Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB58D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED0F83B30;
	Mon,  1 Dec 2025 12:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="jWrXSN7+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A1D83B5B; Mon,  1 Dec 2025 12:11:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B9883A98
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpyiXEpfLyqn8RKXEoZZ+B3YHJwgqmcFqx+WAXysscmtURjKSx7muNoPpP2CGis9MO6iRnsZ0x0RpDfu94HnKOUEypEhPFsfIpGOIwXh2IfQOysg1QtAUAvnc4gz64bjk8msf08e5PjrY4gr8gkOjqacVS1rd7A6jcJr97c44wftfRS6LWr6cQKUHrxmIzsw0Cc9v6zQcM0X6mXUzUDgKCDKXUH5dsNodtHlQx9EW/quCLfmOHfpWAHWf4TO9lg/nLEJI1dmtt59zbQhR294UYq4bGRWP1RhPzWbSbLoOMXSQNkAkkmLjGpl6/kV+79ju46QdB+u26gs+ac3uaqDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gifXmlucMEbrByxHOonkWBRV+BtKpmoXVVwPfKr+CpA=;
 b=Jh53X5M55YdjwJCLRunzkAoJDLCcL3DWpixRivWmOw2xR6ICT+FmtdyhFhnlAHpYsWF37GuORQ4RNXyhJL5jeJNfrRI9/jvKBMT89dsxRdDYCgMB5g2cONqCM4705Tz2Jfj7A2HT+QR06ImBdxKkW9FG5cYVGrCa5b2tgz4dPZwkVh4tkhiiDKm9EEJayJemqcxN1uyBP4c3VIu/Br8Wna6R0RYKW4BXRptHpTX6MdJafhME/HC/D1XCEKgPrQYV71MHo+wYxuboEH1zyGyPS3J5kcJRAJCAIPHGfUyqVEywRMwlVRRtUpQmwnVxTBZVjVqVCI0Q0dk/Tcv8mk1/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gifXmlucMEbrByxHOonkWBRV+BtKpmoXVVwPfKr+CpA=;
 b=jWrXSN7+VrG+Y48GtCd0ilgH6DglA7h2A/fuvR3pCQ+fqkBOwsd65wU2C2yo1ZdM35UCH+/k01+VhKY/jeX+iDp2DZbX0imRYbFd29awV2ZzIucEv4FuEo9nSOW9us3iTirl+Atx01mLOD5dd5XvhyAUqQdIuIwxgxm/N40iIr6Ul3f7MsJR3d0OBH67Z/XrwbMjR9TCEHGOrjjsGbB0fiawtedthSN9JLPig5pVjt6Tg4g2VXrr0Xu5rlpWFV4KkUhKxajDDQHWuz7/Md43Z3t+asHqD0o2exyfBD/E7i5jjA5Wgg27nIiqCWG2YNKEoJbfoBy7BO/JV7uFlps61Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:11:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:11:28 +0000
