Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905C1CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB07D84BBD;
	Fri,  8 May 2026 12:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="L8Fpq4Ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424D184C45; Fri,  8 May 2026 12:05:39 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEFD84B02;
 Fri,  8 May 2026 12:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgO4l4rxePedeHDGGnid96lwYPn9LaU3OO+jjZgBE8YUgMQRRJcX31m9FeZ/+AxdwL+WAgZfQXGFm3oo2zJWY6flpxfCqvn4r4erkJv7YWXL+aBwdkUD1Z5M8cZSy5Bat5MSiDnvpphhxPkmnYU4xi2KVbFHdWljqKNmRElxlijlyRZUYm3QmhIpPCkxt57ibhLQxLpRDAtYbwyphZcm6yDfs7xCfHWMnb7Eka2vpn84Ifa4SPgaDmyF2nyOUFB6yCsV5r1JcATNSxv7bzpd9L1luhipgZFknZ2jOygZbyW43zFD1dE1IRVpDSEb+cBK8gqrcrXwWQTEb4+sldRGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gL52hrs0yeL+Q7e4c0bg0Jk0TawQyxM9ws4Epjc2gk=;
 b=oLtfym4Vfga68KDKFPk6qmGgcXjtJRX3tRsg01v5Z6Ltr7Hk0ZZlQHLwDQh2BX2VQBzVhnj5MrwuiUMe8Q+8euOvtWhX8CCBYhYUJR7XBYA01X5ex9k89Tm0DOWWTcLuialaZLQzax07aBZjo5429AWq8ffdBS74czAMhM3wUulGBxlQL6+/g8aVILP73lCD9QF9WE6CC5PfbJlwqsGnSxQ6AhMEkSDYbMZ07B9YmTg2AG7U9yw4O14J3SEM+DvB3lBAR9f3ccZWGp5IozA7LgjlWqOO80o5ZA9aTMpG9ES5AkfR19dM98OW4FlwSYVBxDO4xkuSYUC6upyzUWRzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gL52hrs0yeL+Q7e4c0bg0Jk0TawQyxM9ws4Epjc2gk=;
 b=L8Fpq4Ftk+AYf6a6cFme9nRMNv6l5GxgBWAWbm36vi+ffPdnT9zr9xAQEJxc/EmDuHHHUoMhe088ls2kIuK/4aGMvulcfgmGgS8X1ICbohTFSAUGcYmAazwx8JfHrXFZ/T4oKaUgiiTGa75VKk6zP1eipZN9UxlSbZqvHm8O+ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 10:05:32 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:05:32 +0000
