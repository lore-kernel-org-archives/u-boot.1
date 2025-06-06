Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DB0C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7E8826AA;
	Sat,  7 Jun 2025 00:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0nVMCTUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6528482AE9; Sat,  7 Jun 2025 00:31:26 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786DA81F0D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5jYFN0womav/O3pib+KGHNv64Kkj6VMG6/k0ME3o1U31trMoQSJ3xGGZgYb14NX8P91PvSAS4wW8MIaQeTFe+yQkzbOSyq1sjh6FBZpJfylrKH2hAoZ3O9s4LmSL5jynTPXYebQ0k4rDplzOzhk2iB7m5lm5EBb0HJeEuPgggBVLgPdeVtyHibvSUMYiiA9DZyI9/WoxP/XnJHJgQ03R7Hq3++r5qPb7GGAmo3J3lD/xBqUqDxF0XuFJAgCEknRpYJqS/gphPCUIo697nbU9U9+G9O1CDAzj+H2QXvdZP5qoX3IwCqVbUCHyzDomrpifbXDFQ+6rcSJOtG8VxdToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFVHVZ9I2d+VRf/6uD0KlH8+S9LrQyosD2MHpw8zsDs=;
 b=JwBrFPZ4db3hBl79r2SVrG8voQkfsYUf9gjJlblpYg9E7i2yU/jR/l7LhRhJyaDND1ctywqqzUKm/4YQq4jqkpK/nW9tx/pt8uOOd5kieJePuGEYzbuouq12GM7oDMTas+hmVv6Ko5PZmdamrqCMfzirHJ9UuVW17HsbEX3XtkNgZitW48ReLAFGhVkz0tWxjaZQSYvf5ffyFgNv2hu+WVAISp4NgugeIS7axp9VnhVlnRleYn00+m8InnW2IbrFneyBsnF2SV4AfkCdSPwF/p/imSaml27FjgKKv6yBFIxAOrtX8sht3L5GMoo/Kv9CZThnMD1FF8ymzNpmbUsSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFVHVZ9I2d+VRf/6uD0KlH8+S9LrQyosD2MHpw8zsDs=;
 b=0nVMCTUONh6wDINv0LK8PTB2yJTMdK7bGlXbUOqNKCPepdS4lAPdsXs4/VaTNYZEwIB3xcN/T04RHQag+1CBGPKNV+fkOfuWjzh+biDPzm8D6mXYyoLhmAjNLT4VIS/brBRxlfgsxOPu1qhwFRXoOzpzfA2OojYj1xTErdgyLqj2SzGFOzBbVScVTIuBEtUMKez2x2HZ/5LwPehayx36N6s/FlfaD8BlHhyfxfVStYo6QmRN9gzIfSMYTkg3b3z3lH0Xkci2x3EWzOyL2OSwNYXC0xdwtMi5zEgZfr3fUVjsKazUrXfJ+W7ch1Llg3/bu9n78d5XlZtRuW5zTepedw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB10377.eurprd08.prod.outlook.com (2603:10a6:10:3db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 22:31:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 22:31:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/3] common/spl: fix potential out of buffer access in
 spl_fit_get_image_name function
