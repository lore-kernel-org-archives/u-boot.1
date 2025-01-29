Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E8C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A6E8083C;
	Wed, 29 Jan 2025 18:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aX7Aei1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50800809A4; Wed, 29 Jan 2025 18:33:02 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A4F80646
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6zo6o3gHARjm/y7WTtDkyIiX+C/xfrbCi7eFadnEEUCbf3qFIPbor/SiRehVT/BI4SgGIHAbQN6xvFUZhEFCbnUnY7wEsMJeIBNllGmdg63kk4zrSojQCk5yz4rh/5ceKYxD6kCN7djlBYaSOEWBLne0SLir6b/Cnfo/zVuqvGHHOtURAJF0opQCYJpuZ94LkOS8BnIy3UHfwRTsQjcRrbm6gRCcRS/8JIyfoK/2LiiEqmyosD3qjZrM/NusA28zpcimRO7JJs7x1b5mjTxZdXxMTb+wH9RgGVT7pTYojV8rG1cuiT8T3ACL5OM3a2iCd+8Vz4aV5ZxEUiF0H4THg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HItInTNj2sWMJqn+06VH1VPXNjTSZonjXC1GKVX/HAo=;
 b=Tcb2dmF4KXvWGTeDFlxrvKBOpZa/5zWPJVmPDQ96jdrYDixFgzxeEcIZBv2rtLarAKetjYKu8a8IOwy9BcoIqSdUq/5HR86uTp2DNCs5C3VncfVHhhEYf/RdTRsckb0OzRLxmASTbOAE/ff4xwRz1bZv72JoXj6ZGPL9aWItKcDNdaXT0DurazqoCLANH4s2ev02T51bMllUGpQ0qbPtfy8UKfgdgI9qdyLPSlRC4UWKYWFSEZUqcngyZQxnCTiP26wgfBLWRGcyE1dfW4iSqY8HnwyhgtnkQ/n6xlv1jR6fGdwkGe6wDM7zHmk2UZPUA2fbREm5Vyl3bwtpoqkrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HItInTNj2sWMJqn+06VH1VPXNjTSZonjXC1GKVX/HAo=;
 b=aX7Aei1tSTksETN144qCsbKDZDNXP5zvCmqpx1X+WFeR5DmR7HJq0PxtE/3Y4rxjH+QsnSKXjBZlPy9I+QH18jKea1/o9iTgf6cRiI+tI28gCJyKfuV6H++8HHRUuKCh3PX8EP5+UQwiArlKgk3xEOSaDRlvEpP5Zdix9FZdDOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 17:32:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 17:32:58 +0000
