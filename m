Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F89C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A968191C;
	Fri, 14 Mar 2025 06:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FTEkn7kV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F362E810F4; Fri, 14 Mar 2025 05:09:32 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3B1880F4C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfGkPI8jjmgptvLA4+cZRvsQX5ic7k4khUNs2cWcSGdyI0qS3+aU893qf2B1yE28WcyxFr4kT37vKmxkCTuYhdkuEkF6XtWE6E5+aqX30B7Mb9Pq/337YIQbtgTBEmYm3pM6/Uzc/m1Kdu9SMLTMMf8qiZZEfo/NVi37YdVoRXfO8gXuDdRvk0oUEjyFkGS9pthihQkq/Vb8zeai+5QVVNVcSMjm3Ti/HEPESE390wGU4LVsVS1vY62FH4RR0b51a5U9PHWhhGiJuB0RjTUznbSrzLpGROD+aH/TJwX1EA7OKCnJJnp/IHd/3DLglu/lom4FWg40tFcTqM5LphhEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fi/bIBB6MeH7+HVN/QYs/1v6cJOsHANdBAn+qsZQJ0=;
 b=au+J60V0c7dBUB+nzRNo9sBNZNO8QVQZnsbHXQ5byw7lql9H76yHbtDm0zJA6UI6avml3+87AX90jZ5wHA5AD9izWkAZCyEuyjCS2A0oNj/s7nuyT8HZXeYEw7aLHOFC2tS7kjVYJoaCHY0lt76N5PnEDH9OohjvRz3KuM3TAkFZdgwPNdIUBsdXVjWcHURr0oK/NBoIYbjaOsOxHOVPDyPWpX3MohPt3DNc8ECAhw6e4FRObNzrXGzGpDjAlR/aoU2IiQA2PnVZtnZNZCuBiSyomY7/fnZj+PhsPYB01g9Zzl5ilj0vvBd6GU6XJ8JQCpknmDKYC/DRBp8WBMQvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fi/bIBB6MeH7+HVN/QYs/1v6cJOsHANdBAn+qsZQJ0=;
 b=FTEkn7kV+Q/tkGVGjcYdFU5cdN/W72E7W6joRwLiZGOr2UDRligqdoey6yqti+UokYLMrwRcCQA4VHsEmJKHUpD17QrEzZEVz8JvsmhTgEUaszltruBUl/jMkpRNJEKBvo4HxpN7lyFMscvFg4m6DsNRWOrTPJ30C78+BTgpYYOLwD+C4czFDOCpFYAr57L7FZW35ynLrHbAFcRjiKEmp56p8PAPK7+KGmsxLnYunSI8MoMdd66NZZztZ3aL3qoMvWYPPA66lRjFO2ivD8K9up72VWu23OfzfvxlbsTBUA/4OIWjH9xrjD80IqJm9t0QXvemssn7bFR0cV4G30+rqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:09:28 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:09:28 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 01/13] drivers: i3c: Add new i3c uclass id
