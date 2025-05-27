Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13354C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E16483865;
	Tue, 27 May 2025 15:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kJ+8G+5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEEEB83830; Tue, 27 May 2025 15:24:41 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D008309C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xk/8L1nywrFhaB9e39OIQeelGvkOfLIvKeIoqOyzbcDFJmyrQYAQj87tYlG7gOwVUOChyPc3erB10puUMJA3LEJPlS8s/kssag+iL5LOE1fVBgZaXWhZ8x7y90Nrd+tIFv87VjtSycK+Cz2HE8Ym3Vs6snOD/V4ummYC93p1dtRJuQmXTMN6Ib7XAySbTSIQctVDqn5diP0N87jfJcjFfBBHlU5Pu0HYvLhms+D0UjVaIPCrZWnvPorJiwBMCTfP2qoGAxl8iSn0dfcM7XzHnh/K19RqM7VU6qZGXFqsM7Uk2Xu81IrfmuWCd6y98VyTN4bIRnToaDZfT3jkLfB86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN7KALff6wmeVIWdK6xReD/LrjG8n4g+SyoIBfoNDjU=;
 b=Qen3ed8K9I7vs2rLEvvVHglarq2t4+37AnzfL6SaUP2hCc2ay+dZRRMDhZMj62RsQfPE3goAUS5M+dKvgEwiVDK5HgkGyXAeiLkmA7FOLFNqwHeHwvTRbomHYB/dkEGg7T5diOhkYbeMK8RzP92WLMSNosW+/pmRfSNBrIsU7dKf4GLHgIYDiWiyQIt1qMnxhqynR+J9WBdiwjzQ1pyZLdFre3x5nAnzOMMInutWSWcufPZt68kjjwgKL1/WtQcKtC19U4yrsNl68L/+6nmHk5KWUUWweSez4DE+h0ua26J93BeUl8GpisZWLvUqVxXsKaxUx+51mzJ0zWuprKCxbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN7KALff6wmeVIWdK6xReD/LrjG8n4g+SyoIBfoNDjU=;
 b=kJ+8G+5diOtOvt/kIYWrXQilsSuBP2rM17PO1Esj0CdZ5rTxsnQdfiK0teL315N3yNNIi+cC66tBc1naIAZPBhZwXySX+qZRqpiy1X+aaTIfsCnziuzBdykATzubP7q40k4as9vPJ4S3SslanENSMzJLl4gzSbo3Ui8VC2ZVEISBrVH3XkNFSBLRuVrh+XG3MAFnjQCbJqvoRCoPPKnnL322Olv6HT9Pvu4KTtlCb8attAfS985dyLsjDLDstu0n7QR39CT7HuVw4rB5sFSYVsOrRwO88p5EymusauhtFWxlKyxkM1GX/A7ryPN3By77fdKjErIdvSQ36GzflT6Otw==
