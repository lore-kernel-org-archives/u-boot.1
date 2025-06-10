Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5E6C61DB2
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 09:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DEB82B18;
	Tue, 10 Jun 2025 11:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FQF6mSdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199638070C; Tue, 10 Jun 2025 11:56:45 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C0782AC4
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsdRiHX/jMabeu7fTCH03RXlBNMKMieH9UtfypV/hz1cHFAT7IrMf3YcivtoeuaJJWKEyYlLvUAfO63H91oSsT1QN0FCohc1LWLfHYWaaXEl99g/XmHq3ZnJvB/wGL89Pi+cGMHw3WAUxC3AUhX6QEOPM2ZVUTe0BklpmaWOqWB65YFwhZEOnKP8xiKsBdluwqwS0VVbUXpaSnTuYAXRIWvz1FUiZnQ9J2tufJoJnmcNuOYINwjQQAZCajOZq1LL6BPkoujYcp+RM/FsjXdBm6RPoFdGeUFOktBJ3+UL0efugbqS/VxMP1JFdViICEcP8Bcdy8AJhIpxeTSXdFEtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbljTcmS3UGM9lIhUMPz2Yrsr38HFrNqK1n/j2Ca/eA=;
 b=toYCUWwLzIfrAcD0Hs5TP8a/f7mN/707GwVGU833Foaci3jp/ujfTLUPMLG1jqLlYxtQdTB0Wv11BD+M1F1Aa44UwDPmcdO1xiwkvcjLHdI3bfubrhPM709zJ/RZ8d1S7GBwy99EXQa7yTN2YrJkz3uRQpejHvI0EesLRytGyF8fGJ5GMN4eewEr53IBN4jB/CUSUHFYmMpF+HiJvKQ8DYr6Bp4ygcLoAU9d24AYk+wsr0NLFv0AD1qYgpBwX4cn+Yr86bnTnQ43hO1uuGxczAxid51eQzURNFWZZgzUYU0AojKIE7NG2ChsTiupXFjMmNZBaAsTayrfIZj7JfIlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbljTcmS3UGM9lIhUMPz2Yrsr38HFrNqK1n/j2Ca/eA=;
 b=FQF6mSdT4prebH8ubSTndyZbIDFhVEYtreKA0Z6A6e0KzVZLEGheVJ49qQwIM+fUwBuZDA1hyNqrYURVNwLSdtSkoQUWaL+dbOv5Qfbr8XL5nhRhKDXjiV3C2Fx4RbGyRNSWlsCtcmoV+tgvQsU+i8d1KQEeWp8Uyg5VG3uZFpdS0h/4rtZQ1D5N/QNZWA2Q8T7WavRxUqi8aLx/3hmNZ+pjQV1iLmD+XGZkqH8j5SGmfeZHgx8gsmVW3XSYSgDx/gs5w7f3lgWsww7v6r6Z2kJ+aNG9MhiVHC0whEaoyhcQ4gNhE09d/ykb5vk0RlYiN7Am0Vko/b6k17PYBIwr4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6343.eurprd08.prod.outlook.com (2603:10a6:20b:337::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 09:56:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 09:56:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 1/3] common/spl: fix potential out of buffer access in
 spl_fit_get_image_name function
