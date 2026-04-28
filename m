Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A3FFF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979538467C;
	Tue, 28 Apr 2026 09:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uNEkLKL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B8D84178; Tue, 28 Apr 2026 08:50:30 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C9884150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiArgwZbmRFWYeIrbdtkRFHvg+IWdLRVBUbNwqnXFfLlZYzNBmjbspcPo8iFTpfJt4OCUXKuOJsYv5q9mJQN1mwm+lsH4PmggcvEkaM/Oc8aH+eBXox0ukDDgbrqPJDuhh/WZM0+kOT6m+9ChdgHpabYZlmckk3YjhobRnbnIycAzAu96xTyNA7MF0mMU8GpiHfwjqCJyQ17zNv4KyWCFJKItvKzDRhpg+HGEhmYFbvTQI1HHx8luGxE7S+YzlVS5/6UVqYzO3Wj0igLNHXm0YVW2WsVAFhpeQVahzIj2DaCOmegmdCKoZFMYpc0FOj2CEI2ZNk3xBuOL9KSZIzUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EpgrA+gxa8tVS9w9el6ZcrMdUyjzrRn4i6wEXPGmtg=;
 b=ZcJ1/qhWUCHnBWdtX12oIrPUx8wA4oKlQZjndxhRw2Z2xYHJRF8s5uQB5Qw5417GkajyL4zfhpr11awMRbvqAeJt2WXjhUcE3qQVGLkcZ72rz5GSA083kE9bEa80aMs7qrkdlYTLo9lbvBZDV4Xgl6xsfY0zd75x1yEE1I8SQ6o+q1HXJkmMbud1eA+vx7LEahcmJSEXi6DxaU52qJCp3/gWDMgMU+cB1FQKthGU6M2Dr2iKWtS0alZ9qMoojy5PE2ZOkAk8K4WpAdpkdbHUpZqYCnmU7sGSLgt+kgX6xNvNm6vwiaXSMiMiaXqMTov5tw7DSPxhpWHnWnwRi4AGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EpgrA+gxa8tVS9w9el6ZcrMdUyjzrRn4i6wEXPGmtg=;
 b=uNEkLKL7OOgRzI9Z89npmVik+sh3OojD6owJfWRROcaLhbugheDgce00V7O8OA9DxVZtcKfCfJeIC7KGq6G+H3g6b58Y8rA+4QlrIM48dG2Pxm1JHDnt4XyV1dyTSaGVDsGYbDdCse6sMqtRPy0VHMBmqWxuIFkhLEeZ1M/ahzKdMdkMZ4mGa/nKYuW5oLzFRsMWu7qKmcB1osLSXVX7Ht+vEhmTE7MyeLqSerjiw9Zkf9bpkPES7W8OiCAYjX1xIND/rsPMc2EAK1k6oyv9WhEhYajm7x2A/G2Hk4g3631xshk3+z/YjUAkP/otsvyUzLEFIpimqvN+VvkELf+iiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:26 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:26 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Subject: [PATCH v2 5/8] configs: socfpga: n5x: enable ISSI QSPI
