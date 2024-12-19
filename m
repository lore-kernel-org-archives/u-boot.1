Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5631FE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1668033A;
	Thu, 19 Dec 2024 14:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pI5I7vIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E27180326; Thu, 19 Dec 2024 14:06:00 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3752F8021A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/v6vR+iwDspuvFHve8QUk4h/Vvb5udfOliq0hAQSq2qMK84gsXUR/q7RoxHco+4wHyeIkkcSiPaHdaW31cv8xzBg+MvOF5gTpHwZEuJkekL2zljNR8LNcX21w1c0XDc3n0qXdQta6RmoY3zgdlrVDoE93mpl8rwPHlWhBCESv01c4Y+2oPi755ig//UUKa+cPpOwV4sL5rmx6Yt3n2LOPAy2aqDkrXzuHsXuVobUYnRv2kzjPN/l2fFFTIUKUXTqkYN13nyNqp/MW/+RKUm7mkeKBKMjnrHBLRwUV+ONZ7gYd0XxiDSCxeQJ2xQXSClRvZq4SQbAxGS1X8XQU6pNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=plc8I1MVhcd/EsjhEr4r2hJzZQWtitJ44d1KApCz9Bw6Ih/XLrQErEuwADbwu4mRYAkT62XR4G3nvqdC7WOUqLk4EFfeFAk+pWv4U3nlS7IPSSBUeWK9mMoEXDrfmQ8EJdxp1L8ykfqRET2EKOe0xwyIKLF9eNLX/ed3DWiPjku80XGkxkIW+diLSY4x3+Mf9bnhJomeyhpxiqO38hjYiOzinIRw/wVZ+/j0sBs49fHTX+s1z5qCzXDbTZNRD83spqNvOkZ1pbD+quJ3Yyqbn7DpztPwVVIFY5nJcWt8oIAze3xgPlMYh9H6vNsN1ITon/rnPybWV4oyVLbwMuK9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=pI5I7vIeBvWZ026Oa2NP4poUiMrpVvPOLDwRh7qy+YpZUIpznS9w8ahBhzDB1aC4VUMqm0APxPjJQLZiwcj3zWohmCgPYv/+EntjxPT2ObFWuaJsKVS3aRq785g/EhMeMfTZrX5JAwfmOSBq/XEEq15GonZNIot0OLK9szX6JI+At9CEQI2QRxqAp6UB2aGV/EJEuCm6nd34WpYRUTPOmeVtmnSTGZXgM9Qu5HXh/wb2CrZvVJlP//+RO4zQ7bC+C50e00sD6M+7OiEfUdaSq3V03cn1G07Cr2kEXLNG9BAfjGEVuDxUrp7z4NHeGvpNi/zpCOPiqWRcQa2aq5CwMA==
Received: from GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::22)
 by PR0P264MB2343.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 13:05:56 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:20:cafe::88) by GVAP278CA0012.outlook.office365.com
 (2603:10a6:710:20::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 13:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 50AF3201A2;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 1/9] tools: kwbimage.h: use linux/compiler_attributes.h
