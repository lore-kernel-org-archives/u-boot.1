Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B118CD5BC6
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51FA83B1A;
	Thu, 13 Nov 2025 12:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oOP8Qzfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A072283DEA; Thu, 13 Nov 2025 12:16:58 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4619D83AAD
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7sFSxwo6OyqCdDGLYhwtzEdrbBRo6l8dcOdL8K5QvqANHK+JUNrn1U2urD37p+cHU+lCTTV1bjlXKIPIHqd8JJUoK4lP1/T5SGA2BGwYcMj0vLKpTi9pIUQBjO/2SHolRSI1wPHezgYRnsuVxVzYLgRkKCzkepn6+UJFGySqGYNLj5Gq5ajYmXvO+FioZgeHMQmocZhXRwhvZCN81LPGFFnl28DCTRgPg4KFUW/K0kbIps5hq4cSH3U+8crSYJjiUK1YhptV+pnVBbPog21PAlqswdXiojR2MiE4gTZJGK5OdpadvxaOnZFREG5wQxIWqnZ4RjjnA/VVa2FV0hr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ecUHkr2Wt5EPIZWoFyePVAonKkUwI0AIbCrFjW9ON4=;
 b=g+p838N4h3ruywTfr8wZ5gem2C69QIQpnXn4iqxPvzrTsM9nfhBz0z139MHxrkPqKgb1Uc9x9dEHq8/yhhdir8yE6+Vhq3y2duOWVZU54PeJHcNs4+4oFGpNBMHDtauKlnu1uabDPGcnVQtUnyZcgdu2RmJzF2Fa/QiuLY9FPr9n0oRTn5O0SvgTX8ZHQq3CF2Y7RZkLbVVAN9AHI/RBj6RrseQgcrtIIxTQngKCQutMaf1YAgKdkiChKgIXhysnh3rGBnDZc43L3f5CbAt185op39w+3hkbu/vmAr8BPUjWkzyLi+swNvAJn+ofb87ohEqxZC5BZbrCONF22ghCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ecUHkr2Wt5EPIZWoFyePVAonKkUwI0AIbCrFjW9ON4=;
 b=oOP8QzfufGnRMBKwIp0XJyMIUMPtdggBhJpGrYHwBIS2zTrcajBEjlej1Lyhqr75THtonP+mMw50UZyulGXiFfsg51Tq3HDuw8Bc+x7GeMBJEEH490/7SegADKoyEW+ZmGEvhqMPbNEnz3OzXGHusy05B38MQ5Nh4roYhjZjMLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV2PR04MB11350.eurprd04.prod.outlook.com (2603:10a6:150:2ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:16:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:16:50 +0000
Message-ID: <44351bcf-64af-4060-89b5-cc0ff666d4a3@cherry.de>
Date: Thu, 13 Nov 2025 12:16:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] sam9x60-curiosity: migrate Boot LED setup to use
 /options/u-boot/boot-led
To: Quentin Schulz <foss+uboot@0leil.net>,
 Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Klaus Goger <klaus.goger@cherry.de>, Eugen Hristev
 <eugen.hristev@linaro.org>,
 Durai Manickam KR <durai.manickamkr@microchip.com>, Stefan Roese
 <sr@denx.de>, Zixun LI <admin@hifiphile.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
 <20251112-led-old-dt-v1-10-2892d49517db@cherry.de>
 <20251113-naming-upper-470ba8be1c25@thorsis.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251113-naming-upper-470ba8be1c25@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV2PR04MB11350:EE_
