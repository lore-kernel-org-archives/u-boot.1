Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66D6E6F076
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 09:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2F583C28;
	Tue, 23 Dec 2025 10:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eC7Lba1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7079A83EE2; Tue, 23 Dec 2025 10:05:34 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23E183B95
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 10:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 204554401E;
 Tue, 23 Dec 2025 09:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2FFC113D0;
 Tue, 23 Dec 2025 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766480730;
 bh=3WFYJo39UpNwdXzTOYkLBVyAS+pV6MFfCjYUTsFxT/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eC7Lba1dIgdfU7EEKsYaJQMbWekid9lPcmr9hC8UII8Yz6o8o5dJXHDBWNQFnYzai
 cMSzxAy+TsRXD8CZWAI8sokcp5hsgfPhhXWd6Xa9sxhMNWnyFncxQuUh0OhT/X/5pv
 OwWT2GK46P4rQ0thdoMfAmJlwSpJBPa9HYwBKnky1cFh77JbbvdQQrTnUd0A8Rsb0q
 DTDPM/va2N9LbtPI1nCbJQeA7Sp6Ju0I9UzqeaGUg5Zu5ip1y7W9jZQ3Vt4fAW/696
 N25YsxH/209SBu5nDfVlB/yI6SZdVT7pP3/B+3+MJAC43V1g27lh5hFmK/BXLo40MY
 d8GUj6KvjLFPg==
Date: Tue, 23 Dec 2025 14:35:14 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com,
 peng.fan@nxp.com, alif.zakuan.yuslaimi@altera.com,
 kory.maincent@bootlin.com, sjg@chromium.org,
 jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 2/7] drivers: usb: dwc3: Add delay after core soft reset
Message-ID: <aUpbSgCIdKgtoSyT@sumit-xelite>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-3-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124155503.2839766-3-balaji.selvanathan@oss.qualcomm.com>
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

On Mon, Nov 24, 2025 at 09:24:58PM +0530, Balaji Selvanathan wrote:
> Add a 100 ms delay after clearing the core soft reset bit to ensure
> the DWC3 controller has sufficient time to complete its reset
> sequence before subsequent register accesses.
> 
> Without this delay, USB initialization can fail on some Qualcomm
> platforms, particularly when using super-speed capable PHYs like
> the QMP USB3-DP Combo PHY on SC7280/QCM6490.
> 
> The change is taken from following upstream Linux implementation:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/core.c?id=f88359e1588b85cf0e8209ab7d6620085f3441d9

If I understand correctly the kernel change here especially following
comment:

	/*
	 * Wait for internal clocks to synchronized. DWC_usb31 and
	 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
	 * keep it consistent across different IPs, let's wait up to
	 * 100ms before clearing GCTL.CORESOFTRESET.
	 */

the delay is required before clearing GCTL.CORESOFTRESET and not after
which your change seems to do. Also, here we aren't doing any role
switch too, right?

-Sumit

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v2:
> - Gave correct commit id for linux implementation
> ---
>  drivers/usb/dwc3/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 847fa1f82c3..ff0bca0dd8e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>  	reg &= ~DWC3_GCTL_CORESOFTRESET;
>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>  
> +	mdelay(100);
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
