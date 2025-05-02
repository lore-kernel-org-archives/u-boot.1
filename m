Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC74C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 10:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25100810EB;
	Fri,  2 May 2025 12:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i862dD9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A4D812BC; Fri,  2 May 2025 12:50:26 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1B680F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 12:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id DDC2CA4C056;
 Fri,  2 May 2025 10:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A258C4CEE4;
 Fri,  2 May 2025 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746183022;
 bh=29TwjY4Z00mH2zi2ByVkVGF4l18cCud1TZAAXs+vDb0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i862dD9xYDo30P930OVpfAy3s769e4EtoJr1qTlLhrNlNIhkCZqRJI4Lu421+Yszc
 yGj2RRB31yxTAA5vl7ZVVOIsksPwnNLj97F2XSFGU3clvgle85dduXpzJPrJSDdNM5
 1+u4jZJy6xdtBQctpHM5Qgqbd7lVJGw0cAOks6uq/AqEcauMR4/HQ7X0XnWXubRzF2
 EvSdN8+fSA5A5+MFNRAfSTNz1g1Ag5tIPRS9rSq3msdq+FdNUUAvPzFRY7zkuExjM4
 5q9RfzFp/eHNt9xc1ISGtPob0PfvpWOjMhisbsFR7G7dMX3GdvSd9bS2v4Kzegh/tB
 u2GUl7t+Qgz/w==
Date: Fri, 2 May 2025 16:20:15 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
Message-ID: <aBSjZ7ospvGxJrbD@sumit-X1>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
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

Hi Casey

On Fri, Apr 11, 2025 at 05:03:33PM +0200, Caleb Connolly wrote:
> The initial capsule update support only worked on the RB3 Gen 2 and made
> a lot of assumptions specific to that board.
> 
> Implement the logic necessary to update U-Boot no matter where it was
> flashed to, independent of any particular board.
> 
> First, we keep track of how U-Boot was loaded, specifically if we had a
> valid external FDT (even if we didn't use it) this indicates that we
> were booted via the Android bootloader, in this case the target for
> capsule updates is the boot partition. Otherwise, we target the uefi
> partition (if it exists) or the xbl partition. We handle A/B support for
> all 3 (currently we always flash to the currently active partition with
> a minor exception for the uefi partition).

Does this means say if we are booting from "A" partition then the update
gets applied to "A" partition only? IOW, we don't support dual bank
updates as of now?

> 
> We introduce two new fw_name strings to differentiate the GUIDs based on
> the target partition, this means one board can support multiple boot
> methods with capsule update support for all of them (typically this
> would be chainloading OR flashing U-Boot to XBL).
> 
> Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
> scsi_scan() unbinds all scsi devices it breaks device handles maintained
> in the EFI layer for the duration of the capsule update process and
> causes the EFI filesystem access to delete the capsule file after the
> update to fail.
> 
> Boards should instead be responsible for calling scsi_scan() before
> initiating DFU.

Thanks for working on EFI firmware capsule updates feature. I think
currently we are missing any documentation from this patch-set. IOW, how
one can test updating U-Boot via EFI firmware capsules? I suppose we are
using here dynamic GUID generation while creating update capsules,
right?

-Sumit

> 
> ---
> Changes in v2:
> - Restrict the partition hunt to either UFS storage or the first MMC
>   device so that we never accidentally write to some external storage
>   (like an sdcard) during a capsule update.
> - Fix typo
> - Link to v1: https://lore.kernel.org/r/20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org
> 
> ---
> Caleb Connolly (4):
>       mach-snapdragon: track boot source
>       mach-snapdragon: CapsuleUpdate: support all boot methods
>       dfu: scsi: don't call scsi_scan()
>       qcom_defconfig: enable capsule update support
> 
>  arch/arm/mach-snapdragon/board.c          |  26 +++
>  arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++++++------
>  arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
>  configs/qcm6490_defconfig                 |   6 -
>  configs/qcom_defconfig                    |   3 +
>  drivers/dfu/dfu_scsi.c                    |   5 -
>  6 files changed, 266 insertions(+), 62 deletions(-)
> ---
> base-commit: 885d68280c29b8011731b6a7cdac32b8d9a4e6fd
> change-id: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2
> 
> Caleb Connolly <caleb.connolly@linaro.org>
> 
