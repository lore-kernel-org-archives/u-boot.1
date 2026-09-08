Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D697C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 15:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 207EC80C7B;
	Tue,  8 Sep 2026 15:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKdBkJnjx5ZM; Tue,  8 Sep 2026 15:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9F91F80C6D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879900;
	b=QwBfM340d3IB1PopNmdoHOZY6LZQ2BqdjBKqosN0cjRe6Hucb+IdIPVbUcr5Zx7G825N
	 bmO8/EU6+XbUsjqliim6hK42GclD7p7bOueM0yIHaimkZ5TJTgdQFiZQIndUgHl8MN2I0
	 gVnbdqT66RXq9OebGqW2nehpGVUHTFDOuMQbIVpZENK72X+QD4M5D2b4z3xy5URCJGKWE
	 CY18mwFGmLf1oAAcE88AfxvwpGXaZuo970Nkq9RCHvn1cALIu9lOj2LXMVvnX0USaS4ND
	 eBuhnyflBeziOUsb9JytHZshjV+1LHnIujwMXQ6P8I7RJ5IhUUqg8UWbuJXa7FLFtCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
	b=n6dAlCIb+Xdd8dWPZbqr2bmDkYJTE23JNByjFr1tEyjEU5FZcJn+CAmw7DjW98j5Tj2l
	 Xge/1noQadI0oYyF92T71ZWa1PR7PPxWcikENx72rbMS7bDLeVFWCepQN70tIBQOSI3iB
	 +xBK3VI78lCyl9svFRx1ZscgIhCsMUkrgMYiU0URbGncjFiySxUl8v4Xj0AA1SwLHBHjp
	 TZs+Bvc36N12fo8W2IOjf50WEkOPDc+VH81KLRLdePbNUsHldRm5I09MVI5i/VI9b551V
	 YSVxfXF1nX6enV3BR6MzRZ2611gsa5vsf2Zm+bvhu7u2Q9buRTc/iI3z4dEK4Ei5fOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879900;
	bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gpGpb5oJBm94KMOka5BY5LeS3rifpupOvKXMMkOe536IzVDTPNHFUFM2gYB8NXxHN
	 m9LhC7ZcL/zByIr49+oqPDPdgMay9NvwG2xTc6C3bJVzYwJcyq7nG/otgFYH1c5+Qr
	 ityrJ5spqyOyOnLKMhOPFL7/buLy2gj/8djr4jdATANBgHkxg/p3J556WaCXA7k+mT
	 E2Bh9BfuuA2r2rDQImjGp90FxOLXdi0/XCbGIsKJ4sHUGxTo450K+xKiq52mvDsBU/
	 FBTFdhg/prjnGkJ/qsmW9I2AsiZVszjGqHYKCh857CIbYMjvSNiYofFGLZcB7afnLS
	 0u8skYrq80WZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F91F80C6D;
	Tue,  8 Sep 2026 15:04:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F79ED61
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61BDC606F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x58duZNfUxqv for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:04:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D2DF660710
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788879888;
 b=NfDkyD5+/tgRXSqlhCr5laJjj8MmfprmeesKwqYaouTzLU83J/Y7W/zOZmSlSF3JHC3V
 FgtU6hHZ1LtCZwx97p5kVS5PqD4DwoHiceNEr3wxLs86HECUXLQHb06vqKGw2kTigswXg
 VDQ4HiznRMd4o+StbOpanm7iQ9dIvi61Djy/QYXkNdV74WRRsLQkV9klFDZKl9wac25et
 Vh8iwbA+eK4XUSZ6C/v46+daKr5c1dq4Wkf0z888OfQEdu7hdlCJwk3FcUSI0Mrow4tkq
 NiMRXGwQSlWr6/nVN3nECp/kFXIQyRGnBsk6ZlIdqFKDpsiTsfE25hu66DbaXRV/7mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788879888;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
 b=SqRQ1xgey7l5UYfyr/GzgYcRFhVuZ9WJH9/8t0xn3YqLwwj3XW+mK2yViq2j7eziBAJR
 fDk/Eh0+5oslB6txxSGzGIyjzaFS2sDUyyEmFvHgm9TMMSLwrt7fPk1DheSzhaTiFLbjy
 5o58dfVCwt5nXb178rv7VsK+lkIjmuUwnoVJ28omd5tTzbETjAYGjXOypVM57r1+3Z//8
 mjvl3CCieCUPRq3nVoipWTvGP7Ds4tUDqtTfryIdYfNqJ1aM1ksOkyPcKHeWr5d7CzYPX
 6p/pTJid6/hvaakSElDHqSQ2bsX4pjOmqw0BhiE0jQrah9SSpEPHYocHszPBU0zZZxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=czLNl5hK; 
 arc=none smtp.remote-ip=185.136.65.226
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 15:04:45 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=czLNl5hK
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.226;
 helo=mta-65-226.siemens.flowmailer.net;
 envelope-from=fm-294854-202609081503398f33e6db7400020718-cizx4n@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2DF660710
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:45 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202609081503398f33e6db7400020718
 for <u-boot@lists.u-boot-project.org>;
 Tue, 08 Sep 2026 17:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=G1fY8U63nje64VVx0XCdA0l8k5Fts2JRQXMEAKXNPlw=;
 b=czLNl5hKXJavLAW5NxdI6L0Vr7pPWwRKc0FcS+hO6LPJfeY848Ptvt6Ub5I+AkzEGga1fj
 OdSYzZq0vbHQCdxY8wAqA713swdj/yb6GLb5GMgazTG3uop/vG4adqpb+ceXzcTgjgDcM8tE
 OHJIjXLuWwH5Z3eHiaaGlvwYkzSSGtjovzJL0nu8EPJP2d4xWmRBb40s4tRr+QwslTirEW8C
 eGDH+z9rfCSaaI/Hz+RGzHlDGqiya2HdSXUyCTUGV7Ot987ldXRy6CnPNB+CeLjSdk+7ihmQ
 FTAB6/HuYg0IZ6T4tJPJb1O+9waePLqhGogCS9jxjNH0VE1BbQMmxezw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 4/5] mmc: Call back to optee after a successful mmc_init
Date: Tue,  8 Sep 2026 17:03:37 +0200
Message-ID: <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1788879818.git.jan.kiszka@siemens.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed to that OP-TEE can re-enumerate services which need RPMB
access that may have become available now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
CC: Peng Fan <peng.fan@nxp.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 670e92ee12b..2463e50cd3c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -27,6 +27,7 @@
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <div64.h>
+#include <tee/optee.h>
 #include "mmc_private.h"
 
 #define DEFAULT_CMD6_TIMEOUT_MS  500
@@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
 				mmc->cfg->name);
 	}
 
+	if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
+		optee_rpmb_available();
+
 	return err;
 }
 
-- 
2.47.3

