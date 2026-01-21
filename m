Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516D6C44522
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E63EE83A6A;
	Wed, 21 Jan 2026 13:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FnrjZ6ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD68E8341A; Wed, 21 Jan 2026 06:48:40 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C352882A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P34VOp3Liel01wAOSOoIe5WJfClyHEPIpSmrii75D6fz12V2gLk5cLqmLlyPnA8xg0Oknv3axTwte0c1OFQeA2rhrLu6BunLGbtZH7QeQDqlbCuv/CrDdcpvyMOnfW7aKY96F4nB7Vu9WHnHqfmVUD6fLLnNJQ/nVyernUe2vMU8sNWpUrBe+O6qH0vS4wNtPnDMH6/DWbw6iAphFYkhvWrBjKaTjRtB9Yq/QnFuo/xlUpO5rfbZ4h8xA7BCLkwM2eW4/lzCG1WBWQOEV76f5WzAClJQ6mbnzZJghI+qnQYOahjx76yqX91yIGhbpu/rjGHL1oNbXKQqa+2GxO+/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgF7KwOUGh4gzDwA99JvgDHlXIlhG2f9WLtb0b6gb3s=;
 b=cudFIiJg6EdbzJS1Etl53ocoQMQqtPtpNJRqiyaLWbmyRn6IKiLUnGOLgtmeLuz2X6XEnmiMyFr1JymkUymmzlV6kcFs4WIZoImSQcw2qCLXJaZagEDAgx6udJnv8+tUGSqZhifXwcaptxtq0XyFA7Sq4eBzuF85N78hmOsHDOxNIpQ1AKiJY29zpbYsXsqr0Vo6xpEwjoyVjwYPLYOohK/W3CKNU7DKF3mGMAoKUkRyc8hGq4Vzg5o8y5axpMQZKaS5bwc5hSIBQdwNCaNUPkLdfAtkf64ugwKfcdyCoTTf2bVow/sTGgyu1aiDF+J+Jdc1gBXKpIuHwXaIoyrPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgF7KwOUGh4gzDwA99JvgDHlXIlhG2f9WLtb0b6gb3s=;
 b=FnrjZ6apnmv4CmM3IU/rQsRpxfaenLCcNbWxyMOOyhS7GD/q6Y/IYmB0XkjlNtZZxjOoVxKwb1buCYlnLUCy7a+Vw0obsyNa3k+qeJJTZ7vlRNwA8XegMOu+vEJBy6VOa66d6SXDH0YR5N1AhaW6KCfS+novX6s3G81FmNumJMc=
Received: from BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15)
 by DM3PPFE51A5CB22.namprd10.prod.outlook.com (2603:10b6:f:fc00::c51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:48:36 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a6) by BY5PR17CA0002.outlook.office365.com
 (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 05:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:48:34 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:50 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:47:50 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5lnlt2327772;
 Tue, 20 Jan 2026 23:47:50 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH v2 3/5] arm: dts: k3-am62p-binman: Configure firewall for
 ATF/OPTEE
