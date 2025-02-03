Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA114C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 06:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB37801BE;
	Mon,  3 Feb 2025 07:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/jz5Tko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2022801DE; Mon,  3 Feb 2025 07:05:23 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84F480087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 07:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir3EJvXdE28L2j+AQ6A/mzYi2vAOBypVLbgB0+1x2bq3Mo9oSidDog/Xjid/BSF6YF3yii9JgG1bI0lVsnOnQkghfNsBzRwy6Pazf/uWp2B8vDX/MZiWlnPjRbkYRzWPrp5NWfGJ1ALOgg6kLUcwMm+yJh2oO9glPPW1DKsr0XdFTobC6+YyJhC+88/Caz8aykE4V090WuThpl/quSSy5w9aYDLvWj6PYOqm6gKPNELts2klPiV93BtLExt9nfvr6+EZRkrozN6cDAqDi6t4UVCGKL8pl1GY5SOgKeWDi/gbCQShw42dHKz2O0VstypUwbdyhmmd2MnpnIwE4nno/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kylJuipIr5lQRJtow9Joi3fMY6VejL15nquBkN782w=;
 b=fe2C40pYdQKEftrHi2Dvo85dCNFz7idhnEaqfebJg2s/dlL0k4g0chai3f47L82gSvVEJWvMATmgoyAGvlAJ2+yuCycBguXMNRopSIzbbr5fPKf219qjD3A22Du7LneGE20FZY5nsP63ePTWl2i9jRzRBlZ+QHP3erQ6GYgja7ymFcBWNWFAyZuE+Xur6JZQzWiMnVQXm2NgGglNynjFKlqq4kupcYgxbtxtQIHyN0/Ue+maZsFcoq2WHCYHcLLZFVTEvW+grE32KDr4UCyB+IgO5R4b1sYKwor2jxk4U8bohZUaLULABrjAmQ9s/hUrLsvln/o7/IwhrL/OaqFa5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kylJuipIr5lQRJtow9Joi3fMY6VejL15nquBkN782w=;
 b=A/jz5TkonP2kQMSeRkL15fLvit530ao2CncFBMC0iIXZE7+O0v6QQWSZ115shlgWSO+rEyEONMdWvVHx1Sswi2mHXZH+FBqiAbxbiLUjB+rlbs5LQj1RZF1FIgJMl3qpH1TjlMLAq/TFHILcDV6HWX2tjE2Jn/dOASILJ3RoCeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 06:05:15 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 06:05:15 +0000
