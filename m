Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44522EEF325
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45AB683F9B;
	Thu,  5 Mar 2026 09:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pYulQexy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1120383F9D; Thu,  5 Mar 2026 09:43:28 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD7083F93
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVWZCRRG8fU1jxdv5WqZBn+H098tZcavKvXez9bNOBLjLc3rGRu1nZ1BilxoTJvLpCx2SH69NrA5q7HmbPmLbmE964Ugk7ufLSd2IWDyI8gcfY8pVa/UTlTv28l7H6Ih2GhM0+0ytAbqlCm01xJTAvJQl0NSpnT4nFneQw/D9B+gxNUveR//1sVVr0rJN7AtesvMtQhVSsWfPGThwvNhmlmaDGHRTunX2l5acKatcEP7m4nK7sf9B33rt2+CXGpMBDtNeLG/f/vJLRzmAZb91lvxC3XqhoMBl8WWRwd50fRhOKSztWYzVZMaA4vNYf59mHL/rkSPAdcRx2hcC8XcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbPUgOGPt4QryekWNxsfMEqCY6V+N8xIYTqL1sDX4AI=;
 b=KK7gHOxfjaeEhgflTHpx0B7tubKVTJgWVhpVwu4/zvOHMfuX+TbWEI0vNkzUSk3x3kU90LdsW5agDY9wEQ/ba4ek1+mWQ0A7qfgFBozjaGeUEq7t4H2dMAj5xPyoooLmmoM0Dc5jMA84nh/oewG1URHYH80EPeE0dg5l8IAb3nu4odigvRdTpsByeukpmfnx0tt+6VyJfLTLkn+H8PtdML9Xxau4GiK0PepN/ylDuiC6tJn44CIILYnbsruDjUNN24G7DSqkTCYnk1M2In5gim6B94DMnXr/FXUehq+uBxn0z5N2DseoP6oT1Fv14Nk1PjZhH8JRx8LkNS2JSkOziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbPUgOGPt4QryekWNxsfMEqCY6V+N8xIYTqL1sDX4AI=;
 b=pYulQexy+Iqces7YHW+9G4I6wQiKW0+OBMnjksWnVwdlMBd1HnU8aICpdSy4QP73n7Jheq6pxYM51LbRqe+2WSE41Eo7RGZz0qpE27SglCCLRVcLQcsX/JOVxQBem1kc6IcYvUyuRz5tZO+mi1lTWqHe7AokkQ3VnUKnDSysu1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 08:43:19 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 08:43:18 +0000
