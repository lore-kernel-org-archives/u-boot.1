Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0759EC021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 12:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7270F80F7A;
	Fri, 21 Feb 2025 13:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NUZ9rQfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208C280F5C; Fri, 21 Feb 2025 13:59:33 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FE680F96
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220c4159f87so28031755ad.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 04:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740142769; x=1740747569; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/FzUCMTo4xdcuur9oFc8DkW9mUh7tQP/5IE0RumJ1g=;
 b=NUZ9rQfag7zkpgf45zeuN5iBvo65ISVfFCCWBTv4qa1JYwfOyXzHBz24apnoNsrKt6
 gMMEFY4aIr5pJ0y1sZYqN04F7dWoynT1UJZ8lz30H3lW1XPXx9kwsCrXmceMsWK0RIA+
 PpGwzEw2Do2EWPTq/SX3xfIZFAPRiHexEMKtZ8V7mfhMKgc8x4WQtbUKOnoJsAOcHFiP
 6VHn8dqu6Uf+SvdPgqTm8mP01b20PgwJ1TiK//c01yBX1v21atSELdPrH8HblnrTnNjs
 KQdCycBnxNTOM/4EBoHP/VHWVCZCrIaJBCX+epHy5PyPIn6C1Uz4SGY27LO8W4xPZtOn
 Qvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740142769; x=1740747569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/FzUCMTo4xdcuur9oFc8DkW9mUh7tQP/5IE0RumJ1g=;
 b=aUsvP6ywMD61CsfmX9WDk0m+gaFKwACVLC8SlvZHZKGHHNPPIOIU1josMmbz43V3xV
 mpy38CFVtpeSv/2+BTUFsctVxRwiJ78njyfhInii5RgKgzp0YtDgJaUphqasJ5a/+UGX
 b/qEjhRB4wxaAdnUfjgURjfqIIY/mlKKcN3M9SDHP7NYiu4D7pFzWVObWzLUXAISU2o7
 jDuhVr1bBzrGx/tcsWAtto+Qe3xOseJn4cYwQDyUul/4YjbJH9IS6MtXFDsGK4Aegt3E
 Yf9Jpsg8BbJCmYYb36cIaSWTdki7/k62X6/6Bbvb4OIVNdVCttOEqP8D95LFZFQmxPok
 18Sw==
X-Gm-Message-State: AOJu0Yxb3SyvKVkoS8MdJfq7JIArqqLFu9wgy9A6vKtGIleliw2bDdK2
 +RHrklV57nYNSIMqKFnwhX48ra/bGt4FLksTwQuGGV5BRwsSL+/vAdFQRxRzNWG86q8NUJUf/t7
 q
X-Gm-Gg: ASbGncus0Lx2WQVCtDYhsCIXrZolUvCjoa/2tqmIi+5y3te5oRW/Ap9lyd+KBwTKuip
 +5eYHKjxhNTjqOFem+qUeinduwfw4T7KJ21DQNQfeXgA84Enh355LrKH6joxRCu3MSF1MyEErs4
 4KCFeWh2akPF/v3Ndt7aIp85bD6Pwbjh6++3fgk/a5CBkYp5lPUqGMxSpIRL19KuFcMTeFa0BOO
 c1Ej77oCHGrJY8OkyGJpOkq4lGki8R7aRi7Thiszdcx0JZB92FLN8q2r+TdvZ1sMUB+I530hoa4
 esQRvEj7vj5Ftl3ZuexYBjg=
X-Google-Smtp-Source: AGHT+IHiBHSCrMGdadpPAfXcoHfarRfmVd8zXH7q/SCGicmQGfXF0lN9qS6sCqhSekE6ngU8Vj/cfg==
X-Received: by 2002:a17:902:ea06:b0:215:a60d:bcc9 with SMTP id
 d9443c01a7336-2219ff30c7amr48977675ad.2.1740142769013; 
 Fri, 21 Feb 2025 04:59:29 -0800 (PST)
Received: from vm.. ([106.195.8.203]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2fceb09f6basm1273971a91.42.2025.02.21.04.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:59:28 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [RFC PATCH 2/3] riscv: Select appropriate image type
Date: Fri, 21 Feb 2025 12:58:52 +0000
Message-ID: <20250221125855.300717-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250221125855.300717-1-mchitale@ventanamicro.com>
References: <20250221125855.300717-1-mchitale@ventanamicro.com>
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

Select between the 32-bit or 64-bit arch type for the image headers
depending on how the build is configured.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/dts/binman.dtsi      | 14 ++++++++++----
 arch/riscv/include/asm/u-boot.h |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 0405faca574..a1a566b511b 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -5,6 +5,12 @@
 
 #include <config.h>
 
+#ifdef CONFIG_64BIT
+#define ARCH "riscv64"
+#else
+#define ARCH "riscv"
+
+#endif
 / {
 	binman: binman {
 		multiple-images;
@@ -31,7 +37,7 @@
 					description = "U-Boot";
 					type = "standalone";
 					os = "U-Boot";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
@@ -44,7 +50,7 @@
 					description = "Linux";
 					type = "standalone";
 					os = "Linux";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
@@ -57,7 +63,7 @@
 				tee {
 					description = "OP-TEE";
 					type = "tee";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					os = "tee";
 					load = /bits/ 64 <CONFIG_SPL_OPTEE_LOAD_ADDR>;
@@ -71,7 +77,7 @@
 					description = "OpenSBI fw_dynamic Firmware";
 					type = "firmware";
 					os = "opensbi";
-					arch = "riscv";
+					arch = ARCH;
 					compression = "none";
 					load = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
 					entry = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
diff --git a/arch/riscv/include/asm/u-boot.h b/arch/riscv/include/asm/u-boot.h
index d5e1d5f3231..a90cc4c21cf 100644
--- a/arch/riscv/include/asm/u-boot.h
+++ b/arch/riscv/include/asm/u-boot.h
@@ -23,6 +23,10 @@
 #include <asm/u-boot-riscv.h>
 
 /* For image.h:image_check_target_arch() */
+#ifdef CONFIG_64BIT
+#define IH_ARCH_DEFAULT IH_ARCH_RISCV64
+#else
 #define IH_ARCH_DEFAULT IH_ARCH_RISCV
+#endif
 
 #endif	/* _U_BOOT_H_ */
-- 
2.45.2

