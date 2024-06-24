Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D8C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6C787CDB;
	Mon, 24 Jun 2024 10:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="n6bFc82V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9535487CDB; Mon, 24 Jun 2024 10:25:36 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2602::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 713678332E
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBcp3ispBLmpOuynHF/yYZRNhmXhObi7UJ6iUROSkJIv+T9DpZWeV7xMIeFZE1l9rMRrwEWe9obpF9rESjrfc5CH4Ni6H7WVSRbBEwbQfkMbzy6Uril+6LJ9E3ew5kOIxBL9gKwWpwwv24w90ikd1+Yd3hxq+cLWoGWDfTO0EGknGz9LEpoijZCfTDaSC4PYBlo8Zqk1m4r3mdr33D+tF/Qm9a6nr3ni80WohishfxBkSIRtv7loO03LD/ch1/sauThe2HYlxa+aNXAMb6I456W7R9lUeSUK3rYGfWPSeST+5o0qvO34TzJetVmqXoz7TrnA1mLta79EO3toA/JdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAk5iaD0cb4kSrbyA/Q5Rks0g9B/2swNGgl1NqZOjQM=;
 b=OrBOF20qo/rFuhNsHn8Nwbfxj/VD5s/wu0LG0Z4Xn9vs7YI0fifhaEI9gaTTR/4g5i3YIDRzQKbNBhAu4+eW19oiCHo3a5yca4P3BP9kX69oo1qhDgs/RhE+yZQTNCfsY51Yk7S3fazKPEQpgIJWjvMbJVBbNH5Uv+zKDxJiRfTUKZ1/Ei4Mcu5tJMVqU/OQ0Rm5a9mpbrhwiekKPW2wmBIG+bJuglfBgw/trxmhz6myAgo173odxnv4PCvrpmIq8ZxvKPJGhwtOKZMMX6S5RJ94lc8Mmx9QS2O993vci1kNsvfm4k6e/l8V1BBBIl8O0rbQj+3aYLB0Ay7o8hX9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAk5iaD0cb4kSrbyA/Q5Rks0g9B/2swNGgl1NqZOjQM=;
 b=n6bFc82VDOjhNde1PStHXy+bBuQ0sWIxdCzCZdYt32dL3r2aNsUTNzvt/ddecwyz08Reh6VbVmZMafvJ+qni+YC3F2RbDxxFIwH8PrAQ9JPwYqE04sEcD6uDTLwsOTZejiJT9kvVYnqSAvOw6/Th1YSJncoJB0h29MHA2Ze2Dps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:25:31 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:25:31 +0000