Message-ID: <f0e723c7-9b92-4775-8c38-5fa1cc791928@cherry.de>
Date: Fri, 8 May 2026 12:05:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0018.eurprd02.prod.outlook.com
 (2603:10a6:803:14::31) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: aeda9eaa-b46e-4374-e8f5-08deace95744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: CGYlg2paC820BgV6rG9W807+fosLfipPv9AY1VuPpk0/yIDmjQe0/Qs5jIAltNeCJ711HdNpOCQiB7Uk7ehaen7FISndQc6N6gSSysjzHSi7zjevxo+iEgJ17iSBBh94zdXcj9sRr8ZnhvpixpfN8nTi31WFdgF6ZBwburL/eDNzIf8Gfw+UGYRode9A6ojiH7kW3C6sgtVe7TSSUq/qd1iWldA0/x8aUeQVv+TmEiIFRUkDtm/uJOnhyMPt4AFUH76OQwAZdpT3MIwWFbcBEGbE/Grk5Xhz6UZd8c8sbaWjWhEcfO5ip+mGYG3FjSJP2rUUfi7PBH5pIRDEss0NMH4CmKT4aBc416Pt7sg4aFk1+OCiuGiKqMZ7/je5MjotQy1IWnOxC6dIcFzM3ZSdAZYjdRmK6a6UrPvZhKKJdRwMkoO3E3MltSK4dZKh/Wk8RKEC7o0jPXM0v2/kADr5d+W/WLuSXlZHTVRlLEyJnwlRMu5VkddAcbbbTWtHQ9tTqepPr/8oiCHAQGBL0fxalsO3esm/w3Pxv3j6byrD4H6zhOKenYZJZ54cUMOzLjLGfEhv1Fo8PevVVwyW7L5qDQ/QRubTLdu/RlHDjCr4PAUACq1bR5L/gMsqgzOnBBD0SzoWP3HJKlBEcDwDgJNS99Jxx37YY1GPfOdmehc/izVFTDOAjY68h86xVNYN4Q0sUrjx1FZr9OiBU45GttSedQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWFMbXlzd2VzaURTd09tbVVmY3ltWXpYUnByUktJYWRRdUNvUk1rbElVSzRM?=
 =?utf-8?B?RkllRHl2QUV0NTc0TTl4UktHVGVZWkZqT3hHZzFBUzhDK1paZjU5Z2FqdEZD?=
 =?utf-8?B?TWdQSGlhRkV6N2Z3cmRqYzhPNVUzWWdQUG1tZktQY0E1dHhJOVd1aTZLYVhR?=
 =?utf-8?B?N3EzeWJvd1Z4dGlCMmUzb0dzeit1SlZJVGF6aVF2N0ZzQ3RzTEdUZC8zUE03?=
 =?utf-8?B?ak1LOENZRmszbHlOUzd2RFhSUmZBS3RZeUNWdTVEU2ZnQWJiZzByLzZUWEZx?=
 =?utf-8?B?eVNQbGh0d1o3b1lDNjRvMm1RcFFZSGJIRkxhQWdPZGFoK0pPK1BQUktjRXo3?=
 =?utf-8?B?U1MvRFgrdUpTVXhsVi9CQjM0cjNrWE9FT1kvdy9BWEpFSUY3NEx2RFpFNUpF?=
 =?utf-8?B?K2t0ZnY4QkZpWVZQNW42Y0x0dTFXc2FCV1NQRVZ0NjcrMGJrSUVPR0wxRURO?=
 =?utf-8?B?TTNEemRrQmFvaXNiQ3E3MUJ5d1l4UmR4K09Bb3ZxS2VXNVJ5MDZQdXNZd2Nk?=
 =?utf-8?B?ZEtjZG9zVlNJS1hUK2QyV2FCNUVoOFdGYU5paFovNW5vNHNLc2ZKSW1yWjlE?=
 =?utf-8?B?ay9ieE8zaEljaUJBTFpCRVBWWml0bFFnZldZM0NUa0VMZzVFMkp6cEtDUmo1?=
 =?utf-8?B?ZnhPdXlXcEhIdm5kM1BWYmh3K20vQytKVE5LYU9ZeENBRUJlL21iSjZlMkxi?=
 =?utf-8?B?ZTlvdDdUMnNLTy9jbVhIRlp3anlZeld5L1R3c1g5dXZZSkh6Nkc5SWdqSjQ2?=
 =?utf-8?B?YUNHVVNjZmhLWHEwQ2VneWxxMVRCVUFCRExKWFVMZ2hhZURhYVFWYlZwSzlm?=
 =?utf-8?B?NWh3WWNHOGZrbjJDTEJNYzhneUxTYVdHT0FiMWwyUEV6LzhJdGU4bHF2QlQ5?=
 =?utf-8?B?RDFXNlkrU2FBNXBNdmMzUW5KN2R0Uzc1R1phcWtoTUprT3pHaGhiTzBWQ24y?=
 =?utf-8?B?dStIY21VbS9IM3lTTVBUdzZMUFB4QjRMczU0d3Zsekx1MGRFN2tGTW11ZUkw?=
 =?utf-8?B?S09TSjFXRDN3TFhBdldrd0gyV2FvdWJoUnVmeVFZMEdYTW1CNWFnVnFocW1U?=
 =?utf-8?B?M2tIbFkwSDdTSG1PY2poMTA2aTN1ZzJJeXZBTlJSajh0VnR4YXhjQWFjcTFz?=
 =?utf-8?B?bzV6b1hMVlFXY0s3VFVzMkVZdExMdCs2dGNBNkYxT2cvTTB4V2NSSjlMM2xt?=
 =?utf-8?B?Q3JSbkxuZXEyRkc0YklSTDB1MDV0R1F2R25BYUtMcVROYXJLN0VYRUlrVDRM?=
 =?utf-8?B?TkQ5SXFBby9obTB2ci9MQzI4TEs3SlJqYjQ0UVBjdnNZUVQxdTRrcjdGTUJU?=
 =?utf-8?B?dHdrMnAzQWFpNGQ2amJxUHdHcWdBMGQvc3lkRGF2Q0FBOWh4T0hLSE5FRmZp?=
 =?utf-8?B?YjVSZlp2d3dnVlZ6ZEdFRnpzZXdFWXBJUkp3M1F5M3pFRnNRUkxycGszVWlp?=
 =?utf-8?B?WlVUZW0rb3gyY0s0VXUwQUhGUllJZUFXVEE5c01nSGRXVGNlWGVqamZRZ2ln?=
 =?utf-8?B?emJKelpmMmVNdlYrNGZ2b0RmWnJEWUZuL0R5ZGFHb0krdG16ekNLV3R2R0pm?=
 =?utf-8?B?Mkh4cmpha2VCR1R6dEFiRzQyb0RnRGtDOUdzc3gwRGRaTEhLcTZ1SHBvd05Y?=
 =?utf-8?B?L25KVFBlYzc0clZYQnB2N0V3WVdiTU5NdDlpRm9uOVFNRzlGNkhPY2k0clla?=
 =?utf-8?B?ZlRVRVFQYUVkZTBwYWIvOVA0eWpJbzBlRmFJTjJGeHVNczF6Rjg3M0hEaFZq?=
 =?utf-8?B?eGpLL0dZd0pIMW8rV3ZUd3RwTjVVTFFWS1JQbWsrTmN4UG9WbjR5dWZ1Z0sx?=
 =?utf-8?B?MUtHaFZtTnJZcjN5RDdDbTZGeVlPVjlCcnZVU1NsMVFFdjM0b0RqS1NQQnJu?=
 =?utf-8?B?SnZOL050K2h3SFVQM2FIbW9aTzVSZHZKdXVRS09HVWsyaHYyNW1UK0RNQzAx?=
 =?utf-8?B?OE11WXJ0YUVBbFNPdEFreHV3eHFqbkVUSENNdFdvSUN5ZlJlV2Yyd1BpQzZK?=
 =?utf-8?B?NGlwK3ZCcnE5d1hES3hTZnNBd2FvMFpIQlppOTQzaWd1VUUrakdCODd0amNM?=
 =?utf-8?B?enBvcTdobmdpLzlmcnlqQVZtSWJRUFduc0hIMkJzWjFGZGcyOU5PQlM1eWti?=
 =?utf-8?B?T1RhRlFDVWdPTnUrU3NHMmxKNW9DTE5aQldKMEcrVVhrUDBBRFBwNXNPSG53?=
 =?utf-8?B?WVNsU3EzTXNHYVdRVUdLMXVRenBmQWVUOTBiNXRRK1dXdkpZS01jZi9jbTNK?=
 =?utf-8?B?dEpwQ0lLOHFwTjVBSTQ3RWhzUk9LUG9BczdxQVIwTXIvNjd2dFlKbVljWnpp?=
 =?utf-8?B?NVBuamZxclpLMmtaM2JuQ2VYMFFYTkN0WHlTekxkb0M5VnFPQ0JPQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aeda9eaa-b46e-4374-e8f5-08deace95744
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:05:32.6343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4JzBjxfP4mBFpDpy3+zcVhwSbq9LoCVjfxVQtM+2m5PjCE5usxsLtq0Ibxw6ox8sLPp7RoCw8oXME5kPl8a228s4uYNaltx2y2ABoKycL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714
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

