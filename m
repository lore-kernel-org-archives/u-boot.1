Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEC5E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 12:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08E180658;
	Fri, 10 Jan 2025 13:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UB8+FCcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F438036B; Fri, 10 Jan 2025 13:35:57 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7EA801F5
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:35:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RspuAg7zmJaqBzvUAF+DktZCP01HySO36TQebX9WhfPNbsrXgsWmn/zHf4klnptuGGR0oC2Q6KjvEeAAgXGY3Qyi4jGzxfZuOH5iytwwK6oi/bdb64IaKujvUR5+bsWCGV9Zo12KfSJAnlxCwtNWfhKYPnSw3fN7FvfCmYTWeWdpnxL16OTjDxKB1YU5napflaZrHu7CYpMlgsB7rj/VPHps/8BT3BLDlRAmUhS+0Yo8Smzp8a/YbOSidAOM0ci/2Ctvwqg+2363tmd20jBoNYbW6oWtupSmUNQ5BTN/WYHC9rEaLVRu73/JBPBfKfGxHum8vJjs+HKxFHSbWni/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rB+y+ZwOng7fHTYwleFqmNG//dn/s38eXevqVZn4YM=;
 b=mVKYI6s2ucZRmNQX1MqZGYuienBN15LXbidFQiCfOQsoUkZpnid5F9jqve8BLYXsvfcquZgPjwKoWrW8B1ByCHzagw/TeDE+rLJo2bGuqgMGfm2F+0cBstVzi22iU77TNqiEJNfooYDJi0G8+mCLtCxFknVPDGvH3mDg3IZIhcHrOS6vvISRbIU8Uexsl5gwiyu3JbvL/GmO2CmMPVzEZ+Yf4Nt3Gu5L/gF3SXLzk6emR0Qzc/gQJiAHHyboPDEizwQUvy73GvSL2/ifwW5+94qyltNp1tj+HvxtkbB9mSAIsvrvsLb+cUQ9jaf763xz4oaZovv0E73VI2XMpyutnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rB+y+ZwOng7fHTYwleFqmNG//dn/s38eXevqVZn4YM=;
 b=UB8+FCcUA95tXERiS12OcImR7/Tt5LTanmrEQJMupie5D+DHpRsqSGC21vIeXeCJYXXOpW20puQfdHXTTTRocbLrK56x4022wYeZFfYif5tK9I7I1KTNVvtgk2yACLlujd4VRalCHt7eDQCwXnM9ZeRSMsFEMud4dAfKgwLO+vIWC7yA/Cn5y3CfjRJZC5dXqvwwHXd2wUnCU4Pd1XN3uskRYSr0uxH/12SAqt/UITLqMxDCgNKq37UH/PfLvc3uKy6y4YsjOTRY+yg6doaGBaiHjQhPr4WBDVGUweobmmksWeb25i7OXQW6wTpTE8zYtaLAyahFBJYBgaQwGuSWlQ==
