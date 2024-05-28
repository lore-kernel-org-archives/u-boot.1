Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E64AC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96676884C6;
	Tue, 28 May 2024 13:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KCihwvAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B1E884BF; Tue, 28 May 2024 13:13:44 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414B788479
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4gvFI5NAgLdE+Lcb4GAXuRY7QZmRPyJC93I3IfLBTnnss3kiJV9TGA3DvdJmk4uc3TJ9nn6e2TRahCAM8sev+xg/Bm1lEpGTTmgzTAALQLEj1AowXJTuZUFDLWKDQB2fopdx2gqG1/ym4dc/PwTcRGPti3ua9C4uy0l6wzxbSZAMhvbO6TxZTKoclo60KPtJC3LYeutD29iSJXfsXXwHIC8Ngnqe2SU9FslTmULsD99G2cZVxuRJqLewy2Yxdpu+WVrdIgQoOqc/oQFcOS4nZEG5dmqeFlt9l0yq0i4XsPeoXLwIWqFT/VEiaCGPPk+iE4LwL5v/mzz4tA+LhMOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YswU0XEVpwdGQHB1Thy172b9uXX6TyFdteeOBmVgmiY=;
 b=HenZGB4syxRVxwAcpcDseCYTmp5W29JB+eM902c/QzYMyj6bx40iyAi3mYYQ7QU9D0pX5EHAwKqJflzlwG0SUaPcmrwq1RNroJRAdKBUQPbmCgkwNJagnW73Sxqcxb+ufk2AsnmciuchzPH5Xh1f678emp6aYYpJaAyXZ89jhY0rgZVkTOMOgKtlYCF5UtDJ5m0gyC5E1CJ4r/7TNTfcYlbb7Cl9bM0T5w2VodZ1eKPXPM9jU5tQkJVU0KTMVhWBfE16sPEG2XKWzOAPCWHA1lf3c1866ju1Q0FlTYmdXcnZfmUpydlnemZvV0wcY6JCwrAyxCePYho2K/m/TJjsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YswU0XEVpwdGQHB1Thy172b9uXX6TyFdteeOBmVgmiY=;
 b=KCihwvARzGbfJ4hJVwW6FByjXIWXVZ7NGnR3mL0/Nd3sj12b+sUJsSyypPOvwcNdZQ7aavMUyUzaaRy0erbMupE+mSdyrRKyIk7mOYPY4shAkml+vT0C5MxpRzAdXpJBPJOrkylkzqP6n5v5drTwp9sS1L1C6DRdDIqCqm9Nt10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:39 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 6/7] powerpc: mpc83xx: remove unused watchdog_reset() function
