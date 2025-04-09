Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D6DC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795C18357B;
	Wed,  9 Apr 2025 09:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Aq8wzi/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875538357B; Wed,  9 Apr 2025 09:55:09 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDC283577
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwxmXOc7B3Hf3/ezANZyuVH1XMKRygbLn5eIiAxnCzR2BjfCDZwhQsrnVAX4VweIPrRWYlc7pmqsxG48sTqQLl2pFAbYKBGyFvX/LQpPQeyviD0ly3SifNeO5cDZY8KtENTpVsMfg/RkCaYX5VBsxCf92bWUzeTJZKxahD4daoWs7mSChRvkaqyH1+1JGNKFO7SjEoxZB0WYvs0NJcEiomlLgXZkQv6GW2R5OBe1gl3JXbQGO5ReitNJnWGTeMHsh1Dy3zn04MWVy5YpskEY1HeNLjEMSYDIa25y3x21Z6J+JhBc+Ly2qCaiJHE2fixrG0Q8OWs7npkQHri1HNVd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYEq6haabY1SeJNasorcwGbckdmq/6QMmQElW9N6L+Q=;
 b=Y/crKVPWnB74pxK6PPx9VRnykEdUNQBPCxbu+T+Ur944ksLpzQrphy6gy2T7KFRNiFOVLWHZQ7JKPSs/oFcs3FaX9o9mTpE4/dcxI4bTxa+T8Ew9xE78ACwSXDjwOAmpqFpjuEpjodNkxKtzTKCt6CcYTdClP6KhqQQEdnff65a6hE3OkMw/6uNJeCDruGD1d2hbWv84uX1zJnK6LDbzdkMrjhFJi3zwmI6g85n9asIjS175xL9XsDn54yGm/a4T/hHkBx0N5zGTmPdHoWznjqae+t8Hcgnvu97etUipt5pxFdZ8ma1Yjb9ZnWSY7wix6C7F7s1MtEnStPGQ++TZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYEq6haabY1SeJNasorcwGbckdmq/6QMmQElW9N6L+Q=;
 b=Aq8wzi/8YaPBH7K/hndYCQ90f7TX0gmXDoEqv+6Br+RuAVnCKgcGwnhyzcYVb/uNvyI1xFIyQ+Bahkjzj+ongdjmkcNFbmJ9VCCTYCbxCl55SAPJ+1SUDuZCjwx7eRewfLaqBltVbqgD3fN/g5o8kQ5rWM5CsPyJQEqzkLiBMtN/ASo2/DVQ6Md1NuggfSuikWcRWeer5154/ALTwRPd4ghkPvyBfPMIEq3jBwMvcjuTpypxIvQxd1uQ1D/8oUvCL/Uzxfim6GbTk8ezz9uPduQ/vh8E01myQOZ2gdDRQ07PgcI6Rm+GtWYUsGVkOLTU55obkphBmlxJ50FuniCpYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 07:54:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 07:54:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de,
	trini@konsulko.com,
	festevam@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH RESEND] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
