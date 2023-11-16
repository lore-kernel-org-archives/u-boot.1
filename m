Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE09FC54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E2E8747E;
	Thu, 16 Nov 2023 14:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231468747E; Thu, 16 Nov 2023 14:02:29 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC71874B5
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AGD288H001846;
 Thu, 16 Nov 2023 21:02:08 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 16 Nov 2023
 21:02:03 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH V3 3/3] configs: andes: add the fdt blob address for SPL copy
 to
Date: Thu, 16 Nov 2023 21:01:36 +0800
Message-ID: <20231116130136.2796918-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116130136.2796918-1-randolph@andestech.com>
References: <20231116130136.2796918-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3AGD288H001846
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

Add the address where the FDT blob should be moved.

Signed-off-by: Randolph <randolph@andestech.com>
---
 configs/ae350_rv32_falcon_defconfig     | 1 +
 configs/ae350_rv32_falcon_xip_defconfig | 1 +
 configs/ae350_rv64_falcon_defconfig     | 1 +
 configs/ae350_rv64_falcon_xip_defconfig | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/ae350_rv32_falcon_defconfig b/configs/ae350_rv32_falcon_defconfig
index 3f2993e371..c0837322bb 100644
--- a/configs/ae350_rv32_falcon_defconfig
+++ b/configs/ae350_rv32_falcon_defconfig
@@ -14,6 +14,7 @@ CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT=y
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x01700000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
diff --git a/configs/ae350_rv32_falcon_xip_defconfig b/configs/ae350_rv32_falcon_xip_defconfig
index e4f4c7807c..d401e4963b 100644
--- a/configs/ae350_rv32_falcon_xip_defconfig
+++ b/configs/ae350_rv32_falcon_xip_defconfig
@@ -15,6 +15,7 @@ CONFIG_TARGET_ANDES_AE350=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_XIP=y
 CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT=y
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x01700000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
diff --git a/configs/ae350_rv64_falcon_defconfig b/configs/ae350_rv64_falcon_defconfig
index 4fb83d8240..b4ae5f9848 100644
--- a/configs/ae350_rv64_falcon_defconfig
+++ b/configs/ae350_rv64_falcon_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_AVAILABLE_HARTS is not set
 CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT=y
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x01700000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x10000000
diff --git a/configs/ae350_rv64_falcon_xip_defconfig b/configs/ae350_rv64_falcon_xip_defconfig
index 45464260ee..c7c8324d30 100644
--- a/configs/ae350_rv64_falcon_xip_defconfig
+++ b/configs/ae350_rv64_falcon_xip_defconfig
@@ -15,6 +15,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_XIP=y
 CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT=y
+CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x01700000
 CONFIG_SYS_MONITOR_BASE=0x88000000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
-- 
2.34.1

