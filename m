Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547EACA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 06:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CCA81E13;
	Thu, 21 Aug 2025 08:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RUA+BB6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2093381FEE; Thu, 21 Aug 2025 08:47:20 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3497E80422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPAVub63RZrtQmYEWDzSTkzkB/lIWuDeB6NatJBBVwf5jS3tQyA/Kot1O1pyjyKjL/3oUkqiSybmtA55dNzaavetKsa70tCeYKR/Dtse2JqeQY//LE7CgH1Euzhbv6ECPDHkpjQYxbfT2yhaRj+bY+i9p0VX4WP2SZpph7yYkPfh5MrJXajtM1IvPKW4SU1va60zCCptMeVaVQL8ytseEUgz3+xRIZKBQqwgQqWUMMHwszmVjnPHf0ze1/J1dpO5owfTYHIS0Jx7N3eWCvJOqwVlmGxyrEeswBOJwch6v04xlJA9nM71tN84dWr5EPbVV0HUtUMiZPZTOUoHiB8NMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fpNavK4WEXj/IAgx8oVMFFcfMBSOXyoRqNNwHfraLk=;
 b=ngFA74Ua6xjYuNpYvDynIoG8i34piFn1KrSE1cRcR243WL0tSaYB+sMfL3Mxr3JuTwcUsidHlBaJVJm0DcvnYpAyqAS/4YZ7PaoYKBg1e9yO9IjFJi68moJ0FYc74ut3f9WnCsLL7GUNeoPGJIUmCuirC052uwButsa52cE+KYUDiXUU7j8t0t8JZQINJRuYRAgkjJ+uUldEBm+AKbwgtmTGYloYQa/hiTD/hC8a+7/jOnXLePc4edyeSomBgZ25jOs8GPX/give/2Z9lMhRE1dhd65MRuZHcr6MCGkKuFw8WZnO5tfNa3PyG6yWFnR4xKqe0dY8FB3gDgBYTm3dvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fpNavK4WEXj/IAgx8oVMFFcfMBSOXyoRqNNwHfraLk=;
 b=RUA+BB6/Ov48e0cKYcym79aF5D//YkTuIXs9roOpV/Z0yTdcSiYW4ReKGuGbXwVUjv6V0kzaID+oCSoJlPIdjA8p+cI+BhAndMGWcvxf2PRpAoCy8T08P7b42sTxFJluBfiPH4olK5g4w07/5fF22NiREs0kbLt33qZZ5V9dFTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 06:47:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 06:47:12 +0000
