Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28ABC5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 18:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 439EA40A02;
	Fri, 21 Aug 2026 18:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXPJg8TEu4iR; Fri, 21 Aug 2026 18:30:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787337059;
	bh=xI32+9tgw9SjlVnbMG4s8XrOOXQQGxwpV8otLm5/C70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BbL2667rdTbySA5Cghg+Bn4yqapRFZdk2UEB9/gGEwat7X9MQlaJvid0xclzyssRK
	 UhmsknycYYo8mv2XjCxNd3G0tsj6Gxo7omycJEuhLbHTWvdVOdMh/PQkNp8kWRon+M
	 3VBzsDYownPi9XLWdtkc+HG3m2w/PD/Il0gYbNZuYp7mXecXqwEv6HskhDp5VQQdof
	 eKVorExYIE9QHSPYNuO4T4a7xh8RAlO3gGghXVt5qkwYn1Ke77NQTtYUKsZbWapVuM
	 FKv6uqzbAAWomsWuCWomgZTWvYUAWUebxtTl0OuMKVy/U+l+RawzTMMkK4uEazY+Xm
	 f4Cz04Z1t3Ldw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8D9140A16;
	Fri, 21 Aug 2026 18:30:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C01F93F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFC0D40C31
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZzI3qORw_ox for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 16:43:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jCNjUkRM
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37CF540C0F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:43:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71E8F42B9E;
 Fri, 21 Aug 2026 16:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D4B1F00A3F;
 Fri, 21 Aug 2026 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787330579;
 bh=xI32+9tgw9SjlVnbMG4s8XrOOXQQGxwpV8otLm5/C70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jCNjUkRMyI2aRZI7QvZyviBxEJxzhKrWwu6ncj6jndHDEHZOAl7kp1aXLDPVkjKtT
 YMtY2uWej2poola2ZCMnF13UBmMHULpxPgQKbVkFQNHL1GUMpJqi6zPRvdm/MrHg1u
 /2c9WVSbFjKGaa2c76aUmKOerslp3td0vjmunJwddCv255oeeEqmMq14LrHwOfoLmZ
 ViEszY4Mle9N9CeV7cmoB4XMpjAw5BD4XD1DlIe7U7q1tctibUyFsg8PkizixdLwgL
 XzwlAtcKiQFnIApPxI6AD8PKafjDz/gFeNBL/fvgE3GBAk8ddP+rTNDhVEuBsOV3Pt
 oZAwFh6tuQYbw==
Date: Fri, 21 Aug 2026 16:42:57 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yixun Lan <dlan@kenrel.org>, Alex Elder <elder@riscstar.com>,
 Yixun Lan <dlan@gentoo.org>, Iker Pedrosa <ikerpedrosam@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Vincent Legoll <legoll@online.fr>, Troy Mitchell <troy.mitchell@linux.dev>,
 Margherita Milani <margherita.milani@amarulasolutions.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH v9 00/19] spacemit mmc driver
Message-ID: <20260821164257-GKA579897@kernel.org>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
X-Mailman-Approved-At: Fri, 21 Aug 2026 18:30:57 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Eric

On 11:54 Wed 19 Aug     , Eric Chung wrote:
> This series adds MMC support for the SpacemiT K1: an SDHCI platform
> driver, the SD card device-tree overlay, defconfig options, and SPL
> boot-device selection from the SoC strap/config registers. The SDHCI
> driver is usable in both SPL and U-Boot proper.
> 
> A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> write images to eMMC.
> 
> ---
> Changes in v9:
> - spl: Enhance detection on booting from SD.
> - dts: Synched upstream DTS files for K1.
> - doc: Create SD card image from scratch.
> - mmc: Avoid to use CMD18 on SD card in SPL.
..
> - pinctrl: Drop "fix drive strength configuration".
Could you please explain why this patch is dropped?

It looks valid to me, also it fix a problem that setting drive strength
actually clear out other pin conf bits which lead to serious bug

-               clrsetbits_le32(addr, PAD_DRIVE, ds);
+               clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));

-- 
Yixun Lan (dlan)
