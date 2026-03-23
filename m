Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59196EC01A2
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 08:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B84383DB6;
	Mon, 23 Mar 2026 09:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mlJFIuee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A57984073; Mon, 23 Mar 2026 09:39:54 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056C583BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpF3ONDw4uE6kYEHdDZ9pszQMJ050GZ/6HKJTdDCBcBQhnce/uQJYO0bv3K0PVn4ybBxcTogPvi1tTavoM7X2mQXhhTlxLcWE8/5ntuvtQyKEqvuQKsNtw0E6agwtirbj5w9Br75KsqOfjqBfb0JD28NzMAFNGnNVvqFkoXWx1N6aH+tTG8eSO0j5POnsK/aD07MkMCmMn1fWfhU/3M2Iox4dFLlwuuoOxDDhJBFtncoyBxnUM6X7cHaEep2IJBeqV45AGxdawZhVumDsTwFvL5rIBlwgkrQ3IIXSjDh0Fth+NXLftcGNAsmb0hS4ZuUFKgNNoe0O/YtmK44LevHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNl91ZOceO/eFEMNVTF7cYEiX0SSxhdXxX6tbR9pMSg=;
 b=faTEYijfm++/WnUzZxiNmsPvKwDKqoZ6R/ZwGusO5sLTuGB5NQUjZzBnIF0ERGtgmxqpnQyaNTGyKVqH/12oCe4QkWjvU3nR5u3rrMXGcnM7P/vFvMcRHmcPyJ8HESx/gXAUSYoKADAg+quBZhj3qMWI1zAsiRmd+T6s5gunNpexe99dyV5KCjGUuf9YpSAzIWdeqaZJUY/UFtzVPeQth44uAalqBrgML27h6rRDFbBvsCU1noyrneMEi+Ban2Zt8LYHo1poQl7lX/ZPXQtcRiUtyctIR+xHQtAp1vMvIr62481K9ZCGKGL3tffpgvyXMyW8UgZOJvLQe52ZTnwp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNl91ZOceO/eFEMNVTF7cYEiX0SSxhdXxX6tbR9pMSg=;
 b=mlJFIuee0XYMB/4/npNgxSU0KXHhBb5o9OBkqj2nvQthMzT007ctf4DCNeTLnzHwuMlAhKwMkz8QdsjSqkxUxle1SrZ5aFrx5M/iVtFHbPp108lxf9fx51vfgIT8QKUm71VMb8HFTbKw4evNZfa+rd8dwFzPVFM2NEF2SFjNuBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AMBPR10MB9779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:766::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Mon, 23 Mar
 2026 08:39:49 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 08:39:49 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] linker_lists.h: drop never used ll_start, ll_end macros
