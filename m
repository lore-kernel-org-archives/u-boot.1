Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9732D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 13:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF8F8452E;
	Fri, 28 Nov 2025 14:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hxpsct1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7CB84534; Fri, 28 Nov 2025 14:17:58 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A038B83B27
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVypM6UBGMD5xw1p5nrdkg8u059Jttw5+7WUeMFYqVxW8/KFRUDsnGSZqARF77AuPnezZwmiNT+7JyI9hmW9Fl/f2KCnXETsvH3iFd6WGFUgtvXYVA8H4rrq2Y6qWf+Eg6X6jQNuA6mXq0hgfKvtku+oYgulWFmb4Zau+sgd+f7ozsLmnzMNU87gt4C4Hqf5VZs/tnbLGvBcUfpuAW78b+nhIqRBuiOqB8RBwI+NrjRjwXWE1PRP7um+8/MI+PLmAkYjDHGmD1R0KFu7LH0eseBV6Ialsg/6QNBqo0PL+vcIPR3O/Y55xer9Nc+rs+OWdIqaj7DWLa7uKOqx6tIP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isCCu6QO3LFY5n1QP2JTUZ1tLuV1TaKSLzM3wJP49Fk=;
 b=oAZei4NjJ5K0qCetlhZN18T+9ODpZF0L52Q/KQX/mtOa6S0UcsqSoUz1KX1UF2vkRHIeOtsKfb12hf8F7+LwzCnvYWFFh4NymC5P3dOeovz0QoN6nwpojESgN+IGxk085/gTQ5M42HIvveXgGZDZ/nRqfcCCPavqyK3cSId0uMMXQhlVaeDf7uoapnS4r53MZXFTsk9jZ48vFF1l9KGiSBmtvwnMKZBiRkhehdYYhWx9gDEelcecnNGyKIKYSRpMS39ZS0fA8aOb+I+QfeOmu7CZgOAsnv4+fbK9yEwej6kYp3xTZzCjg7mlycjvU/Nu6J1XfVVMKr7cfGfieR8NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isCCu6QO3LFY5n1QP2JTUZ1tLuV1TaKSLzM3wJP49Fk=;
 b=Hxpsct1EcqQg/c302i4q/olMvNpKtX/2rDokLa8L5TcfvZaphrH1EFCDl7rSx4E+zvVNljCOG3EK/+eDO/Gl8eKZEJk3WHrWhGejWSbXoWBImBNCUqpU/3i9ArHJtwotjBTGQD2IVhsh4HxsvFtQPxQMkoLzyMFuX7GBBKNZUGfN8AkNI1o/yCd3zbJJdmt0abRtH+hRHp5Y3SgVKI6YSayPq1MFOGbfY10vVAWGapkCaO8WMwa+NxdKDd24iMTJ0ZFckDhOEpqFk1A8VTJMhrwxzERiU5nyKHcUcI9MTzUVp6I2J9U2dfdfIPUaqnZ1RWISs1yU6hfYMnwi1i4NOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA1PR04MB11505.eurprd04.prod.outlook.com (2603:10a6:102:4e3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 13:17:52 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 13:17:52 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 28 Nov 2025 21:16:33 +0800
Subject: [PATCH v1 1/4] ehci-mx6: Add powerup_fixup implementation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-usb2-v1-1-25ec5ac127ff@nxp.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
In-Reply-To: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA1PR04MB11505:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a5e8f6-7f7a-465d-b88d-08de2e8088d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3RsK1pHKzZRSnJ5TGZ4Y0pCdTY3KzVUTjJ1bVFCbHk3d2gxNVhKZWFvaFlU?=
 =?utf-8?B?eWgybjhOazBFb0NuaWNvamRkK25uR0F2YXRkYm5vV2RiQkhDaitydm11UlhP?=
 =?utf-8?B?ZWNCeFA2czJKM3NmSlhpYU1GcE1pY0E3cFJHbXdqK1pnMDRUUEFOM2lwRE51?=
 =?utf-8?B?U3hMSnlZbWFyMmsyRlZTQnpUTTNpOXJUTjFjcDBGM0hscGJNcERMZ242TXZB?=
 =?utf-8?B?VFVnQUt0ZEZxL1dYMnBRKzNpN0NGYVlWc0trZ3NkeUdiNWErU0ozQUU4VHFT?=
 =?utf-8?B?aUhzNDFYY1V6em5ZSittOFhnUkJ3c21UZjBVS293WllRMnFPTTh3THZMWGgz?=
 =?utf-8?B?TTNHeElQY3Fhc1VkS2t5ZDFyeTF4dzNDMnM3dkpvMTBNTVBKcGdtdGwxTDA4?=
 =?utf-8?B?NEhrQ0x0ZGdmRTFGaytUNGFYbTdFSEF2L2xabTFXR09VeU9xR1U2bUJFdjN4?=
 =?utf-8?B?UTNCVnRaSzd1Um5DSDlUM280d296V1BGSEFPblVIMFRUTzc2RWFLSTdJZTdO?=
 =?utf-8?B?ZXBUMGdrVVZFTklkM21rbUxWeFpFdDJ1eWNPWXpoQkwvb2NSTjFOeUMvaDhs?=
 =?utf-8?B?OXVjTitLL2VIOE0zY0tMc0FHUURSRzdLR1k1NmlnNmg5dkpxeDZ4MCtGeHJD?=
 =?utf-8?B?OEt5c0dUZlo4M1dVaUtpOExjaFVCMk9WaThZVm5yTWFSNENaUk5kVVNDS3Yv?=
 =?utf-8?B?cVdieDFwdU9aalV4YUNtNDF5dGdWeE5oYllxRWNzRDRpY2REUmtUeDNMeGts?=
 =?utf-8?B?RlZQTkpycmNVMFVrdEJOandDbmNJUHlUWGNJRkFYZERBd2gvT3Y0VE1uaHJk?=
 =?utf-8?B?dWV0RjhVZ0dUT3UyRHpjQ25kQklPVmVjMjlsYjNWUXRLRmFXWmJ1cFdPSjBB?=
 =?utf-8?B?K0tOQzZ1SUI4M0FnOFNQMTE0cU9STGt2bXd4bzBESU8rcVpkbTNhVVU3aTJ5?=
 =?utf-8?B?NTlRZEd0cGwzRW16MmFFQUFZK0VCYUV5Ly9KemJlNVBFN2V6QXJKTk13b2Vh?=
 =?utf-8?B?ZDhCWnh0RFRGSlB6Q1pzckxRaXowV0owSjZ3VE9CV1ZhMU9IbFJSZjcvbjV3?=
 =?utf-8?B?T2lYNEluTkIxdDBsaTRJRDRDR2ZjOGxlamRGcXN2S1R0czk3dG8yVUFBZzZC?=
 =?utf-8?B?Vms3N1QzUXNGdnZvK1VnSGJGeGFhSVk3bXA2eHlYc1BEMXphUlBpejR5ZWRr?=
 =?utf-8?B?MkNvSDFVVVoycFk2VTZZMnFqalZRR3pvVmloUDk2c2dNUmUwcWpBSlkrcG1L?=
 =?utf-8?B?WEdwV2U5THg5MmRZM1RtMWxleFcyazd1L0x0MWZiZlI1bkdOT011U0VNczl2?=
 =?utf-8?B?RkNUdXAwY2ZiTzNBQnFWQm5HN1kwaTQ5ZmRqNndxR3FRWGlpZUU0anI0S29S?=
 =?utf-8?B?QlQ0WnRkRG1jMTAySjQ0NTZIR3hMODlhY0RRVE9OZmIzU0d1RFgzNFBRdVdX?=
 =?utf-8?B?cnlaMmowcFpiOWt5K2hKWS8yT3V3VGVXbVVIQXZvbUwvcjErdUs3OWRkYjJ1?=
 =?utf-8?B?eG1UVE9qRm9sNlBGSnJkWVRNMnA0N3N6R3N1RGlYakhXbzA0c25mcHptbHhp?=
 =?utf-8?B?NGwrTVQwWnFIRE5GN3BTZGdRNHlweURnc3BMdE54Z0JUZGZPVis2VGtuSFpL?=
 =?utf-8?B?eDJkbWFvZ0NUcWkxNDZUWHJGWEcrQ2h2cC9iMjRHZWFVRGxDbnBDRGN4eVhT?=
 =?utf-8?B?c2lpb1Q2ejNGV09YZjRsMjFkU25QVGtqSm01eU9qZVNzMDlpL0JHckhWUCtS?=
 =?utf-8?B?WGNRS080Y2RlcEdvVlVhSTJMcHFVNjhVWmNwR0ViZzluUDdmMHY4ZXJGY0tL?=
 =?utf-8?B?U2xHamtZd001K25kS0c3RldPVlkyVGxoR2pPYVlUaUxQMCtaeVhHNUNGZHZO?=
 =?utf-8?B?d0hrNkFrcUtPa2ZJS2xYZHRkeHJnaG9wQmFCTnVuLzREVGFTMWR6L20xS2Rq?=
 =?utf-8?B?a2UwUXMvWC9ycHdYdDZQN3hjME1zd2JwZ1c5bTd3MnZjeFlNVkw2WVhja1FD?=
 =?utf-8?B?T0pkMFcyTkRBZTZQcHg0a1dkd3A0dEo0cWYzbUpDMEI3aEo3SEdJUkUrNTN6?=
 =?utf-8?Q?cEIsPq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmdta2RqV1h5VlhaVlNzK1RRWEF0WlIzbVBQbVVwMlFiWWRWOTNlWkpLZTdp?=
 =?utf-8?B?MnhzcnNKVi9qSmdnV2lqM2g4U01rTXlVWUVOWUVoNTBCYVVlYS9CQURrUE5B?=
 =?utf-8?B?SjhFcEszQm9qZ1JUdmxoaTU0NlMxbi9obWNMOThEOWlUTGI3amRjMExubGY0?=
 =?utf-8?B?MnFSN0xKaU85aTlZbHpyZGxGdmlwQVg0RTVWcWQ1UndmbVdqdkE4QmszRGlV?=
 =?utf-8?B?d2JEb01ZL3RKUnhLV0s3UUhPWUt5RG5HeGlrSjJiYjZSV2NhTkRJTkQzTFI2?=
 =?utf-8?B?b2tYZTh0ckRCK3pvUmVGSytyOFJkTkJHMzNYbWkvSEN4SzJwNU80cEIvT1ZX?=
 =?utf-8?B?Smg2T21YNmxsdXBzcmIwd3p6bzFzQmRCTEN1UkVHbDNlcDBqSHd4dVc5UWxD?=
 =?utf-8?B?Qmd4YTRGajZPVkhXL1loRnlmTWdlTzk4TGszckpIc1VXWFBTeUhDRW1CY3Fp?=
 =?utf-8?B?SnI3MHJiUDdEVE1SY0JyRDErQUZjT3dVczlqRHdhNmRWWXp1aFhacVBEenh0?=
 =?utf-8?B?dE9LV29YR0JPVytkY3Zkbit6NzFDNzJKZVdhNDZvZWpnVEVrY1U1VkZ4T0w4?=
 =?utf-8?B?RFl2QkRoMDJNVDF0N3hFWXR3bjBwSnMwZFdVN3JNNG1TUU5GNU9qRm9MWStF?=
 =?utf-8?B?SU9sUlI4K3F0cGVSSDFET0hQN1d3UXBGdG81YURXNFFYMVpYeGZYSmRnMDMz?=
 =?utf-8?B?c3hzdzJMUzhzWnRkQmRTOUlpNHNmVXhUcUthWnVoRkcvVlVmSVBuVk5xNDBj?=
 =?utf-8?B?elpiOWFRdjJYMjVpYmMzZHNWRURjZnprejVvM0ZMdEpNU2pDY3ZjVG81UXZn?=
 =?utf-8?B?eUdxU0xScFlZOCtGY2MzOG5HSVZQT2FKdk4rdnlvMk16dWhSY0Q1ZUMzOEN0?=
 =?utf-8?B?YkxzOW9ONWl4Kzk0aldtUjB1SWVNaHJKbVl4MUlKZnh0Zk5hZnRwZUcxUHRt?=
 =?utf-8?B?emt0aFlNUWtwS2w3NTI3Sm9iUkdEMm9XeWJnTGhYNHRHdmFVS0tJckpoeWxL?=
 =?utf-8?B?aWdqcGplZDJ1VHNNNFhvdWlDNnIzTUV1TDhiK1ZsZGlaTVRZejVRcUFiUExB?=
 =?utf-8?B?NHlESGJCTVdBNEs2cHY1SW11WnZZN3BlTnlhUGcwendGOWp2bXE5SldUUGNm?=
 =?utf-8?B?K0lqeUVFMzBibTBkVVBjYzhiOFF1UkdobEhBbW1UMVY4TUdxS1l3bTA3b3Bh?=
 =?utf-8?B?VTFUOXB5WTR2em0rS0RGOEhYUEx2aUFad0YrWXorQWhDMTlYakFXdW84ZWYw?=
 =?utf-8?B?Q3lNZzYzT1M1NGQyN0dmU095RHhMeGdiNWFsWGlMY0JuQk0yOTlGNVM1UStX?=
 =?utf-8?B?WnNoV1plcjJWRkVLS2YxZjRBMHhHK01Bb2Qzb0FveC8zYmJaZE94NXVObFF5?=
 =?utf-8?B?WjVRaUl3czRBQnIwZmRENWhkaVN0bjNPYmhBbUxRRDhFbnFkNldkMGZhb0dX?=
 =?utf-8?B?NEV6dHIyTmxuNkY3dkpTeld2OUQxUmhCa1hjYTMxZy9pZW92S0tsWUhzaHVq?=
 =?utf-8?B?bXE3R3UxT0pic2FLaDdFTnNQMm9rTUVOcWp6eEw0dlNxOVQ5ck1ScG45c3NX?=
 =?utf-8?B?R0pzcEF6SjlNMjFjWnZvSzVjL0s1ZFhUUkdkMThmUW1IOTlCd0xwajhkQk9E?=
 =?utf-8?B?dnlNQ3RHdmVnR29BbURzdFNadjlsTVFtckRLaUZKdHVPRS9ISnVCYU1xSGVY?=
 =?utf-8?B?NUZhVC9JUFEwUktFQVlja3lTUTJiZS9XWUhLRzZUaTFJUEdydzJQZzhFRUxC?=
 =?utf-8?B?N2NnZ1dMOVpNQVdCZ0xqUlE2UzQwNXdwTFhWL1A4VlN1enp1N3YvVXdlM3Bh?=
 =?utf-8?B?TWpUWWN4WjYzMGNTanBoYm8zLzBnQXZVYS9LVWtrajBNaEY2TTRhMXVRM0E3?=
 =?utf-8?B?bW02VThrZER0eWZhMFBRQ0FXNWJ5c05aSUJ0dXJHQjRmZVpsNmJhT0RFTUNy?=
 =?utf-8?B?ajd2YlVxUHNPR1h1REZnMGFOeFlKbjJlSXhyTUZXVEFtNFF4SEZxUklsS1hK?=
 =?utf-8?B?ckI1L1plZ1lOZE1xOUhnRm9haXo1b1A5VE5DVksrb3dqTkY5UW9nWVJ3UlA4?=
 =?utf-8?B?QzZHTmpieTh5OXYwcENSQ3dkS0pkZkVxTnBWcEV0dVRxcS83SUhxZEwyN2k3?=
 =?utf-8?Q?d50HM54rDAs6buqGBTBLmHP24?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a5e8f6-7f7a-465d-b88d-08de2e8088d3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 13:17:52.1258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hrtal2OLzXtDlwIrYrLujMiK36exJ5DhcIWBBfDt8QcMetMtz2SLopHtMSf/ftZybgGZyGwkeaBoI+4QU1PQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11505
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

When doing port reset, the PR bit of PORTSC1 will be automatically
cleared by our IP, but standard EHCI needs explicit clear by software.
The EHCI-HCD driver follow the EHCI specification, so after 50ms wait,
it clear the PR bit by writting to the PORTSC1 register with value
loaded before setting PR.

This sequence is ok for our IP when the delay time is exact. But when
the timer is slower, some bits like PE, PSPD have been set by controller
automatically after the PR is automatically cleared. So the writing to
the PORTSC1 will overwrite these bits set by controller. And eventually
the driver gets wrong status.

We implement the powerup_fixup operation which delays 50ms and will
check the PR until it is cleared by controller. And will update the reg
value which is written to PORTSC register by EHCI-HCD driver. This is
much safer than depending on the delay time to be accurate and aligining
with controller's behaiver.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/ehci-mx6.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 25907f22612..0b3f1b69657 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -265,6 +265,25 @@ int usb_phy_mode(int port)
 }
 #endif
 
