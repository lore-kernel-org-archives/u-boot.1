Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FE1C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 22:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFF687D43;
	Fri, 21 Jun 2024 00:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hYG+ZUOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3616A87DDF; Fri, 21 Jun 2024 00:10:39 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA4887D40
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so14000281fa.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718921436; x=1719526236; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icVxbAtrLzbWgne5PXK2DmIo0H1bTUwrEfVX/YORqwQ=;
 b=hYG+ZUOsXeVsSUDc93al9H5zL5PTOjPQT2A7AKkndS1K2LjK9T6ALs+zqTQA0IDbQ7
 zFKMytEYIVwdSiHeCX5HnUEvDZLXiitMYuFLdqlhn/DfsXLLrskj8CxncwitCtmpqtuk
 ROti+4H4lf5tglNjafnVjI9neQK9q1zaFfSzTDR6kP5x8JAZX99Pr29QMWA1+bmNJyRN
 tLiDemk1/P81kFVRWVV2IFIQkMrPLzg2als4a5pp97wHbJ9sRTkCUDLAHxUZ6v/mEawM
 yV/qgVqiMF09loi+3XDHGxiAFd/26R7jNbRSXjYODoeMwIQjPXdKNoT8foWbzOl9aHsO
 5ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718921436; x=1719526236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=icVxbAtrLzbWgne5PXK2DmIo0H1bTUwrEfVX/YORqwQ=;
 b=WOKY7pf6/3Lkb47FhyEB7Te7zZ0ABrLkt5E1F3GE4pu2gKXCA0Cvj7dD3mtOpCiGqZ
 Lvyjqah0HNRa5+t8Mg3YY4HdR3qq5/a4Q7bIC7+Z/Edx7nO0VfPhyqDCh9axljlYl8I9
 T0PURY4dhHGEnPBsckxG5AuAyQb8oxuwXQ5G7g0UnbWUy4IR3wXcHimWE2EfM/o1OzB5
 bRDu9FaPcJk8kYYrSnrbRrL/e12eTLin8ayDyXX0wIhN0hqeMFkWHPoAL6Fv2E4nDfMn
 G9lMb3kHqIR5ysy6wdIhay7UEQHrIaPKaVDYEb+TnAqjMF6iekkGT+D64vTtzjwJHN+J
 cgGw==
X-Gm-Message-State: AOJu0YzLvBkdigDN6XP8Oh9mEvHLu5sXPCPDsf6gS74z0Ab0IdEfbzvz
 ysVuGtl3wmJac2jAofQD+JiD0DakdiuXpqkS022puHVlemaGdmKJwutZIR2iOiTk1M58LLFtDAf
 O4T0UXo2ZI2MSbnbZ2+O6DxzThkSvYoD+630=
X-Google-Smtp-Source: AGHT+IH7foOPpo0ocL950kl3LlXIj/WZM14G8+MPMpiPilQOJhmcadJOm3D8z68pG0VGDgmebl5Gremx3cNtg415T0Q=
X-Received: by 2002:a2e:9805:0:b0:2eb:dc13:2d6b with SMTP id
 38308e7fff4ca-2ec3ce93f0fmr39928651fa.13.1718921435443; Thu, 20 Jun 2024
 15:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
In-Reply-To: <20240620213539.ftmjhphypssxp5n4@desolate>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 23:10:24 +0100
Message-ID: <CALeDE9OF5Eqqk5PgTZUUi7r-1ApC7HhoxUMELQRWLXVJzuPOew@mail.gmail.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
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

Thanks for starting this conversation.

> We have briefly discussed this topic on IRC[1]. I would like to
> propose a new boot-firmware repository similar to the Linux-firmware
> repository under the aegis of u-boot hosting.
>
> In addition to TI, it looks like some NXP[2] and Rockchip[3]
> platforms seem to require additional closed-source/open-source
> binaries to have a complete bootable image. Distribution rights and
> locations of these binaries are challenging, and there needs to be a
> standard for how and where they are hosted for end users.

Yes, it's been painful for some time, and often the distribution is
unclear because often the binaries are copies around between SBC
makers often without the other bits such as licenses etc so it's a
case of "who knows =C2=AF\_(=E3=83=84)_/=C2=AF" even if it's the same for a=
ll devices of
a particular SoC.

Having a process around licensing and redistribution requirements is useful=
.

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

I don't believe this makes sense. linux-firmware is designed for
firmware that is loaded by linunx drivers, these are not, they're
generally used a part of early boot firmware prior to the linux kernel
even booting, and could in fact be any other OS. As it is
linux-firmware is 2Gb+ in size, as a maintainer of that package in
Fedora having to determine which of 1000s of firmware is used by linux
or something else or if we need to ship it is hard enough already
without throwing a whole raft of other FW into the mix. I think a
separate repo is the right way to go here please.

> 3. Host a boot-firmware repository - u-boot repo may be the more
>   logical location.
>
> * (1) isn't the correct answer.
>
> * (2) Though I haven't seen any policy from the Linux-firmware
>   community mandating anything of the form, the binaries we are talking

my understanding is the policy is that it's firmware required by linux driv=
ers.

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
> * Limit binaries only to those that do not have an opensource project
>   (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
>   source or are binary only in nature (subject to licensing terms below)
> * Limit binaries to some pre-established size to prevent repository
>   explosion - say, 512Kib?

Not sure that makes sense, if a FW is needed by a device to boot it
doesn't make sense to exclude it based on some arbitrary size

> * Follow the same rules of integration and licensing guidelines as
>   Linux-firmware[6].
> * Similar rules as Linux-firmware guidelines of ABI backward and
>   forward compatibility.
> * Set a workflow update flow and a compatibility requirements document

* needs to come from the vendor (there's been issues with
linux-firmware where people try and post firmware that might not be
redistributable)
* need to be freely redistributable
* needs something similar to the liniux-firmware whence file etc.
* The new linux-firmware PR automation etc is quite good

> If we agree to have boot firmware under the stewardship of u-boot, we
> should also set other rules, which is excellent to discuss.

I think that's a good start, I think we should be open to expansion.

> Thoughts?
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
