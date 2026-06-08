Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1026FCD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9779E8405A;
	Mon,  8 Jun 2026 10:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bpfm9Osv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3018466E; Mon,  8 Jun 2026 10:44:47 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E2F83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBozWqTeVagKeGXNHAGiDnM7RiAAxfphbTD/PuFfNfjeRX3uKXyn78jFY7HE0JSQ/f0pvs7Zzj8ufx9NbbchI3G4u5JlFJOrkcSgyP1/Q1l1JtjaqzyIA6/xhCjs0qErmWQKLe1RUZsvBgbuKfWyy74JoDX2jsySFoNHjPUu5DASNfxjfBY6CLzGU3VpFwwrrQQdNfqeBSQXau/e8Y/KbxHYYT8SXpFZlhBPOtL041OZcx8gv60mo5jssdrVwePcqLvERPygtXg2HAF0wtc7DElrr5cvJI4YEP4J8A6oqJy9C6sSHE7jMsqt9ENGwH2ha29qPJhcevK2M3xn/aVjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tAh3pRSZ1OT+aegTFCk3sCPBLJZHsLNDBpXeLRZ2jA=;
 b=KsrDSqobUMDF4dzMkUa+JlxdLixV3XRNX1I6b7E1Yzs0OLIxCNYlsdYpuVRNq6X2z2Tv/d3zc4DNkAD7pz0og/nEO71FiwV8WRqam2HV19gepuF7M8AxAIlyYdevrIQ3qt/0U8HkWWWld0+eRCq7XE9472+w2ApRLdHPZgzmMz1fsI+l+ZUABnVXZh3YKY5FpTbWx+Fi441rmI+gjDGsUFUW3HyTPO+OeWt/+23BNzXCQifsVqL2xLusYx6Abkxm+MFnnbbVM+n0QRQfEuK0OUgAVfUN+Wa96AIOcP7H2pVNefP+gz7mGF8cgcTdoZjt0lz3oTxLMHPNFyXQcbBGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tAh3pRSZ1OT+aegTFCk3sCPBLJZHsLNDBpXeLRZ2jA=;
 b=Bpfm9Osvu6n4UXnyO9CmAg9VHCJX3q1fq27jr+Of6kLadcKp1ElYKjaITywB55fzEyhorIKmlhXg8JC6eV6b3PQtiUOeqWnOowX6JP6hJcI7+UhA1anJoaG8WEV0m/MpfNA4lQaSH0vnEwZ+Nn6GtbyZQkr5hq7UyCMC0H2hxaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 08:44:40 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:44:40 +0000
