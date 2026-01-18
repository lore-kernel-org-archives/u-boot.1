Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ED9C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F65183BF1;
	Sun, 18 Jan 2026 14:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Q5ihR/gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B94B8313B; Sun, 18 Jan 2026 10:28:19 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EB882BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 10:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768728429; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VJy0j6/b/X1PjbpDnWgaXwWQVh/E7rOmqphMexNXAv7WrwhAeiS5OaYfjuf9l320jsb1gOflGLp3mPVoTAsog4/OJQIkaFkcgSmIKBgUlRmAfj9QXzLAFPWVJr3+uGGlKM1FgVAFwYLbNnelp/LsR3pQmO9JdsffBnUDNIaeUDc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768728429;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hfT55TRigqzFLhNxoFGP5crJpELkNQlGKs3cHh9R7Es=; 
 b=JPXkVuCtH2B7gzMFbKQtWUf3WjIDvCg2D7in8MOjbzi2OTKOOVvu/253S91y5XYnIcMZKg0pmXU73p4x4Uw7dBaAGFUSgoXMOtK6MVaGFt1KZn2IuFccQMr34A7u7q4VMiIwkh7KLs6izjQ8VbIm4Ac5BDzloDJe8xfH8plUJ7I=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768728429; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=hfT55TRigqzFLhNxoFGP5crJpELkNQlGKs3cHh9R7Es=;
 b=Q5ihR/gkZULuzaoE65ZYdmfnCWeAOIlXmMPSH2LwL+5ieEuVfsjjGu7xrl9MPBnx
 nSkpdIBLqjGzCfR7qYfg6DeOxXH72HFN8ar5YrtTCdgI27vydtKXMJMEjTYxIBJSK6U
 JjYQMnvrAXBw88bNqMV2n/KkXlEIGeznhXgmf+/Q=
Received: by mx.zohomail.com with SMTPS id 1768728426370274.2055100892652;
 Sun, 18 Jan 2026 01:27:06 -0800 (PST)
Date: Sun, 18 Jan 2026 09:26:18 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
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
Message-ID: <aWynOt7uVgtqbA1P@pie>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-13-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117190231.977686-13-raymondmaoca@gmail.com>
X-ZohoMailClient: External
X-ZohoMail-Owner: <aWynOt7uVgtqbA1P@pie>+zmo_0_me@ziyao.cc
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

On Sat, Jan 17, 2026 at 02:01:46PM -0500, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> Add dt-binding file of pinctrl driver for Spacemit K1 SoC.
> 
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  include/dt-bindings/pinctrl/k1-pinctrl.h | 59 ++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/k1-pinctrl.h
> 
> diff --git a/include/dt-bindings/pinctrl/k1-pinctrl.h b/include/dt-bindings/pinctrl/k1-pinctrl.h
> new file mode 100644
> index 00000000000..6c6b223c969
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/k1-pinctrl.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (C) 2025-2026 RISCStar Ltd.
> + */
> +
> +#ifndef __DT_BINDINGS_K1_PINCTRL_H
> +#define __DT_BINDINGS_K1_PINCTRL_H
> +
> +/* pin mux */
> +#define MUX_MODE0	0
> +#define MUX_MODE1	1
> +#define MUX_MODE2	2
> +#define MUX_MODE3	3
> +#define MUX_MODE4	4
> +#define MUX_MODE5	5
> +#define MUX_MODE6	6
> +#define MUX_MODE7	7
> +
> +/* strong pull resistor */
> +#define SPU_EN		BIT(3)
> +
> +/* edge detect */
> +#define EDGE_NONE	BIT(6)
> +#define EDGE_RISE	BIT(4)
> +#define EDGE_FALL	BIT(5)
> +#define EDGE_BOTH	(EDGE_RISE | EDGE_FALL)
> +
> +/* slew rate output control */
> +#define SLE_EN		BIT(7)
> +
> +/* schmitter trigger input threshold */
> +#define ST00		(0 << 8)
> +#define ST01		BIT(8)
> +#define ST02		BIT(9)
> +#define ST03		(BIT(8) | BIT(9))
> +
> +/* driver strength*/
> +#define PAD_DS_3V	BIT(10)
> +#define PAD_DS_SLOW0	(0 << 11)
> +#define PAD_DS_SLOW1	BIT(11)
> +#define PAD_DS_MEDIUM	BIT(12)
> +#define PAD_DS_FAST	(BIT(11) | BIT(12))
> +
> +#define PAD_1V8_DS0	PAD_DS_SLOW0
> +#define PAD_1V8_DS1	PAD_DS_SLOW1
> +#define PAD_1V8_DS2	PAD_DS_MEDIUM
> +#define PAD_1V8_DS3	PAD_DS_FAST
> +
> +#define PAD_3V_DS0	(PAD_DS_SLOW0 | PAD_DS_3V)
> +#define PAD_3V_DS1	(PAD_DS_SLOW1 | PAD_DS_3V)
> +#define PAD_3V_DS2	(PAD_DS_MEDIUM | PAD_DS_3V)
> +#define PAD_3V_DS3	(PAD_DS_FAST | PAD_DS_3V)
> +
> +/* pull up/down */
> +#define PULL_DIS	(0 << 13)	/* bit[15:13] 000 */
> +#define PULL_UP		(6 << 13)	/* bit[15:13] 110 */
> +#define PULL_DOWN	(5 << 13)	/* bit[15:13] 101 */
> +
> +#endif /* __DT_BINDINGS_K1_PINCTRL_H */

These definitions look like hardware bits instead of dt-bindings, and I
don't see a binding file for the pinctrl driver of SpacemiT K1 in Linux
upstream. If it's the case, please keep the definitions inside your
driver, correct the commit description, and probably squash it into the
driver patch.

Thanks,
Yao Zi
