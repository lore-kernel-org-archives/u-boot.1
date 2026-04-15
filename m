Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DA6FA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B66F84242;
	Wed, 15 Apr 2026 06:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ECSRdfqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2713F83936; Wed, 15 Apr 2026 05:18:22 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C9A83BC4
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKY0YD01d9sWWU+O1QmEmzoNjp1TCJRIOoHUfcmAi0JZ1tjjUeMUEb+7wCXRcHF62TfbQ79Z+ELhrP4EWFYuPs1zn8LhsP2XXOzpC1j3wXQo6/2HY3oagRPMS3N5NHWNzw8uwnu4YC8vw+5gOzeyknMVCug/+4s/x2asEJcAd8q6VOVJhnDhnR3s5s7I/oTivYtuqxMF0BsjTs4873yx9d15EFZp7Ex5zFCHb5Yuw3ghduYqvG45SZCxVx5jSAYGjfKTrTqhfh4/lUNA2CXaNSDzQ3YbQ2teXwAY+U66Hw6TMeUD4PO32SYiFK3V5YIelVYG5uuoF8MX4ykHo14dBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=469dKHT7mEvnzoJerpPDTIXEsO8spIKvt14Nmx3Q7Dg=;
 b=vDd4Obr/965ZGeeFlC6awMYg/TtYXU5dw28jIcj33xHQnB3tn3kNTOD/c/+nILrAm/qjbCmpJUOyau5tmM46eXIqnwCL5JpeAElUNSmAXc5OqPBRpTnFkfiZb38Xb6Xu7AXIuIHrSTUsIObv37Er6g6wbzhSuPjp1YUUZ8g5iFTGSa7N0bV0DvSnRABOVnW7rgfUAN8pqbdS0H2xVkjAsu6Dk3grqawvtDbVzn1XLUMhCY+stPs+vk9aot5J+ep3+zgioT5SYr02CoG67lEHLQ7vpl9vAJEtmJFdPHFvM24XZo9qRcb69vDzdTlJWqvxIQpPcqB5t4hfaJGU45LcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=469dKHT7mEvnzoJerpPDTIXEsO8spIKvt14Nmx3Q7Dg=;
 b=ECSRdfqfsYslYNieUhp/KEdNnLWZu1uiULTLg01ToHLVcFT0PHdJOOdLSNSV/IOYJbZv3bV5M6N5lqHFJBM67XjtP1bxa4gmV0ItZcW/GGv53PYR/rn9WwmAXDrnnd5ink+pbn0sZ4CeYDzri1OvDoxR+/Wafr7XPD9IumJ+cMaLekllBW+TMIlAmkTFnqJ38iuzo7+15qOLXgMDO66JVMzCJWcwT277qD64O8Nf4vctZCIWxu4QWWu7+v9vp1ljorL0BrFWu/pj0X5vRnDiXYkVjdMROEqv3Ib0X7fYGqlTZAFFMPXWWTjSzTv0wACn3eVtnlRy4pn4CDthzqSNkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB6872.namprd03.prod.outlook.com (2603:10b6:510:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:18:14 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:18:14 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tze Yee Ng <tze.yee.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH 2/2] arm: dts: socfpga: Remove SD card properties from Agilex5
 eMMC device tree
