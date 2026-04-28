Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2984FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 09:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12426845CE;
	Tue, 28 Apr 2026 11:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gGv3KNq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B31845D0; Tue, 28 Apr 2026 11:05:50 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4712584324
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+sd/KNjP/fl61t+RVR77Bl5VGUnGVqG6MXVnuvmQnzol74vUMAGT5wbTPtFTutzqZXCMhcZvwsNlHVyct0NWInqxWlx2AVNjI9NW89TvjWnzuZewf/GyWIrErtcXRdFkW38v/qk3FqwsuLCeikP6afgHTxpHZx2xC/nW5kvTXsCa3HdSxmJxHQQwPBZWWfnQB522XamhCqdz/6qw52El5b0mTVoWv8saY4SvkoMncKPNpMil/A7ov5c8BK5NAuyPZLWqV7Y0uLPwx0WBzep2soUYnOLFZAN+SEMF87qcKOYjuOpjhxQT5YWln7N30qWAMN28maaLLmwMasbI2xR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV1/Ki4Zz4wSHpu7zjZ1CU1wqCziIG2TxS9V0YouRPI=;
 b=y2vQBZriQFvd16RwO/L4g2vunN3ASXb2jzjPR8ycZU8HwDn7DHgqQzUo5AExtwfSXvdmTnAam1KXTyjAqURWQqZPCNmeNovKGAyxgE0nd4WyxztMbILSjnnmrBDqoayNT7gC7CCOBYsBFeDL9mZceVsr/CJT7SGTi0qJgMOm4aXTcNKWHuiwC9BxHzDC65U8Xw6LT+NB3MT8BhsXrrOKOwHbMT6Eb1a7/6qbL9y97clg8LIWh0K9lfQVg0jxkHfVI5ASdFaCOhkEPlkuWScTRDSj2HadWLxZY4VKbijgaZ0SW5pHU/ZjVyFPH1fRET0rhVwY7EUTu6gVJ9O9Oq+7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV1/Ki4Zz4wSHpu7zjZ1CU1wqCziIG2TxS9V0YouRPI=;
 b=gGv3KNq+oezMoEDT7EbA5HX70/XZavS398PXaAsPe1VMs4GiQOuNUmacL9wq4bKnW/Z2vVWeA4y+nj0pR07wDZohoQBvvjiq00NFGgl73K5FRtFeRyedKq+pwSt6LpL1OMGCMDegmDn1zsFFD0ol7TSaRoHRJlEWQx7+AMgYL0bBn6/V1g7Aycn525RrAENKlqX/nihVTBibotn9usZMUEYo6OaPtRXAXjgsXboECVojyGeNCQnz3VBGFF0F6WslCa0CixBNpapn72dAMRdTAjAV5EtYbhqLxfZ3Z+k7qK1g2xQ83I+95JRxn72Z3mIsoKphKxCiIiq2btwF2estJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by DU4PR04MB12064.eurprd04.prod.outlook.com
 (2603:10a6:10:63f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 09:05:47 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 09:05:47 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] imx9: clock: Fix missing break in get_clk_src_rate
