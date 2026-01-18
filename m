Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7459BC9830C
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 20:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB68F8307F;
	Sun, 18 Jan 2026 21:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WOMpSij5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A978389A; Sun, 18 Jan 2026 21:04:33 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9808D82BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 21:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4WsXl52D1JMqaOb/bJd4Goa2EOFy0uUuC3giJ8kBaf/kMw/1AqdkxBNvUkBKeq/rpf7NS41+OfcjRxCLhGPxSOdAtXNWQ8PaQ5uq+DkGoEU1YcfiSdffZf3yi0rh1ZqaG1bdgffCuo21bkZXtskAohHagMDSLb7z/1qwPW3W4a3fJhwz6A9V2iO1SuZduskb2O82U6Nfv5dfK8lT6RuNlx0LDF5kUzKjn6JvIFjUMNK3Jb/Yq+G7NyS37q6+tgvudT/qnucCAi1/PFIn/OawU9vCmJHl9QYRL0WaTZ7Z+OwFU/ZJcF3sbYemoEyTM1ohJPJ8ScFBzKvB9/v2fUd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu45ov/g454w4IJiAjfJVXFwQNyY8qrBjbVy1m9rt/U=;
 b=KYICunneQJhh+W/KCpMh4K+dqcx0+ES64RHNBuu97RQUma7isoQd5JYEPTzjGaVGCSxWW+lymDfKhGz4qeT35xKiQyNhZWPtnqdxvBEgeesHCA6DVkxqtuEtjtebJGalbFLs2Qug+b6kPu7CyDfplmH3rj/rHhg1kWieGCHQE1lLyGZgPl0g4KS8cTSwTKMzn5U9pA9ANaeSCewgcIkahippYdIsrF1Y5NaqJnnhVLIj+9qd1gs5uHObMFyXLG2HROejn1tWvyMYWo/Wqq+1eBn54p1/EZ71KUE34S7jZ3jh7EcDYyr9gfPA8jBu/Xb8wh1kTOD7ejeczOcdXAadnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu45ov/g454w4IJiAjfJVXFwQNyY8qrBjbVy1m9rt/U=;
 b=WOMpSij5cm0/8a1o28y6/KqER9VGtSBV+S+1YAJVlukOcaCTOmlggx0y2tO93RoXWNaUFmRm+OwOMWzBl+OBbERQ6p76vTU25Z3ZnwQsDeb/mLmUjnM8DoGYHF7ydfUK4yiRuKTgfImFJgOmdGaghO/4MGQh8lFPN8kbdUUh/IjMmmvHFbaDgNdrU8z9NN74+Dw6hzQKpEbRTQksMH6ePdhliDqBcOoDVj1suux1vU69v3ssXeRtokgMFG4nVucHq0TEsF29QAh4NDoJMqqGhsnPEbhd5MSja3ZqtkBIbmVg4c8hU+0T6y7K/wEnQgiqDVNGyYQiO8U38YwboMQFvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8282.eurprd08.prod.outlook.com (2603:10a6:150:a3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 20:04:26 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.005; Sun, 18 Jan 2026
 20:04:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Ray Liu <ray.xy.liu@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] Revert "arm: dts: an7581: set r_smpl for MMC in U-Boot"
