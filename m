Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F010C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F09383AB8;
	Wed, 28 May 2025 18:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iOHKR8f6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24ABD839D5; Wed, 28 May 2025 18:08:53 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0EC83903
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-602c3f113bbso8591607a12.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748448530; x=1749053330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G09kR4unYSd9E6kTmOjGfizXBhTtP2c6s2m/AZv8wQU=;
 b=iOHKR8f6y2rWBftemayafeesycL5Q+GuOaGBEChky6i0QrLqKw9NgWTioyb/vAx4Es
 H577G6Y/oWo7hLL+Bf7Fq1z5okEMsUXocQcjwRXTXLaZIaORtXfbwwC5qlRseMeC6WZS
 qycagsLPgbrrto2jX0hTtslCm9v9FBpYLm3Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748448530; x=1749053330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G09kR4unYSd9E6kTmOjGfizXBhTtP2c6s2m/AZv8wQU=;
 b=aXL+rjC9i7oKTnyr7cZrq2hll3V+0o3w8OQ0cxYydPb5Anmm6dt8W0hkyJ4dlbkYi+
 tUyjlnHyMUfWdCuzzpK1wBKsC0BgFyElZAYVPUSNs3E7XjIYwDhuSXyyVons9XpXYy4C
 Ge6+B2nHPL8/5OBRjyNPGjPqhW/dxT1NkCBgCvosx8Jw/xQ3XjtD8BBccBuXVMWVXkWU
 wN4KaIDv6AD4Nlp5UqfJ1yveLQp36Ojc2WxUOVrDrL80BOwEhsOSnRW7CXq04eyZXl1m
 rv8P2AWG79V7ig6gvBcNE+SF6VEojfP7X6Sui+t3j1PHZ89b9ZBM6UbPaDY25K5QVLKZ
 ySHA==
X-Gm-Message-State: AOJu0YxofjX51fa8ybnRptlDIENQqgjPv6pUMulRaoxsrvkBDXCM0OM6
 WEUxp5qBQUmDnRuGuyJinWr6WK/gfv3l/kvj5GGkhn43FGeHBMWDipodnMZPLgg9qlRNFvAR0ud
 9r0+wBM6TcKxsMafkV7OURbtc1ix5QWYFSBuBki5N
X-Gm-Gg: ASbGncuhwizpU+fl/x0EtD5IXaddrK9UoW+8bOx9oqdGwJYgirpMJ/JOEME62alNjfp
 52Vm/XN9Ooqvu7fJGNv7Djxk1ZKsB5NWtZjnwVw9S/0a41KatUnHJQv1sn0BeGeN3X4PpVhRMtZ
 roriml99jTDxcPxeZhCn1V+v8a4m2Ir4M=
X-Google-Smtp-Source: AGHT+IGIBXiR5qr0ODdDrcBuyL/J03Zu1vZeE59hlz1XpZDKPy6PY+sa/D4jNneqgjahfi7lqAc3apYN1I/iTVuyA6k=
X-Received: by 2002:a05:6402:358f:b0:5ff:f524:90e0 with SMTP id
 4fb4d7f45d1cf-602d9163253mr13905547a12.11.1748448530103; Wed, 28 May 2025
 09:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
 <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
 <20250528151927.GB100073@bill-the-cat>
In-Reply-To: <20250528151927.GB100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 17:08:38 +0100
X-Gm-Features: AX0GCFsc-ZYsE2R_mTjr2KvvoIFxZ5wHHChatx1sp4dLogIlpo9HVlDXoOb-BwE
Message-ID: <CAFLszTh3WDhn_ZSRsBMTpD8i5AyNLFGiV0cbPhOfCUAud1_WOg@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] passage: Define a standard for firmware data flow
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, Alexander Graf <agraf@csgraf.de>, 
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Fabio Estevam <festevam@gmail.com>, Harrison Mutai <harrison.mutai@arm.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Liya Huang <1425075683@qq.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 May 2025 18:54:00 +0200
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

