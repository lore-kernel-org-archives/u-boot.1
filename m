Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA111FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0CE842A2;
	Tue, 28 Apr 2026 14:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="plA3WlX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C62845D8; Tue, 28 Apr 2026 09:45:07 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74609845C8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 84414C5CD52;
 Tue, 28 Apr 2026 07:45:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F0786601D0;
 Tue, 28 Apr 2026 07:45:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B8964107283D5; 
 Tue, 28 Apr 2026 09:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777362301; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XJEtTCY1YCjP23ZOwfKP35wiY1THtPC7MXERVGWroHE=;
 b=plA3WlX03MOVE4lJ+rx5mYLgJLxFGi3p8KrinEpB/Iom79KGk4sK1fQ764yfY884uK0uSV
 6QnnddpPzFVoupssxOwKW5OGyFOpqQyRNF7hbffqW+VXlqAMqxyLsNkHc4y8RoYVGWEZGg
 ERogwrZyKQSTIbGJTKqlb1b+JSJewpFGVddXqCOfmuGuEfH0liDuLla+sapSpsxjjUDuVi
 riwc9A9rWDU9ZU/SovIX5P037yQTRmWtyyvAp3Gg7Jby2lkvraPKXUtPsEfu+gRJTOER2F
 ZpYRKk3P3xC61uoRXBT1h07e3By+C2HlXsmr5hyyIJZC7TN/m8LTQJTHyECB3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>,  GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>,  Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>,  Takahiro Kuwano
 <takahiro.kuwano@infineon.com>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Jeffrey Yu <jeyu@issi.com>,  Christoph Reiter
 <christoph.reiter@evk.biz>,  Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>,  Shiji Yang <yangshiji66@outlook.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@at.abb.com>,  Vaishnav
 Achath <vaishnav.a@ti.com>,  Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH 6/6] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV/W25Q512JV
In-Reply-To: <a953087c1d0ff8429d64aa014ddb5612d2799b50.1777345877.git.weijie.gao@mediatek.com>
 (Weijie Gao's message of "Tue, 28 Apr 2026 11:32:13 +0800")
References: <cover.1777345877.git.weijie.gao@mediatek.com>
 <a953087c1d0ff8429d64aa014ddb5612d2799b50.1777345877.git.weijie.gao@mediatek.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Apr 2026 09:45:00 +0200
Message-ID: <871pfzfs03.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:41:00 +0200
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

On 28/04/2026 at 11:32:13 +08, Weijie Gao <weijie.gao@mediatek.com> wrote:

> Datasheets can be found here:
> https://www.winbond.com/resource-files/W25Q256JV%20DTR%20RevK%2010202025%=
20Plus.pdf
> https://www.winbond.com/resource-files/W25Q512JV%20DTR%20RevD%2006292020%=
20133.pdf
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 492411a90f5..dc62a0e034a 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -609,11 +609,21 @@ const struct flash_info spi_nor_ids[] =3D {
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  	},
> +	{
> +		INFO("w25q256jv", 0xef7019, 0, 64 * 1024, 512,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +	},
>  	{
>  		INFO("w25q256jw", 0xef6019, 0, 64 * 1024, 512,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  	},
> +	{
> +		INFO("w25q512jv", 0xef7020, 0, 64 * 1024, 1024,

This is JV-M (here and above).

These chips also happen to conflict with W25QxxRV-M chips. Is this
support for these new chips that you are targeting?

> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +	},
>  	{
>  		INFO("w25q512nwq", 0xef6020, 0, 64 * 1024, 1024,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |

I would rather group them by family (ef60xx then ef70xx).

Thanks,
Miqu=C3=A8l
