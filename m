Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBCCC3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B1882162;
	Tue,  6 May 2025 15:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mTM7zGCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA8C82163; Tue,  6 May 2025 15:26:43 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0396820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6febbd3b75cso52009977b3.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746537999; x=1747142799; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7obfX+1sc3qKx5ZbPDTVx1NxJpGtYNwbSome5Wd7trg=;
 b=mTM7zGCRrNGSrTOJ98ICq9jz1TmsHdu+GRFZe3KZqGR4Ce67y3LrqpkKeRpATczF1U
 55Awb9udtr64dsDIHGiw8/MToEOW9r5wpYFGUkfSqOkWjAd5rRQh45omkcthrkSoWB49
 1SLo5ivcMEMM/7nhp7zopEC5WTdEHatW0b8VHdi9pQvvxBAuz6743dtnheDJjDaDJZYD
 uS92Vh6yLNgea37/HwlgI/093jqGpE9Bbq3D2Vv4aqOi/lsX0qOy5vR8p+r8bj2w6fLM
 LYwk0+ID/+gj5RE4U4bRB5iGdio8p4RD/5s/zezelqLM4MP6jDoJBw7URopknT0BIXhZ
 nrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537999; x=1747142799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7obfX+1sc3qKx5ZbPDTVx1NxJpGtYNwbSome5Wd7trg=;
 b=F3HCCesGImwo1QOOQarXXqd5w4h4LC4iSukMR0QQcUNZRuu4PA7KMn90YiAfyqEPwL
 cyN9jInHGpb7Ay8IwGx1WCF9ymew0g+O8vIOjgSTc9ablDsZkatyY5TkLO5uInBpoPyL
 PkrYNKX8jNb4woJUVfdcqrftQrX3+z8zUkGCxeDF7L3cTGlvZ4Ng1uO+N7BpiiEZgQPU
 i0sUWHV/CS1zO05I5gkZCroNRfcYg13XkdwYld4OY1moFJdlpiq2il6sAgHniijsVarc
 Oj2gjjHQKm+a8qfs6XYoA3VKAyE3EEWuJEIhgQUqkriQVg4Csb9ZjGrnLRF2myl/MJoV
 mMPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfpYmuygWZQYtYT6BLGsXp+Qtki72n+rQTxxXliO0AcBA+FAB9mF+l0r7ADWEWwhvWTpBhEcA=@lists.denx.de
X-Gm-Message-State: AOJu0YyCdOhFTBxtMNcAatuxSMTyru2q0JzAUjks+sGo0iUyq4hUIosb
 GsIGpOpqyf32cxONuJjznqz7paOB4Yb8DyeC3AzgB04yWQUj0F/C4CUa81FBd8LQes6NSw+CYX9
 Eqn28+hWMdBbF5B6vU8BRQmsGhGk3S+EbPkq+OA==
X-Gm-Gg: ASbGncs3TF5KuOjNMsba211bU/evPf4l4/c34hBKTA/KkzKbbm3r4AJmIIipGe+4YzF
 2HKy1tPk1P4OwBDu8ASFncMuALBRKc9xRFbk30gCBfPkYtDFB+T16hEXUvpYwWi92w5b/qUa5Ze
 p83CeLkwgDwR/62X7ZIHOVStwg6dXu679+IA==
X-Google-Smtp-Source: AGHT+IHQCU5iTgrLXUN15V0LTlhEb8SIJ10O1iO5Ip/2ADdCxijr658X6xfJR4/sVmXNO3CFYPq30S01c77/FOt8Kqs=
X-Received: by 2002:a05:690c:8c1a:b0:709:176d:2d3 with SMTP id
 00721157ae682-709176d0565mr37404367b3.5.1746537999525; Tue, 06 May 2025
 06:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
 <aBm2gwHIbcRwTd_F@sumit-X1> <7939ced4-c3e5-44cf-8888-6e03d8ec37b4@linaro.org>
 <aBoCZxATwB8IF_Q6@sumit-X1>
In-Reply-To: <aBoCZxATwB8IF_Q6@sumit-X1>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 6 May 2025 16:26:03 +0300
X-Gm-Features: ATxdqUEL4MzwtlGM80Mzibb_ayc_bdYk_0S6okvAVqhBAv8uYDvg5E6LQzOxMIM
Message-ID: <CAC_iWjKTNAJB5ra7GKjOwpVcOubmLqAxjo8mHt0-D-y0LiErbw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Qualcomm: expand capsule update support
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

Hi Sumit

