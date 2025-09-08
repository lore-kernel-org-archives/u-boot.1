Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37776CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 08:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784E6809A5;
	Mon,  8 Sep 2025 10:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Jf0s0AnO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7323482A9E; Mon,  8 Sep 2025 10:44:24 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BFB800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 10:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzchmu5Ci17dnV2D5NzQCJc3/++5q4rXgvK5qTNJiXRLaMfsXxwNurUw81jRosAvMB7TkhHaUMc9blZbOK7w/pLPZuPk/qZff/RLMbYX3YO5PiLsN+GGCaIEbDsuay8xu/dQND3s9vTJjYCpCHSi8w9muKtkocAuhsX/mpeBKNU2ZWVQku1GaMFNuXjkfJnwqPDDqVREiyn60WPLTIXedkecPxRbbEXNl+CJ1OxWjWB204QT079UkFUP1lB1vRXHSI44DEw992nuiCCZ5sr755SUqf6BVaXJkfjSGvq/rDIfRIcziARBnN2t1ZR5EFgjI546Dr9HB6Z0xeIGbnqJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkiVT251zj3sgxNbtpLUW33HLgk/EfjWTNN39YCKeBQ=;
 b=yHImF7uE0pleW0bHn/IXbia92uqQIlqWz97/CcVhk7qw6HZ/ra8pfyCnAlUqLo6AyzdvPsEt3fkNDgNT6GSu3IcZJEA1YtaVQYEEXOQkHfimjmEgR+aP82yKDzXb4UFynEuIFStKRAfA2iBNGBWGlLG7eBoRW3YEA65kaql1/I2EmaORIpGsl3KT5qP/dlfNSz2Yig8ofmPYgGo3M+XorEmaOTiZEQsfth+Olo1vAa7CYGh5g16HvCmsAQ+SkjlTR+9ihcaYSE6ryNPOPqjoJDwSB7vO9kQFLKcNeIQI3obCB1pKADr3e4y2ut+LZ7A6AK+HhciyQ/lFbfNXKBTmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkiVT251zj3sgxNbtpLUW33HLgk/EfjWTNN39YCKeBQ=;
 b=Jf0s0AnO7dJcTRxc3fCuiDQTXwEqz/FVNfZkVsyWSr+yWVol7YfYrnfNZQQG2sTQtulZ0rVnF4nJeh3eSmjxv0vHhKvW395cfcSxbNQxH+SyE5A3eddnfUS2uyvwUXWGw0c2czbiBFhS/93pFOWI0iENOcGcRQmqE0lNlhG25rbiBUQVdc4Cbskt0fKLXT+wQHiiixBgnNWl7Voc7dkTcyPlctVtdaHUBOkurKUULr4p2HMZ0in5qH/Z/OT2zFDrIOoiaT/fOc/v26SHw4qRziC9qaJNMDrzcwcPeeMi+WLZ1sUFtBaVE9fbxhIilnVYxPruKhQGEgnj3nEddBxp+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV8PR03MB8140.namprd03.prod.outlook.com (2603:10b6:408:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 08:44:17 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 08:44:17 +0000
Message-ID: <3168323f-8cd4-45a9-914e-fb79cd346d67@altera.com>
Date: Mon, 8 Sep 2025 14:14:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: Increase USB Hub debounce timeout in Agilex5
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-4-nareshkumar.ravulapalli@altera.com>
 <7cfaf6cb-38b9-4932-8904-ce7be12a5098@mailbox.org>
 <69597595-6c7e-441a-952b-16b80fd60aca@altera.com>
 <e3107726-6980-4330-aabf-aef1ec9f5562@mailbox.org>
 <bff0c320-35bd-4129-9e19-4ef4103ba923@altera.com>
 <ea637053-8f40-40c5-b257-e582dbbc3c1b@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <ea637053-8f40-40c5-b257-e582dbbc3c1b@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV8PR03MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 957fd761-ac50-4d3b-a1a0-08ddeeb3e586
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUtOdmxjTDltVy9qM25rT3A1SG9xS2JFUGNVTHdwbGdzYUhla3BOMUV4RmY4?=
 =?utf-8?B?T2NGVUprNlFhYlFobTFxZFdWQ3VtZ3kxVEtWSTFPUmtZcnRqYVFzWXp0cENS?=
 =?utf-8?B?TXVqUmU0VFAxU25WRGwycERZeTZaVzNpTk5TdmNWSG9mdTltZmVla3Nrb2xV?=
 =?utf-8?B?a1U4NU81RHpnUklGd01jR3ZmNDJITzlWSFYzaEhzT3dnaWpKZWhCWU8yQkZu?=
 =?utf-8?B?S1Izc3c0cHIxL0FLVk9BZEtLV1d1MFdaREMzRVZwZ2YzNzdSUjhkQzRaRDFE?=
 =?utf-8?B?K0JMcU8yV0hYWFYzc202SWVHR21GVlNUMGtodE9YbVZ0N1dIVlNIaXV0TTRp?=
 =?utf-8?B?L1Q3d09kYkJERzhqbmlzRzQxQTVKcGRBbFA0dmE4Nm8vcEJobWxpakNESVZo?=
 =?utf-8?B?R0plMTVFSmRYOW05M2VTa0J4Y1F1bXNEZW5SQUFuYjFWaS9Hb2RBTGxzTUI4?=
 =?utf-8?B?QkZWOFZjb2xtdk5LMWtIT3VZN0lXQnduY09PMEVEMWIyMFpTc2F6N01VTU1w?=
 =?utf-8?B?RlVjcElWV0RtYUNVQ3ViajlOVUpRVHEvQUtpbHJ2bjVhZzN4aXBFSHh6NzRP?=
 =?utf-8?B?VmNmalBQajgxT3FDZWlGUUxBS2dIVTFYMUc4YVJzb0oyc0ErR1pBT0FQVmJx?=
 =?utf-8?B?SnFhNU1KS2dyVGlsWndndGg3Mzg3YVoxV1dueFBRdEc5UXpONzhhUWdheU5W?=
 =?utf-8?B?dE9yVjB5dlhZbnorZzlrQkRpdmpzOEFZVTdaUU5qTnBDRnhUSWdmTFFmK3hm?=
 =?utf-8?B?cFdkMmVVbVp3WGcrMTRlYWJGRStWSHp2VEloUE1vckE1eC8wdkZCRGdyS0k0?=
 =?utf-8?B?dTIyYUlLYnh1TDVEOWFqY2xDdWJicFo5R1BwbzNvK0FDaHArNDc4aEJNK3BC?=
 =?utf-8?B?NGdXVlVUOXhheDNxcWZFcTJ1eWxybUUvbHVkOUZadEdOMURMaTVmZTFGSitM?=
 =?utf-8?B?TTRmbmpmcWVrNGpBcVc0MU9NMW5HU282alBHbDB3ZDJZZ3QzYk9vWUZkYUdu?=
 =?utf-8?B?Q2tjZVFkVzlRYTFlejFLcTF2U1oyeDFOYmdkWUE5SStVV0c0NVlCcm9xd25B?=
 =?utf-8?B?VmZjZEl3T3JndXpCc1pFWjlOZXZPYkpKZU5jVXcrOC8zMlk1NVFBQ3E5VzNt?=
 =?utf-8?B?em5RYnZtNVBidzA5RjVCdm9kNGNDbkwwSEhlOFAvajRMUjY4eXJhNEVSY2NL?=
 =?utf-8?B?YjBqMkdVUnloU3BFdmxyaGNWVmdBMnVvc1RFZHgrSllKaUdyZi8rdFZXOThD?=
 =?utf-8?B?elBLSEFBYS9uU3krSExKck9iam5DaDVXVlFMZXlMOUsxZmdtWmNNL2NjSHFr?=
 =?utf-8?B?d3ViZ1ZaU2ZFNzBHY2JQU2MySXN1NjRZSlpkcVNKWW43TWJCL2NnOCt3Q3kw?=
 =?utf-8?B?WTB1d2doTXRIanRLUkhoQU04UmlhZGMrWllJa3k5Zmp3UDZudU5HTU9kMUJu?=
 =?utf-8?B?YTVmRFdXbGZLSjhqRVpLKzBjSWgvOExRWFVjZHl4UFpZVHpoYlFrMVpHU2Nm?=
 =?utf-8?B?dU5NY1g3RzRWYkVlU2VCUGNtWi9iZmhpQzJ2K1lHdEdSYytqdWd0bXlJeE1w?=
 =?utf-8?B?S1pqbm9tVUtyS3dPTlhwRWFVSlBRYTRKZThpTGJLcTlJa3BCSHBZT1ZxL0Qv?=
 =?utf-8?B?VE9Xa01Kd3FESk1WZ1RWR2JJME00U0h4U1ZXQ3BrZ3ZtRW5QM3krTkM0NXhn?=
 =?utf-8?B?OTZ0QXFiRHQ3bm8ya1owUWZRN0FPZjRpNFh5WlBrNGlpcnREbG9UK0wzaGEy?=
 =?utf-8?B?N3ljVXRxTCtRVk5FUWlHZHh4VVZBMkFtcVVEdzlZc3pJcktMdUxZVXZlQ3U3?=
 =?utf-8?Q?so+34KTfpMYONwnFKWxmetc9muNKTvy5HgRVg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZBYzVsUTFLUHdzcjhuaUJ6VmY0MXpVc01tdXBtN0dRN0dtWks5SjVaNUVV?=
 =?utf-8?B?OGc1QVQwOEh1UTZkZi9MY3VPNnZBcURmcE1qeEFsdkkrUWQ4SzYyLzFlMlM3?=
 =?utf-8?B?ZmJkK3o2RUFpQ2premZaNHNJZGpzTlJ5TFl0S1FoeERqNk4vaWYwSE5KOTNM?=
 =?utf-8?B?cjAyb0J6UjJnNUpvVnBrc1doVWx0SUl4S2U1UXpiUU1aWFFhWDYvK0RkdzZY?=
 =?utf-8?B?TmFFVkt5VG9QenI0V1NYaHdncW50NUJuNCtqalZPWU5nMXJvSlZtNVF4aWhX?=
 =?utf-8?B?NTB4Nzh4aHE2dVZRYWx3Z0JlelBTNVd0ZnFldGMxdy8vQWFJU1ZaN3RvQk1R?=
 =?utf-8?B?bXF6K25aUkNpdmdRZnF2dGxPMFd0QVNSYUJFaWwxRDEvZ01Ud2trZ2ZZZ0Ny?=
 =?utf-8?B?bDRuY1NjZkw3MEtkaXh3QnJoL1BvdTROeDAzbzBTVlY5ekZPdmlzYTlUeFdG?=
 =?utf-8?B?ZlJDckY2dzdDRFp2ZVhXd3QwQkQ0RU16S1BBT1NDZDhiM2pDZWp6Ri9FZUxG?=
 =?utf-8?B?MWFSQVN4MlFDdEdUbGUxZ0o3ZGZJTDJZZkdzeDVvd2ZkK1QzdVpTd2g2YU84?=
 =?utf-8?B?VXJmeHZZQVlZN2VLakNsdGxGdVJIZnFjUlNuWDdFTCtCVlFKdytaRUVhdExs?=
 =?utf-8?B?RWE4VSswOEFPbkE0WmxEOThQbHRLMWxRRWlnR1RIVUZLN1ErTzNncFl0RGZX?=
 =?utf-8?B?VmUvMy9vZW9KdFAxYXZJaDM1TTJzdzlrbXpmd0p2WFRKQzJjUE5BNGJ1bnVw?=
 =?utf-8?B?QklSYjg5eXpBbWlqOVMvM0xqYmh3VUlldndwZnhpMjF2ODg5T0VqbVh2THpx?=
 =?utf-8?B?cm5Ya2hJR2t0TFk2U2IvbFJrUzRWYUNzRERrOUFXZlREdkIvaUZGdU1RYWd3?=
 =?utf-8?B?NDBMdGNCQTFHWjBLeGdBZExaTndzSkh5N1A4YmY4dHVpczZGd2hoL0NFVEpK?=
 =?utf-8?B?b2ErS05RemcrTU5IZ1J6T3dHbXdRN2RFSVFCRmhBZVdJUE9LYlJ1NjlUeVB4?=
 =?utf-8?B?dWhha2pCY1VoRU9pZFBWMjd6T0hjRHRRT243U3Q0eVB6VlgvV0s0R2hLUmVl?=
 =?utf-8?B?Rk5uQmRNbXFRY2g1WityTXZnQ0E3K0JFYThVdThNVlIvZHJ0WVFFV3JOS0Iv?=
 =?utf-8?B?d05MNk1QZjRRZmEyUFg3VW5McEhCdWJnOHRsU29BK0xTY3I4RVpNc0J1UlVn?=
 =?utf-8?B?VTREb1owZG9mVWhRaTR1MXpEV1FGeldPNDJRZVJaU3RzOTFKWUd5RTA3eld5?=
 =?utf-8?B?Z0hYVGxhdDhCd20zWW95YythYVEyUm5GbDBEaktkSXlxbnlrT1JiM3FycVZL?=
 =?utf-8?B?a1JSRFdIQitPMFlYTFQvbDE5TVcxbnZqMjFWRUY3Zk0zR2dxejRvWk1rNmk3?=
 =?utf-8?B?eEdCSVI1UmtjWWJMbnFHS0ZFS1RJNjN1dFRteUxpTkdQem9McmxxQ1Q4NUNx?=
 =?utf-8?B?SDRvN0NQN1J3ZVZSb05mdDBxSWd3UUxYd1MzeFQvRjlqWXUydnNaSW9yNyt3?=
 =?utf-8?B?RHpjL3lZM2JWUkMwS0hCWU5hME9LWjVBODdWejQxblJEcHN6eURJS0pyMGJS?=
 =?utf-8?B?blZnNVhXQkdYNnplTGlaT0hxZFY0NC91YzdMcXc1QWJta284d2NSblhkZmR5?=
 =?utf-8?B?WjRNNmVzY2U1QlRWRDdpZGI1UTgvRFhHRGQ2UEFiRG52c25iRE0vck1RdkU3?=
 =?utf-8?B?dGlNd04zU25Cdy9DdU1aSUpvZjhwZ21BeWpFVUsvcExCcWwvTWxZR0tkRFlR?=
 =?utf-8?B?ci9OS21PZC9WL2tJeGtWZHF3RDBaTWhpUzd2eis1ak5YRmgrQXRvMUpCK2lO?=
 =?utf-8?B?clkzTXJXczRyRSs1VEFEK2M2U25mRW5CdU90YnhRQjFpV05xVVI0TE5uZEww?=
 =?utf-8?B?Y1ZteDNyNnBWdXVZNlpRV2dvU2VYQUpFbG5RSGhKd3dmc3hXY0lGbEVCaXNZ?=
 =?utf-8?B?WUNscEh6NFJiRFdacEFQOE5IM0VEb2FCYUZNczNleTlkN0ZKbWtvRzlVUnhQ?=
 =?utf-8?B?blpxNVZVeXRBQVVaS2RrUlM1NVFPZmJXU0VEZHBmMXRySTdhRlNhaDFid3kv?=
 =?utf-8?B?cHd5bEtSVzd3dWZwVytQc080WWdOU2dGQkh6UGlsNitoUXo4SjZjUkxJSkha?=
 =?utf-8?B?TXJKc1Rxb2VrczBIenJSSVgwV09Bci9yTWJ0bUFNbGVqNExlSW94SnZsb043?=
 =?utf-8?Q?399cios60d8VuKHzJUSOI9o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957fd761-ac50-4d3b-a1a0-08ddeeb3e586
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:44:17.7660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfUclJ+BosfWeHNjKUumHOn7ojvvs/EHaZ5n5t/1pHzfhJvclwjO3wDC8RQVviAwSj1Pnw/njdcBPpE0383XAwRbFX9Teum7D2eDffBWedwqcvS+KxdP75lHYyjzKxPw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8140
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

Hi Marek

On 02-Sep-25 11:48 PM, Marek Vasut wrote:
> [CAUTION: This email is from outside your organization. Unless you trust 
> the sender, do not click on links or open attachments as it may be a 
> fraudulent email attempting to steal your information and/or compromise 
> your computer.]
> 
> On 9/2/25 9:52 AM, Ravulapalli, Naresh Kumar wrote:
>>
>>
>> On 30-Aug-25 5:30 AM, Marek Vasut wrote:
>>>
>>> On 8/29/25 6:19 PM, Ravulapalli, Naresh Kumar wrote:
>>>> Hi Marek
>>>>
>>>> On 29-Aug-25 2:11 PM, Marek Vasut wrote:
>>>>>
>>>>> On 8/8/25 12:04 PM, Naresh Kumar Ravulapalli wrote:
>>>>>> Some USB devices need more time to be initialized. Hence,
>>>>>> increasing the default USB Hub debounce timeout value for
>>>>>> devices to be discovered, connected to Agilex5 boards.
>>>>> Is this really hub debounce timeout or usb_pgood_delay ?
>>>>>
>>>>> Which devices are those, include that in the commit message.
>>>>
>>>> Yes, timeout is related to USB connect/disconnect signal bounces not
>>>> about bus stability during init.
>>>>
>>>> Issue was mainly observed with legacy flash drives. Maybe I will change
>>>> commit text from "Some USB devices need more time to be initialized..."
>>>> to "Some old USB flash drives need more time to be initialized during
>>>> connect or disconnect events ..."?
>>>>
>>>> Note that I am not modifying the default Kconfig value in general;
>>>> change is only made for an SoCFPGA devkit we tested.
>>> Does this same issue go away if you set usb_pgood_delay to 2000 or
>>> higher too ?
>>
>> No, changing USB HUB debounce timeout is working for us.
> Look at this code:
> 
> https://source.denx.de/u-boot/u-boot/-/blob/master/common/usb_hub.c? 
> ref_type=heads#L199
> 
> "
> #if CONFIG_IS_ENABLED(ENV_SUPPORT)
>         env = env_get("usb_pgood_delay");
>         if (env)
>                 pgood_delay = max(pgood_delay,
>                                   (unsigned)simple_strtol(env, NULL, 0));
> #endif
>         debug("pgood_delay=%dms\n", pgood_delay);
> 
>         /*
>          * Do a minimum delay of the larger value of 100ms or pgood_delay
>          * so that the power can stablize before the devices are queried
>          */
>         hub->query_delay = get_timer(0) + max(100, (int)pgood_delay);
> 
>         /*
>          * Record the power-on timeout here. The max. delay (timeout)
>          * will be done based on this value in the USB port loop in
>          * usb_hub_configure() later.
>          */
>         hub->connect_timeout = hub->query_delay + HUB_DEBOUNCE_TIMEOUT;
>         debug("devnum=%d poweron: query_delay=%d connect_timeout=%d\n",
>               dev->devnum, max(100, (int)pgood_delay),
>               max(100, (int)pgood_delay) + HUB_DEBOUNCE_TIMEOUT);
> "
> 
> Changing both usb_pgood_delay or (CONFIG_USB_)HUB_DEBOUNCE_TIMEOUT
> should have the same effect. How come it does not ?

CONFIG_USB_HUB_DEBOUNCE_TIMEOUT and pgood_delay are used for different 
purposes. If I am not mistaken I think I explained this in my earlier 
comments.

Anyway, to further elaborate, CONFIG_USB_HUB_DEBOUNCE_TIMEOUT is used 
for debounce timeouts during device connect events and pgood_delay is 
used during initial VBus stabilization.

You would be able to see this difference in the link below, where 
pgood_delay which is populated into "hub->query_delay" is used for 
voltages to stabilize before initiating communication and 
"hub->connect_timeout" where "HUB_DEBOUNCE_TIMEOUT" is populated is used 
after getting the port status.

https://github.com/altera-innersource/applications.fpga.soc.uboot-socfpga-dev/blob/b3772135cc63737dbe8e1180a2f8c0e2645590aa/common/usb_hub.c#L455

Also, the change made as part of the comment is not applicable to the 
USB stack in general; it is only for our devkit defconfig.

Kind Regards
Naresh

