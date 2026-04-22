Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC60F9EDE0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D729C84390;
	Wed, 22 Apr 2026 16:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JNzjcXUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0784C8423E; Wed, 22 Apr 2026 15:47:15 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B501183BC8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 15:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-38e7d984096so59891821fa.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 06:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776865629; cv=none;
 d=google.com; s=arc-20240605;
 b=dmAddFYfaU9W6ezJO68HOy3pi43dKQQcGx+jTJ8QbYJQWBxQfmByQlpffzrIrS1TA+
 zC1Mxsq/mLp6oTalrskOt4+FdrGCVt+7hO3erv4KcFowYzZHXDev5GfZV7oD/IhlFntz
 8xx65HJjeIlklSIikjss00HIFzeb2Ummvg9NFBCoi7b7EGbT2cIKWHq7Bv+OnNhxlM4i
 MpmxGj4latT7RSrI5urNEC4a5nv3GmC2w2JXXCNgnumHiwuqNEBu6qnB9ylyd4tDG5pU
 J54HjZrSM4kBBNBIF24cYg9PYwWh2VRC6ERdz//6UFAgJPBDXPDDn4IrTRxphi/5zGc0
 UBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tKZXe++TwV9zFM8MzIe9WBAC89R9N/AfM8E2NZzKLV4=;
 fh=VdmutiOgV7YF/H2RFOfe7KY1vUpRFELyzJ4m3DrBPzY=;
 b=SZQ76BCrgiF/Y8r6KnbP6lHU8/fIUQ38sjicjIv4CH7UaLOANNNex6jWUhovEyUzbb
 miGnTAwwdi5bjFrQvR0hhMLjnctvASqtSXSly5GxQdadnpyCLAtgAGKWc57IyVxcnd3d
 7jYoBkecVhNkHfOyyNXzkG6cghlotX8Us684bFo+Kz9OBG9M+JpvZMKhSUIxDEeUyQcF
 CG2EnXAS7CNo93yWfnNcd9sdZAB/yZ+g8q90i4jdtOKbwG858uOtjdsHm9isBQnD7osw
 nO3tKOs/FWypgSBTP0GL0A1qqLauQqQ90mcd8XEbvxWpfePtjzCkexZLv4vRFp6+nQjA
 6UVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776865629; x=1777470429; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tKZXe++TwV9zFM8MzIe9WBAC89R9N/AfM8E2NZzKLV4=;
 b=JNzjcXUReJ1aTwSr5koObZJEj9dkvlb8ieiM/ZmuFR7ECP4frN1Te45DG5TlMtXsla
 f4bKNWFO0SYYX716b6WET8PhexXdacfMqldyZFxRH95g34nkgVFNYPWstsd77IndIy0l
 Arpu8DMLtDPMM6tJ8EN6AMO4SQOLW403S/yMRA+LbNf3jdXbaoQOhs5ZoenNhNppMeBV
 21XsqYZTnJjPacrHtYTQf+TiSFFQ0JkgH8YYNHgmvmhHHwCqAwPOwHIglVnBCaK6+kPU
 Y8CDZow9YWY6OpE5uDJG20kLJdEYuJVUUd0D9k1lmcls/pvYAnVMh46LOXj0kFCj2b+q
 7r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776865629; x=1777470429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tKZXe++TwV9zFM8MzIe9WBAC89R9N/AfM8E2NZzKLV4=;
 b=SmpztFTaB6Fwd+x28iMWW14j8hYeEVaDYW3D2G81vKwaYxRBIacVNquf/2y4Gc9gyE
 nlG9/qPzRcN3M0JlWC9Ehy/tbsbEuiTooqPkZ2s4F5CokzdvtHMcEZnvRSRzIbdszyYW
 P9f4RyKoD9AUu2l3NPjY23/Rxp+StSoThAqIEK9qT+qYVD93+JFA7wlhskSLHnbC7HjP
 eb+z7NIxmWgKZoNbsKqHgNE2eCWOh0w8MkezStJFtRbY1K8gJiW748TgyMlBXBz91tOI
 nxuQA2fdqVJfgmTHQ5wB0ObGu0mnQ1Au50X8TpLj6lg886UtKGumsJo0bQE+i7laY8EZ
 AKZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8k2eJb1JAw6tH1u2v53czi6Sn0dQcxBXVbY1GlFYahGI33U12K7vUZmlCBt6cA9B7CEORg/7E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/wHMVnD3jWverjv/EVi+D0GI7gScsOASu6kjRGgfI4qBoA9N4
 KaEd6gUNXuT47xzlhCwGBFT19FkRZPsA3Xrdv9JgPpEu2W16FNK39Q0wEUJrUnaLE8Wxcpe0zM6
 F6CLb4oLGIyhJxy2+uimVckyAD3sEcRc=