Date: Wed,  9 Apr 2025 15:53:51 +0800
Message-ID: <20250409075352.535194-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb0ce1b-6b6b-477f-1f78-08dd773bcc36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oxS849KDDJsyHEAWbvR8xSmmO2RcNQWsgmMuqVrToBNQUtH1kNlVgsSU/rp5?=
 =?us-ascii?Q?7J0a2ztyIw18q4Xa6Qrmhrof44eYCrmoQwPkNydLW04BBu/3DVK+Z86ub1Zz?=
 =?us-ascii?Q?HXctjZZoqz3pw2iYk0PUErLNXRpvxZpalXcA2GZRIkci5U0M8kyLY29wXVR9?=
 =?us-ascii?Q?vw7D2pVYC2uDEW5L9ygKlnOP63C7bt/DD/Uzt4fKoIrHmCLRAPXBul8GIP6X?=
 =?us-ascii?Q?4/1i+4JKhvbq4xpNeEQ/xO8RvlMvGHlN3w7gQ5LiDeNujyzJbgdXqTIojKtB?=
 =?us-ascii?Q?NgJj2U2fJOedPhF2hygvYIr8Me1N1RBwjRcfAyBS0I5TRmPOp1FpK9US3/n9?=
 =?us-ascii?Q?h2nqlFX0I8iATPZm6wJNIEti5EbvCs7MbBPKZp/MozwYm8KQ5s2YL/MpMzEP?=
 =?us-ascii?Q?iWt2ZZHkQ50fEQjTAMuMFuTSU/zaY9yZKvbLTPOTOLNJDcZ/a7uPgHSXbI7l?=
 =?us-ascii?Q?Rx9DX0OXtO604AxdUEEk7EOyeaGQGPfAPY39jAb5PxeKzL8buLGYbNK/LPS5?=
 =?us-ascii?Q?T9Doa29qTUzEVih2kf6AQXPnAzSpwhok/ZPsFPTyaifCyJZ7wjn7uyw3fOMa?=
 =?us-ascii?Q?Gtun98p/T2+6Gcqphey902bY6cGDB7GV6kkj2/nq3ImGM5MtvQ7276ZnXiDA?=
 =?us-ascii?Q?HJItnIsHXmnQQc9yUeHouo3fw2IKcV3Op8gTqVGhriH4Qi3YduXVS3qKThTH?=
 =?us-ascii?Q?Dyp3TOuDWeFCZhK+pBNnFab9cb6frGA2j6JQ5wDddFnEPbNQFnz/Aa+xnME2?=
 =?us-ascii?Q?65zykjMyEaHq9BzWNQ0VoUrGqZS6kfJEkyaekE5IzrmdIGIfuAOyEHp1uyHl?=
 =?us-ascii?Q?geFpvke6zRLaJ47jcSZcp2EyuUnGw1Wlm9fx2PrHoBSuavpR/oLCu/Go+7+a?=
 =?us-ascii?Q?xNeQSq+6gzGKmBi91WIEKz4JS8Sj9Ig/JfNoicTSvuxsAlP0Nv/xOCBN/gVy?=
 =?us-ascii?Q?rbfFpfDl/gDqJWmNS+0skGCUA7DO1wkSScjElmvpUD+8Im8fgeA9zz+AJBrm?=
 =?us-ascii?Q?Nthxaadm4ZFgVQP8nGlJ2IjIf2TRmJ31ZIuhGQgdG6QNuvTZTFIx5ugaEt6q?=
 =?us-ascii?Q?6LMMDVSIm/Pk7Knp2faY3zxIwygY0Sg1QVt6YF1Xt9N+SMK4wwsDasMoEAZ8?=
 =?us-ascii?Q?Hop8vMtHC3SsecxDI6Tu5lhAw9OfuQ5mbGksZ2XB8gc/Fdsbl/hSRtXm97KU?=
 =?us-ascii?Q?YkFz1Q2MT3hoBQA7XactQRSbT6yRFHFEiJfb8bQo/r4jJm6ZY9ct63f+62uZ?=
 =?us-ascii?Q?SiSclQyGffS3vMhajgjo7ekiideQaf7rRugNZJ+LIQ4SaNRqlYKTA9dn+w3R?=
 =?us-ascii?Q?YMO0sRwIWtstsHMTlyuVpbCGkYDydMraMOXhpsABe0Enie62GrFvrHtNI47o?=
 =?us-ascii?Q?ri6+MIRae0NsOnqq4WW9KYO0z6CrfLvqKxkX6Tc9FrYYtiYkCWXaJqyeWKRw?=
 =?us-ascii?Q?9gPXU2cx80SFzLwKxTschJ5OOKVi5wlM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0aQNDoNP/le2DIrV54tJ4C5kuzCedHn8wSCJoTt0vnkMs1Ah5ZkvS7yMZAdC?=
 =?us-ascii?Q?fhPTG4AZB5m/qKnJFHpZnbQuV8Soa5Ffs40oiDVxTdw8GNBEmW0YSNQTChbT?=
 =?us-ascii?Q?lAOgOXhBSsMzasp8GILZy92uvlY7QtDC/cptdRXITnhWv5l2Qv8jFC9BbIwu?=
 =?us-ascii?Q?0iICJPMNQ5/+1ccIGkalPM2QdG5zebEN3q99ovYqDv50sy5uk8ZaOUXlDvhD?=
 =?us-ascii?Q?CEhxJssEPutIuBOzlaJkYWz/bBsM0USeBjTK0Wo8zykSf4wYhy8d96rlLuRy?=
 =?us-ascii?Q?IYVsdeIFTFLDxYbkK215p2AD/9ZI3wA5sgSOIuzS2tV6//iLIJDWOqcjncxT?=
 =?us-ascii?Q?Xn6Z+sraHLPU0JPOjPq3Pq89DMys48OGS9cllhcSjlzqNJFqVq9Zk3qx6iFr?=
 =?us-ascii?Q?qV/A1TUqb9TSZZi8/s3PPjB3yBoZluXkIvde6pxhEfvgHOCab9ccR9XCycMG?=
 =?us-ascii?Q?GgF5nlMopuhu3W8qDPu2Cjbjp9xhLdmV7jMJbtjvpVXAzj01eN2IZMgnm3h+?=
 =?us-ascii?Q?Du+j3Hkqi3W+TJ3dG3yipEj4121CYa6iM8Gs1jAX4nKLXOwIO6xkhJFCrIIy?=
 =?us-ascii?Q?Icgsr9Kd63q4Lr25tzwk8SvLP+uqKli0DSr+eEIFz4Pz+0/1KpxSn2tehQIF?=
 =?us-ascii?Q?hsQ9ug6n2snjevwYtpb1VGEjOfLEn5+3KONB/ox0TLGmPHYW4nVJOg9iNL/8?=
 =?us-ascii?Q?18FAhlWE32ZzZLFIx9v49GOZYPE3Vb+7QePsjoZORrc3yx2P2xz12KEg/0B4?=
 =?us-ascii?Q?XLWRRV32zu2a5oihOKHx5b6BVJqMQaf+hCf/GZ/HHj5g4PuEYHl0iFiaEEB5?=
 =?us-ascii?Q?x6GzyR1CZ4m5WNvJKyJzFQa4Dej4XpL3aF4jKGILQR7PpqMe7M5vpmSdHLHP?=
 =?us-ascii?Q?rQ23bGQE6qXjHA9eV9bw2AE6iFWCEzE3zMLHvnhOsvAHD44aHjB1fx92vfcR?=
 =?us-ascii?Q?+RoFu4yh9NYIlWe0viqwhr/AFjM5uRm9KFnKxfKE+f7x3c/Y3ry7n0Wsw+ps?=
 =?us-ascii?Q?KP6ol4Hn0k9ecIZa4YgZ+6tl8AjhQadlRhm4I7VIdqXDl6QS07VVqtun7kY3?=
 =?us-ascii?Q?ju+e0J7rG0vnavANWBS3CVKSzmqj764pys2nwbcE+xqm1RbGSnqJoNIUOcI4?=
 =?us-ascii?Q?cDJUKGEC4AyjLFpxu5ykRA3uIWr5/KgWVl86jpwmiHIOa6iL2yzUmYVQU8Vw?=
 =?us-ascii?Q?lJ6nPohT3E4pbcLsHKBq72mVPsdqe3Oaa4scef6cI6E7+izGHa+iKeGfh5dS?=
 =?us-ascii?Q?JbwacQKxL91zJ0tJNUl3Fm9Q6CwncK4jQxYWW9onPexTCjtUjeZZKvxo8LPH?=
 =?us-ascii?Q?7gevk533OzH4D17Sl3cx3eQD+UMmE+YGWCOzyD4p0DPqbQPG+joi3E35501C?=
 =?us-ascii?Q?j7nMYsQ6f9cfo/ZbdMXt7KhtBqenMHDmcgyOxSjKu61N2OACAYFa7kqIY+8+?=
 =?us-ascii?Q?guiqMDrBU2CTq5G2I4qVlqJpd8j4KPSXLZ0xXi5LkL09a6Mcp4SDHNHCJa5l?=
 =?us-ascii?Q?0e7St0fSJQc/mQ3bVZdS9ijayXKB0K1n5Eun6Yc4nzlppbP5lc7/f5vu+ak7?=
 =?us-ascii?Q?sHH6GaLjMWcZoEVAj7Fa1JhRaWPt/o2hpAJQO2GR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb0ce1b-6b6b-477f-1f78-08dd773bcc36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:54:47.4737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDf+a/te8GEeQaYXTkOiAm9ptyrF4fKFM+WxPDowsuc1F7agRHjqA6U/Pvv3f/DVN1hg4EKFOLHqj9D6+eN5zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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

