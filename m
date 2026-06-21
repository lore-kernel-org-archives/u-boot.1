Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C14DCD4F26
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 02:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8FA849AE;
	Sun, 21 Jun 2026 04:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ED3rpYXj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uf/vx+vD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED52849BF; Sun, 21 Jun 2026 04:40:45 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312EC8499C
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 04:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gjbDB6vQVz9tvP;
 Sun, 21 Jun 2026 04:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3EFt+8OuJZia8+lppz44xshqxEI54pBq1pwhgQa3GuQ=;
 b=ED3rpYXjHoUEMU6lPmVKqK4ZdhSxuFmWA2bib1CcOuw51GQIjjkFudBrhznZbHfyvPbDA+
 2Ac6lZB7OIl6n/OUNlvFICdRPqcx8h3CJPxwGLSWqsQBrZVc9ICGmYRyulLVs/34VpL2yw
 uIc6lUBBWfIAldXIM+3u7vgtruEzLNknxgJi1vaEc0nPZc+hifsoO8Jhlzs+fAAR+pl0Qw
 mH+bOlqgz1JZeLJM5ONvarWr+9gtEetBhK0JYobo4dCvQBlDgJX0rPt8e0UNbkZ9f6g30g
 yr7FnMGLoyun/7HKAa3Bb26tEtyaYhjVI2qa5bFxhPPkz24IO75Wn3yDnAy/cw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782009641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3EFt+8OuJZia8+lppz44xshqxEI54pBq1pwhgQa3GuQ=;
 b=uf/vx+vDJKGx5JgKpkzlJgZWeteHVzYLNqktzKweCdmDBWOjp4yf5VumjOjXCgay7DMbfh
 Fu8KobLDIqyZyQ9V0ZB65Fr/qWCLGWu2sxDMYG4pCuN4GArFlR4DDwaOTYSvT9fd3vZKow
 M480A6rYrjpznUlQZISnn761g4UV/8kY4UL0Em7bhTYNFXh/1XVIGyAQMFERVS0+SS2ntT
 tsP2HUkT8LlE9XOQaB+QmrhL4U+7l0j3r2skmoQ440sFIbnyoUKSphvxz1T6tEl5tDFSBc
 Zf6/mU8Ogn5JbumBB48OnFy+2s9f4hEi05oZzztYGcvCh52ivVPaEJ75luyg2w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gaurav Jain <gaurav.jain@nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] crypto: fsl: Hide CAAM_64BIT symbol behind FSL_CAAM
Date: Sun, 21 Jun 2026 04:40:23 +0200
Message-ID: <20260621024038.404454-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 53f9f143256c603fa9e
X-MBO-RS-META: 8j79rw9ybg4ei4ybg4uh1spjz6wfxonf
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

Make CAAM_64BIT selectable only in case FSL_CAAM is selected,
otherwise CAAM_64BIT shows up in configs of unrelated platforms.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/crypto/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index eb01c6cf700..936e4d9b513 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -20,6 +20,7 @@ config SYS_FSL_MAX_NUM_OF_SEC
 
 config CAAM_64BIT
 	bool
+	depends on FSL_CAAM
 	default y if PHYS_64BIT && !ARCH_IMX8M && !ARCH_IMX8
 	help
 	  Select Crypto driver for 64 bits CAAM version
-- 
2.53.0

