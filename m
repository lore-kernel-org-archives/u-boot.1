Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371D6CA0EFA
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 00:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FBA80548;
	Fri, 22 Aug 2025 02:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LfndNoJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12E081D5D; Fri, 22 Aug 2025 02:04:53 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0DC8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 02:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6197efa570eso3003787a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755821091; x=1756425891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GwQbiRh0nZ0Jnd7ok2OarXuG6O2/EQpRnJW6J89ek24=;
 b=LfndNoJZ6IDRWQeROkqi4pK9BOoS914W67kgDASc6fsZ6CHty9YbUOoX9+RwrNyDMo
 j7LUO7b9WwFFYWC6R2tlxIJXkV7gRjTxWrVRgNBkYxFlh490Z+7R/cF6jONSzgeCyii7
 +unlHX6KoVhHAesrJTenf/2Kr7wLz7tVzvJhFTvCSzWwX8LUzmNIYwP0vwtDdyEM2Pn6
 TM/uxEV1NdEla160/LUgxf1GakIb1kGyQxr8GFZV1V7KKJ2nRn3tfhlcPhdqAD+mFALM
 aoKAbiV6TKrHJmqu2JcVzf4UrZ2Z6T+pEGsGx+bTnBHd0qUibw9ye/W3FXX25TsMHloh
 tsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755821091; x=1756425891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwQbiRh0nZ0Jnd7ok2OarXuG6O2/EQpRnJW6J89ek24=;
 b=W+bI6jziC7MshOGMxvl5QW/Fdzh0kXCW1pLsEn4U2o5rk4or1aDnzBJRJ1rMGm574/
 s6NV32dpwxia34aqHx+yHXQB0Q6OKD4vO3caNPzCXjfNO9SgeZU/Q4BcBSqQiE6bfdaz
 VQ5oNMp6ruQ3fBTROv3PvYo/Xa27wOXpeg4SzjiDz5sIYHRcqJiNSrPQZAku4uBUDbfg
 P1MNvZW5XRjP5MUqx2gL902ZGuaiC9ifuREv7Z0E3LRy/6qFTpyQC05adl/N4NZxJ+b3
 NdN7kppfprOE20dzewBgmrtXFHXYpdRyZ4US6PDBVyu5GlNDKwDEgjmeUJP76g2sjMQZ
 cjjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkmEK1bk1ksAIm0GZOjBvl8Io1ikAxyT/uuApiep3F49hSGaOr8RGjlSxlqi3XUI3eulwpJT8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6QeWCwk8xnMsqONsQhsrpD9Kz27kFaLnTT/WzehEWlOywW9Zz
 gFj7Yrp8z3l0WmPgfatDLzOYeeNCchmbagYr8ovMuEKacYPFr7vm4uU3dUc/k4CzCX5LcDf+Ol4
 QiN3gYvKl521lwIkZb2GQvzArpZe+itM=
X-Gm-Gg: ASbGncsYNG9I2ITxy6/vpZDkMTIc8au+NdwE+Tpa4RGzqHR6pxevaQtfyeDssmHkr5f
 RQNZw4qgmErwYdqrHew6ycNZcLI+GEL0OGig0Nmowx8wqTSaK/Jf7LlKk0o4HFOZAftB3wqMQAH
 /y6EYeLTaak+uXgPdIj2y/SSx7gBk9QA93XydW37O1U7hEd1KMxFjyhLZ/5aLHn/SWorK1QAQPS
 iBKDiUF9yHlIar958oQSEQtolsy7ZNyVLJHAKlp
X-Google-Smtp-Source: AGHT+IH0WFkRaUuqLlMbSZBMh9kUfjGtxQkeoJCq7LUhC2k2sPedu2ipYv22KHwVUf8P6NU1gcdTBLvo6QQUm7PognM=
X-Received: by 2002:a05:6402:1d4f:b0:617:cd9d:e2a4 with SMTP id
 4fb4d7f45d1cf-61c1b45c282mr682816a12.2.1755821091113; Thu, 21 Aug 2025
 17:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
 <b8fa5fa1-0028-43e5-bb14-db94fd16bf3c@gmx.de>
In-Reply-To: <b8fa5fa1-0028-43e5-bb14-db94fd16bf3c@gmx.de>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Fri, 22 Aug 2025 01:04:40 +0100
X-Gm-Features: Ac12FXyMV0pj0rVW4zuaUJgEHBCouDkHZeWg-X26Tbi7i54dCa1Yxp738aZwUm4
Message-ID: <CACAHuLDQ9gp6G1KnbPTH2bcdFChY4x_M1HC0fJU-SJ0ozkghKA@mail.gmail.com>
Subject: Re: [PATCH 06/10] doc: Add riscv to the list of architectures in
 tools/buildman/buildman.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

On Wed, 20 Aug 2025 at 22:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11.08.25 01:37, Adriano Carvalho wrote:
> > Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> > ---
> >   tools/buildman/buildman.rst | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> > index d5d22732088..7944adcd867 100644
> > --- a/tools/buildman/buildman.rst
> > +++ b/tools/buildman/buildman.rst
> > @@ -478,7 +478,8 @@ Setting up
> >
> >      At the time of writing, U-Boot has these architectures:
> >
> > -      arc, arm, m68k, microblaze, mips, nios2, powerpc, sandbox, sh, x86, xtensa
> > +      arc, arm, m68k, microblaze, mips, nios2, powerpc, riscv, sandbox, sh, x86,
> > +      xtensa
>
> The output examples above this line should also be updated to show RISC-V.

Do you mean what's under "Check the available toolchains"?

To reproduce, I would need to install quite a few toolchains. If
anyone already has all those toolchains they could just send me the
output. Do you know someone who can do that? Can you do that? Or
should I just install all those toolchains and reproduce?

> Shouldn't we provide human readable names, e.g.
>
> * RISC-V (riscv)
> * SuperH (sh)

That seems right. I'll include that in the next revision.

How do you call the "actual" name v. the "code" name? I am thinking of
adding something like this after the list: Each item above includes
the architecture's "actual" name and in parenthesis the architecture
"code" name in U-Boot.

[...]

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
