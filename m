Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DAC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 10:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DB08773C;
	Wed,  3 Jan 2024 11:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="f9cguvV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF799876A6; Wed,  3 Jan 2024 11:47:28 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2389871CE
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 11:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSp3keFgnHZanNOtAYDai6k4/ZW/L/zuBugkv4WHpYXWs2EwXQsH6RXBqWbxqa0ZrPfDaQl5SHDe4VRl57nC/SZ4Pa/Ec0sFFfCNf7Ug/flieLidqLWiMpPs4hh89E5kcWMXJf7gHbNtZ4WhNMiFBj4MU+thvqw482x3ziRVZn3jpuRrJqz/1x6+sjcrKCh282l9Buw5HvEg6E2X/zyrgDWg22Wsu4zffqYctwTbLa9hnZWiuqlhW2rkYuDHrexILJ1eVipRk3qh1kuHCluJPwvk3kCZiq3bF55yycld0nkHE6JoayUKlh8dHSCHnzizqyuqX5ynpFieAwov2JSKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSW2tEvxyQsqHf0hHTFKa1MOkAngmwALq/CqtSW1MAI=;
 b=oZKbetQASIo0ex4cAYMzgE+X7iPk3rSIwGULXLeKo/Won40fyhXh3J1VNHE1N0r2vvlJ4otjwf4ZDlD+QM+SdXesD5K10t8K2NE7oDqLF1KVgkRlkZHRpxH3C+2tdsOBu3C63rWBUiygxarvwVBjMtumwQfoMCeWHo8IdaIGFKrxqKWRHDyaPlYxqZVpc/qn6uTNuCiydaa+j7Xh/r/XYah8SmWvvDCZC9XyQAvAIwH/iXvvqB3zjzGjnbKjj9QBF2KnGo2vzHOuxqvAcQfaEZl/LpYFB3T2XMrdw7+3By2FV/umYK0JDdiQ1gRb1zcnD0uDOTRxwGyvHR3s07UaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSW2tEvxyQsqHf0hHTFKa1MOkAngmwALq/CqtSW1MAI=;
 b=f9cguvV+qUJP76kdj8DPMy2E0lPRmcEUrNtBJB19BpOPrTiUC8JjTbQzSt9ifOJft3CK0ODmDRv0UgPOWMI9nIDxhD3jk8DU3QOO37u+4cRJB2oz7G1U9q/1MXIgJF06Njg2p/XjS+zaldDC8KHPGM5kMWp60reA5wuxHiUMc6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:47:24 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 10:47:24 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 8/8] doc: drop references to non-existing
 CONFIG_MEM_SUPPORT_64BIT_DATA
