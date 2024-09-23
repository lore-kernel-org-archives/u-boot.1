Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0258CCF9C6E
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F9CE88D36;
	Mon, 23 Sep 2024 14:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e1MiGFnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13CE88CBA; Mon, 23 Sep 2024 14:11:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0248C88D27
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPFwgRYlz5g3RltqW3oDRi7IARRFRax82Du4O7G/M1eYjfPgGI+hjmYgPgklQ3uDF4SOoDxGhcx+Kqi8oLXXsEWvoIJsI03TBrtOeP9lKTUsZ9GUmlikMiv2jYFAa6v5QW1S3zcd27hx3l7ajdyufG1s/3dwGTUur3Zf0sUE+0NIbTP9bqpUZJ31HleGlP5Ktdu0XMzTT4PnLT2fL53KLK5+ff4GYf7b9HwzYn1mthBBSvh9/EI46qdyqN5VRdndM/1uA6PrPvYbVaPDpMQNDp/yNPaljvYbJmkMuLrUGQtSnty2gmyPioB42FPy6lzvcVszNEPWSzjYgQf3otZecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlDjzLNmOt7zOf63Goj3b4X0qJCBt7vfdMq8D4eTicQ=;
 b=UKKUbdQdgJI3n5gIYJok//zTjJlXon7CL2d//X1E1iT/m8u5W3h9E50DlhgXVnPW5StFeFhX7GvVW1S1nS7jvWQYyyigLOYPTqrfew4coDIgIai4DD47YBicLHzwLd1iasSgrw4+/j/WDbu5qJPqLwm4COKOaCDbIJsvQ+WLKRt1BIXm/2rWb+SwGyoYGlxQxO410+oSln1VGparzYgtBvr19plBRy6FeR0FJRMr6R1a4DWHvvOxHh1K4OouFv4lbYlaQDXC0Cu350fRmHuM1paO1Eua9X2HGQLV2l8a+LJZ4Ro4WAXFlVe9RvtJZAOdfQORl6MxM9oWVmqNYjecRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlDjzLNmOt7zOf63Goj3b4X0qJCBt7vfdMq8D4eTicQ=;
 b=e1MiGFnzCytYKIL4MLlsRAENqRcOCRBVxwm9H6ZH5Ef/TgOTRLmJwcHw2z9t5xmlUN2LbQDGY7mjeEozq28w01WR1CDEHWZhptsP/97pv9WGbl/M1UivFfxrDwErvH+nApOw3TFozZiEPzaT7ZE/cNrQVeqLtvNT7T4HZ//RcrErCeqwqFKtrrFxkfl8XVWW6Qg6sAvhmF/L4H3hGCXpWS2ljNFJD2GvLtsAUkT0Tmrx+pSe4K0UJif4fACLTrrlEMGPSw1uNbe5bC8Do/tURj4UR5zrEiaE6CQYtZYENhF9ACSlifDMvU3qhsCyvwqbMpA1dpv1QR789QDsqJqFIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7807.eurprd04.prod.outlook.com (2603:10a6:102:b8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:11:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 12:11:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, joe.hershberger@ni.com,
 rfried.dev@gmail.com, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Date: Mon, 23 Sep 2024 21:14:38 +0800
