Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A80C54E41
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87C087CE8;
	Sat, 24 Feb 2024 23:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yORF4wLc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TanDmX6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664FD87CEC; Sat, 24 Feb 2024 23:33:08 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B016A87CCC
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Tj1qH4Cbmz9sT2;
 Sat, 24 Feb 2024 23:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708813979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzjHDSBOjhA3M8Z9Z1+L2eWghZ5VhIdHuCxIoCGgBWw=;
 b=yORF4wLcW3rjMOheDKytrx/QhRu3VmLT5p9Naguti49Nuks894NmW6FahZBrpT4MA3QdL/
 vRgjGWxYTMfoQZ+3CTu/tLGPqwgG+P3QygUYIt3UDC77YqNEktjAUCCmQotERRrNfdiDht
 80VXHNuQpKuTsLVOiOunlZKuym12LOUqAsyBtKTmth56l9+Br5aP9LfjdW3ZnUgymnyfeg
 IaTCw0pzOHMTtokV/vFfCWOZgpGLPzRAGIGCRPW/gMyUd5bvRaJuRAAua+RgbMDxys1pF9
 /DpKBxRawvIXWUNy6pOJRQAvy4hRKu67wI63wlVFf3Vd/ukuju77TA3a3Wr2Gg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708813977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzjHDSBOjhA3M8Z9Z1+L2eWghZ5VhIdHuCxIoCGgBWw=;
 b=TanDmX6b9ZOXZGdvrx7jjxskye3tS5p61m1rzOEds5aUiimdnLbNJfboxicfhuMXlpFDPo
 lQBBDU1Z0mt+ytODR5/nDUu7oz5+laAtL/lzLWSxa32t9FYQVVwy7P2g+te2X7wTevERZ9
 +VvFA0QbQPzRwYX+CfrPtWAohtjlyJDD+Dlc1Fsu2+/0gme+j9vIkcskYWumqZHH6TOZvZ
 xs2JRpm4qLa2KOvOoHREaeYXYBDIKvQ8ijMn/R9rJQxe+E5kghU9zDBSwxdpx7apVpvKqE
 PrjjUPonQmlkKKJ9HZBJreljEA5ritrHv6ZIWHBsXsJwhCk1REzcLrpLokhfuw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 2/3] mmc: Add generic tuning flag
Date: Sat, 24 Feb 2024 23:32:10 +0100
Message-ID: <20240224223235.287889-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
References: <20240224223235.287889-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dawz6q76xfr5cnbkck87z4u3zx9u8k9g
X-MBO-RS-ID: bda9ee606ecad9e8aac
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

Set generic mmc->tuning flag when performing tuning to indicate
this condition to drivers. Drivers may use this to bypass various
checks during tuning.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
V2: Use bool var:1;
---
 drivers/mmc/mmc-uclass.c | 8 +++++++-
 include/mmc.h            | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 328456831dd..304bd5eaee2 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -124,7 +124,13 @@ static int dm_mmc_execute_tuning(struct udevice *dev, uint opcode)
 
 int mmc_execute_tuning(struct mmc *mmc, uint opcode)
 {
-	return dm_mmc_execute_tuning(mmc->dev, opcode);
+	int ret;
+
+	mmc->tuning = true;
+	ret = dm_mmc_execute_tuning(mmc->dev, opcode);
+	mmc->tuning = false;
+
+	return ret;
 }
 #endif
 
diff --git a/include/mmc.h b/include/mmc.h
index afca123b386..5c1be5c5b1e 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -736,6 +736,7 @@ struct mmc {
 				  * accessing the boot partitions
 				  */
 	u32 quirks;
+	bool tuning:1;
 	bool hs400_tuning:1;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
-- 
2.43.0

