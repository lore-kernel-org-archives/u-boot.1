Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D044FC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4AFF8294C;
	Tue, 13 May 2025 10:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Tmq6tEJE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EF18091A; Tue, 13 May 2025 10:40:57 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C2C82AE2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIE/24XnG2rVDTVXvv983X0KDHl9/Osmnmitu1hD4cEQVHS1DN1wNHL9C+5aqmGBRd9TB6vt9aOi3oieoEydL24c8sMcMowTeSVjWZzcZikO2ccF3lUqLZgiFPnsT/Jk+jui84RfS/4jcojfDbv5DRHemINOsrI20PQXS5fiGXH4goz01awZu3MUeTRIEBmDq989uWpP+MPc6m125EfjVVlVoLFiMJFGT3E+KFlEoRc0KRiPlmwqAsqNPwU59QyOUjp7a1PNEBQP+AmNhTQxSoxbMLU04viRu4oSxtShn6Nx77PfQkNVM6JIgRTjd3q3itrF+7Up57DYXB5ilCEhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SPiP0hIIG5CdRCHszk8kz3xuTT4VtdgjvCiAejvgss=;
 b=nRCXX+Vy+a9MjJRa2i9XzVtfiIkNE80KDrtVx09ijiyNe25hjHGykeEK/nkSr3BW2nWZSaumaxff3FBRMbNUxF88dquU6RLMXwnq2j45bje/lDz//oDEoeLWk1/E7tERQzfWZOPhJd0n1rDyYboxHEhUQQjaewUGU1xjvFmQxrIStEnj9VjT2TNgQ67IkVZnGl6lLz8Z4E0BFsqcMwoeQ4O7A+Twrdzo1TBksN3C+P8cJnGJR3MH+9YUhEaEMwfO+noUx470jvexgeHdWRIIQJi8yW6NQ7BZhNpNVO6aXx3QvtVpNI63+DLwyYRdnork+FM/oaA7C00B0C6HZj7qmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SPiP0hIIG5CdRCHszk8kz3xuTT4VtdgjvCiAejvgss=;
 b=Tmq6tEJE3v/486DSiLEF9qTzsLmCg6VAPOWjcwBL3V5l/WCzn9JpyFTwkbAm+hUzvXu6xnozX+GOzKSkwJrpmtrHS61E/hPSYEbFXDrRYEDDARjXqZ9rK4Qhr3STFeXudYC8LPhNAGt81u7Y4eNb2zbLfz+N+c1T/yjih6nqzfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA2PR10MB8720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 08:40:51 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:51 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 11/12] test: slre: add tests for character ranges
