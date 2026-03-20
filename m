Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FBA1099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF9D840AB;
	Fri, 20 Mar 2026 21:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y0hpx1dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 250EA83FF9; Fri, 20 Mar 2026 21:53:42 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234E48407F
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d750eeaec3so479716a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040017; x=1774644817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=b9cifnnfN6OL/CTtusPldBDCZYpJAApMtaIlmKQSEyM=;
 b=Y0hpx1dy6XfbsLhvZ7/XqIUOHNNltdUNomCf26YPBOltDZSSA8wUsKRvG5ml9qnkJI
 1NFM9rqC/enwz7n+n2xdk7WSUyO/y2JbyRgcqH5X2OYXZEi3dsgEo2wvcgbGrzSDBxxf
 6VFyKaOiGrFdarJRu9Vliywc2fugVoIyrjBIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040017; x=1774644817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9cifnnfN6OL/CTtusPldBDCZYpJAApMtaIlmKQSEyM=;
 b=NVfyvpiOsWqSWVu1jp6vH5RDb5NEFIa6dDgr7kKKHayb8xpHRXNVt7yIrBJX+KZgPE
 WFRiYkZX5bKyOw+IubCzPp6zxKAP7UhQhml/jgwwauSvcuRWs3pwI17duRpTGcGX2PGm
 nhZhd538TKwg3GKHW6tfPaQi4Gk/j3MbsipkqalcYU4FWoXdQxvQ3Y8YcwU9kiiDkvZY
 lMWQcRZUWNZPvj+fj+FXlkSRcUzdPJ0Vl6XOqWDMWyDhyfZiP62KewTXQ/uaQ/IdUIBf
 sFulvP1KgXYPHxZrSBrYMwRM3Z33UYEJrxBZRkTw3KW3AOQWkuljbKAMDFAjqKVWmJF5
 r1ag==
X-Gm-Message-State: AOJu0YxDGkSpdOnfZHpVEEbdHKIGPyCDxvrs3DBDREJKYRXx5rSVBOGH
 Acjr2oM02WFsN0bD25vA7ellI/Ssvi/JWareTaHjwVrTf2mS/8fUT7VKU2FSoXnB0lRnDH70YQX
 3GTR7Y80=
X-Gm-Gg: ATEYQzxDZVPdOiSk5JcS3cJIuFF7hEzwsNIs92j2B/JHYYnN+xtDs7DbudvB8uDowLY
 pXLFfxKVNzC93I60t6Mo5aGOHJo45b9DVV32DL1/JZ210d8X8mtt1V8d0oRCrF/wSLZeFCAW9C9
 viyiqItur4ij6EF/iWQy4h0zxQ732LO8mQLXuitS5WfBDRRwwkTxshCLFzqNlnr2JVbW62BxXDV
 gGRZOGJzA1tNiN0qWoe++RmzJyyA65per3jtmLd2uxXSmrp6eBPCpjjWjLkNOzJweM/qcV0JbGi
 SlDGAxq6J6Q7rRwvKrSqjgzhdtHk4Ra9Ma4gUJ2CWvhhoEPXsT8xf7aZssewUCnhI8rLJscfXe1
 Bryk7gWz64pieHpRdCY09ML00+s3WGfXIJbKN4kKtOagkjlPg8DRTDpCaa1WM8Xc+hO5I1G8ZR2
 +evQ8i0JDwVkuqh2FUeskx7KdxrzPbvso8ObIqIxLzfkOBvcCeOG/r17ZvaFPUVqbNHY7qS85TI
 TxZYy1aeIwLf5Lb6+dEsdbREhXtse0WpuINU4v1s1f0VPIEQKc=
X-Received: by 2002:a05:6830:8384:b0:7d7:d702:401c with SMTP id
 46e09a7af769-7d7eb0baf03mr2941674a34.32.1774040017497; 
 Fri, 20 Mar 2026 13:53:37 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eae62322sm3034768a34.26.2026.03.20.13.53.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] env: Make more use of the ENV_SAVE_PTR macro
