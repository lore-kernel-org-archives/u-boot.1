Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3969C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD49D82CA6;
	Fri, 13 Jun 2025 14:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tnafIb+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28449807B1; Fri, 13 Jun 2025 14:03:24 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BDBA82C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoU1DmAudtT7uExlnKmecgcLAaLcehatm8Viw1QtnY89H8BpivfnxS8+4lBY++kf6votSVs1USEcAwApO9BjYTrKU9wRHRgVHQ0sZTwnqYRLA2SFEyIavIub1B4ZSZicU1rPCMeb4Pz4SutyFgcJdUIiB4uVA4ZcO3iBokjeF8nxoX4DrIj/52yy5vC4sxq+rGgMMj+5LtZl5+NWOEB33apX0HffvLit13WAh2puH/yYymC+IovL4JZ5y9F0FGybwGG2JrlNxUeDVDATuQjhPtrGl68AqJon9aFjBrEKluhh62nsFly4nVwYttgWKOgL1Y903j/rHToOS6k2LBZWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqil0OMh9WDlP20CBveb18VHu9fsViGyvSMQYaPaUkg=;
 b=JsNtmAKZVVC+ISlQExNmi8hJXi8WDFkCfPM5efE6mDNab6HoqUnuxyveKENiOsItvM0Lp8ie2JPWBBkZ1YmUtcaqeyVnln2WxnGaWExkEvpC9dzaJOjL3sIFgNa2+foiyBQV2LRctl8FkiMTkGJXPGHkc5fPxWUaySxbRYOQm7dk7K4uB4FmaUXU9wAonTqQf2mMdjvaDj3jAp20RKeowXPaLAp3wsUF58mJryu0yjoFamhRCPM8/jxpmvRCz2vunSigNqGEEeun9/jBdWR8n37IdYarJn8XZMade+qldPuHOCmVHA9+eN848qz+mSVb8fMxMBAilFQjL5t6AbsEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqil0OMh9WDlP20CBveb18VHu9fsViGyvSMQYaPaUkg=;
 b=tnafIb+Iyb4bU6v7afDC3xQAtNUydrJrb5MgqTc1dqhRIBwaaB0Bi083cov3zBqbELlCcj+3QcFIVWh38d0yNVZRkTRTbgdRbEBQLfzYBu/SKY97QFmPtOT/xHbhcac4Ha7dv5DcbhWgPeAEu6zYv5vJQi36j9fUUPtcck9A48M/NcD5Z45trHUM3hVVUyXxPdr+FbqsiCcEZ9phIVug7TlTI5qmrgEsFCTYCR7tF4jGqISBv/r/M0r+QIaV6URbviUBFLK1GbSUYEcp/iotYqX6qF8f5N8IeWc4TYRUL3+ZalUXpfIT2xrwiNSuCZVhNYBHrTs1mNW41YnIUklaPA==
