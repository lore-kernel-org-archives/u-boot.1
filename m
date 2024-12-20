Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A22E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 06:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307708007D;
	Fri, 20 Dec 2024 07:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ogFHCH6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986288021A; Fri, 20 Dec 2024 07:41:17 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::708])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1895F8006D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCvMSS5Ss0WUf9cjCebZa15NXZ6jDYGAJWHenzGxax0O6gxXobikVv4iTBsqUU4K4sSIdrJh6DY3S18/81BpEq55bb0Avtgm7efEyG+vCJE2NLn7lzdzPBEfpBKPtqpKew/oU43VxkBdvvDtAH5dw1T9+NTvaNpJ5Vyx+H0mAfFxx2NQhuBy2+kUF/xBGbC7F8Ba/xHZLjTGMm8iOl74XCdwD6n3ojmHf3det8C4isXQ7417jcssJ8J2ej3ZHqyMc71WGZ6IG5kx+EH+wE1YWSkrd/8/TzFkBmwnJC1iRxnL5oLUmjq3lN139ASaOAfOfKRahB47o21j+LtRsk832Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7UxW6KgW1d8iHFRkEdYfo7OWwy08Tn4TQgKBvx6VqQ=;
 b=VUIktpikpVNM8m7IdqDbw24EuAz+NS2XShrsnNKzF9oGRuiEz7eIEV/eK/snmsSmplUA8D5dJcGWk+gz0M9GQTZtxfZPgy7h+FjusuhpESynkvoCdQ8lKGIPnu0Ct2CGfDpaxSlwDne6hzt1A/thhiqbxknj8fEnmZP3GgkyOXxdUAOE8WbweM4jfTVBk6tnY73x+6e3Znndpji1NxM19NviXTsTlMognL0dbNSFATwPGB4iQHqBSF+ZnJxsYzTd9W2sjEwBfsVr6DirCmRpNPlfsU/pvqOtXQbUEnav+UdDADFMtKh8F7h+dR2IVC1/9Ck3mbMjoUGtj0DbVH/QpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7UxW6KgW1d8iHFRkEdYfo7OWwy08Tn4TQgKBvx6VqQ=;
 b=ogFHCH6jAhNHPMxwxcx921lIqC6PhAv3ZxqbThx+iyuCalghfDGwdeGUW5Iw7+EFJzH39Ujp5dB64OTee8qXmekGZUBtIIswEEKsTig0qCoXJWa+6pbYcHGS8xYBP2JEbUcviLcPSnMg3VGP8nkuZrU42EvOqkR1/1wIPx0Kq6Rk+j6Z5sVm+e80OazztF6Ohn8bjw2NonE3tTtZzkwCmChdkWbVX8Sdmy8/2g/OFyulA5ueJA/8OjDj7s6OylGW/BRArcdWY93PmB46wBSiJsKF9ps7N7/1kz4AFYBOWVYCE+WJBjYgMB4B5EiOg+D/onU8kxt8RlzvXwgvc6MRYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DBAP195MB0825.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 06:41:12 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 06:41:12 +0000
Message-ID: <90228225-eac6-4376-baaa-f57eee3ff3ef@phytec.de>
Date: Fri, 20 Dec 2024 13:41:06 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Inline ECC Series
To: Santhosh Kumar K <s-k6@ti.com>, trini@konsulko.com, nm@ti.com,
 vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, m-chawdhry@ti.com,
 vaishnav.a@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de, n-francis@ti.com
