Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B487C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3B082A8C;
	Tue,  6 May 2025 16:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RTYijONr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8C782A0D; Tue,  6 May 2025 16:15:31 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68B482A36
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APAfRE4rOASZ+hedKM4bIc/vooh7pagzuasJqYAWq5gpOJGUO7Yss8DDg4mG++IApMskbiU9plYewBaHetTa18zG35kMdM7U1vX/qj62rbKBrCSy/jsOP56WO1oGSWhkepnKi5QXOtZoQgwl6sjtHNaG/BAdCub7N96ho9CcIhx53k+X3OrcWMqKDEO/amnzTZd5ZEYBvRbfDTE9NABw6WijtgVtmt2TFAyBbaTdcLnMsIP9nTwqdhdaMwPQdupYzDZMOhMFuFg41jROsaLqruCl/51VM1T3uvtSlLjhNSjyauKfK5XDCAUkDG/qwBYvbRB3iZYRCWZ69rTl2xeKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcGrWRYop98t90e2Q86OpjOmUk1zIs+Qn7j5QjhVP8I=;
 b=ToPoC9XCmAxgE/8ROCKFHXLZg4e79Ra8KBs/NzJdeRAdizx/4lHGJxhf5JNJDvrtfbv1tXoeOBHt7BU3PlpXB/+RKXkbkr1TkIBainsVcXgBm9xlzMnl6R07ofiOow82vtoZv1td3ygcP4h3nTojSTc4OHU+E8483hiHGqsHses1UVmK1IC2GQtKnkROEKuA+BJolV6lZFyx4Sp2KP46iFQu61zSRv9bO9PHYF6sdZpV+yp7EPp8ofFDVvazmM9aWVWxrUfJYoZWhPVJeDGtuB6ksBznnONjQfa7zmdFOW4ImBgHip0iDUnx0f71GwxuK6gKOfpU12N+DSPuJ3qN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcGrWRYop98t90e2Q86OpjOmUk1zIs+Qn7j5QjhVP8I=;
 b=RTYijONrA6lPpSbL2TTRrNXBgFpbjhfudKlGFZCcXtYKNynrAYnBxDtPDgGQ00H4S7qhzo825OcXS9or9ADBR6BKf9qlY938BlhQfsG3n++ujWKANpFLc3EDhdWC4VrPaJKMU4cJpaXl9VG+0ylBZPVZPlAYODbLg4km4IJ0UDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by DU0PR10MB7237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:15:27 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:27 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 08/11] slre: fix matching of escape sequence used inside
 character class
