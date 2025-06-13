Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6824C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 09:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3495E82C30;
	Fri, 13 Jun 2025 11:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RJPW51sD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7234C82C2F; Fri, 13 Jun 2025 11:16:03 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8FE82C44
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F1464368E;
 Fri, 13 Jun 2025 09:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA078C4CEE3;
 Fri, 13 Jun 2025 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749806159;
 bh=oFOcFlD5h+ck2u4Cku5w5qH9vZWdjuxAbA9MQneseQM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RJPW51sD4BS19Zbe2HLxiNZgm+QYFpw5ZJ5oz+BrsfH1iP/Oj+3MORNne9G0IdpD9
 m7JYqDD5BN/Vz2LnBf1K6cNTC/uf1pAW6SAS/C0fXFzUJUES59s8GthV7SOIl2UNSQ
 r0DocTfnX8g556fItFngcSZXtaKweSXeBliETNDKEjPkbfTEXl5Sl4kNo6scLEv5qx
 ZjDO2ArmSyPSonNM+oHXvuYkztA7K++36u5/fgby3fHhAd7U5vMgeg04OXmbsv5dbG
 bBcjd6aRVJFmEruAecVJgd/OFJi/56qcC5s0QZ4ZOuH91oNbTrYWabOMYzueMFeEZ0
 xA+SXZ37q6kwQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>, Jean-Jacques Hiblot
 <jjhiblot@ti.com>, u-boot@lists.denx.de
Cc: Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] usb: gadget: musb: Fix duplicate ops assignment in
 ti_musb_peripheral
In-Reply-To: <20250611171031.840277-1-kory.maincent@bootlin.com>
References: <20250611171031.840277-1-kory.maincent@bootlin.com>
Date: Fri, 13 Jun 2025 11:15:56 +0200
Message-ID: <87wm9g3stv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Kory,

Thank you for the patch.

On Wed, Jun 11, 2025 at 19:10, Kory Maincent <kory.maincent@bootlin.com> wrote:

> Remove duplicate .ops assignment that was overriding the correct
> ti_musb_gadget_ops with musb_usb_ops (host ops) in the ti_musb_peripheral
> driver. This was causing U-Boot crashes when trying to call the
> handle_interrupts operation since the wrong ops structure was being used.
>
> Fixes: 7d98dbcc3dc ("usb: musb-new: Add support for DM_USB")

I think this should also be flagged as:

Fixes: 281eaf1ed83a ("usb: gadget: musb: Convert interrupt handling to usb_gadget_generic_ops")

I can do that while applying.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/usb/musb-new/ti-musb.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
> index ec1baa9337d..967d0953875 100644
> --- a/drivers/usb/musb-new/ti-musb.c
> +++ b/drivers/usb/musb-new/ti-musb.c
> @@ -282,7 +282,6 @@ U_BOOT_DRIVER(ti_musb_peripheral) = {
>  	.ops	= &ti_musb_gadget_ops,
>  	.probe = ti_musb_peripheral_probe,
>  	.remove = ti_musb_peripheral_remove,
> -	.ops	= &musb_usb_ops,
>  	.plat_auto	= sizeof(struct ti_musb_plat),
>  	.priv_auto	= sizeof(struct ti_musb_peripheral),
>  	.flags = DM_FLAG_PRE_RELOC,
> -- 
> 2.43.0
