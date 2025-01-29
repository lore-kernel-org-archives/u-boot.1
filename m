Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82209C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6AF980820;
	Wed, 29 Jan 2025 17:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fS9XSgtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0A480AE3; Wed, 29 Jan 2025 17:28:21 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E211807E5
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=As0Ad0iv9dOoeRJYlTZ6Ork8f5+ju4UXBN0RgJTdTzF8y+yMM2xhkQUo3fCQZ2mDrbey/vFMWdfXwJTEGZ0zwU2Exo6/PY6wOyFo6nDIAezeCN3Qa8Hk3unTGCyCeXA7b8v0cWYeDRWwACeqVzg7eMo8z8ehydABOWK1kVG2kjCv2s2wTKERFPG7Xm2jCkIMySb7FqCvR+6eSFRIeer3IOsQmUl0o9Sdxrkg3VMjTG94C4aAMC/rZDRvhGEsAIuPSZ43j22zamCkc2M1T9WSHQM+S6P+m+tiY4jNqlTXX2ElbU7xH6QCvdM6sZpk8wJJZPlt2WJqKzhKUaJTO8GawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13VGxPXbS+K7cyFKViFAWbc9Sv28To4zj4YubBzZsmw=;
 b=ol3l6DBhE7pn3mTdg4tkOze0VtctR3NIaWs6fwita907G5qfwk52AlSkWPdtdfUGQpUecazDkoY5vjxo1yGovEm6g1EYYIC96Moi7PIaBWAmFI64LZ6adydW+BkeaqGmZs92tYTEDDUPgXJLGWUayrdKGjoPIl5Svjszz3OMimDrZtZABnFj/Nx4GjoX6yqQl2lgb5f/u8c39KlmJA8SFJftL/2PVp3HTjf5Rgyo+ccUUwr9RPd1Tg+BQ6e+8e42SYCtnCgGzwqtk9a6+NjYpImCjcXVqNHICFFeOQqTZSs+k75clhjYNMde5rZOwN8v2hhhQ6qQGElW/qdFignpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13VGxPXbS+K7cyFKViFAWbc9Sv28To4zj4YubBzZsmw=;
 b=fS9XSgtTnmdxOYcsqSBTcT3MzVa4LpPThm2qZMJDmKN+W5XK1JZM/f4l8q3LZjpgTftUx6d0uXhIqG4n6hjRREsUVVlruKIUgVwxKCjSP3GJuNJydDON9ERlLBQXNAdGVWttGyKwJG5nxxqiMGCQSRvPvDc34e9cf9RzQlVAhFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 16:28:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 16:28:16 +0000
Message-ID: <fb463ad1-70c6-4c7b-b04a-db44556609d3@cherry.de>
Date: Wed, 29 Jan 2025 17:28:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: renesas: Add TFA BL31 handoff support
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-3-marek.vasut+renesas@mailbox.org>
 <8409fd39-3816-4686-9b9c-56785209ed37@cherry.de>
