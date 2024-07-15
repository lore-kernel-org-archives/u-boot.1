Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7B8C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A09888B0;
	Mon, 15 Jul 2024 16:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mfidtwfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337018887A; Mon, 15 Jul 2024 16:14:03 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770A787B84
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmH4kAjhLI1RoynJj+oxPCC/nlK9dfv1fQH1seqWF1gHP7di9P42Y0ilhLNIlbAtNijoRo+m0EknE7NK3RZ8fE7jJX++PqmBfOQoRiQTYb9WvMpyUo/KJh340+UaCZHieoeFLvSSRuaEUHQi3VbjZFUjrTuk6qgLvQ4VNPU1YQUybnvHIYD/MC+2WxUb87hysgfabwp/qXR5pdmhZ6lFkHfXAtGruj6kxNTlrX6LhxqDFMFhNUZFXraoBbYcyOhyeoVd0Va5gmIXWuyjytmS/FBktLXs1sx7kYxJ0ODlL8toIubYwt9qZyKpTfjbtaZIOgfO5NHsDr9/kiinfzjcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytTHtVpylxu9VkCXSE/xKC/oTS36/ITj3onidIWdlNc=;
 b=cP7vPLgBFqGgKIjTYE+Rje7kemnDStFjxOjOpTn56kZEmd+A+WrxLbWvxTwpjPAaIXaUmB5xdGfx1FmJ5c4ECxXCqr6094SZUYuE4jasOqm417Gq1gfVlMu2WvViPfcdQDD8bxaSwNtiRG1nb30p2E2+MO18NsS5j2zF9c53ytOAnBB/eAis5E6QV4PL3yK1jZZCkafcfDgTvUHu6tcVtLqYj8fnDnxcneZgTCW8J0+wLJFP6MpWF1e9y02E8nejN1E3y8/gzKxfrwtrcAEd7VKGtceXEh7A7c6HE5602foWLhA3FQCEQ/o47LwrCS0gItR/vDJV87n/9eqqeoKHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytTHtVpylxu9VkCXSE/xKC/oTS36/ITj3onidIWdlNc=;
 b=mfidtwfWOdsNq0NNNMYkvvmz04kOTgXHK81Vj2zzsytXCoSQv5+a6OXnqI1UAQbsSyt81/SrGEVye4OmBD0731nGI6TiAm1VFpOAwJzNL6j38AjvfHEfh39rR6tTEoS82ygttTHYgrkUWZFzCGc8rdidopaAuYCjW+D5oPYOXCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:13:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:13:55 +0000
