Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C2CD54B5
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E507B86B5A;
	Tue, 19 Sep 2023 13:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mGQ3wLb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB39086B49; Tue, 19 Sep 2023 13:37:20 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD2486B40
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqMntfWEr6OeAW12lKNHwlfX78Ain6QnykPZakJtA2O9xWmd924w8lyyGmROb7hxs/9q1AD+379TSg3oBJ/Q6ZWF02f6ujRv4yeLQTOtD1Dc85MZvdNmiLUi5G7s3V5FQBMqxIxr8bNE7MeJQn/bT0Ar1lDOrXRXUm6blMMx3VNCQ29frVK37xAdzIqgapMd9TMyWrX6K4hVGTpU0R5XTDjJTa1JVpSsIb6bQIp71GJWSHRPC3QRxJrrpyvB4S10iAsSEIit6jhPQzSKWd9f0elr2cyXcxQGUj5SnmSnw3smbrDQ+7xTfDQkoiACOfwJayK+Q1v9xEknGmNMInFWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTXRnoxZFCSChqBsykR+dcg3yqTwPhHhkqakFK1nzOA=;
 b=CjimC3FkgRgYG5Us3KLhtJlMk7QqmHO0NtLzR8H5XvhevcZcGx+5TxyEjTfOfpGPdsDxJ21U8l2C4O8iFHp1Kd2B1+NVNsVOunfL+JdSM3VIAzsiLtkG8Nvvu2WNSaKsWC1d7npIKf16l6UjyoRmcGQL6Ln9H949JKY+e+1DQYJV9e0/fT7gLpa3yCUGJFbY2cNYNVaTJ4Ok5pOcVFDh5oisq0T35cWEi54Bkp3J/yXqYgwRgw9l53rA9juLXYkZXvPV1dZo+KXpptPS/zUDEpgnuuMoiQY6w3bGQI5exsf8VrLOjsi0yLNIkTUre1YYg0jMkdpupWEz3uFDYZk9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTXRnoxZFCSChqBsykR+dcg3yqTwPhHhkqakFK1nzOA=;
 b=mGQ3wLb9LqtH3g074EvaDJHPIbPxJvnBXkCc8UP+CWCmF1/c6G+zPFng+D2oTwq9JYcWFppYWppMCMv3chz+/7Kc/nitg1IxbdUAT20f602JWjrgRn+OdfVwMJ0rHsEDRj7VKNTcmaSwR43EUW6Yp0CBy03pLIvjdXlvpQ1K6X0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:37:17 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:37:17 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 3/4] tools: binman: add test case for fit, align without fit,
 external-offset
