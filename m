Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD44CD730B6
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 07:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348058407E;
	Fri,  3 Apr 2026 09:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ViJw4yej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533FD840B0; Fri,  3 Apr 2026 09:41:53 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1C683CF5
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 09:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMM4NDxiL4k3MVEVfWjxU8h8fG5TcqKDHadU91qj6Ahj9+X0Aoveaii7S+Xkd90w+yZOySn45HPJNj8OR9oQ6V7qLHLFQBgViGF0kOYydrSbVT8pfY5RDgu0+xVSdFalcLoXX6YPU1e6uZ0Yirvh4GfztmMObLMQTEe59cp9sM0YG/h+eq4U2L6UjCscwB70s9RzQJWMleU5Q29S/Nhogryu6W4A7bPqjoTwvblDaB2T8AvWyWISxv5jIInWmWE/x412XicrxF4WAExotzCZN6ME+ym8qSS84dN01UGNhQECqtVhpnDz4hNJJ0K5b3WZMn0LVlNildNFIvsl0RJvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAAQ7/lt36x8tejb0r8DSLRsS4ejJE/ztNNZVtSKq08=;
 b=YcwHX1u5vHoHzXJoUtxrZPgprvb3ssbsb8AhyVd0FyinRN6ftk3JhICXSXrhCoF8mPEMK+IpZ5YWGC7R56KRQSKKFZSglzgA4F6XCJpg1quBNrFwScnRvo+dSz6YhFl24KSxeSXAsvN8238O2Mxj3PvAZnuVtkBzIrMOVW16bpD7G9co6PKiXi/IViESozH2ec12+QfOZVjkhpE6EttSOgJwC/ApZ7eXvekbW6i7zkOUIKnThY4wW7WgYvuKYn8VgTEuoOHuuNWo49GfDvQjjwT2eS6ojd8w7psLxI7LsuCSUnh9Ur126Nb48JgDZn95Of3MmqmFpa6Idldh1H4XKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAAQ7/lt36x8tejb0r8DSLRsS4ejJE/ztNNZVtSKq08=;
 b=ViJw4yejmQf+3Q4UmBKEs7wxad/wqLCHz6yzZZG7E4tWNtvlEH3Y806nXc4wbVh6n/ega7pPhhsmyZQOjGQPUNPIagh6JzgDayBLBR8jO8agqQMgqGylvw3JPmQKtHM5eDnG+/gBRYPwG7bP5mWFaFg4ASot7raV7b9YBcSoYM7GtGa7nI80CsGv3wNGTIYdis63gx1K7RkiInrtRTCwcasPfMsR5XkQtGv3ISQHYF2hja9rcEnfjyb/hP7jDEDLBv+nSk6XMgMMZ0sovYmU9UCRC9nUhGTfpWOa9PId1WtlOgEaj3jtU+zKd4D5MgD0qo9QcsRXBIOn1jwth800qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::23)
 by PR0P264MB2632.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 07:41:49 +0000
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32]) by PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32%4]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 07:41:48 +0000
Message-ID: <cb03b1c9-5387-4d20-91b2-1f41b6fe6d14@softathome.com>
Date: Fri, 3 Apr 2026 09:41:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] tools: binman: Test signing an encrypted FIT with
 a preload header
