Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3331CC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A8688569;
	Fri, 21 Jun 2024 01:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W6AgrOI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BDB88405; Fri, 21 Jun 2024 01:05:43 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96346884C6
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6fa11ac8695so817954a34.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924739; x=1719529539; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrBgtQcjOMPwpnnmr0UTyZGH0umMUV/kPnEcdQImiEU=;
 b=W6AgrOI+rFoKtBanL2Y2We/obVYmobrrULMgz/kPrpTaK2TAvRW51FODKBGYW68YOr
 YhcbVghbJzLPu8GkeSXx+cz9/m4qHmySfP75q9BoHQP/M3qoocQSCuR3g473wUN9NTvi
 jxFEQhrHWTo3J6m1gtIGVJJG3lhCHfbmg32tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924739; x=1719529539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrBgtQcjOMPwpnnmr0UTyZGH0umMUV/kPnEcdQImiEU=;
 b=EFpg8IbttCV3TBSqnW6B0lt/z6Z6xsMb2QXEtwr8UL3LfN/MUvB5JH10Df7kgAuiJs
 g2PCat3Is3soFX4mG+vJALozoLe0EkXC+/KvlB2/ao23llOFzsNQmXNwYNUC0g/vU3DH
 y729Mm1GPuJ2zXUpXSnVtcHBEi3JZ+f6mbpWz0EXaqPcS77iSdpEeb7HWQoSlLHInkIv
 5d45X0N2Bw8gb9FcH4h4JTkfQmmC3/zJTD2tpv+R4ScfxIKhznchXjRWPJ4QFgUciLoZ
 wbMP2g+gBKbfaXreYtGaW2MapOZUriv2Hm1MeOcq6EsZVXWNBEWqxfqtULYjlcDBoqnQ
 D6CA==
X-Gm-Message-State: AOJu0Yz0HUeGeIKkVdJONEPJyTZbKSN09ITrFOm2S/dY7yfS737Im3O/
 2CvMOPPxNsr9Mhe3/xMHw42CGO4/J8f3CmQv+5xuHcgJITVYr1LogiP5ocXyx6hLBhWCSAo194W
 B/67mMSrtIfe66cEhaebNazfwqSbOjMPgbNif
X-Google-Smtp-Source: AGHT+IHw23W0iewrK3DVqa8OqZUBfgnBKD+Y8CWUGsBjLDoJH4C8nkdY51KAfqapPXxjgC2+BdYbEM/V0t8bEzrMCoE=
X-Received: by 2002:a9d:6e82:0:b0:6f9:d808:6d14 with SMTP id
 46e09a7af769-70075a77c3amr7006334a34.35.1718924739264; Thu, 20 Jun 2024
 16:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
In-Reply-To: <20240620213539.ftmjhphypssxp5n4@desolate>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Jun 2024 17:05:28 -0600
Message-ID: <CAFLszTjhqUA4if6mzt-CNxZA6sHB5sHCXTVHVsOPdag0mXzpnA@mail.gmail.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Josh Boyer <jwboyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Nishanth,

