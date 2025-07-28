Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24338C87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 07:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DF982F8E;
	Mon, 28 Jul 2025 09:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxkFsmJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE344830C8; Mon, 28 Jul 2025 09:12:15 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD8582F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE0SfJiT0RRrAkuC+6hgQDnhqFOmmcbi7ieSK8XGkGUZZnj8b0VoXfVNhnZ9ZIbHQ+YlWxvjndiSwi6757HDLdyE9/QqtZb2HD/vqsmDCLYoD/GQrcMd0lFzGt+2H+jAznTMK/u+CW7XUUTwpqo6oh/Emm9VtCCw6gPPDa4gsmG+s2t0GwdcZQ7m4nUEgc8pbcy1emXo1JiLZg2pw3C7EktRN35zNZbx0WuQs2DzjjaYd0PRsAZFa5avGnPjrRDY/h7oRTPLPHXyQ00FWwAMxYBzdwBjHtNYptrYcwdaMuIlOFvX+5nKDTqdTtEsz3lUmlsP/fH08vhcbNuvapw7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahgIJXkfGs5I/3UVDxr3ug8oGgjWWBjxjqA2WZklwEY=;
 b=Kg97RDvNZKvRhbs8nCdkLB/Mgz77DcMOeySszuIoKibH7oA07xyQBgYd7MoHIs09YXDVM7X316CJ/cEOT/kh0vUtc6MuVUNCo0LYp0JGsZ1Y9bPGHL5DPMQr4kHGP3WazyFqfnQ5N5PN0IHKICAnF0uFbWUBBG19AYK/YTuh0iiTMkrkGsLSJWIZuCAh3DOoR3j13ZQGW87167FyvEobvvxRhZtcF41sc1sG2m5TqjTvR7yEdM0eFTysedvkHI5pT6IAKvLlNoMY8yUvEJF2k328Kajk7E9o8ZwjiDAVPqxNivicLmUQL3w7g4b2i5JrdVr00zQzwRS/S/94DU+KAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahgIJXkfGs5I/3UVDxr3ug8oGgjWWBjxjqA2WZklwEY=;
 b=MxkFsmJthFfeLafv4DluF7POgEu75igqYMcHexXWQAtUOmCmr9qj675zmcjhgmVcjIO8g7Au8xAWXfIhrdWFhMPgZ20AaL1Dv5fYsyFa+HXS9iFK+dt2VjCyhp80I02sd8u+XqK9HmYrhZwknd72UrqaS3U+TzfB9Azm5gcQV6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:12:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 07:12:07 +0000