Date: Mon, 23 Mar 2026 09:39:28 +0100
Message-ID: <20260323083928.1928856-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::23) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AMBPR10MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a0e5e3-23b7-4a18-1bff-08de88b7be83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: rJI76AUv5w2wZ6PIslbrpEBgRAmCCjxrjNNW63Eg62wrn4f5o6KCk7UWd9D/G4b8iMulWJhMs3SKxs7gdZqAFbJ0s7Dtsf/Bm7sv5LctP23Z6otDFyOwp956llAD+UvQoWHFkdJtdHvo2u7oL1FXH1ewvjV4JYWw/tX1FOAnIAm78edMUN6blHCJkm0kUrpJ5AxTScIs9/AlDTaCHCLOSirIgsCDjryFJk3QPFP8m9geOdMJsRYtrIh/IvDbXMzCkt0TwAEm7hnVjWpXGqQbwzXzHGYBlYJ6jneiHw8pm2IrzK9rO8+DwYq/QpERtSz4UbAGyFtLdrD1TfAHBtk5aeKPtUHuF/hMZ+dh4EHRCXeCnGPUwUgW2ENrUa7Ve5z7OrwPmg/nb2Gib4gljxNRlJrm/81aZO9FvST0eq6NstCHoqudsimQpS1HpiQTY8GQ6NtyaydPwTdCRBodFiHTdjnzou7fO+o+s7PodfaEMgcz7YlYLBmTNRwAaVyiA9uF0998DtyEhy4pKxfN7BA2MhR3uYg01Y4qlTXvQyeQgSDM/bTtn5adXeJ76QV9ZL7Do7fJhwmOO1cOjkNgKEDE+iAz5R3/XPzKZ9rYnvWbWyC6cSGbn03iZN0TQJ5qXNi/hb0LM3AOsZWdqLdr3QfBXc89zMNIv9lbHcbyYUCQdT33HlhnfbdBdOJde0Rp54OlSOL0eoGhZyRjXtiwutSDktK9ozkxZe8y+mTfJGtZ+imN5stnWkGBQIfEox1gCQq7iRupHBLulmnIZI1WJq7IZdiftJ+FBStzG1VUrEbUvaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PwqD1cQTgDZR+oBGVlQ0LE+9251BjZOKeIqauCXIGoXTrLtYIkIM5Nsfd5e3?=
 =?us-ascii?Q?slPDdobdkM+utAArzKpTv0cgPWLTElFI9zo/4w3dJ66QP31lriE0guND7F69?=
 =?us-ascii?Q?ev5cResq0nYOZgfOB3i5HoZ4WtsLKRNqau6HzjZlQhkU9AkKxHSwFrEDk9Eq?=
 =?us-ascii?Q?BD/BD/+1FnKuYqYaFm01Iv9FT8xEw4OuAaV91OImFHookIQACfOh+YVFHRAT?=
 =?us-ascii?Q?BcNEHPoRZQJUp4jFmicktcCe4tARN5d+QpSH4jj3Ox/mtj9YLoSrNtX6o8u/?=
 =?us-ascii?Q?lPLXrsE3EVFWUVwwSLHvuiy7GJKuokRB0uvmXGwXJaOqZCWJW7WzxGR30kXL?=
 =?us-ascii?Q?B+By0t0Mt1KEW2J7RMl+CiDWv58D8VnMoTpNqKxcEKFRKXdbgavxzcpFHL7I?=
 =?us-ascii?Q?8O1FL0aIGtv9A4VeK47BQA4AoKGptIAiQEPtSDc3K4GeiWIsceZdhXqR0i0F?=
 =?us-ascii?Q?/bmOpDTT9s95XU0Cel6aWXSTjYp72H/mYRdqMjyUEASE4ZOG8b8SKaLbTgDH?=
 =?us-ascii?Q?N9oDToTW+4IWUSidh1gFVlMfP+VTetKVbczrIocHOTNQ23kb2d54bLywlq8/?=
 =?us-ascii?Q?ZRyV75CpNblz5XhbOFZpvskbpl/4OQA0ILaHV6nvOkfg9m1b4SrU3EfAdIUG?=
 =?us-ascii?Q?BSEMGCG+MHKuY1Y7IDv8Nb52TqEuFTtQoRJtzbBA5nsoPaGt/8BGfaigoZCG?=
 =?us-ascii?Q?NJ2TBpowKXF3pAJPvHQddA0oz9cDFUx5PV/m9AaipPNs8511Y2ceUBQFhV3N?=
 =?us-ascii?Q?kKtRpvxHcAx2i03Kax0pTBx2NHI5Xni/vlKyhSzOqt0Ng0sgRqdb4nWNllsR?=
 =?us-ascii?Q?leO+y1MN2Bt7Z3KmRP+m61230ENodLCDSc+xrBOji1x2OX4VEeFiEVfBYpZJ?=
 =?us-ascii?Q?b3E4jYMTy7a2VSH5tneG8ahkWFVq05I0Tw8IAxnW8KSkxUWAi+2vCWzSPnYg?=
 =?us-ascii?Q?LPMm/fjXKzExzyGTDRbvgl7DbhjYVKwjaMx68tDBmsuQbEwlxAyzZTAi0i/V?=
 =?us-ascii?Q?JfVAKXSVNReulJyfaYwkTu9/StdwBwSlhi07Rte/WtNally7Wg8CFY+yb/DF?=
 =?us-ascii?Q?0jFiyIZVzFDfkJU4T7hkpz47Qt5E+f/0HRRQEZGA04MKje1HlvDGjerEfJeE?=
 =?us-ascii?Q?OQnVAfjTOL7V9aMubQtEhbQombi8liyKrgxSHj+BY9psdRn5k/4mQiUt8mSZ?=
 =?us-ascii?Q?IRtSbOr++miMvHISdAO/fxV1+kEIID7KJEr7JSrizBF9rP27tdiJsaACdgkq?=
 =?us-ascii?Q?vc8fGmdOxMp2hv0M0r9/uLJjCNsmQfMLjm3MihLrgxYqHhzOg/ambBB2RSoQ?=
 =?us-ascii?Q?1QmfLXbb54C4LveXkuGSDhvXf27zm69WJIyMCIL/BwohToVTXXr9aPlVjQV5?=
 =?us-ascii?Q?SOzG1A4ifNkOySYlCBFc6lSZBb2vVI33/fdCQbz6qLqruUDk5ZZJwETjeyYp?=
 =?us-ascii?Q?UJu6FTqkZOpUaUqzg6awLhGSankMlR2QwHRDh1rExJWrDaJQgNuY6I1E9Sfc?=
 =?us-ascii?Q?w2tNBRC5FKDiHfC26XLxkDkOGlvSq/hhMIKvPCUdwHXxggQWE6gelVBejs3d?=
 =?us-ascii?Q?cKYlTVfefD86i3m4DkDgJDAVWFM61gJAFPfAy57dNgPZQq/A+dX50egmRO8r?=
 =?us-ascii?Q?RotFM/UvVLTe7ZWE+2OvKf878ZWR6yehQd1U+jEaia8nCOW+SDXv2NBYO7J+?=
 =?us-ascii?Q?jNW0rlbZUxVeiKWPUm0gzMvQPdY0mBheIyx84paZnCb4FyBIRmmHrr8oJD00?=
 =?us-ascii?Q?qwtVmNT5WMgigPnHB4iuh7gz8D5dFNs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a0e5e3-23b7-4a18-1bff-08de88b7be83
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:39:49.1783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5foWzKnF5vCZR/8XUl2q5xAU8MKMvTG8bajtNHWpbOvbxEA2vgQ3RuV/+KLmrRWTlZIvg/vmbrmcj1NYNgaSmJki/W24jl/vIuQlhzPsX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9779
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

