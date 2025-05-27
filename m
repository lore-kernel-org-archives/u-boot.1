Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F61BC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5B683092;
	Tue, 27 May 2025 15:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mtOAQKaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD063830AF; Tue, 27 May 2025 15:24:36 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192388301F
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3k7gJxvuwJh+z6dwOKNRracmPwnq50A54aSStzdmvixIo4vtQJpYqatdszxvnra6cdRKQKQIGExEhJkKUrtJ+oh51n9VMVu2lLEf7dNUuZ2EzvyPVb1VrMG9Zt/zotB3MiSMRUq7m5BwlvLTY2ufqcMj95hM5Guta2XYva9OmzDB3HATJDzECYX6zlMe5m/sU3mpi/aImh6L15oPXwDKdWi4+QRzBZ0thOx0bgYLx6mY638VJonI49XIplJ7zNd2vlLkK/I1UiFSHVO5X5zg9lUXL53G5VXO7qwuo+iyIppbvPpOBhACNLGTjL6EYQ0Ny8spyXZ8Dk0fsbD0NEaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozu81sJD3/3MlndZfF73GraL8FLWMrMa1OtrYZM5npc=;
 b=N9Xq1rXHxNX9SDsev0DTJpJHuPJB2+qlBwZa83S4d1tL/Qh0JUpd42eSNIXZ2+9wgfm6ejl+ZGwr7mfNEA0Mfkcz0Cx3/7Tdw0WGqYzfxw3Ge5hOp7NmWOx6Tca1FWta5wK9ltpbLfUB/ajGiR59iW6CCclJvZLcx2//LUlJej0OFbjPyTVWyF3D29ksx3wLSu6A9AwuZp4o0RhxUNyDIVGBTHGyduGHZXDJqAcfLKmsR8/TU+LtagDYBH11iSokQH7c4TGCq1kgXeA9suYSQ9TX3XpYaOzGylK0/O1FcmJzPSiHUMQ+Cyjv2eZYT1vaBZNtUj3bav6qdA4fQzZAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozu81sJD3/3MlndZfF73GraL8FLWMrMa1OtrYZM5npc=;
 b=mtOAQKaXuwxzpyZXRy29ii+ETIS7MW5fq2w5YsnxpNnTe2myrG9LSo+RXyyY8lnSnO8q8EQpXOUX+BAYGKKHEIqpKLXzi5kw8IYrxe/9iVsX3lvEaYdiVAufJ9aqhK8jFi6lvGYbN762zaW4EVI+SxJ9+WEjBxbUPNseJE9MVHpoXN9fuy/elOwRYBNI7ABg7POOI0ch5jMPVLkil+WP9kLTlvI0mWKdlEVu7xXw0+dBXZV0QGDRke5ZdhEiskDAHBg+o0h06uUwXHg/NsdGbn1vxTX/5wKHJQHZmfC9a4akTDHJ73y+1rByaQlmk5w2khcwKhrjhQhmqodAYOe4cw==
Received: from PR1P264CA0027.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::14)
 by PAWP195MB2630.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:46e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 13:24:32 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::14) by PR1P264CA0027.outlook.office365.com
 (2603:10a6:102:19f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Tue,
 27 May 2025 13:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:31 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:30 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:30 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH RFC v2 0/8] Fix handling of optional blobs in binman
Date: Tue, 27 May 2025 15:24:08 +0200
Message-ID: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPi8NWgC/3WNTQrCMBCFr1JmbSSNSYuuBMEDuJVSknRqBzUpS
 SiW0rsbiluX7+97C0QMhBFOxQIBJ4rkXRZiV4AdtHsgoy5rEFwoXgrBDLm3dm2vn9i1fky5r19
 M5bivuaxQKMjbMWBPn417h9v1Ak02B4rJh3n7msot+mGPf7BTyTjTUh2ksVVtjTmPw5zQ7juEZ
 l3XL0169ya/AAAA
