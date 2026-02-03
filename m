Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6677FE7FDCF
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476368409A;
	Tue,  3 Feb 2026 12:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3VhA94Zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 672B08409B; Tue,  3 Feb 2026 12:46:13 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C078401A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2IcXnKeL6tb6XDg3QkSTC/5zDTzDNap2NSjVALNSSieAEsAjL/KLLvU5IIf76vgb/hFV/EBz+nVHHBpVOizN9XYAo+moAhomQelmzLf1yz2nSjKGfZTk0EOdvWk223MxZXV0MsK5FG9Guaddd55Mo2GeX1CbV4WDil0Szg5ru/oIDPkrmr8qeGqb9lZj1g4Cd4tdVO5HuROoDtWMQmR/szZ5eDJUYddbiIn6yiza093Z75QooOcz9SGDh3ysu9XryvZfBDqKZQD6rd3cQYp2ovB5cqVKkCqzUINNcEBHrKD8svQgPLE/gJIBjquPFKQZH6HepFoAIm2bygjWF5Y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiMTo5znnRbco2k36V9E2wO6FnI9EnQW2VpQtsaj4wU=;
 b=ZgYOOsgbNPh5KhVqn568uVvbypmlW8lUIPfCEtdm9V+8nAHTalmKYDPfxNojNfqjH2VGj4IgE/uBuvxGHyuTnDwDW4Z7Ms9pfvVSCuwzJC5TJ0L11V+dg4Yny1v+6MrYP2tCx1dimjnIu0E7yTcPMhdBe5q5t/NgRCNeNO7ne8F7AT+G1JvFuTpqLvSd3QoSGZWuqYjZZ4Br2MhFWXlDQgaHdsDl2Ewkvp+iMLGJ1fwGRcRu6bv0f44MGnFxi6YS5BqL1VIOUIKfgzFSrFLjgfjjzK0fbURq/34lQ8Jf9deJ68/HfrMxZR3VMA9iI/CdfamYZj+GlwCr2IdEWpzcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiMTo5znnRbco2k36V9E2wO6FnI9EnQW2VpQtsaj4wU=;
 b=3VhA94ZiwkfXoC6VYsGyXrTdCyS9+VnoRHgQKKYfkdPL1CZRuho0zx0cOLFM+xHzZOtMnz1aPJ/RO7UK3OeEMVn3NeJvjGjcKgxiR4zkGUcKSo4I/sh13+tjhRETxJNL1X9FY8m6Wcdyak45cJ5DvVv2omXmWQRB+EmVSFz5TPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:46:05 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 11:46:05 +0000
