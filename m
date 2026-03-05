Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B909F47CAE
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 18:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A905B83F75;
	Thu,  5 Mar 2026 19:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="m7wceLbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF46083F7F; Thu,  5 Mar 2026 19:25:28 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74853839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 19:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmSnMmzybiznzeE8uZZ0sGPbC25YRc25zAeDg/eZTWArKcs5u7INARYCVwI/Qpe/5Y8oZk02H0G5/zyED39GdcaGZH4nKMljXoMF+ejZRycocJYWYT/QwfuzytkD6c5yuh5WQkLBjqjHXrliLABAg3AW8D0fvTtxkutANPzobQpFki3anejDQNP5qdXTb8j3h1y9dhmMNsSUfQGjWJgIOWsFrn5yXk6hOtrCt0kFMWz4GQHbPtju+jzmwW134UVgMSKhlgwgjoKwOsBkXAQBev3lcdnsJZ0AuondCt5w3cSnTTHDNr3qn5XmEQLPfxoeRPjIHD0weXUwnI705M2Dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E503opekL2AmtoPLoxbj3DyQ/z5XK+iySS2mLqjbSCI=;
 b=lr4eo2gbuEHVCx7SUczOyOEPOrF5HejLMlvnxrVBF0jwYMioIU6EFKnh10b0iwTcT/8XR6AbpGus8AkUTsrnhz2nTeRGvXx7qSepxw0aTKqjLZS4fVrDSBdR+jIan441nVFLVtB64LVc3IdcdzscGCpITwV6QYqB5Yx0u6CUjJxkbUK21zj6wCPt5GW49BneMvGxvEXG0C0PBWzCmvDL4pSOgmXqJ2VbDpAypt46ngNr2QbRSxqI++0N9MtdSdYzt+zlAVEVZnf3zmtmbPLj33nMX1Zyq+MrEPV+7yVVM1LNG6AIj5+yWTQIGVT6uAi8EzxFroPXiTjqxDUVhNDiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E503opekL2AmtoPLoxbj3DyQ/z5XK+iySS2mLqjbSCI=;
 b=m7wceLbj0XwZQSuXzVeI/Xek0oF4pNSpqM+cAH/kCv8ZK7IJvdamdlHKbNZOP8lz6cMD9LW4PqZc0gGylaXXxRE0gtZ0VLvJM7QH6IgqIr4qExaFhhxYjej26+scHzSytlqPDxpsWiQej3KX35KZ8obYj5H2unpEzJLBZQzxVA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB11630.eurprd04.prod.outlook.com (2603:10a6:150:2c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 18:25:22 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 18:25:22 +0000
Message-ID: <6b21b8d3-848a-4ee5-b5eb-3976f3bddd1a@cherry.de>
Date: Thu, 5 Mar 2026 19:25:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
To: Simon Glass <sjg@chromium.org>, "Nussel, Ludwig"
 <ludwig.nussel@siemens.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20260302220937.3682128-1-trini@konsulko.com>
 <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
 <20260303155335.GO1388590@bill-the-cat>
 <d175c4628cefe9d86ec7e8d44e05a85bf081f1ff.camel@siemens.com>
 <CAFLszTixT1WpFdjPLvza+0OYyUSRJ7c7becTAAfuN4agZnNfmg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTixT1WpFdjPLvza+0OYyUSRJ7c7becTAAfuN4agZnNfmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB11630:EE_
X-MS-Office365-Filtering-Correlation-Id: fd42192c-6a8e-45c6-14eb-08de7ae48fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: WmozG30/qqL1FocKEqCdTF8iCqiOS4NDJTU/eYn5XYpAz4PTnvYR23uhbErrbIErwZjXw+DYvP9gRuFLcFzKMWJlO9P4yKDzoo4dnIoR+lByeb/SLdpZzEwXAwYoZv1va9IVe7sedL9rMmWCaxEuLqN9AVJG1nfqhxS1L/izkdgooxfelyKJjU3t88pZKk4oSU8jgd85KA+sMYn6V32OsebzcyQumWFdBn6Iy+kYQrh/TDA86ET5gYidjlld6Tk+hZvisEYzBdTgNE5vnm+S+dzA87sdls6FVRws2QhN0qU/o4CdG3iVYT5F4DBhG0CzKZDPK9MbvAT3QwVL0kDiUkWV/P8+8sqjpKqnk1G4eaJBaAz0okSJaIxaw4ByzrvCp23mDgTvjs4az+at5GuRTccF525tpTt2DUoR4Y/B3Y9tsRI//tP2DTQARmkzEKOV3gWYqv3JpgkADnwZ2YAbAcP7IxSVnLjQKlDbIUR6iPVTH2F3FmFYF84d6d0N5k5Td+06yBDocjauoW4vst68LGwKPWei0X4ozgaMsxTo3oXSbCxE6i+ucfWsSxuCjmuW7GurzqAsRPLiYhIwFjNsdN7BwEadT3pza2JpvmHjr8x2DH/kElWeBMS/wsfhioF0GvsDQ/lPNcWwKTnMiy/lClXF3qTqp0MCiajGXpah3OgoMCG84Cmzvd+YUZV5hHadWclyO/h7hYUPAgcB+XeDPUqViFpF3Nnb95ddV3tiymw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJNd0FSWElLWUxQdHhaem1JNlkyUkJqYUJhWlBtUXJtK0cvSHRPM2s0SzBJ?=
 =?utf-8?B?cFllYjBHZnNFMGFjdTMxM1djUnVnTCtMMG8ybWJwRE5PUlVQTStMTjQ4OXBC?=
 =?utf-8?B?SHpzanFkM2J1ZWY5dmZrWmtNZ0RQRUdDdGpVY29UN0pMbUl3MngwekFLM2Ri?=
 =?utf-8?B?MHE2dnNsUHpQZW15WVY3cXAveVV5dUJYV2NHbVNzM1VuQ2NPVG9ibHlSQ01s?=
 =?utf-8?B?bG1PcmlpYWJ6NHpyUDdJWXF6U2ZtZFJtb0RwN3pwRTU4Z3dLaU5hSnhoK3pU?=
 =?utf-8?B?eCtLUEIxZzJDK3cxbFdENDN0YUorSDJ5SlNpYy96c0xUREZ5eFZlcG9FRC9N?=
 =?utf-8?B?dHV1VFpzZ1Q0andVUFlOcG5neThRQTZ6WUtsdUk2Tis5ek1JcmVrWS82d0h3?=
 =?utf-8?B?SERGMVZtMmt6K0lKM01xbTF4dzdsWHNGcDFrRkFHKzdNQklLTlBNeU1wU0Zr?=
 =?utf-8?B?SW1mQmZNVllVV1MxZ3oyaG5UOGVWNXZVZk9zaUNrQUxzditISktIeUY2QlNi?=
 =?utf-8?B?alNPaWlSWFkvZXBESDRiWVVubGZ4d2pRSEpoQWlPQ2pRaGx2dTVEd0p4dEF5?=
 =?utf-8?B?WEt0VURQanN0QmlxaStXc2VCQ1JxTE15elJsZVdxc2xPQUpReGdkTDJpaEdn?=
 =?utf-8?B?MFhiMVZIdi9YMlUwbTVmM3ZMdnVlb2crblVaRUZMQUNzT2xXTHpIRlBGbm9i?=
 =?utf-8?B?TnkzbU4yOGg5eDErSURyWWVMejJmakk2U1Exa0FwVHNXdzk3T2VvemlmYWFX?=
 =?utf-8?B?bW1maDlFWXlFVTRzbjJUaFZjOTlncDIza3BLazNkczdoNmdCcWxKMmRHUmgw?=
 =?utf-8?B?c044dFE5QVczdWlUYkY4Q3ZOWHdVVEFDN2NGVE5yZnVLM0RGS01EeFRMWlRR?=
 =?utf-8?B?RHhkb0l4MWRsUDVYOUI1SFdTVFUwTVd1OVJsVmdsKzdaQyt6WE5WY3hoeDNQ?=
 =?utf-8?B?UndJNUQzNnUyeTgrN0o1NWFXSHpMWnlHNytXbWdPNW5Kd1NHZXJiWDBHYnRN?=
 =?utf-8?B?WWtZK2FjdXh6bExyK3FscUJIQzhMRDhvYmxzSFdsZW9vSXJLVWJUT3lycHd3?=
 =?utf-8?B?MGN2ai9CK1FiY1pJN0J5em4yY2RpeVNQVnBQNGJJeWh1U0tDN2NoRGVmU3hE?=
 =?utf-8?B?b2VCbkhDUzBIRjVnYnNWN2VKZEZoZzFRdTlJNDVrL2VtZE5UWHg5VldlQ0Nm?=
 =?utf-8?B?SG1HZElTcURiTXo5UjJaWDdrMFZHSVlIdHpkdWhUK2xwSEI1S1U4UDdGVi9F?=
 =?utf-8?B?ZWhGa2x4NVRTOWw0UzhOckE5ZlJJQXl6OEUzWmw2NG9yb2hWTyt0Rm1iN1h3?=
 =?utf-8?B?VFByU0YwVU43MDZXRW1WSnpiekN1YlpNVG9rM3ZxbW5ENG9aWU9jNG5DK1k0?=
 =?utf-8?B?K3FvaG5iSFlFeU8rTnVwNGVQMGppUnpGUzVpQlh2dUJ1ajd3aWVzYm80cmpl?=
 =?utf-8?B?KytnRW54amdBODJidVNmWGhSWmhtemtWNCtTcFRtc0FDUjF5YlpzM1ppVmlu?=
 =?utf-8?B?R2FDcUVqdWc4elpPc0pweWRoOFdHWFVNMGhVOTNYMi9RcHdjMTBEMGxEUlhs?=
 =?utf-8?B?VmlTZ0ZtRkk4Q0RsOWkwbWpUWWxnc1pUTjVFUlZGdWxxMDQxMFVlSjdlN0hz?=
 =?utf-8?B?UWtTdUVKVzZxNTExRDhNV0w4aC8waWFoMWF4QytVbkZkMHk2Vlp0VHB4M2ly?=
 =?utf-8?B?NDM3ZW51blF0Vm93bzJJQWxLbnEvaElvZ0p4NGFiZVpiK0pOL3R4NjZGeHlm?=
 =?utf-8?B?UjVON29aKzg5NzlUZmt2OFMyc1p5WnhFdytGYzdJTWF0R0FhWlE0cElIMmE4?=
 =?utf-8?B?MzlRdzZOUXROS3lXTGQ0c21WN2ZMcmZUYlJocXYrTkg5Szk2M2dVM3lKaVZC?=
 =?utf-8?B?M0xUYXZFMUExMmJMYjNxUG41ZE5sUWw2cGdneW9EcS9pVE05eFYza25nNE4v?=
 =?utf-8?B?ME4rMnBUZmJwbGk3RVlCanQzK2NTdzZleENZV1VTQUo3KzE5UzZGcXc1WHVx?=
 =?utf-8?B?Q1BTajlWS0VBSE1sbTJKZkhqMDBmZGZPa2R3Q05TK1FyY0tTbVQrYUVleElH?=
 =?utf-8?B?ck1XUUd5OVNMYkVoVWVtNFI0a2RqMnBWcHRNeEkvZDEwdmxCMmhvWi9GeFVL?=
 =?utf-8?B?RVBWdzlOcEhCL0tnUUJseGVacVdreENxNlVYcjVKUU9COGltNncrSDUra2tt?=
 =?utf-8?B?RXpvb0xvbzB4L1JyNmZkN1Q3SGQ4dnFQUFB0aFBPaVV4eS9naldaTDkrcXBk?=
 =?utf-8?B?dmx2ZVoyQy90ek1PYlhIdjRRSUxETHV5SU5pMDQ0M09GM21ObHIxcEowR3Jw?=
 =?utf-8?B?a0krekVyRFF4akU2TVRpYkxhYVA5eTFPaU9jRjN4V0cyRUhkaUk4SHFjK1hq?=
 =?utf-8?Q?nWr4A8dINu8F7AHu36F611of/nr2E3RULOxre?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd42192c-6a8e-45c6-14eb-08de7ae48fd9
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 18:25:21.8795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B57qxEdvLk7uvGUcziD8ckOhl8SkamfzOgl8zfyMcPTJucCxNn5Z/CDvSoFjrwKuECCi6oAmG4d2mkgX0VBygY9UmZ1PsuowXoKEkMOO6c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11630
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

Because this has lots of scary words in the title, it may get more eyes 
than usual including from people not used to U-Boot/ML in general.. and 
the other implementation of a bug fix already on the ML doesn't really 
make it obvious they are related, so posting the link here:

https://lore.kernel.org/u-boot/20260304135202.1535134-1-sjg@chromium.org/

Cheers,
Quentin
