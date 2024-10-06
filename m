Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BA3CFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9289A88965;
	Sun,  6 Oct 2024 11:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iIcvsDHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0F988D97; Sun,  6 Oct 2024 11:39:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897BA88936
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFiB4iBuYrkCjteS8lAkHSpWKkU7P+q6M22jzFqVau2HOg3YnRcC8ts0Po1eWpqosweb+kA29Xe9ptTs7MNJQT4JBwrL64zdto8+SRuG1LX5AQAPDN5nM22MMsd1FlPx8zP6kcn8Npdh0ydRpoJkZFFAzaRvfU2xWdP1F3eKT+Yna0TbRRIzZ/cKhb6KGuc9hflvKFLCw5aIUh6rfy2wClOSI+JwVo8EEtGARhwRGThzfdMLLY65HIeIrn9jFh3gUhfpeBlZ2hqEMgmBv/lgWv30qO0BEeF9bL8empnIjPWZNRymGlqoby/y4Prj4Q0BVaArQH2HBUATq1PiSvLJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18mMJewqYpVc3n1CjfnM1J6B8jp+ZUt8LZxSLAtzef4=;
 b=CVfOfzzGnFq97sZni8IywMRzbq1wc6g3QzuuAMrrY8L1MBP6QAVnF/5jEflfoapPpfxwglZMatoKk33bT9OSYiZHm4UQIQwkefOOiYEcFn+CLAgum25PLUzg8Z9uDH4X14CgnwPJx0Sn3RNPMn2NdVQIJjQUXiRwR+jfuRxjEgUT7RPdvAVei6wBi2z0lcJYoXDpsr8Uez3KfaRkiY/p+C+HvzpyVqfSEIXlCCNlgG4ZGsqHzYtBsa3i7Jprufa1uvPhlc3lOfv1QfqBba/QnuyZ6qEH6GmRd6MC5RuaxlGOomhKSTHMm4X22gXPsAqV6rIcYfSqywcuGIKr2SU2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18mMJewqYpVc3n1CjfnM1J6B8jp+ZUt8LZxSLAtzef4=;
 b=iIcvsDHM0NyjfihXpILN67LLJgXOtt/OhNlVhLf4dN+W9j3Q8y91fcoje+05EKfirFsDq1U8Mkhx8j+Q3aT9u/YOXfbrz4MXJCjzykWCawCXqGNj172H8dSuQE/Bd0H54f9yxUFvgjvIN4HGV6k4XkVpowUbV90qQAoqFnFuX7rwoFyZxfUNh9zojYa56nEZuJ8Hu4rxx73GMaFShJEjPA/p+GhLjICavKcvuhpBwI/lKHBMha2ws4g/epgz7owBGa711fEk1M0cZklf1qjc02LLDagafW752yIIPmzZ8eBWHBPBWc9aBjw8D+snsA58i3eZXFJwBVADbkgS4l6SuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sun, 6 Oct
 2024 09:39:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:39:52 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, alice.guo@nxp.com, etienne.carriere@foss.st.com,
 akashi.tkhro@gmail.com, Ranjani.Vaidyanathan@nxp.com, festevam@gmail.com,
 marex@denx.de
