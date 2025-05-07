Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86331C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 10:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0058272A;
	Wed,  7 May 2025 12:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Wn+67CXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401CC8212F; Wed,  7 May 2025 12:58:59 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45778212F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 12:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zhrm59qZDdMwIeNilHsRAf7f/I9/MxkUk/XEAJkgPzBy9LKWlcQRV5kHi4H1UgcQHuCsy8qKy7ioamfiHgBL16eBE+5FCwvR1oQdlMbXE28q2ilFOQwM6wTGctfZb6bdgsNo75U2p8f1QBPGuMf1lBMBvwkq4OdCMp7BdyKf39zs6NnGs9CmdV9Q4sJBpSvwFQMLsnFW0wZ5uoFNbFUHWaMOOGIjNd4w82n3R911UH1C+3WrSUcyx2dyX8oU1csRmaYJqCoZZBbneBLj06H7C+Fk0Wo7KGNXVuPX64d67E9+j/gO2bnVZM/hNo/443CZmaWw2Sl4xPwzuKrMgtj6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9SWCDs5cTBdfInPLCBOb432/kOxfbAtun+2DCc1sis=;
 b=vnED1krEnynfBwh7xU7Uj+txBf3raSCEr2r5paPz3sRsLImrFOSosmPh8m9nlibDjxpIEkFHGRCIQN4KgtF8Ht0bT8WLjPP48leQluoUnAnNZ9W/FKpJ5/26McCtJhTISUrVEo4XOki9qUPrH023px2sPAskZYXIQWGYuqXzUYZDhJrFGbf+feRe/X+6nsKvUv3QWtGtDbEgyl+EVf6UuzsWCb1m4cieuPZVU+dZjBmN6Ts38SQHS2t4kVhaK1uTCKftdsuckTnSpZQuzRXaZBpHnRrceoq25MEimnIBtNlV0pIDxiD71FedANwOpBORJEN985+WWEJhTgovWblQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9SWCDs5cTBdfInPLCBOb432/kOxfbAtun+2DCc1sis=;
 b=Wn+67CXjVqGqCjFpbJ+HP9RcyR2aPq0nhBHjZJrFXeDJYf36KlWCrF+7tC1A+wHz0V3UXfEO2/AgqtDbwnYxOBZV6s9AzJQGR/poe/yXxTWQ3+WAmn139AP65AChWpfEcnhB4ZMt8WgchticgA+elESsAZqKRjvfXw7jL6IWGSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 10:58:52 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 10:58:52 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/3] cyclic: document new guarantees for cyclic_(un)register
