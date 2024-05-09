Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2061C04FFE
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 00:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638D88833D;
	Thu,  9 May 2024 02:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eyZVsDG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BACC88460; Thu,  9 May 2024 02:47:29 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D867288412
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 02:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI0lHRH8Z+f6UXGTqw7Dis442RMTV1a4ib/IxpfE3vF38yTHiVIsOXA2wTiX83jhyhsdSFrNYRArJpwgFLbOGHOLLLZIDZJhr0Z3NnPWAU47taWrOaP0eC0SBO+I9cPVA8/SXwwDbX6sqHZYA/8o+Qfo8fYuINdGnCyf7UzMDc3IwbTdJtSSrcfMG6t7dBHzW40Q/NALUuDGilkS1HFcgWdvzFZseYVEYlUHDejPa9QQ4tyV8nRiaGaHM4UaKuxnapnlI+4mhsvDIyfoVcGLyD9XCF1jrIYzGyjd28/QkA4N+3K1e+XSMiKVjLz9MmLSIbvy051vJdeLD1Lcm3M1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oynsCEbcFLA7uS0+MARxbdpLxc3jHEPRJa2HNxVQqgo=;
 b=QwNuJ3+cHQEBRcrXTnUa5cB8SbSIiM+BEFclxNpSgre4CA8JXxnJ5gMiCjYJuVFEafDL55howuVkqIPHEVPC/o6u0Jz9DIsjU7m2qSNIxw1xm0oJO5xRlBJTiTKyXDOEoqKJZwqo4Kh/DQzWgcCKBg2fAZn9HBWv+lQPW6UibztKkVDSS0huYBnfP0dLG8TvBMMsh4pkhL7EGWjZq4XneLROtNw8fRWX98FuqMIRg3VB4eVzR5MwTy4xQuSE1mYLn4Xpdn78e+T8bsxw7uGruhat8n3aYIV5f73OEmn24twvejzgN8kcCsAVJhIBEdtcPd/rHFB8SDZjpG1fZCgWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oynsCEbcFLA7uS0+MARxbdpLxc3jHEPRJa2HNxVQqgo=;
 b=eyZVsDG1ub+LkP9gCiTMAai28gNRbGwmdI5hqJKM85FsJOUWdEVvsQjsVdnasv4th2OOtMWKxoEgmTQ5WiS7Ci3lcpGsPrS3yP//K44Gnzg+gXIU+Yr7D7iJojpkchX7KpH01dtaAh7FnD4fITCzM5PtP9+pLrgucV89Wea4bvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 00:47:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:47:23 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/3] cyclic: stop strdup'ing name in cyclic_register()
