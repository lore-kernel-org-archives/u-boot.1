Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8969AD58B0F
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 07:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCAC88440E;
	Sun, 15 Mar 2026 08:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FpWRLgSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB6A842DF; Sun, 15 Mar 2026 08:48:15 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E6184409
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 08:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWqGGdDDReOL/IvxIQxRGi5CglrTsIG0vvrV3UWWOxOyydnjUxfbcyt6Q244EYyYfTV88RsDhtDCe227Iczg5PbULzm1IjQyHVKzmNTCbmm4qb3etaVQLePOPnMcyzyEIfNiLtDmDT3OhXlYiMQDFFxCKixD9N3JwtQySD+jsZl8gUCFrxLSmxKC5FTbSRTThxnZCkVBQzWsCH5uFOpXzm6a3+xCZ36ZfN0Ct/9P8nstFT6JOcQwhvCrQTLnyI7NNDQa7Js7KzQUel3ltNNTVonADBvEP3ObTO8r6l1tFTgq41K6l6VYC6CwgvaZtPUQRP3FLYJEAkLVTrBtHIMAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMxEKc39kn7klpcB+aoNwALB8tLIBJg8xS9rOLqYI6o=;
 b=Nexe82FhCbMAbOwF5Z8FYE59KOKbZm7Ej3deQhje3dR6ZZVGD2cegUSOF7j1mgK5Wz14F5PeJ/pUT5YEfeYvK81DETFksOTbcE9ftjOJYWMP5KY3f0aPRyryPC+VKViLLSZcZkv67g4gwhoz0+8emY8vuwCWB4ulGCjZMt2jsTy96UPLlzrMBefBBdGEijzMVBaUgMDW/bZuP/1wGRq2W/eDyT28xQUY06I5CgK7vkhwrLApWYhsjWlzuhYAshfn3/bp8gjRrzP+7B4WOP1p+KM8qSTraFfOurdoqEU3ewRXIf5AP5YXBWhkGDaG5Y7JM9MMKDj943s5erjV8UPkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMxEKc39kn7klpcB+aoNwALB8tLIBJg8xS9rOLqYI6o=;
 b=FpWRLgSwSSXJtCCyopzP8KICmtivdmE17HNfN+KGDbK1/nhZ5cXDaXiGim3TYvlm9Wf7xwVenACWjKSxzQkZiqY5Qk2HmEsV8hWWHHQBeCdDfu8AlqhtUhF99xBl8BaG4YHf3WNZiOc+E3lDki+zdku2OrtXl9P4mCPKobNuxHFfQDFsrV6/shEWaOf79Cex/M+BFMFFHO7LF64i4vXiw0AMV6vmM+I4GLKbwo+MRsEFHSvqMLWqVIXnc/yqVhCa+0gw3BrGECc2wAi5g8hPc9pCPC52WW4S0DFA5zLz6o39hTtjXBd/FFWtmCoVcCJEoSQKdLaN01ec2ATM/XrMYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8613.eurprd08.prod.outlook.com (2603:10a6:10:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Sun, 15 Mar
 2026 07:48:12 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9700.021; Sun, 15 Mar 2026
 07:48:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 3/3] net: pcs-airoha: fix allyesconfig building