X-MS-Office365-Filtering-Correlation-Id: 5934de43-5126-4abe-0e9d-08de22a62486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1I2V2U1ZVdxLzY3bUJ4Q09xeExIcGNEek54eXpzREpiQURUcFA2bnJCWWhT?=
 =?utf-8?B?Q3FKUWxGOW5MQlRvZ3Q0YU1jM1AvdWZwaTV4UHI5cGJNdzVIVmtpaDFCQ241?=
 =?utf-8?B?d2hUNmFlNVhMR29MOTNlMmkrZXk5ZVVJRWxFVkQ2Yk9ETFMwR2lFdHZDTFZj?=
 =?utf-8?B?cHRLWk1kRHpMNmZTM0hpZS92bHE0dXZCWUhRVU9ZOEFrMGxSRU10WkRMVzRT?=
 =?utf-8?B?eGZ2R1IyaThiMElSeHl5R0RaNk1kUkhCdXpiV2J5bmJtRmh0eU1lYkJreFoy?=
 =?utf-8?B?UDRXVmV4bVQ1VkpMVmk3VU9ldWJVcTZSdWNvUThqanZLcUplQWJSUTd0NTBa?=
 =?utf-8?B?azZlNUlSbVRMYXFiMVZOVkJUNWhrRDNBYno2SFBCb3ZuMVk5S05rRS9CZ21s?=
 =?utf-8?B?KzAvZk4wWXNKZUFkUU9jUzN0TkliTERIdlZVcllWVWpXWm13T0ZzUFUvb3Jy?=
 =?utf-8?B?RzRuQk4vaERMaXJibWY1RDRzdFRCNmRTL2pwRVp5b0h4bkRNZ2pCMlErQjhZ?=
 =?utf-8?B?MVVvN0tBbUo3MFhEczk3ejhmSGY0MDcxbnJOWUhWVXhodjN0YlY0OWpSOHZM?=
 =?utf-8?B?STQ1RXRxQ0pqd2JRWFJKM21lWjlyNzZsSDJ1cUJUM3k5aUxBZlZITWJiMEVp?=
 =?utf-8?B?OU12b3NzWVFNYXlNM1VkdzZIcVI1MVQ5NGxxNy90UFlGV3ZER2ZVTzMrb3Jz?=
 =?utf-8?B?Yk5NNUgwRWtDZ2lEOVRnMFppaksrL2gyOHpBNExUVmQxcDg2RVBpMFc1OUlF?=
 =?utf-8?B?Z2hyd1daakNOdnpmS1JjRmN1RDIweFhEY0NFN3lhbS9zbUR1Vnlla0s1MEFu?=
 =?utf-8?B?WjRpUEpsS1BmMjk2TElOaTlucXRGeUxLcUw2SmV5ajlqNDlFWEpRZ3RrWkhZ?=
 =?utf-8?B?aXdKQ3dFVDc5aG00NC91K09TemdpNk9menV5L3FIV1hQbWh2VVdvNUg0Umlh?=
 =?utf-8?B?ZXlPbmI3ZGEwVm82R0swR2Z3MmpVYVVmUDN6d1l6a1EyZ2o2RXRxWWhsRjM1?=
 =?utf-8?B?NTFLb0ZQYnowZ1VNU0RmZ05QQjhvdW50WlRidlVlUElsSmN1cEgySDBBVVJV?=
 =?utf-8?B?UjVSQlc3bVFNVzRGOGQzSlZ0eVNDVWVMOXpRRHZ2UHhHUVlKU0duaDBCVmJJ?=
 =?utf-8?B?OFFpbFBGZ0JpMFBaRTg0ZDMxNmNnS01hR3ZzM1lXT3AxTFI5UVJTbUNkYzIx?=
 =?utf-8?B?Ymw1NnN5Z0Q5UVA3V1JEU2NzaEo0WUVzN3ZMUVUzMCtqMVNaRHNlQnRxR29F?=
 =?utf-8?B?Sjc1K1ZTNFQ3STZUNVlOcGhiLzc4S25IYmtGTUxNTUd0cUtIb1pwYXl3T21w?=
 =?utf-8?B?VDRiZno5a0J4RExHRWJiQVF2WnpmWXRkYi9HbHdyMEVBZHE1UHZ3dVJwRWhR?=
 =?utf-8?B?Yng2MWFrSGFUZkh1L1lZRHMvVVA0UUszR0dPbnFhVjlJQ2lRVkRNbXZqN3Fk?=
 =?utf-8?B?c1FiRUxYZ093eENjak5TeE9Rei90K3IrUzFVVkNNWkFGMnR1Y1VqVVVrR1Z4?=
 =?utf-8?B?a2ZLV2V4bEtoU1NlVkNzM2dGR1lxTC94K25oU0ZHN2F0czh5VFBaSmowRnRz?=
 =?utf-8?B?a3ZRNGp5cWxyZGdhVGszN0hINENodVZ6NFdiTnlGekdabi9yN0VDUGhHWmxP?=
 =?utf-8?B?c0kvMzRHUzdaRXdMMmJ5Rm9BSVlOQnNSa21IbE9wbjZvYitkT0Z2Wk8wN09t?=
 =?utf-8?B?Z0NOUFY5d1dMTUFCYmxaK1RUUnJYQmdWdm5PT3IzcGxCVGdEQXhJMUtFbUFx?=
 =?utf-8?B?dnVFVHJUZ1VWMWZNZiszZlI3OVhqU1FPeVBlbDZMT0hRQk1wYzQzbUE1U0Vy?=
 =?utf-8?B?K04rZE5kZXhDaXU1TTBYVG9HOW8rYUtBbnZTb1h0VmNLTWxweGZvb05JUGFn?=
 =?utf-8?B?clBQL05ScUpOQWVtbjlJaEt6OTYzVlZsUzdyU3YyNU5VTEhGVTJaNlhoenpX?=
 =?utf-8?Q?JfCcy6TFpwMb8qpKKio09wDlVWIu0D4w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhzdkRwcEd4OGYrMys5alUvWThmZmoydWtDcWhYOXVTdVd2N0QyY3VUVmJq?=
 =?utf-8?B?Vmkxd1ZrQlc3RzBjemp0U1FDRjFzak14TDJ2dXQ0QTBFcXpyRDcwY0o4WVM3?=
 =?utf-8?B?dUZKQ0hWOG54V3BjQW8zM29CZGthek5NUHNtb004cmxNaFhIaHJUQXFJbWRX?=
 =?utf-8?B?b0w0M1hteklrMW12bEtEZWdDQTVtS3RmMGZtN3lkMjdmZS9kOTh5Um0xSFp1?=
 =?utf-8?B?VVhoL2F2SWJTdlpTbGp5eU1iQW1uY1BuYk5aTmo2QWx1MWMvN2c3VnRyUTY3?=
 =?utf-8?B?UFFncHo5YSs2ek1FNjFJYWpQcDVFTmpCa2xQQ3ZSeXRYdnpXa3YxUVYzYUtt?=
 =?utf-8?B?YlIxQ2FjRHFHR2JKSloxcWFRTDlJWGpuL29xUzRJSEo3ek1nQ082QU1BNFJD?=
 =?utf-8?B?cllWS1FwQnliYjV5WlZ4dmlwV0gvVDFrUzZHb1hIOC82dEt6bW9SNjN2eWZR?=
 =?utf-8?B?STRHdXBNVmh0dHpNTlJwU3ZDU0NVVzVweFJocjQ2MjN0U1VOR1RxZEtqYUh2?=
 =?utf-8?B?UndhRTVYSWlyVDY2QnMzM1FzZU9lUVVMUEYrVXNaZ1Qwc3NEQ29FYmp0NEs4?=
 =?utf-8?B?bTlVQ3ZXY1VMQTc4bXIrZ2Z5KzFpVG9zT1ltcTdjKzBMRFFhQ1FSM0VIYWUr?=
 =?utf-8?B?V1NQdTJTa2czYkhKLzMxUkFmZDJPUkxBL09BS0UyUW00elBZWU10WVRSNGtX?=
 =?utf-8?B?MTNPNkJCb2ZoOVIxTnh5SENtVEtVWUtiZ2N5cWNaWThUUnlVL1lhdy9lTDlx?=
 =?utf-8?B?QlRZQWxoc1d3NnRkVlhQbGJWQWtBTkhmVVRvZTVNNWo1cTNCalJsRVFud3pB?=
 =?utf-8?B?TWpmeDVRaS9WVUJ3SDNtODl3QkVTSTBuR05HaHI2MkVGVmJTSDhhN0ZWMVpl?=
 =?utf-8?B?THhBOURuekZkRmpLSVBwN2wxdkhPWTFZV3NsWVFOc2Erak5RdUhSVGt2ODJq?=
 =?utf-8?B?OHJVT0ZsVlRFb0thV2d4ekRCWXlFNlVVWEEvbmdlbG16YVB3eW10OGU5Z3Zz?=
 =?utf-8?B?U0lEK1RkdDZDOXVBa2Jtem03S1pEL0c2RDBpb2RBOFRaTjJTOGFlUlJRaGIx?=
 =?utf-8?B?dHNnTHVNdTRiMTN3d1BOR0daRzdIK011anpHMGlMVlR5STRUNkxkdlpML3ZZ?=
 =?utf-8?B?Z0FaYlk5MG1kSXlpZWJXMnZwMGY4MXZsbTBaVlkyU21sa3BCVHRvYzBUNFpO?=
 =?utf-8?B?bEpESk5yUTdCUEFWRHZ4QVpYNlZXeWNrYWJOR2UzV1hxSE03MzBUeFBpa0hi?=
 =?utf-8?B?ZVN6THJsZWk5NllnWkR1alZkdERQenV2enFGS3pFajhaVFFPelc2SFg2NzRF?=
 =?utf-8?B?N2lvS3VSTzJxczRiMGlSeFpMNkFXdDJCaTk2cThZZWxJZ1BIRzd1Zi9aaUFi?=
 =?utf-8?B?bG5sY3NGbVlRWVJzeFJDSEtjbHBYOVBRN2RNd1hQTHFUN2htZitZbHhzbXQy?=
 =?utf-8?B?YmhXaGJwMlc3cTlrL1ZhWlUrYTBqME1QZ243LzdIc0FKVHo3TXRNdG1MV1Yv?=
 =?utf-8?B?Z28yQitXU0tuZzVYZVY0bWQrL0RHQmd0Vi9mWVJFM00zSWtCdXlYNjVJQjhS?=
 =?utf-8?B?eEJzeXNDVTFHamtnWllWcHJtZXBFcEF3Vk1Vd2pFL25oNnZwSEpzRTJ6dVBt?=
 =?utf-8?B?TWhSTHVmZy9OTmFEVXBuRHlnS1pOQllwL1VVSG85TEFVcktnYk8zMXFubEVB?=
 =?utf-8?B?Ly9hZG81WC9INmdZNGZPMUtPZDRCbEM1SDFHaG11Qjh6M1FmRTdwVndxdmtp?=
 =?utf-8?B?L0V4TWxwOFU3NzRHK0twMjdoajNyS0xKWmlaNVBpU0VxODFXSzBFV1EyaldP?=
 =?utf-8?B?R3NOaWpCSWwvckY3WGRqV1hVVW1XWm1rWi94aXFTUllySUZtWi9QQU1WenA1?=
 =?utf-8?B?Mllyd0NhK2k1ZFlWQjFXSDlJMGZLdzc0a2dqOE1LS0xWUHJ5enhtcEtYblBr?=
 =?utf-8?B?SjlhYXlROTBWVGhaT0ZKSVlndGo2aTMwbzRYdG1SV00rWSt3ZXYxcUVOMC9H?=
 =?utf-8?B?a2ZQcVZtQU9yQU5IdHVyN203Q2ZTTFlXWkdLVWJXZVZZTlBqNE9BQkdGc3RC?=
 =?utf-8?B?ejIvTE15eWdqanM4MzhOeEhaMHZkRldaeTB4ZjZNK05lSVVZNkFnMmlMMFRP?=
 =?utf-8?B?RGpLN3hUZStSS0MvWWV5cGJaSHBSNngrSis5SjNEemVIeTYvS2RadkphNU8y?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5934de43-5126-4abe-0e9d-08de22a62486
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:16:50.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FB1wOqOqPAMqVm47VixdA2ogftVTmDEH/Y+Egh3dmYHqKKCyGe75fCip5ZV1ymwApPRro6eRgIJi1/k5tWFsJ0Yt9+fn7pO1pEKU8+1d9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11350
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

