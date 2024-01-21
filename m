Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0051BC47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA388777F;
	Sun, 21 Jan 2024 18:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gryIbXFJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UNQEy1yX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83468783B; Sun, 21 Jan 2024 18:33:27 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A67A876B1
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TJ0nK64r1z9sT7;
 Sun, 21 Jan 2024 18:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SN8L1Wc3ejPKLJXCLmmY/cPxCuENpKyL6osb1vMqrj8=;
 b=gryIbXFJMtjCtTL2Tvw1ZJabhctXqtyHsrmho2DjUwqHW37St+p36N3zr9x4cnY6+LQ5aj
 B4rprz01FDXlzM06CihCZT4d4qppk8ViWJh20fZXFBZSpmZzvhxYGloNvBAP8Qh75JfDuI
 u+v+XBiJyyHg7C1qYpVHuCXXATHh2g7zowhf5A+WZSf3PWxMHRd7HNHP7+ABzrHS/ZSj+b
 02aRd9na24Fd7vBhrEDu/KpdabKNg+gPN7cEYEhFpfrueylEf1i5ELbO1GajAD7Lz3g0Hy
 kNe3+CmQTbpV1gdwHO4L4tYwM0hihoOalvGpA3ZJrRvAM7EEDuFSgx7oOsRZNw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705858404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SN8L1Wc3ejPKLJXCLmmY/cPxCuENpKyL6osb1vMqrj8=;
 b=UNQEy1yXSqQ0n8ZApe2E8r67S2s8fU07XN/CrSr7ShvYCDZ55Pr7hFxUJlO2+pZ5rBEdTE
 Fsw+ZzDVa6LjWqL/pY6PaHNszZJUb5rI6f6pb/LkxV0tWY66hAAci34lHBjolLaHKLJQb2
 TcTJR8Y+7bO2ib79x+9ot/Gp6Gk0eIZRNmDtYJBX3cXXCjUt+nQrKy7rgpcRZDoMlIGyJi
 FvSJqpZWIekI1kavUFplt1h6LsRj4csGzns/kHV/HLEUV73+hrvw3dYXqufuVS6exdHWm3
 eeJi4wRsuj29/EmqdM8V07comsxLx+6j10XGE4b7gP/I4vIPyRej/alJwqU1cw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH] ARM: renesas: whitehawk: Drop extra leading space
Date: Sun, 21 Jan 2024 18:33:12 +0100
Message-ID: <20240121173316.273796-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 62f3113f83a456029fa
X-MBO-RS-META: oed6h7hkxn3fas8t97torti68gbbkxtz
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

Drop leading space in front of a comment. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 board/renesas/whitehawk/whitehawk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/renesas/whitehawk/whitehawk.c b/board/renesas/whitehawk/whitehawk.c
index 3423ebd2995..a72f5e0a7a5 100644
--- a/board/renesas/whitehawk/whitehawk.c
+++ b/board/renesas/whitehawk/whitehawk.c
@@ -31,7 +31,7 @@ static void init_generic_timer(void)
 
 static void init_gic_v3(void)
 {
-	 /* GIC v3 power on */
+	/* GIC v3 power on */
 	writel(BIT(1), GICR_LPI_PWRR);
 
 	/* Wait till the WAKER_CA_BIT changes to 0 */
-- 
2.43.0

