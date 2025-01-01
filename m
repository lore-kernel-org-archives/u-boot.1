Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EC6E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 03:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698E48021A;
	Wed,  1 Jan 2025 04:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="f16ZSavz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 073B48031D; Wed,  1 Jan 2025 04:20:33 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F86B80196
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 04:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt5OlxByL6PgHiYtmxOa+LkT+Ad5ZzSmKfEUDV+RFpxWHp9tTm6LcI0uZURagVxfk6tZzdszOIim8JNPCzB745TwAKP7NCtjCZjKSn4uArXISoSKGVM+Ow6R6CUKU0OnkXgDfGNtK5q70TTraNKn7Jym6/RSlbAZL1POBIHSLfFOyxzM+eaK4HfIlzaPw2qdvmhm8IdhWcClHXdeQKJUGwdzjcYkxclu6HXnx5tr5grXCuASYaaQn2GKEwkxD2g+RbmGJdgtbzoToYBe+hg1j7DSzblfhVh9b0swAygBLqhA9O5tXNNgnL8DM4AiwtvYc6FMsVblwYRCTxfduYfMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dqmHj0rbHoJLKz9yLBdnpbAgtFwl81DpCGCeAvoGjk=;
 b=S6c/zde56HDv79qtT9tlZWo6t8ZT3RHXUnnlCm3GCOcwl5aGarUxmojDdvQF+8XxqDLNMAhufTkTA4k4xuIBPbKOtguGyKIFy9TvomZe1RqqC4hmFVdsZsmuzsKVHzFVEMvl5Kt1mi9vKhPt3x+7TWJFblS37ko7y7ktzzemxI48s7Ky9VMUnelafSI3BXo84DJLo69hY1hn6UAUWAj2eoRnMkaa4yoyd5IjCjfsyVj1DBUl4Vpcm7EYmvFI2yMTltKLNHMII2KbFBpNGNpRic4AKBvw70VZ59eTNqwlQtYorvN6DDnvBTI9OLLDdVmPhf/jLyitFdJJiFUkEQ7Baw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dqmHj0rbHoJLKz9yLBdnpbAgtFwl81DpCGCeAvoGjk=;
 b=f16ZSavzHN0OhaSsUPZQoPnFZTFxuwew2FfgJHO/jQw6fQEp5u9wT3pxGEDUnwdzBsQ/7iE4Swg2Q94PWeATuJHd+8U3Bk0PVv0dVePGzk+ysPPPMKv3gSl6cZnNCLYdkmaq/h70ppD6KrFL0/Ih9sKraYiSZFoeoV1+w3hWvFUSAlBd0Pp1SD4i2bPGHg147LW2ztH9XjiUGL+2ZMuvtQAqL2V19+zIcRaSXffjixPUZ+SMsSavx7D20zY+JGfSYjNEII9K0TsKoA/FiUBY0hpmzvkhaq4AV95DdPGSxXsLw5xtcJDnZ7Zdb/hufAfJXshKKQl3LW/C++aPCWBHig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10228.eurprd08.prod.outlook.com (2603:10a6:20b:648::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 03:20:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 03:20:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2] net: tftpboot: clear timeout_count on every successful
 block
