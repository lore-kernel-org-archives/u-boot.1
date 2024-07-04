Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0C0C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DAD88885;
	Thu,  4 Jul 2024 07:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED108889D; Thu,  4 Jul 2024 07:50:35 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9F4888A0
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBSm7gkJ6WjaP3i7c1e8jnPWs7gnbMX8h1SJ9DVTW8Z519Lk10qhRE0lGvg+/OXtADxOkhDQ0hIFzgf1WHGHDslgItt3xXWz8Ac7nd31lNBABusWAE4K7sj2ECV5dZrBhrHX0gzuNQA8ZXKGpZkLTWhjkee4PkF0EFOzqebAfcXLDADeyhdQVVfToE8xOWJTJyuc98cbnk8VtI1hcniqxvF3tRDrHMIl+9p7FKYs39F6UZf42GVakj1cKaWv1AAXOEsD+pOn7FVdEQevtJA4jU0E2px505tcIv+ye5ftcxVukPxw3PaH5/ixVH1HYPUfNBAt9/DEnoUWRuAx9SiRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq+aaTQlEq61CZkkyT7KJDcpUwx2TFmIJLTmXXDI59A=;
 b=QC5MTHpppAssnLF3sWFprOow788lcjH17L3wIoE/l9TCOjXNgklUCgXcUgbxfxGbpvodHYcpYMOs4sRDY6Pe4q1LDzpcWfWQcNpQ4VaI2KspfqWILI0zi7DxnvxB0nfTW0E5rQa91SJ/LCHpgX3cSsYClQ+0F2kjbADzoc+bv/bqICTc8raceimkHl6JLz4u02Igu6y1hxpfg3b5dy6AVSLfELy64yS5icNKPKWjM7nq/mZaANW45ojR1MAvUSTFo+m5SWLWESNHYIPvHsyweXU+aI8iOnyvRJYEA5caV4MdNfLCAPAmdNY4Dqf11fUx8f10U7q155I6pZpl5/8uAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:27 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:27 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v2 6/8] configs: starfive: Add visionfive2 cadence USB
 configuration
