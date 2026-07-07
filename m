Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD5BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 19:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2795684A29;
	Tue,  7 Jul 2026 21:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WIMH3mLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3070D84A0F; Tue,  7 Jul 2026 21:12:03 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7938849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 21:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-44865cf3010so2644828fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783451519; x=1784056319; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W4MISUeONMrXPwmnq71dwKm8qge7X8rPSWFLYVfVfPk=;
 b=WIMH3mLXluQmMcHNRXihUaugxKYcAPg6tjRI8N0eP7MK9bI2sy62Vu7cXu4fT9bDe/
 SjyFeCp7krzn0zK0fTt3ytYH5p1BEzPBqhdEWD0Y9rNLmVdMQ0tZGnBPWjCj/Cj5fnAE
 foGRyD+OmTmOoonKrjG9RPa1hrm5wus1W3sAT8VlR8ujnTMtgn3+0dENHIqUaixqgPpe
 1VIL7nvgUJAJht1N9BhPfyMqfhsgq+9sj03lTLzOOvX2kohVJ+ZPVFOq2O6GriBsd4td
 jzvQnBLYA7HoHE8WM+8ROJp+ZVOt6w9bYKWnRkiNnZJz1h/UYZmtzIDmv2qGROC7bucj
 HB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783451519; x=1784056319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W4MISUeONMrXPwmnq71dwKm8qge7X8rPSWFLYVfVfPk=;
 b=qCTq3VbLGg2Ie+/pq+QfOb+ieKHULOxjiL0nceslUdxqcjs03HmzUJGPrhhanI0WQA
 7h0GKu9FgHLrr+ubzvtfPjmHJd910qlb8+ilgcOAZ1EGHXvqwt/b1Q3rBv5f2cSgdQ/O
 vbE8ihH5PwYgWZ1pp2xht1wSFj6Y8D8Pd2S5yZX8MW1IAgDZo37+G1gRswC+nR4O+f+t
 RF0KFvgNJp2y9Z56+GcYwaavUTf4vE0BNs3F5cKIvwGbp64fbojDwTWUgZPyLeM2wwkr
 oIcOrNx6qskPXgApexZi5oqozBL+5pAxB/8RgOuNFgvHMp1Q1mxiZNUdigcFomj7k/Ve
 rpZA==
X-Gm-Message-State: AOJu0Yw1TvN8jsHLbUZvNi4FlXYP4w7f6mEHKpklg/tw3akH1LZCz9K6
 OlC9VTFNKIax4j31NJwfnncx6q/hNhPq4iOkuEHf9BVIwglVUcTrYMpN/hC3UZXaElQ=
X-Gm-Gg: AfdE7clAqxnLO3+xRi6GDn31QS+C2E52s719Zv1gX/XnJp/f3u3bteaiGDrMZwB6Qc+
 mFHyNS4GSeIVQ84IvwQpsDuPdMUka3c0rdP6M2dGi9hPbfY3hqwyDbCISPg/TcTrwORLltMiSFf
 uAiS6HzjJSau2OOlM1YctgCv6yOcE6oV/Lf6YySll8D2A8pCERAJ259t2SSyFybYzN+8/q5p8g7
 7VRQbvUce77B8dOxYKJh7Txy58aWVowyS/i3S9J2ME/XtQyfl0OqdY4NWveeXId9LPb4YDd5Ag4
 E9znD/lAI9KZzVkyKn1Ith1FIFm5EGpvBqSf/0EEggk1rYcU0fzIH31LWo3uIZXAdzqA1PJz3pf
 8sthtzP4C5FDtxVq1LL5OIeA3glIsQrf8eXY8pDsN5Im/o+nveZPQ04M9DoECdTpXxbEcJMXqIj
 BXkQGt8TL2uVd5mNqqAQ==
X-Received: by 2002:a05:6808:2f0d:b0:495:f79d:8bd5 with SMTP id
 5614622812f47-49fdc8726abmr4959039b6e.12.1783451519647; 
 Tue, 07 Jul 2026 12:11:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7649:dd46:9d68:b169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82489sm153732b6e.1.2026.07.07.12.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:11:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jul 2026 14:10:03 -0500
