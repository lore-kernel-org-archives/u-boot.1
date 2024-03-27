Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42745C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D073880FC;
	Wed, 27 Mar 2024 14:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QOw8FlZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5545C880E5; Wed, 27 Mar 2024 14:11:27 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647B0880C5
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaM0PW8uytLFg5ll0/kT8F1uIvTy+Ri8f9noltsJ1cb3fR4GwjhECz6GdUC/5ZxEjyVmQ1jAexAgxuwg6GP2FaAffO7vn28uf1NaXvpfjkI7WLfzWGbMOjPnSc6af7FQfhk4JYCesZZ5uVfI15teZIl0fY2bdsvuGmJikhE+lT9FhjujGL3Zw2UsMOATC6dUn4dTK1taoW+aCh1ZJwF7agOytQ7Xwu7Tzzxzc9QgbIEDfcyL+BiGTXWrOSPLfc7y1bZTDWfYP2jz3sNrV5ISHheRbV+U3iqZxJPbjkn6I31Ckh2x4tsljoAoJTVm+4nWf5qDVyJgYCJxz2v4rfb8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw4y8Ys3wAi+rzm+Lf3dok1OxP9lf9H5DAZdqsN45Xk=;
 b=ZmjmoNU654uyoPSXMhgjCjezAzmMC8drGWzG9nONXBVmdvQ2UKFW9k5fEcx5go7US3Y1gOOG9CnU3fPkxpa09rdm6Zb/x8hj5D0Cm35/l2JyOHGCXRJ+TWzgzQbIqn+Fd0tPiBelpCmpzYj++TMvVhefOyrg+wGCHgghOlEcO2vhXWJfB/9iUe3HnTW2zX0KW6fDYdJQhxTHjyXIVyi1PXpHbwWJYPb1QS6Z/2KJzDw5sbiJaSZGLpASHyfCgpFUNUcu5OGmFGAKX1zakkQm2bBxqbKx3eWsxnhI9vDRltywWiUm3xrUd0wLwWenjvgU2+GLIAxYMJ0yhv0eNgZ4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw4y8Ys3wAi+rzm+Lf3dok1OxP9lf9H5DAZdqsN45Xk=;
 b=QOw8FlZelDqmF4PkmSD6kFfQI3lGEnH7krfAE1icBVrTS97asgxzA1SU6K2+lxPxAHtSjHXO0KX/ZREyRVr9sdaNILbjigk6YdITWLZbHv6M1tRhTon67LK32GDni4fUVwoXvA/H6ifX9O9h4hhxwqOsSCk8CdYZYdok83GbxX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:11:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:11:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 Mar 2024 22:10:49 +0800
