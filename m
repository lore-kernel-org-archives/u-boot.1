Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D98C04FF8
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E548088510;
	Tue, 23 Apr 2024 11:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="M4YDOObL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A4B884E9; Tue, 23 Apr 2024 11:26:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C557B884F3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8S0wtwrtADphPj8UxGsZ69juAl42xZVMT4YfPCWoURv98V0li0NYSfCccnbeDAdOqKEuWqg7/DpXe/7Fd0vrm6/5RGEHhi4LhBEXo3pdcJAgJfl+pD4AYRQflVDjulZ61VlcmB2cEt8DeSm7kSdU02zPh//7pvRCcG3iDMtbrH20osFejEeLzzRyadA1EYlwh4trYX8xxCaCBUYXWf10kjUYEELiB88L82jKJ8X7k/bpktw3FGChi9UWbtMQNfX7F2V03FA9/kC1Tr6x10XLviHK3b/8bo/oqCE9JSZ0LL5AnHLli29KZRrTMdffDIvdVmi9Xbi3AlQM5pBlAF/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7syWlKDSJc33GXIwawBVXPwARO6sevDd6uESJvh2dA=;
 b=YHETEDjMGv5fsZGke2b5FzPJXmBEKDHshya0UqFJRNiB1jMyK//MWQ+5FT5jnDNxaMA1gPdsvqne9ucvLsUMw1awcmC3JkJEWtzouRPrLKPSDoW1tkP/KfA5Lkh6qJwXvH8yXZrBoh3PayAZU2z1RbX73A2ObHy6UVcBxQoNPRqs5RNrT9a6Phh95vb+BaTHxj989si71y5Lah498VNlgrE36zs4SMJ3BqWKQcS0eJkpyzBVCX7IzkP32XSSBODcOcdEtm9/N4U1qrp+4Em8Y371cMVj4pkMUIGv7A4bP4ZuBubXoYIri6uD89nWPJDPX+sVDuCxAVZuTSNmFG7YOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7syWlKDSJc33GXIwawBVXPwARO6sevDd6uESJvh2dA=;
 b=M4YDOObLRCTobG46gj5T68I13mDkEVJzJdYfZb0yoZR4IVynle3ufKCllc+L56Om1w1MMMRldXXYpEatr6DrP0SCqtl/bf/jY3C/SgDfGyLieiqnwwTaspdVGy33Kg0eBAgBoMhZQ1m8RIG5q2lR6Iz9+4CBbcrc8YREC0TeWN4/hKr416UjTekWUhCkwj85l6amo2OoX47zNbrb5ZvMHqOv8gbxlxTK19WckzQhFcmmay7xpHhxuoSs1ufnfhV3+ZwMKMx6iJKg0J6WZmJ0itAn/+SoN2Ya1OIW7J2HL7E/Xbw2BZ8N1hAAwCuA3pauDCN2RPEq1xRF1jIi9L7mBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by VI1PR04MB9881.eurprd04.prod.outlook.com (2603:10a6:800:1e1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:26:16 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:26:16 +0000
Message-ID: <c5ac0f87-1789-4912-ad9c-e109855cc5c8@theobroma-systems.com>
Date: Tue, 23 Apr 2024 11:26:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: add support for UART2 M1 and M2 in
 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
 <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
 <99683d6a-2527-4aed-b168-28f0954b6ba4@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <99683d6a-2527-4aed-b168-28f0954b6ba4@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::27) To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|VI1PR04MB9881:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b84a8b-660b-4694-866b-08dc63776ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1dxMVJTc2s5aWorckZrLzIramRjb0FhUDlOT0tQVmJhcWpBNGNyZllhc3cr?=
 =?utf-8?B?RUVaS1NFSFJHQTJLbWpLd1ZUblpobVFtT0xFNjBhMzU4MUtsMTJhSnJvSE5F?=
 =?utf-8?B?NDZlOUdaWmoyV3owbzVqdXZiUWZ4SStPWkxDVFliR2VNQ094ZjRHTnphNWJP?=
 =?utf-8?B?cUduRUlBZkdzUWVGOHM1OVJna3RWWVNpRHZTcUQ2V24zM3FmMTc3dGp3L0N0?=
 =?utf-8?B?c09oRi9kV090UWlHUStUbHV6c2wwWjExTjlEU3MvdHRIa2FSS0hNSy9ZUUFm?=
 =?utf-8?B?MGplYS95UWtvcEM5NW5oQTZiVDFBaVhkTzdmamJMQkxlbXRGVXFicGJiZUZn?=
 =?utf-8?B?TFRuSmlGeEVVWHVBRUNDYm8wR21YQmp2a090WGptWTVjWmVvcHVIUzdnb1Fw?=
 =?utf-8?B?bHBSUW5wai9TSU1OOWo5d3lpS1hVVkpTZ3E4QWhOQkJ3aDY4RVJ6RUd4enE4?=
 =?utf-8?B?eHg2NWlYZEN2QlpydVJOcVBnRFc2eVVJYzgzN2VoaGZhakI4SmFrSDZob00z?=
 =?utf-8?B?WGkxV2drUCtadThNU2MvVCtRZTB0bG00Qk52SzNncUlqam56NkRKOGlueFpx?=
 =?utf-8?B?VFkrUzI0dEIybTlsaG43ZTNHYXVxZVFTTEI2eFVJdEo5TnpkK3BmallKenNX?=
 =?utf-8?B?NFBUVG95ZDJoM010ck5QRk10TTFJYVRHQU43UzZDaEg0cmJBeUFHR0tKOEdt?=
 =?utf-8?B?TXdPbDVQZ0l0dXdtazNHeUIxWTF5dGZrQ1ZYTldKU1FyME9TS3lBRnRqajhY?=
 =?utf-8?B?M2M4cmtLOUdiUlI5TS9OVzR2andydUVNMHZIcXNGUWQ2WkxITm1UeVAvZlZx?=
 =?utf-8?B?a2lzTnNyU0NxeEI5UnhiUDM2NkVRNjcwSnJHUlZzSS9oQkRjUGpEa1c0cEhI?=
 =?utf-8?B?d3BsNW1iV1A4eDJyK0VMa3FHZEpXMlZJaDNKRTRRMExKeGZ4TFVGQ0x5c1VF?=
 =?utf-8?B?UWhEZlUxWVNaaGJ1eG9maUt6VVV6Ykp5ZEVFekV6RGFpUkV0bUc5QkNhUFFq?=
 =?utf-8?B?cEdyRVNwTDNLdWtzY2NIbjZSUGNzNWd4c1lKUWxmbGtPQzNhNEVkWEFmSGFE?=
 =?utf-8?B?TEo0azQ4K1A5MDg5cldkazZaTnlSb0dvYjFNOVFNOTZVczBwWE81ZUdLOGxE?=
 =?utf-8?B?RHVFckZKU1VjemV0MHpROWJiN1RBRldaNC9ldWNyY0grd2dPZnc0NWV4S3ll?=
 =?utf-8?B?b21LT1JYN1JLTzIreWJBNnpoL3pPeTR3MU5MNGg5T3hiUStKUk1zRXdEMlJ0?=
 =?utf-8?B?RWpuNVBEMEp1Z0gyUVIrWlhjWUhIa1NKYlpnRzNWMjFDMCt5c1YrZURZSVQ0?=
 =?utf-8?B?azlFQVRVeWViMnFMWTJDcXVUVm0wSGRUYklNOURkSnlqOFlIVWRiMG1WWmVv?=
 =?utf-8?B?UGZUdG44Y29kNDUrbEJXRDVLN0JVZVd5bFF5N3p5cWZGOHg4bGlEZUtZU2Nq?=
 =?utf-8?B?Tk9pN2RpL1VKY0s0OVVYZ1o0bUpJaEhwNVAyT0FRaFJ4dXdLSFBGK0pqQ1hq?=
 =?utf-8?B?ZVhGcUVTbUJOOGdhL0ZxblN4aU4rYnB0NHQycm9zR1dZZTUyOEFacXFxNWZw?=
 =?utf-8?B?S2tXZUhKQWMzeUZBWTk4eXU3TVEwa0dvQjUrbmpuanFRVFlCNDIzeXJROEtL?=
 =?utf-8?B?YTJhQ0w5My9aM3pSY0pyWTMwZCtMdEs0TjhOYkxOZVM0VTl0Z3EvVVhXcFdo?=
 =?utf-8?B?S2ZGem1GMzlkejcwQ2o1Zi9ab0plM29TdGRzdEs1dTZoY1Bvb3BWRElBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4833.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUsyb3NXRWVYT21LaUtwVEhDVjduSmZZTU52NWlyaldBVVNwTm83d1J0dmdE?=
 =?utf-8?B?V0hwT1FRN2EyeFpOaTlqZmZjMzRWNmE4QnNTY2dNeW5ZU3MzSzdRVm9mcGs5?=
 =?utf-8?B?eEU2Szd3SHdWUVJDVGtCanVBZ2ZBSkRXaW5FamFOdmREcTZLVlkzdis1TW16?=
 =?utf-8?B?VW14WXZWcGpJRmxFdEJGWjNldUYrUlBqWTB5dnVxQkV1eW1NalpLMjVhK0lI?=
 =?utf-8?B?MlNLSzN2T0pJRlRHV3p3YmNuQnBDb0ZuODV2ekRqTnFmL0N6ckdEb25qOFpC?=
 =?utf-8?B?d04zdnlQTFhQQ0JKT0V6UDZPUmpDYXY1QmRUS01kZWZ6d3VOREFHZFgxaHZa?=
 =?utf-8?B?RUVHK256cHRUUms4MGcwNDE2ODFaKzFPKzIrR3RsVGNuTmZxYmdyUy9EdVRk?=
 =?utf-8?B?UFVxVG5EZDdNb25RVVFSc2dlcVQwRzNlcTN6c2x6cUdDNmlUNElkRXdIKzZO?=
 =?utf-8?B?NytYclBNWWtrTXFxcy81ZkZCS2dWbE1Pb2tsS05aVnkzcmwrK3Z2TjJkVDVw?=
 =?utf-8?B?MzlhZkhMSEc1SlpnZzl3aXo3ZFhDUjVYb2dpVkJNRVBLek8vRW1RR21mbWFU?=
 =?utf-8?B?V0NwanRjcHg1QTA4Q0UvZWh3cWFad2F0SEMvU1dqOFRJcStYc0FEc2xiZURU?=
 =?utf-8?B?aFRhYUZybUFWZWVVRXBtdnRVYjBoY2pMaWEyWVU4TlZPTDNOT3RWZ2t6VTdn?=
 =?utf-8?B?eEo2R3pGQXZ0R0QwRzZVbUxtTHljMW43QkQ3dVhlZ25EUmdxU1hEakRHdk5v?=
 =?utf-8?B?SlUybmpESjhrRlVaalg2U3RwMHJEL3BLaFFHQ3l6YzVwMDlxRTlXQlV6SWww?=
 =?utf-8?B?K0g4Y3VCazJwMzMyeUNQOHQ0bWludUVoQUlSNjErOTJMWnRTc0Z0emg1bDVN?=
 =?utf-8?B?Z1dndTd4b3g1MXd2LzA5UXp2cFZOOTVkTUJoK0E2Q3FBWlEwZ21hcDhlQWE2?=
 =?utf-8?B?VnJsR2dEUzRlL1FmYTJGN3MzWjlQVEU0TTExS1grY0RyZVZTRFcwRXgvSFA2?=
 =?utf-8?B?MHhMTmVmN2FvcE9haGpwWGI4NU9wQ25Pcy9Cb2tGbysrT1RvRUdUWWtjRFhQ?=
 =?utf-8?B?ZWRHVFduOFRPSEM1QjJFeVpoSEdsdXcxWVROUkpPTXh1N0JDQUZxQjVDYkpF?=
 =?utf-8?B?REhWWllGZ1FpY0ZGTGNLMm5wUmMzOXZncmhpc1NLWGh6TWNiTkpCRHU3ZFhF?=
 =?utf-8?B?eWRUUjJNaDhwV29QbUFWWU1zQkdOcis3V2RBYkllQk1zT0NtWTZOc2lnbWxG?=
 =?utf-8?B?bW00UHJ4Q1JoSXFTajdOdjFnUmNLY1NRLzNRQjBTY2FnVU5uOXlVaXBTZU1j?=
 =?utf-8?B?QlN3UmlMQzVhQ0VhOVIxR2l5YlFvSnBkZEpsSnkrYVp4K1hXemVnMEZ4R294?=
 =?utf-8?B?cEV3bHBVZ1htREVUSkJGT280U0lnd2hpYzJEZTZTcUl3bnpkc2lNNHVsOGlZ?=
 =?utf-8?B?Q0p5TTZ3K0FnRHRpQVVqbm5RdDd3MmVkUFo4YmhZKzNoUlJqQVovTFE2d0pG?=
 =?utf-8?B?Y1NTY2drY0lxSTlHei9mUGVKdmoxS1NMblVPYmpJM2NTU0VaZmYwYnNIdXJK?=
 =?utf-8?B?S1N2VmY5L2hIWTA5SjVQRmpxU1ZvVFRRYWh3aVFXL0FQQUV5U2VOSkhlZXk5?=
 =?utf-8?B?YTZ3QWhtaSs3SUU2R1dHdEYzNCs4Y3kzdlBxcjE1aVJGalk4TFE2RUhrZThK?=
 =?utf-8?B?NjAzeFNNTTV1OUZwSXdQdVBNMVRFQ1FOM1d0ZXNxd1JJaDdGM0lrbkF2NHM4?=
 =?utf-8?B?d3FCQm1INzU0Z0dLbDRLTFB1NmdyV0tadGtNQzY2YXk2NVpva0RaaVdSOFdo?=
 =?utf-8?B?Wk9WVUpINHB4ejk2Q2huMy9qakIybEFZdHNGTW5rMzU4WVlMazFQR3RtR0Ix?=
 =?utf-8?B?bFBZL3lnd3UxLzZwVm9Nb1JSdWcrMEQrTUkxZWloRks4aTZmdnQrWE5JWi9G?=
 =?utf-8?B?Q013d3lvUUNIVklnMkxPQUVyYkxyTkZ5cXZGWlUrWHNFQ0UxbFVieldZa3U4?=
 =?utf-8?B?KzVyQjRUU3M0NFFsZnlOMDg5ZnE5UUhXdEU5dDh5OGxrdGxJbS9VSXpIakda?=
 =?utf-8?B?dkd3em5vcWdRUlVPL1ljSVBoZkN6aDhiWksxR2toUjU0Y3VrekZLSFhmdFNl?=
 =?utf-8?B?MXgxQk0zVHhSczFzMTJCNW1mLzVuOFJhR3pqNHArYjZNRlhBUFJTTmhsSVJi?=
 =?utf-8?Q?LbRz3ghTzpSIN5RmcKGGAUE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b84a8b-660b-4694-866b-08dc63776ce6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:26:15.9942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWEREa+oCyDqK78az3P9vGCNfoxibuQ4nyz0+vw5B8DGyTxpMRp8ACw5jtyof+t/9d1PUWZKrgrYjQl5ZaXGn3BGndif74zrak+Ot5huGkrafFu4mPp9/4f4cUDVM3Mm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9881
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

