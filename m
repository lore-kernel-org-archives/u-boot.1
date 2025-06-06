Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8073CC61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DBF82A65;
	Fri,  6 Jun 2025 21:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gITgBLOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210E782AFC; Fri,  6 Jun 2025 21:35:40 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2802282A53
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIYpplTkFl7tci7NgnAYwSyi/tnOFr0d+kfni6IKbuNEZKG5vV0QJP7qPLx/lKWJQkpsUOlnDbF1ThCcJqQT3k1YhxeI0N3zrLWI16kzJNuZYFzi3aS7ewnqF/U0zbzmKCbqMBRNrC20BAahgeBjLcR+UZFeAHsicx0+wtk4bJkP+KEdc8X4BmhMGsU/noEtYQyxM8EuYVt+TcQps1YC5swOwcbb12l3lEX6cAKIZZ1ozKxwMJujpj1uEMbPQ9lUWTjZsflJRZGXf/++x7SCjHEuJi8YmmtjrAapcwd734spjpb4CRcPvdwTtLdVfmCC3twe9PqsHAFReI1BYR73Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wV079d6QB3ois6EEbVudkyUYz95onb20QcqZL4xLxrU=;
 b=R6KxgfyB1De3KApbt9drcz2MqjJlrWOY77JmQ3cTbLhhOlj94jivkEVEUa35UkrttytcjbYJg5WTzSC+VVAr3+jkBPL4DIMfN321LaUf00qCoi0u6gmZVbxXidx86c5qfIC/4mbftRLhMkUTWdYdRP1ShPj01s8kQCV9woMrOKWnvByKb3ND8JfEB6zmr1WRcqM98x5jqnJkMQKeFI+7/uCIG7PhQzc+nskjdfvu81mBiqv5uw35mDYucYgxBiVrVwREKNpiST9DHLuLWJHDZ5qM/xytDgm2dcg6bfm4UGFe85Kley19IjUhvj5t4tMbKhW8LygIyuu2X0cJ4cIfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wV079d6QB3ois6EEbVudkyUYz95onb20QcqZL4xLxrU=;
 b=gITgBLOcjC3T2Z8DAxMPfKeEKwPwyKvAEx1iMCS+NjMD+RyEx4Xudx9EvnqmxRdcO7YN5ssPKOlxI3Eo7aIuEIVOzwg53wz1ZzU5DyGOxDDpD4Jf+u5o7+un2IG2huIPYKcCAENM7fX0SJXRLNplsqcDXHM62aocBannfv6ancAbHjEl62KGu8DmVGFb1k6a+do6x/mgE32v5ep+VYG0TV4bGnoCn/3VYBcFD67sEfEeW4syi33M4Fdl5igWh68dtGPeQ/4b9iJh5Og0yCBNG86/PFJl/veM1YRnEWbC5K9dgr5WeZwu6tatyk/DWZxQ265Z7xYsDXTdN9zxjzWt5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 6 Jun
 2025 19:35:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:35:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/3] common/spl: handle properly images with bad checksum