Message-ID: <b33b9e8f-177d-44bc-a23f-a38fa08c19bf@amd.com>
Date: Mon, 8 Jun 2026 10:44:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Skip riscv_cpu_setup() when CPU driver is
 disabled
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
References: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
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
In-Reply-To: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0141.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::29) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 961b4ab8-9580-41e5-4b85-08dec53a2dff
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p2xvaCcv6wmc8dAwb4bPt6QagOQ67Y5wWIGyeeCOB+gzDJ3gbZFisJjbZnBOGbCVmY6Zy7idBAVjrp0/IodqCfalNdscTRSCDRygMm5TRmi2HlPtm1w8ZPTjTLOzMXVnZyaagSlCBqqbzOnXvt9h51qk+qBhALQCZMkZxJ5kXUEW/I1XZn0ZnrJwMtzqHqZS4QyJLeoV3tgUFyhtE2IRM91CumV7mbwjWesbIGYZExZ0au1g415FSsl8U+LyYu9pWhEOFT9IzBVr7XrKtNziohYo+ieewX0qVNeMdAUUfgjlzSS/bjt3uQJXSoquZXIyPWDh/zO61K47gJ9es+m1/zDfPWhrl1/JFqsD0EDKEI69bTfmiDggCFLRcCwkSmozgDOqQxeec2xdXTh0m91J25u78aY2cO8PmyNszVk4+yV0cHECV9scte1whNUoH3FhfVB5Bjyw/eOPOIH7xM/Dpksex8YQXGGmsjKfa2nf54z9PYdJLVJn240jtHZ/eZJ4FV1pzu+0jImCpCWID36U2Nu/a+dGcfQ1sA099w7E0i16dim3oOCxuGNb66xRNusgo0TmEv3LdeldSuV+4/P6OtEWAdMAJMV3Y4qz41G6dMkDYaZ1oivI26MlnBB095mfXmM19skQlvY2R29rBJoVtXCy6VqX0a4iGNCF/Ys3ezD0ETpTx/2HLjvyIzaqwL0i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmVGUE5VS3ZLVzVpbWJzK2MySW9wS2Q1L0UySEMxTW5mNTZ3dzE4MHdOYUJC?=
 =?utf-8?B?UlJQR3F2R08vbWJWZUlWK1lsTmFadTBBMnh2TzZnVkxYWXBDRm9BcDJZb01O?=
 =?utf-8?B?U0E4SHViTjVVVEdVUFU5b25GeHNXVVk1QmVNeHRRL3dwS3lyQ1lIK1AvVU9W?=
 =?utf-8?B?NWpldmtNSkNwYUVCN1NPUEF4dTZ2WU11K2Fta1c3bTdmVFMxSVg2RWQxNjZE?=
 =?utf-8?B?YU9nTUNsd1J6M00ybnREZlpPODB2ZkJIb3Q5eml4bEdOL1A5WVJHTjRjQWZX?=
 =?utf-8?B?b0hmWUVEOGp2eXhDU1prTUVoNXhmaS9lZFZDMjh6aGZManJ0dCs1a2NzS1V3?=
 =?utf-8?B?OHZxTjRMbkppbWJWcTc2ZlVBN1RKZ0pPQUh4ZTdwVE1DeVZDK2RRYytEeG5q?=
 =?utf-8?B?bERESmtSd0FzenBacGs2UWdpK0QvS0NFVUdqem9sNWFwVm5hUFdFdzdyTEF2?=
 =?utf-8?B?QXBXK2JqWk4wR2p1Q3Y0NHE4OG5NNHRPK1pXRlVoek9vOTA1dkJUOE1HaFRv?=
 =?utf-8?B?OXpnWVJuWDJwYWY2RllQQ1R4VWJmb2pvS0diV3FLOFAyaHZaZ1pJTGdpcld6?=
 =?utf-8?B?N2RZU3VLcHJnc242a1JrSis2VTBKZXB2WTQwL05HYVpaZ1BjZjRqS3hLQWds?=
 =?utf-8?B?Njd6WU5JMzVvTUxsSmt1V0xWdDlXZWNUcGRDZWRhQmJQQWlGa0lyaml6WnVJ?=
 =?utf-8?B?anZpWkNTeGtEZzJzRDEwamFhYUNta0ZYNnJMZ3VrZGlMeGpzR0NIaEowQ09Q?=
 =?utf-8?B?QUo1T1ZFakNtQXlCbHZsc3BsVm84ZGRiUFlsTEhheWRQQWtTRHN5WWNGRytp?=
 =?utf-8?B?aFZiUUxjcVRITW05VEVBd2ZhcGcwOXlkNGxkV2MvQ2JBU3VqY0NmbW1LTVBD?=
 =?utf-8?B?ejBBekFiR21pZDN6Z0g5NXBrM1ZrRDdWU25HaS8rWmFQdVA2amlVR0tOSTFM?=
 =?utf-8?B?dHhmeUs5T0FWQVRRcnlUN2Y2WjJmVWtGazgrTnZ6UWt0UWxlaUdTTE96M0sw?=
 =?utf-8?B?dWtRZTlGNkFHZ2tib2E2SjNxbnFGVHh1V1FENkJ5M240akNjbFZ3bVIxVDR6?=
 =?utf-8?B?SkJoR0txVHhDbVRubFJtNlNvWUs1STdRWTNVSTZYRUV4VDlQMEJhaE44RFpa?=
 =?utf-8?B?K1ZLajJjVlMzNTczNmdsQ2RCdHptSXRLRWxpVythckY2TDVkM0VORGRxbDN1?=
 =?utf-8?B?TUJqRlVmOExSZ1FOYTBSbXdtU2NDeWhVT1ZyaDVOSThmdkcvNTZWTFNKUklS?=
 =?utf-8?B?dC9FUnhQR0NzVlhiSmRaK2NxZFZyQTRkOGJWLzNHNTRCQmcrWFFLcjN5akxJ?=
 =?utf-8?B?QVhqTVhicTFET295ZW5hZUp4a1N0ZW5lUzRxNm80ZWg2TnlQVUpGRDlwdG1n?=
 =?utf-8?B?MXVJYU1QUDlhOGhYQS9RMGErSHF3QjkxamlzL2xlZEdGYzZUVDByblRHT0w2?=
 =?utf-8?B?R0l6c09uVEtRY2hvSm9rWHhWS1gwcjlUVjgvYm56NXNoancrVTFRQWU1ZEZm?=
 =?utf-8?B?MW9LYWdvWms3NFJtMWhxRWdpZDdEV2NNdEdwV1VZb2NIVmVlbmJXbUZSTi9l?=
 =?utf-8?B?czBWK2FxYVR2R0I4TENlelBZK0daWjdJZElDZkxwZncva0pDVFMrK0RmSFJp?=
 =?utf-8?B?RVdNT3pJd1dYMGgxS3N2ZHhUdkxNRzcrenZZbXBGRGs2SGhZTEF2ZzZ0RUs4?=
 =?utf-8?B?MEJ2aU9ORHc5SXJPd0p4RUxsS1I4M3JleXpqTk05RGJSSHJSRmVTZDlPT3NL?=
 =?utf-8?B?ZEp3Mko1R2JoblhDMTlsOVhIMmg3bEFBSzcycGRGUDJvVXJBczB2dGRvOEda?=
 =?utf-8?B?dXJUN2tYSGhGZDNUdjBpb0QzS0ZnNU5iTVloTGY4STFBOTMrSE5IQXVqMWd0?=
 =?utf-8?B?L2w4TDhQTncyMi9kWjRUUExpQlJ2VlBRMFVNQUhQZkRzei9wMmtmUEJ2Q1JK?=
 =?utf-8?B?QitiZWxvTHBWdFZxU3RLTkd1UDJjbk9SaWN3UFZ2aG5qTDJwYzJQRjJxNXpy?=
 =?utf-8?B?SDc5a3ByTXhvZ0I2cXZ1N0t2VHg4RzFBUWxjdXZTYm43elZ2OXViTHk3azJS?=
 =?utf-8?B?Mm10Wm8zVkpjUUlLTytWcU11YTVmTWQ2ZHVyYjkwZ21HU2VzVnVqcDMvY1BV?=
 =?utf-8?B?eFVkeVdXVVFOTmxHZ2JLNy9kakI0TExiK1FyWlZLZWlaanM0ODVFWURqTkdK?=
 =?utf-8?B?Rm5ycW5mK0pGZHdqRW5SZmZDSVhKRS80ZXdmOHZMMytlRk9lT3hoMll1WXZN?=
 =?utf-8?B?K0Faa2M4SWttYnVvalZPNGNaSlkzMFMzOFVyenNLK0JuZ0FIbXFuL3Mrd1U1?=
 =?utf-8?B?aE1qY0REcWhYNU5OMDU4K05oRjJXUENvalByZ0UxcDhTKzVXRDludz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961b4ab8-9580-41e5-4b85-08dec53a2dff
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:44:40.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V924JVqQHErqil8BiGXvlS92fJtR1vtAW9HxJix7S1/bZHaRBCMtj9/lKEECZ+5b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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

