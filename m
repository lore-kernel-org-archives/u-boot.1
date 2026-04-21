Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07FAF327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D455984309;
	Tue, 21 Apr 2026 09:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OphC37wS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDE68436C; Tue, 21 Apr 2026 09:55:07 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5319284378
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekcFjXf1vWaOFmZSyVf3k0Ocvibcry9TQonQkZM6a5Zx0p76QnJjTFMY5DC+OKbDB0pmuW1+mTRbWObW7LOqxXi00rvKZQieIc3nfkx1DS+e5nEuolqalejx9nfIbwNYa1ObuTzAudcFhkb453D85SJqepIO2KPeIu5TxF0Cn56CqMYWL+6O+SBO/o3wMvyZ3BAL5gbZQmH+5+DhomFOFtWbvUvevXNZ3MgAg6doZHU8UmTKNAi8nC87+JnMhG5KXXeKgSpAzVG+VFFpOMhkj1So9utzQ2vg+PzOURvIz/Sg452DhVH1Sjo/ejz+MLeviBRQYc8Mt1nmte0n1VAw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trEjd34YEuV87QLT2Pu3QHXOj9josfyoo02S+8GpvXM=;
 b=JYzZKl/6ff4BP2nmjLzhCGNrihj925yHWJ75l+OUcKL9WTvLDccoLyT3wP25L74IGcwV6Cy2TJviLiwMawVIjRAY2X+p51WX8WQfDBNCjviMYa+aOGa47tDv48S8YNmqMnVHrX12OkD4t06rV363KOHIoPoGNbUIKJPrMZSyAkzogU0dhbvZfMihISdprQHoW1dGIG9r7YGbkBM3gR7O+oyH1UWotRccMXWY5WcHLpnNxSTbAm5XEpUJeyf81XdQr2BQU2ZU2vzBEyxZL5/JPJUQ3KDGFyqDeA6Dpj1JnOHit4b0qU44fnbho+UB0axayqc0QV//lvYyn6q8VyhOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trEjd34YEuV87QLT2Pu3QHXOj9josfyoo02S+8GpvXM=;
 b=OphC37wS1PmsAgB9RpmKQ+u6Kix7bRNsBaOE4K5Z4Pw5JMkNBsRoDEHIFgf8I0ra71dfUBQDanpe2TGkzHL0I1pDLxW5uu+WUtj8yNxz09oNOKG9Tcc7QzOpB7Hi25JyaDbCdURTCPFt7Mpk9vEYPrs2baNyZEHIGRPT/bv43FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:54:58 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:54:58 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 5/9] lib/string.c: implement strdup() and strndup() in
 terms of memdup_nul()