Message-ID: <9b24f6ba-6b4c-40aa-836f-c8a576b54701@cherry.de>
Date: Mon, 24 Jun 2024 10:25:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/16] Drop the special am335x_boneblack_vboot target
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240623175302.1463973-1-sjg@chromium.org>
 <20240623175302.1463973-17-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240623175302.1463973-17-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 797c56c8-2247-4359-914e-08dc9427363f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0s4Z0VCREpjMXB1ODR5ZjdBaUpRdms4bm9FcU9QdW5oYjhvQ2tVbUE4YWV1?=
 =?utf-8?B?ZVZ0MHVlZ0o3TVJHd2E3aFhLd0cwcVpENTlOckJpeVF1djFaVjBHdXZJbmJI?=
 =?utf-8?B?SlNNWDNwTnU0aUhZK3orUWxiNng5RkRhOC9zK29vOU9wVllVS1FEY2R2aDgx?=
 =?utf-8?B?ZFgycUhFbExqWVVDRXdBYjFDVVNTRFlzeWxuNXZHdnE4Sld5ZXR1QWluTWth?=
 =?utf-8?B?N0ZDcTJINzEwSXBwN2twZElRYmZpclJrMkswTnV2emVockFjZ0E2MmJXZjZK?=
 =?utf-8?B?WTZHMnpqR1d6MGdVTjZkaXB1d1E5ZjlHUER1QkpaK1hyZGxRUFdjdVl2Ky9D?=
 =?utf-8?B?QXRBMTY0eWdqWnJZMEI4bTJrc1IvWUdtMHRSUWdDN2FRWkt3RC9WcG5odXBl?=
 =?utf-8?B?MlZ1OFRMOEpWdnZ2SHFNdnR5RnpMaVJJcmo3cTVKNkVrMDlkKzBEdnZrYzFH?=
 =?utf-8?B?M25WLy9mTi9QQVhuUTZOMnBjNnZ4QlFVVnpMYndRdDRRMnRvd2xLdWRYYnlD?=
 =?utf-8?B?WTdkUGVTUm9Rc3RFK3VUQ3JBK3BFRDBnQzdTUnhaZUxSd2kzbHZkdytkUEFR?=
 =?utf-8?B?TjRYWjBaTXQ4b21EZmRrMDI4SDJlYVoyNU5lZFNaRFgvQWY4R0RDalVaWElk?=
 =?utf-8?B?cUZwdFdCSGlIa3NBUG9oRGtYaWd2bGVCTTNSaW9JSmYzSzBRbVRRRXR4Uitx?=
 =?utf-8?B?US9FVlRtUjRsLzdyRUpQOTVzai9wbkV6ekFkb0xObXZ0WE5vUXFwNXg1aWth?=
 =?utf-8?B?Q0JiVkxWVDZrUzNEbFN5YkJpcUZuZ3ZyZWt1K1hnSVh1T3FRVWhFcnJIRFIx?=
 =?utf-8?B?czVLS1Q4WnNNMGJlaHJlMXFWWWhqa1N2aHphUVV1anZIMVNMMGZiM0ZEQmo1?=
 =?utf-8?B?UjU2b2d2bER0aFFHcDVVV0s0SUR5MU5TNDh4ZjFxVXAvVHg1clRNbWZQaWdk?=
 =?utf-8?B?enNzUzZpdWdCNlRFQlBNM1c5dEVsR1NvMnE0b0lBR21NNzJUZi82Ry9xM3dI?=
 =?utf-8?B?dUh2R2hBdEFxNEFqYlc2ZWwwUFozemZJZmRpT0hJYUVDZkNkUHZKMGtwWnpt?=
 =?utf-8?B?SmFZcEhRVUgzOXYwSDFIVzgweVpxNjVlZTF2alhtVkwvSjJQU2lBaC9UMTlq?=
 =?utf-8?B?TlprSXh2a0hpRHBVaE4rRXBDRWNxaGlUYnJvWjBNRko1R1RTSWRMc1l1aXlt?=
 =?utf-8?B?UDkzS1E5ZkFqSDdNK0hqaExyOXRsa0VtZXdtbVhJSnNaM25wZW9nMjNaVllq?=
 =?utf-8?B?NFdmeW4zb1FJTzRrRzlWNk14cEwvN0hYMDVKcjg3bFFISTdCZkJGUGpNdnVj?=
 =?utf-8?B?eEJEWFJQSlZaRExOSzgvVHdvUWs5NVNWdDhiK2hwSkpxd2Njd3FIYUEzQWg2?=
 =?utf-8?B?RXJEWExXZWZta0FndXYyT3dZQytkenVnaFdVQ2xPaENlZ1Vvb3hQVjJuMG1r?=
 =?utf-8?B?UjhjK3BUYzllWTZ5bGVRcVU2M0VaRTFOZiszRkpSUlJjN0lQWjlLUk1ER1Jt?=
 =?utf-8?B?c3N2Um5RWjBGbUtOWHJyMkhTWW82My9mRFFVeW9rbFRYMzhNUVdvWWl3Z0hE?=
 =?utf-8?B?Vi96MVp4VHZlcGcyZmdNcy9FTFdFenBVaC93MzVxVTVzTXBBcFN6bzYvV2Zw?=
 =?utf-8?B?cEo3a213RHMveVpZeXYvbTRlaVB2ekhzd21kNzU1MGZwUmFHY1g3NUZmbllk?=
 =?utf-8?B?UTR0TCtZVEw2NUNOVkpmMnl0TWJRTTE1UVBMQUwxVXhaaEJON3M2b3VKZEZC?=
 =?utf-8?Q?ZoMiBCtIduDVVZyWfOhdGsLim5RS9ibwbK7gjwO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJscWF5cHNMOHlUbkMrM1gyYmpWVko0Mjhub296UUpqSWRLK25PT1kvODZH?=
 =?utf-8?B?Yk9uNStkZ3FRTGNSUjAxNXF0cHA5S0lqS0RzSHd1ZXF5VnhrYTZ0WHR1bjhU?=
 =?utf-8?B?UVk1dUxqWmZjQWNjWHdJRHJyeHdaSnBmN1M1Ky8wY2pMUTVDZk91cTRwSFNt?=
 =?utf-8?B?U2x5T1NndTdvWE9SeW9kcGRIVklXcGdqMXN4UGQwU0RXRW1XUXNKSWdxVnBB?=
 =?utf-8?B?WklRaW0wZVhweGdEZEM2UkJpanpHQzRoUWlWdllHN3A5UUs5UFZjZ00zdlF0?=
 =?utf-8?B?L0h6OS9KdjJLNXYvOHNhUWMzZFJZNkhXMGVhMjN1bE1VVUkvT3NiTHhRQ3Nz?=
 =?utf-8?B?TXd5ME45VXdIQ3dlcWJ4U1dOclhZT1ZRS2s1RGdwVG11Ymwxb0VSbTViTklz?=
 =?utf-8?B?YXJNbDU2Y1lzMEY3OUFpdTFodmd2VXdEZnF0WklzaEJ4Y3M1OEI1ZjhLM0I3?=
 =?utf-8?B?eTRVUko2S3dHTFF1TXBXbmdYOUtYSkZPdjgxRkFMQkJvR0pMSnd6dkkybENo?=
 =?utf-8?B?WFhTaEVmZG5LREY0S1FWaG9ZaEErVTRnNmFna3gvODR5ZEdTZU9UbGwzVUd0?=
 =?utf-8?B?QU8xbEw3RTU3ekxiYWtyZjZYTkl4dldhUVNGTWVpVW5NWjlYOStSRjVUZ2Zk?=
 =?utf-8?B?Nk11YWo0ZWkrVVVpNHl3S3F6R0JFUG9TOFR6V1VmNDJCbWpQeVVKQTh3VEs3?=
 =?utf-8?B?ZlVqV2dXYlV2bXd6U0NuNVFWTnJReUFmeTJwQnZFV2VXM21qR1k1cEo1UlRM?=
 =?utf-8?B?UUdaQVdKa3I0R0pYNElaRFpvSzdEQjNxMGhxRmFiYmlSRmRDYmdXZVpnZFBz?=
 =?utf-8?B?cVF1akE3M3U0bGxQWGN2ckx5L1ZVUy9lekthZzV3Z1NMcUVsL0JUa0Uzazc0?=
 =?utf-8?B?bDNyTDlYcENKb05CWTVYdk93SEFidVhZTnFobUdRQStPczRIM3MvMG9sMmZo?=
 =?utf-8?B?N3NHalJwcWx0bW1KdFRJeDc4UnpVY3BybXJCcy9uWUNtSEdtdzQ3Kzk3anBh?=
 =?utf-8?B?b2w3WVduMXNGRWJkTnkvbGtLRVpKQlpzN0tBdFJVdW9OYnBkajNjdnZtZkNX?=
 =?utf-8?B?WEJpTEdjS251ZnRURHI0M1JTdG5TdVE0TURPL0hTU0x3ajhFYm14QkhhZ09S?=
 =?utf-8?B?TXh4Y1NmMFVJMytpUjMwd0V0cHRURHdLUWt0eFRpKzNCWC9kVkQvMXB0MmRt?=
 =?utf-8?B?Sk8yUFRFcnR2cXdyQ3d6cjBNY21LcGttd3ZUN3JYeWlKMCtQcE1mQmVYWDJ1?=
 =?utf-8?B?ME5BMmgzN3U0Qlg1V3hRaHhhNjFqL3l3WjFLbmpsRk83Mk8vZS9kQ291bzho?=
 =?utf-8?B?VXJuTnMxYWdiRkZneFg5MVZrOEFuNzNndks1VXA1SFlQbFBFUnVUcldCVENr?=
 =?utf-8?B?MVNpeVpxRjdJdTRmZmhybnk1ZTFHck4zSHRhS1lFM3NyM2pvN0tSYWo4OGNH?=
 =?utf-8?B?STV3N2N1WkZnZllCTmpTdGZ1ZXpqL3hrUWFwek82Y1JMNjdwRTZzT2FCY2U2?=
 =?utf-8?B?RVBLTCtIeHFKQi9aTmloMW9lcEZjNGQveDBzbk9idXlEUGxlNk1qOFo2bk01?=
 =?utf-8?B?Tjk1ZU9wQ0JoNEkxTVYyNncrV0NHdWE1VWVzbHR6bG52ZkxkR1ViV3pIazJQ?=
 =?utf-8?B?NUozb1ZSbjlKNGErSnE0cHdSeDJ2ZmxGV0ZleDlNRjdvTkxGaG1mNlVEUURs?=
 =?utf-8?B?bkJJZFBkUStmNm9sZStyU3hLREJvYVdGUlJZdnFuSnlHN25udjNZSXdRajhN?=
 =?utf-8?B?eCtWNUN3eklLeWJhWnhYbVFYcHBiMmNmalBKQXoydEt2R01Nb0FSZC9oTlB6?=
 =?utf-8?B?VTIrK25ON1REUnFoT2RCZFhhMkxXclhYOFNyZE13TzBMclFsZ2xRNGw5dVpM?=
 =?utf-8?B?b3NIVHpYd2YvTUJqa3VTNHR5WkVCM3RycXI5cURCWGlaODRXZkVaV2xZTzZr?=
 =?utf-8?B?c1FhOEhMakFJZHlXc0pqZzZWR3p2YlJlU3NwVlpBVU9QbUVnc1hFK05FS2d1?=
 =?utf-8?B?eGpiMDhSdk5vRWltZ3JlcUw4Z2MwekJLeHIzUXJtY3lvMG84Mk9sMGtmZ05B?=
 =?utf-8?B?UDBETkNMNEY5UFdkYk83NW1wdEFkRTJBVnNnWngvcGFiam1EQ3Z2bmRIK0JR?=
 =?utf-8?B?Uy9rNFRoa0dGQ0ZqSWRVK3gvQXdOU24vLytFazg4RVBMQ2hwd2N3WHc0c0po?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 797c56c8-2247-4359-914e-08dc9427363f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:25:31.5541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G4dPdz8lVFI+/Ls9cgMtVL9DKs8iJJesY4OtqSts7I27thbqRXHAsfmic8WUV9MC0O7FBNPNhEIi4DlrmehhT5DjJ9yAOVbycwtJe4RTKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265
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