Date: Wed,  3 Jan 2024 11:47:10 +0100
Message-Id: <20240103104710.4185383-9-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
References: <20240103104710.4185383-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3743:EE_
X-MS-Office365-Filtering-Correlation-Id: dde2a299-6fc2-4731-bb94-08dc0c495ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKo0lrremkg9b6Vgc+VmHq+CyQWzpJVHvi1K0eMqvZiPS/7tkrhxkybiAmXYzi+uiIKq4leDWD7Nx6SVkgaP+Qxb/Nmcj8fa6CK/5B6OUHxk/yZCMolpKkTAWyOCMKFtbECIlvxbNx8dLm1+t12Zvd7dpRHdIrYe3BxFZMD2fQrbKe1O8Nw+BC3co54ua6qSNG6I3RvVKP4uJqQSavnG9oOh3aR8Oe/Pn5fx4SJDLnj5yE5MQjZiVxsqS6Zy9qoB/Vo5S8kRNrVBPCi+2c1eXDnitLabfxXL0q339K7188YbMr2ar6nH1m6n9RYkLugcFVlpJvRCq0GeP4RysxxI6H7UuCuUs292H2f8WQJjDjvqavO3HWB4thaFv+F6ECJBa1MQx52aYyy7jHdgRINVHKUZVNes7dwPpDAjDnvmFrgyde77V5a5x2ijHDZ8/4Mju1aCofovudQ9I2fdLZFAiWYfkXGuhcC7XMQHDP09Cxpn/DCqigZdWTcgleDb6BuoCWzYCBnarBb1eBndHJrFig+FF8soMaA6A7LKCre5Pl/UeBqR95olFKEDWwqX+sMx4xRhQYU+MP9bgmFNRLNNLuRFjHgQmsKbZzOlsSL1Jv+oDSpLESROnkn3TFS17ZOd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39840400004)(376002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8936002)(316002)(8676002)(6486002)(8976002)(4326008)(478600001)(66556008)(66946007)(66476007)(6916009)(54906003)(83380400001)(6512007)(6506007)(6666004)(52116002)(2616005)(1076003)(26005)(107886003)(44832011)(2906002)(41300700001)(5660300002)(38350700005)(36756003)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i41cYhlL1S3nwsyCwWT9cNRIgYHCDX11XyY38l52zOATq0hRSb5CF25PEfwp?=
 =?us-ascii?Q?NkLqOOobuO1CrPl6cl9fZjVTfwNnrSKosXSL6KKXH6MunHfgyUs3Xaxkk/nx?=
 =?us-ascii?Q?tuS4AdJiQ/7JXUot2t3Zw4waW0oxXN+2rUGo1iXDLGZMIp0aQPGRWX7Gyu71?=
 =?us-ascii?Q?btPW0NTmMqMZAr0LhjRcPPYE7+MNefKXq0LKD2Ucc0SSe8s7mBoPiGgrdrxs?=
 =?us-ascii?Q?MQ+9KOd9x4uH/QIC5D0z21Ni7ruAmd2oNHd8Q0R4USHnXXijHYuw+eRtN3kw?=
 =?us-ascii?Q?JK9ME5g2LSaRvQJW5WlZXXRZht5XXYaPlkGrQpOx4NlqahS9w4J1I3ju0I2s?=
 =?us-ascii?Q?/Lm4iEmitObqU+kx2tkEa9h86Ry9WGkXDwO3gk3gLji2AE9r18VB9N0bG+tb?=
 =?us-ascii?Q?hZ/De0IhtuPPgBRpmV2A3J8CSESOzd/q/oH5s5yMlS262LWckNsE+UHYPwcb?=
 =?us-ascii?Q?aK64cgZbEomu31P/di0rrhUBbpZOaue/tttGMfL/5M+FKiXibxDYLlNy4E9O?=
 =?us-ascii?Q?aq1YKmQZD0CwBuHhn1hDAO2KZUr9WOBC/255zun/VFo/g/oZXMqItm//8dFD?=
 =?us-ascii?Q?Clr4fcl9WWREhrpW787hIPp2Zgc9n/DeQwNEKR/vMjBI2xbwpnA3n25dguQ7?=
 =?us-ascii?Q?vPRKnqJdkMKsc2+kFs8DfciwEpSvTfnqqBrnwqTSJI7ceoDdW8qP8rye6X6M?=
 =?us-ascii?Q?jYXPizT8D9l4O3bU7bmWxsLpEArBX2k6z2fXvji3x+/+6bGmPa2IuQyWBIM6?=
 =?us-ascii?Q?/rbdHINBD2TLZPZLzXQmau26fBLDo/tvO8M62E/cUrBzCtXVDNfZ3kSDv6F6?=
 =?us-ascii?Q?ilgL83DohsWrcySmFldqTN5TPdDUMtC3SJ5E2UDdNeCuNGNu/IIowkt1kQyP?=
 =?us-ascii?Q?MNJsU5qZEBPq2UVVLuYPLtVqH9f6IWpikLiT5jrYg4R6aI5k+mZo/pfLTToG?=
 =?us-ascii?Q?PyIOFX4S54TvDaWgGWU+ineys45NxGR4DzMdGb9zSAqiUXCZ/02hFZna0EJJ?=
 =?us-ascii?Q?S1u3J2NUG9zyqNoUCb6Zr0nG+ODBVo1Msdmh7tr2l03D3oPtUsl/lu2dTVoT?=
 =?us-ascii?Q?fWYtMVSiNYPu96oglA3FfvwdsQtnye8t0iSE03jnwEhsYO2EYCng3IkALRLp?=
 =?us-ascii?Q?7wlHHuZABA3PFe4sYTk8K2zs7BzLwEKRAE2rZ7CQFsrwISJzdGRD6+nliUj6?=
 =?us-ascii?Q?x0YT8DpdmN42Yk/jnu2PCLBy752CrewyPb4OWjFplgFbyQhbPU0dEHFWeIoW?=
 =?us-ascii?Q?TUqLdjnqcBC8f1XPsLciZrZjzAL/vEAyLtUXSHDnHoolCa/la1KwxPbeRajg?=
 =?us-ascii?Q?FhcUiZLD5MXiOzK6HvvWwxtBYEIX9Sc7YPEl3R85x0YEx2vutbYfHIVXjK+q?=
 =?us-ascii?Q?RCTbEUHFRYyHnlDPHDpd3COLZFwJ2KJPnbmNfKLtx7lpyDttRSpjdSTfJZ5v?=
 =?us-ascii?Q?kEXyNFSOM1wTVRNPFVIPOsLe1u6N/pdN3CbK8yK/jGIi3qQH/MHib9EEsiET?=
 =?us-ascii?Q?sZluZlCW/s3+f6tApKgLFACtd9+EF33X88NsY4XLbzF1Zgtc/4pKakB+DP/X?=
 =?us-ascii?Q?CV0B4yJE9z1OC5A5vAyoF3LnzzDrpg8UO/rbrMkwl+CyJed9h01jUdYK1b9h?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: dde2a299-6fc2-4731-bb94-08dc0c495ef9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:47:24.7172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy4OjdTYuDwUt3Zr0NcJaN8ka8Ii/RF8/NODnAeyM+PKNYvl+KbKDP/Iz5JeuYa5RJcbkrnyvUlp6ud51fBlggT4AyG2PnmOSNKI+/9i8HY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3743
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

