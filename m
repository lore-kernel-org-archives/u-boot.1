Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C588BC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD48F88B8D;
	Fri, 19 Jul 2024 12:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mUl8Q+lK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xYOOmgJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DED88B7F; Fri, 19 Jul 2024 12:30:18 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE7388B65
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQQsz6Yj6z9sdB;
 Fri, 19 Jul 2024 12:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCX1RGOcNDUEyrHqURr93nw7bbkK1B1oMIme+AJs210=;
 b=mUl8Q+lK1H9s3IeMAERsLoROvUafgEyyeXux41vIQ/bVVTyp9fMIdu9a1rNdPKl4YwXBF1
 VzGAEUDSn3faiGgYJFEQOxqPFHeNjElL6xynk8Sn3wWezu5ZFQ8S/UyMrvP8bGImLFVz/C
 7j4KblxPj2Ani0EJ8OMscCOkEc34M2X8qgCpYsh+BsebE7HGvHdcI5wCQjTeSwhsDxQU/j
 vVfC1vv+ljEgrTHRP6J5OdXyehF09L+hHO+Gnh2XGQe+503tlsaO5jM0ZBadyBc/JW2CyA
 dRwudnUqDM6AxlGY4FC77BThhxklf3x+ZNM/Zz6MF8XGHDxCAXllvvSpeHkTNw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCX1RGOcNDUEyrHqURr93nw7bbkK1B1oMIme+AJs210=;
 b=xYOOmgJROlLH67WFnGaanSouR3LyNh3l8gcvoSEwdMj4+7ao5tenTo2sd3IBBkKMETGUDS
 PftXR9QcS3WuHYjlABHlFfTpcrj8qwLvdAdYh3A+Tx+OSQCqOzv2zbsN/UGF97rgF+2Dr8
 yflgAL04k7lSj/ECOrM/9BudCYCZUQWieWNuPyVZl/yPUHQNbpcm4R63FdNhRUvIik7EIx
 M4BVfFTQ2kZkj6V4CnPHh0mjx3YPG4oa7Hqu1HH9UMhYswWYnT7XcSByJH5gb8zqxfNVYo
 Cfkt8HPACQNxlbNuXb1iTOqn8hP9riuadjS3uqVO3cWWxI3g9CnGcJ4JLWVf7g==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/37] board: aries: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:27:58 +0200
Message-ID: <20240719102934.322997-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a7f4f6159c93d2886b7
X-MBO-RS-META: okoqozkxddhn1ap97ex7zk8ppy98pgp3
X-Rspamd-Queue-Id: 4WQQsz6Yj6z9sdB
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
 board/aries/mcvevk/qts/iocsr_config.h | 1 -
 board/aries/mcvevk/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/aries/mcvevk/qts/iocsr_config.h b/board/aries/mcvevk/qts/iocsr_config.h
index dbcc1d719d4..3084c6a4eb8 100644
--- a/board/aries/mcvevk/qts/iocsr_config.h
+++ b/board/aries/mcvevk/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/aries/mcvevk/qts/pll_config.h b/board/aries/mcvevk/qts/pll_config.h
index 62cf6796afc..fc1ba89819a 100644
--- a/board/aries/mcvevk/qts/pll_config.h
+++ b/board/aries/mcvevk/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

