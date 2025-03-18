Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4DAC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 02:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4B5805D7;
	Tue, 18 Mar 2025 03:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="i1yRC/ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0187080F70; Tue, 18 Mar 2025 03:58:03 +0100 (CET)
Received: from SJ2PR03CU002.outbound.protection.outlook.com
 (mail-westusazlp170130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF0580107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZCqDgsJofnNvTS+rLQX8p3c7xkix/cDsbiKNxQgFJDmTb0Ik8+H6enb+Rgt00y5t9IRR7Tgvlneds+PNFrn5+sMuC0Ehfjmgu2RIwJRhrgoFDiEWxBzYd5uqmYEB7KBIdYCA/WnVb7iJ1V+2BCphArV5RO6wP8FDGF3gevzulS2DAUXpwXU67c80noU+gd6DLY3m0p+vhjtiMgF6ZW48AXXFnc8uPxWRa39lCtnWPRLAo9dU9loqKHKZcZQa/9QBhYHHxGO1FWD80VCy6lMPElJY9yJCu1WGsrhqCwO62NFi7nWhKPAUd9Rs28GQcuh3ccWK36xiujVgoCl7XCufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IanbdELqmgA3KZWJLoiNYqLAkEwyfUvWlFJcV/NW0Vc=;
 b=qBua6W4aqKBV32uNCtnBCQXHCELIayWoZzNjfch1HigOUVNrg+hBDXk9AEvOVoMSGf6W4M7+oQZ3pooM54B+uLg6LwP6R5pxLMANGuPGz1u8wDoUf2ELsqLsgdjLBsMAw3vlfd3QBQul2TwYvkfHL9/OWQBygg78VyvhYNz6vwNHjgjkEyBv1HRJuiJ0mCNRWW4vQtWlUAQRo2fHPQFRyPAeDEqQ3zRFDcErOQ0Sm6Z1BxR7kmb4EVt4HPTw2XiwJJ9eXOpo/SH/r1N4SZmba+hVNhVpHaQ2FWdwhg1q2LPqwVuEl3EEvL0hjZvIy/M5t+/kbii4F0EnGf003Mu9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IanbdELqmgA3KZWJLoiNYqLAkEwyfUvWlFJcV/NW0Vc=;
 b=i1yRC/caSjQKfVP9N/CWMItNnn0hy91zQDxeHeYHvm8/Hc7ubG8WqTI9xq+h39N6S3a2QvMOUlpPGyrfKVLLrvjd2Uy+O5N44qpdWUE3Ff3x76LRKs2oNXXXyyjOfn/jMmo2Mc0MPNR99A1gNbGjAtihPpfBc/Ic4z1EKnPCwyYFW6vubnqw7LXePMHK0fubR1ayv/05vsc22Aapn5w0PD2sRSQ0X8W4fSgmWw7EV9R+GZUs0qlnZ+qcvzDPgZGVbepRGWiB6sKLwY0lvP7I14U5s434lH6bFZtqLY+ZE68WssIkRvdQ86NbErBkBK+zeqKMSwFtkYe1goqceKPgKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3877.namprd03.prod.outlook.com (2603:10b6:a03:6a::11)
 by BN8PR03MB4977.namprd03.prod.outlook.com (2603:10b6:408:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 02:57:57 +0000
Received: from BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868]) by BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 02:57:51 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] configs: agilex5: Enable Marvell PHY driver
Date: Mon, 17 Mar 2025 19:57:46 -0700
Message-Id: <20250318025746.964-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To BYAPR03MB3877.namprd03.prod.outlook.com
 (2603:10b6:a03:6a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3877:EE_|BN8PR03MB4977:EE_
X-MS-Office365-Filtering-Correlation-Id: f60fdc48-0d83-4b73-0a68-08dd65c8abe3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5buJanMsv/DJr7RWdeyQRV60mu7OOBqoiaFpLVTbIb4NxuQ0ed+tpUpV80ns?=
 =?us-ascii?Q?hjzbE5GqrmQuhxnp6zlPpcvlgZ1KJLUnFo4aKVyQRAzMDyRPeTz59uXv3ce3?=
 =?us-ascii?Q?8cCA0dWc2cJluikwTHqHI82UrQV7uYdLB5aEKB/VmSzWSGapMe1w5vAcEOMp?=
 =?us-ascii?Q?S393rpQd1AOGE6aHEzBwHylWV/iZNh3ts4HrTIQZ6noeeA2oC/rVFWashKeB?=
 =?us-ascii?Q?p/gAWdhTKhUgWH0tubJl6kyDTorVUAT0AaXvsqDofszZphGiXCN1BDUU3D/h?=
 =?us-ascii?Q?rRIBqO+7fIqfNYFNCjFpwgJNImeMHb1DmoRKI9ayZyVm4uStgKbaaDKNFTzh?=
 =?us-ascii?Q?GMsDal787Vf6HHOtzdQ/jswqLXfVeF1rTL2MLZEemYwtDnKLk+xBZ0YV73F0?=
 =?us-ascii?Q?Yi3M2PbNQdPdzbi37NtwHFZc79uTD5mYoljD4oj1HiIO7eCq3nZULkEKOc2L?=
 =?us-ascii?Q?LfUyLx2TN05O/dPk26BYMD9A7V+Aj71VGb6fCTW4CTNPOeH5pTNeY7VukA/j?=
 =?us-ascii?Q?ju/WfrJmm1pLoPoj+SBxzosZZ6uS/477XKk0f3rvEF8lbxFrccl+54f0WTSy?=
 =?us-ascii?Q?upN/TEG8Q66BAK7V8EgOZUguKqPSJkhBHQRf1Mx5fmYEmnAELmETycYKzSDl?=
 =?us-ascii?Q?+QCPk8PikTGhaj56RyqSM9QYwDiUMH+K1sGb2kRQ0kinV6Uo14skclFvdk4/?=
 =?us-ascii?Q?4B04IAhdu1/N7IIxOvgPALGYAIAuCDzAq0t6RQOWiyiYmGpq1sO+Jls0DMHv?=
 =?us-ascii?Q?15zcFelVguuF4zwZtavwEDF+B3ZJ7jMg1eMbTPrvnZHv1wAWbMtI7M3DAFY1?=
 =?us-ascii?Q?LWVdhPFjkKjpHXtOMoNlgyNvG0tSiguSpc3r/kIXHXYNkdkt1c+m1CjNgafF?=
 =?us-ascii?Q?OYPflK3APlZDUluntmdradfg/7bWu/sJ5bgYB7UcqZHkPAtsQjtHLFC2HHZX?=
 =?us-ascii?Q?oQo1NP93SolQJwBK7k4xSqQBAFgRwlX7wuqA0nP5B3aDe/292Dg4cXMBWl4h?=
 =?us-ascii?Q?mvoETAPPb8b6zCXVVzUHdxG/RCY3ABeJvypX0BlkTqwX18aP/0EChBb1JyYp?=
 =?us-ascii?Q?ft+a6fJSXqi7ii40gfD38vIho5iX+Wy8NR33fBNqN04SVddtWmsuFCTsSzLy?=
 =?us-ascii?Q?vd6J1Cnmd3/q9kVmvzKVkGby+rRNPBD0h5Xzd5KGR7s/MigjXk94OaRcs5+O?=
 =?us-ascii?Q?TGgRgzJT8mVVazDFb8p/+U1+IfYl50OqaXLOsIZhOuI4bTomXo2o/dmoJ+Vn?=
 =?us-ascii?Q?kAP3XEoCT8AulMD6RKFj/l4n58DcqsG8/pFAiHfAaJznsfUTV+a5hSb+eUJI?=
 =?us-ascii?Q?on2M0w1zEsWdky44DR6/46x1S6AHK13AnJ0ia1xg/5vCeuT1BM6c3ug5ns0z?=
 =?us-ascii?Q?8ATLygBY+sEGuYq6kWMMoZ8+1azt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB3877.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGvk3Ixd3v4vv17mjdE+ayW9TMj2BfHXKWL2uw/Nc2JNSfx9N8W+c0c9oO3X?=
 =?us-ascii?Q?E856O9cuUqkvzYbZJzAEiTVKgfpYCR7T6znrbdbFYFZFwOhIJHWKhAzlFHZ4?=
 =?us-ascii?Q?1j4KVCepdYxsK068PYgQdVr+861GQez/8kLDwXHdJfaa+ZSlzrBY21ceZJcz?=
 =?us-ascii?Q?jUrK2wKtDtxVLkK9mtSwpS1sALw2J+pYW84mvqBmOLwB3VGrKl4jOkarwGOg?=
 =?us-ascii?Q?6Lb9x9La5xYNQsiyZqwTV4LLlm2PxqmqsWIBNb+k3wfA3LYWmIt+85tMGTbE?=
 =?us-ascii?Q?qiqlIviwyIiT4aqKu4kRHZNcWG7RnUjQX7HRRpRE0gw24GjqP94mESoCsLV3?=
 =?us-ascii?Q?UEuFo3QSkBNGjvTdVvOqTcNKpXi/8a6e1wN/8DlN66eHriASDURsD2nLXPcV?=
 =?us-ascii?Q?jYXsv8hs24ZF+y6rcjhCcbcXkk3sTAcBRq1uo9KQKGI7pLOPgNMr2I/FTZSd?=
 =?us-ascii?Q?PRQSc7n1Ddoc6dv1gan4z94UDpxtx+MTpFbw/zvXpI72ZOHusSmKGfxLQOMg?=
 =?us-ascii?Q?ZDwsX3o0fVFvPdqAvqvz6cDu121pXvktbw+LWc7dJoJi0VRV0WANsymxuJNn?=
 =?us-ascii?Q?+mWQL4XefIjRFxpr37E0xRht3Wgussmbr6dW4Zz+HU8ZWuC8Nm8Nn5OywQT3?=
 =?us-ascii?Q?ZtRzSUBvCkC6dbMygj1yw8BPtFrWN6xR9ORPmdqVPzSS3d0ZFJoTzf+mEBhp?=
 =?us-ascii?Q?F3mDfo+Te5gxL5p/aCLrmS/cvXhp/JAXUvbloXYGiQHWGzqaQMzA8YLren+w?=
 =?us-ascii?Q?CSI2FnsRuTxMCn4Gdmd68yo0AGNjOWzVzsJgxWA/3+12+X8oARB6JTbyEqyP?=
 =?us-ascii?Q?X/Qd6GrdWxVpK7IGHnCqonJHCt42QoUtu/r80n0H0ePzgyHzC2j9Rg/oNEOL?=
 =?us-ascii?Q?m8CECJ73dHvQ7djVpMwCxqOBL91VAPxOVhGqitrMIAxb0mmV+AvXTCCkQmNx?=
 =?us-ascii?Q?Pg607+0exg61XHZ8qWiuV3i+bRlU+bDJRKLe8nvttGlQtcue+T4VytAxGKzt?=
 =?us-ascii?Q?TYu2tp2NI1d27XUbd/X85lx6aHYqlLE3abdaWLyBX7Rvklf7TZENzUu0T6/M?=
 =?us-ascii?Q?Daz9e6qkE6iQvf9g3NDgnB2B/O9lWsnoeY5Tu0EFPSZxSeZWygvQlzd7WWDi?=
 =?us-ascii?Q?hiSnOnKVdPPE9uXSyveIN9MCXTeS9Gy0ufI6vX2jyQaHi+tkQ7WW52ceMN5K?=
 =?us-ascii?Q?TpoUE8O2OFQgTEuGU+K89jGVLaGZ2kRFGiFeJY7A2ip5AKdkSR1Jm+hMb1A6?=
 =?us-ascii?Q?K3ufdzhxahfRDfIlKmVMsE6napaYV2354LSu8VluMFmrZDaf/yVkz/tcNuFV?=
 =?us-ascii?Q?DyVtoQtMqwSF57SNdLYJbjKWbHw046u8fL8yNvSsmroujb3dp+4eKEqBEiJl?=
 =?us-ascii?Q?O1V9ab9ZLj47ZbgvwxjlrHAmaFbZXnmAUS9OfiTXDoi/e9nE8Cet2zGfCNNB?=
 =?us-ascii?Q?ntT0mj9PIRbWzFtAZhFgpRNYYxfCNnbHOHAQVw2ko46zQgYU4lgTpckD6ukZ?=
 =?us-ascii?Q?lL5fBLl8eByRwONNqYDsIkP1Oay8YyUatMCo1hmGcFfNiWGVJgosP5x9t+6E?=
 =?us-ascii?Q?N1lrJbGELrMR9ywU3WelMIIxUsdZcnhKQgpZVVEbxUaaT73Z4BTsatyZGCQC?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60fdc48-0d83-4b73-0a68-08dd65c8abe3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3877.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 02:57:50.9714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRN1+rouwYkyqxo5u0T8KNZBEIaqbIDvXRraXvQWXfMMXRiaI4oYUQjwW7ZPjzwFkFSBiBMlyCaj8LOnAzxJDqDHSkCtHB0c5st7unDqQ8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4977
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable Marvell Ethernet PHYs support for Agilex5 defconfig

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 0fa81b0c738..2e59d2bafc7 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -99,3 +99,4 @@ CONFIG_HANDOFF=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_DWC_ETH_XGMAC=y
 CONFIG_BLOBLIST_FIXED=y
+CONFIG_PHY_MARVELL=y
-- 
2.25.1

