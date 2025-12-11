Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782DAD41C1F
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D7383CF3;
	Thu, 11 Dec 2025 11:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JVE3P3KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D62483CF3; Thu, 11 Dec 2025 11:46:52 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E855983BFE
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGtTNeFiOzO+9dzEtKmZafACa/51MOKCnEOrnDN8B2V6NnOVzS+c3cVMbxL9FDZRGK5cAFfMGk2BUajcNRyyK9hJuQDO9XYDwQEjFH5jk4nfGNyFp8iZkrd0woGOuhcGKqv00360EYOw7w4r8JVjowmPBQS44tGAF9E7gM5xf2sbcS3i3zWGTucoje+2aPc8RHQyZWe5gvKTpPunkGUMRsmU3BE4QlbRY6pt2Xk5YU8I6zqFRKz+/bLY6ZH56305diDTCIho9vr1EGNaPYvFamJwA3XKt1ff/JAiZ7Qutlg5HNR9JXw0ytpschks30tVr9Hm87jenj10Sodmbb3qBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpHe9rQDBZFtErpfWNMp5gmn2iHT+sZ+achOZx+85ng=;
 b=lMuu4IuNI+IxoRgz12ybT8TX1ZF8VPf7jg8Qoz3VowF5Dcw84/QpqW9hmG3NnL6JddyMU+51LKBFPm65M22txpqrR8W4VsdhDvFmFBgUcV8ftBoFVWZijED/LXSwHBar9llzf7rczdL9F+MRidLOM+UfZfBzqrRv9cebXcgccMvIMp4KY4DKRLrOM6zNh6HsRCiEOvj1JE4yZyQyFM11XSqkcJGWpozwWlqJ7py6HNdwFdmA5nP9GE1fQSnhtL9S/Qf2XV00NTNJ8fk8p7HhzmIdbqhuKekG7aHD8JcLyDZil/wNT79Az9dTzEBg3qxG+DSZCxromlpOGUSp6+Sw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpHe9rQDBZFtErpfWNMp5gmn2iHT+sZ+achOZx+85ng=;
 b=JVE3P3KWsDSeLLJCiozFTF/wMbd6YvKvxt/oiHstuqbdVNfMoJ11TjG/8IBsbrfZNEXI9aQwvAy18gJJzOG0PB6Ov1c9u01m90W44MAqJZkBrAt1DIG6Erwny+09PKY1qXSgUPf8ITrhOuMP69/w58ZPbl2MmqmhkidPtrU0aPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU7PR04MB11210.eurprd04.prod.outlook.com (2603:10a6:10:5b3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 10:46:47 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 10:46:47 +0000
Message-ID: <6f8d755c-ce0c-42e3-a066-08e75640f3d1@cherry.de>
Date: Thu, 11 Dec 2025 11:46:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568-nanopi-r5: Drop duplicated/extra sdhci
To: Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Cc: Dusty Mabe <dusty@dustymabe.com>
References: <20251209210347.492763-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251209210347.492763-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0166.eurprd09.prod.outlook.com
 (2603:10a6:800:120::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU7PR04MB11210:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a656497-222d-4e69-adb0-08de38a29561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU1uaDNmdHgxLys4V3d6cVdLaUVMTEk3TnY4QVA5M25QNGlqaUJEcE5mdGY0?=
 =?utf-8?B?S2tGZHUxVlhZZTdGck5YUTJZa3lTKzU0WVZxSytVdTR0YjhtYlpabGNINnZ5?=
 =?utf-8?B?djl0ZEtrSUkxWm5UYzJiVmlNaS9aMGV4dDdkVUp5Tkp2VXF6RXE3NWFrbzkr?=
 =?utf-8?B?VWN5SXViOWFPSUdnUi9xR1pBV1NZK1h5V3dwMGRPN1BwK1ZTdHM0Q0ZIVm1Q?=
 =?utf-8?B?RWZJcDVUMDJIU2xVelFRQnRzWDFMZitUb2ZiYlZ2Rld6YThOSEdkQUhtd002?=
 =?utf-8?B?NTViSDJ2TGFvS3ZNQ3hMRkJqSUhGMWJFSHQ2dHhCMmd1aFpTY1p0WlJIL3dP?=
 =?utf-8?B?ZlJudWNTVWE2OE9qancyZ1lQd0RkRi9vcURzZDBpMmF3Q283RHk5K2kvYWhF?=
 =?utf-8?B?TGdGaENIemZTQ0pjNnV5MW14N3RzQ1lQMVVOOGlvR1VQV0pUa2h5RnB5M3Ra?=
 =?utf-8?B?bTU0aHJtcUZ2UVUyMlVleGxDd01lVlFsdDVtc1o1OFZMSlU0eDM0U2pFczV1?=
 =?utf-8?B?K0hGbmJaWU5qaE5BSFRzZlhFZlJQeFJWSjljVEVkdlNCOSttRnM5eXNHZmR1?=
 =?utf-8?B?NG5DOEFBMnFsMjBsLzczNFZHRStPSWNVTjdOWG1pK1E1aitRU2R0aFRVVUNC?=
 =?utf-8?B?TzRxSmVtODc1VWNHRE1XSjNMcHRsU3NwSGNuQmx1MFBNRFowSlRVZHFYTFAy?=
 =?utf-8?B?QlJKWm4wa2d4K25ETnRYYkxBM2V4NmlmdTVUajRTWWJ6UldLYVhzc2dZTVFF?=
 =?utf-8?B?aXY4a1l1UHJubFU2TEhPMjgzKzNGc25DVlpMU21YUkI3VEFDcTFEdHplQ3pP?=
 =?utf-8?B?Wmc1WnErZ0ZKU2pXUUlWUU02MnFvbDFaSjMxdFIrRE4zOE9TZEJzdE1xVURB?=
 =?utf-8?B?aVVuUERxRHhFMVA5aytldXA2ejlkM2lCb3pMZ0ZwakZjaGNTK2lZS2hiWGtv?=
 =?utf-8?B?MFkyYVh0VDE1RHFJUTQ0ODUxMDZXc2hQR3kwZEgzckQ5VTV6TmNFSm5PL01a?=
 =?utf-8?B?R0NQRzJVK29NQkdaUnlsdGNOeGxPbWIvTDlDWTg1WWppWnlkZWM0ZGdKYzNm?=
 =?utf-8?B?VFkwdG8xRzVqejNYRDVudGVyZWlYd0ZqRGVTMXEydzlUc3loY05sQkRsKzlE?=
 =?utf-8?B?S1lnSlFkNHYzaGVWV1JTck9LUWE0R3dDd0xHOVN2bzZ0UFliRjRlbzYxODAr?=
 =?utf-8?B?Q2xVTk9WS3RndkgvclFVUlZ6NXF4dTVna3UzVnNOdnVGQWprOWc1WWl6K21z?=
 =?utf-8?B?ejl1bCt3dFpRVWFaczJadWxNMkhLVmEyN29FK2JqY1dWd0RXUDdlZXlvZC9k?=
 =?utf-8?B?bW4zV2hMdEZ5bzBTL2RMQkY4TW42RFNUMVlpcC92Y3AvSFlGZm81dmdGZlJu?=
 =?utf-8?B?UFpIRytneENYUHY1S01NdU9iKzhBcXRuU0k4QWI3WkduRmVtZWNRNTNYZmJl?=
 =?utf-8?B?dEhwQlAzUTJzYjNTSkN4NStBWmZYWTJVcWVVbjM5b0lRdFI2ZFBoVHEzQXFP?=
 =?utf-8?B?UEdMdWluNHRTVVo5YVYySitSSU1NU3RLRlBZbmE2TWVxdzVOZWc3aXRjdjF4?=
 =?utf-8?B?SStnamhPcktQQkpHVGlLNXlGaGk4WWJGeEtUV3YvMFcrTkYzVTBwcEV4VDBo?=
 =?utf-8?B?VUpSei9GMUxoaFVWOWhlOTBtMW9HUWd4VzhyNzRVQituZ1NFZ3R3UzRkeGho?=
 =?utf-8?B?dktvSU5YNGZZMjAxTHRqSnF2eTM1WXlmV3BhS2JlN25zcmFPdWJNUERrcTgr?=
 =?utf-8?B?UEZhY2NqSVFyQk5mK0VTaE42UnJja2hYdVJaa0J3WFZlS2RJaGdkaHZ1NjVB?=
 =?utf-8?B?cHAwWHQxdkM1M1hiWjNoZXJ5MzVGeGFLc0tvbFlRWkVvZWUyWVhrbzdWZ2FY?=
 =?utf-8?B?WmpUODdUZmdIU1BodllHYTA4ZlQ0TEdQdk5GaGZRaGpGSG4wUzB1cm8zbVhQ?=
 =?utf-8?Q?h6CifsxEs46fWSdJBHQGkyO2Oi428zeR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azFhVTZIQjFqUU9WY2ZoRytsbDF6T1dvRmh4NHQxVkhUY1lvUHMzeEZaVWNB?=
 =?utf-8?B?bTE5Ti9mQUNHT1AzeldjUkpEbDdEZWovVEpjRm4xRE1lT2hTdmNLZHk1Wkky?=
 =?utf-8?B?Y3IrelFxcTlyaFF6aGVWTjdKaXJVWVVxNWdsNGtzdFo3UHA4Mk00R1lkUjdC?=
 =?utf-8?B?ZWdqTWsrOHJTeW1aMXhua09ZMHFPLzZ2Qlg3THgyS0U4WWQ1UG5vbGRRZjVm?=
 =?utf-8?B?UERUc0tvZnZDM3QwNFQxZlUrSktwejNlcE52OW9QK0lYbDFsRmpPcmNabjg0?=
 =?utf-8?B?Qm9wcDBtT3hVNnVJdWFzU0hWcTlxQ1N5R0MrUW91cG9qdkpHRG1HQWF3eWl1?=
 =?utf-8?B?YmtRRUhOeVlQYjcxTFhPVzRyMGUxaWFFMlRiVXJrTFdCeGQ0ci9QQkd4YXA4?=
 =?utf-8?B?M3N2ZSt4ZW4rMFcvbTdUUVVDWmhTaFJ2YXZ3TGlqUDB3Zm9odG10NUFtUHdv?=
 =?utf-8?B?QitsS0lnYmprZ0c3MnBoN2JVTUtmeVprK09GZUltRGt1WDMzbWRtbzM0VEYy?=
 =?utf-8?B?Z1ZocGZpNVptTDluZnJLOWRvQmx4TGhadU1sNjdCbnAwaDljb3pzaFV0ZGFC?=
 =?utf-8?B?N0NCaXpnVDRPMDFtTUZBQ0tnZ2w0SXlYTnZqVC9ZZWFXdW1INEhldmYwOHM0?=
 =?utf-8?B?VnJzVHQ5eWYxUkJHOHY1anREYmtjMkNVTitYMmRUd1RWdGFqL1pmTk1ubkpt?=
 =?utf-8?B?VWQraEJJK01NN0o0cmFoN2JVZEcrYmFSOTUwZmE2UkZaL2I1K2JpTjZhd3Vv?=
 =?utf-8?B?ZXZOZHZvd0tOWjludE9oSC94di9FQVp4WkRIenY4THk3M1EvT3lBRkl5MzlF?=
 =?utf-8?B?OHhpVkVxV0N0MlJBYzhnN2s0d01ocHVjN2dpd3NSTDlEaEkzMnlIQ0N0WHlY?=
 =?utf-8?B?TUhFb3huWE9GQTJoU2hVc211K1ZYV1BuK2thL3NJWDNjWVJ0STRjcXhVTkVi?=
 =?utf-8?B?YTJiRUJkOTYvUm1FY2NVdi9yZmxFSlprK0pDT0dxZlBDUzJiN29ieGhuUDhB?=
 =?utf-8?B?RlI0aE4rbkVsQy8zem9LeHJ4TWowc0hDRCs3VmtiSE1VTDZINm8zS1dOQlIz?=
 =?utf-8?B?aVA0SUVTbkNsci8zWTBadDkwVnNkRUZKbDVzanpiMkRHZ01RWmlDd09XQm5R?=
 =?utf-8?B?b2RPaVRPdnRmZjJxeHpSb2JHWUhEd1NSOS9YSmVDK21jeFRIRFl4KzVlT2Vm?=
 =?utf-8?B?VTV3ckFEUHR1VEFxdzBsTUdiYjFqclZxT0RqNTFQWTdrZDFQVUpPbmYxVFds?=
 =?utf-8?B?WmxMcWJpcC9iWjVYY2lZQ1RzclFyTlAzRXpkOHpqcWp2b0RPMkh3cmV2K2xz?=
 =?utf-8?B?TmY5ZnJiaUhXTjcrQmdNcVgwM1F4NEpnb2ttcDJDR0MxdVY5d0NsdjhLUGtT?=
 =?utf-8?B?a2RlcmoreDBKZGtocUdFTE15M200c1pIemlhRXlqVTZLRnZqbklocGNGTjNk?=
 =?utf-8?B?OGVpUmFlRkw4T09Mb28waDFzS2xJWkJnQVIzcWlqOVRPVXNqSFlYTlJwQ2lW?=
 =?utf-8?B?dEJtNVVmbHY3elUwTTc3eUpLTlBJc09ENUdQZk02ZVVUdVJsVHgyeVlzVDdY?=
 =?utf-8?B?VmRkVWZjdTF4Zm94ejUwcXFweHF1SEFLSGlvL0VvVE5kbk1UZlRBalNpb0dF?=
 =?utf-8?B?M3dYYzhpUENGS3ZzZjYzUVdkTVh3TkExdjZsUkhnRnRhSjlmTTYvTTNGQStR?=
 =?utf-8?B?MmxmeEMzZWd2OU5XT0NMaEpHMkRHYjk0akRnVmQ1ajl5L0RPMDljNHovMm5l?=
 =?utf-8?B?Ynp5MStuWDBIdzJ3RTdxOVNwUklhRDNadzYwN2VMY1UvY3BoY0hyb3B4ckZS?=
 =?utf-8?B?b1VtLzRSbXpPbmxOUzJSRVNTTXg1THJVVHNlTm9mQkw1NmNJelFjcVp2Ympk?=
 =?utf-8?B?ZENUMU85U1RWT3R0V1JZME1kOThZUEVKYTFoTTJpVG1yRWpUcGRoZ1U0cDgr?=
 =?utf-8?B?cU8wNlc3Z3AwQkJEam1vdlJZeFo5WlBWenVFVmVvTEdONFhMYnZndzduL1V3?=
 =?utf-8?B?RFY0U0NDQWE0RHlrclRiK2xncU1pN1BPeFFEYVRaS0d3MW5zSGNHc1ZPalFx?=
 =?utf-8?B?SVlLa0w2dG1oSi9PditTbm83Kzg0Kyt1TmlUcERSYk8wS25LSm84bm9iSjVw?=
 =?utf-8?B?cjBPVllmajc2a2RHSzJYREFzeVNVWjFWU0krNkdNMDM0MTVRby9uVTlRR3RS?=
 =?utf-8?Q?+WFRhRr+A7XBQuNSbr4cPaA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a656497-222d-4e69-adb0-08de38a29561
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:46:47.6189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcpIKCLqYR+zl739rMzPL5opJvhm2WlSS+OlI2J5JbxkA5nFwV6Z2sPjgdhGD6kCsLKozPK2LV9zKPZAS3h2QZLLrMKf73p6dTh16uZlKD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11210
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

Hi Peter,

On 12/9/25 10:03 PM, Peter Robinson wrote:
> The pinctrl settings are now upstream, with the upstream
> voltage supplies, and the HS200 mode is confirmed to work
> fine but the HS400 mode had reported issues so let's just
> consume what the upstream DT has now as it's all known good.
> 
> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> Tested-by: Dusty Mabe <dusty@dustymabe.com>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> index 64c43374c04..7e24be1a5e7 100644
> --- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
> @@ -12,14 +12,6 @@
>   	/delete-property/ vpcie3v3-supply;
>   };
>   
> -&sdhci {
> -	cap-mmc-highspeed;

I'm assuming this isn't "necessary" since we have HS200 enabled? It 
isn't part of the upstream Linux DTS.

Considering we have HS200 support enabled in both SPL and proper, it 
should be used, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
