Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1917FCA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 06:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4869680107;
	Fri, 15 Aug 2025 08:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ITehXcnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3430283A83; Fri, 15 Aug 2025 08:18:21 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F6683A2D
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 08:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrcvTaZAPT1GKMpyidGW6EZISBgGNqKhiF33O4xmWXlEufk2rfZOWFyS6i/FLg7jtYSdHyS2RgGOSJjEnR/WZcOPUlhTX92yjoP81dOlMQDinnGHUwdvM2hnel4AjZfdCnSngH6lHf+xJFSnCrSPcWPfDxrvjYgR4FvmokNP0gHQVEVIZFqKS/aIw85k0qXIz4UpJuKoCFLVbqQaYR4/FKX7jm8BmqYzeky3XY7S9cWbOyn30k2qbILO9ox3ggiQSaGTTUMduebo0Jt/NGzaXAszkrpM2UOcz4x809qGkl5Kqo8T84zXCB7W8k2ekVe2yXh15wjxRZGV0cLWzMaHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+lUmbz1mHv4/hAAgpAiS0wi8/Y5bNQxZwejIUXqjzQ=;
 b=V3nFlYLhUsGlF+JNy6AC01mbYIWdI9ha6yo4YkZ6pmlX4OY5JzdaHSa3nhipVrLHtKpAAFAcSMkh3SwzlKU7QttVokNHZOqWmuLCZqzpz4Mug/Px8LoCfwEc8rQZBnY1lQO843cYisZB8HflMa1zSN6sAeozPyGqe1Qqswgbrp0q64z8SKMzIU2pSMegI9iYAK2lGLF11WEP6cOcmGi6kRLDKv1zP3EKVr1pnX0Vv5eUAU/Vkc4rnXi9WUPag9AjmLfFT3dDEjl0W4iHpXFHYYQdqcnmVzE1epG7Qv3dw3p/DbVICyzXpWUaacDLDAANL0KxpPT+KksBmW+T6mQjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+lUmbz1mHv4/hAAgpAiS0wi8/Y5bNQxZwejIUXqjzQ=;
 b=ITehXcnJzo1gbtjkIvctHqDXGSigAJxp9evsRIFgoD4l58cxnpoAyafORQdzLxodJs+uU2TFVdK0Yu8SaHI19iyZVvKEinf4NO/6+uO5XIFTKC1nZh5dej/lcG1Qb7Ly/bx3J6eeYO6yjAc3AgaPZUd7SFCoJGaoFBrDnHDHCEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5497.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 06:18:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 06:18:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Aniket Limaye <a-limaye@ti.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] i2c: omap24xx_i2c: remove unused members of struct omap_i2c
