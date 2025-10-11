Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B626CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BC783AA9;
	Sat, 11 Oct 2025 20:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="I0A8axeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F84683CF7; Sat, 11 Oct 2025 11:09:06 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D0883C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDQX59TtCALgD65HN0xdsIz0yD9PM9AYIVDhCdCidoLVDgsfDCGBWvvyHvPUqcs+pjlhnuoJYz/zOYGuXsWpAb4xBDb3RpNs2b9OcfmhL0++4/aCchERcRFLETrAiH5g3LdsOYKbsSm91l8T+DamkckHG5shwPW1w9vkRywQgU0B4FJhiAjemKr9oQ2RVMC/Uj+uSQjE/zA1aZt/6ViaNFeqQxFgBJY1SWYUKkeQyjarEuHl2SMfBGR8hFjNLRVJQrxUz5vANeXQwuIFtF3lxE0ujGXeo9kRCkkrRCt09vj095+e1su3YxhrWvxratSifCiQ/fCzEsMVE3zlKi4dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=RY2WZmJ/f7s1mRF4tDMbRu23wG4gqEA+/RXctDNNh7edfQS1v9BAmKwYNxxUrJfAvlPC/ZW0KYsmV4fhwsJYBEaF7RvANnggzAe/HeNokmXSnUpwxAjdQibRWUnfisQBn3LhmbxLiUMOc38GYrlYnv02HQDJjkjR0txB4q6hXFbfWaQgEvfMltUtGtAPanvf4B+Uf8QYgBcqpzcYAnQA+T90mwGfi5ZvShGk9jOZxiLylu+RRm0RkeyWCGmhdKBlpEkuKdc7b8y3dZ4Z9YaSdpQCjtMYjh8BecswFLp5cHLkHs6UbZrAnrsGznn5u4YOgQvJvZmsV0JON6sdrHhD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=I0A8axeDYZ3sqapBNIuftfPx1AHYwR2FkRC61QpoBojxSszs1lrJTrVJy8akNwAOg25tuJAEcJNSRm+I5tD+x7Oc7ngUy4xr5iCAG8l/dUnWT0h8pW9Nxa6lnnRuMO6+F9rkzuXpvjzdDr1LD0Kn3EBaS5c6qShYzZtIzwF8GwOQ3kXSTnjXNUj8xc61b7gvLUWFvOnOJXOG4X15jrIRYa7cC1k0OykAL31HzVmOTm0J/dF8E+V1OLs63iB6nvPv2SyXwv+9Tuauey5mQOYCJfZxDadcph308ixqG1Bzpuc/vgf9NiSqmfSijk/d9B0r52IFwjJA0mXFZXzDiP5vWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:09:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:09:02 +0000
From: alice.guo@nxp.com
Date: Sat, 11 Oct 2025 17:07:52 +0800
Subject: [PATCH v2 05/10] usb: f_sdp: Update SDP driver to support PQC
 container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-5-313444548ab3@oss.nxp.com>
