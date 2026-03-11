Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B808E1125803
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD3E84027;
	Wed, 11 Mar 2026 14:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="voMcyXMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2453883FAF; Wed, 11 Mar 2026 06:02:41 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FBF83F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRsbnnFg3/E4AZJFGV5lLJvRX8VlnqvQWh1gXujCs642d5NQQT89dLlZ9SqI1B5TXj5cagmcgFiAkhfvXfATV5NW1EM/HoTCntk14i+yM9HOcKDf9Nvskc0l/rGXXjitWEP3C//6BZUDlnERbTC6sTTg2lf8oscZdDld4u4H0fI5iQntDtuPtNtD3nbUzQVECt9DUBLtCDgMT9//6AJls4eGRfzC/OKr5OhRcy+Nz+NHeezCH9Efx5/VJQ150p47aD4vHGAVpD8IU98JzYdSuP1m6mDOoNwLblvZ6Si9YBx5lJD+QZ043/Z07fJnGyoooxjonLxgCSTu9jQjyIP1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJmJlS7TnRVspGtltL2FxNmwGN9LDQYbwyZIVLb/Wd8=;
 b=AGW29fBq2hSFQHwW6rT3QVuD3arUyK42jr95aBbPd3VWEW8TOsCnIJj9OVPwSSCjLFoAOw4L6AdCjUzT18d2ynh6RA42iBPOw8knUrpJc0ECyaSWH7fbZCsDMkJLA2WbY5tWegrwrHELVxnb6ywS/wDM8IAnSab1xTvYlTTtcbqZL/leRlcN1zBmV2JzuQUxN9njuXE1Qw57KwtpRm8YvgihKdNQr8myegtw3J530/jpsBiCvDpgaaIum5YcwFmvOLU0maCw7DN/00QDTKSCgRH1iO9Ob/PbugKOsa1w5U3lUC3pzC9S/uUs7pblna63go+0lOCUgC73aX2Rq2/H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJmJlS7TnRVspGtltL2FxNmwGN9LDQYbwyZIVLb/Wd8=;
 b=voMcyXMCmawLMHPCJZl5cmJF+S1L01xWNOPnBcYh+YKUpwPSKjX4Vj8OyHh2+EQahoHwmajQmmuyxDJ7jICA+R827ngDhLaIuuKR36E+Pn8uz8nNWiKMzwc8Q2uXi8JGA5iWxwWJnlzXN5S6n/Fsq426B1r9cwE8iNbk5qI7NH+5a+EkWjMAyjLcVE/FmN44Ad8AmkDzx+F2ns7RHE5jKjCHznIgrc6YgoiMRSV/eEdFU17DqAdWEZN5MmXLC2XtDGkMSdFLX/I9m+hcTp0eNKx6AdPNfC/Q8Jy0pdJw60nYVNkcUvk6NKjuZ+S2N6HT9bfTaTmmDWVNJ1SwZ+KK6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BN9PR03MB6073.namprd03.prod.outlook.com (2603:10b6:408:136::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 05:02:36 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 05:02:36 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: dts: socfpga: n5x: Drop kernel node from binman
Date: Wed, 11 Mar 2026 13:02:23 +0800
Message-ID: <20260311050224.23983-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BN9PR03MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 28760115-2634-4327-e7bb-08de7f2b693a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: CjSGu8vjrUFDFCrJbEn5MhsbO1K2b7F5d+plLjlAKVfOhf6cx3U8M1o3PqDSFcojLyEdL5qQ/xe0jK2itQ/RtanDXH58xqyLxQDe3jTp4OLQYylVdrZTKM3ojZp9Cuu8TWMeKkgvUIIry9MkgOTX+o7F2GK7c2nGFoJg5GnSl7wMHqnizSDlw7+doKW1O4OHGQFvxLD7qrRZzhuuIgBlcNVB2ss04LXKYd9z2TslinVfnJ91OmDEMeVpikgnfPFpS4PR4xAUzrqcRmMQUqqdSP5gTJMJ9yBoMbWhpysgom2xzUR4sGdg9AczfFzkaTdqhYf/20Yuxc/rTYkoDXhfvDludua9Uewtuut51IJuMp6nQ0GzettzQlvirljbd0UaymlKIEvjebIsjvrfoY+MwbBB2SHtsu9ztg+pZ7HkFmkjPwvxQRPsTSKW4itAqLSVsorisl9meUHOj8qVhRZD8+1NdbzJcsYYsQ0GAGDP3O9H1tjsq9x850BSSzuU3k3VVvRv2vWjJz4Or8PKoUeLDG9fc8AcwYXeRClf8NIq5MaotwL8w1dMCjVr7ThaMl6xjuwBbkY8MXJJbj9hhQq5Vk5INOld02bRPLp2RzUpz7VRgwLJOxhCtf4psdPg1FHRsRwLvk0o9i2tLlA9zwY325i0TD8A9kR2hYKR8OEHAMgeKyc6x5i7j4OiLNkUevd4F97nRPYxnqPSrtSWM5WxwoVZUXWIbe2V6OrWmZdopsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ya98Fov/uV7leZWKfrZ5M43QoiFFRLmFmKYfEj2hFx1x9oMEuGLQX7HmalpK?=
 =?us-ascii?Q?Al8jGOCfdGNbhSYeH98t8hScTkdAV6pT4fn2Z0TDrnwKhzbwPOoERGt1Ua8u?=
 =?us-ascii?Q?GsD1e8SncDUH77NtqGgkOHRQ/uHUuJrlP4Q/qIF0xLncpPoZ+oeaL+NFjK/G?=
 =?us-ascii?Q?bn9nb2P6fGMI5+KGVh3TewmyqoH7B8X/PBpX4imNvHVTViZs9IuqKlfKfcfv?=
 =?us-ascii?Q?oszZaMNUxFZAi23TWbtkNTBMOnaFsTptkrtrnb6giAjkNliOVVFKPpp/2jJc?=
 =?us-ascii?Q?g3D+Vy73pEQi0/7HV1/r35XOjfq2lyWavucY7F0vW8JH2qyFlUgR7IHT2hkI?=
 =?us-ascii?Q?uQNUFbU4HP4fIICVyXrdIKt7gHYQAkE59l5OjolR1UGCba0Vp35+bvMUN0Ep?=
 =?us-ascii?Q?LNSu++1V44JUGfvci/EIwwASVH4fdkt4Dfq05p6Rqe/m/5xFOaPpAyvyzRyq?=
 =?us-ascii?Q?f0xVz16IfgPRQKuWE4pTsxnu6l9GZNeyZFLBlIq9ivE30+E3L7l5+ksvuTLL?=
 =?us-ascii?Q?apqXiszllikfHzxCIpR18+Wmm5hGR5vLMX3fxVaZm4y/P7rDVHgYq/LE6flB?=
 =?us-ascii?Q?HfHo5O6OwSmt4gkWdmWltx90dMlztIB2anp155lKfWtYOF7n67D+Uk9TXJHo?=
 =?us-ascii?Q?6KBb6U5jSuBln9oq3B7u7WVQYFrdapqy/Lu/gOy+WTAEqDyBuF3CNb2KmDY0?=
 =?us-ascii?Q?j6WwWd+b8yT1UPkB3qWbpBQzRxT2IY3GCOxfgsdiQ2DboIXBBBhb/VKT9S7+?=
 =?us-ascii?Q?PAuyeajH/RLw5g4OuLmRbQGoHAxKBv0aM4UbMN7jvqr8xtMugxYX0fbNNljz?=
 =?us-ascii?Q?HO7N8blrX2MFKIybBkKn4f3EAzPWxeToG0TGJ5P1WnV1H8DwrNsbxr58+Smr?=
 =?us-ascii?Q?7vuK9PAT8dqdt6mtbWoyv+l07p0geN5wVGTBqGd4mT8k5T0ivxtADhF6kTKF?=
 =?us-ascii?Q?CZMNE4MrLX/CakczygZ/QP3pEa68JJFOqek1cHzOFhF4EdhildYj0xGIvHT0?=
 =?us-ascii?Q?0DCnDa67VuV95uLZIYnPLOBxXBx8qSLHc2nrmIODHmTilOBuzScptBVC99vj?=
 =?us-ascii?Q?EQbgyNaf6Xr30aiX0H5Ujccr+5feRKutkXIEBGXC+qgObH3L0QVHvp/X5P/A?=
 =?us-ascii?Q?zGFJH0frDxZKmn1pVypj3+7zSR8CY7LMI5L4/pVJ80pux7k23+GfKpUA7rNZ?=
 =?us-ascii?Q?HvZlRGG2X6TuV2T83aNlUPvAkC8l9nSclQQIHJGjjlB1At2EABt4JhR9P9Kq?=
 =?us-ascii?Q?t72ssYGG7D5klZDJSlzoz7QRo4KP/2TCeYSDRmblfmv74iiQlXioEIH0ruFt?=
 =?us-ascii?Q?OA4ueRoSB8v3xoD6mJ/KL4vHGREqmT89HPnfqRnsw92AlyI1XjmX8kUoFo0L?=
 =?us-ascii?Q?E/pVprsmltq+bhKuCIkmbmzPmNMMLr6xXQ3XwOlQpGYoYCqNm0925sZuf6Am?=
 =?us-ascii?Q?3YCBcOrCcGpS3EmXm3dPpY03b61lFA2c95j1W+7HnP2l2Jdj0jj6EyJikwqH?=
 =?us-ascii?Q?gXSHn2uGkuVhJR/WuvFDLau0WFe8/p0HTb1G17v9Y2OPR8jlEV9VEL2z/M8g?=
 =?us-ascii?Q?3aoFd6XI5BoimdSJ4n0YCftej4q2IVF+yDa54EATO+xzHJoodZUU3vhV1Q+D?=
 =?us-ascii?Q?44xfok7LzsRcMm8iH5/aiIyGQ831ibjjQDOocl8WTuP31oPvxiIGT4MtAsx2?=
 =?us-ascii?Q?4FXxiR/KNF5DR7la+DdxE/mzM+gu56naLrIehP4wJssj41lIPskb+/eYUvA5?=
 =?us-ascii?Q?6R3ktKXr3rorJOhJottFMr8HmjjEWYg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28760115-2634-4327-e7bb-08de7f2b693a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 05:02:36.2817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mv2HXleMk0koIyBSh0M6KBqYkEEUEfP7ibXjZ3gjyg6OAiOHG5MNHsVCYkNRTH0Qm9NlN0pQbOJMxZ35WPYUA1MFR3PruOs4oD8Q+FugZYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6073
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:14:28 +0100
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

Recent binman changes expect a kernel image to be present when
processing the binman description. N5X builds U-Boot without a
kernel image, so drop the kernel node from n5x.dtsi to avoid the
build dependency.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 840537c9d0b..236975692f1 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -61,3 +61,7 @@
 &watchdog0 {
 	bootph-all;
 };
+
+&binman {
+	/delete-node/ kernel;
+};
-- 
2.43.7

