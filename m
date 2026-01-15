Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63859D3CCB3
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 06:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB3E8803F5;
	Thu, 15 Jan 2026 07:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eVo8vOjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDC3835B3; Thu, 15 Jan 2026 07:52:04 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B6080325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 07:52:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B0EEB40B18;
 Thu, 15 Jan 2026 06:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D6FC116D0;
 Thu, 15 Jan 2026 06:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768459920;
 bh=8POKtVCI1n8kn7AupC3Kc6o+EqXNBo/fNx1cyLC2wVk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eVo8vOjfSZPMJL0ORMM6GMPSqV8EUAUCuggmrkgvVCeDzhMYk7NePtO0eoi9Njecm
 R2f7Rz5sR01rhRM+6E4w/dCTMmEWvXrIv5vnGdC5wWhrA7X2sJtkmxxDtv/kH8ZOr6
 NMz0dTZE7XxAgL6uyk/TAn+ZrMzrImMYnfjxxv+EH/M8NxwFKz/g1NckM/avVZPPwt
 3+xWzXsh7kslUXD4k6II06TKaxOC3R3jSgJmGBVj2uYQNDMTEUSYdyBxIHgV05/Cbi
 YGCJIxG0IUQgtjwXheHoDge/WejAdiJTc9EZ0MWeOknbK0sEVcAJo71z3xScJzLIVe
 YJCBm0vYFhS8A==
Date: Thu, 15 Jan 2026 12:21:52 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [RFC PATCH v1 0/3] efi_loader: Introduce platform hook for FDT
 selection
Message-ID: <aWiOiE34YQH2uFZM@sumit-xelite>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
 <597c246c-113c-4b88-93bb-22ec5b525b55@oss.qualcomm.com>
 <019a78cc-40fa-4404-97a3-b9145107a7ba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <019a78cc-40fa-4404-97a3-b9145107a7ba@linaro.org>
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

On Mon, Jan 12, 2026 at 02:48:21PM +0100, Casey Connolly wrote:
> Hi Aswin,
> 
> On 10/01/2026 09:30, Aswin Murugan wrote:
> > Thanks everyone for all the valuable feedback. I appreciate the detailed
> > reviews and want to address the concerns raised.
> > 
> > I should have been clearer upfront about what makes Qualcomm platforms
> > different here. Qualcomm has its own combined-dtb format that's been
> > used across Linux products. The format is documented in [1] and the
> > combined dtb file is placed in a separate dtb partition
> > 
> > The combined-dtb file contains multiple DTBs concatenated together as a
> > single dtb file, each with Qualcomm-specific properties:
> > - qcom,msm-id (platform ID and SoC revision)
> > - qcom,board-id (board variant and subtype)
> > - qcom,pmic-id (PMIC models - up to 4)
> > 
> > At runtime, we read hardware info from SMEM (shared memory interface
> > with the firmware) and match it against these properties to pick the
> > right DTB.
> > 
> > *Why Existing Approaches Don't Quite Fit*
> > 
> > After reviewing the feedback from Heinrich, Ilias, Simon & Sumith, I
> > realize the core issue is that all the existing U-Boot mechanisms assume
> > separate DTB files on the ESP:
> > 
> > VisionFive2 approach: Uses EEPROM detection in SPL and sets `$fdtfile`
> > to point to individual files like `dtb/starfive/jh7110-milkv-mars.dtb`,
> > `dtb/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb`
> > 
> > eficonfig and distro boot: These mechanisms work great for selecting
> > between multiple DTB files.
> > 
> > The common thread is they all expect individual DTB files, while
> > Qualcomm's deployment model uses a single combined-dtb.dtb file that
> > requires parsing and extraction. This is the fundamental gap we're
> > trying to bridge.
> > 
> >  I agree with Simon that using the weak function approach is not an
> > ideal solution. we should be avoiding adding hooks in the EFI loader.
> > Instead, we need to handle this at the board level and work with the
> > existing `$fdtfile` mechanism.
> > 
> > *Proposed Approach*
> > 
> > Based on all the feedback, here's the revised plan:
> > For v2:
> > 1. In board code: Parse combined-dtb.dtb, extract the matching DTB,
> > write to ESP as `dtb/qcom-<board>.dtb`
> 
> In board code - this should be a new file in mach-snapdragon with a new
> config option.
> 
> I don't think it's correct to write to the ESP, that's a very good way
> to frustrate users and developers imo. Once the proper FDT has been
> found it can be installed as the default for EFI booting by setting
> $fdt_addr to point to it (see efi_install_fdt() in
> lib/efi_loader/efi_helper.c), as well as setting $fdtfile
> 
> This way fdt_addr can be overwritten during boot by the user, and if
> there is an FDT found on the ESP then we can be sure it was put there by
> the distro or user and it should be used instead.
> 
> So in the end the priority of where the FDT is sourced from will look
> like this:
> 
> 1. OS loader (GRUB/sd-boot)
> 2. FDT loaded/configured by user (e.g. in eficonfig)
> 3. DTB found on the ESP by U-Boot (based on $fdtfile)
> 4. FDT from qcom-specific dtb partition
> 5. U-Boot's own FDT
> 
> I think this strikes a good balance without imposing confusing logic on
> the user, particularly if there is a nice log message when the FDT is
> installed from the qcom combined DTB.

