Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCBACA5FB8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 17:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA8483A2B;
	Tue, 20 Jan 2026 18:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="KRK4c2Tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4862580B98; Tue, 20 Jan 2026 18:40:04 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF33480B98
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 18:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pjs1RWLZAWXtc+1lEjItdsKTyWNf65JPZXzAp9KnEmvO/fjDT/IDgjBIZ83XKhpfR2ibrg0PUIm+KLR4CIeTx47BSLA4Msii+B9wVnuMXppkH1NJhfU9hQa2JjsBFyXwUjTIdhTebIb/JlQulZPgNfYXLaYddH9OvLD08HKClHiWz+VaypNkFg+FNQtaorLhyTL6mFKpVPwVlJ3VdfcYfGgr9iAvQyueyj9ajlrh/Y9W7ZNx0aSJ4ycPoO1gtEARAjD1RCqlS/S1M24xIBlFWWwfTW9hayKRqEOOJEVOpMNit+8P711csl9vCfH+xlC9MEYaE9Xjij8oEA+AgNLePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKsZpr+G+0uRPF8FsWnxAr55SnhpqHgG9us8O5UTxQU=;
 b=koZsI08lf7UW1d48cfq8qjBBQq3TdEAFAb+ke2iILI2jY2QMUJuGMo1M5DsN+k6Y/0rUdbzcn8u+1CndGycs4jeQX0I3vLVzN+t53UFCCSDTJabOmE7QzOZ+eFyZgIFqZiUBMfWzOQtzncRKH4XgkBEPJrPh1n6aDVlJ34pvH1xs5lAFWecL4/RnZXyuvrsXnbkpuEomd+Eckp8IzVVvngyfvFpPZ+3bNlGPhHMy/7sjIOOh0rQy9f3QNa4FqBShoTUv2gwUpkKDqd2utfEEzA4UagciV941x39JQ+MJMoOLLpC0pfsPFuYjFDAtCLhgvs82ACQuVtqgkZFuiYasEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKsZpr+G+0uRPF8FsWnxAr55SnhpqHgG9us8O5UTxQU=;
 b=KRK4c2Tvx2J2GWcw6yER613NE/c9ybB1B3lYnjghunLExXChI+CnzE7Sd5KIQG1WkO3tS6xY/9aKi/UiODnIn6TEecVffTQSj7PTnYWwa3YOjfMAVVV/HAoEanefpic07u0AOE9P8hQUKhgKGRxa3rMyvknugrj0ZwF+xyJmW88QwYV5CtzO/Oq8Byx+GCjGoRruQNi4yNi+pyvsJEbJ+7hZNInFgnS0B8qGsu0Kz9ObzLFldgEaYN8HKVLY3drC7WfwnW9/E8sPGDzKs+TSY1kY2ikw0mI3X43dPBY/PWp1GCrsmp7A8VdXzFsypcPhKhswwFhAJ0rF4mA0iz/PDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:39:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:39:50 +0000
Message-ID: <5c6c0fbc-4560-4a88-b52d-97c66341ed30@siemens.com>
Date: Tue, 20 Jan 2026 18:39:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL
 to support MBR