Received: from PA7P264CA0143.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::16)
 by GV2P195MB2281.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 12:35:51 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:102:377:cafe::f7) by PA7P264CA0143.outlook.office365.com
 (2603:10a6:102:377::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 12:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 12:35:50 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
Received: from lws-moog.phytec.de (172.25.32.31) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v3 0/6] imx8(m): add optee node to binman FIT image
Date: Fri, 10 Jan 2025 13:35:32 +0100
Message-ID: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABQUgWcC/23Nyw6DIBAF0F8xrEvDwwB25X80jQEcKgsfAUM0x
 n8v2kW7cDGLO7lzZkMRgoeIHsWGAiQf/TjkwG8Fsp0e3oB9mzNihJWkIhxP3TqDbXy/qL4Zpxk
 AKyFLcIQyzQXKh1MA55cTfb5y7nycx7CePxI9tidH81xxiWKCnRVGKuMqXZn6W7q3gA4usR9Bi
 bwkWCaMsVyWUgsC6p/Y9/0Dl2zlEvcAAAA=
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.31]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|GV2P195MB2281:EE_
X-MS-Office365-Filtering-Correlation-Id: df179af4-8845-4152-9453-08dd31735126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1VHY1ZPbGJIaG5QdnIxOCs0RVYxdmdNdkNGVjJaVGxzaTBZaVRpc1JBTm85?=
 =?utf-8?B?Y2d2YVJKd242emhpeUpNSEsvdVQ5RnhVangzY09SanVHd1kzOEZRL2xkYkdB?=
 =?utf-8?B?K3hCQVlUNGkvRFNvZWZET2E0bGszaCtvUnp4Yk1PZmphK01lT2ZxMTA2OVNi?=
 =?utf-8?B?MEJxbVhXblQzRVN4ZjNHS0d5QUFCNzRCQWRYbUNUSGtZYXBkTnlvVVAzN3JH?=
 =?utf-8?B?T3pEVmZjam5uYUdmWjJTK0ZEMGlPa1dBaTB6RkM4N3pyQ1FxaCtFUUZONmdw?=
 =?utf-8?B?b2pIdDJDUE02ZzlpK3ZQVE9ZemNrQVpnVUNlZTEvTVBBcjVHbFBSckNCNzZo?=
 =?utf-8?B?aXlmOWdMSGtiSVFWWDNUaVBhU2Z3YWlibmpFaHdiZmh6K3hKUkNjeUVoSHRC?=
 =?utf-8?B?YjlsUGhQVmkwNjIvMTBtNkc4b2FlQWwrMjlmSHQrd29SZmQ2SXYzUFIrV1No?=
 =?utf-8?B?Tm9wWjNDbVhRelJVSlBicTJEUXRiSlkyZnFvQkFqaGc0Z0tXQU1rRU81dmM3?=
 =?utf-8?B?aysxNjhOZ28zQ253Z3NXWGVzVmN6T0tPQXdTWmlzNVBOTTNxQWdnZjhQamV0?=
 =?utf-8?B?TDllOUJueVVLUlNjVnBjOEppTkFDcC9YdlBpSFhVbitMNjc4V1hWKzZoVHBK?=
 =?utf-8?B?UHNQU1R2cHFMSWY4d1YybS9SMHVaVVAxZVVMWGplY3E4SmtJL0ZabWtRZmha?=
 =?utf-8?B?dEgwM0ZMZXI1c2ZJRjArZFZuNDlOSnVGL250bVpKNW14aEVTR2pVUXdVNXA0?=
 =?utf-8?B?RG5JTzNuU24zV0RTSHNDb1dNb0l1aHN1YlFGZ0oxOWY1eXovUFc4WU56SmRI?=
 =?utf-8?B?cW1aNmNBRUdWSmF5ckNNU0xPUExLWVVNQVdOeGQxQk1TQ25ERmt4eXJWeWZq?=
 =?utf-8?B?eUNzS1FmeE9tWmNraEFJWDdkQ2NhNlRwdEdpWEFRN3hMMU9yb2g3cUFjSEhw?=
 =?utf-8?B?YitqU01LRldqOFZHT3VkK1B2UFRJRXJSNUtxd3cvQUdnT3g0cDBHQ1BHN2Va?=
 =?utf-8?B?UHVDL3k0QS9WOHg1a0NTY2xqT080Tmx2Q3pZSFptb2xOVklUbUVNTU5EaHlB?=
 =?utf-8?B?Z3g0WG5TcHZSWDZUUTJZT05uTXFyZlFETG00b0VtSXRDZDZFRTBMRXovbmRu?=
 =?utf-8?B?bXgwdXR5TzZ6YlFod1NOTXB2Y09hcHViaVVaMHZsTk5TUERKV3UzYlBlN1I3?=
 =?utf-8?B?Rk5jTWw1cnh1dFFqdkVmcEdCREVzb3BZc3NJWDlHVDFUMkVPYmoyVWk3OURy?=
 =?utf-8?B?QzFyMFJtVXo3UVNQYjRkdDlUUTBFdjlBQUFFMkhGSW1LRm9UcDZldW1OV0Ux?=
 =?utf-8?B?VEY4YVl1WFVvNmljUUsxMzc2c04vSFlMWGZnbytGTWZSbmFhUDUwblQ1cGpV?=
 =?utf-8?B?eUQ4S2J1M1Z0cWx0YkI0MlhleTV4dVJHNnRSVFVmQWE2SjAzREgyR0NsdC9h?=
 =?utf-8?B?d21xOU5tTWxhdHdnV3ByZ2ZPSTRNeC9udmR5a2lDT2llTmFsWGNjRUVPbXR0?=
 =?utf-8?B?enl6ZlFicGMxdjVQZjNPNWs3Ry8rMFViZWQ4Vm05a1laTnhZRHF1WEd0NjZC?=
 =?utf-8?B?RlZ3Uy9LcSs5dmZnNW9vcGkzMnBQaU5EVWpvWFFqVHNiaGVyOW8yU2puUTRC?=
 =?utf-8?B?dTFXWG1HQkxhSWRSNXZxSXc0bnJCV0FiUGZNM0NRa0Z6SGlHMUVQNDVwSXB0?=
 =?utf-8?B?ME03TWhtK2pRTXZ3RXBXQXpUdmhFdGdtZVNKcW1HS2tqNW91M3l1d3ZLcmNT?=
 =?utf-8?B?SHRzN0wvUnJXM1Fvc0hrNEZJVVFXZDVQNzlUdS9GU2pMQzdxMEFMdUI5azQ0?=
 =?utf-8?B?VWRTcFBiaW1aeWJvdmdhM1pybGpqMWk4TGhrODUvUHN0U2I2OVl0cUtHTWl0?=
 =?utf-8?B?VGZoQTNsVEFncnZMeU9tbTZUc1NjRG81MHVpeTFWWC9JSUNiQ0dWRWFVTFRU?=
 =?utf-8?B?VlZ3ME9nWElQdUo0VkVROTNaKys1ZUhZL2llcGtJR0N2WTd6RXFRc212L3V5?=
 =?utf-8?Q?d1sS2zGpw/h3MTAFsTMBa+eBrMyoi8=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:35:50.8648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df179af4-8845-4152-9453-08dd31735126
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2281
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

