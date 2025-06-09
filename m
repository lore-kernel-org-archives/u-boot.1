Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD135C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953868144A;
	Mon,  9 Jun 2025 21:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uBQjDCuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3DE82BD6; Mon,  9 Jun 2025 21:46:16 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC1882B33
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i51L28Gk+i8XI3ebCQVcAUBynhYTMgwA7RWmbuerCfuEKHR9onC1PRx6HCikwJKBG8KIwJHTeeXgqXw8hXXNrReqN0s7P9xlIf/oaLhhBbvmevxfcXxWyrBZQKtEVOhISJK2pOqpeFqzRAT0IZQMxdP1Ndjw0tgRSLTtFDkh+F/d1LBtmGSH9Wlr9L/s7/YRe3aeS3/pIMTWCGtD8cKYfwOH/YiNvRS12mZMcXbPVXXdpRdVgHT69v6XJMMOmIm1w+B7VxZSFQoStfdGx1Evnco3ASpXaF+mROApOiq/RGvuV05qZFt+DHcQlPYXesjOGKzLYeP76/M9Ec0ayJ5c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSDTaRn2vIzO8sTpy56vni3OnDHjqZEulmga5AmlQR8=;
 b=XBTDnlwxKGghWU8B7KWkSieH44YdDOjbW0LuTfioTO04kqnSK/hAE2qxvF5mx6NeNmjWodpqL9B2Ipdh4U/A+eo/9TeLDralGx2ckDotyz5hvDGiKs/nrO703YlH7tr8wB0S5AO0Gpx6uoUuFtDZ4AC+VMP/V4OobkfCZxqkizu0AtQr8qj+InSl8mMUhaRVdQMvbAG2bdBUC2F69hQuciGZOq1YY9aqroOqzT6+6eWiqSApMpr2K2S9DwH0LBMkYHCesJvI67HFJ4cLiTPKiEbMUKO8YE12DtZO4wLiTxeYkopoMK/JyWXurJuEH7TjsozyENyqSyPOcYXZKwc4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSDTaRn2vIzO8sTpy56vni3OnDHjqZEulmga5AmlQR8=;
 b=uBQjDCuSPtNDdcqJHzWHla7cJIiq9Ct9dDvSLmKgzryLW9by2Y3TuZseBACdx1JJC0NeD2tioXxIcmS+fz/5r6J8p7HbP+LSU6yodjDTVbkl3HRv6dezmtjlxmreMnhb7rtQ2U6CrCWySAzWlm+adMA+juIjBgWYy4jkqYFdMhvFLVff85t7sU6DwzwjauxUAdvYAdAq5smcbgR4bWSTBwghnGYlBXx5fWfkDVXHw/sDOl169Qnof0wAtw0vnyFVU7PmixDMR3Ey0iJIBRSTLuko1xMF5NiXmXfTEc3GtXtaLhMlVeU5D7tON+FVTsBO6HQTokFFrjNl56tb8U1Jbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6047.eurprd08.prod.outlook.com (2603:10a6:102:e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Mon, 9 Jun
 2025 19:46:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Mon, 9 Jun 2025
 19:46:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 2/3] common/spl: handle properly images with bad checksum
