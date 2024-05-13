Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336BBC25B74
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAB3F88303;
	Mon, 13 May 2024 20:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dMJxMIWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221EE88303; Mon, 13 May 2024 20:31:48 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C857881BC
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVvB5CG1YgOHoD3tZEx8sMm1SltqBXjfxrAn7bKNhQ0YfSuyku1xx6+EwkpqCYe4WKj2KeN9SQ4NSjc/nhLys+ZjKRIKczwFvvxsOnbswI75762UonJFD+l6fp2PIEVfXA+52NHn4zCVPjxQTFYq0vwraFL1cZLRfI4tgA/PKmZiyAyKso857HqoaurnnV3oqW+4fcFSJuA6WYJmOyqDhuhhmP736pWgu4z2Fr/HdUA5uGLgEjaGXmx+WuKiD26lR1pQH5wNIfxR6Ir0Bq7AnKupY3YHV/+9FGq1Pj3Lnv6cApmwmYGw63V9hnrO0UBbtxPqDg3N7pjRK1QnyZ05tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO8xAhHDxaQDYfeJjJEwSx8efyZ6AHEHlzpu8jfIfs4=;
 b=cyIW65VnvBu44D1SxcF+HYk4+8v+ILExa7+LFL5xyNr4R9AVeiaLObrTqW/HjqjnltRYPdaKXFWL5jNLdalkXXCyK1NGrrQ0X765pEM5g3Y75efIC+sOokPpJw3CRfAw7MxFmkOIhjTfbl1B/PlJAbXAv5PFBUyfbuSXZ04MMJQYWHTvwve/jmqeiQvtvYhEBBxt3xseDAQ8y+DMr7K2a/EQmRzwXTUOoZdMb8SZQ/npXPQCPlgM7rdXiYZYkyw3sUD4qQ2RR8rwiM/Sp1RGMDK+CK0KDu5VCKCSb9TEVGktw1JvfCYr7LPtNIXqJjK2czCztwHzdD4tIJeznheCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO8xAhHDxaQDYfeJjJEwSx8efyZ6AHEHlzpu8jfIfs4=;
 b=dMJxMIWrWgCkL3ZPWfqzmsthPUDU06F1lFV5+17LTOgfzu8SWZTZwUbrIJ9zCNaBinyxaQio9h/QC2VsfNoYB3kCEXvSVglmDtwVW2mZbS7iQdrP/+I5eWAiOAqtB2F0I3dk34ZEUXDCnS8U3ELNBgI/OT4gkBbCNyfHIv6/yPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 18:31:43 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 18:31:43 +0000
