Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848ADC61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 358CD60645;
	Wed,  2 Sep 2026 08:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ya93v526_ZIN; Wed,  2 Sep 2026 08:53:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339220;
	bh=iKaxJaH0JdTFfS4wmSsaLDPQny1CKioxlCzy7xQRibE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FZQBdrdTT3hmk1zayAJVzDz8aswoTAn4nLrjXT+OIzmAnnbrZKp/EW2h0Cys0eA6X
	 XZGrIou82kkTb6b5yxAhffVI+tuyVoKf3uXC0bxOy2HUWxtirse3B26O2OePsKQfDN
	 op7E5a11YPKNzHFr/qQCJNsix3P3+Ut6PVjhKfiQsWq0/nXDki4wcDrxFx0FwKg6dL
	 WNX6LYmCeD0B0B5i2SB43ribezT+5Q+Kt79lG2uzrzZGP74Q+dStyVmq+sitH4URCx
	 A0GUvBjXF3HfosOmNuZCHmoFptw4HZf2lxKvSDAD9dqKIUAleZF5E6l1p2Xm1E9658
	 68FNL89SGJvlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4143606C4;
	Wed,  2 Sep 2026 08:53:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C7046498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8FCE4031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QDA_wCShkRDH for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=fWOxi8Cc
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D23C240310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD1jswNoSWc+8wdNgBccqkpXzb19mPFaInIDjHVVh810Rd8TSsf7nN3UGX4RZHnO3pJ5QM6nXyFaOH7b1HgPeffoTdQSUuESlaH4L4wuJ0khppC5qv0a85Y6qscrMdiObCRpY7msHxnpk4r23NKsiAtnOAzBLZXTbGMDaYaH/xADdwiOzsWcUsEnx0iOZ+ReBEFX3gMTJ4xcSEoXdQwSmPIgGpydxIVy8og15Rz1LiYQnsWRdnm9Vx8BRMfp+eZhY7lr5RMGBwJs4DwoSCmzxsxQpHG+hXo9rU9T+M2W0n7kpzGXXlxOGGWshPDVmYhx4l4pvh+T/oNvML2DzYff1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKaxJaH0JdTFfS4wmSsaLDPQny1CKioxlCzy7xQRibE=;
 b=Rd84xyY1w+QMOVyuxS0uFHR9msK5Il5TuQgbOLRJqESDgm3jbVXSZBIMAxbgTvGQLjMeIRhziOBErS+eo8rz0mbu1wclEqWprrP/kXnDgd0QtzhZHyEiVFHeTGWofA2/JhhMK5tr3E37T8NnjkAg7qA2ntFVp0bWDKHa8J9LiAIx1FUoexSikpxVWgF4LPYCRMQ/uG3m1sbeHFZfILGtVHiPiyonx/Qp7TBBJ8UUoxZnc+XWD0uklRNfBBpR2lEl6L+YFCi1+jRdBYqR4avLbW2hEYQcJc10f5FtyWin1uIXnk92ZyJNgO9zd038SJJKaDXyGFwdG1hQjFN3z6ZMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKaxJaH0JdTFfS4wmSsaLDPQny1CKioxlCzy7xQRibE=;
 b=fWOxi8CcAyM5DgoN8JQuUCFYhATpkAgkY0/D4kB9LRshVZgPulm1RTEN1pa0BlrDkWUVK8j0mKCiyLfawsqokvWginr4SaNFf4rg94src+Hwx0unFLJKLrRKmW7dF1r3BoCwDRTh2tGPaYMXSMOeAN0lc6Gi3eNXEDXG3UbKXebxiibMwXTVmI8+tUa4vJrdgwiUginnEoUaXuoxSHfG+oQ+qft2yo5T9k8+RQsupHTtotvee/95ozCEn/dvmHFdNsB7bq08kQuZ0CiQlHvd9I1CJQZR0vRiZ/on7vR2buKlgZb9mN9G8vL4Dw/L2A4QjjPNrCgPBVo+W6HpIvjacg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:24 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:24 +0000
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
Subject: [PATCH v2 01/16] airoha: add support for Airoha AN7583 SoC
Date: Wed,  2 Sep 2026 11:52:56 +0300
Message-ID: <20260902085311.1550804-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0cf3b254-e4bd-402d-31a6-08df08cfa59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|3023799007|921020|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VxW8LdCBVKAOoOBWNWvlVUjbo0Iy5CCPRR+EIKJuYfmNghTOTC2hoaMXj6CMc9k5TNE/Nj/TQBXTBc6m8LkfHdOu6sWOqB3Em8Poeu4M84zi1mdVUtdnYoePT2FA2JoHzNlyk96j40q5uDUAsTgbVWmH0eBfJRbOpDPiCGrDW/H6Bh8IdeT+oiCduq2/gfTURxUW6ahBh49lmWlElgAchk3McbShPXItf0khYImGjnKChpi5hNNHqzvh8PEbb0+c75QZKcgw7Pi5CunU0EPVXjvpTxeFxZbiCS/wF9gmbs4zp0In1zbgXZpa+G/42hmhGVlYY1euAGfLM3Nbbit1sAJxBP6tpAfTvToD5huqb1+yAYlPn4YAs0EopP1UadSu1jeakx1zzNK+i4wnSkUF9E6jc9Eultn4Z5gmROog6W5RDWnG1Nc6sUhV1ZFipKZ0sUtH/5Q1+0+sJEDbcMTpsiRtCz9bXfCcRkx7RQPslR/jWP7/sg8Rg6MkcEcVkV9I+QeePHqDfe3VghblvbXdNdhkjEEf1+rZ/WxkinGzmhwNHNOG/9XD16ANpyj5I7SEMAzPOoMctbARdmJ4um6JctUNi0wxMAcnQ6dEAwegJ0IhhIlTcmeEkjUZ2J2/LtZRQ/Z9konxJq5yV/6zfFyfImh7YiiF9p0xA6nfnl1/dBEboxpA1zHGwkAPmJzIiebKVh0eettxbwULd4s7VrmjD3zWFtulX7oLgpprDOJmCwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(921020)(6133799003)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+CaBwmoSohR8gEzOBnRB9MTQTcSQeFfZHquIJKhpZPzc4tOi95OGhgW+ooyO?=
 =?us-ascii?Q?wgg8JfzlzoDMT3zjnYMwz5q4ZjMaslif48UCXuxv5RVAGPnd9oibpx+UixUh?=
 =?us-ascii?Q?DkRhG3hkZJqx39mbh4shqOSv6lZ2Q2x6xc7fvdyPhKd1Hv6OK/DR8950I5rw?=
 =?us-ascii?Q?WQCivru4yI2Wsv8m2r3zFO9WRBWG4nzdBiWtw/CeGVdaDdvBc0Dj2J8lwhq0?=
 =?us-ascii?Q?BAbIFUs/vpMxos5hEFddVq53jLrk9iqcfPzo2ms8gT4CwXhP9eY81HmPcU5i?=
 =?us-ascii?Q?sSdjXBBT9vMekD3+mUjHqrEf8Y98f2UYe+5dO0NUJe5RFvBOEY3pKxY2Y3bT?=
 =?us-ascii?Q?fwnVKBxM0fSJp7A/CDdwZepyluMZ/0sEbvglf+jdPFSmmTb21puxqc0BZY3k?=
 =?us-ascii?Q?dh8mruvbwTBEAxfp3eyKZzK5PYNYSz59UyQ0fqX0+JbBcQVyIMd9uz4I9a3c?=
 =?us-ascii?Q?pRYU4a4hgRlzUV3YgCGUZdP8G8WihxWpXY5hsg/XDOowSPufUNKohyXPJhT+?=
 =?us-ascii?Q?fdIfcunN83aFeJmdW1Onpx/Po5Dlp6rOrR+xV4cQve3XUxIZufTWIdF1E43P?=
 =?us-ascii?Q?ZxblCYVRfIFh+fp8vc5O5l1WMNsNCtl5vWzPXepJhv+pnGS5KokeVb7pUD61?=
 =?us-ascii?Q?3w+H9ehI+RIIoAjEyNJMQzh3kMVG/jUZPe2o3aDpzzgdLxo2f7sH+l72zwNt?=
 =?us-ascii?Q?y3U0lYS4Z6wPhet17IbULIuGVUxh+u4K55v96vxyIrIoTBYb/edh02J+ZIUH?=
 =?us-ascii?Q?x/jY18s9g2LYoTTiV6bmL2TeqyrLA/+IN4CFAazDiv8o6u/INtgbxmO2MWbZ?=
 =?us-ascii?Q?z/PF3n4YSRJJDrs3WMuniR5MUE2SDVkmK4gcHXYh8WzIJh9b1/tdbRTYBbnT?=
 =?us-ascii?Q?LTyggem3u2dWd4NxtVIzqvPqBITL5P1j9C2XHyliEeQ9zeDTVTUcLmbrPH1f?=
 =?us-ascii?Q?WarwwsFmg39p2VX4IhYjfMXxB3adgjQCJ3ZDkYyg00GBFqg+pNdmJBnI8czM?=
 =?us-ascii?Q?tJL2zbetQ04W1Ci8wYiGoEPxTNBGb+R2QkIcbd5umOyARz82Lp95VvX+hQ6j?=
 =?us-ascii?Q?yXaPARyRiAu1cqdV3CDrg7U0YNQ7P4Bk8GOrZ1WlEMeQ87HfLYjvJyRl6mCa?=
 =?us-ascii?Q?7aveoD+dZe3yR3sLwBLOWL0+S7Z5tG8cJeM/At5xjEUOTNTcDOX2Te6YLSpr?=
 =?us-ascii?Q?W2Sq69DbdVDejKQSDqLny1QKTIow9O4hJ3/cT6kerboe+thUV5da1CHfjqZd?=
 =?us-ascii?Q?3v5ch8/nQUGMVKqjqBSApbkQHvVk1Z3h+DKqWNqpDipVnyZfhFU7O1dgSZa8?=
 =?us-ascii?Q?CYFFTB21DVYsJ2xWn9A0xflNTZTmKWFD2Im/oz5/UqWczoTB09EaLsYLPXN+?=
 =?us-ascii?Q?9TKdkcHDE+dSko6NVyeXGFtuUmqgb/MuxZ/PwFPX7+HWyq0T0emLDEhhXOlD?=
 =?us-ascii?Q?JulWmOvqy2iBh6rB8/PLrOgkFGvjhSUztMzFN8ph2ZpjPXYi/1tQu7bP99sz?=
 =?us-ascii?Q?B4dg4QJ268Q9s51rQR8rtWCC9ofixGsUoDpH7wmvr8SogNhM8lEjOeghViK7?=
 =?us-ascii?Q?r9UI5VoRzfyMslgrJcmpqTUUJXjxCkqN+reTQu6yvkT8ZJb74HZ5wkE71aFw?=
 =?us-ascii?Q?iB9K3jSSPqkKgfTnK4HElSvwCQxWWZnsNPs0EAUxozp67lC7pegZy3Yb5Mq1?=
 =?us-ascii?Q?1r12/0MYaJMPDhS93+4C43SOkBKznJkYmgqi+ckXj6wdAfDBszjmPCVpmy2a?=
 =?us-ascii?Q?qK9FpLjpNxuVj7O03ecVwSyX9hCCTbc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf3b254-e4bd-402d-31a6-08df08cfa59e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:24.3175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4pXHr5CyzAXLI/6mUhB0QSq9MGKHjKlnSmahNEXuVx2PZrBsb7dYA3/fIq66FYP3edWjQV584aQz6FN6RQ0tYcpwuSPozyqMvh9krBpzVs=
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

Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
entry for the SoC, DTSI and initial config for it. Also add the code for
CPU and RAM initialization. Everything is mostly based on AN7581 that
share lots of common piece.

