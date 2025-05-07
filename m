Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27E8C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C5F8288D;
	Wed,  7 May 2025 14:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RQ9NweGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C4E82169; Wed,  7 May 2025 14:12:58 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A850D820EB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 14:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E81Fue08oAcDcuJROlSbOjjnlHjChrdLCrTEPpvaSvjq76MK6HGYBXN9s3Vs7EMLtxQnUsFiXPHJG/lEH4asTUdltg44GlRryvTM9Tsv7Fx2z7CUf3r0g7P4hXQd2cwO3i4b5CIFdlKohio08BvU0bIcw907CyC7S/KNQ9W9O/lenNXdKOb/21FT3x7OBhXnTa9UDvaeTn4qmMX7Z6WFv93nf+ce35ogrpuh6tLfYyAcEVrzCD9kJwXpsbN1k2597dUy2H7hx9XJ+PmmBgVEWisFYpM86BdkxDVedg6aCU/sDFAckaesSe5BXVdH1BxBWH/vl8LTGSx9eH6l7ru97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XPCqLec/IEONJQ1fY+ja6/kVz127a5oXkuMDh9D7TU=;
 b=xbjsAuA0zSB4BndGWBCz83PQuD//P7dAwyVP8D81TqmsTIKgcz1ZgQZgZW/BR05Ps+m3TvgGghlR2vK8g1Iybf+wYWP/QxNiWpoMDh72t8OIr+kniI3n8kopo4k5UNBpWpHf86dDFkVkdSI35L8GFEjTtNMACYEShwwcWJfoVmJnHqGQc9+ORYHbOtQrN7n4CN4xyH2NXZMOzMu+7Z5q3K/fnwRpOhOH90EQHoZ0l3M8XUY33uL+wQbsy4JWpbGsbPK8UOzfGvaCKSjGcbzB+fILtWYGiZiHe/08BHgpDzxUDoGJNxHliRvkGoBixw4yAW53YK+Ulo/Lz7wNO9VKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XPCqLec/IEONJQ1fY+ja6/kVz127a5oXkuMDh9D7TU=;
 b=RQ9NweGWB3bGpsphGjSeUKhZzm/AhSjNAOqZpidi6cqLX6y3IuJRHT/ZK08vjJP8RHsFj3zTGuXeglTqgb8+aoKqeC4xU0OaS2aJWw72kzgdxFKC5dzEJyQzkXXcgX8wMYsncGNey8pKPGzf9khTlGJlXPmBkIJk32KrPnPj+ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB6014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.38; Wed, 7 May
 2025 12:12:53 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:12:53 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/4] mips: drop unused prefetch code and logic
