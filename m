Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2501C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976EF805C2;
	Mon, 10 Feb 2025 12:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dvyBDi7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E9B809A4; Mon, 10 Feb 2025 12:18:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BE180548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5E7994010B
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 11:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739186322;
 bh=S/y/vXITJzXugifDzQOfHJuwLMCjWu7Nc3MvcgA+8vA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=dvyBDi7M7Hl5eHJiaSTG0hByJa+1EKiUlgvJwRp3x4+0+zNzSKVgdX1XrgkJ5Vaz+
 JZE+AvVPZt2pk5olEa4V8XdXYKZHzsx4XN2ebBNn5XWGh9YxIFkk1R7RqHF8cDhUug
 bTxM3fd7uYjnKUR1yAi3OliqW36zqoHzTwIAcU8uTGTbKpxht3kaWb+61cHSL6WUVW
 TSXwpJSyY/67+4X8+NWWT87PYgS3AhKXlVUpZQqDA5HKQCM6uFgXXs+zPIt/gNR/DW
 l0I1UKMuTN5dO5Ic/o8tdAD+0MEOJsGlQ78UBH+qmPcep+jICveSCmYUPWSn+NArtR
 SupcYQRuwXjfw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so25097065e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 03:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739186322; x=1739791122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/y/vXITJzXugifDzQOfHJuwLMCjWu7Nc3MvcgA+8vA=;
 b=ZNzfKPnRR2FzyObZh7iE481MIq4P7quQi4GsA41VU/JO+YBvCwTVkGFHPDqngv2Kcv
 TMTVMCUxlojlbZOdv+Ggd7BTb6Ga6+d1PTIpqYixOdP1IGQVhJextDD1NP67e8vPOvFe
 P+k5U+d4WIMssSSNy1laf+293H24yVnVb+WZSQYQQ9nuh4ze1DBOVCiWo6a/vegt/QK9
 4rYtIW7YW5Tq8HM9P2o97+U7em+l8fUlgdJAZzz9z92XUWHiieTwra6+WZBfh8FPWtHj
 xNFrr2TCz3NrEip75iJ4tch4RoNdPjZqJ3g0JNmYA2ML8W9mT/YGfoNw/grhK+chBAwo
 anqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlQwO26At7ogKfFfJtmdz07UYb+mEaFTrv2tV5CKjEXtAOj8Z99E4OSEupdmlr7epUHzs+qtg=@lists.denx.de
X-Gm-Message-State: AOJu0YzSfdGVYWRc19EGdbW/8D9I6T9df/k6pcAXINUPrxtBtlxXe3bH
 SM+APlNLzliPDCWcAGvyN5DHbhDBrCTCVusstEo9B5QqrosempCPLmwZzX2/coRue5/X8ssNZmi
 ypvYksyHs3JNg6FE0/tdu1Tx+XUW6Fg9Ak6vS+4x02hEx2zAaPy4Q9UC+hb5SQAT5CaE=
X-Gm-Gg: ASbGncvMQ2hNW0AfyUOCB5trlg0F3lxjBdIFMXG+2/KyUZ7UoncMn+KbtRUsVA2Cl+2
 qn3c821J/eXCrC8FcHJyAmdBsCd+joBco6qfPZ8F65DlBgdxIDMD1naRgEwIiI5WVtiIDtkdSFP
 MVvhQZINj6B6guqXV76xvjuJAqtDVagYAbmK09p3A/yTnjABhDwcp3jMYpBv9OXg6E1YD1NuYtF
 fl5YmkY1J3VQJ34tJoVeeRnEYvrcx620vuBr3UnaJMl2hqOT9prg+J08qxGqX2Ia+cZL+SRr8sm
 vZvqFukXtpC/NrF8JArSKIVTh/HjRLAtCVkEW0/8Lp01PrzYDD7zUAHXOcf/07R1vKq9zNuRCqu
 muJeiuos=
X-Received: by 2002:a5d:6151:0:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-38dc8dcbedamr8892204f8f.21.1739186321990; 
 Mon, 10 Feb 2025 03:18:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmvMVE1DAa99/Z7n4VM+5QY41O823GnTwi8MhYRtL00gcNvKFDN0YZWfizBeujumt1lH9pAg==
X-Received: by 2002:a5d:6151:0:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-38dc8dcbedamr8892173f8f.21.1739186321566; 
 Mon, 10 Feb 2025 03:18:41 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dda26c6f5sm4194243f8f.68.2025.02.10.03.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 03:18:41 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/4] riscv: dts: add OF_LIST handling to binman.dtsi
Date: Mon, 10 Feb 2025 12:18:27 +0100
Message-ID: <20250210111830.72055-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
References: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
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

Binman can automatically generate device-tree and configuration entries in
the FIT image based on CONFIG_OF_LIST if the binman node includes the right
sub-nodes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	no change
---
 arch/riscv/dts/binman.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 0405faca574..7edc36ccac0 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -82,8 +82,9 @@
 					};
 				};
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_OF_LIST)
 				@fdt-SEQ {
+					fit,operation = "gen-fdt-nodes";
 					description = "NAME";
 					type = "flat_dt";
 					compression = "none";
@@ -94,7 +95,7 @@
 			configurations {
 				default = "conf-1";
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_OF_LIST)
 				@conf-SEQ {
 #else
 				conf-1 {
@@ -115,7 +116,7 @@
 #endif
 #endif /* CONFIG_OPTEE */
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_OF_LIST)
 					fdt = "fdt-SEQ";
 #endif
 				};
-- 
2.47.1

