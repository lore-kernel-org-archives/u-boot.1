Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8426ACCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100E283A3D;
	Tue, 28 Oct 2025 09:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FlJ1Ad7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCF083968; Tue, 28 Oct 2025 03:48:39 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4627838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axRgCciqsc8scOgGx+KzS4jRm/2JD5FpkdluLcvZpB4FnIEuoIPKD2TlQRCwJbXdOgDFqlr8lSF8Al0ttRdOYiDIpMBl6hbQdfN+8BQMNV8oaYvvl9CMObZxleNQOpPXTaT05j/Hjsg222Bow7xHuO9h4qSqqXvMVYPRGdVmkUvnIeGG35mnTDRfBm2wRAJJQSfJQDap/jjMN0wlLIiSDlxEzESnXT+G0HAjkVMBWrIGAj6+PYqnTtuG6K2al7NI7L1j1jAOyEdfx1u0Jz2z/Wc25JHnq+Z42hlXIUD+XuwJ/VfPiv9+nM5M6fPOEnQvxLiAKODnqnCtnsjyI4uz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=l2iQLcnlkXaZuh04s2IoFFrjbM3B+sKm+xjyFSsWxBR5bgrHU+MnxiEKkau8d1EalpgXrQY66SWDRtTB2dC9IPQ8uap/nvinmyVDDDHBWCTR8OkLpZzEPbG1umSMqYE6HKRV/F+cVc1fhxyS41r5mU+539Ur4DjTCzmuT7o2l5dNtjLTDJT0JzPCRGERmKThoN+7nZNHWjC2quEx5BYIddn3bXbP1t7MgKU4Gwpc3bibmy6Hv8OXigWDeT/8WgnNRJAWyBT/O68W10fltw9f9LQveZ2zph1dBPTEORPBQDFGykvbnLBTiEXPihOM55QnNw7dZ+4EFn795sGvJ7Wa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOumPe5SjZrWxQCoNkSz1g5nlikV5njZ/DcTw7c36pQ=;
 b=FlJ1Ad7vWUc/1J+aIeZB1ShPj8DYPWYqocs+ciMMmbTQ/pfFdjdu/6TRgCTjiEuTrmWJ6MEVkUs4zy1b65mH2hgEmSJlLnY3gidAOkW5ExrByr+kJtyQNzMN97PbSTFDhELJHa2MkxLuxrmqHcUMqd2jcGSBerC7Op3WqdYSM+nd+XU3gFTrMnkmibl7baJ+dP8cNZpcTdUgpmdtRYNNhGmm5YFdEmORk5kj1PcjbM6p908rWNpJRaDwHTg/z6UHF3AXaN6vpxskar4JGVPfXc8gR53gmXAzaAIWBl0bRRRfx2INHpXpbWJUi3ktHTLdi9QGuuxFkOOC3xsdRc2oNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:48:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:48:36 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:30 +0800
