Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61308CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227D683A35;
	Wed,  8 Oct 2025 09:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6sOCbbWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC07839B5; Wed,  8 Oct 2025 09:27:52 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10940839D9
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bmb2B9mmT2v4wgHf/IATb/E+FnPG5fnEZEXdWCzqMCPeHDK4rY7/ivYCdwIfBw5ZM22Q9ni2tx2mXfaW3IEq6rt/hgk81y7DgCRoZXMue1QRDu1XvhBGXLwyZlPbNH6f0fgQAML9MbY+Tx9dZIsX7JruMPW+Re8LeyKLj1FrozmP9SmBt92gg+P9KHOasb00BL91ZbQOchE7nF4D+xBGN835AsOwS8T4JBcWg7ifWYUDPSWqVVlcBlRzZbyfgAkFxHM7qV7mrajSJaYNQwBynWEC28Kkyt6oroBxM36vlUh/QQdh0SV+TZUZxqal2GN7xNFTxVWieJgp9xil7nPzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wo4C+wF+Ir1xLB/RrxNANtU3x45+8DpeVbRFdMeqVM=;
 b=Nv0Jq8a2rZUnclCJ4NrIV2fVMSPd3LgaiA+ppW2xavc7Bepi0IJufwhKIqt4jNcfZwmPdFB0ayRjJdS6OQxxH5GruQC9FPJc9QpQVkQCbtqpznFTVesrzAG5ZX3koRQqrt8+lbH1GwEhOOfe+ZLkmdNp57lvYgqegdWrVXqHQHRZFpi7hssBOwH4+/71NJdhqtXKWE7vYmWvRpgXa12zIVMXvSxf3gkSyafSq3u4yW6eIkSmVC2aDfszh2u/bPlpVfEiOKZiQ8fqFkIGx0pzOssdkR7i26NuAZ/aVLSSCong04JEwtdtRHqroPyy7bO/ZgCpzQSDvu+sePOi4lVySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wo4C+wF+Ir1xLB/RrxNANtU3x45+8DpeVbRFdMeqVM=;
 b=6sOCbbWcQPBo0Gc9fMnsMY1/8mO1SIYFKGyOpXW47FJm2p7/uRvgUYHgJWTo76YWvMid6U9GLk4ejAajqq0hG4SV+af/5L+9qR2FYlWTp8GmrKs8WmlEMGw7gAiMacGeNiyVEedOdCLpkRaNaK3HLYbQpwllgudvIlJcx31Tm8l8KV++j+l0gDwVQnD0yQtITdi3zW4xRMH7YTvAcOeGm5h5UK6dI5faZ1TQlkmE4y6MDdcTRkL0dCbs5hSa0bpCCNex7YzxWIxPos3APi9JgeekLGf5dPRHjJHCNoBsrzxtpevVt1GXbqWwkjHrRRia2hN1IPb8REWjqBrOro30BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6097.eurprd08.prod.outlook.com (2603:10a6:20b:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:27:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:27:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2 2/2] net: airoha: increase the number of rx network buffers