These macros have AFAICT never been used at all. It's also far from
clear what purpose it could serve - for one thing, what _type would
one pass, other than void perhaps? The example using "struct
my_sub_cmd" seems misplaced, as how could one know that the first
linker list consists of those, and moreover, how would one know how
many there are?

The linker list concept is fragile enough on its own, there is no need
to have unused functionality lying around that may or may not bitrot
and certainly will confuse readers of linker_lists.h.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linker_lists.h | 50 ------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index 0f4a2d686e2..78ba937c8c3 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -288,56 +288,6 @@
 #define ll_entry_ref(_type, _name, _list)				\
 	((_type *)&_u_boot_list_2_##_list##_2_##_name)
 
-/**
- * ll_start() - Point to first entry of first linker-generated array
- * @_type:	Data type of the entry
- *
- * This function returns ``(_type *)`` pointer to the very first entry of
- * the very first linker-generated array.
- *
- * Since this macro defines the start of the linker-generated arrays,
- * its leftmost index must be 1.
- *
- * Example:
- *
- * ::
- *
- *   struct my_sub_cmd *msc = ll_start(struct my_sub_cmd);
- */
-#define ll_start(_type)							\
-({									\
-	static char start[0] __aligned(4) __attribute__((unused))	\
-		__section("__u_boot_list_1");				\
-	_type * tmp = (_type *)&start;					\
-	asm("":"+r"(tmp));						\
-	tmp;								\
-})
-
-/**
- * ll_end() - Point after last entry of last linker-generated array
- * @_type:	Data type of the entry
- *
- * This function returns ``(_type *)`` pointer after the very last entry of
- * the very last linker-generated array.
- *
- * Since this macro defines the end of the linker-generated arrays,
- * its leftmost index must be 3.
- *
- * Example:
- *
- * ::
- *
- *   struct my_sub_cmd *msc = ll_end(struct my_sub_cmd);
- */
-#define ll_end(_type)							\
-({									\
-	static char end[0] __aligned(4) __attribute__((unused))		\
-		__section("__u_boot_list_3");				\
-	_type * tmp = (_type *)&end;					\
-	asm("":"+r"(tmp));						\
-	tmp;								\
-})
-
 #endif /* __ASSEMBLY__ */
 
 #endif	/* __LINKER_LISTS_H__ */
-- 
2.53.0

