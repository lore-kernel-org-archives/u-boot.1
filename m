Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A81AFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4BC84255;
	Tue, 28 Apr 2026 10:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="nBZOBhq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CE8845D0; Tue, 28 Apr 2026 10:25:58 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983C9845C8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0pRYWOLA5yYRdVZYdxSu2K2oCIqdC2EkLnHYZ73MEGWm8dAYqVZIWgbrAADqHv9mOhA7tUxYGq2k8sAMiXtjKwjy5yACHwr9cEmD+6tg1ki9+ATMyXLQ5rEkYWmCiBRhGbz4U4BV4B/B8LWMuIIm0eYX7vdJTcQamxkk2ceBc12E7TouCR2kjsKHspG8Y81yjUZLsEyfv3A28gSksCKFWR+qUpMqXYMQGpRrm7oGMaFStrHd8q8Obky6/JS8VKyngA/tVCX8mInlYLaX1ti2uY2YhnSpwJLPEhOta8kz0naBAHnxY0RTmrIviWjkwegftlvTm1QB1lz45rlWfS1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvLnQcIgMDATBSJu/8Uy+1quQHyk8t9ZjjsV92rxCJI=;
 b=s685GCywVRGFezzvtZNsvnEZuqELtpE/dpMeb/3E4/XQHdNF5sitf1c0qhB42tZZtfNjrEs56sRP823pV0jrB0Il+980MBtxyQ5FrfM8B+Bu9x4ptodPmnM5UYq05TJDb6GfHTu2Bbf1YCafI1lQq8v3tL9KY1eRTX7kp3uGjZqcffh3k5tVme3usARFpdGbYm8SmQKhdBNGWaFFs0Wj2UnJJJV5IemI4XnRib8jc5yK7ejyuC9rtVN32l2pyMNZkPjumR4rg9OSaNoMdfqyK8PRkVvo2YT+TNB2uvOf/S/KlpQ296/ibql1WGtfAXmAO4iD3mlKBY/6qdZbtBumFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvLnQcIgMDATBSJu/8Uy+1quQHyk8t9ZjjsV92rxCJI=;
 b=nBZOBhq0Wz8g4LBn7OPcRDnhkps2WW+ulyNDnJn+CrXX4gWW/RbZCTLb8R21QS/xfy1F200sGOWyxqCK5gkaADXC35EXJkdidn9802ZUsd+Zcsu1+5xhummWSZR0QghRAysTwx/ZYWcgnFZW8Wy9Nh2f/wzcOx+W4uThUQzAb89JUk0BmtOW/pzl/b8AtJkUqokmX+CJQ1z+yE0bLZeFm+g9TzrOeKIMbMscaFmJZhz1P7h+iE55sDux2OlVi5Hk6fKG/eHbnSFVcLCHNILWu5dVt81b8EAQHTczSxzG6tc0g8uChhOIzBU1K9b5/Od16sdBZtdAvNF4qJaRR2apfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by PAVPR10MB7444.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:25:54 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 08:25:54 +0000