Message-ID: <7c81f621-3d13-4371-b9eb-2cda572f0a69@siemens.com>
Date: Mon, 1 Dec 2025 12:11:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: mach-socfpga: Fix non-Agilex targets
To: "Chee, Tien Fong" <tienfong.chee@altera.com>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sune Brian <briansune@gmail.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
References: <99585fee-dd5d-4f9f-aa88-0ee34fe02181@siemens.com>
 <3682cf96-0cca-45ce-92ae-9fc33345e3ee@altera.com>
 <f9f6a5e1-266f-4814-9fef-fe39782a36f7@siemens.com>
 <bf5ba5b6-e012-46cc-86de-805505c6bf34@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bf5ba5b6-e012-46cc-86de-805505c6bf34@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 27227ba8-b63e-47d2-0b22-08de30ca5faa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDloMWJFQzVUblQ4U21mQWhmNVE2SWhPdlB4UXVkaFlHZWg2ZEx2b011T010?=
 =?utf-8?B?ZERlUWVjM3JkS2ozR21hQTFFM0g1THhXVW4vRHYwMHFjYmhsbTJST01NcWRI?=
 =?utf-8?B?ZTA1bDh2NTRGYnE5ZzFadUVxWUUvVzYvZkFYMVRFdm5ObWo1bVdvTFE5akpv?=
 =?utf-8?B?RVFrY3RvVWNTWWJQclZoMHduaEs4S3dNNmtqaUl6aWhxbkdVc1hNbFpvVkxa?=
 =?utf-8?B?eUh2UCtmanRLcGN3QWlvWUgxbm9CMmo5enAyaWxUV2szUUdTd0FWbUxsMW1H?=
 =?utf-8?B?eDVDUEZHTFdkOEw4MW4zMnIwUURndkhDQlA2b2MxYW1BdlU1SWlGYkJFaFZQ?=
 =?utf-8?B?QUpDNVU0VC9XNVdZOGFQbkdNM0R0ZWpPZWRnZEpYdkRLRU4xdnlsdnRvbGRu?=
 =?utf-8?B?b3VTWDE3cVNKdU9GSFEyZHVQWUc5S2lMUE10bmtxK1R6eVhnYUJPQ29JL3pu?=
 =?utf-8?B?ZDhUQ3d4ck9EL1piakw3ZW05VDdhZ2RRSzlSemRocHZvM3RmWURUbnJvU0U3?=
 =?utf-8?B?Wm1qQjErY1hsSHdKZURNTTV5aW8xaTN2cjFYbkVHRitpTTFaN1VKYWhZSDB0?=
 =?utf-8?B?VHd4UEVGSTNZMVVrWFE0cGJPeERKTmhUUk0wdFdUcXNjRTQ5b0Z2d3pVZEhm?=
 =?utf-8?B?Um1USmpUVHFmZE0xNjdUOHVIZzdwYzFLRC9seWZSS21YVm9aaGttYVRBZUd1?=
 =?utf-8?B?Nmt2MWNDWXJoZkpFRUNRM0JKaGpRZ3JWRnhTM0d1WU54dkdNTGtraE1rK2N0?=
 =?utf-8?B?b2dCTlpXRXNiNElBVE5OUGFReXZ3eE92UUdxTUhoaVZJV2pOaVRkK05Nc016?=
 =?utf-8?B?V1MzMW1vTStqUFlBbVl5aTNmUEh0OVZ5RUxQYVVreGJCS2hlVkVJUllpZm1o?=
 =?utf-8?B?K05RTXdJdW5KdEdscUJmYUxJNy9RU2xHcUV1S0NsODJ3MEQxd2kzY05QYXBk?=
 =?utf-8?B?U09sMzdjSFNsbTdqSDloamdBMnM5bU5GM2pCTCtTQmpIbWtjdWQ3dmcwcVZT?=
 =?utf-8?B?MnlqNFAvV1VCVFIydnlQOTBvNndBbGkxeW00QzlnZHdmU1RWUzRHMUxianh5?=
 =?utf-8?B?aEtUcGNUMStvaTFPaHhYanRZN0t1N2NJdDc3ZDd5ZFNHWGJvbDN0aGh4dXRU?=
 =?utf-8?B?RnF2V1Bza1JJQVJOSzROSWN3Skk4ejRaZDFwdVRyU1ZKd01qNk9RVXlqUmh4?=
 =?utf-8?B?Y1ZJdFc0WWkxL3U5TGdwU09aTmlQdUVaZGI1dWM1aGMyUSswYmUvWXNhNll4?=
 =?utf-8?B?c01QMUZCUElhTjU2M0ZVazRIeGdZaTZYd2Uvd0sxQVcra00wOHdIY0d4cTE0?=
 =?utf-8?B?YUREbDkwczhEemhoNDNLelJBWDdXVnVMa0hhWFQwK09nNWFtTlJwWnhVQjBj?=
 =?utf-8?B?aG02VTIxYnQwOEVmOVVXNlVGVFBtQ0NCSjB3czk1TGhvSC82akczOEx2OVM3?=
 =?utf-8?B?QU01WEw0Mms1TXUwYmRjMVlqZ1JsQzJsRlFLUzhqbEJyRFhOTk44SHlrdGxj?=
 =?utf-8?B?eTBEa2lrUS9xeDlJSkJVOUxibHk1M2pDM0FwMTAycUJGRHo0OElHLy9nZkVt?=
 =?utf-8?B?NWU5aHVVeGQ4NzdNeTNrY0laUloyOGlmb01BUDlTUjZRZzUwY0x5a3Iya01L?=
 =?utf-8?B?NEdoMXdJVnhrekRiYzQxUFJ5NFJWTkhkMXVab28rMnB4OGFJaWV2Nll4b1Fm?=
 =?utf-8?B?QklJWXFuN2JYakZ5ZmZBcVh4TnNXdEZVNlN5S21lb0NWMTBEeUhHUmFxcWUr?=
 =?utf-8?B?TklWcE5VSnNxQWZuZGRUS1J2cGxXZWsyWFZOOEZwNnRId3ZiMXdCcnlBSkpt?=
 =?utf-8?B?WXJUY0tUTFd1WHI2NUhXdWYvSm9DSy8rWXNTUVNMQ2Rpd0dpcUFxbkhWQ1No?=
 =?utf-8?B?d1JjZk41N0dLQVZEMXdsYkt3Y2hSV3c2V0VaYzlERklXZC9BUEQ4QVVDbUJ1?=
 =?utf-8?B?cTBxTGJzb0UzR2dlTkZXekdvNXVIZVZiKzdQcmdjc2FSWDhnbENNUmNqOFRP?=
 =?utf-8?B?TkV0L2V5c3pRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmlvMmJobDYyTHd5MDlGdERWQlZmS0V6aEU4MVYzZEV6WTRzVkV0RlY0TVFw?=
 =?utf-8?B?d3J2QWpHZkFoWmt6Njd4VCtBQkFqc3ZUVmkxRnFqcVBLd0dKK2xaTHVVMits?=
 =?utf-8?B?NktNa2dyd0lKR2kveDI5eE5KaForV0l2TnM4N1dhaUhrdkhpS2ZCOTl3Q25W?=
 =?utf-8?B?WSs0a3RQbEt4MHRpWWNsSVdES0IrekJIR3Fjd1YxSUhQS1RTQ0kyRHlKaEFJ?=
 =?utf-8?B?V1V5VmRiQ200OTlvTkt5UFpMcmpoMnpmcHNxcVdKRUNka1NjRW8xTis5d1M3?=
 =?utf-8?B?WjVRdWhMOUpxRGtSa3F6N2x2NHhVVlMzZnkxQ3dOM2ltSGk0MXFNMnlXVjlV?=
 =?utf-8?B?NEd4Z3FOVlJ2T2ZqOU1tREYzTHRaUFdCWC9tK1NjS09jekFRZEU1dnNDUVVr?=
 =?utf-8?B?anlYK21VaXlVZjJiOHJ2Rms2R2JBWjRNUXRHNjVIUFM5OU9jZ0hQS0hzNzZt?=
 =?utf-8?B?WVBGdFRFdnFmbjB0cGRQU0pvc1RtMzU2enA5VVg2MjlXK1JHWjZ2YmVLWmxP?=
 =?utf-8?B?ZGkzbXorczZSNHJNVVd1WVBOUUxkUVlkOU1iK0VCK1E4K2p2SE1Ja2xjeXFn?=
 =?utf-8?B?ejFYd3JoWjJsM3AwMnJsUjJoeGhUQ01lTWVVQVhOM1AybTg2Z1F2a0g3c2Fj?=
 =?utf-8?B?Qk14Q2d2TEJrTk16eUliaGJHQVVxL0drTjdrMk9PZWh3b3Jvb2IvYkdpRW1w?=
 =?utf-8?B?dWRGaTNiUCtyU2p5aFpubDBpTngwTS9vYkkxTHlDbWlocC9tUkRVZGxTekg2?=
 =?utf-8?B?SENVbmVKZE8vRjlUVUVDZnVEQSt1OTFOTS8wVDhTeWFhdEtYNXNuSDVWQmNX?=
 =?utf-8?B?OGFsY0VqZWtQVWRtdXhHVmorcWVyWWN4SGwvQUd3RzluL01HTHdUaUR1NHl4?=
 =?utf-8?B?RlFQTWI5eENVdSt6eHh3dXJtREtnYjlmUHhvWTJPUnlpUndLL3ZuNWlYMU5E?=
 =?utf-8?B?OFNBb2xjZTVnL3dJWkJlWFZtMUwrbTdUK3RqM0dHUzFDL1puZ0JJRS9XbGor?=
 =?utf-8?B?elp2MlNaMlFnODdRQzdSOXlXVk1YenJob2FUTE1qMTI2UFZlTXZheG1VYXlz?=
 =?utf-8?B?aStRZU9aZmY3STlYMGRObmg3TFJqMjJyS2h5eWFCOXpxaWhWMGdnTlhTUzBZ?=
 =?utf-8?B?eFh0YW9XbWtDaEVDSUZDNzVHbEJnN0MxN3R0VGhueXZYTzVEZHBmQ3lXRzNi?=
 =?utf-8?B?blN4dFh1bDVDRXVaR3VzZ2o2dkY3ZGRMajVKbXFKNmZFMEdybGhIN0Q0R3Ev?=
 =?utf-8?B?UHdRSVVTUWt0UzhvaTBmTFBLUmY3VnhubjFiSi93M3pESUFNbUNXcWNxQVR2?=
 =?utf-8?B?eW5NcGRDS3Q1czVwRFpOOUNpam1jRkovMHZBd1MycmpjeE5sbjlscENhNHhS?=
 =?utf-8?B?UW1pM0ViVXNWMi83dHNRY0ducjd1WnhRT2REOEVuNmdpT1RaZm0rSUsxRkU1?=
 =?utf-8?B?QjNnaEU1T0hHcm4rbzk4ajJyS0FjNU1oZGU5QVBNa1NkdVpMUXhUTkRPRE0z?=
 =?utf-8?B?TlhaaW1LNHpNYlRhOW9sdmtsK2sxZ3lmaHB3eUZ2dHhseEQrOFRjbGxmaGgx?=
 =?utf-8?B?VGZyTkE2dGFZM01Qa1Z5RjJkOG92Z1c1cDNzSnNKWDVwdG9XR1NoWlBvbEpu?=
 =?utf-8?B?TTRSNUZqSDRTM2pEbWh1UGFEM3VYYUlEMjNFZmEraXQ1WFBMUkVuUmRKc2Vk?=
 =?utf-8?B?NVROZ21KeSthMDdlUmo1ZmpYZ2drVFZPckVLOGFMMHdwWmlKTjdqVXF0Zlkr?=
 =?utf-8?B?MS9ja0VvTWVpcyt0QW1Vd25aM0MxTFhpUnRzRzM0MDlHL1MxU0VxUjhoUnNZ?=
 =?utf-8?B?Snd5QXMwL0VTeXArdjNLWjRaUzZMRzBNNEtVZ1NPQVJ3alZvSk9KWFhqQmZ3?=
 =?utf-8?B?ampaS2JiT2IvWEpNM0JuS202V1lnSnU3Tks2dVVSRU92ZWlQcDNmQ1U1TmZM?=
 =?utf-8?B?clQ0WlZCYjBqLzRveDlTY2lRb0ozUUdwN0hHMG5HQXBQWWtmRUhjL1BUZVJz?=
 =?utf-8?B?NXJLNlJrNWdKTDhUNXVqYnZheWpEVnZ4eURrNmxVTGxDL1RDRytJYi90K1dS?=
 =?utf-8?B?Qk5vRkJNTG5XM3NCQUlDRWVPY3pWWlNzUkYzT2V3bTFseDdiZndUeCtVNkhk?=
 =?utf-8?B?Y0NDczJ2WTFUeXhQYkdTZkphL1VkLzRNcEpaZDU4NnJ2TnBGMHcxb3pLOXdO?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27227ba8-b63e-47d2-0b22-08de30ca5faa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:11:28.2653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6g3LcmkpdBcmUrGPrmDT/8JW714Y+LMNRnagtpOy+PqA4fNrTI0Z4+7VGsleKhH4ym7qJh8v9G/3WFlQjky5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7999
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

