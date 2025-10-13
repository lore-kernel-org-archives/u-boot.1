Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD9ECCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6685983965;
	Mon, 13 Oct 2025 09:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gs7Zajn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBFD68384E; Mon, 13 Oct 2025 09:00:17 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64088381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP0xB2wXszsv3P0JKdmQCRdhxCFv5GySIiUaGbf+TlZbVenuNo7j/rN7YqDM69IppyD4S+bwmqk4RY5fJgstq4JMgGtF9Z5x/vXgleFiWN6BBWZRiT5rJ3PNKNDrpndqD2LZdGTlucfQp7WeVh+n9i7CN7BWfwTIlRM1RvIY2btNiX1i9mvzHERp+P+SIV0YuRu20s5aDNgfXEWsB4U/apwc3MTGe9Wq+6ZLZpFPzTPuR0H0q75tuJsE5BQMG1eBJR7Oc2ONGU0VRmMVdZMAtihxY8Nu1ODgzwrkk9bbPBZlgtb733C9M1MIxCpAntSpUFlWyhIxeBbo410Nf5S6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=ijEQk9hufXUXpztMv4prv5mvKtHKEuSTqhf1hny01IwAGHgWRNso75RfuV8tWQyNeD+VCrsyf4OjG7pWyvEf0n2rgm/2mU0t1dfud4B4zx06k1VvxCkJYJBMlQO/4aTy9Q+4ZYc3xZ+9oANI9kRv7Mr4tCoO1Hoho9Da7xVmck60Wg8Sd3zgnXWG9Rrm1lO0K9Hc1vrtLU9+sks40qXoUn5Q9sMKxyV0ebBHEgQqPKVhYWdoTuPmyoz+T2VgwTSvKMjJ90/p9jLBjQ8P/5He48pveAW+0pAh/Z9vZeCGPRCEpjrMvht9vrUfoWh8Ovf4ivSgViGpNR8K4NRd3/h/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=gs7Zajn5gL1pfmgXWh5Sc8sJPq+OHcS3fOTg0Jx72Z9zoX2lx3OAUI0pv9AAVzjjK95wZungQW4NahhCAsVyCnpvSQ/Ep/vB1DQKFOhuz6Uk7rpbNi0qYRlj49hux0JJNh9qaXZSevx8VBkeG/d/TNn2k7w4kR8hMdQOPzSA0peZHLkDfb5zdBqzkQtxjtiFQ/EXN9ADGe01GX6wikBACo5ntdVJAR8z0pNDyPhDaR7TUj/mxcASwCrz+/GF+3yxQ2u/Zh+7k5VNaeCq1Nlo3i+TduPnI1MPOj/jPifjS4YM1ssiDcNRNHVBjw1sJ+xyHz4D+e2EOQ0scvlB8MTWZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:00:13 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:13 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:47 +0800
