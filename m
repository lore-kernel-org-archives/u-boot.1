Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F28FEB4909
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 11:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9384F8367F;
	Thu, 12 Feb 2026 12:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iOsWxbWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C228483C4B; Thu, 12 Feb 2026 12:34:00 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD0280FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ7//07itrrvEt/Ao+wb1z/1yexQE3IH1ryVn0ZrUeAO5XGCLIqI11W7Iltxr1wiXvPLMfRt5Ti8CrE/TUfsPDkjxrd+FJL7SMmQs8ulAsJCTbIRIglvqcZgKwDHkJCil+EgtSGcRUyWGF9Arsp26SlaD+AUXHRE5wMHsSPF3zAz30iOxmfT5JUkythZrPP+T9vMYBxkPjvy+EofFgz9lLLSDdFZhSO10I9zJkjk3OWnOPwHDl+bO8mJVBimGkVR4zkR5BV84er2mXFH1qbqHL4sZldg8u5E7I+07xK6Zzj04dg2e6PetKio2hjabBYQLMGwmeTgz9QvPzxSrvMYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZCX1+zoRNPRsIeC8u6hD/irO9YOI0LUnmEcfxOhwBY=;
 b=UX9M58TIoGNMcP+EeTnQ/xiFu0b240y5vn/m4Awa6W6awbZKxtCEcyFpX9r61WhZv2MWvjNW0KG/m/++PJTXl/oHgHptiwDVAXkNKC3A3x6E3KPTfZahAJd3nnd9tLkRTnw5fmKvxC2HGBiDAEro0jxvIhkdPxuGbignf0NxbOz9mJdzYkeIibJ80jDO7KLJgUTsqwuGh6XRfGW2icFJOgWgmPsV1gu4pLNWfYiUjOEo/WVkGA5i83kkDY7O3QNqnCgzFmOx34scj3+D5jvljdxwfranlnNlIGgrZtGsmkh9vr7OFDS8nURe7Y/kah4Kh1W9P3O8Kd1dDlOW3cKdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZCX1+zoRNPRsIeC8u6hD/irO9YOI0LUnmEcfxOhwBY=;
 b=iOsWxbWPP8Mhd+sVg/3OnmX98AWxKAHOHaU4Ikbv1yfU0pmkuEV5j1JMoSALGfRJPO2lI2o05xvB7xF8NTQj4qtKQ4DFV/Rv413anxbfYU/h87dOLqE8N9m1uC9uzZFLoDLlvF/OfBjSB4HlzmSkYKqeTiDtqQq//K/z5RSjWUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 11:33:49 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 11:33:48 +0000