Date: Tue, 21 Apr 2026 09:54:35 +0200
Message-ID: <20260421075439.16696-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0005.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c5f356-8c46-4528-5b5d-08de9f7b4896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Tktb+3qW3b0ZXUp2JIwWhHvgUT17LSy/Bb2a2Vdw3lFGluaoU3j3SkDfabnN4gJdEVwr+/e1VyZp/0DWRySwDsEFLnWzm/zUPkKQV5ItRRSClgzVWERGp6x5hZFxQsCgu06SOndZ+iGTNuCMoA0TX9rlZFbExQ4d+75YOSYeXaEMQJdwua/FOeI28+pzKejWICo8ueYrCEuEZ0FpfZyRSw9lvK0H1sg7pL/K/MLCfdPyADC0xoJQhMK8/x0TUO+tb9IObGXnoatTsCKvUgFb+IpbOnHNSFWCgHXv8NBkN0U5lYMT4pxLOCm8ZafydaEG/oun42Ged//L2S+mILdjbPthmgvoCr69Wv3V4y9pnwFKGV3b7LE8zX6kBQzpJaZ/9diEYi+Z67Nebpuk2+mrcjspkiT/qjBHSZGtFtU0+JD2CmVQWlbC2rDVeYwDfDjkQHgrYVjp3CLK2FRH+FlhIBl/buTuzl+uz3qfoFtWDz2dNQ1vbKmA0YKjA3S8VyaxcghafxYP6Om7dtCPIb7U5yzUMWWxV0nP3KH8ftdIumaHg8/6f1URMFwvcwXoAtg5iWaDh/VdnkWIAayO4CBjxW3JcBGCXfRXrj4RunD7TwxmwRz2Nry2b8NwG9OpHNhwwrxmh2PqqGBMxOnjBF3sPuuWKxv719wHamh7c4Xol/n4otrRgd4OmXyFdoAHJBT3o/euQ3pu+CQlhCb7B9qCyNKoy2UnsTUk+tqGC19yG7Ciy0ysFCb30iKtZkg18Yn+V9MlWcjzc+7TXtBJYISUQyIxEoQ2oXz8PRjVQqifQGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3E2QRy/Ht66bxzbOhQWz7QdwH3iU0lNHEntrA2Wu5wyP+PScIiUy9N5px3l?=
 =?us-ascii?Q?wz0Ied/2AUuL4Fwme81UL5ehyD1F8xfNSKDVMS4L9zOdxhoWuGl5jMo5EJl5?=
 =?us-ascii?Q?84ELYJPaCOip5pxbosTIdj1GHDp3VhlgAUBmaL8BQcLYjlz2PbXBAwBh+bQU?=
 =?us-ascii?Q?wEFhvk/1ILRvicnxu6FGTFjzuLEmikxofV7jZBnUgIt3xO6OX8n4+CSVPO8Q?=
 =?us-ascii?Q?z5lCSDG4d1PnEFlMCyCT0sxk8MTYOIkS72HF10JRS/4CVqhHgri9I/UjoDV2?=
 =?us-ascii?Q?OUurs5ZaPyTq1IEKEOq/F0gQ0uuynodVTe9iyvKQB6to+RGdQnbdPibDEgv4?=
 =?us-ascii?Q?58JZKq6AUYAYrG/UsIwqh+UMT3mlzhRiTrxtxXkK/bPGz/vmTEMlposbwyfu?=
 =?us-ascii?Q?/SV10q8q3nmmpBvZKf8QJeOSqpiBQjdIomBOitAb+Z4YeA/57kI6iZS6XN/5?=
 =?us-ascii?Q?gQU9RKZeI/IllFsZZd03qJR5YW0a2cZiC/GrFi2iCY8Ucbt6xa7RlOA1KGdM?=
 =?us-ascii?Q?qkOJKFLtGp3NozHeYLtelnp+xSrZGhsAQsP0ydUC/2puKev+ffhwtUkqcbmD?=
 =?us-ascii?Q?OwWV1SdaX6mAglmGR3rVZBYib0m4trev7uj+tihjBbg6C6jXpVG2CTiMKIDZ?=
 =?us-ascii?Q?ZzJ5BHcWsol9lZ0uofWu+yGyI+O582qtMhtONunJvRmeTxrkU8ZM0OvGzhjs?=
 =?us-ascii?Q?w8QAxqLH2khUX+aks+ttNSZlaBgMbRwMWKbwvmEIqe2uwlm2VWaXP++1jjyP?=
 =?us-ascii?Q?dvoBhEFattSu7PQeez0uC0OgcJgf9btvRfeMRRfkwcM7iZ1rsX/odTgy8h5F?=
 =?us-ascii?Q?U7m07CSjMjS5hRizrCXeuaS5KLqxt5vBv53ew/oZZELgiRtiQGY6QyeEnvIu?=
 =?us-ascii?Q?Y5RmnPgBPE8MxWtLPiJ7WDjWF3Hnm35XkURDGykZJ5gjWo4dr4tLeSgIUP86?=
 =?us-ascii?Q?kJfrZ7Oez019hJXag3SLBRq9WzA8jzPv33eazpd+prR30dwcWpE2Aq2rmJsA?=
 =?us-ascii?Q?5cfOaN63LiLguFQ1d/x9QCQiXAbDFdHclUZJymXXkiTEUvVDZLh92i7tDBbE?=
 =?us-ascii?Q?owplB0UBrqCpQtzkNP4Rj7aCTdOAGwnLnE6lIy0bJ7Qz8kykSg9kN4P2K6ib?=
 =?us-ascii?Q?u3pqAL7H0iq+AOYP4pi6B5JkoYWL2pPDImlvblPmAghll8t1tClW3AglmsST?=
 =?us-ascii?Q?z2xBgnDvIzliJuK8tf9rjQXFIUgEzEembCbW5jlH2KsPe7FHhLsFPvusu58p?=
 =?us-ascii?Q?m4VfeMmvRPd4lEJ899oHQtPmz1zZC9hbnZVNJK1gGCR/yAh5XHSfgFIgJmlI?=
 =?us-ascii?Q?T/m53paVR3A9BKf4k/ANNGogt/jrpWfE7s3UqjyNEr1tshz83cxNKc/S0148?=
 =?us-ascii?Q?+V0AVf5vRCdXz4CFIP8McRjDZyH36O4t19cPZoUMCVUa8YQUhTkMHJpeJFx1?=
 =?us-ascii?Q?Xe8MgioFFJ+MRpHD4wPtKE+ve9N/s0bNpYCUtOBJ4PlMToNCq/pyEVl+8pgW?=
 =?us-ascii?Q?SU7U9UXZpnnu8qFZEA+d5FTgWIrJf/b7sw6Rl2zRRDOOXlzWeOs4amzI4K84?=
 =?us-ascii?Q?v4L+aHt58EebR11Uh2vojncFdEr0OY1B1nOvqhD88IAR0z0gqzWbutb+qh7q?=
 =?us-ascii?Q?HksdewM9lduA2HCaksMly7e79c+w61kt+RjRuPzo2nwZu7xsdGpFogSPnfZK?=
 =?us-ascii?Q?ZF2Yts9vtG7LLQGUdPHzONhVGhdbPyK2UaV9JIvoKu/GcaVmXYgY1tw0qJZo?=
 =?us-ascii?Q?BZ1myi8MI1qI4oMc4O68VTTTMRQbe50=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c5f356-8c46-4528-5b5d-08de9f7b4896
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:54:58.1721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9xesDsQJwgAARTdDKyrKrnoCqTERaG+NqZppEAeDPguYygIsfyQlusDvE0m1lORvUOjk3KgEu+176S3QX7vSYWC+VoKwVTJX4DpTc+bNvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233
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

With the addition of memdup_nul(), strdup() and strndup() can be
implemented as one-liners.

While not required by POSIX or C, do keep the behaviour of gracefully
accepting a NULL source and simply return NULL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/string.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 3923cce5561..5ccd1011ab5 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -360,38 +360,12 @@ void *memdup_nul(const void *src, size_t len)
 
 char * strdup(const char *s)
 {
-	char *new;
-
-	if ((s == NULL)	||
-	    ((new = malloc (strlen(s) + 1)) == NULL) ) {
-		return NULL;
-	}
-
-	strcpy (new, s);
-	return new;
+	return s ? memdup_nul(s, strlen(s)) : NULL;
 }
 
 char * strndup(const char *s, size_t n)
 {
-	size_t len;
-	char *new;
-
-	if (s == NULL)
-		return NULL;
-
-	len = strlen(s);
-
-	if (n < len)
-		len = n;
-
-	new = malloc(len + 1);
-	if (new == NULL)
-		return NULL;
-
-	strncpy(new, s, len);
-	new[len] = '\0';
-
-	return new;
+	return s ? memdup_nul(s, strnlen(s, n)) : NULL;
 }
 
 #ifndef __HAVE_ARCH_STRSPN
-- 
2.53.0

