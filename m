Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0348DD10F32
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 12:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249B6841E2;
	Wed, 26 Nov 2025 13:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="GfIdbLcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BC383FF4; Wed, 26 Nov 2025 13:17:41 +0100 (CET)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8088409C
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 13:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1764159458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8aXFaUKIvMuOO1Dwwvmh1aNLKqrD3RskAzRCdE1C4o=;
 b=GfIdbLcVZZbDozQytYj+w0tsQXKQkqMU7PTu9c2m1uLwhec40nzeP8fpf3c8rlCwv5u/UE
 P0Eo2duMbTSabSupsDw30/QQE5VALL1im17QL2OtB/7KApV8d9C7IJYZ20Fj7V4R8H1Jrn
 QcEqoOHKtDgjnwh2NnzY1bunbY0vDDtjzyldzKA721BGIbZ64qmk1/aMdPDMJvCm9soHeC
 J8kS8Kh0zCjccja1N76pBixyGX6gYGG8D3PLgyWIo7DzkU546mYSRlPnV3Xz4NkceckNTv
 CYYml3gYgmdtz+qrEaeiDZW+BTDx1C83voPWsR2Fh1lNHBYF0vhnk2xl2yQcIg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:08 +0000
Subject: [PATCH v5 06/10] arm: dts: meson: add meson-gxbb-u-boot.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-spl-gx-v5-6-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4134;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=vi4TTr1wv1tNC9Hsm0/7a1YhPJqvY3kp8HVjOfiWWUg=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/Yq+o3AZn+63Z0p4s1Aerq1cl6qJdwx5FOU
 F2sM9j5RPaJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv2AAKCRCEr8vQ14ma
 A60UD/9+eTtf3TPczI9Itg19R08WKWGYUIPLAPHSu9b8VPj+E09NylvkNlFVV/s1r/ndlP5WWxy
 n0GklwdpnYtXgSpe2HqNUeKlxO+tst81pOiS6wlaPhHfrK/P7UkUoX3OKYnNBB91UUwLxlvqZ4b
 LQl855SnbJHPa40ts7CU685WtaXpEekIjFv9g3gNzAyz4/pyRJsw0YO/M/lTRsbmBsdATHRvzHm
 6Q8TaZjjaS7k+EuvjKejsKm5RqoN9hNFJly7GxD0dZVj0sfb6MzrLxDIlRetZ+XwdLsP5ctfgB2
 r/pu8OTaP2mjeeqCOy04w3vK3IfQSAjiTwCFGmHMSiZPT9YTK4Ml8dMP4HGUCaZzj1AC3vIq8YX
 5XlA+YyqyWhKOs37Up8xt/FdfQ8ogA/PpX1eH9DmRdORAnPIaYgzlvFVRi0WjCzZoKuM4uQzqYH
 wt6Fsq1mkg2aK9lxN/sS+uuD0lINVXIV2YaXICFBp3bnZNXtuNm3g4LXdn71kGD9D75Re/TBkrj
 G8/uddIPv08k+CfjleXpPtd1hCYOw3oO2MUqo6WqNYJc38Ep1HRB9uId/D3yF8GV0Hp440ci5IC
 LRbiMNwRLanovgjRH80D3bY5oZwTxR8WxueVDcXVZTJHNMvwfYue3mq1IF7pTLbJhcAmUNN5lcK
 oQ53Gb+EwNw0VHg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Add a common GXBB DTSI, similar to the meson-gxl-u-boot.dtsi file,
which GXBB devicetrees can include.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi     | 2 +-
 arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi   | 2 +-
 arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi    | 2 +-
 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi        | 2 +-
 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi        | 2 +-
 arch/arm/dts/meson-gxbb-u-boot.dtsi             | 7 +++++++
 arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi   | 2 +-
 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi | 2 +-
 8 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi b/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
index 191c5192c68..4a027b9022b 100644
--- a/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxbb-u-boot.dtsi"
 
 &ethmac {
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
diff --git a/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
index 2a245bbe7f2..53d5c0113fc 100644
--- a/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxbb-u-boot.dtsi"
 
 &ethmac {
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
diff --git a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
index 5a2be8171e1..1bd000eaa86 100644
--- a/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxbb-u-boot.dtsi"
 
 / {
 	smbios {
diff --git a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
index c35158d7e9e..1bef64dc01d 100644
--- a/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxbb-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
index c35158d7e9e..1bef64dc01d 100644
--- a/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
@@ -4,4 +4,4 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxbb-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxbb-u-boot.dtsi b/arch/arm/dts/meson-gxbb-u-boot.dtsi
new file mode 100644
index 00000000000..c35158d7e9e
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
index 3743053eb9c..cd2e9b5099e 100644
--- a/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxbb-u-boot.dtsi"
 
 &ethmac {
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;
diff --git a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
index 3743053eb9c..cd2e9b5099e 100644
--- a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
+++ b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
@@ -4,7 +4,7 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include "meson-gx-u-boot.dtsi"
+#include "meson-gxbb-u-boot.dtsi"
 
 &ethmac {
 	snps,reset-gpio = <&gpio GPIOZ_14 0>;

-- 
2.51.2

