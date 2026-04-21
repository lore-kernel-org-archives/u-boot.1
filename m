Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E776F327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E24A84370;
	Tue, 21 Apr 2026 09:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="T+1D0lvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD83C84370; Tue, 21 Apr 2026 09:55:10 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8CA84348
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpTBnZzyWGDIb43ma30e5pqSEkkb1u6okMz4IAre8yTlVltmf0QVdpSkiFAQihA2uPbYtEa7L41NYYLGaGI491KI2iKGf4AyXAMn5R5LlDk5hc/7dh6rqemjwDOiN7zZKZOM4KE9vjpT0X0dyI+SqJf6EaW9zMupMH7o87we2zu4sLbKj2g+u9PdJFT66IPsnwtTCCga9BeUxLT5cil3uHTdsDOxnP8gXbGX0Wx5ErAU5b2SRZ3APsMb7rtlAgLH1p4GJddcgHRvxUPAK987OKRDPI2AZylzQ0v6ZOQli/ErKBX/dnMcw3/YdIHppSHmQJKFBSklHXh57JuoShaCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBI/T/ztFiuTPKCZZc5567EwMful4IK7eZ58anuADD4=;
 b=VR1O1xssdRSE9w7PIgLWgtuadR9V1NYhF0v3Bf//91cSZ+46ySptbEubHi2jhtCU9TQps2HzEqZsL2RPyqaKRv4ecUAgOwdepK7RUQ0GTlmZC0fKLssECa5BHfu4IiNns81c5TriQP2V934bGhyVjsfzITLTn5TASU1CWPKDZzfaieAoiWYFVXXlkX39a3A79pK6nF66OVBOHsCFKPKpdNTyTxp0717tVDmylkWck38TBZMTELDZ6yyI8/2ACRqd22rgQeHTk+5L2b6hYNTaLZ3Jhky2FqSyADhuR1wQ9IxP9+ZQmV5tCvbK40icqfxLZ/uNMryaTRSa9nUdXNmH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBI/T/ztFiuTPKCZZc5567EwMful4IK7eZ58anuADD4=;
 b=T+1D0lvzYukcsbyRjPHnOvSoqNUmXvmOygEB4FNaTTOKvIeyLxwQ0lubyPz5Z4NAHBdFpKqInSMuI786O86ZkYw50Cy7Zn6huU9bh4ubO0xMzppF4uJ9YpUCERm2ZpswUhPiQ5ddZxMi3+H/EzGMkBEyP2MsxDUpFkUCd9/tFUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:54:59 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:54:59 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 6/9] lib/hashtable.c: use memdup_nul() in himport_r