On 5/4/26 2:16 PM, Simon Glass wrote:
> Hi,
> 
> As you know, I maintain several tools which are part of the U-Boot tree.
> 
> Tom has previously suggested that it would be better to move patman
> out of the U-Boot tree, e.g. to its own Github project. It is a
> general tool which can be used with Linux and other
> mailing-list/patchwork-based projects. I have never been keen on
> taking on the extra effort required, but I've recently added more
> features and am wondering whether now might be a good time to do this.
> 

Even before b4 got released, I've never used patman, so I don't know 
what I'm missing out on but b4 has fixed all the gripes I had with 
git-format-patch+git-send-email so far.

What I can say though is that I cannot install the requirements for 
running tests on Fedora, for a few releases already, because patman is 
using an old pygit2 which doesn't compile with newer versions of libgit2.

Building wheels for collected packages: pygit2
   Building wheel for pygit2 (pyproject.toml) ... error
   error: subprocess-exited-with-error

   × Building wheel for pygit2 (pyproject.toml) did not run successfully.
   │ exit code: 1
   ╰─> [75 lines of output]
       running bdist_wheel
       running build
       running build_py
       creating build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/utils.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/submodules.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/settings.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/repository.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/remotes.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/refspec.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/references.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/packbuilder.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/legacyenums.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/index.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/filter.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/ffi.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/errors.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/enums.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/credentials.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/config.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/callbacks.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/branches.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/blob.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/blame.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/_run.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/_build.py -> build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/__init__.py -> 
build/lib.linux-x86_64-cpython-314/pygit2
       copying pygit2/_pygit2.pyi -> 
build/lib.linux-x86_64-cpython-314/pygit2
       creating build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/types.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/transport.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/submodule.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/strarray.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/stash.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/revert.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/repository.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/remote.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/refspec.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/proxy.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/pack.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/oid.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/net.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/merge.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/indexer.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/index.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/graph.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/errors.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/diff.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/describe.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/config.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/common.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/commit.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/clone.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/checkout.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/callbacks.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/buffer.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/blame.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       copying pygit2/decl/attr.h -> 
build/lib.linux-x86_64-cpython-314/pygit2/decl
       running build_ext
       generating cffi module 
