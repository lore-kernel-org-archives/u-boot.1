Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D90C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 12:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FF6820EB;
	Tue,  6 May 2025 14:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fi8DspHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781288214F; Tue,  6 May 2025 14:37:06 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B545B8291D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 14:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 453826154C;
 Tue,  6 May 2025 12:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AD4C4CEE4;
 Tue,  6 May 2025 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746535022;
 bh=l+8HYsRTCUl1O0RPDyrWU6IK3hGzKxaa+ZvS/oUkgtk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fi8DspHV9oEtPV/djHqjel9whw3go4/Xu0rkrNxziI/Ulmy/MkTfhKNexNqc3DUQk
 xpCxJnts2+7RHiEQCg/roeJX8ePWcSQ1RzlCe8CCTu/whzqu/3OjUKzegwIIl/0lfN
 R7yqJGGr69NVHC2CbWHvMJuIsKTxPOuOVQzlDGug1C44YpVw0ZLCUtOTVXo3imI5iN
 EON9EGhA11Ik/w2sICwtmRS3HpHzAuPnUIxAO28Si3IhSFbbHtlLCLxmfLMk3e/Fa5
 vIUJYvDPf4vAhZvgql6PC3Qpdp+zeOk2ylTp7/cd/0bOuzkW/0MyVuUnV3SAIHDR1w
 MwUbjxXtSaX7Q==
Date: Tue, 6 May 2025 18:06:55 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
Message-ID: <aBoCZxATwB8IF_Q6@sumit-X1>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
 <aBm2gwHIbcRwTd_F@sumit-X1>
 <7939ced4-c3e5-44cf-8888-6e03d8ec37b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7939ced4-c3e5-44cf-8888-6e03d8ec37b4@linaro.org>
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

+ Heinrich

On Tue, May 06, 2025 at 01:33:33PM +0200, Casey Connolly wrote:
> 
> 
> On 5/6/25 09:13, Sumit Garg wrote:
> > Hi Casey,
> > 
> > On Fri, Apr 11, 2025 at 05:03:33PM +0200, Caleb Connolly wrote:
> > > The initial capsule update support only worked on the RB3 Gen 2 and made
> > > a lot of assumptions specific to that board.
> > > 
> > > Implement the logic necessary to update U-Boot no matter where it was
> > > flashed to, independent of any particular board.
> > > 
> > > First, we keep track of how U-Boot was loaded, specifically if we had a
> > > valid external FDT (even if we didn't use it) this indicates that we
> > > were booted via the Android bootloader, in this case the target for
> > > capsule updates is the boot partition. Otherwise, we target the uefi
> > > partition (if it exists) or the xbl partition. We handle A/B support for
> > > all 3 (currently we always flash to the currently active partition with
> > > a minor exception for the uefi partition).
> > > 
> > > We introduce two new fw_name strings to differentiate the GUIDs based on
> > > the target partition, this means one board can support multiple boot
> > > methods with capsule update support for all of them (typically this
> > > would be chainloading OR flashing U-Boot to XBL).
> > > 
> > > Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
> > > scsi_scan() unbinds all scsi devices it breaks device handles maintained
> > > in the EFI layer for the duration of the capsule update process and
> > > causes the EFI filesystem access to delete the capsule file after the
> > > update to fail.
> > > 
> > > Boards should instead be responsible for calling scsi_scan() before
> > > initiating DFU.
> > 
> > I gave this patch-set a try on RB1, but somehow the firmware capsule
> > update didn't worked for me. I was able to install the firmware capsule
> > update using the "fwupdtool" from the OS but U-Boot can't consume it
> > from disk upon a reboot as follows:
> > 
> > Update capsule is present in EFI system partition as:
> > 
> > => ls mmc 0:47 EFI/UpdateCapsule/
> >              ./
> >              ../
> >    1794156   fwupd-77f90b51-588c-5ef0-aab9-046aeb2ac8c5.cap
> > 
> > 1 file(s), 2 dir(s)
> > 
> > However, it can't be picked via a manual/automatic capsule update
> > process in U-Boot:
> > 
> > => efidebug capsule disk-update
> > =>
> > 
> > Is there a known issue? After enabling debug logs, I see the capsule
> > update invocation bails out from here [1].
> 
> Yes, this is a known issue. I was able to work around it by running
> `eficonfig` and creating an entry pointing to the same partition,

Can you share exactly what entry works for you via "eficonfig"?

> then the
> EFI framework knows what you "boot device" is, since there is no default.

I can see the "boot device" listed as part of BootOrder as follows:

=> efidebug boot order
 1: Boot0000: mmc 0

=> efidebug boot dump
Boot0000:
attributes: A-- (0x00000001)
  label: mmc 0
  file_path: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/eMMC(0)/eMMC(0)
  data:
    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2  N.....YM....R,Y.

So I am unsure why the EFI framework is unable to see that although I
can see code under API: find_boot_device() in "lib/efi_loader/efi_capsule.c"
looking for active device under BootOrder.

Ilias, Heinrich,

Do you have any clue here what may be going wrong here?

-Sumit

> 
> I spoke with Ilias about this and we think it's appropriate to bypass this
> check if the option is enabled to ignore OS indications, but didn't get
> aroudn to implementing it yet.
> 
> Kind regards,
> 
> > 
> > [1] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/efi_loader/efi_capsule.c?ref_type=heads#L1037
> > 
> > -Sumit
> > 
> > > 
> > > ---
> > > Changes in v2:
> > > - Restrict the partition hunt to either UFS storage or the first MMC
> > >    device so that we never accidentally write to some external storage
> > >    (like an sdcard) during a capsule update.
> > > - Fix typo
> > > - Link to v1: https://lore.kernel.org/r/20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org
> > > 
> > > ---
> > > Caleb Connolly (4):
> > >        mach-snapdragon: track boot source
> > >        mach-snapdragon: CapsuleUpdate: support all boot methods
> > >        dfu: scsi: don't call scsi_scan()
> > >        qcom_defconfig: enable capsule update support
> > > 
> > >   arch/arm/mach-snapdragon/board.c          |  26 +++
> > >   arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++++++------
> > >   arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
> > >   configs/qcm6490_defconfig                 |   6 -
> > >   configs/qcom_defconfig                    |   3 +
> > >   drivers/dfu/dfu_scsi.c                    |   5 -
> > >   6 files changed, 266 insertions(+), 62 deletions(-)
> > > ---
> > > base-commit: 885d68280c29b8011731b6a7cdac32b8d9a4e6fd
> > > change-id: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2
> > > 
> > > Caleb Connolly <caleb.connolly@linaro.org>
> > > 
> 
> -- 
> Casey (she/they)
> 
