Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABCACEB2CC
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 11:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372A5842EB;
	Sat, 15 Nov 2025 12:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AAoy7+A/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59EFB842F4; Sat, 15 Nov 2025 12:31:37 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DC9839DF
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 12:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34372216275so3221026a91.2
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 03:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763206293; x=1763811093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rc2YHLrOD1udY/Z66pGzZlfjbBdR8LhkEWq9hcIPIWM=;
 b=AAoy7+A/iQb2tfyPN2E/J7rRGLuyQKYX0FnDc7rzT+pl21TUIQqb8bHZwZZN5yIDio
 NkrarPvvGKO1AYgp68jCIvH/kaWveoUzf5tTT0dHW2Vsob3mMEXeRFwpESJ/NTCAu/1t
 J2GcO4qBQWAxIri97DHHnPiPvx1TnsENvF2iRxvKGm2v+nLOdvgZ9IjZ8RIpSs2m1GJC
 FXZMNS7rbOtuDD1aNM5m5lyo3uzg1Uv1TtgGtdI3/a7HiCNZ8l2TBGBnSCpEcYhoZwLC
 Tgq0pLNV67vVlFsbpx03GJT0luwj89B3n2JWojKSfe6kSIlMPYPXb+iZQARDgwGuZ/+J
 99Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763206293; x=1763811093;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rc2YHLrOD1udY/Z66pGzZlfjbBdR8LhkEWq9hcIPIWM=;
 b=JJjpVWZbw5HO8ktrTdXagBAjZSk18uFeWls3gQii4mVqYvC/AlMTvN3rWfRsqcncdL
 4Hw1sJzyx0aaOzEh5ywqrFjmhRUIvp5tONMX4NsaKqm+2zuk0ZNVAHMqy37JlqzTngJ7
 28CE7ZmpLucIgiXqEHF2V0Ed48bCA18kba9LEwLmmMV7V7J1ZWOYzJz/iLJe39UGoUIV
 BPrwNOWv3XZG+9LEfAYx/oQwuNZAHmb+A+XxXPaln7pFZN0ucyAW34CO0ULnen5dxr5K
 RXZ6PKR5uoifRHifDP9Oj0EXiWLpA9yw/K5Hc8o/1mmSKuWSi1ve7ANaGPXtPck7ShuN
 zdDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu/XlSsM8T/JOmLwFW1e0jwirMtGjDery6mLTMU8rDGyHIVjy9J/MpPL+zsBrEqgIKxiWLbz4=@lists.denx.de
X-Gm-Message-State: AOJu0YwOqXBbZvrOwFsn67gCrXLc/3DcKR/fxK4hCgnKHlIsPAZrynpY
 4Rde15dE37Eq1LCJ9/z3j36pbI/kN61rWFFJT4H49pYFSqNREiI5n++E
X-Gm-Gg: ASbGncvN03m9mvu7GSPIe5KvFrKcPlj+ePvEDT4Xeaa88EVkjDcpK0dBvmGb2Xe/lEp
 taHgDUM3wokKpbkOhpMImL8b7sNDL6HTxp8BtTOLyKBpUlSO85BjkmQQfD/XmNYbH+FJM6JlkEg
 ZZm28cIVnfhHYIccjp3R+dlB+koJ4J9gjy4NbE50TOzxgiod8UMRiY2rzHZZwH1S/DFZqcS3YXl
 j+HnVxixTC7s9i66R3T/8dj1f5Gh+RxqT3cQNaPwIf/UusdCQgAzZtCZWqqa4xyK201Zpo0mUNt
 p6SBXR0ZU7RnAUtTLbYO7IIphNYAxRMLazMMzYvR4VVKE/6QDMZc0T3CLLBpPGe8iOnJy13NABN
 hnPsk8bU4b6dS5cjni6F5a7dUY3JACAZZU5mwrXoQTwM/ss7+5N6LjLlUvRfFLIYg2Jel0KYCVT
 hH+0LRe49oi/Xb0MFGlPPWq3ufnw3+K5ivPfMXdhzkkeD5MQzR
X-Google-Smtp-Source: AGHT+IEC6CflGtTcF1mF6DvhFC0OQPEmVrAeKwUz+0QuT+Hi1EExLbHe3RqIE17OS6A4WBA2fGOb3A==
X-Received: by 2002:a17:90b:1c04:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-343f9ed32bcmr6775202a91.15.1763206293510; 
 Sat, 15 Nov 2025 03:31:33 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.113])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e0715737sm12541404a91.6.2025.11.15.03.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 03:31:33 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
Date: Sat, 15 Nov 2025 19:31:18 +0800
Message-ID: <20251115113118.783-1-briansune@gmail.com>
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

This is a quick fix to stablize what
currently users encountered bootup stall.
This fix is found under board boot trials.
No logical code can be explained why it
fails the SDRAM calibration but applying.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..4011fe4784b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -117,6 +117,8 @@ config TARGET_SOCFPGA_CYCLONE5
 
 config TARGET_SOCFPGA_GEN5
 	bool
+	select WDT
+	select DESIGNWARE_WATCHDOG
 	select SPL_ALTERA_SDRAM
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
-- 
2.34.1

