Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B503DFF60ED
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0CE83F0A;
	Tue, 31 Mar 2026 10:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="ON8elqgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BEFC83F5B; Tue, 31 Mar 2026 10:50:09 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6262683E7A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c76b6f9a50eso79074a12.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774947003; cv=none;
 d=google.com; s=arc-20240605;
 b=dYO5w/9o3/HuSPsGL87luwIVa9bwLobaeXjFU+/6sASC17bChYWsnHWitnCwIv+iox
 AgCkCnIr5OJBHHkJ7Oa5xcsDDZlSSeD4QJi4L97V/e5wJmCcQr+nzzIyTKBqMzHwijuf
 FWhz8SMOIi/e9kjdUHeJYGl3Ne5W6qlwbfqAWHqS/HBvDQ7s91rLp127TWp5+IImN3x/
 XybeHOLji4yElZH6yfhaOTzVclLHMj3+3tj8Fpdy0EijVVRRp3i5Pp4wYeNp4WPvI0BO
 sc7NAx6FITUsa4CSs3afSKRLqGv0v3UHvjUf+6bndX1Ev3mRQXHly7B5JKTL8nA5oEHN
 CGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6aHK+odiI6LGEHGyxobyVUxV+IHAzcI6HMKvCWb1nJo=;
 fh=W1x0uTMIvGS5AsTgZqcvIAPG+pCgHeYTwhg5r90LtbM=;
 b=Vk+Qr4ieITW3sSBdh6XH/wWX6ypHJnXRVnKq9qK0Tmth9PivK0SkouZVfCP5YGPwjq
 ZwXygSVZ+s9bmaN8TIQsWXGXNxfuO2434wdAj21poQAT38mHwWOfpFxvx9cq//9NkFV2
 D5V+2OneYlY05CVGuY+TlKaqe97AJ1GVEv795n7ib2Hzazk+hpbT2ZPfy9thZcklYlph
 gJEwH10XqdLB1cy6k7ro1geE88UpucNQWdLft5uu+UH8M8zeRjJWlyRP6LxHOwO57+Yq
 15TO20SNBMBT2eucK092p17ema1Hsjr8KJfg82fS8acabnmbaa5WkzvHObXqPlYkgYZx
 pCaQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1774947003; x=1775551803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6aHK+odiI6LGEHGyxobyVUxV+IHAzcI6HMKvCWb1nJo=;
 b=ON8elqgvTs/YPi0SKkQAynA7decI43McycOKep0zN5qxuUj9gybcMuIbjS+OUa6URq
 dzCOd2QtPEfm6fr8Q8Lx/sFNR8sPYhNcaSGKTmsrEp6hKF78HERKt9i10LXl6hZSOl3l
 v4HfnEnUrUbyTLkeyqCk1QRXTwjtK6tQ2U4oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774947003; x=1775551803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aHK+odiI6LGEHGyxobyVUxV+IHAzcI6HMKvCWb1nJo=;
 b=C2CoBDGT7uE/bgYgN81VW3a8/fxH6+WDdqyFrVGmFC7cXrsC9JLCDwYr+h2X2UXmak
 dzURt68QN8n1wEAHnZtxfAjgwDDfFKpTkx3GMIAKe1s0Mwsn7RABchS3/rb1gjqBwHkM
 olbk05G9rjalT7NTBqqFEl73yCbTz7W9eAMk9BRagZ8Dt8dcvc89S7i19a9QmqTCbdOB
 xMUc2GMFr+wKd4U0l3w1yRsxjIQnZU6a2gXXsAqfyoEBrPSfO9jOWXul9U8ktuEoIJE2
 e3xchxPO+ZPtgWY/nVr1t0S+CiapWrPBVHNz4i4gNcP5VeNV2Y/en4Zu0ycKADt8crQg
 C80w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5p014VUTq3IdxNRCDVqTexit9GlhxfrR6+TIILLgPPxcbnRTrHrFxtgzKgVNAzKV4LPryDAo=@lists.denx.de
X-Gm-Message-State: AOJu0YxkgxqhbYsdknG86vFORPqgcGQvayjkApgRw6ZyANQxAZxH72CM
 xJAu0lZtHWLotTWyzokacVCTgkQlJXJ2DmcZUxO+1lqfx+trv/YiiIVWHay4AxWsFG8mhorFcib
 4xcEkOjYwEzz0SHwzmDWwmPorecc/Lutt8T4/DvXrfQ==
X-Gm-Gg: ATEYQzw1NdCAKRI9VGo4t1g2VDhyeAZ5IZzLNJlIU7145yjDEnk4/9UrRTk+TcZkFcG
 3JIKUZAMH8OGiNcGqR5h/p/5ak2M2TLWiAruwAg+eeMZ0kSCnIuF8c1bBd7kiuRa56TNZkxPirw
 Xavk8BfuxRh5cueDc5a6Mm7gvBMGy/H2SYEq5NuJCaU9ohLOt4uRNUiqPGJpaoA6/YQW+Bhr599
 6a0Dgjxv7hLxLlU9VVeVwIMankTWVFQsZ3djNqPBkIcWaeEN/eMgmGURYch9NyL5sbnpnvgkd4z
 QydWVUVvNvoihbatKbTGARbK0TmRvfbmVWjMUi/z
