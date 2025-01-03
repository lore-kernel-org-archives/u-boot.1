Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B7DE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C740C80107;
	Fri,  3 Jan 2025 04:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C10802EF; Fri,  3 Jan 2025 04:38:20 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700BC800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jacobe.zang@wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBVugueH99z116YYWcbqrJYmeCHdYy3NFo13wUixTRE+cd+k3j2j4PaYsel/axFt8YhYcAkFxaYi5eyy2VpVD5xst+RhRKU2EtoXVgeOOMcsTeKDG3xBtJC0aSNx116Tc6dyqLFGkdtporX99FvLNzvsamHKsacBlAMRlzFfICxw4RvpzCaGrR86q/oBu7Scv5/HCS/kQ3z3nLCwn0JprbKtxjuVwqBqRvY8HDOH8MyL/zpgcgVycpde9iz4bMf58jzVTc0quKTVsvqoLhBbY1BAMw2obrz2P2wv2az+R+aYxf/0R8RukTSd8J6//iTjotgsC9++GptXh60D4aS3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8EpKm3dle+4O4NRggjc3gM330O6zawa5JXzON5gJcA=;
 b=vIgSPgaKTPVaALT1n9pdzUB6MdAaimaSQmSx9Q9TMW/eFy5oiKjMFCmDeFmZ+slh39VMIfaG9spR2XB1IMolhNX/DopKbxNmVW97uKWNj022v6aVPcI8iMyQfC3ZfV/fmYm9dOFLT6JvxslCDlLdA2rUDWsKRTw/OWYjNSHU79BzO2cCmgboNr33mhOccKvLxGFqGy7+VsmvHx5U6cEROhVLuEYUXE1IHz8BOAERTp0yKA1eWhhlpjqixB5u6rQrcXRFEYuyzLuivlBctQ/569TmoPBpnz2PB5ANTseY+whePQi1iUh3tGiQTrxVi2nSTjPKuru0oKS/Or4+x1Ioaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB6451.apcprd03.prod.outlook.com (2603:1096:400:1ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 03:38:12 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%3]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 03:38:11 +0000
Message-ID: <3be3cb19-fcde-4830-879e-53a4ff4d3551@wesion.com>
Date: Fri, 3 Jan 2025 11:38:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add Khadas Edge2 RK3588 board
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, nick@khadas.com
References: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
 <7c6bdb6f-e093-4572-973d-63c17059da41@rock-chips.com>