Content-Language: en-US
In-Reply-To: <8409fd39-3816-4686-9b9c-56785209ed37@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0114.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 3804b266-23a1-4f04-5264-08dd4081ef10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2pFQ1ZaNVd6eCtnOG03VEVNZ3F3Z09DTFEvRmpaU3JENzdxNCtnMzJhQjE5?=
 =?utf-8?B?VXZYajZtNVp6MGhld0E2QzFYWmd0MVZnTHdDSmhzcENrMlg5VXpYMWdmNHlW?=
 =?utf-8?B?OElmc0RQUFBKeHR6bjVEKy8vSUkxTHRpWlpRSjdkMWRWWGNzbmFyb0t5cEFs?=
 =?utf-8?B?UkVLanVHaWJVc3M1RXlkTWhvY0NuVnN5cXA4bSs4S1VBa1I2dWF6YmJzUW15?=
 =?utf-8?B?b0FlNzRXcVFtL0xTNUNiY2VxTzBuTDR1aHVndGZXWm1GK08wT2kvYXh2NHVJ?=
 =?utf-8?B?bDhFMnpNeG9MeHJsdFN1SU13UTJrRGtEQVFXSlNFaDBHTXZ1QlBqa2k5MEoz?=
 =?utf-8?B?L1IwK095dEdoQjlvbWd4RTVyZkRmRHZodnpyeGcrZUZiQWEyZkZIRUZVRGUx?=
 =?utf-8?B?SWRNRERaZGZRN21WaTBPcW85MzJ3eDVpK056a2tkWGtxVCtMOGs4VG9pU1Iv?=
 =?utf-8?B?VW9SMWVkdlV5bTNjSzZrOU5tYTg4L0laUHJxY1pnSUNLd0o2NDBWM0hsZ1h5?=
 =?utf-8?B?eWlzYVlDUGlqSmp5V1VoRFdjd29RblduR3VoTjNMcEdTR2VFZGhUY2ZOSTlO?=
 =?utf-8?B?SFBBMHNoTUFZdDAzenhDKzlQUjd4b0FQbkg4NGhyU1EzajFNbTB3UzVBN05p?=
 =?utf-8?B?b1NTanNlUGVEMS9ObjFxQWZ0VDhSUEFsa3hKdGErNmR1UDZxVmRVNmJGS1Y3?=
 =?utf-8?B?WjAwOGI4MUlSWHlhRStkNGtRTExmZWE4NGo3bXdZMnNQODFFQnBRQldwWTNN?=
 =?utf-8?B?bmZ6Z0NWS1JKN0R6d1k4VjJ1M3VFWHYxWDJTL0svVm13RjlJSHVSS1NwTHZy?=
 =?utf-8?B?ZXdabXZ6YURIWENmRllwRDNURzZnZ2tsWlFQbklEd3pZcEZueTUxeWlWdVpD?=
 =?utf-8?B?NTFxM1g2UGo1TW1FSWYrRkFCbWNCTHN0VjZES2h5cTYvb3kwSzlNbDBvUFIr?=
 =?utf-8?B?SjJJM1Y0L29CYnhvYjBrT01mUUtHRE1PRHlnMzVqV09hNG1HYmxQbHVPTWJO?=
 =?utf-8?B?eGdXRlc4aUZEbk1vODJUZkFGekE2cTczU1FzWDVicTAxZTNITmVXMzgrQ3da?=
 =?utf-8?B?VE5rbWxIcllEMmo1QmhDNUFqSXhNMUYxc0k2RXZkNTZ4OGZBQXJ5bTVhdHF4?=
 =?utf-8?B?WCtVOXh6VHVMbHh6WkVoYmNha0VEc0hiakF0S3psdnNZYnd2cjMrT2ExMjZs?=
 =?utf-8?B?VkxpZ3RNV2JPeFUyZUN6RHVCZzFNNExNTmtQREpDUHdZZk1BVDQ4ZHlLSUkr?=
 =?utf-8?B?dUEvUGFmd25JOXJuN2FEc09LNjAyWG91Y09iT2R0blQ2OTRaa09XaXJSTmdE?=
 =?utf-8?B?VjJjUmgrblJPUm1iaFIrd0RPaHk0Sk50MEcwL2FXaDB1UWhxZ253TmVEcURK?=
 =?utf-8?B?Mlc3UlJOVG4xVFMxQkRZMUdNeW5ib1o5ZU5XMURiWkFzSXlFR1UrZU5IMHIy?=
 =?utf-8?B?ZHJUTGs2VFBZdjFBYXorWG5waVhUeDJSVnJubTRPQ2xKNFdDQ2dzQzBBMUVy?=
 =?utf-8?B?YTJRQ1NmS1cwOEZYYTZMVjFreW1RVU9ZTXBwVi9aVGVReWxXYVUvTit5d28w?=
 =?utf-8?B?TWhQWGxyWndxYTVVbFowVzNIb2hxcjJRN1M3UnVsdWoyblc5RDNkczVnMTZm?=
 =?utf-8?B?NDUrVWczMU9nbk4wRkFEcUhvUGc1WVFJRUZZWXlZWlRrNlM2aE1KeFA3dVRS?=
 =?utf-8?B?eHdqcDl0UE9KNlkyc0lHYmo5bEVVWXF5V3VKOWFuN2xYKzNsNUg4WlplaTg0?=
 =?utf-8?B?ZysxdjNuTERzTFNpWDQ0dkJrenZrWTlUaW9qblM5SW5mUHZ3UTVTQitMSFdm?=
 =?utf-8?B?Rm9xTC8xZVh1RmtiVUtOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZqOGUvWTdhVEcwYjhaL2hpcDJxcXdHckNDUW9RUTJkcDVySmZQY2FXblJS?=
 =?utf-8?B?NU1oQXl5YVYwMmZjcDVWZytxRWZDd3gvd2VJMlgvVDNleGpVZFZyZXFFVjkz?=
 =?utf-8?B?NWZjVGl2QkpZSXE2Yjhlc2h4d3ZsVVBQRVNjNlRMaUo3QW9hNVdhcjZWZDNX?=
 =?utf-8?B?SnVEK2xPeHZCWllUZzBWbndqb1J5aC9UK04vT0NLV3JEaUJuSTFVSWpLbGg3?=
 =?utf-8?B?Wmw1L3p4NEp2VGZnQk9TNlh2M1U2cDFCNzk5eTlFd3UvZW1SZG1jWlF0NzJh?=
 =?utf-8?B?dGJWNTNGNm9zNDRNSXFEWHphNG5aNTZnVmR0UXp5ZktMK1EvRy9xcmIzOUdi?=
 =?utf-8?B?dzVRSDBxZkJjVGlMamJTRjZXKzFqenF2YTI1eGhqNUFOYUNBVTV3ckl0NXc3?=
 =?utf-8?B?aDhJTk9uSXRCZTVNWkNicVBWaHpFZlZBbXhDM1UwS0V1bUNQK0pKTVRBTDB1?=
 =?utf-8?B?TWxpWmtxaTA1VXByL2RWWHRjTUNwU1BMZjQ1ZkE1dWdJRUlwMCtDNnVYbjFS?=
 =?utf-8?B?YXdVeW9JM1J3RDJXSktNR3ZNMUJzWiszSkFLOEdGdGlXTm9jY29qNE5vWHU1?=
 =?utf-8?B?QnFNRDBsSndjS3NpMm9rQmc1NW5Kb0N1ckxmcXY5S1FuVzI5QjFwQlgxTi9M?=
 =?utf-8?B?cDZmaWpJS0daWHgrdko4dEZtTXFVSHBDNThIVEFLSlBEbnZqYU1xNUt3ZThh?=
 =?utf-8?B?bHRhdG1YWjJ4bzRVSkRBUXNkUmdHN3ppenM0bFhQbjJ2dHBWV0VMbnB4Vmlx?=
 =?utf-8?B?Nk53bnBYT3pSUmtXeTlUOVhzN0VRUmM4ZVZ0Wk1uM3VZZFNCeTlGUmczaGNO?=
 =?utf-8?B?bVJxNmtzTUUvaEJZQUZtbUp1clhMWjA3bUFJYklHQ2U3SlgvbTAyK3FqQlBa?=
 =?utf-8?B?SEJGOSs0dDZwZ3hlbkI0SFI2UWxuQnZoNVBub3ltRUVSS1JSMmtBWTUrVEI2?=
 =?utf-8?B?ZDJtRGdJQW0yclRLV2FUcHEwUGhtOXRuK0pxSFZrU1UvbU9UblNqWlpDTWU1?=
 =?utf-8?B?a3Q0L1d2emsvQ1dsWmRtQWhTU3lQMGQ2VlltWUdLYmVxcHU0M3Q3eFZZb3NO?=
 =?utf-8?B?OS9wcXRIT0dtbjduVWtYTk15L21WRjUrN1RYUEVYLzF6Q0k3c21kbEFwdVRp?=
 =?utf-8?B?QW53S1RlR1U2MVdIU25LRFhnZkFSblJFTWhtY2hVUVRJakY4MHNvWmREbGd6?=
 =?utf-8?B?aXpZdko1V2RqQzlHU2d1M3VIVmtXSzFSZ2Zzd2FWaHBFZzZsNHBTcUFUVURy?=
 =?utf-8?B?bDV4TjBzdklpZTVEK2JHNlViOTN3ZXZXbDZMazBIdTZxMjd0a2w0TkllT2xx?=
 =?utf-8?B?SXNMY3cwTWRVcWczMWtIRzd5cmtHUGxycGZRTjh0YW5ZdHdNWUt2b3RNTlJ3?=
 =?utf-8?B?QmFGTjFXNXdNbFM5MHVzL01Ea1JnUExTNG1EU1IxSUUxZTJkSFVXNXVTWmtD?=
 =?utf-8?B?eXhZMGpGbVBpa0NkYWdWSzh5T2dQU2hRMWJaQnNNRERCZ1VGaDkyZUNoK00x?=
 =?utf-8?B?akZjNzRuRldVQVovejVUSElCNlZOTWVZNzZTbEljNmRwWFVneFhNRnE5QVhq?=
 =?utf-8?B?UmNrekFkK2c2U290bm1VVEdkS3hoN25vVWo2N2JnamxLNVBkMnRvTGZYMDRH?=
 =?utf-8?B?ellZemFERmFpdWw2VDJTT2xON05TL21Wa2lZVFZrdlpNbHFBM0QzMkpER1NP?=
 =?utf-8?B?UFgxWEhESUI4L1dBV3BodnpaNjVXVld2VHZaSjFlbFhHRjQ3SUd5bUtyWjFp?=
 =?utf-8?B?dTZ3aHBQVmk4dHJxSktFaCt0SDJwcDBxUmxzcFpVc1I5RmkyVUpKeGhDNGY2?=
 =?utf-8?B?cE9jcXQ1bFNjc09Zei9NaHhFQng3d1ltOFhtb1ROeXNFc3ptZHJiVWlvY25i?=
 =?utf-8?B?Sk9XWGcyOFIrWVFPV3daLytROWRqWmxkcHZPMVprMHM1bkF4S0VSMHlLT2lk?=
 =?utf-8?B?aVF3Rk5rSUxkRS9zRCtxRDdiazNHUEQramhGbVFZcFExQ3oxK3ZYRjNZcUp3?=
 =?utf-8?B?RXpxNXBPUzdUSmhXaEE2S29Wc3Vwank4azJFZ2VCNUsxWFV6S0gzUXd0NGxL?=
 =?utf-8?B?RlZHcm9zS0p3em05U0RRM3hUTHBkTmk5RlJvZ09WazZWT1ZkdnVzWGYxTTJQ?=
 =?utf-8?B?dFRvVnFnd1FCNTNTUHV4eUhEcDFSRWpLdXE1bDBKK1c3SDJPUFAwem53ZWR6?=
 =?utf-8?Q?MB694YBJsb8O5ZAvqqcvn8g=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3804b266-23a1-4f04-5264-08dd4081ef10
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:28:16.3298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fg8vIPjs8uvuGXlwxDlxXpu2ZJ1mrCbMhTp7peCgox1SE8Ol68vu1cTmi6SeNr0q/LyOkGm6wfRAtaI0YHChU/WrvCgkyzwmP6K/JeMe3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999
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



