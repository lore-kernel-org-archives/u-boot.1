Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42F7C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CECC82CF5;
	Fri, 13 Jun 2025 14:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BlH7Ffub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBC582C84; Fri, 13 Jun 2025 14:03:26 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 571E882CBB
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=In07rATFzDK8Hr7GL801Z5I/iD5L1FYvz9a0FncuiUj/UvbHz+/YZOj2GkIU24IkslvH5R6QrhKVuhvrCgBnH2FyeIePdyKX2fAZ0VS9rJ8I9rulAEA0UTU990AdX/t5m+TLisSQoXauoBw2YyZJzGga1ADcIVALfh6pktkP7n6PkuztSk4IsjQtxIIu1T6lzJZPAmuDhMUeYKm2rO/azXix2xU2YqdCeG57SHssnotSHhwXq5SYsGHPribFKAfjquzQxBOGSgjZLZf86e3goWRH/GbGmQ7oXMZSoJpkBSEvcJH1BTnVf9kirBQg1gTXFq3QTe6iXQX/PFzmJcR4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPSVHBy9bk5vTGxdyYEdlt8LIZrUXYptD9m2jAaArB0=;
 b=oSGzQzBznsEGTVE8sv5F1LLU+RQcLzm0gr1Y6JGiufdhGzTDexaqz4ozvjT9T82IrOoELgogRR05pGSC1LEB+uGz24r/bWX4kGnDg34eWvmRg7rbmCrVR5Lt+QHOSQ32/pBGPEyqF+4lQHPP7vjnUCbAqZ7mGHAlZIXc8dqUnoZjcjh/taOMgiLr50bS2nDWim2gmRFtaT3RBdPBsMZTW9E/TRw7mlKHcc9RfwlkaL8A+Fiq/54z2SZwaGX0ms7h+qHxBKXXtyiq9HbhWGCtwvkfvmvF2h1AG+CVbSeid5xrAwhRjTPiNDAtgnhnVVMqq+woftEKenOHSzfbO1Cg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPSVHBy9bk5vTGxdyYEdlt8LIZrUXYptD9m2jAaArB0=;
 b=BlH7FfubwIlipwjQeUr6izxG4doRyvtoAxQfyJ18N/azrF5O/UUPGPh0oAUc2J9X/1TLHjMuu1dvwBPPGRc6qPEozOdAfCbakd+b8bUULTBf1QYvQOPZvV5UGvYShOZZWPGAswBFGA6qiF+FJ/PjlLXSt3UYbpoAiAl/mfykmyuEP/QgJWiXq/eYLOz4c9L6f/KZIVXmXUfkVZPZVx2yB5V/yZXRQ1kDyj260bHhxCiwP3U8PUIsnMSlz3TxOFAJxaR1QUz6pirJSL2Y4OcgkRZTFt1Kl4IvPlRizU+sY1MMx+xym62VnU8D2CCg905UiVzTYvSDXUoW90o3LKWfpA==
