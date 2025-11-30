Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F2D111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 11:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A459D83106;
	Sun, 30 Nov 2025 12:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="PWaxuuvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D597B8312A; Sun, 30 Nov 2025 12:01:08 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCECD8309A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 12:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1764500407;
 bh=CulaeJBnCudLtBTaYipcMcPMoytrQGg8YaHTj5jW+8k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PWaxuuvV0l1kI0NN/GBQ/3vV5/1TRNpIKyB/SN/MSPP8Z0DvGnkmnK/A5Zj+chRrb
 H68Z0RHfauAvFEf+iHF7T9j608IfVSdW00BpzI3lDRC/g/OVhPae5l3Z2gZlZSK4qm
 37dr2Tu8Ps+tp4NG0yjXuzAJ7/pBtQcUNk1QgDKVyZioXXgqO8MiqoFY9J1aC5Ht+N
 P5Ws1rPgp7YDI0sKdjWX/DqEeLz+K8JggGQ0KCuWR+Re8ukxjAPf8vDosi0mwpGpbI
 /B0XVLoeQ3cvVvbOvIVIIyIpOpQBFwwvFvSc+cBiCKr1WXo1JkmTZ2pazrWiJ5uSeB
 HiJtLk2bDnQ4A==
Received: from [192.168.2.54] (unknown [98.97.63.250])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0D2CEB221334;
 Sun, 30 Nov 2025 12:00:05 +0100 (CET)
Message-ID: <d9088cf7-07c0-4458-852d-e083fa0aeb8f@freeshell.de>
Date: Sun, 30 Nov 2025 03:00:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: starfive: enable wget https
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251112005451.41285-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251112005451.41285-1-e@freeshell.de>
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

Hi to all,

On 11/11/25 16:54, E Shattow wrote:
> Enable WGET_HTTPS (no CA verification; also enables dependency MBEDTLS_LIB)
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  configs/starfive_visionfive2_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index fa83ecfa10f..a754134a313 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -76,6 +76,7 @@ CONFIG_CMD_PCI=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_WDT=y
>  CONFIG_CMD_WGET=y
> +CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_OF_BOARD=y
>  CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
> @@ -154,3 +155,4 @@ CONFIG_USB_GADGET=y
>  # CONFIG_WATCHDOG_AUTOSTART is not set
>  CONFIG_WDT=y
>  CONFIG_WDT_STARFIVE=y
> +CONFIG_MBEDTLS_LIB=y
> 
> base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6

If there are no objections then can this then be applied for the 2026.01
release?

-E
