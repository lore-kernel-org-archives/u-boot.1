Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447F8C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 07:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98EC987950;
	Fri, 12 Jan 2024 08:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FhChGGxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B74787970; Fri, 12 Jan 2024 08:07:37 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BCC87950
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 08:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVvOykNcDaaZiGkbyLobkkNwPB2sAYI3YGI1lbRBvmmjWiJ5n2r1RzEAOjzAR4HviI79/6iLAXiSKuHbKjoCXTcpO6CTSpGslQmuRlOnKsVmbtDCOl2SSjGMsEuJ/j3RFqpp9PRJXbG4V2JWvjvc5HlowXtgbOWa37cFDV+JeYLsL8PGw3ItBbwpixTkcwFGyUd28KGvhSu/IsIbYj2qfu/7qDExJgzIwlmMmUx1ajVOAZ/4gq6+dHKB5pUnS2uskpeZsFtBfVMMttSC4WGn4c8DCSakiGYvtAnYGm1EiI48E+rSeuhyftPeRP+BDgD055h/cyZr4DciOSqOiGV4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKtg5ndHCa3D5DoS9L+mjbLmhYRiyOw+Bepm0XeazqE=;
 b=m3AD5mhyM/VjDyQSGCuKzz8wjV3IUrOzQjTHY8HweV2WlU+AMUQXkIRgrQXKhevOt1a5G5Mz6jWDQDf7jVfHUScOtG24vE2RGr+j5kyd6dkFf9iljOkn7pmuzKQrbit52iqVVG3aGXgCtr/T64rQ/y66GGoWe2kFjM7MAoyFVCs2leH3AKKQAt/n7vvL73eqpSdPWL9d+rSNFfjosrDkeakN/hS776tCweEWOWPJ7IODuX3vTci5nsJ4I8Klqudl7eOlUuw/JhJeL8J8z+8oN+BVnb9RLwegkfsJACCwW/wniLkM9WMUEf8hcSQkI7S8KTA18TuHH1dDP+X7bMZmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKtg5ndHCa3D5DoS9L+mjbLmhYRiyOw+Bepm0XeazqE=;
 b=FhChGGxkscX9RHj8iTK32AlbqZ7blSU+/QwKyydf+RjScBWaTeYl4LbOMQ6KDu4hIP4V77rkvjjsfx85QWZRpB+RrScCpLLVm0hmBEwQZZMMEfWYKepkpxvBedbc55XD8OzBQyyaUm7xDYc/ioqd93EUhH+DBuK/Y8nzYyr4qWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5302.eurprd04.prod.outlook.com (2603:10a6:20b:7::20)
 by PAWPR04MB9767.eurprd04.prod.outlook.com (2603:10a6:102:383::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 07:07:33 +0000
Received: from AM6PR04MB5302.eurprd04.prod.outlook.com
 ([fe80::d91e:b436:3bf2:14c8]) by AM6PR04MB5302.eurprd04.prod.outlook.com
 ([fe80::d91e:b436:3bf2:14c8%5]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 07:07:33 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	thomas.schaefer@kontron.com
Subject: [PATCH] arm: imx: imx8m: Enable the SError exception
Date: Fri, 12 Jan 2024 15:07:14 +0800
Message-Id: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To AM6PR04MB5302.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5302:EE_|PAWPR04MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 324def6b-5a26-495b-88db-08dc133d261c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YqZPUuno3NIGNPbQwe6Xj7kPSELZFFfe8fXfTa8BGtaBc3QdXoumzOyTo6f3AgxAOJYnl7Az91YgRANh9NrYZzC1G556iQAPa6Tc8/R9wyyfOIYxHF8pFNSFTW7bh6sQpnOLZxQ1o9ihFooFunFmmXKGUmoX5Vq6FBDEgo1p4DlQl+gJznRPFnhjykr0xYqduap2wR0D/kgzlnWfd0qDpgvTnkG5azwlbaiKd8LTAzOAwpbWCtzVSgKtzIEVyzyW4w0z96wLFK2+WbeToK5kZVVU0iaQLjUJ4lNjtwYeLVJXQ+Lkl/UXDvWd7KnMws/Z1rD4CEVeN9+yzDAuRbjF279YB3igRkoKK9/MYaD5mQDxHhpYAUwDqrrBL9J2omFvTvZZ4E1QuLqwvT3iWot21iy0RdOS/vl8Lg4iARzvb9U5dAI8A3cf860LfL3/3xKdmaVKl1zd8AF4egukAob9a1l17t25uKoYGWDJTNFDIqMzknniu5WFqbQY/7G0fl1WTtsrj42A0dcB4sjy/ub83p9w69LRpVcwP+MTKhVRE2EdwievZB4zr1iOwbzlpaX67GxvSrj/QGR2wgAF+KN5b8IgW4yK1rgjL0gayImyFgG41eqQ4mW+AxZoXAZEVW7mTZbNVqMjmfSDTXPRJhiyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5302.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(316002)(38100700002)(41300700001)(36756003)(2906002)(86362001)(6486002)(6506007)(66476007)(66946007)(52116002)(66556008)(6666004)(478600001)(4744005)(6512007)(5660300002)(4326008)(2616005)(26005)(8936002)(44832011)(8676002)(38350700005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjQdv5A+FaRdG3MGbGQJTK+THPSv3A+9KCsMiZ3nZvFv9Yh1iJrb27ZtHuyF?=
 =?us-ascii?Q?2k7hKRbnpDD2sLR8JfQ2S79+JibzE4SKjZfGX3IF9KlkF2rVYcrpJabaCI2w?=
 =?us-ascii?Q?ukfFVWOsZFgwJNbKtzgQ09iIycwFLV3BVS2Sm+OtetRMZw9sCUPNmt4eQ0dM?=
 =?us-ascii?Q?LQASdsZeHI6qhnodzEopS8QiYYXt/uVusPIqvoKdW005I+7luqeP2W7c6jhm?=
 =?us-ascii?Q?ZgV3CfhUkt6OEj2VQ3q9Yhm/EdTpfTiiU3M6tJ7eD7zqfySyYE3TSNido3M0?=
 =?us-ascii?Q?F5XhLVb3P6wFFDgJ1lTO3A0rz5eMfnr3eyHo3oOamyGA1wgKoXgdVQPdAJgE?=
 =?us-ascii?Q?bRl2VKh4BnXkvzDaaUPUYA8954r0ecoFzsf9H1SiXr03GnLK2eQWE8RKJ39+?=
 =?us-ascii?Q?DcZCxBII80JFNJp3C96XKyxH1nBZ2Ib8A4qlnBWO6aHth/c/n342qphptqac?=
 =?us-ascii?Q?220gb7HNmoYPNCe2Al9BFYN5KgWBPWs9ZEFMZ8QH3bBjBF7bBH+TxpwYWDoF?=
 =?us-ascii?Q?hIPVJig18SAzBcR0sTH8Ia7+Ii/i9xwOSAmGm+qKeQ/IbCSamgTMvbi1CUQH?=
 =?us-ascii?Q?/tG0b4EjKq5acdlqskM4VcMKSnJzIfE5hTXmHvS5+nCMMeQ/mOyo/5a73e3R?=
 =?us-ascii?Q?8FLhbdpK7HpjcIxavDi9drwtXetjJqhsH0tT+h4Ckesi0DEtQUHDtjUmggqc?=
 =?us-ascii?Q?gTUdufR+Q1+lMG9My10zF7f7GTKqmUefmqq4/4BEE18LYSBOD6mqem8slG4e?=
 =?us-ascii?Q?pKeWvU3o+ravBWbXbUr6TiuBhYqpm2i4aj/slmg8tUV/bP4PXN+8XlpKZJ6G?=
 =?us-ascii?Q?JSou+itRxCdxkHi7anavH5XvhRR5UrDFMvDIOuerRjmniBTk//u9DSv159bS?=
 =?us-ascii?Q?5+MpqLg0I0neKTx1vW82cKuQI0+D5jMllNR2zzvcyiUTW2l6uwXmiM9NcQaA?=
 =?us-ascii?Q?Phtob0bD53rcenl5UDtqFuZRK/nUra1YsyBzW9X9pnpq3XQBI8vHxXWJPONa?=
 =?us-ascii?Q?BZp7chJNNK9f5z+U0u/iCMhi6p+sMitgfNORVb04ok1+PT6Jg52sCN4PwhUJ?=
 =?us-ascii?Q?FTS1D362A+CL3/okIQzETYH57qycLZr9jgTGL41g/en27d7Xf+IXracgWNGH?=
 =?us-ascii?Q?ab7pT7mkh96+kTnzLxCzOObZxyNI3j+GyIenewJq1hRV1l1Ix4HyE1W53Z6r?=
 =?us-ascii?Q?kIj3tRoyC4NQwTJ8V1+G0rkTO5tfgc7PrJUjq3EdNxqU8z/ouaSnO+eUEich?=
 =?us-ascii?Q?1KAicNRTSP5mnSfgy9rOWsoPDN3SBSlD/yMRZCuX2cL+60/afFdmg51D9JcK?=
 =?us-ascii?Q?/K8BAGKqdCvglqDt3OOqzRiZSAkVRWqyPXztJ2tCiG9GSN7zfPwFY/aN/xOw?=
 =?us-ascii?Q?hFynBt5OFfHKmLGY372278BlKsWYfOSyj44rHjOxdTnT8ijmnKkKf4LmVBCM?=
 =?us-ascii?Q?s0H6GW1abrD2qCEbadCnRYASI2MUySZTDxLRTpxfGQLFmPgy3Uu5i25SrGTa?=
 =?us-ascii?Q?6yK14RSdRdXMDXOvvkKCy4LdueKwByjUK1pyimBVMfF1vsb3OQ0neQ1Vze7G?=
 =?us-ascii?Q?I8YZ6Qr0vKdcfj5+Ijk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324def6b-5a26-495b-88db-08dc133d261c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 07:07:33.6366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0TNG4K3soahkpu2H4huYl1prehxM3qpfBh4sZp8LPkI3R3HsHCHrZsFnVWtaN4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9767
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

To work with commit 2f3c920(imx8m: workaround ROM serror),
we need to enable the SError exception and install vector in SPL.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 67da198..88ef732 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -11,14 +11,17 @@ config IMX8MQ
 	bool
 	select IMX8M
 	select CLK_IMX8MQ
+	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX8MM
 	bool
 	select IMX8M
+	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX8MN
 	bool
 	select IMX8M
+	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX8MP
 	bool
-- 
2.7.4

