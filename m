Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA991C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 22:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB80581D4F;
	Tue, 25 Mar 2025 23:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v20jUelb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yJLHZ4jJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 626018186D; Tue, 25 Mar 2025 23:44:59 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CC18192A
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 23:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZMlNm5XP9z9t7n;
 Tue, 25 Mar 2025 23:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1eQrPAUERECiTfJ6A2igLm1USR/p0gg9NLnPsDh8zU=;
 b=v20jUelbeovx/2Ff5RuIMZhQhFxy7s2/F9cfN6H9qg1pOTWwhbzRXwC3E7c1+cL1YxfF45
 idUGXtJlVqdk4To7VL2JA+dP4Banfwuw+z2zF7eIMJtYZiq2onXTMt9gSkzEVm659bPkWa
 W0mzWF70RumWYJILRKuF8Aw6VMbltD5T9V28pxpQU7Vw8g4GwqXf+O1W7d4EBQoxpBlu+I
 1sLT73p6zNFVi1N0GJbN1Fr9IWtkETMuN306Zw1xC6V+hwAITnAOUTohOhuO9NkKkXBmlL
 zLt+6NmNwocKoFMP3m2qbsnzoyUYrbPfJ1JwtCwmFU0WK7+R4O+jvV8VwxNfIw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1eQrPAUERECiTfJ6A2igLm1USR/p0gg9NLnPsDh8zU=;
 b=yJLHZ4jJYxR86oQWhWeUrapyO8sxHw597RZtiFl4dKs1niR91XO0RpvKDaxU7wgr1Mvtfm
 7H+nG3bxk57FOjr3Xnoma1wvqfsHq/d7mjCc7nWZYrC4xXqsAlGybe0A6kZnYowpN+qgPd
 xT18pk3ejKJuIwW3BrTlNr13lZ4+fsUSlEySt2m4Qr25U8ARvnISPFBYVWnc6qvOwWpNTv
 a/Z58pB4Z88YObwSqDKdZnYq6ssjEdonw15bZ2Pk9srZaBIo7HR640Y+MTYCqcz7G5mIPy
 srEoyF53Jj92Uvn1zAjR01wy9fOPD8P3E0kBTpFSNPfOJgOlPxngMGXyyaelEw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] ram: renesas: dbsc5: Drop space before
 dbsc5_ddr_setval_all_ch()
Date: Tue, 25 Mar 2025 23:43:30 +0100
Message-ID: <20250325224433.39090-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
References: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kq1owdfd435xxy5kdwcqtdu55boqnndb
X-MBO-RS-ID: e23fdf8a8bc82f6ba45
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

Remove leading space before dbsc5_ddr_setval_all_ch() , no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index e0c4e5fe6c0..730ce79605b 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -4200,8 +4200,8 @@ static u32 dbsc5_init_ddr(struct udevice *dev)
 	dbsc5_dbsc_regset(dev);
 
 	/* Frequency selection change (F1->F2) */
-	 dbsc5_ddr_setval_all_ch(dev, PHY_FREQ_SEL_INDEX, 0x1);
-	 dbsc5_ddr_setval_all_ch(dev, PHY_FREQ_SEL_MULTICAST_EN, 0x0);
+	dbsc5_ddr_setval_all_ch(dev, PHY_FREQ_SEL_INDEX, 0x1);
+	dbsc5_ddr_setval_all_ch(dev, PHY_FREQ_SEL_MULTICAST_EN, 0x0);
 
 	/* dfi_init_start (start ddrphy) & execute pi_training */
 	phytrainingok = dbsc5_pi_training(dev);
-- 
2.47.2

