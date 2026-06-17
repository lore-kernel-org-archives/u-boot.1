Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53280CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B3A84974;
	Wed, 17 Jun 2026 09:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ajwYRSAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D80803F0; Wed, 17 Jun 2026 09:07:01 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD8584974
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAOJV51R0stQZUgDWdYRNZoyl7G6dkOYyLKnVzj4uLKGIIoMfqsKjebUhHUwM4ukpX6oAVrePNFe6LAuiUidOcrgQsRZYgGdS1HKASk8UK9E6jYQvrDMyjjSzYjteS//UfnyXt2S0KnENi1ROOTT7YdjHTtpmn7VNG/V/yZilIUZ2NONhO5QVX6VCr+UsQNGlm+oPze7QmzOwi/qbtVxxtJ4YFkWjau8n3tFM1vu58QK1oleOllGHzC+uhLvgY1hqmkc8IPmG9qn1nswor8OfGTFMW26dcLCma33HYG97sX7F1IpL3f/qXE48OiSTj7BeTU3ELQfr+8zTGxE6c7kaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N24EeAp3W32/JP1H4H0XitvhJfTfZ1/YiBf02eVv2Lk=;
 b=j6G3aSqBKqBDRcI1RZ9hzypuSwVnsAz3xA0wurT/zoToW12vxBYIXDkMiRZI95YVnisnKcvgPAvukCsGZR1QOPwYVaVSR7V3N0UPKzPhseB/fYgYWMmMNqGr7MTkfjCwkQYqlBX5TaMpFjYsGSSMlaXAlIdFpe7BAjPoDMSG+MAr6b/EEkNnvu6XdmTYHGBsPfDACEsWIU2AQ7ohuEIUju8gf8aJ6PcvsEJEdjCdG2Z9911jb4oo9wAIKhnELmh0Er8RdPIlKc8g2lsLjfiHWMVssRK+znw50ciSidtO+8m7SzZZFec5D6RF9yOWCG76njuXZHgPKPmjAB6Q78CQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N24EeAp3W32/JP1H4H0XitvhJfTfZ1/YiBf02eVv2Lk=;
 b=ajwYRSApsa/K/TVbBRWVjdVKMnotCw2w+Q0fgZCO9zTOQ1KcWKcOv6VE1L/IQgay2nsFAaLdpmZkLji20k8oceamuSPFN5RgyDzBGHnxumuMKZqfI9fVg7Ssb0rD6bmIEOjI//0Qm/4Qqx1yWCjUEC98Cc0+pBXbGtXkQeswz1WCdKPu+JSaaIt3im06mh0GO9gMuy3XWucwgUz7Lr68pNxvtxU1EeQoYhyLkNTX6nbK4lvHbrosMr4pkywcCbqYOHMRgu5ML1IXjEXBaw4gw/rZzhjJE+RAsNCln1Vsf5AQW4fhxGri6Fmx2zfL9EwkJzEdITF4Ds9PL1wdDDg+/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:57 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:07 +0800
