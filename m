Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EE7EA3F27
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B272983A47;
	Wed, 11 Feb 2026 16:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xi/Ke9es";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899A283B30; Wed, 11 Feb 2026 16:31:01 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB4F58388D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laPHeEzE8RDKZX4d6qb+r6rzgcKuMwRmTWEfP64gFITjWLIjFWYp/b8toLStkY8HEpP92X6x9QH7b2JnW0bl+LkCKeEIOCTZcMd0NSiDw3sp3D18G/nWGoxYe8NPG+grDDeNa7U37P4v5oJWM0Y478GwPx8OC+nRX1cQumRFZlZHEQpGxzQDGpOFkNBqLblgSXALgxSMv+sBkLEQMpQtjdqilMc2xwSG+9caPHv2jTeUdggljO+Zz7af7uErmMiXk/4llHLD1y+5Oc1V0XHLzzB7I2i5ZQOQRI57LYm1SSYwNjJW0e9mLisgFZPoIFBIILmix0f9XxXhFZdTLtMHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRts6e6EMmk7CLpKgdhM+gNOp9xJ+GkqIGXUDUEY43s=;
 b=BX2FLOvSv8qtOoPjzOCPpeV6t0wL7cYIqHcQvPZR7ILayKq1OXKNuGEm0RgFFvHPJlY0MbQoUfDPXGfVapUw3II6PnBXbG50xAoM6pivmhi2b2H5pjV2S+a4IrXFTvsj9DkCVZx6eNPFftiyUKGRfQp4OXODezrvICHvVcL9PDec9Gt+TikQsoEcxTq4xy54o7qA+DJ94mKwoBthV9M1uNI0uo8Q4sFhGonnN2ORF/W8CX+4yKq20JvcENfpIjb2v/KcjI35rXTkl1BQSfphekIr1tNmZj3tJjZGjmlZfvXGD6+uw62/gUogCfxNLzwp+27f5u2g5Pk0FpDr1zbUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRts6e6EMmk7CLpKgdhM+gNOp9xJ+GkqIGXUDUEY43s=;
 b=Xi/Ke9esYVh5WNoKtkZPzbIKP2/F75TSVkaLKYeRn0+t72+1MlBbYVbv8lT7RnRBXttQd/jS05s59Cqk4PdH/Fkyd3qP+6QTBkYMtrtOWkvxE89qoLyTodpYXEsf2jVAyFyI6oNinbMdVGCPb/OjEAK+btz8iDaYd1Pu0Ptk4s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:30:47 +0000
