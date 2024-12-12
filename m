Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8B4E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F57802BF;
	Thu, 12 Dec 2024 14:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="CpaRyrzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB648021C; Thu, 12 Dec 2024 14:37:20 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096D78021D
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNovxIrb5K2HQxEJ5AvWLhlgaNS5EfXK+A046QFBxu3puPoypfaUWec8TT3SCidCp5hyIth0m9cnSTBQXzyvXPnN3M/oE//jo7JywXXp1jFTBL4OXAO4TB3Wsh5UN5kT5ufzXA3XDKLbHEh8aIjmcm6czT/t1Iq201Al9250bffD74t0UMwCqdnAUQI5ss4BL/d9wu/iQhFsO5x4HhJcR6FlxQ7Wb2FGuA6dkcWMqZSOn3dYySZt0Z9w6CgJbHszRf1GK2RFyEBair8hFRUsu0yoGEcFWEWhmeSmvrclGCDIP+S172/tA2Sob6aalUW59EooWtbKxofzVdee8jSsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=R6ETezoU7nMLb4nkqiLrIJBkfTpKgsOtWmBbFFPVFq1RH9YXcAinPPD9ZHYGLW6o5k0ZdssR2InYtFIquKtKtCSVuOhaBtXfVUJhjhNs77It2y4d66fTnJiO7wUMnFw8uzvKN5GD3ha8D8Ev7elzb8N3q2e2JrXKr1RQTQbg3Ug8DN0OquwxEqe66TaPZkzkwD5jLj7LEr13xliwDXuk3u+JiYmFz5zEOTz4BbVTwYk2NS8Qabtb6jZTNicdZIVAQU7DrBpSpMCgAyA/EdvIlOzBjM7UT3dHZ+F8httpMjq53VauVrpV1DJZRdf0n7LiGDM8J5xWd3nYoHsdaD1JQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=CpaRyrzm+wgGvSV4SYjIv+etin1lWCmI30cZMEHX+m3hyCC+GoifAtbqL9dfH/L+XB731R0mhzf+8+G9FMZ+URk8hrQXr0dlfm/eLXpcRD230pdUVykYj/4UaCmwiYj+UGLkNG8pvGPU8YFNn4hFIIWfUXWkvNXHEGWRNYwfPW8+XyyxNoPJQ8YgtHsiJzK/oYO+urqCVHUFhMteY0Tp1528V0IXmMwdeOQMVPNMl9exx7gOUgX+t9yRlctS7FDs8DVlQtclfn0bm+42X/LIe5Eon0tC3dp/LWV8XcQNWzLWCgJlO++cWyTgn0UnC5t1kFlHOjb4L7VwV/kQUUWY8Q==
Received: from PR3P192CA0023.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::28)
 by PR0P264MB3579.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:37:13 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:56:cafe::db) by PR3P192CA0023.outlook.office365.com
 (2603:10a6:102:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Thu,
 12 Dec 2024 13:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1D4CB20116;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 1/8] tools: kwbimage.h: use linux/compiler_attributes.h
