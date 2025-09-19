Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02948CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8A18349B;
	Fri, 19 Sep 2025 12:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="YN1IsnfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E08833AD; Fri, 19 Sep 2025 12:10:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69075832DA
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWmmgeM6Yhkas1mqzIEdOBxrCWqTz+ZjpH8MdX5aF7UeCykJs8xUcGK9POfpwqIrhREy6023vaPg0favrBpnu/8xCw6dCjEvzFyv/DkeBGwUoLQBSPGo/eQJpgvA84ByN304p9EoupbCcNLS9eUHDJUW4F2wQ9TI0BHE91eV1vrVj4WhDzDn0LlriZyBvSLb6I+bdS7EXi79LersDiJvHLg0BFJKFTNGZZ4X4OQVjwGh5ZjLt+eikfqvSdMAY7QK541nf4xShqjigxfFXKPHO9T7abHU0UiHiV3WWy66lKhyVulWHHkTKJCJQ1924b5aIToYBD+h3wITxyyEEYslZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7Jf5a3ljajeUq3eur1KB+z4xOgsr7ZkpCHixbtIdaQ=;
 b=VuRyn+Kixv6A2enrTVWTyxrxy7MuVKPyPUefzpIFfdIjv2JxZBsn7nsPwjKH21EJ6IYAzzPvHEeXeY+TZ6ybiS4sWfOq6wVAUJi7n/UEDiyQHnYBDpuZ7561AVOIlQ4wH1yxOpOKs3ZaUPHb+VuS+5JlxxBfB2CflI5ERcNz9KjsfrHu8joTyPgP2VSt7o5dQdNQr7AR80yP+YoJvhRJWdDQC70g3ZJP3CcE7ch+SklE8vm1/yZoXTnVEM0+hWBk+FxRPyUVFlCJWz+R4lwSLUA1Q1Tkg8HbRz4ehRwL676EwrCjkvRnZcA5FKqe0NPJmBujnwfzRssmlnJvkU3JjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7Jf5a3ljajeUq3eur1KB+z4xOgsr7ZkpCHixbtIdaQ=;
 b=YN1IsnfBA3VWMaIt1jckjcnbMtZBagYbDFEvm/JsEIpYujfRGg8xWaffl1+8BDWQCKq8zPBNYrvltjaEoHfFeNuyctTe5bPj5y6orLu+gwcHe2Fiiroy4WhKMQpdw+PL/t8vjhbikSk57XI4MBMsPnG9XoFcHrDU0Dlm9gn54Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:10:13 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 5/9] exports.c: drop unused dummy function
