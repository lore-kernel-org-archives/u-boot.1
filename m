Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE4CC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572B880F67;
	Fri, 21 Feb 2025 10:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kvKX0bwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F7E80FAC; Fri, 21 Feb 2025 10:59:21 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F8180F92
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A3CA3FAA5
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740131955;
 bh=f9YVl0gDTaFja+6gQ8WW2kZhWrTn2wxQMuDzekvfL+8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kvKX0bwrcgTUkX3Xrx+MKfHfH04B6laQWztCgwZvVHSSXjgTDOBvb+YW2Pw94Bt4h
 Mak2KiFK2yEukUDz7A82GPdrDHvBnpek+47FaGLdzHXusdmsyZNCYF1LvvNZojHNML
 NrNgnqQX2uYwdmf6+pRemDkIgWywQ92C0/TZBrTs5JvvWe0ki1HTnmTqJ/J6lOK5ID
 Bb9oUTQRwpJ+3YC4JBQ8mP9jC+NRtXzJhg+GdNL18nx9aTQPyVc73Zhoyql8+AqnJ+
 DtBqXjxkeOXA5a76iQ8mtEtOJkiYWHO0GdqZ51F6PbuFYF6j6K6olLNGwNAHn36Lsy
 sGBUicrSOKrDw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4398e841963so21358745e9.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 01:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740131947; x=1740736747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9YVl0gDTaFja+6gQ8WW2kZhWrTn2wxQMuDzekvfL+8=;
 b=I01FbFQy4XgLqFP9Jkqc0ZWxhRywR2qerGiQGbRvwUOT+zPEtVVJh3d4DjYq8oUuL8
 cTtEI7dAniHPOSB+yxkqHjC4TjlAdk468jgTjuN+66So1P8az5y7NugembQDj3tBX+Eo
 uZ1GssTIlRQE8wBo7oonQBoauSRv3Yy3l9EQxluVRcIY+Jw/vFHup31UyNfP/7z7QoCc
 brY8RdWKU/mIn5AuWT+hwsd5DxkQvBVipBzZrLjGIl45jc4FhNnjA7symxNYznRthjuk
 ijHZmpOn3n9pEsU8u46Z7Q6SgMy8Lf/si52b50xIC2piqm6AQzID/Em/m/JVfqR9R/Kx
 xgew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfVWcXSRvs4Q4XADj+B/xQs73sdzBpCZGRvTz+G1e6tjLK8d8ExP2pCTEDUTY4MqyNZo47F7c=@lists.denx.de
X-Gm-Message-State: AOJu0YyPsiKjpRFiZyAILDoHm+hPrMKIg8+4zMr41aTxeZxKMPtXmDvm
 vBf8lhhpXnNO0FA294VhQvpwTKzoucnYS4+Z1194FnNRVNBpgJu3zSoiHbmvMTj3fr+jp9kFE2k
 66ZntmbAiCjSJi/GtF1Xlee6rc+Zyu90nXc11DaRf3SIrzVAJf1xpTGaQzckLP9vrPdg=
X-Gm-Gg: ASbGncuGCCUyi6h79tRBdO3ehSQYiGAIJTJhGgtVSLnWGSqwauB5LbWyYGDUJfrPZxk
 SHGvPrhGbjQ+lrRS0YMaV/kJR27nZKsLTXBXE3YQ/ZUnl0bGxYeYpY0/Ga8OIvOvEC25CPMWTLI
 VQHX2/4QRpzEB+jInz5aHA8LMHxqa/KWHmqmfqN9t8R1FBKbe8CnqMSw77NAAl9EuEmOcRZegW3
 rBmGdVXPYjztn8DkMZsB5oBFibpjpKqvXjBLOXXh/rMXfRQ0eRgxpoUF0wiKJcW59ZCn2sK4wRW
 fDAjMNXdYaAMXgGXjFDgq97H9+GD+Xcxrp09Bd3mL3UE1MKfQSp6fjqrFrzFVatfbiF46SDBmsd
 RpJTLnRcI3oD/2XXmhQ==
X-Received: by 2002:a5d:5f8f:0:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-38f70799c53mr1881128f8f.15.1740131947316; 
 Fri, 21 Feb 2025 01:59:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEXnyeBC2XRluOjjNZGbm8HqNh49knMbx+FxwV4r5xgdlDVaI+fD1d4LXCi16NS01c3wfoQw==
X-Received: by 2002:a5d:5f8f:0:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-38f70799c53mr1881090f8f.15.1740131946900; 
 Fri, 21 Feb 2025 01:59:06 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm3287961f8f.27.2025.02.21.01.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 01:59:06 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/4] riscv: dts: starfive: remove duplicate itb entries
Date: Fri, 21 Feb 2025 10:58:56 +0100
Message-ID: <20250221095856.36530-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
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

As binman already creates nodes based on CONFIG_OF_LIST we don't need to
add extra nodes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org> # StarFIve VisionFive 2
---
v3:
	no change
v2:
	no change
---
 .../dts/starfive-visionfive2-binman.dtsi      | 76 -------------------
 1 file changed, 76 deletions(-)

diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
index 4cce001e80d..05787bdb92d 100644
--- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
+++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
@@ -13,82 +13,6 @@
 };
 
 &binman {
-	itb {
-		fit {
-			images {
-				fdt-jh7110-milkv-mars {
-					description = "jh7110-milkv-mars";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
-					};
-				};
-
-				fdt-jh7110-pine64-star64 {
-					description = "jh7110-pine64-star64";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
-					};
-				};
-
-				fdt-jh7110-starfive-visionfive-2-v1.2a {
-					description = "jh7110-starfive-visionfive-2-v1.2a";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
-					};
-				};
-
-				fdt-jh7110-starfive-visionfive-2-v1.3b {
-					description = "jh7110-starfive-visionfive-2-v1.3b";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
-					};
-				};
-			};
-
-			configurations {
-				conf-jh7110-milkv-mars {
-					description = "jh7110-milkv-mars";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-milkv-mars";
-				};
-
-				conf-jh7110-pine64-star64 {
-					description = "jh7110-pine64-star64";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-pine64-star64";
-				};
-
-				conf-jh7110-starfive-visionfive-2-v1.2a {
-					description = "jh7110-starfive-visionfive-2-v1.2a";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
-				};
-
-				conf-jh7110-starfive-visionfive-2-v1.3b {
-					description = "jh7110-starfive-visionfive-2-v1.3b";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
-				};
-			};
-		};
-	};
-
 	spl-img {
 		filename = "spl/u-boot-spl.bin.normal.out";
 
-- 
2.47.1

