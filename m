Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B85CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 12:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2968391C;
	Thu, 14 Aug 2025 14:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="inJ3t1wA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B8F7838C7; Thu, 14 Aug 2025 14:08:47 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD6C838F8
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRktGF5AgtYfAU5lyA3SuljUFi80ZrYBAs/QHVPez9QDjodA9MtHPUIWhw5n8COC2GUW0xwTwPgMSBprCHnzbyRdIVw1HDE/SHYuFPgpGDPwPMh4Cm5Q5roXIGrK+oxOL1v7I3dSHFlZzTQqIT4phoGP/I2zMoidPMxZ8eEKJdrfEXW6E8QdyQiySCxDHdenV1zdvNU+qKNUO+wRDliuHWhbDFjC+HCk073hn8ZoGEIsyS2DZeXfvD64vYyQC0tQeL8vo8keWF730wYTVgVr6YAjTDbF5Bo1J0OLoFyl3FlvQ0od1rAAG9iXPnzIWTdRiaonfoAWd3Z5Ll/0shfHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1q6ep9WOPTd3TPcqgIVLUoDZ5DveCxXtASKJW/DFKQ=;
 b=UjB6xmGXYwO5rWPUveyjY5J7Lzhom2iGXh9sejqlRRLphgSMlvbSQB0kWSxBouaPF/t0kChq5//hsMZq8Se9uzXDyTfw+1z/JbPWsMl5CMB/4ucSMmgaARYLj+QZqF1rL1ho3O91uq/G/o/D3DO3ViW/GepYjmq9ZvS0Yo1oLsi3pjGRU3qNOncfWEvURLEw345zqXJkAyFh1JWjP1tlFP/3TMr7mycW0DqoUUxYUHT/1Jo2LbxG2WE9Xx+8NcszVUT2qqtjaDURhL1T9ewA6b/sU00m79d9pPUan/CoCLZdfz0txOqs1fTATHr8bYy5ER6F4TTZy9RXRpcIeiN0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1q6ep9WOPTd3TPcqgIVLUoDZ5DveCxXtASKJW/DFKQ=;
 b=inJ3t1wAevaSmea/+izpBug1qHemZj8b0bdqcWmu6JImIM8InLEKiAQnPDx2N6/zXvx0sCS0QbGeKp9QYqTTEm8SF2fAEPkRtcs6y5kUAeR98NcFJdOzv0sDNFriVUojQ9sM0uaECBYMnPW5i9CQbPTE7MrOnETschLoGKCN4IAI//ivVy3+lZ5Gni8A1uJpv0K50o7I/rKpLH413SZ86h5Ivy3vpx+mZ1ifHu0JAmExcBlHy0JwxhWslEx9GYoDz+tKwnCJyqCY9D5FbWJ1Oc8ijvEzFtI9UkgGnWX76f0CJQYIFB2jYH5j0QVgeGWPdDH4lts0bk3i7T4VnkmTIg==
