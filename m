Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D51CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063C888105;
	Thu, 28 Mar 2024 10:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="3OckwAif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 486F2880FE; Thu, 28 Mar 2024 10:01:28 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0716.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC65C87D55
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqK5H0Jh4962cRUVJz2SQZp+4/ThEBdrOd8Cza/ilKL3YzoQ+4yZ2UEtzcRfLcv/U2MbGME1Ty6cj4i7/GRicuis/OM5HJKh5N2iacL0oakp4VqZ0JkcyNu6K77i9/q6wZ1OQijA8WPQP+IPyAR2BKwIqUwXzaU3Exnwc15Cdvxx/80CXoxB1p7tZ2Ayq9HuIkaPk+7LIrLv/RRruDsMH/ZgyuoJT/tZrpJk+ecx8Wk4m6eBj41GYT9uJmoAzhjbaG3azt60aw87Jblp6rbWQsmCj2vziWbUfqTc4qm5x+QNoxdBaVHMrt/KbzG+tMcpbNUdQA3xZCRZ0yInUTtxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evdjx9IhQcu4FhPH4vbI3hHRu5dw3rjUPcGc4THnFo0=;
 b=QrbCLQruWuLt2RDuyYU+ra4ZPlPogAGhqyhsa1M0/aGxZxiwZqtlQAiS+3aDbm4ZFSYOzFe0e+hJA6BO+ZvuJK33lS1z3QOjo3r1qXHqxP5Djf0IbePQzHaQ55e2OD6CH7DDflIai+xcLHrdaVR8tV3NtdKNRldovceSMQrPkGd//h27P8yfhtMjg0axfIjrGK99A1141anRXvVBjP2ae3oO13mD8povzTd1UfrTyvwQJV8T+jv6xtka0zD4J3R2MPEGNmmW7IndBmbT231+i+i9ptsor0RFwxj/3nAr3oRaXWTLYqRlbvmAOoRpV44vB4HZvCnIsgKeS05fcS19PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evdjx9IhQcu4FhPH4vbI3hHRu5dw3rjUPcGc4THnFo0=;
 b=3OckwAifs8I2F13pH5ji/t3KkyhEy8rS4d7i35fNC4uOSYhqt20yHG0Hi8fXFfzLmeIdtbwIQ26UrLNgoBAVz8i5tlQcoOLvdb4o5wyy7Rz+/t7B8yGYCT2mxp2xIYlndahRR3krqcyrRwQKXGLix8QPys4LsXlDtSk6qLPg1ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB3PR08MB9035.eurprd08.prod.outlook.com (2603:10a6:10:429::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:01:18 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:01:18 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] zynq: Add function to enable JTAG
