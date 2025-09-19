Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCADCCAC5A9
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77300833E9;
	Fri, 19 Sep 2025 12:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bgIQ1747";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7EE583321; Fri, 19 Sep 2025 12:10:20 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4244833E9
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqwFprfui+4A9bmOlie8kbxbrG7mzOXkR4x4aiJRTLiHyJ9w+Clq3ZBGI7wI1IbhD6TjpQ2lC2YcDVg3+v+OPR9hOeyXJNhamU5y83d6OGSp7sjMBz5caDRnbxMVFgH30uDBj4wMOIX2Ivr6dE7tMi/ycWfb1B797t7RF4ioWtRdugf5MSSPt4RZFdkK1JlNuL1XcH6PJYdDnD5GQ9pMcHdJidlCKMudfbIwC593uoX1SohRIMiLT94ge9XVOC2MadzoE88hp29kVzIrQQu4oybrXN1poZBnPgKrraLRFmN/XDEVBQdbeHE/SwgUQvxig11kBFvm2yDvjwID4wQMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4FZkoZ25xkn8imY2Xe3ES7cWwstD+O1hryd7NTONzY=;
 b=kQVQcngrOp5zMD1728YssCp1rOF3hRJdnE4AS/mdWFKQwq7kL76+7mEq2sFZDpqmNPVCqlIEpX0/VVuUC3N/W3wG2ZpIStbW5InxcMjID3CoURHKoiL/NZ8MCuRt7dOizd48zB7iEB8c421qJFZ2W8kw719KfHAcX2pCcOTUtviy4d6UIgHq+7WgNvGMxB82hT9Y/SrWePRiW9cfSLSVkmjx9Ya75B2966ALlXyRA4PzRD0/eyoPQ0gB1i64LnVGMFdi6eZ7m6QCJy2YOexNZ+cElnvb5WUrUkb1bZ/vtT32IOfG1+GH5rqhOzkbz7Yx74yN/YKKYoILVZXkIDX2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4FZkoZ25xkn8imY2Xe3ES7cWwstD+O1hryd7NTONzY=;
 b=bgIQ1747vASPewGYJPq/ZM/na1lRyiHkczExbyTjj3XjqXXNN9kfam3DWXZLlz1xybYtQ1AqqSHchX/Ta9QRPds10Z6H86D6LImPwpUJzwqK++A/mG9brk7NGcwkgE0TZ//YordXOfA6t9UEgkaEEP6qkmtzxqF/xpxQgCfVHC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:10:17 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 8/9] _exports.h: export standard memory/string handling
 functions
