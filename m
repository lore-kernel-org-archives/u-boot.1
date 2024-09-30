Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C3CCF649C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 04:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E2A88CBB;
	Mon, 30 Sep 2024 06:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="VK0Ql5+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B9F88D4F; Mon, 30 Sep 2024 06:54:36 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C63388CBB
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfGVYwRbAood8YQSGdmm0VjwozBdR9514yBdQF8+OKQRm84BA1p/pqZfq0TyUhN4DNAgYJWTTHGMC+vBsOvdIdWg0oMgPseGqzNQuXIK5Pl+Lb1Z7lMsrjQjRDNr2PdldfE3X81fDQeNxvWq7+cl6CNHkNWC9DAonrU4jwurP+w9wofvQBTjROtsSxKUpQ3Fd67FKyTQd+HhNsezJ7fvg1mpOWEE1078PAd3k6FBk/POOmdJr3DSXI4i+3E8+1wCsZGuDk7KWeGlEZ7+p0J2N1ZJ3+YY+rkmqzX4ponaePQiSc/1Uqeh+kar8hXTtGHoTO3NMe5LkjChdAfi4s5h8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UtxHrjiEdf3lITzYiLrFZtJ5pkuCJQKAVMdubcmu5I=;
 b=DpbHLYLOyBzmhZ4Z9zf3Y1cW3tgyJwjPthwsSMFUv8zQE7qpQmwWm1FbW6nJy8tughk6foD1CMgEjGBEQM5vpRwMxS8OMQwwe/65GVPGttqA5fXX3UFWMoxlSl73E5HSKXZNNAvGJck+S0okRawmnVgp3PtSKdrY63rDt1OAyzh+nhmcmzwXb+9yhTqF6FSCqIwv0xkl/DHNDA9AqU+f1/7ZHNI6JRLNEtjNVAXyom9dWtCphWeBQFtEg0Cz+TZzbuNltvHI6+X8x32pCdin018LpBMItsVujdhxI1SaiJ73gtlPAomNgYZJZIxInXxXVSHoweBreyJ6wawXNRvk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UtxHrjiEdf3lITzYiLrFZtJ5pkuCJQKAVMdubcmu5I=;
 b=VK0Ql5+aQb9wpNgC1QxLPk3NQ7v7CubSbj/S9BuQ0N5SEWHNmQA65ciEBFwPEIQkltid1SChyzWrkCuF/pWQOZQcTDwAX0Hy2gv8SoAkTUmjrfbCPK9GOyAy2iMMahPwCugyy/rm64uZlZGvGcdxiQnYOmRpNjFOZ5SMhY34bqMTj5pvQ+yKq0MWCnFUqm5vOh2oNhosm8VnNVGDBPcYWGygV0ABKARhag2tEcWja3oqgz2vKNeRuLehP7emVkDhJJLxhVIwxFq9wMSN1ZPoQ357E0E6nd536wog7qeGrOi+ORXBCWMZSOweyx3b6i59YRC2NIzQPNQyWjBOd3gsUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 04:54:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 04:54:31 +0000
