Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EA8C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 11:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D0C82E8C;
	Sun, 29 Jun 2025 13:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+4eUtZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E0782F5D; Sun, 29 Jun 2025 13:02:25 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D5082ED0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-55350d0eedeso3730803e87.2
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194940; x=1751799740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJv5qcPIbH+xZkraxjKBF9oHCVLp2il1XJVD6lOeQuE=;
 b=e+4eUtZ0sg2qySMEros7B2EI8Y3YmM1Rx/MOliXpC6CqyLbDg/lIRx244RMHXQMtM6
 0bfklObuKRjV3jfrj4fqexYLC2dfcbdpubaP/ZizCWK0U3SSgorNFOCjgmIFvnDm20lC
 cUYbKSqgjKi6j4Qt7IqHFqYf9CqCANjLYC7npoazAhdY9GxcIVsMffQ0rPUzPtlO9+am
 U/poE7ES9RRmeQfYGh340oDY3BGcIf507skQm17pMTHztZKi22o3LnF/ilwj01qAJhUy
 BEcjm3c7zOlRwfGN5i4KA4FrSjO1MiDZ7MElKgH1j1HKOMKqR5FeEEELGMTHnwXcn3nq
 Fbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194940; x=1751799740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJv5qcPIbH+xZkraxjKBF9oHCVLp2il1XJVD6lOeQuE=;
 b=GbvNYUXTfIZ+EwoodVf59K60n+CGdsvbzYmLDxOndT6pf+EUOzwAquhwozyubgxPqG
 r3cy2IHHfm9d0V5gjKuZ6bxGbeRDKyaD3fLFOiDo3P/MS6Ntt4yJli3k6TZfPL016w2+
 EKVMmhtz1MgZhJ2TXXZlV0bzMVbn/2aGrwNWNXAOrOz5SKeKOwLygwJGHEgE8GXYFMpn
 WdTHadUbRKAte6Ju660xUIpnPLfDyRoi7slozOdgtnaqWUXHM1dXCurXOyr281mI5/oY
 BNCzsooCivOv9N9jbeArUwX/E9bWMHdwv6ubQEasWqOUMEqqkG3Bhuq+ZtYjgeszcrYU
 moEw==
X-Gm-Message-State: AOJu0YyMlzIn0cT96URmgm8JkW/LgV4+B8eL6D2wsmYls/1yp/nPbHF8
 urBIsBiMJndiP1hGAw9wbEAKGPomaEkapj4urIj+rYvssC+mEWwQdKFS
X-Gm-Gg: ASbGncvN8sc0F+/gSw6bmAJca2kx8AvykRg1Gi09duVVHky9mWwNR6r+6eOwwsL2DrA
 vbYR/oHNBvG9tLQk5N1dVwZxcgDdaulkUMXAFeyS9MQgjIsL22bb0p7pwpaqLh/FjD31Cm1sg1R
 Bt4azLjZqfdkKo9OiZMjjp6eCG+21XmvdpNbxcSwlZGRF0ZqYv0zYY3XMFDfnpvp1PAVUU0ex6e
 hb0d448Up+Yp+M7IYYtOolvIs0MuttiA2myh5dFjdRVt2ArYdo8mhFiNkHYtfM2NambHG9NLx5J
 gGPYTjGZOPRxqc6acvhqlXmONCL6VQjBrSEjhOzCKmIng3dkNRkcBQ==
X-Google-Smtp-Source: AGHT+IGi64M2axqBiFxn/QBpmx83dqd0Gfu57e5tKcQYYZBLsUFPwSFrBcSWB5KUrX4q0/vwaSmJvw==
X-Received: by 2002:a05:6512:e96:b0:553:2874:8ef5 with SMTP id
 2adb3069b0e04-5550b813f17mr3403124e87.16.1751194940324; 
 Sun, 29 Jun 2025 04:02:20 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24028esm1090621e87.19.2025.06.29.04.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 04:02:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/6] ARM: tegra: Enable BSEV for devices that use
 CMD_EBTUPDATE
Date: Sun, 29 Jun 2025 14:02:02 +0300
Message-ID: <20250629110203.25086-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629110203.25086-1-clamor95@gmail.com>
References: <20250629110203.25086-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Ion Agorria <ion@agorria.com>

