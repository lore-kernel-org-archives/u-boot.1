Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8281FC28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3B081D1F;
	Fri, 14 Mar 2025 06:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EqT5Y2Dq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165A580F9C; Fri, 14 Mar 2025 05:10:18 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC23808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQeamuhYORxUi7/xBFig9ySFCNsgk8G1fujyQ/gCod+nKOCZ+kwZmKeA/oM9TEgq52qLFVOGpSh/tP+3hvZMb7EWiq1bVZ9UcmxwfaxZZ+HvI3naKyXifZsVE6VAL98PmjRyUM8XNAEJMZxJB9nM0mV4LH9cXaszreKFKbC5DJG/q7nREmjkod8xLcgvtoB1GSkLAQRzb28qwL5V39A5isTBVQr/uG7ebkc/DIWrrvNNA0ItsmyuKKhbL6aBIXcyqIG+7bdFMl2CHIxT2aK1ehHsfiQLS+bAIuWCnUN5ls4NCYzG+SuHcS2sqiFcQZd8QZqbp5JuGDiYloK7Px6kcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHe1UNYlvk/2RwZZrYSPoUDbYvMc+sfZlRw1nYfuV7w=;
 b=cHSaHIsG0WS1PESn3oqCuZLYq/2qjkAj2OOCP5V2RZdmKyuiy4v9hCiPooO0GiXZWXLBxMkyarhjuGGKzM2lO254fsAzFTrofjQ412CO7TbBP/yJ98iruFBYWtG6hD3k36y9SAGkQLCKH+fcG75TIHZyu1zYr195r20YVLDnIYD9dNFe9394W4VrZ6r7IvM7IIXWXyayLGhhcHQxVmvjUMLh4eqCjmjvSYlVruyx3FM8JaK9LpdzH5f/QdPnLMxleFOrGrJ4nbqmEkgyQ9oKLVXUjXkFpOtnn/WE/poP1kbuciQOJ7fBbCYTdrOqth6WQd+/A0d4fYPnPHSvOC50rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHe1UNYlvk/2RwZZrYSPoUDbYvMc+sfZlRw1nYfuV7w=;
 b=EqT5Y2DqvMhvxmamh6babOANggM0jI82w8ECEGC1IkxwgQlae/C+c/S2mY9Br7BqRHcJ0d5JUCRJwhFnAEEarFd7azBKka0Yna12lDj4Ltc3G5+MugS6D193Xses2FDPCC2OwZpX6acewkFV/gUVr8tPumrgA3+w3rSNAQZthaMG26l/Ria9DLm//h6fIg8a2Li7OJuxU5yjmZMf9BANtd/oEPuP6ylqP8Kn0qtLAc7Vr9ZWPmONbVUukh/if+FuXsegTGE4eocXRbWe1GEha2dG4JDtI+uny4VEwcTnv348ALnXFnb2/aFyjtZGAoKB+jW+fDJ3n4Vgt1ZgVU1Pmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:13 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:13 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 07/13] drivers: i3c: master: Enable probe i3c without
 slave device
