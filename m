Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28664C36008
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B094A805C3;
	Mon, 24 Mar 2025 18:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p0s3QpXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82F0806FC; Mon, 24 Mar 2025 18:40:30 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B43D80548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso2843653f8f.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742838028; x=1743442828;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZSyX4xxsqqwmlaPfwAlqH7A/w6mGPJ+ekuv3TZBjju4=;
 b=p0s3QpXztpfNoOxUpTxeQV+RLRe3KQC5baJu7t0fpS3bOBNDIbCdp/fJAlomlTomqP
 Zwxvz0OROno0p2OWk5/nTR2RLWWzwolQ7t5zHDyJfv90BuEoF5nK2jaHjdPqVWPhT5Ug
 RSrBi4molA9jUZkh+LebwX3KsbSUUbNrdNrQ9i18lt/aJfuonErwJNb8g64vbPMftWaH
 iXrfC7PDzqVzUvtbMIqaJm9qvTC9i1U66iu5ylCZ3UqljUzIJPNYmdH3OdpYIkCHwcx9
 xyYVr7VZExA6iyVRgExtGplh+LIYmIjoNri0rLAhMzi+ZbO8rtNT252eWYD0xDd9lWgm
 UUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742838028; x=1743442828;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSyX4xxsqqwmlaPfwAlqH7A/w6mGPJ+ekuv3TZBjju4=;
 b=BDhvsdsXO3XkgSaGk0X5SYxo6auwE44qiuq5ED4z+tePoTNxT4hS7kHkA+ayLZ0zYZ
 O5Z56O3KN0WESLFSQKHkRl/dZmPCcEUg4TffpHIfaQ46T/YIoFN9K/eX2ce1t5Q4FOd6
 QaASk2kHz9NtMQq6NbhcG2kT+mbxlsfT+qXx4yqZIgTiH8iRfJHZAGk4H7kequTjdQLx
 4Rm0gy4EIg3/KHF3WHy3eWbP/Kx09pztYp645RKy1U5hxIKQYeEfnFSP1eBvXOH4q/Qc
 dXu0bndvyHQQa+aey2qr/LOuzSRlvNlCpGkFxeEzJqBrWBMdiG0hVfzwuGyVt4+mBrCX
 RdOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWafmW9dT05SDM+MBVG7kPHtIZd1NC8oq1Dph/f3qtAxBAF8fOmv0L3Qm/53wvhNDkxbksGp5w=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/QsNdsWETHnQON+Ny00EeJ6CP3AsuMxhWNoFfgy3rXb2jW9ki
 uXJoRv2zOfSnDxPDAJpAeBjQRTdVK/VdTYEgGLmQdtCRwqamp5029auKD9BStmI=
X-Gm-Gg: ASbGnct3HxPqKJfP31E2Gm3zTZo1LIh/I6Jvw9qIlKTpojdv6iaJPp+h+3KDSre3wzk
 NZPLM9Vi829Sb0OPCUvDljqlCmHBLlcE/5TaOEGT/mugpXOEK+IPw08KjNkvOJyy9mFGXqaAx7V
 4z70BVXxYY8AlhOyuOlzA/ELskopWQlbytfUv/T93brENhJOfon8HaMLKVYLBFNYEsriqVwvcRt
 CAoGimn4jyKSbTzHuXiwXUZ/sTD7+dIzQNJCvSg6UB4l+t8UVkJmCz1Q2zIRQXRNJtaFaPxfwl1
 wzE6xrBxsfBuGgNgZqcI2koDs9/oAcQiWI128UdV5/QQtWcy223nWQ==
X-Google-Smtp-Source: AGHT+IEz8LpcdhsTrKJvJU+S34c3NYFNJ5jEi0HYJJxBIpv4Ek3ntpCcS8rO5omhH1cl+VRg/or5bw==
X-Received: by 2002:a5d:5f96:0:b0:390:fd7c:98be with SMTP id
 ffacd0b85a97d-3997f8fa411mr12327176f8f.19.1742838027883; 
 Mon, 24 Mar 2025 10:40:27 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65f0sm11621501f8f.74.2025.03.24.10.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:40:27 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: usb:composite: data abort on second ums launch
