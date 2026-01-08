Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD09D185E8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 12:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8E383B87;
	Thu,  8 Jan 2026 13:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o/ZnpyGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5026383B8A; Thu,  8 Jan 2026 13:10:48 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C43839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 13:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D634860130;
 Thu,  8 Jan 2026 12:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320CDC19421;
 Thu,  8 Jan 2026 12:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767874243;
 bh=HdWBwWUXLiCzxd3C3/VprUqGOPB19pVM3wCKuftM7AU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o/ZnpyGdxzlY2uNlF6mirMFoCk0dUwlCAkSS0EvUe+k43sa/kr/wrJrVntrLIAK29
 sIhQD9AhhHPeleUr9sOiRSGvisb70Vy6tuqayLp525M4oZS+aeckjEAim9MYwE6/Vy
 CMQi5D7K6tjAUGo2EOqeiZdSPR9K+iE1nNO/kDfeqx8HI8C98/RZi46T7waWaFiHh4
 qTS1uqOJhVsYM69aEyEssV7vrzDpQrLnnOr6Lek8RiQyDpW0cf33UTf2L7E2k8qjMB
 z79dC/M/PWK3QkjiKj+S1/ePmvH7GDzJ00deNFREr5ANELw2FMlq7cJuG0WKvQ4R8A
 oj48UBY7AO0hg==
Date: Thu, 8 Jan 2026 17:40:34 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [RFC PATCH v1 0/3] efi_loader: Introduce platform hook for FDT
 selection
Message-ID: <aV-eumhHFeCxceZg@sumit-xelite>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
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

On Tue, Jan 06, 2026 at 05:51:31PM +0530, Aswin Murugan wrote:
> This RFC patch series introduces a weak function hook to allow platforms to
> provide custom device tree selection logic while keeping common EFI
> loader code generic.
> 
> Background:
> Currently, EFI loader supports loading a single DTB file.

As pointed to by folks in the other thread, U-Boot allows to select a
DTB from all the DTBs bundled by the OS in EFI system partition. You can
see the Debian example here for DTBs packaging [1].

> Qualcomm platforms require special multi-DTB selection logic that:
> - Reads hardware information from SMEM (Shared Memory)
> - Selects the appropriate device tree from a combined DTB file based on:
>   * Platform ID (SoC variant)
>   * Board variant and subtype
>   * PMIC configuration
>   * SoC revision.

I think here you are presenting an incomplete picture to the U-Boot
community. You need to show firstly how the multi-DTB FIT image is
prepared first which is described here [2].

From U-Boot point of view, I think this DTB selection logic is useful
which can be used to configure: $fdtfile, see API: configure_env() in
arch/arm/mach-snapdragon/board.c.

However, does this solution also cover OEMs based boards alongside Qcom
reference boards?

> 
> Solution:
> Introduce `efi_load_platform_fdt()` as a weak function:
> - Weak implementation in lib/efi_loader/efi_fdt.c (defaults to no-op)
> - Called from efi_bootmgr_run() after efi_load_distro_fdt()
> - Qualcomm override in arch/arm/mach-snapdragon/efi_fdt_qcom.c
> 

[1] https://packages.debian.org/sid/u-boot-efi-dtb
[2] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/Documentation.md

-Sumit

> Aswin Murugan (3):
>   efi_loader: Add platform hook for FDT loading
>   soc: qcom: smem: Added socinfo header file
>   mach-snapdragon: Implement Qualcomm multi-DTB selection
> 
>  arch/arm/mach-snapdragon/Makefile       |   1 +
>  arch/arm/mach-snapdragon/efi_fdt_qcom.c | 339 ++++++++++++++++++++++++
>  include/soc/qcom/socinfo.h              | 114 ++++++++
>  lib/efi_loader/efi_fdt.c                |  34 +++
>  4 files changed, 488 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom.c
>  create mode 100644 include/soc/qcom/socinfo.h
> 
> -- 
> 2.34.1
> 
