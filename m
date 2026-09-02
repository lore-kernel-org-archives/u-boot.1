Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB0FC61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B9C080DCC;
	Wed,  2 Sep 2026 08:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9716JYRq1G4H; Wed,  2 Sep 2026 08:54:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339244;
	bh=DPMRKbAp5jBH4efwloiNSZ0kR0KMrDweNWLM5qCNR6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y2WxQaR7XancBP2jsWhPuSx8GGQFiI7Hc6KyFOA3OL07NLRdaQ0xbWJTriy8TG0Ep
	 lZWR/CwPy+8yfTUQmhAcg4giWaEawX1RCvcgG2Qgt14aA89q+vmVkd+LYmzVX0Qgo0
	 eJXaOmM40nhrU560akwL82kX701Mp5rYjb2BW5l3agfyfNen2YBEETYAIY5kGregjx
	 rBlvN4euSYmenwVd7nUiX3Mufw+jOJo2Lw476+8gSfAS4uOBV6juegFvT9Tbi80tIT
	 DrtVsSWk+UTOO+2y83F8WrPWzX0u04RMTFoxJvVhdo8S2nJEg6qlzvyy+JLCWxxDWk
	 xvNM/0+jbbhrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A03480F78;
	Wed,  2 Sep 2026 08:54:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 339EB2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A21040329
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Ew5Jdkzm71L for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:54:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=lkY6vMX5
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 575EB4031F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuxDobPrf4zMDKI3VLLXtmFVilfBcrRCPlI1396GOk1CIF7qEo+FnOoM5F/aj7o+OZIVkIQqnmZlJzxT0qNTE2Rlp2OECF015+8uhEdQz/MvJSXXtywKP7LaeF0edGRO6uIHT53YUlUZH9/XCpCA8RxmBReIKW6X98wfIPr8O4fOqdZh6jbNMAjwjxa17Lc80KJQ49/Aer6jVzHxaF23dTDxNtDKIblmVozG0g9+Z4rn+Cao0xibTQbGzNyxHMySxZzr9yuGUG46lRlp5wJuolhOkZReEtbToZnhvRp7hnhPOArnlAPv96lfHza/qVrDsuWfM3aXK0bcTSkDe34UsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPMRKbAp5jBH4efwloiNSZ0kR0KMrDweNWLM5qCNR6E=;
 b=RjNwsE+/0RDXy8AM69Q+rGteNuLVjtRYp+Dpyy7T6vZxgFdEXFwEGCDTS2jw7NRZEj21x/d+HGNZ57gsSnRzuHce54MU1HekwVkHDSfMdDxpIQYdF2v8wGdsjlT0vOpMQnpJC8mCO0drsBGHbQin4HHoGK2GVlkqlWQyPi09mHiDX0/9D9eKr6eAgFwVVtZg0hgx9J4uCRAd925yZy5FOJzo5g3YUaZfq6sU/XkiGAkHL1y4mGQbjp7S933GEj059do81kjLpS7BpMrx1lAJs/YVGrUNMURoCisjwD23xLSQA4/PiIpd02gW1FdlflXCNnRGHpTotPGzAsX0yTAXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPMRKbAp5jBH4efwloiNSZ0kR0KMrDweNWLM5qCNR6E=;
 b=lkY6vMX5xh01jsOeqbmBciqdq9NKrnwl+ItNmWbUutL/PWDJYXGlTXBKCs0apOvbUtdxKRLn5DzbhcqffSJrtMrUupYh61KYjMeJua8/EKQqL34OpIA0lv9pQQG6k89qQ9pBVwCUjechTPieKFaQWDsZvKWQYS8wrR0yR0J50gHt4AjCSP/dFmlZTbAn4OzayoioE0odo2FMdiTTwiqPbdWpQG6e/rUVv1bjKaZv8l7nGhYle3Swj662i1IZb3RYsCh4NhF13YQR7pr3NH8VToh3RZt8ug046wnt/WlcGgeVWG5KgzWnUFDzQQG2xTraHVLdzZ6LF/9B5laRvzVcww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:57 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 13/16] configs: enable PCS for Airoha AN7583
