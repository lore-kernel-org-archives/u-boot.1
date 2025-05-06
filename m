Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829E0C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38F382AEF;
	Tue,  6 May 2025 16:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Zc736UpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258F0829C7; Tue,  6 May 2025 16:15:25 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F65482A8B
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP9ZxONvwZp6I7PlSyOxuw0m2FeZ59aVixYx2HDN108ILthFurEWUOWX5tKkysztBWnMtjCqF/mQhzW6O3xAMM5a/o8T/QJQMZbpYMDaIIxsIc6P2t/OvszrMEgTR57+LX5vCuU1CCfFAon95JlQWpp1zHZep4Hcv27nc2JWFBVICUwM/cuwFbmf82IobBIbBJ7dCHv4Sb6KRJYOMbs4trq3gcmCk3f2whydw3RyH9NudVNw/huI096A/vb1sAXTrpX0tk340+w+VEwKnbw5uRdOu4XFULCcXPJkJPgnFC88H0YAQB1GEKInectXYNcWG+g+FOuyrFWWu3S1LZBhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjaKmEZyt0j/ytdgQfQgqOUwwpiRnSBU9Fy1qWOvVI4=;
 b=X3seOkgzY4Teswzb3Ml8pi2xcLbSllPo0gp8B9r39ssWl3E9znPnIUBvwCiYY4cVX3HRSmCP20LZkSjU0y4QTnRVOo3hgJqp6UlYwqU1GTDb4kfsgtM6slKzj4U8UJtO+3EojkkD27X1U+yJEB9AaFMvmhwGwFFCOlZFwVMpX/4lYso67HvgOOS2IsOKR3D6HqdIwkg01iQCtwpNHrIfvJI2sDA682/iNZUMjnF10pAfFb2KsYpJxiGB4rkjttRE35TkbuBke0zwRhq6XlAP6oljARpue99jP7B+xepMpdMpkbv5ix5GbffioLzsLlzQ7Gy5tF0dboFH9GOwBtTWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjaKmEZyt0j/ytdgQfQgqOUwwpiRnSBU9Fy1qWOvVI4=;
 b=Zc736UpNgjmk+O6Qu59Up1rTiGy6B15upLn5t3BlLZ5goc+MfPNSdjucYt8RpwglMcug+3pbxcSFfKw5eApjdkATxzmZ/Nril8zNx/O4yB68KhdnuGC/CJFBZ746f0/rSmU/Cx9uR7duMnp00Ym2mKKSVCW2ecW8/6qpSMFIahY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by DU0PR10MB7237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:15:20 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 05/11] test: slre: add more test cases
