Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C661AC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E3780A0A;
	Thu,  6 Feb 2025 14:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JeeZXQ8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29F380AE1; Thu,  6 Feb 2025 14:09:18 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CB680A0A
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 14:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB7693F868
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738847352;
 bh=xt0NCrZhdF4uN4ywXOmImtcaPH+Vxza6SJ3j5HNAX0w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JeeZXQ8whqOZ2ETSNW9zTPdERp/mqzmVIzl02fQ1lmtf68tW/SORWW9j+gSGNnzrK
 MxxOOfTgLldbR70Wqd97U9gu2cI86SsPJZOSSJh2ExBnZ7kHX0lI62vayCua1MuTOK
 hhfsEA2tsKaJW3o7Hr1Qc4Pv55Cf/rjujPdoXiGNF9aaL0bap4gy9cNQ+wqEfH03Mt
 UypX/LQdbKaY2L7grHkbEC6r6xN1IEzU8G4J3uS3QMa6vGLlTt4jtsZRMW4iJL3rR/
 TGbZjeHU2kFXcmJBm7cjS9Qa55b8XD7e3RmPpQdtIJ8qs0PYF50hfMB2/6D4TW3hFj
 /P1uuStKx8xUw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dae3db3bcso478680f8f.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 05:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847352; x=1739452152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xt0NCrZhdF4uN4ywXOmImtcaPH+Vxza6SJ3j5HNAX0w=;
 b=TR3+AvxjMHi6PguksxSsGFCAOawwnQQnEFP+LabX3Jeog//zIUGfPlFYQsgWUw/IiT
 mMOv34SyVgKH2akiBvRBd1rVMG3uUFA7zwmO+KjcPN3ZboyGF03Umu7QtIl8e9UN1LmC
 5rRtvW2F58+UrckKfxLjQIOTFb2dFVd9BWldwYZcznYgxv0czliyYHqzHq7C72abZYCN
 gqXwQWaj5leiJDOJgwyMV0Xlq5wdvOJgzH8jl6UZrOcCs1YDyh/6nf3DHTifzYHjvpIg
 h0dKsYNE0M30iZ9SjWwrRdrQ9CkhahTcN/hrCMNuNE2vBtthM8TjlASs5pNiZEzPa53G
 6KTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAvOOXla3MkJWiuHxiZ3oyc8I/jhQDbQ9jb9hb7iLTbh9DK2/fBAqHYZ3wIwPMT9hjIgEBdNM=@lists.denx.de
X-Gm-Message-State: AOJu0YxWweVSPiYRw9TWri2V11vwZGU/V9gPrrZdYaM0AsagBZ+B8uoZ
 T93htlMqHxfim3VMHRXH+UcdRV2qK2Umw1yRlOc/3Q85bV9XwBsd+vj3ZFAFQsekrSrCZwUK2LT
 RWLOXpO5o+0Z1kr4VBhUktwN310Jv18tuaQGacaBS4kax5Xs/TWcRLisJTC54W+eGQxo=
X-Gm-Gg: ASbGncuICcrpoEV7YzYeAPCXQO0HKeMzp4pf10K9y4Fg8IrMiVLzV/UjPs2QjocVcT8
 eq6jsVdELuIk7GQKfBqim2aMfzIfX14gSCt5q3Q+xIzt9dpIg5CJQoWpqBoZCwibQQgQYTC0wDO
 JmG8Jdskinr44l8v6+tGwlmz8OeRvq+4j7YtVA3AVoqKTKc4BnEhOwCXFz3feJrLbzjasRp34bL
 YgKq8NvJr/yPrJrH1bTQURMxYF3rSM/nlyXzwtLhxwIb1QETUuLgNy7i/qRNfgp9guLsyZfvMBd
 LnuasZqOZlYutJOcdNuddzkF+XvtBaZilnYdhw==
X-Received: by 2002:a05:6000:1a8b:b0:38c:5d42:1529 with SMTP id
 ffacd0b85a97d-38db491fa85mr4629550f8f.36.1738847352218; 
 Thu, 06 Feb 2025 05:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMv5uk9MKAyAs3NJeJeTnw4lAhywIiqGy2JT6CnVrB/uopSEGoYocB16XsUIEK+RWkgr5SCA==
X-Received: by 2002:a05:6000:1a8b:b0:38c:5d42:1529 with SMTP id
 ffacd0b85a97d-38db491fa85mr4629530f8f.36.1738847351868; 
 Thu, 06 Feb 2025 05:09:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:c45:4917:78ea:f2d9:5d39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dc9ff64sm18631455e9.9.2025.02.06.05.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 05:09:11 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Cyril Jean <cyril.jean@microchip.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: microchip_mpfs_icicle: set DEFAULT_FDT_FILE
Date: Thu,  6 Feb 2025 14:05:03 +0100
Message-ID: <20250206130503.431058-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Variable $fdtfile needs to be set for automatically loading a device-tree
from the ESP or boot partition.

* Set CONFIG_DEFAULT_FDT_FILE in the defconfig.
* Add $fdtfile to the default environment.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/microchip_mpfs_icicle_defconfig | 1 +
 include/configs/microchip_mpfs_icicle.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_icicle_defconfig
index 5ea6cc371aa..f8acaa98672 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_icicle_defconfig
@@ -12,6 +12,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_DEFAULT_FDT_FILE="microchip/mpfs-icicle-kit.dtb"
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=282
 CONFIG_DISPLAY_CPUINFO=y
diff --git a/include/configs/microchip_mpfs_icicle.h b/include/configs/microchip_mpfs_icicle.h
index 5ced45b88b2..0077f6a5f95 100644
--- a/include/configs/microchip_mpfs_icicle.h
+++ b/include/configs/microchip_mpfs_icicle.h
@@ -26,6 +26,7 @@
 	"scriptaddr=0x88100000\0" \
 	"pxefile_addr_r=0x88200000\0" \
 	"ramdisk_addr_r=0x88300000\0" \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	BOOTENV
 
 #endif /* __CONFIG_H */
-- 
2.47.1