Date: Tue, 19 Sep 2023 13:37:04 +0200
Message-Id: <20230919113705.109639-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:208:be::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3683:EE_
X-MS-Office365-Filtering-Correlation-Id: 832413f2-f79a-40cd-cecd-08dbb904c6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90xm3XnOFRp4zSvel4eRa4OjrwyLr12YDwa0da+LUgBD1nDcf4fNVShX9bUrFMljyfGnY57WoaYnSwYJkQv5zuksih/90fOWF5s7fG9vx6t/BZ371GORR19ZKvZWBoAq6Yus04qbvC72qz0s1J4qgftwGBLXzyroCGMhAm7Vivo7iYWlEHElnG6/W4RjWZBnIMgW2Mvp2MRNmMG6VM4Nx6XkBXZeMm1rcEAQw05JZ2Wn3PhLLV81xQ9DC4ksxF+7Vf2NgiQWS32B50v3XqL5x5k2O1Azmpqw9WZegBf1K9zGEGAQoutYT1UnM4W1ZmDoRCX0MByErf6ZjLSe6W68KM7WqWL2IlQY6eR7t3UpKfsRqk+XOuV248cihgMBj7ks/UUqccxCd8rnyHxu35xIDymB5+BQg85onXQCuKDbwPcL1fyIBhSN9KxP984kv/6q1nx2GJ0UU173ZB551jEhkf3Amv/fcV9EOxamesBcmezyQjkEaPtRrYaAUgQvnYyVwqPEeThTiFPjJ9HQ9Tx+HMiGNiYzzpT13o8yqnyljBHGOZLgI58jkU9CguB77nfeaYIWH8Jn8Fy2/SKANImZcK6qRLYlr6HSHuMEe4Q3EMOTxqdSLcVeXXrVY784n7S3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(366004)(186009)(1800799009)(451199024)(2906002)(5660300002)(6512007)(107886003)(26005)(1076003)(2616005)(41300700001)(316002)(6916009)(66476007)(54906003)(8936002)(8676002)(66556008)(4326008)(44832011)(66946007)(6486002)(8976002)(6666004)(52116002)(478600001)(6506007)(86362001)(36756003)(38100700002)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zEmnNuHAalXFVByqnbv/aeoSkQDUbMH8RzI44ELBqcgmbQpYyeM5C+R4+SRC?=
 =?us-ascii?Q?EdWBthuZsia4PM8LVi716Uw3sIZXIwTi8W3JwFHkx6et/D9hL9YJoaRT0c5h?=
 =?us-ascii?Q?luroPtlf5QHPesPq5gmCDjLWm+tQ+EOoi7oNWN1wrB4wFChusiyshwSurF9/?=
 =?us-ascii?Q?G2Zg5Q1py0Eh9Z/gx/fSPMFciFONPWP5qIqGnDpswy/syRYXbaTTbOGVIyf6?=
 =?us-ascii?Q?NvJ5AhfjveVPaHM1qPZXCt/dX28o7sUejiORjM3xD3ILrdUPLfuTV2nOS8hB?=
 =?us-ascii?Q?IMMKx0+zWgqOrqPFW8zUz43ti4/aYqfcXnMZVvFzdKiSzgi+jhbztr16pbkQ?=
 =?us-ascii?Q?2IVYOwoyLkQAdxKx2zd+evItvY7uyqv1ovaAwHrj02aS+A8F2cfmyTEdL05G?=
 =?us-ascii?Q?XpM3HN6AfvGPvbAThKjKB7HOqYxQ8K0zD3lcW91HlyLrQZF6Z21vUAh83gG9?=
 =?us-ascii?Q?+eEh54hvHE/DbBAVBJelS8m0qAs3ptDf3keXpejcYcM12NpFsPmi25o5uj6n?=
 =?us-ascii?Q?4VZMUAEKi27Vbm3iqvMyItWVBxlg38yMEXLHf+A1oaWnXZbxVlrMmi8BSNko?=
 =?us-ascii?Q?3LsOK1uI9d3QZ43B8akVEmFEEXfDy4YCMpSbkLLx4+YfkSnX0rZRmhS0CdVF?=
 =?us-ascii?Q?SpMHDnk77EqMwdPDWpyZmvLIEns8/2aG3jKXImKICPkZrdx99pO+LkZMtxhC?=
 =?us-ascii?Q?d8rSXqg39hXNGLk1eDPIvt9gYwTJMRxW4ROKhriBbW3d0IPy++cVjqBvxXcN?=
 =?us-ascii?Q?OzyuZ66C2pavns+O0nW8fNnCEPbjaOmBgZvGKGjxaKdXFiHoOBBxzLL/EGge?=
 =?us-ascii?Q?HiPth9lIZKC1o3tebZUETi7oul027hxa1P9S3Z3HVDcKFW1t/6tYABFyOWsT?=
 =?us-ascii?Q?ZRVHcjc7+mMs1zrXdG6XGEHsqpvRnVapvL9palDRhF67uyGCXxBx3Ojuvm4Y?=
 =?us-ascii?Q?bId4vRqOqvMcecbzUqLaDNrWYj6k+BXlZOIYttPYLqUq1eMSy2EH/NVfXbvZ?=
 =?us-ascii?Q?wUnB2xAn8xhX5/qQcy7FhlAXlgFiMvC90ROiRUj+UoTTAUsDKnevGKfst5Tj?=
 =?us-ascii?Q?NOm5fJFBYoGOkzfAfRncmi403c1OLFlhuCIS1CsxIRcPPw85UJLMflf7Asn4?=
 =?us-ascii?Q?K5jDIZV5BM3DoIJoWLO7eKgCeikJVP9gT7SBhjd2u6TiYGCkNuN+bpKQ1gSj?=
 =?us-ascii?Q?yvITLnfijhVQPjElz1yGUnbVKpv7d2uEYjoQXP6hF/JaNuuKzztmQxzP5w49?=
 =?us-ascii?Q?EkrMAIKjk4x9a2hwfMcYRXWL9WCcknx9TwsqXLWg5yDwz+bMuCwFziQRnk3Z?=
 =?us-ascii?Q?Tj+GarEMDkKkblqhW0w66z7O+RgJSAcTUFdwsi7w5ih29MLD7ky1Lz0Mptnz?=
 =?us-ascii?Q?Eh68zMnoqXe/5alQKJggba3HIv+H6BA2arvOJ4rW9SnI/JlHWr2ZKolJDB46?=
 =?us-ascii?Q?AuF3ro7sbEy5ZRdb9sLx2ub9R0dpmN4KXcMyGCUg//bNMaBKG4ceYLnhBm1Z?=
 =?us-ascii?Q?rsVVd+UtKFtzGUbwppWM7JrYrZPnp/mtWdeV8Q/7JpSd4UowC5bRo3AxFyDQ?=
 =?us-ascii?Q?5Vjhw+xfb/h+JfbxLw6rSWO1nM0IDH3/BN7+sSJ5xppbv66JePoHHjjccGel?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 832413f2-f79a-40cd-cecd-08dbb904c6a4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:37:16.7913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dePPtJUF6iKRE412ITmQn7dGqhb0uzMO6OrnIaZaKsrm1JnY9Bww5GHjxvGaQwCG5paPfi20nH26BbwcWDrM85jPVepGOewYeX3uM4xfBHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3683
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

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 tools/binman/ftest.py               | 10 +++++
 tools/binman/test/311_fit_align.dts | 58 +++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tools/binman/test/311_fit_align.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d26e7511f7..a3c465b3d3 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7216,5 +7216,15 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertRegex(err,
                          "Image 'image'.*missing bintools.*: bootgen")
 