Date: Wed,  1 Jan 2025 06:20:16 +0300
Message-ID: <20250101032016.438176-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 451f62fb-dd49-45b7-d8dd-08dd2a133b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ycFfvLrgXF/ZmO/5Vs14jM9YatmqeJLBjBq8TxGKMDMpp6NyH9LNqp7GDEHl?=
 =?us-ascii?Q?cCtwd6En3wskCbTZzWiLODfMQc74Msf0neksHgl6LsbggQfb5z6kHvvi4Ty1?=
 =?us-ascii?Q?HvAoLjw5giA5SBpekOWVutHcCOyorusnJpLFvBTfED+4cwyq5ac/Fv9cjzoF?=
 =?us-ascii?Q?REciALZvMKS9ONNg1/9e25CX3Z4anC8ZWPre8huSyLdd9bqgEQsmr7fnvPg2?=
 =?us-ascii?Q?WEik1Kqvx3SZ/AkEPVpXlOlwLtDhjAy6JJvm0ndW+GA3v3BSrPooc4+AAH4E?=
 =?us-ascii?Q?e6tOXTid6ohpFTA+pBo/C7GS4bk/ynSLwmUtLfmtN5zUNVXkn9HvCZGRu7sp?=
 =?us-ascii?Q?Rnc+Aq0RtSRnHagE7pwwncJwOg03B8QoEO3gfnPxfXHbQt4obY9fqnLHbD0n?=
 =?us-ascii?Q?OSBMG0VivTbt1o6Q3YmlBT2QW0W7SAh+avZFxVFKKkllkxdEykhDHvTDscm6?=
 =?us-ascii?Q?hhwiPP75mehiArJKXvzcufsnAmD46LHgmmPjj/0QNxvZDJOgSUgVnu7nM10K?=
 =?us-ascii?Q?U76PrXLnEDX9FcpJsP3JCDvZNn6vvt0UOS3SM4mfTRnNySq54TS1oZQr8zpN?=
 =?us-ascii?Q?6OAtKFi5EaN4FOGVJ1whzkn/+81gSH1iFYBGraWPudyx+6CRpgeJ/HQy6p9p?=
 =?us-ascii?Q?ukXGMhS3VGmZi5TzGNLWIJVxSWwpXu0VtJ1bmVlJm1yZqSQXuWyec1cSV+XZ?=
 =?us-ascii?Q?w6q3vNrnNlNiSdQHFlaUVSK1DqmAgSpi+yLvgftFvsXkGhAUSCljIyv7h/+1?=
 =?us-ascii?Q?+fyZRE1pthXRmtu34SXQnTbWYzsaW4xTLwjdWWZHtzPbtpkiA9WuuE8WqBKs?=
 =?us-ascii?Q?Jabo6IKkPTPkL7zh1Puf5WASL/+L3A5A+P1ywbX9KxL03862Bjc7OjXw1a9Z?=
 =?us-ascii?Q?DsiL/9LSfjq9Ugk9hY5ZgdhSXAQSYQVlFLJxvUBnLnd7ZwUB7G9fooAjjwRt?=
 =?us-ascii?Q?wjv9vkOo88pxQoHeoGuKAUN9iC0Fb5q2rR/xOA0zmyPzUMPXUgOmAWngsKtZ?=
 =?us-ascii?Q?qiWM/ZihWrRLmN8g5/RYafMZc949Mxx90dhke8AGqny7io7g3p48upSILZ1o?=
 =?us-ascii?Q?6lHUK3E0BC7q6rRbKAv+Yeo5wS3BRMpGu/iGkcodFr0rN71Q70wAowK4/WC9?=
 =?us-ascii?Q?dyxoBhWxX83tOg87+D8oZS2HFbireF1X7cObI19LZGa+2W0xTYcqCMYZyfma?=
 =?us-ascii?Q?6MrUd8hCWiq6nstlvOCEOmwsfiORmQ/LkOY1kVKy7OH5ToekNFgCGdzF5wLP?=
 =?us-ascii?Q?bYnsZF4YoDaZ2gMfAaV5kLRhg+le72kNu2+MMHNnL82Z05twpE87e8M781ex?=
 =?us-ascii?Q?tpAq9fsDpmbK47tR6AOcQocqKhsDoc21xAo41pSBfrVqimsN5z1VywaeXTjw?=
 =?us-ascii?Q?zuddC5XOlKTxbUS97N852OuU4BNvX0LyH6fj33uLAlC5VOfg58RqEZ1WpaEu?=
 =?us-ascii?Q?9dXDnUl7DO4Db5MKUmq4EwdSDa1Dc6I1SeAnhIC8PAVjU+MYeG4ffQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67cH7DysMwuPv5NV3E+112OJA7XOIIttuqi8q/Ulwoh2gVi13eJ+ALDg1+K5?=
 =?us-ascii?Q?grvoCnbkPsn6JGs0yHTrYT9sfC4kwBxwMf+E6t/+q2QNPhl9Vzrd8dTlvs4/?=
 =?us-ascii?Q?Nyp+BGtUwBYPj+3N/H1ucCFv+ET/zHFYuwvCowAK8Z+wHtiKeTJ9ZbXGKF8C?=
 =?us-ascii?Q?B0aEj2dn33b2qKpCxXHnMSPM2I1V9bFjYf3mG5k87UFUADKHN2idnIH4LdqR?=
 =?us-ascii?Q?Ck684PcW2hZtpOPb83TjgiT/J6ey0agD4IRiy/3RZWoLSW1pzuIABMZSnxDh?=
 =?us-ascii?Q?eEVQDyCTJaC+YpKzbYD0gIhEaSALz6Hwu13IveF0Gt48WkXvvET+tdaU5+E4?=
 =?us-ascii?Q?tqZq94jhyfS+XNoNrS1srq7RZE++l+QUG/nDeGFUd1BSuFj6HCHkS0CK3vnL?=
 =?us-ascii?Q?BlHZboVHS2mPIqOa/xNF8Wx5ti1AZCjIUlchc9M9aRCDlhJu83ZVWZffzYUW?=
 =?us-ascii?Q?MdfP1x1r1h+yN/3cLtJy0SUBaG6NorT9GoF+gwGN4KHLsZA7rETBNWN65Ib/?=
 =?us-ascii?Q?LGBQ8IDlAaoqIxDIAJfgBTj7jf3in82R+dojk86m1RWerlDkif9yImYO7FTs?=
 =?us-ascii?Q?hQA4bQZAS65Ta7pF4s6Ax43zBwn2RRjOwEWZ3FHIIdv9+DkwwVjx8QSsSWh0?=
 =?us-ascii?Q?5VPdzzrpfd6pXAWNiMNM/kxVzauGrUKk18JPWT+tsJvbxCGDsSmT5U+RlHgl?=
 =?us-ascii?Q?jHNC4BH6t/VPgT51J8yd8YF3JKzEOc26r0ENW/HWbyu0fbS1sQuNm5wExj/A?=
 =?us-ascii?Q?Q7fCN0LKH0RshWAqxANEY7ttmZmnrgf33ufcPye8FX47b+TuR6O6gBpmreeW?=
 =?us-ascii?Q?7zvbQdJD0bEsCzSgiT7q8r7A27owYGTbGun3T1Ag39Q7tORX2Szuw09bXF4T?=
 =?us-ascii?Q?9MkZSz5ZOwGs+8HRT25dMbDmlt1Ogr4Rg7Rg99XisSd4RM0ogyiGoUWKl3NX?=
 =?us-ascii?Q?8yQivI7W+GW3wFxZv71Sce7xsmrD841a030ePTXIoPuNHQRCin3WvgR+WFwK?=
 =?us-ascii?Q?COWnNSkjp4egoU1cghH4OiXLnN5NtC4PuMezZu7q9snDCtS2aA6LL2/QSW+A?=
 =?us-ascii?Q?Y0hqWrWKNUBpdqz83zmIySvdFdsId3/4xR6F87Ka0jLFhXvYDexm/oAU2ZOx?=
 =?us-ascii?Q?jOWeDa3ogaD48fCavwiR9l8rlmFuBit3RhaSroM78KdWdXsn3Ig5cbmu6AI1?=
 =?us-ascii?Q?axx//Je+b2nQowEhrR+TVjl9vqI5BFZlE9Hb6U+OKs1CeuVSCMgLckMfZYCq?=
 =?us-ascii?Q?U3UiCa6TEAfrikvKt63BI6K5PmcDuv47bbahOlFAci4iUsP7aruBdIMU9BL4?=
 =?us-ascii?Q?5jNGXDRcoqzp+xAwM2aOiTlL6EURJcvnf6JtqBPskIh2h8/M/PAryI8vtatz?=
 =?us-ascii?Q?niHZJ7C2mZ/qV/1vrmi1V/7gs9aqpF39JT6QzSV4AmCMpBiUd2Sgl7aUUzMq?=
 =?us-ascii?Q?VujMUiG3yVELmYQjqSCW6Ee8wjcihc+WExNM0J//PGfvXdD6CWFjpGTaVoc3?=
 =?us-ascii?Q?vlCUA706O3SCK2nn7/P3dj5mGv72/5+BGjkXM3fJz8LUkVwTBQGHZ/PU821p?=
 =?us-ascii?Q?0KeJq0lajtNHJaA/3yZt+BSVCR3SQZqAZQ17KCSnH/I03nIsfCV8LwuHWceH?=
 =?us-ascii?Q?HtHh9wdY3lKudXvDafhOBoE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 451f62fb-dd49-45b7-d8dd-08dd2a133b01
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 03:20:24.1278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JXyibjCmPqKbRqCNBXd1YkuNrWYaZW4AxlrZOpuzhAvrxc4a68x/hVz41uWpXgk9j+bhej5j8t4B7h/F4ICd8qcdmG3e/gkUmfnlsXqnms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10228
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

We have a some boards that rarely starts networking abnormally, so there are
many timeouts during file transfer. In the same time there is a normal transfer
between timeouts. In this case we can continue transfer (instead of connection
aborting) by just clearing timeout counter on every successfull block.

This patch does not affect the case when several timeouts happen one after
another. The transfer will be aborted. Thus the transfer will be
continued in the case of unstable link, but will be aborted in the case
of inaccessible server.

Feature downside: it may greatly slowdown (instead of abort) file transfer
in the case of unstable link.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

---
Changes v2:
 * update patch description

---
 net/tftp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index 704b20b4ff8..8f948204a6f 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -498,6 +498,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 						tftp_state = STATE_DATA;
 						tftp_remote_port = src;
 					}
+					timeout_count = 0;
 					tftp_send(); /* Send next data block */
 				}
 			}
@@ -657,6 +658,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 			net_set_state(NETLOOP_FAIL);
 			break;
 		}
+		timeout_count = 0;
 
 		if (len < tftp_block_size) {
 			tftp_send();
-- 
2.45.2

