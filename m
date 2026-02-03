Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604D5E7C712
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E39840C3;
	Tue,  3 Feb 2026 12:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pp3t+WNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB4F840D8; Tue,  3 Feb 2026 12:54:18 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D34840B1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C8FBA601DF;
 Tue,  3 Feb 2026 11:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62FFC19422;
 Tue,  3 Feb 2026 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770119654;
 bh=eGVcMqi5LddgYwPdjfSk9tl7tsNz/htsTFi8d38P02Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pp3t+WNFThdxkASccL5kidR9NcilueYiEYC3qXyINPxwi70uFeupkFBJok/3RyA7C
 d/srXqoMF9M/ulGSfWCb0KKpnqwdfS1eX2EB2Ea1MURc8nQxFE7C8YwHHBG2e3Plfh
 AkwXdc+exRjcka1a/MEB01ydJV1bqBQxE0uYKQhXAvGZBlqHHRLhhIEXbG0ufmpEY1
 KhsPDIO04+JM+kN4y8w/t64lpp8Av0nd3eWlmfkgZEnrv329R1t8PCZaraaK94vOwS
 ll4ZlmBUwCkUYkZVV+8eo4/qwy6jh8ZA+h+kl4imGlFDk/yx0jdeVeu43kVDkWx9h8
 /0lvDtdxwO6cA==
Date: Tue, 3 Feb 2026 17:24:05 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/3] Add FIT multi-DTB selection for Qualcomm platforms
Message-ID: <aYHh3UCOevXKlv3t@sumit-xelite>
References: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
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

Hi Ashwin,

On Fri, Jan 30, 2026 at 12:18:14AM +0530, Aswin Murugan wrote:
> This series adds dynamic device tree selection from FIT images for
> Qualcomm Snapdragon platforms, enabling U-Boot to select the
> appropriate DTB based on hardware parameters detected from SMEM.
> 
> Qualcomm fit based DTB format is documented in [1]
> The fit image contains only DTB, while the kernel will be part of UKI image.
> 

As I suggested in earlier posting as well, we rather need to use
upstream FIT tooling and infrastructure to generate this FIT image. Do
you know how much of the mkimage tooling can be reused here? Can we push
upstream relevant .dts and .its files as reference?

The next bigger question to me is how FIT signatures are going to be
supported here with secure boot enabled?

Also, as I see here [1] there are only Qcom reference designs supported.
What it will take to support OEM boards based on Qcom silicon?

So I would rather suggest you to build an upstream framework to enable
generating these FIT DTBs, ability to support FIT signatures and
add proper documentation around it upstream U-Boot project.

[1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/qcom-platforms.md

-Sumit

> The implementation consists of three parts:
> 
> 1. SMEM cache infrastructure: Provides cached access to commonly
>    used SMEM data (socinfo, RAM partitions) to avoid redundant
>    lookups during boot. Includes socinfo header from Linux kernel
>    for SoC identification.
> 
> 2. FIT multi-DTB selection: Implements the core selection logic
>    that reads hardware parameters from SMEM, parses metadata DTB,
>    matches FIT configurations, and loads the selected DTB with
>    overlays. Integrates with EFI boot flow by setting fdt_addr.
> 
> 3. Platform configuration: Enables the feature by default and
>    configures platform-specific IMEM sizes needed for storage
>    type detection (QCM6490/QCS615: 0x2B000, QCS9100: 0x59000).
> 
> [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/Documentation.md
> 
> ---
> Changes in v2:
> - In v1, a combined DTB format was used for multi-DTB support. Based on
>   feedback, v2 implements FIT-based DTB selection instead.
> - Link to v1: https://lore.kernel.org/all/20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com/
> 
> Aswin Murugan (3):
>   mach-snapdragon: Add generic SMEM cache infrastructure
>   mach-snapdragon: Add FIT multi-DTB selection support
>   configs: snapdragon: Enable FIT multi-DTB and configure IMEM
> 
>  arch/arm/mach-snapdragon/Kconfig             |   18 +
>  arch/arm/mach-snapdragon/Makefile            |    1 +
>  arch/arm/mach-snapdragon/board.c             |  112 ++
>  arch/arm/mach-snapdragon/qcom-priv.h         |   10 +
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1237 ++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  170 +++
>  arch/arm/mach-snapdragon/rampart.h           |  236 ++++
>  configs/qcm6490_defconfig                    |    2 +
>  configs/qcom_defconfig                       |    2 +
>  configs/qcom_qcs615_defconfig                |    2 +
>  configs/qcom_qcs9100_defconfig               |    1 +
>  include/soc/qcom/socinfo.h                   |  114 ++
>  12 files changed, 1905 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h
>  create mode 100644 arch/arm/mach-snapdragon/rampart.h
>  create mode 100644 include/soc/qcom/socinfo.h
> 
> -- 
> 2.34.1
> 
