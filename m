Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0FEC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B21584CBF;
	Thu,  2 Jul 2026 10:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GGk9sfg4";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F2C7TO4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B289184CC6; Thu,  2 Jul 2026 10:13:08 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB1C84CBC
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6623DAU81285567; Thu, 2 Jul 2026 03:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=NUW9yEf4rnSE5TZXmb3VSpaioye+zqsS12wp3ZPLs
 OQ=; b=GGk9sfg4h5gupKvs6az4gQ+fCWba+B/Jreatx4PmELUs4V8PAzbVgaMbH
 TjtNRZtxzztYl0MldsRwoTs7LeId5sJsBeoqV9lTC7MZF3ZJPa8L1BtbagbrBK8D
 zC1C5j0zzSiKt0zStzf2X2yA0F08+ED9mxktTVlbjZJMwceK2G6QdoajhhjYNUX0
 GLc9iI4Xz+jdoPxMnwwnT6g790khgJDDHm+R0omdOcWVo9AHknn2xM+ePCvWJjQS
 WrOpK+6zK4cYXQjZPXKu2aBTp5rurr19vjWIXRV+ljJ0lFf7nRQhMNeFifyWg6Hx
 LANBM0vobTORLEn0pxc6WktwboPtQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f5fvyhe1x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:13:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ2PlCiZnC6kkHN54j+l+NhjyTdXxx/BpGTgm/e8IvTPsPNLmWih/02hy87vQ0pzHllix10M6T/oOlKa9RGKhRvj5/u/p0qXe5d24NT/eZoyh+KxIiKyb7z9qdLGBj8GmJzvay1zxI3mBj5fdOPjrvrfGFI83/23Wa68Yw7XrpwznR0SlmVsjpuMbPif8T5BzyVjmFNY2DfAmm/dCN2Xsgj7U3J4AiG7zyvteYFcFmf8YD9KGCoBuJmrZd/IPt2AxXATeKDNQQRZOJHRruQtCdvt68k4EMeSR5g8qUU5/O1Xp3j4KcHzqS0XrkyHLRonZIjGLIGves6+P2PbDXPsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUW9yEf4rnSE5TZXmb3VSpaioye+zqsS12wp3ZPLsOQ=;
 b=gNB0hwR7p1MQKMzAdncufdd3o+ux0c4eQnRWoSgL5YIWv1Z9dU/YKFwTQItPmaOsB2MqrPxtMrLQ3azD4hdyzT3Rss4DO9jNBTsW9Waej5VIdUGyALo+hpMDAb6jT7+VYtQDvJ5uBNZSf2oEr7XyoKK1FoyZ2qvHiBT2r4RNODFFYxkMbMy7w2TxwEt8mQZ1RiDInFpwjAk/TQuHuaYmJ5OQiCjnV+dfY9t46MkdfzYLX8jxg1cRQGdjRZEAy6rFKkrT5ezJ2heeD1uIF8fMXn2Vd0/YxVOHSyJL/T8uCATByTJrxBIFNsamD+rDKGU7EOgbip4bT6ICYeNOlJVDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUW9yEf4rnSE5TZXmb3VSpaioye+zqsS12wp3ZPLsOQ=;
 b=F2C7TO4rNpKUjzH5Te5hJftDjUgR1946f+SDal2wUPLPP8Ffl044Ni94dDjuvvWs/Gge+RiVz2+F4tTeHXubRCn2TGkvN9bKPehZX9iJY1xaSc1UrJkzEFw1XSn+9YX8xLZ3cbW9q8hvecQB46r4YJ+vX65dW2iERCQv46EZ3us=
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 08:13:00 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::37) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 08:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 08:12:57 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:12:56 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:12:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 03:12:56 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6628Ct1F2889392;
 Thu, 2 Jul 2026 03:12:56 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 1/3] configs: am62ax_evm_r5_ethboot: Enable config options
 required for Ethernet boot
