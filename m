Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AF3C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E08E480F24;
	Wed, 22 Jul 2026 12:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GrEE0plh9mOb; Wed, 22 Jul 2026 12:38:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DF1380F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784723914;
	bh=apt6Ouo7xW0zIruUu1Bygf52QmrWgDcgLIU840Udoms=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=n0zP1fTT45VcPPRo1sUznxHDjZdO5BOrZJPI6zi7AWcXtKgEUfRiD1QAC8dbl5xdn
	 H2cpJDRohNLW9EBeJyAVkG8DQTYQgHOpJwnG6MdPbO3v6GcCRlvvb4DwVPDlhoaObk
	 QqNVG9SGD/e8N7CbWZc8WEFg5mWCLkcWN5Xydiqk1+8g2Yp56JnhWK+FLb7hCT5GoQ
	 drPYRYhHR3LWnBXpuepQukOMUMBOxlw++7mj4GZRvbZf7Fldo2FFw3dVE7L4nzKJOE
	 qqtYie3P6soqrEoJau8urBvXCPLjzUmfG2TSaksQNGqvl3lz2DzE6JpkZISTIVu8uS
	 Mwq5ZFa+oFXqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DF1380F05;
	Wed, 22 Jul 2026 12:38:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96E93224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88D066071B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:38:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABVS9zG6Q6qZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:38:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C886960626
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C886960626
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C886960626
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6jV5P17fTAnh3akoI16wYzAaEwBHU4zM+CH56YBGThVfouzlJNsbGebekopf5+IJO2I/monuhK1HuTq6tAItHy2zdTdJksQjDbOECGk5Gm2uM1JK2rqhdtQP89YntWAx3BtqfZDBm/GAG006PAWFqmfBp+WkSBgulqA29vBl/nAUQKAEsd31GX51HK79dLc06xo5OTUcvJbFVQY5rXoNrcs4PpyyzYApN9oJMGdDuimF7WTqG257Z+Kr/Ob6A4ONex1SQGKlU4W6VhPTvpkcmvQTASSgcUd6xKaG1nSXAVouX1ocv1wh8F3wQsqbvbwz0HqrsnPy9n4AAuoirBeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apt6Ouo7xW0zIruUu1Bygf52QmrWgDcgLIU840Udoms=;
 b=p+kx6s1LIdEKqOCfQY+LwFuWav312a0OIFiSKq8sMUGycBo6VxbduVYQFuypkE5Rvv+ksDJL3QN6Z2A9+AI6j5G4pV2F/PCcyJ6uRLM1FDXpYwfkn/YY5m/rXYvcaSa+aBLIN94FYRd0veOP+pFoodyhQspZzGbwU1lwzIP40jJBFtQdsyiyj0WRluxesix78WszJWjRbfNO+KoBpDkBlG9xjej4sqpmHmYIQ25Ylx+dF7sJjwMBeYztjug6I+F6wp9YLBsVveaHO8+WtfUmjZ66lfy0zAn4exkAxfoTbEPrkJpU0FSd7Y/AjelGNotcIzIIl6O6MeS0wEr+HEHxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ5PPF01781787B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::986) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:38:23 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 12:38:22 +0000