+    def testFitAlign(self):
+        """Test a FIT image with a fit,align property"""
+        data = self._DoReadFile('311_fit_align.dts')
+        self.assertEqual(2048, len(data))
+
+        dtb = fdt.Fdt.FromData(data)
+        dtb.Scan()
+
+        self.assertEqual(2048, dtb._fdt_obj.totalsize())
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/311_fit_align.dts b/tools/binman/test/311_fit_align.dts
new file mode 100644
index 0000000000..4a9b95b8df
--- /dev/null
+++ b/tools/binman/test/311_fit_align.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		fit {
+			description = "test desc";
+			#address-cells = <1>;
+			fit,align = <2048>;
+
+			images {
+				u-boot {
+					description = "test u-boot";
+					type = "standalone";
+					arch = "arm64";
+					os = "u-boot";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+
+					u-boot-nodtb {
+					};
+				};
+
+				fdt-1 {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+
+					u-boot-dtb {
+					};
+				};
+
+				fdt-2 {
+					description = "test fdt";
+					type = "flat_dt";
+					compression = "none";
+
+					u-boot-dtb {
+					};
+				};
+			};
+
+			configurations {
+				default = "config-1";
+				config-1 {
+					description = "test config";
+					fdt = "fdt-1";
+					firmware = "u-boot";
+				};
+			};
+		};
+	};
+};
-- 
2.37.2

