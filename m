Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1E5C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B337784AE6;
	Tue, 30 Jun 2026 14:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XvjSdKfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DFC884A48; Tue, 30 Jun 2026 08:56:44 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58BE584979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuD5gAxvxH2ssgC3KVXBOUkPRbDq6CoNb9LTb/ZnSpIFzsY9QtNk5tRt/wGpiZQ1PN4KIHPJsbFIOiobQnJs8I2lH8J427VlAqhKyw+8J/mX8k3/DUa9MNYN/E3BUEXnR7wUw6xYNYcexVp7k1cwK0q+Vpz9vQxCj9TUD7qSHO9uuMakB5wqqlipeZKDXE4qEgN+bVqSWy6hn14OWsjedsm539gWl6Ti+I+udki/XKm2G4C77jMJnRHdqq3qJPoRlE5b2FLMBBU2Q8qK0cwXCXFmSGTcodBTvkd792CeNrgj78EfeVnnq9GWZFvTRgP+oQ3615muSMcZR793DHaJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3smMbvuXw3a2FYjrorP4G2GM/TNZgvg7aw3y0/UCBTA=;
 b=XfiJTTMunitiiruCE8OJMZ7ZAlBdc996SjlZk4xQa81DVNpqeiz0tOQA4GthQRpvJcj+oY7zYsBTM0mgjD0SGz09JbQuxwt25Ev/+Ve3QmGo0vp9o3Uh/IGm3D6HgbPQ4OXfqYL3wHtOdnBpkz/Wv0Ji+NeuhsPTpMR+J8rKDkelY5PwZ08tE7EEjQkpHTk1bzcBV3Whxe2q4pdNTTOr8tN2qbsbsT2nPFzc61yVfXnKVi2e4C+Bq3X5ro0o+3dPme23TnGGTU29gY9wL/3Aqx8Zzqrx6N2ww3vAUFTluZOkcJ5VeD17/8WNhhLr9uUME4sVegD3ETyxQdjIeT5sBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3smMbvuXw3a2FYjrorP4G2GM/TNZgvg7aw3y0/UCBTA=;
 b=XvjSdKfALI1s0ygHYWTJ3ouLn39kmT9fUvWqnzA+PVRpWoPsvArGWDIa2s8bdD/sS78/v0wkJSHdVDEz4+WXZL+J/4taY326DlEDpfgqutWDRXexXuVpbnAdT8rQUs5otMfXtJKdq+JKKoNaPlHiuMhc6Z02RiBgJ36QwMnO10aLxNebcuEnKfYa2OFRl7JSpPqJLUKgxjjroCSmUtiGbyJVYnIqJ/fDxmdcQ2dFLE44wMUf3jMT/Z5XXbCUmJgSiA6Dgzf2vdpwzogeDiM9p9ODWRHyotxnbw1ncY8LlimlcVz4GQKGyyp418lLhSQKA+5hdo3B+c1qTq2SoOzN7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:56:39 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:56:39 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 5/8] arm: socfpga: rsu: Add multiflash support