Date: Wed,  7 May 2025 12:58:21 +0200
Message-ID: <20250507105821.484442-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507105821.484442-1-ravi@prevas.dk>
References: <20250507105821.484442-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0118.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:9::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a5fd6b-62a2-45ae-c9df-08dd8d562716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MEjKVXynVOMIMoJu07xAqOc7dKsNSiJxYoGiLNbnPgNrDxvXNjGXd8vd+VZ2?=
 =?us-ascii?Q?Orh4j0+M65Vn4m5uZHT5wV08paoxMVJqchZQw+lqpC3at/XqwTiPu1pp4Jjx?=
 =?us-ascii?Q?qd4guhwzSt0vnd2aiqyxpHZh2FCSlGG7r2f5tHeBqZ362TwJZTG7kGwUquZR?=
 =?us-ascii?Q?V/TAN23dubnYk4RT6uO+9BGidV/Wlk64nTD+hmnh4MZEoUHdLD1ntM6jeGJ8?=
 =?us-ascii?Q?JBfJEzbRXyumZK3hEyixX4XT2aVGj/ZlYbIxhRz3BvdR5kpEgsQ/8snmmx4/?=
 =?us-ascii?Q?dsoy8yxmnbW6/5MncpBvsGJgznD/6sX5ePEs0oSHKgxM5KQ7SNHJTXZQSIgQ?=
 =?us-ascii?Q?yzPPrFTwhIc8LG1dmZtmErVeTr2Plo8/TizQ+L497ZLm/FH1I4OjTJasgKnO?=
 =?us-ascii?Q?L2XCIDCI+4MvEIpke3alf5fxud7XyZv9yug10qMyHDoWxvg429KtFr/kvGSi?=
 =?us-ascii?Q?kfR/5nngGhgORvohbBO9gHFn3onXe/cb3jRDuM7SKThdAPanwVurvTmKjnFr?=
 =?us-ascii?Q?F77na2tSmWhsjCDqpRkX/3Jm8aIOpCYHMZaS2f1VRoEV0L2fp1wlL4UzrqWx?=
 =?us-ascii?Q?ZyD6nHfwVfrxZ4HJjzFJ2zP3s1hu0YRF9f4qpEdnoi8mSDkMpG8PVqXEpTVA?=
 =?us-ascii?Q?vY2syxCQ/tg1AiRukazDTmU8m4f0Bv2w63Z2Sc8oSnkbVha1sGhw//CsoFN2?=
 =?us-ascii?Q?ucpODhqZWJ/lM34pPB5LJShc0MJs7VKlY9904/FNMV4uEZAejNy+1H1dFhFk?=
 =?us-ascii?Q?irs7dmmjfHl+j+j/W0gSu+zgFen+1NXFZbynvwIwp/PphNcks1jCF1kjhSwU?=
 =?us-ascii?Q?ipEexLfe2LAX+1grxKvdSmRqsZdmMx9//SidxeSo2DpQnrvQa8FHGTMjjjnV?=
 =?us-ascii?Q?r/q1QnmxWgW1L7T8NnQnMaciuIVv0qUvMxdTy/tlR5npt/twm9/q4/rcC+SW?=
 =?us-ascii?Q?770RJYn0dKPob8DH85bv1JJw1XznbbUqKB+emNOb+9HC05Vd4JpnJuj3r1bg?=
 =?us-ascii?Q?8bXCfNFaXHaOAxEy+TrCpLKPlHHvHzOQnuSsMtt9+wwgucFDgpgpkYADg+yq?=
 =?us-ascii?Q?zoPHAODzJbmBh6ly6LtRP71XQrNt5EvNs13XccsU36p+JgAruifwjnQm9Fzl?=
 =?us-ascii?Q?9bY7mm+oZwbB1tH/OmwIkb/Thtahegpg3hXml3S7zupIk6QjhKXZ2niJmgJs?=
 =?us-ascii?Q?oNwyWQ5qKyb5ticloUPFL6UWbdqtCf48vqeQ2LhmVqM801S9/x8CU8XzHbPo?=
 =?us-ascii?Q?hGnH87VOLHE7IrmxjRgYxqizmtpDvHDEPNKpR4kfMdTCFBtZ6SpvMoUe/cLL?=
 =?us-ascii?Q?avGsnkwnxTsNGz1CJ8tRfXVVDbGAfsJmwNUFkUjfpHnq+FW8TizdDbKTeXkH?=
 =?us-ascii?Q?BxKkxo0m5jX89dSZ7pw62YAT6Q6ZW3h+4OMiIXYzp8iGIj6QL6BA4ivOXS97?=
 =?us-ascii?Q?6LtC1oeEBlp68YDrD2iEx8KBwr06HCbetQqv+8aHTGrcYoWHGtgGTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kQReSIKo5UeijnFPNfLatcddEoD3mWaRxravlyO9Meq4AaocSl2Rl6GIVVE?=
 =?us-ascii?Q?DhVUbkHV0FrSUWvfJBPOg5ifRAyrkXBB2YLePwzm4KJdkapxqK0/j7rNjRGp?=
 =?us-ascii?Q?zjO27UrLjEY8mgsYVpBYd/hZAs/zv9OL3FRHbCNb2pudC5IA+ENx+mm4/ToE?=
 =?us-ascii?Q?HTNbwjU2LEDLJAM3NEAy49M1SV9z0gGOTYNLAdpKj1cPeqIGDfjbDlqoSOMf?=
 =?us-ascii?Q?zkWMao/JDRITlfXej4WnHYVmYOmAQKQ2fAA08TeBR0yJl57aGZsnODlrZjJ0?=
 =?us-ascii?Q?/6XIHJwE7zvIBb8aSJzu7cr8XYYIVtYXKewQyUD+kO/fDZYNiNMQTRWoA9y/?=
 =?us-ascii?Q?dBSlPEWsZInVBEgd30yO2w8QKlAzivLoRS/s3eqRjsXiQywzvUqZ6z6gOI1K?=
 =?us-ascii?Q?KQbX9uq734jZWq2JcfcTrvp4Muwzz7shtNz9O7lprwlfG/7wkbKqUpTPTW5M?=
 =?us-ascii?Q?D9pDpQlwvKg2g93Bs3ecF+HFm6XSZ5hUm+xuJp99ZaI9kyFfrODlOR0hsYe+?=
 =?us-ascii?Q?+vttoZtvIXsx/EeEiMtYJKeJzobrZL77Z7PCVvwvKpy9UXwhqA9RLv4Q/fuM?=
 =?us-ascii?Q?dfmjYTsofm3cejlmlr/aNrGqqrJ6ywFZYPTKEvphA7VqZSjr1XP44Mj/BLM6?=
 =?us-ascii?Q?9HPLGjuSQZfD0QIs321NxwKvvwXks1A3AImHvbI+5VFxMt6brF14dnQ5X2QJ?=
 =?us-ascii?Q?pxVe+5GTfmb1gvjROK0p5BxlxvwOccrUMRTU6jfF9j45SYUtBB9e38Vt07YW?=
 =?us-ascii?Q?Q3BI33Hd4NrM1UR+6FspaOkEx4BqzqosyfI09kEqdcWz6jCn762IuBgD43Re?=
 =?us-ascii?Q?6U9vd5mMyB7ZOnIbsW+i1RLQKh5LoekBE63By5n39nc7++zwXbrozHODqpOm?=
 =?us-ascii?Q?WDc0jUHKUxDOatkBn1orH2BOEsjWFCqnos0rgMeOCWo3L6wdFPGFKJbJrTwe?=
 =?us-ascii?Q?No0J4PNS/NFXMCibE23urrm9jDr6Bk0x4FkAicSEn0VpOhhWzCM/X3bkY+Ir?=
 =?us-ascii?Q?3Wf2Yt3Ed40+9drFOlHYS6js03u2Oydw8biZpyxbsiA8s8FPU7bwkSsTKOtU?=
 =?us-ascii?Q?2kjJGJVbNnxQexC8gtrb+0GVxDQiIcXyi5y2Ihvw8gYGQf920RMzLedaMMT4?=
 =?us-ascii?Q?AyPKHEBqBA4kYLTxusOSd5Z0a3T6i2F11hxB1QzeHs7CGlIdLf0DK8wccbDr?=
 =?us-ascii?Q?vGqaRqut84IaoJVklYQcken091mrdFHGYcjeVykBq/yoSnhSk6UHpz1Pq61g?=
 =?us-ascii?Q?0LEZfzSWEzGvsx7eJtQyz4oPGZLtFJCb6SEY6frS5uNlDfd67dvoxP9uxZMr?=
 =?us-ascii?Q?yYDaCBX89qknXBiTAangygBythoYL66DjMJgF8JkPJAEQvk2uH5EyV4FkltY?=
 =?us-ascii?Q?g8sHCAW/3lX5taPWN74g1gE/oDLba1Gg3tI/4AJwdfJUFDprOCZ55OVJN6+4?=
 =?us-ascii?Q?hlI4l2sPrfRH8qeL2+EPviSkatdmhunoU+PmvZohuPfv/FjhGFQnZJzd7GyH?=
 =?us-ascii?Q?s+dkijJMogbMWPAAvIzTUlu+oog/kOyUPwvceubcUA5SAqQHy5pZjxIWysxS?=
 =?us-ascii?Q?jKQ2RPOcGLC5F/3B0sljoIsuuPK4f8SXsOpSiAoyPhXNm1WBx5eoZAwjT0vZ?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a5fd6b-62a2-45ae-c9df-08dd8d562716
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:58:52.0229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znkpLzIFqxxGePf6F7750u/VGr8Qv4B+Z8OjnaTkkEl0DozIwGQ2kdpPUymxZXb9nLniYTWnj6PNxxKhUBvaQgmEHaomQHtGVrWibuPZmxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8807
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
 doc/develop/cyclic.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 6f1da6f0d9b..a99b17052f5 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -54,3 +54,16 @@ responsible for calling all registered cyclic functions, into the
 common schedule() function. This guarantees that cyclic_run() is
 executed very often, which is necessary for the cyclic functions to
 get scheduled and executed at their configured periods.
+
+Idempotence
+-----------
+
+Both the cyclic_register() and cyclic_unregister() functions are safe
+to call on any struct cyclic_info, regardless of whether that instance
+is already registered or not.
+
+More specifically, calling cyclic_unregister() with a cyclic_info
+which is not currently registered is a no-op, while calling
+cyclic_register() with a cyclic_info which is currently registered
+results in it being automatically unregistered, and then registered
+with the new callback function and timeout parameters.
-- 
2.49.0

