Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBADAE9D3E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6EB83A47;
	Wed,  4 Feb 2026 15:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jYPh157S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074CB83015; Wed,  4 Feb 2026 15:07:52 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1DB802C1
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-649389b1cc5so6480816d50.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 06:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770214068; cv=none;
 d=google.com; s=arc-20240605;
 b=fKv236OPX0yPbNl3GoQs0aneaWcS2fgdK52igXhwSyF2uvlpzOpDOZF5Kck27jdOQt
 4WWH+OWrTER+6SH8JVK+Y7EdsWuCLGpe2FAL908RSOs0EzTk7CoZxUjggzrVdWJwD1Mb
 nqWE8NqV6PZyu0K04Lqh34idlYOmuU9AbTzIDASk+Vn9uLNgdB7zmyFgij9awNe+JrXG
 NuEdTFCqNAnaxXPKTOZNdkZD8n/9/3W9QqhfvfsDobO9cL1xPAxzxelljJMtZsj+PtCR
 +lF49FEni5yzAS8xr1VYTj9+IE88yjdiKxtNT7FQHnEYClQVS9qvs0k6bgya/mJ8aEuf
 wRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bA5ZAkaP6iIaCvHK8PKabYep6a1fM4N/GdGzTwBrzYk=;
 fh=PYXXYeIUYKQKzwhnWyiNj31GpMwafeGd3kBYhqwdn1Y=;
 b=ZF2JzrBgFVjhlgqhUipOQG8IaiFdiLuL8Ddx2yu8ozq6Go18VylP/V/U9YJmgYkOpG
 egt3ao8dihY46BSSuQgRsVMwWw0Saj5dBD1FvmkfSPCJArzICKCKsAKohMr0KkNJKrJn
 6Kydz1sdkqdwylkA50WdsCakYSdzpCYHaNcwzw0bsuYpu0GuoTirNPKP/QUF3ZtGFVeG
 lTeaUW+e4Ca5pY5Na97z/h9+Gu2SaqLN9qVw8wtMAR6nCSp2VYgIuEZxhGFnYVfdlPo/
 BsoyTBu49zbVNgS7QLmC/JNN5ZiKvS8BKUdWCb3ZzbATddRqCxZ6RTEEI3qFntTD8Udo
 bswg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770214068; x=1770818868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bA5ZAkaP6iIaCvHK8PKabYep6a1fM4N/GdGzTwBrzYk=;
 b=jYPh157SsMyTXRENV+10cu+RLr+LcW3hHpKrZM2ERWINzYRhfdGo1rNWVzE7dpqSid
 jkLQj+o9LWbuHWXLvIBtspI5p/8Wqw3/DgV0/in9o8n5JX9X945+/NxuTMDQl/DU7hGG
 7sYoDPCZydhJt5QdjIuS/6BV1tLanrm2B5G+m3Sx0TiL+UGXZVfaN9JfbhtM3WlyUnih
 ylmaXoXY0fmPfELcSaDsZhEITtp2zpeAihwUZOBvj6tCyOlW6bI2MR/np1oJI9+OcbNB
 +sCLqH7HdGikXc+eDAPU4WKI7F39+Lo5ScYbu0phez/mar+gVteqU6IuegIed8G3tvOY
 Pr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770214068; x=1770818868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA5ZAkaP6iIaCvHK8PKabYep6a1fM4N/GdGzTwBrzYk=;
 b=LSLF/QmeSrW0KI1MGFzkydXPXSrLCt++QuXJBZ4IrPT/e2X42IhuEGlhq2pQlMdQWZ
 WJZog0RBnO9dEZnKpD30FKNRxmQLL3DOP4GNU+zaCuB2/dhgkcOtQ6hneZoJDik3ICh3
 RkCKOD6D17rPMrIroxmwsx2xWdRNajRMVFunCCHWZGkwgL3oz/zt0n/e2ZiwflIznVNR
 WxSyiIBs8uOm8QrMviVQVtjMzlrLVRC0Nt7u0PJjNH3I4PlgoA/jp2DVTs/zsoMjMnKY
 Y7Mm82q+340I+9ROpwMYvD9Q4wpktDz26GnE1+rM+HOVbdIuZgrjeOwBN5oX7fTGWh42
 nG+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAwS5tJbGz5LcQ715qGQZSwAFSLcPPV/nbzbOl33uOvIJ8P2trXGuXvxNx89+b+cxJkrlsz0c=@lists.denx.de
X-Gm-Message-State: AOJu0YyG1gRjNlD48iMAosNOt3Gwe4UphxWE+vOnzhKPS+lNVgFZT27X
 cWm8QKtBh40aSshrgINHb+nSQMtueHSLOFOXR25MZxSRh5ZmU+dxUYqQ0w9XgCNw6pOBE0aZgGj
 jZnXwiq6vDWxVkxqGIUgzkKks1NAthmZXbfQMNNiyWw==