Date: Wed,  2 Sep 2026 11:53:08 +0300
Message-ID: <20260902085311.1550804-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a15e5b-5926-4289-88cb-08df08cfb938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KUyrb/f6W6DHJCchvuARc0ofw1tws/MhfUs4DP9YCOrCpoQrYW7t3/nXgL80dD9nc9olfHmqiFvX9xCuwsx87hcIRr+mWFQC/ALA/aP8vwmiFGjwos+n6VmU+nEUyVDV+ej+p7pGcbFxJnDkupnUKX/osVhgBXyPz7KaGOU5uQNQHIWJIB2y6wLBKOa5/0rEeDx+L5Jq3yqcYvGl3PW8SUgm/6MRjJgSII/Pl8E5o9Bkc+OmSRTzhcg3jcO0oEio930n8OShLlhJMKAaWLWqNnYZ2QBgzjQn7N2TLabs+mg0v5fwFOfgvm2EzLFV3Zf1XyXlA9S+su2ryJKL3TDSw0LvL6wnfWVKO/QhB7h9r2q/i8+ayy7LHjwAo1OmvdX1Ql42VshwY7jQkSZ/aLQGVU6EgVzbwe6uiemvBfsqMZ/LizMpE5xyUxxjHBk2YvgjnjYzN3S1mU9rP5e9JuIrdT5zuS+93atboP4lrVzzIpbYCVgdm23xc89ZdyDruXwZsxsQSprUC5k5WI51P9/Chnd/y/ni54azL605+/KCDphBcO0d57hnxCCEELJEfa5Vm+mq1ZPYlcQORDqJyRr/b7G9YoVFhijknyQBQKl4nZ3xKeHptZrSbov8IDaGuCBcD/mb4kVie3E9mniohC7cOSC/Hl3HgUtUCN7bZVLoMUv4YzuHuHMahtBSTqUDJK+qNkBlVUdNsfisQx1vyOgZZLs/VleV4n0RnnIGMB+uYng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQTYMqpqNx41rMC9ZxB6KBz8T7MSZkInlW59k28DhVmuzllvGlqwn52zpEQa?=
 =?us-ascii?Q?73HQnemMI7r9MxfzXOdkqjT7ROJrFkhb0wsgAuMOBiISkEqK9gs22PwIQJou?=
 =?us-ascii?Q?XFzbMccJ8AmqBVxwVyWyLJQCHW6xoHjMxnvkl9soXlfynITubiypsgNNbCdI?=
 =?us-ascii?Q?Os2VP8kUQdZhqglrar5oM3bzubH7qfjbs4cFoEDCQSOkGUWLcJQ1RtxZZLEX?=
 =?us-ascii?Q?fnLWmVsTZuH40lIyr/RH5rPGovwjgnIAptDVJ8H4dJXx07inP1e9+IV9y1VT?=
 =?us-ascii?Q?V1y0NXDorIno0D589XxaDqGc2L6gftgyevnKVhD+v9tcGPL8WAqIshtasFyV?=
 =?us-ascii?Q?g4XQl4LBotyBoFK8EuRwzai/pakc5S7WOGh0iLdfP2M+Zh5w2vk4eLHQrSvS?=
 =?us-ascii?Q?czvNndfcVOmVjvhTsOqXpynLkfTct9C1XS1XD7WeNqZeFX6FuUyzhAEq9+s5?=
 =?us-ascii?Q?7nH6XSVZwjHC4Z4nnEJijV0MMPB4BB8e5Ko2hVtLaZm6vd8nRst53KkIeyYD?=
 =?us-ascii?Q?Yg8Zeu1ujapuZH16EScfama/L6FkFKhVOdBtsf70Zj9FotDp+Sd/Y6d6H478?=
 =?us-ascii?Q?5RtKFekS/wsfWSLd+1FY76uDxv9Oehn8ZuR9kes7mOhlrBCtAh3d+PA12JJx?=
 =?us-ascii?Q?kP3Z7qHFegZb2ju33PG/1Goo+nxC9A/HlZImjRwAtjgt10e9EggXyfe7yOSc?=
 =?us-ascii?Q?lyunH72o5gP80swUe0fbTaKKGVrDk/IaD9xFw8oeAvE8gL4zWMEdnUKbA5K8?=
 =?us-ascii?Q?yCUJ5WmGsBeZ/9rraNACLdOPB8mamoPYEGxPZZhhV2DkDS7eGpo9praYxgMD?=
 =?us-ascii?Q?rcSsNwgk1iT6iKnm/M0SiJYfCdIpIMSDW3LiLQjt3Ick3uE5inykTPa0EaVO?=
 =?us-ascii?Q?EcbsNSBwtg4wc7Bapu+kR1vbNGxT0HMgIJ1U43IxWhtF4DpOL7ybxEUMqPG4?=
 =?us-ascii?Q?om1XTfJDZEmwRq0DhJJ3DmbgKaODDaR7zbCtxnc5iOssCYafL5JFyk/7hj4O?=
 =?us-ascii?Q?VshRMzPTmiyvLRst42sS/rae5ETvywpyMvAoHGbQU/cXzK+4BJuNCuOWc4xe?=
 =?us-ascii?Q?zexueHsFBQBNT72nKknM7mefizv+66dBeuGqlaXDrum7HtBhJVgfYfkljS2w?=
 =?us-ascii?Q?JigAkrwtkruhJV3xJE6iwOFOHjid8r101S+TrMSCMU8cqsID4oAVGpp9CVOM?=
 =?us-ascii?Q?wzFc+DK5N6LFu98f4MVX4rgPkaP/4DSkIn1GR1rmxirPMhDihk+KVK/SqxYu?=
 =?us-ascii?Q?DPjAc16wmJEzQdzOH35DZnzuRZ2eS1jNHngcTwCgK/BeweTJH2YemsOOLgvX?=
 =?us-ascii?Q?LU0+BVL7KKjNE/TphRYdtwixaVzFpsJx1u9LuoE6vEufqDcl0Hb1tai8mfRD?=
 =?us-ascii?Q?Jr+tzizG5npxpRQDyY27D8t7zaqBjCH5+xCjt2jElUmgrXeV9gewmTDONWXX?=
 =?us-ascii?Q?aWQQWNIvT3FiY4SP6s2dX0On4Gb7Co3jWZGgdMHIpR3Qptq7F9NhTbwQtzpq?=
 =?us-ascii?Q?PvF8O8iBU+iWnwkVnBaUz2kLcrmaWVSE5DA1ntaqz7YtmF4WZJew/dkwM/Bi?=
 =?us-ascii?Q?Mnv/M8jqAYEbK1l0Mw1KFdhZsCyWT8x5kT/PpV0KUJkQTcYLJpYPryRjaiHS?=
 =?us-ascii?Q?kihW5M/xxOsoGpmszjyDUtRKuFeF62BcWh+B0BAhEzPSzWZH/FmqDEYr8sO8?=
 =?us-ascii?Q?O7Ao94lBbOGEO/8HpCIshldjXn/lJ2j2EhN1PZCpf/TUYkNl1EgRYQxkNMyr?=
 =?us-ascii?Q?lBKJyXTXiJKLMsBizGX7BC2Vm5oMRMo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a15e5b-5926-4289-88cb-08df08cfb938
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:57.2169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo/GvuDbO5GT1wmbfLbrwPvfvQfqPFDblmDJKkvS6MTScbKLTcOIs/DAGJy0fGopc3B4uHIcBWfEkTOxgcg3PHi5AO3HQr/Qdsf3+hQS9DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
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

From: Christian Marangi <ansuelsmth@gmail.com>

Enable PCS config for Airoha AN7583 SoC by default to enable
support fo External PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7583_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 7178f45e3f8..8b076c1cfe5 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -65,6 +65,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
+CONFIG_PCS_AIROHA_AN7583=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-- 
2.53.0

