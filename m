Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEB3C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4591875B8;
	Tue, 21 Nov 2023 02:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BXL6HbPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0CB875A4; Tue, 21 Nov 2023 02:31:16 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A4C875AA
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc4d306fe9so11476555ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530247; x=1701135047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0pOwWKtyCvU6lfQQoNXU/mUJNM6UWiWzauvvCP1A+4=;
 b=BXL6HbPTEUuTKZc/3A3kDXzI/X+K+dwqtL3xIzu6fd/MAOO6xbVLOmIfvrZjIiNjsE
 yzWghdEGMfPhBkAab/Sj3IIDfN02db+y5eM1MAHLIiSfvxlTPUrRkPPGhY9Nzsc/ei4h
 YyeFJxVFglOs+Xbk5VrKJZtkBUL1htoKKk/pnu8g/Qu/drfhnPOqHYWBKFaCYJOOb91U
 YU3q1iYxmE9DFbjCBDMrnu3oS5U2sWY7m4SmYdSrJ7oB+YSJZnsOUaRW9xMQX2ukSL++
 pUp3vpODnuy/MEDYc6pojS3xbG/Iwx6Rbt5DQcE/1HlR01axihuO+OWvjCQUJmhn4qmv
 FE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530247; x=1701135047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0pOwWKtyCvU6lfQQoNXU/mUJNM6UWiWzauvvCP1A+4=;
 b=VzokBusaGAJgQdyovDLtXK3jTElA7pXHmCgPkiwgLAMQ619wBny0P8ddL4QVL2L5IS
 Pk4hsE4N0u0smMCa9qk3M/i4mWxO3Gcvyin8jrkfd+na4o0MKwCNHdVy6zPlwkoZ9s4d
 R9eXolREfxVpcpPblkk+Tdytg87qrlzGk1UJslQ0q6r2iCoaRih2auo4gKxtxdL2At/v
 +kSL7tsNgVMdGfUVln6G2uE3u74Sa3lQ8w04n6s5o1N2h9JBAivVxT1rlBeRSZQNq7aF
 Wc7rL7hWP0NwK+ENVZ0l6YW0GXMBZN+rnm9aqaxt3JhDtx+oopvA4jlJYoaynD5zX0Cz
 08Ew==
X-Gm-Message-State: AOJu0YwhhtfQxd+E8RcNZHNwjngI3fxWLCu4eRu2Lu2mYZFXjpvbxY2c
 VUt58ChfCbLgxKpnrSz3wktrEg==
X-Google-Smtp-Source: AGHT+IFMWI4McD/daw9NsnUfJXK+8mUKOrUOdITEccIIlyxq1DV3HVqCX7VeUGyPXV3gnzX5Sbc/Uw==
X-Received: by 2002:a17:902:d48c:b0:1ce:5b6e:bae1 with SMTP id
 c12-20020a170902d48c00b001ce5b6ebae1mr11892980plg.3.1700530246913; 
 Mon, 20 Nov 2023 17:30:46 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:46 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 07/12] cmd: efidebug: ease efi configuration dependency
Date: Tue, 21 Nov 2023 10:29:45 +0900
Message-Id: <20231121012950.156539-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Now it is clear that the command actually depends on interfaces,
not "bootefi bootmgr" command.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/efidebug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 78ef16f4cb5c..e10fbf891a42 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1410,7 +1410,7 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 }
 
 static struct cmd_tbl cmd_efidebug_test_sub[] = {
-#ifdef CONFIG_CMD_BOOTEFI_BOOTMGR
+#ifdef CONFIG_BOOTEFI_BOOTMGR
 	U_BOOT_CMD_MKENT(bootmgr, CONFIG_SYS_MAXARGS, 1, do_efi_test_bootmgr,
 			 "", ""),
 #endif
@@ -1604,7 +1604,7 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI memory map\n"
 	"efidebug tables\n"
 	"  - show UEFI configuration tables\n"
-#ifdef CONFIG_CMD_BOOTEFI_BOOTMGR
+#ifdef CONFIG_BOOTEFI_BOOTMGR
 	"efidebug test bootmgr\n"
 	"  - run simple bootmgr for test\n"
 #endif
-- 
2.34.1

