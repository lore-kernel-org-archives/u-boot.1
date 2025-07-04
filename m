Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F8BC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DEEB82F8E;
	Fri,  4 Jul 2025 23:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1kOKgLaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62C082063; Fri,  4 Jul 2025 22:59:58 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9AC82AF6
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 22:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN28YpwB2Gt0TYLh1Za3a0VlvPYq6ENcL1Cic5MLUo2vRnla2FKbba4wZu1dBUeWopFLmSxOd/xwNKbqkXXCwMvNMeNU+LiE5jjBRL9xSS0u7oHjAxzXQYi/mkv/2KaAMkKhfqzeDF854mqYgTeXqFjcWTM3UWMme9tpFEkyBgj+BD7Rr2oiGQs545J9e5xt+CFsw2Ny0IlneNJUBWW4HLNJkoqhpvA58HyDa2DfihulxjL1gi0wu0pA7FvDwg6UhhuAPvnbN1oix6/4Cy4BEK1NOwNEvDuGanmTPjnjN81mYmeXmr2958/Ir4Bcsj4A/G3flBAwjXKzjzfb2KJn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=ANbrkUTqmUmTYtHhZ+pJTqf4/9f0K27P1JL4/pAqLcfUVs/xesVre21oXh+oQfZdQAVYW4Wbfq+V1UYv5Ibdo5D8/QeWfpz6lhavtsAS94rwzYtOlN6jiA6Z6l1uv2KpCeeX2/Su4FzyTJ5imukhmUC4mNjYNTuPwaYTBOQRP+pSlP9EtVWUZ72cmbqG6Ym2swVg0nRDOH0cW0cIJlUyFaxiN+s7X5PEl072AWbaNO8ZJsGSOBHxIRsc6G1kfGMJD6mOox5LOiNcYkoWuc/4/D+b2x1yq8yMKsNwCxA4VpyaWH9FgSLKqE7gSJco/a8ZocosrcjYOc03rXESORzvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6e4YGeKhkPDIlj/j9zE2U2MjbXT9/EK0PEN5KDo9Hg=;
 b=1kOKgLaMne7CI5yy0Wxdr6j3vn95gFOdDkfCGLY+DfBZIE9zvpQ5MrsgP5pWjz/IqosWwUiQg/guj1hAhqQRBqzI2B9HC1hpzaTUpkh7y9wleDlEAVc9Ui20cX5n+t2FpQpX2uA3JOdyzKW2u6gvhVK9qnInyS8yFbAdajopEzkdcT3967fB03YTxef2V4vojuI7gBft3hIM2CQpOmROAqfBhmDdKF5+Zd/G1Fb6smkCg/ha8p9ZRBCVCPWK+A9jlka2gi3ILk6cWVF2NVna7qwN+sAjTI4/0gHqYi2LOMkyMhzRKNPOb1aom8x6USMFb6SsIi/3YboyDFR7W7WwqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6342.eurprd08.prod.outlook.com (2603:10a6:20b:31a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 20:59:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 20:59:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 1/4] drivers/net/airoha_eth: add missing terminator for
 compatible devices list
