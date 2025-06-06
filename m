Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A91C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D2482ADA;
	Fri,  6 Jun 2025 21:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gR1tP1u3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E617807B1; Fri,  6 Jun 2025 21:35:38 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6672881FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3oAJxuPJPGUB5TpohW+i1bpgajAimt6Cc7T9DEDRAPSqgoQsymYaA41/EitNMbm4L3pl4Vz46SlTBvvpjhkqhhe1hj3LLX0tD17drH5zTHWmUbqAOpzFCaPoRagxTs+JFVYt+WCe+qPpvEOG1X09mvWusEFjWbBXBsEYI4uFZO1J5MUl1qRo2IFZTGgwoDN8bwmduOFTP00R1D5Jik30wuK6ozrNYrNAVy2KN2ZgjmnDy2yyfXUGsLqFQVB2S5Wg0Lg0uD4hlZBgB1E8P12wnCuY2MgkF5ESlAiNlth1pXS6qL7/Qmz4KJJq4+V+PwjUIzvorMbo/1znSygbt5S8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwu4bfWR2FGtwOveCrwdR3sneiRalwl2E/kkQF15Bj4=;
 b=mEAGEf2MlX0jSGJR+wzNCTTXo9FHPxQ6qKkzOJQP9iG4APizPW6EMv145h1uK123RUJUn3LTllzAbwy4Va9N7NcfbdUgf9btztd2KmE0POiivLpyoDwrRO7B/jnzISItm4Q81ca5+TAmGWfVnBCyBexSR7ZNySo21oJeZXMI4bZyIiJPOEc/ZSj+Xs/2g2lLbCjumTBvlLRJm8BYFfRvKKETgzUngnPh2ikMQrXyeH7LOnHcpOxZCdRZuD4bP2RYtkKySpCIhVOfT19GMunQuUc89VNjJ7VnGaeecBpBXydTiC5jDR3B//UBbP97CBJ+7e/Mnjb9zS9eezLlpaq9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwu4bfWR2FGtwOveCrwdR3sneiRalwl2E/kkQF15Bj4=;
 b=gR1tP1u32wJQVq/ThKbvAFzF2EoYi3SMDamk5rHsKNt50JPjixpmtzO1G9mMFdnAhFuDSKY3Mz0qMbFRt7yEvC9VP/M96dktAOsqlSBgcZdXhPUY6KwDcgXyDmZ9oii5YKKHrDp1yI+SPwtP8D33rTgMPIqqSzoteJ+TpKrMJI5OjEpqdZ6Ny0/07PcmHingZ7OuBTn4JD829yK2YOlaxyOzh0r1G7D8WlGcUaF8uFhywgm8niX2hF3aCXy5zItqB9UtiwQBU71kKvVMnTvvYaHfYDK8LQCn8LO4LEY76VyRKjtQhYiMnVd5ip2eCseWrzCcDmCJcBeirSoBh6Nw7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 6 Jun
 2025 19:35:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:35:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/3] common/spl: fix potential out of buffer access in
 spl_fit_get_image_name function
