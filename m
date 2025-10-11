Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1011FCCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7553A83AEF;
	Sat, 11 Oct 2025 20:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QJMsWmLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B71F583E11; Sat, 11 Oct 2025 11:14:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E162583C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu1djaPIAhb9mpoQSg/ABGZZtBE0cY8K743WurdBrMHgSkhetOHDNPEcjgNFyHHE0Ks5kk9skKUkDOkc4dVip9ZL6I8OvGF/2o+fiP824DNHdU7EM7bW/OosJZSgO3dX9jGZ2COA4iAN+F0EWK3a0IUMb98Zc9NVZdR7bYKC60aWUaHDU7+xgltbOrsPnok+pgtPciT0Zn56+8lN+vpXo2XTzEXbs8q3vwHnBgQ5ZIMYBUo21wnFWsK7uSJEaOMg+N9/zUjtPEYlRz2W93Zsm9ttC/A2iAiYbwKhWPDYnQumLBCDNxOpWIlmwrEpTNccrK6B6RGwVBPczm6SlKAh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=QlwQ4dU+RO4Dk4VbKk1sFOZdAU1MmkW38HVT4GiAyN1PCgznQekgfsh6/i/ZYv62omyKg1fLDmqDYAfq6JUBTUgMQh7S3cEHOi+juMhYgIXb/ReWUuQTgLrAXOy3kPufvWClOC/l95OWVpN2JFwcIfmEHc+JezBu8zAbDgqDJJsUhMqqBL0vxYPegMdT4f2D4zQvU24BPAs1Sy6sFACJStB/gQKeCkqSDsQIEqnDwhS9lv0o35j9lxFdskts7WdRykqEv5YXsXaSGMsjKDFlLe7xVVZAXoWIMnpcTTbbv7bmsdsNdOgyswJ7uzbGiIbpb3nowM3eBU4w6t2FDdOKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0KSxBUidr203IiKTsxOnvAjZAHKR7thk2KtnVZEWVM=;
 b=QJMsWmLw9Wg1XGVjrS8hk0dB4hUlJ8tjHGTnAK+JAUEIQsiFCRYHVA+78qRDwPJkdzk51LRoUohWHRELO1rJm+rICvjmPxcCP//FwvDOHDneo+cLRaRhPSE1edAx8IxavmSWC0VxN1FOMafxuC33bEzgaESWqWsPYy+XO3OW6T18n2amulZMDUHltGklM4zLN7oOQ9BT/gRoSbhwgwLdX1TqQiZm9z0x5aPobiEFfgmabPVvCdRfv4yC87g+6NxhzAji2cmWpd9jqcpblJGC1bYPZrZCuPgpBCxUYiYOVIUh9Iem5w8BMZvInUBmNjauPr9Hf52Fn3Xn6HGZDgHD5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:14:13 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:14:13 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:53 +0800
