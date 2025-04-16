Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9701C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B7C82DA1;
	Wed, 16 Apr 2025 13:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BvqK8gPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80AF82E35; Wed, 16 Apr 2025 13:37:07 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A8082C96
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkxgwlpf5c83GTI+KO0B5QXQH34d9Hqc4SY1tRMiKKDHLcQjK8FG2iC5OuHWTPj1mtRQ0zfgmWAJWqX5JtTtMKJPhO3Rs5ZJKV+m0aSCkIqFky0UU1XxvX4HEBpetc5A8Gh8ZQ9TagkuE5/ugEgTFv9at/FHPw5mdER/szUdn+Eq7EorWEZh0YDgwyk7USxHGi0HfSNfstcxRma2H85OwMQaKfN+xIanUHnFCxGKezELTr3FePs7+zb8NeXFPEyiqFBRnUB9cknl2qkkEVZNoyE0dYpDMH5Zp8Qlus+Srb7zrux+UJmMVzem0t7nwMG/ufgglbCWnD54GNXxVDt4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3hdNAtRhlChry74wpUiA1s0gBXHGtxbYfPFjtmcNbE=;
 b=aZSozRgP3wu1Ou6cVziAb1JK87thYqIqdVe7DskQCgPaBE2h/6nN5kxSUABtsfOT6EYfrvSAiHMfh+JLG3gKVGs3ZG82/d4Ib2jwQcMIyDdKHbbrkhSIQt2Uip1tK1znOmNqALXxzNOhTAK8YcEi9OMUdNhGugN/tCYqXix/+0DE4l2CQG+/ESB+nxB5fm5mLwcOCbFA8XxuZEXBrRHfL9GM0J/Jcs20hICuu1C1UcT/bUwofB3rKuNoDoOd49BKat+aKKAhV6NZsfLZHsYXalAWFOdbG516IC9WbDpCpaEVlQdbGdnlTAGlMOe40wyUmGuJjVs6EyZoEeFHtNne2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3hdNAtRhlChry74wpUiA1s0gBXHGtxbYfPFjtmcNbE=;
 b=BvqK8gPUqx8W9aqo/eFs/50I0LhNbg0qEk3RRB2FxnCQLRVRDOR18Uw5wT1e/okAknvnz/WycrbM+QbHzFyVuQ4fhtG0NxyxydK0JAeGyaAvYi7DoY1FtRuxHDOiAZ5Eswz3HuxoKK51WyEg2ahElZhKXZ4nXgU89hXYtwOO234=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:37:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:37:03 +0000
