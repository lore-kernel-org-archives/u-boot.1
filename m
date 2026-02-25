Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9A2F5545C
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 05:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB99183E62;
	Wed, 25 Feb 2026 06:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rRd3zvBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B681083DCB; Wed, 25 Feb 2026 05:43:18 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C3F83C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 05:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2gHTPl9F7d54ZsFGADkj3uSxiNyvZv2f+VdqUpeRk7qJSFYAEQdzzxxbxembZ/TIpasLzq+RsVRPqFbox7vt7NLzBzc3liC2efTF5+ZW1tgKKcv+C1VvroV4GepBqLJ+J0OAHyNHRGood/pp4aTlKLeRe9lMTp5D8TlDklIO0Yai17jnj/zTAkdTMRY+tqbQ2xhw3FMquKccC3zOgA3pKlfrb5WK7SNy2pxJMhHfIk+PdgYKDobDlzeZj4UtO72tAzyVS+msDmzWEWn55B1vD0x9y28MchIoQqYxhl2O6/lVMFVM+MTrrfrlwpQcySoxHrpL0zDexcgzRobHeLkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lSV43aHvSpXH5kYrf6gG9nsxf9agH4hpA1ztjEhgEE=;
 b=fwunbUCyRK5BOyoGG/N2ehFwoRMJtzcGhah/kOtkHCGYnN6bsbD3lfhDpUovCCaf2C8uKZ+NLOm1saWwgv3eloQqSTnXPpQWn/VV2k/VG0/q4llXPioLLRTcJbaVIJpM8r8Ia+1MdcD5JNYMzIa8LiTXZJGjaunvVmb/Bfd1p50jxDB9oWXn5NSe2sCn+xeHIMoq9yDzY76EcDiG3W4tV3BgLhwE+xrygbWKL2WWWdE/HZ4XcmLden2sBvq0rVKc9PKvL7xn1rpiH9xgFBaSkD0oDU59Nd3pI41iE1qpL+/7F+e+l8F3qd3GDQIEetNFKjNHD8ZZIubLf3Y0Q+VArA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lSV43aHvSpXH5kYrf6gG9nsxf9agH4hpA1ztjEhgEE=;
 b=rRd3zvBgIEIqWF7yU/bFLv86Bb3F7MvMaSHGEYU8Sb0Na9TGdAFVjH7pIPkmiew3hgIZ6GiAHNWzMxlNZzeFlxSaa47haHui8BfOszXz7Dz+OpLtoC9TAJqOrc2OwmhbmOVx8zwd6be4sdBvLpOmkfheHdg4agvXMxEN+FNFOt8vpiPOYq07OiLjFBcHPzt5ROLiU0g4uGbb+0/4xacjCPlMsfLiBChhmSL9i4vCW59KSd8Clp1gSXdVjw0pIzeSgfZTC4FUpV0X0cWvJdAxhQrA/VxsCSpbvORcff1PteW3868MdjYrKQefESncnvVplxx27C+PXOxzEqdS7pmcUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH0PR03MB6194.namprd03.prod.outlook.com (2603:10b6:610:d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 04:43:12 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 04:43:12 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>
Subject: [PATCH] drivers: fpga: arria10: Clean up dead code
Date: Wed, 25 Feb 2026 12:42:57 +0800
Message-ID: <20260225044257.31225-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH0PR03MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7aeffb-cb9c-4684-a4ef-08de742861ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/yu1bmbWVKhngbEESRqjOMflJg5m86YVlbENzV2VC0ymuG+sH1YA8qsO2zLq?=
 =?us-ascii?Q?G61dDocLOZPzLVT/7xZ+2X4i6VVkAWvd4MUSUykbkP4d2Nr6mfvXJgyHPv6n?=
 =?us-ascii?Q?WUbXtGcyOIYVOwT/cO7Medb2gmv6ArbZjs447ZF/L7Bk/yWN8tBV568O6/KS?=
 =?us-ascii?Q?muZOmpnX+u1nPjtXhscHY4hvZlFiT42xT6tMPR1iNhVxKPbgTOV21EsCRHQk?=
 =?us-ascii?Q?Feu+fgpFSs2R83LAM6D/jkjkrjGmsNDorFJJnsj7Wt9Wc2aH2P6M+UXeLUSe?=
 =?us-ascii?Q?2/aXEMs5G9OFVgUHh2ZyOqjDgisZJH3zaKoMfZPWDEZ6juM2XadJ3XzWAGQN?=
 =?us-ascii?Q?VVRSSh3e71SEuqvSQ5DYqG9+RWK9tl0UBdt05EBarjDOB96eYpPgkH7KwzCy?=
 =?us-ascii?Q?TOcVGroHwvz10vG0/4h8YVWf0wR4zlp0O2EgC/3COq+l2+dcxCC3jaiVqE9Q?=
 =?us-ascii?Q?PlAJTakwibN8cH3Z7EdFF4b0dfdzpuPNAsaq/lJMjhGqrVR1+lQdMEgxGi0c?=
 =?us-ascii?Q?ixKsHuHmfGTnNoeFS0Os73ie6Nk1NoALPND84styLREeNYf+NBNAlHA7oUV/?=
 =?us-ascii?Q?yn3CYQlRw8OB//cAqaX7hJ2pJzXhxxTXERXI3DP3Tozk9GZwYbwR7AWYQ7Mk?=
 =?us-ascii?Q?NR04XaQYso2lp+iHzuR8N2mOf5E+t98E5s6J6/8ceZShnjhnQZI3Ke6IMmzu?=
 =?us-ascii?Q?y2rKHbU2s64spW/TtZAWIuLUYFlGq+pCPlJWrJU1zN7kDb6zAQDDhjianBLf?=
 =?us-ascii?Q?5WZIp0n9NE/+kF2pUDRctVD2WgyIWbnGTt6mt6JxcThKqGg2CKQZaMSdPELK?=
 =?us-ascii?Q?uZbfi4vEh/W44rC4ML74Sui/CzVL6oJwSWYFQcKjDLbwd7/7TVAaA9XAeHDg?=
 =?us-ascii?Q?2ovZt9oXEl0W5q8Dr08GQHkX1plcmj3m3YeD/9CsRRPGmS2I4pguIIE+tzLV?=
 =?us-ascii?Q?ROOfiQUnvXvzUYTISLxODnSGRtrrCrTn2YtdieqMGWTdDdImLg19VlENT2+N?=
 =?us-ascii?Q?YEyFDhay7YjFZ5UKZnX2FqveRM/rUhmjSJ7ftxpByAzSp41385kBjAHrqa4K?=
 =?us-ascii?Q?r7eU5mjRzG1NL8Xn+Gl9JIZF6/7MDTGjEGYA3RmSb9Wa7ycz5/1IQD70YhHb?=
 =?us-ascii?Q?A4p9xmsTCwwyROvXQvx/wJc88VRYAZ3rdYW5g6IkSfjjRVBDDtc+a8Wapbu0?=
 =?us-ascii?Q?40CYgEun2NUiKIufcV7cCOb0bxmhiV0SQnxtT+kdcgyW4FULqbrCGnkCAvlt?=
 =?us-ascii?Q?GJfMXk3Obvd3SiPieQqM7LXKtOfZ5ke1B+VPHHcGgjht2NKjaccUqL8REsUG?=
 =?us-ascii?Q?cHU6LrY/FuQr0h94nKLplXi3nKbsBJnXPYcZOITm9i2Ucc1fGIOtP8pX0Buc?=
 =?us-ascii?Q?HuJ0OaePND5hJmY5TecnGX4oqEUVyvWZh7+UQDeKdvUynp8pssKPotA4EBgY?=
 =?us-ascii?Q?o3r8iFw2bdX1Dg1nGSUvxgZxJIdvRrwHWAP+Xdi8wLaAhjl5VNXLYAaGfRqz?=
 =?us-ascii?Q?gE43mpryCGz+E8cK8VQKPkFm5AxHwXB+uVKvPR1mUF1+EeGXBAUrznAHQdcu?=
 =?us-ascii?Q?XI2l1wC/TuKH/skRo+8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bFZH00Y9E4VO5bp3m2FhoIu28WYSIvc18yLDHvJaIjkSfFCaD4/BAyQSQfFJ?=
 =?us-ascii?Q?JRS7/upiXxkbqBtNIYeXlExRdu64PQOB85ZkFfVNrM0GU9pxb1kbxmAoFJXb?=
 =?us-ascii?Q?1/TayMofqh8T3u5Xo/4bvM1NLrbDnUGh7YbacIUtpLBg7KKjA1nfkdmp7bsF?=
 =?us-ascii?Q?AeT4m75hG1QkNdrEBDFCJhPBpa1oa7VuAoZy1WwUDZ3gUgwmxCTjSOTHoT0r?=
 =?us-ascii?Q?CBNQkKJgju9dPQOAJXVo/VUEc1UPlqUNKY8zhiKj5oKfQ9/YmQNR+bxAyoO/?=
 =?us-ascii?Q?GTQk/AiJpu8adgB/db+xy3bGfovKbYMXBgvvFrlNMhDgEkDnCriGi7M1/w1Z?=
 =?us-ascii?Q?wzGptHdHilEW1BpHKIoKWni/umDuKmR/nbWF39KmYtodOyHRwiNklR6ps4/Z?=
 =?us-ascii?Q?zSrc1eLA/RZohR3NG205DV85YYbo0XjhgXcfWEcl+3SjJnRwJgiWf6GWiiTC?=
 =?us-ascii?Q?TgFLXQWVbjp2r5rqBdIKz0gE2q4MOTUz7YFD/44aEEVIGNGmKVDtfzyaPoxb?=
 =?us-ascii?Q?Xc8yFgY6PG2QSXHXMuQW2Pe2oKLhfjtnup9rbieWaVelu2zH5y0gLlVKgUrm?=
 =?us-ascii?Q?9XtdebopzgBGHooa5N2Tx//y8wozTwo7V80Q1aBGL3aEs+0JxRx5+TssS+Us?=
 =?us-ascii?Q?TUoC8juuQ2Up/7KBPkBCMDI0SR5t6icM0oNjMW45jRxsAjFTWw96jKzKIrZm?=
 =?us-ascii?Q?YJqzXGlF1FKYBUru/VMFkxpTkC/HhOn0so8QvwuWizTr0aRZD7LaHqmSIK0v?=
 =?us-ascii?Q?eXzWhq5cDkP1wN8TyYN8NQlcReoRgppuAmYXdejEmdrK4HK+7uOng1BE79Su?=
 =?us-ascii?Q?1pKQIj0rhTjUTPq1zlwQMzgmzSRxeupiI9cr+ojKHyKzpMAN7RzMskviyWxg?=
 =?us-ascii?Q?/WGY2/29Z99tAwjHOSDnWmw5o7E1HunkGJQ+SDCHQLdOLAZ7hj/1+nvpHMm8?=
 =?us-ascii?Q?G5KpJNhUTR84l2F0gqB6lUtB0qIC+KFP8pRYt26c/tAtAvd8/Hv/rrBH/DNI?=
 =?us-ascii?Q?rJTUaqvPjg4F5T4lmE1UNvkHJSuDj2oJUMVbcZUB5h+dVeNlG6QUOgtf2EiS?=
 =?us-ascii?Q?oYLgujI1pf/FDT9g/uU8yCr0p2uMf9RD+Dg4gAhOWs2Y8zu0dx/lzTpKea5P?=
 =?us-ascii?Q?U2HmnB4cttyW3o3l2qN2wKeiSSaLWiD17bG4WvcPabWNC4elsuV+SrbvrMRC?=
 =?us-ascii?Q?atPmY4vr+1w4RQOuVKzoJknL9c3Ud46a1ye1RXA/itrjKB6oq1nDBJSO38Y0?=
 =?us-ascii?Q?usNu3+lpGvcX+MsWnYrVlWc+qUGestVLgOCo5Q4HMesZiv2KOWaZUZoRplHE?=
 =?us-ascii?Q?diMQixKd5M9tgz4W1edKYgldIDtGmKkbGJ4cjCrHrN4wCPh6QB3cW4GnCYHn?=
 =?us-ascii?Q?Z7n9Sg2H57Ryw6/SORyaXJKd9i2EX4ncTgdSLadDyqrBaw7Q36kEVLZWxwer?=
 =?us-ascii?Q?ZEWHAyh4bRbQjVP7cOZCbH8+jH/SoadNzGx6/SWcrytLwoLrdlkUrC/9w0LK?=
 =?us-ascii?Q?FJ2+gT1slgSvVD18uSI/94N5QzbstiBp5Uxo5NQTmtbES7h7USJHQiwFQt8K?=
 =?us-ascii?Q?orY5/aWgdTzgeGztnU9B2nyV6QTKUjlbR0OK6at7WJIUDG0hOXyBk3Y/i+wW?=
 =?us-ascii?Q?EyQra3NE3DXJAuzRO5rEK8QUxkts3fyFl+hWPUJaGzFobbcBPA9s4UX1nqgA?=
 =?us-ascii?Q?NbsaCa0s/R6PPLr/y5S+bmBzKEXioXPme/uMlY6LvYKRX9S8TfiENI6OGy4Y?=
 =?us-ascii?Q?B4mIYjiAZLfrirDkyjIpOYPwh3YunH0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7aeffb-cb9c-4684-a4ef-08de742861ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 04:43:12.7113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU5KpiGLqk3yNb3hKnkHuQS2/VcbucrGILugb8DQsCck+bQxpg+RKifReC35iNcafIjPf0uNlrHEZQV4ep3brnpOqIUmkTag6ZZfAffwD6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6194
X-Mailman-Approved-At: Wed, 25 Feb 2026 06:24:43 +0100
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

Remove the dead schedule() code.

Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/fpga/socfpga_arria10.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index e9822b2bb0e..b85cc3e076d 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -532,8 +532,6 @@ static void get_rbf_image_info(struct rbf_info *rbf, u16 *buffer)
 
 		rbf->section = unknown;
 		break;
-
-		schedule();
 	}
 }
 
-- 
2.43.7

