Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CEAC3ABC5
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A7B82102;
	Wed,  7 May 2025 10:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aprNXuTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3BD28215B; Wed,  7 May 2025 10:49:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37117820EB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AF46435E8;
 Wed,  7 May 2025 08:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28659C4CEE7;
 Wed,  7 May 2025 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746607736;
 bh=m/9uOqUe0HBH1XUHv0dI7McfJ2JIOzsLDg3EJSOqk64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aprNXuTO3Zo4GqdseYaqzFHXSQmEpNtbGOZmzrQl1PSPML6DzYRiC5b1rOf4lEh6m
 jQ0DIWk5V9lUGEF9wwzoziYKrbNoCw21uZ0UfxrjJMxqkr6AGHJ1Yj922uRmNQsoWm
 OYBJj72VRfqy/DNVBJESCLFJ6FrYO31ttLMb2dXJ881+GJft7bqd8eC+HFAEuzA95X
 5zg4jgXHAKhE5zAPCt59yZXR5psaLV8+X57mfeVBcGrhBt6S5b2yddY6GDYDaePAh3
 gSDYXyJ9UeWoXeHfwr3Vfb2AIsml6cDdkCtlKEqY7Dg7A0o6XYgCZKOg592iXqcJue
 i/RcUv7G874jg==
Date: Wed, 7 May 2025 14:18:49 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
Message-ID: <aBsecVSdsyzgIQFZ@sumit-X1>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
 <aBm2gwHIbcRwTd_F@sumit-X1>
 <7939ced4-c3e5-44cf-8888-6e03d8ec37b4@linaro.org>
 <aBoCZxATwB8IF_Q6@sumit-X1>
 <CAC_iWjKTNAJB5ra7GKjOwpVcOubmLqAxjo8mHt0-D-y0LiErbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKTNAJB5ra7GKjOwpVcOubmLqAxjo8mHt0-D-y0LiErbw@mail.gmail.com>
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

Hi Ilias,

Thanks for your response.

