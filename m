Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A21D0EE00
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 17:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FFE8410D;
	Tue, 25 Nov 2025 18:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CRZcD/nH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAE284117; Tue, 25 Nov 2025 18:23:35 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431A4840ED
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 18:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFg7KxEwpIomP80nURSZjhfJH9YY/u4c0RyHoD8yaAv0Yw3hLtII6iLdrtTrdQe0eZcD7FWCGFGtUqlTGcrOB8BBWW+P+UabfkBaI+tuT5gECmyQOryeUzwcKuVbSE9r317iOO0pgpZqYOOeWg4NKSGemOHHKhLweVwhepdyLlzGaB6AvWfB2gaDrpmsneinnxdk1fC1jeNCQ8kFu9GIgNafPOw9vobyJQfAUEnvSU6nRh6v8NUpIgGIrxEanyjVfXq+QxbidZs2VTm2JdW4IRPWPEc2W72BnmJjLDSSMjO+AMBQ4cGx0XDp8PYdQqXvHaCTXxXQc/ycq/nMV4zsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAgJqoSfKn1CIswsPKy0S+W4dQN7bRzrctOweUPQi8o=;
 b=fE9ngQ+Jb4PIY2cxn5r61evypgMKFxn2re3VeLyYPrIiqwQQJArNy1HUG/4ZViUCSzHcJydC9Ix30RwOZI2bMAHz3LJGa5W8b74AMkP2iewV+lUFjsEoAZbCln2FGHAWg0l7kedp2AAlDssgtzHeKOeA3W33ZUchS/ssF534yDIhDr1HR5cZiggFTDwvKhi7OEhqt89qZ/cz0WbrQWC5C3JIevd11stPz+dKVZ/ouo2MzJge7v5+ps4fhTb3hPZtEi2Bl55biVKqXuUKBA7+f5PLsEhUNiiU0CNOR6ey1uy7SVteR5dYscsc1AeM1RA7wswz7GE1JRQtDAH/Gorfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAgJqoSfKn1CIswsPKy0S+W4dQN7bRzrctOweUPQi8o=;
 b=CRZcD/nHO9CgSNihKFbKEAawYB34Apifpgii02EO/+oEYlJox39D6UoVWZxjwCM1R5+EYtcrJesmpXyIyzl3fADUfKazEQvS/vbpADmEhV3klGlbf0Y46xetU318+dGHwp+tOGF047l7udmJRLgZVp3L4c3fR7LwBTxPvM/XXt1ts0vXaESyB3ws6PAPaiQcP1ko97DoqEWHRqYA14RghIOOuc3/YayIuwgnxysOxv/6KPUz5ysHDjWKcHJmJbAbS4Uyunfxonq/OnK0dvSWVBpqTXxIpD/aA8XHaz0XZd2pFeZIQkaUNY/DgaofgKGl6UiuBJP5SYmtav4PlkeMcQ==
