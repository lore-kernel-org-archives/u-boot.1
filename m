Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94296EF48C4
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 11:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94EE83DEC;
	Sat, 14 Feb 2026 12:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="JO1zDC1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73BEA83E23; Sat, 14 Feb 2026 12:03:13 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68ADC83D3D
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 12:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1771066962;
 bh=oHpzlTCneH589J0s85oxJ6PbYzr03T0nwtRui9I2EQE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JO1zDC1crmKdzqS2Y09J+gn8yrAC/zvayyXsFzY7Cse0nKjoN8N5+eVDKt/WL8Q1b
 tX7VVvX+HoAm6icXPjG1rpyBq4ZV8F/MxVvh4SecTz3zqtQMyKv6tztFCetW0Nyatk
 rD13rELs0ft6Be3LJuh0rZLcswrvrbzilCK3xXmDyxrv00+lvAdKcEZCBfFmsosY5H
 ZqxvFQd4t+T3ZGMnplphYhSDvM4627ds10KrfzCvQ4jjD61F8gZLL8481gl9gZb8F2
 TwrwksHw+Np3s5PgnlprZlTYjexeWKLFhXsq2NbhtEO5SrvUXzZtpqNDj6IsxdlXlh
 UgjFmTpw7z5zQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8FDBDB2211E6;
 Sat, 14 Feb 2026 12:02:40 +0100 (CET)
Message-ID: <b36465d8-2d99-4143-9e4c-91724c43c620@freeshell.de>
Date: Sat, 14 Feb 2026 03:02:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: visionfive2: Fix the name of VisionFive 2
 Lite DT
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20260214091424.28428-1-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260214091424.28428-1-hal.feng@starfivetech.com>
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

Hi Hal,

On 2/14/26 01:14, Hal Feng wrote:
> The name of VisionFive 2 Lite DT was set incorrectly. Fix it.
> 
> Fixes: 4ea3acc000a7 ("configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST")
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
> index ef4acf7c1db..614a003c971 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_BOOTSTAGE=y
>  CONFIG_OF_BOARD=y
>  CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
> -CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b configs/starfive_visionfive2_defconfig"
> +CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y

NAK

That fixes tag is not valid because the problem is responsibility of Leo
to revert and re-apply. Your series does not have this defect. I care
about this because I am listed as a reviewer.

Leo: fix this error with revert of all affected commits and do it again
correctly instead of authors having to submit a "fix" to a bad merge.

I would like to know why this happened?

Further, when there are ANY changes I would say that the person making
that change MUST add their tag to take responsibility;  it is not
acceptable to me to be tagged on a commit that has been silently
altered. The "forge" (gitlab) lists who committed the series but there
is no indication or comment about what happened here where it matters in
the git repository log.

-E