Date: Tue, 28 Apr 2026 17:07:55 +0800
Message-Id: <20260428090755.1809366-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0165.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::7) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|DU4PR04MB12064:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ae3f19-b985-42d0-137f-08dea50554e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|42112799006|366016|19092799006|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: fghg79bAC7Zi7K9xgpbLsLEgYyUzwRaNRyJfJRC5nr7MvSncDbFbmuyRAd64wP6+UVdSMGpYlO3QnMWxOAIfgvV6idJ7FERL2DNevsRddkTqHKGUxlLYWhLRK0aLwGSphkp2MmyYz5XgV3EnYWoObDB4WHZU2++FindlAiYWLrFjHmomIyY5VOZ/YUGnGt1lvthhXdL6R6JlIKgxvdGzERgr7fM9kBporvu/CkDBor9TeEFiuTd385qbQ/KbWpGMEQ2dpixKTiPXy7CY6Shl+Wfvc6CjlR8/ky1AhzYNtTLULvRM6m08NsZODEL/Ntbyh0jmJkHFDjnerbGrQc0uAvzUbYdJNb/2mTPgyC3JKddkdgPQnM3dsPhIQ2BI/iCITJIOAIvKBEe7plZ9C2BnDN7d6QK+w3sERCieLNG3uWO+HQN8UYSkmT0yAPtHMcTiB8NnvdACFWWCN9UfyPWvvbIrlrQ91J11XQNtNd6+gg0YECaxpAVJlcsm2sGv+B+HhzlJ3aAUL3ZnHoLIvNu7hOw/oXqHA7rXHnRW+kFxn1bSvqchyc6yk5JTOEBStNOnKBXp8RSloy1sJHog2Iq/qkmZfVLGFzdLdH6Yw4nymEs4AQGCITnVcearOTfN0ZVZq73KcVFbOMIavWlZKhKw1OWD3TfjEEc74fDZaea6li8KbhFxfzkT7vFiCaONBmgGZYhXe2u4yUzCDAbsK0WRAdren7R+J3cnATCm0g+YUULQFWtBqpxE5eNnk6A6Yhm0g2JSq+dG82ROYTyBdg44RtBlFs+MqYoPiUeQ36T53KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(42112799006)(366016)(19092799006)(1800799024)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BDWpZW1z/lYYw40thK+XmjiQvzNHFiLXpzD4agtFV5rZ69zTS9he/w9M6m7X?=
 =?us-ascii?Q?GKtWgIYEjY0JCTbpw/ey8CRE7iVLkQ5cukEfewO9SGwVYgKSNx5RsG6wrQTm?=
 =?us-ascii?Q?dz2o3+Z3vxIZpH0EDj6ZsnuhLR5ua7UTR6KG4MbQmZoFxpliKDu6VZlTyVld?=
 =?us-ascii?Q?wBqPMyXZ+DNd4FLhxYYCmu2jV35Rzjl6UyX3Np6F1ohF9AI5yK4UW0wEL6Yd?=
 =?us-ascii?Q?j0CMn0TCTCQsXwx6HfBO3ndVUQnxQmms7KTFezqBZcgSQkdNy7bzYGz2/vvY?=
 =?us-ascii?Q?E0cFoQFIkbFEEtqbBNolwbqkTFd3j/8VJInBrAX+1jV8Lg5uuA2WhnZABNZX?=
 =?us-ascii?Q?KiwwmdYuzEpS7P7GH/ToANlGXhsU/nrjPOTrd8GbZcbQ2E3B9L4+sjz78UKY?=
 =?us-ascii?Q?ICX006ZIM+cOiXMfPM3CfeUCyW5HUNczUlv/N04qx/vtwxyj6MnrAfyIbCBY?=
 =?us-ascii?Q?+UZC3eC3bc7cJByAufJ3UfwKRE6jP2WwZNtuQCqpduxkIrL2jpjKxKWF+T0H?=
 =?us-ascii?Q?kdHNrwNGVSuqi8+ELltSdk6I2wCnQL7EzZOdXaiiCCO1A3OS8QHTg+24vk6o?=
 =?us-ascii?Q?3QHQfD7qBszseCJn3+mC5W7TNm8LiXZQWSJzjajmRQ2oXE38eFzW5LjlAVMM?=
 =?us-ascii?Q?bTcl9cC4jZLRl7diF/L2RhiTY9X+mQ2d6QLma0PdtMfB7mNfxfMB/8RpGhoD?=
 =?us-ascii?Q?fDofcuGvfyTfHlgtWI/BaZq2bjtagy05dHS6hLDccgE/IRNO+2L7/SM+Su/I?=
 =?us-ascii?Q?xU/k+3OU6KZXSgGKnic07tO0BkrKfO0uwHgct2vEiAIGXP7h1Iz182bCzky3?=
 =?us-ascii?Q?DRe7dk9pYJZmJV/krnGs2UkjNI5Zo9uR9TZVolhtlN0svV0fJfel/1inLHNg?=
 =?us-ascii?Q?35Rr90CoEygzyvUa218O0IudgA9oE7UHVlN44bF1s+H67SntC44iFCM2Ha2d?=
 =?us-ascii?Q?mkb9ddFkudfEWdKH+6b7cjg/SjASvpvZvIKWtOT2rnRhyfuaLXm5q8P0s4n7?=
 =?us-ascii?Q?JfhpE7AdfWGGbQ8Jlunl6p5kVc1thr8n378dgf8CG9EWNj3Yh75hsUHnMndf?=
 =?us-ascii?Q?0jbV0Na0vlU82wxtM84m/gtn9xkRNNCIiTgQse51jBYl1E7OiZc1Q+YD5krN?=
 =?us-ascii?Q?yqYuaMNu87QvzPAQ3zXxQo+w5MuK8ZSRvG28NyvAvB0+LM8UGEKp3Ol0Rdvs?=
 =?us-ascii?Q?qBJLn50yECZ2C9M8Sh+K1RF9P92GLGDZ5+CbXiWOm3vOk9+vbY+WdT1FXFuK?=
 =?us-ascii?Q?/sANjmpBeqiZ7pB/zqJPqAj2A1IEf+5Poa7O5NALs3zgYAQ7UTqWDvk1NLcz?=
 =?us-ascii?Q?hI3YmaP+pqD1yZSFlGLoYUY1YeRDY6a1Swvzp56FZSx3hRFbaPuTenn4psGc?=
 =?us-ascii?Q?SIXpkcJh3NqaeAt2qqHFDKTixVc0NintWT/Yg13Ov8GP7MwcALpDp/kBc2ae?=
 =?us-ascii?Q?zbu8FFud0BwIURDnNhIErXEtig35o/KNHg2Vvpw9Y7eUZwXcfhguMp2x+YUd?=
 =?us-ascii?Q?rTZCzJSr0422UOXjgwU9Hj0ZagR63ZB1xVIsovogSQMFOZzgo7thy0hUSA2V?=
 =?us-ascii?Q?ND/9quI1vlhvCzPGor8P4ZL8AumJuM7qSo8xmYsMfK2k4hHpm+P+vowP3Rlm?=
 =?us-ascii?Q?twvBobvHVvI92YCF6pPXhoM1/c4+Iglt4ZEVkSpg2hoYIjFVJU/mEO/eIDge?=
 =?us-ascii?Q?vxx616HZoXYU0ZUkwKWBzglqz+JDHzHCVX+9+wdNN6ECiDvt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ae3f19-b985-42d0-137f-08dea50554e5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 09:05:46.9510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAZB1spvJyYaNN1qPeqiFvpbIe2aicZq8U3J5QJQIhKstvFiBuWyrcHIuo8/x8RQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12064
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

The break is missed for ARM_PLL_CLK in get_clk_src_rate.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 14a2bdf5762..4ccff67b7ab 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -478,6 +478,7 @@ u32 get_clk_src_rate(enum ccm_clk_src source)
 	switch (source) {
 	case ARM_PLL_CLK:
 		ctrl = readl(&ana_regs->arm_pll.ctrl.reg);
+		break;
 	case AUDIO_PLL_CLK:
 		ctrl = readl(&ana_regs->audio_pll.ctrl.reg);
 		break;
-- 
2.37.1

