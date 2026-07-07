Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD53C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B218498B;
	Tue,  7 Jul 2026 21:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="b5Ma5I0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83719849F3; Tue,  7 Jul 2026 21:12:02 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C33848EB
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-44cd237446cso2895112fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451519; x=1784056319; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nf86QZO9rZesPeQ4ZlA7b8U10TFwxgpZWw0wY19FZ9Q=;
 b=b5Ma5I0GEggOuey8KTxYmRbw2g5B8OyivxUKqz5J9+n8Us/JFjwZRqRycIPWY2IUlc
 u/9AfCfATKECD01v5ufr1tvkDfbLAz05ObKVkeL6i1EkaJ40rQLC2B4ctA9fzOOi6jGF
 ePho8O/HLtPOexIvm51A42CduL9+MUGW6Uo5P4Q48rji/anp/3tmKLUPGQtsHYwrLhhc
 PxSZ1oXRlA8WIuQK1Uf2O9YjCrm388fKLx5Xqa92k2a/FbME9WMOHazTwZx/qqTdw1lo
 /oPMmQOTM+nKPM9snJ3/Cx3+GR00L6F6L3H/Q6HpwF6uubM1lw9ShcMZAG/Wsowv2y2l
 7FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451519; x=1784056319;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nf86QZO9rZesPeQ4ZlA7b8U10TFwxgpZWw0wY19FZ9Q=;
 b=Drr3JLvxN/67dR5cNAmmbJpEsHgY6PjlwggvCcJQiLUtM+3dvt9rLpmN2N3AsBVtac
 JefrCel0ONmjJazH0VS7apkFxuN5JpoT8bnorAh0KJlNi7iOKXCvUx2DMt+oUrzGj64w
 IKPUXT/qfqsD7qOngz35hy8gDdW9iJQmHZp1NsGIDvpb27NjkVNw6+kIbIUwLfurHoBV
 NwruwWd3XXVdR7f1YgAqwpt+u9CrYx1Er5OhAh8jUg9+X2Xr6mH85m3p+YpWJ3KZWUIw
 hl+ka/AaMOmwT8GrJbyBPTUPqHa84l6GwwhLI1PuQ0w0NZD/NyA7dhtqNmKn2r3H5P+s
 y0yA==
X-Gm-Message-State: AOJu0YzE0X4AHjNQ0SCzJ/qoZgm2A4h4Vq599Dqy3kytq1WhKLM0nOxt
 pPPlaahz/DCemTwToYz84pSy8V0fxxehCtbHJClDB2ZJ8QvARwa3EKlYnbvWrHwdBS1jAbArx1Y
 p88KF
X-Gm-Gg: AfdE7ckhZll7LIZurou8y77Ju+0JBDO1Gn4Vqc/D+IV+s5c8WuxxRU1Et7EXuJDmVEK
 fiEl1+ZySB9od3pejfnafqojS+XUp4DWrHlTnttOUUvHeg4n8XjCMdt/PRfVjWkci1wllV9nIUf
 QftKfKHol69tMM516Pgt6RVTw4qiJQWk+6HcMUNfQjKeKsSn9/0R286XjKGqZR93u0u2zn5ZuA1
 qhEo0JiZl2kUKbaSxyCMJLua9I/Dc7r0kg8sq8nHRqWKeQY8yAdVwZ9fRDKJkC1+BeUpLVNbF39
 zOb3QQXLowIwsU65bctfx1iyW9unWHOqRBSu1DAmb8IF9845QJ8qV39fInBAvA+9n/9qkK0vbs7
 dYXaZHOfwWtUK3vnwzrMs2HRivREyahvSAVekoAhKk9sQxnsPUtZlihmuKF5Mefv2PN8l8p39DB
 vBBmV26ioKVNhmL7CwKg==
X-Received: by 2002:a05:6808:4703:b0:494:fa8b:d061 with SMTP id
 5614622812f47-49fddfdbf6dmr5211156b6e.29.1783451518603; 
 Tue, 07 Jul 2026 12:11:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:11:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/15] clk: mediatek: unique driver names
Date: Tue, 07 Jul 2026 14:10:02 -0500
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WNWw6CMBQFt0L67U0AoQhbMXyUcsUr9kEfxMS4d
 4sS/ZyTk5kn8+gIPeuyJ3O4kiejExSHjMmr0BMCjYlZmZc8b/IGVJhB3meImpaIMDpa0YEWCj0
 Mktdly2XV1iVLBuvwQo+P/dx/2cfhhjJsyv3hcIkpG763f7XL9ib/Na1wqAPcjZmjBVLWmRVVm
 jyciqLiuWiPKC/dWmzuQXgEaZSi0GUKRxIBZ/BBTKQn1r9ebzKViIz9AAAA
X-Change-ID: 20260707-mtk-clk-unique-driver-names-bc65296c4952
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4195; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=SaJ8IU9b1ctjmHuBQlGb2ixXahVcelg+zWEavsZk+bE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU8QPTJThwggDGZHbFbkCFzLj/GcOQF7Bd1dt
 ZXE1H5JohOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PEBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABsYH/iII6oYe4Sb/MEBWTaKsagLQQWwSgaKD6dS/RKH
 xfCFHck5MjEfLIYY6Tq1pGE0gpfmlV1LqTZwm1D2kTFyY8PJ7F2sC3Z8amYtbySlzNWifEPD2qr
 C5PlltLggGyd6hU/v29xCQ/Wodf4J0Pb7qnzIs0A/pcw9E+srUrYwHAd2XsOFPWEs3s7vxeC7gW
 SCirfR/H+lMjd//XUhR/9cH4dxZdgp4jkEsdhY7Vbw/EZHMRjdYMoCOUa/pXJuMm5mEKHgw2XK5
 IGLvhBLnvn2JxqkUA2jCVdoQgLIWpdBOt14F5xZ5/cMSi1nSQTViAwRTxBs5jQaSoOEWVei223h
 plzU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

