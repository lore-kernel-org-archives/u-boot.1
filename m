Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D59CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 02:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5116640938;
	Fri, 16 Oct 2026 02:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_p2j8d_wiQ5; Fri, 16 Oct 2026 02:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 59F524092A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792116914;
	b=kimGplW8IttP545QeecBh0r0pTR+DR3Hs4oSuW34+lyHiyASarFNoJaIw3r7QjzwJT6X
	 sVtGQusH9FiwoF3TWSjhrSZheaDiQ57dnRMdjqICX92t2jO8kShaTTH+GB9O6FoZut5KM
	 9k2aIJjOo/YHNy6cJ9RedVlfTnXHjAcgdfBkd8PoCG1HrrzM7q2R+CvI+0L1UMTQAgMdr
	 O1uxpptki1DRCJn7ZgxgpN5+8g7kJOfDA6N3M98BAHgblF72fdpM6WwrZWHUDIZnKCI9V
	 nSOVCG1GgAQILZ4JmSHr8ALjJm1+MfJgHdtTY3hWbWrB3nkd3UU+DMqLp5Z5ORSkIAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792116914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mbERWwnuFFZ09QE/imbMNvHvNP2fnB27b51os5GT+vQ=;
	b=dhxKksBUN6ID69POg/NiBsdxRUXYRWBfnkCrwl2w07vl+yTHKd0PK4cEGlkzqz4sK5qu
	 Sbe5hRaU26mTluIbV9ikA7ayhQPwg+fnv1vZHX8hAOQB7rzeFFtE/bWTEI1kZtUj1fgn6
	 +KQcdPey84iRM6XMk/1xybOoUr+EvgToTZV/GdoVZ26iCX7ZqcEVz8AVdD/8uSqVCF+Er
	 ALDbjAIDjkBy4I2XYirPeysKVOjTSTqn7xyvnQU8/mzLmJNr0iqd08o4KEwsz6VEQ9nXs
	 aQ9HcYs6+tnOyWtTHPi0hkTk73PyOcMNbao8Bjo/s8k0ocOAMB92NrBpJj+65Kp68CA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792116914;
	bh=mbERWwnuFFZ09QE/imbMNvHvNP2fnB27b51os5GT+vQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=hwezZmV+PifaBkmYSEa9qZxvEVN9I9+W29AdmFyxRtc3DVdEqyOtf3R2jbt2iiDSe
	 udzt6G2B2flwS7/PkSAQRSsXRk8Iur2xNoq1VjKyszDTARixDvE7GlfRUVyQVMw2w0
	 FI1DR/YwDgxOGxRxCjWlOPWIlFYCdFHRYNE80/VGbc1IMcvdXG3apw4ZF22aO7Ckuc
	 9rUWtRWn3h2TZg3yfThK8tXjNk+s0d3liVXaMaKzR7OWbkLG9biUgD+hKSThzrPFCv
	 ZkOg5l+NOkHeOS74bkSTA8j5LSplm9bXujM57PmNjG+oeOK3n5GlZ5LbwtdeB3nsRh
	 1+6KiuUJmaewQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59F524092A;
	Fri, 16 Oct 2026 02:15:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5362A362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3960E80F84
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WZreX3coUnfC for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 01:43:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BF2980F80
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792115035;
 b=jQbQ1NDHp0EHSKhfPfBlfTUO5QM52bRuSsm6Xf6VISYaT3bgURBcLvMwniGU4tHe64ry
 wEcAaF7US5O+5StuMppJvmZbPxZX3VUDPgXNSUDlOhmLv5pL8J9EoOM6pWD0s+OalnuMA
 Y2J1KRzsS2MWVcT2oS36beGNJCBVVsF0UALbhxPULAiaUeN9Stn+078a983c9/J3f6k6j
 Q3622o1DTNrYBZa3oeE4sLhAvlSSyablRahnZvkl2b2Um/O/OhaKk1Z6hDFc7GuWrE42X
 lhIHupv/6jInxksweckkZcrACqeR19vZCv3v3m+7CeQ3orq1ykT/0nBrbqB5s+yxWbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792115035;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=mbERWwnuFFZ09QE/imbMNvHvNP2fnB27b51os5GT+vQ=;
 b=Ea0p0Mq6PC8pnh+skEm3JHkWrKsDlw0MJzSRenezXTee45yPaJURrSsaVuvp5XUVGj8D
 Zz+vcpsrKF3Md/KGhvx3pqvEw0T7ykFQQz6PQ8NlAMQNLDh8YkrL6oBr7gF0qduLcyNHs
 LoTExmF+QaFMGKfsX6LmBZfdAfQPXgLUfhhAj6v75O3d6naIHabxzsJL8TCp9ovzXKd4s
 f0xo54DdcWkeWMpuI0Vychg8LbQ2vDFcLF6rpzk+6tAHv9RxS1tGkBs7+l6tNCS+YfxE3
 hw35eYHMp5RRK0cDZuiBSczlSuWrF00DM6VwZHY25gmrlJmRTJe5ol3YidhsmnFbqAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VEjIl0gC; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+takahiro.kuwano.infineon.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VEjIl0gC
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BF2980F80
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:43:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EF36A4017E;
 Fri, 16 Oct 2026 01:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8C30C2BCFD;
 Fri, 16 Oct 2026 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792115033;
 bh=NUKjIrp/t/hF84Q6pkeZHkbdX/A2wE8iEhjZFRah+R8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=VEjIl0gCqxVstIL8RrxBF9FSoWh0XHjp41FOWPp4KOFEWnbnBD0ZAxsjUCUJMLSZs
 yDhmzzclhCJUBFWCj4XQIhZ/+fWMXYLkV61dsuDXMd4h8J9zcEOAnY9oblyFhsq2zS
 +yYuFsckON0/lo2SUpIwBfL30Wmv2Huusm05pB1lxJ07s0kXABn4XtRwcnlC7H4jB7
 yd1E/xeAZVh31rC52HBrvlKbBbAUyvdi7uNSJ61rR+ibI3FLU9McNJKqYzGrxW0Fqj
 h70qDhQwEJT9lHrZ+I0mHlMorvIY4wP0XJfY0WwrLJv4vmZd5ncqheNlbA/PD8QHfQ
 xTzP48jNU5JNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AD935CCA463;
 Fri, 16 Oct 2026 01:43:53 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Date: Fri, 16 Oct 2026 10:43:43 +0900
