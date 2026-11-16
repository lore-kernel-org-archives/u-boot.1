Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EF606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=npt8/LBm;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sopypHKS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B380181005;
	Mon, 16 Nov 2026 17:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KA1Ygx5ewESt; Mon, 16 Nov 2026 17:39:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E281381004
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850785;
	b=b23INwpcks8odeKWLcqCCWDKV64EVZArzldU27wjyExMhkXft31Ir18mC9uOSYNm1+xL
	 w8RxNh7wiLvyrGhxI2lAm0Begzuw42tu72hCOuRhZAqVkYkYyAVam0sgZ0a/drASVaMeU
	 7644TRgWyrjoT11pCtNpwnxQqYgIfePdu6zOW13vJ/k4WFBoNIlO46O3uGC/8cySM+dfD
	 UJZ15lIwBU5RskIEed40Uy90SuT55uuKGQeAHeX9gEN1oj/8Xk2lxnIRMdndnaz0D+mi/
	 B6h84gcNPpfNa7soug9KFVAuX7yoyh6YQbuSY67zhVI0FuZdeTO7PEnmJeIjVF8s9Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850785;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hlc4hPg6erJ5/454tyDwhqWdsMNRdwueqtcMMQ1VdZk=;
	b=huqXbsn3Jqkqg/5gpinTzMIKdOXJQWcxisfJOd6U0tp9xBOX42QsYE2hYVuXuSHSit2G
	 N7UQa8i5HxUdSdbphwpNuTcxaVUA6tf4EY6YVGf9YYvYd3hBZAp6eShSbSHmp5PyiAPMF
	 BLc2kpXjuugv1aDMRVqI1lqXXDRmlWXUYYRNjfY/P7MXFRbYUIAV2o5/oGdT0Be75yXY+
	 CRk3SqCVcC/j+MhOgyCnn8+VQCj2M3fIRoLAahHWpV8SI5aD0fB91zma+IZlB8i9APtCP
	 aTb0nxBCyRbP3QBvE3hrpOO9Ydfjkn+CrdGnNiUdMgZOD1uqSW+GBIsStS337k8m5Cw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850785;
	bh=hlc4hPg6erJ5/454tyDwhqWdsMNRdwueqtcMMQ1VdZk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=npt8/LBmLkGzK/IwEBtRyiGOHpd2qzZ1yq4wXB9zMot/WPqV4yHR58dD2BX+xpzF/
	 0Ptv1FxuGP+N7MHCRbbJolJD+NBqxrj5w0EgUsRueGqUBWqrGHiThr0K2dSMMLLTcb
	 6OahwBBedHPO0+PS/x1k9h29fRPhHN/E4b4zxPGnjX4z5A6C1ar/GSeQMwhTtTlTGH
	 59bVthUNt6Bn/Fr6/XivKId67Xsh64Oy9I4dIr+UXEWNSSWZ3tyWnzxwnB17bDAKLI
	 /kGXN+N5TWpHHL+iPNb3qQ+NgUmSu/IOWwdgpBQM6A/ivpOw9EBSzcM9qti9bEyuFH
	 wCcb20aKm9VBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E281381004;
	Mon, 16 Nov 2026 17:39:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FE33176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54750407C4
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2UiqPk7jEtLI for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:39:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 809D3407C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=sopypHKS
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 809D3407C5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:39:42 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSw9670ygzMlkn;
 Mon, 16 Nov 2026 18:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hlc4hPg6erJ5/454tyDwhqWdsMNRdwueqtcMMQ1VdZk=;
 b=sopypHKS12Y7m4/CNoWknlu044qMtZNA8V2zx5d4M/mU3cEBBzNZUCt8FVO6c0gRpgg/qI
 eWE9miTGKeaY4Mtoih6jdZID7zm/VFfE13EQMWi2i7oUn0x9Bzi4HTVa/XDYsc9dTYgmhQ
 XQiMPX71z2EOGTyrqqntRUIPqTVN8cvbsC5+/Ie6xc4Q+KOyk2U6bnuEkjkceUBxoUeOAJ
 d7eWIHJwMk9IFxK5Yj+7SjdQvpRw65yaLQ+oWiH+TErNaSsKKErfl2oS/y9IjjXpqyWqJO
 mRT9iS4PsCZXErGnRlwTbJuWTclveu/o6wCQUEuOhI0JxhZCiwoAYhUFqIUhaA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: ksz9477: Constify driver ops