Message-ID: <a117a5d8-c759-4fe4-bfbc-110e55a99945@amd.com>
Date: Thu, 21 Aug 2025 08:47:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: spi: Fix gd->env_valid for the first write
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 git@xilinx.com, Love Kumar <love.kumar@amd.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com>
 <5046fa19-eab6-47fc-a740-d8f3268070f2@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <5046fa19-eab6-47fc-a740-d8f3268070f2@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:510:324::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 023a1922-183d-4a31-a7c5-08dde07e8f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Si9FUVBBS3EwSzFjWmt3akNlc1BkRXlhcCtZamlHZjVzYUxDNGtJaENRTVFL?=
 =?utf-8?B?OVhRenpod2dhRncrc1dXL0JUMzhzOENWdXdSczRKcVNWUWg2MkRaNlY2aVll?=
 =?utf-8?B?U1FyV0h0V0NLR1pQTUxPa0xid2I0a2lGZU44STN6dmJPRU5mWDN5di9jOHZ1?=
 =?utf-8?B?WmxqbklIK1FuVmFRZjZtSzJvUWFkdzlvMC8xeVM4TG9FZ2hCMHN6ckpvQWRS?=
 =?utf-8?B?aEEyQzZCblphTW54Z1RuUUY2aytFdlNKNWJkQk1QVS9CYndLNzEzTTFUZHVT?=
 =?utf-8?B?aXNsUS9wampxYm42TDlXMDNUNjVQOWMyd1hBRSt3NllJcTVUS3NEUG9meFp1?=
 =?utf-8?B?U1pIT1ZRRVBsWGxUOWt0VTdZZFg4Mk1tRWtWaVdUN0ZPdWtnRFNaREpNL0xs?=
 =?utf-8?B?TkJrajZrM25ub21EMm5ZcjIzU3BhTEp4NXo2eUlNSHJHbHNNa3Y5bStkUlpJ?=
 =?utf-8?B?bngvSE1MZ0JhMEpIei9pb0RMSUVxZWhGVDM1NHMxalZCVVMybnU0bXpRQ1FU?=
 =?utf-8?B?R2VSSVVhZ1UvbjQ0SWQ3aGFVS0s1YlllTFoyQ0Y5WnhEZit0aXdaZGxLRy9W?=
 =?utf-8?B?OU5KMHd4dW1YQlhLTmwwV3VJR1dnUmJhUkhZVGdzaENqS2JNVnlGTDg1Qytv?=
 =?utf-8?B?N1NQSzQ4bVhIQWNFbGlsa2NEaWFBM1gwZ090Y2Z6Tko4OHVsdHN0OERNbUIv?=
 =?utf-8?B?bmlaOEsvNlVsUXNOWmFreEdQRzhzL0ZrcVBoL1dOQ09SL2U0dmhRNC9KYnR3?=
 =?utf-8?B?NnZYZS82UnpranhIcGNHZ3JubUNoK2l5SFRFSFB4VEQ0MzlLUUpDd25TRHMz?=
 =?utf-8?B?Z1NCeUE2Wm5lRkJlUUl3Q1JjOERad0gvOWZTRkRGQk5la3RPT0t2ekhtREF2?=
 =?utf-8?B?cUtxZW52RnYyQkR0czc0UjNSc2dQRzBFbFRPRVJhWlA3eW1IUW9SeWVQQlUx?=
 =?utf-8?B?RklzUFhkbWI1eE1mMUdwU3RuNUNsWUFxZW1tS29Xdkx1Mk9tZGEwZHlMOEN4?=
 =?utf-8?B?QXhnK2gzS2VuSDAzNStGTnBrVkt6ZXU3eXlRRHd3dy93dUNYVklGRm1xY2NR?=
 =?utf-8?B?RlVkcnhJVXdvc1lqNnZzMiswNUI3TFJMZVFwdVlML3dlYmZxbjFwNHdEWmYx?=
 =?utf-8?B?MEk4Ym4vNktqVzZuRmVqTFowTGpVUGxTRHpCN2p1aUhKTFRYK2UrU3pybE9B?=
 =?utf-8?B?RDY3QVBuOElhekN5OSs3STZYZ1ljRWcrOWxWdno3NVhuVFdUUGt6Ym95WlNG?=
 =?utf-8?B?Vzk1MjB2Q0p6OGxBUThLcExBbUQzeXJPRU1XNng0NUpLdFVlTHZ6eVFRNjFC?=
 =?utf-8?B?Qi9ENktPSnRzZWdLemZSZjVwQmlnRnlBd29uMHE0SXdYdS91SWlDdXQ0RU90?=
 =?utf-8?B?ZDBPcUVZRE0yN2MzQnZxWXZ2ZExaTkI4WWZZZkRoNG4vTHdsWGZZK3hKZlZm?=
 =?utf-8?B?TlA0UEJyeWNJRUYzK2toejRFd01XaEg2TlJrck41c25nM09ad3NiVXlkazg5?=
 =?utf-8?B?SE1mTU0yWHVGUDdDVkxWeFlTampSamZVdHdveTlJZFNiZ2oyN3B0QUxDRXdi?=
 =?utf-8?B?cm0ySFg0VWs3bXlNTFR5VVJySy8ySmxMd0FqWE9Ia0pOc3VVWkhlWlc4UTln?=
 =?utf-8?B?QWkwV0VkQUd0d2VYZ1JsbzJnc2hyTEZWWlV0UERUZURYVlpUVFdEbnF3Qloz?=
 =?utf-8?B?M3dpNVJPUURuTmZ0MUozUEdlaUx1bUZrNWZ5K0psSkZCaWJpN0hLQ0x5WXJo?=
 =?utf-8?B?dGxxSFY1azBHWW53NUZ1bFJhS1kwblpMNTErZlozbUx0RW93YjVUZzFDK25S?=
 =?utf-8?B?Vk5adTV5aDh5QnlDUHNoYXRxeXlKeFdyNTU5dmVzNXQvWkxqVVZUVUVqSDUy?=
 =?utf-8?B?Z3c3YU1adk1qemE4R0dXTU9SSFZzNU9qZXF6T1RMK3ZreUw2L3A0MWlCYitz?=
 =?utf-8?Q?IkQjh2gtRQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRtNXQybEdxZ0pjZ0VlL1pLalg1dzBTYVRmVk02STV3V3NIdTd1V09DaFda?=
 =?utf-8?B?L1dDNkc4TThFL0ZzbW9SY2czSlRFenl0bVBaYS9yUmxwaTJrZFhtd3VzM2l6?=
 =?utf-8?B?RlI2cHExMExhWlFURGpPZmtpclA0ektPRE1zRlZjYVZHNjdtanBVQjA4V3FR?=
 =?utf-8?B?YnFoV0VXZnVhSTh3SW9tY3hoczlsSHpLVDBuZ3BMY3VJTDYxOVlDNUxRTkxB?=
 =?utf-8?B?T3ZEMGlMUW1UQnFOTFJQRk9zM1VGVUNqWkh3N1hpejR1RUhLYUxaS1YxczRH?=
 =?utf-8?B?WE5TRlhmOGVYRDRrMnR0cWlzZTMxZ1VNWEVHTXpUMFdCUlQ3Rkxnc0l3bXdq?=
 =?utf-8?B?bEQ4R2hvcTE0SzNUQVFNV09yaW11bXpKaVZxNDJ4Rk5yMWNabzFZRk5sTEZO?=
 =?utf-8?B?K1RYNjhKWXRVN1pOTUNaNWduZjJJdDdhMXdsRzEwMVcxM09scXVLZE9rYUJW?=
 =?utf-8?B?bUd1c3lKdGZxbEJEUDBoR3ZZOCtHcTh1NFJFbTVFV1grMG0xZGoyNGozc3J6?=
 =?utf-8?B?SCtvNDhyQmplNVUvbEFyWUZWNEtMVDdxSkIrM1drbFgraXFJS3NGdjdsRVI5?=
 =?utf-8?B?NXo0SCt3MGpLc09tSm8xbzcvMkNUUG4vRmJ5N0o4MnRRSEs3dUJzQUp0ajht?=
 =?utf-8?B?d2UvbkJNUzZVbmtETElpNE9LcnBUWVRTbWlVdS9FbXlTaVd2MHNkMnppN3RK?=
 =?utf-8?B?a2x1cGxzN05YQmVhMURiN3JlRUlzSkRmcTRxUHgvUlpMUzZxdDZrWnk0cDBX?=
 =?utf-8?B?bHM5Z0ZaT0FZUUpNK1F3MDFnMkcvdGN5aXB3RVJtdzhBblJkQkl3VlNvRjBJ?=
 =?utf-8?B?b0dINEIxdURrZVJ6cEt3UjhUYlRxZ3U0U2NYN2lpUG9MYjd3QjhMWGJGMVBK?=
 =?utf-8?B?VlZpSVBzRG0vVEJpSWhENWNoSGRvLzBFeWRMbVNHZlpBVjVySGNWL2VGbGxl?=
 =?utf-8?B?ZlJld2RBSTc4Z2hKTk5vK1huOXRycEtoSjN3T2pnN0g1WmxQVE9aOTNsVW9z?=
 =?utf-8?B?RXZQaTFFdjBPYmFkQXlpcGMwbkZaQytPbzFlNVlFYXBlTlU0MERkaVVFMFlv?=
 =?utf-8?B?TnA3M3pkYjV4VkN1MFZ0THptczJKNEJPWWM3R1I1bkFOS0lJbnB4b3dmRVVK?=
 =?utf-8?B?eFFRVi9ZcjBmcm50MEZicWRBbDdkYjJJQTJVQ0FRaXVvTGIvSEpuQ25zSmp3?=
 =?utf-8?B?cXlzNUtZaW1VajZFR2xnVGxJSlB0OHVJYnI5T0hIam5ySGtyamJucWhDeGd6?=
 =?utf-8?B?WkJDMElXaUtpaGd0MlFWYUdFV3VCeEc5L2l0UFowbU5OWHhoeHlGRFNnWU41?=
 =?utf-8?B?TmhPSllvQmhtL0FLVjM5dmZ0TXRleVlPM3AyQ2d1UnF3ZEFMc240R1VuSWZM?=
 =?utf-8?B?ZEVQTFIzNlNRNGx2MFFiWk1jNlJIc1VtVVdxYVNhenVtUkpJWVkvVzIwVmZK?=
 =?utf-8?B?OUNWSE1GaFc5YXl0ZllTelFUNU9jWmRLNHRuanpRcGk2ZGRvV2ZYS3NZOWJx?=
 =?utf-8?B?cWtKdW8zQUh1a0NHK1pKUTFyZ0EvZ0trVmhuSmxZaS91dWlXOHB5bkdjdmJk?=
 =?utf-8?B?MkJuU3pIUlVOeUtqclJLd1l3dlFlMVI3ZXgwK01uU2NYU1hsZlRtcktGeFl2?=
 =?utf-8?B?VUR6OFpPNWkzSTNsVWtUenk3MkdFNy90L2lyMCtZNUc2MVlxUVJhMlRka3li?=
 =?utf-8?B?bjV6V0x6OUxGTnZjaHljbUNMVkxXRWVnZEkzampsY3Z1eEUyWmJucWlwLzNW?=
 =?utf-8?B?bEsxVXFSMmMyb3JsbVl1aVZwSm9EWTV3anlhNDV3NzhvQTNReTllUkw1UEY3?=
 =?utf-8?B?dyt3MU5kZm9jTDlBcDBlZExnVzRTTnpnbW5VSHBJYkJOS0FINTlINGVXRmFh?=
 =?utf-8?B?RUdsSzhlRFIyNXo0N093NGIxZllOS2tSN1BqL0xsRVR1V25xcC8zaG1YMzNy?=
 =?utf-8?B?bVladng2MmFHQ1lQRlh3Yy9UV3ZQMEU2Z3Jrb0l0anpLK0hsMWtQSTJNQlRy?=
 =?utf-8?B?VVFFRDllNVRqZ0dzL2VGTEluYmlDTUlBeisxZFdTbUYwSVJ6Z3ZHcmEvbXJR?=
 =?utf-8?B?Rkt1anA0eTREd2M4NitZQ2R5aG1ieUNOOGZLU3ZFYlcwdll5VjhHYWRybmF5?=
 =?utf-8?Q?5aVNTeVshKtBT/369b5MsNTMi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023a1922-183d-4a31-a7c5-08dde07e8f06
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:47:12.7611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHgh57o0xdGN2LuTaLAUCOftyCqle+rZ7B0Sq9stwUeO02iwPQ44epH0wNX9Efx5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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