X-Change-ID: 20250122-binman_faked_optional-5025f7046e25
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=3383;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=9K4bNHXvqncYya6QonhwGaM/cUXw4m6qfdyX78RWhq8=;
 b=IvRBPmb29A4nzNpXiFEk9hwFIn/3iYgUrRQKsvLMo3mXDvE5tmEUFF5lF3k0T7dxH3IXfc7Aa
 mVYfZ/Lsr8OCesrHu/5AENkJ5SbgCpNyflmTnllLDhomAL06NITf3dr
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|PAWP195MB2630:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf71d4f-6ce9-4771-2ee6-08dd9d21d059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3FTS0RNWVdxL2oySit4bDBTWVJIZ1I1c2Z2VSt6N2d3TWZSRjI4VGdCZGhZ?=
 =?utf-8?B?VEtKZFBhTnVGSEdyOTJPSkRkS3VkSE15M21hYStTNWJRSm9HWnlwYU8wZnFv?=
 =?utf-8?B?UG5iREwxdFdoRUdqYTJoczVQMUxtVU51NWo4Q0RPeXFzeGtybldpdndXSVky?=
 =?utf-8?B?YWsxd0RyVEZlZ1lsMksvejhmY3lVRFdPWFNoN01IdDZFL09GNFAxSkFkUWsw?=
 =?utf-8?B?elVRMklBSXVva3lYNnFOZ09kWmJoWlZyT2Nva3JjL1kvWWFFTzBrZDkrUEpi?=
 =?utf-8?B?YzJhdkdkSkM2anhIUXdoZy9iYndCcWJ4QTdnV2tlbGNXK0hyVGRCSmZVVVl2?=
 =?utf-8?B?bVAwS2dJRDVzZU9vVklTM0N6Wm9keHBjVzE0MnU3ZjkwcGdGTE9IMUN4OS9V?=
 =?utf-8?B?bHQ3eVAzTVlDREFhc2xzTC9uVm5nbFIzNDF4cExZVHNVaS84bUZ6ZVpnTUh1?=
 =?utf-8?B?K3NoRkZ3QlM4bnNHYkpyTUw4WldWRVRIclhhcUlPNmxYSEEwbDZ1THNNVC9t?=
 =?utf-8?B?WDA2QzhOeVBsZkdzUjNKaU03eTdtN3J4ZWdLUkJodHlEZmJGWEZQVUhkd0oz?=
 =?utf-8?B?aGluWUxFazU5cVVMWDF6REF1cFFFNTZRd2dGUWhhQzg0N2FiT29KVFQyNEpo?=
 =?utf-8?B?ZHJyT0E0a1NoZXg0NXlYVjdXd0lTMWpzWU1QTVJGdWNRUUJVTUVnZ2kwcXFL?=
 =?utf-8?B?cU5VSkRWWUEyVEpNQlZUZzJTcEtSUW5tSEpsWmxhdVFKZHhtaXZvaCtHTVlD?=
 =?utf-8?B?K3dhZjZCQ2NxUHNLRTVqNWdBNlJHeDZIZGNnbkRWNjl4YnBEdFpvZDd2M2NO?=
 =?utf-8?B?WUVCckdEdnc1b0dwWld0K3VHOURBcURscC9ydTZUOHhjdVdJenNSUE1vZGQ4?=
 =?utf-8?B?TjVOdlJ2T21reXR0VU5nMmxRZVQxQkw4cWhZeEJ6dk16VHNkR0VCUE1wQ1F3?=
 =?utf-8?B?UE9zWU8vT244UlR5WTZhVmxjUHNKOWsrTFhxWVFLOXd2aEVqam5HZi9TeGRn?=
 =?utf-8?B?N1dUbHlPRnF4cElWeEQxVzF6a2svRWsxTFFnUkw2Q0M4cEI5QmpUcVpSUy9x?=
 =?utf-8?B?SkN4ckYxR0svckpSbEY2VlBsWng1L0V6OGhGWklqTVBDWllmWVRVYWJnRmh5?=
 =?utf-8?B?M21tVVZlZUpHRkNRSllsb0M0YjhkNmt5MVB1RHVpMk40aGIxUTNPcSs2aVFH?=
 =?utf-8?B?RWhvWjEvbWxXbmRSS2pySjNRUGtGTmZHMTQrMmM1WVdERndEZExZeU5UcS9a?=
 =?utf-8?B?QUt4V2N2S2duSXNXd1lZY2kraHJ1cjIvc3BDeU1yVVhwNHZOT3lSQUpUaDZJ?=
 =?utf-8?B?Tys2NFNBeUd6S1JoUWE5T0pjRmRGT01zSll3MXJpbExBZ0FqaHF0UGI5SDFy?=
 =?utf-8?B?UXgwU0FMQ3FDVitYM25TTkdyY2NmTFJnUlJpREwzemVIQkRaeTAxTG1qc3Jr?=
 =?utf-8?B?YjV4VW10ZktwQ0VtVXVrenhDaFZBaUI3V0RpM2FqK1ZBMlBiZENMekw1NVJB?=
 =?utf-8?B?ZU9uU1gwZWo1VlJyNkF4d1NWcmExUmlmQXR4Q3BwVDR4Q0hPV3Exby8wdzNH?=
 =?utf-8?B?NWlVb1lsUVVrUHIxYmhMU084S1lFQkFzQnUvNGM2NDhuanEraEJYemlKY0I5?=
 =?utf-8?B?bVFDNjFkdTBDbjk4T1lYWFpsSG45U0pqNCtQbmFQOVVMbWFVZVNXWGhKWC9v?=
 =?utf-8?B?NXZOTDYzVG5ydWhNeUtyUEQ2MGF3TjhjUHZxV1F0dkhRbkcxd2ozeXZMZ0FQ?=
 =?utf-8?B?bVJrc0FLRHpMOTI4ZjV5MWpWTmRPVXhDcGNHMjZsamltQjc0dHdLdlA5bVVL?=
 =?utf-8?B?ZUU4V2R3bnpEMjdneW5WZGVUOGdCYVYrUi91ZklTL0dnSVcrOVYvaVZYc1ky?=
 =?utf-8?B?VmFKSnk5eXc1Rko4S0NLRXNLTFp6c3R6Q2sxTlJVNEtVVWNRb3h0SUl1OEJK?=
 =?utf-8?B?b3p3K0VwOVJRTzg1UEg0dWJ5bmk2R3o2RFY0cHZlVmV4UC9YUlYwTStuR3Zx?=
 =?utf-8?B?eU5SVVRqeEZGOXg5Rm1ja25KTzdGSFljZHZremJiWnVoM1o2dll3SGRuUVhj?=
 =?utf-8?B?WGMyaklXTmdkcU1neWs2ZG9tN1FIb0FoUWtGUT09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:31.1021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf71d4f-6ce9-4771-2ee6-08dd9d21d059
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2630
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

