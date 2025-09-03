Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A922CCA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 00:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED09883390;
	Wed,  3 Sep 2025 02:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B93A833D0; Wed,  3 Sep 2025 02:15:28 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB7D832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 02:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C8124B22025D;
 Wed,  3 Sep 2025 02:15:23 +0200 (CEST)
Message-ID: <18cfc0c4-e351-409b-b611-aabd4b2ab81e@freeshell.de>
Date: Tue, 2 Sep 2025 17:15:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 08/10] configs: visionfive2: Add VisionFive 2 Lite DT to
 OF_LIST
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-9-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250829060931.79940-9-hal.feng@starfivetech.com>
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


On 8/28/25 23:09, Hal Feng wrote:
> So the VisionFive 2 Lite DT will be built and merged into FIT.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index 544140c03f7..5a0e918c733 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -78,7 +78,7 @@ CONFIG_CMD_WDT=y
>  CONFIG_CMD_WGET=y
>  CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_OF_BOARD=y
> -CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
> +CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110s-starfive-visionfive-2-lite"
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y

Okay. While we are adding a target with a different (yet similar) CPU
JH7110S, I have questions about if we can also make JH7100 a variant
here too. How much difference is allowed for one U-Boot board target?

It would be great to have a single U-Boot target
starfive_jh71xx_defconfig for example. I am aware that mainline Linux
kernel defconfig can boot on JH7100 but some peripheral drivers do not
work correctly, and so there is a requirement to compile Linux kernel as
non-portable [1]. However I want to know what prevents U-Boot from
supporting all of JH7100, JH7110, JH7110S, with the same build target?

1: https://wiki.debian.org/InstallingDebianOn/StarFive/VisionFiveV1

Anyways, this change to CONFIG_OF_LIST is sorted correctly and looks
good to me.

Reviewed-by: E Shattow <e@freeshell.de>
