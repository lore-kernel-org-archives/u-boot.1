Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B73CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 06:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA478329B;
	Fri, 19 Sep 2025 08:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="C5hKRlsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D41383314; Fri, 19 Sep 2025 08:59:13 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A7F8323A
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2A+NS5S7XImenPZtrFkdxXn16BKz795mo4QlvZTSvbggUBCM2ow0KAddFcIrHP90Bv/K/dZ98ypvBAMj8+MMVHnZICR09r4dF5sgPsea4AHN30mA1o2Nz4r9cCq7esqLIt5ir2XH0f9qkVZfKqA2St2vsvubDqrYgI8iLCdyRDe005/6Mw18cZ7TvR2iGTlWjAHIuzpiiCPJzE+Jx2y14z24PjHtr5oxlAR0tTvO/wzKkgrb+GeItDwlu/h0ddWh9ASOPxs6kddG20G+rTOyBLr79mjsgJVCbYXeGTcXaOryZyOE7SJhyBnk8ZvffKIwouLdlGn4Rm5NeD5S6EnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXAmuDk0iJ2xTLfkXDfzRy3kk2SggXA0hOzwnHvJMIY=;
 b=JnzaRKHby1nCwOhdi1ZcLQ3ZV5OTR3miYggwkqGO+gNNiGE20plxyj8H3ckwXZtRrBfxw4DkjxCTCFpQcAYbHC6ojgCOLpyL/4XkUMwqm1d0GNCPmHyIw8vdQyzXmWWCy4qjPGSKoXy8MMqX5zPrOrlGkZW3qvx6jTFu0QrNTrbJqbfHZA39Q+9FhifF+gi+M14e2MutOqjRM3THKSk1ip7+F7nq4HDBosszvhEB2sfXcl9/++sY70brFx/l9XPVOfpcx3LfRjvVho7J1e6FZwmBz1isg2l6lJafr6qjb6GVC0BIedf4bgccEFILE2HwyDx1F42AUL/uCYv7qeFVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXAmuDk0iJ2xTLfkXDfzRy3kk2SggXA0hOzwnHvJMIY=;
 b=C5hKRlsztUwqKfj4DWLD+uVX9szqO4VOYs82NFTDJEiGwpr1wHnIrrqdmSFMNXQ5v1FOp1vEFL2zWEJvJrbNTupRPIq9+iEWvRAhC3Hmt0i8zh6S++ui3N4k0GSuU3y5lenS6eibb9JafAukGCbm3w9GqANMm4C1ALKXU35lzY1hIG9OE0vEy6uAuVzRL977ZEoV3R8NFSJpP+HZJXyKBiQH3BD7Bi/LaW3ZpL2rNGMF73/eRNaUQmqWAVaMP9i/5kk4nwWem0wss/t+coGxqExWrVA1DSDMYqkxAr8tZByPMq6jCzBYClHjA05aMJa8JaneUCqzfMFBcdwy8FJ/ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 06:59:09 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:59:09 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH] arm: imx9: Fix LPCG number in ccm_reg structure
