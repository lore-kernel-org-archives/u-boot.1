Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F4DCCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04DE4838AB;
	Mon, 13 Oct 2025 09:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dlAGt8Sk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A4C8384E; Mon, 13 Oct 2025 08:59:35 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927BB8381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghcvpHZGK7Ulou7W/2m0wIMggKwaUrKfvP+EhHJOUhUMFeqTaNMGg6TtmRp3HIKNqEViJ3ZUD+6Ng7QzreFP2V7j+bL94OxNsr1cyCnpJNVuYF/HbN6RrjUQms3JNAQaRgnfqHgaXVDzwZOHXulFss/ylNDfviyJuDtTPYK3n0Frma0wfaCQ+fPqfp4tKp3EH2WgNxhjtpkfr0/ak5dzj4wv1Qz0AN+BC+OiL6xVN3NQFf+rFRV5xCWgoEK3uYUn6qQgu1uRRMq4ldjTTSXzplEm4IN0r6Yox25yYU9QWHPk59eU+JHhqCu3OCEQpae98ok8mnQQyQ96mUAfKhNIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wGqX4clhIDD//T1SvSyRCB068QUVTxDjzgHbvU/0Kk=;
 b=AMWMuawYwfVumD2hLh0e347PeZ+KSfpBIOcLnQJPw6SSa+pTWZF98L7i7vQDdslViizxPykaWwZYbec2bwnvyEasBpCwRhVqB80rl+WPs/lVMydbRHMjVgeSC++CY5RO8cbRTL9GhfPoMoCACPOXWb1GpT1xoTZ3p+ayW9b5gvIC8SGbWJEN09dSsRBqaZ8/1Qcz1zlqx+39YX6b5MYq6RBGalGpjFsrU2ENMuCAg8HwxvCaGF0fYsJAd4oBv5lUixv3xflIxddDL//CZm0zORCpnE8Bj4bxbrXH69ZJET1Q6gdiUw0xJ3ipvSQYSDtXrkfnOJ9U4AnwCSdk6b+vMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wGqX4clhIDD//T1SvSyRCB068QUVTxDjzgHbvU/0Kk=;
 b=dlAGt8SkHjxzoNDF3UqM7R1HiEXG3HMepOMdtwzhoAe3fxCv4HZgDdNwcNJ2ZqT0eqnHzoc2KWY0wwUTeCjwPy2Jr8xeHgtaDS9iPUr/MwxgrbTUV4qMQCi6ah4uWyF+pBEoarNNrB8qdelWEeAs/evYkpJTt5lea/dVH9aVufYxIZb9626maCEl/vEPiEgQOwRJe6yZIAXF6+V6UxZbAfNEY9QSthLP6Tw5wMyJS+pz8HjWH/qqQNr+yI/BPYIF1Oq3+4kdNNYN31j95cm2FUSE+tp6XcJ6uZT4L2YuzQq2k497C5QXLnW/cMiuZRnMVvWeJXzYRZ1MK343/rHn+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:59:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:59:31 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:42 +0800
