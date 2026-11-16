Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE746606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=elzkrkCa;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=L9sqh7Y9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A432740588;
	Mon, 16 Nov 2026 17:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSivn_rme71Q; Mon, 16 Nov 2026 17:44:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD97940562
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851063;
	b=JX+CgVYAHgCbP5h3VFbRF/sfjt1pDhqm7Dwu04VsFZIh8v5HOZljp8SFQeSfZtDUecfS
	 5jN7EEyZlij785612pLP2UksEMU7YDyv9dIOBV9N9GeD+aqiXwA5+msPR8dWMuFR1B+1n
	 OvyBHSFs1k4tcvre5fr2E1MaaAawy67cr5VSIz0VlCQAunMdRfL4e8aTqBsXGSI+/6bvf
	 /5IqPhyAlIwkStqWbeFm74cPk3JQONRkI8QB+taqrK8i+zC368zjfVbAodR5Q4BNYuZlB
	 tv8Z3r3udyYbYijCk2AgG8gfCqvLH6cW+2vyEiDCaefYE4D4q3XaxMnzzX41stjItfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0iHnl/59fW+cPMtlxPa5E2jxfc+/B6PpMr1etktrRQk=;
	b=LzyCeWr91WD8kxskNfeivcV0q1pxtZ0FeC8N13dk23gb6C/ReELwfdb3ZVqvxR3tdRQy
	 pyj+/AkwBWCu1lNGvFQT/JsZ3dfM8QgLpkflChoqWU0X+TEapZ7/OZnQIuJKxNED4RTgC
	 rJW1swpj+EUDokoZ6YKVgO59Ds3Ix7UXh3+o1fOUFtx7dZV6dEz7Vfyb/cwc1Zw4ZLjUw
	 GjT63gUduJ3kE6KrvsjTgiZhNUAQYSbsrQHEEjSC6oho0eXJ3FxoyUpw2XkXv84FZ74NH
	 2jWI7LD6Zpy5A3K9r3FbxXhWxAiVuMi6z94U/FrZx25md+MXvaj+kQujxCD23F7S9Cw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851063;
	bh=0iHnl/59fW+cPMtlxPa5E2jxfc+/B6PpMr1etktrRQk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=elzkrkCagDXqU4OdvNm57Qc+tnv90xl/HVfpjBFYAe7zdRMmgi9PGFZyRHTR9nbt2
	 BQd74BIzC77z1cSC49U3becUAiYlTBhacYPOo4lzyuKEM1MUu0pOZDjw9WNJ8Mbgc5
	 Cjq95j0M3vzm9MsaVigBp+5y6EoDRLdCgzc+6IMNNZExSuoSlhdI1Bz25+LYz6Kxmr
	 aZwAXw210+1nhDiDx1EoYw1bidQTgmbGw2w0Bbhffy9tsejii665+X15KsSxn8SEjU
	 2b8NQfR7N4qdeUWgSETlVBFYicR2jd3H/kp++8C3aX6fZZLsHeU6AkUtu4GltvyPTQ
	 ghMpCm8iImUEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD97940562;
	Mon, 16 Nov 2026 17:44:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E85EE2FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA7BD810D8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6GSqpmmvhRI for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:44:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1BDA810D6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=L9sqh7Y9
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1BDA810D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:44:21 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSwGV20kLzKnCX;
 Mon, 16 Nov 2026 18:44:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794851058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0iHnl/59fW+cPMtlxPa5E2jxfc+/B6PpMr1etktrRQk=;
 b=L9sqh7Y9aLqrLpjll0YVOVVdEk6ih2EKOIsuR76eJeH9GDREhdm3QHQqzjFUpv8DI60Hli
 4E6dO8SV+hSPnz6uKyvZwiPrC7JnrgTtMuFYQG2dai1/1kvI/k//wXMzc4kmNV7QqR3cft
 WRzz/+ylnFhxd1o3a8m3TMZVsX1MqBySs6x/jOOmxmwPPwxA32puViHKL+AgyvqANL2Uq0
 Ca79aoVDXSLu8Ux4Xam9ITdfuc8Ymf73AHc50jndjLuFQZlk+Muq0bQVRSHAW9DXGEvuPw
 cDMbCSwXHlgCEPKy+dNC/pqFUaZNNobl/QUbTiO6vtDpAq358DSRAtFJ7FW8uw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] tpm: Constify driver ops
