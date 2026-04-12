Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7CBE93802
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2414B841DF;
	Sun, 12 Apr 2026 22:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="gDTg+2sU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56C283F75; Sun, 12 Apr 2026 22:00:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7608841C2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 22:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuuRSxJCerohViu0m1LuIBiETolBWYTuUEDS+IJ6gPBIKb0eHGdpSS5VwCDHIgHFdFk47cFI/C0+D93eLnupYFw1apkxmSt7Sj/O4odDZABebb4VulHz5O+q8uFzk+ZmaF7H3B54YNk6+TNdGRjzV6cmfQsZwNPLLFIQ7eESifhBPCqPfnZJyK7PupjQ+MT2m3XpQjiFFhXMDappvUxjJ1xAnVUS0TqTDQhUqcIgrX81OrUZFnKVH2IRmox/vF2zShdjQTJ/rBjW9rqBN7RHV/2hHHK81mZhJvX2ELxnnNJkUNM+B2dGEE9EM72IHbLDUV/Sjrv2l8wPnKKFtC/cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O887aXX8e2rR1HkYX936iBU+F0ILo6ee0SeA3hppHU=;
 b=NQGY8/nJDZ10KSgh6eYVDOoNUYZ3FRMzpLzKOs0mvBsCqln57Ht8uXvChkeZardtKCuqpDrjsUeaAXp55aCuar55L+pddc7bNQf4QdkhUxEiB59fXVIHEepPwW3S8YtX595UPmuEVV4TUN3gLSPQSNAlVKjKNzZuXNrT91kLJz66qo7S/8rTBowEX7IKIc168f2g3sWSf46T0cP0bzc9wq8+VBaVlKfn3ptfFv9yVdtPi8AQHN/fbSWcu6p+nSQ4oJbHa6mhITSiVc4ciA4eFTpLRghWwrLCOlruVBIITN7QYqA5XN3nu25AhglpFVXpI5Geos4Q+3x3N4q+w2C/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O887aXX8e2rR1HkYX936iBU+F0ILo6ee0SeA3hppHU=;
 b=gDTg+2sUp4LhWMRvlGnRkVBluU4glK227bbm9YMbco3iZY+8r1peMlgul2KuJQRj3yG8X8f7WaTwsvj4B4Zwk/KKnFSiIM6vcG/xzNz0anK9Pr4qfpaxO3u0UDbqDyuZRiO+m73P6bFOQZfOdDGaaCu0adrUQpZBUfrUwCFlCtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 20:00:02 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 20:00:02 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 7/8] common/cli.c: use memdup_nul() in run_command_list()
