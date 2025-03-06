Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F99FC282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 06:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FB48144F;
	Thu,  6 Mar 2025 07:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878F180805; Thu,  6 Mar 2025 07:21:08 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC1D81428
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 07:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdPrxDU2jZCSkOSjBQouwsDnrs5uYMSrO36YoVVG9aMyLNa8YUhgqUzaOf+5/D4kpCtYhCtnQNhsB7dzCZ2Z7XkMg8ZG9BwFT9D8d1R4n8a0srJITLhl5APhZdmZBVSvyuwOoItfdIu92fPaO3qIrI8cVr6mvtDnau4PQyONfWFrd5FsdWj0lXIfxauqZi25gLfwKJxWapQWW8Kd1EzSUw08o4IwlcHLuNqTRrSfnm2E8gmFTcF1hfiSsW0TwszlYCJaW6FpHwXZVbHFfroI5YPeVCozXcwZKsZJhEFdPAo8ogHCx9U0vSUKR8b7lgNfoBfkoqlXqJrASUvwUDtU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DGmX8r7lZapjCpkzo8ev3Mc1NDhiOS+FKo0o91wADQ=;
 b=ao2UsuMZGiVvt5bFKHbfCzpZcCBd+MN7/jkspMWHLVvy8bAG6fyVjkw0LfL7MNHf5EheamiREJ106+SvrTy/VDk0/eHnanVeTVOnDUcQvIKhkgP5TcMUP2rdMYcFXpLOX/uedlLc8C2oTPNi1ZcwWDa3gbQp+7i4nx3RjtIRI+h8S9By7iSLQfAzxi2gu8TCNn+blfKQD7bwHu1akZy4BC0mAo03Ta0NZ4Kg7oD93dBwuma6L0q9idXOHCnrT7ee4bS233ez48ZbPdqFusQVEBvzpZKFPpj9n3w5XOPT3oaNiqXiGxXtI+7/UZ1ZfKlIp0hjiaqpxkybO85DgNcumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Thu, 6 Mar
 2025 06:20:49 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 6 Mar 2025 06:20:49 +0000
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
Subject: [PATCH v7 6/8] spl: starfive: visionfive2: Disable USB overcurrent
 pin by default.