To: trini+nodisclaimer@konsulko.com
Cc: sjg+nodisclaimer@chromium.org, alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de
References: <20260402192431.2421155-1-yan.wang@softathome.com>
 <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 xsFNBGQYeUEBEACp9Mxa0R+O3VXwft27iMo1uMfatjkGSMebTe/NXYDeXAc3ZhaktWik/kN0
 dksMdNHuDjQshXFjf16QCp93REtLE1m+h3d1k2KH7VU0Is/wtrAlz3zxyxWwod3H8MF3cBes
 SvFgEsb/qFQ+Re8rKG3+ab0dEqTPTsHJWkciZOxO7+J5hEcS9FKpGk5OxCWRgDHzdDnXi5p4
 VLgvXtoKujLpPlBqpGSNziJzSYtBgt979tzLkt6TNw6kL1/uNCYcmKkutAL/deVdThdMhF8p
 pWz8cSLFyB07/+oCxVVQLdsgNfpoTcv9PFuOH9Fl01F0fezcgwGwk5vr5mrNqqMeG9byrGdd
 Fos6Xf6xACZ7tUXifeFs1jr8GuB5ErGgrSIPTXJBgHHgWr8WUVcTTPjBoPWHR5hMQ4oh7+6Z
 fCdlrQSyjUHz8DWG79mRZ0dQiiPlXBxOZ5dO47Z2NVhKo8GLyHklrhaO1mgqKfHIDGF/IX/a
 TTXyiGHU/anYmzcSKLFkn5C+TMNXx4jBOT2yp51wMX2zh9odDzq/EPbN+A2kweQrfLBgLwcs
 JzsskWpji7Lb7dS8YS3yleEDhL1o26if+fE5YqlDW2A2OGjEBd2HRDyrLAcPll+mhnflgFqK
 IpHRPNsdjUqwMvWknzXMDi/u1FlOCgzFQpqRwZ4k1zyhC4O/UwARAQABzSxQYXVsIEhFTlJZ
 UyA8cGF1bC5oZW5yeXNfZXh0QHNvZnRhdGhvbWUuY29tPsLBjgQTAQoAOBYhBC/0TbUGNniU
 1s2pmlybfngNcCltBQJkGHlBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEFybfngN
 cCltEz0P/A5X/r/RlxwW7S0WBp7MK52hGtT+CApyKqEWRyJbovN6Gjor0uu+VLPqmk8y8ufi
 R2zAvO+cB3hziL7+qY/uxzXIp7j2eziBhhiM4GGzv2BqR7fGXZC9Zy7edAoDVa9QXm8MsCq9
 Ai+87bapfXek/92cnGK8Q40mRSxlgmk1ZyI1mY579k9K4el5ja48aWcvOmTsIeleGBn2BoFv
 dp7/la++0Sfs2HGtxrWeZ+eCUEGFJweU8bb+1nTmK0ksA04qFjlnS3QNPvHteeDd+eyJyq0a
 6QGrYw7czPJsmjGa6KkSdqarG1zh79GMiCvpA/kjp2V03+iRPe/OZDzEwZ3abESWxDx6z8Py
 xhsreNZG2VoNrc9QUK9hT5vYpQHvD+n2cd6V/zOBxIhH1/9I4gf4lGMYDR1ucZYJnlQarjMf
 Ty/eiur55M045vySk/ql8Jlfh7gFCBgmGd8A5LMhYc8UAA/RO9BAL7mUQh195uLmi3ARMAVQ
 TP2c9KDKV4t/Txu32oGis21Bxe8J5p8SNsMUkWV/zShLkGYiPFP3USBO9nht0TQ6+SyFXqH1
 FrmD8Iwpu7ykdAaaXVZ+8LKCR8n/je2GQ0JHcer2XoRvegwfLJFHG7CqtZZVZRxT9iYhWQAA
 xij5PpQVgHqzzHeJ0xs28n9GhFyOgU88HNruzzyzaC2QzsFNBGQYeUEBEACmlubHldszJX1R
 Gpx1T6ILdVe7rPY6SsV92JybiDghSoGzm2G76lN4BywF27xMjK4A1j1I0hdIKFmp7lUB1S/8
 NDpsiWF3YfMEhpdbEQqFvF6S+AkC0GUj1c4PNOThslFFRVSD3Zs/Oot+EJSQFA82Ws7RBBvk
 azfqlyhoLaO7A9tLQIT6E/PYVLj+YzSRWtG7LwIooYgHTmhrue6MXEk1ksQgbLJlAyhOTpoQ
 80QRrck5Qcv7j12WtpZTNWiztjG4ZywlopZfpwtn48genI0PuZB++sRfaJvcrABY2eNHD9iR
 GxmnzDldt6r091fCC9fcY/A6Licbw/I/p42f2tzwmm7Ni8SXTMqkalhGmXyMqlgHBan/AOrM
 im11508QkY1Ls7FxuMq81QP/vppxt6B7DXmI587t/PU6GP9FSQ5uWoKbL3Ny3otRgo9IG7Kl
 gX8NqGtdSGqnUcbTsafXCnQmO/18MbdFTRbaXyeGCrndUMWBJlb9tvg0Mbd/WZUTnqNvyV8f
 JaY20NsGI07haZeuW3/Wey89EiqFQtHw+V69wQCTI6VPeByfcohe4CeFAuIGyx4LGYlP+Z78
 uj5PcL2xSmruqG70HaIyhr+Iom3F9QUXqR8kitUe6Bz4MjAvGN4jzblI6h+Q4UKHB5HY5Fjj
 Y0YqGFnS75Uos16VAKJUHQARAQABwsF2BBgBCgAgFiEEL/RNtQY2eJTWzamaXJt+eA1wKW0F
 AmQYeUECGwwACgkQXJt+eA1wKW2l3g/8CLQkwqgT5Pt4Nsup0/WugJWKaKeqREeUQFZCjIlQ
 oLGenrdeE3FevRyj1qGIHRIDg7zxO7bIcePIKMhzntXYByas+dsWI/u49WIjkn+agjdvnsfm
 6iBNN2uHa27bcEGhOfvskcJVs6qPivUfcXGbl4ovF6DOHPTWsLpLkEANKK0tyZpQD2FKMHSu
 ST9edYn8gdVyCmxeSJ6uyJOBdJ62RZMgg1qYJt1TCF9SBpUYaD6boXZQLgJBIUyo5ah1OM41
 ZG4LtXnmbGoCjlfXADn1GKs6Q1tPeu7Az2HB9NmnUFYAaAk0U2TFE4c13hqBqbf28NE1i54V
 a1i4usgGeOyRYobNsB7wH1znbpuPqcFGRAln4lZt3KAIVmBtLQLUUsfeSLxNQW7mbMxJJaYG
 2pUFD1r55Ye3ODy1qz7edVVsTWjUvZaaZ2d2kQGMe5k8hbZWMefaXTx5Gt2TOULgagRhkPM/
 MVtSwPLGzbgcPyGaMgwbNFg0Lgk+Z0eFfSGO0ROuKZZmyL34FZ3CHFDVZEFQGEFn488SYBeQ
 PVFZ6XtspuBK9LSNi9Y4g4MS5NhWywy7555Q1t/NTiftzPQz3sfmr5iDzVqyxIXFZMKwOxl7
 zE8PsOtQMDauBN1eFehaPb1mlyBio5ispwRCJCm006jBSHvE4i9W+/Lu7DSE2v/LI0U=
