Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08C1C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 20:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA75E80F0B;
	Fri,  7 Mar 2025 21:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MjqzloPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F14F80F4C; Fri,  7 Mar 2025 21:17:02 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38787808A2
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 21:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so2032769f8f.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 12:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741378618; x=1741983418; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCG4XzwCNBmRXb6tIsju17Xyh5EDbCI5ahl9cDEwImw=;
 b=MjqzloPmWueOC4r2sxoLhXM5K7LhyjDnPnPDD4oJ0jIT3yIccdav+jVZYKqm7Hi2fu
 kClHt2PcIOAJWZvh1n4UUV6k379SDOB6iDRBnIUnr4qG5+M7lSQSdfTctDnlLIkKGyxB
 +LaP68Q9V/18TFB53O0iMQ8Tf5pSehn0gai5tEBUIRguh8Rus7JCkBWQIKbigXEVxzL2
 PDgI7oYErVRHQ2GQWQRxbUgJUKhUeDsy9xPKzsk0Pzp2OcpTtBJjleiMdUCIqweelnLb
 tzNGOFojXAKoGhqWdGt/XlDP3j9h6Dr6BxUDucoqmf2tcha0DGjGUdS0YYeCYifT4uiG
 vsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741378618; x=1741983418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCG4XzwCNBmRXb6tIsju17Xyh5EDbCI5ahl9cDEwImw=;
 b=GZHgLuKNMiYTBfpo4WKgATY1DOQK/GC8+m8fVYTxOcnqfAiRYoXDMnTLArmxdz8iYk
 ussRKd8skV0D9gMDVqPFT+/zj2CjyeilF/Csyvg0KuwFQrD+6qhhLBIBYYefF/UxwTmo
 QbGHcbrCsjU7QQarqbL+6vmuZMAlZ36urfBc5ZqDCbQpPRVujw9LqlUBkaydNx53bitA
 TlcnGV1eKS7fwSRQV8SzgbQZgEZ97BjD8o+CkF/Lvb0LSFGQFTIhrVdSm53TgJoUL7l9
 X6Z1tFfDeoUo8G95Ha99z2zVqs9cG6n22JuYNQIBtGl+Qwawk6k/ftT4env3GcirVqju
 /eRQ==
X-Gm-Message-State: AOJu0YzVigjLYovcuZSJiCVpRpIBYS6L5PPsVBeYQ0PQugK7GgZIJ4lu
 NWgbzQ2uHut7qCnOINDnrRDRPRL05fnqsLBm+/dSJQohkjVbPIaks6TZHahVPBpbn54kIFDRd5F
 ZmiMye7WqwiEXGqHZBCT5jRSOGBU5sQ==
X-Gm-Gg: ASbGncscuAybAjtoZWjGmaIkQ99mLgM2M89knfJArj7jp/Z1ob/s3W9PjQgA4pgcNvj
 Mk0KZ4nK/QlWZwvhGRhQihD6eoxKZMRlTXQlIBvQ2Qx0atcuJ8DsMD9HD5DbHFMGl36DyTAIfQJ
 7OwV8EJ3qJvgVzCxj9er4W0D7Hi/Q=
X-Google-Smtp-Source: AGHT+IGNnVPkcQF8HDDMBN+zDBwrotHcGElHprp+IUeqq3nCzYiiykcVzaZXypZlnAfkPqwB7CNBeQwuQhx31RYEhHM=
X-Received: by 2002:a5d:6d05:0:b0:391:2dfa:9829 with SMTP id
 ffacd0b85a97d-39132dc517cmr3616356f8f.50.1741378618432; Fri, 07 Mar 2025
 12:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20250307101629.51561-1-clamor95@gmail.com>
 <20250307101629.51561-2-clamor95@gmail.com>
 <20250307190543.GT2640854@bill-the-cat>
In-Reply-To: <20250307190543.GT2640854@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 7 Mar 2025 22:16:47 +0200
X-Gm-Features: AQ5f1JpvVebYI14-vhu_CaBu1yMRM0_0iHBzH81-kqbpAXrh0lB26HPGn9oo5bg
Message-ID: <CAPVz0n0pxESUWLScUyKBUXUrfYzqwnKuyfru10YdfHSTYwxo_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] sandbox: swap bloblist and fdt loading address
 sequence
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
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

=D0=BF=D1=82, 7 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 21:05 Tom R=
ini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Mar 07, 2025 at 12:16:29PM +0200, Svyatoslav Ryhel wrote:
>
> > The existing memory layout places the bloblist at 0xb000 and the fdt at=
 0x100,
> > resulting in a 0xaf00 size constraint for the fdt. This constraint has =
been
> > reached. Lets modify the layout by moving the bloblist to 0x100. With a
> > bloblist size limit of 0x400, this allows the fdt to be positioned at 0=
x500,
> > thus expanding its permissible size.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> [snip]
> > diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rs=
t
> > index a8b0d7f0395..99459815c25 100644
> > --- a/doc/arch/sandbox/sandbox.rst
> > +++ b/doc/arch/sandbox/sandbox.rst
> > @@ -658,8 +658,8 @@ that are mapped into that memory:
> >  =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Addr       Config                     Usage
> >  =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -     100   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
> > -    b000   CONFIG_BLOBLIST_ADDR       Blob list
> > +     100   CONFIG_BLOBLIST_ADDR       Blob list
> > +     500   CONFIG_SYS_FDT_LOAD_ADDR   Device tree
> >     10000   CFG_MALLOC_F_ADDR          Early memory allocation
> >     f0000   CONFIG_PRE_CON_BUF_ADDR    Pre-console buffer
> >    100000   TCG Event log              TCG Event Log
>
> My question is do we have room or not to set aside 512KiB (as the
> "should never be this large" value) instead of not quite 64KiB which we
> can possibly hit again in the not too distant future? I think I checked
> earlier and CFG_MALLOC_F_ADDR + CONFIG_SYS_MALLOC_F_LEN should still fit
> below CONFIG_PRE_CON_BUF_ADDR if we do that (and also give the bloblist
> some room to expand).
>

preliminary memory map:

0x100         CONFIG_BLOBLIST_ADDR
0x1000       CONFIG_SYS_FDT_LOAD_ADDR
0xf0000      CONFIG_PRE_CON_BUF_ADDR
0xf4000      CFG_MALLOC_F_ADDR
0x100000   TCG Event log


> --
> Tom
