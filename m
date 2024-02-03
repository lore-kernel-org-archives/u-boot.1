Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A430C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 13:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB5E8746C;
	Sat,  3 Feb 2024 14:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="oluRxYS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BD6871DF; Sat,  3 Feb 2024 14:19:39 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0718746C
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 14:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1706966377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmxGednC8xocMoaJdeyV494tyg4b7BPn8qJhsi4hpQU=;
 b=oluRxYS04C9IiKFePCb3JC9n0UmJHK+i9wv9K3j6WvEVJX/pYUnERljYuh8anyF/D4QwRO
 AFXSNy8hov+8ycVXbE0P4kHabdLxcOPM9VlGDmhp9jCosPsx8dq29ERryQu/ddreyOxMYP
 ZgefdBIbpWQsJF77shcg4mMSnnQrHH9lOuzqi4LVLRnBjg78DRXWBWdwVqSmr2f5A+0Lc/
 vmtPJ++hzcWPeV3elvXHkLJvT2mtuEUKzAmeBxgg8kuJW6MbjtlUk/LhbRSKBssjNZeUl1
 /InpXzVhmTnV0pyT6WjYR6mD6+Uf7y5mGvgs89sMZgoknQb5rNp6S/PFhDcsTw==
Date: Sat, 03 Feb 2024 14:19:36 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 08/18] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <20240123-jaguar-v1-8-1eec1c34953c@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-8-1eec1c34953c@theobroma-systems.com>
Message-ID: <0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

Please see my comments below.

On 2024-01-23 15:49, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Only setup_iodomain() differs from the original misc_init_r from
> Rockchip mach code, so let's use rockchip_early_misc_init_r instead of
> reimplementing the whole misc_init_r from Rockchip.

Your patches from this series are fine, but the trouble is that
we end up executing rockchip_setup_macaddr() for the devices
that don't use the RK3339's built-in Gigabit Ethernet interface,
which includes the Pinebook Pro and the Pinephone Pro.

We should add more ifdef guards to rockchip_setup_macaddr(),
to prevent the execution of its body for devices such as the
ones listed above, which eliminates the unneeded code from the
resulting U-Boot images, making them a bit smaller, and saves
some CPU cycles and a bit of time on boot.  It also prevents
the unneeded "ethaddr" and "eth1addr" variables from being
added to the environment.

The patch below should do the trick, which also performs a few
small code cleanups for additional file-level consistency:

diff --git a/arch/arm/mach-rockchip/misc.c 
b/arch/arm/mach-rockchip/misc.c
index 7d03f0c2b679..ed5bdab5a648 100644
--- a/arch/arm/mach-rockchip/misc.c
+++ b/arch/arm/mach-rockchip/misc.c
@@ -23,7 +23,8 @@

  int rockchip_setup_macaddr(void)
  {
-#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
+#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
+    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)
  	int ret;
  	const char *cpuid = env_get("cpuid#");
  	u8 hash[SHA256_SUM_LEN];
@@ -64,15 +65,15 @@ int rockchip_cpuid_from_efuse(const u32 
cpuid_offset,
  			      const u32 cpuid_length,
  			      u8 *cpuid)
  {
-#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) || 
IS_ENABLED(CONFIG_ROCKCHIP_OTP)
+#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE) || 
CONFIG_IS_ENABLED(ROCKCHIP_OTP)
  	struct udevice *dev;
  	int ret;

  	/* retrieve the device */
-#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
+#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE)
  	ret = uclass_get_device_by_driver(UCLASS_MISC,
  					  DM_DRIVER_GET(rockchip_efuse), &dev);
-#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
+#elif CONFIG_IS_ENABLED(ROCKCHIP_OTP)
  	ret = uclass_get_device_by_driver(UCLASS_MISC,
  					  DM_DRIVER_GET(rockchip_otp), &dev);
  #endif

> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  board/pine64/rockpro64_rk3399/rockpro64-rk3399.c | 20 
> ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> index d79084614f1..d0a694ead1d 100644
> --- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> +++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> @@ -11,7 +11,6 @@
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/grf_rk3399.h>
>  #include <asm/arch-rockchip/hardware.h>
> -#include <asm/arch-rockchip/misc.h>
> 
>  #define GRF_IO_VSEL_BT565_SHIFT 0
>  #define PMUGRF_CON0_VSEL_SHIFT 8
> @@ -31,26 +30,11 @@ static void setup_iodomain(void)
>  	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>  }
> 
> -int misc_init_r(void)
> +int rockchip_early_misc_init_r(void)
>  {
> -	const u32 cpuid_offset = 0x7;
> -	const u32 cpuid_length = 0x10;
> -	u8 cpuid[cpuid_length];
> -	int ret;
> -
>  	setup_iodomain();
> 
> -	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
> -	if (ret)
> -		return ret;
> -
> -	ret = rockchip_cpuid_set(cpuid, cpuid_length);
> -	if (ret)
> -		return ret;
> -
> -	ret = rockchip_setup_macaddr();
> -
> -	return ret;
> +	return 0;
>  }
> 
>  #endif
