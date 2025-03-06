Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D82DC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 10:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F6280F9E;
	Thu,  6 Mar 2025 11:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IzItzeMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3149B811C1; Thu,  6 Mar 2025 11:35:49 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882AA80E94
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 11:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK1pz0wtIlDD6lv00ZFTuMu377wPqNOVFCTozTFTLoLoDv8HmSodF9z0/K1Zorf/FQ5uyIZdgkWFEQRzF0ImZbsKLldNZCJMHOK4T8VzhEta5uLMmREMrmFfVxMYQxclrx9P56rLlZESYlpS31V6jhi/5BAZOCGuqrO+KYKxVheZruoq4xwlsBcweInlvm2o7gV0g6930Y1lWJESPYwzApDITRmvQ0owJ9iSC3ty1VPuB3MfJiJ/fXm0zYBmVmElvVnKu2Gp4TjsrgMoXwTBQ75qaHsZLLNXmGG8tYI1iPaoW10rTMHO1fzygr6mhDOj8DuACFNSA+MZkrVOhgauNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbeFg/mNz9+veUnPkIaG63S0dcCxlfA40ggonGf+eTU=;
 b=eR9Q0AKi6f2lPokgY9hcpnir+J4rqF6ab3b8wiwMSaWQmcs4Mg9jQAp9QHZ7uB6mIrnQ2P2GBAy1YNyi5NT9ekaExlcIpJLBOOUDabJx1hQRfF+AQRjob0ZdJPWC37LpPR+415NbrahPf3nzAQ+3whUtRXFQxiaN8Zyf8EV/VLGEnbuMqfhD2TtOnbeFsIpMAGqkAGirf25ihx8E7c5HmtwfW050LVntQ+x1QsBKlGzXjCHYWz3I++QeQU7u0CjzWy4md4sjhaHlwEPToO7yI0pL9QGDQkoW9rHybggX6oIUnBvdDwNoxgPKrfuAooI1pRVZsEv20/scj6tfm0fiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbeFg/mNz9+veUnPkIaG63S0dcCxlfA40ggonGf+eTU=;
 b=IzItzeMK1ILklnV7FXfq6AeG0f/oaP7FnH7u2ddSYUKqAl3D8xUZsRk09FeGe7O/OUs1kjS4aqDstfam00xvHCz3pQZCYOtzySF7Yl5DZbm0LBYq5iswN0opapJRZufx2am2mhRbrB2uXhljx5MDS82mKVVywsmi8qcccO6eAYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 10:35:43 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 10:35:42 +0000