Date: Fri,  4 Jul 2025 23:59:40 +0300
Message-ID: <20250704205943.1398968-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
 <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c92bd2-9fca-4a72-eb03-08ddbb3db9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?olOQthTYh81TmRgj5ZI9NCKgOxCY7jiZ+UwexoytdnjznXtGpY87pMyEnbvz?=
 =?us-ascii?Q?rGFpCHNREzhhiQgOzkF8BwlMy1ZYJsIkoYiPVT5KW+sQzSPJO9lOwRU+GlvJ?=
 =?us-ascii?Q?JMIgsGyuXQA03ev6Oe1wJBH63oDLVG1i1obENTNHZGdun+6UYJ4akcTPseE2?=
 =?us-ascii?Q?oWbX3DDFBkm/bj9ffG4OCbkFeM3plmW7FsWg7qfG4zYDRnDGZt5eicRdjkI+?=
 =?us-ascii?Q?E1AvLdWxrmpE3X1IDM4mJLFN8GDjiMvAQS5PCnUJY8DuXlh6zSDqJOHWujTx?=
 =?us-ascii?Q?HYhw3S9BEXGM+YQD4k5Ui2cwlOxMEPYvJC0ss1SiARr2PM3bjUWzPn9M84x7?=
 =?us-ascii?Q?3vH6ruzYR55Ea0Hx4oR7QTUItHlrXl9GfEdWflti7sXWsa2a4xLRFMczOzdH?=
 =?us-ascii?Q?HywwuPrBoUYCuF/GjNJqZhHQL5jP+Bwwn26Oea9skwwNRVOI6rz341L6FnX1?=
 =?us-ascii?Q?UMBwefpaFAgfRAdAnk2xeoiULfpC/W+TPvp+sFVrxKUg32x7kOWCWOcyoQOm?=
 =?us-ascii?Q?pPUL06IMEYOubIKSM8S0BFnZQs3CJHV/ed34tNYBh7nX8lHRmrn1r2SaKx5c?=
 =?us-ascii?Q?0BRh+SCD0GS8fg1wr+qlm5G6DkrYfpulbDhER/dB9NafJRHh4YWqReyx9uoD?=
 =?us-ascii?Q?0S0iHv+3hzijvkgAboKNPxhSQLpuDnkANgCF8nhgbpj3cdXTVc+JOHJ4xC4K?=
 =?us-ascii?Q?ELk1zAORGQno2wY1f3QLFQpBDgC8JSfwGxhch73ZXY08OaOTaaDEspaI5qW+?=
 =?us-ascii?Q?3mNl+We7gxyC6/GP6lUC8hPK25SCihEk/qKPkyOzyOuwN3p5h1snFI+ejvrk?=
 =?us-ascii?Q?HKUUbKH+bLCesIFT2mgKX6Zx+q25RKfZtpIcYQkCLcJgPIkbxCYu3FAcpVzm?=
 =?us-ascii?Q?naf/Dd47FYImc4Kyh4ouUa0WQzBBl1yr5cJDIhTbBB8crUJa8+TMvB8oKjza?=
 =?us-ascii?Q?yCusha+jPglIXVpurEzwY+gV0j0qDqcInn05jQoOVi4EjkNFepUdZkuCpfH5?=
 =?us-ascii?Q?pGIyqhVNnXfxR1IGZEZ9zS8oY3Qje6v6SwgrWNXwdiIx/MJDpaqjsCv2tIBK?=
 =?us-ascii?Q?e36XNI6hWJPoR4lT7fOf3GGuSe6FT7z7i7A0Sv5c7wXlDkDTczPaYVPY97VT?=
 =?us-ascii?Q?+7H2MkFhYgJEHqe722VIk3YrMtIhtaR5rYEgV95Ic7ZAo998EBAVoVTajwa1?=
 =?us-ascii?Q?AgwHq7T3XUMYWshuecNjKPcBk7gLLwzqccHU+6HSoIuNtnoN8+/GOsMzmffU?=
 =?us-ascii?Q?D5UW0FHpV/kH39tD1hpqndwhNhZz3RNDlAiKK9dAjOt+BqlVTSLRLAPPjXHt?=
 =?us-ascii?Q?0pCSUeRDEBs+JUVAuaWtLyEmneZ5uBxnlsoT+A+52IBqJo0qZUNCb7Xmfdz+?=
 =?us-ascii?Q?fG/YVCM56BW3qnE1whf3Eh3WzA2aH8F8BjY4q/VttposTgmc+JxuX4cb23BQ?=
 =?us-ascii?Q?5a3GTeN5vwSJXPlhrGiIW4Wv0NQZlUTSijwmDKkIXGzQwqezBsCOmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6pPZg7Q2La2oV+3RfonqtR1+zRImn/j3kYHlX5yaUB2eVLBA0lF43/vjwKY9?=
 =?us-ascii?Q?uq538nkz3QkKt16S7l7/FTpaofAvGNny367OKDzUn+R6+ImjT2vkZmoHhTBi?=
 =?us-ascii?Q?TerGlT4HZmpWUrtxAPFnFJDSGwQtTqHwwM0GnrxmMczXrB+CCz1imI6ZRRLE?=
 =?us-ascii?Q?5O3SkGVsw9ZwhZ+eT9aBGMdO7IouVC/fgL2JDr64pgnkSmrjhaSzPL77cY1B?=
 =?us-ascii?Q?4y33wh7/v0o05200PG7fHPXj+GlID1VqIfk5SogCbaxkLMtJM+CK3oLaMOK0?=
 =?us-ascii?Q?2mQf3WRw6ObV7PtLCcGiHV4zypij7DsHwvhwoaeRo2JfGY+e32De2iJb8gpC?=
 =?us-ascii?Q?JoVwtPEzy5rtH1XFuEbKtICjNqFn06Gf0wf3gbXNfyPUOGkL2cn4pqivSOlK?=
 =?us-ascii?Q?tyK75NHgemeXHkpmvQC7k4KUwVHXcXn3D6mu1vn6eJHBiY4d+CS5X4KRmDUj?=
 =?us-ascii?Q?HOcSrj3IVv0r2V5Vubq7mKdymGV8eE+mGn74qIeY7H/sp+SX8Ga6xR4SwoYp?=
 =?us-ascii?Q?IOZMEiwozDVIIPa4BsenW970oXHJiBMNFeTvUnKjdactqdG1wDcIJbi8uWPu?=
 =?us-ascii?Q?sJJJsixGUXfmNhj+0hMoGIniuuRuMUK0QEdBFwXsN7hmisDE/2Ga2QrGHC6f?=
 =?us-ascii?Q?e+d7Ol0Z/HG+pw6dafYgHCdJn/u8tQbHKH4U9pKy+3LwWe3yeIt3wJJMQXms?=
 =?us-ascii?Q?1rYsYSoJQOcmYtOtaAM5N1oOMG29GehqHdbAqoWK2BooC6IKfNUBV0k9FW3f?=
 =?us-ascii?Q?Lyb7azLr/j6dSdhJKUmLsKx2ZQxcRnqeTQ0c+oEpvEeb9wrpdwncJlokZ9QI?=
 =?us-ascii?Q?tj7EwqMjDO84ViXuUIIh5zGlbvmd2JHgZdACIHwVGsNDM6nwHaXPwKK+gT9o?=
 =?us-ascii?Q?MBFvDrD28Q0cDSmh8xAh7mo424SuSgGGjgV84b8LUbUrITXmcfEDnKe+pGy7?=
 =?us-ascii?Q?P0BqYOoSDJJxjSwy55dpEw0zfs80mNpar1r1JhlOZaIFmCpSFMNgRW08jWZn?=
 =?us-ascii?Q?BcSH1lz4WjyrTNzYXAhHgsDfO4YzjluZp2pUY0wZMqAypIIghT7Jp8VVGlDL?=
 =?us-ascii?Q?E7AWlg/hK5/NYtlTKtedLB0tPhbA7hmQNnbQgDRZ0N2Vl+y+dC3J4lo4KNom?=
 =?us-ascii?Q?uhMY4qaW8xjl7naRp2wu2vfmokmrTSb7axLnx6CcqZ9ZhzClNWZFwl3SFsgR?=
 =?us-ascii?Q?Adiu/02b/2HkdR6pZ8cn9pmRuSETFggjg4trX6hi5bB+G8YhJLqLCMEl0NDM?=
 =?us-ascii?Q?8YguME7LkDnGAAclf9K3zRXHRYdDHsIRFnUoi8RxOdKL5c2XHEDyEDyyXdUf?=
 =?us-ascii?Q?vUUQ1rJI//jrtC06K1PFWLDuxRcWcNbX3lw/ooKQNu1sBkzuIccPCUYEpg0N?=
 =?us-ascii?Q?RZxDT9lQO2hNvRrr5pEct60S7mlLFkJMnHoz2K4pcPD4xxRECry00yYoXHEU?=
 =?us-ascii?Q?LIzlFUZw1Ov706ZTSMfzWHhIO/Qkj65OIxapOxI06dALy6Zwkue6+RPnV6ld?=
 =?us-ascii?Q?2X6g9HMMk3gjDBk0pxnFadWZoRJfAlsNkcJzVbLW0AbtsLQZxtIspCKgfpIJ?=
 =?us-ascii?Q?lPSglNinkwUO2DHsHewgweW2TNIIg55VX7i71ITEnKjxGJBtOnF5hgDhpOVB?=
 =?us-ascii?Q?0RI7MaJFCwK8vpOBxjqeFL8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c92bd2-9fca-4a72-eb03-08ddbb3db9ea
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 20:59:54.9457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqjeF7byJ2a3nM27PnZi0ihZwA5V3OAnkJ+CYN88BPZxQmrFE1Bb37TZ0IYavAAtv5gRARxBDaSljvhx9isdRQDF8EiJsRr42KwHDJ1USqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6342
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

Compatible device list must have a terminator. If terminator is missed
the u-boot driver subsystem will access random data placed after the
list in the memory.

The issue can be observed with the "dm compat" command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 7e35e1fd41d..2aa42b3d727 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -926,6 +926,7 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth" },
+	{ }
 };
 
 static const struct eth_ops airoha_eth_ops = {
-- 
2.47.2

