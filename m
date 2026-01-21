Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C10C44501
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 09:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6803F8341A;
	Wed, 21 Jan 2026 10:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D+Orlmxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A89839DF; Wed, 21 Jan 2026 10:17:46 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8BE682A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 10:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dwz9y6nn4z9sSf;
 Wed, 21 Jan 2026 10:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768987063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKgYwrkRViWOoKx0sKq+vDfU+h6AZzhSyj3NiHiA/Qg=;
 b=D+OrlmxrbxEtivfamQRKVNSNKWWyJfyrupA2Ae55puyhfcESsoFh8PemN1qQMrTOq9HAL0
 JTAbhqSyI8LHsTR7cQcRSSAQbHsFj/L/DUC+gpMSCLC0Fu7tCF4Fj1RdEaxQY5tpLwmvMF
 ELZz2p3SWSkn94tW8MEnaQ+nMQEvu9nkzlHyjqbCU+cZqStDBE9RfC6LisL+WaQLKvLmvW
 c4LN/Lis/psQVZUx98IoS7xo1QfTU2wDkt4dKVYWtJOLGmftt1D+KQNAlnwcC09hFOqTz7
 VV4AWay7UuwoDTSBBAc7swv/H6mocGt75jrKeEqPbvmiYF8uo783yU1NiZl23w==
Message-ID: <cf1a8fb2-107b-4539-a623-d376217d67b9@mailbox.org>
Date: Wed, 21 Jan 2026 10:17:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: qcom: stop watchdog by default
To: Casey Connolly <casey.connolly@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shmuel Leib Melamud <smelamud@redhat.com>, Sumit Garg
 <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260121003659.69305-1-casey.connolly@linaro.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260121003659.69305-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fj4zbj6rrg31hsecs1qkkwtk1r5s91pz
X-MBO-RS-ID: 9dd748fd51ed4bb9530
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

On 1/21/26 01:36, Casey Connolly wrote:
> Prevent the Qualcomm watchdog from autostarting and ensure it's stopped
> when the driver probed. In some cases the watchdog is left running by
> a previous bootloader stage. Disable autostart so it isn't left running
> when we boot into the OS, this behaviour can be changed by enabling
> autostart in the board defconfig.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/Kconfig    | 1 +
>   drivers/watchdog/qcom-wdt.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 35ae7d106b1a..416d29d256a2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -15,8 +15,9 @@ config WATCHDOG_AUTOSTART
>   	bool "Automatically start watchdog timer"
>   	depends on WDT
>   	default n if ARCH_SUNXI
>   	default n if ARCH_STM32MP
> +	default n if ARCH_SNAPDRAGON
>   	default y
>   	help
>   	  Automatically start watchdog timer and start servicing it during
>   	  init phase. Enabled by default. Disable this option if you want
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index e4ebb1f31d4b..a8d7e7a79508 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -128,9 +128,9 @@ static int qcom_wdt_probe(struct udevice *dev)
>   		return rate < 0 ? (int)rate : -EINVAL;
>   
>   	wdt->clk_rate = (ulong)rate;
>   
> -	return 0;
> +	return qcom_wdt_stop(dev);
>   }
>   
>   static const struct wdt_ops qcom_wdt_ops = {
>   	.start = qcom_wdt_start,