On 4/22/24 19:41, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-22 18:41, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> UART2 controller is the controller in the reference design for debug
>> console. The default mux is M0 in that reference design. Until now, all
>> boards seemed to be using UART2M0 but RK3588 Tiger for example will be
>> using UART2M2 instead.
>>
>> Therefore, let's add support for UART2M1 and M2 as possible muxes for
>> the UART2 controller used as debug console. UART2M1 support was not
>> tested.
>>
>> The default value is M0 to match the one used currently by all devices
>> and the reference design.
> 
> Is this really necessary?
> 
> Use of board_debug_uart_init() should typically only be needed in TPL on
> Rockchip platform, and with ROCKCHIP_TPL being used it should be enough
> to use rkbin/ddrbin_tool to change uart config and just ensure correct
> pinctrl is used for uart node, and that the uart node is included in SPL
> for correct serial console use.
> 

ddrbin_tool is a blob that Rockchip refuses to provide sources of. 
Running a blob on the target is one thing, requiring our users to run a 
blob on their build machine is another thing (though I document it in 
the rST).

However... I don't think we have another way around because I just 
remembered that if you have two muxes selected for the same UART 
controller, RX won't work. So while we would have UART output for U-Boot 
if Rockchip's TPL is one mux (e.g. m0, the default) and upstream U-Boot 
another one, we wouldn't be able to interact with it.

It'll be necessary the day we have an open-source DRAM init though (I 
had to do this for PX30 for example).

The issue is that since ddrbin_tool is a blob, it's not possible to use 
it in Yocto for automatically generating the appropriate ddr bin blob 
based on uart controller, mux and baudrate. So that will be my cross to 
bear.

> May I suggest you try adding following to defconfig and drop this patch?
> 
>    # CONFIG_DEBUG_UART_BOARD_INIT is not set
> 
> I would expect that should result in same/working behavior without
> having to add any new code.
> 

It does work, thanks for the suggestion, will send a v2.

Cheers,
Quentin
