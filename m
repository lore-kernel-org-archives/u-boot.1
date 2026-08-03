Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C6AC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D546180C0C;
	Mon,  3 Aug 2026 23:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y6GZDMVB4kbv; Mon,  3 Aug 2026 23:18:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 311EE80BFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799085;
	bh=VkPrpolmgjmc03XXLyb7Vn8OaOstQa5mxPIddKwKFSk=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=RxCHTUet/k6I5Tvmz98W0/4IoWnne14MXxg1eWWIaUSF211hr9MyrAi1Tz1ECVi1D
	 5fWS9D3wgvZFqEjlMJQzJCfk/ywpTPUPXaX7R5U3Q1mdRDdgDYON+4YUkcDh2vb7Ei
	 CCkUnpy7Y7z82ljQB3gZo9x1xZbNivM2uiXZVh35uYlPiAvRYk2d66t3H5DMFnnlup
	 lm0IqeKnA6s+u4O8w2j8lWUksA6EnbLz5LRcIg2htJxy6X+5S7dSQJPOeYr9EYkU2D
	 zzAoQpWAJpGO5fhtinx5SXxJ8QV4g0vghnTOuOuhn889TikRfpeEfe/vL7Ykc/lBrG
	 H591i3s0tx1VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 311EE80BFB;
	Mon,  3 Aug 2026 23:18:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A36BB23F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 953A3606AE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dcD-ILDacLl7 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:18:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B8C5F606A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8C5F606A8
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8C5F606A8
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:18:02 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hDXdz3nQpzMlFy;
 Tue, 04 Aug 2026 01:17:59 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: cfi: Replace env_get_f() with env_get_yesno()
Date: Tue,  4 Aug 2026 01:17:31 +0200
Message-ID: <20260803231755.374057-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kozpifry3u74849h6gt6qb4m1cdzu4uz
X-MBO-RS-ID: da052a27b13489d9f80
X-Rspamd-Queue-Id: 4hDXdz3nQpzMlFy
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VkPrpolmgjmc03XXLyb7Vn8OaOstQa5mxPIddKwKFSk=;
 b=v92zXAdcIEwWcZ8u3TRDehID0ilX1WS+b6Toc2s13mxOV6PdIrRK2AySzD8/8TVmfMQWv+
 IKBAbkWma11z0IrqsmE43C3DYYguSs/cDZw//zD4n6CNNG+qIL4sDV1/T7jCnLpQk6+0nc
 b5VKHRkEmwUuCcZmBz6WuRLeqgKz8+NefdfRp2XDhM8HodLoePGmWI4YS/vbCKcHUC8YjQ
 xCyDkEtlg3v7jaB+Ml5OlLNEBLpQ41fQMqUbNwlzIus5JGiGOuH53Qav5fyEHRWpt5RUCn
 mQbYTbk84kdXALEXsNpM7UVj3hohgtxjDjB6QeHWD5/hV4pWq4sFBSycEOWLHA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VkPrpolmgjmc03XXLyb7Vn8OaOstQa5mxPIddKwKFSk=;
 b=xkZyTdTGsDt46s/GfVBLSLBMrvJAqaDVW8kLyuGCzZjqTBPWHP6gNiRGeHjV2DtCJq5i79
 uR4N8WMlUL+Nz114DxVr02936kL4s2X+RBdLxsvMan3Nd5YWtmpW2XrhM3oNMfhWIYQ9Ty
 Lo8J+2UHhLWmDQwd7ZNs0M6TOoxRZdyod/lZQDhv/UAyBSPWX4osr6fOarsM+WQZ6EpXNK
 2NeI31jw26sF6+gdg4dM6R9me53krJQJjdTolU4iLX7zTdHpPw73mpYMGTKW/ANRNOB3l8
 gkZFgu692cuAWa3RMcs6N2ulyfSabGzMYT60h+Xia6qDPsxLIKqRVvWBCgcdvQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=v92zXAdc; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=xkZyTdTG
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xkZyTdTG;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Simplify the code, replace env_get_f() with env_get_yesno(). The
env_get_yesno() internally calls env_get() which may fall back to
env_get_f() if the environment access is not initialized yet.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/mtd/cfi_flash.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
index e50502824ac..cf52abf1554 100644
--- a/drivers/mtd/cfi_flash.c
+++ b/drivers/mtd/cfi_flash.c
@@ -2407,13 +2407,6 @@ unsigned long flash_init(void)
 	unsigned long size = 0;
 	int i;
 
-#ifdef CONFIG_SYS_FLASH_PROTECTION
-	/* read environment from EEPROM */
-	char s[64];
-
-	env_get_f("unlock", s, sizeof(s));
-#endif
-
 #ifdef CONFIG_CFI_FLASH /* for driver model */
 	cfi_flash_init_dm();
 #endif
@@ -2438,7 +2431,7 @@ unsigned long flash_init(void)
 #endif /* CONFIG_SYS_FLASH_QUIET_TEST */
 		}
 #ifdef CONFIG_SYS_FLASH_PROTECTION
-		else if (strcmp(s, "yes") == 0) {
+		else if (env_get_yesno("unlock")) {
 			/*
 			 * Only the U-Boot image and it's environment
 			 * is protected, all other sectors are
-- 
2.53.0

