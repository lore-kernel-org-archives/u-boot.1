Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7430CD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 10:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D94D84119;
	Mon, 18 May 2026 12:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tauhN84N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6092F845E3; Mon, 18 May 2026 12:35:06 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A9183EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 12:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cgeq1hWwo4ZSCqKqXnsaj1qftZZ5XqVhXZ22CwzuH1IMmP/3WwUm+N3a9mtXDSKRBohXO7gnz5KWuKMtbQlZZbnUeYVMxSWMYM2eIYVUhe9un+POwP2QI+A84NTTXLzcVykxYEuZkGSp8ZYYgRQPxkd5cEeX+2lXj5mYJQ5GbXzUIjq8eVOQNjFWoJA6G3f9JJ0MIEr9jaBJ0WeCgoTqAsXcaaiILV0RNLF8ds4/gnuK6g2uqxaQ+PR3F20e9H8+zkHmcFhL8c+FEYNwIrIri51HCDxJDTIwXSTk4K1poRskM2V1Vris8OK0AKNrxT7vHMRChHYNTLqoBXf+J9MQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YydBdqMTH5eAHZcOvrOnnfKvNZ7R6CccaBGoqd2c2RQ=;
 b=df2gIWfqqVhe5q5UaimY6G//xdrTc8Rvl1mK+N4VqDLsFCLqYMaMDkmT+5LF4YtYxko9zQn95Cs3Z8EhT+FrWi3b4/V/rT7sfTbY19ko8lm41a+3hNj0OZcMbHwbS4cKCBlYXcwClFM7NSMWwAU48PmKac5OnNE7JYCAU38TBEVrGxXwZwSF8U4pUCm/gaHibNiy3X3umWlGfCSs+WJ9AeTgW3KL4UAzyV0I7lfReTvHVEwHgGo4JoFmuv0UmDgpgwaC8Iu1jmzhxRZOBHumkuiJmInYpCc505eZ4/38f2LUeTiai7ZhOMsbnANFFRLjyFZ5VHslbmTKRV+62JMp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YydBdqMTH5eAHZcOvrOnnfKvNZ7R6CccaBGoqd2c2RQ=;
 b=tauhN84Nzxp71H+GSmAFYF/qs4TGsg0JCQS+op4pIfnr4xm2CLAhFWZVjBKMr51pYrNMU1d6X5qRQiw0QUd2SbbgdWOPKP2YYB68tsoqt8P50C9BdiCp7PqgbtcFGZoHCEUpcfQ6cyZpxwCDmQvFzCWlajmUPDUbu9lI9BifXg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Mon, 18 May
 2026 10:34:52 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 10:34:52 +0000
