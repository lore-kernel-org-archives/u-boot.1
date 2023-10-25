Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB7CC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416EF87AA5;
	Wed, 25 Oct 2023 15:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B2658700F; Wed, 25 Oct 2023 15:25:32 +0200 (CEST)
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
 [80.67.18.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDB287AAA
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay05.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.1)
 (envelope-from <LW@KARO-electronics.de>) id 1qvdt3-0002Jx-1G;
 Wed, 25 Oct 2023 15:25:29 +0200
Date: Wed, 25 Oct 2023 15:25:26 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Message-ID: <20231025152526.4c3c18c2@karo-electronics.de>
In-Reply-To: <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231024231543.GN496310@bill-the-cat>
 <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On Wed, 25 Oct 2023 07:59:05 +0000 Michel Alex wrote:
> Calculate the maximum length of the buffer when writing
> across the page boundary. If the buffer length (len)
> exceeds the page boundary (pagesize), split it. Use this
> length instead of comparing the length with the pagesize,
> because if the write start address (offset) is not at the
> beginning of a page and the page_offset + len is greater
> than the page boundary (pagesize), the write operation
> would overflow the current page and the behaviour can be
> undefined (e.g. at24).
>=20
> Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
> ---
> Changes for v2:
> - fixed deviations from checkpatch.pl
> - improved commit message
> ---
>  drivers/misc/i2c_eeprom.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
> index bdd7e018cc..0eecbd07ba 100644
> --- a/drivers/misc/i2c_eeprom.c
> +++ b/drivers/misc/i2c_eeprom.c
> @@ -60,6 +60,17 @@ static int i2c_eeprom_std_read(struct udevice *dev, in=
t offset, uint8_t *buf,
>         return dm_i2c_read(dev, offset, buf, size);
>  }
>=20
> +static int i2c_eeprom_len(unsigned int offset, unsigned int len, unsigne=
d int pagesize)
> +{
> +       int page_offset =3D ((offset) & (pagesize - 1));
          int page_offset =3D offset & (pagesize - 1);
2 many ()


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