Message-ID: <7d3b9a41-59a2-48c9-a0bf-846890642709@amd.com>
Date: Thu, 6 Mar 2025 11:35:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] board/BuR/zynq: initial commit
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Fabio Estevam
 <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20250211124957.104907-1-bernhard.messerklinger@br-automation.com>
 <20250211124957.104907-5-bernhard.messerklinger@br-automation.com>
 <de79214c-088e-4554-9e40-b8fce677bf3a@amd.com>
 <DB9PR06MB855954FEBC17BC680E24CAB2D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <DB9PR06MB855954FEBC17BC680E24CAB2D2CA2@DB9PR06MB8559.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::14) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3d3ee5-19f1-4319-79b7-08dd5c9aa581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnpJbWVpYnRaR1VUVDNWNExHcHBFVjRFYVRaMUpwQWxWeGtHNElnZHRQVTA1?=
 =?utf-8?B?ZzFPalVtRVJyTlRHcSs2enFwbjFMdGpVZms1K05YK0ZQZHFtTzRrbEdEMXRZ?=
 =?utf-8?B?UHQxVEYvUjRTNTh4bDd4WERJdTBZUTRldGphZFc0MU5wNzlMSURUZlhnTGFT?=
 =?utf-8?B?M1k1Q09mQUx5Y3ArNklwZDByK2IzN1FlTTRFV0lMOHJsNGRldkU1b1I0aS9w?=
 =?utf-8?B?TDdYaEVSQVVCNFRPdUhZek9IckpQR0NFYlRjUjFkbzJweHgwTVZSVVVZVHZ5?=
 =?utf-8?B?T2plMURFNFVtSVpQc0czSWlNTmVJZlY4R0l5ZDVSSkJ4eS8vUFFVanVOa3RW?=
 =?utf-8?B?UjRtVEVPM0liS0l6Z1JiOEJ6bmVVNlZoRXl3OWw3N21ETU9mV2M4OS9MRkdX?=
 =?utf-8?B?RElpUWxaMFJtdXNmS1RRbEdNcU9uOVhaM2ptcnAxZHV3Ylk4a2sveTdzSzJu?=
 =?utf-8?B?cEhlTzNhZEw0K29jZ1FXak1nVXVCbGdDZUIvSGhzRlhEK1dYaXYrL2Z1ekRV?=
 =?utf-8?B?Q3dyR0VpSkhxZ2dtY21Jd0pjbjFjczlHc1BiSHEyR1BMQzgza2hJc3VCaXgz?=
 =?utf-8?B?UU15VWZHWlBaMjFPbGpUdDZrOXJHZHNKRy9nUmFmUGRnODlPcEFJcGdDQ1Jr?=
 =?utf-8?B?Tk13aWUxdHVxT29BSTVFUXdLZ0FaUjlCNWJ4S2FNOHVVSHlnbUQrQXpTeUtR?=
 =?utf-8?B?WSs2VlFIZCtoVmhyMXNqckF0TDhyR3N3OUw4Q3Q4T2hzQjJNRWIySUxhYXRU?=
 =?utf-8?B?Z01VSVVqRkJmdFhoWGpvRHJ1NGt4MVVKRXltdVNKakh0ZElYeWVzOWREOU9q?=
 =?utf-8?B?WkJsaUN4OWhaN0RCbXFHbHRBK3lSdTVTT3AvNW1BWUE0OTdOM2xNdW5hMDJ0?=
 =?utf-8?B?alBqSGlOelhvR3lmZ2ZxeWZvL3NlUGRXSXcxUm0rbmUxVG9mY1ZFUmxXWk92?=
 =?utf-8?B?aDFEbXNGM0x0dEI5Q1NSR0lZT2ZiOVdzeHkrMU9OOTlzanVLM0xrMWM2dEQ0?=
 =?utf-8?B?WkdwUDRKdThwZ3BPVmI0NVJuOW83dXcvY3JLTGVkU2swUkZ2aXJyakltUS9o?=
 =?utf-8?B?L1ZORFJya2R6MzVmOWt2TkpPckkwZXUrbE44dTYybzVKT3dQWWpEYjFJZWRn?=
 =?utf-8?B?OVkrcUJWVHJWM2dJVXVNNFJYRkQySWgxTVljSklhR3JXTjVrdkd3LzFsNmxV?=
 =?utf-8?B?emhORXltMTVTVW5ydUNLYXdBSjFCTXdpejlES3dvOTgxSmltUlhsaE01Rjg3?=
 =?utf-8?B?WCtNRlpacklkVlhXM0txNHgyTy96Z0VaaGhwWmI2TUdLeHNmQkJES05idTZn?=
 =?utf-8?B?ZDdLL0VvYTBnN05JMmVkSGhPNnU4Ti84YWNVc2pkS3JqUWFXWlZOeU5rZFo0?=
 =?utf-8?B?TTcreUNzQmpNYmRLKzRSd1ZRdlpVekRtSy9GSjNEMlZHMkorbSs4SStvdWlT?=
 =?utf-8?B?TnRHcXdKZXU0WHNISmZTVllrQXlUNkNhYXpHV204eXdiSmQ3elBxNnZwbXFE?=
 =?utf-8?B?RmNBbEU0eHNBSWs2dEh5aHkvQjl1b2RBUzQ3VjlwT1dGdHQ3MFg1QW83S3Zl?=
 =?utf-8?B?cml1ajlFRzdhM0lxTVFGVjhtT2p1REVYR1FTdldoUW4rMGYvMmRvcXhKbHB4?=
 =?utf-8?B?RDloaDRvbUhzV0RzOXRLNlNRc29JS2g5c3ZWYXZ1WjZ4MWhpZVlyRHVPaWZR?=
 =?utf-8?B?QXR4RHpjZ1EvL2NYK05rV0Rud1hnNlByeDF3N0lqTk9ZRUZ1ZzVPMUZQMEh6?=
 =?utf-8?B?cTIzOGdtcEFxSmRsZ3lkVWNna3R2cXdaTGlheGZsVlZ2Mld3U1laV09JMG94?=
 =?utf-8?B?dFZzNkpGYjFPaUliTmh1dTVGd0IvMWwrbDg0cmluaFB1RTFlcCs4d1BLSDdP?=
 =?utf-8?Q?4V6dxTwQq7Jt8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hjS2U1UlFCZ3FyWFNBWndCYmZrTHZDQitnSUtFSnA0YXVXdllhc2YxQitn?=
 =?utf-8?B?MzZKQThZUk1MYWVCY3pITzZWMWJSY1pxRHNYZ1E5OFVXb2lpUzVPMDdqRmJH?=
 =?utf-8?B?R1B0Q0JWSW5QUGhRS1daSEhJOTV2MHQ4NFBxSVVheFFnem9TWklPWnBxTlNW?=
 =?utf-8?B?NzRhWW1kalROQ2xRdnVYRmJOdFgvMUp2WW9VQ0JlQlB0OUNYVjdQV3pyckhi?=
 =?utf-8?B?T0o5VDlYekQ1cXlIbWcyNVlzQXlFNkptMnVLWDEyZ2JUWHlJTjE1UVdDNzIw?=
 =?utf-8?B?eTRJMUdyMFZpVTBlUkRxTS9jUnI3bG8xelhaLzk5WUplczVMVmRXTGZYQ0xW?=
 =?utf-8?B?Q3BpYXRpQnZPUkEwUFloZmZLYTFUSnA4WnRRS2dYaEhlMFhBeFBIanBoT2d2?=
 =?utf-8?B?TUZrbmVKTmo2a3JFN1JDUU5lQ3FSclZ0djRaZ3ArZVhJSS9sdlplSUZ2NkJU?=
 =?utf-8?B?cEsvRUNHQll6YjlkTXZJckFqeTJRVFQ4am1CQmpRYW1jU01ZZzJSTHl5SXFV?=
 =?utf-8?B?cmtiajIzeEpDK2Q3cTlDeXU5QW5YY09ZUkpUd1RVanhqL3hrc3dlMDd5T21G?=
 =?utf-8?B?eWhLYnNpdDROSFZxTVB3MU85ZkJwR0xHamhBMytBRFFMWmJFN215bVhNaTk1?=
 =?utf-8?B?d29zUVNXMXdpbDRZS2ZaWXp5N1NHc0NRcTJzaGFYRVJ0bFZaWTlFYm03QnAz?=
 =?utf-8?B?UVJrcXN1WnVGSDB6a0dac3J5Ylp0Tm5nRmVrSGlZaElKOTZ0UXI5c1AyeVJs?=
 =?utf-8?B?NTByMDdLMXRTZ2NCbzNrYWlHR05vdVNHRUdyRDVXdnYyTTFSREw5YWlwbTFW?=
 =?utf-8?B?RVM3U3c3cmkrSVlHM0NOUW4rTVg1Nm85TWxLS29xbmxYemk5cm92U1VUQlJh?=
 =?utf-8?B?NUxyQTM3N0dib2QvM3V0YkwyL0EzcXIrRGxaRzJnUHZYYnZCTnc5UmwvWGZG?=
 =?utf-8?B?dFlkTHhCTTV1d2Q2NGlLbFlkR05xaW14WU1ma3JWN09qSEpOeW5haU9VYk9V?=
 =?utf-8?B?bVVnWFdBV291V3hPYjYyNlZka0w5QmVSUm9WWENFVVFFMnRFT2E2T05lenNS?=
 =?utf-8?B?alllWmZoVGVmV2MwZDgwc2hqS0RuSHJxSmFBVXJGeENYZEM5V005UnZRUFEx?=
 =?utf-8?B?cDdPTkhncWRHM2N1R04xQ3owLzFYTE9UaGExdndaN1hwQUhCclR1aEh5SmFh?=
 =?utf-8?B?VU92a3p3OG9Tdit0dk9sM0VnaWZ2a3ZTam5ZRHlHQ1ZmK2JUM0MzK3g0OFFO?=
 =?utf-8?B?U0lmRzI5alowL1NXczJwYllkY2M1RkNPWVpublYzc2daendEMW5rSWxVb1Vk?=
 =?utf-8?B?Y1l1L0EvelRVWHJ6VjA0TmdmYncwQzFIM29VdnF4b1o3TGYzdDVFVWJ1RlFL?=
 =?utf-8?B?Ym9Gek9KV2RsVlJjRFRYbGtQRHAwc3h0NnovUmZKOTVxb29KTEQ0MHZLbENr?=
 =?utf-8?B?QUFtRXJQdm91WVVIM3hxb09YdjNjNjJwdkQvU2xrTEo3ZXVTQmNZNDExYVM5?=
 =?utf-8?B?MG1NM3FkVW9aMGJhd3lpNVRnYnM5dHI2QXpHbDNya05CZXl5YmNLRkdlRkEx?=
 =?utf-8?B?L0JXdVlid1VBay9SWXhYVGdPYjV0eTd3M09ZbzhrOWtEQmNHcUkvaG00T0FP?=
 =?utf-8?B?WkZGRUlSUU5zMTZ5TEJzQVJXazJreHhNSThyeTdpZlVNQnpDcEY5UzE3L2NH?=
 =?utf-8?B?UFRncjJOUW1XSzhrZE1ZNnRjaUtNWXRlSExyZTB5ZlpuOCtJN0NjK0UwSnBy?=
 =?utf-8?B?NmJ0V3ViRy9ycGNPOXQra0tteVU4TU1INWY4d0lxMEM1U1ZLM0xjZnJWbHlp?=
 =?utf-8?B?d213WUJWZnBKOTd3bWhpSTFhaWhCeUZkcEkybThKQ1hTRnNVZ25BdVVOakFH?=
 =?utf-8?B?cjNnM1BxSXJraFlLVnNEVnhyczZXTFBReW8vTUNiTjJONGlnUWRQYkI4WTFw?=
 =?utf-8?B?eWtiVEM3WHNDc3djYzJ4Q2ZtSGJXYlBVZmpuUWdlZEhUdnFYZnNvclAzUUhx?=
 =?utf-8?B?Y2hIbEUzYXFDcEt0dGtlYzFJcjVZUjRWZjFsbFZoVGtHRDk4eUJNNFZnYklm?=
 =?utf-8?B?MVE4ZGhzaGsrWVFYa3dxdU5Ca2pzTCtIaHM2SldhWnRtOUlwZ1B2L2Q0UXVS?=
 =?utf-8?Q?k0OBBCRrw5Je/1fentXz3vLrO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3d3ee5-19f1-4319-79b7-08dd5c9aa581
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:35:42.8924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJhEy32HyLJ1dwyZFP0C0F3CdgcHOUCTlduxLrEMr5nJobErpdKDhUqoh8A5fxjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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



