Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDDCCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 14:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8393087F52;
	Wed, 10 Apr 2024 16:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sa+VIhQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3DC088176; Wed, 10 Apr 2024 16:33:35 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3F987EEB
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 16:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-516d0c004b1so8080491e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712759612; x=1713364412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EDUYoYP1kRpMLbFPGF2LtxpsLAPimLQkVZe6WMIalwU=;
 b=Sa+VIhQZziz/YA9wOvo4Me6Lyrch/CLHCVSUNL50rabHD3Q1ONF7YEYrhshxepMXzS
 X62K8TkxC9REMTog3G1sYl+EohT3wKeyPD3uJq5nzwlwEMnLqn6cRozWwvggGZUrI1nj
 f6k9egbmYeyUetbYLOGkOgGEqyJ7swAxnEvu+uHOoOfWBQOUSo4yqqCNQaKSLVdRvwNN
 Pt2F5EHNQAqCGsbppy/Hx58lEO/hQrAStRGiMcyHlvLbflcJ0haKk0GqBJAQ+3ENu0PR
 ah5FPxir/ki2a8Y1tl2hMwwFY+pKALUB63yPeQLBF/tMxFZ7XaUPS46NWFBHg/Yrh0sl
 kLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712759612; x=1713364412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EDUYoYP1kRpMLbFPGF2LtxpsLAPimLQkVZe6WMIalwU=;
 b=cUMj6YmRlRl0EMMDqiLxSoWEFMMCBNAz1uKc0LTqa//u3nl7pTHBJ/s8n4+x0tWhPx
 +JokL5Ih6sCafUpkudPjhVhIpRXi2akkcl2Sq3IcK7zghV9lw75C9vo1HR0gNvU5AOgX
 Otbz0hq42A49Jcd3vZJ/1bBVkoLssfaLdWC8J5+KiiHsW5i5wl2MoGYnHZxn0jFPNwo+
 t6pYUYFVzkM39+yX+aZRSlHjht1yxJXe3tlS+Wfc3Dkm7t3LdGv8uBftsznzgL8fAkgi
 IUbyp7el24ZBOxh/vWb/keZHXcpu7ZgPR9xwZ4lgGTKgZ7kXzQiZJbIboZ++w1Fn1Djx
 mu2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/o9EUPCqln98TanC5H7rjTr7ehN1PwdFkUaJHBcYGCPUSm6xES9O+E3/9RGDSSOYQBlQDlsfxsxCir1RZ7yYB/X11OA==
X-Gm-Message-State: AOJu0YxScZK+0SNZYCqkE0h+caX6EvokR6hRjsGuztZgzVcvch+mCXQG
 JYy24o+plZJQysMXW9CNHJAeukejV81/phrbcGxKLQSVzi3CLw9yCZhs0x5e/MG7JaDn1UP8dTq
 KSHDlEEjeEzL4+AmB8gPN1IE51QOWGHvw73PGKQ==
X-Google-Smtp-Source: AGHT+IGsgCbT8IOyVdEHYyiIx9ePwjdFNqQs99PfqdvbPyzB0OxSulLRQso81yZgvHOJHXVnQNIhIvhAY7SmcaF8NSE=
X-Received: by 2002:ac2:55a4:0:b0:516:d0ec:5308 with SMTP id
 y4-20020ac255a4000000b00516d0ec5308mr2236669lfg.10.1712759612412; Wed, 10 Apr
 2024 07:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <877ch8hrct.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <877ch8hrct.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Apr 2024 16:32:56 +0200
Message-ID: <CAC_iWjLmkguL5FWA0Pxm=0H0cLOgxk5tXQy9L6+pr3gR2nj9Lg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Enable SetvariableRT
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, kettenis@openbsd.org, caleb.connolly@linaro.org, 
 sumit.garg@linaro.org, quic_llindhol@quicinc.com, ardb@kernel.org, 
 pbrobinson@gmail.com, pjones@redhat.com, trini@konsulko.com, 
 kojima.masahisa@socionext.com, takahiro.akashi@linaro.org, bmeng@tinylab.org, 
 raymond.mao@linaro.org, sjg@chromium.org, abdellatif.elkhlifi@arm.com, 
 eajames@linux.ibm.com, alpernebiyasak@gmail.com, sughosh.ganu@linaro.org, 
 o451686892@gmail.com, u-boot@lists.denx.de
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

Hi Mark ,

I am on a conference, not checking emails too much

