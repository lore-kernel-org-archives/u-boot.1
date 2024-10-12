Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8788BD1A42C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB3C88C4D;
	Sat, 12 Oct 2024 05:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC64B88CA1; Sat, 12 Oct 2024 05:13:59 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9491388AB2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esSSMROTwjVuQUHDVqCLqQtCEJScaH7yYipwx/2LEd1mwcGhBK855FyR0aS2CujSnGF+2Ft7PBbldP5jntiXFiXstQ5A0pMnHlCaAFAUOXzuustikYgnzkQrYpPiJn8w0UZivb5bRh+JPbX1bwfIIQskZ7ftkrCBfLAJltJcMOUSwLYk+gFmCEz9FDRB8zbEXkhMf+B4m9hhJ6qDche/tS5T8dXXqnsRUolN2zu6bAoIS1KI6/gC/OtxB/iWPrm/7cnId8USYqakOepi4G35HU6aCxUx4KYAHlIGSmzWyDE16CujoqI5XdOXSg6ChSwgYUXSCbOQe8/A54rUeP2Puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXqRkUX5RuwfUQMtYDCHOVh3gCEYxTxjr3a2QfVwldc=;
 b=m2zjhLhVnE8V6VzYXx7mfG9UZqN1Tv2wqJ5tASpi9iRnrIJlmh9sXGgoUW3cNrvRRjWZeh+nXxqhJjWQ8j0iFLCQlWqpu6TlPnIf3BRyBQF3w8uAZxG3lcP8k/EJntmDB6TlY5BC3RF3yjOIR0JVtRt7YTBLxLmja6Wnx6iG0AVkUeDMoI+fhec5KqoKDsxdyTJi8I1iJo7oW5LfR6yWoAOA+3Fln7sU/bhTlho9fOH5EYVp5MmR8HwUVCZFbAkTa50V61Q8WPAbIsl8cOaX8Az1Tq+L6PK3KzlJ09G8zhh7R0M441nbjwm6+KTXN99IAorfNnWCGbl2LNMmlNHLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:48 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:48 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v5 5/8] spl: starfive: visionfive2: Disable USB overcurrent
 pin by default.
