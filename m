Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5332EC07C79
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 18:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2218893D;
	Mon, 22 Apr 2024 20:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD63B8893F; Mon, 22 Apr 2024 20:18:18 +0200 (CEST)
Received: from PNZPR01CU001.outbound.protection.outlook.com
 (mail-centralindiaazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c408::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C668488914
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 20:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=siliconsignals.io
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=kishan.dudhatra@siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jS2qvKWa664WEUh1YluGBN8VDvpaLDLMVMk283h9DUnsMNAO6nSvgB1mhgZj8SmyjwcgcvgaqHh9oRTJmZb584jEPoJU7SvROcRGvz2Aw9MQfQhRlIsT7nPlb3NgHwAiRLBqapFdNhu9x3BB2n8YATGM1UyX4HV3UpWv0k9BWTBmjkksZM/WD7Lf+AFzdtvjOwdSuTCpUAjZyv7sIisLVTqKjLX4uTI+xWZd7T34vQrNFYZ5+2+ROJReDxznnl0TCBbWCjJkPG/QJsTRadW/CvEUC815+LYYwwWENPFn3fQWF/wQFmyP8toIU8PtS7YvYnODH56eofGqwTnlLT2qiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8UbFhk3ShPwNk61ADgCpBDKXkUWuyjmzXTxZ5oGCu0=;
 b=IHu5YnrlRP0Tjj0+V7fl+PEl/2Mk6G0Xof8dEK7kCoNZvm/S1z3VdBDFeHPKZmXFS9GvxTLGuY8AzkqZtcepcA0r6kmsUadYsXRbzd1FLUbi0zv/ibUbY75NZCicBmbAHZAiMUkMbPAtaOQgvDQ5lyrbG0rwsoztBA/eLHZf6ySZ4lPxJXbPEnMEeyzu8vZ8KyoPUjj2E9SDVSxz2ZxRzKWTLZ+XIl9HktGjuafPH3nDfiankdlP3lfnsPxdiZ0jAjOxwG1Vca8jWV8/KDvPp9egeGz85kd+dyEveDsG2huwQsUfy7zIU8Gbj5Mgw8XJzzQWb8xfaCIeuWv2SPS4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a3::10)
 by MA0PR01MB9530.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:18:13 +0000
