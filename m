Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EACE8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 15:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C61F83C39;
	Tue,  3 Feb 2026 16:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="klPjZQ1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352C983C5E; Tue,  3 Feb 2026 16:32:44 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB57383BC9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 16:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbEPfiFmKiN0mfYYGz8bRoRiwCUa/WvyuRHWZ4qGb/5AfGrybFrZaPdiQOXcqhIMxhcxUiLPvM6yytTS+4AK6fYxI8HQX62vBB1Drjz+nWUePlagl/M/Mi3bMrBqlUpZylWHZAJHqV7s5NrbA71A+5T+e4TpAhCj+elubkvmg5CxUI9an0P4Jektxxkdri65ZGevcW1qh/LJlQX9PXsVEcM+eVbWtDXSgijjE4r9ob/wZ1Km4H3XEg66VnXawm1LBapmpKB/mXzgU5WPhb3NenjSnizFf85MXFMofuACAnB0m/8sx4a61+9HzLH3X6BoAnasxGKWPF5iMl9KeqTVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kbUgdiwDgrG3+Hsph2to+lHCuPQp9JrwICgCXTC6NA=;
 b=OcLMq90nIN+TSVPQApDrQPrLEtdedg4HDJJXoe0MrlIl0v5M05DuXaWsM0uPjtLg8Yh6xF/6TMZ3m4xJ757mtJHJ5dTK57UERTDwPwN6iHpnN0J/g8hewx45KWsqHaZDlLXgjBcarTU8/reN3OwJB2zwwhThPcYefChheGy72gprdfBmmPbNxDy2V1cQcFpOuLsyhXX8E+LZn0rQLaWVU+P4fCLKuIJDDcyxMRbZCDfqOI+kYH16fRqpWkpH1UZC1CEiqU11wg81J9SvvZK1Ww3zvNRLLTeu1IsM9RGSCo0lqLg1VGP3zNEqjhq7L7ull4gH3Sxwzk2/hCah4Mwj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kbUgdiwDgrG3+Hsph2to+lHCuPQp9JrwICgCXTC6NA=;
 b=klPjZQ1u3axkPvi6D79zR0DWizHZjYBuQ0H2DuYlQEk1ZJlwxcrqbtFz9WIC8MuHpMm3TicTAlHnaUxl9U5aELIkgojB/KP4kUgdOaMztwawdW7u5jkw0fNO9es8fP4erbDHF2YtzYRq03Ho/WxQgMdkP/TE7+NMW4gR4TyBTIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 15:32:34 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:32:34 +0000
