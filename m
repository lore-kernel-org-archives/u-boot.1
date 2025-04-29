Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7344C3ABAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346E882958;
	Tue, 29 Apr 2025 15:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZbYLr57J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD128272A; Tue, 29 Apr 2025 15:51:34 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3900D8291D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53TDpURS3093369
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 08:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745934690;
 bh=oB/f/8jLigCWXVHRT82lvQBwjVToWpf55oEAuTwAQew=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZbYLr57JF2+bWq4TW3zi1Smhh6BhXjeoq9cbMseZfAhXeVl22ANi4RVArgpm98lPy
 8hQMxs1ibXfE9hrqXbtBFktfIZoZJdzPIKS8vreO+92076BgExExRIu+Y5dMfkuS1N
 3dEnr/QQbS6x3kOsrhuymInP5Ok4xFa+3sAQJMhI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53TDpUq4042101
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 08:51:30 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 08:51:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 08:51:30 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53TDpTZa048253;
 Tue, 29 Apr 2025 08:51:29 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1 2/2] doc: ti: k3: add language for code-block directive
Date: Tue, 29 Apr 2025 19:21:08 +0530
Message-ID: <20250429135109.631201-2-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429135109.631201-1-anshuld@ti.com>
References: <20250429135109.631201-1-anshuld@ti.com>
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

The code-block directive supports the optional language property which
enables syntax highlighting for the block[1].

This patch adds the relevant language property for code-blocks in k3
docs.

[1]:
https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-code-block

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/ti/k3.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 0deb4d768f9..b79f1526446 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -460,7 +460,7 @@ The Kernel FIT Image that we have has Kernel Image, DTB and the DTBOs.  It
 supports packing multiple images and configurations that allow you to
 choose any configuration at runtime to boot from.
 
-.. code-block::
+.. code-block:: dts
 
     /dts-v1/;
 
@@ -484,7 +484,7 @@ choose any configuration at runtime to boot from.
 
 * Sample Images
 
-.. code-block::
+.. code-block:: dts
 
     kernel-1 {
             description = "Linux kernel";
@@ -533,7 +533,7 @@ corresponding configuration node as follows.
 
 * Sample Configurations
 
-.. code-block::
+.. code-block:: dts
 
     conf-ti_k3-j721e-common-proc-board.dtb {
             description = "Linux kernel, FDT blob";
@@ -585,7 +585,7 @@ Generating the fitImage
 
         For e.g
 
-        .. code-block::
+        .. code-block:: diff
 
             diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
             index a5c1df7e0054..6d0126d955ef 100644
@@ -605,7 +605,7 @@ Generating the fitImage
 
         For e.g
 
-        .. code-block::
+        .. code-block:: diff
 
             diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
                   index 673be646b1e3..752fa805fe8d 100644
-- 
2.49.0

