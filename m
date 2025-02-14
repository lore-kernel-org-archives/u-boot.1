Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3D4C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 05:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5FAD800C2;
	Fri, 14 Feb 2025 06:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=asus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=asus.com header.i=@asus.com header.b="GFIAGua6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DF880756; Fri, 14 Feb 2025 06:09:36 +0100 (CET)
Received: from ms.asus.com (ms.asus.com [103.10.4.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA12801BE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=asus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1337bc180=CW1_Huang@asus.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
 t=1739509772; x=1771045772;
 h=from:to:subject:date:message-id:mime-version;
 bh=2EzYGaJrNfjY/NMQWwAfnoDBzNhwDh6lJmXVwcRbRUk=;
 b=GFIAGua6fHG4Xxv7ogrkCbRsCdKagqPGXr4bqEt+OnMiv8t1wfsdq0WK
 plDdUuhVgKLzpNOpgMjeORhDK32wROn8rfAVcTYrtKYHqu99+ERR41drx
 EZrh0G3SmKEBtF9s46FtbACgeNtlGXjWY7QNkdaZAKDlr8UE1Gu3dpWXY k=;
X-IPAS-Result: =?us-ascii?q?A2FDBACjz65n/0IvFqxagRKBSoFBgQN9hjqRcJdChH8qg?=
 =?us-ascii?q?SwUgWoPAQEBAQEBAQEBCAFEBAEBhAaBAQIWinYnNgcOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQEFAQEBAQEBBgQBAQECgR2FNUcMgluEO14BFTcELyYBBBuCe4IcS?=
 =?us-ascii?q?JQJnDgPgTAaZ4IYBNx+gQgJAYE+gWqGSxoBKkhqhA4BOINEe4JPJm9CgWZRg?=
 =?us-ascii?q?XSDCQESASODUEOCLwSBEIEfgUCDB2eGSJAzg1WCHYg3gUdLMywBVRMXCwcFg?=
 =?us-ascii?q?XEDKjYVHIFGQzc5gg5pSToCDQI1gh4kWIIrhFiEQ4RNhViCEotYZx1AAwttP?=
 =?us-ascii?q?TcUGwUEgTUFnWqEYBOBKRAQQnArZRFEOpJKFI9MR4NVn08Ngw+BCQWheBeEA?=
 =?us-ascii?q?40GhmQDGZJJmH0iowoshSwCBAIEBQIPCIFBLQKBHXBwgzhRGY48Fs1DgTQCB?=
 =?us-ascii?q?wsBAQMJgR6FKokuBS9rYAEB?=
IronPort-PHdr: A9a23:DvSMcRICK8aR9hLOytmcuBphWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEv7M11BSVDdqFo9t/yMPo8InYGlY8qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebgtWiDanfb9+M
 Bq6oArSu8QUgIZpN7o8xAbOrnZUdOtawn9lK0iUkxjg+Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXjSi8
 rtrRRr1gyoJKzI17GfagdF2galGohyuugZ/zpbUbo+LKfR+Yq3Tc9AGSmVORcteTTBNDp+mY
 ocTE+YBPuBVpJT9qVsUqhu+ABGhCf3vxTNVm3T437A63P4nEQHJ2AAiGdQMsnLRoN7oM6ofT
 +C6wLTQwjvBcvNZwzH96IfTfx87uvGMQKlwfdDNxkkoEgPIl1OdopHqMD2JzOoCqXSb7/Z+W
 uK1jW4qsw98riWhy8otloXEiYMYx1Ta+Sllzos7K9K1RUB1b9K4EJZdtS+XOYtqT88+Xmxlp
 Ck0x6EJt5O5ciUHyYoqywPZZveacIaI+gruWPuTLDtmnn5pZqyziwy9/EWi0OHxV8i53E5Uo
 idEjtXBuHUA2wHP5sWDS/Zw+0Ss1SiT2w3W9u5JL0U5mK/GJ5MuxLM7i4QesUDeHi/thEX5k
 rWWeFgl+ump9evqeqnqq5mBPIFukA7+KL4hmsmnDOQ9NQgBQnaU9Pyn1L3m4U35WLJKjuAqk
 qXBsJDVO8AbpqmhDgJJyIgs6AqyAyu63NkZg3cJK1xLdAibgIjuIVHOOPb4Aumjg1i2ijhr3
 O3GPqb5DpXMKHjMjqvhcK5g50Ne1gY/185T64xOBrwOIv//QE78ud3AAh88KQO0wuLnCNtn1
 oMZXGKCGrGUP6PPvVCQ5OwvPvODZIkauDvmMfcl/OPujWQjlVABeqmp2IMbaHajEft+OUWWf
 WLsgssdEWcNpgcyUfTmiEeeXj5Le3ayQ6U86ykmCI6/FojDQYetgKCa0Se/H51WfXxGCkuWH
 Xj1aYqEXfgNZDiPLcB/wXQ4Uu3rVsor0haynAv70KZ8aObZ/D1euZ+pnIxooufUkg0a8T1vE
 9/b32yLXyd4kzVbaSUx2fVUnhU16kqK16c4ewSgVJQHzMwQZScnPJjT5+VhFsu0UQXEKITaA
 G26S8mrVGliBuk6xMUDNh4V852KghPC2n+sBLkY3/yOCYcv+63Rl372O45mynnA2aVg6jtuQ
 sZGOWC8wKIq8Q/VCt3FlkyDnPOscqIRlCfG6GaEyz+Iu0dVGA59WKnIRzYRfEzT+N3i+1iER
 LirWtwa
IronPort-Data: A9a23:T1Km+K90Yy+oXiqwDr1oDrUDE3yTJUtcMsCJ2f8bNWPcYEJGY0x3y
 2pMCD+Baf2ONGHyLd91Po60pkkC6MfTy9NmSwJrr3gxFiIbosfsO4+Ufxz6V8+wBpSYFRo4t
 a3ySTViwOQcFCK0SsKFb+CJQUFUjP3OHPynYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzBXf8s9JKGjNMg068gE431BjCkGtwlkAzY/lNoGjfmxE9ZH7IDfrpR5dQatA88t+SH
 44v/pnglo/q105F5ueer1rOWhZirog+neS5oiE+t6CK2nCur8Gpu0oxHKJ0hUx/011lkz3to
 TnkWFPZpQoBZ8XxdOohvxZwGCp1O4BZ4fz+BSKHq8eO0m+cQnDN+qA7ZK02FdVwFudfKFl83
 KRAdgwoQlaIgPiuxr+nDOB3m99LwMvDZdxF/Cs6i22GS6h4KXzAa/yiCdtw9whpseBTFPDRT
 8MCdCEpZxPFC/FKEg1PV8JnxL/y7pX5WyVcln6boawe2W300wl63YPXMYuLfvXfEK25mW7d/
 Aoq5V/RH1QQM9uD4T6E6W63wOPCmzO9VI96KVGj3qc12hvJnCpPV1tICzNXvMWEt6J3YPoHQ
 2R8x8bkhfJaGJCDJjUlYyCFnQ==
IronPort-HdrOrdr: A9a23:T0Ya66A3EP5XLNTlHegPsceALOsnbusQ8zAXPh9KJiC9I/b1qy
 nxppkmPEfP+U8ssQIb6Ki90ci7MAXhHPFOkO4s1NuZPDUO21HYZb2Kj7GSpQEIcheWnoU2u8
 ZdmsBFeZ7N5DNB/KTHCXyDYrIdKa68gcWVbInlvhRQZDAvT5slwxZyCw6dHEEzbhJBH4AFGJ
 2V4dcCjya8eFwMB/7LTkUtbqzmnZnmhZjmaRkJC1oM8w+Vlw6l77b8DlyxwgoeaTVS2r0vmF
 K12DARp5/T+c1T+CWsm1M73K4m1+cJDeEzSvBkv/JlZwkETDzYJbiJFYfy/Azd69vfk2rC2O
 O82SvIef4DqU84tAmO0F7QM8qJ6kdr15eZo2Xox0cK+qbCNWsH444rv/MCTvMdg3BQ++2VFM
 pwrjqkX10+N2KaoM213am0azh60kWzunYsiugVkjhWVpYfcqZYqcgF8FpSC4poJlOO1GkLKp
 gcMCjn3oclTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2i5ozuNLd7BUo+
 Dfdqh4nrBHScEbKap7GecaWMOyTmjAWwjFPm6eKUnuUKsHJ3XOoZjq56hd3pDfRLUYiJ8p3J
 jRWlJRsmA/P0roFM2VxZVOtgvARW2sNA6duv22J6IJy4EUaICbTxFrEmpe7/dIi89vffHmZw
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3AQlXoZGo1xL56+uD/WKQOymjmUcsueXvw026TGmv?=
 =?us-ascii?q?iMXxiVaC3E26b2Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:76AYggruMyBgHGUef+sezylmCutm56KHMkUqjpANtvK+NH0uPx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from unknown (HELO APZA006TMD.corpnet.asus) ([172.22.47.66])
 by ms.asus.com with ESMTP; 14 Feb 2025 13:09:28 +0800
Received: from APZA003EXB.corpnet.asus (172.22.6.15) by
 APZA006TMD.corpnet.asus (172.22.47.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 14 Feb 2025 13:09:27 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (104.47.26.40) by
 APZA003EXB.corpnet.asus (172.22.6.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39 via Frontend Transport; Fri, 14 Feb 2025 13:09:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPaH2Tx5seGXeHQ54sTJs+OBRH98vLi80wy9I5hP9j9Ci4gjdr5DfFeMTZ9NcdsXcmDdyk3xYadZY6PLpB/Kjg6AKHpAr69p1WHvPeAeaWhf18DRTNNCTPThVSHYth131Xp7c+tNPM+PdwqQ//e/56e6HmWBu5YXqm9pp9fajXfNzZvnyjt3yRY+iGjBa6ujfKlbCIuQ5bfLjFR7oKy3Rn52XgAOBVbPtFHjj15D9mbWPHe/7s8pcQZ/c5Bib5EjW3x8A+MQHisIvZHoPUP1EYZ+HIfEJqRLMhe8b+pXr3VzEwwEiuRjwQzCy7c3+Rc9Ui1DDv+KPmvPkER6BsaOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guiq+YMQW9zP63wTODKOdPvYt/j1RTNMR9+ijDrguYY=;
 b=irrbMNs6SZOcMevRC03ITfEMDHY5wtEDezwTH/u2bHYe9yORyvDtHoiodY4ZjFyMY9VRFxSq7v55tZr1ng7i38+A8pSg+2U7W/oLPMYudiNVEBlLCxvB9jxasIH3dpS++5hC75FhfOdQj/pAhVPHa3Cun9WcRD0vtjYhSS3SrwoWX8vuBrHGMLVj6VtiA3GIobHVyGoBH4zZZ9pErtbFT8GzUZTLgksUmfRP4enRbRvqNXQsTtMIMgGchKqcZWOUR6QAVZcFK/GVr6Mn1i7sIABHTywBMICH2uY6nZLTc+zk6cPxvGR2zTFwxLsCbkrZhDVxeRnWJYh5Uz1i/T/dRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asus.com; dmarc=pass action=none header.from=asus.com;
 dkim=pass header.d=asus.com; arc=none
Received: from KL1PR0401MB6226.apcprd04.prod.outlook.com
 (2603:1096:820:c3::14) by JH0PR04MB7942.apcprd04.prod.outlook.com
 (2603:1096:990:98::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 05:09:25 +0000
Received: from KL1PR0401MB6226.apcprd04.prod.outlook.com
 ([fe80::6f00:61ff:68b6:d606]) by KL1PR0401MB6226.apcprd04.prod.outlook.com
 ([fe80::6f00:61ff:68b6:d606%4]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 05:09:25 +0000
From: =?big5?B?Q1cxIEh1YW5nKLbAp9Owtik=?= <CW1_Huang@asus.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Detect i2c in SPL for AST2600
Thread-Topic: Detect i2c in SPL for AST2600
Thread-Index: Adt+npx1h6kUaoLFTYeEHj/2Y78/ag==
Date: Fri, 14 Feb 2025 05:09:25 +0000
Message-ID: <KL1PR0401MB622605CC8322A70DD9047258AEFE2@KL1PR0401MB6226.apcprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asus.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6226:EE_|JH0PR04MB7942:EE_
x-ms-office365-filtering-correlation-id: 2a97bbde-16a8-4138-e098-08dd4cb5c044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?big5?B?UVpaZlVVWEk1Mk5yNXYybm1iY05ycmhURnZiQ1I0b3A5dnNSc0N2SmVvSDhLRUxS?=
 =?big5?B?ZEhzYm1kNnFEVUd0OEdXV2FZZlRRK0lXS0ZWTUUwN3JuMHE2ZnZUU21WRVowL1Rq?=
 =?big5?B?TTluajY4Y3NhWUxGSFQrTjloMmNlVFE2d29JZEszcnZjZFpNTk0zZjdqT0doZm10?=
 =?big5?B?NE5waCtlTFVodVdWM2RQZG5VVzF6ZXgzSFNQSXZPa05FMENSUFcwYy9IbVFIbFhZ?=
 =?big5?B?bHpsdlFrWFI5VDllVGF6aTJaUWlsWkdMUHFjakZGcUR6K0hmSTlxeVJKL1pWTXY4?=
 =?big5?B?OEk4VENTaTBiOWdCVmJ0NmIzeTlidldmajZaMmlTMjJadTNDUEtRM0pYODlJZGZa?=
 =?big5?B?aXZoa000QjZnYUdXYXM5U0c4dE9pT2Y0NmhTakRmZXByN3ZNR3Q1K2FSQmRxWnNp?=
 =?big5?B?ZzJtTGp0RXRxKzBUcDVqSExRckkyQmd2MytwdlZoeHh6Ym5IS3JIdHdOYU1WcE93?=
 =?big5?B?TXRwNHo5UkJTSDZ6V1lqWGNZN1J3Ujk4MzF2V2toYVNTeGNDNlF1K0xzOCthMGxs?=
 =?big5?B?ZjVXRUF6aFNJYTJvYVA1U3F4ZFFXT3VSelNZdFIrdkZBbGFTNHo2NElNMUIrS3RZ?=
 =?big5?B?N0Vud0lzOWlidVpSM09wdVJJN2l1elVmL1NheGFVVTc1WExxMlhBbEl2K2NTK0Z1?=
 =?big5?B?TllBQUIxMjBVRkZIdnU0Umg3NVVkY3UyS1h0Q2lGZ2tiVHc5SUJ4aUdiekxMajM2?=
 =?big5?B?S3J5QnBqVDNGRUFzSHlkS0ZZQ1d5Mm9sSEVwRk5FVmdxaExhZjZhUWNKRUM0c0Nw?=
 =?big5?B?dklwSUlkWDZzNzYyRmFCdGRyYWVGVVRSTjdXTit3cDNBK0IvR0szNXhxTE9DUFhL?=
 =?big5?B?dmE5RG1Bem9qRnhZbCtDYy9wcm1DNVV2MEx1NHJSNlo0Q1ZQVmhyRTYwem9PTmo4?=
 =?big5?B?U1hxTzBLNDVXamd6R1UzYmI4d3BqallnbCtGSXVGaGVoUWNvbGJXNzhpSW5jTlE1?=
 =?big5?B?V0NwV0d4T2tQUlZsMVIxYU84eE9SbFVUQkxBcWwrT1ZqYTFlWXpQV3pyaU4wMms4?=
 =?big5?B?dHE1MlVyVFpGNXZiVTJCU3lxSkNXZmpEeFNicUpJdmpnaFM2bVkwWDVFK0ZVRGM1?=
 =?big5?B?NHQyT2FZOHNaYlhpaVlUSENMWG01UEFwWVdTVVZrNzQ0YzN0VU1pbGY0ZnRpaktm?=
 =?big5?B?VXVyRnpSdE04aVJPSU5lVTZkRW5hejlqTlZobHRVR1lHalFKZ3grMUxzWTVReUww?=
 =?big5?B?RVFKdUdzMUdlbktEdnBmRDhjTWczOHkreWJ3SVpxNGJBanBVV292K1phN0N4dDRQ?=
 =?big5?B?a1VJS0c1eWtKNkp6dkxCOEFEZWltWHJpaS9qQU5xenRhcVF6TEx4blVPbkYxbHRV?=
 =?big5?B?ZDRFb3pQLzZndDlFR0hxbHlubXV4ZkhJWUNXZ3dEV2FHYzNjeEpma3RBb2VrZ0sx?=
 =?big5?B?dmFONW5aMUpWTkRlajFRYTYvMDRMVE85ZVN3OWZodFpsMXVFcDdMMGF0cmIvc0RK?=
 =?big5?B?ZWkvU2Z2NTBTQlBtckNBZzhyelErdU1nRHVpN3NJMk9XSE5oeWVlcTFVRnpKZkdY?=
 =?big5?B?LzY3K3pEeDZxQ09aazNYV29QTEUyQUlrRjF2WlVDYUh6d215YmJyU1I0R0tGSkNN?=
 =?big5?B?M25aODMyRXRyTW9za3RNTHRQdTljeS9NZ1B0bGpLdVRaWjY3cW0xaTQ1TkNnWWx4?=
 =?big5?B?aUNROHgwQlBybXRrcjBhS1REdG9tN3A0OEZIWkoxRE9YQjk0eGltMUZ6VjJZbTlB?=
 =?big5?B?UCtCdUZJMFEzTEc4MVMwL1dKWTUwNElua1VHajFMc0oyL2V5UFgvdUVWaktPZ3hI?=
 =?big5?B?SUJNVVNzaWRoUVdOaUVlY3Iwb0FCZE5KQllSdHZ6YlY3UFd1QkVYRXVudS9Mb3B1?=
 =?big5?Q?njWYFHzpj8KzMsFD5ArmV4dMGkGRKWIa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0401MB6226.apcprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?ZFF2MXMyQ1AvNUNTS3BIYWNUbW1aWXpYQXhTVVQvSFBsQUJsMzVGanRwa2hLc2dX?=
 =?big5?B?aytJZjkvM0xaekpRZ3psQnlJY3F6S0lHc3RZeVBOZW1PMGhXeHl1YzlFZ0tJUlND?=
 =?big5?B?UWw1T1JDZXE2M1JDOWJncERERGgycldEb2FJeitYMGpFK2t6T0dvV3V4emQxdHQ1?=
 =?big5?B?a1lwWGdaN0dJL1Uyc2RPQ0ZjYTZHRjFubE1McXhYd2RwZDBOOUdmTkpPbUM5cGh4?=
 =?big5?B?eE10akdVNWZEZmtNcFNnbzZTdkdDcVZWZHhzd3BJbmdJdFFURUR4Rmd4L1VFQTZU?=
 =?big5?B?Q2NQZStNWWRLOEhaZXZ4ZHhLdTRWQitPQjUyWEtROEVJV2NZcFRPOVJGUll5c0Zm?=
 =?big5?B?M0xyN3NpRkh6NTlJZSszM0lqUHpvaWpwcEJqb1FtT3ZzZEdzc053R05vUU14SHgv?=
 =?big5?B?cmg0SUVMak10L1IvK29QcFErQnYyTmtacFNJa0Erdmx3Q1phajZBMzBleTFFa2Rn?=
 =?big5?B?K0pVOW9zQWJad3RVdXk2UXgzNU9ES0l1TXhKbm1ZVEY0TU1wRDk0elplTXhXQUxn?=
 =?big5?B?elVCMmVtYWwwYzNjdFhhODc2ZzF0ODRBbTZTV0YyUXVPazRBS2ZWWXdPNk1JQXJM?=
 =?big5?B?bkZEdllla054TlpTTm9sWVZ0TnU3em82SU9JVTRyUnUrT2VsdERlaERkWWxCM21B?=
 =?big5?B?cldUUFNkNXFlVUNtM1NDTnNmbWQ5K09nQzRhWXE1L251VmpNQWt0Z3J0Y0o1TVJT?=
 =?big5?B?M0orS0t1Uml4ME80YkdFVXlJdXBoNEplUFpRZ0xUVEN0U1BjcWNBSEVXMzJjUE5w?=
 =?big5?B?RFIyU0NLcHFIWm12WnMwWnA4eFlJZmwyY3FhOUZFdzJZT2MyVmdBcHJCdm9TZ25W?=
 =?big5?B?by81bEd5VGx0MG0rOTJkSXZ1d2tRRm5GdmRlTVc1Z245b0lWV1RqbzFFUWhrUXkr?=
 =?big5?B?cFlDMmYrRTE5dXdWYXFZWmgvV20vaXU1WmQyQWY0dXZyMDdzZFhtcE9SLzN4ckk4?=
 =?big5?B?MkhHVEdaaG82S0NiWElzazI5NnBtaTYxSXFmeEhMZ3JMOG9iWlFoS25FQjJ4emRq?=
 =?big5?B?akJGMWtOek5peHZyT3VMbUYrdlM4TUNFRGp0R2dxNENTRzRjdnA5a1JROGhyV3VJ?=
 =?big5?B?bmV5dzYvZFd3YXZUazVMOU0zY2dSYzlqUVdnM3U1c3EvRWhtT05sTlpZVkExTXFy?=
 =?big5?B?ZFhjR2ErNy9FV0RuM0p2T1BrS2hpYkNlVU1DeUhBTm1IemxGRGtqZWFiR0t2V0JB?=
 =?big5?B?SFR2ZmZZcmY5QWlnRkpQNU1VYmZJY09xdDlUVFFoRmIrcWUxWitENCt5a21WT3Rm?=
 =?big5?B?UUtaMzRCbVZKckl1eXp4d01FNFdnS1I5SkRIVjNwOVpTQkNTK0txUStSSmQrRm1p?=
 =?big5?B?VTd3WjU1emFHOTkrejhuMkRVYm55bU5IQ1NadExKcytuQmlmNDNFRjhXakI3UWNL?=
 =?big5?B?c1RDTHZrcXkyWDA2Z294TTQySUpJREZJbXhHWEdOUUViMUtsOGJMZE9QSTU3cDYr?=
 =?big5?B?dlJVcDZLWGMrbGljNDBvVWplRDE3aXlZRHhjOWFoZ1hNaG5PdUFjZ01CVktrcHFU?=
 =?big5?B?UzU5clNjQy9wN0svU2Q4NEJUajB3WENGN0JBRHJLdVhKNm4rdTNSWXVwVjdEdDBN?=
 =?big5?B?aXpsUXVuL2NxL2IvNTdJMm01TEozUWsvVTRON0htOFBIRU5pa1hIU1hKdndMaWJK?=
 =?big5?B?eldOd0h6VCtkTDJmaDZoUno5b0ZGb0w3cm91N0ZOVFo4ZE5HRHVGai9LSlg1MWtT?=
 =?big5?B?TlZicEdZSVVaREVtNlhlYU5WcEVVakgxUjRTUysyeXFhZFIxYWJEbFlyNXNMNzM0?=
 =?big5?B?VkIyWU9seVJxYU5iUDBUdnkzWjVhUzMzZ21ST2t3aWRYMmFvWTBaUk1DSDYxc1Mx?=
 =?big5?B?R1ZoUHhOcmdtMkYyUENzdW0vclhhemJsZXI2MHh1cnIyM096Y2sra1BDQWRGRG5I?=
 =?big5?B?TEhScVJmcy9nZElrN25lR2NmaXQ1d1lQUVFUUHNISFZ0S1VWYy9SQlZvaVFDaWFm?=
 =?big5?B?TjdOVkJ3Y2Y2djhGM1VnaXZQdTh5SVk4d0tucDFkcWRsRER4SmlKNXF3MWVacjJC?=
 =?big5?Q?gtTR3ab56K1sLoyh?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6226.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a97bbde-16a8-4138-e098-08dd4cb5c044
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 05:09:25.4908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 301f59c4-c269-4a66-8a8c-f5daab211fa3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRbYUU01xwo38AoTUMzXte9Q9+GYTMZkTtm2uSZIPZWpTtH/9XtOaYfLyu8LUquT6mNTRFuALbTrklcnKa3Zug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7942
X-OriginatorOrg: ASUS.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3223-9.1.2019-28984.000
X-TM-AS-Result: No-10--17.413700-5.000000
X-TMASE-MatchedRID: cnNFLnOjrwrbI75QqKBzn7v8GRKsaHWW10/soz7yB7ETY0zjFwIdiUHx
 pw3DU//lC50TUxe4kal3Pe/IDoH/6raYr0G93ltgbAQSvnY/AMUVN6IbBsyn7tVwVFL7iTibMix
 cDcA5+wMm0fyVhL8kjTx6MvvsQuGNdVKrPvD2PqWqKNNwUAZ6j1XStJ6kHdl4YJZuQSwbzfsDO5
 AtH6g/xepJW5jv3BIHYQvXp5XNRwMvrpaKdc7Wsd76Dvdp9ywqKxle9wLFNGcXCvA6AeRIBSIml
 xLikNASSS6R1kWz2OIizTKE93bAuZ6MEx77sAxoYTsQp+n72Dop6rtItBU/Pv7WVKs2KNffFqsn
 fH9BUv/fLFOLMNS8oMw9CctMzTFAVXS3CAt+DxgarEv/I2gPyo19zNGhZoVDKE9xSWok0twM/GH
 OyvHMelztcpjTSbU47lupSRApbpbocuK7+JBlJN0tuih3oUP1UJ3TeO5mdVdtx0FffBeY/p8hf/
 TuKlSaKYmnFIK41mQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.413700-5.000000
X-TMASE-Version: SMEX-14.0.0.3223-9.1.2019-28984.000
X-TM-SNTS-SMTP: 4BFE46E6567F40A10EC02453FAF464DBC7AE884C4FFEBE6B3C7F9E9E57F76F1E2000:8
X-Mailman-Approved-At: Fri, 14 Feb 2025 06:45:06 +0100
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGVsbG8gZGV2cywNCkmhpm0gd29ya2luZyBvbiBhIEJNQyBzeXN0ZW0gdXNpbmcgQVNQRUVEIEFT
VDI2MDAuDQpXZSBnb3QgdGhlIHUtYm9vdCAyMDE5LjA0IGNvZGUgZnJvbSBCTUMgcHJvdmlkZXIg
KEFNSSkuDQpJoaZtIHRyeWluZyB0byBlbmFibGUgbXVsdGlkdGIgdG8gc3VwcG9ydCBkaWZmZXJl
bnQgU0tVcyBvZg0Kb3VyIGJvYXJkcy4gVGhlIHBsYW4gaXMgdG8gZGV0ZWN0IHRoZSBib2FyZCBp
ZCB2aWEgaTJjIHNvIHRoYXQNCndlIGNhbiBsb2FkIHRoZSBjb3JyZXNwb25kaW5nIERUQi4NCg0K
SaGmdmUgcmVhZCBSRUFETUUubXVsdGktZHRiLWZpdCBhbmQgZW5hYmxlZCB0aGVzZSBjb25maWdz
Og0KQ09ORklHX0RUQl9SRVNFTEVDVD15DQpDT05GSUdfTVVMVElfRFRCX0ZJVD15DQpDT05GSUdf
T0ZfTElCRkRUX09WRVJMQVk9eQ0KQ09ORklHX09GX0xJU1Q9ImFzdDI2MDAtYm9hcmQxIGFzdDI2
MDAtYm9hcmQyIg0KDQpUaGVuIGFkZCBib2FyZF9maXRfY29uZmlnX25hbWVfbWF0Y2ggbGlrZQ0K
I2lmZGVmIENPTkZJR19NVUxUSV9EVEJfRklUDQppbnQgYm9hcmRfZml0X2NvbmZpZ19uYW1lX21h
dGNoKGNvbnN0IGNoYXIgKm5hbWUpDQp7DQogICAgc3RydWN0IHVkZXZpY2UgKmJ1cywgKmRldjsN
CiAgICBpbnQgcmV0ID0gdWNsYXNzX2dldF9kZXZpY2VfYnlfc2VxKFVDTEFTU19JMkMsIDIsICZi
dXMpOw0KICAgIGlmIChyZXQpIHsNCiAgICAgICAgcHJpbnRmKCJDYW6hpnQgYWNjZXNzIEkyQzI6
ICVkXG4iLCByZXQpOw0KICAgICAgICByZXR1cm4gcmV0Ow0KICAgIH0NCg0KICAgIHJldCA9IGRt
X2kyY19wcm9iZShidXMsIDB4RTgsIDAsICZkZXYpOw0KICAgIGlmIChyZXQpIHsNCiAgICAgICAg
cHJpbnRmKCJDYW6hpnQgZGV0ZWN0IGlkOiAlZFxuIiwgcmV0KTsNCiAgICAgICAgcmV0dXJuIHJl
dDsNCiAgICB9DQogICBpZiAoc3RyY21wKG5hbWUsICJhc3QyNjAwLWJvYXJkMSIpDQogICAgICAg
IHJldHVybiAtMTsNCiAgIHJldHVybiAwOw0KfQ0KI2VuZGlmDQoNCkhvd2V2ZXIsIGl0IGRvZXNu
oaZ0IHdvcmsgYXMgZXhwZWN0ZWQuDQp1Y2xhc3NfZ2V0X2RldmljZV9ieV9zZXEgZmFpbGVkIHdp
dGggZXJybm8gLTE5IChObyBzdWNoIGRldmljZSkuDQoNCkFmdGVyIGZ1cnRoZXIgc3R1ZHkgSSBn
dWVzcyBJIGhhdmUgdG8gZW5hYmxlIEkyQyBpbiBTUEwuDQpTbyBJIGFkZGVkIHRoZXNlIGNvbmZp
Z3M6DQoNCkNPTkZJR19TUExfSTJDX1NVUFBPUlQ9eQ0KQ09ORklHX1NQTF9CT0FSRF9JTklUPXkN
Cg0KQWRkIHNwbF9ib2FyZF9pbml0IGxpa2U6DQojaWZkZWYgQ09ORklHX1NQTF9CT0FSRF9JTklU
DQp2b2lkIHNwbF9ib2FyZF9pbml0KHZvaWQpDQp7DQogICAgc3RydWN0IHVkZXZpY2UgKmJ1cywg
KmRldjsNCiAgICBpbnQgcmV0ID0gdWNsYXNzX2dldF9kZXZpY2VfYnlfc2VxKFVDTEFTU19JMkMs
IDIsICZidXMpOw0KICAgIGlmIChyZXQpIHsNCiAgICAgICAgcHJpbnRmKCJDYW6hpnQgYWNjZXNz
IEkyQzI6ICVkXG4iLCByZXQpOw0KICAgIH0NCg0KICAgIHJldCA9IGRtX2kyY19wcm9iZShidXMs
IDB4RTgsIDAsICZkZXYpOw0KICAgIGlmIChyZXQpIHsNCiAgICAgICAgcHJpbnRmKCJDYW6hpnQg
ZGV0ZWN0IGlkOiAlZFxuIiwgcmV0KTsNCiAgICB9DQp9DQojZW5kaWYNCg0KSSBhbHNvIGFkZGVk
IHRoZXNlIHRvIERUUzoNCg0KJnBpbmN0cmxfaTJjM19kZWZhdWx0IHsNCiAgICAgICAgdS1ib290
LGRtLXNwbDsNCn07DQoNCiZpMmMyIHsNCiAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KICAgICAg
ICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0
cmxfaTJjM19kZWZhdWx0PjsNCiAgICAgICAgdS1ib290LGRtLXNwbDsNCn07DQoNCkhvd2V2ZXIs
IGl0IHN0aWxsIGRvZXNuoaZ0IHdvcmsuDQpJIGhhdmUgbm8gaWRlYSBob3cgdG8gZ28gZnVydGhl
ci4NCg0KUGxlYXNlIGdpdmUgbWUgc29tZSBzdWdnZXN0aW9ucy4NCk9yIGlzIGl0IHNpbXBseSBp
bXBvc3NpYmxlIHRvIGRvIHRoYXQ/DQoNCkJlc3QgUmVnYXJkcywNCkNoaWgtV2VpDQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KVGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIHRvIGl0IGNvbnRhaW4g
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBhcmUgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUg
dXNlIG9mIHRoZSBpbmRpdmlkdWFsIHRvIHdob20gaXQgaXMgYWRkcmVzc2VkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9yIHJlY2VpdmUgaXQgYWNjaWRlbnRhbGx5LCBw
bGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgZS1tYWlsIGFuZCBkZWxldGUg
dGhlIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBmcm9tIHlvdXIgY29tcHV0ZXIgc3lzdGVt
LCBhbmQgZGVzdHJveSBhbGwgaGFyZCBjb3BpZXMuIFBsZWFzZSBiZSBhZHZpc2VkIHRoYXQgYW55
IHVuYXV0aG9yaXplZCBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmlidXRpb24gb3IgYW55IGFj
dGlvbiB0YWtlbiBvciBvbWl0dGVkIGluIHJlbGlhbmNlIG9uIHRoaXMsIGlzIGlsbGVnYWwgYW5k
IHByb2hpYml0ZWQuIEFueSB2aWV3cyBvciBvcGluaW9ucyBleHByZXNzZWQgYXJlIHNvbGVseSB0
aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBkbyBub3QgcmVwcmVzZW50IHRob3NlIG9mIEFTVVNUZUsu
DQoNCkZvciBwcmljaW5nIGluZm9ybWF0aW9uLCBBU1VTIGlzIG9ubHkgZW50aXRsZWQgdG8gc2V0
IGEgcmVjb21tZW5kYXRpb24gcmVzYWxlIHByaWNlLiBBbGwgY3VzdG9tZXJzIGFyZSBmcmVlIHRv
IHNldCB0aGVpciBvd24gcHJpY2UgYXMgdGhleSB3aXNoLg0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg==