Date: Fri,  6 Jun 2025 22:35:22 +0300
Message-ID: <20250606193524.458095-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: dc89e400-4a0a-4b29-601e-08dda5314e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VyUPqbOMHNtVgOz0MpAcU3i4TmsW0e16lrVznY4JxYhdeeazueLIADxCDDIQ?=
 =?us-ascii?Q?1azbDUYEXxM46eGSXqP2azr3xVWS+K/mzJ6u9PpgpykhZOfNpVYrbWXoa+9Z?=
 =?us-ascii?Q?Rqrlxts8R3Tw6wrqMWCI6t/Kp4ntoPuZ1rmAPTBg1CvAfx2fTUMKhcrvDxtd?=
 =?us-ascii?Q?gPzclDwI+y0oKR79dRhaHjXuvXJf6JX++uAw+eWbGNG/qzS0HJPRkB7TAquI?=
 =?us-ascii?Q?uZsXga2F+WIDhsSSpVq7p54t4qCpcvYwlTL8gPEFRxKjkv3QNYeh/PKxRCbw?=
 =?us-ascii?Q?QZ2FOXQiGpkcp0NSQmZArByMMZp6SB/pVdf+jRc/orIxrn4kG8Kbg9f3K9dn?=
 =?us-ascii?Q?3PfZj6S34AkXzVd5nw5sM8q6thzAp2+Nm4jZfwL23s0f/tU7vWjRGru2lhbS?=
 =?us-ascii?Q?CKQBO8jkg6hSHpN5EcPoGVTFFZLNBAVH/FI+wvdcX5wfpc0XDb77oIteLVpD?=
 =?us-ascii?Q?jj0iKIiJ52EEv5/OL19Y/2lQrsLto3IU1TqNeXAmyj19zxN5D0761IyEil7b?=
 =?us-ascii?Q?kOUv7mSAy6+w+p3ti+QjYZ3A0jk87tuFWvUc/UhWo63pIFSpy1iDaqbGfKvX?=
 =?us-ascii?Q?cgwwma/f34b1asJCbXSobVQCU702y033QOd70i1DYamtA14Lo27yq+Ryf5R7?=
 =?us-ascii?Q?IKmGQUzChhV+YrMvW0MvoC+D3Gfw+BW76t7Larz/8IhJYEgdiboUuaZ/3In4?=
 =?us-ascii?Q?A9nO2EtVe7B2ruLenCM2S9M4IIoFrBKLfUgXKHYSEPf1TOcffYfhR0KmpSYW?=
 =?us-ascii?Q?47fvXnyVJ6LIPp9TZODDChELgYK/9jjtF6SUN2Zc0+UJQdf4p/CTeKL4nTAf?=
 =?us-ascii?Q?EUxvAhgCdZuflx1mIMxzvghA2+4ZR5+YGz7tUcGqw0ugrBKmYO//XRXiMZUj?=
 =?us-ascii?Q?QniswtVWWYaQbcT7LCGShrgGC/x8tCAmkxK1u9Ox90nbhU5YHpfL92+fF5Yb?=
 =?us-ascii?Q?xZbBilkVvUj07R/Pg7AIh0x8azpDkYKn7ypor51hZZmBpzT37TgG3rD2Xl0I?=
 =?us-ascii?Q?8q504vuwmaNdcxnYaPT6eoPXLfvBnIcU/EDcv7SIABChjR4HfM/bQF1tknlE?=
 =?us-ascii?Q?1kFfGiV8Q4cFD5mOXwLgvS0kwjUuEdqgO2irW2vHaiClTlfkXxiqRsEdC2Ot?=
 =?us-ascii?Q?nTQNBzJWIjNzbjZHmxpA5X/Hi7zyJCNz22dZ0GuwYFy4iaMVUQSh9Bjoqfxq?=
 =?us-ascii?Q?qJM6qsE/rkMa0bUsFuphkMwUeOZzOobpd5As6zKYnqygW8RNXDoIeqJAPr+8?=
 =?us-ascii?Q?FuNell9w+hfG+sLH6Ni2BBJ7GSEOpeCGC1ogXzASqmsMaY6mA+u+gmC1F2EX?=
 =?us-ascii?Q?W3rhrttPmtmgkKqOjFS5I5HMSMF1LF1oDPMoKqM887ORB5YWRKteZ7mPGtEW?=
 =?us-ascii?Q?uzggw+z0XGPkVS0ZN12d6BYbMqTJfNFQJLr/CQogsWwpowzwi9Roiam1rM5g?=
 =?us-ascii?Q?oQmljg2+dnuSA6ioy3faNwcZBsUbA7IkZ5WnzRYzXeJocAZ/3Zmf5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uPKIaqpblqXkBeSkBWFhUPpsvPqL21okj2Wl7/cEdkZs9ihPsfzuzMv0dDry?=
 =?us-ascii?Q?VI/VX9nakgplVbTcRww3TLh5jZDE/DiIAIfdZNZGu4A4D0N3eFzGiV+PnZYV?=
 =?us-ascii?Q?pXjeSNNUud23zGAITG/JhlgveimYP86ANQ5u0DkvFkJvghHGagxQhjxOhTvf?=
 =?us-ascii?Q?PqubJ5CsW782+Qiy9nRCtI18z5vQhiUnX+dSL6MVeEucSAWcqSvu08Mob9ir?=
 =?us-ascii?Q?ikSfEQcxxrM+07LmY3i9b/7X4JjOW4n+mg8OYkq1LCC0649Ocag2bfYsSUEp?=
 =?us-ascii?Q?oq1P2c+m9BCj/vWheKNDDlc+XpgVy34aM/11CuOzSp/NoMzo/HMdw0ul5EED?=
 =?us-ascii?Q?YDJktKRpy66ogISqIR2i2P7ACQrAfAUOhSn3eFqQyHi5sq1fnhmHAoKxD8Tw?=
 =?us-ascii?Q?dMEzJWS4a92gQ+zwDjXYBgYw1pjMjN23U4P/HLVJgJOKDaBwfvoYN3NkkR6V?=
 =?us-ascii?Q?jqK02w2Ot7yN8EqChjtOmLLdqA6gtQ2WA+goCytscENawmiQxqKNwkFH83Cm?=
 =?us-ascii?Q?tZSMIzrDFpZTl8rwez28sOIbOapbOlW9mnPxL5sxiUX6AYh9Te2PjIJBEXG2?=
 =?us-ascii?Q?+q1yIauo+g4OQS6j2g7teVI8y1VaR3CRdiltzzv4M3vZfuqoEqLRPJBZc9P1?=
 =?us-ascii?Q?T/fpMJ5BhR9twEp1QU9nmQbt6QE95fFah5F/hxDpTAqmXHiZGwd5K03kfdcg?=
 =?us-ascii?Q?kBmUuUU0Hxr4gbmYReDp1Mscqg7QGoXZvNN+U6rTu8xPOPEqPBPjMro7z92p?=
 =?us-ascii?Q?ZNGPjhPMOdOait88pCQOH+dQbNSVPNcuPgCQQ2z5P42cC0pwd4WGG5mJCa0c?=
 =?us-ascii?Q?T3T4O6Uzirnromm4ctIYsZuLW/PG0hlRhVH5jGhH6n1jMilUIncseygOdIWH?=
 =?us-ascii?Q?DGTTEYNCPutiie3k8z2X9fqK6/9oiT5FfUquVTmYLqdlRtzRSPD9TjFiPggp?=
 =?us-ascii?Q?d23KKLghDTQ6m1UPSmeOMg6l53MmBcF/V8jXtM1BitbziT44yrU+FszA2DUr?=
 =?us-ascii?Q?DczpydC/Ee4aaJ8Y0HDgDrlHwvN27YDPjk9pLnOMENkuGgoGiqEj/aeJ4X1w?=
 =?us-ascii?Q?d1A0wUZliqnrIEtObm/snzBnmTLaRoFrUV55VQa9siVCUuGGHTtWuNw/6vgs?=
 =?us-ascii?Q?HDG0SqUM12nAkhrdb4faJ/oES/sgGuDnsH9B1p6NpDq8IcBe2T4Mjpk1RQvu?=
 =?us-ascii?Q?3McjxQPgWJGiN5asvFUKKwPPJOUh85X4Y7kQ9NH60ehjw72ysrA0OkyokWL4?=
 =?us-ascii?Q?PgnXFIovkIuqDykJcj35xdDJxy8gZCdz+Frqf4jhE1K9QETvORGBv6jwZXrP?=
 =?us-ascii?Q?IXJJGnJit00ZQJfUMTzmNXm+FoKn86rqlGXHnSPAVFD+rzWvBZBRLuPF5fCs?=
 =?us-ascii?Q?gCxQ9HopFXI0FzT+IjYdClNPGbxVYjMF9Ab5JV0PNQitUVvFq0be+moq0Dls?=
 =?us-ascii?Q?RLjnFSPl2FoZq3V2GavAvjeRDG7EzjAi5b26fb9es8+PBjTpCyKwaD91PQe8?=
 =?us-ascii?Q?4BRUqwPBeXfgA8SjzK5HcbS/1MNy1XOP+ErSwvir1s8Vok9vGKSvvOabeBHS?=
 =?us-ascii?Q?lJz61fcSeWixx4wEoR1b7Qp1IsDEudQB4f8C1lb/UqRI9NooMmwr1/NnwmyO?=
 =?us-ascii?Q?9dc/k3iQ9rd9bl0fWSzGpD4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dc89e400-4a0a-4b29-601e-08dda5314e12
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:35:34.1127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HMzZqzM2IU2UH80Dy89uuI79n+6rztnfB65c62AOsQzEH/hUUNdZR9x1Q/A2EhCOz7UXHZPjPCr9DNc+yeEyuBc3Qhvgam3UTd0jE8YpvI=
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

The current code have two issues:
1) ineffective NULL pointer check

	str = strchr(str, '\0') + 1
	if (!str || ...

   The str here will never be NULL (because we add 1 to result of strchr())

2) strchr() may go out of the buffer for the special forms of name variable.
   It's better use memchr() function here.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 86506d6905c..ab277bb2baa 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 
 	str = name;
 	for (i = 0; i < index; i++) {
-		str = strchr(str, '\0') + 1;
-		if (!str || (str - name >= len)) {
+		str = memchr(str, '\0', name + len - str);
+		if (!str) {
 			found = false;
 			break;
 		}
+		str++;
 	}
 
 	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {
-- 
2.47.2

