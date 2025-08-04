Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144DDC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8995C8407D;
	Tue,  5 Aug 2025 00:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="j7cTmaX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1353984005; Tue,  5 Aug 2025 00:11:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB9D8407A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckJBuwZAScXJm2lr510fjUy6ZXbsdFXMCeml8lgJ9f4haSQcJh5JeIUrPkvGheBFdHVGahCVFR7796rP8li5esK60iJDrwQFdqXUK3Bx5Vjmh2yyBU9v0sYof8yYt/3klWWBrOun2teqcox5qXRonEiO63po86fYov3lOt3lxAr38G9A1dkP2ZtIJtFHA3AuaKiYVgWD3f9TOLhL4l3/8+BLmESvu+ym8DbDHawyFQF//gP9tj2wquhTE0vSG75Sb0fh7X2hw2FSmdcGljGM4oQx+/AOPqcZYDSnbB5qA3tFvQmlqkZO9v5bFYO21ewswp0rYJc3MmMucpjDH3VGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tGfctHi/nnd1bK0Dz6D7nIbiAf+kDS2XfH4Z8EcRcw=;
 b=WiTYOPTMsiInLw03rdjA6YMYs72O0pN+NVAiRFiBRpQ3RW9ixomlDZYbKqpMlla/xTws9BE8kbfruu0MKNbBtv9ejZxpxeeHL/9Plq1bcyIyEnb9cufWgjjOKDC4+bUZH7cCT8VwHVRnWGaph+q3eAu1rVOA1GOj7imYH5SGiKE4EXNyqk4LF5Z/dd4WeVNDD1APgswxqqqdQeNfyrOE5X0Bl740t9+b/JWwrMAFqCvfRZgzb6iTCH6s/U2a/8WFDCFNir4Y/+ggLE3te5YEnu7ugepQEXcvcAlXWaZq/Rc7vUkSD54pMqw/rQn+mdXPzF04uxljV2uV7qquEFnEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tGfctHi/nnd1bK0Dz6D7nIbiAf+kDS2XfH4Z8EcRcw=;
 b=j7cTmaX9Rzmmr5uaU+ArHzSx8TmCpVGd+XzCiKnXim5hGsQYlOQus+mAKHbQyCJTPzs8C2WViYKMf7ig7lh6NjhPXToajdC4AZDW3mxsi6lvb6v8E13j1IR1kRmgVzvY9UY/cCfsWz3YDkeuNaWg6zAOSYudttSgh4XHyFngJ1l0XqEGBtgTrb23GE0l88ZMZwPCu2UtRS1Xiry38i3anvop00cE5R+vFEJOuxBOf+f/nlB2TyaYzE/Kdk59PX+9Jfj7yXIY9ftjWTFP2o/HAx33/k2CUZj+UA3j0ZLBWpRJJ5QMDwhqJiETrh7xPoG+Wpc/ZnGUCMW817ZnUGhd4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 11/22] drivers: mtd: spi-nand: set bitflip_threshold to 75%
 of ECC strength
