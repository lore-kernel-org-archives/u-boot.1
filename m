Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31605C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19034849B1;
	Tue,  7 Jul 2026 21:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="PcI1vV5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2516784A3A; Tue,  7 Jul 2026 21:12:05 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E495284A0A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-48982e3f12cso2703591b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451521; x=1784056321; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cc1wRE1778/+DCNBrzPKICnYYpIGCekeXTC22TVhRRQ=;
 b=PcI1vV5ehQkrcGksTGkiBBltQ36Wx/GjxR4D56TASpKg/IM/RE4fLqYoS9ypw+lNwu
 iZJVOPVpzv8tvjlMF2/7Hn+mEaOiLMgMVRAWYZrP5w6BO63SbcIZE1BKh3YfY4Xpd1XF
 huTiP9whFDAodjOIg9MjlDuoBfSscWMUoOHBQ6M3g2usjt0GOIDZ1rsIgu+3h4LuILhl
 hzS9+fyVbd3bYM4M8H+CTQ0MvwbtzbWpg88A3tSn82zUS98vGN0DJedIe9nkzR78lsXW
 e0VGIhHm27n5VEl8QD4+BvV/4H81ovoqeqiZs+pboiug1+R4RP/kl5xMIzzYSGta4D53
 h0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451521; x=1784056321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cc1wRE1778/+DCNBrzPKICnYYpIGCekeXTC22TVhRRQ=;
 b=pVzEhbRRMzw/Xq6G3LZ4ml/xSr3dHvdxNqih5DWlDsBBqOFR96znStI5K0pAVaZqlL
 +96jm0nIZ2lLyHMFwMC+CVg+Ouc18RpJwiXbTJCjmuCNXSftE6827JUndcutIwwTLN7e
 IPjdhOhD1W6ym35IkcJPeFlOadMNORW4RaCtc6y2tdGNA8WUfEB2E9zk3Dbcmpb6Z5Zb
 +8lNhkeL6XrP5f5EAy+8U9rvZQ/M7sPgiyFIfRCaR3V7Y6CfFua+P2U2fjGPXajxioNy
 2CN+kjt3OUe8dZYs8j705naFbfIV6tpkvrRs3A+4Ds+B6aBaj3mTrtok1qrfqq1z9gaZ
 agkw==
X-Gm-Message-State: AOJu0YxEnWEDs3G2/4cAcVLe6gPC9dwKba6mk7fNgxPVavR0o7IJWYYl
 0RwI6E7LcGKVth6+VM+6904q5ak6H4ZVozLuB2yX+KQApaEFskMpsWbsHP0I3Ld+yrw=
X-Gm-Gg: AfdE7ckuV0w47LFqQx2lVdpQPlkt0p4WH5ZiXAxVzfIe/5lh0tUuie0G4N+EFlyoUUf
 dKAIB339XhZWrKlh4RICfT5dAY1M3/aY5/2LZWkm4vZMyMKp7jZ4C62VDCZ8uUvPZb8ZLVxwxc2
 0kPDCPZbRBgqirlZ+0Dj4lNoTahVUk1G/6VTDnhqyEfrHPdfLzvNsV+TddkT39PKbl018JG5tS7
 Ux2a+d54UP3ds3RMPfZZBBGxZvY5rrdWQskxyOIiKSyO7EVzurezUUgqGJXmzypuuJ4NiJ6tqT8
 kYpwE5ZvaIDi94vfhOPxENlsMrUg77aIw5FgcoLvPBycJbVsNGyRUigEDBl00J0Vm1qKOjxDmlo
 19XhfKEW9aQvY2bXJGOT1KKLyIeNKYZrASnAezn18MX29rl3d8kJvw1HnbS4ujfQiv1JNYCcbku
 YdRRPM1QYPPDMg5WXK+A==
X-Received: by 2002:a05:6808:1910:b0:48c:3b4:2b95 with SMTP id
 5614622812f47-49fddfdba4dmr5077199b6e.29.1783451521605; 
 Tue, 07 Jul 2026 12:12:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:12:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:05 -0500