Message-ID: <484ffed0-16b8-4fa6-b36f-84d6d8a66950@amd.com>
Date: Wed, 22 Jul 2026 14:38:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable CMD_NFS for Zynq and Kria platforms
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, Tom Rini <trini@konsulko.com>
References: <6c05c5dd87fc1e53a4d4328d3b6ab70f7b49af32.1784722525.git.michal.simek@amd.com>
 <CALeDE9O2oBcbuYVmy-iF49QjwzKsAW7DJzHhr3L1V8pi7vFarA@mail.gmail.com>
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
In-Reply-To: <CALeDE9O2oBcbuYVmy-iF49QjwzKsAW7DJzHhr3L1V8pi7vFarA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: e014f406-bbb0-409e-aaef-08dee7ee1e1c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Jw5deU5PSwxbszdzeO3b6cHjkNwPLG0elpy16huhlkjw9+/SBKx54GCiBmf8cRjReK0y5xc678FME5CP5q4F2vTWQl7hXJKbAuRnOlYJfrRo8NIhKaNw6yDjY7TIoMTxlGOH5KOCJXwVbXh2UwXQ50Dt0EaGxH30Wqo9zNN7DHoXy8WzQTrGB1AkqF6DFnensYQlKsqXyZLtT2Y3wSK6dr+PCKU/UT/gcOw4LPQ7XauNcpDd+OKvmUZ0qpGvfFQHPEZpoQwiMHlnPxMR22AH2hHHGPtD+JBPaKwR7h6UVsinO4kG9kYea3EW7H0tq5p31AV6a5jvg6Fal9wrliy4vyB/S/zRXY7/gdIWCyUoItTKqdD/u5SA6TA/vdWbpHWNA2cgqbBKV7Oz3XapJuAR7yzop1GEk3BN2OkkRESJzC7xg8mqEv+ebFym7bZL45oiWf03El3R2dYQiXGmuu2GeSqJkkdm2AwRybrVsLjwdccS0nY1lDX4tPsKmxwItnmovDsBSBRhQZf9e3LnQG17NKMUXMMVIf8NewXSRIFmbOwXqdKLX14xaI/d0syIRsv2HEILLhmkoOKywNcmJ7iPTl1ULIe2OVeJ0gj2a1vhorTPgD4o8ekkpzOpA1gbkBMg7N3+irxrZZPXKK0JGv0sMrmaEJlTgDoP1Mw1R9tmdMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRDalI3SlFiZFU5Ykd2WTdJcnBNRnlCUXpuQVhjV29lMDJFVHkzMGpUaUhU?=
 =?utf-8?B?MjYrZldWeVhuRDZSUjJ0VWVlQlZpZ2RkYnUwandQWVFxazJkZFdJWkcrN29n?=
 =?utf-8?B?RTUzUnV1UzRHRXFRTUU4MlNwbGhib2lwMEYvQXdCcjE2aDFMaTZDVllDQWZh?=
 =?utf-8?B?SUN4T1RtNDRUdWkzL3IrWTEwL2NlMDlpeExOU3FEWE51NUJJbnZudFJraExQ?=
 =?utf-8?B?NW9CczZDTmlsMFZRdFZaVThmYWJ2bXNQejBPNmZzVlFrK2pOQnRxWDA0cFdi?=
 =?utf-8?B?aDZ6SXF4OTRoNWN0ZktYazNpRzFFQTluQnN4QndYMHY5T2xRaW5FMnQrb05p?=
 =?utf-8?B?ZXQxM1l4bmRuN2wzdGJkUFZWR3BSZnBqK25lRktOYW1jMUpoTzNXcVRzcWhO?=
 =?utf-8?B?K21tMjdkSWhDS0JhdFpwdFlUZE9FdUNGOFhIT2Y1Z2didXpWOFYwNXY2b0tx?=
 =?utf-8?B?VkRDdnpVZzlkY003VEZsaitmT0lYU0UzV1k0b1VPM2daQnc3UTNoSGpkUUJa?=
 =?utf-8?B?d2FvbGg3MWRIalk4dHpaZFZCT0puY0JPN1ZxMGV4ZWVsaUNmZUNRcXhpRVhi?=
 =?utf-8?B?Yk5WRzRZMGc2WEw4L1FhVzBDSGg3T0ppTC9mZlhsVUxIY0JEYXJMWGVBK1po?=
 =?utf-8?B?Z0dGeUUwNjZ3S1M4V2FxZXpTZEV2V285TFc1cVYrbUwxSml6TVRseGxhVFA0?=
 =?utf-8?B?Qmk5dkpqM2Q0TWlBSmw4S0kvdGt4OXlrZGZEOVVGSDJLVW02QkNEdmFMUkJX?=
 =?utf-8?B?ZDFWVVB5MTdQQ0U0S0RKZWRSRUZadEZMbkdhYjhINFlmbmpQc3IwdGcwVk8r?=
 =?utf-8?B?Z1hpODNDZHBKSWkwaEdVMENZWlNMQmpqTkJkNEJ0QVlhd2NkKzJXN2w0KzRM?=
 =?utf-8?B?V1duelpjNFh3Rkdpa0dXM1F3ckpGa2k3WWtGWURBTnhkRmdKS0haV1cxNUxy?=
 =?utf-8?B?UVJWNnNCZEJhZlVOTWtHVExqRWRlN3ZWVnBZMGtjR001OXVZKzNGSHV0Y1d2?=
 =?utf-8?B?d1M1dHZsd0MrMjlBemNDRjBQOEs0a3V4ZmlJSk1PYnBXeDFSRG1LS05QWm9k?=
 =?utf-8?B?NnllTXNrQnhtSTdWOFFmY0lUVnpqcDU3VUUwbWZrQ3RLa0dIK1owMVUvbTJh?=
 =?utf-8?B?MW15cTJMU1VXbUo3K29lZGVJdTRWUC9tZXQrTWI3VXRXbkJoYmZyUzNocFN0?=
 =?utf-8?B?blh4Sm1RNkdTUTFpVU96MDFncXRHRDZZMXk5azdJeXBDUy9ZditlSjBWK05x?=
 =?utf-8?B?QmxNRDliNEkvNGhET3FzTCtiekNDN3dxUFA2OW1JcXRCQlN1T0lvRGpwdFhL?=
 =?utf-8?B?Q3Z2a0w2NmNJZEhOcUlZc3VTU1Z1UURKWlJCcmx3c05RU3EwVVlXU29iZWNY?=
 =?utf-8?B?dTgzU2JJTFVRY3JYcDIrV2VCMzJGYzA4OW0zSFdBb1QyWXFPTmVKUVd4VXJ3?=
 =?utf-8?B?UUgvSHVzSmtsSm1Wb0NFOWJZZmF4M1g1TE4rWFFPam5rMmptclhEdklxbDM3?=
 =?utf-8?B?Z1grTzRjUTl2SWk4WmtBc0xwRUZ1UUJzV2k0ZGg0cUJmTXF6bXNlSG1kZWRn?=
 =?utf-8?B?TkNteXd2N0dGLytieFB4dURQdGhYbUV0c2M3ckJYenZYZTFBSE82Ny9EVGlR?=
 =?utf-8?B?TUhNdTA2SlJEMktuRjkxbW5jQ0lNQVM4RGtHdWh1NDg2cEcydU44UmZUYnNI?=
 =?utf-8?B?bzRrKyt5SUNDbFFoVXZ1RGRROGc3ZWIyVk9tRmpwK2oyKzZOb0RINzI1bU5F?=
 =?utf-8?B?eHBKcFZZdE5kUTVDQWxxSjNsUDhzVFNlUTFlWXpYUUhvV2xFNTJEa3FtWHhT?=
 =?utf-8?B?UlNZZ09mT21VdWVlM1JvVzRQK1loQkQyZjhuM3ZrS2l4TFl1bGVZTU1DaHFN?=
 =?utf-8?B?ekpRd0dRL2w0dG9hQ0hSbWhBeWxLYTJtT3RML2hnS0xQbGNuZ2pLRERCbU41?=
 =?utf-8?B?ZEZJL1NYbjI2L0Q0VUlRSnJFZW5CRDlESUJYU0JVZ25YSVFVbTIyUDR1azJI?=
 =?utf-8?B?WTZlcW1Ud0NBTjVTZW5GejhYcUgwNlh5MXA2NXNhdXVoV29TeEVOTm04VFRn?=
 =?utf-8?B?WUV3di8zdlMvR3JveDlzdVdySTU0YUFoNlpLSTBLNCs0V2N4VTRsaTRDZkMr?=
 =?utf-8?B?dkdoQkNXa2FFR1RwV25pT2xmRm44V2ZDN0xDbDgwdzhOaXBoYTZOZFVTNkRk?=
 =?utf-8?B?SnJBbEhZcWhjYzkxZmM5Wm91RDlHNFRscUZuQ3JMR0JhUWZENzhsYXN2VEVo?=
 =?utf-8?B?K1RZcHVOT25YRWZpNTVySmw4NzdnYkJQZVdsRzVxbmVialN0TmgzeGRIRHJP?=
 =?utf-8?B?TCtMbEFiVlJybHRkTEZuU1MycUI4bFc0ZC92U2hhbUN0a0JyL2ZiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e014f406-bbb0-409e-aaef-08dee7ee1e1c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 12:38:22.7815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1f5YJFGT9BRh4ZphlY06rBANyT/8F1JyephgF9kUfwpcu9mZ026xJKVxRdCtfmhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apt6Ouo7xW0zIruUu1Bygf52QmrWgDcgLIU840Udoms=;
 b=Wi0gCR9yTsaRjh9gu+xoiShuv4/PkmObNcF3yWItuAJC4Ab7z0MEvoXLHNUMJtB3Ns4ADxZrarBaVQ//0yHLGI6/5QYQKnBn+T7K7ZJywECtm4eDmbgpnXTl55bxqQzUAqSXFhPAH8HwYhfLHvHPyUDI8/Xnjb9f3EhFiNbYFCg=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Wi0gCR9y
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/22/26 14:26, Peter Robinson wrote:
> On Wed, 22 Jul 2026 at 13:15, Michal Simek via U-Boot
> <u-boot@lists.u-boot-project.org> wrote:
>>
>> Enable CMD_NFS for Zynq and Kria platforms to have it available by default.
> 
> How useful is this these days? From memory it's NFSv2 and that's
> mostly dead everywhere.

That's up to every customer to decide if they want to use it or not. We have it 
in u-boot-xlnx tree from quite a while and we don't know if any customer is 
using it or not but I want to stay as close to mainline as possible hence this 
patch. If this is something what it is supposed to be removed we should remove it.

Cheers,
Michal
