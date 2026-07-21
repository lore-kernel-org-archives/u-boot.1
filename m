Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4D2C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D4D9407E3;
	Tue, 21 Jul 2026 06:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWaT9fiW88FQ; Tue, 21 Jul 2026 06:59:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC838407E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784617182;
	bh=XiBYiJbdinLvohhnONEQQhBVNtQPkaXSYKd4qr7cqK4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M5Oi6Kttwe41NoLeg+FFeIclFLeIveM3L3adgiNP4qpBotvV19Aht8/AmZn4ldMFb
	 mKytzIJCwZPGgDLs216/bCKiVsY92BkbCEbUVDe6YyCLvLPv/rvlluiZ1W5R7oidby
	 TA7DqIYYkJWpCpRid6/3ZDZG0k1aU5dw0/1grdLKhs9fOz6lC8tl/cQVrDXmctU7fe
	 5laas6vQnUYYWudL9dJn1JsLZioT13FEkRNeVERtJoj56ce7TTQKGg9J+fPqtmW34A
	 XYoYz28tMTWO3TxXEhwXUtgYyKsUl3Lt9MqxZZ9v/qMx/sRBes4NmvBXVsOiS8U3hV
	 6ye6DqDMbJqpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC838407E4;
	Tue, 21 Jul 2026 06:59:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF8491093
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A95B880B33
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygZRfiIkCsY0 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:59:41 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C499880A5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C499880A5C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C499880A5C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:59:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B986846A4; Tue, 21 Jul 2026 08:59:38 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27C63803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:59:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTCUkhVKXJ87/HuBs7+NIKKFpmcSQSNoXVlzIcbhpeCXwhEHPsr+s2TOKZOeop6JWq9sx+NYPUS5vmDhgUKMKDeFWJthJONKfdcPmCvdUzkVZ66pZYydr2H9O8M4Q3+H5BrglhM1lXHmJzB3B6t4sShykwBbrR96lQRpcdCFZTwNJeNskjJgjKjuSMegdA0jM0UkqO20KLaM3482ESqPD9XmZGhpgvQ3oYDX08h65ngkkvzcs/I86f2ilrid7GxxEoQfmN/Fes+E9uaYSRDVcDgFHOWfipJVgXiT1pLzxGn2JzMsCUMQQCkFqDo3ysQ3LPs7Gd6SLmIsOTfFp6DBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiBYiJbdinLvohhnONEQQhBVNtQPkaXSYKd4qr7cqK4=;
 b=K3cb9ZQL3XJ7TVtZwRZA3srh7sa20dHkPdQuEGylwv4jLY+JyEZLzf0jQUzPZq9W5elkZwYrHsiRYYaEiuOFcLGcfZbpV+fKRsFEU1BcWi0CKG9TKBiB58s5IJHlJrDDNwVwmoDa/l1WDIzWh+AMf8BP/gow02B9woVsSzvX8dUwy+MEXWSSkctMksiY3AyGu3ImCRGKXiKvqLQAmZbgRV0WOxYwdSjblggXwQErdgCCRuY5abpskDfEZAqlVAqFLJY9QI0gSAgU30biF7Zd0o6XCalcDc5NFVtfgNQgSo/NGmBIZ3ibYWhTPBwfxpqvP2uEtuMrvbZCU3PAKU6xZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV3PR03MB7336.namprd03.prod.outlook.com (2603:10b6:408:19e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 06:59:31 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:59:31 +0000
Message-ID: <811e93fb-9e4d-4fd5-bc16-831a4c748cb7@altera.com>
Date: Tue, 21 Jul 2026 14:59:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Enable MMC secure transaction in SPL.
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Ye Li <ye.li@nxp.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260311050003.20955-1-dinesh.maniyam@altera.com>
 <19dc7d12-f4d7-441b-b00f-0f2ec41945d6@altera.com>
Content-Language: en-US
In-Reply-To: <19dc7d12-f4d7-441b-b00f-0f2ec41945d6@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::15) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV3PR03MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4094a364-5bfa-423e-2e48-08dee6f59d5e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|55112099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: QdndGPLVZEbXTwMMGA7u9yRAn8EkypQn6S9Wxh4FLYeCYie2apNtue7DbXv408/p33PyCYDsnSlNfF+t2lkWjN6NXQN2HH57Ef2OkzhZzDxJbQ2ljGuXjBwXgIR2z69MjSk3SZYjdCyRBL5NWMgNozScDr8L8BKLjUu9CjoTyjgTVpNWBt6PrUsZiDqCXdvnuFhtm8lkmFV413/JdoogM90BHHekiWrVEqUNdYcASsg1hT1I+7tlnEx0IiT0wJ+MXUfDiMUw/LGfyw/pSu9vyNEZtLFhptUOyV4Toud2OMAj5KijUZ/52rMgQTwLbY3URC4K4T+yD9Wky8KHh+35ocQgP3lEqq/BOSUPC/ORWERSzUnxONb221TtLkkcS3PEZZ4g4H51LZ2vDpoDWDkcyOymIqE1ZlT7KjmUmchwhehPzmob8bYiYUskRj/CxNPTVuiikQvq7A0L3BpTOfl0Hr0j9XzoPZYcJOTNiomVXsyIgCwfA5z6Y/ZyztQZPl//1eVa3Ny/NxKPUmx3YD7b86VdTRck8kp3vzaHvGkJuRkuWED6iWefljrlNGcCXnhC5FjouH4LE5BPD3AVc3M8pYM4a3S4NIPi6KbRneFlAKCpYzTi0Ix1nDirQKnaL+cVwTHxvtwulgD/DXiLKj0a97mVIorJnZwKCk4see6iwmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(55112099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2F1elA3eWpBNDVGZ1REMjhUZGRYaGgwZzQ1R1A2NU9KSG4zMHBHcEhzWldQ?=
 =?utf-8?B?SzJ3bXFEMG13T2lURDhuNnZhS2dNcDB4UHhkOUdrUG44V0pPVVgvYldNcGl6?=
 =?utf-8?B?cU1ObFJVd3hRQ2VCWkIvWnl4V3BLRFdxbEgrM0xzYUhIWXhOdGZZaTRqNTV2?=
 =?utf-8?B?QmtJdlpxNDBpNWh4TkFGN3MrYVpFcVdPNytHczlBL3pxUG90N05wQ2ZmT2tZ?=
 =?utf-8?B?ZC9HWW9MVjY4ZkF5RFg0T2VrY21YL3pyeGZRSCtzajg1dityL0FOYUpnL2Nh?=
 =?utf-8?B?T05QQWtVZUlpL3duWEN0VnUzL1YreDBzN1Z2eE5wZnp4Tk8vcEttZjVmeDZw?=
 =?utf-8?B?a0ZlMzgvN2IyOElQU2gxWS9CYVJ2MVJ3a3UwWUp0VmpqTStpNEZJSzFRVCtB?=
 =?utf-8?B?U0FhVXFCd1NNNjEyTDFsNXA2YmpKL0E1WTdsVm5lWncySjVlSERBOGg0UGpX?=
 =?utf-8?B?TVBDZVRSNzZxRHZpcE5uS2o1dkdOSjNQdWFKRFJUdGo4dmdoT3BoNlZqMTFR?=
 =?utf-8?B?U0FWOTZVU1p3L2NCcFVKUzVXOEFHMWsvRzNWUlVlMDNLVCt3WERmTU1kRml3?=
 =?utf-8?B?WUVGeWlZNEwyT1h2VzJlM2JVR3dWTEcySXdwT0FNN1VRaUwvSU1PcTh3amRi?=
 =?utf-8?B?UW43KzdpQUEzMG5kL0VzeVFXOU92NHFSYzNFSUQrZUVuTW9velBMY2lzb21N?=
 =?utf-8?B?aTFUd1U2bmV0Q0c5dVhTUUlqcHRqSkF5eW1pcVV2STVYcnVxK3VXdDFPRjRy?=
 =?utf-8?B?VUtWdTB1c1E1emJRMVpjYzdnQXpEalNqaWpZTjhxMkNEWlNDN3RTWTlwcFVO?=
 =?utf-8?B?aWtBRk9qZjJRNHdlMHJYN2ZLUFRUOENOZjNEMUdEUlRCTHRTUG1jV2x1VVAr?=
 =?utf-8?B?NUhwQ21TOFRSczYyWG9zbXNaWDQ5QTQ0SWd6K092ME5Cam5tdysyQkMwb3JK?=
 =?utf-8?B?dDQ1MlR4MUFDZkdpUS9NMENrSnpydG5rbFFNemhSaTJPOEljUk5HV2FIRm10?=
 =?utf-8?B?YmwyV1RKTTg2THFjdDJsYmFIODU2M2RsUnJNcnhrVktjT2VpMWtjeFNCMVdm?=
 =?utf-8?B?MG82dWRDWFNIUm1OQ0RQWUl3VWs3OG1LblBJa2JJVGk0bFlGblJsdlpKK2Ez?=
 =?utf-8?B?clRkRm9heEJUbi94bzdlbEZOVEdPVUV6ZXBGdGtCd1BNd1ZwLytObTFjMzFo?=
 =?utf-8?B?UG15SHhneGlTMkd6UUlwZktWSGVVcERvTjBvdmFQQTlROU9ReEY0NEV5RXQz?=
 =?utf-8?B?ZEhaaWRhVUc0clU0VE1VZzZqTEdtRVZMNGtuclM4U09tNXoySFJuRjh3cVp3?=
 =?utf-8?B?MXU5UXFTOW5LYWl4V3FEWVltY0xFNUloKytXT2pKZCtVQmlVQXdQLzJ1cUxx?=
 =?utf-8?B?NjJmMFNiSEtlWlZjUkxuQ1RGbkxMN3lydzBoZ3I5Ny9oNVV3U0tvNnMrVTdY?=
 =?utf-8?B?ZlhoMno2c1JGSVpYZHdST1FjVWthNjg1KzU3Wmp3U1pQV3NmSmVjY2NVTEt5?=
 =?utf-8?B?Sk5vcGgxdkJPNCtPbTdOb0NTZGtTVzNPTklhakRzcFJEOWJxZ3JJWWc3NWw2?=
 =?utf-8?B?TCtvZzNBY3QxNjBOQ3JoRzdWTUFTRDltTWpScGgzMWhGWmRLNFVobEJwZi92?=
 =?utf-8?B?dVcwV2lyT0wya3pPSWtaeDlsZXROb21Rem5EcXMrMmM4K1htN0tXVnA0TStu?=
 =?utf-8?B?V09jeHlWWjFadTZINGVJWTFZSjVZSStCOHZXYU04THpkWmoyalVpYjZ0NGtN?=
 =?utf-8?B?VGdtVlBRWDdITG5LVjZpYi9hYTlxRWVISVlpOEx1MjdWR1Eyc3IzRzJQcmFJ?=
 =?utf-8?B?Skg4R1pZRThnVklkVVU0ZGJBZHd6clBHYjZJQWphZEd3V2dtZUpocnk3OWdM?=
 =?utf-8?B?UXZ3VDBGeXJMQUpFVENBMkw4K3IweGlsRVZxSUxFZEZhZVAzZy8yb1dndUEy?=
 =?utf-8?B?bjdSNVdmUjJnQlRoSFVZQ05RQlpNU3BWbEU3QjdtS2ZWK25WdStJN3daQ09F?=
 =?utf-8?B?a2VzTit6YzNCbTNjdU83SUJZVnM4bVY4dU9QTjh0cUNhODhQVmdpMlJGUmJl?=
 =?utf-8?B?QzN2MEtkZ2FoVGlBTUJSM3RuMmsrMnpzbHc2bllpY1dKTnJVcDc1cU9tN2p3?=
 =?utf-8?B?akJ2MzFVR1dxeWowV0F0aXpZSElJZG1MSEhIY25Hb2hvMWx0N0pBSHVzZUNa?=
 =?utf-8?B?Nm54bmZuMGZzRGF5cFhWY3pwMXBFMGlrTVgxd0ZuVHkrZEZOWCtaNThWYkx5?=
 =?utf-8?B?RHk5NGVudGdUSHdPYzRydm40TEkzb3hDSnJhNSt5RWFpMXN3dVBJclJIS1gw?=
 =?utf-8?B?Z2I4WjJzdG1BbUYwMHpPSVhZZTVBdEIrK0p0Z0M0aUs3VFFLdGoyTS9TL09C?=
 =?utf-8?Q?5LasvXNvu8uxBe4o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4094a364-5bfa-423e-2e48-08dee6f59d5e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:59:31.6275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjtYrWfH12NMNaAH5dQ4zbhTQ9fiSk4cfxkHtvtOMoGtV8S4PaIx7U6YHY2DUGx0B7Eq6V1gZQv4pN+iVr5rw9dtyU0PWl3T+CS+OJ47yrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7336
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiBYiJbdinLvohhnONEQQhBVNtQPkaXSYKd4qr7cqK4=;
 b=khYdLjyfhzv5AN5YmZzo3Ld3qY/DH/KZq+Akc2DGZAuWnFUspA0aghurBzLuN2Z9cFSao1IpKY6CwAe6zDqFHEpH23aH37EqfjKdYxMg6OonY8lOX9SdQNMWXYEBUxHFt8MH7whhpOlCvMJyjpWzNk6QBoNaAsTJYnbcULNgUM+Xlwbv6icUWgpI9yNebg7Si6dDzCFuMdbDBaFKYC+AVZ2cobhCjjCDT9CAdmqppKXl2c3jyDdc/vVKpAjBQaDl/wjxbaAZvPfcaxGFRS2W6RL7+3eOO5yOwiyRpkCBcFB5enb7B0q+sA7DDr1vGVAwOi55DnFXUoHt1JfIV3CjpQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=khYdLjyf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="khYdLjyf"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tien Fong,

