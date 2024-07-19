Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA22C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E197D88B50;
	Fri, 19 Jul 2024 03:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C785488B50; Fri, 19 Jul 2024 03:38:45 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C0ED88B42
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMQIhn1b9SKUEtdfpELHT4BDT7PXWE3wHJRb0JJuRGOXl2KYYqf3zQffqMttT6SRfuIjn5QTelYpwRd6xQo3g+/Gh82rioiPy+ajryxTlFNHVFzX378oZna44SV//97cJo3bGmtEqDWRvr7oZDkIkpyieQngheVcDbsKz8Nb8wU6ebfhy7XvH0Rr2hrtXRz6nDm+LIJp+dTN3QF3TH8pz3CE95GAOsz6cFbfwa15nENMyclw7A8HE19Gz4JC1FN6IPaXMgWrgpRNkBo3ZCXuKZHk7KZ6cAIxWzEKiPd/RPChJNMd0rckcj08SycSUlBLim7n7kfCQfKsDbbi2GkcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq+aaTQlEq61CZkkyT7KJDcpUwx2TFmIJLTmXXDI59A=;
 b=Cas5KKMH1RABO12W3feN0j6Sji4biVg/Im+qT3OjrMkaL9xc0A0mF2iIabl/GXqWR++TamBVfzTdULXGNY+8jQjDGssgiqO9sR+l6GZj+c1O6Qz2BVDnZ11C/fATAhM8fBOdgIpKTqlbdefMuPOJqrdiS0eVaLUFWBT9P3TdUt+jCroERpMmhbMhAPKmpYUqUCch3wwKfuaB+Nm2ciGcyLPpAFCozc0zK5ykCerM7D6i4vSdCamJxy+DvICJ3omKpSWs+FkRSZHQNFTN5cCaxZXQMusSQOgzfiEP/Y6ir2HEpb3jSqlcNPgXCq9zfmKaRrSXLfRMygbbK4WpyO420A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:37 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:37 +0000
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
Subject: [PATCH v3 6/8] configs: starfive: Add visionfive2 cadence USB
 configuration
