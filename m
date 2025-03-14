Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F9EC28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136AC81D4F;
	Fri, 14 Mar 2025 06:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TyWMixEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30FDA80F9C; Fri, 14 Mar 2025 05:10:26 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9B6808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdo2u7FjgWoH8wxQFjq4BoSKgGSFz/Uxh48NKhFTvdIibsOxAe1RCrbr7cnP3FXLTt+9wTjfB+Ci1nA2ED/XSf5njIRUYvQZBXV9+OlcAHtRGsCHssimrINrszxFVQ/GIgS1aXItEjNmc3wUSbxGFPQmnz5xQ2IZxeEFMKol4je6YNr9YouoyTfUFyZXvPZXVeQycPmtSGsPgcEnl/aevxP7pTHdDnRRhifpiNirew8dxlkUaxC387007HRdg8NPD7xpf8WYqgKfWO4TC8gSwc+jz4kEMNYXGhNscUgImkkIwddPVhVgV0IFB7DLHp/Ck1cNveZ6iCd062ZS533P3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcqWFj1FNQ9EAN+vvWcrd2/otJEddB2tNLCM5knZrdo=;
 b=WCiig6UdNFGd43NWVNdCaxOLtU3jwUYIjyrbiSy4m5S7AKfgczZxXQA1vkcd85CHNd86LU1imH4XugMF/51NTI0d79sPMxyymNvo4CZaX7DvpVT5URMSsrXauVKklC6AF5pMWRhVbzGCTo8f+/0crsT1LsAWl3Y9oGE5JoyuHOhsZl9JlpW1gvUVImIRYO7P/iTVIhXq8nIevL/fj/v3mZFihEtq8/L/rlhxlqx5zsZQ5fpWxRmP8NATnqKVa+NSSQBv3YbqUiz90vfXtPXOTwee/xysnF5lSt5hjRE/fOLoMJHKKFecweN7zjyHPMyGF6XqDm1QpHSzSqnqcundlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcqWFj1FNQ9EAN+vvWcrd2/otJEddB2tNLCM5knZrdo=;
 b=TyWMixEFbou/Dmw6GiA+BBJw/wQBro3YDQMqh+nLvV5f4aYnf5JL2GF6qnA3+Pya5XC1ePLjkEESOssbFEkUBk8jJaFb/vTvvRNc3QYDRQMVQBRlWMfci7l3CbQSiEFeQvV7os3zM7GmNGm56brKFBwB2nZdeFwl/6qgtlFIVt4VIlI9cF9slC0XDWV0RNTSzVFQ9ZTps5RUrsIHXLF61uoDHIJagYRblRE5KBy1/2KjZ/8u+4MtIYMxtfyztCo+qZ9RSTwJUmygS83rYGW0z10QfTdjwIHP03uCoUvaEnwdeEu1L4Ob/hbaMiZnHNwfCT4zlmwGkSDkEtFgjtsF1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:21 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:21 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 08/13] i3c: master: dw-i3c-master: Fix OD_TIMING for spike
 filter
