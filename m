Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8588D5B16C
	for <u-boot@archiver.kernel.org>; Sun, 14 Dec 2025 21:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E2D80050;
	Sun, 14 Dec 2025 22:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="TqkWcd1k";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="Pgkq77rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DD98006D; Sun, 14 Dec 2025 22:59:15 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D53378003E
 for <u-boot@lists.denx.de>; Sun, 14 Dec 2025 22:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-k346.prod.antispam.mailspamprotection.com;
 s=arckey; t=1765749550; 
 b=aqA2Wode2jE8pX7Hrvsq5tUQwjiZbjFjZ30cH15MBJ8pwqpRX5Elx5vz0QX0fe0yIioH+4dEw+
 kzyqwJLnmaxplDRs+ei2E+/t6j5hoGdcf6fp4pJxJ70gM9cazgHWTxWBCmvODLSptFb0/yJpan
 ksWTdOzgZhqRV+gAiO9kMd+fwGPch07pxfIzVwXUQQqhTw7JkFOABfPn/s2cNaiZmwdFHLIXJJ
 0JwJQvuwIYQwk4k5iPnY6E7jjs/iESfvswnHrbV7g11oaYR2upAfCvEayvs3wyyH+H2gXtuISK
 DBQJC+RNxEoWdJLDvzFJuoXTtzzHBuvOpMfglx5IP8f9sQ==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-k346.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-k346.prod.antispam.mailspamprotection.com;
 s=arckey; t=1765749550; 
 bh=9q786pM9qPqppr7dog+apYFCYSngdaKtcM+7TOzxgWM=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=dP3Dy6TLfpA03HotF3lmq/DtVDPoAWxZC4QeGEuzkvFkQ4zZChc6cOEGhNs4GyiyLB5HekUph0
 QhieGYIkp6zCPljTmyJbRDX7JOGRTed1XZtMPZLSEv6Iw+5s+mFXjlKTFSZtdmrR2a4m/uCJcw
 DCoAaabXOIuIHzdfQvU/VB0clRWwd6icTVP1FOYaGkkR0jKJxzIzR490muSaSD0KuQSMshj43k
 YdcGz6PRGtbpdt3ii+vVV+MmH1zA7FDt2drwxnuiOHzzylq8ABNCNis7xyXfg3qNQ7/+G5S+gv
 febTtyS48mMagcIbJK7FxYPuM100ty+TTFcXYtkza+LouQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=Kp/T3RpcWyopc416eJI+MDnuuLxV65hG1WXDuNr617k=; b=TqkWcd1kXjqd51D2YlCrIx8fPz
 QiYvASAXsjDMfyRP9w3dFcC6lFjquiViOxto9JxKUYNRpHlNh4jUl0N6EIl4qkcO8eC+BgmXES0ob
 pvI6K3do2zHD0JZcz5j6VmzWpQLwbg1GhocGky5Hm8mFnX9QMYzC9aSBvmpy3ns6I7Sw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-k346.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vUu7O-00000002bMV-47xk
 for u-boot@lists.denx.de; Sun, 14 Dec 2025 21:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=Kp/T3RpcWyopc416eJI+MDnuuLxV65hG1WXDuNr617k=; b=Pgkq77rwaR85llxUJYC0s+umNv
 m4+upMIQtmRdCJRTwItXGssozBAEMMzG+e8Vdz/1XCQm1C3KRZ1+UlPj1M0F0KP597zHeV9A+rkva
 tYRh9B0Waum6SAC4Oo2Phd14Ok1gvONlfOuPV+VCgYR8Nb35sgegPSV/ME+BMgPRSzi0=;
Received: from [79.34.194.176] (port=61045 helo=bywater)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vUu7J-000000009uw-0jdJ; Sun, 14 Dec 2025 21:59:01 +0000
Date: Sun, 14 Dec 2025 22:58:59 +0100
From: Francesco Valla <francesco@valla.it>
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Jacky Bai <ping.bai@nxp.com>, Joseph Guo <qijian.guo@oss.nxp.com>,
 Justin Jiang <justin.jiang@nxp.com>
