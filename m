Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3978DC5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F31740653;
	Thu, 20 Aug 2026 12:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2Ld7JlAqaJb; Thu, 20 Aug 2026 12:57:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787230665;
	bh=oiuwSKqTEzuB0jIHF9HL83+8oVx1hvn5f1FY5mdB+Rk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pVMY+dYZmoWe+WbZVZN0/DwT6UTOub5P4BUikkWkOk4a4jLIi4qim7hxgMgzfZun3
	 F5qzvjXDIPUjgVXzIU/YYQnsfTJb55M+c9K5/7ikTb8sPLMd50Z/T5o4q2NAp3/hel
	 gck0fLosJj1V+rulLMFCRSrBrYFd2OQZQPDllohJHLj8+//pmozkl4b0C3LXdlAg6N
	 64V1AEwxWE2M8r4VISGosABTlCxFdPyVSFukeOKMoCtXFFLY6Uwucqf8rNq6tfOHDV
	 7IlaxuTdESIP99e/xlU2BPbaR0/auklVBNkZD9+ATZE8QwB2c3IYIS6tzN0g2HLGiT
	 crTV9TQCdCslw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B307540598;
	Thu, 20 Aug 2026 12:57:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A19E3323
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9394C80C53
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cj0Xlamo9OCm for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:57:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ozndrgt@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=n9gCJ67D
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 987EB80897
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:57:43 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so1907805f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230661; x=1787835461;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oiuwSKqTEzuB0jIHF9HL83+8oVx1hvn5f1FY5mdB+Rk=;
 b=n9gCJ67DmWXEx1OyUjbvweCZ3Qlra+drVeK16Zd3BATzO/Vw0aXnjoRGOTJbnIqqbG
 2R3YA2zfAVPPQ4yy/EchqlPOJrNgn7GXwioOsdXr/lZ9ppD83qjxU55t0olm3bRcZEJy
 W0UdpdVtx3fckSwMVfNSUPzRwodxl1CMT56bvvmda+AXMuukRvRo6jtbLfemwau3DvP8
 nJZDZlIhUp2jELddknLX5uniQbIwkBgMofI807wJRd7GbbeGmRnjyS/gjCeTTGA35Agu
 /X4hB3IbB4gkJjjJt83DirArisp7QqtI985FJqGmMzqJB2bm6ntSdqks4G3MngYihGf3
 56UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230661; x=1787835461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oiuwSKqTEzuB0jIHF9HL83+8oVx1hvn5f1FY5mdB+Rk=;
 b=D6GsXtGqqzihgotVZqjqWP9khZ3klPwRVCoBYgBbDv8tg8FirTmaf8yqQAStQiyB0v
 Gy45mG4+0U8+C39fNC+YjnmNBL5HcFcxhruOhRnkS7ZNuwNOcojTPGxFRapO50kp7DxT
 GqN2AM5kQVvn4S8ua5U9EPp3CaLsXQrMXKxZ7pzGA8E8jIL5kNhmWINXMI1PNBMn4juu
 01ydZiuk04yidxJ99MbeeqqXe7r2Lut3x58nfZtiK2Y7YBR78FPy1iXYW8VLpDZS//sS
 inIjZOEPpKWZ06vIvUqrLoja5kNy5arW2i4bqg3VdLRy9ZnKER3tc9q6zeiB03xibymd
 4h6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJfPB/qreG6FXfEUmZq0RCWm30WzWWRAZackSEXRtKuRhyZ1/iagt7UmMiL3Oc/6zfBo/hv8c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nbr7tv/TiRxc9k3LCXWAb9Jk8lZlKKpGuixjfrZ2nwvQnr3lXm
 Eamzc++TkTMUF1kFT9t/21dMqNRXwLk2g1bn6fTzawM6wKny+4c9MRx3
X-Gm-Gg: AR+sD127Wb7UcfVRHYGDnQDqSrUpFZKOMf79f9KWiGt+VgMyCJSLMHHm/1NhEWxbXGN
 37tVDuLpx3Xxdi9hr/VBc0u5gMhwSgl4RRFnFNGyVO4Fh5M7Iv5FQCbPFGGZKpv5tyDzlZUqtQX
 5Gg8osnNM0oS9N8qcKy8nCEM4Dcxqh/D5MTAy3ZfMpDl1+d7ijRpFE8dAXeZEKpjimUEoG+Nugd
 oXXN4l8rRn8F9ZKoTLTCryxkZSb7ezzcuLXZ7Npp2XkCRupgg7BVs4svwXC5dKO6sCf1B2ujic9
 IfB54HL7TfbXmG5J87HowY7hoB24i2h1hbRkXSZFIrqU+0/nk4GQHaX8yP79FzOs6Zhktf4qvz6
 60BSBuZN6sq6XfKCsSlSjXi5ubMXKcAafeHZzAoVYpQdhoDL2mktyUPI4gxKCX+TnxSLuq3tgFU
 PC2AHtrKxg1WAEk12w7QJYXDyzM6pVdFb7JG30tLs2aQTW5EGoshQMT3WjIM/nHXTNhhxZn4HvR
 3L6fjCXBU4F5FNREonXCA==
