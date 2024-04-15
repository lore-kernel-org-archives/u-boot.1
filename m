Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8EDC00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 14:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A921D870AB;
	Mon, 15 Apr 2024 16:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="FOegHZT1";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="FOegHZT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417B2871C7; Mon, 15 Apr 2024 16:47:40 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BA683334
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 16:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=NhUssbLyOBy8N2lcGKFUXV9a0Ft5Uqxv3ZcmNAhIGQvnOVQB8gYmLhgLGOZJQwgO6rSGJXY2eu1Q9EKu47SyXpydYmQatxJ3HThSjXapq3NNFP3k/BRd2a39j+yi/W1EG8W5yxPDMmZ2GbPm6tgddpY4JuYjdTHN5FYx0dhk4SZkP2a2oVzwg/iRbci436sH4e9JX9I4D2Xh3NCFm1qKrTpcS07acFI3PkCdi6xMerKMDKCgMa9fm6Ol3bq8LsCx+nLlzRj1PS865deM3Uup76SdR2B1hSSXZPVAt0WwyrS/7SsIY1ER+J6S6rtvtUGBn35B4vWx9nQAebuBP5yqdA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDLJt9QlyGwqRc8kGXJq17TbG4LctiB8WADXo5D7pM0=;
 b=ddZG0t1HYDaz5YpQ0qLawpEQqJl2LeeGCPUAxSmE9CMnUTATBCzoWzGZwgrBYhPLAV8LJectu43m6H6AB8L0WwFMtbz2SLAzwIaPaCpLdCUXh4+jMM3M/PXtWibBCrdfsGZ4Ft/BOXyHkA/VI5MR+QtPj3fUnc2v5eDIbp7Rr/XPIq0mmTGC6AQ+JXP5qZdP3FBM13giZ1HZxzRxgntpvqQv6fc4Gslpbhh7TLbZWMx/jCFNwuU3qmdexfeVaM45khnfDX26qOEI7GlyEH7K1/4goFc4pYQtCgDIr604LNyWxw1GYXV81+v198X7LZWVxkELfl2DxKayGz7WtgJLbw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=chromium.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDLJt9QlyGwqRc8kGXJq17TbG4LctiB8WADXo5D7pM0=;
 b=FOegHZT1odxDZcvjqTr2XdybgQgBzRV7C8SRc9wBAkVDJRnhVjLFfNXGAdY8WPIzGv2kFS5YOPD2kb9O36iqcqbduStHkyzkiTG8eDppYsFStvhRwd0wCEVMHVGZH1r7hjv7bP5oaXL5jYt7QeuUew1uBnBRJC7SEMoaCrnljB+RbQMN4paDDxmx3UyakmOswWi1ahZYzEeYHU6Unpzy0f7/txPTtIGWbOSM7TvTTsChyl7wL/edda5DfHxhyY8vgASP4V4mLJQu6lBTjVRGuOBm80f9stoSFpEwFYMUTGGO3/eT9aBBo/E23BLnAnVvWyPdb15V5KEzP716JFVejw==
