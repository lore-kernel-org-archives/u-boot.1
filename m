Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A67FCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 12:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61856838F3;
	Thu, 14 Aug 2025 14:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XsVs9gUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D938390D; Thu, 14 Aug 2025 14:08:45 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45ADF838C5
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnR4c/m1pnGQTdQO2UHnZoeffWP3M6vUGqaJnYQPEBgPjue8mJYT4394/8S+EI3SB8tAFH9iNwcTjqkvrlZGG2VGsl32TuC1uG8Pm3eYlwVDcNbCSawILScSIm0pnYbX79SqwD+/YHe1shvF4IADu2fOWAKecXHYkwLOwIwFUYIJD4L1Ak5jK9UWEGCtZ6+RayO6Ef0IAr/6ntq8AtiAX8XKmkBn4QqDKnQvSZ2b6kLfgEDCywyLd5ODC31Ndf8eq7bih74DCQN+/dSG+DGuNNEUI4wKZuBVsU8uBu8bGGYJLVTzr5Ox/J6erES3+rks/9SghH+mGpZC6dTjKzrFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkG0H75RxYe/O0CqpNx1vywUpRDMEjYCE3aq6KILO18=;
 b=aN7wft0xkU/Tk7yEz0pR8ClfNfIXe08KSZQ0+BIX1Nmx4icAqlc/DydVjgRHDJKFZe4uCchONA5TuJA5onnckmfBD7GVkpRnqQhQVRujh/o9fg1SgcwL+Wgf4c8YZbaq8MsnObTWglZT2BP1sjV39zW9iPBdFp18/T3w77D6ZP8wKpZEHs5gZk6BOwOZwxSwv+9JGC4CjUDXyibqHKqX2d/XnX/lJkaYQwZb/8sWNvNL6zRXTz+As6j6G5wNF/UM+q3OusUMbhz6cAvxaANlPZ3aJ+M+huPIH0X23ISw66o6VR6oucSdJV0yuPixi0f/k2WNkiYg8YhJ1uWjSTE94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkG0H75RxYe/O0CqpNx1vywUpRDMEjYCE3aq6KILO18=;
 b=XsVs9gUOtTPceCQ4PqIor4QWPTjmu0ACL2ESQ5zKR2s0FbnApWKC5SP9mXeC6YSB1SsWbEMJoKTqYy3fn+xCwQRnRMLFUZtbNdTWCVHCwrSvL+oI6IUBnfYl9qBipzFZJe3Rb0a3su66/U1xHpSqItCUGtrcoWlvz98q+NVY2SMnLoKunIXxgNqeC9IcBIPjTVWtxspvS56aqM2uHpPMMrfP2LRhYXsNhvGUB0WQUtk8V7pZ6F8CsIgpNfipUcv/5PDH6SswN2QP0gL0Q43IczdpSI/9tc0BsymlE/eEhuLNSzFx5SUt5MmdNa8xfvSv3cDGH4laRt6WEwUHfvNEJw==
Received: from AS4P192CA0029.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::14)
 by AS8P195MB1286.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3cc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 12:08:40 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::8b) by AS4P192CA0029.outlook.office365.com
 (2603:10a6:20b:5e1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 12:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 12:08:40 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 14 Aug
 2025 14:08:39 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 14 Aug
 2025 14:08:39 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/2] PHYTEC imx8m boards: enable OP-TEE as default
Date: Thu, 14 Aug 2025 14:05:39 +0200
Message-ID: <20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPRnWgC/22NywqDMBBFf0Vm3Sl51Ea68j+KC2MmzUB9kIgo4
 r83tdsuz4F77g6JIlOCR7FDpIUTj0MGdSmgC+3wImSXGZRQpTBaIPdr1eM4zURIQ2vfhM6pymp
 RyrshyMMpkuf1jD6bzIHTPMbt/Fjk1/5yldT/cotEgdZ6r7QXN0NlPYVtpu7qCJrjOD7N9jQ4t
 AAAAA==