References: <20241213103129.332246-1-s-k6@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241213103129.332246-1-s-k6@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::35) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DBAP195MB0825:EE_
X-MS-Office365-Filtering-Correlation-Id: bdaf2572-d6ea-4b5a-6e82-08dd20c14b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WklHUVNlSVBpUjZKb2xVU3RPWnY3OCtRVmkxU0NTU2YwVjFIUWd4MDdZVDla?=
 =?utf-8?B?QWM5MUlMbzNqTksrZzBsU0F4eWtxemw4UE1WdnpqRVNwSUwwYUdrV3o3MTI2?=
 =?utf-8?B?cnFQSU5aOHZZSXFKWWUrK0RNNmdpek5uRTRtZk9xVWxEamlCaW04L1NkUkR1?=
 =?utf-8?B?WkhMenViNEJMM3FralQzUTZDMFlROElTVzU3dS9yUTcvR3huRTg4Zkhpem96?=
 =?utf-8?B?K2lSeTM2QWEySkE5SmExRHlIRitXNm5NUno5TTliUElQR2dadEJWeEl6QjhE?=
 =?utf-8?B?bmR3eTVYSXBGQ2ltQzFIc3JTYUwvbUNvWVJCOS83aEZJdjJkSi9ka0gydVlj?=
 =?utf-8?B?b1VqbnU5cTYvbVlLQjJ0VXBaRGZ3aUVTUk0vV29xZFFubFBTL21OMHkwSTNq?=
 =?utf-8?B?SXRnaGZ1MENRQk40aDg2MWlKeEo4b0ZPc2pYOWh0dGR4bzhwOUZSckxYRVI3?=
 =?utf-8?B?a3BVQTQ3QWVIT2dSYlRJVlh4MFZOZlZhUlpISENHWHF4ZlBTTXNnY291bnV3?=
 =?utf-8?B?QUMwVVYyOVN5VG9rWEpqZHhBcU9EM3FuclY4Qmp0V2Z6bkd0aW9RY3g0dk9l?=
 =?utf-8?B?U3NtVHhFSVBzdTVLeVh5dWJDTjF1YmVVek45cDNSVmdTZGR2UjRmVnlxQ3JR?=
 =?utf-8?B?cDR4ZUJWa0ZieHcvYmJGQ0VNOFNlcFRaSzJ1RDErR1VlVEFxUGo3c1NONm13?=
 =?utf-8?B?MGJ5UnQzNFNBK05UQng2eVFkVzZTaklwdXhNNjlFRW1nSTQxZVFvSG1RTWZu?=
 =?utf-8?B?dkg0M05PaUkxVzlJVjF4cy93WXRISWx6OW5NSnoybm9RMVZqRFd1SElSVmFj?=
 =?utf-8?B?cWtiOWxnUVZoYUo2ejl4Si9HcEtCSG41Z2tDNElVZGhlRmRvWFd5MjQzMVAx?=
 =?utf-8?B?MXJvSnBDdWVvNElGWUVyZTc0Q2lXMFRSNDA2OXdCa0hCVlBleXRCdlZ6NmR5?=
 =?utf-8?B?cWYyUU1Wbzg2NnNlVm5zbkpTK1dBL0IyS1djdzhQUWRlUXFGTXdYSTQvbHB5?=
 =?utf-8?B?RzV2aDZZSXZ6c1ZsTkFCYno5VCt6VC9XekZWS3VrczFJcTVrMFJwb0FJTkZx?=
 =?utf-8?B?Z1l1MWUzTUxpM0R0eDRVSUN6UGhYci9WN1V4VW1QaUk4K2krbURqbGxTWXd3?=
 =?utf-8?B?QSt5bEdlZXdzSzVFTWM2OVNHc3U3VjBrblZYcnZXMzRSREdlQTBQT1p4WHhu?=
 =?utf-8?B?elhmcXkwb09EMUxzdE1hSW1KL0xvbDJMRnlyMk02NnVyY3RobEJ0aXhOWHo2?=
 =?utf-8?B?bGN3aVN6d2VUbDVNUGM4VE1EelJON2FYT2JxOHVMRmJiNEN5YWhYbGlKODJ1?=
 =?utf-8?B?NHlIRkc5L0svbWpMR2NiNTkwcmxhdEk1UjBjV2RnYmQ0WTloMko1VFFPK2Zr?=
 =?utf-8?B?TGJGMnBZekdNbklqSDZWbFhSaXdhUWhyVEJYUlFnSmtVRm40VGxzbjVtQ2NY?=
 =?utf-8?B?OWNIdzRaeWZuaTc2Q3pYd1pxTnJYcHZpMEw5MWUxUkxEaFQzeklwZG9PN3VG?=
 =?utf-8?B?SzdEdjRuT0I5V2MwNnIzcVozN3BHOTBhWnBSVEw0Z3dneUk5NWNZaFBrY3J3?=
 =?utf-8?B?dXkyUmkxQzR2aTJmV2h4VVRyUDNVY0hlUms2TERYMlYvZHJQeTQzT1lOZDZn?=
 =?utf-8?B?ZHBlUzVGcGZ5aG1mQjZuMDB6enFIYklrMFl2SW02VnZXaERoZWc3cmc5dzR6?=
 =?utf-8?B?WW9ISzRwbWJIYjFxYzBkWVR6aTRJbGhjWWNuUkwyUkQwQUNtaGV1SG1iK3VB?=
 =?utf-8?B?d3BZdXZDazlUL3FveURObDdnSHdDVnl2ZFE5VVRDR2t2aGxsZFg3Wng3ZU55?=
 =?utf-8?B?aFB4RUpoeUU5d0ZOQVo2QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVJrejFTUFYrQ24rbWFFM0QzaCtVRkRtbHZpRDhmRlovbUxuUXE4K0RCc0VO?=
 =?utf-8?B?TE5ZWkZhMTJFYU45b1dvVnM2cnE3bVAzM0ZSRTRqRG1waVAwd2FrUlJ1TmY1?=
 =?utf-8?B?cE5mQitxSzhsTjNPSk1DR3ZERjdhTjhpTVBvVW0wVWFzUERUaEppeTdKdGVw?=
 =?utf-8?B?QkxieTl6Ri9TNURPZEd1YnVxTWJLSDlScGQvamttelBqU1g4bi9veXVjWWZY?=
 =?utf-8?B?eVN4RHQ2V1h4QVBlSGhVeTBDaXppM0VQRXYxVVdNdWNxM1B4VVVSVkdGN2ky?=
 =?utf-8?B?bEpsY210TVpFeUkyNGo2WXpXNHY2alVLTjFaU2t1REdmcXFuUHpDY3o2VUNi?=
 =?utf-8?B?UTNqV1A5VlljeTVQUlF6YnpRNEtSYXJqSXJBeWNDdy9uZlJxODd5V1hUeFpk?=
 =?utf-8?B?RHZhMms1L3ZnUzdZL29HMm5McXRYeVM3aTR0RTRiRVJZUFFFeEUyd2hsSlY4?=
 =?utf-8?B?TFp4VUVrS2k4WjZtdVVPMXRXNGhSdHlBMEpZalBpejZEelV6anFacFV1aGtL?=
 =?utf-8?B?RnBzaGZXMHo2YmExNDRUcUN3RVVtT3c3a05qYXVzb09iYkJRTVVwWS9TWWI0?=
 =?utf-8?B?dHdHaVlTK3E4UWcxWERSa1N5c3c0QzNIdk04enIxYXFlN2FtYitSeTRUUGRZ?=
 =?utf-8?B?dktOWXRWTzFMWE0rTmhyNFZNZ0RJUlBIT1NvYVgveU9ncHdWRGlybFhjTXFy?=
 =?utf-8?B?SmY2ZVdOVCt0dHBiZXNSVThtWERBL3hSQlFVa1lRU1lJK2JraUNsaVdqUjJn?=
 =?utf-8?B?OE0rMzhDVTdVU1pkSEpqVW5zMkV3ckdVNW5PS1h1VkhTSkMxMS8wUTkwYXps?=
 =?utf-8?B?d3l3UGlSR2FSMnJWK0FEQnJYeVNtTGtLWUMzMDNST0xGMUFjQnBndWlPWmh1?=
 =?utf-8?B?NkU4U0FmOTV4MmlDUDZnMkZiZDVyQldiVllQOU9sZVlLSTA5VS9YTlExWktQ?=
 =?utf-8?B?Ym1nQ2xvM0RDMnJKd2JpQlI2RVJGZ25hRUNIUnVyREoyZmpNck5ubzN5RlMw?=
 =?utf-8?B?eGs2bFMzdy90a3JES3h1c1hBeGhFZ3g3QTU0M2FQcUw1Qlo2UDA4OWFBZUVu?=
 =?utf-8?B?eDc3blJ6QUJ3Q0tuV0hTclAwZDNLQXJ0NEJBMmx0RU5hUSt2aHUxcENQYU9Y?=
 =?utf-8?B?Rm9PSDhrSnpLajh1emQ4VkVhdVN2V3ZpZU41NWgrdGJDalEyVzZZTnk4TWNZ?=
 =?utf-8?B?bkxwLzhGbWc5WExTdUcyZWJreWp3ejRqRk9xdXBMYWNvbWNzZTJQNEpwRElY?=
 =?utf-8?B?a3ZOaUFVVjhmNXpIL3JtZWdIdVkyc0dVRFdHQWljOHA4ekVnaUQxWkFqdHFn?=
 =?utf-8?B?MzMrOFFVTnRHbVRZMVFUbDV6QWVxaWNidFVFcVFyaXJBcmliamRHV3Z3eGE1?=
 =?utf-8?B?b2IyZnI5d0o2QzZha0VMYnlyUUZLdmNvclRuZkxkVi80MUw5VVNUUWFxaGtI?=
 =?utf-8?B?WnZQUVV0U2hiVFhMUXlkRTUxOGlXVUQ5aTl4UjB4aUt1b1h6V2hGVDdEZ1lY?=
 =?utf-8?B?RU9uMG03WTRjanhIdGIxU3hBTm1SbEJpRUYvNmQza01tY1N3bjRIaElEa2tZ?=
 =?utf-8?B?Q2F6TVFseFpPbkhsb3kwVXhMbFNMUUNVSFpUR0VwWFR1aUpnSGpoZ3BjVUhJ?=
 =?utf-8?B?YnpGR3pwR1BsSlh2SGdGaFdKQ1BoVEJkNmtKem9FdFNCYjd2VWJkb0pINWtJ?=
 =?utf-8?B?Z3RJQjU4SDhpQWlUbWdMYmpkbWFKcUs4T0hNOWtFTDVjTVlrNjFCTTNocXhX?=
 =?utf-8?B?Y0hPU1R5MXFDRTFWY3gvUmtzV2ZYOUR6WnU5ZVVVY0hkd2lUVTIrYjE3RGpZ?=
 =?utf-8?B?KysybEtUc0R2eWJCbkQ4MjNQVzZvZEJ5TXVndVRqWWhnN2YvbnhiSHpJTTFk?=
 =?utf-8?B?amVXUWx2VDFOekhKOFFTZ1MrajRRQTZSQjNWV3BzaDEva3pKN0N6bktsa0RX?=
 =?utf-8?B?dmEvbXJ6RmtZT2RrRkg3c0s2a3N5UUJOeGdvalByRXlxTUQ4SjlqUWRoRDR4?=
 =?utf-8?B?bUNxL1h6WGU2bXJwOHZuazRsMXJ5aGNjcHJUYnczbmVUUEd0M2ZnbUF0SUZE?=
 =?utf-8?B?K3ZzOExtT01nVVY5a1RiOVRGOGFuQmtpbWdrQjZ0bDVJOGRzbTBBWHBDQkx5?=
 =?utf-8?Q?Vsx1zbjtkvNwdxuY/1xWfZrNX?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bdaf2572-d6ea-4b5a-6e82-08dd20c14b5b
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:41:12.4554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nyXVSWg1QGIvSS9Il8erK7XP1QOtJd8tKVCqW+HTYZrmkvsOm09OeblGDnuUcHqFqrClwAHoaHs0HfskZTZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0825
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

