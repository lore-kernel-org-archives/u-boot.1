Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915B4CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CE1849C6;
	Wed, 17 Jun 2026 16:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xl8LhyIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB0F849C5; Wed, 17 Jun 2026 16:12:01 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0181849DA
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLOiJpdpzEXooLH0Ph2JQx1qahLRFS5tTDyQ7oT5B8HzROjxwZ8XcACrN78bCFm0z95pq2bdFE3K2rd8P3W83P6HqQGnUyESMDWSMxppcrJwsxHPVwI1TgbG4QHOATkOE8BP3Sp3tTPNlYCTnUr4ha+TVLeX7VC/iHmwiJvbXu/fDep9XrxerPq6dpjWil2uqivSxs3zovj7Yn6y3TTGbiyRTHTRidRp5XopcOKZae6+ES4dSrJQL9wAYUDIWgBmR18PSKAfgB64ORJkT4aa6KQ8Szsk03caNLR7bTemzDUSabJaIGuXBb3vWdC6I/7OYAKraO2lVqX6QpukhTNAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8Gsa4mXEOVRjGc2f5volgG7JfMVuHaTnI+vlbvTV/w=;
 b=sKg1CSWo0SUC0TW3PXQ9ZbiGFeMRMCrGbDwSbJ6XDlY/EQ2CyVvqqiQauDunpQ1MqJVGKpzMeRaZF7cdRT36D8tUPfw8iG4TOVirONmV/QKi596fTaaypsydwOjknue+dW2K0b7rdFjOzhM/3JWMzToYoGjnnRvTjYHh2Xb7bt1wENyCdtlWEb77/Kt0duw7wu1MQaxxGLiMdC3xmoVpEJDzweObv73tuKhpAO7K+qZuCAqVPfxtNDrMH5+iZoGvzToDID7M9S2a9pU3zH/FckeEeGdi4BJTwJMXli3L31zE+iY549hHIva6wu28CtNIek9DqV8PnJEUHYQRanOojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8Gsa4mXEOVRjGc2f5volgG7JfMVuHaTnI+vlbvTV/w=;
 b=xl8LhyIH8Qsccj/o7qCLqUKa1y12u+5hC5Mr4KLbSmp7zXq8De9RVfN2vvXpi4lcKuk6ZsbG2lXm49lbulZdDvRDYfJHIgSZW2gFbfZkLcXtWXhb3QNXmQozMb0ULPbTZAj92GYpG/cpvTfnzwUB3S2M26OCUsyHqkeNApfCc4KymOCatlnGe/RGROh7VaIwi38K8s1hrgu0nhq8J596hqYgrvU4AHwm6MmATpRIb9zfJj3myZI1kNDoaRYH6gTkX1Oy9SPzJ/s50uVMeW6jvedtFAMKezRFzJv2ezhPnX4EY+SyUrLo5xM9CzeQGrw6961CyWY5+j664l/mC+M2ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AS8PR04MB7623.eurprd04.prod.outlook.com (2603:10a6:20b:29c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:11:58 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:11:58 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 4/4] imx9: scmi: reset GPIO2 according its node status
