Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D493C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A543B82B70;
	Thu, 12 Jun 2025 16:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NoKW1b6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8FE82BD9; Thu, 12 Jun 2025 16:09:48 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E975E828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so2048885b3a.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749737384; x=1750342184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5CD1yswgq3J+tGltLKmFPHbpsaVms3rYIC5MbGViXVM=;
 b=NoKW1b6bqq2K0XBuqafyev2B2GF8hHzgbP+0ZYv5WZYNpzeoR6+viKa+IelLs3ry9v
 5s0kPJSlk0a5oqyE/o0VyQLN4O+WtANy9b9P1R566j7RjJrzWPhMC4MMhP+KVnbOysoT
 G/YjS4N+PGMS3QifZCdzZaMv9Ag9fSfFKglErcPySbZRVFOpkEsFs/yh3cVEKDUyPOuj
 HfzjWRWRThZrxJn/iEtX+oVIMnanHPwITATeY+6M68iPWGNIO69C0hfdszhJOtEzORbh
 ae/aIYtaP/k68TvfefE8/V7whZWae2ha99rOudE64CEVoGj+F7qI7gAe1ZupseI8l8sp
 yKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737384; x=1750342184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5CD1yswgq3J+tGltLKmFPHbpsaVms3rYIC5MbGViXVM=;
 b=J5D1g/wia6yZ3IHhbhtjOaoe6Ymkg/cYmGORiDNhhWQ4PBYhzXFpOJnX80Km4DsDE4
 1FR+lhjw4IHw5y9y7l5GArI4qzWehXvJyYjOuLkxz9pmxvPzUG4XY2b09lk6Pwyu2RB+
 ODELPyDN3RLj+U9Etmhnbn9qp5R0Lddcsvg7CIjEQmHco0xePZOp+PaC9R52GOjM+j6c
 7qxrbkCNYVmmHQ+LQCzlUBPLzJww69wMH0bK4pNK/W/WjmigrPNU5RlY2EQPeXtPD8Kq
 xwvEMDEgqGyY1o+OcnuwzhX7FiYbUuprKho8PMNE/1dHDZDmZqjYCXZ1FE8khnENFvlX
 77DA==
X-Gm-Message-State: AOJu0YzFG0VEt/X1Max0/R12ctutai4NbtP785OOxZ3EAAM1/VfPZWbc
 cZwZ6Z5OxKp7K35/n8v+Kez9l+ZLVfZTKFMmYsmiRqFYw81NZ23yq9lr
X-Gm-Gg: ASbGncsfgRz3Dt/e/wZ8dK35xV+6apzCky6wV6XxSlK/burLBN9d1Sar4wyFSjxtwhT
 817b5HvSWlWJXAiLUuhXKP/7laGLPcWkDnLbJc97CQPcHvHxSxx0SU3buWanGW2EdbjHmB5I9Um
 aXZ2fa3vwUqomDzj/bP5EiUNZ8dTc9mHkp7JXS3YZmAt6oova6f9/ew4oSVfLHRxGzTPzXSFWSj
 L2HSWHglVdpN3Hd3PBwfQjYFeGLEsmk/1N2cisooVoVTNcODH1vFxu5It91o7JEPG0X/M6kXWX2
 BPBhFYbOfmZPr/qtFsXfITPdzPF8MBQwAzIsp+Tu4LhJpd4zEbrLY39jQ/MsS7DPVO+8HyAzt2M
 vigsviTJa
X-Google-Smtp-Source: AGHT+IF1U7zcwkrjyL+mTPUEXOTfJlfRq/xIOWfKamLxLNqu9o/HbtLaDxpe2LIb2O6lVX5TepHIyg==
X-Received: by 2002:a05:6a20:9495:b0:21f:9b24:321b with SMTP id
 adf61e73a8af0-21f9b243595mr3956104637.20.1749737384135; 
 Thu, 12 Jun 2025 07:09:44 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fd6296164sm1166644a12.42.2025.06.12.07.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:09:43 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] toradex-smarc-imx8mp: add SPL_STACK size and
 SPL_HAVE_INIT_STACK
Date: Thu, 12 Jun 2025 11:09:23 -0300
Message-Id: <20250612140923.20497-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: Hiago De Franco <hiago.franco@toradex.com>

When the toradex-smarc-imx8mp_defconfig file was first added, SPL_STACK
was set to 0x960000, but SPL_HAVE_INIT_STACK wasn't enabled.

This led to SPL_STACK being correctly dropped in commit 25fefa05d732
("configs: Resync with savedefconfig"), since SPL_HAVE_INIT_STACK was
missing, which ended up making the board not boot.

Fix this by adding SPL_STACK back and making sure SPL_HAVE_INIT_STACK is
enabled.

Fixes: dde53eae88d6 ("board: toradex: add Toradex SMARC iMX8MP")
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
Fabio, Tom: this is for master please, thanks!
---
 configs/toradex-smarc-imx8mp_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index ca7d9b56efbd..25e6d9623c1d 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -16,6 +16,7 @@ CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x960000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -51,6 +52,7 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
-- 
2.39.5