Enable BSEV for devices that support u-boot self-upgrading feature.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 arch/arm/dts/tegra20-acer-a500-picasso.dts      | 4 ++++
 arch/arm/dts/tegra20-asus-transformer.dtsi      | 4 ++++
 arch/arm/dts/tegra20-lg-star.dts                | 4 ++++
 arch/arm/dts/tegra20-motorola-mot.dtsi          | 4 ++++
 arch/arm/dts/tegra30-asus-grouper-common.dtsi   | 4 ++++
 arch/arm/dts/tegra30-asus-p1801-t.dts           | 4 ++++
 arch/arm/dts/tegra30-asus-tf600t.dts            | 4 ++++
 arch/arm/dts/tegra30-asus-transformer.dtsi      | 4 ++++
 arch/arm/dts/tegra30-htc-endeavoru.dts          | 4 ++++
 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts | 4 ++++
 arch/arm/dts/tegra30-lg-x3.dtsi                 | 4 ++++
 arch/arm/dts/tegra30-ouya.dts                   | 4 ++++
 arch/arm/dts/tegra30-wexler-qc750.dts           | 4 ++++
 13 files changed, 52 insertions(+)

diff --git a/arch/arm/dts/tegra20-acer-a500-picasso.dts b/arch/arm/dts/tegra20-acer-a500-picasso.dts
index 0c301483180..4afde766330 100644
--- a/arch/arm/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/dts/tegra20-acer-a500-picasso.dts
@@ -40,6 +40,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/tegra20-asus-transformer.dtsi
index 49efabbfd92..61b1cea6e90 100644
--- a/arch/arm/dts/tegra20-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
@@ -36,6 +36,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra20-lg-star.dts b/arch/arm/dts/tegra20-lg-star.dts
index 3045bc3135f..083598b1b92 100644
--- a/arch/arm/dts/tegra20-lg-star.dts
+++ b/arch/arm/dts/tegra20-lg-star.dts
@@ -46,6 +46,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra20-motorola-mot.dtsi b/arch/arm/dts/tegra20-motorola-mot.dtsi
index f00707c2859..db2cce1cc0d 100644
--- a/arch/arm/dts/tegra20-motorola-mot.dtsi
+++ b/arch/arm/dts/tegra20-motorola-mot.dtsi
@@ -62,6 +62,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000014 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-asus-grouper-common.dtsi b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
index d437ddc4dce..ddacdbb85c8 100644
--- a/arch/arm/dts/tegra30-asus-grouper-common.dtsi
+++ b/arch/arm/dts/tegra30-asus-grouper-common.dtsi
@@ -44,6 +44,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-asus-p1801-t.dts b/arch/arm/dts/tegra30-asus-p1801-t.dts
index 58f1499cb92..31cbef1b93c 100644
--- a/arch/arm/dts/tegra30-asus-p1801-t.dts
+++ b/arch/arm/dts/tegra30-asus-p1801-t.dts
@@ -50,6 +50,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-asus-tf600t.dts b/arch/arm/dts/tegra30-asus-tf600t.dts
index 1b5729c65f4..5135b8c666c 100644
--- a/arch/arm/dts/tegra30-asus-tf600t.dts
+++ b/arch/arm/dts/tegra30-asus-tf600t.dts
@@ -53,6 +53,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-asus-transformer.dtsi b/arch/arm/dts/tegra30-asus-transformer.dtsi
index 032fb3d00ac..47a44fbc9dd 100644
--- a/arch/arm/dts/tegra30-asus-transformer.dtsi
+++ b/arch/arm/dts/tegra30-asus-transformer.dtsi
@@ -37,6 +37,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index db8ac457880..79f423bd22a 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -60,6 +60,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
index 876fac7b661..53f42089d30 100644
--- a/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
+++ b/arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts
@@ -43,6 +43,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-lg-x3.dtsi b/arch/arm/dts/tegra30-lg-x3.dtsi
index 40b0ee07787..09c5d04a225 100644
--- a/arch/arm/dts/tegra30-lg-x3.dtsi
+++ b/arch/arm/dts/tegra30-lg-x3.dtsi
@@ -42,6 +42,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-ouya.dts b/arch/arm/dts/tegra30-ouya.dts
index 04453eb2432..e6b2824d783 100644
--- a/arch/arm/dts/tegra30-ouya.dts
+++ b/arch/arm/dts/tegra30-ouya.dts
@@ -56,6 +56,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
diff --git a/arch/arm/dts/tegra30-wexler-qc750.dts b/arch/arm/dts/tegra30-wexler-qc750.dts
index b376b91a7fa..ededbf579fd 100644
--- a/arch/arm/dts/tegra30-wexler-qc750.dts
+++ b/arch/arm/dts/tegra30-wexler-qc750.dts
@@ -44,6 +44,10 @@
 		};
 	};
 
+	bsev@6001b000 {
+		status = "okay";
+	};
+
 	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
-- 
2.48.1