Date: Thu,  6 Mar 2025 14:20:30 +0800
Message-Id: <20250306062032.50314-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250306062032.50314-1-minda.chen@starfivetech.com>
References: <20250306062032.50314-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 20dd033b-1d8d-4900-ab53-08dd5c7709c2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: pf45c3wRO9pTHEdKx0M/3LipJuo5Z8GelbVkP4rYnihzXGKAH8xXWs2oOlyXdSfSC5JQjlf8HEcHarNnh8qJZnVd+XetghiBm1tZwhD1jHw+Gv/OwQ7VJE1HiCYfkJs0nc0PFLk+2abPsm7rVrOL/RsLzE8fXSw63z0VVZdSZXv9+ql7k7dYulgeXzbif1LYvnK9zRJV2bK5a6n7Ahge4iMz45mXst0Jd9Ec1oIazkhUvIrxoLACRuipInuWTzrbFxC/9x3kwedua80VztUSGHAY/tlxCDPJ1K8W6Rxsc/zFUwc2O0GoAEVFfW6jaHKWhhG/2xRyYtszBfjPfl+qPKlT7RrnzRxtiwDg7wck5Jc5Flf5ko/fdsaNveaSFYrENRy6he9hSC62UANfcH+ujHqsWKhAyDieDfrK/mqkBcg/d91C+y+0AKCCsxQ+qJOTOnlmytfGf/la/EW5pEfmfnG9SK+fOYj2u5uj9Y2E3oaabW5M8n7eLZy7TKP53TrhKTX/5H6Xi8mJqAtAvlSiYWo5QPUwlDRCpGJaiF+ID5HtWxEtb8PrWOBZbQeVJqhLdL0E3qw9KruHKxqVvEdR9KYtiM9ja6wYDAWEHyvJj6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BToot5ounQplQAS92a26U/xzwHhxcE0oLP92QZ00r9s6VhFlHtrdCSzUZMwb?=
 =?us-ascii?Q?k0PvxDbnRQLXXXFSesWaV8ApDsY8jZLaX8Kp8yVLBhBB++PZV1wkNN5vJbIb?=
 =?us-ascii?Q?P1w3Ke6RgfCcXV2p5fctDrhR1u6zq9fRGVcXQfkwWGUWgbrwYKYqvjo6M7oN?=
 =?us-ascii?Q?fgTIQpxt0ucyIGFHh0NJbpyqUMm1P2e6OudNOhhDnJfNSqaBNZOk7JtSYqsr?=
 =?us-ascii?Q?PQvoFGPKY2EwDHb3/4qcC455QkF4ApN1Gzcrigr5bt8+JwyIyu5Cyf8GJkVN?=
 =?us-ascii?Q?W2dZ7vYK6yCOKO59DhdZLs3cz/GK9CTPyRQs9yfcv0qmeFpb0YG8u/x9JfKW?=
 =?us-ascii?Q?YOB0e22utwdly1qCDKbMwqO5RfYpg5/Hcyadc7iA7EiMQj14OpcqMsPGbHqc?=
 =?us-ascii?Q?mEKNC1hXeE5IrL5FBpGX5Tr1EvcrVxx0TBxndYMNIfMiHm2AlbFHLytDpQT5?=
 =?us-ascii?Q?MtrBEWMf4hrQRFjqV+gpUc1usxNiSydHeKEC2CLAB/byedF2qYyr5DglNbP1?=
 =?us-ascii?Q?pDR/3pNBKm47mT8yEn/gdu41hUWh5VyfXGg5TUCGjk0g3WDhRG5Zm1z/yTmO?=
 =?us-ascii?Q?WQcTrsJMHfpK/mxP3NuE7vTovIjGjclpzu0ZAeX7mRwPjxtim8kLg3KEPgUQ?=
 =?us-ascii?Q?qAf78djIkuWOdniMBSJB4hGZGGdpavOJfPfvoQn+LMianMLvnsZ8aVRPykWU?=
 =?us-ascii?Q?XJK2v8GidA3qMe0s+OqC15pZLO+216+Xz+b8VGEEhITqdPmpN2M2LhV+TbkA?=
 =?us-ascii?Q?q3DQJuKVzNGKBaVeCvphvORseKsnB9wk90ErVFLY613IgKpBtlMnYSoBWsFR?=
 =?us-ascii?Q?C2++jgeCw3WmizObY7VILbJVbYDhcI/gKrbPawDzKGERZBWoW4Ed5Uhki6As?=
 =?us-ascii?Q?Ysw9mO7mIXMVfQoXdo+51AUANoNFTVpLtU596+rYJYwEv9N1Ik+opXkpZIF/?=
 =?us-ascii?Q?lnDq4o3e0ciQDtv9BSctwoPlOMhlUFvAB7Kq2v/+vF41xJrLzR4Tl7byN5pZ?=
 =?us-ascii?Q?hi8CcTJavxmHNVgajhscPCtSANMr+cxd4qZFzW14/Bcxmsq2ZtxZpO+F9IRD?=
 =?us-ascii?Q?UQ/0cNeeUyL8w8SSkhKNU+lQCGGbaLYE7Pe8xVk9nx9VMKB2vkiI+sktrcsi?=
 =?us-ascii?Q?B9ZTCXG2AvusSdVhq183hxLWeGTFU6DRKup3RYnjg4pyFRMqVio9me5dcgcI?=
 =?us-ascii?Q?XuedfkFh5143HfClcm2e4xYkFH7drUXrLw+j/JshNbTvGc2AS4o2rsER9hO+?=
 =?us-ascii?Q?OxnUAeVnrVFk4d4b7m6tRg2I2U56z7D55r0bTGEPuSwRTAWIRvTZE6vsm/OR?=
 =?us-ascii?Q?5ANkUtqGNLK1ZBtOtrkGNrdKCbXtE7w38jiDRNheWdm2SQ5K0gI1Y7FinEGf?=
 =?us-ascii?Q?tC2GsGRlhQGa3ZqlYXWE53/VBOtlgeTXl1gjB+BBfNY2EAz0pLUE2qk/o1bb?=
 =?us-ascii?Q?/lSw9DVIqHkcClkln5gafmzntRlyo2VPWM1CvJ0/WjIms98g1B0BbTnN2esk?=
 =?us-ascii?Q?JXKzjn64+YRQh5BnbfiOOKwPA3ul+gqEBz1dHRNLLlgSUJxEiOM54gpk6Fpc?=
 =?us-ascii?Q?0/4cl8jDG33MI30sn5XK0E/C1ScAlH2nQh+TGL3bTM/KzRmb0dsGDrt+0v+k?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dd033b-1d8d-4900-ab53-08dd5c7709c2
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:20:49.1998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Itpv+EoJ0C6wvU88j3ZdOb4zIdkN6tcbyv5xTCDO02Wkn2ADGrs4NCZn+NfqVUsjJEs1OAZiPzln6PWxJL6ut3w4pvq2T1uDE31j+hu7HGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496
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
Tested-by: E Shattow <lucent@gmail.com>
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
index 22afd76c6b9..1538d6aec73 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -103,6 +103,9 @@ void board_init_f(ulong dummy)
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