Subject: Re: [PATCH v4 0/2] Add FRDM-IMX91 initial support
Message-ID: <aT8zI141dpu1c48e@bywater>
References: <20251212-imx91_frdm-v4-0-66bf00d8e721@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212-imx91_frdm-v4-0-66bf00d8e721@nxp.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c59b7bc1781c5e79675db7cfce37af2a
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vUu7O-00000002bMV-47xk-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-k346.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

On Fri, Dec 12, 2025 at 03:20:19PM +0900, Joseph Guo wrote:
> This series add initial support for the FRDM i.MX91 11x11 development
> board in U-Boot:
> https://www.nxp.com/design/design-center/development-boards-and-designs/FRDM-IMX91
> 
> Include:
> - Device tree for the board.
> - Defconfig and Kconfig for the board.
> - Header file defining memory layout and hadware addresses.
> 
> The board devicetree already attempted to upstream, but not been accepted yet:
> https://lore.kernel.org/all/20251114-imx91_frdm-v1-0-e5763bdf9336@nxp.com/
> 
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
> Changes in v4:
> - add explanation for clear_pd_alert
> - add loadbootscript and bootscript in .env
> - Link to v3: https://lore.kernel.org/r/20251209-imx91_frdm-v3-0-02303eb0c1c3@nxp.com
> 
> Changes in v3:
> - drop usdhc2 in uboot dts - drop usdhc2 in uboot dts
> - add workaround to clear ptn5110 alert in board init
> - /s/EFI_HAVE_CAPSULE_SUPPORT/ENV_IS_IN_MMC
> - move 'soc' node into /{}
> - move reset property into kernel dts
> - drop m-core related env
> - Link to v2: https://lore.kernel.org/r/20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com
> 
> Changes in v2:
> - add upstream link
> - rename 'vrpi' to 'vexp' to keep align with upstream dts
> - move bootph- property from u-boot.dtsi to dts   
> - correct commit message 'EVK' to 'FRDM'
> - use #include in ecc config file to avoid duplication
> - add ecc description in README
> - drop extraneous includes
> - rename 'imx91_frdm.rst' to 'imx91_11x11_frdm.rst'
> - drop IMX91_FRDM_LPDDR4 symbol
> - Link to v1: https://lore.kernel.org/r/20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com
> 
> ---
> Joseph Guo (2):
>       arm64: dts: add NXP FRDM-IMX91 device tree
>       imx: Support i.MX91 11x11 FRDM board
> 
>  arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |   34 +
>  arch/arm/dts/imx91-11x11-frdm.dts                  |  773 ++++++++
>  arch/arm/mach-imx/imx9/Kconfig                     |    9 +
>  board/freescale/imx91_frdm/Kconfig                 |   12 +
>  board/freescale/imx91_frdm/MAINTAINERS             |    7 +
>  board/freescale/imx91_frdm/Makefile                |   16 +
>  board/freescale/imx91_frdm/imx91_frdm.c            |   84 +
>  board/freescale/imx91_frdm/imx91_frdm.env          |   89 +
>  .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
>  board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
>  board/freescale/imx91_frdm/spl.c                   |  193 ++
>  configs/imx91_11x11_frdm_defconfig                 |  138 ++
>  configs/imx91_11x11_frdm_inline_ecc_defconfig      |    3 +
>  doc/board/nxp/imx91_11x11_frdm.rst                 |  100 +
>  doc/board/nxp/index.rst                            |    1 +
>  include/configs/imx91_frdm.h                       |   25 +
>  19 files changed, 9480 insertions(+)
> ---
> base-commit: e199db57c00ba2c2aba81069800126b6543a644c
> change-id: 20251117-imx91_frdm-7a2db95f279d
> 
> Best regards,
> -- 
> Joseph Guo <qijian.guo@nxp.com>
>

Tested-by: Francesco Valla <francesco@valla.it>

Regards,
Francesco

