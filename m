Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA211075275
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE1483FEC;
	Thu, 19 Mar 2026 09:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCD084011; Thu, 19 Mar 2026 09:38:04 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C587283F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8bJtp017663;
 Thu, 19 Mar 2026 16:37:19 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:37:18 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 6/6] configs: ae350: Enable noncached memory support
Date: Thu, 19 Mar 2026 16:37:13 +0800
Message-ID: <20260319083713.3456894-4-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319083713.3456894-1-ycliang@andestech.com>
References: <20260319083713.3456894-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8bJtp017663
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

Enable CONFIG_SYS_HAS_NONCACHED_MEMORY and set
CONFIG_SYS_NONCACHED_MEMORY to 1MB (0x100000) on all AE350
S-mode defconfigs where SBI is available:

  ae350_rv{32,64}_spl_defconfig
  ae350_rv{32,64}_spl_xip_defconfig
  ae350_rv{32,64}_falcon_defconfig
  ae350_rv{32,64}_falcon_xip_defconfig

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 configs/ae350_rv32_falcon_defconfig     | 2 ++
 configs/ae350_rv32_falcon_xip_defconfig | 2 ++
 configs/ae350_rv32_spl_defconfig        | 2 ++
 configs/ae350_rv32_spl_xip_defconfig    | 2 ++
 configs/ae350_rv64_falcon_defconfig     | 2 ++
 configs/ae350_rv64_falcon_xip_defconfig | 2 ++
 configs/ae350_rv64_spl_defconfig        | 2 ++
 configs/ae350_rv64_spl_xip_defconfig    | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/configs/ae350_rv32_falcon_defconfig b/configs/ae350_rv32_falcon_defconfig
index 659be8287ba..08d27d7c823 100644
--- a/configs/ae350_rv32_falcon_defconfig
+++ b/configs/ae350_rv32_falcon_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_falcon_xip_defconfig b/configs/ae350_rv32_falcon_xip_defconfig
index 93b80ef789d..42f0d5f4e60 100644
--- a/configs/ae350_rv32_falcon_xip_defconfig
+++ b/configs/ae350_rv32_falcon_xip_defconfig
@@ -55,6 +55,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 4b0f52ff42b..146e3650708 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index f076f36c73c..c994331e75f 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -54,6 +54,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_falcon_defconfig b/configs/ae350_rv64_falcon_defconfig
index c7c44671419..5dd58047aeb 100644
--- a/configs/ae350_rv64_falcon_defconfig
+++ b/configs/ae350_rv64_falcon_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_falcon_xip_defconfig b/configs/ae350_rv64_falcon_xip_defconfig
index ae9c7cfd933..78e1ea118ac 100644
--- a/configs/ae350_rv64_falcon_xip_defconfig
+++ b/configs/ae350_rv64_falcon_xip_defconfig
@@ -55,6 +55,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index af000ca58ce..22c710661e0 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -53,6 +53,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 8c6e2773723..d2b29c19397 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -54,6 +54,8 @@ CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_FTMAC100=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_SYS_NONCACHED_MEMORY=0x100000
 CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_ATCSPI200_SPI=y
-- 
2.34.1