On 16/4/2026 11:30 am, Chee, Tien Fong wrote:
> Hi Dinesh,
> 
> 
> On 11/3/2026 1:00 pm, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> 
> The subject could say Agilex 5 explicitly (spl_agilex5) so it is obvious 
> it is not all SoCFPGA.
> 
> 
>>
>> Program SECURE_TRANS_REG when CONFIG_SPL_MMC is enabled
>> to allow ATF loaded from MMC to access the secure DDR region.
>>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   arch/arm/mach-socfpga/spl_agilex5.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
>> index 1be347360f5..d0c2af795de 100644
>> --- a/arch/arm/mach-socfpga/spl_agilex5.c
>> +++ b/arch/arm/mach-socfpga/spl_agilex5.c
>> @@ -110,6 +110,14 @@ void board_init_f(ulong dummy)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Set secure transaction for mmc, so ATF image from mmc can be loaded
> 
> 
>   capitalize MMC, minor grammar (“so an ATF image loaded from MMC can …”).
> 
> 
>> +	 * to secure region reserved for ATF in DDR.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_SPL_MMC))
>> +		writel(SECURE_TRANS_SET, SECURE_TRANS_REG);
>> +	}
> 
> 
> That extra } would be a syntax error
> 
> 
> Best regards,
> 
> Tien Fong
> 

Thanks for the review.

I'll update the subject to arm: socfpga: spl_agilex5: ..., fix the
comment wording (MMC / grammar), and remove the extra '}' that would
cause a syntax error.

Will send v2.

Best regards,
Dinesh