'build/temp.linux-x86_64-cpython-314/pygit2._libgit2.c'
       creating build/temp.linux-x86_64-cpython-314
       building 'pygit2._pygit2' extension
       creating 
build/temp.linux-x86_64-cpython-314/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src
       gcc -fno-strict-overflow -Wsign-compare 
-DDYNAMIC_ANNOTATIONS_ENABLED=1 -DNDEBUG -fexceptions -fcf-protection 
-fexceptions -fcf-protection -fexceptions -fcf-protection -O3 -fPIC 
-I/usr/local/include -I/home/qschulz/work/upstream/u-boot/venv/include 
-I/usr/include/python3.14 -c 
/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src/blob.c 
-o 
build/temp.linux-x86_64-cpython-314/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src/blob.o
       In file included from 
/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src/diff.h:34,
                        from 
/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src/blob.c:31:
  
/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src/types.h:37:2: 
error: #error You need a compatible libgit2 version (1.7.x)
          37 | #error You need a compatible libgit2 version (1.7.x)
             |  ^~~~~
  
/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src/blob.c: 
In function ‘blob_filter_stream_write’:
  
/tmp/pip-install-sg4tws_1/pygit2_dfcf87fabf704024a62ab6e9ec4033ed/src/blob.c:171:13: 
error: implicit declaration of function ‘git_error_set’; did you mean 
‘git_error_last’? [-Wimplicit-function-declaration]
         171 |             git_error_set(GIT_ERROR_OS, "failed to put 
chunk to queue");
             |             ^~~~~~~~~~~~~
             |             git_error_last
       error: command '/usr/lib64/ccache/gcc' failed with exit code 1
       [end of output]

   note: This error originates from a subprocess, and is likely not a 
problem with pip.
   ERROR: Failed building wheel for pygit2
Failed to build pygit2

and this essentially has requested I run the tests within the CI 
container, which I would prefer not to do if possible (I somehow managed 
to break my U-Boot local git repo once doing that).

> Buildman is quite obviously designed specifically for U-Boot. I have
> made some improvements recently (a large code refactor and distributed
> builds). I would like to push those changes to mainline. Do people
> think it should be in a separate tree somewhere?
> 

I've only started to use buildman when I did tree-wide refactoring and 
needed to make sure I didn't break anything. It's however essential in 
CI. I don't think it's actively being developed at the moment (at least 
publicly in U-Boot ML) so maybe that's good enough?

Considering the changes made in your fork are as far as I could tell 
mostly developed by/with LLMs and that Tom has been pretty vocal against 
it, moving it outside of the U-Boot umbrella and thus lose "control" of 
what can or cannot be merged while still making use of it in U-Boot 
seems like something we may not want to do.

> Binman was written with U-Boot in mind but supports other projects
> (such as Zephyr). It is generic enough that it could be separated. The
> impact would be harder code review.
> 

Is Binman actually currently used outside of U-Boot? It's one thing to 
support building other projects but if those projects aren't actually 
using it, I'm not sure it's a strong argument (though, the fact it's in 
U-Boot tree could be a major obstacle for other projects to easily 
incorporate it in their process).

Considering binman is an essential piece of SW for some architectures 
(e.g. Rockchip), I don't know if it makes sense to separate it right 
now. At least I don't see an immediate need for splitting it.

> We also have smaller things like qconfig (which I have substantially
> rewritten to make it fast) and dtoc, which is very tailored to U-Boot.
> 

I think qconfig is used every now and then by Tom and it was helpful to 
me when doing refactoring and symbol renaming. It's lacking a feature 
for me but saw your article on qconfig being rewritten in your fork so 
was wondering whether to look at it now or if it would make it to the 
U-Boot ML at some point.

The feature I've found myself really wanting is to filter configs based 
on a symbol and then print the value of some symbols.

E.g. I've wanted in 
https://lore.kernel.org/u-boot/20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de/ 
to know what was the value of CONFIG_SYS_RX_ETH_BUFFER when 
CONFIG_FSL_ENETC is enabled. Same for CONFIG_TI_K3_NAVSS_UDMA and 
CONFIG_SYS_RX_ETH_BUFFER.

I don't think qconfig is an essential tool for U-Boot and could probably 
live outside of U-Boot. I believe the feature of this tool would be 
useful for any project using Kconfig (Linux kernel, Zephyr, U-Boot, 
Barebox, etc...). It however depends on buildman and u-boot pylib today, 
so maybe it's unnecessary complexity to move it out of U-Boot for now 
(and also makes it unusable for other projects?). I don't think there's 
a hurry moving this one to a different place, it's not really bothering 
me to have it in-tree.

> What do people think? Of all of these, patman would be the easiest to
> move, with the least impact on existing workflows.
> 

I think starting with patman would be nice :)

Cheers,
Quentin
