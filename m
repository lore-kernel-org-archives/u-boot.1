Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2387BC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 10:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AA8880AD;
	Tue,  2 Apr 2024 12:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="gb+KPXOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E90B880AD; Tue,  2 Apr 2024 12:01:33 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10olkn2081f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::81f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2018836D
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 12:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xiaofengvskuye@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQw9ivfbvF7L+PVCr8c3h8zMXiOIjmysjNET1zLuCpejpjV9UALnchKKWCtR9H4sSDhmycdbh9Vgl8JavGYAzzDlU0COB62LFRe3IJDpDlmfWOPw82ugh8MDcBI8wHLajRYIk/C+NOB19rZKa8neR2cGSeIxD+nGnw8DC7vqnUJE1evuqXoLf78MFsiH+zoQNzywnY6A8CVWt715hh266Gv4HPVrivrRIrwkWbOI+/qNapTR9CUGpHNqRM5pbPn522mhK5Naa3DnHhiE9abARa0Mj1nWJOGs5fTRLCb6696p9ClSJUwU/2lf+Dtb9RD6l+OJOi23YoLwD1sEw4mTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+q/G0Smf51/SrCzWHCsk/yK7l8cTxrsOxU1WyRmxEw=;
 b=jdqh9mK3YhslZl9mX88+G2BeQgu5X3eOkOGVGh1tAk+72MhmIQMGaAl+CI2KtEldDcONQR4tAOpc5QExKYzkZ3SupckrFYX6zAL2yJPc0+om7gdRGJxPffuBhEa1p6vMi/kWibJ0h2n1gFqjeleRa9B+EgVXN7TV53yPtDBxBfHdA8J4wtbyKBL4K34/bT4GZHB8wrqS8Akg56yNvS2280GxMJnbh9AY3MVSpHyptG+7yjPrvYhnzNPPiWT9+qZpERvcTxGnTWyW1mSOXTvcptle2zsZ4n8cNJfB//wsXdTY5Ez2GZqaETFlgWAJ2ebsKcgrWT41rKNKd0G5a0NBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+q/G0Smf51/SrCzWHCsk/yK7l8cTxrsOxU1WyRmxEw=;
 b=gb+KPXOtzraN8mGjv5xAx8rZB16S7W38I2863CzXefLOcJQSnVkimcFGD83CKmw/6hstwDzC0yfC4QFTlPJIb27lCyBHVJ8pul8CzIS48X/YI2TEa0PJTdlsybO0vs6ZrLyNlYJc+KAG5Qf+qZIUHA5r5AFVHA3R6uTzHCMiZGj89M7WaFTzuffK5wf9T7npSsX1Td2AgVw1BW7v5IQMRNPEI7IRgbELEAj3e/EMn2FEYHLzzh9TxQrUi0dll+REPSLjkjSHgTSKK+2a7JbG29UgisC/Z4N4pCNSUOIpNYJPcQsVg/xOI2ZTC0edbzMGKoCzVWuTrwdX6MIdndqBFQ==
Received: from PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:31b::13)
 by PH0P222MB0531.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:01:23 +0000