X-Received: by 2002:a05:6000:2408:b0:47f:c648:e280 with SMTP id
 ffacd0b85a97d-482b1feb2bcmr20153740f8f.18.1787230661000; 
 Thu, 20 Aug 2026 05:57:41 -0700 (PDT)
Received: from Precision-5570.tail71a1d0.ts.net ([149.140.110.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c45f1sm12782727f8f.31.2026.08.20.05.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:57:40 -0700 (PDT)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: Ozan Durgut <ozan.durgut@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Tom Rini <trini@konsulko.com>, Caleb Ethridge <caleb.ethridge@analog.com>,
 linux@analog.com, u-boot@lists.u-boot-project.org
Subject: [PATCH] configs: sc5xx: set default FDT file
Date: Thu, 20 Aug 2026 14:56:55 +0200
Message-ID: <20260820125705.51692-1-ozndrgt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Ozan Durgut <ozan.durgut@analog.com>

Set CONFIG_DEFAULT_FDT_FILE in all SC5xx defconfigs to the
corresponding board DTB filename, and set fdtfile from it in the
common ADI boot environment. This provides a default device tree
file for booting the OS.

Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 configs/sc573-ezlite_defconfig         | 1 +
 configs/sc584-ezkit_defconfig          | 1 +
 configs/sc589-ezkit_defconfig          | 1 +
 configs/sc589-mini_defconfig           | 1 +
 configs/sc594-som-ezkit-spl_defconfig  | 1 +
 configs/sc594-som-ezlite-spl_defconfig | 1 +
 configs/sc598-som-ezkit-spl_defconfig  | 1 +
 configs/sc598-som-ezlite-spl_defconfig | 1 +
 include/env/adi/adi_boot.env           | 1 +
 9 files changed, 9 insertions(+)

diff --git a/configs/sc573-ezlite_defconfig b/configs/sc573-ezlite_defconfig
index cbf24234cc3..f392d25bfeb 100644
--- a/configs/sc573-ezlite_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -15,6 +15,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_DEFAULT_FDT_FILE="sc573-ezlite.dtb"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index bb24b31b2c0..20728df4e00 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -20,6 +20,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ramboot"
+CONFIG_DEFAULT_FDT_FILE="sc584-ezkit.dtb"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index d3f0380bfed..8b210ea749b 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -23,6 +23,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_DEFAULT_FDT_FILE="sc589-ezkit.dtb"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 1bdede4b739..0b24583384f 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -21,6 +21,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_DEFAULT_FDT_FILE="sc589-mini.dtb"
 CONFIG_SYS_CBSIZE=512
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index 4f8be110ee4..ad7add99fd4 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -17,6 +17,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_DEFAULT_FDT_FILE="sc594-som-ezkit.dtb"
 CONFIG_SYS_CBSIZE=512
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index c045c67569b..96a80d9fc29 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -20,6 +20,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_DEFAULT_FDT_FILE="sc594-som-ezlite.dtb"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 CONFIG_SPL_I2C=y
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index e2fee0d0be8..4f9b8dccc45 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -35,6 +35,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_DEFAULT_FDT_FILE="sc598-som-ezkit.dtb"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_SEPARATE_BSS is not set
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 9ae5bdad6ca..c904567f476 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -36,6 +36,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run spiboot"
+CONFIG_DEFAULT_FDT_FILE="sc598-som-ezlite.dtb"
 CONFIG_SYS_CBSIZE=512
 CONFIG_CYCLIC_MAX_CPU_TIME_US=1000
 # CONFIG_SPL_SEPARATE_BSS is not set
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index 3c83826cf9a..a3e308e6404 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -7,6 +7,7 @@
 /* Config options */
 ethaddr=02:80:ad:20:31:e8
 eth1addr=02:80:ad:20:31:e9
+fdtfile=CONFIG_DEFAULT_FDT_FILE
 httpdstp=8000
 uart_console=CONFIG_UART_CONSOLE
 #ifdef CONFIG_SC59X_64
-- 
2.43.0