Date: Fri, 14 Mar 2025 12:08:50 +0800
Message-Id: <20250314040902.43621-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 13728cb4-3c94-4731-de9f-08dd62ae0391
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xVuIa5Olpb4uxKd8P4GKBkpEB/PLGHYRblXCPp/Yvrj5mOgULvwmh1ObPiBK?=
 =?us-ascii?Q?X/pOzfEaPZIobw0ZvL4nsv47EKT+Z2dfdUk8XuzxcnSVHD332Aoh4neLnEU5?=
 =?us-ascii?Q?PotNB7zUIqdvN7L6Vr1yuIbG/uuvjqQyDvKx1rEbPPxRl8eT/sgsfkxn/JgN?=
 =?us-ascii?Q?afJ5z/LT/wpmMmuENZuHnjtRwESsgwbduWJfoXgIY+BdvSo7qxDP4ERaHonI?=
 =?us-ascii?Q?O3b5mbFYlYijSQTL3sJZR1dSELeNQhRU+Nqp+Benq/seYrTDh55CPtTmrMoK?=
 =?us-ascii?Q?buV3AvPyyaVLkIrmmewRanRPdr+eV52T+Cns6sdmei9k9Ef53qvSUcueAeqM?=
 =?us-ascii?Q?z3N2heIErsiPpmIOvg99S/ktkzxwfrKlB9kWmLgZ8SQYQjpvF9hchDyeA+Da?=
 =?us-ascii?Q?/By31N2L52PpkJ/Jdm6tWPsZa7MKTbydRRbfPwmi/emF0qNoZQu3wHGBsncz?=
 =?us-ascii?Q?Mi1/bKi8KmoKmn8oQcrSfLzH5PAvgB4aUpxBNZ3N5BBFMaKxyd+VUbQNHe28?=
 =?us-ascii?Q?59GX72aknZ9Cp8KJWEsAYkKkft540O8EqDW50G+qJ1l5nt/OGgDijpcNSo2e?=
 =?us-ascii?Q?LlBcO392+u7I5Ps4xZC/cpxxDYLgPclVCfTRnYV2KkblhxJyEvFHc4garNEy?=
 =?us-ascii?Q?wEeqygeg3Pyu/jjAC+6xNbA/LnWJXOgLAfiFwvhyNP2cT45SDra83SlP0Bc/?=
 =?us-ascii?Q?DJNQwVIAjeSp2e0fJTulDJnXwg6HwNpCuLt+w6Iu5UvdWJWymoHOI5SELpNg?=
 =?us-ascii?Q?TTgXed2R/F7NXnRcloHT7DTqrc/l1jzBm1yrd+8FpKShWn0z3b6VajzSXz5k?=
 =?us-ascii?Q?/nQ+tDbmPCkRQM6VXJWgacEKPu7x7H/dHDllunJ1uZtS8Gq/hgnuBEpYBZjv?=
 =?us-ascii?Q?RiGgjwjSoZ40JTTYHAg8zTjqb0sdgot0NkA479t2LVClnXu8ROScaMJdkInf?=
 =?us-ascii?Q?u+OZ2N6+JuO8wi1ZDOafqSEpgCcCsxFqxfiS7bm8jBnBIUZB36IikVT4qsyu?=
 =?us-ascii?Q?lN/z29IxpvNy3IE7ujI0pqGCCLUrnK7hphvSxtDC1oWRer6x+mpnlHiNyzBv?=
 =?us-ascii?Q?7F5wLd0QZHEHGD5CFw+nbr4SmaMlXimeqMe8Kex1yAK/0jCg5cdywX0QDKz9?=
 =?us-ascii?Q?xMh4J/a35sl7E4XCs9QJBSWwXU2fPSAMESdQjOtD4m/CodVHXjA8KbMwW2Gh?=
 =?us-ascii?Q?dWwTibeIqvCLrGjxnl6Z806daFuNErW+IurlosOOuyz4TNjnMniNho1oGcop?=
 =?us-ascii?Q?YJwSXhohJrhlearIFcazfTgzmMdfWMRoqP7LB/aGIKrTNsA/XCzxfcoLrn25?=
 =?us-ascii?Q?pBPopMfLIoa/C7T3tNF11roeWaKui15m1NZddJm6dFJ+HWSmp4MYIm+AiepX?=
 =?us-ascii?Q?L3p9mTGk5bHWDAW+lkamkWLqzLXn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cVuztzd8iBsv5fHpjwfOfj27w6oO5KQAGZDKP8MbB82xE2n11DHUXRKF9SQf?=
 =?us-ascii?Q?4wgRRD7jSAFBvyKmsLypU3l0I5Dz4OTTaE/Leo6inCn/GrDDpbroTuaW/RCK?=
 =?us-ascii?Q?tu/OFlhjcuMSEn1ggqCyRMSA4wBnA7r+mU1/gM7nx/85AckGU3meAJIuNGQd?=
 =?us-ascii?Q?R4iuHkeLU994DdIOeTyxXt531uRlxRwTUhqW16iUZmHGWc0N/fMcxqXg5ydh?=
 =?us-ascii?Q?POF5Rl3rzNj+5eAdtpVt033sIT7EW0pGUvwBELs29nZ+loH4ADNHNeztfIlA?=
 =?us-ascii?Q?ivdql3KcWWFZ4r8/hPoZNDZhohOyko7sDxd65bepvUgNq1UOvEhqxLs8FiyM?=
 =?us-ascii?Q?GsSIVCZMDKftuxwDTyymBl7YtXoCwHBE4+BwSX2y1fjlUeRDp/vtVqgLXKpo?=
 =?us-ascii?Q?qrf0KXDBDybUm5P+9Y0cYKVhIIX+r2saCvcmHj9a3ScSC6b2IA5wDAgErihg?=
 =?us-ascii?Q?TCcgo/zZhSCUE6S+4brJ8GREWmp9Pba42kDhBA9cq9b5OdA8Ga2qVlMLa+6K?=
 =?us-ascii?Q?jFL/z7AkLDyMMqM/0F9eBW+DABfleukK5NvUuf5c/tl5GfxAYKNHeALhm1sW?=
 =?us-ascii?Q?ex/9TWROVTLk0ZqD8La1r0sG5SWECfRCejZbIX0JebVHwcRbTJBhfTCN/wu1?=
 =?us-ascii?Q?wH38t7htlBqjanYj25E/EOpa4wqgLXdDMnq28RbxIyXEMnRsttF3LQgNxi0h?=
 =?us-ascii?Q?9UWnoTGeUlG++9Z+329Y/MxNBNUHNvc0FFIalbwSbahDuUvGWxLs+5R/zbQK?=
 =?us-ascii?Q?quy3aqnY/ULJbMLP7nNpDvqa+MBnoh3M+BorloCf4gK7V/uShn2S2xT9HBsQ?=
 =?us-ascii?Q?MwcFLl3G58SFxLKAb+3x6OrvxDrI05FRvx3pNQfXLww0kl49zBUz78SxXjuZ?=
 =?us-ascii?Q?jMfcLb9kEVKBIYGJtVzVU9r3cIb3Y+vuVxZ8gk+imq3Y5Ub7LgUijEhYCKzo?=
 =?us-ascii?Q?4V9W977h7+REXZGfKJ8n/JSoY/zXn6M0FfJBP2N7rVMaBEWxRZnvXFYbwULD?=
 =?us-ascii?Q?Rd2A1nQa9KLawMpZA/xfwNAnWfgU0FeoiVTGirCNYqSFFkrCCZ5Bh3V/D1ou?=
 =?us-ascii?Q?YcWg08Pd4HF9DOglH4m5vyWercqYgFjHhugInbkfEqEdziegB4KK4Y8maNep?=
 =?us-ascii?Q?r2Z4J7F3QGyKFRFJdNNh232ESvE/U+NHcOrluk6Ewx/027sehdehTfVhy6wU?=
 =?us-ascii?Q?e+2rATlElLSqdjbPAnXr7VO0kKpVPAGEVXUKZJGb9s7fErBXmgs37BBqdU6C?=
 =?us-ascii?Q?cVNO67m9SLuqOrowUswb1NssWevnOR9wiHO+DKL6c5iTCX4k74PLNVVgeI5T?=
 =?us-ascii?Q?0sar8iJA8Wb6TTyvWRBmI5FFWFNrrOz7Bbx/IIrUA1IXRXER4JCSGpCiUOnM?=
 =?us-ascii?Q?zSb3CUrlfoyj0ApAksH3wQbzlq2g0+j4fW0nngccf6ovMhy61FUsC0u6JNL6?=
 =?us-ascii?Q?ed5emyiaTpa1F7PC3JqCZwE5oP47J86GYAZTvgO360gOTxzLF0ASwlJB2ZUR?=
 =?us-ascii?Q?KKvFgjEiTVcua/YOZZYS0fhQC1Qqv4niWAl1joZUMSOw+9A07Bsd9FqdSd+F?=
 =?us-ascii?Q?zA1fIJ0a21UT1WGKVcFhIuwgXubti06jSIPah1+qP4mDNib2wXioDSCnNMBj?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13728cb4-3c94-4731-de9f-08dd62ae0391
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:09:28.2901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3zmcEuIyzW0V2vu8+KOBGL8uv2Fv/QNpI9XSNifdXXbW323Ic4OIbLd5rX2b9gaHqlmsECduYuWmHLth7zIJrKGFMHtdBWsKeCD7lMXNrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..1d259b439ff 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.26.2

