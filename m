Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC32CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855B4830B4;
	Tue,  9 Sep 2025 16:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="O3SqDWuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841D983214; Tue,  9 Sep 2025 16:06:26 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D058309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQTdgc20733HrRXNl+ph3F9ZFQ/hwgQWOWz4iYxJMapodjXXOGEXb32weCQUAmAqjNSVd1h2I/ouWqHGvgCnWdqCfip6RPOvQj4dMc/W6+Rpcvz5ZOLcThtDqOBPBbbQw1+tBUJGOeifg/awkvrkxXGUfhi8vpdlMq5xgiU5URMx+TfXnyZmr5Pu/zSvbfHffz5m4XYYaBnTLUG5AIzvhpTdvDCOI1Y9QsrxILBE7gx1RlK1fQFeAYztOefpKfzcu8sWtaGxR8gIrpq2kVLXP3/ka9VKYq8ttcuh5O2/eky4QYn/pe9avlYEJfHxN7wJZQCWJ2FK9X111gddEPTHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydm1doN89B8UIGoWxy9iDsX4WGLUuSnfJSVGnRGq/XU=;
 b=T87qhFXUySFIIgzkxQ57Zmckh088HesMlBq+dbc6nafY2Gyrio8w/kKsJ1tIvQwco8RyTWu2wi5UoK5trTVUsCwq5f8dp5y4kpxm+zkVwr6k48t/RVeAxHLn10EVQc+IDf1OnAvxnJj0Xl+1Ea2UuGdLNDLx1Kxzxb75O4umbWK1MX63cYiMdR+iimj3MhRGOJ93UmDo4PoBQO21XGlh9hTJ3VvMU9WnXCxE8S2XddrQpQ9jpJtWYrNOvA6MuxGeCVSuDTwU3Q4r/Sh0o0bTthnl6iThHyXFNcweeSZ1/qcJ8h3wYJyJM4yNCHzdHWc+hjCzIBgmfHs3VeZnbG3jVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydm1doN89B8UIGoWxy9iDsX4WGLUuSnfJSVGnRGq/XU=;
 b=O3SqDWuBzCP+pnK3IgtdoPuLg308R/o6yIiLYSIhw2AOpbMEiFA2mRkfQOml1wfcL/1Yo+YaWdaF5CF8BkqlHs6YK+oj2KleXDQzrFciodGuHBczO/qMQId0eK2Ba42mVb55dEf7QkLM/sJEC+UOwv4Q9j/mP2TSSufkci15dJbTkL642x3pQYog6hT2c+N0SW3vA5sADkP94dPlQZs+TOKDafaKp/xxdc/Rt9IKtQnHcWP1vBqMjHN7Kb9hISnkEIlUNH4HKXnLYhelfo4EyI4HAiNXgxH15/IVtgnevgLv7MI75iFiRc39zW7Wxkg4eiGLgPT1sts93iuYlTKrmw==
Received: from AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31)
 by AS8P195MB1334.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3c8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:06:11 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::7c) by AM0PR07CA0018.outlook.office365.com
 (2603:10a6:208:ac::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 14:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 14:06:11 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:11 +0200
Received: from [192.168.2.142] (172.25.39.168) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:10 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v4 0/3] PHYTEC imx8m boards: enable OP-TEE as default
Date: Tue, 9 Sep 2025 16:05:38 +0200
Message-ID: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADI0wGgC/23NSwqDMBSF4a1Ixk3J08SOuo/SgUluaqA+iCKKu
 PdGO6gUh/+B+90F9RAD9OiWLSjCGPrQNinEJUO2KpsX4OBSI0aYJIoTHOpJ17jtBgAMTWnegJ1
 j2nAiaa4ApcMugg/Tjj6eqavQD22c9x8j3dYvpyk/40aKCTbGe8Y9EQrkvavmAezVAdq4kR0Jc
 UqwRFihC6cKWQJR/wT/EQXRpwRPBBXGAxOF4TY/Euu6fgAx1MKFOgEAAA==
