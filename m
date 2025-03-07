Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84D9C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 19:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5733380E94;
	Fri,  7 Mar 2025 20:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hywj3cvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E57A80F0B; Fri,  7 Mar 2025 20:29:48 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E671E808A2
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 20:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390f69f8083so1885230f8f.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741375785; x=1741980585; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylQZphDn+NiwElXgKxQE6NhB5VapYbqwCszlSrMTCMY=;
 b=Hywj3cvg2KyoiCMNkMWGQtMoFpLy2v0p/EZfnncf02pVDTHh7H/pry4hi/wPbWXM5k
 Myup9UR2GHOl8XE0bh02fpRAUwjR4C/Pcr1juMAfv+RbyO0wwHdu+o9nyPr6N0i9WgsZ
 BbW+E5gvtNj8Mi/pHrbHE691inN0d40SRQvQsHtzq5pVlB8WnItZ/9DxlByk8a66Fc+k
 6xS5dCv1Lq8Xd0HLqJPRYgSVrBM/Tslft1CbxCHy7ext/qdbAzIklIs5eKPoqPnHi1JY
 R6fXSwjPqee7DRf5ek3fexpH53Ulwt8kvWIM1y84cQKlXflJF25/ZWooZy4kwWUF31C4
 G3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375785; x=1741980585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylQZphDn+NiwElXgKxQE6NhB5VapYbqwCszlSrMTCMY=;
 b=pWB1Brg5UZhQcj2Epr4ZDciTQ69oT9htDRYctlsDINxHZa51Ku6WC7fZiHX4rJQNne
 kfwK+74Hhd4BUc7tDBKwnlJfTm1BWgRMcN3E9PvT1oVwdRiRoifumtU4NJXBUhqJ7T9G
 HRMCN1ao8LGKvMwn1NVk6a4igT61ualZvMis+/FGN/uDkgMF+uWpYN/dp5Ei2hJuo4Fj
 ERTKorFSSrvhWQLH7Z7mww90vq3VDftkt2tArCwwi7GG3MlT4mlOK1nmL2jLLaehGdd6
 WUN2aUiJowvYKVopZ0PunVH3hKfHTNcib2CMwHhg+nnKsgG0/pIHn4hT2r/h3Q0qPQHV
 7M0w==
X-Gm-Message-State: AOJu0Yx3KlM7Yx3Pt6DNubjW/aK19rEvrEUsbhGUCXxqxRsKu/X/oPn+
 UZi6HkQ9yggak0mhGOIr0DK/VTL2jdJx1gi1VPNeTVGeDwL9FcCBxzCrK4Wf4gdt4vUBZZX4/yZ
 k11uwjYTO3ADvLQHGuRR4M9xKnys=
X-Gm-Gg: ASbGnctEQvCmEG4XHcWhEEJH+vF6GtWpjiUa7QK3momx+f8nCcSgxgsjzegfQrXEmXD
 JO3IX15m8LLAcMdw2wQeoJVU6ylNjvYO0F1ujOCCCNltF+Yfp7wWQQVmOqt6uWSeOLIbHSnaiIu
 ayfSPcF9Ced929wbb/G6wT5g6bTy8=
X-Google-Smtp-Source: AGHT+IE4ETqe7ejCz1Z0VdZI05th7LrZBiGiB7EREkCyv/N+qh4rwYzCjfG1rxFl0DhLOIS2sCbSnakmZGpnywI7LgI=
X-Received: by 2002:a5d:64a4:0:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-39132d45d52mr3028678f8f.27.1741375785129; Fri, 07 Mar 2025
 11:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20250307101629.51561-1-clamor95@gmail.com>
 <20250307101629.51561-2-clamor95@gmail.com>
 <20250307190543.GT2640854@bill-the-cat>
In-Reply-To: <20250307190543.GT2640854@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 7 Mar 2025 21:29:33 +0200
X-Gm-Features: AQ5f1Jp-U9L8z3NBGyfW1UndvaZQz8XKQ2zbc1WxmbyBPPSAanI1nVBeFHg7F-s
Message-ID: <CAPVz0n0pAJTzE9v0OU2qY29yFjRg5D10eeju9ghOchqzVvJEaw@mail.gmail.com>
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

I will configure and test everything but I cannot do anything without
Simon agreement as the sandbox custodian and since he better knows
this setup.

> --
> Tom