Message-ID: <b941f46f-6f1b-409c-9bc1-a72962e56f45@cherry.de>
Date: Wed, 29 Jan 2025 18:32:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: renesas: Add TFA BL31 handoff support
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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
 <b7b755d2-1156-4463-9764-086d9e6ef080@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <b7b755d2-1156-4463-9764-086d9e6ef080@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0102.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::31) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 1641119b-be11-4461-10ef-08dd408af8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|7416014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW5HK3FId0pabTNZdzVRL2RLeG4yL3NuSlRlU0hjVkF6ckovNjFHOHJSb2lq?=
 =?utf-8?B?d3htVHJZa29xR1N6a2NYYUFCZy8vV3kreTFUNlRVWWVHei93UDdpSTNIQ0Uw?=
 =?utf-8?B?cVE4UWNxZE5sQ0JlSTFGeFRpVFRrV1lyVnVLWmxTaVhUcEV2cU5LTkdZSllY?=
 =?utf-8?B?SzRKaW0xaUptVENFQS9zNlo2Vlo0NGcveDdtSERZR1dRRUV3SktYU1gwWnFN?=
 =?utf-8?B?T3ZLM3gyekRHa25EWFd6aHVmUjRxalJYM2R3Y0pYaUNyUEJPSkd6cnA1WXRX?=
 =?utf-8?B?cE1GOXZIWUNwRnBvZ3B1U0wzZEJwR2dpWFFZczhtWWxVQnF0TC90NmVIMFNr?=
 =?utf-8?B?c2Q5MFhvWTlKMm5Pdk9kWi8zVGdpa2hrM3MzMWVCeXlRVUszSUtLRTJzWTNT?=
 =?utf-8?B?UHJYalJhNm1BazZHcERraklHckpldkFWSlg4d3A5QUlQOW1EVWVCMExhM3FO?=
 =?utf-8?B?eVdZeFd4NVg4WjF3bDVpYnlIbHl5NnRueGxoQnA2NFFYNXV1bDlYR0lUaCtK?=
 =?utf-8?B?OEMrRlhmM2kvMXVhcE1zTUJzdVBwaVJ5WDZOQnB6NGdYVkVzUHIwb3RBNXZm?=
 =?utf-8?B?Y095em9TWlF3MTQreGptR0l4NFQ3eHJlT3pFQnFlMi9qUDA5enRkU1lzWlJJ?=
 =?utf-8?B?bFFhMG9EL3o5L01va01HS0xROXhOUXVXQjJTUnhKVWx2STdHSVg1dk1WbVlT?=
 =?utf-8?B?WnY5eDVHQkppY2pNU1prTkxiTGQrZEZhTmkzWVJtTkpPcDN1VGhxazFRYXF2?=
 =?utf-8?B?NWk4Y3dHVFVJUHZnbmVTamRDZ1ByQXlIdmtCcStOb3Y3NE10UDYwbHdaczN3?=
 =?utf-8?B?MGFQWDViMzMybk9mTHRkWFdLM0IwUUhVZUJkazZMMUpMUDlBZElzVFR0L2Yr?=
 =?utf-8?B?R3gwM21TQStHNTZhL29QaXQvT1hzaFJiSkJESUUwZmFHWDJCUER5UXdjSkZS?=
 =?utf-8?B?YUh0YlB5OTBNRSszc0U0U2kvRjk0Y2ZzaEVJS2EwZ3hzQ0lkMXl5RjlPQ2N3?=
 =?utf-8?B?b1R5TEFkNnZGazB2YkFnTXNGTGd4ZnlHOHE3UEV3SHc1eWFDdmZ3WGJRa09y?=
 =?utf-8?B?bngzQ0RWZjVnVnozbGFvRHJ2ODBycVZKdGRGQmYrRks3OFFScWQyN2FZUFRF?=
 =?utf-8?B?SHlLRHZCcnlDM08rbi9VMURQTjFubS9HSXlSZ0NuUVI1a0tHamNQSUJKeGN0?=
 =?utf-8?B?S0RwQm1UWWZRNDNSajZMZ2RQdXhlMnNzSHJ4bkdTVThpaE9ab0grRG1TUHhL?=
 =?utf-8?B?ckIwdWZjeUVOYytEUDlYbXRuRlo5QWJHRVhTQWxwVEVTZytyNXBNWjAzLzVk?=
 =?utf-8?B?dHlJdEF1eTlTeW9MMGVRQ1dBZ0NPa2dZbGFFeStxMWhVZ0t0cUYyQ04xS3Zh?=
 =?utf-8?B?RUlkd2M5Q3dNaGxUTTJxbVRzcmgvdTJpNXlWbTZHd3ZzOEY2NXVGTVgwM1d0?=
 =?utf-8?B?dlc2WDdFZ0JPSzkyN1lPSlFLSmE1OHpPclRzaENVM0dmNXpIbjZBV0tvbldx?=
 =?utf-8?B?SVBYRW8yL1VhMnl4dU1keW1sQmdBYm5hYVBKTnQ3TG5iVFM3cENMaExXVWJi?=
 =?utf-8?B?SC95bHVrZnhVd3RPUWFHWldqVFZTRTA4anJ2MnhJZFBrNHk0S21GTEhoK002?=
 =?utf-8?B?QlMwd1g2UTNKYVZkTWU3YTBCQ2hhdlFlUTBxRTRjM0kwejBBcHNLbjhMYzJZ?=
 =?utf-8?B?bmMvNUdKcEpwenhXYlN3K3hLRDJWYmN4d0s1KytJckI3K2hJdExHWTk4d0NI?=
 =?utf-8?B?Mm90OFhYS0kvOFN4THNRU0pIUnU2Qmw2Ykh3Y09JZ2Q3dVIyamdlOWcwUHRV?=
 =?utf-8?B?aUloYTVxVTcxTUNxaWtxbi9HdWF0RkV0Tk5ybUdJZ2w1T3V5SVlPQk15SVg0?=
 =?utf-8?Q?a1TAO8QbJTEt7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2RFWFJXU1pFYS9SQlYvVjdjSzhXZlNveHIxWkhrNEc1QmtXQ2NTNHUvSUxl?=
 =?utf-8?B?cXo3SUV0Ti9PNTBoVkpYMlhuNDhQbk80YmdCRXhNNWZFKzYyQXlhZzZ1ZHVz?=
 =?utf-8?B?VGR5OFpBdGtZSERqaXZnaE1DcFlsazB6ckQ2cjZhdW5rajNJaWJpWVlPc1BK?=
 =?utf-8?B?d01GQzByYzZUU1hCZnM5SkROVkJzWE4xSXMybFh1TmJzd0Y5UzlTSm8xOTRM?=
 =?utf-8?B?M1JjVVd5ZTYxL1FwYVFJcHcxSVpOdEdmQklYNGZGRi9RTURwQVRxYzgvYWtC?=
 =?utf-8?B?RTkyb1lwQlJiV2hvNXMyT3RDckRxeE5WbUk1b1hjQkR1Zytjb2ZQeDBXdkxx?=
 =?utf-8?B?TCtnR3BFcmpvWmo2aDJVaTUzQkpzVEVJUUcvL0VnWmszb0N1aFhqekZTT0Iy?=
 =?utf-8?B?LzlkMFBDcUY5TmQ4MGIrYXBVRWFMQTRvOWlraG53V04xYWVDWlJSbU9aK3BQ?=
 =?utf-8?B?M1ZBRjJHeGRqNmJpYTYyaFQwSjdGNUdxcVlUYmVXb0owMzYzaGtMR1dQNzNy?=
 =?utf-8?B?djJkTTEzdWgycGZaZzVQVnlzT1Y1U1FCazhyeE9UMlgzQnF5aE9zbE9CMXNh?=
 =?utf-8?B?T0V0a3M2MTF5Yi9JbWM0NmxJZTc5KzF5Uk55V2FtYUowUmNsTDFKaW1zRStO?=
 =?utf-8?B?Rzc3a3I0VTZvbUJneWxQK2JJWEtKV3AxSHgzdmR6SFpnZjdpTGJQelRsZGFP?=
 =?utf-8?B?bElKNkkveFlpUk5VWExla3hQLzB5QnFOOGlsbW5yMERhY2VVQnJZdmtXMjV5?=
 =?utf-8?B?K3JGQ3hHV2RFNGFvWm13Sms2Tkp2ZW5rUWdlVGMvTFlVc2lHQmJSdnRBUEVy?=
 =?utf-8?B?b1EvcTJPTjFLRStpQ3h1Y1RYYnhRWWZOcGEyWS9KTWlkWlBLRGZId1psTFNj?=
 =?utf-8?B?NUc0TG5VU1FjYUY1U1dHRU90ZEdLVnM1N3RGYmVIUmlMUk1qZHk3cFQ1TmRN?=
 =?utf-8?B?L3NnaWw3Y3BUMEd3dXYwS0hDRFNVcjRkZ1ZaQ0pDdG82dnpycHg1YmQvT2g0?=
 =?utf-8?B?eWRBeTlCRXR6aHkwM1NlbGVUN3dscXozSXorNmFjUVFjVXJUYWkzbVZIeXpr?=
 =?utf-8?B?Zmc1NjlDb29leFdUdUYrUS9Hc0hIYjFoUkJSUGl4KzRIa1F1a0pWVTBGN3I4?=
 =?utf-8?B?dndUbFV0d0lGRk1zT242c3haSUVWNGpNK1Azdlo1TEVqTlcycWJjbFp2VCtP?=
 =?utf-8?B?Y0ppMklVNzViczNhTEtzdVhDVHdNMUN1c09oZzd4cm1Sd0dxV01TdHBsL1Qy?=
 =?utf-8?B?UEhvM3Y0UEQ2S2x3d1ZxaXZZaEtQN0hMekxDUEJ1eHRYMyt4RGduRW03VGQ5?=
 =?utf-8?B?Zmd4MnNOdGJGclJNZ2xtUk5ucnlpc2VVMjRXNlBvR25rSFBYdUUxa1haQ1pB?=
 =?utf-8?B?M2lPMjNJay96bjNXZXlISnprQXVUQjBLN3FiV01kdmhPWjVqTEFWWmdQdFk5?=
 =?utf-8?B?ZmhHcGZaWFJnZDd2bDNINEYydWkrRzZlTktlV1ZFeXlYWFdHQ3J1emVvTGZx?=
 =?utf-8?B?cS83dHNtT2FNb2pVYzVMai9iUFJPZmUyNGpITWZGQzBjcjJzZUQrbTFDQmsr?=
 =?utf-8?B?NG4wME8ycXBraDBuU2h1MkJackdsem5OL3Z3SDQvVGpMbGxoaHF6dWRkTVNJ?=
 =?utf-8?B?TlprR1RyQlgwVFkyK1pEcE9LMUVRaFp3OE82dVU3Rm16VTVlYURJdUk0bE42?=
 =?utf-8?B?VGVMcmJaSGtORWZKdUpRcjhoSlZDbE0yOCt4K0VDWjBpVTB3SzM4NUpTZlp6?=
 =?utf-8?B?Z2RxbFc0RTJqMVlCRWVSdHhTM3ZQSDZiMHFtalYwa2FUN3o3OW9rdGhFbERW?=
 =?utf-8?B?c3Y5eU5hOWN2b2Y3Rk1XYXZEZUdTWHB2cXlEcjFPcDZxdHpBNDlVeGlQQzJC?=
 =?utf-8?B?azBaZnNKeUhiSUl4ZERxVThETFRBQkZUTHJlaGZxVE92ZWQrYlVQT1ZHcjZT?=
 =?utf-8?B?bkpOamg1aUFXZmpRNXp0WGt1TERQYk9nQmtnNVJBQUJvWnhuaW1JQ1JvQVor?=
 =?utf-8?B?anlhK2pyN3dTRUc2ZUg1NHlmaUhOdEF3MGtPUHFkREh2K3UvMGhmVDFpUXpt?=
 =?utf-8?B?c3N4RkJaRjJVWWd4NnF0eExmUkpYQU1ibHVJK2NGMGhFczdoK1R6eG11VUVr?=
 =?utf-8?B?UVZxR29TZzMzNTlQb0NqVmFjSXJFTkdSQjQzbTVhWjY3ZlRHc1lzenpXanF5?=
 =?utf-8?Q?aIcTtBO7uwVcggj24loVm80=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1641119b-be11-4461-10ef-08dd408af8c6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:32:58.1150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2iFvE3XI7P0DBZMLRRxhqmRBTY0p9U7V4APZceit3NuOKfjgdkG/6+tCzHhkHY99ZXE20axHJiI7YYr5FTbjNFYnpNME1tC/qGUfbVPeg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
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