Date: Wed,  7 May 2025 14:12:45 +0200
Message-ID: <20250507121246.518691-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507121246.518691-1-ravi@prevas.dk>
References: <20250507121246.518691-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8942111d-35ba-489c-5294-08dd8d607e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y9I2jBTBe063kkBtcFjFfsmDp6GjDzBKvNk9K1bu88KT4ylv0lNS4jPwLjXB?=
 =?us-ascii?Q?6Sntr8hQFzd9oYVwpTxMv+GranMu+Z4TxdGGNM/Wb1yPYRvwxqjLwWipRqfH?=
 =?us-ascii?Q?/AbBwN4IJonzDIzws6lzvHRRRcDffSqcIZr+hE8+UeA5frCl6fkNWFWTsq6X?=
 =?us-ascii?Q?svxtOtcotQL76SNuoD3j9nBvaYY1XG9wmjPExcYoIUeTSwYROzwWMa4ZQRjO?=
 =?us-ascii?Q?76t4F7xqrIjyejIhFyp+TrfInlKUEg/6MGeoc9LlAeCA1RU6CnGr4CgcBX56?=
 =?us-ascii?Q?/2q0lGzqy+C6X+dS9QWcBV+qEJK6dyVuJ727lZebyUNbvd+rBzyARnVSVW9Q?=
 =?us-ascii?Q?v0ui44YE0wqFJSdatZ9rxY+ehuVhtcHyZLjsuIFKHm8fUL69Ai0+2Ui/sjBi?=
 =?us-ascii?Q?SsXLch7GIUpX0B5Q0KvGI5es7cuk8HhxbUcv3lsG60tvYbNBD6f05y97Gaj3?=
 =?us-ascii?Q?tJaP24mMOArJluio9lU5fJxDd4yNSvFqZgnjF3oPxColSA7Im7rVHkBLmseY?=
 =?us-ascii?Q?d8MEFVRloelzUpN+vpJlQPIjKDZB5xYtUWseLXBYbhfbSVpq8b/S/JjEZXqH?=
 =?us-ascii?Q?O9P2RjNiKaORL7d9lD3z6ZHpQk2SxODT5RkH/imo3XMh3k4KInmG/VZyz2A8?=
 =?us-ascii?Q?zZ3wTcuihmHAxwsktsgWV09XRhXbz6N7tN51xcChLhRYp+Vfcglfs56DVqv5?=
 =?us-ascii?Q?w17ZdlUTuqvbpCVAuwtRmoWf2AgeUyy+XgKS8zJgRHic+n25DV38qMf56I1d?=
 =?us-ascii?Q?mSROyUzu6OpCfgBZKvXuWlFq1cMI2VJDo9C3NNuyb9BGFXtRDUGETLLsekpL?=
 =?us-ascii?Q?Ag465JIF5y1SE0WtYlsMa9aDFwE3LnggYyvSdTbOOqqQNscICCn1TjV+aq+B?=
 =?us-ascii?Q?3+EIXLIvmgvdKd43PwupJ6ce8GpCJC5I6AO95g+4twC8aaiUsXZLcF89M1R2?=
 =?us-ascii?Q?HM1F3PO5V+HPHo1luAuab+Y4pIsERnlIHuXSrNDZorXSmDeL3bCNemxZRYui?=
 =?us-ascii?Q?P9gJSit6pikRxjvc4fhZdnH15CRG7Ern/oMAB4h+sShZR149KcwgF48FTQft?=
 =?us-ascii?Q?gIH2ETaEVKYt7dV5QojQtHuLc0FLGvrnI8juwYH7YV0FlEO2e/+MRxnQFwoc?=
 =?us-ascii?Q?e1A07qfVJB0nTAzyQUQjwL37ljdPPXF2dKtYp5Q7LI7Yki4hUnIRSjXFBYeI?=
 =?us-ascii?Q?lnJ5eSZUJlK00O4XINA4ORiyG8cD7wsmAIDNstYZ2M3n3hVsFIhZsCf0rQEw?=
 =?us-ascii?Q?KceC3bJMdf9NWREPm6kHTX/7ANgY6xvLiQr78EEokM/IedC6RyfGa8g56QGs?=
 =?us-ascii?Q?hhVLlEAwV0pvsOjt5gJPGzReyyBrcC3HxxTzQru48HNAjb6O5h/+xhp90cHT?=
 =?us-ascii?Q?nit0P28kmjAwU8a8XaYY5w5LbxCiyZXZfotPmBTRe8tq12OXISUVYMsY4OoK?=
 =?us-ascii?Q?p+DgnyTGGXz0yGpz4P7dUIPRtWiHTJFuW9OYqqaXCbWkHE+ib9jx3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MB5T9/lGFCgLVkU+bdbxpO8OqUuEDGO/YljvXCVHIjsW09qocx7vVNE5UQRc?=
 =?us-ascii?Q?Lrn9uLluy8RuA/czIXiHyPiibJPQX/ASaiP4FG6u5cONfB6sSDVrgorQu3/7?=
 =?us-ascii?Q?xeW8mIub2zzZPh1rOXA7XtRL2EBN4DYnqepLpFCunwzzkXegXGgxN5aq1fCU?=
 =?us-ascii?Q?6no3h/Tp5XTaWcuUUnuyRK2MPeLGWr/KEounWvXy/L1Z2lcVr0mR+nqZPh5x?=
 =?us-ascii?Q?+smT3QTxOVNU+6zKeywaOinKG8UdJTNjzUy/N1c1OOAEkI/v2mHuFHGwBdYl?=
 =?us-ascii?Q?9sq2LGdHHKPmQS1vy9qKqm3S85mZFB4LqAYuiGkhMBCY5yZvlkcvbxNwFSis?=
 =?us-ascii?Q?cSUOLPlagurEmSSTzYNCbRnjAtUJO6UnJwgNWhkT70oU3Z2n65sfQAAT21Pm?=
 =?us-ascii?Q?gBqn3j+8NZhp5wZhWjTP+fTyHOVcQLZay+Civ2K0WQ2eoyIMaSpiqf+GDHgw?=
 =?us-ascii?Q?mGnGTlwNmdQGApoWzdUQ+TshmxouLS4ed/1ZvEjWule//t6ptBHkYgycZNPl?=
 =?us-ascii?Q?dz3NdswascRiUvmjBv0072g7kY/YfmO/xCtgrnaEbzW/RExpklBYK+2jLCIZ?=
 =?us-ascii?Q?X9sgO1w5C7PvJUhuwtCCyqpVxYanQElubEntb1CgHU/Zac4zM4EkCsJTA8DE?=
 =?us-ascii?Q?yuMRGupDIHGS2VxbjlPmszqFWc1LJ9z6Dng4pssxKd6dJ8ulK9Tc2dcfLJK2?=
 =?us-ascii?Q?4difGOCt6XDI5Jv90UQvhe7a3XlM8d7wQH1eeRCwwqBT4yiBMCe/0LMWf9t0?=
 =?us-ascii?Q?Rwwd1pxwkD2XECU/g/rKwMX3ekapu977zSpOMz/1wXkuHyL7flIhsTmuMbdA?=
 =?us-ascii?Q?5TevHokY+vN5PkrqTyA+dt4ijUa+/F7gj5SGod/5o3fB79Chq6yTDb6b1qwl?=
 =?us-ascii?Q?Z9hqz1Z4L1UT2u5UCfIfGAD/uBNjg5KotU62OTmkHDmv+wWukthICYFad7Mw?=
 =?us-ascii?Q?0uKaUZctWMsjZn/1TVAdK5rA+2UvyNApHqHaoz0UWg1Ia/UEP17ihp0AT8Bx?=
 =?us-ascii?Q?rgJLitmmS9k54PThxP7JeniRCkUY/Bn23vDbKp9FTz/v7BGmX76ZTRDetit2?=
 =?us-ascii?Q?QgZKUWRgbXr3sM94Po7J2/9xWE9Dz/UWRVB/MNnjzqlZTm/TJ7RPpZt57zgK?=
 =?us-ascii?Q?llT5UnmTOc5CO4zGJdsMNOmwyc63hzTfrsPRWTqQLoP1EXLc9GKhFDiWqbia?=
 =?us-ascii?Q?t7bVj3ROrx9bL0UmjW6UclsPIvMoofRtIRFMMd5ym8qL4lmXodiEwv5KfLJy?=
 =?us-ascii?Q?chtQPTq4fg20B4eOB8NOO4qpF1DXuQUl7f/6B/z56dxtFZmFRvXgCE2P0d/2?=
 =?us-ascii?Q?1zm+M48zxV3Uleog5WZNNdontjH1IOIPPgU4u1cd27fmA7QwR86fvWHl35dL?=
 =?us-ascii?Q?T7UJSq/R4lFgS/3JH57NQEZYR0A1sDmgoYA1xX4eFgu5/mX2VL/ZPRRe7lph?=
 =?us-ascii?Q?wXNtC8aOmQy0Bv8ejKkDQCuXp2MzdUu9lvnvYRSzfVrcY1Op7EQAJtKRr41/?=
 =?us-ascii?Q?LS550qIfOoBgv12CEiRmuBZEGrNt94KR1aU4xtEmoaFSogyaMWTUaMNO+Iic?=
 =?us-ascii?Q?gOZFq8ZlnQPuCqR7Ew6yZcfW12z+ppiaICJdIm3JunzvBjVegh7ssEUkoVN8?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8942111d-35ba-489c-5294-08dd8d607e3a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:12:53.1922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A5zx3fEQ2K4rjjXG/l/3bT92Nw5EWgYE8+s2AqnYeEIRhNRJAHo1K67v1+jsa5s+iS8YodG23OeJ5+jbTHXsOSW/K9dqedLojEEpnLEcu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6014
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

AFAICT, CONFIG_CPU_HAS_PREFETCH has never existed as a proper Kconfig
symbol in U-Boot, nor has any board include file ever defined it.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/mips/include/asm/processor.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 39a4f435a84..4c6322ed1c7 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -118,20 +118,4 @@ struct task_struct;
  */
 #define return_address() ({__asm__ __volatile__("":::"$31");__builtin_return_address(0);})
 
-#ifdef CONFIG_CPU_HAS_PREFETCH
-
-#define ARCH_HAS_PREFETCH
-
-static inline void prefetch(const void *addr)
-{
-	__asm__ __volatile__(
-	"	.set	mips4		\n"
-	"	pref	%0, (%1)	\n"
-	"	.set	mips0		\n"
-	:
-	: "i" (Pref_Load), "r" (addr));
-}
-
-#endif
-
 #endif /* _ASM_PROCESSOR_H */
-- 
2.49.0