Received: from DUZPR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::12) by AM8P195MB0788.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 17:23:30 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4b3:cafe::6d) by DUZPR01CA0176.outlook.office365.com
 (2603:10a6:10:4b3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 17:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 17:23:29 +0000
Received: from [192.168.2.141] (172.25.39.126) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 25 Nov
 2025 18:23:28 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 25 Nov 2025 18:23:10 +0100
Subject: [PATCH 1/6] phytec: change preferred bootdevice dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251125-wip-bhahn-imx8_cleanup_env-v1-1-414829c01b4b@phytec.de>
References: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
In-Reply-To: <20251125-wip-bhahn-imx8_cleanup_env-v1-0-414829c01b4b@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Peng
 Fan" <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>, Yunus Bas
 <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764091408; l=3146;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=PdcaWHIxBBGXKh+au0/052u7n8P5FgjaeohmXBv1Y24=;
 b=6u3KTRTpNDv0nWYVm1qBH17qFVGRZKUUG5lqCAt+mKoq67VH+aY1VVxNDSFgcdfe/12GgqpaL
 H8AMEdmIJt1DI6MvDrfl1umw6E7dMMgj/9f6N7NyAKdTNvU4JIqGiF8
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.39.126]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AM8P195MB0788:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9eb9a1-42de-4edc-8af6-08de2c475a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjIrdlBPM1dwSkoxb2Z6NDhXQk93K2dEN2tuM09YRCtuRy8zbWpPUEtvTG9J?=
 =?utf-8?B?RHphYTRhL29uZTNMOEJoSWZ5U3NHVlM3aWRncjlLM3BLUmp4bFNoL29uVm5w?=
 =?utf-8?B?dHdNYzZoNHpLQTNUOFN5am5mNEpjcWN6Q2dEb3IwTnFDbUpSL21XaHM2Z2dS?=
 =?utf-8?B?Z2pGUWVuL1RKamRadFgwaXViLzR5SWlFTVRFWnU5TmczNUg4QnI2MXFtYmtR?=
 =?utf-8?B?dlV2bTZmZ0VmSkozN0dxbkc3aE56UkFCb2xMa0VhUG9jSnRNZ0loY2VWeVBG?=
 =?utf-8?B?S240cnM3SU9iME1pMlo0bER1T011SElZcVNQRHpvZVVVVy9VRWVJM1h0c0E2?=
 =?utf-8?B?TmJ1L1loazA2aG9lRzdBNVNlOFRNT1NJNE96enRqQ0VwNTV0ZFdGS3k4WFhQ?=
 =?utf-8?B?RG05enNQQWpGYklwRldiVUg0R2V6OW84TXJ2dDRZM1NDbGdLQ0l2MjU1bWll?=
 =?utf-8?B?R3NVdTRoUnBsYlFNc1FpYy9GajZPdktXUkg5NWNKbnJQVjVtTDg1U3piNmgz?=
 =?utf-8?B?Q1oyQlNrY0pMVTJrYVlLMDRSajQwMWdlc3h1WHFqWWp5RDFHRHJnc3NRYkR5?=
 =?utf-8?B?SUlubTIxUVhtYUF2SmhvTW95N3puSG80L1VxaW0zdE1WeURQUmlJK2JXRFIx?=
 =?utf-8?B?bE1RZGdGQTlHbkdya3ZqQ3UxT3VpSzVjd00vWUFtSnVuNVFMeFlmamU2cVlj?=
 =?utf-8?B?aktrWTVBcmlUaUZONkV5akFRZHhLNVAzd0tmOHJ1dFlCMGpQY2JXdGc0TW9S?=
 =?utf-8?B?WlBUQWtsaWk5UTRXTzBEcVRJUmU3SzluVExmWkV2dHozS1hBdm9tWHF1SDFj?=
 =?utf-8?B?WnczSXU4NHgvVDA1eUdWZlhmTE5YckdEdVo1RVdYbWcxWXVpWnJ6OHhSME5D?=
 =?utf-8?B?aG9OQmI5NVNPTk83MC9kdUQyQUxlelNpTm82SHVsRVJrNnBKU210OG14bnlD?=
 =?utf-8?B?UWRPdHVzWnpoQ2tjVzZ2dGtsRGFNTVMzRmRMN3hsaWFqRDY4YVcxRW9aNGRP?=
 =?utf-8?B?M3JlZzIrb2Y2eFgxRVlsNXRkanY4SU5Od1p6TnNVWnNjdEduOFZjVlBZUlln?=
 =?utf-8?B?M1MxVUgzYng2ZjJvVGVBUnNRTUxSYUZCaThMQk9UeU9wdFZ5cGZ5ZlBRQXVz?=
 =?utf-8?B?Q3doU3drWjVkWFpOT09OZTQ0QVIyeXdIZ0lQR2hoK0hyNzQxL0ZpSWxxanJS?=
 =?utf-8?B?UXhRQ1lMRVhucW1NdEJocGRwdTE4dUR2c1JQZ0hXV3RVNndqZy9NVWxlZTFv?=
 =?utf-8?B?My9sOU4yc1hrQ29SZkxVWW01RjBKSHRqL3hDQVlVblFTdlpWRG1PdlZFUWZa?=
 =?utf-8?B?ZkNJcFQ0ZEpjTElGcU9RUU1tTXhGczZrcG1qMzIxSi9jOUpjQzNwOUIyaWt0?=
 =?utf-8?B?SnF0MW9jczZ5NXhsWXFLWXhGS3NackxmNkw1cEM1ZE1rSmJ2eFdPZ0o4Mkgx?=
 =?utf-8?B?WklPOTVTbCswTFV1MjJoVGFUUTA3em1Na3JxZWF0U0ExbjQ3SGE4RDhmOWpy?=
 =?utf-8?B?L1NBMWxwaDIvVExJTUxqMDBDODlJcE5CQm1DMUQ5QThuTzR5S3pOWE1jMS92?=
 =?utf-8?B?a0g4d2xJVUMxMDIvOHJ1VENQemVCMC9mMzducUZ6UkUvTEhVRGwrSWRqK3Vq?=
 =?utf-8?B?RWo3V2UxS3E3bXNHdC82VXFsM3V0cHRQald5ZWN5UXoyWE45T2MzNTFSZkZy?=
 =?utf-8?B?ZS9SaEhSQ25BY2hFN3IxRTlKbGI3RnNMQlJTdzgxMmlFVGdsV3N5UDA4eXFS?=
 =?utf-8?B?YTdqSk5nYTFWcTVsekhaZ2JCUjFaemR2cjFmTFBGQzEvNXJWTEZnUWNpclZI?=
 =?utf-8?B?ZU1IZytPZVNwS3IyYVdWY2M0UnZ1cnp1eTZ6cTdQbmJjQXYrdDFKQlQ4c1VQ?=
 =?utf-8?B?WTlnMFhRNnViam1vUStLZDU5OFdlTFd0TEpSWkRhdXdRZkZCSkdwMVNIbUJF?=
 =?utf-8?B?djN4aytTdlh3ODlYUDExVTA2YUhVWjl6VmFycUNpQTV0bDZnRURJTXNXWFpr?=
 =?utf-8?B?N0NJYUkzL1NGTjZhSGEybEFoUkNzQ1Q4S2JqdFhOcmVuQVFJYmo2cTgvSFVS?=
 =?utf-8?B?TS9RWEk5bll4cUFVUFhJZ3hyS2FwVmdqS1dkMWNGWE5wTnYweE1NMWt1UmUy?=
 =?utf-8?Q?lXpc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 17:23:29.9332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9eb9a1-42de-4edc-8af6-08de2c475a27
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0788
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