Date: Wed, 17 Jun 2026 22:14:46 +0800
Message-Id: <20260617141446.2794896-4-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617141446.2794896-1-ye.li@oss.nxp.com>
References: <20260617141446.2794896-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|AS8PR04MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f8e2ff-6d3d-42b5-b9c1-08decc7a64c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|19092799006|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sWJhCIm18qD4x76NiktDGIhNOyish2iiCluf5hrYtFqP1yyXnVrQLMiqklmBPTYWWS/GrqVT3niCtj4xe0XMT+Il7gkWY6JdsPwnvyGnH1qRa+9J88XyuXqMeFe2jGIMfwtAPmd73gfHjz2sVzeqZJfOIORi2GTepDhY6X03fge/u5KKPxfQNfLHB1CH9vzqIlyxGO50d0fSJt/cuRq9rPw056PwP/ao+j37BGuyxto7hL/Sen1T5i3UQt6mJX4Bd7BFnQlgmmVcCfCaWT2Qv8cfPbADHwOgO/T6y2tZn2X+7t0IGO+xVKQ18aVDzL7s2VdcxbzeqCSEYmeJ5DqyEweQcJIg/UFubrJZi/mS5NV/IDgLet3a3de6f3EHezL5tn+Ul+HjSz1eB9/5PeqORazJLlUDNL95WjekG+r3X16tITSkd5sM/vqnCW31G4cLSzuTNuX/0HCTKjRCvwRfZ0u170B//9yfYGeK+pU4YHxtcV84bNKre+Jc+kor8ekf3VhTiClzSIF6g1c+N0Pnj7QFpthoBA6a3xh+hSnwoUuRAbiEeML8+aukuW4ejFIKDAWbgmZgQK3MjZnHF7QwzEpl5Edktq0NhAEKzhn10N2LXJlIOXv1V4xTBO4RHJmjOVt7gRtD9gU0nskEDah3Sg+77qWZZTNhwCS/9cZa7ag/2RmhEPssBDSypT3uyEkf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(19092799006)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ju+9VuA4rMGP36lIDYbL+yirFe638fhBJ3wm2p6XCEV4Bk+ugMf1VoQOAEl8?=
 =?us-ascii?Q?P255dvS6w8IuwzqzbQE7vkbYUIBVhgKbGDn573eTXmVtewiHADi3Xim+oCa4?=
 =?us-ascii?Q?Ck0rwEry4hkfLw20nbtlTeUyI0F5Mh2RPQcIz9Rk5EMiC/iAdE5HHjIvwIIT?=
 =?us-ascii?Q?/9TSYQFHoi//VPwMZ7rlWKh5vuhFSij+xM7BMxZBvjhdlnhJxkTvA2X5PJg3?=
 =?us-ascii?Q?+rlOeLJngbLsSiLXs2L93Oopq/KepKaPBBS0s2SzLallU/yWkUPa1og24krJ?=
 =?us-ascii?Q?Qw/mWBD7HAVG7r/XldTf1/09zYwnGBFbdDQTKV6g0MFjQD6ECddvdmGtohHr?=
 =?us-ascii?Q?jLwTV4WyrJMOYDHJRvRT8ppemQ4gRu35mNMn+o0hsP6y8zWI20zRdXxUUdHV?=
 =?us-ascii?Q?DqGWKsROJ0qr2w5r7cSCNzyUWsVAePuTVpw1HPK3A9l9v8kTyENbdL81EZeE?=
 =?us-ascii?Q?M4d303DskBXLunG0KgoTJjLA0QemHUUJE0k+LIlGoMtLsSjLjt695+f8KCMo?=
 =?us-ascii?Q?MOoYzo9hgYnCleJMhxHB3vgp5mSQ5tcDT16UnY+n6U49hQvYJtb8gOlbaFEI?=
 =?us-ascii?Q?c67bJ93WrPSu/MfB7T8UJUuE0+LSthpDAkioh/b44paie9MjtwXZg+4fMrNs?=
 =?us-ascii?Q?paVY0XJzh2pSfOAUgu8OSoTdB7pLQ4nzkJLG5Oplve/sLt60kyqJTD/iqy4G?=
 =?us-ascii?Q?VZcPsucycXhSIcv3Q8XOKsZVXcj9Cz3CAapq+U8F9BHOWJnddNFJIIxU3hXK?=
 =?us-ascii?Q?TQrn1wtDVWWXrqHEzop7FISzc6MK+AaVx3PDZrO0CNxQbtuSyraXaAE2mQPP?=
 =?us-ascii?Q?7/lxw5iL92dRis/LxasfbfG9Pk8ih1A8Op0tgqi6HkXkdeWQoOPu1LM96zcf?=
 =?us-ascii?Q?4SJcMvbDn+mlBq/yco8FXJW7T8zsddv02FFFQvO0a0Ita98Zs3wJTWne2ydL?=
 =?us-ascii?Q?moKRJqzBnmQvWQd/7Xc4UXvNUIj4VhYkladZPnsCRf6itW6owZk9LXmM3seb?=
 =?us-ascii?Q?BNB2ZK8yTheq8+oDL5aPaxOj+YE4BN+RZ7qX0wr9ttJOEXssQgVMlPQ1KLJB?=
 =?us-ascii?Q?wXI4AaxCHKyQWI+a3SJ6NaDiRFsAgv18EhNm5jCAeUuNpYnrq/tl4il1RVq2?=
 =?us-ascii?Q?o8CR8LHCeTW0NnQ5LiMEdzXBSnFI6jhHgXIXOdWilGgDnqSxqJOtaSDWpzek?=
 =?us-ascii?Q?ume4BtY5SLsnPzAapqQ+JkGfdPFP/0nnFsUdVstvwh7ErLdcCQSZq2zV9tvN?=
 =?us-ascii?Q?Wf1fbGlx1DeRwF87NKA3MtHPkKeFufAZnaOnCXAAjTkH+1rX+4TahYdwcxEd?=
 =?us-ascii?Q?uXwhc/6hrcuBeKFmioGbB4CeQQAHtyt1jMefYJUKQcoJb/cobxdfWwC9o8Jw?=
 =?us-ascii?Q?1SE5DgjeuFjsyV+/F8VNMRuuy+dinoK7W7cK4Ru+zrRi4Cs6e/KDiHrgSnG7?=
 =?us-ascii?Q?bG4R0yV7H/0u9V+W4oJX5OsiWMUd2eMleisnyXW+cpw898CA+/aMpwJI/0Cz?=
 =?us-ascii?Q?85oAzlaHheGYJMfmBDVZd53rI7sCIUzcYnWlXuXm3SPQsLTwl+vGruzTt3wu?=
 =?us-ascii?Q?mXNoN6iHB149gl2RorgqKeGyaKlO9zGW8b6H46Kz02ub3ODT9CdUWl+n7ULF?=
 =?us-ascii?Q?kbZW9Rdy88yTa9vf0HPfhLxiv5uWySvFBIZq3a1tNX7gGw9cWEfJOIBE8ESc?=
 =?us-ascii?Q?+aggQEAniURXYAUNQnJPLj9aZwSZ/rfSgZ67JmB9mluprbP7SS7uZYrMYgpn?=
 =?us-ascii?Q?P9xPQMF0XyiNJqIXlVsHv503ZszBQ0U=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f8e2ff-6d3d-42b5-b9c1-08decc7a64c6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:11:58.4858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t18HsIQWt0skYnCKUPSPGN2Lwn0ZdqRmR8kojUo4KnAaDWObY5r7fL6s0nPTkmnorxiILtciorp4v0fh2IsMKHaV2dAllddYfLtPjQwuRtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7623
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

