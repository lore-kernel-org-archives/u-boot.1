Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA43C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D8582B18;
	Sat,  7 Jun 2025 00:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uxIUKji9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A25E82A8D; Sat,  7 Jun 2025 00:31:28 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B317D82AA7
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhMlOkc8W5tRdy3L8wL4TyobF7sOK/1nFKNevm362KNf6Car2IhFZC9nHC5/Jcy5KGko3bNrorGLsTacjr4XXPUKZuv9qihYQzjVndbyUk5rYjQb8hVEqfF6xE7Vvg11yuUijgdzlGyNRgzkFmOhPRhCFP64ZmM37keYtgUZIKLUyvAZgMyt8VosEvFYdOIvt2rDKDq/xkfcyVb4LSouMndCrVwanwDreUFtGZJy1b5fp26+ttDwjkhdRaIAErpFYV5FHlfsQXq9P/6DDXuxcmcmHcp+O/URmenAHarhaegeUgyfxJcUdc4mkHtsABYYYceb8uTjLiJ+Y7rdSLp9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PGTEeCzxa5Xohh+9kjs0JbA8RrWrTb1Y7yTVgRuOOk=;
 b=hYUIrtJ//9CaSaFsAIPfDtJ89d650si46RrAIgUHDRWqminNQNgo/w2hb0sQBFJ+ep1T5wMTr8sBDUempmV9Wps0wYwkL2GYEX6x2HtaDmsQxAKTpi7XFVPaRbOE9x1lcPBz5bgoRCMof4nO8RbSkJDqMsMxiz7kGRQhoJIu3ddos2fR7slI3SF8voiSAzoRmz+C0U5ccCE1YcIX1WGupLXvzpAKiFAJ1P6KB3a8fVjw7UKF0KpMlSTzj5pqDYE5OjSAU4HqAEsR+fKJTz7wkMD8stREHmHuOFCNC7Lz5vVtueJEd5IFkmqWXmrK2eVGpc+W5PTop29sU1ijKW+dNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PGTEeCzxa5Xohh+9kjs0JbA8RrWrTb1Y7yTVgRuOOk=;
 b=uxIUKji9+iiVX0eHFgM+mIwqW3a7aW192v/StliLq8nbKhJQCdwqaigWclOOq6nffNKOgYN4Aubgs0vgWVw/DP+8xQHbsZh+tOzkjHbf2emyHFCi3EVT/YPhsvxhfgdV/ejQrL0CBevEem12aQhPeKrJKqPym4jk/2KwGe/MplUuA/dXgEFqV17+j+rNQ7iU59ubAVXAfwLLoYbXqAiPVvyCNZJfo/iQCjmC7UvLGNkD4N3fbFSo3bz5XZLGYjxKXxub8KiJ4E8y8quCXQr5o7eJ/io69MmgFFjDMTw4HJdGZtVq2lzZTHkIkHUVV8x4zHuf8BppbjwmPy/HDrcLsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB10377.eurprd08.prod.outlook.com (2603:10a6:10:3db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 22:31:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 22:31:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 3/3] common/spl: improve error handling in spl_fit
