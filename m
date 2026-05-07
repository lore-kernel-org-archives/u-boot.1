Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF1BCD342C
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 00:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 633AD849F6;
	Thu,  7 May 2026 02:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="eleON2ny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB50784A02; Thu,  7 May 2026 02:55:22 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FEF849F0
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 02:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY+W+QRmdTeUWw9/L81CB1ujG8To1gj+OvFcmMzAjU5p75/QQAW3+B/EGjJkzNwEGOFlqy16IKbeSkAYLDpT/zROgyULFBTlkD5r9fs4SVgndkyUiDPdM0YOm7TMLrKYxT8I/ubTQQzxBJz4tDftO2RvHWZoNVFikGVL/GIpxlC3Z+DbYjOxU+NbUQH4xyqct3LWv3o/GbWzHm6bXIVj0+D66eJqgJ8RuRJUB/WCSZi4jkHWe6Lc7hk775tsvxK9lvHyZtigWdSHqvtV0zzh01yIDD30B80seeRczkT87QBDkyWS0AIxFP+xCtOzG9LfpxG02EuIO0GFlEzouH27DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZtTQk2MpJ5rYwPavLcaYLytWbAHAHv/6DORhE6aGvk=;
 b=u5Uj1Bz1uHMUo80RiOiVEoIRMx81ReNfzTk34RDDylLuEeX+p5u/dLEr9s6rnl0jg63rETQOA4pPfpaaLv2VnuRg1BKhTKOfikUCj2PbrTQ5dCo+0Ecn3TtcwAEUUJ8lBz1ifWX0TAzmVnqLRWPWQrBUCCw8xHtZYLpoQt5mmNst3jRjF+jXDbRtP7ukoeuYETKvmhNNT3RW4sbs/3vBgAyi9lR0r7e8U7WkQ+zc7fjgVlZqPxqe0+B9stTucHzsLzGk+vDJBkOItWJKTn+eswb3BS9m6zmrnZFofiNQILNQdGwGF821qQ4lXKaj3ygyYVhsJhBGONiLp3m2Lzv5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZtTQk2MpJ5rYwPavLcaYLytWbAHAHv/6DORhE6aGvk=;
 b=eleON2ny3nyjOB8ha8z+icfb2FYiBbiHxp2tcIoNCIGyyll1AFCehKpL2Sdw02vcCwq3KVVK8in7H9IwmEtEX/fZVG4VQ7VWwS8cgyvDyHorkz8nttePpCd3vFfvhTl8qyTCCVZU7JdT7GgbUwRlxs/LVmFdKzb7IYieoa8FfKzW5Uo2V4DbOIRNquoi3U4/bxvX1deBpcumPxmGZevZBpCn/jkByRRDZcjWbgBs2LTyThxS3IZ2zCcLkQd5v6GaU6n/nQUEzl4PoxzndPX0MVNhT5L+KtlRJKueV1WHK2GHV/ELK0lN3qRMm5gvFfKSg0s9AEt+gBlDp3tyDl15KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB6221.namprd03.prod.outlook.com (2603:10b6:a03:3ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 00:55:17 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 00:55:17 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH] arm: dts: socfpga_n5x_socdk: Enable watchdog0