Date: Mon, 16 Nov 2026 18:44:11 +0100
Message-ID: <20261116174416.3488353-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5045f5923793e7694ab
X-MBO-RS-META: 1n7f3k8rfctkxjq7h5qb9ja1f9hcyx71
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
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/tpm/tpm2_tis_core.c | 22 +++++++++++-----------
 drivers/tpm/tpm2_tis_i2c.c  |  2 +-
 drivers/tpm/tpm2_tis_mmio.c |  2 +-
 drivers/tpm/tpm2_tis_spi.c  |  2 +-
 drivers/tpm/tpm_tis.h       |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_core.c b/drivers/tpm/tpm2_tis_core.c
index 1fdf8cfa319..0a2201df19c 100644
--- a/drivers/tpm/tpm2_tis_core.c
+++ b/drivers/tpm/tpm2_tis_core.c
@@ -37,7 +37,7 @@ int tpm_tis_get_desc(struct udevice *dev, char *buf, int size)
 static bool tpm_tis_check_locality(struct udevice *dev, int loc)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	u8 locality;
 
 	phy_ops->read_bytes(dev, TPM_ACCESS(loc), 1, &locality);
@@ -62,7 +62,7 @@ static bool tpm_tis_check_locality(struct udevice *dev, int loc)
 int tpm_tis_request_locality(struct udevice *dev, int loc)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	u8 buf = TPM_ACCESS_REQUEST_USE;
 	unsigned long start, stop;
 
@@ -92,7 +92,7 @@ int tpm_tis_request_locality(struct udevice *dev, int loc)
 static int tpm_tis_status(struct udevice *dev, u8 *status)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 
 	if (chip->locality < 0)
 		return -EINVAL;
@@ -118,7 +118,7 @@ static int tpm_tis_status(struct udevice *dev, u8 *status)
 int tpm_tis_release_locality(struct udevice *dev, int loc)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	u8 buf = TPM_ACCESS_ACTIVE_LOCALITY;
 	int ret;
 
@@ -172,7 +172,7 @@ static int tpm_tis_wait_for_stat(struct udevice *dev, u8 mask,
 static int tpm_tis_get_burstcount(struct udevice *dev, size_t *burstcount)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	unsigned long start, stop;
 	u32 burst;
 
@@ -208,7 +208,7 @@ static int tpm_tis_get_burstcount(struct udevice *dev, size_t *burstcount)
 static int tpm_tis_ready(struct udevice *dev)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	u8 data = TPM_STS_COMMAND_READY;
 
 	/* This will cancel any pending commands */
@@ -218,7 +218,7 @@ static int tpm_tis_ready(struct udevice *dev)
 int tpm_tis_send(struct udevice *dev, const u8 *buf, size_t len)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	size_t burstcnt, wr_size, sent = 0;
 	u8 data = TPM_STS_GO;
 	u8 status;
@@ -301,7 +301,7 @@ release_locality:
 static int tpm_tis_recv_data(struct udevice *dev, u8 *buf, size_t count)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	int size = 0, len, ret;
 	size_t burstcnt;
 	u8 status;
@@ -403,14 +403,14 @@ int tpm_tis_open(struct udevice *dev)
 	return ret;
 }
 
-void tpm_tis_ops_register(struct udevice *dev, struct tpm_tis_phy_ops *ops)
+void tpm_tis_ops_register(struct udevice *dev, const struct tpm_tis_phy_ops *ops)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
 
 	chip->phy_ops = ops;
 }
 
