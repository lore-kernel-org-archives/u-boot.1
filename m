Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4984D74EDB
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AFE83B87;
	Fri, 23 Jan 2026 16:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKla1Y4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB9283B27; Fri, 23 Jan 2026 15:59:10 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8066083B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-560227999d2so815771e0c.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 06:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769180346; cv=none;
 d=google.com; s=arc-20240605;
 b=fDLVUHQW3UQ/LrD4Zc4Iu9ihZKD/YZxqTXIvc1b4LgvCJC6f5WxX9VC/3FxR8GIUzH
 dRgo0yPMvH7kVQfLN2Fo3iggbwQBusgIuR/SFE8SxGadvZC7vWhWY0VyuKmbEXgV7qys
 iWzNJBN48MVXQwZHbUIZaIV8/Rd9mc/P9RmkXEMu1wVlUmtXNcuuPu5NKJV1BZTzXHEb
 qzW91yMwvN6wnNDtH2jQIkNTputKBO8LPNH6UDJxrHJqfeC8jMBBYjpNixaDG54BwDU9
 yqx8V9eFep+JagyBihxbrjmtKcOworBWWDu2y9I1TUkqLIGi4mcOetRDLJiDcJEXvjvq
 /kSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ApmkizHd1/9yPjP+7Ao7ESSMjKJcxfVHJ9RjlxDkoI8=;
 fh=rxZIyqfMIPTq+Vfl+JaXwHgnRFydivE/8KH77F4iVWk=;
 b=Rv4mQZJckEl3F3K5fXztvRIiWo3Fbda7cayI6v8u+meiy2W4ADgbHIh6ZwiphAwZlS
 2ju3eTdjIemwjYWMTVYxgT8GH/5tbuNn8HXFBjzvG1huu1C7S7SQUTnRmhTMzzZWiVvw
 /E+4GfLkru3DEm4SuRITf3u4sY7O5lGTytCqpkKZHi+cFt9RtRCzl50fXQ/oVzW+bxuv
 hazqouwp4ap8J+llZVXVY4QE+DbF0ZHQcJaaWPiTrr81mycGqGI+YAbs1EfmwxbSNq6H
 9oitncAlhGMw57GMu8bbhOZrIz0FGlQMAcFj/ZqaJvVxNeAmTKR4h1opffVrVZndgcZi
 q7ZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769180346; x=1769785146; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ApmkizHd1/9yPjP+7Ao7ESSMjKJcxfVHJ9RjlxDkoI8=;
 b=OKla1Y4bS5fmJ2gF9+5z/OaeJWovzw9MUElisf51OH85HW0PFvz6VhzSLHbkx36olk
 ThSVcX7UsVrfWfTEjDO2FnwsBGrfTeq5tXv5lzuoIajKE/YpfPlK6lsmt2ZzzUQo61QE
 CJifC8YAuWwQQ0pFnqBWpQSs+n6k5E9FHdW6H8mua7HYtjShYWd0zzms0+3922vy3EwV
 nR55dRcT5ZfHBLNY0v2UwtvfZErDbBtE626xz69jj1Gp6qoctLj5I99eqHpmLAa2Acwz
 1cUIdWFPfL+x8/TE47bTV8K5KOi7wlVQAAY0Eku90kvb4gbLBvQQY+9pcyDOwrR7pLXy
 rvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180346; x=1769785146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApmkizHd1/9yPjP+7Ao7ESSMjKJcxfVHJ9RjlxDkoI8=;
 b=mkBVR7SB0G/5hgsuR2O/EtCLRiNvCISUcaAogd1XPwgrdfOVW1kUVPFA8Ddk6E7R70
 DMyxXe9H95OA2OxkDqNK2b6Ez62IhbspjYPKX6nrK1JcuOjwYWTdU3tbEFHKimJQYexq
 NOkkeYCU6UCPJK4u33ErN3gqyBr3lXmTR0OeyUm/EeSofYmWi6AMQQk31cqeoO5CDPpi
 VrIjhMiTTiz11xrl6EUReIZA0YxHQ/Qz9aW224hjq3zYnU8YxdAXq4N2KTV0r5lBR3At
 RJC6MrzG5aDy6KyufRBr6jtzZBoASVc6mNIN6rQEFkN11Z6JKyC1nKb0dch5HWhJXaIB
 lkyA==
