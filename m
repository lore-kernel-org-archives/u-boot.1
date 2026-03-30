Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F31FF494F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 12:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EC683F69;
	Mon, 30 Mar 2026 14:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SD7W63Uj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D734B83DBF; Mon, 30 Mar 2026 14:48:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B24B83D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 14:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWE9u5mL/QtViX22y1Y638E137hmjXbj4r9klhZbqR+b9qvhGKMzNudQcU8W+RR0iAEk4yfAkkfOSuoCQlZSLdMFvD/BeNl5bHWNXr/sfuZfGePggVQx996k8kKGV1PND9j/X5zITIijDCK1D+upb38cQ8cVBwFfh9lFcyKo8g8CROwryaJU9ksbg9DQWS9LCBYFwQerZJ0gFrfrB6gSnA9ECauOamZ+oO8MA9wBe1bUoXkhdRBZRq4MhcHs+eCONYPuJK7NRQWnJnSSU+ahYLwtu40eA6OTofh278eJ3vYGfmSilMAgdbh9gXS8LlJ7m/u4goKfFJweAhSXodn9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17P4Q3O4pKPDJVe4BPoRy46lypLwMNoiTo4x6bB2sgI=;
 b=PCVad+oVi0k20332ygLPTZEx6SmmuoFzWm6wRgW/I8juqlpUy6qo6dANYQ/hsj6DxF6jIZ1VMzo7Dy4WkeBm+A1GYwnDxzSWFvkEcF4bJTbv7CwVnS8EAreIMRdV8w1wI4wPZpzol8jYZqtX4zDy8jX0SpVd5A4kv5SCe55b9n57+AE7wRG/KGxcTIggxRRao9+oDkcoVzhyOMzQDwbuYep7QRF7Tqft7NRwgLtv8cpdVIuXE5ZUYGwsL1m1wsSACEZjc54a7jSU2arlq2c3aEJ95IUmALBa8dnXnUpwl7lhy4aP6TdWl0ni4MQKnRKi55cY6ELksjwuGPv3dhz1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17P4Q3O4pKPDJVe4BPoRy46lypLwMNoiTo4x6bB2sgI=;
 b=SD7W63UjvbptantRrsScjXUDptWy68JebRZOiOAXlT6NfG1LCcHlO3qXhYiDnPW6TKcgDTaECsxnff0GPptLYcgbkqjC0lSitkt8HCGbLvZbot1aRDfXcz1+vqJ5K3gr1rbZRMNgceYwF+ocFBPZlzeS3grXiJgNd6lf1NTkghY5w/kJw/KoChBy13mtKmg5+g+Qx80BTuzE0Wap6xnkTukxEhu7zLv981iFSk+WMszCe92JtKMc0y/yhdDmX/ex4/QHLMo5fWQT6vn+DVE5OS8lXBI1d2VxFZ6sXVP7DOHx7p8k2eqPJgSWXBmEc0lEMMdh/syRK3MZvFqjCSFThw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:48:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Mon, 30 Mar 2026
 12:47:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/4] i.MX8MP: Convert to DM_PMIC for a few boards
Date: Mon, 30 Mar 2026 22:04:02 +0800
Message-Id: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANOCymkC/1XNTQ6DIBCG4auYWXcaQOpPV71H40JhVJJWCDRUY
 7h7qUkXXb5fMs/sEMgbCnAtdvAUTTB2ySFOBai5XyZCo3ODYKJipSjR2Td5fNDUqw0vrWhIjlw
 PQwv5xHkazXpw9y73bMLL+u3QI/+uP0j+Q5EjQ9Iyf6jqhtfqtqzurOwTupTSB4eBFf6mAAAA
