Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE34E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 16:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCC589066;
	Sat,  2 Nov 2024 17:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H5Z7U2D9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8152689030; Sat,  2 Nov 2024 17:28:21 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F5E890BC
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 17:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so606470866b.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730564897; x=1731169697; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=omlfuQ0/WSTwKaOn2Ml/veGcfSZq9jgI61YHdff1Ml8=;
 b=H5Z7U2D9Il9VRB2hAIJ8bLLgtYEGj7/Jm63CWYNcimJOjTdnKtw6jnqMJEl+5TNoFm
 7YQ5DVn/GDnpfMpC9NiKU7efj7diRKOUfenI+tgAbR6a3XtYYhng2K1d31BbXZ6VPrew
 8B457706d/GvUwFUKxVCEERFQyyu5sQQQ8PVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730564897; x=1731169697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=omlfuQ0/WSTwKaOn2Ml/veGcfSZq9jgI61YHdff1Ml8=;
 b=FQdG3boXvGz1Aly9Cx2u7NHqMWWVJ/WnLGiV2lEVv3e6+aR7XFbOPSIe4dkl04+Rms
 6bq4tHyRRws6udFRy8qyhefbmb1PKaf+A9X1Ff3xgAfRoFiorh3AJ7K54sodgGIGieTN
 1uvPQBmMv0MkpoTzXB9t8m1alc5HyjaMvHvcYtN6s21AeWZWH2uPS8A6lG5zx5sSvooh
 MX38TE4magDBeOznJSvDZXnE3OMhsY+dtggq3pdszyUMEqcYaa+ivydFzEsalJZRXSmW
 Rx4kCJZbRwhtF5OeMFWJX/UG9A3jYjR/jNbT9bUVVekSoWeyuy8vKni/owXvFMfKFzoU
 vO8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY92fEE/07emJEYKN4CUU32uK5HbJXShMC5uauac7WEKBO6kAzitLlmv/+uqkyDzSEjGbdBbE=@lists.denx.de
X-Gm-Message-State: AOJu0YxbBPsz9gF9P+JT/Wj45gwCybnVFFkqycM8s3+iYJ6iQtwbhCUz
 n01e9DmcJiHZ9iZytWwGLGW984zhTtwvRAy0eJfj4e7IM9OteWUs7PaWr64332EUhFde0LaF5iq
 ZJmgQ4WfsTrw9Dkp+Qw5lrsowtRGZimkXrZXb
X-Google-Smtp-Source: AGHT+IGcSamG0EYluj86YZvOg7rXW3ulLNPV+FJPd4IzmnIctAcAX3IQ+Zh1zqzGsaB0WKt8EWSJxqrL4IdDfGG+eKU=
X-Received: by 2002:a17:907:7e99:b0:a99:5f45:cb69 with SMTP id
 a640c23a62f3a-a9e559df7f4mr993815166b.4.1730564896796; Sat, 02 Nov 2024
 09:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com>
 <CAFLszTh6s5n4nzC7UKhFnQuXFOucGA6amjN1eV4NqwjV6-NEeQ@mail.gmail.com>
 <1048553d-4818-4aba-8bd1-c958dc0b7c5e@amd.com>
 <178d29b0-d82c-4b18-a3ed-3d46dcc02446@amd.com>
 <20241101135220.GJ3600562@bill-the-cat>
In-Reply-To: <20241101135220.GJ3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 10:28:04 -0600
Message-ID: <CAFLszTgSX1cn1y3C=QHuVfvVr4486ezaFAL4pmdPAvi6m==Lcg@mail.gmail.com>
Subject: Re: [RFC PATCH] zynqmp: Add binman description for SOM
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com, 
 neal.frager@amd.com, Charlie Johnston <charlie.johnston@loftorbital.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tony Dinh <mibodhi@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Michal,

On Fri, 1 Nov 2024 at 14:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 01, 2024 at 02:09:38PM +0100, Michal Simek wrote:
> > Hi Simon,
> >
> > On 11/1/24 09:27, Michal Simek wrote:
> > >
> > >
> > > On 10/31/24 19:03, Simon Glass wrote:
> > > > Hi Michal,
> > > >
> > > > On Wed, 9 Oct 2024 at 10:33, Michal Simek <michal.simek@amd.com> wrote:
> > > > >
> > > > > There is necessary to do some steps to compose boot images. These steps
> > > > > were in scripts in layers for a while. That's why introduce description via
> > > > > binman to simplify wiring and remove all scripting around.
> > > > > This should make sure that everybody is up2date with the latest versions.
> > > > >
> > > > > The first step is to create fit image with DTBs with descriptions in
> > > > > configuration node which is written as regular expression to match all SOM
> > > > > versions.
> > > > > Description is there for k24 and k26 in spite of low level psu_init
> > > > > configuration is different. The reason is that it goes to u-boot.itb image
> > > > > which is the same for k24 and k26.
> > > > > u-boot.itb is another image which is generated. It is normally generated
> > > > > via arch/arm/mach-zynqmp/mkimage_fit_atf.sh but this script is supposed to
> > > > > be deprecated.
> > > > > FIT image by purpose is using 64bit addresses to have default option to
> > > > > move images to high DDR (above 4GB). TF-A and TEE are optional components
> > > > > but in the most cases TF-A is present all the time and TEE(OP-TEE) is used
> > > > > by some configurations too.
> > > > >
> > > > > 3rd generated image is boot.bin with updated user field which contains
> > > > > version number. This image can be used with updated Image Selector
> > > > > which supports A/B update mechanisms with rollback protection.
> > > > >
> > > > > 4th image is image.bin which binary file which contains boot.bin and
> > > > > u-boot.itb together and can be programmed via origin Image Selector.
> > > > > This image can be also used for creating one capsule which contains both
> > > > > boot images (in SPL boot flow).
> > > > >
> > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > ---
> > > > >
> > > > > Currently I have this for testing purpose only to find missing bits and
> > > > > pieces in binman for cases I want to support.
> > > > >
> > > > > This patch depends on
> > > > > https://lore.kernel.org/r/ fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com
> > > > >
> > > > > ---
> > > > >   arch/arm/dts/Makefile                |   1 +
> > > > >   arch/arm/dts/zynqmp-som-binman.dts   | 224 +++++++++++++++++++++++++++
> > > > >   arch/arm/mach-zynqmp/Kconfig         |  17 ++
> > > > >   configs/xilinx_zynqmp_kria_defconfig |   2 +
> > > > >   4 files changed, 244 insertions(+)
> > > > >   create mode 100644 arch/arm/dts/zynqmp-som-binman.dts
> > > >
> > > > I'm pleased to see this. My only suggestion is to use '/bits/ 64'
> > > > instead of the macros, for 64-bit values.
> > >
> > > When I was playing with it some time ago it didn't work but it works now
> > > that's why no issue with it.
> >
> > One more thing on this one. I pretty much dislike that images are generated
> > to u-boot root folder. Isn't there a way that they will be written to
> > separate folder (deploy for example)?
>
> Or perhaps $(obj) ?

Yes $(obj) is where they end up today. I consider output files from
binman to be on the same level as other files created by the build.
Then again, it does end up a bit of a mess, when mixed with the output
files.

I am not keen on 'deploy' as it nothing is being deployed - also it
sounds like a satellite or military attack.

One long-standing issue is that intermediate files are created in the
same directory. Perhaps we could put those in a binman-tmp directory?
They are necessary when things go wrong, but don't need to be used all
the time.

Regards,
Simon
