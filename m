Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2787DC83F0C
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 01:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFA986AF8;
	Sat, 26 Aug 2023 03:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ES4LhtFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC06B86AFE; Sat, 26 Aug 2023 03:06:36 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD2586AE8
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 03:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-64f444fe7a7so12025486d6.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 18:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693011992; x=1693616792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0vPBdf+PQ+CHqi1pRqexDOmKxp04S2I0Sj6mIxmFJKs=;
 b=ES4LhtFrh07jPLtAJtZH8tfwZHf753RYCt9POPZFPy6vA2qJFexUzITws0scvvRwa7
 Js3+nY96IgrFGOINIUX9BGEFnrxL84OU5yi02nnobSRAYS1SU+iz8FunantZX7VbbJnL
 zklKPVYmcRtrLidfrN9R96kJ/6quWQ0hdcBoMWlsPqG9kdWUWs77gfosLzJ2mYwjusBj
 TIcuzo58P6t5GwcQa33+B4o9VcRRqygWxYDBVfhvVCq3po1ZPzwzDII7rP0xXjaim0d4
 P6fQbeOq6EeJaJ5fERNOx8olDP+7L8ch3JmafwECXyqFQ/NeUfRepsKiKylzziP/uKYh
 tDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693011992; x=1693616792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vPBdf+PQ+CHqi1pRqexDOmKxp04S2I0Sj6mIxmFJKs=;
 b=aHTjq+nWJaZigYyQHEcA0+87izm/+uP6yFCkG+ECeSQn8R5qdMP+zHkXHEQbK8Ivqw
 +rlcFpBOujT3Qqcid0U5c6ZcDKq+qgBCGIbq11No0wGZzGaGHgGCCVVhgYO0a6qo16PN
 pAdAGtmThRMTO/4AW8NnxITTDK/jFCOnxjHbvHVa+qUKinb2nT5EQ8zeHnS1I/4gJFwU
 mgtu4GYDaNfWrCQyHazk6ti3GfvujlYEiSGbDfE7BE2lf3L4IR17aDR6/QHRx8WDEsDd
 DFS/fWIJX4uiVW/GoDmeD+p9d9BJxM9dbVlVQNc0HyoOroPL6ed4dS5XNxcOCEAuY5gW
 ZnSw==
X-Gm-Message-State: AOJu0Yys3QAK3kEFY+tF7OwfKWDBi6oRmKPjZDITK6ylqpnLasYocxyM
 tmBjV2dW5uWc5t+ypNmPfkk5qFWDbnrIg5bDNsI=
X-Google-Smtp-Source: AGHT+IHqcO3XZnsFx3ov4ssVxM8ZeOvN42xe9oJo+J2+0ppCAErbrFxGu62ZTiE+NUtJgn6ARuVuFYUF4phOaY5lGqs=
X-Received: by 2002:a0c:e246:0:b0:647:2653:bcc with SMTP id
 x6-20020a0ce246000000b0064726530bccmr23795187qvl.13.1693011992501; Fri, 25
 Aug 2023 18:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
 <20230825012224.ydk4332yb4qodrdb@unfazed>
 <CAPnjgZ0BFt_jZxnazWSd05PYj79VszpcUQ0De84SVu0GgF6BhA@mail.gmail.com>
 <20230825015931.fkx7jx4sqxdr7cqe@directly>
 <CAPnjgZ1uzjhTPNhfE1NR2Boq-M_kABTrA=19xy0s9nSsXWWU0A@mail.gmail.com>
In-Reply-To: <CAPnjgZ1uzjhTPNhfE1NR2Boq-M_kABTrA=19xy0s9nSsXWWU0A@mail.gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 25 Aug 2023 20:06:06 -0500
Message-ID: <CAOCHtYgObufq4YKNFbn50Xk1VUmF4+_mFid9M9=JHVLwrmvBFw@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Simon Glass <sjg@google.com>
Cc: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, 
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Vignesh <vigneshr@ti.com>, 
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

> > Just https://etcher.balena.io/ and flash an SD card with the official
> > image here: https://www.beagleboard.org/distros/beagleplay-debian-11-flasher
> >
> > https://files.beagle.cc/file/beagleboard-public-2021/images/am625x-emmc-flasher-debian-11.6-xfce-arm64-2023-02-04-10gb.img.xz
>
> OK I tried that on an SD card, but it is still bricked.
>

Hi Simon,

I've found the bootrom can be a little too quick and you'll get stuck
on a failed eMMC bootloader.

I find it best, with power applied, if you hold both the USR and RESET
buttons down, then lift off the RESET button.. This will ensure the
bootrom/sysboot will actually load the microSD's version of u-boot.

If it's still failing, please grab this newer small August release:

That's posted here:
https://forum.beagleboard.org/t/arm64-debian-11-x-bullseye-monthly-snapshots-2023-08-05/32318
 (updated monthly)

Specifically this flasher file:
https://rcn-ee.com/rootfs/release/2023-08-05/bullseye-minimal-arm64/beagleplay-emmc-flasher-debian-11.7-minimal-arm64-2023-08-05-4gb.img.xz

Use Balena Etcher to write it directly to a microSD.

Insert microSD in
Apply Power (leds should turn on, if not hit the PWR button to wake up
the TPS...)
Next, hold both USR and RESET buttons
Now, Lift off only the RESET button
When even more leds turn on, lift up on the USR button.

At this point the serial should be loading/booting linux, and then
running the eMMC flasher in single user mode.  Within 5 minutes or so,
it should shutdown with a new image in the eMMC..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
