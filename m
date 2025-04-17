Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3012C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 23:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3514831B5;
	Fri, 18 Apr 2025 01:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QxHeyuca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E17830EB; Thu, 17 Apr 2025 23:59:29 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DD283039
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac289147833so235759066b.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744927166; x=1745531966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GPVfp6QWE4mV2KbRITYwc2ZoIIDrAG2Y0caXcSjqxeI=;
 b=QxHeyucar3hctmcZ0IpKN5pmIGH5m4hcLLdpsTMK2WxQ1SxK+d9TK9I6h93CyFUN9d
 Y0QtGIHWttCg/d1OhGCEnKGW6obK2Z3VRXCAaJayXkq9LWMJXuz37c4JUyl4dzK7PN+i
 8VXX7bvpdhAeSb4RAu3JXCV7Hwmt0cqjcjiqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744927166; x=1745531966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GPVfp6QWE4mV2KbRITYwc2ZoIIDrAG2Y0caXcSjqxeI=;
 b=DlATLRiG6B+VwA7sb05g4BwcrvZ71jVI1Mh4KFKhJwn6ZxEBMfwxGoxLtXD4aeML3z
 K0WSUs526LKyQEZXHdJ0QZ/maIYL2CgEGS3Jxde4wO4lPzU09QQgnWut6bcN7LpcNTun
 EsRuD2W3Z0IZqim6et0J+w82z7s+S+z8THWl6xi0X9TmWNwf3l7p2PrQ1GeJInbDTler
 iAaoisBdYp53INaTVR9j9p+NG+9rG1kitm+jhShqy0ycHon/CqH6XwmkORXq1K68dMSa
 hg7V+nwRSEtfFf0zjXK3lgjXgi9fFGoKK75e2HgdOMtGZz+ZPTNOk/4tBcvaBMu44tXk
 y2QQ==
X-Gm-Message-State: AOJu0YxweGBrLd8eJtzl+6Ie2drVe9Tz5nyjwM0dxSMhp4ddpqyX7/op
 s1XwabFXDXhcZhgWiWBUnIIfYmkJGnv2E2grJaFiDPKt7e6X3aI0t/w1Vgn5C/AruvVUNYERxz3
 o6rmOhKabMOagBRYGhxKxKnUAkd7N2CZh1vJp
X-Gm-Gg: ASbGncvXS4o9kM/i5Med1tmji845cGku6DvxP6msegfnkmXahTuJAW5SSYIfmJrmSVK
 Iay8mt4KKnS9VWGe1oDXGAB241ZdB4qr2KWkPjwaFqRTXhIgT1xmcg0BagmYdT7ndsqmBNSPu3x
 uoVtwC5KrjLhI9Wzl9RXWIJyQ=
X-Google-Smtp-Source: AGHT+IEKFIerqaxgbVzadpjT/wASEU2Eb/Pb/FeWE+3Cl7o2XK3/PIW91gTHhTASe7FlLk3Y+C0THxldI+UB2J0CceE=
X-Received: by 2002:a17:906:9fd2:b0:aca:a539:be04 with SMTP id
 a640c23a62f3a-acb74ad9595mr43130666b.4.1744927166027; Thu, 17 Apr 2025
 14:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
 <20250417212412.GA5495@bill-the-cat>
 <CAFLszThWv+jUQ9cDZBPNvZAj89me-zFHJV4RmNhJ5Jbp+JZgzw@mail.gmail.com>
 <20250417215420.GC5495@bill-the-cat>
In-Reply-To: <20250417215420.GC5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:59:13 -0600
X-Gm-Features: ATxdqUFkOx4cPOvMMn3aKAx5GgP-D4VXjm4FBpHeWKmU3Q_Rg0kNTXQIYYLtXxg
Message-ID: <CAFLszThBLF=Put6QyhmM_yJ=Hq0g+fUW+=E4a0j7LO8VisuUKg@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] passage: Define a standard for firmware data flow
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Alex Shumsky <alexthreed@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Jason Liu <jason.hui.liu@nxp.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Mario Six <mario.six@gdsys.cc>,
 Maximilian Brune <maximilian.brune@9elements.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, 
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Xu Zhang <423756212@qq.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 18 Apr 2025 01:35:40 +0200
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

On Thu, 17 Apr 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 17, 2025 at 03:38:07PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 17 Apr 2025 at 15:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Apr 17, 2025 at 12:15:42PM -0600, Simon Glass wrote:
> > >
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
> > > > This series is available at u-boot-dm/pass-working
> > >
> > > Before I get into further feedback, my first bit of feedback is that
> > > this breaks transfer list support. I didn't check this on Raymond's QEMU
> > > but did test it on vexpress_fvp_bloblist and expect QEMU is also broken.
> > > The most likely reason I think is:
> > > >   passage: spl: Support passing the passage to U-Boot
> > > [snip]
> > > >   xferlist: Drop old xferlist code
> >
> > CI passes for me:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/25806
>
> Sure, good, I was wondering about some of the other changes.
>
> As a reminder there are a number of CI labs (of which none are "Linaro",
> they still need to get moving on that, yes I'm calling them out here as
> a reminder to them) that monitor mainline directly (I push a tree, it
> triggers, they speak up if there's specific breakage) and indirectly
> (Toradex has given talks about their CI which includes weekly mainline
> U-Boot builds) those reports are equally as important as our GitLab and
> Azure pipelines.

I think my QEMU test is a good approach, since we can make it work on
any arch in CI, without need particular hardware.

>
> > > These are not the same. And they should be. And they should be using
> > > the register layout / values other projects use today.
> > >
> > > And I am bluntly uninterested in who shuffled the registers around and
> > > made them no longer agree. What TF-A is doing now is what's in the wild
> > > now. And shame on them if there wasn't a good reason for changing things
> > > either.
> >
> > They are the same and any difference is a bug, quite possibly in my
> > code. I am hoping that Raymond can point it out, as I believe I am
> > following the spec that we created.
> >
> > The xferlist is a little harder to maintain and it has a bit of an
> > unusual API. It's better to use global_data for this case.
>
> Yes, I'm not completely sure where the bug is but your code breaks the
> other platforms and you should have enough information at this point
> to run and reproduce it. If it's weirdly only vexpress_fvp_bloblist that
> breaks, I can tell you how that's run with transfer list. I can't just
> point CI at it because... nasm.us is down which means that coreboot
> can't build from source which means I can't rebuild our docker
> containers to include the TF-A blobs too.

Yes, I gave up with the TF-A thing, but when I hear from Raymond I'll
give it another crack. It can't be that hard. There are just too many
'in flight' things at present.

Regards,
Simon