X-Gm-Gg: AeBDievs/KYcPKs4viVlo8Vwm/FLRfPTugOOcwKIatYvJIb3PjVJzG1OaCR5yQ/04hq
 BQDL8y39sRdpW4xrMw9c9BoCmNtQpf2JKX0sh0gQacw0MRNL1YlqaCPQHn02+VvaHgiFWJtiiG6
 K1UXJWYRFOu5mHr/hFtE9Op713AFMB7fDTYCY9EmoT3OCu2PD1uGiBFDu2PCXwfiICmdTWKDfeM
 ov1HuTtKOZxTSj5vO4frK4v9JbThleWbj7HkfdIeqY/U63j6ATqY3bgtLl8jOaUreRrReOb5x6c
 z9pP6p1RFXfjk/GWRkAF2LYmzFT9RhX0ykt9NoyBbXe4oHZoe/PpKamUkzoqPok1bhpPD8fRnxU
 f40un3A8=
X-Received: by 2002:a05:651c:2120:b0:38e:a8ef:b61 with SMTP id
 38308e7fff4ca-38ec7b479b6mr69847081fa.29.1776865628558; Wed, 22 Apr 2026
 06:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
 <20260421-wdt-v1-2-0bd01ec6a7c4@nxp.com>
 <aa7822a0-a114-4989-b23d-9e242bd2dcde@mailbox.org>
 <PAXPR04MB96446CF3749068C53E1E8092E22D2@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB96446CF3749068C53E1E8092E22D2@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 22 Apr 2026 10:46:57 -0300
X-Gm-Features: AQROBzCbYdRYKRT_FgQtL883Rgg01qLl_uoEOt8KcM6hnXQDUi1vpOCW3C2ZenU
Message-ID: <CAOMZO5A2h1fx=NAPhg-2ise0RQzLJed9GsHGSB6Qa2AgMmP99g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>, dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, "Ross, Fedor" <fedor.ross@ifm.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 22 Apr 2026 16:44:59 +0200
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

On Wed, Apr 22, 2026 at 12:49=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp=
.com> wrote:

[Please trim your replies]

> Hi Stefan,
>
> For platforms with CONFIG_OF_UPSTREAM enabled, the DTS/DTSI files come di=
rectly from the upstream kernel tree and should not be modified in U-Boot, =
so the watchdog node is added in the corresponding xxx-u-boot.dtsi.

Please send the watchdog changes to the upstream kernel, so that
u-boot.dtsi does not grow unnecessarily.

Then mention the upstream lore URL in the U-Boot patch.

We can accept the u-boot.dtsi changes temporarily, but please make it
clear in the U-Boot patch that an effort is being made to get the
u-boot.dtsi change to the upstream kernel.

> For platforms without CONFIG_OF_UPSTREAM, the DTS/DTSI files are maintain=
ed locally in U-Boot, and the watchdog node is added directly to xxx.dtsi.

Please help convert the NXP platforms to CONFIG_OF_UPSTREAM.