Date: Sun, 12 Apr 2026 21:59:46 +0200
Message-ID: <20260412195947.1982729-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
References: <20260412195947.1982729-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0015.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: c38b23ae-e08c-4947-1e27-08de98ce1576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: jNH7wYDkMAtJVjPCTyKbA9wv9OA60Fcw0OTq+1oWSLLSR611YJZZozRwkoVGfZy62ReJELCXljPRrB0zNHsPdwVHALyf7RFyF6H32QTZ81jaK2aDKL1W9gG0hJSktAdwjX5zZA4bDzhLEy6I4pNSumq7xIJxosnFGisFImOgdsbmxQ+oWrSUZXMvnUnblQUfF0QfgH62qpM6c+11SKgwq7tSBbnvNVCMKI/CAMvbPumEevkIweaeILloZMWF0SRU3ayTYDnOtWXfpGkMr3drkMHTixsS0S04sD65tYwCkdZCI6XoR744Ep09SpQzCHLqBQGpv2AmFdduxWx9YoIEvHs5Vg6VpiTANLwMlQiLOZ2Zv41ZhAkxFElOTwvch993Yy6lKCwap/2k6dVdgB3g4TGFuCO5ltR+oayOLhCEaOzmTcHw7pJ/VwiwTWUu3VDxDARu3DO0Pxta5ItSWeiDMkbV85pznB7XVlVv+dauDu4tYpW4ZUIRI21BHjQEzYNDD1b7pWETumcqphmjUJX6MghB4U8hVg6SLC2LjZeUsizgKOa46ZT6atyLBf6zpFAqkfQ3Qpjox8CFxMkXNaELxArRKkMo+fbWAcdXkCN1tVRWBsUUF8tm6/ts7xRYFZ2MAKb6aXKDVmRBWJKGM2Dk+p4Ji0pCRFvJgF9ghcHxER2mtyzKOr9oeZunt0e4Guk/Z/Zfv42yrIbwq+TBM9Oe0yuZp11vU0pJSf4WGMqDOJbmMUAlD+urC7vTVilIPBVbHcQ96whR6Y1OfJjYBoG+eJ9I0DipHO3dmi3BUQvlnps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLL/etbDcUd0GFwF8MDcKwjXV9CaHlM/K/knFG67hQJbG5k4uggB8bjD87zo?=
 =?us-ascii?Q?2h9FnTNReCYigtlwRPqBgG/tr8YPFUeOf17uzY8SETmP+lPVv5/ams6mTsfE?=
 =?us-ascii?Q?2IXa2pI9etJz5V1OEXkvrsSpDoDzboU4hD3W4N/2co8qeGYMrGKwnGetWIZy?=
 =?us-ascii?Q?CZE1l2C1+M6k+D9lB7JWYeJ1j3hzpZXIlCowj9garpJLn/N8fd7kA01o8twl?=
 =?us-ascii?Q?8TmmtTGeUa5PiBq2UX432U9KZVQh1uHM5q/o10TZz2JhImmdc4ycP8MxDvmE?=
 =?us-ascii?Q?PGOr4g2kmu56tyJcpwDBlNfxPTbvyHTCIBcLShiFA/yA2DpVeRSQSoFJxual?=
 =?us-ascii?Q?weFMgXfB5bqNz1RU8uzn7RZOmRDA5Vyxb+mZgUUTCR02P+jWum1SOlAtI4u+?=
 =?us-ascii?Q?TDApCsWKhGtMKfnl4h+9SfWgPLDsFmmnxY75rt0K7MAola/tdNc7dS6xic5y?=
 =?us-ascii?Q?SauhRTiOYMyuIoPjTuOyD9E9lT30GtBCtGNGL7i5mvsuX7jwc/KaYBBHistn?=
 =?us-ascii?Q?AjKp+w0JrKYX4QPVDfp4d8E79G36RXnVJhxcCzJFo0EwlbTdShy4VI7ZkLdE?=
 =?us-ascii?Q?X3zFfhw/eFcyklZFfDWHGPDUd8+P9peRvBubHCv8YdKdjhm9tLltfCc28UI7?=
 =?us-ascii?Q?amUpB+bsZb3XHxagd8An1r4rXl47xczavYJK4M2TMQVxcDEJQQsgbHdWFkUF?=
 =?us-ascii?Q?ZHoe/3LPVXgABMpg0u1Q8kaC+VJPs19LU8JMl6KgrVA/ZPZjVVBflNe6DS9U?=
 =?us-ascii?Q?ecJV8/5NX5ya5whlnRV1Rr37zG6UOir8/obNj+AmaGc9o3S1lLRze/uiUeHv?=
 =?us-ascii?Q?4WvudwN848EBxaPhLWdHrwHDdZc/F/UwQDMG8757d/R7EfUnt4wPHeiULumT?=
 =?us-ascii?Q?L0V2j9sRh8KsHbxt/4y2ocl3jpwQBuh8GaBKcJU6zMJ+6ywHmhfLJG/C95HO?=
 =?us-ascii?Q?woszgfZqW2caXwZ4twB134xMWSoI3EcCp4gUbQIxdNV6MM0xle+fUgx1vrb4?=
 =?us-ascii?Q?JmcAYaY/6ttT04siLgCmVZ3OMqncTfsh/JHGO/pjJwJX3l9VEiPcCelH0cn3?=
 =?us-ascii?Q?3cqOCSVQanPX+Bz90AtJKbLy0kurOfkwNjCLcLFncJsfa5HagdmImcm9Z3h8?=
 =?us-ascii?Q?ZoH1AhRN3OBY+FjzRFVuRSuO8sXCZ2/Bdvmlabt/leF7+ZPA4XkFQ6Gh8rRd?=
 =?us-ascii?Q?AbB4h95YjsQQrVfOZbOlYMrznMtTYvolGL3hwj48WQnkpcLJCUcS+AiFtnNQ?=
 =?us-ascii?Q?ib7hCsoeD7WeZbwEVHipzRTvX0Z7+J12VU4uQOTDbZXoREk92LDxCLdohnh2?=
 =?us-ascii?Q?ebCSgHt2oXIuPGZUa0bIhCcTnJe5U6DqM4AYrZk0ZKtOGG92926PmbFHTbRF?=
 =?us-ascii?Q?1YxZyPUfn256RmZ/sdsL9apn2N96wKVVgYPCJhgj/dhuzubaZWSv+oDlLyU7?=
 =?us-ascii?Q?Mhlgtcz4cvlpcFnBUbB3vcN79E+VH2FttdLeiMBgQ0ZGvWjfVlppzCak9OOp?=
 =?us-ascii?Q?Ud+ZGGHPAtA8wGkz10fONewBTTguPZuEtacPJJSoDbpoS2HUr/WA83DPj7mH?=
 =?us-ascii?Q?9czUtuKpdrAweaLr8xeP0dW99j8T+h3RX+KuC3qj4Ira22uAi8KVTD/wq1rp?=
 =?us-ascii?Q?ZFMixSZWPexWnomAvi+5DefnyqSVqwjD86YRml9LX7OA+Zkzl7V9jASeuhQd?=
 =?us-ascii?Q?0SWOnQ7hzVOLcxXUYohI58+0mahF84WVKZxuRF/EOQGFKzU0UIE7RFMi7Txw?=
 =?us-ascii?Q?vt7NvLLuTx1562SPXl7VHhQfBsdVfUw=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c38b23ae-e08c-4947-1e27-08de98ce1576
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 20:00:02.4614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzx5wkk8SkQg+zrmkA/UGWTTDd1i7BkHmQwP1HwRlFIKKZlv+h0YHfblw8QljiDZ+corENlQIbaGZJEfQZ6gsgyihNjiEunFcLjUShOVhT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9930
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

