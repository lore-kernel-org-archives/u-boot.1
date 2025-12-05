Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6C3D2F7EF
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 13:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F0E841F2;
	Fri,  5 Dec 2025 14:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FibaC1ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC78E841F9; Fri,  5 Dec 2025 14:37:10 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E390B841BC
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 14:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7E1641A1F92;
 Fri,  5 Dec 2025 13:37:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4BB7A606AC;
 Fri,  5 Dec 2025 13:37:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B75810B60851; Fri,  5 Dec 2025 14:37:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764941826; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=q8VM02h7VzdMJQi3gzfFiXY5Belti4llsP//Xb39LRo=;
 b=FibaC1ZH7Bxi6J3Qqmno8LSiVTGH1bEJ+MC62kK4CJDdr7t+dmJ4dXcN9taBquV1Dcv8Uh
 crHFm6YZBaMcAePLktjhTNaZzGmE19Ljwd9fRWKMs2lpluxDYrfbhWOuXjFd/F227S5OOj
 76OQrtIHTR1ttvQobIV6ylBv44DdE5bTTCXjiAOTv7A2v1xmggdjbq42pkBAwwZJ0r1HKT
 wTMUu4IFvTNz0XTlF8cZnlA8OF/0uc3j1RCx58fwvWHkWCl9aii99og0MMfyIPdBgAlieG
 bGgNovK0n0mLqZhCqYgTYVZ2l61BYBmMecNpdiwdsJCqSrcUSPH6i6gUh+futg==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Heiko Schocher <hs@nabladev.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH] i2c: stm32f7_i2c: save some ms in stm32_i2c_choose_solution
Date: Fri,  5 Dec 2025 14:36:41 +0100
Message-ID: <20251205133641.2052099-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

In stm32_i2c_choose_solution, the double loop continues even after a
solution is found.

Breaking out of this double loop once a solution is found permits to
gain some precious ms.

This saves about 13ms in U-Boot.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/i2c/stm32f7_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/stm32f7_i2c.c b/drivers/i2c/stm32f7_i2c.c
index 3f51b1dd1db4..cb5e2c0e31e5 100644
--- a/drivers/i2c/stm32f7_i2c.c
+++ b/drivers/i2c/stm32f7_i2c.c
@@ -651,11 +651,13 @@ static int stm32_i2c_choose_solution(u32 i2cclk,
 						v->sclh = h;
 						sol_found = true;
 						memcpy(s, v, sizeof(*s));
+						goto end_loop;
 					}
 				}
 			}
 		}
 	}
+end_loop:
 
 	if (!sol_found) {
 		log_err("no solution at all\n");

base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
-- 
2.47.3

