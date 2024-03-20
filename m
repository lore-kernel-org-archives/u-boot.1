Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC92C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39198809B;
	Wed, 20 Mar 2024 21:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XUR7t3RM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="giG9TEXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8828809B; Wed, 20 Mar 2024 21:54:36 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489E388076
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V0LSB0GGYz9spD;
 Wed, 20 Mar 2024 21:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCfVkqmnffQ0ot8Q3snbcqsjwdLuSlSCUIGoE57/Bnk=;
 b=XUR7t3RMYWouVJ8gJjbZwRm9S5a1JxcvcGaCX/bsKHu/FqirIwyYp8gLZ9VcESUuCpkpJV
 QiFGw/75cKzhMQHuXG7h9E6iqLVasFRFSNsq13ECEJ+rBFwWeM0c8kI+Ud2A7CW3WCXL6E
 FMkOFKRjEN3rdCYsn4XzkGidEQEdTixkkZICDQSY6Diqe8f9HI2saN3kX2dCaxIC1JzUkB
 OrsZEp+kVMguvVEGY5xy/U1CcqQ+ItCP5SJ01ExT8Y+fxQT2qClcZkBNOChR349NzP2tg4
 ubmEzfACB7aaub8RYwbRD5oCLm2ZKUvd8OAAggB4TfPf+5Ebqktjv/2J/efZQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCfVkqmnffQ0ot8Q3snbcqsjwdLuSlSCUIGoE57/Bnk=;
 b=giG9TEXkEVjzgKqNtdbz2qKDGo93c94JN/FfmQ55sPPvXi0w+AttxP73nHBmLBtMlF13YZ
 ws9H3clqdl/4fE98FtzvvJ3oz6TJbnRSXDyuVCUyZg80xyMLdyv2IoLysTzW/6OTDWGp3y
 Ahlcgtr1Zl3si4wUiiaeASGNotp58BssiVmY9HpLXQHeGe+JMuUlLU6A0e5vqySGXvc3Gx
 1h/00T7LMWIoI+87m3mwv1MIceEpNQ1qlkCQsboDLJlkJtL2Zsj4qx1oobwOF8VjmV53IY
 VLrAKbS7Z9S6nrUnoCT6cHfTPhVZnznOti4YHAUlSwVFwKdoxhYUXwhAZx9Ahg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/5] boot: fdt: Clean up env_get_bootm_size()
Date: Wed, 20 Mar 2024 21:53:06 +0100
Message-ID: <20240320205413.32555-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
References: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b6a77aa5821471f43b1
X-MBO-RS-META: rin4isezpfu1r85j3897g3kajxw9yxnq
X-Rspamd-Queue-Id: 4V0LSB0GGYz9spD
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

Reduce tmp variable use and remove unnecessary type cast in
env_get_bootm_size(). This aligns the env variable parsing
with env_get_bootm_low(). No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: - New patch
V3: - Reword commit message
---
 boot/image-board.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 3263497a1d5..e3d63745299 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -129,10 +129,8 @@ phys_size_t env_get_bootm_size(void)
 	phys_addr_t start;
 	char *s = env_get("bootm_size");
 
-	if (s) {
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
-		return tmp;
-	}
+	if (s)
+		return simple_strtoull(s, NULL, 16);
 
 	start = gd->ram_base;
 	size = gd->ram_size;
@@ -142,7 +140,7 @@ phys_size_t env_get_bootm_size(void)
 
 	s = env_get("bootm_low");
 	if (s)
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
+		tmp = simple_strtoull(s, NULL, 16);
 	else
 		tmp = start;
 
-- 
2.43.0

