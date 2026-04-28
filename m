Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0AFFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60EA846BD;
	Tue, 28 Apr 2026 09:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sp5MNYhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673E0842C7; Tue, 28 Apr 2026 09:22:28 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4B184255
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 65FEE1A3469;
 Tue, 28 Apr 2026 07:22:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 355F1601D0;
 Tue, 28 Apr 2026 07:22:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2A5D107283B4; 
 Tue, 28 Apr 2026 09:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777360944; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=EbBi4ATMabhJyFOU2lOLYX4/UxMX+jTOXzlIfq1uHW4=;
 b=sp5MNYhKzrIg6GK4/qpPhFod9t/d8iF2VJgiLv7WDYqV2rjieZTLR/Gc4SsPY95B/RvC9w
 NDNYR7OhuSBmNddWjY55mmDMQo/tIo2QdLzjni8imDdemYl64wnA597lDVEw6IL19bzwIl
 90DlrGgPBh7e1fdAeE3qNzW+MiFUgDXAbW5ZKZMIOcQuMDo5w0EyY/KoT9PttqC4aVxmGi
 urhYqZ+aRz/jhGMVHfBvpzJTuOf5h8LuIFgrrvzoHvt81RXfvR7pMgqPN8xSbz4lQDx2nX
 rrUlqL0nO0y1eZlga7tk2lMSeU14yf0+gcjtRvGRFtuJDCu9ZOtb2Ws1+s0iCw==
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
Subject: Re: [PATCH 4/6] mtd: spi-nor-ids: Add 4K page support for Macronix
 MX25L25635E
In-Reply-To: <5fd1dfc2637fdc2f33b8ba68b46a35f8f320a6d1.1777345877.git.weijie.gao@mediatek.com>
 (Weijie Gao's message of "Tue, 28 Apr 2026 11:32:03 +0800")
References: <cover.1777345877.git.weijie.gao@mediatek.com>
 <5fd1dfc2637fdc2f33b8ba68b46a35f8f320a6d1.1777345877.git.weijie.gao@mediatek.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 28 Apr 2026 09:22:18 +0200
Message-ID: <87cxzjft1x.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

On 28/04/2026 at 11:32:03 +08, Weijie Gao <weijie.gao@mediatek.com> wrote:

> The datasheet can be found here:
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/8592/MX25L25635E,%203=
V,%20256Mb,%20v1.3.pdf

You can be a little more verbose here, about the why we need this?

> @@ -330,7 +330,7 @@ const struct flash_info spi_nor_ids[] =3D {
>  	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
>  	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
> -	{ INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SPI_NOR_DUAL_READ | =
SPI_NOR_QUAD_READ) },
> +	{ INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

Is this something you really need to flag? Isn't it already provided by
the SFDP tables?

>  	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_4B=
_OPCODES) },
>  	{ INFO("mx25v8035f",  0xc22314, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DU=
AL_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("mx25r1635f",  0xc22815, 0, 64 * 1024,  32, SECT_4K | SPI_NOR_DU=
AL_READ | SPI_NOR_QUAD_READ) },

Thanks,
Miqu=C3=A8l
