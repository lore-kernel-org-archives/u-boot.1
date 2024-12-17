Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED17E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F323801FB;
	Tue, 17 Dec 2024 12:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kh05ANWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A997F8021A; Tue, 17 Dec 2024 12:04:02 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8599E801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZf73iT4nN6mQDphG/I3ibk+lrVtHJ2BqK6CKyW1StnJnB+09rAy0CfB5NXGhsseG+Gkj1I/5aDZOS4ZEGjTWXuUt1KmiuYtgTpxQgQEO+io2PJM2QM1996u89fNhhl9Az7GdGD0dA//4bVFwudbu1QvVTgWygzzcn3lEZFYOhLXD8uq02tN4glOR2aGcvB0iZKZoMHue1mXl1Jldu2KmTsbxfbaqYOgmJmQRPZ4i6z9zJa6PQfF12qEnMcZOquTmSU1TMQ4RcnJgD4zbhDHkV+/9s0x8Mod0DpHuWFlO61m76atFM7iyLNLUCa7y5/4sjlSXNbsoiup6pX+Vw+2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMl0N2q4RFmaGODk2DjCpi1n6iVKGg82qGOZgywtSQc=;
 b=ipdZ+m82V7dP4BSoHMka0GszdzyKugxriV54eQLnq8JLMcHaL9FYC6gOrKeADv6uUUrRCBZZFSE12j5QETBlNMMB2cfdwA9uvhaZRsJvP0l9NDekZMN9Jg02vjmMImkwA3tX17sfSf8PO1HhhrFpgPt+9Msk++LqzcXOvZAyonzkZZPYHs0NlpyRShaqmfK9wdl+jkS//Um21I0GnQbAa9SE6j8w1ldOHUBilhe0ZnB3Zcaldr8nuc4iAggs1ImVeni6CICyJ1ae0qj0fQErbaxOiDjtKq/RuToDyniNpDu8bdzQFCgwTEVF4XDN6zdG63rRtFsS5oYahu7+qBLhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMl0N2q4RFmaGODk2DjCpi1n6iVKGg82qGOZgywtSQc=;
 b=kh05ANWlwYHpOGFycEpIFtbaFNb8VvNDeZG80VyuIcvmps7gcGqEFqjhmLjOV6G29z1ukJ2MRxZKhavaR2zxplnaxsqWBclpzVENokwHIZBr0VwrU0d1o5PxCB9VFRwqT4OHWm494gcdj563111A5XbLEURR+kX2rYcOqSGkH2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 11:03:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 11:03:57 +0000
