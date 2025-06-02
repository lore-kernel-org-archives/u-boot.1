Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF68C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 07:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 372CE828F8;
	Mon,  2 Jun 2025 09:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jaLVzt0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754B08294C; Mon,  2 Jun 2025 09:17:03 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C47858004F
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 09:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MStyEnsdz3rp8jui+U5gjcS1pUsxXViI1JSCYQZtBB9SdvM7Oy1ZVZwPgwd6S+IDDIIuZ/OGiTrsYcjKdyBflK0M49KW/RIpCYQnqT2mRdgURIE3ZsLZi+mLQjtSoZJ1vvT+VkWN3+3BWyvF4UBiJEGbWqD5Ptu/EAAuZx2XqSrKPQ0frgihKLV87mu529U/3CAkL2HMu4jQRwId70dZrVEpHC1LBGAGjVMztvhRMPVQk9SCAq81cvgOcK+pGUxvY1ml+upAPZOyKGVducHmvZOC4c8wBybBOKGcFC+NVwGYhL/bR85l/BYCgnvXrJjfk/+cD6GqcMcAiEp8dUF2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u+0/6BgvQRR1CIbIjyNsGWazmfdqF6YvZbg+C7b2r8=;
 b=I5IByfohcFirlaK/9Obi5hM+W/R8kIrwsEmXFfyFIA4FYIEf4D4+owQC6wVBfc1E6LmnXLfFxqe/J5dONPCRwFnp1ucjS7TfUEyMY9c81jxyLh4cwspt2bj8i+c9SRj921w8J5KGFjk9iSMRyl/NTnOK87kUJwlH9a+ozwZcIjnmKyXIMJ1Bw9c0t4VW4foowDur9SaXFdeQLpOnEYoWbMJiSWyH8bopgNjy52F1qt3htwPgpupL9HKe4ZOKcccL3RRiyf8S7pBFMxpxskfKH9hc1z4mSmjbTGfE3rqDQrTq7zHfuq14IAjLRTRJ5MD/UkEiKCtUDsIxCgNPLCSWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u+0/6BgvQRR1CIbIjyNsGWazmfdqF6YvZbg+C7b2r8=;
 b=jaLVzt0bjhdRK7jH5ux7O7gMHw/LKY74HA1DarGKqpzb0VKoYmRqfdxq26H/cV/c0CxsOKDY8/PWW4MGQKb6AYurM2r/tjtzyelVkXHMVg9/ukK51bs+3aSU6wuCwSgA4wt8C7u9SZtbHqnXYQ7Im4jRps+W8m/14A6wL6cJxJQ=
