Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20011CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 10:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07248340C;
	Fri, 12 Sep 2025 12:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jiv/Lr3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A059E833E9; Fri, 12 Sep 2025 12:06:01 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2CF8340A
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 12:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCBejI6HJWe4nMeHgBrKcJ/Bz913MS7mjRImXRlJ9rIBBl0BfIKEnFdEHaNIELKM80r0iV+sFd97J6ZdpGub/cfNgbVzvgYsFswkJ+TMkwFw3Isj7dsnnkDtvuPZsUrVkX6Oph0F7T0U0N10HfCj3BOmFayF5fIF3dYEJn4OFNT/2MV63Q/7HHL/RB1cZD2a3eRpQ8PzOGHWgvw5eN13KdK/VSUYPBjq/4uYoGhxE7g6TCpAhSsKrPK7Lsl+ob4pODVGx1WT4QAt4FhXR3gzbJO7tIXNNFHxnpz5y60hJYgaxm8LMH2bThip5ukxAkYr8BGOWDR80HYoT6Pmk00Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vZIHPMELFEGwHa3rTvVIUuI1xxBrhYaiMub7FYQr1E=;
 b=tiiUota/Lv2bWRVrCqVZPDgGWkohI7nS0nmw3WcCBumMwPHsqjgqyQn3IiIt/05YqYXUGBHO13KLUzHk1R8zGgKdPo0eYAwX9jlpoeomgqAaHm1cDNXh0FJBBUyR79Q8fZEtGdnoz350VVPevG+AxGUQyWQrP/pETFD5I8xOAvPZRdf0XdJdnV3G/MjH8fNjnCIE3wrX5ZgjIXcB782nRl2DJ2T/Hf880Em+ehzNsYPjZaakKojrWFnfz5yLrIfVRXp/rnA51qROSaZzJVP0TwqkAtnZO9bEQnJYER13CJWc0w2Ueei7wk4EgkBZUt6iKbJt/pMXqNYWwXa15EKNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vZIHPMELFEGwHa3rTvVIUuI1xxBrhYaiMub7FYQr1E=;
 b=Jiv/Lr3f0HW0Hc6euUotRVNlo7HZHn/h7jdGJm8kLktUGSAAmhFire1d9WEE0WNAdAGccO62J0kLu+KOzlE/hmWx/+PLb8JSZugbaelKetAmiDmHoNS+4NWghDMymKyMwfsXzFjE5GsARyIu3+rIJ1C+FroCqNqTBazp6Y0VxkA=