Message-ID: <8d9f785c-2640-47d4-9639-dd0384daf1be@siemens.com>
Date: Mon, 30 Sep 2024 06:54:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case
To: Caleb Connolly <caleb.connolly@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
References: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
 <f7ba8d78-e6d9-4f44-8d49-c7f805d60c5b@linaro.org>
 <55c65001-bc56-4b48-9645-1e5f735fe06b@siemens.com>
 <c9d41382-0590-41d5-9bcf-9729bd5bf03d@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c9d41382-0590-41d5-9bcf-9729bd5bf03d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e335759-f6c8-416d-b647-08dce10bf8a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU1sUnRsaXpYamozSHRuMGJIUUljd1VjSFEwN1Y0bXpvdnBPZGtmM0ZFWU1H?=
 =?utf-8?B?aUdHMXBNM2ZXOHZIa0tkaHIyREwyWU9xN0x2bStLeUdtejc2N3dkdldqVGsw?=
 =?utf-8?B?WWN2WEFlcDBuQlRuMHBSTVJpNjlleHRzUDBsOTgyV0p3ZzZxYkszTERPV2pN?=
 =?utf-8?B?SHhEOHoranE1WHN5Tk0xZ0FrRmNJRXQ5eStWdmxaM0xzVjBuZER6YzJIZEdX?=
 =?utf-8?B?VTVoa2k4UkR4eG9wdXNvRzdBekVBUU9YdGRmSUV2UmdzSzNGV1ZhU3ZMeGM5?=
 =?utf-8?B?dVVIY1JhYVpuaUhTTHhaMXpMdnlBNmNydVpWUjl2SnY1eHhXL1dNY2NVWGVy?=
 =?utf-8?B?dXNLZElzK05BUWZEK1dSbzk4NEM2RkNhRDhsYTZOZ1B2SmlyZ2MycEJaUGx4?=
 =?utf-8?B?Qy9uT0FTTTRuMzVYcTlIKzVSd0FCNzN5dEMzTjR6UTRDTEcyR0h0OVZrbVZ1?=
 =?utf-8?B?QmZkc2k0UXVPTDFPRUpjODhKMm1yanNDYnhCank4Q2JSWkhDYTZoUHFSTkVv?=
 =?utf-8?B?b3U3Kzd3UEVVTzJMN0hGQTNyajVVNnpKTFlST1BjV0N3RFFLU3IzVW5nYkcx?=
 =?utf-8?B?VzMyeHRYVHZ5VGNqd3ZIaERkYzQ2RmhwVlJzdG5lUGloVmhPN1VMWkZzUmEr?=
 =?utf-8?B?aE9HZU1DcWd0b1pRMUZzY21JcEpvY2lqd2dWT29LMVQ5T01CcmVpTThPWjVW?=
 =?utf-8?B?eG1aZkRTVlZKZ2RCSm9mWTBqZWkxeHplVDBjbUREWUU3WFdrMllRSnBSN1Rn?=
 =?utf-8?B?Q3I3Z09ZblBra1pxR1QrVkY2Tll2ZmxvMlh5emdyRWFvaU9SV0w2bzRibDhH?=
 =?utf-8?B?RnBvRzJMVS9LWTlJYlp6LzVNSHQvVWJKemRNNEkyeEJOQXRxSzR6aUR2bStO?=
 =?utf-8?B?YVNMMkZSdXl5a0VKUnozV3IzVVZQamJwaENYNnkrakhZc0hsZTR2ZVNtZnl3?=
 =?utf-8?B?Mkdqb0Rqbm5STGNJNm1uSUdtbjdlRXM4MWhDRkdORkVMR2JuUHVVOEpKVElh?=
 =?utf-8?B?SlV2QWZjRjlRRjNlSTh3QzBNc3ZmTm9KT0p6UWhyK3REcU9ucnUxQmtZcEZo?=
 =?utf-8?B?V3NQUFNET2NrNmx6VmZFb1Bwc2RzM0EzdG9hRUZlWGphWENJRGpQalBNOE03?=
 =?utf-8?B?WHJ5OUxLMDhZYWFVR2IzSWU1RTRJRGlnSjF4Vmkzbk5UVmtkNkk0dERDNnA4?=
 =?utf-8?B?eGY4Z1pBaXoxaDV5Vng1ZTJ6eENsci9XdWJuL1FnR2xJMndLeDNTd0RWb1lT?=
 =?utf-8?B?SHV0TDY0QVAzZ29BbFdTS015YnVvMitHR3NPbFlkMEZudmVVY01EWllwTjY0?=
 =?utf-8?B?VzIrSHB3WXRQbDNpQU4xeWtTZjloUnVKTEpPUlQ0WDROOTdmdHFZNEl4elFt?=
 =?utf-8?B?aW81ejhCR1l3dis2TzJKdzZTSVdFbE1hNFlaNmhraDBaTStJTkI3bmNxNjBv?=
 =?utf-8?B?ZlZRZXRGWHdyY3FkWFZ3N2dvL2lYWFFUeDQwVUtTdmpGWlVVNmJvUHkxVmVR?=
 =?utf-8?B?UlNNZzZBcVpSNUJsQUVKbEMxSnJhdTdicHV5YzAwUGE3bGk3eUVrMFlSMnM4?=
 =?utf-8?B?ckZFT3BiYk81eUtXTU1NM1UrVW5ISmFKbWxtenVNd2tWMlRqNlNoVW1RZExP?=
 =?utf-8?B?UmllVkptVW95YnJoV3gxSFhMcmtoU1lwR0gzRVZpNE5zTXZmZGRUSE5NT092?=
 =?utf-8?B?elBaU0JyeUNDNGhCYVYya2FVTDJKSVhrSzJuK2hLTWN6L0k2WTFkMkFiVDU0?=
 =?utf-8?B?cFMzQ2c5cjIyNm11YXJoVlgyd2RMY2ZJdUZIeFpUL0p5TE8wVnZyNGZYQ0dZ?=
 =?utf-8?B?d25zOUY1K2pMK3pjYzJ6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtrRmhIRmVXcW9ZK01zb1prTmtSTzd2QzlmMitBQXI5bmRiUUx6UmovWWdu?=
 =?utf-8?B?ZDdLcjJVVDhNUkxYWnV1M0tIUCtkMVNqR1pXTmRnTnJ4ZjVEL3I4eHE2aDhZ?=
 =?utf-8?B?R3lzZ0hWZmFhSmdGM1JkRmJneEJCRmwwNFZBT3VrVnlDRW40RUZHRm1WVlZJ?=
 =?utf-8?B?RklXcXZ2d3F3VENhMDFpRXVPME14YkRxbG5BSS9NK2llc2Roei9tdnIwQlY1?=
 =?utf-8?B?aVhDK1k5ZlJ3eUUzbjlQK29ueEdPUHk2cnFpdS9PSHVsWXJhaW41RndxL0Mz?=
 =?utf-8?B?SkZMK2s4VktqSTg2NE52TU82RHdyQXBqYjVueGZLOWFMUTJpU2VzY0ZRRk04?=
 =?utf-8?B?ZkRxTGpGUnV6UncyWHhjbnRHelErcFVEekpaTGdVcG5lMENKdTFPSVI0ZXdI?=
 =?utf-8?B?eWNYRWxLRE9xclVXRTZweDFHTm8yQTZFY25MRExIQVkwKzR0ckUzTFhQM3da?=
 =?utf-8?B?Z29SU2s2bFdkWHd1WCtrYTdXVWJQWEN2Tm9SYWh1dmZmek1EZXVHbWdkZ2Qy?=
 =?utf-8?B?S01CRkxvQ1JVbW5KNkRvOFBGanJQVW01KzQ2VmtFdk9lbmdvSzA0dGw2anBn?=
 =?utf-8?B?cUZsaFhnRGRXMllqYUZjM1ZWOER1aUplenlidkJSTHlVWUR4dFN5UEJzWHNI?=
 =?utf-8?B?ZTNBNUJDMDlmbjFleUFaNzhLTUNpTng3OFZCM01UaU16TmY2NmZHZXB2YWw2?=
 =?utf-8?B?SUpXbE5zNnp2SG03R29mSW8xWmQ4NEdkMHorNHN1ejk4V21Gem43RkZGQy95?=
 =?utf-8?B?RXNQY2V1Nm5uc2xpbUROTEtaMWhrbUFZcDVCaWU0TE84MWNxcTg0ejAyU2pj?=
 =?utf-8?B?elkxdXVSN2lTd1d4N0hOdGJIOTVKcmcyNHVpYzBLbnhxaU50NEVlcWRzaEtr?=
 =?utf-8?B?eVIwbW11ck9LMnY3Z0N6clFHemNic0RHb2F3MGVtK1ZxQWRzR1BTRFRDOGxW?=
 =?utf-8?B?REQrbUhOVXhVUkFtUWg4UmJrTmVKT2Q1U2xmWXI5VTFuQi9rM1VmQUFhUTJD?=
 =?utf-8?B?Y0pzQW80azFicHFEVWIvOTVDTUdyOVhNSFNEaHRkbVFzUkgwYU9UNHk5N3ZB?=
 =?utf-8?B?OFZsTE9EZHBBalZqQ2l1cFhTazA1eUpJSTNrLzhxMnlSTit0bVpLazhKMWFE?=
 =?utf-8?B?YWpwTWxuTUVMTmZVUjFxQnRtVXVWT2FqQ2ZpQ2ZtY3Jtc1liaWR5eEFvVEFS?=
 =?utf-8?B?eWRXcWpad2YvNmhxMVdUZEVTdlBYOE1zK3RIODFlQlJGeHlQU00wNjBmaC9D?=
 =?utf-8?B?Z1ozVVdMUWhPNXQ5M3hHVnp6ZXdTUXNaQ1RISDh2a2szS0dpZG9rSFkrUUNy?=
 =?utf-8?B?NEhWaHJlbXFyRGtVWTMyTnZYN3dJd0VNMGUreWV0TElJbnVlMEUreTV5UExT?=
 =?utf-8?B?QkJkQzZJZ0xIY1QrMDhvY3Z0cHFLYXhPbmxJbEVoMHZnak5Nc0duWEJWRkxH?=
 =?utf-8?B?RUo4TDBRdUhzemVHYjNQazFmRFQvWCs4Nk5jdHZYV2oxU2Y1YTlNQXN4V2Ev?=
 =?utf-8?B?eFJIbzMwN25WYjBJa3hnWVZvSENUMVVrQWNaQk83TVRZRFFXRnpsMVJOeDY0?=
 =?utf-8?B?a29Ed1gyL0ZVdlRYY1UwVElWQVpDdHBHTkkrVTlSRHJXQjJaL3I4SXpmKzJl?=
 =?utf-8?B?blVNUWV6dGdSSzByeGRRRzJEREtWazk2V3VHaDhDczIzZGZ4RnNHVkxFL1VD?=
 =?utf-8?B?dDJXYTFDVHhJdHQvT0lVWExZOGhibmZDTTNYdHBsNTZNdGlKU1hvbkx5SFJw?=
 =?utf-8?B?VmJrbkNTb0MzcUZLQ3l0U3YwM1hzSWdmT3l1enJLYm5LVW5ybmxSaDJhQ2Jp?=
 =?utf-8?B?NGFtdHdMMDlMdmJkc2NtdGZXSjV5S0c4cGRUYnRhenF5RGN4UWdsWXlDdEh4?=
 =?utf-8?B?Qkc1ME5EVVovTnFyRkxUT0IvQ2hEZWtnc1JCdmQwMWdrUFdRd0hIVFo3Zy8v?=
 =?utf-8?B?LzlPZWc4OXV1NWJocEIzbmhWSGdid0RtTi9kTTM3SHJpVFlDYkdjdEwydXFF?=
 =?utf-8?B?aHZIMUNveVhvaHNEZElLQlo4MGtCekFINjVOb2t2cHI3NFhMOHNaWWd1dVVU?=
 =?utf-8?B?Mk4vbHg3L0dTakJ6bFkzWEZWRm4zd3hnbktxcFRIUnJMVGFNTCtiL01uaURq?=
 =?utf-8?Q?hTPiiqAZvduKUexkMkFZC9bay?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e335759-f6c8-416d-b647-08dce10bf8a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:54:31.3453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCayVva0HqVJ+BWd1Orir8AB1lAPWqaZYLzcRfev4VaE/d3TSE3nMMsYT5gXZ9uvUGZBRQzzpbyO8VwS4CJydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5263
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

