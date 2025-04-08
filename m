Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F14C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 08:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C978320C;
	Tue,  8 Apr 2025 10:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aTvzy5gl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DD8831FE; Tue,  8 Apr 2025 10:19:16 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D9B82F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 10:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYerYVtxDnCJHiNv+CD5N8CxUcR2UHhC80obek6sMzlB2peoeUlOBuhEZZ4GHI/8+Kt6XZeFHqJL2igc3cLMpkQoHde7QIJa2KfhRuKACVJJDsuXuSdR58SPWVr2H2CUDYVnsW+PyNfHEA4WTQuF/fKi1fXC/bVD518ncfcBpP79yYDmFV46zpjE5Ea0TzwQg4hJbBAFlE6HGDlGyvU+h0bsJoiz+p6eTxGzyJtFSzqr4F1nekFDBG1YC43Vq+Vop/JIA1+4ju2IyxPkXCh80GMx/DZYTLZ6QOrEioKQl5x9IriDPyaLzyLMQ73OJ4GSynC9rAGqw+7rcq3i8Rek7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdSzntuanx0l1dZWHkXqcfYedQyqsiZJ53x1V5pviPI=;
 b=AxdBUVXp+WX2K7+7B/WMLqdq/mTWd3Wjf8fzoUqMaCLhrG7JGiThAjmJG0OIgX5xjYvbGZ7EPaIm229Nx94JlRpMWgq6vQC2Ep/q5TvVakwaCVRCp8ywNDwz1T67FEHUp9//rhmqpvvsPDEnKTL72q5f3pxWfKSs4s8Z87fR60CANd96RGM+HA7so02wUWuJz/X/doeaObldtCgcumSed1BwTxo5+sBIqsBnj7yj+d7RLOxo4c/u1QFwCffv/VsO3Bx7hhGjiOIlP79A72ysYwRSaP3vrPFBDFL86tcT3A5m9eb4J2EnROSGUi8g2p59sfmTpgjz6DOMOyHsNacrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdSzntuanx0l1dZWHkXqcfYedQyqsiZJ53x1V5pviPI=;
 b=aTvzy5gl1UzoQNCI/XMtsdnnqMtKr1AjPtwsp7rQ3K3D8tnNhNGDAZ/UB17LrmvklkHWWjSE+4ZKdn9u58rFfTcLN2yQ6kvAjr7fneUjMUz+y13C5zAQUSPwlm+vLgxNSlNq53ga4Yy8lEGJOIl9GyBK0v525DUcJq9kMDQNe/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 08:19:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 08:19:09 +0000