X-Change-ID: 20250730-imx8m-optee-enable-dd28b305167e
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755173319; l=1599;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=RCrFNooy8c1q00g53+EDMbxidclnprMYVwDwHXn+DfM=;
 b=rPjUjh41RrkhJLT66f1MEYUXMwcDoqMPJJ1Vla9eKe+InTu0v/T9liNf0/O3AIKwmnOiF55UA
 14Qhxe7GC7SBPvrv9QcPddvXXbDoo2ZliQ5894FGkoDi54Xil8HzM9t
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|AS8P195MB1286:EE_
X-MS-Office365-Filtering-Correlation-Id: 752e9aa4-8709-44f9-8326-08dddb2b4e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUM4enA2OWJ2MWJWQlovVytxMXU2bVZxL3ViYnB4NFJ3SmUyM2Y0dERKdisz?=
 =?utf-8?B?M3lvT3g1L2xzWmZpK1VwNU9qZkxBanFTZkZvT2ZLNFFlRmJhaDVDdzZ6aVJX?=
 =?utf-8?B?ZTdhcGxyT2puQVpJTXM2aWVCK3krS2ZaQW5MZVNrc2tuT1VmT0RvMmZhVDBJ?=
 =?utf-8?B?RERhRFNTaHEvVWx0dW5tZVZyampmRHFSY2lpOHhweXdLNDRnVitIeWExaFdO?=
 =?utf-8?B?RzFzN1dpRnMvVEdUYXEveklJSUFtQ21acTJsUDNDVFh6RGFweDMyNUVFbTBX?=
 =?utf-8?B?dHh2R0Q0ZklhLzdLa2xxL2RTV3d4bHhOcE9UdUQ0ZFd3U2RyNmp4SHlqWGQ5?=
 =?utf-8?B?Sy85bnI1Wmh5ZzZEc2prWHg0bHVCeTFpWXpZWGdodlhzb2dtaVdYNHByNk1i?=
 =?utf-8?B?R29paXdBd2wrV1NXdXRhck01NE9QOGFnMkVna3dab01sWmRMeXNmS3lybWJw?=
 =?utf-8?B?UGcrUEt1dndRRncvbWFCZGRqS2xlRTdlOStEVVNlMWpwUnpua1RoN0xRcmNN?=
 =?utf-8?B?ckczanl1bDgvVUFHdnlSWU9mYnpGN2tsM1VqdDFWTXNTaVk1ZUtTMGRnbUNy?=
 =?utf-8?B?dnk2dkhoNnNoQ2tqM1ZBQVBhbG5VNmpmTklUWkhERTVlQUNoSmIrcjFZbk02?=
 =?utf-8?B?aE1VSEpTUkJGVmNldTVkaVNuZDJVbXBESS9yY2hXWk0rVFFBc3VmT3Q0K0Fm?=
 =?utf-8?B?MHRsZjJFejJQY1hnZzI3b2RhN2xJM3VQT1pTeEdyV1ZjQ0lyTlRmdkd2Yldu?=
 =?utf-8?B?UTYwOFo2QU41KysxWHFhSkFERmN6WjZOREdSaVduc1JXcVk0aGd6SFNDdFZj?=
 =?utf-8?B?c2pqdThJTmdOdHA5QmJSbEZhWHpYd0oya2NQbnRNaVZzS2hXOHdEbzdCNHpt?=
 =?utf-8?B?eWFIYytJekR6ay9BTE1kQWlTUHhYUSs3UUg4NUQ5clRFdDhXNmZmVVRvUDhE?=
 =?utf-8?B?TkxIK3c4a05RQUozcnlSSzQxb292SmIyRnVRaVEzT2o5eXlFQWtLL1c5QjM0?=
 =?utf-8?B?WjR1aTFKOGlIN2VkdUNIQzZlcWVnOUU0L0liTEk1WXVlNVd2bG1HUEtkS3Fh?=
 =?utf-8?B?ME5qc3JJL2xvM3pmdmNXc2owWUpjOWFQNHJkV2hNbkZ4YVdQSXJaVEI5RzUz?=
 =?utf-8?B?UlFKV2wrekRldGVXdGQ1OHNmZXMyZFN2OHh4d3k5a0dnSU5Gb2tpN0t5dm1s?=
 =?utf-8?B?dm5RaHpRSTNOdUNvNHV2VGZrU3RnYlo0NTBBaEMxemc2elVDV2kzSEdlUmFH?=
 =?utf-8?B?c3RkaGNIUlgyaHB4bUJmeXE4N0h0R3JVS1BrK3dlK0tnMGhKS1FIQkZUeUxH?=
 =?utf-8?B?WXRCbW53dEg1QmdrdE9uWXBaQ2NVUzhWdXhINUxwNTBHRjFDeTMyYWJNTksy?=
 =?utf-8?B?TWVXc3RHa0ErcTl6L1JOYys3ZEl2ZVRFWnJOSUplSGJqSkhpZHpoTHJQM3VP?=
 =?utf-8?B?VWhleFN1emZQUDBHSTU1Q2ZGclZKTWxQMGNLUFAyTTAraUtDRm9wT2dtWU1u?=
 =?utf-8?B?RVoweEhSYU1kbUI2cGRRK21EUnZaR2pBNXptS3d5ZWd3eXV3bWtSZmoxeUhx?=
 =?utf-8?B?MzR4UGlrNkxYd2R3b3REZU1xYVZLYjV1N0N6L1NEeUhkalpDSXdLMEdVUDlw?=
 =?utf-8?B?a2FZSENEdFVnZUF1R1pub0xFVTFlRlpMeUlCVzkzZzQ3WERMSndRUUY1Z1Bv?=
 =?utf-8?B?bTlMUUxCWWJhQUpXTFpWbmhjblROajRNYUhPNmhmRjhaRHViaXJteGN3ekdo?=
 =?utf-8?B?bDcwNkNsTTZnVTUvWHNmejhPRGU0b0R4MkxYeWFtUW15UkowZXRJVVJNNmEz?=
 =?utf-8?B?b1U5OE9vMTJnS2IwY2h1YU5sMUFqNkxDd0hJZEp0WXFaZEZ1M2VZZmhudUhN?=
 =?utf-8?B?Y08rOERnaW10UWEzYm9CbUhLMzhyUFl4azRIekZlZU5XeDFGbmVRTFVHY1Vm?=
 =?utf-8?B?dDlkM0JqOVVNd21pR0trR2tOaGthbGtGRmdja1J5ZmVEQmpVL2NjVkVMTkI0?=
 =?utf-8?B?cU9CUHJrOVJ5dk9nbHRSWTZ4cnVVTThwVktKVWZ2M0xKQmFGanBPSjk2aFJ1?=
 =?utf-8?B?eUl4b0NrVDNaRFB0ZnhxQm03a0djWi9IN1RMZz09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:08:40.1587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752e9aa4-8709-44f9-8326-08dddb2b4e68
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1286
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
Changes in v2:
- Use proper board PLATFORM for OP-TEE since boards have been merged to
  master on optee_os (https://github.com/OP-TEE/optee_os/pull/7487)
- add -j $(nproc) to make commands
- Link to v1: https://lore.kernel.org/r/20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de

---
Yannic Moog (2):
      phytec-imx8m boards: enable OP-TEE for KASLR
      doc: phytec: update imx8m docs for optee builds

 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 configs/imx8mm-phygate-tauri-l_defconfig    |  5 +++-
 configs/phycore-imx8mm_defconfig            |  5 +++-
 configs/phycore-imx8mp_defconfig            |  4 +++
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ----------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 42 ++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mm.rst         | 43 +++++++++++++++++++----------
 doc/board/phytec/phycore-imx8mp.rst         | 41 ++++++++++++++-------------
 8 files changed, 91 insertions(+), 64 deletions(-)
---
base-commit: b6e2cfca1a6fd10c8f12016a40d690d2ec61796c
change-id: 20250730-imx8m-optee-enable-dd28b305167e

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

