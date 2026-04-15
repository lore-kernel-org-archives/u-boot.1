Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B00FF43832
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C977C83B99;
	Wed, 15 Apr 2026 17:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="V5Vs3dZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB37283C2B; Wed, 15 Apr 2026 17:18:15 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF6583936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWz9+poA52TBxN5fYFoRyOrBda4btb+sbCLkgLzDcGG1a/+Ep89UHq+9Byu7IuOwqIy04Hyy2ocgNrtRVjF4tTm2omnXlHNAydEf8s6pnTXYdab0xB1o3b0Ie80DDWr7ntgclsb3sL+7/fiGgCc7fRgwbVAylGrM6CwpPMNC3BPhyTGmaB28JMTGYAcqqXpqkoUStdF9X3DKDqAqJuslamaF2eoZuz2+kEq+G8OFc6J5cOKPGaZp/harBtJJwU23PWoHhjktck/brqrvNZexbAUwTEUBqIWZrKaA54uOBAXa4RMxcnrnvywly/S8Jzfkz/LE12yDxsZSUg0S2ZIHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojdaeqwH/a1WlUSB3JfmkiRyOnbSa+w8dZ73SRAqUkA=;
 b=Y4CeG/lCkawQqOFuwqzkzjijsy3/MEaaha/OsIa0xB/PNGs7U6YMpFIhDyifFNb9IpWFJNyjj7tD5Q43Pft2CUICRktDIohC0xtaCabAzJ4AUQ3IgzecKIXZjNeLYTtyN9iIoRNFzhd/qk2piNeTTVbPaCWnSySp8zk6AgPxXfjC3TNaM0tGYlL8ZdJrXzCvLg59wKOYBStBBdVLimNg6VQRDPmeH+M3B0QK8DEC557afTh/v18jdPNKbXCb7lFU0f3Af9iXViopt+57iB9GBUxegF2KzyYw5X+J31hN2obAgj+FR1jUG+XffEkWz7NEgNIEs4UOy/Rd/+C5PqpwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojdaeqwH/a1WlUSB3JfmkiRyOnbSa+w8dZ73SRAqUkA=;
 b=V5Vs3dZBufIVIyhYXWhTfR1Hb5vsD3hd1QAkX/xgkOm3250zOEaxdCg5jx91KsQkNLJ6LEkSUPJNVKkuNGZ0wlfIOgXPcGbPeZMJ3kksuOH/J5bzNEJC6L/63hU3RBWtQIjBtWACJ4B3Bw3d40Y24DKJs06BrbFTF750yiwDp1ejjhnNJ3MiqKn0Gpi3KaHEDKyXgXBpE2Yh3NZmIAUn7zEiM4gpiRUG+2osGOsFqo9xy7FqfmQ9UkJ8iwAtPRrCBLAKlavx5curZjRR/hlFu1Eg4ojjnXQj96aHoomMyEUMNlQca9nFnOnNzsYPDJsRuIgBRktcFk2LtfTVO4pUww==
Received: from PA7P264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::6)
 by PAZP264MB2912.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 15:18:07 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348:cafe::1e) by PA7P264CA0095.outlook.office365.com
 (2603:10a6:102:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 15:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Wed, 15 Apr 2026 15:18:07 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id C255B2010C;
 Wed, 15 Apr 2026 17:18:07 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: trini@konsulko.com,
	simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH] sandbox: enable FIT_SIGNATURE
Date: Wed, 15 Apr 2026 17:17:59 +0200
Message-ID: <20260415151759.85015-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PAZP264MB2912:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2b7a9fc-7939-47a4-5da4-08de9b0232e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ocPnYb5kAig+z3+49LicEBK1AKRbYQeMIgGraFV6IOd5jHlnH4TIInh57JQiipmVV/EcrDGnGltU5jZH9eWIEjg+1RksyGG3jyey28PjvjiYE63q5mgFhPdtnmqRrfAtPpIiPLxb0m7JY7EO8wOC9kHDhTtonK76KXJFyxKhdB4K+lAvJSUqxFc8mnLxnEj8wZH90Ee3Jjx9wMlH2u4xp24r2Oj0mcqKKFcFNY2n6cErFtBJvQW19ZvOMH0X8tsRs1Xj7Gn2xQnN2kC2rKzRPQusa+UgcumZC/mdvglLMKZiI3sQRo2POrdotz8HsOR3TGvm5lH0RD7jo3M0WGi/YbslCpxs1tDQnlSuBWaIjQVRM3vQ0GZzftjWjcww8sXJbuwFGlZbqXGxIekTOMsMCof4GGSKvto8W+ZL/MPwOe+eA4iH5coHV+STAF4d5+aRjPwUq590OFriIX4LtjSIaIp2p+6d+wnXfvie1uy8QgLtUKsaMLoplQd3KkRVN5xmyjv3JkdOn8qX9gQRUbpAv7Yv96VouxYOJ02ruNUiHmC4uYdqFr2/IUCEIh2enh0499h0pQDLZOsuNggwiUIhw9t9T0R0/pzL4EmfXw6seGYx1DUBlD2qlq012ty/S4dZISFpjC9lxLgZWP0YsJqaAhct2Is83sb86+US31f7iB4NE1dfsa4uqNNvgy38DsRddJ6eOGytHhhA/mVynulUiNBrTtr4Eodp0DmnBNDrcDVttTZDZM4+QYqdybMO0vbdU+BE6sDCYiCfJkZrCU2X7w==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DzwiXWNrAYzw4cZS5V0+5kzazdBt2EdeO1ijJywdl0/vWR1aIB4+69xCqH9tPy/iJ3NB2Kp4/ip0TzF7Xt8vvB220LVEyyfWZF2oOEjMrF3zvwzlNu2H86RUmRbPe+tmEQck5mQyvBL0YyCpAEqO/BYbXeozPGaF3NK9X1Xb4lXgh9ArX38FsjN0XLRMIBUFnkndr6Fd9Vw7vJ+WfeLL5HisiI7v3O+oKk+Us/S7U1X4BA+sSAlzME0/zrZAJaq+G2u5gWBy8epER0EWC0mrwTatXH2GwAQpVPXHiiE4ZUk+flDARizfX7ZSSum/q2CfiZ3TxYDDX/pKFACZRjDtk+WiwLf6aeXETzC0IiQXXwjoGPVtQR9mO4gXAoekWFhX7vbaW9qY7qcGCVkh08aXEoodhsFuGlp8VI3Ng7aCqU7yoBNN3B0mLe3In1B8amZt
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:18:07.8605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b7a9fc-7939-47a4-5da4-08de9b0232e1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2912
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

Since commit d09256283f72 ("FIT: Image pre-load signature
support must select not depends on FIT_SIGNATURE")
FIT_SIGNATURE is disabled on sandbox. But this config
is used on many fit signature tests. So FIT_SIGNATURE should
be enabled on sandbox.

Fixes: d09256283f72 ("FIT: Image pre-load signature support must select not depends on FIT_SIGNATURE")
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index b681b91c3f9..f26295103f1 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -21,6 +21,7 @@ CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
-- 
2.43.0