Date: Tue, 30 Jun 2026 14:55:21 +0800
Message-Id: <20260630065524.27680-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 178921b6-114b-4a0f-8988-08ded674bbbf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|11063799006|3023799007|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: 2w6G3BcpK8wUO8JU2enAlwDGQ9V59ENJLCdLYoUWZ6zVMt/sSgBOjBK5/pHzF679h2Ax+grT+dPoa6m5YXpsMZpUh410pqHg0dmrT4fTqKCf3Vz54yyNJ4f2B66MfRqtgPIfVPSWjHnaHDr8WUHGnjaRPtgbyzXK383+cRkDJNUw3o0NMilkeLPofWbpiQpuCj9nxXdztHYrKB2OgBzBkI/MRpO5VBW4HYKWIBiRQja6Gd6k+JtgVmKKA697o0BVqGsDlHN+w4nBq3mreNKn+oHHJmJBz8BYkDgB2QXkl8IOCklflAOe4+Ye0ZIHeilT6Dpwfl1TyAQ/093g1MkmTnbzK/YSqqKPdE61jHETMU0b46rhCnAC2hAvvyktLJjNFsH498sUODXYZv2a3AdqCeEuyqBMm2XODAiD+zdpajActDoiXBXQDi74fsxoEKCvi905Eiq8j026f6sOzuTphr2Wl9jWkbMh8IMBLp/1REZOxqoz4nZEZ9mOukGvxQ9sEKNX7naAnikzzKO3GonuPPIvq8JOVXXKWFtt7Hj4LrzTBYiRZ6sarTPMauAiq0f2MuKI4Yq0XKEhVsldfcQnA9z1aZgP31/qVHVc7b1WccXnlh1lIETC+sVBJznYHl5CZgbVmLc0iyRi4iPAZ3QyUpycBdtqrraJDHc1V9eEgnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(11063799006)(3023799007)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/rG3RkU3XbqT6ND6WaH+oppSZd/XVpPE7UMBM5uqeN2a/nARhiJlGKamnBit?=
 =?us-ascii?Q?OZLDeOun9bZZD2uRyCT5GSl1Es6ntH5gnqBSU/pEyqlDfbVwvoOP3aIvK2fE?=
 =?us-ascii?Q?9ip6d8KJV9PQ3zSgh+tleODemnTt8hr2HwPsPo6KyqB3UpVKWM8+qJuU9jeT?=
 =?us-ascii?Q?iYZqc3aq0Qj23RexWPhHFJ7RpaRC7BxXKFAx+2THbSwcME+UoR7hAwOokvzx?=
 =?us-ascii?Q?D/+VirRvHWLQYq1SHHE9cyZU31IFjx6LDM3GffB0PxL12MSkEZ1ugbBp46f9?=
 =?us-ascii?Q?odUChQDetjLXFiUJZsFZgxW/rivbPkk747Pd2lP1KqZsmyYKSN8VEbWyW9+n?=
 =?us-ascii?Q?AYLKR2Pu0bHCZw4PunMR4L7BDlNsUXz9Rv3M54cNiIeQJ+ZtLHEfFPRaVXhS?=
 =?us-ascii?Q?KLnuVD3pJ/tfVrbz9lgf04KGv6AFr/NAuPbn389GRiEEaL+VZHCAmeEwJ9/l?=
 =?us-ascii?Q?frZjFXRh29tVmeTxfWK27elJHsKBKsBb83JazOVWN+aKKUtHlXlOjYI6yQHy?=
 =?us-ascii?Q?a0mM3PkpVY02HWydNy7wIYCM0aBRTaZHjnJHJv1diNlV+0ssPVrpuLBeV/Rf?=
 =?us-ascii?Q?MKbbpaaG+vUmL0tZu7RuJTFDKa81afvRfk3bqen9L3BnRACe+eP8Wy7uH3f8?=
 =?us-ascii?Q?sK3JqbDKSF/yB6Mt4mzlw+uNQ0nYK7DEcqSowpJ0Fv4fyoZMIOTNTnQ++YFq?=
 =?us-ascii?Q?X+M49YG8fwkJLE9yRatnHCtnnguk+A9JEgeUjXMR+Izxpl72fg017Nzreq4o?=
 =?us-ascii?Q?HlXRad+Yfg1lyzxBJTjGf2zOwEpPNRCIdPZPDyL2CxtTLd7FxSXScNHs/PAl?=
 =?us-ascii?Q?lU3Osdk6j8UADMJHFmAyjw9PjhYrrNNCc4PWDFkKqRjlsIXwpDJYx1Ps94yC?=
 =?us-ascii?Q?dTfr7TDP974pR3+KEL+oCqIS6FNhabBYgL3CArox7TAbJkysBlxEVsAkcvuc?=
 =?us-ascii?Q?lOFKiAqK0GihfUVXP79BuaUeidlTWj0AFUzxAk1mn9+Iv9giwTM+lEfx/n2v?=
 =?us-ascii?Q?KfSjiohGE+zI/SJFzXZElqoqizlMovwOsBrZ6mxZvOiNN91QnNNJ9QrQuBml?=
 =?us-ascii?Q?131ZQd31CfJCMexb/ovZxUnPmqenf65IrJd0qQ/hVnmZlZZuXZ8wekFH75s+?=
 =?us-ascii?Q?Hv/9i9I8NUimfw8g1YMJOqN3vpkHUbgimFJIv6OLRDZ0oNFATslJUsogq3vr?=
 =?us-ascii?Q?IQbOnR+KzteThwNi9V7di9kb+URoNZYt3UiY5HhVb+LEU7HYCAWZ1TApk0uA?=
 =?us-ascii?Q?f2X8ex1lu6sqttYbzBVmVNWZIu2yoj5IXyaF141adTY+RYr9aVHIouf71eDx?=
 =?us-ascii?Q?ydxfSkwT4Xxbzr8B9CXzYy3yyj2a1TUuqOFRJ8aE0hzqVPq6GUV1EPG6K7WX?=
 =?us-ascii?Q?QN5sJtpZQaIb6lsrSVK7vF91uWmy6UfGJZCwDOh1AoYgt8Gd5KmoRl7qH2SL?=
 =?us-ascii?Q?ZWMo56z3naS6h117t41Vf3On+hk8FKZivotZY8J/8grScX8oYdeCyAAj9Epk?=
 =?us-ascii?Q?q4qHZ+ApZor9mkvMEXbBHBoYm7xfaDK5N8vKBuoiHGmzwSapkrgDCAQewCpP?=
 =?us-ascii?Q?Y0x++iG+JQDUeUmzda3w8VqhOe9uf5Af8LnZ5t8dv5AUuvIfmakRQ8yBoirg?=
 =?us-ascii?Q?+N2kh3K78aZILZBIEOKjBVVPQN8lLJxdO/gc8rXAdKkA4L9t7mqBdVLK+wgK?=
 =?us-ascii?Q?HQcrGaugKORMBDev+uWnrxiOiZijP0XxOvZ2w7CRrkJipjjBuTA7T8psGGCz?=
 =?us-ascii?Q?9uJIMrfTpw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178921b6-114b-4a0f-8988-08ded674bbbf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:56:39.0578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqp6uYkxTRgu5BRGpn4hL6yrm1Yf/MdI/WlaAVhGtPF8j/qvJBzi6ntz9vYAU5Lw/7l9KUZnuCaGjEUwgRssWPWS4pmi0PFkilPabJ4lhm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add the SOCFPGA_RSU_MULTIFLASH option to let the QSPI low-level RSU
