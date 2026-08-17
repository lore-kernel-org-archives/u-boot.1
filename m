Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C69C5DF80
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF0A48102F;
	Mon, 17 Aug 2026 18:17:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KKQgy1BrcdG9; Mon, 17 Aug 2026 18:17:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7038C81080
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990638;
	bh=cxIIuCaeJnef6SOB6ZB2qYP/iAwsaSXB3JHUoNdZgxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7yba33gZijOoGdUcwy9PRkM+ykrIikvclwMG/fEwVvExMsYrd3A8LNtBHIVFFwjN
	 epSHejEF0kkrFwQn+AYe9OjuuqVpFg0JpnPtKYD4TOlkejwGvvOKJsiSTS1t6+Ul6r
	 8OA5YEgIy1RC0K9efWUvCCXO7srxaGownsPBSAJMKlxWpJIC5A22ckDD5I4OKiAaga
	 7CgQQp0tY/9fVgeAxwnfIu74efUvWVNL6ZgNwrb4F9bu8t3ATDtj2CovQddzlUp7Ca
	 gsWhj1Zj6C0nYjpJvxSi12fuZGiDPHOIz/nFsntkgWt4yGPFXVtNs/J2V0FvDZDy3Y
	 AyoTsSdd++Jsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7038C81080;
	Mon, 17 Aug 2026 18:17:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6734C282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58BC5406A8
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qTpJqeWpWNIl for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:27:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6DBC2406A1
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pa.msu.edu
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DBC2406A1
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=BMb4swwd
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DBC2406A1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMrKDZgxPArT8Ncoycg11sv9kBhUk2urmyRLIViQyfApAxVxAC8mDfVGev1vtWhlsLUvTQcl0ybo7ooIqniO6Ej783eqVwMh1oCSwhz6hD/ThOjle46zTuBCF+MApxABGq7sdrDEhLMWuVdo04qzdvzhIT7WHh/UoOPzGUOIL6zY7KE1YSeyWAJx8BzWIBnxWDoDFYHSIxo2xEtQk9vYmmKzA2NxXDeNfm6RM1SnEM+ztd+J1GtCXPtyEgQgBeMw99kcSVGLlSZRmmX6brOP1HqEwAyoaHULUe7PnXzs9RDqviBCk5+X81aG7PqKzOJQp4r376tKnXwMYTkd6R7tNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxIIuCaeJnef6SOB6ZB2qYP/iAwsaSXB3JHUoNdZgxw=;
 b=kjYXNBw2Sa3dlc/k/nsxVP2ZUDA2KzBomzDMLpoo/rpSnFxmnxWIdMEQq3Z0x3qvFJwX0n+EA0CNUkmZPfUw5Gfjb1V0zJzuIKtRRk7x33Emw7wgJV2Z/KMrx3RFcOkOJPGuAiRFFIY8kza9uDj23fm1XfU0N2bAlwmjDW3ytTUyI2kv0BoN4ovCOJ64owQla2eG7MeZgRONwiUk7nNlqLZS3rXn4lSsgWNXmITSHDv1lyOfg0SW524VhnsPnAFOVyraJYLnj7Z4RzcllE+MG729YUOHp32Le0Fbm4DoUXXtMbTZPHkl+pKhilXSTPJ650zoyBZ9QLLuNZJ6VnRGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxIIuCaeJnef6SOB6ZB2qYP/iAwsaSXB3JHUoNdZgxw=;
 b=BMb4swwdzxWpdm87JmJJL5Ntlb4ZpbXuTOpk1XNtupRT3xzfDe7bttF/Ure8qVKrRPOpzFXp00t0lYrNejg19+sH+SbUgFmdzOXSc3FOVh2Qj7LeE6jDVVdSzzvXZoZ277BBkXIbAtXn9CyEWbsHpSeAcBxWF/Z1ZLORlD5XU8nK2a5CilPV0wzj0oDXeW9skcv/7HhlduNADJYoGQTWz71jrfWj+NCAGNF2I2sCEoOoEfni2YO1I39wZChaGRRBWXRsZADwvnikA9IoU5BoLTG1Ng+SA4Z7rnbLdhDMJ5RvKEeB2GkJ57QmUsJM120v8WPkC5HSIeco77V/GxA2sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 16:27:52 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Mon, 17 Aug 2026
 16:27:51 +0000
