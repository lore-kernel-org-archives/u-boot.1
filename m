Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D757FC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3AA83852;
	Tue, 27 May 2025 15:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eD2fTP1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0811F8309E; Tue, 27 May 2025 15:24:43 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7FF83844
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4tHsqKx6rbAF9G+LApZeYYMhqCXfXVXr/flLFBKDPxK+NTjJPevLsvjFmXJYirkLgYSnedlzIgiwuvRT1ozUfDr4lih6tXFt3T2RJO9qvDZ8/g2+jygEUjTxIqdOmA4nKZIOXWYnWHsdg/ZNVbGt0fRn1Zu6oYCvgg5Raaal/CI5fCI7y6YtewxLBrMMcJOru08KKzHNQlA8MOReRMD5jJDvpzZ5WEc1WCJ9OIfjMi1kxTx/s6BNRoNyPvitw2tvva/avaSeThgJBe8XgK3EBzK8U8P0AleM9Jg2RrzNzb+e/YEYN9q0kZmVR3omvfzkgrWflOq15c+1dYX9lAiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqil0OMh9WDlP20CBveb18VHu9fsViGyvSMQYaPaUkg=;
 b=HEkNsYh0e5/gkhY1lDnuurUvadljSFZQ8GFTpVrLSuPgX5879RfEiC8DUU7GDqNZHyQ+erleHyhWBstcSE7kSoNtIAZX7emHPJvFpJGbzGX1YraV3W34qQTAXzdyZI1wqjhuXzppQxWsaH22TqEq2jqNlL5MVBwAjQyMepIh2PFDNsDFa31XmZb+81Tc6wFpoX+QUMyY96BXR42AVBA150p43lf7KflSNvwHhRyIe4Osg59BONrkQS0WNEGqZpTpqgBfxgO7Xad1kbrxXPSeCAMbsOpRPob/c+XUgG8blhPRS16KjPUI7jhZQst+tfSEP2cIAiNqLwtMAD4OxXCnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqil0OMh9WDlP20CBveb18VHu9fsViGyvSMQYaPaUkg=;
 b=eD2fTP1+aFcraDZb2dRffM0NGpe7EC59lSBW5l/EvAs1Arbiwv2aszvcKBj+m4SUI9kH8zCsUzJ71p8GPTSxUYALPJsvIM6vgIAnLsVXQbVQ6NqTyFFQOZUWlertMD1kDUrXrDUXDENXzvpWIWuVCf3VsA5L3ki6WEo0vRnE1EzvkS1nVWqjGctjsuyjiekzc3dOq3soDn70PepGWdVy5uSihw3hb3GIBjgBxZlB79ngvewi1BDsbqrifvZmV8JVcA8B0UPRABIocJykL296heI42G3dHmu6ORbYZ1JLcTy2pXYmukCMFo3hdyXI5rKq+025Un5PCUJZeIUoULJnyQ==
