Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757F2C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388BD83E7F;
	Mon,  4 Aug 2025 03:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rgMuOuFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D09383E19; Mon,  4 Aug 2025 03:25:29 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD31383DB6
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+srET2OMXxLSYAf15fS+tpyR3WLjo5nK5q+WINJa1hi5vXAkdggfP0UmDINEBEvG0WijET37Va0UmENvOLvx6dBYl72nv4Zdce6fTPCnOokS9pWvguwiMNKvw15jsmOeHEa6FQLdiPxns3hS2fuaaBJngIg8ciVKX9BWeZWGs6PBgU1Uwbh9ZWVRph5msyEF3mTAkhIye8Uf/mxheQKGZy51i6NCvmXrY0dKyjv7jDMmNE3sPQv5upwTjh1nWur8p5J+RqYADDJrLSLtmvt5pS8xbKF1iF8mcfqHI+ArE2EJoTaXNweBtNVWikEH6/zEuXShGINTef/tgZMLM+xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe0gMLaYE2n6vT1jk8DBjB1S7X4RvZooi/ryKAFHMfw=;
 b=ce2YGUaLAQ0VZk2Eqfugud5y7NklAZaRduBynQxV9sesye23RHlLA/PFZ1+vtLz83SpuX4iDH17qB1SBAzxjpxn/Zxeht6Y+jvLKJjv+6eN/q1vPlQQKBYWP27P0mY30a8MZDNyDj+9FafLcaStZFqq3tN5JAm+MVXaK0Vk+UI0kWldSclevGWA86X8zHOTPuBckzh1mXZzR42LslNh78Rsd5mveN+2mkWYDVsY6l7sFtsffQRCSa/GnMC5Ip/n5NU2m0R8NdC+9ru3YgHWPE7oXMNt3hSY+iPgS/x1+Gq4vz1Ks9goi7IRhvoB8QYS2PCmpiA7tx3B/bPmdoGI2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe0gMLaYE2n6vT1jk8DBjB1S7X4RvZooi/ryKAFHMfw=;
 b=rgMuOuFU8QI6v2y8ebip1kftpRoOPWCVCBYctZ1y0LCuRr317HBGXR3NkY96OmQULeq1qw7xsAUQEEvHXDcc1SNbgi4kGfmnsi9+MQT4BZkVd/5Wy8Vjq9T4lwsM4LXOwRg+xA6GlQnusvUG+ELFuq9WTul9aUekYPS4ESmEl5yxJlEAiv4hrq0EtdleVSKhKvZafuz3ap9wM4yZhQ355lvfr5PjmKrz/faBJDSUjsrSwKpwEf4pKCbkIFK7qUsknEALTUg5/BSA9e8ggYzKn2C04VFGJAVTwtTkR/K3VWD5S/yOynsw9LAaYnU2J/8Xq8/F5VVPdfyeckahhejMjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:25 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:25 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 16/34] arm: socfpga: misc: Exclude Agilex from clock
 manager base address retrieval
