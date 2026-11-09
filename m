Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643E606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1D+aII1A;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lUkF7hMe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC6E080E21;
	Mon,  9 Nov 2026 13:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEq-TJNCDpFq; Mon,  9 Nov 2026 13:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0316D80DF5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794230921;
	b=KhcbxHO9f7sXvHqXaU4UvGVppyvkgA5doxaWihaR0MqDQ/x25XOOWT4/YETkkqFQ8bGM
	 3Uo3qv2iZA6OvgX3RknKEi1zAWfAO8/RIPxFKDtU2uTEZ03G27NM4E8Dhkn2idCYXIbdU
	 7ywY1ylnoCNtaFy5hjtDb/ABGj5kn8f4VGARE7ulYUw2Bp3/HW2bG3Y0vEeo8L2L6pemy
	 PQfSsGmd++vqmPow5uw75KtHuMI8UpLApVSta7VloU3Hzns7CiDZKC5OEhwWbsq4eIiVH
	 81y0/4jXoj7n793+NLmDSJz9/OJn/aT9V6De/y849adyr9gay2lAuhryjLOgVe8+UEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794230921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=XT2ZBcThU0OczgKmUvfjRJ6P9bkITfzDBrCuOP49pno=;
	b=qNgpNG90Mr2Jmjm7eNGW0blNT/dIk7UjkZ7kSkiEgvsry0zTxT5SZRr59iVbwLQERvz8
	 SrH14Ax7HCNV/iw+vuzuTrOBu5ZFi7cCrEX2S2BeM1GPDVr5/l3OJUOP2mNXfvdZeWFsC
	 dbNG0Z0XAifyE49QY870sSbXqrKoOLCbD12m0kkqRgJuVOff+NcPSF3OOX7St7TAdBNhQ
	 5p9ZPKx9cQqLQsx2J2F1QI/xRt1Y0GqBHR9QrX7PtGABBLvf7IPKuXGQHdfhcjRb8grXr
	 3wkZJ2xdeTdsSTC/Hj1qUBSTPdevQx7lwCAjCT3KR+X/nozk4gZ+neKfY44uC8iL8Zg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794230921;
	bh=XT2ZBcThU0OczgKmUvfjRJ6P9bkITfzDBrCuOP49pno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=1D+aII1AVou6aAM6f35bZwr+75BM47mNzWjBDR40iNEHC9OswUDH+cifiDsxd0AXI
	 ObzT0JFXfGrQlOsWcr6gdV9g3ELbge1eglif7lYP9oSovhHTB8xTutcMGARQ5tuz0N
	 cwRSnl1Heu97VndtO3LdSiVJAjmZQL7hZYHDdNuuCTVi/07IeUiJpTkNL9QUtDOmUq
	 yKbh8wnOd5HCXCPNdy0bAQ5TJHgrr0+5Y8h3lJH7Ruf3dZaN/WcuDwx4o966v9MHwV
	 JVdMdJd1j9fXzuChRPadadGRfgCCeXInqTZKolaX+adptHD6RXPMcyt9vOswecdJQr
	 FVJ62MJBpz5eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0316D80DF5;
	Mon,  9 Nov 2026 13:28:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EFB1361
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2525B605F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id th9FlURGpSM8 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 09:39:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DF84605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+takahiro.kuwano.infineon.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lUkF7hMe
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DF84605EF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 09:39:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70C8562FAB;
 Mon,  9 Nov 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F6001F008A4;
 Mon,  9 Nov 2026 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794217195;
 bh=XT2ZBcThU0OczgKmUvfjRJ6P9bkITfzDBrCuOP49pno=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=lUkF7hMeerDSPFt9y7s1LQCei6xBa6/N2YqNt7tuSIajJ+TIqI2NNepoKyBvsizF3
 vOwR900yAKqFrKz5tCUjMcMNtlf829gypA3VXvE4Mi/ves8Lzjv55DlAPmBmkVPRql
 xaq+no2InicqKx65lTthD2bUAkUEYv+ZDknCw47qaVyZ/3k1wgcXRGktymnRzhUN+s
 SlpRNteTNRdteeYh1GUMjDWGy8bJX2cgI3UZ1cbr7ihmQO6Q1gOAQ3vG6n5plxRa2g
 H9rcwVBUouXknrSpLbSCkpCJ5l60WdW20DHUufiSKO48G9JbffRFYQakNEtiU3Pjgo
 mDov71XlI8dfw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D944F483B1;
 Mon,  9 Nov 2026 09:39:53 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Date: Mon, 09 Nov 2026 18:39:42 +0900
Subject: [PATCH v4 2/5] mtd: spi-nor: import manufacturer driver concept
 from Linux
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-split-sfdp-id-v3-v4-2-7270c9d82fd3@infineon.com>
References: <20261109-split-sfdp-id-v3-v4-0-7270c9d82fd3@infineon.com>
In-Reply-To: <20261109-split-sfdp-id-v3-v4-0-7270c9d82fd3@infineon.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Fabio Estevam <festevam@nabladev.com>, Eugen Hristev <ehristev@kernel.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794217192; l=5906;
 i=takahiro.kuwano@infineon.com; s=20261016-2; h=from:subject:message-id;
 bh=xQODin/mkv0+SFiLPEzeOAW8UrlFlDiJAWOD3eXHMoE=;
 b=xdf3hT0T+iA9PCIjizT0a2PGUm+dzEQyQA4hKUlNjF9/FYpQAoFCu7KuAodf5Vy3cRz8MTywc
 Q4ZlFHHB9tFBsqjAJrkndM0RY9mjwca+aid2NCapUhrOM+rpj2WTpkJ
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=pp4mpJAHIqhV2MvdSGbIzKRk3ujhk+tSlGjyTursr4E=
X-Endpoint-Received: by B4 Relay for
 takahiro.kuwano@infineon.com/20261016-2 with auth_id=1202
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 13:28:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: takahiro.kuwano@infineon.com
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Takahiro Kuwano <takahiro.kuwano@infineon.com>

Port spi_nor_manufacturer struct from Linux but ommit 'name' as we don't
print manufacturer name in u-boot, and add 'set_fixups' function pointer
to assign chip specific fixups in manufacturer drivers.Since the u-boot
has size constraint, we should keep having chip-specific fixups in
struct spi_nor instead of flash_info. The 'fixups' and 'set_fixups' are
excluded for tiny.

The manufacturers array and match_id helper are placed in spi-nor-ids.c
as those need to be referred from both core and tiny.

Tested-by: Bastien Curutchet <bastien.curutchet@bootlin.com> # mx25uw51245g
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
index 67486d7a945..6ee141f3e11 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -731,3 +731,25 @@ const struct flash_info spi_nor_ids[] = {
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
index b427253b910..e06ad53a64f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -506,6 +506,7 @@ struct spi_flash {
  * @lock:		the lock for the read/write/erase/lock/unlock operations
  * @dev:		point to a spi device, or a spi nor controller device.
  * @info:		spi-nor part JDEC MFR id and other info
+ * @manufacturer:	SPI NOR manufacturer
  * @manufacturer_sfdp:	manufacturer specific SFDP table
  * @page_size:		the page size of the SPI NOR
  * @addr_width:		number of address bytes
@@ -557,6 +558,7 @@ struct spi_nor {
 	struct udevice		*dev;
 	struct spi_slave	*spi;
 	const struct flash_info	*info;
+	const struct spi_nor_manufacturer *manufacturer;
 	u8			*manufacturer_sfdp;
 	u32			page_size;
 	u8			addr_width;

-- 
2.53.0


