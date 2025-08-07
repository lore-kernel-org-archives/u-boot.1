Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFA9C87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6128441D;
	Thu,  7 Aug 2025 07:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HDjL/J2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07FDE83BF1; Thu,  7 Aug 2025 07:33:09 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C25843FB
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-31f325c1bc1so642235a91.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544784; x=1755149584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQhvsjdoYjXoGVHW9cikp/fqtM6cqnaJ1NQTYpOQDU4=;
 b=HDjL/J2WJmG52+tDMbINKm9sF6PR1/m60ON840gi2KU7IOTmsYbglDyTibAOeK9QVf
 c8Cr6tMHzNJrEUbshGx2Nk6yTVREqCCDlxLfOqcOg2nfcULDjcVM7VpWwwEmG+sRBCU6
 /HVvXJGosq6ZeBUd7VnZ8n58eYcazFxrZX9aSrh+GpNAah3h9oSX92kgJJWaSu/rormJ
 2Pn2dOgvBg3rY4/ZQ/V+kdxc0MuLiUW/nIRas7Na9e7ekyBBTqr+Z9S3DhtfEseV4dZm
 TgeRApq5DgClqGGFwO3LEI3thy2YAAu+sZjRJUd7oKtSxrAHlC6R8mT7qlNqhesiflpb
 ID3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544784; x=1755149584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQhvsjdoYjXoGVHW9cikp/fqtM6cqnaJ1NQTYpOQDU4=;
 b=m6b4QO1nVXZ/0VSS6zUoFw9xs0pmX3P+SLOozKkLa0+CPg7zoVMRtz4oxFxjVJAZem
 w5wsmuEpnFd+6DgfGcErjiSTP/FWRy+K0eZP5myoVQ6OZkak0DqXv82e8cbsOg1IKohM
 ilK36xMGiAAJPPuEOb8SuOcReoCKXl1VjmY/I7lfwEUDXp8e6OXV2hUnObgkTdTPYOGh
 Fc+fcwCmUGs7orLgWGSqAuqgVdyZ78lmU6YZtKjF/fY4iO5r1K3hyYLbJahEMoFrSNaA
 ove6bPkybe3bQW5Hcpgs2ECDTglTGjzeA6REHIZdMJjhuidpi2PHDpjYWnR4fZNSxz/6
 p2Aw==
X-Gm-Message-State: AOJu0YwqaI3xX0rQ9u511y8tmJFZIbtkjT3rnGguF88jgnmnxFG10YPF
 NDwzqABPufve+Raz0LZdgwmSOq2mamCEPcFLgTZJxpRm5NUmDDmSMSKfqk+x6w==
X-Gm-Gg: ASbGncuO/keAsAer2G9fu6pK6dXFy8joRfeiWVUTtZAa9u+Shmq3Nc9AK97SjXSG/uS
 fKxboEBBTvlhTU6Qy7HnmMkJHObVJULYWE2piUVESgqOExBOX0LWq7lB0co3yCpvhriVHCLxE2b
 bx0cTPUYCAjKmNgsNyBmcn5J2BPWp8E5fvNzfdX5MKM6DM9/59w8QspEKU7Y0PzLJubN1m/lQYf
 ndds4hGdWRwsRHtPVw5ItGPCIpy2bzbfNFa3Jg49aDgpgGr2AUm/IlLCBNyEOz1kZGMuZUB2OzQ
 +HBXoTb3P/ZDA6fKdrHsEDUTDy6jZ0LIf5cKSNr+1syoSXuoChGr4yuMAlQa5SbI4YuNeWi3Z6h
 +rzs06NFvLrzgh3YLQWWEHywD7MsZ/42W+g==
X-Google-Smtp-Source: AGHT+IGrKAvGEn22q6fMFK2h09DsjNN9HKbC5K+oPX/oD3vMlfFT4oc2S800E5plvZDLrJvRRwZFWA==
X-Received: by 2002:a17:90b:35c8:b0:321:2160:bf72 with SMTP id
 98e67ed59e1d1-32166dfb0c8mr7183193a91.7.1754544783683; 
 Wed, 06 Aug 2025 22:33:03 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:33:03 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 7/7] configs: npcm: remove CONFIG_SYS_SKIP_UART_INIT
Date: Thu,  7 Aug 2025 13:32:24 +0800
Message-Id: <20250807053224.2169557-8-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
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

Set the uart clock frequency according to dts by default.
If CONFIG_SYS_SKIP_UART_INIT is not enabled, no need to
do board_set_console to change the console bootarg.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 9 ++++++++-
 board/nuvoton/poleg_evb/poleg_evb.c | 2 ++
 configs/arbel_evb_defconfig         | 1 -
 configs/poleg_evb_defconfig         | 1 -
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 16dbaa96e8c..05c4dd187fe 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -94,5 +94,12 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, board_set_console);
+static int last_stage_init(void)
+{
+#ifdef CONFIG_SYS_SKIP_UART_INIT
+	return board_set_console();
+#endif
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index 0a3c052a019..9dfe9744363 100644
--- a/board/nuvoton/poleg_evb/poleg_evb.c
+++ b/board/nuvoton/poleg_evb/poleg_evb.c
@@ -64,7 +64,9 @@ static int last_stage_init(void)
 		}
 		sprintf(value, "ttyS%d,115200n8", dev->seq_);
 		env_set("console", value);
+#ifdef CONFIG_SYS_SKIP_UART_INIT
 		return board_set_console();
+#endif
 	}
 
 	return 0;
diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 8572ad204d8..11ad19f56db 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -17,7 +17,6 @@ CONFIG_SYS_LOAD_ADDR=0x06208000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=120000
 # CONFIG_PSCI_RESET is not set
 CONFIG_ARCH_NPCM8XX=y
-CONFIG_SYS_SKIP_UART_INIT=y
 CONFIG_TARGET_ARBEL_EVB=y
 CONFIG_ENV_ADDR=0x807C0000
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/poleg_evb_defconfig b/configs/poleg_evb_defconfig
index a87e918117c..0803fb1a857 100644
--- a/configs/poleg_evb_defconfig
+++ b/configs/poleg_evb_defconfig
@@ -16,7 +16,6 @@ CONFIG_DEFAULT_DEVICE_TREE="nuvoton-npcm750-evb"
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x10000000
 CONFIG_TARGET_POLEG=y
-CONFIG_SYS_SKIP_UART_INIT=y
 CONFIG_ENV_ADDR=0x80100000
 CONFIG_FIT=y
 CONFIG_USE_BOOTCOMMAND=y
-- 
2.34.1

