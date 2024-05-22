Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA573C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3255788005;
	Wed, 22 May 2024 09:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DS+2i6Bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8854488047; Wed, 22 May 2024 09:09:44 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25FE687FDD
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-66986f58b43so468152a12.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716361780; x=1716966580; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWnOBnKRuXxqyy+QGKgT8Grjdx0vqcChxjcvL0Ozv+I=;
 b=DS+2i6BzKbh9xO/HXMbFq26kbQA4puP2mUKVz6PzpzpuWT8j32BLbxgx9dUjZ1KGsS
 2IsOidowyXYQn24L9QJlg3JuehKsBPizehRh+46o/O98uvTwYFpAmb+uQBbtp7G7+j9/
 /NZNNNKri0gSC45/PY0lUR39JCHjP7/Pnbi5CrPneEPHUYrjKaLFDEyggqbwfy0Dtalg
 N+/8qI9n5QMFTbQSa8y3ctQBppQVuHIteUPWlSwnusrmvkUEzVuiYZ6ji0Q1gJQB7MLD
 BPvUi7b/ROv8/CmnjkGqJQ1bwVCknXfT3/q6SCaXulH9x71u7nflPeObmxomCmSKiNWu
 7PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716361780; x=1716966580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWnOBnKRuXxqyy+QGKgT8Grjdx0vqcChxjcvL0Ozv+I=;
 b=BJ50fHPwOiG7wkAYTtQ92QkjkyHNOn5R5hTPm2sKOOTxGqz7CVzG/5V9RjJ/YogznN
 pkBfNY7LWyxqyvsi8ABPy+/Pz3dI/p3PTkdRpdEPncxSJncrOeDs5mtpl1qAncFzGbao
 uGbruteJyJjE7pE+eWLOW4WsHjgMCg00snbr57D6sE7lJyAuvgQCSDJPwkYjWO21Sz9h
 0Lbqso3Hru/lJXSdP+eZPJHfZSGEux3pMm/9Sa5Baeoin609fi8numzE36Q8+EOfRUyC
 S5Q13eqiFxQ3EpsihNbo+NHwYHolLFfNCjKGLaKMmT/4VhW7D0o8dgXxd08kx5KZapvA
 ZnMw==
X-Gm-Message-State: AOJu0YwXt70P9zoM2lOLmd3XCk3PnHyQ/tzjnihgduzUK64iZ5ZV3ikz
 7gGc69vGudQWQUHVtwuyGlD9ujIinuxT4kfa7V1OYCZeb5qgEmUhrCzPsgFCFlFHZE0IK3aRSyg
 fEWwgZ7b0H6doLOm3KlYC6NtJo3pVtV/F
X-Google-Smtp-Source: AGHT+IFUlO3Jigo6CK9ZSGKnSmJasRcNEU4kNae+LP+OCyFTT9ItT+BES0DyCAC3qM3UcD9ZpiAVOXz7xvjbGn6M9ps=
X-Received: by 2002:a17:90a:db4a:b0:2b0:763b:370e with SMTP id
 98e67ed59e1d1-2bd60426c81mr16018059a91.18.1716361780522; Wed, 22 May 2024
 00:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-4-8fff0cb11c19@flygoat.com>
 <CAMo8Bf+JNR-QSECNhaCWKVkU1s+m6-eUrqePzF=7XyezxDWu0g@mail.gmail.com>
 <74e04a5a-5b16-49a2-a5e9-d0f7ee97484d@app.fastmail.com>
 <CAMo8BfKVk544=8Wd=jSe+DyUhrDYqMF2EQgNuQOcubVdYFCVBw@mail.gmail.com>
In-Reply-To: <CAMo8BfKVk544=8Wd=jSe+DyUhrDYqMF2EQgNuQOcubVdYFCVBw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 22 May 2024 00:09:29 -0700
Message-ID: <CAMo8BfK7pB73k0yzJvfi2P4e8Rjz2huSGxVz1Ueh0dRAuDs+SA@mail.gmail.com>
Subject: Re: [PATCH 04/10] xtensa: Define PLATFORM_ELFFLAGS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
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

On Tue, May 21, 2024 at 12:12=E2=80=AFAM Max Filippov <jcmvbkbc@gmail.com> =
wrote:
> On Mon, May 20, 2024 at 9:00=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.=
com> wrote:
> > >> diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
> > >> index b0809999e403..3ec936272f25 100644
> > >> --- a/arch/xtensa/config.mk
> > >> +++ b/arch/xtensa/config.mk
> > >> @@ -7,3 +7,6 @@ PLATFORM_CPPFLAGS +=3D -D__XTENSA__ -mlongcalls -mfo=
rce-no-pic \
> > >>                      -ffunction-sections -fdata-sections
> > >>
> > >>  LDFLAGS_FINAL +=3D --gc-sections
> > >> +
> > >> +PLATFORM_ELFFLAGS +=3D -B xtensa -O elf32-xtensa-le
> > >> +
> > >
> > > This fixes endianness as little for the whole architecture, but xtens=
a cores
> > > may be either little or big endian.
> >
> > Thanks for reviewing, I can just add a branch with ifdef CONFIG_SYS_BIG=
_EDNIAN
> > if you wish, but I think all CPUs U-Boot support are little endian only=
?
> >
> > I have an ongoing series[1] fixing endian selection options, please let=
 me know if
> > U-Boot do work with big endian Xtensa.
>
> I had an impression that there's nothing endian-specific in the xtensa po=
rt,
> so it should work for both little- and big-endian cores. Let me test whet=
her
> it's true though (:

Yep, I can confirm that. Importing big endian xtensa core files into the cu=
rrent
u-boot (I tested this one:
  https://github.com/jcmvbkbc/xtensa-toolchain-build/blob/master/overlays/x=
tensa_test_kc705_be.tar.gz
matching cross-compiler is available here:
  https://github.com/foss-xtensa/toolchain/releases/download/2019.03/x86_64=
-2019.03-xtensa-test_kc705_be-elf.tar.gz
)
and building it for xtfpga produces a working image.

--=20
Thanks.
-- Max
