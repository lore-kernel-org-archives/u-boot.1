Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F54D3E1AC
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 04:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290C988D5B;
	Sat, 19 Oct 2024 06:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PBjUTYBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D791588995; Fri, 18 Oct 2024 23:48:14 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C847588B23
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 23:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e29747b7532so372736276.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729288091; x=1729892891; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbB+X3UY8BaIONAC/GZNs5O5zTmzdE5U5TW42xCxUzA=;
 b=PBjUTYBk3/d2YmFf79E4IRGkSnXffaJoN0rSINV2Zy2Uadre5R5T7shxtkX5ckMq2R
 10wuiwUS/kBHLOVmjtk7H8iIuc7qkSFC7LB1JwDjqKlY3K1MIF3oDq6idYw0s7F1Bdpv
 Wq8w2nW/MOSOqJtK+X9UcF+W5ILMeQaZW/YFd6tQQzHuwXHgAzQA39P4cg87E1DFmBVx
 AE/14Of6K/Mww9u1h+T59UEqOYMDOLTnsRY86zksOKT7DO0llwAGF9tDRNXKp9E4hwSS
 zy9dxc1dVImL4FXxDFIKl7i7HG8dNjj2dhrYvPaDfv3f/chyOypJvjf482RxQMqmmo56
 p5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729288091; x=1729892891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NbB+X3UY8BaIONAC/GZNs5O5zTmzdE5U5TW42xCxUzA=;
 b=Z1BKTqdQsz3xunnkX9+TQmHXz3LJuhDrt2+zrlT6w0FSChptdJEczp/SpiqLOWSJRb
 /hk/ovRusZXlAuPWuqTXMeq4pYkBosn6RwTogKsTOumQnGfk8yythz9qYT9HQz7zgsG+
 cc/QQD4ITR4C4xaEH/3sNqx3Q7IPhJ/EwK4dDWThQmC7dXLfzwXyYeQdao/UcJCCi8c5
 zILN1pu5cOHph9FJGXvseNR5pihA7qawEUp9O/bsVu+N5hV32xLPbUjoiGDuRZRw3bWc
 AldgdLDZ7A9P3zXaoUkAKQCAxo/c9lDIHOtz1InptL17BeQFt2yY9ioROSggYI9TYNzV
 uSDQ==
X-Gm-Message-State: AOJu0YwreOd8SHS+ii1iygeQTARF6k4hOb/Bn/r8xNbnlyxpEW/uaAtk
 +HowdIbeI1rjpEF9ZyuSXtxTfxZtCzL5JccwVp+7Tcq3V6c+UzHu3ZY6XOJwxPaeFps0o5h3SkC
 iMCN65fVMc/DQ01axr1SoF2uxwiM=
X-Google-Smtp-Source: AGHT+IHBOTnknVYKiUTL1txKTeW2Xio/rnjJMOsy3R3qp+S2sW3ODSHzvrlGGheh0PlgI2Y1gJsKaDVqZpyIm9v4pJ8=
X-Received: by 2002:a05:690c:385:b0:6e2:c13e:2082 with SMTP id
 00721157ae682-6e5bf73ca9cmr19198667b3.1.1729288091585; Fri, 18 Oct 2024
 14:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-3-l.rubusch@gmail.com>
 <ce29c957-4198-4947-b7de-7e10ed385eab@denx.de>
In-Reply-To: <ce29c957-4198-4947-b7de-7e10ed385eab@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 18 Oct 2024 23:47:35 +0200
Message-ID: <CAFXKEHZLwbU=w4LH4iiZeo4ycwOKjgi5YZesHHgxzy6Ac+TOUA@mail.gmail.com>
Subject: Re: [PATCH 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sumit.garg@linaro.org, sjg@chromium.org, 
 xypron.glpk@gmx.de, michal.simek@amd.com, jit.loon.lim@intel.com, 
 barnas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 19 Oct 2024 06:39:29 +0200
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

On Mon, Oct 14, 2024 at 8:42=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

[...]

> > diff --git a/board/enclustra/mercury_aa1/fpga.its b/board/enclustra/mer=
cury_aa1/fpga.its
> > new file mode 100644
> > index 0000000000..cb42d61fbd
> > --- /dev/null
> > +++ b/board/enclustra/mercury_aa1/fpga.its
> > @@ -0,0 +1,32 @@
> > +/dts-v1/;
> > +
> > +/ {
> > +     description =3D "FIT image with FPGA bistream";
> > +     #address-cells =3D <1>;
> > +
> > +     images {
> > +             fpga-periph-1 {
> > +                     description =3D "FPGA peripheral bitstream";
> > +                     data =3D /incbin/("../../../bitstream.periph.rbf"=
);
> > +                     type =3D "fpga";
> > +                     arch =3D "arm";
> > +                     compression =3D "none";
> > +             };
> > +
> > +             fpga-core-1 {
> > +                     description =3D "FPGA core bitstream";
> > +                     data =3D /incbin/("../../../bitstream.core.rbf");
> > +                     type =3D "fpga";
> > +                     arch =3D "arm";
> > +                     compression =3D "none";
> > +             };
> > +     };
> > +
> > +     configurations {
> > +             default =3D "config-1";
> > +             config-1 {
> > +                     description =3D "Boot with FPGA early IO release =
config";
> > +                     fpga =3D "fpga-periph-1", "fpga-core-1";
> > +             };
> > +     };
> > +};
>
> Can this be generated using binman instead ?

This would a oportunity for me to learn the binman tool. Great idea! I
need to read a bit more on binman to get a better understanding. I'll
give it a try and let you know. Thank you.
