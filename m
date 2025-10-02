Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED7DCAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 12:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFDE828A2;
	Thu,  2 Oct 2025 14:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pqrs.dk header.i=@pqrs.dk header.b="Hh5xZdPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5CBA834D4; Thu,  2 Oct 2025 11:44:19 +0200 (CEST)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0C6828A2
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=alvin@pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
 t=1759398255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BvcmkaFUuu+nqXSm9G1JQmduvnVBsVq1mauvvHN8ztA=;
 b=Hh5xZdPS8nWxW9NjYG4clqE+je48mCLI4ODVKiPSyTUU9PjPiP/kHqjThHMpVOJdm0MV2c
 oTGraHA+RsYsQLcy3fKBxOzxCTKRQcsqGRUEpFjcuBxNAhETAFPiUjx6Q//WuTLVqBNZ4I
 opi/fjYTU86GLd0cjYPl1zJS1VyKh1OOygFT5tsjYP1L645exQqdZV1vpXiNX8RJmpBuWR
 dzOaYUQYJVDncRfE0id8MHPfEbSxSsdbZjxuXnsLf4bRcOzh2O8Wkt7imJy3S0OLnmomqt
 nE4cBHVXPE98gfISM+yWVmic33BBDVozk2PlPCkDUe3ALOPh8q015BN5dGW9cQ==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Thu, 02 Oct 2025 11:43:36 +0200
Subject: [PATCH] tftp: make TFTP ports unconditionally configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-tftp-port-v1-1-96d04556b35c@pqrs.dk>
X-B4-Tracking: v=1; b=H4sIAEdJ3mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMj3ZK0kgLdgvyiEl3DVAvzRHPLRDODJHMloPqCotS0zAqwWdGxtbU
 AEQTxyFsAAAA=
X-Change-ID: 20251002-tftp-port-1e87a79a60b7
To: u-boot@lists.denx.de
Cc: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 02 Oct 2025 14:55:58 +0200
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

A few lines of code being guarded by the CONFIG_TFTP_PORT option seems
an unnecessary restriction on the TFTP support provided by a vanilla
U-Boot image. In cases where the TFTP server cannot run as superuser -
and hence cannot run on the well-known port 69 - this quirk incurs a
full reconfiguration and rebuild of the bootloader only in order to
select the appropriate destination port.

Remove the CONFIG_TFTP_PORT option entirely and make the tftpdstp and
tftpsrcp variables always have an effect. Their being unset will mean
that U-Boot behaves the same as if CONFIG_TFTP_PORT was unset. Update
the documentation accordingly. And fix up the single board which was
originally enabling this option.

Signed-off-by: Alvin Šipraga <alvin@pqrs.dk>
---
---
 configs/gurnard_defconfig |  1 -
 doc/usage/cmd/tftpput.rst |  8 ++------
 net/Kconfig               | 18 ------------------
 net/tftp.c                |  3 +--
 4 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/configs/gurnard_defconfig b/configs/gurnard_defconfig
index bde531a6003a2d7167767b3f509876137c7da1a8..85643f249aed65071005a157658c3dc11f44c619 100644
--- a/configs/gurnard_defconfig
+++ b/configs/gurnard_defconfig
@@ -42,7 +42,6 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RETRY_COUNT=20
-CONFIG_TFTP_PORT=y
 CONFIG_TFTP_TSIZE=y
 CONFIG_AT91_GPIO=y
 CONFIG_GENERIC_ATMEL_MCI=y
diff --git a/doc/usage/cmd/tftpput.rst b/doc/usage/cmd/tftpput.rst
index 351c9faa38b9d8357c0e200d8cebd1f90344e0a6..2bcb3032cb2444926da28454eefdb2b128a7389f 100644
--- a/doc/usage/cmd/tftpput.rst
+++ b/doc/usage/cmd/tftpput.rst
@@ -19,9 +19,8 @@ Description
 The tftpput command is used to transfer a file to a TFTP server.
 
 By default the destination port is 69 and the source port is pseudo-random.
-If CONFIG_TFTP_PORT=y, the environment variable *tftpsrcp* can be used to set
-the source port and the environment variable *tftpdstp* can be used to set
-the destination port.
+The environment variable *tftpsrcp* can be used to set the source port and the
+environment variable *tftpdstp* can be used to set the destination port.
 
 address
     memory address where the data starts
@@ -75,9 +74,6 @@ The command is only available if CONFIG_CMD_TFTPPUT=y.
 CONFIG_TFTP_BLOCKSIZE defines the size of the TFTP blocks sent. It defaults
 to 1468 matching an ethernet MTU of 1500.
 
-If CONFIG_TFTP_PORT=y, the environment variables *tftpsrcp* and *tftpdstp* can
-be used to set the source and the destination ports.
-
 CONFIG_TFTP_WINDOWSIZE can be used to set the TFTP window size of transmits
 after which an ACK response is required. The window size defaults to 1.
 
diff --git a/net/Kconfig b/net/Kconfig
index 40ec6bbce7614afde5a2a9f90d431f19a3654a41..7ba64d43b398415825921e7b61dc4c81e986618a 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -60,24 +60,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
 	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
 	  be configured.
 
-config TFTP_PORT
-	bool "Set TFTP UDP source/destination ports via the environment"
-	help
-	  If this is defined, the environment variable tftpsrcp is used to
-	  supply the TFTP UDP source port value.  If tftpsrcp isn't defined,
-	  the normal pseudo-random port number generator is used.
-
-	  Also, the environment variable tftpdstp is used to supply the TFTP
-	  UDP destination port value.  If tftpdstp isn't defined, the normal
-	  port 69 is used.
-
-	  The purpose for tftpsrcp is to allow a TFTP server to blindly start
-	  the TFTP transfer using the pre-configured target IP address and UDP
-	  port. This has the effect of "punching through" the (Windows XP)
-	  firewall, allowing the remainder of the TFTP transfer to proceed
-	  normally.  A better solution is to properly configure the firewall,
-	  but sometimes that is not allowed.
-
 config TFTP_WINDOWSIZE
 	int "TFTP window size"
 	default 1
diff --git a/net/tftp.c b/net/tftp.c
index 1ca9a5ea7cf6bac562006e2506ebcb17996a8c36..1760877107faef57107cb04c484157750ff63602 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -926,14 +926,13 @@ void tftp_start(enum proto_t protocol)
 	/* Use a pseudo-random port unless a specific port is set */
 	tftp_our_port = 1024 + (get_timer(0) % 3072);
 
-#ifdef CONFIG_TFTP_PORT
 	ep = env_get("tftpdstp");
 	if (ep != NULL)
 		tftp_remote_port = simple_strtol(ep, NULL, 10);
 	ep = env_get("tftpsrcp");
 	if (ep != NULL)
 		tftp_our_port = simple_strtol(ep, NULL, 10);
-#endif
+
 	tftp_cur_block = 0;
 	tftp_windowsize = 1;
 	tftp_last_nack = 0;