Received: from AM0PR06CA0122.eurprd06.prod.outlook.com (2603:10a6:208:ab::27)
 by AM8P195MB0980.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 12:03:18 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::b8) by AM0PR06CA0122.outlook.office365.com
 (2603:10a6:208:ab::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
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
 2025 14:03:16 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 13 Jun 2025 14:02:40 +0200
Subject: [PATCH v3 1/6] binman: drop "faked" return value from check_fake_fname
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250613-binman_faked_optional-v3-1-1e23dd7c41a2@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749816196; l=4770;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=NNoLsdQ3bWm72CJmfz2whR4uB6luz7gUkEsO/aX1/J0=;
 b=YwwcOkkhU1NdajpIYdX1tMWe4hDS+0RutpEkScxJtotj/+O+0vNlcf2J3IsrrQiZFkZqXBQwc
 X8n4OAF/LknAjvVb1BqueB0BCrjkQNPYSS9ewaqM7ZsA2nTvpe/0C0D
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|AM8P195MB0980:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f32164-1056-4687-eefc-08ddaa724904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjdZZnJKVlJUOVBpc1Yya291VmdoSmFuVHVMcWlKc3k4UHRiaHJKRU1ZMlZ1?=
 =?utf-8?B?OGZaSWRSWUVQTVVxZXJLekJINW9CZGgxNjk4akJpTFd4Y0FnTFZqcE9ldW4x?=
 =?utf-8?B?Y3hHOEZqdzhkMGQwTjhsUURFZjNHOWp6TTZ1Q2NBL3JHTGFrd1gwSGRCQVl3?=
 =?utf-8?B?YUpZRlRGVkF3NkRMY0x6UTdjcDNKaFZ5SVhQaEF5ZDdDK1RTZjliYWxpNkRI?=
 =?utf-8?B?ZlFsa2VGYTZuT1V5cjJTeGxlQ3lwV3dFZ09pQ0ZHNHUxWUtpYkJiRjJtVVNZ?=
 =?utf-8?B?SVFIa3pPWENSNXNxZWk2L3lDWWhPeEFIUU03ZVZEc3hxbSt2ZmRHWUpzVmhv?=
 =?utf-8?B?a2lPcDF2ZWlJV2FPMXV2aVFRL2dzTnBrTFMzN2dkQlRhSzNkbHh1dERpajIz?=
 =?utf-8?B?WWV3b1h3M1ZqZ1VGOHlzcHY2TmpKaEtOSEJaUFplWExLSkRRNGxQODB3dUlS?=
 =?utf-8?B?dnpYbS9kdWNqalVLL1ZTM3dhN2plOEdsZ2EzdnluVHVoWG5jQ016ZEVSdDR3?=
 =?utf-8?B?eGZzcE1TUzloVW9sOU0zYmRGVkZKNUZ4c3dTVThVdnJsVXRHUkxZRHl3K0VD?=
 =?utf-8?B?bm5rNURwWGd6R0FSeVJCQzZsdVlqU2xxTE9iRFA3MTZnMEl0dW14SjZ3WjlZ?=
 =?utf-8?B?ZlphRHE2UXNNMzZhRzVockxaZkY1ZFdLanJ5WjBzcVdCQTN1WnVsYklQQklO?=
 =?utf-8?B?eUxlbktrN0EyUUFoMVI1bEFMOXN6WkJYRUQ5Rys5U0xtUGpMcE01TzVXNmtq?=
 =?utf-8?B?bVhOWTJTZE90S3pTS2lQenEzUnJBYy9Vc01HN2E0Y2hsNW1TT2V5eXBGZmR4?=
 =?utf-8?B?NVlyU2o4UFJuYUFlTHRZVWhOTnN6SHVOTlZDZ25sK3Z5VnZCOTlTc0FxN2Rv?=
 =?utf-8?B?cWpNalIzcXoraEFGbGFFbWZLbVFRdDRnUE5WbEFQNmFYQStvRkVaT244czdX?=
 =?utf-8?B?MzBiSklMdjRZUHZESlRvOG56Q0J0SVNxa1E3ZkkvT09CYXR1OUdydkRVK0E4?=
 =?utf-8?B?TGNUNEJ3eHdkMTJQeDRrcmU3WFRlNFVmQ21UUTJFL2VVRnJOMENRekJSUzlP?=
 =?utf-8?B?NFVqTlk1QndhTEowcnZvMDlMK2FyUTcvbnRjQkhyY0NzTGsycEdvVWhlTTVG?=
 =?utf-8?B?ZndJNTd1MWdReThsRVFBWXgxSU1ocGtCOGViU1Z4NEl0cnVQQ0dYd0x3WmFS?=
 =?utf-8?B?aDhXM3I1LzVUeGo0UFdTRXZkTFR3ZmdSczg0Vit1Q21OcTJuUk9kY1B3MmFy?=
 =?utf-8?B?Tm9qSDFCRjgzeUFLQkNiNFY4S3IrN001V2lYYnIxU0toYUZCR0xpRmVlb3Ey?=
 =?utf-8?B?eHdsS1VSNmxVRDlwdjJOUGlycS9zanlKWTFyTEZiNW5ma1ZSRmp3emtyZXB6?=
 =?utf-8?B?emtVY203QWVuRjg2c2xHakg1QkNic0R6OGZ6b2hzRVJmcnV2LzNDWXZZWERr?=
 =?utf-8?B?RkJPY0xmTDNaV01oMjV2NE81NmI3V2RDbUNselVLdlc1STVSSGhGWE9BYmVC?=
 =?utf-8?B?cHFkWjhnb29EVEZPUGxYMnJHK3BZYmdiSGpOMExJdy84VzhqWFpyTkFEbUMz?=
 =?utf-8?B?OURyb2dCM3ZaT3ZKS3dEU2RwZEZoUlZSbnlTNTk5MzlrTjU1N1lEOE52bW1I?=
 =?utf-8?B?dE5Edk03ekpuYzVsc2dxa0VSZGhDV3haT05tWmlvMGptQ1JUWnlsNmYrSGVE?=
 =?utf-8?B?QnR3WmxBenc1NUt4RDVyVlVsalBXY2tXQ1dHQmpSS3lOZkFEREJoa3BMM2lx?=
 =?utf-8?B?N2ZrZjV6WEhVWXZBb0tLV0ZrMnJtUHZ4VU05ckNtTnN2dU1EMHFCajZkb1lk?=
 =?utf-8?B?UnU4ZVhaTGdFNi93NTlLUlo3Y0k2NmxFTHYxS0V5RmlacEJRcWdmZUNud1Yx?=
 =?utf-8?B?TzBxV2M3NTc0aUpOU2hTd09wcW14ZDdCeEV1dzl3SnBQa0VJTUQzRlovNElW?=
 =?utf-8?B?U2dFN21ibFU0OTFaTXBqV1JGajByVjdzZzJzd2hob25TOFdsSTlvUFUzV2dl?=
 =?utf-8?B?b2s4QTNoM2xuWGlBQWh4ZGNvUHBCazI5UXphZGQrazUwVmRKM0VjMENaanBk?=
 =?utf-8?Q?B0NiNn?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:03:18.4075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f32164-1056-4687-eefc-08ddaa724904
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0980
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

