Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3504C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA12809A5;
	Sun,  9 Feb 2025 16:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fr+ucDBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADF0807D7; Sun,  9 Feb 2025 16:23:45 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66102807D7
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 829343F516
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739114622;
 bh=UoKgeRaX5jIcY4vTxCtYjY2KVOnzJwxxfgPBtWYcFGw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Fr+ucDBlZ2Zj/xqz1BXSmDnMv4Gl+NmjcNoaiW782KC8RHocWLyqKkXLmcWlqxhkN
 gXRapDZ3FT6SParOoyyS7asUQ8G8dtT/v1mr86gu+46Fod3MYsryg+tIb0VI2dVBxv
 WPCFD6UqkythYlh6DGKTUwnLDBFn9vhY5DIiy7OB4kuK0bRFrJaXbh3/N763WKQwoe
 F034VIB5a7QL5Uv3EsQ8hcWm/2MR+rE14sO19CtHhczuWPLbmrl83oBEkmeHSLPvjE
 MhXVJ1+gGDfkN7+vnJrR38sC48jPcwIkyRggYWdPnyPX/T9cYmbPn0QLxw9Gnwtjjm
 e/5/Mn0IEIeOw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43626224274so21268605e9.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 07:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739114620; x=1739719420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoKgeRaX5jIcY4vTxCtYjY2KVOnzJwxxfgPBtWYcFGw=;
 b=rm3/zb8noOba4dmCYaPstdloP0azNsauIassLDk9G3jneTNnStnqIQST8shamEkzs3
 U8WaPYlGOvAOFMG3D55H230x63xQy3fVe+HIMCxoEyu/K6p2zO1Lr0sVFxzzHEl2eYPq
 HbOsT7+5PUyE/zlaQOyQ+Gv2TZjMJaHvW2LprSrf/lQ/W0PcZwx/3FwciTaMQTw0HFCO
 UNnnTb7GooN6zkxHpqTvOKo10DmS4W4BWlycHYYTpcG7j8kqM5GP90/4HUJIFPRE07FC
 juZHw9jWbLX0AKv3E8WDB6ARNd68AAFQYtGbcLSggGKglf9yhDPeO1uhtGREiO4zb+hS
 WnfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ33oJvHrW7hsM5USD63kO6axkGg2QKp3gJfhPIVjnvHBfIBIhsYxFaq1JVVBJgUxlqCdl1oI=@lists.denx.de
X-Gm-Message-State: AOJu0YwkLhgVmNvI8sqMYcaF4WgaT+UQ+r/pHwW8UqawJS60/Pf9NaMV
 RqcxXURu4oPwfrfyb09pKqc5LYwkgsoetoJYe+T8PWxcY+39LomkytqRFxoAQM0mV7VomRH4Yoo
 wDSdGUc+Wx8KmO7JO6bU/nwXD0FP6DiwOugshns1EKolWXTI5UV+OGcddAxV1DdOxCX0=
X-Gm-Gg: ASbGncvDwaIUgiuMK0et08OiEDShLZIB2ZGtYXuwehConwT0IA8Co90Ac5FI/EktAiD
 tP0AaWl2waTs9Umh+MEPmJsSsS46QGp2ldZ38B+NQdQ6resCX0rkx1plMonEym4L2Q+AWzTwQGR
 a+Gv/TIPCw2o+T7S0L4LzoCwcIiJJ/tD93cdJOK124QNfcdZ6bYzopSwAfrewIaIjaxg3/q4V1J
 NYq6X8u/N76phvtOs4xjfwWY/SmBKWWePu+sYSumuT34EovNF4HXGD8FwWNXQ6HvXSN57LMWg1P
 JNxoOmQPSSokEVGWxqVBQk+7gPoA6R5IwG/JCDH/3R2zmYyRThKzNlSM0ZEXbp0Pt5Vna/aZKvE
 K0SwLEVw=
X-Received: by 2002:a05:600c:4eca:b0:434:a852:ba6d with SMTP id
 5b1f17b1804b1-4392498a1e3mr73325145e9.9.1739114620178; 
 Sun, 09 Feb 2025 07:23:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ/ueCkdjtO5AZLtTtN+T9tYxhxwg9pN9H7AAe1ilhywHGAv10078L40+5gyLbLXj5wGBs9w==
X-Received: by 2002:a05:600c:4eca:b0:434:a852:ba6d with SMTP id
 5b1f17b1804b1-4392498a1e3mr73324985e9.9.1739114619741; 
 Sun, 09 Feb 2025 07:23:39 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd016496esm5912663f8f.19.2025.02.09.07.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 07:23:39 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, "E . Shattow" <lucent@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/4] riscv: dts: starfive: remove duplicate itb entries
Date: Sun,  9 Feb 2025 16:23:28 +0100
Message-ID: <20250209152329.187194-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
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

