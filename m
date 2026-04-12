Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CD5E93802
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392198419C;
	Sun, 12 Apr 2026 22:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Wg/UBlrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44478419E; Sun, 12 Apr 2026 22:00:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5D484119
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 21:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJhn68sr2TnEiz4km61B/jtpKhXPVHrjMDtMbIkuS0hGya43B2RBGxe4spQJKjVeB31u+PIXOGR1zdDvd1sxCvcR7x7LmZayK3G/J5wmM8kF8n34Kv61WErmewhd51H69HqeXI2/1Xon1zHFJK0z9Y1McqEIpqP2f/1+ha6irRUZOiWC6K5yWtDjRxdBAy+H8srI7n6e6jD4v3G8LBv6E4TniXVrTdE2e81lBjHvQeQ6vEZVOvSejTcE4n1UmHCnrxrEmfEJuxnWYqZvBF8+I++HKid955x/VhFM6+FVhVQ7X+Rt4tGftilt7mJ+eZBsF95HQiZFK255meSIExolyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9gcpx7LwI/XE1hnh0MgUZuLZWrmB1CnR3Spyb+0feo=;
 b=EK0F43G/E5II6D2OU1aCOwa+8byFi/8ZscWeujbaPTxkwdHfu70QpI3JW5I+SsupjpcSNBMvY27oAYRmHrOK93vYPzAXEXVBFMqYS/nqKmUiLTpTaFK9aEmAMaFfcutSYs7BTADmvRMUz+VM4mT8EDs+CpTO4rH6Eg4QlN3QHMS5ym97C/PeaGCwbc9SykC/EmlNx/OsVVtX6upcCqBXt/ma1hCm2MhNvy2hbTzgMZGHDT6y8TGb7MSE2FH7B0etfZOdDc7jMHTNcl2HT844vvUuvbcisDdj0DTSyBa7jejG2H5A0I6CwGVaAwKsnfQrajCljQwWZAbYMYiorQqMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9gcpx7LwI/XE1hnh0MgUZuLZWrmB1CnR3Spyb+0feo=;
 b=Wg/UBlrDJVHdZDQ1OU/JRg+4q2rmJhtDzuT5btssqVvS9AbDwHh5UNeDnYnMWdtepVAIotqOIR6i59EmSXqzA6BnRcyv9PgLSU+NdowYiqX+/PG6+IIsnj2hH1hIAsn0RDuaG7/1E4S7jiGHHql7G0j3m5aAe7kZiwp0vA6byqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 19:59:57 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 19:59:57 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/8] lib/string.c: drop pointless __HAVE_ARCH_STRDUP