Acked-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583-evb.dts          |  67 +++++
 arch/arm/dts/an7583.dtsi             | 387 +++++++++++++++++++++++++++
 arch/arm/mach-airoha/Kconfig         |  14 +
 arch/arm/mach-airoha/Makefile        |   1 +
 arch/arm/mach-airoha/an7583/Makefile |   3 +
 arch/arm/mach-airoha/an7583/init.c   |  66 +++++
 board/airoha/an7583/MAINTAINERS      |   5 +
 board/airoha/an7583/Makefile         |   3 +
 board/airoha/an7583/an7583_rfb.c     |  16 ++
 configs/an7583_evb_defconfig         |  79 ++++++
 include/configs/an7583.h             |  19 ++
 11 files changed, 660 insertions(+)
 create mode 100644 arch/arm/dts/an7583-evb.dts
 create mode 100644 arch/arm/dts/an7583.dtsi
 create mode 100644 arch/arm/mach-airoha/an7583/Makefile
 create mode 100644 arch/arm/mach-airoha/an7583/init.c
 create mode 100644 board/airoha/an7583/MAINTAINERS
 create mode 100644 board/airoha/an7583/Makefile
 create mode 100644 board/airoha/an7583/an7583_rfb.c
 create mode 100644 configs/an7583_evb_defconfig
 create mode 100644 include/configs/an7583.h