Message-ID: <300f75b7-6c59-4b58-b4b0-e8aaf7919318@amd.com>
Date: Tue, 8 Apr 2025 10:18:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: fwu: Dump custom fields from mdata structure
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1254c3c538facb1a124865aede861f399cf524df.1742552744.git.michal.simek@amd.com>
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
In-Reply-To: <1254c3c538facb1a124865aede861f399cf524df.1742552744.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: be5b54e3-4fd8-4003-4d57-08dd76760922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk50bFFBaUJLdGxLdjhWcFNoQkUvTGhuL0ZQRlJCMXdXamNOMFV4K0s0VzNu?=
 =?utf-8?B?MkVROE9WY0hRdWJQSEJxbWpXZzlFU0s3bHFVb0QyNGdZWUZkUzFFUDNTUTc3?=
 =?utf-8?B?ZjJTeTd2em9EZmZmSEx4YUxUampCVGNqNklGMmJqUWwzZ1RubmlybUVmSlRq?=
 =?utf-8?B?bHByUEZ0L3NLZ3pOMXArbzZibXc2UW90SGVZNFVXVG9Gd2RxTWl5eUhzWSs5?=
 =?utf-8?B?L3dLYVY5WEZkYVcvRXpqaTBBTllSUHA0R0REbGxwWk5uT2R3V3BMUWpZQkxY?=
 =?utf-8?B?eE5xaWpFcGZkSVE1eWFDdVR6Tzd0cEt1N1l1MThVR3lMVTRKYU9GVGk2U1By?=
 =?utf-8?B?aTMxbXJTaE8wcnZicExObE5Oa1RKS1ZBbmRWMnZKVlNqTFpneFBQbHk0REMz?=
 =?utf-8?B?Ry93aXJXVEh1WDF4bkFQVEtWa3RPY01Xc0ZqSWhaWmMrUytJM3NQbjNqamo0?=
 =?utf-8?B?WlBGNlJCK1hFN0hZS1VhcWpsamc4aFR4WkxBcmdYR203Vkg1RDdHUzN2akhU?=
 =?utf-8?B?bTI1d3lnVmRjNWtOUTZ5UDVXRjJZcksrbUNoU2Y1N0FGM3F1eXBNV0xuWU9S?=
 =?utf-8?B?QUdTYmlDZU1nUVdWaDJlU1UyVjV0Yk83ZjE1UGdxVkE2bGV4ZDFrQUFuWW80?=
 =?utf-8?B?b0o0L0ExMi9kSUppT3hlNURyMzNJKzF4Uk9DeDF4YVNwZGpuTDdWazFaMzBB?=
 =?utf-8?B?aEwzcTFlOERCL0xzdi9PMmpmNXNQTlVwbVIwdkpIOVB5WVhkZEdlYXJFNTdu?=
 =?utf-8?B?NmQ5akx2Z0hVeVBzMDh1dlQ4cUplbjBYbHNURXZGZnUxS3VEY09UZE5PQXEz?=
 =?utf-8?B?U0hQTkRRQytpcCt2U0VkbUR2N1VGVGgzTlFGT1hiTTVVWmU0bUx3WnBEa2I5?=
 =?utf-8?B?K2RsekVWTVFsbG96VmNMSXluZHZVR0dtVitLY0lWV280Y0w4UkRoNTlXNkYz?=
 =?utf-8?B?TDB1Z29LTWZFejR5KzIwRVlhWWlsOUswd3ZBTWphZno4NEZGR3IvYTQrVDJn?=
 =?utf-8?B?Vlo3am1GcXlmZ0NXRDJ4ZHphYW9NMFNqWWVBUmg1M0lId2FURDN3NVYyTUFw?=
 =?utf-8?B?N2ptMWlLY1FUK2FBY015d3RxN1V6azZXVXJmdm9NRjJCTUUyaW5WY1NQY1M0?=
 =?utf-8?B?Q2xubU9rMjkzcXlFYlk0eDVVb2FYQU1jTldsSHJ3ZGFNbFIvR3VzSVNzOTAy?=
 =?utf-8?B?eDlJNDUxVUZwSkhudStXU3FSZ2dhdHI1TThyN3pjNUJvN1ZHUzdpeWh0b0F1?=
 =?utf-8?B?Z1loTWRSaG5kVmNqb1VoTVFHRndVVlYwNndzNjdWWithWmIrcXlnRkd1Z1BF?=
 =?utf-8?B?REJoTzh5ZHlobHltcHk3czBIU1VwVWpLUzRWeXlDTmRuSGxxQklrTnI4T1Bu?=
 =?utf-8?B?cmo4UzJLMTdwaC9wTVFSTDBOUjJxUFhtQjhLdVdKd2xPRkFTNE9tNG81RHpK?=
 =?utf-8?B?emt6WkF5NS9tNzg1RFNYS1E4eTgwMlpVVzAxenk3SXROWGtVUW5oSkpYOFNT?=
 =?utf-8?B?UlUrV0VsVEk5amwyc0luT2puSXRBS01YT21kNFkvcFN2Z2JnL3dCUTQ4dWk0?=
 =?utf-8?B?dUgwaVdIUVBmWHUvVkJ1dWwxZGRPZ24wcjN4dzZxaVVlY2FLM2hTdksvV0cx?=
 =?utf-8?B?WXpWb0pxQ1g3OTdGV3pYa0xSTkJ2WlZIZEV4Qy95TmlkSkpTeUlYd3paT1Ev?=
 =?utf-8?B?QlVobGVYVmNGbk9MTFk1a05rUEhWYVhKSWo3VWdMelZwRzlOQnBDeHluMGRS?=
 =?utf-8?B?U0lpZm51RURoOGJlaCtiQm1mRXVzLzZWV3l3Q0lGWDdWOFhrTXJ4eVlPL3VE?=
 =?utf-8?B?Qzl3Sk1GTjVoMzVidkk3bnJsZVBRdE1TSHYybzNCY3FPcEZmck9tK1cxVDFp?=
 =?utf-8?Q?by8UvgqexHqP5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1c3bzJ0cUp4Q2taNEFjeEJnaHFsSEZJUDlEdnpUV2c1bjJjNC8xRWVGUkZu?=
 =?utf-8?B?YkZlZDBpczBRdXF2SUZxYTFvU0REamJGUWNwanlXREw4M0xQNmhHTytDODNU?=
 =?utf-8?B?L1BoODdoSVVFc0RuNWJ6NGl3am1Sb3VadWxQS3BFNzNnelhrNXQvMUFDcHR4?=
 =?utf-8?B?M3l5Q1pqUDJoSDR4bVp4VzNxWi93NG1DL25sUk00VWxwQWcwaGRGUkhpaDZv?=
 =?utf-8?B?UVJ4T3VMbVlZZzVxdURnVUZsV3NMMVRnYlExczZuVVg2NXA4cHZMMHFZYnd6?=
 =?utf-8?B?ZnluU01Cc0ozSElUQ0FXTEdyZnRkWEFsdG1TYXd1M3ZSNEFDcEVtSzVYUTZz?=
 =?utf-8?B?NUsxYjRJam1TRWIvTE93UDJWY2ZrYVA3blAvMjhMcUphdWVtVFc3YlU2bGJR?=
 =?utf-8?B?Y2IzTGNVdTlsYnZVZUgvMkJDQVk4U0l0M3Mrd3doZEx6ZlZ0cE0zb0d2TVlN?=
 =?utf-8?B?VlFvQ2lrN2o2RlJXazA4N2VQNnJJUFMyODA3ZndyWGdkSTlERXhSVEF6eTJK?=
 =?utf-8?B?TW5GcEJBM0ZCeWV2UFRSYXU3Z0pDN3N0eTJWalVCQWNydWdTSGtJWDFuV3JW?=
 =?utf-8?B?WEVNZE4yVGlaZjBJSnNLY3hHNklLc0ViZzFnVHJ6dnNoenhUQnlHUWZjNUJO?=
 =?utf-8?B?Y3IrYkkxZmt5M3lsOTh6bEhuYzNkd2VOUW1FRjdYYkhZRXE0YytFS2dPR205?=
 =?utf-8?B?OFArOWFlRGxJK2RudHcxdTJCakwxYUd4VjgzVFJ0eG1VNVc1N1FLZGV5cWRD?=
 =?utf-8?B?Z0IyQ1NIYjJkaCtzb09ob3EzZWtTMC9BdzlaMERtNjlDajZsOUdnTm1TMm9F?=
 =?utf-8?B?RG1HSVVSUlJEVVJoNThmd3lQNE0xdFVKUExQZEtnQ2JvZFd5VzlCZW42NTJC?=
 =?utf-8?B?VnUwd3hIY0NQUWNCalhQK09ZZ1Z6cGxUUzkvWFVzR3NqOEpYU2cwS1drOUtY?=
 =?utf-8?B?NitxSG1zcnRHQ1ArZTZkazRmV1pmQjY1dmtVSzFlU3RJdW0xNFY2TXYrS0Rt?=
 =?utf-8?B?RkJpNDR6NGoxV2NYaXRyOVR5UWhoVlpLcmdlSGx3NGR1bWRZV2xRblhVNWg4?=
 =?utf-8?B?NndROUw0anRIam5nV2NiTnVVQVlvTlB0NWVFTmxLS2dWNFFGRkZZZVVKcmpj?=
 =?utf-8?B?VGduMWNrOHdUdkkxM01TV3ZON3dYclJKRkZ4MC9tRUhkY0hmZXVOcXdNWjlh?=
 =?utf-8?B?VmpuV2ZIQkg0b2FrTHhUMGxSTjR5eHlmYVZEYjg2ZU9jT2JBb1J4VGNTY0hp?=
 =?utf-8?B?dzlYRlordll6RjB3Umc0ZEg3MnBXTFkrREhpUllNRjhLZDZnRyt4RW8yNnNB?=
 =?utf-8?B?ZERNQkVKNlFQeU5maHZ4RnlveDlYdi9kNmcwK09McmRjbE53RTh6bzlmYk5D?=
 =?utf-8?B?NUsrN3VGNWdMOGlCazh0cVJzbmJXOXRqb0l6eUZKMnpYZ0czQkVaVUhOaVE1?=
 =?utf-8?B?NGFhUlJvT2o1WkRjSHBSUGFTREFFU2o3MWFPRGptYTVoNEUwajduOFBjVjJr?=
 =?utf-8?B?TnUrZ3lhc0NqTTA3cEc0NGtxRnBzY3JLZUJyQk9vVjdqZGdGOTB6d1pqSFBT?=
 =?utf-8?B?WXBnb1BTZ3RjT3h0RVoyMlZONm9HOUVCWk1OamEveWk3UHFHdTlyNkE5SjRW?=
 =?utf-8?B?ZE1qRE0raGNFcjQrMkFFRXloSjRTWEx5UnU0OTBDdWZhdGpPN0dnRnpBbkVC?=
 =?utf-8?B?ckFLU2xEZ0s4VW8wYkZhQzNSV2IraWVZYktvZ0V0dWdBWUpYL1JiR0I2bjNm?=
 =?utf-8?B?WkxlMnN5Y1N0WW9jenJuTlNTUXhKeUtLM2htdXZSRUI2WDZvVGpQL2c3NWF0?=
 =?utf-8?B?dGgvR2E2OFA5VG1sSFBnSEZxdWpqV0ZwSm1IUnhlbi85L0taelROazZ6WDBR?=
 =?utf-8?B?QkR2ck1LT3NaczQxZDBwN2FHSGJBSnY5VENlNjV1OWtBNE1Lc1UvS1BUbHN0?=
 =?utf-8?B?RHZwdGVGbmtPRHBFZXE3aENJT1Y0cXM4UGtCSWJnUXRlR0JYUnpSWHNXQU1i?=
 =?utf-8?B?T3pJK2t4ZkxnQmlONlljZTdRNTJnWkorem5DUGdCYXI1Q09OMjE2eTRMVHN6?=
 =?utf-8?B?ZDRLcmhzN1M0Z0RIdi9XR0xLcGI1cHdSdTYrcVpOeTFnbGZRREx0U0NJM0VV?=
 =?utf-8?Q?NSmezbzTkwiXWtS1jZLv6O1yl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5b54e3-4fd8-4003-4d57-08dd76760922
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:19:09.0382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nY3+OMgmQGccAZOCaPL16JUSp4QYarrKHnpxGy11PlNJinzalJUWOgcG8vmWqfH2
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