Date: Wed,  8 Oct 2025 10:27:33 +0300
Message-ID: <20251008072733.373173-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008072733.373173-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251008072733.373173-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000384C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:e) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: bd180c1a-5f6c-4145-43ce-08de063c2b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0qadcQ6cfAnQe6T9E6aaAKzXz4TOe+KgT8zXqouqmPV2/525e9d0WhOYUH/B?=
 =?us-ascii?Q?RCfvmRtXfzXM1DVSE62uwJtiQdZB+kRaIWkWhE4bKWVSsTdrdv+NplbVtqGW?=
 =?us-ascii?Q?UY0hOa9Qv4zAtN/Sa3P/bEllOzl0aIMa7RYFvSoC3072//CxzWUUCG8IA5Dc?=
 =?us-ascii?Q?fq4267aFESR1zByVTWQDd+p8nv0TYzy9KUJgjDCxDgbHQDq4vj+DrHnmANLs?=
 =?us-ascii?Q?zWWguAqcF4QoFzr5pc8pwA77rDfZLAVwObolRxeNwFZKzfja3DMkeBtity3u?=
 =?us-ascii?Q?kvqFFlmDZxK0bZWPDZLm5/hz6IrQBlEf/3lz9Z6kAPrXAkXVO8iz/rZZHRCN?=
 =?us-ascii?Q?ORqMO9zAcEH8yJFHeiJkPA6xYunuWIS8t5JFSGT1cREdtAk1bVKs7yI6juWV?=
 =?us-ascii?Q?FxyAd4WRKh5eogmnb+YtLVZRboMSQ/UwrtfOAA1wHj9XbZK3Fku7W6fsICa8?=
 =?us-ascii?Q?qP+GnrcLR89pXZ2if9CvS1NQm67ZmFtuOikXQF8ZStgzzifkUmSi6PIKiJbA?=
 =?us-ascii?Q?USnSWxxJuhLLQVWQX2Re/5MAXE1ykk+qGR0XitAloczuxtlaChZJMcNLB3r1?=
 =?us-ascii?Q?ZWGuwNlyDhEfLoLpzMwGJjzfpgYOeiqxml2SCiVLLbXWxebPwzPBRwwujYRf?=
 =?us-ascii?Q?RGd8SNkqYI3mXgofhYenAklx95fTaEv4B5zGH2/gk8P/txEmZ9+s3veSqeyO?=
 =?us-ascii?Q?FfVDWFjWAk7v3088xMUamFpE6p79AbFXtfAOO8HI+g9BIAC/gGcmpcwOg30V?=
 =?us-ascii?Q?FOubqNr1ZegbweCji8zDPRPnczAZ0Yv05W77d1hBZyv3J+W/Y1goihd3tQ+2?=
 =?us-ascii?Q?a4CWiyJiLkMx81+E0/3jHXpqZYH4YNdpt+cHanlkJxv2ERRxNrpFoEbXuhI2?=
 =?us-ascii?Q?SaphWac1Q91bPWf1QkjJO/Kglqv8WhtivfqNhrwVGJAk1NvhTdlGFvJ3YRxI?=
 =?us-ascii?Q?sKsrchXcqCX3xmXeMthoFEL7io+CqlaOX7QwWOIo0JbJ5guh6JQfLjU8AqJr?=
 =?us-ascii?Q?oiMCtll1weRDNDZmMtFREBBvggOOmGjxgcHueJyFkiNH0GlYKectVTy/7UsT?=
 =?us-ascii?Q?FcI6rHZ+yEvNDmwjBPiBSuIUuSBdjRHBs25KLJRnljTWE8K2HMoXyLNQ/IPG?=
 =?us-ascii?Q?EIFqoMLYOX2dO1+i1dDJW/unsLrLJN0pmHm5JzeUrL4bB622DNheV8M9EyUG?=
 =?us-ascii?Q?UyORkhZxEk9/+SiT+4ZPJvXDBKwgZkS7NKjvM2E4iVWGRUJV93Oc2OXd/Y5d?=
 =?us-ascii?Q?M+DVsKl0NisyufFzcLvMEsKougOy6IBKh37WTraovsY6mQyq59KFkfoKs7Oq?=
 =?us-ascii?Q?b3xZ7CcnchjnpD6tkTZTE5PH2qoye67gEzxAm0MR0zRbpqMlHF7v9gXo7UKb?=
 =?us-ascii?Q?3gdrrtUrKYpMatFAW7bMYTg4hxVJHFTJvVDF0YHxO8G5ryJX1utliXM3bwm4?=
 =?us-ascii?Q?OPEMj18ytV0+GNU8Q2lD3UybGOshxSgrPuG3e4dpjhf1WxE/CUEo1iq3bA5U?=
 =?us-ascii?Q?wF+SO2bHMW2Ebh9dqGLBkF8mD3hrTdpZSUUk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGBcNZYLr3TfViIODcBx3O2rkys85r4utvcX6oll/54sdbExtYADkP5GkpLh?=
 =?us-ascii?Q?c7GSdis3Z7BCvruXBoAyBP0UTioDuDLBkzF+4SVXGmxPg6bIe3ClODkPlsmD?=
 =?us-ascii?Q?xZm6IscHKW8D5X806yTdoaYhBr3C1j6Yv/j4OaLUnkxII1eR3FuBSwPKs5t2?=
 =?us-ascii?Q?CoVn8s1HyWpI/Sj3tK1o2aJ5D1X96JinOm6iCXhwvhBLbTMwwFx7wp/c6IAQ?=
 =?us-ascii?Q?vmkVo4Poande2cdfVe8d/uLLtTAZ35GCkLQXUvTDA1Ei+uwAiNjhMtriTmUg?=
 =?us-ascii?Q?+Q4fk9w1ija8wSjc6sP/l9V8B0t0cly4sgetlLtC5w4vMKpDP681ZOu4tekb?=
 =?us-ascii?Q?jMVIkvM46tDS9qCdRz77BE6gJl3bRpiMQ5+BXqc/ZyH6o/oLxAE5OTak3r8a?=
 =?us-ascii?Q?bGoI5leKQAGQn9hWoKOavzGZ2Xia8uT5J2NuOLJS2G+uGUJae55/4Adnq/wP?=
 =?us-ascii?Q?d/mWUPwBpqcNXgOo3gJKIgsur/9iZdYvRQhGTpze18Vbc9LO9icbZ8QOLIXW?=
 =?us-ascii?Q?5dOScGBDIG7amYcPfqBwnDl0FcLzyOQXYn5/pbde9Gf1IHFItWHE8gEaysIj?=
 =?us-ascii?Q?yJqgzQclPIXx+/NLBgG2P+vHqVYYhjLIIJRmW9fx2rkuh+a8b5S6zkbF2d7y?=
 =?us-ascii?Q?0IO/oBbmZWtqj0c+5/1NuKKwR2dPqAM4x7r856EycbZP10AMq2d4Ba0EWHNd?=
 =?us-ascii?Q?aoouqpkezlG1MvllL2c0HOZhdAcc1rs/UvYubZdx0CmqDDth1CX6CVPhqqSO?=
 =?us-ascii?Q?T5Vocgoz09AkCAqj7f5f+KDc5z2XO1D1sSxQcBRJA+Is28wDjGBHIQXrduoQ?=
 =?us-ascii?Q?vcEqS9mFHAT4mYkIYtburyhGFrrYEcmVighc++00cQYwCoNqbMcRhi6Vddom?=
 =?us-ascii?Q?sIb5gny3KRGBBrwGpzOZUs2nZQcqmQJGhgjr33h/1dpxNhkWICMLhmaK4X3P?=
 =?us-ascii?Q?WzPW/7pz3j90NuLq2gj8vp1+Rih8cDI4/Inbcl4WiCBzKeBJwIgJum+VyRgx?=
 =?us-ascii?Q?3Nse41vXh/G25wMDctNNORWwqcejdIsZR+0bYsatpU2wFJxh37pnsSFAaf9C?=
 =?us-ascii?Q?AxXPm2NoGpP97ztyP/bMFiEePtttpFVfapJq13CkkgDkXPlFlKnvkLuZgRP+?=
 =?us-ascii?Q?5lANNJoioNifGgxs/ICIAHl3U1PyWmeoxRhWkjh8nKPRhKG704rifcqlkCSE?=
 =?us-ascii?Q?0xMi9Szhr6xXqpjKEFvNQ/CNRbRn0gVFFnGwCnQF1XnglmTLlWIJavYLCbn0?=
 =?us-ascii?Q?UpjP0CetI4uPbgq96sNGGqm5SBde/RW+nd/qrO+keFrHhXjFXHAp22QM9sf+?=
 =?us-ascii?Q?VeLDntJflXAIGbPFEmIgSmVVfX1Yzkq4ViR7Cn9Tw0DmNBrg1uAP65VOs6LS?=
 =?us-ascii?Q?Dk+MaNNbymye9nQz46LY7ABvH3RY1qCL3Oo9pkO4DYf+h9LXZOTvwq5R4pcR?=
 =?us-ascii?Q?89CbS7GtFbLrzxBHi5uLotkbIUJB5/ZJ92Z207eqkSXPdidotJC3qcxxi+yk?=
 =?us-ascii?Q?GNdw3bN7KIp1b76T3vgWUvC8odqpu77ygyVRu+IfTwT81P0qoEcblbMV/uaX?=
 =?us-ascii?Q?Egjv5+4UT2y9Ws4a83SasdLOvArj6qJxS6ko9iTxOHSuoB9vEjYQea84k9D8?=
 =?us-ascii?Q?45Bu8lPO5DJgFX34TydCbHc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bd180c1a-5f6c-4145-43ce-08de063c2b6b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:27:43.2141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QRGztkv9kf4eifm913ltP/Hmg/bdHkXz+IhY6IpjSpRLtho4XMN2Jv7Bqqu1Ax9NsAnzBfDUa0hd5yoU4fAaOC0y6Mw2vXzDo2qF1rzGxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6097
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

According to commit 997786bbf473 ("drivers/net/airoha_eth: fix stalling
in package receiving") the minimal possible value of SYS_RX_ETH_BUFFER
is 4. Unfortunately it's too small for reliable ping.

Observations shows that SYS_RX_ETH_BUFFER must be at least 8.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 0ccab4f066f..baa3fc3f5de 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -43,6 +43,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
-- 
2.51.0