On 09.08.24 17:19, Caleb Connolly wrote:
> 
> 
> On 09/08/2024 07:19, Jan Kiszka wrote:
>> On 08.08.24 16:27, Caleb Connolly wrote:
>>> Hi Jan,
>>>
>>> On 08/08/2024 10:51, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> When DM_REGULATOR is disabled, all calls will return -ENOSYS. Account
>>>> for that so that targets like the IOT2050 will work again.
>>>>
>>>> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus
>>>> regulator")
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>    drivers/usb/dwc3/dwc3-generic.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c
>>>> b/drivers/usb/dwc3/dwc3-generic.c
>>>> index a9ba315463c..2ab41cbae45 100644
>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>> @@ -246,12 +246,12 @@ static int dwc3_generic_host_probe(struct
>>>> udevice *dev)
>>>>            return rc;
>>>>          rc = device_get_supply_regulator(dev, "vbus-supply",
>>>> &priv->vbus_supply);
>>>> -    if (rc)
>>>> +    if (rc && rc != -ENOSYS)
>>>>            debug("%s: No vbus regulator found: %d\n", dev->name, rc);
>>>>    -    /* Only returns an error if regulator is valid and failed to
>>>> enable due to a driver issue */
>>>> +    /* Does not return an error if regulator is invalid - but does so
>>>> when DM_REGULATOR is disabled */
>>>>        rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>>>> -    if (rc)
>>>> +    if (rc && rc != -ENOSYS)
>>>
>>> regulator_set_enable_if_allowed() will return 0 if the call to
>>> regulator_set_enable() returns -ENOSYS
>>>
>>> Maybe it would make sense to have the stub implementation of
>>> regulator_set_enable_if_allowed() return 0?
>>>
>>
>> Possible. Would that be the only case where a stub should not return
>> ENOSYS? All do so far.
>>
>>> Somewhat confusing to check for -ENOSYS here imo, since it isn't really
>>> obvious when that would be the case.
>>
>> But that would still leave is a with a misleading message, even if it is
>> just a debug output. The absence of a regulator is not per se a bug to
>> my understanding.
> 
> Ah good point.
> 
> Alternatively, maybe it would be easier to gate this code block with if
> (CONFIG_IS_ENABLED(DM_REGULATOR)?
> 
> But yeah maybe fine as is.
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Can this regression fix be merged now, or should I add that gating?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