Date: Tue,  5 Aug 2025 01:11:11 +0300
Message-ID: <20250804221122.1420516-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b908ed-3881-4529-2c57-08ddd3a3e601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eSLnAQRsTyJoz/Oq37FyPw6oIi8eBc2vm6SrBn/r70OYlJhTRrdaM2TBQrBx?=
 =?us-ascii?Q?a7vsT7oZG9d9Y6NpdBB9bDIsgdAyt82YQbJgocuW8L9aWtMNwu1fDEQM4qIy?=
 =?us-ascii?Q?YIxM4D9a1Rj/Cp90kOlakpHuNAIlLKMtrZjZbnpqi/B1sotr+ggq6GBtigqQ?=
 =?us-ascii?Q?Mcuk9w5qj1w7XG78lCCODMonKpEtnlPbmyJZOQiB8MLxEiue0UdOP8znsIZ7?=
 =?us-ascii?Q?/g5bEDpk+LMbxTZsIKy8NgE70xf0ujxsIsD53qots+evU1IBkToKqi6f4HkE?=
 =?us-ascii?Q?Ab9fQeSAwDls+PC53KSH6sYAfFDyGUy6yZFWNQBe0dW1V8WWSD2VYeo0ccxH?=
 =?us-ascii?Q?Jk6v5yMBsFXDZvA3PPWKH/IgjaLQyFIkUnJd5cLj7IsJTeL51scf56uGxnsf?=
 =?us-ascii?Q?bDhMX4YF/7oNNoQjAcyGXRtrld9sMcVf+LXN4kynv6etDho14tvWu7J4DgR6?=
 =?us-ascii?Q?QwDgMUfc0qro+dseVO/1GzsONwj4nQLMeXqZYimaHU/WvNmF7lKzQ35WjZjI?=
 =?us-ascii?Q?zcW/l4yQAsuZI5oWwUWIoz/AacFhZVI2yo3FCta5qYj3Tyql/7hxGbKy2qnw?=
 =?us-ascii?Q?ttsvcjf9eI/S81O7CuQeJAMwsEnX1wPH8HEf7JmRHgC9yWyQ5iWejfbbFGaU?=
 =?us-ascii?Q?3mDKF3nzO7NoqWorVMIXKpnQBgwZj1KtltpURbhEdym6p0WcGLZn4x11CSUO?=
 =?us-ascii?Q?H9zOz+o3zJcaCdqWlNOE6mUjwk5v4u1MElKqARTbCUy1CxzBz8rWEeXW2iUD?=
 =?us-ascii?Q?n5hkEfbhv+NP0pj5fH88nAZka1EROe10KG8zUjGxMaMxUcdVn+FvdjqeAiFI?=
 =?us-ascii?Q?RCJ51kcnClTK+9GOHcyHVocC3Dzsx1iwM/97Q/heNPNxTbxoJ5Y/jyf0lTZd?=
 =?us-ascii?Q?30XLHtWuOw1RK0Upzf3pqVPDGo7nLhOSvdE/vfAirnPkkQ12Qek4NQ/p6fc7?=
 =?us-ascii?Q?h1t33j49IucbYSXPGwmBKp7zzzdEITZruNKoVvVef/2eVdE7T+9GX4xkuaHb?=
 =?us-ascii?Q?MMpLt1cHHnR12TOF+4P3T5qJSiJC/8cyPzQwxeTVEXm1DhIMSK8tWO7ugkoQ?=
 =?us-ascii?Q?gxZnsKcLuHQ0mnwZ11ghl9/JHNEoZV0zzK/7es5y4FNjUxnMUkl9lut8H+U8?=
 =?us-ascii?Q?PuOiGXosM3SzixF9GE7WA/5lgkH7o4DYAffXC62zlyo0ZxrQwpnG/2L/x284?=
 =?us-ascii?Q?ry/qYkvHikhYTrQ2fvMzVx1/M86AQF+hNnd4H0jQDwBEKKQ9wLFrYK2Nd0qJ?=
 =?us-ascii?Q?7rXK/ausaeTGgQQM0H2UCSgjThb49GAWu7sp42lnoNntU4qBThe8fQI+7oyu?=
 =?us-ascii?Q?18CS0jdE8YbmKRFvTG7OljgBpkdechLzlJ53Ze8RKj1Q4+P0LvYxp/DBVnEe?=
 =?us-ascii?Q?s12Xo35sUUj+xFnaURg5b2XtJLyMKVjNIsc1g8GBanQrIBJvQiWKqI9DMm5m?=
 =?us-ascii?Q?dKDqI0fla1/lxvxth2NrPrHp0YY9V0AxnMfwwx+4sHXGEdRHNxC1/dR7lkyL?=
 =?us-ascii?Q?EpDBkMe+YduVKQ4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uINE9ufiD9SdB9qGYhbJFxKfqXyR7lLlLwDzPyH9o+R+2a7zLk66Lcsl9HTo?=
 =?us-ascii?Q?lczOXg05I9hPl0XYeSrZeffxWnnBrhQP4/en0uAClvOuraAMssdtpeVJmaQb?=
 =?us-ascii?Q?5W8T8jQxQJppx45V3aKhNHGQuxb8jHEhPLIW/gFA1pCXKV+/2EogB3vAGBzG?=
 =?us-ascii?Q?Fhw7kB8rkEXNjcB8890qumvvHlI4sXmt2KpFIprNv7Y/YQ4SO/lgDMwRDcc1?=
 =?us-ascii?Q?8EHK9X2vDzQQJKNip2XuwZCXHXXY0MQij9F5GZbtqFy0YUyzNzg0cK+6dQcN?=
 =?us-ascii?Q?F8acc9J/kEVsRHQ2O2+X4Uu+rnZh7fnhA71yThAWX37jZ0h5S5mA4vtw1Ltx?=
 =?us-ascii?Q?rKNNi6eeUJsofP8y21zIXWAAdV5NgBZNDgSFSHWdbIqQasMQiPRz4LZy60i7?=
 =?us-ascii?Q?JFrB5/0gqr2E74da+/+e6/nlz2rDXes8zI9MEMOVwt6cixf/eZSrGdVcwDjJ?=
 =?us-ascii?Q?yVCcELE9JGqhKVqVU7MD6q9/yZCoDtV9Z4RE2Albug8lqQtbMCcjYakc52rC?=
 =?us-ascii?Q?xMylB+ehQK673d9Rf6OtyuzSA+9T+gwzYE54PaPxYArExJJtkBCd69St9lrc?=
 =?us-ascii?Q?4Rk6zCOe7DibRZWDDzdkgjqJssJC5RdxfxRRKQ4LIK9C4Ka947h9beAgM0Vz?=
 =?us-ascii?Q?AewOtqePToPE8VfHAT5QYTrK5f4KkY0Tocuj3fV5hmdU+hEULjNOjOkxi1dd?=
 =?us-ascii?Q?H7thjwWL0eOGXdCeVqX8Vyzp0PnMEGxAmWHbob2MczptdnvcK18K+MVXFiJu?=
 =?us-ascii?Q?AJFB7AsNpB67pBEzPoZ6L1CetjGtbERrE6U0T6MFlg1b5hW/mpbYVNcf5K84?=
 =?us-ascii?Q?qvBtQycIo/BZCJWzGoAUMgs8VDci+GZK8wDUzQCEJzw+rmC/aiPpZkWTpd94?=
 =?us-ascii?Q?viV3qM5V/L5k3OXWjgFpc7t7KGqc89ADWRcGr4SHJOIvCsGnH0bymaGW+gOu?=
 =?us-ascii?Q?iwDhC45uPXpogC5E+ZZZkCYUzRtph2WMM4eL0TtbNcaqdLrZRcbZ6kd+/5js?=
 =?us-ascii?Q?5jd2JrtipOKCfF2Nm8wJVwYH5rooAHXSmWOijv3pg+nOtAlaVlatvuQ5A8Tt?=
 =?us-ascii?Q?xWgBVocy77Wq4KT0flT0hgcjhmah7agsGpliRsBLq6lHW1w5lVXJtQqZ/su2?=
 =?us-ascii?Q?Hzrhq/NMH+wIOe2MSmBxQDJFiz1lP5kXMxGekUUwMow3bmQ3yrAg4FZdMuOs?=
 =?us-ascii?Q?LmBCdspCjzhC1uiNX4LdCTnyIPxuP96lUWlHlCKJ1p8thba9jy/Ma23Y7DvY?=
 =?us-ascii?Q?6NOiQMYKvFKlRUz6L90LOB+cHy1SQ2qJ4+B57waiO0dFH6pbBRq1LWf03alM?=
 =?us-ascii?Q?oDGz2cl3+w+noNZ7Y1jgZRp/zezblmB69YF62EhRg8zd7+ivkC2NB9DO2PXc?=
 =?us-ascii?Q?ePcIfiUBwII2vh3wJ+8Gc00ankwnt0a5Glj/mR2zgpDjamTOR6JCDUQQV9AZ?=
 =?us-ascii?Q?rXc95Z2FoGNzrevxH1D+mkZWXph8fF7TmFLZKfIf5DhIOTWt9U7REHQUKmYS?=
 =?us-ascii?Q?4Afis1Fp141bYc5hHzgrc4wtRvWVNWLiQHW5QPPFKLHxHbgst50DXjSWg+d0?=
 =?us-ascii?Q?WAcKQFrA14jS1Kk97gKPRRuhWSptqpXoEjAgbltW5u6WSLsoBvCWci49eaG+?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b908ed-3881-4529-2c57-08ddd3a3e601
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:45.0297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0oRrSBT3ZqSpy/4QFzhpvuuW+ISx/2GbbEOQLVeN+AuQEugx2UlzAl70miyDapQ9J09o0EqEgYkigCNCtNq68ZxJBpdIuDoBUwarE8doS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

This is a port of linux commit 1824520e7477bedf76bd08c32261c755e6405cd9
(mtd: spinand: set bitflip_threshold to 75% of ECC strength)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b4795927277..7ace61fd19f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1279,6 +1279,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.47.2

