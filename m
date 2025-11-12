Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E30CD4847
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 21:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114C083D4A;
	Wed, 12 Nov 2025 22:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P7F6HVzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0394E83D6C; Wed, 12 Nov 2025 22:19:47 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E377883D0D
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 22:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-450252e3bceso26017b6e.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762982383; x=1763587183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZFOuiWJGiu9qy37ovCXyUr3s1hhf36jjCJrPwF8TBA=;
 b=P7F6HVzCbB1QnD/JrzkKCuiLTmMQCNcbW6Ro773a8sTBoecPyOIYyarJkRNSpg7lxd
 HLCCraOcrxwgLub0hp0/hUE2g9Z83Ql/5P1iJ4CVPjtvwiUujf3untA4DDnQntg415xZ
 aOG6kdKoFSSyaFrlu84qivpCCMSLLo8vZSZpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762982383; x=1763587183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ZFOuiWJGiu9qy37ovCXyUr3s1hhf36jjCJrPwF8TBA=;
 b=vM9pmlI6knKvTLMw4/9sYHjKxbuq4T1Cem6LZO4AwkVDYzR5xwXcW6c1js49u+kF+K
 LYJ4uk652i4gmUFhHGGLEKe5Pg/YNa0xeNAdB68b4n22Hy80xHW/sP7rMI1y/+7M3vtI
 15tE8Z8MRD+V0Yl0rb8W7kUE9Nsrd50hjLXy9Oe1OBok8l+4hkCJrti3OJqM62Rnucz/
 /lz39dOEKln6xovRu10h2BnBQHBl69fTCSWfOLRvcMrlMyUN10fGrsazqHHztOQ5dK3O
 f54IFHvHBX0GGg0FYsHixmftUD8aF2SJH176kGqR2XKsf6upHFKzbFr5ErCXRzZBvbvw
 qkIg==
X-Gm-Message-State: AOJu0YyUtbQYjWZGyxWB34BtnjinoJ0McTfYqkUmlpe4+7oDq/arayjv
 sWmkB/tpBsn1N1CnUuT3++oeKqocLvWC6kjjE9SxsdBNCZ5G4RseluxYLcpi6k4ksyhL+ePsxWA
 l6KTi26k2og==
X-Gm-Gg: ASbGncuYpX1NkoWQGuRmAEctL1m1Hl6u88F9hgSessLQHRf+1N0Qj++Hc3bwDx1rm6a
 gnkqmJBOGkhDtmeIYc9jvRlFW8nhLtgyB67FRDAlZQvoShXs7Wevs0F+pqKuNEftv16iz8ik8Gq
 mzsgINiDkUVJfP0JYaUqyDvceb6KFl+RQ/YmdIlzDueoX6oMRLnCAHSTWn1LTu+RemdcGLAhmoS
 uXRF8OCheKU7R8q3AYgm6k2IrmlRTV1ECkIWDT2RFpSEZIyM9X0mbpmJJGhJhzaWY6w5+SR3gRz
 Bih09/gatOnGvkGLQqNumORykZh+G8z+f0BgMKjnlB752IS6i4f+dQcj99jWUh6hfkiscEn9mwN
 N4BmZprU36MAGL3LzhwE8J7sj5mWl6hiC6OpP6Ea6KTFr6htaS3oAQZ3mRgQ6a3VZeTghShiLeQ
 twFWs2tpH9s/s4p/1OjY5QONjfBbcbpqBdW74FcbFBYYrmdDN1fMfP
X-Google-Smtp-Source: AGHT+IHzAp26E6WcScJUQsu9PB+wrxVZgHQ7uBHH8lyFnUrJTYH1J+Dqtt17qvblfF1FycjDJEWUmA==
X-Received: by 2002:a05:6808:1794:b0:450:10b:a541 with SMTP id
 5614622812f47-450745ae582mr1962818b6e.33.1762982383655; 
 Wed, 12 Nov 2025 13:19:43 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450027c574csm8750328b6e.19.2025.11.12.13.19.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 13:19:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] fs/jffs2: Make depend on !64BIT
Date: Wed, 12 Nov 2025 15:19:42 -0600
Message-ID: <20251112211942.1429056-1-trini@konsulko.com>
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

Building this code on 64bit platforms leads to warnings (and so errors
in CI). Rather than rework the code, as this is a deprecated filesystem,
don't try and disallow building on 64bit hosts.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig      | 1 +
 fs/jffs2/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5b9c13d85e76..278c6eaf0f3e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2912,6 +2912,7 @@ config CMD_FS_UUID
 
 config CMD_JFFS2
 	bool "jffs2 command"
+	depends on !64BIT
 	select FS_JFFS2
 	help
 	  Enables commands to support the JFFS2 (Journalling Flash File System
diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index 3bf01cd03137..dede59ee3362 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -1,5 +1,6 @@
 config FS_JFFS2
 	bool "Enable JFFS2 filesystem support"
+	depends on !64BIT
 	help
 	  This provides support for reading images from JFFS2 (Journalling
 	  Flash File System version 2). JFFS2 is a log-structured file system
-- 
2.43.0

