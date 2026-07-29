Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1D2C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 15:40:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A62580DD0;
	Wed, 29 Jul 2026 15:40:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jHAXZ9tEqsTf; Wed, 29 Jul 2026 15:40:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E40AD80DBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785339616;
	bh=miVSVxwj72FXrOuGGK6ocpGFbVwXu0x4oAccTNw8l8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c4JcnvaEDmhxwX1i6F8VVIk84h7y7+DjYK1mxFVOi+3dWHJcQutqOof1hNoA5H15F
	 411/U2npHoeymKQjxgvJS/JJZtWfLKtkE6C0vufr6YnlISpBk7NtvStxqOZwfrrJM9
	 xqnDuOJZeC4CKqtVqRJNi+I63WcE1QoJAnG8DjAwzmmj0JD661U0F6GL/tXDj/W7NF
	 VaKXSxOy3r+07U9pf3IBuP2z2JB5PjnA9K5aplegO3OTy0CCNzo2qg8Z1RE91CIS8u
	 Qe5hPqKfbZyhQVC2J9vm2j5/1bMe7bDvhmnnNSRcYDBTzMbWCGChZLpud5/4yZgTe+
	 bimT18QNP/67w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E40AD80DBF;
	Wed, 29 Jul 2026 15:40:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E2EF2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 643F160626
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:40:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pQdJ40zBos8o for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 15:40:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F04D660609
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F04D660609
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F04D660609
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:40:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1328494B; Wed, 29 Jul 2026 17:40:08 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 916DF82991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 17:40:06 +0200 (CEST)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4a46a53abc9so583493b6e.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339605; x=1785944405;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=miVSVxwj72FXrOuGGK6ocpGFbVwXu0x4oAccTNw8l8k=;
 b=HPRBlI/49vNfxhEqxLkuSaKwUVS/fcABLBH3cvg0B2zmgRB4tT3BO3DA9UpvOfypXi
 a9+E1r/Zxc03pkoFZkgn3CE/ZTLNM7UumtxwCFrxp53Ab6r3iXrb2B02kZyV+aYqdLqw
 SSz2TmaL5gxy695drkVQidJ1qD0s9AAImPSf5OMiK4npLsCrg4Z/aP01rU5iFkm2rj5h
 KaM6wBqfGzbjmQvE9WxNp5U7cqg0zZgVCRDLS3TbjuVeWcSuIf9ElYquDd5MS/raQAZg
 5QWQ3ODRjo7q+aglD1twvM3ft15wdkPe1YVbWhxSaX80QGWaQSdPhjTOgQgvTIYYamgL
 NLrg==
X-Gm-Message-State: AOJu0YzA9F8oY/s4xw7j0vRCgXRROGtP5INdtB43pgVQBbDc58CDVrpM
 z7k3HH5RjMuZMubuc7LHsjsTQhwKsszy1jI0pbC9fUqktRrwGcDCvOgPZLfFCGVSFOI=
X-Gm-Gg: AR+sD12GRaELdl/iRcLG0UQkG0rENj3l/3XFxGjI82KJ5wnSHhErpfW6DHAI1VC+fVn
 0kACG4LTMeflEthe6sC4N/y9BjdFL+45bDwjICM7ukZDhjx61qY4vNRx5aBg+r3p69t3g5hf3uh
 VAt6lxt/l+f3Hhbv4MD2+jbRIDuthpETFiWAs+7/9fF35a3WK5niVnwTX8MP71kULodleHOhaum
 /A6L+I7iha/w1fChpoe008gKxDjKqxj3pRvGLdlbhF4NftyR4VaLBCdDUxPpEUmRnebimM9spXN
 eSYdYz7T3AdIWL52ZcnLCFvH3D7zHRsqL6gbD/9gaf5z77yhjUDVl2V0WanRwXwoG/HRmFtGXU8
 dxC+8jJpqrx5g7WEyuI5W2BuaCF5Joe7wfLp5f3aHA2Wc8fLlaFrm2nfC8e+Iurug6JtCgjG+Tw
 XrHzfUfy5s9lE4CWbpXorqrqNkLfv3dJVptYzsmhsjJ76NELLIARLINUK0j5Q0ZIAkwQ==
