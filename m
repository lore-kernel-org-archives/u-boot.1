Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEFBFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8509483FB5;
	Tue, 28 Apr 2026 14:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ROE56rGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2EE84698; Tue, 28 Apr 2026 09:41:16 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA60B8464E
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 553AE4E42B5F;
 Tue, 28 Apr 2026 07:41:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1EC48601D0;
 Tue, 28 Apr 2026 07:41:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 054A810728430; 
 Tue, 28 Apr 2026 09:41:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777362072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=tRzTEotDpomL/4AWS5Ra9jHN1ITyC7BIQJMTE8kNMmk=;
 b=ROE56rGtZfKtMsnIWUF8Djg1o4oFpxMCj4EB3SWMlghvvVn113SsqP+Qa617LEqWTuNkg1
 C7qBm0NKl5FdiBpXpw7RpjEL+isOHX5AIOORH4K/2qpIba7iwOg/KojFM7r6Cqr5cih1rB
 rLctx77fGr5PCcGLtgd+IXFoi00NWL7HzFTeV1EnnQz2xpBB/7RrTDRy8R/2gopf86AKMk
 F1TK0puJY4riagCFEqmVBAttlBI1EcWEXvrBK0bw2KbVzspHl5a4dxFMWRBQLtdfBZ3ZKV
 U75ocbT2penfvqV6dQArD+n53YykvAzmOL8nliNgKhvZXh1xZ99KfutyviAZPg==
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
Subject: Re: [PATCH 5/6] mtd: spi-nor-ids: Fix Winbond W25Q256JW and remove
 W25Q256FW
In-Reply-To: <5f9c98f56655634a64be9fc1059173a8db609055.1777345877.git.weijie.gao@mediatek.com>
 (Weijie Gao's message of "Tue, 28 Apr 2026 11:32:11 +0800")
References: <cover.1777345877.git.weijie.gao@mediatek.com>
 <5f9c98f56655634a64be9fc1059173a8db609055.1777345877.git.weijie.gao@mediatek.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Apr 2026 09:41:07 +0200
Message-ID: <877bprfs6k.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On 28/04/2026 at 11:32:11 +08, Weijie Gao <weijie.gao@mediatek.com> wrote:

> There's no part named W25Q256FW, only W25Q256JW (Non-DTR version) exists
> with ID ef6019.
>
> The datasheet can be found here:
> https://www.winbond.com/resource-files/W25Q256JW%20SPI%20RevJ%2003102021%20Plus.pdf
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index a157e370b89..492411a90f5 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -610,12 +610,7 @@ const struct flash_info spi_nor_ids[] = {
>  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  	},
>  	{
> -		INFO("w25q256fw", 0xef6019, 0, 64 * 1024, 512,
> -			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> -	},
> -	{
> -		INFO("w25q256jw", 0xef7019, 0, 64 * 1024, 512,

FYI, this ID is W25Q256JV-M.

> +		INFO("w25q256jw", 0xef6019, 0, 64 * 1024, 512,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  	},

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