Message-ID: <e8526845-44c4-44ef-8921-bee95fbe2fe3@amd.com>
Date: Tue, 3 Feb 2026 12:45:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] efi_var: Unify read/write access helper function
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1770105470.git.michal.simek@amd.com>
 <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
 <GV2PR05MB11941E99EBCEFBB6D8F523E6F839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <92c5c4f6-05fd-4c65-be43-b5125030cacb@amd.com>
 <GV2PR05MB1194157700C5D0ABCF1578C64839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <GV2PR05MB1194157700C5D0ABCF1578C64839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0241.eurprd07.prod.outlook.com
 (2603:10a6:802:58::44) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: d5722a00-15a5-4b51-2691-08de6319d00e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2NMaXJkZzIrNGdzTXlDMlN4ejBud3dwSWYwWWlZVHRRNy8vcVZLWThZYUJY?=
 =?utf-8?B?NzVoNGlFUm5SM2NIbGYra1JhbVVIaGQ4cko0cENaWEV3MmxtM09EU2NTQmFC?=
 =?utf-8?B?RTRVTkdzZGo4a1lmS2NRc0ZrS0lDZEVyQjdaUGNxSjRXbXVxV3JWWHNtM1du?=
 =?utf-8?B?ZGtuU0dKVU9zU3kza1dkby9CMWlvYlBGODBmVm5IaFFwaDRyaEJLZWd1Rjcx?=
 =?utf-8?B?ZWhJeE91WlRSd0tnWlNmeGtyUWRMdkVha0V1REwxMU4wUTY1UG9FUUEwUnVv?=
 =?utf-8?B?R2FPNXhxMTRtdmNkTERwbzFpMElIUDhCUlVtWi85YnpXdVVrdnpSQmhMU0pY?=
 =?utf-8?B?aUsrbjYyb0Z6MlUxT01MV2N6ZU10N2NFc1l5YWlQM0JDTFNNZmFUaWlPWUZy?=
 =?utf-8?B?ZDV1VVNoRGxPQUg0WDFXVHJReVpNTno4dTE4UXhtR1RxajAzZm1udS90ZHZ4?=
 =?utf-8?B?QkJRRStiUEJab1BLaWVWSk52VFRiRUVPN2dycE9RYzk1Vit2TVQrYnF0Z0xp?=
 =?utf-8?B?bU5nb1VsanZZTmorZUxGVFQvRWU4YnJBNzFncFM0QXZsRFpsQWtWajVwTDhH?=
 =?utf-8?B?MVFVTGI0UzhMN1dmZkFwb3V5dEtIa3FZNUpPWGhMUkd5VDl1N25lK1lDbFVs?=
 =?utf-8?B?SjVIL1VKM2pic2lnQlZHbTVPUnl0RFltWHFWU2phMUU4dmN0YjRwbjlNYnhG?=
 =?utf-8?B?NUVyZzdrSmxLaHA1Ykd3R2xaUW53TmhGR0svbzBsMnhPMDA0bXVhbmo5U1hT?=
 =?utf-8?B?RzhReGVWaE1YTVhxU0RkQmdldFdJeXM4OGY1bWRORmp4cjVCOW9hWjllQnZi?=
 =?utf-8?B?KzlmNi9zUC9HTWlmVmQyLzRaY0NDdU15M3Q2Z0JqbFhlUzBNV2VnUVJ3T2Rp?=
 =?utf-8?B?UndjZTcxd2ljRElma2lYWXR1OEpTOFFpWjZRSE5lT3U0cmphc1hMRVdNamFR?=
 =?utf-8?B?V1I1NUdrSFNpMUgxUGpqcWY0NDB0UnlCZEVJTis2QlFja0pCd2x2amFuZm9p?=
 =?utf-8?B?a2d1c1AwMkcybFR1Wk1jZXhlTkJnTTEwUHdNYlFNQkMzMEwwVEhBbFRjTUNZ?=
 =?utf-8?B?UVc3QytZYWNibnhObG1qbFB0K2RWYUpQOG1LM0RuM3FMU1ZGR0dxakxXcHYy?=
 =?utf-8?B?cTU3cUR4ZEFSWmFDdWl2Zk5LTmxlWEZnNE5CMkUvZlpvSjYvUk1zUXF0MU1X?=
 =?utf-8?B?c1lESFRTakFZZnNWUGh3Z3JZdWIvY2ZQdkRDVTdNRmc3T2JxbGM5NkpEODdq?=
 =?utf-8?B?RTVpSHluejFaOUhMeW4ybXFYS2V0a09QbmtrUGE0c2VyZlJEU2hyMW91K0lE?=
 =?utf-8?B?TkgwT214NGd6WnR2MWwxZFgwckxLYzg3U0o4UkpNZDl6SDh4b1djN3Vhbi9l?=
 =?utf-8?B?REdkZHZyb1FZeklObTNpaTl3OEJxYS9PcnRHYlBxNnFqa3QwVHk0QnVWNWhG?=
 =?utf-8?B?Q2FmaldvR0lSTWxCcUkvbDYwby9uRlZBRElWVE9LT0EvM3FaUUw0MHdrUkJQ?=
 =?utf-8?B?WkFNdDVEOEZiV2h5eks5ZDNDdUZYZjZkMFdWRmZpUytaTjFLUEtTZDdyb3Rl?=
 =?utf-8?B?ZVNnT3FNS2JxRGQxakNvbENhT2FFUmZWOXdBYTlzUWo1a1dSZ3d0VHc0YkhN?=
 =?utf-8?B?ZWV0OG5LbVF1d21HdVRTTGtlcjd6cFBCTWQ3ZUlRamV5Tk90Snk4WTNYYmpR?=
 =?utf-8?B?TEgySFVFVnVSVytYeUVqbys4RWFnNXFQRXRnaWRPeVQrcm1jMjUwTU1lSVdS?=
 =?utf-8?B?TE1NTEhkcENOYXA4S2JycGE4aGZGazNaVjNKazhaUEg2dGdIMmFjaitxY2Fq?=
 =?utf-8?B?aWFCUUFyYTd5Y2k5NzFFbnNldWNTTVRlaUdsdFdsRE0zMEZhRHk4eEpnKzNp?=
 =?utf-8?B?YzlueEVuTlVJOXgzc1l2ZVBxYlg0NEJiZGZyck9HVUpCSElCVmhVSE5qWmNC?=
 =?utf-8?B?NGhDY1VhclBUUzgzUDBJYzA3MjlJcExWM2RxWDlWQWdLRUw0YjZrQXU4Rml3?=
 =?utf-8?B?ZkZwL3lEdk5YVzB6NUZSR1c1dUFZTm5BOWZpc3JvaWZXbXZpKy8vb3FRTnVI?=
 =?utf-8?B?aHJJK3gvOGNZeU1lYi9ZY3BNRkJWRDMvVVBBdWRQM0lQdzBuNlpXd0tKQW03?=
 =?utf-8?Q?c33s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTVCK1F3UytmV0lvcUd6azFiUFZXL0tjc0dEdFdHcTdWdHIrV09weDl2Q2tw?=
 =?utf-8?B?dHFKa01OUkZleHhDd2R0L3p2NktiRjhhS2owaHRvVlRkTW1TajNJNjJnY2hJ?=
 =?utf-8?B?bEE2THB6MkNqbm5xTUEvYVNjWDNndmd6aDdPZ0FLQ3llRE5oU3dVL25xUTVB?=
 =?utf-8?B?cUtiMkVGYkYrc2JBMDRQM0Njc1oyRUo5Q0I5MGZoYnJFQytvY3FwMUJTc20w?=
 =?utf-8?B?ZkNTOENodUI5dkkvSVBQL2ZuaVlYRVlDNVZWczRNR3NsNDZUNlhHZVU0aS9Q?=
 =?utf-8?B?Q1JSZWFSdWxrdHN4dzJwcWg2TjdremV1cTdJV0FRcDhhcTNJeEYvMndJM1B0?=
 =?utf-8?B?WHh1UURiOFhEZmZqUVVKSk82aFY1RmxkK1dybzgxbDVLR1ora0JxUUViVU5P?=
 =?utf-8?B?UjdKWTQ3UlNSVGJhQjd3clFuSHlKYzdLQ3lTZnU2ZFVNbHl0VEUrcDQxZ2hN?=
 =?utf-8?B?VE8weUFXazZmd2xWbUJXYlZMVnh3Z212RlVvUzlkcGVSTVVPR0d6anVuMXEw?=
 =?utf-8?B?NG8vZnFSVmxCWUlPYkJJeHRlaEp3L01VN1Z3YjlJUVNETTFxSU5NZERLd2xV?=
 =?utf-8?B?YmxFMGlBSnEwc2g2STh2bmdyaXNCUVBTMUVkK2JMc1kzS2ZJS3ByRmxDRUZy?=
 =?utf-8?B?WUhFVUt5SVg4blhZNmZFWVVCcTZtVjJNNjZPemNhQjYwQ0NGRFNBV1hiTzY1?=
 =?utf-8?B?NEV0dSt4U01ldUNpQmgweXFsTWF6OGZGTVpHT0V1THc0Vmkzbmc0TUZUWk8r?=
 =?utf-8?B?OFlTUUdzQ0kzSFIybEpLU3pzZ2N4dlVhNzRTdlNpeGtvVXNMQ0pLUE9PVmJI?=
 =?utf-8?B?ZHhWYzNwWTNvejBtUXpjQm1SSDFwRjhRNTRabmJjd21RQVNRYVhVL1l0bjd3?=
 =?utf-8?B?TzQwNzFsZEhkZEZNN1ZMNWl0bjFqUWxSeFM5cFFjVzJYMnBQZ0dqL3ZXRnFm?=
 =?utf-8?B?RHBaRE1MaitIWndsQUF1RFRFOWhvLzl2M2pZZWMyb2dka3NvMW94Z29USWVh?=
 =?utf-8?B?UTNqQ2ZJS2RYSVFVNno3Q0dsM0pFTjZYcW9aNWtyKzErdXcwRVNMQUl1ejRI?=
 =?utf-8?B?UTBBaXF5RzArQ2ZxL1hybkVlUmZveFFVQTZDdWR1UG80THQrWlNlaWhFUHlz?=
 =?utf-8?B?Tk5BVDZjWHI2bXV3T1A1bmZBNnhvN1BiRzUxMTFjbERvVDEySlFpK1F6TVp3?=
 =?utf-8?B?Y3dKSTQ4eTlkalFTemszSnlOc3piVUdubzFxbkVDQTlQaDR4dllUa21aNEhG?=
 =?utf-8?B?ai9lNmJONDNRUVpGN1FuRTJZbDhLTm04L29MUm9BWWpKc1l5MUZrK00zQVZs?=
 =?utf-8?B?UHB6dllIN0xONmx4UGVTdjR6Zi9pcytWWXZKR1FPRnpUME55bXFlRlJybmpU?=
 =?utf-8?B?dHNqanAxTzhNZjd1NlhyMVBFbzE1Y21XL1ZYRnE3dE1RVWs0aW1ITXdxdnRD?=
 =?utf-8?B?M2NDeUZObTN3azl4dlNWWVpXTUNCczk3S0Y1ajVzL1FGRkpQSGlTbU9FVjRj?=
 =?utf-8?B?cHM4Y3dsRmdjMkFwUmRHRFh1ZVgrMkZWSllzNXBaNVpjUUJxd2NaakZUL0li?=
 =?utf-8?B?aE1PcVFEamUzZytJc09rZmNzYlllQU1yZVBVL0dQbVB1dlo4K3B6YTVQL2lj?=
 =?utf-8?B?aFFwZTdzWW9OdnJTRi9nMTRmd09OM3hGSDBtVG5UU0hsUkJEbHpDMEVyVjNC?=
 =?utf-8?B?SGtLMFhGbXZZMFVpZzBpNGdUQytONG1ES0gwenFOaVVLL051T0NtTHp4SVEx?=
 =?utf-8?B?UTBNVmZhZEVTVVlrOUJvNHYvTjBkRWJYSUJRcTBjcHptTnpiSHRPN3RocURx?=
 =?utf-8?B?Znd0alNjUDd0OGJVaEFWcFlRNUpBR25KclZ4MnVNb3drSlJFSERZNzBsemRi?=
 =?utf-8?B?SzRzV0ZORzJ6S0RDbjZab0JPVmg3NUorY3dLaFBuQXZJcGNTam51S3NkYUpP?=
 =?utf-8?B?b2xROVdpNlRlNTB0T0JxbDVHcEVkME9vaFBWcW5CWnVHNFMzMWlPUXR4Q0xB?=
 =?utf-8?B?QUVYdHhvVE1RL01XK0F2OU55eEZXRVFNL256a2tKSXJuUmo5S3F5N2tyOFd2?=
 =?utf-8?B?YUphNG9GNy80Um1qNjRTMVBwbUlOMERxVG5BRytsSHh0RUkwOXV0OXBWYnFG?=
 =?utf-8?B?eXM1c0V5L2M0U2U1b1I1YkNiR0NXZHFNb2gzTU1oa0pLcTlJUXhGaVBNSll5?=
 =?utf-8?B?bVl1SWRHT0Z6MnBzQlpGK0xIZGI2eDNCWTNxamZOZjk0MnJjVC9yakI3TDV5?=
 =?utf-8?B?WlRoRWtBaVdnM0lWWXBINDdGZkRMcEltL1JNbUY1OW1SYkJtdUxPNVNNMUlP?=
 =?utf-8?B?UEY2SDY4QlNLd3o3Vm8wdUtpZmJyVUJjQit4WDhmai9uU3JMaGVsdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5722a00-15a5-4b51-2691-08de6319d00e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:46:05.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6/QiRPskDbtqD02ToDnmMu/QtblQIXW+n3yw0Jj90OKGEl23OHs5jzysPQYeLpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
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