Message-ID: <7f67c021-97db-41f8-96d5-66c56ecd2e48@amd.com>
Date: Tue, 17 Dec 2024 12:03:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not use hardcoded address in
 do_zynqmp_reboot()
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Charlie Johnston <charlie.johnston@loftorbital.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <3e5c6ea426b81cc73b90e6425764e41a98deb2a6.1733735454.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3e5c6ea426b81cc73b90e6425764e41a98deb2a6.1733735454.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0242.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f86833-012c-4405-9651-08dd1e8a80ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEd5TnEzZmFESGtTN1hNOGRHbFlPL1Y1bFZvcldwbTBkT0hPaGF1dG5PL3Bq?=
 =?utf-8?B?MFM1cnBkT2lScVlMQjl0N21sSkgydENzNkUrSWRwMXFXbmluSEJ6RUlWcjRI?=
 =?utf-8?B?eEVHdXlUcTVvcDV5YTdNbGp4akh3NFZ3TEJhbEZPYXBiREt4aU54SEVjNFVL?=
 =?utf-8?B?M3lIakVoQm9YTUtjR2xuY3dRMGswUE1ldEYwUnFOOU11Z0NrVVZmRSs2cSt3?=
 =?utf-8?B?N1c2NWxWSmtqWVhkMGVIV0FOT2FNN2txK0JTSUdDa1BnajcydTNzb3kxV1Jj?=
 =?utf-8?B?TEMvb3RJV1JiUmhnZU12Y2FLbEZTa0E5cEpPeExQWitHMTFxRFF2dUdiczhi?=
 =?utf-8?B?Y28yV3R1UkhiN1FyaUJQeHFNWGY5Z3VFR0huTUx6NklXSE02QkpPTFNsUEk3?=
 =?utf-8?B?ZlozYzdGWjIzZDFpWFhyRERrMmJTd2trV2phNzJVcmQ0V1ZoblRQN0UwVVM2?=
 =?utf-8?B?TlBSekZUTzlkQUpMaTl6alJaZkJGYjIwNW9ySDRKbmlwNXNSYVRGU1JEMGla?=
 =?utf-8?B?R0J2aC9DekcrNmUrc056TnQzcTlhcU5rTitEU2gzczNTbkhTMWVrWjdEeWl5?=
 =?utf-8?B?Vk1rN0tZL1Z3bi9RclFxN3Q5ampMd2pTRE81Y21nTi94V1orVmRZcUxna01Z?=
 =?utf-8?B?aERJUEVEOHpodzNPV3JjenBFRW56Q0lnUi9qRjN0WUhUOExsTjVpWHR5bFBX?=
 =?utf-8?B?Um5EMGIvTnpJdG9NSk1tcWVtckUxMWNuZmlVVUx2Wjl5UGVoY0UyQ21kL3BW?=
 =?utf-8?B?VjBKQW9UNHljb0lpbWZNQ0V0dU4vK2FNNVdzTXBvZTI5R1RVeXJVREp2c3Uv?=
 =?utf-8?B?U2pqdXh2TzZoTHVsTytHTW9nekhHdzNYcmlTZWM3dzFjcDNYWkpXU3B1S2xm?=
 =?utf-8?B?Z1ROY3BXaDdxU3dMTzNMczNhR2J1ZklBU29scEVhU3Z2dmxYSXlhZmNYRTdr?=
 =?utf-8?B?NmpVUVhiMGVDdGoyNTRZdGVidHF0THZPTzhjVkJnQXJXd051V0pHMUR5cW5R?=
 =?utf-8?B?NlVYN0JQcEZZaE5mUVIvQm9TcWF6ZjdjRUUxMEIzRndTczEyRkV2Y1JmdUNQ?=
 =?utf-8?B?T3R4MlMzYmIzT05meDlJNG5VQjQ0L3FzTWE4Y1ZpcnAxN0Q1L0RXQjFvUEd5?=
 =?utf-8?B?M1MvS1ZVbUxITFozM2pzWEFBaFRsMTVlZC9OUGVTajBiUWNSc3hIeXlRZllx?=
 =?utf-8?B?R1paNVh3UzlKcFMrZzdDaDJ0dkxoS1FWNmlYa1NmbFhQQnhNclFPLy9SYzBH?=
 =?utf-8?B?TUxtWmJOZTBNOWpjbTFRT0NGbFI3aXJxNmZFWnVlMjlEeWVSKzZPb0FvYjlk?=
 =?utf-8?B?anUzeEludlRzYWIzUnAxd1Z4ZGs0akNsbHhHYjRoWDNXT3lJVk0yQnVhSmNI?=
 =?utf-8?B?VUl1dnFYN05ZaUE1aVdqVVZBc1BGWFprVXVuWnlEWjgzaC9rYktiRnQ4WTVK?=
 =?utf-8?B?SE04UmZBSWpuT0dWNHM1Wm0wak9iUUxLUUtCbTVzTThCL0NVTnFqVEpTOXAv?=
 =?utf-8?B?aXpPaldlckhYTGwva3BSYnkyWFZsYnM1bUxwS2NxOG9WaVQ3aFdRbVkyRkVo?=
 =?utf-8?B?M0crRE1SeXpOcDhILzc3dDkzcFNCdW9VMFpkWjhjaUp5Sm5jYVFsc0J2OEww?=
 =?utf-8?B?V2U5NHJzNmJ2MlZ1R3NxTWU0ZlNKV3BEK0NMNjhPd0I0V2ZUYVloNWx2N0JD?=
 =?utf-8?B?dTk3NXdaUTFHNkhMZFJabkdxUW9kS2g5NWZwbDF3VytHUUluQTNwbGJNb3Y0?=
 =?utf-8?B?SUdmNittNVQrY1NMVVVkRU1JQmhVRUtzZ09vYmY3MmhJdGMxWU5TNHhocG5B?=
 =?utf-8?B?OC8wN3QvcUl2aFErdEZKNkwraG9FdEVWbDRBRStXaVhzWjNrRzFORmVSTmhR?=
 =?utf-8?Q?jjz5NKrD9FMTv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajRwYVhIR2xuQmlwalRSVkprS0tDaDRUM29EYUJneEU4bzdWSmN4R092SmFM?=
 =?utf-8?B?TUtnaW9TUWs3NE1INjRQVFBmMzlOYjROUlhQMURxVmk2M3JEZkVvMlhJTWpl?=
 =?utf-8?B?MjZtYTA4UzNQNVd4bi9ucmZHVitLZWU2bjFXTUNIVGdiVTM3Lzc1c2w0TGNY?=
 =?utf-8?B?TUMwNWZnZjl0ckpFRTMwTGY2WUhGbU5udE1Sbjdza2tRckNLaWtFTkdyN1pS?=
 =?utf-8?B?LzFOQkhDa2lSZzRhdnZyVHluQnhsbHdrNENGUCsrc2dFNEczMExLNTBSbEla?=
 =?utf-8?B?MlptR1A4bkhjRUd3clJtWHNhdWdoR1V3TWRPWEJpdFhQOGxMN1hEQlp2c2Ex?=
 =?utf-8?B?cXE1ZlNobU9xZDZpOHZ4TmJieUxXTUtqVUpMbGpEWTlSeEExY05tbnpDejRQ?=
 =?utf-8?B?UFlONzZkaGFXSnZnbkxJai9PT0Q1TmU3cHNqREhUaWR4ZVptZWxSMlJUdGdh?=
 =?utf-8?B?Vk9zbHFOdEFrM01Za2ppQ0IyVnlxK29sU0plSm4xTi9OMVZ5Ky81djk0SDM4?=
 =?utf-8?B?bmNrcTFVZ1pSMzZiSlBaMGt5bllPTG1qYXhjYjBsbG5lRUpXT0pYSkFsTmxs?=
 =?utf-8?B?akF6aW1EUi9EdFlHYm10ZlRVK1ZHQjhDdS8xdVNMV0U5MG1BRXlZMm1jcTd2?=
 =?utf-8?B?dWNJOWFMMTA4eHE4VmFpTFZWTmpTZE9pVmdpVzlEaE9WTGFaUDZDYm5HUjhy?=
 =?utf-8?B?SVJGOFMvZ0pXaTUwK0xrdExaYndRb214UU1mNEd6bjJJdHBqdmVVYmhxMGF5?=
 =?utf-8?B?T0U4b0Jla0RPK2w3aTkydjlwQi9oZzd3WVJFOGg5UlRLY0VqZmNwT3lScUZy?=
 =?utf-8?B?MmhsWGhCWDZLVEc4bW15RVUrS1hUNTU1VmRMUkpMU29WaTBwZGY1QytIUWxO?=
 =?utf-8?B?TzhGRHdyZElxa2NpYkpaZUJGWENObjRWblZNdXFiUjZWZ0JMQjFZVUFDSDRx?=
 =?utf-8?B?QkNsTzExc0tRRXJJVXErQTlPRzUrYU5hNUVNRzZNNCtwbXNEbU40SENGcEwy?=
 =?utf-8?B?T3g2R2dOaCs3TjFCWjBjQUwvaktreTMxZ2twUHNNWWE0QUhtcTFzNjBPa0hh?=
 =?utf-8?B?R1pZZDQ1ZTJtdXhLTmZ4bmpNaGdYSVRHWG4yWlAySUZDenFOMGlHRWlSYjBz?=
 =?utf-8?B?ZEk4aGtKeUJHZnB0Z05QS0V0eFZzNVpnazh5MS9oSTRHOWlSZlBoVjFQbFkz?=
 =?utf-8?B?Smh1TUU2UmJzYTl2NE9MVlNjZXZwbFJnSlMyNHdWcVY3cm9UZ1VlYVdQdjkv?=
 =?utf-8?B?Qlo2NFhFbzA0bjhCNEE2ZFB2Q3o5bXJqWlpWdEd2dXZwQ2JZd0hsNEtheFlC?=
 =?utf-8?B?VHJrclkzZG5OTkx6WkxDaFQydmlzNnVwdFJ4UnBHNUF0Y1AzdlYyNWwrN0Iw?=
 =?utf-8?B?VjJ0djZKb1ZMaUVLTGFKMHRuN09sMnpIMU00M1M5VHNVVk5CajcvYTMwekpC?=
 =?utf-8?B?cThiTlRpY2lCU0liSms1LzlnMVVpaFlGYkxpa2s5YWY0RVgvYldoUHF3QjNE?=
 =?utf-8?B?eUtSYy93M3Vqa2duZUtuQmY3RXNJVFU0NFdsamtaT1JVVmFhYk53ZXZ1YndQ?=
 =?utf-8?B?eDkyRkxvMVFBbXk4dEhYWGxYdVQweGZIZG1GTnpKK0Y1V1owQVpTSHBDeW5j?=
 =?utf-8?B?Z0tSQTd0c1NtblBwQWttdXlEVlBNM2FLK3psdk5mUlFWQW45QkgxRCtlWmdS?=
 =?utf-8?B?QUFFTThreDdZUWMrS1BHaDFkNmlpWUpDWkZJSlZ6b0FwNDJDem0vdWVxVXZC?=
 =?utf-8?B?THJQczFETTN2SDFSbHJxcnVkQ2d3SmcrQzhwNWI4dHE0ekJOTGR3YWlBZHpS?=
 =?utf-8?B?dkpXZU0vMis4T2FRSGNLODIzZjlWck1xVXFqTFUwTDNiSUdha1Q2ZERhb3NT?=
 =?utf-8?B?R1UwaXExWVRIcTRIT1BETmtWczRuZFBlQ1pEQXZuclEyWUZ2MndyenRtN2l6?=
 =?utf-8?B?N1lYWk1NSm1hMWZPVkZNUkFUTFEwdXJJdjBXcVBWK0FjYXJnZ0dMOXpMaC9P?=
 =?utf-8?B?a3NLcDgwQW10T2licXhiN0tXem1ZSXEzb29iNUo4VEc5YW9VVVhUZFJOMGU4?=
 =?utf-8?B?N3M3WUc1RjhQQ3JKdUY2RlRoNTJqUWVPbGNtT2lIcFRXRVpqSWxEeEZSaytW?=
 =?utf-8?Q?0RLeWfLMlSGAya5kxk7b/J2NZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f86833-012c-4405-9651-08dd1e8a80ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 11:03:57.7503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsnD4Fcb2MWVJ1N4t5Ju6TJPLAwZmh9CwGojKB2xL7guQSxINFlxJ86vITpl7/vb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
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



On 12/9/24 10:10, Michal Simek wrote:
> multi_boot is already the part of csu_base structure that's why use it
> directly instead of using register offset value.
> 
> Fixes: fc001432e5b0 ("arm64: zynqmp: Add u-boot command to boot into recovery image")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-zynqmp/zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index 8ee25e4c3161..3aa218545bba 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -349,7 +349,7 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
>   
>   	multiboot = hextoul(argv[2], NULL);
>   
> -	ret = zynqmp_mmio_write(0xFFCA0010, 0xfff, multiboot);
> +	ret = zynqmp_mmio_write((ulong)&csu_base->multi_boot, 0xfff, multiboot);
>   	if (ret != 0) {
>   		printf("Failed: mmio write\n");
>   		return ret;

Applied.
M
