Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76621C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F19E388651;
	Mon, 29 Jul 2024 10:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ApaTtYtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C45F88365; Mon, 29 Jul 2024 10:38:16 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E55B88247
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyUt/Y5jr5XWa9x7q2hxmaOhMp0SufrXVyc8nHQcOAyKOdoX/avCBVaY6vbMq+GWdNTUnaf6A/S+MnhLwapy7iNus6we7DL0IlyY2q5XLrlJO+mtS3ynFVgfpCKKha/+px+Fdbhbt9+vMMxgBgUjZZ6opPGa+SF5lOCA9aOANkessGpOHs4Cfcch8DTxepOclnD4oPVdMs6lJLBCvVi9eeHJH3/8id2B2XqdhUyHYqwXvr9aUTPPBEYlGnkEZHddwy1IXEhCubc4n7cXWC1QiWTydyZo7Pw5p7XOg3kHe/sYD+jQXvrX7XgFbURXnJbFpCVZude2OKU4/HwZE08y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DwLQ8ZGPugGOu+/XquSn6F1E8F+UbCcC583X72dtno=;
 b=I2KWBxMPuoFuwFEIVZWNi+VBITMkmjd7wYUiuz7ikmJTFUk4c+G5/v6iIqAjgsj+UXuWXtz8AiEhahXzwu5GHjdt7O32ILaV41q8gfnmK9rUxDbQgVw91DU0JQwiozQ3td8jh430GsXdknwuK8mBwd2dYJXv03oUnpU8PK43rHass+oloT0csx82bPLz349aIFw+pidfSnA6NBAaEo3uWqpLsDDjvzxvN2lC1cxYr6AEsRWZfqkDIKvD3tFVUdw+LeJHwlww8J3mpd/TpteMBQXylbXEKRLh+XzLR5Lg/ehqEBkixZzV5/Rj42WyjCmNUBz4SadhWzYXJ0B2gpcTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DwLQ8ZGPugGOu+/XquSn6F1E8F+UbCcC583X72dtno=;
 b=ApaTtYttzoC+mFFgrNZfG0zn73PAILWGXPGahqom1fSsnAR82ydEbVtTmu0JpDwXT/TYPSRUGB1lq4z3tbLeY1cjzRxOHVpJSVR3rT7iJZGWWvbT1u+Ba1K/thcAcCrDvOD9JdTCd9WfrYZ7d/vHFbWoMtbfLyZITte+6uIFTJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI0PR04MB10341.eurprd04.prod.outlook.com (2603:10a6:800:217::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.24; Mon, 29 Jul
 2024 08:38:10 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 08:38:09 +0000
Message-ID: <8095468b-0eac-4591-8aca-3034eeda7365@cherry.de>
Date: Mon, 29 Jul 2024 10:38:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: dts: rk3568: Sync the evb board name with kernel
To: Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240729071850.918007-1-kever.yang@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240729071850.918007-1-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI0PR04MB10341:EE_
X-MS-Office365-Filtering-Correlation-Id: 133091b0-d94d-4332-d0e1-08dcafa9c690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djJSdHBvR1hzM1YzcEFRZUFLSlZoVnNKL2oveVZ3eXRCTU5YSUt3UUpGUksz?=
 =?utf-8?B?N25GQzBNWk55WnpSdXNYTXp6VmpiUTBtVEpLcVFKMEFsS3RWN0Y0NXZ4S0Zl?=
 =?utf-8?B?QjBBZlpSaVhRMWF6YXBaSmlIMUwrMnlEVHRDRGRWdzNCVmM2UWFMOFZidllj?=
 =?utf-8?B?U0VqQU4xRG9NbEJHOGtkUDBaaHhtZGc2UTJhb2RBWHBmNjcreEloZ1pXU3Ey?=
 =?utf-8?B?SHBsL2dqb0VLNU16QkJBcjFiN3VERm5RK0o0UXVYaklSbVVvWEpKd3VUM1Jk?=
 =?utf-8?B?STJyUWVaUlJ3Y3lqc0hJTzZnK3Zaa2Z3VmRmaHVVZlhFSitGVy8xZmJFSURR?=
 =?utf-8?B?YWxmVkVJVU5ERC9CcnJCMUtDRGJnNTYwSjh1MWVWTzQ0bzZoTXNWNFFwNUx3?=
 =?utf-8?B?Q3JtZnlsT0tjRWdKTlp1bGtXZnczZ3pOeWc3RXFkaytGOVVnQjJnM2V0RkNN?=
 =?utf-8?B?akgweVh1MmtoTUFLY1NwenlHeFNsT1lGalhBeUJlVnlmNWRGNFg2NUN1bnZk?=
 =?utf-8?B?ZGpqOFJjOUhYZ3NKZEpFK0dvaGtZdzE3eXFNb21HdnVwZkd1QTVCMExuazIv?=
 =?utf-8?B?SWEySjI4SzFGcy8yQ01EcWlrNWhqTE5HM1M5Z1ZKMUJSTXRkUVpvVldXNkJH?=
 =?utf-8?B?N3A3cUFmRU5rcTZ1Z0hHQVNZTkhCNUZwUGlmeE1PQ2IremxhSGE3OXZ0NXlp?=
 =?utf-8?B?UUZhOVBHS2QrWlIvVXhVTmlNNE01TjBkaVhpb1VqKzhCSjlpMk5SSERBKzQ5?=
 =?utf-8?B?KzBVWFRFNkNydUlaZlYzNHE0eWcwK011RFFaaGptT1I1VXQwQUU5czlEaWh5?=
 =?utf-8?B?R2RGUjBBSkVMeExKWmtiTmpkdTUrUW1mNS9kc2RCR0xpUnp0cGpkRjB3bjRX?=
 =?utf-8?B?RlI2Y01TVVFSejZJdUU1WFNJWXRTVkxHU0VWQ1hyQ1pyWnIrL0FnMWpxSTVS?=
 =?utf-8?B?WWpCc0h2bUdUZVB5N2R1ZGdpREdIWXM1L2MxSmcwZTZqV0VkcTBxZGQxZWZG?=
 =?utf-8?B?WWlVRmRrL2dNKzN4WWI3ek92U1M0elllVkJ4QW1PcmRUUVVKTkVrcmZnSEE1?=
 =?utf-8?B?bTE2bVNkalFYUUxkazZxTC9kbTZHUXFTMDNBU29pbnFCN05IeDhVSDlOQXRZ?=
 =?utf-8?B?U2tMUjExL2haSzQ4azhtVG9LSDh4S1FPcm5nMjNSbGZjQXlvOXQzWWZDc2t2?=
 =?utf-8?B?ZlVBN2Z0L0IrZGdEcUhPYkJUcDhLSnY2RlBiL0tpQVVNM01HSUdsTm55ak52?=
 =?utf-8?B?Wkp4V0RTcjdGSkRkUXVtRXlFc0g5czV0cWdNTTZNSFBWM08rUjVNVnliZVY1?=
 =?utf-8?B?TzBmVjhCbkh6SGhPcnhRSXRCS09sdU1mQ2R2YXhFOGVxbjFjUnVpN0Rwa2cx?=
 =?utf-8?B?d1NjNXpyNTBpbzJHOWN6MEFXT090YUxPS2czZ213Uk9rQTFmUlpkQ3IwTTFu?=
 =?utf-8?B?MlZjRmFFYzVUc0RiWXlSYXNkMnZ0Y2M5Q280M3JhN2kwRnppVlMvU2R5SnNl?=
 =?utf-8?B?a1UzRjhYeHQ4bC9QbUJsTUI1T0VsL1FRTmU3dUJSa09BMktrSzNHd21lYkp3?=
 =?utf-8?B?OEhCUzBYZjNvRFcvN0k0S1hnRkxGQWt0c3gwYTZOckhGMFE2RklWYzV1Zm90?=
 =?utf-8?B?LzRNSEZic04rMW1OMUYwT2xaRzVUNmVGbzd5SDEySWpQZGxjd2daRjhrL1Ir?=
 =?utf-8?B?RmZ3bUtOSWhzSG9UTWlzaCsyNDFXbVJkcm9FMlIwM1lVMmZwUEI4ZUl2Y0FV?=
 =?utf-8?B?RW1jUlZUV3NlRXEwYktqTlUyb0hGSHYrdnRjdC81UERhMi8yVU05cHdzOUho?=
 =?utf-8?B?bk9FZXpiWXNOcWZFbkRKdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1kzcHhqQzBPeHNoWTNMQ3lybDdGaXpOUkRoNzJRZlIvZmUyOXlEMnQwcFps?=
 =?utf-8?B?UDY1cXJVemoxYklBTHZoalVTblcreEhWQWVKQ1RScmJMR2F1TS9kWjRHRGIw?=
 =?utf-8?B?dGgvUkVTNGV2enZLcnNnM2UzelJ4VEhBd0FaclovNGI4SGVteStSVktHUkNG?=
 =?utf-8?B?MVpuRFFxYk5KeUFad1hxcStaaDNSQ3ZIa3NTYnd4TTdPUUxUa242SnoyUEV6?=
 =?utf-8?B?MGk5cE4zY3ovZHZ6bkcvS0JKU2JhQ1lMOTJNUVIyN1loRlgvUzBYVFdaVnIy?=
 =?utf-8?B?MHphMm9JUVJOZGJJSkxpRlFPWmVzT1FFQ0Q2NStIbVFoNThxMW52YzJPdjFS?=
 =?utf-8?B?eExkYWNRVS9LVlp0OC90SE9xR1J3M3E1QVkwWC8ySk5XODdVRGduTGpaTHE4?=
 =?utf-8?B?aUJrV3JsOERBTStQdTErVFRoTTl3SzR2dkhEWG9LTENmbG85cTNTYVAxb2J2?=
 =?utf-8?B?OEhlc2pwK1V3elVyR2xEZXVWYjJ5S0g3OGRDNHpWYUx5VHJyK3BSQ01sVXoz?=
 =?utf-8?B?bTB5YUJPTFJQWnhyRXJBUnRCRU9PZDc2MTFLb0hSZ0hoR3ZhNHVabjdwVGNa?=
 =?utf-8?B?WkJtTmkzc3MxaG5XZzBtQVJSNmM1OUh4a3VMQmRJUFUrVVJYZGJDSDY2YUlk?=
 =?utf-8?B?MGIvZFMxbG1TRDdZNkZhUkJRT1lXajhOd1c0cU50ays4dW04MlB3QUNyLy8v?=
 =?utf-8?B?cG1wM2Exa29uVmNSTnRaWTIzM01MR25BbkpxNFNPcGNYNUpRYnJRN24rL3N2?=
 =?utf-8?B?T21TT3lEb1c5elBEazh2NHJwV015NG5jZ3NlV2QrMzM4YWpsblU2OGlKampl?=
 =?utf-8?B?WldMckdwaGJMK1V5UHRJTnM0T1kyL2pkU3Nsa0NvR2dMalRUcjlqK1QzMWZl?=
 =?utf-8?B?N2ZFSlRSdFRDMzgzTkFMWTFYYnFGNzYybXV3ZjlmeWJFbzc5T1VBODBRdVM3?=
 =?utf-8?B?ZVpJZzJad2xOdjU1VEFHRGpQdnlUSDlsaktQeXlwa2FxbFhGRHZHcWFIcUJN?=
 =?utf-8?B?T0xaVHlaZnJKQzZlcTFqN2tRSjJqdUM3bWw0OUpMMWhmaVhEMllXdk9pYVdn?=
 =?utf-8?B?SjZaaFhoQ0loczBEZUhhZndSc1E4MHRtNTBKbThyM1pFZ3BkTW9GNGJwNzRZ?=
 =?utf-8?B?YXlZenJZMWJ3UzRJQmpyWndONVp3QXp6MElHYVpHb1lvT1V0cEJCajk5ZVJK?=
 =?utf-8?B?eDRud0ZPb3hJc3NkQVR0L05VdHFYdk1EL1cwUVlOOCtHZDNYZjJrOFdYMTYv?=
 =?utf-8?B?WFNMVnBRTmpNelZ2ZytGbTQxNk5QK0NPeHdicDBhazZCMUVSVWtvMGwyVHdJ?=
 =?utf-8?B?TWpxQUh4ZVZyYTdySHBKVTNXU01xSEIvblJNTnN0TTlFQUNFOVpEYVQvWjlZ?=
 =?utf-8?B?d2cxOUNyeHpadzFtRlRUQ1NIeGpaVnVneUF4cEpQRmV4T2NZVXV2VGVCQStl?=
 =?utf-8?B?VWw2ZU5KNlJKcHRGWFFabDYxR295M2hCdDN1K3RkUnZnSHZTTTRUUWwyVkR6?=
 =?utf-8?B?bFE0aHRLUGR0cjRtbE1JclhSR0htZ2dGVXd0RzlnOHEzdmtVdnNtYzExUWpE?=
 =?utf-8?B?c3lsQnJiNDFzVzc0a1NkbGZ0QmhXVmRPQnFDZmlKMi9SWDBwYVh3ejhaVHNs?=
 =?utf-8?B?UDNMVENZSjFHU0xXWng1YzM3WUZKYWFpbHBoOHRSY2IvR1FGV1BIVzJ6Szlo?=
 =?utf-8?B?VjF5cVNHWHVudkFzczRwc3BEdm1MTWIzdXdSYlEycUZtSG00NHFGelJsN0Jp?=
 =?utf-8?B?V1BpbjJrSFZnaEwvTDhNZUQ5c3IvRXRGdkxaOW9Wb1NXYVNvRnF6ZUhCczdT?=
 =?utf-8?B?SlozblEwdWtBVGJQZlNyVG1yeWZTZEtaVXphNkpCdmc4SVhQZmFFRzNyWm44?=
 =?utf-8?B?R3ROZWVqRTBZYmw4eWpwbEtvWkV1R3hGdm1rSEdZaUJ6RzhEV1BTeXpDUWl3?=
 =?utf-8?B?bUJoRjNERVJxNGNPK3FwQ21EZnVaYlJ3cWRzY0U3TTFLZjFGNldSc21sMXEr?=
 =?utf-8?B?UFFIM0FEUXZKaUdxN1l1ME5Nb2JpUnNuVkpMWmNJTHN6ZlUyUUtpTThoVGpT?=
 =?utf-8?B?MWNWbFZrYUd0MXR4OFBGaUtsWEtTVG92emh6OXhUdzlqWGVpUlAvdDFLd0ZE?=
 =?utf-8?B?VWViSGJoTVc0T3YxREZlN2xPRlJDUjNoOTRNanBFWmpVUWhYZjkxZERrZUli?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 133091b0-d94d-4332-d0e1-08dcafa9c690
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 08:38:09.8543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0znUjDCtMWdfYCR+wdUF3oCkXfXHoz6vBr1i9kgIXYcFoPx65Vc9vcZ/r0+JJTyiP5b6FNg9yaxUsW9mKKhDE2mGF4fnrCHDNalB3ie/L00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10341
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

Hi Kever,

On 7/29/24 9:18 AM, Kever Yang wrote:
> The name of rk3568 evb in mainline kernel is rk3568-evb1-v10.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