Received: from MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::28)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:05:53 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::1d) by MN0P220CA0013.outlook.office365.com
 (2603:10b6:208:52e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.0 via Frontend Transport; Fri, 12 Sep 2025 10:05:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:05:50 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Sep 2025 03:05:49 -0700
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH v4 1/2] FWU: Add platform hook support for fwu metata
Date: Fri, 12 Sep 2025 15:35:38 +0530
Message-ID: <20250912100539.4127378-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250912100539.4127378-1-padmarao.begari@amd.com>
References: <20250912100539.4127378-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3c4257-6446-41ce-e36b-08ddf1e3f48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4hYFjzyryxAtBzwe8pE+1L014YlD+/MIa+EBTtFz3ernTVLvCZVo79oqwkbA?=
 =?us-ascii?Q?dJQvmue1BylCKWs7U6lD1iHwfGUHUk6iJn1TSCtUz/5CPsNXbbc1RL8uwl/e?=
 =?us-ascii?Q?PMqplfLksL8KEK6enbzBEC2xjOTu+SxROeoh+i0eh/HKK3Tw3nhyaSrJ/GRi?=
 =?us-ascii?Q?fl19hR+784nu09bxDMU55TUFtCOov2F2OLfTTg0ys/zDIDjgqdqXWkTk7qF7?=
 =?us-ascii?Q?beC9Rzkh0E2mjxw+erKVmDJ0PayZFjZJMKAG16C4F0cnAPvVJKd0AcwLoMoz?=
 =?us-ascii?Q?pRiPoakhnqV5BIdig82Jy1GJ5qUAwY2zfjU7T4Jxhl/9SiSSClYb5OGjRkz0?=
 =?us-ascii?Q?xAxts9xu6DYzORIVcJpbX/AWjG4pm9+4+QoQvNJ2CkXrXUNxJDXMxNse/9KW?=
 =?us-ascii?Q?iMg0Q8hfMIsxJtIwoyik1UIY61vvOIOe8jF38oMJGOUoy5dUZYCqr9X+Uv5B?=
 =?us-ascii?Q?gCkiE6ArHKs6YQY0aT1pO9vnknlXOERN6SBi5Zxpb+iPSWObZYQ5av7XxcMT?=
 =?us-ascii?Q?9GPLn9KYXHu+ClxSHRGmG7dkuColP1vcrn9yzeKLGdu54Am/st855MOe1nGk?=
 =?us-ascii?Q?/dGxs1aCMJKG1d/caqZ9c29ICofXAtVM1bRGbYEEQK6R4B9yRqqSPbC8DIfH?=
 =?us-ascii?Q?5c6gYdK3gb0c7XRcyRV4owmQLmPNT1Hpc8Jvr5WOE6fMq+oCVDB3rxZIKwxx?=
 =?us-ascii?Q?ul+Pg0U1NB+2VEq8feVP3T8JDeFTFr7hKyLxzN1AMwOh7mB0tpfuvshD8+/a?=
 =?us-ascii?Q?+rRyMSP7M5j+CmI6pAhrDM1ciAvLf67Y+rXMurHQq727TQRYdhmNQDT7F3kC?=
 =?us-ascii?Q?qtE6OkRPf+e6Z8hbFib5dmHqTTSxg7EKWLwCzTUZA7t6eB/66+IyRljsI+85?=
 =?us-ascii?Q?ThzLliQj2/YIKPHNoERIochNtz6yK70TvVodSzfIBFMgjJ/6sEtqTfQIHZ4x?=
 =?us-ascii?Q?s0g9rnh5FCjXqwDGTjnzlPbJAmi87y2kfXN4S23szBkWoWOVShgx+YonzW6t?=
 =?us-ascii?Q?wV5fyBqsDt658PD16+bravMJfsu5/qjirt8Cp5dQDnkzY31lHA5WtJWozT82?=
 =?us-ascii?Q?0jlSkZyick0PUlnrP0Urh5eCgsjzKRM+3d/qUI2n+AIdhdQYtnvNcblstXPa?=
 =?us-ascii?Q?tcgkpp/gBhVdWRxIobcEvHidsnNtKpyeF6idK9GimiVS2S7p2iHDMjPffizE?=
 =?us-ascii?Q?QV4h5dsnhwpZwCcuDPTptLbjmhyEeId2F96nKq+fc/Sl6TpJnC4+4rbCcSHS?=
 =?us-ascii?Q?05DkRz6BqR2Uv3l/sNnwKlYSgQUe1TcFGwn8qmOSuSZNDK/WSdLF+V6hsbVM?=
 =?us-ascii?Q?7rdZLa1Rszz1qm2EfrUemzeLMRosXj9h9I9W573MTSV5q/8N4pyoQ6pk3Kk6?=
 =?us-ascii?Q?XJJ/ZW0r+gw29Ahrxe+nAlFOT+uTcSJ4oMNcv59h3XIpgPfceR3FkRUIWf99?=
 =?us-ascii?Q?hH4EVSHO8lmbSeV6ARuU9CHhARNezDRTksmnKX/fQdDt89x+28zfk64AFaL1?=
 =?us-ascii?Q?S+0lgRnFUvRcGG7v81Y2sMpnXWV6gu2Jfx5/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:05:51.8936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3c4257-6446-41ce-e36b-08ddf1e3f48e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

FWU metadata information is unavailable for platform-specific
operations since FWU initialization has not yet occurred.
The initialization function is invoked as part of the main
loop event. To address this, the FWU platform hook function
is introduced during FWU initialization, allowing metadata
processing with platform-specific operations.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 include/fwu.h         | 11 +++++++++++
 lib/fwu_updates/fwu.c | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index 77e60167fc7..e7bd1d492af 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -128,6 +128,17 @@ int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 int fwu_write_mdata(struct udevice *dev, struct fwu_mdata *mdata,
 		    bool primary, uint32_t size);
 
+/**
+ * fwu_platform_hook() - Platform specific processing with FWU metadata
+ * @dev: FWU metadata device
+ * @data: FWU metadata
+ *
+ * Provide a platform specific function for processing with the FWU metadata.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data);
+
 /**
  * fwu_get_mdata() - Read, verify and return the FWU metadata
  *
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 7f085a0211f..0f5ef2ba515 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -655,6 +655,16 @@ __weak void fwu_plat_get_bootidx(uint *boot_idx)
 		*boot_idx = 0; /* Dummy value */
 }
 
+/**
+ * fwu_platform_hook() - Platform specific processing with FWU metadata
+ *
+ * Return: 0 if OK, -ve on error
+ */
+__weak int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	return 0;
+}
+
 /**
  * fwu_update_checks_pass() - Check if FWU update can be done
  *
@@ -712,6 +722,7 @@ static int fwu_boottime_checks(void)
 {
 	int ret;
 	u32 boot_idx, active_idx;
+	struct fwu_data *data;
 
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
@@ -770,6 +781,13 @@ static int fwu_boottime_checks(void)
 	if (!ret)
 		boottime_check = 1;
 
+	data = fwu_get_data();
+	ret = fwu_platform_hook(g_dev, data);
+	if (ret) {
+		log_err("fwu_platform_hook() failed\n");
+		return ret;
+	}
+
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
-- 
2.44.1

