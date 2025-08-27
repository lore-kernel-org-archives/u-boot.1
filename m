Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B1FCA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2408323A;
	Wed, 27 Aug 2025 16:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3851583189; Wed, 27 Aug 2025 05:13:02 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99918313F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 05:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi+fSPbFa/MkqhlIiKU324wePzko+QbzgRQcI8d9sNydP8pXvDx6SBbDlA+XjnZeX3tpNUzsyHsjSI2BPIU8w0ez0Bzpupw/NJqU4fcaoXSo1VD1uyspFI49pGtOY6EgIxJoAck568fAr/J1DNNcT/x6eKm6sK+9aIqfmMY03Ym474Lag9iIz7xOcgF+yLcgFUxv2mRX1RyQs1j9vBk5NXLCaaim3AD+oLMwQekqmQ/O1vP2Yig+DEg2sQC3lTyDjKg7MU9idf1tyapuH2AzmkLwzHcI8AIZWlJq6ZdZ4inpPV0Xe5L7c5srxcGuvhmlICzX+wYTu1HUa1x9pzt2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0M3M0tqV1Rffru1BYXYHzRBCxFGQgbhgU0zkKTxCOKg=;
 b=nH/J6K2ITbJs3UXXjMm61/Fj2zTGuYxUVKDK7RigfQu0AUtBvUJSzCKaDVTMr8EA/guexB3a7l9Yql0L8raxOKjJMDKye1d95nmxmk1W0C0CzFAmD/ILbUfbnWzFSslRSgi759rsg9qr17nZYwyIwJ4Gf3TAsD/5XWcTX+udtYi9P9624Nu9T6WWbUgnxSbfoGU+YOaD6HgzvnZmuDZXJd+01gq0t5bUJB5FGxKONvZsU/epWvQiVjbUzCl+0BE3mCjwmO4Jb6vNd/cE3Ztp2K22dv6YvfhX+zHSenallTSTY7gfM6iu32zxFCDvMZkURU+5rwpCN/4C3vtdFbO7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.32; Wed, 27 Aug
 2025 03:12:53 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.030; Wed, 27 Aug 2025
 03:12:53 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1] pcie: starfive: Fix the incorrect use of dev_err()
