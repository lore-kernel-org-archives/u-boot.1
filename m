Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856EACCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3E083BC8;
	Sat,  1 Nov 2025 01:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VHDGy326";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94AED83B71; Sat,  1 Nov 2025 01:45:29 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA5283B82
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8jQvgKNqm4pmAlYK44Ilcy1LgSMl9Ba8JYww+cA8Z7DtUn8EL2c3KRnc5RwIw/DF9IwwjAmbMhIYF6yCx85a4RZXHu40ovC4L2ZE/1Hm5SuZR3zGOkOkq7B9UpaB54MqBiBm7R7DYgz6Q828/smGhJV6aPMZbflu4Dv1ah5KxhGou3o78r7WVp/V5gYtIAfzSN0QpnROV5zXIh1mTeSW6RjeDAjnrBAtEWgMYjqxBDLUP0H0Ft7eUZIV+uISD7USdyGX3HmMq84GNFgRaEQ5bcYxpk4odCa6S3MC//ZUUVQATJQXFW2qQhLRwTswG8/tIecqQcnL0uX1To5yo/aDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ial/mVyzz5OJiErVV0o9OgFoNDFmMcWSxWMnOGdYHxs=;
 b=B0lxf7xk2ldzif/9euDGnDqBb8JFwgZQIgNKbqZsbT1dqRKcZK48mRM8fWlqPnrafx8dh1S6Hqs8bggCxOLO0ek7AHLURGfLoiD7gmtNLBrOR+LEkUrlHt4/f1gfL7GFQp0KjQNHxev+HkBzQrP7B4Opwma8mbiQEG0XxuGKQHiJ95IJ+4pfCStvTe/AdGiHU/SWR8PCa+tKAr6Rb3pl3CzfN+iK8uvm8jP89txXdjJyvRIL9jZQWz5mx8nBA5deENu7+/nw37QCgBq0utSM6HfzaxUCnQtcQr59YJus4DicTTROrCXdMtzdqkXw4yg9cU1wloW57g7pC1XkaX5usA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ial/mVyzz5OJiErVV0o9OgFoNDFmMcWSxWMnOGdYHxs=;
 b=VHDGy326HKFsquI64dIVRB0uegnWLS63ACyb+eLvp4e0yPLfUgoHwxs8GAZrJzRUXzSJxyn2t41IPZKlqDGQKi2Vf1FMyCrAcE+ZFmbhvpAdWUye0gzf0cTes00wHXWdYFvhSggCSIc6d5KRzH4WhgY/MVAWfmaTJlC6QJ/4i5qQ+Eh2C3A5TJlaygD3/KANHFFL9fdNwYLjTrZ7qyH0VBPg8zilXYD85CQmn69FVzNb9cSHq5Rci5sGjKVKudwQtIQyVd2uWB6dCgTvHPFoD5B3RSTmxM00hfRnkNWDjiew4lN33AC25zM5NP2zHSJ74ewbEvvQ1EXwFOMlQIPpMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 11/19] reset: airoha: add support for airoha en7523 SoC family
