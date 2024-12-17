Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C70E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0E280269;
	Tue, 17 Dec 2024 09:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="H1nsQY18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB77F80245; Tue, 17 Dec 2024 09:32:25 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE5680243
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xME0MHT5FZvi1XVmtVX+yJNMA94/J2j3M6XG+mOWcVhD1IC8l02iVW1haawylkl5DysmknOUa2R/mWHz9skqpo3bbOu82qAwJgBtOjZ1lbwQumB2TrtK70xtIY6aLCqmoNfbbjCTQfmn5Co0ItpHfHs1F/2fnx4dZA89FaM64uoZ8T1i+89ZL8/MEPqXtxc1O/SesQOKD/BNn1a+x7Qw7MzPrTFTwzDZ6eFPcxq1pQ3NkGAODdN24f88ni49YJZNcIaZ5/JM23nAcfruIPgwGtU0sm/WZ0LFlTRscxyy5XFevVWzfycev9scwZSlzl+kjBEh9KvWfgxN1eBK9xzVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=ZVKqjCyybcfp6iMDUspFv877WklL/lx9H1YnbWFwBN4X50577+sWChAHc+jIQCzHlpza1iRldnf/+a330Ijq/xThxM2CBbYDVXtTzSRr2+ofBEtYql9vM4Tll1UTiqAysEo6/y1yJ/95zbvlXmjjycraeRwV1TIofRBlhVB2sFNiPcJZWCQ7cHXwEwCehMHRGvE7cnPYS9NlTbDJY5cWVD7o6ibk0LCL6518dZuyIbViwkAWNfzIWS8mM/7hAHA+kenRxZaSYKNlKz7G2WRXTUXxlgQHKVwz31Yh0cTV1cburpGjZHoQMn5R2ikqSMjPh8C3bc1CqYP2Mhs49tLj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QCYaJre4Bf0xil4bx+pFmzWDqIHT3v9iBPqzYc3iSU=;
 b=H1nsQY18py8Ybci3kogO/5oWMqH5f+oMUzbGWeecO197Cfucw+YvsgUtVTnoWWQphkpdHCLZ7634ZFJuP2u/6l+PxG8PqKGKSuHHJsx6XD6vl+lmiCtqcKlr54DZ5JLGAnZfjeBn+ndtqFrTAiFW4qxuGhQp4hauWDtrLmOTnYVrfM5iILd2iOLFF9L4vEPErzrMOCtuJgdvo5gQ3MAVI2LfhSEXy978u8mncm7o+W1oZlwLfaa0z1kosaZib5cAvZv8AECwlI1HvZB2od3FGiw+NLlhz1eaSHYbZ1xdZmV3QuuoTZHMBc4Dz3dgeZnfRcDxCQCUf83MHhcpok0ErQ==
Received: from PAZP264CA0180.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::19)
 by MR1P264MB2195.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:236:cafe::49) by PAZP264CA0180.outlook.office365.com
 (2603:10a6:102:236::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 08:32:17 +0000
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
 via Frontend Transport; Tue, 17 Dec 2024 08:32:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9617920229;
 Tue, 17 Dec 2024 09:32:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 1/9] tools: kwbimage.h: use linux/compiler_attributes.h