Subject: [PATCH 4/4] clk: scmi: Add workaround for set_rate/enable/disable
Date: Sun,  6 Oct 2024 17:38:25 +0800
Message-Id: <20241006093825.2800013-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
References: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce4cc45-4248-40d9-d313-08dce5ead3cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RampuFW5C38dyCZH4CmWBJgAMdQPRHv3XB1JAxxN4fAVuXk81DBwS/TMDMAZ?=
 =?us-ascii?Q?iDbOf0gCF0s3UpE7vxkd2Ayaaqp7XSXS92KkjCdp7JaUAEXojhfizfMWsaUS?=
 =?us-ascii?Q?lgB8xD8yta3OrRdxKaIpr6A1VevQGtRRsMzpAAPogXfvpydKLaZtLWv8akuC?=
 =?us-ascii?Q?E9Hf/AnG+bWgUqjfGaEuLXqTGJIDlys0WhAA6ZX/WTJczUSGdf51QeaCZMbL?=
 =?us-ascii?Q?Uz07eVa2UjKiCtUw7K78QYjLw9vaWIzB1lPAXy00kn29/zDfMYCE3v6VG7Ek?=
 =?us-ascii?Q?MxaYVJF1oJqUYQJiUbN+U8uyhaF2+sLxfjykB2EWbrcubYu+HyySuUSRZBA3?=
 =?us-ascii?Q?gFP3DZsRhFbaWnJa7diugOTIRzaASyBjRGn434QS9eSEFNoGwEoTJHNbuyri?=
 =?us-ascii?Q?ew9rWJhO6y4mI6Db1S7g9a4Yc+h6Xw70YiqgFogk4D2G3rl6N7a2a2mHsLTo?=
 =?us-ascii?Q?4zPb7Qw7flHEo/hoz/nOvrhZDV32Nnc9LxWxghe1y1/cxdyVq3lRWrV+V6ef?=
 =?us-ascii?Q?CilmUMVuZt1Z0qelKdL3jLfQyH4qAOuPTfqIn7LlU+9ms/0RHnYtOL2zLFrP?=
 =?us-ascii?Q?jt0aSykE0AXBARy+sik9xgtrp9MSzm2kvYN1fNwMnY7lpGrVOL6cHccZ97wj?=
 =?us-ascii?Q?Jf7e1ujrjkc0hxDIoBoo+HbGXJLpvUqOAndMRf1KKmX12gsbAkqOR3Fe2ndZ?=
 =?us-ascii?Q?Y4zlgVlUIRtDeIvmvcEQ+UBN8sKrcG3/uomtbKv6Rian7U1eP76LLkBzYcSa?=
 =?us-ascii?Q?69n0GysgNTqtX1OtQjjCDzleoHy3JfYXBBQfKOZkF6nYWDrV9S6P+X5FxPy1?=
 =?us-ascii?Q?l/H45m+HrWaDmLFD2f4OmPiLRb6X03iaX7TLIt4xFJ8DGoGGoP8eIumOxHcs?=
 =?us-ascii?Q?PacJ2wZo5LtHfr4i9bim7mmGHO8TNHUAoi2B3gekGMrlD6YeLmsvOca8JAQe?=
 =?us-ascii?Q?7He8L+4kPay7eR+FAarZbPv2k27kv4fBVu/pz1nu0JD2rp8L+vY1t5X2EJzx?=
 =?us-ascii?Q?5idATGVVUZAXRxMH/wjMbzVU3W4cUmFGGP+LV8nT2gASklSKRMB9YvKOElO+?=
 =?us-ascii?Q?WvDcBee/VTJLS2zFLW3WH6bwlBovD0taDp9V3MsAjhmqQZ38SyK356kABZ4V?=
 =?us-ascii?Q?/vnYreV5K2btS233b27bwypwMYzDW8aRv2Zb4ggQkcD7/0LK9PokJa9wpwGh?=
 =?us-ascii?Q?dijC4F/l/dahyZicAU4jSD1YlnxOyAu0cJJHRLSNVC0Cv0ASTjRE+Dae26rq?=
 =?us-ascii?Q?ucXubpBKG5NtKgp+/PZZCF/weR8NDLd773o9rjzZlML7lw29JFvBp+LIlQ/R?=
 =?us-ascii?Q?nM1KvWsuog2E7JG0VFDEwgura3BIfq77L9qMBjXcTtKeUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTkisoC9L0VUtZjTkwsF1zFycpkq7/ZH3GQxk/MwZu55CGfRzo/9l//aB9ig?=
 =?us-ascii?Q?60QyfUIOFHoLZA72RFOjbBRM3KavFtgnNVvNsDHwixUPh1ijjC2+nhn0XbG8?=
 =?us-ascii?Q?VPtPrpP8+f5Z7FsLUhw2Sj6iWlTBniK0dzwO3YFKPe/91pqMeMP+sfjfBgpt?=
 =?us-ascii?Q?KxnI6QiIpEECu1YlDpg4p9K7pj8xl9N5NTfzVNxBOKEo7ENS6YJ+rFRBpIWK?=
 =?us-ascii?Q?xP4c/uodaTULIkgSqiXxrlgmchRNrp63IZ2cSXm60jnSXW2dBFVYH3AA1NMD?=
 =?us-ascii?Q?bFF9y5Tm3wB3KAXHDDbl7kZi3J6coE3wOKrw6OZFDW8+q7WN0sygWWmJjR3H?=
 =?us-ascii?Q?mjj0T/JcfOPzlz9Rbjy+Pbk+af6gKn80h08WeDZ0/WxJfA99SYq44JABmxRR?=
 =?us-ascii?Q?dZ/2QlSZBe5SNcJCCTJuymBEjg1tSPeUPspGNSE2YvikO3qqgAG4bHstM4qa?=
 =?us-ascii?Q?IBNlsQDMKerqfjw6p5qa87ec0Irb1LTmpjPArsU6Ozus5dzrpgLhvrOVgRti?=
 =?us-ascii?Q?ox9/FIFsHaNux8hrGU+bL4XoqgNgdIkDJ/o8TRRUrjNHpqH5qNX5zuGIaa5g?=
 =?us-ascii?Q?8NsJIwB8/oQtkIxTxt/Y+NyLIDzvSkFHfYdzXkPWaq35fRKdpwKNpE/6q1FZ?=
 =?us-ascii?Q?KbTeNU2sGjOM6LCMsj0mC+V+gjQfvBXgex3PZwtAwj9XEUqJ59gPf963aLQS?=
 =?us-ascii?Q?YCjD485YM3Qz68yXSLouafDHDOO2unR+EPRURIp6OmKECUMQKR84yKabuB7M?=
 =?us-ascii?Q?pQ3I8xVoge8hF98UivEfGlwe/I0CovOVj2Kjqs+Jm3w37YiVPfuIpcs/7lcE?=
 =?us-ascii?Q?Nlof4UKxIcVL8MmJMgnO4sg0GjRQLzHFxgpiMj/yn5jvMJizlRExCsvvB3dV?=
 =?us-ascii?Q?OIwvIFnZv8Cx0E+P/lhCO8gdQZ6hudV28Wb/7e66uPrUjCvNJLe4raMKeji3?=
 =?us-ascii?Q?3kkqkGEVSvLF4EfLh3fmeAKWP/RQv8C4Cdx2j2hgBhds5I3xV/UZRscec0th?=
 =?us-ascii?Q?xXBoU+rwHQ+FI+NCO6oXsoA+Xxif0K3sKRSzhHcdBH9eVE8brQUdxlweK8S5?=
 =?us-ascii?Q?JinCHkGxOzdMt4gnPxrvbXqYopxF+59GG1qigkHpeCEshwEI3XO4ukALrN5N?=
 =?us-ascii?Q?MM5CK0GMIUeH3b6elE2SMZQrwU/xKGUWFNP4robmFsB7SJQfnJeyrHaCECah?=
 =?us-ascii?Q?tiIL5W+Koz5hnuMyLPUbF8hkLpAQbhJ6XxBPaFO1ZfO95jmZdZDNTv3VaZrA?=
 =?us-ascii?Q?HsiHMysmAtwTFoSF2fPGF1AVdlIl02ZaJZFdxGPhX785KV5eBXBnY3AUTT0m?=
 =?us-ascii?Q?55I6VGRoUUDKYo9RhuQP+Thz5SPf4ETP1MiZvkIlLM2WAZ+xgLa2dbfMho7b?=
 =?us-ascii?Q?l84wMO9TQVLd91+e1dc+syps6iQicrc+tgSWTtZIwsc4/XFg9ko2N3cpX3ah?=
 =?us-ascii?Q?Z644SKFdQlR/2DoBxAgHl1E7LqPfDfFYCrkwf11tTgi6o0NiJ9XEXNb+LBcr?=
 =?us-ascii?Q?XZoWbWFeZ4AxhB56+UVxYCs/0zELUA6UH+xKawATlnz2gGff9AoiOdzS0W9g?=
 =?us-ascii?Q?65PjSjUFm44zSrKK+1pJXDygZS84yyN20fKKjqBE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce4cc45-4248-40d9-d313-08dce5ead3cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:39:52.0071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0AmW1t7YKGL/sfmDSZSwbEG6CXYp1lQ3g6IQ6AvIfucyCeTUHjwmEBPRm0RXPz9VXBqfwVYJN3KVAmkWONWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670
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

From: Ye Li <ye.li@nxp.com>

Add workaround to set_rate/enable/disable to bus clock that SM
will reply DENIED error.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index a01292c479..a860a653ba 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -73,7 +73,13 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 	if (ret)
 		return ret;
 
-	return scmi_to_linux_errno(out.status);
+	ret = scmi_to_linux_errno(out.status);
+	if (ret == -EACCES) {
+		debug("Ignore %s enable failure\n", clk_hw_get_name(clk));
+		ret = 0;
+	}
+
+	return ret;
 }
 
 static int scmi_clk_enable(struct clk *clk)
@@ -108,7 +114,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,6 +139,17 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	ulong orig_rate;
+
+	orig_rate = scmi_clk_get_rate(clk);
+	if (orig_rate == rate)
+		return orig_rate;
+
+	return __scmi_clk_set_rate(clk, rate);
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
 	struct clk *clk;
-- 
2.34.1