In-Reply-To: <CA+GyqeaFbV3BM-1YFW4iJ3nYSL5jXfRS+_Gg7AEUg9d1yxjSjA@mail.gmail.com>
References: <CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com>
 <72987a42-4e5b-4b53-a5de-2c654e129c43@denx.de>
 <87v7rypcoy.fsf@baylibre.com>
 <CA+GyqeaFbV3BM-1YFW4iJ3nYSL5jXfRS+_Gg7AEUg9d1yxjSjA@mail.gmail.com>
Date: Mon, 24 Mar 2025 18:40:26 +0100
Message-ID: <87sen2pbsl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Zixun,

On lun., mars 24, 2025 at 18:33, Zixun LI <admin@hifiphile.com> wrote:

> On Mon, Mar 24, 2025 at 6:21=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>> I've tried to reproduce this on master (2025.04-rc4-g244e61fbb7f5) and I
>> don't reproduce this with the VIM3 board using khadas-vim3_android_ab_de=
fconfig:
>>
>> I'll try to understand why it's behaving differently between the
>> sam9x60-curiosity and the vim3.
>
> Thank you for your test, I think it's because VIM3 is a large SoC with
> plenty of RAM
> (SYS_MALLOC_LEN=3D0x08000000) while SAM9X60 is much smaller
> (SYS_MALLOC_LEN=3D0x81000).

You are right, I've applied the following diff:

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3=
_android_ab_defconfig
index a078c5d363ae..c8d1cc69f1fb 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYS_BOARD=3D"vim3"
 CONFIG_SYS_CONFIG_NAME=3D"khadas-vim3_android"
 CONFIG_ARCH_MESON=3Dy
 CONFIG_TEXT_BASE=3D0x01000000
-CONFIG_SYS_MALLOC_LEN=3D0x08000000
+CONFIG_SYS_MALLOC_LEN=3D0x81000
 CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000

And with this, I can reproduce the issue you have reported:

U-Boot 2025.04-rc4-g0eeeeabb7cb1 (Mar 24 2025 - 18:37:26 +0100) khadas-vim3

Model: Khadas VIM3
SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
DRAM:  2 GiB (effective 3.8 GiB)
Core:  407 devices, 36 uclasses, devicetree: separate
MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
Loading Environment from MMC... MMC Device -1 not found
*** Warning - No MMC card found, using default environment

In:    usbkbd,serial
Out:   vidconsole,serial
Err:   vidconsole,serial
Net:   eth0: ethernet@ff3f0000

Hit any key to stop autoboot:  0
=3D> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
|crq->brequest:0x0
CTRL+C - Operation aborted
=3D> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
"Synchronous Abort" handler, esr 0x96000004, far 0xfffffffff2ea40f0
elr: 000000000102ddf4 lr : 000000000105c828 (reloc)
elr: 00000000f2f34df4 lr : 00000000f2f63828
x0 : 0000000100000000 x1 : 0000000100000000
x2 : 0000000000000000 x3 : fffffffff2ea40e0
x4 : 00000000f2fca1b8 x5 : 00000000f2ea40e0
x6 : 00000000f2fca1c8 x7 : 00000000f2ee6780
x8 : 000000000000003f x9 : 0000000000000004
x10: 0000000000000058 x11: 00000000000058c4
x12: 0000000000000000 x13: 00000000f2e62800
x14: 00000000f4ec0040 x15: 0000000000000000
x16: 00000000f2f63684 x17: 0000000000c0c0c0
x18: 00000000f2e75e00 x19: 00000000f2ea4010
x20: 00000000fffffff4 x21: 00000000f2e9d500
x22: 00000000f2ea40f0 x23: 00000000f2ea4050
x24: 00000000f2f62ebc x25: 00000000f2fd0000
x26: 00000000f2ea1cd0 x27: 0000000000000000
x28: 0000000000000000 x29: 00000000f2e62290

Code: d00004a6 910720c6 cb000063 8b000021 (f9400860)
Resetting CPU ...

resetting ...

>
> Each time when ums is called 2*FSG_BUFLEN, 256kB buffer is allocated
> and it seems not
> freed as fsg_common_release() is not called.
>
> Zixun