References: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-313444548ab3@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e61aba8-223d-4bde-d860-08de08a5d226
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGJFTGZjU2RvTjBlaldiTGVKWi9UMzJOVk9GdVk0UjBzM0NGcWJxUnZ2MVUy?=
 =?utf-8?B?OFVCWWZ4WWFzN2dHT1lFQThnMmJRYlJJNWZPYmRtd3VwWXE1U0RnNHpvMmFq?=
 =?utf-8?B?cXhyNkhhbTJSdStTZzVzWThCeVRZVEdWQXVDdzVYRDJEWXJwQktldUlUK0p5?=
 =?utf-8?B?ZzZ2WWEwa0xCb3E4Z3gxcGVNNVY5MWFSbW5MbVFadzZzRmJZc3krN1NHdDVZ?=
 =?utf-8?B?aFY3OXFuYVZ3azBwc0xjWXl3cjBobkIvdmp1T20rUWVGRFVjWTRGYW84dGdz?=
 =?utf-8?B?ZUVrdnVOUGtQbDlGL1NXSUNaV1pMZDBVeHhrV2JHdWo1OFhNOCt1UFZOakpv?=
 =?utf-8?B?dXNDNUV0QnkzWDc2MUxVZitkL1lSclhSM1VFTmtVa2lMUnIwUWNQeFNldld6?=
 =?utf-8?B?WWFvcWFZSGZJNDcvczdFbkVUT3J2WVpQcWtnbHBDSUxlN0pSNEpQQWFpejZH?=
 =?utf-8?B?SEorYXB3cURJaEl2U2o4WERDYmpLUm9YMHBDbFl0ZW9USWFhRmg1blRRV1Rl?=
 =?utf-8?B?ZHBFMXUxU05qb0FHcEhobzhwd2M3N09wODlyMzk5WmFZaElNV2NaRUhOeWRj?=
 =?utf-8?B?Q2s1WnAyUnBjZEhjQVFmZE5WY0NwVkhCZWVPR3M0N3EzWmFlemRxckZaTjEv?=
 =?utf-8?B?Um5oaUYwWkhJY3lxRG9POUh4dUhwRUl6ZjJjdWpvaWpOSGtyMVhNVWtwVGRO?=
 =?utf-8?B?Zld1NjlpTUw0WmhLODF4RVd6YlhDSHE3aWRWWlZMSzNXSENJaWFZcmVPVHQ2?=
 =?utf-8?B?cUZ2anBzWkJ3YWNwZlBwWTdXSXRLR1RIbS92MTJUMTYyVCszWFJkTE1DdDZx?=
 =?utf-8?B?c3AydkxFcHJseldtTlpnSTdZUEU2NC9MaHZmeHRBaytlRTRuNXAvRmxSSGNs?=
 =?utf-8?B?eU1ueGtlV1M0U0UrRVk3YVExZGxqU1VQUHJvT0FkNURETzczaHc3Y1VvWmVF?=
 =?utf-8?B?bWZ1ZWdZKzQzK3puVHd5S250YTVVRlR3N2xvMFlsOFgzWVNzRHRhLzFVZlBr?=
 =?utf-8?B?OFd1WktUUkptVk1wMmJNQTlTVlgwb0xrb3ljWDIveUIwQ1FBMlA2S0FKb2w1?=
 =?utf-8?B?TkdtbEswdWZFZkk2cG9qanA3eFV3dlk2VHMxOGFiWVFUTlIycTZuTk5IMWdx?=
 =?utf-8?B?RDlhZ1pONHVHWmpkZHNrOUF3ci9UMnVEMlAzMkZhUmdNV0JpRnlETy9Tc0lz?=
 =?utf-8?B?L2R4UmFRWWV3bnNBVll5dFJvNjBibDNxU0FNTGN3Q2RNR0ZhQTNsRDZMOGVN?=
 =?utf-8?B?NjByMW5rd3pFKzdleDY0aldyWEVEWVR5cDMvNXI5TXFZMHJMOFM1QXozTXJD?=
 =?utf-8?B?VkFMUEZJcDREbWN3ODVPa2ZFVlNBcWVzaUJkZ3VnN2dRRzNQUmZuSlFiUzM3?=
 =?utf-8?B?aEU3VXZDbk44aDRoZTFFQW0zcXR1dkU3YXdMNVRWUHFsNEdZVysySi9veG1t?=
 =?utf-8?B?V3k1dGwwRDNrTWZrZnIyLzNjaVJIVW45K0pMZ0hnV01YOEpEaFRmN0Q0aDdt?=
 =?utf-8?B?N29XWnhTNlEyUmNHNU9hcFVvdm5PRTQxbTBWdXpzYVJndnY3Mmc2Q0hrR2Fi?=
 =?utf-8?B?SEU5SFZKMDFKV2ZHMDhuVW9wV2VIRFRFbWJoOXRvQXZsV1B6SkZDYnRhMVpn?=
 =?utf-8?B?eTdVVk5CemZOUGRqTUFDbXJtMlVWS09VenpzWDlGZXBqWnZHYUZIdkRLL1A5?=
 =?utf-8?B?V0txMXNQS0V4b2tEL3VuR3BGek5TUnZOM2ZpUnptMERTSjNZK0NLNmZPRTAx?=
 =?utf-8?B?MW1QVVFQZkJwUE9TMEN2cGxWZmFNalhrWGxzdFlMeWpGUys4RnZvN3ZUNUYy?=
 =?utf-8?B?NnpwNGlrVWlVeHpTZTFiaU0ydzBXWURWNzQvV24xSFZkUkdUMjVCUC95aXJs?=
 =?utf-8?B?N1RRVmhuSTY0OW5NaFllSEo1YVppcnNDYTR5RVJOdWJQZ1dNbXI1WUIyKzVz?=
 =?utf-8?B?ellxaU9iMjZRSkJtU3FYRUFkREdvV2haT3lVQXRZZnk2K3Z0QjM2TjBPd2Yr?=
 =?utf-8?B?QzlaZmU4Q0gzMzJnV3BCUzFva0djeHVhTjVsMzdqbXQvdUlNanpNdkk5WkFw?=
 =?utf-8?Q?jZr5U+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHc2SzBwU0NPakd0NVQwZGNqYXYzaE9LTzBvcS82alFxQTRJY0V5RUplT2tB?=
 =?utf-8?B?RmNPK3owTGFJQWppVG1VR1N1SXFRZVRlOC9POEljOGs0RHRkT1pObFZHRWdQ?=
 =?utf-8?B?VFZ2WE5JTStRTTJRREc0cWV2b1hCd0h5MFRHaXI2WS9ua1lLMG9yL1F1bjds?=
 =?utf-8?B?YzlaV2FXYmQ5VWUzaU5aMThjc1MrdG1HL0d6ZnZtRUUzUFdsZ2VMS3VRWXBy?=
 =?utf-8?B?RmxZWklITW1TYmF3ZTU2N0xOKzI3V2JHY2x2OFREUmZ5clhRZFFWR1J5ZXdx?=
 =?utf-8?B?TlJRZHVvVi91TmpkMUU2V3hKbHhYd0ViWitQZ25jd2FPTmVrVllzQi8wOFdL?=
 =?utf-8?B?N3liWUQyUmk0dDRhTWY2RFY2UnB4L3IyQVBBOXMrL1BNN2FLY2hQOGZzRlpY?=
 =?utf-8?B?MDM5OGkxclk0NllZY0NlQnlSenlpY1VwR3VxR0FGTS91azY1MmRHNDJQNkVq?=
 =?utf-8?B?Nyt0SUlJUzJXYWVlTHVMalBsV0t4QzdDc2FBTzJqcmh1b0NuMGRPejFlT0Y1?=
 =?utf-8?B?MjUrVjgrOUg0NHg3ZkQxaDNYOVVlSXVsbnZXNTFUVVI1dU5LSVZ6SXBjQ29E?=
 =?utf-8?B?VmZUUFNUd2hXeStHTkNZQ28weU1WQmJ6L2RxVW1yWHhKRmJwS2dqeDV4RTMx?=
 =?utf-8?B?UEIvZGp5NUtSdys4NXFKMzV6aDJndnY2eFE5dHhobFJhWmVYWnU4MmZEazUv?=
 =?utf-8?B?M3JlaFVzZXdyTGJzSFpiZkQra0NqWDhyR21lUkk4dkdyclU3RXc1Q01VK0lP?=
 =?utf-8?B?bFlKYWE1c1diNGZDQ240VVQydkZiWjFXNnhBcnRiUjVObTNlTTdrajhFdGZE?=
 =?utf-8?B?aDBVZlVValluSWdhMnNvT2JGMHBXdjNqaGJaTUI1R0FNalFSQzREQ204dzhE?=
 =?utf-8?B?cFhQSmQ5YStxT2w5cWg3NDNOdEVldXhVWFBiWS9YSzdwaTRyVFkzbnR2ZVNa?=
 =?utf-8?B?TkxjMWFlZDYrYml5Rldsajg3aVRxcGo5VUpBWFVsOEh6cGUrSys0enhQQ3Y2?=
 =?utf-8?B?blNqR2xTTkN3c0hPMVh6a3krSTZaVDB4YnpPcTNKMTROUHpMOE56UllYMm5R?=
 =?utf-8?B?c1dSUVRGYUgySlcxK0lOckt6QWtaTkthK3N1K3lGUmhwZjV5bW9wVVFON0RD?=
 =?utf-8?B?KzdwUjRFWnpINEwxdnFXeW55Y1R2ZGZUWlFoaG5hQ1FNVUNrWFFhV3l0NTJp?=
 =?utf-8?B?Z1NLZHByRnRTeFNUamNIYlppVW1iS1VRU2VUc2h6V2I2YlErOGVxQ01INFZ4?=
 =?utf-8?B?SGpzTUthVmRjZUt1dFdhSkxObDJMWU5wN1oxYUNDclpTcWFTQXhBcHo3Mlp0?=
 =?utf-8?B?bklCYjkzaiswK1N0aGVnaWFZTDl4cTlrSUFraDYvMTlkVE45VjZLQ2FLbUxF?=
 =?utf-8?B?aWNTbEFFTkM5dEJQRUozakdtcVlBOUsyK2xVTXYxNDY0SGdiem1LZ1kzSndH?=
 =?utf-8?B?bk5HbENHbFJ6ZFNoak1nRXF5bElNVVJhYkowSk9qWEE0a3dibmtSQktZMkh1?=
 =?utf-8?B?STUwM1l5Q2l6Nmw2Ukx4cDdtOUdEcVV0My94M2ZWaFJaN3ZHNEQ2cTJHZito?=
 =?utf-8?B?eGdYdXdQb0lwQkdDcjh5c1ZOOHRMdXdlczNsUmhJYm1jVFR1TU5pbzdrMUND?=
 =?utf-8?B?K25aSWp4eXNFU3dQcEdEVkNtek1oWDFtWDV0TDJxbk9kaWY2bjZsdk1Da2d4?=
 =?utf-8?B?d1kweWJOOENnV3dTU0lmdGhmUkkrSUFMWVNMS2U3dVVPWHQ0bGVSM0o2VkxB?=
 =?utf-8?B?dzVHSW1zQzMvMUhjMDFaTEp5aGNiTU1HUzRSbFRFMGxHWVdaM2E4VHRnL210?=
 =?utf-8?B?N09vZ0dmK0lJSHhNajN2Q0JWU1VLK01YcmJMLzlnYWZQRFpFemhUa0pNWWYz?=
 =?utf-8?B?TC9CYmFSbEVydmVZanNYMExPOVlqTngyRFNkblkxRzJ2QkQ3aGo5clFoZjJO?=
 =?utf-8?B?WCsvNCt1UDZmdk51RExzcUh2MGcrTm53ZXJFMFdpZytYS25qMmhUM2tsU09x?=
 =?utf-8?B?SFFrdjhBeTkxZHJ1cmUzaHpVNEZFcnN6bUp0L3BkY2JCckwvZjM3WnBRaWFP?=
 =?utf-8?B?VUMwRmRmL1E2VzQwTGJMQWtWVHlaaWJrNFdLMDVMY0I5dFNSY3FveUhqWGNk?=
 =?utf-8?Q?ion4fGzpVm0FsqmE87uuhxG2H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e61aba8-223d-4bde-d860-08de08a5d226
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:09:02.2995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVqivGJ+e9/klrDzQVFgc/TdZ/rEcM2QyFkzBJYvclNHJW6+W5xuL7HXmuLrVmDomD0tllKdnUVxAeKr3XR+7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

Since PQC container has changed version to 0x2 in container header,
update the header's check.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/f_sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 647001d8dd0..f72e27028b7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -765,7 +765,7 @@ static ulong search_container_header(ulong p, int size)
 
 	for (i = 0; i < size; i += 4) {
 		hdr = (u8 *)(p + i);
-		if (*(hdr + 3) == 0x87 && *hdr == 0)
+		if (*(hdr + 3) == 0x87 && (*hdr == 0 || *hdr == 2))
 			if (*(hdr + 1) != 0 || *(hdr + 2) != 0)
 				return p + i;
 	}

-- 
2.43.0