Hi Santhosh,

Am 13.12.24 um 17:31 schrieb Santhosh Kumar K:
> Hello,
> 
> This series is to:
> 
> Add support for Inline ECC in DDR for AM64X, AM62X, AM62AX, AM62PX,
> J721S2 and J784S4 devices.
> 
> (1/9) Add ss_cfg reg entry
> (2/9) Enable ECC priming with BIST engine
> (3/9) Add a function to store base address and size of RAM's banks
>        in a 64-bit device private data
> (4/9) Setup the ECC region start and range
> (5/9) Enable ECC 1-bit error, 2-bit error and multiple-bit
>        error interrupts
> (6/9) Add CONFIG_K3_INLINE_ECC
> (7/9) Remove 'ti,ecc-enable' flag
> (8/9) Set default NR_DRAM_BANKS to 2
> (9/9) Pull Redundant DDR functions to a common location and Fixup
>        DDR size when ECC is enabled
>        
> Changes since v4:
> 1. Make dram_init and dram_init_banksize weak at mach-k3/ and define at
>     board/ti/
> 2. Remove 'ti,ecc-enable' flag
> 3. Minor changes like patch order change (8/8 in v4 to 1/9 in v5),
>     use 'u64'

Tested on a phycore-am62x with a 1 and 2 GB variant, so you can have my

