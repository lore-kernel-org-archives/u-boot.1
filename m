Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B05C44500
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 19:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EAC83FEE;
	Sat,  4 Jul 2026 21:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EpZK/ofU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC8584119; Sat,  4 Jul 2026 21:40:27 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94EB8341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 21:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWHFm7hzlat/x5J1Y8HykKvyiM9iOjekaLXYFX29e0QJt/FaUxmuxvkzkIlgK2xiH7P4d4igH7jkNBPdYSn60bFCIXRAI5cD3dtZxNXV1bwNtdITGXwYZikepLAvWZfFVWUu8gzYXM8gP56qAJtg8M0tt2YMYSzAUcclH7CbqBd+fzTWChepRjEzuUoeqZbmPdsjr1VGLlU4AMRgez8azSz8XfAImYYen70DJD/CJetr0tklyNaVIxHmhtJ8KPFdBwfuo2zD+R585rF+mb8tCnYsRm/ToRgZDkNCLZOjcpMS+vyMZHRZwcKtbLt4A0l6u5ALQmOFdzk8QrkA4JiDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lDB4juUTcvXZYWpCQkhFknb0AEJMNj8bnbzCHuxQI0=;
 b=cQT62t1x5W+9JFosmMqRpFQQKtpTiuwgPymv2yTIqEJqMeR5rUlSoMF5TqDvGVk0VXTdcHjF0jvxoMRxvKVkPWAXmZji/fCajv+u5Lu7+hPTCFZhQ3ZpoaRFrCJI/P9b79FegGmLaAZM1rq6RQAdY6PwoQ80K7xCYv0rmFOx8W81al7LkxS9KYvHCwT/X1ZjvNlAW3bq3JNyqnHcapxBeLM53g9qP4JunU+dnJJhoS6+e1dG+pcfi7UfYBE/nWOCXexR96wANEYH/E/oCC4gfv6aW/ZyhYYF6BU67s2cx74Gdif0aOILRLvqs5ylvY9JiSuS0BXQ7k9g+q5C8xkakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lDB4juUTcvXZYWpCQkhFknb0AEJMNj8bnbzCHuxQI0=;
 b=EpZK/ofU/kv3zGczpkNj+KJuYi8wqB80Q9f1YxsPj9cXWntY4AZA/gKIESsm6Ylcrj9W3Lx3o6FZXVc/GI3A+SfrzzBr9bGDPI8r85xyHZ0ORlLYGE1gK47OmxKWlh6VoRJkyF/w5VuxjDm4gJrYb0J2X+KSmf8Xjtv8PTAkfH4KZuMEVEdy4Nmsmg7igzhDBKj0kirQoIGhTvPOCtqttd67tafAMFHIHZyItxrhVZ79oTzTPEOQ2rV+0fSNZ3V7Xxa8mEkhnWG2BhR/RzSoQUCfjLllzLLJdBoGxjBSIMXG/trSemNcH8WcnEFOQynbhEAzsUG1XK8vkrisXpmSrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5443.namprd03.prod.outlook.com (2603:10b6:208:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Sat, 4 Jul
 2026 19:40:17 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.011; Sat, 4 Jul 2026
 19:40:17 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH] MAINTAINERS: add entry for SDHCI Cadence driver