Hi Tom,

On Wed, 28 May 2025 at 16:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 28, 2025 at 03:32:12PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> > > >
> > > > This series adds a standard way of passing information between different
> > > > firmware phases. This already exists in U-Boot at a very basic level, in
> > > > the form of a bloblist containing an spl_handoff structure, but the intent
> > > > here is to define something useful across projects.
> > > >
> > > > The need for this is growing as firmware fragments into multiple binaries
> > > > each with its own purpose. Without any run-time connection, we must rely
> > > > on build-time settings which are brittle and painful to keep in sync.
> > > >
> > > > This feature is named 'standard passage' since the name is more unique
> > > > than many others that could be chosen, it is a passage in the sense that
> > > > information is flowing from one place to another and it is standard,
> > > > because that is what we want to create.
> > > >
> > > > The implementation is mostly a pointer to a bloblist in a register, with
> > > > an extra register to point to a devicetree, for more complex data. This
> > > > should cover all cases (small memory footprint as well as complex data
> > > > flow) and be easy enough to implement on all architectures.
> > > >
> > > > The emphasis is on enabling open communcation between binaries, not
> > > > enabling passage of secret, undocumented data, although this is possible
> > > > in a private environment.
> > > >
> > > > To try this out:
> > > >
> > > > $ ./scripts/build-qemu -a arm -rsx
> > > >
> > > > This will build and run QEMU for arm64 and you should see the standdard
> > > > passage working:
> > > >
> > > >    Core:  49 devices, 13 uclasses, devicetree: passage
> > > >
> > > > This series is available at u-boot-dm/pass-working
> > > >
> > > > Changes in v5:
> > > > - Add RFC for test script
> > >
> > > And this is why I question if you are working in good faith. I've
> > > rejected this countless times. I'm still rejecting it. Stop including
> > > it. Point at the version you could easily be maintaining in the contrib
> > > repository where you have write access and no one will be telling you to
> > > not do something. People would even review the patches since it would be
> > > against mainline.
> >
> > I fully understand that you don't want the script and I'm only
> > including (as an RFC) so people can actually try this series out. I
> > didn't want to point to my tree as I thought that would annoy you. I
> > already went through why the contrib tree is not suitable for me.
>
> So I have to take changes that I disagree with, but you can't work with
> a tree for your tooling where the community would be happy to provide
> feedback? That does not sound like compromise. Again, I have trouble
> believing that you are working in good faith to resolve the differences
> here.

Yes, as mentioned before I would like you to take changes you disagree
with, at least once we have discussed alternatives and I'm sure that's
the way I want to go. It would save a lot of grief if you could do
that.

I could use your contrib/ repo but there isn't a lot of point, since I
have to have my own tree anyway, due to rejected / changes-requested
patches. It's just lots of fiddling around for no gain. I'm fine with
your not having the scripts in your tree and I'm fine with maintaining
the Python tools in my tree. Basically it seems my tree is the dumping
ground for the stuff you don't want in 'pure U-Boot', or don't want
yet. If you would like me to sync my scripts to the contrib/ tree
every now and then, yes I can do that. I don't see much point since we
can't reference them in docs or test them in CI, but I'm willing to do
it.

But I do want to post patches so I can get feedback from people who
are interested. Perhaps we could set up an 'experimental' mailing list
for that, since you seem really unhappy when I send them to the U-Boot
mailing list?

Re your 'good faith' thing, I'm really just trying to make progress
and I wish there was less 'email overhead' and more action. If you
have concerns, it would be better to discuss a resolution f2f or on a
VC, not endless email threads which don't relate to the patches I'm
sending. The series we are discussing here was sent in 2021 based on
bloblist from 2018! [1]. It is why Firmware Handoff happened. Give me
some credit for foresight, at least.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/cover/20211101011734.1614781-1-sjg@chromium.org/