X-Received: by 2002:a05:6300:210c:b0:39b:e1e5:a101 with SMTP id
 adf61e73a8af0-39c87b5fe54mr13856778637.43.1774947003315; Tue, 31 Mar 2026
 01:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260330220124.2747127-1-daniel@thingy.jp>
 <b0e5de29-f7de-4dc1-be15-58a6039326ee@kernel-space.org>
In-Reply-To: <b0e5de29-f7de-4dc1-be15-58a6039326ee@kernel-space.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 31 Mar 2026 17:49:51 +0900
X-Gm-Features: AQROBzD6I-gLJykXs-ld-7xJNBpMd3BzsmzByRbJ1NXnMKaq5upu2mYLlcTVsts
Message-ID: <CAFr9PX=fVUGNgPnJGgU3sdwnNuNSWTp75Ny4DbAh1AoTpG+11g@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: Add LTO support
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: visitorckw@gmail.com, u-boot@lists.denx.de
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

Hi Angelo,

On Tue, 31 Mar 2026 at 16:37, Angelo Dureghello <angelo@kernel-space.org> wrote:
> > -DItype __ashldi3 (DItype u, word_type b)
> > +__used DItype __ashldi3 (DItype u, word_type b)
>
> Why the above __used is needed ? This impacts all the coldfire builds.
>

At least for normal m68k the final link will fail because GCC has
output references to the libgcc functions but LTO didn't think they
were needed and discarded them already (example below). So this
attribute is to tell GCC to keep them so the link completes. On
coldfire is this giving you code you didn't have before? I guess that
could be the case if coldfire doesn't need to emulate some things with
libgcc.

Cheers,

Daniel


Build with the "+__used DItype __ashldi3 (DItype u, word_type b)" hunk reverted:

daniel@kinako:~/coding/cleantrees/u-boot$ make
CROSS_COMPILE=m68k-linux-gnu- -j16
 UPD     include/generated/timestamp_autogenerated.h
 UPD     include/config/uboot.release
 UPD     include/generated/version_autogenerated.h
 LDS     u-boot.lds
 CC      arch/m68k/lib/ashldi3.o
 AR      arch/m68k/lib/lib.a
 CC      cmd/version.o
 CC      common/init/board_init.o
 CC      common/version.o
 AR      cmd/built-in.a
 AR      common/init/built-in.a
 AR      common/built-in.a
 KSL     keep-syms-lto.c
 KSLCC   keep-syms-lto.o
 LTO     u-boot
/usr/bin/m68k-linux-gnu-ld.bfd: /tmp/cciN6Tis.ltrans0.ltrans.o: in
function `board_init_f':
/home/daniel/coding/cleantrees/u-boot/common/board_f.c:213:(.text.board_init_f+0x3fc):
undefined reference to `__ashldi3'
/usr/bin/m68k-linux-gnu-ld.bfd:
/tmp/cciN6Tis.ltrans0.ltrans.o:/home/daniel/coding/cleantrees/u-boot/common/board_f.c:213:(.text.board_init_f+0x404):
undefined reference to `__ashldi3'
/usr/bin/m68k-linux-gnu-ld.bfd: /tmp/cciN6Tis.ltrans1.ltrans.o: in
function `virtio_uclass_child_pre_probe':
/home/daniel/coding/cleantrees/u-boot/include/virtio.h:463:(.text.virtio_uclass_child_pre_probe+0x114):
undefined reference to `__ashldi3'
/usr/bin/m68k-linux-gnu-ld.bfd: /tmp/cciN6Tis.ltrans1.ltrans.o: in
function `virtio_uclass_child_pre_probe':
/home/daniel/coding/cleantrees/u-boot/drivers/virtio/virtio-uclass.c:311:(.text.virtio_uclass_child_pre_probe+0x160):
undefined reference to `__ashldi3'
/usr/bin/m68k-linux-gnu-ld.bfd:
/home/daniel/coding/cleantrees/u-boot/drivers/virtio/virtio-uclass.c:321:(.text.virtio_uclass_child_pre_probe+0x1aa):
undefined reference to `__ashldi3'
/usr/bin/m68k-linux-gnu-ld.bfd:
/tmp/cciN6Tis.ltrans1.ltrans.o:/home/daniel/coding/cleantrees/u-boot/drivers/virtio/virtio_blk.c:82:
more undefined references to `__ashldi3' follow
collect2: error: ld returned 1 exit status
make: *** [Makefile:2096: u-boot] Error 1
