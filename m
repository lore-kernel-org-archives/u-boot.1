Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F579CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 11:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C3478470E;
	Wed, 20 May 2026 13:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="I1bZbwGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1890847AF; Wed, 20 May 2026 13:32:29 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885D8846E6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksFfHt3iZoIflMOOd6xkv3hJW7/u2TMtR9h1k68bkXE3zsqDG53am+AjCwkhorehe2h3YtObDwxGWrOORupddXQkaj+BkzS6s9kTCPZ6Qo9qf93U/Gxg0fgR9Wngg6quHUPdOwJTbWuDmjnVzftnswIvgJ6gAUTZipmlDudAzyonSQqUXcYDwUbfGcoI7KovUVmuxQ6onOlneIAFmgzSRH0aVj9LgRQw5BKrBvLDdPtRG8L6ich5GOxQNMUZ+E2ydaSyifkZeiXFPITFus9mgXgV2boZKsSku/BoOTBSUjzTmjX5HuIHfefzPc8pOcNcz07t7NMzVudP/DziOoYeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd5qqb2+hHkl4p7Xh2gEAv8GeOzGrLcLbq0SpSaqIxw=;
 b=aXUsA7/7ChA6WUJYtu8w5Xd3V8skc8QPv/75XNAk9UgT/VgMhLaEjkSomfGFupES/h+aOA+JUnEbzf2k8dzZeuJRNuXDtRgGnEAqG0+jAv8zD24DXN5z9Ig0AD7rdlyuP7igRE+6PcZ7BgU9MGy5slHktvyblxek1LektFrOx6EMpeMlJuE241cFxVD4eWW+515oUrHXf8nbNDMERdk5jfbs4qOJQmKbmJKVb5eODrBzJtkbgBvY+tqHnxYUpspPdDbrVQ46eT8A6M/8ZCE6jk9Ww0yUCQ037xMGEsTk6AAcKwEMlcod65Fil2eV67hcq4PjAWzt1wRCJQGPIyNAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd5qqb2+hHkl4p7Xh2gEAv8GeOzGrLcLbq0SpSaqIxw=;
 b=I1bZbwGp+am/0egKpe9hsk6wdsy+nzrTvIXu6vhGqiVqn9PiI8OIlP3x5Nfa3Gy5yXeKNKXETsT6zqDsUHjrOiko/EFVJEsS3rpYIsjp40Tml2jTnNyqtePrPVNiGHov06L+NT0jPjKiJXnWWYulmu9McOz9R82w2v6ivpKjEY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB9778.eurprd04.prod.outlook.com (2603:10a6:150:110::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:32:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 11:32:21 +0000
Message-ID: <a7c9e757-95d5-4dac-a87f-156b22e5967c@cherry.de>
Date: Wed, 20 May 2026 13:32:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20260429180247.83091-1-ekovsky@redhat.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429180247.83091-1-ekovsky@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0005.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 831a47b5-1862-4172-a841-08deb66374f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8O2yNr20STdC/d+vqMs9IdpDpJurk1zFP0EX8qH37sL1Vx2fE4x4WHIBxR5zo5JnbaV0kNxNkiIIoY8kLMrOUy5oP3ylxoDFlhtk+IBXx5rsq97EXCECJhViEJgP5f7ApTGpbZRxgWULJq4EF9Lw9ivBDi3JhET0RHxwZBg0xiR+XnHS9ViMC8FFT2Jq5JO9KrvLAj6A1wNsA7/oi/AxUz7Q+8miaTLdlpkrPdAi5nAB3iRvJHFuySbMgTGppjqTUOZ+iBcBwW0cOAU4FbUb6gohWjdAeEKWnbchp3JaikaPgrD6B5Nmuxvo0+4BD67XxaWmbp8fnn14g8kpAnR+1NCPQ2dpRjMPYj9er2RKZFi+1QyD9/TMvHhrGh0hig4YL3h7k+UMPGWEprzt8vgz5VCEVAFPE7l3dMeXkyEOsp3QOfK25hzipcboLofoCj6HrWq+SPZjWD9PxR1M0wrBb2bze0hUUaZ1L3GFnmOzs8JDm/M2EHRiidrSTh7/g+70GhqqgSKW6gWgNcjx2QleXjFojaLZ7kMnhwluCtYOW8k5SXNzp5PtelnGv7ZRRbgUGZX/TCO2JhkJgPa3dniedgVRfnaC4+r3qguzWcbvwL3ct8xWso28v1LPeO0aej5HmT4dDdYqMRZxrlS7nX0UsUJK7euCo4jhZQXzzYp7/gOX+hzrFPOdGo0TCVbKiSgXhqJNt2sD4kn3rpVCKk7YDobDWB1BYXK9TbVdg1UOG1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXV5YVh3QzcyQ0ZEYVpxN2ZSWVk5SFA3dkM0bjZqTndYMkNUSjgzc3JqRm5M?=
 =?utf-8?B?eUZuUklPM0lXWklHeGMrWCtBU1FCSDlScXVDdWlEMENRbUtobVpwd2poZjZn?=
 =?utf-8?B?c2pZR3lreVZGT2wrOWpFR2pCekN5d0NFS1BVNkdZRW15Nm9mRCtMNFRDeSts?=
 =?utf-8?B?eklsVnp2WTRxa3BRRjFnbWtHOTEvZDl0dnQyL2tOWGZzd2MzdDk1TjBPY3ov?=
 =?utf-8?B?WGd3SCtqYzBXbVJHa2YyaUUvNVJZclZXWnNPYlRDQ1A5SG9aR3VvQXRCSVRj?=
 =?utf-8?B?NE5OVGlTTDdNMEhqZms5bXFBc0llc1psRk9nU0tudENQQ08ydkgrTHRFazZD?=
 =?utf-8?B?YnlGbkdSU2VCVDNyWTZsaTltVkZxZ2Uyc3JsRmw4VDRiZHVNYnpTdWR4QzIz?=
 =?utf-8?B?WHVtUzFNdUxvenorOGNsRjIzMnBPZzRabU5FdmxoTmE0c2tRU2pWendhSnQ3?=
 =?utf-8?B?dXI5U3JVcVhJVDVIYUptS09UNjVoYVdpVTJwYXVEeDBNM21ScUN1VlQ2Tml0?=
 =?utf-8?B?V2R3ZjNNUU9LZ0lESk9JRkE2Nm1SN0djVDR6aU5iOVV1R2VwTTc1ZTZhMHhk?=
 =?utf-8?B?b1VNSE5DaHhmbnhJcU9SUDdkTi9uNVVTVS94aHhpMGIrUUlBYjRuaVlwb2pX?=
 =?utf-8?B?QjI2WEpHbzlCYU9IcGk3Q0thYUNUenZEdktaV1ozZkFxbzhFSjFKemJ3QnpZ?=
 =?utf-8?B?aC8yTjdoT3lUazBSS2pQMnV0ZG0xaWxMbUoreDVhclRjNmh2Zkx3QkEvUDZE?=
 =?utf-8?B?MDJwSXRIZXRTaS9oNWN4OGsyYU1RZmUwMzAxMDBpOGwzYjNxYmdFeElOYTV0?=
 =?utf-8?B?THhwZFBESSsyV2d4RkY0YWZINDQ2T21hOUFjVHlSblBXMHEyZGxnUU9YOEZj?=
 =?utf-8?B?NVZuYWpsWm1jVmxtc1V0VzZiVHdpcFhQVm5GbkpKZzhLbU1IQW9IZVhZZ1VT?=
 =?utf-8?B?Zlc3TzZHalNhWDZBQ1J6N0l4YytPWjcxWDRpcnRiSlpJZFdERU1MRnBzZ1Zy?=
 =?utf-8?B?Sjd5Y3BZejMxWks2Z1BoczRlR3dTQkovbkNhMEEvN1YvNUF3Y3YvZG1Yd25o?=
 =?utf-8?B?NjlzU3o0bjczODBHaDdVY1pZdlh2cTEwTC92OUtveS9nYlVJM0xzQUpyNzhX?=
 =?utf-8?B?blF3Vk1OSnZVYnora0N1OGIvM0JWNk51S1d4blVoRkpYOEpqcHU0Z3htK0NQ?=
 =?utf-8?B?S2R0UUUwNG80SHlidDhvKzBVSnF5OHdvTU9UQVhwVFhSZVJDM3ZFTndCaGs5?=
 =?utf-8?B?Wk9SRmpOajNDQmVHMDNTVk8rZTJGQjA4YkVwT3BLRWFlT0lRcTNGS1lGVjVJ?=
 =?utf-8?B?djg5TXorQTBIQlBFc1dXR1FPaW5CVnk3YUVlelQwNU1ZQmhqa2dSSUlIRzlB?=
 =?utf-8?B?bVBXVjh5R1lkdTAzNkd2cTQ2Wm51bGVTdlBEN3hoeTBrZFRTK0RFMXpEdjZZ?=
 =?utf-8?B?L1hSSnkzblpmTkhIUW43c21DamljWHVlY1dZSU1zYWlsa1BxYVpLTWVBazgv?=
 =?utf-8?B?Mk53bEFlVzBjZ0pOUnI0SUh1UlFUbGE2NWs4ODR5eDBpY3lWOHo4clNITGtJ?=
 =?utf-8?B?eXJiYnk2dXpja3lNU3pvMnVGbEZ0UEVuYW1yZWdTOC9qNk5qUy9LUHA4a2pH?=
 =?utf-8?B?S2YxaGUzWG02NExXNUNMZ3pHRWpwTzlTdGc0U1c1bmk1cnFuVzNjUW9UZ1pk?=
 =?utf-8?B?UzRQdkZZcEhlQzJVaGo1UGl2SVBOdFBJdExDUC8zZzNrNzYyczNveFNIa1FD?=
 =?utf-8?B?dVVYM1lGM0lkQXVINDczS3BvTFQ5RnVVblRWdWRTTFM0VXdSU0Zqck1OQjZJ?=
 =?utf-8?B?WDBqRXc0cUk0ZkdVdjg0TWs1VHpDcGJGMkk1T0RFenl6bUpHK3pnZ3k5MmMw?=
 =?utf-8?B?RElvNkdHWVJGaDJPcngvdDZvTzR3TkQvSmRGLzFvc0dtdnZTcHZqNWhWMm9Z?=
 =?utf-8?B?M2JrTjFCZUhDY3libmhxVkpCbFdYQnY2NjlTWGhwTkdaVzRnV0xBTEJjdEJ1?=
 =?utf-8?B?eHFzTzBkZEFlMzg1cmdzVXZMRXZyL0lBcGRmL2U5YW9YdkUyQWd0NlJqOGhn?=
 =?utf-8?B?NVR5UEd2OUMzZnFOYmc1T3M4Q004TENmQjVZcVBrN0g2bWJxYmlJNERTSDhC?=
 =?utf-8?B?Zlk4SHVuOXBmYmNiSWo5V1d2dmpORWZ4R2dHWU5vYVpMeW5tNThEQTZucTMz?=
 =?utf-8?B?UFVRZVFUMlhqcmE1RzllaEFiVHhLTisvd1ZvdXpFU0V2RDkyU3g4TVpBbGZR?=
 =?utf-8?B?SUlNYmk0M3l2eG1ZWjZtdy96TGZ1TWtYQTVCUGNOZ0FORG9hS2NqWG5kYWhq?=
 =?utf-8?B?K3hBV2VmenJKME5BZzZweEZmK044MjJFVkdaSGlxc04rbXcrQmpjdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 831a47b5-1862-4172-a841-08deb66374f1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:32:21.4464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T0msfFlfkQRAByMOq/vNG21afMnte/se9lzdaDxKyxRP7Wpid/d4WE5auPFGf/egoVEcqhFoStEGQJ2z13lPxoc4VDN0e4Di/PhD7hMH0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9778
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

Forgot to report something I fixed locally.

On 4/29/26 8:02 PM, Eddie Kovsky wrote:
[...]
> @@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>   		return -ENOENT;
>   	}
>   
> +#ifdef USE_PKCS11_PROVIDER
> +	EVP_PKEY *private_key = NULL;
> +	OSSL_STORE_CTX *store;
> +
> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> +
> +	store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
> +	ERR(!store, "OSSL_STORE_open");
> +
> +	while (!OSSL_STORE_eof(store)) {
> +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> +
> +		if (!info) {
> +			drain_openssl_errors(__LINE__, 0);
> +			continue;
> +		}
> +		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> +			private_key = OSSL_STORE_INFO_get1_PKEY(info);
> +			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> +		}
> +		OSSL_STORE_INFO_free(info);
> +		if (private_key)
> +			break;
> +	}
> +	OSSL_STORE_close(store);
> +
> +	*evpp = private_key;

If we reach here without actually finding a private_key, we'll return 0 
a few lines down which is definitely not what we want to do. I'm suggesting:

if (!private_key)
     return -EINVAL;

Maybe it should be -ENOENT like for when we don't find the key on disk 
(see first line in git context in this hunk), because for some reason 
our logic in tools/image-host.c specifies that missing keys is allowed 
(???????).

> +#else
>   	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
>   		rsa_err("Failure reading private key");
>   		fclose(f);
>   		return -EPROTO;
>   	}
>   	fclose(f);
> -
> +#endif
>   	return 0;
>   }
>   
Cheers,
Quentin