On 1/29/25 5:02 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 1/12/25 11:36 PM, Marek Vasut wrote:
>> Implement custom U_BOOT_FIT_LOADABLE_HANDLER and 
>> armv8_switch_to_el2_prep()
>> handling in case the TFA was loaded. The loadables handler sets up custom
>> handoff structure used by Renesas TFA fork in fixed location in DRAM and
>> indicates the TFA has been loaded.
>>
>> The custom armv8_switch_to_el2_prep() handling tests whether the TFA BL31
>> was previously loaded and the custom handoff structure was set up, and if
>> so, jumps to TFA BL31 which switches from EL3 to EL2 and then returns to
>> U-Boot just past bl in armv8_switch_to_el2() to finish starting the Linux
>> kernel.
>>
>> The jump to Linux through TFA works in such a way that the custom
>> armv8_switch_to_el2_prep() handler configures the custom handoff 
>> structure
>> such that the target jump address of the TFA BL31 on exit is set to the
>> armv8_switch_to_el2() + 4, which is just past the bl, and just before the
>> U-Boot code which implements the Linux kernel boot from either EL. The
>> registers passed through the TFA BL31 are all the registers passed into
>> armv8_switch_to_el2_prep() to assure maximum compatibility with all the
>> boot modes. The armv8_switch_to_el2_prep() handler jumps to the TFA BL31,
>> which does its setup, drops EL from EL3 to EL2 and finally jumps to the
>> armv8_switch_to_el2() + 4 entry point, which then allows U-Boot to boot
>> the Linux kernel the usual way.
>>
>> In order to build suitable kernel fitImage, build TFA first, temporarily
>> from downstream repository:
>> remote: https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Frenesas-rcar%2Farm-trusted- 
>> firmware.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7C6ab2eb623e32425379f108dd407e5a7c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638737633628498421%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DWQfUm5mp9%2FMCUxvFFbO1yfjKlvmtfiOD8VTkN%2BEZKk%3D&reserved=0
>> branch: rcar_gen4_v2.7_v4x
>>
>> ```
>> $ git clean -fqdx
>> $ MBEDTLS_DIR=/path/to/mbedtls/ make -j$(nproc) bl31 \
>>     PLAT=rcar_gen4 ARCH=aarch64 LSI=V4H SPD=none \
>>     CTX_INCLUDE_AARCH32_REGS=0 MBEDTLS_COMMON_MK=1 \
>>     PTP_NONSECURE_ACCESS=1 LOG_LEVEL=20 DEBUG=0 \
>>     ENABLE_ASSERTIONS=0 E=0
>> ```
>>
>> Build Linux kernel Image and device tree from current mainline Linux
>> kernel repository, obtain 'Image' and 'r8a779g0-white-hawk.dtb' .
>>
>> Bundle the files together using provided fit-image.its fitImage 
>> description:
>> ```
>> $ mkimage -f fit-image.its fitImage
>> ```
>>
>> To start the kernel fiImage generated in previous step, load fitImage
>> to DRAM and use the 'bootm' command to start it:
>> => load 0x58000000 ... fitImage && bootm 0x58000000
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
>> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Julien Masson <jmasson@baylibre.com>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Maxim Moskalets <maximmosk4@gmail.com>
>> Cc: Michael Walle <mwalle@kernel.org>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
>> Cc: Peter Hoyes <Peter.Hoyes@arm.com>
>> Cc: Raymond Mao <raymond.mao@linaro.org>
>> Cc: Sam Protsenko <semen.protsenko@linaro.org>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   board/renesas/common/gen4-common.c | 118 +++++++++++++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>
>> diff --git a/board/renesas/common/gen4-common.c b/board/renesas/ 
>> common/gen4-common.c
>> index 52a0639073b..c7f3f9a30ab 100644
>> --- a/board/renesas/common/gen4-common.c
>> +++ b/board/renesas/common/gen4-common.c
>> @@ -7,11 +7,13 @@
>>   #include <asm/arch/renesas.h>
>>   #include <asm/arch/sys_proto.h>
>> +#include <asm/armv8/mmu.h>
>>   #include <asm/global_data.h>
>>   #include <asm/io.h>
>>   #include <asm/mach-types.h>
>>   #include <asm/processor.h>
>>   #include <asm/system.h>
>> +#include <image.h>
>>   #include <linux/errno.h>
>>   #define RST_BASE    0xE6160000 /* Domain0 */
>> @@ -88,3 +90,119 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>   {
>>       return 0;
>>   }
>> +
>> +/* R-Car Gen4 TFA BL31 handoff structure and handling. */
>> +struct param_header {
>> +    u8            type;
>> +    u8            version;
>> +    u16            size;
>> +    u32            attr;
>> +};
>> +
>> +struct tfa_image_info {
>> +    struct param_header    h;
>> +    uintptr_t        image_base;
>> +    u32            image_size;
>> +    u32            image_max_size;
>> +};
>> +
>> +struct aapcs64_params {
>> +    u64            arg0;
>> +    u64            arg1;
>> +    u64            arg2;
>> +    u64            arg3;
>> +    u64            arg4;
>> +    u64            arg5;
>> +    u64            arg6;
>> +    u64            arg7;
>> +};
>> +
>> +struct entry_point_info {
>> +    struct param_header    h;
>> +    uintptr_t        pc;
>> +    u32            spsr;
>> +    struct aapcs64_params    args;
>> +};
>> +
>> +struct bl2_to_bl31_params_mem {
>> +    struct tfa_image_info    bl32_image_info;
>> +    struct tfa_image_info    bl33_image_info;
>> +    struct entry_point_info    bl33_ep_info;
>> +    struct entry_point_info    bl32_ep_info;
>> +};
>> +
>> +/* Default jump address, return to U-Boot */
>> +#define BL33_BASE    0x44100000
>> +/* Custom parameters address passed to TFA by ICUMXA loader */
>> +#define PARAMS_BASE    0x46422200
>> +
> 
> Shouldn't we rather set those as offset compared to the load/entry 
> address passed in the ITS?
> 
>> +/* Usually such a structure is produced by ICUMXA and passed in at 
>> 0x46422200 */
>> +static const struct bl2_to_bl31_params_mem blinfo_template = {
>> +    .bl33_ep_info.h.type = 1,    /* PARAM_EP */
>> +    .bl33_ep_info.h.version = 2,    /* Version 2 */
>> +    .bl33_ep_info.h.size = sizeof(struct entry_point_info),
>> +    .bl33_ep_info.h.attr = 0x81,    /* Executable | Non-Secure */
>> +    .bl33_ep_info.spsr = 0x2c9,    /* Mode=EL2, SP=ELX, 
>> Exceptions=OFF */
>> +    .bl33_ep_info.pc = BL33_BASE,
>> +
>> +    .bl33_image_info.h.type = 1,    /* PARAM_EP */
>> +    .bl33_image_info.h.version = 2,    /* Version 2 */
>> +    .bl33_image_info.h.size = sizeof(struct image_info),
>> +    .bl33_image_info.h.attr = 0,
>> +    .bl33_image_info.image_base = BL33_BASE,
>> +};
>> +
>> +static bool tfa_bl31_image_loaded;
>> +static ulong tfa_bl31_image_addr;
>> +
>> +static void tfa_bl31_image_process(ulong image, size_t size)
>> +{
>> +    /* Custom parameters address passed to TFA by ICUMXA loader */
>> +    struct bl2_to_bl31_params_mem *blinfo = (struct 
>> bl2_to_bl31_params_mem *)PARAMS_BASE;
>> +
>> +    /* Clear a page and copy template */
>> +    memset((void *)PARAMS_BASE, 0, PAGE_SIZE);
>> +    memcpy(blinfo, &blinfo_template, sizeof(*blinfo));
>> +    tfa_bl31_image_addr = image;
>> +    tfa_bl31_image_loaded = true;
>> +}
>> +
>> +U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TFA_BL31, tfa_bl31_image_process);
>> +
>> +void armv8_switch_to_el2_prep(u64 args, u64 mach_nr, u64 fdt_addr,
>> +                  u64 arg4, u64 entry_point, u64 es_flag)
>> +{
>> +    typedef void __noreturn (*image_entry_noargs_t)(void);
>> +    image_entry_noargs_t image_entry =
>> +        (image_entry_noargs_t)(void *)tfa_bl31_image_addr;
>> +    struct bl2_to_bl31_params_mem *blinfo =
>> +        (struct bl2_to_bl31_params_mem *)PARAMS_BASE;
>> +
>> +    /*
>> +     * Destination address in arch/arm/cpu/armv8/transition.S
>> +     * right past the first bl in armv8_switch_to_el2() to let
>> +     * the rest of U-Boot pre-Linux code run. The code does run
>> +     * without stack pointer!
>> +     */
>> +    const u64 ep = ((u64)(uintptr_t)&armv8_switch_to_el2) + 4;
>> +
>> +    /* If TFA BL31 was not part of the fitImage, do regular boot. */
>> +    if (!tfa_bl31_image_loaded)
>> +        return;
>> +
>> +    /*
>> +     * Set up kernel entry point and parameters:
>> +     * x0 is FDT address, x1..x3 must be 0
>> +     */
>> +    blinfo->bl33_ep_info.pc = ep;
>> +    blinfo->bl33_ep_info.args.arg0 = args;
>> +    blinfo->bl33_ep_info.args.arg1 = mach_nr;
>> +    blinfo->bl33_ep_info.args.arg2 = fdt_addr;
>> +    blinfo->bl33_ep_info.args.arg3 = arg4;
>> +    blinfo->bl33_ep_info.args.arg4 = entry_point;
>> +    blinfo->bl33_ep_info.args.arg5 = es_flag;
>> +    blinfo->bl33_image_info.image_base = ep;
>> +
>> +    /* Jump to TFA BL31 */
>> +    image_entry();
>> +}
> 
> Shouldn't we have a weak implementation that SoC vendor can override if 
> they feel like it?
> 
> To me this feels like it could be much quicker adopted if we had some 
> default people could try out for their boards.
> 
> We already have a generic spl_invoke_atf() so why not the same for this 
> mechanism? As far as I could tell, we get the load address of TEE and U- 
> Boot proper (bl32 and bl33) and pass it the FDT (or nothing if 
> SPL_ATF_NO_PLATFORM_PARAM symbol set).
> 
> I am not too sure who and how TEE will be started as it needs to be 
> executing in EL3 too I believe? So we may still have to provide that 
> one? BL33 would be the kernel params like you did in this patch. Then 
> the bl31 param could also be either the fdt or nothing if 
> ATF_NO_PLATFORM_PARAM is set.
> 

Actually, I would highly prefer we don't even have this symbol and have 
instead a property in the TF-A image node in the ITS to say whether 
we're allowed to pass parameters or not to BL31? The user bundling TF-A 
inside the linux.itb should know (well, we should probably know also 
when building BL31 within u-boot.itb....).

We actually need this symbol on all Rockchip boards using the Rockchip 
blob and not upstream. But this also prevents us from using some 
featureset of the upstream TF-A if we rebuild without disabling the 
symbol. It'd be nice if we don't have to rebuild U-Boot depending on 
which variant of BL31 we use on Rockchip, this info should be stored in 
the linux.itb is what I'm saying. This doesn't need to be in this 
introducing commit though I believe, we can work something out later I 
guess.

Cheers,
Quentin