Date: Fri, 19 Sep 2025 12:09:58 +0200
Message-ID: <20250919101002.568488-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0042.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b28b364-a3f2-45f0-567c-08ddf764b91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WYUK5LZk2eaUTVtl0YuMjBLXl74oL9ieUoL6loLRrEpA8h98snvaxOpnVKkw?=
 =?us-ascii?Q?+PoGBe4PCCf3nGL381xkI9img7Jdwk0T2whGV7CTZcL2Nsa227/KOISo92Ws?=
 =?us-ascii?Q?TwUrF3Wz1SUN6o4Ze3RhRwUrRjxIAB969J9pmBltJRp6zsZQM5DDTFPFP3WS?=
 =?us-ascii?Q?Qu2Qownuj3wNMLE/IhC1lyyNzYHzifGM1Fkd0TsTeMKypl5p+7FyM8LkGaDp?=
 =?us-ascii?Q?ppaBP+bGMCJ9g9HpzGWFEHNagAD6rksMh7F3E3IslQh7sZXC6lwfqeGSUiiB?=
 =?us-ascii?Q?C2IS3f3RrvhL3vyDymrFZHgEi+Q+JNnMVxCrWFLRZQdvcq8YA5/uNmYgllaq?=
 =?us-ascii?Q?wfpHjpHqVw/25QMg/hCL0MG0/oiwVPGCY8MvwGaRB+iMDdyWJRC6UeliMnN6?=
 =?us-ascii?Q?z5rYS99UyuNHl+tovdz3w8qe0NHuHZgx17ZCki+eVx16aXxUo3yV7Iw6x7aY?=
 =?us-ascii?Q?6Bb+L+n5AJCgf0caiuU4rLKqHBk7FVXqpX2/tbwpZ9nRntB/F8E9VBa5W39b?=
 =?us-ascii?Q?SVu4bd+QWfsyVQpfx2Lcb8+IDjenAOSRhJWlgIRk0TZ5R6HhQsTHRtm/KUDm?=
 =?us-ascii?Q?L4R6m9mGdECUILpDQQXZSsXyoE5kvshpoDhTsc5QXltLDmFm6rVx/J7RJB5c?=
 =?us-ascii?Q?wQMUrM/Na02vHdtdaMLfZIVPnhVJjc3+WicsJqCCgwXDSzehqrL2dsNNHkeb?=
 =?us-ascii?Q?0772LxaYNylqLeeYq1RCzJls51BJMlhvrIHYvp/Uq0H9xgGtxx7l7E2LcaC2?=
 =?us-ascii?Q?hW0AVFE3SN/xlTWJO8DJNglipzzmP+STVELcjWyYdQu1XeSe9i8FjpMNNq+C?=
 =?us-ascii?Q?2CfhT5u/VbkuQX/vzd+WiXp4FU2mgc2k4YJ0kWIMUIF+zflkPUoh1sN9sUxy?=
 =?us-ascii?Q?6pUWHYIjfcqEk8cg4aBTKMqgpY6OV2mGei9+zhWP5yJ/L1CRAi1nntGnz1Ev?=
 =?us-ascii?Q?cj8XrY6seOkNlznLMOwt761XshqYdQTfGoCWg+ZsgiiVLze1PrAcWIQCwM+A?=
 =?us-ascii?Q?rQ+lR3RvyHq07lbk3ZIfWcBVPNHdj6ZH5Qlb3B6URS/FJqNKMsKmSOU9TuoA?=
 =?us-ascii?Q?FHZ8tQZ577W9RAzed7ikURI3rRE444v4g6AF/qg7PfTU7vP45hQAVAOXld/e?=
 =?us-ascii?Q?7xRYfWdwwgRUYgEICc8N1eylnnR0nIowcoIDSNOs+7PocBC3FhCPhDfAgx4w?=
 =?us-ascii?Q?h3GaaefJET5Yu7UZR7A3dS4pt1rBwpZ7MJqD5Z4Ls3+tTrK9rL1szdwLMx4k?=
 =?us-ascii?Q?2goMYqtylrN/6e7luND3DhsPCA+GSvDUaj95Gu80o0jqxfLlpVBiPcpdw9o6?=
 =?us-ascii?Q?yulrRIwRq/9Nm9mMBsOasbfAKxioGWf2yCposIO19BSaIvq9POYCjNgzRWLc?=
 =?us-ascii?Q?xmD72tK/BpcEX8XB9YyFNZdPoyaxb005rxtZ3E6TVUGh3BHf4hsVqnR+yxHb?=
 =?us-ascii?Q?ztOez+aVZttxU1oeCNjpyuKOPLEkVU0fLfV4vkG9cGGzMa7+mGEA1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HZrfuOgKLCaq2HI5ruLwx1Pm9RHvF5OnWzrNv0MumwRdAm0eDN2iPxkJJlo?=
 =?us-ascii?Q?N+nxLcJq4B5lVeMZfjct6L7nMXMRylUElBd6K/vC4be20Ew96HoFMangD1d1?=
 =?us-ascii?Q?rDiwfTn8mP2awRbmkWUDsTVFaP0MF5DLNSy0inTH7YaUHw6ZHwUQIH7CXiTm?=
 =?us-ascii?Q?X9SC1gBHiMR2sBN0rFLm4mPbFyl71S8xsSOZ2P840acE4yo9BPOGEnrC3axr?=
 =?us-ascii?Q?h4eZmPuS5OmQS1EE3Dm6yCbMi5bgt7kj5RjDQt92c/uvZoF1QubrcLF5XI6E?=
 =?us-ascii?Q?1Ke2YIemsbmmHF2nZWnsI2vLbrCP8yLUtDz0cwkjShZ+oDNKoqyxKif6PL08?=
 =?us-ascii?Q?oQsvoEdJOow/N0KMIE9yAoS7CAnGgGOGksKu76QMUDAYwwZ4tV6DSO5vuW0L?=
 =?us-ascii?Q?pkuaX864fitusNOA9cmEzVxXcFRE4GSHb7K7GRRum2w/XtRjIEKk+igOI+r6?=
 =?us-ascii?Q?GPYJhrVGJzXPfugenRqQvf1OMywBw/XZyfeHbM3XAnwBGUIMyPsn8DSrVHoo?=
 =?us-ascii?Q?zJmkxb27GV47/TAxBhwHCRZKffk7LLtj8BKMYx52dhD9kDySti97+eJIeTPo?=
 =?us-ascii?Q?OWumAIUeU21hGmR5iwKKzORarvGspJeXjmoPcmlhKAbF9uv1SqzNuI3l29/H?=
 =?us-ascii?Q?L7pYpWfCzmAUbyoZ6xc+X7+0gNTNauRANHp96VAxJC9NKW190PA/DMOLJgHK?=
 =?us-ascii?Q?+p53h+nGW0atjJKvY/C902VOlFfSxyO/49+hdyJx2P2HDvyKCbdsSexHYORk?=
 =?us-ascii?Q?gCR6lWnOW05Nk+ytxZY6ugURDe58XUXXQEZsk3vD0oHQU8iJDY5RJGjyvq5A?=
 =?us-ascii?Q?XdVJpd8wlpZ+Io9X+tU06ZtysSx1i9xO4dFUL+bKeF9HXGAEgJTuX8OpcwaD?=
 =?us-ascii?Q?tfkKjC/2M8J7KK0I60Qn3RKGwNARpmm5WL/0mVfnkSELRT6ViBXK2JQl7bAe?=
 =?us-ascii?Q?2E8JMFvK2bqjG/3eSJwvac719/m8TU6zcA6W5BFfl3XgCEnru0XN7tBtXGZh?=
 =?us-ascii?Q?DehFI2sNfdHLy/zsybGeKWDDaACW7ugpHiKSQ7cYCwLur83jXQ75foeaPNHT?=
 =?us-ascii?Q?ljeHfaNgWcWCT6kWU6z8ZRqKRTXFHvjtR/Wfo48Lt53DbQkNVa/DuhmLQKVX?=
 =?us-ascii?Q?USq2l78W8a1Z2M0WqAGoWanZTiO7Y6y7iBzlqMohtnVvf0CQIBsCfuYrfj+m?=
 =?us-ascii?Q?FDBlFXj2jLrt8drCuBm0+XAETHF6tug2rdbdXTuW0lwmY0iLzvUx0K1OcBqZ?=
 =?us-ascii?Q?UbuP2tg3m+FxmUmbWk+sfQQ+GOAdUF1qizWY7UOEgXXEjrcLDQqcxtyf9qoP?=
 =?us-ascii?Q?fiDAEcy2BtrtmlJqkfvXo4hSCEczSxkjEHcpQ4svX0EufD6J9hjK1fBJdIif?=
 =?us-ascii?Q?mADIpIJNQov5KJ075gBSWsBqCLeRwRSsv7GkVA3tlk+d+kBsdqYmDKpqKPmM?=
 =?us-ascii?Q?ccg50BtuqopJjKnFX1us7prW9jsOoaZdHfJuDt9deQfn0I8BjDyVWiPHHOMm?=
 =?us-ascii?Q?Dqhj7QNjgwrmAoM0ZG/dugZlJO1zOUfLWbUsjlXV+iBjggdkhCSsOGwZjhcj?=
 =?us-ascii?Q?urnWHn4A4GeECRcIk9qZRTcOwkK46KJeSlxXvoaDJxFO5nv7X4KD3q/pIOpG?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b28b364-a3f2-45f0-567c-08ddf764b91c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:13.2902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHlKtnDDQrN5BkYmkVlM7V3euvFlhkSiJOlqjMgXAMgGGoW7pL2c04fYLpQETL8+z1Avh4tSctOTNl0tMhguK+RZtWx2u0gb/4eU9KejCjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
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

