Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D64C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 494D183855;
	Thu, 14 Aug 2025 01:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iqz3Mdyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05FE8383A; Thu, 14 Aug 2025 01:43:44 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3701D838C2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw9hkHfkV1E0Hbu3Ko+d4GZCj8dbjp9ZWooN+N1kzJvl4tFp8HPGrFfhx6SW0BIgNPU/R21hPtNSklARv1Tv6lW8zfhQSWsXupmWDv05lnQ0tXF0RdupnUDiS1peuUdvWVVzpxxeCo474c7GzH7GeJZRX8BL8ux42P3sHfIEMtEWzPiWvtGZYLChHHWXiPH6gR87RkLpP9ENu+Sran4QhQ0oMvICMnHiR2FJvCu8qluCL4b7/fksRGwKB0FLbcG3yaYB0cqLnKwhtAxU6GNT77aoMTDSQVb2dwBd0+ZIlW514ATTcaonLb1uEtWTeHJp/LchQikXAU57z4fudJU2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jToLFzWWlMw0CpRDBHVxZyVybHCZJuuzNTYBywfdshg=;
 b=CogciZIUSILOvapETdReyP/KwxmLOJGy0fv9mDq5bx7jSdxWt76FC2HyW4e6pI/82ShHDkUwwxgDi5cSZfzio0sHdyf7VxAfpfn1FLOE/56IcZqPDmUEWFTGSzhKxdpephzTnheIZ7GlIXj6/L37Xh7MAy7UHpPM8yRo2lt1Usr9gVa/7JXq+qOa2/9A5qzw5SAMgZ+NgB797+tRcvluaZD4hS4MdqzWn3JjZ8qv2dPKWy+wDvoBEqKb/0TetiHYuLvY8EiVvrLl/9jNG8ROw5aYD2LC5rfChpxAbAZJ6FlUm5U4X97nUAGY/wkb8L1Z7jnR4y86HiwZ/Wko/MNYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jToLFzWWlMw0CpRDBHVxZyVybHCZJuuzNTYBywfdshg=;
 b=iqz3MdycLwl/oS+Q5qloL0A1OOzytbcyzZXpdmSG1ojOBfutXTRkNyjqz7YZmNPusjGYdb2DWGyhH4mLbSrwLM9u49uqZQTClthoDKeY0SznxZwsyH1Rmexsx4D+Kk4ndfW64Rn+F4HQlX/LVeQzqYiRMwaFm3jH+Yx8Hb+Ri0HJgmad/KJSTvcWe1k+CNOum/00B2ujkoG/YKzLxR/3+g0UsLaNNY4IwvAP5HHSGsBmVPOkywScTBsXcUJBY0MBfigRptVQI1B/vi+Fvf/bkY/IuX4s0XqFf5tGvZP4qI/4gB/uGTHKvgQulxASSxpdb7IbmdWvKwsJI42OVEULDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 13/21] mtd: spinand: Remove write_enable_op() in markbad()