Date: Thu, 28 Mar 2024 10:01:09 +0100
Message-Id: <20240328090110.14683-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240328090110.14683-1-lukas.funke-oss@weidmueller.com>
References: <20240328090110.14683-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB3PR08MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f99b9a-984c-4fae-66b2-08dc4f05a197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLqWBUM8d/xVyHhKrujX1hfk3hriZ/7X4igP0IijI5Cf2Aez4ZFeOPfKCndh0mqgAi7bXXhkrKKL5H7uwbrjx0YXCXbNIgBm73X2esFuZTdvwHCi6m4l81bJcsguyB+VTbFloj9l94QWJ1HG2IY4qUff5V7apXlVyDMqCuByQbxyrKcbltov/Slo5bK88b3H03UyeKuPzcrn2qFER4rZbR1J1B/UUMiZGIFEVIkvK6jYqRf9q6QKQiZcwLFUHqB8HZJB15AYUb9m4z7bdVvHHacAL27Dtyq+zv7pi/LnhzMnuRg2qNz3asiUbbNvKHL+oKCQchJCFgu7Tv6ncR+HTmzokJc8YZTMd2/miFnyJio8coMp0hQ8ybabGWVQMQ/cJYWWI/G+/ConOYY38sTaZ2KJwMwgYlLuRX82c7a74V1YEmd+bU0hreYfOUmjCwZ+H0uxehKKUdmPaM9N9SZJJeRHVhtjIEELg7wSBtzqQl2mlsb8FPklIXll5OZDFarI37kMd56GvqHMvNil4ZbeHr7NpK2q+zZ2Ueh48QcX7VaxDpsnl7Q2NVfzDS30hgQ+srVfTop5t0HrU+OedghfLeGZ4BEwmglOPkTfwo05K1kY645hmXqm0QDKENRSme9ygozUjwjbgCa7H+zG2O+Vc8ptBfjcRjo7OO9xiftV0bYABYwizzq0miktsGnMdK0BDHI3Q2uyiS0RN91CoyF9Tna4eaNgjnO++jfa4Z0fVms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmzdCZRtD+W8yRlFUSai/kEZYngY6nIgxpMqc3QnzIdlDWbRmDCJxs9C2LY3?=
 =?us-ascii?Q?ybDILLNzGUQqtRc/ytC+M6j3UNlp8CHgKMkmdFAMRip9xtGkUR0Kzt0EG9cV?=
 =?us-ascii?Q?XpzK/3ukSW+EB8SWia+0A6iBVjid5qhcEKpIDfYXZ1lbMj6iCHo3o9n9PnR6?=
 =?us-ascii?Q?rIuh7+6blt5+qA9kHklVCXIgwm1tOkkxL+vf27xvjYeSJ657HbJ87Bud5WgW?=
 =?us-ascii?Q?wCUK8ZXan9COa+qMKB335sj/Zp+S8Q+mWEoVhzxbSea39tFEoGAwiORcREKK?=
 =?us-ascii?Q?aISxnOZ4euxRdLZBOkXJ9BB1VqrNpkjGK1Rdj640xqLoEmTSD8xvlvQrXcrx?=
 =?us-ascii?Q?pjsC/7Tls9d85O08BRMgNwSnm8I3ifgY1cncBCq7hww55KI29OTOFggU1oaQ?=
 =?us-ascii?Q?7+SFEQOEd+yg0gQyuKrLkIWIhAMgl1xC8N5L3UehgpCgABNo8rFOa46PshRk?=
 =?us-ascii?Q?Ptc8Bm8k3WR9gdjw6AlYZ/XDm71JhHY8jbhPx5aX8jE7awTEnJJCNpPc5qAX?=
 =?us-ascii?Q?HBScxz+h75Fo6MVjt6DuIhbjBSSbLvGwcZZJeIPesBNNWtNVSzmCCGbPU3FI?=
 =?us-ascii?Q?hAgPerTvZ7M3zSwkQDffD+5SMSeyPEphXZGstAlTRoCRo5zhkEX5Rjbdu5dQ?=
 =?us-ascii?Q?CjX6CmGCM2smAq8B/ev65jjjkm6JBhriNz7ixQzIGQZZ9Z9WFei4XHaxv42/?=
 =?us-ascii?Q?JLu1jHTP32f5dI33pnqtRMBT4OFRGSr4+J5i2ckeal5ezIPPWMACCEveO/xa?=
 =?us-ascii?Q?5ZPLtQKWpIQfssJTrjxOuQWdteBUtahQc6qJHtjsIA9XKzUYTixVQ6v7tM7k?=
 =?us-ascii?Q?9XUoGwOrGoCAnDB5zCtfhrHXZgMTR8cqM/+njCB3YogUgZpPOt1EpYqY/QBz?=
 =?us-ascii?Q?kTuA/2bLmeD7nbOVV1z+AftwYiV41Zw3E8TvVSgyvHdvxcBg3B6vLa6Cp3YW?=
 =?us-ascii?Q?+NH2jdWPUcnywDLvwmnBrQC//i9RtHZNikXZidh/InL7ODzBe9zVQKtL1Ufw?=
 =?us-ascii?Q?AorwroO5QLHpa/iHn+hGYKkbUMVI4rlatG86OCp1W70xGNg6ovYr6TuVhOZ8?=
 =?us-ascii?Q?VkC/dyc+sjAe5fkXw8sVZxfE55Wz6mmIq2xyqref9yVBbVNyGzWzPP/41I2z?=
 =?us-ascii?Q?EF2KpVYK9GdmTS2IVYo7rYfJabMKX/2ehoijC370+ncc6GZ2L0k3Zrt4rvbb?=
 =?us-ascii?Q?bVJ0H9UNwryuIrNPz7uSxDit8MssojpQVpPSpsV6rHq20xywZF4TEq3cBHWj?=
 =?us-ascii?Q?wggU4gUras2OI+OwWzYyYAEVI4wCNY2OuQRKxHZi8KSeWrzZqjZKUJ7/V8Gy?=
 =?us-ascii?Q?LzofbIqjzYE1UUkXS3/XBELwH6IOVcjTNAFK+DIPbxhR5k8g+1/7OXz8l1/s?=
 =?us-ascii?Q?2T7uomFtWa+YXSiQVRnrNvkW5UUxgivKRUI9X8GQh9Vr3gk+Sj/BhVApdhPi?=
 =?us-ascii?Q?wtN/w5avpZN37NEh4ggxsK2Rm4K76YOS8LxgAYguMNVqSa/3UX+bCWz+9KCC?=
 =?us-ascii?Q?wVdfLLisxUA8R1t9mKgBEweadjpKcE0tI2V+RCXhf8UjbPs4LrhkTdAw68X9?=
 =?us-ascii?Q?oJq5NyBOEnWGiseuWvGKktJk1KxZuHrbWZCSCRvYt50L9SXnRAmd4BDxC0sa?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f99b9a-984c-4fae-66b2-08dc4f05a197
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:01:18.5270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KSKa+0dmW13u/Wbw0eKVtPLbpiMFuJZrhSYInBopblWNjkFi2+RLx7NgxD47S/qAjzeJWgAbgvOyyaXhiqVLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9035
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

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

