Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F51CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF96684825;
	Tue,  9 Jun 2026 09:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nw2O/5sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC85B84851; Tue,  9 Jun 2026 09:19:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616FD8484C
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r72n85YZUz1os80cDqtvvYVzRJjdMWL3CpecaawOZ8S/N7oMgMZ6XDU4+3bRYYy3zbPXBmHf057tx/zf8OOEMuCF3GoX/czGESE5SJ2evxfaPaZJ4Voo72u+yh9GTFSYF+HcWweEjCsE/9cUkG5IgxZJ03KLmSKH3iatJjaeZXpEfuC3rvYwKIvgMDILib2M9SFGmzSf+kkOf2tIpoOIWYN4Vj2cembVXla0E2w7/Co/m8oP1tba9iTHorYetrsxkJjeezpdc9iQNh6aYUp2yJgdt3ZxmkzJNnGfXT3o/KoWvIFs0XUjIRUrrJGFr72dZ1mO5HhqyGlNnY2UgLSAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrCxp2lrGnX9xs8mXwCzkpBKcyXerzYKxcaEO34TJjY=;
 b=Od9b8fhQd1ebBaFO8AfEVQDtuIbpgAKUIJIYNZURzxpotJqgKK0eJ7suWAtrd+Qvh/ps9vmrDti1ZmzKrlH2U7m4+3mAgIzfj3IOSRP9J0igMJs+1SoAvwd8A4MpdvCQ6zWxtZe1Ye8h1+WEyfzV0oLaW+LP9Rg3A0b12IDz7dsknwVbJ2RSieaM2G/sTDSg/t7BQMbZWbArHwVNpnlSmqxBnkivJfVev+lE+3sTE30vLKexbNi//ZyKNb1Rsyn289Fjx8mWaza1PEhUQpIaVEa5abA8xv0kZjJLHi9gyKKHMSBzUDjiUkeUgYIJST76Xmf2Qpd4a2On1p6x8H3GxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrCxp2lrGnX9xs8mXwCzkpBKcyXerzYKxcaEO34TJjY=;
 b=Nw2O/5szMrpPuFgumgDy9+x4K2+w0MAxxl9yBigoyBa5QbqWV/b7JA5/Y8OXmJV/E4gGOW7Tqkbl/kpp+K3NJUCnDMssEjw5YER0sVuBqmG4o5Uj6O0zhjCKdcGfK/XFMbb4DkcHdjtcQjVtqYSh3PRU96LOmiPa2J2QTyXuKE9EuA7YaryFjPrlVULciA2ctkJTcsgacJacdiunUYq1K9Hsj3TefOaHSW9ZrbLwQKrenCrJSuSlywUAgIL0Pqq82kzj1Iglnd7w8QFNhTN2z+VWeN36a7ePoTfrtN1BFLCeO90AnnO+CEwNp5L+Rpxuib7+cEmEvVVaG8gHMGbNhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB11546.eurprd04.prod.outlook.com (2603:10a6:800:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:25 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:23 +0800
Subject: [PATCH v2 06/13] imx: Guard print_cpuinfo with !CONFIG_IS_ENABLED(CPU)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-6-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB11546:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c03981-f915-4e51-598a-08dec5f76f9e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|6133799003|22082099003|18002099003|38350700014|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: faoyReJ8kmhhA+pMt/17q+i1zhKulEBPi0JlxWjbYzSrJXoR8tHVTyXNSyr6ew7NCEo99HoKa7BumdhVLmUH9kidF3gv65sO+2xk3mttMCnOp6azFnXNPI6Sdm/hI9vbzNBl/6bkl/+fDGxpwZcaRUcXbGcaEpA4RVZ+1Yn5D8Q52DEWPYAsGaIuwtAEf1G8I275yFaFhLHx4I6bejIEPYYA4KvlztG1ZLsKeO4hryAnPNUWolCg9bZuhBSAevJtip4jqo80CuJVgDHY/78O1cl66dgKBFqtC9Y2q0FtmD/XbTiZ6yCWJZTCe8gYTwL+osQHzghlOQxXRmLX9JuXxF6psGOTir8Xc+USQKhIcLjLj6rRGiOVG4UAL3pf5fQaqjg1JW+NkC1cqJ/gpzur0nMSh5fSXp9YKz6I992PLZ6dYrAa10xoT3Az8hEi7hlZF+NFH4B6+gOyZOhbQa57oJTXSsBLttiwU1dCg6u8ZLutCaX76S28Lgqa1tU9rXDcaILLpZKIvEB3i4NVRDb+hEX1G26e33H+N9Wn6CPg45ENkTHVupDsOgDXvNO9WLRxqxrBMO50Z+8lfKN2egGiQ/UuCfqBsfSp66wMoW3FjNzaFkgRYUewJSobksN/8MyKV6MCtXrExFL5tLHgo61zcrYkI6cL4KxvaOglj1xc2Aow9JdObO+oNBtDuIjx0b8rGooiiXky7ru9fpULhmqDgHU9oQ4rDS0kW8RqK2lMqqcPpRWKxP5Bi0GpAixNEHER
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(6133799003)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1ZNWnYrR0dhNG1NYU9UZE9ERWp6amdGUm9lWThBc0NCd1o4S0ptc2lGUkQv?=
 =?utf-8?B?R1ZleGs4RHpJZk4ySHp4dkZEV0lBeXl0a3hrSjdGSmd2QnBESDBEdlQxNlBN?=
 =?utf-8?B?MVdQMjFKaU43V0xMSlBYWUlIMXZIcXJjZkhFUUNmMTRmSVI2QU9Oc09aZXha?=
 =?utf-8?B?WEZ0OC9kb01tdWRzalRadDhnaW4vZU9BUkRYVGt0Y3BXblp2SVFiT3Z0TE1U?=
 =?utf-8?B?ZHdzbm5LN3RveUJaOFd3SnpicEQ4bHdheWlHN1l3eGp4T0dVamVBWUlIOUhF?=
 =?utf-8?B?ekpjWi9VYVkvS01iMzAvTG1tamx5TVNtQTF1Ny9EUnU4M0tuaHN3WVEzZ2RV?=
 =?utf-8?B?Rm5hUjAyVkJGWE9mVE55Y0hTckV4ZDY5NjJISnBpbFZmVGRLSnlGeGwxMmFp?=
 =?utf-8?B?NlQ4aXN5UHd5NE1RUlJ2bndwRk9Ea1pnQzY1MTQrdUJtZEkreXcyZHpramhO?=
 =?utf-8?B?SW5zMjB6V3I2d0FsWlh4UzgzdU1qenRqTXlZb1ZzYVpjaENjZlhROGxIZHBY?=
 =?utf-8?B?ZXVXT3E0NmdNcjVuYnpjbDJ0K2dIc3RLMVp1NWVEV1hRRk5GV01Md1RPS3Uv?=
 =?utf-8?B?U3dqUzA2Si9CZHh0Wk1rNUlGbkNTVlQ5Skpkb1g1UjdDOTdnaHBXUTd6N05h?=
 =?utf-8?B?c3RyNDlHRW9FTmo1a3E0MHZEc0tTaC92ZWpPdTNKUyt5SVlkblNiQkI0ZkUr?=
 =?utf-8?B?ODRQS3BJS1lvdlNTSm55d0c2REFrQ1lTa3FLMnFvRWowWmVjTm1CUXdMMWoy?=
 =?utf-8?B?eVRwVTJyaFVWVzRHSUEvQXVLQXY0N2ErM0I4Um02Ukw5QlFiUGtCbityUHRG?=
 =?utf-8?B?bW1oOGFmeUlyRXRGQUlydGNnYXl5K2k0SDByMjRseWRsUDMrNWZGRWtCcW4r?=
 =?utf-8?B?QVFUQmxmM2pxS1FObEI2YUo2eTlLWi84cktOWDVLbWFRdlVDQ0dIRElZZENt?=
 =?utf-8?B?TXJZaUZHcHBCQ2VzeFo0dWhTaUlvOVhXRm9ocFpzUUk0RnlnMEpuUGp3aitE?=
 =?utf-8?B?VnFWQU9MV21VSnpwcUNwdTVsQXA4N0xiRkZnNGxUVnpKYjlEb09tSm5jVEJM?=
 =?utf-8?B?MXU4NXpQM2ZINEJMelo3KzR3NWxNRUpOMGJ4Nzd0UUFlODUxeVlIeUF6d2V6?=
 =?utf-8?B?N25YdjBCdXNFdTBSVzBZc2MzalRlR1M2dlZBMEQvUFNBL3hMWjNGQzdLM3dS?=
 =?utf-8?B?Zi9rWitoY2JqaVU5d2ZucGZ5REJPWmU2TzBPbnl5bFhXZ285N1B6a0VORXFK?=
 =?utf-8?B?ZXhMRHhwLytaVmZuYTEwblpGYllLY1RCTnBic3VnajlqR29pZW0ySUJsekNH?=
 =?utf-8?B?eEhNZXNuUVFBUWdSK0Y2R0pLT0dYZHRpS3FZbm8rN0JDMS9YbTlzKy8rWWhY?=
 =?utf-8?B?N1RDU3BXV2xna3dhRWFyRFRZWklZOEdLM2lWN0JTTSt4QVRpbVF5M25xMHNh?=
 =?utf-8?B?U2tHOE40eXZjdXcyM2J5RFZFSTEvRXlvQWJhTW1jRDY4cUdDVzNFQWlWNGYw?=
 =?utf-8?B?Z1hGbm5VVjhxdkozd2U4UlZzQU0vMERlVHl5VklIT0FhMzczemo0YjFuWFBa?=
 =?utf-8?B?a0ZHR2tSTTM2cjVFR3ZmaUVDQTEvN2VMOEo2ajJHTDhjMDR5ME8yVHUxSld0?=
 =?utf-8?B?Yko1OG5aUDhkUzVqMTBxS01aM0JUd09MT1N3Nkw1cXFqV0VSbGczNW9SNkcw?=
 =?utf-8?B?ZVlFZG1LMkRXT01aVTlrdE1wSHlOZURRNEJyZXB5L3BEUjQzQURDWXJjOFF3?=
 =?utf-8?B?OGVwZzdiTGV6c004WCs5NVBXQlNzSTlCOUZPZTRJc1NqaWNid1luVzFxMXRh?=
 =?utf-8?B?TlJmNHZNbkhtV0o1SWVPQ2xiY2tYbkN0UWs3OUxRNXJJWitrMnU2YlJUQ1ZT?=
 =?utf-8?B?SW1uYzl2T2NDMUNGOXh3Y0ZxaERTZmU4UHFHWUtacmxTTHJ0RjE3THhoNkk1?=
 =?utf-8?B?UUszUGVUcFBZQ1FXYUpMQ2F0UWlkbExpME9NWFoxMExlMHlTYUJMVnpFdFFw?=
 =?utf-8?B?S0JZY0VOMFp3b3N2Ly9wVEtTaEJvZkhLL3Z3RWRxVW1aMHFKT05DbHlTVEZy?=
 =?utf-8?B?cWxranh3b1dWV3BxUUNJZjg5Z3lkS25JdWtCWXNqVlJUcnY3QUFlUS9QRnhS?=
 =?utf-8?B?YnowZ1czTnpLdWZreThtNlBnMngrR0M1VmFCRW9aczJ4ZzUzTi9pWWZaNHQr?=
 =?utf-8?B?UHlSVDM1MHcrbDJkUC9NY1pZMlgyakhoaldpUUUyNDl5ci9oajNuZGpvK3JQ?=
 =?utf-8?B?VWRnM284cGM4WUhFMHRySUtCUUNsNEYxYldsYkJlU1V1S2o5VzVhaWZzMWRz?=
 =?utf-8?B?RUZncjRuTXNOd20zRmpvSHpJV2tJdHZGK3I3QXlXVzhUWWFIWjYyZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c03981-f915-4e51-598a-08dec5f76f9e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:25.4409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 401hh3Lgpp6dKL4i6FPlWqKk5n6rAvlfhtqL76wplGE1LtrwChIL9CSG9dTJ1Nd9Pa7jlv5zXGSbd7TwY/S+5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11546
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

When CONFIG_CPU is enabled, print_cpuinfo is defined in common/board_f.c
with static property. However in imx cpu.c, print_cpuinfo is not a local
function, so guard it with !CONFIG_IS_ENABLED(CPU).

And all i.MX8M boards has CONFIG_CPU and CONFIG_CPU_IMX set, so remove the
dead code.

However legacy print_cpuinfo also print reset reason, to keep reset
reason printed as before, export get_reset_reason() and invoke it
at arch_misc_init().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/cpu.c       | 60 +------------------------------------------
 arch/arm/mach-imx/imx8m/soc.c | 30 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index c49ad44ac2d..93be5644c88 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -47,7 +47,7 @@ u32 get_imx_reset_cause(void)
 	return reset_cause;
 }
 
