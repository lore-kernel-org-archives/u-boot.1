Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAACAD3CCB3
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 06:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FC7803F5;
	Thu, 15 Jan 2026 07:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="allRh0cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4387983623; Thu, 15 Jan 2026 07:50:22 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21E180325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 07:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F0A242BB9;
 Thu, 15 Jan 2026 06:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD07C19421;
 Thu, 15 Jan 2026 06:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768459818;
 bh=+evbQBO48WudzSiNMzGY/KiJC7aI2Hd7p5EjGSlSilM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=allRh0cVvi+BfcECDgqEV4RimlArOSbZPvq8BJm+ZmLHBBdMYV5R58dw3uGYvBR9m
 VQP5Z6TXObHbSzhQA7oW4NClzrcAUJKCkJVjBpUCDzuIKvHKICbV5dmEBDfxEZZqsq
 ONYuQJRyJTgB0I/q9A3r37MUNKO+nLtrFvoCaFdfq0ha1RQcWzhqV6D0IkeIDkFXIb
 /OagntFsZYmUqo0iVqDoRcL5uJukZlqlTx14nsdkLmnhTY74zIun1qhTV9TPibRr/2
 9cd0iinNyvO4KUKxPpdVfTdQwkSbvh6Q97YXHbI0Ws2to9gN1s/J0Vy448K4W61Ric
 54cLT3WMkYvLQ==
Date: Thu, 15 Jan 2026 12:20:10 +0530
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
Message-ID: <aWiOIjLre9Ry70Jx@sumit-xelite>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
 <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
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

On Sat, Jan 10, 2026 at 02:00:03PM +0530, Aswin Murugan wrote:
> Thanks everyone for all the valuable feedback. I appreciate the detailed
> reviews and want to address the concerns raised.
> 
> I should have been clearer upfront about what makes Qualcomm platforms
> different here. Qualcomm has its own combined-dtb format that's been used
> across Linux products. The format is documented in [1] and the combined dtb
> file is placed in a separate dtb partition
> 
> The combined-dtb file contains multiple DTBs concatenated together as a
> single dtb file, each with Qualcomm-specific properties:
> - qcom,msm-id (platform ID and SoC revision)
> - qcom,board-id (board variant and subtype)
> - qcom,pmic-id (PMIC models - up to 4)

As discussed in the thread here [1], combined DTB is a legacy format
which is superceeded by the FIT based [2]. So rather work on FIT based
DTB packaging. Along with that extend mkimage tooling support in order
to build that FIT based multi DTB image.

[1] https://github.com/qualcomm-linux/meta-qcom/pull/1373#discussion_r2684555441
[2] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/Documentation.md

-Sumit

> 
> At runtime, we read hardware info from SMEM (shared memory interface with
> the firmware) and match it against these properties to pick the right DTB.
> 
> *Why Existing Approaches Don't Quite Fit*
> 
> After reviewing the feedback from Heinrich, Ilias, Simon & Sumith, I realize
> the core issue is that all the existing U-Boot mechanisms assume separate
> DTB files on the ESP:
> 
> VisionFive2 approach: Uses EEPROM detection in SPL and sets `$fdtfile` to
> point to individual files like `dtb/starfive/jh7110-milkv-mars.dtb`,
> `dtb/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb`
> 
> eficonfig and distro boot: These mechanisms work great for selecting between
> multiple DTB files.
> 
> The common thread is they all expect individual DTB files, while Qualcomm's
> deployment model uses a single combined-dtb.dtb file that requires parsing
> and extraction. This is the fundamental gap we're trying to bridge.
> 
>  I agree with Simon that using the weak function approach is not an ideal
> solution. we should be avoiding adding hooks in the EFI loader. Instead, we
> need to handle this at the board level and work with the existing `$fdtfile`
> mechanism.
> 
> *Proposed Approach*
> 
> Based on all the feedback, here's the revised plan:
> For v2:
> 1. In board code: Parse combined-dtb.dtb, extract the matching DTB, write to
> ESP as `dtb/qcom-<board>.dtb`
> 3. Set `$fdtfile` to point to the extracted file
> 4. Let standard EFI mechanisms handle the rest
> 5. Drop the weak function approach entirely
> 
> Does this approach address the concerns raised, or suggest a different
> direction? I'm particularly interested in feedback on runtime DTB extraction
> to ESP is acceptable, or if there's a better way to bridge between our
> combined-dtb format and U-Boot's expectations.
> 
> [1] https://docs.qualcomm.com/doc/80-70023-27/topic/configure_and_secure_boot_with_systemd_boot_and_uki.html#multi-dtb-support
> 
> Thanks,
> Aswin
> 
> On 1/6/2026 5:51 PM, Aswin Murugan wrote:
> > This RFC patch series introduces a weak function hook to allow platforms to
> > provide custom device tree selection logic while keeping common EFI
> > loader code generic.
> > 
> > Background:
> > Currently, EFI loader supports loading a single DTB file.
> > Qualcomm platforms require special multi-DTB selection logic that:
> > - Reads hardware information from SMEM (Shared Memory)
> > - Selects the appropriate device tree from a combined DTB file based on:
> >    * Platform ID (SoC variant)
> >    * Board variant and subtype
> >    * PMIC configuration
> >    * SoC revision.
> > 
> > Solution:
> > Introduce `efi_load_platform_fdt()` as a weak function:
> > - Weak implementation in lib/efi_loader/efi_fdt.c (defaults to no-op)
> > - Called from efi_bootmgr_run() after efi_load_distro_fdt()
> > - Qualcomm override in arch/arm/mach-snapdragon/efi_fdt_qcom.c
> > 
> > Aswin Murugan (3):
> >    efi_loader: Add platform hook for FDT loading
> >    soc: qcom: smem: Added socinfo header file
> >    mach-snapdragon: Implement Qualcomm multi-DTB selection
> > 
> >   arch/arm/mach-snapdragon/Makefile       |   1 +
> >   arch/arm/mach-snapdragon/efi_fdt_qcom.c | 339 ++++++++++++++++++++++++
> >   include/soc/qcom/socinfo.h              | 114 ++++++++
> >   lib/efi_loader/efi_fdt.c                |  34 +++
> >   4 files changed, 488 insertions(+)
> >   create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom.c
> >   create mode 100644 include/soc/qcom/socinfo.h
> > 
