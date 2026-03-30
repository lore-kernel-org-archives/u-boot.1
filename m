Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE0BFF494F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 12:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDDE83F5B;
	Mon, 30 Mar 2026 14:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BSYyAfty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0289A83D17; Mon, 30 Mar 2026 14:48:23 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E41D884010
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 14:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV6dXeYzU5dlG1nDMWei1mNO5l+1ETkFy08cTxIx2ep/CZcCXnAP2gUzaBd0paIFZP8wD/tKG0vi3VsYNF+72krMRia/zlePxziHFTUJ/45S3TbiUmOZ7wmF6ammy3fp1gccWndak8cs/GCepQieWemVTqvczzLVAh8nnwv3YtyqV2MdusNfswIlRu1yLq3+SBTkLvv77KJltaEDxMBuuKQMBrpufxmcHt8A32Gf1suXVtpce+d5onoGIhnqfH3khihZUmo91Ag6EPwRmUTJybbkY5mlIa4EPJS3GTryrsCs+K21TLSmKXeXvyKW9O7lIezfO0QPFx7G+/dzLCVXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emcO386Z17DLY51Ivm8ogG4JYHvJbAN9uUQeYwa/jck=;
 b=V4AT0l5YgGFMsTdD1ACCniX2Kne0XkJfOUwiTtd+LxzPylY/v9aorLBObLXQLjzh7p+MAHV9vc2/UkyC0KT7Yru+bgwrz5N245/tQEOdpZEkIOa6PAQQ8SuVf5OFc5Y+rna6QqBpXy/JqIeRwyzwJrPVdl0KV790dwjnJKdXe0Z6/jTRt7PXIh89XqDczRLexbcT1fpcu+wW0YRGocNIVQNCGDnukK/NfVuMfsIVWold7FnnGR/r96X54ZtsNt/es0i+rBF5CxyJ6Y4mqfKOGwXYax4hXF8VjKGGfv2u+s+xR1QahiGAE7Oc0JPOA7vBkB+O4J7UNXrhkyhNmq7IHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emcO386Z17DLY51Ivm8ogG4JYHvJbAN9uUQeYwa/jck=;
 b=BSYyAfty400bhThAwtbwADlG5Wnb7uykPI7V3/XUUCnyIv2ZAMd/5UQEnB6FAUYwnrNcqjQv0cM66bV5Bimhfuy+u6emfpTlJyBjJfRK1i+IJNyXpGPxrmrCphhlHwAn0JpwxnFxPnjDOnChZ79h5CjDdOdn+zzViNjHJTlpytAAYIKuXQs38XzRhx5/ypJ0zmqnqaO/NERCoy1lsVBdcSw0wqbvEAlQtQsH6Xj/DWas8cM2XeIQ6b31Th/0+MVvYcemv+Wi0rpnYGWV6kNs1RCTb8qdzd/EniCIRz5hmN6fXgQqQwJAg7ojGM9tuwG4gEw2XHj6Ab1kEjqnkkNLdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:48:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Mon, 30 Mar 2026
 12:47:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 30 Mar 2026 22:04:04 +0800