Date: Tue, 10 Jun 2025 12:56:30 +0300
Message-ID: <20250610095632.1085431-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
 <20250610095632.1085431-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0010.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ea6df9-9f9b-4971-95d8-08dda8051936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AsxNMO6eJdYUBdxb1Z8Tj6G+MEaoXMNb70IwPn52ZAs2MZJq7NhoLi6wlSTm?=
 =?us-ascii?Q?kF/+R1LtPtZ3RlM4qzxw3jsG74FvqROK6kpJP0KtdL0JXtH84MOAsEiXYjnm?=
 =?us-ascii?Q?Tt0PHg3S261fB7F7VVQAzxWQPnYHclPFpocRhrZp+jrJofAgwnuScHdK5iC5?=
 =?us-ascii?Q?N7FKtN0zdGFLxuHEZGQ6SqhsAu+c3Fro42nvtMmBfQFTxEo8JSL3jksA8f7N?=
 =?us-ascii?Q?5GGI+uds/DmbWilTDO8qVD7yku81ZRDtfyP2fV8tOlEvh4Mc32CrmNSZBRp0?=
 =?us-ascii?Q?RGuE8CIQTug6aViUK76OQx30+oxBctbfIGYZtD+Ka3Wk7ja28/mZ932Uhcmb?=
 =?us-ascii?Q?FM1qAiOHq7dfq2I+j7F7/3ZAlZ5QkJyucUGJPG+vC+jequuOwrgvFyoBZHJJ?=
 =?us-ascii?Q?I512NdLlZFxaUEpHlNfTY1yaP7Z5Fmp66wYJyujG8bhB6pFUTR5750oOV8jw?=
 =?us-ascii?Q?uOY2Q9GTFrcKNiBF8pU1emo4VFKic4Ce2XKXsadVAd5uRRVXPs2Hk6yF/KMq?=
 =?us-ascii?Q?FGzFR50TSC0htul2AkOGwqjC2iD2dGPFsCRJoLe3UoSDiQMBRZiFtgT8iEMW?=
 =?us-ascii?Q?qO3L+7PLB3wU3o9Wc7QopOoJczJwd8HthJyoIBV7FT43WesNrM5KqAwK2gnn?=
 =?us-ascii?Q?tLkJoIoTZHPyabN/O9Q8UbeZAAu/iwbJSyIE66Vw3/oC6sm8diINDVfctlMo?=
 =?us-ascii?Q?u5BOezaSD2Lmr0XImnGYWe8aWiilddtGYYWOFKDtgpje5oa7TejwHX5onpd8?=
 =?us-ascii?Q?UkYugfCKBy1gJH19P4vW2UcBrou8hT3D+8eqZA79CF7ULdGxjkVEIapv9pS8?=
 =?us-ascii?Q?dMz/mIdsE/egRyfQiinDsXCALpgUQYFjTDttADOVVfWXKpzXKoKMVip8IiDp?=
 =?us-ascii?Q?yXq9BnpXWwR2W2yE04ibz87R/emzrw8mE4/ZotNmvme/TgixYYVoAvEFt4Ky?=
 =?us-ascii?Q?zhGzBjQAFyqDmObbwwWdBnIMKE0K5ArSaPK8k1Mbb0IaAv/L6ooqJsXTmnf2?=
 =?us-ascii?Q?bPEhA1YtB/QS7KjTvAorITd7cEd7RCZiLjkYKdMR8KLyy0cafzHR7m2x1r90?=
 =?us-ascii?Q?bHz9UNSOHmg3OFzaypqnRN8Mby+8A2teadGZmsY+5sQXKxbpK7xJK8a9pMMj?=
 =?us-ascii?Q?+L1P4/0OK64OGfDiSzNpgJ0G63FgN0XZbmh/ZtzGnjB+Dmg6XHzNQ+BLpkFw?=
 =?us-ascii?Q?QjPUTDT7aPB6PKr+5fIQdLvbSD+6B8CpGhHWEQGeuzcYI1uYFRiva59WSLRt?=
 =?us-ascii?Q?1h46xYdeo+QK10n4LDANGUem0MSYQTkP+REC0LB3czTwpKVmqBVBFboeY2qX?=
 =?us-ascii?Q?89Nj2pcPkBEM17geMTCizBS4ce4mNkbFRALYTDkB/U5pk5IcAdw7oYe2IowI?=
 =?us-ascii?Q?R1p83P2Vj13kRKek41t3Sycx/X1zAguYC0ulbbgIEmUT7cFuoLD4Ma1mMghh?=
 =?us-ascii?Q?ohLgYvhuxp+jBJOR4gZxy/cl9ZBivqi39baNGpX9qWfFWx0nmGrx+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OrRkoNnbsoVdiIkiwPTDtih4/t7TILeJXq7gPtUzVa2EGGaZBqNZQ7Ejk+ZF?=
 =?us-ascii?Q?LaoiATH3LWtwUuUYLe+ucGR+gHkv64s7P+1c69vqZm78UznxOkrYyZiOSsxt?=
 =?us-ascii?Q?Tf7ht1G9A6mtH1UtmomxG1uPFOTEEpeJMIJQ7pHTmy7kn2nsK/cG/2JB9M/v?=
 =?us-ascii?Q?tUWFblhjrkwulWGyA+HTUraFk0Yoj1FXBLDitvXdRz2s0ZpZmN0LhOLCR87M?=
 =?us-ascii?Q?ABMjIXJdTgjW7p79Bu7bguudMS/F+J32+MVo8OB9GHP7qjmFbxtmDR2dDrRG?=
 =?us-ascii?Q?nu+d4Z73/cBojlMv3q4GhplSU29CWMeepoBKcQdbejAuurZlX9+GdZvltrMy?=
 =?us-ascii?Q?cJ8HVcKZL8VrvwJdSedMHEbh87Crf1z4378OfAgr5xtoDBmXKlAUJMPU1TGn?=
 =?us-ascii?Q?QY9dxckQsdyyuNYkrbCnjnXpSk1OgNaOJQ91D2JEaTN9zJmA8FeZc2gLb4XR?=
 =?us-ascii?Q?pa+RVOQ68G7ExATqU6YnbGYvE29dLMM+aI0cC+UmeRCGRcOS4tczDGkVMndb?=
 =?us-ascii?Q?MUwmjSLZ+1aQ8Ldf5ewhoRpd+qiJl424vIN71NAeTYiUSwUUp+Npwsr+fcBe?=
 =?us-ascii?Q?4ioQ1w9tF+KpYGeEak5j3KVxV9zLhsE2oKI1aXH9llrH5Mk7BxPJwQu0yaqs?=
 =?us-ascii?Q?R3A5vusc4ANt7A5i5/b3/eeOfaDcJl6teKv2tVVzIzMfgF6z3xYB3WRzVuHn?=
 =?us-ascii?Q?vk2GP7inQcA0qRQ8ZvIefZLK/5lALJAj1Z1LIR6b05xUMe7d/bAIS3Ndb4s2?=
 =?us-ascii?Q?nb+VH/owbsSWQ6llp3LMLY+o4cFBqmblf1xbTzR3cUELz2Aqa/vnjrviKgst?=
 =?us-ascii?Q?qsBiFRwn1D6efTAwptLo4eAaKrOEkce+Zh8Zfg0S0m55BIiwXZX9Aucbk9Hn?=
 =?us-ascii?Q?u2O+4nFrgIzPjMTa+w9yuMFHmxTp4OP6Zx7JRg+x6KFzgllSQ/Z1xeFdWp2X?=
 =?us-ascii?Q?kqhaENKcUME/ttsfZBCAc9qjA3OiqHCGye5QfRWd6YX0m6HnbzP+vV9ljYnb?=
 =?us-ascii?Q?LFyXfQI3tYiZxBGU0p6fBpSWaXAtigpYWEmUMzD/+I07muAMMmmM6J05KpEB?=
 =?us-ascii?Q?ANZ5PiqnvX4eq5DSD+B2U45mrsi6xf1vMIE0AuRU1zaLemtdwRTxHkYJDpuu?=
 =?us-ascii?Q?uuHBPM56jq2S2Pwve7t7VJxIDtQm+FhLFz13AsyrxIXTk+Qc80QIpO+RlQ1t?=
 =?us-ascii?Q?J2fsTEbS5hXMe90PEeiyWXCEZf68S0xs0beY6rpNDSIt890D8tY2n9QoIzlK?=
 =?us-ascii?Q?F4utsnewkQHeKZ8KfTaEBapumk8zkC8lNT6IY7SL1T2FsBqoxPRkNZXgv3yV?=
 =?us-ascii?Q?PZkagZM2P9qMUuL73OUpkORLuFHlaXzyRPn4Gz2tAH9SyHAl1b0UQlMBU+St?=
 =?us-ascii?Q?nFg9SLE1Br264c8LY9T6pAaBBOjlYC7sOv88sdXx6euo+vp4L6LSUmF5RzSu?=
 =?us-ascii?Q?2LLepvobWN62fMi/oR0uA/5Ri/iCLyhlrEQvrJNPB3D+2Ooy8oYVMvs1SVZC?=
 =?us-ascii?Q?n1TU4sk5acDwitQXBfZPdQMkKJndh/I/SjW0XebQo0PwGftNr/iDAUcbKUBb?=
 =?us-ascii?Q?3m3id6Z8ZBsS0weaFTd6J1e/JVpq+oarjIsh0fFWN+NPIWeew/raPll11QGo?=
 =?us-ascii?Q?HmXALn79e/HnxHxwpWqwTQ0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ea6df9-9f9b-4971-95d8-08dda8051936
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:56:40.9744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7LvzuvPCsgeq5M12azruhn/A8iczkAB4myA7+7hk7x9MYe50W3cmu41j23YmV1fD5ZIB4295lKOrZDk2xgrlMV8+6RqGH9XTQil/6D8vgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6343
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

The current code have two issues:
1) ineffective NULL pointer check

	str = strchr(str, '\0') + 1
	if (!str || ...

   The str here will never be NULL (because we add 1 to result of strchr())

2) strchr() may go out of the buffer for the special forms of name variable.
   It's better use memchr() function here.

   According to the code the property is a sequence of C-string like
   shown below:

     'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!', '\0'

   index is the string number we are interested, so

     index = 0   =>  "hello",
     index = 1   =>  "world",
     index = 2   =>  "!"

   The issue will arrise if last string for some reason have no terminating
   '\0' character. This can happen for damaged or specially crafted dtb.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 common/spl/spl_fit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 86506d6905c..ab277bb2baa 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 
 	str = name;
 	for (i = 0; i < index; i++) {
-		str = strchr(str, '\0') + 1;
-		if (!str || (str - name >= len)) {
+		str = memchr(str, '\0', name + len - str);
+		if (!str) {
 			found = false;
 			break;
 		}
+		str++;
 	}
 
 	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {
-- 
2.47.2

