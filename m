Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AED3606A32C
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d0vEPUW8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpimpSxo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C5681779;
	Fri, 20 Nov 2026 13:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-39fTYeNM2k; Fri, 20 Nov 2026 13:21:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 242DF81765
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180904;
	b=W26lyH/5LBPm9fNLJU5kSee+qSV8pAcOoe7QK8e5k2DvoBbEUjz6g5RhhciYWV+IUCuB
	 NUCr2HtYFDngHLD3qKDbGlaVxmLewrbyT3MkX/6QB9jOYflNDAtA0Xp4thu7xNuoOV40y
	 AuY4mLL57f2NzPTOR3arZ4dtyVpSGLS1B1Zu3VJjoe7Be3aiT+EoH5xB/NPnmCJSih+Kw
	 JBSFQUP+P5h0IIR15LUnVPWbAJF8vXZV91sUQwnHAA56DDcYZUS12YIw8GkqF1Gc7gDyv
	 hcjTrw4B/Aj7txyGUReAC5qgK0tDs8AOYKwkV0WRst22q17IGrDvGT8wqtrMHtMhk7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A+FBzOPNsU74249jB20mnjyyfRI0bo9QEhbWuFMR3Eo=;
	b=aNL0lQawrakA+QRbiUMHHvaMEjTOvjs8ozkjsGLmYjllzdPKWWft+6wpQPTpu7BnDWRq
	 nxXbapxBPqcRp3w6il/A00uu43rfU99RVgmSjEDehZW8MNAGQ+hja2cpIf5IlyKVjbZX4
	 xHC+n1U4bpbG0z4UmnLRJYG2dG32TNUj2Pach0OSUp6Qg8gC//a5+5amwcm0AqMEGrFuP
	 phGN796JD/cgc4LRsoDP9ICIARnoUB99Q5wHhodKe5T7BDt/I0uUqQ+OGiMlwL109eqY+
	 0makJSDLsOIxBnB8MjdS//CRMLK6E5LPfPoU6LtAEQlXbZ77QFAiO8wVAaId9cgCP/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180904;
	bh=A+FBzOPNsU74249jB20mnjyyfRI0bo9QEhbWuFMR3Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d0vEPUW8KgTBdRWR7Epm2qdqgUjnJHl10Br5Urc4pgcLCYRRy892tOc+VkXozOQlp
	 ZsW3gVqJMbRjW8Wv0wCWRBDRQab0gmq1SivqexBIHVtNey79jJFFyJWeGDf+MN4Nnr
	 AQosfED/KNTvE2AU1WgCLjXovSgqhS3K8JvyXgmhhn35LaqH/SHxcrt6RN/jzoiOwf
	 u5mJl+LaqgyuvEt/BAU2qn/86q46sOexvzVGkpQ8boify6xu/jypPD5fpNv+efuTof
	 NbfgK6r7rPOfo6yVhQpR8FJyyMIdrop/wewuKJrl1BI2qqtfwbexZitVmGO2aqskss
	 e7/9wGETXE30Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 242DF81765;
	Fri, 20 Nov 2026 13:21:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01BA11C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E83F140A25
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1OQmIfZM0F0e for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7B15A4016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WpimpSxo
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B15A4016D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:53 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so653866f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173051; x=1795777851;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A+FBzOPNsU74249jB20mnjyyfRI0bo9QEhbWuFMR3Eo=;
 b=WpimpSxo6/xS5+4Yan3ilfwcckh2R8WCNutbbVoJIMYL6TmJwn5tMd7RZcCGOc29UG
 dJ8208q0eC4Zdt2wTYlfD0NMPC0OtsJRusTDvY/54wqj8EMqH3qf+HhaAUQP4IZXv837
 K91H4Fe0XeivtNUupwUOZp0PzzA9j6Nmx4QgB00jZfvigd+5O2SoE3RKtewRaZ1gPAFO
 PETWbBvuyWrZ85BJuuTZ4dDLlbh+xjyvoLDr2zfRP5fzjNHlAGDmIvonnTHDpzqB0zFY
 X1gcjX9TrTPJruJDzCdWEqIxxKbNFSN0GltvCQDxWhoXEbTb534kDj1Cco/aSNC8zkX2
 EmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173051; x=1795777851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A+FBzOPNsU74249jB20mnjyyfRI0bo9QEhbWuFMR3Eo=;
 b=Dz5dmfeVWrVhWvZ67f/7vnhk3xQiwme8iz6oXK0se1bGzW5bKTJPC6zb5zoWeR6MC8
 X2FSsSI+MDqe4/u0lH9HqRLlpZbYyAWYAG/kXlfsUBT/XoxYSQolG0DiGcnJLOnBBSn4
 32FnpOQ9g4kKJY19GZwmDOPQcIMDKk2pCU6Gf6FskUGNkqV/OtM+iOLN0PpSANsPlkoK
 DUbTEG1gE488oUGmeM+k0mwY9nl4M0RNhseWGWy6RnC5Nmwd5FPDE61Uj4ngPhIbbkul
 7fup372pfSkrcWPyAl++MXHjkqHxkoGIbVmhwa2Sn/Dln0Sc8Wi+Zkk1pP9IvzmjANWu
 W0xQ==
X-Gm-Message-State: APuU4Z+uasOZy/8zCbGgnieMCosS47U+ouij9qTPlBVhlFDFgxSPPjHM
 J47Uw0AHQ6foDsCQitN205IVz938GJ+Axhck6lKGQ4DU3Qscpd/J4HBH
