Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F3606A332
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=my66D3WK;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LNuqwuRh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CF5681138;
	Tue, 17 Nov 2026 14:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQhUHhQqkco3; Tue, 17 Nov 2026 14:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9A5881134
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794925686;
	b=TZaEaCFc+TKPK/ikodCYp7EGxoB6kW0oOw++ZbpdOJzIy+uHZyU/9+3qm+KJjzOj1j6Z
	 liKZ8ilkD+G/4kLPIVAHdIeZhmfhJaXa3tVoXD1mcz1Rq48rfmzqvmJEh4CcXTgAWuQ0J
	 2C096erm7Ng1wa2I7MQs6ik0oMyfcVO+WZZAEj3G71O6GZvnypwoiKFUAY5cap++gZSU2
	 PszWCf2HRlVYDCveRZ9xcMzQepk6+pGy0trga1T6PeuCJ2JJ2SDe0xCiqDollupOJxhZG
	 0jopZkkmdVlTb+3DkH6IMxRg+eX/0+O/E2zURAMUtQu+mgLWXdUXw9Fh0JIpZtLwehw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794925686;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y2LaKWWPDN7CXGl8fGfc335yxsokMV29WG6cAAhASP8=;
	b=AyayYCTSHIRwlNtJOkZ7bMQvevVc70iO2Zs9bPB8OQ8Zb6PIfHZ7iEWfVWys+bmYEwOc
	 hp4S5+fnZcxh9A8x39Miwn7GAGPTuqyJnUUkRuABaFYd2s6D8kUd3fG0GvfJ10p2rwAmc
	 2R2rAKdyQlHzXaKtUzE5B32WTpgduAO1/fpaMWT2cP1cwKH4LHzafUluIAxvN7aoeSfgV
	 SpX6dML9aOfoZ8fnDuKC9JF58qAwDGPu75Jf3ellQgl3tmIldYsVZ1YVhhc+p370M8nAp
	 5JwlCZzpu022N4SFXe/1UhHFGB7rcJjv0hNss4x8H0bgXZ78mZqJ6Ih9dBED0+spdCw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=LNuqwuRh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794925686;
	bh=y2LaKWWPDN7CXGl8fGfc335yxsokMV29WG6cAAhASP8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=my66D3WKbKvWXIuZ14SFhaZbmSeyn6mOnPR7h7iggfKKcCcmE/4O8sgfRwCMSYy4h
	 1gj8vsgHCCXIVK3i683fnbhGAd5KuqiH04JtHT8zOWgDa0D0FNX6Mwd5U0N6MtixNw
	 ZyxS4aAMxuxQKWd/W7dFjuUMrgqWMRaMFnLEcnqDhKEmLVioEhd3w0FcmoEnCjhJkQ
	 PTk7rQqucwMwLTDUxoeyZNbk8hV+XDAUg4nn3Z2oAHvAKBax0FqjP3jgeoFg6pQGwz
	 7n7a15uwCNzyxee54a6JVHfnC+46w3BVTD1aeywhyzxoQ7XbZtXrIkgHgwJ4SLSeQz
	 N7DPDFio+E7DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9A5881134;
	Tue, 17 Nov 2026 14:28:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9125170B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 833C381134
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbGO5LUuZxMt for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 14:28:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 457EE81132
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=LNuqwuRh
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 457EE81132
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 14:28:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0A3CC1A15CD;
 Tue, 17 Nov 2026 14:28:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D3A7A5FD6A;
 Tue, 17 Nov 2026 14:27:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED52D11BC0026; Tue, 17 Nov 2026 15:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794925679; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=y2LaKWWPDN7CXGl8fGfc335yxsokMV29WG6cAAhASP8=;
 b=LNuqwuRh4020wWNLtcH4vmUN7tWwVb8qRnqZZ15pM9birxlJFWapKBlLKiGntzA0IEyNG7
 oyjIXK9gKWE1KRVHKWeF3uqUkWTEDPKs5tGE/XF9GT/391JYPoxlMLtxqh6qLBWlTzQJpF
 U3ovXzILtDE9Uo/cFxq69f6MYc0Noe+xrA5CpCURcH+maRhjY7bgKiqcG7nkGIr9A9gThn
 FMkJL03BJwcH1wr/MUO2SaTFhOPN1Cc7zpNlLb5Hk5cVcUPHFORicY67t/fro9k3QJxq3w
 DnlrmTDKbmv2jThPFgyl2PFTKr5JYgwbbSOLaq7adXEHqJ5kX5xGSPGMTYh2aA==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org, Terry Zhou <terryzhou05@gmail.com>,
 "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Subject: [PATCH] mmc: snps_sdhci: Add missing sentinel
Date: Tue, 17 Nov 2026 15:27:47 +0100
Message-ID: <20261117142747.219005-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the missing sentinel in snps_sdhci_ids array.

The struct udevice_id should end with a sentinel to prevent an
out-of-bound access.

Fixes: 1cf3e900affa ("mmc: snps_sdhci: Add sdhci driver support for TH1520 SoC")
Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 drivers/mmc/snps_sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/snps_sdhci.c b/drivers/mmc/snps_sdhci.c
index fe834ec29692..4c1a7f1892aa 100644
--- a/drivers/mmc/snps_sdhci.c
+++ b/drivers/mmc/snps_sdhci.c
@@ -429,7 +429,8 @@ static int snps_sdhci_bind(struct udevice *dev)
 }
 
 static const struct udevice_id snps_sdhci_ids[] = {
-	{ .compatible = "thead,th1520-dwcmshc" }
+	{ .compatible = "thead,th1520-dwcmshc" },
+	{ /* sentinel */ }
 };
 
 U_BOOT_DRIVER(snps_sdhci_drv) = {
-- 
2.55.0