Date: Thu, 19 Dec 2024 14:05:46 +0100
Message-Id: <20241219130554.49825-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PR0P264MB2343:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2a296f5-1a1f-4026-747e-08dd202de04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uy6npd4YtByTd5LUEaxpJdabs5YSq9Xz6jSukYICKv1uycuBBPaVSsPOrL3M?=
 =?us-ascii?Q?bF31CPAA9UGD1tVoxcmLDOCuCIaT+Mvfpp9lOn+cztnTExJjhUgWYj3bzf6H?=
 =?us-ascii?Q?80usg5VYtskeZ548PsNIwp4T0+HXiYI6CjDENuoEvRqF/VepIuskle5nZlOj?=
 =?us-ascii?Q?z/KALfCN22Y7bU57k7USx1oR9V1YDvNX66yRtxU1ietrQYZRd55+NsQUnnjq?=
 =?us-ascii?Q?4P0ItRDW7Gwdmd74PSfeVU98IzLvrdGkeGuysMIEPIGVg8KOQYcvnDo7E2ig?=
 =?us-ascii?Q?iPkiAkSEt40+2VqO0mnL9PoJKWRcvNkc/bxGRMnvnQfl9wOdmmTrhPnsdCuE?=
 =?us-ascii?Q?JYpZw/IperRPwvcWTwL6KlfdRAtgUVvc17DVsmaE7iu2frvg4TtLoRggjNeS?=
 =?us-ascii?Q?IL/O+f3jaIFNARR23aT6dujmYl74ZJ1jsZnYUftQiPI9S9VtE9EaYJsGJqIk?=
 =?us-ascii?Q?TvOUVWP86So7Elbl9+FefqFyE/x+rzhXwAODbPYkh9cZVsiayi0MqXUGLG4N?=
 =?us-ascii?Q?ATnxthbAXY98FN3uwqIA7Ew0vlEYQgn3KzXHG4Wq9/QzLs15gLIhw7sIwuJN?=
 =?us-ascii?Q?tv4IJ7Ol6sAdOvM2JEC4ZcRrOgjq0TcuNYW6EC6b9Q4rijHwhJUl7c4h1GcG?=
 =?us-ascii?Q?4T9FT4djlKtvSFXPWWWsTWf1unuV5cAprjHFKHWDL4D9sqlGe0KTQ/FvJwR1?=
 =?us-ascii?Q?OPidicHLSb0eRzQUDW2uZSBKExh/wq9K0XTR2qB5C+FfvGHCnDsrvAbrE2YZ?=
 =?us-ascii?Q?DXhAoSa3VfNpEGkB14HJwTwNcglVrQP2IcJxW0zmRngg056Vrjjk0M+ex6VI?=
 =?us-ascii?Q?BlYMQTf6weSUkoGU1/eWnLbu+bStZXEwC8X2WL3DYwUSrl8gjISiyq4bXPA3?=
 =?us-ascii?Q?rCPupN9IS/Yo7Du3vt4YB+NTW205cZWMSFKGw9uDXfb1WbT94blBJK/ypaJR?=
 =?us-ascii?Q?lY5GZ+MK2ZYZ/eUdYgiuweF5RfklQgQ2bzu4NBcstfxTrOftP1hf27+Q1e7a?=
 =?us-ascii?Q?H96RzibPRnWrJQ1x6jA2RzkkMhcZ2teqcLCnELj2xsPz3m6ia+bc7XsBn4LI?=
 =?us-ascii?Q?B7kQVKyLCGt06untuhXJPr7LtsucwqrdEdwMvm3+F41dk5vT2dcZNOWA7HV5?=
 =?us-ascii?Q?5vrE+yny4KVFHVnGR1k4OeVtF8lG6Xr22s/uFpvv93kU5hfocEDsds4dwv/v?=
 =?us-ascii?Q?sgC6ymIZuiEQeND1oZqxokfSA7d3CBNPFpDG6Bdn9AEnmGjVJwU/ON+lmzcz?=
 =?us-ascii?Q?v8doKw52vSmU3uMvEJSOZcW8OjHcixJMHSJy3xV3WfJoczzpDTNUlAjN5tP2?=
 =?us-ascii?Q?cTIzm9p0LWWn35ppZN96TPaVOlIwzELmuIrJuXDkm/LJ07+OuFru1ly3yUfk?=
 =?us-ascii?Q?y9FWr7w9QhG+Loxgn08NelPF5laqCNWTKN09pPIC4OqFqR4DWLrzAJgDNsMP?=
 =?us-ascii?Q?uHKS2QIo1fBBASq6fL2xibZxvgZmIRVWyLQZZuo9YBxXFTDwW53phXmCiFc7?=
 =?us-ascii?Q?zDwWgLtYb4cNyXQ=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.4733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a296f5-1a1f-4026-747e-08dd202de04c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2343
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