In-Reply-To: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::6) To PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB3119:EE_|PR0P264MB2632:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a8ed9b-9444-4a0e-28ef-08de915476a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|17002099007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: M59VlE+YStyurbUx2pVh5umoNDWrixCpXL4yAhg8Bv730pH4v8ginx/ZWnfX3ETPiIVlQGhcds9jqw+fvaMxzIQFN43UKB8291KkvAk3DI0MhN5eGBbXYJr6olcVlVlb/bnyjb6sMrU786r1r3fjeNq7qLDSVDAwORzhNP1k4sryusze6K6GV2TB1dineVYs+6Y1yUrWQ7vAKdWkOWWsS/bW8SEcZLt8A3c45s78uv5s9C9ihm7jDvRZB5X1fUzdrBb8Ab2B1Qkuc0NvwmZ0EKZ13CuD4FHfgUZi/rndEN/PwA2I3rCZJT2fXCsyTEpzg6EQlgnvGOw28mCN1CWnGjWaauoB6jiivs3J55qCHTGPyvBqM1WSAiZabOWeXpa44NubHgFI/ybKQSV5SoeacTg+A9tUsHuRXDhj+ff3LccsZTrJ+BDDJ8ZgktrzqIXh10WYGdJ9AOxrGN5RUtv5fg17ryHejscraIA5mSpRTBSbrn3vhT4AQFuaWKF/Vccgu79/S3Gn1SYA1zXXXkaebW3AmQ+LsU+45IfasfpICkFG70LTax0/CQ1e2wGyX9BQ+qYwzq9ygb9kKtRGrVjd2mooerNuMcHxZY24a1yZzm2+nOUjR6CGR6xCueUJa70OhY6h0I04WUfC0pA3MgcIbuVMshoNg7vr+BiMhI00Zcppoo8/Wq/mwWS+NJZfCESNl3poTpB0ts8VH4sY45aCFfmJhs6NowhXRBBIxbVR7v4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(17002099007)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RlQi9jc0tjNGVIZVdGaENZUmtpZmlWU3pLOEtBWmljYnl0QWdrTUVRcGxH?=
 =?utf-8?B?Qm0vaFlVT0xEOGw3YW4ySFZFcmFNWmJKc2JBdzU5OUVMTXFiMVJDNE94RXV2?=
 =?utf-8?B?N1d6UGVCdHdMckdEbmNqRURWM05KTXE5RW1OUFhoMmMzMVlXc0lnb2dyd0lK?=
 =?utf-8?B?VW14UFpGdGxKdUZ1RXkrWGdLMTlNRU5nYnBEL3JVbEMydnhDUnl3Mm9lWFpj?=
 =?utf-8?B?aEhlRWNEQTBUYzlqZHl4NjNyRjV6YXRjL29QMkhQaVZLSmhSREVRTGlZcVlX?=
 =?utf-8?B?QlpTSkMxbGtKUmQxZUNIMm9UZGloeWp3ektuOEFJYTJsbExGTUNCNmRGZEkz?=
 =?utf-8?B?alZicEl6cTRLdlpha2pvcXBlcjg5QmJsMFJHVWpva3ZUZTc4UE1sc2FBTy9z?=
 =?utf-8?B?aXVaY0Z1ZzBRZEJCUUdxVm1HMHBPamM4bjZhNnNYNlltbE5NRWxGR3NyL2tJ?=
 =?utf-8?B?dmVwd2dvZVZwa2RPcTBhOEh3WWVKRVNtaWtkR3BhdS8ybmkwQnR1aGlDbnFr?=
 =?utf-8?B?emNHY0l4SkU4dFp2ZXRzSzJyRTJpd2RSbElvRGZQL3RaaElNK1htYTBzUVZr?=
 =?utf-8?B?cG1lUGdHcjROZ1ZJWUV0M3N2N3dJZjRjYk9RVDNnaDQwdEtoYVJReVhMdURL?=
 =?utf-8?B?R1dUQWUyWGNOUFVuY2JkRzUza01wUUo4aFZROGhKbGVPODdodnVyU2ovbDdh?=
 =?utf-8?B?V0RDaCsycmpRcXkzZXVETGxIb1dNR2VpUGR5bWl4ekIyNlBmeldRdG9HZlNu?=
 =?utf-8?B?L3NVVFRlV0VxSUlTL0FoSU9wZXhRaFdoNy9HaTVxUVBkRzdCU2xWaGFuV2RN?=
 =?utf-8?B?c284dTI1UVNQWEYwbFllQmcvSmFnRXR0VmRhYmxCbzcxUUQxdGtwekRENE5o?=
 =?utf-8?B?UzE2anJDZ1ZwTHAwMkk3cXRyS0VicFQ5eXNKdGJMU2FkS0R5L3Y3YVRTYnhI?=
 =?utf-8?B?eWhMVExDcjhFNFFjQ2ZOdzQxbEFMUG1mWWZob3NTb0F4eEtCS3E2L0VseUlX?=
 =?utf-8?B?MUNPaWJ0VytjTDZzM1pOVzUyOGROR1NwbkZGL3poYW94Y3Yvc2hscnhoRWFm?=
 =?utf-8?B?WUlGRDRuRm1FUUhuVFZwa1FMQ3BMMlZkNjhDQjAwdHVUU1JVaWhvYU43VFlS?=
 =?utf-8?B?SVRkbTlxTG9NZGYzbVNCWEpuS2x5dnZqR2FGZy9ncmd1YjRHa0lPN1Zaaytm?=
 =?utf-8?B?bkh3TUMwWG4xQ3BIdzNQSWEwa05LWjFUekFQWmlsMzQxbFFtY3cvLy9LZVRj?=
 =?utf-8?B?OG9QTjRURUZLay9wNWZ5U1hWaStvNDRzK0pJWTA3MHhJODk2VGRnMVFNa0FV?=
 =?utf-8?B?aFVBdjM4NnV3Nnl1VDN3ajBEdTVmcGNWaHlxUmtVZ2dId3kwS0NxNWRuMklN?=
 =?utf-8?B?dzNjNlZjUHBML3dlSHFRK29uWHY3UUZhODdmVW5JY3hoNm5UVnY2Y1NmZWZp?=
 =?utf-8?B?alVSRSsxMm5sWS84MlhIaEF6TVBLZUt6T1FuTHYwWnhtREgxbCtqY2FDMnEr?=
 =?utf-8?B?dDRjL0tycE1GNit2RGdaNmRIK29zL2lmVmFtcXBJU1RqaUtYWTZDLys4S1c3?=
 =?utf-8?B?eGpYKys2OTFXN1pZcy95S3VLTUZSeDZDSXk1SG4yK1FRYnFVaDBaVHV6OWN2?=
 =?utf-8?B?TjJqaEl1WWw4RnZKbmRveXhUTWdOZHZHU2Y0dElhYUl4Ny9BV1FFUFRoV3li?=
 =?utf-8?B?elNvN1Vtdkp2WjJDS2diWnZ4UWM3RFl1a0M4QkZlNnppaWhQYWhJcC81MmJB?=
 =?utf-8?B?T0NVSDVnUVVKcTY5Mis3eEw4eit2RVRsMHk5U05CK29tSzlobzQ4UWV6N2ho?=
 =?utf-8?B?MjI4Tm80Wm5ReXI5MTY1Rm9Ib2kzWkZjU0VySURNcmh1SUhRZGxya0t6R0Ns?=
 =?utf-8?B?SlhPYUt4a0p6b0l0WG4wWjlwNUxGTWI4R0VsM2R1aVJzczByOGZwQmxLMWJF?=
 =?utf-8?B?ZU92Ym5YbE56VVdvTkpPdCtQdkZIYVNvL2JqdjlvVHcvOHJQdFltZU1hS1Ix?=
 =?utf-8?B?UVNJRmFMYXFxMmo5VFlONUJ1NDNTNlQ3ckZlTmNsV1MrR2V6ZGc1QmJUcFF1?=
 =?utf-8?B?ckZIejhFRXRGQisyQUtieWxOOThVUktrMnlKZ1Z6Vi9BQitWT3MxMkFqMFpH?=
 =?utf-8?B?UDVXQWxVTWV1YTc2SjIxSHJPZHBSaEtCMFdxWXpmWkE3ZWxEcFJIRHhrS1Ez?=
 =?utf-8?B?T2F4cW9tUndrRVprbnNGL3dRbDZBVnNQSG9iZmRiazlyME5ialhmUGJHYSs0?=
 =?utf-8?B?cUFjVEtUaGIwUlZaK2Vlb3VPYUVmVngxTjhEY1Y5Q1plQzhxWUlZcEN1WmNx?=
 =?utf-8?B?Q1pGTW9CY3FvYzRRaXBrZFVCOVBXVENUMmUzQWdEeG51b3BmeVNlSmFHU0FS?=
 =?utf-8?Q?WT64aHGx2Py4xobk=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a8ed9b-9444-4a0e-28ef-08de915476a3
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:41:48.8972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ACwStfvvqiNfsszTtciTBrhToTpeySzIucLXw/PppIr73kAGNOTv011ZfgoiNNbkzx+pHJILVDZIp+9Dsfeu0S0/NmXAKkiPR0YCOsROjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2632
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

