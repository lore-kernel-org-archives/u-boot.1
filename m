Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5FCE9A742
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA02D8352B;
	Tue, 24 Mar 2026 10:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FNoOQ706";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEF88366F; Tue, 24 Mar 2026 10:14:56 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554688352B
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ork1WDHsIkIUDWg5FT/UY+CzQ9MTD3Bm/ybpK9vxV1micp+rpGzJid45YM//4G1ZRcOFP7AYJYl2WRsxVobkx+l8uLyT5p4nGE5FsOnvSZZoe3ZrvpNyl95wVbsY24FgkC5kiP/IBtR5OT8KfUF8HoL3K9i1ooYAlWSbiFiJ6OUYnEx4ROIVknXlalZWo+blPYy82Zdl7HPbTW7KgHC9cgk+uwuKqUn8RX6CdraN9DypRYs0yQiFY/6KoKe8b4uFJ38mYMRbxtRQ/PZ1QsNp3E3EfOce1szYlgHN4XpoXRPz99kJY4vjYnfpEQceo5mb+qp+Np59f+IDUOIVbJqDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u88jk1cjVgz8ZBL8JSLvml3cNBuJMxSvdyfADeGT6dI=;
 b=HBKavpnaMyNoxpzaljSSQmrAjlRVDZlCvaDJSVSFrOayNazCBU8xpF4vlkRbYhfVORSZpif+2CIL5HafyNI7yVF2T2/6/nvYab22XEaWEnMBipk4o9HWY2J0CWGbVl9dwkNNsCiQ31RVkTWhGMKjHsSadAqiBalSBqjh3qe81p/NNiM6TRD5BOt+fVLJv7mjJfGQNMPFvRD1bUsfMelLR75As28o+ywssn/MV4xyofI4S/RzYaNsUU3yWAqcKCC9mIZM6IKK6yZ2Vnv39uW+jb1+ZcTkRwUktOXxE8Fpx/1zflBw+lW0juqGg0SbBjDCnuSzKTWuUCSHAGmyJRnijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u88jk1cjVgz8ZBL8JSLvml3cNBuJMxSvdyfADeGT6dI=;
 b=FNoOQ706oVc6PxfjKjhe/LYNQLOpbTxFRiLX1zN5dpYqdKXySyd4q97W0F7pTypB/3Rq07NuDJ2+Oyl9y/E4a3WgXL5HfwFkk8NwEpVCMxVO5TLqvZ7AaxRFKEOjdyqt5loOowlrAATrOSNI7WF4QhyT2ubgISdPjxZHVVQbwYI6eY2/tkxgxpC8LFk2abFxGc6qm91IHJxJR/s/726y9qko0asjTmEqVd3TDArA5H+BCmn7nbSfDch/FDSQZiRF5YSdzwnbMEU7nBZWaAo8bE2XoGZpdQTPC2+qhBlBm6SY58Mf7BN7x+HrIxl7PUlME80qDmhvNW1Lg0ySKizn4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:14:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 09:14:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 24 Mar 2026 18:30:31 +0800
