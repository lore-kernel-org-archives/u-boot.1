Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9B8C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 11:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EC58215E;
	Wed, 30 Apr 2025 13:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wyxis9xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1461F8283E; Wed, 30 Apr 2025 13:56:32 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616AE82153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 13:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-702628e34f2so9051067b3.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746014188; x=1746618988; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SGMwxBqJlq8FOE5lkmQJL2Cri9OUvWomAZcVRlFJs+4=;
 b=wyxis9xl39X1UNJ5NpKiMVnn5cbfb8FjPe60dbDUxnIL0xjbp9XPTEoTNoMisUKJzE
 SOQqihoitKywu5as3lKHhunzWNIlJX5zmAoebesQHfZdZKlPUawghu3szINMSV5GhYrx
 wJNCLdPEmrUYDQe5vS3YTHH3OFeXWTKy4yafCKhAXiXnJHXTA7sxGH/E4JVxWFhGLwYe
 zmC599af0xKidXSRO1fx1/9YOIwA1G+b8e2iRASu1Lqz0r5WU5GFm566mGu0rZsEjiMU
 XjT9g/ZfypH5roYCDSGtidOlkwQArNU+3N7n8cbT0uPsDlO+9QNHeXknip6uI579HxGF
 wQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746014188; x=1746618988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SGMwxBqJlq8FOE5lkmQJL2Cri9OUvWomAZcVRlFJs+4=;
 b=PTk+xJpfnqz3Gh5VoY2Nt8Nt8UHwevGfYalmrV2PnIWsiO+vOOX27xLC5kBLY/HFY/
 oUaxjWiHDlH2QmSMZG6dJtyi4LJTt3a3gUte1rcmVK6wuAJ4vZywO/tIgkH/nLgkhldU
 JUoa9MvNlMymCdI2jTgH82ZZYzADLEfr8vJJrRpYTXvH1WrDrKPg8X7d+CjdBWMHGIdo
 C98lhQlG1z1Pun1bLp92MMIF4bmj3eQiAZwNmhPizCPyu56o/Trk00DSk8hV+D2fsYrR
 eZj5uv/LsK3XUJ1EinSe+/BLQoBCm9QLsQ0SRE5n1n/gd/43W/qpWvQ+x4vxzdgl4k4Y
 rESw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw1yMLrrSjUZx9Ra+BOvJOmn7L9oO44P3E+BXL5MNxvpR15SSJdAGKN9wifyKRXLN3qD+qojk=@lists.denx.de
X-Gm-Message-State: AOJu0YyQaroUr37/BU374kH33GN8J71pIxzZmr4AlNz+h2NNHWqypupw
 hBw0jrdOHZxpbl6SofFS+oNT4y+iG/U+1YkDdDQdjn8fPktC2qzxBctQVvGWVffV6uxBM3EJ9dJ
 /pGMhUqp3rgIelcfwEx6JcfPdvi3Ac0GZAalsqQ==
X-Gm-Gg: ASbGncsEfcCMbu0m4zU+wllRTk98e0amomuD3bqcLBrb4oLP2cvtOY/51NzTslBPNXH
 nvSi1OeTFbIc2qZ2kL3vO9c57m+J3vGEq6Qua4WpU+Uw5YU+eMbEZ/+5D7GHP0bymifgkq0zkh2
 J3yZJqcRsCUMWNG7tcql/k28xgYhmeo3jLRg==
X-Google-Smtp-Source: AGHT+IFxJ7n7iT0MrZy90eDPdeeNsdjd0PiONvXZjJlUG9ca5MNn8pu7F7jlYaG25P88t566fVxgh5e+crFBRkPgc/s=
X-Received: by 2002:a05:690c:998a:b0:6fb:9445:d28e with SMTP id
 00721157ae682-708ad0cc1bdmr32595667b3.10.1746014188119; Wed, 30 Apr 2025
 04:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250429132756.2105309-1-adriano.cordova@canonical.com>
 <20250429132756.2105309-2-adriano.cordova@canonical.com>
 <5516429f-074e-4ae6-bd7d-d49f020eae4a@gmx.de>
 <0aba7595-018d-4288-a8d4-a262da9a4580@gmx.de>
 <afc3301f-c364-400f-80f4-ca6b81b5484b@gmx.de>
