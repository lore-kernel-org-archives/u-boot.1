Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3B2C47072
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725A786F53;
	Wed, 15 Nov 2023 14:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="msRzyExM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725C687120; Wed, 15 Nov 2023 14:12:13 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D36804CE
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso983085866b.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700053931; x=1700658731; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+bpy2m+K1I+wZYX1fBGxORs9SQwuuekfS2Eunla8R4U=;
 b=msRzyExMw5DNZ0lvQFYzsJvatqW0vyRhQyejsvHZzx9JF9KbGvrfZ97pPVf9owmMak
 A6M96RMEjk17QzPlP0OIV1Q+0ACMDpqwD/AV41t6H9jJT0VdqHPpXtzV3TWK+FYftgq1
 r56FcbB5gAsIAGZ7q96mKiP8MvdXCc7byeBBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700053931; x=1700658731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bpy2m+K1I+wZYX1fBGxORs9SQwuuekfS2Eunla8R4U=;
 b=c2qT/fSOOeyv6/W6A5MdJd2k+INEI7fu9ZLYkRq02CZmPbsqJlAh1JnjQKSkZ0bUT9
 qO80/KJ5OBgtD7Vxcbrov3hnGXNlR6i/33EzgmTjC4HJdsMqjVv05zF1Q0vopcQtGOKJ
 vIMclyu7Kw5g9ia6zwSxlpAkZ3i6/GvCEGShAMqrT2XhmVRe17Jyn5eZeaeX4n1slOpE
 33POVP8m8kFyBGJ7UzYglCJslT01wf+myAkuqk+/CDvdXTwBARhV8zgvwlwCptXrrUZu
 CpkwsASnma3oLRHp6Y/oXv9idOxz5aulmw7AqxKVjtvG5mH/3ietayiMAcKyg4BC9Ff2
 W4Ew==
X-Gm-Message-State: AOJu0YwoyRIUi89AfYWYDZ70fecfUKNtUSLIfaEg0n1uZU+whYFAJagH
 tM9YJ9li5PzqEL9XqSkLMypxyJ+u+iNZ35SOhj7mSQ==
X-Google-Smtp-Source: AGHT+IGnZMF67nwpzu3ROYptLDyrRvezwlzlzMrAjiMRopyejVg0WJbj8hFYAsEowH8qSUI9gZz7Ze1kC9T70QplS88=
X-Received: by 2002:a17:906:cd1f:b0:9e6:9abb:d3cc with SMTP id
 oz31-20020a170906cd1f00b009e69abbd3ccmr8535595ejb.1.1700053930459; Wed, 15
 Nov 2023 05:12:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
In-Reply-To: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 06:11:52 -0700
Message-ID: <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

+Heinrich Schuchardt

Hi Shantur,

On Wed, 15 Nov 2023 at 05:59, Shantur Rathore <i@shantur.com> wrote:
>
> Hi all,
>
> I am facing an issue with bootflow where grub efi crashes only when
> bootflow is selected manually.
>
> Board - RockPro64
> OS - Armbian Bookworm CLI
> U-boot : 2024.01-rc2
> Built and installed in SPI
> Boot Device = USB drive connected to USB 2.0 port
>
> Success scenario :
>
> => setenv boot_targets usb
> => setenv bootmeths efi
> => bootflow scan -lb
>
> Grub loads and Linux boots
> Full Log - https://pastebin.com/KUFtUcha
>
> Failure scenario
> Full Log : https://pastebin.com/GHyG2NDz
>
> > setenv boot_targets usb
> => setenv bootmeths efi
> => bootflow scan
> => bootflow list
> Showing all bootflows
> Seq Method State Uclass Part Name Filename
> --- ----------- ------ -------- ---- ------------------------ ----------------
> 0 efi ready usb_mass_ 1 usb_mass_storage.lun0.boo efi/boot/bootaa64.efi
> --- ----------- ------ -------- ---- ------------------------ ----------------
> (1 bootflow, 1 valid)
> => bootflow select 0
> => bootflow boot
> ** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi
>
> Loading Linux 6.1.50-current-rockchip64 ...
> Loading initial ramdisk ...
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services...
> "Synchronous Abort" handler, esr 0x96000044, far 0x300905a65
> elr: 000000000022d634 lr : 0000000000208e14 (reloc)
> elr: 00000000f3f47634 lr : 00000000f3f22e14
> x0 : 0000000300905a4d x1 : 0000000000000000
> x2 : 0000000000000000 x3 : 000000000207fff0
> x4 : 00000000f3fd6470 x5 : 000000000207fff0
> x6 : 0000ffff00000004 x7 : 00000000f1f9fad0
> x8 : 7f7f7f7f7f7f7f7f x9 : 000000000000d02c
> x10: 00000000f1efee8c x11: 000000000000d020
> x12: 00000000f1efef88 x13: 00000000ad400000
> x14: 00000000f1efef2c x15: 00000000f1eff057
> x16: 00000000f3f21fc0 x17: 00000000d017a1d0
> x18: 00000000f1f11d70 x19: 00000000f1f21eb0
> x20: 0000000000000000 x21: 00000000f1f27b80
> x22: 0000000000000000 x23: 0000000000000000
> x24: 0000000000000000 x25: 00000000f3fc9ed7
> x26: 00000000b0c36000 x27: 00000000f02cd000
> x28: 00000000f03a210c x29: 00000000f1efee20
>
> Code: f9400860 eb06001f 540004e0 f9400c66 (f9000c06)
> UEFI image [0x00000000f0da4000:0x00000000f0dbbfff] '/efi\boot\fbaa64.efi'
> UEFI image [0x00000000f0386000:0x00000000f07adfff] '/\EFI\debian\grubaa64.efi'
> UEFI image [0x00000000af4e0000:0x00000000b11dffff]
> Resetting CPU ...
>
> resetting ...
>
> I am unable to figure out what is the difference between the 2 ways of booting.
>
> Thanks for your help.

Thank you for the detailed report. Can you try series [1] in
particular patch [2]

It has been sitting around for quite a while, unfortunately.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=381851
[2] https://patchwork.ozlabs.org/project/uboot/patch/20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid/