Hi Alex,

On 11/13/25 9:44 AM, Alexander Dahl wrote:
> Hello Quentin,
> 
> thanks for your effort.  I'm all in for common behaviour.
> See more remarks below.
> 
> Am Wed, Nov 12, 2025 at 06:48:15PM +0100 schrieb Quentin Schulz:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This board is one of the last users of /config/u-boot,boot-led property
>> which is a U-Boot property out of the DT spec.
> 
> Well, I introduced it back in 2023 with commit 1818b44b7bc ("board:
> sam9x60-curiosity: Let LED subsystem init leds if enabled"), maybe
> because I found the old property in the documentation?
> 
> Not sure since when CONFIG_LED_BOOT and the new property is a thing,
> but I have no hard feelings here.
> 

https://github.com/devicetree-org/dt-schema/commit/3033f0b3479760db047fd58f38ed777dc7e2a856 
for the new property, that is, a year ago, so pretty new :)

914fd75a5d2f ("led: implement LED boot API") for the first commit for 
LED_BOOT, about a year ago as well.

>> Let's migrate it to use the in-spec /options/u-boot/boot-led property.
>> When enabling LED_BOOT, U-Boot proper will lit the LED right before
>> entering the main loop, so nothing needs to be done in board files.
> 
> Fine.  Using specified properties and having less board code are both
> good things!
> 
>> As explained in the commit adding support for this u-boot,boot-led
>> property, let's keep backward compatibility in case LED_BOOT isn't
>> selected.
> 
> Would be nice to hear the opinion of someone from Microchip for this?!
> These properties did not gain adoption on their new boards.  It's a
> bit dissapointing their boards are not maintained in mainline U-Boot
> by themselves anymore.  :-/
> 
>> Note that this is not tested as I do not own this device.
> 
> Tested-by: Alexander Dahl <ada@thorsis.com>
> 

Thanks!

> Note: With CONFIG_LED_BOOT enabled, the LED turns to on in a later boot
> phase as with that option disabled.  I don't think this is a problem,
> just wanted to share the observation.
> 

Mmmmm... Yes, so the board-specific LED thing for this board is done in 
board_init() which is very early in the list of callbacks called after 
relocation (c.f. initcall_run_r() in common/board_r.c). The generic 
support is done in initr_boot_led_on() which is essentially the last 
callback before U-Boot enters the main loop. It will blink (but maybe 
doesn't have time to actually blink) for the time it takes the few 
callbacks between that and initr_boot_led_blink() a few callbacks earlier.

It's still in the same phase (that is the U-Boot phase, e.g. TPL, SPL, 
U-Boot proper, before/after relocation), but much later in the boot 
process. I'm not sure why it's so late in the boot process except that 
blinking probably requires some sort of timer (or whatever CYCLIC is 
using under the hood) that needs to be enabled before being able to blink.

If this is an issue, I **think** we could simply call led_boot_on() in 
board_leds_init() when CONFIG_IS_ENABLED(LED_BOOT) is true, but I'm not 
sure if everything's in place for uclass and DM.

Cheers,
Quentin
