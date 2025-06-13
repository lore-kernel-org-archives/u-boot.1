Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5709CC61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6468F82D17;
	Fri, 13 Jun 2025 14:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UkzyvweM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C8582C84; Fri, 13 Jun 2025 14:03:26 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21BB807B1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeV+3mOGKh7AJtgowppM5G2cWDQW6jsE5uhYnR9QLtL+t8Hv03KNITVRa4pscr07wBi9ihNusj+it8mhclH3hKc+aXrxBalx8R2aZjdJglKIAxtONwrzU8mA0vahYytV8ORfzVa5rUxkdcURON4o6/9/0IrQGNMfK+HIscqbuyDtkFm4QodO3XN55y1r2G52SpT0qv555lbiaYcWHoEgKLmQjqIfoH3ZbMuXFEHepwcW3G7EhVxUOyZafeXfUGCJad4FWWoCe+ath+g3ndjxCS1I7vYRfZzQlULsmTFxwQLmOcrwAopCGcEiWd2GeLbvegxZ+JJcxTD03mzN/u5F1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CzKRlKJSqMDCbF1HZGYtWrNjDDcotLLIwm1k30VYwA=;
 b=iL93QkmboPtXYkvWrOf/KLzdajMxT8nC0GKVMhKlDjQMO5bSsCJ07CBo9UsAM9zTJg4fQJrGxJJbp/mNFB+BdR5SMFuGp1V3wuhyEFl401E7bCU0OCSzDH2sMp8IBg7G5ePyR3TUYXSW9LOVdzH+NC+NMzUJ/0h6r6S76gtlY+nrloJC6I+9IZFTEd4ddKD7Qv9DA3UFgjS7ZCBl8YLt3+zcjT6TmPnrR0k8bicHM98zvBFg3hKf9HxBBUew7jq2ZcyWP3oxM+RdTpi1JKU8pTpytWSvH4cAJ9zOBdovrLWJJPpSxcNTMTCRbSaz0d4d6Q5+7nwY2ZYGH4EhM1rouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CzKRlKJSqMDCbF1HZGYtWrNjDDcotLLIwm1k30VYwA=;
 b=UkzyvweMURAfly3YX0uSyh8Gm3z4wlTZsjgq7OVLWHKt3jKT0N+Xxe5SWVwaAdgl9sELpFIHSaRYzsFofJvBE+8yUaNMm820Pn71G4+GlRXKN3YaNgJV8BnQYQw6AekYp6I6II6kWfCYGrcWAcisqBlaznOc9c3Ayg4o3c6GrS/SgT1HuOczy9w0zOev5dqfsORRgRdhmGxbEhWwQVZKWicY7IUjcGrXjV8YMj2RuoGD7IAwOcj/nVM3ZbH68gxv7/H4FlTZnsM4JrP3wCLQ4W6x5t/tZGBzw7loYa3gmDDEHaLwzvEyXkxJmebHEKG6ij1BtqajLyPXb3m6YzJHBg==
Received: from AM0PR06CA0121.eurprd06.prod.outlook.com (2603:10a6:208:ab::26)
 by GV1P195MB2103.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 12:03:17 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::9c) by AM0PR06CA0121.outlook.office365.com
 (2603:10a6:208:ab::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 12:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 12:03:16 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:16 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v3 0/6] Fix handling of optional blobs in binman
Date: Fri, 13 Jun 2025 14:02:39 +0200
Message-ID: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF8TTGgC/3XNQQ6CMBAF0KuYrq1pp5SCK+9hDGnLII1aCCWNh
 HB3C4nRDcs/8+fNTAIODgM5H2YyYHTBdT4FcTwQ22p/R+rqlAkwkIwDUOP8S/uq0Q+sq64fU18
 /qUzrRrEsR5Ak3fYDNu69uddbyq0LYzdM25vI1+lXLHfEyCmjOpMiMzZX1phL304j2lONZBUj/
 BQJak+BpAiRgzZFqWTB/5VlWT48NmUDAAEAAA==
