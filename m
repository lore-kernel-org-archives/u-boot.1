Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C2BC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 150C180F7B;
	Tue, 25 Feb 2025 12:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="U7ks3krq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9F480F92; Tue, 25 Feb 2025 12:13:15 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F45680F53
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mu/a2/95hm+dqLV7oCrvQBfan8ar7D4CuoO1iuakEVs19rH+00DqDV5p+IdnJJmbCdCI/HyclUMutX4T+SPnjGQ9O1T4QpTi8j/m/5lITZt6PosJTgoeGg4Ju9wnoK+RB3uJs3e1nUKaAcKnVBcAzw1u3JXZMFmAo3cSM8sz4Gv/uJ1Sr2MB09tm/xlilrkNsjBxMfenUyecmzq0WAcbnNPg6rppDCn2kz15vilD5paj71ORZcs7Mg8pBJg2XdvMzjCfXU2OQO2xh6M08FzksravKyKI+2hjEnWJH1nM9XE948vweROyuqx1CUvpXbWr7lKn1SrYTGk1wPm5orjPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fukrI2v6RdPIeg0q8HBJN9GkyvFWf3XM8MREdp8O6zs=;
 b=QCb5L4JWJsxt8ieJgudgR0qkwW+6KbPAsKf3NXG0LzbaLTYTglnOZeBTtMF9m3W/bBl+KNYrJ7h3py5/hxYPWJu16vDqpL66nMz2P0SgSJHqt6tfxPbzRdxsY2tVwjnpKtw3kae0bipLp1qxVnX5+yaPGwS2xKf3mKunjAE0zW8BARaZvFooKjiC61vFGbW0Z1gwkhEXC1zcma0IH0bI3HnSkkOMVVeXqq1VR1yHe2YyaO7FpgmpDLwhCV9EvhG4uR7BoY0GZCAL5nUZX0NgElqH+273PNwnPFI4esDDWau/ztctnTefCTfjUbsRYMjzCkDGXc2GeHvLDHWBpUUjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fukrI2v6RdPIeg0q8HBJN9GkyvFWf3XM8MREdp8O6zs=;
 b=U7ks3krq9XExkIgBq9hIzCIF/uQfBr8klXedVy+JrjGiJtUSxE4tYW7nSpmCnbwOh44xFrC+OhtuwXMXV1fcK5MWXx7cmdzIlWqRAlCKYvBTTVU5b4IXw2UeJ02b6XqW2lBiObvV5B49Psr+G18Q4LWRQJY7WoKxLIULZJ+dqVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6889.eurprd04.prod.outlook.com (2603:10a6:10:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:13:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 11:13:09 +0000
Message-ID: <308422ff-3036-48ed-9d78-305b6904fc87@cherry.de>
Date: Tue, 25 Feb 2025 12:13:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] led: fix next coverity scan error
To: Heiko Schocher <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250225094923.71364-1-hs@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250225094923.71364-1-hs@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 286b3a07-3f0c-4445-5ddb-08dd558d62fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWxnTWZVeUpmMjhPaHNkMTJyK1dxWmtRWS9WVnpCd1h4czQwQzg3L0dDVDB6?=
 =?utf-8?B?VDA1eUQ0VzltYmJHdWtJMTVzSStEalVzZnNsYnRoSHIwRUNZa1VQQzh3cG1t?=
 =?utf-8?B?OTRaSUc3VjN6VTVKVWg3R0dtRHZlZnkrLzBNVFltMVdwVEZuUHROd1ZpNG5W?=
 =?utf-8?B?UmhxM3pHVTZUcXU0UCszOGpRNkI0cGJPbzRaNDNSdWRDV3NCQkRoYVk0blF6?=
 =?utf-8?B?UUNlTktwbjk0YW9yTUJwcHBIcUlUakJqbVExdlF4WnJzU0JVVWdreHEzQmZK?=
 =?utf-8?B?azNlbDBRYzkrOGNGWXZZT05OR1VMVFlpVDQ0TUltL0VFa2lRVzhhQkhTR1Z1?=
 =?utf-8?B?ckptVTVxRURxeDV4VHFtUjdMT1dvUisvV0pBSTc4OGZWTjVDSlh6MUIzQlAv?=
 =?utf-8?B?L1hwV29OZjN5cThVdCtRU3RjRE81VUZOU3IreW1KM0dpcVFnYVF2Z0h0OHRj?=
 =?utf-8?B?QlgvWjdmdTRiTUVGTmxtUi9KQkV3bEtYTW1GdkdkLyt0bEM5RUdIcGJqWGlH?=
 =?utf-8?B?ZHlkYlJ4bk5MYzBPSmppSDViV1lIdGRtNGNEeWZDOVhpckYxdWtYei9pUzBn?=
 =?utf-8?B?QW14Yjd4bG05eVpPR0xGb0w3YVJQTnBjc2tVaDVHbzJ2UzV4REFGbjhlbjZQ?=
 =?utf-8?B?R0dnbWtvbDdGbGhoYytnb3E5aXFGTlZ2aHJHS2pyVnpwYTBETUpma25zSVdj?=
 =?utf-8?B?ZTV1S1BJZFRZazVQUXZJUWpRL09iQ1plNVI2bHJnZU5uWnQ0NTNNZmlNWERD?=
 =?utf-8?B?TUhGVndld1BzQXVEb3BSRFF0RlVaNG1qSUFZaU1qSlQ4d3BMUDV0eFpaNlVn?=
 =?utf-8?B?ZDRrMzQ3SWNJaEtUVnpOeWp1bVppMkxkdllkZFppL1FleDlFZFR3ZmJLTUVO?=
 =?utf-8?B?Yi9zaU5lbEZvU0ZVbnFJQUZjMElhZG9mNlFZdXZGRlVPVFkvWjN4R3hXRVNQ?=
 =?utf-8?B?SVUxTGhSMGdnSm9DM1ZFdm9FSVQvZC9Venh3OHh6VXZra2Q0VXdmQ0VKeExJ?=
 =?utf-8?B?MzZxRTJ3SHBORGRhYzRGaEFPM2MyU1RBVGYvQVpPNTN0Q0ZpbHBLamJ2Zmk1?=
 =?utf-8?B?RS9MMmZBWkdMUld6U3RMK2s2czI1V1BBcHpMY2ozczIvdEp3YnV2c3JOVVRH?=
 =?utf-8?B?WDI2VkVaMy9uK1hobTlqYXFrc1Vod1hkaVVpZHF1dDQzSkIxR25GRmpEeGpH?=
 =?utf-8?B?T1puQVZvdWxnU2VOZmtadnNNa1NuSzM5WVRuckVDeDBZWWtEakxLa08rUmpu?=
 =?utf-8?B?NmIyN0taVTNYUklPdkJWcVdMQTVhWjRIL0ROcUdJVUVmVzArYW1uT1N4Vjlz?=
 =?utf-8?B?VnNLam84T01OWUpoMEw2NW5JQmQ0SVo0c3l1RGt1V2lJdzNUdzNEaFdOYUhF?=
 =?utf-8?B?Ym9SVEVDT2IwVDNWbDZrVUJvKzRTTDZnaHhnUFBMMW1tcm9VV1pNanN1Z1VP?=
 =?utf-8?B?a29xZmh2MWJ6Uk1kQXNmOXh6bnhrTlJJcm5sWTlRVW41QW1JbGFHdVhtQWky?=
 =?utf-8?B?N25aS2NzN2VWbUs2SGhIRW5HWEJRRVlpZDIxWDBTaURXUDgzdEpvc2VpclBV?=
 =?utf-8?B?NXdIZFp3ZFNQcGs4Qm4xSmlEUFV2RE9URnZ1bGJsWXNYakxUb1R0UWp0N1ly?=
 =?utf-8?B?djZ3TlJNSnoxZ3VMbjY2REFlbDQzaStMUmhsL3FodjhBQkhHSVBmSUlLRmFN?=
 =?utf-8?B?SlQ1VlJEYWI2a3hhaHJ0QkFrRUxWUmJ4MnlOZll4WDQ2eUU1UDNpbzRXa0Fx?=
 =?utf-8?B?bUdDMEY3QVo0TmRuci9hdlF3ZEpidFlqa1B0SFl0Zm53a1dHTHlidGJTVlVB?=
 =?utf-8?B?YURCdlhsZUdjMCsyWEF6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTFiREVmVkxLNWsya0xBcHJEcHVlY3hOOFI2d3FrVTVablA0dVg1OGxJY3JK?=
 =?utf-8?B?N0QyczVsZFArakdwajVQclVQWnFQQ1hIbWFOM0ZZWWVjNkNQbFVoSHRBRlFC?=
 =?utf-8?B?MFJhemVkdDFGWFhHZ0RHN1BKMlU2N3NKc291UGRnbVEvMFhFSlIzdmJ3QjA0?=
 =?utf-8?B?NERaZFRsSkgzNVlaS0YvbXZFSkl2djZKUDliTGZkTmJJSHMySmt0aExiSFFI?=
 =?utf-8?B?TVlDYXA1bFpBWml0U0w3dlUxYlpicG1PL05uZGNLcWtGZWNhaVBwSHE0RndW?=
 =?utf-8?B?U1U3OVR2UnRLbXNWdHhpUVExVFEva28wclN6QzlLdWJpR1VMUHBuMmU5T1Yz?=
 =?utf-8?B?UlZ2RHgxaERRclgrUWE2cVBBOFJVWUhJL0hoTVdxZ0pxL083V2xUL0Z5aktU?=
 =?utf-8?B?OFp5U1gzNW4va1FwSEV1R1ZJT0NMYVl3d3lWd0xTZ1Q2aEtCQ3NYdDhBRmQ4?=
 =?utf-8?B?VnVTK0thOFZpS3JEUjB0d2JtdlVYR2tZZUFEZW5PY1cwdlFOWFVQdmJ6RlRU?=
 =?utf-8?B?WW5MRUcvbU91RThQeHdmSlAvWFcxUGxPZFRtd25Uem4rQUtwMXBNZUJUaXRk?=
 =?utf-8?B?eFp5VHM0QnJPYlM2cWRsQjBrRFRLV2h5Z1h6UWZlYkovN3lsZkdwdmlablBl?=
 =?utf-8?B?M3UwRkpnYVp6NDhrdnQ2QU1vaS9EV2dNT2QydGdOM3pBQ1hRTkhYeEtvRkNm?=
 =?utf-8?B?RTUwb3R4S005ZnUyRWw0a3NVT3B2MTlkdUFGWFdVU29pUmh5amNLWnBhUVp4?=
 =?utf-8?B?akYxNEtaQ2RaWDRZdUk0SUlGV2RuL202OGg0WmR5eVZxN2NiQ0pJMmpqQ0wr?=
 =?utf-8?B?c1RlZzNzaU96dnZxTTZibnV0L1Yxc1h4blp1dGtRMjVkRjdzSlhWT2xLcUxE?=
 =?utf-8?B?U0hiK2d6VnBGWk5rY1JjczcyaStHUXQwNjJYVmJtNU5BNzFuSXFOcVlMR1I2?=
 =?utf-8?B?SkVEeURYYWtmMHJxV3pZT1ZRTis0L2NUbU1pL2VyV3IvQ3dWZU9qdEEyMmNV?=
 =?utf-8?B?WDFqNjZ0WVFLL3gvSjZEQWF5d2s0SE9MUTNFcG1hVyt3U3JMZW5xNGdoSk9N?=
 =?utf-8?B?QTJVbHNuTVhYazV5Z0hlL0p3QWVtbkkwclIweEJ5ZFhUTHB3UEpCMThtbG01?=
 =?utf-8?B?RHAxaHVlbWJDejVyVGF4VFRrOVZvRFYzZHRLVmZINEFFNkNlWHhxNVhTVDFC?=
 =?utf-8?B?TjRIcFlmcGZRcWtESEFwVThPN214c082blZRaGJ5NUR3QU9ZN0h6b2FZcGxv?=
 =?utf-8?B?cGRNeTlHbmNIUWx4YURNUmMrbXF3aGw5TjlJQzVHcHh6VXRqMGo4elNUaXUx?=
 =?utf-8?B?Q09vOXZVcjJSMWd0em9LTXVUSG1HejBDNWdMWDNMNFZTdHZ1ck5WSE53Y2tD?=
 =?utf-8?B?NWRiOEFNdTVoak9sM2F1WDlkVzE0RjlwR29TZFIwMWtoQzJDN3l3MlpDMUhX?=
 =?utf-8?B?UndLMWdSWlVIVGpMSzBWRXZVUW5mY0ZmUU5oUjh3b0V4cmt6a0RSVDQ3a2hk?=
 =?utf-8?B?S0RKeGpzcHFNLy9JUUlmenBMUWVpcm84VGg0UGc1aVo4WWNyQTRoNFgvaVFw?=
 =?utf-8?B?S3BjRXhwdTdzVFRpejAvNUwxa0R6ZGwvT1dXQkYzK2RURTNWcGFUaHY1bm9I?=
 =?utf-8?B?WlZ0MkRGY0YxaDRmT3loR1dtWGhOWjVnUzVaMytwaXVSakNmWU9VNFpTNXJ2?=
 =?utf-8?B?R0pISGtNVTAzK0xNZm0zaVNRNEFIeERTWTJXeDljN0w1Nk45T1hWdVJ0eHd0?=
 =?utf-8?B?YWZvNHVHamRIbU5uT2IyZEljeHhLblhqOWtxcmQ4QXA2OUc5cWhURnZxMTYy?=
 =?utf-8?B?S3VNd1I0ZE53RVdQaVVzb0ltMlNlUWVVZ25pNjZQdXZleXhjTkZqQTBtU2Mz?=
 =?utf-8?B?WHNwSTd2VjAvU21SYkVLWkpJZDhvaXQxS1BVUjlCMzQzc2FnL0I4bFJ5ZEtY?=
 =?utf-8?B?QWZKQ0tVN3YxYjA0dWZyL2UyNm1Oak1vaWlxR2xpa00xZndpOVJ3eWR4TnpB?=
 =?utf-8?B?S3l4NGFvMTY1MG5YRS8xSEdMZFpaa0JsUUNScXBOSis0amZUZUVsbE4yRkVR?=
 =?utf-8?B?MHBoNkhSN01EZHM2QmhGYnMzaTdYNnU4V0ZERFRCZTZ2TjZ5VjNYZXNqQ2pT?=
 =?utf-8?B?Y1h4MTZEOWZ0eldHVWhjMk1TSlNOa3NrVVNXbFRvMlFKUEhIMm8zV1RGRXhh?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 286b3a07-3f0c-4445-5ddb-08dd558d62fe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:13:09.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RwO/sP7aj1tsMvGSmAvEA6F+ni/vv8fLJ+xZYvDK8WZnA+f/mxvcdvh6VKBvpTR1DZ6cdPBnVavuPX9CP8mLJCetRlPI86FYgr0J8dino4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6889
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