Subject: [PATCH 08/11] usb: dwc3: generic: add board_usb_init/cleanup hooks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-8-b824fe1e9299@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
In-Reply-To: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f8580b-d2ac-4eae-fb1c-08decc3f04b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 2TZvRGEfbJoXhV9q7NnlZa+8dERpJe1aM054HeGb7JgHjiNerJpjYTDSrOyP7hf7YmfWRDkR5YtCHoxIvyQ4sFFXQSqldgRitXSH10lFqh4AZoMdCoYwlUCF1hEsSnr6DO+nC7uWgOisEDEO7QGN4hPoViKMRyujGDbWGaoq6X5hjMWIm+XC8M7LkAt1N8pApxwUO6rfbqkUdV+/Jl21W6UrHwI/l/s1SaR/uX2bFLYEB3lgF7J9FZA/gPIJCsO60grF+jsy4k8PXyUeJKX58usjbXSiUO1xr9X3jOzpsUYT1bdK1f2U76yaSlpXPILsI0pKYIPMl1u1EsMO8+gQ26EWQznk8hUaFy13TnovZBs091UjDxbYwOti5ABEVFeGOpwBJ5e02H2OyyOsst0eRKioTU8/8KRPJ3bhtJq4l7z0eOP3x2i3M2/Wi06TolGii/FT/aOS7AQQ2nnVBxzPqPfXwk7ot4NpjFMqozx4IqtAjYgZX3sJkEuBba7wTPTSIl8LiP5TXBxT7U6+R2Fx/BAW5Kn1O0F7QcAivE/U/B1JdjBjRmiYUfZ3cO3NmTM3fSFyqL2OmjaTs6eVvruYnGdTONiikkGoctnAlbe05G6r/t1N5AYpPfRExka+AVa91VvoYI2BDnb3Z5nHH6rWQ3q5N798OBVnOpwNWhb+XEUtqPmJnfZuaBVbFQ5gfn6R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUF1YzREYWx3a0dsZjJ1Um50VXlXZFQ1T1d3KzlzVGZndUVqbVRBaHhzLzVB?=
 =?utf-8?B?MzltQmpVcFRQSW8zMmE3WXhyeEVueHEybk83ZlpUNXYxaEdJWEthYmUxQ2Jk?=
 =?utf-8?B?bHBqMnoyNjdidU9DZ3h3Z2pqUDhhbnVyak4rRGpMc2tIejQwL21Gc0pLSXhM?=
 =?utf-8?B?UXp1cVgrSlJxOU5QK3hxcDVmajZrYkdzckp6MXZRVjZ5aHd5dStoTkk4RGh5?=
 =?utf-8?B?TERCajhDSyt2NWlPbHB4MnpmN3JEMW50YVFDcUdhdnhtaGlkeERNaGRxd0p3?=
 =?utf-8?B?OFJDUm55RTJwVllUQTcvS3NNcDdaaFllZTAxMHBMS0pVUGcwNFpnWUsyNDNS?=
 =?utf-8?B?VFh2aFNRcWZVdHUyazBmbXozSlFXOTI4MXRXWXJHTTkwa0FRNXZ0WWcwN2Fq?=
 =?utf-8?B?eHUwWWR0WVRmeCtYSnlBUjk2UktNeWhhTDdNcUc4aDFBYnZSZW85ODVtbTJU?=
 =?utf-8?B?YnR5UnA2bVV1RG5sOFdTTFZHUmZGMGpFVCtJRCs1T09aZVpLdGE5TGg5S3I3?=
 =?utf-8?B?M3VIZVF6UTZzY3BEdGEvS3JKdXNGUHoxMGxEZC9NMTNDY21WTVNRSkNrNUNU?=
 =?utf-8?B?RnNqTlRzWE8vSHFLTWpsdnM4WE1DZTNjWjFMZzZScG4zVnVZWWtyVUxWZVNK?=
 =?utf-8?B?Tk5QQ3pkREdGT1NuakRscGtXZmZIREYwZWxwS3IvOTYzLzUweE5XRWxXS0p3?=
 =?utf-8?B?Q29wcVBqU3ByWldpV2dCTEN3VGRhakNXRzJzQXk2UHdWenphY2pqOHQzejd1?=
 =?utf-8?B?SEloU1VjQ0VWaU9KTktxVUZhOGFnWWxnOS9QN1VSd1VRazhFeVUvWVY5dTFv?=
 =?utf-8?B?VU1DZ3A5aWcyYXNFMnNRbm0xYUJqNFI4WFcxSVJUcW5qb3dlekU0REgwWW1k?=
 =?utf-8?B?Zk5PekplSVp5NnVlQmxVWEJGRFJvdHJMZ01NYjh6VWhUdWdnNEZnRTVjaUNK?=
 =?utf-8?B?U2FPOUhOY05sMy9TL3pPM0ltLzZqdCtZUHFDUTJPUzdUVEIyTTFJUDdHeWkr?=
 =?utf-8?B?OUxKdlJoanRMeGFpNVRPQzRTblFycGh5aFlMMUxSaDZXR1hNN29sMGNCd2dm?=
 =?utf-8?B?TFYrSlJtV1k5aVJJTHVtWVV5NjAxYld0emg4WXk2d3BaSm10L0ZxSFFTdXNa?=
 =?utf-8?B?OG1rUkUxRG5yOWV1RFQ1YW14YmgxQ0hmYnorbTV4a21PVU8yUGVMcXBZTG5i?=
 =?utf-8?B?YjRGM1d1Y2FNdk1TVmJrTmQxTnBKMTFhaTNCOEQwVk12K0pvdWJ4V2xWTkdD?=
 =?utf-8?B?VGNwYk5sVGFyNHVZajJrZGdlUnhITGpGamZkWGtaVnJ6R2VvcWlVUEI5aXFp?=
 =?utf-8?B?dFFpUXIvckVQTFd0ZXZBL2FLRHRJNFFYeCtYdlBvU3V0Nk96Rm5WbXhwQzRJ?=
 =?utf-8?B?R1Qyai80UHpDdUx3aXVPbVh0NUtZbzRZOXBoclFuZGY5TnVhSXI2cDI5TEpn?=
 =?utf-8?B?ODl0OE56a3YvbHFsSlFTMkJIWVRqS29HQS93d0pPclZRUENvWGF6cnA2bmxB?=
 =?utf-8?B?WW50b1hpNUFLRzVwUTdOZ1pHRWZSaUxFaEpVNUpOTHBGV29MTVAyR21WVGF6?=
 =?utf-8?B?L1ROb3JOZEtkQ2E3NS9oL0VNRFNPeUl2ZGNiU3ptMGI0eXZrVGo1MU1GUFpm?=
 =?utf-8?B?a0VBVVJOUUFndEc3UjJxcnVHak9pUmpmQTdpNEJMK1RsVVJCYVp6UkkwUmxH?=
 =?utf-8?B?dW9ucmNESTdhRWJ0NE90elJrRmJxaVBSS2ZrNU9wcGVRTFRMY0ZxMEt5UnhE?=
 =?utf-8?B?WWhZSlI2RkVYSUVHNzhpMlYyWWhQVW9YRjJzT05rdDg4RkdpWnkxUmJjaTB3?=
 =?utf-8?B?YnB4VDZrbFlHazdHdG1XL1l6RG1pamZuZmhyNk1xNWFycFZIU1c2OEl2U2Rh?=
 =?utf-8?B?RGJYdXkrSnJBaWFSQ2ZxMDU0ZFhEVWZBclQ1bG85OC83NGxtUEFsYlhVc3lr?=
 =?utf-8?B?dUJUM1Z3Vy9TbWsrV1RWL2VxN0pNMXF6azh1ZFFMTjYweXdhY0wyOWV0VEFo?=
 =?utf-8?B?V1VJNkdNNTVsa21FNFE4UjNNWnJ6ZWN2cVpobEZ1UmZmTG95M0gyS0FvQlF3?=
 =?utf-8?B?OE4xaUtETjVkMGdJenVxTG5yWTlVNzdNOXpXN1BlQ3oxWkkzdlpQN2JJQkxj?=
 =?utf-8?B?VzhuMGNuSnZHOTFnN0xyZHpoWFJDekIweDJQWlBLSWV5OVRYSmxHNkdES1FD?=
 =?utf-8?B?QkNZZFV0QzVsb2pSRDl0L09MRVU0K0hjZEs5TWZiNXBzTkJhQ2x2NW12b2tu?=
 =?utf-8?B?eGlmM2ZzSkU4Z0hvNXhWSzIzdmFmZVVsbWJyWFZJcUVoUmNtQTVlUUg0ck9j?=
 =?utf-8?B?Ulg0QkwrbE1DUVZ6Z1pKbCtBd3RDK3p4UHZkRUJpaEI0b2NPakY5UE9mVzYy?=
 =?utf-8?Q?HM/JFClzSyISis5lTExVuQyZpr2wGYIJKIjET?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f8580b-d2ac-4eae-fb1c-08decc3f04b1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:56.8756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6N4LvGFCWbdkrQn5tG7aviClESeNYAq4mnegLzB6CkrXnnM75/RzVVVsEtEHckXaOn8QN2iQ3KiIR23bju4XQAHsb/Q0qQubvXm10OwcojgT8VE2buAgamEQ65ooOWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906
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

