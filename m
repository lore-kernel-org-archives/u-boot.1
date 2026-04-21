Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592E4F327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A211F84378;
	Tue, 21 Apr 2026 09:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WI40dViX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCDC842D2; Tue, 21 Apr 2026 09:55:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC03B84309
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biUb8DSdSjgLUPQcJHiV61gtOv/DFRJo9829/7WOIqc9bxysXUCEBy6aZXgJ725ENHXqCZu0FjQhDfiMLHNzlxJhdvwaAZdTxvR6XB/A9OkdcWI87e1YXzikObeAX0QcHpE/yjkGHJigW2Zk2m7nLCumhJHxwp40PsE4T/3elDMfKa/0y9OuEGWIfw0H3OJzjmIifZ/iUAJVfEFAAfyGB3P3W0XApwVK9spdvPP3uyXjXIRg4Yncjo5xiqHqbo2ZXwgAugP2Gz9q7c/ymcxMr1Viovq8LUvhz+7kdxIfbpExilQ1rl/uw8tE+FNqfTrM5nxOmKRClsDnooz99FwxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPXtIaN0EKSgUAyiKh0u20FaTmR27W55jEB9Ojj1mAY=;
 b=HS1o5u3Hht/vcQqHngn2UjVgE2AVkjOpb+d/Xyhk4CBpwbXitcUGcTUD9jxwVAaK4JnDfoM1xHTRkHg7tbfu/qvFr6fotKX9GeiyUOkFmgHAwPzUCNIj02Hn/UuY9+HOpexpki5AD4sDsjkSjL8b2WjJASf4zDve5Wik/hdYuFVTKTm+AVziNldGOgG7kK5yjhENYuNBtbcM7LwHVsge4TXh9DocRijFC+cxvLSlUGulbu8w8OcTNbws5kCnSItCAalhdC/JogPZOR7+dybJ8vCJPGQlnyz5DeDcwGpdXmWtU3ffINr1d5En0JWa33aAcByYsBNA6lHJJr3YlixFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPXtIaN0EKSgUAyiKh0u20FaTmR27W55jEB9Ojj1mAY=;
 b=WI40dViXJJoNSIf11bcrTkl0pSPu70tvd2fzTmgdOgS4Z+cZpKhZXNSzRlhwxNvbdHK5QvYDuMNRr1dxorL4ZvBd6aW6FTH+etLXaQb9s4+ZnDczM+/D66z9rFPvEzfpMkhxyIYS95fPinNjQNd/JvSZJ2ncUkZRuBBa1bKya+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:54:55 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:54:55 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 3/9] lib/string.c: drop pointless __HAVE_ARCH_STRDUP
