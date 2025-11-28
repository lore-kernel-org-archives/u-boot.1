Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55576D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE3183B8A;
	Fri, 28 Nov 2025 17:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="E0zgB0j1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771C883B99; Fri, 28 Nov 2025 17:39:05 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2154838FA
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEKVDpMggJcft+ABy53jMpC0lh4TBy+Kr/ug4Avg9lel/3wdco3LaoDQ++H+fc/3yNZFD3geskB9wH3iN6tW63IXOFmjQnbwGMzjijfx6nMiHxndLvjV/Og6S20wnQkYsZSzoj57Ft4k1dOh8USxcTbWdlxJ4xwSO97Z3Onw8Pz4LUh9vQXYTTrm760Pygs5U7zBfAlZN7C+gQmaeSWP5dq723rZLoj4SB5IO9axZusamBe7rio3PWYY3r1iqX5aqezvVhTnj5/MBgVBY6S37EzJdmh8odms0r1DZPiyoA2+hc4z48p4GFS+mgjkRXwm6PkrE6ywxedrmFjKt4mKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR/KFYjXo8mfFhEvag4NlQq51CPQhPMqD+329JKkLFM=;
 b=Cv+bFDcLUNj7z8bmjWCSwZBjN7N6KoLLdy3VoAft8B+FqnSEO8IpPIcgX1t3mOaUpZhoHpz/YmtlSZ5Dq88DwuBXpTt6E3PhPPclvgzvHtKoKIFnK/qXWxAFoH75yyIWhwZ0JnD7LJ2BxlNn7oYXWMVrBdA9uOjLN603jGr47/U0Iosz13FZOlsXNhLnfcyM+MPKhvO+6Mecdc4fRocMAvYwIBlfCVSpBMhKYwPqmhAKH/3RaYhJM4L6H0eO1Zf3Vf/Ec1XH89emf7YUfEhBOQSw7sLXBwEB0nOI8nz015tUjZXr0yvNa1Mi+8CxGH5piET2TGzUhpwhz678VkhEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=mailbox.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR/KFYjXo8mfFhEvag4NlQq51CPQhPMqD+329JKkLFM=;
 b=E0zgB0j1Kb9q9nvfFdJZ5Us1NFiVncl7ZOTRFxGr6yRT2LxNYwyewgDiHbm+q2Y47XNfCON9lQFH4yCwqufbq9vJTLUyxmOlrbdAsOVgAAdrjS+z7d3ERjMq5IJjXFb72qP+hRGwa001YQRuXFlTiTZfQL5LmH5P5dZVEEXimuP+07h/86VFnk6Ht42iR1nHb1+drPCg8jN1glmWdNXMrPEupZI04vm4Xt10e78fsE7T4DAGJhCyxkRhdnsqf/ETTism9goSYKWarG1vmLb9m18HrMMR8VBwZ4s4eZBEq/p6a+IO5DO3nlcClcphIjLes18u17MohLxZV8mX8B07DA==
Received: from CWLP123CA0255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::23)
 by AM9P195MB1266.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 16:39:00 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::aa) by CWLP123CA0255.outlook.office365.com
 (2603:10a6:400:19e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 28 Nov 2025 16:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 28 Nov 2025 16:38:59 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 28 Nov
 2025 17:38:59 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH v2 0/6] phytec: imx8: cleanup environments
Date: Fri, 28 Nov 2025 17:38:40 +0100
Message-ID: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDQKWkC/43NQQ7CIBCF4as0sxYDBJLqynuYpgE6lUmUEqjYp
 undxZ7A5fcW/9sgYyLMcG02SFgo0xQq5KkB5014IKOhGiSXWgip2Ycis974wOi1tL17ognv2GM
 obLTGtgPno9EaaiAmHGk54veu2lOep7QeX0X81r+yRTDOlFCtvDgurLK36NcZ3XlA6PZ9/wKU3
 mAmxAAAAA==
