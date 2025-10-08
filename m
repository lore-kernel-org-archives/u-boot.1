Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A60CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 17:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4400A83927;
	Wed,  8 Oct 2025 19:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b5dCN2SK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D898983929; Wed,  8 Oct 2025 19:44:27 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8148F8391B
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 19:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b523fb676efso24536a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759945464; x=1760550264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=G42N7sIPqLYmjlIGHvy3Z2vy02gS2pFQJTOdd+tGYks=;
 b=b5dCN2SKqUYRlwMA4kMziDN2NQjTWXEIi7Jyh8GtLcfl1UZxy8DwLA11bBuMEl2PTL
 Z6feUGtzixx54FvfKDDw6luhF2U5qlptFiRhmCMudzgezh4bfdB2EA3Dc9dWX39GctIp
 +j6Mv36lDeGdg1dF3LqYOBSBar5KMwnIlUkMuEC/KSqJ/SnQC63g1e7g3Cq79wyg8ix+
 NoaXbEXbnYKVTc6Om8+sltSfX8rXChvY7sjjQgJhdKSKVxtHNNwumFNvXXmJSEmp8SiI
 g8MtXB6N/RBIWrQMBJGePdPBZifqDg1sG53EgLZohxm9rqpTQc60uMNaWRDgj7rwEMRX
 7UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759945464; x=1760550264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G42N7sIPqLYmjlIGHvy3Z2vy02gS2pFQJTOdd+tGYks=;
 b=lg0uxRJ7FNEJmflUVkRlwfak5AoVK4cnRNba4KaQDb2uuYO0BWeDqY4dYAGBHCRJ+k
 BRoQv52dLX6VSpiIRmrZmNGnEEEMuBT5ODeLTdA9OXnm9cREbrP4MhWiAL/yqpOGSpM0
 4Or/4pYkmK26UGLXvBfFL5erUDM7stOb7eEKsU9lWvi2n3gNJvDSABK5MkmI8uBbNwcK
 AGs/Jma5tpipMJPTvgGd0QmP2Pg3IqHfx1FXdDlOsiRbKxqBX9EEwGjiJRYbIep84GM4
 +kmakicn/fhyYIiz528VKTc7BdvrlJ8oh2dInyZ85tXrEw4uaIItIrp/HFtkG8+25GE6
 hSPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3b8mXMBMb8Lv+Lr7n5EffSzhyIlKaSbk1y7SwdIYBsY9sM6+fJkeF62xMNuHDg2wx7IOwqVE=@lists.denx.de
X-Gm-Message-State: AOJu0YxQyAwhUjkBBSitJ9oAnDzC8wNnT0gD3viHsHu52ceVj1SY7y9n
 UgICd2zNkqPQvLpxAeY11f60HWnMAu5NA2jDH4u/aGzyatsc9KELMU1UbqtqzGY9cbwnaA==
X-Gm-Gg: ASbGnctmsez8gL6dml6aMN/7P3e/9533e73wtcrKxd4MYd59Vtfgi3soO7CVd9QEg4G
 ghVm5FUQCuSf2BKNakyVl2XJPeOsMT5F3S4nscNBh4HeR4jL8/ulVlaB0bgRCijI46TLDpHRhMv
 YhNir2AvwyRm8ITW9F3Ba6xprd6/3yXEvq75ZeNtzQevzGtLt2hGpb8yLIirP+pOGLXEQ1vywxh
 EQJA94KoR+ttVOFJDEk6cVgtQj8QV2lluiEsSIsDs+s3+NWJpJN+rF0iGH6e3weSqJwAhrHcGIZ
 utnewdtGM79qNezLh/AnTxYqqqdGjWr/oQ3VwWXKrgWWPOD8quCqUeG15o4YXmFsPWrd7aJs2Lu
 1YYIp6Nb9DFDKbs8Zw9CkIyp3pKd1D+ZlDZIXchEABIVQXAdWDOnjGgRLh/PIzht0aZjpL3MkGP
 jVlXaxT4o=
X-Google-Smtp-Source: AGHT+IEh4nyRuO8/CYxg0PSp+iOlqc9IzjsOx3qqwCBxEC+S0d/25SOBSbAoCJmkfuna5rPQSbZv8w==
X-Received: by 2002:a17:902:dac2:b0:290:273f:1073 with SMTP id
 d9443c01a7336-290273f12a2mr62248625ad.20.1759945463754; 
 Wed, 08 Oct 2025 10:44:23 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.31])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f36738sm3117545ad.87.2025.10.08.10.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 10:44:23 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] cmd/dma: documentation
Date: Thu,  9 Oct 2025 01:44:08 +0800
Message-ID: <20251008174408.381-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

This explains how
to use the new U-Boot command 'dmareset'.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 doc/usage/cmd/dmareset.rst | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 doc/usage/cmd/dmareset.rst

diff --git a/doc/usage/cmd/dmareset.rst b/doc/usage/cmd/dmareset.rst
new file mode 100644
index 00000000000..cf48ad91c5c
--- /dev/null
+++ b/doc/usage/cmd/dmareset.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: dmareset (command)
+
+ command
+===========
+
+Synopsis
+--------
+
+::
+
+    Usage: dmareset <channel 0-7> [<channel 0-7> ...]
+    dmareset - Release PL330 DMA channel reset(s) for SoCFPGA
+
+    Usage:
+    dmareset <channel 0-7> [<channel 0-7> ...]  - release reset for one or more DMA channels
+
+dmareset channel
+----------------
+
+Release the DMA channel reset *channel*.
+
+Parameters
+----------
+
+channel
+    DMA channel number
+
+Example
+-------
+
+Release DMA channel(s)::
+
+    => dmareset 0
+    PL330 DMA channel 0 reset released
+    => dmareset 1
+    PL330 DMA channel 1 reset released
+    => dmareset 0 1
+    PL330 DMA channel 0 reset released
+    PL330 DMA channel 1 reset released
+
+
+Configuration
+-------------
+
+The dmareset command is only available if CONFIG_CMD_C5_PL330_DMA=y in
+"Shell scripting commands".
+
+Return value
+------------
+
+If the command succeds the return PL330 DMA channel $? reset released.
+If an error occurs, the return Error: channel must be 0-7.
-- 
2.47.1.windows.1