Message-ID: <028363ed-f4ea-4a59-abc0-9f251d7e5f1a@amd.com>
Date: Mon, 28 Jul 2025 09:12:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot-test-hooks PATCH] travis-ci: Wire MB-V targets for CI
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
References: <82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com>
 <20250722200832.GI2847763@bill-the-cat>
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
In-Reply-To: <20250722200832.GI2847763@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e6aeaf-7265-4dd1-78b4-08ddcda61020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkRWNTQyWjBkbzhwN0UraXE2MlZDME5kcDkwMEloay9YL3h1bUJBeWlLMW9D?=
 =?utf-8?B?L2o1b2xmdHpZcnhHL1B1QS9xb2VvVTdrekNGNTI5Qm5xQUtvV2VqUndXREds?=
 =?utf-8?B?blo5SndDOG9hZHowc2NVYzNvWkhWcTJ2czRSRkM5Qm1pQ0FHRzJhTDJjUzI0?=
 =?utf-8?B?SHBNem04M0Zoa1VxMWNFWnh1Q2h1QzV1VWV3NW52Rmd5T3ZSa1RQRTllcEw5?=
 =?utf-8?B?RjdPNWgwbFoxZ0pybTlsak5GcEZ6L2hmZ3Z5VGZKOVVsdDRNdDRnWjZ2REhp?=
 =?utf-8?B?am5LSG03U2pHNVoxNkp0UHp6RVdjOE1CUzJIaGllcEFxQVRvUm16Y2Jmclpr?=
 =?utf-8?B?NWMwRENaVElJSEQ3ZjlYbVFZbWhoOXlWT2lHR3hRNTcwcisrMS8rQnFtWHRI?=
 =?utf-8?B?L3k0a2ZMNWVzQWgzRXA1L2toeWQ3aW5XN01BbElGNE1zbmRZcytyak9VSmx5?=
 =?utf-8?B?VFc2Z2FmdlNTMFA1alZjZG5OZlVzd3lGM0RNSmRYSHNtNlA2ZTk2YW9TOGlz?=
 =?utf-8?B?dkxEZjY0ZTlRVmNRWG5pV1FGTkJ3ejlVcDkwMmhVY3BjdVRIYlNFbm5CM3A1?=
 =?utf-8?B?YUNyTWVoQ1hqaEh0ZEM4M2dvODd1MlZmTTlMaVNZUVdmTDJNdSs5OXdzNXF4?=
 =?utf-8?B?aCsxaUxqODNwaHdpanBSejhVcnJCeHJTYmhsdU1PSEtxK3g1YW1tYnUwRWNn?=
 =?utf-8?B?SzllclorQW1EMzk4eGtEc1JVcU5pdzdWTCt3WHFmdDh6dWJUMHdJVkFmUWxR?=
 =?utf-8?B?cisxMis0WkpDMkF5RTVCRStXOHFER0o0Nk9tWVI5SWFMUlNaNnNiYXd2WCtx?=
 =?utf-8?B?UDArZUJ3VUh1QTZySlZ0bSt4VG5jNDE1b0NNam45SCtXbmx2MDF6UFZsM0JW?=
 =?utf-8?B?U05kY1JZOWdQd29NejVnQlcrRkZKdFpCMzVTUEozNVRmY0dDbzAyYVJNdTBr?=
 =?utf-8?B?bWc0QmYzNHBpQWpORG11cktmQkdMYlgrY2RLUUxLWlpnWms4dkJtbmlUVDJH?=
 =?utf-8?B?d1Q4RDFxa0RWUkVYa1l2bHZUcmp4Ykw1cFdIbE9qR2xzUlR5dDNwcEhVRmdF?=
 =?utf-8?B?OGxFTEY2Wk41bTdocW0xWDlGNTk4Um0vSHcyU0FNaXhsd2EyYjRnSStCU1ZS?=
 =?utf-8?B?aDlTb0FqYkhQZ1FmaGFaR0x3ZS9OK3FzVWhDaUc5TUM4OTRZZFQ2bnVKTDNu?=
 =?utf-8?B?b3lNN1pDR1huU1ZlbzhmeWNPNnVWc3lTWHJjNjd3dEFyN1NCKytuSVc3Szdq?=
 =?utf-8?B?KzNSV0RlL2NJS0pyb2Rkdk9ncW1rTEhTSUVLcXZ1ay9FcWIwdjROM0VjbWhv?=
 =?utf-8?B?b1lHYnBrbi9SUi9rZVVLY2ptbncwSmVscUdUdVRnWDRQODE4eFZ3TUM1ZnpG?=
 =?utf-8?B?V2laU3JVTFFVaUpZQ1ppNktWRTJaOEh2TUdlT0xqbVE4ZkVrUnNJcUdwN1RR?=
 =?utf-8?B?eGxsdHpLSUlIZEhQRXUxRy90S2hGaVE2TzJXQlpRZkMwM043RzA5NkxJN1Az?=
 =?utf-8?B?OEliUmg4UWtPa2dUUjgxT0VST0IxSWtHaWpyYXJNMC80ejVkTmVwS1ZhS2hj?=
 =?utf-8?B?S3hrZXBUL3ZIUm1EWlA4SWRwdDJiN0lFQkRXSXVIeGkzZ0ZQMFdOdjlMTkMw?=
 =?utf-8?B?N3hoVjUyU1k1Z2c1N0Q0Uk0xSHlTVEtza2VEY01qS3BXME1pVUtUMHVwb3or?=
 =?utf-8?B?RTkyN0ZNK1ZrYXhldVZKYTlCbVJIZm5oR0JyMzl6YVdjUSt0K2xLeEpzSkd4?=
 =?utf-8?B?SSs1UVZwWVFxckxkY2JwQzh3Vm1HcjVpS2VadmU2SVBuU05zSzR6Sm5ueFpq?=
 =?utf-8?B?NDJZcUZacGI0MHZqeCtVMENXTlRua3VEcWJCMzlyb2dhTFIrL3RjYmxMeFFt?=
 =?utf-8?B?YVc4dUFuRHlVamQzVHRZMVYreUFneFpLQ3FPNWtlQzJWellPd2FKYXo1eVA4?=
 =?utf-8?Q?si3wWkiwWDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVWdHVzZHdaMXFERzl0MmFmREdKdU5sZm5KMk9pRFcwbHlrVlhpZVN3Szdy?=
 =?utf-8?B?eEh6Y0tRc2FmRzhQaFFqMEJYdGVjZzd3eWI0RVI0MFkwalprallTc0k2cDBG?=
 =?utf-8?B?eVQ0ckFoR05SejNzTk5xUDkzWTY5L1o4OXdzL1pkVTF1SFJKNVF0Q3h5dkpu?=
 =?utf-8?B?Y3pxcHI1ODkwaXl4MVpNTHpnQmhKaitNMTl3RTFZN2txRGtCRWh6a1I0K1JW?=
 =?utf-8?B?dTNqMVV5Uzc1UUVPOXlXSUxKWkc4QjVJUUd1K2RJYTE2MVNVbzY0Q2FyTEll?=
 =?utf-8?B?SkZrSHB5alFTMngxRHlIbm56VUd0OUtrY20rY2Y1ZW9WMVpObURuTmdodE9R?=
 =?utf-8?B?ZmtlUWtMVnh4WjhJVHRLZEdCNW40MDVSc3l5WHlrdFRqTHNZcExpeFA3NGFh?=
 =?utf-8?B?bG8yQ2dKaGdiVmxONThRQkJqblJuV3FqdjByWGRvQVY3Yk0rSFRPUi9HeUxQ?=
 =?utf-8?B?bXl2SjlZb2FMNjVNTUhHVER0RCtKM1Izb1JsOHVXZ1hrN1BZeTNHajFRQnFD?=
 =?utf-8?B?ZmNiWmlGakw3U01kWjIrTGV2d0FLNGhyZ0M1cUJDMWlKejVDR0dvNk1FMkVv?=
 =?utf-8?B?K1kveHl0bnFSQkFYd0pQV0Z3Nm5LSmphNkNXK1k4T2ZWL3ozd0pUR1lkS0xx?=
 =?utf-8?B?aHJ6RXp2NmNXWXpaM2ZyTWtEZDVqRXJrVGhjMmdZeVJ1dDJ0bEdCdHpaeE10?=
 =?utf-8?B?K3dGUHJsSnU0K2NxMDBqblJkMjRYb2pYdTN3WHJoZ0RSYzA2anNjK2VLa3lp?=
 =?utf-8?B?ODZ1VmhBQ1ZBNXRjbmJaZFlqUkpWNFlYQi9zcU5JMEMxVG9wZ3RkK0R5cVU5?=
 =?utf-8?B?d2N6TmJOcWRQSi9UMWkzY2dPVUxnOTl3N01pMGVZdnROTUk3ckNNUEZkQk5B?=
 =?utf-8?B?M1BremQyUXhnbXRGMHRqZFNmVmFlVEVlV0puWTdPMVRwZ1RIekpWZjRRN2d0?=
 =?utf-8?B?TzlacEIySktKYzlxWmhYWmI2aEh2bW1sTTdjSkhVU2FsdU0vMGQ4VG1GaFFp?=
 =?utf-8?B?NkVsNytTY1FBemxLZWROUktPOWFEdnBjeWw2ZUtxU0xNUnIyRk9EQUphT21Y?=
 =?utf-8?B?ZTJwai92Q1YzWERqZUZleDFrUUxzbkRWdC9yWFlXTk9lV0JNdlJVU0ZFdFdp?=
 =?utf-8?B?NnFlUmZ3bnRocnl1anVFaXlXWGtBZWlpOVJLLzU4Nm9tT2ltdkdFVy96cnJz?=
 =?utf-8?B?aS9XQjkzNWc0bXhnYVBsampHYjlwYS9UMUVrVXhTVnYyT2dDL2ZpT0NWMENW?=
 =?utf-8?B?Z3MvVi9FQWtmQWdGWlQ3RGY5Z3c4d3hGMjNVcSsrUnZJUlNkMEdNaFRqM2t3?=
 =?utf-8?B?TnhnM0U3cUt5cUFScmRZSEJuR3hJL0hEMnovVVZwWDVTb1BUbXZoSUVCbDRs?=
 =?utf-8?B?WnhkZzhkOHNYdHdFeDdObTA3dHZuTUxKZTNuTG5kL05CbGRLOXFsS2dxM2JJ?=
 =?utf-8?B?SS8zbjJKQ0NnNUdjRmJna1cweTc3TTdlMlF1ZzZORnZsTVdPL3I1b2NvRlhl?=
 =?utf-8?B?c3pvQktJZ2J4UVJyK1F3bG56WUJQMW9UcUwwWUhIMjY3QW83amhFODFndU9K?=
 =?utf-8?B?d25mRjY2YnZqVGR1cHdsTmVOOWNqMXJFMUJaSnBDOEp6T081d0ROUG1RRDRj?=
 =?utf-8?B?VVZYcHdCbnFLUUlFSlhnUFdFc0YxVFo3OGVlS0tTdU5rSUZ6SC9VNXJBWXEz?=
 =?utf-8?B?UHdpb1pIMUJDNFNaNXVDdmxRbXNEbVdHNGpaQVBSdzZtNzlzMkhoM1ZhWUpW?=
 =?utf-8?B?NGVxcW1nZ1VCZytGVnc5STZXbDZoSjAvdFk1VmNUQkg2WWFYa3licFBQa2NC?=
 =?utf-8?B?SnJWQmpnd2tIVTlnMXdHQWcxcDdDQXZYejhzeFJ6WGt4SUJ4RU9ncTk5MzVy?=
 =?utf-8?B?OUVJM2VBSlRmSkdyUWRqUS9VTit5b3J4YjF4WkhyTVhCZ2s3dmFLZjd0aTFL?=
 =?utf-8?B?dEhpVWZ1TFJ4S2pBUnhhS0Z6YmZFZ2ZYTE9pSlA1UW9PWmR0dmRpRzlVRjYx?=
 =?utf-8?B?YWVMa29PTW1YaDBwbnFucTBhS2VSWlEySlBoQVAxalI1bW5rS0U2Nk96VmVa?=
 =?utf-8?B?ZFFoQ2l5eXE0Z2lqU3BMK1d6UHpzM3E2eENLNEtObFlMdHZwdUczaksxM2Ni?=
 =?utf-8?Q?vN/JNg3PnCa0LpO87yj94oUux?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e6aeaf-7265-4dd1-78b4-08ddcda61020
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:12:07.6949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt58wStcenytUt8cKzXe57r2X3EW9u+WUZKZVUz4FV3WB4dtCZLoXm51G5ymdssT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
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



On 7/22/25 22:08, Tom Rini wrote:
> On Tue, Jul 22, 2025 at 12:51:45PM +0200, Michal Simek wrote:
> 
>> When QEMU v10 upgrade happens MB-V targets should be wired to add them to
>> CI that's why add configuration for it.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

Thanks. Can you please merge this?
Then I will start to enabling it in CI.

Thanks,
Michal
