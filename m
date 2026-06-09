Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193CDCD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32968497A;
	Tue,  9 Jun 2026 21:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="XV0C8Pgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E968496E; Tue,  9 Jun 2026 21:04:44 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D4884987
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=g7O2lTjG7riqCwBUaA12WeGdl2YrxvnShVAuREkc8AY=; b=XV0C8PghAx9RNdLb68f7s+BJyr
 jgnaMflpbFU5PfYLJDPvlDNuKp9YdJdnLBWiymcYjNR4bqzuwzqB+ZojPFnqDV4N9dS+LEklDGi9t
 6Or4zTUHsiARsVMYjwO9EvrhDitihVIRuZTtsj1G7iYjV/j3gGKcimYlC/QfGabKjJyLs2fpYpSnj
 9XYXrl3HLHrDtfuQMKvQnNuN9TStfwVdGJIcUlCHV39HTzseZk4E69AcoZ1mINEESwfPfnJ5F7ACm
 8D5ZlVeAa4LFCKAC+E7iTxr7RZTe1fmacKEe0IzLodoa8gezAEn5POlKKUliDMhGBNyrPWNyDaLzo
 1XZgaQqA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Richard Genoud <richard.genoud@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>,
 Daniele Briguglio <hello@superkali.me>
Subject: Re: [PATCH v3 4/4] pci: pcie_dw_rockchip: imply CLK_GATED_FIXED and
 switch PHY to imply
Date: Tue, 09 Jun 2026 21:04:41 +0200
Message-ID: <2706350.Lt9SDvczpP@diego>
In-Reply-To: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-4-58f2cea72030@superkali.me>
References: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
 <20260520-rock-5-itx-pcie-refclk-dtsi-v3-4-58f2cea72030@superkali.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Mittwoch, 20. Mai 2026, 08:05:30 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Daniele Briguglio:
> Switch the PHY_ROCKCHIP_SNPS_PCIE3 dependency from select to
> imply, and add imply CLK_GATED_FIXED so that boards using
> gated-fixed-clock refclks pick up the driver automatically as
> their DT moves to the binding, without each defconfig having to
> touch the symbol.
>=20
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Daniele Briguglio <hello@superkali.me>

Acked-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de> # rock-5-itx