Hi Tom,

Just after pushing the v3 I realized that this test would better go 
under tools/binman/test/security/ instead of tools/binman/test/fit/.
I am going to push a v4 with this change. Sorry for the inconvenience.

Kind regards,
Paul

On 03/04/2026 09:32, Paul HENRYS wrote:
> Add a test to verify the preload header correctly signs an encrypted
> FIT. This test exercises the case where encryption uses random IVs that
> would change between mkimage calls.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v3:
> - Rebase against 'next' branch
> - Move test in tools/binman/test/fit without a numeric prefix
> - Update encryption key path passed to _DoReadFileDtb()
>
>   tools/binman/ftest.py                         | 21 +++++++
>   .../test/fit/pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100644 tools/binman/test/fit/pre_load_fit_encrypted.dts
>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index ca5149ee654..301c7705837 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -5895,6 +5895,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>               data = self._DoReadFileDtb('security/pre_load_invalid_key.dts',
>                                          entry_args=entry_args)
>   
> +    def testPreLoadEncryptedFit(self):
> +        """Test an encrypted FIT image with a pre-load header"""
> +        entry_args = {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        data = tools.read_file(self.TestFile("fit/aes256.bin"))
> +        self._MakeInputFile("keys/aes256.bin", data)
> +
> +        keys_subdir = os.path.join(self._indir, "keys")
> +        data = self._DoReadFileDtb(
> +            'fit/pre_load_fit_encrypted.dts', entry_args=entry_args,
> +            extra_indirs=[keys_subdir])[0]
> +
> +        image_fname = tools.get_output_filename('image.bin')
> +        is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
> +
> +        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
> +        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
> +        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
> +        self.assertEqual(is_signed, True)
> +
>       def _CheckSafeUniqueNames(self, *images):
>           """Check all entries of given images for unsafe unique names"""
>           for image in images:
> diff --git a/tools/binman/test/fit/pre_load_fit_encrypted.dts b/tools/binman/test/fit/pre_load_fit_encrypted.dts
> new file mode 100644
> index 00000000000..f5e9bf9426c
> --- /dev/null
> +++ b/tools/binman/test/fit/pre_load_fit_encrypted.dts
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	binman {
> +		pre-load {
> +			content = <&image>;
> +			algo-name = "sha256,rsa2048";
> +			key-name = "dev.key";
> +			header-size = <4096>;
> +			version = <0x11223344>;
> +		};
> +
> +		image: fit {
> +			fit,encrypt;
> +			description = "Test a FIT with encrypted data and signed with a preload";
> +			#address-cells = <1>;
> +
> +			images {
> +				u-boot {
> +					description = "U-Boot";
> +					type = "firmware";
> +					arch = "arm64";
> +					os = "U-Boot";
> +					compression = "none";
> +					load = <00000000>;
> +					entry = <00000000>;
> +					cipher {
> +						algo = "aes256";
> +						key-name-hint = "aes256";
> +					};
> +					u-boot-nodtb {
> +					};
> +				};
> +				fdt-1 {
> +					description = "Flattened Device Tree blob";
> +					type = "flat_dt";
> +					arch = "arm64";
> +					compression = "none";
> +					cipher {
> +						algo = "aes256";
> +						key-name-hint = "aes256";
> +					};
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-1";
> +				conf-1 {
> +					description = "Boot U-Boot with FDT blob";
> +					firmware = "u-boot";
> +					fdt = "fdt-1";
> +				};
> +			};
> +		};
> +	};
> +};
