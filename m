Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F031CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 07:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB51C8309A;
	Tue, 16 Sep 2025 09:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3HY1NLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B568318E; Tue, 16 Sep 2025 09:43:50 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E4C83071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwYc8mGANrz/PZffivXnYw51jhCoEZF83Xoebrf6p5e43oxyWYB5AcYTMIs30Mg7kQZWi8ifDmZHl1j2WWc8qlfWTikErSA924HAMf0IGK4u8/M9e+FmPg1cCjmsLBX6qdyYH/3Bvi2TgVlESt54utFmGtA49flmJluj+FTMXOt8LHJrGjbMoCiOb7/xaPg7P5umoV8pwaDfVUhV72FU37UQiVNbU7wHvRw95YyqopnOdXyVRq8wmONvNnR++CwxOSdjy5vPmLmsce7p3IHjrtV8b9FjlEHozePvn3H1Mdw9nDjUYxtt75SC/gZnyP5PS0mipcgRY25eZn14pK2TlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz7PiuY7IqtGsSS+agdo8xAFi0IMNJk3M7hkxloxIuw=;
 b=Np0gicAtMtpPwR9OP97wtTc8t16l9o57PX9+tCVDESLYWpo/NCpskW7cFtmmnmUA3LpH1rSj++phKNFwxl3p2L7CxoligCPkEGftSMdDXUWbIBa3xNSMgjVrkzHwk6diFqfvDLYiE1TdjnNGGyWchjc/7XnipREVTLDkLPctnnfdkVYdeMQwGJAseQ0dGmQis5P5uO8EHoRUn7hoiPYqTZVUazrqNiDGs/XXUdJ9EnJXNChH8HWI03hXFcGftnGTBgtzVMgpTJ9v1/HF3XJlNXh2T+qPO/WP4Wq62f996/dbrw/IPzslUQcXPRiBMgPcSMw3GVj1/8FknipfXVegdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz7PiuY7IqtGsSS+agdo8xAFi0IMNJk3M7hkxloxIuw=;
 b=j3HY1NLVkijyvLqS4fw63Phydm8gkrb2Xo7uKtw7Fg2WnlNzCqGW7moARYaJmSEC0fNkAQ0adbUFB6XnsAjYl2YQuX7vzCUV8T9cH9lSwxEihVyPzQWofexBf65aenYKa90SRp5djldeC/qp/ewdKm9/zOZXzIKcNp3PD1pGKFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 07:43:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 07:43:41 +0000
