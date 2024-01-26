Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2339FC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9139087C15;
	Fri, 26 Jan 2024 13:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="lKWP0qyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E9087C11; Fri, 26 Jan 2024 13:48:35 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3140987BAD
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 13:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ole.orhagen@northern.tech
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5101f2dfdadso666601e87.2
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 04:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1706273312; x=1706878112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gYeNtYvdoUZadzKy2xMIPAFBNn5hKoeZTZ/PTgZLd0w=;
 b=lKWP0qyn1PQmSUE3915qwby2DUwv8Qej5Zu2K7BVgGbXD+zYIs/Pzupz3IlkfZe4PG
 DfXgpUEMF3rXw5B8irBmN6F2N/lp56fyi1GWj8zFU9JBOxNoUUcnJJ+KE43ZuNWBG1Fh
 zReUX5poSezMoQkYsBBCSqql6ew3L4W2kjkbRCaLLDqtEnmSBtKbaFTc74GCy4Ta5nQw
 jPCPMFctB8o/wopSRjt3PgPZiJFmyF9eu0QwBr6nK5riJoBfziGooEDafVWj+ahhS+Wy
 lEyp18dEaR9cmX3z6w98HYaM4S5z5AXXUyFaGRSHRHk8Kr9bCXx8o+Pc1Z3Xh1XxQXOS
 cLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706273312; x=1706878112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYeNtYvdoUZadzKy2xMIPAFBNn5hKoeZTZ/PTgZLd0w=;
 b=v8rXtsrFcw4NkLq84Np8f9qYErlaLYra/EkyTwOri0l8SOMf0R9xuyj8qOGQY+68Zs
 LVJrgPOU8/DVXLstbFGNgHz0hKX/U5N1sTH1uGuWm3HbEFVP/JdTFgj//QEb/zFNbi/E
 yNBtKZx6zkpFqqAgkbBs1sCJkk4O5F/PTjmGE7f+q0h647Hydh+CEaj2soRVxq+Pc/9c
 LLGJjBnk4RoXQ3VtUtN19NbTsm3hLfb/cPsUHN59prq2MNPljk0rj0vd4sYNVM2LqjfC
 7axKuDJqVvQbE4pKPMn9gXj92ZhSWsL/O/dbvpnZSz558AI7VpHxYHqTl/Lx5y6uOCvW
 r5JA==
X-Gm-Message-State: AOJu0Yw4CaI0DxXKEV7+ksk7AYyYA83WXRuAkTD9V2kLaS2ly6oS/NFR
 dkxx2mqPo5MFfSBWZPeNd2W4jr3kOwp5oC5w46riWr4WH2+pqTIiTLaMskfHealeU23bPMu98u4
 pMbRYdevQngRJbiKGEkOyx48huBm1kXQIHa4QvFg+S/9/nXW1XNZN/w6eBBo=
X-Google-Smtp-Source: AGHT+IEB4L33lGhATgIhi9WXFzSziAaYdvuvgDZnjP6Gtf3re+yXWkXLhE25wwUVBjV5mdYTUPPd6A==
X-Received: by 2002:a05:651c:316:b0:2cf:16f2:b058 with SMTP id
 a22-20020a05651c031600b002cf16f2b058mr710992ljp.106.1706273312052; 
 Fri, 26 Jan 2024 04:48:32 -0800 (PST)
Received: from olepor.localhost ([91.232.32.37])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a2e9d52000000b002cf1a94c216sm152556ljj.2.2024.01.26.04.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 04:48:31 -0800 (PST)
From: "Ole P. Orhagen" <ole.orhagen@northern.tech>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Kristian Amlie <kristian.amlie@northern.tech>,
 "Ole P. Orhagen" <ole.orhagen@northern.tech>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Mark Kettenis <kettenis@openbsd.org>, Patryk Biel <pbiel7@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
Date: Fri, 26 Jan 2024 13:47:50 +0100
Message-ID: <20240126124801.1164892-1-ole.orhagen@northern.tech>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jan 2024 13:57:38 +0100
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

This commit enables support for DM_SERIAL in the vexpress_ca9x4 boards.

When running the board with the DM_SERIAL driver, the board ran out of
memory in SPL when initialising the DM serial driver.

Thus this required an increase in the pre-allocated SRAM memory. I did
increase it to 0x800, and it now works graciously.

It could probably be set lower, but I do not see any reason not to use the
available SRAM at this point.

Also adds stdout-path to the 'chosen' node in the device tree.

Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>

---

 arch/arm/Kconfig                  | 2 +-
 arch/arm/dts/vexpress-v2p-ca9.dts | 4 +++-
 configs/vexpress_ca9x4_defconfig  | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index abd7c6c79a..8e9aaf70d2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -678,7 +678,7 @@ config ARCH_BCMBCA
 config TARGET_VEXPRESS_CA9X4
 	bool "Support vexpress_ca9x4"
 	select CPU_V7A
-	select PL011_SERIAL
+	select PL01X_SERIAL
 
 config TARGET_BCMNS
 	bool "Support Broadcom Northstar"
diff --git a/arch/arm/dts/vexpress-v2p-ca9.dts b/arch/arm/dts/vexpress-v2p-ca9.dts
index bf00c62bcf..e5b86c0d67 100644
--- a/arch/arm/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/dts/vexpress-v2p-ca9.dts
@@ -20,7 +20,9 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	chosen { };
+	chosen {
+		stdout-path = &v2m_serial0;
+	};
 
 	aliases {
 		serial0 = &v2m_serial0;
diff --git a/configs/vexpress_ca9x4_defconfig b/configs/vexpress_ca9x4_defconfig
index 2601e55ebf..f8e93bef4e 100644
--- a/configs/vexpress_ca9x4_defconfig
+++ b/configs/vexpress_ca9x4_defconfig
@@ -2,7 +2,7 @@ CONFIG_ARM=y
 CONFIG_SYS_L2CACHE_OFF=y
 CONFIG_TARGET_VEXPRESS_CA9X4=y
 CONFIG_TEXT_BASE=0x60800000
-CONFIG_SYS_MALLOC_F_LEN=0x400
+CONFIG_SYS_MALLOC_F_LEN=0x800
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60000f10
@@ -41,6 +41,7 @@ CONFIG_ARM_PL180_MMCI=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=127
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_DM_SERIAL=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_SYS_FLASH_CFI_WIDTH_32BIT=y
 CONFIG_FLASH_SHOW_PROGRESS=0
-- 
2.43.0

