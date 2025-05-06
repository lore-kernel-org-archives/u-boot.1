Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC7CC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A81800C1;
	Tue,  6 May 2025 09:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BTJbB5uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF36F80050; Tue,  6 May 2025 09:13:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C039280050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3994D5C4808;
 Tue,  6 May 2025 07:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0F5C4CEE4;
 Tue,  6 May 2025 07:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746515594;
 bh=gFJLe+UKmxMax/uUFP9h2rdtDidALTRVP+UGUkZYFXY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BTJbB5ucWrWv+FRSvoxrfsZNb7iaB/eE2UWmMkI+gJ4fZI9hsKSHerJGte1qOrkly
 53YbPYyyQfBNATiTDSeP1vJA8tpjXS65XRi2HnHX7SNokWobgGgZkK7x/ou8CTQWAN
 AGg74qGjxXq1YM/G1s5exeb+wm6/+bhkF9TyeDxXgz0bdjQhrnHXFiyaBTHUzoMrCq
 1+MwQGxtPPsvZ2Lbor7mVlMuWTW+OBMvI6i+Nj9ONHY5sPj+Kh7ExPqTaXYWXBFOV5
 eG7fx3jULj2VQRorLgbRofIgJDEBNJPfedAfVy9gVxmdOcC5ipgmP3JdAwRjYbEkHA
 tQOROFMysoKzA==
Date: Tue, 6 May 2025 12:43:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
Message-ID: <aBm2gwHIbcRwTd_F@sumit-X1>
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

Hi Casey,

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

I gave this patch-set a try on RB1, but somehow the firmware capsule
update didn't worked for me. I was able to install the firmware capsule
update using the "fwupdtool" from the OS but U-Boot can't consume it
from disk upon a reboot as follows:

Update capsule is present in EFI system partition as:

=> ls mmc 0:47 EFI/UpdateCapsule/
            ./
            ../
  1794156   fwupd-77f90b51-588c-5ef0-aab9-046aeb2ac8c5.cap

1 file(s), 2 dir(s)

However, it can't be picked via a manual/automatic capsule update
process in U-Boot:

=> efidebug capsule disk-update  
=>

Is there a known issue? After enabling debug logs, I see the capsule
update invocation bails out from here [1].

[1] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/efi_loader/efi_capsule.c?ref_type=heads#L1037

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
