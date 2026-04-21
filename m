Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1321FF327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D38843B8;
	Tue, 21 Apr 2026 09:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Zet9XffO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BF584258; Tue, 21 Apr 2026 09:55:13 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFD68431C
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSJ5gi5kdKI3HlPRdHqBTubg/8rrsRQpPu88uTLoYcLgIY92nrS0khd5fbAEtqVWjWuz7DU39WGXLiDoqWZHznolMs+jIoj9ihPSr341CtzcRi8P/u3wdV/HVXoHK7jrX9CZZLn1VEcvfmsHPLR77GErCH8yZK8qQ7RnELFGp/VZN00vCxKtm3Eyp3F26r3VFwYH0D2iD6Kcg3YIpyLAwvDRwpGcnL8LaxUy5I2NKAlYFz8RqWxR5oCsErU44ndPOlBTGf0xUSP2qTDyMrsW7A0awTS7kmb5putcxKV+m1dnaNjxYLv3d0421reW364WlS+2Eb/0sjz/Ptx/7nepMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwgjrL9btV9jhe+aej0ekP6fwmwkr3StRaJgf4XaKHw=;
 b=rp04Bea6Fiq99WZy84wd3mvlIEaJQlul+Fqg1YnOpA3yI4z30Eyb+cUk31mnGGUh7frBXKeCbn6dNL4NjFczyJ+fnZgG2S/12MBZ3F6QEDYX304amU2GN68dsVa0c06ejRLnaKtniAYQNT97UdVufMR1xMTPUMsocHtN8D5d7N+mn+xKKklHxfGepi460Qr2iUXxY82HXBd2D6j1dee7edx19Nmp9POHu7w1CWGeRWHUTz5Fzs4PnoDWS07ccaZKyxhuJoLbjzGTCf3KU0Z4AUdLHFdnclsEyKJzPnULzmup4zxMq7BYb4bz5RzUG4LHbyq5BAAUdDVZK1tnzZA95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwgjrL9btV9jhe+aej0ekP6fwmwkr3StRaJgf4XaKHw=;
 b=Zet9XffOGI9r6M8dhaoLaX/8Z+cdqNPIIgOGaI9WHsE7m7MM+vIroZazJkN08IaVKY76SgwU72R5/f6/05IpjFbpFsdBuL3It19grHUP2LOTqFTuRjPTxHmLnmOgXQYNvoNIkzesMdDbgBWA4qQUYA47if/xfoC+xmLvbnHIMKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:55:00 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:55:00 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 7/9] common/cli.c: use memdup_nul() in run_command_list()
