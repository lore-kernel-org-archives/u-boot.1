Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249DCD1A452
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 08:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A7988E3C;
	Sat, 12 Oct 2024 10:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BrjXxySZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45DE88E3F; Sat, 12 Oct 2024 10:31:24 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151EE88E33
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 10:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GK3NC8fLfdClAK9AaUfkn8xeR2FqbQ9b4Av5QBSAW6yx8ABwcqpGjoKm30+urSCTWvJq2+ndYqOKHmavDWUSTitFsqM1RFCgM5aJvaTcicKwQjM+DXV9ZCrp8a1cMwvvJc9iRX3v+qYbar6Q/9+k94+uPR2JAbFzKoXpvsdLwp+CbQmo041xHXQbKvNkt5JgnhlQvsUxK10wDL4UL0MbxobvVVEBgRDYpd7x4nBv5HYQoQLBYTcYdXrleJbE1K32YrTPTSEXBrWCjL6W1QvjEFJnVXCZuFV91E6HtEB9z7Bzva4EDwOF4zIo6z1xhCmH+ufMIpfixkl838PnngLIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxB9ESYEpE7S9AEN9g5tLHKXvZy76hZ4kE0yFPRpzLA=;
 b=qOkm5RsIUYBfZ9R/gLFaeg6H/dvORtr2KLAzJ9uLCQjBxcfUjXv1ai0aTxxpNU+gYWdmYVTzYDcKgNa3XYmxKagQXIYFBu73NLE2OSLhu/eOrh+vTkH/NQS4MIj+zfxTjuDfJPpDMs/9Wtb4UsSt7dzCge0Tljl3qbPyd57eujf7uf49aqukrvtPcqxdCMdxzYgiDu/VmFywUl3b9pOfvZQVDB5ODhjGIQnccxavenUX9Uih86MRVpnTwDPGkDiaRzPSuTMvgoJU8z3icmArZPeM4xqoX7wdZZJvP6Gds+0I1eXZgv5k134R1k0Ubphl9qeFs0gu8PDIuJDKmwRqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxB9ESYEpE7S9AEN9g5tLHKXvZy76hZ4kE0yFPRpzLA=;
 b=BrjXxySZbD+xJ8yU4hmWC0012AdTeOGeSx8rFRRilAKVAaTC1HlBZb0+y5Pd5qVnfZF3Uzc3VpyFWOb8hYb1FALkq9IAH43z0dD0/pKduEVYEOE7kjRLnGidUX5DcP1Zdk8b55r66AMJGLq+aFOdF1KtZLIk2bO3zXFsmgBIQDAZVpeb4fBFoVPuZsyg6BBNTfeG9c2Gg4Bt9KRgE50LYoJH0Y0ntGwtKthKFmwgOjKU+UmUYNE3fs7o78yDYZiBTyuJeKxH3Ef2Y/1jq6RFqmpK/B1Yt1ObkNJfgHrQ93CblW0y3GUb3UVlwFc64sEcMvZxR51/4+nVwLjED/+X0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 08:31:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 08:31:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de,
	u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, gilles.talis@nxp.com, Peng Fan <peng.fan@nxp.com>,
 Gilles TALIS <gilles.talis@gmail.com>
