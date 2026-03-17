Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B33FED9E4
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B468F84359;
	Tue, 17 Mar 2026 16:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uRBsbazZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856A784383; Tue, 17 Mar 2026 16:53:18 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC5284332
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxqeE4BSS1LVWwEvy+QbmeYmDzgl8HaGyQJ9m6S/+LpYONNvcD2mhc/4uW5OJUt33bF2Dy3IR2Dh1T/RGwSMUsiDb1W8MEiQ8kSMqsskOWIgCeXAib0NKPpFI5hEkmOSbsIIWUK3clLoAdEM7ifQeQx6nU0dvLPuVRq9Di/vO//B/g9y8jvOTd5++qNWghm05oROv5zPPt4xF0aI9WfS9scgkc+13O3qPkTRfKRLpgnyEIVMZWWzNcCexYfXFafho3s1h3sKDWotrdbzmArGq4gEhCWZEjZ3cLUOFePYOaR+YJHI+NG92oPWrUZnvnVXOraocRh3L4Yw2p+n8DJXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs9/eq3U3DbSPGaEqeMr9jfsz7Emd4U+O2CNpoAyGnw=;
 b=Zd4L8ys1EcYCRcF2N1YPVJ13I7P6VQGwA3sa3evMDDXFaf5vPrK7kE14JFvUtWGELUUmS2iWYHM/q3pZcQ7WomsVB9wWL3KYduyR2JBFBp4h3D6fWXFxcZKWyD4Hrl7nJQuErXohaE0UQSL++QzacYUJhNG+LCU4m1kMKJT14MiGROG+HyUuzTGW8+tpNeAEtgum2gRRAEwK/GF+bNVAoqu3nVg4w0k1gvNWxlWdL+wBKCUyCnot0tWxJVxZkr2CowaXqAdqh+7djuI3n3cqd+Snj2RlejS8T5qh7QmQwE1obZMPMMKGV8Z2hujOyeH0gRgzb8B9H29M5ftFrazN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs9/eq3U3DbSPGaEqeMr9jfsz7Emd4U+O2CNpoAyGnw=;
 b=uRBsbazZaUBdkVVMBUV8PzoILaFB7c1qK+nXPMhMZ9uG9EOY7l99GUK+CVA/2t6Te6AQjm9C/tvSsL9SzcwDaIxLLvt35DErbJSBHMVgTx9SVqmw3SKn3WrD7S7l130cF6jqFkWqQr9jheTcIEjGtTlfbfo4/oK+GaztQ1WaP6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 15:51:18 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 15:51:18 +0000