Subject: [PATCH v4 09/10] net: fsl_enetc_mdio: Add support for phy-supply
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-9-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5c67a1-9ae6-4ad1-3850-08de15cc7dc3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnFHMkpxWWZ4YXBrWGdQak1ISUJVZTAyc0pabzJSKy9mYnovZ0gvRTdXbnRa?=
 =?utf-8?B?RkR4QlpqUnMyMVZJanFUWGtvS0MrazBFSEMwSDBYSlVZVi9vS2gzOFYzNVJY?=
 =?utf-8?B?VVNYZmluMlN5WTJjck1PZDRaVDJTOXVJT1JFODdoYVlSUHlVcldMRmEyVWxV?=
 =?utf-8?B?YUxLNGE3aHdlZHJva2EzUCs1NmtLQmpjd3FFajljQWsvQkJiUVdQdnUra0N2?=
 =?utf-8?B?RERXM0hLRHN0eVk1MGh3THVmcjVmemdQc2dDenRRU0Vja2lPdSt1NWh4YzZO?=
 =?utf-8?B?NTVBdjcvb2lDeGY5OUF6a0NDa2FTbk1sbGNnK1p0ZTRRNkVIdkJIMC8zcmVB?=
 =?utf-8?B?L24vVERYY0c0QlcyQ3JPUEVQdTNib0FwMzViQndPY2pBTnNkdmRvcU1lbHpZ?=
 =?utf-8?B?dFpmZmtFR1Q5QW16MFdSampYR1FxZ0RHYkxsbmpnbm0wMkk0am1RUjNmWVFU?=
 =?utf-8?B?UjkwSjJ1QkVQaTVhaGxnTVhQVkJ0NGVSN2tucHJLdzFxQjFMc2NOMDhPNXhr?=
 =?utf-8?B?UGVYbjZEcEN3UXRmSTZsSUNuM1FZc3Q4dUhuRmdNTzRtdjJZblZzMmxNVVY2?=
 =?utf-8?B?NXdyU05uNkQ4cGxVRmF2UkJGUTEzS0N1NUNweklJWEtiSEdtNGovaDlFZnVr?=
 =?utf-8?B?Y0JxRXNiNWJ4czZVMElwaTNaWjZQQ0RzT0FFa2hjUE1objZQeTd3eFByZ3l3?=
 =?utf-8?B?VFl6TDJBTC9CbUhpcGg4Ni8wdXY1UEtVdFNtMSszdkEyUFlwaDhCeE1mTm5Y?=
 =?utf-8?B?aFA4T0s2eGpUMWY1dnhqeUIwaThMZU45L2NVVTZTa0tuTi8ybzc2VG8zNU5a?=
 =?utf-8?B?dGpraXh1RWdBenBic1dsNnUyc3NrRTRVc0xoMzk2eXVYWVdTQXIwcy9UNWZp?=
 =?utf-8?B?REE1b0V4WWRvaFlzY2xRYUVrbFE3VFUvcnYzSHZ2a0l3MHhCeExUOUc3VkRa?=
 =?utf-8?B?NUQwUmtNRUNYVGsrN2FCRndUYmJ3RHYzTEovdmpJMkd2aEh0SXNWVHBDWHJY?=
 =?utf-8?B?bzBqTkJiOUhtdjR4MFYyTXowNkxjdE0xRmRYbmkwazhFNkFLcW52MGVvVExk?=
 =?utf-8?B?VDcxNDZwbUNxTzFwbjdPZWJsQ0xKU2hNVWJRWWptZjU5czF0RWZSN1F0dGha?=
 =?utf-8?B?QngwU1dPUWQ3U1ViWDYyNmlaSThoWlN0Mm44Q1UrT2Y0NzdsaCt5dW5jNWhT?=
 =?utf-8?B?MEEwY21tNEFWbnBIMnJkUm1KamI4Ty9nZjB6Y21IRUVYUUZLbmtxQWVPdm1C?=
 =?utf-8?B?MmhDb3gxNmRiMTRNQjQ1dVhDbC9DRUJzL0V3Ym9JL3ZZZmM5cGc4STB3OGx2?=
 =?utf-8?B?dzFycmo2ZUwzUGFZalpJRjVPcTJvL01zYmE3eWpxUkd4azZhd3hRQmY3VFNx?=
 =?utf-8?B?WkpqUzdLMXM3ZTZxVm95cXltYlFkcXpPVnJkbms0WXljMWxuZy9HTkhhV25w?=
 =?utf-8?B?d1FFMUJhNm9RWU5BaS93a3NsemIvcG9wU0xOMkZyOHd0QXR3VC9IMUVHNjEw?=
 =?utf-8?B?NENlaHJwR05wYThZY3lMS0NaRHN0OFhtRzdGL2diWjh3Mis3T2xlbHRjNFpH?=
 =?utf-8?B?b2tRNHlobCsyZ1dMMzZMNzlqam9NU28yVzk4UnN6dTdNK0hLcVJhaU05RnB6?=
 =?utf-8?B?TmExa2Y2N2tPVmN3MnpRaVZ6bjVtSDRKOU1aNFNrYWZBOXpNSGtlcHRCQ25p?=
 =?utf-8?B?M3IzRXNSUTNMTFR6MTg0NHdoa1gvNG9TTW1wRlY5VnJ3cGJsQ2tNSlhDZG9u?=
 =?utf-8?B?Y3E1aUhCZWEwTk5GTGgwTnduVnAveEQvZ3czRDhjdVFlWGJmaTNLeE1Fbm5R?=
 =?utf-8?B?LzlKYmtNM0VMN3UvanY4VFNsQWVmdnZBTjdXMWdKSy9Xb1h5R2pmbjRHeXVW?=
 =?utf-8?B?bUd1Y0Y4cVNtZjcyT05DTG5Yeml2eU1MN1k4YWNQMWFyeDBFWEUyNy80Z0cv?=
 =?utf-8?B?TkFLeGNTVGVnZlhzL1VNaXVaTkQrSHhYREpGdVN1S0FVcG1vZnc1ZG9WREU3?=
 =?utf-8?B?SlBIbFhwTXY0d1cyR0ZMd0NHMWsrdFNUSkVXcUNwSVNOSDZyM0w4T2VTRS9h?=
 =?utf-8?Q?jFdkKE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NOM0dteDkyMlZ1K2tDVFV3TGwwRHVMQWVQdFhIMUROVXJVR3doeE9uM0s2?=
 =?utf-8?B?cmFLYWFHcExrNk1VdXhWeWJzZVBXNi9CMmIybjNFUVoxaXhDbmwzZVRxMDR3?=
 =?utf-8?B?YjZ4d2lzL1RvaTNyUDAvWmJiRHBVWGJwWXZIb3RENDd6WmRxUXh4ZmJicys1?=
 =?utf-8?B?RUVzWHlzQ3FEeXhjbFloUi9wd3ptSDZ0S2diWFRBK1lpTGFjZy96ZjFJVWhK?=
 =?utf-8?B?S1hyS2VEWGRhZlN5bkw3WUQvN2xRNE9SVVA1Nzl5VEJXL3EvTlNHZGpYdGZE?=
 =?utf-8?B?aU1UempvbGdEV2lwYmE0aVJHZHJDYit3a0tjblBVaTdZQ0dnRCt5a1lTVFFC?=
 =?utf-8?B?QlpDRmdacjRVVTFTK0NzWlhLRXM3amNTM3E1dGZFMGJ3bkdXcDNiQWNIODFO?=
 =?utf-8?B?UC9ld0JTNTZiNUUvYyt1bmJPdSt2UjlXdnFVeVMyOEp2M1ZQdDhTaFZUMDBN?=
 =?utf-8?B?M0N3TkJuMTVXNEhsZ0I5ZDVlczRzd2wrNHI5WFNoRFRkUXQ3R2l5VmoxR2hY?=
 =?utf-8?B?UlU1alpyckg0TG5za1NBYXJabFVYMWc5UG10YTlVelRIZFVGN2FwenMxK3RB?=
 =?utf-8?B?TldmdXg5UzNETVNmWG4vc00rSWNaWHRkcXBlOVBnUjAzMXdVakJ1ZFpKVjNr?=
 =?utf-8?B?RXRHazBMcGJGWGV1YzFXdmxVNDdGdmlXY2RyOEhBTjhpeWtTRkZZejBaZDZT?=
 =?utf-8?B?R2V5cEM5eDByb1hSbVpSRERIZ0JvRm45UkVjQzhUTzRHdDNMUEoyQWNjRWhu?=
 =?utf-8?B?YkhOM3Q5ZjlKb3FtWnluOEtJSXNpSTY1ZitDdWI3bWFHVEhqMXhMSy9mbVZv?=
 =?utf-8?B?VG9vZlZFTjNha3EvdHV0cmJtSCtmMXV3d2lxM1R5UHcwZ1psRSt4SHhheEc1?=
 =?utf-8?B?bGtxekwvRGRKTHV0aDR4SzlEVUVDQVNLYjF3U0xVWWJ6ODgwQVU3UFJDc1JC?=
 =?utf-8?B?RC9KSWdHSE5kSkpRN3hpU2JvZW1nckNjKzQ2NWlXQzZGanVPQksyVm82TWpY?=
 =?utf-8?B?U1VPRkFEY1QrV1MvMlhtRGNGT2JsNlBXVXpaRDA0NDNMZHh2aG9LSkFjZVIr?=
 =?utf-8?B?NEltWitDOEFxQ0RWWGxlS3prYTNNQXl1T2c4bTZ2dUVkOU5OVmpOZEdpVVA4?=
 =?utf-8?B?NnpNeU1FSWpxSm5HRkM0Yk9zRC9wRHpaZU9uTUxSWkx6K0tKWWNZSUxPd3cr?=
 =?utf-8?B?V3dqbENpbk83WDNvVnRsbXhHSUd1L3RWOGhxcS8vOUlNaXEybnB2QkVVYTFy?=
 =?utf-8?B?dURKUjVaUmhsdHJxaW5WS2tDTlhmMWExSVR5MlpqRitwZDFIVHlwTjRKVWxp?=
 =?utf-8?B?VGFMTHRzVktrYTlSMlUvTThTcmhkV1pKeDZsNGdoWFF4Z2RQTGkrbk5Ienhh?=
 =?utf-8?B?ZG9jSlQ3M2lqR2h0RmwxbUwvckQzQ3ZPc05wVTBDWmh2SFk1UVJQU3pZaG56?=
 =?utf-8?B?TXduUzNYZXpZWFQrQ0NmQVhBc3hjYjVQY0krM0NacElCS0w4OTZWMWNiMEtM?=
 =?utf-8?B?NFJnTFc1WTF4cC9RanFIaVIwQnpKdTQzWlk5MHdTUGI3SnJBQW5vRW0wS29F?=
 =?utf-8?B?Zm5SRlZXU0ZmVFJvRG96dGZyV2lVU044ditRcTk2amxHeHRCRlRTQVlRdWpE?=
 =?utf-8?B?enNhS3lMUHZIYUpCYVV5UnNLazZUUTNuM25tNFduMFBSTDZJUkU3aWZLLy9Z?=
 =?utf-8?B?eEYyTG0wa3JQK1ZnNXcrME9makFROWlkV0ZyVXhrMzVDMkZPOEFKcVlBcjRD?=
 =?utf-8?B?bHF6U2k5N1hxdlBuU1pYV1p5TWx5VFhEaDA5aWJUaU80cDE4b2xUTnp4alBp?=
 =?utf-8?B?NU1pU3hWc2ovUE15KzdrMHBNWGpLM3cwRlJOTzhPQlovcG5EYkNPYkxMcHY1?=
 =?utf-8?B?UEJTSlVScTNUTWVubHdNeXlyOHVicStycURkOVlUTis4bWlxZEc2N1BnZ1dl?=
 =?utf-8?B?clc0ODhZd0RKY2JhdTJFNGZBSlFWeGRmZE85MHJzd0FVdXpIWnY1Wkc0R01P?=
 =?utf-8?B?bCtMb1ZZZFJjYzBNMGxhcUJ2cm1ZMi9TOXFkQm5iWUlVRzhFNXNaY2tiMXlC?=
 =?utf-8?B?WWdPeEsycnVGU25GTUxHaHJLNFJQcys4aW4wMWl0UHJhRTZ2MlNtQjd6eU1R?=
 =?utf-8?Q?rjfXExgbRVDMWHm4XTotWYo3J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5c67a1-9ae6-4ad1-3850-08de15cc7dc3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:48:36.2683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS3JLG3fI9lC/woMiFZzYizcpviHTX+Z6ISCh77ObdsHiDkvl5f/8oLRsrvw0v7IRO0VFIRnVsWh9/Aa+Hd0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

