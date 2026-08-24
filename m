Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199F3C5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D752F40659;
	Mon, 24 Aug 2026 12:29:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKbGo5Po8SwU; Mon, 24 Aug 2026 12:29:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787574540;
	bh=tYSIVjK6Yfoc4aVN/GPMbjic+scR22v+FLlzP7BECqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ltI0LIltpuc6wBJESzAsUl76PSi4XBCRnY84YoivNXerOuW16i/0twO4eXTVyvztl
	 O8O3ju2Li2Iei0Feick3hD4mpRZm0CQJxloiOXDQonFAnAgU1xfuXgnK5yPEPX9dfA
	 Fdi7f6xNMo/s3vJ6k4vGfYuCeOEbnzg2OHJOt0UdGQraRuJEFsJtWCZouvySgWPzym
	 RomcBd1RlH5Wbes655ADwT4WNFLzBJv48RzzaY+DAkjKmQvxFq/KzbTboIaqjVweA5
	 OE/kIBB/DiD3VZcIYT9H2E0hwOb5ArYPPuuZo5sRN5eskwsjjXKEf64nclIDG5K7Mo
	 9eAF1NmQgRO7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D5F84069F;
	Mon, 24 Aug 2026 12:29:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 149A541A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFCA34069F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1cAX1RIge8Oh for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:28:58 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=DYcHwEPC
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CD0540659
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWwCDj245lq+6GA5x34WI6MZ1wA3WcHL9fO4WPXDoxifkGfZzLSz0eRtO75Gcektx8Hazr7GGJF/GZNJ8WcI4QoMPLATirkTyfhsv3M5VGZZkvFysExqmM6CDYmEqFpUKKiiPlT4j0raLB1zxy4M8LatyKRezxgCZh/jDyd1fz/ns7Kqd8bSXLzRYtP45yMZ+r5BChUzf4vYNIHm1j+nKAXrxdyDkW52aibuQ5yaZT2Q+Cvk3MJgBoJrl7wvYgRu6b9lI7dKtC3hKqTcgh06jd68aKeg2zzvgpRgPFPMGaOKuA4kjgwu84mRNdYJ4NrjotxXgOsIFwkyKtC3TRDLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYSIVjK6Yfoc4aVN/GPMbjic+scR22v+FLlzP7BECqs=;
 b=Q8SiOmQz3LtNQqa/4wJqJnYD2M6GxRnYb75aa+pFe29DzkeH+fRrQIduQXwrbWaDDU8bybSYzHedzekpT6smoBZCRpTgYFuWk0Rc9zfd8OAMfK5ywTJv1N7eMbFFbWOpM7FQ8vUXvYceph+xdAdqBZ4mepsupaidmZ6bzeicgScWU5/RmEIcx5gR+F66muhywVXVKrJusJu1/freJ59RW6oNM+OqSSvv0MHn5ME4lSYcurWCTJViWsbtma983mxeS2t08Q1ozbnW55PNbF35fudbq6/1Yd3vF/Zn2U8RJOKqHs1yU+6l3moAOHwLiiyz3sn9QokMASJnlQ31LQ3EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYSIVjK6Yfoc4aVN/GPMbjic+scR22v+FLlzP7BECqs=;
 b=DYcHwEPCQvCI+0XU7DsMvXKF3T19mdY+bwzPNInLoAIHTWtxjV01iawsdsEA+G2JFk+MMmkni9vupz+77t0lkWZTUd+TQRFFJb2cmImfUnpRCR516VRXvMHHJUFzROYyOZkZLxY4ZYSev8WR7+uhbcANx0dUb3g1YnYkAFrmHwwu3rZMtCPuXyHaOiLLM/lFOasLa21QGF0u5+vVw+AKSpR8/p0rXmdcvU2At3tQy5mQhUzpOcrmr6dI9Zu5oAltnEZp1inmVxP8Z8JdKOT9bB5eIN0ZAG9ZMpliHhOMqqpH7l4fUUTxNwWzZsu7n4B1a/l4TDRr1wdXewP2rmo/Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:28:49 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:28:49 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] configs: ls104{3,6}aqds_tfa: enable PCIe Ethernet
