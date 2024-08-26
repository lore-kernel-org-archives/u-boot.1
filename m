Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B30C5472D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFCD889CA;
	Mon, 26 Aug 2024 17:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sNJ171wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10F78891B; Mon, 26 Aug 2024 17:32:54 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40CB889CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDhAIL4KnQoGaPkKhHvmwc8XM1/A7Y9896NZFVrK+zeooDi0M2KwEz01SMRiMrakNiBJpHOd7y81QPHXzaRJ3gNphvPPmwjrDTabwE47sJqr/tznQK5t52bSR1S/fv9HhNQCzIwwNPKtufv0dKteP/XCYVPmo6AwZLa37M6P3gX+rvispRxYu2OjezKvN+bpDBaI1dK9gxKlWSpMuMP6JyP/x+6WpIAU87GYb9q3OC/Gp1DdIXohbZ9Qn1RHJd8wY6+cGlMkcZONbOwhBuJCzcelOXE2ERYkBLTi3nSYVCrxAxSaS/nMSb2IMCN/pLtOr/Lh4bGD07z1DYf4wrGRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZymTqJYoPIRkPIym1WoW1+YszjaACYNYiLFzEaYnpW0=;
 b=K8/uBgPhgFvbXEzuUZDAjIxlO0cTv1ezkhZRYRz9zdutGYKTF+01WG4B8Yzl6o9HQogtfPiM9t56I0uAxkQfFBZwrcDy/IBfK6k90dFBW5C/u9yK8Gz24NCACTfguElere8hNQSaw42G1mMEvkD/9bGjxCc7nG0s3I7QOci8gUJW8EAyeQ9jqp69BjCmjkWTGq+8w0XcUKeL6AzIpPOnsZabjJqnx7zNHiE4kc5GKjBmeTJvg6I/PVRdfRNIP7iLIqd4R/gKvJKI/8mF/X/dpwSIwiTYit7/pXex5zKxGY/DC9DZvDyIXGBQhfooSStlpUR5XN7cEs1svMuFnax87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZymTqJYoPIRkPIym1WoW1+YszjaACYNYiLFzEaYnpW0=;
 b=sNJ171wj38ujSj9evglv/KJIPZj54DzG8nO9sezDPNSvnoDYL27EPIQbHJtStXy6unKbAvWQYDtPmCPtLeFipFp2bkms1z4MnnNDFCNNgPL8KtTKGy5vXv9LUSQPXV488VcyTZbEP13obZV2f+I+sgb+kZEIEIMLZn1TbbfqbM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 15:32:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:32:47 +0000