X-Change-ID: 20260323-power-legacy-5928e4f1dbb9
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
X-MS-Office365-Filtering-Correlation-Id: 5cab507f-0599-4c1c-4c89-08de8e5a8648
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: JV3d2ZZ7mYRX0OZt8R+o1Lfan13BGzMc7TlbOb+ZfYBOkoRCLcTJl44LpTJr5tbPo+YZCXX3f+vlEpN0sAh1XdkYvgHSsiayRIzQqeZgUXyn1C/yWG3jnWrJRwXeEDYQGlmYYH+wFL3Ou1gPtPSxN7osYlBRJKoencnDG/5WAYl6IoiRFRkpgxlmAmxFefbeM5V0pQyxBd7gnzFH3/X2nJKbc9PxgiCJT3I3T3FhaG9WdWfxomiU6f3pAyL1UvrNqIbx0dw1IUOODQDTyw8WllV6tCPAajrR63YA2Y5577etdEriWEHlQdhDjvMi9dUfJht2AwQXUMgbwFgVMOoYOfCDoPBnR2dZdP6sPnty0Bqdd5vq9wakX4QaEfiaMYap6pVNYtV4MkLCl8bAMkAWt3NuYcWxBWNaPxKY+bNewkSNRwQarZVZ73HiBcs7bDPqCi0qe1L4S9bUvUkKPbe9YDU/n401Sjah7+YZ70fsVN/a1uAEXujEHRLQO9oHvxDlwNSBNuRzAfWJqeviv04Ys8Ulveauw/F9wG9adSWM2HP34uiL2O9aCYZss6sJBM07lBgyyh5g7kUIq9Tjy+W8aFsSLoxHVIMNIGFUoR8hThOzQFC3tM8HvJ2GpJ/APnYs3XEk4K70ZODWhDDBtF++gBqFhXmp62Nt11nOtx3HxpEAq2eHrAU0JX8WOBbaqUE6DKGDXkdxIjjfoRHP6V5FjYT6Xq4BqnuUigi7ypPUqo20pXE85l5qHgToQ2PETeEx+zfe1d4rVG/bRuY/E4al73/sZJrjTogfNon18kC1CV/kOFf3xbTT1r+MnwB8Fc1H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJ0THJiQXZRM3ZHcDRyVVJJRUI0OE4xNTFMY0lNcTQvVW4rbEtKempabkVH?=
 =?utf-8?B?YzFZNElpa2w2MDc1UTNNN1FybnVKdlFCYkxHNVF0UWxhNXNEbmptYmtDeENB?=
 =?utf-8?B?MW5GV0t1cFNrQ1lhaGhvVjR1ODB2a2VENmg2NXdOV1BCSGpvZmtpd1o4WTZy?=
 =?utf-8?B?eGRrNkR0VjE3Q0gyQXdJakg4bmI5QitpdDc5TDdyUUFFbkkweXVRNWFKNUll?=
 =?utf-8?B?V1ZOK3JOV1ViSXk2blRsYkhteTdtSW8zREs0VkxZTGVFK0VLRUxvNlFHWUZG?=
 =?utf-8?B?ZU9kTVJpeFBTaDlIRG42R09ublZaSE1YdGFhUlhnV1cwdm4wYWJJZTZuSHJ3?=
 =?utf-8?B?R0hKeUZlTHh0cVNJNnc2SEJ5eGVQVUZtcmhXU051MW9Xc0ZUQkJHcUkwY090?=
 =?utf-8?B?N21RZm5YMFVNTFRNRjh1a21mNkhTVFV3VGNFQXIrS2g5ZGU2QTE2cTd5NmVM?=
 =?utf-8?B?NEFpQXJOOW5yLytwejIzdUx0ajFRbHArQVEyWVBWN1RNa0JoYlpvRmFDNnR2?=
 =?utf-8?B?eWhsVThiVUxydmxnY29TTXFKSEVjMG84S0p2R0krQWZnaHppejNNQk9yZDV6?=
 =?utf-8?B?YXEvUmpncFhUcm5lMnVrcklSM2lhZ3pSNkY4UXhpOVJqOFhsc3IxUm5sOEtr?=
 =?utf-8?B?QVI3cUNSRGZmWEpCN1JyQU4zUW90TTdUT0EvNXRpNVc1cDhPZFNRQzVQZlQw?=
 =?utf-8?B?OGdXTmlaOFh1N0VFWjNiOEJzcWdha1lESVJFYjhScGx2SXNpeW9ubFFscFVw?=
 =?utf-8?B?TG9YVHFranJlMUgzcFZCN2RqbGJxL0JuWjJ1anJpZWVmZG91Q21nSk9kT1RV?=
 =?utf-8?B?UFRDWDhIZXh2cDRPOEtkNE80M3Zmb2tka2pZQ0ZyQ2xvYTEybnkyMGVHTm9S?=
 =?utf-8?B?WmhtemI4TWdjbkhTL1hGcHR6eU1LbGM2VzRCcEdEenUxNU4rN0JsRUs2VnVS?=
 =?utf-8?B?NExDU29OYkEvdXhvYVV5cHlCc1BDNitLM1J0aUs0cDhrZHZLc2ZQWnV2TTVp?=
 =?utf-8?B?VG9CUHdUdDhza3g5QmFaVDVPRGN0a3cvMXpkODcwcDRGd01DZVg3dWpOMHIz?=
 =?utf-8?B?blp6R2pvbEJXN0ZPS3M3Z3JTbjU1QnhoRVpkaUVmTEFCSy93bVhkVWlTVXV3?=
 =?utf-8?B?cndCSFRBT2Myb2JXbU0rMC90QzZkRkR1bjFyendObmJiRWhLcEpJcVA2T0Iv?=
 =?utf-8?B?QTJIS0duSmUzVzRpKzFNcjdpbU12d24zVHowSDM2dElsUndoUjlyU3BvZW92?=
 =?utf-8?B?RmQycVYvRGY0L1BnY1BUL0pacXFhY3FlOWN0OWNVNXVBOVBWMnM5cGFhUXF2?=
 =?utf-8?B?WVNwU3VGS1VHT3h5ZFc5UC9ZOUo3K0JwQ25YTzNPUmRFOGZUZ2dCRHpBelRx?=
 =?utf-8?B?UHRmTGFnRVBqVzN5bzRUVGhvbHlEUXE2bSttYXlSYmNaWk95QXdQRXUvN1gv?=
 =?utf-8?B?aG9vejFKUzNxVElEclBheU0vL2JaMWJYZDQxdDhYdDFyZi9oTWVpNDFSclk2?=
 =?utf-8?B?U3Z1SFg0ZFBYbmZPZWwyMzMzM0Y4bUNDak9kQm1FRGZWdXI1bEZnSWQwVUsx?=
 =?utf-8?B?Y0JQNC9mQi95MVZkVHBQRHBKVXpDd2ZxZXJYeHByd3VmWGJHVGpYa3E4Vi9G?=
 =?utf-8?B?UERQaUhwNlY3d1QzMG5xTS9maVQxQkVpbndHa2Z5cFFRb3ZmbW4rZFpGbzRQ?=
 =?utf-8?B?cHNBS0NsdFdxSERqbGlBaWI2TFhDZk03YmJQQkdJNVFRRWxTa21ydVpIalpJ?=
 =?utf-8?B?RURqSVF0S1pvTDd3SkNqcjlaOWxydGxldEZSbytpMkw0dDVHcWl6emdsaUFX?=
 =?utf-8?B?VkpzdU95UkJTMzVxM1ZQTVRYbHdJWkF5TENRZ2lmdzh5alh5SW9KTEtpYmJk?=
 =?utf-8?B?Y1l5Wm11VTc0V2xqVWpOVjBqRDV4NkZhbEhzVFJQVy9IUGlaMjJoRVFTa1RW?=
 =?utf-8?B?NlBmZlFoOEM1bGdwLytUYVVWYXh3a2p0dUg4ZmQ5M0dSTHlWZW1rSGkwMmJR?=
 =?utf-8?B?VGZIVkIzcUYzM2pyc2g2STJuVlBwMnBCNWRaUDQ4eGdrMi9PNHc1YzhRS1BO?=
 =?utf-8?B?WFNOOGpzWEhVM0JKeXhHUkVhbFI5aFNVY1YvWEQ4cWozMGI2S2E1dTQzRWRi?=
 =?utf-8?B?dHVXbHlBTy9hUkpkRDZIcjdQZXRsMzZZWkowZ1Vuc2hZaTAyUmt5Zmw5OE9p?=
 =?utf-8?B?ejRPakdVd3JCdm9kNmk3NnMvUWgybVpJRWVxdjNmM0U2OFVPb2JKOGdPdm1C?=
 =?utf-8?B?K3JrREIrRURwa2Y4ZVFiZHpHMi9XTWJoYVRVbUduU1ZYeFJ3YlBoMThudXpj?=
 =?utf-8?B?SXExKzVxNUt2TGR6ai9NTzF4NDF4amF3YkNUQ051SVdKVXlnbVNZUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cab507f-0599-4c1c-4c89-08de8e5a8648
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:47:38.6888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClS59nGiFD59WwnlbNMv8ZM3Dkq7CqrL4COlaEOGta3rgkn35wG8r6PBMUcvX7sX3J8co238SSRWTzoDtKEvgA==
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