Subject: [PATCH 5/6] Makefile: tune the include order
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-imx93-of-v1-5-afab6b31422a@nxp.com>
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
In-Reply-To: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8ec0ff-5a12-4674-63b4-08dc4e5f670d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJlnbeAZ2HOt44k7M+P6FXH8FblA3y7V9Ie6PMA08VzkHHZbnpHJHZh3B0YbnBGGJ8DP4SG9zKY8rM3g2Ksj7S/3Gs0OBsR9Y3AxSUeHB5m+8FZH4RCikJ9GqJdSrEdTibQDtzEBJwKZNvGQrcSSxCtEToReuj2eP5c0uuaZzy5LzfLiGxSs186NWsVeBRtCP50fgI4c53bT11KaK6dIhONnWn4AlzN/TJjrT+lpFW921FFN71dglhN9FHl+KWYRiilWchHmrqsFmdT3Mc15LnLt7cN8yoHtH7D6zlKdnLuqiueSswuro2x8BWKf8Mp2B7bME62nGdekWAfiwVqVbv7PmEJ0lOUcIW1NMCTZf7t6YZby9V6N9/2OIn9sDNdLsUAmM/T/JsXPyBcfye6zt98MPS0cw9BRMZd6DJL5UThjfSIUhRuB4QyQLrEvNIvAgHoBPl0uetbjEa7WppBqWF6EjlO4LVMgsjqG+n+LalNcplz+egBk9/8ptnv1Oo1IPaFYqWaGUY2RUCxMvN+OyIMK+tPB6WrVO1Zep8AVrcElfn8W9Kr0Wq4Bfv0t6fLoYr8KBvKjdVPVYsBQ4485AfjskslH7u+BsHhQY/VQT4s2UTY3bVhDr9cQX9bkGzDUQ/qnLR0At4WW+AWiUXWFcoogiV7xvrr2i78zxYe2MYtQmNdBS6GdkfEExifp+ytSaDpbUm7s2lTGsgT2nCjDQT8h7tEP7gkOOLB7HjPT24A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjlQcE1ibEFMSnBwSWNHcDBoWTZ5cG1aWHBJWUVDaFp3V0xuVzNrMklkem1F?=
 =?utf-8?B?Wld1VkN4ZmRoMmdtUkErRGtDakdyR3RKVmN1QVU1c3NJZTJvMmw5SFk2Nkxu?=
 =?utf-8?B?djRtL2lWT0U3L1JSUjFWR1BGeTdtVmRlTDV4bWU0QmYzcEZ1WXVuVWpWWjJn?=
 =?utf-8?B?Wlh5R0IxbXM2bzNram9uSXo3SUVlT3V0TDdLTDhSYnZoTldVRjIvU3IraVpr?=
 =?utf-8?B?L3hTTmQyTUFEaG1MUVczOERQOGI4c1kvS0RhdXR5VFNXcTRaSnJlQm02aG1K?=
 =?utf-8?B?dkV0a3RsanJIYzRDTU9PRHhxWCtOV1VaUFpjUk9pNEt3MHZzcEpGNXBGTlJF?=
 =?utf-8?B?YituQ0h2endYM2o1Z05GVVlsRnlOd3lqcWN2UlZ2bU9tU2UxL0YxK1hscmZK?=
 =?utf-8?B?Y1VuTHhJdzhPczAyc1phcktsdkRudEFybDEvMGl1SnZWUzlhMkcvazU4WWh0?=
 =?utf-8?B?bUVEZk5xeG9qcFdlWWhkTHJGaEFUQk5HeWkxNy9VOFQyQXdIb2xEUXVWa0dj?=
 =?utf-8?B?UlNaMGx1SS9TcGRvTHJZeXFZMmt0VEs0MEExbVZVazRkSWJXZFFOTGJaMFZJ?=
 =?utf-8?B?ak9GdDk1VU5oWmR2SUd0LzQ0V0d0Q2VpSWN3NUV0QnJHU0VtcVdVd2pPVkZK?=
 =?utf-8?B?RTQ3azJtc2VLc1c0Z3JtY0FQRzZMZHU3ZGFYSWV0WHYrMGFVMm1PVStwQ0xw?=
 =?utf-8?B?b3F0NmVGTzd4RzI0SksxbWkySjNWMlZ6VC9lVkFYS2p6MTI1bzRPRWYyNnZo?=
 =?utf-8?B?R2NwemNSeEdXTTliMEFGMG1qOFVMc1poVlVVM0FoZGkyUm5ZT0djd0FnMm9G?=
 =?utf-8?B?SERBY0diTkMwRkQyb0dVSGVaVUtrMTYrZEZwejdhc09QbkJEdG9vdWZtQlRE?=
 =?utf-8?B?K29zSXhvbmxsNUdobE1oV0NBQkFQZENJdDB1bjNuT0wwZnVDak9hc2JpL05G?=
 =?utf-8?B?Z2JWZnErUFhtMXNxTWNGNXd1QlJ0bkZ4V0VFVDNlOVlHVStuU0FFakVGSlJj?=
 =?utf-8?B?RHpuT1VnbXl1dmMrZkxZOTgrS1VFWW1IUGRUTjE0WnRFVlVPMG9DeHNLNThP?=
 =?utf-8?B?aDFDelZ5WmhJdTQxMXE5OFNVUVIvcU9sN255RStybmJ0Njd4b2Fjdm9qRmJE?=
 =?utf-8?B?ZzM5akRpU1FZK1JQc3hKQVlvVVA2R3YxcFVOWGFiUFpkQ2RLMFBzNjBjbkR2?=
 =?utf-8?B?UmZYMldyVDJHNzB3enpSa0FCMm1KUW9SalcrcEw2WktYUWo5YUNmZkg3YVRI?=
 =?utf-8?B?eXhRMVc3bDdCWDRiN1l6eVFiQ09pM0VuNG8yd3AzNFhvZ2lxOUZMdm0rWmlS?=
 =?utf-8?B?Y0FySSt6SnRoaUZaSm1OZE1lMTdpclZCZlBFQjd5TEJZSzRDOG9OYVZud2RB?=
 =?utf-8?B?YWtGcGhTTk1zWFZXTDRGK3N2cXNFMkRDMm1OajFIOTBRejRJQXBUbE5KR3cz?=
 =?utf-8?B?MVM2K2hOVEJJT0tRMzBucXQ5OVV4ZitZd1pLa1pFNlN1aHFQa0gvL1JyOFdE?=
 =?utf-8?B?Y0dnS3hHUVNFK2JjZ1dMNU8xNGVJd3FtWFRkSlJqRXhHeC8yTEhMcWU4bmJW?=
 =?utf-8?B?MVVuTmgrc0JxNktKVU1LNEVrZENzcFJNSUd2YlJZZnNjUUtOaEdlaVpiT29t?=
 =?utf-8?B?bEVrMmkvRG1qbWE2Nmd3STF4Ly9wV3o0TkZiSzhEdDVxRGJrYWtXWnBycXBz?=
 =?utf-8?B?Z1RKd0pkY1JmVGl4RytlSEx5aHVQTHM1L3ZkMEl2M3ZHSGhaeGNrSWdnYW1k?=
 =?utf-8?B?RGxEOU9qMXBlMEM0Wncyb1VXbkUwUjd1WUdOejlvam15REc0Y0IyU1R4ejZ4?=
 =?utf-8?B?SjlVckgzOVVOb3pYWlV5MWt6NEtpMjVvSG5ZZXNiS2d3bzlQYkM3a2p6dVM2?=
 =?utf-8?B?RVV3MTd4NDRodTlIWHptZHMwTWZrMGwzOVZuZTJHUnVtNy9OdmFHOEVmTTY3?=
 =?utf-8?B?ZjlBMEpydkZKc0xsbkpHZjVucDV6SE9HekIvSGh2V3FocUQzajVoUHNQYXdI?=
 =?utf-8?B?RSsyelVXaGp0TEtmckoxQVZBNmEvMUZOZ3RjUVFZeUMvaGRwUm4yQlV0bEVN?=
 =?utf-8?B?WVl4NjNOT2twTWF0ZUZKWERWN1habmRGbVdSRncrcFVpSzNXa3dmOE5DMXdY?=
 =?utf-8?Q?h6107OkiPcoEFg1eYUl+zrm8+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8ec0ff-5a12-4674-63b4-08dc4e5f670d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:11:23.8537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWuwqYt5vV8YTbBFC2bB+u741WDLep+bjkKMjr16E+Y1CgWadgKdGdOFXPxWOmIFAYdYkaZ9UbeLXv+EsTGc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
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

From: Peng Fan <peng.fan@nxp.com>

For OF_UPSTREAM support, the U-Boot headers under dt-bindings/ maybe
different with OF_UPSTREAM headers. So let OF_UPSTREAM headers be
included first when migrating to OF_UPSTREAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b80924241ec..b9c2d896c2e 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 # Use UBOOTINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 UBOOTINCLUDE    := \
+	-I$(srctree)/dts/upstream/include \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
 	$(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
@@ -835,8 +836,7 @@ UBOOTINCLUDE    := \
 				-I$(srctree)/arch/arm/thumb1/include), \
 			-I$(srctree)/arch/arm/thumb1/include)) \
 	-I$(srctree)/arch/$(ARCH)/include \
-	-include $(srctree)/include/linux/kconfig.h \
-	-I$(srctree)/dts/upstream/include
+	-include $(srctree)/include/linux/kconfig.h
 
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
@@ -907,7 +907,7 @@ ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
 PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
 else
 ifndef CONFIG_CC_IS_CLANG
-PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
+PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`)
 endif
 endif
 PLATFORM_LIBS += $(PLATFORM_LIBGCC)

-- 
2.35.3

