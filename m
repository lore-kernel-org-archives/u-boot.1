Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1327C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076B682A8B;
	Tue,  6 May 2025 16:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RnD94O8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6617B82A36; Tue,  6 May 2025 16:15:29 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 403FD82A64
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKprI4wMeyJhc2bWNNlH4MaeofUUw4fNaNPpZ0+XNXnMmZojEPmwPcNvn2dx914KIcqyzeQ99iVjbhN19bJdb14IMkuGAcfoGV7hju9/fEronco8DMv5RIfwVZh5J8Mb50dBrnmCJkqzMPhnYS94b7M7ETahMS4LHcP01LjeaU6dPnJXuTvk6Jr08fYM6FlnB++8ZccftKhBAmgJZtNtHAqoU7D7h/mWS//x9BSNLyNAYPlpiL3QKIp8s6XRgIq/fuOnJXbXcRLdCVIEQWPe7SiMFnGxhw5c7TFoAr4SzFJJSjTiUXt+P38gd3FzXasUm6BdDcaHnYeNkuPuC0o7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4kYVHaZBUfdTwG6WcC7vE0TMTTjjf8I4KLOS0xpB3s=;
 b=Y/tJ69wSY6c5snrA4kCchsH28NYrCib1Q4Rt3lzTvavdDRf83jsL35K+E/FJtPFsN3s7zOCmOLXrJeVLHWNvNWjzy76ZZD/MbNGL/HBETKmQ8u0ZCaYfPFRtlLmO3EOVAr9RYDXM3c5fmBm996QNvRbubmySqzqfc6e7lfFUuI0Re4ttpUmOL/1MuCGwV2m9629N2cn1hX7TcjkFmZjzxfZ1m+A5D0Bhn4Sufxn4hVYJNFvIGbkeiHpbXOQaXfvyoBtRhh7F+7cYP4mETJ6XUQx4QUB4QRYT4xDPuI8JHudd1nhimcDfZS9OCVnBYlNM8x603HkmW4NfJt/xhVBCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4kYVHaZBUfdTwG6WcC7vE0TMTTjjf8I4KLOS0xpB3s=;
 b=RnD94O8O+Ld2DU+VQgb/gz5idoE5vNGwIJkHtnRhNqcC2rui3qKmwXgUleIaceIBvWzVRtbMV2CUb+7nERLzAMLkqpwEFXxCF7b+hzUbbnq2iluTwSnJ/BqqOmmGZjZvdXhp9eN0VAiKh1PRjZ0VhxOlUUlMujDNRXniM3QIGnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by VI1PR10MB8208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:15:24 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:23 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 06/11] test: slre: add some (negative) character class tests