Received: from AM0PR06CA0142.eurprd06.prod.outlook.com (2603:10a6:208:ab::47)
 by PR3P195MB1022.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 12:03:19 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::21) by AM0PR06CA0142.outlook.office365.com
 (2603:10a6:208:ab::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Fri,
 13 Jun 2025 12:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 12:03:18 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:17 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 13 Jun 2025 14:02:42 +0200
Subject: [PATCH v3 3/6] binman: rework dropping absent entries from
 packaged image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250613-binman_faked_optional-v3-3-1e23dd7c41a2@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749816196; l=9517;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=30NcHxGk2S58y5OJy6A5SCZKhr3ADaY0x4Tksca91KQ=;
 b=Err5+eB7EKdsQ113TUdClq81PLYKFuYa/B7fec44gQZYC/lpkoZlMIA7ZuhPjt1YpHWbUDXzH
 Y4NbXS0E+kpAoXaoMWpmRo3BiBQ7EmzwfJWV4Kna4KQycHOgBETwtXd
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|PR3P195MB1022:EE_
X-MS-Office365-Filtering-Correlation-Id: ec54a686-079b-4689-a7fb-08ddaa72494c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzdSczlLdXVSd0VXN2kxa2NwK2FTbXNBRGVSbHNXdFNXN3RvNFZPMVZOZUxE?=
 =?utf-8?B?aEdWc25TY29rRHc3V01DMW9hTlltSmgyZ2Jua2dTRjd3V040My9adHZndmVW?=
 =?utf-8?B?dVJzcXlEa2d6bGdLR3JFWlRwTzlKbUpGWlJ6QmIzZEFqR1ZRdGZQOVl6STF2?=
 =?utf-8?B?N3BKalpmckQ2TmtxVnByYlh3QVB0Nk9JMnIxQkt5Z3dnUXJvWktNcVlhOUl4?=
 =?utf-8?B?eklXS0RiTnZBSmNuRi9MenNuTXJQNWFqY1FSa0pSSURldXdBN2sxcU80a2xI?=
 =?utf-8?B?UHZpSGU0R2pxRmx1aUdlK2ZqUmNMZFRCQ3ZIWUtTMDZPVTdYMld4R25naVMx?=
 =?utf-8?B?RldNTTNBclg5Nllob0FYNE1TbHpCUHZpTXdWN3FKOWczaWNvNE40dndBNXRD?=
 =?utf-8?B?dU5QRWxoalJnT00za0lEUjFBME5TdWdRWERwa05tTzFtVkliS08zT3pXeWJD?=
 =?utf-8?B?N3I4SDlRTXZsYWdZcHY5TlVSY01SWkdLTnlvc1dtRjczNEx1Tlkva2hOWWli?=
 =?utf-8?B?bHdIaTZRR2VIN1F5MjFlTmM4NTN2T2JRMnJ6RmNzN2N5WWFPSkt3S3FQQjVs?=
 =?utf-8?B?WWhFVGNyMml0YVUvbWFTL2t1c0J2VGZRV1dZSlY0YkZxMms2UFgwc1pUSWJK?=
 =?utf-8?B?QWR6d3dJaENjU0NtaFJ2OEJQMWpnZEFGM1BrSUVOZFk0YW42ODk0ejRLRVZO?=
 =?utf-8?B?b01wdm9ONVJpVVowNkUyaUhNTjdRaDlUTWFQUHRXMFVvb2FqVmZvY2JVK05v?=
 =?utf-8?B?aXlETzVIN1ZTbU8xVUE4OWFURERKZUpWaW1JMUZLUlNHQkJ0bGhiNk1UWjJK?=
 =?utf-8?B?bmgvYjMzMjBEYThyTDVtUWxBc0hwZHNodFcwQXQ2bTVpbTRPelZaTi9heHdK?=
 =?utf-8?B?NnA1RmIzL2tYQnRLYW5GVG1sdnhJTHhLdTI5UVRTQ0pmOUV4YnhLdFluUGRh?=
 =?utf-8?B?WDZRTURMRGRmaDVNL1hPUVhTT0NzRWpjRXNpU1FkSFhJL3hhV3ZjTlI4WDFZ?=
 =?utf-8?B?a3N6dG9wZlBxdnZvM3Y0ZkdlWWNBOUFrU2Y4VnVLa0R0TUc1QXR6VVpqdFVr?=
 =?utf-8?B?WUZ4NVpmWmNrVFFVNGFDVzlNd0pZbTEyZ2sxMFNoUXdWQXFwWUJ4WmdNL1Z2?=
 =?utf-8?B?OFhzNVkwZ2xjOXZmQUhZZUs5RkxlTlo1bXczYzNYOFcyVlJwZnJBRzdOb3M4?=
 =?utf-8?B?REQvbnZGdHJESXF1VmxLWTF3VklncDFFOTRvU0dYdnBUTzlua2F6aWFVZiti?=
 =?utf-8?B?MGI2YVZid3I3WHNRemJlaWNLV1RpZDlTc1gvK2E1aGFZUFRkNDhOVkczdlpo?=
 =?utf-8?B?MmlQWitKcDhCNDFmZDFyMlZHaVkxZEVKaWUxZFFIemlrVUNNYy83ZDBFbzBi?=
 =?utf-8?B?UjNNM0t0aGZkUk8wUGMxTGs1SHN3TTUzTGViMzVzSWZ3cnJlSEVZTlkzcHN5?=
 =?utf-8?B?K0FPOXZVSFRmcEd3TVFUUXZJcCtDS3JUeE9lM2RRL1JKU000UHh5QWZWejFT?=
 =?utf-8?B?azJaYmNsL1VCTWRBNUtURWI5MVJHRUtCZFZCd1hwZkhQSTJyMUdKOEhlTFFX?=
 =?utf-8?B?R0lXS3FXSHNIK3ZXQzFMb3UvS3Z3MENPcy85TzNPZG41VG1VRTQySm9mbjRW?=
 =?utf-8?B?VkhlN2dqbS8xSTZBcmxHYkk2cGgwWWJOT2t3eXJOTTNTeGFPVTIxWjR3UjZK?=
 =?utf-8?B?aXRVTVI0VmdNQ2M4dm0zUUV4VENrMzUzVkVVV3BYUEdhQkwvTU9OaHR1bFFK?=
 =?utf-8?B?VTFUU2c1UkpRRVJhMklkZXBxZkRLUVVlTGVPKzlDdU5LZXhMU1ZSNEdIdXNo?=
 =?utf-8?B?REMwYXRha293Wnd2dDBCMFFoZ3kyNkFrTVRrRXNpRGkxWTVoaE5FNUt0UkFF?=
 =?utf-8?B?RFdrbzA4TzZpQkRBNmlaczZUTVNKa0FoUTFCNmYvZy9NY2hrOFpKNUpvNzR3?=
 =?utf-8?B?VTZLVXhxdE1iM011R2tBTGFnaU9DV2RPd3l0VUdaOGY2Uy8xRHFCM01WSkU4?=
 =?utf-8?B?T3VxRDJDS3krVjlsNkdKeHkxem5XMytjY2dtYm8zMk84L1Q3RlVJeVNGV01k?=
 =?utf-8?Q?X+AjmD?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:03:18.8757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec54a686-079b-4689-a7fb-08ddaa72494c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1022
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

When blobs are absent and are marked as optional, they can be safely
dropped from the binman tree. Use the drop_absent function for that.
Rename drop_absent to drop_absent_optional as we do not want to drop any
entries that are absent; they should be reported by binman as errors
when they are missing.
We also reorder the processing of the image the following:
- We call the CheckForProblems function before the image is built.
- We drop entries after we checked for problems with the image.
This is okay because CheckForProblems does not look at the file we have
written but rather queries the data structure (image) built with binman.
This also allows us to get all error and warning messages that we want
to report while avoiding putting missing optional entries in the final
image.
As only the blobs are dropped, the sections still remain in the
assembled image. Thus add them to the expected test case checks where
necessary.

In addition, a rework of testPackTeeOsOptional test case is necessary.

The test did not really do what it was supposed to. The description said
that optional binary is tested, but the binary is not marked as
optional. Further, the tee.elf file, when included in the image
properly, also shows up in the image data. This must be added as well.

As there is no global variable for the elf data, set the pathname to the
elf file that was created when setting up the test suite.
For the test case get the filename and read the contents, comparing them
to the contents of the created binman image.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/control.py       |  5 ++---
 tools/binman/entry.py         |  6 +++++-
 tools/binman/etype/cbfs.py    |  3 ++-
 tools/binman/etype/mkimage.py |  2 +-
 tools/binman/etype/section.py | 16 ++++++++++++----
 tools/binman/ftest.py         | 14 ++++++++------
 tools/binman/image.py         |  2 ++
 7 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 1946656f7d368209df3299a0e7c833b93edf2120..5a66c06d346cc74dc3e0e037eb263b6ced64a9b4 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -697,7 +697,6 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
         image.SetAllowMissing(allow_missing)
         image.SetAllowFakeBlob(allow_fake_blobs)
         image.GetEntryContents()
-        image.drop_absent()
     image.GetEntryOffsets()
 
     # We need to pack the entries to figure out where everything
@@ -736,12 +735,12 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
         image.Raise('Entries changed size after packing (tried %s passes)' %
                     passes)
 
+    has_problems = CheckForProblems(image)
+
     image.BuildImage()
     if write_map:
         image.WriteMap()
 
-    has_problems = CheckForProblems(image)
-
     image.WriteAlternates()
 
     return has_problems
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 6390917e5083e40a4e3294e5d36ec300d2057fe9..ce7ef28e94b17e349544776070c457d5882661b1 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -760,7 +760,7 @@ class Entry(object):
                           self.image_pos)
 
     # pylint: disable=assignment-from-none
