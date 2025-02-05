Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E003BC02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 401E280BAD;
	Wed,  5 Feb 2025 14:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3FZ2lJkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320BA806C9; Wed,  5 Feb 2025 13:42:25 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F6A80562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 13:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrAeO/aPPr6/4tbNaTlIWavWGC9QJCJN3oUKopxpqQKS01aSHG8XTvTKG1kGqASGxbXouZoNLIJgjY4EswUGaKi1sK9Qqs5EE/oSHkClHI2wCyish0YoHOmP4CV9a54eGV+AnhwndsY8cWL4Y1rruzWZzRPsdngW1dY6PqyHjklWNnIngN/Pgf77/eJiRQI2QH1uqjgezAIi/odgiE0xwDOtAwcf5slpbnM33zsBKcrQo9PO0f4EyPYJlyAjTaNd4QRAWIrgQ6FQwAYwQ12JvcikI0UInQ2/Wkgw3rt338VFWXZ0TugRXdUv7T9tdYM5pj7fenwzn9nj10Cz2L4a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ednUr7RmX8eA8e0hrlI0X6KZavPOg1qFxdUAXgvFvpo=;
 b=iS4WylsyrImUJrDEnm4sZ/GqClPPp/wCk1hCdumcI8sxsNWXK3U/ndmhBs00IlAiJOP+WtWM8faDdS33HObwJn/HWQF3R5D34tmWpWmBaXHGLC+jyeJK0ODOMbRCU0kh4gJl1uq1I1mXdgwttq/CnRa7IupXjBIVcT9FHOquutvLL+PY5/Zx/UmWI2FpQnRsVyj4alIK+lczRbV6XNaQIRsffWDlPnNv94pDpzDJ5zdDLk/Wbw90ZPcDRcu13MLyLg/VdMFrfG7pD16Se5LqmWTC6503R8ekEVcFR4tiJn6qIKL7SCg8L0LufAsX6ZJ6bHwg6PSMyn7Q5Eb3AOOWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ednUr7RmX8eA8e0hrlI0X6KZavPOg1qFxdUAXgvFvpo=;
 b=3FZ2lJkzm0ZGoxqdh1JHAFHam/nEgYKRLq2evFozdNHkjp+rJmYuJcyerojzg2pZfsnz76FS1nGSpJ4kJgB1maqI9eUpgD4iC5Od7rINwc4D3vCSx5H2EfDqdWkLrmblg2R5QIFNkUvkcQhyJ/GZvNWVeXkeqWZaf16q22CBTA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 12:42:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 12:42:18 +0000
