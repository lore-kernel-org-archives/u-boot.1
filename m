Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DB5C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6939488B78;
	Fri, 19 Jul 2024 12:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PG18RU2Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KRgSyLG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72BA488BB1; Fri, 19 Jul 2024 12:30:28 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA9C88B78
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQQtB2KL0z9tXp;
 Fri, 19 Jul 2024 12:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BCbM2yhWwPhPzFoTFv34nhJMlU+R043xVkVg9btMjo=;
 b=PG18RU2QNsphiyOliauowUy9d6qgualHfjgFPHIM5JfqWIXkZcOAu41lVod58iXUJfLn2R
 Eh0PYlDMdtNr97BjBLWXoS47MXvQm65ql7BxYCF9fmlNKBjSRz60GQaQ6GiOg/ErA0h4xm
 wHyypL2x0Gb45EJCp+XtGrCbcDkQUFezbphJv2FNXZ6iEFIgoUy50plqh4wMcza2Z/VxOW
 dW7ZGAOHlQsSn7JpGbkgy9HmmcTrDQamywKcDprZ6gwseDYz5ovCQWg6QWjbNxuLdmYjYZ
 C9OyCa8TRbZlKrTNzzoKpoUKZLD/fh+40PJDJB/GN2aUrBgMy7AnDO2mUhY7Bw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BCbM2yhWwPhPzFoTFv34nhJMlU+R043xVkVg9btMjo=;
 b=KRgSyLG++qD604CgOGnBtNO3y1Lyh1ekS/yLRBJ2mrwiAr5ytj3OuWDCkLnqQmzXRAbQ7q
 Xvaiatq4aIwVQqGdQwi4kExNJFtIVfOc8uKLK031g5UHtkHkCPIZmUY49MSD5DjhVT7jsS
 s3bDKg0+lg65feXNKIsJkI+5xrjchDT/kqg5slTyQs4nNlDeAuFNbnOzAvTfInL8XzLdVi
 FiRZml+V8Gn1xbFHjg09ozgLQ3V7cf7x425xDUKUD0WD5I+oOoRj18BiixpS6W3zXxOPst
 7kOFQj0HRCWUVbgB0VScb5EdiEd3rG9htQ3wKFGdJUwue2Z34H1CP4cj7dDeAw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/37] board: ebv: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:07 +0200
Message-ID: <20240719102934.322997-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1cd2519a24fb2444b5f
X-MBO-RS-META: 4mcfrw7g5jmggog79u67ryn117xgywdx
X-Rspamd-Queue-Id: 4WQQtB2KL0z9tXp
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/ebv/socrates/qts/iocsr_config.h | 1 -
 board/ebv/socrates/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/ebv/socrates/qts/iocsr_config.h b/board/ebv/socrates/qts/iocsr_config.h
index c24b5cb5f0b..d9a0c72044b 100644
--- a/board/ebv/socrates/qts/iocsr_config.h
+++ b/board/ebv/socrates/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/ebv/socrates/qts/pll_config.h b/board/ebv/socrates/qts/pll_config.h
index eaa18c1c802..baee1a922a8 100644
--- a/board/ebv/socrates/qts/pll_config.h
+++ b/board/ebv/socrates/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