On 1/29/25 6:00 PM, Marek Vasut wrote:
> On 1/29/25 5:02 PM, Quentin Schulz wrote:
>>> +void armv8_switch_to_el2_prep(u64 args, u64 mach_nr, u64 fdt_addr,
>>> +                  u64 arg4, u64 entry_point, u64 es_flag)
>>> +{
>>> +    typedef void __noreturn (*image_entry_noargs_t)(void);
>>> +    image_entry_noargs_t image_entry =
>>> +        (image_entry_noargs_t)(void *)tfa_bl31_image_addr;
>>> +    struct bl2_to_bl31_params_mem *blinfo =
>>> +        (struct bl2_to_bl31_params_mem *)PARAMS_BASE;
>>> +
>>> +    /*
>>> +     * Destination address in arch/arm/cpu/armv8/transition.S
>>> +     * right past the first bl in armv8_switch_to_el2() to let
>>> +     * the rest of U-Boot pre-Linux code run. The code does run
>>> +     * without stack pointer!
>>> +     */
>>> +    const u64 ep = ((u64)(uintptr_t)&armv8_switch_to_el2) + 4;
>>> +
>>> +    /* If TFA BL31 was not part of the fitImage, do regular boot. */
>>> +    if (!tfa_bl31_image_loaded)
>>> +        return;
>>> +
>>> +    /*
>>> +     * Set up kernel entry point and parameters:
>>> +     * x0 is FDT address, x1..x3 must be 0
>>> +     */
>>> +    blinfo->bl33_ep_info.pc = ep;
>>> +    blinfo->bl33_ep_info.args.arg0 = args;
>>> +    blinfo->bl33_ep_info.args.arg1 = mach_nr;
>>> +    blinfo->bl33_ep_info.args.arg2 = fdt_addr;
>>> +    blinfo->bl33_ep_info.args.arg3 = arg4;
>>> +    blinfo->bl33_ep_info.args.arg4 = entry_point;
>>> +    blinfo->bl33_ep_info.args.arg5 = es_flag;
>>> +    blinfo->bl33_image_info.image_base = ep;
>>> +
>>> +    /* Jump to TFA BL31 */
>>> +    image_entry();
>>> +}
>>
>> Shouldn't we have a weak implementation that SoC vendor can override 
>> if they feel like it?
> 
> We do have one. Please do have a look at 1/3 in this series:
> 
> WEAK(armv8_switch_to_el2_prep)
> 

