Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90DDD3CCB2
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 07:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D8080325;
	Thu, 15 Jan 2026 08:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cu66a9Hw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B120682BF2; Thu, 15 Jan 2026 08:24:17 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A2B80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C498441A9B;
 Thu, 15 Jan 2026 07:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0FAC116D0;
 Thu, 15 Jan 2026 07:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768461853;
 bh=XoKGTHJf2meSVIAo2QTn5Du/G4U3L+JV02z/3eu9z+U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cu66a9HwzfDhYB40duj9oQ53qkylpudyPOHdMo7bO/ogH+FB5eZuiM64bXpCBWUgb
 O2jzS8rNCMGJU8fi+UXI3Zpk7M8i3oNyf7QdxjGW/PDoroREsZAVYmywdPR1/ihbwT
 lH/VopZGd5+IICY8H5hew8HtvKbuENHubDT0ZhUFxbcErUcweRn2zi+hYmMY3Jzpqm
 UEqRyF+a0UvQYjExIkQymCrUKlLQomOhBOOlT7dgp6t+nfjRB4M2tln8tKKgJNRXRR
 8PIh64UnNqWwQMGloBZkghqWBHYqs3pzoTEybbygVuBFls/nA5yPf+kB97J3iDoKDG
 R0khBwUXfaUFw==
Date: Thu, 15 Jan 2026 12:54:06 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 ilias.apalodimas@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: Fix fastboot buffer address for QCS615 and
 QCM6490 boards
Message-ID: <aWiWFrdwvy7-IK63@sumit-xelite>
References: <20260107095038.2491697-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107095038.2491697-1-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

On Wed, Jan 07, 2026 at 03:20:38PM +0530, Balaji Selvanathan wrote:
> The default value of CONFIG_FASTBOOT_BUF_ADDR is 0, which causes
> NULL pointer dereference during fastboot commands when users dont
> provide "-l" option in fastboot usb command.

On Qcom platforms, we usually rely on LMB allocations for fastboot
address, see here [1]. So I would rather suggest you to adapt fastboot
common code [2] to consume fastboot address from env (fastboot_addr_r)
in case CONFIG_FASTBOOT_BUF_ADDR is 0. Then it will be a generic fix
applicable for all the Qcom platforms.

[1] arch/arm/mach-snapdragon/board.c:545 env_set_hex("fastboot_addr_r", addr)
[2] drivers/fastboot/fb_common.c:235 fastboot_init()

-Sumit

> 
> Set it to safe and sufficiently large region in RAM
> of the QCS615 and QCM6490 boards, to prevent crashes.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcm6490_defconfig     | 2 ++
>  configs/qcom_qcs615_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 54eb5dedaec..618098c8860 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -13,3 +13,5 @@ CONFIG_TEXT_BASE=0x9fc00000
>  CONFIG_REMAKE_ELF=y
>  
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> +
> +CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index 2468267b955..14043b4f23d 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -20,3 +20,5 @@ CONFIG_REMAKE_ELF=y
>  
>  # Address where U-Boot will be loaded
>  CONFIG_TEXT_BASE=0x9fc00000
> +
> +CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
> -- 
> 2.34.1
> 