-    def GetEntries(self):
+    def GetEntries(self) -> None:
         """Return a list of entries contained by this entry
 
         Returns:
@@ -1351,6 +1351,10 @@ features to produce new behaviours.
             os.mkdir(cls.fake_dir)
         tout.notice(f"Fake-blob dir is '{cls.fake_dir}'")
 
+    def drop_absent_optional(self) -> None:
+        """Entries don't have any entries, do nothing"""
+        pass
+
     def ensure_props(self):
         """Raise an exception if properties are missing
 
diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
index 124fa1e4ffc7d0374b27c09d32ead8429567d304..5879f377231bf94697bea97c3cfc3a2515665b8f 100644
--- a/tools/binman/etype/cbfs.py
+++ b/tools/binman/etype/cbfs.py
@@ -276,7 +276,8 @@ class Entry_cbfs(Entry):
         for entry in self._entries.values():
             entry.ListEntries(entries, indent + 1)
 
-    def GetEntries(self):
+    def GetEntries(self) -> dict[str, Entry]:
+        """Returns the entries (tree children) of this section"""
         return self._entries
 
     def ReadData(self, decomp=True, alt_format=None):
diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.py
index 6ae5d0c8a4f3c54e1277a575b8e235cc1aba4e13..75e59c3d3a3104da7559982f64968fdd99b7bd5f 100644
--- a/tools/binman/etype/mkimage.py
+++ b/tools/binman/etype/mkimage.py
@@ -205,7 +205,7 @@ class Entry_mkimage(Entry_section):
             self.record_missing_bintool(self.mkimage)
             return data
 
-    def GetEntries(self):
+    def GetEntries(self) -> dict[str, Entry]:
         # Make a copy so we don't change the original
         entries = OrderedDict(self._entries)
         if self._imagename:
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 1d50bb477534702019502d08f8648d4c9a367c0f..03c4f7c6ec74c6fa75c9362e2fecdb0e6ab568cb 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -537,7 +537,7 @@ class Entry_section(Entry):
         for entry in self._entries.values():
             entry.WriteMap(fd, indent + 1)
 
-    def GetEntries(self):
+    def GetEntries(self) -> dict[str, Entry]:
         return self._entries
 
     def GetContentsByPhandle(self, phandle, source_entry, required):
@@ -772,9 +772,17 @@ class Entry_section(Entry):
                        todo)
         return True
 
-    def drop_absent(self):
-        """Drop entries which are absent"""
-        self._entries = {n: e for n, e in self._entries.items() if not e.absent}
+    def drop_absent_optional(self) -> None:
+        """Drop entries which are absent.
+        Call for all nodes in the tree. Leaf nodes will do nothing per
+        definition. Sections however have _entries and should drop all children
+        which are absent.
+        """
+        self._entries = {n: e for n, e in self._entries.items() if not (e.absent and e.optional)}
+        # Drop nodes first before traversing children to avoid superfluous calls
+        # to children of absent nodes.
+        for e in self.GetEntries().values():
+            e.drop_absent_optional()
 
     def _SetEntryOffsetSize(self, name, offset, size):
         """Set the offset and size of an entry
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 4a8d330c8f89adc3c248199760a936dd243158a2..d707e2aa555b39316d206a4c170ebb83aa6daf72 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -251,7 +251,7 @@ class TestFunctional(unittest.TestCase):
         # ATF and OP_TEE
         TestFunctional._MakeInputFile('bl31.elf',
             tools.read_file(cls.ElfTestFile('elf_sections')))