Received: from SN7PR12MB6931.namprd12.prod.outlook.com
 ([fe80::f6fd:4b02:a116:fcaf]) by SN7PR12MB6931.namprd12.prod.outlook.com
 ([fe80::f6fd:4b02:a116:fcaf%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 15:30:47 +0000
Message-ID: <e14baf37-a610-42f8-b155-315e0f4f35d7@amd.com>
Date: Wed, 11 Feb 2026 16:30:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] efi_var: Unify read/write access helper function
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1770119483.git.michal.simek@amd.com>
 <f56553cd519b768f8febba0b8d807de3cad14739.1770119483.git.michal.simek@amd.com>
 <CAC_iWjLHCPVDTTqV9F8NiaLGkV_PP3M9OPC3dDzozSEk6FRFTQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjLHCPVDTTqV9F8NiaLGkV_PP3M9OPC3dDzozSEk6FRFTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::17) To SN7PR12MB6931.namprd12.prod.outlook.com
 (2603:10b6:806:261::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6931:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c991d93-f98c-4117-e183-08de69828729
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3A4SWxGTDlQQm1raUlUMUYvMW03N2xTMzVXTTFoQVR3cHcwUk01TTNBaHli?=
 =?utf-8?B?S2x1ekxXT2ZReFAvUnRPejR1ZXAxV3FXUjY1N2JKRUE2L0tpRkw5My9YdU9z?=
 =?utf-8?B?WjNZNUVqbXhER2xrQlNsbHZ2c3JGSmdwWnpna3FyUVRsWFlQeUxjaDNTSEtS?=
 =?utf-8?B?c3B4Z05Bcld1UXFUUW1KSUJYRTFUNjhxMkdjNVJrOXdTT3JxQ1BTb3RIYnZx?=
 =?utf-8?B?RnBuVmhwOFR1VzNTQ1NwcldmcG5rREJMVWNrUGlZVzUyOW9KL3hxRzZld1FH?=
 =?utf-8?B?VzUvaTMzaVpPRGE4VlZ3Q09VY1Y5WXlEVlVsR0R4cmsxQ0xsaURJSmJsM2NC?=
 =?utf-8?B?WVRvNTVjSHp1QVkxRCt4VjgrQ3d1UkhSSVRMR255UmdZempEWDhXeFd0MmZj?=
 =?utf-8?B?eUIyYlRhbTFydG9qdW1rL3ZXZ29xVHpQWXc1RHlxRXFGYmRsMGJsWk12Q040?=
 =?utf-8?B?RFJWMkJhMG1oSGdUb0hoYUViMEFHUUJFcVREdVZJQUdnWHdLYXlvTzE3MXBq?=
 =?utf-8?B?Ym9oN0hUc3QrV2xyWCtUeklkR3hrVUF2dnlUV3dtUkZzeng1Tk9jQXUvSDN6?=
 =?utf-8?B?Q3d0U1lpYkl3empMakxqQkYvNm5ONDVtSjZTa0RrdVUwZ0JoNmVuZ2ppWTJL?=
 =?utf-8?B?QUdwU1lJSWR0QXN0OU1yclpwdjkvdEdXVlpPRlE2cHc1dGJDcHhDMkNzRHJm?=
 =?utf-8?B?ZnpSN2w1U292SW56NmVaSnlKamd3a1NzaXd5VW1lemk5d09NN2V1a1RWY0Zu?=
 =?utf-8?B?aTVZd1lieUxDL3ZLeEtXKzBPSTFPNllnQStzaDZYQ1JZem1NTVRUM05WdnRS?=
 =?utf-8?B?RlJobks3ZTkzYnVIbUdyanVKUlBSWDlVQ0REOUR1V2pOeDcxNWppR281NzZX?=
 =?utf-8?B?c0tpZW40d1kzRDJHVnNJNis4b1hHcXZURW9FSmdSRVJXeFdhNndyWUptL2Yx?=
 =?utf-8?B?TGdmYVlaSXByUlFNdE02ZExrOWdiVWpiTks3ZTFjYVhlQWNxTnU1S1QxTG9R?=
 =?utf-8?B?K1hqVVgxWkdLZTluY2pIbWorbVRaNDVtemtqeGg5cW5BakEzQ3lsT1d3TVFm?=
 =?utf-8?B?ZVJOQ0FxaTNpTDBCMnFQekRSVzVCYXAwVHp4YUR0WnVFVUVnMXFlZG9SMzBD?=
 =?utf-8?B?b2xBcWVURXBtR1VjZUlvWEM4OUNEek9EbEVrVFY3VUxIZFViWURyVU9MMlpE?=
 =?utf-8?B?QVBtcEYxRXZPcWxwQ2lYM1ZHbzl6YzJBeUZDdzM0WDNPU0ZBYjVDOEhaT0l0?=
 =?utf-8?B?QUlhTzNQUGxrMkUyQzBUMFBKYk9zS0lWT0hOeUtML1ExZ0NSc0Rib3pYbkNS?=
 =?utf-8?B?S3lRY09rMXEyRWJFY2s4SHZ2S2tuMDRoRXFMSFloWnBQbmV4VHgzQWs2ZkJk?=
 =?utf-8?B?c2V4Y1pxOCtSNktYbUxLaGNZNmhOL2dONE94ekxjbURBTkRxeVE3VWMwdkdw?=
 =?utf-8?B?T1N3SFZTYXgzM0pUMEE1RmpVT1ZodnlEK21paXlZTG1qNGNHc0tPUkthSjJu?=
 =?utf-8?B?djNLS0MzOGUrT1BGWko4YklscG5JUzhFdEd4YVgramZXSWFjT21SaDlXbjBD?=
 =?utf-8?B?eGNvYnBnY3Z4cWJibU9vZzJwTzVaUFJoWTh6NkJSb0hnYUZscXFQZjZCZXFm?=
 =?utf-8?B?U3VybFJnZ3A5WFVqUXN5TzlQTFF3a1ArRCs2WHcrQlo3Ukw1aUtiOTJZRTlq?=
 =?utf-8?B?TUxKOU1VL3RLa1BibXFndHhUNmVMczViTjBrYzdsenlPYkxnK2VLWlZtc0Ny?=
 =?utf-8?B?MlpIcS8vVGlvelNUYW5iTS9md0k2ak9uVk1NY3RLMkdweE1Eck1SdWJIRy8x?=
 =?utf-8?B?TWhoc1E5UGlMZ0pwRTFpSDNyYWZQU0NqTEgvZDd6TUtueWtIS0hyOGxoaGts?=
 =?utf-8?B?TFg4eGJaYU4xVUVlSjBxSkhNNHR1b1hIUENac2Z4aDFBaDVENGhpMTB4R0NL?=
 =?utf-8?B?ZndUSXR6blVWaVc4MTQvM1YxeHQyYTVWdEM0RnJWUGNvbm9PRSt3Vm9XM0Nm?=
 =?utf-8?B?OTBEeGpiVDZ4cDlxemthMkcwcVhEQ2p2bTc2c1RENXBSdUhUSmNiT2x4N2Jl?=
 =?utf-8?B?MkhHdkYxeXBEVjdMcmJxeTFwSnB2c2NxOVZwSlAwNlJWdjRNMEJrcDJvK3E3?=
 =?utf-8?Q?dvk8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6931.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0dualhyQjhrQy9wSDJXMW5SVHlaYmRYcjhvYW1EQmZiS3dGd3FDNEU3bTEw?=
 =?utf-8?B?SDJndWRzbmdrNnlTa1orYXE4MUZtck92SXpLajNROHBhUGVXMmxJSFhTZUJy?=
 =?utf-8?B?bHBRV0JWSnhMOXJydGJjblRCYm5LU2JMV0dkaXhTU01nT2c1K1Z4d0FhYmUz?=
 =?utf-8?B?dlJnQTdIa1pLYzFkSjZmRGJ2dGI2UnhtVkcxdUpZc3VWdlRuRGZMNWhnTTFL?=
 =?utf-8?B?YmR5V0hMbm9rSjc4M0pNekxqdndMS3lNeUtMOTNSemkzalB5eU9HZ0VVT1ha?=
 =?utf-8?B?OXpaOU9hbHI3bzRkNVNvSjlMZE9DM1R3SFhpYTBVS3R2Z2NxVGJIcm5QQWxE?=
 =?utf-8?B?cjlUQkQ2VjE3MU1iYjJwRnl4cTBzTUc2T2czSXRTeEJQTzlseWxFVjVId1ph?=
 =?utf-8?B?NGpEa1dHRDNrSUxrSWZMaERncjRiRE14R0lyQ1N1NE13WWIzY1kvc3FmWFov?=
 =?utf-8?B?M0F6Sk03NWkyaDFqRXhMNUgwczNJN3h1ZDd4WHdadzZQeDY3N1JtK3ZmaXFy?=
 =?utf-8?B?VVdzbG12Njg1ak5SczJrUkRKWHQyZ1NLM3UyZi9mSFhWMk94WnhOTWRNVnBF?=
 =?utf-8?B?N0xuOTA2enVJVk51QWJMWWtqV0xUcW4wUGZlNFdGdzZGdUJINm9tUEZ3TEdj?=
 =?utf-8?B?Sk9jUWhlbUU3dWpBSEVNelJ0NkZtWmNwYnpEUDBnelZXL2tYN29rZTc3U0tt?=
 =?utf-8?B?bnJRVE1DMUxxcVRUUTg4MEZ5RTZFeEZVSUJIWXY3VzJUeXFVMUNoMVVRMkdi?=
 =?utf-8?B?bmlnRUNDV3BNMHY3MDZuZUVicDh0RHpYSTB3MFhrMDJDUm9FOEJrSHY4alBV?=
 =?utf-8?B?SXJ1UUdmUEpZZmlranVva0F6c3lTbURwN3l5SHZ2NTh2VGNvTnB2SEJTc25G?=
 =?utf-8?B?VVN3bnFoTGRxd004RmJJQzN6Y1hyZHk4ajVyNFlNYVl3bnV5UFdZYnhGaHN2?=
 =?utf-8?B?K01PVUhEYUNGSFo0Q040ZTVmdXc3eEwvTGpybk0rY1U1TUpEam9LcjJDVlRG?=
 =?utf-8?B?d3Y1cS8rS3lscnIveW1FUkt3bUtNZXIvOFp6SXhhSS93MmNoMVdwdGtBcWJD?=
 =?utf-8?B?bFEvdUJDOFQrNWlITUQ1TzRFZUtBd1ZpZ1IyL0szVE9zZzBBUmo0SFZTSHEy?=
 =?utf-8?B?S3lLN0JWcWJPdVZxcjJYVld3TUFlaGs0ZU9zc1JGZTJLd3RlUkRiWFZLbTJU?=
 =?utf-8?B?SytkZGdXa1hXWEt2UXpiMm45aUFneEJScnpNZUE5am9ZY3JzbDQxQWsvNVFV?=
 =?utf-8?B?cGhPN2hZTGNkNitaSGJQWmNvWXBvdjVoVVZ6MHFYT1ZOa3dCZHNzL29RaWhW?=
 =?utf-8?B?RWxtSmRpYXJyKzFGVG1TRCt4bU5NL1c5elpOVkI0T3piSHBYU2JXK2pVV25B?=
 =?utf-8?B?VlJod0lnZEtndlhGajlqM2Zsekp5eTBuQmFGMUhUdmRMUFZtUm5YcFBTd3k5?=
 =?utf-8?B?VFdESk9JL1diL3AwRjEwWS9XeXRuQ2lONGNXaFV1ZTV0RXdHbXZsdkRoOWR3?=
 =?utf-8?B?WVF3UmlSa1hZaGxsZ2U5ZFhvbHUxdjRGU3dpUStHV2ZQcFZYaVNib2Zzc3Zy?=
 =?utf-8?B?a2sxSEtGSmwxSWNGNkRaa3pINzVmdDJIWGlBalpzbUhGcW5pQk9jaFByOWNO?=
 =?utf-8?B?OTE5Rko3QUZCY1I0bXl3bnRBSUVaSkZiNERkN1FrRmNLeWpkSmFuczRkWDc3?=
 =?utf-8?B?V2JjUjE2NmtvK0s2dWNtMEpXcWQ1ZmIvNkVHT1dSTkFNSHE0elhvZC96a2hV?=
 =?utf-8?B?c3VXUXBYVkJCY0JTYU1VL1NIREpaNTBjbjVQSStYeGxVcEY3Q2xTcHhLVDVy?=
 =?utf-8?B?WFVTWnZvRU5mTFV5U1E5U1lwNDkrMyt1aFBPcEEwY0NiVFFqWEJWOENGVFl3?=
 =?utf-8?B?TkZYenE2SCthOWk3SkNDV24wRVBKTEp2NXRKcENMeW1pSjFrUFN3dzc2UExm?=
 =?utf-8?B?YVZkQW1KTi9mMmFseExtTTZqTEZUVDJNcXBxY083aTIrRjVaQmF2anJVT284?=
 =?utf-8?B?OEZsQWI4WUdVN0dVRiswRTVHUUQ5RnpWejNFcVc2VUUxckdvQ0dWeW9ZUzFG?=
 =?utf-8?B?Tmk0UTlWakJQeHlHU3U4R2dKQ0ZmNUhTdWE1OVBDakg3UXFPcmpsWld0RFl1?=
 =?utf-8?B?YVM4MkRxRm1qeFovZ3ozZzVoNFRMM0tmZjM3K2hnMGNaZmVXZ1diK2lrN2F5?=
 =?utf-8?B?YncxU2tJNzFHTzJvRWVEamJJSVljdkRtamUvaE1VZ1BuZ1ZxNlBOWHI0M0FK?=
 =?utf-8?B?QUZLNkxNbDM3RXFTemxtRElaZ1dZU3RTeWtKeFFERFF1RFc2ajlyZUIxMGN6?=
 =?utf-8?B?VHdWb1pZTnBtNTNyWERaSjN3clpYV0tvM0lWRlNCalYwbWladnNnZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c991d93-f98c-4117-e183-08de69828729
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6931.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:30:47.2008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dskkl75gQbZXDsgIqiYenNpNEb3OdXMudWQUA0TYWsy53fsfluzqBKPqw+qDVWc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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



On 2/11/26 16:06, Ilias Apalodimas wrote:
> Hi Michal
> 
> Since you'll have to send a v8 a few nits.
> 
> 
> [...]
> 
> 
>>   }
>>
>>   /**
>> - * efi_var_to_file() - save non-volatile variables as file
>> + * efi_var_to_storage() - save non-volatile variables as file
> 
> it's not 'as file' anymore right?
> 
>>    *
>>    * File ubootefi.var is created on the EFI system partion.
> 
> And this needs an update "If they are stored to file..." etc
> 
>>    *
>>    * Return:     status code
>>    */
>> -efi_status_t efi_var_to_file(void)
>> +efi_status_t efi_var_to_storage(void)
>>   {
>>          efi_status_t ret;
>>          struct efi_var_file *buf;
>> @@ -85,7 +85,7 @@ out:
>>   }
>>
>>   /**
>> - * efi_var_from_file() - read variables from file
>> + * efi_var_from_storage() - read variables from file
> 
> same here
> 
>>    *
>>    * File ubootefi.var is read from the EFI system partitions and the variables
>>    * stored in the file are created.
> 
> and here
> 
> [...]
> 
> You can keep the r-b tags, as it's just comment updates

This is actually correct. Because this code is used only for storing variables 
as file on filesystem.

I updated include/efi_variable.h which is generic and shared between fs/sf but
lib/efi_loader/efi_var_file.c is only for saving/reading file on FS.

M