There have been attempts to get op-tee node integrated upstream in the
past [1][2]. The challenge is on how to handle the load and entry
addresses where the op-tee image should be loaded to.
Different SoC families and architectures have different RAM base
addresses. Further the final addresses can vary from board to board
(e.g. depending on populated RAM size).
This approach follows the TI k3 kconfig solution.
To be able to define a sensible default for the new config option, put
it in the imx8m kconfig. For other imx families, the RAM start addresses
are different and thus finding a common sensible default is not
possible.
I do not have a working Nano and quad board so I was not able to test them.

I included usage for PHYTEC boards for examples (with documentation).

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230622173006.3921891-1-tharvey@gateworks.com/
[2] https://patchwork.ozlabs.org/project/uboot/patch/ZeHDVr-Bzm935-5N@mecka.net/

---
Changes in v3:
- use OPTEE_LOAD_ADDR defaults as defined in upstream tf-a
- add imx8mq (untested)
- move common PHYTEC imx8mm optee build doc into include file

Changes in v2 (from RFC):
- Use kconfig instead of trying pure dt approach.
- Add load addresses in defconfigs instead of <board>-u-boot dts.

---
Yannic Moog (6):
      arm: imx8m: add OP-TEE node
      phycore-imx8mp_defconfig: add optee load address
      imx8mm-phygate-tauri-l_defconfig: add optee load address
      phycore-imx8mm_defconfig: add optee load address
      doc: phytec: imx8mp: add OP-TEE documentation
      doc: phytec: imx8mm: add OP-TEE documentation

 arch/arm/dts/imx8mm-u-boot.dtsi             | 17 ++++++++++++++++-
 arch/arm/dts/imx8mn-u-boot.dtsi             | 17 ++++++++++++++++-
 arch/arm/dts/imx8mp-u-boot.dtsi             | 17 ++++++++++++++++-
 arch/arm/dts/imx8mq-u-boot.dtsi             | 17 ++++++++++++++++-
 arch/arm/mach-imx/imx8m/Kconfig             | 11 +++++++++++
 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 +
 configs/imx8mm-phygate-tauri-l_defconfig    |  1 +
 configs/phycore-imx8mm_defconfig            |  1 +
 configs/phycore-imx8mp_defconfig            |  1 +
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ++++++++++++++
 doc/board/phytec/imx8mm-phygate-tauri-l.rst |  9 ++++++++-
 doc/board/phytec/phycore-imx8mm.rst         |  8 +++++++-
 doc/board/phytec/phycore-imx8mp.rst         | 20 +++++++++++++++++++-
 13 files changed, 127 insertions(+), 7 deletions(-)
---
base-commit: 6016960ceb9d3fda591cda94df3841748fb65596
change-id: 20240903-phytec_imx8m_optee-8674ef012a36

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

