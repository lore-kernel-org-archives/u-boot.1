Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CECD743D8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 20:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A5689336;
	Wed, 20 Nov 2024 21:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljLWPutd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48D589328; Wed, 20 Nov 2024 19:40:42 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CDC8901D
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 19:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6eea5763561so3778097b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732128039; x=1732732839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2DGJv5IWwXOAbXcJTEnQSHSdYQ1Gn232u2u88x/X5Q=;
 b=ljLWPutdb0YTkO0RM2gDbGzzb8Z9yqsntcbCoyDVVlLZnjiuykNOWKecWCLV93UcyO
 7RIUZYjlWRJtGavoz5USq3oWxywQ9OWwe7VTEISOUMaRQHNWZsTrMx2Fq6zxa5MzPmyU
 2AYbLH9Eoj7Yzy3Z3dxI3qPY2p/zkYXrztUshU1iBcQqPHNI3J9ytkYLtUAxPYzEKQKz
 HOtar/ICyo+5Wi+zPbwFP8MuYzJhnw6bKdoSPFSrZqlMw8ZU4rzw09qKvmYE6oc1fQQt
 ChxrtC7iM+hsx2hS+s/DJJlLZzbHguqFDJSUfNjgIkt7pup/uDf1YNRZi2NL4vIhWM/O
 dhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732128039; x=1732732839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i2DGJv5IWwXOAbXcJTEnQSHSdYQ1Gn232u2u88x/X5Q=;
 b=unpSVQKBsGqFfvrb3wIlZTIeL3QDezfM9BIsJt9lj7ROKOF9IPdJKwUuWPPS/cY87F
 N5+lzUzHJ84q2DV5J6EG4p3bESvs8mkoPbmdmlyYcjvkqIJaeLbqD0AUvEq8XwkSJuSv
 sfYagBWwuaw+o5QC36+D++hGVWArqCql/UrPmFopC/qu8LpLEeHgPZBWJWWjfIMumHks
 hXokxl/KGiPc9YUs3h+kotUBy4svjNuR2ZHeinCJDCOA5ADfLiddG7h+h2iMrr+A2vHh
 36Rr0qwcBJMOJEqIcptdQjuDx7CpJWosbGYthq4Oqf6l+2LGcprJd4e25Got1YKsnehQ
 0YEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw8yO9EVyhVW5fm36ksgoUnzOCW8rbWx1NMOJ06yp9Rbp8LD8X+Uv716vJFcjZDiiuHEyd3t4=@lists.denx.de
X-Gm-Message-State: AOJu0YyZJuCdbLN9iCn4pdhS2QZQoTO3SEhfn0HYR7iIv2OUqIZTAnhG
 ju0Iv43KWO9X40kG8gccGPSAIjSK3IFAxls8ZdYzz3sHTjOCVKfZHFz4b+VRSPh6SwzqyiXziJe
 R1NU/g1SrNFnIuKB2bV9WC1axCiA=
X-Gm-Gg: ASbGncsO39c/l6Ab8X9ROGRgS2qTA7pBSqaIFLv3bn9wTQzHVntjSSNQwFHIizsRWxC
 3V1p/I4F+XvmV4xyH4r1jJL++ZhKMdfQ=
X-Google-Smtp-Source: AGHT+IGAqCI1s7MZlNI1l/a10kRogthWu45FdXttcPxvvyZOtUNCob2AUAFIVPMpe20H+oudBNFO5R0foJhFkX2Zoo0=
X-Received: by 2002:a05:690c:9a90:b0:6ee:4d4c:3091 with SMTP id
 00721157ae682-6eebd2b4e63mr16144387b3.6.1732128039319; Wed, 20 Nov 2024
 10:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-4-l.rubusch@gmail.com>
 <CAFLszTiUwscvAX20rtP9HdVzzE-4UDAnR0m1TVSHEjqmSrvbNg@mail.gmail.com>
In-Reply-To: <CAFLszTiUwscvAX20rtP9HdVzzE-4UDAnR0m1TVSHEjqmSrvbNg@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 20 Nov 2024 19:40:03 +0100
Message-ID: <CAFXKEHZJ7OXsQ5=Pi+9ZDpt5wMdO2spzvEjSNupQVuNrMO2EqQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] doc: develop: Fix typos and wording in
 binman/entries.rst
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, ada@thorsis.com, 
 xypron.glpk@gmx.de, mkorpershoek@baylibre.com, 
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com, n-francis@ti.com, 
 afd@ti.com, al.kochet@gmail.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 20 Nov 2024 21:41:16 +0100
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

Hi Simon,

On Wed, Nov 20, 2024 at 2:38=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Lothar,
>
> On Tue, 19 Nov 2024 at 15:29, Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >
> > Fix some typos and wording in binman/entries.rst.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  tools/binman/entries.rst | 104 +++++++++++++++++++--------------------
> >  1 file changed, 52 insertions(+), 52 deletions(-)
>
> This file is actually auto-generated, so you should change the
> individual entry types which are used to generate it.
>
> As Heinrich says, we tend towards 'International English' rather than
> US, but it depends who wrote the original code in question! But we try
> not to do patches which just convert one to the other.

No problem. I fixed the things Heinrich and Alex mentioned, as of
behavior and ralionalized, I reverted that. I'll drop entries.rst.
Still I changed then to use "devicetree" as term uniformly in
binman.rst. Pls, let me know if this is ok, or too much of a change.
Sry, for the fuzz