Date: Sat,  7 Jun 2025 01:31:09 +0300
Message-ID: <20250606223109.502055-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB10377:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c72e95-b1eb-4d60-9e79-08dda549dbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hmefQVGD5vxYBirSleCD+am3XV8SqMmhmmZXZHxtVyFmZjpTwmA2tdiMOojJ?=
 =?us-ascii?Q?lh48SYVwpTnOjhjEB2L6xtqR40NKCniJcFiAGYCHe5asrPbcI4c++DB0VPX5?=
 =?us-ascii?Q?dzPtozeBTcc3WiLqGeA/zgGPUr0s2r+TYxb3yv9yj0mnE6ZwP3l+U3fSjSQj?=
 =?us-ascii?Q?QqKy2RnPHEb1m+xtRHmR2GX5+JAgzHxdzd/O2//lg2kCY0IrDNLFbbHbB2yQ?=
 =?us-ascii?Q?YzFADIya1D3mJGDBku0m9h9Y/6BwHkD+nkjdCnP/fRzdIa60TKj7X7/j07QQ?=
 =?us-ascii?Q?v8lliJiRHTzStYbQmmoGtmONRWyj8tZytGoZ0xp8oTnTcQmGHXWAkAAwuNgo?=
 =?us-ascii?Q?FeQ9TnmJfCsYO/WbHcVZeEgB4iruKqfyCfwqy67oAgDizypxK0NgcwMISrQn?=
 =?us-ascii?Q?9UHJK+p5onnYS61oUd8aJGs1D2dhtWuZE6oraxVURkLkE85YNgL45xosABJ1?=
 =?us-ascii?Q?tyNPAfjJpKApqT3IOeOlpdBqs/TwLAbFKkBV1TEW/I6s1GnO2V5QVEigqqQD?=
 =?us-ascii?Q?HG1kX7MEzeUSFocnrvNSsKXIAN318vQw2k/Xz9j1YxMjEYqoQbnH5UdZvb5f?=
 =?us-ascii?Q?N9NewVJRXypzJmdviTI97NTB+Dp3kqOo8tGOyzVx8Gex1AwU81M4E8UxD0gX?=
 =?us-ascii?Q?hO1A8K/AT1NSRUyEHNUEqQlHL1pm8vXW27w9Bzc9RdZe2OL1esMC3/z2WLah?=
 =?us-ascii?Q?OeQz695ZqhzHItaIc7Hp/w+eGeLKIvX49XnsoTXMdg764Hukezofm8vi7878?=
 =?us-ascii?Q?Q1Nab9ppxfTGWuJJJQ0B21LzkKjl6QAscboiQGjDc5AM+QEqgEkxz058QDWL?=
 =?us-ascii?Q?MdUyYT2b4vLU9ucSYFh0qO73Yo2czOMT9FFytRKs8OY8OBYq5eOUOHUkCq2K?=
 =?us-ascii?Q?YGjnuKf7juRjBmr1pSbkRAKXf8txkTF+mGOmt6Xi7/5aCClZv9EbSKVfLuCa?=
 =?us-ascii?Q?U03fE6imFZhjovYxysTo9T/b1xUae3wy1t8fsHmPH8R1ttsY9OumM6dn07EV?=
 =?us-ascii?Q?GoPU+n/zgedIM1F4bjtXSPvIJxMhEVT2brCklVzE5w8t0jtVD4okkgqAz4h7?=
 =?us-ascii?Q?gfnbZg+6Ru1CX11RuU1Q4DzByZN11va0kr6okU+eHkYXVVEZFg4nW3+qYVr4?=
 =?us-ascii?Q?XC6fHdxYR8DoP7aOp2/7nCjraFkgVtsVSqLZPO7vAU120Qy7y0+8CQA+GING?=
 =?us-ascii?Q?KXBS51Y8uaWpRI2/lSweNYEvkVNfHNEmXL48nayPXvYfcZWzmc2ZO+piLsF/?=
 =?us-ascii?Q?4AMhx5PrkgLdpOTbqZk6whA3EmLYhR8NsGTmyZHMyaVDfWJj+Z8dC5RWLMo5?=
 =?us-ascii?Q?wDthKaTnU1maLhY0E0SB2+h6c2V0RAprqwCkj4PSt0JQo7pz+G/BHTf89SYW?=
 =?us-ascii?Q?QZaegpXIDdIM7tb7zaYRvBBiKucftL0EpW3TOdHfguv9dVO2TjOcDWkYSmeb?=
 =?us-ascii?Q?2wGlBITNns0k4C8AxAU7Q3niPJcAtV8ne8D5Ocabqope47IM5moGAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgCQRw9mjq8VfWwIuyrAngI3IovyK/WO4eFlQ8GxIrUfxwiPmLXzq5k+YUtg?=
 =?us-ascii?Q?ce6k+5O9oQnliF7lBnTf1Wv62f14nkOCeUeltWDOZiTXnFgU+hp8CZYt3bVu?=
 =?us-ascii?Q?hBaL0aQMn1r0JB/fjr7C6u+JgH4RFgf5XOKVelAm3KWkt77huHkt8X4LDcm0?=
 =?us-ascii?Q?Fwi9N+T8KMOErZRbM9hp5Zk2gi+A4Nexl/LFK9L7MAAHYHGERV3DgcTY6042?=
 =?us-ascii?Q?g7Q210qgEdgv9CXbWT6LsC8KB4jWTvmAzKO6EXj/9dCr3HTlMNPeCegg6tQ5?=
 =?us-ascii?Q?dTCSX8lbRrdJM0oL+OYPCeNcRismG4xqCoCfx+1EOCXqq6UrZD70mkMcdtUT?=
 =?us-ascii?Q?EOOa6XgmsF/y6PwYhT0dgl0ApdsxAHYqBUy++lSsY67+vcTfuaISg68nOgWc?=
 =?us-ascii?Q?zsehkwgVNK2D0RoW9yQ9mvvnIvszAtpqfzlwjDXgZ3a/UOxK/rVT8IkIIKdP?=
 =?us-ascii?Q?DNQNovEmcxdgP5tr7IU+Qy69LuQuQWDac/Voco9mFJvi65w+24DTyqgK7XdK?=
 =?us-ascii?Q?mInvcwsFUosjSUw5xmKXErxOlps7uldFZl0Szj7cQkwMB7MnYzZRwqLk8TTm?=
 =?us-ascii?Q?owLvpMJ2O/+8wUQekfwYkIRjenk2QVwSTHFpCRG2S1J41AbVwHzrtAXgspvP?=
 =?us-ascii?Q?aeKeSCBji32SrjU9RCkMsqct2EklSCaxDWxedB29hzYZs8/tF1iphIT4bG6K?=
 =?us-ascii?Q?yfn7jZyESo7AXEQFBOnag+NT5rCxPu0iavS2HTi2ZeQbyyIIkSRg36XOD5zC?=
 =?us-ascii?Q?OZUeIYgTLMMIQbi7iB4J70Acvlw2c8mDstSSqtNsD+l4KrmYTV1w99yqv4YR?=
 =?us-ascii?Q?cqDcwbEmr1fpSQf50gQr/OmijLU+RCEi2Jr42JDJ4isiFqOv5dtsoInIloma?=
 =?us-ascii?Q?P1oBWmvwZCzHvJrhhno5GP92EDMd54TA4LnhmklJMutJ37TqUFKh1o4Bead+?=
 =?us-ascii?Q?pCzZxkmmOwnyUqZ7iOHoF+HBeX1mYSmU8qtN0KHUvwGK0I5y0SuPqQQAhE7v?=
 =?us-ascii?Q?cQVcuC49jwupFwkK3PraeGEKQ5KTPBVmPHa/eSUB+E1u07XOLjR1JkukHBem?=
 =?us-ascii?Q?8OCTS51ZgBopoCL+k1dvR/BHANYyZ6N1GIinZrd7Rurjr8Q8fT2Yj5oSZ7u8?=
 =?us-ascii?Q?Y0PSqEgkydXQvaiNiNf3ssYGcxXKswe1KQsvbPRjvj8psO0QWqjhd5OsCCSy?=
 =?us-ascii?Q?fwcOcWIqaP5uiOH+MTvQHgG7k1uTs/y5VWhHoK5yleGJmZd26H7ajKPrB9pj?=
 =?us-ascii?Q?1yZt0odJTehB1LC9lsaPipuQiEmApDNVdomKdqP0unsGOPk+HvCoqn0saS0z?=
 =?us-ascii?Q?mL8+ZTJELPpDr7tUzlK+9CV/YY/2tJcNF4r1TulYogoPUVZwoW3tPOliHPOm?=
 =?us-ascii?Q?cEwltZZD+ztPychD1ELMuAQssciywCHyWsl/wxFTBQHsx8v6BFYYzPf6tQm/?=
 =?us-ascii?Q?A+jMNZXYAai9n6p6qoDOmTm1v3ZQjlnhmzktfGSvgAlsTyV1Lr4YKzsuV6iV?=
 =?us-ascii?Q?6B5gE4wCiLa2OVLULrtAwj32gf+OHd+PnEo9Bd7ZvTDMFaoI9M9cB3CGINpN?=
 =?us-ascii?Q?ffFXYKMh2vhGGgYCnsY+BlsGdpOiDYrYhiKqqaW/FZ9HJAbv6NRlBcTTz8Tj?=
 =?us-ascii?Q?EeTVen3gPtdsz92jKw6gieM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c72e95-b1eb-4d60-9e79-08dda549dbf8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 22:31:20.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ToS5lxN/ZEgUJ1DjRkRjuNXcLEl4VpcAfu6Z1ZaLCb4weqR3unGgl6Xincz/EX11I0ULzgQLeQD7wZCtYu/pfoBXwQLqRBoK8ASjxrOsdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10377
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

