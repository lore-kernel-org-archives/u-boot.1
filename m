Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22BDD711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62E98309A;
	Fri, 19 Dec 2025 00:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HHKtsSGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC36F83710; Fri, 19 Dec 2025 00:37:01 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74273836A3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3f5c9275b31so747746fac.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766101018; x=1766705818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKAxKj5LoBPRCCu2ngsT/CSQv4EloClSMlWNBL52PnA=;
 b=HHKtsSGtM2pTe+SBaGncD7SGIz/EliUEzx+TtxuUHBCvZjW6jI6w8ZUd20ndhMVuvW
 KfxAPNLo2QP4+B05KgQQrD+omxTOxv9TUOKkFa+ylUPDL/jyrBFJ5UjtctbJ70JeB+/E
 zEW1Iql37TdRlgYik+3Z2bc55vLDogNfJ1IMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766101018; x=1766705818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iKAxKj5LoBPRCCu2ngsT/CSQv4EloClSMlWNBL52PnA=;
 b=QvQiCQMisVvDWgsBmeoehb4LIItNx5pBrBEyV9ASi5s1luyL6TQfJdqZC8/dwn937v
 X8uJnZDBgUQRGjcl+wm6vXOpipuubr3avBIsiBccSMEUAOyju8mZtwCurmPHLDLw+6/J
 NfU0f01dDM6fNZ42/a2F9ADHTxPWadbLUitOkuX8PB1gXsPBEoZz/gHJZQ5Ler9Hzwqi
 n7M/yAOTp2bbRF/W7jUFede27Q97MFAAtjW0xZlfgm5BYlvUvM9C1dzXAiRh32Jj2exy
 SsCobq3zwsGyr4Fwp58S1U/yTNlSwgrPijdpU8S612zM5lkrDhqBdcQgvcS4N7538wa4
 8y6Q==
X-Gm-Message-State: AOJu0YwiKe8IUyAeS0sX42v5JIK90gOUDimfeIVedB3LVJuB5HJDUtyO
 9Bez961NktxIEjjFj7H6O5oY/CJHtePKS5gS1Mc1QHM58yGywfNOqTjrGmoE1Ism/lFaRnLq2Bl
 o5kVEjdc=
X-Gm-Gg: AY/fxX46IQUi5YtvFLtuDMKdesoaDa/BJiCET6HKjLPS6oIGtl/7wDFo5z6jYl9Vs0o
 fkHjE5VfUdpShNLUZSBXtGS/6NPp4hutUktH8DKGNCDTOBlGPe8iG9lbeXknaa25rp1l+TH8M94
 bBskPKh9N+Q1zMv548YfcCOKGLpGEAr6Q//gH7foWLyS07aWqANTEGywJhiC2+MDY4xWBuBQSfn
 2bOYSCxwYpQIr85s0B3EJe5RMxhQBvgAwJHH6YDhkKblhmgt+/F/0P20/yP61Tgt8wTOsI8qqg8
 1u5hTFY2bRIkRQw+QbW9pAN1exZmi+uRBrGW5HkdiDFaDt/QdIvi4E2+3bAypNvLSLtyUfewaRM
 hQW41J4HyyvC+o7Nyfh7lN88MRg1w565nDW+VPviyJowAsRxH+LyZj7cR0CpDJSsMm46Wsr7BQ/
 zo99mZp0Jv0OTYXN1BaHMJhgnuCI/recl/PVGJu+Aj6cdMzvQIsPbi
X-Google-Smtp-Source: AGHT+IFjt8CNjrwKmpWZdDonWrUrWFJ6XvUPb7tr0XIKHp+r0WTQfIlUgadOHl4nULyk6pjxjOKQ0A==
X-Received: by 2002:a05:6871:6681:b0:3f5:b16e:82c6 with SMTP id
 586e51a60fabf-3fda547c27amr748916fac.52.1766101018086; 
 Thu, 18 Dec 2025 15:36:58 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab5ccb9sm449605fac.10.2025.12.18.15.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:36:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>,
	Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCHv1 1/3] lzma: Add Kconfig options to optimize for size
Date: Thu, 18 Dec 2025 17:30:56 -0600
Message-ID: <20251218233654.3938385-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218233654.3938385-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
 <20251218233654.3938385-1-trini@konsulko.com>
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

Currently, our LZMA library has an option for optimizing for size,
rather than speed. It is a minimal savings today, and has not been worth
enabling. As this will change in the near future, add options now to
allow disabling it in full U-Boot or in SPL, and enable these on
gardena-smart-gateway-mt7688 which is very close to the size limit
today.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
---
 configs/gardena-smart-gateway-mt7688_defconfig |  2 ++
 lib/Kconfig                                    | 14 ++++++++++++++
 lib/lzma/Makefile                              |  1 +
 3 files changed, 17 insertions(+)

diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index 3c2bcc6a3c44..aba8a2ffd1de 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -101,4 +101,6 @@ CONFIG_MT7621_SPI=y
 CONFIG_WDT=y
 CONFIG_WDT_MT7621=y
 CONFIG_LZMA=y
+CONFIG_LZMA_SIZE_OPTIMIZATION=y
 CONFIG_SPL_LZMA=y
+CONFIG_SPL_LZMA_SIZE_OPTIMIZATION=y
diff --git a/lib/Kconfig b/lib/Kconfig
index fe0b878a206b..96032eaddf95 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -838,6 +838,13 @@ config LZMA
 	  ratio and fairly fast decompression speed. See also
 	  CONFIG_CMD_LZMADEC which provides a decode command.
 
+config LZMA_SIZE_OPTIMIZATION
+	bool "Optimize the LZMA algorithm for smaller binary size"
+	help
+	  This enables building the LZMA library optimized for size, rather
+	  than performance. This can be a loss of 15-20% in decompression
+	  speed, but a savings of close to two kilobytes in many cases.
+
 config LZO
 	bool "Enable LZO decompression support"
 	help
@@ -932,6 +939,13 @@ config SPL_LZMA
 	help
 	  This enables support for LZMA compression algorithm for SPL boot.
 
+config SPL_LZMA_SIZE_OPTIMIZATION
+	bool "Optimize the LZMA algorithm for smaller binary size in SPL"
+	help
+	  This enables building the LZMA library optimized for size, rather
+	  than performance. This can be a loss of 15-20% in decompression
+	  speed, but a savings of close to two kilobytes in many cases.
+
 config TPL_LZMA
 	bool "Enable LZMA decompression support for TPL build"
 	depends on TPL
diff --git a/lib/lzma/Makefile b/lib/lzma/Makefile
index c2fd3e494541..b8ad570ab1c2 100644
--- a/lib/lzma/Makefile
+++ b/lib/lzma/Makefile
@@ -7,5 +7,6 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 ccflags-y += -D_LZMA_PROB32
+ccflags-$(CONFIG_$(PHASE_)LZMA_SIZE_OPTIMIZATION) += -D_LZMA_SIZE_OPT
 
 obj-y += LzmaDec.o LzmaTools.o
-- 
2.43.0

