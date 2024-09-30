Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757BACE835D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEB688FBB;
	Mon, 30 Sep 2024 19:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FA388F83; Mon, 30 Sep 2024 18:07:22 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn
 [139.219.146.115])
 by phobos.denx.de (Postfix) with ESMTP id 6E41D88CBD
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyiNKgPY9/Ty0MducTLANGjpuDkKpKGtMf2vtFLdbAQ1RRc/lE6rg1wftw4fH/L0Li4vWC3nzE0nAwbzfTy7ZulG/dQLdTd2NcSpeQXRjweRKNzJY2RAlMOiPEq0TsEsYYrwqIL5WQJLSrxzi1ZqizWoAEouQjqV3LQ4OOJ2pXwajplHLZvYqm8eNstOPee1i+N4GZa+pIho5HuPo0zIcDrNihIIDdR+hk1l/dkH7xv50vLohV4yv5EVFNpRwbjiUJte6ZFGdNH8fXSOQLveEgBkpuP78rZ7SW0kxmgNMUznstROKfSntHJyAfdzmjT7Y8br44yxQfDkjI7JXYzQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wt1Ky582IM/u9xUezKpekkTmgj6o/u7aykerTZmafE=;
 b=PxILdm9ipDSR0wXRRR8wf/XKUKagu6m2xH5yCq4oVyBWC+o627RY0WgjOrwMa3tQboe5+ebIUeG6L1C1iw4mTmqMEJrInmhjOpwKppw1yDkPfAqvNJTT3UbFL2WKAHpm3n1mpX3gvGiysh3lz3TcURGuJu2KIAiWP3Pzj3HSgS72W0vEIiUmdCQrB36zsBdfpK0Byvh1RWukgQX3jppYEPrgqJ+ppOqufbF8FFKsVMMJ/bHMZxmWvwgb91SdzC8JORUyrlBEZEaBXa8p+3RZ2VG2oBMwITU93QFaDRTY7rMPlO0bRDIzcMpi6Z8Ia/7WJzkRWr2RwuTXrANyLahpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:38 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:38 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 10/12] board: starfive: spl: Drop the unneeded DT
 modification code