X-Change-ID: 20250122-binman_faked_optional-5025f7046e25
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749816196; l=3102;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=sXP9S1KnHjvw37SIYuJskE5jGpOhWUD+eH0poVVdQGM=;
 b=uQsPVMfJu5DKoNU2Q8VrZ/MNpGFV83DUGUcobEXITkz6561hS/eIizJTnWZX1fQmbUu7cKPC+
 ktyg8Cst1iEDhE9T7nfOyjNE+kaLbQfivzjbH1Y333IEyypTGcz//J/
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|GV1P195MB2103:EE_
X-MS-Office365-Filtering-Correlation-Id: f95eea5e-06f9-4275-19f5-08ddaa724828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2xtZ2NqSXJtdlpxTE9ENDE3N2Q4bkFlTG1zajlvUG8zQTUrQU5nNnJGWDNo?=
 =?utf-8?B?Nys2c0piaDlad1Q0cklYUmFMcGxuZ05OeXZhdjVyVEpsd3crT0o0VTVMWXNy?=
 =?utf-8?B?TGtZa3VucjZuSm81ODFCbnJJR3p3dGJTdXNoRjY3RVhBNkRmWHk5UzJ3MVVi?=
 =?utf-8?B?VWZ4NWxITjE4amFRZlBYT1FFa2hKbk9hVGV2YWVzMmZCVTMrM0RqVW8ySTds?=
 =?utf-8?B?VUJCSDhTTnU0VzVTZlBaem5PTHpyQncxbkF0K0JMQXJPZ2dvSUVZazBpaXRV?=
 =?utf-8?B?bDhSVy9ka1hUb0ZWWFVrY2FRMXQwSXgzUE5QNDErUzkzenU4TkZ5T054cnc1?=
 =?utf-8?B?NlozTno5K1owSGMrV2lCNlR0bkEzTnRqcC80NUVBRnJGQ1lBemh3Y0YyNkhM?=
 =?utf-8?B?Y1gvREV5dUJGUEFjQ2ZpWi9HR3ZuaEtacWtFeXN1YnhpM2IyNkk3N1paTGUv?=
 =?utf-8?B?dWJ6UFlxU21BNUx4bnh1ZE5hanhGbE81TE8wYnNpVG9xSzUvUVhYZHNaSER2?=
 =?utf-8?B?aDcvelFRVUsyM0d6U1lWVXl0YitRdjZwNWF3L2k0aVoyUkVVWERjUFlwQXJq?=
 =?utf-8?B?aFNHQ3BlMmE2cGdWeUFxMjBtT3VNeURaTmxyQnV5ZURXMTYxT0taTTJNZzZ5?=
 =?utf-8?B?ZzJUWFQzcGJGT3ZuNkFyVVE3ZFhHTi9EQlNuVElLNG9jOExCayt5ZlBmdm1Y?=
 =?utf-8?B?TmkvUlZyTkppdEJncmZtU1BxNGVValoxcG1xUzNEUFJiMVNHR3N6L2M1VHYy?=
 =?utf-8?B?TGQ4aGJ5RjlnV2lVRktyL1BhcVlDbU9Jem54RWE2OERPRlJuQkthTGVWVjU5?=
 =?utf-8?B?SVdTRTZCbEo3cDRxY0k0RmVWSTdlVnh6TDV4VG1hbC83L3hQcUhDL1VlQjJs?=
 =?utf-8?B?US9laWVLVU4xTmlydHBrd0xscHJzdjdLTlAzakVXcUg1ZDRWMzhiZ2J0cUN5?=
 =?utf-8?B?Y1U0bWVVTmhrRTFTSzlodmsya2gyU2RQbkRiSDRYMU96ZFJNUGdrQjdSMXRk?=
 =?utf-8?B?Q1crYVBQWEhVRzFRU2U2c1h4dUdaZzhFRG85LzBnNG83N2s5TVY1ZmtTMHRR?=
 =?utf-8?B?RkRJZlduS2JsMksrNndKNEliUnBscGdYU1RVUlBHM2E2L0k0RzNvM0pwVW8r?=
 =?utf-8?B?bk8wTzE1bWlSekxIVm4vQkNxSXBBQmxGQWk0RWc1bkljem5BbldSUjFiakQ3?=
 =?utf-8?B?RUp6Z2dESUlwT0ZDaHNNTEdia0dYWXpYcmFBZXFwS21vVUZVcWhEYS9NZ1Jv?=
 =?utf-8?B?bm4xUDdjalJEWWlIYW4xck9WY3J6dk1yRzNjRllaZnpaZkw2dGRhYURpaVlD?=
 =?utf-8?B?dFA4MGFiakVFWnNsbTBZRm51dVVBOXRnWDNjakRqUmdlTWJ4eW80VkUwT212?=
 =?utf-8?B?QkJRMHVaeW4rRjFpS3NXdzBGeVpwVm8vbldRQnptM1pxbUcrTk01UkhCNnZB?=
 =?utf-8?B?UUtlV0llU2xSa3o4bzIvM3ExQ0JUemN2ZDFWaEVVNnhGd05sRWtkeG5hSW1B?=
 =?utf-8?B?YnRkU2NoKzgrQnNiQmhzSlc1dTJzVUMwUThGRk9YK1RtdkxkY0hVeUxxSXFl?=
 =?utf-8?B?aXlXVWNUcEVXZ3VxRk1kMUhhVVFFaHgvck9GSmszUWc2V2g4RHNxSzQ4TlBU?=
 =?utf-8?B?SzdLd3lyTWM0bDM3eTZkaFRMT1R3SFJ6eXFnNVhoYy9nZktqZ1VuV3l0WnV1?=
 =?utf-8?B?RWtFbUJ0RkZnS20yd1hoczQyeFNIQk9RUjhSMVYyZiszN2VtZXdNQ3JNeXhh?=
 =?utf-8?B?K1VtK0FIdXF1M2gvUzhZSFdNZ3FjdlAyS3BTcUZxWFU1bmx4cTFndlhFWWFh?=
 =?utf-8?B?NzhZb1BNVHVTQ2xMUGxUWWoxVEo4T1oyZ0hYYVJJVzB0ZDd0SzVHaXJsOVVY?=
 =?utf-8?B?bnVjcjdSVGJGK1BKa0hwN3ZPd3doeDA4SS8wUmZ0dlRpTHUzN24vUCtOS3Zl?=
 =?utf-8?B?V2FTa2FuQVgrc0RIN3hwVHNCZGlUZ2xhU3ZTWjZ0K1c4dDlVUDNIaWVKQ3ZM?=
 =?utf-8?B?R09aNXR0ZVBvLzU4aEkyUiswL2FONzVXbFBBdCswS0x2eUJyNmRUTnlUazRD?=
 =?utf-8?B?M3p5KzcrY3oyeFVUUC9QVi9qcSs0TEduQmFjUT09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:03:16.9538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95eea5e-06f9-4275-19f5-08ddaa724828
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2103
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