Date: Sat,  1 Nov 2025 03:44:55 +0300
Message-ID: <20251101004503.2379529-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ffc72e-fdcc-4b84-7c63-08de18dff16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DZ1XOpohBQPkwXsj2jiGUIPaJXYyhmueJ9dZR6DXEv+cEx98MdCEU4FQ2UeC?=
 =?us-ascii?Q?oFq2uf0zEdze0ogaeU9ToY9ca698d3KhYbGV2RDPnTRMG98LYJkwCg6OjLlI?=
 =?us-ascii?Q?4c7EtKSRze/X16voua2MesWltrwDpxx1lkFH/iXuL0biFWt3OU1O9GLIutrL?=
 =?us-ascii?Q?ygeCDZdeJLdBvu9661MwPIfo8lk44juiMA+IEr+QVT97wBUoi2+wmdQ50xbd?=
 =?us-ascii?Q?yrc3HPl8YVWp+HahYkZg+5bzsSiTMChwcQEXk2A5H5FtNNtAyO8qW0hH+1ob?=
 =?us-ascii?Q?O5ItJHPVKeyAAJKfQ5Rfa0INPiaNVLKfEwDpx3WXJHndANZuf9czYDlHgN39?=
 =?us-ascii?Q?MIplbHNIwa1TAlCrlFaNpzKMkiM25n6oHURXLPTJb5+Em0RyJhOq62UGXlg4?=
 =?us-ascii?Q?7UWaudjwaysBwnQu20bZSY3aLGwKr13XoW6kBLYabq7ApciCgLGnGwot9fdj?=
 =?us-ascii?Q?BiK54McdHsZ/gqhD905iR2udrWkbmc1cAS6/j3jlF9sSKlJBYjNQbG+0s5n+?=
 =?us-ascii?Q?a0XH3o31ByKEluOjHfJ2qHiiVkXqDtR4VuBmJJHZGzJx1yt1yGdkOAa/VN1s?=
 =?us-ascii?Q?mzifzrb6Fc93XV6aGQEUXJd9O9YkBdYzjNs6MdMs15KOMgP1SxFE9ePnt0i7?=
 =?us-ascii?Q?LJ1EWLhwsLSYbIkTMqxRx2hN9BaXADOVr3glgJ28o8yfyni8LB/LNz8PIPX+?=
 =?us-ascii?Q?kvfTEpZTEO98/cUfe6JWB+aKUjaTxJC7lcYvzlkNSwI4ZrV6YJjh6bezBxwS?=
 =?us-ascii?Q?hOKsDuA1l1yWQXmKmUVQF4fK8bAjnhPcmIpAbs7Eh/AZsTwAkgfiOPCyQQuk?=
 =?us-ascii?Q?bk8FhWRq5pKUL60UeP1ZjyzTIUYkZ2EjM42heAcGoXmav14HAXimQx8ck+xg?=
 =?us-ascii?Q?kqq6/oT/fxoZVtSSFqSEBpuGY+fENTXckkDtKO/D7AZxFc1hefWTIhf105oy?=
 =?us-ascii?Q?HrObqv8QsZeUe4d3TiF7Lt4i5kNif6hP6zLuesLrQ1SAEB8dDv2Nw7JpWnsu?=
 =?us-ascii?Q?XJsN90wNocpinmZjQViQrBWr34xRSx9JsOwnPtA1d1I8z6JjxsE6rkji5is1?=
 =?us-ascii?Q?Ris0sqqTy+fn6QgoRlynOgyI5+OhiOX468SqnqHH2ZFeZTVVSSHVMWHB3QxW?=
 =?us-ascii?Q?0p1uMjv1JiqSDrawb//dNcoF4pZRzAGAGDJWdZEmFYdftpk0p4vwTq7IiUcy?=
 =?us-ascii?Q?uBe8mRzJiKqsEv9t4AjXufMtfIo1iv8uEfxzS3wISr5x0UH1oAxE0bJgy/ey?=
 =?us-ascii?Q?0Cc8P6nBJCRpYFKrb0gVU4/rDflBwT6gtn+8IMu22+HEYzpHhiNhM+bB26xH?=
 =?us-ascii?Q?fWx+jb6sUz6Zo9C3CYckJqTdtCzwrbiVeWkU5DpJD4T2Zc6x4phzM+uIxkEN?=
 =?us-ascii?Q?FEYh5yuOnmeAS4TyA5AjcmpZBpuqVt0E0cu+XgIhFgLcJwCKJYgd+TJ6C4rs?=
 =?us-ascii?Q?U11OlSMNxJLSZZmV5va0TA6g8mNkr1yqhQWu7N3mARvNzVv9Mm7bCF98vopL?=
 =?us-ascii?Q?EPWjTu33RjQRVaPFdyw2MCWHZsJ/ydgxaNCm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kf1VcRy+XCu/sDHDRCSmhOi4BHdH0tD534VopD7wBWcB+brLYUpj41b5hpLp?=
 =?us-ascii?Q?c8V89m22e8OtFgpMMz+sZG3Mbr3xjATfjpa20nfGppyEXd0Yw40GRfkmREnh?=
 =?us-ascii?Q?GBJ0M3Zft8YTpkIZMPu7WxDQP78dWNCvlquQuXFif9TCjGTvNZ7SsML+V+Cw?=
 =?us-ascii?Q?owfb5q4ws/UdYK7Xa8P8b5hKab74JZghDIWvaaXFrcc5Vai1d2aHGFUqiaTi?=
 =?us-ascii?Q?cchfiBA9d8blnD4dUjAU/jaxi3iLi3w2DvDdrmFGNvcojA1h/ciMQwXZdN5d?=
 =?us-ascii?Q?q2n3SZaKDkdoN5MksUR0Z6isO4QFmX2mB4Exkm93LZRJecEzpf/I8VrG+804?=
 =?us-ascii?Q?5FhrGVDnTAqO/lkFQiY0IbOboRj0zrqkXsjhJHJ+yeSEZGuchIIZL6iWBy/e?=
 =?us-ascii?Q?cbU83/TFgay96nzOxcR+05SHUNYYPeKz9slU6OaOEwFnm0s3eJwnAUNnbipv?=
 =?us-ascii?Q?kf6HKLF3CF0fkLIS3SYGffWOlB4siSGe4wylTDSRH2iZPLmkyGgJ3Qwewslc?=
 =?us-ascii?Q?MtDxSllu6sL1lzeZWLBnZNhOBn8UMwecSNl/CYQNr0o65e5/TSBtyGGB4Bh1?=
 =?us-ascii?Q?/ZNEh7a4f+4tqo98EBl3qd0/XQKwUuLFRmV23REptx/3ynSAAgW5LuJZirhe?=
 =?us-ascii?Q?6XMOQgdLSG44VYKuf+pxCbiiZ44WvogrbwyOsVCWbdvTbvA1jWsYuX0LB4xd?=
 =?us-ascii?Q?0gZxiVoCnsrmsPp6uLyVYrT+3uB/PzMw+o3UX/84QOjzHASzRQf80drMNcXr?=
 =?us-ascii?Q?5dUkTF92haUj3NL+JFBjbWlnN5GIY7z30OZxqYLGb//O1YKkxbGTW0j7UJqn?=
 =?us-ascii?Q?LjLqh/XcUSRsMi0oGf3fT58fj0QZgx/ua4x/r1JpfH6yl09I6OhttKEnMqPw?=
 =?us-ascii?Q?y5nTP/XePro2LUHrm2tQ5kg9nhJKQAyV6U75+yYdCP+nMNGVwZRQO45Mc4wY?=
 =?us-ascii?Q?qBXfQbyV3nqfQICgLMm50oe0GMlxhdN84f8ro0bpLVfk71YWAc1Pf4jfRkbx?=
 =?us-ascii?Q?Fca/U73DKoW3pYJHIuKYStAEy3Z9jhzMQftTdLOLAx4sPl41Xc1INbO2S444?=
 =?us-ascii?Q?mCU1syTe/DLCuup3punkAJuvl9eeiMclX7C11UbLV6uuHPdDgAYHD42dxCz4?=
 =?us-ascii?Q?murLh/UsSKNCxUox1RNyvO7PcH1bHSXCBDXoWTBtleEjRbsO6Ni82BW4i/u3?=
 =?us-ascii?Q?gSgBmGFg9e3UQRrdgE+RDet4V4tfauTMW4ItLBMP4c5CxPcBEx+Gntg+KqTe?=
 =?us-ascii?Q?NFgmN/fGyca8+1U0T2oPleyW1+AKKAU0YPR/fkPRYbdZFihZK6xRw/sH4iv3?=
 =?us-ascii?Q?uAGca8k5BI/1sZzMm9zYYmWPHXo875glPb+gxfzd0rSnun1cNXkvjFoLnOes?=
 =?us-ascii?Q?ckUgnguwza415i8dxQ0MUhVolb98s2s7C388RgPIFet/4R/Zql9J97s5K5U0?=
 =?us-ascii?Q?1B//Eq+zDZzYprIfkQFwT7UJlk33wuEIeSe5zSa8sIBqrxAsdyiYISO01t+x?=
 =?us-ascii?Q?DAdofUsIyYBAjKbRUmLbHS1+RTDFn4+nCvvKMrT2Kpk0xoo7uuUal6FXMa+e?=
 =?us-ascii?Q?7VKcH7IoM28Nij7VipcFF+Y08qVTbsudvz8TZzRFZBYz/T3G3mGNgz+Kmd2C?=
 =?us-ascii?Q?I5Rl6MH/toxev+MAnKp6pqU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ffc72e-fdcc-4b84-7c63-08de18dff16f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:24.2023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBMPLDe8oepipeulPPdkkzTqzSV4LzolSHiuaR5RRaH/BayfvpO1y+O/KZMWCjCnidqBrKE8rjaeP6oF0pYeMmx20PqeNlIj81soZgTyars=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