Sounds reasonable to me.

-Sumit

> 
> Kind regards,
> 
> > 3. Set `$fdtfile` to point to the extracted file
> > 4. Let standard EFI mechanisms handle the rest
> > 5. Drop the weak function approach entirely
> > 
> > Does this approach address the concerns raised, or suggest a different
> > direction? I'm particularly interested in feedback on runtime DTB
> > extraction to ESP is acceptable, or if there's a better way to bridge
> > between our combined-dtb format and U-Boot's expectations.
> > 
> > [1] https://docs.qualcomm.com/doc/80-70023-27/topic/
> > configure_and_secure_boot_with_systemd_boot_and_uki.html#multi-dtb-support
> > 
> > Thanks,
> > Aswin
> > 
> > On 1/6/2026 5:51 PM, Aswin Murugan wrote:
> >> This RFC patch series introduces a weak function hook to allow
> >> platforms to
> >> provide custom device tree selection logic while keeping common EFI
> >> loader code generic.
> >>
> >> Background:
> >> Currently, EFI loader supports loading a single DTB file.
> >> Qualcomm platforms require special multi-DTB selection logic that:
> >> - Reads hardware information from SMEM (Shared Memory)
> >> - Selects the appropriate device tree from a combined DTB file based on:
> >>    * Platform ID (SoC variant)
> >>    * Board variant and subtype
> >>    * PMIC configuration
> >>    * SoC revision.
> >>
> >> Solution:
> >> Introduce `efi_load_platform_fdt()` as a weak function:
> >> - Weak implementation in lib/efi_loader/efi_fdt.c (defaults to no-op)
> >> - Called from efi_bootmgr_run() after efi_load_distro_fdt()
> >> - Qualcomm override in arch/arm/mach-snapdragon/efi_fdt_qcom.c
> >>
> >> Aswin Murugan (3):
> >>    efi_loader: Add platform hook for FDT loading
> >>    soc: qcom: smem: Added socinfo header file
> >>    mach-snapdragon: Implement Qualcomm multi-DTB selection
> >>
> >>   arch/arm/mach-snapdragon/Makefile       |   1 +
> >>   arch/arm/mach-snapdragon/efi_fdt_qcom.c | 339 ++++++++++++++++++++++++
> >>   include/soc/qcom/socinfo.h              | 114 ++++++++
> >>   lib/efi_loader/efi_fdt.c                |  34 +++
> >>   4 files changed, 488 insertions(+)
> >>   create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom.c
> >>   create mode 100644 include/soc/qcom/socinfo.h
> >>
> 
> -- 
> // Casey (she/her)
> 
