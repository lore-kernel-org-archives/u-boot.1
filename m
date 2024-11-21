Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3B9D6ED3E
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CEF89761;
	Thu, 21 Nov 2024 15:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bEV6O7Bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3BB689751; Thu, 21 Nov 2024 15:11:11 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF4FD89760
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa1e87afd31so137541566b.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732198268; x=1732803068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N2a7qZpnzNZ+MZQi3pJlqIVz2DjQ6L1WBO1CFCZOhCs=;
 b=bEV6O7Bn02LEbmOnhh4B4Uj8miTFVKy2DBy+RdLMaAYe0R3HhZfCg2Tp3uYgPc+Iun
 q5yAhp78aCWE7hNMnvus76EO4gvw2SxzsgtiaQTDJBQ9tBs7KKx2ieQLO2eVkpsf60Cl
 8cQ8JRg8tTw/TMHe2V5ybX1AKyJINBO1n137nOl8psBWdb5E2mmE+rKQ/wh+iZmy82ch
 i6Nu9MqLnJRcGJ5DCJ7fOPChn1MKBm4iEY7naWSvjRolbhwon1uszDTrcwDInDRPEcqp
 72DRhk/4PVtlJva0HSHnn+C4XOWAT0ieKWxrpUJrgUz5IcwEPAyb4VqgUgJR3rjaK+Nf
 Y2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732198268; x=1732803068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2a7qZpnzNZ+MZQi3pJlqIVz2DjQ6L1WBO1CFCZOhCs=;
 b=RfkqNKYBlBg4eHsCjc2c5sU8MKaajdcGl6GrmQcQ/jAAQ/abPSrfg0GolzpojWIkOM
 zoP6qsufwosIF0ensb7wqGeKsJF80KZTfRVM/VkgJLxEGZekFuVjzbo66/0X/LE41iVB
 +LVitnfkqrkoEqmX2cfBxWDSS17FqLpajjRk58Lnv14XLstAxJFZHK/g4MCNpeBsIyrQ
 B+bFfA7l3ZpXCiIg08d0tp5KNa7UMBfIuq7HHMQ5GyZMWn7/yVWN4oWWCANLO1PmvySi
 KqxQXDIInfPTHXTtgrKq+3tAaI5+FO9vnFvy5DxKAUs2emKgyfle/Pa6ARPC52fz/vvo
 1PJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV059eVzJPfM043TtZzCGGnEPlSe7pSIP6GsCAp+pE1unW9rsGwOzw5CXmjiw6VUUT2FHIUG8M=@lists.denx.de
X-Gm-Message-State: AOJu0YylU5pNp7M2pcEjVVRiJeIM5auCXxlc7IF0rT/HT1o4UFN7T+MJ
 /+Hrr4kSyc9Yp1qpkSyTX/23zzXtoKfwJbrSk2egNLHMNr50t6WO0kXyv1yhVlU=
X-Gm-Gg: ASbGncv4awIU9iQ34NheCSvw6sbkIM2pC6Nd1TJinmSnTpRRob2QI6nqIvrWp38A/5i
 7cXBf84kmU2fQwACibXclAaCK1Mt8SJ6oy8nMAzKqN8YAvU4U0/LAg63mcLGddJnLjS/WtTNivZ
 CQrce8okPX7O4qk4VDYFS9piCvArJSC/FXYG9URSMbTOHdyZWkega3pLEHKm3d/UdqFgOTINcrI
 F+UKG7cMNpf8y37iUMrivpca/EXzNDht2DgNA4JmOESNISfNI6ii2AK1ZqUL1qbgBrkIyobtlbu
 vGa5uujbctohEEnn+zjPFjDvdw==
X-Google-Smtp-Source: AGHT+IEoS8NzBm7uRvX22Y1CP2mODL0YW46Sx3Bw/mTUseuGShXyXlh34Qi1mwbzYJn9mSO/G1lqEw==
X-Received: by 2002:a17:907:3687:b0:a99:3318:e7c3 with SMTP id
 a640c23a62f3a-aa4dd70b57fmr627056766b.43.1732198268257; 
 Thu, 21 Nov 2024 06:11:08 -0800 (PST)
Received: from localhost.localdomain (ppp089210064034.access.hol.gr.
 [89.210.64.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f4153136sm85534566b.12.2024.11.21.06.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 06:11:07 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all
 architectures
Date: Thu, 21 Nov 2024 16:10:58 +0200
Message-ID: <20241121141058.367812-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

There not only ARM64 boards but also RISC-V boards that require a bounce
buffer to read block devices.

Drop the architecture restriction.

This patch was added in commit dcd1b63b7072 ("efi_loader: allow EFI_LOADER_BOUNCE_BUFFER on all architectures")
but was inadvertently reverted by
commit commit 775f7657ba58 ("Kconfig: clean up the efi configuration status") which was merged after.

Bring back the correct Kconfig dependencies

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 58d49789f12c..d93f28b84224 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -481,7 +481,6 @@ endmenu
 menu "Misc options"
 config EFI_LOADER_BOUNCE_BUFFER
 	bool "EFI Applications use bounce buffers for DMA operations"
-	depends on ARM64
 	help
 	  Some hardware does not support DMA to full 64bit addresses. For this
 	  hardware we can create a bounce buffer so that payloads don't have to
-- 
2.45.2

