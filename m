Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F4BCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 08:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4F58323A;
	Thu, 23 Oct 2025 10:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ROepkh74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F78832BC; Thu, 23 Oct 2025 10:48:23 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6408006D
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 10:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKtyrhFcxFNhmGwGFXaxhebmnOpGEseBe5V0+HKi21WTqrHTAUswdMvDx9tmRM0V77xNnku+tns7d9uy15hUaHQqPLdCnZue759VBqF7eUSYCRXyhHDFDWVofoOSlebVtM/g3V/fD/K1M13BrjAomXe1XrLjaN5faf2XC0g8IgzWW2TeK68UXyk73TFqVE5gZdCVUWnLRT05cyuwnXMbhHH0EkQfhf1IyPpn1NJA4q5jGUp+4wxjKi6hzlv9ab/3bDw7pgUEIGg0q0oUwPHaGP46tDqvNJQFAsdOKiPBJlbtT5LdZoA3ahkEcRVD+aDPrBDQOYwjENv5+/ykvpl//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKb6/TJ5MsMKG6Qrgfql6U8DXw36QqrT9yWcC6VXYHg=;
 b=mSKUJUhB3Irr/WYUpst48ciTg/LujIYUWIOn2qD6QJ0mqgAMSsQyLIYvikk9H8NRwpc2OwcR2i+sO9+EQ2+9YUAalkAddPzq1wbW337oR2ozM4t57XvCDRfynNpAgMWSc1aNOY/plzTuucOd572NBYpv5JF00Nm2agkWYta+QSkLD3UIk1O1DLQDLssbJcq8IE4SH7Sfg0aj/NxkVHtHo8xfVU3F+Hbh5KAZs410iUIgsWq0bB25aX27a2ft7yS5/fRvSLR0wR4Yu79uDklVO+qg9DKBo+ePuWaMEN8aeLGDuNwgtg5ie3Zh0X9obuZxWYR4I1yKrFvQY1PD+sN/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKb6/TJ5MsMKG6Qrgfql6U8DXw36QqrT9yWcC6VXYHg=;
 b=ROepkh74tYdhGe/4+kz+Wn+J7qwpcAtKkax569sPsW0/Tb2aaZZ6gkKY9PFtuyIj0jafFAcxbcCDlE8EkpwaFZddzjvfpWpFas8VXxbwNMQ4qssarsJmw0bBpTidZPcHriizjd7Io7mg/PFNSj52Avkn5QFptctYr7GJk5peEUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAWPR10MB7271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 23 Oct
 2025 08:48:18 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:48:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] liebherr: btt: shrink spl_board_init
