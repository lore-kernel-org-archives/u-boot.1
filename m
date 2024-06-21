Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F717C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6555588578;
	Fri, 21 Jun 2024 16:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m89Iygzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDFD88569; Fri, 21 Jun 2024 16:58:12 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 593E2880F1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-632bcf111ffso20972667b3.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981888; x=1719586688; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WI9jfBliMRc+r5+TwDi1CUMNpPM3llT5XKmdDJp7MzU=;
 b=m89Iygzfhruzid+lCmrWfao7tchKSfewrk9t99EHhVKev8uH2KhyEHcFPXq8012F19
 Imqn2a8PokqxylwtU6RbQhYz0wvGXBqUkEsgoTDcA6Z5grXe8E+D2RTUXRLlR20v63Ge
 F001+pLqf1hEbePChQIWcOZv6YwKsudTkMc+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981888; x=1719586688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WI9jfBliMRc+r5+TwDi1CUMNpPM3llT5XKmdDJp7MzU=;
 b=O9tEd6ce3aqsUfjCv8YDJ6GEs5ToRL75vOeJ4byeH07/0qD4fYODgxtW48tJN0rwaf
 E9ywqXDLr75A0nMHqZOjOB+eYuIuO+8p/qvJ/RbOdca3u5afBylE4/Ei2/Zra5kTlFaN
 DbuZOWV7EwA+l/LrNhC5KnL3Lvi2NNq2SAs8/oO7/7/ZK7Y7AaRWz7QSb5RtDs71h6Et
 ZZOPOtr8K1jz759MbKrWrzvjJqlfmkatE0mhrpHYyTGy2NC0uMw272/STc88buPRzo7m
 iYAm1mr6pS341gY3YxnWqfa9PDVL1jgse2VDqCbYl6peH3kpaWpIMqUzarFKIVOZ22TO
 P82w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTY6e7JJoO9UqmdTIKC3Y5i32nw+RhLl19+0sG1W1PEANvQZnIl7kIXEeGYehg2v5LKQPg+gk8uNOzWFtsHODHxcvdTg==
X-Gm-Message-State: AOJu0YwWKPXJXu5kB8/vNArghJF2etL7p+0AbwuHR4nVm26zqJDwGh0e
 ngPxZIHtYBlfW7v3tES6awEO+zrQZhwblsJGRl5h2V0OSSqBVm2yWRyRSw4PXgx1GQ5+33jGCMr
 2FPJHTRpBQk7l43rXhVwGHGAkaNhXmWWzq9LR
X-Google-Smtp-Source: AGHT+IGbRVtAfdIkqLEBPkKsghro35nFQw1Sa/yXCo0mbqpMQipyBGACeDyWjXSsvEpyFhSIQvNPVAXhUbQLqvbKQ2s=
X-Received: by 2002:a81:9144:0:b0:63b:d711:e722 with SMTP id
 00721157ae682-63bd711ee8cmr59001167b3.1.1718981888111; Fri, 21 Jun 2024
 07:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <CAFLszTjhqUA4if6mzt-CNxZA6sHB5sHCXTVHVsOPdag0mXzpnA@mail.gmail.com>
 <CALeDE9NWwUeDL2-GpVx5_Br5u9aL36UMmOEVqv+PXYF1X1xOqQ@mail.gmail.com>
In-Reply-To: <CALeDE9NWwUeDL2-GpVx5_Br5u9aL36UMmOEVqv+PXYF1X1xOqQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:57 -0600
Message-ID: <CAFLszTi5F0b2F6MP_K+Pno8WKvawPA40KasVsk+V0DJxBz=AeA@mail.gmail.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Peter Robinson <pbrobinson@gmail.com>
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

Hi Peter,