Per the thread [1] that Tom asks.

Convert to DM_PMIC for icore-edimm2.2, libra-fpsc, verdin and
phyboard-pollux-rdk.

I not have the boards to test, so just my best practice to do the
migration.

For i.MX8MQ boards that still using SPL_POWER_LEGACY, it is a bit different,
because the OCRAM is a bit small, I need find more time to check on it.

[1] https://lore.kernel.org/u-boot/20260320214518.GD502704@bill-the-cat/

CI: https://github.com/u-boot/u-boot/pull/916

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Drop vqmmc-supply in patch 1,2,3
- Rebased to next
- Link to v1: https://lore.kernel.org/r/20260324-power-legacy-v1-0-ed432367817c@nxp.com

---
Peng Fan (4):
      imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
      imx8mp: verdin: Convert to DM_PMIC
      imx8mp: libra-fpsc: Convert to DM_PMIC
      imx8mp: icore-edimm2.2: Convert to DM_PMIC

 .../dts/imx8mp-icore-mx8mp-edimm2.2-u-boot.dtsi    | 18 ++++++-
 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi     | 22 ++++++++-
 .../arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 22 ++++++++-
 arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    | 20 ++++++--
 board/engicam/imx8mp/spl.c                         | 53 +++++++--------------
 board/phytec/imx8mp-libra-fpsc/spl.c               | 46 ++++++------------
 board/phytec/phycore_imx8mp/spl.c                  | 43 ++++++-----------
 board/toradex/verdin-imx8mp/spl.c                  | 55 +++++++---------------
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      | 12 ++---
 configs/imx8mp-libra-fpsc_defconfig                | 10 ++--
 configs/phycore-imx8mp_defconfig                   | 10 ++--
 configs/verdin-imx8mp_defconfig                    | 13 ++---
 12 files changed, 151 insertions(+), 173 deletions(-)
---
base-commit: d9eee3d17882ec40f8ca5e231046bbf287ab4369
change-id: 20260323-power-legacy-5928e4f1dbb9

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