Tested-by: Wadim Egorov <w.egorov@phytec.de>

for this series.

> 
> v4: https://lore.kernel.org/u-boot/20241021044024.835846-1-s-k6@ti.com/
> 
> Changes since v3:
> Pull redundant DDR functions to arch/arm/mach-k3/*
> 
> v3: https://lore.kernel.org/all/20240523050430.455201-1-s-k6@ti.com/
> 
> Changes since v2:
> Removed 'default n' in Kconfig as that is default setting
> 
> v2: https://lore.kernel.org/u-boot/20240510084707.1903133-1-s-k6@ti.com/
> 
> Changes since v1:
> Add support for J7* devices.
> 
> v1: https://lore.kernel.org/u-boot/20240131060213.1128024-1-s-k6@ti.com/
> 
> Test Results: https://gist.github.com/santhosh21/88de920771ed2efa0463a5a367cb8d7b
> 
> Thanks and Regards,
> Santhosh.
> 
> Georgi Vlaev (1):
>    ram: k3-ddrss: Use the DDR controller BIST engine for ECC priming
> 
> Neha Malcom Francis (2):
>    drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
>    arm: mach-k3: Set NR_DRAM_BANKS to 2
> 
> Santhosh Kumar K (6):
>    arm: dts: k3-*-ddr: Add ss_cfg reg entry
>    ram: k3-ddrss: Add k3_ddrss_ddr_bank_base_size_calc() to solve
>      'calculations restricted to 32 bits' issue
>    ram: k3-ddrss: Setup ECC region start and range
>    ram: k3-ddrss: Enable ECC interrupts
>    ram: k3-ddrss: Remove 'ti,ecc-enable' support
>    board: ti: Pull redundant DDR functions to a common location and Fixup
>      DDR size when ECC is enabled
> 
>   arch/arm/dts/k3-am62a-ddr.dtsi         |   7 +-
>   arch/arm/dts/k3-j721s2-ddr.dtsi        |  12 +-
>   arch/arm/dts/k3-j784s4-ddr.dtsi        |  24 ++-
>   arch/arm/mach-k3/Kconfig               |   3 +
>   arch/arm/mach-k3/Makefile              |   2 +-
>   arch/arm/mach-k3/include/mach/k3-ddr.h |  15 ++
>   arch/arm/mach-k3/k3-ddr.c              |  72 ++++++++
>   board/ti/am62ax/evm.c                  |  17 +-
>   board/ti/am62px/evm.c                  |  17 +-
>   board/ti/am62x/evm.c                   |  63 +------
>   board/ti/am64x/evm.c                   |  73 +--------
>   board/ti/am65x/evm.c                   |  29 +---
>   board/ti/common/Makefile               |   1 +
>   board/ti/common/k3-ddr.c               |  33 ++++
>   board/ti/common/k3-ddr.h               |  12 ++
>   board/ti/j721e/evm.c                   |  29 +---
>   board/ti/j721s2/evm.c                  |  35 ++--
>   board/ti/j784s4/evm.c                  |  17 +-
>   configs/am62ax_evm_a53_defconfig       |   1 -
>   configs/am62px_evm_a53_defconfig       |   1 -
>   configs/am62x_evm_a53_defconfig        |   1 -
>   configs/am62x_evm_r5_defconfig         |   1 -
>   configs/am64x_evm_a53_defconfig        |   1 -
>   configs/am64x_evm_r5_defconfig         |   1 -
>   configs/am65x_evm_a53_defconfig        |   1 -
>   configs/am65x_evm_r5_defconfig         |   1 -
>   configs/am65x_evm_r5_usbdfu_defconfig  |   1 -
>   configs/am65x_evm_r5_usbmsc_defconfig  |   1 -
>   configs/j7200_evm_a72_defconfig        |   1 -
>   configs/j721e_evm_a72_defconfig        |   1 -
>   configs/j721s2_evm_a72_defconfig       |   1 -
>   configs/j722s_evm_a53_defconfig        |   1 -
>   configs/j784s4_evm_a72_defconfig       |   1 -
>   drivers/ram/Kconfig                    |  10 ++
>   drivers/ram/k3-ddrss/k3-ddrss.c        | 219 +++++++++++++++++++++----
>   35 files changed, 417 insertions(+), 288 deletions(-)
>   create mode 100644 arch/arm/mach-k3/include/mach/k3-ddr.h
>   create mode 100644 arch/arm/mach-k3/k3-ddr.c
>   create mode 100644 board/ti/common/k3-ddr.c
>   create mode 100644 board/ti/common/k3-ddr.h
> 

