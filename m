Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AE9C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 10:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB47803CC;
	Fri,  7 Mar 2025 11:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FJlCzRgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4588056A; Fri,  7 Mar 2025 11:29:05 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B4880017
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 11:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdVBZTfMZW2Ux5YecfSEcVwNNTBKkg+kJ4Xg2LJYEyYdGYO6ypj1IqMjMPV1JrKz9E7C45gCpbJbJd/l/NbI1XKCQ2Z7XM3LPGAkTHjo0kZBZEC+1ORu2BzDypA0T22Ag+ZWoyG0rHlcq1D736ml2zvoS3A1t4wefcU4uo/Z1knz7zeAdOqhAo5kBsQurVGdWQHXp3hEXcQM7EewQk+axa3zGDm/q8IrY8+R1amFDOKbNwaawUQD7/umVbq/g6NAY1N5DTULDHoZjUMM340nx6dONslh7Ka7+YfeoWVb3VMWbTpnD7D2bDTi9IxIADEOce9WNCwxgApzXoxBWEDTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peqB5tKoai+kM0f8zzKmmIrspAZ6rysUkV68125GVdU=;
 b=LTpIdVvtRs7ZIAIFUl/4QDsBq2JrhinXV263+QSlOBPAYPggM8cgVrxrIhja8cA+eLPOynO7uN/rb8nFMBc15L0s44FwBJkPUfxeOHL44tiIcCHTwGHN+QAq2i6ah16INEDqpLRN5aL0XpqCS02Y6Ow4hYkewW7g6YFV6Ss5rTlwoTIreDkRkvdgvnnXSkERp5R95vHqRC3/b0qxPFqoJKDYVDkU8CeSwmcnYPssDLE8W19UMVUx3ZsJDDoZk0JFVAnVmy/d856LxCkQaOxItQD3FI8VxrP8wxe6dKU71BPC/lJHC3YBZNx1KaAEowH3EtkidME2X3Peyhkg2/Cvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peqB5tKoai+kM0f8zzKmmIrspAZ6rysUkV68125GVdU=;
 b=FJlCzRgg1623+3jJ26VwYpBlvC8BFaWlluivXjzdCBoSnVJgq/A6lSifi5oGhp02HrIMEXmUWFq58xKv9NfmSvTnjWUHQvxsn/hhVvZC3gDxBN1BNdCJX8A0z1C1jlM3SYBpgEYLagE+kaYtpFBIVpuV6NPutaGsVofodaCFLA+JWipk4A18ZMyWxAi4Ui55xytyV2HSJfM2XNDIvrj7VsK5rBzWhtJUWu/F3XLxcoXIacnmHwpcwpO/D+X1nqFSfWhUbEaoBJLX24Q9MN8lW9s92Pl08Z4DxqK8EWCdvigubH4jC2lSrf8ZJD6szGS8vSjw+kwO8fcIiQmb3uVyTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SJ0PR03MB5487.namprd03.prod.outlook.com (2603:10b6:a03:284::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 10:28:55 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 10:28:55 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: ddr: altera: Fix integer overflow during size
 calculation
Date: Fri,  7 Mar 2025 02:28:51 -0800
Message-Id: <20250307102851.12964-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SJ0PR03MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 9468b744-00ea-4f32-3213-08dd5d62dd10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TQfISsehDkFuxnGHKulXvNxaChklclM2RdDwAMMT795pRhDyuJ3G9dbecj98?=
 =?us-ascii?Q?NUt8GsASjWzMLurXHhgcjT2WTtTVFy+yiZQMMJYMq0UpIVNegOBV3rEeSElp?=
 =?us-ascii?Q?H9MUlHvt1q5dgVzpnmd02EUN2ZTEIEwvjz2F3U9s+qPak2dTDBxD0hPLY06r?=
 =?us-ascii?Q?6eg4OQJ/BHhdeA/2tWx3N69uEEz6XkW8T4+VfccD9jrOtCZMSJXSFXJY41QQ?=
 =?us-ascii?Q?QxKnqB0XbUQa+t6oFTd95CUgUPGiSVOuTiDj6WuQNLFtDx5AIKCgfNXW72MS?=
 =?us-ascii?Q?EJ28mYnzTy9GFwfVnKHvJrUwIMe8/va99ooOhyndrc+pw0CgQDNdfZ5lI4AY?=
 =?us-ascii?Q?rIycguQPW0NlpFBFg9TUck7VS9H6Y+Qj9PTyYor2TBvX7JcfAIfV3QeQwGVY?=
 =?us-ascii?Q?cqoxFZVQJ8ujfGs14C/rCflheYUJezf1gsJt9DG5YaVSHOzzZmyfjKfbCaK6?=
 =?us-ascii?Q?8bX1MmzmYNVRrFTGwMtGv3DGQ9y7Hr15+t7TxwqhoXLTLVrgAoDATWyFluYv?=
 =?us-ascii?Q?EKV8Fla6lD2nX73lzOIRw3ZlHKUeVq8HJj4JvmH9btAB7Fyhzhspw1al/Vi9?=
 =?us-ascii?Q?L/2qVBC7vRqjRQGeFsV1l4uij+ykdZTpDh0D+QgxZIAKWn21FK5kI21Je5x8?=
 =?us-ascii?Q?r+bKsO7+iZiV5VIAaRx9K4Wd1fGoJjctllREdPc00Ssd9/YI89UXxpdO98tl?=
 =?us-ascii?Q?7HD08KV0Lm/f4ZoGUi9Ucb6FgCgJymto2ILcZNeMMU8tOfYCYrB13HWrRQui?=
 =?us-ascii?Q?Z1jwN6oQvwblJfkLFIgcbDwp+bPwD1kSWAELkZV9mRHiWVeFre99iQst+0mZ?=
 =?us-ascii?Q?pRzjjKLNG04grpvCRYusoiF+DenpEofHgz3jQJe1UcpA5TofoPlhJ8sjRvuX?=
 =?us-ascii?Q?12rI1D1GpDGD0iCAx4rjhLkkBLYKxpL1i39E4SHsFdTj1Hy2E4lRR4XHgw9w?=
 =?us-ascii?Q?WLHbB9uBQT5U8V/B+YwMzi33j35lk0rHp0JyRTLiq8wWhNyLG2Zele4+aapR?=
 =?us-ascii?Q?ht+Sq/E44wMEc2FTratjILPB1MoMvWSOT5o74n1OrDqSmy+CFjX5Xpj6ckI8?=
 =?us-ascii?Q?sT87lqAzshS4nFhr5Xq7EjC9P74nRuz5hd1gL8ue6BjteEvVCxEKllkRQPIu?=
 =?us-ascii?Q?UlUVTWMImxWuDIRNYRRRpc/Q5WW5vHis+6ty6PVXdNTDnEelGrVvDUCup4C8?=
 =?us-ascii?Q?k48KVpqtTj1xI8qkI+ipMfKqnEyQsfnpZa+yyUyT6/8Rb7q0N9H0CjURe+Cz?=
 =?us-ascii?Q?TC369WGXtJk5ifBQQue+yQFAT5yyRdgdoXl+iWoQQAooKCabm0HopaM195DX?=
 =?us-ascii?Q?UX177D5zXQrcDBc07+sC+jCRohF7jwLzaOgakQyTpTlfkJu9KTeZUqxDP2as?=
 =?us-ascii?Q?jf/NTDLZqeDNiWvG4LgOklWQzSsR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XlIfY4NzJp0BwNAGXP0xkDqr/b+P6CTFzlLZ1VtXKR4aan7p9RZm1GknRCL7?=
 =?us-ascii?Q?y5W2iEdO1OFoqhJabmcQ99Dkk8XzXxrqxqV8C13wPXna69NNpED1uFT17D3y?=
 =?us-ascii?Q?UpMfaEWMk7RF9E4iaWHjF5Qxzrz1p3IqHAZDnIcQBHlsMcjL5aYXw8fADcxj?=
 =?us-ascii?Q?40l16uwE1R5peZVaSUyq0tCVKVtpnf4l5V8j9WpfLR8YPpKXWwm/1hg8pu9D?=
 =?us-ascii?Q?Xc1eH8N5ffPHjfMJZjoWBARCJNrhMLGoGE3DG7xUyv7ov8kAnYxWV8nfkaLY?=
 =?us-ascii?Q?787s6OQSwK1Y6JYwEw8cS/zMwQU3vRDxJDnramsM7zPy8RtvtgND1m/TmPx+?=
 =?us-ascii?Q?r41o7OjAMxrOUZ7f1CCWaaaFRXiSWL8gtQr2xlHAuHMQkwbF9sKagCZdHf+V?=
 =?us-ascii?Q?zHnlYJ5IMa3RUxB7d+CfJxv2gDLRJ9TxY+PDrFwqZ9D7WXayKnOjeENFIGcP?=
 =?us-ascii?Q?W3AQsaOs6lltgU5QKboLLlDiGmJ+75WXr/RKAGX4Eigx/NPcSR2uKG8wyvQy?=
 =?us-ascii?Q?YBeaTjERq6IMHqFi3XndnJ6G50lEqKrf90PIc0aAyEpp2GfJaLu2uoWkFPYI?=
 =?us-ascii?Q?kx8TXiwKxd2b8x5tCbSRl6yn8uJYAPIf6IZcEeMipoqpnNejDcH3/gY6yanm?=
 =?us-ascii?Q?mDAcHOqUqdofZrI7Tq7HAt8QpYtW2+MZydNXD9Bj3IRfVn1pmfQMz1uFFbDJ?=
 =?us-ascii?Q?RQa+XMwFpkq4pK3SDRmC0EjHqVEr000V8hcUZr31ruNABVx9jRUJgQizlq79?=
 =?us-ascii?Q?yUJ+tGRlX+tlA5R8ajgRqJkxWXSdBqpxdCKGzYw2iWkySLM0bYJqfayDQDGL?=
 =?us-ascii?Q?Dw5TYYwtJ1pzPsoqHTbIElOybh0BEkU8Naj5umU4SyCkEgx5f6jIDNZq7Dxt?=
 =?us-ascii?Q?/e2PD7AHHIbyWsQEQAargW4Jo00u+CnIwQhhwoaEnntTVm7BHknegDxainm1?=
 =?us-ascii?Q?fhOlDqWOuOlEo42VhZoiEyw5jrzOr1zkyoAQiB+uQ/7g0zhl4iyQB9eHIs7U?=
 =?us-ascii?Q?JwsZFcFaK2RxEgc44ma1bK8zpaXPFWsOJ3VhH1C6qYgal0Lg0JASgGnXwgm7?=
 =?us-ascii?Q?aVx6PtrIcZOh+7FFS+ouV5+eBfkNQ00mhC8gLwc088yUkOhOxVKoX1z6ocpF?=
 =?us-ascii?Q?+XBnYbzw0RphFKNmurpOPj5yFeOrbUdzFC3L+A7SNzHh6ysTCKDlf1luUk8O?=
 =?us-ascii?Q?hGcY2ZRZtinuD88HsxOESCH94PXFEf3f8vCAjo9/Jp02DvPkqB4sAPdSuWM+?=
 =?us-ascii?Q?eslIYVW0W2cJKsCH1DDzDH4AtptYiaq35jsJ3znxF+KUN6MGDkYC9FKgWhV+?=
 =?us-ascii?Q?aY8I6MqIQXHmjwub5qHxlGXNIMBEQE42xtzbtIh/Is1ZAgXo3Av63BpW54YO?=
 =?us-ascii?Q?6z5MPHaxCDQ5+ymvUxyA5B3+pEX4y7YjxapYBGTvdg0W/RFaCwM2SC8vfxNL?=
 =?us-ascii?Q?5bbL5l9O1kzvFJhduNrtNoi3MkTF+Su6r1nYy7pEhMrbUabG0HS2hW6u92vl?=
 =?us-ascii?Q?BDN+G7fiPyYClbnYuNZMQsMEtBvAotfEQSf9ifcnpfYHtIOIy/1TfYmVweNE?=
 =?us-ascii?Q?JszmGeGSCr8EDOb2kTsdZhI6HGrytDsCfedMTplA5elf1xHtKqe5wO4Zkhdx?=
 =?us-ascii?Q?RNH9hESbyyxKld+jv5NW6zg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9468b744-00ea-4f32-3213-08dd5d62dd10
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:28:55.5291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcFHqqva+uA0QqrT0/8+phOA9laTgPV0+PVTEkSThl0feeYiSL/2oeiLEOlrgrMLr3H8etQVm6FPsJ8dLYmt7g1WqJOg7EUOsOV9k7o8YJ96lacPzxRD8YqQpADNcHQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5487
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

Data structure, dramaddrw, is defined as u32. Compiler performs
32-bit arithmetic and logic operations on this data structure. Fix
is provided to avoid integer overflow while performing shifting
operations greater than 32-bit.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_soc64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index c8c9211adc..75c6de1e4e 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -249,7 +249,7 @@ phys_size_t sdram_calculate_size(struct altera_sdram_plat *plat)
 			 DRAMADDRW_CFG_ROW_ADDR_WIDTH(dramaddrw) +
 			 DRAMADDRW_CFG_COL_ADDR_WIDTH(dramaddrw));
 
-	size *= (2 << (hmc_ecc_readl(plat, DDRIOCTRL) &
+	size *= ((phys_size_t)2 << (hmc_ecc_readl(plat, DDRIOCTRL) &
 			DDR_HMC_DDRIOCTRL_IOSIZE_MSK));
 
 	return size;
-- 
2.35.3

