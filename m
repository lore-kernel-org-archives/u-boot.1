Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F037C44502
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 09:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0A38341A;
	Wed, 21 Jan 2026 10:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SjVUbDnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9AF18397D; Wed, 21 Jan 2026 10:04:01 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FF982A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DFFE760007;
 Wed, 21 Jan 2026 09:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A807C16AAE;
 Wed, 21 Jan 2026 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768986237;
 bh=xYWfNPRabz2ja3BlNRqMsdn0QEiFrp2Ad9nk0UBmZN4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SjVUbDnrFeD4prWyH2yzaH8Y5m9anGHmnEm3O8vTYKTHHCpbV8/At4Qgk02DnUoG0
 ueVWZLSpT6yvx5n2i7xSgWd0NeUednOt61qDoRd0mz0uBxLhOSGYbo3/N7u59RzULk
 7af3U7Mag5xnkuTbWHMG2jbawRWU/vTxr6d2KolYTMbtWCy/mV16agAh2bKUOBBQAE
 GJop8Hgg1PfbfSilroF+N17Fv30Vcl7maUo91yZSITIcdr61zZhmVvNpDmffPwNDPA
 GANQwrl4tm0CaSY8Oj5RD1KpYPj4n8/7Jxp1fBpWDN0FIiQZan8wQhCuomY7jgTijQ
 6VgToYV3Ppv3w==
Date: Wed, 21 Jan 2026 14:33:47 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH] watchdog: qcom: stop watchdog by default
Message-ID: <aXCWc1OtQZEQMDlI@sumit-xelite>
References: <20260121003659.69305-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121003659.69305-1-casey.connolly@linaro.org>
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

On Wed, Jan 21, 2026 at 01:36:51AM +0100, Casey Connolly wrote:
> Prevent the Qualcomm watchdog from autostarting and ensure it's stopped
> when the driver probed. In some cases the watchdog is left running by
> a previous bootloader stage. Disable autostart so it isn't left running
> when we boot into the OS, this behaviour can be changed by enabling
> autostart in the board defconfig.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/watchdog/Kconfig    | 1 +
>  drivers/watchdog/qcom-wdt.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

Sounds like a reasonable default option, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 35ae7d106b1a..416d29d256a2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -15,8 +15,9 @@ config WATCHDOG_AUTOSTART
>  	bool "Automatically start watchdog timer"
>  	depends on WDT
>  	default n if ARCH_SUNXI
>  	default n if ARCH_STM32MP
> +	default n if ARCH_SNAPDRAGON
>  	default y
>  	help
>  	  Automatically start watchdog timer and start servicing it during
>  	  init phase. Enabled by default. Disable this option if you want
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index e4ebb1f31d4b..a8d7e7a79508 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -128,9 +128,9 @@ static int qcom_wdt_probe(struct udevice *dev)
>  		return rate < 0 ? (int)rate : -EINVAL;
>  
>  	wdt->clk_rate = (ulong)rate;
>  
> -	return 0;
> +	return qcom_wdt_stop(dev);
>  }
>  
>  static const struct wdt_ops qcom_wdt_ops = {
>  	.start = qcom_wdt_start,
> -- 
> 2.52.0
> 
