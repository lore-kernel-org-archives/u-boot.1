Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE57C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 12:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E02805C8;
	Sat, 29 Mar 2025 13:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="RZFWLGHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06EAD81951; Sat, 29 Mar 2025 13:48:15 +0100 (CET)
Received: from mail.per1cycle.org (mail.per1cycle.org [188.245.231.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3008059D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 13:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7DF9A3FAF8; Sat, 29 Mar 2025 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1743252489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJzxQCqJU6MBD0w+BWJXcms0XH9yC+AOulprQAesu6c=;
 b=RZFWLGHc90PTIwjqgW3G12mG8KKe6t8SQ3mjUx+3oaDGrg8M/KekreByNAWiF3PGCevVms
 cUzpygKjVfMd9EDbS/jcLp1APE/2La2/+Bhj+sXQy1V4HH3PYV026lGOyKd8q74avXg/n8
 PUR/mUo7Ikd7yZnL1oAqND7R2xDVv19APpRrAFJZn++hkwrj1UaPWL9WwT+6+E9j/Htt/g
 gjRKqckVbCT8OixexyUpPzfROZYUR809AcgivxBMkTXlob6NRDhVyfznU9uyqCSk916EVz
 WnEj4wl80jXxsRfBBlcHDlY00wDziMv9e3Ndw6k9+RDRzNaT8aCYReQ/Hf3h1Q==
From: Huan Zhou <me@per1cycle.org>
Date: Sat, 29 Mar 2025 20:47:59 +0800
Subject: [PATCH 1/2] riscv: dts: k1: add pinctrl property in dts.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-pinctrl-k1-v1-1-3083d7057989@per1cycle.org>
References: <20250329-pinctrl-k1-v1-0-3083d7057989@per1cycle.org>
In-Reply-To: <20250329-pinctrl-k1-v1-0-3083d7057989@per1cycle.org>
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>, Huan Zhou <pericycle.cc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743252484; l=2081;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=bEAuLnpu5S1BO39Kqkim+uMbKSfPHs3/8y2vKQ8u7pA=;
 b=++jmFPVC84fvwxOAXU1rqyB+6JiLQvcKKwjZBvTtmndKoQOP9HES+iOnNzPvPo36oRKU0O/bo
 aE6vhBXtDjtC2DMGG4CTgB1Naq+xpw4C/9K5O+hT0l0VbFP+JfBedde
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Add pinctrl node in device tree and update
in bananapi f3 dts.

Signed-off-by: Huan Zhou <me@per1cycle.org>
---
 arch/riscv/dts/k1-bananapi-f3.dts |  3 +++
 arch/riscv/dts/k1-pinctrl.dtsi    | 19 +++++++++++++++++++
 arch/riscv/dts/k1.dtsi            |  8 +++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1-bananapi-f3.dts
index d2486f70906143ad1f2bde753f12dea5bab2e5ab..6b5b83bcdb9ae4553c5fb63a7a9684f5d47a456e 100644
--- a/arch/riscv/dts/k1-bananapi-f3.dts
+++ b/arch/riscv/dts/k1-bananapi-f3.dts
@@ -5,6 +5,7 @@
 
 #include "k1.dtsi"
 #include "binman.dtsi"
+#include "k1-pinctrl.dtsi"
 
 / {
 	model = "Banana Pi BPI-F3";
@@ -21,5 +22,7 @@
 };
 
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
diff --git a/arch/riscv/dts/k1-pinctrl.dtsi b/arch/riscv/dts/k1-pinctrl.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..14e7096fbcfdc88a9f9989993fdd2aca6de7462e
--- /dev/null
+++ b/arch/riscv/dts/k1-pinctrl.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 Spacemit Inc.
+ * Copyright (C) 2025 Yixun Lan <dlan@gentoo.org>
+ */
+
+#define K1_PADCONF(pin, func) (((pin) << 16) | (func))
+
+&pinctrl {
+	uart0_2_cfg: uart0-2-cfg {
+		uart0-2-pins {
+			pinmux = <K1_PADCONF(68, 2)>,
+				 <K1_PADCONF(69, 2)>;
+
+			bias-pull-up = <0>;
+			drive-strength = <32>;
+		};
+	};
+};
diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index 514be453dbaf6713cdf4ad5a5d653488297ebb83..4626bdd48b2a5dfc3a29ffcdbcec608b4a2573ac 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -455,5 +455,11 @@
 			reg-io-width = <4>;
 			status = "reserved"; /* for TEE usage */
 		};
+
+		pinctrl: pinctrl@d401e000 {
+			compatible = "spacemit,k1-pinctrl", "pinctrl-single";
+			reg = <0x0 0xd401e000 0x0 0x400>;
+			pinctrl-single,register-width = <32>;
+		};
 	};
-};
\ No newline at end of file
+};

-- 
2.39.5