On 2/3/26 12:29, Maarten Brock wrote:
>> -----Original Message-----
>> From: Michal Simek <michal.simek@amd.com>
>> Sent: Tuesday 3 February 2026 11:10
>> To: Maarten Brock <Maarten.Brock@sttls.nl>; u-boot@lists.denx.de;
>> git@amd.com
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
>> <xypron.glpk@gmx.de>; Shantur Rathore <i@shantur.com>; Tom Rini
>> <trini@konsulko.com>
>> Subject: Re: [PATCH v6 2/3] efi_var: Unify read/write access helper function
>>
>> Hi,
>>
>> On 2/3/26 10:44, Maarten Brock wrote:
>>> Hello Michal,
>>>
>>> Why are the new function names non-symmetrical?
>>> efi_var_to_storage <-> efi_var_from ...
>>
>> Ilias was asking about these names in v5 review.
> 
> I'm sure he meant something different from what you implemented.
> 
>> I am ok with this with a small nit.
>> Can we rename efi_var_read/write to efi_var_from/to_storage? I want to
>> make it clealer what these functions are used for
>>
>> With the changes above
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> I think Ilias meant to use:
> efi_var_from_storage & efi_var_to_storage
> and not:
> efi_var_from         & efi_var_to_storage

You are likely right. Let me fix that.

Thanks,
Michal
