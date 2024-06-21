Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3492C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 07:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0421880A5;
	Fri, 21 Jun 2024 09:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GR/aJ0pg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15738880A3; Fri, 21 Jun 2024 09:35:26 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D363880A5
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 09:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d331cc9feso217098a12.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718955323; x=1719560123; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Idqyj4dkrGNauNGP5ksMOgN0IK9cetkmJm/t5H1cs9U=;
 b=GR/aJ0pgfRaVelzgMckfh98pw1F72i21vbCdbLL4yvmzEU0b+HK5hqu60KA4Eig9oN
 alKjN938yJBh5SASUwx1daY9PRbIDiY9iBbZTqNMFLchcf3A4B7xR6saLWvK4nCjTuWK
 2HKBd+QG3fYFSLtGUXqT71XeFbBy3e1jATtV0cLg4mTEaVFZ/aIGPEnIkfoqWt8oXaYT
 2PECDyPwVViIO/L9HWV+9t7NFvWkQ50sn3ql6QYY0ko7xVCvX3Oja8DcfOf0f/z9kggQ
 4yBtd3IXFrFAcmD81kt6rfyBq9hUgKDR+BzpQu9484oh69VQ+roYDVV51wK0CHgw62FS
 ayXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718955323; x=1719560123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Idqyj4dkrGNauNGP5ksMOgN0IK9cetkmJm/t5H1cs9U=;
 b=rQILViBzu78qK/bxSaLlff3/SAd4oxS76EQMxaziUcybqC+jIozD0jDJTvcBWggziH
 tBg11+EtWgFUjIQ6BWC16iCel9vFfmIkDZ98b8wZevkfCpdwTuaq01zrcE+mzZFx9knV
 7+hJdmbFabqvope/Bm7oSM6eAL3Tuaac6o0QERvAIt+jPPq43GbsH4XE7n+nxd6PmUCf
 3UOSbsCpGG2DiTh6pW/IY+9W68xfLQpzX7LQGIoV1lpMSzI+05odVH6Rb+cpSqGoMtPL
 XkDDfLxbKIR3nGah0Pk8aQ4Ypyxovr16otuubPD263nZcR0OgWz0bcmK328u4zUD+pqK
 2jTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU645kbzGlNmbvOXsY9MIDU1psyccIQYYLYtklGIdrLuwT/cNZjXh4CbfRlqJK0zAfYDpXpflflz+KOyjlb0iaGpodRlQ==
X-Gm-Message-State: AOJu0Yz8vwKF6pBCCR0XT+KL3Lxv8C0kyQOkAyP6vraGYBPnS8dUOZwI
 PwMI24isHE5BdwGw14yj7uXQO42EOQzMnzzhA/2JHWqcVbXTf6O8N8aMsDDo3Rc6Cw/lb7ohHc6
 ya+zw6zpPv3v/FBrwwwBu6/I9IY4=
X-Google-Smtp-Source: AGHT+IEDZJ1eK12hQ82IJ3FqiRZxKMho05ocSqzypaRoIyxp7D4/3PCASP9e66gofb2fFCORRSEBmAJRpjrBSQjq6QY=
X-Received: by 2002:a50:9fcb:0:b0:57c:70b0:d541 with SMTP id
 4fb4d7f45d1cf-57d07e6bd08mr4741332a12.20.1718955322646; Fri, 21 Jun 2024
 00:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <CAFLszTjhqUA4if6mzt-CNxZA6sHB5sHCXTVHVsOPdag0mXzpnA@mail.gmail.com>
In-Reply-To: <CAFLszTjhqUA4if6mzt-CNxZA6sHB5sHCXTVHVsOPdag0mXzpnA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 21 Jun 2024 08:35:11 +0100
Message-ID: <CALeDE9NWwUeDL2-GpVx5_Br5u9aL36UMmOEVqv+PXYF1X1xOqQ@mail.gmail.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Simon Glass <sjg@chromium.org>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
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

