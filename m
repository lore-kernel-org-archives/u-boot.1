Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E039C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2D787FB5;
	Thu, 28 Mar 2024 10:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="U1rX6Cql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C843383CF3; Thu, 28 Mar 2024 10:01:23 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF6587D43
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezx2f8SY7RBbNNgLr1orR2bJK2ruLwo6vCg2PEu7TJ3NkJa3RxqxdBspLI5RKg3no3QkajncTXpZIgceu9Lb5xW37iyWnYqCbXy9WrI2d6+fpNdW6eryQOpsXL0+nycApi7rN7iPhB1chNvp51kmpd5SQHFnQdf2QLSX+rhW5z6BFjmaSON9DNjkBQc3cpxfcC2VCktAuDfT6nygDsHp2lXmmN6rDePwWDU+oqS3WWJ6KeUEu8iWRV7P/ucbbSfElHK+lz4Omizrd+Defmsgn8LIDQgiwrviRLFa6nUMemJ3IkTFKhtOdaYglBa1ke9VSmvadY9QZOWtjbLrrxFlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlqlY7q+JuVwTwzXu6UgWKB6ouP2apzBE4lh7XwZTA8=;
 b=j1sgKWH0l2dPDWF1NsIukvZnuuARtP1vuw+ED2HSsqHonpOiMiQyi6LoTwhVQ01u03TlElGu/HXnpdNR4wR5c4Sf1yzrr7AcDVldJp23dfTDzEVQqUQ44eP9BhjYTzxFtQcyLzcshgkpVr749feHAdNA5xMiBLzTnvv8/EQYHUWiDxY3DGFCUU9rVfkWAEnCN6lfStrUfd8OVjX8FpnNsCAQjaBMnWg75ULUjMz8M6gmr07Rvrny0aIHiBgsPNN/fSN63p7BcIlx+j1xB7wQTYYkVadzE7F+q0udKn0rcrV3Z20Ari8W8NTdRRx7LJjrkuuaUKnMkH47TNmt4jZgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlqlY7q+JuVwTwzXu6UgWKB6ouP2apzBE4lh7XwZTA8=;
 b=U1rX6CqlvljVQotqtpGUl/H8emXQR2RQFl005vbDh7AriNIuua5/kll+JufGGL2W69cUDboe/nSRdSxfdwOQ4fqL8cNBLJJC3uf8u7vDAHkwQqfIi9CfcZpjEpxtX+lrKjrJxfypML0EsPSnRBw7qNYIVMBsxWwaZ8alBRSZii8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAVPR08MB9578.eurprd08.prod.outlook.com (2603:10a6:102:310::10)
 with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 1/3] zynq: Add get function for multi boot address register
