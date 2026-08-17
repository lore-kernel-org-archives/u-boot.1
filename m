Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE15C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 03:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA31480D0B;
	Mon, 17 Aug 2026 03:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KTPVWrZm7Xnk; Mon, 17 Aug 2026 03:22:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C75B280D93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786936938;
	bh=N/MLMudzTttQoVL3AuNtztzBONKZeBsyMYV3JQxLY9Q=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=fZEvwadyRnW8v14MZjIa+idtJCKow4gtV3h7N23Dxp04RlFKuxDfuO5dm1o5yWpbd
	 3+DS2GuNALyEHmzSVROpe1oqgbnuzB+Dq7bb9bdRliPtJ0lMu1reiOf3S3k9g8PU0G
	 gM5YM5PKhWal6F14vQwiz/ix8QsyiohiKCcXbsMKtZNw+Iv5l4qqQU5Y/kn/fCKItw
	 wSpGBbNGdUtmB/GidjAQiacN3HAvjly8NfGIntuU2RNzSjxZcS8pizxol6RnMDZVs5
	 5Kb7YLP8qlyqxsGm+Bekw5dRj2qM2Al2cbyo+QzlpDg/GWlMlXlnWSBbCoCV/mACpQ
	 X0YzVHU4z9tqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C75B280D93;
	Mon, 17 Aug 2026 03:22:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27D442EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 03:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1968B4065B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 03:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iudsH7po7eeO for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 03:22:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=boon.khai.ng@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0705D405DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0705D405DD
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0705D405DD
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 03:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBhwKq6Rvm2L8/1YxYKuJL0LVi1FH6sszhrvYYcahqahHYou+EpH9vLk6CxnHA1Lokv7WZw5zECk1HGPfgtgjsydTSj7TPujGOhU30aSZ2c+K+6ZYjBo0aJCSZlwdHkVweuUF/P9BJekBto1OAwQ81zzRmQ8azLduQLhZd7jnLLiD72IM6Js/dYH5EutoMP6eqa9BPC3USoAtrbN/95zOMwF+szhjP7/LJRxDIwU7BaCrfSV7RCbiIZ2+a+Gy2H3UeOkhzVP4ugaM64xGdivLjvKoebsEgtv6hAAiWg11WEV9n5gayh8D1pqyUCWJDkB3Cyoyzwo7rDml8aRndlHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/MLMudzTttQoVL3AuNtztzBONKZeBsyMYV3JQxLY9Q=;
 b=uuGxkAY/AwoPP0ck8B6A8LsuxM8VBl7743d1a//56qSK5p3PDnZmBsX2ynv3BInTRMR0+Z6STmA/VFki3PGG+UQxTJ1BD7/TZFkorbeDGKP89qt8ldJipNPGmzolsU2GCyPy6iVqTwKLMJEUCMi1pSPP68ke9JbnYX8pfn4YvuoTtVeNY3syNy+xNFUb39DmSpHmE8Skbb8foHbXBP7IOemJ33IHWzGU3b8ziRuLSgTukPrn55Eu2I63aLUkDrk8gNq/tHaUEWkZMGhtKJh+FFnkjB31OFxAcAFd+T8hMaCPtnQxeC7DOf8X/WDVIzqqZINqXkJWZN/i0mYn34LxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH9PR03MB470143.namprd03.prod.outlook.com (2603:10b6:510:3ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:22:13 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:22:13 +0000
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2] include: configs: socfpga: Add environment variables for
 distro boot