On Mon, 8 Apr 2024 at 16:16, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Date: Sat,  6 Apr 2024 17:01:51 +0300
> >
> > Hi all,
>
> Hi Ilias,
>
> > This is an updated version of [0].
> >
> > When EFI variables are stored on file we don't allow SetVariableRT,
> > since the OS doesn't know how to access or write that file.  At the same
> > time keeping the U-Boot drivers alive in runtime sections and performing
> > writes from the firmware is dangerous -- if at all possible.
> >
> > For GetVariableRT  we copy runtime variables in RAM and expose them to
> > the OS. Add a Kconfig option and provide SetVariableRT using the same
> > memory back end. The OS will be responsible for syncing the RAM contents
> > to the file, otherwise any changes made during runtime won't persist
> > reboots.
> >
> > It's worth noting that the variable store format is defined in EBBR [1]
> > and authenticated variables are explicitly prohibited, since they have
> > to be stored on a medium that's tamper and rollback protected.
> >
> > The original RFC was just enabling the memory back end. This is a more
> > complete version and we should be able, with small adjustments of
> > userspace tools, fix SetVariableRT. If enabled the firmware will add two
> > new RO EFI variables after ExitBootServices.
> >
> > RTStorageVolatile -- contains the filename, relative to the ESP
> > VarToFile -- an EFI variable that holds all the BS,RT, NV variables and can
> > be copied to the file defined by RTStorageVolatile.
>
> How does the OS know what the right ESP is?  The system might have
> multiple disks that each have an ESP and more than one of those ESPs
> might contain an ubootefi.var file.  Maybe this should be a full
> EFI device path that includes the partition?

This delegates the problem no? How does the firmware know what ESP the
OS will need, so it can inject the proper DP?
Usually in Linux,  each OS version will know and mount the ESP it
needs using a UUID defined during the installation, so the name
relative to ESP seemed better.

In any case, this was a concern of mine as well on the RFC and I did
say we can alternatively use a full device path, but it will make the
userspace app harder. But as I said we will need a mechanism that the
firmware understands which OS pairs with each ESP.

>
> Also, is RTStorageVolutile the right name for this?  This is about
> storing Non-Volatile variables after all...

It's supposed to mean "Variable storage is volatile, here's the
filename you can use to persist them", but suggestions are always
welcome!

Thanks
/Ilias
>
> >
> > If any errors occur during the variable init, the firmware will delete them
> > and adjust the RT_PROP table accordingly, disabling SetvarRT.
> >
> > - pre-patch
> > $~ mount | grep efiva
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)
> >
> > $~ efibootmgr -n 0001
> > Could not set BootNext: Read-only file system
> >
> > - post-patch
> > $~ mount | grep efiva
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
> > , disabling SetvarRT.
> > $~ efibootmgr -n 0001
> > BootNext: 0001
> > BootCurrent: 0000
> > BootOrder: 0000,0001
> > Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
> > Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}
> >
> > $~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
> > GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
> > Name: "BootNext"
> > Attributes:
> >         Non-Volatile
> >         Boot Service Access
> >         Runtime Service Access
> > Value:
> > 00000000  01 00
> >
> > [0] https://lore.kernel.org/u-boot/20240329071929.2461441-1-ilias.apalodimas@linaro.org/
> > [1] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage
> >
> > Changes since the RFC:
> > - Return EFI_INVALID_PARAM if attributes are not volatile
> > - Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
> > - Add 2 EFI variables and allow userspace to write the file
> > - Add selftests
> >
> > Ilias Apalodimas (4):
> >   efi_loader: conditionally enable SetvariableRT
> >   efi_loader: Add OS notifications for SetVariableRT in RAM
> >   efi_loader: add an EFI variable with the variable file contents
> >   efi_selftest: add tests for setvariableRT
> >
> >  include/efi_loader.h                          |   4 +
> >  include/efi_variable.h                        |  15 +-
> >  lib/efi_loader/Kconfig                        |  16 ++
> >  lib/efi_loader/efi_boottime.c                 |   2 +
> >  lib/efi_loader/efi_runtime.c                  |   1 +
> >  lib/efi_loader/efi_var_common.c               |  43 ++--
> >  lib/efi_loader/efi_var_file.c                 |   1 -
> >  lib/efi_loader/efi_var_mem.c                  |  90 +++-----
> >  lib/efi_loader/efi_variable.c                 | 210 +++++++++++++++++-
> >  lib/efi_loader/efi_variable_tee.c             |   1 -
> >  .../efi_selftest_variables_runtime.c          | 116 +++++++++-
> >  11 files changed, 401 insertions(+), 98 deletions(-)
> >
> > --
> > 2.37.2
> >
> >