On 6/23/24 7:53 PM, Simon Glass wrote:
> Now that am335x_evm boots OK on the Beaglebone black, drop the latter
> and update the docs to cover the change.
> 
> Also add a few updates about 'make fit' and drop the note about the
> security review, as U-Boot's verified boot has had quite extensive
> review now.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> 
> Changes in v4:
> - Move Binman size feature to a separate series
> 
> Changes in v2:
> - Drop patch "regulator: rk8xx: Fix incorrect parameter"
> - Rewrite boneblack patch to onstead drop the target and update docs
> 
>   board/ti/am335x/MAINTAINERS              |  1 -
>   configs/am335x_boneblack_vboot_defconfig | 94 ------------------------
>   configs/am335x_evm_defconfig             |  3 +-
>   doc/usage/fit/beaglebone_vboot.rst       | 21 +++---
>   4 files changed, 12 insertions(+), 107 deletions(-)
>   delete mode 100644 configs/am335x_boneblack_vboot_defconfig
> 
> diff --git a/board/ti/am335x/MAINTAINERS b/board/ti/am335x/MAINTAINERS
> index 219c8715bf1..ed8800a2663 100644
> --- a/board/ti/am335x/MAINTAINERS
> +++ b/board/ti/am335x/MAINTAINERS
> @@ -3,6 +3,5 @@ M:	Tom Rini <trini@konsulko.com>
>   S:	Maintained
>   F:	board/ti/am335x/
>   F:	include/configs/am335x_evm.h
> -F:	configs/am335x_boneblack_vboot_defconfig
>   F:	configs/am335x_evm_defconfig
>   F:	configs/am335x_evm_spiboot_defconfig
> diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_boneblack_vboot_defconfig
> deleted file mode 100644
> index d473a1a793b..00000000000
> --- a/configs/am335x_boneblack_vboot_defconfig
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_ARCH_CPU_INIT=y
> -# CONFIG_SPL_USE_ARCH_MEMCPY is not set
> -# CONFIG_SPL_USE_ARCH_MEMSET is not set
> -CONFIG_ARCH_OMAP2PLUS=y
> -CONFIG_TI_COMMON_CMD_OPTIONS=y
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
> -CONFIG_SF_DEFAULT_SPEED=24000000
> -CONFIG_DEFAULT_DEVICE_TREE="am335x-boneblack"
> -CONFIG_AM33XX=y
> -CONFIG_CLOCK_SYNTHESIZER=y
> -CONFIG_SPL=y
> -CONFIG_ENV_OFFSET_REDUND=0x280000
> -CONFIG_TIMESTAMP=y
> -CONFIG_FIT_SIGNATURE=y
> -CONFIG_FIT_VERBOSE=y
> -CONFIG_SYS_BOOTM_LEN=0x1000000
> -CONFIG_DISTRO_DEFAULTS=y
> -CONFIG_AUTOBOOT_KEYED=y
> -CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
> -CONFIG_AUTOBOOT_DELAY_STR="d"
> -CONFIG_AUTOBOOT_STOP_STR=" "
> -CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> -CONFIG_SYS_CONSOLE_INFO_QUIET=y
> -CONFIG_ARCH_MISC_INIT=y
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> -CONFIG_SPL_MUSB_NEW=y
> -# CONFIG_SPL_NAND_SUPPORT is not set
> -CONFIG_SPL_NET=y
> -CONFIG_SPL_NET_VCI_STRING="AM33xx U-Boot SPL"
> -CONFIG_SPL_OS_BOOT=y
> -CONFIG_SPL_FALCON_BOOT_MMCSD=y
> -CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
> -CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
> -CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
> -CONFIG_CMD_SPL=y
> -CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> -# CONFIG_CMD_SETEXPR is not set
> -CONFIG_BOOTP_DNS2=y
> -CONFIG_OF_CONTROL=y
> -CONFIG_SPL_OF_CONTROL=y
> -CONFIG_ENV_OVERWRITE=y
> -CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> -CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> -CONFIG_SYS_MMC_ENV_DEV=1
> -CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> -CONFIG_VERSION_VARIABLE=y
> -CONFIG_NET_RETRY_COUNT=10
> -CONFIG_BOOTP_SEND_HOSTNAME=y
> -# CONFIG_SPL_BLK is not set
> -CONFIG_BOOTCOUNT_LIMIT=y
> -CONFIG_SYS_BOOTCOUNT_BE=y
> -CONFIG_DFU_MMC=y
> -CONFIG_DFU_RAM=y
> -CONFIG_USB_FUNCTION_FASTBOOT=y
> -CONFIG_DM_I2C=y
> -CONFIG_MISC=y
> -CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> -# CONFIG_SPL_DM_MMC is not set
> -CONFIG_MMC_OMAP_HS=y
> -CONFIG_MTD=y
> -CONFIG_DM_SPI_FLASH=y
> -CONFIG_SPI_FLASH_WINBOND=y
> -CONFIG_PHY_ATHEROS=y
> -CONFIG_PHY_SMSC=y
> -CONFIG_PHY_GIGE=y
> -CONFIG_MII=y
> -CONFIG_DRIVER_TI_CPSW=y
> -CONFIG_DM_PMIC=y
> -# CONFIG_SPL_DM_PMIC is not set
> -CONFIG_PMIC_TPS65217=y
> -CONFIG_SPL_POWER_TPS65910=y
> -CONFIG_SPI=y
> -CONFIG_DM_SPI=y
> -CONFIG_OMAP3_SPI=y
> -CONFIG_TIMER=y
> -CONFIG_OMAP_TIMER=y
> -CONFIG_USB=y
> -CONFIG_DM_USB_GADGET=y
> -CONFIG_SPL_DM_USB_GADGET=y
> -CONFIG_USB_MUSB_HOST=y
> -CONFIG_USB_MUSB_GADGET=y
> -CONFIG_USB_MUSB_TI=y
> -CONFIG_USB_GADGET=y
> -CONFIG_SPL_USB_GADGET=y
> -CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> -CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> -CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
> -CONFIG_USB_ETHER=y
> -CONFIG_SPL_USB_ETHER=y
> -CONFIG_LZO=y
> diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> index d243cb16e72..cabc181460a 100644
> --- a/configs/am335x_evm_defconfig
> +++ b/configs/am335x_evm_defconfig
> @@ -13,6 +13,8 @@ CONFIG_AM335X_USB0_PERIPHERAL=y
>   CONFIG_AM335X_USB1=y
>   CONFIG_SPL=y
>   CONFIG_TIMESTAMP=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_FIT_VERBOSE=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_SYS_BOOTM_LEN=0x1000000
>   CONFIG_DISTRO_DEFAULTS=y
> @@ -119,5 +121,4 @@ CONFIG_SPL_USB_ETHER=y
>   CONFIG_WDT=y
>   # CONFIG_SPL_WDT is not set
>   CONFIG_DYNAMIC_CRC_TABLE=y
> -CONFIG_RSA=y
>   CONFIG_LZO=y
> diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
> index cd6bb141910..1360c71803c 100644
> --- a/doc/usage/fit/beaglebone_vboot.rst
> +++ b/doc/usage/fit/beaglebone_vboot.rst
> @@ -67,18 +67,20 @@ a. Set up the environment variable to point to your toolchain. You will need
>   
>          export CROSS_COMPILE=arm-linux-gnueabi-
>   
> -b. Configure and build U-Boot with verified boot enabled::
> +b. Configure and build U-Boot with verified boot enabled. Note that we use the
> +am335x_evm target since it covers all boards based on the AM335x evaluation
> +board::
>   
>       export UBOOT=/path/to/u-boot
>       cd $UBOOT
>       # You can add -j10 if you have 10 CPUs to make it faster
> -    make O=b/am335x_boneblack_vboot am335x_boneblack_vboot_config all
> -    export UOUT=$UBOOT/b/am335x_boneblack_vboot
> +    make O=b/am335x_evm am335x_evm_config all
> +    export UOUT=$UBOOT/b/am335x_evm
>   
>   c. You will now have a U-Boot image::
>   
> -    file b/am335x_boneblack_vboot/u-boot-dtb.img
> -    b/am335x_boneblack_vboot/u-boot-dtb.img: u-boot legacy uImage,
> +    file b/am335x_evm/u-boot-dtb.img
> +    b/am335x_evm/u-boot-dtb.img: u-boot legacy uImage,
>         U-Boot 2014.07-rc2-00065-g2f69f8, Firmware/ARM, Firmware Image
>         (Not compressed), 395375 bytes, Sat May 31 16:19:04 2014,
>         Load Address: 0x80800000, Entry Point: 0x00000000,
> @@ -466,7 +468,7 @@ the private key that you signed with so that it can verify any kernels that
>   you sign::
>   
>       cd $UBOOT
> -    make O=b/am335x_boneblack_vboot EXT_DTB=${WORK}/am335x-boneblack-pubkey.dtb
> +    make O=b/am335x_evm EXT_DTB=${WORK}/am335x-boneblack-pubkey.dtb
>   
>   Here we are overriding the normal device tree file with our one, which
>   contains the public key.
> @@ -597,14 +599,11 @@ Further Improvements
>   
>   Several of the steps here can be easily automated. In particular it would be
>   capital if signing and packaging a kernel were easy, perhaps a simple make
> -target in the kernel.
> +target in the kernel. A stating point for this is the 'make image.fit' target

s/stating/starting/ I believe?

Cheers,
Quentin