Content-Language: en-US
From: Jacobe Zang <jacobe.zang@wesion.com>
In-Reply-To: <7c6bdb6f-e093-4572-973d-63c17059da41@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e86dfc7-db84-43b1-97ec-08dd2ba80c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGpvb2VyamlWWDYrR3RuR25DSWs3ZkU4NWFjVUxPVnZSTmk2bVBRYUhMSGlo?=
 =?utf-8?B?R20yRUJGa1lacWtFUnlPcjRVQ0FlVWI2R2kvQmZqYVI5akw5Z3ZHZXVQKzBO?=
 =?utf-8?B?WUNuMkhIMUNpY0RTb1JKUWlTZllBN3FNK3NWSERwMmtxVC9McFFVK0tKZXhD?=
 =?utf-8?B?VnlJUk5RTEM3YnY4eTAybVJRRkNUZjJvbkxYaTAvSjdpaS85bksrV3Jha0ND?=
 =?utf-8?B?cjVyd3RyMmg2MjRHVkdGT1BNb05FbUt2Ti9GdzRqZUgxbHJIbTZxZVZFOTVw?=
 =?utf-8?B?S2tnRjNKZjF4OUxXeHFVbjF6U2k1RGNUK0NKSmpXaTdSY2wxRGlHNTgxZVBo?=
 =?utf-8?B?UTJ4eHphZytQczJaUWlkWi90L0NvQlMxd0RZMUZEV0dUVkJVZ3NVRk0ySHB6?=
 =?utf-8?B?cEN5UWI2eXU2TWxJQzRiTVVYL1ZqeDR6TVdhZitUK1RDOUtKcUsxSjVTaXVM?=
 =?utf-8?B?WHRYUzdySCtaTEY1ejdpbVd2QkdzZzRqSERrZlRicC9PMFRrMWRaV25PT2Nt?=
 =?utf-8?B?YzU1cFNnYWFwck51M3J2UlYvUzdGM043TjlOTi9INm16WHMzWkJrcVVQWXlp?=
 =?utf-8?B?R3p3V1RqYnM1WHNkdTgwTjUvUCtHaWNvd09mNzE2RXQrZHNXRGtJTGs4aDhq?=
 =?utf-8?B?Sk5qM2hCVkJSZ2JQNDlneEdyTEtzbkxEc0x0cXlBWnJkOFRKcU9zSm9ReUN0?=
 =?utf-8?B?aU1nVkhmcmhwdzRrb0dRU3hha2RlR1RHNlozanp5M05FTXpKM1JyMXFVd1Vp?=
 =?utf-8?B?clQ2TkhWTmRTQ285VmpOVmcyZ2h4ZUlJeVc5bHJPdGZQNzRtMEhRM1J0d21u?=
 =?utf-8?B?YnlLbFdVMHNIcHpqRCtZN2c0c3NxMlRhV1VLb1NWVXpjSWx5ZjRHZms5dWJ4?=
 =?utf-8?B?b0ZoYm9XOE14ZXkwUmhCRmZ6MDNaMzlveFozeFd1TVhCcWpHYlFVWXBBVkhm?=
 =?utf-8?B?dUdYem5tSnZxVVdhQ3RoY3VBRDlFMkVWeXczWXE1TWs4cmhwNFl1Qnd0azVC?=
 =?utf-8?B?a2VqRnVmZGQrbFV5bFcxVHoyZXFuWm1LeGNXeFJqUkdRbWtZQ1FWL2pNZGJr?=
 =?utf-8?B?aWVOUThuU3JtLy9ZUVBlazNJNjZyMUNRT1JXQzJXYmtwQno1RllCWnorL2dK?=
 =?utf-8?B?bmdwNVl5bVhKN2V0cWRvcEN2WG5kdW9GeWFGMHFWczZpK3hhNEFRcW9HUU9C?=
 =?utf-8?B?d053SUExNVZKYTVac3dGQUFzS2NIUG9WLzZwZUJZRXIrQ21LT0JqZ2UzbjVR?=
 =?utf-8?B?aEphNlMzNU15c2RrZGR6NnU3RFozRDZEazdEamtUSm03NEtiK201azN3VmVB?=
 =?utf-8?B?bmFnK1hNaGN4TG1IYWhVcGU0WExqMVVoNVNIdnFhT3hjUXEwYXgvakY1YnI3?=
 =?utf-8?B?VGhQY2hGL0tqWlBoMC9XUUErUjFsUW5YQk5ya3dxVU53OStRSXdrYVQ5bzhX?=
 =?utf-8?B?OStkNDNubVUvQ0JlQkowbDE0Q1hIbUc4VUY1T1VHNkx1VGtwa0U1RkNNam5w?=
 =?utf-8?B?ZWlZQTRwSUFuS0JTUVBRZENxZWVWUDJHbWFiVFQzL1BEMWFzUi9JZzA3YlM5?=
 =?utf-8?B?SWc4RUdIdlFKd0pmSHB2TGh2Zm02UmZHdFpHUFZyTXVnWFNiYjJVOHlLSHd1?=
 =?utf-8?B?N2RWdm9KYkhXQS94TWc0Y1lhWkRjQ2tBeVdQelNFSWxLbnlRUjlsN2RxZ0h5?=
 =?utf-8?B?REpNZzduSkVQMW5jdWs5VFZ4YTFZa1Q0eXUzekZCcHlhYTRFQTJpSC9SY3Rj?=
 =?utf-8?B?UVdwclhKUmZ0QTNPY2FETm9id3NPaUFNeFVIN0xaTTFGQ0V5a3NiR2w1bjFK?=
 =?utf-8?B?NVZ5UU54SmQySExkaXpzdDJxSDNTbHkwNUI0MVlOTUlJWENUajZOT1FaelFK?=
 =?utf-8?Q?Y8+UjUmvckNPI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR03MB7001.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a09KQVBqdFpUNHZZSkN2RlQ4b0ViUGIwYTN5cmhrR0UycEVzT1VzblJyZFZy?=
 =?utf-8?B?dTVIRWF5NkpGNWx6Y0xrNHhSNm4xV2J2YUI0UmtYWGxMNzBhTGJ5UlNYUzlv?=
 =?utf-8?B?S2RJcW16Wmw5cGtZUC9KbUtJVk1UZ0k3TUo1Z1lFelBqandoNXVNU0crbVF0?=
 =?utf-8?B?a0RsYkNscHUzZGMzL3h6TUNnTnhPRlNsZjNJR0I2eUlSZGo5S3gzeDVnaGNK?=
 =?utf-8?B?WjVEc1dGRkxkOXR4QWFoWmZkSkwxaDBPMUp2dEZPNTc4Lzc0Y3RnZnp6RDVw?=
 =?utf-8?B?UXRpcUlCR0s4Y0t1SGsxeHVUYmw3QTVNVVhyZ1h3c0p5YXk2QjN2VmUrNHA0?=
 =?utf-8?B?aXNtaVEyNWdyalZTMGxoeTVKTFBSNE9ZbFl6MFl1QWVBcVVHTkpHNTdwamdK?=
 =?utf-8?B?aTZlQXBlUGJQSDNKakI5d3dEaW0zVjQ5Q01yaHplVHpzZS9JdDc3eUxrbEQ0?=
 =?utf-8?B?L2NXTWpudndNRnlwUXV2ak5jRzQ3akpUNk5RakRNTVBtWFlxbytIbTdHMWFM?=
 =?utf-8?B?SkVYZjRaR05kNVlLZjFkNFRuMjNOREh0bGhFcVp6OW5vZWNSdzVJQ3g2L0NK?=
 =?utf-8?B?T0dSQVJqRGs2ak1QR2dseEtRQlAyRXBIRkVibENlYkx5SDhmYVgwN2tac2lN?=
 =?utf-8?B?ZXFRaER1QWdLTG9hRjNHUlVPNDAyL1krQk16ZUprcTFOd2xVU1RGNzAwTTY0?=
 =?utf-8?B?WmNleUtKYmlxNWZtMWtXbzAxTXZzOU5BRGhxRFdmbzkxMHBOSk1qbW54SDhH?=
 =?utf-8?B?M015YnJUMk9TaHFlelhPR0RwN1l6NzUrY3lpeDQveTltYjZvYU9CYjJOamxl?=
 =?utf-8?B?dHd2c0NXUzlnOUIvTEdEalE3MUNrSTdCQXVrSjE4aVkyTnBFdWFpY0JrQlRV?=
 =?utf-8?B?cGR5WEhmSVcybElzTUppOXhIc3N5MUx0ZUdOaU8xQUdZS05VSmRrOU0vMGpw?=
 =?utf-8?B?Z21rYUlVVG42UzlTTFpvdTRRNnNvTTlpNDcxYW5BUlVzbWdjbWdpOUpWVUFy?=
 =?utf-8?B?SnNBaWVvMEMrbHB3dUc0QWR1NG1hUmZkUDNwa0V2RE5SejFacTArMVd3UEcv?=
 =?utf-8?B?MGVvZHZveWRPOTQ5UldWZ2tFYituak16ZnlwcXlrdzVMaWIwTnBNeXQ4eFdh?=
 =?utf-8?B?NnlwYWpEbnM0VFN4OERZUFNYN0FHMDFqQ2liV1NNS0ZhVDlFVm5sOGtsS3Iy?=
 =?utf-8?B?UnE5cGR2VnBhU21hVWJOc1ZudjNpVmQ5YUZ3OENmaXlkZURtV0N6SmloR01h?=
 =?utf-8?B?MlNFbHJmQWlFejBuVjNhcHhGN1MzNXFHYUtmN3RDbHR3SkxGbXZrSVdzcXda?=
 =?utf-8?B?emg3QnpTZk5HUzFVWVc1Si94TUcvMGZGWnFtVVNqSFpOckpXd3ZSa3JxejI5?=
 =?utf-8?B?Vm1OM2NiU1FqLzNoNmtYQWF1YnFnOUN0Zmh0QjR0QVhXem9OSml0Mkk1NXZX?=
 =?utf-8?B?Q3NVTmM4YXExbWEyVWJqdEd3bksxRlk1RjFMV09XYk5xckNlRmtqL3luN1JZ?=
 =?utf-8?B?OFNGaHNLdGRpTkt4bkhUdzIxM21XVDB6bXJQcEc2S2lLM2Exck1URy9sNU44?=
 =?utf-8?B?MkxwNm4rN3doQ0ZUUG9Ed1VzZDVpblJMVnIveFdaVG9TU3RZaThFMHJPQ3Zi?=
 =?utf-8?B?a0NIK0ZhdVJHazVMNWU0SjZ1MlFnUDR5ZVFFU2d1TExjT2p2cFVEMGhYdllR?=
 =?utf-8?B?YjUxUmJ5SzJnTXo2Q1pNM1RMRllMNmlWWmE2TzhCZXc4ZlNtYUlGeVNDY0Zo?=
 =?utf-8?B?RkY5U3VJWHRxZUs2dlczTUxYYi9FWU5sSkpKTlVmNHNhbnorSDFENSthRllv?=
 =?utf-8?B?NVFDQmNtY0lhWVdBZldSQkc0c0RaY2ZVMUFqUWd1RHNiNFcvZUdweXNsMU5X?=
 =?utf-8?B?UlFpcUsrcUxuaVlxdUVIMHUyK3R5dmdxbkZrOEZzNHE1UG92L05tS1lOUjQ3?=
 =?utf-8?B?NGJyMXZRZi9TOTNUWFU5bHRsTU5DSUk4Y3I0Zk1wbDcvM3NMenBRNnhSdGVp?=
 =?utf-8?B?Zm5yN3hveEJrSFVEb0I1V2JwL3RHSldaMW12alhDdi9ONXYwU3diazVaeDlO?=
 =?utf-8?B?RDRNU2ROOCtVRGZXRjVKRlg0OXRRVWoxMEZmUWRrMjJqSVRhdXJnMDRQMy9I?=
 =?utf-8?B?THdZUnZmSGdvRCsyM0hiUFkyWUpmb3g3MW5MSW05SWdLRU5lblFENENkVEVx?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e86dfc7-db84-43b1-97ec-08dd2ba80c3e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 03:38:11.7323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1XP7S4n/PYGqQ2XN/ialwtyWQ1Yr+pUoB9A+P4YccGLqrqhywRWaqr9DwPZaTPOo7bOCU3mk4FAeKKysC3sMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6451
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