Date: Mon,  9 Jun 2025 22:46:00 +0300
Message-ID: <20250609194601.987979-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250609164841.GU1382132@bill-the-cat>
 <20250609194601.987979-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: ca94d8da-d22b-4f90-2fe5-08dda78e48d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qiSD4ZIWEyCI5cnbzrdhaNVsib+UdiSGhoApIpftAHd67CC+t+5bYFkOi4Yy?=
 =?us-ascii?Q?f85eqEfGr5UUpcd5y/xCPB8QHud+3VLAP0yZA6lJigP2NZfdC9bDhg4zhz5y?=
 =?us-ascii?Q?eUzugTTxe9DR/2gUAF13aaUU2HUplPRFp2to3f09zMA8CZVqsfuFgEviVqsF?=
 =?us-ascii?Q?4/ZLp2SrD0k9+OrwUe3lPcZzoHPi5G+eC+9RRlrRB20tt9Dev3BKN46UufBv?=
 =?us-ascii?Q?JlooboYkM37EoxuiPbIsGINrorpnuK6JwwFEa1TVyaXAHAMTplH4M2inj8kW?=
 =?us-ascii?Q?5T5r7RUEU2DOFw9yv82G92nE8bc3n4cPJHcG+VF+MsP53/8ILw+aeTe1DaRR?=
 =?us-ascii?Q?ymI//5C9xkDcuqzAS/RE8g5sSvSHPpCzo6FJzHAh6WtySMoajJzxaijTj75h?=
 =?us-ascii?Q?wJW20CETmd9rPoMdBN3GZbT0D/i7Brp1HlFKUDk4d4386xAVjAhmSSHMadzj?=
 =?us-ascii?Q?Q4rcnQFVOv9QP32EozFN8QduhxnSlWaoFfz4GXOMv5NwxhLlNygU00vYRyD+?=
 =?us-ascii?Q?Jiiho0sPlCPT+ekd0U/hRMT2VEdK9OFG9aplXBgU+TQz9yAyHdKA8AHSmIVZ?=
 =?us-ascii?Q?e4wiitAW+MKOIecUO6c7m76jKPwWeEKAVNhf4JTt41etzWLMjuUBlkNTRYif?=
 =?us-ascii?Q?72RT8yozELrIactdWT2Ml25y1Q7fwUkBBn6ETMx9rIbEzBiZ1pIeiieS4nNr?=
 =?us-ascii?Q?LALBbE1p7mFUZrdlm8SFoc2WKAEq854mvUN1WsoGkdQQ4BUOMGz+8O6rwpqW?=
 =?us-ascii?Q?8iok6jCVbXkF3XhTJYtwqFV5oqHUO/SyJ8n8l7d7hdmXi15nr/tmqFPgOO3B?=
 =?us-ascii?Q?YczjU0OFat/GfqtjlfjOMyHpIQ1x5tx7AAEItN6Bxbn0jc2uQrmBjm1xp+jX?=
 =?us-ascii?Q?Vaa4K5+rWPf7SpM2Tt7A4u3bkmaXeHZAuSAd7w7CCZnMim9rWfqIHemaYxGV?=
 =?us-ascii?Q?Jq7FwvnE3uoDGf0/dYzlo/WhiB/bfbvQ1wDeJFwDaq7d7AN6bKCXQbNspW0e?=
 =?us-ascii?Q?qJU+CZe5cDOCIxItc/5DkeciiDOKsmUxrlp9QCv4FOeNH2vArh5zv11qBhyP?=
 =?us-ascii?Q?8BoSfWnuYJryOocgKeMb9dOuaFCSFmLgSC1QRfg6lKdGGL6nmwr9M/PUoEV2?=
 =?us-ascii?Q?DFFNy76xxkgDjKxMFKJRVlBsh5Ah4fNZVm4LXrQVZrwt52l9o0+JODkOdOl0?=
 =?us-ascii?Q?1FrglysIvg/db3DiBaBx5T0VXht1u5PX00Dn2vDmKJlnikTDOma0RYyZ8Q+3?=
 =?us-ascii?Q?ObvYra/GUveuUdRaW0f9XvGRjXfSrZy6kFIN+v5dz1ezRewYv58ZoE/SyBJH?=
 =?us-ascii?Q?nIWKk7wDkAu2zqafjFSopjkEs9GGPLV7KOZzblqvhv9GKKrYpZBG663oew4T?=
 =?us-ascii?Q?qa1yMtKH5jp6ZSQ/mcfBqSdDMDdglaaOtkR8v8fvc6Hi2MTQ4aa1+13QD95D?=
 =?us-ascii?Q?OCMl+v0a1pJd4MBqKOGdL/f7B3rptDpYHS57RkTCKLe+Gu4NGu1S/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4gDwDZwJqXnmyWWtD3ByHJs6lOTEYzsPHvZmFhsQOWRzwQ2Xmzclm2EE4ge?=
 =?us-ascii?Q?/x6IHTVlvKhMc566qqI1faoO3/a5MT+fZSEOVqhobh/Wj7jpeXtgDsC6yM1J?=
 =?us-ascii?Q?wol69eSAt34wFM33ag0gVN4wNhsZx/QODoNwh/lwhel6dlhnNx4/OHR117H5?=
 =?us-ascii?Q?hm230tKmOgKdQt8wfSxufYS0GCy3OwH98L3Gh2NF/xxs5Po4XRQAiLgMT/S3?=
 =?us-ascii?Q?MfThZDJR3Q2iWkJ1K2S4XZyc2DAY3nHWPYSuPM56d0ADwBrXp3wQ5JReZz98?=
 =?us-ascii?Q?zfI8vcIsiMQfjpgUg66GIz6laFho137RMtBMC6OWBgR+3PKwCQL1RoIIX+0x?=
 =?us-ascii?Q?jO4K9bHJUzF82LaU5SCnSVoYApEU3y4MhFIAXQVawgaQxS/AAGf6ctOKfqr+?=
 =?us-ascii?Q?qg6r1zHzQeH9x1ehv65N6boqIm7yL9Sj4lhr0eeod56t2I7LFbd/EmrucdNu?=
 =?us-ascii?Q?s324ealVfjZsIakD0p84YOdEDCpO4hxtOpcAexWfFUxO23lN8obf+55m5NLV?=
 =?us-ascii?Q?jh4HqD3XZuVw53QLgSdR9gQ7wwoAkSf31sHEuS5zSCei+9mR/hN9V3Jb2lsw?=
 =?us-ascii?Q?ocIx7ZDXEqS9+9pyi1+ROAiv4TvQO6h6UOs/RKul4bnneWLl2YRqgOmi4gBZ?=
 =?us-ascii?Q?qVTJHi6FuXIb4Pgvl1Hr4N8sdmFJTaLPTAt4u5Jk2hsZqcSSiFB1XrEaVj5i?=
 =?us-ascii?Q?l0U7GoFB+x4O2hBiTug9p6d0ze5tz6nFp8P7U4oi0kNX5E92jHnGcSadPtbT?=
 =?us-ascii?Q?mt/OGUSu9qGXT24df2MzjYw0czNIe8W12MKUwCaKZD0yBvo9BVLGWZw3+kMx?=
 =?us-ascii?Q?sBIVojXlepqdKfiLFpN1PfpV2cnm/I2dg4TcbVKO3QkuWutsbO75ZjJVrUPI?=
 =?us-ascii?Q?kAa5EYAU//bBbb3uERgylahJRxd08ScrlSYgqjqn8Le2zckAAWUj8TOZG361?=
 =?us-ascii?Q?v4L5lk3NhV5QBxP9hm0RcwPIjUHhnLDJrCY7F9ICUbRU5zB8P0Rgpb3yDCk7?=
 =?us-ascii?Q?Nr4HuH0K3Apicmo0EJIMayfVRHzsLAuSYUNSPLHVWkawImG2IRgbcH7OcGg0?=
 =?us-ascii?Q?6+gcNseXljyJmzhuyqxQPDTDLPPW0eGU2W11JRbtEmhvUMyKH31z2FG5/pai?=
 =?us-ascii?Q?ykdx4jTbDUdbWF4R7v7c/7LkF6F7Hi7yI8qBD1XNu9nJY1OksfcoAPaK9dc+?=
 =?us-ascii?Q?nI8t4wx8CMpbXn1xbFksH9vbMd7F1lNSpr3G7DuaUzcKCa1muL7lEVTIKP8a?=
 =?us-ascii?Q?m8HlaCwyhuNnw7On/dtoRl5u7DGK836rVID7STbnbMJFPab4q3P17jTaoaUl?=
 =?us-ascii?Q?jf5h94tj9HAZVnx6Fy3tbwlLPcIeJpPmHA5KuV4yiKimrdNmCdDfbpOgimMN?=
 =?us-ascii?Q?qilpuiSFxrpkunJFZU6PSxyMltdavoC8Z9Y/TVTMrynDy00sJkuj6rQG9EwP?=
 =?us-ascii?Q?7e4HD9BAspMw1yGTnSA/sj3dqvz61WRYhbwu+VNz7e/De6OEQzWDcforGNue?=
 =?us-ascii?Q?MLopVlbjLBO2ML8stAJ0iNwuNR31x8dvaGVOdXH8pnRILApEYnVj5f7CEAbQ?=
 =?us-ascii?Q?CBzLdFjuXN+dq5rLt7Bl8T2agHqJz4Yw0MEp4v5RCWXxv8+/59PiZBfUp819?=
 =?us-ascii?Q?aFNxPsmj++OkRnHVOjpQhBQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ca94d8da-d22b-4f90-2fe5-08dda78e48d1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:46:10.7434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UmTATCb5Mz+HNIvFuU1ihkl4lLFWamJKjm+ubhtSZku3G49kh174mgVfUOmrSmMMF1BgZa/iFp8fgMzP0nux6c4QDT1a07WJpWAI44Uf08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6047
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
board bricking.

