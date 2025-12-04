Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B803D1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0985983B2C;
	Thu,  4 Dec 2025 05:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3kMDEcqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1407183F72; Thu,  4 Dec 2025 05:14:58 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D7883D9C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At8l5bTCBCe4o+a+ojyWLdRYlzZEwVMtV/hJ/hbVp8Li9ntlkBOaX5QQMrTiuyNZG2DCLsAkN3MWE8gpUoC90n0Q9SFEJU5QyAGCQSqmB+dWiaa5S/BzjXux/FT6rE0w7b7RU3fIyvy0+vQMkRCMPS8Om9b1ru9sxwS6tyz7spswuRWUSTw11ptg9Sve+W+aYdX/IhkPAS3rZAot2+eNtKL4YgpDtphXAyhT6Rq0appq/3M8wWOzwLDGLfBCY/1qdifVq/GUn69QPLoeEtNRvy69y5IHz0RRS23ZWQ1XKmv/DhycQfLYmvz3RDkzdzMqZ58DgL42Kbrruj24brFhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqVNwd8khqFDo+kPHAtNbu2fowXYAwaZJ7cge27IiSs=;
 b=H3HGDaVo47NnOXQ3K2Lia43VSR7PcGUUio7Cy38dcv25sQltNROv8rFYiJdMn0UwqTRyPXEO/ljlCRXQtj5z89mfHmPanCt1aWtBeUsdZef1wcauAVQt97FJCW/ZvZZGatyCUc1j/OjLmQdMJjHJahNP3S7/qD1OYJXyHD5uU9V+YM/FIXHrK/yysnj9tYSUzKMizqp1XjqWqKTzqJ6c5qM80NfJhB0GF1QPkCrhojXY49brOj47o1JAk0EdLKlDSOmHlvABtV6YomzHUx/GL28UZPv1viAgGF9+X58FHhLDa5+aNuU9Aklhg+oH/dHTviaNF/uSolE1t5xo+3VkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqVNwd8khqFDo+kPHAtNbu2fowXYAwaZJ7cge27IiSs=;
 b=3kMDEcqox2bX4jvIieGWeBxFFJluU7eQwB0C71LMETLH97FpYge8kwG7YW1h2DxFIHPys+1fXUFMqsmn/1WPrC64ICFnGwrMm3br442vF7prDgUv0oNj6CpvnLvqTOfrRGdh8h9sk4mQ9McUs0WDn/+xTaoz04CEHR/v7D7314nK5Ct57Gny+u2qYsPIP3YGRsfo8N+AjKFqRi0Lzej7kosh5cNQcK+OrJRdLwP8XE6IwLIjFbxF44/N5LwiLUiYcqPH0R5mIpHqOFBcO+qkQUNsGvBeoLyyfK8HexDkou+9WDoMOxghNNo3NhfgfmXO2FiBa0Qbo69rnZpJP3O2Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 08/19] net: airoha: pcs: improve/fix building rules
