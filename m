Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F542E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080898069D;
	Tue, 14 Jan 2025 14:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NlUtXfKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2BA806DD; Tue, 14 Jan 2025 14:44:02 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D532805CD
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab2e308a99bso196723366b.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736862239; x=1737467039; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=diIXIi9qDASjieNS6Q0Tfcx4BOcc02tzZRpOZlLyUWs=;
 b=NlUtXfKIKEhp6NXh6MW2rCb8sHFBVO4cvQbh0I0p70jEgHjj1vQBARnxWwbkIIDzSa
 zFuChcBX4wEvj3TSe/XJ0Fyi3ExuWFEyFGVKtB8O0kafbthgmuqU01eElC90EQ7crq8s
 Va6l+FLc4m3hxlhz1YcNBZIYbnTrgQX88Z/3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736862239; x=1737467039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=diIXIi9qDASjieNS6Q0Tfcx4BOcc02tzZRpOZlLyUWs=;
 b=RddLRxe3T4QCcOt/3+MnEydbA22DWSjIEK/tL/88y7sEmGjNVDNXF5UGhLELjH1eiV
 d3vD+UdaMWrKUlzKsd7udDHemgGgqLHG7op+hmMD6XpRr212VD+PZ/qtWAvSD/NbZp6K
 KX7FmUCTqSdq1YDYMYhnUOpotHg6QvmJhwUe70nKGs9moI/xa0S9d2ytpKcsYW8sFTfT
 /1KzinihM5Kb8g1tC/JbsoecIvz+nFksHSFWkEGgVA+RdIFl6hnmkL9xWrt2vZbZ1PLX
 jsUy2RJx9vEDOUP8qIzkbRlkR+c2YjAlYe980UMpMnqjOSDFpSsJVrrHoQE4193Ms+NJ
 wWzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCLtFseJJHJ84DL8ornh5tBwhVimmEks7Yt/5Eo1jyeJLjuHyq7TuJaJ+KvIzrthbPLrzD1H4=@lists.denx.de
X-Gm-Message-State: AOJu0YxZF6NwGIFdo2DxRLguy1HYpzSCiNwOOIenDzT87w89JdV1DxWt
 Add3GfkwG+hYy71jjZgXoyPnOI5T3XSWLsjLp22A2onHYhhdbQmMTvuLiNh1XNUj4f2pcZV6OSP
 srPW0USefbpi2+6mOYAZJbj+ovbXOZvcjGS+I
X-Gm-Gg: ASbGncsZ0292VVu/B5JzR9jdQIb9TOLniM+7vq7rrkp7mkNBbJDIQ2Y9FPqZZfi4SFz
 MWp3cuHUbAcilM17z9L+GMOmPdVuSCyswrrIz8+w=
X-Google-Smtp-Source: AGHT+IFxPI6Q9R8SfjM3Kh8/NKws/LeUXYhhUpbZeA6xrHpQkIBXslCM9ltpIVWO1Z9ONFoDKSY0zDRekNv5WemNmTI=
X-Received: by 2002:a17:906:99c2:b0:aa6:938a:3c40 with SMTP id
 a640c23a62f3a-ab2c3d4d2c5mr1828715766b.24.1736862239067; Tue, 14 Jan 2025
 05:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20250112235843.25738-1-semen.protsenko@linaro.org>
 <be394627-0cbd-4658-a45b-7cbd4d1b4db0@gmx.de>
In-Reply-To: <be394627-0cbd-4658-a45b-7cbd4d1b4db0@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 06:43:47 -0700
X-Gm-Features: AbW1kvZIETnTnwbtp189KGJ2fQLaIKkpsEvKEqxWqldFsDK_vB2JgH5_FaJE5WI
Message-ID: <CAFLszTinHCAPgow1TgVfcT4uW6DT7eYGovMCUrwUs2S8Z1Erog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] efi_loader: Call efi_init_early() even earlier
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Mon, 13 Jan 2025 at 00:29, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/13/25 00:58, Sam Protsenko wrote:
> > At least in case of the E850-96 board all DM devices are probed in
> > initr_dm(), before efi_init_early() call. Eventually efi_bl_init()
> > registers the EVT_DM_POST_PROBE_EVENT event, but all DM devices
> > (including eMMC) are already probed by then, so no events are caught.
> > Because of that efi_disk_probe() is never called, so EFI disk objects
> > are not created and EFI subsystem can't function correctly, showing the
> > next symptoms:
> >    - 'efidebug dh' output shows nothing
> >    - attempt to add boot devices in 'eficonfig' shows this message:
> >      "No block device found!"
> >    - 'bootefi selftest $fdtcontroladdr' shows this warning:
> >      "Cannot persist EFI variables without system partition"
> >    - booting GRUB with 'bootefi' runs minimal GRUB shell which doesn't
> >      see any block devices as well, probably because EFI vars weren't
> >      passed
> >
> > Move efi_init_early() call before initr_dm() in init_sequence_r[] so
> > that EVT_DM_POST_PROBE_EVENT in efi_bl_init() can actually catch all DM
> > probe events and create corresponding EFI objects. That fixes the
> > described problem and makes it possible to run EFI apps like GRUB
> > correctly, add entries in 'eficonfig', and makes 'efivar --list' command
> > in Linux rootfs actually show EFI variables.
> >
> > This patch doubles down on the approach taken in commit 5e847f7729b3
> > ("efi_loader: call efi_init_early() earlier"), taking a different path
> > than another fix proposed earlier in "Pull-request efi-2025-01-rc4" [1].
> > There was also a related discussion in the "efi_loader: more tightly
> > integrate UEFI disks to driver model" patch series [2].
>
> There are two DM functions:
>
> - dm_initr
> - dm_initr_dm_devices
>
> Before dm_initr() gd->dm_root points to the pre-relocation tree. So I
> guess we should not register the DM events for EFI before that point.
>
> Shouldn't the DM devices only be scanned in initr_dm_devices? Why is
> E850-96 doing so in dm_initr?
>
> @Simon
> We really need to document the dm_initr* functions. Could you, please,
> suggest code comments to be added common/board_r.c.

Once [1] lands, sure. At the moment, dm_init() is doing the wrong thing.

>
> Please, also describe enum bootstage_id including
> BOOTSTAGE_ID_ACCUM_DM_R. I am clueless why the value exists.

It provides the time taken by driver model to init, after relocation.
It is printed with the bootstage report before the kernel boots. BTW
it should be printed before the EFI app boots too, assuming bootstage
is enabled.

>
> Do you have an idea why dm_init_and_scan() would cause probing? Why is
> this function called in dm_initr() and not in initr_dm_devices()?

No, that is just wrong. I hope it isn't something to do with Marek's change.

As noted above I did send something to try to restore the driver model
'invariants'[1]. If that is applied then I could take a look at a test
for this, to make sure other boards don't have this problem.

As I mentioned elsewhere, EFI_LOADER should be using U-Boot's internal
data where possible, rather than having its own parallel data
structures, as that is always up-to-date. I also wonder if there is a
clever way to create ephemeral structures which are created as needed
from the DM data. Not sure.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=433606
