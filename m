Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34E2C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD1D81273;
	Thu, 27 Mar 2025 15:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XDWaow3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660D981951; Thu, 27 Mar 2025 15:03:28 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2667D806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXnlQmy5mD35I7Q2bynuygclW0yDq7qifYui3Kv6IYVCTYB17ZNudwVeizzdcevAZuvpaoAV1Sc9fn39UZw5iAJMUkxxnflcK/4OGYWazzGL55JDHYfa0p9PJQdP1HMFBLUTSXo/SMnoL3tHT7tVF6DBiXZbpJkZ6rinIc2ofH7C3WOyfQpkXfS5Va+4wSbyRZrgA1QOXnmcjexKZV4nvn8eiJvRw0SGmeZEdLS/NXvg1F/TKxU6FVMKNWeGzo++9tnv9SSo2+0KEIed8dDVJiVk9n+XnqUOBV52XkH/aTLM/5fVzeI47vccXXPkqnEiDPP4j4l2eX34WyoWDXnM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7hlgTF8NmKrZYB+LkrRyO8JBtyShAitcQLnZlUpBTo=;
 b=vtG643A02842E9/9ce/XTObO6GXeABUuAxiRE3kNvP3cSggIJ8dkrojwp/HwUydnQiq7mxyin44cuhj3VpsTC+54RKFxZko5fDbtL2P1fbMmIQ9twA6zd+aWwmD+bOmZVVC7rZ59ho+6PHj6JLubLT9rEowR6kA/wkDqqRDRDc1Ygwpy+qgutowv8MBCng+sKa8AaTurLKOgMjVq43vSR2wDpltkKKe7nE47XpBCieoiOTKZlgwLtV2dkcP+4rc9Bpuo1/PUEIBJQqQsCZTNET613ti63WX0S+wDfS4LJ43i/qZIbG/rY10EV8mG7dv2ts8NgHU0f9wafgaWN7paGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7hlgTF8NmKrZYB+LkrRyO8JBtyShAitcQLnZlUpBTo=;
 b=XDWaow3u4U+5Cai/W4irpwy9Nnsg2pOU1VNKlXgwEQmqXv1m46+wrPJ/ILrCuc7E8uocIJRhB8jMJOE4nnQxwawwEJWOS1jUTCUt6nBs+juJfyYeO1JChKdmVeDh2J7gvKYHPuUsyHfxrtfr7N/Wd7/Zjfre8yMWGrucIgT8i1B5lv3a/GmRfVU9QPambhy6UWXRTOGZdlmuWfxx6D0CeRCNqKnoEc6dckLeX4x2y8nzsozpfYPixc+7e+aFdN8pkm6I5dQwrlp6kmwlzj8jLMzmbvguQeRtrz4R0V9T+Fzvb9Dj2kL3CqdezNMzW/+mvPJoc2e8Mb7R5L/SsP2tyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by DU0P195MB1498.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:34a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:03:24 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:03:24 +0000
Message-ID: <213c480e-0e2c-451b-97cf-2a6871e5d341@phytec.de>
Date: Thu, 27 Mar 2025 15:03:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] arm: dts: k3-am625-phyboard-lyra-rdk: Add boot phase
 tag to phy_gmii_sel
To: Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Cc: trini@konsulko.com, ggiordano@phytec.com, afd@ti.com, n-francis@ti.com,
 nmorrisson@phytec.com, vigneshr@ti.com, s-k6@ti.com, dannenberg@ti.com,
 bb@ti.com
References: <20250325035824.2304200-1-w.egorov@phytec.de>
 <20250325035824.2304200-2-w.egorov@phytec.de>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250325035824.2304200-2-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:303:dd::22) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|DU0P195MB1498:EE_
