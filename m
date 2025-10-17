Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E0DCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2968391B;
	Fri, 17 Oct 2025 17:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="OaOg5Pt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDAF8386D; Fri, 17 Oct 2025 17:28:09 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 427C383852
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 10D3C2603D;
 Fri, 17 Oct 2025 17:28:07 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHyazC09FDoa; Fri, 17 Oct 2025 17:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714885; bh=pJvqTUpuNyyVssdiLzX9JakblWKsY507IuZacL5fqV4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OaOg5Pt7q0/bY3oag45zlg0LfmCglmw4Ffn/BBjfuDkzu5zlptFm1uS9ozeneORc4
 F96YYnK5xTH07Obag/lhUDJyi+jeETkutNEVTqjN8LRTbis04D4LG9IxBSo0FCpnmg
 MEHQK1pi7qLplthJWHiF2TvwqbUkhOAfn/58pcYUTO7pV4FdTJMOhRcX65ncPJx1k7
 hpwj0je/BG8Ol+AkQWehleyp3JPdHToi8wZNsVrKEckJRogE9xIoqjRaWLfI2RnfVB
 0/FG/E+4foGOmkt6v3cbj5Y+bncDKbD37sdK10SX4JvLP2onu7+PQOUHrnWfatvxfy
 LpQNHleOqyWRg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:57:41 +0530
Subject: [PATCH 2/2] pinctrl: exynos78x0: add proper support for exynos7870
 pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-pinctrl-exynos7870-v1-2-beaa92f95a0c@disroot.org>
References: <20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org>
In-Reply-To: <20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714868; l=3925;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=pJvqTUpuNyyVssdiLzX9JakblWKsY507IuZacL5fqV4=;
 b=XGjKvSz2z9EAllFGTpfepg2icwciQe8/2BObPC0kTdN+2NiOkIeZJUa7sjde6GD+nURtI0X7S
 Z38apQhrNQcD4RwFWzRjnx+84OxcnChgDv9Gw5+5s0vBFNnn52vE0Th
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

The pinctrl blocks for Exynos7870 and Exynos7880 are similar, however in
Exynos7870, the CCORE block is actually referred to as MIF. Since
ordering happens lexically, it isn't directly compatible with
samsung,exynos78x0-pinctrl.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos78x0.c | 59 +++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos78x0.c b/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
index cc01028add123765f9c652e4be46967a20800295..04e721738028dd5280c7ced6d3a55a803e722bd5 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos78x0.c
@@ -45,6 +45,11 @@ static const struct samsung_pin_bank_data exynos78x0_pin_banks2[] = {
 	EXYNOS_PIN_BANK(4, 0x040, "gpz2"),
 };
 
+/* pin banks of exynos78x0 pin-controller 3 (ESE) */
+static const struct samsung_pin_bank_data exynos78x0_pin_banks3[] = {
+	EXYNOS_PIN_BANK(5, 0x000, "gpc7"),
+};
+
 /* pin banks of exynos78x0 pin-controller 4 (FSYS) */
 static const struct samsung_pin_bank_data exynos78x0_pin_banks4[] = {
 	EXYNOS_PIN_BANK(3, 0x000, "gpr0"),
@@ -54,6 +59,11 @@ static const struct samsung_pin_bank_data exynos78x0_pin_banks4[] = {
 	EXYNOS_PIN_BANK(6, 0x080, "gpr4"),
 };
 
+/* pin banks of exynos78x0 pin-controller 5 (NFC) */
+static const struct samsung_pin_bank_data exynos78x0_pin_banks5[] = {
+	EXYNOS_PIN_BANK(4, 0x000, "gpc2"),
+};
+
 /* pin banks of exynos78x0 pin-controller 6 (TOP) */
 static const struct samsung_pin_bank_data exynos78x0_pin_banks6[] = {
 	EXYNOS_PIN_BANK(4, 0x000, "gpb0"),
@@ -77,6 +87,11 @@ static const struct samsung_pin_bank_data exynos78x0_pin_banks6[] = {
 	EXYNOS_PIN_BANK(5, 0x240, "gpf4"),
 };
 
+/* pin banks of exynos7870 pin-controller 7 (TOUCH) */
+static const struct samsung_pin_bank_data exynos78x0_pin_banks7[] = {
+	EXYNOS_PIN_BANK(3, 0x000, "gpc3"),
+};
+
 const struct samsung_pin_ctrl exynos78x0_pin_ctrl[] = {
 	{
 		/* pin-controller instance 0 Alive data */
@@ -102,9 +117,53 @@ const struct samsung_pin_ctrl exynos78x0_pin_ctrl[] = {
 	{/* list terminator */}
 };
 
+/*
+ * In Exynos7870, the CCORE block is named as MIF instead. As the
+ * pinctrl blocks are sorted in lexical order of their names, the
+ * order isn't the same as Exynos7880.
+ */
+const struct samsung_pin_ctrl exynos7870_pin_ctrl[] = {
+	{
+		/* pin-controller instance 0 Alive data */
+		.pin_banks	= exynos78x0_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks0),
+	}, {
+		/* pin-controller instance 1 DISPAUD data */
+		.pin_banks	= exynos78x0_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks2),
+	}, {
+		/* pin-controller instance 2 ESE data */
+		.pin_banks	= exynos78x0_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks3),
+	}, {
+		/* pin-controller instance 3 FSYS data */
+		.pin_banks	= exynos78x0_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks4),
+	}, {
+		/* pin-controller instance 4 MIF data */
+		.pin_banks	= exynos78x0_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks1),
+	}, {
+		/* pin-controller instance 5 NFC data */
+		.pin_banks	= exynos78x0_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks5),
+	}, {
+		/* pin-controller instance 6 TOP data */
+		.pin_banks	= exynos78x0_pin_banks6,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks6),
+	}, {
+		/* pin-controller instance 7 TOUCH data */
+		.pin_banks	= exynos78x0_pin_banks7,
+		.nr_banks	= ARRAY_SIZE(exynos78x0_pin_banks7),
+	},
+	{/* list terminator */}
+};
+
 static const struct udevice_id exynos78x0_pinctrl_ids[] = {
 	{ .compatible = "samsung,exynos78x0-pinctrl",
 		.data = (ulong)exynos78x0_pin_ctrl },
+	{ .compatible = "samsung,exynos7870-pinctrl",
+		.data = (ulong)exynos7870_pin_ctrl },
 	{ }
 };
 

-- 
2.51.0