On 3/6/25 11:20, Bernhard Messerklinger wrote:
> From: Michal Simek <michal.simek@amd.com>
> Sent: Wednesday, February 26, 2025 11:23 AM
>> On 2/11/25 13:49, Bernhard Messerklinger wrote:
>>> This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170
>>> boards. This boards are based on the Xilinx Zynq SoC.
>>>
>>> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Remove all unnecessary device-tree entries
>>> - Reviewed led names (no pattern restriction found)
>>> - Fix maintainers file
>>> - Cleanup of code
>>> - Move preboot variable to env file
>>>
>>>    arch/arm/dts/Makefile                         |   8 +-
>>>    arch/arm/dts/zynq-brcp1-u-boot.dtsi           | 110 +++++++
>>>    arch/arm/dts/zynq-brcp1.dtsi                  | 133 +++++++++
>>>    arch/arm/dts/zynq-brcp150-u-boot.dtsi         | 129 ++++++++
>>>    arch/arm/dts/zynq-brcp150.dts                 | 174 +++++++++++
>>>    arch/arm/dts/zynq-brcp170-u-boot.dtsi         | 113 +++++++
>>>    arch/arm/dts/zynq-brcp170.dts                 | 140 +++++++++
>>>    arch/arm/dts/zynq-brcp1_1r.dts                |  29 ++
>>>    arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 ++
>>>    arch/arm/dts/zynq-brcp1_2r.dts                |  22 ++
>>>    arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        | 110 +++++++
>>>    arch/arm/dts/zynq-brsmarc2.dts                | 158 ++++++++++
>>>    arch/arm/mach-zynq/Kconfig                    |   1 +
>>>    board/BuR/zynq/Kconfig                        |  14 +
>>>    board/BuR/zynq/MAINTAINERS                    |  11 +
>>>    board/BuR/zynq/Makefile                       |  15 +
>>>    board/BuR/zynq/brcp150/board.c                |   4 +
>>>    board/BuR/zynq/brcp150/ps7_init_gpl.c         | 278 ++++++++++++++++++
>>>    board/BuR/zynq/brcp170/board.c                |   4 +
>>>    board/BuR/zynq/brcp170/ps7_init_gpl.c         | 274 +++++++++++++++++
>>>    board/BuR/zynq/brcp1_1r/board.c               |   4 +
>>>    board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 274 +++++++++++++++++
>>>    board/BuR/zynq/brcp1_1r_switch/board.c        |   4 +
>>>    board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++
>>>    board/BuR/zynq/brcp1_2r/board.c               |   4 +
>>>    board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 277 +++++++++++++++++
>>>    board/BuR/zynq/brsmarc2/board.c               |  30 ++
>>>    board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 276 +++++++++++++++++
>>>    board/BuR/zynq/common/board.c                 | 231 +++++++++++++++
>>>    board/BuR/zynq/env/brcp1.env                  | 109 +++++++
>>>    board/BuR/zynq/env/brcp150.env                | 119 ++++++++
>>>    configs/brcp150_defconfig                     | 123 ++++++++
>>>    configs/brcp170_defconfig                     | 122 ++++++++
>>>    configs/brcp1_1r_defconfig                    | 122 ++++++++
>>>    configs/brcp1_1r_switch_defconfig             | 123 ++++++++
>>>    configs/brcp1_2r_defconfig                    | 122 ++++++++
>>>    configs/brsmarc2_defconfig                    | 122 ++++++++
>>>    include/configs/brzynq.h                      |  21 ++
>>>    38 files changed, 4109 insertions(+), 1 deletion(-)
>>>    create mode 100644 arch/arm/dts/zynq-brcp1-u-boot.dtsi
>>>    create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
>>>    create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
>>>    create mode 100644 arch/arm/dts/zynq-brcp150.dts
>>>    create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
>>>    create mode 100644 arch/arm/dts/zynq-brcp170.dts
>>>    create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts
>>>    create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts
>>>    create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts
>>>    create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
>>>    create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
>>>    create mode 100644 board/BuR/zynq/Kconfig
>>>    create mode 100644 board/BuR/zynq/MAINTAINERS
>>>    create mode 100644 board/BuR/zynq/Makefile
>>>    create mode 100644 board/BuR/zynq/brcp150/board.c
>>>    create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c
>>>    create mode 100644 board/BuR/zynq/brcp170/board.c
>>>    create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c
>>>    create mode 100644 board/BuR/zynq/brcp1_1r/board.c
>>>    create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
>>>    create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c
>>>    create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
>>>    create mode 100644 board/BuR/zynq/brcp1_2r/board.c
>>>    create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
>>>    create mode 100644 board/BuR/zynq/brsmarc2/board.c
>>>    create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c
>>>    create mode 100644 board/BuR/zynq/common/board.c
>>>    create mode 100644 board/BuR/zynq/env/brcp1.env
>>>    create mode 100644 board/BuR/zynq/env/brcp150.env
>>>    create mode 100644 configs/brcp150_defconfig
>>>    create mode 100644 configs/brcp170_defconfig
>>>    create mode 100644 configs/brcp1_1r_defconfig
>>>    create mode 100644 configs/brcp1_1r_switch_defconfig
>>>    create mode 100644 configs/brcp1_2r_defconfig
>>>    create mode 100644 configs/brsmarc2_defconfig
>>>    create mode 100644 include/configs/brzynq.h
>>>
>>> diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dtsi
>>> new file mode 100644
>>> index 00000000000..f1cf75f1277
>>> --- /dev/null
>>> +++ b/arch/arm/dts/zynq-brcp1.dtsi
>>> @@ -0,0 +1,133 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright 2024 B&R Industrial Automation GmbH
>>> + */
>>> +
>>> +/include/ "zynq-7000.dtsi"
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +
>>> +/ {
>>> +     model = "BRCP1 CPU";
>>> +     compatible = "br,cp1",
>>> +                  "xlnx,zynq-7000";
>>> +
>>> +     aliases {
>>> +             i2c0 = &i2c0;
>>> +             serial0 = &uart0;
>>> +             spi0 = &qspi;
>>> +             mmc0 = &sdhci0;
>>> +     };
>>> +
>>> +     memory {
>>> +             device_type = "memory";
>>> +             reg = <0x0 0x40000000>;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>> +
>>> +     usb_phy0: phy0 {
>>> +             compatible = "usb-nop-xceiv";
>>> +             #phy-cells = <0>;
>>> +     };
>>> +
>>> +     brd_rst: board_reset {
>>> +             compatible = "br,board-reset";
>>> +             pin = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>>> +     };
>>> +
>>> +     leds {
>>> +             compatible = "gpio-leds";
>>> +             se_green {
>>> +                     label = "S_E_GREEN";
>>> +                     gpios = <&ledgpio 0 GPIO_ACTIVE_LOW>;
>>> +                     default-state = "off";
>>> +             };
>>> +             se_red {
>>> +                     label = "S_E_RED";
>>> +                     gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
>>> +                     default-state = "off";
>>> +             };
>>> +             rdy_f_yellow {
>>> +                     label = "RDY_F_YELLOW";
>>> +                     gpios = <&ledgpio 2 GPIO_ACTIVE_LOW>;
>>> +                     default-state = "off";
>>> +             };
>>> +             re_green {
>>> +                     label = "R_E_GREEN";
>>> +                     gpios = <&ledgpio 3 GPIO_ACTIVE_LOW>;
>>> +                     default-state = "off";
>>> +             };
>>> +             re_red {
>>> +                     label = "R_E_RED";
>>> +                     gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
>>> +                     default-state = "off";
>>> +             };
>>> +             plk_se_green {
>>> +                     label = "PLK_S_E_GREEN";
>>> +                     gpios = <&ledgpio 5 GPIO_ACTIVE_LOW>;
>>> +                     default-state = "off";
>>> +             };
>>> +             eth_se_green {
>>> +                     label = "ETH_S_E_GREEN";
>>> +                     gpios = <&ledgpio 6 GPIO_ACTIVE_LOW>;
>>> +                     default-state = "off";
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +#include "zynq-brcp1-u-boot.dtsi"
>>
>>
>> Why? It should be added automatically when you run build.
> 
> This is not case for me since I have 3 base device-trees:
> zynq-brcp1_1r.dts
> zynq-brcp1_1r_switch.dts
> zynq-brcp1_2r.dts
> 
> This device-trees include the same base file zynq-brcp1.dtsi.
> The file zynq-brcp1-u-boot.dtsi is needed in all 3 of the above files.
> But the zynq-brcp1.dtsi file naming doesn't trigger the automatic include of the
> zynq-brcp1-u-boot.dtsi file.
> 
> My approach is to include zynq-brcp1-u-boot.dtsi manually.
> 
> Also I don't think it is a good idea to create 5 u-boot dtb files:
> zynq-brcp1_1r-u-boot.dtsi
> zynq-brcp1_1r_switch-u-boot.dtsi
> zynq-brcp1_2r-u-boot.dtsi
> 
> Perhaps you have a better suggestion for this problem?

pretty much bootp-all can go to your standard files. It is the part of dt-schema 
for a while now that's why don't need to keep it in u-boot.dtsi only file.

And then you have only binman part. You are not adding fdtmap to binman that's 
why I think map is not added to binary itself and you have only description in 
DT. I am using CONFIG_BINMAN_DTB and if you don't need to have binman node on 
your target you can use it too. Then you can simply share this across your 
boards and you will avoid sourcing these files.

M

