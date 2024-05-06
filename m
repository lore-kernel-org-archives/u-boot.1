Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5568DC4345F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 07:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD4DC87F64;
	Mon,  6 May 2024 09:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="gzZfgkhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D8B87F68; Mon,  6 May 2024 09:17:41 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83EB587E83
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 09:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEKdadZ9J9t1YCeEIGv2u585zrWovIPgEMKPsMWQTJCptyAUj/F2ogRPQa7UrJqU+6eRlCSEB3oQU6sG2U5FQIZG+afxcbfqwgnCXpthzlQVF7mqQ5tE6ORRyQio5C3YOtu5pGRrg2zHtOmZoR8ex61xqbjCtsPsVqpdPPpS1p1L5TDeftI4XDEqYN2pbbk0gIRIKeAkuE6FjWt0hcdisRI8IQsHZfJnRPnLJLHmAmRZ7c2rObTirafU9EppgyXEG89mSlQH09xfKjni9mqCX35zwvyLNi5MPkMJMJjzhJS/RYxGC3TwD8l4znMmj/pB/pcz1OVFgW0YM981SefVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yECJKh1qsBXs6pG4einz9v5fDy5Fo6ihg8oyVn7vIU=;
 b=ecOoKLiVIw67otSPNEF49vUWnLiDs/UPOuyGFJ5KPktWISIsZp0GQHZ/Bf/w1kTyiYP+tMBqCKMyifESkYLwXcDVCHuw2Qj4lEbX4U7mrvhlvzOAuCD++yoCdWenrZxFoc9211mAeEJ2vdRQ25EyglfUw2NwH9ybqjz0tCYN3lZ5Y8O892mKvCUCmpTp8fYqCgLshNqqUtmBH80ioZdKlETugWbbAbrXcCRspphXcJGUXqfV17K89t02i2aK8Fo0RKVVfMNMMvP1qd5Lfw8OjJ1zhdzvoAGpOGYYkLv9pOmLgwULV0h2iII2Rirs9MytWcv3OhvB3WCIffBxxwW/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yECJKh1qsBXs6pG4einz9v5fDy5Fo6ihg8oyVn7vIU=;
 b=gzZfgkhQl2PQSeIF96LlfzuxhjaO5nmzZGf8yNvnqWgCP6azVygefTKqNmnwySbHTkyOmOUP2yycH7nHU2WulanWkbu5vjKnDFj5cx9S/lSvCtm0KQW8jlqaUvLcvqmhCimPZszJAeF1UGET2lEQPB7JdvJtbKAJutflkLamp70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8975.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:565::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 07:17:37 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:17:36 +0000