Message-ID: <d2b8767d-068d-476d-ab8c-3a8290ab35c0@pa.msu.edu>
Date: Mon, 17 Aug 2026 12:27:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
To: Conor.Dooley@microchip.com, tim609@andestech.com
Cc: u-boot@lists.u-boot-project.org, Jamie.Gibbons@microchip.com
References: <20260724173547.77823-1-nwhitehorn@pa.msu.edu>
 <2ityfs2bulvplo6klwvv3jqb7iybjt7225xj7nmmbp7tofsv3m@jsbyw2shn2ss>
 <1f83d1e5-bced-4fe2-8afd-1ad5e215ad1b@pa.msu.edu>
 <a332c1d0-5228-41c1-9228-5e22338f0109@microchip.com>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Autocrypt: addr=nwhitehorn@pa.msu.edu; keydata=
 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
In-Reply-To: <a332c1d0-5228-41c1-9228-5e22338f0109@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:610:59::37) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d92c86-2b37-4928-5e57-08defc7c7b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|23010399003|376014|1800799024|366016|10070799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /X/r+jmdOAz/fQO8Vm0vBmVcCSm0uU9H04OaGn1O4DatfYAkdsJzqWsJBMCb1EG6GsvsTFfvZRule3qshkK+ACi6bIJOgb//ERxVVo+mIZ3/QTns6m+1SdSNiI06Fg1lt8CFjytWcga0V1jOxmm7EhxBN+6q6OyCMR+EtspYiaQg8Bg68apVjwHSkov641LL7XIfSxdSlFwZV9PsN/QlJyd2gqEclcn0881CYHp6He2VIpmMeeIAj06h93Q6QQikCaQHn9yGJmTbH8KkdZX147oJ7n7FCkiMTp5Mo82/BYs/WGIc5zb5DkmGBOyr/Fu7E/4rI3JRzja1kOAcIrO0KlKhzM+WKVeO2haZWGBZp6NotQJKPQDqWS4AIVsWKa4oUFsZuP5xu0+6fRYFacyXDCEejVACnMlqCC9LzCuFPdS7ssPMJ4mdXfKmNEy7/QIKJd+CXpqzKBs7T639jSU3czFmqkBh501fzvhvtS6fi7nm345Y4fLoSgU3yQZCt0gRF/KZvortbh42BJIpywSUUJJfJAOA3qD98OlB2RSgasnmENZFRQ0KZo+HNX5sZTDSa3hpzRwuXSRohRXJlUomg+vjmcO1YwiGgvGKboOaHgzSXYcsa0WRcKzCp4/1ugQE62h2J05Hc9dTDEPg/fKd2z8EULO96QOpIwAUpImSxB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(23010399003)(376014)(1800799024)(366016)(10070799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNCQ09Fc2t0dmY4VjZXU3hHUDNkZGNEYnAzOHBKSndscUhmM3JJeXRSSE85?=
 =?utf-8?B?YXhRcGhheHF5OTRHclQ4dnRVSndMa2xFVDVqVmNrdTZUbVpDdW82MmtyWmd6?=
 =?utf-8?B?MnpNczhnK0RtTEJVQzFUbG5OSzhZM2NxcllGcHNOOHdQcjFKWWhibmh6Wnlh?=
 =?utf-8?B?Ty8rSmZsRTJILzRVaHNUS0VwRWtjSGQ1cjBQUG9oSEZTWHphOG40VldUUTBM?=
 =?utf-8?B?UStWa0dyUTlBRk1RTDdPUnB3bm1yTHdORHJnLzhnUjNWVXh6a2xiMnM1OWRH?=
 =?utf-8?B?UEZvclZlc21KV3h4OGxGaTVsb0ZDUWcxazBIOFZzYmd5OTVaL1drdzljRUZE?=
 =?utf-8?B?YTYrSGp0aDdoT1pDalhRNTJwU2RIVTE1cmJvb2NrdGlkYVhmTTR3YkVoNDRh?=
 =?utf-8?B?b2wvNnJiWER3R2pDRHIwK1JFRE9iclU0cXU4VkJxVEZvMzVTMngxSktEWUlR?=
 =?utf-8?B?RHJPM2VucmZDM1A4dkxXSXh2U05Zcitra011M1JNS25CcVdSVWNGeGQ1OGlY?=
 =?utf-8?B?V0hFS0hWWXp2eGU5dlcwYzNITzB1RE1sZEEySU9Dcm1UUzZXMWFwWVhHa0U1?=
 =?utf-8?B?MjZqQ2RHK1JweVNtV0c0L3Rab21qaDRlZUl4NTdGcHJVM1o2MnhDTDdkTnhU?=
 =?utf-8?B?cE56UmNNTm84SWxMMkw4VXV3dHNxZFRCOFBMUnE2QnBXdDdPTEhtSlcxUGQz?=
 =?utf-8?B?MHY2d0pHN3ZKVXJDN1BpVURLRjBRMjdCMFI2eXdQZVg3YjN6Y1N2QVl4RW9I?=
 =?utf-8?B?c092Yk40dm54bnJIRE5RSGk4TUpDcW0rM3JFVExqSHJPQmtSSEVuQlJycFVt?=
 =?utf-8?B?djR2TC9La0hsbUNENkg2UVM5RzdrOW9TZExmYzFUVFY2ZVhOdU9MTWs0VWFp?=
 =?utf-8?B?U1lLTXg1TGE1RklxMTEyU1J4ZnA3YldHUk5NRFhGYUdOKzN5UWRNRWtTS3BT?=
 =?utf-8?B?WmJVcS9qUVRrTlEzcFVXMldINzZ3VUdhTXh6RGdmbS9RMXJRQ3Jma1JyQ3pM?=
 =?utf-8?B?ZHJCUkVFdE83OUkwZEFITncxZG9YQm43NEYzdkxjMGxJY2J5U3BPZXhvWHAw?=
 =?utf-8?B?NTZwSWJwWGV4dGJWbkswRGwyWXlXS3JWaGF5TUNXY3NmV1ZaZlRKMGJxeGNN?=
 =?utf-8?B?QWMvY0I2bUhnMGFFSG9KOWNRZWt5R0ZFZUpRYzd6bDdtVmUvN1ovMC9XSUZs?=
 =?utf-8?B?SE9pQmtHYXlpVEVQZGxsS25ZVDloQUJDUFRPemxvRllZRW9xS1NILzAvZHVS?=
 =?utf-8?B?MnBJL3NyWDdjN0VMNTEwN2NiYXM1bWJCSUNmWGlrMEdua0N5WitUTUVhWFVl?=
 =?utf-8?B?TWhydW0rLzdia256dWtDTnFYQ2xTa0RFNWlhaE9OS1RsbnVyanJXdkZ0ZlAy?=
 =?utf-8?B?b1pYZUVGOFcrOXNJbVVZSkh3REs5Q28yS0E4ZWZ0UVRtbkZLeEs4N2pvSTRQ?=
 =?utf-8?B?RUxwQy9SQTJCMzZocmd1ZEZOZEdqbGN2VEdlTHhyRHB2N0IzMnRLV2dsYk1I?=
 =?utf-8?B?M2tEOHg5d3RWbURpbEVSNUMwOER4SUZ2MnkxOVpGakZ0RDR6Z3didnZzUzMy?=
 =?utf-8?B?VVVHM1JVWjc4SmI4aGpSaGphelJDaTdRa3owS0NMSDVWc0tydWwwL3poQnVq?=
 =?utf-8?B?Sk1JVFNCMXFEODBGeXQzWldwMUxGN1E3YW13Vk5kN2ZwTkJPM3Z3RnM1RVNT?=
 =?utf-8?B?UUs3aUpENlgrY1RVRmgrdVRmRWwxZTFla29VeXFhQVBYenhXY3grOE9WcU4r?=
 =?utf-8?B?dkN4cXBnb2ZRUnhvOW9WNGYxSTlvc2ZjQXNnc09qc3J4VEpWem1STzJDWStn?=
 =?utf-8?B?L3VmQ0ZSZlRXU0xWaXZ5RVh3VDArdWVnV3JwRHdhNHlWQ3p3STBxb2VVeFFT?=
 =?utf-8?B?THR1Wkd3dmhwOTVsWm1FZDlyMmdXeFdRM2IwT3VWWEZsWldNZEU2MUY0TTJa?=
 =?utf-8?B?T1FTeCt6UHFmbGQ0MHVCRkgxWFRFY3E5a0Q0S2NjVXJQSVpTZDJ5bzlZM2JR?=
 =?utf-8?B?Mm9NM0VnSW9SWlNMWWxhdU51ams5WGdIMVI3WG9PWHp2Y3pRVDg1dEdIdTNr?=
 =?utf-8?B?RkhCdk4yeWg5bnFDSzlrSExtMDF1d1VyUk5DZm8xdmR3c3F1aS80S0RSTkdH?=
 =?utf-8?B?YUZLcG5EYTVISnNhNldSc2daa0xxV0prZ0hjTEZVTkZuZnBBcXR6ZVpGaERB?=
 =?utf-8?B?bWV6c2VzbCtHVG85aFk5RGZ2MDdWZ09TK0dYdXpScDhjT0NwSFh3ZXA4TkNC?=
 =?utf-8?B?TXNSdEVvMHJRTkV3SFZLVzYvUGVsQURiRDVySEZvc28vSzREMHFsWXlkUElJ?=
 =?utf-8?B?bExzdkdiYWo2MGpvWkplT0JUc1lGV2pld3N6dTFVL3BqVEo1T1JnUGFrMlhy?=
 =?utf-8?Q?xljvRP3XYhZ4276fMnyD6BbmaE5LWNUEHRFzA?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d92c86-2b37-4928-5e57-08defc7c7b85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:27:51.2620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSOsOTF4siEPrNulFHqz7AKOIb19PUVdlan2mCTutZGbZ8JsDZxSeo++4DUazU3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/17/26 12:22, Conor.Dooley@microchip.com wrote:
> On 17/08/2026 15:32, Nathan Whitehorn wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 8/16/26 06:25, Tim Ouyang wrote:
>>> On Fri, Jul 24, 2026 at 01:33:50PM -0400, Nathan Whitehorn wrote:
>>>> +    designid[32] = 0;
>>>> +    for (idx = 0; idx < 16; idx++)
>>>> +            sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
>>> The variable serialstring may not be properly null‑terminated.
>>>
>>>> +            if (env_get("pf_design_ver") != NULL)
>>>> +                    fdt_setprop(blob, node, "fpga-design-version", env_get("pf_design_ver"), strlen(env_get("pf_design_id")) + 1);
>>> I think it should be strlen(env_get("pf_design_ver")) here.
>>> Please ensure any long lines are wrapped properly also.
>> Thank you for the review and for spotting those frankly embarassing
>> bugs. I will send a v2 shortly, including the style changes.
>>
>> One question I wanted to ask before sending v2: I somewhat arbitrarily
>> named the created environment variables "pf_*" for "Polarfire_". Would
>> you prefer they be "mpfs_*" instead?
> Please.
>
> FWIW, I missed this series originally and will hopefully get a chance
> to take a look at it tomorrow.

Thanks! The patches need to be rebased anyway, so I'll wait until your 
comments before sending a v2. Should I also rename the device-tree 
properties (currently fpga-*) to mpfs-* as well as renaming the U-Boot 
environment variables?
-Nathan

>
> Cheers,
> Conor.
>
>

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


