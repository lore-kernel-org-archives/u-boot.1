Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B3CAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 06:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9258323A;
	Thu, 18 Sep 2025 08:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DSy+bDUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A6280B9B; Thu, 18 Sep 2025 08:14:05 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::713])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5456F81E13
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 08:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2SKD46f/Qjqpw9MCdHwjKWCwOGD7csbVEGy9xQ3oH0UNCp9x5njNSqqGDJ8I/gop/OAVb806YXLaJ3t0T/OjhN5n+JSPfy28nA0J/D4Vihte6SRmG2Ydhpy69WyneaIityuOrBwHx1Iv/p/16dRk6JUDDWZhvwugeEe4Z/G/SkpVg2jxefNCgamEbfClQopkO8BHN0FLx1BXM5vZJh/UaCitnWBRQ3Dw7vYYE4FDDQG7/kPEpyc1hLJ9BDNHKjify/Dpm6gvQ4aYq5wdPXGAyLq+YWxDRMZtYGAC/RO8sjBDrBJfB12Edbaiagqv8zNTUdRVgtpgjVL0pMdy8GqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxEUOvE36WBDevTNfNxjVmR7gKYkaQDjJzV5UB9TRKI=;
 b=Bs4NaUK92AoVPoFt6DIqMQJBdvRdf2RkkQQNERDVDp+naIJegvaqbZUN3LifhRXdQi50g/DW0MvxcAlIanTOBja3GJvvLwS2Ful2O3Eq42O/QIMYKfRHxthdAvWrsN9heKd/RKXJKLQyY2vzvLrnTVqktdlC+ZfigIb7oLEqfHu2QYksrzTSQ9DFPwe35mRsGGO0NMhdM+gxGAyS+lyAI0lMj8vwkQpVm4WWKziC9tHvK1iP2+gOFz/D1QNCWvhEZmCMXFznG2COqMWHTPXWB1tqpAshshceVtK2ZzEBK4yTX2+rkseCdS77itlbqh86iTr20/uYpVK+PrLo+Jq/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxEUOvE36WBDevTNfNxjVmR7gKYkaQDjJzV5UB9TRKI=;
 b=DSy+bDUMDqyLWEWHYiL5LUHgWgPLdSBxDDWvxU1S2/T/0mLj/gf42A3mojULJmyTLYsKWc3g8P20da/QW+xegN77FaYgrlbrsP+fICIKFLQEi85sPTFK+b3CmBOQKS377Q4DCdGdZYSIEiD9MFRCRaTE7OhkP3bPhxNo6/c+QMS6M6LmveadpUdseBu0TsDmlGMkuNzaK6CaKkCfZhT4SYEoXGx7Xf76aSiRDPtEJWLu3rCtH9Luyd3QwM6hRhM0d4OLiqwlnmh+r5P5Zr2fW6cSTmjq5WvhY2jG3pfss2un148qh7YnO0xgcy1CVUrF0ONtw2VzXESXs6DWJUJzMw==
Received: from DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) by PA1P195MB3044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:4fe::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:13:59 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::6a) by DUZPR01CA0053.outlook.office365.com
 (2603:10a6:10:469::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 06:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 06:13:58 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Thu, 18 Sep
 2025 08:13:58 +0200
Received: from llp-moog.phytec.de (172.25.32.54) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 08:13:58 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v5 0/3] PHYTEC imx8m boards: enable OP-TEE as default
Date: Thu, 18 Sep 2025 08:13:54 +0200
Message-ID: <20250918-imx8m-optee-enable-v5-0-ecbe0b583b94@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKjy2gC/23NTQ6CMBCG4auYrq3pz5S2rryHcUHbqTRRIEAIx
 nB3Cy4khuX7JfPMm/TYJezJ+fAmHY6pT02dQx0PxFdlfUeaQm4imFBMS0bTczJP2rQDIsW6dA+
 kIQjjJFO80EjyYdthTNOKXm+5q9QPTfdaf4x8Wb+c4XKPGzll1LkYhYwMNKpLW70G9KeAZOFGs
 SVglxCZ8GBs0FaVyPQ/IX+EZWaXkJng4CIKsE764p+ALWF3CchEESKCBe+ttFtinucPynnjk30
 BAAA=