On 01.12.25 11:32, Chee, Tien Fong wrote:
> Hi Jan,
> 
> On 1/12/2025 5:48 pm, Jan Kiszka wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>> On 25.11.25 04:31, Chee, Tien Fong wrote:
>>> Hi Jan,
>>>
>>> On 14/11/2025 8:07 pm, Jan Kiszka wrote:
>>>> [CAUTION: This email is from outside your organization. Unless you
>>>> trust the sender, do not click on links or open attachments as it may
>>>> be a fraudulent email attempting to steal your information and/or
>>>> compromise your computer.]
>>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> The Altera system manager device is only provided for the Agilex
>>>> targets. All others were left with an uninitialized socfpga_sysmgr_base
>>>> after that refactoring, breaking any boot attempts already in SPL.
>>>>
>>>> Tested only on Cyclone5 / DE0-Nano-SoC.
>>>>
>>>> Fixes: 35638172f99a ("arm: socfpga: agilex5: Add new driver model for
>>>> system manager in Agilex5")
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>    arch/arm/mach-socfpga/misc.c     | 7 +++++++
>>>>    arch/arm/mach-socfpga/spl_a10.c  | 1 +
>>>>    arch/arm/mach-socfpga/spl_gen5.c | 1 +
>>>>    arch/arm/mach-socfpga/spl_n5x.c  | 1 +
>>>>    arch/arm/mach-socfpga/spl_s10.c  | 1 +
>>>>    5 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/
>>>> misc.c
>>>> index 76747c2196a..f859d54dce4 100644
>>>> --- a/arch/arm/mach-socfpga/misc.c
>>>> +++ b/arch/arm/mach-socfpga/misc.c
>>>> @@ -277,6 +277,8 @@ void socfpga_get_managers_addr(void)
>>>>    void socfpga_get_sys_mgr_addr(void)
>>>>    {
>>>>           int ret;
>>>> +#if defined(CONFIG_TARGET_SOCFPGA_AGILEX) || \
>>>> +    defined(TARGET_SOCFPGA_AGILEX7M) ||
>>>> defined(TARGET_SOCFPGA_AGILEX5)
>>>>           struct udevice *dev;
>>>>
>>>>           ofnode node = ofnode_get_aliases_node("sysmgr");
>>>> @@ -293,6 +295,11 @@ void socfpga_get_sys_mgr_addr(void)
>>>>           } else {
>>>>                   socfpga_sysmgr_base =
>>>> (phys_addr_t)dev_read_addr(dev);
>>>>           }
>>>> +#else
>>>> +       ret = socfpga_get_base_addr("altr,sys-mgr",
>>>> &socfpga_sysmgr_base);
>>>> +       if (ret)
>>>> +               hang();
>>>> +#endif
>>>>    }
>>>>
>>>>    phys_addr_t socfpga_get_rstmgr_addr(void)
>>>> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/
>>>> spl_a10.c
>>>> index c20376f7f8e..26828077c51 100644
>>>> --- a/arch/arm/mach-socfpga/spl_a10.c
>>>> +++ b/arch/arm/mach-socfpga/spl_a10.c
>>>> @@ -250,6 +250,7 @@ void board_init_f(ulong dummy)
>>>>           if (spl_early_init())
>>>>                   hang();
>>>>
>>>> +       socfpga_get_sys_mgr_addr();
>>>>           socfpga_get_managers_addr();
>>>>
>>>>           dcache_disable();
>>>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/
>>>> spl_gen5.c
>>>> index df79cfe0f7f..f1c654e1566 100644
>>>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>>>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>>>> @@ -72,6 +72,7 @@ void board_init_f(ulong dummy)
>>>>           if (ret)
>>>>                   hang();
>>>>
>>>> +       socfpga_get_sys_mgr_addr();
>>>>           socfpga_get_managers_addr();
>>>>
>>>>           /*
>>>> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/
>>>> spl_n5x.c
>>>> index 81283ef7162..ed4e6f38b31 100644
>>>> --- a/arch/arm/mach-socfpga/spl_n5x.c
>>>> +++ b/arch/arm/mach-socfpga/spl_n5x.c
>>>> @@ -31,6 +31,7 @@ void board_init_f(ulong dummy)
>>>>           if (ret)
>>>>                   hang();
>>>>
>>>> +       socfpga_get_sys_mgr_addr();
>>>>           socfpga_get_managers_addr();
>>>>
>>>>           /* Ensure watchdog is paused when debugging is happening */
>>>> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/
>>>> spl_s10.c
>>>> index fa83ff96adc..460a6f88416 100644
>>>> --- a/arch/arm/mach-socfpga/spl_s10.c
>>>> +++ b/arch/arm/mach-socfpga/spl_s10.c
>>>> @@ -33,6 +33,7 @@ void board_init_f(ulong dummy)
>>>>           if (ret)
>>>>                   hang();
>>>>
>>>> +       socfpga_get_sys_mgr_addr();
>>>>           socfpga_get_managers_addr();
>>>>
>>>>           /* Ensure watchdog is paused when debugging is happening */
>>> Thanks for the quick fix. I’ve reviewed your patch along with Brian’s
>>> fix
>>> (https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-
>>> briansune@gmail.com/).
>>>
>>> Both address the same issue, but Brian’s approach keeps the change local
>>> to misc.c and avoids spreading SoC specific conditionals into SPL paths,
>>> which fits better with the ongoing DM migration.
>>>
>>> Functionally they both work, but Brian’s version looks cleaner for long-
>>> term maintenance.
>>>
>>>
>>> Could you take a look at Brian’s patch as well and let us know if you
>>> see any issues or corner cases we might have missed?
>>>
>> Sorry, think I forgot to reply back than: The difference is that my
>> patch already prepares for having a driver model for the other boards as
>> well, establishing that socfpga_get_sys_mgr_addr sets the address, only
>> catching the differences in that function. That looks more invasive but
>> should be design-wise in line with what you want to achieve, at least
>> mid to long-term.
> 
> Thanks for the feedback. My intent is to keep socfpga_get_sys_mgr_addr()
> as the entry point for the sysmgr driver model.
> 
> That way, when we see it called on a platform, it clearly indicates the
> sysmgr driver is running under DM.
> 
> No cleanup will be needed for socfpga_get_sys_mgr_addr() later, since
> there’s no legacy method for accessing the sysmgr inside.
> 

Makes sense as well, then the other approach fits better.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