Received: from AS9PR06CA0420.eurprd06.prod.outlook.com (2603:10a6:20b:461::7)
 by GVXPR03MB10336.eurprd03.prod.outlook.com (2603:10a6:150:155::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 14:47:33 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::4f) by AS9PR06CA0420.outlook.office365.com
 (2603:10a6:20b:461::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Mon, 15 Apr 2024 14:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Mon, 15 Apr 2024 14:47:33 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 D04EA20080F8B; Mon, 15 Apr 2024 14:47:32 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (unknown
 [104.47.1.51])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 71D402008006F; 
 Mon, 15 Apr 2024 14:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+LfpQn+lHaDcY7mGD6erLZK1loWCbyu22h8ItkoKvJBlG6VKrMaFKEV2uDNQv2pk9FkFDY+nz9u8LPKdGMuTTBkK0BGxG6wHcc2hzkttgwRbZiDP8RqVJMeH6n8nbEdda8zJ+s5yf8kblKjZCuhJEhGGi+vfgiS5QjVTLkzFRu58kDWYOP88IMSV41dbkDA29cgHtw3BfHHJneVEfHenUzyAMVoeH9yirH+XJ/88UnX8ilvPAdn4Zchwb+xCD2eNw+hE+q/ss7EOF2LduOMi9mTi89TjeuWvoRd3hLRBk+XaOah+zXgp/Ga2CYz6CLXaMAxAaEy1n7xdhJ17z5IAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDLJt9QlyGwqRc8kGXJq17TbG4LctiB8WADXo5D7pM0=;
 b=B1V2NqDgsbYYWIw7MuYa8+3PXOulKzgpbJyuKjLYiOIguVM5G0lixzXwNWgRS/itqlppKpY03QKgjDJ/78+ppHQF1tDiqXmqj27fBdMypeNpOijOmXF68htDpePqTB1V08n6AR4tjZFxeFe5RUMiBuEL2Nsx8N6vBfo5ehm7OeljT+EAHn314B8PwiWijNmdYMnkSmtxoofhYstvRWK9rEGModv2Gge7o7OZYOEcPE614abnYq2atLeLhIl4hkQNw+9bMFbdh3PhcgT7padanJwMFxgAQP5eFlmp+NS710LSCG+xwOSg+1KcmhPNAEWt8v7wjyEjtPHAB447Kazmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDLJt9QlyGwqRc8kGXJq17TbG4LctiB8WADXo5D7pM0=;
 b=FOegHZT1odxDZcvjqTr2XdybgQgBzRV7C8SRc9wBAkVDJRnhVjLFfNXGAdY8WPIzGv2kFS5YOPD2kb9O36iqcqbduStHkyzkiTG8eDppYsFStvhRwd0wCEVMHVGZH1r7hjv7bP5oaXL5jYt7QeuUew1uBnBRJC7SEMoaCrnljB+RbQMN4paDDxmx3UyakmOswWi1ahZYzEeYHU6Unpzy0f7/txPTtIGWbOSM7TvTTsChyl7wL/edda5DfHxhyY8vgASP4V4mLJQu6lBTjVRGuOBm80f9stoSFpEwFYMUTGGO3/eT9aBBo/E23BLnAnVvWyPdb15V5KEzP716JFVejw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by GVXPR03MB8428.eurprd03.prod.outlook.com (2603:10a6:150:2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 14:47:08 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:47:08 +0000
Message-ID: <2a4de3a9-3520-46ac-8309-a2135dc807bc@seco.com>
Date: Mon, 15 Apr 2024 10:47:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: programmable clock calculation needs
 multiplier +1
To: curtis.machida@intel.com, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240412192641.2912914-1-curtis.machida@intel.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240412192641.2912914-1-curtis.machida@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E0E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:f) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|GVXPR03MB8428:EE_|AMS0EPF00000195:EE_|GVXPR03MB10336:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4a4213-5363-4d89-08bb-08dc5d5afbb0
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?UHJpc0VEQWZtVjlNS21KTlJWcG1kQUdWMS9EeGxHSlU2ZkJYS3Q5NW1iLzV5?=
 =?utf-8?B?QUcyMnY3ekVIZDNTRnlrQjl6Sm8vNDlvRjlERHBGL1R5VUVMVjdjUE5xanRI?=
 =?utf-8?B?eE9iK1NWVHRhVUM0amRXRDIwbTh3VGQxSlBYZk1SdmhBbnlZK0tDa2s1MUpz?=
 =?utf-8?B?Q1NjNjcwSVBDcjR4UDFDWmpyWURrcXplQkVaSjlORE5hM1NiTGRFS2ZINE1I?=
 =?utf-8?B?dUpxZTQyelBkYjV6SnBGYlo3czI0Vkw4MWpRRnRDM3JnSC9iRERRS0ZSYVZQ?=
 =?utf-8?B?S1ZqVFZKQUFGamVyK2RvVkNBSUFRVHdqM1NVdnBIVGczU3BYR2xDNFBCRHk2?=
 =?utf-8?B?TmM2RGFDMDV4VGkxTklYZ0dSY0J6MzF1V1JMMHhwdzFmSUFZNWxta0VUOHg4?=
 =?utf-8?B?WGhlRHlzM2QyOFlhREU3RDQxTTk2VC9FdUlmbHZkQit3OXZWT0FteEFUWTNO?=
 =?utf-8?B?N29kSW54NzlmdURrVE9xMFZ5cENiTXZGMTFSdVRLYk9MYWxRZTl3ME1palBF?=
 =?utf-8?B?ZFh1OVRDczgzY1ZmaWNETk9xY2pxSzFiZjZ3MTRxV3RYYVl4R3RFWXRIamxn?=
 =?utf-8?B?NmE2YzNqU2tMbXlIRFFKSWliRzQvQlN6VSs5dEsyUXRCSUo4eU9mNFVuMGMx?=
 =?utf-8?B?cTZPK1d5SnhwMDhuV092RDJCVExRSFBNOTd3eHJyV1lQOTlaMVlwaEtVcmoy?=
 =?utf-8?B?REdmWkNCdTJOdzBta1EyYlhBQndpbzN5MlZvS3BQRmFpbmx6OEhXc25jaGp3?=
 =?utf-8?B?TFJHazh3aW1JY0laMXg4YzhLRmRTSUV4WTZ5NVNZRUVSK2Ztc29lZDJSWmZ0?=
 =?utf-8?B?TzNKZnVnTGNBaVhFdE9yWi9EWVd1N3pHRWRWRzl1WVdMc3UvZHZOeitFbHpD?=
 =?utf-8?B?dUFrMTR2a3lPMGF6bUFtTG9NMXQyang4M0FINnRmZlRFZVlIRlYrKzdZVjg3?=
 =?utf-8?B?eUtSeEQrc0lRMWZMbXNjcmcxbE9Wc0FFWjdiM3BYTGt5N2hBaUh2Y2REdk42?=
 =?utf-8?B?UEh4Mk5DcEtERURGWHFrVTdNNzczRG95bHZ3UHlnL3djQnZ2ZVV2NlN1S3dh?=
 =?utf-8?B?Z1FSckw4Y2JDcnFMT3JkOUJPSUxrc2pBbXdKUXJuSFB2eXByTThDejkzbTZB?=
 =?utf-8?B?c3paZW13em9HdktWSWN2d0RBcEp0dTZRcjNGWDF3SW5COU0wa1IxSS9BVzR3?=
 =?utf-8?B?OS80OHMvcnRmdHpndjJkazdtMXlXbnhIOUJZd3VXR0lTbVgwb2syMHJmK3c1?=
 =?utf-8?B?aFdxRHBueHJZdGhPTWRzVzJsRlpaRzRER2h0a29pNk4yMWl2Q3BzMjk1dE5R?=
 =?utf-8?B?TzNRV0ovSEF4MUh2S0ZzSzhrUWtXUVM0TmRISE5MYk9ITGxrc3VIOVVyV0Fn?=
 =?utf-8?B?Z2dQOEZBTTR6aW9DNCswSjFpb3h4MU5rSXlKNUF5QkVkVmorUmhRYkFnbExr?=
 =?utf-8?B?aUVHWTNWNVdSbHlPclUwNlpaQUw5a0RJSzhOVnd3UDJXN3JyZTBleHJRNFBR?=
 =?utf-8?B?NWlMMW9nbG5TeC9ycFdxUWtGUkk0N28rQzZrNW04d1JnK3lnT2pDNFRjQ0pm?=
 =?utf-8?B?ZytTRXJvNGc3S2VVODEyODdNeUhmZmtLMDBLZVVab0tUT041cUlQRjBQeG00?=
 =?utf-8?B?RUJ3Q2RnRFd0eFBMNDNWUlRKaHFZNVJTMVBVU0N2eEVmTEkzUlJ6d214QU1i?=
 =?utf-8?B?QStMZHg0VHJrQjdicjhlQk4vOHhpSjlsbDhmekUrUDRwcWVMeGpOVDI2b3Fs?=
 =?utf-8?B?eVl3eklpV2hvek9wakgvNHpUbjV2M1k5dFlXZkNoTUJ3SGtCdCtUN3NRdkJr?=
 =?utf-8?B?cSt5aGpVZUNDelNQd1IvUT09?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8428
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 00324535-bd86-440c-8a33-08dc5d5aecf3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWX81DjSuhGR3G5eL9iv2MXhOHlkWUsgfEHnYtwqIngdhNfv2r6NdZvZUgwbFN9jw1WmPvWMb7pNkqFuqW0rsp66n26nAovMPUd0tnDvDUtVvuLWZk2oDWIbuIK18T/IQZpaGRB+uCfpsEz31chjzFvbs0AauFU1phv0YdMU5s6lCBS1HBDmY9UFV49FUjxYooTjZXlgWePagk9giArtGVa56KQ1FZETvDNjBLn/xACzwsCBa35Q3hSNozIUyo4E8BhMNPX1dYdD0zPWmvdqhGFlTPu9AdV7ukS+lGfWBFAVwqO95+dfnDU7CgFiuDtlIakTXmgx7nuPl1G0JowJzRZvoGWwMvSyIbtYg5H746tS2SXVzPyvo5Jv423RTZOzhJe6HRkFXPkdQ401iD2kjjrnpFEiWVnHkkzjPnOeNlg/m3xlcUgO1AZe6IW4GYRKqoEOWFqqsiJ6dFu1df3QK878ApXprWK+RUH6g8Gnw11Tz4MsmPLAe/oHvQk2huhIOjrCm0R2pekIK7VeHBQAbFVJyHsU9qpusNgsjfK39WZVA0eiUVoivO2Swr3pSuiH7jES3hN6PdBuqBi8g7UxNkU8PdYGcjaadnhrs2uH2LFp3U+k6XPSMQhHb9VaW68SgMrULV1OycZPNnuJyFBi7tdDlPV7lAuuSty5GEZjViNyyYd2sK94r0IgkPvvZYV3oaQ0V9vrGL31cQ/rG/AjeBTk6wPl/1gQcjJTBGOsUjs90O6eJRmdGcD4B/e97DUJ
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:47:33.0356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4a4213-5363-4d89-08bb-08dc5d5afbb0
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10336
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

On 4/12/24 15:26, curtis.machida@intel.com wrote:
> [You don't often get email from curtis.machida@intel.com. Learn why this is important at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2faka.ms%2fLearnAboutSenderIdentification&umid=4f25273f-b33b-4eb3-8643-c1f6eff8842b&auth=d807158c60b7d2502abde8a2fc01f40662980862-c95c2e418b830130ad99c91e42b2732e3f7e44ee ]
> 
> From: cmachida <curtis.machida@intel.com>
> 
> According to the SD Host Controller Simplified Specification v4.20,
> the multiplier value M is one more than the Clock Multiplier field.
> 
> Copied code from Linux project.  drivers/mmc/host/sdhci.c line 4405
> 
> Signed-off-by: cmachida <curtis.machida@intel.com>
> ---
> 
>  drivers/mmc/sdhci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
> index 0178ed8a11..a8476ec4e9 100644
> --- a/drivers/mmc/sdhci.c
> +++ b/drivers/mmc/sdhci.c
> @@ -929,6 +929,15 @@ int sdhci_setup_cfg(struct mmc_config *cfg, struct sdhci_host *host,
>                 debug("%s, caps_1: 0x%x\n", __func__, caps_1);
>                 host->clk_mul = (caps_1 & SDHCI_CLOCK_MUL_MASK) >>
>                                 SDHCI_CLOCK_MUL_SHIFT;
> +
> +               /*
> +                * In case the value in Clock Multiplier is 0, then programmable
> +                * clock mode is not supported, otherwise the actual clock
> +                * multiplier is one more than the value of Clock Multiplier
> +                * in the Capabilities Register.
> +                */
> +               if (host->clk_mul)
> +                       host->clk_mul += 1;
>         }
> 
>         if (host->max_clk == 0) {
> --
> 2.43.2
> 

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