Date: Fri, 19 Jul 2024 09:38:20 +0800
Message-Id: <20240719013822.101374-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719013822.101374-1-minda.chen@starfivetech.com>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc6913d-1dcd-4337-fc1a-08dca793826d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 2uXI5mBMv8M7efT7ogzUskmI1kfY1VLeCo7dnHDHcqgYIBEQuGmjLaFTqzb9qYjE9FI2Iq+5rI7XH7Pl/3kXkTmOjNpQAxM658glvu5qpSPuqSmz2ZyLWPUKNwY53ImrWCPMpM/7A4kuAMG/Wi1Y0ITnwp9+xPkZdQp42rEnZym70M6rix+tFxAQUnhTX1lIQxSYmJQiEQSW/RquLp82/OOJPMkYDkedrpmZmHu0MwvES6MeJkmniqf46JpwrWaPq8qQbEfIXelTbW90UJ449GV8CA6qDiF24zPxWbM2OENwwtUH5vgqhgQu08PcBKzeGyi31FwC8Ab+7hTzpCsvDJXwq8lSjfMFgNBV5A7Xv4vJMvrFDCpDPneXrU1PSS6RRq1LtozedJMuUJTMNmpw4UEs28zF8eC+eDMicvFkmI3y+LlVRDpy7689c0pjGYAnM06SqdT3s4ZvPlOFw/PsijJbz9VaPkrVUHCqvcmfwnruEUHTUrO6b+I+hopM2dfRev4nBynvDWB5tZxaiY1c40d61QxdJbssMtTgLpLBhrZkAjH2oqDDVvGoLCMAq8eP/MV8OEvamQLIBMUQpBEEugU0PUwCloguXhVwct3SbpqV+yt0y6SSIHMirR2OI5BEtqJD5k3KtwNjzterQee9wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaGKxykhLD6vTMeYTXtACs//jMnACWoTSQzxkq2zO/dDkuyw1C8qepIFGWBj?=
 =?us-ascii?Q?Ei7BmMVx5LSJSyMQzDa9Kws8amOEDzlSnBVmSs410yjm5WSnCnq/B4PeIBc8?=
 =?us-ascii?Q?eig9QSVznpMuX6qZiW6v3yOB5J+jY5Dc1HIoDrKjvk2tnSHMHdpoIK4nJzmC?=
 =?us-ascii?Q?v7pooi6IUHU8oLxSw3JDEnxSQIEjBqIqM1QQWD3foRW568SbjspOzR23iQOc?=
 =?us-ascii?Q?wCBzZdrCv6TkvsAj7yGhk5ejMyGupX2kbeeFXCx5mjNnXQOugMkVcYSAUfKN?=
 =?us-ascii?Q?yoFrc9DfbIK3JyEsg80u5ZnLZBOkKiPu6gzn+z8j5SGoJIIPFhHz59vo3DFW?=
 =?us-ascii?Q?h+F4TliH6YNtOtktZK0F3I0fLd/MCCCajkRWDendesLUWP8VgMfoAm62amtP?=
 =?us-ascii?Q?bli9mrIWbmb7WSVGf20IVijw4OVWR4gouBgeZs66Eh7VQQcGK1xnqvj/tTm6?=
 =?us-ascii?Q?6d0blhl1V24OVfUA2i7Zlu/9UC0MibBgUWKX+mbs36tC31KqrFm8f0tEEnm3?=
 =?us-ascii?Q?rRGwc05yA21R0Q7paY3WZplwbQkpM/bbPMGjrGfbhjWaaKx8e1WDt+av9MCC?=
 =?us-ascii?Q?8RQeAFNJs3hrUPdxmhfFaSZdhr4mZDfLdR964LT9s6xnHGe42W4isw/9MSSu?=
 =?us-ascii?Q?zhdXzmZRDmwhAwiMgGp2kw4lGYfTAFV8JPzoym7I5Whi5MNCew49IQoYwKQw?=
 =?us-ascii?Q?Lu+0Ao3MzyTZ0pW3CcmhuVQGY0ZppEapYl3lZ9j/2ln3TMeALv6k2jG3vZ2g?=
 =?us-ascii?Q?GHOyGnO+D7UKizf5gdyE0jQG5OPsUeayKd+Vg06462nEIRNFcy0iTjDaQZXb?=
 =?us-ascii?Q?8qTPzd1GQGnCJpwmDJALmTS7ZBIPhbF5keDYf831SD+y7sGCb1WJquziHckE?=
 =?us-ascii?Q?oi7uGd70yuELzLfgvjd87uIfGiFCMm+RHWunN4kOwGxxHcZcmolnXuC1ICEc?=
 =?us-ascii?Q?G626yxTgYg4FrmqBo1/5EVES+0MImPTQV6jER6Cysqk/0ceOT0EL448o1v0P?=
 =?us-ascii?Q?XRqBk/TUb7rL2ZK7Sovi4KOAWZT3gHRJ08hoW9SMWCEb589j8zJFea+R+hHk?=
 =?us-ascii?Q?O4bx9UPRSF5NqyrkhqJEDZchXSLtjvXQKusIuSk6dwVeyqgLgkb6+77bM5wN?=
 =?us-ascii?Q?jT6W/wwD/dj0GWIOYGvPZOpaDDtOHDnwmKEqwVku+kamL3CY5goY6MWVrief?=
 =?us-ascii?Q?PmGKeEc9VtBmKzu+uvveBEptA7NmSm7S3uWBfWUR/B4UaceTY97ILs4qi5N0?=
 =?us-ascii?Q?ZIxNq8v6dVJZdgAfmiEMOLtcFkrKJpawHEBZlquoxUBM3UjxqMefOLpK2RJu?=
 =?us-ascii?Q?f+jOSIqnH6PkiqZ6E+5F1KxnPcF1BSnTQnN7rYuTTyqkVTPL+bKDgxeBLUaK?=
 =?us-ascii?Q?M4kLH+zFnOQwEbo1LmYJlMmSmCwKnBtKfVpJPfaCS5Yu/mg0DsS4iLGLhp43?=
 =?us-ascii?Q?KWSnUID6SKA+qcj/4lOP5lD48lAwsyot9lx5IYN2qoM1j7JkhmulPY3SrSyb?=
 =?us-ascii?Q?krqwqVxk8s8HA/GB7LxN4BzzjgP8n+9b6EAVy8KKBb4LmtHqQirGGF1Zvhwl?=
 =?us-ascii?Q?wmdhBmf+vpkL5jv8SBElnzImCZAmiLVqfAO+EwnxIGT6olZGQ3FUzeZ35FA5?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc6913d-1dcd-4337-fc1a-08dca793826d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:37.1264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79/GoFKR6mLieYJrY96K4hxYWwMs4vy62x5TEFu/sMa0MSqVFdPd1dzppReZ6wPtGUx2/MoxgT/i2h7FPnQZAO7Hz2JxBhzD14Os8mxGmuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623
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

