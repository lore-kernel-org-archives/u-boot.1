Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD6FD14885
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 01:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1A083A26;
	Thu,  8 Jan 2026 02:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQsHineF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5E683A26; Thu,  8 Jan 2026 02:32:14 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3086839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 02:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-78d6a3c3b77so15616847b3.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 17:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767835930; x=1768440730; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOC+5f2zTA9OGS9ncObF3JNVYRLFkMT7a5wKqEP895g=;
 b=BQsHineFC6o8tKj33skAxQ/cVexZ3In+ETBpcDfXwznrPhJVR323Wud7uCNTeIn720
 C+yF67Vpt5RTQ3vbbypOIOcEXyDrAx2l38SEToZSkxGQ1BcHwVLcoaJQHvsJqxJt9zf9
 nOIrnMGd4kCaJsALC6mx7OB/2aJnZIzV4RbDS54UnNYPBfaHrkcaWFFgQCxjMizLkv+C
 H2yINfEIJ6wQ8k7LcdCGvKoadje+AkH5Ln5aLk4yveTD6KPVF/yPKufFNHJu6FbKUFHy
 oqQlhDFSug7f126XAIJJCjVAOkTpjGt3kgbdxfesewB9ithhqu3HJ+gH5i74R864Id+x
 Eb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767835930; x=1768440730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOC+5f2zTA9OGS9ncObF3JNVYRLFkMT7a5wKqEP895g=;
 b=c+hN2W0p5SQnyKPIMr/IVq3gsmENFWkghi5tkk0cRBsOgF3y+dYj/Fy1vtY+DMCWqi
 v4G4xvou0xe05y1cm4415YUOMeBEWW9QZxSk0vjYIjU0IEj1jJ4CFrjn6cF45e83vBco
 c82rnKyw6nK3JEqKqbe+rjf7Hnj22y7xRrDBphu75RP8EetlDUlPBalu34Uf1NY7oO2h
 di1Qy9tgNpBjHO7LHGjpoP2okfv/Vi04gM/ren8CgUZtS2g+FYft12yRcZugT/xEWq4P
 5KDQlmNM8ZUj3jWET+UL+niwzmdlc1kfa9pfKWV4NC0YQQjhiNS6KIKvXmNaZXiGaY3S
 /5Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOFKl6XPvLKno/5KBKsdTv/54sC4GmUywX5DkDH52nCb/khDzvfWy3md+4FCe7pI9AsI6yt0w=@lists.denx.de
X-Gm-Message-State: AOJu0YxPZuEDQJ6Gj8LgfIW2Q8b88YhIZs7fpmQgVATXo3H2wLDY6szp
 4iWdaJ6lqo624yPuP5Jjm8+fi15OGIF+5AmaN8/9qeR2RVI/p+kOdDJkzwA6ll4gE0dtz1JAQQG
 aXxRfsxE2Fdw3eRyLyTUpsLh9bGoEeuY=
X-Gm-Gg: AY/fxX42ytKP8ZGdJSTWI+BOeJINEmuNFntEAHm0mWDkF74xFsWBoBMgym5WWT5WiM2
 jPrjruGX3wZFi8g1kVZJvUj24yGMGBYs/cixnyevmqhHxwZJ69eKcxSwxQ/MVDkehCA1qUaOvOm
 km0OHLe/WxqPFN2g/leVrrM1Fv2xGyPXsmHJqU5OyX1xXziRaCT1sogMPzSX+MciORZwlr37NAZ
 fpthgKISHGkjYqN1UPLGb1EfWG+4O+6tDN1FK/DEFyUjjhgwHB3uihGl5rhg/pBDy2/lOe8hRIr
 GN/fgkN3OLE1kLSU6+D0hhoQNMY=
X-Google-Smtp-Source: AGHT+IEdOPfS0TedhexF41T49QAd9J5QJ8EHKCfDDXnc5xG1TgSlEfUNUQcGjSzm4ZS1nWcPubvbYg8BPk54PEHzPv0=
X-Received: by 2002:a05:690e:1445:b0:646:69a2:d400 with SMTP id
 956f58d0204a3-6470d2437edmr6445730d50.10.1767835930201; Wed, 07 Jan 2026
 17:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
 <20251226-xspi-v1-1-4bb116750dba@nxp.com>
 <20251226145748.GD710860@bill-the-cat>
In-Reply-To: <20251226145748.GD710860@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Jan 2026 22:31:56 -0300
X-Gm-Features: AQt7F2qwmmM7RVJDJ3J427OeB1eTp9IgdIB5jv9GlXPdADHGni8_GUleJrLV75c
Message-ID: <CAOMZO5DxdMTcFjrNi10dCQ2Fwjj7VRipFE3Ns2LRKNRor5Vi-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
To: Tom Rini <trini@konsulko.com>
Cc: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@nabladev.com>, 
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexander Dahl <ada@thorsis.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
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

Hi Alice,

On Fri, Dec 26, 2025 at 11:57=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> > +config NXP_XSPI
> > +     bool "NXP XSPI driver"
> > +     depends on SPI_MEM
> > +     help
> > +       Enable the NXP External SPI (XSPI) driver. This driver can be u=
sed to
> > +       access the SPI NOR/NAND flash on platforms embedding this NXP I=
P core.
>
> Does this driver build on sandbox? If yes, great, if not, this needs
> more specific "depends on" logic.

Please address Tom's question so we can move forward with this series.

Thanks
