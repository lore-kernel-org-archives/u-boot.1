Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DBECA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A352B8313B;
	Tue,  9 Sep 2025 16:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BJ1SQ3q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE70F83192; Tue,  9 Sep 2025 16:06:22 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C7FA8309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnj1OfxIyn8apERkp0S10b4IPmD+W4CGSC+C9r7SzRg0AR1bnhKoLzuMnewGTHwL7I/sWaZcP9tV7mafh7Y4o2b3hVofDtOKO+iGI8m6YhO0QaiRO3Uw5XR9Xxl0nH+pSn9uIgPfwfAZIeu4pkoD5m4bkw3JuyJBgl9aPXJpv8z40q2Y3hjupusBSaCTYaK/8Lx/f7Vsw97mb3wwvDaLKnKzHJX1zknusHftBelvOuOZ/apUp3unu6UNlHDsS71lOyFMHlV8hpOHAbYlJBO8SJ2NYUV+Ma+AEu53K9GUHIfGjXhVRezRlErJqPkv/MokidhNrx9AjgFjAVgpNN2FlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpxVlRVDHrxT1yWIedOXC5glbzAbrcq1G/Ty+N+lfa8=;
 b=YGGPzq1KHUB1tsph96qQSZrvmC2WStuvmYLcdVRI4drq1c4gSyUswVhV2TWMnsVDZSDCIRbQNLoJzxZC3EAlyUynLEKZZ/4SCtKmuwEd+lCjOCkwrYES23+EFpx2wnwuzB9b3G540Yh2WnWg2rM9NeSewBL97abiMa7vFqtE+m+CjsPLvnKn+JmpqyatdblzMC6jTbGv822zi6IFakr3hmJvXqENsWqfBeOpRQl+cWi2rCgg8KmO0xH3Af0FVLMEqyRYOjyGC4d2hxrK2tNg7ZM0F6ZDFKgaAszJpLsWXKOoxWsL1Hh4DSbQSlrAtYFx3GvxozSz6OcapxojUldYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpxVlRVDHrxT1yWIedOXC5glbzAbrcq1G/Ty+N+lfa8=;
 b=BJ1SQ3q6pktWtwM51e0GNp10JCdZXeJjvXFIFA6WJG8p7SJIM0pQ4ZJFcSpUSggU4fbqc0E4bcO11bSwsoA365dbZNCIV8VooaqjKW7vabT3e1N2EXCsO3O+E6E+GbwJEQN19qNdgSS8s5SJCJ0ZeYNKM4DuJsYiKIo4t2rMd1ghUUQm3cD7n3UBmSNPCXI8eR1DFy28UV2TPjnZ8unt6dP6RNu3oUOqID5+SdaK19AFkJ7aeg0dRQV5L9vo7OOYMv7yIRI/jHSrt02DLSeb+csLbZooXdP2Ufx8Q++hzGVrTCVLLRdVkUKuhYQwnniSj7yTj+Wdr1sc9SlRW9BK2w==
