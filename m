Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABD3C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D5C885A2;
	Fri, 21 Jun 2024 01:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ErGoDq9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89D68859B; Fri, 21 Jun 2024 01:06:47 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF82B87B77
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7eb5dd9f994so49019139f.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924804; x=1719529604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55AI1Zdq2PtMQvY/0hkcvJqBd9KlBMTMR5uFE0YcI/k=;
 b=ErGoDq9xH84K6q5cfG5Tk/6Br/tByJU/yAyDX0PdUoP52G3Or5mFx9dWHLTo4xWrRo
 I2zJrXkboc9VOot+NBIyToQw5E9mVXlvQT1az1vE6WgNAXbxO8nqWYrk43QSEqFw++Wa
 4IvSRxMwTZ0rwK8FAJ8u1csDQy36/mmE9QXTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924804; x=1719529604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55AI1Zdq2PtMQvY/0hkcvJqBd9KlBMTMR5uFE0YcI/k=;
 b=eiYtbhTlJVgHwGuriGOdthYcl13eZcg/M2JgUZIBjUo2QvCblnLLH0f1YLQaNWITyQ
 +5XUgBXKymVs018CPQp+r5muQbWkvEEdcHxAZ2Sb6kbO18k0AQhROCZXE1PPODI1MMnr
 lcc0exegLOhfoupW5XeBpcegQKJ1dV3kArfwG/GNDZO/RIN2akHwItNbN1sc8GfBgZjO
 W8df7SEoFz+F6wSIa3SKWKtNS917Xqi1Rnav1n1x9JY7fo238FQOS/kAuuNVE/XQwWh7
 jIU2NGw/E7LitZ/H/feNc3ZMhsGYNpomyu3HcpItAnbm4Hw7gfqKRcuwP3W0owT3xH68
 MXrA==
X-Gm-Message-State: AOJu0Yyu/oRQ2Oa7yioijo+IHN5buMNTG8J7lan9AkGMfu3KgLm0mSjv
 ON4e2/ze6BnapDg7VQJGqsbZVoJrsSgi2CTDpAmTxJuK6ZyHK+w7v0+c/oMyPytpweNjhz/JPoo
 ytw==
X-Google-Smtp-Source: AGHT+IGLnZAJ44OCy90q1HuPE748YtsmNyGjAfWkiWEPSyN1gH4G+3T7KU84X7TwinYibGGDpxppQQ==
X-Received: by 2002:a05:6602:6003:b0:7f1:3ad1:2341 with SMTP id
 ca18e2360f4ac-7f13ee24152mr775004539f.7.1718924804350; 
 Thu, 20 Jun 2024 16:06:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 08/18] x86: Set up some assumed sizes for binary blobs
Date: Thu, 20 Jun 2024 17:06:15 -0600
Message-Id: <20240620230625.1797397-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

Add assumed sizes so that Binman can check that the U-Boot binaries do
not grow too large.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/dts/u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/dts/u-boot.dtsi b/arch/x86/dts/u-boot.dtsi
index e0de3318091..fdd28979e0b 100644
--- a/arch/x86/dts/u-boot.dtsi
+++ b/arch/x86/dts/u-boot.dtsi
@@ -24,9 +24,11 @@
 #ifdef CONFIG_HAVE_INTEL_ME
 	intel-descriptor {
 		filename = CONFIG_FLASH_DESCRIPTOR_FILE;
+		assume-size = <0x1000>;
 	};
 	intel-me {
 		filename = CONFIG_INTEL_ME_FILE;
+		assume-size = <0x1ff000>;
 	};
 #endif
 #ifdef CONFIG_TPL
@@ -87,6 +89,7 @@
 #ifdef CONFIG_HAVE_MRC
 	intel-mrc {
 		offset = <CFG_X86_MRC_ADDR>;
+		assume-size = <0x2fc94>;
 	};
 #endif
 #ifdef CONFIG_FSP_VERSION1
@@ -98,6 +101,7 @@
 #ifdef CONFIG_FSP_VERSION2
 	intel-descriptor {
 		filename = CONFIG_FLASH_DESCRIPTOR_FILE;
+		assume-size = <4096>;
 	};
 	intel-ifwi {
 		filename = CONFIG_IFWI_INPUT_FILE;
@@ -139,6 +143,7 @@
 	intel-vga {
 		filename = CONFIG_VGA_BIOS_FILE;
 		offset = <CONFIG_VGA_BIOS_ADDR>;
+		assume-size = <0x10000>;
 	};
 #endif
 #ifdef CONFIG_HAVE_VBT
-- 
2.34.1