Received: from AS4P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::7)
 by DU7PPFB768BB21D.EURP195.PROD.OUTLOOK.COM (2603:10a6:18:3::be4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 14 Aug
 2025 12:08:41 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::36) by AS4P192CA0018.outlook.office365.com
 (2603:10a6:20b:5e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 12:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 12:08:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 14 Aug
 2025 14:08:39 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 14 Aug
 2025 14:08:39 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Thu, 14 Aug 2025 14:05:40 +0200
Subject: [PATCH v2 1/2] phytec-imx8m boards: enable OP-TEE for KASLR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250814-imx8m-optee-enable-v2-1-c489d795ae07@phytec.de>
References: <20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de>
In-Reply-To: <20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755173319; l=3404;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=GglVISYWkf03epQswfViOlTE3uy8bJCfNJpKlh5SN/w=;
 b=ghZiC8tH0IkYDB3HNUDctGKjAyen/ky57OP65Oa4M2YqfT7r2qyzNxkum8W1+0cF0WszFCbSO
 5emerRqVVTdASDYcYf7wBYtNRyqOE30W2wUJ5Geeow85WdBzGOYReUI
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|DU7PPFB768BB21D:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c177b55-54af-4317-2cbf-08dddb2b4ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGRzV0t6WFB4NlVUZlovaTJERDBmQW1ZK2J0TjJWbk5QeDdQQU9NNW1Zc1FG?=
 =?utf-8?B?Tk05Skh4QnJWdDdYNjhYcDg4WGV1UGhLZm5UdWlKc2ZsREJuZTZpRXZDbFA0?=
 =?utf-8?B?cjIzZk9BaVZnMzFjU0VPc2EydzBLeklNd1huQTQ2VERqSDNZdjdWODhPeW0w?=
 =?utf-8?B?Z1JIKzBFQytmSHp2Qm1GL1hrVGlQZytNZGc1OW52SmszSGxSbS9sVFM0RUdt?=
 =?utf-8?B?Q25QMVFFQjlVUitCS0xqNjRsay9oL2JEZHArV2JXM2tZTnlZMDJtcVlscHZy?=
 =?utf-8?B?dDIxbzRQcjVWMnE5clpnVFd1RlIzTVdZcmVsTUtDVHdNM28yVDFkUWFTZjcv?=
 =?utf-8?B?MStoMDY5SjVGTzdhRUdid1NKUkRod2FmWGE1bjRlN2JWb09VQ3NPUkdGd0tH?=
 =?utf-8?B?ZW1Sb3Fic0YzdDVaZHdBK3hHZjQ1S2RWNEU5SVdQaFBPNGNuZDRMOTdRQ2pF?=
 =?utf-8?B?QXpZUkF2cWdpaGIzWENnU2R0OEZnYnNnY0VqZEZVYmRZRXVISGFEZHFWRUdH?=
 =?utf-8?B?VHZWbUpVTzBycnQ1dlRIcTZXS2hoTm5uMm5kamxQcURjTEdiYURucitzSGY3?=
 =?utf-8?B?VVljR21WRGRpN3dDbUdDNVZGVm14elBsY1ZQbWVpQ2FLZ0xIdFFIZzFtK1l2?=
 =?utf-8?B?TVNRdTNjbFVWd2hoK25WNjBubloyVndVQnNHRG1aSlJEejJNVFhvQWpxd2RR?=
 =?utf-8?B?Q1dPWmI3KzhvdHBJOTFKcERYYWo1UmM0R3NFTlpFOUUwekEwNFJZQ2RiWHJM?=
 =?utf-8?B?ZXBPTGIzT2Z0MEUrczdiL3dsK1FScEtUR0M1bnFkcnRnQ3RnM2lPZGt0dGx2?=
 =?utf-8?B?cWtTdjAyTzJuOEthelB0bkV6NDR5YWxqWlJZVkh5R0Zsa0NsSFRHKzUzbXd3?=
 =?utf-8?B?KzZrQXRpdTBmL21WWGZVTmx2ak4xWXhJTENxeHNGc2ViaGFxUU9qVlNJSEM4?=
 =?utf-8?B?eFpqTGx4ZnM5Rk9wclFqbWZLNU9XVy9ycWs1ZUdqZDU2R0MwVlFvREN5YWk0?=
 =?utf-8?B?bFpTUzNIM2NlY3VITktjYTFTcGxzTFRZR3laWmpPc2pDU0s4eUdWZ1Buc0gr?=
 =?utf-8?B?TmxEY1JVQUFSQW8wbDh1N0xFdFBmb0lZK0lDUHBFUFovZWVaemxSeW83UURX?=
 =?utf-8?B?ZEtpYWZwbGZBcFBrdTg1ZWEvYzFwS3NCSVdPWS84VVd4VHdDM0ZVVUxRWVhQ?=
 =?utf-8?B?TUhtbmtUcnlDZHZEQmc5TW5OUVh5V2ZITmpOZlZ3TTVJQkJjSG1OdjdORXJi?=
 =?utf-8?B?UytFVXBBdTRQQVlGLy9CVjRTTHF6by9jejNvM09oT2hjc0FYeXhqN2NmMmw1?=
 =?utf-8?B?cmRtdGdQZERlNnJXQWE0L0QrRDkzRklKbHBGaG02enBSWnBWRTJ2dDU1bWNQ?=
 =?utf-8?B?ekJ1dW5OdXdEbDF0OTVBWmY2R3Y3ellGN3dDWTI0bDY4VWlzb2xabkVnZzBE?=
 =?utf-8?B?RDdZZGZzakFEdkc0TFZOU3dLTTN6MkRBYWFGbzNYOFZ5OTlzYWFFYVIxWmE5?=
 =?utf-8?B?TWZiRlB3dmh5OFRCWFIyN0NDdHlDbnB3RlE4cWlrQ0tUbU1NQ2RScFl5MDVi?=
 =?utf-8?B?bzRVNjhsWkZWSVN5TnQ1ZGh6cmsvU2JNeGY5cGJWU0cyOG9FeVZiTVMyV2Qv?=
 =?utf-8?B?Qmg2ZitCekoxSjRLUENJSGRyaXBxRWNvYllGWlhXK2UrV1gxVERzTFlHc2RF?=
 =?utf-8?B?MWhIdDlHSDdvUjRUbzZIUk9CNEgzWU9sNEpOU2luL1VQWC9ya0cxczA1bWNw?=
 =?utf-8?B?U28waGR4d0Q4Tm0vdFI2dFB0d2Z0ekZ4bkJNM3VpNzJwMklBQnpFc0p0WFRa?=
 =?utf-8?B?N2RIMEwyTWJmNk5kZWlyT25PTEx5ZGZ4L0J5SVd4V1lITzQrM280aHJjd2M0?=
 =?utf-8?B?S3c0d012bSsrdStQT2pkalJ4OHJkdXVabW9MTVFjMyt2bmhMSWhVTEJld0NE?=
 =?utf-8?B?Yy9UeXdLMGdrQ0pWLzJDbEs3ZU91aW1jLzBUVmVoY3I1NWMwMFdIRG4wZlNr?=
 =?utf-8?B?OVBMVS9FMmRrdnpDTUNUcUdYQklaMjExUDF0Z3JkNXNORXlRL216eE1YSnph?=
 =?utf-8?Q?x4TYdp?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:08:41.0022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c177b55-54af-4317-2cbf-08dddb2b4ee9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPFB768BB21D
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
Set OP-TEE load address to end of 1GiB RAM for phycore-imx8mp as the
board is supported in a 1GiB RAM variant.
For the imx8mm boards, only 2GiB versions are supported, so the default
at the end of 2GiB is sufficient.

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

