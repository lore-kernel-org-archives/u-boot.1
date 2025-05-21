Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BCBC3ABC9
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D43182EB8;
	Wed, 21 May 2025 14:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IM8gxTlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C6F82E31; Wed, 21 May 2025 13:43:10 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764AE82E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 13:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-54d98aa5981so9924156e87.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747827788; x=1748432588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E3B+4H37ggD2LAjllrY/evp4zE1lv6ZUPIkQXGEyIEY=;
 b=IM8gxTlWSXJgHdWPmQ7uOZJFK5Y4dPcQeO3U8K2lmNafThxWJMPB1HG9Kv+5QpihNV
 o4beGkJAzr5/2VFQeq9pB900sOMA00IAKN9T/2uxNN3106c2/xcwpeLg5uods1kLs2Ag
 Bb5/GOk0cmjY+QTzifICcyO/grh256WSoYZ5UH1Lc+vGHK21no0KfhctpWnvIozEeXM+
 Fi6gY2GJuH1YlG+0BIy6qjAXQjJQig8Fcv1crUxOij1meVfd/NjiPPSTnTnXtcHYXvD6
 WA5s2dLP+cUFHUYJXhfksN78AN12NRj48sFfJFWuTmDv7S6U4xgPyqtYwlEMV/Z9Ac7z
 9JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747827788; x=1748432588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3B+4H37ggD2LAjllrY/evp4zE1lv6ZUPIkQXGEyIEY=;
 b=LmubhexAvvuBx4evW7v7z/OLQ7Z3wx2oQ9Vyc9usjGsCFNzwftbst3jR8afBWs+36p
 DNbyYIWRal5l0HY1CsFn35sUFwkzwaXkKqX/zNd2quZokeq090WYRn2OfiNGR+r1V6UQ
 X333MwC11mojX/L735ob+IzHvLfGh0khvPrGkznETeNprzblVvuTT//NkIPrspWCdWSS
 QMSNRk3tjebrxJr/AjxkPu+NOZ66CUTxCh+pNEa2FTlB2DmY3pO8Yy0kTG9ag1qt6JRK
 T/ZCQHiMlKRGAWNGkEBglu6BhEPMiH0QzTnW6qeDR2d1/mhxfX0faqfgNz6beg1G8O9m
 eSPQ==
X-Gm-Message-State: AOJu0Yy6L1DgjvVJPkN1Ekd54Q8PJ90IUu5H3Idh2R97eOgYU/u5Sb48
 8LltvodZ7usog8RqTvuvoB3hYyL0DYyPeS5pGpA2HEeaPcsy0pL+vD9/LiG2HIiJ9eE=
X-Gm-Gg: ASbGncvErAdQfHmb7yGs9/G3gldEbqfypXvEEAZ8pHkzJeBlgPjpWyv9KIWM9m4dYxQ
 wBA2H973yq7QeL/CjPP364MlHkpIkTk7m3Bx+25SdmdRIocPJnhmvgsDu2BF9uRkbNsvN0mtsTC
 hI/+yYcLCHR/XUEAtli5hLb2SMQG4a+kU1jOSkH+m/aEEl5BartCpWGHIeVPuOe8npunkz/Lrzc
 CQa2TxaaRqLjq/jIrqeq+I37pXYxr9yWsTXJytlJD6PWSVtSG4XMgveTS2nmj5vTSQeweLaGrnZ
 S68C7Fn/Lnj7WP5moUqUwsn7LnuLvCZuogh6tM/ONxOiPXu/GFpUTLQoYiTQECA6aX/96JX5Dgy
 67g0=
X-Google-Smtp-Source: AGHT+IFHERDsOqKIDiNNcHMaMsJmKjXzzb6IRsM64q7L+hcnpjy6p4umc9VBf1l1iYvDtDgSqteTWA==
X-Received: by 2002:ac2:4e07:0:b0:54f:c6b0:4c71 with SMTP id
 2adb3069b0e04-550e71983e4mr6693963e87.10.1747827787653; 
 Wed, 21 May 2025 04:43:07 -0700 (PDT)
Received: from nuoska (85-76-8-228-nat.elisa-mobile.fi. [85.76.8.228])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550eb6c7155sm2597252e87.22.2025.05.21.04.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 04:43:07 -0700 (PDT)
Date: Wed, 21 May 2025 12:43:04 +0100
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Mark Kettenis <kettenis@openbsd.org>
Subject: Re: QEMU & KVM broken for arm64
Message-ID: <aC28SFgTkLjamG-f@nuoska>
References: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
 <CAC_iWjK4U9KEdYkkkKb2TB4p+VJFU3DVFLK8fUg0druZpiZ4tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjK4U9KEdYkkkKb2TB4p+VJFU3DVFLK8fUg0druZpiZ4tQ@mail.gmail.com>
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:46 +0200
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

Hi,

On Wed, May 21, 2025 at 12:08:19PM +0300, Ilias Apalodimas wrote:
> ++CC Mikko who stumbled upon it
> 
> On Wed, 21 May 2025 at 12:07, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > Starting from commit 53d5a221632e  ("emulation: Use bloblist to hold
> > tables") I can't boot U-Boot with QEMU (version 8.2.2) & KVM anymore.
> > The command line to reproduce it is:
> > qemu-system-aarch64 -smp 2 -nographic -cpu host -m 4096 -accel kvm
> > -bios u-boot.bin -machine virt,secure=off
> >
> > commit 24768a23a9b3 ("emulation: fdt: Relax condition for
> > OF_HAS_PRIOR_STAGE") boots fine.
> >
> > Simon do you have an arm64 host to reproduce this?

Since full revert is hard, a simple config changes on top
of 2024.04 fixes this:

--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_BLOBLIST_SIZE_RELOC=0x2000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
@@ -27,7 +26,7 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
-CONFIG_BLOBLIST=y
+# CONFIG_BLOBLIST is not set
 CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y

So should users apply this as config snippet or patch if they plan to
boot with qemu and kvm?

I'm using yocto and genericarm64 machine target to build on native
aarch64 and then run the resulting u-boot and kernel+initrd+rootfs
from wic image using:

$ sudo /home/builder/src/base/repo/poky/build_genericarm64/tmp/work/aarch64-linux/qemu-helper-native/1.0/recipe-sysroot-native/usr/bin/qemu-system-aarch64 -device virtio-net-pci,netdev=net0,mac=52:54:00:12:35:02 -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22,hostfwd=tcp:127.0.0.1:2323-:23,tftp=/home/builder/src/base/repo/poky/build_genericarm64/tmp/deploy/images/genericarm64 -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 -drive id=root,file=/home/builder/src/base/repo/poky/build_genericarm64/tmp/deploy/images/genericarm64/core-image-base-genericarm64.rootfs.wic,if=none,format=raw -device virtio-blk-pci,drive=root   -machine virt,secure=off -cpu host -accel kvm -m 256 -serial mon:stdio -serial null -nographic -vga none -bios /home/builder/src/base/repo/poky/build_genericarm64/tmp/deploy/images/genericarm64/u-boot.bin

(sudo due to not being in kvm group yet)

Cheers,

-Mikko