Well yes, and it's completely empty :)

>> To me this feels like it could be much quicker adopted if we had some 
>> default people could try out for their boards.
>>
>> We already have a generic spl_invoke_atf() so why not the same for 
>> this mechanism? As far as I could tell, we get the load address of TEE 
>> and U- Boot proper (bl32 and bl33) and pass it the FDT (or nothing if 
>> SPL_ATF_NO_PLATFORM_PARAM symbol set).
> 
> Looking at spl_invoke_atf(), it _almost_ looks like something I could 
> use, but from what I see there and here, the handoff structure layout is 
> slightly different, it seems to be board specific.
> 

I believe it's common to any board with SPL_ATF symbol enabled.

That would be...

$ git grep CONFIG_SPL_ATF= configs | cut -f1 -d ':' | sort
configs/anbernic-rgxx3-rk3566_defconfig
configs/bpi-r2-pro-rk3568_defconfig
configs/cm3588-nas-rk3588_defconfig
configs/coolpi-4b-rk3588s_defconfig
configs/coolpi-cm5-evb-rk3588_defconfig
configs/coolpi-cm5-genbook-rk3588_defconfig
configs/evb-px30_defconfig
configs/evb-px5_defconfig
configs/evb-rk3328_defconfig
configs/evb-rk3568_defconfig
configs/evb-rk3588_defconfig
configs/firefly-px30_defconfig
configs/generic-rk3568_defconfig
configs/generic-rk3588_defconfig
configs/jaguar-rk3588_defconfig
configs/khadas-edge2-rk3588s_defconfig
configs/lubancat-2-rk3568_defconfig
configs/nanopc-t6-rk3588_defconfig
configs/nanopi-r2c-plus-rk3328_defconfig
configs/nanopi-r2c-rk3328_defconfig
configs/nanopi-r2s-plus-rk3328_defconfig
configs/nanopi-r2s-rk3328_defconfig
configs/nanopi-r3s-rk3566_defconfig
configs/nanopi-r5c-rk3568_defconfig
configs/nanopi-r5s-rk3568_defconfig
configs/nanopi-r6c-rk3588s_defconfig
configs/nanopi-r6s-rk3588s_defconfig
configs/neu6a-io-rk3588_defconfig
configs/neu6b-io-rk3588_defconfig
configs/nova-rk3588s_defconfig
configs/odroid-go2_defconfig
configs/odroid-m1-rk3568_defconfig
configs/odroid-m1s-rk3566_defconfig
configs/odroid-m2-rk3588s_defconfig
configs/orangepi-3b-rk3566_defconfig
configs/orangepi-5-plus-rk3588_defconfig
configs/orangepi-5-rk3588s_defconfig
configs/orangepi-r1-plus-lts-rk3328_defconfig
configs/orangepi-r1-plus-rk3328_defconfig
configs/pinetab2-rk3566_defconfig
configs/powkiddy-x55-rk3566_defconfig
configs/px30-core-ctouch2-of10-px30_defconfig
configs/px30-core-ctouch2-px30_defconfig
configs/px30-core-edimm2.2-px30_defconfig
configs/qnap-ts433-rk3568_defconfig
configs/quartz64-a-rk3566_defconfig
configs/quartz64-b-rk3566_defconfig
configs/quartzpro64-rk3588_defconfig
configs/radxa-cm3-io-rk3566_defconfig
configs/radxa-e25-rk3568_defconfig
configs/radxa-zero-3-rk3566_defconfig
configs/ringneck-px30_defconfig
configs/roc-cc-rk3328_defconfig
configs/rock-3a-rk3568_defconfig
configs/rock-3b-rk3568_defconfig
configs/rock-3c-rk3566_defconfig
configs/rock5a-rk3588s_defconfig
configs/rock5b-rk3588_defconfig
configs/rock-5c-rk3588s_defconfig
configs/rock-5-itx-rk3588_defconfig
configs/rock64-rk3328_defconfig
configs/rock-pi-e-rk3328_defconfig
configs/rock-pi-e-v3-rk3328_defconfig
configs/sige7-rk3588_defconfig
configs/socfpga_agilex5_defconfig
configs/socfpga_agilex_atf_defconfig
configs/socfpga_agilex_vab_defconfig
configs/socfpga_n5x_atf_defconfig
configs/socfpga_n5x_vab_defconfig
configs/socfpga_stratix10_atf_defconfig
configs/soquartz-blade-rk3566_defconfig
configs/soquartz-cm4-rk3566_defconfig
configs/soquartz-model-a-rk3566_defconfig
configs/tiger-rk3588_defconfig
configs/toybrick-rk3588_defconfig
configs/turing-rk1-rk3588_defconfig
configs/xilinx_zynqmp_kria_defconfig
configs/xilinx_zynqmp_virt_defconfig

Essentially Rockchip boards + some socfpga and Xilinx ZynqMP boards.

... which I guess confirms what you've been saying, I don't feel like 
it's generic enough to warrant making it the default, weak, implementation.

Cheers,
Quentin
