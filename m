Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232D4C3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 06:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3411580584;
	Sun, 18 May 2025 08:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d4ACTmX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D928059D; Sun, 18 May 2025 08:43:58 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F3C8004F
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 08:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-035.46.114.pool.telefonica.de
 [46.114.104.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B1E363FF22; 
 Sun, 18 May 2025 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1747550635;
 bh=au4VL8LCQoDEkSHnSYvTnnumtLJfEzqG20FmM/CA2Bw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=d4ACTmX+Q+OK5GsRxyNVKz/ohg76MZgf1s9SxqiPVSLMm3mKJfSk3l5CEXOyEdC4K
 sFbFpqWfZfLcvFbTiBfpgMQa5bDYJjGNPNNHSyYQnPQBr4n/Nn5ZUAsFlgSSZ3g1ge
 nzPnBqhVAAIl0F3JlqXE66hfxeS9865oG9H2TXCKDgPcc0RPAqJwQJTsyaf9lOeF/j
 MmlzvGDRgHkGQK3Ndc4PKa3sr+1i1ZccxM/dNZbCsIS8BduyDieuvGAhNM8tYGtXY0
 eKp24hCnj3876ho7NU9UXd9ud5AusF68GTqlPskVqFAL6hfvglTczKhiiaBaYJvAMP
 k8kCgg/ReRK3A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correct EFI_TCG2_PROTOCOL_MEASURE_DTB
 description
Date: Sun, 18 May 2025 08:43:44 +0200
Message-ID: <20250518064344.14467-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

%s/data that change/data that changes/
%s/cannot be used has/cannot be used as/
%s/Otherwise/Otherwise,/
%s/allows better measurement/allows for better measurement/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 7f02a83e2a2..95b51d4da1f 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -443,10 +443,9 @@ config EFI_TCG2_PROTOCOL_MEASURE_DTB
 	help
 	  When enabled, the DTB image passed to the booted EFI image is
 	  measured using the EFI TCG2 protocol. Do not enable this feature if
-	  the passed DTB contains data that change across platform reboots
-	  and cannot be used has a predictable measurement. Otherwise
-	  this feature allows better measurement of the system boot
-	  sequence.
+	  the passed DTB contains data that changes across platform reboots
+	  and cannot be used as a predictable measurement. Otherwise, this
+	  feature allows for better measurement of the system boot sequence.
 
 config EFI_LOAD_FILE2_INITRD
 	bool "EFI_FILE_LOAD2_PROTOCOL for Linux initial ramdisk"
-- 
2.48.1