On Fri, 21 Jun 2024 at 00:05, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Nishanth,
>
> On Thu, 20 Jun 2024 at 15:35, Nishanth Menon <nm@ti.com> wrote:
> >
> > Hi Team,
> >
> > We have briefly discussed this topic on IRC[1]. I would like to
> > propose a new boot-firmware repository similar to the Linux-firmware
> > repository under the aegis of u-boot hosting.
> >
> > In addition to TI, it looks like some NXP[2] and Rockchip[3]
> > platforms seem to require additional closed-source/open-source
> > binaries to have a complete bootable image. Distribution rights and
> > locations of these binaries are challenging, and there needs to be a
> > standard for how and where they are hosted for end users.
> >
> > Further, looking ahead to future architectures:
> > * IP firmware: More and more IP vendors are embedding their own
> >   "specialized controllers" and require firmware for the operation
> >   (similar to Rockchip's DDR controller, I guess),
> > * boot stage firmware: Additional stages of the boot process involve
> >   vendor intermediate firmware, such as power configuration.
> > * Security enclave binaries: While I see a few folks trying to have an
> >   open-source s/w architecture, many PKA and PQC systems still require
> >   prop binaries for IP reasons.
> >
> > NOTE: I am not judging any company(including TI) for reasons why some
> > firmware is proprietary, but I hate to have the end users and other
> > system (distro) maintainers have to deal with hell trying to make the
> > life of end users easy to live with.
> >
> > In the case of TI's K3 architecture devices, we have two binary blobs
> > that are critical for the boot process.
> >
> > 1. TIFS Firmware / DMSC firmware[4]=E2=80=94This is the security enclav=
e
> >   firmware. It is often encrypted, and sources are not public (due to
> >   various business/regulatory reasons).
> > 2. DM Firmware[5] - There is a source in public in some cases and
> >   binary only in others - essentially limited function binary to be
> >   put up in the device management uC. In cases where the source is
> >   available, the build procedure is, in my personal opinion, pretty
> >   arcane, and even though in theory it is practical, in practice, not
> >   friendly - efforts are going to simplify it, even probably integrate
> >   it with a more opensource ecosystem, but that is talking "look at the
> >   tea leaves" stuff.
> > 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
> >   binary that gives the tifs system context restore logic before
> >   retrieving tifs firmware and a corresponding DM restoration binary.
> >
> > All told, this is not unlike the situation that necessitated the
> > creation of a Linux firmware repository.
> >
> > Options that I see:
> >
> > 1. Let the status quo be - SoC vendors maintain random locations and
> >   random rules to maintain boot firmware.
> > 2. Ask Linux-firmware to host the binaries in a single canonical
> >   location
> > 3. Host a boot-firmware repository - u-boot repo may be the more
> >   logical location.
> >
> > * (1) isn't the correct answer.
> >
> > * (2) Though I haven't seen any policy from the Linux-firmware
> >   community mandating anything of the form, the binaries we are talking
> >   of may not belong to Linux-firmware as they aren't strictly speaking
> >   something Linux kernel will load (since the bootloader has that
> >   responsibility), and in some cases may not even directly talk to
> >   (security enclave or DDR firmware stuff). I am adding Josh to this
> >   mail to see if he has any opinions on the topic (but keeping
> >   from cross posting on linux-firmware list, unless folks feel it is
> >   OK).
> >
> > On (3):
> > Proposal:
> >
> > * Create a boot firmware repository in Denx and/or GitHub (if
> >   financials are a hurdle, I hope we can solve it as a community).
> > * Limit binaries only to those consumed part of the u-boot scope.
> >
> > * Limit binaries only to those that do not have an opensource project
> >   (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
> >   source or are binary only in nature (subject to licensing terms below=
)
> > * Limit binaries to some pre-established size to prevent repository
> >   explosion - say, 512Kib?
> > * Follow the same rules of integration and licensing guidelines as
> >   Linux-firmware[6].
> > * Similar rules as Linux-firmware guidelines of ABI backward and
> >   forward compatibility.
> > * Set a workflow update flow and a compatibility requirements document
> >
> > If we agree to have boot firmware under the stewardship of u-boot, we
> > should also set other rules, which is excellent to discuss.
> >
> > Thoughts?
>
> I suggest:
>
> 4) Add a 'binman blob' subcommand which can fetch blobs, similarly to
> how 'binman tool -f xxx' features a tool, using the image description
> to know what is needed and some configuration for where to find it /
> how to build it.

This is a solving a different problem IMO. Also most distros build in
constrained environments so pulling FW randomly with a tool in the
build process won't work. Also most users won't want to pull the
latest each time they build, most vendors will choose a static set of
versions and only bump to deal with bugs, CVEs or explicit features
they need rather than having a series of moving targets.

Well the whole point of the repo is to remove the guesswork, it would
be a set of firmware that is expected to work in a single location.

> IMO the actual repo is not the ultimate goal here. Building and
> testing should be the ultimate goal.

I disagree, the repo would assist working and tested firmware because
there could be a review/test process as part of it to ensure things
work and are tested to give users a good experience rather than having
to search the web and forum posts to attempt to find pieces that work
together.

> >
> > [1] https://libera.irclog.whitequark.org/u-boot/2024-06-13#36498796;
> > [2] https://docs.nxp.com/bundle/AN14093/page/topics/build_the_u-boot.ht=
ml
> > [3] https://bbs.t-firefly.com/forum.php?mod=3Dviewthread&tid=3D2236
> > [4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/t=
i-sysfw?h=3Dti-linux-firmware
> > [5] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/t=
i-dm?h=3Dti-linux-firmware
> > [6] https://docs.kernel.org/next/driver-api/firmware/firmware-usage-gui=
delines.html
> > --
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 =
DDB5 849D 1736 249D
>
> Regards,
> SImon
