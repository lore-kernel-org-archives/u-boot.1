Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F62F106F304
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B4883CF5;
	Thu, 26 Mar 2026 09:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f9YgNEKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9062583DA6; Thu, 26 Mar 2026 09:54:49 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46ED838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F24360103;
 Thu, 26 Mar 2026 08:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99244C116C6;
 Thu, 26 Mar 2026 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774515285;
 bh=LLqV3qnBBic/TBzV38CcHr+cD5UWFNZlePgfL8ioyF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f9YgNEKM7hh3tbtp4yV96ODTlnYPkzp+uhevntZjecseaFoiUJPAQ8emtjtuTtkyY
 TQf2A20GhIGIf/3csWIKV82j3WT1T1bLfDrUp4PSB0z6p4mZleY3CHGFLkRHLQV5d3
 CfeLvyB+87NrS3/wct4MhNeMXDGTfzjuWs6wqnCnHgI9VY73wQpqIc0O2Gy+Ve/lGN
 4iZ6PnNe1ySWOOVBD26pH9JwX9m2ScsI4m+I8aftkZZ1KkgBgVk2hvRfmpRzu13yUC
 cXu6U5l16pswwUJbh8EeJXnsjvTVNysFQ6XZCToSWLBx4hcfHbEy1UpD6clzSQbaRm
 EtlT/n16OOFCg==
Date: Thu, 26 Mar 2026 14:24:37 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 sjg@chromium.org, mkorpershoek@kernel.org, jan.kiszka@siemens.com,
 paul.liu@linaro.org, j-humphreys@ti.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/2] qcom: EFI PSCI runtime reset handling and config
 update
Message-ID: <acT0TVv3SeaDxSrQ@sumit-xelite>
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
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

On Tue, Mar 24, 2026 at 11:29:11PM +0530, Aswin Murugan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> With CONFIG_PSCI_RESET enabled, EFI runtime resets always use PSCI, but since
> it cannot pass the arguments needed for special reboot modes, requests like
> bootloader or EDL fall back to a normal reboot.
> 
> This version updates the earlier series that introduced configuration control
> over EFI PSCI-based runtime reset handling.
> 
> During review [1], it was pointed out that modifying only the Kconfig option
> was incomplete, as the EFI runtime configuration table in
> lib/efi_loader/efi_runtime.c also needs to be updated to reflect whether
> runtime reset support is enabled.
> 
> Additionally, the reviewer suggested that instead of introducing a new
> EFI_PSCI_RESET_RUNTIME option, we should reuse the existing
> EFI_HAVE_RUNTIME_RESET knob, making it user-configurable so platforms can
> opt out when the kernel must retain full control of specialized reboot
> modes.
> 
> This version implements that feedback:
> 
> 1. EFI_HAVE_RUNTIME_RESET is now a proper Kconfig configurable option
>    This allows individual platforms, such as Qualcomm boards, to 
>    explicitly disable U-Boot’s EFI runtime reset callbacks when required.
> 
> 2. The Qualcomm defconfig disables EFI_HAVE_RUNTIME_RESET so that the
>    kernel can manage advanced reboot flows (EDL, bootloader entry, etc.)
>    without U-Boot overriding those reset modes through EFI runtime
>    services.
> 
> 3. The EFI runtime table is updated accordingly to conditionally
>    advertise reset support only when EFI_HAVE_RUNTIME_RESET is enabled.
> 
> These changes maintain existing default behavior for platforms that rely
> on U-Boot’s EFI reset services, while enabling platforms with more
> complex reboot semantics to opt out cleanly.
> 
> [1] https://lore.kernel.org/all/CAC_iWjKZXsE86J_wJ=JTE0TGL=MqGm8YRYsq4BrkU2ba3me6OQ@mail.gmail.com/
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v4:
> - Made EFI_HAVE_RUNTIME_RESET user configurable & used it to disable U-Boot’s EFI runtime reset
>   for qualcomm platforms
> - Link to v3: https://lore.kernel.org/all/20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com/

For the series:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> Changes in v3:
> - Updated the commit message
> - Changed 'CONFIG_EFI_PSCI_RESET_RUNTIME=n' to '# CONFIG_EFI_PSCI_RESET_RUNTIME is not set'
> - Link to v2: https://lore.kernel.org/all/20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v2:
> - As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
> - Disabled the EFI_PSCI_RESET_RUNTIME config for qualcomm platforms
> - Link to v1: https://lore.kernel.org/all/20260108105146.1285450-1-aswin.murugan@oss.qualcomm.com/
> ---
> Aswin Murugan (2):
>   efi_loader: make EFI_HAVE_RUNTIME_RESET a user-selectable option
>   qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in qcom_defconfig
> 
>  configs/qcom_defconfig | 1 +
>  lib/efi_loader/Kconfig | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1
> 