X-Change-ID: 20251125-wip-bhahn-imx8_cleanup_env-fbab8d00fa55
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764347939; l=2208;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=0usdINBKAXLUdWg+nDbo2l0+ByV2IVoQZdLN9cI9Khg=;
 b=nPWT63hBw4HPfH+fvwrcVRut0k1KfQhjZEKhcPhdMpp+FrFPGQXHF+CbwNrUdhHSO+9nPhoeB
 oOQ1rIfj7LRDwrRDmslrySCQDKZpZl0ZgllBvKTk+EfmwdVovOmIfmP
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AM9P195MB1266:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bde022-4e90-4a07-309c-08de2e9ca1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjJ3bXcyemdVQ3duYThpZ2RkTkhXSjUwRTMrM3V2bmM4b24yall3RUw4aVhV?=
 =?utf-8?B?eTdRa1ZtWHZEbGEyWmhtSnpaSmcvZFpCQTVXWTlUOTNwVlRIRnBvVjVoWGpD?=
 =?utf-8?B?MFZqeXdodmd2T0loVkFGTk1VRVV5L0hWYXpIdHJ4NmZqVXd2b1kzZTBMOVVN?=
 =?utf-8?B?MjFEdmRYbWVCT1RpT0t5WDYydTI4cGpPL0ZoVkUzbnpGMGpwZVh3Mnd5Mytw?=
 =?utf-8?B?ekxxbWxwNGdpZW9LL3NsMEJZUnNtMWcreWwyMDJIYWZpdEVTQ0FHbUp0eHp4?=
 =?utf-8?B?aVBkOGRNa0szQ1VkSEdsTTRkR3dtNmpXTzVMMTZGdUpaelF6bjNRZVhla0Vm?=
 =?utf-8?B?cTZpa2ZKQXB0ZDl2Z2VoamxadkVNN1gyS1gwOHVlWURvczhkSmVYaENjeDJO?=
 =?utf-8?B?aDRUaFZtOUdtaFdQcWJuY040czRHSkdOQlpwYTU4bEVLTW5kV3NiVTZWcHJZ?=
 =?utf-8?B?ZXJNK3ZtQ2R3R1EzenAzQmIxejRoRmVxOTN1N1E0d0lPcEF4YW1laFl0cFVU?=
 =?utf-8?B?UEIwankwaE9JYzBhOVhWSUNqRTBUVCtWWUVxZzBSM1ZuSFJ5clRTNHFjakhS?=
 =?utf-8?B?OW9keGkzR0ZqZEhaVFhQc2JOMmJhajZFakRPNGh0SzA5QUJJNWNuVXJocjI1?=
 =?utf-8?B?RkFBOFM1VFBLVW8zamRaM1JIeVA4MFdyYW9xUG9HV3h3U1hGT2NxQWJ0Q3pw?=
 =?utf-8?B?blZnK0VnRmwvZ2Q4UXlkaldmYVhsTnNJU3JwaFZVd2pkNjY2aVA0STltWG9X?=
 =?utf-8?B?dGJPQWtYbzhSR0R4K0lqdjhVRzNSK3dobmU0SzJqN3BSNnFaYjE5Ym16Wjls?=
 =?utf-8?B?OEdCOXlYYXVEVUEzV0FuWitheFNVekh0ckZWZTRpM3NTcXV6blpCRUZQZDZB?=
 =?utf-8?B?b2VXUksyakZMMWpHeEtyNTErSU5LSUkwWXdxdFI1ejQ2aEs2Wmh2ZFpDNmxH?=
 =?utf-8?B?VE4zNVR6c3NkSlMzS21FNEt4SVl6VHdORTdMUmF4Z2NPdmxhazc4UGYydXpP?=
 =?utf-8?B?SXBsTjdaWVM3eThkc1FSdkFVTkxhMzlnOWhHcUp4Qy91U1Myd3VSUTRBRi9D?=
 =?utf-8?B?S2ZiN2lTTHFJRHk3dXJMNmQ5QTJWbUVMZW1mZ2hkZzZGL3A4K2FraWQ4Zktv?=
 =?utf-8?B?RDYyK0FuaDM2OXZMYS81cFZqdE1pYnAvUVBoTnNQRXNob1BVNFlDTmpRdENr?=
 =?utf-8?B?UUxrd0ZKdURlb2puOVdENHVORUNZWkVmU0lnNWM2dkpIL1V3dTFwRUJDeHJq?=
 =?utf-8?B?K1Qrelp4bllmaktNV2JEakd5KzU5R2M5dUpRdTlieVRsVGdXOHdHaXBMcDZr?=
 =?utf-8?B?cUtQUDY1WDlDVWYrc3lwMUFhTENQMnlQWWR5dXlPRnpkczFYUG9CVXIzSUtS?=
 =?utf-8?B?b2RrWTJCdS9TR1dVckhXdmxEVjdwWVMreXVGeGJXY01WRnlPaGhoNkhGS1dZ?=
 =?utf-8?B?bTVwc2VESWlqN2t2alhtZnJDdm04Q1gvcTZVays2aUJ3NWp5elQ5RUhNOGpI?=
 =?utf-8?B?MEVrRUZlZmZpUXJYN0JGRzMxTGZFYUI3TFU5ZTdCMUhCZmp3TFNRK1Q5c1JO?=
 =?utf-8?B?d1ZuNk44RElCMXU2bkk0eU5iZklrbmZJT1NoMDExcG9SWWgyZVpqQmFQMGNv?=
 =?utf-8?B?Z3VjN2ZKODd2TC9SOHF3d1hkUjdmVUVlYVMrOVAwVmhtVGFSYmF4MWJValFJ?=
 =?utf-8?B?Vm43TG9DNFVEUVdoMzRZRExOMWZBTktuZVcwSlJQcEpoMTNqNEZFUVB5T3pu?=
 =?utf-8?B?THQ3djgzRmhLU3JEVG9GRk5PVUFLZDJNUWJCNHoyT2F0RFJOT1N4YmN1Vk5s?=
 =?utf-8?B?bHFKcW9PTnRQTWpNRmFlY3NITmo5a3E0RFhuTXZuTGxZYnZzcVBGaEdObXcz?=
 =?utf-8?B?YjMrSXk0MkFRQ05RU2JCVVRZOGQ2enFRWFE2NEEvNTVrZXNrUmg2cHUvQURx?=
 =?utf-8?B?clgwc2dhdXRxeWVHZHkyTEFXYzhCV1ZSb240Qlg4ZUlnNDl2czNXSEhwd3Rj?=
 =?utf-8?B?alo4eEJaMEQ4M0Z1RWJieEhIYk5rVUMrZWxIQWhReFdIQmJQdXZ4SHJoeS9v?=
 =?utf-8?B?UWRJWVFRUjVLN3B6TVdKNktReUZBRUo5N25meXRsSG9yVyt2WGpvd0dsNWwz?=
 =?utf-8?Q?cBznodpQPFj7iGgJcWiNHlA/m?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:38:59.7334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bde022-4e90-4a07-309c-08de2e9ca1d0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1266
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