Message-ID: <9c75b683-1fcd-4250-b2a8-7a5a69dc9b87@amd.com>
Date: Thu, 5 Mar 2026 09:43:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Enable GIC600 support
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <e3135eee33282281572fbc960aa45b5d0f355158.1772098079.git.michal.simek@amd.com>
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
In-Reply-To: <e3135eee33282281572fbc960aa45b5d0f355158.1772098079.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:510:5::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fdd166-f2ee-4c80-7d1b-08de7a934014
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 0JaX9q7Ci3tLuadat0iR6YF0HN/3KFnNbsk0oJ7F6oCp9Lb6EIyt4/PYx/EhCjyIQV49UCn89YGhOJY7xespa+Rn5I4L3SZgyEuDg3vFIEGarH0ltZknD3gI37N3EpzKgVkeAnOjrbJeACOWpEL3EQzrw8BkKbhG7Odobo2jGS5kKHT8FKjrWOsf/nD7tdR5MxMKtyiq7l9MOHYFWupTtzpCNkTWZtJ275Zq6M8k+wQwkSOpMWQaoOXgliuANwJB2hOaw5fEsabtMPF/pb7vEkJ+dbCP0DasjqBroT6NaFiHQ99CMAbkY89lRcks1N4vDz3GS3wQ3Ovu/4xXBLJ1J7EdtImWy/x1E4v4EEJ7lQIuPCx/n7/WheohWyQTTZRywi+h4aAeKz1ajBLym0c1qx0a/01LZdoIo98UTCFcjcUUoT8KJplwaHNLIyZCM+faLABTV8Ke4WMWGbIkylcuYoe0lmD8x5GhmK+bcvgWvi+BZH9lSMyVy++qS321KDOlcNMymWtHoN5Nl7z6rsMXwFTVLILV5F/3P6bmG0OBpxRnk8iWj7EfyP/qCbGmokAcHQNFPvNawUHWW4q410pDUjG897bQAPCS5CltCdsbEYqLN9QkJ1/u9UJu+9g07oQN54bmXFvi2sMP1794WEwzUb64//q9qa0JYrZ6bc8kJkOURwF7XtEQ1PvdK12wYOXyC5+uyTz3tNwfBrpk5r+rOdCkceVOH0ut19aSQIrxAMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TElEQ016TUZmSkpORGlseGhvaVFCYzFUR2NnK3F2a0ZROHBzaVJ5QTQwLzV1?=
 =?utf-8?B?emVQKzdlT3BvN3paSGtOd1FoK2kyTU9VZlhGMmFWN2swQThHSUp4bkZNNlZO?=
 =?utf-8?B?cXd4MHdNaW9YZWgxVWU4c01IaDNPV3RlaWZxT3huQ2ZOUjJCMHlzQkFra2JO?=
 =?utf-8?B?MXdYRnk1bHc2M1hGaWtQenRnVnZyOW5icUY3TG5WWW1hUDBHZE10WlRuZEk3?=
 =?utf-8?B?UXcrTUgyUmZDWTFHZERzRWNYNGc0ak10ekgxajBQZE1zSHFMYUFDN0JkWmli?=
 =?utf-8?B?a3BYbHN4T3NWSGtBYmJsdGdtaHJubjRUZW5XTW00aHUrcFo2KzE4eWlyR042?=
 =?utf-8?B?T051Yjc2ZjRNSlFydVpEaVp2elVBeG9qN2E5VDZJTkFFZXVJYjJLT1BOeWNs?=
 =?utf-8?B?eE1IU05ub1AxK3EwNWM3SXlnaUZBNXhlVU9OcFdsUEhtSHhKMXRWNWZzb0tY?=
 =?utf-8?B?RldTNlgrWS9TdjhYTUlvd00yWklnbVhjRnhTK2hxUVRJWXJxbm5wcXpDV0hm?=
 =?utf-8?B?Y0hQdHR1bDI4Q25EUTJrbmpZQXhybm1aZlEvdUNDUlJVVzFaSnVjR1lMRGpZ?=
 =?utf-8?B?TUx4Q0pPNG9pOTNoRkt0NjE2ZUVLVCtEemZoL3JpV051dVYwMko2U1JSY2Fy?=
 =?utf-8?B?czdsdmxjY2o4cTRxaGFMTHN1eE1ranpRL1RHUVRXNUdaVGFEY3ZmcW81OXUw?=
 =?utf-8?B?ZTFKdmJCVnJ0UlVTd2lrVUN6U1BEWGt4ZkdvSEhJN2JKemR4NW5Qbmh6NEtl?=
 =?utf-8?B?Q2k4U2VyQTFlK1BHUFdrU2NSQlRwT1FHZDUrV283SEZCZlQyWCtUTkt6TWY2?=
 =?utf-8?B?ejBncmtxbnJNTGFNU3EvcDJOU25USUdPcTRWb3ZXYTE2cHNRQmpWRmVxbmhr?=
 =?utf-8?B?eTl6dERlZEhGL0xXNytyTURKSUNpWjlWaWx1NU81akQrS1lSRUJmT0dMNjFn?=
 =?utf-8?B?RVY4Wnk5U0ZXWVVkcmUwQnF5WVBTK2h1SzRzbUViVWVhVnR3N1RueUVOeXJM?=
 =?utf-8?B?aDZsR21ENHhscDBva2pIOENsMTlGMEg1NHY4YnRETTFlS2ZYcUQ2RzdiL2Vw?=
 =?utf-8?B?R041aVJmMkdyTkdSenBNVUtXSnpGdW1iNVVUOEJnL1RGeHBIN3ZYTlp4d1Z0?=
 =?utf-8?B?c0NnbGpSSmVxR09IK056T3ZocyszandnakVBRS84U0hvL3R1RTRRaDlEaHM1?=
 =?utf-8?B?eVFaNVpwandaV29RNVkzSnM0Q29YLzZtQnJvQUhYTXZvcTgyQWQxYndUVlBK?=
 =?utf-8?B?Y1RENTgwTTFYWVlsZEdJQWNRUHNFc2Y3SkxXREpYSUhxVVJHK1htT244ZW8r?=
 =?utf-8?B?b1RiUFBLbW5WN25GV2l5ZUdYZ0FhejJQdDZPR3RGd1JVNCtWdEQ3K1V0WFo3?=
 =?utf-8?B?YzkyU2JPQXpBU3R6dXhzSDZSTGsrS0owcElwVStpY0YvbkdmTUJBWERoWVJU?=
 =?utf-8?B?cXhxVDIvaWtIM2paNFJ6SlhDUFNIWVJhMDlzaDJ2NkthbWxYaElscTJZOVBt?=
 =?utf-8?B?U3lNZmVoU3p6d3JFdEdJOXNIZHlhMktUTFZhZVRSc1ZqS1hZT09kd2R1RUF4?=
 =?utf-8?B?enQreVlOckFhVHpSVmdhREtDTmp4NEMrb1BSa2NsK0F0enBQQ1ZRT0doREFK?=
 =?utf-8?B?SWhKbGRNZHpQQ0NvbDQ0Z2hvcTZ4djdqcDBkbmpDSVMwU2ZTb1FydTN6UzFP?=
 =?utf-8?B?U2R5ajdLd0JKcGpSaHA1Y0U1cGtLMlZldjRyeCszdUh5ZWhWNTNPVFY3SVFk?=
 =?utf-8?B?V0lBQkZlV2JoenBLVXRpRE9wUGhYUlovQ1ZwR2NLVzBZOGN1VFhJYmxJc0JT?=
 =?utf-8?B?dXBFYklYWlJ3SDFQQmNuUHp6Y20rQ25Ba0FaT2Qvb21KUnMwbFE2ODEvMU4w?=
 =?utf-8?B?azA2Y3FmWlhJN2c2WlJMdXU0ZnNjTS81OTlVVk9XWnlRelNzTkJYWHBZUG1v?=
 =?utf-8?B?RlkvcnVSNnhZNkFBY1llTzAva2NKTUs1Tm5kZzBRWEVLdkIxMXFKaWx3TUJW?=
 =?utf-8?B?cnY2SDcxTUxCRWdCWkorVFAyQjBxSTZYY0l3TDBFaVQvc0kvUUxjam5NQ0Q2?=
 =?utf-8?B?WGVYdUw4MWpFTGtyWFUrQ3MwZ212bHk0eDNtRmo4WlN5cWV2aXlsTEF6TGZL?=
 =?utf-8?B?eUJXQ21NTVo5ZHdobTZKYU02QldXUThZTGcrcVBtSHBQaDRjVmY4Qk1yMTdH?=
 =?utf-8?B?K1hJSlNaYzFDQkllSnVkRS9NZjRwUzFrRDZURm4zdjg5N1JTeGVrQzJ6SS9q?=
 =?utf-8?B?Wk5IZmY2cFhrdytMZ3Yzdm5MUm1naUF1Sllva1FrN3ZQd0M5VXMrMTFiUWhL?=
 =?utf-8?B?V0RibkkxVEVxTUZ0VmNzKyttL0NNZkdac21zaDRST2dKKzZzVllRQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fdd166-f2ee-4c80-7d1b-08de7a934014
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 08:43:18.8515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+IpZct2KMDkt7+fqOPCHyeFq9r47y5hH3lI257GSOvgz8yzVnJSuZtaFopYTQ7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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



On 2/26/26 10:28, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Add and enable the GIC600 support configuration by default for
> Versal Gen 2.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal2/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-versal2/Kconfig b/arch/arm/mach-versal2/Kconfig
> index 2a595151d6fa..d1d8cbb815f6 100644
> --- a/arch/arm/mach-versal2/Kconfig
> +++ b/arch/arm/mach-versal2/Kconfig
> @@ -43,6 +43,9 @@ config SYS_MEM_RSVD_FOR_MMU
>   config GICV3
>   	def_bool y
>   
> +config GICV3_SUPPORT_GIC600
> +	def_bool y
> +
>   config SYS_MALLOC_LEN
>   	default 0x2000000
>   

Applied.
M
