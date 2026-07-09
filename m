Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F32C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 17:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD87184B73;
	Thu,  9 Jul 2026 19:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BMCxvHqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDD1384A8F; Thu,  9 Jul 2026 19:37:15 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661E484B8D
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 19:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a1888969ddso94167eaf.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783618632; x=1784223432; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bz7bPVB8pnvn/Zs5wZDXQKz2j9n422he04+HOWryANo=;
 b=BMCxvHqnc4xbRV2jC14ojOcAXu8Vat4yoUw8cjUT3PIpo4CWlrieubkUP0AI1ZHtZc
 6uHv7UEToW9PKCvKJ/eyKaSP5Pcws4QqTwrExVUh0qFDMHjtfgub4MA6mlPQbk3+MmoB
 NkmTq+ru+PMkg6Xx/D3SLTCxUZ/Gbkig6Cfbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783618632; x=1784223432;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bz7bPVB8pnvn/Zs5wZDXQKz2j9n422he04+HOWryANo=;
 b=SjWJXUlbQ3F8JEbYJImMtHpMMigp+R99leeislbRHHVUWJmuZfnDFt6p0NAMXSJ/LS
 KdQIa10LCrOCsLU5WQ+dcqVsi1gw1iBTbj63VGjkW15a1N4elA4CLKxjZLYiiCWisNyl
 bsZD+TAkz/AN1eiT5sTugR2RMcWHZX+ZEQdjxmsbxgFGWyWEXhMdutVDjSyiS0c/uHkV
 vJunAMIGjLXxLmV7rtobYnMK6DL4QHJQV3t3DOQswhOLcudyvZ+a7BN/KK3uOmfVECuz
 G+EdBF3XpmIBRnfc3fhkKAIvpHqtEZa4v+l+oxGszUoBIKERFbQDOh4Hh/W1Qmma28kG
 uWkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9V58Cyd4LmEO7BGl+EGEtr46C0pMKl5/tqThQVbOzGY1/b8FJ+pDN6C9ETFj76TZPKL8ukP6o=@lists.denx.de
X-Gm-Message-State: AOJu0YzC3UNLrZFxj+mYrCzrcGp4umBhA8dz3ZmM8s65QEF0Ga1iIn6C
 RajgcjYj6aKDZNnPeV+PgtRvQ5zA9cTCir5KzEIdfchicWJ1nOUJO0hOvOqXkk2eH9g=
X-Gm-Gg: AfdE7ckcobHvlgEQQomaDek6s9k6cgg89NL8i/oGZSi1iPVQhF3t5Ne+SA5gFkNWvUw
 Z/h+NNdmc3PpkVBGZW40pE6HG/J6vqA2jW9cejReGzkp3dJW+IXoF3cvLOjY9sXEct1Q23CIN9I
 nSd039Xgh5oagV5q6LxziVCkm0wAS9HwTaW+u5H9rS1S0B4kh0bD+z+d7jTjCuwJ1zJaMI475+v
 M6JAaag3JXOIuLR/ZuzDRn8CwJO6Rl8slNzyouRwEBXUOk5mz3AZEeF2NaLvWn9uGh+w7ByTDja
 kwC/fQe+XQcyQaYfFHaT1KPnYqWjQCVgiARNC2BoJJzMeDteytBj5bIqyYPFgyyQdcCtmvWBmpO
 dB5tKkqXq/Onb2PWKK9NUP248qFon+SF2L4zXxqAKQVTVMw6ub/jAtNyJjXImK2G+XTd+bh7Jx8
 lUMeycYXAUCuLQMRsAB4tAggR5xZLyWcGUhNtWJyNHkM8XGxo91NFnWJlDDsQ+6PlmAzjNlrab3
 CWa64xK/mHQaMvGyuBXv4TbyhUvGNvaqwsB
X-Received: by 2002:a05:6820:99a:b0:6a3:83ee:6338 with SMTP id
 006d021491bc7-6a383ee6c43mr1809063eaf.26.1783618632124; 
 Thu, 09 Jul 2026 10:37:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4519134dff2sm2522419fac.8.2026.07.09.10.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:37:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de, 
 Markus Gothe <markus.gothe@genexis.eu>, 
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH v15 00/24] pinctrl: add support of Airoha SoCs
Message-Id: <178361863014.2290342.10627903121263378059.b4-ty@konsulko.com>
Date: Thu, 09 Jul 2026 11:37:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 03 Jul 2026 14:56:03 +0300, Mikhail Kshevetskiy wrote:

> This patch series add pin controller and gpio driver support for EN7523/
> AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
> gpio driver with Matheus Sampaio Queiroga changes.
> 
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_en7523/kernel/src/branch/airoha_en7523_pinctrl
> 
> [...]

Applied to u-boot/master, thanks!

[01/24] watchdog: renesas_wwdt: #undef field_{get, prep}() before definition
        commit: b8b9ca05c720d97c6f5f9d0738e7743de94e7a26
[02/24] power: domain: renesas-r8a78000: #undef field_{get, prep}() before definition
        commit: 40db9d313be6f6700ae1530b245e48dd1f60d51b
[03/24] net: hifemac: #undef field_{get, prep}() before definition
        commit: cd36be5a4731fb1d640458101ae7327b3e450c73
[04/24] mtd: nand: raw: sunxi: #undef field_{get, prep}() before definition
        commit: 9b5c0b883485a63eac437ade055b1f3a928eb39a
[05/24] clk: renesas: #undef field_{get, prep}() before definition
        commit: 6bbf6cfc915672005f118c5b8419d7a971fd3515
[06/24] board: renesas: gen5-cm33: #undef field_{get, prep}() before definition
        commit: 08badbd7d82c2f1e69051f110cd8966e4bfd573d
[07/24] bitops: import BITS_PER_TYPE() macro from linux
        commit: ab447ac61782bad20b73bd9e19dcadb255c27f8a
[08/24] bitfield: Add less-checking __FIELD_{GET,PREP}()
        commit: 9c10cba536874641bbc70a53588d6a59c9292e2e
[09/24] bitfield: Add non-constant field_{prep, get}() helpers
        commit: da10fca9b062bde09144d65a0559676c658ac0ae
[10/24] watchdog: renesas_wwdt: Convert to common field_{get, prep}() helpers
        commit: c02633a823b837cf59d84324472ce4169a39dfa5
[11/24] power: domain: renesas-r8a78000: Convert to common field_{get, prep}() helpers
        commit: 0a1ca728f97f433f1b264c541c0376818dc88631
[12/24] net: hifemac: Convert to common field_{get, prep}() helpers
        commit: d2f172f3054b98e9ec51180bc9574bf6e3581e63
[13/24] mtd: nand: raw: sunxi: Convert to common field_{get, prep}() helpers
        commit: 3253f2b326b3ce7a520c3233923f03760c510fcd
[14/24] clk: renesas: rcar-cpg-lib: Convert to common field_{get, prep}() helpers
        commit: 575717f4b67a5b3f2e342ad22283473cd5f3e975
[15/24] board: renesas: gen5-cm33: Convert to common field_{get, prep}() helpers
        commit: d26cb20e6bd70a47ca7ca2ca8d9145e669475824
[16/24] pinctrl: add more pinconf/pinctrl definitions
        commit: 7518f6fbc4b9f786dabef4ada2881024a2039bb9
[17/24] pinctrl: sort and format the contents of the makefile
        commit: 05a8f13bbdbf6b7f0e6b799668a1758046a90fd5
[18/24] pinctrl: airoha: add shared pinctrl code
        commit: dcdd7aa2644ad66a004c17aeeb878ea9da35b295
[19/24] pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
        commit: 1c98e84c04bf7f9ae183849e4c9ae05b535ccc92
[20/24] pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
        commit: 56d820371f3a8025b6d435276d07bf6dc1342c93
[21/24] pinctrl: airoha: add pin controller and gpio driver for EN7523 SoC
        commit: 5c07bb58962d474bcf8902819a7305b682d0dc3a
[22/24] configs: airoha: an7581: enable pinctrl/gpio support
        commit: 8f99a782fdb3ed4a934174f763cf5feafcbb7941
[23/24] configs: airoha: en7523: enable pinctrl/gpio support
        commit: 4c7f94a738572f406e2b0644b34b0e57493de115
[24/24] arm: dts: en7523: add pinctrl/gpio support, drop legacy gpio support
        commit: c56c7298c42b06043aa3e9ae5bafd021bf1bac4c
-- 
Tom


