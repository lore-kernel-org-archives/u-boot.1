Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C286AC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39DB582A56;
	Tue, 13 May 2025 10:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ZLp69yPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66FA8091A; Tue, 13 May 2025 10:40:51 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B400082AA3
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwQRVQuc7Vnj+jfaivZrofF9302+wpUkLdPsRtG1f+VfTfXsNOytSOGdRz3uvfp8rROpvfu54xeDkEesw8eD146Qj5re1c2iV1Dwa7Fs6dXrrq7iJvk8M3RIuGzA2lc4r4bOxXNPc2mHpRDc4sm6x0yLANoj1RntpE5GazuOrU1SLls5Yq0gzT4ywZXsi3pSQGNj+OfYT2nD2Wioxq92pvxgr1Ev/9X4sN74AIborN69k5gwe2htfDHRYThJHhXK/1s+OdG7olTmBSQbN3ZFah/V+EM1S6z3xi/+cKndKGYNUDH1D+d/QLSLZkBAzmjJNhA0IawZio1EYB3xAlVqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MTuIEyT9gGu8TqG3oLNMXZ8J9cV7ozfBeH22Fq6JLg=;
 b=CkJK3MILbl3pblZUrWZvbanQQ+ef0ahpLTyfTGM07jhmihFPqwAQOUs/A4AAWqBVNiOb4VDg9K0E/2OLkvn9gCSMYySzS/Z77RBbySPyUeWEinyAqZay1w7RHYLNc2C19X7KtOBkO9SKnflIMaNYLYx8tpIovM2iqak2eqaOCgKV5OMp06qA2CoqkJF/VuoofhOO0ZLseDpGqKe+YWpnxU8mWByO3MR8wW6/EHT439AcDcMwNKEpRuNlu6QdjjCTyxoqbAp8mieL0iUSzx/NirD8LZCSveJAfdG/8aJXhrhK6W6ywZlVg2wGU0il2n2q00RM3hWoSxsgbcGY88oN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MTuIEyT9gGu8TqG3oLNMXZ8J9cV7ozfBeH22Fq6JLg=;
 b=ZLp69yPsw8tcK+3+DI4IK2xrw4RZqRyDqAlShdWLa9RjHDSqpuOy/cflhLxMwl5fVGY8TJdSn27pu9mr6efV8mW9bEhp5EJr3kcWWQ2s0zCm0hkV6VZtClQHfHvzliLPmzdfhpKZ+rh32gUchAcA+NoRRriQ6S5n/4G+XzAmhis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:47 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:46 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 07/12] slre: refactor is_any_but()
