Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2069EC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7337083A5E;
	Wed, 28 May 2025 18:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IbOHla4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EB6839D5; Wed, 28 May 2025 16:32:29 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A681832A4
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-604e745b6fbso4772165a12.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748442747; x=1749047547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hlyxwwbkYDCgxjmtT+iaqRm3xTS+mo2sOBLrwaQWENM=;
 b=IbOHla4KEOjxSa019hgLdTh4nKBVGc88YByKLLaBR9y0bV+nPEljdHYYV3H9T9iBcb
 ZC6PyiKNf6GND+tEZkbIYHPVD1pshUCRoIIv2lvOBGMMRBYxInguSWtlfO0LT21VdT7M
 AG9bHUK/gz3uKxe0SYiMFzcTkrWf5GBc0Ir5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442747; x=1749047547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hlyxwwbkYDCgxjmtT+iaqRm3xTS+mo2sOBLrwaQWENM=;
 b=lISKa1DWZNqr0c+M/alsuthaa41ShfY0Fz9Mx/WjmxFB6MxQQ3eKJX5dJdU8sS7tcv
 blvwj4DvK92wzH4S17aFsw0YkDy0pUtsniFYSi0h4VitjXI0q9534BxVZ1bhKouiNgfK
 EPFwADUL72UQWwuAMkdm0tUBxQrjHiZvakFQpH+BCayU/yy5LhaIYsDVdur52W2w+BhN
 rjTjbCqmiuOxtKzq5344/PpocGIPW/d303v/MXMMfDE8dSBUj2cHhCG6HjGXUwydlmx+
 VRGWGBXFNUKzy+Pa6T/hUS145rOVOmsIIfrSnoOBJanIQSw8sbdmf7JX+H0RQEl5vEe3
 NVpw==
X-Gm-Message-State: AOJu0YwYx3JN3iv1sYrMG8q9e2FnnFS+faDGpt5esYxRBOm3C74fzJb6
 w5u09AFQJCJNnGPPKh0/59/6C63lP5H7sA8Kvvd/BMpRWHH8PHOoKKFWMUoK+zDrKmt+5nljtNp
 n7JL586g1Gw+0RSLJea4jI5AF9ScvM/IPrXfxC4Hm
X-Gm-Gg: ASbGncspqdphfL4em+0bGhe54/ajehAwvKtt0F7AA54JZPcDNeJcHmjzmk44JwZtvno
 /Up5dSeNHBuYBGPzsQTM4ipwq2I2tdcfQ5sV/oKLMlfFuzxUx7bz7Jr4+rPHrL9nsrYbyxiqYM6
 qnUYDjQcpwB+RZbE8g6+JB72Bz0RKItaQ=
X-Google-Smtp-Source: AGHT+IEtBjpnrCkR+rvCtZR6h+C3QvbbBMGUo5TaDKUa4mpvb0XZCv0UF7MPI/rYm2UicCE0F15hx9taUmJMhZelg7Y=
X-Received: by 2002:a05:6402:2685:b0:601:ff94:4a41 with SMTP id
 4fb4d7f45d1cf-6051c508081mr1848208a12.29.1748442746647; Wed, 28 May 2025
 07:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
In-Reply-To: <20250528142521.GW100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 15:32:12 +0100
X-Gm-Features: AX0GCFvcCHrPLCj_kfo01VmkqMM7E9fRLJsRanSmS7gq4al0pvRFhb8qpEpdfGQ
Message-ID: <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
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

On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> >
> > This series adds a standard way of passing information between different
> > firmware phases. This already exists in U-Boot at a very basic level, in
> > the form of a bloblist containing an spl_handoff structure, but the intent
> > here is to define something useful across projects.
> >
> > The need for this is growing as firmware fragments into multiple binaries
> > each with its own purpose. Without any run-time connection, we must rely
> > on build-time settings which are brittle and painful to keep in sync.
> >
> > This feature is named 'standard passage' since the name is more unique
> > than many others that could be chosen, it is a passage in the sense that
> > information is flowing from one place to another and it is standard,
> > because that is what we want to create.
> >
> > The implementation is mostly a pointer to a bloblist in a register, with
> > an extra register to point to a devicetree, for more complex data. This
> > should cover all cases (small memory footprint as well as complex data
> > flow) and be easy enough to implement on all architectures.
> >
> > The emphasis is on enabling open communcation between binaries, not
> > enabling passage of secret, undocumented data, although this is possible
> > in a private environment.
> >
> > To try this out:
> >
> > $ ./scripts/build-qemu -a arm -rsx
> >
> > This will build and run QEMU for arm64 and you should see the standdard
> > passage working:
> >
> >    Core:  49 devices, 13 uclasses, devicetree: passage
> >
> > This series is available at u-boot-dm/pass-working
> >
> > Changes in v5:
> > - Add RFC for test script
>
> And this is why I question if you are working in good faith. I've
> rejected this countless times. I'm still rejecting it. Stop including
> it. Point at the version you could easily be maintaining in the contrib
> repository where you have write access and no one will be telling you to
> not do something. People would even review the patches since it would be
> against mainline.

I fully understand that you don't want the script and I'm only
including (as an RFC) so people can actually try this series out. I
didn't want to point to my tree as I thought that would annoy you. I
already went through why the contrib tree is not suitable for me.

Please just ignore that patch. I've marked it as rejected in patchwork
and if I send a v6, I'll drop it.

Regards,
Simon
