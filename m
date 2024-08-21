Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC9AC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6F5988A74;
	Wed, 21 Aug 2024 04:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WoUa6rge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D1588A64; Wed, 21 Aug 2024 04:10:47 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D60E88A74
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf42a563c8so34017196d6.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206244; x=1724811044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOf8jINUElXJrgd3V7RpyrQxxI8WVwWBCggnM6Zu8WA=;
 b=WoUa6rgeSYS8QizZPaA8YYR0U93aa9FyCciiNRTXxH7gBMzteIAiSHl5eqQPfhGqr8
 0QKOBWGqE80Iw9wRDT7eryGDVbSs8FKyi2b1K/ARheE2cK4Zr7sWTaY6CCqNefiDQcgJ
 ypG2ZSWKhmc/1He2BeFUtTG5ApW1B2Qr0uctQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206244; x=1724811044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOf8jINUElXJrgd3V7RpyrQxxI8WVwWBCggnM6Zu8WA=;
 b=KWVhZFUmrJ5mu8sNUcXwtgyhd2Ao2AFL4A+0Niqdb+KTiS+BNjrngZSsi2OGwEVIR0
 AliCIqHEMoe0mZg/pOjjD+sqjFEPI4h2O1SQEfhc7wG4Jm6lcXY3LE2k1lVK2HYBAkJo
 TLs8qEPmzv3XABTLVc4jwdYjZIkCsu0Huk7fej4DOtYxRzabk05FfvPJVYr3BFRVr+UW
 /OR37gj+yH5Bqqfx+NoIZBWo6IUnakqBm1uc7BIqC4RN1P/RBPg3OxTP6o1ggqHmVA1U
 s+7pJLXWDQqyv+L2JRSenF4eUIzfU3gRWgQQaXZM0N+75vb0RZpKKnhseEfz2wURAi4/
 vK6g==
X-Gm-Message-State: AOJu0YxbOqXxpN/D8pTViiCJ9q3PN/m8rHFO0UDxalYaYiHoq3WJE1E+
 kjSx6SVSiEgdCcY0YBWlmU4bGAdKAUchB2N6HugKt2/gLYq+12hrf/Zs8f+zUi0p6mjr9CH00Ur
 MxduXgZimNXoiJvmoH+ELKAzUMwRZxx7J8heoarWxdSR73xE=
X-Google-Smtp-Source: AGHT+IGSLIeQZxh7Eeu9v8BCMA8ndzxfuOjHzoRlJfqJZtkHM7doP9l5upyvcdMrZyztmHR+oVY8TeEdWS+Z3RivozA=
X-Received: by 2002:a05:6214:3992:b0:6bf:8bf8:658d with SMTP id
 6a1803df08f44-6c155e1ef05mr11742526d6.54.1724206244298; Tue, 20 Aug 2024
 19:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
In-Reply-To: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:10:33 -0600
Message-ID: <CAFLszTh==U4_km3EQgNoqaDAK5uWXAAcj01Wd8B1U7CR31XH3g@mail.gmail.com>
Subject: Re: u-boot on raspberry pi with secure boot
To: Jonas Kvinge <jonaski@opensuse.org>
Cc: u-boot@lists.denx.de
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

Hi Jonas,

On Mon, 19 Aug 2024 at 07:11, Jonas Kvinge <jonaski@opensuse.org> wrote:
>
> Hi,
>
> I have a custom installation of openSUSE Tumbleweed which uses u-boot
> and Grub.
> To use secure boot on the RPI, one creates a boot.img containing the
> kernel and other files which is signed, and the eeprom is locked to
> only allow booting with this signature.
> (https://github.com/raspberrypi/usbboot/blob/master/secure-boot-recovery/README.md
> ).
> Since I'm using u-boot, I'm creating a boot.img containing u-boot.bin
> instead of the linux kernel and ramdisk.
> But then nothing is locking down which kernel can boot, since that's
> controller by UEFI and Grub. u-boot starts Grub from the UEFI
> partition, and Grub starts the kernel from a separate /boot partition.
> And I see no way to change this
> I use a 3 partition setup where the partitions are 1. FAT UEFI
> partition, 2. Linux ext4 /boot partition, 3. Encrypted LUKS ext4 root
> partition.
> I've been looking into
> https://trac.gateworks.com/wiki/secure_boot#SecuringtheKernelFDTramdiskviaFITimages
> But is that possible to do with my current setup? Can I include grub
> and the kernel/initrd in the boot.img and make u-boot use that instead
> of from the UEFI partition?

It's 'U-Boot', BTW.

I don't fully understand your situation, but you should be able to use
FIT as there is an EFI test for it - see
test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py

Note that RPI typically uses a private bootloader, so I'm not sure how
secure it can actually be.

Regards,
Simon
