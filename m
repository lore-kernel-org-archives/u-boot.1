Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91E0C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3311F805D7;
	Wed,  4 Jun 2025 21:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="lh97Q/P6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4018B82AAA; Wed,  4 Jun 2025 21:56:25 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B0E8212B
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/FI4O2zxcBpmGcZAAXIPKjxE0Kr72hzzDfG+KvVD+EihkEPzJJZktDC261lF32VwKi17rf2CGs4PdQ5vdvrvghE2K4Ozt2vMjtswNzpixdOR4eexviumeJvJGEzQJU3DiIN5IlW6qfcBucfC59o0OE9OY+oAblt7a12ZxjhAKj1NRUE56yeUngUg+4Wi0e4GeSc8/t+ECzu1TprQhD4ilTIaUzTImcdsPcmJa3CxE40oHWU2Ap3HqOOvvLuq2oJzL6zOJC5wB8Be9NpFEBwhBt5bDjLlX/EVfek/WzM+FstgroKom/d0zBGAnpHUUjtewgkEm9at5nEiXOm5RjcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwDczO/qMOmukjMicsbgPHQ+Zn7ak3ZcdtDKoogB9eY=;
 b=gZvvn8vFQAwMtIGKfZ6tW/CMtLhsGulb+ATAFb3nF6wIOwRlWK21FbCXzRmTJi73ybJSxgQYddRpB5y61l2+zzzLrNFDWfTIb0lxpiHXkQcXIJUSktRs4MAXZRUoYJ5DHMtQNeLRSuakmbZkEVDML08FgTCg6CxqDHoAzAsABPEh0N0cGNDaGsvjTJXkHdgFmJ7UZrf9GdHu8WbSI8rc+VFfWDSYTQqG8uQjBR9r0quOrMl84QFmF2S9pxiLLxzwxKNZrV4Q5lcr61FqcPqGk+UUhm4SrtG6CXxPhvGniQhCrebVijH0i36GceHDyD2UFF6PAYHGefSZfh+iKaSlqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwDczO/qMOmukjMicsbgPHQ+Zn7ak3ZcdtDKoogB9eY=;
 b=lh97Q/P6YemIpOxuv3Kg5RiA0tPCg80aEHyhlrvfhKncxsiko4214F/yK1KKNAKrp4GPpf0SRGfu6TVM6lWKTW4SEYxqhuWPnNN+AAhuUSV0IwNVkWzgrtYBvRmswaXhiv6OczF3sa6x4qZn6cBzaUdY7+qDB/2BSGB565A1ayY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:22 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:22 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 06/12] m68k: drop pointless #if 0 block