Message-ID: <4cf432e0-88ff-4d3a-9cac-212f818bfbc1@cherry.de>
Date: Mon, 15 Jul 2024 16:13:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] doc: Add a description for bootmeth_sandbox
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-8-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ec3fcd-6723-4d28-3cc8-08dca4d85c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHQwcG9LNDNhVWRuTVlBVkRHelB4cWVBVFZxSUVnejNqNFlRWXd5cVlwUVVn?=
 =?utf-8?B?aTd1NG44N21IWVZIYS81V1lWTzU5ejNyaGx6ZTg1SDNTYzJiTmp2MUxYZXBR?=
 =?utf-8?B?NktNcGIwbDkxTnA3R21yeUxtV2hDVjV2ZjZoRGxGcXNpMVZ2ckJ6dGoyamJQ?=
 =?utf-8?B?RTZqV1BxSmY4aVE4a3FYUzNES0UxMlAxdFpUNHluRG0zRm5LSnllcWRIVzRU?=
 =?utf-8?B?MTVRNmh5OVdTalcySGR6QTg0aXcyU1IySGRvTTdRS2VieXhBQ2lhMEc0SHRR?=
 =?utf-8?B?b2RwNlJEUGZUbVFBdEEzam42Z2tXY1ptT0xlbXZCbkJiOTFScFRmWkoyYlJu?=
 =?utf-8?B?VytxdkdTNVZxV1U5a2cvT0NjaDQvalZqM1VzcnN6Tzg0bWUvZW9vOU9WZW1U?=
 =?utf-8?B?S3dEeTZwL01SRG9nMk41c3FZRS9ibW9Ecjc0Q3duc0pHZ2VaYkJyd3YrS3Rm?=
 =?utf-8?B?YkIycmZvVndqaHpnWU1YM21oTkNCZ2J0bDdZSHc2Sm1Ia0JzS1U2MkY4eUll?=
 =?utf-8?B?UnVEcVo3R2d5UkFoR2tzT29DSkcrSDkzUUJwaW1lbUdZZWNZSjlaZ21BWGtW?=
 =?utf-8?B?SFBlZHlReHVmaklEMWlKWXI3cGFydnhJLzIraE8raC9aNHprakxteXRRTmN5?=
 =?utf-8?B?NE5xS0FJdjFHd000RVFqRTF1QmVDMmhNZUhWQXNaRDQ3ZUg5VTU2c1VEaXcx?=
 =?utf-8?B?REpBK0cvVXdVN2g5RWtlYW44Q2I3bTBVSTdwUzFiMXFtQ3JwWXYrYzZWdlJM?=
 =?utf-8?B?NUdPN1VTSkJCb3FXcFFXQjM3azlSWmdrckl5eUdEeWdib0U3ZzkrRlR0K2dQ?=
 =?utf-8?B?dVhRRGJma1NEWm5TbWoyVXYxVkp0U0VnbEt5eFNIZ0pPTUlQT0hWbzlDVWNP?=
 =?utf-8?B?MEpHTU5KMEV4SmhtRGk3VXdSdXlIT3ZoTzlaRGlFOERzVUtZZzUwZm5vSEMy?=
 =?utf-8?B?ckdDQktqWnFmWHBkUlhOMTBLMUFqS1VJajFva2szN29oMnhjQi9uVkFZTHJw?=
 =?utf-8?B?NW5NVWI5QUVSYXpBOHJQeWN3bWc5UktQMEd5N2IxdCtTOWFIOWNnTHZCNEZ3?=
 =?utf-8?B?alRLTHZvSEVzNHR2TGtpUzVYeUMvNm1EY3M5MTdMZzI4TXN4Vk9LczVRa0xT?=
 =?utf-8?B?MTRRVEJTam5jU29rT3F2d2RTbUVUYjZ2eStoZ3IyWGViT0xQdWV3MlpiR0pI?=
 =?utf-8?B?Sm8rOThlUDZBOHpBUzJtYVdKZmVEV0xLTFY0eEhteDhLcWo0S3U4VWNva0tF?=
 =?utf-8?B?MVBzQWZBTnVPaERMYUpvR2F4cGpUUVRBdTNIc1AzUFBlVEhrbDVLUmEwZ2Zq?=
 =?utf-8?B?V0dGT2lZWm9vWG9BZi9HZXJXMlRyMFFpeFR4SlNVcUhNN0NzN3kvek5GOElR?=
 =?utf-8?B?TjE1UnRqaGVOb2ZaZU5hazBTS3pielU1WGg0VXEyWkhEYVZUNmIwbW1xRDN0?=
 =?utf-8?B?VkpydlNsMkFJRDNHRGJoMTJsUmpsNTJoOUxSeUhWck0vak9RVEp5cTJDcU93?=
 =?utf-8?B?bWhtT0V6cEZpS2RxZzZ4ZmthWnljZDQ0MkVMMVpRbFRtNXp2UGFzR1hvTWFQ?=
 =?utf-8?B?c25sUngwN1lsMWw1NXF4REh1MmcwdWtZbFdNd0RkVml6b25JK1hWYTBmZXdK?=
 =?utf-8?B?enRCR0x2Y0NlMzkxZU55dGVic2RHN3VTVGl6NzhPRFJoU1dyVWVnc0N2Q3hI?=
 =?utf-8?B?NGVOVjRJOUh0T2lmYmZucVk5QTYxRzl2TzBmbklCK0NSSnVWMUl5MXlwUG5Q?=
 =?utf-8?B?MFFKLzZQZkFJMjJCRHlrQ2RjdjJYUlhoZERtNG9tNmY1YzBXWUd5VWdHUFF1?=
 =?utf-8?B?R2RVbGlRM1ppeTQ3amU0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UytDanhWL2RRUWhjdElRSWhwSldVNkkzSGdHUGxrTkdobE5DYkpxODJhbzZO?=
 =?utf-8?B?cGlBTHh4eWk0NjZxZWtkNUVnbjZMYzhhWUVOR04vOExaRDFKb3hXbHYzSFZk?=
 =?utf-8?B?UHIrajRSQ01aWnNCbkhxV1kralFtOUloSHlmd0JQVDl5THYwUjdtTUduWElq?=
 =?utf-8?B?NEgyV3FheTk5c1pDZzhPNW1XeGJkVTRuQWNTZUhsMmpaR3dHOHNFZURzRlBU?=
 =?utf-8?B?cldncCtHdExISEdvY1dqVmU1TStRajlham1LdFNHNXQ0Vy9ZaW1zME1OL0VE?=
 =?utf-8?B?Y0pvM0ZIeDBxZlVYZ1FCelAzME95QXdwVGxvS3FQRVV1MXZUZmpzNitnNUlU?=
 =?utf-8?B?K0x3L3ZkeDlCTTVmVXA0QzhUVTFDUmNaOHBjTE9mWWgxVElHSEIrR3Eva1Np?=
 =?utf-8?B?SklVNkRnSndKRGdLV0loTENIVWF3eEJmWHcvS2hKdU9pWWZ1MzU1MTRvS3Jk?=
 =?utf-8?B?NXk4MmkzK1JlRitsT1BDUzBCK2hTMU5tb2t2VGxaNGEwNEtEU1hQREdjN3cr?=
 =?utf-8?B?dFJhTkVSelNKMndTSERXYTdlbnVMUTN5NER6ZnVPcnRtYnZEQ0Q4ZjNmU3FV?=
 =?utf-8?B?a1JSbnJUeStyZk0yd3luU0pJUUdhdkpwVzMvVEdRRkcraWR5c05ibXBXNTdt?=
 =?utf-8?B?WWUzb3B0MmQ1cnFCRE54VjIwZVFKdGY1YnMvOUx5ZHNyRVRMbStLQUZwYmFw?=
 =?utf-8?B?ZmNDNDhLYllNanFaL3VTL1ZuNHFqM243KzhERmVlQUdyditZaS9tWXYrMStI?=
 =?utf-8?B?cUI0TVJkNFNyeVo1SnJlWmc3QnBxU3VMMnlVbk5aS0FqNU0vRU1maHFYNUs1?=
 =?utf-8?B?THlzUEp6K2lZWUFwN0FzYjdRdW1ITmNyTWQ3T1RoazRWWEdSQVMrREN4M0VO?=
 =?utf-8?B?ak9KU0Rnb3ZaYWgwRkNCZFlPQ01NbkhTUFRnNzM0eUFYOUhsbjRqb252V1pH?=
 =?utf-8?B?NWE2a0hFU3Ira09na0FwZXBTNFZTV1NyMVlLRmwzeG56NFphL1hhQzhKZlFK?=
 =?utf-8?B?ejVTamp0dWVOdkdaWFJKYVoweXh6SlA1TkRzL09NNExaemhwRk95VXNVc2NU?=
 =?utf-8?B?dFdxZDJWVDdwSi9PNU1MQlk4QkVkTHBaeXljZEU3NmxsVVNnQ0FzOER4REFo?=
 =?utf-8?B?WUs0Y05mdkVvTTdlanNjd1lCS2d3em9IcDBTM1p5RWV1YWIrUWZmdkJHYlNs?=
 =?utf-8?B?ODE3ZU9UdG5aYkgyUXZGeXAyOFJvNGVGeUVaKzJCVVl1Y21EU2hUM2hGQzRT?=
 =?utf-8?B?MTVhUVNJZG1HSVZQenNXbVlBMVB6TDRTRHMyNkpyVW5TV0JRU2Voa3lCeWtk?=
 =?utf-8?B?dmJvU1lVa1VBQzI0ekw1dnhWSitEaTdjNFNia2ZLRjFLaGs2eW90MklEZCt6?=
 =?utf-8?B?M0ZGbjJScUxiOHhFVlZrYjhidnB1TXJKdmdLVE04Zm9CZG5WekNPZEs5bExk?=
 =?utf-8?B?bm9IQlBTUldkekNieEVSZlI2Qy9nM0s4dENOd3dEaWRMRGFONmtwUTVnUEpV?=
 =?utf-8?B?d1EzYmIzeE9lei9SRmhrL0kvdHgxZDZQYjFsOUNiNjQ4VE5tOGhhZ0lBWGhJ?=
 =?utf-8?B?QkZuWHljWEU5cmVYYU9vVldpR0NWaDRQeVpweEpIZk5LTVlHam02SWNtTmtL?=
 =?utf-8?B?K3I1K0Y5Rk5sc3hjUno4Z0RjVDIyNGo2L2M1dmx0c2NLWUtaeURpVUdFbGNK?=
 =?utf-8?B?R01uWXltZHpiVnh5cTJPd21TblIvU3RZNlAvVVN4TWhOVlFXN3RXR1Q0Vjlv?=
 =?utf-8?B?eHJPVCtxTVZMK05CTnFmOVZtUlRyaUcwUXRKQ0Vrcm9Ucm8wY0wvblpVR2Zn?=
 =?utf-8?B?S1dlZmtYM1FEcWdFMGpyaityT2ZoYnRpTFlGS3FvS1cydmliTlEybG15aTBv?=
 =?utf-8?B?bURyM1l3RXh0SUlPRlFFSElaVTFlanZiSnR4SDlraGlUV29DbS9EQzVmbHpG?=
 =?utf-8?B?SGNDRDlQT0IrQmJZczduN1Mzd0hyck4xaTVqdXVBdWFTZlV4QVVqdUJ5Wk84?=
 =?utf-8?B?Q0R2M1J3RURHazA5Z0V4Ujl5UW9JcDNCT1hsVzBvdmJReW8yZFIwUnh3Y3po?=
 =?utf-8?B?aXRlSVJ5UmEraFJ5M0lzVHhlZVNHbCtGRk9OTFFuZVFKazNXNEpWRGxuYjkv?=
 =?utf-8?B?dWhOdXZwOGZwTVdXTFY3VlZTSmc3djM3d09ack5UNjFIeTFoeHZPYjhTTTZ4?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ec3fcd-6723-4d28-3cc8-08dca4d85c59
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:13:55.0274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8BFL3S+H2g9ebVoLt0eDDzWdmrE7tl7Oz/cTcL1UT+6FwrJZpMvczNGSiF4ec3VxAwqlZGz1QJej65MYZbb4pfnVFfUaeVgRIBi/zcReNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

On 7/15/24 12:13 PM, Simon Glass wrote:
> Add documentation for the sandbox bootmeth.
> 
> Fix up the compatible string to drop the 'extlinux' part, which is not
> relevant to this bootmeth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
