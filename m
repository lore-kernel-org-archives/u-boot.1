Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C458C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14F883B5E;
	Thu, 22 Jan 2026 00:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NF/N4yFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31E4F8313B; Thu, 22 Jan 2026 00:20:30 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CABE83A3B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-5ee9fa419f5so82928137.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 15:20:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769037626; cv=none;
 d=google.com; s=arc-20240605;
 b=Ns11u6yEebxh6w+r+MfNTUF+zRVkexf2etSzUmxJlFNnq4f0b7nnMnPyC3cJsnXyaK
 e6opcSeI/j9iOThEOg9FTU18IjhOeSwO/cJq67ZfHIZPgqaxrbkx1pkGYE2WQk88PRyu
 7y2bOhOJ1fjHoxug3L34ZsPWyL1CyhlyF8Z4XSvcHKW7qZ3/kbQ/RoAE4vy2qj9ctH7l
 pMp+W37n7yIwOmNe3BPKHxOq95iF2TZMFUDaxA466RBkdIwiYhb8HQzYgN5zYPEqsngq
 RAN6MWClDaIKn7/tS2L/HxirYdX+3foYh1klO7X1lLcdpd1GnstcRF+CFeWD7uU0+6yn
 wByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wBeZUQgz2tBfTnhk9g/DJJc2ir/bNKTEkUlaY969MJQ=;
 fh=cBxqcWycY55CMa++Zrc05lnPv0gEMnAmYvR8RQ1Jp3I=;
 b=XO5ScfZIReWlGAk1T2vax7eYvOzcZQ6MOig7iZgCxj+I3Oqe556hI9lwog2WBYXv35
 w2XGQWKVHAM3Kzq0NxTFyesp4cii/yIdg8bAZJBtHDNNnkUtpzQreigbzFqktVB0zE3/
 a0p9C2dpFKopVdMmG8AfFeAyZ0qurbARLWJiz04u/sFmRvBoTwNs470jTDMFtmtDp2CB
 u52b7XVcw9GbiXyLRsexT62t2F5Ot+Lt5NCHDwEKrc21yRt2na2l+WkbqbTqfhwmZsYB
 Z/fnh6hd4PtYKwrfI/s2Q2IMt0OslogfvalnOD0fXEvXwVSh+iJ8ksxcXDtji5XZkOFO
 +Egw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769037626; x=1769642426; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wBeZUQgz2tBfTnhk9g/DJJc2ir/bNKTEkUlaY969MJQ=;
 b=NF/N4yFpfYgEzvjBHCngrxrxbfuBQFVJph0v21DM+Vuft2vH1n+nosY1KuHfGXasBm
 MrM+FteQAJT0YaYTfP+bilM4WYYMm2atY2o4p4KI06SPXkFYzbMZ3irnbZ+EW5WwhEwn
 7YAv6NLD4PFv1ZeJDFklrPxk5YACouL29cvMzCUv6HZ7wuovssdAxs8TI5p3SddUZqW2
 bdBxiqy1ylP3Dt/cqEmux6TuzKCTk2ihF3Q4Z3gmntF98sEwycMz+MQ/SUU4FGYaW/M/
 pt1MPsCoKDci1YlqTvJUXHCCYfyWdbmeKkk/v1nG7U3PAgwt878WJakCbM+9fTYZbYn1
 +lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769037626; x=1769642426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBeZUQgz2tBfTnhk9g/DJJc2ir/bNKTEkUlaY969MJQ=;
 b=ucHUFumnhIJS1nGj5vrCu1Q6N524zcfK7gPvy9FlbeIkrYdJwxMNLt3FjLs9Wt2bOl
 oNPGZf4rXHFOUmbPjgW4LCQZF6e9zz66pJN7h6XVir3t6I+Il9ADHKvfXUKx2cRw1ot5
 poyMk0ftFELenbTDT9KTiuGe1Wvri8q2zpwxEbD1SucUPcDLysXgrRzgs+Ed2OKXKfXe
 eBPutHAz74gWB1tBdNEZ/Z97I6KCNN+PxVLiVavYh+qbjg9/fHSXc30YYG/x14E0DFV9
 HS1A1JynL2YJB6Am/MkGk90oToKlgxjP50hQbRKcUcnLq/gYwyROHAfxk/ptI7XEeXep
 O6cQ==
X-Gm-Message-State: AOJu0YzVyGuVe77ybgwugxdNQDz8AXSyf7cw59mLd1/S/NrjNx5a4ds8
 0O5HQgRmfE6CbH4o/feyab1Z/28MR/F6HCJo6/eqBAqE/t1Y1CS7O+rVOp3JuHjIziolyH/i4qg
 nsrSVV6vsSG/HHSQ7KSHcvKPVku5+XkA=
X-Gm-Gg: AZuq6aJKb6OZwJvUylS4B5QlzKUY2FR1viraSlwyIH98jt7/+u71wH37UbHN2EhDhbx
 j+7N8iN09Wz2qQirUKe7eMoD2UnOfmybX+BB0bRdYama0q18KrODHzaYLCZ0ENepcXOsWfH9wx5
 XFUuAk4FkTcFpX/RqMHHx7YsJBDsIra1Mm6JYBst+nJ1K+/IgFWWuDcrzZvtw8VM4SQGClflUm4
 Ah/VdpxD9EsRUL1Bh5dSpUuP1ob6Dh/5ZIcHtIQekGdsOpu3ZNJeM62UxMGxU+SKkyCLtZp