Date: Wed,  4 Jun 2025 21:56:06 +0200
Message-ID: <20250604195612.2312979-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dbfd37-e8d4-4cf5-634f-08dda3a1e12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FKYN2FgRguozo58tfOd6LDrU5ym9oxPKL4xKu/z+8cBeksaCRirSqh3ZzsU4?=
 =?us-ascii?Q?PP0mn3s4GZ2EYdBlWPn59twQe6uozmDpH0cWDsz32v6wNdWEjN8XYypt91Zi?=
 =?us-ascii?Q?IGSRudZn+kUojK76e4oEk/jdY+aZzhOmPYXJ2huXHGw1gTo59TNYywr8tzTS?=
 =?us-ascii?Q?X9p7r8D6tZUlAd8B054RZnAFoEOQqMTtkGXbNjVLfWy+eLbP7ly1ZP78Cx/T?=
 =?us-ascii?Q?ndaVU2kXcSBTLy00zK4kF9nM7XhTseySJGPZ9eV9DFKCWxutdaxWNbYFSpsW?=
 =?us-ascii?Q?p6cNePTviHlfIIImL51y1Yot5o31piip43c0J7xuU74mnz8gSQ+EM2Pk6SrK?=
 =?us-ascii?Q?ucky+UDcNz3Y3r9J2rG9O9pOXum0S5hMC8oCyUkjvrIfkpX22PkLizX357Kw?=
 =?us-ascii?Q?B7OVy95TshQfvgVZXsiC/PmraNA5wyaNVTdlLXciVQhcZvDHJQldyyyoXMDG?=
 =?us-ascii?Q?nSyqwmJ7ZohMGNwec7fm4ryZUpfvs03Ym9k541LFAvVUhuZ9OsKdeaQRMQUz?=
 =?us-ascii?Q?t5A73bvX/KyBwwYKiywH8GcUfTfUBurxDkW6zilj7IlkS5/ZDU8yMcSch5q/?=
 =?us-ascii?Q?lm89crES0oxNoTUSM0GUwmUIZiLfKaYYCmfOaP6IhNBacCvY3avI5+UDRIZW?=
 =?us-ascii?Q?7LIt3N3AhY2Km+JRBQxT4sXuTZN06knPEUSSAJvA8OBcx00o/YQatnRk5mUZ?=
 =?us-ascii?Q?WxW95MzdXYX1mbBeTd/KClgsr5DEhDT9BV2XL+Wwpbog5vnEIL+YYMmnjf/3?=
 =?us-ascii?Q?4wZVDP90gwKBJNY7nNiFzNpm7qH1X6B/mD7zpybpjPpNdLjJZogQZsz5/ans?=
 =?us-ascii?Q?HsyCMLdEUJeC35wKXQQ//3DzsgCRlETGFlTb+WP9Q9PUUMaDciLWF2MopBad?=
 =?us-ascii?Q?LqSJdUoI6r6AP5hz7a+IGWxJrCB3JZNBK3sfqXZdgtzxkrCdpADBTtYTnwPD?=
 =?us-ascii?Q?8LirJRU5ueBEeBgbV2PjVic9lMxdrpmYyfS1ApXctzcBJYkhXz6q5Jm388el?=
 =?us-ascii?Q?GPhqGD96Eow74+Jj3qs7SVVJbRBn0m1KBDj8UtXGRMbwhEZQ4+kyNnT7gRZc?=
 =?us-ascii?Q?QlTTe3jq6Al1Dy1Amv+lVBhjqrpePSKvZC4OVOOL5Kc1gu/hM2F8oZy6zOUc?=
 =?us-ascii?Q?4UF1Ny7zHA9mrWa10tF20rF1pGSjlfYvXCHleQH8Yu2QCJJbK+n5SKwaRmnh?=
 =?us-ascii?Q?SDmrccCNBOz2p8A7MEDwkeWJlJWOmU9TU3AQaAMVADWYaZ2CzhCpI2B3XCeK?=
 =?us-ascii?Q?dvlczM4U9xB76l4ns/rDTKTukAFSO+fANdA2HiICoqfJrSUclhuz49pftNsB?=
 =?us-ascii?Q?gntl2ybolMLHKZgklea/hbHEJBcl0D0UmBBvOOjE4ql9V484YvpI8oozWls1?=
 =?us-ascii?Q?sLpIgH1QU9HMdEeDHBBfoPR1iUc3NlMToBIacFvgjHgcK2K0UfWFw58SNVs9?=
 =?us-ascii?Q?ME1o9m1b31g/We4FhqgxEQrwRioYQfKcaiufaKJEuVADCXD21U5wFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eshZcj82O+m9T01nEbEVxuxD9LlEsPBJUq0jxYnUm1WyKdxT2NmwJcKdIHBv?=
 =?us-ascii?Q?qaDvr4MIdCKjlOCOQHhpxkkqSpWf8A65hrAJ0kDMtBckN3jL+2A8CgnWjR1F?=
 =?us-ascii?Q?O1eIyoSc4v8uJltfse+2BpkVnsMa1gwdOvPLEaTOl8ZTj4iTaAK3ryI+mjPd?=
 =?us-ascii?Q?0nMUSBcKxbzI7cR0uSMHvW/nEwlVyzQXRnGda9+zm5MjL3Za/TypPynbJioo?=
 =?us-ascii?Q?KZky3qHlnj+BpB+uou45Uym+Dxb0Ta4s0ICuwh98WfuHEVXsv6Qfk3BBR9Gk?=
 =?us-ascii?Q?YR5Pr1u3QPRmsVXp3ATPf1ky5kfn9MFUxqEJ6+f8NTBumi8mIgMo18OcLapE?=
 =?us-ascii?Q?9G/jDxkGOX9AJYCrDhjOyThWVzGdxUynepSz9K3oj5mmkE7Z0Z6Kl/rHNxFu?=
 =?us-ascii?Q?pddlxjbkMGyx/U7YT7+yLAl8Jyy8ceAAYytDcvDteH9xNPB6uqAK2W62HPVa?=
 =?us-ascii?Q?3Pg6pb6qHoYfHAl37JM1f87DaeC1OxKVyXEyksUXHLyx2jGVZqDkCDcePqd/?=
 =?us-ascii?Q?hKDMQ+/8YxWuKwHtUicaUhY2dhIoYOvOiOCcIwu4e/FiD9YRQHpMYRM2IOTm?=
 =?us-ascii?Q?dvxGCwdl/+FF+PWWxPRyVXoVsVwd6bp9n9HTtU8L98unBdJqV79g4DUn2pHM?=
 =?us-ascii?Q?ZVni6VZMkB5abKyz+rp5rGRVA3f7DMaNbs7rLlxmU4XHqSy5H550Nh5lZ0cW?=
 =?us-ascii?Q?Ml1Ku8R7HtpJN/JUVxB2V0OsMz4jG/D65C2NBbU0IV+Ce07NP3jz2jikBXs4?=
 =?us-ascii?Q?l1Iy8xxASrXByutrJRq8ND9vGlWqfv71OuA3EUF5LoNP/VpdPmMKEUwcEC5J?=
 =?us-ascii?Q?yqADBso5fC1LV2eCndlE9d0E4FsSxq3b094JhZvwwNH1ay/u0C0dXGuaSynT?=
 =?us-ascii?Q?hv38CBc+eFDsqGjhL7+tEWdknQIn15L+WVTWlTRVRx0mFa1gU3NMMdffK5DC?=
 =?us-ascii?Q?SUsSkHJiZmw16mAxiTv4v1qNVipovKJI58cu61Q7/uTzHkWtGl3qozvf5LbG?=
 =?us-ascii?Q?san2b6PO0a+9b3lp3poVoB05l5BwoRDOGoOdVVPfxCVUn5hJmLnBN4BepTQA?=
 =?us-ascii?Q?ZGCSmrIL02EHFdHNS7Ze6EgeKR5S5jPkW1hZ1CGQA3O+bFVTD/g+Qa9cIeMb?=
 =?us-ascii?Q?iqqBNnw5Vmo7d3j1WPXgbXBYf5sD+wXTDbPvomkHZmpuK9Pnhjjs3GjzFdgJ?=
 =?us-ascii?Q?HyfbVJeFslZbMOvXXrhTXBuEvT6hzQaWa1i3P8RfyP3LPv/3dLnCHj3fp+zr?=
 =?us-ascii?Q?Ukdq1/LqiW57iNTUjISb3uEk9QtKHm20QLMocVUJ3VJyyzvVobORyB6p23K/?=
 =?us-ascii?Q?gxH6vNFKv3S5DSC3eWcEL0OBClQQwjbtzcVR6WJM0JMQ/W1Hk2PdU9bW2JZy?=
 =?us-ascii?Q?0x+l2YNrsxxGX/AmCobXk7rGupaAkNA7x8R1I6L6mS8khHVgEMI4ohMW1UVY?=
 =?us-ascii?Q?LRHdOB9fz3mPzFhK7ziLZwUrHy59Fm7FANnoBahgGq/O55n3Bi3TcorkctKn?=
 =?us-ascii?Q?y8B7nBUX2A7qhpnHHyWF2E49MrsFPzsHuNI/whXsF5Dr467RMKLyasx6Hu5y?=
 =?us-ascii?Q?C4DFgZ69pcIqODYnX/boM3ZYsNyVxMc7takTecsxGjc9YVsqfTGdjzkhplVw?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dbfd37-e8d4-4cf5-634f-08dda3a1e12e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:22.0439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zplwyGLWzzd6Qvesl8YNPu08QMYvnhw+gMLyPo5+w5kCO6FsK658Z/7DqDrfP/O8KtdbP7PmRpZ31V+GAaKu5/SM7ESlcSrtmqwrh+SS7gQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

The way DECLARE_GLOBAL_DATA_PTR is used, the stuff under #if 0 can
never compile as you cannot have a non-constant initializer at global
scope (and one would get linker errors as well because the 'gd' symbol
would be defined in multiple TUs).

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/m68k/include/asm/global_data.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
index 29b46645676..aea2ccabe08 100644
--- a/arch/m68k/include/asm/global_data.h
+++ b/arch/m68k/include/asm/global_data.h
@@ -32,11 +32,6 @@ struct arch_global_data {
 
 #include <asm-generic/global_data.h>
 
-#if 0
-extern gd_t *global_data;
-#define DECLARE_GLOBAL_DATA_PTR     gd_t *gd = global_data
-#else
 #define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("d7")
-#endif
 
 #endif /* __ASM_GBL_DATA_H */
-- 
2.49.0