Subject: [PATCH v3 06/10] phy: imx8mq-usb: Add SPL support for i.MX8MQ,
 i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-6-293e79d4bc12@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 4543b3e5-5920-4dda-f686-08de0a26284b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2t3TUV2R21FVUpsU0VTQmFYbGZBZmlqbFlHeitMUGpidHNkeERNOU11Mkha?=
 =?utf-8?B?MkRGczFNQk1yYXJpbW1QMkhpeTJZVk1xNkF1MlhPcGNVZFNSWmExOW5HcjR3?=
 =?utf-8?B?Ri9YL1VvODF1VnhHMjRCRGFkSitJNlBtWU1CRkR2UjBaT0kwSm5kUHZZeUZr?=
 =?utf-8?B?YXFtM0thRnRkT1Bka2NFQ2YzTjE1TDQxK1JTVkozb1g5NDE5cVNOeEQwWjAw?=
 =?utf-8?B?Z291ZWNFOUpvNWE0cE04Y1ViNFpPZjdYaFZQVzNVdFI3TDZqVmtialUyZ0VQ?=
 =?utf-8?B?SGExK0tSL0MzcStjWUhISVpSYjR1NjBTNC9YOE8za1RuZWlsdmFQNCtZVnZw?=
 =?utf-8?B?aGhydlY4eHY1c2MydkZFNWVMQmNweDVpeVBrRGJqQ0Q3ZGZoR3ZaTURyTzNO?=
 =?utf-8?B?aVlkUWFzTnFhYXBSUXF4NUY1ZnN6MGpLaDN5dWxBdnVBWjVVKzN1ejNyVmNm?=
 =?utf-8?B?TExFc00wRFlHNU82MERnZlJCNTNEVWJRbk5RU1ZvSU5aWEJzLzN6b3NMU2Ft?=
 =?utf-8?B?Z0lzM2pnSHFVVjF4Y0NleXJ0WVY0T1h1Y0hLaHR0STlPK2FDdENwQ0dkRVpt?=
 =?utf-8?B?TDAzZ1lmVi95MGZ6R2pRQ1pOSXpPZVFNN2wwZWJzZlJQUDdIN3FibUUyU0Vx?=
 =?utf-8?B?V2NCQmpyR3ZXNmFSQXYwcHlKeS9WSjBRSWZYWFkzWUhSQ2p5ZlN1UWxGN3F0?=
 =?utf-8?B?Vjd4UmJkYmQvV2ZWcTBCVU1YU2NCVDFMT2NvUmtqSGRhd2kzVGhCQ251clhD?=
 =?utf-8?B?VmtiMis1ZmZBRnQyQm5MQ3I0djk3UDB1cjRlblJCQW03bURjZXg2U0RWbVp5?=
 =?utf-8?B?VUxocVdvZTVNVEEyUjZpTXBDT21sMnJuYm9qKzJhWUhKOFNFVlFmZ295ZG9D?=
 =?utf-8?B?Q05UVWRnWG8yeHBxWXlLcFpMZUF1VkhETjkrSlVabllZSTJNYlVGTGNpSjhw?=
 =?utf-8?B?c1BjNlJYUGlpVk5CZ0lzS3VYVkw0S1pVdktRbmZZZ1hKOW5tZ2lVcE1PaXY5?=
 =?utf-8?B?dDdaaEZDam1yUm5tRitBZ3NuZ1UvZ3dsSUVhcHBTT0IvQ3BtOUlGWEVJM0gx?=
 =?utf-8?B?eWo2b0dMZXZaZUFyZU1pWlMydFZuanlNQytzSGNmWmpiK2FvUmFUSW55ZTNY?=
 =?utf-8?B?V20xNDlMWk5QQitiNXo0VkdqWFNPY3RTeUhGYWNUL1I0UUlmSmhqZ0dQcDBy?=
 =?utf-8?B?WVRXQVdOaFp0bjNBWHpZdDk5a2tMUWV3VUUrS3hpLzNYK3V0QThmUmZrc3dr?=
 =?utf-8?B?R0VISFRsNi9sWXJRMUlnS2YwUE56OVRtb1E2ZW5kaC9GdUF6ck5ncGdmckZC?=
 =?utf-8?B?NU5hU3pxTm9xaW1ESkVwSlAzTDJvQUVrNUd3YjBocFZKU1JESngzc2hWSGtp?=
 =?utf-8?B?amR5dEtXbzE2ci9pa3BSTGkxN0plNFNSc0UxK2pDcEVabWkvMU9kcWVIUlVh?=
 =?utf-8?B?UGJYY3ZLdXpBVWdmRHJkVml0bDJVUG1sanBWUTBHaStkRzJBRXBySFB0S1Zv?=
 =?utf-8?B?YlJaT1JTc3pvdGsydXQ4RWpkbXhyOGk5SkZjNnJCQ1FQWEZYb3k0U0MrdkVn?=
 =?utf-8?B?dkxnV1pTNFZFdm9zelg0RWhuT3ZjL2RiSnFHaW9LaVpDZmEvN1JPVnB1d0h3?=
 =?utf-8?B?WGpNVlhYQW1ZZ1hic29wWEdpS1BmbWQvblBwVmpHVjdsWVlCQVpIRnliL2tl?=
 =?utf-8?B?SHdGS1ZUc0lQYjlaaVRoVVdtYzR4UitRV0QxejdZT0tYbEY0bHZlNGVWRzFI?=
 =?utf-8?B?VjlqbXdXZFZBTkdFYnVCL0VkUEdEcU1TcW1mbERrYVN5VmljQ09ncnFIcnYx?=
 =?utf-8?B?ekZTcDRYbFVIeXdGRGxmWE1rMmp0RVhEeldKeHFFRlhzQ1dkejlqMUhVSlVs?=
 =?utf-8?B?cUFvYUlGdUJsZ3dJa041d0hzNVM5cnk5T0VGb0ZhZHVzN3F3cXVKNzFMZlJZ?=
 =?utf-8?B?U2J2NU1WYUZ1Vi8rVEJQUFhVWFJwZDFDY1BYZ01WMTBKQkVmQk9HMmxBVnRm?=
 =?utf-8?B?QnMwRk5wYUJ5MWRsMDNnRU9TbDJFdm5CU3lGRkdGL1ZBbGpudjY4THpTYUVz?=
 =?utf-8?Q?EJViWw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Z6Rk9BU2cyNmhEeWVpY25XK0FUb3dESjBBYWpiYVNLMVRUTHJ5SFlhamZR?=
 =?utf-8?B?SVJid0NaTEY3ZFdpcUloTW5SaStnNWYwM1M3TUV6OTl0ZjluZW5RVSt0cEpF?=
 =?utf-8?B?TXF1K2JSdmdUSDdxUnduNktYbERINGRuand3Z1FiQWxHN2lpSGpHdzA0VkFi?=
 =?utf-8?B?cHNuS1c4TjR6Q0ZLakNoeUF4aGRvK0JQNkhTWEYrV24wTHRSU1VySVVETDJ5?=
 =?utf-8?B?YjFDbTZYd0JjS3diT1NoYzdXTWlaNnMyUG9CQWIrVXQ0djFxM3ZCNC9GcDFJ?=
 =?utf-8?B?UkljR2w3VnI4aUgram9KYWEvUWQ1a3F4VWlSZG42ajJsWG8ydXhUNFZXVWVT?=
 =?utf-8?B?bFc0QVZOS0l1ZTF6Tm9Eb0V0T3kvVjU2UjBxMWIwUWdqdTVSM2xFanBxcjdM?=
 =?utf-8?B?Z2JYOTBYdklVR3pSZHY1ejBJME9FRE5wellyQmQwR1lmbkJxQjRxRWFyaTdK?=
 =?utf-8?B?WFFnNUx6ejJWd2JKUllxampLZmFVWTk1cnFwVUo3T1JCYmtMemp1emRZenFv?=
 =?utf-8?B?aEVQM1UxRWZ5cE13a3VVb0c1b2EyaldVeG50MUpuU1NURWdoYVhhd2NTNkZ6?=
 =?utf-8?B?SmU5K3lJT2s2M21DY0o2VWRRKzlkTmV5K3JDY0syd1U1SUxYSnd3ZVlhZWd1?=
 =?utf-8?B?Mk5tMEhZcU1SaUxFZFlZOVFMZUl4SzNXRFBXR0dDQ1lTODJVMzljWm85cDVC?=
 =?utf-8?B?ZmRZN0JzZHd2SGJtWjRaQ29uMnh6ZWFaZGtLUGh2TzFGWkxOWjd3OXh1SHpI?=
 =?utf-8?B?RlFBYkRXMWdBWUV6Sm85Qit4ZkttTk8yQTVNNzRHelBZQnFMajVTaDZ2R09I?=
 =?utf-8?B?U1lsL2VGOUN6SEZpOHZveUdFSUVORGdJeFB1T05OWjRnVXpDaDBlc3lYRCtM?=
 =?utf-8?B?Uyt6N2VqQ0JlaFBKRkVZU0dBRi9iWHhqZk5ZaGhoQXFNQ2IrS0lNNjdIdUty?=
 =?utf-8?B?ektzV0RSSnNRRWRXYXMvZFhtSnVkR0hHZDFNSmEvWEdFckdCWjZKK1diSWhO?=
 =?utf-8?B?amVZQmJiRVBFMmxXa05Jdll4S3QwZVVIaFA5SFpZYy9pSnpoVmZZTm9wR0pK?=
 =?utf-8?B?K1VGUTlrQlZ3UVdUZCtwUy9TbEg5aStvRG9YSnhDdzJBb3VHTThtYkFEYUVJ?=
 =?utf-8?B?M0NKeHFLVURJcUo5V1hoYlV1b2tOWVdQOVJOSGQ4VzVZYTVHRHE2UDhDc090?=
 =?utf-8?B?Tmw0UFA3RElaT0xqNms4QW1sMW1ER1oyemVValpJa2kzNWN5OGxzREJEM0gv?=
 =?utf-8?B?Z21xRHJsUEY3Rmo0ZE1SSXlrcVRHL2xidDdwSFRqaGl5RlNoSUNDUURjQnVU?=
 =?utf-8?B?UVF4WVdNS0lIb3NNY3ZBWEdBZlcyWmpoS1liclVwazlxcmtrdllmdFhFMTI0?=
 =?utf-8?B?c25VOHpWbEJ2SWdsSVZSTS9PeW1GSFptU0hEOWpRSW1TcnpoYi92RnY3dUhY?=
 =?utf-8?B?THkwTE9ZS3lYcXdOeGJqY2N2OFJMUGF5ai8yVkdHZ2Jndmpkc01ZdnBPT3dq?=
 =?utf-8?B?aGdXcGVSaTVvZTZBb1pwdHZjWFhIemc3NUJ0anAxYUMyZkxtVlh1ZTJRS3VV?=
 =?utf-8?B?QlpRcDhTNG1NU1IwMEoyMFhiVnRRay9Xd0tUc0pIL2ZvY2hOMkt3RmkvVCts?=
 =?utf-8?B?L3JlQm9UWFpMaEl1S2NtVjRtL2diMnhGaVZUdmZkK1lENGV5RDhyZEErSDE2?=
 =?utf-8?B?cDdRRTVMais3YUNOK2tCUnRZajNqU3g0SEsveHQ5aEMyUVA4bXlBVEJzZFVU?=
 =?utf-8?B?OGo1QmRKMXJXSTJ5TFpCd0FGaVlKS1BpV3QwQm1FS2xOeThTZG5aeWFYeGov?=
 =?utf-8?B?aDdTVXpSTWZ6YWhJaDZZQXI0T1pSeXhOU3lFYUZrT2R5eEtXL0FpMWIwcnY5?=
 =?utf-8?B?VjdnY2RCckViUzZpZ09GN09zdEhNWE43UVdPL2ltNTZuRitJUk5Cc3VPeC9x?=
 =?utf-8?B?MGYwVTJoR3ZsV2NTbUlMcmFiaUp5ZnRLbk9PYlkydDFtdTJWbGxNeDZuMkNO?=
 =?utf-8?B?TFhKeDdXS2paVDdadXF4WndiL2lSYzRGNzlRdnRVTXVsamdqMmFzZ3Z3QUtq?=
 =?utf-8?B?aEgvbktlR3B3TVZKMFZsdUZFTWxvdHFSNmpGMzI4Mjl1a00wcXdOZU1JMGlj?=
 =?utf-8?Q?miQxKEXPbIhCcheifFGM/tlXn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4543b3e5-5920-4dda-f686-08de0a26284b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:00:13.6284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMnoKIDhV2yfcw9KqDPnK9uMWlDaJ5PYotm5Ju1l37M/uhMFg8+Iaat+RCs85ei0WVLrzfAIdFuMj2JXSTKc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

