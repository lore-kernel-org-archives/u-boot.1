Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAAAC87FCC
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 05:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CFE83013;
	Sun, 27 Jul 2025 07:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="USi0USmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F4A83015; Sun, 27 Jul 2025 07:35:44 +0200 (CEST)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22588300B
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 07:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cib8KTnX0BntiaEwgAAOqVrb/K8t2GB0ylcAsx3iJnMRgNa+8kHImRx/VShpb2T/W0GJPZobuI3WCkWmkMJeHINM6s2Y4ngl75MEncLzJTvO2wsmHgw+SShO3i3eRXp/ar/wKTSWDsWo0c/f8WdmmpA/2z13fZUxucU2AlER/KRNkLN/qdvJAyqVssv5cKLt9+1f+OTfd3mW/r+FvhJ+9GdkzZ6i7utTAECm79Fkep7llIGSLYfKOZgOKRCkeL+uU4sMll+UmRb9gR6ub5RAfBl2AqWe0xE+P7UCZOfcfjoG58ZWQ4RgNm1BKAQ1m/dpC1vL30Demz5r+9q7Ty8UmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slmFugexL1nx8XMWowmMnx1Ix7rwc2oojhpHbZspTtQ=;
 b=HsURYUjKcC1BV9lcKiwWloVDFTro25jXm11czad57fHz2cxvz0mkBasMwttAYfBRxL5zq8rC+hVkdVbmfTnozZCcmgWlcg9k/OnaYj+3bZvoV9/YlFus3p/M77V0P9VRGnnRP2u0kAY6aAdRxzlW04lcSc0DSSB3E0ojz+ERLtebRvS6ypdYVlHbAQFTjjHXgsyJAS4H+kd+vI7O55wfBNFZWTcJZ51xsVxpdpt3/0KBjdD4gw+0rw9mvh/MwryLqvE8rmkR89KxXiNhKvUJx05CfGl26YS057y78nYBgzXw34F9SCssZmuwcrhfOZ9YteRzQyHH5Zo3M6UDJ2fhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slmFugexL1nx8XMWowmMnx1Ix7rwc2oojhpHbZspTtQ=;
 b=USi0USmWAdA9KdtR9cT3qyXN+dqKrPS4iyDvDTdWaCMkVnf+qaDVoAMxYTOL01CRniWO8ROZJyfmYwB6XszsU/0OtdvPDyxODBuWWK4tDIR73D5pdUMMq/GOb2H1VPlzt4Qmvs6iI2gO+EvrDgVyWb3EZPLlX7W1qUblkk99Iy1EyGl9RCjHqLYF/wUD7H/6TuNQI9buZkWE1QWLakWyGtifDfN8e3yuzVfFvFZiPSZvDn5qIe9fHAQkPAIRytffubdsXpN53sn3MJ364WSYCyjID+WugcwVgJoFcu6fF4Kr8+ttvrOZ1zYC6oiIrtunpve3hcUXEZHG8P0xXF3AwQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TY7PR01MB14995.jpnprd01.prod.outlook.com (2603:1096:405:253::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 27 Jul
 2025 05:35:37 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8964.024; Sun, 27 Jul 2025
 05:35:37 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 "SkyLake . Huang" <skylake.huang@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] arm: dts: mediatek: remove useless SPI property must_tx