Hi Rick, cc: Tom,

On 5/11/26 10:31, Michal Simek wrote:
> Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
> instead of plain ifdef"), add an early return in riscv_cpu_setup() when
> CONFIG_CPU is not enabled. This allows platforms to save code space in
> SPL by disabling CONFIG_SPL_CPU.
> 
> Without this patch, building U-Boot with CONFIG_CPU=n and CONFIG_EVENT=y
> is broken: riscv_cpu_setup() is registered as an EVT_DM_POST_INIT_F event
> spy, and when the CPU uclass is unavailable uclass_find_first_device()
> returns no device, so the function returns -ENODEV. That in turn makes
> event_notify_null() in dm_init_and_scan() fail and triggers a boot hang
> ("initcall initf_dm() failed"). Returning 0 early avoids that failure.
> 
> The compiler's dead-code elimination combined with --gc-sections
> removes the unreachable code and all associated static data,
> achieving significant size reduction without preprocessor guards:
> 
>    spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
>    spl/u-boot-spl:text -1460
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> ---
> 
> Changes in v2:
> - extend commit message
> 
>   arch/riscv/cpu/cpu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index bbadd0c9a469..3bec7c7cb6d0 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
>   	const char *isa, **exts;
>   	struct udevice *dev;
>   
> +	if (!CONFIG_IS_ENABLED(CPU))
> +		return 0;
> +
>   	uclass_find_first_device(UCLASS_CPU, &dev);
>   	if (!dev) {
>   		debug("unable to find the RISC-V cpu device\n");

Rick: Can you apply this patch?

Thanks,
Michal