Date: Fri, 19 Sep 2025 12:10:01 +0200
Message-ID: <20250919101002.568488-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: d629e212-b34d-40f0-cf7a-08ddf764bba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UaCL2WFkRnK1aEeQ/V7TbZjTVJSubEzNmf6aCwtNB/n97ApA4+SPJ/zRqa0C?=
 =?us-ascii?Q?N+b30kdaYmIzeTqE4w2YUjAgr0kpeb9sZ2mGbX+UOHXQP11bKfJJQgtTuium?=
 =?us-ascii?Q?kS+Hy2wlbl/4oDHss9qX4B3/w+eT7J76UJsNyE8JBF/YkVHxa3TyPjr7n76Q?=
 =?us-ascii?Q?J1VrfLi105p4RoC6SonpYm9bLO3APYqnnIh7RYqY6s1A78nvY/Yyzjnm4F0a?=
 =?us-ascii?Q?5n7Zyr76i9GRDxvbw9Pr81eRjrNFs4V6ffIxxfGOPt9jbGTw4Je1VndZU1vf?=
 =?us-ascii?Q?o51EyEXMF0kDx65VZMB1utJANdVp7RlSVjbeUfg5/ibB55D+udF3W9Zp5AB0?=
 =?us-ascii?Q?vHTrQy/9sLOKoWYL7qQH7lc/fZx3T8HV3UUEWUh4tsRXMUjsovaNGLtIPWq5?=
 =?us-ascii?Q?J3ygMe4xU7AzBIZcgCJIURuTyP5YyIr9LKsq1tbB6xzptQjbjdoKNk95KR2S?=
 =?us-ascii?Q?RseKGvIODTJU0/EpEK4Htkk5nnb8JayxXMWNYhU8XjqVaI4GALQ9WZ7rbeMH?=
 =?us-ascii?Q?s4sj9fwDeMwEebtwL5cNUATMRZlcyqrDAwgDfhOyewtIvcSniqIiBufgfa9X?=
 =?us-ascii?Q?qbNbplEreN8GQK6cKu1m5QlQtnXXyF7nB+BxGM2HLIoVN2CbhTi6Inf/XqQC?=
 =?us-ascii?Q?UdJYgNTOB9ofW3vLtSphkSD1gldN9OSfRidlzWYF3BhXugCBnx3F9DqIM7cA?=
 =?us-ascii?Q?iq4IooboAjcskiGa2O04Smv6s5b64l7kLYD2baURzjs2HmZ3vX3QYERJ2X4L?=
 =?us-ascii?Q?iudMzeufvQ/6Pw0RUxBUK3t1RgdOb/RS/kT4wBIpYg8HUANvhZZzepJ4Je3Y?=
 =?us-ascii?Q?JLPGsUKjb9MufdMBSPLXEtI5lOWlsRwnQZHcL0wilRM0eT6DB4LAbJijG20M?=
 =?us-ascii?Q?zm+9E03r+KRQ5W2WwlxnvYxdG3POj43/Kg5depRT+JtuyS2UlQtQo3UeX9eD?=
 =?us-ascii?Q?6Pktz4dtwWu64bSK+l/1G89AzkpHa9JLv3HWsqmTgotUpAUZ2U8+LR7msIit?=
 =?us-ascii?Q?PPKhNmHq5UgC8ZNt14yn8wgiRGZGgTqCHN+9LwiSL9yQefQkPfmGYpGDgWaT?=
 =?us-ascii?Q?F6GWuk2fU0PKZLxKtE3Iw044mFLPIRkQ9zODipRUliLbaVTnIxWLQ+u2N9TT?=
 =?us-ascii?Q?uVefxgcPg02qVxU0J3+NuBfCsREMFt60vOd0kqUNBviiOtOT4kuxaEAIQEHr?=
 =?us-ascii?Q?vM0AKnGN4FmOM8gxI54OocRh09OOvFK03aw8n61yRHcE/u+c2LWupLIcc5Ha?=
 =?us-ascii?Q?/nnpsj9z+bJC51VCUUd7PrzErReOPMG43SnV+VefD7vRrMez0wHBF0QcH2jz?=
 =?us-ascii?Q?/TdzE5ds2mMmM5210ofPEU92X3B2dRIX4jOBIQZDZmpEKCjuEXGwNsX6P8mz?=
 =?us-ascii?Q?VtRTPqVKMFBgMkkVJpv9UqCZIQpPB1KzvsPF5hESvzdGJkSP8B/l8z/0s97d?=
 =?us-ascii?Q?gEEfEJE3J/3sKcPxPnKWapGIJooEpn61Frou1iOpGWW7NXldtr1MVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSJeLl0XTxhH2cDtTz9SxNorZHS0hhZB3W+3rLJZEzuAkdXUSA47czPzlUJa?=
 =?us-ascii?Q?dv0vgUUuPIA1kCbCHxj/kwAlyFl/gcHlLXpSoRXQ+GdvMWtUs4K3zG0ep3ea?=
 =?us-ascii?Q?2uxtg5amTcegDeKCz4PkM55/Wo4DgssCaVkDLzis9MHxAlT5/qF7tbPHHLex?=
 =?us-ascii?Q?oNuuA05QkQsmzyUO+vHsMS5X9SGpnaZDRrwi1MiBJ9nKI6fJ9mFt3IlxEUyJ?=
 =?us-ascii?Q?ppWid2ehwTT/Dzoyu/PpntLFAx5Sjvuw4QTlQE0eVbs5agSG7JOC6SrA8Tjb?=
 =?us-ascii?Q?YMf3HSG0Gg1WSGoimJbyxujopRbFEmlVCQStuXFxAea6T0e++0OpTVvrC16o?=
 =?us-ascii?Q?AcwEQZWoghZyCPzw/K71Q+uvp/j6N96FC39G+hPPfzHEISC40uD3WQr2kSDz?=
 =?us-ascii?Q?vAAJrj3bM4Y9RBuifyzX5wBGf1fR8RvzCx05dx0nKB2K6qOzMP+wxLpmKrFC?=
 =?us-ascii?Q?z3aWtZ+DqOMHylV41fvnN9TgD30XbxM+gf7OUzftrE9FTLbabpNSVUF3uGfO?=
 =?us-ascii?Q?50PsYNogdwGmWL10aRnE0vfzt9PtIVSN+i7mSRpavhIbH3QhB6KJSK5HrO1u?=
 =?us-ascii?Q?ga9Po93Q5WhuNwuFL7NhnxYmSLwV6ryaLauMhlKXdrjF8Rj7duS4As8Fm50M?=
 =?us-ascii?Q?YQTR1nwfAeu55gcy4P1ENpiDkg5l1EdEjyC98CgAI0ND6PT66o3Vl3nNv320?=
 =?us-ascii?Q?egfwU7pP1UWBtIwPnAuhVXh2I7jMG7b0QHCNTV/n0+HsxxYmM+GUt8fJbUAX?=
 =?us-ascii?Q?Jv701E4lW1Sajb/+gAi8SrpJh3GQgm7efwOE3xEhmCZxnikJf1jsRdbDtOyg?=
 =?us-ascii?Q?92nVba5tMyOpval2V8tLDPixf0XRZ3GyopsCb4aqX0Z2f3O8X841MFU1xULH?=
 =?us-ascii?Q?wAeg5xMqjWSADu1ctPu/4Cz0zwEPcl9cqNN6IdWbSf6n6pWEQ3OwK4gWj4bW?=
 =?us-ascii?Q?l9FQIxDqjNKfdvNKnD/Oj3rlIfIQmyVmL4lo3wd29XvN4jYF5xUm4oJ79s/+?=
 =?us-ascii?Q?DLeIMNXRMVoTJpP6dIncp/nItuqrnVn28QGSsNtebvGNgZXFTZCu0a0os7bE?=
 =?us-ascii?Q?1a1nwvnVXiljzAN+ylxN5Tew1wxDHp39jSthgUkSpFgdS0Vo/OABqa3K3A3d?=
 =?us-ascii?Q?XcBiQkpd383vC+ZmK70KUafCw5/cvOPOyjm/IK6XRSbn/Mgp/T86A7IIgJjd?=
 =?us-ascii?Q?z/gv/Rczkw9CG3wGD1Wkik/cANcdF+RqgKAPSWtdQgt7awGsOShaezTaXoZm?=
 =?us-ascii?Q?Ki4vOkcseQfUnJKSxf0lr1E7aaJNJdp0pTW6WDbMB5nxvXHAWyHdnoFa9VVc?=
 =?us-ascii?Q?6f6fKVgzqsDISxIKvaIkEQ3YU3WO+nLxfzRuAof/VmNSGZNZKWx0QeQJkcXl?=
 =?us-ascii?Q?bOmFy4l94/xbTKqiDfYKbLO23RYOq5SDVKxYv4rGks7k2rEV8ExQXrm4YeiM?=
 =?us-ascii?Q?46IuABNPmmZkH+b+bMRaKPGBPKJEcTeudn5rCaId5zdelebFBSpf8PAhEzBa?=
 =?us-ascii?Q?o26fmszixmAa/C3ckxYqILyyHGYauCG87MQ5+g7o/Mxst5OSf2uWJ7LiL3ck?=
 =?us-ascii?Q?6SaWsyjHkEMV6wGcXjqsVzcfGlvd5tiikjEVWVeue3nSy0hAEhOjt+uUTKeh?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d629e212-b34d-40f0-cf7a-08ddf764bba2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:17.4830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBudVHhOTd5BHtZScn3wLMdWFCPWWN9RQCmZcd3z2lnkK35bk+hrj/djsR8ZoVYap4EZeUhscN+Y4i69Yk5PYjxJd8TFJx6ilWeCpT69FrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
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

