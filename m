Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA63D3EE75
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 15:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4988A8397D;
	Thu, 22 Jan 2026 16:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="csmgu0kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1AB83AE9; Thu, 22 Jan 2026 15:56:54 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42775839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769093762; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kJNE9oKYGNFspybkSyZ0J4zSbJZR/XFIviO6mYifShhLKNxTWgn1eCqRGpbquAcwwOYGbcRZ+eXHV22TztwwDfhh8HlFR5y6xA1aYS9uwwzi5WimC3YCiQPqUZEZCIF6mlOIyXqULkpu5tI8wYyJF9GZQahIt0PjBLlI1yYD9As=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769093762;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IhK6gD4U58i9Iq6LDQ/+dYLOsQrZa+XP3LCKfo5PXys=; 
 b=lZvp0K9f5WTE3Ckb6NAx9O6XJRlPtDAVYTfVi437fyd1dwv8Frbs46rO1G9WDo3/gEjWXlIc62TZ/uAdhVDW7OSkZ2NaIvR7NoKKVLLrC+e8mVaYh4qxMN7cHbxJrqf4FAxHvBVSoqGNFfQSLnjR5lzmyZqaFwyVw5pCWEVlzBA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769093762; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=IhK6gD4U58i9Iq6LDQ/+dYLOsQrZa+XP3LCKfo5PXys=;
 b=csmgu0kqh1FhZOI8xGWOVjEOzU9mg7EoXoS9nSJyVuqbLM0s92SY/iRfiUUtNlXv
 CkqgoMMjoBbejcaoD2JHRvXxcZU3ob7jTyctfwR0NeziI6j9Z0BeXe/hTFjBw+6Tytt
 20Fb7vU4mH08LTxPE4IWrTlv2+FIBWyjjUgujY4w=
Received: by mx.zohomail.com with SMTPS id 176909375945764.29740913063688;
 Thu, 22 Jan 2026 06:55:59 -0800 (PST)
Date: Thu, 22 Jan 2026 14:55:39 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com,
 Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Michal Simek <michal.simek@amd.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@gentoo.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Aniket Limaye <a-limaye@ti.com>, Ian Roberts <ian.roberts@timesys.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Samuel Holland <samuel@sholland.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH 12/17] dt-bindings: pinctrl: add k1 support
Message-ID: <aXI6a9VRLqlElMKt@pie>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-13-raymondmaoca@gmail.com>
 <aWynOt7uVgtqbA1P@pie>
 <CAMDkj5yRkgniJzFhywuQoQLWw-jGWgCpCNExHpjE-o+hTr49NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMDkj5yRkgniJzFhywuQoQLWw-jGWgCpCNExHpjE-o+hTr49NQ@mail.gmail.com>
X-ZohoMailClient: External
X-ZohoMail-Owner: <aXI6a9VRLqlElMKt@pie>+zmo_0_me@ziyao.cc
X-Mailman-Approved-At: Thu, 22 Jan 2026 16:08:48 +0100
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

