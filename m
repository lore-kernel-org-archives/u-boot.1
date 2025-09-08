Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CE7CAC582
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A60F5809A5;
	Mon,  8 Sep 2025 10:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bIv+ZbQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5251F82AE9; Mon,  8 Sep 2025 10:50:02 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3AD800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO25D8/IyyeaNg084lmq4jVYW7W+kIi3GaOOh1j4Xj2vFwmqbKgNQ4F7LdZnLID/NjUF9YVvDiVgm34gVCTNUxZRvIc3l1wO1P5q9+XjNyuyaDdQfaU+jRq+9ch8dTNxKaasPR3y7WuuoZOA7wJkYSN7ccLwqjLbtD8EApQK6hh+rMJMVEXz25rtLCmiRAsHvcN785E8CGjLWBe1H6KM1EiEXEkpiOjQrkhwLT4VFkahggnqLwMCUP2XaW45UezR36ppNGtf2aFBkFN2hqnePg6putwgh7tYkuEmvEd+ZZJ8D3+ddeyiszK+tY9lIQJZ8HzjeLo8eicgYL6IdxK99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9svMgVx8X1oDoSFoZTrozgPHk6vqaSVLYuTPoFhO6c=;
 b=M6OhvJJjAgeik44Hxw6aNxCHooRKdBFosmoRat/RPx8VbwmN789kgykZXxgHS+F4A5JbMd2KvEcsJxxtyoP5a9G4BhStIsUNuGIdSFBxTE/sovq6JU5RsTI6sn6lX8fAhWZd3YwlULBUaP8gWyEcXVDZujSu70/RaYNiMssXfvtIQVKEtXVnc0RCNszJHf7EFuZdSRSw54b2Bz9roHpLT7ZbqLQ9UIbheZZsGHX/OnzGQrnmqq50UqYClOfgeFC5WoQjqO8dQ8GIegqVckjg+ModjSyCzH7bUFuljGhSIwFmMVo8ceTL5ZpgX4YPRoLfQwa1tBE2qEDHie486AY8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9svMgVx8X1oDoSFoZTrozgPHk6vqaSVLYuTPoFhO6c=;
 b=bIv+ZbQd+Q6hf/uCXwUD/731V/mc0eaGOZaw34VTWB5TiSIYrp8F1UXAZGXYMnVbgWSP2sc7sXRerxKo/bnketzfmk14KYWHU/jgkyJVfIpRO5mwi+juTBfbTd/w3fQPpJSIOxL99FFMR9gp5quy+HOlTboA193OqfESbqoipzB2UaaCi6+GkdVjgxDT9LegkpGrdYwVAYrgNljFLsSJr5JoG4+zbvqyTltRLqfypr6nhubHPOB9iyyjKHq5krll51ZtZb35dHprmtWFrULu9ybvr5S3xQ7ZjSPG04DtzDnClkj/D/AtEQXg9oFRXdeCkbSvQEJKdzVQs90zZ8Y1Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV8PR03MB8140.namprd03.prod.outlook.com (2603:10b6:408:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 08:49:56 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 08:49:55 +0000
Message-ID: <a0f59cb8-be2c-41e7-94d5-a039783ffa60@altera.com>
Date: Mon, 8 Sep 2025 14:19:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
 <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
 <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
 <bff0c320-35bd-4129-9e19-4ef4103ba923@altera.com>
 <ea637053-8f40-40c5-b257-e582dbbc3c1b@mailbox.org>
 <3168323f-8cd4-45a9-914e-fb79cd346d67@altera.com>
Content-Language: en-US
In-Reply-To: <3168323f-8cd4-45a9-914e-fb79cd346d67@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::13) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV8PR03MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a57e8e-6108-4cf7-8adc-08ddeeb4af25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzFDSWlIejRRcms0a3hGUkM2NHc0TkFhUUF3MjJXYnBSa2FBaUFTQlNPNVlz?=
 =?utf-8?B?bENRMWZYdUw1SWJES0hmNGhIRytqWXo1MU91eW9aeUJLL1daNDVDUE40UG9N?=
 =?utf-8?B?NkRDVzhjTlowcFRwVitFbWdXSmJBUVY5UHVLOGdRUmE4V3ZaL3JDVXdsSkFH?=
 =?utf-8?B?MEJITWo5MkhsL0VWa01wYXo0MGJrb3lXYTRSZ3JMR1ArclFLREtZb1NFTnZG?=
 =?utf-8?B?T1FuZ2dhMkNxaXpIaE9OSVBiSWl3ZUR3aTBtWTVaOHNTbThIUWZlSFV3Rkc4?=
 =?utf-8?B?TmVFdXpJOGwwS01FdEpEOGptc3NCUmlDNjhoUENhR2lQT3c3b01SRDBUTTBR?=
 =?utf-8?B?eTFoUkUrQklBc3ZZemM1R05JcXA0RE05NGdnOG0vNDJMSXNRVCtOODJ4WHZE?=
 =?utf-8?B?N1dTNlVMQVFDV1NvM0UrVWRheUFlR25oMkpTM2ZWMkh0RnBHd2hVSndmeGM5?=
 =?utf-8?B?N1o1TWh3d1dpTEVMeGhxa0dFcURhZXlSdk9jb094Z3FtNktYbUwxZk1Pdks1?=
 =?utf-8?B?VTNmdUNlYnluWWd2dVZsd1RnVCtGenByMkROdThUd2hZSFpjQUM2QWxVTldv?=
 =?utf-8?B?eUtROTArdXMwaVNudkVlVmY5bS8zZStnaGVsRUI3REkzRHVWZ1JnVVlzSjNh?=
 =?utf-8?B?YXVHZ0JUMU4za1NXZmdabmw2bFI0MXp3c241TS9qdGJ0Z3YrKzhTSis1SGJw?=
 =?utf-8?B?YlZNbHJ2TVlnQmtkeWVjWVNrd1dlSXVlRWRvYy9LYnFvc2RJZUh6VzdjRHBL?=
 =?utf-8?B?djgxb2xBRjk0N1V3b0ZLd08xMjIwektGNW5PUTF3QlJEMThvQXNFblE2V1Ry?=
 =?utf-8?B?NzRDb09uS1kzalY0VmZTN3dRV21pN1NTbit0ejZTQmZMTFJXRFlKM2FVVTZB?=
 =?utf-8?B?MlIzS0U5TkRwcHJ0YTkwT2RjK1c5Wk5qNytSWXNRVUxmNkNLRUVEN1owRHFh?=
 =?utf-8?B?Z2tIWk5NOWhiMHgrblBSNU5pOTFqZURKREgyOTJEaFBGRGV0L0Eya3p2bkJl?=
 =?utf-8?B?T2dITVRMcjl5TGZRMkNWdHhOYUtjUzJNS3ZkeWJabzJEZXl3bk5yalpuK2lM?=
 =?utf-8?B?TDJXbXBZd1hsOFpQdDRVU0ZVNzk1ZVEwUG1BVkx3bS9IZytNY2w4cldCVDVO?=
 =?utf-8?B?U1NUczJwMUtuVG1KOWZVMjFPVkY3Tm5rRGxEemlldnl3akw5RkFVUVlzRnNq?=
 =?utf-8?B?WVV4QXVTeldaYmF0aHp4ZHplTURvN3Qxa1poRkZtMVV3K1Z6WWhVeTRKdkpO?=
 =?utf-8?B?S3Bjb21EbUl6bU5zajRyY20xaWJPWVViNitlNTQrTitPZ1pMZFVTMlM5THZl?=
 =?utf-8?B?VGlzSFk2WmExQ08yTTNJamlFOE5JeHhLN0RTZHk2R2ZtV2JPbHR5REJ1SW5L?=
 =?utf-8?B?NnV0RUZMekl6K21KVmI1TmlnM3lLUTV5aVl4NmxFL1l2SnFyMklDMENnODAw?=
 =?utf-8?B?a1ZPQ242NzlMN3FFTDdCZUhGWE8vcThBbzZpbFcwdlEycWh5QVVrRkZQcW12?=
 =?utf-8?B?WXlTeTJNeWVTNDhBdWZlajE3MTdDN2p2SndKVThvdXBBZDZhcm1oYkowVjBS?=
 =?utf-8?B?TjlReEduRDdJaWRiYTJBTHJHZTRCdFFnSWx1dXg0NXhySi80QmkzYldrdnpP?=
 =?utf-8?B?TjdDdDd4YSt0VWVhWGpxbzkyVTh0UE5QTVkrdktUN25XUUhlbnBLTWE0Wmo0?=
 =?utf-8?B?YTVHb3hzTGk5NWpVQnJEZ3ltcEVCVjV2YTBKd3YrMW5tWWNyVUh3SW5ZR3hZ?=
 =?utf-8?B?VlA3aTQzTmtFeVZYeXZramFDSWpOU0d4clBnR3hJRDN1bDQrRUNtdkNha1d6?=
 =?utf-8?Q?3LuMptD7nXUARfbHYLPvI1MOFPGXWYxwVT0uw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWFUYmlhTmF1c3hhR05TNXRqMk9vR28rSDdoeUhCVzBqSnNMWUtHbVU3S3h4?=
 =?utf-8?B?WVJhOUkrc0ZxVGp4ak5oZWJRRno2M0hBeXA5YXZNNUppM2kxS29JdHRiNHh6?=
 =?utf-8?B?dVlEdnU3Y2V1Z3JJdlFISi9uYTVsZkxka1JxZ2tMVlgreVJKOVQwdEtsUnlx?=
 =?utf-8?B?bmVId05UWEVSenNHS1doRitRREpZOTc5d3YzM3ZqVVZtMXVGcFdqNE52ZHdn?=
 =?utf-8?B?YlRKNWJKT0IxbVROcC80cEU1WWpldE9nb1ZEK0tJVHNHa2xKelo3cnVIRzVp?=
 =?utf-8?B?YW8vZEMxeUk5bnhXRm52UnkvTWJXU29helZ5aEpVWENLdGVtb0NYT29Gdm1O?=
 =?utf-8?B?L3haN2tjYmRaNS9FL1kwcGp2TjVCcXNjQnhaVnU0NW1pdzlCYk5YY0FybG55?=
 =?utf-8?B?aXNKUUMvaDlpWXFYK3dpM0VJKzFmRmJUMlNHSy9aNjNLU1dFeTlBUXJlUHRp?=
 =?utf-8?B?aTZBS0pkaXd6V3ZWdHNIMUZzRFFHSmh6Nnc4OFdQU0IrV0VPVVZycHdzck9G?=
 =?utf-8?B?T3VqU2NxVnZsejMzSy82YUpHTFE4TGFiWEc3UGVqcW4rVXdiZERQdzFJWlB3?=
 =?utf-8?B?NnQ2WmdFbHNabGkzQkxMMTNPM1JlQlRXL2dHTnNkZjk1TUt5bi9idm5NZ2dI?=
 =?utf-8?B?R1JiWVBvTWZEWWt0ejlqeUtwWHdLWDZ3YTFtWWVaSXQvbjVjZzZpQTRzQUx5?=
 =?utf-8?B?b0dUQmsvWGJWeDVnL2J0SWYxc2RMaklaem5wQXJVaURwcDM2azR2RjRQRTRL?=
 =?utf-8?B?eGt1cjJnL3dOb1UvS3AyeDk4dk1pcUxOU25DR3EyNzJHQVIvNGFrencwUHgz?=
 =?utf-8?B?elkzUVFUYVRpUWZ6dGVpVzJSRmVjU000aXROdmRVZmpwWWh2M3YyQjFZb0M5?=
 =?utf-8?B?c1lBbWp3Mjl4NFdvdjgxb3JpTzhCNlRSMWF2VG9xcG5MWkt4eC9EdEg1bVhQ?=
 =?utf-8?B?cFE5eUlOR29jWmRFYjdNTk5vdkFlUk11VDk3c1E5RVNKUkNKNDRkWEtIQ2g2?=
 =?utf-8?B?bDJDVmtjUktMMlEyZ01DUWJ5UHk5MWF5azFZWUVPWDkzUGJ4dmtQTGc3YnpS?=
 =?utf-8?B?S2FXeDZKcHJVQWFCV2tFTEw0MkhQekxLYWJ4ZVltS0t6dzZleWtMRUVObUFW?=
 =?utf-8?B?eUNPTEtVeFBlaFd2MUtMMXB0MEwwWVF6YzBxVjAwMVRkdExBL0lod2pYUnBR?=
 =?utf-8?B?bzdoa2NvVHc1d1BPRFhKeUI2eU5rdEYyNm1rcDJXeUtsYUY4cnAvN0FjZHJY?=
 =?utf-8?B?bVY4ek9EZjU4OFJjcTMrV0RKMXFaRDRRSGV5cVk4YlExUGROZjVNZkZUdk9s?=
 =?utf-8?B?emlvNGcxMk5KZXI2MS91elczaUgvUUVFUDRkZEN3OGlPczJTbHZXeTc3d2ZB?=
 =?utf-8?B?QWhSUGJOWi9qYnFrM1VoTDFiTTZWRlhGYlFqYkl5ZWlWU0dTalZ4dTczb0xN?=
 =?utf-8?B?TXZYamI4UjF3N2JlODNRMExMVGdxN20xb3RkYXovQ1VrdDJqNklmdkNaTklK?=
 =?utf-8?B?NUtEZjVqWXpYeHBmT1cyVTV2SGFIRzM4dlB0WG9WQ1cwdWNUMm1NN3g0Z2R0?=
 =?utf-8?B?UFJyK2lnb29nQ2loQ0dQNDNnVE5ZSitIdEQ2V3h3bkh4V0JRcDhOWFhNR3lt?=
 =?utf-8?B?ZXpOTXhSRFFnSkhTYW9nZThiS2gwUFdic21CVTc1Y05RRjFOazVsWnZ3dDE5?=
 =?utf-8?B?SENMc2dJUDBUZ0gycVBHT3h1bmQ3ckJTZSsyN3dnckowczBHcFVDeXQvSWFn?=
 =?utf-8?B?NDM2dEhMYmZhNnVBTUNUcmc2ZlBKRGFxOHBZaUJCR3EvQkUvaGhBdEpvK1FG?=
 =?utf-8?B?bk03REtVZS94aGgyZFVoTzZDMy9naDZPN0NtWDJ0ajJiczNJbXkyRVQvNzBB?=
 =?utf-8?B?YzArQnNjVXU3YU1Mb21STkJjblVjUTFzNncyQWZQMGgrS2VnaTViRmZkMlhL?=
 =?utf-8?B?anhTNDVNUXRETFRTb1JXVFJ2L2RFakRNR20wbTVPNHg3U1JjWDBjRjYwNzRx?=
 =?utf-8?B?anMwbHk0d0lnZFF1V0JSV1I2d3FMdUV4Y3QvSXRFVXRmL2dSUWFTKy9VcFJU?=
 =?utf-8?B?ODVRakZCOFBqL3haU1JpK3NRNTdqaktuY1V4ZjN6NTdtcW11UVpaSDFqZTBL?=
 =?utf-8?B?Z25wV1FaK1V4SDh5MnBYM252TVlOL1lyeFJ1MXdKcElERnVMSzJWUGFsaHM3?=
 =?utf-8?Q?jS1EXKJlRi9mXNEpK4k471s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a57e8e-6108-4cf7-8adc-08ddeeb4af25
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:55.8028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3WU+y271v7J6m+IuM11675e6g1HdakBVMRFtpDWBoqN/IyM90bXCDu2CoKjLdRsqGPgkt8WcHKfqsskePpSUt5TmTAuexQJXHl2nFzMNYoYzswHXTAPpUH82sZHy4jE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8140
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