The output stays to inform/warn the user, but in this case the tee-os
entry will not be present in the final image.

---
Changes in v3:
- Fix all failing tests
  - add commit that reworks bin.elf test
  - add section data to failing tests. E.g. tee-os contains missing
    tee.bin, but is still included in the image.
- remove _entries -> GetEntries() refactor patch
- reorder commits -> smaller fixes before refactor EDITME: use bulletpoints and terse descriptions.
- squash commits so that for each commits all binman tests should pass now
- rebase on next
- Link to v2: https://lore.kernel.org/r/20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de

Changes in v2:
- mark as RFC due to failing tests. In current state, series is more of
  a concept
- Link to v1: https://lore.kernel.org/r/20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de

---
Yannic Moog (6):
      binman: drop "faked" return value from check_fake_fname
      binman: mark optional missing blobs as absent
      binman: rework dropping absent entries from packaged image
      binman: add faked optional entry case in CheckForProblems
      binman: ftest: pass allow_fake_blob to _DoReadFileDtb
      binman: test: assert optional blobs don't cause non-functionality

 tools/binman/binman.rst             |  7 +++++
 tools/binman/control.py             | 30 ++++++++++++++++-----
 tools/binman/entry.py               | 17 +++++++-----
 tools/binman/etype/blob.py          |  9 ++++---
 tools/binman/etype/blob_ext_list.py |  4 +--
 tools/binman/etype/cbfs.py          |  3 ++-
 tools/binman/etype/mkimage.py       |  2 +-
 tools/binman/etype/section.py       | 16 ++++++++---
 tools/binman/ftest.py               | 54 +++++++++++++++++++++++++------------
 tools/binman/image.py               |  2 ++
 10 files changed, 102 insertions(+), 42 deletions(-)
---
base-commit: 548d997229b7929bd7f0782415952d5a85eb7e64
change-id: 20250122-binman_faked_optional-5025f7046e25

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