On 8/20/25 22:59, Marek Vasut wrote:
> On 8/19/25 4:25 PM, Michal Simek wrote:
> [...]
> 
>> ZynqMP> mtd read "U-Boot storage variables" 1000
> 
> It would be better to spray the 0x1000 area with pattern first, otherwise, if 
> the 'mtd read' fails, such failure might go undetected.

can be done.

> 
>> Reading 131072 byte(s) at offset 0x00000000
>> ZynqMP> md 1000
>> 00001000: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
> 
> [...]
> 
>> ZynqMP> savee
> 
> "env save" is the modern equivalent.
> 
>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... 
>> offset 2200000
>> done
>> Valid environment: 2
>> OK
>> ZynqMP> mtd read "U-Boot storage variables" 1000
>> Reading 131072 byte(s) at offset 0x00000000
> 
> This here looks odd:
> - Where is the "offset 2200000" print coming from ?

I had additional debugs in the code when this output was created.

diff --git a/env/sf.c b/env/sf.c
index 0b70e18b9afa..961e853eaef7 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -127,7 +127,7 @@ static int env_sf_save(void)
         if (ret)
                 goto done;

-       puts("Writing to SPI flash...");
+       printf("Writing to SPI flash... offset %x\n", env_new_offset);




> - The valid environment is indicated to be 2 , shouldn't that be 1
>    (primary copy = 1, redundant copy = 2) ?