Check the GPIO2 dts node status to determine reset it or not.
On iMX952 single SPL/U-Boot image is shared for both mx952evk
and mx952evkrpmsg SM configs. GPIO2 is assigned to M7 domain
in mx952evkrpmsg, and there is no active user of GPIO2 for
mx952evk and mx952evkrpmsg in SPL/U-Boot, so it is disabled in
DTS. Otherwise, reset GPIO2 will meet hang when working with
mx952evkrpmsg SM.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index c4127349aa3..00b8693fbe0 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -14,6 +14,7 @@
 #include <asm/setup.h>
 #include <dm/uclass.h>
 #include <dm/device.h>
+#include <dm/ofnode.h>
 #include <env_internal.h>
 #include <fuse.h>
 #include <imx_thermal.h>
@@ -949,6 +950,22 @@ static void gpio_reset(ulong gpio_base)
 	writel(0, gpio_base + 0x1c);
 }
 
+static int gpio_available(const char *nodes_path)
+{
+	ofnode gpio_node = ofnode_path(nodes_path);
+	const char *status;
+
+	if (!ofnode_valid(gpio_node))
+		return false;
+
+	status = ofnode_read_string(gpio_node, "status");
+
+	if (status && !strcmp(status, "disabled"))
+		return false;
+
+	return true;
+}
+
 int arch_cpu_init(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
@@ -964,7 +981,9 @@ int arch_cpu_init(void)
 			disable_wdog((void __iomem *)base);
 		}
 
-		gpio_reset(GPIO2_BASE_ADDR);
+		if (gpio_available("/soc/gpio@43810000"))
+			gpio_reset(GPIO2_BASE_ADDR);
+
 		gpio_reset(GPIO3_BASE_ADDR);
 		gpio_reset(GPIO4_BASE_ADDR);
 		gpio_reset(GPIO5_BASE_ADDR);
-- 
2.34.1