Date: Thu,  4 Dec 2025 07:14:22 +0300
Message-ID: <20251204041433.3459826-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a00d82-515c-49f6-44d4-08de32ebadb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gw1YufcxR/NfMnC0Bh/lPOS3WMLR1fQvKUiZTKr16Ntc0hLCknKsAdNN46sJ?=
 =?us-ascii?Q?XNhBe00mnIOi1LuQSoW2in8arpzh4PzqBreeHF3krf+aO9+c1om6S6m8w7dH?=
 =?us-ascii?Q?A+0h9fpo4AkZd5ON4/ryj4ELWya+EuIV5srpDkvQI/sg6qB6fNsdCzfLfPTy?=
 =?us-ascii?Q?hNp6JtGu8/hBtUPh9T/sx0uRlUSeEClTlbF8gYaxwgjwFc7GjI/rj/mxCeCo?=
 =?us-ascii?Q?RnE7Ed5IpFO96iOGbYlUYTj2/aJj66bCYYVfJinkkUoy4L6HJ9V7DHjkPYgV?=
 =?us-ascii?Q?kMaVi86z57CYfS1omJ9opKP7FLyHf5w5my67wBmRU51CYJAcLt1bqNCKd+mG?=
 =?us-ascii?Q?wlTJpcirX30pVX3z1NpjldkUaF5yoonCwfDVikxN+M9KwTvCGW5a8XJ8+O94?=
 =?us-ascii?Q?gkUJebKggTswqTA+F3r8bDZCSNqdv9aaRKHZrVaim2YJzoWldJwoCVjyKXks?=
 =?us-ascii?Q?ej5qazk6COkCLozf/tPYp0vSy1TvK137bfSgda/0GgeS3vCLxNrHSlHBt6py?=
 =?us-ascii?Q?epSyIUdk1gz93oKP3vgnF9W4tM+SbSxOzAdciyP3+P7sX275JvpY1xpVy9wv?=
 =?us-ascii?Q?uTiNl/vmVYUNWgLKTMlV++xmr0wAiqlrKuFo5JQrIC71xuw6FcVS4B7PS3mQ?=
 =?us-ascii?Q?AChw+oW2eLKr4DxJ/vCSCcislMBgC1lRZ2pfeUsDudkdtcDodrRPmGvlKV+Q?=
 =?us-ascii?Q?+OT3DDlkZqX82HtuEhh3GoTnxiMweE8upJjIBBXJGI+C5wo11Y1kvM8eJptQ?=
 =?us-ascii?Q?oFtOFdrO04Dui1bjLqo07eEu2N5SHbRXUi7CiTl0HnhMDfo5ETljeY5CqRQ1?=
 =?us-ascii?Q?idbJxzXHvOwk/btQBaNgQp8ngRpeLISGaXfKI/oque36yTqysHW6WeDoKIBE?=
 =?us-ascii?Q?GTYfDs1E6OUsqBjfzGtoKwuPrSxD5ZjGJZFnDKr89xr1eqdSSaidg7kKHNkt?=
 =?us-ascii?Q?0SJILCdBnFDvLnxRIXDP/1tzRawC+lYRwubKOwTtHNbz9T+j/oVPkCt+RHJf?=
 =?us-ascii?Q?6FpA8uRNR0xEouo4IispCzu3qWK8eNadqEqnVZsnfDS78PrVu+YR5U8JhMO8?=
 =?us-ascii?Q?7nKGCVMIcqhwrZHi5/CxZu9Pl3I/dZ+fbEpnf6m9k82Q0ry2jmiJ2+J0pI3+?=
 =?us-ascii?Q?C5HHbCNpcv81dR9CuvRFSW2wGCjUVX9t/ggtXJj5Hi0tOFXn+CxsQmdk6APC?=
 =?us-ascii?Q?CichurTjS1l5ouTQOsKOktPST+i9LMDTwXJIC6hT5WatdT5WLdl580c+95Nu?=
 =?us-ascii?Q?goWpIowNT1hyAGizTdws343XcOhJTBVV35qaH4wcKzoxa8c0n+KmaKp7gKLF?=
 =?us-ascii?Q?kJpFVh4Bkt4uX8HmjptcooHOiN2OT+1WGNAFtLF0hq3uTDS4bF3cv/XYFEJN?=
 =?us-ascii?Q?gQGT8dW3CkrC1pPKzSvbJ8oJsID1wWP0GRo4jEpBV26bz7HAZw/CDvE/dJU7?=
 =?us-ascii?Q?+cjI4oKymlF1qTAADfIhy9M5U1mkGO2qYalAq9FVdm0F/jIl/6OTUh1cgMV/?=
 =?us-ascii?Q?aqQa7HTg7VRndc40FFsmiA++BczAN0kFAwSdU07WyDRwYvefF9p7/wyIJw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKnE+FZ5cgNxiMe5pcsnHR0frfERgQXV8tQBa9M/pxubznUPYSFwmyZPhNH5?=
 =?us-ascii?Q?/Ysd3USCqrHLGP3DvI10hJaHewcEDwEcuF8I9Efxox5Adu6UXgwpzqKTWoma?=
 =?us-ascii?Q?2lKkQaRkiM4JS8lofOFEJag8jgKAk8QVBw/LSLzCN/sJq3xE+guSo3aLC4It?=
 =?us-ascii?Q?qv/7DOVNDKzxEtpVJetAi+8NZqKeVVlLJwAUKxixUi6xmlUkFWaG1Nuqe4cT?=
 =?us-ascii?Q?0qQv8HYgF5jItZqRD155fRIax9gYoZBrOc/PRfPuLy+KcyHeLfkP+zxFMho+?=
 =?us-ascii?Q?gvlrOocmsaFCPTtlnUkvC6LGfSqJXqeytSi+smkPRKRJ6gHfrRjhG8qc9f4+?=
 =?us-ascii?Q?7uw7uhfDJTgglZD70L2KIB4rou6OKJFGj6UgSCsxZTRWMDO94/FGqw53v7Il?=
 =?us-ascii?Q?pu/1H5DWg6ZJUA6lNxHJuhYhAg/FowOuChKRu3BdAthPgbeznNlziyPHctSH?=
 =?us-ascii?Q?tcVcR5FM5Tw9lsy4BWQHSydb0cOKMVRNJ1nDR6qu9fde3TkJqcUa0VF/hjHK?=
 =?us-ascii?Q?EMIuWDaxlvavXXhawa5siUP/cy1F9/wM46pABIazx7BktaL1wIL1ZAd05HYU?=
 =?us-ascii?Q?yrSpbq2zMoTXXWrBKwp6o7kYaNXUZ5kttbDZxEOT7VrNFU6E5+w9/pkKCPik?=
 =?us-ascii?Q?MGKjdYsKKlbyyNcJTcmdxtec+nImDDrtSdLowNcEkIdbtUHpHfdrbtVIGUh2?=
 =?us-ascii?Q?5hkCf2EIFP94PB+EJQFvLGd1JtjjM5iUxaqGS9uw6g1ma0swu6VWsVSTU7DZ?=
 =?us-ascii?Q?zvP5hKVDRoaftgmeQkz61GZkXa2Sw3hwsrNwziga22evAk3r96O1pvXRycj5?=
 =?us-ascii?Q?QR9wJ9M33xc6hn5hY/kV3VID/dKUiGV00GbequVToKfRf6ba4XKkGG9kTRL+?=
 =?us-ascii?Q?zydqOoRPRCJFqUf8By5RMvf8PhgHaN6X/bRZYNNEpWfLUAjk5tZMx+ZNod21?=
 =?us-ascii?Q?I55g5ptUKmMM2ENNkNw1DthwLRc2G2bue+3HPeEensVgxseNnynl7p1nqS5w?=
 =?us-ascii?Q?7CGBFmId3REFPCt7XQ3vq28aO816cmya9WEXX1r5AZnhvX1C6TDKNoGLoVhw?=
 =?us-ascii?Q?Q+SIaSzWYaA/dyzcklKYnKy9Nl2WS/iISh3WuFNlAcdGmoItq1HUbkhay+0T?=
 =?us-ascii?Q?WzopLIyxCCXT4zJztf3y7CUsszipyNurGWnFDuAHi7DWsho7ybRCUzPueRXI?=
 =?us-ascii?Q?9/OLma0cG3kdMkTE80Jcz7MP8rpImRxXxlql1NpIkElANH1q3gvYsNd8UE1J?=
 =?us-ascii?Q?Bee46BXCGLhOlldFphYUSD1tC0liu6q396TvI/KNKwb4PhFbEl0da3Utsj12?=
 =?us-ascii?Q?j4KxHNCocy++/sd/eCXzlDwXmz1Fm/j9IgUrD1iApsLKaI3Fj+/BCofDYtom?=
 =?us-ascii?Q?av6uXb4EgDK5PBo7YqXNCJcwRL44GP8vKQK++jv1LdoRapmxbfAGXWaQokNX?=
 =?us-ascii?Q?5Wqj8Mchug3L5gum+KO+aCACY/H27RjCkSMzTECIE5uDkUBhmmoUxh0w/OZS?=
 =?us-ascii?Q?bZ5BgrNPaQqbbshZqXAb+BaHUtlIe8TP7Ozy9DAARwlZHYUwiJIfstonBwNk?=
 =?us-ascii?Q?2T+tB/hetdQLeE88ee+2HNqWW3SFGsi4iJmMe2ZZ0/i34BeBXnUcKywalmk1?=
 =?us-ascii?Q?/xmJGgHYKzsuHUHLldqmloc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a00d82-515c-49f6-44d4-08de32ebadb5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:54.9404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSbL9JfVHV0yUbfYiP/HRXBsDGBQ45zMj/LpVeeqc1NLDYdX3TqpZfv6shVKyNcokm8y5i5Lx6YUW6ZRMk/Xv+HdOma2Ob9xyWbpCgreh/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

pcs-airoha-common.o should not build unconditionally,
also make building rules looks better.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha/Makefile b/drivers/net/airoha/Makefile
index 27f2969434c..81fd26cf813 100644
--- a/drivers/net/airoha/Makefile
+++ b/drivers/net/airoha/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y				+= pcs-airoha-common.o
-ifdef CONFIG_PCS_AIROHA_AN7581
-obj-y				+= pcs-an7581.o
-endif
+obj-$(CONFIG_PCS_AIROHA)	+= pcs-airoha-common.o
+obj-$(CONFIG_PCS_AIROHA_AN7581)	+= pcs-an7581.o
-- 
2.51.0