This series solves a contradiction regarding ext blobs packaged in
binman. When they are marked as optional, by default they are faked, two
messages are emitted. One says the image is not functional the other
says the image is still functional. Both concern the same binman
entry/blob.

Binman is set up to have fake external blobs in case they are missing.
This is regardless on whether they are optional or not.
The implementation does not allow different types of entries to override
the faking decision; at least there wouldn't be much sense in doing so.

Here is an example build output of a phycore-imx8mp:

  BINMAN  .binman_stamp
Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Image 'image' has faked optional external blobs and is still functional: tee.bin

  OFCHK   .config

The output will stay to inform/warn the user, but in this case the
tee-os entry will not be present in the final image.

The first patch makes binman test with --fake_ext_blobs by default to be
consistent with the default make target when building U-Boot. This
exposes an error as one test is failing where it should not (loadables).
Then, fix some tests that must not fake ext blobs and thus failed due to
the change.

---
Changes in v2:
- mark as RFC due to failing tests. In current state, series is more of
  a concept
- Link to v1: https://lore.kernel.org/r/20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de

---
Yannic Moog (8):
      tools: binman: ftest: pass allow_fake_blob to _DoReadFileDtb
      tools: binman: drop "faked" return value from check_fake_fname
      tools: binman: mark optional missing blobs as absent
      binman: replace _entries with GetEntries()
      binman: rework dropping absent entries from packaged image
      tools: binman: add faked optional entry case in CheckForProblems
      tools: binman: ftest: fix tests that require non-faked ext blobs
      binman: test: assert optional blobs don't cause non-functionality

 tools/binman/binman.rst               |  7 ++++
 tools/binman/control.py               | 27 +++++++++++----
 tools/binman/entry.py                 | 17 ++++++----
 tools/binman/etype/atf_fip.py         |  4 +--
 tools/binman/etype/blob.py            |  9 ++---
 tools/binman/etype/blob_ext_list.py   |  4 +--
 tools/binman/etype/blob_phase.py      |  4 +--
 tools/binman/etype/cbfs.py            | 15 +++++----
 tools/binman/etype/efi_capsule.py     |  2 +-
 tools/binman/etype/fit.py             |  4 +--
 tools/binman/etype/mkimage.py         |  6 ++--
 tools/binman/etype/nxp_imx8mcst.py    |  2 +-
 tools/binman/etype/nxp_imx8mimage.py  |  2 +-
 tools/binman/etype/section.py         | 62 ++++++++++++++++++++---------------
 tools/binman/etype/ti_board_config.py |  8 ++---
 tools/binman/ftest.py                 | 43 +++++++++++++++++-------
 tools/binman/image.py                 |  4 ++-
 17 files changed, 138 insertions(+), 82 deletions(-)
---
base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
change-id: 20250122-binman_faked_optional-5025f7046e25

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