yes it should be 1 but this is the code before this patch is applied and it is 
saying 2 but actual write is happening to 1.


> - The dump of what looks like primary copy also seems valid, so
>    shouldn't Valid environment be 1 (see previous bullet)

yes - dump is valid because the first write is happening to primary copy but 
logic itself is saying that it was saved to redundant copy. And that's exactly 
what my patch is fixing.

> 
>> ZynqMP> md 1000
>> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
>> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
>> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
>> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
>> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
>> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
>> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
>> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
>> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
>> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
>> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
>> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
>> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
>> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
>> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
>> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
>> ZynqMP> mtd read "U-Boot storage variables backup" 1000
>> Reading 131072 byte(s) at offset 0x00000000
>> ZynqMP> md 1000
>> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
>> ZynqMP> savee
>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... 
>> offset 2200000
>> done
>> Valid environment: 1
>> OK
>> ZynqMP> mtd read "U-Boot storage variables" 1000
> 
> This behavior here looks correct .

yes for primary yes but secondary should be populated already based on log above 
but it is not.
On the first save you should save variables to primary, on second save to 
secondary.

As you see from logs. On the first save - the first location is used but u-boot 
reports that it was saved to 2 redundant location. On second save it is saved to 
the first location and also said that it is the first.

But after this patch applied. On the first save - the first is used (unchanged 
behavior) and it is reported as the first (fix the report). On second saving the 
second location is used (fix) and it is reported as 2 (fix).