Date: Sun, 12 Apr 2026 21:59:42 +0200
Message-ID: <20260412195947.1982729-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
References: <20260412195947.1982729-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0002.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6a18cb-1e57-4029-d37a-08de98ce12a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: awd1PePQ+yiHTEGPZ6f/DGZ3nVCFcBFPHM/hMvMKnQ3y2/pkLq+WfDy3RYp4aWNh/qT/U9LyXvtvwyT+Gv+RVhs5NLQktFHGikGAAaB9U2+nAPR3hGTtyy7mu18zyOtgMa+8U9bw2UiX/6LCkBoISeCrMmup/FTG9aolcuwo3eUyCtBdVqd5bMxPob53SzMAWYqE3y84/jxHnSkIUzdKNuA5b6e4byodTXkJVD6yKKcD4T/hcnyxYVbgR8+3QM2Q1kdWB8/46SNC4y3IKByLwh4fDeVfnTAkinbvYu/QtfbYZPlGIkQPvXX7uiY8LwuBY9p5mQOwsP+JRMRas6qXrdaYQ9BBkCk5ylf7uoeRNnnS8C4pz0bq0eTAUTCBhkwpESbJCAlCsxzbhPsBQO/HyD27MFx0LeWRiXx+al/B5p9eCZ9InsTg1omGLcYX0+ffKeldtjzBFYs1OJm5nyZ+4ZdP6as+n2A1/m5cW78H3T2kEiNexzW32s8HsZsBq0wCyGaYhsUpl1bGAkJrvNQ2MhhtPXK/mS9/bObACsek0lLe6q3/v2y6gIIVfDcIsjNGV7+KiEQYQhfiF1OUR908wOk5AJ5ekED6Kam1VngMIh+C+KGN8gsIvjAQZjUBL72fufI6iqfWxiFqDZ5tetHyThRfQgarpID/Rr5GfQZQ71C2/hexOU/z7uIZMzEIncYLcBMw3Gz8EDD6JZsjM57bxuc7Jcka8J497AwDlJD7OgTi4v9spMW8f+UIR8mIu5zgOjSZ5eC/zy0z7X5KscbmBlYhgt6WE5OcpNRzi7kZYdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJG5vGMhJVuPKAIn+5gR72ANS86c2Ea+c/ZOUeoBDe211geuV4LrnXAWdv3J?=
 =?us-ascii?Q?gOzd66VRiEdufGPIooMT/zEqK/0PWQIdo8b/sDxGTEWAKDJF9qZwgnpZYS4N?=
 =?us-ascii?Q?cCdbUcQVDPzqRvXK7kPraiILNiwteEUH2eI5fQ4cM4Ca1SjYNKlnMF/V6tGk?=
 =?us-ascii?Q?0W3mhGNwpi6wgW5HG0+dtabC8mq+NfqVznDEYX/Fi66OJ2BKE9iKaiy8lFTv?=
 =?us-ascii?Q?NTFJLjIO5OpsLmuMGrhcp7VE+/QeNJFG2lD9vu5t3bh6rRkALLGdTHVmufSS?=
 =?us-ascii?Q?t+NrsNM7PVaoKRdV7IWM/N9Ik7IC81rJjr+q+bU/CSIyHRS2SY1sD5iPILE/?=
 =?us-ascii?Q?5UgwSDKa0ZAwmiTgqAHcmTGzb7WTZnltb2Z6UFpqrI8mxldF6A7mOf8CoeUP?=
 =?us-ascii?Q?3ge/aZvMUV9K9/riuVXb7nsuAjWJQh2ovNoID26tqZnr/Nwr8HJDAxdSk6P8?=
 =?us-ascii?Q?fsD2fIF5xeRl2Fiq3AMSzguoKmxO9M7lzIMU2H1yxdzPnbPFKXhY1m0bSMjm?=
 =?us-ascii?Q?Q+5+6HtLEjA0/DS8/jsCTBlDErf5j5vlIBQUH15skompzcwZvwyYnyzj1zCF?=
 =?us-ascii?Q?zTqU/YpljWJietme+MMXlUAOvlDRAyeP7U11X2qYIJg+QvB/8cdp6sXegyqm?=
 =?us-ascii?Q?RqkMlR+ay5akX2E2DqWVrRf8dgy/r01mz21ZVzfcwJw9ku0m0xqHWPZtisu9?=
 =?us-ascii?Q?F1l2YYx48u2SQTuhwAKYa7BhmURbRPeCsxShphKtYpn0+vGYVRdy1O/Acwlb?=
 =?us-ascii?Q?Syc1WnXxJ6+enPh8sVJy6Bs9+w40A4m28fVg7INQG92OcL/9sUEOgNFeo1lg?=
 =?us-ascii?Q?8XEFOYXxV9vjD1ItN8NGb1/hHXR/Y828MAdYZsjf0Q0eVeJmPzjLL2HZZFkE?=
 =?us-ascii?Q?xYJxXoQlOVmHmKHr3ehkLmJj/Va0o1pi+AifoXC6h0aKM90dMALMqezBd1sG?=
 =?us-ascii?Q?8eduJIWwxa4pibG8fwkAEzvhhUdZttUMrd4gO4c0P97BnjpyOmtmL4W+lom5?=
 =?us-ascii?Q?TSQg+NM5Bob1yiVT1mC2GwqnlOVweMn8sSIi/X3WtNINauEzsAg7t/kEmfm3?=
 =?us-ascii?Q?KqWccb2mTxLMsh3bZpPMel788fm0Ul8thHUuVIHzDvLJuCh8qQhgXI2vx6Su?=
 =?us-ascii?Q?x05xPYJgV+Dm8ctjEIrzyolzksL31toAh8t4xKTSMl/2BPAk9awcs8A6VWbp?=
 =?us-ascii?Q?j9i/Rf9fCNGHM2auSqUI8Pmec/L4HPXaavuHnLnnNGOL+wdQUVXgKJ9gQ6bt?=
 =?us-ascii?Q?FLdZJ0FlOspacpncCdnGd0qV3ZNI2fPKnTVzHfwybjKMHCMMAe7Dn4cyHQkB?=
 =?us-ascii?Q?LfF5jRkwYg3KSfsatI8iLtEOwNCBWcS8S5LSKHawNth96f4yALGUeVzF4iYQ?=
 =?us-ascii?Q?j+ua3tlkD2g7qMig6V/S91F8Bj3t6Fa9afYJpqnPlQfJGtmZRbVA+rsSCKaQ?=
 =?us-ascii?Q?xu9djHm7fX/dGo2gnBccWWJ7Wv6smpjeM42Ic/AGsRBpBEUYgxvVAvULnLpB?=
 =?us-ascii?Q?NJDB/zFAA+sanSAuMdoqZ9TGorSbyE0ooHnHBRI9CxsQ8A1mLex6AUm4l2Vy?=
 =?us-ascii?Q?s9S50/FkteTX5p43p6rfuR3LbbIz8iFbGMQZjBshuhjx+f+6cAjAwA4Fugn5?=
 =?us-ascii?Q?2s225P+4MXSQP4xKrJfivaE4aLxA4U60UWh4a54UpaOeNv0xzxVtH/4R3eI5?=
 =?us-ascii?Q?qD71eVbURXzY0fQkkNAoJYWJmoSShWs0zMhjlM+WRlZfv5g5R3MJ/lnkOL50?=
 =?us-ascii?Q?BRqmPlyK5U/+eh7waEiu7uJGaU4elks=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6a18cb-1e57-4029-d37a-08de98ce12a7
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 19:59:57.7617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: op/4muaib8Mo37cVAyd54qrEwka26Jkv70FGV8ukz78N7ZiQf+ouqkFkTMubJF0S0sRzvAMu4X3SVOQvHAzqQz5PLeY56N91nU8vvXM+NQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9930
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

There have never been an arch-specific optimized implementation of
str[n]dup, nor is there likely to ever be one, because unlike their
cousins strlen(), strcpy() and similar that simply read/write the
src/dst, the dup functions by definition involve memory allocation. So
drop this irrelevant cpp guard.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linux/string.h | 3 +--
 lib/string.c           | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 9e47fe01c16..a28150fa578 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -101,10 +101,9 @@ size_t strcspn(const char *s, const char *reject);
 # define strndup		sandbox_strndup
 #endif
 
-#ifndef __HAVE_ARCH_STRDUP
 extern char * strdup(const char *);
 extern char * strndup(const char *, size_t);
-#endif
+
 #ifndef __HAVE_ARCH_STRSWAB
 extern char * strswab(const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index c2813e0f854..2c1baa568b9 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -343,7 +343,6 @@ size_t strcspn(const char *s, const char *reject)
 }
 #endif
 
-#ifndef __HAVE_ARCH_STRDUP
 char * strdup(const char *s)
 {
 	char *new;
@@ -379,7 +378,6 @@ char * strndup(const char *s, size_t n)
 
 	return new;
 }
-#endif
 
 #ifndef __HAVE_ARCH_STRSPN
 /**
-- 
2.53.0