X-MS-Office365-Filtering-Correlation-Id: 8215f785-8388-4aee-8f86-08dd6d38235a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHV0emRGMGt1SUM2UitLaDA0cklnQlUybVlnUmZ0Um9JTmMrM3NYejJVa01T?=
 =?utf-8?B?eFFyUTloam51MTdyV0dEdEFoTXZWRjJFVlBBQ2huZEVsQWZmTXRLaWFBNElt?=
 =?utf-8?B?bS9PTFhwYnRtdit6aHdxUWF1RlNHd2dQMHZ1YW9YMUc2cHlWVzNyV094Y21n?=
 =?utf-8?B?eHM2MmNBbXoxdS9DZSs3cDg0K3dVdlh1RTBWS3J2S3ZjdTl6a2pwWmJqd1U4?=
 =?utf-8?B?SmFsdEdtdkNWU0txU21ibzU0S2Rja3A0N2U2VlJ4WVVXZDN0UkdvWXRUQzdz?=
 =?utf-8?B?M2tnazBjZGkzbEszWXpIMXZIcGNIM0tNOTJKc3AxTXcrRVNhcytwRDl0R1F6?=
 =?utf-8?B?N3VIUzRJVnFEdERldGVPRnBydVQwQ0ExajJkcFI3d3MvUWxNcWdGb2xQOVRO?=
 =?utf-8?B?ZGQ5MHlDTGhXMldjcGFxOC93Y2RTRHhxaU1ERldGVDJkZFNMYTdiTEhLUGxB?=
 =?utf-8?B?QU9LTzNuWVJOUTBWVW9vYWhkTXM1YmlSanpqbk11Rnp3VTdZT1Y2YjdxK05K?=
 =?utf-8?B?MGdIYmZ0VlZEK1JMc1JiTlJweGVIamkrcHZlM1V0S0VMZjFmWHhCRXFOMzFl?=
 =?utf-8?B?TFhYVlpPWUxIQXl5L1Y4bnQ0cUVLNGRxOTFGcW9FSGF0bkIvWUdkNmphUlFY?=
 =?utf-8?B?NkwzSDFoaWN1Z3Y4NkdCNE84ZjkyaVo0MEUvTm1EQmVHNkxrLzNYTTRPS3FI?=
 =?utf-8?B?ZlA1a0RoR1dOQm9LSU9PME1KTkR3UkEybDNvT05WR0RNYzBpZ2JoZ21jYzFV?=
 =?utf-8?B?MWNMU0JUV3BHNGF0emEzNkcrK3NldzJwanIrQnNHL0xGdDI3NTFlYmZ3ckxp?=
 =?utf-8?B?aEZHeEphOFpQMDI3bktuRlBiSm8yK0kyNmJaYU10UmxkaVhDVVJwaGhCaHY5?=
 =?utf-8?B?Wjd2OERKbUFPbkNqNUhxTStYVWcrRFZacnhWZHBkWElOcU1sempXbG43SWJS?=
 =?utf-8?B?RzZicGhjN2NZZlhiN1F6UFZLNGRmRVpsMWJLUFV1cEZJMEZ2K2dwV3NiMURz?=
 =?utf-8?B?Tko4VGhtZ21BdXBGNy9qR1NEd0hTUm1hZFZDYzZSMjhrVm41YUEyQnF6M3ZB?=
 =?utf-8?B?NW04WWNnVnNzYzBYeVNDNkZjU3UyLzAzeUIxSDlPZVAxcEtqTFdhcHcyNzB4?=
 =?utf-8?B?Uk1LQmlyWUVqZjRycFBJL1NCNXRrak1zaWdWTTVKQWZzTGYzZjJvV0N3MWJs?=
 =?utf-8?B?WUNZaG9VTmJVUUY2cDRtWDlzWVBuMXNFTU5OUzNKVTJhWjI0d29kelNpTEtl?=
 =?utf-8?B?bngwWnlPWUZ4d1JpOFFRTkVDZEt1RFZDak5qVThyM2pXOTR1Y2VmWVAzcjkw?=
 =?utf-8?B?YjBSd3I0QUlIRXAzTGRpNEVsQ3NZQ1l0SWVOVDBlRk41UVNZSEt5RG9wK3NW?=
 =?utf-8?B?NzNCaXRMb090aEx6Q0pMbWFxY0pKeTk3aWlTcDY4RTYwMjhLeHJDam56MlhC?=
 =?utf-8?B?aXV5cGJabENZVDZrK21EWHhYOGpzQ2l6dHVzNGZBcFVwR3MzWXJxcWRaNHpt?=
 =?utf-8?B?Wmo2dnhENWN5dTEyK2xzRkxNSlJsbTZ6YU1BS3ZrbW5BWlQ5MlV5ajlUVzE4?=
 =?utf-8?B?Zkxzd3VZS3c0enVwUWpCeGdBOWFZV25wL21odTg3Z1kzQVEwVjBTczJWVnN1?=
 =?utf-8?B?QWNsd1FOYzRFcWtjZlJnUnd5bmxLZmc0dGFsbTB4c3VMV0hXc0NqZ2ZGL21Y?=
 =?utf-8?B?UXluYUxVc1BIZjV1Nkp1UXFkamoxTytWdnlBMWwxQzFsSjNQbUFBZzJWMUF2?=
 =?utf-8?B?b0NzbzJmTHhCenhacDR4YXFxYVR0ZjMvL25aeERlWnA2djI5WUVnVTF1Q2li?=
 =?utf-8?B?NzE0eVNjbHBYUm44Q29EWVlXWWs0azhTZ3ZkZ0N5STNuNk9WTkdmNitKL1Nv?=
 =?utf-8?Q?CkmovffouM0kB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJ1T1Zadzg3OHhoV0xqSzU2T29mUnRwbmcvd0hPMzRwd2Nua3ZZRHpoTDl5?=
 =?utf-8?B?RERZNVhCTEE3T0ZSNVhDUFZRNXdOa0pxaWk3Mm9JZGdiajVSUUMwaVlVeGg5?=
 =?utf-8?B?bzZzUlRKNEdUejhHTERqSXJKYllpaWJzdVBWTHFuVEtzZkN6VmY4RW9hNFhX?=
 =?utf-8?B?VjBBSnlWWEFoZWNKY1NzK21xZDZCUjlkdHJXNUpDT203Q2xIL2tNb01lV1VV?=
 =?utf-8?B?amt0cFN5Q1VmQmZmcjJ3emRRYUsrMTF0RlVMemFTVnNLd2doWXFtU2tiNnpz?=
 =?utf-8?B?bjlaNElZcFp3UXd0K2czTENtMU9uRmlNWnc0RW43WG4xRGhsZklMa0VwbnlL?=
 =?utf-8?B?VXZ1MGVjK21iVjFiODdaRzkvOGpJYVJJSzg2dzdBVVorS0JqbDVHWDBBTXdy?=
 =?utf-8?B?L0pFN1ZJUzdrUFBieDlUS1RidFVreS94SEt3V3YvdERHM041clJYUEpEd2hm?=
 =?utf-8?B?R3BRc1RvVzZkU1pLY3BGNVpzTE91YU5SdnptNXRwbnBiTGZzSlByUmlTOWZR?=
 =?utf-8?B?VWkwSFFKUTVCbkJHT3kyUlNFbTFpQUg4TWtrTW4zSlhUdjhTTnBweUdiS1c0?=
 =?utf-8?B?bDFKUWFhUnMvRDlxckFOYkdyUFo2VURDM0IrMVJqRVV5RUNuYkxOL2lYK3p5?=
 =?utf-8?B?Umg5L0QzeGI5aldHTTltRnl3U2g4RTNZcW0zMFFrbXZETEk0cnFBY0JhYVAz?=
 =?utf-8?B?a0hNM3Z0MEFRbzUzYU94ajZDbEtNU082a3NYZkVKVHpuZWpQbWJnS2tFcUNw?=
 =?utf-8?B?WkJ0M3FiTzNkWlNWbmtJOTJOSWZxWHBXQ0Zqb0NQQi9JOWpiRE5MRmIxaVpj?=
 =?utf-8?B?T2xLVmtCZXpSMkpVSEowTGcxTFY0UjdsZGFMSkM1R0NMb0U1OCt5ZVlBcDVo?=
 =?utf-8?B?R011YUdsc2F0dlp0Z0FEVzI2a2dPRmI5cXNBM1dINWNPb0NwY0d0Um5Pakxp?=
 =?utf-8?B?ck1GZmV0dUx3cERxejdmTW5iSmZQaTNqSG1pTncwdGNCU1kyTzlLT0lFNm42?=
 =?utf-8?B?ZDF6dk5ITDN3RURsNXQydGNoUTJsS0JLeHBoZmswL2R5d0lvMGVJbEJQYWU0?=
 =?utf-8?B?S3pJOGQ5Q3FlZzNrU20xb1M4OGRCdGV0S3czREUrZlhJbVBwTnFJUTZIbmtH?=
 =?utf-8?B?RWpjay9PemIveGxBajNqcWZUT0xCTmY4NWcyNWo5a0FkRi9jNkZ3TXYxRHIr?=
 =?utf-8?B?UkNQV1pjNGVuTUZuSGxkSFcya1g3ZGJmU3p5ZjBzYlpiMWhkOWhLL3pCd01p?=
 =?utf-8?B?U2FzSXdEcDF4K0tRLzNHdWJCUFhZakd0dzhmcG1adERkOHBrNEJDSC84YzZS?=
 =?utf-8?B?TlFRTzVoYnV4SlRraW03RHRoNEFNdDFoOUVPd2RVK04wemVJaVhKUDF6UXNH?=
 =?utf-8?B?Mlp5U0hiM1U5NjRFakFxMkRvcEd6UjVLY0RIMlQzejdoZ0ZnRFZKRy96M21x?=
 =?utf-8?B?NEFmbVAvZmRoai9mcUlXZHlJd0ZIaDk4eWR5aTQ3aDhIYkRYWloyL3BHZndt?=
 =?utf-8?B?dHZuaWkvU3hrN29sMSs0dHN2YkNQb0tXY0NMc1NOSFM3RzdEUjNuZHZsL1Fj?=
 =?utf-8?B?MnZUZXJjNWgwT1RqZnlTbHZjWjhnVjRieHp3bVMxNkRVZUhUVFByM0gyR0p6?=
 =?utf-8?B?eXBramZURFU2TnpTbkNtdjlaNlQvalBUbkpmanpPS2grZGRWNmtma3NxUk4x?=
 =?utf-8?B?N0owYzNPSmEvLzBHWkc5d2pIZzJOd1JDUWRLYXdPdnhMSU1aSWszMmMwNDVh?=
 =?utf-8?B?eDVpdXlVSERjSENzMDF3NGhxQUVvQU5wMlMycmx6cTZ4WldyQ0w5MDZJRll2?=
 =?utf-8?B?SVFhaGloQ0Q0bDNiUTVzQ2YvbE54UkMxRmgvcnltZU55SjJqVEZRVmk4aGFk?=
 =?utf-8?B?bXI1UWtJVEtQZDJPNTB0NkFINnVIdEovUEtvK2JqcFRydXRIYVA1YmZvN1F4?=
 =?utf-8?B?a29VRks0TW9OdzVBZ1BzYzd6T1UwQVVZdjQyMmZha1FNazdyOG9mc3doellH?=
 =?utf-8?B?U3Q0cDlraC9GR1JhQ0I0SkFVK1Q0UDBqb2YyTTFDTWdJRlFPd3VuTlFQM2Q4?=
 =?utf-8?B?V3NmT0VqN0puZkVZdGdjTkxCQk9NUHB5aldwWE5CS3RWbGtlQkMrU0hodmt4?=
 =?utf-8?B?MEsrQUVMMWZxTndFL2xzVGtZMXRHcG1OMk5XVlY2TEtEeHZtc0hWSmFESEQv?=
 =?utf-8?Q?pcDA1HFfCWJ4hn6g1MitZCXeqRSs8pugtKnEDtZr1u4V?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8215f785-8388-4aee-8f86-08dd6d38235a
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 14:03:23.9470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hc+tbzbrrl2gxjgKBo7xpsIdw1lRYiFSU/3OGDPJZzwxU6ZcN2vycbVDJ7IYri1mD/gc7qgWdCVJLFstJRSVwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1498
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


