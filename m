Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DEBC83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 00:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DCAA836D3;
	Fri, 25 Jul 2025 02:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="EoyTVKhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C02A8838FA; Fri, 25 Jul 2025 02:21:48 +0200 (CEST)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B217983666
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 02:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S39GbGhzsKp0LZjFBIzJey3TPzZeqL+jZpBlNOTej59/JBLFvFcJLyZbKR0Md9SIyoPJUDXxre1ZI8crn9wt73sOUw1dEuOycN6JgV0OEq+AqAYcxHwPkEbKbz1InCYJcgEhlDPMqQvm619YGjksFT3sAtVyf773x5w+Hw/3DrehloCH2dVox5PUztcxKoom2I/x0Gco8KiVeiv/cophdzUWlSCOyNXxs5N2kZux3EqGgjpuKxcmngP7+TKEGLPtBM7D9s2CflrOAJXhxGPKlEcvL0F7NkmA9CZFigjh88cTeqPoeC0VFYeo/Ig7sc7Xg0xQc5SdPhLoHVp1AqXIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyNxOHKUh1Iw6MIZDmS1tUXfZLQjJi1+wuULSTy5w3k=;
 b=EViWGLSrZAlIyfr3te5YEr3kK91i4nl1hNA+o4ntsq8zhlQOBo/yZ7vUKoUq+mwi/O+yj/NafGRkKyRrGPUsote7x+ojrPJ6XMnauS0RrbMuVyHMFVqJW15RYXTC1SVl7bdELjRHDyTm3etB/Ayeyk/sJgwqQCQbWxv4UV0JBSyGeQlLQo5xG4JopNJZgvwRzvSGCe0s+QJts1ClnSuH6O1DkgFKj82p3DsfBKlkbnOuUWKf6XGToX9VqmsrlxuDiuAZ3uyX5dgiU3aZhziKnpfSoYEgoZvhsylLGyCI757xaEx+4sdSyGjLyVoQuJ5S5sfPrSnvqhoq4cvci/STbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyNxOHKUh1Iw6MIZDmS1tUXfZLQjJi1+wuULSTy5w3k=;
 b=EoyTVKhnct+VgWlTN07hVUitEQVimnCGovum8JTZueuYKN5Z1DEdgZNRANzYVGKT+qObUfSwZaPKjfYnHZMghAdbiD5iUQOcN/lCxDAvjMB8KnAPaxSTjRmfW53Xi9eJowwLCe9+KPJE7MuEBzFmsncQPtbDQCFFo1rR/5WXueUjS7mTK/pb/wbX+fO5m/aN7m95WlzM0EXVRGIc7avdGtwG4Enw6BajLkV+Xsh+iGIE3JQHPMqtgDvlQfkoxFIbQaJ0JOSgu/KfIaNMgtJ+DGXJoscjO/jHBx73jQDzO1E6yFFnbhMVdIdDB+5BRYmsGo8xswddsnAcsccZp9rjlQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYRPR01MB16229.jpnprd01.prod.outlook.com (2603:1096:405:2e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 00:21:43 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 00:21:43 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/2] env: mtd: initialize saved_buf pointer
