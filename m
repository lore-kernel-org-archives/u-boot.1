Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E19C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA39889EB;
	Tue,  6 Aug 2024 14:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FirXuY23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD03188A1F; Tue,  6 Aug 2024 14:53:54 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5BC87DDF
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqN0VWUQZN/REtnnHibSrx8Tl0xS2IErDE6sb1/DiHanHSTie22OcBy01shGuLLGexcbLnwa3hXfQDFbMk6XGjryh9pzZrraAjCnpeiBjZVtJJDdk+/ErO44cmGOhuucDxeT2wOZ3grWu96Ny4c3bzcezuk7MsU77Z98XVlnyEj8I2GxWDMnhJK67nOuxODChJRLS9SbZgf1l1c/fPZ/I1SPn9E6SaUK06Js86rQfbCYRmSFpP/XC4BBA5RiiZo3gT0cfEFqyD7Cjc6BBndK/to7OVGdd5mcRPrWRNH2GHXC2LoPTMT1eBN76U1/HHphnMo5aj5nprzs5uiyP8XYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgWkh5bkMfKofmuoY6BL8oP1Z2WCoBXmN+fk+0C/FI4=;
 b=semO0XyLyu9xbJ/X0D9oPoLrb6gH1CuZY9jzS3gZAEFqSJDtjQF1FsgaRHyPr7GEvPltq/ebR1F7UHBoAavesQG2feySN8DfA7MOJXrpFSwrKP0oILnYqh1m8uzYGkOlPBNySjIs0GQ6gA3tEAnXf6akenjV5KoiITE4HHCDQM0OaS7MAxQO0wWdwhxYKOQorz9xrEs8YA8dj6KncyjAvbS3BdVhyIkGLf885cTvu9OKLpMOF3vF3cEGFVAeiq88fuNSLUzJdFXTonr47u5viUObA6U4BQKwWx6E4QlctVh2mrCR0toJ45xOdHBd2Rej/rz7qe4kaSeKWLttXajGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgWkh5bkMfKofmuoY6BL8oP1Z2WCoBXmN+fk+0C/FI4=;
 b=FirXuY23HQJ/6zkUrc3yWgWFZZoBdA3nlym7VU+d6m6e5nAHBGDpYHo2aEjZVk8b2YCY4jtkqPXAmXxXHWOto0JchQ1GDI3IfD5Y0depepBWETQn6LFDFqawuB0410LcFL1EWe+nNwql0fbnMEIMrGFroHcf8SsGvbkuQjjtq7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:53:41 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 12:53:40 +0000