diff --git a/arch/arm/dts/an7583-evb.dts b/arch/arm/dts/an7583-evb.dts
new file mode 100644
index 00000000000..d02cd194e8a
--- /dev/null
+++ b/arch/arm/dts/an7583-evb.dts
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+/* Bootloader installs ATF here */
+/memreserve/ 0x80000000 0x200000;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "an7583.dtsi"
+
+/ {
+	model = "Airoha AN7583 Evaluation Board";
+	compatible = "airoha,an7583-evb", "airoha,an7583", "airoha,en7583";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+		stdout-path = "serial0:115200n8";
+		linux,usable-memory-range = <0x0 0x80200000 0x0 0x1fe00000>;
+	};
+
+	/* When running as a first-stage bootloader this isn't filled in automatically */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};
+
+&an7583_pinctrl {
+	pcie0_rst_pins: pcie0-rst-pins {
+		conf {
+			pins = "pcie_reset0";
+			drive-open-drain = <1>;
+		};
+	};
+
+	pcie1_rst_pins: pcie1-rst-pins {
+		conf {
+			pins = "pcie_reset1";
+			drive-open-drain = <1>;
+		};
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_rst_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_rst_pins>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&snfi {
+	status = "okay";
+};
diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
new file mode 100644
index 00000000000..9362d2fbedf
--- /dev/null
+++ b/arch/arm/dts/an7583.dtsi
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,an7583-reset.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf-reserved-memory@80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x40000>;
+		};
+
+		npu-binary@84000000 {
+			no-map;
+			reg = <0x0 0x84000000 0x0 0xa00000>;
+		};
+
+		npu-flag@84b0000 {
+			no-map;
+			reg = <0x0 0x84b00000 0x0 0x100000>;
+		};
+
+		npu-pkt@85000000 {
+			no-map;
+			reg = <0x0 0x85000000 0x0 0x1a00000>;
+		};
+
+		npu-phyaddr@86b00000 {
+			no-map;
+			reg = <0x0 0x86b00000 0x0 0x100000>;
+		};
+
+		npu-rxdesc@86d00000 {
+			no-map;
+			reg = <0x0 0x86d00000 0x0 0x100000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+			#cooling-cells = <2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-size = <0x80000>;
+			cache-line-size = <64>;
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@9000000 {
+			compatible = "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x09000000 0x0 0x20000>,
+			      <0x0 0x09080000 0x0 0x80000>,
+			      <0x0 0x09400000 0x0 0x2000>,
+			      <0x0 0x09500000 0x0 0x2000>,
+			      <0x0 0x09600000 0x0 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		chip_scu: syscon@1fa20000 {
+			compatible = "airoha,en7581-chip-scu", "syscon";
+			reg = <0x0 0x1fa20000 0x0 0x388>;
+		};
+
+		syscon@1fbe3400 {
+			compatible = "airoha,en7581-pbus-csr", "syscon";
+			reg = <0x0 0x1fbe3400 0x0 0xff>;
+		};
+
+		system-controller@1fb00000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x1fb00000 0x0 0x970>;
+
+			scuclk: scuclk {
+				compatible = "airoha,an7583-scu";
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
+			mdio_0: mdio-0 {
+				compatible = "airoha,an7583-mdio";
+				resets = <&scuclk AN7583_MDIO0>;
+
+				airoha,bus-id = <0>;
+			};
+
+			mdio_1: mdio-1 {
+				compatible = "airoha,an7583-mdio";
+				resets = <&scuclk AN7583_MDIO1>;
+
+				airoha,bus-id = <1>;
+			};
+		};
+
+		system-controller@1fbf0200 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x1fbf0200 0x0 0xc0>;
+
+			an7583_pinctrl: pinctrl {
+				compatible = "airoha,an7583-pinctrl";
+
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
+
+		i2cclock: i2cclock@0 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+
+			/* 20 MHz */
+			clock-frequency = <20000000>;
+		};
+
+		i2c0: i2c0@1fbf8000 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8000 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		i2c1: i2c1@1fbf8100 {
+			compatible = "mediatek,mt7621-i2c";
+			reg = <0x0 0x1fbf8100 0x0 0x100>;
+
+			clocks = <&i2cclock>;
+
+			/* 100 kHz */
+			clock-frequency = <100000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disable";
+		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x600>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+
+		uart1: serial@1fbf0000 {
+			compatible = "ns16550";
+			reg = <0x0 0x1fbf0000 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <1843200>;
+			bootph-all;
+		};
+
+		uart2: serial@1fbf0300 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0300 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		hsuart3: serial@1fbe1000 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbe1000 0x0 0x40>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart4: serial@1fbf0600 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0600 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		uart5: serial@1fbf0700 {
+			compatible = "airoha,en7523-uart";
+			reg = <0x0 0x1fbf0700 0x0 0x30>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+
+			status = "disabled";
+		};
+
+		pciephy: phy@1fa5a000 {
+			compatible = "airoha,en7581-pcie-phy";
+			reg = <0x0 0x1fa5a000 0x0 0xfff>,
+			      <0x0 0x1fa5b000 0x0 0xfff>,
+			      <0x0 0x1fa5c000 0x0 0xfff>,
+			      <0x0 0x1fc10044 0x0 0x4>,
+			      <0x0 0x1fc30044 0x0 0x4>,
+			      <0x0 0x1fc15030 0x0 0x104>;
+			reg-names = "csr-2l", "pma0", "pma1",
+				    "p0-xr-dtime", "p1-xr-dtime",
+				    "rx-aeq";
+			#phy-cells = <0>;
+		};
+
+		pcie0: pcie@1fc00000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fc20000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie@1fc20000 {
+			compatible = "airoha,an7583-pcie";
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			reg = <0x0 0x1fa92000 0x0 0x1670>;
+			reg-names = "pcie-mac";
+
+			clocks = <&scuclk EN7523_CLK_PCIE>;
+			clock-names = "sys-ck";
+
+			phys = <&pciephy>;
+			phy-names = "pcie-phy";
+
+			ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+			resets = <&scuclk AN7583_PCIE0_RST>,
+				 <&scuclk AN7583_PCIE1_RST>;
+			reset-names = "phy-lane0", "phy-lane1";
+
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
index 4b0374001d0..72cd1454208 100644
--- a/arch/arm/mach-airoha/Kconfig
+++ b/arch/arm/mach-airoha/Kconfig
@@ -29,19 +29,33 @@ config TARGET_AN7581
 	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
 	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
 
+config TARGET_AN7583
+	bool "Airoha AN7583 SoC"
+	select ARM64
+	help
+	  The Airoha AN7583 is a ARM-based SoC with a quad-core Cortex-A7
+	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
+	  crypto engine, built-in Wi-Fi / Bluetooth combo chip, JPEG decoder,
+	  video interfaces supporting HDMI and MIPI, and video codec support.
+	  Peripherals include Gigabit Ethernet, switch, USB3.0 and OTG, PCIe,
+	  I2S, PCM, S/PDIF, UART, SPI, I2C, IR TX/RX, and PWM.
+
 endchoice
 
 config SYS_SOC
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_BOARD
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 config SYS_CONFIG_NAME
 	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
+	default "an7583" if TARGET_AN7583
 
 endif
 
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
index 91395b8a850..51d82ea3e21 100644
--- a/arch/arm/mach-airoha/Makefile
+++ b/arch/arm/mach-airoha/Makefile
@@ -4,3 +4,4 @@ obj-y	+= cpu.o
 
 obj-$(CONFIG_TARGET_EN7523) += en7523/
 obj-$(CONFIG_TARGET_AN7581) += an7581/
+obj-$(CONFIG_TARGET_AN7583) += an7583/
diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
new file mode 100644
index 00000000000..886ab7e4eb9
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += init.o
diff --git a/arch/arm/mach-airoha/an7583/init.c b/arch/arm/mach-airoha/an7583/init.c
new file mode 100644
index 00000000000..18c5e101367
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/init.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fdtdec.h>
+#include <init.h>
+#include <linux/sizes.h>
+#include <sysreset.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/system.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Airoha AN7583\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	gd->dram[0].start = gd->ram_base;
+	gd->dram[0].size = get_effective_memsize();
+
+	if (gd->ram_size > SZ_2G) {
+		gd->dram[1].start = gd->ram_base + SZ_2G;
+		gd->dram[1].size = gd->ram_size - SZ_2G;
+	}
+
+	return 0;
+}
+
+void reset_cpu(void)
+{
+	psci_system_reset();
+}
+
+static struct mm_region an7583_mem_map[] = {
+	{
+		/* DDR, 32-bit area */
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		/* DDR, 64-bit area */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = SZ_4G + SZ_2G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+	}
+};
+struct mm_region *mem_map = an7583_mem_map;
diff --git a/board/airoha/an7583/MAINTAINERS b/board/airoha/an7583/MAINTAINERS
new file mode 100644
index 00000000000..71ee542a8bc
--- /dev/null
+++ b/board/airoha/an7583/MAINTAINERS
@@ -0,0 +1,5 @@
+AN7581
+M:	Christian Marangi <ansuelsmth@gmail.com>
+S:	Maintained
+N:      airoha
+N:      an7583
diff --git a/board/airoha/an7583/Makefile b/board/airoha/an7583/Makefile
new file mode 100644
index 00000000000..d582684d1f7
--- /dev/null
+++ b/board/airoha/an7583/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= an7583_rfb.o
diff --git a/board/airoha/an7583/an7583_rfb.c b/board/airoha/an7583/an7583_rfb.c
new file mode 100644
index 00000000000..aa73679d929
--- /dev/null
+++ b/board/airoha/an7583/an7583_rfb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
new file mode 100644
index 00000000000..16466be51b2
--- /dev/null
+++ b/configs/an7583_evb_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_AN7583=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x7c000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="an7583-evb"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="an7583-evb"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AIROHA_AN7583=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_SHA512=y
diff --git a/include/configs/an7583.h b/include/configs/an7583.h
new file mode 100644
index 00000000000..c865afea1a2
--- /dev/null
+++ b/include/configs/an7583.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for Airoha AN7583
+ */
+
+#ifndef __AN7583_H
+#define __AN7583_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.53.0

