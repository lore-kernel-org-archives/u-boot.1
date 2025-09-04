Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF03CA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 07:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24DAD836F0;
	Thu,  4 Sep 2025 09:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fByZBx0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BE483734; Thu,  4 Sep 2025 09:16:31 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDDD836EE
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 09:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIAzwNULy0x+4fG3mYf9Jd6vQcHmRYcez84bja9cN96B671V3aBUZhGFKQT+Pz+6OB+4GCqezVHLxbmyh80YsRJDZiYIQetk7RtMj1JDjPdt6io863jQoN6u0uWumvi7ef7+lnBolyuJLDSPXsL97wRhusgV0sPY4Iw12vTpILyGipGa31ol/h3/cCDudo9FBUmo7XEHzNxmGBjZZVRfqhEJVtkLZDntBEfLyL/elZZrBq1Uk9g0MdbLe5W3fywF09s0Ef2CKs+eswCQSqgtXG56sVA6/BjE2XRu5B4Ql1prj/sJT5dl9hHGtrCB41LW9eHf6qPye6FoV8e3tOQIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9D7vcgLeKqvItNxnNtygU8/N1mU6qE5J3JgKxnXjow=;
 b=SKY1edVAKB0iXtRTFqj2h32oSQj/xw92L75H23T19GmNH3S8hayMhPfbQW9+qvKAN2viI61oJ7/84MQrurSBv91FiPEm+Gabc64mPJ0TKHrR0RUsK2MbK9k05ea2ENVEEyX+sHggBZGLS9CQqPYC6YOFNZCHiD04BZFq7ilOuAqKR1mzLFMZP2papPoTbGjq5i0FrP9P5CCuvFUawwuq/KSEmGEGv4tVysphWhYiCVj/lIQi+G+wgpTbPaeOBt+uVa4DNhKX9/Z2v7tgrrDtZ12zDDCP/7n1LFnoDH0qFh0McqZvw4B36W8QLXS21V7ZdXUZ/9odLyFfQ7PXUZy9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9D7vcgLeKqvItNxnNtygU8/N1mU6qE5J3JgKxnXjow=;
 b=fByZBx0iMLKRtAs3tfTcNlXHcyj7aP19+BZKHw90Rwjn4qGZCtT2xWtMJPhB/nXHW4yf4d8ZtNMylFj5/c+JHUajg0OOBhrzy+vZ6ipvjDApau2Nk4nk2TtmD39oHmEk+c1F8kBpbHdAAt72+jU/UfltHo0zljW+kxPlGMbBFvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 07:16:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 07:16:25 +0000
Message-ID: <eba59573-f2b3-422a-8b2d-dfab327ffd93@amd.com>
Date: Thu, 4 Sep 2025 09:16:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tools: zynqmp_psu_init_minimize.sh: Switch to
 clang-format