Subject: [PATCH V2] clk: imx8mp: Add i.MX8MP Dummy clk
Date: Sat, 12 Oct 2024 17:34:10 +0800
Message-Id: <20241012093410.9069-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 73518505-6963-4f6d-f932-08dcea983eb3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wBMfSLwBfXbqq3F2YlHU6DvUyGIb+H97o64tPiXOIkg7hjS4sHWISt/Z9Lj7?=
 =?us-ascii?Q?x9DwYV3X6+4ICHFuP9hR1WrJioe91TM1Fc46KXPVWTZav+M9aFVYa/8PM/j2?=
 =?us-ascii?Q?rZN8efdCQnDI6YmcFun/lAHGjDDbCoODIeBr3oCCHjdonhgKkyCw1RkRWrMU?=
 =?us-ascii?Q?wMD3rEp2X+E/7ayPcURjBl6G3mjWQuEQ0r43r1hF0G6ci0st2W6s0PQkq8Tf?=
 =?us-ascii?Q?a7f57dY6Flb2pod9+eeyvw4kzNlV3rS+RO1YmL7ZwWF0pWw4OVdscuxDfAL2?=
 =?us-ascii?Q?WKHGeGKsm/jvqJm4mp1qk/OD981ANrLZV/0pS2p6cZOKGVV4eaUsRbF/pjp9?=
 =?us-ascii?Q?v5HiBAsW3giys+UoanJF/Tu+4OVFdxZFrTQTyhqa66UvVnwOFtguBqgdYfM5?=
 =?us-ascii?Q?d/ZuA2Xoy0lXtqmJrJghce55ULLHNUSLqRZnNg5sDJC65vL3doBB4M7FZlQX?=
 =?us-ascii?Q?Wck5K0Po+QvVjf+oX69woDJ/re6N5UL4Wr2SPzLnw5g7YdhpzvDkmStCBR65?=
 =?us-ascii?Q?YRqT/ORni8fNx/6dlEgKxHFIp8CzMJ0bdMLc3qcgSbUtZOuGCxrf5FMUa3Vi?=
 =?us-ascii?Q?4ZEXbKXdDCWQhAZVmHE05lKYv2oWChe7ICGBaOT8YVb1+Nt+eT15sH0avZS1?=
 =?us-ascii?Q?z05H0QR2rlVDDehnw6WrMwABrzE/P6yWyChEOteo0fegtm31pgeANznwFVrw?=
 =?us-ascii?Q?Ou4NqqXqyFeqfFgOAwPSexBal1amjxV7ymKyfylQvB+UKEuAFfGud08SMlBV?=
 =?us-ascii?Q?6BJ25RyNO6ZIW0h8dpS3cfzo38YjnKkf4/eNi5cFYfeMFWKVarKHClndXM3b?=
 =?us-ascii?Q?OMzxqZrp+fzPjN31ns8TYvO9nKwYDk+7y9nWf2U63ANDL6227lr5m5F1dX/F?=
 =?us-ascii?Q?oC6XczJlgaM+g3FtxiDsgAwoAf6bq9ryiui2fg2fSY8YOqBMJeRX4Iqzsu3l?=
 =?us-ascii?Q?iVqBGoxn7tfysU9BFLyuvSQm3IYRQO/+QelCl19MjWIfoIkpxQlU++u5QXht?=
 =?us-ascii?Q?ikSZRK3FCBQQRQg8TpyC7JSdX/vFJJ6BVyb9/fu3IvZ5CuksMZ7t5nlzk3ns?=
 =?us-ascii?Q?m1kDiTqBcxbnzOwg0gjkz+GXDjSVFlS0VLKGAx6vcP+SRHqH4tpBliAYjpfA?=
 =?us-ascii?Q?//fRg/QlGv4DPR3YImiPEmCVeLqWvMJWCW9JBTchGN7wnedwgCsixd4HU7PD?=
 =?us-ascii?Q?trbiyZsmFT8l5Pv3yWAOFuv+UZEqfbJp1CU41rPjSSMLif3ChpeiR9U3zdRC?=
 =?us-ascii?Q?r82zgn2/U+qvICD5RsM7uuPK5p1Wm7zAiwhpgbYkXgtbdP/n0L5JgzkvPOkq?=
 =?us-ascii?Q?9TJeWF8IiQ5JLiDFchRTpQKg4h6GDj4zgqc4QvRbe+59Fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CMvffkDotPDf8YLQ/XRIHaeVnUVBTpsXPmthcQSYKFDbG4dV2xFiCtFcH+90?=
 =?us-ascii?Q?XzoiucNH5rdXPBna7mRQUpJQSbEwLjIPfNdkl+haWvTJKhz36sz4QwmXIXop?=
 =?us-ascii?Q?rX7aCOOJBvHDgiL9hJ4sTzoOle45Nez2/0oVyUwOTnvN9mX1lLGnQapLiW8g?=
 =?us-ascii?Q?7zbyzAzHc2dqz5eb3Lh/lkq8cBDPylYsQFOcPD4cWIKFPcN3nMZFh3yidX54?=
 =?us-ascii?Q?rJVbmXCjoDE9dBHHR/+xSoY3PuvEuO+ZyAmHFkkCEs6f9vnfNiBpaBaEXq/g?=
 =?us-ascii?Q?rJRV1l09dPMd13f/Aj3xG68Yo89GSkC/0QZxBVOmeZnm1UjZZ63xkAFiMgut?=
 =?us-ascii?Q?kYnWmkTa/o0W+SA2v/5opsX3p3LQkbVWULaVsugMKwhLdMKt7ubvHaIAav6A?=
 =?us-ascii?Q?1Xl6UUJ1iI6A4jV/6uQn1PdKlGgE5qnaMzfrfv2c0kNMuND3VDRqz1CoBFaR?=
 =?us-ascii?Q?KrPCuSyf1ze6wsy2fuApRFBVsZiW/beGddGLCv8h0cbrnT2o8jCrf1PBCeJm?=
 =?us-ascii?Q?3pM3wbuVKEDyI0CaTgoBWiuoUzAfov3OOBMLNmqat69BySD9zLjMJI2/AHdv?=
 =?us-ascii?Q?e9Ed5z3BsMVoZbjc15+0nw8amwjTMd+xlciHqbPDdJENh6KIIesb1zDIdzJ/?=
 =?us-ascii?Q?aMgBOBCdvh7tW6XRLwam7IOVFhKWZihyOhEQ2LPHPp3mgyAvNuSIPmEn1BU3?=
 =?us-ascii?Q?mAeMLCxPwN8cXMsPtnO69nGdl4057rWIOFNNIZMUCrSmUpwL0vVK4Y4AF/rl?=
 =?us-ascii?Q?w0AkGS8NfQ1ZZGLVOyOy74DqzIYSlY1t5UkKPBtdgnC1gnhJzX6kCQjcseCq?=
 =?us-ascii?Q?yHzzokaLd2UWDg+AA62k7+i/r0mn9bZ1mSwJ/3f6tiLAVQIGQcJVBwP/ppoA?=
 =?us-ascii?Q?fS6hDfkM+oUlG6IVxyugmMvjNQBnIKm4Jkn9dpCFoy7xSk7gBdep8R6DTm0X?=
 =?us-ascii?Q?59inJyAm+S9F5MdfqF3cwRkxfnwJhwbKXplLHhkNqf56Mn3tP/K2/DgTUxyc?=
 =?us-ascii?Q?xMz+a+nEfdMhbMG6PVnREQUv7pXUt/TBLrMOQBm0rWj9X7VDoC7XAcJTDqJC?=
 =?us-ascii?Q?fysA9eHKbjwBX8HNs7P9sCrmgfhd4P/gwSt6I82aj+PNpoIXSVX2rW8KJrX3?=
 =?us-ascii?Q?yjltVRf5ecjlJMNqgegsq+GKnPTHtINQR6//4jT7h6uZGQUlCed8Q6o2u7Qi?=
 =?us-ascii?Q?DNGWCSSswwGmAXxvUy+mpgUOw/LJxXYQDyh4QJ9WKArx3TFfkaEFa42WuznH?=
 =?us-ascii?Q?FPcW64H4RDMe4z56DYqwT6/VDN5nvdkZy3fxKvUP/66rZMkIYSTKVAyNyEH5?=
 =?us-ascii?Q?JyYEawJxqxSe2SpY8rPAWVj4Mp1vSvxAqkI5x26M8OiTkIt+SHttYbq0gfNk?=
 =?us-ascii?Q?1NvHIcgLxM8bhROJzw47iM1nB9vj6U64dccQj6Nc8ZGWRVyMMe6XtDHvqy3p?=
 =?us-ascii?Q?nYSeFCY4gWUqe5Lyd2yPI50B2zEWDGzL205tBV907NyR0rBnPUyaJfiCAHRi?=
 =?us-ascii?Q?sU32zilsTFXY3Qotu4eeEv8UdJKpBubB34JZRXYFAUNJz45cy6rI+t7P2cr8?=
 =?us-ascii?Q?iqEP51HTcZO4HPJmbsftLrW1a7hvqKhfcXP37c3b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73518505-6963-4f6d-f932-08dcea983eb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 08:31:19.0573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeitAcgkW3bYJaG8/LGFxjKu3qTXqXiq18BFZOeSw5booa37yDEAnNHkeM+qKDmtcN8pnLpBn/XOUFR2tGwEPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9251
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

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP SDHC use CLK_IMX8MP_DUMMY clk entry. Without the clk, the bulk
api will return failure.

The correct entry should be replaced with IMX8MP_IPG_ROOT clk in device
tree. This will be done in Kernel device tree and sync to U-Boot in
future:
https://lore.kernel.org/all/20241012025221.1728438-1-peng.fan@oss.nxp.com/

Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API")
Reported-by: Gilles Talis <gilles.talis@nxp.com>
Tested-by: Gilles TALIS <gilles.talis@gmail.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add link to kernel patch
 Add T-b

 drivers/clk/imx/clk-imx8mp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 34d91cd6880..1d04090ca00 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -197,6 +197,8 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	base = (void *)ANATOP_BASE_ADDR;
 
+	clk_dm(IMX8MP_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0));
+
 	clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux("sys_pll1_ref_sel", base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
-- 
2.35.3