-#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD)
+#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(CPU)
 static char *get_reset_cause(void)
 {
 	switch (get_imx_reset_cause()) {
@@ -75,11 +75,6 @@ static char *get_reset_cause(void)
 		return "WDOG4";
 	case 0x00200:
 		return "TEMPSENSE";
-#elif defined(CONFIG_IMX8M)
-	case 0x00100:
-		return "WDOG2";
-	case 0x00200:
-		return "TEMPSENSE";
 #else
 	case 0x00100:
 		return "TEMPSENSE";
@@ -90,63 +85,10 @@ static char *get_reset_cause(void)
 		return "unknown reset";
 	}
 }
-#endif
-
-#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD)
 
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
-	case MXC_CPU_IMX8MP:
-		return "8MP[8]";	/* Quad-core version of the imx8mp */
-	case MXC_CPU_IMX8MPD2:
-		return "8MP Dual[2]";	/* Dual-core version of the imx8mp, low cost industrial & HMI */
-	case MXC_CPU_IMX8MPD:
-		return "8MP Dual[3]";	/* Dual-core version of the imx8mp */
-	case MXC_CPU_IMX8MPL:
-		return "8MP Lite[4]";	/* Quad-core Lite version of the imx8mp */
-	case MXC_CPU_IMX8MP5:
-		return "8MP[5]";	/* Quad-core version of the imx8mp, low cost industrial & HMI */
-	case MXC_CPU_IMX8MP6:
-		return "8MP[6]";	/* Quad-core version of the imx8mp, NPU fused */
-	case MXC_CPU_IMX8MPUL:
-		return "8MP UltraLite";	/* Quad-core UltraLite version of the imx8mp */
-	case MXC_CPU_IMX8MN:
-		return "8MNano Quad"; /* Quad-core version */
-	case MXC_CPU_IMX8MND:
-		return "8MNano Dual"; /* Dual-core version */
-	case MXC_CPU_IMX8MNS:
-		return "8MNano Solo"; /* Single-core version */
-	case MXC_CPU_IMX8MNL:
-		return "8MNano QuadLite"; /* Quad-core Lite version */
-	case MXC_CPU_IMX8MNDL:
-		return "8MNano DualLite"; /* Dual-core Lite version */
-	case MXC_CPU_IMX8MNSL:
-		return "8MNano SoloLite";/* Single-core Lite version of the imx8mn */
-	case MXC_CPU_IMX8MNUQ:
-		return "8MNano UltraLite Quad";/* Quad-core UltraLite version of the imx8mn */
-	case MXC_CPU_IMX8MNUD:
-		return "8MNano UltraLite Dual";/* Dual-core UltraLite version of the imx8mn */
-	case MXC_CPU_IMX8MNUS:
-		return "8MNano UltraLite Solo";/* Single-core UltraLite version of the imx8mn */
-	case MXC_CPU_IMX8MM:
-		return "8MMQ";	/* Quad-core version of the imx8mm */
-	case MXC_CPU_IMX8MML:
-		return "8MMQL";	/* Quad-core Lite version of the imx8mm */
-	case MXC_CPU_IMX8MMD:
-		return "8MMD";	/* Dual-core version of the imx8mm */
-	case MXC_CPU_IMX8MMDL:
-		return "8MMDL";	/* Dual-core Lite version of the imx8mm */
-	case MXC_CPU_IMX8MMS:
-		return "8MMS";	/* Single-core version of the imx8mm */
-	case MXC_CPU_IMX8MMSL:
-		return "8MMSL";	/* Single-core Lite version of the imx8mm */
-	case MXC_CPU_IMX8MQ:
-		return "8MQ";	/* Quad-core version of the imx8mq */
-	case MXC_CPU_IMX8MQL:
-		return "8MQLite";	/* Quad-core Lite version of the imx8mq */
-	case MXC_CPU_IMX8MD:
-		return "8MD";	/* Dual-core version of the imx8mq */
 	case MXC_CPU_MX7S:
 		return "7S";	/* Single-core version of the mx7 */
 	case MXC_CPU_MX7D:
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 498bbe6704f..75c8d502a35 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1480,6 +1480,33 @@ void reset_cpu(void)
 #endif
 
 #if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
+static char *get_reset_cause(void)
+{
+	switch (get_imx_reset_cause()) {
+	case 0x00001:
+	case 0x00011:
+		return "POR";
+	case 0x00004:
+		return "CSU";
+	case 0x00008:
+		return "IPP USER";
+	case 0x00010:
+		return "WDOG";
+	case 0x00020:
+		return "JTAG HIGH-Z";
+	case 0x00040:
+		return "JTAG SW";
+	case 0x00080:
+		return "WDOG3";
+	case 0x00100:
+		return "WDOG2";
+	case 0x00200:
+		return "TEMPSENSE";
+	default:
+		return "unknown reset";
+	}
+}
+
 int arch_misc_init(void)
 {
 	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
@@ -1491,6 +1518,9 @@ int arch_misc_init(void)
 			printf("Failed to initialize caam_jr: %d\n", ret);
 	}
 
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		printf("Reset cause: %s\n", get_reset_cause());
+
 	return 0;
 }
 #endif

-- 
2.51.0