To: Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
Cc: eballetb@redhat.com, alexl@redhat.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maks Mishin <maks.mishinfz@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-5-javierm@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260120133630.1695055-5-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 201607f9-5616-44ee-5b5c-08de584ae9cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWJxWU5UK2M3L0tUS1lrSmpFdSswZWVkRUpDYnpmRTBVWCs3bmE4bmxUeXls?=
 =?utf-8?B?REpEMDBtZGZ4VEROZTNGMHl0bm94ZVpPUG1iNGlpZG9zTUhnRCtUWnZpVUtP?=
 =?utf-8?B?cWV1bG1ITW1sTzIyN0pkcW9maVlQNGpXc3c0eXNoTE1TR2ZuQTN6UEhzRHdI?=
 =?utf-8?B?cHEydnZsTklLWkJ6Znp0RTRzRzVGSTBJNkhQR0JkeEo2YkM0MmUyUE9DaWgw?=
 =?utf-8?B?WXR4RHN6ZC9LOUI0N01GR0dlRkZINUJQMFVQVWlXbk9pc2xmdzFxQmFndHBC?=
 =?utf-8?B?TFAvYkVRcit2VGlvUXRxMjlxVVE2c0dJY0pEbmdSNDRXdmt1ck52djJ5eDR6?=
 =?utf-8?B?OFdkM2NhRkg5Zk92THNMbTgvOU1hSTRKOTJvQkM0RE85eTVaT2JoSlREdFFZ?=
 =?utf-8?B?d01XdE96NzMwMWZDQVM4MklvNS83bDVDWXdPN3E4Zmk5TlE2bk1ackV6aEwy?=
 =?utf-8?B?cnp5dnFzYlNEUTdMc2R4ano0N0Z3YmFEQytCdmVNR2dvdmNhdmxGdWt1RnRk?=
 =?utf-8?B?bmNtNDlGZkdqU2lHSDdjMUlrNEF2bjlDTldVT0xtNTEvNEk1dHVuN29uckxt?=
 =?utf-8?B?QzJiN0tpMDQ3OUFFQ2d0RFVYSUtacmxveEx5Q3RUSCtqSjlTZ0VyN1h4bith?=
 =?utf-8?B?UHd2SWZrRGpNenFkbzV6NjJDcnozNWVnRjZweTRBVEpEN0diUFkwU0c4RmdL?=
 =?utf-8?B?enFVVjMyRXdFZm82VVlNL3FZbWlpd1Q1b0N5UXFkaXkwbFg3TGo4WVZWaUVq?=
 =?utf-8?B?TmRwMmRDOCtmeU5ncFdiaUNwLzFNczZwSlNHTnRsVTFiSm52OFFFM3drS2xG?=
 =?utf-8?B?YmNWWmQvSU1GU3IyRHJRdUlpVUF4ZHNYNHhwcjdDVUVOL2t5RHBHVXdGdzFX?=
 =?utf-8?B?UDY5VjZQaXo4S25UWTkwY1J6WEtRVWd1dVpYdUQyMnhoQ2kwczlYNE9vSGVw?=
 =?utf-8?B?eWpDNFZlUFRiRFBkOExuOVBZREFzWW5DR3NjQ05va3NabklGQUdodkFRMnpU?=
 =?utf-8?B?Sy9xMy8vRjZsbGozN3E2emZmV2VoSEdReFB2dmJyMjJ4RVRvbmlndUExcStl?=
 =?utf-8?B?MzlWTldvMWRFdFJnQURzSjBuSnI3elFnUmtpdG9PWkYrWUZwZjBYNjZrMTRZ?=
 =?utf-8?B?SkdydGtrSG9qU0tQMnBwbUNaL29GMEJKV3Y5cXY2MlpYMDNRQ3dVZGNsZDdS?=
 =?utf-8?B?bjVyT1JGWCtqTzl6amZxcUlZakRwdDkvaWNRclZoWnk5Zys2RjFFMWhVYits?=
 =?utf-8?B?cm5ibm5lTHJYcENVK2czNk0xMEZHSVYxdTBEU3JDK1JsTUl6a1E4eXlaWEd3?=
 =?utf-8?B?VXowS2RZUXBOR0ZlQ3pSTFhkRzhHT3lvd0dJazJ4N2x3a0VxVi9CWEIzUkt5?=
 =?utf-8?B?TlpJUmIzZTNqelU4RDVGMG9zVkRyNkx4Vm1zMDRkRGRKYlMrN2Zuby9WSElq?=
 =?utf-8?B?RU16S3ZHL3lHVUM0QVdHLzQ0Zmt3TC9Ja2FWMGU3NWVMdWZ3dE40VGtCN2hY?=
 =?utf-8?B?ektXRklJOGVEbW9mN3FLd0FyTWhHVjZVUk02dW5oenF4ZW5DQXFwK3VOMTQ5?=
 =?utf-8?B?QzdIUTZWK09SSDNHenUvVCtGeG9SZVJXSDdhcjkyMlZLSEhUU1F0Y1RTbWNH?=
 =?utf-8?B?R3ZXM3dCZVRKNlpDU0ltMnJqcXhRWEpZZWVuVXdQQ0tjbGlTaHRMUHo0bDln?=
 =?utf-8?B?TnJwSncwTTZUazJaQUkyMUZQYUVXUTJ1ZE81OGJBRm02MWQzUWpXRUFVWW55?=
 =?utf-8?B?bUM3WHJZZTFCVVJmRStWaTQ2aXpwbUdaVnl1NGRBQ2RCSXNFcGNnT3FoMTh1?=
 =?utf-8?B?Z1FDb3JVQVl5Z1N3WjUxQnRKUlBTOHpxOElqZjhZTFR4aCtRbkZjTS9tNmow?=
 =?utf-8?B?SDFLVHFGWWN0ckkzS0hkWnlIYmQ2Vk8yTnlsZ1Ivem4rNFNtRlBYaW94WldR?=
 =?utf-8?B?WkZPNzFDanJkVzFtY3hLZ1VMTTgvWFdld2tRbWlLUXI0WWZnbmpFR0V0WGNn?=
 =?utf-8?B?eVQyVHRVcm5tTTVzNEMrRjJuck40NmxZWXhmaFFpV0w3dmlrenQ1b241Ly9q?=
 =?utf-8?B?a3lxczFMam1tdFdmVHlYVXJ4ekpacmQyVGYxdnI5azFTL3d2dWhWY09OQVRK?=
 =?utf-8?Q?rhP4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzBXemtLL0xVUnpubVJDZ25ZQ1V3NDcrN0MrWHhpQzhETjlvTU4vbTYyRTR6?=
 =?utf-8?B?YTYwekRTSTRvQmE1SDcxVTRtTHhqWkR3ekdmaVMzeTNYTXJXOWR5ZmEzTFpy?=
 =?utf-8?B?SGpWU0M3Sk1EVWo5U3pxQWxaYng1ekNCY0pxTDZQYnA3VWp6Y2FwZzVIMGVK?=
 =?utf-8?B?MW1qd2lySThxUHMvVGY1TVlhK3VWSko4bndIME9WV0VISDFLaGM0aUVXbDNa?=
 =?utf-8?B?SXVJdzFuQTFncS94WW1tdktLaXBySnNQRXJTYW85bTJXM2xXWFBIdzBvWERN?=
 =?utf-8?B?elJ3WG1MMStVNXNGWUdEWWpJYytxOEcySXdpcmxJTkQxZHd3RlZva3BvOGlM?=
 =?utf-8?B?MW1RTEhxVjVkall6c1ZuMGNZUm1nLzcvaExMTHlpZXkvNzlYcS9qckR2c1Nx?=
 =?utf-8?B?dzdLSmJBbU1TWlpqdHdPOW45aHgwM1BFMjloWDRwQlRtOGwvdDl2OTB6NEdG?=
 =?utf-8?B?YVYzdVpycXJUbE50Y0hnQ20ySGxiY014Z2s4NXhlTjhvbHQyckdQVExDU0N0?=
 =?utf-8?B?eUNOc0NKOE5RLzFxNG5GbTltajgzU2lwMWRkUG1Uak1BaDVoei9sS1NySzRy?=
 =?utf-8?B?UnJTUHRCSkx0YkpzcnYwVXNKRnBKY0FyUjBxaXZZK2w3cXR3L3d5aDBLaXd5?=
 =?utf-8?B?NjZhNFkwL1hXQWphK0NXT0ZCdzV6aFlRcC9rYXJyWGZIWXRpbkhHUlN2RzRG?=
 =?utf-8?B?RkNGNGF0TGZtcys2bVBBNXYvVVpRdVIrTEs5QXYxY2lsTG1vaWdWeVRlOW5y?=
 =?utf-8?B?S1duMzBQRmNFdEpWNVZpdTV3NU8vcnFESUpHSTNDNHNvUFJOaGRqRWdNZFpn?=
 =?utf-8?B?aTBMeUZMOWRTMVhFTUxlZmJhSHg4OVZkZUpHaitKUVBpQnR1dHlyY0FVOXNM?=
 =?utf-8?B?VG1ITnNzMk4welhKUnlOWm5hTHpRQ2thZi9nOXhRWTRiZVl4Zk5neGhWcU80?=
 =?utf-8?B?RVI5NVE4QkJwcGJISzZTeHZ3aC8rcHB1V3luazIwL05aRlRZaGVYRFVZZDcr?=
 =?utf-8?B?c1dHakRBeDh6UGtzV1BzSXY2cXRRanBxa1htc0Fnb29va3VrTm9xckFsd1NE?=
 =?utf-8?B?V3dyS29WWEF4NElaU3ZWSmMvRy91RDcwRk8xN1l3THVWUVJYenJDYTdENVdT?=
 =?utf-8?B?QlM0WmFCMW5uRUkxbXJqeHFBbHNsQTFQMmQxa1lEODNBQWlQS0hFa1JRQkN3?=
 =?utf-8?B?bWV5N2JSQ1d5UXU1cys5bVJrSGtVZTdPTmFkdGtSd3lXSWtLVm44bjdGTEtx?=
 =?utf-8?B?UG9PRnRNcHhzUTRkN2ZuNmRCazJ1RnJaUGNoQkN0cGc1Y1VpcWNtWkE0Vk1k?=
 =?utf-8?B?WTBKMnRDMlV6UTVsVzhUdFpmZVFnQy9ob0c1UHpqdVlSRmkrV1RQZkxvenly?=
 =?utf-8?B?K2FrOFV4dEdUYmtXNVBrdEpzK094R3k0RXgzQWVocEFXdnk1dElBUXBObWFC?=
 =?utf-8?B?cGI2eHlJWUw3YSthV3IvVS9BS2UxeEMwRlZheU9YeXlrbCtpV0VrQ0Y0MXFI?=
 =?utf-8?B?T2QzbGtJcDJwQ1pLWEdpaFFSMlllWFlpa2dvUlZKa0JyWCtFaVJLRjRmY25R?=
 =?utf-8?B?bkFFd3lXUTBNYzBxTzNpbmhSRnYwTzBkTVFia0pZUjlGRUgyczRNbUpFYlp1?=
 =?utf-8?B?SGVzVjNHUExhWFBLVGFmQ0Jya1F0OEYzRHpUZjIzUW9JS05BNFJLeWlOdWFu?=
 =?utf-8?B?NUJteTF3ZmdKUFpGbmdxTTZ5cThBUlJkalkzNUJkUlpQQjZBbjVUZnBHcnVw?=
 =?utf-8?B?QVVVSWx3a1A5eVBGZ2ROcXVrejlBRTN1VWxITlU4UzFLWGlmZmZYK1NFc25Y?=
 =?utf-8?B?S2s4alU1MktJV2pESit4UVVqbHJQbUlPaGxacURNeGdyVkk2TWhyR1FvVGV0?=
 =?utf-8?B?akxtMGxxNXl0QWViM3hYYnpxOStUT28yM3psdFNTdmdTV1JxMUJSUU5VVDhN?=
 =?utf-8?B?ZW9IaTk2WXY3UDFJSEVNUk5WUjZuekhqc29Ga3FmWGJXTiswakNFQWZiYUlR?=
 =?utf-8?B?QUhrbkc4S2d0RHF6NDE3T3ZNcTR1ZzFxQzliSWI4TmVjcmtqaUc1K21zNkJu?=
 =?utf-8?B?dXZwdjg1Vkl0YnNRdDMvTEV6WHlwb1RDTHNidHlleCtnYkRWR0E5VTJRSDMy?=
 =?utf-8?B?cnlBYnRSYnN6eUV0ME5RWjAvY2lkQm1hWFJRVTRMcGZhMm5LL1I3SVpMaWMy?=
 =?utf-8?B?MjR6cUtqWmVpRDFjVFM1ZEVwaGNMMmErcHltczV5L2ZSdEpNRUh3Mitxdkgx?=
 =?utf-8?B?Q2VSVjE0QU5SL3htb0FuN1ZiMENuekVCV1c3dnF2eVF4ZE5GTnpmT3dSSjJ0?=
 =?utf-8?B?aWd5TGV2L3BlejBwVEQrNHB0NlFUSWt4NzFVM0xhZ1pjWUdoZDdLM0V1VkNS?=
 =?utf-8?Q?V0Qf/MVcxxjmPUQQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201607f9-5616-44ee-5b5c-08de584ae9cc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:39:50.7626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkQ2C6FpCHMAbqCEq24JMVlLsM4DPBpvJAt9MTbppQ4ByPMG789A315CLzwgs/rwijZqOPKr2t1eOQlttDqDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7783
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

On 20.01.26 14:36, Javier Martinez Canillas wrote:
> The EFI_PARTITION_INFO_PROTOCOL provides detailed information about
> partitions. The UEFI specification mentions that both GPT and MBR
> partition schemes are supported, but the U-Boot implementation only
> supports the former.
> 
> This can cause compatibility issues for platforms whose boot ROM only
> supports MBR. This change adds support for MBR partition tables to
> the protocol, making U-Boot compatible with systems that require a
> legacy MBR table.

Normally, this is simple to address via hybrid partition tables. I've
done that already for two different SoCs (TI AM62 and Altera Cyclone V),
and this allows to use all the nifty features of the modern GPT without
upsetting the ROM loaders. Do you have a SoC where this does not work?

That said, adding this feature may still be valuable.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