Date: Tue, 14 Apr 2026 20:18:11 -0700
Message-ID: <90dbe9fa1a16de9299987105e38cc29b5cb3d18d.1775640837.git.tzeyee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1775640837.git.tzeyee.ng@altera.com>
References: <cover.1775640837.git.tzeyee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9fbbf3-5741-474b-aec4-08de9a9da1a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: TLpO1S6LlPNAKjoJq4WB18lbIwX/MX4JIqAg2+NOJ2MVy6Y0DO3VQxeL7+uSzgj+4/ho0yVUYciDDaxrPUcb02zJ/Bs3q9BglB9ZZohtV1aHr8YONn+c1/6rKvUL6wP/4TbF7qWla85ib0t67gSIbawU6AqB/9hIJivX3j5cN595HAB3bFbyk0RCcQUP9CSJcADKQKzykngOWQw4diSzxwv5Ko7BuxZu4PFJkl28dxYbFvuwcxUQ4bfkAZfwpuQc31QUSGIlXj1RtagIIuvw1FGJPnYhafRH+QODlyDqdq4b8uofRbfPdX6SLEvsIbx2LSBn2N99BHHk5oMsQyaV905URr+UkboT1CjViDgSEDiVehjeQZpBBdZcSQ9q9ofWUbQpSObYOZgDT5mUrxXqH2LRJPiKNJPsDcdK/9O8qwnO6LbDnN8x7hNIRmEiEx0tuZygZ/erDMqQDAuODxH8Du89OgAW8uRw+xxUZaiLxsuHGbc7eKSkzdE7Xi2bttnspLDti6tqvAtyW0uhqpVW+jQ+4g7cnXeG25fk9gzIezWsVXQT9t/FIlpWKUzGqkE4iqzO+zIQO8Wzvg6EMZK6+J9jLyXApFgYETDtmR7/xIPwaRwVKn3ZjoIQCwPYp65Q4dW8IqSPouoGcLQKdp0BJ3HruCAlXk3eiS76DerIEjKGTTNN292LV82e4upEUxqaNGidwJYzePGFTssHIIdX2j8A/EhqZotUaXott+rab8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/BeDDqXvBPdLHqu3VNzGCmD8gb/KdX+eG+qc/ZNLFgWwoNUUtaEFhfMuEfC?=
 =?us-ascii?Q?HmZwGWQrrHZEpiNfqvHMMVWoGckjcjv+jAyIBqsmmGY+rwWiQjU2GXrIy7cv?=
 =?us-ascii?Q?tW9Kzd512TzYp2GtnAJSyeBHiIGFuQQAQsZJroHAOxCfsVbjs5IXJAx69E9r?=
 =?us-ascii?Q?53HF7jeHfVVksAoU759u+cnfmxIig94/utz6ClN6EhI2UeETXTwPXBG0ilBe?=
 =?us-ascii?Q?IbTdkqa756xINkec7WLs1k8dIg+7ni2yuIFUYaolcm0iUTsBjZ8HlhJR/4zy?=
 =?us-ascii?Q?fO/LHCNxoWlwqQRpCboY6Kqh5Kn1GsuTpL/QXj1f61ANOw9XJUsPs1B3ukyq?=
 =?us-ascii?Q?e4zaZBfdju3lLlPDP2F/G2pxh1AIEY9oBkj9Bq00ePO/VOY4/deay8riE6Mw?=
 =?us-ascii?Q?1IcOiNcbtwgpS5FQJfbYTqRnDBtOJ593CH9NjJGbFXrnqACr8aATbfL8tYrV?=
 =?us-ascii?Q?2S5Z/ND85yAB/R2COZgTgCKmRlpXnLys3FLrtLkFXRtNgfadG7sToyDv49j1?=
 =?us-ascii?Q?0l06D87ayYJcBpZ9SIMIbbL9Zzpxfuuv2yCuQtvAu1rpZmqPDcrwSYMQ6Sov?=
 =?us-ascii?Q?xddoTLYLaJdQlzGJWWjHDkK00kT6aUVJf3K078NJjJ5nb1EBZ1lERmIw6HBI?=
 =?us-ascii?Q?QF9JVM0/EsFAj3wgNxlAn/J+nXwhbzEfebdMtf4pk/gRajHv6FJjbaYzidQR?=
 =?us-ascii?Q?hK9eqhOzMPcuPa4rU07qSkdi6P4CBg5KuuVbJIKUmud1XzxBo/MtstZOGG+f?=
 =?us-ascii?Q?yfff/5+KJK19raiOmDeH0yBi1rYju5WLyIvbqPxjhR48R9OW5cRqWSveNFYQ?=
 =?us-ascii?Q?OKzqx3bgu3Igkg1UeOR9mCSHW5TIEtc2JHk7BdgRgtXdjZ1nrT8WA8eF7kkR?=
 =?us-ascii?Q?FcbRPPLfw/HT/XRKP0g132ZBQebq8I65vCQY6JrE/XWs0iX1v5+ulWAWg5dF?=
 =?us-ascii?Q?RuMTre+51SYtQG7DPubAhHWRZdIODsNIDsD4A7ZhUHus2WResdQXi5FjM8TP?=
 =?us-ascii?Q?odlUIkDkTAdTgKR7VVhVd0w2/oCqG//lss0gdzoDKlpQ8YsG+riHV9LIdpG5?=
 =?us-ascii?Q?EojxMEn28Yodg4WUQtG9Ezfz/Av8AnxIUwzGm2oK9T+aOjt7zyAnazy2qVqo?=
 =?us-ascii?Q?qT/1xx2Y2o3YNoemwdsogZPcziBFE/u2i4MYZCxBH2OCn524bP29OlbcCcud?=
 =?us-ascii?Q?UKxtjaWdfwd5aJQqtTDkq97ai/CsMhqNpBXEKmdcPmX1WNZ12dc2Q9V7Yacl?=
 =?us-ascii?Q?Yss+f+KrGSpoz+nCr6uAktVpoZLatsClZ2iwKuMUIO4+rDEWByeUiWQXuvYN?=
 =?us-ascii?Q?AZ8EVb7d8Ef5ewqw7+yMxFJRPjo5GSs+WGnhtqXfcZtTEKgqYoGrsYo+/UST?=
 =?us-ascii?Q?9wXJEQ1aXbBY9INB6ujqVn+j80i1E6YONJHCPJjoC7d1IXd8t7furKXinvg4?=
 =?us-ascii?Q?mxTyjV+uo3i9bkLJ9Oc/4kPkAK4TJc3e9XXcr1+Dai5BOsPNU2xvFNQfyiR7?=
 =?us-ascii?Q?kqJxeAIaUzy5+wPFMS6vIIbvthYk3dTpoRZzmIiLO3sSHMDiIA5rLFk5yjsp?=
 =?us-ascii?Q?i9x78/q+oXiwF2lnQWq9P51bEKE4sU+vhmR22UExzosWqrLqvkkfVuTcZl6n?=
 =?us-ascii?Q?Dmfs2xH8GeTcdoupV1zQAcDgWbowApfG77bg1NH8e4rJoJTIl2Nk+/n80jlW?=
 =?us-ascii?Q?mThWzjLk6eafYoOcMWGf9D+z00hAsiqEMRXpaVVK2/zzg56kIncxwr8wg/gn?=
 =?us-ascii?Q?cR1OHjw8eQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9fbbf3-5741-474b-aec4-08de9a9da1a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:18:14.6810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2pbA6E56GGPQvma1Enr4haYC1ATipSKR5bf+eOlk6mEeUFLKHJa+Q3qu21YHDvQQKCyP/gwg6dveWHVo8pleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6872
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:44 +0200
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
Message-ID: <20260415031811.JsqPTkTCzf8lpRQfPpFwxx4LQ89yIcPIQdBQe-yfeMA@z>

From: tzeyeeng <tzeyee.ng@altera.com>

eMMC inherit the configuration from socfpga_agilex5_socdk.dts, including
the SD card properties.

Changes:
- Remove sd-uhs-sdr50 and sd-uhs-sdr104, which are SD card speed mode from
eMMC device tree.
- Set SDHCI Capabilities bit18 to enable 8-bit embedded device support.

Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index c06781064ca..f1e8b737e3f 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -18,6 +18,8 @@
 };
 
 &mmc {
+	/delete-property/ sd-uhs-sdr50;
+	/delete-property/ sd-uhs-sdr104;
 	status = "okay";
 
 	no-sd;
@@ -32,7 +34,7 @@
 	vqmmc-supply = <&emmc_io_1v8_reg>;
 	max-frequency = <200000000>;
 	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
-	sdhci-caps-mask = <0x00000000 0x0000ff00>;
+	sdhci-caps-mask = <0x00000000 0x0004ff00>;
 
 	/* eMMC legacy mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
-- 
2.43.7