On Tue, May 06, 2025 at 04:26:03PM +0300, Ilias Apalodimas wrote:
> Hi Sumit
> 
> On Tue, 6 May 2025 at 15:37, Sumit Garg <sumit.garg@kernel.org> wrote:
> >
> > + Heinrich
> >
> > On Tue, May 06, 2025 at 01:33:33PM +0200, Casey Connolly wrote:
> > >
> > >
> > > On 5/6/25 09:13, Sumit Garg wrote:
> > > > Hi Casey,
> > > >
> > > > On Fri, Apr 11, 2025 at 05:03:33PM +0200, Caleb Connolly wrote:
> > > > > The initial capsule update support only worked on the RB3 Gen 2 and made
> > > > > a lot of assumptions specific to that board.
> > > > >
> > > > > Implement the logic necessary to update U-Boot no matter where it was
> > > > > flashed to, independent of any particular board.
> > > > >
> > > > > First, we keep track of how U-Boot was loaded, specifically if we had a
> > > > > valid external FDT (even if we didn't use it) this indicates that we
> > > > > were booted via the Android bootloader, in this case the target for
> > > > > capsule updates is the boot partition. Otherwise, we target the uefi
> > > > > partition (if it exists) or the xbl partition. We handle A/B support for
> > > > > all 3 (currently we always flash to the currently active partition with
> > > > > a minor exception for the uefi partition).
> > > > >
> > > > > We introduce two new fw_name strings to differentiate the GUIDs based on
> > > > > the target partition, this means one board can support multiple boot
> > > > > methods with capsule update support for all of them (typically this
> > > > > would be chainloading OR flashing U-Boot to XBL).
> > > > >
> > > > > Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
> > > > > scsi_scan() unbinds all scsi devices it breaks device handles maintained
> > > > > in the EFI layer for the duration of the capsule update process and
> > > > > causes the EFI filesystem access to delete the capsule file after the
> > > > > update to fail.
> > > > >
> > > > > Boards should instead be responsible for calling scsi_scan() before
> > > > > initiating DFU.
> > > >
> > > > I gave this patch-set a try on RB1, but somehow the firmware capsule
> > > > update didn't worked for me. I was able to install the firmware capsule
> > > > update using the "fwupdtool" from the OS but U-Boot can't consume it
> > > > from disk upon a reboot as follows:
> > > >
> > > > Update capsule is present in EFI system partition as:
> > > >
> > > > => ls mmc 0:47 EFI/UpdateCapsule/
> > > >              ./
> > > >              ../
> > > >    1794156   fwupd-77f90b51-588c-5ef0-aab9-046aeb2ac8c5.cap
> > > >
> > > > 1 file(s), 2 dir(s)
> > > >
> > > > However, it can't be picked via a manual/automatic capsule update
> > > > process in U-Boot:
> > > >
> > > > => efidebug capsule disk-update
> > > > =>
> > > >
> > > > Is there a known issue? After enabling debug logs, I see the capsule
> > > > update invocation bails out from here [1].
> > >
> > > Yes, this is a known issue. I was able to work around it by running
> > > `eficonfig` and creating an entry pointing to the same partition,
> >
> 
> It's not an issue. It what the EFI spec describes for capsule updates
> on disk [0].
> That one says
> "The directory \EFI\UpdateCapsule is checked for capsules only within
> the EFI system partition on the device specified in the active boot
> option determine by reference to BootNext variable or BootOrder
> variable processing"
> So tl;dr your active boot options needs to point to the same ESP as
> you active boot option.
> eficonfig scans and stores default boot options when it runs, so I
> guess that's what made it work for you.

Agree, however this patch-set doesn't enable EFI runtime variable
services and hence CONFIG_EFI_IGNORE_OSINDICATIONS=y is set. Hence the
BootNext or BootOrder variables can't get configured by the OS
(fwupdtool). That's probably why Casey used `eficonfig` to set up new
boot entry pointing at ESP or the approach you mentioned below is
additionally needed for capsule update to work with this patch-set.

Casey,

It is something we should put under documenation for capsule update
support until we enable runtime EFI variables support.

> 
> > Can you share exactly what entry works for you via "eficonfig"?
> >
> > > then the
> > > EFI framework knows what you "boot device" is, since there is no default.
> >
> > I can see the "boot device" listed as part of BootOrder as follows:
> >
> > => efidebug boot order
> >  1: Boot0000: mmc 0
> >
> > => efidebug boot dump
> > Boot0000:
> > attributes: A-- (0x00000001)
> >   label: mmc 0
> >   file_path: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/eMMC(0)/eMMC(0)
> >   data:
> >     00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2  N.....YM....R,Y.
> >
> > So I am unsure why the EFI framework is unable to see that although I
> > can see code under API: find_boot_device() in "lib/efi_loader/efi_capsule.c"
> > looking for active device under BootOrder.
> >
> > Ilias, Heinrich,
> >
> > Do you have any clue here what may be going wrong here?
> 
> I assume the partition you store the capsule is an ESP -- IOW can you
> write and preserve EFI variables?

Yeah the EFI variable storage based on ESP file is enabled by this
patch-set.

> 
> Do you have EFI_CAPSULE_ON_DISK_EARLY enabled?

I am just directly testing this patch-set on RB1 and using fwupdtool on
the OS side to install capsules. So, EFI_CAPSULE_ON_DISK_EARLY isn't
enabled.

> My guess is that the disk isn't scanned yet and the capsule update
> doesn't start.

I can see the disk being scanned however as I mentioned above the ESP
boot entry is missing since the runtime variables support isn't present.

> There are some problems currently with scanned devices that Heinrich
> was looking at [1]
> 
> You can try
> - efidebug capsule update <capsule address> after you load the capsule
> manually. That will at least perform the update and you can move on
> with reviewing the patch as the current issue is orthogonal
> 
> or
> 
> - efidebug boot add -b 1001 cap mmc 1:1 EFI/UpdateCapsule && efidebug
> boot next 1001
> - setenv -e -nv -bs -rt -v OsIndications =0x0000000000000004 (if you
> dont have OS INDICATIONS)
> - efidebug capsule disk-update

Thanks for this suggestion, now I am able to get the capsule update to
work by manually adding a boot next entry as per following diff:

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index dbf6f4e7260..87703b5a643 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -3,7 +3,9 @@ stdout=serial,vidconsole
 stderr=serial,vidconsole
 preboot=scsi scan; usb start
 fastboot=fastboot -l $fastboot_addr_r usb 0
-do_boot=bootefi bootmgr
+cap_update=efidebug boot add -b 1001 cap mmc 0:47 EFI/UpdateCapsule && efidebug boot next 1001 && efidebug capsule disk-update
+cap_cleanup=efidebug boot rm 1001 && efidebug boot next 0000
+do_boot=run cap_update; run cap_cleanup; bootefi bootmgr
 bootmenu_0=Boot first available device=run do_boot
 bootmenu_1=Enable fastboot mode=run fastboot
 bootmenu_2=Reset device=reset

Since this diff requires specifying ESP partition specific to RB1, we
can't merge something like this upstream. So I am just hoping if the
generic EFI framework is able to auto discover the ESP partition for
capsule updates similar to how ESP is dicovered during boot in case the
EFI runtime variables and OsIndications aren't supported.

-Sumit

> 
> >
> > -Sumit
> 
> [0] https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.html#delivery-of-capsules-via-file-on-mass-storage-device
> [1] https://lore.kernel.org/u-boot/20250421162555.1200687-1-heinrich.schuchardt@canonical.com/
> 
> Thanks
> /Ilias
> 
> 
