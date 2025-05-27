Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF73C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77AB183831;
	Tue, 27 May 2025 15:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RpEMXKwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECA48383A; Tue, 27 May 2025 15:24:41 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B5B837F6
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONT5TdM0t1SrbM+tJvltL8M08BC6WBEhsV/ql9h4EO6FpqWKvSGtJEi/JN65XD4TAdTSi3YL3DR4zLPYMlxENF9+cPbQd2GWaAFwQbBIR71F04G+uhWbvCrocpj3kuPQSZDrIWBbwWf0jSDWGNVhVFuoqr2LvF9CI7hMWSaQJ1ypGuE5Wk3ZPilMx47L2GcCfICjXQrLKKlnvbg1vSMQUcngbi3nGvAWrJ1rwGqMr0yC5q2WUFrdbsLVN2x7NbTxK3O9tckjujFJ1jk/EO3+KSq2OKOfYP9gSteAiw6Vnonhjd6TX4pm3KpzqvSqd+y+E6XE0gZa2fwXR5e++o3c5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u4rhP4GoSvJCrXIZyU6OrrEmx0459KZYZtbbhQS8UQ=;
 b=y1TErRusmLC7PIQ60eIR4wx0+dmkylWd8gwzvRkDqVnJ3YCG1fpYeAPc8wZy1oW5dnLbFKRmnXGi0K7LFN6mWoavAnvPj/rGyyc3r8DVjIo/jyYU+byyEJWKa+iPhLS6McIy+ee7Xqm7td3XZLWmL1hPrTKCr+xMOMGBG3kvT/cMovOPxHOnd/+A9NvXrx/Q0xocFkIbhg7gM+gkIZFag255M5kZL8DeN4/QnAqdYa/j2toO9aMV5Pt4lwDuj4/fv/QlW40wRAdrKTKRfO3aLXPckNcBbTcP/tq+LSMv659ESfB1UBVrwRhmAMwrEZeb0sScWaFre6ixTqNP+1vZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u4rhP4GoSvJCrXIZyU6OrrEmx0459KZYZtbbhQS8UQ=;
 b=RpEMXKwVXbpwIFcUlktdog819jHIoZG8WKWEXYfn0bdTF7WCXeDwkbRYd8+3D6gl16TVG1Y+rtfsB17AVeo6JLoapYeS0Z/FPbNepmdIMdLcM5tNSLHPFtpGBDTzKNZ6kpnw4/fkXYXtoHn1dbI/+XVm4VacziavBWmy0xnx4t7HW7eczWSH7OLsh8ECFrhEeWH1mevRYZB0qB2nPdZTzz3Ng6gxVqmoTCFVNY23i+8Ttn9UjlFe7QaCv+WlYWdeJqygPCMw6fGP8fvM5i9Qw6W5zX8wcUQ1RKQboHz41c03nFE1DZRUyCNCs47AWuz7qS2l6tw0mFoS4vwTli8SSg==
