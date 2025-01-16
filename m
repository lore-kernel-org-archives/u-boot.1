Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E28C02188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B6B8033D;
	Fri, 17 Jan 2025 00:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IyFdTM80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C869806FB; Fri, 17 Jan 2025 00:10:48 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233A28022B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb939021bfso773658b6e.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737069045; x=1737673845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gj5QTNElvkNsiGzY19/EU2oMS3qXTdXdjTFL3+bOKro=;
 b=IyFdTM80w4R4TVUwgB5EBhnNBNbZ5siLBFYuBNL4Dx643+9UsWNpFOipd841nz7+Rn
 svTGweYxpKhuYAa6VkcQgjYX7DSPBhYbd6iu0v+0fm3o+b+CMRzrtJeX8Z/OcqzeOP/9
 qw7GHCSY+044TDiNHBesidpfcZEQJIQGmGCuTpPxncBHOwNV6whd2Yd1CgAte8DoLIPX
 zo/ZU1MrYgWzhUPodPXJcMoIL6M+Yr74dhKpepAPPUW78jUW+qgrFJl4PVA0IKElchLW
 gi4czv4OopKxXDp0YGCa2OfuJpiqVkM62zDikwQnM53ldyCL+W4F1QgQ/TGXlv1RnECQ
 j0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737069045; x=1737673845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gj5QTNElvkNsiGzY19/EU2oMS3qXTdXdjTFL3+bOKro=;
 b=c47P00ow/ojqJF/QXsIm5DmF87mZlsLjVY51sjLV1SN6W8lPtK7KegoQc727+z6qpQ
 D/xDlzxCNpvtQpycKQ7eFz12h9TT6Kq/ABeCW6G4Tfa1rFJVo410dR+qdcoM/dYQKD3n
 KCZwxFEd473+imWtTPZrzTq42EBlC3Kb1S8yzJMrpW2S+rNqBVUNzj6KG0q3kaZ70A6J
 VabzrSa85e9j8Nv3swsrAPZ1OSsils0DW6v/Px/LS9uEAUlvO5u37G64obsDGgJwwzCQ
 uqaSxbqy1oeRObGYsWJLb8Y0PHpnnGJhITTAQysk5PdAdk3E4J33Ga1N0bxaJ9Mj+DOJ
 dgvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTzmhwft2WDkIe6Ck0FwiKlFYlIBbvBZrcDepV2rTa2w7TIXPnJnXwdUj0m1P4kLM/huN3bRU=@lists.denx.de
X-Gm-Message-State: AOJu0YwBrpTynMXLLSTPzgueD0m785YGpjfN2lkeGkySmf9az0WU2UD/
 9AxOZcpQDtnGfUkOwx4ICiREXdLbjddFxzBJg/1fH1dEZ6xIfubt
X-Gm-Gg: ASbGncvB7EzwLpnhqI454bmCv7zITqRGl/jRho/aE+LEz2dyIh+TwNYIapOGN9WnvaX
 QIA4vPCvcRpzogDoTAspIX+3WzjkCnxiHIdtUkDs5i69i0BibJdr40Joh7JMTjoUO2HNDkE5kuV
 4t+n/9ZDetG/K1r+S0CkzmM6wV9zpUrGYZyttQheIbPHqy4eFOSZKYqmHyGcwxwOfk12yiN3OVe
 dQMYiOCyK49QskaH1srQbw7WbC5P6ReSvUnj+LWzP6z16hiyN36bYCw6KAa3nsh32Jl2NQ=
X-Google-Smtp-Source: AGHT+IG+d7zVQ4ssdAfTL+F8s6gZ++LxxGwVtefxvCasjVQMIp59VUnkLye+0DGnwlLiU2X0JGyW9w==
X-Received: by 2002:a05:6808:4e08:b0:3e5:f656:dd19 with SMTP id
 5614622812f47-3f19fc2aceemr382398b6e.19.1737069044652; 
 Thu, 16 Jan 2025 15:10:44 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b1a4:73e9:7e6a:ebcd])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f19da6eab9sm422175b6e.17.2025.01.16.15.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:10:43 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: uboot-imx@nxp.com, peng.fan@nxp.com, y.moog@phytec.de,
 u-boot@lists.denx.de, marex@denx.de, Fabio Estevam <festevam@denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8m: Guard binman nodes with CONFIG_OPTEE 
Date: Thu, 16 Jan 2025 20:10:32 -0300
Message-Id: <20250116231032.2312636-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Guard binman nodes with CONFIG_OPTEE to fix the following error
when building without optee support:

  BINMAN  .binman_stamp
Image 'image' has faked external blobs and is non-functional: tee.bin

Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Some images are invalid
make: *** [Makefile:1135: .binman_stamp] Error 103

Reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 2 ++
 arch/arm/dts/imx8mn-u-boot.dtsi | 2 ++
 arch/arm/dts/imx8mp-u-boot.dtsi | 2 ++
 arch/arm/dts/imx8mq-u-boot.dtsi | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index ecc2319279ea..f1cc3fd2532b 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -164,6 +164,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -178,6 +179,7 @@
 							optional;
 						};
 					};
+#endif
 
 					binman_fip: fip {
 						arch = "arm64";
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 4a4498b36b01..08a81ddc9cb2 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -240,6 +240,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -254,6 +255,7 @@
 							optional;
 						};
 					};
+#endif
 
 					binman_fip: fip {
 						arch = "arm64";
diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 9ede98a11e42..55be8e4f7cb0 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -185,6 +185,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -199,6 +200,7 @@
 							optional;
 						};
 					};
+#endif
 
 					@fdt-SEQ {
 						description = "NAME";
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 93e2ef27f7ce..cdeacbac108b 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -144,6 +144,7 @@
 					};
 #endif
 
+#ifdef CONFIG_OPTEE
 					tee: tee {
 						description = "OP-TEE";
 						type = "tee";
@@ -158,6 +159,7 @@
 							optional;
 						};
 					};
+#endif
 
 					fdt {
 						compression = "none";
-- 
2.34.1

