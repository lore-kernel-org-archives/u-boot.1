Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F2EC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC8C80040;
	Wed, 15 Jan 2025 11:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FbgnBfv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9865800C2; Wed, 15 Jan 2025 11:38:32 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D038C80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY0nQqmtMHl7oms8r1jbk7nC0RGjNGkoKKuJIGAUlDi7d1AJkYJbPGgro+4Iwm51HQ4FPPuGP/NQSLU+5/CYQy0KrDo9GMxrvg2JDP4EqV0m8omsZXhapXbAVu7SoDUOwrUqIXTu0q3JcroH+ees4B3VKVjnqkKdw4BrxvcF+mM67rHPpeisSaRIIB2wBjN+bEj1nVSbl/9xhKmv1g6KfcruqvRcnFJgFdcx8T3ueHGC/BMt25Xalnmkc1oW8CJkKHT+8T/CDLAnkNQrlxARULCTh09o7fBbk3ljv2FOmK23lQXb6vJvFRRbeO60R4eGX4ntHJLvFModBAeZAmqVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypPJSS5a+iIUiGbr4O+DgeZsKKyVdQeJT/DienxprNs=;
 b=tCaAlGd5Zmn8CcqggYZXHMGHi2kCheEg1TZU43ft9ZmhscGQosBYNZLTQdnqfj9dJcWPZTmCY6zrj+OJqbDn0jMR8Et2m0HvKauBAvMzgMzk0aI6ckBx1v/HZxT4zI3fRZJlcpTl5pplPtEBTdMahpgtR61LXwtRVOHhCf80jj/1eCn+84gOs0QUsw9e8Hq7Z+Pq0zMOdIVNOP+LomSvCFNw1DX5YAIZBPv0rAoKxFGdCkTTEBiPsp67JcrcJPeCwgCYZdZBZ9lcQDtgWnfrgJeNdE1iSXNifeGDrSPzebsiuSSlOEwNM4QCIv4s8YnOGDX5yQPG7H9VR83jvnYN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypPJSS5a+iIUiGbr4O+DgeZsKKyVdQeJT/DienxprNs=;
 b=FbgnBfv2K5fMobe3n1lWWit7EtrdGZDuQe0fbz21TDr6KvgdRQ6S2NxeyOsxs+amRXbuMfSPLbvz0y2Y0vcLMN8WmRtliKzEqA+xEtqw2AT5MBydov9uIetrdNh1SEGSqaUMTJ647+R5a5HcA/PSoECbZDntyqfPBy/6Uf4SBBqVfpf74utGJOCmmgO3N73FdCO+s9z0h3tbJbDvm34vfs1r1MBBUOTRRUQIawMN07jKqmZTvRnP+lXeLxaFA9cRyr6qnLa1m0mkDUJngNObDT2XFvgAdqxkOyTFihCeOt602uYsZgWFHlvxKzsJ7IaBGo/k4aUaLT6/iPQirbGjNw==
Received: from DU2PR04CA0081.eurprd04.prod.outlook.com (2603:10a6:10:232::26)
 by DU4P195MB2666.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:571::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:38:27 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::30) by DU2PR04CA0081.outlook.office365.com
 (2603:10a6:10:232::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 10:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 10:38:27 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 11:38:27 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 15 Jan
 2025 11:38:25 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH] configs: phycore_am62x_r5_defconfig: Increase SPL Malloc Pool