In-Reply-To: <afc3301f-c364-400f-80f4-ca6b81b5484b@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Apr 2025 14:55:51 +0300
X-Gm-Features: ATxdqUGaq5-ziFSRwBZRa4_tihcSWxyIhaVwHouSNvA07lU01TNeYkaFBc95U7c
Message-ID: <CAC_iWjJG0JVeB0o5jFyjTShWswejojA4mdBG0JYUrQ18Fn2pLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] efi_loader: bootbin: do not load an initrd if none
 is provided
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de, Masahisa Kojima <kojima.masahisa@socionext.com>
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

Hi Heinrich

On Wed, 30 Apr 2025 at 14:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 30.04.25 13:00, Heinrich Schuchardt wrote:
> > On 30.04.25 09:03, Heinrich Schuchardt wrote:
> >> On 4/29/25 15:27, Adriano Cordova wrote:
> >>> Do not try to create an initrd device path nor try to register
> >>> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
> >>>
> >>> Handle initrd installation in efi_binary_run_dp with
> >>> efi_install_initrd, imitating what is done for the fdt.
> >>>
> >>> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> >>> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> >>> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> >>> Tested-by: Weizhao Ouyang <o451686892@gmail.com>
> >>
> >> I built and installed U-Boot for the StarFive VisionFive 2 based on
> >> origin/master plus this series.
> >>
> >> I created a FIT images using the its file listed below.
> >>
> >> I loaded and tried to run the FIT image:
> >>
> >> StarFive # load nvme 0:1 $kernel_addr_r initrd.itb
> >> StarFive # bootm $kernel_addr_r
> >>
> >> and saw the following failure:
> >>
> >> ## Transferring control to EFI (at address 00000000) ...
> >> Card did not respond to voltage select! : -110
> >> Booting /initrd.itb
> >> Not a PE-COFF file
> >> Loading image failed
> >>
> >> We use the entry point instead of the load address when transferring
> >> control to the EFI sub-system.
> >>
> >> This bug was introduced by ecc7fdaa9ef1 ("bootm: Add a bootm command
> >> for type IH_OS_EFI") and is not related to your patches but we still
> >> need to fix it.
> >
> > Addressed by:
> > bootm: pass kernel load address not entry point for IH_OS_EFI
> > https://patchwork.ozlabs.org/project/uboot/
> > patch/20250430105546.327442-1-heinrich.schuchardt@canonical.com/
> >
> >>
> >> Afterwards I tried to boot into Ubuntu and got:
> >>
> >>    Loading Linux 6.14.0-13-generic ...
> >>    Loading initial ramdisk ...
> >>    error: failed to install protocols.
> >>    Loading device tree blob...
> >>
> >>    Press any key to continue...
> >>
> >> It seems that U-Boot did not uninstall the LoadFile2 protocol when
> >> discovering that the EFI image was invalid. We should have a look at
> >> the error handling.
> >
> > This issue still has to be resolved.
>
> For FIT images we don't trigger the event group related to
> efi_guid_event_group_return_to_efibootmgr which calls event
> efi_initrd_return_notify() which in turn calls efi_initrd_deregister().
>
> A call to efi_initrd_deregister() is missing in do_bootm_efi().
>
> Maybe adding the call to efi_binary_run() and getting rid of the event
> group would be preferable.
>
> @Ilias, @Masahisa
> Any preferences?

I was about to respond that EFI handles that with an event! We used to
do this in the efi bootmgr code, when returning from the EFI app, but
having an event seemed more elegant back then.
If removing the event makes the code common across efi/non-efi cases I
am fine removing it.

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >>
> >> The initrd for my test case can be created with:
> >>
> >> echo 'hello world' > hello
> >> echo hello | cpio -o -H newc > initrd
> >>
> >
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >
>