On 2025/1/3 11:24, Kever Yang wrote:
> Hi Jacobe,
> 
> On 2024/12/4 17:45, Jacobe Zang wrote:
>> Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
>> by Khadas.
>>
>> There are tree variants depending on the DRAM size : 8G and 16G.
> 
> So this is two instead of typo three, right?

Yes, this is a typo error, only two variants.

> 
> I can correct it when apply if not other update is needed.

Okay, that couldn't be better.

> 
>>
>> Specification:
>>
>>      Rockchip RK3588S SoC
>>      4x ARM Cortex-A76, 4x ARM Cortex-A55
>>      8/16GB memory LPDDR4x
>>      Mali G610MP4 GPU
>>      3x MIPI CSI 4x lanes
>>      2x MIPI-DSI DPHY 4x lanes
>>      32/64GB eMMC
>>      1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
>>      1x HDMI 2.1 output, 1x DP 1.4 output
>>      USB PD over USB Type-C
>>
>> Kernel commit:
>> 04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")
>>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> Thanks,
> - Kever
>> ---
>> Add support for Khadas Edge2
>> ---
>> Changes in v2:
>> - defconfig: Update defconfig made from upstream
>> - Link to v1: https://lore.kernel.org/r/20241119-edge2-v1-1- 
>> b10c5d7626ca@wesion.com
>> ---
>>   arch/arm/mach-rockchip/rk3588/Kconfig         |  23 ++++
>>   board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 +++
>>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 ++
>>   configs/khadas-edge2-rk3588s_defconfig        | 146 ++++++++++++++++ 
>> ++++++++++
>>   doc/board/rockchip/rockchip.rst               |   1 +
>>   include/configs/khadas-edge2-rk3588s.h        |  15 +++
>>   6 files changed, 203 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach- 
>> rockchip/rk3588/Kconfig
>> index b5a0e624a53..7d817e7f1bd 100644
>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>> @@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
>>             - fan controller (AMC6821 emulation)
>>           * 80-pin Mezzanine connector
>> +config TARGET_KHADAS_EDGE2_RK3588
>> +    bool "Khadas Edge2 RK3588 board"
>> +    select BOARD_LATE_INIT
>> +    help
>> +      Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board 
>> Computer)
>> +      by Khadas.
>> +
>> +      There are tree variants depending on the DRAM size : 8G and 16G.
>> +
>> +      Specification:
>> +
>> +      Rockchip RK3588S SoC
>> +      4x ARM Cortex-A76, 4x ARM Cortex-A55
>> +      8/16GB memory LPDDR4x
>> +      Mali G610MP4 GPU
>> +      3x MIPI CSI 4x lanes
>> +      2x MIPI-DSI DPHY 4x lanes
>> +      32/64GB eMMC
>> +      1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
>> +      1x HDMI 2.1 output, 1x DP 1.4 output
>> +      USB PD over USB Type-C
>> +
>>   config TARGET_NANOPCT6_RK3588
>>       bool "FriendlyElec NanoPC-T6 RK3588 board"
>>       select BOARD_LATE_INIT
>> @@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/ 
>> Kconfig"
>>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
>>   source "board/hardkernel/odroid_m2/Kconfig"
>>   source "board/indiedroid/nova/Kconfig"
>> +source "board/khadas/khadas-edge2-rk3588s/Kconfig"
>>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>>   source "board/turing/turing-rk1-rk3588/Kconfig"
>>   source "board/radxa/rock5a-rk3588s/Kconfig"
>> diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/ 
>> khadas-edge2-rk3588s/Kconfig
>> new file mode 100644
>> index 00000000000..dd7b6cd8054
>> --- /dev/null
>> +++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
>> @@ -0,0 +1,12 @@
>> +if TARGET_KHADAS_EDGE2_RK3588
>> +
>> +config SYS_BOARD
>> +    default "khadas-edge2-rk3588s"
>> +
>> +config SYS_VENDOR
>> +    default "khadas"
>> +
>> +config SYS_CONFIG_NAME
>> +    default "khadas-edge2-rk3588s"
>> +
>> +endif
>> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/ 
>> khadas/khadas-edge2-rk3588s/MAINTAINERS
>> new file mode 100644
>> index 00000000000..3f16923b0f2
>> --- /dev/null
>> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
>> @@ -0,0 +1,6 @@
>> +KHADAS-EDGE2-RK3588S
>> +M:    Jacobe Zang <jacobe.zang@wesion.com>
>> +S:    Maintained
>> +F:    configs/khadas-edge2-rk3588s_defconfig
>> +F:    include/configs/khadas-edge2-rk3588s.h
>> +F:    dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
>> \ No newline at end of file
>> diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas- 
>> edge2-rk3588s_defconfig
>> new file mode 100644
>> index 00000000000..bc9e8f39ec5
>> --- /dev/null
>> +++ b/configs/khadas-edge2-rk3588s_defconfig
>> @@ -0,0 +1,146 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_COUNTER_FREQUENCY=24000000
>> +CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
>> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_SYS_MALLOC_F_LEN=0x80000
>> +CONFIG_ROCKCHIP_RK3588=y
>> +CONFIG_SPL_SERIAL=y
>> +CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>> +CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_VERBOSE=y
>> +CONFIG_SPL_FIT_SIGNATURE=y
>> +CONFIG_SPL_LOAD_FIT=y
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_SPL_MAX_SIZE=0x40000
>> +CONFIG_SPL_PAD_TO=0x7f8000
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_SPL_SEPARATE_BSS=y
>> +CONFIG_SPL_MMC_WRITE=y
>> +CONFIG_SPL_MTD_SUPPORT=y
>> +CONFIG_SPL_ATF=y
>> +CONFIG_SYS_PROMPT="kedge2# "
>> +CONFIG_AUTOBOOT_KEYED=y
>> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
>> +CONFIG_AUTOBOOT_STOP_STR=" "
>> +CONFIG_CMD_BOOTZ=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_SPI=y
>> +CONFIG_SPL_SPI_SUPPORT=y
>> +CONFIG_DM_SPI=y
>> +# CONFIG_DM_SPI_FLASH=y
>> +CONFIG_MMC=y
>> +# CONFIG_MMC_SPI=y
>> +CONFIG_CMD_SF_TEST=y
>> +CONFIG_CMD_SPI=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_REGULATOR=y
>> +CONFIG_CMD_TFTPPUT=y
>> +# CONFIG_SPL_DOS_PARTITION is not set
>> +CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>> +CONFIG_SPL_OF_CONTROL=y
>> +CONFIG_OF_LIVE=y
>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned- 
>> clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>> +CONFIG_REGMAP=y
>> +CONFIG_SPL_REGMAP=y
>> +CONFIG_SYSCON=y
>> +CONFIG_SPL_SYSCON=y
>> +CONFIG_CLK=y
>> +CONFIG_SPL_CLK=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x1
>> +CONFIG_FASTBOOT_BUF_ADDR=0xc00800
>> +CONFIG_FASTBOOT_BUF_SIZE=0x07000000
>> +CONFIG_FASTBOOT_FLASH=y
>> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>> +CONFIG_ROCKCHIP_GPIO=y
>> +CONFIG_SYS_I2C_ROCKCHIP=y
>> +CONFIG_I2C_MUX=y
>> +CONFIG_MISC=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_SPL_MISC=y
>> +CONFIG_ROCKCHIP_OTP=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_HS200_SUPPORT=y
>> +CONFIG_MMC_HS400_SUPPORT=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>> +CONFIG_PHY_REALTEK=y
>> +CONFIG_MTD=y
>> +# CONFIG_NAND=y
>> +# CONFIG_MTD_SPI_NAND=y
>> +CONFIG_SF_DEFAULT_SPEED=80000000
>> +CONFIG_SPI_FLASH_EON=y
>> +CONFIG_SPI_FLASH_GIGADEVICE=y
>> +CONFIG_SPI_FLASH_MACRONIX=y
>> +CONFIG_SPI_FLASH_SST=y
>> +CONFIG_SPI_FLASH_WINBOND=y
>> +CONFIG_SPI_FLASH_XMC=y
>> +CONFIG_SPI_FLASH_XTX=y
>> +CONFIG_SPI_FLASH_MTD=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_DWC_ETH_QOS=y
>> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>> +CONFIG_GMAC_ROCKCHIP=y
>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>> +CONFIG_PHY_ROCKCHIP_USBDP=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_SPL_PINCTRL=y
>> +CONFIG_DM_PMIC=y
>> +CONFIG_TYPEC_TCPM=y
>> +CONFIG_TYPEC_FUSB302=y
>> +CONFIG_REGULATOR_PWM=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>> +CONFIG_DM_REGULATOR_GPIO=y
>> +CONFIG_PWM_ROCKCHIP=y
>> +CONFIG_RAM=y
>> +CONFIG_SPL_RAM=y
>> +CONFIG_TPL_RAM=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_SPL_DM_RESET=y
>> +CONFIG_BAUDRATE=1500000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550_MEM32=y
>> +CONFIG_ROCKCHIP_SPI=y
>> +CONFIG_ROCKCHIP_SFC=y
>> +CONFIG_SYSRESET=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> +CONFIG_USB_EHCI_HCD=y
>> +CONFIG_USB_EHCI_GENERIC=y
>> +CONFIG_USB_OHCI_HCD=y
>> +CONFIG_USB_OHCI_GENERIC=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_USB_STORAGE=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_MANUFACTURER="Rockchip"
>> +CONFIG_USB_GADGET_VENDOR_NUM=0x2207
>> +CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
>> +CONFIG_USB_GADGET_DOWNLOAD=y
>> +CONFIG_DISPLAY=y
>> +CONFIG_USE_TINY_PRINTF=y
>> +CONFIG_SPL_TINY_MEMSET=y
>> +CONFIG_RSA=y
>> +CONFIG_SPL_RSA=y
>> +CONFIG_LZ4=y
>> +CONFIG_LZMA=y
>> +CONFIG_ERRNO_STR=y
>> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/ 
>> rockchip.rst
>> index 9bab86d2347..ea98b73d33c 100644
>> --- a/doc/board/rockchip/rockchip.rst
>> +++ b/doc/board/rockchip/rockchip.rst
>> @@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
>>        - Generic RK3588S/RK3588 (generic-rk3588)
>>        - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
>>        - Indiedroid Nova (nova-rk3588s)
>> +     - Khadas Edge2 (khadas-edge2-rk3588s)
>>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
>>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>>        - Radxa ROCK 5A (rock5a-rk3588s)
>> diff --git a/include/configs/khadas-edge2-rk3588s.h b/include/configs/ 
>> khadas-edge2-rk3588s.h
>> new file mode 100644
>> index 00000000000..d279cf3826a
>> --- /dev/null
>> +++ b/include/configs/khadas-edge2-rk3588s.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (c) 2024 Khadas Technology Co., Ltd.
>> + */
>> +
>> +#ifndef __KHADAS_EDGE2_RK3588_H
>> +#define __KHADAS_EDGE2_RK3588_H
>> +
>> +#include <configs/rk3588_common.h>
>> +
>> +#define ROCKCHIP_DEVICE_SETTINGS \
>> +        "stdout=serial,vidconsole\0" \
>> +        "stderr=serial,vidconsole\0"
>> +
>> +#endif /* __KHADAS_EDGE2_RK3588_H */
>>
>> ---
>> base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
>> change-id: 20241119-edge2-18ac09a490ab
>>

---
Best regards,
Jacobe Zang
