Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55228C4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 15:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE3B87C7B;
	Thu,  1 Feb 2024 16:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="txdSVmB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EFE287D11; Thu,  1 Feb 2024 15:54:08 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD9C87D14
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 4F248100011;
 Thu,  1 Feb 2024 17:54:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4F248100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1706799245;
 bh=H1ofN8Zv/hMrKkj3ZXx1f0saJPvyqdzU2+JZoVhtskQ=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=txdSVmB+tuBlw8G8SUgaFkTQDEYXZW8WXinXswbY8FfR6jC7FzAlFohzd63rQzbUb
 zSdGbyMwpv4tOnGIoWHiREYoY7ZjMX+xZkOrgWrLVA/0/leTh8McvYqZnQP53KhyNf
 QLNqqox+mYausT11cJBjMwmeCd6wrBPznvgUa8b4vsGiV9LnERIGx7SRKT5yypJxkS
 5J1bC61j14VSM4liSTB7bSEwBTndqP1YcTmAB22yhyhnOdcR7mk73GquJrkh8AKxm3
 d/meYD5LQCTHC5kgLcCsO2fiVY4fRGbxEYLVK8bX+qgVDEZ6b5xK6nWPsXs3qZx8Vk
 w/8BCQ5f8yANg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  1 Feb 2024 17:54:05 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 17:54:04 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::25de:2e74:8821:eb9a]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::25de:2e74:8821:eb9a%7]) with
 mapi id 15.02.1118.040; Thu, 1 Feb 2024 17:54:04 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
Thread-Topic: [RFC PATCH v2 2/2] board: ad401: example of fastboot oem board
 realization
Thread-Index: AQHaVO/tacIhsq/EBEWrtLsZKJ51orD1UMQAgAAQCoA=
Date: Thu, 1 Feb 2024 14:54:04 +0000
Message-ID: <20240201145359.qov4mqc6njcz7unt@cab-wsm-0029881>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
 <20240201092027.6258-3-avromanov@salutedevices.com>
 <fc0bc1b6-6ae8-4331-a0b2-3ebd2d30699d@moroto.mountain>
In-Reply-To: <fc0bc1b6-6ae8-4331-a0b2-3ebd2d30699d@moroto.mountain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D85A0C49F203044685CA32F21BB1A0D2@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183123 [Feb 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/01 13:26:00 #23335101
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 01 Feb 2024 16:38:08 +0100
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

On Thu, Feb 01, 2024 at 04:56:34PM +0300, Dan Carpenter wrote:
> On Thu, Feb 01, 2024 at 12:20:27PM +0300, Alexey Romanov wrote:
> > +static int fastboot_nand_write_tpl(struct mtd_info *mtd, void *buffer,
> > +				   u32 offset, size_t size, int flags)
> > +{
> > +	int boot_cpy_num =3D meson_bootloader_copy_num(BOOT_TPL);
> > +	u64 size_per_copy =3D meson_bootloader_copy_size(mtd, BOOT_TPL);
> > +	int i;
> > +
> > +	for (i =3D 0; i < boot_cpy_num; i++) {
> > +		size_t retlen, len =3D size;
> > +		int ret;
> > +
> > +		ret =3D nand_write_skip_bad(mtd, offset + (i * size_per_copy),
> > +					  &len, &retlen, offset + size_per_copy,
>                                                          ^^^^^^^^^^^^^^^^=
^^^^^^
> Sorry if I'm missing something obvious, but why is the limit
> "offset + size_per_copy"?  I would have expected it to be just
> "size_per_copy" or maybe some kind of limit minus the offset...

Yeah, this is incorrect. Should be size_per_copy.=20

But this patch is just an example of realization.

>=20
> > +					  buffer, flags);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> regards,
> dan carpenter
>=20

--=20
Thank you,
Alexey=
