Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C69D41173
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 11:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A8583015;
	Thu, 15 Jan 2026 12:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eQnI8FwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7036483885; Thu, 15 Jan 2026 12:22:44 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2011580325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 12:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOtSfLeQ1zzW/KuCUuSjbDeodkO9JEgq7/lGYcPnf8xHZRUkTyvjgU6dIMu/cLBtgTEkT2yPbfX7KLfhrQYbPfAIgI8hihv7K0gJoyDGCLuFoR5Mo5s/eQ8EBH3fK5R5AdW8Bk+LMWySG3Hw+nuqCO5S3wty+HDIhHdpvkD0IHvy126c/UajeReewOHA/V3UrQyqt8EYaTH6Af3MWRcUFT9Xh9ymJ1XVsmHilTlltRKfVYXgv+XDtCp6AiyDDUdSN8HinRgxvgu46NzAuOWGWrD/ZxW6TQLUZCkAZmGxX7UW5h2C3jCX8CvTOaWfBw6Eo89O10rP7E9UUq8ueehOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Aimoti3oedI+oKN3aycCEg7o6EEb9TV6JCV+kLGSYI=;
 b=bq1wuqpUCbIOZMLR4BWUVPWhpTRkUsd3GGBoZu0lG+tvKQRoh8BQYf7F7ytxr/Hd0HEgIalRZYmsZGLHViqdYYttS2Rr4Cl10beh/u7FqrPRAh8FBt3+whtFF+luEQNVfezl8/PVeSfmQ6L/b+iwtEt99nYcRbZy45AxUwM9bdlBi8GSAg+wV70u7QEgdv806IRYee53ioKUhVQAxGGp7ca6uava0diHNaXbNYKlt0WOSAO0NfXftoSJaumQ7zsgKZxzD5HIrLa4uVkSQ6engZ+thEROSrF3Kvm9yulGIMvKrS25jOqksd9pHbCwMEb37XXPg3vbFFHoFbb+fw4GVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Aimoti3oedI+oKN3aycCEg7o6EEb9TV6JCV+kLGSYI=;
 b=eQnI8FwOZapsRCPcdYZUNzHbgKvgLKtDfol3lHBeZtLFVjel0hf96+IFhcVF1GlDlMuNH84RK89rR0XeZCdoYb4xCqHeE8+ID1fLq8hb/ZhjxGeyf4QAW/LE5i1rrk4f2JW6DzEzoOGBT0PGH1A4/PBm+Tk+2pR8g5J/gIaDK+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 11:22:40 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 11:22:38 +0000
