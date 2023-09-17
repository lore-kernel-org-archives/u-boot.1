Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E4BCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737598662F;
	Sun, 17 Sep 2023 16:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RKhTjjBs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XIkufckc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2360D86611; Sun, 17 Sep 2023 16:09:15 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF54866DC
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVCs00jtz9sQ8
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+vCxcr9fr66y3vmJw1NUX/2Gv8Rz/TNepoSHfur8S4=;
 b=RKhTjjBszVKhESDYuwVK/jHE9tYVBik3Kj4zXxd3r+lkMKcn8h+mIsA+vv4e1XdbMxMuD4
 KPoVO58aru+NnwvFUNQrqLj2t+NJWk+/Wce+J6WsACz6BEd+fsf0Clpmpganp/h3P/vgIC
 iUa2fxtoyJ4Y0JRkveiP/fPHPxQRSt75+wAYcxhi3fR19z3rqkQtIqOzsPk7+//GZrkW4R
 kHVSrFW78brgcc1ZUCjrBlmaS67wm5hQyRukGRztp78MueptLTpaeVltuIdPl6Ex5H5o9/
 JA84+Td5Uzd/nHDlHMlgNje+r+uA6fYjPglOxwhjKXVPR3msPD5JVAc7dkZ9Ag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+vCxcr9fr66y3vmJw1NUX/2Gv8Rz/TNepoSHfur8S4=;
 b=XIkufckctwxFTAEK55jFuR0u7vrQHva2uTv1cEiaKrJMYhA94eRP2uyb+uJRRLDvvwE13O
 qS4VSQuZiKhugKns/KQlZOyTW/jvL330o7FPTDudaYwZuBYb5W3pzWX0n7h8N4qDeOgnT4
 AvZFBCdqqEuMcYIVK6Jb81JMb65mee1X52Kr2FMgSFuI+iRvMxF/Vm2WBz4XDScShcSvZ5
 9dvkhIdlNFaTmLuUumoGkyxM4dleO6pJyTkKotnaP6KVzo91YI0Mp6dNMVsLpZy8U8tMAC
 +fl498oHbL9KlFWdeE96ZJ8G/Hf3VZ6ur7FvTxQvGhvK6kEAU6albo5Z0kIKZQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/18] pinctrl: renesas: Synchronize R8A7792 V2H PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:38 +0200
Message-Id: <20230917140849.379711-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mrbmbspdm9xb9fq9xnkwfh5ow9418yhp
X-MBO-RS-ID: 611eeccc81db6ef1d0d
X-Rspamd-Queue-Id: 4RpVCs00jtz9sQ8
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

Synchronize R-Car R8A7792 V2H PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a7792.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7792.c b/drivers/pinctrl/renesas/pfc-r8a7792.c
index 81cfe81c7f5..08f1f97af6e 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7792.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7792.c
@@ -2629,7 +2629,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* IP7_1_0 [2] */
 		FN_PWM0, FN_TCLK1, FN_FSO_CFE_0, 0 ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_bias_reg pinmux_bias_regs[] = {
-- 
2.40.1

