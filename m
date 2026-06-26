Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAA1CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 11:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB7278404D;
	Fri, 26 Jun 2026 13:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L5fbQY5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2148460E; Fri, 26 Jun 2026 13:08:38 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A49380398
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 13:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfHTQArwxbm1V73jsiZ4qvoTGReyAS2mZm3tfFEqkXrRtduV5ItykPsFQCzXADvum3CsphrQwvSynsRiNnqJHvsKkV2c7THPymjvnxOGjMf4Qg89N/tZ2YgFhggJ2aHdvCzyvist97zA6J121OcKb6yqJVsuOR2oLSvxRQMqD6uFc8UwFw3IiKI6ZLG2fRAEyGfiorhmo1v3vU+KZpu94fbPRl9tIZ8dZDbg/eDsE3oF8uxJzMsL7sAo2Y6bZ6HkmfgbnUVU9ELbWXthNG0P738FEzRrvN+JC4K9Ut/v4kmOhrcab4rhjM7nlscr83CHcxzVJikJgMQiOc5eayhmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdBBBfQ44q4gaZWpWTXN/9mn/6QEn6agPAaNvFz8T3w=;
 b=PiVoLfMsrPefPMazdB+Re8s5gPzlnTnygg6yRIRgCl7bvWzb+nRn+UChYDwFJnvj7LH298qh2V4BTL73xv3aj5H2lQ5MaxZ6TPFRbFQLvPCMQHP+aZfKubzQ0LZoMZYdCfNXgvx2bYV3f7O2cPQOl72JUN03O/9170OcCwHmO9XseJap109ZpPkcQ8ddYj6Z9mOyN4vHimFptsTadKBWqvQvd1A88Pfr/eYjufRI++ahrC19UtC0OEI/JfR21Xdlhy706SL3k8rXI6MMS77ETGbOStoHYsjy5CTV+Itoj3yWiX//oZ+9POxBcpQTpYvvDLrWxk27eHbtAzrd+qHpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdBBBfQ44q4gaZWpWTXN/9mn/6QEn6agPAaNvFz8T3w=;
 b=L5fbQY5TO8guO4XNU9M4IkdZAYNIKNTeYEBH0BVwsW6lrYUNWyhfHtmuYM4koTGQ8HlYzV0cyJ17A63NwUBM30OYcZFTYozLdXUYIE/e0jHSRlvkcfcxT9fEa0Q2h7D/TztZKIb5Ucx2IhoCRFsMQQJID0Lp3B32lXq0XUl1ENb948kOFXOEv2b7sVRoTUbrlK1Ul1GDQD2HKWUniEyHAMMxPWOAcWV7NQv6ParbbrBKXcE5/UYyiyU8THW7p73GaYGNQjjgQqtD5L4ISA3un0ZAxw0bJ6W2g26Mby17ofRcp8qD7jqnRH0/AJOpnUvM1eEtfSoYqFARXc0OvNn7DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by GVXPR04MB10081.eurprd04.prod.outlook.com (2603:10a6:150:1b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 11:08:33 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 11:08:33 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com
Subject: [PATCH 1/2] misc: ele_api: Add V2X Get State API
Date: Fri, 26 Jun 2026 19:11:52 +0800
Message-Id: <20260626111153.2438623-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|GVXPR04MB10081:EE_
X-MS-Office365-Filtering-Correlation-Id: 517e56ce-9fc1-4a62-7cfe-08ded37342f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|376014|366016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yPpwKsLEPvhjBU8kcTuXCWGwcDxHlrML1CR53qkw0S1qaOjh0PSDhoY4RX9RCUqXhZR50tYOiU3RrDmsfspl9+tHNP5lR37Y+VB7n89R8Sm5dmexQMtArueh39ZJ/fx2ZfQvrwwLaPPd2yzoJF8WWBOTXWFYVtoeRyvrX9kGBcydxc8YxSQdwEPxnmLy2CTmWqSN80uQpa3NCY6ZyHD5e8fFkRlwvnYxpL3mbwPkd9ZULBqk6DR0hZRB/Wn5uI36HPDaX723i3W8LkxaB5jYrknrUU6GDwZvKCQvwwccBj2mMcJeHQvIadhqlL0adCTNwYDoVlam5Z6/9VntRowCtilSjy0+yb9Tyx5JpcSAPG9qezffkcnyPEGrextHCdflbKf/Tzv7i9lLut4TQHNeYadDNFDJKvQbUznmmnOsJ//cCYdqZtCuyLS/dT/1WDY/BZ06h+sQdT/TZDD7X+Gf/vwbjBq8Ba6a15Ryg3qGcayqMDoW7/KaUfv7OQjjwBX3Y4+JMtZgjTccmYYBiVaBaU5N2PxhEXvG7g1K8DUN3VM0SBP64BD8q/V54aQaobk3LdgALMtC0P7fjeqb0QmtJnvpNyyYjDaWO+Az5T9EY83rS+FZooDyLt5CVwzDsMUITVcKM41tx5o8uUx2Xfh4PFy+hgoV3OGXPZgHNVc/tCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Svlw58y3wLPKbk5WuLb5Yy4/YeDAeDCvO+aATtZx8CAug8M8S0+0cFK8FuX?=
 =?us-ascii?Q?Qd4S7/69ALjHirz9fFUqDStwGLVp39taNOXZqN7UkT+msceBjWVDyX8XZZdl?=
 =?us-ascii?Q?XEf+2h6fqctG/f+HvgaDLFUTs0X0AlIx49RuweDW6BWtUTCbE6CXXQh3R8e/?=
 =?us-ascii?Q?mtGPHd4mdL1RZrEOVd8csU/Zrte1qcUnn/RZyJXpGf2sfo/7Fa8oRWj09juG?=
 =?us-ascii?Q?6/Mdq25aeGL6hElo4Tq0aBM23vBGZmRvmxQ895PwxMGlmZ+c5RJAcpznfqKw?=
 =?us-ascii?Q?CVMfLnejght9awbmgWc9Ih2pOJGdIOymClp/H2PXPMY9ASUQEaSlEyxs2prc?=
 =?us-ascii?Q?GGcGjxAfCGJ7tfwXLY5m4RozPUxz0ySTLC8JZKyKhbPTJa2n9JSigGXj6mdL?=
 =?us-ascii?Q?Ub+44zQp6UEuw2jVYhXrfX5or9lO5pOsQH7c1NUzFuTcplA8DiTm+ntC4Pu/?=
 =?us-ascii?Q?aFF4LUnIQurQEhqGOp+h+yswoTa2MJjMVSTTrTidt16vT8XIcrTSq9UPx0kF?=
 =?us-ascii?Q?nfeVC1tz7636IYbz7TFT5VoUcUNUhnhuQND0acoHHEphdPaPTwoWNVFACQUl?=
 =?us-ascii?Q?6YodeJ4eMVMnMuv5QgGhCFvKinYgCypGIsv1ewZtZZ4w7sHzMn2Yf+i65P1s?=
 =?us-ascii?Q?J8O8Fe7TpYPCanD5Z3Rf23hiKsQsp3ddTBZ0ePuDw63qnpTkaKZNuWr0VSgj?=
 =?us-ascii?Q?+3W8PEEL7aSiASWsYRMeKuYOVVpJPbaXhtmzvF4JrmtqN2ukgz4g/rYcrNZv?=
 =?us-ascii?Q?gn66yxNvPtfFXYvubesf8MMhBeBt+vYDY70aiNxnhc9ia9Q54oDqFRZDlupz?=
 =?us-ascii?Q?4j4MI9B3Owz1iNVymV8VHeiMCBTYnO6v9iX3gH+gSXyJ4fcMlZs95Y2vQs2t?=
 =?us-ascii?Q?tPAwug8HLxublscYjS/xraovoTqc5rrHxBOj0TxQzAxE8osoZ5vz4fhADf1X?=
 =?us-ascii?Q?w6zG7iz+UOqvyyT+YWo9sYh9RLLbSOWXE5Pdu9suL7clQGbIPnG150xANwFZ?=
 =?us-ascii?Q?8YthiJ4uTLUSp7lUY6RlInNrxO314Aeqih0CS/l97MmAfaisFrPysrpxdS/5?=
 =?us-ascii?Q?bK0FG/zKXuGrxyD9WMrMghWCjyE61wrsW7wuqmFIDDfZTuCUUEnkPw2ZtMBi?=
 =?us-ascii?Q?ApRv6BuNgj5NFIxH7UxStB2ZOs1K33HjqrHvD6yYIFHSlwk7+7DoNRrf/scE?=
 =?us-ascii?Q?kTJFCIT3jnkd4oNasjpY3RwHjCIhfLBz6hMu6q5rUHInvQ8CnJBvYGxj2BLq?=
 =?us-ascii?Q?pgMWOfeAj4m9W2YNPuWML42hOFHuOx/xPO3MkE7IIwRhilWm/KZCudxljT3R?=
 =?us-ascii?Q?H9U1xkROl4LJt0Cc/T4I68yCxD2mcPcxpt9j3IAkbkVIpIKkyNfNxYORre+z?=
 =?us-ascii?Q?9mGguww7AZreaj9cu4UCwyH1BNRQ1mwJgZHshqhHe6Xrhc1hENpco3Wjbk5b?=
 =?us-ascii?Q?YMQJosS/rudQX9V+NWW2iCYg6UG5qcKl0pXFSGOGcBhVLjTq3RHA6HAU78Ez?=
 =?us-ascii?Q?qHnfvst0KZowkikcE5iiANXbgQYb11I+htYuBad5fg+lOMgn3a8e+XPBkgAc?=
 =?us-ascii?Q?2r7bp8LwfyiWZ5GXFZkvkm0gyIgLHUDm6VMGG6pDmBGUIXGxCs/U3gXUOVf1?=
 =?us-ascii?Q?nAdQ1L84Z230lC5p0ex5o/6i+l0pAow72EJePUITkxNsjHTv34JVrtSG8dVR?=
 =?us-ascii?Q?NZiuzbU6OvFKM7uuMLS1ruN4eOoxmdP+IuR44VioOEseesGkbR7OC8T0Vghg?=
 =?us-ascii?Q?VGDNhq5oN/zpogwjArooXFVF+ZJjtPc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517e56ce-9fc1-4a62-7cfe-08ded37342f5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:08:33.4977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QGAAXg78mPsG/apwc/1ehvr+oO/uAhrLQViZorvK555tH4qol+2paueugXxqlCMt/MQQGmGBvJXWHnNXPs8raxaU1ooEXepCAI+r/KoDXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10081
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

From: Ye Li <ye.li@nxp.com>

Add V2X Get State API to return V2X states for debug purpose

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  8 +++++++
 drivers/misc/imx_ele/ele_api.c          | 32 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 04e7f20a2a6..8d779d6ae1b 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -30,6 +30,7 @@
 #define ELE_START_RNG (0xA3)
 #define ELE_CMD_DERIVE_KEY (0xA9)
 #define ELE_GENERATE_DEK_BLOB (0xAF)
+#define ELE_V2X_GET_STATE_REQ (0xB2)
 #define ELE_ENABLE_PATCH_REQ (0xC3)
 #define ELE_RELEASE_RDC_REQ (0xC4)
 #define ELE_GET_FW_STATUS_REQ (0xC5)
@@ -141,6 +142,12 @@ struct ele_get_info_data {
 	u32 reserved[8];
 };
 
+struct v2x_get_state {
+	u8 v2x_state;
+	u8 v2x_power_state;
+	u32 v2x_err_code;
+};
+
 int ele_release_rdc(u8 core_id, u8 xrdc, u32 *response);
 int ele_auth_oem_ctnr(ulong ctnr_addr, u32 *response);
 int ele_release_container(u32 *response);
@@ -166,4 +173,5 @@ int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
 int ele_set_gmid(u32 *response);
 int ele_volt_change_start_req(void);
 int ele_volt_change_finish_req(void);
+int ele_v2x_get_state(struct v2x_get_state *state, u32 *response);
 #endif
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index 8ee0a7733ca..355fd86ed8c 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -795,6 +795,38 @@ int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_outp
 	return ret;
 }
 
+int ele_v2x_get_state(struct v2x_get_state *state, u32 *response)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 1;
+	msg.command = ELE_V2X_GET_STATE_REQ;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	state->v2x_state = msg.data[1] & 0xFF;
+	state->v2x_power_state = (msg.data[1] & 0xFF00) >> 8;
+	state->v2x_err_code = msg.data[2];
+
+	return ret;
+}
+
 int ele_volt_change_start_req(void)
 {
 	struct udevice *dev = gd->arch.ele_dev;
-- 
2.34.1