Message-ID: <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
Date: Mon, 18 May 2026 12:34:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1778665323.git.michal.simek@amd.com>
 <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
 <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
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
In-Reply-To: <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 421c697f-1407-4510-704c-08deb4c91868
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|4143699003|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Xx207ik3neg/lMfDJ5Zdt3Qx/TNwBwjE+bfAKhIxuqGc6lNY6hJ4W+8n+tKg0vBtccgHeQpbzdOoBrhO4GEB3iVAJkb9fGnx2B6JYsShQJ9WXTQopicPh8jG4x0xTq5WwUHbKucpbaboeLc/RNHE1CF66CLyp2yGRzAMj6vW1+agk0UGFzleRarQQIYGXoMunpWsdl6YeC7wz6ZLxREYiYGmSk9mQnvkZzZjGUY6uluHxiVyj4Lx2d5bYICOuga3OEyUrZzfQr0BcZW/l1SM2MhUcc7s1GYAC5FXrrYmGXp52YNGiAtuYf5tvWQ/mTJYT8yWzqqhh6uV7rk3YNw9ox/AiCjcU6j8s2xht8fECAVSSEZ5Fq5374WMTD3duvIsFz1rVNNjWbBaX8okYHXZrza3DXONT9WSmkAWk4NOXeSeDPzWQVpsiyBsssQjZSPOCPDliXfk3vzvGrZtijdfADB8oRwFmnsrC0t55XwhB21u4ppo91Catq7VpAw4kJb7D04+Dk2sL/r0ixBwPt9zVyxDrjIJqsJsVUtzKJrZductjIbkQXak1UcXueoqVATBIZA/8Qa3CUUAw/k8ZcNYdapr4dfpHWIYnpO07XFUX2h/ocQJ2N38uM2uawd1+EVbpEEiiVIrHid/qNuFFlAnHlJLx6lcG4oZEPjIf3R3bVH1RjvGsBbgwQUOkqOYbMKB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01FUWZmNnZWSjZaWTZEMytGSmVuUWpHWHhVYXhLMkRkTnQ3OU9KL25PdGRn?=
 =?utf-8?B?bkFMRUhlT3BTRjJtd0pBV3FrNms1dEQyUVVybFBjdEdmR2JHcSthSlYybSsw?=
 =?utf-8?B?alRpUzYxYTlNM09NMGFWeVN0U3hLWlI4Y1Q4TzFFZC9PSGQ3Z1FiUklQOGhm?=
 =?utf-8?B?RmhNb3hSTjY0UDFIdGJRSTFzQ3c0dnJKYnpLbm03aUNURWk2bytlMGp0c2l6?=
 =?utf-8?B?TUtNckJhOUdTM3ZTbjhaMXhjZXVvblZHRldiSFMwRzMzSTNQa3RjOHZwSml2?=
 =?utf-8?B?L2xRa0Z6RHRubVFYQlNKVE1UV2RiK3Y2c3JtZWNQNlkxVzJFRlhPcWRMWVl6?=
 =?utf-8?B?UnZOQXFGK0MvRWFQUFBScFdtYzZ3VjJQOWhIVWtGLzEzUEduZmVseXFBaWU3?=
 =?utf-8?B?SjM2dE9NNEdBNHRYMFhFa3l1Tm9NV0xsd0dFenVEOVFZVEJpNnVjcE5YbTdK?=
 =?utf-8?B?SVBEQys2TEp4TVAxTnliNlQ5b2V0bVBqRHJWNStoc3VMSzErS00vcG9wMUhZ?=
 =?utf-8?B?U3d2T0ZRbUIzYmxKTm5ObC9mdnhHdHg2dXRMREtlZExENjRQcm9GNlpocVJv?=
 =?utf-8?B?Rkl6K2F0THJUUmZHTGIxaG1LZ2NMN1pJUEJvaHhLYWgyTU1BUW5oQzhEelVq?=
 =?utf-8?B?anlYM1FwdzhWYyt6Z3orT1Fjai9NNFhJM3ZIRVRhTk10aml2R1MzRSszdWN2?=
 =?utf-8?B?U1VTUXBzWU1POW5tWDNFVFZKeS8vYzkwWEVIVmo2ZklVTWlwY0psWlF4MnIw?=
 =?utf-8?B?a04xNUxGTW1CZE5tQTQzRi9XV1JWcTc5OUNNbXNBalN3M1EzMnZPb3ZoaHVY?=
 =?utf-8?B?OGdrTDZraHZZYUUrOWJudURRNjR3WGxNQXliOC9YT0RKYkw3Z2NxMnJvazNx?=
 =?utf-8?B?L200Myt0RFhHUkJuS3QvcXV2MkxHYTVTWDY5QnNMbHBwaFdVakU1NWlobEZq?=
 =?utf-8?B?V3Y3TUFCM3JwakRVay9IVy9Sb3RHSC9JczBpOUs1MjBMbUZmWTlRbkYzdmRS?=
 =?utf-8?B?blVoc0pFNzZrK1R5bmkzbHVCUHVDZ0tCbWluZWFZNFJFdjB5TTNmOTFUNzN0?=
 =?utf-8?B?bkNwampxTjZLRjFld2NjcWRrdW4yeU9PTTdhMmZXMVBaTlhFYXJXdG12MHAv?=
 =?utf-8?B?ZklhVnVmQm0vOW14blJxa3dUZ1c0KzN5RjkvY0lOSjN3UXR2RDVZRjBqY2VX?=
 =?utf-8?B?L2lCTHByUGVUVWZEWXQ4S2U2eWlja0YvQUM2UGlMTGtPYW1yU1BkNjBSS2Iv?=
 =?utf-8?B?V2wzV0h4TXZkYnRqL2pDandBS1ZlcWdML2JNNEhVaE1PVGR4eHNHSkZCdko1?=
 =?utf-8?B?cm1XMHIyUlRONkhnRGFmSkVNc3N2dVQwMDRYTmJ1M1RXdXl0aUNyQytiL3oz?=
 =?utf-8?B?eXJXWnA1eUoraUlFUFExZERNL3N4WDhzL2F5VUduTFVQKzhkZUtnYW02THdr?=
 =?utf-8?B?SHp1R0t6R093NU5VeVZnSklFanYxbzV6VVNCcFc5N3BramIzN3VUL09VYVI2?=
 =?utf-8?B?Yko0WkFIckZHR2NKZk5pN0dEOGVYM21ldzdnOXhnN1FQdVozcU1Wb3BpNmlq?=
 =?utf-8?B?S2krRVZGMC9wbzllSDRHZWhFYVVXSitwUUJJVGF4STBpM0xUdXEzTUlqaEVQ?=
 =?utf-8?B?ZllxcGppVEZINmxZSWdjV0x4dWQvTEV4U2pwOFM0eW94UHZhRFc4eVZWeG5x?=
 =?utf-8?B?R0IxTmR6WmplU2kwOXU0VHdHUEUwdzMyVk9iejcxTFR3RWkzMDgrRHZzeTlo?=
 =?utf-8?B?QUFTZXBNWGYxZUg4bTlsMXZ0cWZkZWlRdE9odys1aG9BU1lMNzRvK2dVK2dr?=
 =?utf-8?B?R0IyR0lUc1h1a2RaRDk1eFFabVBBQ1VzVWFKWmQreFF5RCtvYVFmMDAzZ1Na?=
 =?utf-8?B?eGlsTFFlVkhrbi8yN09qTURBRVJNTUN3ZkdpZzZkKzB3L09SQ09OQVJEalkx?=
 =?utf-8?B?TnBaTnB2YnNIR3BGMWgxNjFBTkhDckluaFRVbjBjblliaTFqYU94VHNETVhN?=
 =?utf-8?B?eE5reVlRZjJzZ1pSV3R2SXdjMWVTZjlMd0luU0sweFVtTGxhT1RmMXZkc3J0?=
 =?utf-8?B?SGVyb1ZjT09qeitXVGNXUjhWR1lZOHhVdjhPZlVDS3d4ZkN5UWZFWDVDQ3kv?=
 =?utf-8?B?YklxNG44TXNOWU45NUJHZ2REYWppejRkSWc0TzFCWll4Sy91eXE4amMvWE1G?=
 =?utf-8?B?NXh2S3pmRWNnbnFoNWxzSFRTaGdOR3V2T1I4c3JrenVZMkNEOWxJRnNQZ3hn?=
 =?utf-8?B?dE5sVkZaNlh4RVowVWcwM3VrYmttYlczK3A1ME00NGtWZzE5V2VHNjhOdjdy?=
 =?utf-8?B?aDQzakpjbGphaDRZM3c2Rm9BeXpHNzJ3eHludUFIbTUySjk1LzN4Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421c697f-1407-4510-704c-08deb4c91868
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:34:52.5877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzQE7jC8GucV8ugVEnG6SMy6b33DYqNGR6ieYC7TnG88VpTxzIVImdSSYVKmYAUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

Hi Maarten,

On 5/18/26 12:21, Maarten Brock wrote:
> Hello Michal,
> 
> Although properly commented, I find the reset_reset_bulk() implementation
> counterintuitive. Are we so certain that the Linux implementation is the right
> and obvious one? I personally would prefer to have it assert all resets at the
> same time. It is faster and prevents races if the resets are interdependent.

Why do you think that it is faster?

I expect you would like to do it like this right?

int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
{
	int ret;

	ret = reset_assert_bulk(bulk);
	if (ret) {
		dev_err(bus, "Failed to assert reset: %d\n", ret);
		return ret;
	}

	udelay(delay_us);

	/* Deassert all OSPI reset lines */
	ret = reset_deassert_bulk(bulk);
	if (ret) {
		dev_err(bus, "Failed to deassert reset: %d\n", ret);
		return ret;
	}

	return 0;
}

Thanks,
Michal