Subject: [PATCH v3 2/4] mtd: spi-nor: import manufacturer driver concept
 from Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-split-sfdp-id-v3-v3-2-4a47b8fc945a@infineon.com>
References: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
In-Reply-To: <20261016-split-sfdp-id-v3-v3-0-4a47b8fc945a@infineon.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Fabio Estevam <festevam@nabladev.com>, Eugen Hristev <ehristev@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792115031; l=5829;
 i=takahiro.kuwano@infineon.com; s=20261016-2; h=from:subject:message-id;
 bh=egaNTxAIu099unu75N5pDyo5UN1pWZc642vZqxVPvXc=;
 b=sJfJK4QUGu6ASi0QuiHqLQS4TCUlkyXDRVxNQxi0WNuyhSZ348k0U1a5JkzxCRfF2pXMmw2r4
 q5b9yJ5bPHCBEFbuyBG720STp5vI4VaC0/i7ZgdPcsLC3PzYNeW8or+
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=pp4mpJAHIqhV2MvdSGbIzKRk3ujhk+tSlGjyTursr4E=
X-Endpoint-Received: by B4 Relay for
 takahiro.kuwano@infineon.com/20261016-2 with auth_id=1202
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 02:15:13 +0000
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
Reply-To: takahiro.kuwano@infineon.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Port spi_nor_manufacturer struct from Linux but ommit 'name' as we don't
print manufacturer name in u-boot, and add 'set_fixups' function pointer
to assign chip specific fixups in manufacturer drivers.Since the u-boot
has size constraint, we should keep having chip-specific fixups in
struct spi_nor instead of flash_info. The 'fixups' and 'set_fixups' are
excluded for tiny.

The manufacturers array and match_id helper are placed in spi-nor-ids.c
as those need to be referred from both core and tiny.

Signed-off-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
 drivers/mtd/spi/sf_internal.h  | 19 +++++++++++++++++++
 drivers/mtd/spi/sfdp.c         |  9 +++++++++
 drivers/mtd/spi/spi-nor-core.c |  9 +++++++++
 drivers/mtd/spi/spi-nor-ids.c  | 22 ++++++++++++++++++++++
 include/linux/mtd/spi-nor.h    |  2 ++
 5 files changed, 61 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 576617beb70..bc69af94aca 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -97,6 +97,23 @@ struct flash_info {
 #define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
 };
 
