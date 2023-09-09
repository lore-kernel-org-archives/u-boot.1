Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1D1EEB57D
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 02:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD30986484;
	Sat,  9 Sep 2023 04:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mGNExTRH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V31a5Pun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A80D8648C; Sat,  9 Sep 2023 04:54:59 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8228A8477A
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 04:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RjHdX21rYz9sW5;
 Sat,  9 Sep 2023 04:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694228096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8QlGYvYHKAFxA2B+r7z+M6wQ4CNAkvDoWWFnGAVTeJ8=;
 b=mGNExTRH9A7PKjYwJeuTOakq+0CSIKxjKZAcQ0L2lppfCoBnnDTbR/pCydGzNp141I76FX
 3wAavliBGgyi4X8sAzHdi3LYfoSh4y789TtyuwKPAiQxbRH+SY/dgsdT70gv6g2LxLArac
 T0eRAAZ/uH8dsGWgvUldyyrgDvZLc5CEikSAiHttHg1CxcTV4pVbl1Kvznuhq+Xq2jUtF7
 se5ATIzzKR71ZpAKlocBY/x39lLxJX20V/Da/r5y+V3eSiSteypN3sQ2cPn/d9D4EOpDPE
 tRnGFeQ+Lt/J+tciIp3XyYdmmslcGYfYGgAIsJrk/nVK+mExRJEijnHGUfB4Zw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694228093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8QlGYvYHKAFxA2B+r7z+M6wQ4CNAkvDoWWFnGAVTeJ8=;
 b=V31a5PunhwFTb4EJqotIH1kjwo4og2iuPyDhmpllo3ZKwwiXSZWEkvZtq4R760V2TDCOVd
 lt2MdquXNckS+hyJPaafeaB7z+JcBn/9TvyIuaQcx1pW9W2OeAL2FLpioUguKz006BoaGH
 iK4YWWvAl9btF+PM2SZYxIAuGKzm5IcvQQ3nByFOmWso5liqOWw93wxNkLTB+CP19I6ARH
 yZMywxN0BR1nUfZ81ZOguoUtTBtfpZM7YrvyVdGEel98P4sUKw+jYDukqqDJ4zISsMLvwL
 PwEUAj2t5s4Q41Fyp/uEGQqSeg0iHI1JRiV13iostMzl67DUG+HQHv/wGQshmA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH] ufs: ufs-renesas: Drop include common.h
Date: Sat,  9 Sep 2023 04:54:35 +0200
Message-Id: <20230909025435.84441-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c5d13fa20aa29abdc8b
X-MBO-RS-META: f4cpwyowt9pngtgmhitoykj9sit1wyyc
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

The "#include <common.h>" is being phased out in favor of more fine
grained header management, i.e. ideally include a subset of headers
that are really needed. Remove it from this driver.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/ufs/ufs-renesas.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index f6086050cde..ae05bdc8102 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -6,7 +6,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <ufs.h>
 #include <asm/io.h>
-- 
2.40.1