From: Alice Guo <alice.guo@nxp.com>

U_BOOT_SCMI_PROTO_DRIVER macro is used to add a SCMI protocol driver to
scmi_proto_driver list. scmi_proto_driver_get() function can be used to
match a SCMI protocol id and its driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 16 ++++++++++++++++
 include/scmi_agent-uclass.h               | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index e6e43ae936a..ea79cfa0cf2 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -352,6 +352,22 @@ static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
 	return 0;
 }
 
+static struct driver *scmi_proto_driver_get(unsigned int proto_id)
+{
+	struct scmi_proto_driver *start, *entry;
+	int n_ents;
+
+	start = ll_entry_start(struct scmi_proto_driver, scmi_proto_driver);
+	n_ents = ll_entry_count(struct scmi_proto_driver, scmi_proto_driver);
+
+	for (entry = start; entry != start + n_ents; entry++) {
+		if (entry->match->proto_id == proto_id)
+			return entry->driver;
+	}
+
+	return NULL;
+}
+
 /*
  * SCMI agent devices binds devices of various uclasses depending on
  * the FDT description. scmi_bind_protocol() is a generic bind sequence
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d..842c56858af 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -115,4 +115,19 @@ struct scmi_agent_ops {
 			   struct scmi_msg *msg);
 };
 
+struct scmi_proto_match {
+	unsigned int proto_id;
+};
+
+struct scmi_proto_driver {
+	struct driver *driver;
+	const struct scmi_proto_match *match;
+};
+
+#define U_BOOT_SCMI_PROTO_DRIVER(__name, __match) \
+	ll_entry_declare(struct scmi_proto_driver, __name, scmi_proto_driver) = { \
+		.driver = llsym(struct driver, __name, driver), \
+		.match = __match, \
+	}
+
 #endif /* _SCMI_TRANSPORT_UCLASS_H */
-- 
2.43.0