Date: Thu,  9 May 2024 02:47:12 +0200
Message-Id: <20240509004714.1394547-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
References: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e7b44d-4690-43ee-f3ad-08dc6fc19701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/0nCRTWwiZfSC67Xm2V/cPe+Nn4wb0/wJkSD6yp+9vuS2lGZTTHLZCKkC5hW?=
 =?us-ascii?Q?sxdpI/GYpjrIiRmGxatm5jthUoeyXFGPCv9YJWARrSdE2k0r1lycgr0NLkJ2?=
 =?us-ascii?Q?Rtwu4l524IjOMXPnezblikzaYSQpd62ayIVvG7AJOlo0ZYAWe026VSFw07d4?=
 =?us-ascii?Q?M5QakUfhR0lBNnlxfWXUIx+ib552pWSL9f1vWRiM6h9vcFnXKNhrpYd5JPDe?=
 =?us-ascii?Q?h5p1OTIAe1+1+3abGiSufNWrsN/aQe7S2+oVyMsaZRphFNzSYFa1MJeHyiXV?=
 =?us-ascii?Q?y9kd8drjEjLPODsd6pYqQWGxF5Si/yfoyCdDmuL/FbgylgWVDPtCMGg0vEXf?=
 =?us-ascii?Q?E6wIB517TzMGPQWtn+gglRJQ7LRbf8hQsbyVF82pqIl3H/+1HBmWO6hBwmZa?=
 =?us-ascii?Q?2mujJQf8LSL7CodLMywvf2knONibHpDM0nHQs2KBcf8WDOlhAmUvEYNhoHUB?=
 =?us-ascii?Q?Hcfek/T+yXYOLfK1z/2EuOGgQFcqmqRqxCXiZ7A1gIHDI54nJG0baGaWocrU?=
 =?us-ascii?Q?Eqk/KteOeh+lYQA0TM6NkDl3DwtXivSDdcgQjyK+V0o2QohGzdwsZpS7uWuo?=
 =?us-ascii?Q?emaBMrxQ3m0+uLXbk6nzS3nbxeO8QrMoRNEQC+DxM4xp1RmiULHmnvUFbzkn?=
 =?us-ascii?Q?6vsjuMT1RILWkiOOxjw/RubNdYGOVw4aHbfLVb2OxdKvwrPODaukjngp5MR6?=
 =?us-ascii?Q?BL6J2U5lSY2IeQC3BhKYKkLVOOHly7/IoXuGqX2B+WK5vfOt6bJT6av7Oj2r?=
 =?us-ascii?Q?Jk6oH5s/hc6yDxJ/NKv8bqs5cZSLuiKe86SEFurQiM94sq8ucD3ZZBBzzwHy?=
 =?us-ascii?Q?N9mypgFeJVpGqafLVeDc0xp16uoGf9JCT9Q33xsAhKInb2wxUoOtcBDHn4eu?=
 =?us-ascii?Q?Y2MNsQeOVTYN8W1yDykXHnk17AWm1ybSRyjKnj04iFHlbemcycYTz3VTxZgI?=
 =?us-ascii?Q?Z791Gl0la7Nx7D8wByyZSr5zeUJdvYK6nX1qFXD5YOzUOmAzYZcu6FIIuBgC?=
 =?us-ascii?Q?UqovAzJEAQHpTC8muxlTzAxkVC8891zrbk4ykMYmM9qRUOGOuv8/9pW9TAKw?=
 =?us-ascii?Q?lBssd1iRCQDWPHf4xqi9CrPd825PvcOIxTRwmI6iyPC84sR3RHx2Z6WVi71+?=
 =?us-ascii?Q?IBzZnEtTaKJONzJe/3lsh1JhWtlaMucdlV7ylaSnwuxAscPJ9iEEXEj9S7fz?=
 =?us-ascii?Q?OHrC8VoCO73ETOMTqiVxR+GzqI+NsZiJyUbgg36QREo0HNshui7Oo9BcFDRe?=
 =?us-ascii?Q?MqDS4I+h1qYMI0FgH3fTuI7uNMBCMr/G8+KGT8ymzCXvbIeZpWbcvKMRb+QT?=
 =?us-ascii?Q?OOFPe+Od99qV0aJPCNws1CJ+5xRcE7DBPG+npjLtEBy8gQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BKORXXIk7vGnblVVuHloTvrXB1bhbLxvsXhahhDz0KloIFqkzxbl4w3Y6zKP?=
 =?us-ascii?Q?mTUBfreCfMqG3PIsBAo+iJi85b8k5uXgw9854oMa7/Q2UckUoeMqFGyON78F?=
 =?us-ascii?Q?fFD1uX3SeI9qem5djVEi7qMhpxS4Tk4vMereAcBXed1vZHC9TbqhgdWWP+us?=
 =?us-ascii?Q?MPyNKpr59EDZNIjF2wEzsZW6oO54rJc/brr2cR9uhPvP2sPAC+0rMFcY1GSs?=
 =?us-ascii?Q?SjJRC2fUhNgfaBYabbDHEkq6c/9behKSN4cf+AtxhQG+E8p7SVZyH80iZsCY?=
 =?us-ascii?Q?VS8HA0ysoE9+CtMQKLen6rMvwp0P1+uMAJ+XZB2MLOUyTL8LJaABeWtHcBuQ?=
 =?us-ascii?Q?x1S8W+eVIQcXBE52hqkvwolchukakL9DmonQwu9P5x1il3SHvw9S+ZjOYuhM?=
 =?us-ascii?Q?jbg1/g6HoqZQZdtOm9REV98NRoRvhGovdFw0UGypykdOZvPeZfHeN811bJmL?=
 =?us-ascii?Q?LQQ21Hh2kq0uw5b7BjU7IQWinkar8SE/5WGSH3+ODOwlG1ti3MH4QyCpdQYc?=
 =?us-ascii?Q?fV0CKqUeFj9Ky7431isM0vmV5fxJtqyAouUBtm26jl9szxgPIhAMDcxaf7+y?=
 =?us-ascii?Q?COxRHI+jzd+/e7SkLX9D7jPWrdiVDEv/jSnRhkdQSJp3evvMq2zBRtLK3ihv?=
 =?us-ascii?Q?kLbLhRlAnjDJHTK2PowP3oGmLjd72HG39/DlwNyc/PHw0/EWagGMx5u80eXD?=
 =?us-ascii?Q?W9fIIvzubYwP/yxB32RdMbye605OJ7/NYCSOkRsxTQe2d37hOkHCW2Z7A0p+?=
 =?us-ascii?Q?FOzMpp1acTg3nPfxquUC1sXON1S7kSC7Muo5OFi5qEeaVH3b5bmrXCFac9Lo?=
 =?us-ascii?Q?yYndOR0QGGDfLBf6O2pCs+9zDlJ1F9+BeNI/ck5tqz5DiQl2dhKgRVv9JQvm?=
 =?us-ascii?Q?Ei0iTkB6wVpJIZTX9rPLKUWy+1G2/+UU9ouoqoWDWc06XX7CZMWTBRtb42co?=
 =?us-ascii?Q?CaJx6reNgdBogzoeetGUR4vpa7iXbKBd7tmHUk4LNx1OILKEJZ1FIIyUj7iZ?=
 =?us-ascii?Q?oS55eGWexFE8PVtorz3qAs6XsLEizaQZ9eONGwAy4+6AHbL+TsQm/mVhReYe?=
 =?us-ascii?Q?4On7iZXKQXFTXd8WLXPrfJ+xUd4s4eO/ENczk2asIfDs4CEINrzOLvQ3rDCA?=
 =?us-ascii?Q?Dyn24b9n0ddjdS7c7lozpWhPR6r70XYzIEul1rl7BYJEee0V6HJW5Z+6VbDv?=
 =?us-ascii?Q?RqxctGif7xVFoQCaT1W//5/4U5dmH17w00SNfEMwq08mxSeo1aGZUQ2yNQX3?=
 =?us-ascii?Q?7t2yKJkrnuNhwYe80kxQdNDm4R27TnhNbY5XnMVgb0qrxpAbc5ot9t4kEIFj?=
 =?us-ascii?Q?T8nGOSR2LBqaUJYSjKNML7ZqjTXdS9EBZ1wTkZPSvD0od/SMmu8gsU12v1bs?=
 =?us-ascii?Q?a+BUBkgUG/t93uAkOrGzP9dMgdNFVnRUeLTfa+2wGMkGyflbp/FF4oO4HaAu?=
 =?us-ascii?Q?9zU0dp6e/cpV9PqulJiwscTa+k311Du1qhGLpGsn3e5L8hhJCcYBdW2KPFVd?=
 =?us-ascii?Q?fe1n9mclK6uQ9TqhsAjdDeuz0+rjIeAAGs3SxUrmiSoUsonQNaanBPU3un2s?=
 =?us-ascii?Q?CbG5NxxSoz9YHvHPulRhmWtk1PsmHuJMfPiEay1xi1FLDEBReenrIKeFvVlB?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e7b44d-4690-43ee-f3ad-08dc6fc19701
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:47:23.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifBrYP90K36pYkrFn6ZsrpySncOED2YQbTKSVxanv8pTG8V27zeI4KekJFDmwUKODoHf1hFw5Kl0UzrmqrxDrgz8W9/LAAv0/FNW9Q1vlfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
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

We are not checking the return value of strdup(), nor
freeing the string in cyclic_unregister().

However, all current users either pass a string literal or the
dev->name of the client device. So in all cases the name string will
live at least as long as the cyclic_info is registered, so just make
that a requirement.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/cyclic.c  | 2 +-
 include/cyclic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index a49bfc88f5c..c62e7fa7d19 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -40,7 +40,7 @@ struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
 	/* Store values in struct */
 	cyclic->func = func;
 	cyclic->ctx = ctx;
-	cyclic->name = strdup(name);
+	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
diff --git a/include/cyclic.h b/include/cyclic.h
index 44ad3cb6b80..38946216fb8 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -31,7 +31,7 @@
 struct cyclic_info {
 	void (*func)(void *ctx);
 	void *ctx;
-	char *name;
+	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
 	uint64_t cpu_time_us;
-- 
2.40.1.1.g1c60b9335d