X-Gm-Message-State: AOJu0YyxoefAqpLY/J1NoBiodAiV1Exihil6fvMLYkRlRXmK5KLqNf1Q
 ZUEay+lIwAIklDoF1mVETmIlyN9hjL0Y6fcTrPHmCMbCXgC8VgfdcFDpNMLLF8/aJ5Yo5MzJP1y
 4a3HCCZqbRm+kotkyfNu7k6NY4MZmwtA=
X-Gm-Gg: AZuq6aJSkvsmfhl6TnkVQXn2EsRvgf+hNrHuWfP0InVwHMhsZcOa9lHs24NeGxtkibB
 SRFj6MBlGb6o++Kb2fIWJ0xZxsOCnvvpVsSd2vTKhek9HrnPKrjx6UO2So0hKUGV9GWSiLTDRrp
 3bGYJQeTSiZWNEgGkeXoktxnYRKoVlMLOuUJ69NTGVKm85gOsZXQn+ph9OzT2mljrYX3CwQGrnt
 V4IwkBazc3+7wzth/+rpD5DWHkvoLfOY8n3dcS9KT0BJ+gFOVP/UFDLtanUzoQt/ZXG0qcO
X-Received: by 2002:a05:6122:1307:b0:55e:64d7:ae76 with SMTP id
 71dfb90a1353d-5663ebd27c8mr914367e0c.20.1769180346057; Fri, 23 Jan 2026
 06:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <ab43d859-ab6d-4a1a-9f7f-0afd61545e17@gmx.de>
In-Reply-To: <ab43d859-ab6d-4a1a-9f7f-0afd61545e17@gmx.de>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 23 Jan 2026 09:58:54 -0500
X-Gm-Features: AZwV_QiS0w57KF-KrfW1Q45YUT5_sqmIQCABUoZx4CasbtEKJRu0_Lyizt13ng8
Message-ID: <CAMDkj5xRZw=FDUptbjH30DTnAL4tdNo9GqtLLUya=jnNi_Um6Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add board support for Spacemit K1 SoC in SPL
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, 
 Raymond Mao <raymond.mao@riscstar.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Henrik Grimler <henrik@grimler.se>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Samuel Holland <samuel@sholland.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
X-Mailman-Approved-At: Fri, 23 Jan 2026 16:16:20 +0100
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

Hi Heinrich,

On Thu, Jan 22, 2026 at 3:30=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de>
wrote:

> On 1/17/26 20:01, Raymond Mao wrote:
> > From: Raymond Mao<raymond.mao@riscstar.com>
> >
> > This patch series introduces full support for the k1 SoC in SPL for
> > multiple boards.
> >
> > The series enables the board by:
> > 1. Adding the base board definition with device tree.
> > 2. Bringing up essential clock sources and tree.
> > 3. Initializing I2C buses for peripheral communication.
> > 4. Integrating the PMIC driver for power management.
> > 5. Adding regulator drivers for voltage domain control.
> >
> > Junhui Liu (1):
> >    clk: spacemit: Add support for K1 SoC
>
>
> Hello Raymond,
>
> Is a downstream OpenSBI still needed for testing this? The documentation
> in doc/board/spacemit/bananapi-f3.rst refers to
>
> git clone https://github.com/cyyself/opensbi -b k1-opensbi
>
> which is based on OpenSBI v1.6-32-g02c7a9bb.
>
> Or is the necessary code already upstream? Upstream OpenSBI seems to
> have some support in platform/generic/spacemit/k1.c.
>
> Should doc/board/spacemit/bananapi-f3.rst be renamed or do you plan on
> different docs for different boards?
>
>
This series is for SPL, but there is a plan to update the document later
when I prepare next patches for the u-boot proper.

Raymond


> Best regards
>
> Heinrich
>