Subject: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
In-Reply-To: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8a6779-dcb6-40a5-04c0-08de8985c241
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: IHSLkbIVV8AWr7RSW3NrgtiY/tXsMuFxP/CX7KXKCYu3HyJJ6Nf8M4dgbsOzgdYM68oEY22S88NcIBE+qEsoJzWrjdaQc90r6C1wEqhzYKqJ+flsidfFxiGxD3LTncWdKfv1aVMf8KfpeGNoUHQyxSZolEQ48YqfB/hl5IROuyhpffesZLduPM8VIkAzzaPAwuYI7V1W3UAfP5GhjeVBil8ulXxM7OUP6x75hOPxr/aS8aocMfXEP8223mIaae9IutOrywtYQMRYLdmuLwkTy1bzZCCbQ7plP3FY2eq2oWkniiHN2FrZqb33uum3skKxZM/ft2c5uZN8KIScJprIwKt32RMGqiolLDcSzk884ngHSShr/g6Ubv4wyQMDHW/tC+Ewi9wKNlegbr9lDogH9Zcr6zVvjGRLQ5ewwP7YzTp9ZcRKvlpe8cIiRP2d0iuRuh0VYlaZutBWm6BuSeWNy+QtJSGLqQ5XWjUsjp+6mwiSmFk5Qq7cqmsbKpMaT6ZJIrETK9o1ezJQbu9KAOm9GRYAG2Mg6cJDVL9sM2eEM5SKnjP21x0aH31O/hVMgX4YeZFNvvLv9hYoL5cJxoBAekqHDO5BRIbPmgvcztT/58J2V6Moa/syHqRDEf2Ly/cs4S0+ZbPhDCwA3YQ9li4xY88SClZQocC4/4TNQ1a4peAzPKM3n65EFjMTKVXl1vgfdtL39M8U2a2b/xnodV8la07dpp22z/zQIRS6y024MdXEbR6shRq8GN7gDNawqWsY6pB5FC+e+10o7XdgDOxDIbqWaJuRLWDuY+MSqG0Y96E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0RPVENrcTErMlJ3bVJtN3lDWmdSV0ZyMXFEUXZtcXF2dlZnVUVNRVppeUhv?=
 =?utf-8?B?T1o3YVozRDZtRVNMLzBDMllGd1VtdVcyZms1MmtRdnh3cUpzM0Y1dGdRVklS?=
 =?utf-8?B?enRiU0RWQmtuZ3NsS1V0K2swYzkxeUM0emVzQ3RkVjI2djZXZHdvNzFZQlVQ?=
 =?utf-8?B?MXgzVFNKY0NGVHQxd2ZQc3IreDlIRHJzNU5GcVExZHpzZVVsK21ieXlSZGR3?=
 =?utf-8?B?RlpVSFNDVnlmb2Z3T0tsb3c2ZWJKNW1KUGtwZEc1a2I3T2J6dUdrV1cyOE9Z?=
 =?utf-8?B?b1VaUytwOXhBMnBFclZuTG12aWtURU0wL25kYW1TWldlK0FSRHVKdHlRN1NV?=
 =?utf-8?B?K1pvZjJxUXZtTmlMQlp0ZWdjbGVUZE9oRkxWeW9UZjhPNExmL2ZvdVFrTTdX?=
 =?utf-8?B?Q1R0VEFaRmNWdTlMTE01WkEvclZNOWQ1ZXpScC84ejQyYTE5MFllQlNtaGlx?=
 =?utf-8?B?Y2Z0ZEcyaURzdWQ4RHZtQ2l0T25xdVEvWFRYaFZIZEwzQldUbURCL1RmSThv?=
 =?utf-8?B?cHZIRUdjWnVDVmVTYVhKdWY0R1NoZzdiY3V0MFBFS2l2OFYwb1RiSEk2b3Nx?=
 =?utf-8?B?VzRHdHJlUFR3MzI5bWVQN3hIMkFDU1Q5T3JPczcxcnFvV3lTT2wyOEJ4YTFC?=
 =?utf-8?B?VDcwN3hBdmJ5SE8xSFFXbEtOWXFGQWJpSytTQTBEMVZSdVJmRWpHeGY2T1BJ?=
 =?utf-8?B?cU9aY0xmMUlZcFd2Q2w3SUZpWUhtVDJOWmh6dFdIbTdVa0RJUmZoay9aUWdE?=
 =?utf-8?B?VTV2TElnR2U4Wit0VkhLOXIrOGNWaGswOGcyWnBBVzNnRUtneS9Xa1lhYmY4?=
 =?utf-8?B?WEY4YzBaSmdXZmZITmxBMlpkRGJkeEpZaHl1SmVsTUIyM2VXZzRPNTd1czdC?=
 =?utf-8?B?aWIwTHViS3pTeTZUajdYSEx6QXN6VUM4TWY4WktDb2JpekVFNVNSalV1S1Fq?=
 =?utf-8?B?WnJjNm12aWplR2g3alVVTEx3RzhsNExHazZZUzNhM29MbHY2ZFllVVh3cEE5?=
 =?utf-8?B?TzJ0eGZLbjY5dVBIQ0QycVlEeFRHMjNtaUxxRjNpemZsL0tod0NZTVB1TEsr?=
 =?utf-8?B?Y0l6WFhuM1NCZG9JbGdhc3JlRkY4enFybzBiWHk2RFJxWjNQRDlEU0wxZHB2?=
 =?utf-8?B?dEd0THlpbmRLTTlXUG4rczB2VTlyWTVTRGJNLzA5cC82WWlSZm9nYzNhRlIz?=
 =?utf-8?B?UVZTUFlQMFRkdTQ5Q0hYOFZqNWxjM0tRa2dIZkdZOWZTVlg0aDAvUU9YN0M2?=
 =?utf-8?B?UmM3SGhVQUcwSHNiWGl6YTdqeEFlNGR6UkdqUm9ub09ONUVscVJjZjFqSTl1?=
 =?utf-8?B?WjN5ZnhwamxjeXhMRzVLeFlnRkRtUWdpaGFCcjlBbnl5RFB0UzVadjg0SWt5?=
 =?utf-8?B?Y0pZNDIwOWpOSzlFbTV2OStLOFdwWDFibytUSEMyNWdzQ2E3a3JWcnZZN2Ro?=
 =?utf-8?B?UlIzaFgvYlNxNW9lUy9OOHlWNElBN29wTFBQRk5SdVpMU3BSd2U5Q1lvTm9p?=
 =?utf-8?B?azN4bnpmblpzSDJvN3NzemxFc2NrTk1jeUM4MHVrYXVQYmRidGNFeTdvQWhy?=
 =?utf-8?B?dmUxZ3M1VzJheCtDUGpwLzhIMG12d0hsYUprdFd5dW1aZWNwVDIrT3kxdFJR?=
 =?utf-8?B?dmxYTUM0ZG5vSUNkWGtKTnNWdm1wYUtrMUoxMFMzSVdKaTZMMGgvWjlaZ3ZF?=
 =?utf-8?B?RjVOQ0kxaGY5aXhvQitzcS8xc29veDlqRHl0RTFYQzJNUDhhNkpSOU12bDdl?=
 =?utf-8?B?M09HbXJFWlZycFhtRkNGQXlLUFlYaXkvTkZycGlkbjQ4RWFpblpNRWxYRHN3?=
 =?utf-8?B?K2Y2a0lVRDB4MC9LQ3FjSVJhVWpBOVFhZ3k0c1ZaeUdZdE5mY2ViOEliNTZ2?=
 =?utf-8?B?VlcwRE9TckIzWW9PallJVzBTWFRHQldLYzdpaWM4UVpTOW5aWThGZ3pVYkUw?=
 =?utf-8?B?WFlpSUVaTzVyTmhOSVBzZXZheVRkcllHb1Brc3h3UDBqRUZHQ1ZISEhCU0NR?=
 =?utf-8?B?MVJXaG0vMzZOdGxXeEJ0UDlKYTh1TzdNYnNHK0lveDgzL1NjMWYvZ0RkMHJT?=
 =?utf-8?B?Wm0yVDljQ1ptVy9FUGtxKzg5MWdEbFBTcU1DQ0xNakZpQXYzSmd3ZlhMM01Q?=
 =?utf-8?B?ejdrRTRZdG9FQ1JObzJsMzkwNVNKZFNoNzFweVFaVWVXUEJBQXFET3p5c3ZU?=
 =?utf-8?B?ZVhZTFQvNmdMWXdoNENpNzlyMGFkcVVJc0NuRlQyZUVoRUhkR2VZYkRyK2xt?=
 =?utf-8?B?TVh1ekVMSmhWbVVFU2dKSHlyc0JXM0MwT3VXT2IzUDZ6cGtLREZBeFJZZUJw?=
 =?utf-8?B?dkhXMk9nYURiUGVjMTVraUJLTXl6YVVVRCtPZ2o3TGlHVCtPUFpLUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8a6779-dcb6-40a5-04c0-08de8985c241
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:14:31.7733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OelgFYVuDTVym2dxsRjhnHx6IvCRTTg5x+cL7ToO6+1vibFKLjVqNJPCzesHaB6yfvv6sw7MzvmzyaPubtoZ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
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