On 3/21/25 11:25, Michal Simek wrote:
> The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
> data to the FWU metadata") added support for adding vendor data to mdata
> structure but it is not visible anywhere that's why extend fwu command to
> dump it.
> 
> Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Extend print message
> - Cover hexdump dependencies
> 
> RFC:
> https://lore.kernel.org/r/75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com
> 
> ---
>   cmd/Kconfig     |  1 +
>   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 642cc1116e87..1f8aa2521a8e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -185,6 +185,7 @@ config CMD_UFETCH
>   config CMD_FWU_METADATA
>   	bool "fwu metadata read"
>   	depends on FWU_MULTI_BANK_UPDATE
> +	imply HEXDUMP if FWU_MDATA_V2
>   	help
>   	  Command to read the metadata and dump it's contents
>   
> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> index 9c048d69a131..5b5a2e4d1cda 100644
> --- a/cmd/fwu_mdata.c
> +++ b/cmd/fwu_mdata.c
> @@ -7,6 +7,7 @@
>   #include <dm.h>
>   #include <fwu.h>
>   #include <fwu_mdata.h>
> +#include <hexdump.h>
>   #include <log.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
>   			       img_info->accepted == 0x1 ? "yes" : "no");
>   		}
>   	}
> +
> +	if (data->version == 2) {
> +		struct fwu_mdata *mdata = data->fwu_mdata;
> +		struct fwu_fw_store_desc *desc;
> +		void *end;
> +		u32 diff;
> +
> +		/*
> +		 * fwu_mdata defines only header that's why taking it as array
> +		 * which exactly point to image description location
> +		 */
> +		desc = (struct fwu_fw_store_desc *)&mdata[1];
> +
> +		/* Number of entries is taken from for loop - variable i */
> +		end = &desc->img_entry[i];
> +		debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
> +
> +		diff = data->metadata_size - ((void *)end - (void *)mdata);
> +		if (diff) {
> +			printf("Custom fields covered by CRC len: 0x%x\n", diff);
> +			print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
> +					     end, diff);
> +		}
> +	}
>   }
>   
>   int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,

Can someone pick it up? Or should I take it?

Thanks,
Michal