backend span the sub-partition layout across more than one SPI flash
device. When enabled, rsu_ll_qspi_init() queries the Secure Device
Manager via the QSPI get-device-info mailbox command to discover the
number and size of attached flash devices and probes each enabled
chip select; otherwise it falls back to the single-flash path.

Add the QSPI_GET_DEVICE_INFO_RESP_LEN definition used by the device
info decode, and rename the integer power helper from the libm-clashing
pow() to rsu_pow() since it is RSU-internal and only consumed by the
multiflash flash-size calculation.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/Kconfig                    | 10 ++++++++++
 arch/arm/mach-socfpga/include/mach/mailbox_s10.h |  3 +++
 arch/arm/mach-socfpga/include/mach/rsu_misc.h    |  2 +-
 arch/arm/mach-socfpga/rsu_ll_qspi.c              |  2 +-
 arch/arm/mach-socfpga/rsu_misc.c                 |  6 +++---
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index ff961e7f13c..e9d675344f7 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -18,6 +18,16 @@ config SOCFPGA_RSU_SF_CS
 	  loads u-boot.itb from). Override only when RSU metadata lives
 	  on a different chip select than the u-boot.itb boot image.
 
+config SOCFPGA_RSU_MULTIFLASH
+	bool "Enable RSU multiflash support"
+	depends on CMD_SOCFPGA_RSU
+	help
+	  Allow the RSU flow to operate across multiple SPI flash devices.
+	  When enabled, the QSPI low-level backend queries the Secure Device
+	  Manager for the number and size of the attached flash devices and
+	  spans the RSU sub-partition layout across all of them. Leave
+	  disabled for the common single-flash layout.
+
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
 	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
