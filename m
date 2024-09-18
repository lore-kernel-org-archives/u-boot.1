Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D35CCD191
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 09:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D5CC88ED8;
	Wed, 18 Sep 2024 11:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ONkENbsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D643788ED8; Wed, 18 Sep 2024 11:04:05 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFBF888CAF
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 11:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53654e2ed93so7235698e87.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726650243; x=1727255043; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=207garyeJyw8m4AOYg9/4EyEzJzACjfQNztZPwSO0YQ=;
 b=ONkENbsiFRU+ZdSEo2Vr9f85+zc+3s+KCjB6md07AOgvcyvVdAQGEuKLWyk9nQPWAK
 eNv0EOU1u4bw2QAu5PzMn1JcTMz0aN0lHGLSuMWmKYPQkN58xFyWa5W7KM/JrkVWPuXO
 XUa0v3St0rIjIvsAIMPt6NeAVrPGPcCcuzsTSglK04yTLNQSeqNgI6VNy7bwH/BfaE2B
 S1+CyN1lLvbWmODEJ2fDmzhvLSK4zb10q+cQL9S3nqCi+jpmrtXspY9yN/Q0hyGRNVYO
 Y2cpsmCTUEP/UauiF5ZsDfO3+o9/H5emE7zyuUH3jMMlp4hd7MKfbuafdLvtvmlNriAB
 1Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726650243; x=1727255043;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=207garyeJyw8m4AOYg9/4EyEzJzACjfQNztZPwSO0YQ=;
 b=g/y8BWUlNqY9gZ4b5KeEawNl8/HH4CdchBRo2sCVGNq1Zvvt19yWXgU3Z/8OGW5xwF
 n+x2XLLh6KA/furE9uhG3UImOv8uXqoZiA8vgXxXUrj+/88oJ1thmXe5ubE5kOtwJuLz
 ild+5tL1Ly/bblEqcekSMYhSBDegMmkyZD3lMwlMwZ0Njkm0fW7uhF/1neiwhx3YxgX6
 pGiDFdUb/XwLvgeC4MzRsC+sZGz2N8RINaXJecR+6IPG9CMA7aDKk58EHjC6B3tExSuF
 oheFrX1/xydZfewc5P9aJa2XIXefrVvm2L2jmtiGUFgZaEAGA1hiX3w69lx2FUL/JjzI
 HsHA==
X-Gm-Message-State: AOJu0YzJkU4o0IUBertnl2yApBVRAYOaZe4Wxb/hZJCJKabf7rD1sOQD
 T/VfZ++rtmE6FkuKx7Q7U9diMVDxv/y3susFgLJQekwDfM+DuUjobEyeQA==
X-Google-Smtp-Source: AGHT+IEeHbA4amtPxaGyUvnInFNNr+9YXl5h5Nz5FSdgu/n0VO+ByFIieYPgN1u/Hsa6TMtuTpjo/A==
X-Received: by 2002:a05:6512:b03:b0:536:53c2:8179 with SMTP id
 2adb3069b0e04-53678feb22dmr13307344e87.37.1726650242215; 
 Wed, 18 Sep 2024 02:04:02 -0700 (PDT)
Received: from localhost.localdomain ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870a8635sm1467116e87.217.2024.09.18.02.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 02:04:01 -0700 (PDT)
From: al.kochet@gmail.com
To: u-boot@lists.denx.de
Cc: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] Makefile: pass external DTB provided by make variable EXT_DTB
 to binman
Date: Wed, 18 Sep 2024 12:03:59 +0300
Message-Id: <20240918090359.743-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.17.1
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

From: Alexander Kochetkov <al.kochet@gmail.com>

Yocto build is using EXT_DTB to repack U-boot during signed
FIT kernel creation. First, it takes the DTB from U-boot, than
it creates signed FIT kernel image and places kernel key into
the DTB. After that it executes:
    make EXT_DTB=/path/to/dtb/with/kernel/key

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 Makefile | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1c754ceb595..21b47cb2b59 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,7 +1367,16 @@ u-boot.ldr:	u-boot
 # ---------------------------------------------------------------------------
 # Use 'make BINMAN_DEBUG=1' to enable debugging
 # Use 'make BINMAN_VERBOSE=3' to set vebosity level
+
+ifneq ($(EXT_DTB),)
+of_list := $(basename $(notdir $(EXT_DTB)))
+of_list_dir := $(dir $(EXT_DTB))
+default_dt := $(of_list)
+else
+of_list := $(CONFIG_OF_LIST)
+of_list_dir := $(dt_dir)
 default_dt := $(if $(DEVICE_TREE),$(DEVICE_TREE),$(CONFIG_DEFAULT_DEVICE_TREE))
+endif
 
 quiet_cmd_binman = BINMAN  $@
 cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
@@ -1377,7 +1386,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		build -u -d u-boot.dtb -O . -m \
 		--allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
 		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
-		-I $(dt_dir) -a of-list=$(CONFIG_OF_LIST) \
+		-I $(of_list_dir) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
 		-a atf-bl31-path=${BL31} \
 		-a tee-os-path=${TEE} \
-- 
2.17.1

