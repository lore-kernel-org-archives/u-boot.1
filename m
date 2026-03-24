Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF315F54AD7
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 16:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6D1807C0;
	Tue, 24 Mar 2026 17:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="KCI+0WIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465C4838BB; Tue, 24 Mar 2026 17:30:44 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADF580087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4BD8910D6F7; Tue, 24 Mar 2026 17:30:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774369841; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=njamcRstlf8nkRJMXv+XtEMfjB+tg6Aah/OY1MOexv4=;
 b=KCI+0WIRlJso87i+W06NCg/y7LCbF0GQT8bZGcp9R+M1bngff78K/uVY7He3yXUi7irF1U
 07yNz4Si9FbzqKSNqT9pAsbhBxJDqEEQ4d7k1jrMA7uYdiIUJwUNzUQ3ygW00voYyCBgTV
 iAc+XAUE3xwG4AD6XVCa/FOIAdPi+hsQ3ELLV0jQxJEbpCKVjHz5cxRS5cB9Nq/i7U5RWr
 ed2FOOZJ1+94K9JW3lu83k+UlabaiQcOEFKyO+Hl8TgQe7H14hgTwBNRSfmCCRcsBfOup3
 n+rmJjjB10+M2B2jag8bI+caY+UDUdEKsxzzUnI2GJ1teEfXV8wb51IgCL4ZIw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@nabladev.com>, Heiko Schocher <hs@nabladev.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] crypto: fsl: init caam_jr driver
Date: Tue, 24 Mar 2026 17:30:36 +0100
Message-Id: <20260324163036.94787-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

select ARCH_MISC_INIT Kconfig symbol when enabling
freescales crypto driver support, as the init of
the caam_jr driver is done in arch_misc_init and
not enabling ARCH_MISC_INIT leads in crashes, hangs
for example in hash calculations, as caam-jr driver
is not initialized.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
Suggested-by: Fabio Estevam <festevam@nabladev.com>
---
Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=206&view=results

 drivers/crypto/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index fe694f6022c..eb01c6cf700 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -3,6 +3,7 @@ if ARM || PPC
 config FSL_CAAM
 	bool "Freescale Crypto Driver Support"
 	select SHA_HW_ACCEL
+	select ARCH_MISC_INIT
 	# hw_sha1() under drivers/crypto, and needed with SHA_HW_ACCEL
 	select MISC if DM
 	imply SPL_CRYPTO if (ARM && SPL)
-- 
2.20.1

base-commit: eb95914b9f5886b7ca0eaa2dbcd8a66bb8e5f81a
