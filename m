Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40F1C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 07:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F2584C19;
	Thu,  2 Jul 2026 09:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="22RksKHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F9984CB1; Thu,  2 Jul 2026 09:49:11 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9C184B88
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbxfQkwC8lZ/9eZvrmpInxcaEkL4kBKPa4x2F2+n1Q+g/NIRpv66Y0ZIYkeLoJAREeKK7S2sOgqXV12O2cEt5oH41AP6eANWOKgaEMGrhtk8dCgnvAEFrnshF8O9aibsPvRBdMKxskoob2LBWh2XQp/xS8Sly2QCWQqXQXYt21dQXetRxv+S6g/KWWGQICRSfQ+kNND6r1KInMluh2bpP10z8WwETb9MdtmFu0xq2UuJ3MeNi21eTsV/QcG1iOmxo5z/3zCrKoFjnEhNK1WlodRQnnd7+Oipz9ONqbdMnlbQuiRPxQVZTZ6oIdI2TgzfN6D60enW6lASX+LulPg++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYqV2DwylH5cvcvq/oMmBo1I3XgiWHghQ8SkRKEBLUI=;
 b=Sf8eF3PgUxIgL38GQXf6RAw8/GB29oz17HxvBDFB/2wq0E++69BaThnuyd9F5QTBmYvZAtEHqBK8xXNgryTkL1xKOx/YSamOU0zA0pNg+b1KQb51XnpiD2kr+AQaORLRrlrN3mHlgp9T+SNkYLtBHSWJPZUg18QU5YZ9iSv36WKaCv2EmqESGczdQWIrBlabn8nD+X/E1NJ52/bH9g6Z41QFKryELiM5ZW+R49XD6aB/DQH3UhPs8tWBgt0b9NHyIey26UYw4TkyxJ3aROYxVNspk25n0NMrYwRCYZIKlrc0bKkgE7YCTRoT7oWUFvEbWZ1FUl3srUbQmAwD0OdPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYqV2DwylH5cvcvq/oMmBo1I3XgiWHghQ8SkRKEBLUI=;
 b=22RksKHibHI6jqZouJ9uKdtmLGYd1L6dbL0+lradpLN8MkA6W6by0Og+UBkNQSy6V6PZIMrdG3lLXEhceIWS/CPFQ8JW+GYysw+BRlKo4CoAdpeobUSVEnUWq5YOTTLprXfkB3e6XD4dnpDdXsiqmzbT73SXkU/BfzjNWe6XWU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 07:49:03 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:49:03 +0000