Message-ID: <7bc236dc-4cdb-4b43-a752-f9d6dcfa9498@amd.com>
Date: Mon, 3 Feb 2025 11:34:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] test/py: Shorten u_boot_console
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huang Jianan
 <jnhuang95@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Roger Knecht <rknecht@pm.me>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Harvey <tharvey@gateworks.com>, Weizhao Ouyang <o451686892@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, linux-erofs@lists.ozlabs.org
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-2-sjg@chromium.org>
 <20250125215055.GF60249@bill-the-cat>
 <CAFLszTjG0P0bdwziV4irtiU1JGNMwnoiLO9xhPxLQa9GZPVBtA@mail.gmail.com>
 <20250125225510.GJ60249@bill-the-cat>
 <CAFLszTj7no1azG+Us4toZA00O79sZpr3qgtoD69UpQFVNjAhoQ@mail.gmail.com>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <CAFLszTj7no1azG+Us4toZA00O79sZpr3qgtoD69UpQFVNjAhoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::16) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: f22ec493-f65b-4db4-732b-08dd4418ba2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akgvcnNsVzRxNGhDcndtbEZnWXdxWU0zYlFPdW5LY0ZlbFd1TG9GZHpRcHcr?=
 =?utf-8?B?YkpvbnJwbEtpRUpQcDNwTjRTMXNkWUtzQjFqVStmVTlMQ05zU2FzdTB6eGZo?=
 =?utf-8?B?ZklXcUJxZ3l3TjFaRUwwNmpJK2hmTWo4c1gyVnYvOFhkNjFVWjk1dWJ3eVBC?=
 =?utf-8?B?VjJmV3R3dCtRUjl3UTJPVzFxb2pZRVhtTkQwVzBHdmk5YnJ2WUZTVkxMaDZT?=
 =?utf-8?B?YTlBanlmdFh3QWxIRXBvU21sdy9hbEx1RkhibUkycXNYZEY3V1BPWU9hYmZM?=
 =?utf-8?B?RTViZTk0N0dsWnUvUUhjSHVjSUpObVlrNXdNbFBnNFQxczdUZy9oNDJZcU5X?=
 =?utf-8?B?aU1TbVdHV0pUTmxDVWlUYklnTG4wemZwTTlIOXRtWmp4RjNFQ2U1YWlpd01X?=
 =?utf-8?B?bHdLb055VmNUSElJVUp1bHJGTkpURjNTZVBwc0d2YWExMW81SnM0N2d3WmxM?=
 =?utf-8?B?QVBUcmUyWC9mTnMvS1l6WVpEcHd6WkhWeWlqOUYxMGM3N2g1Z2lyV2U1ZHNR?=
 =?utf-8?B?bkd3eENHRzNWVUZmMW5MYmNHVlFkbWhoWnlFYXY3aXJKWXRORHRZUVdGOGU2?=
 =?utf-8?B?VVBQYTVBRlFVS0dYUEhSVEg0V1k0RmtMaEMvZmpPSFJNZzlVUEMxRkRWVkYx?=
 =?utf-8?B?VjlGeERUU1VQNVRlaDdCWjNnbTBzSXd2L2tzb3ltQjRqSFArVS8yempoMzZH?=
 =?utf-8?B?UEpTb1RjWEFiQWZ1NGxzakwya3VwZStPYm52WDk4MmwvRzBtS2lpbUk1WDBN?=
 =?utf-8?B?OXJJSGcyZ0hIU29vZWdKU3FyMkRiNjdrTkpHWWJLMDBIME02Sy9hcWRBK3FX?=
 =?utf-8?B?OVY5OXpGM3RVckZuZlJMZGlzc2k0K0VUVmw5T01IN3pHMmVTM3hFV016cFBD?=
 =?utf-8?B?bjhQTWVrNVY0cklhM2Y4ejRtYVFWcWc0dGNWYXdSaC9PbDhLQm9nN1JjUjZL?=
 =?utf-8?B?L3pxbzlFamRaWGZuRlNyYkcrQUVuT1hpdFB3SExpMDZkSFY3N2NzRXJTN1E1?=
 =?utf-8?B?M3BIYkcveDNNOXVxaEhZQ3JjMnhZYW5JV3lRK3d5M3JHZ3hNRnR2WEZsKy9m?=
 =?utf-8?B?Y2hJMnBVUlc2Wm1iNi9jYnN5REtibHh2V3A4QnlyVk9IekxZVWNjQnVaV09F?=
 =?utf-8?B?R1RETWl4dlQ0VWRSZFdzd2NZcGVNRFdFUUI5RzFyWHNCVWgzL000VnlHR1BI?=
 =?utf-8?B?WWZ1Qlc1MWNxMWpwU0FRYkdKZkxVYU1ybklySCtudkgwaXNIWS9Cb1lacktM?=
 =?utf-8?B?YWNmNC8ydUlINWo0QWtNalZ2RWpLODJhZDJqOHZIV3NEcnNjeDd3R0Y3WWVp?=
 =?utf-8?B?ZkNyd1hZdURoS2dTSG1MR2MvbGpYWXE1aUFwUWk4MjB0OU1zNzZLZmJ6SllR?=
 =?utf-8?B?ZEppUEVWN2ZEWjdJVGlGbjgvZW4vTDNmYmxUMHM0aS9hVkhZMkFjOXRIdnBt?=
 =?utf-8?B?ODBjdndxWlUvamNnTGNDRnBIM2krQ1dnQi9jWVU1UlZoeFhtdGhoTk9hY2I5?=
 =?utf-8?B?RGsycFJsL1gzdTdqSVV0bUR2YW43VU9lZ0puR3RFemVWR2ZGQ3pCWnhkUGZp?=
 =?utf-8?B?d2YzVzlUaGRxWlcvUXhyRG9Nc3o4ZjAyZTJocXIzVTRzelZCRlM4ZG1ZSDZP?=
 =?utf-8?B?S3Fja0xSRUpML0MwK056aGRwNmRMV2k2K0Y2bHNjRkJNaVZKQ1NKNElLTjlh?=
 =?utf-8?B?a0Qyckc4MkdBbXY4Q21JN1F3R0EzMENISzJpYlBTUkkrU3greUpTaEdXQzRq?=
 =?utf-8?B?WlBLL2E2b05YQmZXUTdvTEw3UmRFazRFYzZpTTZsWldRU0V6SXVmajl0SUpw?=
 =?utf-8?B?U0s3MzVCWER3SnBHV3BSamhscXVCQzVldlRqd1dQeWlhVUxJWkRPOHAxakR3?=
 =?utf-8?Q?EtzrQconfNgrz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1U5c0dab0lOZjltNHJxa3JqclFObExadmhWdml4VFViSzduazNYM3Iyc05W?=
 =?utf-8?B?VUtjT0ZsL3dja1QyaldLRXY0OW5DMTZjTFZYTnQ3UEd5WDlna2hnRmhYdTh5?=
 =?utf-8?B?Mld3aHdPUms0VExrUW13dUFGZU5qN3ZNb1BBUGF4Z2RjSjRCY1YvTlhpQTVi?=
 =?utf-8?B?bUtESGdwcWQ0Y0VoNnFIN0JpRFEyaU53d253bTdOY0ludGgyNk1zb3c4RXIv?=
 =?utf-8?B?OTNnL2lqOFB1d1RGQy9ITjg0YmRXQ3FhMlJaVWRvR2RaeVpVYVU1T2pwRlE5?=
 =?utf-8?B?S1BVOUxQb2hZcFU5bWQwaVFYNkh1a21kbFFaaE1DNUdUblUvVkNvTzRXVmt2?=
 =?utf-8?B?WnVucW9KazJaSEhGaUJoV2ZWSEdMWGp0dnYvNUk1SVo1V0s1dVROMGd2aXMy?=
 =?utf-8?B?U0Exa1czYkV1TDNTdCtLOVZmSlcxVlJ0ejFVK3Zmd3B2MTRqcVBicHcrRlVJ?=
 =?utf-8?B?K0FXbFA2NVZqNjltU09WVFZXQnZjNkxnTkROY1BsZmtSNC9xVGJ3dEdBVVlY?=
 =?utf-8?B?OHNXcWRMbGo1cEVRT3hienVjT1FVUERZcDErbGJDd2RKQmV4M053ajZjS2Qx?=
 =?utf-8?B?VitnR0ZBOFo2VnZsQ2pVOFJSWnl0anMxYmptR2RPSWJjYkdQSEZYUDZyM0dB?=
 =?utf-8?B?VlVackswdmcwVy9BWmtUNlVKVXdGL256VUw0Sk9BVjJ4Q21mVFNibmNubzNH?=
 =?utf-8?B?RnNkdWhWZlNMdUwzN3RuS3B3VGRxNVdSdUN5KzFLZFNTcXNuVVFodDdSNHBt?=
 =?utf-8?B?aE5UUDBydUNVc2I0MDlnS3lqUjM4eWVOSnZxbkNmNWt1NENTUTRjVFdEMm8v?=
 =?utf-8?B?cGRtR1FMelArQmVxVlZHQ25Ua3lFWTJXdExmdnNMSXdieDk4ZG5mYzc1cWM1?=
 =?utf-8?B?VHR2aDVZcTZzbG5MY2JtQzdPTnhpQ3RXQlpOV1JObUZFNmp2UndzWThUd1Zy?=
 =?utf-8?B?Q2tUY2xLeFBSRWdoM1Y3ekZLU3BjczNoTHBLRlZEM3VWU29sS2lHYnBDMkpH?=
 =?utf-8?B?UW11eUUxeFNsc3pYNE0wZWxaWkxnZksyemVZR2N1WDQ1SzkzdnIwRTFtSU0z?=
 =?utf-8?B?ZFRIME1TUUJQYnBySVQ1M2xUM2hJSE4wL1lqSTZ4cWY3alY5aWhBb0tCYUVB?=
 =?utf-8?B?TVh0eVRtaUM4clZkZER1dFpLVUpnUHd6czFXS2RNSjY0MGRCYk1sSVhkK1RK?=
 =?utf-8?B?N1N3UHF0dmdhVUVRc2hlZlpYczE5d3lTejFxc3puOXZ0SFMwUmkvVG1DZmlr?=
 =?utf-8?B?c1V3dGo2ZldaV3dLdk1CWnplVjZYbGoveURUZVpSM0w4Vlk2aTgwN3hLWEtY?=
 =?utf-8?B?QzVZUDBqRG1qNW9GOWxqMVNjYUhSYkYyUlozSEhMZDhjbmNiZ2RzTDZ4SWxH?=
 =?utf-8?B?aWpwN0NuU2E5clNBU3daUE84STZKdHNnVlNmN1ZPa2RiUnFBTnhjbEJtRE5h?=
 =?utf-8?B?UTBMcUQ4UXNsUzhFTWN3UjhRTFh3Z0h6UG9LaHpjSXIxN3RheDZiTWtoSlM2?=
 =?utf-8?B?Q1hzQWk3aVVEVVdEWjRGdjUxL29US2FNbFkyVTZ3ejRhTURtbUt1QW5IRVNG?=
 =?utf-8?B?OWVSTzlZRmxjaC9NbWRnZ0FmZEc1T1FrN3hhM3VHT0FNa3BYK2pnL1lwREt1?=
 =?utf-8?B?VmRTekxmdlM2eklQeG5OL01sOVI0SUxERldNUnpEb0NMQnhna0JwaFFrWmJL?=
 =?utf-8?B?YndHb1BKWW84bW5MQzZ3ZThLVTh2dklqc3dwNzBJT1dFNGJ5WGxRcFdUeHZ1?=
 =?utf-8?B?TGd0TzJTMUE5dzFRRjdzS1FyYnVqa01oYmpUcHM0ZTladG1LWWxqK0FPUGQw?=
 =?utf-8?B?MG8vWDlqQ2wyL050OWJzdlpkdzVsRDFOTEU4bDcrMGU4RDhjS2gzZjM1Wkli?=
 =?utf-8?B?eEs2UXE5bTdIY2hZQi90aEZwYlU3Unk3d2tWajdXdy8vMGdKcFNFUkVORkNs?=
 =?utf-8?B?Q3Ewd29mV1BzbVZwdHlUbFI0am51SzFkOW5KcEljVXNsZXduS1lBcmVPeFg2?=
 =?utf-8?B?cTRTRGtZdFhHc2Jpd3VNbThVNnY1THRqeCs5NVJ4aXVXSjhXSTJFWHdhMjhQ?=
 =?utf-8?B?UTdmWjFxZUh4SHJpcmpaQ29BVGorTCtPMzdWNXl0cDFwcGhnNmd2Vy9PazZ1?=
 =?utf-8?Q?0Ml8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22ec493-f65b-4db4-732b-08dd4418ba2a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 06:05:15.5428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2adfpCv9I6QAucSkNNYD/RdIoVrza01b6C0rq25wyjiL0+qWWvOqqs4uTxEel4D7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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

