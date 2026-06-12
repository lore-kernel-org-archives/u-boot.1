Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A525CD98C7
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 00:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC8B838BB;
	Fri, 12 Jun 2026 02:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="LZkBeDEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A91F84664; Fri, 12 Jun 2026 02:12:33 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278458056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 02:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6d2f297f4so285498a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 17:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781223150; x=1781827950; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IiJzu90wx2ESwr1KZ1LYAiDab/X7j/f+TXxlYzK9XFg=;
 b=LZkBeDEMQgseS7Rv/GzaEH+eUXfPhKhcm3N04PYB2NPtqCsuwCZ2U2ejtBW30S74To
 M0UvGt8f3hOeirbiWgExwaGeXocVSVfs7S3UyHGje1eje8ssI4+wl468cjYb94WfEXr/
 RcSb7eUSHh5a1wdI5u7+CphebvLHWAbWb03nP+1xI6fZe0RVM+viigNMeB96XEFc/ILd
 hjTBn+qRW+SfTExyXrBPr7m5G8PFkSxdF8PD+D0O/URptQlBAP1VCw4dtFMxUXk7P2+h
 k0dGuMK5wsmqa96OrRXH3jjH+g9Z5PITlDZmYqh8d+HF3Ri9YTBIkNOe09AGI5ruRGjt
 5sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781223150; x=1781827950;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IiJzu90wx2ESwr1KZ1LYAiDab/X7j/f+TXxlYzK9XFg=;
 b=V+UVLQgk+Y20dlo7ZoNXIUuLc3Ua8If4TXHkJ0YTMqGm2FUi+GYOo7qhZVUcokB1dk
 5GnRJAGDDasDFwHd7YWj7rNSHIFs4cbHq6Hs6YvYT/1zpkih63LxsbxeShUOkHnkKv/u
 qh7Y/J4+ihiSpPDIut/8WMhottWMuZ2+lC+Lqv8Mgw9qZnYHh3h5rM4M6XEgLZ1Fx0ro
 5nL/SZ/2NAUcXRL+rPROg22CgEY8BHZScbAlNUZYoEW/FcwgXIFbPzfHd/Pm1mxzg9t5
 +zTWlaomkPyslYRY1ewPMU5fNuSMK3puyvGrPWzniBq8gOvzJA5RtPIF3qI+zr2QOzGI
 QAZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1/v7MD8X2nKUjdK66+is8mJDuTLa+3jq9F78HIjP4aztxIIyaAewc3K5VmtzCtwVVW73G1IA=@lists.denx.de
X-Gm-Message-State: AOJu0YxaA7s9NYaFtoHe5WsBwxhMhh84uVOzA2uXvYIUOFNo+0XiYh9C
 yPLAHQdnnT+gWpTC+jhZuSI9SkPNSqU1IdHKlFKy6NEvkdYcn74P5f+I+7Gx87ETpZM=
X-Gm-Gg: Acq92OFOj2KpE8nHZ82zBjSqLdOLIxzXRHSLCYejxx4fQt2MjEsEAb6r0fxgpedIr0X
 OJOeHjgtbzsKdDdv+mh8ChGT0qJ1qPPpO9eo7HLyckCUnJKR6X9O6wmV4q8lNCWKarWJ0VtKrNm
 1/T7q7NIzczxKB2bBtbrhvNtP0gxb+fRbrZIewcJ22Y04hH3lu8o61+NQICfV7rHxqpBGAAqg8G
 2pW7+HuY3bnXBRM4kG93ZP9c3hmUS0Y/HsxL6TB16weNBY087OIMumh5GqF1oHNdE1v5nAP5ePw
 K3pTrxuydo5mMWwrjRl4Jn5nU50aorzxkiPlmP28ylX4IL4K+6xFWyJGDbYqONZrJE7VWzCaxWN
 k7ZE2mFREQPXxDwmC4XXltYVqdnkouMYnWYfv7GFRooeqdPJWrW/1rwFNciCT0uTcUus81trO3k
 33ufp5ai3mYAj5CzJd5KbtJmfn0Vd3vV8O/UlYOQ==