Date: Fri, 25 Jul 2025 08:20:45 +0800
Message-ID: <OSBPR01MB1670F35FC517694360204B4FBC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670E56647F1F8B4BA66A931BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670E56647F1F8B4BA66A931BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250725002045.7673-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYRPR01MB16229:EE_
X-MS-Office365-Filtering-Correlation-Id: d74d0772-6f5a-4566-17c4-08ddcb113b94
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8022599003|19110799012|15080799012|8060799015|5072599009|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RLJbV68dX1tUODBV8StCmaZBbcLPGpsYBlVukrU6Wvj+Bi1qJGGN+X8WfZQv?=
 =?us-ascii?Q?Xq3aLLhT7uAbv9onitJvETCTjXdTSTlzPYyTxmYtCqOALWIorG/ksfqsU1lZ?=
 =?us-ascii?Q?j32dj+ZtLYeTRWqAlxMW7RFHM5w7v02JWpahp4kQ8xp72qteb0M3Ptgm1t2/?=
 =?us-ascii?Q?H3hkhyeK2uRsLdJJbkRUroCZTW6CY4LIwYGgEclVLZiYeGMxHoD0fNMkUMTl?=
 =?us-ascii?Q?7JMpCaILm2SbgHjUvVbAS4xKKZx4ZjtQkD6hy3c5X7jqLMnxfM2ZybAMS2LI?=
 =?us-ascii?Q?0SJXIgGPi9e/AFrskd4BKbiyZP+GEkRx0jDCj9YIrptYyqcmzV21zuTcjEbc?=
 =?us-ascii?Q?EJeord/eADy1ipiJ0Qfw63WVEFjRUp50GGjN9ACv3846wghU3ROwnlK4yp7Q?=
 =?us-ascii?Q?aSveX0qumKpAe4vn9EEFg9SlfqWi+e5/xnPG4vlqKZS+8pYPF8S7p9fuxB/k?=
 =?us-ascii?Q?8OfwR4QBfsgbI9MhrApbLrv/KCz/+zYnE7hHwumaEpngflYFhGF0T76nRZAi?=
 =?us-ascii?Q?ZEpsJbP4HKLp4TdZ9ir3mgfvowF/2IBH4VQUsycesXqnORHnFgN+0nHVK5pG?=
 =?us-ascii?Q?JRtuBrNkjvnx30GgJZ0OvHIvVnW6LG5oQTPCqyNYhdqrW9zUfEfSyiGYlcDd?=
 =?us-ascii?Q?a8eSCWISM/cJhOrUc/llRb2wG21KbilpnEVcQuxeXPDTcy5roYcoa/GqrewL?=
 =?us-ascii?Q?Ze4PHf+IB+FkFE09O39cIm9PyjA7WFau94zZjMpdFDHS7/OW5dKM2ATM1wbf?=
 =?us-ascii?Q?LybLTCzTlR43kSxxqOUbfsrnWAvnpeoc+gv8wtdejcIXxnEvUepHkc0HKiLe?=
 =?us-ascii?Q?qUfYW8zu1BpHQQyCMS38a47lruwXkUE2j5NtryU6bJfYtpLsfZ/VLKTh55lt?=
 =?us-ascii?Q?GR4J4vuXIeGxoyWoC3/Gi45E0g/7Zskd6PGj9ldA78cwp2UE/69WihoKvODx?=
 =?us-ascii?Q?yb2i8aX3e3bHqgYZv4fDRxLCYCJ/+fzWdCMiSOrM/E+YR6jPz0Rt/OiIekKJ?=
 =?us-ascii?Q?eQm9vrDwMAxb1GP9vEO1X2hvKsQs0v6+2QuQXOgQnmLTFKqDyo+lTYPbE/nY?=
 =?us-ascii?Q?gNvhZVJQbyJv1KsTzNIZV8B65NTQ5GukA1MHwzPEnzfVCAM+RAGicL/lh/ho?=
 =?us-ascii?Q?lpp1/OGqIKWxHjQsaV/1TFW4B0ClPaw2gw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YhGNjVL9v1mKjsr336jfy4otFndrGwzoB78IFFu4HtgM07KWulIMo6atpc0?=
 =?us-ascii?Q?rUjTaBQW0hOJ7wRjN4X/ZdRMotJWKcRqCQSkvnbk2TY4lT8M1nocssYV2WAw?=
 =?us-ascii?Q?TRFU8RvJNTaBfzpGsl7o+WSg7le8qwuGeKf9/YhU2MXKRQxBv9CcKYvyE8Yf?=
 =?us-ascii?Q?1ODNWgib/ww0qUfxkxNRECG59L9C4/9nqojatWCd9IRCrKE++v31f2X2A8BB?=
 =?us-ascii?Q?oqD1WK2kzbZzXsP8Oe2LOtrr14t1DP6/bYOI4T0JNWOoqX228zS6DN4pdZRO?=
 =?us-ascii?Q?TStmEmgp9FlaBrZje2Af/TCAQtYAUPojKj9Al9M3qm/yf7bhAWJwa87J121f?=
 =?us-ascii?Q?eB1IdA+r+3HYS6+2U2nIKc5p+JfC7W0zdLA5NAQwdMWxJVMPHJkMXCuvK/i7?=
 =?us-ascii?Q?NX1lnfQ+E1pXdWQkAdaBc4hGlvOFaBi+Yyu8UXOVBAG3T7YNTcSBIT/gNyYL?=
 =?us-ascii?Q?bCNGSbubAXw+CWulT1b1OQBS2CMdYgwSJ1IbZ9j4+wXaBUKrAJlz5BC/5G6U?=
 =?us-ascii?Q?p1P1CyX0jgPS9kpddjS94JcKqZZvpdhEZaUgwzMhPdHTDokSD1jGBy7yPGWa?=
 =?us-ascii?Q?mVmjAgsY4DSGV8f7NMvIIl+OROcxHtrWBGCBSHfsHU2hC6Eo1E3OBJT+kZVs?=
 =?us-ascii?Q?UW703j0JqezgrheqpLkX7GR6REaW8xvfGqhhO24tTILhyYsLvikPKJdbOaTy?=
 =?us-ascii?Q?tIgY4kJBjBK7EayY+ENz7o06/RyG5494GTSeWmJFEYxt4SSCTXap6briCiAL?=
 =?us-ascii?Q?5zYFgYwkCPODMQwB+fLvsiHUzA0QGF/7ydFm4hTFCYsNAdf5pc/oE+7QJFKp?=
 =?us-ascii?Q?9x6GBTwO8wgF0QBqWBP3EbKneWlAKcR4RSnS1bMiP4BbmJcCoVHm/BO+p33z?=
 =?us-ascii?Q?G2pFdEL6mD3z6bsEXp3/9KytQAf7UNtJf1t8tMAdBG1PDc5wRbjs2iwhwpmc?=
 =?us-ascii?Q?ypzmQ6PArcsC1Zkb1bDogZi05iU7wBoJ3tiuuuSNVwWNslir0VSKE3xVCei7?=
 =?us-ascii?Q?6epzsM7qScTgB8g8LldwbjWCdq/MnswK52nTMky/fgedmuC4+Lh1kQ3bbLmQ?=
 =?us-ascii?Q?i6lY2AmOk6xaHaU9q/k24UmNt+5H+5Mh0kuidcuxgoTDMq26ijzZr2jGdRqF?=
 =?us-ascii?Q?DQdgrPsC9m2SyVMw7+lw8g/RXLFSI3RlgUMkxj/y74GuFw3w7V7UYA9Kop+m?=
 =?us-ascii?Q?scB4K2n8rVyeJyd8VCvN9w1cEY3S4n8znPNyZHyjLlbnG0CcbI0s7kr/kd8E?=
 =?us-ascii?Q?MXbenIP0MjjLGNvImlMV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74d0772-6f5a-4566-17c4-08ddcb113b94
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 00:21:43.6500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16229
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

When sect_size is greater than the CONFIG_ENV_SIZE, this wild
pointer will cause CPU halt or system crash.

Fixes: 03fb08d4aef8 ("env: Introduce support for MTD")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 env/mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/mtd.c b/env/mtd.c
index ad263ed4b29..b26ee80985a 100644
--- a/env/mtd.c
+++ b/env/mtd.c
@@ -201,7 +201,7 @@ static int env_mtd_erase(void)
 {
 	struct mtd_info *mtd_env;
 	u32 sect_size, sect_num;
-	char *saved_buf, *tmp;
+	char *saved_buf = NULL, *tmp;
 	struct erase_info ei;
 	size_t ret_len;
 	int remaining;
-- 
2.50.0