Date: Sat,  7 Jun 2025 01:31:07 +0300
Message-ID: <20250606223109.502055-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB10377:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6e61b3-ed0f-47b2-d3fa-08dda549daf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/7JrXbTM7QNATmMGDI+qSgBOXrZ1hJyWOBsW2C49aYKX8Wmcb6CoTNDTrdbM?=
 =?us-ascii?Q?u0QReugbiUVmMQRoz+5ssJRB/+i2n/5FpD0s4useEslXL2G15sKG3ZAZ5+Mn?=
 =?us-ascii?Q?r9XJw/ZSsWbX3RHLiGi6stUSua/jXiknyCgc05UEYKz7MrfxD1rbCyU//vBJ?=
 =?us-ascii?Q?KRPvYYfSLGDzMDEFKFkmz8OrE+pf4/UmWJDjD3kJPbQjZgzO6KsH+FBKH7Rk?=
 =?us-ascii?Q?pEaIstkjvDtLO02Kie3839KjTouvtmvqIPAdgnI7ujh7Fs1hsY16bmYh0sZ4?=
 =?us-ascii?Q?bOC6j8TpBD5vRgJLc4YOMev7xb2k9OiImuDgxigItjujea0Ig2jZ3nlCojph?=
 =?us-ascii?Q?K9kSM6rUxNoQ3ybIPRk+GcrOoT8kePJz1+pvMQpDsXNz7iEm0Tnks77jlVpk?=
 =?us-ascii?Q?GHGPZPJeSV6xC3Py2mgg3yF/7vU/9eijuUuA0O6JuGPmqaIu6qYnaU2x7svY?=
 =?us-ascii?Q?vfhypWUYPLB1ASBu7FcK2rj5X9jG0kJ4fZib/Th7EQGM5R0jj6tMNmsw2lvF?=
 =?us-ascii?Q?sIuD88aHEFijZC/e+NNDseGyr80KDrApd27gs+k0Rrwl1DkXvX7llbHasP7/?=
 =?us-ascii?Q?/mchU98pTSI7vIngQ1Zj8aM+3W7QAZyzyOZ9O6AGBemg3kQENB79l0ciHJAf?=
 =?us-ascii?Q?bka0+F57+b039beTkSYsvgj8ezRV5Cqi/uLjZN5e/zGCniv2rqcweRXQ47VE?=
 =?us-ascii?Q?MT19PQ7a1IiKwtAVJn8OJdlG5l5m7W7zeUZq7yKyiJZ/h6I+/tlDnpkqkMx9?=
 =?us-ascii?Q?PBQbDBExkZQ7S6vdcBFLAN6mAKHPEZqTNERW9bdZjiNjNxmzddf7rpc9jE2M?=
 =?us-ascii?Q?0xuRa4s7EMWYDNv0XD1tRWUBtdemoIK58XpN+YZ6aAEvFBG+xpqtQtKBUsjp?=
 =?us-ascii?Q?p4FO7MMr2L/tbXtiFHltA9kQPWVZEqo/UJZ8GNboiQgvTgJIUDstYH4uBVOB?=
 =?us-ascii?Q?ciRLwL8YGxTD+f81VUMNXxW1YGzBLBwJOibB3PP5v3y3BXaBDI1jKuirINQB?=
 =?us-ascii?Q?frlvzSMWynJxIV9vrj0zHZsmfNgX93llR2wNAbNmf5uLpGwQgQsxNYK46GhV?=
 =?us-ascii?Q?npe98JA3viyBoKKY1gYd2XWzcXWZ1oVI9mnOBg+dZJ5vO5A6edPgmFy5wBRl?=
 =?us-ascii?Q?xnp6Ii9C0Br2j1aazFYiuvJ5nmKv8cH22X1eXyAzPKddCJ/Mij787HI+iEmS?=
 =?us-ascii?Q?zMrtNC+HKoADWC5uXAkAzzQ3WUg1o49vC623sGebeJpWxXLd5snu8R//swB1?=
 =?us-ascii?Q?nVRYJZNhIByd3kNeLW4zwY43dYp0xLZ971Zv9vyX6XFNYi+oMwlbliEnU5hv?=
 =?us-ascii?Q?SlZRfdJT901Wk8wpgpAeQLh6jgc7fioL4yw1B8kzKAoWmqq26qRFo4esHyJV?=
 =?us-ascii?Q?qv5q7SLqIoNud4f1FFCpLZGr4emS3Y3TeQuxRAQf4rBAt2SITYm16wgg0yJY?=
 =?us-ascii?Q?YBmKTZ5wqvD2wt/PopLg6fHbiiXPWmWxpngNkZjOgYGh+3cPBBvWjg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PE3DOXDm3fH/U1OnYgtu1tH9iz1oY1WH015Av9UIBR6eIzFNnhCMGW83NFxW?=
 =?us-ascii?Q?g/MdWetnCvuZQEa+JK/B4/alyZCV+h7zivUr12NoPS53GBxdA2c4qwzx+unp?=
 =?us-ascii?Q?ebWOK48wWT10baE3db2clDbqGYM59pQeun4Hft1GuPQI+yiWYoe0aiNGbbZ7?=
 =?us-ascii?Q?tuPeDsctc/57yvVxi6ZtJDFcqjn91eTGW5x98TGzcTY4wLKVrB0RIfzLE0MK?=
 =?us-ascii?Q?b6yk1EjzPgcxs34yg4DZ5QXzlPU1Ux1EdRBuQYaH5e7dlI9M8jWV6fqHo8aD?=
 =?us-ascii?Q?RrBEkcFQlsySXmEcSmstHCNvKYopBcQ+RcHGZPitXoCqyA40R3nfD9BmvqMn?=
 =?us-ascii?Q?F0nf+4dwk6o9UDkimFckzgS3s06LX4p+sAcahgYNsuHvXhgZxMYOY/7WXBkw?=
 =?us-ascii?Q?/O31+xudVUHG0zJ7tile6Ay2CmN5atj8Y9ZCgIy5+6VQAxPVQsqf0yktsoks?=
 =?us-ascii?Q?c7sBOuu1CaDaLBOOF/DnpueDlkecGefPVfylWWpajqKpUwJw00ULm30zaoq4?=
 =?us-ascii?Q?VZ0G2UXvGlrE6CEwKidAJ3AA3xZhnsKqKRhjpZXBCcKDI8hr5fJjvEIuK+Pj?=
 =?us-ascii?Q?7x+k4jN0L2V39I7XzzrYp84dI063JOstJNiKXCW+lKRRMXqGR04yPx7CuU6/?=
 =?us-ascii?Q?H8HIOZVq6N/+Cpg5unwIW/rVAqSbWj4TUr4zlUoejkxBa4Rn5pLNrQLyXyVE?=
 =?us-ascii?Q?VTJUhlnuX+LaUVboBxVdKmHo7MdR09+o3UT5h9/ZLdCOtmkegv0SKVHzb5tH?=
 =?us-ascii?Q?YTwrc9cLjoo0MS/gah6JUBAFQzro96lwUZROpjxSmUnwRAUD67D7H/MBMbxf?=
 =?us-ascii?Q?SGLRdlICibInUQgrhXx/4Qom10KN404kI0XZn5ZcDeZaBIEswZVfa0ZCYjps?=
 =?us-ascii?Q?bYA7yaIQb9GL0lNLmmOt2bzTcNy4RJtSgqq1jgp6wCwdekpwGl8FJdSZ8qZr?=
 =?us-ascii?Q?W5swTqzCYtD67pYWefGrUFrR/gmv0HrG50RsaZVtTM8UV//IUbfS4ItleDTe?=
 =?us-ascii?Q?hlub6pIPR7rKQLXHLYEgJ4ZhphMmlDr1a5bYfBFi2uF8w6RvybKGflrVu+Gn?=
 =?us-ascii?Q?nnknms26/qKmJAKzU4G85ZrAHyBwNp2btgSJwDd00I8MgD8440hVeDrNTrUl?=
 =?us-ascii?Q?iUgJzUxjv90RT7gd630m4NSkTozSf7XtNzZyh7Z7I/l3QGi3kQtQCS9qTpI+?=
 =?us-ascii?Q?POVJmzVeaD+FSEsMcEz/pmVMYvuoIe7EnllruxNVxYD5yWW/EqBHT/v5XW9U?=
 =?us-ascii?Q?YDyo5LNU9z+1x75OS3utQ8BMUGHs9gkzGblK532MLdKkwZjwDKqbXtDKkG6C?=
 =?us-ascii?Q?dzOgWmToIl5/ywG6SiNshcZSsBbSQMVbnWHXLlgHllcmheO+N7kTOn7vIIPS?=
 =?us-ascii?Q?P8zXLqKcOXigt5eVY5S9EhGAMOoiTe/6T/JwPrq/pJAcSFmnXNk753RYDybH?=
 =?us-ascii?Q?5YXRhXdbscBbLLqBEvNLCJ2SWwwtdFqg3eeSAiM9ufSn1XoYmDHWJwacSy8K?=
 =?us-ascii?Q?tBi2NWBQnAYYMgssmF+l6AlM5+x5xMYFt+fOkE/lDHwC2RAPSPM0lAwNcitN?=
 =?us-ascii?Q?hEk/j9crhSjkvwZOiW7L8w0EnFWYxoeYFMfPrtq4ES3/jdaa7+2nmuBcyG8A?=
 =?us-ascii?Q?G5t+mgXYm0TLForQ64CAELo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6e61b3-ed0f-47b2-d3fa-08dda549daf8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 22:31:18.3721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e+/EgcvlTCrg77CnkP/CJYCoBYwYJE63sWvCCPp6PMGQw8epNHRH9nX83VZi5q0UPel1Ob/DyWiTuG1cJQL1AdwPW8zIqqnHkbX4liLWHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10377
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

The current code have two issues:
1) ineffective NULL pointer check

	str = strchr(str, '\0') + 1
	if (!str || ...

   The str here will never be NULL (because we add 1 to result of strchr())

2) strchr() may go out of the buffer for the special forms of name variable.
   It's better use memchr() function here.

   According to the code the property is a sequence of C-string like
   shown below:

     'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!', '\0'

   index is the string number we are interested, so

     index = 0   =>  "hello",
     index = 1   =>  "world",
     index = 2   =>  "!"

   The issue will arrise if last string for some reason have no terminating
   '\0' character. This can happen for damaged or specially crafted dtb.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 86506d6905c..ab277bb2baa 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 
 	str = name;
 	for (i = 0; i < index; i++) {
-		str = strchr(str, '\0') + 1;
-		if (!str || (str - name >= len)) {
+		str = memchr(str, '\0', name + len - str);
+		if (!str) {
 			found = false;
 			break;
 		}
+		str++;
 	}
 
 	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {
-- 
2.47.2

