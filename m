Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7AAC282DE
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BE88168B;
	Sun, 16 Mar 2025 14:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DtcMwwHR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XhFVsm7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3322280F4C; Sun, 16 Mar 2025 14:54:48 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46DD080F4C
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZG03B0vrzz9sZH;
 Sun, 16 Mar 2025 14:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkodjEVOvWCiuT0cSReYfCA1cOrpEjvfy7/UlEtpYnI=;
 b=DtcMwwHRvV/KBAy4hgHeQiNLOt8wsTGeGgl1J8bG6DUCNOyWvyp+Uh/GWkxADM3nq4diXN
 liG9IXlJBTV+aGCzi0Phun3CMjsj556XL8VVA98BRhEVGzZjwviryLqEBa0wOKo8HqMbvt
 dubWY3D/kWj6Kc3L4BYJT/gi4QFpzs1Qgk+2m9UVSRR8Ud/qyXtI3BPXxnrKtk4NeDDvDp
 MVvJaRH6yoOOPAoSNV3hnHJPI29AgTtbGWDR8hOPExCGIsxI/MCiDVGcuB4IadW4YNCvBP
 tO0gFzOgqLE4xkEFIIEBIeC5lBcxCZ+tuWCR/ghZoFOjq/HfFBC3W3cqYi9ovQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkodjEVOvWCiuT0cSReYfCA1cOrpEjvfy7/UlEtpYnI=;
 b=XhFVsm7pE/t8BsAzrMRZwYSXkTITcsnTQcNi9L69N0HOu3If2iFocMhJouXknlCPOntApc
 rWuEA9FdskfXoGJnQsxJNe8WdeSF8JQTCZUnT90qSRfHO5QzEQu7NdtkaTnXHJot3jcxxp
 rFEmofEJugK9Xs1Rmxrn/ghkvTgXmLu6uawC+PbBXaEFEEJEl8dCL9RCXx8pexfo00tin5
 9pWC+bIIMJcu9l1U//jOuznfwedK3rm8FgdbcAJaUzEMBrcn/lt1WsFsvodTHnw6A4GmSN
 zV7I9+B7E3Lxj7WF74ZKJm/Q/klNbZ3d8OF05W5dvK78wtdY9slWVpSWkhAiiQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/7] ram: renesas: dbsc5: Fix bitrate MD pin parsing
Date: Sun, 16 Mar 2025 14:51:39 +0100
Message-ID: <20250316135417.7909-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
References: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cqfgm6epmybm6c8yg3ccsspxkk8nfrex
X-MBO-RS-ID: d9a3952c03fbdd6bedb
X-Rspamd-Queue-Id: 4ZG03B0vrzz9sZH
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

Fix copy paste error in MD pin handling for 5500 Mbps and 4800 Mbps case,
each should be handled by MD[19,17] == 2 and MD[19,17] == 3 respectively.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 210a68f6496..939775d4d16 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -4450,10 +4450,10 @@ static int renesas_dbsc5_dram_probe(struct udevice *dev)
 	} else if (md == 1) {
 		priv->ddr_mbps = 6000;
 		priv->ddr_mbpsdiv = 1;
-	} else if (md == 1) {
+	} else if (md == 2) {
 		priv->ddr_mbps = 5500;
 		priv->ddr_mbpsdiv = 1;
-	} else if (md == 1) {
+	} else if (md == 3) {
 		priv->ddr_mbps = 4800;
 		priv->ddr_mbpsdiv = 1;
 	}
-- 
2.47.2