X-Received: by 2002:a05:6830:2e03:b0:7e6:f7fb:9682 with SMTP id
 46e09a7af769-7e7846efe32mr332701a34.2.1781223149792; 
 Thu, 11 Jun 2026 17:12:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e781740de4sm644878a34.23.2026.06.11.17.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 17:12:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 19:12:20 -0500
Subject: [PATCH] arm64: dts: mediatek: mt6359: give regulators unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mtk-pick-dt-mt6359-unique-names-v1-1-601546be1210@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTsJpWkjXsW4KO2gI6FipzUmh
 LtTdPe+zf9WEEpMApdmhUQfFn7FCnVqwD9cvBNyqIau7WxrlcI5T7iwnzDkuq02PZbI70IY3Uy
 CXp9N78ZglB6gVpZEI39/D9fb31KGJ/l8ZGHbdmA+cJWDAAAA
X-Change-ID: 20260611-mtk-pick-dt-mt6359-unique-names-c3859afd513b
To: Sumit Garg <sumit.garg@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KZTkyLqoSuam9jaV9wbtbo4lt1U+/xj9//t8YCc8Mks=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqK07lipUdSkbg2AnRBjVvmX6fhr8CwAbobCM8q
 d/5irPvpLeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaitO5RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJ0oH/0y4IdTWI3DBjlqXq7XXof7k3nHoVf3BvfItMHm
 Yy+a255LblG7RUFY8ifJ+d/3wYF5YkZMlEMFZ/nT99wRckRHxReYRFPCluxroOCesJr0mOwVdSt
 BavBt4XnVpAZimptzofuIe+Ww5h/Jo+nz3Dapw0LA/wTV0jbv65uy++Jqkp0TeprQIDtD70fjvG
 O0zxX5Yddj1Hfq6CnLDV4KYrOuaAkscOrxXpVpmjgBUcV0sjjEnLAIPJSYSb5SgTyjRegCvK6N9
 rGcNSqt+DwaWb3ZJrOOU86brWm0TJe78U9vXpYTmEOHyrQrMeND3jOYCgUVS3w7hARSa47z559I
 ngKs=
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

Change the regulator-name properties to be unique for all regulators.
U-Boot cannot handle duplicate names.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ upstream commit: d91639d0ab3223b61c00442021dc639c9ddc2b76 ]

(cherry picked from commit 22ce1d7d45a696128b8ad2cb9fbc4f2073bcb4f6)

---
This is one we've been waiting for since we added the MT6359 PMIC
support to U-Boot recently.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 dts/upstream/src/arm64/mediatek/mt6359.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/mediatek/mt6359.dtsi b/dts/upstream/src/arm64/mediatek/mt6359.dtsi
index 467d8a4c2aa..45ad69ee49e 100644
--- a/dts/upstream/src/arm64/mediatek/mt6359.dtsi
+++ b/dts/upstream/src/arm64/mediatek/mt6359.dtsi
@@ -205,7 +205,7 @@
 				regulator-max-microvolt = <1700000>;
 			};
 			mt6359_vrfck_1_ldo_reg: ldo_vrfck_1 {
-				regulator-name = "vrfck";
+				regulator-name = "vrfck_1";
 				regulator-min-microvolt = <1240000>;
 				regulator-max-microvolt = <1600000>;
 			};
@@ -227,7 +227,7 @@
 				regulator-max-microvolt = <3300000>;
 			};
 			mt6359_vemc_1_ldo_reg: ldo_vemc_1 {
-				regulator-name = "vemc";
+				regulator-name = "vemc_1";
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <3300000>;
 			};

---
base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
change-id: 20260611-mtk-pick-dt-mt6359-unique-names-c3859afd513b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

