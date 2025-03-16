Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D9EC282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FED280ECC;
	Sun, 16 Mar 2025 14:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OW2JjT7l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mYPqcFle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A590280F4C; Sun, 16 Mar 2025 14:51:37 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B469380C93
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZFzzW3rzCz9sGQ;
 Sun, 16 Mar 2025 14:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gophunncjbljYTZJBb8wIsIVo3KgquSWafoNP9WB1cg=;
 b=OW2JjT7lpZuXptFag7BUlju8IgHLcR3o//txanh07XV6MasqfQasfEILCzuySEVnuVsJqh
 NT06f7pIKd09gX7pf5qUWaKns81/oQvPREmzaJUMCdzTB3qDlQKpf8yV/wGjMELhkuBAX+
 XwJZuoJnpIcRuf90DrjZtHWeFWg8/wKSIjX2rUp6CBeE86w89PQ1KLObX94i5n1iu+LcO2
 tEhX3bHb/wzlKObr5w7pVMMyNqCyKGURPNg8l75tfTc4CUOP9zzCfnfLHGJt7z9PyLJXgM
 GGhF97NGrvVvuKjOpbylpsH6Dq1PPw61UyrUV/W0ZBTlUKi3s2hZhrzl8sN7Lg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gophunncjbljYTZJBb8wIsIVo3KgquSWafoNP9WB1cg=;
 b=mYPqcFle/+GsG2XYC8CDkPXtB85rO4/Hs5yCb/RTynkElzhv1/7r/s6aZo39FXQtJy5ePD
 60dgwvOImFyNZeCjnlkvsIeEZDn33vQQ65MdbAXwvjKMmxp27fL65p+h7vOHR99jcNoXlL
 Pet9CC9inRfoxXkyt9l1pOL++bdqAkIaZtc6z42+rSS9aWq+zVeB2bn02lZ5Z/5FLDrRqc
 cGXcDf6mmSYh3Bk1MGmsnBW1qNVEBhgz/DaUO4ysCkiQ0a9IXGmzExe9tM9xb+KBMQayp3
 V3WJEJQeYJtcaK9tlgRt6+2oUjvyTy4migQsvOPc8gqPUkucXlkf60Etxr8rgA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Drop stale R-Car V4H SPL implementation
 description
Date: Sun, 16 Mar 2025 14:51:09 +0100
Message-ID: <20250316135124.7881-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8f4503d5da1f912cfc8
X-MBO-RS-META: s8pnwnyem63s77ntmfwurc8oyao3owgf
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

The R-Car V4H SPL implementation was originally running on the Cortex-R52
core, but this is no longer the case. Majority of the SPL now runs on the
Cortex-A76 core. Drop the stale description.

Fixes: ec53fdee5bec ("arm64: renesas: Add Renesas R-Car V4H SPL implementation")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/common/gen4-spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/renesas/common/gen4-spl.c b/board/renesas/common/gen4-spl.c
index e46ef0a3075..ebfefab7253 100644
--- a/board/renesas/common/gen4-spl.c
+++ b/board/renesas/common/gen4-spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * R-Car Gen4 Cortex-R52 SPL
+ * R-Car Gen4 SPL
  *
  * Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
-- 
2.47.2