Date: Tue, 28 May 2024 13:13:24 +0200
Message-Id: <20240528111325.2163560-7-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
References: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: d119f6fb-f7f3-473e-abe5-08dc7f073a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wkbA2Nm/07UiMwxyz4SPpPICY94kNnfaQ2AA3wT/f892IfYTDUk8KRrLsrdC?=
 =?us-ascii?Q?WayYGu6PAk+bzhQ+AWECc7JwhWx63fLahMVdpeDZMRaxtNAgg3xmTcjwisZx?=
 =?us-ascii?Q?wGoFjMUAX+a3sL5q1xZ6t7bXHUjrec3h5qWHPQtPEZFOUag6t3z1jtsNysXC?=
 =?us-ascii?Q?b0WOn2v1F1nJYGD4CMnvilaR725LkVMSk1iDL0ImAiaHsUpLN0/F6C0OdFG5?=
 =?us-ascii?Q?emvSeU4zXnJjj4lylGnOhF1Q8PMPMUa2L5qHjIPwQ5jzM/UbVIaCGgvSg2B8?=
 =?us-ascii?Q?pN00XQWABAu7e6J+0WN3YOKyhHHHOFMk78AdB4xe3u1yx/iR0Eq9z4YGwV8y?=
 =?us-ascii?Q?kkHfeZ8cV9N1ky2/zCUUQKeHoHAdqvg+bRr4jIPMjVSOiuhB7bWY7TkVUe9X?=
 =?us-ascii?Q?1NIaZSlpPqmMNf2yAD48ifbb0bjBGeUCFDqUkP7K0eLNj8qX3ZWd6DgtfovK?=
 =?us-ascii?Q?No+a9itYpVBrYNRMiDJWi6HEbFQXXMpHrRgFGGf3mffqKTZYnzwwi4AL3Fbq?=
 =?us-ascii?Q?UzRTOj6ev9AgYTzLnE78aKVotnSUoAmW/1NW0rNNYbj7pDOsCzUR3THi8v0O?=
 =?us-ascii?Q?+cYndK+1T06Ke60da810C0JWV4AcTv94Qji6fLPQMN+QzFgwi4jK93BY7vVl?=
 =?us-ascii?Q?6AxuPgIqH+MyRhryhwMVa54wJOENWz/QoRSeyrIR8iWqs+cKDS8hMwrx7Uau?=
 =?us-ascii?Q?cZ1HR1rzkm6sTgk40KDaogivjTQPWfOLvIyPiWjHTBaOR/uNo5elG0xrDdDz?=
 =?us-ascii?Q?dbhbwA5CEnsFGryZYkVPEgRQXqWTCKkkBND4phGWKCo3Evy4CW81Te/lxXUj?=
 =?us-ascii?Q?0S0giLmV4HSv5hoN7xrnl1qovImTQF9Ne7c304fOMshmYUp7gTpmylPB3+Zj?=
 =?us-ascii?Q?mzbg8z6Aj3K1YBQn+rWCmQEvR6Q2XVADDqlSh7/RlJ36SlsplJsbHKGxGkzq?=
 =?us-ascii?Q?T+WM0/cFOioT/vtGIe6IZZDPnYQlpy1Gg5b7iQbeuGpTNSFqNwY1jjYm7kus?=
 =?us-ascii?Q?uiQcjSVHUxFEcpQPlbnCAvA1/6JxsIOrd5auhilLQ7nnsB/2LzpI++AOJhaB?=
 =?us-ascii?Q?RvisUaX0L57P93JelFOHSzrf/KQO+QXdV7Br3uaL2Ao+6nImjRZ1IBpSd1EU?=
 =?us-ascii?Q?uCsmKRXz1SebYSIFl5Pj+3hJmalXDH7BTyKNID4JMO+DcEWrwnd22Ek4RHZp?=
 =?us-ascii?Q?Q5HoBRCyetI4F/131wt9yS2L/g6X2Q1SBxegYy1gj47Op4AZUT0kw7Q5Gdhc?=
 =?us-ascii?Q?F7AC6JxjCWLUPb36ELT5tjUJUteEPJIZtCMiY4zIM7dXKtxGbE0myuG2Yp+s?=
 =?us-ascii?Q?SJFOD53GJuDFc/RDZ8mpeRk7NQTiyOwGtnVTjGqVkujnqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ly1GGtF7No87tZgq6g89JzikiqogJApOOrBGDh4nVVNo18pXuYLJmCCASmzL?=
 =?us-ascii?Q?RulIhEWbhEWO3yhwc1EwH/EeyoSiK6/i4Ut4RYGOhu141SKltsLdOIaYMwSG?=
 =?us-ascii?Q?Z6k/uN05BmqJQ+A+LUGlYo0nph9PovNlhqYa9qHCEX87CJvSVulbawi2ga+q?=
 =?us-ascii?Q?/IGZ9UY2xjRfhPAeAhJ00zWSkGZAgQ1crvxo9JQUJdKQGvX1wuETJTpHDUdu?=
 =?us-ascii?Q?1cWcZ/hKpngLMr8bd69MUq3+dcYA49GfxyfY03qsO/t2EZlY78JDwQd2cFr1?=
 =?us-ascii?Q?baeigfKKRI56PEZuc+DsGmmBSap4ttjuWMBct2WErmSncB9PMDnZtDfoRs6G?=
 =?us-ascii?Q?dUhLIOOTyx19H3LVrqVJa9T0RCCgRJA/k4+8iUyaVK2+CSD3k1fKBamVFWLl?=
 =?us-ascii?Q?U7yjcUmss2LcAeYWfeUZy7fX0GgKol+amA8jndaQCqikipprgIkQ7S0e1auo?=
 =?us-ascii?Q?KKfDOpYA6dCIOir98sK+uoqABSRf++puqijd8J0ZW1eFHYbn0Gc8Ictkpsyh?=
 =?us-ascii?Q?Vchwe6GgXp0/iRU279yzM38W6Vebe1NV+PQiMMGx6Xv58jHPAmoIKT+2LGTr?=
 =?us-ascii?Q?au0Og0fQKpT3ZJJ8EWaOBuBs4L80ynB0duEi5FNs4kNvFYjRQB/Tpg9+akUP?=
 =?us-ascii?Q?HXbWeY9pTwZVP/SiALSPEHqzEI+SDnFBIj5rnyJeNutrnHrkqVj7bDFNUs1M?=
 =?us-ascii?Q?nrHFZpPvkglpmcKUuBURijMLU0sqhYuB7sbHCXyf78Ia1w6DcafpOhhMRS1x?=
 =?us-ascii?Q?EFycvzF+epoaYH9aLdaDBd5CFfq4n8jijQQ60Y33C/N72jRxrYEEMU4QKTlx?=
 =?us-ascii?Q?36sAaYFno9xCIS6bI3tBlewhNWQWsHoVDqnh4/jlNuH8yIee/RJ6X7QNSJCR?=
 =?us-ascii?Q?7c4FivZmh5s/89BJat0OpctHDaVKM+g3gDUViHTPeBR6iOEtuJHTM1VV3ekJ?=
 =?us-ascii?Q?o7aEaemXbePXKuXgXB4NJ5w6zAgFE/I70pf0uCEacskvG3dyp4wMQ5pSu5xb?=
 =?us-ascii?Q?+FwwApyX1ShN1E4e8Vlkw0xLXlDzi5qfHykiblFSM0RtntPqlo2AkIdJNu42?=
 =?us-ascii?Q?gUz45eAiqgnZ+wP0Wi7pUVQHbtCFO29Eqy5eyLGZBIxdcom9GR9dO02u8xmP?=
 =?us-ascii?Q?OHlP+5cjlWEiu+uO6j2FEO949gKTHobiv8GB2JAfhwH3HXs4kVfCQPJXV5mh?=
 =?us-ascii?Q?STKfiUrm+toWKofoka9dQe14s/HzIewhMevl+8Ycrif/7ZJmFGaO4fquEo4Q?=
 =?us-ascii?Q?u7/b/6N5bfC2jw1NgECy4JeC+b078UdZdV+zGYbx7dFyiBQpecIGlllktmwg?=
 =?us-ascii?Q?LiuHxySQg0V0mM3+4/v5pcf/oG9cl8dz6ndQ9uc3Ee4yF+cUcmEeiKCWqRCG?=
 =?us-ascii?Q?jfqvkkEVSjhxlK6N4vZ4F9NexyEUxyobNlowDonYUMdqEjCEIA07lyTEYeFs?=
 =?us-ascii?Q?OmSgM9I3t7Gvh+lS6c3EObauvysDvM4cumy+Zkncwfs5IPyaC4L5XO4ts0kr?=
 =?us-ascii?Q?+/MuDlIOG3rF3snxuK8U2dfrSqbQwzJ8DND0HRTwaDPLerYPs/L8MHpWiJLZ?=
 =?us-ascii?Q?uuGJ0CaIrqnshD6a3L5FZc3n3QE/ruCHdsivIGLdbHNKO4TpF7DIbUuXMw74?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d119f6fb-f7f3-473e-abe5-08dc7f073a0f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:39.7134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqRdSzl8IV8TGzZwcYK3xdMX5wx4HuUq9Lt0f6WRndh/VyT4+FzPv/gp6LsCFDFPJx3622Oqc9tt5t5RYoP7CuEcz5NHPAB051kWc2C8yBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079
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

There is no longer any code in tree that calls a watchdog_reset()
function. The macro WATCHDOG_RESET, which used to emit a call to
watchdog_reset(), got removed two years ago.

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/powerpc/cpu/mpc83xx/cpu.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/cpu.c b/arch/powerpc/cpu/mpc83xx/cpu.c
index f6ffe295b8e..4ae26013272 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu.c
@@ -165,21 +165,6 @@ unsigned long get_tbclk(void)
 }
 #endif
 
-#if defined(CONFIG_WATCHDOG) && !defined(CONFIG_WDT)
-void watchdog_reset (void)
-{
-	int re_enable = disable_interrupts();
-
-	/* Reset the 83xx watchdog */
-	volatile immap_t *immr = (immap_t *) CONFIG_SYS_IMMR;
-	immr->wdt.swsrr = 0x556c;
-	immr->wdt.swsrr = 0xaa39;
-
-	if (re_enable)
-		enable_interrupts();
-}
-#endif
-
 /*
  * Initializes on-chip MMC controllers.
  * to override, implement board_mmc_init()
-- 
2.40.1.1.g1c60b9335d