Message-ID: <efd4edb2-d01d-4263-9fe9-303f8cfd9581@amd.com>
Date: Thu, 12 Feb 2026 12:33:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gpio: Introduce gpio-delay driver and enable it on
 Kria
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, Fabio Estevam
 <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini
 <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <cover.1770105146.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1770105146.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:74::45) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: daa4c77e-7667-4661-f600-08de6a2a96c3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkV4ZjFQMDEzTTBpOGFPNE9TV2ozUlFmZ3ZCVzFyWmR6bXM3ekk0MTFwSXl4?=
 =?utf-8?B?TGZFd0ZxYWNjNDY0c0UvT2VVNEJXZHNhR3ljTFVxWUNVaXpDUTg4TFJvcS93?=
 =?utf-8?B?WW96KzJ6K1NVVi9YdW1QeHlwdHJ4SHdrakJtQWFqbDRwQ1Q4bmJjSWk4UkU4?=
 =?utf-8?B?K1VwK085dXI3Q3RqZWVqTWdjdi90K2ZCcDVnS0ZLZTd6S2lmWDdVZjgvdUNO?=
 =?utf-8?B?ZUpldm1aS0ZiWVNkUC9MdDROYnh4Tmo1RjJFU2Q0YXh5dEJLUWJGZTUvaEhW?=
 =?utf-8?B?K3U2SXdYMnAwRDJNYTlMVy9yVkRHWjZqeXk2VkhsdFM5bmZ0Tk5LMGRpU0dn?=
 =?utf-8?B?NkJndVgwZ0RVTlRQWWhjMEU1d2JFenNleXVkdkFXV1R1bnB3VmloUWNtSGl1?=
 =?utf-8?B?ci9YbTVuWXk5WERUc3h5R3JCOHZ4WGRyMzFoNzFJNkFOaGRiQXBTbWdONXZY?=
 =?utf-8?B?UHpmUVlBRjgrN3dmN0cvaU4zYkYyNUFTNHh1OURnTnRvdzI4NVpnUGtGMkw2?=
 =?utf-8?B?eTY1NlVUdE1qV1ZHeVd4VVNzdlREbUxvcTMrSzhmVHBLM1JRMXJxRTAxREc3?=
 =?utf-8?B?cGtpdkxyT1YzMjYzYXpJSXIyMTRuY2NsaDBOZk9EYmh2Uks3eFJKcXg5Vlo3?=
 =?utf-8?B?dnVTS09PM0o3MzRvRzNFVVVlbEZWelRxT1FyZEZYY2tqVURqWEN4ei94cnVl?=
 =?utf-8?B?WDhWd0FTQlNFbkZodU1Ob3ErMnBZSm5wZHczZktCTENWa01uUXFwTWRydWNa?=
 =?utf-8?B?RTVaeW5ZeWh0bmtMU1lVVHZNVFd4NWxuUFZtYzNkdEpOS3RKOGpGWUxEczJV?=
 =?utf-8?B?bHJOcExJbU50S3VBeElNclN0MElidDcrMG5kVGd6V0VreWdmd3JORzlwZzls?=
 =?utf-8?B?ak02MlFqZVhybHdvckpuTE5Xb01VYlhEbHBzamRkRDN5K0c2RGdKZnpza3BX?=
 =?utf-8?B?NE1WdWwvV0g4eWJCVi9ONXlCQkZMRWhIdWp1N25jek9lSmllczQzTHYvRUw1?=
 =?utf-8?B?d3NRbjRGamM3Uys3b3hDRmx6SUl5a0s4T2tweTAzSGV5eHVDMmtTNjI5Zm1z?=
 =?utf-8?B?bkhyMURyRlhINjZjbEFMYk52b3dPZktBUnhKdmhtV1cvL090Mk50QVo2NVRz?=
 =?utf-8?B?dGtwNXpTb2ZtQUQxbDVLQTJKY29ETEZONU15Q0laZG4xcXFhSkx5SlBEU2Uv?=
 =?utf-8?B?a2U2VEVtZW1JaFJKNmxsN2YzdmZQQ0g1ek5OYnRWa0Z2R2RnSWhHUEM0T3l5?=
 =?utf-8?B?bUpkL0c0cnRRdXRPU2VnWkJrMkdLL0hNcFV3ZGVrM2xRRUdkelNGMG8zTjJj?=
 =?utf-8?B?K1FZMFNIVmcxSDY3QkVJeVNNMTNGZ0lyMXo4aUJpL00zNVZTdHAwNEo1RE56?=
 =?utf-8?B?VkZGRjNEaG5KMENSempXMklzSUtaZmJZZStKK2xpWkxROTVsQ1Z1ZVhSaE43?=
 =?utf-8?B?OEZ1MVZFdkZsazBtLzlNYkZiczZFY2w2azdYK1hGVlhnZGJlSjZjS0I4ZERn?=
 =?utf-8?B?WldoSm1oeFVaSVJ4M2hoOXViMnUrQVRpUS9WdERoSnRJbXpNWEV5SEpoVkNH?=
 =?utf-8?B?U1pOYWNwMXloV25yR3ZWdzJUZTZlU1dXckJqd0VteG5haUgyNFpoQnNPTEFH?=
 =?utf-8?B?dlltTm9icmU4a3BZK1RKYi9VbXRtek45dU5zU1h5ajRvWkJMcFdtdU5PRzFz?=
 =?utf-8?B?YXplR3M2Y2JGQW1oUDZESzZmMHhnRnA4MzYvbWdSME15L3hBRGtxSjhpV1Ny?=
 =?utf-8?B?WFhOK0J5Wm5qbzFBQlJGMDBtSGRmaVJyT3NGZmlxM3ArdDJkK2k5cDVHa3VV?=
 =?utf-8?B?UlBPN2duTGZuYjh0Q1JBMGdkYVR4Q1FEWUtlRmE0b1dYeS9PU2VlRFJjbGlv?=
 =?utf-8?B?MUhMZTFaREN6bXZvRERQYnRtT3JSYlIxaHNTVElHNnpMZXEydlg4MHZxaURJ?=
 =?utf-8?B?d09jblplQnJFUFBxamt1cXhtQkoxRVJUdG0xelVsbVlIOW01NEt0Qjg2QjlI?=
 =?utf-8?B?OEtLOXJuV3RRa1JzakVvZWFma2xOLzZPNE1DMFdWS2NRbWdBTkc0cmpnOFdC?=
 =?utf-8?B?Vm11SjUvbGVTR1UrdG8xRDFVY0tmQXVRTzM1TGl0NVoxMUtJb0M2eExNclF1?=
 =?utf-8?Q?owG0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rjl6d1hTSVNSbXhKbkZZeVRqd0lTVmM3clM1b0gyblJIeUgrY1pka3NSYURG?=
 =?utf-8?B?TkI3SnUrVkhvQXBDbkZheEQxaGNQL09JMU1Sd1pvQjN2YWlNTXpGRk83aytG?=
 =?utf-8?B?N0lYR25mdmtvbSs1djVubzRheGo0ODJHSnFaZmhIN1c3L1F4UUY3WWMzSUVB?=
 =?utf-8?B?b3hCZzdKSWtwMFIrVmN5Szh0V3FWelNETXhJdXF5RkFGVXhpOVI3OXQwWjNH?=
 =?utf-8?B?aVhwY2xFd2hZNlM2TXNqNmQyZGJaTlY3SUVpUHdKd0VTSTkwS0VHanZtQmIr?=
 =?utf-8?B?OVRlL0s5OTNicjhndk8zY21QcTMyTFMzMEI4NW16N3N4MXdGNVZhQ25DbVFI?=
 =?utf-8?B?UTFzZ2h6NHIyamtSaGxaWHppSUlCVWRaUmJ0ZElyVDhHbXBlOU9mRUxSbXR6?=
 =?utf-8?B?OXJTTzRHSnNWdlJqdm5kcDBUWkxVaVhlUVZMSEc5SHE0VUtxNExjdnBhYWVY?=
 =?utf-8?B?RmxUTllEOFZIV0pxSFp0NFFsYS8wM29ZMWxVWFNvNTlvTGFFNlFkZ1N0U1V0?=
 =?utf-8?B?OGMrMFhYbUNBVlo5WUk2M1lvRU1WV3JWSTEvdnV4T0RxZkVGS0FCNVoxSFVw?=
 =?utf-8?B?THh1dUo4WllIcndqeTJUYU44aEcxZUhxdm1MVnJnbmduSUZBNFpZa01oVWhX?=
 =?utf-8?B?NStDY2s5YUd0aEhyalg5aElpUmxPMUNPNnkwbTVDaEkwYW1pTFA5eldLNnBZ?=
 =?utf-8?B?ZWZhMHVWWDlwK2pERUtscG4wUXBVUzhRRm1KcHlYREtWa2JRMGtzcWEvNXY4?=
 =?utf-8?B?N2s2cjBwWGFVUXpQekd5UzFqaFg5OHdvRFhZc01pR1FvZTRQdmE1MGJOa1lL?=
 =?utf-8?B?MVRIMFlZRFd1OExSR05aS08wR2FLN1lWTWR6Nk9haTYrZmx3NTk5V3VJT0Ex?=
 =?utf-8?B?UlNNOU05NmJrdGt4ODR6SzVvcG9pNDBsVzFkWEt2d2YrR2JEb0xhaVNEL1pB?=
 =?utf-8?B?N3pTN2NLdURLNmN3ZDV5TlV3bjdWbmVuZWxjNHQ3dm9SK1k5OHlEVzZ4SjZt?=
 =?utf-8?B?QjNTd09OZ2t2a2ZVTDNnVTJnNXFGbVBPRTlxK2VxbFBDRjc2Z0xoa2l0T1pk?=
 =?utf-8?B?c3hoVlh2WmdTb1R1SkpDMTVzT2RDcEdTY3ZXeUlFVmNVZ1BSNU1LOStUL1lW?=
 =?utf-8?B?c0ZZRE9YU1dxQUpTZUVmM0RIbE1UNk50OTJyT1ZCV3ZpeGdDTkd5akhZQWV3?=
 =?utf-8?B?NnV3VUV5ZmJkQ3ZLcFVya0l0NTRWc0F4d0tlaXFyOHVpV2F6QzVQUG9UeW5M?=
 =?utf-8?B?WGlsd2ROUkFqTlR2RmZ0WVF3L1lqNW1KdnVyUU1RbEk5dVZoajRTbEJDTnhz?=
 =?utf-8?B?K2FOd3BGbU9CdjBydjI4NHU1YUZQVEl0d0FBRmhwMmxPdmNxVlE5ZEIzeWNr?=
 =?utf-8?B?eDNaZld0RlFmNUJTWld6dFhvVnlrU3p3akZQb3JvczkvRFNGakRqVGM3VUYy?=
 =?utf-8?B?Y3p2M2VHWnQrN016VjlKaUpDTDhXWSsrZHFkaGVvVE94YlNmWVZ5ZVFtMy9h?=
 =?utf-8?B?K3lldlBVNVcwUy9aVFFTb242QWQ0Vnk1N05aVDlWMlVHMWdHQU1wVVlqbUlj?=
 =?utf-8?B?ZEpHZGtOcEg2ZXk5QkVpTkRjUU1MeUJpa2V3N2Mybi9wT1h4a0Y5a1dabkIw?=
 =?utf-8?B?T2xmTTBFdHNpTjA2QUZKRmY2Rmh0MW9pcnlGUUtyOEVnUFJTU0xIU2N0Y2Ni?=
 =?utf-8?B?S3dtUFVLLzUxK1BsZkh0M2ZzN0FOeEs1THpicXM2ZHd1Q1l4YyttRU5sWDYr?=
 =?utf-8?B?R0poY2VLWVpwSWFUa1BZU3JwYVFiUGRFa2cxTmtIaXdoNEpZQkpIUEFjU3Rr?=
 =?utf-8?B?YVg3dG1tRmx5WW1ZZHYzWHBLYXh3djhiT1E0UkFEQ0tnM1crd05xQnFyTHR2?=
 =?utf-8?B?ekY4ck9vaitBNXBKdXBSNWlCME5NTFFDcHQyaUhreEVuandReWVBTDJjajla?=
 =?utf-8?B?VXBFcTJIc2JZY21ITHZBcUNOMHdleWUyVHErdmU1YmpHUkFDa3JSVkNMczk2?=
 =?utf-8?B?Ym14WFY1M1NMRGVKVVloajFEbHFLMHdyV0tnME5mYkY3QjVPdjFHVklPMG56?=
 =?utf-8?B?TDh3d1k3SkpLVFhYS3hhSk1tRTFwYWZtdW1CSlVJVnBkMVhRYWY0SkpIZkdx?=
 =?utf-8?B?eUYrU1Z4Wng2bDZwckdIYk5uZkpkWVFMOWNCODY4Z3E1ZWp0UjRMNnc5a2lN?=
 =?utf-8?B?dnBlTWJKTG02dEZrbzdHaEJSbkZWWEo3elAwWkNBVEpyazhTL20rMFBGYUFo?=
 =?utf-8?B?cUdJRlNUdjYwT0lMZ3F6VXFxeWFJMmloVUQ4ZlkwLzRnbDlqQUIweDBNcDlt?=
 =?utf-8?B?Z2pxWkRXMWlJMDlFSkxwTERwMGhVQVhCb0NpbTRkZkFOR3VyUjFHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa4c77e-7667-4661-f600-08de6a2a96c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 11:33:48.7312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJGDE9+a0/bvnT2n7V0BpV4fe7pOo0BxJitpcgO1mb2uDfSuNKzPbSMqDFSO5z1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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