Date: Mon, 16 Nov 2026 18:39:29 +0100
Message-ID: <20261116173936.3488088-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 23064eb52462229b8ae
X-MBO-RS-META: deaqw38btauz63x3sqmp3adkbthdx11e
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/net/ksz9477.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ksz9477.c b/drivers/net/ksz9477.c
index 7ebbe197660..fcd249c83a1 100644
--- a/drivers/net/ksz9477.c
+++ b/drivers/net/ksz9477.c
@@ -113,7 +113,7 @@ struct ksz_phy_ops {
 
 struct ksz_dsa_priv {
 	struct udevice *dev;
-	struct ksz_phy_ops *phy_ops;
+	const struct ksz_phy_ops *phy_ops;
 
 	u32 features;			/* chip specific features */
 };
@@ -129,7 +129,7 @@ static inline int ksz_i2c_write(struct udevice *dev, u32 reg, u8 *val, int len)
 	return dm_i2c_write(dev, reg, val, len);
 }
 
-static struct ksz_phy_ops phy_i2c_ops = {
+static const struct ksz_phy_ops phy_i2c_ops = {
 	.read = ksz_i2c_read,
 	.write = ksz_i2c_write,
 };
@@ -215,7 +215,7 @@ static inline int ksz_spi_write(struct udevice *dev, u32 reg, u8 *val, int len)
 	return ksz_spi_xfer(dev, reg, val, NULL, len);
 }
 
-static struct ksz_phy_ops phy_spi_ops = {
+static const struct ksz_phy_ops phy_spi_ops = {
 	.read = ksz_spi_read,
 	.write = ksz_spi_write,
 };
@@ -224,7 +224,7 @@ static struct ksz_phy_ops phy_spi_ops = {
 static inline int ksz_read8(struct udevice *dev, u32 reg, u8 *val)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
-	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+	const struct ksz_phy_ops *phy_ops = priv->phy_ops;
 
 	int ret = phy_ops->read(dev, reg, val, 1);
 
@@ -241,7 +241,7 @@ static inline int ksz_pread8(struct udevice *dev, int port, int reg, u8 *val)
 static inline int ksz_write8(struct udevice *dev, u32 reg, u8 val)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
-	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+	const struct ksz_phy_ops *phy_ops = priv->phy_ops;
 
 	dev_dbg(dev, "%s 0x%04x>>0x%02x\n", __func__, reg, val);
 	return phy_ops->write(dev, reg, &val, 1);
@@ -255,7 +255,7 @@ static inline int ksz_pwrite8(struct udevice *dev, int port, int reg, u8 val)
 static inline int ksz_write16(struct udevice *dev, u32 reg, u16 val)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
-	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+	const struct ksz_phy_ops *phy_ops = priv->phy_ops;
 	u8 buf[2];
 
 	buf[1] = val & 0xff;
@@ -273,7 +273,7 @@ static inline int ksz_pwrite16(struct udevice *dev, int port, int reg, u16 val)
 static inline int ksz_read16(struct udevice *dev, u32 reg, u16 *val)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
-	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+	const struct ksz_phy_ops *phy_ops = priv->phy_ops;
 	u8 buf[2];
 	int ret;
 
@@ -292,7 +292,7 @@ static inline int ksz_pread16(struct udevice *dev, int port, int reg, u16 *val)
 static inline int ksz_read32(struct udevice *dev, u32 reg, u32 *val)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
-	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+	const struct ksz_phy_ops *phy_ops = priv->phy_ops;
 
 	return phy_ops->read(dev, reg, (u8 *)val, 4);
 }
@@ -305,7 +305,7 @@ static inline int ksz_pread32(struct udevice *dev, int port, int reg, u32 *val)
 static inline int ksz_write32(struct udevice *dev, u32 reg, u32 val)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
-	struct ksz_phy_ops *phy_ops = priv->phy_ops;
+	const struct ksz_phy_ops *phy_ops = priv->phy_ops;
 	u8 buf[4];
 
 	buf[3] = val & 0xff;
@@ -662,14 +662,14 @@ static int ksz_probe_mdio(struct udevice *dev)
 	return 0;
 }
 
-static void ksz_ops_register(struct udevice *dev, struct ksz_phy_ops *ops)
+static void ksz_ops_register(struct udevice *dev, const struct ksz_phy_ops *ops)
 {
 	struct ksz_dsa_priv *priv = dev_get_priv(dev);
 
 	priv->phy_ops = ops;
 }
 
-static bool dsa_ksz_check_ops(struct ksz_phy_ops *phy_ops)
+static bool dsa_ksz_check_ops(const struct ksz_phy_ops *phy_ops)
 {
 	if (!phy_ops || !phy_ops->read || !phy_ops->write)
 		return false;
-- 
2.53.0