index 5cb6ae4bcaf..ead9e510bac 100644
--- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
@@ -136,6 +136,9 @@ enum ALT_SDM_MBOX_RESP_CODE {
 #define MBOX_HPS_STAGE_NOTIFY		93
 #define MBOX_QSPI_GET_DEVICE_INFO	116 /* get QSPI size and erasesize */
 
+/* Response length (in words) of the QSPI get-device-info command */
+#define QSPI_GET_DEVICE_INFO_RESP_LEN	8
+
 /* Mailbox registers */
 #define MBOX_CIN			0	/* command valid offset */
 #define MBOX_ROUT			4	/* response output offset */
diff --git a/arch/arm/mach-socfpga/include/mach/rsu_misc.h b/arch/arm/mach-socfpga/include/mach/rsu_misc.h
index 7777d652912..6d2c8f90367 100644
--- a/arch/arm/mach-socfpga/include/mach/rsu_misc.h
+++ b/arch/arm/mach-socfpga/include/mach/rsu_misc.h
@@ -61,5 +61,5 @@ void rsu_log(const enum rsu_log_level level, const char *format, ...);
 int smc_store_max_retry(u32 value);
 
 void swap_bits(char *data, int size);
-int pow(u32 x, u32 y);
+int rsu_pow(u32 x, u32 y);
 #endif
diff --git a/arch/arm/mach-socfpga/rsu_ll_qspi.c b/arch/arm/mach-socfpga/rsu_ll_qspi.c
index 423df4dd676..11bd80a6eca 100644
--- a/arch/arm/mach-socfpga/rsu_ll_qspi.c
+++ b/arch/arm/mach-socfpga/rsu_ll_qspi.c
@@ -2258,7 +2258,7 @@ int get_num_flash(u32 *flash_enabled)
 		if (mbox_flash_info[i].size > SZ_2G) {
 			/* >2Gb, power the bit 0-30 */
 			debug("RSU: QSPI %d larger than 2Gbits capacity.", i);
-			flash_enabled[i] = pow(2, mbox_flash_info[i].size & GENMASK(30, 0));
+			flash_enabled[i] = rsu_pow(2, mbox_flash_info[i].size & GENMASK(30, 0));
 			flash_enabled[i] = flash_enabled[i] / SZ_8;
 		} else {
 			/* <= 2Gb, total the bit 0-30 */
diff --git a/arch/arm/mach-socfpga/rsu_misc.c b/arch/arm/mach-socfpga/rsu_misc.c
index 50a744d162e..6d34d0d2632 100644
--- a/arch/arm/mach-socfpga/rsu_misc.c
+++ b/arch/arm/mach-socfpga/rsu_misc.c
@@ -135,14 +135,14 @@ void swap_bits(char *data, int len)
 	}
 }
 
-int pow(u32 x, u32 y)
+int rsu_pow(u32 x, u32 y)
 {
 	if (y == 0)
 		return 1;
 	else if ((y % 2) == 0)
-		return pow(x, y / 2) * pow(x, y / 2);
+		return rsu_pow(x, y / 2) * rsu_pow(x, y / 2);
 	else
-		return x * pow(x, y / 2) * pow(x, y / 2);
+		return x * rsu_pow(x, y / 2) * rsu_pow(x, y / 2);
 }
 
 /**
-- 
2.43.7