Date: Mon, 30 Sep 2024 23:59:17 +0800
Message-ID: <20240930155919.111738-11-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b7ac1d-44ca-4c84-74dd-08dce168e30f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: sGRZAoggz6npC7LVbG5cNOkXcHLFFeApoOO2s3l9se3xbS+p49/UqEH8bFzq6vF9jMt/CF8EmIfaEtgReGE/6GpiScuMIKvOwrw9X62gXq1VhgqSYIyyYJ+1RHFjGFcInN4MlY5SidcB/m/GICyiPAvpUkXXmCkN6SfucHpu20lqpupn5OpA9k5GU6SuuRZOkmGxjoVBVc8tAX+JUslSn/g0ZAsS8IUwtESRq9Ixk5WAMrigJlt6sr5gmJLxnnnp7XcmKOT8orI/YlIypjV1NN2g2oInZPjnHdsThaAenz9t1+zJJxKl/7KC31ggO01UKMgI06Kf9bA0+O4JtSLXs44XH59zPz+4FsN8Zt6Kfrjc4WvJgtTW04jlT13zNaiPr0kKwl+JJzVI7ILnRDGSOT3abO5lnFD6kSJi0fjuLauZtrHzd8nCZ0meUENoiClpdA/f1mbpIZjI5b+ovIxyWV9GOrXDaaSx0KVMjSmpjxjjjrLe7zntDfG/xU0wv8LDZXiy6A6+1FTtpaq+x5SCmb/vW9w2yxtGmcuTzG5U96OwwhkY+xgXp63T/SbbJPa2NQWnEBo0p7zC6s4uLdpRIHoyGHmak7XxHtOMdzwNhNImDCidSpQgjm8sxTyMRCDL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0lw78dq9Chk+TdIiGCh8w1JlBIlpvOnN8L+zR56QZTSZ5s1flH+DGALQIAfb?=
 =?us-ascii?Q?8hLlxwnV9wD5J4BSFxTPPerFejcsVmn41L9QzvM60aXAttRZwztgeIKuJsnB?=
 =?us-ascii?Q?rwZo+j7FBd9DURQOaS2JjHIZI7szmjBwbawT7bQBHzAshuuC13uC4GpM7j8W?=
 =?us-ascii?Q?SaQLR3mHvd3PfA+OIFnRtmBiQ8hiiiQJbvUx7n648LWV09+skEFfga2ROARv?=
 =?us-ascii?Q?q8Dk5Ipnjz8aBorzjRFqobenACr8ZpfXAPL8URB8yHufyjwIq+c8ogfFxkeS?=
 =?us-ascii?Q?iMkNkATBQLe62JlnJH4OVtX4a4lYSPf3RgBYjyXsnpWl5+ekALxs3nArPpaw?=
 =?us-ascii?Q?ZepkENy+0pnZbL0JC1oICmWiEJI+SXrW70eK5oPpUwO/BFh978s5/cS1or4q?=
 =?us-ascii?Q?tal/Kjr801/YqV+VHM3dymAgvCPULNpd8PXoiL9IGwWdtwmRzUlUl7phFmyv?=
 =?us-ascii?Q?wlPgfvYoDpiVfyOfLFetJSwB9hPnuVXC2fO/+USSMU6T5fPd9w2BVuo5iQC2?=
 =?us-ascii?Q?q8NakPY+i3SSqCopAum0AexW3AF+JSQNxk26Tu7AzMaXrrRORu77bXoyY4o0?=
 =?us-ascii?Q?4aaxOFU01RughA/ccfWPTwT3Fpwb0IyAnstdNYr3FM8yLaSaP2x9sZbcaQlg?=
 =?us-ascii?Q?ow5BnSLdDorUsjzVGMF6wA3JU/oMBYL9hwgD/Gy8BZdcpE6RYEEYbPmSF60g?=
 =?us-ascii?Q?uBYQk1YouQ0PFbIxyFSoi8N+FswKGXFdqJEk0SejkYt5/khpfbDo7erUjnGA?=
 =?us-ascii?Q?gEGdUPkgkgw2efvySNU4JN2s4LA0jkMk8+z5iz3dHa3Zg283ICQokijUj5NS?=
 =?us-ascii?Q?y4miPU2ju/jR5nn5DOwuDRWhRK7GaY0NZkz+rnWgjZM7zo6pf3qn88sx1c29?=
 =?us-ascii?Q?VCc833dPE/1BjsposyYAKKoFvHKlQUwZGLjxUsacJaW+7AQ8Xc5zks7OSjr1?=
 =?us-ascii?Q?3/EwtZuzKsCU5S/Xjm+egW4Mv8nDMZt5aU5zICOmjdVbQ7B7RsDQrlyEumAJ?=
 =?us-ascii?Q?M4HGXxUlhHx0CoYvVxc+rqUBmpaSAC2PN60D0OArDDr9P+ZC+ve6AIAhja3J?=
 =?us-ascii?Q?ceTBwoENZMrPDQ9AXBIiGavTxzva8IRW9kLQRzC5VdU6JpXUkEJ6qh9H3sDS?=
 =?us-ascii?Q?pRUZEnLK1wfttzs33r0YrQxNCrd7qMNHpvR7tGAxs12iDVQkoP6YhGjAaEap?=
 =?us-ascii?Q?Di1DQ5If8mUUBuiuPyLnmBxLi5dlk7Ku8rTOMJATVX6wK/QtEgURtfIzrM5x?=
 =?us-ascii?Q?3Ba4nXKvh4WqAFIOBWXQ3C1gPmNcdzhJJYR+EC204yP4Dm64JH5eey+of+wq?=
 =?us-ascii?Q?+oJDXn6vlwalIwEfLmuFzrSKbcEkhOKItSTcveLMKDZspYd5HbAMTA07+lED?=
 =?us-ascii?Q?XL7rAOQaVYpgQQr5FGuEhsDZFzg0jLY5z4rI28NDOFYoEDt0bscpHRRgtPrj?=
 =?us-ascii?Q?Bm06/8yThNzCrJXPtFgw6R+3zbYXN7e0TLwoZOKZoMnacayeXBwRBzVlUemQ?=
 =?us-ascii?Q?elecA6hs35jXf8vrpVsVb+mHsKM9UpTN6szHURAtPP66/M6m7SGNaEgykNqA?=
 =?us-ascii?Q?nR7AMqXCKsK5YUuTEtqbhCkrFj6Bv4thJ6ts/2a2+1/mcKOJjYzR83FcCn0F?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b7ac1d-44ca-4c84-74dd-08dce168e30f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:38.3324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyYs5qiHn0MQgMp1zXVDBjoKed7N1niSQ1E6pZwvzZApoPhnvozTWGnWZahNF42W5JhKpdcJZtGbKd3cClDNMBE2RZImDH4Q1NCyAWReap8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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