Received: from PR1P264CA0021.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::8)
 by DB5P195MB2403.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:4a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 13:24:35 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::39) by PR1P264CA0021.outlook.office365.com
 (2603:10a6:102:19f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Tue,
 27 May 2025 13:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:35 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:15 +0200
Subject: [PATCH RFC v2 7/8] tools: binman: ftest: fix tests that require
 non-faked ext blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-7-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=3424;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=eGNorwv47xyYBgBgkl0ycGJouEe52B5katTZgF0daZA=;
 b=o0K/CmcELst3I7lqp+Y1WzNIg97KoqwmOUCZNMhmhee26kWV0XomgxsXxOXOSQezAEGNiyKi4
 rSzAfTjVA6OAKm00aAw+uuPvZLijiIIOhwOqlfTZx0zqlaDujlZMoMo
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DB5P195MB2403:EE_
X-MS-Office365-Filtering-Correlation-Id: 7000319a-747b-42c5-da3a-08dd9d21d302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3VISjFLT3gxYk5MZ1lhTjhRR0I1SHlkMlExeUFxNHdkMVFrMk11blpCRjNh?=
 =?utf-8?B?cVNBakVrWUxqVmdLRnlKOXFaK2ZCZUJzL0RRQlFsc3RwaVZUZ043am84UFRK?=
 =?utf-8?B?RnB1blVrdkRvbnZBRnlRSlphZHFyaXFNamRaUFpLc0hMZlNPVVQyd0d3NXJn?=
 =?utf-8?B?NVdOOElmMlUydFVEWGtqSjRCU2U1enEvREY2ZFJuQ1pWZlltcnFVVkRiaktM?=
 =?utf-8?B?Q3BPdlptQ2VaVjZXNWdVYmxvN1l3UEQrMVdMb3VycFkwd01SOWZadFhRcUFs?=
 =?utf-8?B?ZHZuU0dDM0YwenRaUXRYblNwb01tMk8yNFNRRVU3ZmV2ZC9zN3FkdHBrOVJ4?=
 =?utf-8?B?UnVDa2ZoTkxodXl6cVZVR3hkQ3diSnBJNnZJWVlNUHBUb3hxWFI5QlMxTURa?=
 =?utf-8?B?NkVHQ2MyeGFxQkpscFhqeEVDb0J3OTJ5TkRDNlBLU3hVaGtTMSttM0F3UDEv?=
 =?utf-8?B?R3JFaHFhRVVSWHM3Y3ZQc0ZYbkpVNEgvdE1qY3EzekFsM05sNHh3Tnk1QkFU?=
 =?utf-8?B?U1hZcDIwV1lNaWRZQnhtdmlySTlRRFRuTlZYaGgxUk9TTUt6L3hManpEejJN?=
 =?utf-8?B?L0lvc1h4RlRyRlBtYmJsNmpjdmRpUyt2K09YR0VMVmZJa1pqNWdZMXhHdW9z?=
 =?utf-8?B?L0t3L1BKRGtZZnpBQTVub21YOThXSmcrVVdFckUvSTFxR1pOREN2Mzc0Y1Yw?=
 =?utf-8?B?NUtOc3lvN3RQbnB0R2dVK0pMWlBjMnRpa2QzUVVxV2xqNUVvNEorOU1seUFk?=
 =?utf-8?B?ZnJielZKVlB3bklKRDZUUVNreXl3NHdZNk9KTWY4cCtRQkVXSFBjQUN6SGFp?=
 =?utf-8?B?S29VVlNMN3IxQkNaWVN5TTVocFZpeGlab0RhcE0yR1RvWTF3WTlONlRRM3or?=
 =?utf-8?B?VC83MHUwcHdndk5IL210Y2VQeUpLYjVQaDVDeE1ZSzZ5T3c2SGp0eTFXV0RF?=
 =?utf-8?B?TENjdXBhK3VKckY2eERkSWZJa3ZZeFE3RzNZNHBvRHpiT210aXc5WVhpUXFM?=
 =?utf-8?B?ejRkYUJEY0RZVmxwRWNMTnhDNTVNNzcyMnUwckczcVBIaDBJZTc4VzE0V0JO?=
 =?utf-8?B?SlMvZkFxcmdUNGYvYTVwMVlLVDVBMEFURkpXcnNpeTcwbFZVYWNwSHB2MXFx?=
 =?utf-8?B?WGFCeitVNlhIMHhyWE1ZZmJUay9WanJrSllOZnI3TGFaeWl2U1hoNlhkcm9h?=
 =?utf-8?B?K1ZxdUd0K0M5Q00vcFFMbVRFKzFXS2IzNDJGMXJuQzAzL2dFUzN2bDFjRzl3?=
 =?utf-8?B?MlFVRHBLejc3NUFiVkZieDBhY0dadXJYcS9CTUE1SHMzN1p5dzVCL2hWNjE0?=
 =?utf-8?B?RFFGeWlUeE1DcEc3emdPMzJCNGJLOHl2ZjVIRXFFbHhLd01lQWtMWUh6V01I?=
 =?utf-8?B?QlJGUStQRzREV0hDUnBHQkRSVG9Ld0R3UFF5eFAvYnhWaE00dStQRlNQRnk3?=
 =?utf-8?B?dldUNXZnemF4ZHBkTnptQmVMQURnNk1XR3pTb1dYeTJWMUhsOTMveUNpcHpl?=
 =?utf-8?B?SlM5d2R4MEp2ZXBxenp2UXpaNUdRTDB4NTVFSTdVcUVjdW9QcjJ5OEpjeDRC?=
 =?utf-8?B?aUhoQVF3andqQnVyQms5azMvd0VjUjFJOTVwOUYvN24wcSs5K0p5QmM3QmR3?=
 =?utf-8?B?bGZoMXYwUzM4Tk5kZURPaVJmYkdXZFh3WWEzbktFRFIzRlFhZkttTGU5UFJQ?=
 =?utf-8?B?YW13RUZnNFFZamhLMDhjMDgydnBnSlI4U0ZsNXNuQnNFcmIrdHN6Sk1NSGxS?=
 =?utf-8?B?eUwxS1RDTVlWUmx4QVJIV2VKYm1UMU1PbEp2OUpsS2o5MjlabWJxV0FtUVJN?=
 =?utf-8?B?MnFrRWhCVW1haXRSdnlzWW5tSkVlSzBnSjFPOEgzSGp2eGZDS3dsdlF3WVlq?=
 =?utf-8?B?bHVDa1FDV1NlcDNQRlJBTWJFWEJsTU5GUVlmaG5jazJUZElyYVlMYjdMamgy?=
 =?utf-8?B?YlZackl1b2ozblM5TVdIZXo2V0paYnhId3V1Y2k0dUNaMFJtR3gwYWdERWhm?=
 =?utf-8?B?WHZOM0xCeW1RaW41U1ZCRG0vNDJqdU4wSDBUSEJHeTljVFZIWWIvdUw0YVVa?=
 =?utf-8?Q?rzhcwF?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:35.5713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7000319a-747b-42c5-da3a-08dd9d21d302
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P195MB2403
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

By default, external blobs are faked. Some tests care only about more
basic functionality. In those cases no external blobs should be faked.
That would trigger a different (binman) case which is not in scope for
those particular tests.
Thus, disable faked blobs for those test cases.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 3fccd4c8ef5f8757b54f3b3fe5fe7898fd166dcb..d7deb3e68ce69c9c1a132f8f29cb71638646277a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5207,13 +5207,15 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtblobList(self):
         """Test an image with an external blob list"""
-        data = self._DoReadFile('215_blob_ext_list.dts')
-        self.assertEqual(REFCODE_DATA + FSP_M_DATA, data)
+        data = self._DoReadFileDtb('215_blob_ext_list.dts',
+                                   allow_fake_blobs=False)
+        self.assertEqual(REFCODE_DATA + FSP_M_DATA, data[0])
 
     def testExtblobListMissing(self):
         """Test an image with a missing external blob"""
         with self.assertRaises(ValueError) as e:
-            self._DoReadFile('216_blob_ext_list_missing.dts')
+            self._DoReadFileDtb('216_blob_ext_list_missing.dts',
+                                allow_fake_blobs=False)
         self.assertIn("Filename 'missing-file' not found in input path",
                       str(e.exception))
 
@@ -5221,7 +5223,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test an image with an missing external blob that is allowed"""
         with test_util.capture_sys_output() as (stdout, stderr):
             self._DoTestFile('216_blob_ext_list_missing.dts',
-                             allow_missing=True)
+                             allow_missing=True, allow_fake_blobs=False)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: blob-ext")
 
@@ -5758,10 +5760,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
 
     def testFitSplitElfMissing(self):
-        """Test an split-elf FIT with a missing ELF file"""
+        """Test an split-elf FIT with a missing ELF file. Don't fake the file."""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
-        out, err = self.checkFitSplitElf(allow_missing=True)
+        out, err = self.checkFitSplitElf(allow_missing=True, allow_fake_blobs=False)
         self.assertRegex(
             err,
             "Image '.*' is missing external blobs and is non-functional: .*")
@@ -6532,7 +6534,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testExtblobOptional(self):
         """Test an image with an external blob that is optional"""
         with test_util.capture_sys_output() as (stdout, stderr):
-            data = self._DoReadFile('266_blob_ext_opt.dts')
+            data = self._DoReadFileDtb('266_blob_ext_opt.dts',
+                                       allow_fake_blobs=False)[0]
+
         self.assertEqual(REFCODE_DATA, data)
         err = stderr.getvalue()
         self.assertRegex(

-- 
2.43.0

