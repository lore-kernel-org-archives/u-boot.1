Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF2C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FE584C27;
	Mon, 13 Jul 2026 15:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fMo1BZ5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B5684B93; Mon, 13 Jul 2026 15:35:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A73684C28
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgcRO1RmDmspTZSapa9R6rDazYXWPJCISxFlosnJ6xuEk4kj04x6f+8xXEC6DISQ+Vvggjx2UiNAzdDl+3spxOxR6/3eJzr0dOcKRLTxId9PH5WSc8pDCxCWIfXsceA3iLwXqM1LvFDNANQUljKtForTcfwQdE3Mx7EHwK17MUsChWkGuzYuuYoey+dMpGBU3sOl34dMi701LyZ9PcafHIT2h+yH6t4bYy99La2fVFUvZ3v0lrEWE+7dwrOWwGHJbNwCM3gdoQvHZH/oyvlZsrlKDgp0MpgvhSxnSE7DVCdFn+XSs5u/u0/O0ESeE7S8h9UXUqtm/UC2ywP7EervfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL6nbxnPbdPlwJ3CXRKri4sfv0s86LS8Nqj/H4M5bC8=;
 b=C8qruPjIICmpi2+e35ssL6teO62T9HaWsst/ctVe5bpbg57vxeIqcEOTEe+P3WyYm6KYsTAuMZXyociHQjKsq5E0OTLtWYJ4+n3mnFiY7K3YgUGs7uwvMHdymshbtsTLbHIHcu2Uc9lgH3rJb+yGLWEiI/iuT406T8o8yXdcK07rFTmLdCcQUZcnE4OKShcylR3r3/bfQsB6tWnLYFQIRaiw5pOfMLU8dm5Pu+8p3d/3EbJIxuQoP+nGgcVwOvuZb53mtJM/F3L3W8WPF16/ZIXIUZf2QQXLk/Cg7av7r18pXN6y73cwJozIGb6Kp80UsAtjlSq316k7Sc41BUak3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL6nbxnPbdPlwJ3CXRKri4sfv0s86LS8Nqj/H4M5bC8=;
 b=fMo1BZ5qRHIb4YFUzpIEOwZtfyWN0gDKz+xsC2cjExrzkb9EPAXnrBx4nKs7isLnn+6KEkMYsWE6+DPfoOjQbBEQW0hLu3d2C4tOGnQuinuVZWZRB9YEOyYYJQdk0ueiuSpuWgMRv3TH2KNyAP3D4vzjZmjLiB2wnuFmOH/h/BN0dK+fpIlms9BZHh/21LSGNQMLf28eAalPQKa29npdMPLzVbUPhxIdK+llgJ7ZvUKuIngLQj+X3LE9ha+YavPFCXjZZigmuGdtdGeHspquvwGFPsybmkDpWTEy/YQI4BdmmeK8lhDgPcBSIULYthxpcvhSFlLCUFAsE0PC8GecBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB9011.eurprd04.prod.outlook.com (2603:10a6:20b:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:35:03 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 13:35:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Jul 2026 21:32:56 +0800
Subject: [PATCH v2 5/5] mmc: fix mmc_deinit regression when card is at 1.8V
 signaling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-mmc-fix-v2-5-b0ba3b4a8d97@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
In-Reply-To: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8779828f-2f76-4962-f246-08dee0e38aa7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: B1r+oNNyT4lMEQ4YWHh6YeZ1I+AzRrop3EbGd537aW+io7yzf2rjii9uHPwUX4XuuFY4kZ+awEljvk6TSslG0VDDr+Y730bFnjYVhL3/t6y5GsjeCLZU9T1McUWVjKTxbzT6/XwS3wyAS8pvuoX2XRzA8KVuHf8wtC8LVOd7PRox/XLJFlEnfiNluN9vdsYQlj4n6cFg9aOpSmP2TyfERkE9+u2xqy8Iq1MyGwfLoI4j2TXdZVC1U1EJFJhuHF03DkxXSvT4viS6KQT9QY9Qi4UuOKxUT7Ry4j6zv7D5DEc679FasG+hUZgEkePjYmMG3nlVIzZzMENK0J70roCdBaHQVvTsyeFePWJOBclvKarQTBJ0RlaWVp4UCFVGbliYwevXZVDza03bJndTt+v7cefpVcA+PAJQVOZzmFbSoI+fdskRG4JZM5hGTjhH7zKqbjO9bRghaGgcsJTKhW+bzRt5WlcBJnVdz+qRpRNIpuWa+2eaButb30DhMpYjab4KhB7EwBREqVvC7kBoxwijkRHx7KWglUBZmFTmjryR8cv7oIFAMrWoGJV1AZXnLry4Ky6hafcAzXqWZzTW/ZeUJt/BOqP+7vTNIbcehqR490AO/Dv0Pw7dIq8YXKJ/D9Zo6Q4mC9gbbCUIu+knSY1ujk7YxIIO5VpBnoaPGqDvMww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFFXSWZuY3RRWmFXR09sRWNVaG16V3hrei9nS0M1MkJRbTdka1RZRlpNTkNK?=
 =?utf-8?B?YkxsRDVSc3ZremFqaUFpYzhtT1BQV3NGZG9ETU05RUtJS1dFWUdRYkRYQUZJ?=
 =?utf-8?B?M3FMWnRoWmFhbnAyckhaR3lhUThxK2tEZXFPV2J2eEtYbWZRYUsvME4rQkdh?=
 =?utf-8?B?aGpDNGZkNEk2WlhEdkpXSEc3NUJEZ0E3M25UT3Ryd1pra3JCSHZ4WUxxZm0y?=
 =?utf-8?B?a0JSdC9HZFBDdFBzYklEMWtQSEtsU3JRcEs0VitOMXpaelU1cGMxQkFPOGhH?=
 =?utf-8?B?SWJPTmsxYVAxZXFVNkdxR2M4cER0QzY4cHRzNURWZHVZbTVrTTdlcGxtWE5J?=
 =?utf-8?B?c1A2MDdHK3pkMEpXQmMwSGl1VDZhZ0N2TlJvNTZDSU9rMUdORWJCSTN4bElo?=
 =?utf-8?B?UERKK1hlNDQ3YUordWJlT1VLaHhQQTJ4ZUFxYXEzZjNxTFB1WnlGZGZXakZN?=
 =?utf-8?B?ZGhXeklPVDNnR3A2Y2dGekp3aG1nSnNoYWM4aWxhc3BNRGIrR2hDY3VrSjJG?=
 =?utf-8?B?MFZ5OFVzUGtNYWlURlUvYWcvMElMdmR3bnZ5OEVIM3ltTytOTTBoaS9SMmgz?=
 =?utf-8?B?YmJMZ3NMQkVueGtSTzhyZlUxWGprOVNBRnkzYXp6NXdSYk1pSGN6dWJEektH?=
 =?utf-8?B?THBkaGdweXFSdGFGb2g5aDZ6SFlEbEF3SXdOR0hZUVBadUE1dlJzMlZZbStE?=
 =?utf-8?B?MUpndWVjUnV0Z2gyNW9NYjdUUEw4RzFRWDBQVXFxMHpBSVo5c2daRmtNc2Ft?=
 =?utf-8?B?dFZwUXVYRFFtdnlUemZ6dmkvUHRrSnNyVVJOSnJKNmlpT1pFQzYybkk4YldC?=
 =?utf-8?B?OGdsR0ZmdkRGYlorZmJmeHBOMUhuZWg1bzhzMXJFbGZIVG43QkZHT1JLSWcv?=
 =?utf-8?B?eFFrYnU2eDB0RUZ6UFNVT0E4YnA4Z1dmRk5TM08xOTBvMENEUUJMNHRXNXRk?=
 =?utf-8?B?K3J4dllPNjJUSHRZSGJJNjFUTFllcktzTmxYZTdSTHY2b2F5Zm10YUR1TmZp?=
 =?utf-8?B?OGV3WTZYYnpNS3dETVFabzVJbnFjaU5JY21MN1k5aXN1bGRnMHVReGNQb0JS?=
 =?utf-8?B?K2dhYlkyczdabEFXVTVwa05mZEZWQ21zc0VOTDcyLzlHTnA0Y1ZRYXhyL0JR?=
 =?utf-8?B?MkIxeGt4YmpYYWRNejN5V28rbnNrL2c0Zy9ZUEw4MnA0LzMxTlpEZ1FrbFpC?=
 =?utf-8?B?S0lsRHB0RTcrbmh1ZHpXUW5tWkUyOFBwTnoyWTlyTWloVnB2V1AwUGNETWNF?=
 =?utf-8?B?YlVPSWJCa1l4WnR5YlJ3TGh5c2IxR0wzdW9qUThoY1VwM3h2Vkp6YVpMUFpt?=
 =?utf-8?B?MjBPSjJaTkVaK1lIRFJkUUpCd1BQUDdGREZ0bUdLZkk2YVpoUTcraTF5WkJQ?=
 =?utf-8?B?MW8rcHN4NkhML055QmR0ZUthZG13V01MRXBJbEdVOExtNWtDaVBUc0hYUGZ5?=
 =?utf-8?B?RGZMTGpMUEZhUk1JckN6M2hJV1hiUVlKclQvVnNGZ05MTDdSbXFqMnNpbTZU?=
 =?utf-8?B?bjVaZ3lsL0RpbDBSdlpjZEtrK05IZXdweGJKWHp3R0NVbHdxTENVU0t2RVZ0?=
 =?utf-8?B?b0s0WWZVSytWVVRHVDVjdEJNWW1HczVaTG9pN29XbXJ5ZWVIZmk2c2FMdnBK?=
 =?utf-8?B?SG52Wlg0dXR2RUNyanlmakJhMVhWdW5XNzJHbG5HVTJURGsyYWhqK1B0dG9o?=
 =?utf-8?B?Z2w2SzRseVg2S1JaVlhLeUlnUWFDTkJqcWZZNTRCVlp6SWtZQTFlUWd4OXE5?=
 =?utf-8?B?akZHOWtWcFFSRU80THRhYUpmM0hpcTNDSVdPTkVQb3RXNm5VN3BScktkRHZB?=
 =?utf-8?B?cCtGQ1k2dk5DYlVKNnRSLzZSYzBrc0NWMlBhejVSYUE0OXZIZFVOa3oyejR3?=
 =?utf-8?B?UTFUSXBSWGc5ZVFSUXFHZnNGUi9qcVZOZGYzd3VpdGNSM21HUTlqYTU3UjAx?=
 =?utf-8?B?TGxWMXIrZVd5SkN6NjBwRDR3blg0TnY3Qy9vTWJvRzdCeGVkcUVHdHdZZ2Ey?=
 =?utf-8?B?eVRpZ1liVjZsVlI0SnNmd0pXYU5vV1VoNHJuR2NFYWYrMGpRRGNYY3JtMzlM?=
 =?utf-8?B?L1ZpSm9FOS8wYnlnbk42RGFqK016YTBVODNlZ2hwaU5kL2pUNVVxQm55R0Fx?=
 =?utf-8?B?TWFGcGl1bXNNWmo0cVhFUkJ6enoyMDJpZkFwMjBQQ0JtNHJDOE85aGg3bnk4?=
 =?utf-8?B?Sm1KL0RtTy8xSVRqeWU2dDdzM0pxRDBsTDBJeVJVRHl0MlBab2xwMmlKaDBj?=
 =?utf-8?B?cC9hVlFHYlhZK0VoZ05PLzhWWkkxSFVVRWhtSlpYZGlwN1IrRnRORVFYL0Rz?=
 =?utf-8?B?Y0xLU0ljb2dpRXJDUU96R3RVWVI2SlNrVFZYZ3pjelNFaDZKbXI4VC9reUor?=
 =?utf-8?Q?v5X3KmPiAl/9kI3Tc8x8jK74XgJ+GiU0DdrmQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8779828f-2f76-4962-f246-08dee0e38aa7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:35:02.4151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHIg0ITZYF9CelNMMOjonZHc8TVI0r1Jo7WqgrtF7qEqBnY5lKLxGk6lcfarOhWsRJNPFUrHKKVnKtcnMzb0NhI3Z4ZA4nVfGokBYFOZsvc9wEGqCNEwdpy67SCmPiQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9011
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

Commit 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without
power cycle") added detection of cards already operating at 1.8V
signaling via mmc_sd_card_using_v18(). This correctly handles the
warm-reboot scenario in mmc_startup().

However, mmc_deinit() strips ALL UHS capabilities from the card caps
and calls sd_select_mode_and_width() to downgrade the card before
kernel handoff. For a card that has switched to 1.8V, uhs_en is
already true (via OCR_S18R in mmc->ocr), so sd_select_mode_and_width()
attempts UHS mode selection -- but no UHS modes remain in the filtered
caps. The non-UHS fallbacks (SD_HS, MMC_LEGACY) are 3.3V speed modes
which, when selected while signaling at 1.8V, leave the card in an
inconsistent state it cannot recover from without a power cycle.

Per SD Physical Layer Specification: "Once the card enters 1.8V
signaling mode, the card cannot be switched to 3.3V signaling without
power cycle. If the card receives CMD0, card returns to Idle state but
still works with SDR12 timing."

Fix by using a UHS capability mask that preserves UHS_SDR12 when the
card is operating at 1.8V. SDR12 is the minimum valid UHS-I mode and
is always available at 1.8V signaling per the SD specification, so the
card is left in a consistent (1.8V) state at a low, safe speed.

Fixes: 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without power cycle")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/mmc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 5fd12d21f92..135fd835609 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3173,10 +3173,19 @@ int mmc_deinit(struct mmc *mmc)
 		return 0;
 
 	if (IS_SD(mmc)) {
-		caps_filtered = mmc->card_caps &
-			~(MMC_CAP(UHS_SDR12) | MMC_CAP(UHS_SDR25) |
-			  MMC_CAP(UHS_SDR50) | MMC_CAP(UHS_DDR50) |
-			  MMC_CAP(UHS_SDR104));
+		u32 uhs_mask = UHS_CAPS;
+
+#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
+		/*
+		 * Per SD spec, once a card enters 1.8V signaling it
+		 * cannot revert to 3.3V without a power cycle.
+		 * If the card is operating at 1.8V, keep UHS_SDR12
+		 * as the minimum fallback mode.
+		 */
+		if (mmc_sd_card_using_v18(mmc))
+			uhs_mask &= ~MMC_CAP(UHS_SDR12);
+#endif
+		caps_filtered = mmc->card_caps & ~uhs_mask;
 
 		return sd_select_mode_and_width(mmc, caps_filtered);
 	} else {

-- 
2.51.0

