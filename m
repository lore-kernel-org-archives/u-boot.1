Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A022CC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5568215E;
	Wed, 30 Apr 2025 16:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TeFCOox3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEEE482153; Wed, 30 Apr 2025 15:55:15 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF49882B66
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 15:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so1092232066b.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746021313; x=1746626113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDRRPkvOm8rTawrPH3XDZ0kUtiK9FrL3dZ25X16e4/c=;
 b=TeFCOox3RJAR9sf6apAGetw3yl8JZxtY7zp5snKi2ggSYps1n9xjktBYiohmzY2Gk0
 qlVVGeSlyBb2QbDdtANIAwXbUa7oq3yEfpa7QbP6PWQk1aXrCrc/7c8wXZ65fhZN1POv
 08+BY0hVclsrJv3glfX4FnYZkUxXWxtGs5nVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021313; x=1746626113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDRRPkvOm8rTawrPH3XDZ0kUtiK9FrL3dZ25X16e4/c=;
 b=amaDX+Q45PtZ36ZULvJ25LxIg0QjBdzjfBh2W5CU7oe1bPo4+8M8u2sMJETkIiqEND
 bKe7ABD551Tw+qUph3oOFZxAiBMQL4+j4x2XKMc7D5gikeVIFKcCpHBT5I+709dQpKgN
 bIoCngPWr9ucdw65wlG8rCe1NrhB+KzriFNjjM9gpHIhh0UEr41JEYPWUPhSn5UiTRKl
 D5z08Z1LQmeYfMH1PA7qoSkP1JD0JHlllIkLz//xjPq0tWEJ8tgXIY80kcvLB90KyfU6
 ixI0AzTFeDLoU9dKUHUNFJZij64DPtzTAdlxx0zMH9STbAGYMQMvLdZtesKVoZ4cJbWp
 rTFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrahyA9n03tbzSsGGU3qj0VAbuYhBd3lw6h72nm+5iYttjYzNssVweUqzpbE0gsAYisYBrViQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwbiP2HeIktLxsoYj2+mfQG6Yfs24NtnHQKQc+YCjv8YqiC4C2V
 z5Ac/MSzejs+fUyl70IIUW7wUM8s4S0PVXiF9iXVUpEeEXbSpg6ieddo3FQ+JaAXnu0G8DxWQgF
 +u09fqLlsblyNsdGDELfV9XG89yFpeb4n8NSB
X-Gm-Gg: ASbGncstJi4ljp/V8yR1oDcw4qgpafa1WVdmILMUSIl+qa35TUpEm/H6q3rXeV0rRia
 ecrhyOOgnGfliO68sPmFIYGeSnVcaRCBaCDd4LTQksEegYF2b9wIMhlOcpZUjsod1wRmxLZSowu
 QolUMSNiGDDjX7saOujetQkAg=
X-Google-Smtp-Source: AGHT+IETUwM4SYopb6PnW9YeuDvWgEVs7yt7VbAPS5PFU3n1vSnMOP7Z4iFxYKQVBxbDxjtFcrqYExQXSl5RgKPhBqI=
X-Received: by 2002:a17:906:ef0a:b0:ac1:e6bd:a568 with SMTP id
 a640c23a62f3a-acee25c84acmr248892766b.37.1746021313003; Wed, 30 Apr 2025
 06:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250417181613.1355024-1-sjg@chromium.org>
 <CAEfUkUJpT8YxOgdakCBbjBo_a6a6pQDR_wh=iqX5LC+cFAFJ0Q@mail.gmail.com>
 <20250429171154.GJ1261075@bill-the-cat>
In-Reply-To: <20250429171154.GJ1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Apr 2025 07:55:01 -0600
X-Gm-Features: ATxdqUHVo3u8GyjcNZmopreLS-LdbN1DM5slAJOoA_0B2NifYGFnxYncU1wGYuc
Message-ID: <CAFLszTjfq1TVjYSiCQmtSOZK7MoVUOFU5ycOzeBK4-5-zCKxFQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/22] passage: Define a standard for firmware data flow
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Peter Maydell <peter.maydell@linaro.org>,
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
X-Mailman-Approved-At: Wed, 30 Apr 2025 16:51:40 +0200
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

On Tue, 29 Apr 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 28, 2025 at 10:41:25AM -0400, Raymond Mao wrote:
> > Hi Simon,
> >
> > On Thu, 17 Apr 2025 at 14:16, Simon Glass <sjg@chromium.org> wrote:
> > >
> > >
> > > This series adds a standard way of passing information between different
> > > firmware phases. This already exists in U-Boot at a very basic level, in
> > > the form of a bloblist containing an spl_handoff structure, but the intent
> > > here is to define something useful across projects.
> > >
> > > The need for this is growing as firmware fragments into multiple binaries
> > > each with its own purpose. Without any run-time connection, we must rely
> > > on build-time settings which are brittle and painful to keep in sync.
> > >
> > > This feature is named 'standard passage' since the name is more unique
> > > than many others that could be chosen, it is a passage in the sense that
> > > information is flowing from one place to another and it is standard,
> > > because that is what we want to create.
> > >
> > > The implementation is mostly a pointer to a bloblist in a register, with
> > > an extra register to point to a devicetree, for more complex data. This
> > > should cover all cases (small memory footprint as well as complex data
> > > flow) and be easy enough to implement on all architectures.
> > >
> > > The emphasis is on enabling open communcation between binaries, not
> > > enabling passage of secret, undocumented data, although this is possible
> > > in a private environment.
> > >
> > > This series is available at u-boot-dm/pass-working
> > >
> >
> > First of all, can you group those patches which are necessary for
> > refactoring the "passage" concept into a smaller series for an easy
> > review?
> >
> > Actually as I mentioned in our previous discussions, I don't agree to
> > add a OF_BLOBLIST as this is duplicated with "BLOBLIST +
> > BLOBLIST_PASSAGE_MANDATORY (aka PASSAGE_IN in the context of your
> > patch - I am not sure the reason you prefer to rename it - do we have
> > any other passage approaches other than using bloblist? And do you
> > have any considerations to allow a fallback or not in case passage
> > failures?)"
>
> As preamble, I am actively working to push the changes for
> vexpress_fvp_bloblist to be available in CI and so provide an easier
> testing path.
>
> At the high level, I don't see what the difference is between "BLOBLIST
> + BLOBLIST_PASSAGE_MANDATORY" and "BLOBLIST + OF_BLOBLIST" or "BLOBLIST
> + whatever v4 of this series ends up showing". Everyone seems wildly in
> agreement that if the prior stage is supposed to give us information
> then it must have done so.
>
> One of the long running "jokes" in computer science about naming being
> one of the hardest problems applies here, too.

I want to use OF_BLOBLIST as it clearly indicates that the devicetree
comes from a bloblist. The BLOBLIST_PASSAGE_MANDATORY thing is a
work-around to try to avoid having OF_BLOBLIST.

>
> > Secondly I prefer to keep the register convention code as a xferlist
> > library that can be used for arm arches other than split them into
> > different low level assemblies. In case of any firmware handoff
> > specification update, we just need to maintain this library.
>
> Yes, if things can be written in a C file, they should be in a C file,
> not assembler.

In this case I disagree and if you look at the x86 code, this kind of
approach is just not sensible. Please take a look at the contortions
of xferlist_from_boot_arg(). It was written for one architecture only,
yet purports to be a general API. My approach is simpler. Also, if
save_boot_args() is implemented by the board, then standard passage
will be broken for that board. It's a weak function!

More generally, please decide if you are willing to let me maintain bloblist.

Regards,
Simon