Message-ID: <e8bdf854-db5c-4292-b469-bb678d75d498@cherry.de>
Date: Mon, 13 May 2024 20:31:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: rv1126: Migrate to OF_UPSTREAM
To: Anand Moon <anand@edgeble.ai>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
References: <20240511161224.1176-1-anand@edgeble.ai>
 <6857bc47-895d-45bc-9b7d-d00ac7b0ec1a@cherry.de>
 <CACF1qncdn9y+bE6vwjCBOAdseTkwPORMHfJ2JFJt6m7ECHGT1A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CACF1qncdn9y+bE6vwjCBOAdseTkwPORMHfJ2JFJt6m7ECHGT1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2733f444-f475-42a9-d2a5-08dc737aefed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1VSR0FodUoxNFpiNi9kbHVUbVR2dUhtbUhsbzFxeURySzRSMDl0RDRsc2xF?=
 =?utf-8?B?ZjVmWHg3cTBWZXNhUFB4WEZGTm44WStnSTZpK0NOK091c09SSk94YjJpalZS?=
 =?utf-8?B?VldYQy9mYlR2NU9yNzZ5QTBJUVJkU3V0NDRnTDc1U3Bjd3drWWxYdXh0UFZw?=
 =?utf-8?B?SWVidFpDM0orRVkvbmRWN2tmSmhsMEJ1TkFiMzJnV0gzSlhlSGhjZ2xMU24v?=
 =?utf-8?B?T3FwWE5nYjhTaXA0Y29FVFVmUUZINGVlVi9FQ1BtL3RaWE9xbmptYlZERTY3?=
 =?utf-8?B?TjloZUkwZndUOUNBMkVBV01lbjdhdkl6V3ZSSURpT0RqSTU3ZTZISFRjTVlQ?=
 =?utf-8?B?Z1Q5eFRoUWZFelJUYWdwMDFHWjI1TDU4TEJDaUNsY0Yra1NnL05OdjdHb2FP?=
 =?utf-8?B?WW1Sc1ZuY05CUFZrVDFDR2NrbkpTRm81UXFHYWRCZGV5dVNPZmNPSGlXUXhv?=
 =?utf-8?B?ckhkVEZRelNjNFgyTVpEd1VISU80QWNpSXM2alNBMzVYaEl6S3UreXJWT3Rk?=
 =?utf-8?B?ZGdrempjQ0J1VmZLVGxiMXZQMkVYdXhwelFlWmU1cXpWMXdnQlVmVjhERmZK?=
 =?utf-8?B?MDR1aTVja1VKVHFJd3g5RitmYVZaWFNwYkRIZFJ0V291dE5xdWk0Vzkwcmo1?=
 =?utf-8?B?RUtKWDJiTnNUNmhuMk5PcGNVa3FpaHdibEJZWjNjTXdGQVo4Sk5uWjlDeWo4?=
 =?utf-8?B?ZVgxZDN2Y3ljeFRubzFsb0R5dGNndW43a3RlZ3BNTTVWK0hWSFR2Z1ZrdlQw?=
 =?utf-8?B?cGlEQzFSbTk3MTduN0k5NVdtRlh3WTBJZ2dNSTJEWTRkMnQrdEJ3UDlhSHlC?=
 =?utf-8?B?Ylc3MDQ1aVpjR240R3lDMUZFNjlWaWNKOFdHbkJyMmZTUEo1YXVNWUxKN2VE?=
 =?utf-8?B?ZkhtQkJsbERJZ3gwZXpialZsVVd4TG5wZTlyMCs4VkJlY09TTSttM1NrN2tj?=
 =?utf-8?B?ZytPbkxKVFNCb1orVEtjNGxWNVJEYzlZM0hDQ044NzN0ZVIxbDc5Y2N5WmdV?=
 =?utf-8?B?ZWYvSFZVT25PbjFMd0NJbFpVSGlvVXBjN3pTTTk3dVc0c2xSMWMvSXJEd215?=
 =?utf-8?B?Y1g3enRRTjIwQnZyRm5JTSs3WFplY0tFci9NMzlXcGlmbFFpL3lhMmYrajVz?=
 =?utf-8?B?OHZNUFJrVWgwK3AvaU0rdXVhTUdqSmVOeHJJYVNNT09GZzFZUEs1cUNSb3VR?=
 =?utf-8?B?ditlSS9xTlIrT0FxbmpaVWlFSFZPZnlreTQ1blZVeFJRaEFiY3l3QUh5VUxo?=
 =?utf-8?B?SlVUbzJiVTdWdFNpVkphRVRxQklSamcvRTlRQ2tINDlWdzZ1SlQydjlnL1k0?=
 =?utf-8?B?TnJQNjdOUkoyVWRLZkVUemhSbmNDcnNKUHVsMnZKSGJoeFpyOWx3YlBrK3dV?=
 =?utf-8?B?cHkzYUt4L3M1RDUrWmpvWml3dW1MTDNzNEtKR0dMZ0ZNUGRNZE1SNmtjeWNo?=
 =?utf-8?B?T1lJVUM0RHF3Rm5PdFgrL05CZ2RRTFU0aGliUGYvYzFxdWRZY2xUVjBYMWZk?=
 =?utf-8?B?VjdSamUrZmJxZERSbHIxKyt5UmoydVN5STFLZU5KN0EwTkw4QXoxTlRrSnVM?=
 =?utf-8?B?L3MzQU12Z2xXa0VrSitvc2QwZ0wrV0QzZkpoMDZpRSs2K1h5aUxkYndZZXly?=
 =?utf-8?B?N1RuZFdiaFRCSXpRZlpNd3BtQWgvMm56M1J0dk1Qb3AxRzdOc1dDOFNZUDM1?=
 =?utf-8?B?STZuVCt0NThyeHNYU0lEZVgwenVSWWpIZVB0UE1oSW96TzNDM1lsRFpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWc4OWV2bTdyZTZ2c0hES1ZHS2djYmxkRTZPaDUxbWJFVWsrUjZnNWJhdEpS?=
 =?utf-8?B?RUF1dUg5aUtVTkluanRFbWxsWm8vbklmamZscTVZVlNvM1A5dTU4UFo5dDlC?=
 =?utf-8?B?M0taVXo0NzV6NUxtKytaSHJrOTB4N294czRIT3FIdE9GdWlwVk1qNG1abWUx?=
 =?utf-8?B?YzlLaTVERGcreTdyS2ppZThXcEdRY0FXYWkrYTZXY2IyalhTWUtibndYUUZY?=
 =?utf-8?B?TTFURGx2dGZFMTkrYXJRQUNPZlJIek5KTVRRcERVTzN0RnVCVFFka2dwdDZY?=
 =?utf-8?B?NkR4VjlFMnIrRkhDOXFjYUJwdTFXMFF3NEI2dStteDIzS3ViY3VVdmNEV1Bq?=
 =?utf-8?B?WitZdjhJMFVFeVBNd1ZwU0NlWVFENTE4enVUV0h2emR1N0lwNUpudStzSG52?=
 =?utf-8?B?WjA5MlFleW0weVFueG80MFhPL2F2SHZ4bFBFY3l4VFFNRzdDdGNydzdoQ3Ev?=
 =?utf-8?B?SUt2aWVlQndZeHpWK21hbnhDM2ZPM2FycVNmYjJaenRTZENpTVFoYjRNSmFQ?=
 =?utf-8?B?eWJIMGQrK29mY205V0lkTHVWTWRHdE1HRUhzZjA1eFhxMm1qN0twaDVrM3h2?=
 =?utf-8?B?V1lWOFF4d1JOZVEwUEs1K3pPYkRFUnBjQU4zdy95aVVpK3hId1JuRVhva1I3?=
 =?utf-8?B?RE9rNkYyUGdsaFlRRkxXbkRrbmlSUlZtaGk4eHZ6RzlXQTZhSUNXUnNBVE5G?=
 =?utf-8?B?WU5ncEJleGNJamluMkZTWTlSME5QM2dKWFdwVTlGb1NVUlE0RVBWK3ozNEh0?=
 =?utf-8?B?cWl4U3d6bkFwTDlrb1h5cktzbVlBT1ZqN3p3N1RpUlFsRGFPRTlnU1pYVTBs?=
 =?utf-8?B?KzE2TTZtcGNFOWEwd1RxNzVWMnpUMW1raHJaYzdNR2g0Ti9QZ1JxM1JJQnl4?=
 =?utf-8?B?ZlpCY3BhcXJOOVl4SzQyNmJvWENKRHJQdU5YWXR3NDlFQ3hwMW9jUDV4VmRF?=
 =?utf-8?B?Rk0ycEdsNHF0MGZvaTZmK0h4KzNrVCsrZm1OMEZTSVlKTVdBM0tuMUxHT3dK?=
 =?utf-8?B?bDh3VlhVODk4RXpuRFVDS0JEQXRSczR6TTM4WjRDOTN6cWxNNTIwbzYyT2c3?=
 =?utf-8?B?dDNSNVBPcTZFbGxycnJFSWZhdi9IMzhvTXRxMDVzR1dxakhzMWduOG1rRW53?=
 =?utf-8?B?T1dYODIyOWpPWHRoV0lTM2FlY0VKdnAxaFMrTnpDQldmK0Nxc29zTENSU2Vw?=
 =?utf-8?B?UFVqOWFJNGtpb1dMVEVvM0FtUnRYWk9IRmRpSFVJWlF0M2ZoZzNiVkEvS0VM?=
 =?utf-8?B?cjVsb0h2b2g5SFNjZHZNSHZmU3pzTjExOE5oOHlsTzRWU1h4aVBNVk5VeUlN?=
 =?utf-8?B?R1d6elBNUUZBa1dXTzlWckozNFBDR3crMGVIL3ZlNWFYM1FTU1FNWXVDLzJG?=
 =?utf-8?B?T3VlVDRHUUszVmZNcU5qWGJ5NnJRd3BKd2k2SDE3ZEpaQXZVQW01YWtOcG5D?=
 =?utf-8?B?enBkKzFIODRuWWpodnIrRG5MMmh1aGFjeitCTkM0U1krMGRUWjhmd2ZyaUhX?=
 =?utf-8?B?ZHRnNnN1TEVSeEZNTlBjODI3WmxhYnNpc1QxTW9wRjVoU0VFblhvN0QzMGkw?=
 =?utf-8?B?aUt2ZmJGUWloMmYwREQwMkxwd1FUT0N5c0lIMUs0Q0tQb2YydkZNOHNSaHZS?=
 =?utf-8?B?YWFuS2NCNzhWaStHT3JMd3gwdklQU3JIbnhYcnNScGNEbXRIbDE3TklhNk9F?=
 =?utf-8?B?U1hmaDJYTDZnZXpFRzJjOWc1cURkeHQybWhzN1lqd1VqbGdzVU1lbzJUeFJk?=
 =?utf-8?B?b1VhWnlUVm50YzJVZHFEVUt6cWh1WjVFcVhFZlBwRTZIVlcxa3RaUjBHYi9y?=
 =?utf-8?B?Y3B6bTBqajFlQzBMVnA4c3FMSFFQa1Uyc2oyZWwyRHVMdEdsTDFPaEFNYU1k?=
 =?utf-8?B?NlpVVExDenJQdXZHLzJ2bmkzRHJncmhEZ2djTWQrVVZkUU8rUndQR21jM1k2?=
 =?utf-8?B?Z3I4YnFSVG9BV2VYVXZ3OXYxMTkxa2ZrZU1JS3VhZ2lXT1N4Z3NCLzd3K1FB?=
 =?utf-8?B?N1JocjBOTWd0bnBUR3lyL1lWU1RyRUplby9EQTk5OERQMTlIUUtPeHY3ZktD?=
 =?utf-8?B?TWNFRXM3czY1Wnd2LzRqdk9YRWRsWXNFNmdVMzhoTVlzZUNxTDExZGhnLy9r?=
 =?utf-8?B?bE9Jb0R3N0JZU3JWKzhxYzhHUUZLZXRaMzkwVitqdWQzQ3d2cnY2N0dxRVg4?=
 =?utf-8?Q?yD0x0UJ/y67k9f9DJ9f/4Vg=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2733f444-f475-42a9-d2a5-08dc737aefed
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 18:31:43.0082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe8t2rQmUyyvVwXyB8TieP7BwWknoEiGcn1NSYGLFyc12T4LWvFI2GX/DZiV7Mskk59GOLt5CFumkIJkKH7HlUjvINnTzQkD3gjrhdKC/00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
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