In non-secure boot mode jtag is restored by the BootROM. In secure boot
mode jtag has to be restored by the trusted application, i.e. the
bootloader.

This commit adds a function to enable the jtag interface on zynq
devices from u-boot.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/arm/mach-zynq/cpu.c                    | 19 +++++++++++++++++++
 arch/arm/mach-zynq/include/mach/sys_proto.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-zynq/cpu.c b/arch/arm/mach-zynq/cpu.c
index 3d2866422e..b8d413b69a 100644
--- a/arch/arm/mach-zynq/cpu.c
+++ b/arch/arm/mach-zynq/cpu.c
@@ -14,6 +14,13 @@
 #include <asm/arch/ps7_init_gpl.h>
 #include <asm/arch/sys_proto.h>
 
+#define ZYNQ_DEV_CFG_CTRL_DAP_EN		GENMASK(0, 2)
+#define ZYNQ_DEV_CFG_CTRL_DBGEN			BIT(3)
+#define ZYNQ_DEV_CFG_CTRL_NIDEN			BIT(4)
+#define ZYNQ_DEV_CFG_CTRL_SPIDEM		BIT(5)
+#define ZYNQ_DEV_CFG_CTRL_SPNIDEN		BIT(6)
+#define ZYNQ_DEV_CFG_CTRL_JTAG_CHAIN_DIS	BIT(23)
+
 #define ZYNQ_SILICON_VER_MASK		0xF0000000
 #define ZYNQ_SILICON_VER_SHIFT		28
 #define ZYNQ_MULTIBOOT_ADDR_MASK	0x00001FFF
@@ -74,6 +81,18 @@ int arch_cpu_init(void)
 	return 0;
 }
 
+void zynq_enable_jtag(void)
+{
+	unsigned int v;
+
+	v = readl(&devcfg_base->ctrl);
+	v &= ~ZYNQ_DEV_CFG_CTRL_JTAG_CHAIN_DIS;
+	v |= ZYNQ_DEV_CFG_CTRL_DAP_EN | ZYNQ_DEV_CFG_CTRL_DBGEN
+	   | ZYNQ_DEV_CFG_CTRL_NIDEN | ZYNQ_DEV_CFG_CTRL_NIDEN
+	   | ZYNQ_DEV_CFG_CTRL_SPIDEM | ZYNQ_DEV_CFG_CTRL_SPNIDEN;
+	writel(v, &devcfg_base->ctrl);
+}
+
 unsigned int zynq_get_silicon_version(void)
 {
 	return (readl(&devcfg_base->mctrl) & ZYNQ_SILICON_VER_MASK)
diff --git a/arch/arm/mach-zynq/include/mach/sys_proto.h b/arch/arm/mach-zynq/include/mach/sys_proto.h
index 6b85682808..f583ef090d 100644
--- a/arch/arm/mach-zynq/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynq/include/mach/sys_proto.h
@@ -15,6 +15,7 @@ extern u32 zynq_slcr_get_boot_mode(void);
 extern u32 zynq_slcr_get_idcode(void);
 extern int zynq_slcr_get_mio_pin_status(const char *periph);
 extern void zynq_ddrc_init(void);
+extern void zynq_enable_jtag(void);
 extern unsigned int zynq_get_silicon_version(void);
 extern unsigned int zynq_get_mulitboot_addr(void);
 extern void zynq_set_mulitboot_addr(unsigned int);
-- 
2.30.2