X-Change-ID: 20250730-imx8m-optee-enable-dd28b305167e
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758176038; l=2319;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=AWedgqYMRpJshCsLQRsmDbl0fud6X2S4FUEa7L4PTRU=;
 b=ex+ZwfTeCqNkq/0egVmNn4NGEZzF4b+m3o4EnsvIyy+DBJKkCdfW+JCnfx214QcFpQ4XNmkyK
 1Tj58SJ1lsTDIPeYGLVjetc91qFShL+0PttbXaHGAeJKoVh5m8QuoS4
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.54]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C1:EE_|PA1P195MB3044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9e8edb-455f-4ecc-3e10-08ddf67a8e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TitwM1hBZFhpY3VrTzlzYlJXelZlSFBWdFN1c3BqK2d3dzB4eUY0UE0yNlgy?=
 =?utf-8?B?a09xcm13NW50bW10VWI4SEJIR0pKZHBGWDc4M2gwcEgwQjlEY09jdnVrRVZW?=
 =?utf-8?B?L1ZZbVdUN2xUOVZwRTFqeldVYU02bkQ0NFdkRFpCTlFZRGNacVRpNW1OOVFi?=
 =?utf-8?B?UTNrTUpvRFQ5dFNuRmpRa0ZDYkkxc2x3dzFXRk9vV1hiTnF4d0tEcFZURWVt?=
 =?utf-8?B?SHd3bEs4ODVWMGhibUR5YVZ0V28xNTBXblJnTTFGemhOb3FLUEtQd2lqTW96?=
 =?utf-8?B?SXJhV0VsWUU3ZmN1SHN3UytWcEN0MEdGa2V1M0ZITjc4NStralAybi92K1k0?=
 =?utf-8?B?Z1ZZYThHbU9ZYVl6Q1d2bk5jc0Y1enRNaTlTQ3pQTVhVWUlTRmVDRUNiQ1E3?=
 =?utf-8?B?bkYwRzRldHRPbitjRVc3VStNZE5kNkphMVlGb2YwczF1cENrY1ByUkVlczNY?=
 =?utf-8?B?NkozTXFVdzZsbCtBNGFQMlFLUUZUOTFLWFpycFp1ZmxZQkFWQ0xoV2M2VTFJ?=
 =?utf-8?B?dWFheXBxT2Z2NUF0N25qaEIzNE1WVTR1VWxPQjN3b0xCYlpFK0x6NU40YlZP?=
 =?utf-8?B?NWxiZW5TNWV6a1Ridmk5MnlnU3FxMGRGbVBVMDBBTVNhRFg3NGZJNWV3Misy?=
 =?utf-8?B?bGNYMUp4b3pwaHcvaUw5WEtaNXV2Z1hFQTZsa0pXdThzb1BFdVZVcU1tSXJD?=
 =?utf-8?B?aGtpUlFYUnl4TTB3WDF2a0VkSnFwZkZzWXRDR0prdUJxWG9aNTdjMDE3b1lH?=
 =?utf-8?B?K0swUGNxOTdTMkVxeUJHQUpHRk1FYVB3clM1VmU0T0MvdFVQRlVadklXS2d6?=
 =?utf-8?B?QXltaGlzUFV1UjJaNHpLYWFOL25iOHJUamN4M0JQay9mbWcrZjZsQkVjMVVm?=
 =?utf-8?B?UmEwaWdYNnpZcWQ3RnZQVDlGRTVxaW9tL3R1ZVk2VU1jK3JhQTd0eWNKamZ4?=
 =?utf-8?B?SFdSeWErUU1rTXBGTC9kWnFZcGJuakJDOVh6eU54aExZenY3Znd2SWQ4Mlp4?=
 =?utf-8?B?RlI3MDJoOG1ScjJaM09RMEJhMGt6V0ljeGxPdVBYRVN3THRLOU4zZk10MENt?=
 =?utf-8?B?YVZ1SGJISmNqeXFIOGs1cXhhRStWNTY3cVgvanAyNnoybzRCVzJpb25rRmV4?=
 =?utf-8?B?N1ozbFlYQTFZeGw1VzVNblJEVVNJNElnbEl4c3lBT0ZicmU3NG5mbVc4ZUZu?=
 =?utf-8?B?c054OTZoN2JTOW5DV1RtbmJNMk0vYnVqeXNwTlJTK3lYNmV0UXFIVmZvb1B0?=
 =?utf-8?B?Y3NOQndEejZueG8zanM2RFJITWdtU2lEYkF3enJIUHpZOW5DZU0rdW10REJy?=
 =?utf-8?B?R3RCNkpvVnNJSXo1bnM1bFFCVG94R3ZnVzIrd2h2YUh4R2xnNUJ3dUhRLzZw?=
 =?utf-8?B?YVJnRW5pU2pHL1dKMERTcC9XMElQdGxsak1PN1ZqQXJFdlpwalFXblB4dUFo?=
 =?utf-8?B?eTlqZktXQkJKd05aTlVzVDVlY1ZKd2ZnRlIrL3pLSVFHaUZWN3h4L3lnTWFk?=
 =?utf-8?B?cW53YjJVdnNtWjZ6WGcwVGdrUmhlSi9lUUlKUy95eiszS1pSb2ZoUVVjTlpU?=
 =?utf-8?B?MHg3ejJlallKbzlCN0lJWDIrbmRNSytiaXFVNWJaa216cTdFOWxvdjJ4K1U1?=
 =?utf-8?B?Mjl4bVprZG1jNDN3eVFOZkJjcS96YlVKcXJ0UmVzVS9jN1U2RDhVZ09uaUFl?=
 =?utf-8?B?NEM0OHdYMHFkMGVSaE82WDEyQ2I3dkFuNHpZVHVPU0NYQUppRnBZTDNVQlpE?=
 =?utf-8?B?VW01WURqWHJmSXEwWEFBcit2K2Y1d2IyTFo5a0tMWFcvaUdCdlhuZStaS3ov?=
 =?utf-8?B?OVl2cTVqc2ZsMzdmMVY2NS9Pa3N5TUxUa2xrbXN6LzVHMXBPd1BQbnlkWWIv?=
 =?utf-8?B?NkFMUFBMMjdwaVZLUXlGc1pVS2lYUXRHaVd1K3hwN3NaMDlURGdrNHZlc25M?=
 =?utf-8?B?d2VRWXo2TnAySVNXYXdRTUtiUmtObDF5NG1UWU9iaTZRNUcwVTJId1BoL0Rz?=
 =?utf-8?B?TUwybzQrZ3JwVVh4SEhmSjJiK3IzWDZ0SjUrSWhhakRLanpQNFhTMUJ2K3kx?=
 =?utf-8?B?ajg0VG44L3c4SUNuUkRJbGxBclZnUmNuRGYrZz09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:13:58.9758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9e8edb-455f-4ecc-3e10-08ddf67a8e4f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P195MB3044
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