Date: Thu, 28 Mar 2024 10:01:08 +0100
Message-Id: <20240328090110.14683-2-lukas.funke-oss@weidmueller.com>
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
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAVPR08MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b72c2c9-0319-4a87-d761-08dc4f05a15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3/fsgHbPQ0ZqUdv1YSJEzWJz4HXbop2N1EU+XpkWoB1iHj/q19TNucL7f6VCBjo5ZCYRVEEh3Qu8O1Br78Ih4bhMeEtKqlhnYYsoj0V3Rcwr8XKR/JZWyKspGRs9MdMvAFcl3wCai0FtrU9on4sDKVU+CE1n7jhN/W6/SSPvQYbQ/sTf6v+34LMZRoLbfQbif+IidjT3tVymY5O8iFQy42eWdS6nuwFKvRZqhBrhDSRtom9/3fqqVqV9taSsjlfokeCTUW86mIjnse0jpNe0wq9aMroyIu294hAH7qfZ2sIQA46vIeOpSykZ5xSBGK2BxmXtRd8X4puQqV1V7pmAZiMgqabx4JV0ieq6+4RKvQQd7Fkj7mGa2Wurj3Mz3vSa0+0ucPznn2Ypdp200PO69JO+Q+hlD53D3YlCxJCUREJzW+g3wuI+PtTjGxzYu5V6hT5Zx5pzZnWbk/7pbo0iKDuaTIGJ2GfKdcz9o9OQ4BMP6lL7ZS6MOLWrmTw8kVpbLCHXGM3+XTRtnTqAnQ3cgdiSEFg/kB2QkBwftFQPo+CXdoR3J9FqYRegLpynPfjQC28WZlk4CV88adDV2rfPbFqRHe7zC9NB1Dk33Gbho00KeQYMrafgvdBE8xvmEcT3urH2L1g2krbdB7ilOABIyTHYPPVNjxy6nvj6wHlrgUmYoAcAVgv6bNTRG18c8Qg5KvFIveEfjOiHcGeQoDZwjpPeX1EnJ9TA3r0Ciugttg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OiUEaoLbk05tLhRRe3VV1P1fN7J/Mj0hQkLNseOLk/ItLn3r/psw6VXiBX/f?=
 =?us-ascii?Q?OnoLYQtFWRhEPX8Bi/NMEqF/OxWFHCU7/ewy6cuOAhCHTQg0wW2TxV8eEfv7?=
 =?us-ascii?Q?vViuE6KvV7kslRtxcvcCRd87A837zoVgbCX5EPMHQ2qI5A/YHnKat6UamI9c?=
 =?us-ascii?Q?2t4YoHkr7sRezQbJaRwdit22+QsS8Fe1TQ3gdTbS7TeNbdTXY9jBw1NSPImb?=
 =?us-ascii?Q?mmd5avENC7I8Jg1vVo16oj+uMX7q3woQ6v7Rriibqt+ZbpFjQ9pBghO/9dNM?=
 =?us-ascii?Q?ilVeInJ+LSOy7OrIoMfILPVkawTJzkQ9zTD/WP6jKJveWl17kX8ncrE4RFFm?=
 =?us-ascii?Q?kWVCKSY2YDB+AAzJdPXg2828Y6Ju7tsfORY6yBWeNs6g+jaqi4c/c3HM1z1j?=
 =?us-ascii?Q?LxozG3TmtOnIqPOdi2o2JrDR35kOkheW7k0HPj5Ibzu9aLSYJg36Z+rGAQ9l?=
 =?us-ascii?Q?eqokQX9tanhwzRta4FgxCzSKiLExAHDGQl7a9dFZLSkCBTFGj1j9Aot0hKiL?=
 =?us-ascii?Q?qoOXehTj6rWo0nO08rEPGM4JsHRYkhZC1PVSI08FmkYeZ3gMltV3J1LbHbKR?=
 =?us-ascii?Q?vDNqoaClOytxn1atosKxvryaf+O15K5JYgD7c3KlH8A2NPmRgDDSEngdlV0B?=
 =?us-ascii?Q?Vy9dbALoys9cutAOVr472gbqZNTGzvYazDdPz/kmLt1mKg8KB8Jn35GF9Yf6?=
 =?us-ascii?Q?mi+Nm2/iIlq9tIKBIQvcxx8GvBaun9RcXdmmVCwFDXZ6js6Y5M60aQec+j/n?=
 =?us-ascii?Q?CLk5UgmAbQezAsfeoencjwCtMaOXK5rp6zARswhCyYCbzUPpq6uRuH0mFRuk?=
 =?us-ascii?Q?quyiXgWZYXcHs6crvQgTQcz8qXBakKuUiyvxiyZJ0MYns5SMu+ldSJRR65Mm?=
 =?us-ascii?Q?1iOpdknw03n0yKCgYimVI0SiWdxlhvf9iYWLnUoLBKBIWoFLwHZcatClpQKm?=
 =?us-ascii?Q?whb1aULoLc8LRIIgF2lNHeP0rm3Uk6uy/SZDtLtr4Axw6KytavBbhz9U06Hq?=
 =?us-ascii?Q?i2n2Qr4/H5oY2iI16ufpc7FceB+4QZUoigR/anWTZAoualhue9Yys4lpCXcd?=
 =?us-ascii?Q?xLITQSkbbdzxknAvn/+g2up2xqtuEmv25q12Hw6j0f1iYffH5URiBc1Dm2Tw?=
 =?us-ascii?Q?gd1MxvSZ91bGcTdJGhHPN1vlPnLht4amir/CMs7/ffle3pRLfCwjrqpj9NAN?=
 =?us-ascii?Q?wBlqf+7pqunT9jh1l0ZjUPQmDxL91YDU8dwKYJGeNLU948feikGd2Tzc0mhO?=
 =?us-ascii?Q?G6Nm2ZRCQ/FhSXqADVoOmgKIJX5izcuzm1pHHiZNmFImgRr2mmwdybq7CMML?=
 =?us-ascii?Q?lKqIHv0UKYjoJ9uWO7RfRWiNh+183PRSynqwxhY8P9ZYFn05IILjkF8zXfbL?=
 =?us-ascii?Q?4aXjwf7JKm21gg6FH2RpjD/CJXiofzVB7zDPj9EqpIqGjJIg7Cs5fV3kd4Kk?=
 =?us-ascii?Q?GGaTslIpvfcsqoxl5VCin1KhrcEBZN3FEEOEpWKg+DWPBUOx6i1NzeIAnu70?=
 =?us-ascii?Q?mPWvv8Nx05V/GfxCUQPjPHtBW12zi5qAsnD4QsqlVlKV1byFWmVOo68Sm39S?=
 =?us-ascii?Q?4p36ARXmkqyi3KG8N++7lFdBodOzpmtY+Jwp2w4j01QlK271rg2CRW5QWVd/?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b72c2c9-0319-4a87-d761-08dc4f05a15e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:01:18.1299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+J+IOAM+n69odletwhmji8uhAD2tDFHNjnrXdYbj0v8Bqvm9Ypo1xa3dTLb+b+viIhnmHd77pzuDVk4fJqz2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9578
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

