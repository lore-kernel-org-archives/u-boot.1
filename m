Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA5CC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1DC80562;
	Tue,  4 Feb 2025 18:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GLr6/hwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F186805D7; Tue,  4 Feb 2025 18:54:29 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA0D800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfmzDxKXohiYbEsdFem0YpUhpU40NJ9F8Z3b3Hi3fTYiBNa1jdt+FnPFM9RUHt2HF8AQqKQ6SaVrLRaVywMQeP/vJNJ5EzbkKB0n5qFnfhprBauv6pCwPZFUgysKKAnWG/pjDGuAVOZlERXgmWi4qAfc1vS1ZYNbg5pNAT6Z1OpE9UdYMfMZLuOk/jHFTUW4aMP3ul9mgHiHbr0NxIlPpZ1u+9ckceBDhRdozAzMuwCeBkz3EbTHojL8XT/ulPPZtF4xgTkwGPChnUVnDXGAQQd692X89MPsdUyQAcy/KUR1i1H4CRVUxeNsFBESBQEmlNLrdqUNcHjJDiIRuFZXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofyI7LLQvaBiSoUMTrN5/lYIvXtKcjbty78GiIq1kmE=;
 b=JUbNist5R+jDTiQ66gFoA09+RDrMT5O4BIi3zK5Ao2M6OXdAZHUYzzHq2uOggSRgit4ip9v5ffLp708xfDl9wjSn/D03OmV4ORMChHU641LgVnjYlXrTZBBpsb7ADpj5g6gnqThsS7xWb1Hr+lsOBwd9XrY5IaDQo7nJ7hYJamwMsUShJQvLHoGLSeSKeguPBtG9nRZDmF7Dxkx3RjFIJE442tVeYSU27KIUEDJ+fmshHBi4XjlfKBjDi1tS7uDTJhz3hD9WcPYlfc5gWqGQgy4AEC+jHU1z+Xyd7Evy5mujUjXhN84Ha7cx/kH7vPgAOaN63mchA0I6CKGH/uXksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofyI7LLQvaBiSoUMTrN5/lYIvXtKcjbty78GiIq1kmE=;
 b=GLr6/hwr1gDByJaKpTuEfsrAFErXcTgDbwD5yXN8s1SbVyqeFtraTExBBnev7BWP30JGn/CtYiKHvnQmadQrzBfkcgbA62IEBtvZIR+N8D1WR4OFjeMpSF2oQVHSm4GuMDWxMBa1y88kQ+4eSb96zy/hj9hcJ/iipMkg+AUH1xQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 17:54:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:54:24 +0000