Message-ID: <e239e4da-635f-448e-b6d3-c3721e66b8e6@amd.com>
Date: Tue, 17 Mar 2026 16:51:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Rework TARGET_MICROBLAZE_GENERIC
 implementation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260317012412.4162279-1-trini@konsulko.com>
 <92a3aa0d-4d2f-4845-9ac2-6bcb976bced8@amd.com>
 <20260317144955.GC502704@bill-the-cat>
 <0f352388-4e79-483a-a4ca-2f14f4bea6c8@amd.com>
 <20260317154136.GD502704@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260317154136.GD502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 839bda40-b592-47ac-c800-08de843d0780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|7053199007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yIzDiHi5ykf24O8rDDyp2ytrC3Y82snyg4afcq302EgSIV+fzdnjFHUbzQHVodW8B5XtH9xfhJn9fWeorqHMrs/WzPZhtRx8BAhZtO061rLIXKexh5mZBlcKWQfdEKbHRmPt9mCW4Z8Qk8U+BrY9v8ZYKJbKYFL9uUfD5l2pfSY2rzhWwtyoHcyzHMAVxqE4pm3r3fmiyFZDFa7g5vvYwgKnHDXj9cNZkBBPtXJJsyQwaahiZzj9xixBlTtVvNC9XOE88aOA1YVZzqR0t61kNsIfqBXSV/+kcS8YbhjZmJ9fnEBWj2tskv6uULGzqQcAI/oO1zKblgHhbcFWMpvN00mU5q3Y2trXhT+1q82DHWJCF4U14I4oP7kvdfzTmThHSiZPWrzWxDYmrpwUSZda1Z8uSvG7/p9Vm4F5GWR9TvizJrGUKumhP9f+pxLy+nlqaWgxTBXU1+o4Fo1PiuOxZcqcNUom7UXDbFMepMKg7wHZqwfz1wC+DHjRCppxcP+I0wjplM/G4l6JuG7+EVGE3ojUMUfACbeyOxNu/r5lBWS3mqrwmY4BNZs/uEaw3LEevzTSTRblQqK3VWONelyY3yus1xyMkY+3c+xPu7Qar13f6NqTi9sF4Cxg/K65XCDSR05vi870lNtzAvbfepHU+YbYAmK1++LQaaLnSVfTjD5aBrToO5KwCASMKT0J/QS/vNmAAs45vOlgCcbXzhj5B04C1GvVWNZ7EXZ4zAFkNYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(7053199007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmo2MGNkVHMzWXVvUmpxcE5TNHNWM1RzZm50b1l4R2MyQXJtenZkOWJibW1l?=
 =?utf-8?B?eW10U1M4eFZFTFpLM3IwZDZ0aFpGbWxYYW9uMXRVRHBTd3RxdFgremtEVmI3?=
 =?utf-8?B?L1FzUk1xZFpTMzh4Z3k2TEt5dHhwbUZQaytodi8zbndLdDJNaEx2bzZoYWNa?=
 =?utf-8?B?cHZHQkJONmFHak1WVEE5b1psY1liR2NKR1FKYTJVcnNTd1UrMG1WMzloS2xN?=
 =?utf-8?B?MkVjWnE2d2hrK2cxajdhc0k1dVhsaCtKM3RiNFByQ2FZQVRoenhFVDNUWGky?=
 =?utf-8?B?ZURidjhuUnp5WEEvV2N4VXorSlR1clRUbXVMSTlieFdJSHVrMmF6SmRBSWhq?=
 =?utf-8?B?WUJ2NnlDRFBmWHVoRGVDUTFUUGhwOEhJaXk4aHVlRHU4b2xCY3hma2d1TFk3?=
 =?utf-8?B?QXlHNExmUEw2R2lxMG0rWmgrSUJYM25UbXU4aVVrOUNPNWU4YVEyeFZPWDRI?=
 =?utf-8?B?cy91RTBXdXpyMUh4WkdXZDFQd09JQXRhOEpEa0g2WHIwdUFWMXdoRTU2YTJp?=
 =?utf-8?B?RThKNEY4dHZQeTZGZDgxbUxGdWVlQ1ZnZ0tyTGJYa0NCbXZLb2paT01QeHVP?=
 =?utf-8?B?U2QzbS9vZ2ltQW1udGdvVE93Y055YUFCSEdCOW9ZTG53M3ExTEFLOFhJMFFT?=
 =?utf-8?B?Rk0vQnZ3bEY0ZkZTeFVLSjZJcXFDSHRma1Nvb28yb2VZNDdCaVVLWmxpc1lZ?=
 =?utf-8?B?bE4zZkNpbm5XMWVVY2VIRDNwNnVBdUU1TFVaTHBTZStKVVBjazN6Q3MwcjNr?=
 =?utf-8?B?V05za3FDdzF6bHJYNlFDTkE4RU1aZGVrS2NNVGhIWGp1M3RsQkc4ZmZOUWJO?=
 =?utf-8?B?aWJ5cksvTjFqcHFPUmNZdlEwd2pmMloyVjcrRWtuNEtTcVk0OWxZM0lTOUJw?=
 =?utf-8?B?V3czS0pBdmc5Q2dTNk5FM2JkWHFGNHc3c1dZcDQwaTVVMjdzckNka1cwSm1n?=
 =?utf-8?B?QmhvUC9yREpjbGsydUhFK2tJSWVmZ0ErWVdzeXl5azVnakRUVG1qYmhJM1kz?=
 =?utf-8?B?WDd6TEJTL05ZMkpjNitPTDgwQUY2MXdRbGdXWlZBWVhhNWRtaWRPTFZFNDAw?=
 =?utf-8?B?c3A5RDE1SSsycSsrVUxHMXkvbDdYZ240Q2FlVjRSOVhlWTJxVHZFQU1IRUR3?=
 =?utf-8?B?eitoRDNQak1JMmVISkM0aEpUTFYzTHhTQlB1TUZUSEZSVmFrY1BYWTJtOUFq?=
 =?utf-8?B?cFdybkkxUDRHRXZpRXZNWGU3MmZmQnE1Ty9mRkFTMjRaeWRUWHZJbmI3cWRw?=
 =?utf-8?B?S0ZESmtadGNodWVsV09EWUN6em92M0cxSGY3NXp1c1kzMTY3UE43SldhM1lO?=
 =?utf-8?B?ODBSUHRXZ3BpSzluVXozMVpDYW9uWVk5d2dGd2VRR1B6dGV0d0RwUWtQa3BB?=
 =?utf-8?B?L0hsOVgwVmdNMUJSdEs1Wi92aTV2WXBCazNyaElCRm82UDNZQi9BQXI4S2xm?=
 =?utf-8?B?UmErR001U3BnSzZ2eDlIVjR2VHVPWENtY09wUnVvbXhqQ2xRZVhhS3JsaTRL?=
 =?utf-8?B?WmNOd1YwSmtjME1ZUGx4aVdnaTY0WWxnM0d4Q212V1pyRW9hWTNiUldyLzcy?=
 =?utf-8?B?NGt5ckRVaGNsaGZMN0tQd2QzSEdyT2F2UVhBSjkyTHNwMENnelpiR1UrbWdw?=
 =?utf-8?B?Z01PbUNOYU5KNTV2ZmtpaFVwTmdUY1o5QWJJT3J3ejZ5cm5yakNEZncyMHlQ?=
 =?utf-8?B?aHloRFNBK2FZNXV0SDY4RDg0SXRvejIrU3c3Y1VHNlpRSFVxY084NEo2aXNs?=
 =?utf-8?B?NytvbTE5RVBnVW5JUGl2YTdqMW1oNUYxZVZTVHpQNmF6WUdGNHJ3ZTVFZWpa?=
 =?utf-8?B?VWUrcnR3Q0hHUnBSQUlaeGdnVlQ1Y3dWTzlrQmNJc3NGWEV3WjVBNFZreEtr?=
 =?utf-8?B?WXNwRFhjV01aalNPNEdseWE1eEw2YjVEbk5HWHg0S1NjT2tUZG9nREdwT1N5?=
 =?utf-8?B?aGYyT3d5TUgvL1IyaVR3Tmk1MlR5ajJyUDFhTzBUbGFXNW4rdFZ0S3pWVmJC?=
 =?utf-8?B?MjlpRnkvM1Q4aE1tcXJrK0w3YmF3WFFtY2F5dVd1ejNmV1Z5cXNGNnVrdjlr?=
 =?utf-8?B?dmpJeWhlTkFQUWs2c3ZRbktiUXJycWZwcnBjc3JzWFR5dE5kVHdKaTdVWkth?=
 =?utf-8?B?QTE5djFlRktOUWdUdjVFSVVMdUNYRjBzSkpCWnlsMG5sTCt0eXo3cGNjek95?=
 =?utf-8?B?YktUSkVsWjIvNHFjYzFnRzYramtaM2ZKMUZiUU4yZXNWV1Mvek9ZQU01eFVl?=
 =?utf-8?B?ZmJZRWVKK0c5TGpqaGVTUHR1M20rM2lGTVU4bUVlR3lRV0pPTkU3NmF1MUpT?=
 =?utf-8?B?MUNLQXBHYnhGS2pnbllSOFY1WVg5YUp1UUh0N1pxV1ZUajMrY0FTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839bda40-b592-47ac-c800-08de843d0780
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:51:18.8603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OVa9PUkmevyeDXvgpofTxT3+nCsZO3eDdSO5tgdyUkRpdZFolQI9lWX9Hv8njTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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



On 3/17/26 16:41, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 04:35:30PM +0100, Michal Simek wrote:
>>
>>
>> On 3/17/26 15:49, Tom Rini wrote:
>>> On Tue, Mar 17, 2026 at 01:06:15PM +0100, Michal Simek wrote:
>>>>
>>>>
>>>> On 3/17/26 02:24, Tom Rini wrote:
>>>>> As exposed by "make randconfig", some symbols such as
>>>>> XILINX_MICROBLAZE0_PVR can be set without TARGET_MICROBLAZE_GENERIC but
>>>>> have a transitive dependency on it. The easiest path of resolution here
>>>>> is that since there is only one valid microblaze "board", rework that
>>>>> symbol to be non-optional.
>>>>>
>>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>>> ---
>>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>     arch/microblaze/Kconfig | 10 +++-------
>>>>>     1 file changed, 3 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>>>> index 4261e5009fdc..16c55ddfd95c 100644
>>>>> --- a/arch/microblaze/Kconfig
>>>>> +++ b/arch/microblaze/Kconfig
>>>>> @@ -7,12 +7,8 @@ config SYS_ARCH
>>>>>     config STATIC_RELA
>>>>>     	def_bool y
>>>>> -choice
>>>>> -	prompt "Target select"
>>>>> -	optional
>>>>> -
>>>>>     config TARGET_MICROBLAZE_GENERIC
>>>>> -	bool "Support microblaze-generic"
>>>>> +	def_bool y
>>>>>     	select BOARD_LATE_INIT
>>>>>     	select DM
>>>>>     	select DM_SERIAL
>>>>> @@ -26,8 +22,8 @@ config TARGET_MICROBLAZE_GENERIC
>>>>>     	select MTD
>>>>>     	select SPI
>>>>>     	imply CMD_DM
>>>>> -
>>>>> -endchoice
>>>>> +	help
>>>>> +	  Support microblaze-generic
>>>>>     source "board/xilinx/Kconfig"
>>>>>     source "board/xilinx/microblaze-generic/Kconfig"
>>>>
>>>> Applied.
>>>
>>> Please drop this for now, I need to do a v2 and I've found another
>>> randconfig that gives me:
>>> WARNING: unmet direct dependencies detected for XILINX_MICROBLAZE0_PVR
>>>     Depends on [n]: MICROBLAZE [=y] && TARGET_MICROBLAZE_GENERIC [=n]
>>>     Selected by [y]:
>>>     - CPU_MICROBLAZE [=y] && CPU [=y] && MICROBLAZE [=y]
>>>
>>
>> I expect this is from cpuinfo driver.
> 
> Yes, it is. But it's one of the problems randconfig exposes since it
> does funny things when generating a valid .config, and seeing what blows
> up. What I have in progress now is removing TARGET_MICROBLAZE_GENERIC
> entirely and using MICROBLAZE in the few tests.
> 

it should be fine to mark it as dependency.

M

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 6a96be94de49..c805c0bbfa19 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -35,9 +35,8 @@ config CPU_ARMV8

  config CPU_MICROBLAZE
         bool "Enable Microblaze CPU driver"
-       depends on CPU && MICROBLAZE
+       depends on CPU && MICROBLAZE && XILINX_MICROBLAZE0_PVR
         select DM_EVENT
-       select XILINX_MICROBLAZE0_PVR
         help
           Support CPU cores for Microblaze architecture.