Date: Mon, 24 Aug 2026 15:28:25 +0300
Message-Id: <20260824122825.95712-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824122825.95712-1-vladimir.oltean@nxp.com>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 36583551-232f-4023-ac52-08df01db401d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: h5YkQVFAtgS3AnANpINc0TOF42VagC0my4p9cFyH9AFJojWtcP2VMk4teSobg9mnxAM8Bb8VWv7hfTJuVVfLbJ+RuLLrFA3PgTVnXkPqS1BM3pjfp8AHA5jazoefK1kIW88ArdVTD260py64duOE8nlWUa2IENVV/toEzPHhAx7fW5VwzFYXvKmgvTIw18s5CW1hRZwXIfJRvXRZGWfB3e99i94eyMGs64SQbzqYZlqaz0Kp+iTZ8LU5TdAmSrW0RvpfPkLFbUzm963XFW7lcrYG9Pl0kkrxuxaunuPlp7Oz9kdd+t6aNwlmwZJTGlJTVpoQ/P7cZwSKgCdGMP8mqHJ8RBqIgdViRz+cV3039938v2sXfq0KStZJlVdmx8d12AKvVF3SgkT0P7fyLo+gqVSbvVukW0lFP1GUbovAWG27MSzgaedPq1FuL45UzC+pENHC2nylcrWvUZqR8lrOZpBUPiZkID0zOU8KCmwiekQgkhxbwwUXVOC7w44HiZfDQ87ueStOKtyk6blmMqYl8f5t4juJ+yGOeS7GdbD9XSnMV1yzHVmqQKClzvg+FJe0fD9lYmBZgyQG7xha7Gtc+QP3KQGLyY4Dkyr4pdK9CpD9XLRdJQZRn3esB5FQ8rEaQIg7fX41rbwU6jqIJGr/011a9Qg0pmO8NMt4nDhW95Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QR0fmxDTs+5dFWk6MrHXEoqsqPylugvlA6vV82sK6VZfHHwMvaNwlNJhuwME?=
 =?us-ascii?Q?0JXdNXMwZJw0f7VZ+iiaZnKrMFwSoahl2jVdJldFjarb7meylsRAdVIq2kz/?=
 =?us-ascii?Q?N6fSHgTg6M3MZ/Jdy4mC+ByfWra82qeCeNlYStRPn1zQ9ZSIm/jGY9KBxNOh?=
 =?us-ascii?Q?rqMZ0AK/qlPKdU6rhO5Mz96JFV+YjMQXZErxNQXrEmVrkIVIPtXMTFI6ACqV?=
 =?us-ascii?Q?u7uK7KQ2HYxLMowLca7tRAyPkEHiGgKNButXLDvGg+G/sc7pzGQMeZ/nGPlw?=
 =?us-ascii?Q?rDjNwkPgDUOm32fviU/atWYdQzjXHkuNZsCLsXIiSAYMoY0gH3RIN9OZJ6Wb?=
 =?us-ascii?Q?LzVrerp4vF4SHVWE1soLdR7zYPdqQCzifMf6DQXq+UmiRvF1DQMDEV6U1s/I?=
 =?us-ascii?Q?KVQt/Bqg+1gHodnx2OWWcP3b/TA+9y065Eh0tjf0yw8F6+2QHu5dDnddWrNM?=
 =?us-ascii?Q?UY6PJ7dIIxfjHKFGVXMJKuyNMQKWJwXDrnqjHdgdl9P86rmtSXdZ0erp2gY0?=
 =?us-ascii?Q?YFMVRGkFA1ujggG+pI0D/d3KNF4rC9sleRtsQ8hhLHDwcVtNj4zZT2hSh28b?=
 =?us-ascii?Q?eZpXd91wtouw68pB8BIQI6/ncbeUzYGO9/OB92z0DoeMkYD/zdrd+6Q8OvJr?=
 =?us-ascii?Q?3opEtouurj1Hk0k9AyM7p8cPzr3SSqzffCtrIj16JdRISMs616xs6svnh9yZ?=
 =?us-ascii?Q?wbhyMxVRaggc6K+pV4Q6joQAGhWQbNLk6Ax6A6e09h5ViuVdU1H+nu5HQTuA?=
 =?us-ascii?Q?bgfzjkx9dVDK+v4ctt4AndTRrAUnKw29+vHHcIkIVLUSADeMGuvgT/3j+yGi?=
 =?us-ascii?Q?0u2BWM/G2L11zIkz1Gg4u+fUcWIs0BOI0bFhfiV4MUWL79JefDo2FVNOITY+?=
 =?us-ascii?Q?V7JB74A8ziiTX0Yu+9h6YSHeMNVxjan6a01bAc0l4b7FxwqESNS/y+eWnxiv?=
 =?us-ascii?Q?CDBwpyC8qmWlnbmQhl56TmiwyT/p3z6122Pg9nsGpqeFd5YRjl521fbN/xGA?=
 =?us-ascii?Q?4Rzl/jnCVm9BeXvyfdIUn8R5E5vjrakHL/jQ65sPHhNNhGCgPWKkB5DqjsOk?=
 =?us-ascii?Q?f1HZdwZGbAqBe4FAF6JcfkseIQQMLk8L7sCCTHaRPiOhDTOKvfeBcqazV5J1?=
 =?us-ascii?Q?W5GMZBERxyvEkStTjQbDn43iJKhnx/F/43GYO1zj9nM9xnlcA8eSN0BGkTUV?=
 =?us-ascii?Q?MAb+NbItrxPjEeTzN03fPUyrB/aqPQYh07KCjlE62/WDBmRtmWJxxihoMg2h?=
 =?us-ascii?Q?XX40B4zWroi3hzlslru43hvY97qRPHZY+FsichTT3q1E75lI4MEM8zB/Nhmu?=
 =?us-ascii?Q?XrbYhK1q4agKaTlKoWDfF8oWvgR+9uWvzkxNxi0xeXd0yH1vfJM1Dy8YAkXb?=
 =?us-ascii?Q?BmuKADuaQPi/YWchdzsY4Iv8pNCXf0DyIy9sm+ORonTyGCdDaTq6QsvxsSuc?=
 =?us-ascii?Q?3c1tjlVIrG1qisnat4YR/McBomouqe1dPdiK/tbbN4I/d9FCAtZt9Yz6uR4d?=
 =?us-ascii?Q?hJKMqypseyEBfpVWFav1LPC9gQTN+KvGzTLA1kjAK3FXW5tKYt7WTACTGvj1?=
 =?us-ascii?Q?ToTHxDUp35IaaX2OtE6+AdmuUNGOEgDx5+IPoOORIZa2CI1TdE1OCEUta1qc?=
 =?us-ascii?Q?4QrrQAh+SjMFSqiw8rfLPhWFhgvKc7YF4eC0V90QwVET6YAx5hYAX80si4/5?=
 =?us-ascii?Q?GNfTxvAZUSo0W1ko16Pk0T8VsuKMX51RblMIywVlDgXh4a6X9FTmY4QmOat7?=
 =?us-ascii?Q?yX6O6yn9DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36583551-232f-4023-ac52-08df01db401d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:28:49.6478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRliWBgIsYi6DOQy7XF2OXAPIDNTDTK9Ovecyxo301tAQKVbI0VQF+F83FhRlg7e0P5PeQR+IGs53jPYEKOshw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