Change the preferred bootdevice dynamically based on the device the
U-Boot is loaded from. The same way is already implemented for
imx8mp-libra-fpsc board. Also let standardboot set bootcmd variable
automatically.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/phycore_imx8mm/phycore-imx8mm.c   | 2 ++
 board/phytec/phycore_imx8mp/phycore-imx8mp.c   | 5 ++++-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 6 ------
 configs/phycore-imx8mp_defconfig               | 1 -
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/board/phytec/phycore_imx8mm/phycore-imx8mm.c b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
index 06cffbca3a69..7d569d475e63 100644
--- a/board/phytec/phycore_imx8mm/phycore-imx8mm.c
+++ b/board/phytec/phycore_imx8mm/phycore-imx8mm.c
@@ -41,6 +41,8 @@ int board_late_init(void)
 	switch (get_boot_device()) {
 	case SD2_BOOT:
 		env_set_ulong("mmcdev", 1);
+		if (!strcmp(env_get("boot_targets"), env_get_default("boot_targets")))
+			env_set("boot_targets", "mmc1 mmc2 usb ethernet");
 		break;
 	case MMC3_BOOT:
 		env_set_ulong("mmcdev", 2);
diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
index bf2d5ce01fa5..25cf889d357c 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -76,13 +76,16 @@ int board_late_init(void)
 	switch (get_boot_device()) {
 	case SD2_BOOT:
 		env_set_ulong("mmcdev", 1);
+		if (!strcmp(env_get("boot_targets"), env_get_default("boot_targets")))
+			env_set("boot_targets", "mmc1 mmc2 usb ethernet");
 		break;
 	case MMC3_BOOT:
 		env_set_ulong("mmcdev", 2);
 		break;
 	case USB_BOOT:
 		printf("Detect USB boot. Will enter fastboot mode!\n");
-		env_set_ulong("dofastboot", 1);
+		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
+			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
 		break;
 	default:
 		break;
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 70044997adb8..323199b041b1 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,8 +1,3 @@
-bootcmd=
-	if test ${dofastboot} = 1; then
-		fastboot 0;
-	fi;
-	bootflow scan -lb;
 #ifdef CONFIG_BOOTMETH_RAUC
 bootmeths=rauc script efi
 #else
@@ -12,7 +7,6 @@ boot_targets=mmc2 mmc1 usb ethernet
 bootenv_addr_r=0x49100000
 boot_script_dhcp=boot.scr.uimg
 console=ttymxc0,115200
-dofastboot=0
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128
 fdt_addr_r=0x48000000
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index c497f0bcd913..2fcf7db9e5c8 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -38,7 +38,6 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_FDT_FIXUP_PARTITIONS=y
-# CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074

-- 
2.43.0