Date: Tue, 13 May 2025 10:40:33 +0200
Message-ID: <20250513084034.654865-12-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA2PR10MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 159c9d3f-2f8f-4b59-648d-08dd91f9de09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PHMqHza1UroQN69PJlY8k1FLHGOl3G3lXNqgx2HYBewetztKKhlCp+07JowJ?=
 =?us-ascii?Q?xbjTmQ4Vq0UtaSyLjQsBxo16clpBQj7ZhURIDRxh3BPMUU444DJbBJiRHIKh?=
 =?us-ascii?Q?gGrWq3V0Vi5otRH7dhHI3Jlxz//cOr4JSlrOwiHhd8ern9zk6SfAeawFrcxe?=
 =?us-ascii?Q?YIHm9Fn3XXs3IWVobLSuxKVuMNzknIrzI3F90LIYmlVWL9hzFwJUIu/xT2Ch?=
 =?us-ascii?Q?2PkxPsaQUR2BTpx7KLrQiVHJoGfOMFcT3SANTm2ZIL9YJGYkWaRkVt+DTqNk?=
 =?us-ascii?Q?4ecr3HIHsjjr/5N/L6yDQ47bDX2RX3xI5sO2C9lySiVO0yonZ4HZ0nRNfuz3?=
 =?us-ascii?Q?ESLA1+KaJRmk8P7MKI8M2Vu8IeVvA/4YOlO1kGzFyQp7Xz6QfTQGseWC500t?=
 =?us-ascii?Q?vuXtgjwVppT1EG77Y8/qWsfCnzYl4pkh1vww0ju86Bt+ED8G7+QaQU9bhad6?=
 =?us-ascii?Q?6iWDJ6ii12g3acFmK1M2i0SguP/E/nICoEhzTTl9H6zXiM8+0yMhSJRjTjnH?=
 =?us-ascii?Q?NnGdJBkhhF+LLB2iZb0cMOZlLU6qRI8MI7OEi1KA4UOaRl/nnah0wt/H8jSm?=
 =?us-ascii?Q?XSic70BFg4C52yu3Kn7HXzuOL3p7mhowliOfsHNu4UE+4O3rB8kyrV5bQkzy?=
 =?us-ascii?Q?SZLy3wQrkahWrmyA+refKT1mKaZVGPzSRZK/578w7DcFvyqdD0Xu4DdC7+uo?=
 =?us-ascii?Q?5+c8VGeN7XyuIGGZHkqEip0pcVXiv3TQfVfngqxmJ7p95+nJAtTTIdkvBTKQ?=
 =?us-ascii?Q?MW97U3tXEam8GujuYDdqaQq4gfNfO2MJy62Nttmd14SMYDmkXZbH33iFFrEO?=
 =?us-ascii?Q?0wbxQTKow+pgC1CFYxzPXoTEYkQQAsAgnPagsT6nQWtJfPYNepzZyLsFEuJe?=
 =?us-ascii?Q?qNY4YjzVEMt3xmit4ubXOPJPd16vCb7R5SVxaCgOHacdx53VHoGiqpXA4J6e?=
 =?us-ascii?Q?Z5wPo9JR9fGQGis4Yq8OJdpbwl3LvviMZxPh8+Y6lSBAQAektYn1gvDWt/kQ?=
 =?us-ascii?Q?zavU77RFo2WKftYJrNXrM8xM3GLTAKU1SrfqdMFxMrFCMoeCbQrjByimoQhd?=
 =?us-ascii?Q?cXDr7g9anYBFThU7Mx1jzJGCZfEnPFqKzKG1h5Poqb/tDXjLsqyGLRSAJuVD?=
 =?us-ascii?Q?rLoQH9E+u1YekGqDUWa0BwhxGn9cLF5+ivbEQjlrYBTeN5Yu8uIhZTo5mc8g?=
 =?us-ascii?Q?cbfcVqDkY7q+8UsBxBTMSe3fCUxYE2Bo07fQ80bfdcHj605roMQ6boIOEiT4?=
 =?us-ascii?Q?W3eb/dVZ8wOVZayh1FDZvo5RR8C7ZJAkdhYDFI6+gCBIG/i2kTSMzfShw3/A?=
 =?us-ascii?Q?x1ZBdnmPdkt6mlGX3xVfwJVEHfYbiJwn7X1ZlqHHlsZAWpB8hx/7+AxHk3Lj?=
 =?us-ascii?Q?scrW/FsooXXEFwxqlaF8WzD68vfrc5ZMXVFjgNyEut/FCOshMy8o2P6xpJPG?=
 =?us-ascii?Q?eR/gPmq0kygG4CQpHAtmhW8ZIO9hMl8L1qQxjVOFn2UiyyCX+kHDrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HefcGstEwdoPwzG85H9Avb9h/B4bMoB3mSmzUrGhoarsPrTX8M9r3etfEoLG?=
 =?us-ascii?Q?0xLnyxGZkzquj3ynSSJX5AodqWqtrb9rSnC6eepKhHipJT3f73JVM5WjcMgo?=
 =?us-ascii?Q?eA5jdOIop9kH1JBlltCzhzTLDJlZbVQZ8aM/lYS67nULth8L1+WVT3LvqNld?=
 =?us-ascii?Q?yKg0k9WuTtBoBN4j1XyAHzmLHz6r/XRDTD7sZtlV5xmWo0vOxt/uFTcUmcCZ?=
 =?us-ascii?Q?KYXMFjEnFltH0RkxnKpRVS7fQbPpdaD9J9g4NqmdqND2Gor4f9dv0r243IJM?=
 =?us-ascii?Q?C1psuDZzNnKSl32p/i15FzTvlCvoTvGKqDzqms/KGSgfcNhB07fKYtCYXcQ2?=
 =?us-ascii?Q?uPvDlM1Kls5YnwCD0wXmWwoObkdF2wRwQJiayykKemhgVHgw2gOIl+rxuT+M?=
 =?us-ascii?Q?ILfzqt62xCGf8nRjCXkmnK1KQlIkS2MK88OwJSy6VUWbcBlMO82RL/6npqDS?=
 =?us-ascii?Q?dw6u49dUaNX1ADpuiCi6cEtt0s8BZdS2Xg/xu/Rt7d/umCB09U+zQCXzc5ua?=
 =?us-ascii?Q?tydVtsBLHsZ4HxL2+UJhgzz5HzIN4qnHfHoWAt/lm7zTvTFxNTPx9cVHdnBP?=
 =?us-ascii?Q?TLBCJawSrBJM8dWN0iKMUyfi3SbWyfUhvkHkG248xYN8cvP8LyGW232+zLKk?=
 =?us-ascii?Q?yzzVjjQA9YMu3KrqEaIRBXsRskeYvDZQR+wpUvtq3ML6iLSeLOZPt9uzHwC+?=
 =?us-ascii?Q?MNPAh/shTvAI1SIld0zuEBPNOtE6mXSD/bUtNBnfEqlE1dKGptzAXXUm9tks?=
 =?us-ascii?Q?Jgbo6Gv08wjWN04Eta3v8DRl6qnFWK4zDaJ9W8zBl0nti0+PyRbQt7zljHvM?=
 =?us-ascii?Q?6DiAca6VwF7syBumfm7UDEkEbkw99f1oZNsoEYwQKD7lZ/z0SyyOwrNwMm0w?=
 =?us-ascii?Q?daW7TlnpQ/kkFgwEF23ZG1utFMCUCHPDi4wlZXhcp/U8utQKeZW98snk/F5q?=
 =?us-ascii?Q?pVaTvHZvWJt80AYwssNflrZBlqOlOHHzhz0sIGrj+OgKL/+cw5n+IrH2a17A?=
 =?us-ascii?Q?QHs6T9CQYC5mFNYKKFPF9/Ss6JAmWheCGyMpkYC60G2WR42+up06YYItXK7A?=
 =?us-ascii?Q?0iInrMNk7rGdG5TE9KD4fIelTpGkUJ3VH7pdjFb5oP1othyXXnNezTmj4oFc?=
 =?us-ascii?Q?SPGfGdKOzA5D+1mpnVQ2V86yEGh3V7F+Ii1dTyYrzNCwGKD4TVwf+cOPk9dz?=
 =?us-ascii?Q?zQG+QA6l1ULsUekp4c/GZCSDtSlmdgv4AJlAiUEKl4WI05Z8ts9CQCWTCRZK?=
 =?us-ascii?Q?xQ2ja2qj/uyFmg1ocvFKUPyXhEbp4wQSCHAeA8aChNFpYGtXxo7kSlLMV9oa?=
 =?us-ascii?Q?1+s8ln0yCz/7CbQqMdHKG/X03PmWS5PbHkjWF6yOEhkU18Rc7h1f0tCia1SV?=
 =?us-ascii?Q?rv0lr1slme6J+vKpdZrEd0KNlF5PwQAth9bpKEPcDehn/4i3JkkTcPEYRFEX?=
 =?us-ascii?Q?u/0AYgrKtvkfZ73bOQ6kR5js6Wr9137ikTDDGnQen/7eCjnGp9h/2EPfbQJy?=
 =?us-ascii?Q?bFfWm/hHClFU0MbFRhzyBB/BIdPKIrckIiGg0f1j24jiWh7yaoSx1DcxCXGV?=
 =?us-ascii?Q?axlj0O/RaVzl4mXZ9SsES5ZICwLAaAnNN/+5uBN319Yqf3nuQL97wGWiSTb7?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 159c9d3f-2f8f-4b59-648d-08dd91f9de09
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:51.6094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7OMWvzAAnta+ZEHiq11pXE8j8jJApS6sVD5kNH4tZBkOiuIdHGUeB0LwpdIoD/J/LKqZFlePkQcI8nFLrg3VxyVidD021k00zg8K21E7fE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8720
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

The first of these, { "U-Boot", "^[B-Uo-t]*$", 0 }, would match
previously when the - and the letters were all interpreted literally.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/lib/slre.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/lib/slre.c b/test/lib/slre.c
index 053d046075e..ff2386d614a 100644
--- a/test/lib/slre.c
+++ b/test/lib/slre.c
@@ -29,6 +29,14 @@ static const struct re_test re_test[] = {
 	/* DIGIT is 17 */
 	{ "##\x11%%\x11", "^[#%\\d]*$", 0 },
 	{ "##23%%45", "^[#%\\d]*$", 1 },
+	{ "U-Boot", "^[B-Uo-t]*$", 0 },
+	{ "U-Boot", "^[A-Zm-v-]*$", 1 },
+	{ "U-Boot", "^[-A-Za-z]*$", 1 },
+	/* The range --C covers both - and B. */
+	{ "U-Boot", "^[--CUot]*$", 1 },
+	{ "U-Boot", "^[^0-9]*$", 1 },
+	{ "U-Boot", "^[^0-9<->]*$", 1 },
+	{ "U-Boot", "^[^0-9<\\->]*$", 0 },
 	{}
 };
 
-- 
2.49.0

