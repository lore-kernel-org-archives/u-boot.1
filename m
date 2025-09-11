Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576C0CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E10835C9;
	Thu, 11 Sep 2025 14:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NaBUgSGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F6F833AD; Thu, 11 Sep 2025 12:56:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B55A833C6
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qahs9CNEkjskaTWfSbBhRY6spNIFNNNdRA/h8GVWMLlinPHi2oRLurDpME86/+mHuY6AR0ICz7tGJqiT10koOxWs4N6R1AgP8ITtSKl9KwWjdfsWCqftmmpRxempAaHhuSFHmq+3qV4bjSnOubWd3J3hij+ZjJoZ3i5sc0emNCKzTP6/1BZT94+0pa4dJSMhwYyEj5Kiyb3nAU1P9BBmLaxOm11NN3SavRDmtG3NKphAdCH+9U9Z/oUJEfNyfxffkw3srBjwdr+Di5nq5ITRlFsXM2yx77KVtsJ+9x/lnr4bauYlAD/u7Ybca/NH6SOQPj1/Z0KAOwaqTJNuaH5SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXtFaeuJUyOLG0lm2IsRxjkxNkyUVhAwA0RA/47Y7CM=;
 b=mf6cSm6iXjkpwZ+Hu0aWV8DfpG3oNufNIdk6PA0v5KEG+oOWD39YQTnZojMtqkhdf59f9YqaeCgBXoATR4w2fRESVGduDvRalUec81KKSpbyl7TMM4KB7icTIwIMrjofFge5AGMSb/pFKEUaJyxAu25TnLxSQbEnkZWJ5Fh1rSqh202rEE+i+exrG5olP8NcULKjm7MuHvlz6pWOwn2CGrXPxg4Cf4FOGS6+s6EABnVaGkJiNRWeYrJSBSWG2vPuhgJrIpLBjGXRByDjdqGykAFc+ACTeO1MpmzG9oprNboR++uIM0TtHNlTaZ5edQ6yOVjb9Jn/K9Jn7HE5cpmBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXtFaeuJUyOLG0lm2IsRxjkxNkyUVhAwA0RA/47Y7CM=;
 b=NaBUgSGZBq011OWpUEr4/EAho+8rGJLGXDsse7HsjgN26Zxbg0qFCXlTFqwZkx8FEjORlrOe+EvvEC4pqlfhgX7wa8WKaMbPgE3ggCOoV2I43RIn5N1AaXtyq6IBlsdsA55pXuxqvAm7FXJ4wEt8hvw4+Cr+2vcLlVkc0JmGJY/uamG3JkzysAsRchNRTTM/3UP6thT5oHmREH49aQdsyJfQUTu7ybPcOwLTvOUDjGRwkXy0VX9AJDsX8eAidQ73I0kpW6C4nDQSVlSeTXHsQu3F/V6GALRRB7S+rLWcniZWzhcRLJnLrRi3QAiNoDnNW8+rFtYU4BZK3wVH17ltCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GV4PR04MB11752.eurprd04.prod.outlook.com (2603:10a6:150:2dc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 10:56:53 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 10:56:53 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com
Subject: [RESEND PATCH 7/8] arm: dts: imx95-evk: set alias for enetc PCI buses
Date: Thu, 11 Sep 2025 18:56:10 +0800
Message-Id: <20250911105611.3664965-8-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911105611.3664965-1-ye.li@nxp.com>
References: <20250911105611.3664965-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GV4PR04MB11752:EE_
X-MS-Office365-Filtering-Correlation-Id: e6994bd1-15e7-49b8-88c9-08ddf121eaac
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h1iCylF+uiI2K5FGCGzn71II/PHv0klFIm3+8dfYhs6U+r1qbtYHYQ1wPXu2?=
 =?us-ascii?Q?Ggocgrs4ZDqqPSDCV4kaBax28eOep13RvYYIwJEsP0jrSw6W54fOt8LG/VDh?=
 =?us-ascii?Q?Ow/fmrqFlfVN0KqiQus2CS1tk67cD1GajSISGWSlrnKfyVv4JgKf9S0B/Dnj?=
 =?us-ascii?Q?C+z3ksrt+rTCNX0nmjkQqvyD9N0stWdu5L+RzXJCnxbNizQcoygVOJaEQfoU?=
 =?us-ascii?Q?BO23H2U7QKZReTcC5efEHDoLngyM3MmmdyUSDUsFZv7iGfYHHlN1DSKX0KTf?=
 =?us-ascii?Q?jQy2PDArxt0g2brtYdACgdPI4EfNUF5Q6MNSOl80aBMqWTHo5IVlW8Y9rrCg?=
 =?us-ascii?Q?i7Vai7kn1r9uTzDpkPglMTGfZ5pzeOLP87rskgJ/k+NlcDUc0smNh8mr2m42?=
 =?us-ascii?Q?IpIkjyHiEqnRRiX/XE/rsJLZRPwjCkN7q+kD3T61Wm1VQcU/rFESOZ25d2z1?=
 =?us-ascii?Q?79WsK8zfPHfbUmsVQw8JGnUZXQ4ect5sCfq+JbanjRbMPv594bxShgpU2Lz4?=
 =?us-ascii?Q?S6/6awwrUOUlHtbMyu5OU305jxwyh1J1zQMvP9+lc2f0N5vzkkhsTX9WfLn9?=
 =?us-ascii?Q?uNMl8PLbRxp0PIqBmrtelNm1NJ86Qa5N5yXE0RHX7zSUE968gl0NLWF/zRr1?=
 =?us-ascii?Q?XOH7YEB/t+oYVEecnCtJS0RRkpyudZhQKm+Pg52O/OTlTPd6D2LoBnvihTv6?=
 =?us-ascii?Q?Ts176wrs9sTEdy1iM/n2DUyqWh3VgShtrSGpzxfG/3x63cgDKqQxYzxlKN2t?=
 =?us-ascii?Q?pYr/3md/CNczNCSVw2vdkguqtupGMEf+M+XT2mc+83MYzGRwR7yWNHNdiEoL?=
 =?us-ascii?Q?jhog2sJtFWPjlEHFUzMQI68m1TNXv/OrazwDZpHiYUkBDrEemUa+BruCToSo?=
 =?us-ascii?Q?LLkVPF7Sq45jKHJCSqJIP65zL/3JtVK0eU6dPpAxngHAwLMJD7a8TYsjLmbt?=
 =?us-ascii?Q?Yeo1JUlqQzVVrt7iWVdi5nxwaLkul7X34zbv2ypFIh+a6D3KJP/pXCdjwryY?=
 =?us-ascii?Q?ghGLpyctpJwaN0EwbPyJ3FGkoLXzwM5RNLy4LsYN19YgdZO8JOAXCbNgVfxR?=
 =?us-ascii?Q?Rdg4ORiEYmJkB7NthB6zBQ01a4iKLM56473EFDC34fOV0y1zHEHiIIPygsiv?=
 =?us-ascii?Q?8/K52PkLhRbaUjHomkRN0xJewA7x+1RZF4OW4VcL0EPE91+eoDw/VeSeAPXI?=
 =?us-ascii?Q?AJTt6ik/TaKRwheDmrAnu/Wve7Sfiwah8hjl63YVW2DDR6OpcyOJwaGhrEsq?=
 =?us-ascii?Q?49B+nMHsCI8+ZD9WCt4RZrH3osezbBI7L8wIMn5cRn0on8e7eb5+usK4cPIc?=
 =?us-ascii?Q?qyK329U9lec0rE7Wf8ws/7g6/1pIBCZ8hH4yTSU3ppoSBPFODFDhCIDH9oa6?=
 =?us-ascii?Q?y213K7Fqqe1KkvYEjmO6VEECpsWfnqzPF0uVEe01GIeMB42RfykQ/f4a52hO?=
 =?us-ascii?Q?fTKpTp2zCPwWxj8/ziYbYsS8dM51R7H4h4O957oPrQplAz13Su19trX+wghQ?=
 =?us-ascii?Q?VMtmjE6AJ6XgzZA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8NdfEi4jYdh/K82noNDxFr18bE9ZHDPIeRkE7vgYbH3D4/8TW6vheR4dFyQ?=
 =?us-ascii?Q?idwXvl/0dALqT3MV2/Xuuw96Onqg+tFRCNsPmzFwpO47BeFfwRUWr/NzYa0k?=
 =?us-ascii?Q?wjP/FGFeIqio4O28CCMVW52Ydh8bIOVZEoMbJV9ZAC6Gy7Z3dPgvcfh2gMrn?=
 =?us-ascii?Q?w/tlLtdYrJa/Ggnq9kHmAmHIe8pH6yrVLepqPjO3pm0GEP1UYAWC/GpkDUoo?=
 =?us-ascii?Q?3gJmdVtj0wSnfwJkxdG+zkmH2gdt9YllBDVD57O+OILcbSdZkt46Y/qqrR/Q?=
 =?us-ascii?Q?QUACTgB4nhOHgaRCTnGuOImfWyqfxiL+4Z55Jfg+WXtPYCn8t7fGXfdX6Cxw?=
 =?us-ascii?Q?72+cjnvRDdZkP4dpe8hvpIiblpwcDXIXz6fTv2S0hCPkpK2x/qTI2TkmO23G?=
 =?us-ascii?Q?LgrFEZSg4e+OKUyVoDoamSiLzQsf4Zhis1cALOTNscXzOH11pMTvF9D4rkqI?=
 =?us-ascii?Q?I1jq/90C5ePFiUO/wbWCKAW1YiNqPzXX9he05X2nhuStaW79KW3bDMoiZLVV?=
 =?us-ascii?Q?1HZ35hBO8aY0A9wbp3/+HZGEGrhPwkV8tX+h1Px4G3eal01/6OOPtxpmz+iu?=
 =?us-ascii?Q?j2m4RjTnmKmbKWLNvHNH1+FLbQg+W6sodl05kg9MTLtEiAJ0Y5acT4baKXeb?=
 =?us-ascii?Q?moLFHg+a2mzLXhuc5KpwzEzFHC8PuiIw1/WAY6cJrwJEX7adbGtQDGaHDxA2?=
 =?us-ascii?Q?XhXjBk8S7d5WXiAMZcozqkcv3eFGTWtrCWc4kiNIN88bC7RriiOGaj3+QBnm?=
 =?us-ascii?Q?QAPytvGsnwRs+5I3xwjPm0mrb/lg/5lI2AHaHjCFZLAqnVk0jYFgz2mYGJ+U?=
 =?us-ascii?Q?39jnSLchsAgePdc/X+ywKSEgmhuy4OpvM61lk3ACKyEawKUxu/f52PDY03eL?=
 =?us-ascii?Q?8tD3vv/TW0wqod1bMMejsr3rjGHH9Vk0qZZdWsy6Bcb7ul0iXJyNDZJwid5E?=
 =?us-ascii?Q?4z3Qlc1GIIuwGOIScscjBypyYi9L1/y2SKnhev5NZKih1sBllrWdzvZWH651?=
 =?us-ascii?Q?su4BOWR05l4MhnQ4zecneUyOYc0EJ3CAVEzWdn0Cjc9yQt5bj2kO0qGN8l2L?=
 =?us-ascii?Q?LUsemdLF0u5t87OhLRAlQ8jKP86/JvzuchKzaGePx9TBCCAYyUeTxfINa3U3?=
 =?us-ascii?Q?hq55yHLMuhsSQ07TKt4kQWaKDrUr2FqGkQlJb6R+F6AwHGV8FW1X8JJuAAPO?=
 =?us-ascii?Q?2RPk15fNqVPLPfOtIxIThjQntU5aDYMPFMY235N3CYSFA5XiXktkD5/iDRxc?=
 =?us-ascii?Q?8nJ7m2DKIdAJ4ewnqrczmRtvs6Wkaf0dqDUoiEF4jAgJY9rf/BSZFz5vxBdo?=
 =?us-ascii?Q?LBIz7ht+aDKGFmsN/C6i96uYYhRK1judKB2Sky1ij89DsTkx0v8dE12zGmxu?=
 =?us-ascii?Q?SEmaZGZlyHvPuKU4YLz5jCy0XiGfgJP+A16spCxn28c/KJwY2He0P2pQXOU7?=
 =?us-ascii?Q?OVXk2N1jlO0fR/3A6CIGnV2bDAj4zCzB91yNeyus7wIay1DR5n9GwnKxZ6pz?=
 =?us-ascii?Q?Xzy9Z9jyHnd/ZJLvYvGM3V8RGTn4MShFxyBITUycOqNZ6f5HRFXqCSsM8PvO?=
 =?us-ascii?Q?FsPIVBZ/924RyzzrEFjkTSn4ttWzm6nAWI8ey3uZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6994bd1-15e7-49b8-88c9-08ddf121eaac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:56:53.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVm/RNkkLkVEvFAsHWww7vwDX08PeTr5veVZMWqZXaIYBWZuLte/ycwFF+b1Gv7G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11752
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

Use fixed seq 0 and 1 for enetc PCI buses, then the seq for PCI controllers
could start after them.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
index 2d1f02baa5f..8b59831b7ca 100644
--- a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -5,6 +5,13 @@
 
 #include "imx95-u-boot.dtsi"
 
+/ {
+	aliases {
+		pci0 = &netc_bus0;
+		pci1 = &netc_bus1;
+	};
+};
+
 &lpuart1 {
 	bootph-pre-ram;
 };
-- 
2.37.1