Date: Wed, 15 Jan 2025 02:38:13 -0800
Message-ID: <20250115103813.844488-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|DU4P195MB2666:EE_
X-MS-Office365-Filtering-Correlation-Id: 315d9c00-0fd2-4a5c-380e-08dd3550bf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Vv9ClbsyBjLiH5aNq0J5H4drivGdZdYcVbo8AkyrJF16CfgPJeYdnInU+mT?=
 =?us-ascii?Q?33BOWt4NjTi2Lf9kwPY5xTRUFXVt4G+yaZc1qyfL7bEWyLxk5QjVRjsCZE9V?=
 =?us-ascii?Q?1sz6wMWoFQI+UWl+KRs86orRSBccBZTnEjR6okPLbpDhDjh5F8FDK2gmWQB5?=
 =?us-ascii?Q?Nup5Jp0NWXkS8xaOYJYBcTlXRtcVHU9AaDYnbKNKJrO1+AlMQ22v8MxZnDQi?=
 =?us-ascii?Q?xIs8n7aGV+8/QacvOdY/BjZ/e9zjFzNdivgaKlFuw5BIrq3xLLXqjy3SnGw7?=
 =?us-ascii?Q?fcrIngnGlGw99dVHZdTqHWXx5jKzX/W3xg5yTCBMYz8zBtdsJgScqAaMlVtW?=
 =?us-ascii?Q?uYDFw7MxCrhIe1xZhA3Q6F8xYFV5gKPr+ZXrYu4K5fhVTc48ktdUnZgk8SGK?=
 =?us-ascii?Q?Fzw/wtb0w4ceFMRVRSgqQ0HuMOwerK8SZE+CjQoTBSpAT8mC46Hdl/U1Phlm?=
 =?us-ascii?Q?qraTgq3YvmnarSXHkAJx4+BUQbZqrIA5jvvwIdNN367FoH7BUlrktPwoYX8F?=
 =?us-ascii?Q?2zEuZ637QEkHdLOQEMzF4fBOauEk+jY/Oali8qNtzTRaCgE+NxiPWE3D5jTT?=
 =?us-ascii?Q?9e55n4vhr1LNyGTGQfbFwJuXsEp9cZKWygmpkUNpLanMDXxCAc/I42GfAQF4?=
 =?us-ascii?Q?8FY63aPR1IC8HewcY/VHfchLXpW17dyub+LAtPyA0s2Ru1E0sF2EMCYUydOC?=
 =?us-ascii?Q?ubONuxlie6fh4VZLFZsjMrz8P3qK/wGEesfUoOREw+NT4cXlOrND+rB47Odz?=
 =?us-ascii?Q?IdctpLEROlhWIkwQLUwkT7OGpvsSKFPm4TzvRNI3XnDE8dovjxqcb46OqTPJ?=
 =?us-ascii?Q?jz4vN1iF0mxByGD+mDlhnDhAHNhf4/V1TARn+Exmudc3hjIKzuWyXR8yokoe?=
 =?us-ascii?Q?Ey4JbCyHkgD3Onhda36wKb0MdHs3qCSFKnfQErgOm4O4ICt9s917GAqcAkAD?=
 =?us-ascii?Q?bcE2ol6w/HB+YB25/VYGl/3UpMT3JCcx6fkspTbbUWhVhkYt5T/UW5NsdpmL?=
 =?us-ascii?Q?Tpe/51/bCdg1H+0aTBi4EdYlSuXEPVB4LhHU1rMwsyugP8YHDbrMi5igP2bJ?=
 =?us-ascii?Q?vuN25Am+zT0LrmSpTZDb0ZmF8OF25ErgH8Z98w9+ucfMPW0LQ0PuHWvyqZll?=
 =?us-ascii?Q?AS5cEc+mxdL/LwYYMSApBoIBT4NBMk/Cz6EI5kcBTfDKTQ8v1litqzJMd0Tn?=
 =?us-ascii?Q?4bRbk0iWmsmznPTXYMP7KjATHDKczBVVirM4kVfdE8H+Fc8I9ARgws9Zr3HB?=
 =?us-ascii?Q?gdXG4AJJPDrK5ii01fQ4+irqtmiaY9O2NbtuGMs4dbcGTAwGN4pCMlaqsxsx?=
 =?us-ascii?Q?Z/lEXYJWmaspKoL/jpr4PoqnX9cqwi7wbZqDWP/Z0DrQc0b/0/UJbXd/tjN+?=
 =?us-ascii?Q?/+Ije6/XeL4HR5pWvFszaEyYxI7HTstHFQ4Uymh6CkCBHgpO5DOf5X6Jtkg7?=
 =?us-ascii?Q?9xFR7+qxVjBzkCdLs2wSXm2o2oNy4Ewnl7S/6zmRhuAv6JIy+IIC328PDt41?=
 =?us-ascii?Q?Z4aoNTQipAgQ3ls=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:38:27.6200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315d9c00-0fd2-4a5c-380e-08dd3550bf22
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB2666
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

Increase the malloc pool size for the SPL by additional 4kB from
0x7000 to 0x8000.

This fixes following error message:
  ...
  alloc space exhausted ptr 7028 limit 7000
  DRAM init failed: -12

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_r5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index a856e69d88c..c5ddcd72852 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -21,7 +21,7 @@ CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_TEXT_BASE=0x43c00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
-- 
2.25.1

