Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE0FD49C82
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 09:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC428426E;
	Fri, 30 Jan 2026 10:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A5bzHxD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436D5842DB; Fri, 30 Jan 2026 10:11:11 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C598421E
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 10:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3lhp79/bkbFif6gl6mKKn6c15MXq09TYyt+gRKhhA5hXyy9hBAOK/RVVzgegtaiYTaQoiiS14NV5apdyeQZKB+BRjhkTnb2VUIwZab+XahwDG3oBotTZFNlbXWLXryEeSoo3bCj/2BqsAarXgEy6tEOeUJgXyqcrQspJV7Uk/mM5lWQKBAGjMrV2D/Qqu9Yd2DTNT6AiHbtNE75jl2vgymOvwM1mSrZFVB3muiMNP2nl4aZ68SDiGVvG7igceZ6hq71V1BzD7oJvG3hTY7jZYWRCdzNmzUVlXRnqcimlT+Q2yE2eARiIC5/9gaZQ8ymBdP/Ekyz/I7eQU1PYizPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3FOjKejPxQ90z/e2ut+aOA/LJNUnpkv6LVDgRGEl9A=;
 b=I2KUUAiL9C1h7296e278JO+HeJSWkuDPItdEhoA4/wtgAGDCn3/QAyBar410FOJhOY5myN2FhMqzKE1cJPe3FGdubW6YNZi9LoAQnz+GpFkzpgTSj6vd2rwZosEw/JIZAZp8GKTQMX6XCqXEgGQIDmrfgSAuYxbB+GJP40oigh01FzWfSjoYlhyouGxjYsBAV655xg3p7Z1tHAKF4cumQE8Li2goOuLINC3VL44/DHS3NHR3L42f4A36zRSCgqd29lVl56HqvphUrjCGIqUBT5gg/NQoJX7aR7dYBMBtk8bXUNuf0Mxcwej75fYwcNdgtOhWMddJheqaORn+/Eqb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3FOjKejPxQ90z/e2ut+aOA/LJNUnpkv6LVDgRGEl9A=;
 b=A5bzHxD6hxundOMlavi0I+UKeZUfbXjIgQLBMkMzPbH1b/aaxOOftTClpVFNK2pRIYd/rGiGpeeCHCDmYNADp1LBiRz2dhj29ABVBuBgUbo66rsJ6Pd9BpeS5BZx8VBIRNAL4NJU1XyTMbgLtY+XfkvkM2QNp4llHn1iM7oZaqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 09:10:59 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 09:10:59 +0000
