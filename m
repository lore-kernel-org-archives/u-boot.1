Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15340CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FFB84951;
	Fri, 12 Jun 2026 22:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ECYfJ0B2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BC2848A6; Fri, 12 Jun 2026 22:27:41 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5798063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69e46524711so931203eaf.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781296058; x=1781900858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swDA42XSDG7Lse5LbFCKmRKwVMC4aGRCO7Oh6VqZ75o=;
 b=ECYfJ0B2VfyZ6/po3n0niiSn4nHG+deOxfMUkBQMs+tBh2E/3+uFUUlkZosFA4yup/
 mwDqj6zYPTqVQXcAbNto8ab1qHPW48Put/zKaz+n96vLO4YMEnjhZnM9GA9zz3KfyCw6
 Yv04sd666Y2//IkOq5xW218+XP+q4aVdzxH3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781296058; x=1781900858;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=swDA42XSDG7Lse5LbFCKmRKwVMC4aGRCO7Oh6VqZ75o=;
 b=FHT7OSlupQo51LeO1rG0d0VhvOijBQGYOvm4+rO4TO4C207xhf0RLN3q148RfywOFM
 NIDkI/pn5ZiFU30HS0XB5hQaScnyrhiK9Z+y3hY4WD6YmREMBVstp0MIZiz1QSNUOJDE
 Olj2tj17/m3JHBsTYNEpgd6x4bVUl/33E3NeyPPwejZezkDy03VUgiasIEL1OKc6D6HO
 EvnQ8OQo9sRIeKemviMkV2LhN+bXhGPA/wgUx0SgrEx+ySM79oFcU8DxhJnM80fiXCeX
 kTgy5QfmuosDuArbckP+mxEBYJObmp87V8Xnsn07UGX47YcSD2MuuLNfbYWeCKQB53v0
 BKuw==
X-Gm-Message-State: AOJu0YzoUr6SMG0kmcWhmSrT9Rkg+ZTypWq3A8QQwv2idPVrINiKiaF0
 ZEWqlS/5dlXpeRCpJk8wHzRugv5ovBvkWApv0xP/NoBgTvLHzDCz5eIO9dr6g2E6/js=
X-Gm-Gg: Acq92OF7pwN+eAL+t4JGCDp5JkQhwC3W9fSv7ZgXUzTQTmyd5QYxpqrO/UOhWSeuGnF
 ywP8pavXFLyHA5ptJxqNekklQ0tUB0bldBZB1fEiUsFrObSMZW8FBkkJlP+np6ds6l+k+TI+R4C
 ol4H3aoTu/JkSUbD8fNCQlSleESf8nadSxEstsUJWgQczXJDKKCkEUjyhKhnQJSsAqgkpHhUhik
 qWrsYIM7Hddeq5nZPOkVOOXDp0PyJ+LodJhYzEtOpJoX//o20LtdFRt1XMX6G2dDvHYs0O7mONi
 1o78BfYDQR0QvKM8xjPlV9h4L4p2+GLotEYwJDZuNFciT1D3uC5CDW8smAHqPQnOBKtQHNsaID6
 IhQQPUMzPgUoOBeAAx1ibGQyltJntdPd7kYugPg3ibG1j2afVDhdi6r0ie2dEUJDXfvaPJ2Qmm1
 uNiNWn5BJvEez6mE/+nkdSnCPZWJ6iLqMm9zeEQPjWDQpY7De2uXtgneMjvIUY5KkHIUt6Zyyic
 vsrYQQp5pdFeku9kMJQlCMC6LbGb206YVfavc+tusqqXcAwhgyQ6VSK+g==
X-Received: by 2002:a05:6820:138c:b0:69d:9b72:8151 with SMTP id
 006d021491bc7-69edc760185mr2624127eaf.41.1781296057761; 
 Fri, 12 Jun 2026 13:27:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426b30eea5sm2597585fac.14.2026.06.12.13.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:27:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
Subject: Re: [PATCH v8 00/17] arm: am335x: Switch to upstream devicetree
Message-Id: <178129605472.868114.5945719675413717440.b4-ty@konsulko.com>
Date: Fri, 12 Jun 2026 14:27:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Fri, 12 Jun 2026 22:49:58 +0200
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

On Mon, 01 Jun 2026 11:30:35 +0200, Markus Schneider-Pargmann (TI) wrote:

> The series is split into two logical groups:
> 
> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>   with the current u-boot devicetree.
> - Patches 4-17: Make upstream devicetree working with uboot. This
>   adds tick-timer, adds compatibility of the board code for different
>   USB probing, makes SPL smaller and updates the defconfig.
> 
> [...]

Applied to u-boot/next, thanks!

[01/17] arm: dts: am335x-evm: Add backlight to the panel
        commit: 380d8e388745896a31241b123b75737f4b0ea58f
[02/17] configs: am335x_evm_defconfig: Enable panel
        commit: d50fd4e4ad6e4d5c2b4460c6eb11ff2c5db1b735
[03/17] include: configs: am335x_evm: Enable vidconsole
        commit: b941dc47398b93aea37b9139d6816610ad78352f
[04/17] configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
        commit: 6e01c9435eec065078561239f19a7250678601a9
[05/17] configs: am335x_evm: Unify evm board defconfigs
        commit: cc1c6632b6444105f52147a2d1d0d9f92f6fa993
[06/17] am33xx: Avoid hard failure on USB probe issue
        commit: 44d86f9194acbd1c649278d7e63b79280f26e1de
[07/17] arm: dts: am335x-*-u-boot: Add chosen tick-timer
        commit: 0ecacc52f4e1871678fc97b3c30a81398e813f22
[08/17] arm: dts: am335x-boneblack-u-boot: Add lcdc to all boot phases
        commit: 515a20d7ee2b053326fa3e4cc036330b00de437f
[09/17] am33xx: Fix comment about config symbols
        commit: 9e54b0e9861f4de054c5124b8d7887e983613078
[10/17] am33xx: Support upstream devicetree USB device
        commit: 39762783b1268a9f62f426bd2f328530c0cec67c
[11/17] dm: core: Split SIMPLE_PM_BUS into phases
        commit: 0c57d71f4ef33275a49c422b8375e0c785eb961f
[12/17] configs: am335x_evm_defconfig: Switch to upstream devicetree
        commit: d21db0e6afbdcae4e0abd8e21ab7f76953bb93e3
[13/17] arm: dts: am335x: Remove unused uboot devicetrees
        commit: 1cf2fb7bce4550d0071a06b76ef381f4e016ceb7
[14/17] dm: core: Remove dependency on CLK
        commit: 5c3741f1355be429f8258975745f2ec701174cc8
[15/17] Makefile: Move dt_dir definition
        commit: 9c1a0f7b45540a8029b8d308a66d9128b98bf5cf
[16/17] arm: mach-omap2: Use dt_dir for devicetree paths
        commit: 484dacfcf18fb2bf2d3e50f76e11f75f2f76f1f4
[17/17] arm: dts: Move remaining am335x-bone* to OF_UPSTREAM
        commit: 1bded011586688be654c08df7dc922cc6b688e94
-- 
Tom


