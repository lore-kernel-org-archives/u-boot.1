Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BA3C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 13:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6601F87282;
	Tue, 19 Dec 2023 14:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="BuxAM0CS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4500386FBD; Tue, 19 Dec 2023 14:33:47 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CE0874ED
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 14:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7EA51A13E8;
 Tue, 19 Dec 2023 14:33:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=mail; bh=H2eYNxvF2Y0DaRMAn+619lRldElamij/MdZAYite9rU=; b=
 BuxAM0CSWPFZxqij+Ua07WtQim41MMG3rtBd3mTiJa94k/w9UYMSTkGch/pTBUi5
 lZ+9ovCACS71YG2xRl2oincytGXlDOTEJIbWo8yo7DFJGiorEehazu/u4+3SZWVT
 OpA2sbFgJkpI+2SrbIs8Y8PbLn5y15bUBCB9SvEHloap/xHlRxIJGZLk4sgNSxmr
 XqQX2uGCcl9GsCaJ3qJ3FP6t3dRW4+oYBfP8QQNY1HiFbbqFgvR7L/za4XCyzdNx
 O8lOGc4wR1j0dFJPL0nOt75ESiIp6u6pqHuG7SDFBy4zWGYcljh4v/nXw4L+fyMZ
 sfvZovRKF7JwNg27HJ4Aa0wMRC/ow5C7ejhHa3+QEO8kAZ6JDa9AWQa8t7o4naH1
 N4HPFvZOfEayGF2GhcC+Y7jXcA8WvwNnovMvk2Swy9+8d43HwDZXlRpGB7l5jbN1
 INP1bBElgc2jqVYFBhZOdUnfAw1+67WjTgAPvHzqyM/Aet8bb8H+nxo65X6oSaPC
 zH0TxeX3sH+tjMKORM9yN15yMdp07MHxDJioVttVlS+PV8+aZbi/QlDPS4wfpue+
 UGUtRVhQyu0fQkYGRTDMVIoODHe+rSPhx6Us6jL3nA/cVuvMLM/KCnyer9Wz3OzD
 BsrD4r/pAd6iQyEBQFqGBHg8RIcjSQljmK1vMezZuQM=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
 <csokas.bence@prolan.hu>
Subject: [PATCH v2] arm: spl: Use separate fault handlers instead of a single
 common one
Date: Tue, 19 Dec 2023 14:33:18 +0100
Message-ID: <20231219133317.11101-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1702992823; VERSION=7966; MC=1964262394;
 ID=56356; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE70385C6D7C66
X-Mailman-Approved-At: Tue, 19 Dec 2023 14:36:16 +0100
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

It may be necessary to set breakpoints etc. on a specific fault handler in SPL.
Add a Kconfig option to separate the different handlers into their own individual infinite loops.

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * Change `depends`: add `&& !ARM64 && !CPU_V7M`
    * Remove `default n`

 arch/arm/Kconfig       |  9 +++++++++
 arch/arm/lib/vectors.S | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 328e2ddc33..a6ddbad30c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -79,6 +79,15 @@ config SPL_SYS_NO_VECTOR_TABLE
 	depends on SPL
 	bool
 
+config SPL_USE_SEPARATE_FAULT_HANDLERS
+	bool "Use separate fault handlers instead of a single common one"
+	depends on !SPL_SYS_NO_VECTOR_TABLE && !ARM64 && !CPU_V7M
+	help
+	  Instead of a common fault handler, generate a separate one for
+	  undefined_instruction, software_interrupt, prefetch_abort etc.
+	  This is for debugging purposes, when you want to set breakpoints
+	  on them separately.
+
 config LINUX_KERNEL_IMAGE_HEADER
 	depends on ARM64
 	bool
diff --git a/arch/arm/lib/vectors.S b/arch/arm/lib/vectors.S
index 7cf7d1636f..a14bca6fb8 100644
--- a/arch/arm/lib/vectors.S
+++ b/arch/arm/lib/vectors.S
@@ -138,11 +138,29 @@ _fiq:			.word fiq
 #if !CONFIG_IS_ENABLED(SYS_NO_VECTOR_TABLE)
 	.align	5
 undefined_instruction:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	undefined_instruction
+#endif
 software_interrupt:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	software_interrupt
+#endif
 prefetch_abort:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	prefetch_abort
+#endif
 data_abort:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	data_abort
+#endif
 not_used:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	not_used
+#endif
 irq:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	irq
+#endif
 fiq:
 1:
 	b	1b			/* hang and never return */
-- 
2.25.1


