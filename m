Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D13BCFB422
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 00:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3F2889C3;
	Sun,  6 Oct 2024 02:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BZ+5EFPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23B588A24; Sun,  6 Oct 2024 02:20:39 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8D3888DD
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 02:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZqCMFX3NyOjsTVItpU/8ARlFYt4ARlKPzf8hlIkmAw4YlpJqHEGvLb0DfKUjB6JVCkQCONo4FjH0Edv/8HqLStWku9esyQkrP2gN23cCHRA/0RBSmO/c4i655Zq7b2TNDX72C6KVwKZgY5WvijkCUb2cx3mtzwZjLBaYc/VJ0BPLgO06/pwCrNX6w1XA2lvmhpUI07mXipbCPnI8PdyGZkMuYgqUhIVsYP+O8g2yjnlpY2bf1moIsSH6teIrN3pP0FOgoIyvDNNFIB4fHF7+qUfBGi2OHfHQoX5fWtNNP+CWhhaz1AfwIbbI7FU4hXS2VEAra80HzHCnr8B2hfSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F96pcQRlsazAmN07B4MufIf0LMaLzWSFyOKjpS4cc7g=;
 b=BADrKwz4ZLlIVLwYWoZQS//A5Ym9fXF4pqJvQtXgyjOa+o9etbHHHQ7ITTOuRSsgERinibOnpa+bbpXywj/5T327kpdLqI6VKSSjdY1UvxN934OieeLPtXV8F16JdWN6We+VvoM9FGjyfHczc04kaWwpjj5bVpcFbLmXXdqfsfsR1ddGsl9R2P5obsD5s50SeT+V8o6TC0M8rLQW9Ipsk4e+FThEM+VF2RFBmWPXjwjDFGfbKFbw2GYC7BtILtzg29kl3kx2/RsVFVJvvRv0XT/KkkWsjmMyUR19VLnCHOl3ZShQ6TJIs5dt0LZJnvHEhuqpo95FCSqEUUDJwA1MUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F96pcQRlsazAmN07B4MufIf0LMaLzWSFyOKjpS4cc7g=;
 b=BZ+5EFPOA+J+9iioXwcdXlQKDHniBNwB+D6OACdxjNOAYuFBJSnkaJxKAAh9Rg8HjKJ7A8sTV2Wa/G3ad4HnRbWnnqd8egIhfIGzMunpqfrmNTeBDdrvKX7D4JozotppC3y8SZFQmy5PWs0eZ4djPw16u8TtQYQq0tyhIJh+/bviyB3QRIX/CUESH3YaBK657hY+GIj1MXPs1jZAVQStgEQ2o7QL1SaC81/V7Gy7ZiO5y8igHrqPO0i13DW9tzDqQ2iavjZgdJCgwtMgHejTITbSvmdmyBb3aVOjV7pEole1b/2u7LCB0dcWw/+KWUuUIjIL/p9tw3HeVIN9HCjAgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB9470.eurprd04.prod.outlook.com (2603:10a6:102:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sun, 6 Oct
 2024 00:20:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 00:20:35 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 othacehe@gnu.org, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v1] misc: imx_ele: add ELE release aux API
