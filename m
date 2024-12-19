Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3039E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8008021A;
	Thu, 19 Dec 2024 22:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sl53PEkc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QJNzlsVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E14C8021D; Thu, 19 Dec 2024 22:22:20 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BE580196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YDk5j1sC7z9t8l;
 Thu, 19 Dec 2024 22:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734643337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1Y8P6i0NA17tOa3dbiT1QnS90vxJ7q9UB+m8/gB4C8I=;
 b=sl53PEkc9Of2prIqOwwEHZ+FGyDBOhjw7mLzBwdfGdLy5tfBBVXBAYL7XK04gZpdE2nJFi
 /ioH3iJupMErZ+t/rLxfihl9oztX634fL+CXBp0FpnBRfuGAjTlUcY7MLfRFADhPGluKmu
 2BaVXWn0MoXk7fWEK3zIzCExQIdL3aScLUXmi9i1Z8YcV41N6tYncQL5owB5BSdnXFC2z1
 4mM5jp+vXAZ1ycgkElb9lEUhvqVEdphKocgYt/vJOuDg4Q1g+Uy2XReQB+zsjORVSIK+sF
 Uq55DLmfTi5EtsadZE2wN21jko1W/wpb24hVA299oAYiLb/KrIBB5LJz9hz9dg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734643335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1Y8P6i0NA17tOa3dbiT1QnS90vxJ7q9UB+m8/gB4C8I=;
 b=QJNzlsVfpse6VuF5qo8UtIZYJXbKV6GrZpq3WjPAYdJhUeUcWDiF6IKw0E1CsxJgLZAv8Z
 kGITdTOte6soDZ5YRtE402h2LwiPj3fHxvZiZVL+3dKBtb2+BxvN9jjLKzEza7P1vHvfsE
 +HQySDvtuFcWWbAKOao/E23NTOKRDuQBxADKOFRx7Pkg4aCFZ4bclIM42ZT4V0QYuM0zhk
 RzOY9Tmt39g14tLYZGzR1fYNYgNgcXjAELaAENJYD7vXj4R5EBNXtSF9kpjK3Y6hxKwIUA
 XluZ0pKak5phQvSzzRLb+onZKRRMY3rUR13E6ZB+vp9wceF+Fs0setAUawZ1pg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] net: rswitch: Simplify code using clrsetbits_le32()
Date: Thu, 19 Dec 2024 22:21:42 +0100
Message-ID: <20241219212201.94695-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3161e1643dd41d237f6
X-MBO-RS-META: nyxzu18kmdsinhar6a8u7fneft694of5
X-Rspamd-Queue-Id: 4YDk5j1sC7z9t8l
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

Use clrsetbits_le32() to make this complicated construct simpler.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Drop the now unused 'reg' variable
---
 drivers/net/rswitch.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 259d584ac98..247eb139ff9 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -417,7 +417,6 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 	struct rswitch_port_priv *priv = miidev->priv;
 	struct rswitch_etha *etha = &priv->etha;
 	int val;
-	int reg;
 
 	/* Change to disable mode */
 	rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
@@ -426,9 +425,9 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 	rswitch_etha_change_mode(priv, EAMC_OPC_CONFIG);
 
 	/* Enable Station Management clock */
-	reg = readl(etha->addr + MPIC);
-	reg &= ~MPIC_PSMCS_MASK & ~MPIC_PSMHT_MASK;
-	writel(reg | MPIC_MDC_CLK_SET, etha->addr + MPIC);
+	clrsetbits_le32(etha->addr + MPIC,
+			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
+			MPIC_MDC_CLK_SET);
 
 	/* Set Station Management Mode : Clause 45 */
 	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
@@ -449,7 +448,6 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 {
 	struct rswitch_port_priv *priv = miidev->priv;
 	struct rswitch_etha *etha = &priv->etha;
-	int reg;
 
 	/* Change to disable mode */
 	rswitch_etha_change_mode(priv, EAMC_OPC_DISABLE);
@@ -458,9 +456,9 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 	rswitch_etha_change_mode(priv, EAMC_OPC_CONFIG);
 
 	/* Enable Station Management clock */
-	reg = readl(etha->addr + MPIC);
-	reg &= ~MPIC_PSMCS_MASK & ~MPIC_PSMHT_MASK;
-	writel(reg | MPIC_MDC_CLK_SET, etha->addr + MPIC);
+	clrsetbits_le32(etha->addr + MPIC,
+			MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
+			MPIC_MDC_CLK_SET);
 
 	/* Set Station Management Mode : Clause 45 */
 	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
-- 
2.45.2

