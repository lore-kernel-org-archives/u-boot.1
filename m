Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E819E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 04:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7FAE89040;
	Fri,  6 Dec 2024 05:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IAeCJPP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22E4892FB; Fri,  6 Dec 2024 05:25:28 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA1E881FD
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 05:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6efea3c9e6eso417087b3.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 20:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733459125; x=1734063925; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lSVGrK2bUaeZW3Zts4bfJLuHJH/pJrbBPd5+jdV6bjc=;
 b=IAeCJPP67CL1F7JskMjv3O9AH/KFtBOP2zaSbRQgIGCxk3KQO9SgRGkyDFtXdJpZnB
 lDdPvdcI6ueFU9T3Br0YIEex09jX7+5wZ/F5FvzuJpD6lpHHpEJi7Sw6aURC6TFPlA+K
 +urGldg3jfF1oPWwzKmSI+bpcDuU+tfvGN/ERFGigeXfD1e1dWLJ1OoXtPpJbHwA2IYX
 d1ahoUYOA5SDgq71qVTz0YdENO95EjNE5nNll+CIOIp+uhKiZ0FPpP50MUaPMPGoPBRF
 BvH3XrMIM4LE731dcZiUFhmob9E0xEFotfTHxVxfRjwFPNOce+Np0lx8ELC3GNfzIsB4
 ysCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733459125; x=1734063925;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSVGrK2bUaeZW3Zts4bfJLuHJH/pJrbBPd5+jdV6bjc=;
 b=H8kwI0MCCOkfRuq4b3MdgQQ4ufvcrNs+ruyjKK2/bzXSRui+YPAVb0hmFxN2ViipfX
 3+7Pec0Pujq74r0FmUM3E9u2XV3Agum1O1O64Wq9lh2OBumhy4vkdDabCGFGYmONOghB
 wkoad/zZiKloFa4ttrib1kJr/Tj1ariW3avV4UGQ4TdpZ5XAxxdXfXTUwPj/XFI4RY9o
 aTdF74Gm1PKE47G97auyMkpQVRbZ6HvSCbvRHaKiP1My0W3fTsGc6lVoaxU36rIkdexR
 Ka5d8Cvzle0wu60BfuLR4ylVnQg1nP2wZA7fp/bABFOSAuxoYHRATuvWGuS2m7HqLso6
 Tskg==
X-Gm-Message-State: AOJu0YwbQgWttp6uBNTeW9hXfOt460OZxmF2aGNZEgrhyRWrySGki2Bn
 S+U1S5e4TKwDNUpjDKiS+9I9WwbsnBuBcOjDF5Ms8CdZWxvgUuml9VgqvbQ5oOGgZnpnzRvTuv2
 xae3POY7b/MRuE/V7NGQumS9otidq3C7RBzrlGA==
X-Gm-Gg: ASbGncv16F8QX67Wnvm82gO4wND0S1tl1PPn+vJ8k7a+MSkS0DZN1z9HWbTRwKXn/lJ
 I1wO1oXdst8EEiubFdruamQHMEE5n8fA=
X-Google-Smtp-Source: AGHT+IFjpuZcExPxmrYy0/IXxl4Zxc6GOWWsEyCw89aYSrnMH8swHtfnBeR4b/4kx8B8oGhLAOff5Uix7x7iGCtNEKI=
X-Received: by 2002:a05:690c:62c8:b0:6ef:522a:1c28 with SMTP id
 00721157ae682-6efe3caa78cmr25790327b3.35.1733459124955; Thu, 05 Dec 2024
 20:25:24 -0800 (PST)
MIME-Version: 1.0
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 5 Dec 2024 22:25:14 -0600
Message-ID: <CAPLW+4=qP6pCN0xd9n3U5jBePJk2jEKgixCs1A_uBaDTwFLT4g@mail.gmail.com>
Subject: [REGRESSION] lmb: add and reserve memory above ram_top
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
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

Hi Sughosh,

Commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
causes a regression on the E850-96 board. It looks like it could be
not E850-96 specific though. During U-Boot boot (the most recent
master branch, with this commit present), before U-Boot shell appears,
I observe the next error message, which doesn't happen before this
patch:

    ERROR: reserving fdt memory region failed (addr=f0000000
size=200000 flags=4)

