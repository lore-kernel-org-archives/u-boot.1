Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7812DC47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 12:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A3787A23;
	Sun,  7 Jan 2024 13:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jyhn5FUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3049787A1A; Sun,  7 Jan 2024 12:27:55 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70E587463
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 12:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28b6218d102so889006a91.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704626870; x=1705231670; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yqPcJ8kA6ZuqJo455dagUSW+H+A9+IZM9U3hAG010xE=;
 b=Jyhn5FUq3oPpdZ1VNUeRtklmx2vdYlZ0qu1Ppzkb9NxaDV3TDnwePfoi0mUdoqKRw8
 7laHszbkDv3Y6k/E1+jmI47GBVx6Q+z8HFXriSB3I7VZjRVV6aF207D4WIzZn+GBKy8u
 mfHrwsWueHlZmKEqcmxRifQ5XMk57iGsJbGB2kdqVCluCBaStzoatwpAYZz9fpA1tLOD
 cL/JH+3hpYhV2TVanyf6dmlIsr3rF4xtNxv0z2YPFYST3R0Jg+yRY0gku6DyjlLDfLkk
 xmfPd8MKa0e98RsD2GLd70/PDmMxoJ1jSQZ6MRSpfsmTJ+RzYyD1af6/DFZj5HaLq0rT
 GYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704626870; x=1705231670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqPcJ8kA6ZuqJo455dagUSW+H+A9+IZM9U3hAG010xE=;
 b=Iyivk0NSAYrvrxr/r7zgBF5UEWn6r+gv7p/UEQaKyb9nt8kZh3LeUSGuvQarGQocC+
 cdfjp/f5X9NWeA1JagBhhBMFTN0Qv1ns0+M2inzKqt2ufn9Oi9RkepuXNDLK19I147G8
 pykTXKdZTR+/SBcGVCrZa/DifFVjxkXQTReCZZDsjNiPY2ZNEXsT2Ob68ycxwZFU0rxM
 73t7DxB/+k+fbSvCndfWKwJgN35aqhCgSSfZEleRx4lmWicsJ7gYQs5prwDZGH3yzW0J
 stL0lSKJ53n37Lge3iutOC/SCLFZHoMDwK9jh2otJc0liemZEXEHCAjRr8+bE0FfQA/z
 g/IA==
X-Gm-Message-State: AOJu0Yy79VymhE9Udo4a0p+lEV28Am9br8u5raDVECw83xdkQPnWD6qX
 N+eUlnTnxFC7eYbbnuy0pW3q9TD10zs7qTLz
X-Google-Smtp-Source: AGHT+IGe7IfNxt6tnZnJlxot7ObtAxnrhSYe9WS+Pkr1e4ps1OJ1dUIK2KBKD9Kn26RgMcyuaK3Yzw==
X-Received: by 2002:a17:90a:d911:b0:28c:9f41:2e9 with SMTP id
 c17-20020a17090ad91100b0028c9f4102e9mr798859pjv.58.1704626870520; 
 Sun, 07 Jan 2024 03:27:50 -0800 (PST)
Received: from localhost.localdomain ([120.204.188.187])
 by smtp.gmail.com with ESMTPSA id
 sf15-20020a17090b51cf00b0028d435cc2cbsm1279253pjb.15.2024.01.07.03.27.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 03:27:50 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/4] configs: milkv_duo_defconfig: Add initial config
Date: Sun,  7 Jan 2024 19:27:09 +0800
Message-ID: <20240107112713.61966-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240107112713.61966-1-seashell11234455@gmail.com>
References: <20240107112713.61966-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jan 2024 13:25:04 +0100
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

Add basic config for Milk-V Duo board which make it capable of booting into
serial console.

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 configs/milkv_duo_defconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 configs/milkv_duo_defconfig

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
new file mode 100644
index 0000000000..c4782639ef
--- /dev/null
+++ b/configs/milkv_duo_defconfig
@@ -0,0 +1,24 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x820000
+CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
+CONFIG_DEFAULT_DEVICE_TREE="cv1800b-milkv-duo"
+CONFIG_IDENT_STRING="milkv_duo"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_TARGET_MILKV_DUO=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="milkv_duo# "
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
+# CONFIG_EFI_LOADER is not set
-- 
2.41.0