Hi Simon,

On 26/01/25 4:28 am, Simon Glass wrote:
> Hi Tom,
> 
> On Sat, 25 Jan 2025 at 15:55, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sat, Jan 25, 2025 at 03:42:00PM -0700, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Sat, 25 Jan 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Sat, Jan 25, 2025 at 02:31:36PM -0700, Simon Glass wrote:
>>>>
>>>>> This fixture name is quite long and results in lots of verbose code.
>>>>> We know this is U-Boot so the 'u_boot_' part is not necessary.
>>>>>
>>>>> But it is also a bit of a misnomer, since it provides access to all the
>>>>> information available to tests. It is not just the console.
>>>>>
>>>>> It would be too confusing to use con as it would be confused with
>>>>> config and it is probably too short.
>>>>>
>>>>> So shorten it to 'ubpy'.
>>>>>
>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> [snip]
>>>>>   102 files changed, 2591 insertions(+), 2591 deletions(-)
>>>>
>>>> First, I'm not sure I like "ubpy". I believe "u_boot_console" is because
>>>> it's how we interact with the stdin/stdout of the running U-Boot. And
>>>> indeed it provides more than that. But ubpy is too abstract and unclear,
>>>> and looking at the diffstat, I don't know that big global rename is
>>>> justified to save text space.
>>>
>>> I actually get quite confused hunting around in the fixtures so I
>>> suspect others do too. I would like to settle on some better names.
>>>
>>> Yes, I don't like ubpy much, either. Your favourite AI suggests
>>> 'fixture' or 'test_env', both I which I prefer. The only challenge is
>>> that 'env' has various other meanings in U-Boot.
>>
>> Yes, until someone has a better suggestion than "ubpy", we should leave
>> things alone. "fixture" has its own meaning within pytest and so that
>> would also be confusing.
> 
> Yes, ideas welcome. Arguably it is confusing that this one fixture
> provides a gateway to all the others.

I have a couple of names to suggest:
1) "ubintf"/"ub_interface" - As it interacts with U-Boot during testing 
and acts as the primary interface.
2) "ubman"/"ub_manager" - As it manages multiple things in tests, not 
only limited to console.

Regards,
Love Kumar

> 
> Regards,
> Simon