Subject: [PATCH v2 2/4] imx8mp: verdin: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-power-legacy-v2-2-47dde3182a2c@nxp.com>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
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
X-ClientProxiedBy: MA5PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9962:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c034663-b95c-478c-e819-08de8e5a8ce3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: hos1y/jc1e92Phfc2+tHaVYQAIkBCg+HfqK41vqFxKc4LrtMU4jkvv/5PZbsk66nfakoPaMgZYnTQTkdhZXY0jWiD+z+7fONjvffW9A4Pibv0OUwu2BRYeZBbumH2oaiE1hYYT7ze34iWZDE3CC4orQbF+35g0Mk9EFNH9Zd9sH3c4unuLzH95iMQSH9CyBsTwOrQtWqiUs0uJ3xEwzQes0ljI+fVAvxpZAfm8H8poQpwe2tadr5Fro7oZNXnZRUydWGh/+ZL/X9dFXgg3gRH4K6F+KSRVrMfzpEJa0XsKr1ORMTlD0ZN49Ocpq5hwl1j8XPmMrfmgGQm/nlSwp8j3UtHF9hB0DX4tIaxyLqh/sHeYNmJtwKXCVO1TTr/d61Edd4OMwP+QbOVyCyqnoa+LLLwSIvMNDtnPg5Vb/5QKQAON5LY639iIOjoX0ybnsaHXUsiEF8hMZrwECti+A8Wf+U6tgA5BflWmJ0Zi/6IWwE3rgrcs0Tf/ERJRuot7Rst3oDF7tvNwWFonMwNmSGIaIJFTXddsSRVgJLfX92mQTljYxjuF8PuTiTyoQkU6M0MgDi8vcfmCVYhsRU34eOpkh8cm4OkG8lm8Q5tv2Wu3LOiK1ZgVhxTkXKjNe60BHq/yU3aEJV7ovSwcncvgFLKOOMLfaTAB54KVxboV9qNNGUWGgoUXLjlc7RnhhKsWWTQ89DcxfNKvduNJMDuIXBDTsPA99KIiwOHkI1cQ4r6FlOOaCbUOIjd2M33A1aJNHtI89vGDGwZij1LTfAUcAoQP18+kkx8CuimCN37j2Y9i8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZybDdMLzIvSmowbjdSblZhN3Z0NXZYeVZiYkZ0RXVZeDB2L1pZcmRNdXpM?=
 =?utf-8?B?cUEwWVN3cjF1blM1eEN0d25EcXF1cllrSjZYV3ZoNGt4aEZxWnNtR25yY1Rp?=
 =?utf-8?B?R05mVWJwaG4vdjNpNldVcURReDZ0aUdmcUs4VFhNL0ZWK0liOEJRNldlZ3F0?=
 =?utf-8?B?RERrZkxYNHN5RHFZekQreFN2MjVESUw5N1VzRkRYTmFyRTZXdVhVQTlJYUV1?=
 =?utf-8?B?anI5ak5qRUZPbXRDeFpyaHhXQUNyVGNuQ3RJWXF2WFJ6N1k5SlEwNDlrQVBK?=
 =?utf-8?B?akwyNzBZQWJ1enp4VXZyblgvRHhJQmMyYmF5bFUvTHB5Z3VsVlRhcjh0SWVL?=
 =?utf-8?B?eVV6V0FUa0JjdHdyQnNNaTRtSDk5a1h1QzJBelJFcEsycmtUWUEwd2l6RERz?=
 =?utf-8?B?VDFJTzY5SjY4LzNrY3hxU2ZhRXp3c3F5K0tnV21UWUhua0NMNzlqTm1KRTBq?=
 =?utf-8?B?UnVEWGxkajlXd0MwdEpzVGhBR2JHUmJkMmt3ZGVPd04veVphdXptUEJCY2hu?=
 =?utf-8?B?aTUrdnZaWmJVa1Q5eFNYODhEbkpieDNpblNkdFVIcXlXTXhCVndjSHVZay9u?=
 =?utf-8?B?aUp2bjE1c1VvY3E0ejI1SjFRWUlYOXE4OVVZNHJtY3Bsa0EyR2EvZUlvZDhB?=
 =?utf-8?B?NEN4OC9wTWIrelRNWnJINXplaElwYncrVGE3dTgyQy81TzF5Ykxhb1lFdnVK?=
 =?utf-8?B?NkpYM1NvMWxab1lxRjV3ODFROFpBbkY1QVVLd2g2WnBUdElabXNqcVFLeHlD?=
 =?utf-8?B?ZmQzYk1TTjFUa2RyT3RvenZQT0R5SFROWmRwbllyQ2RGV1F4WFh1Z0gvOWdq?=
 =?utf-8?B?Sy9SYXU0ZFBhL1VvcTk2WHdrY1dSTjBVWWZDbjZ1U2JoVEFRcks0VHB4Tjgr?=
 =?utf-8?B?Nnpwa1F0cVpBQ0htdEZkUnU0bkttVm8vbzI2VFZyZ2Q0S2RZWkhGdDBZQkkr?=
 =?utf-8?B?aUY4aXdMa0hJSjB5bkM5REF5alVBOGlYZ1cremg5V2VFVFlkcmhRZkZDTTMx?=
 =?utf-8?B?NFMvbCtpN0R6eWlRU3dRZXl5cGxRNUdrOGQwb3NOUFlWdWNhUGxTOW5GMlp3?=
 =?utf-8?B?MWRTZC9NZ1BNS25LR20wa3U0Rjd3VnVqUGxUYzZJTGk4WVZTTW1XaDFtMU5B?=
 =?utf-8?B?WlBjQWlkK1V1S0FxRE52YmlEemU4UlR6VTNQcWY0RUtiUTVNa1hLdTl1T2Zm?=
 =?utf-8?B?UEpFcHJyOTFVSWxFc0ZkU3ZYQlk0Y0VVZUthRXR6VnRsS3lYNmh0V1BYSXhH?=
 =?utf-8?B?VzRaWXplckhyZG0xYlBwT0NaRStVbVFPck5iM0xRYnh4R1crZ1VvUVRhVVQr?=
 =?utf-8?B?N2ZTRHFuK2lIZURCOHVLR3dZTXhrem5OeGwyL2ZiZmdDd0crbGF2cVVlb2th?=
 =?utf-8?B?dmNDRFUwRXY1MmI0MXBBdGovSnI4RVF6SWc4MWs0VmFaU0VVaVhGTUFqR29w?=
 =?utf-8?B?NWgzZEszeWhxUkV2Q2VvU3pwcEQreE14RkVQcDlEcTd2alQrZHpmN2s0U1Uz?=
 =?utf-8?B?dmdla2tEdzlBaGlNWXBKbEh3VVgyeUVLV3Qxa0U1dGlOYU84b0hLYVRBdkxE?=
 =?utf-8?B?MVpjak0zQjJUTkl4L3JIQmlJZVF3VkpFdTlYemdyU0xHYmFXZXBoUGQ1K3or?=
 =?utf-8?B?Qk9uNVZ5VnB6Qks1ZEkzeHZjeFZuTEN5M1lUeldmSW94clZ2SjA5YkhiWGxF?=
 =?utf-8?B?NTNvUFlrb3ljWndEMCsrOEpadmRxMytmaklDclpnOTUyR3ZaRjdOTlJMMG1S?=
 =?utf-8?B?ZDNMb2p5dzFib3dtWmxheWF4Ky9lMXVoazZkWVBuc29td3dIN1VGNjdSQisz?=
 =?utf-8?B?dXFjUUp3cSsxejhsOUwxbXo4ekF4cnJUWjNxR2xPUzFCY3UzL3lqdlQ4ZzBr?=
 =?utf-8?B?WEgzcTJHcHRhTDE5d0RLekhOSVRGTm5JS1VhZUFJNW9wQlpkSzBVbTd6R3V1?=
 =?utf-8?B?Y0RMRUhVRDVObFd0UWNJZDZoUE5IWkZnMk1kbVNEUHRrZDR5MFE1MC9QREpj?=
 =?utf-8?B?cTFlNHAwaExra1R3VmZyNzc1K1dRaVRXTGluZmgvQ2pvRjR4VTlJUk1Zb1R6?=
 =?utf-8?B?ckRFV0RLNkVKZ2xtSkpFYkNwL1JMQktpay9LZG9zU3N6NkpRT2tGWElDOEdO?=
 =?utf-8?B?K1R1R3F4V1R2Ty9BYXYwYnNHTVZwOGtxQXRUL3daVUtHNVZYV2M5NmtHeEln?=
 =?utf-8?B?dEFWdGhtNFF6RHJXUEZDcDFYWElRMXhJS1E2bGUwMDV1VDkwVmVoSnp2bHc4?=
 =?utf-8?B?dEpWSDZEY0tISFh1TmFGMmYvMkxPeHY5bW9LaFN6K29GZ0VMZlJrR0F3cHVI?=
 =?utf-8?B?N2V6OXk2TFE2TUFpSFVYYUtDd2lGeHlMeVZIelZGaG1rZHNEcVd4dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c034663-b95c-478c-e819-08de8e5a8ce3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:47:49.6705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /H+4pTC4vXnOXMcqldpREthBau/fnsRHX1oRJTQhHsLklzMwGmn5PM1BjvbInJICEDa8nQv08+o5WjsCP/Aneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962
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
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi | 20 +++++++--
 board/toradex/verdin-imx8mp/spl.c               | 55 +++++++------------------
 configs/verdin-imx8mp_defconfig                 | 13 ++----
 3 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