The state of the environments are different for imx8 boards. Some boards
have more and some have less features. Cleanup the environment and bring
all phytec imx8 boards to the same level. This includes:
- remove unused variables
- modify variables for use with ampliphy-boot bootscripts
- set bootdevices, bootmeths in devicetree for standardboot
- modify boot_devices dynamically for sdcard boot
- let standardboot set bootcmd
- sort env variables alphabetically

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Changes in v2:
- fix for modifying boot_devices dynamically for sdcardboot
- reordering patches (modify boot_devices depends on setting them in the
  devicetree)
- remove bootenv_addr_r as it is no longer used with ampliphy-boot
- Link to v1: https://lore.kernel.org/r/20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de

---
Benjamin Hahn (6):
      phytec: adapt env to ampliphy-boot bootscripts for imx8 boards
      phytec: add emmc_dev and sd_dev env vars for imx8 boards
      phytec: set bootdevices and bootmeths in devicetree for imx8 boards
      phytec: change preferred bootdevice dynamically
      phytec: use fdtoverlay_addr_r
      phytec: sort .env files alphabetically for imx8 boards

 arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi   | 16 ++++++++++++++++
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi      | 16 ++++++++++++++++
 arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi  | 20 ++++++++++++++++++++
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.c   |  2 +-
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 14 ++++++--------
 board/phytec/phycore_imx8mm/phycore-imx8mm.c         |  2 ++
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 14 ++++++++------
 board/phytec/phycore_imx8mp/phycore-imx8mp.c         |  5 ++++-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env       | 17 +++--------------
 configs/phycore-imx8mp_defconfig                     |  1 -
 10 files changed, 76 insertions(+), 31 deletions(-)
---
base-commit: a22f664b64aaa7ab8d431e1e6c021c6e63fd9a51
change-id: 20251125-wip-bhahn-imx8_cleanup_env-fbab8d00fa55

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

