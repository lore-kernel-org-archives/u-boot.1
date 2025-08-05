Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28526C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9C8835B0;
	Tue,  5 Aug 2025 11:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mX5oZHNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5021C835B0; Tue,  5 Aug 2025 11:20:22 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B3681D5D
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b34a6d0c9a3so5232424a12.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385618; x=1754990418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ysc9J/9W6bMz5yxZFL4EJhN8oGA2qvyjIngraV8nM54=;
 b=mX5oZHNpRu96qSO3lJRYKyfHlEGVgvwiRGiCKkOdp5fyaHirWhIRMcKwqemNC1PVgh
 Y3pLIcghsm4xLyCPnbawywb88iVGJgMorHM9a8I/8kCb+HODEvgrQK5KI8n1yJpwb/4N
 a3O86etViIzDdhiBgFHR6GpatFMrJTnT1d5xy9YGOoG6kZHc0ZzrVuHbt7zMOwY49ePL
 5T+VwYp23DfH09MxT+KH1CTZ5YtBAp+M10HB5G2dhUfWEEcbwpzk7Yr1ekfuuPgjs0bt
 a3dyozMVcVpT69RJN+nJdKNU3vRo485SpVLpMQwofmqiIl6ftVhPGhUT2X7dqeyN5CVH
 gkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385618; x=1754990418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ysc9J/9W6bMz5yxZFL4EJhN8oGA2qvyjIngraV8nM54=;
 b=KeDna6sKr1Oqe3yg+hrO1YxpdfSo49zyapGv/JFRISzBS00TLaKM6/ChkFa2X0jNcc
 WRlEkbeuy1gD1UkeD2pp0T0W5+6lENEWqMn6SpDs4Kl8Rby47iMRlfAng01neB/c3MTm
 bxC3+BzYlmRfHbnJQo72E4RHwOuF34OgOOu0KpJCbl+mmbR2FyPaC9TdJRNRG7Zk/Nxs
 arBrUNM5EvZsnGuby4/OAa7BDlJ4cOPt7dcjyd5ER39/TtTUXoW8lyIeT3S22jmO3TMr
 X4gNgmY3T76waVd2DeuhxwJtBFn2LjNzrUf0Vq9mOht/O2C7RTxv/Xd0x3o6VQt96Kar
 5QvQ==
X-Gm-Message-State: AOJu0Yzgc/ODtWsPRXzpAhBcUwVw87/UWZYmWXzI7lSEkN4Dlxnwi6ga
 dLmhZLBkRRPgtMWYblEJYqKDYxooHQqj7sJGXlj7qWauVoVNo0jRxCGk
X-Gm-Gg: ASbGncukHjj2Pn8pHt/iJEapJk8cTDQFNbBUQ6F188ni0dXp1rSuQ9Qom82rivQAbA7
 JMaFlLhT6I1OQd5Ops2SMXsafmnH0RZp//4eJajxMVX4jgrWzI1rm4F4PQyzrSoG5Gnog65vDeN
 JyczAZG6M6PQa+4AtKUfQNkW8bq1/dCsqvFUguvEYACiAlL+5cWfTIjO9Eq+0p3GGxzZORtaETq
 KapQhUMpAG06QwyB8I0wr/tqYgQyE9sxAiDZQCLFENJrnQuH8dN7LFx6/7r+rlX4jv3odz6TZx3
 t5OGCUm7mpWpEAF4u6HTLn7JshceAMJCn2VQsSA0ECFqZGH+EsuaUfHSO7HHr84pqKoxyq6YfxE
 bkcmc69FdjnKbQZ4A3f9W+ckEyK3vyimVeA==
X-Google-Smtp-Source: AGHT+IEP3bNHXTnhFa2oooHsEsgqFplAmlEP3LeSlrNmVzjOgjOQILXM1w+Udl2nt5467uodpMrjNA==
X-Received: by 2002:a05:6a21:32a9:b0:23d:d9dd:8e4f with SMTP id
 adf61e73a8af0-23df980547bmr17110119637.28.1754385617947; 
 Tue, 05 Aug 2025 02:20:17 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:20:17 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 9/9] configs: npcm: remove CONFIG_SYS_SKIP_UART_INIT
Date: Tue,  5 Aug 2025 17:18:50 +0800
Message-Id: <20250805091850.2051096-10-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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
index 16dbaa96e8c..0fba4a8b709 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -94,5 +94,12 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, board_set_console);
+static int last_stage_init(void)
+{
+#ifdef CONFIG_SYS_SKIP_UART_INIT
+	board_set_console();
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