> 
>> Reading 131072 byte(s) at offset 0x00000000
>> ZynqMP> md 1000
>> 00001000: 5d691224 63726101 72613d68 7561006d  $.i].arch=arm.au
>> 00001010: 6f6c6f74 6e3d6461 6162006f 61726475  toload=no.baudra
>> 00001020: 313d6574 30323531 6f620030 3d647261  te=115200.board=
>> 00001030: 716e797a 6200706d 6472616f 6e616d5f  zynqmp.board_man
>> 00001040: 63616675 65727574 49583d72 584e494c  ufacturer=XILINX
>> 00001050: 616f6200 6e5f6472 3d656d61 4b2d4d53  .board_name=SM-K
>> 00001060: 582d3632 47324c43 44452d43 616f6200  26-XCL2GC-ED.boa
>> 00001070: 725f6472 423d7665 616f6200 735f6472  rd_rev=B.board_s
>> 00001080: 61697265 30353d6c 42323735 46313131  erial=50572B111F
>> 00001090: 62004832 6472616f 7465735f 723d7075  2H.board_setup=r
>> 000010a0: 64206374 30207665 797a203b 706d716e  tc dev 0; zynqmp
>> 000010b0: 696d6d20 72775f6f 20657469 46467830   mmio_write 0xFF
>> 000010c0: 30304143 30203031 66666678 203b3020  CA0010 0xfff 0;
>> 000010d0: 74206669 20747365 61637b24 5f316472  if test ${card1_
>> 000010e0: 656d616e 203d207d 2d4b4353 472d564b  name} = SCK-KV-G
>> 000010f0: 6874203b 72206e65 74206e75 6b5f6d70  ; then run tpm_k
>> ZynqMP> mtd read "U-Boot storage variables backup" 1000
>> Reading 131072 byte(s) at offset 0x00000000
>> ZynqMP> md 1000
>> 00001000: ffffffff ffffff00 ffffffff ffffffff  ................
>> 00001010: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001020: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001030: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001040: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001050: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001060: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001070: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001080: ffffffff ffffffff ffffffff ffffffff  ................
>> 00001090: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010a0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010b0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010c0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010d0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010e0: ffffffff ffffffff ffffffff ffffffff  ................
>> 000010f0: ffffffff ffffffff ffffffff ffffffff  ................
>> ZynqMP> savee
>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... 
>> offset 2220000
>> done
>> Valid environment: 2
>> OK
>> ZynqMP> savee
>> Saving Environment to SPIFlash... Erasing SPI flash...Writing to SPI flash... 
>> offset 2200000
>> done
>> Valid environment: 1
> It would be good to validate that both copies of the env are actually written 
> where they are supposed to be written . This part is missing from this test. And 
> in fact -- it would be good if this fix did have a proper test .

I can validate it again but even now log is too long now.
It is just demonstration that at start you get two saves to the same location. 
When 2 saves happens behavior is correct.
I think it will be good if you can try it on any platform which this enabled to 
see if you can demonstrate the same problem.

Love: Can you please take a look at if this can be added to pytest?

Thanks,
Michal