Date: Sun, 18 Jan 2026 23:04:16 +0300
Message-ID: <20260118200416.690517-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ecb06a-8f64-404d-f1b0-08de56ccc7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xLOFp2KGWZZhRlre1GV+q28eMrUayv+dBwpupYCRFV4UdUvNEoIlI9jTxbZ0?=
 =?us-ascii?Q?CxvkoTS3Rc1ACG6ucWuQiRDOlo0u3yEJX2DFoU+IJnBEPtSp1sX7YtOlo/XO?=
 =?us-ascii?Q?60bIMVAhnR9ts22n42l5vMbdgWD8+xvn5ybcLemaHatQmJauILsJei40bMy7?=
 =?us-ascii?Q?i0OYfrog+0L9MCWS4gHGP0tfmm7W2kuSCj9Ttk/tH3otUbYrtpTbc5d0/STb?=
 =?us-ascii?Q?EwvQPbWSt3/H8pBCRWicDfUpQHTknQagcKOLupSDa30490tmjyoqiYaHwHFk?=
 =?us-ascii?Q?KR6A2R/NdqrJIC8Ek+MWADAhb5SZJ4kDckiZ2KIoGvRVPo+Z1V/Zesd0M+zH?=
 =?us-ascii?Q?GChy8mkPKlyOoORzK/J3ADIm0HABQbR1Z+UCCDmdezfTCfRb3QN9TBbaslbk?=
 =?us-ascii?Q?u+WveBu27bK4MeiMWxSfPSBowAf7HYNXt8StA4rntM9WKZ9kdEUPV+duFApr?=
 =?us-ascii?Q?nCXd7b5P+Z3TTUWEBtG2QQMTwt0jrvVwEtxzPVGTQ4zwXwT/l6Zbfa3NhG+l?=
 =?us-ascii?Q?MFOWtf8jvAmlePp5mpESiVWjOFwKYh/cCTFORClCqJwOH02dMtjow4g5mWLy?=
 =?us-ascii?Q?xYr3aRBq62Cb7FNuSh597PdJSsnutOECfIOZQb8UIzA2ap55nxR992rPyhE4?=
 =?us-ascii?Q?0Xj7ciUi2KxA+Jxn68GhMmaQ5Ort5MkPD09XC7SFlPa5SgEBhcKpUyfTLxNO?=
 =?us-ascii?Q?rk6pxCUByd+E812/Wbcs41/lBDfd6ci47q7Difv2v9LrlgfyI9oKEHZVtdJx?=
 =?us-ascii?Q?ZzpEBPZq2HmrRLZTg/96EUIBVCg0DRQk1pramL7tEf73YDTptzMOFf1pzI4I?=
 =?us-ascii?Q?cMPdupB6msI7bVMp3RE/UOdDTV2uwI5rm/y1LM1YtzLpof/AYL7eb7A3UETk?=
 =?us-ascii?Q?iPIo2YnrO0FfCpsWqoMuwnXHVDYdk0rYm7db6yUNAD8aHHd+YfdZ8BB3NfN4?=
 =?us-ascii?Q?N53kxRCI2v0O/zb1TwU4UVe2C2kpzsqeM4rQXNAKHYsOF4SGRyfHdFPL8rsT?=
 =?us-ascii?Q?Hes+Wlegtsdza4iY0gbh2AziCRRHgaG5z/TwuqAqJq7QUKseb5gFpcQJpXQ+?=
 =?us-ascii?Q?l4QbwHaWedii3fjKVgHf/LNcLlGgOCF3S+dbaD6rRXHxbthSuWJXtCT5zU9Y?=
 =?us-ascii?Q?UFwqZnVII0untrQDo9n63b5kjwZSbukQwCaarg10v2S/KHjDv9bQNdxTdBu8?=
 =?us-ascii?Q?6gWq3LQsxb91pUcOgc9PWerxrfdlKYlDnJ8H66V4x5ZdVQzNxlBVUrBpOchA?=
 =?us-ascii?Q?sABWlgVQzN1Xwrtr4hr/qIe0CdYoKDedGTaV4np9wr8i3XnKT32SirbysyPt?=
 =?us-ascii?Q?K/O/HxdTaMjcY/K3Q0XwPqo1Tz2b1GSnUFpbfnO5wlxRpO0kH1dJXfjVDGqB?=
 =?us-ascii?Q?4C3m1E8XGWElf3JT42uE+W8KJmrCjdC1JfrvtPYfGfqQK9lV5Da4RTAg53tP?=
 =?us-ascii?Q?SkJd5guc8KaiTASm0oXRZnvrzYO1jqNE+ddqSr98tBi91hiR9N75bh7vhMvX?=
 =?us-ascii?Q?ch/nsLploFqdtCEp92G+LQBViOKT8jptQRllp3LN6zOEHx+FFpb3PfpzBWoE?=
 =?us-ascii?Q?6vLQ+PE0MeqNsWu1RVTm9I+nHE5LMWcOjoozBnJyiDI8kfdpO7hkcK3eVz0O?=
 =?us-ascii?Q?hlxHK1GIwqKVgg/ALj/8hZY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OK9rhdd+CLpriU9u+N4QrM5p6wL+C4R46JD3kjIswNPabN7cEROr/xFN8pE6?=
 =?us-ascii?Q?IlrI84ymlluewm9/X8HF3wnO221i8D38g2ZDjDjtqcu6i4S36my0g86/LTCg?=
 =?us-ascii?Q?BuTo5fAgROIU1FNCIFPpTQo6h2wV/RhpWAEe7NlizG1JeGOD7ISKX+qWdA0R?=
 =?us-ascii?Q?XreL3r9Lb4OdnuvIIt0fqmsLIsZVx16SnUWhjHjvmkUboacoR1xbzSq0XClz?=
 =?us-ascii?Q?SJY/BHw1kXWIgcfOQMLQm5EbA5g3fzpAgMJp/wIYS6F6scDJXiuWiMKIhzme?=
 =?us-ascii?Q?Xky0qWYm5jDMW16Js4tBL1IFLpsVhzU9wUikakAoQOzpAjH2KeTZxgezOpgK?=
 =?us-ascii?Q?O9RCFRxqw7w6xpzJjwiXTsv/uSVtBO7Xo4cKgUKrDKQaW/dJ8uu4PaTBIc0N?=
 =?us-ascii?Q?E2XPls4iUQk8NIHjGohb6NNOor43zMRvbJbPnBaAguvuwDqFDF5jLFlc3JHp?=
 =?us-ascii?Q?6YzaTb5HmH2UADz/32iwWw12xTy5Y0zbsQMj6AsCu+Tqes/dR/dhbiHR74mP?=
 =?us-ascii?Q?+cKEe2T5doHbCMKq5HqHTlBqeax2E8DWWAFZZs+/rx/pqVUUWSuUg1a5lB3t?=
 =?us-ascii?Q?RaGZW/DEJXArT2hoT8Gv4CVaSnqbQJTTFE4XXn4UhmGF3y6fxBxI6U8g7tjC?=
 =?us-ascii?Q?p0BbRiTW5VNC7g1aKI8Rvon4KYz07OgZG68gYRCbmQmQagSz49lxhQcFpxaA?=
 =?us-ascii?Q?ROHTMa1eEwXzo1sUUL56eCMwIkVs77YTr/t2VEs5VNP8dEfe1D0ARkE4oEWC?=
 =?us-ascii?Q?qaGkhIkD0BiUJiQX59HZRNFQMcGRSp9nwYAv5HSGMGTz7DWYNCMJ1QGrTHEl?=
 =?us-ascii?Q?z31ZBQxvm7W78qlXhhnjV3LmliBklAHRSrGIQiTbsjzEk7fo0kPlgaB+Z10x?=
 =?us-ascii?Q?Masp26acijKdzDtac6koFmwuCDlqmccf6a6XjYluEu3FsfxdU8vvruYCLDGB?=
 =?us-ascii?Q?YCwnrBm5/kK/Y9exQqrehEP3yF+0xD3K3/AmOJE6VxgzDs68tDe60fectHpX?=
 =?us-ascii?Q?nvA5+uJyjWrBwACfGzwHoy1xRkUt45fvBp0oZiqoaD+PCmPlsRrS8fVGoQ28?=
 =?us-ascii?Q?zp8zToYIRwG1rypjq+8N4zRVQr4tQ7Cr+3VD5EUhL+AYDS/1+3NKm08YCVCQ?=
 =?us-ascii?Q?u26Z5nPvNB3e1XstDjUW01J3rJn7rtJtwr7UhFy66MYE2wb4mOxrPfoAULQI?=
 =?us-ascii?Q?EO1+ImEJvpXExeamn2ouFHYMBSe+94SyH3tHx4G2RA/2bMy7VXgGwRamMKR5?=
 =?us-ascii?Q?lzbxlmAWpDjThic+7CQX2kAO1IKLfgC6uK2gmPgXrbOhw6UNkT81usdiWBBZ?=
 =?us-ascii?Q?4BPu4M6qZJZZSDxttv1JCSX5brcQHZ8JLoKD30IKgWsyK+CUMLEMLKseKm7K?=
 =?us-ascii?Q?qsAwm1LBsAyxI02CpB2a9FHxNTfm2PhMn8zkyPndokJVGXMp+N1XHFo02CCs?=
 =?us-ascii?Q?aT7P0jMrOXkG/gqrQuxkG4684t4/F873uPwocv25GYERTyjapX3MNKwuqoED?=
 =?us-ascii?Q?4w3lnkGAO71jnMuszTGJG8M/I+Wv+u1wLEBXw1dGanBAiEHNy9qh5SZPHKrx?=
 =?us-ascii?Q?T1s7/D4iB1kFvfN4h1sh/5K6/jkcx8LztI1W+hNfN5pnHkeQAwc0IXt7We1S?=
 =?us-ascii?Q?LikeiROrZjik0cANvLnr58UGChsdjwgytq9/6eP+DUWR7LFezsFoaIq5W9ix?=
 =?us-ascii?Q?PhgU1glhxYcjKX7/uL2uWlmLxxha9zdqGL19MsUh16r83kEDonqdk3YkFs8M?=
 =?us-ascii?Q?F1LiplGemKLghgMy5eTRqGwKLSGUOl0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ecb06a-8f64-404d-f1b0-08de56ccc7da
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 20:04:26.2478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4U9x02Ni3OZBXETAmDYsq93F6YQ3wlxQ5AAKxnYBKkzgpsN11mpB/LrME9skr4UGimkdDRsI9rx7ApKyXAwGeSBP76GbqduVVAU/XgEFKkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8282
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

On my AN7581 board, the same change in the Airoha ATF-2.10 source code
causes instability in eMMC reading. After the patch, in about 9 of 10
cases, ATF BL2 is unable to read FIP image from the eMMC flash. Thus
BL31 and U-Boot are unable to start.

Lets revert commit 7cb79f8d3d55 ("arm: dts: an7581: set r_smpl for MMC
in U-Boot") until the issue will be investigated.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/an7581-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 7fc71d471c4..a9297ca6503 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -84,7 +84,6 @@
 			reg = <0x0 0x1fa0e000 0x0 0x1000>,
 				<0x0 0x1fa0c000 0x0 0x60>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-			r_smpl = <1>;
 			clocks = <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
 			clock-names = "source", "hclk";
 			bus-width = <4>;
-- 
2.51.0