This patch adds SPL Kconfig option (SPL_PHY_IMX8MQ_USB) for the i.MX8MQ,
i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY driver, allowing the driver to be
compiled and probed in SPL stage.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/phy/Kconfig  | 14 +++++++++++---
 drivers/phy/Makefile |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d36a5f00ef8..420d7c7a44d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -289,11 +289,19 @@ config PHY_NPCM_USB
 	  Support the USB PHY in NPCM SoCs
 
 config PHY_IMX8MQ_USB
-	bool "NXP i.MX8MQ/i.MX8MP/i.MX95 USB PHY Driver"
+	bool "NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB PHY Driver"
 	depends on PHY
-	depends on IMX8MQ || IMX8MP || IMX95
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
 	help
-	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, and i.MX95 SoC
+	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 SoCs.
+
+config SPL_PHY_IMX8MQ_USB
+	bool "Enable NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB3.0 PHY Driver in SPL"
+	depends on SPL_PHY
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
+	help
+	  Enable support for the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and
+	  i.MX94 SoCs in SPL.
 
 config PHY_IMX8M_PCIE
 	bool "NXP i.MX8MM/i.MX8MP PCIe PHY Driver"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 98c1ef8683b..5a6df0ecfeb 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
-obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
+obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
 obj-y += cadence/

-- 
2.43.0

