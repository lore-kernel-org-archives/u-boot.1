Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20775C531DC
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 08:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7770888680;
	Mon, 12 Aug 2024 10:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="I5i8jnfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042B3886B1; Mon, 12 Aug 2024 10:58:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF108860B
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 10:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWTa4tHXwbgw2+Qpy8V176F3xDfpRhvWakpk0LWeKUhdavOWq67QiQw9M3pAlp7tx4rJQWXXmeBO++RomsgyKe0jihseAD7UhAOAzYeJpzqL1bWuFjXuufhjYmqYVdZIbVQqd1J1KSaTCh53GsIq0iXQFGqYWDcH3nW6PndJAZNhEXSFiIHlPlAUjzzI6baRkC8OklA2wyNS2Q76i3lAjH50qBUhXW2zRnpTL168X5tLfu5f+29hfAE0AXJQJiel8MXzyuBL28xXDW2sdP9m72k4WoiT0WSed5spprf16SdzRmmRMlDSbgGjlN/BMiSyAFq3rlzqgXMskt7qcNzr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAYV8HnFdeR146R0zlScPr5H4CK9eGAJfHpCy1PO8wU=;
 b=cGiKKrXLkaH61i9zTqACnmgokql73MJxk85wVBrUDE1MYX3dOsT4VaG4EvpIm2yJ6XR3kQYsmvQpsFMhw3JHjc/8mIreT8xYlfkJqI1yQCfIJG5VM24i6ShLqQlKV8cSRQAa7TE8Hh5UcjvTguVNix1BiDwD0d3bBz4VXvBRNgoKhxPJTlwyAbXOPzjBlfkOavTye3Tq9Uto015wpMmXRByJJZeQeqw38IoHseBJ375pQPmrpwIdnhKTbHEy/PecgJ1RTvZ/LFUXkhUKm5NbqEFW+590EfF/j+wOQkBXtlyBewtOYarcmy6q5duClC0sEHRaJ2tFLaiG9+mhtrJ3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAYV8HnFdeR146R0zlScPr5H4CK9eGAJfHpCy1PO8wU=;
 b=I5i8jnfUai8gmMBhc8zfyjdxx0zuqNZ/BANCGaQuOpMExBH624pZhsH0vw1Kjr2rz4DI0A4vAXoORRNuW5x+meOPTqiK8RgqVlZUFvYHnJh8LIBDnvLd8pIppb8IRHFzCQO77MDbM2seCcKSL9/UUtF6iE7y4DDUFNlkSLt8quk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Mon, 12 Aug
 2024 08:58:13 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:58:13 +0000