Date: Tue, 21 Apr 2026 09:54:37 +0200
Message-ID: <20260421075439.16696-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0016.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d32c048-5760-449e-2094-08de9f7b4a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dRxwk8nfo1eOX9m6MsNk6+6KE3zH1/9Zcz9FiSvGSTiqgskon57K01ADMqrvXEJBc3qfNQL1eFsIU2AtIK0fzmDYc+RoOXWhWRylGpEoaJj8yaNrDcHS98qikJjNoGzviiR9aE0Gu2/YZjlyn8HzoUv9C+20dmyF4kNgPDLkXfBPdzMxaZay+du3d4qlPe7UOdOyOCkfHEu1CMhFCDPXLZ4uQMtbO3qIpRXVADMBqmmm16OQzcz2+LZmYfL+u8h+B9tku2wRIPO5iQO81dBdzF1l877kDjKjL4ORC/YDnrJc/e3uSO6w3hxynf9ljo6D+sNG109fpr0SkcwrTf/w65B/dOFUzRXT6T0h76QimKsbkRJ2RG9uQlA5sMl0J2QBgP3o4TZ/y44EtZtMZM6ZIL6djy55KM6pr8E8l/SxnUeLQ0SluI2e0B951hNXST6y5ObyxE0LUtB63+XYibNDURIQpNNpCZ5Az13Va4UyjfssgaYO6eiOWwLT9wr+X1VetGjNdqu99hgIWP+8c7Km0cY1IyJiV/cmNzGio/bSUKTrhAzekD56JpGzwHrlIwqHGSd/SsdLO8NJ36j5a2JGnHuX8JWI1l9HUX4bwcLG8iXHCgQQaYg/E44agux8X/w11p7v7jNz86L9zRtsSOnUxn0cr5HSfmQfX/q52JSSxzZig7ndXiiUDPHYGf+R+BgDZJ5m7ctceFe2CIzJVw5+VFK+DFubrgN8ggqfmVZZwyFOn6Ckf6vUX895Xx/G58s1b/iCgmcHyokRgD+nRB+QRR24iFLkKI/5YG1LyWStLss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xyLjjNMMHXni/nCwVfCh8DsfvcsjBcntpqigQkOPVmlbJDQ3oRGPoTWzVEKY?=
 =?us-ascii?Q?bsnQ8GK/zWjME20zG4xObNr0QGVEfwrAo/DK4T/A5gxYiuIPJL0HO0VcBWBj?=
 =?us-ascii?Q?e4cYL6BUV3Jxndo7rGOZeS8J90lj7f8e6LX9D2HL8Ck01WWnRbhVHbJCENR2?=
 =?us-ascii?Q?egWRoiThxCl0M3gCt3IeazSpkX35OCQPnKEjWkA6UZ1r6tPZHh22s6xrTtfc?=
 =?us-ascii?Q?edgRVY0KgNE7vg0cZdV2urEF3bkmCBB6kt5iJmIguJmkVAhfGZ3owZ8MLh5C?=
 =?us-ascii?Q?9OEeDWm8YuxN+ZT82kvFiQykegTij3nTCY6OUflH0z0RWPW2BIdrq/Sw7SBF?=
 =?us-ascii?Q?CNMMCzd0MqcKrO2ACZF37fpVoM30bXmD8F6VZR9sdvZKVJzfbkHPae2Ui44u?=
 =?us-ascii?Q?cXmQCc3mb1jaZRTkCiEaroZbRqEhIKs4TRuYR8rLr6D37f502cNtjeyEGTKs?=
 =?us-ascii?Q?l2thrUWG5y0E0yjRLyoE+wUhgOXrnjHB1yVPgv9xwog02f/6suqLy1pq+lBL?=
 =?us-ascii?Q?6mH+kvLWP7SPKd5f5eAjN76hvVD0spgroV9BM74unvMG0aL9/CBgqPRdx71b?=
 =?us-ascii?Q?Nk/KOJG7XwFX6poPiOcGpuBTyGh4xj9u/70peNhI39aUnyyW81p4N7XFQxKH?=
 =?us-ascii?Q?kXJ28zzm899qPirj8MprisJ9u702RK7Lr8VCxrGwOBuTBtWHyez7c/zsXLsZ?=
 =?us-ascii?Q?MhVUG2oDtFU+TFK/WH3pxhfkzqvLkQQb3thZ1vHiUa2n3XswIX+d2g0AU4ic?=
 =?us-ascii?Q?wFqcNaFCU3fPY1vRVhEI+/FlQ6S2w3ZXcmFoR4PPqS/KZH26Bl8EG1H8U4Z4?=
 =?us-ascii?Q?kTQHJleh/jrzKh0S/K0qBJmDWRLkv0e+KxlpvIL3vTZLI5gXMxeLncKr4rP8?=
 =?us-ascii?Q?E5vOvXmGphHUA1FacGmfwTILIri2tfD9koUT0toWNl7hL4dAd/QVLY06z2ho?=
 =?us-ascii?Q?JSfsnMZ7u06TCCerELyiMVKTPrWOfm6jnUIXxj4m0fp+bGSHFP8Hl3rvKJsk?=
 =?us-ascii?Q?xLJEnCkGwDDERwyvlPO+02KzR1zOZH6P5mJ2ZO4BREbv8RQeKmiqW+2/2LMx?=
 =?us-ascii?Q?xP83ODo6UVSduZk2yLi6gzyzh0wkXdcTfKkQBIjkuEwdPKf1aptzaMhJj+Jg?=
 =?us-ascii?Q?4aNNWOdix48HsvEZe/aVOukCQAMksf5QUkv7sotu30EL5vM+qqJhEnoo7V9B?=
 =?us-ascii?Q?9m4jfuhsMzBECvjnHhVBznlTZd3uQg3G+THIQ8RMGnOckCvCZk4JC95THsZd?=
 =?us-ascii?Q?jIKv0O4GM+frqRmHCEbqXiGOGj4Y4/KDE7EDN7Cc1lyRsJnYWDUm6rWH0VD4?=
 =?us-ascii?Q?4Lf8DTPWMk5IqdOhWkR2REYYlhliOIizADTAfELdmugsKWFq032MaglA/p6Z?=
 =?us-ascii?Q?SoQziqGkoqgPW9JH/hhSSrCjiPVxKPCu43kJKjcq3jCxhLdWnv7UCE5Wq4D6?=
 =?us-ascii?Q?GVdEnzjbV8Zq3G7ONzumzSGXBFm+OpLiAeb39WOh6NjERaPtD5OrfP894FuG?=
 =?us-ascii?Q?wMBT3LfMqpK5BAa/xoENc6+PZj8a2L3wKcKLsxrOEpAOTyVIl/Xg+TPjWjEb?=
 =?us-ascii?Q?/6X1jWyw/rZX2Upw7L9eApWCxeD/8JVGy5jwbWLJm5BqlKqqAWGu5Ub8aeKU?=
 =?us-ascii?Q?0/ooQQdM2NBMh0e6AUNu/DgUQ4mrWEu20MiJeRYsxtT2rznz0Jw10qvRMfgi?=
 =?us-ascii?Q?5eRymCNZlBVH7J+jRWS8SLDJ4MkCUfAWkoos6g9VQq7tcH+/j/grubrUYcCb?=
 =?us-ascii?Q?VYNgkgAD9e5wycgzeqQgwkzYX0QtAck=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d32c048-5760-449e-2094-08de9f7b4a03
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:55:00.5953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW62xMy+V0yliGfXpkabXb63sKNKT3fa2xONY26BZa47J4q38JFrSnSxzf20ddKBPZpRXiWqhz+jRkAvnm3imIg2EZbQ/A06MV5jEHW3sas=
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

Use memdup_nul() instead of open-coding it.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/cli.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/cli.c b/common/cli.c
index 4694a35cd0e..ccf7e26e821 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -138,11 +138,9 @@ int run_command_list(const char *cmd, int len, int flag)
 #endif
 	}
 	if (need_buff) {
-		buff = malloc(len + 1);
+		buff = memdup_nul(cmd, len);
 		if (!buff)
 			return 1;
-		memcpy(buff, cmd, len);
-		buff[len] = '\0';
 	}
 #ifdef CONFIG_HUSH_PARSER
 	if (use_hush_old()) {
-- 
2.53.0

