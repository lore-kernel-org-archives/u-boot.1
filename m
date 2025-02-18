Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1B6C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D94A80F96;
	Tue, 18 Feb 2025 13:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vX/qncF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E28807C0; Tue, 18 Feb 2025 13:10:59 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A7980BA8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKxy7Skbs3K2qklhKpVrF2ZQXHDJlNf2hOFN2UqUrJcXMphoCzcRvSSdJJQ3lHek0GsU2ySbZXaP1owz5B+PCL/CB2EQ0oJnuyjnhq8oRk/QdCiGIOC8IJ4Njy6eBc48zAMRUnR2G0mkdwTqPxyGcJBiQXbw2/we+ZvAjwAy5RJakzT5hVXQIg4IczKgIkEE8nYshLYr3wShBLdW0WBIn+QzUZbJDx3eEKH8BcINR8c/T65OevRgRuJx+b+F7hfNmy+TT3TxtdPWV3PU7+XF+dWD5nt2T0bsIN3Q8k32JCv7gPgckKfCWPctzPowl5f97emA8gdlmWaBLlyYs9/YRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4DdZ/MbGuxEr0efWDDzPMG83wkpfUyCwuRa9mJgjFU=;
 b=VkAr++or+jRpc+g7c80X2iy208BYRzgF11XXg9gRFDhrj4AuOAaMwQ1naUQQFNhuEbk/DYCvYdiAED9+dsetiKiUF2GMGVyEV+X0a07dBZuI3piOQboNWPThN6DdduzkKhNdefKl0OSesfPvPjjM/gZhH8tWI9KYMXIieMug4kQj3iKBLRRR+/L3+phCwJhikJID6HF2FcExdlrs9G70W7a/g16vFRPeS8GDsUE+ic33ePSotZHMEdPW4jHWxKbUzt31PCHrAjvCNZ+VT/YXSWgkKvdhRkYI+rEm75JQjCwXo05ZYi1hXdKn6EHp59fZ0P/MDOfcpWW1p82IdaDbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4DdZ/MbGuxEr0efWDDzPMG83wkpfUyCwuRa9mJgjFU=;
 b=vX/qncF1gE4J9sOMa2EPxVDCzLQjX/PuYUJ470WTfd19epKBFelViI48hloT7y2C+iR9v8YjvR1pPFPHgOBDnMKG63qlgS/R2YjT4QxUjfu3wGv5UJSLk2bcMWLWZoTF3fryxk8I/viz85c2Q12rjLSN1ZKHhRSyg/yyGlJSnmB9m7ULs//rYmkZP2IJ09KOkj8v0BlxHUrXgIsGpMaL3tM6zSUSOk4dnsba7Jf7pjNrQt8PW6nsfa3bafukct4N34gVtzy5LVL7duWXEncwyPoOkPl6tvRwfhcp6pVWjG2SN/PN3jGak9o/Qq25WTGSVaP3C3qdrHSwX8NOfdtTHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:10:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:10:56 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 14/20] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Date: Tue, 18 Feb 2025 20:05:51 +0800