X-Received: by 2002:a05:6808:16a5:b0:494:18ad:8a5b with SMTP id
 5614622812f47-4ad5b6212bdmr3301261b6e.17.1785339605099; 
 Wed, 29 Jul 2026 08:40:05 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6efc6ffcsm2036403b6e.15.2026.07.29.08.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:40:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Sam Shih <sam.shih@mediatek.com>
In-Reply-To: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
References: <20260715-b4-mtk-clk-cleanup-clock-gate-drivers-v2-0-23e907516010@baylibre.com>
Subject: Re: [PATCH v2 00/32] clk: mediatek: remove the dedicated clock
 gate driver
Message-Id: <178533938737.3352940.10363300664585379780.b4-ty@b4>
Date: Wed, 29 Jul 2026 10:36:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5020; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=L0Zwwa1YZu0xIV3S8LQNyMNaqXtsn4A7uTNRHYjR6hM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqah7M4heKaAiU6cqN0bf1JkoTSjMEpYujKCKe6
 f55+5zYYEaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamoezBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AUMAH/1P5RNbJluBP3b/3JYJkWZfyfMXPNgEG9ZL1a1s
 lcmQOslTuS75Bp5QYnpNhlWJk1+fFomzmlc4hUhTv90o6Qm4omjHM8dounNFQxQeR9CM4Nmps8b
 gekIURM4S2TIEFjvURwobUd7MNQz+KkIBL8BHneI+T0KKTiHtXvlG2BQKlXY2+Q07BDE7TtCGEd
 9QE8pvHreg7E+2YFh98lSJBlwkK+OqChq58K/kQy2m/rtapkQKC6sJPe3Z9YfBp+zRR5Jw9ntEV
 DP2B148XWYO9+ds5WmBpWzyVW0Mwi9sdBKDJxs836gdmXgaCUqsix+kON/C61zSt7uqMGoyT3nX
 XIjs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785339605; x=1785944405; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=miVSVxwj72FXrOuGGK6ocpGFbVwXu0x4oAccTNw8l8k=;
 b=XBnPDoqgJcR+4+MfGyLDUPXqOaGFvIbghzMr5jeHl5fPFC4H1q4+p/9aEk27h+L+n9
 2dPjBVysS6+G/Kd29CH2v9lRmakqOb+Kbd5hfW/rQTtH7+xK+o1Tpw8/E2bxwIR5E+Jp
 e4g/s7qN/AfZjfQMRwWtanY2dCXB3VygVoiDP91RiZSmI0stNnC3DX6nYz1oBJryE9hq
 6UJkUlkwvl/b5sOmwfsrKDGgSpyZHB6UYVxxLWrwmciUy48Ul3c6kLM0Fyf1HpRBPpbZ
 /+ujYSOa5FVBOUZy3HQeLjj0TSvkTDL8k9BxbggsfTQB9AyjRjpTtushq7WvAXP55bEb
 MdhQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XBnPDoqg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="XBnPDoqg"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 15 Jul 2026 16:28:28 +0200, Julien Stephan wrote:
> clk: mediatek: remove the dedicated clock gate driver
> 
> Several MediaTek SoCs expose multiple clock gate controller instances.
> In U-Boot, each instance currently requires its own U_BOOT_DRIVER,
> mtk_clk_tree, probe() function and compatible table, even though they all
> share the same implementation. On top of that, the framework carries a
> whole dedicated code path for clock gate controllers (mtk_clk_gate_ops,
> struct mtk_cg_priv, mtk_common_clk_gate_init()), which duplicates logic
> that the topckgen path already provides through struct mtk_clk_tree.
> 
> [...]

I made a few tweaks when applying to add trailing commas, use CONFIG_IS_ENABLED()
instead of IS_ENABLED(), avoid an extra arg in GATE_CLK_TREE() and changed the
name of the common probe function to include "probe" in the name.

Applied to mediatek-for-main, thanks!

[01/32] clk: mediatek: mt8188: deduplicate clock gate drivers
        commit: e46941363e390dd4f627ad732ac369754b773f7b
[02/32] clk: mediatek: mt8188: use driver data to store the clock tree
        commit: 506b75797d755c73ec65ad3cca3a8273010264cb
[03/32] clk: mediatek: mt7622: deduplicate clock gate drivers
        commit: 7f6d4b14e6f168d67ece24ef14cd877dae4a7abd
[04/32] clk: mediatek: mt7622: use driver data to store the clock tree
        commit: 71b900f2037bce87b7b50d374262b18549b545da