On Wed, Jan 21, 2026 at 06:20:15PM -0500, Raymond Mao wrote:
> Hi Yao Zi,
> 
> On Sun, Jan 18, 2026 at 4:28 AM Yao Zi <me@ziyao.cc> wrote:
> 
> > On Sat, Jan 17, 2026 at 02:01:46PM -0500, Raymond Mao wrote:
> > > From: Raymond Mao <raymond.mao@riscstar.com>
> > >
> > > Add dt-binding file of pinctrl driver for Spacemit K1 SoC.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > ---
> > >  include/dt-bindings/pinctrl/k1-pinctrl.h | 59 ++++++++++++++++++++++++
> > >  1 file changed, 59 insertions(+)
> > >  create mode 100644 include/dt-bindings/pinctrl/k1-pinctrl.h
> > >
> > > diff --git a/include/dt-bindings/pinctrl/k1-pinctrl.h
> > b/include/dt-bindings/pinctrl/k1-pinctrl.h
> > > new file mode 100644
> > > index 00000000000..6c6b223c969
> > > --- /dev/null
> > > +++ b/include/dt-bindings/pinctrl/k1-pinctrl.h
> > > @@ -0,0 +1,59 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > +/*
> > > + * Copyright (C) 2025-2026 RISCStar Ltd.
> > > + */
> > > +
> > > +#ifndef __DT_BINDINGS_K1_PINCTRL_H
> > > +#define __DT_BINDINGS_K1_PINCTRL_H
> > > +
> > > +/* pin mux */
> > > +#define MUX_MODE0    0
> > > +#define MUX_MODE1    1
> > > +#define MUX_MODE2    2
> > > +#define MUX_MODE3    3
> > > +#define MUX_MODE4    4
> > > +#define MUX_MODE5    5
> > > +#define MUX_MODE6    6
> > > +#define MUX_MODE7    7
> > > +
> > > +/* strong pull resistor */
> > > +#define SPU_EN               BIT(3)
> > > +
> > > +/* edge detect */
> > > +#define EDGE_NONE    BIT(6)
> > > +#define EDGE_RISE    BIT(4)
> > > +#define EDGE_FALL    BIT(5)
> > > +#define EDGE_BOTH    (EDGE_RISE | EDGE_FALL)
> > > +
> > > +/* slew rate output control */
> > > +#define SLE_EN               BIT(7)
> > > +
> > > +/* schmitter trigger input threshold */
> > > +#define ST00         (0 << 8)
> > > +#define ST01         BIT(8)
> > > +#define ST02         BIT(9)
> > > +#define ST03         (BIT(8) | BIT(9))
> > > +
> > > +/* driver strength*/
> > > +#define PAD_DS_3V    BIT(10)
> > > +#define PAD_DS_SLOW0 (0 << 11)
> > > +#define PAD_DS_SLOW1 BIT(11)
> > > +#define PAD_DS_MEDIUM        BIT(12)
> > > +#define PAD_DS_FAST  (BIT(11) | BIT(12))
> > > +
> > > +#define PAD_1V8_DS0  PAD_DS_SLOW0
> > > +#define PAD_1V8_DS1  PAD_DS_SLOW1
> > > +#define PAD_1V8_DS2  PAD_DS_MEDIUM
> > > +#define PAD_1V8_DS3  PAD_DS_FAST
> > > +
> > > +#define PAD_3V_DS0   (PAD_DS_SLOW0 | PAD_DS_3V)
> > > +#define PAD_3V_DS1   (PAD_DS_SLOW1 | PAD_DS_3V)
> > > +#define PAD_3V_DS2   (PAD_DS_MEDIUM | PAD_DS_3V)
> > > +#define PAD_3V_DS3   (PAD_DS_FAST | PAD_DS_3V)
> > > +
> > > +/* pull up/down */
> > > +#define PULL_DIS     (0 << 13)       /* bit[15:13] 000 */
> > > +#define PULL_UP              (6 << 13)       /* bit[15:13] 110 */
> > > +#define PULL_DOWN    (5 << 13)       /* bit[15:13] 101 */
> > > +
> > > +#endif /* __DT_BINDINGS_K1_PINCTRL_H */
> >
> > These definitions look like hardware bits instead of dt-bindings, and I
> > don't see a binding file for the pinctrl driver of SpacemiT K1 in Linux
> > upstream. If it's the case, please keep the definitions inside your
> > driver, correct the commit description, and probably squash it into the
> > driver patch.
> >
> > We'll use the pinctrl-single driver. So all pin configurations could be

But you removed the pinctrl-single node in PATCH 6, didn't you? And I
don't think this "binding" file gets used in any devicetree after
applying the series.

And I suggest aligning with the upstream pinctrl binding. It eases
migration to upstream device-tree, and makes it possible to share a
single dtb between Linux and U-Boot, which is a nice feature.

> filled in the DTS file, not in the dt-binding file.
> But the pinmux configurations should be included in the dt-binding file.

> Regards,
> Raymond
> 
> 
> > Thanks,
> > Yao Zi
> >

Best regards,
Yao Zi