Message-ID: <9bfd2fa8-c330-4d93-9d69-6ab76fabc7d8@cherry.de>
Date: Tue, 6 Aug 2024 14:53:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: Use files from dts/upstream
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240725094609.3113632-1-jonas@kwiboo.se>
 <20240725094609.3113632-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240725094609.3113632-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: f8441b9f-a182-4173-ab7a-08dcb616cbf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N29pWlVPNXFqejVwRHNoTGZsV2wwV1ZIajZuaU9tdVI0Y2o5c0JOZFN5YVRE?=
 =?utf-8?B?TWdaRUtzcEpCMmZEcDVOdGlObit0QXVZVTJZR1pVb3JaanEweFBMMWd3a0c2?=
 =?utf-8?B?cDNvUitIUXVlSGJidy9GdmVvWXRJbUpCRnVwRXNCY3E5azlxZ2ZtOTVYZjBN?=
 =?utf-8?B?K3dsOE1RSjZ6aENBTmVDcTBvbzFaMkZ0bEZTQ0NKR255bDJ6VHVkaFpQc1JJ?=
 =?utf-8?B?Vm02UWdGcU5kY0wyZW45TGpiTXhPeTlydEpkaHNxNngvQWtWMVp3OUJKUjl0?=
 =?utf-8?B?WmJicEVaS09DQ3pyS0Z0TXM0YUFqVWZYZUFRc0EwVWNSWC9OWlVzaGtObHRy?=
 =?utf-8?B?Sm02d3U5RXhGNVYvWlgwanJWbTMzNlVJb2dJN3JCODJnMWNFTEozZGZvT3JL?=
 =?utf-8?B?TVFuTzViNy9HaXgvWWtDeVZCMFZmanVXejlBNyt4OGVZMFVOOFJSajZ1OHdG?=
 =?utf-8?B?cHVzTDB5ODdaclY1ODhmejVNUzg0eEZIM0V2eFBPSHNJYWZJYXR6WEpVcStU?=
 =?utf-8?B?UjFPbjBCcHAxVkZJRWIya0t5azY5VnZydTlBWlcralVsUDI2U3BNZ0dsQ1Fw?=
 =?utf-8?B?anJLbVlPa1JZZzAyOTJLNHVIY1F4UXJXN2pWZ24yWHVNZk93VytJTFJDclk3?=
 =?utf-8?B?NXlHVmlKVXNveTRPUytaMkloakUrNTM4VmpsekNiemlWM3djZkFsQ01SdEpz?=
 =?utf-8?B?cmwybG4xbkd2bGg4NGs3bjliTDlBK3BzN1RFMnRIZG5SdzVRSTlRdGt5c0xq?=
 =?utf-8?B?NzkvVHdDV0VOcEpFdWxDbk0zS3NhL21VS0J2VjA3NjU4R05SYXVSdmV4TGI0?=
 =?utf-8?B?SU1WbHJVRFZOeHllTXRrWEJJd0t5eHh1Nk9mT3cvaHhERnpLR0NxMzg0TzJk?=
 =?utf-8?B?OHJYb081M2JNdHdxb2hiUEpUYThXSXZ2WE1GV2tvTUlhRWx6cEM0enUxcGlL?=
 =?utf-8?B?d1haQUtPNnlFckhjVU5HNkQrY2N6aXJpZVlPU3Y0eHJ0aUxZenpyYlBVSjBH?=
 =?utf-8?B?K0pUZzN6OFUyaE1YQnMzVDdMV3Y3UUVYVHpuZ0pDTlBZZ0thS3dhcmo0bk9O?=
 =?utf-8?B?bGdYMHZTS09ZZkRHOVpzMmZXKzJVd1hlUTN5OUxEOEhMUUhVYVdhUFJXMFZ1?=
 =?utf-8?B?WWorTS9wbE15eTdaR1pDVEYzeVRMK21MN00xVXE4UVhhTWVpam1wUDAzc0w2?=
 =?utf-8?B?Y0hjQ2pyY0JFakVtc0ZNT0VZTERjUVp1T3BTZy9vdDU5WDk3bE16MzV4bTEz?=
 =?utf-8?B?YlpSOXUwbVN6T2pNbVU4aXFaNTh5YVlZK2V1VUxQb3pyWWlWcnRROWFkZnI2?=
 =?utf-8?B?VDViNnJ6Vnd0KytCOUxXUy9SclZEUGFVMkFaTHV0Mk5XTnVpUmRLNUhiOS9P?=
 =?utf-8?B?MElGOXFyS2NnNnQ5UnhsWUdTVEZlaHNGTlB4NlE1VlVFQlN0VjU2S1I5VHBC?=
 =?utf-8?B?YmRMclNORWZBZXh4eS9XY1RVK09iZjc5ZGovcE5sK0o0cFY2SlJreUJkUXFj?=
 =?utf-8?B?aVJsWDVzbDlGWlZwNmtkS0RZMmlkSExsMGtzQ2dTTktQbFZFbVdsT0pDck9M?=
 =?utf-8?B?aHFreG9tQUFxamNtQ2piQkFscVZ3UFREcjZyeGg2ZlJ3Zy8zZkFrbFdTUE1V?=
 =?utf-8?B?dG5pcEI0cmV6Qyt1VVZ1YXFDNHcrYisyMzdPSG5qcStFaGdPZE1TUUxrVndn?=
 =?utf-8?B?T0RRTFdMTUVqZVUzekpadHA2cnp5cUcwWStBc2pNa2ZGZ2NLQlBkM2dXZTJh?=
 =?utf-8?B?cTlDTCtkb0t1MDY2L1o4VFlFNjZCRTB5SiszM0Z4MGtkNXBTRjJ1aVIzcFU3?=
 =?utf-8?B?cVJUY1RLdmJpbTh4RnBKUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWZUazA1L1dwdkpTL3NhZURiVk5qcGFrZTgzSHlNUDNpWFJERmZqajlkYStP?=
 =?utf-8?B?d29Bank4bENic2pjUDBWTzBPZnFXOGRNRFBrL3hUN0ErWlplNHdiL2dQZWdQ?=
 =?utf-8?B?Q2R6ekFYVStPaGxGaVpteDJ0S0ZnMFlPT2xDOEgyMXcyQjdISHZjZkFLeE1y?=
 =?utf-8?B?K3pqeHNQNVhDbzVTSm9XdWYzeE8xSU9lMytKOEFMckdpZzJJS0tUN0pzcmEz?=
 =?utf-8?B?Znk2MXYzL2Y3UlJ3K003YjhYUlBuMVU0QmozS1FIZWE5eFJRTHBhWmxCOElL?=
 =?utf-8?B?QUJNWGhkV1E5YmU5V0pRcW54YkIzaFpQZ3l6L1ZKeGVoMkVCVURwMUhVNG1D?=
 =?utf-8?B?RUdFNmFjQVp6UU9TVjVpQ21GenBPc1BzQWZDcHdCMWwxQ2pBakhyRFVuQjBa?=
 =?utf-8?B?L09HUTlIR0xDQUU5NkRDWVRuZCtHR3oxY050dzBsdWJtNjdUSmZDWFM0ZU04?=
 =?utf-8?B?eDMvbUJxcFJoc0VMWkhBd3pTSmtOYmFGSy90enRZaXNuV2JzR3RidlFGck9a?=
 =?utf-8?B?bnF1K2VKYkY3QjJvYllXeWxOT2NiS0RzL3JnZ2xwR1J5amJJbHJwc3BPakdW?=
 =?utf-8?B?WVZpbndkSXM1cXBQcm05YXdvTk5YcW45VTZFc2hvclhORmxRZ0hiTUIyV3FK?=
 =?utf-8?B?ZXRpR1dDRzJWVjZuWWltKzhzRnhMUHBDSEx2eHdMaEZWbUF2MHJuWkNmNVE0?=
 =?utf-8?B?NVRVcno3MlNIMk4xcFlSS0M0V2NBeU55RmhyVTBlTTdaS21jNHNXem5iOXUy?=
 =?utf-8?B?ZERWK2VBZGxQUkFTbG1QeXhsYkdoVXdkWkVlQ0pQRjNtUGRqUktING5iTDdS?=
 =?utf-8?B?bjhUb3RuTFkzakt0SnRTZitmTTdrOXRmNDYrdmpldU5MS2xScGpCS0NtdHJx?=
 =?utf-8?B?UmI1eU4zWjd5a2dabThueXhIT0dOd29SRGR4ajFWaW4xK0JJVngvMWJIbU5J?=
 =?utf-8?B?UWxkRE8zWWRWNndUa2l4SENOS1RTU2cxUm54YXBkM2g4WHgrWlMrZE5XL042?=
 =?utf-8?B?bW1Ic0RHdEM5ZXJ2SFlFK2U3cU02a0p1bkczcUg4MGFmZ1lzSXNhT1FYUDdh?=
 =?utf-8?B?R2lzUmlUV25TTU9wOEpoMmlDSnJCUVdTNlFKUEh0dHZxT0tQVmZkR0N1a1dp?=
 =?utf-8?B?VDNiSCt2U2dFQTVVOUc2ekRQQ0NLL3czUjY1cUFid3ZqUVE3T3JjMDNqRWdG?=
 =?utf-8?B?Z0NjWWVJVHZ6MnB4L1hHZVhrUXpzZEs2UjM1cmJyNEsrRFEzWVdEaHd6bEdF?=
 =?utf-8?B?RVlHWGV0SFlDU295bzR4UEtHMU5LWlBKMnFYNjNyOTNCL0NScGJLeXdXMS9z?=
 =?utf-8?B?dlU5U3NEZzBlVUhCN1dLVS9wNHI0VVpsa1haUGpGdlNxOVMrclVUSVpkYVU1?=
 =?utf-8?B?VGI2QWh4bGRmRGovQmpBWjV3a1AreTkrdFNrZ051SVdxbE9OUUZLNlVoQTBh?=
 =?utf-8?B?WEw0czhOam95aWxab012bkl4U0hBa1JEK2hxSGo3aGdMUGZPdWMxN1l1WlVI?=
 =?utf-8?B?anlnZUN3cUU0VzBJb1REZHU2N1JsRTJKZ0VmckhQSzE0dVR2TFNCdjRzUC9G?=
 =?utf-8?B?bU9QV2w5MmJreWtiRDJMQ2JVNXJlNEMrayt3d1RFb3ptTHFibFZCRU1aSmo0?=
 =?utf-8?B?ME9wb0tOMk1henM2eW9ZOWR6UExEUlprKzI3aGVzcHN4Nm9pTld0Q1JiMDBa?=
 =?utf-8?B?Q09IVUdiRkJ4RDNDM1R6M25rdnFNQmQ2ekc0WEpwL2lCQlpEWUFtMlgzV0xC?=
 =?utf-8?B?ZXRCeFF5RWtlRlBnWnptYWlaZjNZNjB1RUZWOUlnbmN4Y0lWWVNKTkZqY3VZ?=
 =?utf-8?B?MHdJR2pEMGlNa2kwRDFJKzVEYXNKVGprdk9STVZnTXlDYVZzR1JMMjQ4cHJK?=
 =?utf-8?B?R081ZVdjMjJkaWFMZ0lyOHhTMFowSkJDTHA3Q3ZZUEI2c3dBV1drb29TaGJR?=
 =?utf-8?B?RkRIOThxRFpzTU14OURKNkZoT08vY0JlNWtnZk5Ob3hjWXkrNXlVNkd0M3R1?=
 =?utf-8?B?REYyU2dFbUNpM0s0MDRjQjdOYlRzdUNBcTJSYWZGc2d1ODZod1Z6Wk5FaFpE?=
 =?utf-8?B?czZDSUJhcWRHN0RhWHFxQ0NLYlhiN1B1WGtwWFRYME9hZjNqaFNNY2w4UytB?=
 =?utf-8?B?ckNUbHY5NkIvZy9Bd2puZ2g4UXhvWER5MmQrZEh0TUJVK29zQ0g5bG5UVUdp?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8441b9f-a182-4173-ab7a-08dcb616cbf4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:53:40.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XYjHS/SIyvmmK2zs6qOss1SoExBmcd4PY1wQ7TutMd33n+7zrt8YHi0GPR1TvuXWLqqPaC7OpejpPnjnFeqiEB0MDt01vpkT9VldSBurdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226
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

Hi Jonas,

On 7/25/24 11:46 AM, Jonas Karlman wrote:
> Most Rockchip aarch64 targets have now migrated to use OF_UPSTREAM,
> however a few of the old dtsi and dt-bindings files still remain.
> 
> Remove remaining common dtsi and header files that can be included
> directly from dts/upstream to prevent possible issues when future tags
> from devicetree-binding is merged. No changes is expected with this.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