Message-ID: <c7483e63-f51d-4b8c-9340-acf75e1f04b8@cherry.de>
Date: Mon, 12 Aug 2024 10:58:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
 <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
 <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: ae04704a-2e89-4ef3-d273-08dcbaace5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCs3V2VTOWh5R21jZGpOZktsWkJNRDBtbTRTWksxOWdzVUpzZFFWNU54Wi9a?=
 =?utf-8?B?UC9BNFhiTXJFZGlZTE9UUkhGUlJHTGFWWGc3QWdDditjcWpuMFZrR2cwMTht?=
 =?utf-8?B?L1ZiSzhxRTBBMEJ1OUk4R2cwMkJEcjh2RkpoTGdXcHQ3TzFWUEk4SE5LeFFQ?=
 =?utf-8?B?SHk0cms1dXdxQlRTZEtZWHNLL2h6WXJlQzk4N1pVTDdEeENpeWVBbmNhYnlB?=
 =?utf-8?B?YTkrK0VOMzM5L3NBb1hwb3UwR244S3pWVEt1TnlkRUExdE9HRjJVMUFNNVNU?=
 =?utf-8?B?eSsrbDhSR1JLYk1QSUMwY1ZxSWV6bElYZ0dpNHAzOFNGaU02KzA2T1NEMnhu?=
 =?utf-8?B?TzFWWGRKc2MvKzN0dGV1VDZidkE4cGV5a3l5NkxwRXhUSnlLZUx6emFyaWVN?=
 =?utf-8?B?cGdiNlkxZ1BqVnBtMzJDVkFDQiszd3dZR3JqVStCZkRNR3JXZkllRUYrd28w?=
 =?utf-8?B?em9XTUVmbGd5WUNYdk0raUIwbjl1a1FROGszc1FVcWdzNENBOC9LVnhtSExJ?=
 =?utf-8?B?dlY3bGlnZS9IaDhIY3hySkNzWEVjQXB2UkQvMzdsMTU1NHBPSTR3ckVKVk01?=
 =?utf-8?B?cnpMSXREMnJSNC9ob1lERU93NElDYkd2MFhkTDljU1EzbmRXNG42OE50WWla?=
 =?utf-8?B?TFNQRzh5MG1PcGpxWGZkVXJOcENEZElMa0FCQi9Qd1lxSlIydGZQbEtEZHQ1?=
 =?utf-8?B?SlEvdmlMdXFFb0RCYUdaNTY4ZExiMDZ0WjhzSnZYSHRjSUcrMGpjZDJaVTR3?=
 =?utf-8?B?UWFYYnNFUEUxYWYwMzhkQzFNcjBjQTYrcS9kYllwVDVENWFuY21wY0l5UFNI?=
 =?utf-8?B?NUt2MEJ4ckh4dTRFZWNMMHR3TlloOUpadnFHYmxldjlMTW1vMDJ0bmdmNlZl?=
 =?utf-8?B?V3dnU0hUKzZ5Ri9OaE5tSXZaa2JCU0pFc1ZWUFRKLzFpMm5pUnNLNHA3QXp3?=
 =?utf-8?B?Mko3clFlb1B6RW54dnJKNHJvUVpUVWxmK2ViZE5yZVhOcU1IV0FXYmU4dFNV?=
 =?utf-8?B?S1JERmN6S0F0SFBubVFHZ1RwbVZpZDNKUHpWRExpREJZbFAvRTZ3WXR6Y1hv?=
 =?utf-8?B?Tk9IemorOFlMOWFVUUJVbHRhKzNLWkVCaDl4aGY3K3hrQ2Fxc2FCVjVLbW9w?=
 =?utf-8?B?b1U5MEVVN2c1MHA0UlpsL1B4QVNESERySzRnNEJKM0NEbGdQcUJnM0IvNk15?=
 =?utf-8?B?eERTTmZZNHZVR2hhcmhTRTdDZ3hibktCYkNiYTl4MlFVTUI3V1lseDVHZERa?=
 =?utf-8?B?bkRZNWFIZTlOd0NWcDg5YnFoVFJ6amduVDJQZDVQNHJNT3BUaTl1WUJ2WUJB?=
 =?utf-8?B?b0FvcVhBREd2N1RiWjE4OEttOXdlQi9mZStENkRRMDh0blVkVC8zaDIrWGRD?=
 =?utf-8?B?NlRBWGQ2Q2xFbmNsNDFyU3RIL3pzRWhDbmxTdzNjdkxacVlCdDJDY3ZnTDMv?=
 =?utf-8?B?Ry9Od0g3My9HSXNheUM4TmFFM1kxVDdhc3puUm9vSFBCM0ZiV0J6RG1OSFFl?=
 =?utf-8?B?a0RHZzdNbklUMVZGenN5SU90MWpkMG9aRkJhb3ExSmdWNDN1Vm9wMlFxK2xE?=
 =?utf-8?B?SzkvMVozTCt4VXFYditHM3FFN1ZVVmlpSVNGRi9kWTdGcVhEd1JsQlBLaXBW?=
 =?utf-8?B?TWhKNWtaemNBdjJweDhRaitreUpBb2Ztb3NQUXJkUFZ4d2x4Rzd6WkJuL1Fi?=
 =?utf-8?B?d2RMbk9rRm4zK2JFMGdqNC9maG5LZjRLNVFxemErZEJKdncreDZseFhFRk1Y?=
 =?utf-8?B?UnF5R2w2U2J3RE1oS0d2b1NhY3paMWxSMGlnUERrVytvWVNpM2ZaMUNJOFRE?=
 =?utf-8?B?UEFPTnhDUWFwdktsRFlOdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHNOeForNkdreGdrN29keWd6YmRId2NEZlRyRGFiYi9jbWlIc1c0Uzd2c25q?=
 =?utf-8?B?bVlPU3k5c210LzcvMnV2bkJjNWNLTUVMakJXY2ZTempkdUxtTklZYVMrMVdV?=
 =?utf-8?B?bjlqSVUwZXJsWE5JYW9YaDVIQVR3OFBncUI5WlpjZHJ0V0N0eWhGODk5T2FK?=
 =?utf-8?B?MDVER0F4MmRaQzVyS1VaOG14Z3VQK3FyKy9Qaml2RDJSVElZZ1RTZWJWTmFa?=
 =?utf-8?B?RHl0M1BXODlIWHpRWnljRFpwWDcxaE1TT3JZQmxsT2NKdUZOWjFuNFhZQjV3?=
 =?utf-8?B?aCt2d2UvdHZ1ZTVvODEwdXNJQ3R2NW9RTmo2ZUdFVmNTa3UyRnBNckZXVjQ1?=
 =?utf-8?B?VnhLK1IwTHk5UXozZ2R5Y3htUVJnQVIxOENobmZxMGUxREhPOTZ0MkNuSzV1?=
 =?utf-8?B?MkpHU2VGbkppcDFTWE40a2haU2NZemx2OVlPQUYyTXg2SXdVS1hKclJESFc3?=
 =?utf-8?B?TS9nTmlpek9obGZoTW5xU1NyVHFNMnNIanZ2eVBBV216SGVOaVVsQ1BqRGF3?=
 =?utf-8?B?V2lDbzRheU1QNDlhdjVWdHVyZWc1MUF4dlBYQ1dudXljQkxBbWYzQy9RZWJT?=
 =?utf-8?B?aFhVL3hZaFlUYi9SeldrTXoxSnVucjRQdGpqUG90ZGM2N1NPL29uREVNaWhO?=
 =?utf-8?B?dXg1aEFFMGxPQVpMWFBzbERXVW5tb2RMc252RHZnR2FyQzFrVHlyQ3VySnhC?=
 =?utf-8?B?aGFjMWhIU1plcXRVTW4xZUNodGk2T1JHbERjUGRmT3grVldJZkNESzJLL0Rn?=
 =?utf-8?B?R2hJWUFwVEhyc1JqVnNDMVFSK2Q3MjgzV1h6M042Q1RJNTRMeERnUEpNY3pR?=
 =?utf-8?B?M0VpZlcxWVR2ckFrK0twU0ZKMWNKMWN6K3p0aUVSSVQrZ3lkYWZiMXFuMlg4?=
 =?utf-8?B?djRyK2Y2blNnN0FRQ0gxTTJJbFh2ZXc1UHpXNzQ4c2w0eDRaamEzMkZhWGZh?=
 =?utf-8?B?K3Izc2NnVHNxazJlMWdhblhVNVA0R0FUMkw0WTI2S2ZHS1NSLzVXRy9mcjJO?=
 =?utf-8?B?M0VoRU9PY0doWlZOb0pMSVBGeXc1T1B6MDdkcGZ6QWhGVWhCSmUrTzZ3b1d3?=
 =?utf-8?B?UEZ6eUk5aTFXMnJIbXBXMUcvZEJnNW9vSXhZdUVtS3J5YWNST1BHbEJ4ejJz?=
 =?utf-8?B?bmVTMDBBWTJYSGxmaG1IZVh4YWEzVEVoT3N0QUU1cG1JbUhpUjZ3Ryttcjk2?=
 =?utf-8?B?VVQ0SGlHaTl1ZTFxQURHcGNCOG45enY4ZDhTbnVXRGFGTHhEdXViSjNCV25O?=
 =?utf-8?B?NU15aXd0c09ZcmZaMWdpTzJqczdFeEJ5R290ZWhCT1M5QkxnVWlpcXNQaW50?=
 =?utf-8?B?akJWSzNNWUFNTHFsNXhaNmQvZGloTDZtZ09xTHJJYmMrZ2JWYzhOa0MrK21L?=
 =?utf-8?B?VHRRalVXYXhqdTlvKzV3cUtYOENPS1pQb2wySVdEeHNsNGRlelNzajVBOVRN?=
 =?utf-8?B?V0s4UXdNcndLY1U1cndtQStUSG9jblE0b2MwVUUxOFVpcHNlalR1N25Idks0?=
 =?utf-8?B?U2ZGT0xhQk12MWV0aGkrSkRUL0U0VHFFU1JRbks0dXo3RGoyY1lYaTM3Y2dv?=
 =?utf-8?B?cXI3Q2ludzNPSCt4V0tIK3llWWFieVp2MEZMck9DdlcvV3ZaY0kwWjI3bVVh?=
 =?utf-8?B?bVdPUlpUQ1lLcEZIT3FONndRc2I2UzI1NEdVc2thQUtqa2RqQ2UrZnFsd1lx?=
 =?utf-8?B?UlFpVURYeFFSZFExL0Q2OFNoKzQzWmpaMXRpUTh4YlowOG5DZXdncmt2OWRN?=
 =?utf-8?B?UzRYckhaZ0hQQUZBYnVnMGpwMkFVekVZUjQ4aC84Z29WVEU3b1lST0N6S1Vw?=
 =?utf-8?B?OUJ1TU1rVE9vU25pa2p1N0V3SE5QdE9mekFKbHl5S2lBSllRbXZsaEd4U21m?=
 =?utf-8?B?eGJJNE84dm5jeEFlOXVsaXI0cXhydkxQRXdQZUNOVXZJeHowS2NxMTNKSWpN?=
 =?utf-8?B?K2xNKzRIYzZoVG8vRWNHczhjUHF4ck4rZ3Z6dnlRNFFGcnBCZWpGS0Y4bFkr?=
 =?utf-8?B?M0sxN1dWcXVXV3M1SG50RG5odFIzVVQ1dEFURS9VbWowWGhVVHQzbWtJdkVN?=
 =?utf-8?B?UDRBU0loQjhmMy9PVWZFL0RMcU94aGVUeDNOQnBxcGhFMHBCbHFERENJRUxa?=
 =?utf-8?B?aytlZ0xyaFFGRTJrVXl0ZGp6N0VHOCtsa3hobXkrcXdaNm1kcWE1K25SRmdu?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ae04704a-2e89-4ef3-d273-08dcbaace5c6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:58:13.3173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7j/gjKwkW2pdEp/myuiDuyWdoZWVBVrdbpzRz8lwbZyelelU4zpFdLUgqfm9pAlB0YzU5KRYu5utqU+5Wzpg1N6VTIomeDYsHoKeH9QCRNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
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

On 8/11/24 4:50 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Tue, 6 Aug 2024 at 08:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 7/21/24 5:25 PM, Simon Glass wrote:
>>> Use the log subsystem instead of dev, to avoid including function names
>>> in the code.
>>>
>>> The CONFIG_LOGF_FUNC option can be used to enable the function name.
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>    drivers/mmc/mmc.c | 49 ++++++++++++++++++++++++-----------------------
>>>    1 file changed, 25 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>> index b18dc331f78..b0105afe5d6 100644
>>> --- a/drivers/mmc/mmc.c
>>> +++ b/drivers/mmc/mmc.c
>>> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
>>>
>>>                if (status & MMC_STATUS_MASK) {
>>>    #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
>>> -                     pr_err("Status Error: 0x%08x\n", status);
>>> +                     log_err("Status Error: %08x\n", status);
>>
>> Please don't remove the 0x prefix (will not comment on other patches in
>> this series if it happens again, please check :) ).
> 
> OK...hex is the default though.
> 

Can you please clarify what you meant by "it's the default though"?

Cheers,
Quentin