Date: Fri, 14 Mar 2025 12:08:57 +0800
Message-Id: <20250314040902.43621-9-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cae7fb-8a0f-4639-ce4b-08dd62ae22da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w8RZ1WAjPU5ysOaIi2Qj5P/fY/YuJToSZRmnnmpPqQtFPNjrX9/sPU/5mLHZ?=
 =?us-ascii?Q?dz8O7nGNXHUOtu06zRyOeDJP7Xyfg64nHW1vbbxMVnvEjNchJ5Oa3mD6F1lG?=
 =?us-ascii?Q?UkhTsv6HFaxy5+rEbsfPKS7OPcJETMt213K6qeiVaDZTRGLJAiuCLaeCK3lN?=
 =?us-ascii?Q?roirjXPsfYzxxeG7tcuyPqTqk1OxwdEoYj0QEaXlknHjZfbbsPzWxzYwhgjy?=
 =?us-ascii?Q?Bfcbj1PAjaPdU7xwPQyz2NzgL3LoAJYYgF0oDFIJiQqRlbzREAFI3hdeVuXV?=
 =?us-ascii?Q?iuCC1krdofdxh2bnJMh0Z2yK7xQ3xFYqucjCbZHfPVmMBynCVZZzX91GjCX9?=
 =?us-ascii?Q?STDqCGAjh9KDvuUbcnsIcyvn89+pZd8OHne6Fm5jZOzqXFKncwWzFqtRJgdv?=
 =?us-ascii?Q?bXnDVVXl0EOdxXyKNo96JyoT/aJxbgjoPuClUA4MmuX+PLy1+CSs0lMffIen?=
 =?us-ascii?Q?c0OCPZnJb9lyQZSHLgPq4MqYaixfRJhYWVxm2lf+7GPNlUYEmlcxWrAjMpCw?=
 =?us-ascii?Q?Osjh4ZCS5fCWSIP3kS4oa4LXNZ73gIlPTgAQlcqlcqxQLsINYfmCtEvEFtt+?=
 =?us-ascii?Q?Y/iLLr2mVY2GJcsWrByukdrbey19hP4BuGBywTE5XNxaRd8ie+6XFPP3Ul87?=
 =?us-ascii?Q?Mo1eK3dm5VGlB03/ATatNLa8DnqIjzROxowIALduuWRGmFjK+SwvaLrePb/Q?=
 =?us-ascii?Q?As13SGN6UjwDbqiPnLS2m2AZwqaMQWJCiiEf4oMea3TN4q9yZ9rCSYhtqnwY?=
 =?us-ascii?Q?dWUCzIItSFIkBULZdTjus7TCSPSLuam9Ot1mRh4fj3PPMqWIXlVOKOULBjhT?=
 =?us-ascii?Q?rI04IG14cl2ZO8D3HM/rymQdCtArdFcYRhEPu0gtjMmpy3EmstFV7aBshmIR?=
 =?us-ascii?Q?FZtEHHRfmllTPO4ibYBRH2J/ho02pWDbTYSho6vL8iSPB1X7v7MOIieOyt3Z?=
 =?us-ascii?Q?t5uErVjOKOngFpyBxv61xtC8i3Ld70PEeoXZcl02G40au16XXkCxLpqodkB7?=
 =?us-ascii?Q?N3Rqrayf1Pf2w1cJ4TKbRmiwux2LGcqSccFumPVwyolD1Hh2MuQ5yG8Oe5Tn?=
 =?us-ascii?Q?vFIB7hOcjJ71G8CrO8gXyVMAg2UGeya+50NsKTamGMyhgd5KAS6sZ6p5lNYH?=
 =?us-ascii?Q?tQavCzOEHUfnDOqeQdLgGfLcOKr9YG88ItFxNNiXLPFN36fax5G4exQ7DyIH?=
 =?us-ascii?Q?yF5pZ10AchiJP4hZiROVWYdtijZ+dbP2+4/stzmewrQW/G9CKOl5ewmbtEVx?=
 =?us-ascii?Q?sSI/rzWzrh7aYylad+Nn5cGiVnPMtPUyGhuWOH26IwxIflVMb72r+VrSO1Dh?=
 =?us-ascii?Q?xiyZjCrlpT2R1BkaRdWVrXVwKqQ49ODJu+0rT+PkjqtxW8bo8MYdT44VKxM4?=
 =?us-ascii?Q?FLYobQw5txYbsSvZ3knqQfC9N5Ro?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dslRRSCUxoJTRgv9QwLVdu7RyhH28U563nPRIofAbRm09ZpLeUf6YehfDiES?=
 =?us-ascii?Q?P8XDHt2J6ka0HmCjS6rQy0i3pQTzsLn7Wsw9HqhxyVbVJL8MprYFjEepIZ4f?=
 =?us-ascii?Q?ahzwpXGdFp7bOo3Y3v+fe6rq8I4OYhP11bHZRSkXhlYrbJV7SbuTKOQ2P8Ow?=
 =?us-ascii?Q?RMnrT0CMBqcK3Tog1N0RdBI/cTWihFaloafZaNeKVVbsupRoMYaiw8l91hWP?=
 =?us-ascii?Q?mJs8wl6IZv6KYCw8wKtlK1MIT5XDE2KMj1Hj6hT2Ve+XPUTZh4A3yffXhOBh?=
 =?us-ascii?Q?LKFCLG6bSyDWC9IIyz4ZwzwYmDjMgEyOEmvpms1xvBk9viJwqsqI/4GKaH69?=
 =?us-ascii?Q?bg0f+yjFdXl4lO+Sja96bN2Xr/efCQhN1DXWVl8FphByO6RwXhxkoJ/4avoS?=
 =?us-ascii?Q?N21+D7InHv3I2Hoio3chLSiboqk45rSZb/nWwp0wT1JpBYTZFL19S29aWY2u?=
 =?us-ascii?Q?WogNzxGfC9ufDrogiDfgKMCMuLPxaYqXaE2BIOZdprBfEelZixYGLL2N0tUe?=
 =?us-ascii?Q?irn0n53fihukrH23txrzRY3MHEFI5UMzSPMMRVasSKVth6YvUVHubFcoOFNi?=
 =?us-ascii?Q?OLp0a664ioXXUy3cjRvBh1aJg4XegQbqFjQBECRZQtoI7DuarkbNTvVVsiFg?=
 =?us-ascii?Q?XwfZ2PIBl3+uvUMFECQ+3udykHwJlG0iVgbGr30ljFyViDrT/827qBAVUKe2?=
 =?us-ascii?Q?sHOBFW2260cymbn95F3uPcvGzPUDlOu71gzuG0V9aBLrF7WOmXMoGjQLrJbm?=
 =?us-ascii?Q?/czs/2YMXYkPKxT1X74/RreYT4kUAQQhv58b3rpoHqk3VKKyu34o9oXg9s6L?=
 =?us-ascii?Q?9UqVK0afqZZwsg+066bFtU1Ggv2r1YyKDwdlx4OO7jIeo0gQ9KLULNhiyhQh?=
 =?us-ascii?Q?HX/4/eUNicqRqpSpwGxVOEIT0XBVV6/jnGzGKlbJ9gshQldcbTrXTVOptE+Z?=
 =?us-ascii?Q?+WfDojHVvekwNSwHqZRyilV1CIZywZuIAoy7DGfojG6FmMayNfjDfts+yJ8r?=
 =?us-ascii?Q?soeeRvWQ2ZT1oN8FmZ9AYNN3E1zNF/lUpuFfjftIv3WRgFL3EzoZ933GoEzm?=
 =?us-ascii?Q?FemNdQEO++uox3+vgrfc763mG2+b4WpJcw+HG+iqF5bBwdDg+v9CJKjCGfhd?=
 =?us-ascii?Q?03zaf7mbQQog1mb7fW5F1DS5qF8/TveTvl0dNPK9G60dEOV4+KVtJv6PDM7U?=
 =?us-ascii?Q?LttcdXYELPsvZndqnegP0LPBpmORxLRlLxZ2xqWFUB0a6YX4KBGp6PzdExtw?=
 =?us-ascii?Q?vN1FAgY795JedKJXMJLAW7dg0MeLfxwDoGAorpTLxLFZUefKZthVbt6E/g+H?=
 =?us-ascii?Q?ffiNRNd4eghKrh6iXV8ivFindtercv0EoHEEx9iMDpq8ItsMJOjgYufmhnZH?=
 =?us-ascii?Q?bJ+F6y6ivQ8WCyF6fDXNA04Gdt7rmpGkhj0tR7G0na5mUxInwfxq7eYdPpJf?=
 =?us-ascii?Q?TWNGtyBSKiZoULma2VKmHACZonmJWqd49TYt3lqE8T28uJ0jKkjmPdbNtO9N?=
 =?us-ascii?Q?zbbzdl+igpe5i8o73L5klV5PrPLaAnsYH50oWcFT0x09JxJsURMHI8IW5E4u?=
 =?us-ascii?Q?oE1Isoxyk4VrF7EixUNwD8onZboXeim83NkLnUXalh4o38iL2Nu4PWYizmYp?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cae7fb-8a0f-4639-ce4b-08dd62ae22da
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:20.7823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SF/8xYU70lBAEC/5OH396zrFE+RCP3oTBk9AFX1AAxRJugibdT8FNl2bOaJBSXtVo/4B+VshTEUrsNXiYykAAx9R4ph21/7Eg9xVGGrDpJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Fix the I3C device with spike filter unable to detect issue by setting
tHIGH_INIT to 200ns for first broadcast address.
This is according to MIPI SPEC 1.1.1 for first broadcast address
which is already part of linux upstreamed patch.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
 include/dw-i3c.h                   |  1 +
 include/linux/i3c/master.h         |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index b3c5bf210c6..af6e472f232 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -330,6 +330,14 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
 		hcnt = SCL_I3C_TIMING_CNT_MIN;
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (!master->first_broadcast) {
+		lcnt = SCL_I3C_TIMING_LCNT(readl(master->regs + SCL_I3C_OD_TIMING));
+		scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | lcnt;
+		writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+		return 0;
+	}
+
 	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
 	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
 		lcnt = SCL_I3C_TIMING_CNT_MIN;