Date: Tue,  6 May 2025 16:10:32 +0200
Message-ID: <20250506141035.385756-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::30) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|DU0PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b637e4e-75cb-46a8-bbdf-08dd8ca87355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BpL+eAEBurLXdpybRjasS1edzcamZYEL9BqnxwLDIjGBoexkt/1LCEuoSQYm?=
 =?us-ascii?Q?QYnjFj/fbhR2UPU9VNA2cq6lo3qceFZ77PfvwXJjbkyxbztu9HRbLmWTE6QC?=
 =?us-ascii?Q?U0yLqH4UPtsnL7WwWz3uALx893ta9a4I7lVCMSaTEZovwSPKxFe/PVFw7puS?=
 =?us-ascii?Q?8vfDIiTWzAoPhGFtzN7JFSq9YKrL9hpmJ+UAYiSvKE4IybBguD85wmTp1OUT?=
 =?us-ascii?Q?ohzqaGLx2HRmR3wItiKKFm1vjmtN3IAMvgZ4boJZILIkKZ8yEW+9bTt+P+St?=
 =?us-ascii?Q?dXjoeQuOJ66pe3Jop3ToEoRKMI2ZdF8x3WT1oWHwDKTpIPsiqPfGU3jo67pY?=
 =?us-ascii?Q?OlOoe+ND863Mpvky5hMBwlRWfrMoFK170vRlvILTGKiWjJojf6MkX6mB3rOQ?=
 =?us-ascii?Q?0KAONdBJIVs5XyAyHdJFoXWW2lU9LLyVd6s8EpoJPnQfsjNrnaRAola7GyG+?=
 =?us-ascii?Q?bjMTcH5Qo/SPW9zpeaTC6/7olvKcULdnE1rexR1hkDyWR7P+khV6oTRGT+6w?=
 =?us-ascii?Q?xRSI1T7A5CiiLGACxu4E23/kvYUn9WID4DgplWZGqelU0vrWOQ6G3udc1E+T?=
 =?us-ascii?Q?VDShP6ZYO1E8/7+dtpNDPq7Q0P5sBrTqmhLIL+9uoxxqBNpBcaFMFqwkpuRs?=
 =?us-ascii?Q?6gUpeDh8FDFfrjpIyYDzaTyFAU9Cg7GVzhz9el42rtZM9Ph3Qyyd17jQPQCg?=
 =?us-ascii?Q?ewpNFi8k6dEJCE/En9z34RgpbCQl5628QJqn68mUpMGIaOf7UHlR3p+3MAmR?=
 =?us-ascii?Q?TlVLAwiRGyg3KFgLqGwNkSCAJwtL1cH8PPgyYz0Nj9Bm0tgRYjbgKPTsLdDf?=
 =?us-ascii?Q?XnbzwdqsNZH1ZX88Jz77Ye7eJdhxHCgZbtE4k0zu8Zv7rhg/r7bua/zfpz8W?=
 =?us-ascii?Q?P3lPXtr3Y94BQVC2qOPqs1GdieyV36rJjpSzRtAHm3UmaHRh+YMMranwXr+p?=
 =?us-ascii?Q?Cg4yTBDG2tn98a2QYXykLQX0rUy8FOdYMFRId+Z1mTVvKc2dpcIsaDszzbi2?=
 =?us-ascii?Q?aaD5t4EIhTcvrM4Ock4gUEquKG3X23C2HI/CQD525Kdbb/G8bw20u3A7kHiE?=
 =?us-ascii?Q?3vz+ewg/p5Zw57NSGV9DThaa3Z1te95QWmqC4O6BluQpQMa4V2OFiESXnSF6?=
 =?us-ascii?Q?T26K8Hfh/N/V+N8jjJ4zPmrmCcb0ff/fWvwoED78bCKrkSErn8tdpgO2fF8c?=
 =?us-ascii?Q?2mVlkBkAFx3nZBiIsUFHM62g/xV7j+4HL9XTECInM8bnPJQGmBovjLf3DqeV?=
 =?us-ascii?Q?GPXtTLWwlpVeGfEJIDuK8nzdP3Fj6XR8yzEtVH8jZ8kjkIP5HgBFOdXNNemA?=
 =?us-ascii?Q?5Ebs1W1htyU9d/VMK559trpJ9V7iAuZMqhiISG3Y/jjGHTl/dRLSUGnclpzy?=
 =?us-ascii?Q?Q9l2uE22Q85q+yyCfwt1HhT0DsWRimUEFxeTjpOzJxot54NLQBDxmtYRd2K8?=
 =?us-ascii?Q?7Hh9wtqh730st0W4EoCrf0Wo05kASBwP4GQz7Sji2Epla7vt9+cVCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lg18oMj75G+Cd2bO90q1fb0qfhtGO/dswqnsHHXHmPOHiSi4q8j1FA43xTyT?=
 =?us-ascii?Q?8RbBPRX0Nf/aim+OTWJt9QkWuVZkYqco07UXlGOP1WLLT5D0K8cFG5sd4uqo?=
 =?us-ascii?Q?jGG42wGKHLam3lM8VvhxnNikn340I3g3Cqkmw1JXgzBhX6iJeCnYzE5vEBxp?=
 =?us-ascii?Q?sdd/ahBzqlF2TsIK2sOLSrlWlnlTdHImnOFAxPLUEWJD4Hc0ys50lJmxdr2A?=
 =?us-ascii?Q?JGFXSz3AtcgGHnffPrM6HEQC652lUFhKh9lRoKDMhxYCRme0vU2ZjmSGQBLC?=
 =?us-ascii?Q?1HOg5eARz0qvoepDrsYNj+INMtrhCditpacz2PVX5lOpTEcROvLU+QOl0iWC?=
 =?us-ascii?Q?aIFXGRa3CJ2EUUxON9vrVTgLMd+H4nuEwdHhdf0AHskJyD6BhvvrIUb9mEWv?=
 =?us-ascii?Q?B8rDKyBx5AZj42P8nlW/dJkKHzxBjAhjq6O6ZN9XN/lzkM97+x8RCz7kwmUJ?=
 =?us-ascii?Q?ck9ddYbLC9MGjAv+j6ImD+4+CIE9dhMWlSMT8vWf6rZwb90Z4zC3ANrKBqE3?=
 =?us-ascii?Q?J6URsV4ymjJus385720nu31XRwfBxkzfje7oCKqNMlA+GNGbh516cwhCN/6Y?=
 =?us-ascii?Q?chv4g/mWDp9kSf/U8ZEooYjsINTtc1zLgCOubNu23KW3UrjrpsHCJ7h30TVf?=
 =?us-ascii?Q?hDLYAg49JU9Qvxtck70HSkHrvizEaOyQXOyLelBlIw/LgCTqyGTwtKYgSP9M?=
 =?us-ascii?Q?V1/WPdJekkWgF5RY8QCa9Mz7VFHPQjMQGWFrPlndTr29/9AxcfRFI/t6ot5X?=
 =?us-ascii?Q?KHKjZ8S2ybFXmWPE0VZjHOZ1mjDtUc12eKS4BIDX0yaX71/+rVMZObqQv5rS?=
 =?us-ascii?Q?EtYZoF9t8/wWtnBHBjLL1U9nBI4oU6W0Lkttm4dKGPHzn5v6NzAmyLV6kwnZ?=
 =?us-ascii?Q?ZSwSasy/vUvue2x5MQDKqFZPDaaUsqQBoexVJGV/wNYW9KNR3Fg0nb9e6nY3?=
 =?us-ascii?Q?H9SvfaLPYkykBbPtesiuz43RJ6S1y4mItrArFEtQUrEygEy94FYdsyyIbCsL?=
 =?us-ascii?Q?v1PI4/CUSa75oYvy7f4Z58ERDocvApe9OGD0QkME4PAYw9YmngJb0qtWbfc9?=
 =?us-ascii?Q?kHR7Z8xsCxdr+h/WFIybpB8HB0GSzA+pLSwCPRWEqEqUd2mLHhXuTCyk67fc?=
 =?us-ascii?Q?Bca9aRsha6V+8aQGO3LeBdoiw0tPBugQLYQurUjXCd77Q2xiouOVscHdCVwz?=
 =?us-ascii?Q?oPjK6kYlx2hu9DILdAGUqk3X5bSxNwTadSuIGFHfn1kc543L0eK9KLqs2UtS?=
 =?us-ascii?Q?hCe0YywcvXB+4v+CpwItPgvEzSJB0mum/6en4PCfT5VHE9I5FcEHS3NdlKps?=
 =?us-ascii?Q?P2lQbAyoAaGmCW3cMec8Xxwz+WGMKdE4MBzVshkfFmBIlBEvvudrx0KN5C9t?=
 =?us-ascii?Q?GfAR0p2Do3AmvCBqITsJ/0a0VBKNfvJXq50gQfX/YABJ4dHf0z4FeWu3wspd?=
 =?us-ascii?Q?07AoxH6zzvxwf97qz9r8yccB8FVAH93qXt/sjISdh9E3mDRriNRJNryK7pqf?=
 =?us-ascii?Q?Pxfw8iRstwiBQ3UiW3e18cq9VMGx1rFlKuu/HpgQrEmuIlrgew5z4Z8Vhw52?=
 =?us-ascii?Q?TB+6uJj41kKhEHjRV1lA5klBF4MQMGAF2ifeIen1lpSMkSLprHhEuMLXmUo8?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b637e4e-75cb-46a8-bbdf-08dd8ca87355
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:27.5665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5f9JCdENaT2i9O9bQgcqfQMkt3l5ZrGdUeAnrWIKBc8T0vqbzVpu+xD1+l6/2FMXJEU7D82rV1T4Z4PS2sw25oj0BCnMj3/HmJOMrgUOmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7237
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