On 2/3/26 08:52, Michal Simek wrote:
> Hi,
> 
> we need to wait more time for getting USB hub out of reset to be able to do
> initialiation over i2c that's why use gpio-delay driver instead of changing
> waiting time in usb hub driver. Waiting time depends on gpio wiring on the
> board which is in some of our case going via SLG programmable device.
> 
> Thanks,
> Michal
> 
> Changes in v2:
> - Check return value from dm_gpio_set_value()
> - Do not use GPIOD_IS_OUT when requesting gpio
> - fix commit message
> 
> Michal Simek (3):
>    gpio: Add GPIO delay driver
>    xilinx: Enable GPIO delay driver on Kria platforms
>    arm64: zynqmp: Wire gpio-delay driver for USB hub reset
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso |  13 ++-
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso |  16 ++-
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  16 ++-
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso |  13 ++-
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso |  11 +-
>   configs/xilinx_zynqmp_kria_defconfig   |   1 +
>   drivers/gpio/Kconfig                   |   8 ++
>   drivers/gpio/Makefile                  |   1 +
>   drivers/gpio/gpio-delay.c              | 139 +++++++++++++++++++++++++
>   9 files changed, 202 insertions(+), 16 deletions(-)
>   create mode 100644 drivers/gpio/gpio-delay.c
> 

Applied.
M