OPTEE config was unset by default and the doc for the boards was not
quite accurate as TEE configs must be enabled first in order to be able
to build with OP-TEE support.
This series enables the config by default, i.e. when wanting to build
without OP-TEE now, configs need to be modified.
Update and clean up the documentation:
Change instructions on how to build bootable image with the new OP-TEE
related changes.

---
Changes in v5:
- remove OP-TEE benchmark cfg from board docs (2nd attempt)
- Link to v4: https://lore.kernel.org/r/20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de

Changes in v4:
- rebase onto next (to get imx8mp-libra)
- remove OP-TEE benchmark cfg from board docs
- Link to v3: https://lore.kernel.org/r/20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de

Changes in v3:
- extract doc style changes into separate commit
- fix commit message -> phycore-imx8mm sets OP-TEE at end of 1GiB ram
- Link to v2: https://lore.kernel.org/r/20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de

Changes in v2:
- Use proper board PLATFORM for OP-TEE since boards have been merged to
  master on optee_os (https://github.com/OP-TEE/optee_os/pull/7487)
- add -j $(nproc) to make commands
- Link to v1: https://lore.kernel.org/r/20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de

---
Yannic Moog (3):
      phytec-imx8m boards: enable OP-TEE for KASLR
      doc: phytec: update imx8m docs for optee builds
      doc: phytec: imx8m: Style and firmware update

 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 configs/imx8mm-phygate-tauri-l_defconfig    |  5 +++-
 configs/phycore-imx8mm_defconfig            |  5 +++-
 configs/phycore-imx8mp_defconfig            |  4 +++
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ---------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 41 ++++++++++++++++++---------
 doc/board/phytec/imx8mp-libra-fpsc.rst      |  1 -
 doc/board/phytec/phycore-imx8mm.rst         | 42 ++++++++++++++++++---------
 doc/board/phytec/phycore-imx8mp.rst         | 44 +++++++++++++++--------------
 9 files changed, 90 insertions(+), 67 deletions(-)
---
base-commit: 28d6f787b0deb3f66118857297a855233eba18d1
change-id: 20250730-imx8m-optee-enable-dd28b305167e

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