X-Gm-Gg: AYBFou1nXenJU/NVN6FrOUOxuk1pfRRaA92nKjMHb/xZx1wNz22MAwncua7zwveAhPY
 rUmA/Q7QcrQqM93TB/+oNFQdQ/IhT64uyDJZMRg0nDTb1Y/NCB8a6/Bow41IsiQNbsx1oMjWBdN
 7LbXtQTJ2U1r1paJhmhoI5T+kAJflZ1xsoF2+DSWaryOm2YIgn7kdQ8yHMwAs1Hf10IcBu8sXz+
 KEqArscu1rLWHtAs3808kXIUM5KatzVJh1Ae8E91jRbCZ3DWcC2Tg/913rIicOq+LuPJz/pS4C1
 JeAOU9bnG4PGAR5hprOob2WFPkqeUphCtezQ8YgBxylt12OLWFZAAkgwpRjDafquJeE4bNktlDl
 8vLPRCwdhYcUeCqoE1sGo2baYwXy51S1/5mjjfQq80QfaLuEGt94H7SeoMFcenuT6UzenMiiIq8
 GoeY3YtRpIqIfC+sHocLWZIKXXKnFBIlzYz5DdYgGYCNF/O1lTM39O94g7OJ4LpZ5s5rHgZJdu/
 Y/spkV085T97rOzhq26mdzRf06yBEXgh5Oc5rvPER+a513TPf21NK4KsHkpnqB8f31byLXXjUpy
 M0bsjLeOvP2oi+sdrYSyqWs=
X-Received: by 2002:a05:600c:638f:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4bb8880607cmr55377425e9.13.1795173051161; 
 Fri, 20 Nov 2026 03:10:51 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:50 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 6/7] arm: dts: imx6ull-colibri: migrate to OF_UPSTREAM
Date: Fri, 20 Nov 2026 12:10:12 +0100
Message-ID: <20261120111037.110741-7-eichest@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120111037.110741-1-eichest@gmail.com>
References: <20261120111037.110741-1-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Build the Colibri iMX6ULL device trees from dts/upstream so they follow
the Linux kernel releases instead of a local copy.  The U-Boot specific
bits stay in the *-u-boot.dtsi files.

Remove the now obsolete device tree files:
- imx6ull-colibri.dtsi
- imx6ull-colibri-nonwifi.dtsi
- imx6ull-colibri-emmc-nonwifi.dtsi
- imx6ull-colibri-eval-v3.dtsi
- imx6ull-colibri-eval-v3.dts
- imx6ull-colibri-emmc-eval-v3.dts

Tested-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/dts/Makefile                         |   2 -
 arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts |  17 -
 .../arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi | 187 -----
 arch/arm/dts/imx6ull-colibri-eval-v3.dts      |  14 -
 arch/arm/dts/imx6ull-colibri-eval-v3.dtsi     | 121 ---
 arch/arm/dts/imx6ull-colibri-nonwifi.dtsi     | 161 ----
 arch/arm/dts/imx6ull-colibri.dtsi             | 748 ------------------
 arch/arm/mach-imx/mx6/Kconfig                 |   1 +
 board/toradex/colibri-imx6ull/MAINTAINERS     |   8 +-
 configs/colibri-imx6ull-emmc_defconfig        |   2 +-
 configs/colibri-imx6ull_defconfig             |   2 +-
 11 files changed, 5 insertions(+), 1258 deletions(-)
 delete mode 100644 arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts
 delete mode 100644 arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri-eval-v3.dts
 delete mode 100644 arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
 delete mode 100644 arch/arm/dts/imx6ull-colibri.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index cf4674042a2..e965aa6cd59 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -800,8 +800,6 @@ dtb-$(CONFIG_MX6UL) += \
 
 dtb-$(CONFIG_MX6ULL) += \
 	imx6ull-14x14-evk.dtb \
-	imx6ull-colibri-emmc-eval-v3.dtb \
-	imx6ull-colibri-eval-v3.dtb \
 	imx6ull-myir-mys-6ulx-eval.dtb \
 	imx6ull-seeed-npi-imx6ull-dev-board.dtb \
 	imx6ull-phytec-segin-ff-rdk-emmc.dtb \
