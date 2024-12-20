Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7AAE77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0AA80328;
	Fri, 20 Dec 2024 01:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D+cNngQV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lxILWdIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593078021A; Fri, 20 Dec 2024 01:50:31 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB9180312
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YDpjw5t2vz9sp2;
 Fri, 20 Dec 2024 01:50:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734655828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyUkFN4Urqxiin4XNyvTlt6mvqBlfO5kraDsNF4HNeM=;
 b=D+cNngQVYCxSkTW+RNlzLfiXCI7FoL5UTrpXDf+ypSDbn25ZIk+Bgz8a+NrDOYc+BE73je
 dsa27+nYKHd/6e0byJQwwe4+qz8edigFagtC1wl+vxHgFoQvgQFl55stEXb/STD/Lv3aXr
 HNpim8gIHAQWgFJsjKTuynEC7JIPi6WhL3vmxkzFfzkHeQmP5NvTZRte2MTltd8HOUGwFU
 iWGHR/t8ZncyowKveaCSSLbwkQ+bCPN+aM5Q8YWjiPE+zCEwOuqn9dk5myRjZts6N/IFlC
 wg2Z5eF62T4d2f3JMcoEIT/ifmyCFZjNRIGk/5crwRBm5qisa25soBvVhK5sCA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734655827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyUkFN4Urqxiin4XNyvTlt6mvqBlfO5kraDsNF4HNeM=;
 b=lxILWdIPrMNcHJr99ndELZrz9DQPBGtVuO/YZHGa/ZesQlHawIUZRqrNWZg+cpA7GQtG6p
 45nnpbGDeJbt2m+tKzrfmY60Vsq88YyoJoovVrqTKaeHKwzgzsGKfzZtXeLotRCnMexzCr
 iLo1Crl4iiYNs6f1J5H8dsz4YtIto8p/3KIxAJVQAflECwh5pqNS0x3+FBvybXI7kjy9JT
 OKwkBWas0pvwxoVpDmrT34EDZ29M+WxbZLWYFE2fOntWHfvmkBJhxv3uUQzRYn6mhlcWeu
 n/d8vNlTRoXSEnSjvryyEaEZfyHSugz3sv7FrwcIMKNpF4hyh3tzc9HciSOhyg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] net: rswitch: Add PHY C22 access support
Date: Fri, 20 Dec 2024 01:48:41 +0100
Message-ID: <20241220005007.169383-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241220005007.169383-1-marek.vasut+renesas@mailbox.org>
References: <20241220005007.169383-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8d1c550c6b97e801eac
X-MBO-RS-META: bfjsasurofmqqf5ojiez79riajha3yg8
X-Rspamd-Queue-Id: 4YDpjw5t2vz9sp2
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

Implement C22 PHY access support in addition to C45 PHY access
support which is already present. This is used for PHYs which
do not support C45 access or which are C22 only.

The C22 access can be recognized when devad is set to -1 or
0xffffffff hex, which also matches MDIO_DEVAD_NONE macro. Test
for this special devad value and if it is set this way, perform
C22 access, otherwise perform C45 access.

Based on work by LUU HOAI <hoai.luu.ub@renesas.com>

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 5dc5de15f6f..df0c3864b59 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -355,16 +355,50 @@ static int rswitch_gwca_change_mode(struct rswitch_port_priv *priv,
 	return ret;
 }
 
+static int rswitch_mii_access_c22(struct rswitch_etha *etha, bool read,
+				  int phyad, int regad, int data)
+{
+	const u32 pop = read ? MDIO_READ_C22 : MDIO_WRITE_C22;
+	u32 val, pval;
+	int ret;
+
+	/* Clear Station Management Mode : Clause 22 */
+	clrbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
+
+	/* Clear completion flags */
+	writel(MMIS1_CLEAR_FLAGS, etha->addr + MMIS1);
+
+	/* Submit C22 access to PHY */
+	val = MPSM_PSME | (pop << 13) | (regad << 8) | (phyad << 3);
+	if (!read)
+		val |= data << 16;
+	writel(val, etha->addr + MPSM);
+
+	ret = readl_poll_sleep_timeout(etha->addr + MPSM, pval,
+				       !(pval & MPSM_PSME),
+				       RSWITCH_SLEEP_US,
+				       RSWITCH_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	if (!read)
+		return 0;
+
+	/* Read data */
+	ret = (readl(etha->addr + MPSM) & MPSM_PRD_MASK) >> 16;
+
+	/* Clear read completion flag */
+	setbits_le32(etha->addr + MMIS1, MMIS1_PRACS);
+
+	return ret;
+}
+
 static int rswitch_mii_access_c45(struct rswitch_etha *etha, bool read,
 				  int phyad, int devad, int regad, int data)
 {
 	u32 pval, val;
 	int ret;
 
-	/* No match device */
-	if (devad == 0xffffffff)
-		return 0;
-
 	/* Set Station Management Mode : Clause 45 */
 	setbits_le32(etha->addr + MPSM, MPSM_MFF_C45);
 
@@ -433,7 +467,10 @@ static int rswitch_mii_read_c45(struct mii_dev *miidev, int phyad, int devad, in
 			MPIC_MDC_CLK_SET);
 
 	/* Access PHY register */
-	val = rswitch_mii_access_c45(etha, true, phyad, devad, regad, 0);
+	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
+		val = rswitch_mii_access_c45(etha, true, phyad, devad, regad, 0);
+	else
+		val = rswitch_mii_access_c22(etha, true, phyad, regad, 0);
 
 	/* Disable Station Management Clock */
 	clrbits_le32(etha->addr + MPIC, MPIC_PSMCS_MASK);
@@ -461,7 +498,10 @@ int rswitch_mii_write_c45(struct mii_dev *miidev, int phyad, int devad, int rega
 			MPIC_MDC_CLK_SET);
 
 	/* Access PHY register */
-	rswitch_mii_access_c45(etha, false, phyad, devad, regad, data);
+	if (devad != MDIO_DEVAD_NONE)	/* Definitelly C45 */
+		rswitch_mii_access_c45(etha, false, phyad, devad, regad, data);
+	else
+		rswitch_mii_access_c22(etha, false, phyad, regad, data);
 
 	/* Disable Station Management Clock */
 	clrbits_le32(etha->addr + MPIC, MPIC_PSMCS_MASK);
-- 
2.45.2