On Tue, 6 May 2025 at 15:37, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> + Heinrich
>
> On Tue, May 06, 2025 at 01:33:33PM +0200, Casey Connolly wrote:
> >
> >
> > On 5/6/25 09:13, Sumit Garg wrote:
> > > Hi Casey,
> > >
> > > On Fri, Apr 11, 2025 at 05:03:33PM +0200, Caleb Connolly wrote:
> > > > The initial capsule update support only worked on the RB3 Gen 2 and made
> > > > a lot of assumptions specific to that board.
> > > >
> > > > Implement the logic necessary to update U-Boot no matter where it was
> > > > flashed to, independent of any particular board.
> > > >
> > > > First, we keep track of how U-Boot was loaded, specifically if we had a
> > > > valid external FDT (even if we didn't use it) this indicates that we
> > > > were booted via the Android bootloader, in this case the target for
> > > > capsule updates is the boot partition. Otherwise, we target the uefi
> > > > partition (if it exists) or the xbl partition. We handle A/B support for
> > > > all 3 (currently we always flash to the currently active partition with
> > > > a minor exception for the uefi partition).
> > > >
> > > > We introduce two new fw_name strings to differentiate the GUIDs based on
> > > > the target partition, this means one board can support multiple boot
> > > > methods with capsule update support for all of them (typically this
> > > > would be chainloading OR flashing U-Boot to XBL).
> > > >
> > > > Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
> > > > scsi_scan() unbinds all scsi devices it breaks device handles maintained
> > > > in the EFI layer for the duration of the capsule update process and
> > > > causes the EFI filesystem access to delete the capsule file after the
> > > > update to fail.
> > > >
> > > > Boards should instead be responsible for calling scsi_scan() before
> > > > initiating DFU.
> > >
> > > I gave this patch-set a try on RB1, but somehow the firmware capsule
> > > update didn't worked for me. I was able to install the firmware capsule
> > > update using the "fwupdtool" from the OS but U-Boot can't consume it
> > > from disk upon a reboot as follows:
> > >
> > > Update capsule is present in EFI system partition as:
> > >
> > > => ls mmc 0:47 EFI/UpdateCapsule/
> > >              ./
> > >              ../
> > >    1794156   fwupd-77f90b51-588c-5ef0-aab9-046aeb2ac8c5.cap
> > >
> > > 1 file(s), 2 dir(s)
> > >
> > > However, it can't be picked via a manual/automatic capsule update
> > > process in U-Boot:
> > >
> > > => efidebug capsule disk-update
> > > =>
> > >
> > > Is there a known issue? After enabling debug logs, I see the capsule
> > > update invocation bails out from here [1].
> >
> > Yes, this is a known issue. I was able to work around it by running
> > `eficonfig` and creating an entry pointing to the same partition,
>

It's not an issue. It what the EFI spec describes for capsule updates
on disk [0].
That one says
"The directory \EFI\UpdateCapsule is checked for capsules only within
the EFI system partition on the device specified in the active boot
option determine by reference to BootNext variable or BootOrder
variable processing"
So tl;dr your active boot options needs to point to the same ESP as
you active boot option.
eficonfig scans and stores default boot options when it runs, so I
guess that's what made it work for you.

> Can you share exactly what entry works for you via "eficonfig"?
>
> > then the
> > EFI framework knows what you "boot device" is, since there is no default.
>
> I can see the "boot device" listed as part of BootOrder as follows:
>
> => efidebug boot order
>  1: Boot0000: mmc 0
>
> => efidebug boot dump
> Boot0000:
> attributes: A-- (0x00000001)
>   label: mmc 0
>   file_path: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/eMMC(0)/eMMC(0)
>   data:
>     00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2  N.....YM....R,Y.
>
> So I am unsure why the EFI framework is unable to see that although I
> can see code under API: find_boot_device() in "lib/efi_loader/efi_capsule.c"
> looking for active device under BootOrder.
>
> Ilias, Heinrich,
>
> Do you have any clue here what may be going wrong here?

I assume the partition you store the capsule is an ESP -- IOW can you
write and preserve EFI variables?

Do you have EFI_CAPSULE_ON_DISK_EARLY enabled?
My guess is that the disk isn't scanned yet and the capsule update
doesn't start.
There are some problems currently with scanned devices that Heinrich
was looking at [1]

You can try
- efidebug capsule update <capsule address> after you load the capsule
manually. That will at least perform the update and you can move on
with reviewing the patch as the current issue is orthogonal

or

- efidebug boot add -b 1001 cap mmc 1:1 EFI/UpdateCapsule && efidebug
boot next 1001
- setenv -e -nv -bs -rt -v OsIndications =0x0000000000000004 (if you
dont have OS INDICATIONS)
- efidebug capsule disk-update

>
> -Sumit

[0] https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.html#delivery-of-capsules-via-file-on-mass-storage-device
[1] https://lore.kernel.org/u-boot/20250421162555.1200687-1-heinrich.schuchardt@canonical.com/

Thanks
/Ilias


>
> >
> > I spoke with Ilias about this and we think it's appropriate to bypass this
> > check if the option is enabled to ignore OS indications, but didn't get
> > aroudn to implementing it yet.
> >
> > Kind regards,
> >
> > >
> > > [1] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/efi_loader/efi_capsule.c?ref_type=heads#L1037
> > >
> > > -Sumit
> > >
> > > >
> > > > ---
> > > > Changes in v2:
> > > > - Restrict the partition hunt to either UFS storage or the first MMC
> > > >    device so that we never accidentally write to some external storage
> > > >    (like an sdcard) during a capsule update.
> > > > - Fix typo
> > > > - Link to v1: https://lore.kernel.org/r/20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org
> > > >
> > > > ---
> > > > Caleb Connolly (4):
> > > >        mach-snapdragon: track boot source
> > > >        mach-snapdragon: CapsuleUpdate: support all boot methods
> > > >        dfu: scsi: don't call scsi_scan()
> > > >        qcom_defconfig: enable capsule update support
> > > >
> > > >   arch/arm/mach-snapdragon/board.c          |  26 +++
> > > >   arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++++++------
> > > >   arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
> > > >   configs/qcm6490_defconfig                 |   6 -
> > > >   configs/qcom_defconfig                    |   3 +
> > > >   drivers/dfu/dfu_scsi.c                    |   5 -
> > > >   6 files changed, 266 insertions(+), 62 deletions(-)
> > > > ---
> > > > base-commit: 885d68280c29b8011731b6a7cdac32b8d9a4e6fd
> > > > change-id: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2
> > > >
> > > > Caleb Connolly <caleb.connolly@linaro.org>
> > > >
> >
> > --
> > Casey (she/they)
> >