Received: from AM0PR07CA0019.eurprd07.prod.outlook.com (2603:10a6:208:ac::32)
 by FRWP195MB2940.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:185::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:06:12 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::7c) by AM0PR07CA0019.outlook.office365.com
 (2603:10a6:208:ac::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 14:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 14:06:12 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:11 +0200
Received: from [192.168.2.142] (172.25.39.168) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 9 Sep
 2025 16:06:11 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 9 Sep 2025 16:05:39 +0200
Subject: [PATCH v4 1/3] phytec-imx8m boards: enable OP-TEE for KASLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-imx8m-optee-enable-v4-1-6dfe494cc939@phytec.de>
References: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
In-Reply-To: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757426770; l=3511;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=jHa8u+2ni5TvhraGixMjORr4ccernl+mzN1Du0hX9Y8=;
 b=jnwo6w+SNTZ/bC1KhwfHxK5mps2yKMUdGqT/K5NK2e7GmsiwlZVbIH3RPj9pVSqdE4jHX5sOj
 DySRp5RyBGyCNM2MT6pa0fJ3/Wpn5BKXuHftc9m6gnZGQxHHyCcV9YU
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.39.168]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|FRWP195MB2940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccddcab-4e6f-48f8-06de-08ddefaa0889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW5abDd1ODNyaHlwUkIzSlNrVFdsd01CVnUrMFZUdi9majlTV0I4VDkyM1d1?=
 =?utf-8?B?a0YybEJuMkliR3RCSHlvZU5NenpYbFE2Y1BiK09Sb1FhSlZ2dS93UHVLNGcz?=
 =?utf-8?B?WlFJNE5QY3dYQVE4VCt2M3pqVWU3bDh0aWtRL2EreHVoQzJlQ3lzTGErcDVm?=
 =?utf-8?B?NURWMEZocTVkQzNSVmdHRi9xbHN3b0RqRS9PaTBUUGFER1lFdGFFTEd0UWVj?=
 =?utf-8?B?YjNEc1ZscThSdzBZQ0tOOG1pMUY1eVQwcGx0cldYamFEVVJpRzZvZnBBMUtV?=
 =?utf-8?B?RGRVdVJ2V0NncEZzVjg0Z0ZsWVp3ZDRNaGZCR29TanpCWUJvb0U5MUJnLzda?=
 =?utf-8?B?ekU2LzRlTDFXVHlQL3dodTFFVXRsMFlGcGx2TTZESXpYM1VWL2g0T3BDVDRY?=
 =?utf-8?B?b0xUUUxSclJVdjkrVERZV2ZteXZkWjJ6eHRzTng0LzY3MUtsTEU4VmtuSDZk?=
 =?utf-8?B?MmVxeHAzbERFcERvRTZvUHhzeUxWQUdoRFJCUVA0TnZWc0JhNHZnWWtEKyt6?=
 =?utf-8?B?ZG9ON1pDaEt5L1RoOEZ5czRmRWxhbGVGTHhLWFNYZGR5R0l2dk54c2N0Zk5T?=
 =?utf-8?B?dWVpZjhEZHZGRktiYlNpd2lmeFh5ZFdtd1MyZHdxczhCZU1qN0E2WXEvOGlE?=
 =?utf-8?B?R2U4T1N5aVozbkZxRUhaSnF0L2wzNTZONDZBVHQzMzZnbjV0SDJZNzlxSkk4?=
 =?utf-8?B?SlJzd1hXUE9yTG5JN0pjRlFERmZ2bmpGZ1o5QStUdnFtelgzb2hvR3BkMEVa?=
 =?utf-8?B?c0VLaWlKaW1DQm01NXNEUnVUSElPRTUrdzF6S3JzNVVFUnNjd1BkS2pXSmZZ?=
 =?utf-8?B?MHhOK0hEdjMrcFBDaG5nKy9wNVJSTlAyUkRIZFhLZGg5YWQ0Mm5aT3hUN0Rw?=
 =?utf-8?B?d081VEEzaTJhWS8zRlB4NGxGNFl0ZitIQmp3Z29yZkdJckcwTDc5WUtGUU45?=
 =?utf-8?B?Q0EzaFZFd0pxSnl6SUJBS3pPMXdJL2w3ZlJUYnlZcVZOeVpBaTl5a2NWUDFF?=
 =?utf-8?B?UVNZdDhlcmxLYlJ2Q2FzVHJaZi9zaWxReEFuTnI0MWlKZXZDa25yaXBzZi9v?=
 =?utf-8?B?dWFnQ0I2TTJ0Y1BmUDZoYjcrejU3b1ZyZFhkaDZwS0hLZWlQa3cwYzFsT0dU?=
 =?utf-8?B?blc3TDVSTVc4UEM4SlE4REF2M2srbkp0UW9ZNVFMNkYwTkZ1ZlhvZ1plT3dI?=
 =?utf-8?B?eVp1cGZVamthUTBtcURqTy93TjdzNnpZS0ZZTzU4L1dnOVN4SXZwaVpvZXJw?=
 =?utf-8?B?eWEzcDNVL1JUMVF5bW1PV0tCMEdwTkorU290L1RNUmNSMGpPcnVtY3FpcnQ2?=
 =?utf-8?B?Z1RlWFlJclI3cFRIWmNHQ0padEYxTmNFd2VTS2dldEFUcldIUDc1MVRiZXJo?=
 =?utf-8?B?RkJBbUNocTlGRnZ4eDVmUXZDa2NLZ3ZhalEyeTl2UGFqVGFpQlNBQ1pxOFZj?=
 =?utf-8?B?eWlkYjVudHFtb0V5d0FZbTY5VVB0aXJ1YXpVZmk1ZC9VQ2NDMmdWNUVRT2ZD?=
 =?utf-8?B?RHUvOGlOODJJYkVBWEJ6R21FQzNXdENlUDhDc015SE5DbTRMQmdqc3lXQTds?=
 =?utf-8?B?aXFOQVAwK1dxR2JhQzlPTTB5MUtXYmxoTU0rZUl5VzZmVzhzQmFlK2dlVVhO?=
 =?utf-8?B?ZXVac0d0THFyUk1zOXIrVThGVDU5UGNYdU15RWVkRHJxeVp2bjJTL0J1KzRk?=
 =?utf-8?B?TjFadGJ6STEyM09aRVNIUUk2ZEpOdTZVVVB3c1gwanRKd1dvY2w4OTh3bTNG?=
 =?utf-8?B?Znd6SDN2a2xDVUczaEl0NHJqWDlMNHlSS2I3UWRkYndjNmQ5ZmtGUXo1bXlT?=
 =?utf-8?B?RG1NeExyYUMyN1liQ3VzT3FIL3RSRllVeHdMdkZ1eGtrNHZhaUV4RW02dXox?=
 =?utf-8?B?bzVDQ2R2N3BranFkTHVlWnlON0NVWmRCRTZWMVdtZ1BtTkpqdEQ0NUJPTUpz?=
 =?utf-8?B?Z05oWnhvRFpBanA5Q0NqcGx6ZWZJTVQ0dVZDNVM5RjEvTnJWNzFxVUFUU01Q?=
 =?utf-8?B?MTF2WU9LSUJtOWdnSTVPMlpGTFhnMU9DbWhxdFR6SzY2dkxqaDZmNENIWHVk?=
 =?utf-8?Q?u6LDR9?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:06:12.2705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccddcab-4e6f-48f8-06de-08ddefaa0889
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP195MB2940
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

