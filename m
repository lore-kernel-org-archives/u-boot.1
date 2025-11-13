Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69110CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF77183FE9;
	Thu, 13 Nov 2025 20:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="QrI1P2kc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE95283A03; Thu, 13 Nov 2025 14:33:43 +0100 (CET)
Received: from outbound-ip2a.ess.barracuda.com
 (outbound-ip2a.ess.barracuda.com [209.222.82.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0EC083873
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 14:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11020081.outbound.protection.outlook.com [52.101.46.81]) by
 mx-outbound44-28.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Nov 2025 13:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCMkpx2pVOhyq/BcEICcGcMWz6hCM9hH2wAYhd3lH6p/AS86NV5YeTrYLlM7nqgmvgIMO4wRzvIpBbADwa+RjQggQ5IHIJLjyEXH/mSHQq7PNYC0/G5NRKrhu78OSOuCfvYCXJzafLQi/k+Z0MaOKmEy72n6h/15YJ+yGPnni9Q3oQ4Ug7DkQUPEo7g68YvoBFxrvavXelMLDAvUwZaPElr+NqqIUi2GDUdVfO6xSFLErrlwE6J1bvtTyXx8MqlL3mDpcGcERMffCUI7WIaY6ah2IZQb8qer9rlDKgHUj3ZHzdXBOLaD34BtNfEotZD9bVdy+pUxd2mZw6KSChHhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riTl3cpi523pcrka5H/iYmlzkJr9d1qnnnzlvM14DTA=;
 b=Lvpy1qbdTIdD1PPgJ1snlJ7CgAvdRjuPT2HSUaI+0wIPg3cco9Yh5gMjG9S1+4nsAhljEVjaiWXlMSTlHkjMepEI9FpgXaCWBqa3MWfrWsVnBGR0Qa+BaB5e4Wwb2Ud2tAclGKaoXainH4LNLeRcFbCqgHFsExIWArRaBj8AlqnmzDSOnylQmvwTqSNe9abLocLjjEgQcjOVjHcaaZAf14uwVsn9y58QdUgcxf/vSUVxdSNLK+eJXpuUoXZn4zUkdGVkeJoqkLHapihe0qZyc0f8XCYAe7qyd6yYwvSLT6ouRZ4VVb6xAtzlRv2hi/5/9/Hn/hu7IG/xpAjGSce6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riTl3cpi523pcrka5H/iYmlzkJr9d1qnnnzlvM14DTA=;
 b=QrI1P2kcWaHd4MtC9Gx+O800TWVmdGR3yC2BnpePKXbTZdXxgXprEzGfolMML4gFm1vHG32SXU5TNm78AmvqEqWv1hDkkbK83OSq0h3LsCZ/KDnF346VLVnV1c6UbXstXzFqlEG9VjrkpmPZrb53dlNPOJ7mViEhj0E/OVBFrqf39Kx2wBOqINtlqm/2dPc9oq5tiq6aDN/2/LOIS4RPo363rUvCXDUmiSNp6U4O9n9gw981H/vzr93XrBXGvXcxYGwRbei5kFvSi31tqtyzpQ4lRwq2owf8qdvLHn6B5S65C2elkszSz0w8RDnprAHVrSTspeTHIYVvl5rR3jG5Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 by DS0PR10MB6077.namprd10.prod.outlook.com (2603:10b6:8:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 13:33:20 +0000
Received: from BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d]) by BLAPR10MB5156.namprd10.prod.outlook.com
 ([fe80::228a:7b4f:3287:f13d%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 13:33:20 +0000
Message-ID: <dff97ea3-5b81-4624-b120-ba43da8b280c@digi.com>
Date: Thu, 13 Nov 2025 14:33:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx91: fix ENET1_TD3 pinmux for GPIO function
To: Fabio Estevam <festevam@gmail.com>, Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Newsgroups: gmane.comp.boot-loaders.u-boot
References: <20251111-imx91_pins_fix-v1-1-f9347f896cd4@valla.it>
 <CAOMZO5AD6BQP3WhcP_NBMm33Fs2Lxao7yvbC9DWrPz8q3_5nNQ@mail.gmail.com>
Content-Language: en-US
From: Javier Viguera <javier.viguera@digi.com>
In-Reply-To: <CAOMZO5AD6BQP3WhcP_NBMm33Fs2Lxao7yvbC9DWrPz8q3_5nNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To BLAPR10MB5156.namprd10.prod.outlook.com
 (2603:10b6:208:321::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5156:EE_|DS0PR10MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b1cdf8-178a-422a-54e4-08de22b935fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dm5GT2l1MjBiU21vbnJkWHpGVzZCV01UOTlKdlpHcU5wcXoxa3lDU256Tm91?=
 =?utf-8?B?Ri96emJPM3MxZWtibC9uUDlNc3pjRmdZYUpFN0VtaGJ1cG9JY1kxVlpzQ0lF?=
 =?utf-8?B?a0Z1SlZrU2NjTEowMFIwa2JCeWFtUHVQaXB0TmQrU3BkUHhlWXA0aldRQSsy?=
 =?utf-8?B?RXUrd3k2Y1IwR01NM0VDZm9teE5YbHlWUFdCaTl6cWR0Z2VQMXUxWksxdW5t?=
 =?utf-8?B?Z09lRDBHRzlWYjI2UkFHYi9uVEZjYVlvK2UrOFFMdUtKaHBxMmMxRXVuVndE?=
 =?utf-8?B?L3ZCNXk4T011Q0RCUXNMbkxjcW82RWxYcVJLMmpyOVU2Yk1LUEN3U3lYV1l0?=
 =?utf-8?B?eVlwMm9ib3lSYVJmbGFTcTBzQTZCOG8xc0NiM0x0bW5KbXdoTHhaOStRUG0r?=
 =?utf-8?B?ZVcwbzdqSW5ZR01sNlBuVVhRZmdKeE1DZXVVU2JCTDRyYXhvVWhuQmZQSk9X?=
 =?utf-8?B?YUpnMmlFSUhFdGZQa2taa3RTZFNCUnE3aXNZMXRsVlJTampOdEFhN3J0SEF0?=
 =?utf-8?B?Z0xmTTRMS0VqR04wM0FUOW45aVdVNUkwTklhOXc2WkdidS93VzVIRWhNQWMv?=
 =?utf-8?B?bHJtZlV4Ymd5UUM0ZngyZk9xZGtlQ0ZwNFB6MHoyV29HR241MVduTW1nTDZW?=
 =?utf-8?B?cUNvS1o1K3NTY055SWxUQnBLV0w5TjFBajR6RkEwU05XNXRpWmdLTzlYcnZC?=
 =?utf-8?B?cjFPdVMzbkFEcFE2SDVkemNvQTljNnFZdGpkaHNUdldwUHg3L1ZINmRwRWd5?=
 =?utf-8?B?UUt1OHRGSUx0V29LUDJ0TXJGeklpd2o2dWhnc3g0aGtVL1IzMk43bHRmVndy?=
 =?utf-8?B?czFvL2M3bkVtUDdHWHJBeG1ITi9ST2Ivc2RBS3J3Q21oMUVPMXdNcUJOOWVD?=
 =?utf-8?B?TmFLNzQ1alQ1REx0cE9TbE9qcXJYLzFTcnQ2dmhlVWo1aHNUczVkVWVxS25D?=
 =?utf-8?B?UzNCaXgwOHRmQmU5VDcxdTJzcjZBL0oxZkJpWGtaY0hPN0ZhQ3NBbXBrQ1Ji?=
 =?utf-8?B?enRQRGl0eG5maUxPY3A3Z1phelQzc2wxQnZKMEhMNGFrbnVtR2Z4eXRtN1hN?=
 =?utf-8?B?Rkd1d3RJcE9LMlQrSzVNeWZUQk51RDZ5NDd1cTU2RWcyaTNqRjhXUnJ4MG4r?=
 =?utf-8?B?RUNHRXdtV21sVlllc0JZRUxXOXo3L1QxSndRaTFjeUFIV0w4ZWtaa0VKZEps?=
 =?utf-8?B?MWtmUS9wbVhVeEtyQi9zRytGeklTT0dxaFVicmwyNTN6elZGalhxT0xUcUo5?=
 =?utf-8?B?Q29ZaVpSUXI3aEp2Q3FXOUZFYU1BZGFTWlhqb2NEdlhFK25vZm1Lc05Pc29X?=
 =?utf-8?B?NXkrMk43Y1MxdzV0a0hBTk1LWGJna3VrQUpRSjY5Sjl4VHpVaFRPRndBbkp5?=
 =?utf-8?B?endnWTdvV3VINTdRekM1SVJ2VEhOK1RGMmhjdStzV2FBaTN1QlovcEZaNVhD?=
 =?utf-8?B?VHFicUQyYnR6RWdOaWpIdDhMU3dQTkQ3eXRqK2k2WTE2VklKSERmTmZjbUs4?=
 =?utf-8?B?UUp0Si9sNDJxUzcrdnA1NlJUbXhoWDVGY21Qb2VtU2kzS3Zrdy9ONjVwVk9k?=
 =?utf-8?B?cnJDbG9TYlVYMXY4alIxRFNTNlgrK0M1dVVPbHQ1aTRhMlJ0K2xVYWNUU1BP?=
 =?utf-8?B?Mm81Y3doNnBBSnU4aTdyV3NFN2o4Ky8yTzlnYlM1RDBmc2tyMHhTVGRQTEFt?=
 =?utf-8?B?QjdDU1hpSTI4S2ZkcnVKc0lyNG9PQWVlVUVMY0VuU2JRQTFJektHRGZCTmNV?=
 =?utf-8?B?M21rLzNZOThlQ1B1ajhQMlNtUjBUZkEyNk5ORkNwVnBIeHgxQzYzS1UwVzl0?=
 =?utf-8?B?QjdwNkpETVBGMzNhbThRVDl2eXFtbWRDVW5ieDErNUREL2MrUlZSMWpWbE03?=
 =?utf-8?B?eWxseS85RjhyL1NTNGR5OEJqTnBZRmpPZDZ1YjFNNTRnVExnSDR1WjBUM2hW?=
 =?utf-8?B?cXFYYkJ2N0M3TldtUVplWEJPVTROYjhqWEZaVjROYVk3dnZycStGaXRsK2Zq?=
 =?utf-8?B?UW9HdDdaUndSZ1pkcXhBbnJuUjRUaUQ5NmxnQU5xNkljWmE3SER4UC9LVW8r?=
 =?utf-8?Q?FOucuF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5156.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtrM0FQSVd6ZGdFMXY3NnEyRmdjQmpPUFJuYmxmN1B1ekk1dWJXV21YcmlD?=
 =?utf-8?B?bENBMCtyc3Y4ZEFCbFRwYlVuWThJQy9ybkJWc1Z1a2lTRjVTTVA3ZXZ3NEE5?=
 =?utf-8?B?NldsWUhRZ2tGQXJpZy9XdzFJZTVYRTlGNzNtM3QrekwrTDVKcFlYR0FxMmpK?=
 =?utf-8?B?cm9zWnAwT1dQc3Brc3oyVEU2d1pQRU9Oa0hqYy9LNG1MM3dKTEZnVFlDSHA1?=
 =?utf-8?B?M01qekMzU2ZHZTl6SXdCemRXazZMSDZOWVZuNXI4S2ZaSnRjYzFjSmZZYmtJ?=
 =?utf-8?B?THlHbFNybG0zU0lIMFZJL0k4Q211eVdPdDBaWk95dy9BNS9CUUhBNnhMUjZZ?=
 =?utf-8?B?Z0NVckFSNCtzdCsyQWpEb2l3dTY3VVhFUElVSzRBTkZMcDlKaXRudmFCZFFV?=
 =?utf-8?B?dnlpTlBJMzJKSjJVVVhIY3l3dG8ycEEzVXo1RkVaTG1ONGtSaXlrYnpBTyt5?=
 =?utf-8?B?UXY4Z1Y5MVJWN25DTnFGQWRjNWYrY01jT1psRk5oOGR6WmJkQzJNODRkWjNN?=
 =?utf-8?B?cWJ2eDFUMEJHekFKY0xYd25rdlNmRDdWdFRxQ0RvNUtubnAzeS9XWFB0Tm5x?=
 =?utf-8?B?TS9XOGxFT2toVWYyNmdLWmk3VUkyYnVWNE1mOHR0WmpGK2liNk02NUlER3FZ?=
 =?utf-8?B?SStIT3preFdtOUdEREcrYUpzUUs0T1AwQ2pZODEzOXhoSzJNV3VqNkc5SG1N?=
 =?utf-8?B?elJyZ3d0WVBOOHpaUmFZaTIzR0hLcTFDRk9ESWE0SlZuWm5veDRRRDJrbkhH?=
 =?utf-8?B?K2dyTzJrcTV0Z2p0cGdmY2NsYmo0OTNUdnVvKzZLTy9naHVGTVh5QWQzcWRM?=
 =?utf-8?B?aU84ek1XdW8wRTdpTStteVdjaFBJK3ZXc2xOLzNVNHNnY1RQY2xSVW8yQkpK?=
 =?utf-8?B?Qkg3VXpucUF0TnRDbFJTUEE0a2Q3YjhCZjhqSk1FWmJEQ0pIZTQyUlpDcTg2?=
 =?utf-8?B?OUMrdEljUUhVYmVvVThDQlYzTGc0TGVHbjYwMGpkT2xZSTZTVlZLdW9JSnNI?=
 =?utf-8?B?d09tR2JMMVp6N2hxLytFQmNnWTdablNSb21TTWJYczFQMVMvdE1aSDMzdWJu?=
 =?utf-8?B?TTJ1VENpNU9nSnpOZ0dlWmdJSnNYbjdnM2lEZEljRE5qT29MSGN4Q3JzZEoz?=
 =?utf-8?B?SC9URTRxWlJ4eVczRnFzNnBZVnJJbDN6WHhoSnpWZG5EenBOci9EcnhPZzhC?=
 =?utf-8?B?Q2k5WEdiaXdST1BVMWxPOFNoaXBnbXJrNWVPbmxka20yWjJVL05sWUIwOWxP?=
 =?utf-8?B?RlR0VDBaeHY4a3pwckpXdXlUeGVqY3djam8vYmlBMmFnM3JnbDV6Y0NhV3lO?=
 =?utf-8?B?endwN3dVeENXRnA5cUZNbVN4TUNnQm5IeEpOK2dVMDE5ckhvc1NCMmRvOTE3?=
 =?utf-8?B?QkNtWEpqRDU4NGNsR3hJZGtMQTNuOWhXYVQ3Y1pjNkR5STIzeFZuYnZzNzM0?=
 =?utf-8?B?VHp4MUF2MXdpak1kMW9jTzZ0UDFLQTJOTE9qd0RZTDlVYTdMenladHdZVUtC?=
 =?utf-8?B?dW45L2FKTjFiclBMelFFSmlPanJCM0dqVURlZnlhTXJtajRiWWdaNUJkSld1?=
 =?utf-8?B?RWpjRWU3aTMvVUNqdGpqZ3M1UkRWSVUvN3pmMGpjSkRxWWIyZDkzKzQwR29J?=
 =?utf-8?B?TWZxM3I4bUhXc0ZGQ3RFeG4wZjJTU0pFM0VRRTdudEpnZGw1WVcvampVUi9n?=
 =?utf-8?B?MmRTc0hUSW1YR2xJYzhRK3YyTGpaTEoyTHp3WEhnQTRlejN5UjJyMG9RYndk?=
 =?utf-8?B?cWNneUhrUkdSNGhnUk40M0ZOYUZ5VXA5aWtqakZQTkduL0VMRUhJbitHSCtn?=
 =?utf-8?B?RTdGTWZFdmpDREd5eTlNb04wSlYzbGlHb1lyRkJ1aWx2eEZHTXNXVDJKNm5O?=
 =?utf-8?B?UW1SbW92Zmk4VnhlKytvcVM5dUpsU29oeG5ONmptZHZWV3Z3ZUQ5N3VWd2lY?=
 =?utf-8?B?Q3JyWmFJVEY0TGR6UGpOS0hJQURzTjlheWxGMXNvM2lrR1V1U2x6OGNHZ3ZJ?=
 =?utf-8?B?YkRvSkdHcWQzeFBHdSs5ZENEdVRyOGlldEZJS1VSTzMyczZwbER5Kzlla01T?=
 =?utf-8?B?eFpwbElYS0NEaEtGdlhSUE8ycm16QTMzOHUrb2FFdVVTS2k2Wkk2dS93V2Zl?=
 =?utf-8?Q?XdQWZ53x2clsBPCEx3jerQb+v?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b1cdf8-178a-422a-54e4-08de22b935fc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5156.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 13:33:20.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isLXrvZaWb0TBYxNhIdTDa8WPFTnTBnrrKwbRrohLMQMRR4Flh3GvQPSPCei5BtRujuYu9ex+O+m1K5VkqgkQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6077
X-BESS-ID: 1763040807-111292-7686-3224-1
X-BESS-VER: 2019.1_20251103.1605
X-BESS-Apparent-Source-IP: 52.101.46.81
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmaGlkBGBlDMKNXSMjktNTnJLN
 ki0cjYxCDRJNUk1cIwxdA8McXQxFKpNhYABDceXkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268919 [from 
 cloudscan8-51.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Thu, 13 Nov 2025 20:23:39 +0100
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

On 12/11/25 22:15, Fabio Estevam wrote:
> Hi Francesco,
> 
> On Tue, Nov 11, 2025 at 10:19 AM Francesco Valla <francesco@valla.it> wrote:
>>
>> Fix a typo in the GPIO function for the ENET1_TD3 pad, aligning it to
>> the function specified in the datasheet.
>>
>> Fixes: a9d562daa3c3 ("imx: Add iMX91 support")
>>
>> Signed-off-by: Francesco Valla <francesco@valla.it>
> 
> Nice catch!
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 

Just for completeness, I think there is another one: 
MX91_PAD_I2C2_SCL__GPIO1_IO3 should e MX91_PAD_I2C2_SCL__GPIO1_IO2

--
Regards
Javier Viguera
Digi International Inc.