Date: Thu, 23 Oct 2025 10:47:59 +0200
Message-ID: <20251023084759.2113493-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::30) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAWPR10MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: a89049cb-0db0-456d-994f-08de1210e9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C96iDy0avdzp7VlhcoPQb/HQUqMMy/Mj5oDCIuDhbag8VrngKNrXXzM4sEjX?=
 =?us-ascii?Q?lAIco5dtcWzatdprlz9Qd0VQDnRzjiVeMnvL2PuMEcEcSu5ELWW+T9VlJMkg?=
 =?us-ascii?Q?L1xjB9BtHkeTsQXpHr8i9yKO4PWmtCN+X1neq3L7wWiWJv8uK85MIULV/ytZ?=
 =?us-ascii?Q?joNaR5r6F+5wNN0O28otTeQp8pevvkPDlEfsUfCLchBn+nsb7cAo4w4K1GiY?=
 =?us-ascii?Q?hAJJtp4GYDTqHcK9XpsoSSmAoW5imUauIekNzDDTN1swxCU8Tg6IklUIzh9B?=
 =?us-ascii?Q?fuIDmyXAqr7Vp+5UTwMMA+wdB7HTeKNQC/G4ByyuMl0Mt/S8SCKlCCbBqasB?=
 =?us-ascii?Q?KpyRvCDuFTh97VJAAg8lPnrwkaefuO+yImkejhTVYgP8nwpa66v1ptTl2q78?=
 =?us-ascii?Q?2VT0lfEQzgZ2IunA02voMa41mPXOAiIws92o50Xvq7FMDd/0peKo0opqL0q3?=
 =?us-ascii?Q?llYWe2qbUR+o1Iv6PdGlA3DqdTPQuViNYLrEDPoyxvSjIYS1X/oedfuC8fDc?=
 =?us-ascii?Q?X9sYnvoS/ne7V9XgARoLPjC6GPF1QjSAYD3UoWQuiJs7aAjexFNYQhXGSlqE?=
 =?us-ascii?Q?K9U2nDpxGhiCcvyM2akZ++ZTNxXrCZyXKWn7WRYKmDoZ9P5lceWLxiHuQ9GO?=
 =?us-ascii?Q?o6atrrLTJdce4u48hCvspwZ3M0x0W4s7mrn0njj5+e4hqmZynsyvFcqbuQix?=
 =?us-ascii?Q?n5hgsKiap5nvPHkfDu7dhsTyNDOFHAY4mG4SfKgsVpnXIZV1863jx5TjnBHq?=
 =?us-ascii?Q?VD2ErmBb5kxCqjfCnquagoZEm0G7WJNz49/sFEw65rintSzGvU5YJmSkRJZp?=
 =?us-ascii?Q?NeQVeWE3zPzwMteZ7EhtKSQvCUzF+i6eDRjHYHu1BtG14QZSPZhxIDyzUcXN?=
 =?us-ascii?Q?4BAnFN3rKs+7clwYkQyoOFWUkQMgcgfWgNrt/Bg/Tzr3C0Rs7VH0r3OqqI3m?=
 =?us-ascii?Q?m3emvcajk5I6w+eJJA3vNQRHVxwpOvSJah5KPVFcfEjehPwvoWi7Zmf0ga66?=
 =?us-ascii?Q?O2nq+5+1HwBD8r/MR54SofRygXICiNMcjd8g+KHba1+nwYCyxUvC2HDop5gO?=
 =?us-ascii?Q?E4+LbnttvHDQjGBinXeaM7nsyBhmNoQ0ZTmj/myyRML/Ul0e3vy57pi6OPAC?=
 =?us-ascii?Q?MXf0KIPKuECppXPVcS9D4AArXFONSd/6qKaM9NsYlRk8NXhoGruPgHXb1BTE?=
 =?us-ascii?Q?2wprUhFHVPUdG+sUhH7X6UVLK1bIHfvvHX2iYBTp4BgpjG3Rt3oq1vM62Yzc?=
 =?us-ascii?Q?gdrpBjaBzH2U5BnrJaVjm2zhWrr8Jp4Fqsdd0uCcnGS3bij3cGP9CIpJcN4W?=
 =?us-ascii?Q?emm9TP+VYv3g9Xy0V50sYe6xx5f0hgREIOANA3rIfHj/LaYWh2/fYzU/sp8f?=
 =?us-ascii?Q?CH0VxibnbbSDeRez9EFLRVoPERrn5d0NRbZRWis5wMsRzppADUyrnN5hsz5h?=
 =?us-ascii?Q?lbdPflVOel1QUB/VpE+Lt/G+zKkLOO1d4Y3I1vtiMwPY/ubYEzgr2OIKJjfi?=
 =?us-ascii?Q?Omlt5YPRgre/TMmXp0wpZzYUT0FMIOPhy6T/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ps7EmND6LM6u+BtE411TigCs0uS7tIIEDOlnFsIZebwRckDS12Euyp/hH8+f?=
 =?us-ascii?Q?LYPO0GjtrN2ytMsqBpd5HokN5KeQ329dqkGVfL6pDfRgh2losxaMT7uBBe4p?=
 =?us-ascii?Q?hYb27SnH7EVwVldAkLoMaVX03jnUpNOv041YWRz5Vo9dqaD+crZlLYOUM6J5?=
 =?us-ascii?Q?OlCe0v6f8KFobYtwuWEGN3zeL8VQvLALe5p9itW9FGKxOCCXY2o2tOCaG6B2?=
 =?us-ascii?Q?OWCnj47z3Hg/vdt1zx1wEiH2uBcdm++i5UNS9VhSAUK6pmwsQu0Sfia+NbPX?=
 =?us-ascii?Q?sZmSWyZJTQZuaYJG/lYLzGg5SIXeiD1N0BEmQ68kFGqRdkOgQpILB+x3EduV?=
 =?us-ascii?Q?jU/gS+mIdTf4yEeu48N33Yn5tIEAEPGccYKfggJmM/ExpXtKg4MRcIee30M7?=
 =?us-ascii?Q?5GaVZ2rWWiSW8mQEdMJpu3lt9TS4g8k5aWVaQm03xi9stveJ3AQBVecipAjh?=
 =?us-ascii?Q?kCCfo4XpvmmfNtqwME1LmdB/J1GeLsEr5YazY1ULljDv3TdarM6jAMzUANaw?=
 =?us-ascii?Q?MqcCneL4WLy1IRc1x253R0tCjyZNFPcSwAlJbn1GN+0Q+M1hXc7HMVt2mcz/?=
 =?us-ascii?Q?OyC6niCNIV5YiyvFrjUxwMSgyTLPbJsMO1u2oXx8ahlfacC945In93OXhiMK?=
 =?us-ascii?Q?+vY1r9VjFPONlgOHH8jHkH7FnwtJI2bI20tRCVSPy73Tva3SkBTT+HMwkUxQ?=
 =?us-ascii?Q?xuSSM6zygMw0FIoBRhqGh0qVpJDoiqXW25r1yUlDHlcqLbjIWhXHFOFaO81w?=
 =?us-ascii?Q?ZYF2WClxs/yNZFxYRVUP/41h/tMhZ/YuTlb9rcOh/oWbpw7W9Uf4IEYRgl7w?=
 =?us-ascii?Q?td+2pLuTqedOUevqv68V94a4cv+iBwqve7MzR0AnDULbxCqX9FcLsIJKRFMQ?=
 =?us-ascii?Q?NJEbQ33S2GWOJEMW+fLD9uF71WOdJzWTKPrRAiO4ha5Nok6jjgoE6/b11o5M?=
 =?us-ascii?Q?EmMYrKL88yhGZT5QzaiWRw9Qb8aHtTFGUS/JH8Z4mbUhzDGGGhJE3TMA0eIU?=
 =?us-ascii?Q?EIJ38Vb7/vlhK3k73y6qe9+bq3q8PSSXjknSCoRvUS9wQZEq6Nh6WFbImaAt?=
 =?us-ascii?Q?HQuWw8ryHU8a6CfjZs7DREJW7WQXpv7BfliU/ptKgWEW5njtN5DSh7h8z9Nw?=
 =?us-ascii?Q?lzbyTARbugoeiriVT/OMoP+E7O6B2Qkkk8ttfv3L2n+BtG4ORANUETM4Pdg7?=
 =?us-ascii?Q?Fr8Rw5zObooy9bJH+Mp+SAOYg1sEMpQMPL4JCLCDwh0epJBRTQAm2/lW1neK?=
 =?us-ascii?Q?yx4h183kvulyZKmdxF2iM4Obxzb+iaAbupL+xLxdqFdLcu/1SFvvcRmR3NX0?=
 =?us-ascii?Q?d3WSXAD2PDizdeKUuZxd0de806WGTaMtemb5wTJ1muBiovhOpSVL0nA8OlQT?=
 =?us-ascii?Q?rKA8l/zxZO5mL1NVW4MmB9gA0iRxEGyhwdseNETO1dgmAoH3NLzopnaX4yu/?=
 =?us-ascii?Q?Ejl/pqRUKEs2q5iV8FcHJ+QH8RBV2cprytDvxt+TBFVE1lM2tYforZsvNnft?=
 =?us-ascii?Q?+nA6evxpcwB0z9Vhus6SusplqyUGUUvl/T+hgIfeiXdyyyF1u2H2TU+yTPCt?=
 =?us-ascii?Q?biITghQuzZSO1THjcE3++rQOzGHxv7DB0oRCdX97RIHLroiTYjSknviacz8v?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a89049cb-0db0-456d-994f-08de1210e9a9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:48:18.4280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77EJIz13dx1OQp9v9ZCriPuva5dgIZyFp3/Bc4WOVZuBtLlYxn7rW5cmPzF4Hvm+MsPk4FvPyFw3421KVe9/1yWR0eGmRdBznJwBDXsJ+Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7271
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