X-Change-ID: 20250730-imx8m-optee-enable-dd28b305167e
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757426770; l=2144;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=gnBknDE1xYPRMpED3PMwU0a0wLsZRD0blVmKkH5hFEU=;
 b=YXD9+xrXYsBxw5I16iYb+3CvnEjdXnL+YFWToNmfRK/0S/B6Hem0VXQqGAEdvcNLaep+ukxQX
 obyaG1G36BSDrGwothNUcMK3e4c1KYGXxTdR1nNzn52/hkDzizG1mDm
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.39.168]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|AS8P195MB1334:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deea20f-013e-4781-e75d-08ddefaa0801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1gxN0RRK2pwSlFYZEZHMGk2elRNNXoyZGpEYllvSHdZazF4dSt6NFhiMUl4?=
 =?utf-8?B?TXc1M3hZVVgvajBldW1jUnZwUHVxcnRlS1JJTCtRUmp3VzkzVlRaRjlsNU54?=
 =?utf-8?B?UGNHMGtnajdUaVEvTFUralhRY1lTMStYV2J2OHJXZzB0Tlg5ZnNPRDZHRjVi?=
 =?utf-8?B?NEMyNmlROWhUWXUyOFowdFZPb1J0NmdOMGwxQ0tIbEdRVzVJYnh5ZVBKMFRO?=
 =?utf-8?B?aEdEK3Q1WjZJTndDb3pKV3VFM09BSTJ2elc2WkdlK3puTWhyOFQySkRuVGdy?=
 =?utf-8?B?Rzd0L0VsNGY2bnlyeVYxcDdpTytrZDBZL2FmQ1Y5SHkxaFJEeGJHQkNyV1k2?=
 =?utf-8?B?M0o3WHlBSzlLWmErbWJLSkRTNTFkekI1ci9pRk1QVFcyT1RxdDVHZzlWSUFT?=
 =?utf-8?B?MENEcTFWbmFycVhVbFdVSEg5T3hJcXNIUTBPYStLS1RjdzhuRFgzTlN5bVIy?=
 =?utf-8?B?SndpN1VVSW1jOTFXR0IyT1AycURvQ1l5VUZJR0N1UzRDVkRsblRoUXVmRVFn?=
 =?utf-8?B?M3lBQWdHVTRJRXoxMDA5Qm4xWURjWjJhZldzOU84SlZOWnNLWkM1cWJXOWJ5?=
 =?utf-8?B?WHVkVjFFSjlEY2FocjAzWnQ5M2ZSTUdiZ2R0V01IeGRxbWhHNVI1QTByNDlQ?=
 =?utf-8?B?TFk0cFhiMjYvTXVlRDF6ZjhQbW9BdDE2NGplL1BhNmx2VlI3ZnZOamVzQ0Z4?=
 =?utf-8?B?TGtMZWI5ODQxb3orUFBSTFgyMzErRFFTK3dYZXRMNFJHV0pZWVB3UmR5V0dr?=
 =?utf-8?B?cjN5RnQ3Q0JzVjV2Q1NSOWl1SlVBQTV4RE9ON01NRDhzSldYcVEzQm4xZ2V3?=
 =?utf-8?B?RWVWNmNnSEo3OExhWnBUZlorZjFkUXZjTWVyVnJ1aEkwV25LUG9UTVpTcmx2?=
 =?utf-8?B?VHhGVnNTWWR0cm40UFpLem1CYjU5bXVxTEhBeU9Eanp3aHlnRjBNNlhvNlg0?=
 =?utf-8?B?WjNEeUdvL0d3ZUdxdHRZTDcraEdQd2RFUjhuKzR5a3NlUXhaL2phUTFmRWVl?=
 =?utf-8?B?UE9WTnhBeHcvMFBkRjlWVVAwcmZYUFYyaU5SU3ZOMHdjdVNOZVdtR2l3cVhK?=
 =?utf-8?B?bTU4bW51MWhmRDVLTkZURCtQMWZtU1BVS2FCTHZVbWlqOGZ1MlIyTTI2ZmhJ?=
 =?utf-8?B?ZFpNVFlMdXFaVm5vdmxCR21HU0dRek1DWEV1RmswSmE0T2NsM0YxUTYvQ0V0?=
 =?utf-8?B?eU1KeHhUTHlqNG9yL04yMUZyT2pQYnFKOXV0NlRUODgrSFAzMGxVWGRRaEJ4?=
 =?utf-8?B?VkVvOWJSZUlEbHN6M2xkZ2huWkxsNTRwc1BZRE9zNzJpVTJFOEltUG0zKzVL?=
 =?utf-8?B?Si9HNXJ1RTAzMVIvSHJUUXh1ZTR6TmtUN0JqL1h2MVFqdHFRd1NzWkhHZkRt?=
 =?utf-8?B?NTlMTlBmdWF6em9GR2U1TlFOTFhmQzRHMi82Tnl2bU5OYnBhOWNUekl6T01l?=
 =?utf-8?B?RldoTUc1RlI1Q2VlUVRoeHhEL1N0a0JzWFFCaGtXT3dhMHBicHloWlRvZnVQ?=
 =?utf-8?B?WkdTalc4N05CTFMxMVR0aFBXQTRxSkxpR3BNNlVCQ2lwajZqR0VCNHQyQjY5?=
 =?utf-8?B?U3J3L2c5NnFOamFGaytjNmZZb0ZoQUlsQS9rZzFMTUJidHREVEtVRXFrZDd5?=
 =?utf-8?B?a1VuaCtCZmhORjkzWVdSQ2x1a1dmQ3RwWDVhakVMRzVRdnZjb2xuNEZLS3pq?=
 =?utf-8?B?SmRUZllOVHFyTmUyUkpKakRuaW9CUFJkZ1ZZYWFXNTlvZlNhd2FzWG41YWRY?=
 =?utf-8?B?MU1hblI3bnFCTEE2bXQ2OHVIUDdBUzVoSGxnbVQxVXE0ZjBvejE1QkRiT0F3?=
 =?utf-8?B?WW1EdElUNGp4YjZ3bjc5TEJlTXR2eXJiN3FQcitadlJOQnh2N2xrak9TbnEr?=
 =?utf-8?B?dVhmRGo2aU9ocFo4aHhMdG50VllnYTFjQ3lKSWVobzRkNUp5cGo4YmloQ0tM?=
 =?utf-8?B?NGNxWGZ6VVVqUTdLQ2pSeTNPUzgxUHR5RE0zeTQrY1Izb25HaU5WQi8zVHdS?=
 =?utf-8?B?UnVKTmc2L3NrM2wwUVJXcVhWMUw4UGl4SjU0UjFXZk9wSUNpc2MzN1BlSi91?=
 =?utf-8?B?TDFGRkpyTlNCNHFwNDVOVzFoZXhzRW5SU1Y0QT09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:06:11.3835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deea20f-013e-4781-e75d-08ddefaa0801
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1334
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
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 42 ++++++++++++++++++---------
 doc/board/phytec/imx8mp-libra-fpsc.rst      |  1 -
 doc/board/phytec/phycore-imx8mm.rst         | 43 +++++++++++++++++++---------
 doc/board/phytec/phycore-imx8mp.rst         | 44 +++++++++++++++--------------
 9 files changed, 92 insertions(+), 67 deletions(-)
---
base-commit: 28d6f787b0deb3f66118857297a855233eba18d1
change-id: 20250730-imx8m-optee-enable-dd28b305167e

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

