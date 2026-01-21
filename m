Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AEEC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F9DC83A3B;
	Thu, 22 Jan 2026 00:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k10CniaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4130B839DF; Thu, 22 Jan 2026 00:17:54 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E921E8313B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-5eeaae02888so114672137.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 15:17:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769037471; cv=none;
 d=google.com; s=arc-20240605;
 b=j4F+VxorkPV1PmKmtxQJwuWW1Q9NBaLpwgijE4XOSwmEx/fkOYK2JEGyBJN48Ps7YU
 go6dJPv7fkENA1oGNo0C4We2cjq+9dY7OlARn20rdfPevhraUzPQsgNvVWPXteBjFXo/
 TNSy3T9ZAw0mR3Kyt5By5lCow++z3pPFnujKUDa8NAhiX3HbXRKErctjABJ2dM9wE3SA
 jaf0bLG4Cigc8e2OsMSKYd+Xsq2UJKASKxqWlcB/PulnosaNQH4YY+QXkF5Lz1+bjoM9
 7cIqPilOgPXKYlyORPFdiiDUJiqfA5h3eM1Q31sdTFzuncXywNuXOiJKJoxItJ++lvS0
 VmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C4tYjwSWea3BkvJKVVHfcLZltxu4pGL9ZEnrk3oNDq8=;
 fh=Wx7wNhPct/Qj1jCfILDotJwHkArpzRqFupw+1K3o51g=;
 b=ULKdAWMw7zDfMR4bJeOvTJc7aG/Qxg6xPz0AVWdPk4hiBnchPEHbwqBcHsKsozZGYL
 1+dDH60rQqtrwNMejocLuRMOsAkBbDDFDLJ8q7ZHtvyb0tLOXqvshZCR/YwzFAyVzZAE
 GuNT/mOJ/kyj+vkcYkrq/ReEMPe0lK9W6shjzJB3WOCTa5x5xoNPv0b+L9eWvuJqZMgK
 q2mOUZMUp2D8//WnsauDJhUsrrITbpYg66C5EUT5Yd0cdl/ioreefgB1L0UfJrC681dj
 SO8eCIES3nLrrvc5zXKmpbhZg96SCWPpsV8Q2wdc6j+4FZTwfl7cd+Tul2HS/+G/HKJY
 VMCQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769037471; x=1769642271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C4tYjwSWea3BkvJKVVHfcLZltxu4pGL9ZEnrk3oNDq8=;
 b=k10CniaUagDBA7lLZbU7/U/q8cLyjmO2YrRhr1bLhF8mTzazFXrAcHUgbHzSI1Jl9K
 Rw9SIP7BCCbepm1KRegF7GSicZBf6UMDqYuCYEoBaxA1Y7p/UtOWDaHiHViy3Mz7raQt
 /oo6ISOTcI1cImGGyrQHfMZ43/iLqIiHFvNkduSlJIjjQimKiDXEmvaTtWvmB5PNo5UO
 Hc10POJmc9W1cRUlP1aqC2f6HhrXyDSUfdDZh+ZAbr8kNKkUX8UH6LJtPOaVOLxkVLhI
 DkJtPh/6+uvNXzKlZt13OyvZ/cO1G8oU393cX1IwT67wQjeVAJ8I9JbUkR8/LkvvrMe4
 A7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769037471; x=1769642271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4tYjwSWea3BkvJKVVHfcLZltxu4pGL9ZEnrk3oNDq8=;
 b=lxKsV3GaG5N4/5vPlaJWe3aJtEVDcUoTxNxSuKbBjSjH1fdkSl6LoRQJU+1N7HNH63
 Dzvq5udzP97OK86ces99st5xozhxOFYVeRJMQ+2iPMta4SrC/FK8qmHzoe5r6MtkOfzI
 tXkCSufGXz82ewatnw3MDdX9qAgg8hSgDspTIT3di+vME7RE8sdsZKvYrfqH9PsRVpno
 lDOLXrWuK16LFKIYzb7pUEjjap9SunxnBOgCfgvtHSXe/usxxoS0bPRCKzghUzDJIPs0
 csJyg7siQv26gFzbaA9wUNJwpi+3NyFAcnO7NC0V40OB2NpaAShM+8RyThU4hLMhWtao
 36sA==
X-Gm-Message-State: AOJu0YzsTHCurtY9XawY1H5dY5DiKXBSkyv4IE9wVbUF6Boq3zccvxfg
 /6GSZtyA7jPYnt24KQAOKwZefmHCy9go7Wx1AtjxRX3f2GbKplVDvF2uP+0VCdkRlX1lFVZ93EJ
 mlrV3WUM2MgbNEk9n8zRN6jp+FPQzx2E=
X-Gm-Gg: AZuq6aKmL4iQa9pu4c/JWm1/ibhRVqJNzs8wcowaPBVjTkHufaF7NvPBREpNjvXqV42
 h1p2LOmY30syf7HqxpLdH+svpoeNP+mJ2cJvERLDrR1wjDaQy8/1BwgtlvK8nmzp3prPDnZy8hD
 YNEBHVSMfSz4QamyS5z5oV81rJlhHpYPgJsiGXYl7rDeZf3cTpHkcBIPWh1NcI4qcXvIMGsilJL
 PKOI8Q6Q/n4SQ4nTUTzU2fS1KSNFyIzDWhsvpGr3F3L5ulrOelnfSQoXU40kNxnG6Tmzsg2
X-Received: by 2002:a05:6102:d87:b0:5db:3d11:c8d6 with SMTP id
 ada2fe7eead31-5f1a4d71a7fmr5670515137.5.1769037470555; Wed, 21 Jan 2026
 15:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-5-raymondmaoca@gmail.com> <aWyjUHwp2gzZfUYH@pie>
In-Reply-To: <aWyjUHwp2gzZfUYH@pie>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 21 Jan 2026 18:17:39 -0500
X-Gm-Features: AZwV_Qhd9ONWNlr5ukZRj6trW51WKw0nWDp9UHCSCbzPztQzcgZR5We9Jm8A8V4
Message-ID: <CAMDkj5z5BQN5gSuE_4uTruqqHiNO5c4yKsWBC_eQUm=gaXi+kw@mail.gmail.com>
Subject: Re: [PATCH 04/17] reset: k1: add SPL support and enable TWSI8 reset
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Aniket Limaye <a-limaye@ti.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, Greg Malysa <malysagreg@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Justin Klaassen <justin@tidylabs.net>, 
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Samuel Holland <samuel@sholland.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:20:31 +0100
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

Hi Yao Zi

On Sun, Jan 18, 2026 at 4:12=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:

> On Sat, Jan 17, 2026 at 02:01:38PM -0500, Raymond Mao wrote:
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > This commit enhances the K1 reset controller driver:
> >
> > 1. Enable SPL support
> >    - Select CONFIG_SPL_RESET_SPACEMIT_K1 for SPL builds
> >    - Reset controller is required during early boot for
> >      proper hardware initialization sequence
> >
> > 2. Remove TWSI8 (I2C8) reset restriction
> >    - TWSI8 is now fully controllable by reset controller
>
> I don't think you change any real logics in the driver, so what fixes
> the function of TWSI8 reset? This deserves more explanation.
>
>
The TWSI8 reset could be accessed. But it's only writable. So I remove
the restriction.

Regards,
Raymond


> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> >  drivers/reset/Kconfig             | 7 +++++++
> >  drivers/reset/Makefile            | 2 +-
> >  drivers/reset/reset-spacemit-k1.c | 4 ----
> >  3 files changed, 8 insertions(+), 5 deletions(-)
>
> Regards,
> Yao Zi
>