Date: Thu,  4 Jul 2024 13:50:12 +0800
Message-Id: <20240704055014.55117-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704055014.55117-1-minda.chen@starfivetech.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b01057-669d-46b4-8f8d-08dc9bed34cf
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: GsYXJ4f7DlGORXTwbVzFf0CejgX3uA1wDJM2QPq2EHiy4TKbLSrH9L4z5TejLdlHlX9gJkFRk/9hkCn3J/EjwQZ6V+ufCpU7vj3zxA/mD6ZqL6LbUucSF2oIt2Ej1Ks6JI8irBXmyTrYbUYgigk3IewLbwppZExopZRtr5d2Ms/oaFoI0iJFPC/h1+4e+MSgUtc6e8yHEOBGqYVGGytvTArOatRr0iGRCvS1PU8PQe5jyCxefMG9aAnafpCI6R7wVpSI6TokkB5cCXzmw6Fiqhf5gFm3TODelJ5PakjR6StK+NFZSkE5kR/OD7px1eLCyqhm5jT6otYGzJfGNc6YymwPgO/d8yawqs+Z3P6G/pkH4EJXt+/SwwPU+HVRRCo6y12+p/uNCTMyysXo6mB5R5iMt83dzbaDA9h5n5MWN09SrZgRbHx1W+pVXSb1pOBNasTxanW4ZlRYvZDS6UyKJ3cLJ4QBeuQll9XJg4V4CTHDTN8w7Ch+2STCK5mNw7ennRTb5F8zkg3a17Xdi5d9BD5rU9Kfd7+cq5imSuPwDZkzOfsti1kxMw2oCNpLQUAtvNQsDPOjvXn6YjRCDnV7TfyS3f4hyCA+Ed0EmRUZLTxhw3ph5hn88Qx6G1a6TeTfh27QeDcyFypRIrV1+aquMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZxYLHKFANjMmLAOfAt5hDyFCNsGt4Ho1s8E+iswDQq0dvzBh90xEwS5pa2d6?=
 =?us-ascii?Q?I4flSQAxCwRrkrG7cnwa7Foh4RjojWIiTdaLgUZnb7SsgfzImz8lwPE6slcF?=
 =?us-ascii?Q?XAOiw0qR9GjjKW5sUmUhfG2PHTxax6rDss6CVPOZJk5oFr70+ttONVOylKwj?=
 =?us-ascii?Q?bYgQCTjO3l4hLNKW/hVLlKl+gryQTNpy84Ad2Xg4SPh0eIMSvDXzne64EUdV?=
 =?us-ascii?Q?jITZjdYV+5tqWNDJQLMnX+zP3PyU8L0I4bZrD8DLM8eNLccy3qI/6c5DMb0B?=
 =?us-ascii?Q?9JvAqs9ItX9wwdLdbSqdixoe4iKiQRucHKn3bTdhuph0QLwDnrTC8uwTPI/n?=
 =?us-ascii?Q?DswkJD5883NEGBERahJ6l1TUw5QwDeWEHoBpDiwa7fOHxgBMHMmctKv//NA/?=
 =?us-ascii?Q?9B6dGcIgUia7RrSFKqOYXHtG12trKLM8ZZCwWsyreZIsfM6XKWqS3iSRtCxY?=
 =?us-ascii?Q?i2RqvL/HNz9CqF3/jXL8pse2qtmHyBzuA1cMNJt8ojcgSNIp8MNWgo2kWeTG?=
 =?us-ascii?Q?UIEah2zlJbhuV9qpaQIvaXwEk6feXqymSrOkuJPSTX6RA/TzF2FLfP5BIouT?=
 =?us-ascii?Q?LxTvQ8VXkPUTeJQS9FEnXcVOXlCUODsvWNpgaLFHNJATVUmWOQsHMUii3Izb?=
 =?us-ascii?Q?x7+aHDPqR7Xt3lNOKInRRkvSxyxlVOaCfjJOL87w5YeWto2s1YJsxb/HN8hl?=
 =?us-ascii?Q?eBZcvWxVUXAK+V/gz2i5D0r7imO6NAW9wpw2WY2f9oRsl9vELoh0GB6I3+AQ?=
 =?us-ascii?Q?zb19fNaszseNFpMT6hLiPoqyNcb4cIHLodgUGXU8K3MbvwfT1OiP0ZP/zwQM?=
 =?us-ascii?Q?qymvPBCoEhjTGHeNyXR9VLlFFgXNQ275oUlIJ7E5IJk7MpP6tN+TWW8hnbQ7?=
 =?us-ascii?Q?q3nvDxY7NMmEoTSik3PEsUqMwDXTrk3mIenzqNt2EzB13Ba4Tflzyp8Qt2TL?=
 =?us-ascii?Q?5Xlm20GBP6peRhrVQzktT+1G6KeNIrREq412LzplbrXmCiOBLpclxbKu/Kgt?=
 =?us-ascii?Q?Aa1bnYByNHiCMK9eP7BEbLWKZo5ZBtGTZ8udOQayrS9sxNW8bO0dknkJsIlT?=
 =?us-ascii?Q?kthBosuJoZMWJ1YDCZTwUZUW37heHhVPPlTQ9vYZvTbVY/hjqmzM3/rBzcgp?=
 =?us-ascii?Q?sD3kmAuNFMMQhJzSL8gY1ThdzFCxLlOUdKleXVZ3Alj2pZQFmgHoJqBkU6AS?=
 =?us-ascii?Q?bj/l+RyqTEqnA3lvwPf094wyJrRiTJVx2KJZR2qzLjROqkcydx/if4dNqHGT?=
 =?us-ascii?Q?+Ik17qdFKZZq3G3f0Yj7CJ41ZxgcBs4ySHL6ZigiiimlIFJOL3gNxge/6zd+?=
 =?us-ascii?Q?EpXtrZwrlJr/A/k/LipAy582L5E+QLqpiP2KaF0Ov4J81M7fCA9UT5Ohzm7b?=
 =?us-ascii?Q?sYT5gE3mMFk1uzP+LqtIv5K/fcxUaGWk4prAY6ZoEM39px8EDrv2L2+DCPsg?=
 =?us-ascii?Q?BcVkUrb54GHYR5u5SSIn9sOUq85hRKJYBZRoldz2XRwE0zQIyiFQs3ROkYqh?=
 =?us-ascii?Q?64KxeyzP1Vrq0vhZpHA3nazbb2o0P8odXNeO7BBEU56Gh7UZrsYSHjhCG4Am?=
 =?us-ascii?Q?MncCsH1b921Eb9bWi8Z/ncw3KQyV014cFRVPtWk+7uUw0HZPIcKjj9hXWIkb?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b01057-669d-46b4-8f8d-08dc9bed34cf
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:27.6354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2AcR3JWllvW0YmmxnnJFpcyD+n5F8oavNizrvVTKXVNfTZjWvP3Chu1qnpgQRSwL2v986NcDh5HMeu301dRNxptokbrt1c9yA57RpOpI2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766
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

Add cadence USB confiuration.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 174ac24dc7..35137eec59 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -69,6 +69,7 @@ CONFIG_SYS_EEPROM_SIZE=512
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_MEMINFO=y
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
@@ -112,6 +113,8 @@ CONFIG_NVME_PCI=y
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_PCIE_STARFIVE_JH7110=y
+CONFIG_PHY_STARFIVE_JH7110_PCIE=y
+CONFIG_PHY_STARFIVE_JH7110_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -127,13 +130,19 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_SYSRESET=y
 CONFIG_TIMER_EARLY=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_PCI=y
+CONFIG_USB_CDNS3=y
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
+# CONFIG_USB_CDNS3_TI is not set
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
 # CONFIG_WATCHDOG is not set
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
-- 
2.17.1

