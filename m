Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B68C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A048B88BBC;
	Fri, 19 Jul 2024 12:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Lf9FZJac";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jRJ6Kzgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102CC88BA4; Fri, 19 Jul 2024 12:30:26 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA9288B4F
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQQt800HPz9sls;
 Fri, 19 Jul 2024 12:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cswUZg2yKt6JLdpZihNtvrEqJPDKC/6Q7yijZm7pxLw=;
 b=Lf9FZJacr8HNRrNWmUFTxaArxL1Piy1fKS8VWYra+MU6jZlN0aT2qb4acOfdZaJ9TWn6WW
 goGK6ipa16tdak2Y3VCRnrioEDAc3CKBi8aqhiBBbsGfZECMhpK8o7cm+83/8clVmp1OXf
 7VyZro5tUArR54co8RBsFXEmRqCakZzNxeF7t32rd1P7ND2EQOGhpXfzecWw37xJyTbEWp
 cecdoCdT5wVPOUAxhfhyX/pLdbZ306o+af3o98t+qKUKgQY6EN0yprm+uvdUvNkD3L3bFT
 g7LF150L7I6pjCy6V40V36vYwjWwfhh/6/ODK8ITZ7aBawCrBZsgIvgXB7EDoA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cswUZg2yKt6JLdpZihNtvrEqJPDKC/6Q7yijZm7pxLw=;
 b=jRJ6KzgwPLwcaEBhvLTm7xbHgiDBj3VgCNYBLPnnmPDnSdgrCxE36o6BzTW4cdfWwGSz7h
 pjNKhIuKqfFByC0KWLkqnRqINmzytc2n1NFcOp8VOBnu8cGS9MOQmqywGiN4/xzNpuRL5t
 fdPJ18HTT2vUPGY+yRm9Y+sx5OoKl5FfkqHr3IZJHMNttlP8H/GdkIufnfe/FqcLfHCIBT
 wSD/wJfinl406zGnKAVQmwKeu9G4ZfDwTM/bYjyQp7nmXkshXqH0vHfovOOEzwemHmDZE+
 HlPJIXWaLXFkkKnGhjEeD6HJ4n9CfGF3lMJnfRqLekhEQpUxOlAKjYUkSML7+w==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/37] board: devboards: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:05 +0200
Message-ID: <20240719102934.322997-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ppgibyxa5jzz4dshijuxr89kwrmga6no
X-MBO-RS-ID: bd3c04429f45ad1c898
X-Rspamd-Queue-Id: 4WQQt800HPz9sls
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
 board/devboards/dbm-soc1/qts/iocsr_config.h | 1 -
 board/devboards/dbm-soc1/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/devboards/dbm-soc1/qts/iocsr_config.h b/board/devboards/dbm-soc1/qts/iocsr_config.h
index 56b2130671a..6bec839e283 100644
--- a/board/devboards/dbm-soc1/qts/iocsr_config.h
+++ b/board/devboards/dbm-soc1/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/devboards/dbm-soc1/qts/pll_config.h b/board/devboards/dbm-soc1/qts/pll_config.h
index 104e324d8a4..52f1eb0c7b4 100644
--- a/board/devboards/dbm-soc1/qts/pll_config.h
+++ b/board/devboards/dbm-soc1/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