This board is very tight on space in SPL; in fact with my compiler it
ends up just exactly on the wrong side:

spl/u-boot-spl.bin exceeds file size limit:
  limit:  0xa000 bytes
  actual: 0xa014 bytes
  excess: 0x14 bytes

The repeated "lookup and request" pattern in spl_board_init() suggests
a low-hanging fruit for reducing the code size. This reduces the
object size of spl/board/liebherr/btt/btt.o by 300 bytes.

I've left the lack of error handling as-is; there isn't really
anything to do if it fails, so I suppose the printfs are the best that
can be done.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
Compile-tested only. Stumbled on this while investigating why another patch failed CI.

 board/liebherr/btt/btt.c | 60 +++++++++++++---------------------------
 1 file changed, 19 insertions(+), 41 deletions(-)

diff --git a/board/liebherr/btt/btt.c b/board/liebherr/btt/btt.c
index e05e333ac7e..c4b6c37e495 100644
--- a/board/liebherr/btt/btt.c
+++ b/board/liebherr/btt/btt.c
@@ -110,10 +110,23 @@ static int spi_load_boot_info(void)
 #define BTT_MONITORING_DEVICE_TIMEOUT 100
 static int rescue_val;
 
+static void lookup_and_request(struct gpio_desc *desc, const char *name, const char *label)
+{
+	int ret;
+
+	ret = dm_gpio_lookup_name(name, desc);
+	if (ret)
+		printf("Cannot get %s\n", name);
+
+	ret = dm_gpio_request(desc, label);
+	if (ret)
+		printf("Cannot request %s\n", name);
+}
+
 void spl_board_init(void)
 {
 	struct gpio_desc phy_rst, boot, rescue, wifi_en, bt_en;
-	int ret, i;
+	int i;
 
 	/*
 	 * On the new HW version of BTTC/3 (with LAN8720ai PHY) the !RST pin
@@ -125,14 +138,7 @@ void spl_board_init(void)
 	 * to set the RESET pin to HIGH after 100us, so there was no need to
 	 * set it explicitly.
 	 */
-	ret = dm_gpio_lookup_name("GPIO4_12", &phy_rst);
-	if (ret)
-		printf("Cannot get GPIO4_12\n");
-
-	ret = dm_gpio_request(&phy_rst, "phy-rst");
-	if (ret)
-		printf("Cannot request GPIO4_12\n");
-
+	lookup_and_request(&phy_rst, "GPIO4_12", "phy-rst");
 	dm_gpio_set_dir_flags(&phy_rst, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
 
 	/*
@@ -140,14 +146,7 @@ void spl_board_init(void)
 	 * it is directly connected to Jody module without any externa pull up
 	 * down register.
 	 */
-	ret = dm_gpio_lookup_name("GPIO0_27", &wifi_en);
-	if (ret)
-		printf("Cannot get GPIO0_27\n");
-
-	ret = dm_gpio_request(&wifi_en, "wifi-en");
-	if (ret)
-		printf("Cannot request GPIO0_27\n");
-
+	lookup_and_request(&wifi_en, "GPIO0_27", "wifi-en");
 	dm_gpio_set_dir_flags(&wifi_en, GPIOD_IS_OUT | GPIOD_ACTIVE_LOW |
 			      GPIOD_IS_OUT_ACTIVE);
 
@@ -157,36 +156,15 @@ void spl_board_init(void)
 	 * time this pin is set to HIGH). However, the manual recommends setting
 	 * it high from LOW state.
 	 */
-	ret = dm_gpio_lookup_name("GPIO3_27", &bt_en);
-	if (ret)
-		printf("Cannot get GPIO3_27\n");
-
-	ret = dm_gpio_request(&bt_en, "bt-en");
-	if (ret)
-		printf("Cannot request GPIO3_27\n");
-
+	lookup_and_request(&bt_en, "GPIO3_27", "bt-en");
 	dm_gpio_set_dir_flags(&bt_en, GPIOD_IS_OUT | GPIOD_ACTIVE_LOW |
 			      GPIOD_IS_OUT_ACTIVE);
 
 	/* 'boot' and 'rescue' pins */
-	ret = dm_gpio_lookup_name("GPIO4_9", &boot);
-	if (ret)
-		printf("Cannot get GPIO4_9\n");
-
-	ret = dm_gpio_request(&boot, "boot");
-	if (ret)
-		printf("Cannot request GPIO4_9\n");
-
+	lookup_and_request(&boot, "GPIO4_9", "boot");
 	dm_gpio_set_dir_flags(&boot, GPIOD_IS_IN);
 
-	ret = dm_gpio_lookup_name("GPIO4_11", &rescue);
-	if (ret)
-		printf("Cannot get GPIO4_11\n");
-
-	ret = dm_gpio_request(&rescue, "rescue");
-	if (ret)
-		printf("Cannot request GPIO4_11\n");
-
+	lookup_and_request(&rescue, "GPIO4_11", "rescue");
 	dm_gpio_set_dir_flags(&rescue, GPIOD_IS_IN);
 
 	/* Wait for ready signal from system "monitoring" device */
-- 
2.51.0

