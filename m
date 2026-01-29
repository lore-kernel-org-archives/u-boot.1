Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530C4D3566B
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89FA983B72;
	Thu, 29 Jan 2026 06:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DO4i/1C5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9965983C29; Thu, 29 Jan 2026 06:05:52 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8113483C23
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcVubIuCMOpnzkXrBuMtbt3lVJFsbvoYYmCAV5DNrgUaKtjq/MEA9UtG+UlXBn2QOEkxoRdNb094oiRSimgp+MereLUBwoSvg9bIKDzmOv/10cNQYYIP3BVX3nRaoYuZyC+XWNaWCmSHYNgzfG/YHCteFH0pncq+bv/ad2KZJ4JYZ3D/sl8jIi9yFEcb7wkvnC0gSpWF0MspHdGCr4JsTvvM3VNh8ZPr/Vu8z+Y42OfE+TV8tG2L+SxEX6LfuVaFD6i/CEl5WbozerlzjX58rY+4xEkZmZ/K82Aq+XT4KCddESJTqIDZnJatJN5ty7Z67QtBv52TbsILn4cvRP3wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcEVL/shVRGJ1+EC6s5DfbEDfPyBUfznsNDjJdc244M=;
 b=K+xcD64jjZH18TnjuocDeFy2edj9pO9GDB6dFSJM4pFy8dCwMCrYe1udJNT04cpGJbIpir+UVdYocUV6Avzm6sl1LIbN4qtX5i/z22679btIV+PwTybxY/2DQ4F4LYTE1gwO8zIDDGtr/6WBgEtb7PGu412TGrI9uFeiMW+hqLp0RPqUQSZtMDwJNH2KrmsVB9tP9IGePM1wOR6d8sEfwn09EOSBzwVQQiyNyaNKM4zt64PYzwQqZBijyWevtKvjnSdouZYtqPpBiQ0f7zU92mGtnsZmU0A6PLabIdlSrAo0qpbHHX0t/RFk8ydVcBlgSBN6FVjl3rFGJGvZ9QSERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcEVL/shVRGJ1+EC6s5DfbEDfPyBUfznsNDjJdc244M=;
 b=DO4i/1C530HEZKhsNNWc9GLIZOuawPNiCXrpzntBFv3/7ova/8olu68aHmN9NFSBhAiQfh1jI8a5cDyCJSsq43G0UkCzt/OuzYHFMIgjXYqKATfuGTjrEfbN1ylUWQVdoAkRTLrZg7mNrXjkp71NYFoM1IRodpoqKyPOdT/zwslcaKloldCDh+8U5fPGOTtDB7f6Ace3FFPS0DOMTywMlacdXRhNimxDbKYTV5CmChvAva8bxJQnvieTz67NDB6UYQYTVDpo3bjQJXCH6AU82xuBoW9EdeIEHTe7wQPDqVnW7gvQDeS2yS72C+APVDJJHBCEM6AYzZL9JJiyUJRyww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS7PR03MB8219.namprd03.prod.outlook.com (2603:10b6:8:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 05:05:48 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 05:05:48 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE Kconfig
 option
Date: Thu, 29 Jan 2026 13:04:42 +0800
Message-ID: <20260129050446.8858-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260129050446.8858-1-dinesh.maniyam@altera.com>
References: <20260129050446.8858-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS7PR03MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1627cc8f-80d7-42ec-4a72-08de5ef410a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E1kBrIqFnmogIQWpTEXZJhThIl+f2kR9Sc10rRDbLYNlkaSwczOt6MwUy+/y?=
 =?us-ascii?Q?SlZuo1EHlwMD/xp6tVNq2PO7I04LDdWioX/w+CCqzjor9Uyu2Ud+D2A5DOKC?=
 =?us-ascii?Q?oku6mILPmy2fanykC0DUIfONnC4qobk4o1SXB575LL0J594P4Vf8RqZ28BfE?=
 =?us-ascii?Q?oLZvNRy4jGZ2do8IzACUyTN4qPMeRbjCiszn75HGvxALXBF2rkF1O2vGlfks?=
 =?us-ascii?Q?w6iTeef/EelvXQL967Gdj9oxJkHDhqwkEG+aIsQIdI7QfeVjdyCF7yvTza54?=
 =?us-ascii?Q?82i0mmJFAW0ZWe5hNGwSrJfx3yp810n+rwe4MNP92btOzHG4oLkPA4kFYdP7?=
 =?us-ascii?Q?jnAqECJbtAYaIUkI3qfeJxJiBBT8UCjGKVPszgd4CrM5iN2dMaKnmz6WZ1IM?=
 =?us-ascii?Q?SQpnMKYtrwIAv2auQpjhVFP8etgXun/gi4j4KThiKdo+hjV07tDpzQEIW/HQ?=
 =?us-ascii?Q?CAdKGd9AsmiSd5QElAWT2cRtjjY8eEeaPTZ2nr2hUWsUow+8GW7vQymV7TJZ?=
 =?us-ascii?Q?VEefxpBuvJEm87DFlNs6YOU9y5+rISF2izpSgc2/B8+ldR2L7yO39XLknYHM?=
 =?us-ascii?Q?DjyteEV51XtyR4oDUgYDLzQrWDi/b2iefYaMPkrFv8ZCiMiXglld/JuYCc6N?=
 =?us-ascii?Q?jAZQE2L7tdp63yVdh39rQQGxdfZg/CuwsX2/MAMM+9994nW7hm24Hw+mI5ij?=
 =?us-ascii?Q?WE5Hk1n0ie/m6JS7yxf2xKtgax74N4Uc1qW01yiBCXafGtlMfHM4Rsw8U4fr?=
 =?us-ascii?Q?qoafPzhAqr0j1xfQsNu0/LavVTO07Zy7QdUzuCFDUl42qNeDYSzUns25A3k6?=
 =?us-ascii?Q?yt/6ytaB+nJKAHbjtSrguTWEa8DHeZHbyqD3ofNVD5wAig02QkkprevvwEu7?=
 =?us-ascii?Q?OHrXtkViyrkvM4DC1Gp9NnKJUGUFHm/XckxOg/OeXH9s9XrKqaudeWBffB9V?=
 =?us-ascii?Q?9YH2xQ96NeE3lTKvhWy46fJOrF8PZA2oH+7dCDWLz1fKV2pLOZmqB8nAydf/?=
 =?us-ascii?Q?uBhDH1f+eZ/M+mJwvXnmDuKIwp2YS3wkJrrJRAQTMMi0QP2Ke7W1QdN/xiyY?=
 =?us-ascii?Q?HQ+wkhpdLObNtfMAFUsuQkvAS9UT/KdGKc5RryH8whylK56ChhavgZ6BN19t?=
 =?us-ascii?Q?A6cileSgHMRHGtoajazcAVwEfYsgfHH4G4jcmOR8gdAUq3JbQL/SuSy2QACo?=
 =?us-ascii?Q?cTLE8ExdGXF3h40HxrbOHgza87Z7PNsahh06oFLWVE0k37YXUKkjTRGdr9WL?=
 =?us-ascii?Q?P2bX8X58ru5aCqSwhciAuV7UfrybKb72SOSwkC9OEQLRzv0P6En/a2Immjk8?=
 =?us-ascii?Q?xoY9F3kHasHTiiKjD3DHRZ8xO5vH9u07+altLaHxB8KtAKGtfkAbSxQscCwx?=
 =?us-ascii?Q?1AzEfVbz9i05a3HXCXHY6DKYq4yOjwfCP3MuBMJRO77U8Tb3dLxm1MqCR3Wd?=
 =?us-ascii?Q?84CRiEdq34aGCABaBqNkIQ//eDB7oMK1uTPIksDpnd0QGMXZSXokPFjf3Vln?=
 =?us-ascii?Q?GsP1n13b4C4DhOpr0a+2OaxfpVFqhsFJr6bsWveMI7lUL4fz7qH6MmENw1GG?=
 =?us-ascii?Q?HH8oCOUznjS+0EFJFTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pkq6XzfnooH3jw+82jues2tZuagCo7UDzJ81E3Suy7GZrsyVkRP0RcSABjB8?=
 =?us-ascii?Q?TGAf9IPAt/UUvZvIh10UDKO5E0m9a4+AosJPspBRzcf7M+mI2cTQWX0ZKk1M?=
 =?us-ascii?Q?2FKzZYdQ4TxgF7wO8R6SuzpG+R/WhHaZygnhXItaHDfONL2IFHzGEw7jR4Fk?=
 =?us-ascii?Q?qv2r8BkaLM6hCgQ4JkCK1ey9Mkt/1B454PU4hBkvKj+UR9u04g4VcvuYiE9G?=
 =?us-ascii?Q?7CQVuzn8DntXUmvJ3B0etwbDohOrcCIzPSajToK6qgl/KfLzVcm7JcK2RpHo?=
 =?us-ascii?Q?cigVmPE3b97EYrH2ScOQcKNktkrjbWHlTiuK3nRyIy51M9EZTw5QD9Vupr6p?=
 =?us-ascii?Q?QSW1pl5MGJVxFLjVdnCNgdvsyvnW4yx6rhaerBfvaCk4xroIOyDBoXvmnKES?=
 =?us-ascii?Q?jUODBOxBqwmcZHsZ2vJSRQ3sD6UVHWaPqPnh4k9fP24kBjTysU28xiZvE3k3?=
 =?us-ascii?Q?8q7v3LXRYM33x19fTMdDFCPahzLi/eR0uXk4h9St3Lmh+64KMdBGQjhQoQ+l?=
 =?us-ascii?Q?+sXewU7JFiFOjhpgJwqtqWLoRYu8Ms4W+c/o54VoPDZCwB0s6umrqtoTYvwj?=
 =?us-ascii?Q?SngWqjyCCiNK7ZYNV2PEQOj49dTJZJ5JMvS0+736FE/sQQGDDUVcHrpiPzEr?=
 =?us-ascii?Q?97fo/npZfC4oRmZE8TwCDL9ob91eQY8WDs/0UAMFkuJkkhPgTNcYInSB/rSv?=
 =?us-ascii?Q?Tr/mCRmdkQaxOJ8WQv3GTRdkbl1iazL7/uVNSbGuzhklpmdCtX4MikXhKDl4?=
 =?us-ascii?Q?EMQBJ0Y52GG5UPRMKKnNs9OtYBlDwsu6u0x5TEXCMnRXmRPbUMWitbZ4lRMu?=
 =?us-ascii?Q?WavdvMonuW4nZPoAAnxuyAuqQYuwKGXfMHQs4/XVqkbWd/xHWh47iqbyead0?=
 =?us-ascii?Q?0N7s4ruS7Qf+EEyJcb93ObDP1B/jDOwMLgizeNqW8/AUnF01jnVuWCId/A55?=
 =?us-ascii?Q?xo+jmVYaJAh9dwtTotcYlNrVo34SNsfh/Wwy1TIL40V9czxtqYZGyrf8srUw?=
 =?us-ascii?Q?amT7dqeD2J2LW73O8EjiLoH6Hm/PNgMQhqYHRZBZF84PvJNrbdwntK8bB6a+?=
 =?us-ascii?Q?klV0yslLT0Q2ZZ2+D8r3EhvDOOs/OtA/C/PYDFvqZrU+MaEw4W5D3rxSbl+X?=
 =?us-ascii?Q?wXBXLIpCMvQXnkIkNRfOaKYDnpaph7ne1V51vY+pihButpLNMACbcmGx1/wQ?=
 =?us-ascii?Q?lWYy6NNfZTEOx8PAqFr2JF3wB8197w6USIJkfPCsoAyOfMXXTmqf2o/yl/CP?=
 =?us-ascii?Q?kpijbi9Em8uE1Y9PqurnAEv22XjvIKR9YDvASNCQwBOPFU7R3aPRp6nCuTft?=
 =?us-ascii?Q?dvF8yFmCOBxs5JW0hwm9f9cYteOeEtt6fo6BwYLpzZuPLt8DtNclfeXa0j4M?=
 =?us-ascii?Q?sYah0wP4dqol8vWXhiOjIBX9Lc0v9o9O/J4oDb0Z9uPKEBkjERuTn0NoyOeK?=
 =?us-ascii?Q?iINc6/cd5T7VKHoWbsqesfRVV9k0c+CkGOZE+ZykCObT9XyfRpIWtbpIw4tM?=
 =?us-ascii?Q?ZJcUXwDirmrW8NheX1YqtEXoK072zOxwnitbCWzfB+JeddxcA/Cmky6076tt?=
 =?us-ascii?Q?HVbFLap8ZtUqQK01JdEpzXd9X/6SrDQTDA6xktmn9O/LgIBgfAYonWxRuwRm?=
 =?us-ascii?Q?ywfXiQWbfsUo9Im3QrU82jN5y77kBUBNh47RzLw2fhlgAG+IluSqhzmHrIw0?=
 =?us-ascii?Q?+mp3RD9XR6IxcPf9mz7UE7ZBlT2XMtBBW1Ar/wnB0C9aqnPIgDgDK1AZwsTJ?=
 =?us-ascii?Q?iGDfijEiWPZhTlRftfvsk9UDD65RyDE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1627cc8f-80d7-42ec-4a72-08de5ef410a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:05:48.1612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey5EnCwdTIjkfEhvBkVvlUPzcet+vQy4mzdmogIIZa+HsT9YiDzjpdvnSaVZMmwCHX/1TutcBJhDaaKe1YSZhN2HdLbVUYa8s4wI30jcmQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8219
X-Mailman-Approved-At: Thu, 29 Jan 2026 06:31:37 +0100
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

The SPL NAND MTD framework requires working driver model support
and sufficient memory resources, which are not available on all
platforms.

Introduce a SPL_NAND_FRAMEWORK_CAPABLE Kconfig option to allow
platforms to explicitly advertise support for compiling the full
NAND/MTD framework into SPL.

This avoids accidental enablement of the SPL NAND framework on
platforms that cannot support it and provides a clear capability
boundary for platform maintainers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Kconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index e0ff28cb21b..e41e5ef2e94 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -809,6 +809,31 @@ config SYS_NAND_HW_ECC_OOBFIRST
 	bool "In SPL, read the OOB first and then the data from NAND"
 	depends on SPL_NAND_SIMPLE
 
+config SPL_NAND_FRAMEWORK_CAPABLE
+	bool
+	depends on SPL_DM
+	depends on SPL_HAS_BSS_LINKER_SECTION
+
+config SPL_NAND_USE_NAND_FRAMEWORK
+	bool "Use NAND/MTD framework in SPL"
+	depends on SPL_NAND_SUPPORT && MTD
+	depends on SPL_NAND_FRAMEWORK_CAPABLE
+	depends on SPL_ENV_SUPPORT
+	depends on ENV_IS_IN_NAND
+	select SPL_SYS_NAND_SELF_INIT
+	select SPL_NAND_BASE
+	select SPL_NAND_DRIVERS
+	select SPL_NAND_IDENT
+	select SPL_NAND_INIT
+	select SPL_NAND_ECC
+	help
+		Enable loading U-Boot from NAND in SPL using the full
+		NAND/MTD framework instead of the minimal SPL NAND loaders.
+		This provides bad-block aware reads and flexible offset
+		handling via the common NAND/MTD infrastructure.
+		Platforms enabling this option must also provide working
+		driver model support and sufficient SPL memory resources.
+
 endif	# if SPL
 
 endif	# if MTD_RAW_NAND
-- 
2.43.7