Message-ID: <9f47e10a-ff99-43b6-b0a8-9f96ecadd561@amd.com>
Date: Wed, 16 Apr 2025 13:36:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: versal-net: Enable loading bitstreams via fpga
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <3420e63e46e21daca3330ba2498aeb1ebc9b1fd5.1744273334.git.michal.simek@amd.com>
Content-Language: en-US
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
In-Reply-To: <3420e63e46e21daca3330ba2498aeb1ebc9b1fd5.1744273334.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 17abe46e-2089-4555-cd32-08dd7cdb020f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlE3NFdCZWgveDcwcVk4TU1QNVFJY3RGRjh4MEUxdmEyVVZDUS9sOGx0dHFJ?=
 =?utf-8?B?S3Ftb2pKUG5HWHNZRzdIOWJQQXBmTXFoSmhSUkRCUmpFSVJENHpHclBHc0s5?=
 =?utf-8?B?ZVhDRG93OHhYZDlndHk2cStXalJBUk9ZdmNuV0FMa1NrcUVvRktIbkQxdzZN?=
 =?utf-8?B?dHBYTEQ0bTVZSlhQRXZkcEhoSENrQlNaYllKaU5FdW1PTFJWQld0QWpST1Qw?=
 =?utf-8?B?cFBGdFNHVlAvTjc5eUZiSGJaZlNFNHhMSjh2L3dJd2ZTcmthQmN1dGMvNS82?=
 =?utf-8?B?b25JQ3A4eWlFOVZyZkFlbVNKQ1BYN0hnbXI1M2ZTekFCOCtXMFE2ZkNKOTND?=
 =?utf-8?B?Rnh0NUdCZ3lVcjFOUkZ2U3VsUVU2L1pmdnNpdnNGVlcyRWl5YzRRT2xSaWZQ?=
 =?utf-8?B?ajFQMEZySmd1dEQ4c1ZjL1FDQklHMlpnL0NMbHhpNFE0N1JLUjlvYjJXTnJQ?=
 =?utf-8?B?OEFkaE0wSHdybEttRzRlanhUa1Ewd0VEb2lGOU9HRzZDZk5rM3JiaUJNY0tN?=
 =?utf-8?B?emwrTCtsTWMyQ0NaR2xQRGI2MTBBWXFvTVR4aHRhVWhwSnF2SGRrb2hESFhy?=
 =?utf-8?B?ZGVWdEdlWlM3M0JLeVN6Q2dqTEIyblkrUUIvYlVPeUl1Z1lGcmg2TFdUQlNo?=
 =?utf-8?B?d0N1a2pPbmhreXo0UW9EdGlFOVZBNS9vTkNscS82L0c0Rm1Vc3k0YmVvRDQ5?=
 =?utf-8?B?RWRCczVNcFBGSEUvRmxjZExjU1NoOE5jc1BhSzR2SzFhek9iUzQrcVhxT3dJ?=
 =?utf-8?B?Y2RLU29ncU53Tk9MS012amRTS3BHU3l6T0laRzFoUVJRdkZmV25UTGVoVnNW?=
 =?utf-8?B?ZEh0Tm1XSCtiL0piYUtFd2QzNE5oM2RsRUo1TlQ4b3Rwdm0rL0k4WVBXak02?=
 =?utf-8?B?bThzWHorSlJwamhlNWFlY1lJZEFjM0w4NVFvQ3NFSk9vb3VoUUpyZi9oSTV5?=
 =?utf-8?B?Zm10Q09oV2hEd2Z6eUZXd1Nqbll5WUp0ZmcrNzZtcVc4cWRDRy9INm1rZDN1?=
 =?utf-8?B?SWpyOVk2ckhsd1c4VHNzRDhjOWJ4djJmUmZpTFVPVGVGcGlZeWlIeHJDbkp1?=
 =?utf-8?B?VVBJQ2o1SDRsMEhkOVVIUHlGVlZURWZYbWI5WXRGN3N1a2o1aHpLaXN6eDF4?=
 =?utf-8?B?TG1kRDRJcS9SZlYrMDRESFFJU0dmQ0tZWDFIRFl4UHNVWFVmUmlpVHJXSno0?=
 =?utf-8?B?MXNXK1g4REQ4eWlNNnkyYno4aWlkc3hLWTlhNVNCOWJ6NzkxSTllMXJPcEty?=
 =?utf-8?B?d0pPTklWNHVEQjlKVUFubElMU2l5QlVSRE9LRWlRMXl5M1ZlMHJnTjdKcGwr?=
 =?utf-8?B?RndSOVh0OC9qeEVVMmI1N01qUWZaQ1NKQk5mak81VDhhRHJvWExtQjZiMXE3?=
 =?utf-8?B?SnA5UFdxZXhVMVF2Rlc4Y3A0WitZR3ZpQ0txdFR4M1RUczFRR1QwV0Z1bHF1?=
 =?utf-8?B?Q0FDZXZZT3UxQjZIbU9zWitJTEtqRzF5Q1Y3UUxLVDZCRFFYUUlCTU5SMjNw?=
 =?utf-8?B?cDVwUlJtb1B1bGt0azJTSHJScnlCR0crdk84YTBYTHJtaGROUXE4RjNnV0oz?=
 =?utf-8?B?YXVxRmxQZlpCck0rYkpmZ2JreWNzc2FiM0xoYUVYNUM2c1dXbVlSb0xVNU5X?=
 =?utf-8?B?enpkZ0MrTjczUldlelBxaktRcXdnVEwvMVF6Z2F5YTBVOCtFVnQxOFFaN3JZ?=
 =?utf-8?B?YmowWjZ5aWNVQnFpMmxDRGtHV3RFdk85U3VVVVlkNmRoOGI3RTI4b1JRSDlC?=
 =?utf-8?B?eUVnVXpjdGNaMHlrQ2JaeWZjSDVFNEJqMkNpYWR2U2NGR256MU55aVhURUlK?=
 =?utf-8?B?SGJtL09KQ1dIU2MwNVpIVDVpTDF0b2IvSXZ1b2NDbGdJcFBmTllmZUkyQWNa?=
 =?utf-8?B?QkdaTUYxQUdRbmZWRnNIV0lmbHI4V2ZPK0NXTXEwVlgrYnVFV3hqait0T0Uw?=
 =?utf-8?Q?FraVGEbmFww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVlyQ3E4R0xHOElYUVFhZkVtYjlraUVGNWU0cURqdUsxQ2JESmMwam5oNXJQ?=
 =?utf-8?B?TDVUK1NTdXdjT1NXSUgrVEtqWTVJWFdQdkFHc2NpWmY2bHpSeTRsa3UzK3Rh?=
 =?utf-8?B?Z0J0d3J0ZTdab282SG84dWlMclp3MDA3eU1qRkZlcHNGS1pSRGF5S1V5ckRz?=
 =?utf-8?B?QytOVE9BYVJhZmhhL1pGUTZQbjhmZzUxRXVsMXVNYmtRNC9uSXE4Z0N2VjFR?=
 =?utf-8?B?NUhsakhFNXZGTDVlRk1LSnllN1VHUG5rUUdraE51MmNSSWtrSExQK0wzQlhl?=
 =?utf-8?B?TzJURTNYUUdJcTBDWFBBeEdLUU44Q1FpNGM3S0pCdlVUcEVPSmx3Tkh0QVhD?=
 =?utf-8?B?Z1haSlNqSUZsUllpQWtXSFN5cmxZWUNUK2JXSDBqd1d4RWFZcFFCRlFzWHFO?=
 =?utf-8?B?TkRiMjJ6cUtuSmZ5bHRnVEcvQ3ErTDRtZW50ZVNOS0YxNE5RN0tteTRKTzZX?=
 =?utf-8?B?QlRNd29JbUN3eUZrMFNtRUVQcjBFbXBDeHBUcFc0ZDBFd1oyalhUK3VuWFdO?=
 =?utf-8?B?ZEViMHRyK21KVnRDU3RZUzBROFgvcFVEejFPcDJvbHA5N3N2TzltTkR4UDBt?=
 =?utf-8?B?WVg0SmJ5Qm5zSWNPMlRHSFA2MHFiQi9aMVBNa05GSC9OejRKekFXN0lramdt?=
 =?utf-8?B?MG1VRW5xWWRFak5DRkpveTVhdHE5ZU1QMWpnUlFoY1RENmwzNXVob2x4N281?=
 =?utf-8?B?amRiTENrTksycFFvQndpY2hKM2tQa0xlUUpsS1lmZTBtbE5sckhPWTZEb3dl?=
 =?utf-8?B?dk05Z1BpQTZCcHdpZGZZZktaZ1F5aUlmQy9kRFZyOUNkdjhreWFHQzJFS2Vj?=
 =?utf-8?B?TWpaUnk5ZmE0Vmk0U3JqNXJ5d0x6UmZSa3ZGUFlpOUdwcXEzMWJ5MEJzazdX?=
 =?utf-8?B?S2JscXlUV0c2TVpTY3VUeVIrK2VwekUxVWFKajUveTRuUnM1cGt4cGtlWlFz?=
 =?utf-8?B?NVNJanAzUVk1c0c4RWlLbi9TOFpGUzdHYjR4aExXU0gyTHZreGgyVVhKeHQr?=
 =?utf-8?B?WWRNc1hHK0lpK1llVVQ0aDNpT0gvenp4S2V0YWMzM1QrRDBmWG1ZaXpYNlNl?=
 =?utf-8?B?Y2ZFVXdtbURhWFBiTnl6U2trVE9ra0thaXVNWFpwTG1Ma3g4eFd0OXZwQ29l?=
 =?utf-8?B?cVRMa2dXbXdCSVBlWWdMN3BocjA2eHFXbThrOXNJL1c0WWZzTmFFMkNLbFAx?=
 =?utf-8?B?dEFiVXo2Ykc0VDJ0N0tQNWw0djQ3QStKdDBsQlBaVjN5aHhHb3RGeTQvN0M5?=
 =?utf-8?B?UHAwNGsvWnJ3bGNBNk45K1ZzaG5wemp4emd4Y3JjZ3ZWaHBXZlRtT0lCN282?=
 =?utf-8?B?aEFSQXI2RGt2RkpyS2RyaDE4a3VMNUQrdE84QUdKSlpDcFhodFFhTEhKMkRM?=
 =?utf-8?B?VFlZMG9qbnk1TFRNRkJDWnBWMzVYbUViQ1JOTHdmblorbEJwVG1PcHJjUkRY?=
 =?utf-8?B?TUg4bkxQc2d5NWRVUk9vek1URlhBdEJLRlZOSkxZbzM4eFJCdjltRHJoMnlQ?=
 =?utf-8?B?OVYxNEhYTEFFY2tVSWRmMDYxaEI3MVlJYkJHcllJVmVpR2IwTDRUTi9nVHlN?=
 =?utf-8?B?cHFwWmQ5RjBRb1JmVU9tOFMwZEdaR1E3R3VxL09tdnlpdTY2akZrSVlFRmNF?=
 =?utf-8?B?cWFNbTRmQWR0VXUwYXhPdFQ4cDdIR3hyL1pjeTl0L3RTNG1hS0ZUczB2bWY4?=
 =?utf-8?B?eVhsRUd6aDNzVDl0d2NJVjloMGlxTTFZVFg2UkVzN1hLR3VGWW9EVm5kakR2?=
 =?utf-8?B?QVFBdHhFOTMraXZrTGk3d21NbXA1cnlZTEh3Qm02aHdqMUE0VHhLWHNVeEdq?=
 =?utf-8?B?S1RiYm5lWmhyc2tBNUk3R290bituaEc4QTZMLzUzSmhqSSt2d0dSY3VPaTFU?=
 =?utf-8?B?TmVUSFlDRDNJd3ZFWmk2ZnJtZXBLYS9ZMnZwQVZLUkxTWFlJYm9vOUlPZnhY?=
 =?utf-8?B?aGlHYmxjMnhHK0xXSDVNemZYUGNmZUs3WlpNQmdURTdlWElMSjE2a0ZMUUFQ?=
 =?utf-8?B?TlJkYXlsUUtRTE82bnlNaFhFc1pHd1MxQkZhMlNnQjBKbDBHWUQ3MjgvTFg3?=
 =?utf-8?B?eXlBUVVXckQ2TVAvSk1iUkNSa25HZVBPU1dDUkdKRHkrVU8zS1hyWnFSRUoz?=
 =?utf-8?Q?sMlTi/IlGr2eGNhJX3CsXmvtb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17abe46e-2089-4555-cd32-08dd7cdb020f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:37:03.3543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZP4JNGheEi/X/AEZAc54ARet4+op8byX8qTEaxm5UpDdxHfRUKWnY/E1TB4D4Xh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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



On 4/10/25 10:22, Michal Simek wrote:
> Enable FPGA Xilinx interface and driver for loading bistreams.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_versal_net_virt_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 49dc9bb5c4d3..add233d2dbb7 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -76,6 +76,8 @@ CONFIG_DFU_RAM=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_VERSALPL=y
>   CONFIG_ARM_FFA_TRANSPORT=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_VERSALPL=y
>   CONFIG_ZYNQ_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_CADENCE=y


Applied.
M