Message-ID: <be5256e4-b99c-490c-9217-7671c53914ee@amd.com>
Date: Tue, 3 Feb 2026 16:32:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gpio: Introduce gpio-delay driver and enable it on
 Kria
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, git@amd.com
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
 <0097d26f-9e6a-4412-bd74-8c3a3bf19fa6@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <0097d26f-9e6a-4412-bd74-8c3a3bf19fa6@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0264.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::31) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: bb568d39-3ec0-43d4-f21a-08de633973bc
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUY5MDFtdlRHTTQrS0lBaE9oS3dZcjBhbEtrQ25oZzlURjliUXYyUWZNWlVn?=
 =?utf-8?B?N1lZbXVrTWN4UGxDMGtrTTg4WGpaY1VGMWpSbG9CQWNERng4WW0zbEhvYWNM?=
 =?utf-8?B?NUNEYzY1WVMwQnlLZkRLTmxib2ZIOHR4Y0RzZ3N4MzhVdkNqQTJKd2V5TE1I?=
 =?utf-8?B?M3Azbkc3K2lGdEgyYW9XcGkybXBicmVCaUdmazN3SnNBdEpESVZ5U0lFSXRj?=
 =?utf-8?B?RW5EYWN4VVgweE1Jd1NkeVcvSlE3K0I2UkRqVzM5bHZWWStMeGNad08wWTZL?=
 =?utf-8?B?S1pPY0R6T1hHSlBYR2l6Zk93dXZiM2VVRllZeHhNVDVDNDBvczVFVE5oT0JN?=
 =?utf-8?B?R092TnBrN2szQXVVa2JNZ3RYbkk3NVdxRmNJQUl2bU8rdEwzSjhzQm96bzdG?=
 =?utf-8?B?ZmlVOEN5U1NwUitndHVzMHJXSEQ3MnlQMXovRHlqRkxiazBaRWlKNk5vSExm?=
 =?utf-8?B?UXhUVEZ5M1lVMzBqbzA4TWNna3JEaDJjK3NScUFzZ3hndmtaa1pMdEh5NGVR?=
 =?utf-8?B?cENBYWp0Sy85ajNKdEV2Y1BPcDRMeUFlRFhRWGs0SW5tbSszNXR0NWpPNWVn?=
 =?utf-8?B?NGpnc2lzZysrNzBsRjFkdkI1cXJwZ2wrS1dGcjJDa1VucjRzMkcyS2VjSTNw?=
 =?utf-8?B?THBnaVJTaGM5NmxDV0V6aERvMUd3aVBrMCs2REM2eUZQdVc1ODIwSU5wQVNy?=
 =?utf-8?B?OFQ3MlI5TEpzM2w4SWVrclJYK3R6ZmlaSEFnMDhPYWdmeVgvU1ZHV3V5dTEv?=
 =?utf-8?B?d1E3cTYvYTRnVm4xeGJ2SDZNWFNWSVBvVWJBb2VoR2ZjeDRXc2NaRkxRQnN4?=
 =?utf-8?B?QU8ybU9qc0pKYUdmWjBDVFBpcml0ZHhUb3ZxSUgvVlJYVkNjY0tCb3k3NUcr?=
 =?utf-8?B?cFpOZmUyTFhtWkt0SzEvSlJqSmtBVVJ1UC9EWlhJQUZkOEpGY0xkK1BubnVL?=
 =?utf-8?B?a1FOMU5IOTAxWjhWbE5VZml3QlFEQWhLdGZkYzZxN25veVp1SEJGU25sRU83?=
 =?utf-8?B?cm5qT0JzbE5sWUF2Tks2czEweno2aUpac3JITlFrenVnZ0xEWEFpR29jblMr?=
 =?utf-8?B?cG9pWUg4cllIcU1tR3pJdnprZlNQU1NlcVRSdEtoL0ovTksxSFVqMkFCblFQ?=
 =?utf-8?B?THZtMzYxRFAveDREb1ZONE43VkVSWWFsS245MjJFNkJJTjFWZW9jZjlCQ1hu?=
 =?utf-8?B?N1VTWm5tUVBGSEtmZVM2Ni80dHlEVWR0TUJndHlpUWtDNU1Mbk9iTGxIRUh0?=
 =?utf-8?B?Nk5jZXRFempCODJ2ZWZ4cjR0WmR4b3Q0K0RUL0RTb2VXdkVZQnFQOHhKdk1G?=
 =?utf-8?B?Mlk4bzJkZ3V0Y0xoM0EwTXFjZ0l4NWE3T3Z2UkRNWVVRYmc2RDRpcjdxeS9m?=
 =?utf-8?B?UTY5cXJYb2FwNGkzTWpNM0N4VzRLKzFscmhpTzNyME1KaU12bWtmL1pKWVpT?=
 =?utf-8?B?dUlEMkxWOGFPWG42a05NSWtVcTJOUGJheFVzMFhrcm5kZjBUVnJ5dWFJajVI?=
 =?utf-8?B?SjZtTzlmd1NmWHNrNDBtM1U5WWlZTlZPS0RlZ3pjV29XZ2liakdCM0VLS1pn?=
 =?utf-8?B?ZXhKZWJ2S2dvWEx4SkFsRDYxZEMxWm5CaWtxWk1MSVllWkhKZlFmL21icEhW?=
 =?utf-8?B?bGRnQmZVaU5XNEJibWdRaEFlQnF2bXo0ZlJFeHQ3emxBN2JxTjFUSWhTT25K?=
 =?utf-8?B?blZrSmxLWVVuNmNJYlpyVjJNdlRabzRWUm50b0tXaTFjdTQ1cGNrZDN0c0NL?=
 =?utf-8?B?VXlXT1ZPNE1EdkxpVWVrWkJyT01VRVJtNVpDUkRTSFlKRnl2NnFRTnJEYzB2?=
 =?utf-8?B?TkNnUnZLRGxqZzJ4MTRKSlNBZ0hhYk04WnZ3dDlQczN6d0RQSVRxTUxUTzBq?=
 =?utf-8?B?aWlPTHVYMEtraTlDMkhrZVo3bXZwVktqOENxTTI5ZG9YUDAxY0RyMWJUbmRs?=
 =?utf-8?B?aHNLRHpTNjBkaVZzTEdXN1FueEk1dDFibmdVcm5xYllWQ1VCYi8yTWtTdkwz?=
 =?utf-8?B?cnNmYTlkejhWYXNibTFXYXFOUlQyWHZhcmZaT05LNXNweXdxS1RKR2NITGJq?=
 =?utf-8?B?S1ZZY05QNitHVXZKNGdpWFZWakJERlRmYVF3R1dtWFJ0SmhQcnVaL0laU3Bs?=
 =?utf-8?Q?C4TY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWpZeU9KVE5zdjhYeHlwWlN3QWFCbHFob216S25OU2tOVmZKQjQrdDE5ZkIz?=
 =?utf-8?B?a0xpL2xoOG1idCtuYzhaNUFGeHUrNy9IaG1SalRMK3JkbTBIOTZVekQyOFg5?=
 =?utf-8?B?a0VlenBUdGd0YUlweUsxbStnWC9ZOXJaTmJiYTFZeFdXTjYvSUh6K3BxK3JZ?=
 =?utf-8?B?VXRJZCtLNjdEdUthUFZJbWl4OFA5NldnUU03MlFCd1BpU3Fxd25iaFZ1U0Y5?=
 =?utf-8?B?V0R1dEN0bERGWkx2b05wU2NmdjBDWklDSnhiYkptbTk2YTlCVnl0SHRCa0Vz?=
 =?utf-8?B?a01KcUVHWGdIdXRkMGtJckdUck5rZDRhWmsyY1hzUWgyR3A2SitHVkZVVHcz?=
 =?utf-8?B?c09NQUYyamRSYmxubUR4TXdkaFVXMlZ3dVZhRjBIWG5FNmJIVmdUNGgrSFdP?=
 =?utf-8?B?em1VVlp5RHA5QzFsTmRXcmVVc1creWV5VkdXb2pPMVdJaDN4Mm1EUkxlU2x0?=
 =?utf-8?B?YWpqbk45NDZIemduUnpMMFdXL3RLMWRleGhlYnlJUHdWNWFzbWprMUhpemtQ?=
 =?utf-8?B?Q2tXYWlnVEdvK3ZPRGVMRkJ4NzZWR2M2V2J0U2lBSjhVQUFCeUJ0TGp5aWFQ?=
 =?utf-8?B?aHhrSmE4S0dWWGhaU1Q0bGI0bC9NcHZ4Z25zaFBnM1dlazg5dDVzYlpFNEJV?=
 =?utf-8?B?TmVLZmN0bnJWQ1Z0aG05cHlUTFNCb1FYR3VGRG1rTzVneVpFWHhUMVd2WUlR?=
 =?utf-8?B?VnF2U3hYTzlFdTN6ais1cXZxSG9YanZuRHpwUFozSFJlTTdzSlpRLzFOQlRr?=
 =?utf-8?B?SnJIY3ZlZW1BQUZWTExJcUNQNE42Nm1ZKzhDc25uZmZ3NDVKNzRaaUpBb0lF?=
 =?utf-8?B?SU9tTzRVa0MzQ2dORW55cktiend3cDBrS1BUSHNubFNtTk9sdVZJNHFJRUd3?=
 =?utf-8?B?K2F0NnpYRm9IVERMbkhDWnF0Rk1hcWJMbWFTMkRNdnpJQ01vQ0ZIV1J4TVlv?=
 =?utf-8?B?M1hUMm9McFpGcC9GS0diWkUzcUQ4YlFQeVpJTmMwYnZGbEVoeXpiUlpFWjQ0?=
 =?utf-8?B?SU5IbGZWMXcrWi9ITjBucHFCak44T1NmajVGcHNZTlA5emZObm9HdEdndVcr?=
 =?utf-8?B?dFQvUXdYa1hTLysrN2ZPdUorQmlRZTRkQ3hNNTZnK0JyNi9nakJPMU1MYU1v?=
 =?utf-8?B?UFlpdk5HRGFVUG0zeXloSFY1MHY3VWMrVGYrRGY0SHdONjRDalBOZDkwSDh4?=
 =?utf-8?B?ZVh6cmtXclVGWWJnZlEvNEVtOU0yTUpuQUZwSHpGeDRTZUVpb1J3NTA0OTZF?=
 =?utf-8?B?S0NOQVhpZmtiSUdMekFabFdwWWlHZHRJZXdHcnl4NzFNeFRNdTF4Y2JEcWFN?=
 =?utf-8?B?SkZFVXhyTWFQWjhEcW1qR1ZPM1Y2dkhDNjZycDhsd3dML2tGdGVJaUlJM3lD?=
 =?utf-8?B?TGcwMm1jSnh6aldYZmxYWGtMOHR4YjZHaVVjUEpxWVRRYTRndDcyR0N0YjB0?=
 =?utf-8?B?VDdsSEdJcUx1RDIyMDlWdTRNUCt0cHlnRmxteEhrYWdXNk9WNXFYTzA5NXg5?=
 =?utf-8?B?ZWYxOXJtMFBjUDlPd1BPNFh3SjNKeXpYOEdLU0QrSmU0TDFpVXpaa3RucUpp?=
 =?utf-8?B?TjdxVm53MmI0SGpOeTZ5SCtHekZqOFE2NUxJZWJ4eUE1QkpMNEV0SHhFSkRW?=
 =?utf-8?B?MHZLdGl0Rk9jUWNxQnQ0ZmNFcElRd0Y1dlhXVHZKQTJnc3l6NWpMZC91NXdW?=
 =?utf-8?B?RUlWN25BV0RZOWxqUHpNZExIc2NzemROME9wcTNJRXdoQWtJQUlnWmR4RnRk?=
 =?utf-8?B?MDNua0JZQmR5SktJY2RWcXI3eFR5bExjOUVldVIycWk2WGZPcHZkVHMvcjNl?=
 =?utf-8?B?YTIzWVhUaVFya3dRdXhDM3Noc0svYTl0cFpKMjZlRkQxM2pZRERJMTBUa0l5?=
 =?utf-8?B?L1Q0UTQrT1NjVExMSmF6UGltRm9OdEFJVDB4Ujh2aEkwVCtkY2toU0pVNTVq?=
 =?utf-8?B?OFUwOHZDU203QU9STklyVGdDME15a0t6MXB6amtZWWFyM1ZHL2UxQjBuNjl0?=
 =?utf-8?B?blpPclg4WW5CaE9qZzdrOFpVSU1NQkJNRGtiNGx3N1FFbmxsdDloUWpuaTVY?=
 =?utf-8?B?ZWcvZUQ3Wm5FOUpBVVI4TnBrOWlFdTZqclRaTXFEVXRsT1h5NFBpZ1ROclZU?=
 =?utf-8?B?RlhxODlVay9CMlh5UGlsNFNIZENGRExyRDI5dTZsSFMrazNlcGtOZEdPVlRF?=
 =?utf-8?B?OFVyQnZYVnltdXpBeXR1YjN4RjVVWUQzUzd4RWVwMitvbG9LR3RMNEJES0Fi?=
 =?utf-8?B?aHNIZTdXb0t0M1dUaWxXbkM4MjE4Rm55dmdMTFp6R2dNalpoSUkza2dLWDBY?=
 =?utf-8?B?TTZPSW1WNXByWmNYNE1pMG9IcTkvUzlIakRPTGo1MDJmR09GTkx3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb568d39-3ec0-43d4-f21a-08de633973bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:32:34.5471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU2WW7E+zDsXRB37DU8YpT5uv31QQbVHaAsRaTjT5cI/ySNzvnLv3lPoNWwCLWz1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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



On 2/3/26 12:39, Marek Vasut wrote:
> On 2/3/26 8:52 AM, Michal Simek wrote:
>> Hi,
>>
>> we need to wait more time for getting USB hub out of reset to be able to do
>> initialiation over i2c that's why use gpio-delay driver instead of changing
>> waiting time in usb hub driver. Waiting time depends on gpio wiring on the
>> board which is in some of our case going via SLG programmable device.
> Can you not use some regulator or make the reset assert/deassert time 
> configurable via DT property ?

Sorry not following. delay is configurable via DT now - the patch 3/3 for example.
This avoid a need to change usb5744 driver to wait longer time which is what we 
discussed in past.

M
