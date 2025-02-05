Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E491C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 03:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C30801F5;
	Wed,  5 Feb 2025 04:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="On8qsLPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13CDA80207; Wed,  5 Feb 2025 04:13:28 +0100 (CET)
Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com
 [45.254.49.205])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8541D80087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 04:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id a30f5de4;
 Wed, 5 Feb 2025 11:13:17 +0800 (GMT+08:00)
Message-ID: <82002bf1-ce13-4e5a-8efc-256e4c237aa9@rock-chips.com>
Date: Wed, 5 Feb 2025 11:13:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: theobroma-systems: use HAVE_VENDOR_COMMON_LIB
 to simplify Makefile
To: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250129-tsd-have_vendor_common_lib-v1-1-631525b51458@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250129-tsd-have_vendor_common_lib-v1-1-631525b51458@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01JSFZCThlJGh5DSR9JT0pWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
 pVSktLVUpCS0tZBg++
X-HM-Tid: 0a94d419076503afkunma30f5de4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6Kgw6HDIWFhQeMTY#LxEQ
 Mx4aCx9VSlVKTEhDTElOSkJDQ0lCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISElINwY+
DKIM-Signature: a=rsa-sha256;
 b=On8qsLPGVmJmHOI8etPWyUIyAHHnWeS3OLl2mm2cM9dIs6Qw8zENzl6UxTqY5qZUb5gk8IMQ3uI5zMrQRdMKQPDFc+ZK7XG52X3TP5h5r7TDEUovHFh9A3LOZ/NxOEO+t27LOuc4Q+pt6K9RrHqjMxQSTOcwKqto1UGJAoaSAuw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=qvPqPLi3ncGIH5IvK1GtUyrIJhgOmvKwSTvJzUPJdyM=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/1/29 23:24, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The build system uses HAVE_VENDOR_COMMON_LIB to automatically include
> board/$(VENDOR)/common/Makefile, therefore let's use that to implicitly
> include board/theobroma-systems/common/Makefile and compile the common.c
> file when building proper.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/common/Makefile        | 9 +++++++++
>   board/theobroma-systems/jaguar_rk3588/Makefile | 3 ---
>   board/theobroma-systems/puma_rk3399/Makefile   | 3 ---
>   board/theobroma-systems/ringneck_px30/Makefile | 3 ---
>   board/theobroma-systems/tiger_rk3588/Makefile  | 3 ---
>   5 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/board/theobroma-systems/common/Makefile b/board/theobroma-systems/common/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..c1cadb4b913e8da8bc182f8142b16b2443891343
> --- /dev/null
> +++ b/board/theobroma-systems/common/Makefile
> @@ -0,0 +1,9 @@
> +#
> +# Copyright (c) 2025 Cherry Embedded Solutions GmbH
> +#
> +# SPDX-License-Identifier:	GPL-2.0+
> +#
> +
> +ifneq ($(CONFIG_XPL_BUILD),y)
> +obj-y	+= common.o
> +endif
> diff --git a/board/theobroma-systems/jaguar_rk3588/Makefile b/board/theobroma-systems/jaguar_rk3588/Makefile
> index d43bf194b687cacc556491ecc9041c4da8fd207c..38b73d2846c48f8afad31349d0cf3c593969366e 100644
> --- a/board/theobroma-systems/jaguar_rk3588/Makefile
> +++ b/board/theobroma-systems/jaguar_rk3588/Makefile
> @@ -5,6 +5,3 @@
>   #
>   
>   obj-y += jaguar_rk3588.o
> -ifneq ($(CONFIG_XPL_BUILD),y)
> -obj-y	+= ../common/common.o
> -endif
> diff --git a/board/theobroma-systems/puma_rk3399/Makefile b/board/theobroma-systems/puma_rk3399/Makefile
> index 2256e72cda1986ffa9502447a5d7d975eaea504b..d962b56f11123afe4573b64b0d8728fc0a0aa576 100644
> --- a/board/theobroma-systems/puma_rk3399/Makefile
> +++ b/board/theobroma-systems/puma_rk3399/Makefile
> @@ -5,6 +5,3 @@
>   #
>   
>   obj-y	+= puma-rk3399.o
> -ifneq ($(CONFIG_XPL_BUILD),y)
> -obj-y	+= ../common/common.o
> -endif
> diff --git a/board/theobroma-systems/ringneck_px30/Makefile b/board/theobroma-systems/ringneck_px30/Makefile
> index 4d108f2d011f07d0fff141158af39a55726348f7..31ada1a69422cdb7bb85bc6c737e2a98187bc62c 100644
> --- a/board/theobroma-systems/ringneck_px30/Makefile
> +++ b/board/theobroma-systems/ringneck_px30/Makefile
> @@ -5,6 +5,3 @@
>   #
>   
>   obj-y	+= ringneck-px30.o
> -ifneq ($(CONFIG_XPL_BUILD),y)
> -obj-y	+= ../common/common.o
> -endif
> diff --git a/board/theobroma-systems/tiger_rk3588/Makefile b/board/theobroma-systems/tiger_rk3588/Makefile
> index 94b0859eb356c31c3358c453ae46ea8cc64a50c0..900647735fb129fc9252a1cb14ed19d74e8026a0 100644
> --- a/board/theobroma-systems/tiger_rk3588/Makefile
> +++ b/board/theobroma-systems/tiger_rk3588/Makefile
> @@ -5,6 +5,3 @@
>   #
>   
>   obj-y += tiger_rk3588.o
> -ifneq ($(CONFIG_XPL_BUILD),y)
> -obj-y	+= ../common/common.o
> -endif
>
> ---
> base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
> change-id: 20250129-tsd-have_vendor_common_lib-42c4dd70c3e4
>
> Best regards,