-        TestFunctional._MakeInputFile('tee.elf',
+        TestFunctional.tee_elf_path = TestFunctional._MakeInputFile('tee.elf',
             tools.read_file(cls.ElfTestFile('elf_sections')))
 
         # Newer OP_TEE file in v1 binary format
@@ -6459,16 +6459,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
     def testAbsent(self):
         """Check handling of absent entries"""
         data = self._DoReadFile('262_absent.dts')
-        self.assertEqual(U_BOOT_DATA + U_BOOT_IMG_DATA, data)
+        self.assertEqual(U_BOOT_DATA + b'aa' + U_BOOT_IMG_DATA, data)
 
-    def testPackTeeOsOptional(self):
-        """Test that an image with an optional TEE binary can be created"""
+    def testPackTeeOsElf(self):
+        """Test that an image with a TEE elf binary can be created"""
         entry_args = {
             'tee-os-path': 'tee.elf',
         }
+        tee_path = self.tee_elf_path
         data = self._DoReadFileDtb('263_tee_os_opt.dts',
                                    entry_args=entry_args)[0]
-        self.assertEqual(U_BOOT_DATA + U_BOOT_IMG_DATA, data)
+        self.assertEqual(U_BOOT_DATA + tools.read_file(tee_path) +
+                         U_BOOT_IMG_DATA, data)
 
     def checkFitTee(self, dts, tee_fname):
         """Check that a tee-os entry works and returns data
@@ -6724,7 +6726,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         node = dtb.GetNode('/configurations/conf-missing-tee-1')
         self.assertEqual('atf-1', node.props['firmware'].value)
-        self.assertEqual(['u-boot', 'atf-2'],
+        self.assertEqual(['u-boot', 'tee', 'atf-2'],
                          fdt_util.GetStringList(node, 'loadables'))
 
     def testTooldir(self):
diff --git a/tools/binman/image.py b/tools/binman/image.py
index 24ce0af7c72b5256a9a71963a6d94c080ed8bdd4..698cfa4148e1a0f762d90d99ee3bc581cff5105a 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -183,6 +183,8 @@ class Image(section.Entry_section):
         fname = tools.get_output_filename(self._filename)
         tout.info("Writing image to '%s'" % fname)
         with open(fname, 'wb') as fd:
+            # For final image, don't write absent blobs to file
+            self.drop_absent_optional()
             data = self.GetPaddedData()
             fd.write(data)
         tout.info("Wrote %#x bytes" % len(data))

-- 
2.43.0