Date: Tue, 17 Dec 2024 09:32:04 +0100
Message-Id: <20241217083212.70330-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MR1P264MB2195:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d399a68c-fb80-4ed9-e7ae-08dd1e75508c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pZS144KP4Lu1G67oPc7083x8xS3OSx4dJgoWj9eqeR52IzKjjaPcP3h7eFgi?=
 =?us-ascii?Q?3g7MIXOsCb/cItsNFKQxCg8uONg0xBIQJQapzJ6XyZMrCEr/vhmSe/EA7QTC?=
 =?us-ascii?Q?EzvozcI1NXRTZ0lWBWeWD9wJr9gGR13hWTmn+/dEFRaZ63I5cOMMxYpqijUe?=
 =?us-ascii?Q?Jwh7XVEfL1nERAPGZgmKTz3qEQYAuMkA86BY7YOzeYcBikV93alGvmt+sMSs?=
 =?us-ascii?Q?UfqL4S1XUXmBau3LHNt/EQ8PLmFzkGQ6mszIQmM3xctEQvDo+y9qeVXAy+8V?=
 =?us-ascii?Q?+Q+RJjE4oYKpfb83cLrlukAmJzjH7L1IIm6UdIIHHN6NAOEpZ8B7cMvvmAHY?=
 =?us-ascii?Q?hdOn/pA8jHjuitT6GG3jn4GHEOtlKTl2ra5pHRJU5x/Zz7NqYgeDB07fDFfB?=
 =?us-ascii?Q?8ftxyjR9a2uHaFF5Do7bWsAH4wbyXcgQ8iJIR7uVw30QkoHi6sqLXCC7uJXL?=
 =?us-ascii?Q?XsUNeCxikxQC0nHjERprSXHvOUz8XGAoxMhlaMbVHABRzCIwEEqxv30DMf49?=
 =?us-ascii?Q?EEVQ4STDfXZFB9xX1jl6+sf1M1McYWBmmUse6C6PNXKkDAyM156bhu609768?=
 =?us-ascii?Q?i/KqBe56tT9Ldf8PTH8Wc6uQ6VjYwW5VNmVY4UJCXbz8wMXqnx9q1um9VcDe?=
 =?us-ascii?Q?lVsS1JuCiHzMWg5coJE8rDVGAkAq1Q6BSgNMfKJI+rL8CXXdljz4RdYwP9uK?=
 =?us-ascii?Q?3xOCfdWf0mQZxU6q5VYpw1o2NqmEwY9QBZs+9VdmpCzhmddN+HS19RnaNun+?=
 =?us-ascii?Q?iasG3p5hXCVlza70pQ4R/Ex3MaH83Fsb+36zJqA7ggnWQxSWom0oJel9n5o1?=
 =?us-ascii?Q?I+hqi7p0r8ulmb5+2iNE5Uy/Fw7zPKBNUxxSCJ7H4p1zJXwv0dT+skxEEktn?=
 =?us-ascii?Q?zabGclfmdWVKxRlriJC6UKLgNwiek43APOwz3QnUDKYFVvPMDLLkcXZQI8QL?=
 =?us-ascii?Q?UD1F2XtUU0obdhoPTW4f1EAULZZlAnSJgn2RYNsjj7/K3Kq9pqQP4XTt8WTu?=
 =?us-ascii?Q?Ilo54xCEl/uACfoyJop5sgnrmDeGAfN2blXvvNUf0MgrLVDIhaMTVhvppM5Z?=
 =?us-ascii?Q?COdVUIX4u9zLpinJyaHjuc4HcX7YGm8DhcTgb6kTp44ekktUXLWgMlEseOcy?=
 =?us-ascii?Q?asRtjbmdZ08z+6/zz0DpThf1CpMKsx2o20doLbqYtmBSeMyG1NXIo6DwRbdc?=
 =?us-ascii?Q?nWd8aYv4lKjnDWNmGeP1QErndL1gKbRU5C3/zcezcSrclQBgZGNcTqbKFRUP?=
 =?us-ascii?Q?X9nqIEYZ5toKvuX0ncSeFdT0JemsvA8P8b2LjXvTRJ3mMrZej/Sn7trTtK5s?=
 =?us-ascii?Q?mJkDXm0YUedeOeGVCGj9iF1Qc3BlTG4NWxW0pr/Jykkl+VTCFsX2PfdIEZN+?=
 =?us-ascii?Q?6CwJnCumnmycVjk7iOngIqMvOYcxnZby1kNIACPUUjouXEr9rVScWhg8vR+i?=
 =?us-ascii?Q?EXBwi3ypnaz1vNUrFvYLI9eYfpaz1lPCmPppaL2+wrnvJg2+EywC4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:16.7428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d399a68c-fb80-4ed9-e7ae-08dd1e75508c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2195
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

