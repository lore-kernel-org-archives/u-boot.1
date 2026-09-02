Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FD9C61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3D188107F;
	Wed,  2 Sep 2026 08:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PRffGnLYrbZ1; Wed,  2 Sep 2026 08:54:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339258;
	bh=5sTD18ozE9Q0q3fXwYN+xj+PKp8QVl8CVhcWWwOhkjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+SF1U2GjYRu7Aahwb+GfK3UhpwXsXmSXE7wSNzuHd5ZCWoFuM8FnwBO4a5CMeu8N
	 GbQXJYxh9DpMA+145JRP9ZfwCvgc5yEIDO6ymBfwWyoPlN9Mz2deGdnSSNzOrfdiNF
	 3OJkxNxSSD6C49qE//bAYW8NIXgh9GCgq/okd+1evHIRH8rB1V0dye06wkQsE/Zjjs
	 dixOQwAtjWbuAwAdWghqdpUBpbt1hN2BA10MFRdy546mx/oxEO3AQe6aOopZtUEACh
	 4e/3ruP7DSN/YnWN098PU77o/rkqQ6QqccNTGt0U9mRaphZPew8etAHwL1RrR29GGx
	 McYY/fuwOF3HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A301781028;
	Wed,  2 Sep 2026 08:54:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4036C127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 311E380F4E
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xvkWn7hCnled for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:54:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=tXD98CrP
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E28081028
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+6fDn2C8XgPCI4JKJ9jsNEI6RqseeeVbkO+g06ebL1JAZwPPh2cGWqXKQDOePms1z+VZvPrCnS3VjscO36+m3CnscEArhofxaieAdyEIa8UgVC7Uz327aVEnXiujaThMN2/p6gMw3JKfu2ylpJJper7PzIXfYdkmnaeZEp+z7YhKz2uw5k7I49IKP5pXxI3vaI0iwtNptqZMgPWAs4cPtMJ6DdgVfl0ajqLkvH5FXfr9TmK4l5vTOWucwdNRxQxoCHmu+OlU61A7aXHPo5WvWIU31GMm49G9eE2KTMubIALAokjEz8whlz05BciU9/9eGi7yo/YU/QRu2DVlCoR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sTD18ozE9Q0q3fXwYN+xj+PKp8QVl8CVhcWWwOhkjI=;
 b=RCrEedoVop6M7elERPfJcolX+tNqdUjTMV3OIMtG2NoSPhG9+30yIE+OA57MiN64WjTXWfyQb3QGTfTUQdwDlDA6Ix4UMzbz3Fcl+cI383bWP0oMaldSKoQxq2xcJf5hvMUZrBs39SFkWys/lwlA6VA6MOFkyFKMeIaUE1e2RSo3nPqIjFjQVhFJtVxO9WO9yJp9yHcYldg8hrU4I2AqZaTZ+wLz13/FQGjaCPex7G1EsK9KUVckNJboSefaVZSidTluCk/hjCsS74H2hSHYYGdjsIULrTExufqTiuP9SkLCydOz8I4+Y+jTgVGFm0BIi6Iui7IYHxg6ZIb/RC1Q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sTD18ozE9Q0q3fXwYN+xj+PKp8QVl8CVhcWWwOhkjI=;
 b=tXD98CrPKuTC7N6nRSArCcCRB0nyQdhu20hNQhQg5E49oKQv6rSPAQuFsg/3Av0wJJtT8j0aKGRc/dM4Fn4HM61C/c7mh/dNK0M2XIGkcT2qDGyBWINT2KwdnHvElfCH0aAKhmk1InFK+qVADmaGNOYW5iQVOr31D5NOwwljCVHEyBQiBpfC85Ceal/2RgW25yAOL3bWxG3RAWEVVayK8CAa3kn+DNnRQFOxniM3hm2jsfefgEeIbXGq8d/5YTvf5O5LZsEmJuUAmjeE5aTX9zHggrF1uzCM0BmMJtcEtNZbiSEpJrVGv6hvkO3yTepRobxIDHvFeeUUnGHAoSw36g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB10692.eurprd08.prod.outlook.com (2603:10a6:150:160::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:54:05 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:54:05 +0000
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
Subject: [PATCH v2 16/16] an7583: enable MDIO_AIROHA by default
Date: Wed,  2 Sep 2026 11:53:11 +0300
Message-ID: <20260902085311.1550804-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB10692:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc11ab4-d84d-422e-acd7-08df08cfbe06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|52116014|366016|921020|38350700014|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: rn3bR8b/1BzdnMP9Y/2fQrhrDSCHt5hv+6Z5AVLouQZMUQA2xrSvbL3SyBcEPc+uLltYeoAcUOmy98XaTzbpsS1wTS+XnQh35H2m2Wk7Bz2nmfNUfv6kn0MOFmMmec/xF6KL+1hY7WdODNhTL5mkED1Sx95yaAjy3WhL+Ee4z2cBezm4ElVXJrzb10Ze28A22N+apOALFkAlkZDIazagbdx/hMT/lIbAg7IoV/TUVE7sJjJTWR/AInInq6PMHXy4r7NI2rmGaUsvROtnWhCnB7LmFGvuhxOnfn0WQw5y/ewwFq2xz+Tpn1UE3YvRKajx6NxyJaD8z6mPMB/x/2LCpu6w08DN9euM5JBm0ttHbNsJmyMK4+8dq5JTNbhHFXGa3W9La7gXMUn0O4u5SehlqMB5rMnLqr+VCeaYmuakyxG5KhD6VyMRTGKBRhHbd53tn8d8g/zRWZQJmS71TbRLuPjOaKGwjoHjCJv7hwb/D4NMT+sMQi/XoO9txZUirA1cwKuqVcTuI8yup2JkBS+7O0ymwEWk1Yc8VC95sLmNrLG6LoebH8FFv63DCYFhnzHGPgWvLtgNaE6qZ51NJlAZiQvTs2ULk6KT86HJxk7DVVvskPv8cMPMWPDzqyJlKIv5CoLLYY8crBEh7W0jptGjnBkLWr9puzLh7Gomb3RElN7bAjxVwfGuRugFyUKnFPzTDyMhK05CXduYyyL7NWBSuF89pRFukUbUKviet1FtiVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(52116014)(366016)(921020)(38350700014)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ci1DzkQ/Aw5t4iVnDbmaTA5QddmXmdGlvjnW3/D1krvF6+UYz+92qk0w5gD2?=
 =?us-ascii?Q?2yd/Gp1DWHN6wwzWBWILb+KdlcsEB8krh0FuKkyhx2eC+e+BMPE5gqhiYiiV?=
 =?us-ascii?Q?dsYq5Zm8M0eb2C2ovIMOZA/j1GIaHucmeVZF6OZUO4gDPCJ8UjIy1WzBrISv?=
 =?us-ascii?Q?51LJrPOYvr+s0VZqDLvV+nLirO6YCOraSt76c30pB51lBOk/1l1W85YYZXBh?=
 =?us-ascii?Q?pqaAmJg9h0Hica8Tr6RiMuvAs6snSphbaMc1sDwVToxoEB6wcj5Bq7DuZcJ1?=
 =?us-ascii?Q?JBlCL7p8qlBglBs13Do3IPmZHS+hYkFwneZgUXt60SiL/G2BcNxqGOmLGjzp?=
 =?us-ascii?Q?W3bHN/OKRlddHAiHWb9vci+r6sn9x87fO7i8/g8tWyL4USh0vKtxYtZABM6q?=
 =?us-ascii?Q?CpcmJpFGy2RW2KY0Og/lhpWMT0565afdfeItLb1WdDe2egptavbx9FoC4Fw4?=
 =?us-ascii?Q?VMo89hqFqVKlEW0deuo1GxsLn5CHTpd3F/I7KrnRdGJ+t5hl3KgR0zpkW7EM?=
 =?us-ascii?Q?5ibNDzHPIm8CYhYCQZ/lYhf5KAC2eN6g9l93yvDdGMoDxoYeH32xPQXahVof?=
 =?us-ascii?Q?WPekJDabey75N6LIGcZ9XoWs2PZ7TMC3clJKt28/HWSGqJRYZFUWhkADoL7N?=
 =?us-ascii?Q?E0ASsvAtkoPCTuAWKkX9FV9iFWzfBIbUz8s85fAxV1hyHoHHGJayzBTYTmJg?=
 =?us-ascii?Q?w9sX6YOk5/71e4BUfhswC6y+NqBePSA2TwI0DWFvtCe3J2bCIMYnaCYdFcQC?=
 =?us-ascii?Q?OhZdN6tWSy/SLFnCTPDHIXdjNNwWWwq52YHOV9z9ZqNY4mhpHwT6mTg6BIaq?=
 =?us-ascii?Q?Iku+le+E75o6T4aG2vvGEIjXop4q+w3aGLymnAf4Pqgnu1BspNQ0HpLoi6pb?=
 =?us-ascii?Q?a0OEwdc8jv/SfnhQD4+amVSIBXv7PHeZJXjPUowDoNrDrTnHQzWHGqDBlSkm?=
 =?us-ascii?Q?ZpusD5SSnI6vQ4Ivm/whXw/crFsZyz1TxhuHcJHvv+Kno/i+tYvuKWjhxeQS?=
 =?us-ascii?Q?zb+vURHueS9yxo3fP0pMr1VQwN+sZF1Saz7tRpzih9PL79LnlKq7c8aXLAzS?=
 =?us-ascii?Q?/QghdvhdbZEukYBusKAkpjoAcKNKST/caQC2UIs2PzLDWK+XvJRb6dmGxXyJ?=
 =?us-ascii?Q?kYUp1lOM4bgeVSrbe07dF7OL63mHU+WPoReOEq4XlUYkwl4e3ckZwytkxYMm?=
 =?us-ascii?Q?07FBdGlUlzE+IudYnfyP5kT2X0D6wv7LcZR/PIg4Xlehp7h6uBnlUCVHr7Sl?=
 =?us-ascii?Q?atwVWGMEvF4k7mFB9bxKcZM+V/P2roU9SkH97vxExPsMGm8W2biPmGnqHoCX?=
 =?us-ascii?Q?+EHgG1yjwi80s73zw/xIvUqwChUXwDxrWzIZi59WUBATIc7PB54SiwYlcnUh?=
 =?us-ascii?Q?mbhUzA3h3rvnYmvLuExNoHhKyuqRPI5dByxCbS+EgcK/a3XqWg2mUb5RsKbL?=
 =?us-ascii?Q?fROkfJLDIIGwwgINgAVYLTVq14a5E6rkxGB65q6b2Mt4i2Lh0rWcqb5T6LDH?=
 =?us-ascii?Q?/pHFf/BUa0W21kGK8RBoEjX3bGITTtg79o9wbYj4V4sl3UXY9afKVjxwXldv?=
 =?us-ascii?Q?XAxgTg/IZtUtGcZMzbwj1gVgwi4RdLyZCeDY96gs4q6aCpK76Kk8hHYPu9yu?=
 =?us-ascii?Q?H7qxV1OIgr+3zwlbMufzzRDxPno0e45jSkhqx1WORY4CN8cIt5YRwaQVNeQ5?=
 =?us-ascii?Q?gAPPhD6o9RrELVCwSlPNFEav8jrVno7LE/7z1qII4fyZapaOtadnGJgXUjCE?=
 =?us-ascii?Q?ohNym8mQmG+p2qHGaxMWcA4liIsvvPY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc11ab4-d84d-422e-acd7-08df08cfbe06
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:54:05.1509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fLnxB/iuJkrV+u6/ITAoAbQIskufQYAd61ZJFiwIy9oawTab3b12boRTEfw/S+ddlC1MuhATZNJrPivcCG4qdM3psrtN7oQ+pzTWKb73sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10692
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

Enable MDIO_AIROHA in the default config.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7583_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 8b076c1cfe5..08bcbd52c99 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -65,6 +65,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
+CONFIG_MDIO_AIROHA=y
 CONFIG_PCS_AIROHA_AN7583=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
-- 
2.53.0