At the compile stage, the anyof() function clearly intends to handle escape
sequences like \d (for digits) inside square brackets, since the logic
emits a 0 byte followed by the code representing the character
class (NONSPACE, SPACE or DIGIT).

However, this is not handled in the corresponding match helper
is_any_of(); it just naively loops over all the bytes in the ->data
array emitted by anyof() and compares those directly to the current
character. For example, this means that the string "\x11" (containing
the single character with value 17) is matched by the regex "[#%\d]",
because DIGIT happens to be 17.

Fix that by recognizing a zero byte as indicating something special
and act accordingly. In order not to repeat the "increment *ofs and
return 1" in all places, put those two lines after a new match: label.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/slre.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/lib/slre.c b/lib/slre.c
index 5cb0d3ec7fa..87dfde720e9 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -472,13 +472,33 @@ is_any_of(const unsigned char *p, int len, const char *s, int *ofs)
 
 	ch = s[*ofs];
 
-	for (i = 0; i < len; i++)
-		if (p[i] == ch) {
-			(*ofs)++;
-			return 1;
+	for (i = 0; i < len; i++) {
+		if (p[i] == '\0') {
+			switch (p[++i]) {
+			case NONSPACE:
+				if (!isspace(ch))
+					goto match;
+				break;
+			case SPACE:
+				if (isspace(ch))
+					goto match;
+				break;
+			case DIGIT:
+				if (isdigit(ch))
+					goto match;
+				break;
+			}
+			continue;
 		}
+		if (p[i] == ch)
+			goto match;
+	}
 
 	return 0;
+
+match:
+	(*ofs)++;
+	return 1;
 }
 
 static int
-- 
2.49.0

