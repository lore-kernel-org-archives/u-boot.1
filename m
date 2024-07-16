Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC2FC3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 02:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A46B8813A;
	Tue, 16 Jul 2024 04:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZV4jmzSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743548813A; Tue, 16 Jul 2024 04:17:54 +0200 (CEST)
Received: from mail-m1282.netease.com (mail-m1282.netease.com [103.209.128.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6786887FC8
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 04:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ZV4jmzSQThz4lEOSZGIv1p/6610XMWzX3Dxz9n1F690F2m1JNqlJ/ETjDjwqD5iEpLKA6abmANfqro1zHBDb7xxtqqcBqmCintIbWAlNX1G34CWmvoH3Kd0fHzXVRwxpMGoYNQM2EmZ6E9DaJbAJJfYRjjcSorQd6n55DNeOWzI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=dnoWWyYlXO9CisuQlV+mMPLADTg9mkFU6fSoanKtFZ8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 395A69001C9;
 Tue, 16 Jul 2024 10:17:37 +0800 (CST)
Message-ID: <b88949a1-db7d-43ea-8046-9e5e1f86d5e4@rock-chips.com>
Date: Tue, 16 Jul 2024 10:17:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/2] rockchip: theobroma-systems: migrate git URLs to
 HTTPS
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
 <20240620-tsd-http-git-clone-v1-1-666e8d6a8949@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240620-tsd-http-git-clone-v1-1-666e8d6a8949@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgeQlYeHR4YGk9MShoZSUtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a90b954c0be03a9kunm395a69001c9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6LSo*DjI5EBg*GVFLFkot
 GQgwCitVSlVKTElKS0JNSU5DSk9JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQ09ONwY+
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


On 2024/6/20 18:24, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> It turns out only Puma had a working git:// URL. Though that is now
> fixed, having HTTPS URLs make it easier to directly reach our cgit
> webserver to check what's up without having to change the URL manually.
>
> Depending on your terminal settings, this also makes it possible to
> open the link from it.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/jaguar_rk3588/MAINTAINERS | 2 +-
>   board/theobroma-systems/puma_rk3399/MAINTAINERS   | 2 +-
>   board/theobroma-systems/ringneck_px30/MAINTAINERS | 2 +-
>   board/theobroma-systems/tiger_rk3588/MAINTAINERS  | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
> index ab7051b427f..370d0a1272a 100644
> --- a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
> +++ b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
> @@ -10,4 +10,4 @@ F:	include/configs/jaguar_rk3588.h
>   F:	arch/arm/dts/rk3588-jaguar*
>   F:	configs/jaguar-rk3588_defconfig
>   W:	https://embedded.cherry.de/product/jaguar-sbc-rk3588/
> -T:	git git://git.embedded.cherry.de/jaguar-u-boot.git
> +T:	git https://git.embedded.cherry.de/jaguar-u-boot.git
> diff --git a/board/theobroma-systems/puma_rk3399/MAINTAINERS b/board/theobroma-systems/puma_rk3399/MAINTAINERS
> index 2536e348887..1a5b78bf535 100644
> --- a/board/theobroma-systems/puma_rk3399/MAINTAINERS
> +++ b/board/theobroma-systems/puma_rk3399/MAINTAINERS
> @@ -9,4 +9,4 @@ F:	include/configs/puma_rk3399.h
>   F:	arch/arm/dts/rk3399-puma*
>   F:	configs/puma-rk3399_defconfig
>   W:	https://embedded.cherry.de/product/puma-som-rk3399-q7/
> -T:	git git://git.embedded.cherry.de/puma-u-boot.git
> +T:	git https://git.embedded.cherry.de/puma-u-boot.git
> diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
> index 2aff91f4207..4d4544a2a3e 100644
> --- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
> +++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
> @@ -9,4 +9,4 @@ F:	include/configs/ringneck_px30.h
>   F:	arch/arm/dts/px30-ringneck*
>   F:	configs/ringneck-px30_defconfig
>   W:	https://embedded.cherry.de/product/ringneck-som-px30-uq7/
> -T:	git git://git.embedded.cherry.de/ringneck-u-boot.git
> +T:	git https://git.embedded.cherry.de/ringneck-u-boot.git
> diff --git a/board/theobroma-systems/tiger_rk3588/MAINTAINERS b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
> index e5aab4b29f3..a95135616ad 100644
> --- a/board/theobroma-systems/tiger_rk3588/MAINTAINERS
> +++ b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
> @@ -10,4 +10,4 @@ F:	include/configs/tiger_rk3588.h
>   F:	arch/arm/dts/rk3588-tiger*
>   F:	configs/tiger-rk3588_defconfig
>   W:	https://embedded.cherry.de/product/tiger-som-rk3588-q7/
> -T:	git git://git.embedded.cherry.de/tiger-u-boot.git
> +T:	git https://git.embedded.cherry.de/tiger-u-boot.git
>