Message-ID: <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
Date: Thu, 2 Jul 2026 09:48:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
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
In-Reply-To: <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e237919-0c8b-4987-ff4d-08ded80e630a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: peZCsTPmLb87iQtPUhMPcOTIFWTBxID1Jalzzh1Mqbi1x0cd5ed8zpb2yd5deLx7efa+lkunHfgEDqxKL9LTqJ/gb/uTPwRTyTGvSmogKNsNeAKe2zStCDy8b5EzMejrxLt+GHfNkObVOUkJqojAdATPya/096y+r+yRhjjYoSNVnigI7U/B2S6nANaSnMohiI7hPLYvOnrcvnVbrGBtP6g/GUNrtlu4hyWZ+ZnRxe0BBs7MXru9mPiMUGGuIyDjuMpcItUW+vCCItb6D+GqoNaxyBs6KLF+Etd7f54leamFGh2zJjnRpSpNNfv2dcFDy5yo2LiSV42EeGSNFFFbjB2/DP5W0pgO1lHz4f/TtjKu/RyIbt7pHtGYKw11y4d9nm/pIuKm+S6YrWE2c0+GybSgNAmZAgp0HsWfjsaMjqTAYOI/kKE+mVY0VoW3WtJ1aLRCjPJ38LC/EXwykqX9sXkf9H8kVa7nCKxHd6dyOVdfvc9aUKsThBL0FCZlu9PBJf5n0F2QJ3m1bQ6bKKdxEZm/EGBIfLn8hkFvYBVuqH55Yp5ePDnB9mjQDCDchTZ2a4f82u2UzzZKVp3WncBBN635lgYcA7Ho0PyxaYsQv57p3SPHRE1C4P48Isa+Pu/6VWxx84PFuQeTmEuJe45NBlIWCNVXq8fRl+h15F3l9CE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURqQy8ram4wSXluazkwZko3MUNBN2FOWlRtMWN0cXhHUkRRLzJzOEdubGFL?=
 =?utf-8?B?Z2w1UFRYY0FpTDNFd1FwUm5VVHVmcWJaZ3VjdlhaU0NMRVVzbXZybTJuc3ZC?=
 =?utf-8?B?aUJzSkprMVdPQ1RVbXJTVmwwcWNEVm9DVlBlVStWTm00by9vK2EzRlp2NWlv?=
 =?utf-8?B?aGNnbHNyeWU2cGpydytXcEVUY00vdFMvdVRVMnFNNHA3RDdDYTNmQU1uaE9H?=
 =?utf-8?B?dW4vaFBUeDNsUzVrbWFDOW1lVDdMS09rVkVYTmhPbDdqM3JoeHA1Y3ZsRGJX?=
 =?utf-8?B?eWZHVWhxbzdFdUovNkk0WENpeEtkOHEyNlNjMVliMyt6UWVQanNjUGFhKzk5?=
 =?utf-8?B?QzZMT1FjZklrRUYwUmxQa2g4OHBXTFNpWlUyNGNTN1Z1UUlxdVJUYmpvbi9Y?=
 =?utf-8?B?di9HZHhXaHFOYmV6RWRLZDBYM2hqWndxYllsWlhyMVZUYzhDeVBIMWYvL25D?=
 =?utf-8?B?SmorMG54cVRRcDJxbmhvellPQUppT1hCQ29UYmgwbVVqNm5mMkk5NjkyMDhW?=
 =?utf-8?B?Y2IyTlVNYkdmTk9RenlhaUZhN2dPZFVuRStSMzhYVDRPd212Mm8zZjRUSFJk?=
 =?utf-8?B?RXQyekhyQkRoWEFhMGRoUlpDZnNCWlBkalovS1dqRHpyRkJTY3BKSHVQcXpY?=
 =?utf-8?B?N0ZINkM3QWFHc3RNclM4ejMxS0tYYjJLSktmZ0h3NmNNQlBvOWRvL0NFL1F0?=
 =?utf-8?B?RWt6QmFBTXRXS2JZWndMRWtuM05memNyd2dLNTdJQU5lSWpyNTZybnhoQytQ?=
 =?utf-8?B?Vk5XdmRxU0VmUnhKVHY0SWZUcnhQQVR6dUhJL3dSOEJyVCtkMlhCMFhIMjI1?=
 =?utf-8?B?aTlrNGNkNG5LYm1Qa2JIZFk1RFJ2QlVSY1k4S3dtR0MrSGpCeGpIbnNtUmxJ?=
 =?utf-8?B?S2VYVkYyaThMaFJybGxNWUlMOWlUU3EzdmhsdHBrZTN0cC9Ia1lLSVlyMWNC?=
 =?utf-8?B?Y045UHR5SFFMdVVzREFxMzdHZXNoSHhSelVtTU9jOVd3bUdlL3JVMWtMQVJ3?=
 =?utf-8?B?dGovak40SnBaeVp0Tmw3dGlKd3p1eTJVSFEyY0ZJdGJiTDhlZnFpeHRicVd3?=
 =?utf-8?B?K092RXFYcGJkWWI5MVJxMnF5bFR5a0xOd2hobUJ2QVBabFkvYnZPUTdMUi9a?=
 =?utf-8?B?WG1UZlV1T21XUUZ2Z0xOeUtIcUE0Q1M2cmdTcHphRzU1b09ZTURQTnl3Y2t3?=
 =?utf-8?B?RERKYlV3S2YxYUZpSG45RzFNbTJyeDRuUmZKdmJVRTQ0ZmFWcHQ2TFJKN3ds?=
 =?utf-8?B?MVVKRGxZOE1NNEtxK29uS0ZlbzljL0JJWFA1cDQxUng4QllHUzlQK1hWMm5l?=
 =?utf-8?B?cmxZckFsVy9QZG5wdUpmQ0pPR2Z2Q1k4UUFYTmp2QkxMTkJGN1NUN3FiNmVP?=
 =?utf-8?B?Vmt0eXBOWDJ3eERvYW1CalFaMDFZTzRpaWFKek1NbU45WFlXQmtFSXVzUXRp?=
 =?utf-8?B?eDR6VTlaM24vdmF2c2JVRmxFQTVGdEFuZThDTmN6RWUySmZXTmJ5MnVRQmUv?=
 =?utf-8?B?VXNqbllQeWRnUFlROU9IbFlrMjlWNjkwQzRlWk9CSmJEUDB4WExUbWx5Qiti?=
 =?utf-8?B?S1RjbGgrMVBhbXhRQXZGNm9KUE5lVW9UekV0OHlYLzYrMkYxWnYxSHo2VTM1?=
 =?utf-8?B?clhjczhTUkpicVc3cUcvakttUkZiaDRPdXZoN2NlUXRSK0JGSWRZeTlTdnVT?=
 =?utf-8?B?YmoyeTVBN0Rqc3ZsbDVEZDFmemF4bDJ1aklzNFdaWktjZGRJUy9sK0FZUEV1?=
 =?utf-8?B?UlhPeHUra2NtR1dmNjVEVUdHZkp1OXRqdlBUSlZvUUxyM1F4WU15ZEYxcmdx?=
 =?utf-8?B?WmJDR0tmdU5veitXZHFBZEh0SmdJTXJoK1BiNTFiL0hMR2tuVGYwRnJ3QnVE?=
 =?utf-8?B?QUhYSW5KeXllZWp0UHZjM3JxZGJIa3dmOEc5eHNWZGtWVjVtdWpaNlN1WlRp?=
 =?utf-8?B?VnBGMzZaSVFJR0krcExjOENxSWV6ZWRGcmFhU1M4NUVRMi9qMWhEZWZRWm5P?=
 =?utf-8?B?WUcwdEdWWERoNzVEK3ZOYkI5QkRrUldSeFpKWjRydDh1bmpKb0JMaVRZZG1r?=
 =?utf-8?B?cG5lVjQvY1ZrYUZXZ3p5Z09peGY0MWRuVGQ1ZGJLbldENTdMTjlWbHU1SitR?=
 =?utf-8?B?N09EbFl2WUQ5VEJiVUR6bnRTLzVUSVo2bWhsdXA1djV4T2ZrM1Q4VFlWTkh2?=
 =?utf-8?B?SHJsRGU0Y1FVL2ZXZFZaQWFvM2gvNEtJc0lCVGZWYXYycXVJU3cvdk9YaXF2?=
 =?utf-8?B?UUx5TDNzV3dtMWtxTGRaSElrd09UR05hUHdPOGxpYzlVWTZ1aktpYzZHVkJp?=
 =?utf-8?B?cXQwQTZOSEVKbCtZbURsdWdmTVhmRjVlMlVORUZQbFdKaFBCb3lmUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e237919-0c8b-4987-ff4d-08ded80e630a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:49:03.7648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yax33uRZTlPAXjVdudabCtYx7HtZvpbaFRMas6xUVGoOmLHIEUOSIPYTYvAkknIs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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



On 7/2/26 09:41, Ilias Apalodimas wrote:
> Hi Michal,
> 
> On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
>>
>> On systems with FWU enabled but without the required DT changes the FWU
>> metadata device is not found and fwu_boottime_checks() returns an error.
>> Being an initcall, that non-zero return aborts the boot flow
>>
>> Return 0 instead so the boot continues. The preceding log_err() still
>> tells the user that the FWU device could not be found.
> 
> Won't that affect the board later on? E.g When you do capsule updates,
> updating the metadata will fail

Do you mean on systems without mdata?

Thanks,
Michal