Date: Tue, 21 Apr 2026 09:54:33 +0200
Message-ID: <20260421075439.16696-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0023.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: aaaf6271-025c-4cdf-544e-08de9f7b46c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d+ONX8UzYEaGr7juRkjfyLVQwlkRUhKDWvKRJxgZTaP7za9Gl5LsBwH8nIYzxTzgWtcBguuGIGsLM2ZT3uH79SqvJyU5tAeYKRIBSFQfKPj2H9KGlkB72RD2ltuGK59/Ba89fx8Z/9hO//1yjOhQHsQxTTWyEnlAtR+l2kgTvElE0IXKoEKYkUTQwAMlsAZD3o9b7a5tAPwmbGohaVAbZddHYMtNolLpdFJSL2XUMMGqES7pbLjbCCOBDSiYVHsmZwmcBIKSXz3jWGBu4cXXWmq4i4aDJC9w2hAWrXa/hzMq8MAUskT3LjIGS0HWFbdjGBiLHH2aqtCZvZ8FOzo0puLf4/tia5aYDl0cd+f3fiMjafRhmeHkQbyK8iRPVWtvWAZ/4/plauTadO9tyezxiKP2pRUGzcmAA05zT09xAaSZ0deOc7Wx+EqmJGfakaIv+Spg7PYpt3CvLgVJ89iBwNWXsoBJMBCTHQ8xJo0ZN1LBJDXQ/Gsi0ohBm3Ap57HE93SWqkAJ7iBx842YbRyBId6inK6tjLkG6YwO6+sHEr44V0dii4DV7pUsHcqeEhr5fz4e2TkfCObN62qg0rtLIwfY90Un8K9FFtR8Z92zzktal0AyKk08wrge2ILH5blQENhRLh7YJGD1xCeqI2TW7W0c4T0tAkqnPtXMfWJWjsb7bWld3Qo3EL5qgFRkRk12zacJOe0BpCByGMvvMOCyCleqx9QJEn2OO29st2kDPSTa38nnJ7EoOZ3LEW9CNV9s8c+hF6yJrAqYeFDZJTtrCGWFmJFo0zW2d5X3FelL5vA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BGdjux40qKRtD9ofI2OWmhD3fD1nqtbmNxuP9i4eWvG+2dsp4eod0NKsiI+E?=
 =?us-ascii?Q?9pke9BzrZ2IsHu0kVhPph5EvdHIuTi4Y18gdDmm45D86l0x+0JJigPZQ28T+?=
 =?us-ascii?Q?rXfH9C3tfYhvR40mWGsQWFwJPDmn9/vS0FfdP9trMImPywNTKUNy+Y3yZEkO?=
 =?us-ascii?Q?hOVExYYZ6TpiB5qFtzqFus3/wNkegtjrkoLXoEYzXv6C6VzP5+0fLeI3m2uR?=
 =?us-ascii?Q?M4D+dlQrOK4Kp1g8aorIae/eP5gv26O7hmtTyUdmA1G95ihiYEq7Tqz+xrFV?=
 =?us-ascii?Q?113qAdhGROLmB18h60w8+0s2ONwZiD4wL5yXoak9bl0xi5KDhRcZLQudqIht?=
 =?us-ascii?Q?6O7aefiQAZigYSssENLhLL7Of4txAELy4HsqWAXz1iWhitorQwe1DghcP2kU?=
 =?us-ascii?Q?yoosh05rENsmSWSJlSsNh2NB3J2Q6blbLjM2FdI0PYkQkFvttnEkrnwNrGvQ?=
 =?us-ascii?Q?R6mFY5G9Xvg+uLN+K1Nh9V0Qw0PdvNourolw2Y9UlRRnEIwX17oX7R/vNdPE?=
 =?us-ascii?Q?7hGN5OKTa9yRnP+HiBWrRVZTHMQDlQDLKtwvuR70QzGRVHuQ7ByWK2XArfIz?=
 =?us-ascii?Q?ti7ot6ZAojNud1R9ZF2ND76CO5vzh3wblbNR2bEDvQbqTyO1ARC3orksmMWf?=
 =?us-ascii?Q?+uZWJTP4vqupz1Jb6VXzWRpG0ctvNf1MwwXyD/n0sHRQJeOeLum/8F9T6UPn?=
 =?us-ascii?Q?WA0Zyfxv0X7vwkEkoYhzN/mhs2fAr6bh4BxYT39ZMqP312gPh2bgEF1PSjtd?=
 =?us-ascii?Q?N9biHQozzXHIt09Lf3530gcAygy00in0dABBudvnrWtAzgEThpGAXmWj4nbF?=
 =?us-ascii?Q?YFmiIM++OZt7rzdtJ8tpujqMdDT0/zjtN39aZ5MiphArh0kKSRsufheG0cjx?=
 =?us-ascii?Q?TU1mPMp50GgnnhI8HtQouFrTO9M0MeslNmTw4jOIin3VKW9KxdMpOxNqrHvJ?=
 =?us-ascii?Q?EivbSO5GnDvzWRq3i3kq/sEm6nfXktMWAJta1d7GwEkPVgNHjyp/hvZoquHs?=
 =?us-ascii?Q?A1vLQ0icmhYIvcoesijq+jcFz04OBDGuLcnHAgHkIoMkhcfJ7K5kPoY4zbrz?=
 =?us-ascii?Q?KlpJncXfaiFPJM57aPvGLHeEwIgJOleJls67hWehDMh10BKahtaE4429fUQr?=
 =?us-ascii?Q?mvJ7cu5DmchxoAmKpqTN05zFHPoj7G70E+cKGVCF0DH6rCgiQeyZUdtCAAFB?=
 =?us-ascii?Q?s44tRxFEt38QtmiwIY16+mvIogsKCp4eTVLLB3rOzkCJPpHn8B0OS8S/Jq9k?=
 =?us-ascii?Q?L7bkExA6C7FKmgS3nFgAe5TGj2wyCenczqpUaMWFIGSDf0gx8dWuyRDvDNbU?=
 =?us-ascii?Q?ul0yg617QgUpanZh/L3oZJTnGCn3RLw+EhTQXNHTJ9yHAlrm6Vpmg5W5wcIw?=
 =?us-ascii?Q?xqg7bCg2M+cUsyVQ5ajDh3g+sCAvWdxtDK0gtn2vIQilKwT3J75wJ53W0WVd?=
 =?us-ascii?Q?i9M7//EaLNzWNujzw8d5TyKC0STnUFjO9DWR6WVhGdbgUkljkkAZYtZS7EYV?=
 =?us-ascii?Q?d/6u/PGgH2ljlWm8/d+dL5e2yMqJQ7Wt3tu/SKF82awG95DbREOownsyvgCu?=
 =?us-ascii?Q?nKLLn4dM1iqh+8DMyocYycbIq4ZgvVOcWtVaL13+jBEEt718wuV5bqxTy4LU?=
 =?us-ascii?Q?vrkH2LZE8PM1PI+izXpKMsFMpgctYB08mjcM7Rjn2xjTLkpWM8XorWCzqDWk?=
 =?us-ascii?Q?2NcStzFy4caLpap0kCkkbbMm929u5N/UeRpEa7IBdT/HpB05PWdF0SbYUZML?=
 =?us-ascii?Q?MtLQvkDZDcX8eIhdG1eXF01dhTXLVX8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf6271-025c-4cdf-544e-08de9f7b46c5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:54:55.1342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BxjDXZL5dl0Fu6wV4fhvRLAWg6zc5dh++Xj/WkNdlnEi04w7hjD0e4BUtW+xa2lsurHQ9p1r5iKwiVc1TbZwJUqua/nIpVpieLgpphB7mA=
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

There has never been an arch-specific optimized implementation of
str[n]dup, nor is there likely to ever be one, because unlike their
cousins strlen(), strcpy() and similar that simply read/write the
src/dst, the dup functions by definition involve memory allocation. So
drop this irrelevant cpp guard.

Reviewed-by: Simon Glass <sjg@chromium.org>
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

