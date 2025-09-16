Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337B1CAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30B481E13;
	Tue, 16 Sep 2025 20:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="R767pJ7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF098309A; Tue, 16 Sep 2025 17:47:17 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDF9803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 17:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2uk5ZgKeSx/xpRSsj2Cu+uSnbwHoFgLrNzb84XMXoVf1sedOvDrsWm0b6wjSSDfJt6lVGjhAbSMwAsDcxWi+kST2VCo3fnZBV8nB9MkpOge2qn5e/dd6ZkyT83E98hKMqe8+v/GN+i2frZPjmMzrL/laKTDEv2QRY+mWmbadfE6k0IIoqTZNVSFewv/CyvMhTiU0v1x/RCMMJ4X/owfsynpHzI00h336Ykpsx6D4UH8pqak8cIqaoRz5aqTpaDhSKjC/gCElJ1YXRNfQ46FTXhRCjI3e5tnJXfIBfUF4BDMqjH6r6SyBsbAuPMF9wyjYkYIzY04SebG2XuXQx8fEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uROsUhEZueJ5oILmLWzNPU2/8ie8GSH1F/c/XZwV3WI=;
 b=BWUVVLvcpnRUsck8EXYLfqaU4B1GM2+/1LQqzDb1O6k9zfiUEdMf7oqOKgvHljvCvK7E9B3CiuYm32PYrk5sEJ8cNdbuc3B9XMyX1NP4fylO7KLVCnNQCtqqk5uVtq3O8ESsqqPUIu8wQhMARuY7CiehLYn3RLtWi18phq2TX0TMH+Q9w2VFuXgSoSsh7RTCP0x2O+OtIpsA9oVJQDw8B2I+rPl+rLyni9ZohJyrdxqGGl5IJzVNoVrNN7vPD+qlrFH7mfRxGaqp2BmNoIl/8ClRuGyS0QE+UHCFXk91D3jKZyOR/12nK89nhhRR7OarAQPNQ0D+wse7sZZUq9Uwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uROsUhEZueJ5oILmLWzNPU2/8ie8GSH1F/c/XZwV3WI=;
 b=R767pJ7gRLwJz+2sSQnQJWtntkWKoMieArHjMSCR/5zfQ5TcGJ7gwX2M2QM9/nrtBQcZKFAqVtlAaZRpnP8Wmy9u6afhlYW42t4R5rQSa+GWkw7pmXnuCiVfA8VrUTtSVXcXqeRbpnxuKAgJSehGx7FSz5102fjcWJ+cjE0ciUTD3Vf18kMHRpeZR87EiePnNL39tlDJ67fTRKJ1Nza+H+lFWSin9ZFz1lnq1PEvCtsy4dvMMrAhpsk1q0kCA/svwhAI8jZ09U9yWL4I7J2kMuvWS4iH8aRxG2210ipfedZkWVUKtdxsgXOsP6NSPeXm6+ZvbKe1nZO6mcJv5eAaeA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DB9PR03MB7706.eurprd03.prod.outlook.com (2603:10a6:10:2c8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 15:47:12 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 15:47:12 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Jonas Kvinge <jonaski@opensuse.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mLSGhZUAgBDNUAA=
Date: Tue, 16 Sep 2025 15:47:11 +0000
Message-ID: <60d548b8-1cbe-4fab-a49c-8b1cb9027f19@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <f12fccf0f6d6b36fa58a7ef971ee9d06b566b03a.camel@opensuse.org>
In-Reply-To: <f12fccf0f6d6b36fa58a7ef971ee9d06b566b03a.camel@opensuse.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DB9PR03MB7706:EE_
x-ms-office365-filtering-correlation-id: 88572c04-fc1d-478e-6dd4-08ddf5384d5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aU5qM0ZyNWZRanFsbk9GS1RIUjRaczZ0eHphUld2VEdFbVc4MGlSa29JMzNp?=
 =?utf-8?B?RHBqcEJRTjBBM2hsWEo3bnA5Q3ZwSzBPMi9HaE9hTEJoZTdCbXU1SGhrOWpZ?=
 =?utf-8?B?K2s0aUd0NlZXMWlDV1JPcVhkRDNZUGZhNW9LVzFkT01xUzU5UWVFaWtxS0xL?=
 =?utf-8?B?OUlNemxBT2wrNCtWb0Z5TGRWR0dXNXRxVEw1Ny9CRklUa2VUTGhNaGs0UlQ5?=
 =?utf-8?B?bmJIL1BVVjgvV0k5TytlV3NPUkYzckRTems0SXQ2aEhkSXVEK0V1dnJVMi90?=
 =?utf-8?B?QUNIb2RmY3ZYU2tSUGlBWDByejEvYWxnWFFoVUQzL3ZjSVpScmgwbFNCVXZG?=
 =?utf-8?B?NXpPK0orSWRkbERBTjJIbzRoZVlIL3pPL3hjZ1doUXVqczd6Q3hDZHNrNzNO?=
 =?utf-8?B?elQ4bnF2MzdTa0J5NWV1K3lhaFhVb0swOVVRdjcwVWxZQU4rOGZCMnM4SG5O?=
 =?utf-8?B?S1NjOUlQNkl4YXZsYWhQcXZDM0hlVVFNYUJYRkZBMS9SVEg4L1QvY2xCWTJE?=
 =?utf-8?B?YmdWL0QxRUdHR0plcjlaMWs4dVFOZlhvcVJSYUkxTjY1VU5vY3pVRzJzRUwy?=
 =?utf-8?B?WDFVbmdad1lCdzVsamt1dERJeUdiaU1MZlhsaGIydzB5b0FnTEdhVytPODVT?=
 =?utf-8?B?aFlLbkMxRTR4enhtYW85a1dTT0YrLytBbHdSaGtqR09zdDljdDdodmg5STd0?=
 =?utf-8?B?M3hlZ0RMWmp1MDVtRmV4WGZySFkybjVvSzhRcVBUNUxxZlZnSE0rT01CM0tv?=
 =?utf-8?B?K28zYVE0NHlkUHFJRW9IUG1mczk0M3ArbUdFWkgzUU5IV1NvOXlqcGRpVFg5?=
 =?utf-8?B?cy93SjhYeVlvdWdLbTV0Tk4ya29lVVhyekpqS3Y2Y3BnRXc1UnRuWE15VDhY?=
 =?utf-8?B?SCtXdkRjN2YyTVdXbjAwRkRyQTVmK3NJOGtkMHczclR5VEkwMXNLK1ZEOXJY?=
 =?utf-8?B?c1UvZGRNOW5SU2tidjNMVlBQVHZkL1UxMjhLeWhQY3ZZUFU3TEs4dzlDT3VB?=
 =?utf-8?B?Vk1EeE5jS3F6cFhJTDJGMWV4SnNXRnVTU3luNDk1eXpWMUpwamFHcTVCd2l0?=
 =?utf-8?B?R2tVZXhFdXhaY3pKSEl3QTFDb1R4QjFUTEpXMC9CSmFuRWswa3dDMzR6WkIr?=
 =?utf-8?B?M1dqQ0dnUGh4S2JKSlNyU2NvZ1V5NDFHYW11ZmJhSk93RGdkMlptRDIyaVMz?=
 =?utf-8?B?b1AxbitHTVdDckRTZkRyTWJ6cjZXTUlDVmVmVVB1dU1oS1R1MVhEZFRvNWt6?=
 =?utf-8?B?OU5sNk5rRjBFZXRiU2tkQXl0K1dUajZhMEQ0TDdaVXcxK3pzQnZycnphREF4?=
 =?utf-8?B?QmNBTGx1SmpzdkIyZEk5VlRTbE1ZVEJjNjIralVBMW1hZ0Y3NU5VWHh4aWIw?=
 =?utf-8?B?WWExNm42dWg2K1dRVEVvVE9nRU1pbDJRQ2V4WjZETUxCNEl2U3MxUTl3dXdo?=
 =?utf-8?B?d2tEaEVZM1VOMThYaGIyeUJSamRSek8wbHdtMGpkSUlrY1F4aUhCKzJyVEVC?=
 =?utf-8?B?K2dXUjhRcmkxOGxPc0UySzEzZk81Qkp2cjhxdE5hMXpTOHdUaDg2Mk5qOVpM?=
 =?utf-8?B?a0FQMU5QcHAwdFRMR05VNnE2ODRqeXlpa2FmT3loYmpleVlGMTNxeVpQbTZl?=
 =?utf-8?B?V2l5OCtiQ0tpY1dOaTFETXdzRHc5Q3BPN3ZYWEI0Rld2VWNtaFdCekdaUzZo?=
 =?utf-8?B?aDhwWndWajdSSlZrVmZMNFZBbU9CcEgzNFVCUVJMb0RXM3licHpldWdaSG42?=
 =?utf-8?B?VVNzRmJwVU9TQjdYcTNYd0c4eTFMUDU5eERJTnRyUUdySVpPWGZXVFdieTNt?=
 =?utf-8?B?eTFCVTZJWTZuaDhGMFBtWjhNWXlsNUpWaUZ3Wkg5YVU1ZkhCeFp1Nm10RkpH?=
 =?utf-8?B?SGRqQUVjN011UVlTalZLM1VGYzFQUG1UZFdtNDF0YlFJOEJTNXZucTE1T0ph?=
 =?utf-8?B?S2lZYm5EeER2bFZIQWxRaXhjYWZJZ3B4eXdlVEFGTDh6WjZmbEVTSFVlbjNa?=
 =?utf-8?B?N2k2cEtPbzlRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um9PNHZ4YlFPME9HUEpVYStSbTVReW1KRU1DemcxcEVDYzFGK2lsUWJFR1ZU?=
 =?utf-8?B?OTdxQ0ZXTXZVa2hwNkpST2lwMlQxblRkZ1EwbHRWa0dwR2c1dUhYRU5UelVa?=
 =?utf-8?B?YW9URGdvQWhsbmFKV0hVYkVTRTVzRVFUMWs4cmJNdnRwWHY1MTdYV1FBZHFK?=
 =?utf-8?B?bTlWUklUelhlQm10RktIZCtLSGlGY292K3dpOFZPT3FsMGVTeE1SZzdNU1Nw?=
 =?utf-8?B?THlweXFNc2swSGk0SDRhVGF5allJNzVOTU9oSG43WEpJcmNVS3UzQk5Nb1h3?=
 =?utf-8?B?WFRxT1NpbFFTVy9EZC9LZXpTZlFOb1VmNHAzSXU4bmFiSHNlbGFJOEphMWt4?=
 =?utf-8?B?dTdvM0pmQzY4WHlNUmNxU3JudWkyeENkWVM2N2lZNlJENXhtaVYwa0tSdjRj?=
 =?utf-8?B?WXpKUXFDQmVtZjgvdFBlM2tNZ3czb3dCZ2p4enZQSHBxN3NtOGQwQjV6emJO?=
 =?utf-8?B?NFQ4TFdqUEJ5MTFMandjdDJNeTA5bEhub3JjNHdqSXlRNEN0OFZkNUk4S0pU?=
 =?utf-8?B?NTlyLzFBNXM2VlBsMUJORk1NaVJqcVNBZGZuZHkxOWpGbnhTWllUVXltMHJI?=
 =?utf-8?B?MFFrQ0tBU0g4RWpqbDZhRGpzWDlqdXZlbE9uNFJOOTE5UDVLZUJFQ3hQQ0RH?=
 =?utf-8?B?YkhkWFJValJhNnhUOVI2RityN1VTeFlqc3lsa3NQaytUU1kyRG5qMjg5T3Vk?=
 =?utf-8?B?QWFUMWVHRzJsMkpFcGdQM2NxVC9OcDhobmp1NGttME1SQXhGYjRUaU5laG5D?=
 =?utf-8?B?cnluZjVSYWdmVVpNQlpFVEVjYVBTUkRYSjFyRHczM0lYekVady9RdlFVRjNt?=
 =?utf-8?B?RXg3SnVkZ0NLOVplREVOVG1jU1orQmRNQ3BUaThlVm11Zk04c3YyWnl0a3hs?=
 =?utf-8?B?cUVJZ1VtYWpZY2tDeFNJQ0VEQytIREhMbXZiSjhrV2FXT1AzbjVybk5mL1lH?=
 =?utf-8?B?VFBvVG9wTFp1N0tHMFBqQWpxRDRuYUZRTmFWV1VnTm5lWXBMaHYyMUpwbXB2?=
 =?utf-8?B?WER2b1BhK0MyYThITXBTMjVnQ1hkaVRQSVgzQnR0bWNNZ2I2RUZYbXJjdUwx?=
 =?utf-8?B?OFlmc2YzQ1cxRUZod1NVTDNkQlZFOHhlcko3WVdHL3EwRFdXS1RVY0s4M1Fu?=
 =?utf-8?B?eXYyRFFOLzZqVDJpSWY4eDlkRG90MWowTE4za0hBVHYyd1U4Z2VwaHppcXEw?=
 =?utf-8?B?WElMTXFjRTMxbHlCUHcrRlJOQU1kN25wNTBLd25qbE9Ud0xHSUJMNEFuM21o?=
 =?utf-8?B?MXE3Y0h5VW9pUlVLdnl4cEpxWEY5QWU3b1RXQ040V3pFQTc3NmlkcFpQQTN3?=
 =?utf-8?B?ai9JNkgyYnY3Tjd4RUFvek9XM29hSS9IdTRnbHkxd2prd1ZkeFV2MlVicFRs?=
 =?utf-8?B?MW9PejV2MlpSZ3dwNXJVWGxmY0RmYUhIbWxSdnBONWVvcmVrMTJmNDNGRHVX?=
 =?utf-8?B?azZqczhTc0NrMXR5RTJJY255ckVha0xUMC9iYmY3K3hBUjV5blJpTHl0UUo1?=
 =?utf-8?B?NTlhbUtTN1g2UDFMSzl1Z1prSE8zbUpKMWFOeG9YSHBEeTc1UjhzQ0EwdjRF?=
 =?utf-8?B?SFRBZlhlVUR0Zko3YXI1YXV6ZGozeTBEZVo2d3Y5MFFPWlZyV29TT3RIelgy?=
 =?utf-8?B?UW1Jc1MzUUlsa2NIYVhPZnFmbElwZW5hbVhjUVczY2VKbkMvOExaNnhXdW54?=
 =?utf-8?B?cDc5RWw1VFhialpLMTMrWnBTdHp0K2liTVlPcjN5L2NMUGRxN1pZMGN6Qkg2?=
 =?utf-8?B?cCtkb0VqMlAvMXdNTjFFd1B3ZFgxME1LczBJNmhtVzhKMGJNb1FoY0w5MHNv?=
 =?utf-8?B?T1hkRDM0cXpQT0tobUlnWXJZQnJCekZHQkFoSTZqYmV5T21veVhJWXdjRE13?=
 =?utf-8?B?UlY0Z0lsSkZRZ1lBM085bS9KcGF3SisydmZ5UDIxcmkzR2NyaDlISFZGaGVh?=
 =?utf-8?B?MlBlRTdTWk5FRXVWbklXM2NndnJUUEYrcUdHdTF2ZnFjcDRGSFBmUndyVWQv?=
 =?utf-8?B?RW1naVp0K1ZSTm9ocnlHcUdUMk8vNzkwQ2ZIVWl6TDFKdTRWRTBaYWM2cFRW?=
 =?utf-8?B?cE5QRzQwYy80M2J2VUtpNDMrT0tRczZKMncvSmhKeHlwSDkvV29vZEIyQmE0?=
 =?utf-8?B?TmVoNmVKdWc0WFI3S1cwQXJDRmpDaVlvMEZSUGRpUGhaalNFdlR3MVZ4R3J3?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64A1D6BBBD84CC488CABE1A9E71593FF@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88572c04-fc1d-478e-6dd4-08ddf5384d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 15:47:12.0847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmxeMPJM+LBKC8bEgZ/UCGNWaVVSH0ZiK87IGmK6VkoeeYNIx8NCYkBcrCob1QnHHBDU+3FgHYHlDnkkbqZAVlI4MorzNV9a+xCoWWFGOH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7706
X-Mailman-Approved-At: Tue, 16 Sep 2025 20:54:24 +0200
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

SGkgSm9uYXMsDQoNCkkgc2VlIHRoYXQgcnAxIGJpbmRpbmdzIGFyZSBhbHJlYWR5IG1lcmdlZCBz
byB3ZSBoYXZlIHN0YXJ0ZWQgcmViYXNlIA0KcHJvY2Vzcy4NCk9uY2Ugd2UnbGwgZG9uZSB3ZSB3
aWxsIHNlbmQgYW5vdGhlciB2ZXJzaW9uIG9uIHRvcCBvZiB0aGUgbGF0ZXN0IG1hc3Rlci4NCg0K
T24gMDYvMDkvMjAyNSAwMjoxMiwgSm9uYXMgS3ZpbmdlIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIGpvbmFza2lAb3BlbnN1c2Uub3JnLiBMZWFybiB3aHkgdGhpcyBp
cyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0
aW9uIF0NCj4NCj4gT24gV2VkLCAyMDI1LTAyLTA1IGF0IDEwOjE1ICswMDAwLCBPbGVrc2lpIE1v
aXNpZWlldiB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGdlbmVyaWMgc3Vw
cG9ydCBmb3IgUmFzcGJlcnJ5IFBJIDUgaW4NCj4+IFUtQm9vdCB3aXRoIGFkZGl0aW9uYWwgaGFy
ZHdhcmUgZHJpdmVycy4NCj4+IFRoZSBmb2xsb3dpbmcgZmVhdHVyZXMgd2VyZSBpbXBsZW1lbnRl
ZDoNCj4+IDEpIGFkZCBnZW5lcmljIGJvYXJkIGNvbmZpZyBmb3IgUmFzcGJlcnJ5IFBJNSBpbmNs
dWRpbmcgZGV2aWNlLXRyZWUNCj4+IGZpbGVzOw0KPj4gMikgYWRkIHN1cHBvcnQgZm9yIFJQMSBj
aGlwIHdpdGggYWRkaXRpb25hbCBoYXJkd2FyZTsNCj4+IDMpIGFkZCBzdXBwb3J0IGZvciBycDEt
Y2xvY2sgZHJpdmVyIHdpdGggZHQtYmluZGluZ3MgdXBkYXRlOw0KPj4gNCkgUENJRSBCUkNNU1RC
IGRyaXZlciBzdXBwb3J0IGZvciBSYXNwYmVycnkgUEkgNTsNCj4+IDUpIGFkZCBjbG9jay9yZXNl
dC9ncGlvIGRyaXZlcnM7DQo+PiA2KSBhZGQgZXRoZXJuZXQgc3VwcG9ydCBpbiB1LWJvb3QuDQo+
Pg0KPiBJcyBpdCBwb3NzaWJsZSB0byBnZXQgdGhlc2UgcGF0Y2hlcyB1cGRhdGVkIGZvciB0aGUg
bGF0ZXN0IG1hc3Rlcg0KPiBicmFuY2g/IEknbSBoYXZpbmcgdHJvdWJsZSB3aXRoIGF0IGxlYXN0
IHBhdGNoIDkgYW5kIDExLg0KPg0KPiBKb25hcw0K