+static void ehci_mx6_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
+				   uint32_t *reg)
+{
+	u32 result;
+	int usec = 2000;
+
+	mdelay(50);
+
+	do {
+		result = ehci_readl(status_reg);
+		udelay(5);
+		if (!(result & EHCI_PS_PR))
+			break;
+		usec--;
+	} while (usec > 0);
+
+	*reg = ehci_readl(status_reg);
+}
+
 #if !defined(CONFIG_PHY)
 /* Should be done in the MXS PHY driver */
 static void usb_oc_config(struct usbnc_regs *usbnc, int index)
@@ -331,6 +350,10 @@ int __weak board_ehci_power(int port, int on)
 	return 0;
 }
 
+static const struct ehci_ops mx6_ehci_ops = {
+	.powerup_fixup	= ehci_mx6_powerup_fixup,
+};
+
 int ehci_hcd_init(int index, enum usb_init_type init,
 		struct ehci_hccr **hccr, struct ehci_hcor **hcor)
 {
@@ -394,6 +417,8 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 	}
 #endif
 
+	ehci_set_controller_priv(index, NULL, &mx6_ehci_ops);
+
 	type = board_usb_phy_mode(index);
 
 	if (hccr && hcor) {
@@ -502,7 +527,8 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 }
 
 static const struct ehci_ops mx6_ehci_ops = {
-	.init_after_reset = mx6_init_after_reset
+	.powerup_fixup		= ehci_mx6_powerup_fixup,
+	.init_after_reset	= mx6_init_after_reset,
 };
 
 static int ehci_usb_phy_mode(struct udevice *dev)

-- 
2.43.0