Date: Mon, 17 Aug 2026 11:21:52 +0800
Message-ID: <20260817032152.30718-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|PH9PR03MB470143:EE_
X-MS-Office365-Filtering-Correlation-Id: 8068f5a5-6174-43ae-d36b-08defc0eba7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|18002099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info: YuQ9DAcIjbT6IPU5trLA6OzvYnRebn9ibNdYe1XYzp3GV1OcIW5t6k77hlLJRzqpEXlvdk2Mzr1mHK7l0gS3P7+Wn/CmlsEyY4LTzD69B8ym/d29ByegcnCEviwQd+ZHke3yGoJNkD3CeKQl29+0RyV3TQGvQS5R98bHk4jGnq/bpTkUWrhik1aUGGELdcbtbUZJlT9gDz9trdA9A3D0A8OGi/1H3jBocN1nPzy182C82c8T5nIkadwy9drmvEE/nPs+LE4r8DNVHvvxcVbM67YZ/oroK+exgN7yIP0GW/Np1GWI4bJO8zuR/jQ8YHPo+2taqh1GtEF7uzQ5ci3esa7SG5qoKzv2LgnfXF+8m1CyAhV/GJxJS0gUr8/iQ/67+DmS9SikxCaYYXMWVzYJq8MRHv0gz1ek5XUOWTvu7gxrP9mO2HZlu/2s5FAiapNliszPNNGCUbLpqN8gT5YpVj0HVQ+1IrLxvr5Wi6IkHyrDj811pSe8St2mUfNsWok+7ifxhnSM7SB9O9PW6pgLcrchnUbqYFdtI2WSH8ZTBLvqCsg1978/OZgj3jyDiGT+IYIiK+wOdYb2bdUNKLV3nWejuBKsLRGD36Ygckf6+QVZy835jUf+nq0ch7LWNjiK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(18002099003)(55112099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtagmpVp3Tae8UzOBFRutpgCVgT0ucKMvUlZxR3QDRJdGBqcbO1DXKP9wEWC?=
 =?us-ascii?Q?Wol5FreYyyiYMJVTqmlw6DqUM6U6jwzI0OHg7l0c0OK0VrstbDzvNlKQ+ula?=
 =?us-ascii?Q?ozRTwx8wgHNfvb/J/qXPdfQxXl+u1YFlrYiYg7D1B961WOTsqcgbe7JHGxUp?=
 =?us-ascii?Q?kzxEWxeyZK7TngDtmlGXeyFBH2elrazccgvxoXI4lRYrt2Arj0JmQmtlpaMB?=
 =?us-ascii?Q?Bq1+eR+JEPYx2mnhw/OXZJ9Y7c2EmJydtOTh4C5+Mfh8heWRCn1NtoUoMEpO?=
 =?us-ascii?Q?W2krosEBqY2zBg5k+FJkHZEW9EjhGU5mH9J+9CTlHX3YvX3jToh8XJ783/jf?=
 =?us-ascii?Q?JV0d//+geNAD/SIlgcfXG4I+c+7hk0U9LLo7X67k+mY1bx+EyNsOZX4HApK5?=
 =?us-ascii?Q?kFao4qGrToFyzRFQDWVDO0L1ckYLpYAMJUkR/shIDcLwkAbNptQ4lnU1dkz/?=
 =?us-ascii?Q?pIzNfQVDbwbfx3AIdk6Xn/hYKW3/qmh/DqqRQTa5Y0b1wq5Mj9iZOn2MKX4k?=
 =?us-ascii?Q?UVgCj3dld0mbNjaq7zJSS4zjbA0R4Uy6YQpFGAmUNqaPVAWIFpPOtGlHrdbr?=
 =?us-ascii?Q?gPLsCEocBPSJxVazIltVQc6F9pRFyNp0JjFCwB+OunyEDUe8UulHeS9FZLJA?=
 =?us-ascii?Q?USFeqZ1BmS0j62bVHkzuG6lm2zO55JKbCHzZlTFjOkjMu1xU8ZPvk542YbX+?=
 =?us-ascii?Q?tQl7WJ82alFTU05Psg9hn9xazq+iLN0CFxvW+Vqe0GJiz9CVLQG0oL6HkalH?=
 =?us-ascii?Q?LhJeIngNvmUHrJPdBexn7icpKoy2llnstOMH6FrBMw/GtPsWJKnCq8fvtgrl?=
 =?us-ascii?Q?vp2QEnjoytnXhCQZobYGaLQoI95Ay3blp84OrGC0EMd/dYEPcF85Cu9iuX3n?=
 =?us-ascii?Q?AppoLwxb34N8Li8Y6vYlUNyiPS43FD2gIUgxO7vYXBJTuyLrU7P5us+wYzXa?=
 =?us-ascii?Q?4PDdFneRMHhpmcgHQBfbBgSpSR3rNDa1uXhDgVa/bVaWjOl9Z4RIMyfUSBef?=
 =?us-ascii?Q?pHqfKn/2UUxz4dxEq3N+UqxZRQ5S9gCm1zHySMXIOLjV0tADmWlffQLrZMtK?=
 =?us-ascii?Q?R6lz2buL47AMAX6eS8PyoSgT9GlCFtYOO2AxI+d8ypKHQtUX25qGUkxwuUxN?=
 =?us-ascii?Q?t3WppedixYAYeLqHfXAEQSTEV32cWtCO39JH8VJbL15Zo5+bE83zVkmnZaoU?=
 =?us-ascii?Q?xreAGb0WKFUoq4brYMwmJu55yOBF6JH481f3/ik7S8CR954vsurMdTQLJCYc?=
 =?us-ascii?Q?wH343RKUiGv9A/bj0/VR7Yyu1HPBDWVNus+TuFt61qDE++IrQwX/jswryWhx?=
 =?us-ascii?Q?X34Ip36UTKKBBV9VKfHcPuJ97pnrldjqJPJq9HAFMBM9BrjBsHF0C+jzJF+j?=
 =?us-ascii?Q?J/x1m46GqcUDzdOfSWZhfX8+LJKcmNhlW+VDXHW98OfrjgFkYFMt2hoPV5de?=
 =?us-ascii?Q?nGzcVMz9w7qToyTpIKEXLsil0bcr9xO/QNk2/zR2yx/4j7oEOAshAMg198ZU?=
 =?us-ascii?Q?3Cu6wtjCNF4UjVyiSNWqpjCAhBBYxP4poHpG3kEhFGZjkEWDFE9e254vXl0X?=
 =?us-ascii?Q?8ZlSx5xWurhEI688P2XQ41P8YtT0SREuq5YORERm38YIXNktZQmA0vIla82i?=
 =?us-ascii?Q?Xiv4AEJYhevn2PtEJJNLURU13pK0rgVrrl8WEvNCSv0DiqYiAqn3E6da07my?=
 =?us-ascii?Q?EO0t42PzHnZ4DnojloUV7AxF7uVHUj0Iqmtn7nr87F4DdCtenA/6nS2d0e/n?=
 =?us-ascii?Q?StsBsk9FFg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8068f5a5-6174-43ae-d36b-08defc0eba7e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:22:12.6070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GW0QbI76V0Rv2/fW+H4959hayTeCvbJAxHgD6wcGN3uvfJDgy9WaeylmR3fQQCgn3NPkeexmh1usnsFTnB3iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR03MB470143
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Boon Khai Ng via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Boon Khai Ng <boon.khai.ng@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Added environment variables needed to support distro boot.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
v2:
- Drop the rsu_status environment variable addition. Per review
  comment from Tien Fong, it is not required for distro boot and
  the RSU driver is not yet supported.

v1: https://patchwork.ozlabs.org/project/uboot/
patch/20260304040201.9265-1-boon.khai.ng@altera.com/
- Added "nandroot" (rootfs UBI volume for distro boot) and
  "rsu_status" (helper command to show RSU DCMF version/status/retry
  counters) environment variables.
---
 include/configs/socfpga_soc64_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 4d333c63ad9..daa208a27a1 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -144,6 +144,7 @@
 		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
 	"scriptaddr=0x81000000\0" \
 	"scriptfile=boot.scr\0" \
+	"nandroot=ubi0:rootfs\0" \
 	"socfpga_legacy_reset_compat=1\0" \
 	"smc_fid_rd=0xC2000007\0" \
 	"smc_fid_wr=0xC2000008\0" \
-- 
2.43.7