This commit adds a function to get/set the multiboot register. This
becomes handy in order to ensure a fresh bootimage search after reset.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/arm/mach-zynq/cpu.c                    | 19 +++++++++++++++++--
 arch/arm/mach-zynq/include/mach/hardware.h  |  3 ++-
 arch/arm/mach-zynq/include/mach/sys_proto.h |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-zynq/cpu.c b/arch/arm/mach-zynq/cpu.c
index 3b6518c71c..3d2866422e 100644
--- a/arch/arm/mach-zynq/cpu.c
+++ b/arch/arm/mach-zynq/cpu.c
@@ -14,8 +14,9 @@
 #include <asm/arch/ps7_init_gpl.h>
 #include <asm/arch/sys_proto.h>
 
-#define ZYNQ_SILICON_VER_MASK	0xF0000000
-#define ZYNQ_SILICON_VER_SHIFT	28
+#define ZYNQ_SILICON_VER_MASK		0xF0000000
+#define ZYNQ_SILICON_VER_SHIFT		28
+#define ZYNQ_MULTIBOOT_ADDR_MASK	0x00001FFF
 
 #if CONFIG_IS_ENABLED(FPGA)
 xilinx_desc fpga = {
@@ -79,6 +80,20 @@ unsigned int zynq_get_silicon_version(void)
 						>> ZYNQ_SILICON_VER_SHIFT;
 }
 
+unsigned int zynq_get_mulitboot_addr(void)
+{
+	return readl(&devcfg_base->multiboot_addr) & ZYNQ_MULTIBOOT_ADDR_MASK;
+}
+
+void zynq_set_mulitboot_addr(unsigned int value)
+{
+	unsigned int v = readl(&devcfg_base->multiboot_addr);
+
+	v &= ~ZYNQ_MULTIBOOT_ADDR_MASK;
+	v |= value & ZYNQ_MULTIBOOT_ADDR_MASK;
+	writel(v, &devcfg_base->multiboot_addr);
+}
+
 void reset_cpu(void)
 {
 	zynq_slcr_cpu_reset();
diff --git a/arch/arm/mach-zynq/include/mach/hardware.h b/arch/arm/mach-zynq/include/mach/hardware.h
index 89eb565c94..9199baccfa 100644
--- a/arch/arm/mach-zynq/include/mach/hardware.h
+++ b/arch/arm/mach-zynq/include/mach/hardware.h
@@ -96,7 +96,8 @@ struct devcfg_regs {
 	u32 dma_src_len; /* 0x20 */
 	u32 dma_dst_len; /* 0x24 */
 	u32 rom_shadow; /* 0x28 */
-	u32 reserved1[2];
+	u32 multiboot_addr; /* 0x2c */
+	u32 reserved1[1];
 	u32 unlock; /* 0x34 */
 	u32 reserved2[18];
 	u32 mctrl; /* 0x80 */
diff --git a/arch/arm/mach-zynq/include/mach/sys_proto.h b/arch/arm/mach-zynq/include/mach/sys_proto.h
index 268ec50ad8..6b85682808 100644
--- a/arch/arm/mach-zynq/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynq/include/mach/sys_proto.h
@@ -16,5 +16,7 @@ extern u32 zynq_slcr_get_idcode(void);
 extern int zynq_slcr_get_mio_pin_status(const char *periph);
 extern void zynq_ddrc_init(void);
 extern unsigned int zynq_get_silicon_version(void);
+extern unsigned int zynq_get_mulitboot_addr(void);
+extern void zynq_set_mulitboot_addr(unsigned int);
 
 #endif /* _SYS_PROTO_H_ */
-- 
2.30.2