Message-ID: <d2512ac3-ae86-4c51-b413-48215fc6b04f@cherry.de>
Date: Tue, 4 Feb 2025 18:54:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3399: grf: Fix enum typos for UART2
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Paul Kocialkowski
 <paulk@sys-base.io>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250204172954.3364927-1-wens@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250204172954.3364927-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: b05af560-80d1-4675-a764-08dd4544f59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDR3bFRaR1cxclgwNThzRnl3Mm5wZFk3cW5vd053T25STFJ5dDQ2eWs2NjY1?=
 =?utf-8?B?aC84am11MjBJQk5FTjlxSStOZy9sQVpqbDFWcWxqZTZUbElhWlp0b2E0cE4v?=
 =?utf-8?B?aW1ac1hSeFo1Vmd3WHA2M3prT21ZVEJFOGhCdmQwRDB1aU5OMTJldENIYTZH?=
 =?utf-8?B?YkJjWUlVOExYQTBXWnpBR3BZSSt4UElPanpRRVoxZUFIVnlJOUowSW1zN1JF?=
 =?utf-8?B?ZmsxN2lHL2NJYnowL0trMFFQODhxOElJeW16ZmdzSFlqSktDSDVKYk1ZT3dF?=
 =?utf-8?B?UlJWaDFGZ3k4a1Q3bjVyZW1Hd1g0M0Z0MkZYMTVqZ01YeTNqc2lQS25VOG1G?=
 =?utf-8?B?MkpNdmpJc3VjUGY3czRFT0hxQTU3RDBueitXSGtKb2syWTkxSWY4LzBvMm1L?=
 =?utf-8?B?VDlaUUovQ2YyT25XaHVjVVpOYjMvVG5tR2gzR0xmcVZ1Z2JYaVpQODVvSWxY?=
 =?utf-8?B?bllKUmlPcmp0N0s3SFBMTFNUUUV0MGp5TTFJZkJkS2xWOFl3NVZPWXhQYU9t?=
 =?utf-8?B?ODBGcWx2SW9maThDUFpmam43QWU1WVZqTVB1OEZjQjFCTmZ1NDRiQzRsSUlC?=
 =?utf-8?B?WHpqOHExZ20rN3hYR1RDQTBIWWIxbW1HeE5RS0VLdDZKbzZMMUJ0K0d6cFVu?=
 =?utf-8?B?TmkxVjFnRlQyaTBDaGY4WXJjaWJNUHI5T0orVmlGN1pCNXlzd2pEbngvKzZQ?=
 =?utf-8?B?YTBJaFdBSExrckVrMkNnbTlPaWN0NlAraGx6U09KUTVNNDR1SVh2eGk0Tkln?=
 =?utf-8?B?d1dHWVZlWkY2bWwxaVBKRWY5T1J5ZEpJb1pHTW5aRmdYQXdBck1NaUYzRmNl?=
 =?utf-8?B?amtpZ3J3ZXh5c21DZCtwUm1iWkFJOUVwc2dQM3I0RXpmS2pCbjRiQ1lISmU5?=
 =?utf-8?B?eFpiaWhLWkxvdDh3dUxkWU5lQUMyK0VRNVVvQ2RwZGxvUm1nOExDb0RDT3NN?=
 =?utf-8?B?UFpzTXUzYnlTRXYwdXNONTduWnRaUDlHZUpUQUZRelV2bnNuc2Q1QkFFNm5z?=
 =?utf-8?B?ZUk0OVcrNXhiWlRnVVp2MTk3WVhNSm9XaDlSanV2MEJUUUZ3aUFtaFpRZVJq?=
 =?utf-8?B?RE5FajBQMDhwcStHQTdseHNmUm9JeTJRMWZOSDk5dkx0bGVVcE04a0NxYTZ0?=
 =?utf-8?B?WDM2L3BvRWpWTlZJeW81dERMdjJqdHBrYW43T3RCZURnOEcyZG1LVnJjRFBl?=
 =?utf-8?B?RjVRaXJXdDlMTDZXcHdISUIzbW1xcVJ1UWpJZDM2N0VweHJwckVVWXpTanlS?=
 =?utf-8?B?N3RhYmFuSURLaUJCVW1UejVMRDdSMWdvQmRkekJzdllYMm40dk9leXh1N0hQ?=
 =?utf-8?B?SGhXeVZXZDdpbzc2WEgrb3lSTkRtQk5SQnNNTlh2OTNLNlJyblZLdzVLdDVD?=
 =?utf-8?B?N1hXZ0tRSkNRVjlnSmtRbVZxWVRPYlZVQU5HY1lHSURzSXNXVlBpbjhvQmhW?=
 =?utf-8?B?Qmc1L2g2dzNYWU5qSnQ3anpxUVMwL0UyQ29VUi9Ra2QxRHdqUlp2bDhBTTVL?=
 =?utf-8?B?U3lYam5IekluRTBNNjBXd1Y0VHVsOFFTUjkzOEFSQmtpQXM3bFBZTFNId2tn?=
 =?utf-8?B?UDUrV055WE1SL1hUdXZGb0hxWnFidGtmSGlOM29oR0F1VFVMMzdiVzMxaUFY?=
 =?utf-8?B?UWwxekxMOGlRZTVPK2tkZ1FmWjFzVXZnem94MDdYUUlWQzZ3RHB1bHA5VzBC?=
 =?utf-8?B?Q3puaHZibnZMbWJ4dnR4eTFycnY2U0EyNG12blRweFF3SDY4VXNTVzI1NU9p?=
 =?utf-8?B?aFNFNS9FQUJVS2FMZHVmTFNIYWJJS1ozeC9rTHFBZmlLQjlNQkJ5aHpVS0dZ?=
 =?utf-8?B?VU9UVFhZWFU2SDA4cGNyblVkWWhycjQwb3hyR2NxYmdDTjFrN0VCczNuYjE5?=
 =?utf-8?Q?HONbY9YClYN1Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmd2V2FqN2tSVW12a0NncEN1LzJEMmJPT1dpYkp4cnFKUDFBSHY5VVA0SkNJ?=
 =?utf-8?B?UVBJWmVxZEEvckk1YkptN0dNTFVpemZCRHNHSUVIa3Q1UDdBN2U5bDFhRDZ2?=
 =?utf-8?B?ZXlkRWhJci9TbWZaVjdwZkd5bHFUK0pzeXF2S0RxdVY1NERpMncvSHVwRWJ1?=
 =?utf-8?B?dmhLUWREVjFuMVdnUGF3UFZWSXJnbGpvMVYva04rc3RyMjhRVVRWVzBwMk5k?=
 =?utf-8?B?UmtwSTJjOC9qNkYxWXN6Tmx6TENTYUcxVjduOFoxc1EyS0RuenViRnZqRU9Q?=
 =?utf-8?B?dGpQWGxLUThuVHJyd0ZBNFZvSnc1bU12b20rTnAxWDVYaUZpYzgzMTBkR0px?=
 =?utf-8?B?M2ZLTEt2OWw4aDRTWm1RNTZYS2Q0alFXQnpjMW5Rb0JQdUhiaWl2RXp3dmky?=
 =?utf-8?B?SE1FbDM2b3R5Q0VIVHJnR1MrS0ljNWVNZEpKckJvTnE0UE5samtCNElKLzhL?=
 =?utf-8?B?cVg5T2IyRC9mUnl2VXZ2NTY2cDFFZWRRVlp1cHVqMzlHM1d3R3Z0SzlkUnMw?=
 =?utf-8?B?TWh3VFdMSWJiMjB4cWZIdTh5U3pyTUJSMWlCTmY2bDFhTHNSbXRKUXcwRkZz?=
 =?utf-8?B?WmgyZXU4bEMwQnBvT002VmxLaTRLMW5vR2dnWFlnS2VDN0lPYnBUZmtFZ080?=
 =?utf-8?B?N2VFZVBnZjB4T1ExZkwxQzUxY05zN1podUxOVTdwL2NtMGZqcnpGOS9VWFZW?=
 =?utf-8?B?Y2ZBT29Xa0ZYNTkrUGc0cnovaWw5YXV2b24zRXkvT3J5SzZxVUM3UUJJbGJQ?=
 =?utf-8?B?YStFSDM1bEQzRCtoSkRaT044QjFxc0RuemdoRW4xQ29rL0dBSTZSa3JYZndo?=
 =?utf-8?B?MjBEZjc3STdWMnB1eW8zU0xRRUdLai9TL0Nha20xODNwZHMrNWovL0wxVUti?=
 =?utf-8?B?aTFWVkhpUzB4cktFUkZGb1dSZm4rUXhseGtBaDl6QkdSNlEybE5rRjN2eTBC?=
 =?utf-8?B?RnQzalF1dVpFS2lUSjhjK0I2UUdOSDlDOXJJS2ZzbjdtVHFsRWx0ckl3aTR1?=
 =?utf-8?B?OTBHbmo4cVVsVmFqaXlVaXZOV3NOamZsMDQ1WlBNQ2VjUWEvQ0dzUGVLWlND?=
 =?utf-8?B?TUdCYTBnZG13RmpOcGtVUVpxbFhRWDMvWm1LSlBNTThhem5HWEJEYWdkWWtS?=
 =?utf-8?B?ZjdFZC9wbHcwTDMrcUp0QTZOcUtuYkw2bzdMQW9mdy9HRHNuQVF2Q2FCaytp?=
 =?utf-8?B?Y05zNjc0ZGFhZTNLblExcTFhaFduei8rdlkrenIyMk5pNm52ZzJqdnM2WGZ4?=
 =?utf-8?B?NU04Wmx5RnZwMVNJcy91VkVLaklIS1Z0TWZkMmEvRkRiWGRSVWp2V2Y0ZUJE?=
 =?utf-8?B?ckk4TDN6eFN3eC9OZXVqcG1mcmVvazNuK21IWWJiQmw2dlhzS0hwd3RPeW52?=
 =?utf-8?B?QmQ2UE56cHFvaFJ2ejFiK082b1gyZ0cyQWs0RTRXVzBIK1g4WTVQTldIZXZI?=
 =?utf-8?B?ME0zeDdRM0duMWFOTm80ZEExZXRXcVNyWTdyUWZuVmR1Z295VHFQaXg1cm5Y?=
 =?utf-8?B?M0REN2s0QXRlY0Nhb0E3Ui9TL3kyeEswOTFHTFFoSmVWbkZITW9aYkc1c2Rx?=
 =?utf-8?B?eno5Ty84eGRvSmUwM09BTC9iR05qeVZDN053dUFPNUd3Szc3QXk4eFFNektx?=
 =?utf-8?B?Q1lWQUs4MzZZeTE5cHVYQzdka3FYb1dnRXRHaUx5c2JrWjZhcWtvSFZaVHVX?=
 =?utf-8?B?cU5ydGtlTm5kWlZTNWROclJCRW91MmdVT1hXcVA0eEhaL2QxdXUvNzFWWHZs?=
 =?utf-8?B?eTRHWitQbnAvZ3M4aW4wMjhYQ1g0K1ZBNWdWUDVQdHJOUGMweVFqWEtjY2E4?=
 =?utf-8?B?blpPSWZRZEt0dE4zQ1hzeFhBek9TM2t2QnhIV3RJc0NRV3FFMU90bldQbGMv?=
 =?utf-8?B?M3BYS0t1aUkzSDYyWFZHRmlaSnNnakpnMVJHZlJFaHI3TU5RSjF5WXhQaDk1?=
 =?utf-8?B?NjR0TnhtMWZZMGlPU3U2RUxvWmlhb1BlM2svRlZxVW1yMW9VL3JwQ2hDb3JL?=
 =?utf-8?B?KzNiZWhsQlY5Unh3U1RBZUhUQk42eHRNM0I3UjcrSUM1RE4wMmNPZ3lkUFZI?=
 =?utf-8?B?dVBsb2tjS2hsMUpUT3dlSHh0UDdmQ28wanZNK1p3czU0Q0cxaW14Wk90eEJS?=
 =?utf-8?B?Mk5pM0NYMEU4SVhLaFNQVzlDVTVkNVU4UUpyQjdiSk9CKzd6L3dvTklLTzNH?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b05af560-80d1-4675-a764-08dd4544f59a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:54:24.6329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVofDrZwIFZmTtMtQ4zqQypi+wOyODoXEGJqIehHkoPW4RlTaJ0/QVGEvq/hV0Pvxc9kKvGF+S0LoM3vCHlb740Ug3zI/zwxCydATO0pR3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726
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

Hi Chen-Yu,

On 2/4/25 6:29 PM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> In the GRF header file, some instances of UART2 pinmux are prefixed with
> "GRF_UART2DBG" while others have "GRF_UART2DGB".
> 
> Since UART2 is the default console UART and used for debugging, it is
> more likely the name should be UART2DBG.
> 

The naming should be consistent yes, but it should match the TRM to make 
searching in it easier. UART2DGB doesn't exist in the TRM and UART2DBG* 
do and match what's here so I would vote for that to be the reason 
instead of some elaborate guessing :)

> Fix the ones that are wrong.
> 
> Fixes: a2c08df3813b ("pinctrl: add driver for rk3399")
> Fixes: fa72de10452c ("rockchip: arm64: rk3399: move grf register definitions to grf_rk3399.h")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