Date: Tue, 28 Apr 2026 14:49:49 +0800
Message-ID: <20260428064952.3965-6-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: e21789f5-6a69-44bf-b2df-08dea4f26db9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: HhzhdN40+UkVx6a559QxKr4txGPOcBm3hl07Tufma7b97cHsqNZAfk2IvT7ZXoZbERR21rlu6igJODlfmX9QaX1T22bMohizqSoc6zXCqx5TDxaVdWE/lABE1kWI7b7ad6YG2xUddVfsP1izo3++xdhrh0lEFkBFg6vdqNxfAf/191z8ldfXYIBNf0mS+PeepDn4szaiBEuskDWFALhIul0G/K5vhgXK0O7S+41zlELEzlS8OmG54KvWJu5cC+lcyPlrBw6PBaO0O00B9RPuzP6dgkc4YFmq1hTvEhTLkJsxGi/SPZc05Oy44/2i+2s3c+4t6G5QkD65Ls4Y2DqPOXv1mDMQcoszB7Hxp7PohJWJj/PibHs6stRX8omOrp+V/m952ZOpXVCLiGWvqbLhbAw9ADoQWrVO0LmhCDu4PJJd+IctWSg7krZ2GM30CuTl+++AuwxoqUr7R1NSACogill3G1oLt/4Lqwg315Cc7ZFsfM6t4IFLxG+FI6o6yIA1/uR/0AznQDAsC4V7OOqWU91g2XhNmZCq5xwaBLPCkNfbil6JZRVUrz2+KciodRYXSeYvmlIjgPP0orfEGUL8ZiRuRZASuG443jkbYFPFGo8qJy30kcC2Enwh0X3tGtv/AtynnHLu6vDkcohwHaDFMaVhVfaz7wbwIM6mbcT/cqkrw4L4Ph3l+SG+vAzghxYX35orUXOUsBmOO01uV6NbE1oytNwRwR1tog/eqeQbqlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ByIcYaydWuvQ4I4+4FAarxPXrUlA1gkwn84Y3JZ4jvzssYW5xP6Yr/T8qal?=
 =?us-ascii?Q?46audJXNno3A5WFXDKqYMOiWuOo5FwUy5pKYK/rwSasW6iMeAFIXIMUgUJHc?=
 =?us-ascii?Q?jqfYnuc31r4guhxVc8s9TJpQ8WMgcqXwq5Sn9PW9k/iK9L/IT2NkhAqHMRCk?=
 =?us-ascii?Q?YrYkWw3esv6eTvMcM+qJ86HHYu6T1lS2K5N+pofB9BN68q9giXf3N8K0uDof?=
 =?us-ascii?Q?2F+EfT0PGvWEBL74gpC3T9iB+jER7f2NxE4zvUQuYQ0QKBBrBF1f9cWcTOey?=
 =?us-ascii?Q?QOaXy/bFcB+1tCBT/9THEHo2Te5FjOiTixeM6gUieLFwAPxi/07n0f/CXsT7?=
 =?us-ascii?Q?u7Cxsxo5i+x9tZ87KfMpmgT9S0N0Z7+vqwt76hIgHIynLA/dMb1z+idsKeGU?=
 =?us-ascii?Q?QyCaiZN/iFkjC8CdxWCXyxiKmBsBSEiNeLGuTUQSdP7b5izpLSM1xkl4SsJi?=
 =?us-ascii?Q?jNNIZ/PbnITiHUVqvl7QXrhjz3tNKCXFyVYK9Z9iE6Mq+NpZqsh1dufZMrCH?=
 =?us-ascii?Q?pSjxUnzuzrSZNW2+fTed0pu9e00MZB6GWA6i3UGrtxhsbWorFmy58ZyCu7lo?=
 =?us-ascii?Q?gi2Gnl3Hajkxtg8oLlCMPwZaax1/O/O6vjllZtLF5KJFLDQ5iL9UCZHwLxvO?=
 =?us-ascii?Q?t2OSnzCgTsnxEouq9piCTYJXAVMUaf00xbfMrfaUfBiSVxg/KCS8Og5UWuvY?=
 =?us-ascii?Q?zIpQNN3Fe3wPX4dUplr+Lz2iteB3CilPRezyzUXm7Kb1sqso4veZd7AX/6vb?=
 =?us-ascii?Q?RY7vtB+gbdmCD/Bp0rQnrtqiBG5KlWwyoW1nZL6dIHyrBClBbUCAT71+g1HU?=
 =?us-ascii?Q?DQsNf12b0VY6jRZR+IQmd2MjNoX744Urwxj98w56vVMLu4AKm3v3yGI7FDBu?=
 =?us-ascii?Q?dP3a6LgyeV8IM/BCiu6p0ER53X51q37Cyd40Gnzz87erL2atU2HzYL/Rm7GD?=
 =?us-ascii?Q?FahlQfw3xLB2ALhSwZV/xvVcmIt4yCZgRfMV6wJRGipYJpEUoB3KYktGX6L5?=
 =?us-ascii?Q?wM/G8/6FKDXyco7iNZTGxjhFqNWYIpJMo37ZzBRhUQRZpE8f4WqpB3hFK/HE?=
 =?us-ascii?Q?Z5WKq2JSdY76H6z4Fy6/ZLaKFnQIENUVrLZX3PartiZdDarh9NwZM67CaP+2?=
 =?us-ascii?Q?L5xqcVPqr4vnn6vDCqQS7DZtLMXTE0oBLiK7x1Ad5d5O06OtJ6vSgLbwxngx?=
 =?us-ascii?Q?RDBiLKg6syrt+ngjOJtApHgr6jVRc8KeyTcwzOahEjFvI+a0wYyPdicJdBqK?=
 =?us-ascii?Q?iqKEwpdPbF4KklMsUjBpNNPgCJ7dDP2FL+QaADYHmIoH0iEOVhGgOyeZHnun?=
 =?us-ascii?Q?gJrQbQUAPMzEI/aSNgci+yTYIa+sax3v0g4L8GkOwtsN6jgvphkJHmNRTRJa?=
 =?us-ascii?Q?rnZRNwV2FaXMkKD4O8sIptIF+/E/bHPADL0w8tqCQCh7ElgmcWXvzczXWfDd?=
 =?us-ascii?Q?rNgipMgjLvUWpuJgIHps7Zk/5HdElfmIQDRN6uPtz7OSlSPEguqcz3QDziX5?=
 =?us-ascii?Q?ls/A34bYQrlvrdln2dHpSgz/4ZGL1pp/tVacrjd0pYe5UBWUkFeF6+bvhXwZ?=
 =?us-ascii?Q?AjUwA+VEFC/JXqd4Orm8oGB1wc/wZOaWkBr3VM+Mo00mBqqCJ599SnbJR8+9?=
 =?us-ascii?Q?YoICY7+tI6LTWO3mySqI6R8CBzve/RryVS8S+BOfxsJvQa2kCKR/E2J3KaTz?=
 =?us-ascii?Q?s2mnFNghToyP7qUTiyPnS+cLt2WV+85ZgUCW4Bn+ObVYUqChotdsFf7WbjuQ?=
 =?us-ascii?Q?KN7gjI77qDFSLCN2JiKze45PAFlN7Jo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21789f5-6a69-44bf-b2df-08dea4f26db9
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:26.5935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK6E5t9z1WG3DGiPQXN0b4t5xfWgayuF4WStUQM7V+mZwcCSNH87k0dIlXZanHP4Rp8adYRDRjhALCP/FdXbq70XhX4QRgiKepSktjNxnp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable ISSI SPI flash support in the N5X device.

Signed-off-by: Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 273e74c6499..17dc55aa41a 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -74,6 +74,7 @@ CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_ISSI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.43.7