The memory node [1] is defined like this in the E850-96 dts:

    memory@80000000 {
        device_type = "memory";
        reg = <0x0 0x80000000 0x3ab00000>,
                 <0x0 0xc0000000 0x40000000>,
                 <0x8 0x80000000 0x80000000>;
    };

And the reserved-memory node [2] has only one entry:

    ramoops@f0000000 {
        reg = <0x0 0xf0000000 0x200000>;
        ...
    };

Here is the relevant part of 'bdinfo' output:

    lmb_dump_all:
     memory.count = 0x3
     memory[0]      [0x80000000-0xbaafffff], 0x3ab00000 bytes, flags: none
     memory[1]      [0xc0000000-0xffffffff], 0x40000000 bytes, flags: none
     memory[2]      [0x880000000-0x8ffffffff], 0x80000000 bytes, flags: none
     reserved.count = 0x4
     reserved[0]    [0xb922d000-0xb922ffff], 0x3000 bytes, flags:
no-notify, no-overwrite
     reserved[1]    [0xb9230e10-0xbaafffff], 0x18cf1f0 bytes, flags:
no-overwrite
     reserved[2]    [0xc0000000-0xffffffff], 0x40000000 bytes, flags:
no-overwrite
     reserved[3]    [0x880000000-0x8ffffffff], 0x80000000 bytes,
flags: no-overwrite

The same error also occurs when I'm trying to boot Linux with 'booti' command:

    Working FDT set to 8a000000
    ERROR: reserving fdt memory region failed (addr=f0000000
size=200000 flags=4)
       Loading Device Tree to 00000000b912a000, end 00000000b922cfff ... OK

Although I think the device tree portion above is valid, I also tried
to cleanup the 'memory' and 'reserved-memory' nodes like this, to see
if that was going to help working around the issue:

    memory@80000000 {
        device_type = "memory";
        reg = <0x0 0x80000000 0x80000000>,
                 <0x8 0x80000000 0x80000000>;
    };

    reserved-memory {
        ...
        secure_reserved: secure-os@bab00000 {
            reg = <0x0 0xbab00000 0x5500000>;
            no-map;
        };

        ramoops@f0000000 {
            reg = <0x0 0xf0000000 0x200000>;
            ...
        };
    };

It made the first error message (during the U-Boot boot) go away, but
the later errors (when trying to boot the kernel) still persist. Here
is the relevant 'bdinfo' output with my dts change above applied:

    lmb_dump_all:
     memory.count = 0x2
     memory[0]      [0x80000000-0xffffffff], 0x80000000 bytes, flags: none
     memory[1]      [0x880000000-0x8ffffffff], 0x80000000 bytes, flags: none
     reserved.count = 0x5
     reserved[0]    [0xbab00000-0xbfffffff], 0x5500000 bytes, flags: no-map
     reserved[1]    [0xf0000000-0xf01fffff], 0x200000 bytes, flags: no-overwrite
     reserved[2]    [0xfe72d000-0xfe72ffff], 0x3000 bytes, flags:
no-notify, no-overwrite
     reserved[3]    [0xfe730dd0-0xffffffff], 0x18cf230 bytes, flags:
no-overwrite
     reserved[4]    [0x880000000-0x8ffffffff], 0x80000000 bytes,
flags: no-overwrite

The error messages I'm observing after issuing the 'booti' command are
as follows:

    ERROR: reserving fdt memory region failed (addr=bab00000
size=5500000 flags=2)
    ERROR: reserving fdt memory region failed (addr=f0000000
size=200000 flags=4)

It looks like all mentioned error messages are harmless, in a way that
I'm still able to boot Linux, and U-Boot reserved areas still seem to
exist in 'bdinfo'. But seeing error messages like that is definitely a
nuisance by itself, and might be an indicator of some actual issues.
Do you have any remedy for that by chance? Please let me know if you
need more debug input from my side.

Thanks!

[1] https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/exynos/exynos850-e850-96.dts#L55
[2] https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/exynos/exynos850-e850-96.dts#L144