Message-ID: <13013334-1760-4ea0-bcb6-25bda49a3bd5@siemens.com>
Date: Tue, 28 Apr 2026 10:25:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] qemu: overlay signature nodes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
 <20260427155551.GH41863@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20260427155551.GH41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0092.eurprd05.prod.outlook.com
 (2603:10a6:20b:498::30) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|PAVPR10MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: e7328937-e9af-4f3a-11ba-08dea4ffc389
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 33TYsyTUTfS9sGk7QaFzU41gVp5eIcU0iDmwywRCnHxESj/IiUSZVMT7EJpDzeJhplu3R166ZgJs68ePoS5sXfSvKlRUpiApKVKiWV5DVye7at00PuaojiT1gpCiOlXDVLSxPGgH2vPSLllpgsyyNOCRcN/YSWgTcDsyzz34R+ROIuzTkk6ZTG9DYA4we8T2DTowdQQ08g4vsmmsQrr6U8L5ATnw7MuKgLnqSn0A3FdmVJUwMxBEQQDCKvaz6XCRzKctqNsB+BxEKSXTtMfn0Sre3Ft0Hl1VrFhi4FLIDBzy38mDtAgB1Yxqv5W6KhRzNyyQYZhU8mCKIMI43wTb+HcGJop/rYbHqmdjk+htp7wNFLhlFN46R9MGVf2PZky8ileqhx/PRP8G7tGxg+7T/12vfqGf9a/Rf2PgBBVxy4fA9kBt7uWPWF2FMwln7i85XICaAn/TAlKx0xvCDa67ZLUBtS/b09dep5NgN46rq28CKYMWmpkoI49EL0hnhIkCkk1gpbJrtpmfagjPzEIJb+qEWdB4k2hhgrowa2fMX+FK2WXLSUO3ILr+YybPex3KZByS/zhveSA34B8bjy27ibDfC6P/rCw/yQ+yu7Z0UReAtrWJ2qQrc7neNS9GffpVRDGn+h3REj7cR20jOTT4mX7V8pt3PROVtZuLslbHuFG9ccJUR5y3kyk0ds1DSHk0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?USs2K1hVMDlHZzVWeFB0bGpPWVJETmVuNGwwRVNQdXJCcVVhSDQzNjZGdnlH?=
 =?utf-8?B?MS85cTN0Q2lrckFadG1lS05WUnRWa2YrNGZmemtLWXVpSnRKNGxWM2dESmEy?=
 =?utf-8?B?TTZ0a0w3SGkweXY3emlYK2w2OHNsclVnSUVpM1pyeTNub1FxTDNQSFZINzVH?=
 =?utf-8?B?c2NrL3grcVR3dHFkQmVPR1FqSVQxb2VnOFlKN2VhNWFTRE9nS1ZJWVpaQVFN?=
 =?utf-8?B?bm8weVorMlZQeFQ5VWVURGw3eFkwNlNFajZuQTE3Z0tqS1E2NEwxMktjRlFF?=
 =?utf-8?B?cXN4ZHBzTjNoMjVOTXd6WllOYkxxd1Z3ODF0dUZiZlhqYW9hZ1kzRm9MWlE2?=
 =?utf-8?B?d0lGd0tvTFgzK0RGZlViajdGRDhncEc0a3A0ZWZZWUh4K1F6a0pFUlZ6S0dL?=
 =?utf-8?B?ZUE0YWM0TCtNR0RoUEdVYVI3NzNNYklKSDU3OFBKQ3pmYWhPQ2V3REozN0k5?=
 =?utf-8?B?TnBaWTU3akdtS21xbHA2WFNESDZvNzZ6YzhzTXBUd0VUTjR5V0VkOThQMVpJ?=
 =?utf-8?B?K0YvNGJiUHZwcXd2eXdZb3ZtLzhSYm9sQU5ub0VKTE8xakRuVFVHVklZR1Jy?=
 =?utf-8?B?cTVyZ3RxUmFhQ2JHdmZ6WDV4T0dtVEtJNkhQdGxkQ0Y1aVZjRXA3RFRDNDBX?=
 =?utf-8?B?S0dRR3dUYmFaMlBDajd5V2E0b21ISzc0UmZyWVlqOVgxYXZJQW5zb2psZmhn?=
 =?utf-8?B?S1lHK09WMS8rcVV6V3JaOWxIZ0tEUjNpU054ajkvOTEyeXZ0Y2o2SnYvUGlp?=
 =?utf-8?B?ZlNxeFlhaTY4MTFTNWNqY3J1eXBlU0ZGSnBSdHlxZVlBTkxqTG1OOURLRThq?=
 =?utf-8?B?emtzQldkWFh5UXFhNXhIbEZvWk1OcUowRi9tRmVLM2t4WlhHcGtCMzlGb25I?=
 =?utf-8?B?eXdRWHVGODdXTHJ0b1B4anVxeGRRNkVTenY5TDl2NUZUaG1VZVhZbVFrcU84?=
 =?utf-8?B?REZ3ZmxkdDI2cVhTbm9FZGd2VytuZldod3ZvVTJJdkJkcWRWWTFJdVdOQTZY?=
 =?utf-8?B?djI2S29PNUM2MmlPRm1mdFZITVZLRGZHcEpaMUVmWE9Qa3JURlNwWmpnVldj?=
 =?utf-8?B?WWttWTd4UFNyTnZxU0o4WTJuVWtzMS9kS3hvbkVyMFFCSzdCU0JTbmNqOGoz?=
 =?utf-8?B?dEpsdUM2NEdlbFJabEdGWlorRXNQY2ZKSzVZVzdQc2U4aVIrYWpFQVB2cmlz?=
 =?utf-8?B?WWtwTXpDMXVJZHVEYUk4d2VFWnJrVTcreHYxMmJ0SGtCenp6NkwzWTlsd3hv?=
 =?utf-8?B?UHZaQU1OOGxTVllWSXJucEhsRkRhY0ZzOGplOXBBYWFOdXZqT2hrdWNKOFJL?=
 =?utf-8?B?K3NyekttanN3Z256L2VDckhqK3IyNjVMOFYrd0s1QkZLZ1l6Q1BiR25VaGxZ?=
 =?utf-8?B?RER4ZWJEMGNZeVQ3L2YrK3drS3NzUUUxR0drYUdPbkpUbTB4b3NkdzdiYWdV?=
 =?utf-8?B?bUx5QlVqblFMeDZrS1NURnp2ZVo2WUpPTk5kNDBjajQ5OXZKM1N1ZFJta0hy?=
 =?utf-8?B?Nm1tTnJmeFM4MkpSMnE0U2hyUzBJRjM4dUVZVXVoZmhtdHp5TVgrczlaSnlw?=
 =?utf-8?B?MERiQVhsWEVhazdEVVpjVWlNaXgyWFAwU3JhbDhLSm1qUDY1RW5aYU8rR0pB?=
 =?utf-8?B?L1FZN3QyYUxhcHk0ckc1QXp1Z045TnhDZkUxMnlhNGtNVW5BeG1xOFBvd3J1?=
 =?utf-8?B?Yy90Sm1IVWNCSHg3OEg0TjVxY01DRWlJZklhWWliVjNsdThUeVNNaURRZnYw?=
 =?utf-8?B?bTNUVnN1VU5xWEFmMUlKbVBnUXFkWFhyNGY0clBmV2RndngrcW1wTWVmaHFL?=
 =?utf-8?B?ajhWVDdGL2xsejg5NzdJSVp6QktjOVRhcGR2NTVXUWs5c0FpMVNyOU5NelJo?=
 =?utf-8?B?Q0k3ZHlidzExQ1kybmtSU3NydWJFMElOUG9oeFVvSDFETldkSDE3VnBCTWpu?=
 =?utf-8?B?Q2R5T1UrczZkTFJWa0FwbHNsMUlkWlVaUUE4RENvSy9pOEVyWGdRR1VRREJr?=
 =?utf-8?B?eUU1dG5ydlBpZlRVc0NNZDlYS1VzODNUbnNLbDA3b0tibVNtRTFqU2xKTmxH?=
 =?utf-8?B?ZEJ6TUc5RldGc2JKSWIrNmNhWUhYWDZ6L3M1U0V3L2VGZXZuKyszQ0dZTEJN?=
 =?utf-8?B?R2k0L3p0KzNQL1JBaEk2OXFmOGYvVENrdnZVTHBBc3NaOTRjbUxlMC9BSXhp?=
 =?utf-8?B?NFdtSE00WS80bjgrbTRPWEI4YVZGSEozbkFqQXY4Ung5Tmd5NW14cjE5eEhX?=
 =?utf-8?B?N0U3WEN5YnpmNU9VQTJ4MmpCVFJiTW0vT2NldkkwcU1vdnc1U2lhZ1JpTk5w?=
 =?utf-8?B?K2g3ZGw0Z2l2Y0FUZjBnMm82T1Vzb1VSYzBlOTE1bmpOVFBURVJBRlphTXdD?=
 =?utf-8?Q?6oIY/a1tg2znNmoY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7328937-e9af-4f3a-11ba-08dea4ffc389
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:25:53.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAyTiQ7G5e+t/DXkHf3wV9xn7nQQDuJjdk0y862iWgxfgXkOMfd3RiCeAN6oHGxYn252dkyDPdZ23moVS+ClClqigJ+v8jtlrl6rzVzfvKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7444
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

On 4/27/26 17:55, Tom Rini wrote:
> On Mon, Apr 27, 2026 at 05:03:38PM +0200, Ludwig Nussel wrote:
> 
>> The keys trusted for FIT signature verification are supposed to be
>> embedded in the device tree built into u-boot. When running in Qemu it's
>> convenient to use the device tree provided by the VM which doesn't know
>> about signatures though. So merge the signature nodes at run time.
>>
>> Needs
>>    CONFIG_OF_OMIT_DTB=n
>>    CONFIG_OF_LIBFDT_OVERLAY=y
>>
>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> 
> This series seems interesting. Can you please reply with a cover letter
> that explains it a bit and perhaps some usage information? Thanks!

Sure. I guess it might make sense to isolate this patch as it's useful 
by itself even without the verification changes.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