Date: Fri,  6 Jun 2025 22:35:23 +0300
Message-ID: <20250606193524.458095-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606193524.458095-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606193524.458095-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AEE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::318) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ecc3d9-af41-403d-cd33-08dda5314ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EWEovB+F6VhQPe5YYMiapTMk5hovtODGASFYE5AHFQ12AxO+uSJRnk0mET9m?=
 =?us-ascii?Q?n1Q2S45FIu/SgRAwk9DYPpSZpgS1u2r1I8WGX9fUTuCp4wr9HekFM18zHhUv?=
 =?us-ascii?Q?giahf6y/Y9mMEUhZRhXKVhtpHx/s0w4bUoYIsQkRk0ZeKvmK7oVrgUY6wM2r?=
 =?us-ascii?Q?OA0XzIr+qQvFhyTzfuvL3OGDtnkjAlFl0ZbL8mG070fl7X7VrJO1Ti0D7Rwt?=
 =?us-ascii?Q?2Dvv0KAQL2C3XfnQgRIUxhH0qHmct7T0UslfE1xxfojL8IrPhoPC0kUObPWt?=
 =?us-ascii?Q?5rr/ZCWUNR/P917PYGs36MV4w0luk80ZDaAErBb1Ie+zIPuUpAM9K1i8+dRc?=
 =?us-ascii?Q?niCn+uRBz4aKOYB3hhDT/nm5sYyxxIMdok2zg9AjlFHXgYf6kU3ZCdXVXsoc?=
 =?us-ascii?Q?/qoVnFsIytBG51/D7znrw3GwGKaZlZHiKDNCMvs9WUIZdGrYRaaZPrF5UXcR?=
 =?us-ascii?Q?44cKcOSC/tLpfwT9FL7IhDeBOPdcy1p1IkInQ+egJIGeNedxXAocVUU4nIbs?=
 =?us-ascii?Q?EnTxWwLqMJYbUhubTRf/GFUhQ4482dBzPafc6mM/2IOjqSKV6rLUFI6Q/VVb?=
 =?us-ascii?Q?kh0N1Br5ttdshbooQJd3GMLAwk2sdPU06DdlMNzFqVYHszR4Xm3EpGYXqcUr?=
 =?us-ascii?Q?CwVYFWpYBdkcKRPeX5dtWj4NNdN33MMJjsWMjFUHoZsYYuhnQV8rnUhS8yRy?=
 =?us-ascii?Q?PacX0ExE0fPuqE2tkmRSXuVgUQNby5kpBLmKbrGO62ZyzutQ1CGWdR7W4CS1?=
 =?us-ascii?Q?WRUQyUBEudTeJqAZDw1yhWxvAFj+RhKAZnxjPLZUREjgyoTHfNEsvH9tVYjT?=
 =?us-ascii?Q?Qg+nSlVri0Idu4uqmhuOFzfVbMdsQft72fLVzouTu3wONsu7wLnqihng2cYj?=
 =?us-ascii?Q?EB6tuoAQZqxC+ijDAsxT/P8ghvn87OJaBDF7Nz97skisQb0SqoaLY4oBFL3q?=
 =?us-ascii?Q?oNdh4PgWd5VubXPPe1Wq2XUuZVhBHjzx02bgiy8OnZb6LerHkRuZw3HWwW5E?=
 =?us-ascii?Q?mDr6R97gCjl5yfn1V2PvuUle28/pykOxKBmoU4eYOgMh+yExzMix2+OwzFE8?=
 =?us-ascii?Q?mMGVw98e0mGuPRkdgyiWzYH50S0m31zsItoIYld+qShlm9EjBoEPehggWJD1?=
 =?us-ascii?Q?C2XsUuMcF7UMz2/Vokg810Ow7mrCYmY2Iqq060XWes8xnjvMyH3d2Idr8GE0?=
 =?us-ascii?Q?zktmDQPcIAXhNjefJhbH2hnjvV+PoYit85Kfzd0pyIc1ZeE+WdLfRckPxv1d?=
 =?us-ascii?Q?cGPnvMxOtTr4Sbhxj6K1D7LIK8bOoC5xB3K5Wn5EMjDi/MhiUp+dJAIu8TBm?=
 =?us-ascii?Q?vMGuXrKyY0gUakBiVMLGjKHL5EJB1k1+2Fjn4vWNcF1ZObd/+vIEjNGuD3GZ?=
 =?us-ascii?Q?ufF3Bcz4G1pJrzBqvgBhrdf/88f4ueecZx/IQqZ4bmXcasB8p9XD4gPvreKf?=
 =?us-ascii?Q?UgUdvh2cKvaMiyLH4yv4HBM7vv8LEyeoLOJSJdOgm7AV5L9cELDxTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bt1ZCdoapQRYQX7/X91W8pOAngyKXwgUWJ+zNp/z+HZmmoDHQxy/SO1eDGk8?=
 =?us-ascii?Q?QtFlohDbs1DU6xeRkf3dJP/LlHOyb1MhR6bdvYax7NmugWyvW4SnSbqgKkVL?=
 =?us-ascii?Q?8y07g5CYfRaseYyQ+GOuK0XMzYFQR11Q4kbtt/XIdy2uapKYSiPjk7Cf1t8p?=
 =?us-ascii?Q?JkSq/9idu439ffwPKsTumGs7zsxojfZ3ci5shGfNjYYcOGtwR0Un9APknBrh?=
 =?us-ascii?Q?DMV+PuWfVem1KzyuO8NDPYRcFgDy2aiDyZZ3LeWFdQhTEYpntkndki+s3Gzj?=
 =?us-ascii?Q?7iJT77IORSsshxJRSyDacSMrzrr/YPhGoazHlJ6PaOLxQJ+sELlIGvR72kza?=
 =?us-ascii?Q?VOijaDD2z/8d21+1y2xAqTBQ2hfo0jLK4mPc9taBpdx2AjcpTTohvMojOaKu?=
 =?us-ascii?Q?3G5XR3FhqfZdfE0HGfotCeTIXwa3nMKSMFLzIyz6JDm1le0xnxQfWRF1YlPD?=
 =?us-ascii?Q?IevL1U3MxLFQ0GlUNKC7vCAa5rsL03ahfBOvny0lUNsjnzUh/JrOWp23MZdA?=
 =?us-ascii?Q?kDXPNk9d3h4pdGOnvoazX6XIN1yL5g67IB0h6uQYmpoPq4xXqjM+artKf4Rr?=
 =?us-ascii?Q?MMaHX1ldC+qxGdxZcFnR7je2YSGw4LPLDk292dDmhI0SdBedMQdWWkowpjMQ?=
 =?us-ascii?Q?SQb8NbFqBH/OlOYfFnriJs+YXT0ECCL5PHlF3VynpVRcN6A62F++nR9hTDeY?=
 =?us-ascii?Q?U7Ia3o619k5gMGwPmnuNGcqYfXJTsjsesEVf4f37MJPVbhnBa9Jx1KwBeMIu?=
 =?us-ascii?Q?dlvKmcYGMuCLnWyzsHuzJGKQtW2J5UjpNQW92+Gba9TUcyQwds6Jb2JU4IH5?=
 =?us-ascii?Q?sbx0tQDOf5Gew3texjxM4ZWLGIcKtaslm68UQN044t/8wklT6LjSyM5gI5gy?=
 =?us-ascii?Q?vPmsw/wAbjZ/ZggyGlGGOgiaitwfyJqySV3gDnODJs3vNlMgJYE9KTJVMOvk?=
 =?us-ascii?Q?ty9OBwXp4yerTR5g8oEI1E9KvA9fP1pSpmknvzYpotrBJRifpcceVqpardAm?=
 =?us-ascii?Q?VFTdDeeYicrVjKyq8l0qtetlO4oKrTPQSjRa30o4/NHDfGbra5tJTXyvGiog?=
 =?us-ascii?Q?6+NUCDYo4gQz3a6A8h3FnPiHD5q4BD4cxBXll+E2bqCmdoZafamJeB2QPcdN?=
 =?us-ascii?Q?7o7RyNPGnNq/KUoOFw/PuBSB0kwRU/ORcDkBIuj2kswQ9iWxk8jccHEL/+06?=
 =?us-ascii?Q?mUAMpiApWg0hftmgoneiV2CeOGS6MFMbnevWgkT5dpd1+Frq3CS0xKb7uYju?=
 =?us-ascii?Q?QDqmyHs9tMBeKR2Xcp3+D3UAv04ihSD+qaIxjPQE3xgHzF+rciAfTRq+ooNc?=
 =?us-ascii?Q?RTCcbOxnBj0WiP5It97lWHN1xkc847/xCoKh1rCniyoxIff0HrEjNNii/nQY?=
 =?us-ascii?Q?p1d/C4dRbK9BVMIDFR+8yo47VHEeZW0eCOlNannMZGWRw7bR7l1P+kg+Y4DU?=
 =?us-ascii?Q?padbzFJobU+8jtua95RuvggWck8MiMM8GZdJquBTlNsjZOfJE4EUTgZkKDtJ?=
 =?us-ascii?Q?D3wGQFxS6Lhz121qAdpqFfXiVfIYgUV4EuDeGR4StKTeoMra+bY1SjIJKMnx?=
 =?us-ascii?Q?A+liHObfwtgJItJd0jC6HW3J+VdItrdhtsaTkjj6WVbGuxLUBewZQpGakqns?=
 =?us-ascii?Q?YyG5+phUsGwITFZT9piRC0A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ecc3d9-af41-403d-cd33-08dda5314ee7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:35:35.9670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2VKE+TSmpmhpzEGMXgs32h34T5wYSOmoRLpYEBPbR6o2nOle7cmVAwnrzJl9c2jI9xKmY+vUncqxXsNIOJwprkUxqZzDLcvHJTD1D1vHC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7623
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

load_simple_fit() returns -EPERM for the images with broken signatures.
Unfortunately this may conflict with image loaging selection on the base
of boot phase. See commit 873112db9ce68c38984ff25808dde726f8dd5573
("spl: Support selecting images based on phase in simple FIT").

Thus loading of

	configurations {
		uboot {
			description = "u-boot";
			firmware = "atf";
			loadables = "atf", "tee", "uboot";
		};
	};

with damaged "tee" image may finish without errors. This may results in
board bricking. This should not happen.

The simplest way to resolve an issue is returning the different error
code for the cases of broken signature.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ab277bb2baa..783bb84bdb5 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -322,7 +322,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		       fit_get_name(fit, node, NULL));
 		if (!fit_image_verify_with_data(fit, node, gd_fdt_blob(), src,
 						length))
-			return -EPERM;
+			return -EACCES;
 		puts("OK\n");
 	}
 
-- 
2.47.2