Received: from BYAPR07CA0041.namprd07.prod.outlook.com (2603:10b6:a03:60::18)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 07:16:53 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::14) by BYAPR07CA0041.outlook.office365.com
 (2603:10b6:a03:60::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Mon,
 2 Jun 2025 07:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 07:16:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 02:16:50 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Jun 2025 02:16:49 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kongyang Liu <seashell11234455@gmail.com>, Leo
 Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, Yao Zi
 <ziyao@disroot.org>
Subject: [PATCH] clk: versal: Fix clock driver dependency
Date: Mon, 2 Jun 2025 09:16:40 +0200
Message-ID: <2809943a6ebb3062369b1a38aabe2b53babb29cc.1748848598.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BTvfvFVJcRsUBX5uaBUwJQlGCNLV0SZagz1HVXNz6ck=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTY+t9Kuz/JyW7v0/xkkQ01un3+HxdrtMy6dkLkQ3GYv
 OyMc6rbOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiy/sZGd4IGzeqPJ8lGPdF
 UdPm906BbrWLXvtzH99ytbWX0nk/rZLhv/cy9/ebVnx7y//h0AXzr5qzMnRuiuzS0nb8G6926F4
 8IxsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cef7c44-0b27-4f9a-0f12-08dda1a572fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F0a5kQjXYMVt1Ic0nihLAIJpUMtyfYhXZpakgkzz6kt8kulfUkhtNhOVvTsK?=
 =?us-ascii?Q?SZCjWeS03xzTEoOqklxxGOTQ+N5mMOXhJb75zruHtMKLCpu/KK3DfrXM8mJN?=
 =?us-ascii?Q?2JB8lH8uYbL5sKWmfxEH3TQq8LqlukO/lu//Vsm+NoCY6kF5O97zpfBrBkCZ?=
 =?us-ascii?Q?GaGOQPEaCIxaYpgFvrK04yxUcAygab6JeaFXwzo0P51wNy7r12MCQMAqYNdS?=
 =?us-ascii?Q?QfMbt7Z+xupSiqw+obyphC1YDAX6HZv4B/cgzBFw/6ap1BunuiTRDk8+JdLs?=
 =?us-ascii?Q?bOdqp0owRuYWQcCRT8/cdXXJ/K/4afFNPAVZem826QoIhL+RBfWVqiUI4hjb?=
 =?us-ascii?Q?Q7VgZvf4CPBinyl5+0v9LnGtlpIkQ1OjFjgDGj550ott8bs3a2HMFCBjN1e6?=
 =?us-ascii?Q?pD0p8mLskQqrQx/aHR6WdfifB8/DSCA5jWDJI/V4jJSdhcJAJpM5fvn0uX83?=
 =?us-ascii?Q?CC4uOP2bXK8PqX7eGpHYHl/N7g6LbX63dFgN5ah057VrrfvjAplW1PrXj1eK?=
 =?us-ascii?Q?+9DFL/m1bnAF2dmB/jwmSE/lZKMn6nYEaGyfdIe9yZRstKkACfFM8mHJ5592?=
 =?us-ascii?Q?IM5NPV1bs0OrThCNkHhN+hdFPuVO7UddZEGYhbs63skQ6QIcN5i+sQqtwdL7?=
 =?us-ascii?Q?+e+0P3kBjNA6J9OuDs7PVDbaMl8ugm4HWwFTK+Tc2rBIlTBsjdorIFtWNUMt?=
 =?us-ascii?Q?Xln0Ub8gTvmI+yINNWq9Sg503vtS7JYX4XY7xbiBep2k8eWiOjnwCK0OZLcs?=
 =?us-ascii?Q?ajWjyDof/lrQsf2SCW61cuAB/vNkm+8SnCD5fME3OeCpH5TB04XYZxQyXCp1?=
 =?us-ascii?Q?gc0RS17SZWrHO9IHsN78VT4MlXywGjE++q4zQUueQFPe6aDpVMG2HwU+E8Cc?=
 =?us-ascii?Q?VZbwpEghXIlHmUKSIfXCU6godxH5Fi5VY7M1vMbK2kFtz+yKuccp5Jx1cMIh?=
 =?us-ascii?Q?3Q0wfv++aLeYQut52flukYHzjre7Ewxj0UD73mTMFDapx57iN/anCd3lD2uS?=
 =?us-ascii?Q?Wk0UcI8x+4mkVJ7hSl6gbm5s9LGpSFNYfObBX0N5M4ZtDJwLVRvGOn2WUirF?=
 =?us-ascii?Q?/YMT2IgvPp8v8AbYQlHxfy3W9I1mZNQEPPZ0g+ndabpfDOiw/iTNV5vdZwaK?=
 =?us-ascii?Q?WNY7u7gWKH+2Qc3cIOVeJ6tlJSrnwONJ8vtTH2RlIFCau6JQO8ePVcrFft/f?=
 =?us-ascii?Q?1SkefrHTwna8NdwP+YfT/yGQWIaW6K9xtmnSy3gUe4Qq5Ur0ZbwcLwjt0efv?=
 =?us-ascii?Q?U7a7g1hnxCb+wB4OKMc9hAoFd5tC3IXRDyc3MQCxLxhFXkvFjHO/OBy1SbnH?=
 =?us-ascii?Q?3t6dApWU77pjeBzQnpSTt6K1alGfYZSQIZQlEhVDKVkEVAfCu/Ar3MzHfXvg?=
 =?us-ascii?Q?LTGHHiAOhHptIm5wX2nGfo0ysxMC9wSVev/FXn3Kx633Pl66xG106MvXhPaG?=
 =?us-ascii?Q?Wq1ddZ7iKtmec840UgKavKfTATAdxi6p5TzNBJ5keBYi0/tr/psm3BvjHUic?=
 =?us-ascii?Q?+jQM5cTvr0bG/uCmy9SL8KZEPXdedhDNqcfd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 07:16:52.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cef7c44-0b27-4f9a-0f12-08dda1a572fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704
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

Driver fully depends on firmware driver to be present that's why change
imply to depends on to cover it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 19aa2ffa5396..d4dff571412e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -214,7 +214,7 @@ config CLK_VERSACLOCK
 config CLK_VERSAL
 	bool "Enable clock driver support for Versal"
 	depends on (ARCH_VERSAL || ARCH_VERSAL_NET)
-	imply ZYNQMP_FIRMWARE
+	depends on ZYNQMP_FIRMWARE
 	help
 	  This clock driver adds support for clock realted settings for
 	  Versal platform.
-- 
2.43.0

base-commit: 59f1100aff7e6b855f73f55c2da52e77cdc64fcc
branch: debian-sent3