Date: Sun, 27 Jul 2025 13:35:13 +0800
Message-ID: <OSBPR01MB1670FAE7E61614CB66C47D79BC5BA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250727053513.16104-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TY7PR01MB14995:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c78b7b-b7c1-437d-37fb-08ddcccf6767
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|15080799012|41001999006|5072599009|461199028|5062599005|52005399003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lRq6CDCSgDaFh4acKR/dzkdkN+umrqzty6WAVuDLkTj15tN5DSvT041DV6VC?=
 =?us-ascii?Q?d5nh0qhvCxkuwzVmyFrpOFrnQbdmSiHvH8+pbC7EaJCGij5myydSqI4oMANQ?=
 =?us-ascii?Q?YeHH3FoABy4VHueJz1bDVtwEzLwj1wysnNGdZox0jDrRqBnAGloJbNj0SKSP?=
 =?us-ascii?Q?cHEn8X5LsxIE2KPaehtoov4uFFJMRKmQMYNOC9SdUYixCFT4dtR3WnYtVjga?=
 =?us-ascii?Q?2/wgccD+1Y5lCZFcQ5yIQYEqaJqg006Zu6LjV9PAiu8U9+pH5RQO+43dJjXn?=
 =?us-ascii?Q?J3Xs7DOo6uIh0DAGJEuOC/XHb7OQ/Jn9Pa9H7PX7/a2C7dPQwqXIG/iL7zH1?=
 =?us-ascii?Q?MDkz880BHEhdkb535RzoDve+AQRYUl0u3DnbexmQwL7CZcdJl4CW93kz7K5y?=
 =?us-ascii?Q?nnKFI3p2EzuZg1XWef7NGX9qX3UlyNwWQUcd+BXoVonWGnrPcK76ukmR8R7j?=
 =?us-ascii?Q?LM5U3PqMfj0nuCijsuDIGJuMdUtsQ8eCfWAjYycPmZBfoWrumYIdU8JzbpbP?=
 =?us-ascii?Q?Lk2YpwZLle/izw5aBOGPhksfwEl8dFYBzyHALDTarYD+qbR+vUsAPp7ne+va?=
 =?us-ascii?Q?ABNA8Cvv8/VIxS3+g4akOyTCZlZ2XzofL4HBtA2q1Z+YF6YMhMh1PMR5g/D7?=
 =?us-ascii?Q?vMgvIY1j+oQCOA4FM6yzXAMD9gJDBLBuD93ywsldooB/lfDeew4lcWLtIPt2?=
 =?us-ascii?Q?k4m695Xqj7VXHdm/q47zWUsPztpf2O9u8/bw1irnTwhvCE86zqxSvC0Ec5R6?=
 =?us-ascii?Q?aNzK0dPKyNOKQon1Gaul6fek8uIf1xqJx2WCm1XpIFZOBNc7dhuT1qKEQ6C/?=
 =?us-ascii?Q?woRcyr1xOqdnffZI9G8KT7hxa1fupVsz0hloFbFescVv4L4LdBtdvIHn/Tp0?=
 =?us-ascii?Q?ZuOvw/uUSiIdvqbFm8JIgqzmIeSRs5u69rL6gZ2MaHUqp692KGMBV4mFkcNn?=
 =?us-ascii?Q?zokLYO2h7ueHnFsRfbxO+BEG0MwScv3AvIZId7fXhn8Z/vhKhlqoYIoRzsrl?=
 =?us-ascii?Q?+RzL/debUmWKzoS7dmh2ZJDFcdw328Y6sV1kc9YrhP/bZs5d5TVO2RDzt6N6?=
 =?us-ascii?Q?1emMwvtjeDKcSoMm4RmGH7gEyBmzc8XuzPQoBEg7u9kaG9DcCUQHp50tfVlz?=
 =?us-ascii?Q?b+lo2Jxvq9k+p3ERlDjT69Pzvv7caon0Wrn2Lw1ZFwjWkEZVLXPBmFgGEkuz?=
 =?us-ascii?Q?IRCgZYdFKk3PQ88Wef4A1FI2gSWrsXVw4Ov1eaayXNzBn1U0z8f4Dqi6VVM?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNmaMn+lK/WLgINfhiqhKxVN8r02acpYq53grttUCnL2USdRNOetT6VbY+4w?=
 =?us-ascii?Q?1cAnkZzaDhZz3OKYw6SjMnk/Z1NsYOqoDpSNZ6eXN8IgyhIfxBpBdPCiUsKt?=
 =?us-ascii?Q?rkncWfbH8arymeFHacJbTr28E1zCQCcSytwDgEW6Pr1WIXKlyl3756QvZ0k8?=
 =?us-ascii?Q?CpVixndDRTr0R/TA+COW3zgYd0smGYqfPd0l1gYRHaRDX2oy/6wnew+Zl4Dr?=
 =?us-ascii?Q?t9cZIdQkAicWFn9H8sEnay4kCsFJAx8m5GOWOIpKl9tELzasWNkdSSlo8f2U?=
 =?us-ascii?Q?VQGLJdkThdqr1oF5dVxjyKsq+7QOyaZKHn08cmtlzgVgRcVSGa7cL2yZmeBp?=
 =?us-ascii?Q?bfbHR2kiWKaWEb/mUYYLM6OwGaZ657rlhMrgoTOILHmflhNxhj3m+C2inSeX?=
 =?us-ascii?Q?9DrWS4SzIcCrb2P+fNkO8wY/fnIuoyaDQdc3Ue+mNxpwtOStwpfP2F+fH/oB?=
 =?us-ascii?Q?TWHGGAEdIID88ejLLwOmO5rDqdcIsPql0OH6ALD0UzFF6jUNciHkZocM8kK8?=
 =?us-ascii?Q?U8ll2hFYWPysh7XMPwAHglavarjrLBWKfsFE3w311jAnzbgwPezJResOHb4M?=
 =?us-ascii?Q?0mWfEdcnu/e8yOsBTIkG0bEHGht7YSdkq9WYwQoz3/DW4znCviUgkkIQolrf?=
 =?us-ascii?Q?x5yYHwzeqb7DOzz4JZUcamkTmjL7cGy22wpfCxvvqDgtURI3x+yvnm9Z8jk4?=
 =?us-ascii?Q?t0kkSA/1WVwFTmNO3n3/l0ZdggnnBveSqstq0wXwYQJih7mpeOrhEfao2Ze2?=
 =?us-ascii?Q?p9c9/jrYKBsV1AND25UTC2ui75ScaYRtsqv33tLNdtcImkQWqMXwfNv8UR+g?=
 =?us-ascii?Q?OsK+KNgqKyvU9Vk1vF6UXP+ScTcNom3VLMPumEnGXEtJHZf96+5vfIO5wUzC?=
 =?us-ascii?Q?8biqmKLtaypj2FxQVwhD/KpNl/MOv53KM4GIFC3vZf7j9Zqap2xtM67te7F2?=
 =?us-ascii?Q?apcQ/455PZBNPw0DUZ55cNVNNCBXRMVb8VdbrE/RCkLkK2fnT0mNfgj/VARC?=
 =?us-ascii?Q?hxaaviDa7bcpfBDbJTIHiqz0uRgZNG4WBDskXnQFAKgR4FiFD5+NaJqJP9AX?=
 =?us-ascii?Q?FR61jDPpY1C8WZSd1zbvD/6IGYLeihdlSGEmRwA7Ta+Z4gDjhkSFaDYR2OGh?=
 =?us-ascii?Q?rziIoEdX2gObW5mKBt/dYjzSxFnP3sgy7zfM46prs/Wwxgw604bQcvTxtM3Q?=
 =?us-ascii?Q?dPZG5RUnNIvYC72DtgiR8+pYEz9JoLf9EcFDPipTQZ+b0e0gWtpPJwrPKSNQ?=
 =?us-ascii?Q?2t+kXFIYQ1NjtfqbXOP2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c78b7b-b7c1-437d-37fb-08ddcccf6767
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 05:35:36.5040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14995
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