Message-ID: <20250218120559.451678-15-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 859aab90-f62e-48aa-5baa-08dd50154c16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c48R//VJqN2dvEgY4FTKXiL0f3FzfgYIFOdqrIekQE6Yby7DH3y3C55JrAUY?=
 =?us-ascii?Q?lRSYL29h7+eVFkcInsvjTXaWFPcu4IXWmOjDbbElm/h+EWbA+66Z54tz9HHE?=
 =?us-ascii?Q?DBOrPBMiuGBIrae5cHQGf3V4kX5UmRQ7n1ucYyu43K4iUjFe63oVKlNiJXhw?=
 =?us-ascii?Q?PQY7HeMF9UZEFvVJF3ay6+1LuZR4gcFTAG4jL/O3PQJHIECbMiNLV0l8Swci?=
 =?us-ascii?Q?Nefchg9BcxkCgnkKg8/+gXoLr7esnnJ7wz1Gm6WdKLlDceSnmmW3HI4Du/sw?=
 =?us-ascii?Q?ObGYNnr63gZrgL+pfnbPe7gMrWx89arepzQ5OC1ikz7C0BFnZTz93d2r6jGu?=
 =?us-ascii?Q?I77iOICs5q60Xaf1F1zAPAjh7cAYjm1/FKquOjsDzdjv1k2cMHaB4FAZHBps?=
 =?us-ascii?Q?LowRPQiM8l0aDFqZPS5da931u3yISpmDAFdzDPfP3G86ErIpm+KE6z2GP9EK?=
 =?us-ascii?Q?vybTjAUYQbBHflpBZYjbcKETz7XY1M8IJuKLlgafl7euWvAS7WoyOWAJ+BYh?=
 =?us-ascii?Q?qGpcFrzO0j3o5/1xp+l2QDqwpHRKnTSX/Jk3eWsU8q/aA0G8+RuQlKySntMe?=
 =?us-ascii?Q?Bv/JXo4Sqoj2I23J98fx8x3/Ixs/5HDmh8NtVvFm3f10UhzwmyQVwG3436OQ?=
 =?us-ascii?Q?nZXZE0bOsgcJ+msGmvM/aGaIMtavKCCuxvKTEsi1IbC7RVCzgITk5r2H77Oa?=
 =?us-ascii?Q?HMc6qrW1Dm90xfPCLKIPdsFBtvw1aSQpPE2WVTr/Er/k78VZpLnEDqY/i1kh?=
 =?us-ascii?Q?KSU24DEdQR8pRs8yjGVrN8oPBKfPsg/bRVw0hBwcFIs5HLgMzOXTRKzlnNUl?=
 =?us-ascii?Q?gd5QlecEkhO++XRTn2yM2mPu8Vebg7xwFyuIJl1pvyAIu5NoZHVSuLZcosac?=
 =?us-ascii?Q?C26xgf8JVSvaeW81UR1upKElF6Cr4ptvZLudNuZCcgyXelzFU+C3jsE2ZFVk?=
 =?us-ascii?Q?EoWTJo7bDOqZa0vhvoToti5JPFWoIgji3g/pz/KBEWVrk9+Zv0ZNlw9aYAn6?=
 =?us-ascii?Q?q3TBVUnQJLn9JMhoUBz5myN0VKoV77gOlYNiyXBN1ZgAhrn6aijhKNc/+sS8?=
 =?us-ascii?Q?KI4rFOAWL8T78JC13VpiV6cc+DZAtcuwRivS3RtxOGjD12Fq2pXP/dVXh0ZL?=
 =?us-ascii?Q?R6v8LEutH++++E0NPVarykNIjCuljCUKz2+Gu4GeiOVQat4iJ4lq1ASvF/rw?=
 =?us-ascii?Q?ygcnC3Eo8cqRVa0zkSSuoiSqbdQBrVoDPX8iiek4LXYyVaUcjjqk86g3z4Mz?=
 =?us-ascii?Q?ddrX2JfXyQBsYOCnM0fVMc5wAwvhVi1d91WbL2L8cXC6FGMBGsYmuMWruPnw?=
 =?us-ascii?Q?p3pRyCsyueJO4uKXEkM9kOxz4I2cX3vOaO+TCgjRSEB4Bx3iRyYcg4/vy3jm?=
 =?us-ascii?Q?uspzSaS+M2O9+/u2LNyr6HqWCPT7icJBWlhEydgCGAlNTnOZoXA5iQ9ERxyZ?=
 =?us-ascii?Q?jHin0RrEAiToufpo5zvAwkn9kF5DOiVY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?az4ZgaMGi0AoYl7UC8tV7SKW8j7L7gJCWBlgtQUiweVO8p8DigComYKqNLVg?=
 =?us-ascii?Q?XQc4dlYSfnLOJFQ494r2HbKQPMmQIDvWlwjVJS1usZbYv8FEzjEJMW2sH5qE?=
 =?us-ascii?Q?hUINmirn+XuqwxJaDHdsUl7Yeyctwfug1/NVBmyVP1qhOdBUyll1liP8z/CQ?=
 =?us-ascii?Q?RneLfps+lXtrAPEXLyLBP9HwSKk72+XqsQXGd7Z1h8/Rqv3hHZ3xHK0IL+FY?=
 =?us-ascii?Q?4MC3tRw7EeWRCkgbQyA0ZQIc2x6D5Qver0uhyyPQQLrgA9KXYUmjbF3P34f3?=
 =?us-ascii?Q?gbj6v97xVVWKhdSaGsot3f/NvokmjWFyJan9azTIM31jhljfl0Us9pfLhbLf?=
 =?us-ascii?Q?9qVWLu19GjUmVN+C1c7wy2QNFAzFYPo3dVU8dC+mIwDqMrjcsRuK3xmCW+9Y?=
 =?us-ascii?Q?ktpzE9etybFUHGCqeJ4D8l+A7qUEGbct/FAjBoNl+6MtGXbrVmY3qaD50nMl?=
 =?us-ascii?Q?AcqyZXiPmRONjyAV3rchXDVSeB/S1UWyEJkp8IveInJoG1e+YgZZr08jFCRs?=
 =?us-ascii?Q?VehapfqtD9pcS8BfXi9gC87yPupeTOrsU+RvY8l8udCqrsv3bO7azJ02CVVa?=
 =?us-ascii?Q?po4qBQmsntwvnJSeWzwti6WkL28tVCKXYLiKAjpcuyyIkR/ThsGmKMdGNPNZ?=
 =?us-ascii?Q?1kbOygu7qb2+BslH4Iip5pFjsQVv2diCpMqJhKz5oitXmY3vIxlsSoIHLwq5?=
 =?us-ascii?Q?xBj4APVm29T3FuZ5hcR9lyVcHrRTcTbIIPbEIq2tixX1x/qlzPmbDRRAS+ws?=
 =?us-ascii?Q?Q8UQKdpUHn2iXIIGEgbULffhPBlXiPD9wryT7w09zgGPww26NWEOuy/2IBUl?=
 =?us-ascii?Q?F28H21V+SFDQvpCfDhB+4KAKUOGbvabGVPu5+7selrogtjf/8sixmtyT3CZD?=
 =?us-ascii?Q?SZHhfM2E4sT1Ye3IS/YSFGfs1BsEX3Kix5EdM92jJndWEulbmP+VcOTgNz7M?=
 =?us-ascii?Q?6da7O/gMeMHIuZwdxXgqtgbycfUGuM78Pys6kyD0hAfnHBnBKsGxm6nj9WvU?=
 =?us-ascii?Q?xD7cmTgEZpdTFcsCbU8f0SG8B4fBmZZLh3pyOxmj57euVtfa/KWuAsI4aupo?=
 =?us-ascii?Q?6MO/WIwad9gkM0iHQ2hvq7ek6aX9AqWMVDXXtS+E8Y7hC3ECax5bYAXsdyLd?=
 =?us-ascii?Q?C+23u6VhlFsEzSI7GZosZXtZyH3WF+pzU0ZuohTD4qCXrJh0ZXtiRWER8JKW?=
 =?us-ascii?Q?+56quMsksFG0RF/df2ASBFhL3E7d3Gj713ZWiKSOc9lFXdaiVYho/13Y8qgU?=
 =?us-ascii?Q?ml5lzFTPIqXgmGnPVkvTrmuOvWx6NUX2nz30mzMcT3l0psXbEfvCDQVNlfYR?=
 =?us-ascii?Q?9DqFMcbBZxxp78C5gzXRqZIX05chC2Kw34XUZ9sRyhWv88rbQlhVBOg5Kkfv?=
 =?us-ascii?Q?hOj8DZ0ET0NSO7tUeeLd5O947j7akDdll4eBFbEbAXyEHAdtp3e5I6Zb24hg?=
 =?us-ascii?Q?K2RwGBRq5qgDS5VC/BKOas9cdk5gnHzuO7oQfFum8p2YXKbJqGOWsB0u4TBS?=
 =?us-ascii?Q?wZKQM4VJzOQE5Vwh8zPpgYZ4DpN6+AM9IeXY8dezngx7pXd60fis4qWmpU3H?=
 =?us-ascii?Q?+N5q4rdLOwicPAWIdCRHkAgv5Q91jO1lr5ZuwICA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859aab90-f62e-48aa-5baa-08dd50154c16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:10:56.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugqtE8zkgRz2R1RTdvcqFdNzisveuyrAF4dI/i/4/4F6V0FDD4BHzAPBQQzchQdDWlu3Yxol5tj6icY4iGRdKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3..f38f3b2d338 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || IMX93 || IMX91
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"
-- 
2.43.0

