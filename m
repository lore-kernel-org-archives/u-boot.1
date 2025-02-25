Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833FEC021A4
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 02:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E70980EC0;
	Tue, 25 Feb 2025 03:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="li4M6zss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7188F80F53; Tue, 25 Feb 2025 03:16:16 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E40E80540
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 03:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abb79af88afso935474366b.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 18:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740449774; x=1741054574; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Np0ajj/jXvh+vBVJ3Vj9hKBEeF9obpJ2fsy7viOR5aw=;
 b=li4M6zss5FzjCyux3qljqyaa/SpHHmsJiqtvmWCntZQ/C1gowsp21Ib67z4vG07kRJ
 r2cl+KFmG+2vScjfc29Ll59cdBKvoV5RFOQGMivO3s6/LMW/0N8hqpXJrSS5W4vL+IeS
 ZOUHaODvDecm13YopmGIkd4CSS5zh+2Flqcp4QjzBslira472aLX804s0cc/z0V3uGID
 skfZCcOe1/PEx/nqexy2HZoxA12mcz8LuvW2fhj9M7KE7QwXzuut1g0pzhwmkD3bvkdI
 bQ+JQveoQR6EVujcVUccCxUjkyQ67wvze84zcIzRutpyqREFz8GQ3/mLri+flzr0pT00
 Z6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740449774; x=1741054574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Np0ajj/jXvh+vBVJ3Vj9hKBEeF9obpJ2fsy7viOR5aw=;
 b=G9k8TeeVyvEEOcjg2upNvpcCTFlOaHRBNrvGRolVMXsR0Joa++tommeFCyyk9kLUcC
 eIA2sCSAB9lwhKJ3tqpHEeCtSzfwSEA5alLep1j+2HMw1m7HMzjeMZiNN523sL3XTc5m
 thG64apHK/3Cl8QzMDjlS0K9Zn5E6OQC6+0agFFcSN9V0sjGeeUg2675agJWNp6Zh0ht
 IYo5dIl3Wpwim+6HpgbYItK6Aks6gSD+NP/EgX9iyHRN689m6ZzwHEqpyShZslvd2FQC
 7EjmDcFwkVsPOZmVXiP3mpxy9nf8ooESTcEgh5U/WSiEl9O2lDo6efMR3boYKrE4yJe3
 mTvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh03jatUvvHMlWQskS/DvIvy8l///tfS5QpFfdiSHu4PkvXDXlsTzD46W0+DfIS+i1uZONhSI=@lists.denx.de
X-Gm-Message-State: AOJu0YxMpMU29GbJG41sIPALLQdorbdJdPo0ZPYDuOKXbpqRDYLo0/dU
 xityciGTpBAn+7iKRE7zZiliZEquU1WM7tyCdROOPaDd+r1BRk87nceYoOwckCZTI8ywV9ELA9y
 qKN3yI4E0ofs0Q5IhWRNKDIXRPpc=
X-Gm-Gg: ASbGncumi2dBxaVwgtqkWJH7rZd4btpHed+VsSqM2JoHXKE3jrlexb4w7/WuqBA/PK0
 4fpm3sxjl6flReGV473u5Fsn8YcVXGEQ4lobsihcz3LS4jlEzCq+PThrAvDexVKQLSD55Zdw9Wn
 bQt6E3DyH7A8KDEw5N5mg83NTNR2DGl75iREsze4G8
X-Google-Smtp-Source: AGHT+IG0uYRy7f8H9Wc/1TwtPmny5Q3xWaCmturul942ZYi3JAOV2BrFBV127YvYKnNnJbyHkUDB9lWPsWUy1gTHPgg=
X-Received: by 2002:a17:906:80e:b0:abc:c34:4134 with SMTP id
 a640c23a62f3a-abc0c344449mr1204669966b.18.1740449773649; Mon, 24 Feb 2025
 18:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-8-CFSworks@gmail.com>
 <38091cbd-d531-416c-9bdb-9f81f5c52f88@gmx.de>
In-Reply-To: <38091cbd-d531-416c-9bdb-9f81f5c52f88@gmx.de>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 24 Feb 2025 18:16:02 -0800
X-Gm-Features: AWEUYZlohB0X_EWuotDODO3zkNKDmmnnrFHNzGdMAHRUCbpYfW3hLC1ySffa-dQ
Message-ID: <CAH5Ym4gXKQ=YadAT=koSeuMvqavwYkP1OAdwSgnUWhUB+krQMg@mail.gmail.com>
Subject: Re: [PATCH 07/17] arm: Replace 'adrl' in EFI crt0
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
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

On Mon, Feb 24, 2025 at 12:42=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 2/24/25 06:55, Sam Edwards wrote:
> > LLVM's IAS does not (and cannot easily) support the 'adrl'
> > pseudoinstruction, and ARM developers generally do not consider it
> > portable across assembler implementations either.
> >
> > Instead, expand it into the two subtract instructions it would emit
> > anyway. An explanation of the math follows:
> >
> > The .+8 and .+4 refer to the same memory location; this is because the
>

Hey there Heinrich,

> Are we sure that we never generate thumb instructions here?

Completely positive; the stmfd/ldmfd (at least) instructions do not
have THUMB encodings, so this file can only assemble for ARM.

>
> > .+4 expression occurs in a subsequent instruction, 4 bytes after the
> > first. This memory location is the value of the PC register when it is
> > read by the first sub instruction. Thus, both inner parenthesized
> > expressions evaluate to the same result: PC's offset relative to
> > image_base. The subtract instructions then remove one byte each
> > (low, then high) of the total offset, thereby getting the absolute
> > address of image_base loaded in r0.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >   arch/arm/lib/crt0_arm_efi.S | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> > index 91b0fe12c51..235b3a0c48f 100644
> > --- a/arch/arm/lib/crt0_arm_efi.S
> > +++ b/arch/arm/lib/crt0_arm_efi.S
> > @@ -149,7 +149,8 @@ _start:
> >       adr             r1, .L_DYNAMIC
> >       ldr             r0, [r1]
> >       add             r1, r0, r1
> > -     adrl            r0, image_base
> > +     sub             r0, pc, #((.+8-image_base) & 0xff)
> > +     sub             r0, r0, #((.+4-image_base) & 0xff00)
>
> These are the instructions resulting from building qemu_arm_defconfig:
>
> sub     r0, pc, #24
> sub     r0, r0, #16, 24 @ 0x1000
>
> The last instruction subtracts 0x1000000.

I'd have to see the machine code to be sure, but it looks like that's
the 12-bit immediate value encoding of:
(16 >>> 24)
...which would equal 0x1000, as suggested by the disassembler comment.

Cheers,
Sam

>
> I can't see how your instructions would be doing the same.
>
> Best regards
>
> Heinrich
>
> >       bl              _relocate
> >       teq             r0, #0
> >       bne             0f
>