Message-ID: <8babb792-e277-4319-9f65-76263ca25d19@amd.com>
Date: Fri, 30 Jan 2026 10:10:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] efi_var_file: refactor to move buffer functions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com, Shantur Rathore <i@shantur.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
References: <cover.1769177838.git.michal.simek@amd.com>
 <a24775e12c07f363f05e966b707280487c8bbe3f.1769177838.git.michal.simek@amd.com>
 <CAC_iWj+dvScrzUYvWP=aeqr9wJAjL0CU6atnAm98F+SL2C_TBg@mail.gmail.com>
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
In-Reply-To: <CAC_iWj+dvScrzUYvWP=aeqr9wJAjL0CU6atnAm98F+SL2C_TBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0274.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::41) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cee976-9b1f-473b-9587-08de5fdf7b8a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHpNemVSMS95T2tFRFJUa0p5ZTJhdmdhOFcvdk1JdldueEsyejFyZGJvbkhJ?=
 =?utf-8?B?bDVkcXpSMDlmaXJkbCtmTDV4emFqZjNOS1IzU0pXSWdLeFZrL1o2N25PbnJV?=
 =?utf-8?B?NHVZUkI3UVVQd2VFL3lheHpkODVFMEl4dkFyd1hOUFBOZ0g0ckdINHR1R1U0?=
 =?utf-8?B?UDVLWnBnSmUxZnBWR3dnWEtsRlprdEVML0VXZGZNSGs5UzNjcEZnZWdTbHJt?=
 =?utf-8?B?ODhGY1VIYnlqRk5Oc0l2UzlTeEt3NlByUWloUTY5enpJZitPY2R3S3ZKeDJs?=
 =?utf-8?B?OGRIRkJpcS80VDQwd0N4UmRRa1cyTFlJSDc2bG5IRHBycUlPZm54SDZ1UUlu?=
 =?utf-8?B?QWtrdzRxc3Y0TVlYTmtoT3A4TS8zNlBUSjV6b1VGSlY2cHhVSTlDNHpCc3pD?=
 =?utf-8?B?eGkraVhOUkFyYkhRbUczYThaQy9hN2Z6TGNoUTVucGJ1WVpLcmt5Yy8vV0U5?=
 =?utf-8?B?bTVuL0x5b3lkVzdvZFlFenJDZTFrZ3l0NkFMY0toclpwQmk5bEpUUUdKYUs5?=
 =?utf-8?B?eU83eWJ6cEhweU5XUVBCVWZJSEpmdUlrWmh6Z09MbXViWmdNMmk2VENPTHF0?=
 =?utf-8?B?U2RuVTZUL0o3NmpIdXRMSTNjWTlTVzAvK3Q0TXU2YWVZQXZWNW1IRVl0SXZr?=
 =?utf-8?B?YUJmZm1nNjRkRWZxaFk5TG1sVWx6VWdYcndwRFp4UHFPakk3bEdPK2c2RWpx?=
 =?utf-8?B?eEZFME9LUytDRXh5bU51WEM3aVB3V0tma0VUZmxwQlM0WUtlN0FmR0szcG1j?=
 =?utf-8?B?TVVBcjZiRXRFRkVDZ0xhSFp4a2VFdlBHem1sSHcxMytYWDVtakZEdlBSR2lE?=
 =?utf-8?B?eWxxZXU1N09ISWo3anMxbS9JZkVMMlJpUDMrM21mbkRpdlJuU21rSHRLU0ty?=
 =?utf-8?B?b3pESFFNd2Fxa0tlcWlZTThjYWx2Y000cUJRTGdBZWw4ZG9Lb1NoOGlwUnFY?=
 =?utf-8?B?U0tKVXRrbkx6aytMOVh2NzlvQVAvTDVMZlE0RlhuOTBYWU1pdnlCbjQ5RStz?=
 =?utf-8?B?bzkzQnhyNXlqTGNhNE9BYnMwMWowYlE2SktRdG9uc3QzMkdKRFgwelZGM0Rs?=
 =?utf-8?B?OWpmVUI0OWdFQlZLTGxmV3FoMkRnemU3SUZxZDdFK2xyUmdjallXbTJ5cHg1?=
 =?utf-8?B?a3VJSnJmVjlmSmdoVHNGcHZtdkhmMmU5dStzcDloVU4yUFZPelJaZE9Wa2Vt?=
 =?utf-8?B?aEM2eis0eCttZ09hcXFOVmpaOUZzYkQ4dWt0d0xlWU1jYlBSMTl1dmg2U01C?=
 =?utf-8?B?ZWpLUEZ5TVNMS2wwUWJjUG1mWjQydlJaUXNjMm1NaXVUZTcxc2JZZzlDNFFt?=
 =?utf-8?B?d2I1VkpnNzMvT0FLM2tMbEhqcWF3SUp4RXRaY0tjcUg5c3lCY1F5ZVdxS3Z4?=
 =?utf-8?B?d3hhWk9SWUtFSk8rQzY2S1daNjEwaVBRd2VOSmdPTEpqWWhjQW56VXdjNGxR?=
 =?utf-8?B?TkhXbitqeU4zUVZjYjcrUzlOSmxEcnpHUGgxRlJ6Nk5MOG9iY05lTGRXd3dq?=
 =?utf-8?B?dWg5NFJjNTdtT09MenBqV08rcWo2bGxwK1ViRFNDeGxYVUxFN3lYM0lnSWVP?=
 =?utf-8?B?RHc0N1dadnlQdm0va0t2VGpkL1RJUUtLNDNCMUc2cERYdW5BaFNZVmRmOUdy?=
 =?utf-8?B?YVRRcFdDWSs2MlRWZklpblAzRVRzQ2ZuWU5ub2FtaUp3QWgybXBJUFIyR1NY?=
 =?utf-8?B?eVV0aE9jZDN2WDRjR1U3V2pFVnZvMTF1WmYwZHJGNHR6L0dzcTJ5TGNNQkty?=
 =?utf-8?B?NjlWV3pCQXU1cjZ6NW42ZWVUbXphN2w2ZWdOUVIwWjk2b053b0tZUjNSenVr?=
 =?utf-8?B?bk1IUlVlMW84WWd5L1lpN3V6UXVRaE9JUG5kcnlzUlRBVWtrVVlCY3pFcEJT?=
 =?utf-8?B?TCtKTzlrajA4bFBMRGIxeGFabDhrL1ZSVi9OVytPbXhzWlRnSU1vZTRzdW9o?=
 =?utf-8?B?WkJoeEpKMDNLdGpTNzBsbXdaT1UxcGZVT0t5Q3IrRUVyOUhkeFRTZTMzcFEy?=
 =?utf-8?B?WXo2U2RwMTZDalc2VytKYXFkS0UxZmprVkwzU1FjbGI0dFZvanRHVkFsMHc3?=
 =?utf-8?B?MW0vMTBGdENvMXRaSkJwM3VXbkRDOENqNzVna3Rjb1E5TWNacW9RNmw0UWlx?=
 =?utf-8?Q?HeGM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVk0Qnd6WU0wWStQYkZXM3BBaU9neWlYVlFjRURyNzFzS2ZNU2VjWkgxUmlH?=
 =?utf-8?B?bjUxSGZuR0k4eFVMUVVTRzJxNHR3WjBXRUVERFowUThDQktxVzlsNWdEOFNu?=
 =?utf-8?B?MlpXZjBldnJ5bW9RSDJDZ2FDTWFabmZRcHY1NnNiTld3LzBGT1l1bTRDSlhv?=
 =?utf-8?B?RnZJN1NmRU5HQldrc0p0bFZuWlQwT1F6VjdtVkpENk01UWRtVTJGRGZmZVJQ?=
 =?utf-8?B?ajlBcUN1SUVnbjVBNkNGMTEzNmxoMUVtNFlZSmlJTlN5SFlTK2ZUTDNod052?=
 =?utf-8?B?MXRvWHduSnZNNmhpUUxxb25oQUdCcU4yZ3ZybWxhSkFRdFhxbVltNzdrb0sy?=
 =?utf-8?B?WVV3VUk1MHdpV1hlZm11NVZtc1psQ0dXZTFTbEVIMWFoOUI5RThCb1lveEM4?=
 =?utf-8?B?dXRXaGtvNnlNamYrRTlxcTV0VDVqMHpWazMvQjdVWUxXa3RobzhKbzh5c0VK?=
 =?utf-8?B?K3RqcEEwc09jdkdZYlhFTXV1dnRvMjlsOGRRakNqWllTQXBWeHVWNXRIZjVr?=
 =?utf-8?B?Z2lqcDNpLzlHN1QyU3BVT0ptRHZhdWU4SjBqWHcrWWdXM1lxUU1EVVZzSHVK?=
 =?utf-8?B?T0NFQlFWN2Q2M1hISkRZVHBGZW1aRFdidXZ3V0FVM0Z4eVoxY2c4d1RLMlNl?=
 =?utf-8?B?c3FPbEVYMVVsRnB2QlZjQUx0VEFDR3hwMFExNTd1R0JveG12ajd4ZkI4eUta?=
 =?utf-8?B?K0FGYWt0aFg1MllrNktwbThwZ29nNlo4MW4wcmREaVIrK1dyUHRDVUpwUURP?=
 =?utf-8?B?bzcvNERRbkR3U3FYc29tL2hMOVZQdUR0Sm5rbFZEUk80N3QwMUdvSUg1OWpH?=
 =?utf-8?B?THZ4ZjBBQjN0d05UdUNGMlovS1Rhc1B6dFc4VzJOYUg3YlcrT0VteEtlZTVB?=
 =?utf-8?B?cjVMekhOQ3QrSXVFL0crNEJhZkxhYTFaNitpbXBKNzRBbUpkWlhLRXFaSDl3?=
 =?utf-8?B?OFZpcHM3OGNLSFpaN2JBdkdIUkdyY29VYjR3NGk3ZW0wZElEcFI4L3FIL3k3?=
 =?utf-8?B?VmwwMlF5amVYNnkxRXpnOXk4RmxrcnF5TVhGNnpob2tvQjZRQ1NHaldFR2tE?=
 =?utf-8?B?WDlNTDlGb3ZURE9iNFNJcDFxV2tOdFJDQ0dCb1l0OWFNa3FkeCt4UjA5bXRn?=
 =?utf-8?B?Vkl1RGYrbVpScjlZU21hRW5WZEpLNGdjSm93K0tsWDFSb1V6VVJmUWhHc1c2?=
 =?utf-8?B?NDlDS2o2UUNhT24wdjNuUThrM3k0ZEQwUCtIQTVvclhFUWFzekZqNUtEMWx2?=
 =?utf-8?B?ZVVsYysyQldNNjk2c2JoaUw2WDVUYjltTVU5cjVFelU5c2VHaXlSVWVFa3hw?=
 =?utf-8?B?RzI1dG5YL1N0UFNNNWFWcEQvVmhMcFFMTHNGYk5TdE9YeUVEa3o1TE5ZVjFT?=
 =?utf-8?B?b1R4TWd6NVBwWXZDM0JXelFkQWs5OXp5S09PVXA4ZUs1dmdIdVlIT1BnZkVo?=
 =?utf-8?B?L1d6WjFKaDE5RUhmOENsT0kvM3ZLWmc0cGRDM3hFdS9KTWxhalF2MytUelBJ?=
 =?utf-8?B?cDdxWG5YUlluMDdZaFE4SEh3UjZFQjVhZkl2TVRlaGN3VmRYTFJ1L1FxQTQ1?=
 =?utf-8?B?c1NnUEN3Ym1remFQVWV1V3ZQRUlIYzVPbElSS3ZqWjZHWVhKQWo5RVE1akN5?=
 =?utf-8?B?VHNFakw4Ykd2NjFtZlA5Snozbk1mY2djbEVrMlp1VkVWTi9CdmRaTFp2S2xM?=
 =?utf-8?B?WmVnNFMvYVdkdXBwcmVPYmw0bjU1NFFuSWkvUkwzYTFOUjJRNEo0bkZsZDNn?=
 =?utf-8?B?eHZkRUp0YThROW1zUmN5RU5UYVh1WC8xRjNmeU5zdis3WXl3TEFTa3M1V2pY?=
 =?utf-8?B?SDN6NSt3MWJZSDFDZytJY2M1WXZxNHMvTzViKy96ejQzQUdjOGk5cnpMNzFu?=
 =?utf-8?B?NURQOFhhL1hUMjVHZm85SEZiZWVLdm5MNUVHYVhUZzJsT25yUmJ5Q0dRV1lv?=
 =?utf-8?B?aldnOHg2TDlqdFpiRmpmVkVXYW0rUTdzeDEybDlJREZ5c2pFRmZJMEwydXpT?=
 =?utf-8?B?eW9kNWpROHJIaUY3NDF3ZjNlVWV0M3JoYTZZdEVZTm9LRTBnQkVNK1hLWitT?=
 =?utf-8?B?WWk5dnk1emR5RXFMc2Ntc3lLRXdIV2F4Um12QkJkd2NkeGw0U0U3TnJhTHla?=
 =?utf-8?B?NkhzdDlrR0xSZGE0cU9rMlNVR21UQkJmeGxhVS9jQXl5Z3FlUHpEdXRyMWl2?=
 =?utf-8?B?UFpFUEx4RTBWd0dtdXFpYmk5OFB2RjdQdEk1cEdrOEU4clpwNVQvcFJ2TWpk?=
 =?utf-8?B?OGsySHVxdDduZXN2elNzOWRUZm4zakh0M2tsK2E4UHZUNlNoMEpNTFJOemFY?=
 =?utf-8?B?T0krRHR1ODZXRk1ENmJZa3JXeHVwR0ZrenF4dDg4SVhlRVBaKzNrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cee976-9b1f-473b-9587-08de5fdf7b8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 09:10:59.1308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IB4pAArk2WJbMKFkFHHpfsFtPuGXS7y+ynzFpCdqwgQKtrQ2P3bISkSQcN966CtC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
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