Date: Fri, 20 Mar 2026 14:53:35 -0600
Message-ID: <20260320205335.3788760-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With commit 82b2f4135719 ("env_internal.h: add alternative ENV_SAVE_PTR
macro") we introduced the ENV_SAVE_PTR macro but as explained in the
commit message, left full conversion for a later time. This commit
makes more progress on that front by doing the remaining easy
conversions to the new macro.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 env/eeprom.c  | 2 +-
 env/nvram.c   | 2 +-
 env/onenand.c | 2 +-
 env/remote.c  | 2 +-
 env/scsi.c    | 4 +---
 env/ubi.c     | 2 +-
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/env/eeprom.c b/env/eeprom.c
index b290b1013e1c..f4cc29093768 100644
--- a/env/eeprom.c
+++ b/env/eeprom.c
@@ -175,5 +175,5 @@ U_BOOT_ENV_LOCATION(eeprom) = {
 	.location	= ENVL_EEPROM,
 	ENV_NAME("EEPROM")
 	.load		= env_eeprom_load,
-	.save		= env_save_ptr(env_eeprom_save),
+	.save		= ENV_SAVE_PTR(env_eeprom_save),
 };
diff --git a/env/nvram.c b/env/nvram.c
index d49cd0f337a0..18f0a0aa1fbf 100644
--- a/env/nvram.c
+++ b/env/nvram.c
@@ -65,6 +65,6 @@ U_BOOT_ENV_LOCATION(nvram) = {
 	.location	= ENVL_NVRAM,
 	ENV_NAME("NVRAM")
 	.load		= env_nvram_load,
-	.save		= env_save_ptr(env_nvram_save),
+	.save		= ENV_SAVE_PTR(env_nvram_save),
 	.init		= env_nvram_init,
 };
diff --git a/env/onenand.c b/env/onenand.c
index 8c349ef5ce6c..59b523e06c63 100644
--- a/env/onenand.c
+++ b/env/onenand.c
@@ -107,5 +107,5 @@ U_BOOT_ENV_LOCATION(onenand) = {
 	.location	= ENVL_ONENAND,
 	ENV_NAME("OneNAND")
 	.load		= env_onenand_load,
-	.save		= env_save_ptr(env_onenand_save),
+	.save		= ENV_SAVE_PTR(env_onenand_save),
 };
diff --git a/env/remote.c b/env/remote.c
index 0cc383c23602..c8ade18c0b66 100644
--- a/env/remote.c
+++ b/env/remote.c
@@ -56,6 +56,6 @@ U_BOOT_ENV_LOCATION(remote) = {
 	.location	= ENVL_REMOTE,
 	ENV_NAME("Remote")
 	.load		= env_remote_load,
-	.save		= env_save_ptr(env_remote_save),
+	.save		= ENV_SAVE_PTR(env_remote_save),
 	.init		= env_remote_init,
 };
diff --git a/env/scsi.c b/env/scsi.c
index 207717e17b16..e56891a98993 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -108,8 +108,6 @@ U_BOOT_ENV_LOCATION(scsi) = {
 	.location	= ENVL_SCSI,
 	ENV_NAME("SCSI")
 	.load		= env_scsi_load,
-#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
-	.save		= env_save_ptr(env_scsi_save),
+	.save		= ENV_SAVE_PTR(env_scsi_save),
 	.erase		= ENV_ERASE_PTR(env_scsi_erase),
-#endif
 };
diff --git a/env/ubi.c b/env/ubi.c
index 59bd96feb488..347ff2346edf 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -219,6 +219,6 @@ U_BOOT_ENV_LOCATION(ubi) = {
 	.location	= ENVL_UBI,
 	ENV_NAME("UBI")
 	.load		= env_ubi_load,
-	.save		= env_save_ptr(env_ubi_save),
+	.save		= ENV_SAVE_PTR(env_ubi_save),
 	.erase		= ENV_ERASE_PTR(env_ubi_erase),
 };
-- 
2.43.0