This fix a possible NULL pointer dereference.

There is also a risk of memory leaking within the same portion of code.
The leak will happen if loaded image is bad or damaged. In this case
u-boot-spl will try booting from the other available media. Unfortunately
resources allocated for previous boot media will NOT be freed.

We can't fix that issue as the memory allocation mechanism used here
is unknown. It can be different kinds of malloc() or something else.

To somewhat reduce memory consumption, one can try to reuse previously
allocated memory as it's done in board_spl_fit_buffer_addr() from
test/image/spl_load.c.

The corresponding comment was put to the code as well.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 783bb84bdb5..438d1ecf124 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -703,13 +703,29 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 */
 	size = get_aligned_image_size(info, size, 0);
 	buf = board_spl_fit_buffer_addr(size, size, 1);
+	if (!buf)
+		return -EIO;
 
 	count = info->read(info, offset, size, buf);
+	if (!count) {
+		/*
+		 * The memory allocated by board_spl_fit_buffer_addr()
+		 * should be freed. Unfortunately, we don't know what
+		 * memory allocation mechanism was used, so we'll hope
+		 * for the best and leave it as is.
+		 *
+		 * To somewhat reduce memory consumption, one can try
+		 * to reuse previously allocated memory as it's done in
+		 * board_spl_fit_buffer_addr() from test/image/spl_load.c
+		 */
+		return -EIO;
+	}
+
 	ctx->fit = buf;
 	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
 	      offset, size, buf, count);
 
-	return (count == 0) ? -EIO : 0;
+	return 0;
 }
 
 static int spl_simple_fit_parse(struct spl_fit_info *ctx)
-- 
2.47.2