Date: Wed, 21 Jan 2026 11:17:10 +0530
Message-ID: <20260121054712.176939-4-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121054712.176939-1-s-joshi@ti.com>
References: <20260121054712.176939-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DM3PPFE51A5CB22:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a449fa-699f-4d99-a063-08de58b0b760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I/SCA9ldNTMGfiB4OwE/G1p2AVJ1M4iBX6CtmNQw7DxkLFPEwThONXCfP/pA?=
 =?us-ascii?Q?4gswKRIhpoCLTnrSgmZ1Yw3b4k+f4AuYxWtRVgUlEO3ys1hDIjxTh92kyOiE?=
 =?us-ascii?Q?hbxlnpr1UJOKZWuvgm76cZQ7YohueK9yVRlm1KHaFz971zAQJj+xbnuHVSqQ?=
 =?us-ascii?Q?un9Rd0jqUE3u/LN3z+DqjK0ETU15Z3yicHCl/AsR0TBUOXje05cNlds0WARL?=
 =?us-ascii?Q?ENbvO7eZfmKO1YLPU0AR0GB33MLD6WCjmeOExUrZG2k9K83tPFo75YGR4ENb?=
 =?us-ascii?Q?3gtQTquZuXjpsxiEbYApAFWF6cvSXASCIMjsJUlHALTw7+2HelszF1o8I0I6?=
 =?us-ascii?Q?qXw66WFhKR5PVuKLGg1xBJeVEIdGgFg/3wfhhbkKIVFXpdehedgtg3i5LurT?=
 =?us-ascii?Q?5L7Bqst3GNynPkTXVXdLBu4TjgpuI+xYs/wfqup4pUHcOZXEh84manxS3FZq?=
 =?us-ascii?Q?82j5XpIaQVCD02kJL0Ko2PM3JTg4q54ZAC5zce0gqyjcEQOcOEBpmDDGtgj8?=
 =?us-ascii?Q?3MUrjDx33NOMfG54lEUevwsA6dagVCqWTkK31eHyQVojM7suQ8ysfGWryR1G?=
 =?us-ascii?Q?Rz4C3o/4yQ/YOC0YhZgWfMLSwMdczM/2wKvAp9qAEzRiqqrgWemkUKpoV9bu?=
 =?us-ascii?Q?iWONoKbYHb7UO7DYJ08aoTtQkz9fTDTk7arfyFGFkbbp+Wr+IBtXdCVVzhD1?=
 =?us-ascii?Q?Ns9fZx9IeKhYrgT9PRvEbAdLYiznOfnNNsPImk4P/P9N+2hvoscWSJVp43MS?=
 =?us-ascii?Q?460UqpKTSpr9ZWkh0V+jPLko7rXA13UGdIKrzzQDnFv9mApmxXT2iObreRV4?=
 =?us-ascii?Q?hWkiqCIziw6jyUrmHblWBxZiFwyffASsWT6heRp1qkJcT+GgFVU/rkGBHqEk?=
 =?us-ascii?Q?t+6w6M/6/tj3f2TSoKy5w5Xkj/07PJMIRwyDUkyEuDhcFA/uxG1qAKRCRUAu?=
 =?us-ascii?Q?RmAZwO8bG1dkFaMh3zqo1KRiITT7va39izd2UuQzFBzw6BHIu2uxmf/5cRFH?=
 =?us-ascii?Q?fzO8E4fEzYDxW1RYXFp4Kfoh4d5kpwBFOo91x7IauE036DcZb+PyzIMwpaXe?=
 =?us-ascii?Q?/gkoq5IYlLl6XF7o2N6lrVIxR59RZClAP8dIlIOLQg8UOT0ceiXiGF3im1Y+?=
 =?us-ascii?Q?pCqYusZO/jAnpoyJ47zt2siOt2tUvFavYEis5OgZtX8uD1Sb6GUmKeLly9zS?=
 =?us-ascii?Q?CIeabMQqlKjTuYZhM0DluH8vA0VL8fdtuJfaz/Ygq+x+k9q3ssOqEgHMAwl5?=
 =?us-ascii?Q?+kPKY/3M60U7f2hvlV5GKI9CKLVEae1sgrh6I+Yfi6elRRDSfqmznMSQVw0Z?=
 =?us-ascii?Q?frzQJvYITUFs6gwINKw/lv9kPqrNQmHIqT8i7mgtc2mV59AUZn/Yuh6rvQbM?=
 =?us-ascii?Q?j734Xwt6kTZ1eG7RjtKntXPL6FSro5YqI9Igb0xkm33NEziDOU+6YmfktsUp?=
 =?us-ascii?Q?lc+dacN2OA2ZA3HLhfOB+vxpNxVUyIieJIawV5c2DauirC7wJ2hPlLCH7s1x?=
 =?us-ascii?Q?aPHSCjm6lQq+4eAdqNojZzvCroS95SNKtCAK/hMn7oxm4M0lAzSZ3Sqytr/S?=
 =?us-ascii?Q?JOoIEd5p38Er6Oso/pre93wkxvesEMIpyvdww97u4boWe415yu0hfnlwf70I?=
 =?us-ascii?Q?u6MhmcHWXKUzN24+3tTx2jpjIbD8h2aXCSfaTxP3BY3Kbe1ZOENvuT8r0SMw?=
 =?us-ascii?Q?Tkafng=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:48:34.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a449fa-699f-4d99-a063-08de58b0b760
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE51A5CB22
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:15:54 +0100
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure reads and writes in AM62P.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
index e1443d6226b..603487341d2 100644
--- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
@@ -217,6 +217,38 @@
 
 		fit {
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