Date: Sun,  3 Aug 2025 18:24:43 -0700
Message-Id: <20250804012501.21811-17-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3e6e5d-1d4d-428e-3d84-08ddd2f5ca11
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5NsB2PyhN9jTyhE6O/MxLmQf46z2SOMaAqq75kgy11K5VPGbSE45ZCQDs6Sd?=
 =?us-ascii?Q?7s34x0Fje2BMKdt05Wp4TSvmkWvJ/SU+ZvXCHRXHTVUYsPo0//VMl2Rqbu6K?=
 =?us-ascii?Q?WIscZDRFSQaFPfycoJulklGV/2hjEcLgsM5XItgim7jZBE2VxB7x9+sY8QJW?=
 =?us-ascii?Q?kIbdY6aeIPfpOlK3P0FZ6DmUSE6aU90u45h/a1J2Jj0o3891ATMiTSQy2No+?=
 =?us-ascii?Q?kx0alPeOY9RezsUSwMjUXhgdPqHWEyZTg1MBvZFJfJVTF7oQHNB4PZ+j2XHN?=
 =?us-ascii?Q?I28KXEakW89iA9n1M9leVDAkeYn4WzRjG8aoMDSmX2bNPXdYhOJh5qkstvh4?=
 =?us-ascii?Q?UVYBS9jR1a1/db6vhEGU1do0RMUgBoC3hBgl+37XPQUebY8WrvOlpaMkOkfS?=
 =?us-ascii?Q?qr0O4OU2nydF54LfhcJN7zdnUuU4qedtuUkRdyrtRdFsAMtjLbb96DmP481M?=
 =?us-ascii?Q?4pAyXWFf9hYmBa6zrZaNORAehVfF+g8cQi9xFo0jRH7ap/ApZA0oRxAol3AM?=
 =?us-ascii?Q?RRqRTy3QdZTo2KXF4CL3GPwkaRuck1G9KMcnso9VaP1//PiGw7OV2Yht2WAW?=
 =?us-ascii?Q?8++f643bemonxVxT6MeWm5SzP0ZedvFeQiSz3rDvgj07lmFswHY6AKI1gLQ1?=
 =?us-ascii?Q?2sHLTuTygO5YvJew/7ZILD8H2hKjF49OhKYsAtXqZcwEJ/SdcZ992jfuzyHI?=
 =?us-ascii?Q?0VRblUyTdk261Pd+w97hOJ4MaU/VEly/8JGJpqy3HPSzXmz9AA9z7vaWF9mg?=
 =?us-ascii?Q?u535Ft07AGwi8taQXBe/RSJhOpZCLwCg1N6FvATOqc+JVkWlvVzaxdtDQQ6J?=
 =?us-ascii?Q?e4nqdBEzIUki9AZg7TYIk1LNQE7Iodq6tsdpDpp1ZpJ927f5GGH1kxHOzSmg?=
 =?us-ascii?Q?JACT+O2cImngY6P7i7c1oqJKPdlovU/XHlw1uyZZb/JUIiZdkAnsIYLbD3zF?=
 =?us-ascii?Q?red1KkjvNfPJ+l8a7J+z5AW8Z//9xdS+arFunAR2oi0uyw80UmM8E+cw2dzt?=
 =?us-ascii?Q?tR4J5YFJjNsUDqd/Ipsx9qOv8j3NQJXq886RMvhDDX0YKOcpyAYFOZmfBLIL?=
 =?us-ascii?Q?FQdvoGhOoM8rqs7FVXjVR+sYVU5IliPdbsMA/Q4PEfqalsqnHpb3NuRZa4xJ?=
 =?us-ascii?Q?+B6WhPnVsSg2xC0pBEC8lF5mp0eQj9npNlxAEckiw90pxIT4oKokL1DpHW6F?=
 =?us-ascii?Q?iXYPnJ1ZZH66A5FbSDKwnM2KczQQpUOhbcM6VaC9HK8lb7OH7BT/vc0xHulR?=
 =?us-ascii?Q?DQQi705KOsX77iiWVkmWvaJ7nAgFKn/my6ClkKVUbyc0a5P4et7Ti3v/vIjR?=
 =?us-ascii?Q?qaUrqGjum4ujgjlEBQn9j27Yc6MUTc7ZZ85Yui5/WYAG1qEtgIk+LwCT1aGE?=
 =?us-ascii?Q?17rg2dpM2bWJq6MXKxZwKQ2GAY/H+87F4B0jmFVbld4Sn/j7Ug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWjekkkNeHzLIGzJsoqQcauTxisz3MUt9WraKQU90qdQbony5B7u3ScWYQm9?=
 =?us-ascii?Q?NyptFalUgFOZ1gTVMVKE2Nv0frD2z/eMaRtrzRvnuhDzfblFplqlXtpm2bdh?=
 =?us-ascii?Q?H1v+IofPpldIiWaFDk9CHchBUFrxwtSIxeWK8Z8twFiTdSTCC6LNQFkDDO5B?=
 =?us-ascii?Q?nl8kfYB70Wv5WyCQ4anQCLzpX7N54sb0HUSUC38uy1UdAd2jdL5RnXSLRLzx?=
 =?us-ascii?Q?ptFVsPuuGIyhEhVVN0G6HMHHenzx7DOBztuUQ1n0hC2bpynZUF6EUe1iTM8s?=
 =?us-ascii?Q?Ruk//P88d5+UERvpIQxjTHnXcq+tKFf/jI1c+TGoQavaw5u7P22pGK17hkNI?=
 =?us-ascii?Q?e+9RHvvLEgX3wUh4iC33KCtvZ5vhUKHDqnwVFc4siq+HCXc91RK2IcZ6xKmf?=
 =?us-ascii?Q?gDdjYfREK8gSTtiPyd33eEfSpMAD+w0gpdyg+pV1QBf+VsjaAyx3/U4ssILf?=
 =?us-ascii?Q?/3Gb4BtgDUxWGJqxdSMcVvzgyxXaH9OGoU6oREmfjQgLJtynIncwk961+/e6?=
 =?us-ascii?Q?wJD6Qe+uwSJtR1B+RcbO0MOs3RkVmoVnEi6IPZOpAl+XEuTE20t0ZYE+0GLa?=
 =?us-ascii?Q?+x+KCm0z9Idb4bQHbuCi2lvtDu1x02Ol2oyVaABTDt070QOnaE3fc0HPJ07B?=
 =?us-ascii?Q?ZYouiIJZRz8GcEfOLjXua6REvTkYnBBRHHXzARDO6h+oQUxHhKfqypidQEnS?=
 =?us-ascii?Q?/+6hnAfLCm5ZybC8LYQqYiVNo0EQlcb3SvXjxdpClWKWD5uFLIN6mOKtGcD7?=
 =?us-ascii?Q?yhawy7Xdn40a7riybGdJ+A6ZOhh0wj7l+nS+dbbk/1+i+XgoqbjYejBol97g?=
 =?us-ascii?Q?rUI1ifG2oKmJl/gvwqO9sdkMRlFsRkEwQDzxBle31eTY3bUUtdMApaIHcf0u?=
 =?us-ascii?Q?gcC2s4rtk5n7JIAuBIwPzeerCr5CDvVx6ItSA3lUM4BMNKvrYzZMNJnwF4Mp?=
 =?us-ascii?Q?ose0UuScDsOhKglgnHlJ5MH+ZrY+SgjYKUa+l1X99fpSXbeal5FXUwHim29o?=
 =?us-ascii?Q?KueWTKcddzkZC1ropLo9B1ZuQXNiTfIZomUzvZk8BLGCF1/5q1LI2u1Ts+9d?=
 =?us-ascii?Q?wlIvp+a5kluykb3UOQrvMDrOdFl+nRjqMu0kG41U9z0oBIUWl7ofcqaGrdqE?=
 =?us-ascii?Q?ficc2AG4wItQnfZD1hfxbdmYoddDtSmUTHZYstWxuf9ulKVpRyn8dgEpQ4ku?=
 =?us-ascii?Q?bampFCGOf8OKbcWZKMU8KgNYy1IwIpPFCB4wmefqHnQZFkGr9RJ0O+ojywUW?=
 =?us-ascii?Q?QxnRZ9RZPs9KNVy75qWU7XgA95ICrJbsha+wFyAw2gyE3o1lRc/GHVoLqdK2?=
 =?us-ascii?Q?R2Bm0xeYSsuU8pftXsi914Y9U8j/lFJrsG2n+rjBOics1jHiMm8RNdAQsweE?=
 =?us-ascii?Q?dhAxE6wRmrtli3I75ZjkcKpeSBHxkVYa5yOE+CUlmpHvgZKvudd98jpZpDZ2?=
 =?us-ascii?Q?LSeq/bJJ6570jS4/zKRVZD1vq7LDHWtjJikTShaCUzvb5tA3Xzvn3en85+qM?=
 =?us-ascii?Q?ke6aEurSvxZtbxgCiYdzn28Rc2N0vvQHnV31+TPJb6GotyTe0td6q2WeNhpJ?=
 =?us-ascii?Q?e7kUePvaM1thmqQz9RxjkeF2y7H42q3pNWpHJOL1xj5hEDdJuQkVsC/sMR8Q?=
 =?us-ascii?Q?1PFyyOy5yXsbzrp+uDAbG2w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3e6e5d-1d4d-428e-3d84-08ddd2f5ca11
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:25.7074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9aLmvbHW0ZiKFT4HW3dUFf+li4RB+388OzXIRjZgFH34ml8XqoQYhIHg0hi28ahRwc4EkDBjl8jgdCKL2Do1Y0TIhsBOniscwpAx4T/NhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Agilex retrieves its clock manager address via probing its own clock
driver model during the SPL initialization.

Therefore, excluding Agilex from calling its clock driver in misc
driver to retrieve the clock manager address.

Once all SoC64 devices has been successfully transition to clock
driver model method, this implementation will be cleaned up.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/misc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 3089f823b20..eb0eeb7bef4 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -261,13 +261,11 @@ void socfpga_get_managers_addr(void)
 	if (ret)
 		hang();
 
-	if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX))
-		ret = socfpga_get_base_addr("intel,agilex-clkmgr",
-					    &socfpga_clkmgr_base);
 	else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
 		ret = socfpga_get_base_addr("intel,n5x-clkmgr",
 					    &socfpga_clkmgr_base);
-	else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
+	else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
+		 !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
 		ret = socfpga_get_base_addr("altr,clk-mgr",
 					    &socfpga_clkmgr_base);
 
-- 
2.35.3