On Thu, 20 Jun 2024 at 15:35, Nishanth Menon <nm@ti.com> wrote:
>
> Hi Team,
>
> We have briefly discussed this topic on IRC[1]. I would like to
> propose a new boot-firmware repository similar to the Linux-firmware
> repository under the aegis of u-boot hosting.
>
> In addition to TI, it looks like some NXP[2] and Rockchip[3]
> platforms seem to require additional closed-source/open-source
> binaries to have a complete bootable image. Distribution rights and
> locations of these binaries are challenging, and there needs to be a
> standard for how and where they are hosted for end users.
>
> Further, looking ahead to future architectures:
> * IP firmware: More and more IP vendors are embedding their own
>   "specialized controllers" and require firmware for the operation
>   (similar to Rockchip's DDR controller, I guess),
> * boot stage firmware: Additional stages of the boot process involve
>   vendor intermediate firmware, such as power configuration.
> * Security enclave binaries: While I see a few folks trying to have an
>   open-source s/w architecture, many PKA and PQC systems still require
>   prop binaries for IP reasons.
>
> NOTE: I am not judging any company(including TI) for reasons why some
> firmware is proprietary, but I hate to have the end users and other
> system (distro) maintainers have to deal with hell trying to make the
> life of end users easy to live with.
>
> In the case of TI's K3 architecture devices, we have two binary blobs
> that are critical for the boot process.
>
> 1. TIFS Firmware / DMSC firmware[4]=E2=80=94This is the security enclave
>   firmware. It is often encrypted, and sources are not public (due to
>   various business/regulatory reasons).
> 2. DM Firmware[5] - There is a source in public in some cases and
>   binary only in others - essentially limited function binary to be
>   put up in the device management uC. In cases where the source is
>   available, the build procedure is, in my personal opinion, pretty
>   arcane, and even though in theory it is practical, in practice, not
>   friendly - efforts are going to simplify it, even probably integrate
>   it with a more opensource ecosystem, but that is talking "look at the
>   tea leaves" stuff.
> 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
>   binary that gives the tifs system context restore logic before
>   retrieving tifs firmware and a corresponding DM restoration binary.
>
> All told, this is not unlike the situation that necessitated the
> creation of a Linux firmware repository.
>
> Options that I see:
>
> 1. Let the status quo be - SoC vendors maintain random locations and
>   random rules to maintain boot firmware.
> 2. Ask Linux-firmware to host the binaries in a single canonical
>   location
> 3. Host a boot-firmware repository - u-boot repo may be the more
>   logical location.
>
> * (1) isn't the correct answer.
>
> * (2) Though I haven't seen any policy from the Linux-firmware
>   community mandating anything of the form, the binaries we are talking
>   of may not belong to Linux-firmware as they aren't strictly speaking
>   something Linux kernel will load (since the bootloader has that
>   responsibility), and in some cases may not even directly talk to
>   (security enclave or DDR firmware stuff). I am adding Josh to this
>   mail to see if he has any opinions on the topic (but keeping
>   from cross posting on linux-firmware list, unless folks feel it is
>   OK).
>
> On (3):
> Proposal:
>
> * Create a boot firmware repository in Denx and/or GitHub (if
>   financials are a hurdle, I hope we can solve it as a community).
> * Limit binaries only to those consumed part of the u-boot scope.
>
> * Limit binaries only to those that do not have an opensource project
>   (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
>   source or are binary only in nature (subject to licensing terms below)
> * Limit binaries to some pre-established size to prevent repository
>   explosion - say, 512Kib?
> * Follow the same rules of integration and licensing guidelines as
>   Linux-firmware[6].
> * Similar rules as Linux-firmware guidelines of ABI backward and
>   forward compatibility.
> * Set a workflow update flow and a compatibility requirements document
>
> If we agree to have boot firmware under the stewardship of u-boot, we
> should also set other rules, which is excellent to discuss.
>
> Thoughts?

I suggest:

4) Add a 'binman blob' subcommand which can fetch blobs, similarly to
how 'binman tool -f xxx' features a tool, using the image description
to know what is needed and some configuration for where to find it /
how to build it.

That way we can actually build working images and test them, without
user intervention / guesswork.

IMO the actual repo is not the ultimate goal here. Building and
testing should be the ultimate goal.

>
> [1] https://libera.irclog.whitequark.org/u-boot/2024-06-13#36498796;
> [2] https://docs.nxp.com/bundle/AN14093/page/topics/build_the_u-boot.html
> [3] https://bbs.t-firefly.com/forum.php?mod=3Dviewthread&tid=3D2236
> [4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-=
sysfw?h=3Dti-linux-firmware
> [5] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-=
dm?h=3Dti-linux-firmware
> [6] https://docs.kernel.org/next/driver-api/firmware/firmware-usage-guide=
lines.html
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D

Regards,
SImon