Date: Fri, 15 Aug 2025 08:17:19 +0200
Message-ID: <20250815061719.2758662-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c9ecad-7a2f-4b85-93cf-08dddbc38422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PJgtJMg20IZiPsMz1UnID2vGlQlokT3Fmu1UvXtW2P+UQnjMxSuDbVkAva6I?=
 =?us-ascii?Q?iR97kwwwkG0cLXQYvQPKpKI2+i05Lp0JXvZSmkjZ0On6w7L9C9e8VhQqZeeV?=
 =?us-ascii?Q?6YiGC4UB/y7ZOm/zhYrAD4m177MxUlh0BZw0kJmfM7F7E+EQ7Rrl6yfzQEhT?=
 =?us-ascii?Q?Wwa7ZRVmaS4xW9Ezd7gvD0qsYs2D9XQHfU2391kDW+djRINJY+ya7GVDKSgN?=
 =?us-ascii?Q?QdUs0Yji2r2Tye2jRcUpQWxoiLpTuX4F+2qr323g7ewKDOIQYn7aIIQkO7zx?=
 =?us-ascii?Q?MqK12Pvj/aUkHC68dnc5mZRO/fjupCpC7czrtCvYrMm37PeAcf1GDfPrKUeb?=
 =?us-ascii?Q?hcr0RsmcbyWsp9rimgaCW279G/uOkDDw+HOXPBDZ4U6opLnqr7dO9MEHFT5T?=
 =?us-ascii?Q?WGI19kqipHs9i8m49iEK92WDby1ulM3SVTXsO0CJ/RpFmwx/icRC+0m7/LX1?=
 =?us-ascii?Q?Sma3H8IJKEaVloM3I6I4XZO0U2mYLeyQ7CkTUMMOLp9ZD1WBTgAV8nvjzlyh?=
 =?us-ascii?Q?26tC7Kyk9QNW7+hnDSEUuzWhsFfOVGGfl9wObpn2z2lxX6v4rvU+viT6G1Ig?=
 =?us-ascii?Q?ZiHlDfrEVyePYBcbDZggRgGec8DxioC2DdsCTpaPKJyNgEgARo3G2/DCRxra?=
 =?us-ascii?Q?6aRBaV0Cdpu3+VD+Z2OwIxx6xm5zN5tHOUCQRZHjZo17VfDTz+7nzHa0W+lS?=
 =?us-ascii?Q?XOWTItbwdhKWqk182gy6aNLCmYmGbLFHLseyWgfY+DYVBRihEQ0HWHmWS5Vo?=
 =?us-ascii?Q?gxgMFCgDUjOmO7R8Z9h4FLgJt66m9Bh3DVUQMSTlt8g6vBntTNw4yOD4l9y9?=
 =?us-ascii?Q?QbyXZhvhl/7TTxLaJZhITcPnO2S0u/NPc5AciP4CaNNNCFk3lPh7XXyfaVd3?=
 =?us-ascii?Q?5ZqY/yGZpiydpM7N580Nyk8f43Knysh0iIKq3Rx0A5aDC2258XRuNjHlEyQn?=
 =?us-ascii?Q?F9ENukOKyUi1a4WaRl8hpgHzLKxImCPd6B3ruwwUl0HxVM2QgjZx95onoXwk?=
 =?us-ascii?Q?tJc7NDTxPFduVGkDBfg7znnxCoTCf9uf8R3TXLQ8cwwS80h5Ix7/fCtbSqKZ?=
 =?us-ascii?Q?jv0UiABRhoa2w9YP+kizvAudgrGoSIcEpkdM7VeVmg6FLkq+evcZwmNbEgd5?=
 =?us-ascii?Q?x4p1Cf6Ze5wlpcCL0d5Ka82PZz2XYbiH8zsAOcLH/uT/MxQltqEKtxqEJv9c?=
 =?us-ascii?Q?ZOiFfPYUjjYE/iTMJb4c/qMgn110XqWGLGXLx2QS9LUK6Zkkx5eoBl73lian?=
 =?us-ascii?Q?wbScg/l879Rpmj+e1S6TWDSvxqix+uZ9fvx4Ghsbt/7ADFqZqlRO9kWMwYVg?=
 =?us-ascii?Q?I5g1S1GA0WoR7V9VsylOV41nqGRJPEoWpGC7+lpds6jxtQQZ3ZPMETghdGre?=
 =?us-ascii?Q?EuSW/lKG26KxU7ERO0pfltL7L7c2yHHZP4JyS8r2+jsTjbXzm6TmwuChQoO+?=
 =?us-ascii?Q?dOjzLphpDEduFPSwoeYLOLLXUJLhzodtrP9j2vpBWmyC2riE944f1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YkqpCAEKtwmRNkTNpwFVTwK9ZWtVXEN5Gr3bMdmuRc2WLvdHoTJN0IKXWeIN?=
 =?us-ascii?Q?Fa6UraP/5PZ1ggzpr97CK8zbzzaGC2xFEP4ErsBE9c/h/MKouH1dNoG1Mtua?=
 =?us-ascii?Q?63kuvS9Yc4RIAEydChV5ixGdvpID3DlH6rqE0o37PZYfjiWhe0HHb6URf4Kz?=
 =?us-ascii?Q?WqB5QmAmFUaEdM9mA/K409d1oYDAQAW1BTX/Jx+GakfxwTzZmeDLocFYq42C?=
 =?us-ascii?Q?DsM5bC6V77aIC/6eKYQyMtXLouzL2yK4E+ezrhFCJRtMJ/NvYSsujFdtxVSZ?=
 =?us-ascii?Q?2/oXHokypHe3/BII2dGyOAEHZJxlmY4As6VahGd+xTALhPvDyTEXVNCPiOIg?=
 =?us-ascii?Q?BSnUKqU7iu1iSQ1/DDWLkYkMsoae8PwQ0L5zF4l+u84TtFXgBhmo5JjKBpGb?=
 =?us-ascii?Q?o307Uc+7kZyFmLVN+6sO/wxXG6cefeYJ8T8Hr97lU1Z/VWOe6QD6PiYNSyJ0?=
 =?us-ascii?Q?KUTq5AeZCj6TSkChouAp1oTgV6lnl06NnOTfO21GB5pSh0eUW80/dYPGQc9a?=
 =?us-ascii?Q?TmDKQDbn1R/qkSJc6E1EyjDKkwyXi2e6GBS/SzbC0A4gkk7leVCP3MeHiCzH?=
 =?us-ascii?Q?AUceZaKGpkCwy04RZfd0RqKJlxLqn5B6krSbo3zv0brHSPkyH5vNLqjhGeQZ?=
 =?us-ascii?Q?Le/IgXUWfmTkNKXqyhLqAniEiTwl5M6L1v7SZPqfSHn01WOT5EBNjRrkktZL?=
 =?us-ascii?Q?H4LWIl20CglmiT2o+AUvmV3WFfiskGIbs7nPZAui2wKb0/dyxje7o193/QVJ?=
 =?us-ascii?Q?QuuKyg+l1LldvbgvxKuQcsa7WLwl1y9e7uXYvjRX4CXfNZsF4pAb+04HZV4Z?=
 =?us-ascii?Q?Op5EWPETbemNC9BIo2zYk0KLCgTGkAQdQ89J8v2M/QusEqJbqGv1QeKbb2Jl?=
 =?us-ascii?Q?YaoVrn5otb42Dq7JWKpKGzbS/bSiaH4LtQzdGpWcWEzfbuFcMtyMd4hmElMd?=
 =?us-ascii?Q?qVcp0hXyRh6mZbOsQU5so3A4DuaVBBi+0lgTeOe9zqIQr/CHlQ+6fMeEHlA2?=
 =?us-ascii?Q?bdYojhwgc5dbxoo2oNvndMrXOFzJa1Bh4GRUs2TfzhviazFpZLOOYW2OdLrq?=
 =?us-ascii?Q?VLZzPZ1+jUTj4rLhHXJ0U2Vm5f/Cj6plox+80RktbekUSlZqb5+M8BKsCLzZ?=
 =?us-ascii?Q?ZAV0eHvV0XSv3Y36DWEF1UJ0j26Mq2+PKQhmjO/PB90NXjsYnCq57ATKTuqy?=
 =?us-ascii?Q?rZFvgJbsPfmI4BmKem7iTOX0xlycTBq0UmS59/ei2RS5a8jl7KdoDeOsoReB?=
 =?us-ascii?Q?oA3RpZTZqpQDuzM4PtXKld6Auu+6iQqewf9HU00puJT+NsEtlB3q1SGEtyGf?=
 =?us-ascii?Q?+RbEt5OgY5bvH+9HfoDiI1VPcTKICUgkZ3iMgjzKLTC2OdSAJRO+vlurs1Xt?=
 =?us-ascii?Q?NYwAbrxhdhN4PnB4u0/24jw5gK3LDogiZmwxOWVFxMTDlJ0x6Dd1/Te3s2iB?=
 =?us-ascii?Q?VdU7uy11+QRCVm1OVZAbrZSL06YdgVo0m1PGC+PWBADV7DKGPJrbite599wR?=
 =?us-ascii?Q?eQP975QrtcXP3naWQiuXtHyom/tyfBml442xXJPEa9BrkGvH9NMWFeroFGS1?=
 =?us-ascii?Q?bvJqWSVL3riQswQMapG7zKDlyHzlvnnIJQzy77igpToD9Z+QI+05pVM/gveA?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c9ecad-7a2f-4b85-93cf-08dddbc38422
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 06:18:14.0390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUBdTazNJ7LMj7iN8CDO5u1328U5yiWyrJqjYVbTy61q/3DbDRPn8Glg8ZHcGHXTVCk5g0wNkJ1Elv6JDdxMIuR0/GzMlyOUrEx37PtqIq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5497
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

The clk and clk_id members of struct omap_i2c are not used anywhere,
and AFAICT never have been.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/i2c/omap24xx_i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
index a6361d3d17d..2c6f8ea5901 100644
--- a/drivers/i2c/omap24xx_i2c.c
+++ b/drivers/i2c/omap24xx_i2c.c
@@ -134,12 +134,10 @@ static const u8 __maybe_unused reg_map_ip_v2[] = {
 };
 
 struct omap_i2c {
-	struct udevice *clk;
 	int ip_rev;
 	struct i2c *regs;
 	unsigned int speed;
 	int waitdelay;
-	int clk_id;
 };
 
 static inline const u8 *omap_i2c_get_ip_reg_map(int ip_rev)
-- 
2.50.1