Add support for the optional 'phy-supply' property in the ENETC MDIO
driver. This allows the driver to enable and manage the PHY's power
supply via the regulator framework when specified in device tree.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_mdio.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/fsl_enetc_mdio.c b/drivers/net/fsl_enetc_mdio.c
index c1d491f2c5a..3d76d92a62a 100644
--- a/drivers/net/fsl_enetc_mdio.c
+++ b/drivers/net/fsl_enetc_mdio.c
@@ -11,6 +11,8 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <miiphy.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
 
 #include "fsl_enetc.h"
 
@@ -135,6 +137,8 @@ static int enetc_mdio_probe(struct udevice *dev)
 	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
 	struct enetc_mdio_priv *priv = dev_get_priv(dev);
 	u16 cmd = PCI_COMMAND_MEMORY;
+	int ret;
+	struct udevice *supply = NULL;
 
 	priv->regs_base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE, 0);
 	if (!priv->regs_base) {
@@ -144,6 +148,27 @@ static int enetc_mdio_probe(struct udevice *dev)
 
 	priv->regs_base += ENETC_MDIO_BASE;
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "phy-supply",
+						  &supply);
+		if (ret && ret != -ENOENT) {
+			printf("%s: device_get_supply_regulator failed: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		if (supply) {
+			regulator_set_enable(supply, false);
+			mdelay(100);
+
+			ret = regulator_set_enable_if_allowed(supply, true);
+			if (ret) {
+				printf("%s: Error enabling phy supply\n", dev->name);
+				return ret;
+			}
+		}
+	}
+
 	if (pplat->vendor == PCI_VENDOR_ID_PHILIPS)	/* i.MX95 */
 		cmd |= PCI_COMMAND_MASTER;
 

-- 
2.43.0

