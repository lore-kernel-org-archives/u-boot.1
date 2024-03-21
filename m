Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8795DC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 11:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A5388087;
	Thu, 21 Mar 2024 12:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="l53j1Rhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C59887FF2; Thu, 21 Mar 2024 08:20:10 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A889F87D4F
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rnCiV-0002P8-R4; Thu, 21 Mar 2024 03:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=EqHfY0OBYBT3PTWQMxNY78Hp/RLlDQOTr0aNJyYAOrs=; b=l53j1Rhn4ceVBE
 Hai9gknkWPUxAS7g78ACM3OJMhgsris0R2B87A+qx7DeuZjOVNoKG5kfEb+JYUrKIn1ECmoJloEL/
 utUSQaPYE7jwj78twCzo5GqQJsgpLWqpiHmEH7gmYcWzVLSrbANV5pH5JNrgyYIcBG00gWpDvoJiz
 fUmLBR0AFC+sMQa3LvEX+5+PvC+ybCGWzr/kK5EdS5fxQNbf7ZpETwmQBpPFGMMA7pfRKN1lNFeK5
 I6wvooRBFuXslHG8sQH2ZxKyKqMWlS6uJtrvt8ESaF9H4kuGLXA99Djw8myfhgvO3MdTVQ9V1AkKp
 tzKdQ7YdVL2HpCsrhqMA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Clement Faure <clement.faure@nxp.com>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH] imx: ele_ahab: Add ahab_commit command support
Date: Thu, 21 Mar 2024 08:19:53 +0100
Message-ID: <20240321071953.14615-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Mar 2024 12:32:10 +0100
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

This message is used to commit into the fuses any new SRK revocation and
FW version information that have been found into the NXP (ELE FW) and
OEM containers.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  2 ++
 arch/arm/mach-imx/ele_ahab.c            | 29 ++++++++++++++++++++++
 drivers/misc/imx_ele/ele_api.c          | 32 +++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index cfd4ecebb62..a29b849d903 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -24,6 +24,7 @@
 #define ELE_GET_FW_VERSION_REQ (0x9D)
 #define ELE_RET_LIFECYCLE_UP_REQ (0xA0)
 #define ELE_GET_EVENTS_REQ (0xA2)
+#define ELE_COMMIT_REQ (0xA8)
 #define ELE_START_RNG (0xA3)
 #define ELE_GENERATE_DEK_BLOB (0xAF)
 #define ELE_ENABLE_PATCH_REQ (0xC3)
@@ -142,6 +143,7 @@ int ele_read_common_fuse(u16 fuse_id, u32 *fuse_words, u32 fuse_num, u32 *respon
 int ele_release_caam(u32 core_did, u32 *response);
 int ele_get_fw_version(u32 *fw_version, u32 *sha1, u32 *response);
 int ele_get_events(u32 *events, u32 *events_cnt, u32 *response);
+int ele_commit(u16 fuse_id, u32 *response, u32 *info_type);
 int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_output_size);
 int ele_dump_buffer(u32 *buffer, u32 buffer_length);
 int ele_get_info(struct ele_get_info_data *info, u32 *response);
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 295c055ad0a..d02316ed6cb 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -625,6 +625,29 @@ static int do_ahab_return_lifecycle(struct cmd_tbl *cmdtp, int flag, int argc, c
 	return CMD_RET_SUCCESS;
 }
 
+static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	u32 index;
+	u32 resp;
+	u32 info_type;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	index = simple_strtoul(argv[1], NULL, 16);
+	printf("Commit index is 0x%x\n", index);
+
+	if (ele_commit(index, &resp, &info_type)) {
+		printf("Error in AHAB commit\n");
+		return -EIO;
+	}
+
+	printf("Ahab commit succeeded. Information type is 0x%x\n", info_type);
+
+	return 0;
+}
+
 U_BOOT_CMD(auth_cntr, CONFIG_SYS_MAXARGS, 1, do_authenticate,
 	   "autenticate OS container via AHAB",
 	   "addr\n"
@@ -657,3 +680,9 @@ U_BOOT_CMD(ahab_return_lifecycle, CONFIG_SYS_MAXARGS, 1, do_ahab_return_lifecycl
 	   "addr\n"
 	   "addr - Return lifecycle message block signed by OEM SRK\n"
 );
+
+U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
+	   "commit into the fuses any new SRK revocation and FW version information\n"
+	   "that have been found into the NXP (ELE FW) and OEM containers",
+	   ""
+);
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index 0c017734a49..e0ec22c7abf 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -528,6 +528,38 @@ int ele_start_rng(void)
 	return ret;
 }
 
+int ele_commit(u16 fuse_id, u32 *response, u32 *info_type)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg;
+	int ret = 0;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 2;
+	msg.command = ELE_COMMIT_REQ;
+	msg.data[0] = fuse_id;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, fuse_id 0x%x, response 0x%x\n",
+		       __func__, ret, fuse_id, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	if (info_type)
+		*info_type = msg.data[1];
+
+	return ret;
+}
+
 int ele_write_secure_fuse(ulong signed_msg_blk, u32 *response)
 {
 	struct udevice *dev = gd->arch.ele_dev;
-- 
2.41.0