These boards are typically fitted with an Intel PCIe network card.

Since commit cd9b71c3f629 ("layerscape: Disable CONFIG_FMAN_ENET on
*aqds* platforms") which disabled on-chip DPAA networking, we can now
set CONFIG_DM_ETH for the Intel driver.

We also need to enable PCI bus enumeration during init, to actually make
use of the DM_ETH driver.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig | 2 ++
 configs/ls1043aqds_tfa_defconfig             | 2 ++
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig | 2 ++
 configs/ls1046aqds_tfa_defconfig             | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
index 7e8d98c78404..8e10b218fe50 100644
--- a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
@@ -11,11 +11,13 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_SYS_I2C_MXC_I2C4=y
 CONFIG_DM_GPIO=y
+CONFIG_DM_ETH=y
 CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1043a-qds-duart"
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
 CONFIG_PCI=y
+CONFIG_PCI_INIT_R=y
 CONFIG_NXP_ESBC=y
 CONFIG_SYS_FSL_SEC_MON_BE=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index e8fc4c9c1b57..236281892fa6 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -13,12 +13,14 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_SYS_I2C_MXC_I2C4=y
 CONFIG_DM_GPIO=y
+CONFIG_DM_ETH=y
 CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1043a-qds-duart"
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
 CONFIG_ENV_ADDR=0x60500000
 CONFIG_PCI=y
+CONFIG_PCI_INIT_R=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
diff --git a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
index 43699af49a1b..733bde1c3fd5 100644
--- a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
@@ -11,11 +11,13 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_SYS_I2C_MXC_I2C4=y
 CONFIG_DM_GPIO=y
+CONFIG_DM_ETH=y
 CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1046a-qds-duart"
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
 CONFIG_PCI=y
+CONFIG_PCI_INIT_R=y
 CONFIG_NXP_ESBC=y
 CONFIG_SYS_FSL_SEC_MON_BE=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index 31668b74af8e..ab1fdbd2b6a8 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -13,12 +13,14 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_SYS_I2C_MXC_I2C4=y
 CONFIG_DM_GPIO=y
+CONFIG_DM_ETH=y
 CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1046a-qds-duart"
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
 CONFIG_ENV_ADDR=0x60500000
 CONFIG_PCI=y
+CONFIG_PCI_INIT_R=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
-- 
2.34.1