Date: Wed, 27 Aug 2025 11:11:56 +0800
Message-ID: <20250827031156.109432-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::19) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9bf1f3-487c-4863-6fef-08dde5179cd4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: 3/kSwTNMoBemaWMqZuvxxKpwxWTu8asQ8HjTapue2XzUkyjEKKt8sZzCT+kadqwHrMuOy2z6SjQ3Hi2PANZUFh0m++8xPDvTyZjQDi6zZOUM5ur6AbHcym/SqcF/RaP+FHQ6HGwKrEOrt06lXKGlaE562X4/irz+yrKv/asPWN6OM+zV4s3mbvZ+KklbiLoi0uOD2dOuIZwsZ2f4taAsprrRNuWeEKrwiOC4ZXSC77fRzAvTbLRoIgLyO1s4AA4jqD+fcCdrnREWTQPrnxQisYWykZxYUeivA4QhHBC8NHEMKhOgzvE6uCEn6UcagJo7U5b0vPB8vJHV+qQPQS1c7GmyqByFS8lBJM4Ym5efQQIuifFIXu8EYQa2eV7gDNOg5HNS1R1c/s4Y87Hbge5lTwXCVrpDir486hBX9rqzkfvlfPHOe8zJ9+QEAs/1Ti9WVzW7atZlTiFzR+I5p3ON3dIkTCMPsOspVKTxftd2Z9KFHqRHcMZfSkTEAGEQLX3fdpj7/isnoI/M2eN0MIYUDLMS73SrleEBPXqqoCRf+8IDDa4wovLKB6drMQBAid6tPvV4JWgcIImBRj59236odtcLdFc+cZaEHGvuAxWgOfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YNpV26pTyWDvt7Tz36rPTQ0/zLA8Um4q7+j+uTbCJjFXNWXQ4F5Yxn/jtlKB?=
 =?us-ascii?Q?63nQvMFVCy6mCEsTZINnFIRodfybsNTUoGqeiuI6DKVepXt0ES3YourJQOE9?=
 =?us-ascii?Q?y76To1UmTCS42DWCJCifKXz3FCFqRGqsL7hWUZUJPqDu0Mlnv5NMX+SuALBA?=
 =?us-ascii?Q?hD1l5U2jzdnlfepW597jM1T1HO1A4jGpd4R8wPqQTcKb8CAtXstxYjXExo9A?=
 =?us-ascii?Q?MLmP1VsFExYvFTFmST4KElTtRt1jSAu1jhax8kEdnbRmwK1dVSkw05ThVW6B?=
 =?us-ascii?Q?yEheDDbzlGWESYXHY1u4OvqLCBVYhqPluRdQTWErccfxKwTc+erVSRfYfUGx?=
 =?us-ascii?Q?3+sv+4UfkNdfGLAif2+AAHEpK3CfyrWurf9ndbGHdOfnYwshlMcEVBZ1Fi5s?=
 =?us-ascii?Q?Qovhi6ZXui1wyy1SLnwlNhDtyQlyPuZFor93Pl3LRHrQt/gbCCUCKBahawV8?=
 =?us-ascii?Q?u4mG4QL+P+4+TMNMF5xd+pWiiP/9297XAPdZ1NEeQTrvhH9TGd0k8DY4LmBV?=
 =?us-ascii?Q?hmw6myRs/CtXPnU+ZjsJxy0pT8DQDbwWnmc6bv8WnrneyVN+n+uQfaHNVHoH?=
 =?us-ascii?Q?uB0/gfYQPB8rEUyjf7pwYAsb71XfZwucAoeqAExLAyg54vtbLgTXkOQeosNh?=
 =?us-ascii?Q?weDyPianhebdq1xDayEj5Br/WjLol/1ubLX/iSGbFGSTZvhjh4kNKNYAAIvj?=
 =?us-ascii?Q?AnJC6ov8HBUom6l/m/JmbS8zqMcPXI3wAE0xYLaWMa6Bx1QW6Ae6iCPcvd/W?=
 =?us-ascii?Q?XSTFtyuAgPB4MDflvNiZORG5J05E5+pztnNSmuJmH3l952K3XfzgNUFFAliM?=
 =?us-ascii?Q?M0IHuflxMVbmFt9kGT1w9ACeWOjQiwB0AR0YiSHLyw/ZQEwiqF/plVIZc7dX?=
 =?us-ascii?Q?/OF/p9M5r3QBJ1VY/EY2E5Cc6s6suwslmiVQC/dJT2S8EslSMin/F1EtcvFd?=
 =?us-ascii?Q?y2j1rI6YGpzHfEG4nVYT6ob94zD5UQ5kCFVK1J4ntoANwc6+f2Y16ZoKr7V0?=
 =?us-ascii?Q?22LI4eofi+D0HLUaSANN0XrxdvmgwwGg6Vn6kbjS0qUicBzzecdAttZLoPPy?=
 =?us-ascii?Q?hq3N+3ZRR+HKGcuFt5lbZBhIf9T34c/bnf+LpD+GO3z96kQ8p8R19T9KjVKs?=
 =?us-ascii?Q?EPUqAyuWIo8ZKOSqQRjprSYh6VJfV0iCpBb0e0s/ow2YpRTwidUa2OpUdsr4?=
 =?us-ascii?Q?Pdndswi6S/ZgozB8ZsLk9CfMPI9E3eXy446UTbNGRF0P2u8/PSvTxBrx4KL9?=
 =?us-ascii?Q?fC/XlN8rnb2HPzpDisTGiShtqcz48qtVZskxgjROMWHk5pg7vaW7/Aqu64zR?=
 =?us-ascii?Q?VH55l71VV35BlDkMJC/nFXQgqTwQe3veTS6q+V1a1yTMvGnXHWjlYthe1quW?=
 =?us-ascii?Q?/diSdoGV2h7dQEDFXwsCZBDLdEZSsBN0e5H+qXMClSiEdb4Tto5+9fGCmIE2?=
 =?us-ascii?Q?lSKxHK+LCBMG2wuoKE2hRPJJjoUorSJCU13/YsG9NdKTq4D3hyOIGEhNAeaK?=
 =?us-ascii?Q?9S7/yfJNA3U0XHKV338jU2sjnRBr2NlHhFg/SQTCHJL9iTXAVQLRbyWVprVd?=
 =?us-ascii?Q?MP4LdNMeZ0AoLvo54NN+0huD6aGNB6YGq4l6LEpD7U5of42x3fOV2L0fa5Kr?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9bf1f3-487c-4863-6fef-08dde5179cd4
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:12:53.6428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FfI+gAazwE7ph2r2aeMhItYZpiaZHVrwKiBor9JpY7l7Pqk0h84W8w433+CvXK/+lwk9xudQf3qVfoxwFMHcMCNCgpFVNW02OIDiRSeQh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Wed, 27 Aug 2025 16:25:23 +0200
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

Use dev_info() instead of dev_err() when finishing the probe function.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/pci/pcie_starfive_jh7110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
index 51aca7359ff..f2256307ab3 100644
--- a/drivers/pci/pcie_starfive_jh7110.c
+++ b/drivers/pci/pcie_starfive_jh7110.c
@@ -292,7 +292,7 @@ static int starfive_pcie_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	dev_err(dev, "Starfive PCIe bus probed.\n");
+	dev_info(dev, "StarFive PCIe bus probed\n");
 
 	return 0;
 }

base-commit: 3dc5e9a0108bb114175b6362f9cb22367402f624
-- 
2.43.2