Date: Thu, 14 Aug 2025 02:43:06 +0300
Message-ID: <20250813234314.3945708-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 3433a982-5efb-42c6-7ea8-08dddac33b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nehgf8B+3MgYZKBCY9YigoHBNvKU7D+kUiDb2jBH5woIDiPkOweblF0MhDCv?=
 =?us-ascii?Q?jsPhumOrFqtEdxI+5U1eCt/Jzlxas5CZ8iuviM6aKRpGxOtPy1zWBZMJGKF9?=
 =?us-ascii?Q?kq5VQvp2Gefij3Ff5yLR9xWkBMJTVVTVvRefNt1ufzLOG4UcaSh8ho8Jt27s?=
 =?us-ascii?Q?QRikwxOk4sQ8lLsx846QZ4XZtJY4VdVGOS+K9k+wrUzxawuAX285T2pb5eHf?=
 =?us-ascii?Q?yFSxG5gVBaSxAgcPTDK2wk+rP6zShVsmmhUYvEpr6IMEjwc2wmT05XQZjJMW?=
 =?us-ascii?Q?BFZxjS1fSG0/IVrsZh+UEz5NoDyx5taqFcJI2D6X7xMqVmsRBGW4W4J/f5ng?=
 =?us-ascii?Q?hjymaSpYHDXStxNF/nbBqf6ZrsN1Jv/+EkLfOeF+RZAjPlp6xC8zFHXChTZL?=
 =?us-ascii?Q?uxkjgX5Hfyb0FOAW5NEicCaCRg2IQlGKKv0BAZK5Sf83Fsy004nj5j0rPlW2?=
 =?us-ascii?Q?6VaWnXzA5wNABDmCgFYfAaXyvMlvzYcrgADlk2X2mYpyZiBGWmXTs7K2FXtp?=
 =?us-ascii?Q?K/MuuDivOWePb001jyiXmYFNm5b1BdxS/s8RTDRZt557fDzrxBZVnibulQmW?=
 =?us-ascii?Q?kNMTTW+Vk4ActxiBWvL7NWMEMV4SqZAmfNyv9Bj/kbuYflnxH4ocaPz5oHY3?=
 =?us-ascii?Q?Lh3sHJEh9An+sMxbVbP4eRnYsh+x0Gbk2BZZmi093lU+tFEblTF/am0ssuxE?=
 =?us-ascii?Q?heCHUJ3f3tzn742LRDB3wgXkGmtUqRoqKsYu4CCDuHmJT9BkOoSfM/Bwd2VE?=
 =?us-ascii?Q?5bYaOrJsOUadWwqbY/kGGu7jiPM2xq8tSh+gEEiGVmAqWFuU2e+6WZNOa9Nq?=
 =?us-ascii?Q?KwVp0a9c/XJU9wLrZf1BwJUrpODLQuuDvwO+4/C4jDHQJFdwfVWUdQYO5P8p?=
 =?us-ascii?Q?bnwBddNj5Bil3b6NxiJhVu95nEiXmQfIi61GLONa45VJlDEcuGerPT4bm9zx?=
 =?us-ascii?Q?Hw3w5iWlOSS2eR3wQT1fgXTrEf81RAeC1a2fgxmXlTOWQMg2kS9iHryu5gr8?=
 =?us-ascii?Q?D7L8+pMo1eO2vHASngSwRMqEC9G7PjOX8Nvb6uV1e0aPNfhXudpNQsrBZbUo?=
 =?us-ascii?Q?Sb9Yh5DPePzLI6/MgVsW/udRib61Rob2cdr/0pNzWGIpcg5NVQ8lBGcnztrW?=
 =?us-ascii?Q?gcoMicRqANF6IMUduK49RmHiI4JU53qD4MK9Ml1PDCUMyoikV9kvBgKLo7zX?=
 =?us-ascii?Q?8Cee5pocOTJFaSKU1S1spQcE+HwDlFNsfZPrUtx0m8zpcqb/j7+7Mt5PO2vI?=
 =?us-ascii?Q?P/xJmjCiT2AkXDi8vbnM1xhgkgwojKY0ACISnXGcdW/iXAwfHoRGKqSIf3qu?=
 =?us-ascii?Q?GrA7zITX5QF/szx7bNtC8nLapw8ckQF35pErU5Kp1Plsk5+vILCXMskYIgKe?=
 =?us-ascii?Q?R2AfouBkec4FeSBEu/VhsW2kAgsWJxe5NSu4aZnY7byVq/rPknM690bpddBA?=
 =?us-ascii?Q?J/vdSPGitc4tdeyAg7bzqUatk3aJJfFH6YQ4i7hyobFuMjaU4ARuRaHDJT/o?=
 =?us-ascii?Q?Dvq9OYfN5QHA2xs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ynmG4TReLIacoAdLB42uqYrLUPlx6rbeqJHaflrLa3dyQhXFd2IuqATvUfpZ?=
 =?us-ascii?Q?eqPj68oenpOJjNKAhoRvLO8zT8h1EQ7/1HNajL/A5imcc2QsDspEkoodhuaz?=
 =?us-ascii?Q?oro/hxQCdig/0Vum1Gl948SGlNDkiWrBnrQW4nb/d4kh3rTq5JPxPmBHvyr/?=
 =?us-ascii?Q?TblifrWMPCsfHXw3MLGNt0dZDKPz3PBlf7JLvAVqRlJkZGmjDq+jjAODNj/a?=
 =?us-ascii?Q?hs2Wr356cruaFHV/Ris4v3kbuNNwij0CuoyXJ/hYqUBK0+9kndA7hQgQs850?=
 =?us-ascii?Q?BshaeO+7yH9P+HjA7NGh1M4FqNEzbiBhJASfSiNcYXzLJIbIaW1AVIPwSxJR?=
 =?us-ascii?Q?1eleHyeyK4fsceAoufht8Lmk71yTXtC2V53sE36EWkGkUu8i2DmrvxbbhwWD?=
 =?us-ascii?Q?qbe4lESkmWmo5rnUiIZS5PDgHmqEf2mjd3IqgJugUleMVyVpxn4JlSthMYIK?=
 =?us-ascii?Q?CmukUe2Yl9vsILYDXr1petd03BozCWggjAvrOTewXZcfjPUUObUtt000jcb+?=
 =?us-ascii?Q?NW9E97OsOHByGoxQ/oZL2KOIklPJ6WK9gVxCwuL25vD2+55LX6T++HbTdaal?=
 =?us-ascii?Q?7BS8io20xCYV11LZSr1CyjzS3kBiV5QjhUSl3yMEKkyjagvEG0uNLbc8aTLo?=
 =?us-ascii?Q?dWjkJM9Mv9N8OwwOvenSD8eiqd2RVIyEDy6hzKRBGoepXk+7OgJKXVw+wql9?=
 =?us-ascii?Q?lX8U198IgbHkOM41NtEe/MqMTSoBqsaXbvO8MAdPWrE7HxrDjdbUbEhHHuP7?=
 =?us-ascii?Q?TAqYeyP6YZ8x9lkbszfnXwc/ZtI/WlfklyaNWrjZWU5dyQ1BwbtF9NTYzZzx?=
 =?us-ascii?Q?6kD4BzT2foBQuy64J2cAtSzlsgkBms28djfawjZaDjNHM3ZUOzhg3zuKhBWB?=
 =?us-ascii?Q?JcP+JXi48/OZzucHjXQh6XcyLWDDdgfBXkXf/iuid8ecesclKqQ40lmGiCaC?=
 =?us-ascii?Q?JZODJvLptLyeRHwj1F9JVUgl61JvUXomZZbiocvIEqSzHR+QD0wNCzIe5RJJ?=
 =?us-ascii?Q?RDRH5FVXE8DSpdSvFVn/Cy2FuXhRn68etOv26Vkx27Wvyyv7JAE/ek9OPOr6?=
 =?us-ascii?Q?3AWmHfrTlGKM79CPh/N9cTCThxALbZydbaNJzz8OEWACr0HgAGr8+pWhktcL?=
 =?us-ascii?Q?Zc+jF5A7YKe2c6wVjokMivPyTkMvHaHCsrNO0KFit0EvDonq8dkVmDPLzpw0?=
 =?us-ascii?Q?O+Y/0oOdKCQmEP7H+N4ypvZn7CTJM0uS46qvJI4xpuRSjlj2WwjT0Z0F7bAY?=
 =?us-ascii?Q?87fI+5SScXuIwbdHiesb4mw4rimnjM0xK93+fyloFy7sS56gf5/+JIwW5zN+?=
 =?us-ascii?Q?GwdOYMz5xLf7USvw/8hoHjmK+G/Kqr6s6bpjgeGCypJncO9Ws8pgqZTZ7Lhn?=
 =?us-ascii?Q?sXrXxgTUDMR1yencaC7Z8wSz3QZw+HjIx2bDhbWDTCSuh+cM01BLQxedeait?=
 =?us-ascii?Q?+amAt/p60w9k13rSHO3xwnGIP4J+9NDVCkJd0jttOH4Up04s5IIHNCJxdTTj?=
 =?us-ascii?Q?jnt0AO7EOnTwfigR0C9GjAwSTiE2mAFuTEaBQjmCWgf+DG9P+cSR6NwLQfDb?=
 =?us-ascii?Q?+InaXUY9IOfbT8a9nDawU7OyUEnFJMvHcGwzzdzKMyXPnBQTtohnitaI8hin?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3433a982-5efb-42c6-7ea8-08dddac33b66
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:40.9742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe5wE3n2KHByAzV2hXjruL7xZnA5eFU/55r4ZXOeuouEvjxPL69OueZCobT1AuhYzAF6RI/xj0T1zPifqZ7qVZtgSx8jhAcysJMyLcjQDm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

We don't have to call spinand_write_enable_op() in spinand_markbad() as
it is called in spinand_write_page().

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This is the port of linux commit
c6858779f1f5 (mtd: spinand: Remove write_enable_op() in markbad())

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2083e3673cc..d0c9083a5b3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -795,10 +795,6 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_write_enable_op(spinand);
-	if (ret)
-		return ret;
-
 	return spinand_write_page(spinand, &req);
 }
 
-- 
2.50.1