This patch fixes commit 873112db9ce68c38984ff25808dde726f8dd5573
("spl: Support selecting images based on phase in simple FIT")
by replacing EPERM with EBADSLT places where it should be done.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ab277bb2baa..321954a1547 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -200,7 +200,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  *		the image gets loaded to the address pointed to by the
  *		load_addr member in this struct, if load_addr is not 0
  *
- * Return:	0 on success, -EPERM if this image is not the correct phase
+ * Return:	0 on success, -EBADSLT if this image is not the correct phase
  * (for CONFIG_BOOTMETH_VBE_SIMPLE_FW), or another negative error number on
  * other error.
  */
@@ -236,7 +236,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return ret;
 		} else {
 			log_debug("- phase mismatch, skipping this image\n");
-			return -EPERM;
+			return -EBADSLT;
 		}
 	}
 
@@ -475,7 +475,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			image_info.load_addr = (ulong)tmpbuffer;
 			ret = load_simple_fit(info, offset, ctx, node,
 					      &image_info);
-			if (ret == -EPERM)
+			if (ret == -EBADSLT)
 				continue;
 			else if (ret < 0)
 				break;
@@ -835,7 +835,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 		image_info.load_addr = 0;
 		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
-		if (ret < 0 && ret != -EPERM) {
+		if (ret < 0 && ret != -EBADSLT) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
 			return ret;
-- 
2.47.2