diff --git a/arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts b/arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts
deleted file mode 100644
index 61b93cb040c..00000000000
--- a/arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
-/*
- * Copyright 2021 Toradex
- */
-
-/dts-v1/;
-
-#include "imx6ull-colibri-emmc-nonwifi.dtsi"
-#include "imx6ull-colibri-eval-v3.dtsi"
-
-/ {
-	model = "Toradex Colibri iMX6ULL 1GB (eMMC) on Colibri Evaluation Board V3";
-	compatible = "toradex,colibri-imx6ull-emmc-eval",
-		     "toradex,colibri-imx6ull-emmc",
-		     "toradex,colibri-imx6ull",
-		     "fsl,imx6ull";
-};
diff --git a/arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi b/arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
deleted file mode 100644
index ea238525d5c..00000000000
--- a/arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
+++ /dev/null
@@ -1,187 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright 2022 Toradex
- */
-
-#include "imx6ull-colibri.dtsi"
-
-/ {
-	aliases {
-		mmc0 = &usdhc2; /* eMMC */
-		mmc1 = &usdhc1; /* MMC 4-bit slot */
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>;
-	};
-};
-
-&gpio1 {
-	gpio-line-names = "SODIMM_8",
-			  "SODIMM_6",
-			  "SODIMM_129",
-			  "SODIMM_89",
-			  "SODIMM_19",
-			  "SODIMM_21",
-			  "UNUSABLE_SODIMM_180",
-			  "UNUSABLE_SODIMM_184",
-			  "SODIMM_4",
-			  "SODIMM_2",
-			  "SODIMM_106",
-			  "SODIMM_71",
-			  "SODIMM_23",
-			  "SODIMM_31",
-			  "SODIMM_99",
-			  "SODIMM_102",
-			  "SODIMM_33",
-			  "SODIMM_35",
-			  "SODIMM_25",
-			  "SODIMM_27",
-			  "SODIMM_36",
-			  "SODIMM_38",
-			  "SODIMM_32",
-			  "SODIMM_34",
-			  "SODIMM_135",
-			  "SODIMM_77",
-			  "SODIMM_100",
-			  "SODIMM_186",
-			  "SODIMM_196",
-			  "SODIMM_194";
-};
-
-&gpio2 {
-	gpio-line-names = "SODIMM_55",
-			  "SODIMM_63",
-			  "SODIMM_178",
-			  "SODIMM_188",
-			  "SODIMM_73",
-			  "SODIMM_30",
-			  "SODIMM_67",
-			  "SODIMM_104",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "SODIMM_190",
-			  "SODIMM_47",
-			  "SODIMM_192",
-			  "SODIMM_49",
-			  "SODIMM_51",
-			  "SODIMM_53";
-};
-
-&gpio3 {
-	gpio-line-names = "SODIMM_56",
-			  "SODIMM_44",
-			  "SODIMM_68",
-			  "SODIMM_82",
-			  "",
-			  "SODIMM_76",
-			  "SODIMM_70",
-			  "SODIMM_60",
-			  "SODIMM_58",
-			  "SODIMM_78",
-			  "SODIMM_72",
-			  "SODIMM_80",
-			  "SODIMM_46",
-			  "SODIMM_62",
-			  "SODIMM_48",
-			  "SODIMM_74",
-			  "SODIMM_50",
-			  "SODIMM_52",
-			  "SODIMM_54",
-			  "SODIMM_66",
-			  "SODIMM_64",
-			  "SODIMM_57",
-			  "SODIMM_61",
-			  "SODIMM_29",
-			  "SODIMM_37",
-			  "SODIMM_88",
-			  "SODIMM_86",
-			  "SODIMM_92",
-			  "SODIMM_90";
-};
-
-&gpio4 {
-	gpio-line-names = "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "SODIMM_140",
-			  "SODIMM_59",
-			  "SODIMM_142",
-			  "SODIMM_144",
-			  "SODIMM_133",
-			  "SODIMM_146",
-			  "SODIMM_28",
-			  "SODIMM_75",
-			  "SODIMM_96",
-			  "SODIMM_81",
-			  "SODIMM_94",
-			  "SODIMM_101",
-			  "SODIMM_103",
-			  "SODIMM_79",
-			  "SODIMM_97",
-			  "SODIMM_69",
-			  "SODIMM_98",
-			  "SODIMM_85",
-			  "SODIMM_65";
-};
-
-&gpio5 {
-	gpio-line-names = "SODIMM_43",
-			  "SODIMM_45",
-			  "SODIMM_137",
-			  "SODIMM_95",
-			  "SODIMM_107",
-			  "SODIMM_131",
-			  "SODIMM_93",
-			  "",
-			  "SODIMM_138",
-			  "",
-			  "SODIMM_105",
-			  "SODIMM_127";
-};
-
-/* NAND */
-&gpmi {
-	status = "disabled";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
-		&pinctrl_gpio4 &pinctrl_gpio6 &pinctrl_gpio7
-		&pinctrl_gpmi_gpio>;
-};
-
-&iomuxc_snvs {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio3>;
-};
-
-/* eMMC */
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2emmc>;
-	assigned-clocks = <&clks IMX6UL_CLK_USDHC2_SEL>, <&clks IMX6UL_CLK_USDHC2>;
-	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
-	assigned-clock-rates = <0>, <198000000>;
-	bus-width = <8>;
-	keep-power-in-suspend;
-	no-1-8-v;
-	non-removable;
-	vmmc-supply = <&reg_module_3v3>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx6ull-colibri-eval-v3.dts b/arch/arm/dts/imx6ull-colibri-eval-v3.dts
deleted file mode 100644
index 9bf7111d7b0..00000000000
--- a/arch/arm/dts/imx6ull-colibri-eval-v3.dts
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright 2018-2022 Toradex
- */
-
-/dts-v1/;
-
-#include "imx6ull-colibri-nonwifi.dtsi"
-#include "imx6ull-colibri-eval-v3.dtsi"
-
-/ {
-	model = "Toradex Colibri iMX6ULL 256/512MB on Colibri Evaluation Board V3";
-	compatible = "toradex,colibri-imx6ull-eval", "fsl,imx6ull";
-};
diff --git a/arch/arm/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
deleted file mode 100644
index e29907428c2..00000000000
--- a/arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
+++ /dev/null
@@ -1,121 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright 2017-2022 Toradex
- */
-
-/ {
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	/* fixed crystal dedicated to mcp2515 */
-	clk16m: clk16m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <16000000>;
-	};
-
-	reg_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_5v0: regulator-5v0 {
-		compatible = "regulator-fixed";
-		regulator-name = "5V";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
-	reg_usbh_vbus: regulator-usbh-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usbh_reg>;
-		regulator-name = "VCC_USB[1-4]";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 2 GPIO_ACTIVE_LOW>;
-		vin-supply = <&reg_5v0>;
-	};
-};
-
-&adc1 {
-	status = "okay";
-};
-
-&ecspi1 {
-	status = "okay";
-
-	mcp2515: can@0 {
-		compatible = "microchip,mcp2515";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_can_int>;
-		reg = <0>;
-		clocks = <&clk16m>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
-		spi-max-frequency = <10000000>;
-		vdd-supply = <&reg_3v3>;
-		xceiver-supply = <&reg_5v0>;
-		status = "okay";
-	};
-};
-
-&i2c1 {
-	status = "okay";
-
-	/* M41T0M6 real time clock on carrier board */
-	m41t0m6: rtc@68 {
-		compatible = "st,m41t0";
-		reg = <0x68>;
-	};
-};
-
-/* PWM <A> */
-&pwm4 {
-	status = "okay";
-};
-
-/* PWM <B> */
-&pwm5 {
-	status = "okay";
-};
-
-/* PWM <C> */
-&pwm6 {
-	status = "okay";
-};
-
-/* PWM <D> */
-&pwm7 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart5 {
-	status = "okay";
-};
-
-&usbotg1 {
-	vbus-supply = <&reg_usbh_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	vbus-supply = <&reg_usbh_vbus>;
-	status = "okay";
-};
-
-&usdhc1 {
-	vmmc-supply = <&reg_3v3>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
deleted file mode 100644
index 88901db255d..00000000000
--- a/arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
+++ /dev/null
@@ -1,161 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright 2018-2022 Toradex
- */
-
-#include "imx6ull-colibri.dtsi"
-
-/ {
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x80000000 0x10000000>;
-	};
-};
-
-&gpio1 {
-	gpio-line-names = "SODIMM_8",
-			  "SODIMM_6",
-			  "SODIMM_129",
-			  "SODIMM_89",
-			  "SODIMM_19",
-			  "SODIMM_21",
-			  "UNUSABLE_SODIMM_180",
-			  "UNUSABLE_SODIMM_184",
-			  "SODIMM_4",
-			  "SODIMM_2",
-			  "SODIMM_106",
-			  "SODIMM_71",
-			  "SODIMM_23",
-			  "SODIMM_31",
-			  "SODIMM_99",
-			  "SODIMM_102",
-			  "SODIMM_33",
-			  "SODIMM_35",
-			  "SODIMM_25",
-			  "SODIMM_27",
-			  "SODIMM_36",
-			  "SODIMM_38",
-			  "SODIMM_32",
-			  "SODIMM_34",
-			  "SODIMM_135",
-			  "SODIMM_77",
-			  "SODIMM_100",
-			  "SODIMM_186",
-			  "SODIMM_196",
-			  "SODIMM_194";
-};
-
-&gpio2 {
-	gpio-line-names = "SODIMM_55",
-			  "SODIMM_63",
-			  "SODIMM_178",
-			  "SODIMM_188",
-			  "SODIMM_73",
-			  "SODIMM_30",
-			  "SODIMM_67",
-			  "SODIMM_104",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "SODIMM_190",
-			  "SODIMM_47",
-			  "SODIMM_192",
-			  "SODIMM_49",
-			  "SODIMM_51",
-			  "SODIMM_53";
-};
-
-&gpio3 {
-	gpio-line-names = "SODIMM_56",
-			  "SODIMM_44",
-			  "SODIMM_68",
-			  "SODIMM_82",
-			  "",
-			  "SODIMM_76",
-			  "SODIMM_70",
-			  "SODIMM_60",
-			  "SODIMM_58",
-			  "SODIMM_78",
-			  "SODIMM_72",
-			  "SODIMM_80",
-			  "SODIMM_46",
-			  "SODIMM_62",
-			  "SODIMM_48",
-			  "SODIMM_74",
-			  "SODIMM_50",
-			  "SODIMM_52",
-			  "SODIMM_54",
-			  "SODIMM_66",
-			  "SODIMM_64",
-			  "SODIMM_57",
-			  "SODIMM_61",
-			  "SODIMM_29",
-			  "SODIMM_37",
-			  "SODIMM_88",
-			  "SODIMM_86",
-			  "SODIMM_92",
-			  "SODIMM_90";
-};
-
-&gpio4 {
-	gpio-line-names = "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "",
-			  "SODIMM_59",
-			  "",
-			  "",
-			  "SODIMM_133",
-			  "",
-			  "SODIMM_28",
-			  "SODIMM_75",
-			  "SODIMM_96",
-			  "SODIMM_81",
-			  "SODIMM_94",
-			  "SODIMM_101",
-			  "SODIMM_103",
-			  "SODIMM_79",
-			  "SODIMM_97",
-			  "SODIMM_69",
-			  "SODIMM_98",
-			  "SODIMM_85",
-			  "SODIMM_65";
-};
-
-&gpio5 {
-	gpio-line-names = "SODIMM_43",
-			  "SODIMM_45",
-			  "SODIMM_137",
-			  "SODIMM_95",
-			  "SODIMM_107",
-			  "SODIMM_131",
-			  "SODIMM_93",
-			  "",
-			  "SODIMM_138",
-			  "",
-			  "SODIMM_105",
-			  "SODIMM_127";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
-		&pinctrl_gpio4 &pinctrl_gpio6 &pinctrl_gpio7>;
-};
-
-&iomuxc_snvs {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio3>;
-};
diff --git a/arch/arm/dts/imx6ull-colibri.dtsi b/arch/arm/dts/imx6ull-colibri.dtsi
deleted file mode 100644
index 577a424b0e1..00000000000
--- a/arch/arm/dts/imx6ull-colibri.dtsi
+++ /dev/null
@@ -1,748 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-/*
- * Copyright 2018-2022 Toradex
- */
-
-#include "imx6ull.dtsi"
-
-/ {
-	/* Ethernet aliases to ensure correct MAC addresses */
-	aliases {
-		ethernet0 = &fec2;
-		ethernet1 = &fec1;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-		enable-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		power-supply = <&reg_3v3>;
-		pwms = <&pwm4 0 5000000 1>;
-		status = "okay";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
-
-		wakeup {
-			debounce-interval = <10>;
-			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
-			label = "Wake-Up";
-			linux,code = <KEY_WAKEUP>;
-			wakeup-source;
-		};
-	};
-
-	panel_dpi: panel-dpi {
-		compatible = "edt,et057090dhu";
-		backlight = <&backlight>;
-		power-supply = <&reg_3v3>;
-		status = "okay";
-
-		port {
-			lcd_panel_in: endpoint {
-				remote-endpoint = <&lcdif_out>;
-			};
-		};
-	};
-
-	reg_module_3v3: regulator-module-3v3 {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-name = "+V3.3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_module_3v3_avdd: regulator-module-3v3-avdd {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-name = "+V3.3_AVDD_AUDIO";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_sd1_vqmmc: regulator-sd1-vqmmc {
-		compatible = "regulator-gpio";
-		gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_snvs_reg_sd>;
-		regulator-always-on;
-		regulator-name = "+V3.3_1.8_SD";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		states = <1800000 0x1 3300000 0x0>;
-		vin-supply = <&reg_module_3v3>;
-	};
-
-	reg_eth_phy: regulator-eth-phy {
-		compatible = "regulator-fixed-clock";
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-name = "+V3.3_ETH";
-		regulator-type = "voltage";
-		vin-supply = <&reg_module_3v3>;
-		clocks = <&clks IMX6UL_CLK_ENET2_REF_125M>;
-		startup-delay-us = <150000>;
-	};
-};
-
-&adc1 {
-	vref-supply = <&reg_module_3v3_avdd>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_adc1>;
-};
-
-&can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "disabled";
-};
-
-&can2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-	status = "disabled";
-};
-
-/* Colibri SPI */
-&ecspi1 {
-	cs-gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
-};
-
-/* Ethernet */
-&fec2 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_enet2>;
-	pinctrl-1 = <&pinctrl_enet2_sleep>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy1>;
-	phy-supply = <&reg_eth_phy>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@2 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			max-speed = <100>;
-			reg = <2>;
-		};
-	};
-};
-
-/* NAND */
-&gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	fsl,use-minimum-ecc;
-	nand-on-flash-bbt;
-	nand-ecc-mode = "hw";
-	nand-ecc-strength = <8>;
-	nand-ecc-step-size = <512>;
-	status = "okay";
-};
-
-/* I2C3_SDA/SCL on SODIMM 194/196 (e.g. RTC on carrier board) */
-&i2c1 {
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	/* Atmel maxtouch controller */
-	atmel_mxt_ts: touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_atmel_conn &pinctrl_atmel_snvs_conn>;
-		reg = <0x4a>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;       /* SODIMM 107 / INT */
-		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;    /* SODIMM 106 / RST */
-		status = "disabled";
-	};
-};
-
-/*
- * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
- * touch screen controller
- */
-&i2c2 {
-	/* Use low frequency to compensate for the high pull-up values. */
-	clock-frequency = <40000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	ad7879_ts: touchscreen@2c {
-		compatible = "adi,ad7879-1";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_snvs_ad7879_int>;
-		reg = <0x2c>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-		touchscreen-max-pressure = <4096>;
-		adi,resistance-plate-x = <120>;
-		adi,first-conversion-delay = /bits/ 8 <3>;
-		adi,acquisition-time = /bits/ 8 <1>;
-		adi,median-filter-size = /bits/ 8 <2>;
-		adi,averaging = /bits/ 8 <1>;
-		adi,conversion-interval = /bits/ 8 <255>;
-	};
-};
-
-&lcdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lcdif_dat
-		     &pinctrl_lcdif_ctrl>;
-
-	port {
-		lcdif_out: endpoint {
-			remote-endpoint = <&lcd_panel_in>;
-		};
-	};
-};
-
-/* PWM <A> */
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-};
-
-/* PWM <B> */
-&pwm5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm5>;
-};
-
-/* PWM <C> */
-&pwm6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm6>;
-};
-
-/* PWM <D> */
-&pwm7 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm7>;
-};
-
-&sdma {
-	status = "okay";
-};
-
-&snvs_pwrkey {
-	status = "disabled";
-};
-
-/* Colibri UART_A */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1>;
-	uart-has-rtscts;
-	fsl,dte-mode;
-};
-
-/* Colibri UART_B */
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	fsl,dte-mode;
-};
-
-/* Colibri UART_C */
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	fsl,dte-mode;
-};
-
-/* Colibri USBC */
-&usbotg1 {
-	dr_mode = "otg";
-	srp-disable;
-	hnp-disable;
-	adp-disable;
-};
-
-/* Colibri USBH */
-&usbotg2 {
-	dr_mode = "host";
-};
-
-/* Colibri MMC/SD */
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
-	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_snvs_usdhc1_cd>;
-	pinctrl-3 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd_sleep>;
-	assigned-clocks = <&clks IMX6UL_CLK_USDHC1_SEL>, <&clks IMX6UL_CLK_USDHC1>;
-	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
-	assigned-clock-rates = <0>, <198000000>;
-	bus-width = <4>;
-	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>; /* MMC_CD */
-	disable-wp;
-	keep-power-in-suspend;
-	no-1-8-v;
-	vqmmc-supply = <&reg_sd1_vqmmc>;
-	wakeup-source;
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-};
-
-&iomuxc {
-	pinctrl_adc1: adc1grp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00        0x3000 /* SODIMM 8 */
-			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01        0x3000 /* SODIMM 6 */
-			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08        0x3000 /* SODIMM 4 */
-			MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x3000 /* SODIMM 2 */
-		>;
-	};
-
-	pinctrl_atmel_adap: atmeladapgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_DQS__GPIO4_IO16          0xb0a0  /* SODIMM 28 */
-			MX6UL_PAD_ENET1_TX_EN__GPIO2_IO05       0xb0a0  /* SODIMM 30 */
-		>;
-	};
-
-	pinctrl_atmel_conn: atmelconngrp {
-		fsl,pins = <
-			MX6UL_PAD_JTAG_MOD__GPIO1_IO10          0xb0a0  /* SODIMM 106 */
-		>;
-	};
-
-	pinctrl_can_int: canintgrp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04	0x13010	/* SODIMM 73 */
-		>;
-	};
-
-	pinctrl_enet2: enet2grp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
-			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
-			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
-			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
-		>;
-	};
-
-	pinctrl_enet2_sleep: enet2-sleepgrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06	0x0
-			MX6UL_PAD_GPIO1_IO07__GPIO1_IO07	0x0
-			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x0
-			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x0
-			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10	0x0
-			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15	0x0
-			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
-			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11	0x0
-			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12	0x0
-			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x0
-		>;
-	};
-
-	pinctrl_ecspi1_cs: ecspi1csgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA21__GPIO3_IO26	0x70a0	/* SODIMM 86 */
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA20__ECSPI1_SCLK	0x000a0	/* SODIMM 88 */
-			MX6UL_PAD_LCD_DATA22__ECSPI1_MOSI	0x000a0 /* SODIMM 92 */
-			MX6UL_PAD_LCD_DATA23__ECSPI1_MISO	0x100a0 /* SODIMM 90 */
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_RX_DATA0__FLEXCAN1_TX	0x1b020
-			MX6UL_PAD_ENET1_RX_DATA1__FLEXCAN1_RX	0x1b020
-		>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_TX_DATA0__FLEXCAN2_RX	0x1b020
-			MX6UL_PAD_ENET1_RX_EN__FLEXCAN2_TX	0x1b020
-		>;
-	};
-
-	pinctrl_gpio_bl_on: gpioblongrp {
-		fsl,pins = <
-			MX6UL_PAD_JTAG_TMS__GPIO1_IO11		0x30a0	/* SODIMM 71 */
-		>;
-	};
-
-	pinctrl_gpio1: gpio1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0x10b0 /* SODIMM 77 */
-			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x70a0 /* SODIMM 99 */
-			MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x10b0 /* SODIMM 133 */
-			MX6UL_PAD_UART3_TX_DATA__GPIO1_IO24	0x10b0 /* SODIMM 135 */
-			MX6UL_PAD_UART3_CTS_B__GPIO1_IO26	0x10b0 /* SODIMM 100 */
-			MX6UL_PAD_JTAG_TRST_B__GPIO1_IO15	0x70a0 /* SODIMM 102 */
-			MX6UL_PAD_ENET1_RX_ER__GPIO2_IO07	0x10b0 /* SODIMM 104 */
-			MX6UL_PAD_UART3_RTS_B__GPIO1_IO27	0x10b0 /* SODIMM 186 */
-		>;
-	};
-
-	pinctrl_gpio2: gpio2grp { /* Camera */
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA04__GPIO4_IO25	0x10b0 /* SODIMM 69 */
-			MX6UL_PAD_CSI_MCLK__GPIO4_IO17		0x10b0 /* SODIMM 75 */
-			MX6UL_PAD_CSI_DATA06__GPIO4_IO27	0x10b0 /* SODIMM 85 */
-			MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18	0x10b0 /* SODIMM 96 */
-			MX6UL_PAD_CSI_DATA05__GPIO4_IO26	0x10b0 /* SODIMM 98 */
-		>;
-	};
-
-	pinctrl_gpio3: gpio3grp { /* CAN2 */
-		fsl,pins = <
-			MX6UL_PAD_ENET1_RX_EN__GPIO2_IO02	0x10b0 /* SODIMM 178 */
-			MX6UL_PAD_ENET1_TX_DATA0__GPIO2_IO03	0x10b0 /* SODIMM 188 */
-		>;
-	};
-
-	pinctrl_gpio4: gpio4grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA07__GPIO4_IO28	0x10b0 /* SODIMM 65 */
-		>;
-	};
-
-	pinctrl_gpio6: gpio6grp { /* Wifi pins */
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0x10b0 /* SODIMM 89 */
-			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x10b0 /* SODIMM 79 */
-			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x10b0 /* SODIMM 81 */
-			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x10b0 /* SODIMM 97 */
-			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x10b0 /* SODIMM 101 */
-			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x10b0 /* SODIMM 103 */
-			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x10b0 /* SODIMM 94 */
-		>;
-	};
-
-	pinctrl_gpio7: gpio7grp { /* CAN1 */
-		fsl,pins = <
-			MX6UL_PAD_ENET1_RX_DATA0__GPIO2_IO00	0xb0b0/* SODIMM 55 */
-			MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0xb0b0 /* SODIMM 63 */
-		>;
-	};
-
-	/*
-	 * With an eMMC instead of a raw NAND device the following pins
-	 * are available at SODIMM pins.
-	 */
-	pinctrl_gpmi_gpio: gpmigpiogrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_ALE__GPIO4_IO10		0x10b0 /* SODIMM 140 */
-			MX6UL_PAD_NAND_CE0_B__GPIO4_IO13	0x10b0 /* SODIMM 144 */
-			MX6UL_PAD_NAND_CLE__GPIO4_IO15		0x10b0 /* SODIMM 146 */
-			MX6UL_PAD_NAND_READY_B__GPIO4_IO12	0x10b0 /* SODIMM 142 */
-		>;
-	};
-
-	pinctrl_gpmi_nand: gpminandgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x100a9
-			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0x100a9
-			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0x100a9
-			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0x100a9
-			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0x100a9
-			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0x100a9
-			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0x100a9
-			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0x100a9
-			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0x100a9
-			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0x100a9
-			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0x100a9
-			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0x100a9
-			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0x100a9
-			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0x100a9
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0	/* SODIMM 196 */
-			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0	/* SODIMM 194 */
-		>;
-	};
-
-	pinctrl_i2c1_gpio: i2c1-gpiogrp {
-		fsl,pins = <
-			MX6UL_PAD_UART4_TX_DATA__GPIO1_IO28 0x4001b8b0	/* SODIMM 196 */
-			MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29 0x4001b8b0	/* SODIMM 194 */
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL 0x4001f8b0
-			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA 0x4001f8b0
-		>;
-	};
-
-	pinctrl_i2c2_gpio: i2c2-gpiogrp {
-		fsl,pins = <
-			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30 0x4001f8b0
-			MX6UL_PAD_UART5_RX_DATA__GPIO1_IO31 0x4001f8b0
-		>;
-	};
-
-	pinctrl_lcdif_dat: lcdifdatgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00 0x00079	/* SODIMM 76 */
-			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01 0x00079	/* SODIMM 70 */
-			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02 0x00079	/* SODIMM 60 */
-			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03 0x00079	/* SODIMM 58 */
-			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04 0x00079	/* SODIMM 78 */
-			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05 0x00079	/* SODIMM 72 */
-			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06 0x00079	/* SODIMM 80 */
-			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07 0x00079	/* SODIMM 46 */
-			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08 0x00079	/* SODIMM 62 */
-			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09 0x00079	/* SODIMM 48 */
-			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10 0x00079	/* SODIMM 74 */
-			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11 0x00079	/* SODIMM 50 */
-			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12 0x00079	/* SODIMM 52 */
-			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13 0x00079	/* SODIMM 54 */
-			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14 0x00079	/* SODIMM 66 */
-			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15 0x00079	/* SODIMM 64 */
-			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16 0x00079	/* SODIMM 57 */
-			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17 0x00079	/* SODIMM 61 */
-		>;
-	};
-
-	pinctrl_lcdif_ctrl: lcdifctrlgrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_CLK__LCDIF_CLK	    0x00079	/* SODIMM 56 */
-			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE  0x00079	/* SODIMM 44 */
-			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC    0x00079	/* SODIMM 68 */
-			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC    0x00079	/* SODIMM 82 */
-		>;
-	};
-
-	pinctrl_pwm4: pwm4grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_WP_B__PWM4_OUT	0x00079		/* SODIMM 59 */
-		>;
-	};
-
-	pinctrl_pwm5: pwm5grp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_DQS__PWM5_OUT	0x00079		/* SODIMM 28 */
-		>;
-	};
-
-	pinctrl_pwm6: pwm6grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_TX_EN__PWM6_OUT	0x00079		/* SODIMM 30 */
-		>;
-	};
-
-	pinctrl_pwm7: pwm7grp {
-		fsl,pins = <
-			MX6UL_PAD_ENET1_TX_CLK__PWM7_OUT	0x00079	/* SODIMM 67 */
-		>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX6UL_PAD_UART1_TX_DATA__UART1_DTE_RX	0x1b0b1	/* SODIMM 33 */
-			MX6UL_PAD_UART1_RX_DATA__UART1_DTE_TX	0x1b0b1	/* SODIMM 35 */
-			MX6UL_PAD_UART1_RTS_B__UART1_DTE_CTS	0x1b0b1	/* SODIMM 27 */
-			MX6UL_PAD_UART1_CTS_B__UART1_DTE_RTS	0x1b0b1	/* SODIMM 25 */
-		>;
-	};
-
-	pinctrl_uart1_ctrl1: uart1ctrl1grp { /* Additional DTR, DCD */
-		fsl,pins = <
-			MX6UL_PAD_JTAG_TDI__GPIO1_IO13		0x70a0 /* SODIMM 31 / DCD */
-			MX6UL_PAD_LCD_DATA18__GPIO3_IO23	0x10b0 /* SODIMM 29 / DSR */
-			MX6UL_PAD_JTAG_TDO__GPIO1_IO12		0x90b1 /* SODIMM 23 / DTR */
-			MX6UL_PAD_LCD_DATA19__GPIO3_IO24        0x10b0 /* SODIMM 37 / RI */
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX6UL_PAD_UART2_TX_DATA__UART2_DTE_RX	0x1b0b1 /* SODIMM 36 */
-			MX6UL_PAD_UART2_RX_DATA__UART2_DTE_TX	0x1b0b1 /* SODIMM 38 */
-			MX6UL_PAD_UART2_CTS_B__UART2_DTE_RTS	0x1b0b1 /* SODIMM 32 */
-			MX6UL_PAD_UART2_RTS_B__UART2_DTE_CTS	0x1b0b1 /* SODIMM 34 */
-		>;
-	};
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO04__UART5_DTE_RX	0x1b0b1 /* SODIMM 19 */
-			MX6UL_PAD_GPIO1_IO05__UART5_DTE_TX	0x1b0b1 /* SODIMM 21 */
-		>;
-	};
-
-	pinctrl_usbh_reg: usbhreggrp {
-		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x10b0 /* SODIMM 129 / USBH_PEN */
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059 /* SODIMM 47 */
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059 /* SODIMM 190 */
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059 /* SODIMM 192 */
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059 /* SODIMM 49 */
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059 /* SODIMM 51 */
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059 /* SODIMM 53 */
-		>;
-	};
-
-	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
-		fsl,pins = <
-			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
-			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
-			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
-			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
-			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
-			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX6UL_PAD_CSI_DATA00__USDHC2_DATA0	0x17069
-			MX6UL_PAD_CSI_DATA01__USDHC2_DATA1	0x17069
-			MX6UL_PAD_CSI_DATA02__USDHC2_DATA2	0x17069
-			MX6UL_PAD_CSI_DATA03__USDHC2_DATA3	0x17069
-			MX6UL_PAD_CSI_HSYNC__USDHC2_CMD		0x17069
-			MX6UL_PAD_CSI_VSYNC__USDHC2_CLK		0x10069
-
-			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x10
-		>;
-	};
-
-	pinctrl_usdhc2emmc: usdhc2emmcgrp {
-		fsl,pins = <
-			MX6UL_PAD_NAND_RE_B__USDHC2_CLK     0x17059
-			MX6UL_PAD_NAND_WE_B__USDHC2_CMD     0x17059
-			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0 0x17059
-			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1 0x17059
-			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2 0x17059
-			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3 0x17059
-			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4 0x17059
-			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5 0x17059
-			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6 0x17059
-			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7 0x17059
-		>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <
-			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
-		>;
-	};
-};
-
-&iomuxc_snvs {
-	pinctrl_atmel_snvs_conn: atmelsnvsconngrp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04     0xb0a0	/* SODIMM 107 */
-		>;
-	};
-
-	pinctrl_snvs_gpio1: snvsgpio1grp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x110a0	/* SODIMM 93 */
-			MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x110a0	/* SODIMM 95 */
-			MX6ULL_PAD_BOOT_MODE0__GPIO5_IO10	0x1b0a0	/* SODIMM 105 */
-			MX6ULL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x0b0a0	/* SODIMM 131 / USBH_OC */
-			MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x110a0	/* SODIMM 138 */
-		>;
-	};
-
-	pinctrl_snvs_gpio3: snvsgpio3grp { /* Wifi pins */
-		fsl,pins = <
-			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x130a0	/* SODIMM 127 */
-		>;
-	};
-
-	pinctrl_snvs_ad7879_int: snvsad7879intgrp { /* TOUCH Interrupt */
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x100b0
-		>;
-	};
-
-	pinctrl_snvs_reg_sd: snvsregsdgrp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x400100b0
-		>;
-	};
-
-	pinctrl_snvs_usbc_det: snvsusbcdetgrp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x130b0
-		>;
-	};
-
-	pinctrl_snvs_gpiokeys: snvsgpiokeysgrp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x130a0	/* SODIMM 45 / WAKE_UP */
-		>;
-	};
-
-	pinctrl_snvs_usdhc1_cd: snvsusdhc1cdgrp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0a0 /* SODIMM 43 / MMC_CD */
-		>;
-	};
-
-	pinctrl_snvs_usdhc1_cd_sleep: snvsusdhc1cd-sleepgrp {
-		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x0
-		>;
-	};
-
-	pinctrl_snvs_wifi_pdn: snvswifipdngrp {
-		fsl,pins = <
-			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x130a0
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 6140d9f319b..081c941fe45 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -170,6 +170,7 @@ config TARGET_COLIBRI_IMX6ULL
 	select DM
 	select DM_THERMAL
 	select IOMUX_LPSR
+	imply OF_UPSTREAM
 
 config TARGET_DART_6UL
 	bool "Variscite imx6ULL dart(DART-SOM-6ULL)"
diff --git a/board/toradex/colibri-imx6ull/MAINTAINERS b/board/toradex/colibri-imx6ull/MAINTAINERS
index 1ceb1c8eb1b..5afcabdced1 100644
--- a/board/toradex/colibri-imx6ull/MAINTAINERS
+++ b/board/toradex/colibri-imx6ull/MAINTAINERS
@@ -3,12 +3,8 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:	https://www.toradex.com/community
 S:	Maintained
-F:	arch/arm/dts/imx6ull-colibri.dtsi
-F:	arch/arm/dts/imx6ull-colibri-emmc-eval-v3.dts
-F:	arch/arm/dts/imx6ull-colibri-emmc-nonwifi.dtsi
-F:	arch/arm/dts/imx6ull-colibri-eval-v3.dts
-F:	arch/arm/dts/imx6ull-colibri-eval-v3.dtsi
-F:	arch/arm/dts/imx6ull-colibri-nonwifi.dtsi
+F:	arch/arm/dts/imx6ull-colibri-emmc-eval-v3-u-boot.dtsi
+F:	arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
 F:	board/toradex/colibri-imx6ull/
 F:	board/toradex/common/
 F:	configs/colibri-imx6ull_defconfig
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index e48ce16b467..c56e9a90bc1 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -8,7 +8,7 @@ CONFIG_MX6ULL=y
 CONFIG_TARGET_COLIBRI_IMX6ULL=y
 CONFIG_DM_GPIO=y
 CONFIG_TARGET_COLIBRI_IMX6ULL_EMMC=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6ull-colibri-emmc-eval-v3"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-colibri-emmc-eval-v3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x84200000
 CONFIG_SYS_MEMTEST_START=0x80000000
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index d18965f5508..d65e5c16957 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -9,7 +9,7 @@ CONFIG_MX6ULL=y
 CONFIG_TARGET_COLIBRI_IMX6ULL=y
 CONFIG_DM_GPIO=y
 CONFIG_TARGET_COLIBRI_IMX6ULL_NAND=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6ull-colibri-eval-v3"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-colibri-eval-v3"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x84200000
 CONFIG_SYS_MEMTEST_START=0x80000000
-- 
2.56.1