As OF_UPSTREAM is implemented, these code are redundant.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 358 -------------------------------
 1 file changed, 358 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index f55c6b5d34..38132ecccd 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -20,366 +20,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_CLK_CPU_ROOT_SHIFT		24
 #define JH7110_CLK_CPU_ROOT_MASK		GENMASK(29, 24)
 
-struct starfive_vf2_pro {
-	const char *path;
-	const char *name;
-	const char *value;
-};
-
-static const struct starfive_vf2_pro milk_v_mars[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
-};
-
-static const struct starfive_vf2_pro starfive_vera[] = {
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "rx-internal-delay-ps",
-		"1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "tx-internal-delay-ps",
-		"1350"}
-};
-
-static const struct starfive_vf2_pro starfive_verb[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
-
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{ "/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-clk-drv-microamp", "3970"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"rx-internal-delay-ps", "0"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"tx-internal-delay-ps", "0"},
-};
-
-static const struct starfive_vf2_pro star64_pine64[] = {
-	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
-	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
-
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-10-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,tx-clk-1000-inverted", NULL},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-clk-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"rx-internal-delay-ps", "1900"},
-	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
-		"tx-internal-delay-ps", "1500"},
-
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-adj-enabled", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-10-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,tx-clk-100-inverted", NULL},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-clk-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"motorcomm,rx-data-drv-microamp", "2910"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"rx-internal-delay-ps", "0"},
-	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-		"tx-internal-delay-ps", "300"},
-};
-
-void spl_fdt_fixup_mars(void *fdt)
-{
-	static const char compat[] = "milkv,mars\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "Milk-V Mars");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
-			   "status", "disabled");
-
-	for (i = 0; i < ARRAY_SIZE(milk_v_mars); i++) {
-		offset = fdt_path_offset(fdt, milk_v_mars[i].path);
-
-		if (milk_v_mars[i].value)
-			ret = fdt_setprop_u32(fdt, offset, milk_v_mars[i].name,
-					      dectoul(milk_v_mars[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, milk_v_mars[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, milk_v_mars[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_mars_cm(void *fdt)
-{
-	const char *compat;
-	const char *model;
-	int compat_size;
-
-	spl_fdt_fixup_mars(fdt);
-
-	if (!get_mmc_size_from_eeprom()) {
-		int offset;
-		static const char
-		compat_cm_lite[] = "milkv,mars-cm-lite\0starfive,jh7110";
-
-		model = "Milk-V Mars CM Lite";
-		compat = compat_cm_lite;
-		compat_size = sizeof(compat_cm_lite);
-
-		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
-		/* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
-		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
-	} else {
-		static const char
-		compat_cm[] = "milkv,mars-cm\0starfive,jh7110";
-
-		model = "Milk-V Mars CM";
-		compat = compat_cm;
-		compat_size = sizeof(compat_cm);
-	}
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"),
-		    "compatible", compat, compat_size);
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
-}
-
-void spl_fdt_fixup_version_a(void *fdt)
-{
-	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "StarFive VisionFive 2 v1.2A");
-
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_RX);
-
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
-			   "phy-mode", "rmii");
-
-	for (i = 0; i < ARRAY_SIZE(starfive_vera); i++) {
-		offset = fdt_path_offset(fdt, starfive_vera[i].path);
-
-		if (starfive_vera[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  starfive_vera[i].name,
-					      dectoul(starfive_vera[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, starfive_vera[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, starfive_vera[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_version_b(void *fdt)
-{
-	static const char compat[] = "starfive,visionfive-2-v1.3b\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "StarFive VisionFive 2 v1.3B");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	for (i = 0; i < ARRAY_SIZE(starfive_verb); i++) {
-		offset = fdt_path_offset(fdt, starfive_verb[i].path);
-
-		if (starfive_verb[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  starfive_verb[i].name,
-					      dectoul(starfive_verb[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, starfive_verb[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, starfive_verb[i].name);
-				break;
-		}
-	}
-}
-
-void spl_fdt_fixup_star64(void *fdt)
-{
-	static const char compat[] = "pine64,star64\0starfive,jh7110";
-	u32 phandle;
-	u8 i;
-	int offset;
-	int ret;
-
-	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
-	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
-			   "Pine64 Star64");
-
-	/* gmac0 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_AONCLK_GMAC0_RMII_RTX);
-
-	/* gmac1 */
-	offset = fdt_path_offset(fdt, "/soc/clock-controller@13020000");
-	phandle = fdt_get_phandle(fdt, offset);
-	offset = fdt_path_offset(fdt, "/soc/ethernet@16040000");
-
-	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
-	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_SYSCLK_GMAC1_TX);
-	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
-	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
-			   JH7110_SYSCLK_GMAC1_RMII_RTX);
-
-	for (i = 0; i < ARRAY_SIZE(star64_pine64); i++) {
-		offset = fdt_path_offset(fdt, star64_pine64[i].path);
-
-		if (star64_pine64[i].value)
-			ret = fdt_setprop_u32(fdt, offset,  star64_pine64[i].name,
-					      dectoul(star64_pine64[i].value, NULL));
-		else
-			ret = fdt_setprop_empty(fdt, offset, star64_pine64[i].name);
-
-		if (ret) {
-			pr_err("%s set prop %s fail.\n", __func__, star64_pine64[i].name);
-				break;
-		}
-	}
-}
-
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-	u8 version;
-	const char *product_id;
-
-	product_id = get_product_id_from_eeprom();
-	if (!product_id) {
-		pr_err("Can't read EEPROM\n");
-		return;
-	}
-	if (!strncmp(product_id, "MARC", 4)) {
-		spl_fdt_fixup_mars_cm(spl_image->fdt_addr);
-	} else if (!strncmp(product_id, "MARS", 4)) {
-		spl_fdt_fixup_mars(spl_image->fdt_addr);
-	} else if (!strncmp(product_id, "VF7110", 6)) {
-		version = get_pcb_revision_from_eeprom();
-		switch (version) {
-		case 'a':
-		case 'A':
-			spl_fdt_fixup_version_a(spl_image->fdt_addr);
-			break;
-
-		case 'b':
-		case 'B':
-		default:
-			spl_fdt_fixup_version_b(spl_image->fdt_addr);
-		break;
-		};
-	} else if (!strncmp(product_id, "STAR64", 6)) {
-		spl_fdt_fixup_star64(spl_image->fdt_addr);
-	} else {
-		pr_err("Unknown product %s\n", product_id);
-	};
-
 	/* Update the memory size which read from eeprom or DT */
 	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
 }
-- 
2.43.2