Received: from PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM
 ([fe80::8392:7df5:faab:8f4b]) by PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM
 ([fe80::8392:7df5:faab:8f4b%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 10:01:23 +0000
From: xiaofengvskuye <xiaofengvskuye@hotmail.com>
To: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com
Cc: u-boot@lists.denx.de, jonas@kwiboo.se,
 xiaofengvskuye <xiaofengvskuye@hotmail.com>
Subject: [PATCH] clk: rockchip: rk3399: Add SCLK_UART4_PMU support
Date: Tue,  2 Apr 2024 18:01:08 +0800
Message-ID: <PH7P222MB0668C67CD89312A9CED6E64DDD3E2@PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [K9RpRAPIVegxlQfP3HGBURh5geXPznWToMDtoWVFsbX06dsMoKLkRa+yiy2m+rjQ]
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:31b::13)
X-Microsoft-Original-Message-ID: <20240402100108.540664-1-xiaofengvskuye@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7P222MB0668:EE_|PH0P222MB0531:EE_
X-MS-Office365-Filtering-Correlation-Id: e546ac5d-3e3c-4fee-456f-08dc52fbda50
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/FjIF4saYqa1N0hyW8NIk7i2bBBhtxB1aMz/ylIAX77zELreVYNQUlfV7BdPf/y83ZpBv9SELexk7h+NmJ5wlQdJPal9GkEeEsrZzzvhGoP+nffFXytW+WkZaJq1gZOWaiJbWthRR/bgZ5NQQc/sOjsqzq6FT20EgdBeosM/CRMwgR/YCWNlm4dSFxv7MEtnPuvkzewhLjfnaYRBNWZew1owSPQbuvHL5BFmMpxnu+vN049hvmUVukpnm0ReJgcyyQqXVCT1Iqxk4CXs595xWj5l8a7X8ww+fUfuHQFOJRT1w+80v8OR4TqZFPx/JLYQ2t8H1I4AqiJwwSWnbMI9AUiyZspdux7EzTV2vQR0vmvM39BHbLkdBBKcipomqEi8iMNwIdvf/MTeczpJUlvkEUJmvVfrqngocB7KJCIZV3UFHxek2gkab3TeExjZQk9TwEkfXTyP4PfENNmwLVpbZyfkAwRfsd51tk6YsTCzjF7jKjBkH7J9AfP+SizUZzIc937ODsoIgvN+CEN5izthKvPnpUPqyg3yoWUuQ7bekk3Sad2mtdLwi8gyF/Yn2wNTdzEAi7KtZGYsg72gzgjm1Tcadvz9KeEYPvYXe1g5w48rxz7hPyomrGBxEjxRCK1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0jy8KuTd1qsjF+yTUYKc0BI+FZ6AO4TdWAr3cpNEtVCRtPI5Iz0OhbvjfaQJ?=
 =?us-ascii?Q?o/YxiqOx3sLNOXtP7z3VdTNDrYWRwn5UQ+EJKlrCoWzNWRk0AkgxUNdylAJS?=
 =?us-ascii?Q?KWuDgp5NA6JxxdsVKRKRdm/WCQ3XGwo2fLrTJm0gJ/nN/cZL3qhARk7qmMgs?=
 =?us-ascii?Q?9dYrU0I85XyDS4hWvOBMywAwr0aRskXz+eRPpd3Ye4wgGwHpcbRylCki7c6q?=
 =?us-ascii?Q?8SwiQBXU4RhclwXi8evdDYp2D5o+p4SFSxStXkdHavUmbH3Lb3N2FTLRvILG?=
 =?us-ascii?Q?9TDZA5mIqLsIISQzXhLoNCRtFlVPCDwOPNilimEBDIOI4rgtdYnXlAtDWi0r?=
 =?us-ascii?Q?KB4rc7I1ZYylQPNt01zZBU2+OiQwHrQpkufOtyjL6Hd9AaZZEY9AtPzkksC3?=
 =?us-ascii?Q?+m++FpBIDCNNjPRYV2hxZu9UrrwjkJRgplrZVrGXmWrfA0fSx2pr5T9KPNMV?=
 =?us-ascii?Q?4o0tExLZiA9FQ9msDAxfPQBdPcEYBhaX5As3Y1MZG7b9AnQxHW1elyBaOTf+?=
 =?us-ascii?Q?jF3HpNo1g/qJp+IlDtgzbsFBHnldV2mFpVu3rlMoeJgMdru7JE7ZH0P8jAOY?=
 =?us-ascii?Q?MUZZy3b+CZpKDjpMaWg6NhGN400kz5gmQ+nZ2nE0AuYXml1+3346SwrXsN8h?=
 =?us-ascii?Q?wOwyLdFNvMPgBb7bT2Rtlc79u+NfQJosxPNjEPEpHDIa/u6uNLjfthP2FyQd?=
 =?us-ascii?Q?Hcz5cfc+vSacXWCxUBNBEW5jKCNAul5rkhEFpDUn7WpSlg8alBHeqwbQ3n0L?=
 =?us-ascii?Q?vlV8j9OEgoIk83xL+vWkYTuJ7aMagMQgMVcySPBuCZ632ibb0d5dEyrD166i?=
 =?us-ascii?Q?zGTcnNJXJRp/AVuxlOzS8wqOfwWmO7T/rrtcFNVaTql3jz/VlZBxGz5kZwfW?=
 =?us-ascii?Q?nadMzC/K0TuUe93AXkTdeUjeTlPTIcdajWlwbMkPycBpG++o8jEgqAKQuuOe?=
 =?us-ascii?Q?mMmoZkRK5xEGtKSmuUo60u0LA+fRKJv+6vB50bNWlrLaVjyeCPzZPqKw4v/I?=
 =?us-ascii?Q?DBZ7ZsvPDOvfWDbCN8/up/oHvj85BnOhI/7RINNz9UtOpt4L3Blam/T/oIZd?=
 =?us-ascii?Q?9A4xX7CGJWCzFMmOPI54+YBN8AOlYISY0t7/ThHe/Y4jcEyUNdCoVNi+lO/z?=
 =?us-ascii?Q?WS5npEpL0E294u470jjvH3bg2qYiOmqNyoZrwIdaejjsfgsogkj541sOx0Ru?=
 =?us-ascii?Q?8WIA7Mai3APUflcn11dnOVww3gZ9Vy9IwA50kYD2bO1VO17Qiw2KaVFACJJE?=
 =?us-ascii?Q?c5AJ2uK6TgHf3d43aagj0TD4oL59se090/lp3tDuXPACUouXm4t34x4s6bop?=
 =?us-ascii?Q?KhrjRHRMRqpDjnDVFBWfa/0y?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f13ea.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e546ac5d-3e3c-4fee-456f-08dc52fbda50
X-MS-Exchange-CrossTenant-AuthSource: PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:01:23.3896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0P222MB0531
X-Mailman-Approved-At: Tue, 02 Apr 2024 12:05:17 +0200
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

The SCLK_UART4_PMU clocks is used as reference clock for UART4 block.

Add simple support to get rate of SCLK_UART4_PMU clocks to fix
reference clock period configuration.

Signed-off-by: xiaofengvskuye <xiaofengvskuye@hotmail.com>
---
 drivers/clk/rockchip/clk_rk3399.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index c37e8a53a2..a9114c4b02 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -1563,6 +1563,8 @@ static ulong rk3399_pmuclk_get_rate(struct clk *clk)
 	case SCLK_I2C8_PMU:
 		rate = rk3399_i2c_get_pmuclk(priv->pmucru, clk->id);
 		break;
+    case SCLK_UART4_PMU:
+		return 24000000;
 	default:
 		return -ENOENT;
 	}
-- 
2.43.2

