Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07656C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64538803B5;
	Sun,  9 Feb 2025 21:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A90807D7; Sun,  9 Feb 2025 21:43:13 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7002180141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.27.21]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E4C31B2C1924;
 Sun,  9 Feb 2025 21:43:07 +0100 (CET)
Message-ID: <2d6e34fa-f45e-4edd-8b6d-4911400b6b77@freeshell.de>
Date: Sun, 9 Feb 2025 12:43:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: starfive: default to
 jh7110-starfive-visionfive-2-v1.3b
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, H Bell
 <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
 <20250209152329.187194-5-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250209152329.187194-5-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


On 2/9/25 07:23, Heinrich Schuchardt wrote:
> We use starfive_visionfive2_defconfig to generate a FIT image supporting
> all JH7110 boards in U-Boot. Make jh7110-starfive-visionfive-2-v1.3b the
> default configuration that is used if no other configuration fits.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index c3f2142ae1b..ed077886436 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -78,7 +78,7 @@ CONFIG_CMD_WDT=y
>  CONFIG_CMD_TFTPPUT=y
>  CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_OF_BOARD=y
> -CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
> +CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a"
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y

Please keep CONFIG_OF_LIST sorted. Fall-through case should instead be a
failure to boot, or at least a warning to the user that something
unexpected is happening and inform that an assumption of a generic set
of parameters or arbitrary board Fdt is being substituted. Implicit
fall-through selection that un-orders the list is NAK. -E