On 3/25/25 04:58, Wadim Egorov wrote:
> Add bootph-all tag to phy_gmii_sel node. This is needed for booting via
> Ethernet. While at it, drop main_pktdma reg redefinitions which are already
> provided by the top-level SoC device tree file.
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

For entire series,
Tested-by: Daniel Schultz <d.schultz@phytec.de>

> ---
>   .../arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> index 2bc5acbec23..253ca297e12 100644
> --- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> @@ -42,6 +42,10 @@
>   	bootph-all;
>   };
>   
> +&phy_gmii_sel {
> +	bootph-all;
> +};
> +
>   &fss {
>   	bootph-all;
>   };
> @@ -86,16 +90,6 @@
>   
>   &main_pktdma {
>   	bootph-all;
> -	reg = <0x00 0x485c0000 0x00 0x100>,
> -	      <0x00 0x4a800000 0x00 0x20000>,
> -	      <0x00 0x4aa00000 0x00 0x20000>,
> -	      <0x00 0x4b800000 0x00 0x200000>,
> -	      <0x00 0x485e0000 0x00 0x10000>,
> -	      <0x00 0x484a0000 0x00 0x2000>,
> -	      <0x00 0x484c0000 0x00 0x2000>,
> -	      <0x00 0x48430000 0x00 0x1000>;
> -	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
> -		    "cfg", "tchan", "rchan", "rflow";
>   };
>   
>   &main_rgmii1_pins_default {