Date: Fri, 14 Mar 2025 12:08:56 +0800
Message-Id: <20250314040902.43621-8-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 158ad423-aaac-4912-3abc-08dd62ae1e8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?csObxIZBs3x3O1I4KcIlbeKimPgYna8/hUVdJ9leiiTR5VVqWRIRPiFsKfv1?=
 =?us-ascii?Q?/Cxmd1fkPyNDkB9zCsUaiBs9RtKMl0HmPMF8GJmWmD+FVv/I539LuOmLxm2/?=
 =?us-ascii?Q?OclX1ICnNpkOzSQyLDP7QNaAFSIq8tfah0pCbDmchdsOIhso5y5gW2UWwcEH?=
 =?us-ascii?Q?w2mi467/ajHXcm5pT0xupMBXHJ3pCKkuNmGfDjz1Oq/siilc4bljVcbVjFPP?=
 =?us-ascii?Q?N1QYZ75zHUhknaWFFpC+hWZXTnt46x6IXuLvdqNMx+gnlhcr1m1uejg7dd4k?=
 =?us-ascii?Q?myNo5u7YQMtKnQW0snKt6MHvGEQFWJjh/DjYKLTcQkScGi3YTo2Xm/UT83BJ?=
 =?us-ascii?Q?XRmeTziyr6gXSmMii3oe8FNnC6n05peo5FeOQhe16B9X+G9p5UXW84xYKrJZ?=
 =?us-ascii?Q?O9g4NumMTy7mbFSsns8syOtTa8SVgKzodpxLqWppBgzg4U3sJScLv1Qzmoyx?=
 =?us-ascii?Q?sQiC0CHAwLXUYSlGdiwBu+VnPmnkzl2VuFnPq5JV7J6A2ZZcRWD6yLHtLKVx?=
 =?us-ascii?Q?K7sWCF/Ld/Vq6pPNHAllDB52h1hkhdqKZAevS+FS/6I6AjPSlmkJZeLDbuIo?=
 =?us-ascii?Q?N9XQ1dS3SwWb0Ud46ljZr88Rl2eXOP32j/nNmJQ5vCNWLjKN4jq4obhOFesX?=
 =?us-ascii?Q?y6a6DHrvRFyrxeD/TAF5gdXFk+ZiTo5aOXZEdECaCVikoHHJA/47yT3nN6/s?=
 =?us-ascii?Q?CTEXs8ez6fWCrcLIRlBs8NZl4UsrMhGpU9BiS7Bi2Yma8+pWeV9tFpe2uFQ8?=
 =?us-ascii?Q?vv88I7UUSX/p/7I/0U2aSIhBiZIg90aNjT5bxFbfIyOUo4ObbxwNUIb+vlyz?=
 =?us-ascii?Q?2NjNZWIgPK3G3FLKEzMC3tY5OTFqAuEew9/4zvkkHk64REFFI47GtyhFFUNj?=
 =?us-ascii?Q?bPodY3sekbQez64F7mySq4ugWsD1piKhpaWiKvKGV+2xlPMWERM/n5RXLUA7?=
 =?us-ascii?Q?sfcLqKkQZFqaRKg314YB/2xjnqpOhd2k6A2+DG+DRx6/B/TwHEJwEqSE09HR?=
 =?us-ascii?Q?qktwBLkJtSoVZLh2htlZG7uyoB46C0bT6ltkMs5v8pGl7u47lkKA3Mlo+fCh?=
 =?us-ascii?Q?NKL/C3JS19XcwaSEDNlXyAhjruKN1oQ28xRckq8weX3MH7axaqpNdUMHRnE0?=
 =?us-ascii?Q?YaDoY8LEFCb7SLW9QpLQcUIgQGKDa0tvBLcyqFyIR7OxJcRsYAA6jeq4igZQ?=
 =?us-ascii?Q?SlhTNiQGSmHBsuPBRNHq8tavvaVs7hmu/Q0SOYLNNVklumbL0irz4Bs7Wtoh?=
 =?us-ascii?Q?H4iZkqY+KVQpQP+GGdHteFwcbaFOS8tYsVDiwc/sq9SulpGcE9zBy0rRlH8t?=
 =?us-ascii?Q?EQ9PnBH+2Mf/HIxjMw9XcHPxNUhSOqsGEe58j5os6r7O1QdYkazPKNn8gXRc?=
 =?us-ascii?Q?1YF7tcciWB7F0skakD0a4NNeWM74?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xS8GhsfbSjdR+Y85538N/Q49F8VVRETjXA6RnrfHx1n6KfyOIFyx6pvtiMlQ?=
 =?us-ascii?Q?XqNZCcp7SsA5LJ3VeNW7GEUDp6bE3RAGOjZS9wa3U/ywum4SpFKpuq6WOM1A?=
 =?us-ascii?Q?8ljifetb3FykXr4ilYsIzvXpblT5HcMNej2D+5dZ3Hk+svd3xwerJxELJ9je?=
 =?us-ascii?Q?6ouniXz/ysp/BR3Xxgmc/fWb0mBXopBNlTaMm5E8sEUsQiT3EKoENLzEpoPd?=
 =?us-ascii?Q?w07Nl1soKt60rRdcekCs0Kw5jXMjgqPafQ9SQidt9yMQTtU+D+9Jz0fQCxN+?=
 =?us-ascii?Q?e2+JVJvCpvezRB0jnzNr+7mWF/MKDaHs2zp7gEvn2zFa6s00r8fwd1uZgZZx?=
 =?us-ascii?Q?7Q8DyXUiKq+aKssR7w6j8zbGek/HTe0TUeITBNOCjAcioEsnA2ehDrgeYqX6?=
 =?us-ascii?Q?ZOwptYJ88E1DLNPcw7De/JlS52a2HRC5py/jlyjSh2R5xcDjWU2BpO2F6Rjz?=
 =?us-ascii?Q?LmWr94RiSFlT5XoMfutO6AvFCD1efaVo4kN1RwWDWAJudZy6bPU9Ci5RaCeY?=
 =?us-ascii?Q?LfWmKatyE9yjUbfEU6FZxkkMfRdFg6wTN3PJ03x2GwFm6mp7DueS3BFfLsOx?=
 =?us-ascii?Q?HGQzxdy4riMZuRHIcxb6VUFKbIqh9JguuQmKpEBLBsz9pj5uKpS+et+pw53Y?=
 =?us-ascii?Q?WlM3urmZcgPdnZlYa69YFUu59OsqReM8qMgxFvD/kyQRXsekioR40aoKY7so?=
 =?us-ascii?Q?tC2ndFNqf0uJ23is4Q/CsVQHPqyWcx302HTPsYf1oCAU4jkIoQoYXBfksAbU?=
 =?us-ascii?Q?LJHKyHryV2DO/MOmg2LhQG4qSakG0QeL5wVasD5DgxG1S3YdJX7Z4NVg8K54?=
 =?us-ascii?Q?XWnxA4EcGAfEwz7vXNbVdthEj58Zvpt7KctPREjA3A0ifUrIYnVam62VZeJW?=
 =?us-ascii?Q?BP9ukLdsV5V+uG61vU5JIeQW+yHvztkTjcW0P00FbV6eD674ojp12ZUCNkXa?=
 =?us-ascii?Q?FmB+wkROuufQz+LB4pcc4vfBwBe/DBZTFP0BP77mYa2g7XtdEhs6K5hFuc+B?=
 =?us-ascii?Q?bRHaTPNbbxb7x+S5/rNVXkDCqJTJ+AM9XGsoWtOHTiraV8J/VVyOntGpF144?=
 =?us-ascii?Q?ToRJquSWuow2UfWDsAjYHPbKZiPZH6DCRgBNrzbhVelm6ZZmLsVJ5n5Iel0w?=
 =?us-ascii?Q?wEvnMaagjhwqzptx87OiBhA8sohC6VoCuPL6hFkwicj/IPpeXpUPqgahx3a6?=
 =?us-ascii?Q?Lo4Rtk2FvA2ocABGUR0WrBNKbmLQDWSKY4xqIvXdCnmXG30akbvEGtb28Y2T?=
 =?us-ascii?Q?p0BxGa0tfxglbfkboZ8drTiDpejlvxjPGJOc6+0/+7Md0S5k0j/NS5KkB4/8?=
 =?us-ascii?Q?UvIittMAHPWa5hBIsItVjYa3BD6nuUFTOW4bryD5hwzyFeoFwn+t54EUJwwp?=
 =?us-ascii?Q?4sstNuVJDh9qW3nSAwB5ketItlSrFM/DB/c518dvpvGWdqIjRjd4B8qwRADH?=
 =?us-ascii?Q?pF4lPduVTSQ6hQ0nv0OQBX9obMQ55B/v6PrUcLXgl7LmWxt8i43nEfyqpiQc?=
 =?us-ascii?Q?355UxloSLsBOjQDSyHiftFlOSPzGS6yRXmWjD3tLSen2WnDuWdpmHV9hM5iF?=
 =?us-ascii?Q?OKLdQRQfi+F0yrn3VwbaRZbRHEg3aQfu391Ia4xjjTvFJ7f2Y/oF32kOoDhw?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158ad423-aaac-4912-3abc-08dd62ae1e8f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:13.4966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Lxg1Wesop5B6HcMGMVV8PiAeiRz6sbNLtWDQ7ZocJtipoFIpD6uAFt+t1J0lJOUrJfFBejfGRB0SlAh0tuThi94KtUUUiKbwhW/x6X5P/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Picked linux i3c driver upstraming patch to fix the issue to
probe for i3c controller without slave device attached.
With this fix, the ret check will be on command error and will success
without slave device attached.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index a4f2de1302d..6df6410bb12 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -454,6 +454,9 @@ static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
 
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
@@ -509,6 +512,9 @@ static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
 	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
 	i3c_ccc_cmd_dest_cleanup(&dest);
 
+	if (ret)
+		ret = cmd.err;
+
 	return ret;
 }
 
-- 
2.26.2