Date: Tue, 21 Apr 2026 09:54:36 +0200
Message-ID: <20260421075439.16696-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0008.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::10)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e3783e-2304-49d5-19e2-08de9f7b494f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tgtlkyru9q1XKe8Z82PmQ3WFeZ5V2U8K5wP9v/ne1QeNrQWtevnl94PCprRBMQbJc1D7MU9fy2CYFHocmr7T0MOxbaQF/nT6eQBUTrUAk04eTKy31Qa1RgBE3bHWHeMnmPqOoz3L8ORGOFMqSBFjKm98NKpIHVpShJR2A6vx59sVz8LjaDs9PxON2DhP4z7eP8hBPDP04LuyMyLxzFaRSYJDSipQsSOyCIzerfj1uLU1qkbZGHVlFlHCqBLxkL/khm9RFxzZ5N3RcTknRDr/l+bMdrMFWYse2J6KUeAltWXXPoieta4twSJSgNCtR+AsKwILytr8U3V1TipLjt29f3dN8rrwJC0Mfs8og8PVGtLPPlH/Z9ryUOfP5dfr0qAgfEkeV1x9E6c7efda9m1DVWWQywti/FIM5XAti8mvsK3LQ6ONz7X/9147mUVSOJtA8BE9V4TN6A+O2gaX4lODJ4MlxnVJVGiCGCJIiJTis40HXfc4urQa2Xx5gwUjmbqhZHJC2ktoOq3NoHLyw7DY+T9hPY5VNQEIHyamivbZaurrD9BbRF5tFSUWCxAyodu0SAmBoD89VAL5/s3DZbzHVXqHy/n4rGo1POg8aKBcvtcQq0uhotT8UFDBR9VKuy0cEKkt3+meRyEMWQCAaBpYbOddold8oTLbeai8BUPb9XmSmyWFlSVAdVT01gZfkFaru30+TG60hSP4hgpPluf89D4DtsU9cv8vz6O4tLVU7/YRc5wMwcETANp2rcyDBGGbPtFDi2ueFq4F2UUBYo0crOAvGAQlf1xxkUqGdzxDqK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7mzG8o1PnLIMPZiwf/tl8HNj8F4MrtXmeSLhc1e/tvu7TNMr0ESYgz1jM9D?=
 =?us-ascii?Q?hFLZTZLWn2v8S0H2U8A1y8VvL/JU+jthLyTQ/RfYvl5Ast4/ywfDvq9sidkI?=
 =?us-ascii?Q?Ou3Ws1KwyE+SDUX87km4rglncw3dhW7bkS2rJPHcxrotKCVtI/4cdU1fKCd5?=
 =?us-ascii?Q?C3woVyT9ovAyCFnCK7G6TGtP1WKHBLDLY3RhB6itAmKsLpOceFwtXNmw9RF8?=
 =?us-ascii?Q?VV01yqtrAJ1bPhSH4xEg3yGVMavFAHjyPUse/zASuFBhNUacopZkhxommM4e?=
 =?us-ascii?Q?vcuaZ/BItcOh0LQAX4cAdrJAom+alQn4c0wWE470E7ZyINt55FqYuiKCzW0g?=
 =?us-ascii?Q?APtDsdZRX3Kb77Vt+X3z3GUcYc0WBxGEV/sEDN+RN/zGABAcFVByU9gFhLZJ?=
 =?us-ascii?Q?22H6givMfjaWKIavEjQWUoD8W3pNS3/dBSW1qGLpbmc4kfvH1SG9QAO6BjOz?=
 =?us-ascii?Q?uQGMNt4yWulAndbh5x9T/fpetkz/1ZXz2Q1QS/YTxMJhbN43iBA/914L/v0W?=
 =?us-ascii?Q?NhKIEKyNCGt/BS4yQTB7T8VQ2YRVjvl7KevEo28/m8IoNrtdWCQdbjsvPUmy?=
 =?us-ascii?Q?YsVJFFO7Mi0VDcUTRgGtLU+fL4MNmOvMm/ffHN+/C5bPxEdG0FDp5rHcJalb?=
 =?us-ascii?Q?8dOIyJyludoTFJjr97KjMgUe7dx34++e6NQTnThdNbhkJguTGK9S6e8cEhP/?=
 =?us-ascii?Q?6sjpM3lXGJjIkBFXQ5qVdBSllAQbO2YBK06bKsg1VNhfYwFAtg02vwSE1y6z?=
 =?us-ascii?Q?FIZxICUErr4pY90668a/zJs6FyGnBXi4im3yRtU+rvIKxRbINTTFCdZx+k1m?=
 =?us-ascii?Q?7Z6qzPwea9+dU3tJQA7/5DOGfN9pkFQr1CrVlIjUADESJxSiJNErARJePCur?=
 =?us-ascii?Q?J3ea1At2DHcWHil2e2B6NPTs1Jymn1HcOgVHI2L+q4tjrsfcVeAYbEyudz5K?=
 =?us-ascii?Q?y5Mza6OHr1X2W/gWtzrWCC7i3GnRqx9LdNRYCqgy1crh0kaOhsYUsGQnDGxt?=
 =?us-ascii?Q?1FesyEFpnrEUs8/nw6ZAUL+pvzZphT4OCz2kFm7EKL/R43J3cyOR0kgxmOWr?=
 =?us-ascii?Q?wjGiFiRmqQnEGcVBjaglJJDNUgECKAvc75SUwI0ahnJP4CEUtcpoCT/ype4F?=
 =?us-ascii?Q?SATpK+DpdziQ0vOOif5+S5RnK+rdohirp4EtGI0guW7vfdafdT60PG+Ow8Y8?=
 =?us-ascii?Q?noVTqc2/KXV/tJ4ecrB7Jx1LtlClG8kBAXxzFrae3hjKD7iLZWROmBhpeW+O?=
 =?us-ascii?Q?DuIe4r2taaUW412lM7RBQKR/XuIoU9AnaccIXsr/oEAS6ST273KXOnRa+GvM?=
 =?us-ascii?Q?3e6uf3AfOWG77M/5o8iN/dtdcRNBEMNRDzw3Aab2do1ijgVY/jMUEM6biEdt?=
 =?us-ascii?Q?xX+GG2imGhTThFXMOvvE/m46GkXVVa80c7gK5E6G1SNa52UY8KzJvJZcFhEe?=
 =?us-ascii?Q?+r6MnRbcdSGM2skeN6dZF9zVa8zrtK8hLrxlrcXZ5izRlXbur3fUE7mbkkAk?=
 =?us-ascii?Q?h49vBhSX5ZBGclslBI5xc1+vZB9SKHbAtA50H5vN+5EpRzlV264h6jVi/O5d?=
 =?us-ascii?Q?0VPHkNjkxcVC0pMectez6dC37E21QJJa0TiJEDl906W/z11U0lu+YjGAPcs7?=
 =?us-ascii?Q?TWZn9gRSwHkSkHC6B+ZimTqw01G8jOzpAssz3Oh/16uc7VcFcilYAM8m3B0u?=
 =?us-ascii?Q?SV2GZP3OR/tIw5GTuH3QZMCcC89Q6HPudnAMw2AT3MDj1hlLc3WMluFCw6i5?=
 =?us-ascii?Q?10qIsyOD8PF6H29ex4GssAjBSxGQSRc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e3783e-2304-49d5-19e2-08de9f7b494f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:54:59.3720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG/JIPP54uybeSstkqWG5TMI1TY+bYeI7gfWK0+atLagFObfZdfftP6kYUTdnWnlR88nfGtwB3lwJzXDqZdeRrXVqRHoqgjGkgY3veURddQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5995
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

We have memdup_nul() for exactly this pattern of duplicating a block
of memory and ensuring there's a nul byte after the copy.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/hashtable.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/hashtable.c b/lib/hashtable.c
index 75c263b5053..f96a8e686f6 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -821,13 +821,12 @@ int himport_r(struct hsearch_data *htab,
 	}
 
 	/* we allocate new space to make sure we can write to the array */
-	if ((data = malloc(size + 1)) == NULL) {
-		debug("himport_r: can't malloc %lu bytes\n", (ulong)size + 1);
+	data = memdup_nul(env, size);
+	if (data == NULL) {
+		debug("himport_r: can't duplicate env block\n");
 		__set_errno(ENOMEM);
 		return 0;
 	}
-	memcpy(data, env, size);
-	data[size] = '\0';
 	dp = data;
 
 	/* make a local copy of the list of variables */
-- 
2.53.0