Message-ID: <6e34f324-f9ea-476c-854d-92574f35ae9d@amd.com>
Date: Wed, 5 Feb 2025 13:41:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Evgeny Bachinin
 <EABachinin@salutedevices.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
 <CAC_iWjJnGGLhSyZFyF3jju9Evq9hY792jsDD4bL33H+6E2x9+w@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWjJnGGLhSyZFyF3jju9Evq9hY792jsDD4bL33H+6E2x9+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0116.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: b301489e-607b-4c76-e5d4-08dd45e28684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzMzZEpCT2pMQTdheDdtU2kvYTlvcDJrajMxMG1FKy9DVWZ4Sk9wdGd2ZGgz?=
 =?utf-8?B?dFBuRzJkZzlmWnU3TVYyM0hqVkFpR1ZpZ2h4S1BEOGR2M09ad3RKc3dBRkdR?=
 =?utf-8?B?NDFzcVlqYXJxbW91RThOc0RrUEJDOHhsbFgxNEVSMzA5SXk5c25Gd1lleGN4?=
 =?utf-8?B?aEF4N293eDV2bjdMOGk0RXZHblhZVFRhbkFaUGI4VkhVTXRHb2RxSDVML2s5?=
 =?utf-8?B?QkxvQ3RIT3RiWHdBTFhUbGJXYmVMWkZRMFdTaWowTkY2dlZZbWZCM2YxOWFu?=
 =?utf-8?B?NVlKZzN6T3Z2ZmFtanY3WFhsdFUrMUVqK0IyMldKRko3dnNiVzdOUXp0SWlJ?=
 =?utf-8?B?dSs5eXo1K2hmRDhaU0YzVTk2U3MzMytRbFBTT24wS2ZOMlJZY3JTK0QxQ3dn?=
 =?utf-8?B?SlQ4YWdqdFYyR2MzcURJSWVoZ2dYak56aGRnK2J2SXM0bXk4dFpsemVVcks1?=
 =?utf-8?B?czl2TmNyandUcUs4SndWZWFIWWg2aTZhMjJrY1ZPOGdyNzMvTmxzbHY3SmpC?=
 =?utf-8?B?a3pHWmhmRCtMK2dZOUJJUmlSZmN3bWpOL3Y3YUk3bU95M0ZhK2RUNnlvWXRW?=
 =?utf-8?B?N0VtUmZhVGluMlpqbmpxbkdlM3BsR0JxanFjUUhqVkhsOVJYRTlHSE80ekRy?=
 =?utf-8?B?a0JKa21iTjNacFpDZXUvWVk4bzRVZWwxRDVuV1pKK21OZC9rQ1VCRzczZHBP?=
 =?utf-8?B?ZVpXSmVMWStQZkg3Y2cvOTdrWU03QWY3OFJNdGE3UWtxclhUZnZobTB3eElP?=
 =?utf-8?B?eXlkVko0UUJmcFlCaXBiZFZZZG82VStneG53K2VSMmtMZVpYOE1Vd2xiSXh5?=
 =?utf-8?B?VjF6UFY1Zm1lK0dmdk5QelpyYnhJSU16YVpmU0s2TW5waEcrQjdPWHZDY3dM?=
 =?utf-8?B?a3ByQkNDUjZiWG1XZkovLzBlZWNaTHdJTFBiSlE1Zjd0QUVUbGZlMitmdUV3?=
 =?utf-8?B?WkEyZWI2dDRjd3ZIWE9hR0hQcFljVDliSmladjI0cGJxbE0vTExXdW1aQnBC?=
 =?utf-8?B?dmRIUkZWbnVtL2ZYYVlSYkpJVC93OFZoM1loY29NQldkb0pKK0JKb1B6bXBm?=
 =?utf-8?B?NXlGb3lPZEJnVDAwSXdPUk1ORTBLNUlleEx5dFAzdWZoQlpnVEdGdTlnVFFa?=
 =?utf-8?B?SWVqWnM2Z001Qlo1M2dnTUVsZG9za3NOcEtUZVFnWE9HbU5NWVpoeitXU3lM?=
 =?utf-8?B?K2VvU2REakZhbzd2eFM2QXZuelByLzRCN3VBbSs0VzF5MklwYVhDWFN4bmdZ?=
 =?utf-8?B?a1d6VjdLMVdremVkd21MQ2hiMXBOZ1M3NXIzeTdpN1dlVkxpTUgvNzdCV0Zk?=
 =?utf-8?B?WGU5eHl1QThxVytkNEUrNFhtUlJ1SEpEZWVRWm5pcHN0eFB0OHhUSzlIcGh1?=
 =?utf-8?B?SzRaY1BWNXVkVW1vUGMrR1JUOUM4dnZhRXc2KzEzaVdKdTZra0tIc1YwOU1t?=
 =?utf-8?B?a21SWTJhTkVTcEFWWVFQLy9IaW83ZkVvY2NnNjExdXZabWFNN2Y1bGVTZDVF?=
 =?utf-8?B?eUdwUDBRTHlISitrVlNSZVFxWTIra3ZxQ1N3N0k2SDRqVWxQODF5Tk5HcitJ?=
 =?utf-8?B?d2pWMEpob3FyOEVqYWhZSldYb2N5b1BObzJmSGU4WWhXc3VVNU9aOTR1NGgy?=
 =?utf-8?B?bDNxRk9pRjk0MVJmOUFxZ2ZmMUFXbiszcEs1S0dadUtHYVUvR1NhSktRQTBj?=
 =?utf-8?B?MzdWK1ljbGs2bWlndGljSDdPb3JlYjFkaTBoS1ovMXk3TGg0Mm92d0lnMDcz?=
 =?utf-8?B?TFpjVWloSVc4RGpTNFVIODJHWFQ3SDUrSkJWRnV0WlUyRmF6UVRDM3NQTXNv?=
 =?utf-8?B?d1A5R3JJK0hRaHZha1hRMFZ5aGhiT3h0VDR2elNMTVluQW5RakdIMTRMcXhZ?=
 =?utf-8?Q?kjWXSMGkzqdZu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRxTkl1ZjFSaGhYa21INW1DcTAraE5EWTlxMFpGNjMybXBIOW1hMDJ1eXhT?=
 =?utf-8?B?YjBEN2tVUk4vdE94bndpQXBpSmljRFR4aHpCWjZkQUpQcitOeDZ5bTlESzFm?=
 =?utf-8?B?RVBoM0Y4R0JHUUtnSHNVbjdCMkVUaDVTOHJ6WDRDMnVrMUI2bG4xdkJMQ3cz?=
 =?utf-8?B?SGJ6WFYxbzhyUWw2QkVzOWEwUnNEUHQxWlBoRFpTVHZJTDZRWmJNK2Z5NkN2?=
 =?utf-8?B?Y0c1VG1hTlhwNG5BKzAzTzRNRjRxYWl6Y09paXp4SDBCRUdmUFA1VWVrckNy?=
 =?utf-8?B?ZW00cUQ2VFFKMmY2N01KT3dUQWJVRUMvZU9wdnVpRW44SG0veGZJWnpaU1pZ?=
 =?utf-8?B?ZkV2dndqVDhyc1JuODJsNWpXRFZZL1JpNW9XOHR6UHJ5dkFYTVE4NzZrRGdD?=
 =?utf-8?B?Q3l2MWUyNGJxTDZlU3NJa3dmOUMwNkhZN3hoZi9SUzYxRnB4bXZaQ3RLQyt4?=
 =?utf-8?B?bVpPekNtQmNuVWI2b1NMYVJYU09ZdVExM0NNSkk5aG80L2VmcXBnaGZWTm9v?=
 =?utf-8?B?TlUvRlBHTUl2cG4rajhYQWltNFhuc2NraTdXUGZQVEZVYUZJRnNuUGNQRXM1?=
 =?utf-8?B?endVRXNrc3pHL05vUjVmQU9XTXhZZjdXV2htcHJwZ2tVR1RPeU93cFJyTDRF?=
 =?utf-8?B?TzlmMTRtSVdVc3QzeGlYR2Fvb3VSclFOeHNtcXNIZ3k0dWZtSytsUmJ1UHpY?=
 =?utf-8?B?Y042djkxa1lJS2Z6Y0p0a211dGRPaUJHdjNveUNaUWhGTWpCQjNjQW9acEc1?=
 =?utf-8?B?RVJuWSt3MHYyTVRGWnI1RWE0VlpSek9EM2EwVkd0SGx3R2hTR1ZYTmxweElC?=
 =?utf-8?B?dXdhV2gvWGZyMHpPQXA2S1pYYjlBS3J6VUhjbkJRd2ZMa3YyVExpQmgzWmVM?=
 =?utf-8?B?cWxDMTZqMGs0cm8zUlNKankwZlZ0Tm1zcGFlOG00TlRlSWJNR3NIRGdEdHo0?=
 =?utf-8?B?enFtMkJ4akJWUnhGeWwwT1ZJeko4REJETjg5M3JJOW9MMFh2ckd2V2RXNk1K?=
 =?utf-8?B?Q3RBVWxkdjk1d0VySktJWXF6ZUEwYXdsMDd4d00zOWFsWFpYTjJSallyQmRp?=
 =?utf-8?B?akR0ZUZXbGc1YUFYVkRBdnNvMzZKZjZoNlE3dHpyM1gvb2RFMWtFQWh2RW9W?=
 =?utf-8?B?S0ZLejNzWGllQ1htVXlTNjJ0eGxwam5zUFBCMytmajFrbUhKV2RrYzhwNzNI?=
 =?utf-8?B?cW1lbm5SU2FXL2VlanZLNkovdUxFUVpkbFFmZWVkZmlJQmZNOVJtV1M2YWo2?=
 =?utf-8?B?OUpta0h5eGJia0xqanVvbjREaGh1RGJTRG5VTFlUUEpCdmUrOUdHdkdpN3B3?=
 =?utf-8?B?NnM2TGgwdmxzVEtoVGMwOUY4QndOL1VTMUh0aFlJTHRRRzFad0pUUzJvZGVj?=
 =?utf-8?B?dWlrR0VqYjNKbGMzdUM5WUVhREtJOW5NWmJqRmNqNENma0VwVHlqS0ZwdktP?=
 =?utf-8?B?VXF5eVF3MGZSN0JGaUNwWVNFbXJ2d0piL0pnVFNuMG4raUV6TjN2VnBnZHNJ?=
 =?utf-8?B?QldIRmJCc2QxZW1PWlA2OXVCNGFjbDlEaTdtMm0vaHZxcE9vUk1TS0NOQ1Nm?=
 =?utf-8?B?NDJ6VHlRdzNpNUcrU0xOTjNwN0U1RU1yam5IQlZVZnlYcjhHaWdRa2tDdnAx?=
 =?utf-8?B?NGVyZXpnQ3FnU2NPUFZEeDFHY09jU1RlQW9vSWR0bUNVcGRDVzlTZ3J2SFcw?=
 =?utf-8?B?d2IwMHZHd0YzbkZpRjMxRjg0VjFHR1FTS01LSmdGanZhblZkT2Y0ODd0SU8v?=
 =?utf-8?B?UkdEMXNuNUhMei8wT2JMS1pjd3V2eEhUUWVzVlNYQVVRZ2xoaE1zNTJsSk9s?=
 =?utf-8?B?ZlhHem1QaXJnY2pzRGF2OERmS1psd0h2bHZLVy9PeDVvSU9wMnhBNUN4cklW?=
 =?utf-8?B?cVpxUHc2UGFTWWlGNFNzYjBzUHpDeTBwRnVWcXM5bWtWeVQwQWt1Wjl5ckFZ?=
 =?utf-8?B?aDhON3BIaXVKMllMVlBTdDhMUXA0N3dSYm9kNUk0TVA2R0ZaRDNQNWtpblAr?=
 =?utf-8?B?U2hMWXk1MElwalJIQm1lOGJvSCtsdnhnK3llV29vbjREakM3cm4rVFFBY2lr?=
 =?utf-8?B?a0tnLys1RlU4bGtXOFE0Q3JzRTJjUVFHNmdyODFYYi9xNnJIQjNLdTBlbm9P?=
 =?utf-8?Q?LtNYJgaB71LbHCtPFpS2p6GPV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b301489e-607b-4c76-e5d4-08dd45e28684
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 12:42:18.0725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCKz9hx8hu6oQIIhZaL535LB2XMnvFY8V72HxZ/edoofgibycfjSq8KDn3yOTcSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Hi,

On 2/5/25 09:22, Ilias Apalodimas wrote:
> I'm just replying to myself here but I'll send a v2 when the patches
> are reviewed.
> 
> I can add the linker under an ifdef, so u-boot size won't change
> unless a Kconfig options is selected

I think you can just do it for alignment not really big ifdef in the file.
Definitely this will be needed for our mini configurations which are running out 
of OCM.
Feel free to look at xilinx_*_mini* configurations.

Thanks,
Michal