On Fri, 21 Jun 2024 at 01:35, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Fri, 21 Jun 2024 at 00:05, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Nishanth,
> >
> > On Thu, 20 Jun 2024 at 15:35, Nishanth Menon <nm@ti.com> wrote:
> > >
> > > Hi Team,
> > >
> > > We have briefly discussed this topic on IRC[1]. I would like to
> > > propose a new boot-firmware repository similar to the Linux-firmware
> > > repository under the aegis of u-boot hosting.
> > >
> > > In addition to TI, it looks like some NXP[2] and Rockchip[3]
> > > platforms seem to require additional closed-source/open-source
> > > binaries to have a complete bootable image. Distribution rights and
> > > locations of these binaries are challenging, and there needs to be a
> > > standard for how and where they are hosted for end users.
> > >
> > > Further, looking ahead to future architectures:
> > > * IP firmware: More and more IP vendors are embedding their own
> > >   "specialized controllers" and require firmware for the operation
> > >   (similar to Rockchip's DDR controller, I guess),
> > > * boot stage firmware: Additional stages of the boot process involve
> > >   vendor intermediate firmware, such as power configuration.
> > > * Security enclave binaries: While I see a few folks trying to have a=
n
> > >   open-source s/w architecture, many PKA and PQC systems still requir=
e
> > >   prop binaries for IP reasons.
> > >
> > > NOTE: I am not judging any company(including TI) for reasons why some
> > > firmware is proprietary, but I hate to have the end users and other
> > > system (distro) maintainers have to deal with hell trying to make the
> > > life of end users easy to live with.
> > >
> > > In the case of TI's K3 architecture devices, we have two binary blobs
> > > that are critical for the boot process.
> > >
> > > 1. TIFS Firmware / DMSC firmware[4]=E2=80=94This is the security encl=
ave
> > >   firmware. It is often encrypted, and sources are not public (due to
> > >   various business/regulatory reasons).
> > > 2. DM Firmware[5] - There is a source in public in some cases and
> > >   binary only in others - essentially limited function binary to be
> > >   put up in the device management uC. In cases where the source is
> > >   available, the build procedure is, in my personal opinion, pretty
> > >   arcane, and even though in theory it is practical, in practice, not
> > >   friendly - efforts are going to simplify it, even probably integrat=
e
> > >   it with a more opensource ecosystem, but that is talking "look at t=
he
> > >   tea leaves" stuff.
> > > 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
> > >   binary that gives the tifs system context restore logic before
> > >   retrieving tifs firmware and a corresponding DM restoration binary.
> > >
> > > All told, this is not unlike the situation that necessitated the
> > > creation of a Linux firmware repository.
> > >
> > > Options that I see:
> > >
> > > 1. Let the status quo be - SoC vendors maintain random locations and
> > >   random rules to maintain boot firmware.
> > > 2. Ask Linux-firmware to host the binaries in a single canonical
> > >   location
> > > 3. Host a boot-firmware repository - u-boot repo may be the more
> > >   logical location.
> > >
> > > * (1) isn't the correct answer.
> > >
> > > * (2) Though I haven't seen any policy from the Linux-firmware
> > >   community mandating anything of the form, the binaries we are talki=
ng
> > >   of may not belong to Linux-firmware as they aren't strictly speakin=
g
> > >   something Linux kernel will load (since the bootloader has that
> > >   responsibility), and in some cases may not even directly talk to
> > >   (security enclave or DDR firmware stuff). I am adding Josh to this
> > >   mail to see if he has any opinions on the topic (but keeping
> > >   from cross posting on linux-firmware list, unless folks feel it is
> > >   OK).
> > >
> > > On (3):
> > > Proposal:
> > >
> > > * Create a boot firmware repository in Denx and/or GitHub (if
> > >   financials are a hurdle, I hope we can solve it as a community).
> > > * Limit binaries only to those consumed part of the u-boot scope.
> > >
> > > * Limit binaries only to those that do not have an opensource project
> > >   (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
> > >   source or are binary only in nature (subject to licensing terms bel=
ow)
> > > * Limit binaries to some pre-established size to prevent repository
> > >   explosion - say, 512Kib?
> > > * Follow the same rules of integration and licensing guidelines as
> > >   Linux-firmware[6].
> > > * Similar rules as Linux-firmware guidelines of ABI backward and
> > >   forward compatibility.
> > > * Set a workflow update flow and a compatibility requirements documen=
t
> > >
> > > If we agree to have boot firmware under the stewardship of u-boot, we
> > > should also set other rules, which is excellent to discuss.
> > >
> > > Thoughts?
> >
> > I suggest:
> >
> > 4) Add a 'binman blob' subcommand which can fetch blobs, similarly to
> > how 'binman tool -f xxx' features a tool, using the image description
> > to know what is needed and some configuration for where to find it /
> > how to build it.
>
> This is a solving a different problem IMO. Also most distros build in
> constrained environments so pulling FW randomly with a tool in the
> build process won't work. Also most users won't want to pull the
> latest each time they build, most vendors will choose a static set of
> versions and only bump to deal with bugs, CVEs or explicit features
> they need rather than having a series of moving targets.

Yes of course. This is actually how 'binman tool' works - unless you
explicitly fetch something it uses what you have. I am certainly not
suggesting that binman fetch things as part of the build itself, but
that it provide a way to programmatically obtain the required bobs,
e.g. fetching from a defined (or public) repo or building from source.
We would need to support different versions of the same file, dealing
with files which are common across SoCs, etc.

>
> Well the whole point of the repo is to remove the guesswork, it would
> be a set of firmware that is expected to work in a single location.

I don't believe a repo is sufficient. The instructions for building
images are becoming complex enough that it is a non-trivial job for
anyone to work through the steps and figure out what to do. If you are
deeply into a particular SoC it is worth the effort, I suppose. But I
favour a comprehensive image description (as provided by Binman) and a
programmatic method.

I'm not sure of the best way to 'uprev' blobs, but wherever they are
stored, I suppose the image description would be changed to select the
new version.

>
> > IMO the actual repo is not the ultimate goal here. Building and
> > testing should be the ultimate goal.
>
> I disagree, the repo would assist working and tested firmware because
> there could be a review/test process as part of it to ensure things
> work and are tested to give users a good experience rather than having
> to search the web and forum posts to attempt to find pieces that work
> together.

I believe we are saying the same thing here, albeit that I feel a repo
is not enough.

Regards,
Simon


>
> > >
> > > [1] https://libera.irclog.whitequark.org/u-boot/2024-06-13#36498796;
> > > [2] https://docs.nxp.com/bundle/AN14093/page/topics/build_the_u-boot.=
html
> > > [3] https://bbs.t-firefly.com/forum.php?mod=3Dviewthread&tid=3D2236
> > > [4] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree=
/ti-sysfw?h=3Dti-linux-firmware
> > > [5] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree=
/ti-dm?h=3Dti-linux-firmware
> > > [6] https://docs.kernel.org/next/driver-api/firmware/firmware-usage-g=
uidelines.html
> > > --
> > > Regards,
> > > Nishanth Menon
> > > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A3=
4 DDB5 849D 1736 249D
