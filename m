Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F21C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 520EA6067A;
	Mon, 27 Jul 2026 09:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQMuPB_RighH; Mon, 27 Jul 2026 09:04:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE16F605DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143096;
	bh=YKQwPV97riWTewORN/dCttrCU0/iV+mTDvy+OrKR0lM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FBouw97hO2NVWULUxh+NuWC1q3TRd1p0gJ1QfQMsvCrUFWuxOiaPOt+CvnLSn7vVK
	 6kzLqF5WVObWonA+8LZEd2TlPqr1dVHsJn2X4L6VfKsHOkC2ganLqhGt6cpaM2l1K7
	 hwBUAi652Tbwk0HxccJeex2mRgO066B0hId8owSgPoqWhuM3pmEVBb+ud5WDraW6G7
	 YP0Gv3zBks03O/upDrNmOPgoCcrDf3oBsy3XbOfgiAYOfttmXF/U1F++Kkue5fiYPa
	 k9aJNZVIwBxLz4dQBIgzYfF6BMKQkJ7Xuh7YIoFwiWK9ZnMDuaTIGlcTmrYnvkM7lH
	 5vQx37aS4a9KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE16F605DE;
	Mon, 27 Jul 2026 09:04:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0BEE42A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2A2880C0D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:04:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPbCr6ebnmBh for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:04:55 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CAC3C80B23
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAC3C80B23
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAC3C80B23
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:04:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0985584659; Mon, 27 Jul 2026 11:04:53 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB96C82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:04:50 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31772601DE;
 Mon, 27 Jul 2026 09:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD8E1F000E9;
 Mon, 27 Jul 2026 09:04:48 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Anshul Dalal <anshuld@ti.com>
Subject: Re: [PATCH v5 17/75] usb: dwc3: import from kernel v4.14
In-Reply-To: <20260716134305.614278-18-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-18-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:04:46 +0200
Message-ID: <87y0ew4xch.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143088;
 bh=YKQwPV97riWTewORN/dCttrCU0/iV+mTDvy+OrKR0lM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=bW4dko7AUw4NeaFEQEY1X3luY132cvIPRwlVRdRvwzQFKms5l4zAj+ATunDOR1WFv
 9s3FqWZZY9RnOCY49JTGXuCnUvOlHAUYqvmLEREcL6tnhJsgulBTnN5qGlJK2eUYCL
 1hdItRp/xtOOZcPuPac7f3MbDhStn5bmRQ/xMIZ5c3BtiQDSvxPhpDPuDieZfuCnK9
 mpkCDuQHJgNOtM6nmdGmwCVPxh9q+zUz9PIfx7AzUO9CXeNwZIzhAi7q80iBBWxRnt
 SSYxbzFrz3CAuM3MLmmXcxPTZouAsyLO5aNAiV1JOZNcpDKxb8qR8fM5PU91Yff/Ws
 3cQ9FOwJn9iaQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=bW4dko7A
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bW4dko7A"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:41, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v4.13 to v4.14.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v4.13..v4.14
> Commits imported:
> b24413180f56 License cleanup: add SPDX GPL-2.0 license identifier to files with no license
> c3cdce45f8d3 usb: dwc3: of-simple: Add compatible for Spreadtrum SC9860 platform
> 551684708356 usb: dwc3: ep0: fix DMA starvation by assigning req->trb on ep0
> e7059ef82a22 usb: dwc3: of-simple: remove include of clk-provider.h
> 95aa932c93d2 usb/dwc3:constify dev_pm_ops
> c14af973ed86 usb: dwc3: keystone: Add PM_RUNTIME Support to DWC3 Keystone USB driver
> 0ae99ecba792 usb: dwc3: omap: fix error return code in dwc3_omap_probe()
> 8bcd9889721f usb: dwc3: pci: constify dev_pm_ops
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Fixes: b1a3ed068869 ("spl: make args file optional in falcon mode")

Why is this fixes tag here? How is a usb DWC3 update fixing falcon mode
for SPL?

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and the
result looks good to me.

> ---
>  drivers/usb/dwc3/ep0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 827e376bfa97..75e6cb044eb2 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -990,6 +990,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>  					 DWC3_TRBCTL_CONTROL_DATA,
>  					 true);
>  
> +		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
> +
>  		/* Now prepare one extra TRB to align transfer size */
>  		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
>  					 maxpacket - rem,
> @@ -1015,6 +1017,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>  					 DWC3_TRBCTL_CONTROL_DATA,
>  					 true);
>  
> +		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
> +
>  		/* Now prepare one extra TRB to align transfer size */
>  		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
>  					 0, DWC3_TRBCTL_CONTROL_DATA,
> @@ -1029,6 +1033,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>  		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
>  				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
>  				false);
> +
> +		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
> +
>  		ret = dwc3_ep0_start_trans(dep);
>  	}
>  
> -- 
> 2.53.0