Date: Sun, 15 Mar 2026 10:47:57 +0300
Message-ID: <20260315074757.3829709-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260315074757.3829709-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 48188643-e901-4ebb-63c5-08de82673478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x+zQb6KHgrCXxUwRB/jfEqzpcfxrcwnQB0BdM0oeySkSbH21pzQ59rMspMfK7xCXs/zA+1v/bVewT/o5QM1lvyFrYekF94tJ57WYzihmgqNzslw/3wZH+sLgjy1q9p91zypwqvsVo1rhWEdJr/iCza3Ac4ppIUS42N5iUOzq9ZmOiedPpzIVHixguSlS40/PSDpEp0hoZNy9Mga2abhvAzSzWWXEj8fwT8+tHQv8ZxPyYfWti3PZAOKbNgvdyX+PhddorCvErcnUz8aPQirQnobxmTXm0wsOj93jVvdgJlTHhm2vGBQyeOM2zBDhfwFBlWUT7IkN8Hi+WWIPNPEbLKJF1BbHYbXkkn2+I91LZFJ0+WTauzQFB2oqQYhrb9M8O82RF2A+efgfQ+dij2PMD5PNYEDwlgXATponF/ZGvabOYT5HCj4gYTRaCrMF105QYblf5ZcP5RRo+WTO3FufVI7V0vTZ0I2N1NBq/lMsFBxnpEQbLTwK/5VpWC4KtFb/ZNxRNhoAWBumWsekkhXVuzkTiktNGdfJjBop1vWBJo2Dzj2qBU/mJumWRv1APf3lrVqqtRd7Nakk4KZBRiXSUD/8XmvrSO/Evf13qsLMyWqROFfaSPTkjWAMqgPf8RXIKkjUZwKTUhwbeWI6cUUEt3vIMJ76Jc2D2ZijtK1yKWyJ779vJ35K1wYAhYsPaO+nFV4VK56tpTtzG7RpqXfNE7F/C4hbC8gFpfbi5ccEDnMgWelHyHIOCJRf9fTWSL1qE1Mupz9Mr6ER5TLapqnpPlqZf8UDFQwpXxT41hK+vzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wymab8kt8uKJX3aZ9VFegk7VFSrA/Q6wjgDBqRtuJ1uokLeDblIHdxM7BM2T?=
 =?us-ascii?Q?L6mDgMs2SROn+0xATYCoeF45TbNf/vyR3q2yWYZ402tkPyt3qH5WmLPpE8Tq?=
 =?us-ascii?Q?1gVwZ08deVXJRDLENQv54f8k8qCsJCbTDw+ehYWMSamTYxXSTkScfOggYtzS?=
 =?us-ascii?Q?VXWGSbNnC8qOtrE0wKOy532VQgCAsRqWCd/9zexV/QrLwZGcLzmKV+Har4Wb?=
 =?us-ascii?Q?UUa69JdwCDmMVPcTfUOIYj6XIxVvPwqlEdjyLLwzG0ZGBfZInuTiHuNWGvj2?=
 =?us-ascii?Q?Y2iwFmpJ9gtA5yEfXqVBt+mTTFytFtX1J4la/qsvJKt5C/vq924fS3/ry9gw?=
 =?us-ascii?Q?4FyW5oEKfvkZHnEf4Z4XKn3OY/H5TtKK8ZJX8UvO4/hMeetS3Ip4sRGezWvf?=
 =?us-ascii?Q?MWWIchKIE8ZW23gdC3tGtR44XinlPxtkIQQI0PGX6LkMy9Iaaalzw5HTtatg?=
 =?us-ascii?Q?GtC/xpwWdXEqaHkwi8QFbB4nZVesIQzbsdFISJChmBI9lqRXjO10yAsTzKT/?=
 =?us-ascii?Q?fnB+3gkFLYzA8oemg9GFRulGjdCAXcsGJHtyQ/cExtLTzcsVY4WUgFz1Z0fS?=
 =?us-ascii?Q?9rZUeBuQYJOARELWKOVD3T1Wlf4rstdO3UTF0zUH1CAxWEYqY7+CFoc/ojn/?=
 =?us-ascii?Q?HgTi7/4MJWakZFezall96bmNvX2pg1hb3Fql3BcVL3pmBDz3YofUiXWB/w2v?=
 =?us-ascii?Q?E0eyxJHH0y4aapLOdkv+NDtCkeQCZiPyNTCg2M61LoIxnQA8zr/BX9a2O7Jo?=
 =?us-ascii?Q?0O53YpkRo6ymYEHwrfw2gEi5LXrSku0/5tKsRKOk7QuiXqU/WF2SYYhss2/h?=
 =?us-ascii?Q?JInQp6COw+cNIiO9FSvse49PDL0ftxjOko/Qd0X9mmVy5qQKkV9bsC+6jAGA?=
 =?us-ascii?Q?ed3ADXuo79NNccclRJHPMJ5rDQe5DbKyMde6UZJk/9C5HDcq/FR7xTx7KMU/?=
 =?us-ascii?Q?B7fP8MvnG6XVshNbfcKtlbnREwdZ6e0w9fCJyw3Ts/KD4FD2YUtPqj/9tzQs?=
 =?us-ascii?Q?8hGf6dLEuvUepiS5dLObUwlAyjpGvEVjB7/LAAWcg5nPGe2atbay6BDI2RbT?=
 =?us-ascii?Q?fK96zbtX4U5n+5ojdR6gREFyVgvaDiRg7fOfEvdb1H0RE9g6ngRYCSV+BAXK?=
 =?us-ascii?Q?nPVylgZ9FvMyuP1p53GyHvvK02ATy4JYUMwTngiFaIOcUWvM7tSyvXLpN1Xv?=
 =?us-ascii?Q?FitnHgAMCRKyhiQHb4eyTT/UOC1hGskOyg9l7dt12CvJE6gbq/kHdo8T/Lc3?=
 =?us-ascii?Q?lLbtK0YQzjHMx4v/Tpm5Gzvq/9Z/DxElpDfw51fP132327X2aKJIMLlCkdPt?=
 =?us-ascii?Q?QGwW+ylHD3G/Tz2UUTGvfTJt0YfszhAvZI6KxD8nuUdzAst/PpPj51c2iyJu?=
 =?us-ascii?Q?vzXFwc/DuCcWnw+IYHeOVMSP6ejDcyG4SKhUzx+jJr5gfjNVUUJqrHCw0PyL?=
 =?us-ascii?Q?Y/QcU6prNSrIyLu9tUPEAskSv07pk016omLE5EzmCouh3ZwfSdVv6OXjF1Um?=
 =?us-ascii?Q?b3Fwh3cuh5xurDDLAxI4D1XL/AztxdN7Jg78G/kVIa/ewQCwSxzlJsYAsEVz?=
 =?us-ascii?Q?/hpnqYDOzMAWwgIGtKjSez8wAHqXyfyAiutgCDRE1EejsFprcSvPsyw+NgTv?=
 =?us-ascii?Q?KWxwGR2ZT99U/aKGtTq0YICsb3ujH5316R0tY7XHRn5Iei8LW2Uo/bpZl0fE?=
 =?us-ascii?Q?46OEzZcDmZE1Fx7s/piwTgPbooAgJRi1iG2NapNj0ovc6QCfHXX1B4ZWuP6z?=
 =?us-ascii?Q?2pd+U27xBNlKWYoUmIaAaaMZLeNX6ts=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 48188643-e901-4ebb-63c5-08de82673478
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 07:48:10.8905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la5fgDSp5jlbaGnDriF85VC+LWRFYhawp5yiqCtz7L0ACffnG+IbaVfk7YOe5bhjOkTy8YJ/w0XuW69hg1IRUlngLcqmlYJ79Sk/A2k8AbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8613
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

Airoha PCS driver depends on ARCH_AIROHA, so it should not be built
by allyesconfig configuration.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/airoha/Kconfig b/drivers/net/airoha/Kconfig
index 8c2d6db92fa..d0c007ced80 100644
--- a/drivers/net/airoha/Kconfig
+++ b/drivers/net/airoha/Kconfig
@@ -6,6 +6,7 @@ config PCS_AIROHA
 
 config PCS_AIROHA_AN7581
 	bool "Airoha AN7581 PCS driver"
+	depends on ARCH_AIROHA
 	select PCS_AIROHA
 	help
 	  This module provides helper to phylink for managing the Airoha
-- 
2.51.0

