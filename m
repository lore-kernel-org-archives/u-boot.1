Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65011C61DB4
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 09:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77BFE6067D;
	Tue, 25 Aug 2026 09:48:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ho9hIEIQR76; Tue, 25 Aug 2026 09:48:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787651304;
	bh=6QC2gh1QFPWjESEEe2yhE1Z0P9ONbf3I61Y0B/hOVD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0R1SUjn3muOHv1doxx78Vw95i99wxpNXxp19GSpf+FHBDP0pG5lqE7Qh3oUT53oHI
	 mi02VyAd4P8Yvj7ITpDsoc0MeITmsnlxiyZ2tewf4RWNJ40TQIWm18aQrBsGtkyD4Q
	 Y+fC8xZFCxv6/FdEKhk8gOOa7oEtU/QUu5YFWrkKbw6t5PMTNCwwAusUKabQOlLs8H
	 +x+V+oGtY8XGvDl3vnPHgjGgKUKawRPoTPCjyuNnpF6H8aAm/lZZUixtURNfc2zKJe
	 xWErg2izmLJtrkgyxcByHofv6XT/7uBOZSQB6VOCIa7zCSIr0wQMFu/Y3F4mIcR/ik
	 sDdVVuOKo2NLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDB1560619;
	Tue, 25 Aug 2026 09:48:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2410A30E0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A89F40064
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KroX8ev7eJWr for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 09:48:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=kJpwfl6C; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=yf/PhQe6
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F40FB400EC
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 09:48:21 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hTjdb3sYLzMlGC;
 Tue, 25 Aug 2026 11:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787651299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QC2gh1QFPWjESEEe2yhE1Z0P9ONbf3I61Y0B/hOVD8=;
 b=kJpwfl6CK3SmH7IQAofv9cNG/BU18BC0WIC9LFuz71T5QXB7dsekK8Y0LhP2IZ9a5mo/+p
 pCM9hgv/+g6RQRQxOy0ZZHdn/+es1A7XKdcFPHK1o1E3Ir6CyjANQscRSdEO8PUaC7Ri3/
 9dnOBi/OcxiCfIZgOVgCvs+nuusCK0i/dFnJn4lO3UMjR4WO+/dgIHttSe2gl0bwz+Zil7
 +jeKC7A0m8p9AaAkojlOGHc1BH/2t5tQuSNkr1XeWfO3p/YI7FHEl699m6+KpoM3Zpr7x8
 5kbhZirlOAEjj5BfKWE3J3XZcGZPOPqfzZ3NNxcEH2U3CVwAI/N5MtI4bwxfHQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="yf/PhQe6";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ab7c860e-2f59-4c60-96dc-0c510a63d64c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787651297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QC2gh1QFPWjESEEe2yhE1Z0P9ONbf3I61Y0B/hOVD8=;
 b=yf/PhQe6JmV75BArJMs5dcgN53niSWJtXUYXetPbrb+/Bbb9m3OQNziXBlYmrity1KhWIZ
 zes7zs5IWm8RiWTsj8Q6MalLuNK09l594sqKGeo8qP3wFuTye5tGw0fukwig/N63qeDnMb
 4omQokR0mpcCrlRUfoh3+GTyBdIdksNuKRqrgfMwPraZvedoue7ksUQUlsBAmsC9v928du
 z2fi/cnm13KdDMB+yPWU3BLBrbCEka4bqMScCBVoYG70PMXMNcPfGhs9FDpW7m6kuimDPT
 fPY62d0sQlo2fwaCwh6UfFurFbXZj1qN1Ve9qwG/9+R3NTAyS2gp44SUFTsV6w==
Date: Tue, 25 Aug 2026 01:33:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/6] usb: dwc3: core: only provide legacy gadget IRQ
 handler when USB_DWC3_GADGET
To: Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.u-boot-project.org, francesco.dolcini@toradex.com,
 trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 alice.guo@nxp.com, antoine.gouby@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-2-eichest@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260824183048.419198-2-eichest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: f5mcfjibfgdz7unr79g4za717bm7jskk
X-MBO-RS-ID: ae206abc19753676917
X-Rspamd-Queue-Id: 4hTjdb3sYLzMlGC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Building a board with USB_DWC3=y (DWC3 used purely as an XHCI host
> controller), USB_DWC3_GADGET unset, and DM_USB_GADGET disabled (e.g.
> to use CONFIG_CI_UDC for a separate ChipIdea gadget/OTG controller)
> fails to link:
> 
> drivers/usb/gadget/ci_udc.o: in function `dm_usb_gadget_handle_interrupts':
> drivers/usb/gadget/ci_udc.c:983: multiple definition of `dm_usb_gadget_handle_interrupts';
> drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.c:1034: first defined here
> drivers/usb/dwc3/core.o: in function `dm_usb_gadget_handle_interrupts':
> drivers/usb/dwc3/core.c:1044: undefined reference to `dwc3_gadget_uboot_handle_interrupt'
> 
> Add "&& CONFIG_IS_ENABLED(USB_DWC3_GADGET)" to the guard so this code
> is only compiled when the DWC3 gadget driver it depends on is actually
> present, matching the Makefile dependency. Boards that combine DWC3
> (host) with a separate legacy gadget driver like CI_UDC, with
> DM_USB_GADGET disabled, now link correctly. Boards that already use
> DWC3 in gadget mode without DM_USB_GADGET are unaffected since
> USB_DWC3_GADGET is set for them.
> 
> Fixes: 4d1589808970 ("usb: udc: dwc3: Fold board dm_usb_gadget_handle_interrupts() into DWC3 gadget")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>   drivers/usb/dwc3/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index be198041f08..9bff5149c5f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1016,7 +1016,7 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
>   MODULE_LICENSE("GPL v2");
>   MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
>   
> -#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET) && CONFIG_IS_ENABLED(USB_DWC3_GADGET)
>   __weak int dwc3_uboot_interrupt_status(struct udevice *dev)
Simply enable DM_USB_GADGET , then the 
drivers/usb/gadget/udc/udc-uclass.c dm_usb_gadget_handle_interrupts() is 
used which correctly invokes the per-controller IRQ handler. DWC3_GADGET 
should likely depend on DM_USB_GADGET.