X-Received: by 2002:a05:6102:e10:b0:5ef:9a37:17b9 with SMTP id
 ada2fe7eead31-5f1a537ff8amr5723505137.12.1769037626297; Wed, 21 Jan 2026
 15:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-13-raymondmaoca@gmail.com> <aWynOt7uVgtqbA1P@pie>
In-Reply-To: <aWynOt7uVgtqbA1P@pie>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 21 Jan 2026 18:20:15 -0500
X-Gm-Features: AZwV_QhRMjjkAY522rLnLGLHfSRFJkvbTyabKXEq65XxBpyvv8iW7WTXpZlHry0
Message-ID: <CAMDkj5yRkgniJzFhywuQoQLWw-jGWgCpCNExHpjE-o+hTr49NQ@mail.gmail.com>
Subject: Re: [PATCH 12/17] dt-bindings: pinctrl: add k1 support
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>, 
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Yixun Lan <dlan@gentoo.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, Aniket Limaye <a-limaye@ti.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Henrik Grimler <henrik@grimler.se>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Justin Klaassen <justin@tidylabs.net>, Samuel Holland <samuel@sholland.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:20:38 +0100
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

Hi Yao Zi,

On Sun, Jan 18, 2026 at 4:28=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:

> On Sat, Jan 17, 2026 at 02:01:46PM -0500, Raymond Mao wrote:
> > From: Raymond Mao <raymond.mao@riscstar.com>
> >
> > Add dt-binding file of pinctrl driver for Spacemit K1 SoC.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> >  include/dt-bindings/pinctrl/k1-pinctrl.h | 59 ++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 include/dt-bindings/pinctrl/k1-pinctrl.h
> >
> > diff --git a/include/dt-bindings/pinctrl/k1-pinctrl.h
> b/include/dt-bindings/pinctrl/k1-pinctrl.h
> > new file mode 100644
> > index 00000000000..6c6b223c969
> > --- /dev/null
> > +++ b/include/dt-bindings/pinctrl/k1-pinctrl.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/*
> > + * Copyright (C) 2025-2026 RISCStar Ltd.
> > + */
> > +
> > +#ifndef __DT_BINDINGS_K1_PINCTRL_H
> > +#define __DT_BINDINGS_K1_PINCTRL_H
> > +
> > +/* pin mux */
> > +#define MUX_MODE0    0
> > +#define MUX_MODE1    1
> > +#define MUX_MODE2    2
> > +#define MUX_MODE3    3
> > +#define MUX_MODE4    4
> > +#define MUX_MODE5    5
> > +#define MUX_MODE6    6
> > +#define MUX_MODE7    7
> > +
> > +/* strong pull resistor */
> > +#define SPU_EN               BIT(3)
> > +
> > +/* edge detect */
> > +#define EDGE_NONE    BIT(6)
> > +#define EDGE_RISE    BIT(4)
> > +#define EDGE_FALL    BIT(5)
> > +#define EDGE_BOTH    (EDGE_RISE | EDGE_FALL)
> > +
> > +/* slew rate output control */
> > +#define SLE_EN               BIT(7)
> > +
> > +/* schmitter trigger input threshold */
> > +#define ST00         (0 << 8)
> > +#define ST01         BIT(8)
> > +#define ST02         BIT(9)
> > +#define ST03         (BIT(8) | BIT(9))
> > +
> > +/* driver strength*/
> > +#define PAD_DS_3V    BIT(10)
> > +#define PAD_DS_SLOW0 (0 << 11)
> > +#define PAD_DS_SLOW1 BIT(11)
> > +#define PAD_DS_MEDIUM        BIT(12)
> > +#define PAD_DS_FAST  (BIT(11) | BIT(12))
> > +
> > +#define PAD_1V8_DS0  PAD_DS_SLOW0
> > +#define PAD_1V8_DS1  PAD_DS_SLOW1
> > +#define PAD_1V8_DS2  PAD_DS_MEDIUM
> > +#define PAD_1V8_DS3  PAD_DS_FAST
> > +
> > +#define PAD_3V_DS0   (PAD_DS_SLOW0 | PAD_DS_3V)
> > +#define PAD_3V_DS1   (PAD_DS_SLOW1 | PAD_DS_3V)
> > +#define PAD_3V_DS2   (PAD_DS_MEDIUM | PAD_DS_3V)
> > +#define PAD_3V_DS3   (PAD_DS_FAST | PAD_DS_3V)
> > +
> > +/* pull up/down */
> > +#define PULL_DIS     (0 << 13)       /* bit[15:13] 000 */
> > +#define PULL_UP              (6 << 13)       /* bit[15:13] 110 */
> > +#define PULL_DOWN    (5 << 13)       /* bit[15:13] 101 */
> > +
> > +#endif /* __DT_BINDINGS_K1_PINCTRL_H */
>
> These definitions look like hardware bits instead of dt-bindings, and I
> don't see a binding file for the pinctrl driver of SpacemiT K1 in Linux
> upstream. If it's the case, please keep the definitions inside your
> driver, correct the commit description, and probably squash it into the
> driver patch.
>
> We'll use the pinctrl-single driver. So all pin configurations could be
filled in the DTS file, not in the dt-binding file.
But the pinmux configurations should be included in the dt-binding file.

Regards,
Raymond


> Thanks,
> Yao Zi
>
