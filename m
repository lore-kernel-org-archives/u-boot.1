Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCAEC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9734871CD;
	Wed, 15 Nov 2023 13:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="iyLmrtGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E1F871D0; Wed, 15 Nov 2023 13:59:26 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3C2286689
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9e2838bcb5eso990123066b.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700053163; x=1700657963;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eAqadM9xU00Hp6GoZdazXNpMExQ02szGWlh+zbqIag4=;
 b=iyLmrtGIdkSIz3tyOSrG1UUssJ8r/ifoyVAoQZ1gAX6MIMYf1BHOxKGITf7WGCNOzX
 /bUGn0XqGL5XsoDPynqYJ/O9b+NDr+mM97b94+iNOUXPBTGmhipStG2R1xYh02DIB91U
 srj5RbFH/ZC3XhOgKUhRnjNz7BZwjW82EXIXZ5i7rZ6lfGIDkUmUqqvqk0HSg03cRRup
 pSjnf1KqvvsWMST04BzqbA34SZkMC2e9XFtGbvHvHHK+0kymXIvBfkDVSZmnbYVENJZr
 TOg8gmigSwzr60NdtEPUq1BK8mKg7yYRNXVHlxjqPPgyi4NesrNXHiVvNec5AXDVhuI/
 JqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700053163; x=1700657963;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eAqadM9xU00Hp6GoZdazXNpMExQ02szGWlh+zbqIag4=;
 b=XOlKekU34r4l8jz17yHXTnvXMelBArm11SJX6UyNJRGmSgkT8NlU+oJQLtTIobjRz3
 vYVyqQGxYBvXBdxOL5YcHOAdTgMYWTTD79M/AVqbUIHbkrIjaWpgfevJwwD9uuMkr7dO
 9uwazhhuChIM7xF7hwjy82cOmzK+EJEJhVwoqbRn4SqImOnL3E52RmqKimPQeFPc1kwY
 RgR+hqVarxHC5hhHvabHxu6HNGY4nQO0uI81xvlwIL8OoANP4lJ0ts7OL8q8aZB+3ypH
 ajaAJRRwgu8Jdvt1ZHUO90erMhW/ceUHm4UisQocqhD3oMgg008WabzRzlUqNS+GaNiI
 CW9Q==
X-Gm-Message-State: AOJu0Yz2HLIh9BimTzY2b+QkFpPQW6S6fZ7czJZMLpRJ+uBYWOgXbXSG
 BVxPlmi9EHli51BI5gmeI2wxaagUxdAUE6Z3Q1CDlw==
X-Google-Smtp-Source: AGHT+IHzJKjRzQcmkukFVMSuDXlhia7RaI2MbCdJL/kopW+h7gXnhVHwEpYTpUVBlIPS1Yzpkj5+vQ==
X-Received: by 2002:a17:906:7149:b0:9da:f391:409a with SMTP id
 z9-20020a170906714900b009daf391409amr10487725ejj.26.1700053162855; 
 Wed, 15 Nov 2023 04:59:22 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 m22-20020a170906235600b009e6279fc1d6sm6955653eja.40.2023.11.15.04.59.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 04:59:22 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so10313706a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:59:22 -0800 (PST)
X-Received: by 2002:a05:6402:3451:b0:543:714b:535d with SMTP id
 l17-20020a056402345100b00543714b535dmr9593827edc.3.1700053162124; Wed, 15 Nov
 2023 04:59:22 -0800 (PST)
MIME-Version: 1.0
From: Shantur Rathore <i@shantur.com>
Date: Wed, 15 Nov 2023 12:59:11 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
Message-ID: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
Subject: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: u-boot@lists.denx.de
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

Hi all,

I am facing an issue with bootflow where grub efi crashes only when
bootflow is selected manually.

Board - RockPro64
OS - Armbian Bookworm CLI
U-boot : 2024.01-rc2
Built and installed in SPI
Boot Device = USB drive connected to USB 2.0 port

Success scenario :

=> setenv boot_targets usb
=> setenv bootmeths efi
=> bootflow scan -lb

Grub loads and Linux boots
Full Log - https://pastebin.com/KUFtUcha

Failure scenario
Full Log : https://pastebin.com/GHyG2NDz

> setenv boot_targets usb
=> setenv bootmeths efi
=> bootflow scan
=> bootflow list
Showing all bootflows
Seq Method State Uclass Part Name Filename
--- ----------- ------ -------- ---- ------------------------ ----------------
0 efi ready usb_mass_ 1 usb_mass_storage.lun0.boo efi/boot/bootaa64.efi
--- ----------- ------ -------- ---- ------------------------ ----------------
(1 bootflow, 1 valid)
=> bootflow select 0
=> bootflow boot
** Booting bootflow 'usb_mass_storage.lun0.bootdev.part_1' with efi

Loading Linux 6.1.50-current-rockchip64 ...
Loading initial ramdisk ...
EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
"Synchronous Abort" handler, esr 0x96000044, far 0x300905a65
elr: 000000000022d634 lr : 0000000000208e14 (reloc)
elr: 00000000f3f47634 lr : 00000000f3f22e14
x0 : 0000000300905a4d x1 : 0000000000000000
x2 : 0000000000000000 x3 : 000000000207fff0
x4 : 00000000f3fd6470 x5 : 000000000207fff0
x6 : 0000ffff00000004 x7 : 00000000f1f9fad0
x8 : 7f7f7f7f7f7f7f7f x9 : 000000000000d02c
x10: 00000000f1efee8c x11: 000000000000d020
x12: 00000000f1efef88 x13: 00000000ad400000
x14: 00000000f1efef2c x15: 00000000f1eff057
x16: 00000000f3f21fc0 x17: 00000000d017a1d0
x18: 00000000f1f11d70 x19: 00000000f1f21eb0
x20: 0000000000000000 x21: 00000000f1f27b80
x22: 0000000000000000 x23: 0000000000000000
x24: 0000000000000000 x25: 00000000f3fc9ed7
x26: 00000000b0c36000 x27: 00000000f02cd000
x28: 00000000f03a210c x29: 00000000f1efee20

Code: f9400860 eb06001f 540004e0 f9400c66 (f9000c06)
UEFI image [0x00000000f0da4000:0x00000000f0dbbfff] '/efi\boot\fbaa64.efi'
UEFI image [0x00000000f0386000:0x00000000f07adfff] '/\EFI\debian\grubaa64.efi'
UEFI image [0x00000000af4e0000:0x00000000b11dffff]
Resetting CPU ...

resetting ...

I am unable to figure out what is the difference between the 2 ways of booting.

Thanks for your help.

Regards,
Shantur