The !CONFIG_PHY_AQUANTIA defines were already superfluous since
_exports.h does have a CONFIG_PHY_AQUANTIA, so the entries never
existed. In fact, it couldn't have worked, because the defines would
affect both occurences of the mdio_get_current_dev identifier in the

	EXPORT_FUNC(mdio_get_current_dev, struct mii_dev *,
		    mdio_get_current_dev, void)

so the C code would end up containing four copies of

  gd->jt->dummy = dummy

but struct jt_funcs would not and does not have any 'dummy' member.

Now that nothing in _exports.h refers to dummy(), remove the empty
function.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/exports.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/common/exports.c b/common/exports.c
index 48b084c3861..1b7fec685b1 100644
--- a/common/exports.c
+++ b/common/exports.c
@@ -7,10 +7,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-__attribute__((unused)) static void dummy(void)
-{
-}
-
 unsigned long get_version(void)
 {
 	return XF_VERSION;
@@ -18,13 +14,6 @@ unsigned long get_version(void)
 
 #define EXPORT_FUNC(f, a, x, ...)  gd->jt->x = f;
 
-#ifndef CONFIG_PHY_AQUANTIA
-# define mdio_get_current_dev		dummy
-# define phy_find_by_mask		dummy
-# define mdio_phydev_for_ethname	dummy
-# define miiphy_set_current_dev		dummy
-#endif
-
 int jumptable_init(void)
 {
 	gd->jt = malloc(sizeof(struct jt_funcs));
-- 
2.51.0