Date: Tue, 13 May 2025 10:40:29 +0200
Message-ID: <20250513084034.654865-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aece9d0-413a-45d5-a514-08dd91f9db1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBJGhgDlINJK18Qhv+RejRoxkQxoc9AVErOVgM8PAupfe653wl35fcn413ve?=
 =?us-ascii?Q?8X0CQFCOc7ivdLDO/a0W+UUNFnX231qiUC6f1b3Kd3A6W/YevepWNRqr33v6?=
 =?us-ascii?Q?X8I96nqJC4XfryceubmL5fiyHIKma0KMqcLvZDCqX4jgR87CaShxAnohg6HP?=
 =?us-ascii?Q?/uHvU/R4QJt5Cba9Wbf5Yb5wb9oVOfKLTCz1xTQeVLY+4zncVVqqkPE6LWSy?=
 =?us-ascii?Q?mY0ds+kd19saI+RdFHNjRIIDEuyyof02+6LNC+qtzVz8bVGatvyapvdSNMRX?=
 =?us-ascii?Q?n78X17ioAv+xxfaos54W9F46T7+gfqA+BiWZ1E55AXPgHmKrRllhhNCF8mRV?=
 =?us-ascii?Q?R6FDH+y5K1spa8tnME4fO+XB74O+Z+IPSAjJQa5as2yJUqort22s3w0PlCFa?=
 =?us-ascii?Q?NnAC5KPBS6Xw+348VEuvPrPiv+x3uXd0FOfut20f6P8tEqDcfVP3xvvBEzOi?=
 =?us-ascii?Q?E65Kq48rtbLlpRLDWty9gHKWpYRDa6xqXNomkUj7N2uEdd5Fx1F/YOl/trgW?=
 =?us-ascii?Q?b8eLA0akg0YVrrsonVx8ar3EVesNaEW8N69FtLNIbaTW1/3mXUimpvSPJl7E?=
 =?us-ascii?Q?C2i/9jUTPk44oRBnwrwdCUDeVxKNKRLfsNzRDH4rk74+7WDrlbTmIvPZAILI?=
 =?us-ascii?Q?AXecBXsdhbxuqjvXaLBd/TpCMkufWabJODk6eLm8RjGxmj1iijBtnp655iQV?=
 =?us-ascii?Q?5RO7id4t/KeJJ/dg/5GOJjNaAoRcijU430Lfq+s+iiWx0KPyP4SzUBucSOD8?=
 =?us-ascii?Q?+rHXCBcxuymTMpVxenLD12yapr/jlS/BbHsAsiESMX5kNE7xBDxDr7gdwfMP?=
 =?us-ascii?Q?qFvTao5a8c2ISJma8x7iz7XPM04iScCx/6DJh1TrJugmgZf/SaoyuNu6Mwc8?=
 =?us-ascii?Q?/OpYTb1sXr2YQuPYALxuIdqeG9kHF+DJTm0wbTiBI5Fk/iGidPLYFSWCy80K?=
 =?us-ascii?Q?zPCbrcfeOvqC5hubGFim9wsBo1VeaXGiTbhGbPghPigvH2EULU4/FC4LwHvS?=
 =?us-ascii?Q?yB913VXqK+1VQUByOxXzFS1IvENC8c3iyTktyTaolTJ7WhSumrUuCqayKEaB?=
 =?us-ascii?Q?ight1yITnEs2WtU8hZ7Pg7+D4DZrlatUw9tsXybionAwnz1/rM7uzBOpfPBN?=
 =?us-ascii?Q?j3h5jiv0AYuHAxQUs0kEWQf5R4u/AKxNI1DrbbxFIVo2VgxHMcXP+FEE9XiK?=
 =?us-ascii?Q?yUsAbdVGsX/zbs3aiTXntfTssVKMzZjBMAgnivgoKjHohE/kuIMwPkE6HtVK?=
 =?us-ascii?Q?vG4HGnyNI76RGvvqmu9xHLefv6KVxa1BSDX/WYkBwfrcW49YtK2lBe29rhZC?=
 =?us-ascii?Q?CCQD7STPT5oBYDUndWdqRTylKbkzytXKcfnr9QXSF6m9ASnbxcTOD1dogZsR?=
 =?us-ascii?Q?m9K0Y+HvyVKwx2sjpRqmzJtuU9KVYRKv+u7C0a43WCrhC+G0IX3w8bE6AadV?=
 =?us-ascii?Q?bnPoLfRNJR6b7LFtX4r7krqxC3vsQ0bw9kb2TvHc5Qn6n6+iigswRQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZB6GoTwWUB6mmhtnpvex2oAmKrbdi6wMXVxbgvIiJ0G/hMK0i/IvZEx3ih/z?=
 =?us-ascii?Q?T5PdSQDbAWZMIvzs3HL4BsGX17ARlbEHGKRowxVesC0mOsjIdNW+SUb/OA5m?=
 =?us-ascii?Q?NGfwwpLMiez06Nu3UnfrpjMocwPGXbiUFvt6amy3HGZaqHcB/rFv9daV57TB?=
 =?us-ascii?Q?UvNyEc9InDzCfAvyF5jT1qXMPnBUtVqXoSHAxZ9rRJvWGo7XgJIfyLseuQKx?=
 =?us-ascii?Q?fp4sI9oY9LcvDeGfnJPpFEqSuQ/VYmUs+9SdRzkz+qijoUvOYGYpTiHkbjki?=
 =?us-ascii?Q?e0P8YZWyx+Z/T7E1h0EY8CRGpb8VHLaZ0O4ULfzlHttz9jzKQRFajFo8MUjX?=
 =?us-ascii?Q?ERpp+Pom0WDFXn486eZAdDiXhXEF+jxf5ufviBzm3fDgGKGYUBGIivj5qFT5?=
 =?us-ascii?Q?WPFJknqBKQ/KXZNiwF3ZTlK9rxUmaWElUg4ecgvQsJCmQKRTQFawx37zA01d?=
 =?us-ascii?Q?ddpr780n9ktBym6QWeV+snDy3cktzMHWCBu5DPLJ9w86eqcfzEjxLgKJl6My?=
 =?us-ascii?Q?paIsBvxqQeZ82ZqqZvDqSQllaczEe/ZT5oKJT73wriCuYvfcs5PdWpq+zwdA?=
 =?us-ascii?Q?TJbBNNisrhmLWlaP2anBZkC+4aVsU5Y59jxcNS6JYcQ92Cgpf4lCAM4zXlX5?=
 =?us-ascii?Q?b4nw6B9nRYwWzILIFq09Lk7PXkW6faLiJOa49c1BnzPKAHEOeqi90TjxZv01?=
 =?us-ascii?Q?mWhVcUoMGooB0acIdoq7znMSG/DttfnEh2IOOec2ttId3sEAkrPnuDfKukab?=
 =?us-ascii?Q?TM0KzkWwVPHtWKR3Ckk+rY46nyplYC7Phg6f8vOOs8Ic4HZSOtNbhzOQL1cd?=
 =?us-ascii?Q?5AxGnzp7zwongWewJf1v3mjInyN9p7jw3viKaKTXeYMjyvHA6FFX3l44CwxU?=
 =?us-ascii?Q?Tr3J9AeLnYiOpqxModaGdjTQK6BkvJ2dDsJVUXUJ7ECg1H+bmt0DgR501KX8?=
 =?us-ascii?Q?JxbCHcR09Zhu49pF46FD6+/ElphDpms3aAW2bS8TpnmpyhGvvemvTILS0+49?=
 =?us-ascii?Q?EbXC+qPO1DiJeJViRQUQK1gdTm+OTk8FlxJq8ffh5dUqJ2XEUkI0MFe9JNND?=
 =?us-ascii?Q?nSE2eaMDZmxcndbz9D2WrG18/pO/MXfiZOi7AhQQbIfY+JEYFO0aP3iXoDho?=
 =?us-ascii?Q?1xCuBUgAiRCyVReogKFPeWgZANz+AzTpObRWmAJXvYvXk3Sv/2l2LYR5TOjR?=
 =?us-ascii?Q?Q9ZGodgKA+/qqIwtNlNQXwWEaRLgL7Tem3/HqQQsUNyE0jK9nCmTtvrz8EJe?=
 =?us-ascii?Q?9HzDNfgnYghDWIHeNBE6mA3MtiYJB8K8bdmg1zvBDr4ihZPxm9AEpynvGymi?=
 =?us-ascii?Q?agGtFZ6i/5H7LqUbEX4h473bPZwAKSRd0gDA3FLgN1ik0t4RRFwQsK92O0P3?=
 =?us-ascii?Q?wGwOU6QQLoZvpCabt589hneAztck6Rzt0jYwM4pxRVyFc7NqAIQs1i+cUkq5?=
 =?us-ascii?Q?u9cOpfB+OU1B0T/hnddbgjrtDIKIajexIGH5SFEYE12xyRU0Kd3/bCaTS0kz?=
 =?us-ascii?Q?ydeEQwC8Xz8PYTc483EJLhoQHLdv89m7r7FA6L/Hqu8vED8R03kbfv2UUfP5?=
 =?us-ascii?Q?tsQEE+01CcCILbDM2+Vw+SJRrGdXQZ9bJaD2ZBsdoGKPVhi00Ue05fk/arho?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aece9d0-413a-45d5-a514-08dd91f9db1e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:46.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37aQO4jzCfkz572jDcO6HWuFGEXvFViudvb4CMfvmoowP0te9p0ztEjpMlqCmmUlAugPXViR99XszhwYH5IXrflld0za/vcq5uaXR7cz9RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

As preparation for fixing the handling of backslash-escapes used
inside a character class, refactor is_any_but() to be defined in terms
of is_any_of() so we don't have to repeat the same logic in two places.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/slre.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/slre.c b/lib/slre.c
index 4f455400d3a..5cb0d3ec7fa 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -484,17 +484,14 @@ is_any_of(const unsigned char *p, int len, const char *s, int *ofs)
 static int
 is_any_but(const unsigned char *p, int len, const char *s, int *ofs)
 {
-	int	i, ch;
-
-	ch = s[*ofs];
+	int	dummy = *ofs;
 
-	for (i = 0; i < len; i++) {
-		if (p[i] == ch)
-			return 0;
+	if (is_any_of(p, len, s, &dummy)) {
+		return 0;
+	} else {
+		(*ofs)++;
+		return 1;
 	}
-
-	(*ofs)++;
-	return 1;
 }
 
 static int
-- 
2.49.0