Date: Thu, 12 Dec 2024 14:37:03 +0100
Message-Id: <20241212133710.172404-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PR0P264MB3579:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d1af6540-0d7d-4a33-d2eb-08dd1ab2160a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3WOrA3OEUL6PIocpW49szMz1pgGm8S/IE6PwQyfmc0zWXkxTzUmzwGefm8H4?=
 =?us-ascii?Q?tot5gdnNH/iV3w4Jo3yE9PVrcfy+ZSlCS6QRo/uYHy7qYQDxCzCoqVpCZDIe?=
 =?us-ascii?Q?v9WBk7eqZSz98WSiupmWFDSsuJK4kinJpbRXUppxYWQ7hImGS7TzRZtoSTP9?=
 =?us-ascii?Q?k2SEpBM6YBOQ7YrzLmnuDZnWkSiw4mZw2Jnzt3hcblNhCHhcZlEzGWOL/WBB?=
 =?us-ascii?Q?4g4Y1QlUY8/CY4lHBZYkEAxq9Wke9Do+sv/zf7woE9Ih9eeOm8Xk0NO7pRwu?=
 =?us-ascii?Q?k1nmI3CdQmNH70i9EZhOT5JenXx1s02xwaKLFzVSLsWQdZ3imXUCpRglvArl?=
 =?us-ascii?Q?+TCVgxRhwl5jvLP9cjICi6amaTwXFfvGECKz3G8Tk8iG2JqLshdORkbjqzkr?=
 =?us-ascii?Q?1B7QZH16Km1e/FVTR2u4GJIfPylDXDCS1OAhaJIjD7A1iGptyJbN70KQxD0I?=
 =?us-ascii?Q?X4I6fxqBjLpj8vu6wnu/1wYDlfOK1m/gzYFUPvTb9GtGuWIumXRdGdA8XWKf?=
 =?us-ascii?Q?v4cXXBdrdOdoZUDTGFFA3NMkiln+Au1aPgeaqbGPQ2VHpv58CZH6Z3S/+Bds?=
 =?us-ascii?Q?6Gt5uNPSBDYDwEB7P3VjB9KHGHuS24mDFXgO8/rT0X32zzjhLaXdpriORn1Q?=
 =?us-ascii?Q?bj4xfJB5niG2RtXATNat7wL7fQU6iT4cSt/ePQDz6yt99ZtuDq9o67vmRhbu?=
 =?us-ascii?Q?7+gA3kE8rkWnal/Py6IpjDczirHAuMYe5RjtNXAjDGuKp7LtGmB+pi9RB88z?=
 =?us-ascii?Q?vqD/jPAZvvL8Rj7Lh2AJqOi8jJvW/0RVXYP5zwspiDi5U5+JjOvft4LvVvao?=
 =?us-ascii?Q?29ghHCBS0E2Fm+WdMRpevXIykgXEv9NRqpOHl5b6OlUflSfVdFu+gXmVO3zf?=
 =?us-ascii?Q?XjkiamuqTKpwRXKMpu9WH1hJWjjbOqTdlakKXCoAoZDUdkDyKtFvFUTdpCum?=
 =?us-ascii?Q?V8K3WswJTgT8HaHuw4Byr9O3STVyDVoXuEvjfvMtKUt4niJaZRMdj7oS5uAy?=
 =?us-ascii?Q?MMaPOQHwXpU16uJe/SktxbsfmU48M4qCWeinPIJ/TPSUMZZWL7qG9JZhgtEO?=
 =?us-ascii?Q?ufjDqkiPIHdykETaAqF/7mJYaPwo3LLf+qw6wgtsiYkZrhnR3GncSNm6xnCT?=
 =?us-ascii?Q?GFj3GJsG+YQoN0JOj2V7lnorz9SAS9jSLuk9Ilib7fTyg1aXq4Xw1clQsF6T?=
 =?us-ascii?Q?JRLoITup8HpoJJUY6hbAnpfbAiDPgngQr2MPf9YDcNY4wFVnVDb9uonj0EdN?=
 =?us-ascii?Q?f4CvkC2J4ufVcC0a12F8+RqGNq5xH5jeEkv0b9nB0BNWJLdr6AsRyd9+7NqN?=
 =?us-ascii?Q?EpaVL0KLE8ii47GxD6q75H53yqPAEfbweqkgPP8Yh1KFDUgzyUPtPi3ue9gz?=
 =?us-ascii?Q?ZoJlH5YEZMkAiNm8fJH69fIHqhdfCtRVZzNHTD2XL0Si1TzMRdRrIhyhkDcu?=
 =?us-ascii?Q?VUxT8h46X+uXlK3QunNWIjF/t0maL08x?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.2318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1af6540-0d7d-4a33-d2eb-08dd1ab2160a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3579
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

The attribute __packed was defined in the file
tools/kwbimage.h but this attribute is already
defined in linux/compiler_attributes.h. So we
include <linux/compiler_attributes.h.h> and
do not define __packed.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 tools/kwbimage.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/kwbimage.h b/tools/kwbimage.h
index 505522332bd..e1fa2e4e215 100644
--- a/tools/kwbimage.h
+++ b/tools/kwbimage.h
@@ -11,11 +11,7 @@
 #include <compiler.h>
 #include <stdint.h>
 
-#ifdef __GNUC__
-#define __packed __attribute((packed))
-#else
-#define __packed
-#endif
+#include <linux/compiler_attributes.h>
 
 #define KWBIMAGE_MAX_CONFIG	((0x1dc - 0x20)/sizeof(struct reg_config))
 #define MAX_TEMPBUF_LEN		32
-- 
2.25.1