Message-ID: <4293aa84-986a-4326-bef6-5a4f7a1387ab@kontron.de>
Date: Mon, 6 May 2024 09:17:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 080/149] board: kontron: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heiko Thiery <heiko.thiery@gmail.com>, Michael Walle <michael@walle.cc>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-80-trini@konsulko.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240501024316.1767971-80-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bee270-9ea9-4bfb-3a7c-08dc6d9c9abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzBlL3I2cUF3eFpqajh4dmlWaFdLanE2aXZqaFVsWFFKZGpXM0dVVm9NT2RF?=
 =?utf-8?B?dEVSRFFrRXVTa1VsQ3pOWTRpVWh5NEZybEdYYm1YQVo2NXdRTzNSMURpZzVR?=
 =?utf-8?B?NGF6WEc2UWdGTDhMRENoblg1OHhrZGdZejluRW9qNFl5bU5tRXRaaVNpU2ta?=
 =?utf-8?B?Q1JvaVpiVzdiK2R6L0lpQjJhUVl3RmtyeklTL0tLRFVzOVpFUTIzM2d2aEJX?=
 =?utf-8?B?QlNNVGhoU3NxUXkrcVZrZXN2R1JkNjdwNWJZMkhFbmRCRGdMT1prNE5XVjNk?=
 =?utf-8?B?UGFOOThRV3lBSDZZbTVKeEVUbkpXZUVXS1pFdmpGMDF4U0tJdmQ3WGJZVkw5?=
 =?utf-8?B?RWdWWHJTRDhvc09jWU5hVnZaY2loTVJqWG10MlhLWlg3akU5amNyd29FK3Qy?=
 =?utf-8?B?VjdoeFFpckJaRXBtVWo3bkI1V3R0Nkx6UVE0c08ybHMwWUhnYjVjY2I4Uk1v?=
 =?utf-8?B?TFJ4ZDEvQ0FPOFBRdFI5RDV2UUpYTGx5Z2c3NjQ1YmNQTjlwcXBveW9maFBD?=
 =?utf-8?B?cERRSmUxeWpFcTZFSXQxR1BGTHExOUo3QVF3a0k1ckxEOGZ1TGlUVGdSWHBU?=
 =?utf-8?B?ekNyb0hldEJ3RFQrVlp4ZExvOHhEWHE2cy9tQ0N4OVJtb0hQU2tERy9USmpN?=
 =?utf-8?B?OFVZUGxRVThaUTRxNzYxdityZk42MW54V1kyMHN0c2R5YitGa2YzelFVMWt2?=
 =?utf-8?B?VWt5TnprM2tjcTlMU29IRFB1QVBjMTIxZnpQQ0ZSQ1V6UVlOOG4xSHpGVlRP?=
 =?utf-8?B?aUtaUGRwTzJ6RlBvWFpzNXVVWWFrZHlWR2NvcFVRNlpNMElNSDFWVWNxb1Zk?=
 =?utf-8?B?NzJ1UDg2ZUhnTjlsUzBQaE9lYkJlZTNONGZXWFAxd0Znb3ZNSHJLMlVWRURq?=
 =?utf-8?B?T1VhdEdYeGlNQjJvMEZnTUcyaFk2WERuYWV0SElwdUxxS1ZsbWlRM0J2cXlS?=
 =?utf-8?B?RklYdXExRWxYUG1xZUZ3Sk96QnlSUmFSZUFmNmNMQThRRDJkZ2IyODRqWGE4?=
 =?utf-8?B?dUVjaTJITVU0ZHJ3blpNcDh5dkNzMis1WUJsSEQzMzEyVVl0cVZPcDMyamNN?=
 =?utf-8?B?OVNnb3c5QXh0S1dPM3Ztand0RDAybUt3VlBocGkzaFRNZ1dmZjZjMDBub3ZK?=
 =?utf-8?B?aE5LSlVTTXBENHJNaHRydFRCQmE3S09TYVJuRGd4d0ZEV3lmMWNlQXA5eWtY?=
 =?utf-8?B?YmxIWGE2T1FuSDdITFE0YS9HTkM4dUpqT3E2b0RTTWQvL1BkUmI2ZTNYWDd2?=
 =?utf-8?B?VHpKbXN3cG1SNXB4N0t1M005QTJOTU9YVU51RW15QzJPT05ybWR5d0JsaTgx?=
 =?utf-8?B?VXdQbmNWbnJCdWQzN2JlQXdtOTZYV2Qyd0FjYTE4enVSMkNBU256SEUxNHRI?=
 =?utf-8?B?UlNzQ0hKR3JacVVxaTE0cnpJWDA1dWdGdlZTdzRZZzI1RHA3TmVFZXpFR1Ni?=
 =?utf-8?B?Wm5WaE9aMDNlNnl6Y0N3Q0tkS0xweVpTTUFldTRmMSt1dlZnQ2ZaRytIRHBZ?=
 =?utf-8?B?Q2N1MUQrK01pSHREYVZmYWMwdXZweThQWStBV1JmaFZhV1h1MGRiYTdyWmRK?=
 =?utf-8?B?aWdKc2R4Y05QSkM3emNTbUNRRFV1Y0JlZWdxMVBvUS9Xdkc4WkJVVmRYckc5?=
 =?utf-8?B?RUhpRWtraE5yb08zaDZzTjF2Nys2b2U2ZERhTjk0RkM2eStBT0ZITE1LZjZy?=
 =?utf-8?B?bjBvbGRiY2YzMWdvVy9HdnF1SFRiTFZPYXhsSzR6YWdOMDc3UGJ3cVNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFBGb1ZRSG1zS1h0TEhoaWgvR1dpN3VZN2pzbHVjZVVmN1NFZHJ5Ui96QmlT?=
 =?utf-8?B?MFp4QkdLa1A5b0FlUTRZQU1LR1dxRmdQb2NSL3ExZkFoZnRmaUsrUUtJNEF2?=
 =?utf-8?B?Mk5nVWhheDFJWWFhSXhCTFh0V0dhREFzeTdSWUM0L2VXMDZFcXJLWU1SZ0Er?=
 =?utf-8?B?bkdXREg2bU10N2FHYkh0OE9CcDJhL2o3eDI5NWVtWGl1RWlha3dDa2JNZXRS?=
 =?utf-8?B?SEs1bXN6YkRldHJrNk8zdjFHNitRRWx3WUU5OWJQakpucTIza3hiVFNuRURY?=
 =?utf-8?B?WFVXYTVWTDZSaHJxQXdGNHJKWkdQazFIRVd6RkczbUtVelgxMHQxbUpmbG4r?=
 =?utf-8?B?QU5KdW1NemIwNXkzaUd4K2lGWjZrTHhXSDhJTEErL2pteFJrWUdGNFFYRDl5?=
 =?utf-8?B?d0Y5SytWekt2YVc5cXhlRTVxeW80bG1TMFp3d3RnbDhDVyt2SXBDdlRnZy9y?=
 =?utf-8?B?ajUwU3V3blMvVjJWMzZEdVZMUTBINjBVZkU2TW9VZEJvU3NOWjFUTVpkK3ZT?=
 =?utf-8?B?bjdDTW5jcjhGVWNRL2xHeFUzSlRVS3E4QmNMalh2cFMwNkdWanZrMk43V20z?=
 =?utf-8?B?SS93RGp5NzVER2I4Nm5hdzNIRGp3S0xEakNveElsUFkxa0NrNjR4UGtzNjFa?=
 =?utf-8?B?Ym5IdlRQczNIZkxvTWoxUjBTUUlwdFhKa0g3OTZDVE02eGtOL3p5ZW8xdEdn?=
 =?utf-8?B?VFA1dU04TDJxV1FMNG9iTzlSVjV3UTk4RU52MzFQTkdyZURmbDg3WHVMTjVz?=
 =?utf-8?B?eW1ZK2RtMVdwNVR3THFjWll5RFRkdzVsc24xa3g5c1YvNXg0YTRhK2ZpKzhn?=
 =?utf-8?B?SlY4VWJuMnlOUUloN3Q0cHRHVTFLUThrMjZBdW9hazVjOUl6SndkbXJsQlJD?=
 =?utf-8?B?SFZMd0k2SE5xL0UvU3Q4bW1BNnNmTXUrVjFyTGQzdkpDL0YzVkV6aGdERmVP?=
 =?utf-8?B?cmN5eUxhUE03VVJIRHhiazl0cEUwcVBjTWlSNHBoalo0MjZCUlpUMk9nbHZu?=
 =?utf-8?B?Z0dSTmlTaWtTdzNDU2lGc29rUlJ0NmU2bzIyR0V2TjYweWtveWJZNmIvQndH?=
 =?utf-8?B?SjZlUWtGMW1NU0RpZjVmR0UrZWh0Mm9sVXRWSFNsSmQyNGg4aWsreElUQ1lh?=
 =?utf-8?B?VVRpUTVGTzRNeVkrLzhRTWJPL284N2JEVUJib2tCVW9YeXpDNG85S1pXRXUy?=
 =?utf-8?B?aHFmY0pTNkVGZkorRzlRUjBkbC9GY1I1TkZ3emZxV1Rsdm9BSDArOThKb0pw?=
 =?utf-8?B?OW54N1pmOVFSakpiRzFUcXh3Y0ZNQi9kMGxHRzhZQkxSYW9rMktsQTdOczFl?=
 =?utf-8?B?VC91OG1nUXNnSDY2QU5EV1VlUWpUNnNsMEhSbk9BSnQzYlN3aGoxSkpkM2Zr?=
 =?utf-8?B?c1BjbEo1TE51RmR5N0xuYlM4QWpudGJoalZmbE1QM1A0M1d5Z2NXeUhDYXNq?=
 =?utf-8?B?eVM5NzViMnAybWxldDRrM2dXRmhSQ08vbmZVL3lCK3dNeUlPMHdSbG5rSFVt?=
 =?utf-8?B?Z21jRzdiSzVQaUZZN2RQYTQ1TkNhL1F0a2w4NjNJaFhwZmdCMkN1Z2dNVXZR?=
 =?utf-8?B?U2NhSE1jV1hValdqeFJqL0x2YzE2NG01aFhHcU1wTVVrVU9xS3h0OURyNnJ4?=
 =?utf-8?B?Yi9GWjA2bmZ2ZysvSHRzVVpsWkhvWCtVTjdzdmpxRTQzSTdJa1BVcVZOSmNQ?=
 =?utf-8?B?R1QwbDhFQklUZURRa1RGc1dFa1ppend2S0RpRVhjWVZEdmErQ21pM0tvdFVQ?=
 =?utf-8?B?SU42c2VRRDltaGZZQUZvQithTHVwc0xyMUpPSjltMWpkTHU0TW5ldVV6N1Fx?=
 =?utf-8?B?ekZGWndiSzdOaWNiUng2a1dQUll4WWpDV0lZaDdnUisvSXlCc1dUcC9HRUpK?=
 =?utf-8?B?OHJ4a3krUVBDaFgxL3VUNldUZ3dFNUcrU3BMczc3VDlBUU5GVkdTV0JxN2lN?=
 =?utf-8?B?TENOVXlsUVVTdngxc0VwdDl3KzZ6MitCcS9ERlAxYVJOLzk1ZDF1L1BHNGVS?=
 =?utf-8?B?M3krLzBsbi9RcU16dmhxWUxuMkVTcFRpaytiUkRRL0FCNEZLWWg5eXBYNURt?=
 =?utf-8?B?MU1PY3A2Z0JiZE1BcEIzSEJXaTFud2Nmb0tmcGQ3aGtUcjRnTzZGWEs0b2lT?=
 =?utf-8?B?a1NkcEVpS3ZuMVM4VmJCQktGbDJYNmk1clFnRFU0MHlzM2JwOGxYNnc4T0ZX?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bee270-9ea9-4bfb-3a7c-08dc6d9c9abc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:17:36.1256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKygGe74Ugc0OlKR2ds0W8HAhkZ/zrF5VgwCRb3xs47WTirEQa/EFOZWg733scGy4yYTE9TiurLZy2ZfC2Yip8nBdKE4NT/bMBQsh8dEodc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8975
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

On 01.05.24 04:42, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Frieder Schrempf <frieder.schrempf@kontron.de>