Message-ID: <803e4d86-89da-46bb-99e7-b62daf4caa0e@amd.com>
Date: Mon, 26 Aug 2024 17:32:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] armv8: Add arch-specific sysinfo driver
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Stefan Roese <sr@denx.de>,
 Kever Yang <kever.yang@rock-chips.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-6-raymond.mao@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240816154658.1866186-6-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: afe5d6b2-471a-4fab-b1b6-08dcc5e45659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z01PY0gzVjdKQks1Y3FIb0xGVGo0ZnhqREYyQVVSN1F5clN4ZHAzcWFKZXJO?=
 =?utf-8?B?dVgvY0R1c0RtSXd0SHorY3habVI3SmJieUFPV1dqY2RnTmNhams2QTNWVEJ3?=
 =?utf-8?B?bEZzNkhLeFJrbkVqYzJtWmlHNllGaUd6SWlMdG1LZnRxc2h4SzdhNUpEamF0?=
 =?utf-8?B?NjIxYU5zNlpDbThHRDY1TkY2cUVaQzBINkVTMFhNcFU5SWp6TlJkbTFlRmxG?=
 =?utf-8?B?RzN0bmIzSVU2ZGZqR1FYUzN1Z01zd0p0NXhhdzltSmJGc3dPZHdxSFg2TmNn?=
 =?utf-8?B?UXhxdFpUeHNGZGRvS2RXRGI0SWJHNHVsb09xd3hVZnhZRlJ5RHEzMnFxeHdj?=
 =?utf-8?B?eTlKWk1Pa2RTUlozMHF2VkZwMDJVRXlYU3phLytnYktLcHlnN1pjNklPd1Az?=
 =?utf-8?B?WjJwUVZnUW9qL2haMzJOM2tER3N0SUlPVVdTVWpIMWZmMG5TUWpmM09pZU1E?=
 =?utf-8?B?dEh0bTBtV245R1EwdElwK0x5aE5XMSsrYTIrSEk3RWc2ejErdUJ1S1krZ2pZ?=
 =?utf-8?B?TCtDdE84YnNnQmRCdUFnbGFvUDE2b3FnQ05zL3NySDBqalUrNWI2cnhyTXZ1?=
 =?utf-8?B?Zk1IWlpOc01VTEUzSythVnhncFEzTTBWc1J2NU9LbHBrL1VOU1JrNmVhSkgx?=
 =?utf-8?B?R2p4MGIzZkNJYTY4R2NiRlpIT05wV2F3RFpxcEVTY1A0Zk1mSEFPUlBOZ2hs?=
 =?utf-8?B?ZlhJSzdtTi9vRWlZVlRVSTcrSVFpM1FyeGYvazJZMmFlSFpLOG0rK0xmcXp1?=
 =?utf-8?B?bUhPdVB3YnRnK2NyRXZBOEJhU0Y4Q0k5dW1teWp3VC9OVk9EUDVqVktXQkhU?=
 =?utf-8?B?c0tQYkRKSEt3QURRa0Y2dkVBaUhWYmFsVEdpUEVXdHcyWXVlUDhpWjJrcnlu?=
 =?utf-8?B?c3h2dlFtQmIrYlVlMWl2OHYyTkVOVlJBZDhmL0dvSDdXVDJQTVZEbUhrVm5l?=
 =?utf-8?B?WGRLY2ZDOGhZWnlEK3ZkTm5UcDNUUFoyaXFrLzFSdGQ5aTNtNXNUc3BVWkJZ?=
 =?utf-8?B?Y29WK203Z0p0SEUwemgxcGpRdElDbjlnL3BYYUpJaVBrUmFDdzQvamIrZGpJ?=
 =?utf-8?B?bUtzelY3VkZiYk5QbDJyZG5BZzN4eWNSeTA5dzBOOVRIUFYyUElmRnV4NXVF?=
 =?utf-8?B?SnBQMHBuM0JyYVJzNlNacXpsbGlHelQvN0FUOS9GZnBBZGhueUQxY1FKU1Rh?=
 =?utf-8?B?bERBZ082Mlhrc1E0MlNXQ0srd01ZSTVyS1RaS2dURzZSVitHV1lQdnNBejIy?=
 =?utf-8?B?QzNML21VeExPVUZGRHZSVkFWcVk2ZTQ3RjFSVVJUMHRwaUtyYjIvT2MrdGRr?=
 =?utf-8?B?QkcxQlY0d0ZUQlRyb0Q2VTBqVWl3eGtYVWZKRXIybE82T2p3U25oU1lvMzZl?=
 =?utf-8?B?aE1LZlZvVWNMTTQwbG1DVm11TG50WFN5RzNESGlnRVF3QTd2Vmk0eXhzT0lz?=
 =?utf-8?B?Z293QWtSOFlmZFhaRHBySGIrMndjMktwbWN3ZjBHT2xFa241eGxKcSs4OWdN?=
 =?utf-8?B?cmR6cXVONE0xZk5pMkR2WjRDemtsZmZIQ3QwWXkzMzNuUDYxZ3NNMWpmRklu?=
 =?utf-8?B?QWNUWEVNa1ZWR2FtbDRQVFBwdWVnZ1Q0UXl3OGticGtFS0tkQVg0c3RzU2dm?=
 =?utf-8?B?Wk9aOEkvWUx4QXRaSVVqN21QY3dhQm1sYkxxLzM3ZkcrYXJvMVRSTm50K2p5?=
 =?utf-8?B?dmU1UjRMMndSdWVRTG1rcWVRRFRvcWlsTjV4dmM4WU1ZOWdxbEZzRUI0TEFn?=
 =?utf-8?B?RFRKTVNybVVPTXlKdzdBR0FkUExCelh5RHczdlRYNzl1TXUyclVhUE1MTFox?=
 =?utf-8?B?VkNUd01nd1MwYmtpSHNCdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDdnZE9CMWtLNjlwTzdQaERJUTJnd3hRQUpMU203TG85U0x5YlhuSmg5Wnc1?=
 =?utf-8?B?cC9DZFpqUUtNQWFXR0lhSk1CNFhVamt0YWpkQzF5cCtNelRkdkcveE1UeTZi?=
 =?utf-8?B?WkovRWJHN1lXZGpNZFR1dmd4a09lOFJnZGE3VU9QSzV3Q253dVFQUjF0bkRR?=
 =?utf-8?B?WjUralVURkt1eVVBWnF5MUpxS3JBTUZpU2tkQ1NIZkFGOGJyWmZSNWtndmR5?=
 =?utf-8?B?dU4xMkNTcTlkcStsS0xObWU1bGsybXNaWmVZc2sycnI3RzdKMXlHSkhLVXdF?=
 =?utf-8?B?RmNYT3AyeU1udUtVWG5xTUlKQXhjeExvTEY0QlZwaFVYWkRXeE8xTi9hQmF5?=
 =?utf-8?B?MGlxZ0FQMVFLNTNvY2dtY0dFMEpvZXAzWkRoZTdMUTNpcFlZTXdpVTg3STVU?=
 =?utf-8?B?T0w5dkNydGlWSGJpNGRQS2hjbHdZQlBmL2l2OHgwQXFNOTZjdm0wZ21sNkE4?=
 =?utf-8?B?NnRjZmV1SEFJWVYrNVRXUGszNkkzRC9ZTVUyL1dzTjFHTU1YWXdoUG1BQTFk?=
 =?utf-8?B?UFFpakQ5WFJ4K2hjZVZsVlBzeThaN0VHR2hyZ3JFbWZVcjVnTkFGOHB0WTRy?=
 =?utf-8?B?am1OSnBpYWxUWHA0WE5UN05uUmZHR3FMYVNpeDJFRmtzSXp2bVM1Mm5ZSnpP?=
 =?utf-8?B?eDdSVE04bzlHRkJnejc5cU5wTFZwZUs2eG5sdktzZnhEZXBXRFdBSmxCMkZX?=
 =?utf-8?B?aWZaNHpMY1k3K1lBTmxpWFVDdlV5QVlPbDdlcjhWaXM5MnRCOFcxSXMrbFp6?=
 =?utf-8?B?Rllod2pPNEFuL3IzK0ZXVHNMS3ZhTmpHQzBHRzlZNFpOOXpLdDBmVjhVdUJZ?=
 =?utf-8?B?K2szQ2RWaUJ2Yjdpdk10Y2d4MFF1Si9JMzJ6S1VGVEJEajV4ci9tWi9DNWNx?=
 =?utf-8?B?dXZSVnpCektDdTVxWGJwNkgyUXZUVTAwMG9RR0VrSzB6SU5xMk5uVi9EWWlr?=
 =?utf-8?B?MDRIMzJMMTFoRVBGczE2aWozVHFmb1hSNHVVK0gxWGlOZWhCL2FWUUVUZVh2?=
 =?utf-8?B?enpjamMrSFVPZnVleFg0QndxWk5SeHo2bnBEVlQ5WlJ4UUVpQ0pSK3dUUW43?=
 =?utf-8?B?YmpvM2o5WEw1a2ZHNEpBVFlSQjRlNnVmUy9WYkdySFh6SzA4bVBiV3BEcjlh?=
 =?utf-8?B?cVByYmZ5Tk1pUVRIZUk4SHJ5cTI2Rno2T2xNK043Vm9tb3dXYklCZWMrMEk2?=
 =?utf-8?B?V2hid2Z4MVgxMjhvaFpsNVVFdmtSZUI0V3k1ZTZiaDRIM1V4YWhFeFJUSENK?=
 =?utf-8?B?a25Od2NFaVd0TWdkdCtMVjNKV1REVEdjUitBRS9YaGIrclRTc0hwRHBLU09S?=
 =?utf-8?B?NDgvOTFPaHhvL3NBODUwQU9jOFBOSU8xdkJ4RHo5cUErcGM0NWR5cGZWL3ll?=
 =?utf-8?B?R0wxQU9yc0NldFprdnc4dThEM2pRdm5tWjN6eDZBNGhCRVA4WnpSa2xQRXMv?=
 =?utf-8?B?Q1FZOXllZlg2dTlhSmlyNXNuY3ZkcTBRbitEOXdGc3daOTBCSFVBanFSazUw?=
 =?utf-8?B?VGpHTXA2ejZxL1hEMTE2dTFZcE14ekVMemh2MU1tOW9EMDVnSjdCWkNWazJo?=
 =?utf-8?B?SW92NXpkQm1pOXMzZHFZcGpsb2dRV0JKeWFlVTAxVXNNa2w4S0gvRnA1TW1t?=
 =?utf-8?B?L3ZrNGRGUWgzZEdYVFZBbXgyVTJhNXQwNjltK05GdUFqUFhtSDZjWmpMSjRj?=
 =?utf-8?B?UnEvWGV5dW85RE9wL3FoLzhZUzdYYkJJdkhEc0VDdDErSEtFSFhwRjJqY1ZJ?=
 =?utf-8?B?Vm9qSG0xdFpZdWdrNXk2Y3NvWkIwTlJiTlhpdWZ6K1lLS1UzS1V0MkFteGtW?=
 =?utf-8?B?YkphVThWMm9wTWtwbm11TllRN3Qrb29EaTk1eityN0QrZUVkT1AvQ1BzeFAr?=
 =?utf-8?B?TzEwMWNoOEVCUjUyeElvWDNtUFdnWEI5d0VvOVFNNDVLaWVZMjhyNitaNnJq?=
 =?utf-8?B?MGpUbHBpcDk5eXpRQmhpZk5GL3hLU0E3K2FZdVZ2c3lIT1JnemZFaW9DUG82?=
 =?utf-8?B?RXFQekpTSDRZbHVJdnQ5YmNFZGtwdXNSSmJWSi9yZ21OV29ydGE5d3pCRTIw?=
 =?utf-8?B?aDllazgyWTlvaExVZVpWSHQwRTF3cFo0eWN5cVUzWjNTVEd4SjVISi8vRHVR?=
 =?utf-8?Q?G7tB1CE3V/TWKhBogAZZrE6dz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe5d6b2-471a-4fab-b1b6-08dcc5e45659
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:32:47.2772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thOR11ycQWCfFJqPauxLqwTDOTBGQepU0xkuaUh1VnzJMBybiPeH+Dj6IDdQV0sR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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