Hi Heiko,

On 2/25/25 10:49 AM, Heiko Schocher wrote:
> Tom reported the following covervity scan error:
> 
> *** CID 542488:  Control flow issues  (NO_EFFECT)
> /drivers/led/led-uclass.c: 277 in led_get_function_name()
> 271                     return uc_plat->label;
> 272
> 273             /* Now try to detect function label name */
> 274             func = dev_read_string(dev, "function");
> 275             cp = dev_read_u32(dev, "color", &color);
> 276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>>      CID 542488:  Control flow issues  (NO_EFFECT)
>>>>      This less-than-zero comparison of an unsigned value is never true.
> "color < 0U".
> 277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
> 278                     cp = -EINVAL;
> 279
> 
> see:
> https://lists.denx.de/pipermail/u-boot/2025-February/581567.html
> 
> Fix it.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> ---
> Azure build:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=171&view=results
> 
>   drivers/led/led-uclass.c                       | 2 +-
>   dts/upstream/include/dt-bindings/leds/common.h | 5 ++++-

NACK. We don't modify files in dts/upstream as they are directly 
imported from devicetree-rebasing tree and would either be replaced 
during next update or induce a merge conflict.

>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> index 22f61d12d38..e2edcc43f30 100644
> --- a/drivers/led/led-uclass.c
> +++ b/drivers/led/led-uclass.c
> @@ -274,7 +274,7 @@ static const char *led_get_function_name(struct udevice *dev)
>   	func = dev_read_string(dev, "function");
>   	cp = dev_read_u32(dev, "color", &color);
>   	// prevent coverity scan error CID 541279: (TAINTED_SCALAR)
> -	if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
> +	if (color >= LED_COLOR_ID_MAX)
>   		cp = -EINVAL;
>   
>   	if (cp == 0 || func) {
> diff --git a/dts/upstream/include/dt-bindings/leds/common.h b/dts/upstream/include/dt-bindings/leds/common.h
> index 4f017bea012..9e5ac5196e2 100644
> --- a/dts/upstream/include/dt-bindings/leds/common.h
> +++ b/dts/upstream/include/dt-bindings/leds/common.h
> @@ -21,7 +21,10 @@
>   #define LEDS_BOOST_ADAPTIVE	1
>   #define LEDS_BOOST_FIXED	2
>   
> -/* Standard LED colors */
> +/*
> + * Standard LED colors, LED_COLOR_ID_WHITE must be the
> + * first one and start with value 0
> + */

Can you explain why white needs to be the first AND be 0?

I don't know enough about the C standard or compilers in general to know 
what happens if the indices in led_colors aren't in order but I guess 
that's where your limitation comes from?

e.g.

   static const char * const led_colors[LED_COLOR_ID_MAX] = {
           [LED_COLOR_ID_WHITE] = "white",
           [LED_COLOR_ID_RED] = "red",
           [LED_COLOR_ID_GREEN] = "green",
           [LED_COLOR_ID_BLUE] = "blue",
           [LED_COLOR_ID_AMBER] = "amber",
           [LED_COLOR_ID_VIOLET] = "violet",
           [LED_COLOR_ID_YELLOW] = "yellow",
           [LED_COLOR_ID_IR] = "ir",
           [LED_COLOR_ID_MULTI] = "multicolor",
           [LED_COLOR_ID_RGB] = "rgb",
           [LED_COLOR_ID_PURPLE] = "purple",
           [LED_COLOR_ID_ORANGE] = "orange",
           [LED_COLOR_ID_PINK] = "pink",
           [LED_COLOR_ID_CYAN] = "cyan",
           [LED_COLOR_ID_LIME] = "lime",
   };

is ordered, but what happens if you have e.g.:

   static const char * const led_colors[LED_COLOR_ID_MAX] = {
           [LED_COLOR_ID_RED] = "red",
           [LED_COLOR_ID_WHITE] = "white",
           [LED_COLOR_ID_GREEN] = "green",
           [LED_COLOR_ID_BLUE] = "blue",
           [LED_COLOR_ID_AMBER] = "amber",
           [LED_COLOR_ID_VIOLET] = "violet",
           [LED_COLOR_ID_YELLOW] = "yellow",
           [LED_COLOR_ID_IR] = "ir",
           [LED_COLOR_ID_MULTI] = "multicolor",
           [LED_COLOR_ID_RGB] = "rgb",
           [LED_COLOR_ID_PURPLE] = "purple",
           [LED_COLOR_ID_ORANGE] = "orange",
           [LED_COLOR_ID_PINK] = "pink",
           [LED_COLOR_ID_CYAN] = "cyan",
           [LED_COLOR_ID_LIME] = "lime",
   };

? I think it should be just fine?

Reading the code, it seems there's an assumption that led_colors has a 
contiguous and full list of indices from LED_COLOR_ID "enum". What 
happens when the dt-binding gets extended with new colors and the DT 
makes use of it without updating led_colors in led-uclass.c? Aren't we 
going to try to print a NULL string?

If that's the case, I see two solutions:
- ignore LED colors when they aren't in led_colors,
- decouple LED_COLOR_ID_MAX from the binding with UBOOT_LED_COLOR_ID_MAX 
which is the currently supported max based on led_colors last index 
(+1). We could even do a #warn or #error so that UBOOT_LED_COLOR_ID_MAX 
and LED_COLOR_ID_MAX are the same value so that we're forced to keep 
them in sync, but that'll make Tom's life harder when merging newer 
releases of devicetree-rebasing tree.

Cheers,
Quentin