Subject: [PATCH 01/15] clk: mediatek: mt7622: unique driver names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mtk-clk-unique-driver-names-v1-1-283d9a55361e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2958; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=2lOCKD5N2VfgU6UKqOHirMxOcImefC9kKPKnIG8ySkk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTU8XVhyifzJexCZE6m4IgpICQAroDKtzO9JfP
 uxYx+8lmcqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak1PFxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AF/cH/RKE6DATTsB8bxPrI3L3snQFba9ItYmv49K+wjm
 aXpiGK5+AV6eMKIWNbyEQ7EIxndNWT38xfidaeMta9kJeOz7BSSIfUvtz76D13G1tG9TgxBDTq/
 yDOHIsaWY2iOOZWSDZ0y9Ub5sllx2gUgRPgdg6GU7c1ap58JbVe/vm5CXhYI8sP9z8ZcmCqUOqL
 viTBVi/3nOo73sVmTeA7Fmr1mfSJC3ffLbFCYfFsgIoW0+curSJ3V7YNAT00MOL8pCzT3DZvu2V
 R8D+nAztV8q/zNv7OsJYt86L7J1AHR57tlQk0k31urpJn6RZr1/iFiqnTnZpQ5XAbQLegQGF+RV
 A7uk=
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

Change driver names for MediaTek mt7622 clocks to be globally unique.
This will allow better build bot testing by allowing all clocks to be
compiled at the same time.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index afe1717bfc5..6b7e074758b 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -802,7 +802,7 @@ static const struct udevice_id mt7622_ssusbsys_compat[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(mtk_mcucfg) = {
+U_BOOT_DRIVER(mt7622_mcucfg) = {
 	.name = "mt7622-mcucfg",
 	.id = UCLASS_SYSCON,
 	.of_match = mt7622_mcucfg_compat,
@@ -810,7 +810,7 @@ U_BOOT_DRIVER(mtk_mcucfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
+U_BOOT_DRIVER(mt7622_clk_apmixedsys) = {
 	.name = "mt7622-clock-apmixedsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_apmixed_compat,
@@ -820,7 +820,7 @@ U_BOOT_DRIVER(mtk_clk_apmixedsys) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_topckgen) = {
+U_BOOT_DRIVER(mt7622_clk_topckgen) = {
 	.name = "mt7622-clock-topckgen",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_topckgen_compat,
@@ -830,7 +830,7 @@ U_BOOT_DRIVER(mtk_clk_topckgen) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_infracfg) = {
+U_BOOT_DRIVER(mt7622_clk_infracfg) = {
 	.name = "mt7622-clock-infracfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_infracfg_compat,
@@ -840,7 +840,7 @@ U_BOOT_DRIVER(mtk_clk_infracfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_pericfg) = {
+U_BOOT_DRIVER(mt7622_clk_pericfg) = {
 	.name = "mt7622-clock-pericfg",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_pericfg_compat,
@@ -850,7 +850,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
-U_BOOT_DRIVER(mtk_clk_pciesys) = {
+U_BOOT_DRIVER(mt7622_clk_pciesys) = {
 	.name = "mt7622-clock-pciesys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_pciesys_compat,
@@ -860,7 +860,7 @@ U_BOOT_DRIVER(mtk_clk_pciesys) = {
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mtk_clk_ethsys) = {
+U_BOOT_DRIVER(mt7622_clk_ethsys) = {
 	.name = "mt7622-clock-ethsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_ethsys_compat,
@@ -870,7 +870,7 @@ U_BOOT_DRIVER(mtk_clk_ethsys) = {
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mtk_clk_sgmiisys) = {
+U_BOOT_DRIVER(mt7622_clk_sgmiisys) = {
 	.name = "mt7622-clock-sgmiisys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_sgmiisys_compat,
@@ -879,7 +879,7 @@ U_BOOT_DRIVER(mtk_clk_sgmiisys) = {
 	.ops = &mtk_clk_gate_ops,
 };
 
-U_BOOT_DRIVER(mtk_clk_ssusbsys) = {
+U_BOOT_DRIVER(mt7622_clk_ssusbsys) = {
 	.name = "mt7622-clock-ssusbsys",
 	.id = UCLASS_CLK,
 	.of_match = mt7622_ssusbsys_compat,

-- 
2.43.0