[05/32] clk: mediatek: mt7623: deduplicate clock gate drivers
        commit: d77d52f3244b84318766dc446d8cc7323a6e0cc9
[06/32] clk: mediatek: mt7623: use driver data to store the clock tree
        commit: 636b038ac09353854626070705b4647063b52064
[07/32] clk: mediatek: mt7629: deduplicate clock gate drivers
        commit: 44c677c4f73a4abb19593adbd5ad5f906ff8256e
[08/32] clk: mediatek: mt7629: use driver data to store the clock tree
        commit: 1dfa53855337727e0b13c87cc034bdce4d06ce63
[09/32] clk: mediatek: mt7981: deduplicate clock gate drivers
        commit: bb9f7e62d6647235e2be22612de88b2146d77173
[10/32] clk: mediatek: mt7981: use driver data to store the clock tree
        commit: 3aaae670f35fe7b1e221ac7741ec53ced96b47ff
[11/32] clk: mediatek: mt7986: deduplicate clock gate drivers
        commit: f6d0bad12450540a13385b6f4415f2b746567da0
[12/32] clk: mediatek: mt7986: use driver data to store the clock tree
        commit: 83b3ec0999083fff3839add149312c7d8ffa918b
[13/32] clk: mediatek: mt7987: deduplicate clock gate drivers
        commit: 8aa74e4fffc1bf90e6831fae8d03045a445d09a2
[14/32] clk: mediatek: mt7987: use driver data to store the clock tree
        commit: fbf41a84eebdfc7cb4ade7845f64a21eab62a75c
[15/32] clk: mediatek: mt7988: deduplicate clock gate drivers
        commit: 712573b72ba5402c1c2946b60d9e9c7aee8e2aeb
[16/32] clk: mediatek: mt7988: use driver data to store the clock tree
        commit: 66f52575d03a2f74dc37d822ed84983aed4aea34
[17/32] clk: mediatek: mt8183: deduplicate clock gate drivers
        commit: 98e9bfc7b077a75dc5122dea28a40b3b0e43dcb8
[18/32] clk: mediatek: mt8183: use driver data to store the clock tree
        commit: 72c157c7e9bef30c4abe2179df65f9033217079c
[19/32] clk: mediatek: mt8516: deduplicate clock gate drivers
        commit: c74cf36d43511d915b3b3b557fd0e324b0b36d72
[20/32] clk: mediatek: mt8516: use driver data to store the clock tree
        commit: f1f627f1823010592fa90ffb8664a0ea39148f0b
[21/32] clk: mediatek: mt8518: deduplicate clock gate drivers
        commit: 84186fb05a7bae2ce8a378bee8e9fb89991faec1
[22/32] clk: mediatek: mt8518: use driver data to store the clock tree
        commit: 6dfb478c77ec08512a1b2041dfe1349aa81a4e2c
[23/32] clk: mediatek: mt8195: deduplicate clock gate drivers
        commit: 095ff3864fcdfb229b6de429b8c495b02f83f373
[24/32] clk: mediatek: mt8195: use driver data to store the clock tree
        commit: 356f09054558b88675ae3e437d769df5564fb7a0
[25/32] clk: mediatek: mt8365: deduplicate clock gate drivers
        commit: 155c7169c2cad7704e24182c25f9b8df924aea46
[26/32] clk: mediatek: mt8365: use driver data to store the clock tree
        commit: 39ee1d667e1c8bc59ca503b9faf7f03c051af2cc
[27/32] clk: mediatek: mt8512: deduplicate clock gate drivers
        commit: c12916afc9d011d5ca9e1435c67d576c904f2282
[28/32] clk: mediatek: mt8512: use driver data to store the clock tree
        commit: 8d35d3d110f11b9ca45e620f379b8ce29eb830b7
[29/32] clk: mediatek: mt8189: deduplicate clock gate drivers
        commit: 370316f4b4c0ddaa361c171965261cfa5503d2ac
[30/32] clk: mediatek: mt8189: use driver data to store the clock tree
        commit: 39164a7c87eedb582b068ad7195641b85a908021
[31/32] clk: mediatek: remove the dedicated clock gate code path
        commit: 11738176761de9ccb2670bf42a5b707dc4baacab
[32/32] clk: mediatek: get the clock tree from the driver data in mtk_common_clk_init
        commit: 70f453532192dd369a2c8dae2e4bc5ec8a4d9e97

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

