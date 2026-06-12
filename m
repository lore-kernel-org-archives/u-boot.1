Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E64CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B41D84664;
	Fri, 12 Jun 2026 14:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QTe7kltf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FBEE839A8; Fri, 12 Jun 2026 07:41:28 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8378005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 07:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+takahiro.kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 357574080A;
 Fri, 12 Jun 2026 05:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 193B0C4AF12;
 Fri, 12 Jun 2026 05:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781242884;
 bh=mn49zY7dq8J1F95ASyp15iFeDU8pru6pBV0RxASChmA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=QTe7kltfapEX4m4TiyMP8gLqmuKq594ksJNrlNvX0zrxiBMSAwh6nA2iixsjJzlrS
 lLyp+zywYjEth6WspzCRqB61t72BQn+1rHsLmR8HXNWjoLfliXaxl9OrU7antT8btM
 /H5z1iQaxPCZvM7mNzaMKdAiYYHSjXVcB7vYUh2MMA9lfT+VCM65nm4GSOLzhhQhEl
 6EIDbMMwvvebXwdrdiwX020EoHjuKPG8Mk7FGhcPgkQhWyDppfSgp58+B9knfEQIp8
 fzKUDkAnUZf38Zrsg8wI5XEIt3UcGYRnfa4Zz2v5zShtWtABcNMoZuUgcsXFC5h/AT
 YvX/d37pdM3mA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB9FCD98D6;
 Fri, 12 Jun 2026 05:41:24 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+takahiro.kuwano.infineon.com@kernel.org>
Date: Fri, 12 Jun 2026 14:40:50 +0900
Subject: [PATCH 2/4] mtd: spi-nor: import manufacturer driver concept from
 Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-split-id-table-into-vendor-files-v1-2-dfaaa82cc6f0@infineon.com>
References: <20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com>
In-Reply-To: <20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Walle <mwalle@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@nabladev.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781242882; l=6563;
 i=takahiro.kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=Lc2Yt7NrwvqFl9repzp3ddDSRnbEIlmOvaXR4Tg4TIM=;
 b=ufVt6BVFwqtH+ZoYdFMPi4R/Dac+r3b06iHWw1WfvdVSiDclX8Oo4MiLeCT2AE9+MgP4IsSku
 jVAsfQ8ClCxCpiWOtebTC4qhip/brpi8rrXmH0BdzxM5Ff+eDqGxtQn
X-Developer-Key: i=takahiro.kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for takahiro.kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <takahiro.kuwano@infineon.com>
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:35:35 +0200
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
Reply-To: takahiro.kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

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
 drivers/mtd/spi/sf_internal.h  | 18 ++++++++++++++++++
 drivers/mtd/spi/sfdp.c         |  9 +++++++++
 drivers/mtd/spi/spi-nor-core.c | 13 +++++++++++++
 drivers/mtd/spi/spi-nor-ids.c  | 21 +++++++++++++++++++++
 drivers/mtd/spi/spi-nor-tiny.c |  4 ++++
 include/linux/mtd/spi-nor.h    |  2 ++
 6 files changed, 67 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 576617beb70..3b6b51cb11c 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -97,6 +97,22 @@ struct flash_info {
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
 extern const struct flash_info spi_nor_ids[];
 
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -143,4 +159,6 @@ int macronix_quad_enable(struct spi_nor *nor);
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
index b99a1a45d8f..697e443bf5a 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1405,6 +1405,10 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}
 
+	info = spi_nor_match_id(nor, id);
+	if (info)
+		return info;
+
 	info = spi_nor_ids;
 	for (; info->name; info++) {
 		if (info->id_len) {
@@ -2190,6 +2194,9 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
 static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
 {
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->post_sfdp)
+		nor->manufacturer->fixups->post_sfdp(nor, params);
+
 	if (nor->fixups && nor->fixups->post_sfdp)
 		nor->fixups->post_sfdp(nor, params);
 }
@@ -2197,6 +2204,9 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
 static void spi_nor_late_init_fixups(struct spi_nor *nor,
 				     struct spi_nor_flash_parameter *params)
 {
+	if (nor->manufacturer->fixups && nor->manufacturer->fixups->late_init)
+		nor->manufacturer->fixups->late_init(nor, params);
+
 	if (nor->fixups && nor->fixups->late_init)
 		nor->fixups->late_init(nor, params);
 }
@@ -3640,6 +3650,9 @@ int spi_nor_remove(struct spi_nor *nor)
 
 void spi_nor_set_fixups(struct spi_nor *nor)
 {
+	if (nor->manufacturer->set_fixups)
+		nor->manufacturer->set_fixups(nor);
+
 #ifdef CONFIG_SPI_FLASH_SPANSION
 	if (JEDEC_MFR(nor->info) == SNOR_MFR_CYPRESS) {
 		switch (nor->info->id[1]) {
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..45e9b866795 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -723,3 +723,24 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 	{ },
 };
+
+static const struct spi_nor_manufacturer *manufacturers[] = {
+};
+
+const struct flash_info *spi_nor_match_id(struct spi_nor *nor, const u8 *id)
+{
+	const struct flash_info *part;
+	unsigned int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
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
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index cf00473ee83..c7824285191 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -383,6 +383,10 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}
 
+	info = spi_nor_match_id(nor, id);
+	if (info)
+		return info;
+
 	info = spi_nor_ids;
 	for (; info->sector_size != 0; info++) {
 		if (info->id_len) {
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
2.43.0