Date: Tue,  6 May 2025 16:10:29 +0200
Message-ID: <20250506141035.385756-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|DU0PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 391a3e27-9698-4e0d-0745-08dd8ca86f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o8xImeaUZQ/ivI0IG30O2UkvnURBNbDSvAfuOnim9d3eTN670WIeyo3XGsG5?=
 =?us-ascii?Q?fXB833hTtYS+OPhKLZ2pM+JsOjJudtWVEvupXPCJxWun2xFA16A1UA+h1+Uw?=
 =?us-ascii?Q?lX+uYt8qYsnv9OHCRPwpnEXuM3WkJ5oeTOjx92lGSEdp0UMIcHPyD+1OjynK?=
 =?us-ascii?Q?db83qzXxRgjw4BePmRL6Be11bON5JGYyailtrkoNjUD4kj0lgOjAXm30d0e0?=
 =?us-ascii?Q?9yZDq6Ee8Cb7D2Drakf3WP/Qk+qY1MQVD8O5igjryKxyiBVrkn19njELULp9?=
 =?us-ascii?Q?c1Wq/5Wf+HglzFN/N5RPy8Hbxl1tCH2ssO85A5i3WVeZKJ1xgo4vXCrJ+/es?=
 =?us-ascii?Q?8MGq4C18nfRO/I1+Z+aK/HuqEsK1pOAWmLU1FKH4HKCdMmD6ROxkBXB68ExB?=
 =?us-ascii?Q?qDRv6KDGy1/EKINTj21zknZzy/fWlmk5OoByYMwp8c+Jj+FRQ7hMwKk/QeDx?=
 =?us-ascii?Q?iTQ286hsjTkMo/K58tItMlxVz1mzF6f0RwqCgLybC3tOHBzeZb5XT9HerOk1?=
 =?us-ascii?Q?aGKleUUpXTjH21GEH+vfEkmaSLTPdDrJyTj9lhEyh3InjFBoHj57AU32XzLq?=
 =?us-ascii?Q?932I5gElKxLuEIm7wqkLavVUdX8glIJHBblvqs2eOEjrzKvzEnzHF7xw+C5K?=
 =?us-ascii?Q?uGrLmgYzRv2kzAK4oXwopASMx8cK5TeIjlkmid7phFlbxAf74TFxxvYWYPl2?=
 =?us-ascii?Q?EW+8rhdR7FEKohRpYMwp+x0x0GAeA5FkH7UfMogXfbo5sTMVcVlO9+B+QFl6?=
 =?us-ascii?Q?SDabi0GdyidsDcU8aBi+6pQb1mrNYVtPgRu71dJTKzYn8PM32rCC/TVeKsPX?=
 =?us-ascii?Q?/AtYu+KNkPdSl7FWH5OzSJR/vKyOMqFm7UnJNChUD8kAxPNnCD2xnjihjjWS?=
 =?us-ascii?Q?errcWsWvo5nE5uNQCGLpW5QHHFR6/r6oxxLnb0DHtIAw8BVGHBoIl1Py+6Sk?=
 =?us-ascii?Q?qHt+QIOlWlUAxAUVF4+wgo9M/D8xUTiy4vU0C8pELC6L4vnHyZgCjeMa/KH3?=
 =?us-ascii?Q?d9RHeLuZUKMWqSM8fejR0scAYX31/ozF5ukoe9tdEev8OVIgjlsuWVqXrO+x?=
 =?us-ascii?Q?R4NU4jUIH3dWpBbOrGTaXhLLFcorXl2bFmX9Egq9akq+QCMOlYRm6DOBDdGb?=
 =?us-ascii?Q?TSY/OzihGlGvPGi4Sq6KFvKOqsWdJI6b3hrg7qkMPZO9OhXO/D40N04dmms1?=
 =?us-ascii?Q?LDqB6VKLoyMhqgydUf/DZVBV5TRB41AUnY6Ugc8hE8Kk8E1BsbbTPOUe4WnM?=
 =?us-ascii?Q?sP5LmOc+E00Z35+aMryOakQ2huL6O6EbHeFS9haSqj+a/4WskaYT7oilvJRp?=
 =?us-ascii?Q?+KojKFO9GVAx/hYRFeJTLI8LjP61pBxokOnMcUJ6gtw4yg+YsyDG1pRDdrmC?=
 =?us-ascii?Q?NYTvHHw4JRr2kZBar9VdCFliRI2NJAGG1xn6oP0ew5DqPoESJRn++b3BVOdz?=
 =?us-ascii?Q?L0qMiYSXDb50ZOn3F+6STL+v/Eh4FCznStdL7XAgRj9N2uP3mF/WGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfMLKUweM+LHggfa4so6ikNnP6k9fBU3V0XuRdXeeGKGIOUa1taKEsvBefBk?=
 =?us-ascii?Q?DwfV152UOI1T0VnsNJDmWF6Qfc1Zr/2Nv2R5Z0WP3CgGmADm91vVHWBNc9Cj?=
 =?us-ascii?Q?ZIfY6aoMDBxnVVZM7aBtdHJ1bMamiMnMrXciOCIoowqhFcoysEE2PQ/vxWBv?=
 =?us-ascii?Q?Ne8xw7SFI8qJHOT7PdEAol0FHP+qSYIKgdZ0q4NTktyH48DXZXD+a8SJLTf5?=
 =?us-ascii?Q?n15300vGNzxYfUHwoCX7aiJxfD6miARpk4PeYbj7eYvdY1ssl2qMQjd94A5P?=
 =?us-ascii?Q?Ky9Z3JEibLK1wtoNCg1W2tC19JYjLs7kPilG/ey/j7QKCMAZ5fXl4Sh0NBir?=
 =?us-ascii?Q?rziFuUWbSEFE7EdjSYYV8Fs5NT8qLwU2nFD+RV8XR1EGMRuRl/tX/KXAQOL9?=
 =?us-ascii?Q?lzUdpUsT1DjZHRoeiHq0laqfutGcuw8mISvMRfg10uFV6mMT6Lo6zh0I5gNw?=
 =?us-ascii?Q?VcXsozvY+pQ9MOhLZwjQ5MA0h1/bGAzCo7tcU4vdFs1Xvx9AapmAV/EF8t1i?=
 =?us-ascii?Q?5BoZCfLShDp/TUy+9y1/AlZd/cU69lBXxgsG2ctXUoMnf/mC9kGN9r92CkBB?=
 =?us-ascii?Q?eE3EhT8HjSON0rjrncq+urCPTda8MfEKj3JVrUMaa88QOe/Gb2V/fVCNEZf4?=
 =?us-ascii?Q?QM/l3pL5sKSvUaqjK53bN1cD2y55wLDd40Xde+j3OznpvJbuqCetWyWE0Zoc?=
 =?us-ascii?Q?NI91CLdfxFzKrYMJO2mCAzybg16b/HEZjhx9jtsloLP+tcSZJ1FUOCSptaXD?=
 =?us-ascii?Q?xnPj0K/v2gxvr8LTg2bvtx95mIfE+mY5OzxfKhVQw66gVcJti1jEPgq4I+ck?=
 =?us-ascii?Q?eFqn6YaBlJNnNHCjuZV2t26C91joWcdlyJPiUbnk3l8HsSYEJXivU0af2YVi?=
 =?us-ascii?Q?ms/IvX02T+H+JzJKAhgGZTA4RGtfhie63go7X4Fa73DH4/TJlYnmFCrXhokk?=
 =?us-ascii?Q?MxkGR0IEBYdgY4Tt5esCS73mqpJjgiyYbgcDEQl8G60sH7B5nNS+n2OSJWQ+?=
 =?us-ascii?Q?2mKC7Vc6QLwoGPb71/cuja+agkKTcxjeK5wdVXfb6IesW8yXyhx22h5ZMUgh?=
 =?us-ascii?Q?4TkdDFRjnhTSSu8/GJJ4Oj7QbVYF5YG848fcBk32VQh08Bb/Hob3UsuohWEu?=
 =?us-ascii?Q?uPs3sUCOwkTOkfA43zH55Qa/y6iKU8WJbcEiIio2YYTDl+/Y/xqLoxPlFcJC?=
 =?us-ascii?Q?QUSwET+8YM6Xxs5KlJOcr/cMcxFeuX0RqaGC36yl6qxqViQkIhUgSWimcxmM?=
 =?us-ascii?Q?0+SearFUT/58l2Ai+ZjlS15zVhNrQ3scIihGQFGCUOkw8mjg9AW0uk5hUmxa?=
 =?us-ascii?Q?wWHkrKTn4bzEqo/FPLv/hAIFA9M3J2VuSXNCl+01IbeERRErQLqyo6JbipXj?=
 =?us-ascii?Q?Y4eA8/Ku2cwY8NnY1AIhiisezytjQv/cRauatDk37armSb55Rp5e/LpKl+HX?=
 =?us-ascii?Q?9WCW482j5S4oOzcG0p+d6NWx5OH+LIJMOGV/KAWHTOpiRFLJesVCKHf2aB4L?=
 =?us-ascii?Q?9spyD42yiwGqNg7wu/OUUbLz9idH7g20+ChuIfa/uMAMVMMaSEOKbZ1le74I?=
 =?us-ascii?Q?6w6OycNVYzSVDy10iY4fEnAm81BoMkAaIhP+dxGDScpA43xHKfKlUkvKaIWr?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 391a3e27-9698-4e0d-0745-08dd8ca86f37
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:20.6260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW2mjoE/59AqOvS2jF3AjRt8y3Y0pDEUeouhQgmt0z/F8ebWebuQJTMMNyLrmXioGzq+3HOSk7PrxxcGVS8Fw6TBOrdyLZzS8uEASp+ele0=
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

Add some tests for the "drop wrong anchored optimization". Without
the previous commit, the first, fifth and seventh of these would fail,
i.e. those:

	{ "xby", "^a|b", 1},
	{ "", "x*$", 1},
	{ "yy", "x*$", 1},

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index 51a50b269aa..b76d33475dd 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -15,6 +15,14 @@ static const struct re_test re_test[] = {
 	{ "x23", "^\\d+$", 0},
 	{ "banana", "^([bn]a)*$", 1},
 	{ "panama", "^([bn]a)*$", 0},
+	{ "xby", "^a|b", 1},
+	{ "xby", "b|^a", 1},
+	{ "xby", "b|c$", 1},
+	{ "xby", "c$|b", 1},
+	{ "", "x*$", 1},
+	{ "", "^x*$", 1},
+	{ "yy", "x*$", 1},
+	{ "yy", "^x*$", 0},
 	{}
 };
 
-- 
2.49.0