Message-ID: <e93ebf36-2f5d-45ff-82d5-2d92048a4421@cherry.de>
Date: Thu, 15 Jan 2026 12:22:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] rockchip: rk3588-generic: Enable support for RK3582
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <20260107230747.3552391-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260107230747.3552391-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f1d8cc-4e56-49a8-a7ce-08de542863c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXcwN2FybWZSN0tJZ2dESzFwY2NRZmxURnArR2NkN3FLc3lVVHdVeXFBTHdY?=
 =?utf-8?B?Z3Bxb2pNRU9xRjN6VFAraUxFUEFpcmtycjh2bTBsTUE4ZWtxWkVMVm1XWExV?=
 =?utf-8?B?dFhnVTNnM3V3dU5KaEp5TEFpZ3BPR0Z4NFRKNGJVcmg3dy9BYWJDamlmOHp0?=
 =?utf-8?B?dlF4UFJndE04WmNRcTJmeFNiV0w4VTR4TnNOV0V2VXFubUMyQ1g0bHU0eVFH?=
 =?utf-8?B?WnFWNTJIY0l2M1UwUnd4bVFPSUpOd1BZN3BmcFRuSFVPSGE5Z0sxRXdxWXdm?=
 =?utf-8?B?RGdTWDQxTXFVTkpUL25FSkdIandTeUIwRXp6QmNTTTdEcDRnWVZaWTE1RkMr?=
 =?utf-8?B?RzhTdHo2SW9SV2VUV3BpU0pIVkVkMVVyNUdqbjMxRWc4Mmprb1BHWEVJblhl?=
 =?utf-8?B?cWk1Q2FtbHhSWUlaRG1CUnhMakI2Tnd0dlFJNVcwUXA0ckw2clE3VzF3aDhT?=
 =?utf-8?B?TFJFS2FZZ3c4bXZVM1lSOWt3VVZxdEt3RHZmeFlmZmtlYkx1N05pVHBGVjV1?=
 =?utf-8?B?anYyN3VENjVORVpoQ0FhRGpaczh0dlN1UWxJdkdQUFZ3Qmg4TlJlZEIreEQv?=
 =?utf-8?B?alZTeU9iVDBOTThxbWt0bm1BcjJFb0RIaSs1SmgxenEydWpaVGJITXlFZ2NW?=
 =?utf-8?B?KzVab3lYWVV5SCtLRHhvemtDNzc0TDArZHlCVnR6WW9LdWxJM1llNXhrOHBn?=
 =?utf-8?B?VDUrWmFxNlZkSGNlMVJTWjFpTS8zRGtZTVNHM0liQVc1cVZpeUxiendTbGFJ?=
 =?utf-8?B?SThQTzhwbGR2aEZZZDZwQkFDdlo3cS9scTRLbjBXVms0WVVTbVdKd2tmNmFq?=
 =?utf-8?B?bnlvWnVvRFZtUHU0Y2lVN0R5UkI3ajFXY3l4WUtBWC9oVkVLcEpzT1NsZ2Rl?=
 =?utf-8?B?Ym5rRXJ2Vzd3Y1RMK3Y0MFliNXJqWG45bEdDeW54V2kySStkUW11bk0wcTZN?=
 =?utf-8?B?ZDNiN1RpSGVKNXhPeUYzRzdyZWIxRHlHcGdISGpma2gvU1FwR1lzQXM3Tlhn?=
 =?utf-8?B?ZVo1elBKVzZJMGNLSUk2dDE4bmpWemdLbW5rbktRYXBYSzhnL29sTkFWSXhW?=
 =?utf-8?B?Z0pyMUJLckNFMTdjaHhjMGNlMGpDenB4TWlyMHB5c3FpZ3JsWE9QS3hVSlI5?=
 =?utf-8?B?NlVSTU93S1NQMytUbzhUOVRzOTJjdzhrR0JLQUdIU0czR3pnb2ZpWWM0QVFX?=
 =?utf-8?B?M0NJS3d1RUphSTZJcVZlTUlNUXR1eGVXZDQxN3lEc3RteHBITVhkdnRka3lx?=
 =?utf-8?B?cUtTRG9SMU8zN3ZqWkJiTW9CYng4NGxBRlpMR3MyWDVSSFN3S3owUnE4TEZD?=
 =?utf-8?B?MHhLQWsrTTZWekhxVWoxbVlCSGI4WmN1SndvbEFiNDY3T1QreWc2MExmN2l6?=
 =?utf-8?B?UHB2QnBiYnI3V3BzQXk3NmFPdUJhbS9nNTFsNmJiZk15UVNtMmRja3FCV0Iz?=
 =?utf-8?B?eGVMWm9BLzlReVlhUHdqK0NrVFFNL0RjTjU3aDUxaEFnTjVQcmxrMUxZVTA2?=
 =?utf-8?B?R24vbDZyaE0rR3hSMkkzTklYajVXWTFqTWxRWTZPUk9SbU5oYVA3WDlLSVd2?=
 =?utf-8?B?NEhPbXczSDBaZHlCZkpVckVaNjMxMHEyWis1THhuSnZ0Z1NJekJWS1JsZzJu?=
 =?utf-8?B?eU5rNnhlZ0tWSjNSM2IyQmxaUHR4TDBlbUhvMGpHTnYvRDhWNTFJa2RHQ3Rz?=
 =?utf-8?B?SG9CclVWM2hKNjdoMnBuaThHeG1ma2U0OXhWQ2UvZzZKSzk5dGJIWXRGb24r?=
 =?utf-8?B?LzlMeXVDalNRTnBSNVl2WVcwVFJoaDcyY0YyNTdGeXJESFpaWjFJQWkweWJw?=
 =?utf-8?B?a3dmcFRtVDNXZDUxRGp5bFo5dTNDK2lwS2dlMzdmbTdOT3Z0OTE1M0dDSjNw?=
 =?utf-8?B?UHJUcE9GWGxNdGxhamlwRnY3V1BHRVNES21mOCtXSlhjNTMvN2ZQUFdubWth?=
 =?utf-8?B?UHNrUVQzMWs3dUtpRGhhdHMzb3FzelozZXdOT09nc1ZBbjVrOU1HWGRXQXZM?=
 =?utf-8?B?UW5SMVowM0twU0NidW40V0VLdVB4MjlHVUJoN002K0tnSGxBU3pjUGdISVJE?=
 =?utf-8?B?YUxmK2FLVmQxRDMyeC8rcmlLbklTcTFDSVkrbzBxVlptMDhaRUJPNXZlWjdj?=
 =?utf-8?Q?Maic=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUptK2FUeGFXTFQ3Y3kwalNPVDQrL2FIZzh6K3hoYXg3U2kxTnVuc1M0NGV1?=
 =?utf-8?B?THIrcmRBODZ1MjJJcWJLeTNtMXJQZ29jZWFyK3FoTytJM0p0U2tOQnZ5U2FC?=
 =?utf-8?B?REtXTDl2VjlKdjRQSStQR0JLWVhXV211ZGZJci80elVtM1hFNEJPdkhlcUc2?=
 =?utf-8?B?Q3hpTFRPdW9EMDdvZEZhTDhRZE5OcE4wR0gzQzFuTEs5d0tQWGkraUExdjlx?=
 =?utf-8?B?RmZHdmV6OTBGY1pYK09SeDNrblBIYnI4MEU2VHNHemNNOFovMEhhdDc1N1FW?=
 =?utf-8?B?TzZIRWF2QVljUmJmbysyb1dLVkx6cUJZV2lHY05Gc3Y4MDJGWFVrOWg1M0dI?=
 =?utf-8?B?cXJzaDAwS1lyaGdDb21sQm81WWR2ZEJxaDZidmtkRUIyT3Rld0FUS2JOQzdo?=
 =?utf-8?B?NUxqZlhqYlozSEV3KzRrWkFIQnI0NzRTN3dFSExZMS94QnpuV09UYlhYV2Fx?=
 =?utf-8?B?azcxREgwMG5vaHNFYlJ0bVJjdkhsZTEyMys2Z3lXUkY3T0diVXFDYWM1Rm5w?=
 =?utf-8?B?VEpaVm5nV2JtUnFqSFRmcmtKWGhkUnZSdkluZVh6RmpPMDM1dTNPNytLdlM5?=
 =?utf-8?B?aG9BRTZ3c0hzQmVIdUwzOEM4K1d1a3hyYmJMSGRMQkJvNnpRUnN4S0dlK3Z6?=
 =?utf-8?B?MzVCZVBUd0p4OTQybUR0R29Ca0hnTnpDM3FHMU9uOU4zTzRxcFZTMUFGb0w3?=
 =?utf-8?B?eEJmN2p2Zm9jd1VNQUl0Mi9remRkdGZGbEwrejVDaThrWXA5RVpUWk1WeHF3?=
 =?utf-8?B?bFRObWpBeFRDeHZmWHo4OHppWHQzZThDZFF2ZDFUWTVFQ1VVYmhGTTVCR0FV?=
 =?utf-8?B?bk14Q1BJeW9JRjJaUHN6OXBXRnlrWmw1OExlaHBoVktyQ3JBNlZHNC83Nm9l?=
 =?utf-8?B?M0dzUndvSWc2RFliZXkwNWJYZ0lxYTZVdjl3ZWZ2ZHdnVXFKa0xxelNNS21C?=
 =?utf-8?B?THJDWkhXemxZMjNoS2E2YmFYQndmQVFqQUhmbEc5SG9KdEdHdmcvR2dlZWZG?=
 =?utf-8?B?UVBwdko4SC9lcE4yRkFvQmRmQTI2TlZlSE4rWlczRWdPcUNENURrTmVmNjU5?=
 =?utf-8?B?aXJ5UUFnRlFlOFdjeVdCcnJCOHRBOGZQRDZsRFNpd1VKcVFPVHdpZUpMakFv?=
 =?utf-8?B?Q1NTWEl3c3IzRjM2ejVZWUhqb0tET1R0MjluRjg5RGJFRmR0Vm5WcHpYV3cv?=
 =?utf-8?B?VXlHSXZXL1lJZ3BhdC9kNERpd3VZb2VUMml6dmlBMHQyLzZpK2FFcXlWK0Z5?=
 =?utf-8?B?MVlKRWRpSXpPcStXNlFOYU12YlBxVWFSamNzQzBMMUZ6dHZoT3VLMHE2Q09q?=
 =?utf-8?B?ZmFQZnAwMzNmMWdodXYvVEJKQzNBQmlJOTY0Y2l4SlZTZ2pIdnFuRTgwVFd2?=
 =?utf-8?B?elkvcEp3NDJLTU9EM2VHMk5KMXNmdFE4R2FoQXhaRnVOMUMrd0tnN0QyU3Rs?=
 =?utf-8?B?OVlkU0p0cjNmOXR0bUVsdXArbXZ1eUhxaFZMUzhud1YzRTNrcTJZSVQzb2lB?=
 =?utf-8?B?RjJUVXNOSGxqUWhDYTFYYkNUbFc4UVdaWUNTdHUzY1lITFZwN0FZWWhUZy91?=
 =?utf-8?B?bWduN0dKWGJtS2wvNHZjUUZaUnRiNEdqRzVFT0YySUxFZVpkSDdwYW1oVjRZ?=
 =?utf-8?B?MHpRSWYxZTYyN1l1TFo2SnJPcUZQUmpLb1VZekwxTTJIY2x5NnFJb25nMjUx?=
 =?utf-8?B?eHdQZ3pMSEZkZXBWbEFkeG1IaWR5djgwM1NCalJ5OEd5Z3VnbURTQVY1T1ZL?=
 =?utf-8?B?R2JScmhnZy9rOGtJT1o3MXIxVVkrRStoUHRTTjRhVDdNZnpINnNNa3dxME5N?=
 =?utf-8?B?RHByS2pnbzhCTVQ2TDZHVXdrZXpFaDllUDRTRjJGR2g0QlF2bFZhQ1c3b3VC?=
 =?utf-8?B?SWVSa3BXU1dGR2RUOGQyRlRqV3BoeGpEUUxEcEhIVGRCTHZBQmZaYXE4WWth?=
 =?utf-8?B?YmNySWhaZVo0RmsxcnhXZDdtWkNtNERTS2pzVUs4dDNNV0x5T1EwUXQvTEdC?=
 =?utf-8?B?dHV2Q01FT2tUdjNKS2JJK2FnUlJEOEJOb1JUSkYvcnYvd3Y2YngxRnIwNGxV?=
 =?utf-8?B?a1dYNEpjWmRaM1RMVVBPaGdQTWtaVGxmR1NaaTdFSTVFT2p4dlFCN0xMY2VH?=
 =?utf-8?B?emYrNk5ZZnVKRTJ4MFRTZUtrM3BFZzZUNW84ZXJaaFJyZjg0TE1heS9ta0Ey?=
 =?utf-8?B?UzZtT2FIZzRmZURsYWRERzhrT3R4bm8zTkVDdWt2Q3ZjaXluQWVDVEo3VGVx?=
 =?utf-8?B?aktFcElyS0VTc2ZqMGFyOENFQUFzZXQ1Tkc2WmFiYVBXUmNQTkN5MEpaWlFE?=
 =?utf-8?B?b3M1cTFaOTRhZ0t2ZndVcWRCeHJoQXFJbm0xclhsTm91ZHNCNkZ6UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f1d8cc-4e56-49a8-a7ce-08de542863c6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 11:22:38.3737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeLBpvIBn2jXGGmVnq8CoOLfAfiIQKOqrfodzVzZzdx3p4G9cpfEP7komMWiEfuVK1SlO89P2BtPiCPaURlKdvEsNYbwV0BjdcF62eRPlxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075
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

Hi Jonas,

On 1/8/26 12:07 AM, Jonas Karlman wrote:
> Add Kconfig option OF_SYSTEM_SETUP=y to support booting boards with a
> RK3582 SoC. CPU and GPU cores are failed based on ip-state and policy.
> 
> Tested on a ROCK 5C Lite v1.1:
> 
>    cpu-code: 35 82
>    ip-state: 10 00 00 (otp)
>    ip-state: 30 9e 04 (policy)
>    remove cpu-map cluster1
>    rename cpu-map cluster2
>    fail gpu
>    fail rkvdec1
>    fail rkvenc1
>    fail cpu cpu@400
>    fail cpu cpu@500
> 
> and on a Radxa E52C:
> 
>    cpu-code: 35 82
>    ip-state: 00 04 00 (otp)
>    ip-state: c0 9e 04 (policy)
>    remove cpu-map cluster2
>    fail gpu
>    fail rkvdec1
>    fail rkvenc1
>    fail cpu cpu@600
>    fail cpu cpu@700
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