Subject: [PATCH 03/15] clk: mediatek: mt7629: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-3-283d9a55361e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3457; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=B8i5PKOUpJF61FRefo06ev5Qx7HU/PrAL+2CjtyNWJc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU8k0TQT7h78uy9Pzy79nmhCGrldVYOZVmVs4
 WC+xZu3W5iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PJBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AhoEH/3G1RKQGMkhP4WSabqzI7MRy8X/yJGyMvPIsYtm
 oqHsY3K+5w422DEK34/Hzg0yvtyAfwwG6Zc24p0110AgW0K7qro6SotCTLNkGYf9zdimb5EX8I6
 vrdXj+jm2j95mjf5djgVaoQPiMjvHoKI1dMDTUqtQXyMGIoCT1e7l5f0+OlnBKH+w7WM86vgDhT
 b50XxDi9ch/X6Q3WXilIs3uqvXm+P7lSnZauPSLeF1LcVqCMdBaB3HQFsXFdLYXp2m0H4enJQ1U
 X8YgrPsGY+pQ9VL9ax9La4Z0IaD556NP1zOY4lkR52j3A+QARFuBDoMPvGTdgm+e/1rcR05KLNI
 nxp4=
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

Change driver names for MediaTek mt7629 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt7629/init.c |  4 ++--
 drivers/clk/mediatek/clk-mt7629.c    | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7629/init.c b/arch/arm/mach-mediatek/mt7629/init.c
index ff027ed03ef..d12eb5339e9 100644
--- a/arch/arm/mach-mediatek/mt7629/init.c
+++ b/arch/arm/mach-mediatek/mt7629/init.c
@@ -41,7 +41,7 @@ static int mtk_pll_early_init(void)
 	int ret, i;
 
 	ret = uclass_get_device_by_driver(UCLASS_CLK,
-			DM_DRIVER_GET(mtk_clk_apmixedsys), &dev);
+			DM_DRIVER_GET(mt7629_clk_apmixedsys), &dev);
 	if (ret)
 		return ret;
 
@@ -60,7 +60,7 @@ static int mtk_pll_early_init(void)
 
 	/* setup mcu bus */
 	ret = uclass_get_device_by_driver(UCLASS_SYSCON,
-			DM_DRIVER_GET(mtk_mcucfg), &dev);
+			DM_DRIVER_GET(mt7629_mcucfg), &dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 793cabf8490..f3a1610e307 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -724,7 +724,7 @@ static const struct udevice_id mt7629_mcucfg_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_mcucfg) = {
+U_BOOT_DRIVER(mt7629_mcucfg) = {
 	.name = "mt7629-mcucfg",
 	.id = UCLASS_SYSCON,
 	.of_match = mt7629_mcucfg_compat,
@@ -732,7 +732,7 @@ U_BOOT_DRIVER(mtk_mcucfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt7629_clk_apmixedsys) = {
 	.name = "mt7629-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_apmixed_compat,
@@ -742,7 +742,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 	.name = "mt7629-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_topckgen_compat,
@@ -752,7 +752,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt7629_clk_infracfg) = {
 	.name = "mt7629-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_infracfg_compat,
@@ -762,7 +762,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_pericfg) = {
+U_BOOT_DRIVER(mt7629_clk_pericfg) = {
 	.name = "mt7629-clock-pericfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_pericfg_compat,
@@ -772,7 +772,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_ethsys) = {
+U_BOOT_DRIVER(mt7629_clk_ethsys) = {
 	.name = "mt7629-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_ethsys_compat,
@@ -782,7 +782,7 @@ U_BOOT_DRIVER(mtk_clk_ethsys) = {
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mtk_clk_sgmiisys) = {
+U_BOOT_DRIVER(mt7629_clk_sgmiisys) = {
 	.name = "mt7629-clock-sgmiisys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_sgmiisys_compat,
@@ -791,7 +791,7 @@ U_BOOT_DRIVER(mtk_clk_sgmiisys) = {
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mtk_clk_ssusbsys) = {
+U_BOOT_DRIVER(mt7629_clk_ssusbsys) = {
 	.name = "mt7629-clock-ssusbsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7629_ssusbsys_compat,

-- 
2.43.0