From: Peng Fan <peng.fan@nxp.com>

Convert the board to use DM_PMIC instead of the legacy SPL I2C/PMIC
handling.

Changes include:
- Enable DM_PMIC, DM_PMIC_PCA9450, and SPL_DM_PMIC_PCA9450 in defconfig.
- Drop legacy SPL I2C and PMIC options.
- Remove manual I2C1 pad setup and legacy power_pca9450_init() usage.
- Use DM-based pmic_get() with the DT node "pmic@25".
- Update PMIC register programming to use struct udevice API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 16 +++++++-
 board/phytec/phycore_imx8mp/spl.c                  | 43 +++++++---------------
 configs/phycore-imx8mp_defconfig                   | 10 ++---
 3 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
index 4804a204e92..871e7fd674d 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
@@ -34,6 +34,18 @@
 	};
 };
 
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -83,11 +95,11 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pmic {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usb_dwc3_0 {
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index fc7aefd0073..fc6f5104925 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -117,45 +117,32 @@ out:
 	ddr_init(&dram_timing);
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(0, 0x25);
-	if (ret)
-		printf("power init failed");
-	p = pmic_get("PCA9450");
-	pmic_probe(p);
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
 	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
 
 	/* Increase VDD_SOC and VDD_ARM to OD voltage 0.95V */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
 
 	/* Set BUCK1 DVS1 to suspend controlled through PMIC_STBY_REQ */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Set WDOG_B_CFG to cold reset */
-	pmic_reg_write(p, PCA9450_RESET_CTRL, 0xA1);
+	pmic_reg_write(dev, PCA9450_RESET_CTRL, 0xA1);
 
 	return 0;
 }
@@ -193,8 +180,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 2fcf7db9e5c..51d9737afb3 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -10,7 +10,6 @@ CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
 CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
@@ -113,8 +112,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -144,15 +141,16 @@ CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y

-- 
2.51.0