@@ -347,6 +355,9 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	lcnt = max_t(u8,
 		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 
+	/* first broadcast thigh to 200ns, to disable spike filter */
+	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_INIT_OD_MIN_NS, core_period);
+
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
 
@@ -402,6 +413,9 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	u32 thld_ctrl;
 	int ret;
 
+	/* first broadcast to disable spike filter */
+	master->first_broadcast = true;
+
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -481,6 +495,15 @@ static void dw_i3c_master_irq_handler(struct dw_i3c_master *master)
 	if (status & INTR_TRANSFER_ERR_STAT)
 		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
 
+	/* set back to THIGH_MAX_NS, after disable spike filter */
+	if (master->first_broadcast) {
+		master->first_broadcast = false;
+		int ret = dw_i3c_clk_cfg(master);
+
+		if (ret)
+			pr_err("Failed to set clk cfg\n");
+	}
+
 	spin_unlock(&master->xferqueue.lock);
 }
 
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 920f18bccb4..42c37d6dfa2 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -240,6 +240,7 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	u8 addrs[MAX_DEVS];
+	bool first_broadcast;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index bafb1448b57..c2391170ae1 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -278,6 +278,7 @@ struct i3c_device {
 #define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
 #define I3C_BUS_I2C_FM_SCL_RATE		400000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
+#define I3C_BUS_THIGH_INIT_OD_MIN_NS	200
 
 /**
  * enum i3c_bus_mode - I3C bus mode
-- 
2.26.2