Date: Sat, 12 Oct 2024 11:13:25 +0800
Message-Id: <20241012031328.4268-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241012031328.4268-1-minda.chen@starfivetech.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4f3249-1f69-40ad-f694-08dcea6be39c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: G9WUYiC1lLwbSf9D5NjtbXUkk8mxqPubUldZltH/RbZx4z9pzScsA5bY6OHh+ir6wMWmZuz+R2Qp/W5lxxfT6VXrpMJZgeidij8pXgQJQNwodnq0VuEf+mqKQ4mypemv91qscFFnersXoL3pnmv1VU7Yjwl1yzj/EE0ilA7v96ZioTnFiQlysTMUm9AS6s4DOFzOTzrsIQgRQly53o83JruMzi0XR6ncfKJ86xFHFLEvGWrbQktQELwt+Quh8rR++3o8DI4ky/IEdvCot01FW6BM4SWtnFd4CHdEYnCxdfVReo6/WRIG8RHwj50QTU2/hQklBCH7vkPKUf5/hcNKVz3x/xnTyzwMGa7opnCqg09wKELGRjipAZofL9eW12M4UNvsMBsZpH+Mst0LAOuz8i7E5i6m8aTaNKSe8SHRdcrIWUov7fPw99qcSZLxXvkBihXVmphvUN+XLdU7yArTMDaZNqp5Vq9yJ1FZTNrh43v/QCgUqGj8TByqsZNnib/llmCv6yWvuc/p5kFwOSQrJNNXTbRMnndnO90+2JGoO96ThyK5SSEvTqIj69ZmoYXzPFzANgc1iFChrdDcCEn4U+++jeHAY16lGRJJSfs8YOqVpsyFdKK2Nt7cTLXFFCQYnSXbO2QXwpTQ7flZMsrKQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EcSu1gH7w4ekQrhzy45AIN8kH+7EUD1ssKos4RoFBS1lhXqiZCOtEkzzzaVh?=
 =?us-ascii?Q?wFCsALzGRoOIURbU+NcYxLxjhnifYzJGQflcjuZDHNyG4lUhNO17vC0jqVK8?=
 =?us-ascii?Q?m73D0n55X2UIv96eS/Q6jrW7rctZecxjoNZDKbpchujUwAblhCASJwCxBAoQ?=
 =?us-ascii?Q?XCFKtLrhPs65VYP2t6JwwIVvxLvIAhcc8BWtL76Rnt3VeVQLO/gWlA0xEGXA?=
 =?us-ascii?Q?wdK+Yq2HXuQgkMKbkEcB+1S+6gBVjZrQKFE6ysO2eyvUZ+LeEZ3+WSyZ/VtJ?=
 =?us-ascii?Q?1XAHTlv5zgywzDKm7FEs/fm3mSg44t7BsF7xD8Zf860YBlJIXd8OqN3eTxHa?=
 =?us-ascii?Q?qUkBQ5HReuJ3HNm9mJF1vZJrtu0gJGVSj41CXtyV3ledExC6bmnawD9fIfV/?=
 =?us-ascii?Q?3JTlhth5Tc0DDv8mF9q7rbOoG0bJUOW2Ih+RvF+wC2hSbiX56rZFQfRlpKiy?=
 =?us-ascii?Q?yCE4dlMfJjjvT9TaBaVwflkTx+Na2wxiaWBVG5qIBbT0gKdm2vqWnYT5JbF2?=
 =?us-ascii?Q?0aStQl3+fM/roXhljbSO4OqT3m92+EGJlNNSuBoN5jSRFdMUj+E8ZaDVZYp5?=
 =?us-ascii?Q?hImWQ4StBuYANNPYxo/WS/OA9/TF3gOqkDnhwtU+9oYmpGL2kxye7vSvG2P3?=
 =?us-ascii?Q?52k3kr4V3h9lVb9rkoyw0h8lnHG9OvNnBhRoHGrEt5dJY8ljiVRvzNOowU2/?=
 =?us-ascii?Q?3eAOu5EjCjDpEGufFMXsZKHWYX1wVr1K12VH4Dg1lx9NihtOSnj2iEqaOCPN?=
 =?us-ascii?Q?56Q+zp/j0uoQOKBSXuL43dt9D9q8U0YXWGe8sj3mHmvmpoFQapjVPH/olWmW?=
 =?us-ascii?Q?WOL11BePC73FCyPGp/rN8rdVhBPfA80FXF2heuV0i7F13j4/ojYtf0VkYj0T?=
 =?us-ascii?Q?5pqkWeeECd2gYYhsbNI7ieSZRoOSJbRd3EozrMyYhpBNAMx96msHOMN/iGPE?=
 =?us-ascii?Q?ot/XOh+I2yDu3IwNkcvo+5R2j33s7+QqteOC6rjPYyxN2a8BfW4vTniAN6V2?=
 =?us-ascii?Q?jyi4/3RdKOULRy043Rzj29kc3g2f4Da4OMO2sNy7dxw9k7GJmAuAHyWzFkHg?=
 =?us-ascii?Q?cIWn+8aKbukM1BG80zmxfgVijMd8GDVydO9wYsKCf24uYS6hAM9o+/AUGqmA?=
 =?us-ascii?Q?Si895e9LzHp4M3jFoqvMV8JQ4HIJ93+SnMf/POI7WZRnmHLPUQWmgPZnM+AY?=
 =?us-ascii?Q?EGNLkStt4yKMe9w0yOyzq7ZYb6GRUtEi2UFxRr/dmDqX26OcTw3VYz4qX4rg?=
 =?us-ascii?Q?pobSIEmZlWV+rlXq/LopTWsKOY8sdR3i/WVl4HckPw2MSQdQSPVARF0emC8l?=
 =?us-ascii?Q?Wmqxzl0jqCv2egjCuoTFWF2GDq5Te6hG1z0IuYZk5BXa5mGV+gJ2e7T6EqLF?=
 =?us-ascii?Q?V9bkozaG7TOGcY8IUhsB8sqmAvQeOMg3A2r4jcxFRdpoz2mar1ePwjyx+s05?=
 =?us-ascii?Q?GFCzs4mCFRC7x65QJjJ1JFBW5Nfysf0GE10UBd4+E56MLfWVP+klyjbdhGOY?=
 =?us-ascii?Q?inATj6mWB7rLVsupziMmIJ/WiZPjK/ULA3uuL53zUPcRI4HW3fwZv4fpqEhk?=
 =?us-ascii?Q?cIYNlu7Tp/4YLUR4w/UpxkzRYmmLksUj9ldzwiVh3XkX+Ltc8Y6bhJJY+Sbi?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f3249-1f69-40ad-f694-08dcea6be39c
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:48.1919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNFvuh8Oiu/8ZmlfAGCD21iIUPFglCpWGwkvXe6Vz6xm/0c31SzR2nCRBzzs4CsnA3VChRyUoindT3PUYT89OdAiz4J9N/geePdpcWe4EP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0850
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

For some JH7110 boards, USB host overcurent pin is not reserved,
To make USB host work, overcurrent pin must be disabled. So set the
pin default disabled in spl stage.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 arch/riscv/include/asm/arch-jh7110/gpio.h | 5 +++++
 board/starfive/visionfive2/spl.c          | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/gpio.h b/arch/riscv/include/asm/arch-jh7110/gpio.h
index 90aa2f8a9ed..be2a1e0d1c8 100644
--- a/arch/riscv/include/asm/arch-jh7110/gpio.h
+++ b/arch/riscv/include/asm/arch-jh7110/gpio.h
@@ -63,6 +63,11 @@ enum gpio_state {
 			GPIO_DIN_MASK << GPIO_SHIFT(gpi), \
 			((gpio + 2) & GPIO_DIN_MASK) << GPIO_SHIFT(gpi))
 
+#define SYS_IOMUX_DIN_DISABLED(gpi)\
+	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_DIN + GPIO_OFFSET(gpi), \
+			GPIO_DIN_MASK << GPIO_SHIFT(gpi), \
+			((0x1) & GPIO_DIN_MASK) << GPIO_SHIFT(gpi))
+
 #define SYS_IOMUX_SET_DS(gpio, ds) \
 	clrsetbits_le32(JH7110_SYS_IOMUX + GPIO_CONFIG + gpio * 4, \
 			GPIO_DS_MASK, (ds) << GPIO_DS_SHIFT)
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index f55c6b5d34c..0c9798f32b8 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -461,6 +461,9 @@ void board_init_f(ulong dummy)
 			JH7110_CLK_CPU_ROOT_MASK,
 			BIT(JH7110_CLK_CPU_ROOT_SHIFT));
 
+	/* Set USB overcurrent overflow pin disable */
+	SYS_IOMUX_DIN_DISABLED(2);
+
 	ret = spl_board_init_f();
 	if (ret) {
 		debug("spl_board_init_f init failed: %d\n", ret);
-- 
2.17.1