This property is not documented. And the "mediatek,ipm-spi" SPI
driver doesn't check it.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/arm/dts/mt7981-rfb.dts               | 2 --
 arch/arm/dts/mt7986a-bpi-r3-sd.dts        | 1 -
 arch/arm/dts/mt7986a-rfb.dts              | 1 -
 arch/arm/dts/mt7986a-sd-rfb.dts           | 1 -
 arch/arm/dts/mt7986b-rfb.dts              | 1 -
 arch/arm/dts/mt7986b-sd-rfb.dts           | 1 -
 arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi | 1 -
 arch/arm/dts/mt7987a-rfb-u-boot.dtsi      | 2 --
 arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi   | 1 -
 arch/arm/dts/mt7988-rfb.dts               | 2 --
 arch/arm/dts/mt7988-sd-rfb.dts            | 1 -
 11 files changed, 14 deletions(-)

diff --git a/arch/arm/dts/mt7981-rfb.dts b/arch/arm/dts/mt7981-rfb.dts
index 17e6b5af7a2..ad149a34437 100644
--- a/arch/arm/dts/mt7981-rfb.dts
+++ b/arch/arm/dts/mt7981-rfb.dts
@@ -139,7 +139,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_flash_pins>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
@@ -162,7 +161,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi2_flash_pins>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7986a-bpi-r3-sd.dts b/arch/arm/dts/mt7986a-bpi-r3-sd.dts
index e01ae4c3dc7..ab6f84a3ece 100644
--- a/arch/arm/dts/mt7986a-bpi-r3-sd.dts
+++ b/arch/arm/dts/mt7986a-bpi-r3-sd.dts
@@ -173,7 +173,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_flash_pins>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7986a-rfb.dts b/arch/arm/dts/mt7986a-rfb.dts
index d4bbb23204a..0d628a2e715 100644
--- a/arch/arm/dts/mt7986a-rfb.dts
+++ b/arch/arm/dts/mt7986a-rfb.dts
@@ -178,7 +178,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_flash_pins>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7986a-sd-rfb.dts b/arch/arm/dts/mt7986a-sd-rfb.dts
index 11823e05bda..632f8b9446d 100644
--- a/arch/arm/dts/mt7986a-sd-rfb.dts
+++ b/arch/arm/dts/mt7986a-sd-rfb.dts
@@ -138,7 +138,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_flash_pins>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7986b-rfb.dts b/arch/arm/dts/mt7986b-rfb.dts
index 0a731fe87fd..44524345468 100644
--- a/arch/arm/dts/mt7986b-rfb.dts
+++ b/arch/arm/dts/mt7986b-rfb.dts
@@ -165,7 +165,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_flash_pins>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7986b-sd-rfb.dts b/arch/arm/dts/mt7986b-sd-rfb.dts
index e5fb4d73e70..d5c4273047a 100644
--- a/arch/arm/dts/mt7986b-sd-rfb.dts
+++ b/arch/arm/dts/mt7986b-sd-rfb.dts
@@ -134,7 +134,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_flash_pins>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi b/arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi
index 54cf72b3bf8..dc3f70aad64 100644
--- a/arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi
+++ b/arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi
@@ -42,7 +42,6 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7987a-rfb-u-boot.dtsi b/arch/arm/dts/mt7987a-rfb-u-boot.dtsi
index f1ed51e21c4..fa02ff59f6a 100644
--- a/arch/arm/dts/mt7987a-rfb-u-boot.dtsi
+++ b/arch/arm/dts/mt7987a-rfb-u-boot.dtsi
@@ -28,7 +28,6 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
@@ -52,7 +51,6 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi b/arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi
index b07e6da41e2..cf1114e7d99 100644
--- a/arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi
+++ b/arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi
@@ -40,7 +40,6 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index 1694ef8d9c3..6176ef923b2 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -181,7 +181,6 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
@@ -204,7 +203,6 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
diff --git a/arch/arm/dts/mt7988-sd-rfb.dts b/arch/arm/dts/mt7988-sd-rfb.dts
index 63e923137c2..e29a9764187 100644
--- a/arch/arm/dts/mt7988-sd-rfb.dts
+++ b/arch/arm/dts/mt7988-sd-rfb.dts
@@ -108,7 +108,6 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	must_tx;
 	enhance_timing;
 	dma_ext;
 	ipm_design;
-- 
2.50.0