This adds reset controller support for airoha en7523/en7529/en7562 SoCs.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/reset/reset-airoha.c | 71 ++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
index 58b868d9855..ef8c47a067b 100644
--- a/drivers/reset/reset-airoha.c
+++ b/drivers/reset/reset-airoha.c
@@ -13,6 +13,7 @@
 #include <regmap.h>
 #include <asm/arch/scu-regmap.h>
 
+#include <dt-bindings/reset/airoha,en7523-reset.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
 
 #define RST_NR_PER_BANK			32
@@ -23,6 +24,7 @@
 struct airoha_reset_priv {
 	const u16 *bank_ofs;
 	const u16 *idx_map;
+	int num_rsts;
 	struct regmap *map;
 };
 
@@ -31,6 +33,53 @@ static const u16 en7581_rst_ofs[] = {
 	REG_RESET_CONTROL1,
 };
 
+static const u16 en7523_rst_map[] = {
+	/* RST_CTRL2 */
+	[EN7523_XPON_PHY_RST]		= 0,
+	[EN7523_XSI_MAC_RST]		= 7,
+	[EN7523_XSI_PHY_RST]		= 8,
+	[EN7523_NPU_RST]		= 9,
+	[EN7523_I2S_RST]		= 10,
+	[EN7523_TRNG_RST]		= 11,
+	[EN7523_TRNG_MSTART_RST]	= 12,
+	[EN7523_DUAL_HSI0_RST]		= 13,
+	[EN7523_DUAL_HSI1_RST]		= 14,
+	[EN7523_HSI_RST]		= 15,
+	[EN7523_DUAL_HSI0_MAC_RST]	= 16,
+	[EN7523_DUAL_HSI1_MAC_RST]	= 17,
+	[EN7523_HSI_MAC_RST]		= 18,
+	[EN7523_WDMA_RST]		= 19,
+	[EN7523_WOE0_RST]		= 20,
+	[EN7523_WOE1_RST]		= 21,
+	[EN7523_HSDMA_RST]		= 22,
+	[EN7523_I2C2RBUS_RST]		= 23,
+	[EN7523_TDMA_RST]		= 24,
+	/* RST_CTRL1 */
+	[EN7523_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[EN7523_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[EN7523_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[EN7523_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[EN7523_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[EN7523_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[EN7523_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[EN7523_UART_RST]		= RST_NR_PER_BANK + 12,
+	[EN7523_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[EN7523_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[EN7523_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[EN7523_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[EN7523_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[EN7523_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[EN7523_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[EN7523_FE_RST]			= RST_NR_PER_BANK + 21,
+	[EN7523_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[EN7523_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[EN7523_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[EN7523_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[EN7523_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[EN7523_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[EN7523_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
 static const u16 en7581_rst_map[] = {
 	/* RST_CTRL2 */
 	[EN7581_XPON_PHY_RST]		= 0,
@@ -136,7 +185,7 @@ static int airoha_reset_xlate(struct reset_ctl *reset_ctl,
 {
 	struct airoha_reset_priv *priv = dev_get_priv(reset_ctl->dev);
 
-	if (args->args[0] >= ARRAY_SIZE(en7581_rst_map))
+	if (args->args[0] >= priv->num_rsts)
 		return -EINVAL;
 
 	reset_ctl->id = priv->idx_map[args->args[0]];
@@ -151,7 +200,7 @@ static struct reset_ops airoha_reset_ops = {
 	.rst_status = airoha_reset_status,
 };
 
-static int airoha_reset_probe(struct udevice *dev)
+static int reset_init(struct udevice *dev, const u16 *rst_map, int num_rsts)
 {
 	struct airoha_reset_priv *priv = dev_get_priv(dev);
 
@@ -160,11 +209,27 @@ static int airoha_reset_probe(struct udevice *dev)
 		return PTR_ERR(priv->map);
 
 	priv->bank_ofs = en7581_rst_ofs;
-	priv->idx_map = en7581_rst_map;
+	priv->idx_map = rst_map;
+	priv->num_rsts = num_rsts;
 
 	return 0;
 }
 
+static int airoha_reset_probe(struct udevice *dev)
+{
+	if (ofnode_device_is_compatible(dev_ofnode(dev),
+					"airoha,en7523-scu"))
+		return reset_init(dev, en7523_rst_map,
+				  ARRAY_SIZE(en7523_rst_map));
+
+	if (ofnode_device_is_compatible(dev_ofnode(dev),
+					"airoha,en7581-scu"))
+		return reset_init(dev, en7581_rst_map,
+				  ARRAY_SIZE(en7581_rst_map));
+
+	return -ENODEV;
+}
+
 U_BOOT_DRIVER(airoha_reset) = {
 	.name = "airoha-reset",
 	.id = UCLASS_RESET,
-- 
2.51.0

