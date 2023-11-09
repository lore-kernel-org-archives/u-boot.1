Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31381C41535
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 08:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA1C87063;
	Thu,  9 Nov 2023 09:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KcZlOPxU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F4387101; Thu,  9 Nov 2023 09:41:38 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C44787063
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 09:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso4014345e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 00:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699519292; x=1700124092;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JlFeqU/pELCEwVkxm9QUlj3X3Uc2/UhgV+POn5E8/Ms=;
 b=KcZlOPxUuflbUDeN5x1ZXxjUOS2ytirR7/9za0+tNdO8JcgYv7a6lDNXKzIMF5dkI9
 5yu2JFiU/UBPxRQaABRc+fOwFGC8c57vDC4vbEIu5QDhQplY8Xz8LqBIsY6wYNNfZsu9
 pZLKzz8dBHncBzgdOgvowKFyaZXJq6cfHGseYt2igObZZu10CIwrV7nIWi/dBDEQTM5E
 wOcT0USzQDDN2dY598hnZ0pb1wxAjwBUYvTFyJQAeD/49Wu3EWeR4Dfbtfu7NVzmyYPM
 sxBBLD2ZknNJJkhwKHJHSgmlIcDJyXGGKFPoXbxP1Atux0XoxdW8RYy3GwzbNKHPnd0y
 pcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699519292; x=1700124092;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JlFeqU/pELCEwVkxm9QUlj3X3Uc2/UhgV+POn5E8/Ms=;
 b=pMq8XwAqufY+2Ir3VxSgyBvf+cFxyxlv7s0VrS+Xm/TWW6JqBYsVtDkLFVU6QaWQHK
 VcozUO/QJkkqv+CCsVCmzSWwYCuKFwY8/o4lEKt9dt8d+dvdwJlnrTkeEarcMAeKbS8z
 iKV4kYMmprRF1awbq3r0N+MXXICLz5Ap0mnVrr6MF6xxYIidmMVFd6SAQqZK+NzpBS0H
 BONUxh/+PH783uWvlwIpRZKjc4+ihII7BPjRNudkIe9+eeQ9KfzC7mon65ScNlIcvt1W
 RyfzDxjIL1TV94oyL7WKAUnWtsi6ToQy6JEI/SwHLcTYaPGMv321vbaFj6ePft0mQKic
 5isA==
X-Gm-Message-State: AOJu0YwJOIK15VBNTW2DV6N+ylieHPXSb+DDjqQkviM3SGaX93+RZT5y
 eklsey3Cq7r9hk/M0eQyN2RwHA==
X-Google-Smtp-Source: AGHT+IE41r9/B8J33FuVSPUtZVDKR1NEIEZd+3QJEpAIoX6kuxRDM5yzp7vnl8dE1d396psYutMv9g==
X-Received: by 2002:a05:600c:4fd4:b0:405:499a:7fc1 with SMTP id
 o20-20020a05600c4fd400b00405499a7fc1mr3711725wmq.40.1699519292086; 
 Thu, 09 Nov 2023 00:41:32 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 gy15-20020a05600c880f00b004064741f855sm1331879wmb.47.2023.11.09.00.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 00:41:31 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>, Heiko
 Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Implement fastboot multiresponce
In-Reply-To: <20231107124241.35432-1-clamor95@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
Date: Thu, 09 Nov 2023 09:41:30 +0100
Message-ID: <87cywj9v45.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Svyatoslav, Ion,

Thank you for these series.

On mar., nov. 07, 2023 at 14:42, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Currently u-boot fastboot can only send one message back to host,
> so if there is a need to print more than one line messages must be
> kept sending until all the required data is obtained. This behavior
> can be adjusted using multiresponce ability (getting multiple lines
> of response) proposed in this patch set.
>
> Implementation of multiresponce leads to ability to dump content of
> console buffer which, with use of "oem run", allows to entirely avoid
> need in UART.

I'm happy to fastboot getvar all implemented since it's standardly
supported on Android phones.

fastboot oem console seems like a nice debug tool as well when no
console is available.

I do have some concerns with the series, mainly because the introduction
of the "MORE" byte response.
"MORE" is not part of the fastboot specification [1].

However, that specification documents "TEXT", which, per my
understanding, should allow to send multiple responses as well.

Could we implement this using "TEXT" instead ?

[1] https://android.googlesource.com/platform/system/core/+/master/fastboot/#transport-and-framing

>
> Ion Agorria (5):
>   fastboot: multiresponse support
>   fastboot: implement "getvar all"
>   commonn: console: introduce overflow and isempty calls
>   lib: membuff: fix readline not returning line in case of overflow
>   fastboot: add oem console command support
>
>  boot/bootmeth_extlinux.c          |  2 +-
>  common/console.c                  | 17 +++++--
>  doc/android/fastboot-protocol.rst |  3 ++
>  doc/android/fastboot.rst          |  1 +
>  drivers/fastboot/Kconfig          |  7 +++
>  drivers/fastboot/fb_command.c     | 52 +++++++++++++++++++++
>  drivers/fastboot/fb_getvar.c      | 75 +++++++++++++++++++++++++------
>  drivers/usb/gadget/f_fastboot.c   | 29 ++++++++++++
>  include/console.h                 | 14 ++++++
>  include/fastboot-internal.h       |  7 +++
>  include/fastboot.h                |  9 ++++
>  include/membuff.h                 |  5 ++-
>  lib/membuff.c                     |  4 +-
>  net/fastboot_udp.c                | 25 ++++++++---
>  test/ut.c                         |  9 ++--
>  15 files changed, 226 insertions(+), 33 deletions(-)
>
> -- 
> 2.40.1