Date: Sat,  4 Jul 2026 12:39:26 -0700
Message-ID: <20260704193926.19245-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BLAPR03MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff151f7-f467-45e5-f7cc-08deda04131f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i6JV3d8vKvYCqVPf53LQaPYTrPbijvb3RH0nmipFL3y6EZq7xuh8E/qdlrwgO3WVCPwXG/Iikomzf8cfx2Ye8ekE56T89Ebrf5YS5XXb9LM3///nnteHXRZrU4wi3v0pvo9FRDnjKJBYZXs9WyfbyK1rIvtqVwUoe5MroQCJvoUb0ouJ/Iq8rvPYYrVr3KV4Ik/Zr5Bmh5zeSYQXgBSlFceEriX4ZcJHSiOlNW9AXEz4576lXBRRfY6Gj9m6HYb6+FsHEF0rE3ZQXNJtnBkSa/QvzGKRIvoqRSuqlrQgq7Noi4+zKsjk4qj9B/8OjWCllwjQY0HUueTnPMIBj7MXb8fz/uJVT+Bk9+zKrOAoBxTxrfMsSKi0Zs2lkOJMRfzhIteSDzKU4dJak8NW6AjbT33wj9xqK2NgnmA0ajElSnd8Q1/gD6BOcr2kWwtqGO078SiNBYMtITP/XxXE7JUjFin2Nx64rSJ8B17PJ7f0Vt5R1df/C+N6NrkhfRHRV/t6wmgkoFf3ZYm+4DxQVUNXa3Pbakd8trdenfwwJuiVXH80rQagwODhNjq8qGJPraxsmgt3VmHYwfy/xEE1c0xFxhWsTFiTJt6YtCtH+m3jyhrnfZtKg/plWxR0LBI4tJ52hnFkj6telPwo1isHLLmKQ5Ql2eFHeQbtQjqs/XQfNYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOO/+nuFhnazPvNoiqbDicUGScMolyIhDu+v0GMabOwStsR4qWe5g0UBNT5e?=
 =?us-ascii?Q?g0viLIp/rLuddg1dj9Y711ANz0Py/SaTRCxY6qUoohTTseU0S6Mk561T1DnL?=
 =?us-ascii?Q?tIQpNNQhFxGT5iKev9xcs1qP4jgeQeS+20TPHGwvU/f32dZRKIJycF/J10cv?=
 =?us-ascii?Q?i2D7OhYpXbjglOSaPyewfPzd3bansfeHLq+858JUdj2cAGS6oIfeVMNJCo7F?=
 =?us-ascii?Q?77Jf1EMqbwkwWbJgh/UeXapfpkRLsUymRzOGINfsZN8u1DOiyLbbE+1wFs9F?=
 =?us-ascii?Q?0BOW8NowwirPSO0OjdnmjhPxpz5saV2VJqDBM/Gh5ALgTiW4N11HrXLCM4I3?=
 =?us-ascii?Q?qdvu/rkk9InPAZzB0zWz4MUPaJKzkeACsSS4XK6qCleVxEimNuivO9A16bR2?=
 =?us-ascii?Q?+73YYGyJw/YhphE011kDr2tfrc52UCX+UKibwX8sSpKYYSsKBgUshKNWqghl?=
 =?us-ascii?Q?MQbfLZ1jQ9RhZTyyrR5AaN89VmKuEmBLRkPTlJqqZRVyv506y66cLCQw37rI?=
 =?us-ascii?Q?a1F+zAnQrtXt/+p5auUjwx/d6kgg82bHri6/sJ0KWN2NtYaqeQYzhW06YhyU?=
 =?us-ascii?Q?ZTzXU4We207kdI8iQ27Y+RH2VMCyn3OFKnu1cmOhmdRCs/E/uHF/PHTmiTES?=
 =?us-ascii?Q?frRDzP2Sl2xhAK6OjkYhP/uZrDr8pGsJkIOVLo9lq4dz0MduK09x4rxEVfNb?=
 =?us-ascii?Q?MRuadZpQ4W5Burd7WSOddD7382Gx6GpgH43U3YbQF9inwakZCDu0ELG/JKK+?=
 =?us-ascii?Q?gPdL9/j5en4sZbz9lB01Ad0Z24xXLhQvAIYgrk/1w6nvEZFP6hLIzsr7i/zs?=
 =?us-ascii?Q?V5v4aJHj9YD1IKmgT76aKxpzS8dDAPH04TMQhaciA/7JEeo0ITTBWfntDxLz?=
 =?us-ascii?Q?JEIhynDV+1xpo0zIMgAR1L8IjBlJZsR1jy9IRp4PNqPfpE9z77Yo2RLoxBlq?=
 =?us-ascii?Q?epb0duKhQNYaLGRJSld34yM8SbWg4P7Q4JtSrctpNfjCTQm/x0kWHqncPnGX?=
 =?us-ascii?Q?NqQuF9ZDcpURbfsmkl5RX4KRaEPnJvzBMT3YisZqD836K0k1muGmJgu/tiRr?=
 =?us-ascii?Q?WZz7NlZw/fuLZtjNHSeR1Y84s1oNoiKYhoN0E4q1bMBovzNt2Y0DoB0WOweX?=
 =?us-ascii?Q?iBo80Qzale3w3h/PWVjJjOwbPKAd1miM7cCDvP12yaUoLea+wt2M6nUlmcny?=
 =?us-ascii?Q?21pscr3UEiuvbTUlhD2Ijt9T1L68xPZvcTpK/KHZF7H0bQseoda6yOYXN3Wy?=
 =?us-ascii?Q?HB4rHn4B4CCnjw3x+R6kxuLwHU64dNQVEiZ1/trfXSyveXp8crhIHItdGKpX?=
 =?us-ascii?Q?v5A5tRqKgiwnssk6BNjzFNGOzsmDsIuBU3muj1SvUQ2iOYLqVQ6Csqk0w+A6?=
 =?us-ascii?Q?KqIal1gOYLh3DzQEU521QR3JDBchAkngdUiWNw7kzFyRITR9qEFLnDZ8OO3z?=
 =?us-ascii?Q?uqLXaIxBBK8lEqLQnw6lUXBECM4jHbv3UEAvdtuHHYcc69fpmQUG7OLYkIug?=
 =?us-ascii?Q?YV/gKUQBFGOz6PjbvSL5DGY1/bEFyL2Xumw7j8pHmvuhm2UpLTMEEJSCClai?=
 =?us-ascii?Q?TAVDqwn8pM1omN6e9eagWJFI/EC9LzOsEIGem3mPVWxQS3dLp45AF7mFyuZ5?=
 =?us-ascii?Q?FuPuAF4KO4U+nsHn9+Q8RvoQHX3oCcyqlMFSAZUZDEP522HKTkDISJ5lmshs?=
 =?us-ascii?Q?kJ37vhWUKtQbSr+gPpn9DLZrz/+9evNmO/+8oJqf9HQYwsgY3ppVQSg4k4b4?=
 =?us-ascii?Q?f8Vsq9zshZ0RO9slkuxJdZX6QrUyqlc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff151f7-f467-45e5-f7cc-08deda04131f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2026 19:40:17.0999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqMOFhMenHE8o67tuYsnt9TbPT48tP0F9/DXkTsuPMHZqww4/UHbUVuFtFmQ/O7oHDtPFvgyxTk0BTH4G6P9OIIUv76GREXinrFH5CYMogU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5443
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

Add a MAINTAINERS entry for the Cadence SDHCI driver files
(drivers/mmc/sdhci-cadence*). The original authors
(Masahiro Yamada <yamada.masahiro@socionext.com> and
Kuan Lim Lee <kuanlim.lee@starfivetech.com>) email addresses are no
longer reachable. Add myself as maintainer since I am actively
maintaining and developing these files.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..cc31934ece5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1707,6 +1707,11 @@ F:	drivers/firmware/scmi/
 F:	include/scmi*
 N:	scmi
 
+SDHCI CADENCE
+M:	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+S:	Maintained
+F:	drivers/mmc/sdhci-cadence*
+
 SEAMA
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
-- 
2.43.7