Message-Id: <20240923131439.28572-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f5b2e4-467d-41eb-5032-08dcdbc8d59d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0eUcd4c13uml+hE+iAxHjkwR5iudOzzVoN0Fi1J/3bWn9+za4xuOnDrYRhgo?=
 =?us-ascii?Q?Ca+GWcmMEcZTu+ALZHgfyIU1y8z7RC0v4qFuq2T68t59UQi9M81EObluaIgJ?=
 =?us-ascii?Q?eWD66OiFtgdJRE+h2Bl78og/ArIz3NAwosjkd5un6AkbQvgQBJ0Yp+osd98F?=
 =?us-ascii?Q?tXb2QIGAUuodK7nEFRgiXt+Ua+aqiEtcKJOjpjy0u2/QBmXEwvyweOC2Vs37?=
 =?us-ascii?Q?sATSr2H8Tl8KcZIvtkj3NtNCRRlhVog07jK7VM9trUTp3yg1QSq9JMMKGp8W?=
 =?us-ascii?Q?tXYIvMuRGnFII/+UKRD00onp15iGxf2LFsnDbzb6b5aD7Lz+ywxN+e8QL3qG?=
 =?us-ascii?Q?71gFguVgIf17q7PuR6aR3ZHMampzz4uVFWzuUABwEMfcXsigYJBOz1rX4HoJ?=
 =?us-ascii?Q?FHL6JXJDwDH5HArxncsvaE6v7WOppsqIlojbbJz/4Fu38XOUYQp6panx+++x?=
 =?us-ascii?Q?mqUM+/auklk12reD+S4xubm3N9ydICvN5J0wA5lCB8k28tpA8sUPKhIzNcty?=
 =?us-ascii?Q?l3Seu6ELs5UOIQkLMuH9RIP8QDOouHBXXCQmTKljgohQEvZXbaG3mT/yAaFa?=
 =?us-ascii?Q?W8o6ElIckgv0rhxAhVeLU+DpJB29b6PSfTvJg5WRe8fTq1AvgIxg/OoEpNpZ?=
 =?us-ascii?Q?dq8dc7XFA/6DcgSt/+kMlkiGrS7gLlHb3rG76+tn/MzzFxu41PgNQcFRFMTN?=
 =?us-ascii?Q?ljqDKWoDTAdWPLJopR+Xan6nmwoeUQRLpscopOHlosrCTMemYaZgl3TFMWdl?=
 =?us-ascii?Q?aQUM/tHHoGrKz40SBBVjW055GUxDu2FlSUwB69GWEdI0lrhmd52M4aWISuka?=
 =?us-ascii?Q?9W6Evs7xYdT3gaNzcUg9/dbzXtUvY0uI5QA2jlBLkZvRuGPj6ZSjA5b835Pk?=
 =?us-ascii?Q?yQfOycNGAlZjSL2cS2DIkPjZ4rabnu1plr5EfdtG0UsSsIgPhK48W28K5dxO?=
 =?us-ascii?Q?oM8q4fKKoe3Y4sjwNBjFaDEsG838j0WKEQc4ybnQ7ANVJ/8aNDV6GxoRpWIC?=
 =?us-ascii?Q?giIxAGKId+pN4A27IyTFb6xrFr6ZfNyvcmVmFU+MmSTztv6ZWZXhl3Jlxf9w?=
 =?us-ascii?Q?Dark5+3Ru8gquc5Wp3scZ8XxNFUiiQ24BM2uQPob9FoQgeVoxQkgxmCo2uva?=
 =?us-ascii?Q?A+ZM4EMiU/sRvq+8BMdOEDIuSeVFFkcAKJ9/aY+HN/aNOSrle0exbkAUjuHn?=
 =?us-ascii?Q?D+zr00+oUyvx8bNkm5PSpbi7F4+wnZEDfDqdfXvygmPGqNFFTNtzPn2MIfOJ?=
 =?us-ascii?Q?M+/vcO2yloye7TAbFZeRAxCBqAZnthjwTPTurbotgic2IhN7ZK+dkwiAAhbf?=
 =?us-ascii?Q?h9QCMCmRxYmQob7++/FpGTPdZDzHj9LT5B6yvWwAQHibsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrbzNg9ZZML+jgUuUI05erUhTDXlIHav4XEpQaH3d8eaQbXoaeNY3Tjg9+fa?=
 =?us-ascii?Q?S/sAp0DEDefZY9Ge2+BIH3C7cB2w1BvQgiohV3CsAVGc2Z1RpKgmPVJMNlfD?=
 =?us-ascii?Q?pKJRrWXHyDLwI5tZkoLZHcJjY9Y/mO9NiTCCsEni4UQVtlHzcnE+OkvFIXCA?=
 =?us-ascii?Q?F47oUsh7JKJVPxmrpA9WX0bJTvMEL85y1d8mQM0qljIA/8OYKTo4HVqz9EO8?=
 =?us-ascii?Q?yoogLBc9/g9qYYqeNu5TK0StIVtFgZ96ryVxfFlG5OwFLPGAJwPx9dfCUevF?=
 =?us-ascii?Q?xJ4oKvZcGYGeJw6PO+NMqPwzbKDi9GlQrx/bbeo7VjAXYq81eZnITtJHAGqP?=
 =?us-ascii?Q?cnX6+ccRsFrA1Z2boeJOmU2lfni2RcIwk4PFKVkGBsTN2z0KgCu8B1tqyCHn?=
 =?us-ascii?Q?mk+Hlug3IHeAYn0eUlnmmFyayOLwtncy2M8n1z5BdfV5G01amjH7VfxwepA8?=
 =?us-ascii?Q?yxjtRWiL/3/zunAiB2PUPAYcM1NgYSlN8sr9EQ5fB0IUnH3LiPrCqEKRvta9?=
 =?us-ascii?Q?nYOaU6c/+UGxO/r3AKdN46pedmsqEX8wuqj3V+CcO+Vun/EziujRVzrCV32O?=
 =?us-ascii?Q?LFM3+HdlfeGMwtkjvd55iOiOupF3LXnxYfetn+i/lmxSS+R0u9rG4Su+aVgC?=
 =?us-ascii?Q?oWs1bX+c8PUc4UXpuMluV4d2yfxURX6dTi76oxA878TxKaZuXxWu0d1DkeXi?=
 =?us-ascii?Q?6hrEVcd6LUtHyz/qXUZNYqe9HpJY0NTeVzvETehU+niHvIWFbBHFMXwq6VVc?=
 =?us-ascii?Q?hbnXUOUwLU7glyjN92YU6EmSVO7Fcmok6RAWLHBSXKtqo6b7SfqgmxAyqLgK?=
 =?us-ascii?Q?FQuacpiFOyMmm32vF8ZypOTnWgyt7oUo5nMw8M64xFQZPSJM1wy8PlqwitCU?=
 =?us-ascii?Q?ileHbtXGl4nSSMsWPFqn2HPBSx7rnTp4MiAu/kgZ09rIWUWZiuOW5Oezeza7?=
 =?us-ascii?Q?y3Ddopy4ROhCBxI2WaSwzsi5R70f2Z8uLaB+iT6hUxPsKtlEWk+7kYUq99ym?=
 =?us-ascii?Q?B9JGIqUKykgeto25nQV5A/HyqcOl0XyM+uU3MOb/HANPnKillxy9FY7DpWVq?=
 =?us-ascii?Q?5sSj2NjJJdIN5YqslMTZb66cHYaZnTrl6oHOYEHeUIwJJJWnuB6RNt9hrV07?=
 =?us-ascii?Q?Qho2fEKeXRsMd9jTxcgNVKJ0MGGBCyvpMbBCgWzbjfItSVdCdob/8wasob+j?=
 =?us-ascii?Q?33tBcDhua3G/nLlkhJ9SiCZthaHvUK4Y2JAXGBDb6IwZTp3wBxW5Ch1/3jAu?=
 =?us-ascii?Q?k8WhYz58MHtb77gjSlF7PHz6cdDQjy+a0E51gaoEcLrorcpgfeI2C3i/RLCr?=
 =?us-ascii?Q?VKj72D/cOxAAIJDprR+9ANPUYg/cR4GhszY7GoL2x7O2g8iqYYUruD4Gkjc7?=
 =?us-ascii?Q?iVOfskGtKzM6ODB+MuvfVk0fY6J2vKzePDzq3RWGsmSoUZA/NPcx1QdPscLM?=
 =?us-ascii?Q?PeOJIZlW3PyrmQYi3+Nnm3kdNT9qAl37igkAhIMsV6akUZX3Ssd5RZrOS/ff?=
 =?us-ascii?Q?dMdwmG+uru++kKdi2//lSdwCV5a77JEqfMDRbFoIo0zea+aUbzx1BMzfNQGc?=
 =?us-ascii?Q?STxE3DIqNgogi2BtNhrWY4dOw5eXarlhqLfTVgFa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f5b2e4-467d-41eb-5032-08dcdbc8d59d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:11:20.8233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNgI3LPHTYVskbFHlWIRR3ttwD6TAzZ4nU3OAcLDBI1eHnvtxiFCJ6/c7WFHF5VTpMco53rIAoWMpqNXI5FAvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7807
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

Because iMX93 has a internal 1/2 divider before clock input to
network controller, so have to set twice frequency rate

Fixes: 09de565f76b ("net: fec_mxc: support i.MX93")
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/fec_mxc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 0a0d92bc2cd..e5d7f0f3e1e 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1215,6 +1215,9 @@ static int fecmxc_set_ref_clk(struct clk *clk_ref, phy_interface_t interface)
 	else
 		return -EINVAL;
 
+	if (is_imx93())
+		freq = freq << 1;
+
 	ret = clk_set_rate(clk_ref, freq);
 	if (ret < 0)
 		return ret;
-- 
2.35.3

