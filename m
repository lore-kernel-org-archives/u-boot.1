Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F009C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F0F8291D;
	Tue, 29 Apr 2025 15:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SMJjhqX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA028293C; Tue, 29 Apr 2025 15:51:33 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EE18272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53TDpToK3682311
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 08:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745934689;
 bh=pUHqG5K/jMB1f0Yq0WusebZ2T3Z3cptgtFFmm1nMgEg=;
 h=From:To:CC:Subject:Date;
 b=SMJjhqX1EMBbCOmoXYwRvoxLdeI7HswhbzEV59mM4yzEo/qlMwtrXOuHTybQy5MA+
 Dow2PlfYTQZSio6J39TOvpZVbvGZfy6LGIXFtgFzZ7s/9C6o7OTdQoik6fmajydv8g
 bh1fcl4l7ZwfX5Xi1ZMq+1SEjxlhesUZ5kKy9XcY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53TDpS4q004875
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 08:51:28 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 08:51:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 08:51:28 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53TDpRgi048228;
 Tue, 29 Apr 2025 08:51:28 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1 1/2] doc: ti: update bash code-block directives to prompt
Date: Tue, 29 Apr 2025 19:21:07 +0530
Message-ID: <20250429135109.631201-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The code-block directive requires addition of the prompt symbol for each
line, using the prompt directive instead allows for auto insertion of
the symbol per line[1].

For the readers, the character added by the prompt directive is
un-selectable i.e the entire line can be more easily selected for copy
pasting etc. Whereas with code-block, the prompt symbol like "$" is also
selectable which is usually not the intent.

This is mostly a QoL addition + making the docs consistent since k3.rst
makes use of prompt directives which these board docs include from.

[1]: https://pypi.org/project/sphinx-prompt/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/ti/am62ax_sk.rst  | 20 ++++++++++----------
 doc/board/ti/am62px_sk.rst  | 18 +++++++++---------
 doc/board/ti/j722s_evm.rst  | 14 +++++++-------
 doc/board/ti/j784s4_evm.rst | 16 ++++++++--------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 262340ef59a..43a1db68873 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -81,16 +81,16 @@ Set the variables corresponding to this platform:
 .. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash
 
- $ export UBOOT_CFG_CORTEXR=am62ax_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=am62ax_evm_a53_defconfig
- $ export TFA_BOARD=lite
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-am62ax
- $ # we dont use any extra OPTEE parameters
- $ unset OPTEE_EXTRA_ARGS
+   export UBOOT_CFG_CORTEXR=am62ax_evm_r5_defconfig
+   export UBOOT_CFG_CORTEXA=am62ax_evm_a53_defconfig
+   export TFA_BOARD=lite
+   # we dont use any extra TFA parameters
+   unset TFA_EXTRA_ARGS
+   export OPTEE_PLATFORM=k3-am62ax
+   # we dont use any extra OPTEE parameters
+   unset OPTEE_EXTRA_ARGS
 
 1. Trusted Firmware-A:
 
@@ -212,6 +212,6 @@ detailed setup information.
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash
 
   openocd -f board/ti_am62a7evm.cfg
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 99bdc034869..a07d6a4da45 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -91,15 +91,15 @@ Set the variables corresponding to this platform:
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
 
-.. code-block:: bash
+.. prompt:: bash
 
- $ export UBOOT_CFG_CORTEXR=am62px_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=am62px_evm_a53_defconfig
- $ export TFA_BOARD=lite
- $ # we dont use any extra TFA parameters
- $ unset TFA_EXTRA_ARGS
- $ export OPTEE_PLATFORM=k3-am62x
- $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+   export UBOOT_CFG_CORTEXR=am62px_evm_r5_defconfig
+   export UBOOT_CFG_CORTEXA=am62px_evm_a53_defconfig
+   export TFA_BOARD=lite
+   # we dont use any extra TFA parameters
+   unset TFA_EXTRA_ARGS
+   export OPTEE_PLATFORM=k3-am62x
+   export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
 
 .. am62px_evm_rst_include_start_build_steps
 
@@ -312,6 +312,6 @@ detailed setup information.
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash
 
   openocd -f board/ti_am62pevm.cfg
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index e5a1be50c4f..0ca3399f263 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -68,13 +68,13 @@ Set the variables corresponding to this platform:
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
 
-.. code-block:: bash
+.. prompt:: bash
 
- $ export UBOOT_CFG_CORTEXR=j722s_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=j722s_evm_a53_defconfig
- $ export TFA_BOARD=lite
- $ export OPTEE_PLATFORM=k3-am62x
- $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+   export UBOOT_CFG_CORTEXR=j722s_evm_r5_defconfig
+   export UBOOT_CFG_CORTEXA=j722s_evm_a53_defconfig
+   export TFA_BOARD=lite
+   export OPTEE_PLATFORM=k3-am62x
+   export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
 
 .. j722s_evm_rst_include_start_build_steps
 
@@ -259,6 +259,6 @@ detailed setup information.
 
 To start OpenOCD and connect to the board
 
-.. code-block:: bash
+.. prompt:: bash
 
   openocd -f board/ti_j722sevm.cfg
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index a1e927cb743..349fb394d74 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -81,14 +81,14 @@ Set the variables corresponding to this platform:
 .. include::  k3.rst
     :start-after: .. k3_rst_include_start_common_env_vars_defn
     :end-before: .. k3_rst_include_end_common_env_vars_defn
-.. code-block:: bash
+.. prompt:: bash
 
- $ export UBOOT_CFG_CORTEXR=j784s4_evm_r5_defconfig
- $ export UBOOT_CFG_CORTEXA=j784s4_evm_a72_defconfig
- $ export TFA_BOARD=j784s4
- $ export TFA_EXTRA_ARGS="K3_USART=0x8"
- $ export OPTEE_PLATFORM=k3-j784s4
- $ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
+   export UBOOT_CFG_CORTEXR=j784s4_evm_r5_defconfig
+   export UBOOT_CFG_CORTEXA=j784s4_evm_a72_defconfig
+   export TFA_BOARD=j784s4
+   export TFA_EXTRA_ARGS="K3_USART=0x8"
+   export OPTEE_PLATFORM=k3-j784s4
+   export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
 
 .. j784s4_evm_rst_include_start_build_steps
 
@@ -326,6 +326,6 @@ Debugging U-Boot on J784S4-EVM and AM69-SK
 To start OpenOCD and connect to J784S4-EVM or AM69-SK board, use the
 following.
 
-.. code-block:: bash
+.. prompt:: bash
 
   openocd -f board/ti_j784s4evm.cfg
-- 
2.49.0