Hi Anand,

On 5/13/24 2:07 PM, Anand Moon wrote:
> [You don't often get email from anand@edgeble.ai. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Quentin,
> 
> On Mon, 13 May 2024 at 16:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Anand,
>>
>> On 5/11/24 6:12 PM, Anand Moon wrote:
>>> [You don't often get email from anand@edgeble.ai. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Migrate RV1126 boards that exists in Linux v6.8 to use OF_UPSTREAM.
>>>
>>> Following targets is migrated to use OF_UPSTREAM:
>>>
>>> - rv1126-edgeble-neu2 : Board is an industrial form factor
>>>                           IO board.
>>> - sonoff-ihost-rv1126 : Gateway device designed to provide a
>>>                           Smart Home Hub.
>>>
>>> Cc: Tim Lunn <tim@feathertop.org>
>>> Cc: Jagan Teki <jagan@edgeble.ai>
>>> Reviewed-By: Tim Lunn <tim@feathertop.org>
>>> Tested-By: Tim Lunn <tim@feathertop.org>
>>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>>> Signed-off-by: Anand Moon <anand@edgable.ai>
>>
>> Doesn't match the mail address sending this patch :)
>>
> Earlier I sent this patch with my email ID,
> Since I am testing these new boards,
> I will use this edgable.ai email ID for source code changes to boards.
> if needed I could send this with From: Anand Moon <anand@edgable.ai>
> 

Up to you, it is just particularly odd that there's only one letter 
difference between those two mail addresses, which very much looks like 
a typo:
edgeble.ai and
edgable.ai

But if this was on purpose, nothing against it :)

(I made a similar typo in a kernel patch recently, hence why I brought 
this up :) )

Cheers,
Quentin