Date: Thu,  7 May 2026 08:55:05 +0800
Message-ID: <20260507005505.3917-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4ce412-a9d1-485c-7cb8-08deabd34e0d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: wGf0HXhbjEVJYZZqEaOMh00kPHtIvaav7fcVa/+YDaXU4Ai56Y/xIOmh3aPO0GRpVoUJa5Kj5NOPUKxVGDgmngTTKUGKaeV3MqUmAwtVgcGrBrAQhd2O3egfdKESvfd+n94kWzujjli0zbt24czJej3l6Vohv5EYbytYW7GsV1qTp2IuD3o37aELvRpsN2l+sfDQ+c5AertBP0fgZgRbQrG95L7BVm66wmg0WddmVcnlt9ayG1KMxvRsxu7XWa2I2RJHzHqOUGEcgojmd02PrMolLZiN3Dj/YzrHcV1Q2UnV9MfVaWonJoiXBJZfMzdemKPG2b9Fa8wXKi0WsH7XQFcDZsT+pWBX49euvz6ufdfQMc8bKnvYdg2UJN+fbTSMCt1aarqA5ZuH4TXYlu+O4JB/E+RiAIBx/lAfZhVwqE5soXKCX4rraP9EMwwIzm5CmoIkGZQg4tFCO4aGRnK4pJNP4NxOHyb4etMLWDlJ6iqsvnCSDMO0vrQGZKsFZ32E2Yy2U/uM0GBvgWrelwLAFaUO9YIaaX9a2l7uYebPGaaxfLBFjiR/Dk5e1+b4v1r3xD9oWlpzHN5mTwh3VyAT7almsAZYaHNZGDFwO7ntO6EBwnGRKcxSBYgxyTXE8IuduHByDRKCSv4uZ4zZvj2hBXR7/gbNFK6TDhvjzAaLcF5GE9Y6rrexuxHFDFieyqWc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GgQEDYChHtOabCZVvGGmr5gymjRLHnOn98+KqHyZR93uZ0MYMM69q9SmNcvi?=
 =?us-ascii?Q?626zVDpkaX2AitjjJ2t0Q8VmmXKgLH/5KPOlyR5rOA31BvabwOt0EAQgoc9R?=
 =?us-ascii?Q?76Y/wDrZV4Tjlprb4sm9HMZaKOBhISE+tOE5Hi5o2u7bFwy42+BRlfr5gfsu?=
 =?us-ascii?Q?3IdkemWHtgnRxzao8ZdL2Ifkk0o6GnnITdwnmYXvbsg9ammU7m0qjTSI+vZm?=
 =?us-ascii?Q?juoCmhBwYPTIUQYzyPTWtWDa4AfDdztj6txVr0oHU/+fMLEuj94F3GxLywNt?=
 =?us-ascii?Q?oOkGOoohaoS+R99klx7VRmL3uu/o9aCDz9PMhnOfyCPUwdseQTpSXlX698kk?=
 =?us-ascii?Q?8dz+DPu2yGxDs2Bq/9VG6It9zV43F3s9SQrG884uvuteJ89TPcDZycmZ8Cpy?=
 =?us-ascii?Q?JlQ/QktrYZYjoIaYtL7T4zFteExMDGJjl8psFxOzQAt0zt87zpZXtaplT2Tg?=
 =?us-ascii?Q?9TL/r37clmKsNoJZzNT1a11VT/ibX7D9T2Vg2b5H9LvWkoBmTg9fHUDwO137?=
 =?us-ascii?Q?lyhFweiG8A3pXig/ioeedQ+7h4pmlpHqPSLrTQOSM24ezZMt1ZltO38fpukM?=
 =?us-ascii?Q?hOb6jPXAwiK0Mnq/tb/INLgawdYIuiTgMOUMbF+d5Grq6AFeB/UOKmsU6AHY?=
 =?us-ascii?Q?Mi7eMxzrib3r3jvpgQ8W/eUbMvSXjWcR8WACh7n/KogpxE2ew3nM6Z4B0n01?=
 =?us-ascii?Q?TJFEc3bfzfDvlV+ssR2gVwwoeefgU6hIHfJ5g1HhJ9djMzYBBwsaHxtiz1ka?=
 =?us-ascii?Q?PDUiTIlvxqO664GhTlv/kH3jhl74TKaD5AFcQXPsciyhSyRFBQBCBbvVtClF?=
 =?us-ascii?Q?RcumEfCGcm4B1JhLekBQkc0gJnG68NncBq3FKEn8dsN7mzhfJZXX5WloKiRm?=
 =?us-ascii?Q?h0+64KLOwo3792XODAFb3jHVV0vETPEP4UT2o9iGht77mOy1mpzzhHv7Lx7x?=
 =?us-ascii?Q?eR9It8tXt3y34GGoSSGiUOWMEtkmtl71pCjDKYl7S/YRp4EpU3a2xZ6f0py9?=
 =?us-ascii?Q?sIasiUtANkN6m6rCIf00hj7F1JWMukMRJb3mINdCqE/ZZSIG60Y1gn/WWoMC?=
 =?us-ascii?Q?6hSXOYbti28YojcHs3ve6Hg1Z/uM4uK2+vlpk6wlJt+10zvGmMe5aB5yoZrQ?=
 =?us-ascii?Q?orcpGQ28wEfENAHdTgUBg6X7H+ymMXVmYREsMFPYmq1QgRx13tOvTCb21aFU?=
 =?us-ascii?Q?YkJ3lpNIz9WnAn7vOvtcEtpJW/h2dmXCHaNQeNhUfVRbuwQG+UH0O0e6Zxdi?=
 =?us-ascii?Q?Bn3Eq8+UaJhkX8wq2rRXMOqUSp0j16hjV/676lykYeQpc4eWgX8gi0T8z8b2?=
 =?us-ascii?Q?lzEXjXVcrBS3dmPaBwhD3EBbijeL1m6+/1vTwZdNmHjKFmBOoO5gqEAo4hfC?=
 =?us-ascii?Q?rfZRFRu716Km5fG/nt/CMUMudXU9I/wvUdFtf/qZMyLNuIz/JmPFGz9SPVjd?=
 =?us-ascii?Q?knpZ7rDccgQ2LCGu1AkXO8w3syvpiddTiWTGtgeBKee6Omb8W7xL/3YcAzuf?=
 =?us-ascii?Q?E3LRh+zTcHyZvq27GkzL7WfnlwU9GNtJ4yJXWR5rJnCYS04yQ99tfVMY6InL?=
 =?us-ascii?Q?/B84727F8yr63z+u6oyOqJ2AbnHAO9HbqUodFJhBj6Kax7JZ6jQlJZpHFeDw?=
 =?us-ascii?Q?TzScMUDkJu9rrRrHZtfIhnABziz2ZcoejUn+Vn0Ejkcj2mENznTk6TaHliNu?=
 =?us-ascii?Q?vII85soeUHDTme6lIBKYJbL2cwjOUiF+I2IzyjjtgM8qg/1zJsSzQ5p4cGdx?=
 =?us-ascii?Q?T1+XpHj4zv5FuSyxaxpN3AgqQ4FODcU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4ce412-a9d1-485c-7cb8-08deabd34e0d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 00:55:17.6037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q8id5jOwI167AOFRoUet8zGoMRp0KVCBpfDjADfGfSPgdvzc8sJ2T0wpi40CjR+go4xa/NHyPZ91sEKa6E5xEFTTA6SPlucsfjRo8OxXnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6221
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

Enable watchdog0 so the DesignWare watchdog can be probed and serviced
by U-Boot. Matches the existing Stratix 10 SoCDK enablement.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_n5x_socdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/socfpga_n5x_socdk.dts b/arch/arm/dts/socfpga_n5x_socdk.dts
index 915b8f6380e..f98e87bb87e 100644
--- a/arch/arm/dts/socfpga_n5x_socdk.dts
+++ b/arch/arm/dts/socfpga_n5x_socdk.dts
@@ -120,3 +120,7 @@
 &usb1 {
 	status = "okay";
 };
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.43.7