Such a config option does not exist. Rephrase, and avoid mentioning
MEM_SUPPORT_64BIT_DATA, which is an implementation detail.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 doc/usage/cmd/cmp.rst | 2 +-
 doc/usage/cmd/cp.rst  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/usage/cmd/cmp.rst b/doc/usage/cmd/cmp.rst
index 8d196ee5786..66865ebd7ee 100644
--- a/doc/usage/cmd/cmp.rst
+++ b/doc/usage/cmd/cmp.rst
@@ -96,7 +96,7 @@ Configuration
 -------------
 
 The cmp command is only available if CONFIG_CMD_MEMORY=y. The cmp.q command is
-only available if additionally CONFIG_MEM_SUPPORT_64BIT_DATA=y.
+only available on 64-bit targets.
 
 Return value
 ------------
diff --git a/doc/usage/cmd/cp.rst b/doc/usage/cmd/cp.rst
index 67360e30e41..bea379ff360 100644
--- a/doc/usage/cmd/cp.rst
+++ b/doc/usage/cmd/cp.rst
@@ -74,7 +74,7 @@ Configuration
 -------------
 
 The cp command is available if CONFIG_CMD_MEMORY=y. Support for 64 bit words
-(cp.q) depends on CONFIG_MEM_SUPPORT_64BIT_DATA=y. Copying to flash depends on
+(cp.q) is only available on 64-bit targets. Copying to flash depends on
 CONFIG_MTD_NOR_FLASH=y.
 
 Return value
-- 
2.40.1.1.g1c60b9335d