Subject: [PATCH v3 01/10] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-1-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: e19a48c6-996f-499a-d054-08de0a260ee4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|19092799006|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzdxMGQrT05LanNQZjFFR2tQd203TENRVURoS3NRV01Qa3d1SFd2TDdzVkly?=
 =?utf-8?B?WUVBWVh3dmVmR1U4cVlkdXUyV2J6d0pOcjdHNWU0RXlsZFM5aE90d1lTZ28w?=
 =?utf-8?B?NDlpcGFPZkJlOHpJS1JNaGd4b1p4eDJoUnhGRWw3TCtzLzZ1UE5IYTlyZVZE?=
 =?utf-8?B?dU9OWGZOSzZnZ3V6eWZPQmN6TDF3R1N5dzNiSUVYb2R1TlFpRGVaa2phT3po?=
 =?utf-8?B?QUhwMFJyMTFtZGJMYWJCQVM2NWNzY1E0dmdZQWpaRExZOVRsblhDdG1KYXll?=
 =?utf-8?B?d2NMM0RUSW1NU1hFeGhaQ1BPbjdNOXpZb09HLzJockhDMzlSVTNHT25LM1ha?=
 =?utf-8?B?T3hCV3dnZEtxbDVGOVZhbmduNHFFcGNlVm16ZmNyOU5UckpaWjBYQXpUU1Nl?=
 =?utf-8?B?R0FCSUlyRzE2N1c1eTFaUGFDR1BEclQ4YzAwZmdFVXl4dEU5a1ZkeXlqMzJ3?=
 =?utf-8?B?MlE1enc2bWVOamwrUHA3NERIdUtlWG9oZjhmNzFNWm1LT2pBK2I2RTh3ei9u?=
 =?utf-8?B?Vk9sVjR5UEl6cTJqemM0ZXFYVHJzRjlDUmdlblE5K2J0TGFaNE5hUXRQTnpS?=
 =?utf-8?B?R0srangyTUZSWlVsMXl6aWJtZitkdmFHVVRXWGE4TkVsdXpjUmlMaFRMN3gw?=
 =?utf-8?B?dFp0eUViVzFyelJLVm5KTUYwSy9kS25aVnl3N0dVWVc2bktKZE5zL1R2UU1q?=
 =?utf-8?B?Y1phd2c2cjg4Q0hSTlZ2ZWVqeGVydjQxK1Bxck5aOU9jcGx6cW9aOW5uU2Jq?=
 =?utf-8?B?eldSMzNUQ2xUOWE1K2xORU1WOWFnZ0tUamJGUkc3R2JKTmtNNEVKMnpkdHRK?=
 =?utf-8?B?YkRhZFVjN3dyb0pRQmtpazY0UFVaVG1ITTNkamo5S3JucTVPY1R1WVRJQ3pI?=
 =?utf-8?B?dng1QUJDMlNreU1yVmxHd1pEVlpMcVVqS2pVWEp4ZUlGWDFIVGx6RURJaStW?=
 =?utf-8?B?RG9HSzlrUXdySitySVJyVU05NWljN0NQdG1iSDhaNE1sZ2QrZm5mTnh3ZEhJ?=
 =?utf-8?B?ZlRidmVCTDhyM1VEUDg4QnF5b3RWdW1oc1dyNVM4Ulkrc3J3NjArWlBMdTl5?=
 =?utf-8?B?K0dMV0M1YVh5V2tPOTUzOVRLME5ERytQRGJHajZidGVSTE8xa2JocjhwR0Rn?=
 =?utf-8?B?TXJxN01VcnhUTWRkQ00xMHNqV3NYbVZ0V1RhNkM4L0ozeUFReGM0NVpMNGoy?=
 =?utf-8?B?Vlo1ZDU2R2w5TWl6dzBNUGRzZDlDOUd2ME1MZ0prRVVwTG8vRDNHa1JOREhP?=
 =?utf-8?B?K0FOT1JhaFR2WjZmaGtaMXByQkZ6VHdWdjA1eTM2VzAzRjhNYjdYelljVzkz?=
 =?utf-8?B?cjBUU1A5alZoRFFyTFkwelQ5dDF1K20rcXM2SmsyWXFobUU3c054a3BySFI0?=
 =?utf-8?B?VFpUV1Vvc042NGpacGxjazZLL1h4eHdVcGZwMWNBaVFGcStLRzkzZXJvTkUr?=
 =?utf-8?B?eFdDSlRKazJWSDI4NmpUeWZaVlZnTmRGaUpWanh0YnRJK2oxRkZtVVBWUzBZ?=
 =?utf-8?B?Yi8xZElMc0Yra2NVOHdhNnpNNTA1WHBJS1BwcHBZK1JVZUJBNkZqYzdYRlNm?=
 =?utf-8?B?aktUdUFMVjE0SjNSa0JtR1l4dmozakpKd2FLY1lXZHV1RW11REhzaWp2amQ0?=
 =?utf-8?B?c2YrSXJka25jVlh0UEM0NFVXcDVKdlJPYm9uRmh3S2hMaTNiT3UzOWFEN3pP?=
 =?utf-8?B?cTFLeWpHa29lMm5FOXg5alFzWFVZSldXTDFqMTRSZkswTmdQZWFWQzhQUEx2?=
 =?utf-8?B?dnBKaDU0TFNWUUx3L1g0RklpSzJ4WGF4K3dPTTBhVzZFd0NkczV0MndPRCtW?=
 =?utf-8?B?WDdiU0kwdzhjSGo3UG9TZ1hpR1ZzS2psRG1xcTVRTGJINzFTQ2syaEZCcmF2?=
 =?utf-8?B?Mm1wZTJaUWdQd2pnZXJoSFhjRENvWmFaUHdqaTJrcUVOd0w1RWZCRkdLWTBw?=
 =?utf-8?B?S2wrU3J4M0N3WE04aHYzb0YzMTJwbURkQzRDbDQ0ZS82ejMzQUxZVzE1UE8x?=
 =?utf-8?B?UytiN3c3aTFBaFNuVGxUOW0relZlb1VIN25TYXVOWTVCOXhGaWRtdmxvNjdm?=
 =?utf-8?Q?qZSSTv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmYxR3ExeWhpekhPY09NUVZ3MjE2WFFRRnFLQkNzNytWMExRY2FHK2JVY3lj?=
 =?utf-8?B?dVBMa3huajJYai9aRmE4TEZwQzErUUN4dHNKclkveE1ZcVYyT01WYkZ5bUw4?=
 =?utf-8?B?b3ZtaXh0TTlsK2lkaXBMTjVlWGZ6U0JXdzVWZi9zZHpUREU0UGdrUDFncmg5?=
 =?utf-8?B?NDYwa0w0Vi9hUE14Mk9BWmdmN0dsbTlPc2FVd2Z6eEVYY1FTOGxpZlpvVHJI?=
 =?utf-8?B?NndZUi9XVlpNWFpVTjZneFc1NnR5VXVBMis1L01kWjBuOXNBaVo5NVQ1Mm54?=
 =?utf-8?B?YUpreEJnaGdEQ3JuZzNIWlRKOEFIWEpTL2V4L1hJUTdXdDhnckU0R2dNSjEv?=
 =?utf-8?B?bmRBWjE1MkNpN2s0b1lVU1VOOGU3aGt1aTNRdHBHZlkrNUpvT2FIamJ3dkRO?=
 =?utf-8?B?bjgwaDFvRWpxa2VaNmttTXJpcEhmZmpXVHB5UTdQcUpWaXFsREVHdFlVTWFG?=
 =?utf-8?B?eFk4MGNJWUxwbHo1dDZ5SFdvYWlZUllsNUdlL0RxSWVFWlRBcER5NVR6VVdW?=
 =?utf-8?B?a3VmQ0M3M2dQalFMVUFFbGxZY2JKWHVNOUNMSlFUM2tyOHdZTkFoQjN2Qmty?=
 =?utf-8?B?d1ErdnBpUmh0L01zeDhvZWxjZEFockZsTUJ1dm9IS1VCQk1qSWVkYjNYaFlM?=
 =?utf-8?B?M214TUpsWWJhWmQvanV1Yjl5NXpEeFVuM3R5bkZtMCtUTUw2ZEpQdjRkNWZy?=
 =?utf-8?B?ajBKZ0w2TTJOeVREWGhBNUtndTJzL2N5QVRrNlVVSzN3Y3hQbGZ0Sk52T0Nm?=
 =?utf-8?B?T25LSld6d0NDbExScDFTbVFNT2tmOFhjWk9ScnpiL1pvUHJ6WWV0Z0hmZEoz?=
 =?utf-8?B?M1doZUl1a0RxaVVYdFloMTgwcFhxUGVjcjlNTys5d0d0MWgwVU1iakVUUjJs?=
 =?utf-8?B?dHlzc0hXVHdLOGpsWC9BOWFhOTRQUXBrNzJGcmpOSG4wUGRWSUpUT3pRWTlI?=
 =?utf-8?B?OThjdUVJclhpY0xiK0VlaUVhR2lEWXdrS0N0ckdyaDdTcHpxU21WcSs3d3VM?=
 =?utf-8?B?MUZrN3hWbjA3WmpKbXRYR2RVVmE0M1hSYjNsSGZxd0U3RFVBYlBmUTgzaUxk?=
 =?utf-8?B?eDN2V2lIK2JQZmlLZlZXZ1c3RmtVeXoyZ0NFUFBmeWM2L25IZGpBUEROTitM?=
 =?utf-8?B?Ym9XemxOdDhZQ3BlMTZ5eUZuaG9PUkI0eFIxb3hoZVdKTmc2U2hiSjNIbk5C?=
 =?utf-8?B?RXF4RVkzNXVUdzBRdzk0L2JYVDI3MWFyVUQwWVZRVE5RUG5qcDBISGRkYWox?=
 =?utf-8?B?VmovOU9xYmZ2QUg5dmZwNHNNSjZYYjBrNFRlaTJPcm5aZ1A5VFRoaFQzelZa?=
 =?utf-8?B?MmF3R0kvWm9kbDFhcTdVei81eDdJY1JTMjhoc21za3FCNFN2b2NvSmhTdHNG?=
 =?utf-8?B?NEU3Q3M5enFobnp1Rm1hVlBOSTN5UUdsWmF4ZDA0VDhSbjBONDB1NVcwSW0x?=
 =?utf-8?B?a2JVZjhPUmlpS0x0ZmFSZWw4M2d1TERLUEh0RHM5UzJtdzF5c0l6Mkk2Z08z?=
 =?utf-8?B?blBoL3hIMVFjcStkcXN3eWNDQ2FNdGwwTWlIQStsOTJOL3VTT0x3OE5xbE5s?=
 =?utf-8?B?UGxSSlBUSUhrMmZRZ3VoUndIdzUyaUdjSFQyQVc3cEM0QlBmOEFXelVRL29S?=
 =?utf-8?B?Z3diRWhaS1VUN2lGNXVQb1o1MzFDaS95ZUZPWFRlQUFWcXRESWZNcEVnUWwx?=
 =?utf-8?B?Tk5DVkdOUXcxOVNxUHRsd2pzODhlSTlvYzN6NHJjT01XSSsrYVFDWkNzQVh0?=
 =?utf-8?B?OE16QWREb3ptMktwVUk5aEQ0T0ZXYUtHUUk0dmlZRUwwSVBXc01tRTdudXRj?=
 =?utf-8?B?WHNteElHS3Jka1c1clFpSWgzNkdhczRHc0xoMnp3ZktUMG05Szg5cktrU3FL?=
 =?utf-8?B?a0hvRWpGREs3Uko0STRtZUFZaVZrZkpzTVVoNmxHNVdmQndxVUhhVHlCcTh1?=
 =?utf-8?B?MFpraXFUMURxRHdmSC9TZUY0bDVheWVnVmFPTlJrUXc5ZWNxMmZwRTFnZmN4?=
 =?utf-8?B?NUFkbW15Yi9kb0JJSUpXakRUeFZnMm9CZStLN1BqWXkweDFZRENubjdkWFh3?=
 =?utf-8?B?VE5xeVBGMGNDMWlhRnVJanpnTmJpUk9nRG1LR3N2aUd5aFFPZWhUTmhNVEw1?=
 =?utf-8?Q?ewt3INmAlTQUbW3BA4UNAuWjG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19a48c6-996f-499a-d054-08de0a260ee4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:59:31.0561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY8n+O+Kyi+O5PphJX3glZelqqo/QupSqKgLekBhJ+tr/bdlQioA8NGzZAA/D2a/pN+z1yM/L2PVOxqXe7fpEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

From: Alice Guo <alice.guo@nxp.com>

Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
i.MX95, the condition check is updated to use IMX9.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2cf687fc4f3..427b62e934b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,10 +210,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
+	depends on ARCH_MX7 || IMX8M || IMX9
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93 || IMX95
-	select NOP_PHY if IMX8M || IMX93 || IMX95
+	select PHY if IMX8M || IMX9
+	select NOP_PHY if IMX8M || IMX9
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

-- 
2.43.0