It came up a while ago that we want all drivers to have globally unique
names in order to build as many drivers as possible, e.g. in an allyes
config for build testing [1].

This was blocked by the fact the core driver used these names for
looking up parent clocks. This code is slated to be removed [2] so we
can proceed with renaming the driver symbols now.

[1]: https://lore.kernel.org/u-boot/20260323211331.GO502704@bill-the-cat/
[2]: https://lore.kernel.org/u-boot/20260707-mtk-clk-parent-lookup-improvements-v1-0-65d24cc0d569@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (15):
      clk: mediatek: mt7622: unique driver names
      clk: mediatek: mt7623: unique driver names
      clk: mediatek: mt7629: unique driver names
      clk: mediatek: mt7981: unique driver names
      clk: mediatek: mt7986: unique driver names
      clk: mediatek: mt7987: unique driver names
      clk: mediatek: mt7988: unique driver names
      clk: mediatek: mt8183: unique driver names
      clk: mediatek: mt8188: unique driver names
      clk: mediatek: mt8189: unique driver names
      clk: mediatek: mt8195: unique driver names
      clk: mediatek: mt8365: unique driver names
      clk: mediatek: mt8512: unique driver names
      clk: mediatek: mt8516: unique driver names
      clk: mediatek: mt8518: unique driver names

 arch/arm/mach-mediatek/mt7629/init.c |  4 ++--
 arch/arm/mach-mediatek/mt8516/init.c |  2 +-
 drivers/clk/mediatek/clk-mt7622.c    | 18 +++++++++---------
 drivers/clk/mediatek/clk-mt7623.c    | 14 +++++++-------
 drivers/clk/mediatek/clk-mt7629.c    | 16 ++++++++--------
 drivers/clk/mediatek/clk-mt7981.c    | 12 ++++++------
 drivers/clk/mediatek/clk-mt7986.c    |  8 ++++----
 drivers/clk/mediatek/clk-mt7987.c    |  8 ++++----
 drivers/clk/mediatek/clk-mt7988.c    | 14 +++++++-------
 drivers/clk/mediatek/clk-mt8183.c    |  6 +++---
 drivers/clk/mediatek/clk-mt8188.c    | 14 +++++++-------
 drivers/clk/mediatek/clk-mt8189.c    |  8 ++++----
 drivers/clk/mediatek/clk-mt8195.c    |  6 +++---
 drivers/clk/mediatek/clk-mt8365.c    |  6 +++---
 drivers/clk/mediatek/clk-mt8512.c    |  8 ++++----
 drivers/clk/mediatek/clk-mt8516.c    |  6 +++---
 drivers/clk/mediatek/clk-mt8518.c    |  6 +++---
 17 files changed, 78 insertions(+), 78 deletions(-)
---
base-commit: 6a320da6ed11817859c5fa5267094907653405b7
change-id: 20260707-mtk-clk-unique-driver-names-bc65296c4952
prerequisite-change-id: 20260706-mtk-clk-parent-lookup-improvements-811460a93ecf:v1
prerequisite-patch-id: a87c4fcb84fad1ccfe198c86b3ddd28c709473d7
prerequisite-patch-id: cf4ca630e7917093e3e492c60401242e654724c0
prerequisite-patch-id: 7a1ed9ee2d090d8412b7e75109dcf78fa40fbf80
prerequisite-patch-id: 3ccb0117c6bda1d2b7684c759c48bcd1be57e758
prerequisite-patch-id: eab4d8043469565bf349fba6b0294e71978ea15f
prerequisite-patch-id: a70dbd9d5e654ffde00c394db5976cc1a85563e3
prerequisite-patch-id: ea2acc0cb136801975e438b97a5ee3928845a975
prerequisite-patch-id: 4d6af496a8f57a6a359ef810699c9be0d8e4aa23
prerequisite-patch-id: 16af40443339bb30a1009c78f0d4b5182fed7235
prerequisite-patch-id: ed2e4a662f8372a89eb8dc88d785052c3e967fed
prerequisite-patch-id: a45ed7a978d8863f3476f1ade9c9e575d3e949db
prerequisite-patch-id: 8e30eb79bd94aba1c479ac45ac8266f1ce42ca89
prerequisite-patch-id: 535d75dfa5b139070b598181a8d9952cc57879ed
prerequisite-patch-id: 6efbba680c67ce9bdee4c8277a18eb3310069258
prerequisite-patch-id: 609c0453bf79885891445d20e5df1bd862a771aa
prerequisite-patch-id: 55ff4ab62dba0c64f6909091ba9758d28f069f1d
prerequisite-patch-id: 00930b851ae740f9aa120399ed5c5a87075e9d3c
prerequisite-patch-id: a65f7cf078cd5e2d2b416a191733b257af72e92c
prerequisite-patch-id: a5da91dc86881983b7dc8180444c0890383cdcfc
prerequisite-patch-id: 2f650204d07baf9e38efd73e5a53852576d21760
prerequisite-patch-id: d648d7e9a96aefbf70b24f792c5d3339b0a5c2ae
prerequisite-patch-id: 736e17bcd00cd64541feeaa2df26725aa70e21c5
prerequisite-patch-id: f0c4fd4ab3df6174181f74ef63b83cadc33e1f61
prerequisite-patch-id: 3c314383a7e10a9f5e3f41235a4e660cb46b07b3

Best regards,
--  
David Lechner <dlechner@baylibre.com>