The current list of exported functions lacks quite a few bog-standard C
library functions that we might as well expose, since U-Boot certainly
has them implemented anyway. There's no reason a standalone
application should have its own strlen() implementation or link in a
copy from some tiny libc.

For a customer's standalone app, this means it goes from 95K to 10K.
More importantly, we can ditch the custom toolchain including a
newlibc used to build the standalone app and just use the same
toolchain as used to build u-boot itself.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/_exports.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/_exports.h b/include/_exports.h
index f1b11c1e380..a23fc001421 100644
--- a/include/_exports.h
+++ b/include/_exports.h
@@ -23,6 +23,8 @@
 	EXPORT_FUNC(irq_free_handler, void, free_hdlr, int)
 #endif
 	EXPORT_FUNC(malloc, void *, malloc, size_t)
+	EXPORT_FUNC(realloc, void *, realloc, void *, size_t)
+	EXPORT_FUNC(calloc, void *, calloc, size_t, size_t)
 #if !CONFIG_IS_ENABLED(SYS_MALLOC_SIMPLE)
 	EXPORT_FUNC(free, void, free, void *)
 #endif
@@ -43,9 +45,21 @@
 		    const char *, char **, unsigned int)
 	EXPORT_FUNC(ustrtoull, unsigned long long, ustrtoull,
 		    const char *, char **, unsigned int)