Date: Thu, 2 Jul 2026 13:42:49 +0530
Message-ID: <20260702081251.2691159-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702081251.2691159-1-c-vankar@ti.com>
References: <20260702081251.2691159-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7680d64e-f4be-4f65-c2fb-08ded811b997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: iTndeI6XNxpkicgMY3UzPhpbi0vI6x98HEbSciy9fJGpnfqVoG3eFWiI4sjcs5ork1uu9uidwkMj2IyBjEgqpG8/je/ghB5vp8wLquEibxWhUcwCsB63hjJTvd9k2El1qFR2GPb6YnyVLuSqfvURWOy7uZ/c+37qkTiLMMDfR87WBAj4tfA+jRxq/en+eALZKMJ/9SKNmFoBqz2S3bIZ2EANGyeKyBNZYrr+2GHFO+Vucdcdnvf93k+bxstaDJJN2GejC/b+YO2k2lPBOOGSAoXlkNhpEI6Tz4fV/jmAnVId3I92j1hW343mTBieVRGKojl+8u/lv39KKnqLYgIrLCh8OaaTkejUKnhV2cY/RP4AalNUvQpahPepZXT6EsZQ22LMz4p3fUBJT6JGI/wg4vUwt0G2ip1gf17wGWmjkJ9c34jb/Mt3COh9BaJASSK+TCDB0o138nkqr+/xC3JFLt22eQUMl49w4/t4mGSogMoKz6zrs1tjOaOfUGBo8VqeVF+zzYt2/pGPpSQVdEwh9xQNBd3epiX1jvBn1NSJH9s6RlrpvvTpRSDMguQtYEtCuorC4DxX6a931sRPTRhxKthmMLJch/luuMPsiZkRGqq2A5aG46UmqSBoQDfe790/abS3RX5rHLCj1RSmx1pHj8AiisFU6IKmSINlKCDSkv7PcD+tUfPyOuK/tHJdOkJJyAgbQsbxVmWCffXA2ICztQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8PLy7SEdNDffVVxvQMYhhQA3Z/DZo+FuUZFxYwEzmXpJ6C/3BbW3Lyqw3A8qHZKtmh4/MyKYFZTlTtbvQwESaCNNGebCN2So919Kvzgkn+XWMuPyVLxrYRcyfdp4KMbvyShiQPBIQe/OinGUWBWvGT8PCFxQpoAC4t7f69DNQg2D7ZkglUxbw3sPdNYRmD3vUUiHFiR4BAfVuYWG+yba6r3uGspTisIq/7nJSKU4a8NLJrKloWtbu3c4l0rwda15BWZoTg6u4xmDCWCaL4d+isXdlnuzVfK5KkLnX/7+fdtkrD4WYRx4/A8Bf4JX4ODuhw2fcqoyWjY/c0Ok/LO1oAve2TVqKnwhzqZGfiaj1zVWlbPpu5a05OQjDY3lL60bDmelUYqVk9zTA5YTbqlMMSMzx1xiBVDB6Zb7VaVUXhSWO4XsuXq0peeziHfsGZ2c
X-Exchange-RoutingPolicyChecked: BGtN6D+UdEfCwrMj6Ay6UZ9ZZ/wS5VSznYpsG8IcCxTxOBB6sRBQ/Py+mRCfYfO05OkBv4O0XiOm+hzXoH5kj7IxmoQwx8QVWAzxkbvtac4Ze8rkdGsnAvvhSDbgSFrShbNCEaQf8ewfnesmt4pfdOnf/QNO5TYQQTXYHzksMcrbYWHhsjWAhOt3dqk/G0LmISzeZucoBJElnglUsXm0NDq2WmBD1Yd/+0HuryyLkeI9zOnd0+zMYPJPW7jsnD+xg9vT1+I6B7FmawSV7O/F4b5P9TwIBcSCyAkIGuSAQ4nDlEHAfIma7+1iUhXrs2IB1pLuRR3PpzGdXm5w43tGLw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:12:57.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7680d64e-f4be-4f65-c2fb-08ded811b997
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-ORIG-GUID: Pmw1pfvSS0rn2zhNd9zwJ88shHAx0q8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfXyx1QkMKJrxAL
 zscTg+tJi4tJ3QwdvJfrP6Fc27p3jSQpAaGNZEP9lKjJ1lDu9mY6EoqYotkEdH75hT1Gq9fV9BL
 QbrTju+twof/rze/Ba8sVklXVXhZkhu06bOBF3DFTw+SidVXHCrAXEFoGZGJ7vc5+GTWI7Lma/b
 8zMCzw6WrJkcO+Yeqw1l1oOgMMcfma9ctjDXaK9f+OJUDRk6jCbyhezZGGnb1kV3v0KkG2ioXUF
 lxCWSin1k4ZxAe/iYrrbPuEql6Nda3/PeLU9X93/6PJ7PLOYgtQBdZydboB3Ega6wpb/KS35ihS
 dM4wyaY0yjeerE3IJ8q0+DqBkZvv92s7sfYZKZeEgcz1TlhQvSKYZF6yGazmge2PpiVWZH1X9uO
 pm6mGERLTHRQ2EBEHEpde6Rz6jadfN0xy/BIFHKgFeKOTe028sEsvQjJI9Ux8H3JiOjTAn2PZMH
 fi9QEjddTeCvxxtVKag==
X-Proofpoint-GUID: Pmw1pfvSS0rn2zhNd9zwJ88shHAx0q8P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfX7qQkW/nXePjg
 hW9nG4oZEWAnHXY9VL15K51eFVsFXNiSi8tO3uMHPRYbicQbacZUtSAV/2rnYkT8G1tn1oDT0Dh
 9qeD3unXRKteQzBsaI6YpMTBHuNRZ88=
X-Authority-Analysis: v=2.4 cv=T+q8ifKQ c=1 sm=1 tr=0 ts=6a461d90 cx=c_pps
 a=YlXwlwCmDr4vNaLG4mezpw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=KCiNzePIEqwCjz3gAusA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020083
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

Enable config support to enable Ethernet boot on SK-AM62A-LP for R5 SPL
stage.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 configs/am62ax_evm_r5_ethboot_defconfig | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig

diff --git a/configs/am62ax_evm_r5_ethboot_defconfig b/configs/am62ax_evm_r5_ethboot_defconfig
new file mode 100644
index 00000000000..215084d1490
--- /dev/null
+++ b/configs/am62ax_evm_r5_ethboot_defconfig
@@ -0,0 +1,27 @@
+#include <configs/am62ax_evm_r5_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SOC_K3_AM62A7=y
+CONFIG_TARGET_AM62A7_R5_EVM=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62a7-r5-sk"
+# CONFIG_NO_NET is not set
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_MMC=n
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_I2C=y
+CONFIG_NET=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot R5 SPL"
+CONFIG_CMD_DHCP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_DM_I2C=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_TI_AM65_CPSW_NUSS=y
-- 
2.34.1

