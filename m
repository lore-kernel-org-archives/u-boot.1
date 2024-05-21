Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D5AC25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D488803E;
	Tue, 21 May 2024 09:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GnCwI/DN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1229F88690; Tue, 21 May 2024 09:12:55 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC8387FA1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1eb0e08bfd2so103339645ad.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716275570; x=1716880370; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0f8SlwThMHLBE6/rc5zwh2x89oYTaJgG00KPQBnsJ8=;
 b=GnCwI/DNMjMX6wuFwv5oQlpEueT1oq5ucCkSUq5ZeymvkscJZnelq7WNpg/GzbJIEi
 7IL4mgcgbIuNf/joIPc6o1E6MDlxIa0zcZJt8f05mo3Zx5b+9uX/qiPlOIBP/+nQS3k5
 0dtejEgi+PeBy8F8ehCEroEFI5FCKDORncJd1neWJLC2XKn595aVwcsqPX6clpM7bKfM
 zK/ab8xyrVdr3+T0jsElxYytrqBXlukHnzYZi+ej02Y80XjRP+EZXJoV5rZuX7BKN2la
 AoF7zhtoJtaL2Q1U7ue6XVpUtusOk4LSltBv/ZYi42gef7Dq3MNni7DPWC00eDXv/kfD
 m13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716275570; x=1716880370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0f8SlwThMHLBE6/rc5zwh2x89oYTaJgG00KPQBnsJ8=;
 b=WwMNVOcayaeBwgqNg3XLidMcqmJ1R7PN4k8kC2R1d+8r11gDnLykKdGGo01xoE03RU
 2lfUQGbFjn03221gLWBbjdfPxQxuoA5uq2bnC+tcAZr8C+x1Tp7Ews/l1ThMWrxZi4tE
 GyIrf7LG9uQKSNCjsMnOILpSdSfLPdtm8VBrlnwO/5Q3cjFowOLI2zT6+B7X1+mYog9t
 /NSXY+7cOJ8SufFf89uPBld/VfYoAt08oZ+9j++dPZAILZSFZuXd5nUjXjYgBohX6ZgX
 2IizhuyR3m87ZR3OgCrkRFc61/fdBBESWQimpU6aXWjsAqvr7D3kSzJ2kv+a6iZmACzn
 pRjQ==
X-Gm-Message-State: AOJu0Yz/hTbHbmZBov889Fw4pBuaHVK5wQB5m5tZhb1AEhLWu9Atth2v
 43LdG9CHbxFlNJoKrKmMTKnVtsj2dCX3NO27vhp2waBFCOI1V+xmgWaR1iM1YNV43Sv35fHaqMX
 jUI4dXnmEoqV7ewCREtk7GpNhjxb5J9WV
X-Google-Smtp-Source: AGHT+IFu0mfi7qjTTdovgi2pdk8810oguFsZR36Nebys0hDR0Ew7fqm7X9q5CuBUB6XoMnpbocnTOmWIfLfoGZU6Ezc=
X-Received: by 2002:a17:902:da84:b0:1f2:f182:f616 with SMTP id
 d9443c01a7336-1f2f18300e3mr88951385ad.13.1716275569755; Tue, 21 May 2024
 00:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-4-8fff0cb11c19@flygoat.com>
 <CAMo8Bf+JNR-QSECNhaCWKVkU1s+m6-eUrqePzF=7XyezxDWu0g@mail.gmail.com>
 <74e04a5a-5b16-49a2-a5e9-d0f7ee97484d@app.fastmail.com>
In-Reply-To: <74e04a5a-5b16-49a2-a5e9-d0f7ee97484d@app.fastmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 21 May 2024 00:12:38 -0700
Message-ID: <CAMo8BfKVk544=8Wd=jSe+DyUhrDYqMF2EQgNuQOcubVdYFCVBw@mail.gmail.com>
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

On Mon, May 20, 2024 at 9:00=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
> >> diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
> >> index b0809999e403..3ec936272f25 100644
> >> --- a/arch/xtensa/config.mk
> >> +++ b/arch/xtensa/config.mk
> >> @@ -7,3 +7,6 @@ PLATFORM_CPPFLAGS +=3D -D__XTENSA__ -mlongcalls -mforc=
e-no-pic \
> >>                      -ffunction-sections -fdata-sections
> >>
> >>  LDFLAGS_FINAL +=3D --gc-sections
> >> +
> >> +PLATFORM_ELFFLAGS +=3D -B xtensa -O elf32-xtensa-le
> >> +
> >
> > This fixes endianness as little for the whole architecture, but xtensa =
cores
> > may be either little or big endian.
>
> Thanks for reviewing, I can just add a branch with ifdef CONFIG_SYS_BIG_E=
DNIAN
> if you wish, but I think all CPUs U-Boot support are little endian only?
>
> I have an ongoing series[1] fixing endian selection options, please let m=
e know if
> U-Boot do work with big endian Xtensa.

I had an impression that there's nothing endian-specific in the xtensa port=
,
so it should work for both little- and big-endian cores. Let me test whethe=
r
it's true though (:

> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20240519-aarch64-be=
-v1-11-75cc328eddfa@flygoat.com/

--=20
Thanks.
-- Max