+	EXPORT_FUNC(memcmp, int, memcmp, const void *, const void *, size_t)
+	EXPORT_FUNC(memcpy, void *, memcpy, void *, const void *, size_t)
+	EXPORT_FUNC(memmove, void *, memmove, void *, const void *, size_t)
 	EXPORT_FUNC(memset, void *, memset, void *, int, size_t)
+	EXPORT_FUNC(strchr, char *, strchr, const char *cs, int c)
+	EXPORT_FUNC(strlen, size_t, strlen, const char *s)
+	EXPORT_FUNC(strncmp, int, strncmp, const char *cs, const char *ct, size_t n)
+	EXPORT_FUNC(strncpy, char *, strncpy, char *dest, const char *src, size_t n)
+	EXPORT_FUNC(strnlen, size_t, strnlen, const char *s, size_t n)
 	EXPORT_FUNC(strcmp, int, strcmp, const char *cs, const char *ct)
 	EXPORT_FUNC(strcpy, char *, strcpy, char *dest, const char *src)
+	EXPORT_FUNC(sprintf, int, sprintf, char *, const char *, ...)
+	EXPORT_FUNC(snprintf, int, snprintf, char *, size_t, const char *, ...)
+	EXPORT_FUNC(vsprintf, int, vsprintf, char *, const char *, va_list)
+	EXPORT_FUNC(vsnprintf, int, vsnprintf, char *, size_t, const char *, va_list)
 #if defined(CONFIG_CMD_I2C) && CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
 	EXPORT_FUNC(i2c_write, int, i2c_write, uchar, uint, int , uchar * , int)
 	EXPORT_FUNC(i2c_read, int, i2c_read, uchar, uint, int , uchar * , int)
-- 
2.51.0