X-Gm-Gg: AZuq6aJwN7ypyZbjXlnbcKWNgGy2WBbMWk8PdvUXHq8A7BZC4j55uLqW4RtBZ6KsyjZ
 7CIyqsVdX94O7PCnaARS9uHLFphSO8tAMZmJ23PMDAUSUy64arblOoDzLhdI1eGrBnuVpPNGUZw
 5XcXvF+ktJwiAgo8KENbkko1XSo+9KrprQsTmm+IUulir5q75X3tG6DHPxy/gJ38dzpcT0rDD2I
 zogD7FO99apivTh31Pq4ZBkFNtIZ1d22zRZMU+5mO+HDXXhtL10ZzBrMxp38vI1U2s/tAE=
X-Received: by 2002:a05:690e:b4a:b0:649:5f25:3f77 with SMTP id
 956f58d0204a3-649db33da89mr2637184d50.21.1770214067781; Wed, 04 Feb 2026
 06:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20260130110132.8018-1-ssunkkan@gmail.com>
 <DG48IKMSA1IL.2D1LC7O9QABVJ@ti.com>
In-Reply-To: <DG48IKMSA1IL.2D1LC7O9QABVJ@ti.com>
From: Clus Tom <ssunkkan@gmail.com>
Date: Wed, 4 Feb 2026 22:07:36 +0800
X-Gm-Features: AZwV_QiYRF-krBDTebBiN9p-NdrVrUyJgNJz3qqCvJ7hm3cGL1JCIxpDR8norGM
Message-ID: <CABjXDjFpx==gBj-pj39WBQRMTrz0zAEZcKAH2s3fYPgUXKfPdA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: ids: Add support for Puyasemi flash chips
To: Anshul Dalal <anshuld@ti.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 04 Feb 2026 15:36:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Anshul,
Thanks for the review. I have sent v2 with the requested changes (using
existing config and adding datasheet links).

Best regards,
Ssunk

Anshul Dalal <anshuld@ti.com> =E4=BA=8E2026=E5=B9=B42=E6=9C=882=E6=97=A5=E5=
=91=A8=E4=B8=80 13:42=E5=86=99=E9=81=93=EF=BC=9A

> On Fri Jan 30, 2026 at 4:31 PM IST, Ssunk wrote:
> > This patch adds JEDEC IDs for Puyasemi PY25F512HB, PY25F01GHB,
> > PY25F512LC, and PY25F01GLC flash parts.
> >
> > site: https://www.puyasemi.com
>
> A link to the datasheets and a reference to the "Table ID Definitions"
> would be helpful in cross-checking the correctness of the IDs.
>
> >
> > Signed-off-by: Ssunk <ssunkkan@gmail.com>
>
> The patch doesn't apply cleanly, please rebase on master or next (as
> appropriate) for the next revision.
>
> > ---
> >  drivers/mtd/spi/Kconfig       |  6 ++++++
> >  drivers/mtd/spi/spi-nor-ids.c | 11 +++++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> > index a9617c6c58..c223862a46 100644
> > --- a/drivers/mtd/spi/Kconfig
> > +++ b/drivers/mtd/spi/Kconfig
> > @@ -217,6 +217,12 @@ config SPI_FLASH_XTX
> >         Add support for various XTX (XTX Technology Limited)
> >         SPI flash chips (XT25xxx).
> >
> > +config SPI_FLASH_PUYASEMI
> > +     bool "PUYASEMI SPI flash support"
> > +     help
> > +       Add support for various PUYASEMI (Puya Semiconductor (Shanghai)
> Co., Ltd.)
> > +       SPI flash chips (py25xxx)
> > +
>
> Can't this be included as part of the existing CONFIG_SPI_FLASH_PUYA
> which was added by the commit 5c73c05f20be ("mtd: spi-nor-ids: Add Puya
> Semiconductor chips description")?
>
> Nit: Would be nice to see new configs being added in alphabetical order
> in the Kconfig, though the order is not strictly followed currently :(
>
> >  endif
> >
> >  config SPI_FLASH_USE_4K_SECTORS
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c
> b/drivers/mtd/spi/spi-nor-ids.c
> > index 4b7b358eac..2e479ab8a1 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -624,6 +624,17 @@ const struct flash_info spi_nor_ids[] =3D {
> >              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
> >       { INFO("xt25w01g", 0x0b651B, 0, 64 * 1024, 2048,
> >              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
> > +#endif
> > +#ifdef CONFIG_SPI_FLASH_PUYASEMI
> > +     /* Puya Semiconductor (Shanghai) Co., Ltd */
> > +     { INFO("py25f512hb", 0x85231a, 0, 64 * 1024, 1024,
> > +            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
> > +     { INFO("py25f01ghb", 0x85231b, 0, 64 * 1024, 2048,
> > +            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
> > +     { INFO("py25f512lc", 0x85631a, 0, 64 * 1024, 1024,
> > +            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
> > +     { INFO("py25f01glc", 0x85631b, 0, 64 * 1024, 2048,
> > +            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> SPI_NOR_4B_OPCODES) },
> >  #endif
> >       { },
> >  };
>
>
