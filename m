Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E6EEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0403D86A30;
	Wed,  6 Sep 2023 23:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WIJIUClI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mOpemq+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8109E868BC; Wed,  6 Sep 2023 23:31:08 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C606486A4C
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RgwXk5Pqqz9sW6;
 Wed,  6 Sep 2023 23:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyxWN9r/K+ghErumb6q7ED0sl0+8XLdNN++FVLN5UZg=;
 b=WIJIUClIG4ut7lJESNbVPMWroZdgdYCGJ9fSP3UejN1kI6hT2lxiSNAp//F0yoshTBh20D
 RLen6Go5HEg0qAcBOkynijjcFF6g20kF6CBv7PusfNvwdjILN6LJTCE65qRwcriCiutqpk
 HMdxgOvvxD4dblVI+xBK+82AVBg6jXN2kGO2aTVuzK/xnSUhYVIeMg7KO4CDNWVFdRdANT
 R1Uh93sjcebJc/q6tAKTuk+rvnjet+/kGPYtj/it5CGDWjt76/IhwNyEv1ZTJGkPPzYqN9
 nLBIvqeOWgWPIL/0K9nbmfmhtIULdJn6M985/CruHijtzHHduhXT28KD8WtAdQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyxWN9r/K+ghErumb6q7ED0sl0+8XLdNN++FVLN5UZg=;
 b=mOpemq+bFJpiRLCk+zBL91UNlixdQFW9NrzaKfp7hx4ulkldiuv51ZaryqT0sX5W3QoIes
 fFPqZ3Sjd2vjqBl15XoJKydElHlMazeKmXfiTzN4KDGZPIa4Ntgj+MbwhnVx3QKen6EhzF
 u/vYGgUpMqdYVi7A/u4wDbYO1bGfvtBpdm3LcpKVQsEA3jfQrIxFgaDiVi+o+ZEXrLR1X9
 0Dkb86GLSa1O1w79SmxdLMQCq2Wf4IUyL+rUEIrl5oWWzHSi2EZbbjJnLIGLGfs7zgxSnK
 f1jea9T+nImUU5Ji4qEb3LHJbZ6GtZJBiIy8BZWCI3ZevgfbSqYrNXXtH+3HJQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 35/35] post: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:15 +0200
Message-Id: <20230906213015.203437-36-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f1d18ba992e67c68fc7
X-MBO-RS-META: izxtk8u7zjdj8xiqf9qxg6z55611bx3y
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 doc/README.POST |  5 -----
 include/post.h  |  3 ---
 post/post.c     | 48 ------------------------------------------------
 3 files changed, 56 deletions(-)

diff --git a/doc/README.POST b/doc/README.POST
index 1366f95c662..c614ea44a28 100644
--- a/doc/README.POST
+++ b/doc/README.POST
@@ -138,11 +138,6 @@ The POST layer will export the following interface routines:
      mode the test is executed in (power-on, normal, power-fail,
      manual).
 
-  o) void post_reloc(ulong offset);
-
-     This routine will be called from board_init_r() and will
-     relocate the POST test table.
-
   o) int post_info(char *name);
 
      This routine will print the list of all POST tests that can be
diff --git a/include/post.h b/include/post.h
index 41120695064..6e88d550722 100644
--- a/include/post.h
+++ b/include/post.h
@@ -105,9 +105,6 @@ void post_bootmode_clear (void);
 int post_run (char *name, int flags);
 int post_info (char *name);
 int post_log (char *format, ...);
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-void post_reloc (void);
-#endif
 unsigned long post_time_ms (unsigned long base);
 
 /**
diff --git a/post/post.c b/post/post.c
index 4db862c0dbb..946d9094d45 100644
--- a/post/post.c
+++ b/post/post.c
@@ -416,54 +416,6 @@ int post_log(char *format, ...)
 	return 0;
 }
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-void post_reloc(void)
-{
-	unsigned int i;
-
-	/*
-	 * We have to relocate the test table manually
-	 */
-	for (i = 0; i < post_list_size; i++) {
-		ulong addr;
-		struct post_test *test = post_list + i;
-
-		if (test->name) {
-			addr = (ulong)(test->name) + gd->reloc_off;
-			test->name = (char *)addr;
-		}
-
-		if (test->cmd) {
-			addr = (ulong)(test->cmd) + gd->reloc_off;
-			test->cmd = (char *)addr;
-		}
-
-		if (test->desc) {
-			addr = (ulong)(test->desc) + gd->reloc_off;
-			test->desc = (char *)addr;
-		}
-
-		if (test->test) {
-			addr = (ulong)(test->test) + gd->reloc_off;
-			test->test = (int (*)(int flags)) addr;
-		}
-
-		if (test->init_f) {
-			addr = (ulong)(test->init_f) + gd->reloc_off;
-			test->init_f = (int (*)(void)) addr;
-		}
-
-		if (test->reloc) {
-			addr = (ulong)(test->reloc) + gd->reloc_off;
-			test->reloc = (void (*)(void)) addr;
-
-			test->reloc();
-		}
-	}
-}
-#endif
-
-
 /*
  * Some tests (e.g. SYSMON) need the time when post_init_f started,
  * but we cannot use get_timer() at this point.
-- 
2.40.1