Received: from MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da4e:be76:93b8:e469]) by MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da4e:be76:93b8:e469%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 18:18:13 +0000
From: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
Subject: [PATCH v2] cmd: gpt: initialize partition table
Date: Mon, 22 Apr 2024 23:47:33 +0530
Message-Id: <20240422181733.179881-1-kishan.dudhatra@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB7912:EE_|MA0PR01MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b236c1-1556-4929-949d-08dc62f89272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0FMTmW7YQfwMgu8DzL3s8gbIzQHM3M2FOUyyaje/n6kxsHve5s0+vxkhHVPQ?=
 =?us-ascii?Q?B6an/mP7UtLBtsgvQe4OjYE8UBat4eDBgXuAeRq9FH0lMLCwAyhll6GifNrp?=
 =?us-ascii?Q?Q/IyR3v7eY708juaAht5qaNXwibA29imfxWSfKEP+yDWWfOiRGNRllX0qMCG?=
 =?us-ascii?Q?2L4nncqMi4du1G6erutMu414gBQTOWxV70GRV3avsbiT9h5dkRHj0VtpE3Wt?=
 =?us-ascii?Q?dXnR8limJdAuYStOxtCyCRwaSJzS51kKW6x1Dz61JNRfvYhNISpoAaS9Gcan?=
 =?us-ascii?Q?37X2ltu4gBNz9ejbWonvV3kj6n1zs3Kv038zXSjY2O96mV64snyNsktB6/P5?=
 =?us-ascii?Q?qNd2nozfNIAhQopovDuygJGormrRPGGrpd1BMYVMy5zsOsLw8NQqeNbLMNYv?=
 =?us-ascii?Q?Ai9zMTPUFpUyQRv2J7KZZwtDgCA+zLMCndELkWQmpB/knQ/q3zdnkJRxpNtP?=
 =?us-ascii?Q?rjYneJ6ocRLeQf8o9p+2p3jKy0zaNPUqNUaMGUeGSQpo9Mc0VVas9g0q6U5z?=
 =?us-ascii?Q?5fW8K475C9XSiFX2yyyNchyt+ht+KTGSjllw80WsP6Fr1U+6ZEU40UrSMaWc?=
 =?us-ascii?Q?faCIGvcL7V3clgSwvM9FmAzC/5S3p0JbDPOjCXgmh+R8M0dLfiMSdiacnEST?=
 =?us-ascii?Q?jtj8hlOMbIeVEtHDl0OdgbmAnpqzCANeNI+EtEy9KPC6ecbu5b1WuUYqS6bi?=
 =?us-ascii?Q?+d81s44MCYPm/ANZybAIArDDuSSvUubUGK1AQuP1ifeSlqoUX24Y7+u58PV5?=
 =?us-ascii?Q?x0OeY5+9dpuETe6g+IvAKipbI9a2NxUdd97RmbDsFdDxTqz769P10z81x5bb?=
 =?us-ascii?Q?3iMcTzA5Lj3MBnuRRghK3Eo6Uyk1IlyO64NPrum5yoKOtMR9p6JCvYJkn6mg?=
 =?us-ascii?Q?++cooCCHEHZlK5RVl3myjrqtPysiEAr9HMKpWcqzBI7ihB4Fa8JWTH1Hy03E?=
 =?us-ascii?Q?xlJBYnWIh3vEF0i14lBEhePjXhNkuV/AFEMa/yQ+rOoSl6B8oonGCEy5Ow3R?=
 =?us-ascii?Q?IXyMpyl0F2CyJ64EZzDvEO4SALW8F6RG7Uiaqpq57HvIbMXZf1PUqm8lYEVT?=
 =?us-ascii?Q?146AIIn/SX71WK5/tnHuJt2mLM6Ym3NdaKqkioqUYIKEmzzycBheb3IyaqcN?=
 =?us-ascii?Q?/eQUV3uJTGP4KLaWKTIke3ZIBfjlQk2c8VYbtJCOh6MtRaFs+2UcymCiznhz?=
 =?us-ascii?Q?CDG7UzNBBtp07/maJxWeW0w/gsy17c9qpGTyK1qFqMoAETGwEUToSLcQc+6G?=
 =?us-ascii?Q?OCph1Ao0MmYOSWVWzM7CDdzxVliYrkv33jpXxTT4JJ6xaaoP67BLr9uT5IXX?=
 =?us-ascii?Q?WV2WxUj69ylmiNVkLDFj3r0o1o89pDaHk4FPGUjAK+zW9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(366007)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VcTz+gaU7Sic75QmRLsJsJm/7m/35uovjNPYE4OVytFoWivgpNbWdlKNZ8KP?=
 =?us-ascii?Q?UgZqFyfa7gycW9+LNidNFkYrAhTDoxsbqiqpwRhqmeOUFTZrOeKm5sh/GYWB?=
 =?us-ascii?Q?u/xaJRlBQLwNZVic8Q7PV3G7rDk4SEukzS834pNlqasjNKa3UbWMyKvbdYY5?=
 =?us-ascii?Q?b9aukdrIZjsJCXYwWTnSZ307mgpiFyHBffoiB9aFAtL42h7IQubEjivqYTid?=
 =?us-ascii?Q?dYvU9l9Ms8NLK2AqUcs1G/lDz5VAL8nuymmXaBL/V6i/QgOZztSOmjPbwbzL?=
 =?us-ascii?Q?zTFAEdS3rIdebrDPmRII3XjkwC2Lhrl1DHqD4uCKdCyqpmbX5Z5FHZMIo5rA?=
 =?us-ascii?Q?2bZZCMjRbeU5Y8DlWs5RKGYuFaTEypDRtUM5vHJQUXTeZqaYGvGh4NxjVr91?=
 =?us-ascii?Q?zqqqJq/iZqi+T9gLYhln3Ak4mL11FOUgedcMapnA5/MqbZOkkYnuWNH65X+X?=
 =?us-ascii?Q?uDevLFm5vuckj7tLTv4zjgrl2kqugqo+qCV0Z4MTAaTVxwc4dwzGh8rxWR0x?=
 =?us-ascii?Q?UZStSxR4m2wFDZ+EgIop9YACJvxurgY7/428hq9H149bPkMZU5nCD2HWvxSk?=
 =?us-ascii?Q?cPCDYy5+zfsCvo1lbogAfzsA70+b666nulFGIJfpz1xmi1220Vz237jKLbE0?=
 =?us-ascii?Q?v0RwBQgnlZwsPNWXGUbll2J0Q1u+6HlPlLiKr2bBoj5oAmT4xqyn/Dt0r7DW?=
 =?us-ascii?Q?8WeyZzBYFQofGFRHIJXqll9npPt/azKIduNZEtissekRmzrSX2oHpJ9QRM0F?=
 =?us-ascii?Q?MyHojjeXJmCsTFazhwgqlja0BvnY6HC7ibizDgIi9e68jPJLEkLycJaD4DRU?=
 =?us-ascii?Q?bFRlp9kzsyxee90fRrUbd+9+fQSZ/J4AdA5H9oVjTWPsUIWePNqCqZLVsyaG?=
 =?us-ascii?Q?MGcJ+J72cpTP1Z+nNiL1ylKULfXG6baNjxOut9JgtiC7Wi77HF7LZa2VUw8E?=
 =?us-ascii?Q?V/zlNhvFP+TTp4vFNLJe9nLvxUBiAxBMjM2TJe0gHDLSOMW0ssE6sP8wtJ4f?=
 =?us-ascii?Q?hB2IaODJMrAX+gKTZ/Z9gp+KnkMn8CLkkFqQfG7BPeMaqIW6eJzkPeLax2Rd?=
 =?us-ascii?Q?dOArkKzvN8lTaO0IYoCaOQJyIz4wCbtmjstY3Ru67S7nbLJM/J2A3lft+JtS?=
 =?us-ascii?Q?CmzsLx8XqDoO26uS8jJ4uNR3h7wINKazlV1TLLCXv3YPRwLQlHiHu+Prxl+N?=
 =?us-ascii?Q?rz+6ihIEshaPlEviE11X9/+ftauZa/4Fy7nxmfyWgMcHgbI0fEu932eoY8tM?=
 =?us-ascii?Q?grM8xl9dBbU4GkI3PD+i5AJ+/RW78rL/B/EFpJ7iIaKWoJIEriMTvMEXOdiX?=
 =?us-ascii?Q?YfYfVQoobvTzn9CUungKi++WBIkXn422MfDVb6h5nx/3N4Gz3gCFxKUAoK7P?=
 =?us-ascii?Q?tYgTigdjwfw8woQYOaotXiftimvoBavpcy2O/ny26jcauVDiAgq/YbJk7MjE?=
 =?us-ascii?Q?mFcY8BUgqS3N42sdwWhH5olxL3DFqGe8O+34bNiUU5Nz/xfIeSeeJShANSV4?=
 =?us-ascii?Q?qld+fTEgCbY6hSot4xCQkLxZIvXgzL+38EkEFa0l7+SjttxTDIHGumwqLMSU?=
 =?us-ascii?Q?JGOAq5KuprreY5ido65B0SUS2xBvTG2B3o4rLIGOzbZD09TwvqdZV1Kidl22?=
 =?us-ascii?Q?8BWwULbJtXmhCJXuT0ZLxN8=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b236c1-1556-4929-949d-08dc62f89272
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:18:13.0437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyY0ReGwFkojbrR0BA/o9ZucoPbd6mzVtctKZlxAn4NpXr/dr7DEWJ5mz65/7LEmolpIAzgcqyT3X9neNnR36HaibHH2Yam052MEMjGbcoBXWafvIS6YaQWAytUOG97e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9530
X-Mailman-Approved-At: Mon, 22 Apr 2024 20:20:24 +0200
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

Change in v2:
	- Fix applies to all block devices, not just MMC.

If partition init is not completed within the gpt write,
the gpt partition list will not be updated.

Signed-off-by: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>

diff --git a/cmd/gpt.c b/cmd/gpt.c
index d7e96529a6..7aaf1889a5 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -643,6 +643,10 @@ static int gpt_default(struct blk_desc *blk_dev_desc, const char *str_part)
 	free(str_disk_guid);
 	free(partitions);
 
+	/* initialize partition table */
+	if (blk_enabled())
+		part_init(blk_dev_desc);
+
 	return ret;
 }
 
-- 
2.34.1