-static bool tis_check_ops(struct tpm_tis_phy_ops *phy_ops)
+static bool tis_check_ops(const struct tpm_tis_phy_ops *phy_ops)
 {
 	if (!phy_ops || !phy_ops->read_bytes || !phy_ops->write_bytes ||
 	    !phy_ops->read32 || !phy_ops->write32)
@@ -444,7 +444,7 @@ static int tpm_tis_wait_init(struct udevice *dev, int loc)
 int tpm_tis_init(struct udevice *dev)
 {
 	struct tpm_chip *chip = dev_get_priv(dev);
-	struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops = chip->phy_ops;
 	int ret;
 	u32 tmp;
 
diff --git a/drivers/tpm/tpm2_tis_i2c.c b/drivers/tpm/tpm2_tis_i2c.c
index 93efccc7757..a358014ea2a 100644
--- a/drivers/tpm/tpm2_tis_i2c.c
+++ b/drivers/tpm/tpm2_tis_i2c.c
@@ -92,7 +92,7 @@ static int tpm_tis_i2c_write32(struct udevice *dev, u32 addr, u32 value)
 	return tpm_tis_i2c_write(dev, addr, sizeof(value), (u8 *)&value_le);
 }
 
-static struct tpm_tis_phy_ops phy_ops = {
+static const struct tpm_tis_phy_ops phy_ops = {
 	.read_bytes = tpm_tis_i2c_read,
 	.write_bytes = tpm_tis_i2c_write,
 	.read32 = tpm_tis_i2c_read32,
diff --git a/drivers/tpm/tpm2_tis_mmio.c b/drivers/tpm/tpm2_tis_mmio.c
index fc62dcda9ef..679abcc107c 100644
--- a/drivers/tpm/tpm2_tis_mmio.c
+++ b/drivers/tpm/tpm2_tis_mmio.c
@@ -70,7 +70,7 @@ static int mmio_write32(struct udevice *dev, u32 addr, u32 value)
 	return 0;
 }
 
-static struct tpm_tis_phy_ops phy_ops = {
+static const struct tpm_tis_phy_ops phy_ops = {
 	.read_bytes = mmio_read_bytes,
 	.write_bytes = mmio_write_bytes,
 	.read32 = mmio_read32,
diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index c433e8088ac..3ca2d6f6b12 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -187,7 +187,7 @@ static int tpm_tis_spi_write32(struct udevice *dev, u32 addr, u32 value)
 	return tpm_tis_spi_write(dev, addr, sizeof(value), (u8 *)&value_le);
 }
 
-static struct tpm_tis_phy_ops phy_ops = {
+static const struct tpm_tis_phy_ops phy_ops = {
 	.read_bytes = tpm_tis_spi_read,
 	.write_bytes = tpm_tis_spi_write,
 	.read32 = tpm_tis_spi_read32,
diff --git a/drivers/tpm/tpm_tis.h b/drivers/tpm/tpm_tis.h
index 93f622f2910..32d4f9200ed 100644
--- a/drivers/tpm/tpm_tis.h
+++ b/drivers/tpm/tpm_tis.h
@@ -110,7 +110,7 @@ struct tpm_chip {
 	u8 rid;
 	unsigned long timeout_a, timeout_b, timeout_c, timeout_d;  /* msec */
 	ulong chip_type;
-	struct tpm_tis_phy_ops *phy_ops;
+	const struct tpm_tis_phy_ops *phy_ops;
 };
 
 struct tpm_input_header {
@@ -265,5 +265,5 @@ int tpm_tis_init(struct udevice *udev);
  * @dev: TPM device
  * @ops: tpm_tis_phy_ops ops for the device
  */
-void tpm_tis_ops_register(struct udevice *udev, struct tpm_tis_phy_ops *ops);
+void tpm_tis_ops_register(struct udevice *udev, const struct tpm_tis_phy_ops *ops);
 #endif
-- 
2.53.0