index 7b45a87450b..3b0af5bc0a0 100644
--- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
@@ -70,7 +70,7 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 
 	eeprom_module: eeprom@50 {
 		compatible = "i2c-eeprom";
@@ -104,7 +104,7 @@
 };
 
 &pca9450 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_ctrl_sleep_moci {
@@ -112,7 +112,11 @@
 };
 
 &pinctrl_i2c1 {
-	bootph-pre-ram;
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
 };
 
 &pinctrl_usdhc2_pwr_en {
@@ -159,6 +163,12 @@
 	sd-uhs-ddr50;
 	sd-uhs-sdr104;
 	bootph-pre-ram;
+	/*
+	 * LDO5 output depends on SD2_VSEL, but no way to read back SD2_VSEL
+	 * when using SDHC controller VSELECT to control SD2_VSEL. So drop
+	 * vqmmc-supply to avoid fsl_esdhc_imx read back wrong voltage.
+	 */
+	 /delete-property/ vqmmc-supply;
 };
 
 &usdhc3 {
@@ -173,3 +183,7 @@
 &wdog1 {
 	bootph-pre-ram;
 };
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
diff --git a/board/toradex/verdin-imx8mp/spl.c b/board/toradex/verdin-imx8mp/spl.c
index b39058b1b5d..44678a976ca 100644
--- a/board/toradex/verdin-imx8mp/spl.c
+++ b/board/toradex/verdin-imx8mp/spl.c
@@ -8,12 +8,8 @@
 #include <log.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch/ddr.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
@@ -68,36 +64,21 @@ void spl_board_init(void)
 	puts("Normal Boot\n");
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
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
-#define I2C_PMIC	0
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(I2C_PMIC, 0x25);
-	if (ret)
-		printf("power init failed\n");
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
 
 	/*
 	 * increase VDD_SOC to typical value 0.95V before first
@@ -107,23 +88,22 @@ int power_init_board(void)
 	 */
 	if (IS_ENABLED(CONFIG_IMX8M_VDD_SOC_850MV))
 		/* set DVS0 to 0.85v for special case */
-		pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x14);
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
 	else
-		pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1c);
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1c);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Kernel uses OD/OD freq for SoC */
 	/* To avoid timing risk from SoC to ARM, increase VDD_ARM to OD voltage 0.95v */
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1c);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1c);
 
 	/* set LDO4 and CONFIG2 to enable the I2C level translator */
-	pmic_reg_write(p, PCA9450_LDO4CTRL, 0x59);
-	pmic_reg_write(p, PCA9450_CONFIG2, 0x1);
+	pmic_reg_write(dev, PCA9450_LDO4CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_CONFIG2, 0x1);
 
 	return 0;
 }
-#endif
 
 #if IS_ENABLED(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
@@ -156,9 +136,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	/* Adjust PMIC voltage to 1.0V for 800 MHz */
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	/* PMIC initialization */
 	power_init_board();
 
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 99749c50194..455a601b07d 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -7,10 +7,6 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
-CONFIG_SYS_I2C_MXC_I2C4=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-verdin-wifi-dev"
 CONFIG_TARGET_VERDIN_IMX8MP=y
@@ -119,8 +115,6 @@ CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_I2C_EEPROM=y
@@ -152,14 +146,15 @@ CONFIG_PHY_IMX8M_PCIE=y
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
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y

-- 
2.51.0