Received: from PR1P264CA0022.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::9)
 by DB9P195MB1145.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Tue, 27 May
 2025 13:24:33 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::e4) by PR1P264CA0022.outlook.office365.com
 (2603:10a6:102:19f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 13:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:33 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:30 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:10 +0200
Subject: [PATCH RFC v2 2/8] tools: binman: drop "faked" return value from
 check_fake_fname
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-2-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=4770;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=NNoLsdQ3bWm72CJmfz2whR4uB6luz7gUkEsO/aX1/J0=;
 b=598YrBYQ8X6h6yJMgw79SfqHQ6pDASxYovsqCJK4J5oJo5zQpfgjVPU92yUGuZ+fzDTBbrKjo
 21D8RZ4IWtcBYBM0HWqlLhoaAr9PRniaxWHdKQw6wI08ZSQSjIbDq5N
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|DB9P195MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0835cd-9671-4fc4-7fd1-08dd9d21d180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXdvcjdmdGM0bmdBN2Y1QUtMWlF3Qko1OTdwcVp4RUU2cGFnYkxJaFNsMDdB?=
 =?utf-8?B?aVRyVEJFRWpNcStGeHhxQ2RtZUVWTXBxblZPUnRxZkdxMTZ5SzNaK3dQMmNH?=
 =?utf-8?B?dUxoa0lFUnRkV1dLTEc1Sk1nQnBZak53VHRxY3NoQ3J5cU9tVjY2V1IwVG9Y?=
 =?utf-8?B?a1BvWlNWYW1YS0Vvem1GRmxiazZIbGU3dlV3MElEUFpmOTc0S0hNY3dENGhU?=
 =?utf-8?B?NjVXU0drL29pajl6MmRxbUZwanM3cXF6akpjRFBFcTVPOTV6b0pZdjlXVDg3?=
 =?utf-8?B?Nk0zTThoTGVJRnNoMzJJcC9KVGtxRUQxUFBTQXBWT2NMMzlXdGEvdWljY2Rz?=
 =?utf-8?B?YUFJSE0xek5mb0hFNzljNThPS3N6aUhYVXc0M0hiVER4K3VOVENDK3ZDbm5v?=
 =?utf-8?B?bmw3clpINW91L1Zzcklod2lYZ2lDcHo0bDA2SWc4c3BIODAwSUxUMWc2MzlP?=
 =?utf-8?B?VUQxU0JYTE5NU1V1M1FoUzU4cEs0MmphUHl4SVdUUGxmNHJIL3c3SmtDL09J?=
 =?utf-8?B?RWlWZkpXWGFKb1dBeXpMTnNNbHJEOHZES0VHWTRBUlF4TWFhSDMrK1NKMDEy?=
 =?utf-8?B?c1ZBeEZuZnBWL3grd3Y3bUZkK1VKL09TV3hZbXpuSW15WUxSS2t2K3VBUXg1?=
 =?utf-8?B?UGZYQTZMOFdwWERYeW05Q3p3SWY5ang2STBTK0ZkbzRhRDlhOHZEeGhKdC9H?=
 =?utf-8?B?UnJNa0RGZ0s1KzlhMW04WFV0M2crSEZBd3FERGdBdUVibmNXeitYRDBKbzM2?=
 =?utf-8?B?RnExWDYrUjNJY1k4dm1sZUdXMElvbHhBdXlIcm5GMGx1QndVT05CblJGbHVw?=
 =?utf-8?B?dndTbUkwUjF5ZFg2OGoxZXZaM3RNRTVDS3Y5L1U0KzdhMjVubDN4c2NlbW1y?=
 =?utf-8?B?aVpIZk9oc2gzeDRmcE8xbkZRSnZ0SE9KTlp6bnd6U1B1WnVQamlOaUdYaGJQ?=
 =?utf-8?B?RUVVTUFOY1pjRnhHRW5FdnY2elJ5ZmhJbWNGdmIrSmZhdHRSUG1YdGE1Nm5p?=
 =?utf-8?B?ZmpwZ1dqdnFJSWl5dGFOV3hxK3BSNFA2YVp6aG9MSzd6WWRhZGM2SHorZVZ6?=
 =?utf-8?B?U1BtUjlOMGo0UHNqMmVqNU5CYmZxSzNSZTN3SnBnNWV1UFFkYW5EMWluMEk2?=
 =?utf-8?B?TlAvRHdrZ2tDNGlWd3NTVm5zKzBmMU5SbDBCSFNSTzFoT2ZYaWFTRUt6bUVU?=
 =?utf-8?B?V0hTVWhvelNLREJ1YTlsc0dKSGJUSmZ4bGl4OGp4YkI0bmpTUENlZE9iVDhJ?=
 =?utf-8?B?TDB0S2VXeGhrNDFkL2wyVlNSQlI5a2Rhbit5WlRkbnF4YThLS2loNEJlU21O?=
 =?utf-8?B?V1Y4MlhHOXpRbngvQlNiZWhkaEpzLzlWYllKaXVMQlQ2RlRxcURLaDRQR1hz?=
 =?utf-8?B?UVFOcVB2NnU2L0lpanc2SUhSTHpMbFZOb0JSOHN5SXpnQ2RoMEhoUllHQzRp?=
 =?utf-8?B?NmxralFiUFpNOVIzWk1uVTU0VFY5VTFxL2NtaTBMQzNONDdsVnVQQTNDZE04?=
 =?utf-8?B?d2tVcE5JR0t6TDZGU2VSTmFMV2JKOWZoSStkVmRNVDZEZXJIQmIwNlJHVGRZ?=
 =?utf-8?B?a2k4clhJYVVQYUFKdzR0RkE5ZUdnUk04aGxjOW9RNE55TFJnNVJrTSs5SEJ4?=
 =?utf-8?B?eWkzdkJyZnpxS1UwSjZEZTdENUEveG1hbW5jVmFtVnZoWWhpVWJKZkl1bGNB?=
 =?utf-8?B?aXBXQ1JiSFVXd25MQm13cTZnYUE3YU5NeUxyakJLL1BxY0o0Wno1UDdsdXFN?=
 =?utf-8?B?WDYwc3I5LzFYL05nSlVsWEhJYXBhY3NwRkV6SURUWStDUjA1RTFKd1RibDhr?=
 =?utf-8?B?Mmh4bUxKVHllWUVPODRGSmFOTURKYVVwejNkNmNBVDZSNHdpUDA3SkdvL1lL?=
 =?utf-8?B?elViSUtXeFM3UXVGbDNrRHJRbDAwQjRqR1FhVVJGMXhhVXBVSUd2QmRRL2pW?=
 =?utf-8?B?VEcwWUNwTnUycy94WStmYzFadCtFZXBVd2NmeVE4aXJBbjBpMWo1K20xd00y?=
 =?utf-8?B?bDdXMGF0RGE2cTNZaWJmei8yZFNtL24yT3lTaXBkekE2ZHFUOVFhMlRXT1NH?=
 =?utf-8?Q?IJR28W?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:33.0397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0835cd-9671-4fc4-7fd1-08dd9d21d180
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1145
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

check_fake_fname sets the faked member of the entry. Use that member
to get the faked status instead of a returned value indicating the same.
Add type annotations to the modified functions while at it.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/entry.py               | 11 +++++------
 tools/binman/etype/blob.py          |  7 +++----
 tools/binman/etype/blob_ext_list.py |  4 ++--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index bdc60e47fcab7bc69907eb08de9b50e977934b74..6390917e5083e40a4e3294e5d36ec300d2057fe9 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -88,6 +88,7 @@ class Entry(object):
             updated with a hash of the entry contents
         comp_bintool: Bintools used for compress and decompress data
         fake_fname: Fake filename, if one was created, else None
+        faked (bool): True if the entry is absent and faked
         required_props (dict of str): Properties which must be present. This can
             be added to by subclasses
         elf_fname (str): Filename of the ELF file, if this entry holds an ELF
@@ -1120,7 +1121,7 @@ features to produce new behaviours.
         if self.missing and not self.optional:
             missing_list.append(self)
 
-    def check_fake_fname(self, fname, size=0):
+    def check_fake_fname(self, fname: str, size: int = 0) -> str:
         """If the file is missing and the entry allows fake blobs, fake it
 
         Sets self.faked to True if faked
@@ -1130,9 +1131,7 @@ features to produce new behaviours.
             size (int): Size of fake file to create
 
         Returns:
-            tuple:
-                fname (str): Filename of faked file
-                bool: True if the blob was faked, False if not
+            fname (str): Filename of faked file
         """
         if self.allow_fake and not pathlib.Path(fname).is_file():
             if not self.fake_fname:
@@ -1142,8 +1141,8 @@ features to produce new behaviours.
                 tout.info(f"Entry '{self._node.path}': Faked blob '{outfname}'")
                 self.fake_fname = outfname
             self.faked = True
-            return self.fake_fname, True
-        return fname, False
+            return self.fake_fname
+        return fname
 
     def CheckFakedBlobs(self, faked_blobs_list):
         """Check if any entries in this section have faked external blobs
diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
index 041e1122953ef80c0c48735fa8116f56def58f58..970fae91cd9b2a31b3f31d2ecdb77e27a89d69fb 100644
--- a/tools/binman/etype/blob.py
+++ b/tools/binman/etype/blob.py
@@ -42,7 +42,7 @@ class Entry_blob(Entry):
             if fdt_util.GetBool(self._node, 'write-symbols'):
                 self.auto_write_symbols = True
 
-    def ObtainContents(self, fake_size=0):
+    def ObtainContents(self, fake_size: int = 0) -> bool:
         self._filename = self.GetDefaultFilename()
         self._pathname = tools.get_input_filename(self._filename,
             self.external and (self.optional or self.section.GetAllowMissing()))
@@ -50,10 +50,9 @@ class Entry_blob(Entry):
         if not self._pathname:
             if not fake_size and self.assume_size:
                 fake_size = self.assume_size
-            self._pathname, faked = self.check_fake_fname(self._filename,
-                                                          fake_size)
+            self._pathname = self.check_fake_fname(self._filename, fake_size)
             self.missing = True
-            if not faked:
+            if not self.faked:
                 content_size = 0
                 if self.assume_size: # Ensure we get test coverage on next line
                     content_size = self.assume_size
diff --git a/tools/binman/etype/blob_ext_list.py b/tools/binman/etype/blob_ext_list.py
index 1bfcf6733a752d3552d5adbbf5a1cd206d36963f..a8b5a24c3a1c2c9b0b1bd7ab793ba3993cb4368e 100644
--- a/tools/binman/etype/blob_ext_list.py
+++ b/tools/binman/etype/blob_ext_list.py
@@ -33,11 +33,11 @@ class Entry_blob_ext_list(Entry_blob):
         self._filenames = fdt_util.GetStringList(self._node, 'filenames')
         self._pathnames = []
 
-    def ObtainContents(self):
+    def ObtainContents(self) -> bool:
         missing = False
         pathnames = []
         for fname in self._filenames:
-            fname, _ = self.check_fake_fname(fname)
+            fname = self.check_fake_fname(fname)
             pathname = tools.get_input_filename(
                 fname, self.external and self.section.GetAllowMissing())
             # Allow the file to be missing

-- 
2.43.0