Subject: [PATCH v2 05/10] usb: f_sdp: Update SDP driver to support PQC
 container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-5-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 5422e845-1ece-4e62-f919-08de08a68b60
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0QxSm5PR2FqeFcyVXByOGFJVTZLQUMzeTlIY0xGcEhqNHdOdVVqbU5POUwx?=
 =?utf-8?B?T0l5TzVPS0JzZVVwS0Z0Y3VkYTFxYndGRnlRTUhqd3J4SDZ3VXdUN3lMTCs5?=
 =?utf-8?B?NFhpaExkV2gvR2lLekRwcWF5ekdZRG1EUlNIQTVac2FCaHJ3VSttWGc5MlJL?=
 =?utf-8?B?TjdDZDRSeGtlRmxOZlJmdFNSdXNWT1lVTFBSYS94Z0xLbjN6MklsYXFqQnJI?=
 =?utf-8?B?azZUVFhWVUhMOTc4OExTSFB2aXVZOUloRERqR0dZUXEwdzkzT2dQQmhRYlAr?=
 =?utf-8?B?QmQvVnVndkhCVk45K1phYzM0SzVrN2NyWVVLbndVK2pxcFdUUG9XcnFRcjBY?=
 =?utf-8?B?aXdiV05EV2RHTDBLVDhzUkx0VTVjdlB1OVRTZjVkU1JvZmNkdVRQRFZRMG5k?=
 =?utf-8?B?ZzgwN3BIdDgxd0VXSkk4OFd0SnhrY04rdnN0QXN6QUJtMmJ0eko2NUhQazhu?=
 =?utf-8?B?YnpINm1icFdtbFIyZFR1eXdqS1lTMVZxZFRPYVJaWERLVDA1SE9EQ3FnY2JD?=
 =?utf-8?B?V1NHbjNFLzVaSXJCTGRJR0RtVExGM3l3eFpsanFJRk5PRkk0WTlKTDExc1BK?=
 =?utf-8?B?bDEwS0hDeXc2d3VaNVBmck5Fa3cxWVZsL0E3TVFuRnE3QU9GNUVBNFBPVlo2?=
 =?utf-8?B?WFFXM3YwRjlhWUdTQ1B1YzNybENoQ1c5SXpqUXZzS3k0TXNUUDQ4SW9tZ1dj?=
 =?utf-8?B?dnZvaG0yYVgyZUc5Y0hPYzJibVkzM2hRMVVkem83UWtod3FLWG1BalNBelNC?=
 =?utf-8?B?dWNybiszTUdRaTl4T1VlVGVqdFhNUkhXcXR5cHRwcDFUOTVTRTBhT211bDc2?=
 =?utf-8?B?Q0hRbk1zVDRTMURmZlFXZjRXcTlMY2xwS0lDb3FaTzBnWHlaYzVNcVl5RWxH?=
 =?utf-8?B?Ni83M2FVVVN4M0VwdHpPbWIvNHlLeXdIWTNFSWFBWlhSbFFraHdCSHd3dHA3?=
 =?utf-8?B?ang3TW9Bek51V01RTTJQc0tmWWJyaWpCMU1rWDkycHYrQkgxN1p3L2JPS0pW?=
 =?utf-8?B?ZlQvLzZNWkRsZG0zTE5FbzY0QUc1L0E5Q1A0U2RqNXcyQlhtd1BockpSdFN6?=
 =?utf-8?B?ZWNrSnRYYVRWTDJqVlRhY1RSeG9GRDZOa1BVSEp5b0NUYU5mUzBCNWJuYkVC?=
 =?utf-8?B?Y2d3Slc5K0tWaU8yOURxejFEdVdwVHdpQUVVZ25Rbmo0VW5tVFJtM2pGcUww?=
 =?utf-8?B?eWRIUUFURUUyVitlRDF3dmFZMjhLQnZ3ZllKUkR0dDNXbHY5dkIyZWFPeHBa?=
 =?utf-8?B?U0gxZGx4MEg0QkcwWkl1d01ySFFEUTB4Ym84d09JU2F4NVFEcFUvK3JoOTJr?=
 =?utf-8?B?ZVJmYlczSHRoeC91Tk5tekV3ekV0R2ltdVU5bEdJUlJFcmt5Rkx4aFM4enEv?=
 =?utf-8?B?ZVBlazhGM0xQZDM5d2JjMFVnTStnc2JtSktiT2V6Qk1HSFZ4K3g4OHVFamdi?=
 =?utf-8?B?NlFCd3lzQWtQZCtaVnVsQ1hneStkdE9xYWgyZmQxY2cydmpleW1qelJha3VZ?=
 =?utf-8?B?YndENXVhTWhkclFRZ0toQk5oZzd2bmU2ellnVzN5ZWZRdHJmK3BESTRSY3Z6?=
 =?utf-8?B?ekd4RlRlZjZya2VpTURBU0NRYVphQ3QxUTFNMm9kc1RFYm40Z0taNGpsN1p2?=
 =?utf-8?B?UlhCa2MrYkJjZXZ3T0taNXBOdkdiYUJDbnlrbUh0NUZ0NVQyVkhUc05udTRm?=
 =?utf-8?B?dzZ2akJWRnlnQkpJdk9mVS9XV1hlZVVwM05yMms1b2ZOQkVOWVpLbjdWSUJx?=
 =?utf-8?B?ZFRHek1MOGRrSGE3aWxQTnRFNm1NSXVOb2UxbGpZV0txbTJNT2FvNDNLNnVm?=
 =?utf-8?B?ZW1lN2FJUzk0NTZPMklZd3NibjBlQXZ2c0pFRkM2eXkrRXJaaVZoVWtwNy9h?=
 =?utf-8?B?czRGQm96VXFyeTVrRzBTaDdvU1lYcGxqNVE4YXd4OWpjMnVYSnZqcFR4OThO?=
 =?utf-8?B?UHVKWFBNaW05V21KcW9vRFRHUlIyMUN6VDgvSkVacFdPK2p1TDE2WVEvcnVL?=
 =?utf-8?B?aGxETUd2Qlg5cG1BaGl6VFF4Mi9pbmk0VTdLNUVYZEpMUDBZYkVRNHpTTXEy?=
 =?utf-8?Q?hWO7Xo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3F1RVA5bGUvNFMramZ6QWdQdDR2ZEhaa2N6NERGeGhwUXl5d3A4UDBGTXk5?=
 =?utf-8?B?eUplVHlZSkVhcW9oQVpsS29rRGJkd2VsOWJmNDlMNDF4MXA2M0taNVRJVy80?=
 =?utf-8?B?TUloTTVicVJaWHhQYU1NTnp3UVRlbmtYZEtzd3ErMEZHNFJjY1lBcTNhM1R1?=
 =?utf-8?B?c2FyeURuVFdZcm9EY3RlMllidUp4YUMwODVqc2h5eStUdXZtbkNtMkJqblVl?=
 =?utf-8?B?L3JuTWlPMzlKUHNOTE8rd3hUVlo1b1dkM3BZUVJieVRVdCtLT09YeDg4dVlE?=
 =?utf-8?B?MVh2Sng1R0hjZ3hpa0lYYXJiSUtBVVJGNGVXaTB4cWd5SkZ2NHo5eElaMy9w?=
 =?utf-8?B?a1BpQVViaS9DNVdjUlg5TnBzWnpYZlZ1d2RoUU5YZ2EzMFU4MFc1dFYwTFdv?=
 =?utf-8?B?dlRoalBNN21GVHliYW1kdWM4YzUyVTA0VDN1bWlMWUZxalVMcEV6aVhGRjZE?=
 =?utf-8?B?bkZreW5ibmY1UmNteXAyTFlwcHQ2RDNOeHBsY3JRL1YxNi9iM1dhSUkvM2pk?=
 =?utf-8?B?cWhkSkxnQTFwVldudXNoTWx3M0ZwMHFWWHZPTWtZcG8zUkJkSTFubGVabjh3?=
 =?utf-8?B?Z2tJYWFEVHozK0N6T3o2YmtDajI1U0hoN3hBVUJqN1Y5U0UxREtlWnRKWUxV?=
 =?utf-8?B?VHBvWitxR1Nwam15djgwakZSanlGOVJNOTNiUnd5M0dPRGRvRkJpREZYT3p6?=
 =?utf-8?B?cEQ4Z1l0elJ1WjM1M1lidHdlZ2tsc1d1M2VtMjhkVjltekxSdlJsOWFyTGtt?=
 =?utf-8?B?TllVMTdQY2Q1aGxPWlRJS20vZGJaYnR0b0JOTjhsSFY1Rk1VOUgraEF5UEFI?=
 =?utf-8?B?VUI5STllREJZQ2dKRW50RUNGb01id0N6NTBpNDVUMU5Sa2FiditVcUMxUnRX?=
 =?utf-8?B?NWQxT3orQXY5N3B4KzhQSEloc1RaSDJ6aUlNZTUzNzB0SHpIbnNPazNIYTRQ?=
 =?utf-8?B?R2U1MzR0VUJjZXoxMG42VlI2bXp6MFRMSXhmdFlZdDViU3hHOE8zeEdLNXZY?=
 =?utf-8?B?L0pBS1hSbUpDRjlydWVkblY0cWdGMGxLVzRwZUJlblBxaktwVmsvU0RJOE9Q?=
 =?utf-8?B?TXRWSjlJYzhVNnJzelRHeTc5K3FZVTNNQVFZS1N2bmFkR1pVLzYrcUp4bk9R?=
 =?utf-8?B?WUtiMkwwTWRDWFlkcWNzR3ZHMG9CSkZPZlhpVEU4b3RwMmxMWWg1RlphdVp3?=
 =?utf-8?B?R1VjVHd6amkxZjEwYXAwZnkyM0l1YmN1T0Ntck5FS2pDL2orMG1VSHFIY3pK?=
 =?utf-8?B?TnlWd1Q2RFpVSHVxRVdVMkNjdWc1ZC9iU014YjQyQzk0ZlpHZ3dqUnY2YmNK?=
 =?utf-8?B?amJaYjVyMEFJcDdRRnN4SG52bUFrVFNWTzlBdXJFSkZoellQWnlBd20wVjFx?=
 =?utf-8?B?WGJPUkV2QWlOZnhoQ3pGTXlCZkN4TnI1ZFZjMnBoQjJ2QmJVa0lkcXA1c09j?=
 =?utf-8?B?MkpIR1NpYjhYUXlHN1d0RDEvcUdDQVQwdEpBOHdHNTF2SjlMVlpra2VycWww?=
 =?utf-8?B?YngxQTI0NFV5K2hmbDhLMTdQZmFPbU40WW5YQno0WHZicE1hcnpvQkZoU0pw?=
 =?utf-8?B?MFJub0ZEcTBxWXgwMUEvR1NBbm9PR281WjFhU3VuOVNDaW53OXk5M2tDWU9w?=
 =?utf-8?B?UXFQWk16UmVjaTB1djRXY1ZLZGdZR2VwUHdBVnpVWlBpR2VxOVNCMEhkekN1?=
 =?utf-8?B?blREdytCWTRFeFJlWW1BS1Q3cEhXajk5b1NtUVJoZ1d5eXcyaTZ6TWJ3S0hv?=
 =?utf-8?B?NDdiUythcGJ5QVRIVFl5eDFpK2E2R3lhTjYwTFJpemx0Y25uK3dMWjZ2bTMr?=
 =?utf-8?B?LzlwdkFvSVJVbkVXRDA3S2ZEREZpUTZZZkhxS2xwZXdSOGlBSlpNUm44Rnlh?=
 =?utf-8?B?TEVJSWthUGlndEtZV1RzaTRBbEIxalh5MmFTbW1iRFVnb2dMbHZRVEhTS0hk?=
 =?utf-8?B?NTQvQkFQZ1BuWG82eXZObTMyR0ZjZVlaczI1alhKTHRrTVZBOUhBSFdiUU1x?=
 =?utf-8?B?Q2JCMkpmcGloN0l3eFBxQ24yb0lHcUxDZTJWT1NNOXV4RjdsODhvaVd6MG9J?=
 =?utf-8?B?aG1LL1JuZElncFYxUTFGMldlamZKU2Qvc3duSlNRSjZZTXFlUnAzbHBabVNi?=
 =?utf-8?Q?wcQQ1MfKDrrYMJAyhdJp+SkxL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5422e845-1ece-4e62-f919-08de08a68b60
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:14:13.0492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+im9hHFJX67Wp/VfAWzBpLxKV0+Yj2m0N47Hc2xWLiEIxWB5zeX+5+C4XipDXxxkpkn3y96SE1dAKHe8DlRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

