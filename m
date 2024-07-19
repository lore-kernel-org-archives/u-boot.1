Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EA0C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DF488BDC;
	Fri, 19 Jul 2024 12:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r0AaxE1F";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wZ4OB0/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F1B288BF3; Fri, 19 Jul 2024 12:50:37 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12EAE88BCF
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKP5Zy4z9sr8;
 Fri, 19 Jul 2024 12:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiR8TjYu4V81ZBK7sRO4Zk84L+uoBx2cAAXPhwFFx2Y=;
 b=r0AaxE1F5IjMuElwhejJnG2nnBoU5Ai+TO2YidEZk3EIbmdr82y5hOEGdxNnehFrj5DvgM
 AihlN6beMpj9cL04pS/Da15fKHkHZoeKG2ifaDm9h6wfZKPfBiYj48B8pCazAp979/UmrF
 xxj1cGg3Vp1mer/BmMCdvYIKxktCRNBdQHCEJrdfh8Jen6IVHm/ZeiZUqZdCKW8E+eykfN
 TGs0FrssgNtHMBD8BnLPiIf9ecdzwxwksiHJe1rYV/lTBvPiqCeehKmXDMYaOpUNZDx3w4
 doIHIjH/RrH8GPg4b2t8srs9Ja+dmvAWzmsxJ1/bSIP7OXAFvcdPNgVLC4aemA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiR8TjYu4V81ZBK7sRO4Zk84L+uoBx2cAAXPhwFFx2Y=;
 b=wZ4OB0/jKbJzE7EEqgmOCgB3DqwdYdwaBOIP8JahxqUNclQsrxjQF01b1yks/1KnrAiAim
 EYktE/TxqERZyIUoetztCEvmQgiFcXWPbKbpm1Az4I24q8iINUNC+twKe8dKW9/1fhcwAD
 cjqHQXedSjWt+EKKjeBZF17GgB0Fc+zMTzOQ5iO00L9NIkCOo8GqN/7IuFZTb9IMedFXyI
 RlLcvC/A0Cs0j9XGKxN5OKcV0YtbvqILC37k+kri1NhNLXmarVtQJKpltIOumS3cjz8cct
 IiClDpvJLSJTOnJfxKqQqyd4tlH2QQLrWa5VPT0/1AdSUG/Wlst7vH9pOGIh8A==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 16/37] board: gdsys: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:53 +0200
Message-ID: <20240719104948.323791-16-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: otwqikd4da5ee7ffpppksw4jy45ftxke
X-MBO-RS-ID: 2f23562765b7224c83a
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
 board/gdsys/common/dp501.c     | 1 -
 board/gdsys/common/ioep-fpga.c | 1 -
 board/gdsys/common/osd.c       | 2 --
 3 files changed, 4 deletions(-)

diff --git a/board/gdsys/common/dp501.c b/board/gdsys/common/dp501.c
index 7698e76b524..715544c31ec 100644
--- a/board/gdsys/common/dp501.c
+++ b/board/gdsys/common/dp501.c
@@ -136,7 +136,6 @@ void dp501_powerdown(u8 addr)
 	dp501_setbits(addr, 0x0a, 0x30); /* power down encoder, standby mode */
 }
 
-
 int dp501_probe(unsigned screen, bool power)
 {
 #ifdef CONFIG_SYS_DP501_BASE
diff --git a/board/gdsys/common/ioep-fpga.c b/board/gdsys/common/ioep-fpga.c
index f01b48b5c8e..eea486a03fb 100644
--- a/board/gdsys/common/ioep-fpga.c
+++ b/board/gdsys/common/ioep-fpga.c
@@ -6,7 +6,6 @@
 
 #ifdef CONFIG_GDSYS_LEGACY_DRIVERS
 
-
 #include <gdsys_fpga.h>
 #include <linux/bitops.h>
 
diff --git a/board/gdsys/common/osd.c b/board/gdsys/common/osd.c
index bd9c5ca9969..915b733547f 100644
--- a/board/gdsys/common/osd.c
+++ b/board/gdsys/common/osd.c
@@ -165,7 +165,6 @@ static unsigned int ics8n3qv01_get_fout_calc(unsigned index)
 	return fout_calc;
 }
 
-
 static void ics8n3qv01_calc_parameters(unsigned int fout,
 	unsigned int *_mint, unsigned int *_mfrac,
 	unsigned int *_n)
@@ -424,7 +423,6 @@ int osd_write(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		y = hextoul(argv[2], NULL);
 		rp = argv[3];
 
-
 		while (*rp) {
 			char substr[5];
 
-- 
2.43.0