Received: from PR1P264CA0033.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::20)
 by GV1P195MB2032.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:60::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 13:24:34 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::87) by PR1P264CA0033.outlook.office365.com
 (2603:10a6:102:19f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 13:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:34 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:12 +0200
Subject: [PATCH RFC v2 4/8] binman: replace _entries with GetEntries()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-4-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=19196;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=noNpS2qk5j64Ihn8G3t1Y5G/d8XLKT2KbZqkA1U4xjA=;
 b=2QBeOmECqO3MvwufM7jWFU1rLDktpYDgEnPqkbzcnwRLB+tKy5smoeE+qb+PGRToVkiRUCWlo
 25QKRh6q8ohCRxjwjq+evnNmwEnnI2Wu+xDcuERdvDbnitCyRsOy1ry
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|GV1P195MB2032:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f1589b-ae6c-43f6-e656-08dd9d21d21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzRnOFJZNG0xcjNNRVdXOHR0QS80bFBuR1B1Um1tOEs4dVQ5VEQ3U0VhMmw4?=
 =?utf-8?B?aGhySW5xYXRocVJVSjA1cWpwZ21QZjdGSXBweEY5ckYrSHdITGo4YnFCVEM5?=
 =?utf-8?B?dFZXeVJidlo2YnZEWjQ0cVNUN21MVllmQ1VOSjhiQzltTFZVWGdhNGs3WGM1?=
 =?utf-8?B?TW01b25DSmdKcCtlOTM2VGJUTWMvd21VSWFBMzRHMHNQaFcxUjJaSUczTGcr?=
 =?utf-8?B?YWxpVkEybWVvVnh3OGhUQmFldjZ0ZTBTeFM4Z3k4dlFzTEFKTWFjanpNYmdk?=
 =?utf-8?B?MnB3TDR2YVVJN242NS9zbDNlRHVhTER4cTRWbUxGWkx4MXVuaDNuT2MxTlA1?=
 =?utf-8?B?VjhGOXdySkpTNWtUdXpSZkdXRzI3TjN1U1I0WnhsbWxuZEpOUkYzMlpkUTUx?=
 =?utf-8?B?OGdxeFFHc09pSVZtQWIxZ2VUR1BuSTdIZ0pvSDVHVVBHamlGQ2V5N3dGZ3pO?=
 =?utf-8?B?V1Y3WnJZVUFpQTF6b0dLczh2blE4bk5lS1lsL1JFTk1sb2NiWFVNQVhnakIw?=
 =?utf-8?B?NjhidWNlazZDREZzZklYTGVOTW45RjFkQzNGcEFEWDFUWnJHMTlZV0FlTDBE?=
 =?utf-8?B?dEgxcVFOUWlURitTUWY5bDVRVmk4My9WOUF0STAraVNRTUlIUnQ0R01yUElk?=
 =?utf-8?B?eTdReWJvbnJQb1hybU9yR3pOZTVsK0JEQ21QQnErYVhkYlFqZ2xYQUkvcmhr?=
 =?utf-8?B?U3JhVTlnek45RGVudlhpMG1xYkdyRzF6Y3g0TXhhUkVaMGlZR2M3UU9UazU4?=
 =?utf-8?B?Z1FkTmVCRW96c2FGL3ZDWlREMU5HbTJuWjJNRlVKVGljanhhV05jR0lRRkc1?=
 =?utf-8?B?cXVFQnNBSnVqazlBTjdNRXVjTFBLeURpNnpydnFSRDhyRk1Ib1FodmV2ZXNm?=
 =?utf-8?B?anpaRUgrMnZBRDJNNmNPMmpyUVplZWp1TitQVzIvaWt3cnZpSzNBejZnSDVZ?=
 =?utf-8?B?NjFmT1lFK3dpQmQ5anZFNGV1NUNMOUFxdHRVWkFuMWY2cThsVGI1b3RsQ1lF?=
 =?utf-8?B?YTgrdit4MTBPdXUwaVdmWHczS2Y1ZWZuelJDSGI5a2hxMTJVeVM4ZzZJSERW?=
 =?utf-8?B?QUZSMHREL0M3TVNONXE0Uk5XRzI3QmJZUE9sK0VZb2JEbHV3NG1uekJwOE9B?=
 =?utf-8?B?WFh3UGw1LzNGdVRGN1J5akFuNUZrZ05hM3hxWjQ2NGZUNUhsdzRUbElCMVYw?=
 =?utf-8?B?NjYvdktDMlVxSGEwYTd6d1p1Y0RpdlZLMjBXZFkzVk8zaThxQXY3bG9xRFh6?=
 =?utf-8?B?VUg4d2RkdDBFcDZwTWFUbXp5UGJRVWN0U0YyYm1xajQwbFRYeTFJblNnZm1I?=
 =?utf-8?B?RERNYThoK2JyYTlBaWdUcGpYMkl2cWNkVjhCQ3VGYklFVnJubThlYU8xRHBt?=
 =?utf-8?B?b1o4VnI0VVBBeDljOFBKR2Y0KzZ1emlnZGZwZjYrVzF2U3ZIUG9OQUhKQmk2?=
 =?utf-8?B?MzRGTGJkQWZNaHR0c0lmOHVSSlJjQlozYXJQTThIREVlbFYrd0hQOUF0SjZj?=
 =?utf-8?B?UmZOc3Jzb0FBTVl2c2g5K09uamV0NmYycnpQS2ZBUzc4T0tuRjBXK1ZMaUFh?=
 =?utf-8?B?RmpUMTdSMEN2bzFOeDlEUEM2bHJDYThsbEFaYVFRaFdNZWw3cUVudHNjL0wv?=
 =?utf-8?B?djVrQ2kxbWtHb05rZ1E5QWhqRm1CLzNmU29jNDE2UldPSDZKWUVNanpmSnZO?=
 =?utf-8?B?ZTN1bFUwV05WM3dxSzhBM2UxOFJEcTQ5UXZveTdZVlowTGJJUDJ6M212NDFI?=
 =?utf-8?B?VjdvSFJJY3BzQVNWdWRpSHA5aEJDNXZ6aEJBZ0tIU2xiL2lQQXVWTFE3MDdP?=
 =?utf-8?B?dy9Id3V3YmxWeUNLR2xGb0JQdkRDbGFHdWlOcDNnL1k0dnVjOXVieEl1Y2x0?=
 =?utf-8?B?SnhpTjMvOG5yS2w0b0JqT1pMWllrUUFqWWM3dUEzNFE5dWI0clF6Q1M1a2dq?=
 =?utf-8?B?dk5XZ255TWRSdVY0T0xZcXc3UlFHdDVQUG1POFJxdjJrdW5ueVhEQXJtTzl1?=
 =?utf-8?B?THl0OHowdWJCemNJQTdOUUovTk1SNDF5cWtHZ1A4MkI5ZThZU1BRQitCbnZQ?=
 =?utf-8?Q?/8K29A?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:34.0710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f1589b-ae6c-43f6-e656-08dd9d21d21d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2032
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

_entries, as highlighted by leading _, is a private member and thus
should not be accessed directly. As a result use the GetEntries function
instead.
GetEntries() returns _entries. No functional change introduced in this
commit.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/etype/atf_fip.py         |  4 ++--
 tools/binman/etype/blob_phase.py      |  4 ++--
 tools/binman/etype/cbfs.py            | 12 +++++-----
 tools/binman/etype/efi_capsule.py     |  2 +-
 tools/binman/etype/fit.py             |  4 ++--
 tools/binman/etype/mkimage.py         |  4 ++--
 tools/binman/etype/nxp_imx8mcst.py    |  2 +-
 tools/binman/etype/nxp_imx8mimage.py  |  2 +-
 tools/binman/etype/section.py         | 44 +++++++++++++++++------------------
 tools/binman/etype/ti_board_config.py |  8 +++----
 tools/binman/ftest.py                 |  2 +-
 11 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/binman/etype/atf_fip.py b/tools/binman/etype/atf_fip.py
index 636e073afc84b37d64934e6dd03945e9d515483a..56c5b2a8189453d83dd48fd37416690ded140f2a 100644
--- a/tools/binman/etype/atf_fip.py
+++ b/tools/binman/etype/atf_fip.py
@@ -220,7 +220,7 @@ class Entry_atf_fip(Entry_section):
             bytes: Data obtained, or None if None
         """
         fip = FipWriter(self._fip_flags, self._fip_align)
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             # First get the input data and put it in an entry. If not available,
             # try later.
             entry_data = entry.GetData(required)
@@ -244,7 +244,7 @@ class Entry_atf_fip(Entry_section):
         super().SetImagePos(image_pos)
 
         # Now update the entries with info from the FIP entries
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             fent = entry._fip_entry
             entry.size = fent.size
             entry.offset = fent.offset
diff --git a/tools/binman/etype/blob_phase.py b/tools/binman/etype/blob_phase.py
index 09bb89b3b7849834c3572f4c8080ce0fdcca1dc2..0f9ab3f05dd19baecb052ab8b3af513ecca15936 100644
--- a/tools/binman/etype/blob_phase.py
+++ b/tools/binman/etype/blob_phase.py
@@ -55,10 +55,10 @@ class Entry_blob_phase(Entry_section):
 
         # Propagate the no-write-symbols property
         if self.no_write_symbols:
-            for entry in self._entries.values():
+            for entry in self.GetEntries().values():
                 entry.no_write_symbols = True
 
         # Propagate the symbols-base property
         if self.symbols_base is not None:
-            for entry in self._entries.values():
+            for entry in self.GetEntries().values():
                 entry.symbols_base = self.symbols_base
diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
index 124fa1e4ffc7d0374b27c09d32ead8429567d304..886e34ef8221ad50e9f881e8abad16015c9790b5 100644
--- a/tools/binman/etype/cbfs.py
+++ b/tools/binman/etype/cbfs.py
@@ -220,7 +220,7 @@ class Entry_cbfs(Entry):
         if self.size is None:
             self.Raise("'cbfs' entry must have a size property")
         cbfs = CbfsWriter(self.size, arch)
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             if entry != skip_entry and not entry.ObtainContents():
                 return False
             cfile = self.ObtainCfile(cbfs, entry)
@@ -241,7 +241,7 @@ class Entry_cbfs(Entry):
         super().SetImagePos(image_pos)
 
         # Now update the entries with info from the CBFS entries
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             cfile = entry._cbfs_file
             entry.size = cfile.data_len
             entry.offset = cfile.calced_cbfs_offset
@@ -251,7 +251,7 @@ class Entry_cbfs(Entry):
 
     def AddMissingProperties(self, have_image_pos):
         super().AddMissingProperties(have_image_pos)
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.AddMissingProperties(have_image_pos)
             if entry._cbfs_compress:
                 state.AddZeroProp(entry._node, 'uncomp-size')
@@ -263,7 +263,7 @@ class Entry_cbfs(Entry):
     def SetCalculatedProperties(self):
         """Set the value of device-tree properties calculated by binman"""
         super().SetCalculatedProperties()
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             state.SetInt(entry._node, 'offset', entry.offset)
             state.SetInt(entry._node, 'size', entry.size)
             state.SetInt(entry._node, 'image-pos', entry.image_pos)
@@ -273,7 +273,7 @@ class Entry_cbfs(Entry):
     def ListEntries(self, entries, indent):
         """Override this method to list all files in the section"""
         super().ListEntries(entries, indent)
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.ListEntries(entries, indent + 1)
 
     def GetEntries(self):
@@ -299,5 +299,5 @@ class Entry_cbfs(Entry):
 
     def AddBintools(self, btools):
         super().AddBintools(btools)
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.AddBintools(btools)
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 9f06cc88e6e505448800c05988a039d287525b7b..5cdc6536795b824aea74b22b198a177df8cb35e2 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -130,7 +130,7 @@ class Entry_efi_capsule(Entry_section):
             if not os.path.isabs(self.public_key_cert):
                 public_key_cert = tools.get_input_filename(self.public_key_cert)
         data, payload, uniq = self.collect_contents_to_file(
-            self._entries.values(), 'capsule_in')
+            self.GetEntries().values(), 'capsule_in')
         outfile = self._filename if self._filename else 'capsule.%s' % uniq
         capsule_fname = tools.get_output_filename(outfile)
         guid = self.image_guid
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index ed3cac4ee7e9706bc46f1cffc90c41946591ec2f..f03e64319eeb3c23b59e368bfac698765e68e1b5 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -962,7 +962,7 @@ class Entry_fit(Entry_section):
 
         # Remove generator entries from the main list
         for path in to_remove:
-            if path in self._entries:
+            if path in self.GetEntries():
                 del self._entries[path]
 
         # Pack this new FDT and scan it so we can add the data later
@@ -994,7 +994,7 @@ class Entry_fit(Entry_section):
         fdt = Fdt.FromData(self.GetData())
         fdt.Scan()
 
-        for image_name, entry in self._entries.items():
+        for image_name, entry in self.GetEntries().items():
             path = f"/images/{image_name}"
             node = fdt.GetNode(path)
 
diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.py
index 6ae5d0c8a4f3c54e1277a575b8e235cc1aba4e13..19ee30a13ca75a5d05a17d4c26424e84934b6ea2 100644
--- a/tools/binman/etype/mkimage.py
+++ b/tools/binman/etype/mkimage.py
@@ -168,7 +168,7 @@ class Entry_mkimage(Entry_section):
         if self._multiple_data_files:
             fnames = []
             uniq = self.GetUniqueName()
-            for entry in self._entries.values():
+            for entry in self.GetEntries().values():
                 # Put the contents in a temporary file
                 ename = f'mkimage-in-{uniq}-{entry.name}'
                 fname = tools.get_output_filename(ename)
@@ -179,7 +179,7 @@ class Entry_mkimage(Entry_section):
             data = b''
         else:
             data, input_fname, uniq = self.collect_contents_to_file(
-                self._entries.values(), 'mkimage', fake_size)
+                self.GetEntries().values(), 'mkimage', fake_size)
         if self._imagename:
             image_data, imagename_fname, _ = self.collect_contents_to_file(
                 [self._imagename], 'mkimage-n', 1024)
diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index dd9f226b7514ff4070652273c5520498bec02f90..8b3785a318bcc4c92c3ac0ed23b745f08911e4fb 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -95,7 +95,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
 
     def BuildSectionData(self, required):
         data, input_fname, uniq = self.collect_contents_to_file(
-            self._entries.values(), 'input')
+            self.GetEntries().values(), 'input')
 
         # Parse the input data and figure out what it is that is being signed.
         # - If it is mkimage'd imx8mimage, then extract to be signed data size
diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
index 8ad177b3b65e8c45e7f2fd74768b319930704e10..2fc572f2dc09a40b8e255d6157de31f806649e7d 100644
--- a/tools/binman/etype/nxp_imx8mimage.py
+++ b/tools/binman/etype/nxp_imx8mimage.py
@@ -39,7 +39,7 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
 
     def BuildSectionData(self, required):
         data, input_fname, uniq = self.collect_contents_to_file(
-            self._entries.values(), 'input')
+            self.GetEntries().values(), 'input')
         # Generate mkimage configuration file similar to imx8mimage.cfg
         # and pass it to mkimage to generate SPL image for us here.
         cfg_fname = tools.get_output_filename('nxp.imx8mimage.cfg.%s' % uniq)
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 4c4c8c417f81be6fc1e23d28ea971052e7aef9c9..44b1b85e93496d0ca114907f42a98da1f0af09b9 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -229,7 +229,7 @@ class Entry_section(Entry):
 
     def GetFdts(self):
         fdts = {}
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             fdts.update(entry.GetFdts())
         return fdts
 
@@ -239,7 +239,7 @@ class Entry_section(Entry):
         Some entries need to adjust the device tree for their purposes. This
         may involve adding or deleting properties.
         """
-        todo = self._entries.values()
+        todo = self.GetEntries().values()
         for passnum in range(3):
             next_todo = []
             for entry in todo:
@@ -255,7 +255,7 @@ class Entry_section(Entry):
 
     def gen_entries(self):
         super().gen_entries()
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.gen_entries()
 
     def AddMissingProperties(self, have_image_pos):
@@ -263,7 +263,7 @@ class Entry_section(Entry):
         super().AddMissingProperties(have_image_pos)
         if self.compress != 'none':
             have_image_pos = False
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.AddMissingProperties(have_image_pos)
 
     def ObtainContents(self, fake_size=0, skip_entry=None):
@@ -329,7 +329,7 @@ class Entry_section(Entry):
         """
         section_data = bytearray()
 
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry_data = entry.GetData(required)
 
             # This can happen when this section is referenced from a collection
@@ -364,7 +364,7 @@ class Entry_section(Entry):
                 section_data += data
 
         self.Detail('GetData: %d entries, total size %#x' %
-                    (len(self._entries), len(section_data)))
+                    (len(self.GetEntries()), len(section_data)))
         return self.CompressData(section_data)
 
     def GetPaddedData(self, data=None):
@@ -425,7 +425,7 @@ class Entry_section(Entry):
     def ResetForPack(self):
         """Reset offset/size fields so that packing can be done again"""
         super().ResetForPack()
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.ResetForPack()
 
     def Pack(self, offset):
@@ -457,7 +457,7 @@ class Entry_section(Entry):
     def _extend_entries(self):
         """Extend any entries that are permitted to"""
         exp_entry = None
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             if exp_entry:
                 exp_entry.extend_to_limit(entry.offset)
                 exp_entry = None
@@ -468,8 +468,8 @@ class Entry_section(Entry):
 
     def _SortEntries(self):
         """Sort entries by offset"""
-        entries = sorted(self._entries.values(), key=lambda entry: entry.offset)
-        self._entries.clear()
+        entries = sorted(self.GetEntries().values(), key=lambda entry: entry.offset)
+        self.GetEntries().clear()
         for entry in entries:
             self._entries[entry._node.name] = entry
 
@@ -479,7 +479,7 @@ class Entry_section(Entry):
 
         offset = 0
         prev_name = 'None'
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.CheckEntries()
             if (entry.offset < self._skip_at_start or
                     entry.offset + entry.size > self._skip_at_start +
@@ -500,24 +500,24 @@ class Entry_section(Entry):
 
     def WriteSymbols(self, section):
         """Write symbol values into binary files for access at run time"""
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.WriteSymbols(self)
 
     def SetCalculatedProperties(self):
         super().SetCalculatedProperties()
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.SetCalculatedProperties()
 
     def SetImagePos(self, image_pos):
         super().SetImagePos(image_pos)
         if self.compress == 'none':
-            for entry in self._entries.values():
+            for entry in self.GetEntries().values():
                 entry.SetImagePos(image_pos + self.offset)
 
     def ProcessContents(self):
         sizes_ok_base = super(Entry_section, self).ProcessContents()
         sizes_ok = True
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             if not entry.ProcessContents():
                 sizes_ok = False
         return sizes_ok and sizes_ok_base
@@ -530,7 +530,7 @@ class Entry_section(Entry):
         """
         Entry.WriteMapLine(fd, indent, self.name, self.offset or 0,
                            self.size, self.image_pos)
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.WriteMap(fd, indent + 1)
 
     def GetEntries(self):
@@ -641,7 +641,7 @@ class Entry_section(Entry):
                 property which is not supported
         """
         if not entries:
-            entries = self._entries
+            entries = self.GetEntries()
         entry, entry_name, prop_name = self.LookupEntry(entries, sym_name, msg)
         if not entry:
             err = ("%s: Entry '%s' not found in list (%s)" %
@@ -687,7 +687,7 @@ class Entry_section(Entry):
         Returns:
             entry matching that type, or None if not found
         """
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             if entry.etype == etype:
                 return entry
         return None
@@ -780,7 +780,7 @@ class Entry_section(Entry):
             offset: New offset, or None to leave alone
             size: New size, or None to leave alone
         """
-        entry = self._entries.get(name)
+        entry = self.GetEntries().get(name)
         if not entry:
             self._Raise("Unable to set offset/size for unknown entry '%s'" %
                         name)
@@ -793,7 +793,7 @@ class Entry_section(Entry):
         This calls each entry's GetOffsets() method. If it returns a list
         of entries to update, it updates them.
         """
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             offset_dict = entry.GetOffsets()
             for name, info in offset_dict.items():
                 self._SetEntryOffsetSize(name, *info)
@@ -822,11 +822,11 @@ class Entry_section(Entry):
         """List the files in the section"""
         Entry.AddEntryInfo(entries, indent, self.name, self.etype, self.size,
                            self.image_pos, None, self.offset, self)
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.ListEntries(entries, indent + 1)
 
     def LoadData(self, decomp=True):
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             entry.LoadData(decomp)
         data = self.ReadData(decomp)
         self.contents_size = len(data)
diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index 7c6773ac7bcd2780b5bbe7b3cd6d7d62b38dfe77..a78c7ba14561072ff64ad64ebcbcbbe95d074859 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -227,16 +227,16 @@ class Entry_ti_board_config(Entry_section):
             self._binary_offset += t_bytes
             self._binary_offset += self._num_elems * struct.calcsize(self._fmt)
 
-            if 'board-cfg' in self._entries:
+            if 'board-cfg' in self.GetEntries():
                 self._add_boardcfg(BOARDCFG, self._entries['board-cfg']._cfg_data)
 
-            if 'sec-cfg' in self._entries:
+            if 'sec-cfg' in self.GetEntries():
                 self._add_boardcfg(BOARDCFG_SEC, self._entries['sec-cfg']._cfg_data)
 
-            if 'pm-cfg' in self._entries:
+            if 'pm-cfg' in self.GetEntries():
                 self._add_boardcfg(BOARDCFG_PM, self._entries['pm-cfg']._cfg_data)
 
-            if 'rm-cfg' in self._entries:
+            if 'rm-cfg' in self.GetEntries():
                 self._add_boardcfg(BOARDCFG_RM, self._entries['rm-cfg']._cfg_data)
 
             data = self._finalize()
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 52f0a729bdab0a0bd00f798bbc07d678dd4513de..3fccd4c8ef5f8757b54f3b3fe5fe7898fd166dcb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2198,7 +2198,7 @@ class TestFunctional(unittest.TestCase):
         image = control.images['image']
         entries = image.GetEntries()
         files = entries['files']
-        entries = files._entries
+        entries = files.GetEntries()
 
         orig = b''
         for i in range(1, 3):

-- 
2.43.0