Date: Sun,  6 Oct 2024 08:19:19 +0800
Message-Id: <20241006001919.2785844-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 747f83de-a2b7-45aa-aed6-08dce59cb270
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6XujzHaQorjzqemn7v95QNppPMlC5L75G6g8U0/e67CLcnrDVxLdOWHnv1mc?=
 =?us-ascii?Q?fTnY0NiIsjf9b6g2uMJxVwZ3Y4QXDXp8hnJuOcZrkisFktgbU2R7nNXtUUIs?=
 =?us-ascii?Q?9XeEffp/l3wM5JUkHIGAYjtIpgVTbKYd1fymHoIac8YIxqVdLEE60QYMg5Z5?=
 =?us-ascii?Q?QgX+2YN4T1NotdkygY32Ck8mSAnMxFvyryJVbtSPCa8u+30EDMEmGzeHILE5?=
 =?us-ascii?Q?w1mgZofCpfDm+hXUibO2k5go26uODozLKhA/AADLhvdJm+bQnQD/acTwHOWf?=
 =?us-ascii?Q?Pfu9I5g4uDYDRWc1HiVG1AFrvDjS+3ylOZdEKd84f0mRDryvf0mEeQ1nYR0G?=
 =?us-ascii?Q?l5SgxF9H+REbvxPvav3m5MyCKKrjTRsc1PJUIXxF9Jow05ldxrdCYKbtCuSV?=
 =?us-ascii?Q?yaDst+F9WdT4PsiiOozh+ek1PBPV13BA7+jLM0d4jLzODZNmtxEEVNkJpOxi?=
 =?us-ascii?Q?tEzJEmLQA9FCMf7vnAiIpVm24gsCEMeUDrTbVoOq8P52qaQB7wMMR/JSPiea?=
 =?us-ascii?Q?mynzvy/KzIJAOKNv2wv/AosZVDr+K1wSwQALer8ohpIU2Grz7SMdfR7GftXh?=
 =?us-ascii?Q?KmmDtzWuP26MmSN0lgjRlLb138Rink64Y8DOqNenSZfH8IK+zFTRPgTbj7ab?=
 =?us-ascii?Q?N7ffmCok0oQoAedavI4wNHvAHH0hs/BZuk9ELK1F6Uo6IHf4LX396mqUFWmD?=
 =?us-ascii?Q?ZkVuCu8eFa9s1HTNEcjVLnncM33lXbvGwVa7BwSn511ZGc0P/fbQcRYbd655?=
 =?us-ascii?Q?8U5/tzrTjENTDU22FW8bikQlglo383/Y7ixyveFxw4QCc3O2VB2cQ7bYJK7u?=
 =?us-ascii?Q?j26WG4VX0KNQ86Sjksrfb8Wy5X1fme+oKXvKWJvF0cO3UcRczHFWiOX61/7U?=
 =?us-ascii?Q?S7cGvaLF6BE6VrYQK9SyhQvEnT6K68QdsjTYkRQEM3MvuTs4oyAwzB4MYZjB?=
 =?us-ascii?Q?3vMPm/riMsdr7o2omk+xnyQ9k4nwGPYiW9XOSitl7eDp34dMP1WQMWswBws5?=
 =?us-ascii?Q?7X24IWswtnQ8cZnb182BixXVkm1+MTdBr+XnsNG0P4zsx9fJpkrSzs2XYuu6?=
 =?us-ascii?Q?CSuf7d+JWQ2Cz5K3E7xLoF2z6M9Nj7rLZwh7iP+Y0A6DJhZYq6jxZqmd047F?=
 =?us-ascii?Q?tGt8K+mSJyC9p25VrTap+Ust4XeICpJTNTeZ/oigxNpBOiNAzKR6xKbCgwh3?=
 =?us-ascii?Q?VDhjGOk/Ik9oCjWgoYas03IwvbbiM4xH+SD7cKT/UbTIsWtk+RpJxuiQM23N?=
 =?us-ascii?Q?1Eqtm+oCE+vhISyNxg0hBKo45t0J9f64ibBBFqdG1ebcRxcNCawj1Gw0rB8v?=
 =?us-ascii?Q?cTPLJJjdqLA99Bs7YzOPe7oFK4rVIpryNZacHcEKfXTESw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAfdx4hwJTecYXDECCNXa0sOHmLQD+WQmsHkNDowaWybWvUBI5zYX1uETAwH?=
 =?us-ascii?Q?WIbWw1JTMtlb6DU6+y8PeZa59MKiGHL2SzP5pmyc8vuhjbt70mGdU1P9e0xB?=
 =?us-ascii?Q?jabTOZD704uxQkZ4ftp5Wgy4ZMYzAVOHj/XVyrisYxM+XiLT6OHlXNkP/8Aw?=
 =?us-ascii?Q?etJ0gpnwwpP/Ttd34jOduMwMhpV/+Rxwgv0V+KFqtImiRZi/zOcdwBZDMn9N?=
 =?us-ascii?Q?qGnOZCnld5YkF0DF1XyJubPmlYU631KvK49dv8JTlZ41W9CwHQqXHmwY4RLz?=
 =?us-ascii?Q?rwwAiTNfsoDGCeP22wHE5qJ6t3NQKhkxPAEpTNdBRnUSRsjzKNswK8QfG5Ui?=
 =?us-ascii?Q?WK1gyWUrjIMxpYjm84ffFVHo3Abre8c8v52P5KA0ZKJDRA1xdpFg6dWXTKTb?=
 =?us-ascii?Q?0y9cCA7L9JXxauhXC5Fs2JSQFUTkbizutV054J26J63PNIU17rqOsE3hRcyH?=
 =?us-ascii?Q?GdEdoa1MQ75FZPc/BnCu4Vi0RH/+UmxLg/j4BVDTX5EFJDpp62PYPVdEAAfG?=
 =?us-ascii?Q?9NBGZ2SBrAZ6cKW3VEhv9t/Q+BQHvJt9n9EVkRwAUQXo6igPqo9eZZeEKd1t?=
 =?us-ascii?Q?+udO7RBsIx6EGtDZA4JnbQdKP3Wc9dAkWscHadAsVoxDOVfcAgE670ArvbGP?=
 =?us-ascii?Q?QlALiEE6YatuHVkoqt0yo2BnRjVcckUcYRYmpCDRWZ+aa3b8uSwiX0cJb/zR?=
 =?us-ascii?Q?qZJnNb0ap8yWObvKFmvJFfeqNeC0YZXjnKDBYyJyvxVWaKF4kB+XCs/3G7LD?=
 =?us-ascii?Q?JXEXUz/7MxQY9bC3fJ1fFY5wZSVz48H2U90jOIY6JpfNM4OKF6k9LW+wqwqT?=
 =?us-ascii?Q?OhfvJEGuSlwKRbAtXhLdQEL2FgP5C2kPkaFEWHgDnZNMxkf+ks/KzHz9uNiU?=
 =?us-ascii?Q?+2YyBXHBseieVepBYQ+M4+/3RxZpjf78EQW5NRgRgOw18oSW7mRg0FQQUxs0?=
 =?us-ascii?Q?DlleSfg7MmDsOhXxpsQ+ydHAoLOpAhjRQzCMFnghSU9GnTDt0EpqgKt1dtQN?=
 =?us-ascii?Q?ix0fHvrhHbqVBqWWycDQWcTGBWfJN3CGs2polTcY6GhfOms0YaD38+mUFy4r?=
 =?us-ascii?Q?BHDf1Z3BetMtwoVIX6GLqeURVz+mLOnm6k5ITEqpGUNDBhOrITutaH5IIJ+i?=
 =?us-ascii?Q?XDKxZuZH7VGgoc82dZ/8CzuMWgNIgYfC3H/6L4L16rVXaQW2KiFGQkRKmdh1?=
 =?us-ascii?Q?mWF8f057S2axDYhvTqGgsTEfqRbTOGTZifEn26WowkHUapkDw5LbP5k7CBnj?=
 =?us-ascii?Q?pODzZ0gSCTZSzyzUCkCUR0Ugijg9lDYj0adUmqKfpD9Qo5oIpU8gZ8k+vGeg?=
 =?us-ascii?Q?0OXkygcafScsAz0snmKJRzB6AwwiVT+jlBGEPRywAbHHwpUUIAFPFV9Gr9eY?=
 =?us-ascii?Q?c7dfbbApALRS1PHKyVcAkCLMEajU9gTj0TToTugULMKOa9qpsR1ATB3Tw9n0?=
 =?us-ascii?Q?vENpy3M0kWYCeFt4/qtixyMH+zObmDbA7idMHcEf3J3sPpCSVaIuTnaePXWz?=
 =?us-ascii?Q?FxOFUIzg+Hb9vetKF/iLdb6HMdv6vUYEKy05W3Z6H74xPTBS8BJ6GAJKCBkW?=
 =?us-ascii?Q?ipkFCTK1h8FS6JO38gGH5x98J0shd1WI3GxxDOW6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747f83de-a2b7-45aa-aed6-08dce59cb270
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 00:20:35.3342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w6mb5d/AGi7YRG8IIMe5C8wMy3OYhchsku6NROMvD4VULr5HyagYXkZq2YBq749zSU9xxg57z2ksBglntGRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9470
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