On 08-Sep-25 2:14 PM, Ravulapalli, Naresh Kumar wrote:
> Hi Marek
> 
> On 02-Sep-25 11:48 PM, Marek Vasut wrote:
>>
>> On 9/2/25 9:52 AM, Ravulapalli, Naresh Kumar wrote:
>>>
>>>
>>> On 30-Aug-25 5:30 AM, Marek Vasut wrote:
>>>>
>>>> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>>>>> Hi Marek
>>>>>
>>>>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>>>>
>>>>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>>>>> Some USB devices need more time to be initialized. Hence,
>>>>>>> increasing the default USB Hub debounce timeout value for
>>>>>>> devices to be discovered, connected to Agilex5 boards.
>>>>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>>>>
>>>>>> Which devices are those, include that in the commit message.
>>>>>
>>>>> Yes, timeout is related to USB connect/disconnect signal bounces not
>>>>> about bus stability during init.
>>>>>
>>>>> Issue was mainly observed with legacy flash drives. Maybe I will 
>>>>> change
>>>>> commit text from "Some USB devices need more time to be 
>>>>> initialized..."
>>>>> to "Some old USB flash drives need more time to be initialized during
>>>>> connect or disconnect events ..."?
>>>>>
>>>>> Note that I am not modifying the default Kconfig value in general;
>>>>> change is only made for an SoCFPGA devkit we tested.
>>>> Does this same issue go away if you set usb_pgood_delay to 2000 or
>>>> higher too ?
>>>
>>> No, changing USB HUB debounce timeout is working for us.
>> Look at this code:
>>
>> https://source.denx.de/u-boot/u-boot/-/blob/master/common/usb_hub.c? 
>> ref_type=heads#L199
>>
>> "
>> #if CONFIG_IS_ENABLED(ENV_SUPPORT)
>>         env = env_get("usb_pgood_delay");
>>         if (env)
>>                 pgood_delay = max(pgood_delay,
>>                                   (unsigned)simple_strtol(env, NULL, 0));
>> #endif
>>         debug("pgood_delay=%dms\n", pgood_delay);
>>
>>         /*
>>          * Do a minimum delay of the larger value of 100ms or pgood_delay
>>          * so that the power can stablize before the devices are queried
>>          */
>>         hub->query_delay = get_timer(0) + max(100, (int)pgood_delay);
>>
>>         /*
>>          * Record the power-on timeout here. The max. delay (timeout)
>>          * will be done based on this value in the USB port loop in
>>          * usb_hub_configure() later.
>>          */
>>         hub->connect_timeout = hub->query_delay + HUB_DEBOUNCE_TIMEOUT;
>>         debug("devnum=%d poweron: query_delay=%d connect_timeout=%d\n",
>>               dev->devnum, max(100, (int)pgood_delay),
>>               max(100, (int)pgood_delay) + HUB_DEBOUNCE_TIMEOUT);
>> "
>>
>> Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
>> should have the same effect. How come it does not ?
> 
> CONFIG_USB_HUB_DEBOUNCE_TIMEOUT and pgood_delay are used for different 
> purposes. If I am not mistaken I think I explained this in my earlier 
> comments.
> 
> Anyway, to further elaborate, CONFIG_USB_HUB_DEBOUNCE_TIMEOUT is used 
> for debounce timeouts during device connect events and pgood_delay is 
> used during initial VBus stabilization.
> 
> You would be able to see this difference in the link below, where 
> pgood_delay which is populated into "hub->query_delay" is used for 
> voltages to stabilize before initiating communication and "hub- 
>  >connect_timeout" where "HUB_DEBOUNCE_TIMEOUT" is populated is used 
> after getting the port status.
> 

Apologies for the earlier link, please use this link, 
https://github.com/u-boot/u-boot/blob/328747974a0620d0996113fe2b3906b06e96de00/common/usb_hub.c#L455

> 
> Also, the change made as part of the comment is not applicable to the 
> USB stack in general; it is only for our devkit defconfig.
> 