Date: Tue,  6 May 2025 16:10:30 +0200
Message-ID: <20250506141035.385756-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|VI1PR10MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: a229ceb0-be2f-447b-e440-08dd8ca87126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZUdGSgAPfIlGkK7ZylkzU81MAfziRSvrfDoMZSZ47BQJQpTwSxtQm58Fequl?=
 =?us-ascii?Q?nv5QHWHUY4GHh3LSt75SqagxJT51nc+w0PIJTaSmHyMxrvgg1c5JGf89LcUc?=
 =?us-ascii?Q?GcrgVbMzOtcG5A6/Jm37O2TNyfVYM/KP1rzsUA0nDhOHlESc2e0ksFuV4G9d?=
 =?us-ascii?Q?l6d14U6XBeRUZX3WpFfGW6U3EwdBU9rSb3wZ3NKrdneEsO0mpFJOdWJrLnvY?=
 =?us-ascii?Q?yJsLXv3FuABzZjqmEeEqEa96aepYkn8T/QV0RMOtb1T8atFzvr77hTkMCoEp?=
 =?us-ascii?Q?niElao/FVPICN5Y8HTKkbGF0VTAP9RnGsjNlufPjccFn/5wSEMSb2wQNTqQu?=
 =?us-ascii?Q?tnp5/KnmK08ujvip2Qbrvfag2UqJpk9BNUrsGXXqqB98WFOiFauhBRVDtzlj?=
 =?us-ascii?Q?yWnuKO7XcoFcMORlVZJAdta3i4eIFaW40ZG+T8zQF/LMsw5Yf7FTHxIMg7NR?=
 =?us-ascii?Q?QFc2xcVD0u7J5AmcR8y3PoeL0ZA4g34k3Ants+gEGO7XlNQLPgW9uLx55SIJ?=
 =?us-ascii?Q?pNolKCzs86PQ2DhauurvVfxvRIfRHVSQ8d3D9U/9yNSpLOqKi2IMGDwynbLM?=
 =?us-ascii?Q?QPW1cOVIUDAxHf0JYpwSuHIEju4SlNfyQfp/SwH75oA5VhuEZJT7E7DrpRYi?=
 =?us-ascii?Q?6qjFl2Ng9Fsn+0ml3UfIgWOFKfzJ7HTrQ6Ls6+injWsB35dSXOOvOCLlG2lE?=
 =?us-ascii?Q?C2pT9xQZXk2Tb/if8bjswuv1iAhQEzqYzonoQBiPpm5tNpWlE11Rac5O0rgG?=
 =?us-ascii?Q?zcQ1viSKiD19Dog9HYU0OzYF+4DCpLWZS3+QArkoNtGYqt9rTFkAASBg894b?=
 =?us-ascii?Q?if7iZ3LMAiA0efFEnqm0JvYx3jBlK4TZVLMp3wsp/WauzZl9cxC+jVU9zMQ3?=
 =?us-ascii?Q?w2Q/s4kc0qzxsF8jcJXAqXJQJ/zjH5gTFECCXd6HgQWtoROHybOSQh1BwDCn?=
 =?us-ascii?Q?+0AUIUyJHjy2ornxJH9bHujc+Bp3IwzVsTIgnb5HWeoYyvDvRe4c0nkpQhWx?=
 =?us-ascii?Q?eL9f60V56ywvd7Fv1fB9wgOlWcoJEwGURNGRupSr+ylCmk7Nt1wr6Oxqj6Am?=
 =?us-ascii?Q?Xz+Wab1TYeMFmfTRt6OHn7Mnk0MjmZ0esGFcCqDUorwN9Y5DLh/nYxPYn4W3?=
 =?us-ascii?Q?s61dbt3WfDQIwDtAZ/b4cz2CQ9Y1EeO0X4o/w6E8jdXYn+Yq47xxeIqJzpfJ?=
 =?us-ascii?Q?pCnsR9+QLe525XpySI2PeFIDoQJVF3FGL/YxnYVsnUosSPdTdmFSY0P78ELp?=
 =?us-ascii?Q?8n/5QwwJs9gPPC4kSGNoPh6t8MnbA3LHpeKAVSOF2hegnfXXtjcX+fZR/mDz?=
 =?us-ascii?Q?BAn4y5319pjrYIfghQrFIBfD5GviB/lKoCd+Afd+zyca3cfnAgI1xpW+uz2g?=
 =?us-ascii?Q?nL7EbdxjQuJ7m5n/2wfCkMDzN6jVPIy/20SHUv8m3fpQrUv1Utp9vJr4G9A2?=
 =?us-ascii?Q?7SAApiD52WMWrqrszwdIhFtFOsKGeYIE1jA8vy59/KR6l77xu2JVtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gr4RGIUSMhHyOPmMZ/ie04NgnwqJut2krT0VFrjBONPRO3KV+B+3Oh0SEW9?=
 =?us-ascii?Q?OAIUYGaXdX9ujXgU1pKUAmbF4P4aiHGfFmRISffrbsK9huB44k61UhDAAI5/?=
 =?us-ascii?Q?x5AaP8/MeHLNRbrEN8SIi7gBAAQEo1T8G7Dl8gYjSupheMsEQlK1zvAV3TXX?=
 =?us-ascii?Q?9aSGRo3dgzg32Vo2c+FJ2ky5qA6Ck4hp196lGrL/NsViGOe5E5tpNIGy+FGd?=
 =?us-ascii?Q?PmBCfoj4EmNkfq/rPWDLpkqc0EIB/N9TYTCXS2PGFhkmyHk8PYwwZ+tvUqtj?=
 =?us-ascii?Q?WMJp0Zr1it99CMSd+v4Xju7wXOu2Ig6MeQ62rJ1Qv+n8d586rlchj/CvCkSU?=
 =?us-ascii?Q?Esr5LKCIDk+oLGNCkbP9AaSFbP8UEgR0s/m367Tgc5TzJTkqEexj4dGf4n1U?=
 =?us-ascii?Q?DSoEj4Cj2MDVE3ogAuQbxAYCAduytRV2bazPYQQqanXsQT2+Wb39B2ap5eVh?=
 =?us-ascii?Q?e3WV1B2vpf6yuD6Crtl6ugwi7TuXD9LvaG4ecAYl4hRJWytc+YMlhW+QurDE?=
 =?us-ascii?Q?znpK2tP2wS2t9htha6hN1KSDT1q68QXSw8yR+oo/iRhcY02OG1CE0HfrkJDa?=
 =?us-ascii?Q?5wTql6yGe2nrZfOJzvpywGTg2q+VZ0YepvcyQ6QkLbWZvxbmGGfLvViq60Bq?=
 =?us-ascii?Q?E2HUmjgzCQrLN57YJCPsdmnPucXXOTns22z/EzCylmwpYn2DIsOZkKGyzizx?=
 =?us-ascii?Q?Pw1pZArvTrSHrIJCNY8JZrzIvYkRUVzci7ALti3KW99MhlF0lTQuRxJZtsfa?=
 =?us-ascii?Q?tnqdo4xx04gpkbynuYScn5XvSEk7xQo6ThZJc8d9FaVyCNGQCljuVoeCp8YH?=
 =?us-ascii?Q?q1zyGNgEtKFA9PN4kvbO8sLKQoWt5W5IOiiPWwaaBCVHLFKgf9PGjadpc4vC?=
 =?us-ascii?Q?SA/gjp2KgW7XOWvcbpPTJfUPZLxtSurxXhS9XppgWDvxkeSliktEsefSbiDM?=
 =?us-ascii?Q?BVJA4VBbuwKKcfU5F89bk8VtAlIXBZywpLAlmUEXnKQdgp1zcunbPazNciUn?=
 =?us-ascii?Q?vJimuucOUV9VtQuKon6w7TOB6StZ21+98pCedhawEq6A5U3/nUazGO3YKaBC?=
 =?us-ascii?Q?1N32mq8KWHkCmqtAP4zkTyUMeAkQYzjmyw9zapsVOLO78wqMaBE4xqffkKYT?=
 =?us-ascii?Q?RDyodDBIAOt+VtFcPQTGJ/qWMu2lr1aaWcUN9RBPUeXVCpIMft8JWEZ5Cq7r?=
 =?us-ascii?Q?zboPaEtBj1+wbuj95nJbcl0FIpHmU4LE4IQfyhBEIz8bwSkXbYwJQ6AaBUaZ?=
 =?us-ascii?Q?9IgHWsyBxXea5aCR0/FCXs16BzNAg2hDc3NLI34POq7J/dUZ0lv1xXlBuZpm?=
 =?us-ascii?Q?OcuomB91eROuiOhK+hyuy1+a8Dxb+0Ko3DNIjyja/wsBn1axCHSUumFTNaHk?=
 =?us-ascii?Q?GH3chxag3oIgGE7d5exufOzK0FX4ONVrQBfm68XR2P8UagzkbybnCDzk8F50?=
 =?us-ascii?Q?0FbM8EcTjv7txwvV0r7kufkFPfWz3aG+kOZaCI55CGTDyvHdFlE/rwETt4k3?=
 =?us-ascii?Q?Or+9KWN2Df6iYhyltGNEwmk3rk+rbPMb/eXCoKj4gS2UNuUQtKKQucVWKZnK?=
 =?us-ascii?Q?SQ4Qod7fFE3i2eeOBqHvi/ZDIuhh6QYZy/gN+vAYEXi/tV42L0+3SbTfy4qh?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a229ceb0-be2f-447b-e440-08dd8ca87126
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:23.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjqpG/o1cCc8ApiPuvmQN213U5ny1bH6VM+VrxNFrOkmHgFUOzHm2qoIF4tJ8P+zC+m6FvgqxRFJZb6EwICCbtHkBjTImx4ytHmPlXsSl+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8208
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index b76d33475dd..9b41ea92f38 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -23,6 +23,9 @@ static const struct re_test re_test[] = {
 	{ "", "^x*$", 1},
 	{ "yy", "x*$", 1},
 	{ "yy", "^x*$", 0},
+	{ "Gadsby", "^[^eE]*$", 1},
+	{ "Ernest", "^[^eE]*$", 0},
+	{ "6d41f0a39d6", "^[0123456789abcdef]*$", 1 },
 	{}
 };
 
-- 
2.49.0