Message-ID: <08c3a9f9-23ff-4350-aca8-11fa58959a92@amd.com>
Date: Tue, 16 Sep 2025 09:43:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] xilinx: Update guid with fwu metadata
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, ilias.apalodimas@linaro.org
References: <20250912100539.4127378-1-padmarao.begari@amd.com>
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
In-Reply-To: <20250912100539.4127378-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: d28add6b-3f5e-4083-7593-08ddf4f4c1db
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXFnWEtXQXlBQkZUbG9veWh5eWFvOVM3MkRuT1lzUXc5L1ZLbldrZkZEKzFD?=
 =?utf-8?B?QitwamI2TkxjOUprMXMyWkltZUNSYjY1bUc0NEFMRzM4K0xPU0RGNW5wWUhB?=
 =?utf-8?B?TlNqNXBDajA0eGI5Y1hBRkhYbTkwVjVYVkVGUzhINlZVMjlWdlJGdndZUlBU?=
 =?utf-8?B?NTF5UTk3dGZEdnJPQi9uaWJSM2VyVGNkbGJ4amJMaXQzN2xKdmJ2Q0tnVEF1?=
 =?utf-8?B?bU1NNDZJYkNVaWhqMWg2RGlXc0pPOXhRNWg1ZVFVL0VPU21FVklpaDhrQ1Fi?=
 =?utf-8?B?Q0hPVXlBTmQzR0RDZVUzNStaWHlPczNWdWJhbDU4dkU4dDh4WGVNWVB5YVZz?=
 =?utf-8?B?c1hXTG0xa0V0MDhBMHAxTXRhSjMvempQNmY5ZXFNK08xUDBFb3JueVhtbHI2?=
 =?utf-8?B?LzhuQ2dhTzNZSHovcVFVbVRwemtaZXI0WEpDUVNJaFUxUm5GT0xkY0UzZUtz?=
 =?utf-8?B?dkxDdndyWEpqYTZMT3JObVBsRjhjWVBwSCsvdndtM0gwYjZ2RlJoWTZCUXFR?=
 =?utf-8?B?aFB0aDVXZ0wwK3NrRktsdjJSV2Y3dFVaeGQ4WFl0YXgrVDVpcmtKaDRSNy80?=
 =?utf-8?B?akhyMG8zellSWlIycUtXN1pYOEFjVHFzUm1WVUUzTkY2a01QUjVnTENXak5r?=
 =?utf-8?B?bFpwTnJBNVpKcWpJQnRrOWZxRmxDNlBiaWEzTkw3aHIvUTB0MWJUejRxd3pZ?=
 =?utf-8?B?T3IraURlYnk1OFR3RHZVRmxkY2MxUzN0OHNnOEhNWDBQcFJrTzV0MmIyeHRQ?=
 =?utf-8?B?N0FyTldqdFdwWHF3UTA1SWptWWsyK2RXcDVLUnpTcWdNMlY2K3o0SGxuZHQv?=
 =?utf-8?B?SVFsR1p0MWZiWTd3WWVLb1l1TGtyWWxlODFidWwxdVVLdlZhemZqQVdhQmhy?=
 =?utf-8?B?bTJqT29Pb2x4ZEtpbXg5aC9ETGVDQnA3b0dWZ1c2WjQ0OExXRXVTbWZMcEE0?=
 =?utf-8?B?UDdrVmdUSUZCbE16QWRkUFc4NmE4a1p3c0xRbVVXUVpkbWdBK29CNXRuZDlo?=
 =?utf-8?B?SFBMNHR0SERFUksydUdqNjE1N3gwcGlEbmovR0hwRjgwMGlQWFB4SXU1bVVL?=
 =?utf-8?B?ckNSaUxWbXV0NEZnQ3drR21xMS9BeW40dVlWVUZwaGsyaFljRDFYUUhrQllx?=
 =?utf-8?B?VTg5Z1RPdEdTcUcrT3grbDZndjRnb2lOU1hrcjQzLzVZSWpUQ0NDT1RKeEEy?=
 =?utf-8?B?L1RDekJHTDlTRlc4d0hNZFIwaHRzTTduUHk5NzRPNWUrZjVScHE1M3k2ZG1J?=
 =?utf-8?B?YVVpR1VjNjgyMDF3UHRpeC9CZlFqMUUzTnk5VWRqNjA0Sks4VFBHdVBjdE5L?=
 =?utf-8?B?WHlWM1hQVjFNbzdOdzNyT1lkdW1UK3pZQXlxV3ZQbU1WQlZnbzFwNVBOUUVv?=
 =?utf-8?B?d0Y1ZzVJK1c0eGVISXAyNHBNa0tqOU4rTnVGYVpoVTNrbkVPZWl4eXQrN055?=
 =?utf-8?B?K0RpRWNPK2d6dTNFajJFK0pLOWxNb2d4UWdnbURieEgzZmtHOXljMVVEQk1q?=
 =?utf-8?B?NUpuNDAwREEvU09tVmRxVjl0Um40aHZNeGZTWXp3dk16ZUoraUZhWXUyaUtT?=
 =?utf-8?B?R2oyaGJNeWg3UWdUSGVSWEpaUkduOWdCNEF4N0tpdzhLME1KdGhTNFBDRG5m?=
 =?utf-8?B?WnBYaERPUE43c3Z6U1FhcWt4N3Y1R3oxbEJkYU8xTXNzMXRFK1R5cTNYL2VS?=
 =?utf-8?B?Y3lZY3VBdHFSMVVmeWg0NzVIWXZyeEJXclQ3Tkk0bFlCa0M2ZTRSMXRaeUNm?=
 =?utf-8?B?SFdnM0J5Q3VGM3pRTjNLTVJOUDVXZG5TdWxha3BONEZ3TDAwK3RqWU9QVE9L?=
 =?utf-8?B?aitLOWhNSWlnUDFVejd3Y0JEUWYvRjc0bHUwTENwc2VCRnhWbTk4YVBhcmpm?=
 =?utf-8?B?dWxwWWIwSzIxcmZSekV1bVJ1TWlIc0k3ak9YVTNadnB2TWNNY0dtNzUrTkwy?=
 =?utf-8?Q?Cp9mQUFZ56I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFKVlkyS2RBSXJIMSt3d2R3WE44aWliZXBjRzJ2RjNKNHUvb0FEZ1B1WEtO?=
 =?utf-8?B?RDVqR3lQMllDblZUamt0QTVvc2pUaU9mSlV2TldrZVhiME8rUm1OMldHeUxE?=
 =?utf-8?B?dno3eHNYZkZ5SnNCbTBhTnU2cVU3K0RNWFY5Z1UzbHY1TWdFci9maHFLYmZs?=
 =?utf-8?B?Qm54V2hHN1F3TGJidlNWN3N5Qm0ySXR3SzF5UjFoU29CVEtOaUNPcDdvc3lu?=
 =?utf-8?B?SVkxZi9UOUpZS3ZkR081dHpPVGhhaE55WmxPSk9FSGRMSjkwOFR6cm1oaU82?=
 =?utf-8?B?VUU2YUF5NDhxUHJReFgwQjIyVWxIL0dCNTZVUXdJa3Zlb0xJTXBRdnJjRU84?=
 =?utf-8?B?d3c5WWhRQUJaRVEzaEZwVGVmbzFrcmJSaVBvN1dsaHVzb0piemxvWGlHQzBz?=
 =?utf-8?B?Yk81VnY1ckNHTmYzMXh3L1BLejlZY3hDMVc5cjFFRHFSVkhaV1U5SFhtNzhJ?=
 =?utf-8?B?QnUwbER1RTVpc2xvWk1sNHhBUGhiM3daRWx0WEZaNVNMLzYzNzE4U2FnTkRJ?=
 =?utf-8?B?N2NlbW1jQnJ5bERiM0pqNTdsV1pWQTJOdnNqQ3lYeW0yaW0yc0drOVI0c0xn?=
 =?utf-8?B?Q0pUWFpKZzkyMWhKR205SjY1Y0F3b1VzbUVWc3pDNm93ZXVOUHgwcEF3REdl?=
 =?utf-8?B?d0VBR0ZiemhIMnNtRHZ2UStveFpPVFp5di9GeFVYUmtMeGxKTC9wdXplazRx?=
 =?utf-8?B?dHUyTkVwL1F4NFRsRVZHSU5aajkvRUE1aEk4QUZJTEdKTURIWEtQK3QxWnV6?=
 =?utf-8?B?UW81UnY2YU84KzRXeUdLaHlvYlVFb05xTUpKQlNIWDQ1V0J6WlBzVzhnYldM?=
 =?utf-8?B?dXQvS2M3aEVydmpwaVI3TmJZOHo1YVFKekZBNFdNeCtNK0Rqc2twakYrQWRP?=
 =?utf-8?B?WDZhQUhXN2s1ZE5UMktTRVFKcmt6c09kendoZjQzRVVVZDN1RlN4aXVIendJ?=
 =?utf-8?B?ZDdHNE0veTRob3B4ZmF1SWpndEhabmJIbE1oZmVkTmxWT1pzMFRuZGcwQlln?=
 =?utf-8?B?OFRqeU1Fd0lkUlZSVFd5c0ZUWjNob1FaSTM0a0RUa1NpRmFQUFRvTzY3bGpk?=
 =?utf-8?B?cXhzanh0ZVVvMzRjeitLSzRPWGloMUVxY0w5KzZtd2crU1lXdlZYU1NpL2dZ?=
 =?utf-8?B?NDM2VW5QTFMyalo5VFc4SlNvRWhBZDUwNlJIUEZrbko2Q3kzL1UrSWJaZUxi?=
 =?utf-8?B?bGtLZVhrNFNxbEU1dW9lekR6ZWE4ZmtaZitXZ2xzbnliYWwvaXlhRGw2Mnll?=
 =?utf-8?B?ZGcvNUlkbzMrMUc3eHZYWlJFNFprVTBPdVM1TzdCc2REZVZqZUZobDNnV2l0?=
 =?utf-8?B?eFlpcWZEM1BkOExzSWJiZjVJOUVXbk4rOGRaMG1Ya1M4ZTNQYXV6V2tjL2Yz?=
 =?utf-8?B?cnBZaHRhVXFzdENXdG9mT1dGdWIrcFJrTkJBV1NCZWNucjNuZUJTcW1PUGx2?=
 =?utf-8?B?d3lYR2c2cDZleXdsL0F0Si9HcCtUMzNMMlFkNU13UVZhK1RBRTlmZCsxZ0lH?=
 =?utf-8?B?ZGhHVEtaUWpoZEdFSG9UYndKeURpNTErRllzbkd2M0lHWE9NeC8vUm9kM2F0?=
 =?utf-8?B?NTN5eTI4dXZpNnFzVktndTFieGNkb0NJY1BQeU8vbTVSTkhkVElldDJCdm03?=
 =?utf-8?B?YTR4RlY0b3dhNG5FSDdyTnlOZjZ6cFoxN2ZCaEZPVXZTdG9sV3k5Wk5WeWV3?=
 =?utf-8?B?OTBPQytyU01KS1VVenZIZk85RitVM2E1VHVCdTZUTlJSMVJzWE4wTFhteTBn?=
 =?utf-8?B?d0RVZUJKaU1abEdraFZsSHNGMHFJUU1adDJTZFE1cGZIMTVhRncxdml2MmxH?=
 =?utf-8?B?ZjRqelJja3RLZk95NytMNG5iYWxNMUhJbmJ2bzArNVRrK092VC9HdG5Qa2Vr?=
 =?utf-8?B?cVprUVd6MDlBZ05HWWpQbllFNjQ4UG51RXl0UHhaYzAreTdadWRPYmozM2R2?=
 =?utf-8?B?dVNoVzJURmhCMTlXZHVEbnJPR1lCeVZuVGE3bUtLOXJXcGEyRzFwVFY3dmc2?=
 =?utf-8?B?czd6OWFNcEFSWERQbDBnSWJqR054dkJuK1V2dnhmZnBtRDFlNHp5RFdtWmNW?=
 =?utf-8?B?NFRCZWw4QzNHaEJ5VEFHZUI5U3A2M0lFbnpLNkNkRGFyUndXS1JEZEk4S2U1?=
 =?utf-8?Q?YeOCdIXXDIzR2+dqMDQ4ndudc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28add6b-3f5e-4083-7593-08ddf4f4c1db
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 07:43:41.9315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUDGVmR0m6OJTrCy69G96N1J6XDEHmkwP1ftw8AhybPuMdmWz3W7NrFfChRgUI2P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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



On 9/12/25 12:05, Padmarao Begari wrote:
> Introducing the fwu platform hook function from fwu
> initialization to process fwu metadata information with
> platform specific operation, and use image uuid(GUID)
> from fwu metadata structure for fwu multi bank update.
> 
> Change in v4:
> -Include fwu.h in board.c
> -Rename fwu_mtd_platform_hook() to fwu_platform_hook()
> 
> Change in v3:
> -Update Note in function
> -Update function description
> -Remove ENOSYS
> 
> Change in v2:
> -Update commit message for FWU mdata
> -Remove platform_hook() from driver, add weak and actual platform hook function
> 
> Padmarao Begari (2):
>    FWU: Add platform hook support for fwu metata
>    board: xilinx: update guid based on metadata
> 
>   board/xilinx/common/board.c | 27 +++++++++++++++++++++++++++
>   include/fwu.h               | 11 +++++++++++
>   lib/fwu_updates/fwu.c       | 18 ++++++++++++++++++
>   3 files changed, 56 insertions(+)
> 

Applied.
M