From: Peng Fan <peng.fan@nxp.com>

Add release AUX core ELE API which is used to replace RTC enable
on iMX95 to release TROUT.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  7 +++++++
 drivers/misc/imx_ele/ele_api.c          | 26 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index d4ac567e7e..7bb9d15b7e 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -38,6 +38,7 @@
 #define ELE_ENABLE_APC_REQ (0xD2)
 #define ELE_ENABLE_RTC_REQ (0xD3)
 #define ELE_DEEP_POWER_DOWN_REQ (0xD4)
+#define ELE_ENABLE_AUX_REQ (0xD4)
 #define ELE_STOP_RST_TIMER_REQ (0xD5)
 #define ELE_WRITE_FUSE_REQ (0xD6)
 #define ELE_RELEASE_CAAM_REQ (0xD7)
@@ -113,6 +114,12 @@
 #define ELE_SUCCESS_IND (0xD6)
 #define ELE_FAILURE_IND (0x29)
 
+enum ELE_AUX_ID {
+	ELE_RTC = 0x1,
+	ELE_APC = 0x2,
+	ELE_CM7 = 0xb
+};
+
 #define ELE_MAX_MSG          255U
 
 struct ele_msg {
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index b753419f01..4a40f2ed00 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -459,6 +459,32 @@ int ele_release_m33_trout(void)
 	return ret;
 }
 
+int ele_enable_aux(enum ELE_AUX_ID id)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg;
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 2;
+	msg.command = ELE_ENABLE_AUX_REQ;
+	msg.data[0] = id;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	return ret;
+}
+
 int ele_get_events(u32 *events, u32 *events_cnt, u32 *response)
 {
 	struct udevice *dev = gd->arch.ele_dev;
-- 
2.34.1