On 1/30/26 08:39, Ilias Apalodimas wrote:
> Hi Michal,
> 
> Thanks for following up on this
> 
> 
>>    * efi_var_restore() - restore EFI variables from buffer
>>    *
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index f490081f6542..ca1775eb03be 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -53,7 +53,7 @@ ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>>   obj-y += efi_variable_tee.o
>>   else
>>   obj-y += efi_variable.o
>> -obj-y += efi_var_file.o
>> +obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
> 
> hrmm what if we compile with EFI_VARIABLE_NO_STORE?

What's the concern here?

efi_var_to_file/efi_var_from_file() are just defined in efi_var_file.c

But that functions are never called from efi_variable.c

        if (attributes & EFI_VARIABLE_NON_VOLATILE) {
                if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
                        return EFI_NOT_READY;

                 efi_var_to_file();

I mean undefined reference to efi_var_to_file() is there but because there is 
return above function is unreachable and compiler just removes it.


> 
>> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
>> index f3533f4def3a..13db6eae882a 100644
>> --- a/lib/efi_loader/efi_variable.c
>> +++ b/lib/efi_loader/efi_variable.c
>> @@ -397,11 +397,15 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>>                  ret = EFI_SUCCESS;
>>
>>          /*
>> -        * Write non-volatile EFI variables to file
>> +        * Write non-volatile EFI variables
>>           * TODO: check if a value change has occured to avoid superfluous writes
>>           */
>> -       if (attributes & EFI_VARIABLE_NON_VOLATILE)
>> +       if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>> +               if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
>> +                       return EFI_NOT_READY;
> 
> I think we should just return success here. EFI_VARIABLE_NO_STORE
> means "dont store on file, but we still have to update the memory
> backend.

Yes before this patch EFI_SUCCESS was returned. Will fix.

Thanks,
Michal