On 8/16/24 17:46, Raymond Mao wrote:
> Add common sysinfo driver for armv8 platforms containing all
> necessary SMBIOS information (Type 1 to 4).
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   arch/arm/cpu/armv8/Makefile  |   5 +
>   arch/arm/cpu/armv8/sysinfo.c | 203 +++++++++++++++++++++++++++++++++++
>   2 files changed, 208 insertions(+)
>   create mode 100644 arch/arm/cpu/armv8/sysinfo.c
> 
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index bba4f570dbb..374f20d455d 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -45,3 +45,8 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
>   obj-$(CONFIG_XEN) += xen/
>   obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
>   obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
> +
> +ifndef CONFIG_SPL_BUILD
> +obj-$(CONFIG_SYSINFO_SMBIOS) += sysinfo.o
> +ccflags-$(CONFIG_SYSINFO_SMBIOS) += -I$(srctree)/drivers/sysinfo

I think this should be moved to generic location to avoid line above.

> +endif
> \ No newline at end of file

obviously wrong.

> diff --git a/arch/arm/cpu/armv8/sysinfo.c b/arch/arm/cpu/armv8/sysinfo.c
> new file mode 100644
> index 00000000000..a8e17d654be
> --- /dev/null
> +++ b/arch/arm/cpu/armv8/sysinfo.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include <dm.h>
> +#if CONFIG_IS_ENABLED(SYSINFO_SMBIOS)
> +#include <smbios_plat.h>
> +#endif

This also look weird.

M
