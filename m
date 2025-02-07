Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A29C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6BB80805;
	Fri,  7 Feb 2025 18:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vRBpmlDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377F3807F1; Fri,  7 Feb 2025 18:23:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A59B800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A4D7F3FE7C
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738949000;
 bh=1nqXt0vf7fGqx6Or74CkzgNF2GrGJ6StzX11kmZ1DMQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=vRBpmlDeGWjJEUSJgrByQBqvLyS7YMgJEqmvV+/yj/q8swsm8ApCzmTcd9PmER7rR
 UvXSTrpyk/O/mR+lg94Hx24sIbAWnsxefRRQBtm1fzjEa5opuHtR+kVi+fynDgzeW6
 m9KewKb+qayau5Jss2DcuH42BWuImTd6gDkAbf8pupySkwA8ZdJi4a/IGYTcI2gGBK
 X8RJ/TSE50nMq18Z7S5vGsn0khQhQ2bJCoE79Ic93W71n+QARTvn/lB8wmLFGWxJy8
 X2OA7JpYV5OmruhsWqPub6y3QRs4i1+HaZ1pppnFYJLvHaciMU13EuiJlrAKRBELWS
 bXBBR+5iThSuA==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab6eecc3221so285815466b.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948923; x=1739553723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nqXt0vf7fGqx6Or74CkzgNF2GrGJ6StzX11kmZ1DMQ=;
 b=Murt5oedJ9WfhpvF4EVxXLRQuWhzno5drueMuapo7ms+Kw52UlR9fnrJc6Mm6yG+IX
 U/2M2nLe6ECbUbMu8ukHPDaU/ieEglImtiNsQSNqx24jbfhKuhKaMyXiC8KZ7iPFtCgL
 SfUdZbc3U0segnKbVHVssNgSNIPwL8MxzqZ6vnxV1VyMlhWCVM/HDeY8Yy3wEQ0g3fao
 /FL7nPKeanm76sDddSOuQKoakzLcbktJJAP09rgqa+dUXbbVKvk1AHj/yGAWHBCrYE5o
 +CEWJg9sYtcvUuS/GHzrrqnvNnf+V4pxMLdOiZdkcdFd4xUe8s6OJryrYfQnGavxU/mj
 j4QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKZcgsfteD2Dk7tb2u5y7xMKfRRELKzEvZoxnBiq5rsOF4Sq738jgT5yP009FsmSxXW8PjOVU=@lists.denx.de
X-Gm-Message-State: AOJu0YwUoO8FnMMoFKnAeGOD7BmyS5y9AzF/pdKhRIrUT8VpQKqV9hG4
 wnYCB+kVseaSKGD7VUYN3Hf2iaWmuzk0E3MBlp3VgK/amjd8BYlkDIRkb9Rc6OCRQD7rUlQZvjq
 7q2sK47da2LR8244sNz2YJb7hW/UCoZNjB7oqbjLbxPBc4Z9Nfrqb3MEAMvCNfiANK8M=
X-Gm-Gg: ASbGnctJ/LsQ7+KaW7D/yceliJd4OBnqTssGZHF9KTHgjZNK9el4jAgUR9nXmV1GjuH
 hLJMiQXUNdgjt99PEDEXK0NAqxR2hMjJDRY+UgB54bCLX7fw+MPi4x4S+v65IJc78a3mOByBkKh
 VQiIszkIH3CSKd1r9cFHo7CV+IDfluQYUAiwMkPuDtlHkuPOchS3R0k9wvm+1Z+zyCnwORK2wn9
 v3EuGqy9FsJziGe+Q+Xlm1gJIghfUrYT0xMhsOFPGz62tj0uQI1yE5+Ef2+0IXvd1zNHo+bPta3
 V2/82Mwgufj2Spe9yHVhwhrhs0txzJFeankuyc6BljsU3EksP68bx3gobLhidsoaus8t8lodcfq
 lsXZHK7M=
X-Received: by 2002:a17:907:3e8d:b0:aa6:9176:61ed with SMTP id
 a640c23a62f3a-ab789c2d498mr430881366b.48.1738948922879; 
 Fri, 07 Feb 2025 09:22:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK42rxj++qzQr4g5I8fXbf1H5gR2/grvTKwEeAa148IHipuqlycVrf5pfEr4l7Aai0VSMonQ==
X-Received: by 2002:a17:907:3e8d:b0:aa6:9176:61ed with SMTP id
 a640c23a62f3a-ab789c2d498mr430878266b.48.1738948922487; 
 Fri, 07 Feb 2025 09:22:02 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2866914a12.52.2025.02.07.09.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:22:01 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/6] riscv: dts: starfive: DeepComputing FML13V01 binman config
Date: Fri,  7 Feb 2025 18:21:12 +0100
Message-ID: <20250207172116.117749-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
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

Add the DeepComputing Framework motherboard (FML13V01) to the binman
include for the starfive_visionfive2_defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/dts/starfive-visionfive2-binman.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
index 4cce001e80d..63289405fbb 100644
--- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
+++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
@@ -16,6 +16,16 @@
 	itb {
 		fit {
 			images {
+				fdt-jh7110-deepcomputing-fml13v01 {
+					description = "jh7110-deepcomputing-fml13v01";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dtb";
+					};
+				};
+
 				fdt-jh7110-milkv-mars {
 					description = "jh7110-milkv-mars";
 					load = <0x40400000>;
@@ -58,6 +68,13 @@
 			};
 
 			configurations {
+				conf-jh7110-deepcomputing-fml13v01 {
+					description = "jh7110-deepcomputing-fml13v01";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-deepcomputing-fml13v01";
+				};
+
 				conf-jh7110-milkv-mars {
 					description = "jh7110-milkv-mars";
 					firmware = "opensbi";
-- 
2.47.1