Date: Fri, 19 Sep 2025 14:58:34 +0800
Message-Id: <20250919065834.1497068-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250919065834.1497068-1-ye.li@nxp.com>
References: <20250919065834.1497068-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: ff91a750-310b-48c1-b81a-08ddf74a07d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKi3t6tF3IdZ8czQVsl0CkcjM7Jp6ogYLH5hnHO4fQ1HvNcuz5xhH0mz7duL?=
 =?us-ascii?Q?/Zk4lUqK7IwI5XZLcobawNSC+24xYRKnibGXHv2ooHBygUQP/u3QzCSoKywP?=
 =?us-ascii?Q?zBDsqQKisMj3TerixtJB90Y5ngGpmZU8H/bItKeZ/DqmvfvoR6zKN2Y60dP6?=
 =?us-ascii?Q?jHDCM0L5h0w4c0Ktk1Bn4AxcGtew2sH3RqoEpykVd8p2PZpT8qnm6KII2iQv?=
 =?us-ascii?Q?l6HuPBFSdckhOnQLDr5evZPLFlV1QZLGBEj5YxIdRUMjn2qLXviWTMa1oa35?=
 =?us-ascii?Q?c1LDLpHkuGgpWAs8Yvquq4/SXGjD5KQZ6tWNkFXndsZBrPCUOr/MqX2Mtpqp?=
 =?us-ascii?Q?sH7bBO01taTPhpMpOb+OMZAonu+ea6WqGO2u+ZAwmPS8SIbSeQGA7a1UR2GY?=
 =?us-ascii?Q?2Yao5d1fQmLq28HUQG6TCAS729MVdwLm5pATNL6fbq8mLVP5SiMmqXI+eZsj?=
 =?us-ascii?Q?MmdWosP7r5n0vsCj83SwecZvmAhhJcqIwbXrup2ICBGLL7PnlfuFrPHNkxq3?=
 =?us-ascii?Q?0V8JIzHoTwESo+06v2LYj0GOK2WUGUFkBu+zObocjpsFlEZKsZU8bwlAK0EX?=
 =?us-ascii?Q?mHd0SdC1OnnkdSbCYv+Vv11FifV2BgWWia2YVPu2qewls6AYxd69PWMixCfp?=
 =?us-ascii?Q?Z7v8rLh5T+gLE8/z+ADc78/jBl4E7KKjt1OWZEaWATv+Dy2N8cO2DdBCK5n+?=
 =?us-ascii?Q?h2lXoAgJgwgjXrB12wjR1DgYcxsmf9W+XONqd0mfy30UrnLQ9dzXdayHa1vE?=
 =?us-ascii?Q?UMrbEoG2bxhbb2P4u6BJzEnJzSWaVMc8C5ugNLyx5RSJKQDwrs+EqukcH+ZU?=
 =?us-ascii?Q?PHaZgO3iikqHqvaDUeAz7kXtXDBMMz5lELjm9YRXcm7vY/5hIeASzVztQFYr?=
 =?us-ascii?Q?WwnnC8IyasA/dmOuEKbXxTQKvyW17G3LSMtYjmtVHDa+D5Gb1f5npcJgMsbu?=
 =?us-ascii?Q?YxL8v4Jsl5YW/66ym4dxAhEDHWp87cw6o4hLEmLDtAKSPX5C+731I2nuZSaZ?=
 =?us-ascii?Q?CnZsptJk0SniDPwJJRe9hrCSFGFHIDLnq+ke4p7Zcm2c5u0I8Lzpbv3pXMeR?=
 =?us-ascii?Q?DRU65leQIsGJhcKbnAxV2KiTVK73VFJJBzFQCAbgdqLOPJXVVqaFdIta75R4?=
 =?us-ascii?Q?fmlBzmD7UuFslvkS5Zt5t9VVLKYBdjFkp/NWkHscp2pWxSvLaSH2yPRDq9nR?=
 =?us-ascii?Q?ZcXcNW5fcRnUdJn1lR9nFDeiyGGRO5mG+aUjDlhJz13KS1Hdp26AXdfVTjK7?=
 =?us-ascii?Q?g5nkvpQKI7Sj1Kxs3q/wrAifEg+gf24oUS1XJ2n5vbYOczJ2fHR+9BSd++gg?=
 =?us-ascii?Q?EyXuFi5o/47XK3qeM/LqSaGfQGlnC9JuSkNafD34GkTWC44FDLiYr109zrSb?=
 =?us-ascii?Q?MGQ2ToukqtyzwaAOOfhtH6UV9PIokHgZuZaDZ36PDX/o5ZMMHwUDrdB3EwQU?=
 =?us-ascii?Q?Hp5W4HiDZu/eA64n8Slb31wN/1F0fRhjSIuJEHBCuuJNG/Ny3RR3Hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(376014)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Faql+4yU+qtJdux24LOGnKp92oxQhMDo0c1Hs35pFTwThTXmBgz0F9cdx6a7?=
 =?us-ascii?Q?TAMWn63ViTQwPZEPKFhsRI2eC5a1Jv/0cgJBzmbqTXrKm+IgBbuAGFI7Zfhh?=
 =?us-ascii?Q?+h4ibhzFg6LlAejbGYsLj0EYkhNN+Fk5jRX6cXNaNy9hrpTgqloDThk2JZW5?=
 =?us-ascii?Q?L46GUaxjws9yw0dWLH3qBpXLGMfjk4fOTZA+dwUZeYdl6pHlge/0uqf5uf6m?=
 =?us-ascii?Q?lEG0GFugKkHklby91t0zzTtLIR+7WrJVNIR+JdhGSxiz8FoKYeTSPc72nl5L?=
 =?us-ascii?Q?fIbQKPUey6W8vdXWFjBfMWcJSyrVWHizW7123j7IlHkvR8/JYHiu7n/J5UNK?=
 =?us-ascii?Q?uLDVE/ifwpAsxzCONC5dxhomS0/RHP1DcNK4WLXe4gpPs+rgBldst0M3h4ep?=
 =?us-ascii?Q?Lo9iziHXjlxpAQumSFTIOYKslr1OFrHDmtKTS5IZVcRzZWQvJhNfjUm9Lk9+?=
 =?us-ascii?Q?2877dDF86669fBPjFwslxAAE+nvc4pQ7gwBB6XrwxMnuJ1NtGqzmM9aT/vTi?=
 =?us-ascii?Q?4pvV7y6A0TjoR7/N4/PDqQVjUDzqlkrtWriU+7lyruUUZ9CG0JmU/M0whw/G?=
 =?us-ascii?Q?K0cejYfCBW+sYliKG/HEZIhx849oKyInhblHPAmMSast+Kgr87P+NxSskddN?=
 =?us-ascii?Q?TsSQAjd30r4uC3TvkQHt+whpZynIvTyKIa7LR7dQGfNnxwE0kMWtYdb/YjkT?=
 =?us-ascii?Q?WaWybXzbMxbfIeDYPekQkzJlBYS84poYKcjAdBdZXuhUC5CIMHrz2181OyhP?=
 =?us-ascii?Q?FfNazwUfHidnAYcIlhKlJKvafKcl2NdGCjm3fteyVq46Ww8HrWSOcrm+C2QF?=
 =?us-ascii?Q?blews/Mx8zVsFm7ZJNu33tSfqZDvS3OwSaiEnTQcg3eLZZV+zdtX6vvFSktI?=
 =?us-ascii?Q?+LNldmxAAcobm+UnN0VZkz41EDH1V0w8ZOlGLrV1Ykv6MtWWkZbuLY+9sNsX?=
 =?us-ascii?Q?1coGIqrDFm4PGlpZhnzrG5VcUNATfevEHwY+JsrmhZei4qo5HOyQ5ZbUBoAJ?=
 =?us-ascii?Q?QDivGs5BB4L+Y6ZI7/cFEz08WZ5TKKbQXSCDjQmPnbdR3Zz95HG58KQTRmTO?=
 =?us-ascii?Q?2nB+hTHlrNBQzzRIE6ln7X6IJ5ECVG8Vryyi8HrPVbfbdYl8yv1EZNldg3Mj?=
 =?us-ascii?Q?pI8pp+K4JYshwWYxcECNjNpAl92cB9BM0Qj+fRKwPyT0hVMe5a9gaFjOapxn?=
 =?us-ascii?Q?dK+3eacG1BPWcG7wDrUIqAVww33sFfEvbcRfVWPCb0bSBbA2T3ugDkBmRXzs?=
 =?us-ascii?Q?6xQwwELreQmBBEDg2P918BikGQs1bD2DG4ljc9pNDmKLpqaTVXksrcSfjdfn?=
 =?us-ascii?Q?6t9JIT5yymqxsTVYx9flQLoF3DjGA+/1n35XB7eJj0Qch9+yIuwHIJW7hwin?=
 =?us-ascii?Q?6uTLjO++ALNGWtWoFJ2Gy865Pqjl7Tnw/O/swZxuMxbvno8v1rE94vUeg3Ro?=
 =?us-ascii?Q?bGtfWBXDrgBqLACfdF8y7+JVYRqhMohAI6hYYbkYm8cl6oBXhC2Kshqa6IQG?=
 =?us-ascii?Q?9yh1j2AY0BcZyGb65vbmWiky4zJt+8Q0Or0A2Ghv7ENZYJbXV31A2yVMiEnX?=
 =?us-ascii?Q?aZKVD+Oo+KQfLsKtdio=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff91a750-310b-48c1-b81a-08ddf74a07d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:59:09.0820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ6Y3riTHyvx7K+NZCb8Yh+yEkhxuU55EBPdQRqpPRgByDlemUsibYifIToFdSeU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640
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

The LPCG number on iMX93 and iMX91 is 127 not 122. The wrong
value is used in ccm_reg structure and Coverity reports several
issues as out-of-bounds write.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index ffaf6b5f7d8..ddc84d2c9ed 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -111,7 +111,7 @@ struct ccm_reg {
 	u32 reserved_3[192];
 	struct ccm_lpcg_oscpll clk_oscplls[19]; /* 0x5000 */
 	u32 reserved_4[2768];
-	struct ccm_lpcg_oscpll clk_lpcgs[122]; /* 0x8000 */
+	struct ccm_lpcg_oscpll clk_lpcgs[127]; /* 0x8000 */
 };
 
 struct ana_pll_reg_elem {
-- 
2.37.1