From: Ye Li <ye.li@nxp.com>

Call board_usb_init() during dwc3_generic_probe() and
board_usb_cleanup() during dwc3_generic_remove() to allow
board-level USB configuration (e.g. Type-C CC role, SS mux,
VBUS control) before DWC3 core initialization.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2356b3bc0aa..2c6f8e6d8ba 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -9,6 +9,7 @@
 
 #include <dm.h>
 #include <reset.h>
+#include <usb.h>
 #include <asm/gpio.h>
 #include <dm/device_compat.h>
 #include <dm/lists.h>
@@ -118,6 +119,11 @@ static int dwc3_generic_probe(struct udevice *dev,
 	if (device_is_compatible(dev->parent, "rockchip,rk3399-dwc3"))
 		reset_deassert_bulk(&glue->resets);
 
+	if (mode == USB_DR_MODE_HOST)
+		board_usb_init(dev_seq(dev), USB_INIT_HOST);
+	else if (mode == USB_DR_MODE_PERIPHERAL)
+		board_usb_init(dev_seq(dev), USB_INIT_DEVICE);
+
 	priv->base = map_physmem(plat->base, DWC3_OTG_REGS_END, MAP_NOCACHE);
 	dwc3->regs = priv->base + DWC3_GLOBALS_REGS_START;
 
@@ -134,6 +140,7 @@ static int dwc3_generic_remove(struct udevice *dev,
 			       struct dwc3_generic_priv *priv)
 {
 	struct dwc3 *dwc3 = &priv->dwc3;
+	enum usb_dr_mode mode = dwc3->dr_mode;
 
 	if (CONFIG_IS_ENABLED(DM_GPIO) &&
 	    device_is_compatible(dev->parent, "xlnx,zynqmp-dwc3") &&
@@ -147,6 +154,11 @@ static int dwc3_generic_remove(struct udevice *dev,
 	dwc3_shutdown_phy(dev, &priv->phys);
 	unmap_physmem(dwc3->regs, MAP_NOCACHE);
 
+	if (mode == USB_DR_MODE_HOST)
+		board_usb_cleanup(dev_seq(dev), USB_INIT_HOST);
+	else if (mode == USB_DR_MODE_PERIPHERAL)
+		board_usb_cleanup(dev_seq(dev), USB_INIT_DEVICE);
+
 	return 0;
 }
 

-- 
2.51.0