+/**
+ * struct spi_nor_manufacturer - SPI NOR manufacturer object
+ * @parts: array of parts supported by this manufacturer
+ * @nparts: number of entries in the parts array
+ * @fixups: hooks called at various points in time during spi_nor_scan()
+ * @set_fixups: called to assign chip-specific fixups
+ */
+struct spi_nor_manufacturer {
+	const struct flash_info *parts;
+	unsigned int nparts;
+#if !CONFIG_IS_ENABLED(SPI_FLASH_TINY)
+	const struct spi_nor_fixups *fixups;
+	void (*set_fixups)(struct spi_nor *nor);
+#endif
+};
+
+extern const struct spi_nor_manufacturer *manufacturers[];
 extern const struct flash_info spi_nor_ids[];
 
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -143,4 +160,6 @@ int macronix_quad_enable(struct spi_nor *nor);
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
 int spansion_no_read_cr_quad_enable(struct spi_nor *nor);
 
+const struct flash_info *spi_nor_match_id(struct spi_nor *nor, const u8 *id);
+
 #endif /* _SF_INTERNAL_H_ */
diff --git a/drivers/mtd/spi/sfdp.c b/drivers/mtd/spi/sfdp.c
index fd545796d50..db9dda12e27 100644
--- a/drivers/mtd/spi/sfdp.c
+++ b/drivers/mtd/spi/sfdp.c
@@ -219,6 +219,15 @@ spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			 const struct sfdp_bfpt *bfpt,
 			 struct spi_nor_flash_parameter *params)
 {
+	int ret;
+
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->post_bfpt) {
+		ret = nor->manufacturer->fixups->post_bfpt(nor, bfpt_header,
+							   bfpt, params);
+		if (ret)
+			return ret;
+	}
+
 	if (nor->fixups && nor->fixups->post_bfpt)
 		return nor->fixups->post_bfpt(nor, bfpt_header, bfpt, params);
 
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index b99a1a45d8f..205986a4464 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -2190,6 +2190,9 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
 static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
 {
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->post_sfdp)
+		nor->manufacturer->fixups->post_sfdp(nor, params);
+
 	if (nor->fixups && nor->fixups->post_sfdp)
 		nor->fixups->post_sfdp(nor, params);
 }
@@ -2197,6 +2200,9 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 static void spi_nor_late_init_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
 {
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->late_init)
+		nor->manufacturer->fixups->late_init(nor, params);
+
 	if (nor->fixups && nor->fixups->late_init)
 		nor->fixups->late_init(nor, params);
 }
@@ -3640,6 +3646,9 @@ int spi_nor_remove(struct spi_nor *nor)
 
 void spi_nor_set_fixups(struct spi_nor *nor)
 {
+	if (nor->manufacturer->set_fixups)
+		nor->manufacturer->set_fixups(nor);
+
 #ifdef CONFIG_SPI_FLASH_SPANSION
 	if (JEDEC_MFR(nor->info) == SNOR_MFR_CYPRESS) {
 		switch (nor->info->id[1]) {
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 90aa1025176..e56efd3915e 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -728,3 +728,25 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 	{ },
 };
+
+const struct spi_nor_manufacturer *manufacturers[] = {
+	NULL /* sentinel */
+};
+
+const struct flash_info *spi_nor_match_id(struct spi_nor *nor, const u8 *id)
+{
+	const struct flash_info *part;
+	unsigned int i, j;
+
+	for (i = 0; manufacturers[i]; i++) {
+		for (j = 0; j < manufacturers[i]->nparts; j++) {
+			part = &manufacturers[i]->parts[j];
+			if (!memcmp(part->id, id, part->id_len)) {
+				nor->manufacturer = manufacturers[i];
+				return part;
+			}
+		}
+	}
+
+	return NULL;
+}
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..08567a80472 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -508,6 +508,7 @@ struct spi_flash {
  * @lock:		the lock for the read/write/erase/lock/unlock operations
  * @dev:		point to a spi device, or a spi nor controller device.
  * @info:		spi-nor part JDEC MFR id and other info
+ * @manufacturer:	SPI NOR manufacturer
  * @manufacturer_sfdp:	manufacturer specific SFDP table
  * @page_size:		the page size of the SPI NOR
  * @addr_width:		number of address bytes
@@ -559,6 +560,7 @@ struct spi_nor {
 	struct udevice		*dev;
 	struct spi_slave	*spi;
 	const struct flash_info	*info;
+	const struct spi_nor_manufacturer *manufacturer;
 	u8			*manufacturer_sfdp;
 	u32			page_size;
 	u8			addr_width;

-- 
2.53.0


