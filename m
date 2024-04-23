Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1289C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 07:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E92588A97;
	Tue, 23 Apr 2024 09:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TkXu6sFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5AD8895C; Tue, 23 Apr 2024 09:22:35 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5954D88AA1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 09:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so5406826b3a.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713856952; x=1714461752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9I9ej1ACfSJFlnxItUMQDdtZJmE558oByWFcT4f+WTU=;
 b=TkXu6sFe3dHTsbsDtZxOMT2vZ7Uvsikjd7LDxFWKy5WxpI+xPrLVCcGeWD+Y3/qsZu
 SRpaSkPJI3jtE0A9VBUiAADaHMZ8lx678WSb9yiWJxtwA8ktA0z97N8MbUOY3u92qlj1
 S7NQ2d0Qoaivq68onyurcjitN2sD9wPPt/9JClDZXs2/K3t/bHaZ95CWzT33YrmL2e8I
 AZoZrLObGIg6vEy+LwRUN1WjjaGydaB2oPT1xz4zN7vfi2ty1c/ZuOq9PRoH/j9gmfxM
 kesrLKND2qXHVZ4enmmcE4+W/kQuqABUh+Cb74d/PxUCFTdMs2BVhh80SLI5WIW14+I/
 iJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856952; x=1714461752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9I9ej1ACfSJFlnxItUMQDdtZJmE558oByWFcT4f+WTU=;
 b=ti+ENQXyOv3cmxMgHoIFcLHwoQBvz6fU9lZ0forMck8GNyXQBOUvXIBy3k/A6kIl/d
 yEdrXE1hZIORvXTsnCQD2x+TbNi7kVjpwRzHS6X6Yh/95b4MapcDQvbpjAaIpAD5cQ8a
 1N2+w6Y68ztcvAksfeaetmO6SxTg6DUDh6qkMmj3Qw1M0uW+jX1lA64VovQjPaI/VbtU
 ty9aveQCMR3DhU/Iwl67MwLpF2N5RmmD0QmAm9Df9WHCqLg7maeFqyxnRFNw2mkgV9qx
 IXYNsynigJqG7j9xU+EqQgLjBDLLeuI1M/zjauAOCt+t+ujd1VkXc8nsfByjj+PetQl6
 5Ftg==
X-Gm-Message-State: AOJu0YxEOxaOtuv7I3LCv/1LA3A9syQy4jtM+/chN//G/6A0C+yj1M0J
 Qw4eXrj+YAMQVETtEiaiyY5jk3abjwc7z58s1pvVnR6N1fOagd4L
X-Google-Smtp-Source: AGHT+IH8XYC1yR0vzLEOaI8dJnzeW5Ca/l3muFmKDgvaATA99Zc51gJceVXrNOeOEmd+mhVpXIbtzg==
X-Received: by 2002:a05:6a00:2da0:b0:6ec:ea4b:f077 with SMTP id
 fb32-20020a056a002da000b006ecea4bf077mr16838565pfb.16.1713856951793; 
 Tue, 23 Apr 2024 00:22:31 -0700 (PDT)
Received: from localhost.localdomain ([180.217.143.235])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a634c11000000b005f0793db2ebsm8746695pga.74.2024.04.23.00.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 00:22:31 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: YSCHU@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 KWLIU@nuvoton.com, JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] configs: arbel: increase u-boot mapping size
Date: Tue, 23 Apr 2024 15:22:09 +0800
Message-Id: <20240423072210.1926141-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
References: <20240423072210.1926141-1-JJLIU0@nuvoton.com>
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

When u-boot enable CONFIG_SYS_BOOT_RAMDISK_HIGH, rootfs image relocated
from FIU address space to memory address before jump to kernel.

Since Arbel reserved memory from 0x00000000 to 0x06200000 for tip image,
and rootfs image may too large that cannot found a suitable location
before 128MB(0x8000000), so increase mapping size from 128MB to 192MB.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 include/configs/arbel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 576ee37ee4..d8ccc45968 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -7,7 +7,7 @@
 #define __CONFIG_ARBEL_H
 
 #define CFG_SYS_SDRAM_BASE		0x0
-#define CFG_SYS_BOOTMAPSZ		(128 << 20)
+#define CFG_SYS_BOOTMAPSZ		(192 << 20)
 #define CFG_SYS_BOOTM_LEN		(20 << 20)
 #define CFG_SYS_INIT_RAM_ADDR	CFG_SYS_SDRAM_BASE
 #define CFG_SYS_INIT_RAM_SIZE	0x8000
-- 
2.25.1