Enable OP-TEE config and RNG by default.
Set OP-TEE load address to end of 1GiB RAM for phycore-imx8mp and
phycore-imx8mm as the boards support a 1GiB RAM variant (although not
yet upstreamed for phycore-imx8mm).
The imx8mm-phygate-tauri-l board only supports 2GiB, so the default at
the end of 2GiB is sufficient.

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 5 ++++-
 configs/phycore-imx8mm_defconfig         | 5 ++++-
 configs/phycore-imx8mp_defconfig         | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 7369c0a05ac98315682127f0e96af7d36c4763d2..6dc95d6d3edbc0b4ed25a66d23f1b65435e01697 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -73,9 +73,9 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -97,11 +97,14 @@ CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 4d6bce26f07f7b90e7c3674f4b9ddcac8d775e1d..4cf4d3972567bcf77d9ee7e2fda707070a778c72 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -82,9 +82,9 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -120,6 +120,7 @@ CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
@@ -129,5 +130,7 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 6bd8bcf15daa95966aa973d8a493ebc1f05b14e9..c497f0bcd9131abab0b751ec9cc81194405b1f19 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
 CONFIG_TARGET_PHYCORE_IMX8MP=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
@@ -153,6 +154,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_POWER_I2C=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
@@ -162,6 +164,8 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y

-- 
2.43.0