To: Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250903220942.473282-1-javier.tia@linaro.org>
 <20250903220942.473282-3-javier.tia@linaro.org>
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
In-Reply-To: <20250903220942.473282-3-javier.tia@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbfcaab-3da0-4692-0df5-08ddeb82f56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmRyN1A0VE9DZ3RibWZjQ2g0Znc0TEhwS3lpSERrMjF3SkN0dHltSWtLRTBt?=
 =?utf-8?B?VVNrWUxuSWUvdUxwaGl2SEsyaGpTblFlYUNFRDVqYUw1eEJKL3h1MXFNU3oz?=
 =?utf-8?B?MEhHeG50Q2R4TUhpcS9SbGdtajdxclJWMXB0dElVemtwVmZ3b3hVZEpLbzNm?=
 =?utf-8?B?Z2IrSDhkelVkQ3VyeldwSUpoSVlxV0t6NitHVlhZbU9mTU1DQ2J4MW9xVnBX?=
 =?utf-8?B?WlhOV2EzdVJaRjhxM1hYcVB0SlBMaGpGdUl6M1BOcEZjZXJEakxMbVRwbVBM?=
 =?utf-8?B?bWhZa29vVDVxT0pReFVrajRldVhMaHVLZlFEVHRnRHJqZDJhTEw5S3BRS1NV?=
 =?utf-8?B?YlNZK1RQbjlqVDVGMzgzYy8zWnQ5NGdVcy9rM2MxY0dYeUV3SE5sWWpHRWxR?=
 =?utf-8?B?dGgxcjJIVjMrc1hqRGFEQmJGcVpScUhJeFZIcG1EYlJIcEUzRmJTckpwcU1q?=
 =?utf-8?B?MHcyVUJjZU8vVHphVFN3T3laSFF0aDN1cVJUSTVsSG13UmJmNFZBQWx2eVNJ?=
 =?utf-8?B?VjNWUW4rRmVTZzJ1aHV6M0xKenJEdmFQTVZScUtVRmk1b3FZZ1pJbUVOaHhq?=
 =?utf-8?B?bWJHQmllc2FnbGUzZUJZZGFHK0Y1bVVGUWdVUDRUdFRSMXZjOEJRL0ZVeU1h?=
 =?utf-8?B?Q2tZVSt1RkIxVnRxaUNrVjZ1K21PNnhWc3ZkUHVuVWZJaFZka3N0UWJ6c3J1?=
 =?utf-8?B?ejVXdzZWU29PdGNwaWNDRzBOZnpseXNLUjdlVFhZU0lqdjZKUWRZQm1VV1Fo?=
 =?utf-8?B?bEQzNnlQQk8yeW0vVFZZUjBNRjlDZnROWjVBWklOZ21iQlFkdHE0ZkJXN3RL?=
 =?utf-8?B?N3lRUjFPaEV5cUZmMFdlS0xhS0NwQ3BWZWZ6bFpMMWNYekJISnN4ZDV1enRZ?=
 =?utf-8?B?d1ZOVTV2NTBHTFZFQWNTNHhYSUtMN0YvV25RbjVFcDJnSW8zNHpKK1VuRTJP?=
 =?utf-8?B?MHJRVnlLQStmMU9vSGo1Nmd1TU9vRWhBY2RnWDIyVDhEb3NZUTFhaFNYMk9F?=
 =?utf-8?B?Z01wM3REYUVkUzBOU1VLMUhQRU9ucmxnelVReDA3ci82UXhHZHVJWVFnVDda?=
 =?utf-8?B?YkdCMUJFaDJXbXZXdlhtYjErWThPODhNai9OeldXbm5SL3RmRWtxMHppVysr?=
 =?utf-8?B?QzA5MEJDcjZiWU15UDJwWTArNUdMVEt2OFUvZ216SGtUMlFsS0VpNXovS2lF?=
 =?utf-8?B?SWdXb3NPajFUaEgvMXRkYlk2SnNIdlJuaDNCY3VZWW5UajFjc2h3QmhPVlls?=
 =?utf-8?B?TjVGenE2OEVpMlNzMXRzNnNkMTZ3UHBnakswN2Vrck1objJZL2dzelFBUzRO?=
 =?utf-8?B?OHROc0ttWDdkUzBSSEhmaVJUNjdSS1ZqTmVtZDZJelNoRkJnWUhZRGc3Zi96?=
 =?utf-8?B?bDBQOFhSTFg3UHFsaVhaUXlxWUY1RW5VWUtDc05mSmFBN0N5R1lyYUgvT1Bl?=
 =?utf-8?B?T0JZWTduaTVFYnBmQTRTWks2Sm8wVlFtenpvN3hXb2JkMnJPMWptVmhJNDZa?=
 =?utf-8?B?VGk0cDlmTnJPYWtnS0Z5OVVYeTRNL3duWmJwODNnbkkwTS9VeE5mSmJHR3Rs?=
 =?utf-8?B?RG5UME5iRjBuNUQydVFHOEZJbmxOc0d0dkgvS1pKNE16eXJFa2lrcjFXejll?=
 =?utf-8?B?eG83VFRsRnZnaWF6Zlk1dHhBZk9HRUN5cTg4dmlUbFNVd2xDbUp4bTFkZzRQ?=
 =?utf-8?B?ZG9ucy8rM3RRekJKWkF0ZC94M3V3VWNxK0psYU8xaUxyTDlhWlVLU3N3M0ZD?=
 =?utf-8?B?N2c5RXZpV3A3LzlqYWZESWtMaGd1VGRUMWoyYStnUTloeTVrMHo2N1pXTkxq?=
 =?utf-8?B?Q29kdVljRnYrL0VnTTNRZ2I0OXVhSWNNY24zWTdCVmdCV1h6bi84RlllbHRS?=
 =?utf-8?B?NWZ0Z3pFb3F0V2NvRUtCblBkRy9kcDVGYkhaUXBDd203UTR5ZlF1cjNuV2N0?=
 =?utf-8?Q?XTWa/plyPGA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJwcFJKN2ZGMjNrS1gvVUlJZ2lKdklFRmV6RXJuNmRua3MzOXRyRTJCUTRY?=
 =?utf-8?B?K2gvdHpIOGhHZVBLWDgzUDZ3bjlOcEprOFJqa05wbFdxclkvTXJaT1Q0YkxU?=
 =?utf-8?B?RWNMTWprNGE1bDcwMWJ4c1JKblJmRUlQTzFsTG1vcEFsVG5pNWZlQkV4VitT?=
 =?utf-8?B?R29EdW5zRjY0QTZJNms3Qy9udE5lMEV3WEVYTUx6L2pkdzM0c2NvTlpjQ0sw?=
 =?utf-8?B?WnlVMVR3c2JEWlR0MEp6MWdLL0VDVzRJUUN6VGxwOTkzblUySEE5Zm5mUFNx?=
 =?utf-8?B?dnE3K3E5NmsrZzN5S282ckNjOS9iZ29qeTk2NjZxMDBieGFWeUE5QkJRZjJw?=
 =?utf-8?B?SCtTbGp2SjMxTFp0bEVBRzJNb0piVHJGT3YxYnZaL2dHUWZpZXFaSWx3c2pU?=
 =?utf-8?B?VTRvN3pSWkFRMm1uTStUYmExeWRNVkpmbFhzT2VyQ0s1ZExtT3ZyYllOc2ZM?=
 =?utf-8?B?ZTdqRVJWSlZEN1plR2tzZzkwNnVnb2oxYW1PU2FFY1BmZUF1dVZiRHdaSmhK?=
 =?utf-8?B?QmJ4VC9jN01SU0pkaHd1VW5VZTB2czBNSnVrS2xWMXJrL1hzYlVESWkxekcx?=
 =?utf-8?B?RFFZb1NUa2M3TlhKK2R3M2QzTEFNMkdCK0NxT2ovcy9yWUIvR3J1bGJaalR6?=
 =?utf-8?B?OXRoeHBXemNsbzlQV0NkbjFsS09LaENXbHdlZGdEaEpTV2NZU0Z2K2s1cFlH?=
 =?utf-8?B?dFFHQysrVFN3ME1ZL3FSUUdXS1Y3WXIxdHFsblYvbys4Y3YyNXVNdlFIRHVk?=
 =?utf-8?B?V2RCdjI5Q2lCSHlsZVU2T1VyQWcvTVFtZE5OeXZRSnVFRDIyREkrM3gyVERa?=
 =?utf-8?B?VHRPMGtjczhJeEt3eUFMNWh3NVQ4OFZCYSs1TXJseUM1UkIzK0ZXbzhKMm83?=
 =?utf-8?B?RXlkVmViK1JKZkZGUTQ2U01vSnF5bUVpaTF4bnJzV2o0dStwUFk1dnQ4Wi9I?=
 =?utf-8?B?elRaYXlUSVVFVjg5a09vY2JUa1ZUVVRxYkk1TjJYbmwvbFQydUM1dm9qQUNV?=
 =?utf-8?B?ejRjRENidUErRFc5Y3BISGptdVViL2NrMzBaMzA2Kzd1YzhDeGUwa2JjaGs5?=
 =?utf-8?B?TEtvelNhdjRlTmw4L3V4anBJZjYzMnMzcyt4SThGSzRVSEtGeDJZQ0hpUVpE?=
 =?utf-8?B?STIwbFBERXRVbUZtTnliZllvNmlNRnlVNjFGSFBwL0Z3WXFPck52bFVtTUNY?=
 =?utf-8?B?S2d0anpzMmFHd2xJOGhrekdPMWJMb0pMdHAwOEMyQVpiRmgvM05td1EvRC81?=
 =?utf-8?B?VnA2TjVkZDJqUE5heS9PdkFzbUwxb201R3VtaDloWEUvOTBxRy83ZXp0OU01?=
 =?utf-8?B?RzN1eG9TdUtTSFZ4aUZzVVpOM3dLeDVRN1VvQUg3clRKSnFLWU1LQk5ldlpw?=
 =?utf-8?B?T0xBMDdiUHJsU3ZGL2k0bjY1Tk1pdW94S205QXFIYWlPNlhWY1ozK3REUXQw?=
 =?utf-8?B?d00ya2FWUWFWN1NoQk9sRTRXaUJzTkZPSUszTmhweHVPeUxRbjVvV2RVK0lR?=
 =?utf-8?B?SWkxam9EbEkrQWVINXdobDBuSHV1ZnNlYktwN21uQmlVNkwzeEtIK2tyMGhN?=
 =?utf-8?B?eEdWT0xXSm9ZMkU2NWNxT0NIeWk3c3A3NG82Zkp5dHcxclgwSW50UC8vajBO?=
 =?utf-8?B?a2NkMFZ5bm9hdnlwejM4QzUvTFFzRjZBV3Jkbm8yQ3ZvZXoweUpPMzg0a2Z5?=
 =?utf-8?B?VDdXWURqZzNQbW5QQk9Vd1FRa0xGLytITEovYm9yL1JBZm9rTHhFMk92dFZC?=
 =?utf-8?B?OFAvem1nb1pPQ0xsQnR2RU9LcWN5bUxMeVZiVlFIaXZyUkFrQS92V3JCS2po?=
 =?utf-8?B?YUY5d1ZpQ2tLL3pjV1ZBaTBxTWN4U2FpS1BFaHcyRnBHYU9ROWQxL05WT0sv?=
 =?utf-8?B?b3pmL1IvNzg1VStWV3ZvSHk0aDFOK3A2UWRyVWE1b1QxM3BGWkp6TUcwUHZZ?=
 =?utf-8?B?N3g2L25pTmVjaW9rRCswc0NjY0g5NTBDdzJVdmphbmtjRVZsblhERFZnWEs5?=
 =?utf-8?B?WjR0UGRsamsvdWFGbzlYWmVaVk53SmhtQW9rekNvTG5ycFFUNXlWcWlVczZV?=
 =?utf-8?B?MHdKYUF6NWZFS21JekNTalVsdkZOTHJjL0p2WUZIejhGeTA5VVJ2dEV3T3dq?=
 =?utf-8?Q?+MljX6Mj+ywWpvluAFPsDS6RC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbfcaab-3da0-4692-0df5-08ddeb82f56c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:16:25.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl7dplVcclPbXkO51ALGwVtUn0HZHU8o/VP4xVMOwt3Ve2+bjCRyP3aVwayNiRoO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
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



On 9/4/25 00:09, Javier Tia wrote:
> Replace the use of scripts/Lindent with clang-format in
> zynqmp_psu_init_minimize.sh. This change is made to align with the rest
> of the codebase that uses clang-format for code formatting. This ensures
> consistency across all scripts in terms of code style and formatting.
> 
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>   tools/zynqmp_psu_init_minimize.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/zynqmp_psu_init_minimize.sh b/tools/zynqmp_psu_init_minimize.sh
> index 5c8b73703bf..f8b729ebc97 100755
> --- a/tools/zynqmp_psu_init_minimize.sh
> +++ b/tools/zynqmp_psu_init_minimize.sh
> @@ -82,7 +82,7 @@ for i in $FUNCS_TO_REMOVE; do
>   sed -i "/$i/,/^}$/d" ${OUT}
>   done
>   
> -scripts/Lindent ${OUT}
> +clang-format -i -style=file ${OUT}
>   
>   # Prepend 'static' to internal functions
>   sed -i 's/^.*data(void)$/static &/g' ${OUT}

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
