Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F02C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA0984A12;
	Tue,  7 Jul 2026 21:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Rdr3MyLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD10E848EB; Tue,  7 Jul 2026 21:12:06 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B0D849D2
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-485ecc0f2dfso2752995b6e.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451523; x=1784056323; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hjaHRj9h+s12dlKpvhJG6BhUOk1ijEJBX00VWXOqsDI=;
 b=Rdr3MyLA/jfxS31HftemAemqZXHpq/H9gLlRp6YPDkKdMIy0A4AOjLk1NUj9tNjdZh
 Hh0dMvFVGJQ+/Kfd541kMHgHNTFO+RiKiKd34PSgEYdy5dq5zDKBTd8dN+i5xqRt3iKa
 lcGcPxM0WsbYORHgXnEzHE5lNNMkHqpA0sglbzOsWw7yZr7/YvYmaBAachTrAkX0GQwB
 u3jS0/SQiujSnb7bQ7BgG+HwoOIwJv6faPR5yGg/MIlJCZbRFTO6BE5cpR7lzBatj8VJ
 BMWq6+eCtJ+z0Pb1WFfrz59vBOcWv8wGCEENrs8dLrn0WHz7jWgSJ6IhPvGQw1UXsqD5
 79HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451523; x=1784056323;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hjaHRj9h+s12dlKpvhJG6BhUOk1ijEJBX00VWXOqsDI=;
 b=U3AM0cfs3L213wHDgFUGiT/r3qS4mUlXsbWzM2u4hYyRn/TdRMY2ZNfY6cTKiZTcF6
 MLc3lFFyn2wOz9Gn4qp0JqTHKtHgUAFec9XEtiyO6ly4CtjuUjxlUCCuuI2lxNHEEa+M
 lNPdcFoIoE8Bg2udF+C2z4fldrHIZhJXEJPzI0MmtOH1I05lj7AuCNyylvNO4/+bgjVQ
 kNpCyPPtqAlS0VHFSe7CClOX57b4qM17ECcm2ROALOZQynlT7Lr7Qvcar7SOFZZRvETr
 iuPpL5lYFKOUZPD98yNrcqBLeJimA7UuW4IaKpmJZUnnlzlm4e44GuYWMvuD+sak2RGY
 VM3Q==
X-Gm-Message-State: AOJu0YxFYAFqy/vEHD88NlDr1Xs/wCDGMdFf6N6k6BG3YweKAUtt0BLx
 3srAUuE4hx9f41TRE+6lP22SDgexit2eqohW4h67gHd0NszvFXMee7qxY7SdDOy/WuY=
X-Gm-Gg: AfdE7cmEqL2okmpdJ3OU0z6ll1FTHN3VU/pXuFqqwrszQ/X2vcQ/lxtrw9ypwOGJUD2
 JoKS5IN6KRIG2PauMCSz3QSGa+0Sn1MNJ56zBhBJy4elruPv8zFscIthUHV8niuVHJpQEz2bgxb
 d91PC9s5nNs3MmyI08TrBIy0ky/fOHrC5yGof2m1hiVO9TtU+YgcZHXOJSumIKSQrdF69p8XJzI
 eNuPOrAiUtD3/bViFiFQyqJAqFNbF/ROdeOYuvetJrnTjl9XvlNaYXVz6qtWra447mOEpsI6WhO
 /BvYlbSMxyQQWN+pZqVe2+muwkUcReL2gkgB3jiudD/bQl8stIbD5Gnb6h7E2p8oE40/407yTfL
 S8W9nrAoFX3mj18ru0ERmGE4A1u6g99Ajypl+kTJ3XkYNHsnXeO1LUw3T/5pqygCbXbQlBP7x3F
 /FoRNhqrhlVeUX/PXIsA==
X-Received: by 2002:a05:6808:250c:b0:49b:9a35:f71d with SMTP id
 5614622812f47-49fde6e5b31mr4019310b6e.30.1783451523554; 
 Tue, 07 Jul 2026 12:12:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:07 -0500
Subject: [PATCH 05/15] clk: mediatek: mt7986: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-5-283d9a55361e@baylibre.com>
References: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
In-Reply-To: <20260707-mtk-clk-unique-driver-names-v1-0-283d9a55361e@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XZvPp0R+QK5HwP4kEd91SjwbGLrpje35aPkf1zdlEKo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU8xJBbD3b2E8o962T1WdL5A0A8tvSshgFzuw
 n2FbgGtD7eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PMRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHZAH/RTANv3FPtwmxyaGoVr/8UkUnz8LUxxwFu8d+sg
 Z5mqqIyONRJA4OpFdU53snLtWUvWxcgeJ1/r/MrJu4TyB/yOXvfpCG7CEpSkTJRzrnZ3iJmTGd4
 6Xg67PF5GQ7mJSyXKQ6NgU043ns3YM5ELNCPggzUoDnDxsL8r6Vrl90hCukl/cUPpCVh9bTHfgU
 XWOe1AyRrjqOip9/wUKgOExGilc0i2SYjJHuWF31M+/waOJoiXNUTr1tZHtTihwU97WbIeCYOX4
 Ch/LYJbxQlZaY+wqvZ7GNOAPytqR5/00Dv5rN02D0JpAazjQwPUUFgIDm4FA63UCMJymYmCJUSa
 4qR0=
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

Change driver names for MediaTek mt7986 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 731ed6035cf..8fcb1616503 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -595,7 +595,7 @@ static int mt7986_topckgen_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7986_topckgen_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
 	.name = "mt7986-clock-fixed-pll",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_fixed_pll_compat,
@@ -605,7 +605,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt7986_clk_topckgen) = {
 	.name = "mt7986-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_topckgen_compat,
@@ -625,7 +625,7 @@ static int mt7986_infracfg_probe(struct udevice *dev)
 	return mtk_common_clk_init(dev, &mt7986_infracfg_clk_tree);
 }
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt7986_clk_infracfg) = {
 	.name = "mt7986-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_infracfg_compat,
@@ -679,7 +679,7 @@ static const struct udevice_id mt7986_ethsys_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_clk_ethsys) = {
+U_BOOT_DRIVER(mt7986_clk_ethsys) = {
 	.name = "mt7986-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7986_ethsys_compat,

-- 
2.43.0

