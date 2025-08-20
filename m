Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3812CCA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 11:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7D58211F;
	Wed, 20 Aug 2025 13:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aMh/G4C7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD5282B07; Wed, 20 Aug 2025 13:35:38 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0188801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 13:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWa/7hK10H6zOdtacYS8FOEpXd2IuSAINRIzf9cDLhgcVtqcwPVJ5qgoJ4f5Vp2TuB4BnMsxNGkpFmTTZ/rgVj8rU5Pg+fvamwei2P8Y0dw8+Lcer7u1dHLufyEaLkpRHWJPr/Pd5wOB49dV3wvwo4zri0848j7q89baPFjXFS7NHSdrajaCiV3Hul86iF6l1VhOrVwoeDOZNG9fn3HYLRIt7eDdLWZJQ+6WmPCQDBi60JQbVpSEZBcDcANGoi7KksddTxdDjIsTnSBMPQEJpqRh+ANLoiH2rQ7B1v9eLL/TMsW+Ul3INedIpDqKUqSRXK3QXv6Qshvkb4z0TS3U5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHaKSXD7IKFXxn7Pr+Rs4NCo8JArwLOW/VeQOdFEM1o=;
 b=RhkAKfYOn/0su8SnVIs2ipnDmWCThs+cTR8rHUZwRPvtPABB7eWTWwKjwGzIY1F6YClr5oF0L747nK8n5D+VjW0kU62RoTEVMqMtp0KHcpQ/uwP5xcvjTE5ty4B73XTqmoZ2sjjVcILtnzY1UA+ChPyEGhs6SBW+3kx328HvRdeEQ4JIUMSiJYQ+axLVPU25mNINWQ8FNiinplrYXvBrF+Zq8kWD7m+RHqpnusLQzMVyflewgnyZgZMIkwV9Mvf+LjL1fkQAAhOLzVUNI0B6Ta5j0et6esKX0557ceuDLQaqM3zpL5auaGFjSGvmQ/2KoJ7JOVYaedktyjMdGJjMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHaKSXD7IKFXxn7Pr+Rs4NCo8JArwLOW/VeQOdFEM1o=;
 b=aMh/G4C7f/9LuCRcfoISRsIi/XiNETa/S101xxRB54/j+2mhWFJ+kJmQOAzTD0t60522ydO5UeCWyUtS7HBasybOFSQOLR6NkM336n7bFHyD8/cT7WxRcx3Nte44rpwPJSVKh3f9P2L9c27Ms1FryFFizdY16hLpkTpFPVHHKFVQ9q52jKSMtNhiI+9J6XDwhVccS8jEt+cu433hEH6BUxsv1/H8Jw5foIw/JNhTGff+p1umOpiCk3R0l1BVA6EHjEFGY9T6jrwAgmiSr00E3WzOcGH1hHR12+P+qHQpgqXWbDDhCiShoERso7ZwXGthaf46ym061GPfWgG9oPggUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5749.namprd03.prod.outlook.com (2603:10b6:510:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 11:35:32 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 11:35:32 +0000
Message-ID: <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
Date: Wed, 20 Aug 2025 17:05:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
 <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::15) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 89902f6d-dc6d-43dc-3f49-08dddfddac1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjZYdE1hK3V0MWpoZFJDK25SZzNQSThGdnFwbjVyeEcySlgyd0ZoZWdzTG56?=
 =?utf-8?B?akpKSE1PQTRBbC8ySGU1Yi9SUGZBMUdEREo4SENCUGJXS3RIcnFiUWpidWpF?=
 =?utf-8?B?bkd6RFJVOU1yckJZZDRHOFJaRFJXUGUzb3RmZzJNNjQ0TjJJZ3ZVV2VtNFhF?=
 =?utf-8?B?QXo1Ni9LeG93eVgvMElIMk1rcUV5Q1NmNkFsNGFoaXl6cGYza0VIcUNZU3lQ?=
 =?utf-8?B?UVdIQ2xQYjhpUW9mdU1tVS9uVFdKem5iYi95anRsVEIzQzNVMFRJNlhLYXlC?=
 =?utf-8?B?Q0FpcXFDMjZYOEt6eE5ndC9MSmgwaWI1Qm5sZHVJQk5ZR2c2b2h5TXdBMmFP?=
 =?utf-8?B?WTRpSzk0azZjdHl4cEdZTVJOZU1qL0ZOemVhZGliUnA4ZmJjL3lzaTAwR1Zy?=
 =?utf-8?B?RVIrYjliU2luOW9tWnA0ZEFSeDhHQW5EMTlyWjVyb2JQM1JaVWJwY2RPcWND?=
 =?utf-8?B?UDYwWk15b2ZYZlJ4UW1RalBLM29oSXZENE93Vm9ycVBWNnZwRnNpQmJ6UEZX?=
 =?utf-8?B?TkorRGxDaGJOcHlmVzRSL0lkeUF1Vi9VZXR1WE5IYiszWk41aFlQTzlrWXRi?=
 =?utf-8?B?Q2F4Mi9PVTVHeXpTdEJEeUZnUkpjd2NpR0x4N1pvNHpKM1FvSEZGSkVRczg0?=
 =?utf-8?B?RklSWGNwWndpenZRVmtZNDZHRTdkb2xRT3hwNWt2MjhKY3RFV285clNhamtk?=
 =?utf-8?B?UE1qZWNqU1RDanIrZnRUSExKOWcyZTI5dWdpeVgyMThhLzRTdjRncW9KSDJl?=
 =?utf-8?B?WGoyaTlvcWtwVnRVQlZSeTJONFJ6eTBNSmNYY2RzVlpoVWhzUExJQ1VDa01E?=
 =?utf-8?B?cnFqVEx2ekRNZE5SdEg2dHpDcVRWREU4Z3d3Tk41YWVjUnF1SHN0TTlWUXhZ?=
 =?utf-8?B?RExoTTB4RGIwSVJMSlV4RHhxMHFVVnVmRUxNN09od2NqSXAwRkd5dEExSXNo?=
 =?utf-8?B?WUxRczhqU0hZN2ZudUJLN0Z0UEo4VzFOSGRLN3ZvYkFKUlovd0ZqNThjRzR6?=
 =?utf-8?B?UTlOcSszYVVVakRQMmRQVmNwdm1teEhCeEFCTy9RQXZETUp5T2dUMXNKUHha?=
 =?utf-8?B?ZDlPY2pacE9wZTNPUElxNStuS1UyN1hacGZRVCtnQmI0TXI2NkFqZ3FieTNw?=
 =?utf-8?B?VGkxU0RWZUI2elRST0Y3elg3aEY1YWljYlhYOGxlekdFYmE5Y3MreVhyN1Ev?=
 =?utf-8?B?ZVBlUVJBb3p5VGc4Q0dBdTdXbDdweEdYcTJrWXNWNWxZaUEvUWxzbjhMVjdw?=
 =?utf-8?B?a0JPKzNxK0hJYnFzZnlxN3pseWNtVGhOeXdWT2dDb2pxb0tYYTJrMU9renBW?=
 =?utf-8?B?eTZna2VEaUt5RjFaZEgxc2ZBa0xsNHQ3K1ZEM2tEMW13ZVdDSUZpL2h1b2dr?=
 =?utf-8?B?OEpWbzZoQ0lZY0VvTGVJcVpKdTk0NjR5TjZlT1g5ZExzbnYvWG5qb0ZtMUZY?=
 =?utf-8?B?Q05xTHRtL1RMZ1hSK1dFWWpUVk1rVGNWdkk1TlVUcGxNWVNFWW90a0x2UkxD?=
 =?utf-8?B?WWUvZVNQMThtYUpjN0VrOTJMWU1UYzJIK3R5RlpVWlRLeCtQYUdGcXV2dFRO?=
 =?utf-8?B?RlpCVDFEY1lBYTE3cjlQVWJtMU13RDBpZTFsMTd6RUxJWUF5TjBmQ3pudnRK?=
 =?utf-8?B?SFJCVVdXOUJ0dlpScFhDRU11NjJCQ244RGlBV2pkeUNIVTkxem1rUjdpcnRH?=
 =?utf-8?B?dkl5VjlCSm93UmlCYmtydGVKYkoxaXljVjlLazVLaFl4cEZUbzZSTFFVMEx4?=
 =?utf-8?B?cU9ZaEx6OWk1QmZpUHVMRHJtNjMyQXY2UnJ2U1pxZDY5U0ZKUGJDM2dLa2ZN?=
 =?utf-8?B?MjR5R0MrWTdzR1dLeHJLMC9yMnBsY1dSZUxWS0ZxdTlMY0lhTmhrWjBlN3Nt?=
 =?utf-8?B?dWxYcWxHaEl1dDdsTmM4VTFxUFhYaHNHa1pPUDJEVWJLUVZPTkIyR0U4dlZO?=
 =?utf-8?Q?BJ3zxXY3oXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZkN0puUm1uUFpNajJIVEdaQi9rMjlETnM3bVk1Z2Zia3FZbWQzbHV2WUhM?=
 =?utf-8?B?cEQvKzMvMXA2aDhaenl2YnN0TExiZTI4U3VtZSs0TnZjRHo4V0tGSjZ3N2RI?=
 =?utf-8?B?MnJrV0xjVlRwY29CVkg3eDFZRC9BN3VuWm1uSE1SL2J6VGJVNW1pV1kzT2Fk?=
 =?utf-8?B?ZzRQMjArbkwzbWdZTDVxSG5YWFFYNkhRTy9pbUw1TlZHNXpCUkxMdklvV1lj?=
 =?utf-8?B?dU5xRCtmN2lCRmN0ZWdUYmVMOWhjZUJFTmx6NGtDVVlJbmtEVDY0SXpYaFIz?=
 =?utf-8?B?MWRFVE4zZ1c3amFqVGVzL21IZUNCSnozQzI4Ry9DMG56SjdNMUErTnlpSC8v?=
 =?utf-8?B?djIvNlF0RGliUTRNLzZBSW1TZkZHeXJjYUVwWjN2Y3JZWG1nOE5RdEFXUWYz?=
 =?utf-8?B?WDIwS1puWXF5V2RKY2tXeFpZSG82cDcvVTl5TDBPYWJDTTFmajFiUWJFbDlJ?=
 =?utf-8?B?QVV3MFQyWE9hMGwrdHBWSGEzaW8xbDl1RjdsdGcveDV1d0xVSzF4U0l1OW5C?=
 =?utf-8?B?cnBjZmttVk5hTlFMUGRUczJmMjh2NE40eUJxZ0ZEeGhJZFV6dlprL1JrT2dt?=
 =?utf-8?B?M2hLamxBYVJyODFNeG9kN0JabmJrZVpWR0N3MHlsa01DaVNDWHRPN3d5N0dD?=
 =?utf-8?B?dHhEZkVkVU1ZQS9DQUpHUW8rc2N3aS9zT0pOT2pUSkdqZGp5TEFuRmVyQ1ZF?=
 =?utf-8?B?akszc1psWWxzNEZQTzRwU3JxYWZBa3FLY2ZYMVcyYXMwR3JQSk9ITzZKQVds?=
 =?utf-8?B?NXU2ZmYrdW1kZ1NDNXU2dTZOcmdobUpHTWNHaUE3NC9SQ3Rram5SZDY5Q2ZP?=
 =?utf-8?B?dmdZUWFqU0FRUkd0Rmgvd0l6TzVkR0NqUVIwa09tcVYwK1N0dVpVWWxnSkQ2?=
 =?utf-8?B?VzJSRkh3eWw3M0RGbE5iSWp1Um4vSmdtaC8wNkJJWFl0Rk5STGVDVzAwdkZq?=
 =?utf-8?B?WXJmNEZQdmhkajlJZFVoQUZIcmVVYkt3d2h3bjBBMHhLZjBHb0E5eEpCcXRR?=
 =?utf-8?B?SFZKQTY1UHEwK3FzeSs3Q1F4VHVNVGRtY3dqQXlreGc2cW9lRWFQQnBBWlNn?=
 =?utf-8?B?bjFrQ1o1amxaRmhHUjZ4dCtMYVZGcDJiMzIxYTl6WmhWcFlhMFBKcVBSQUZK?=
 =?utf-8?B?bWFFdmVJU2hvTjR1TDZFQXZhbTlVcSt1elJFdUpVRWhZam1WNXJVcVZ6UmEw?=
 =?utf-8?B?SlIzYXFWNjJXMWowU09vczluUzA2MkRma3Vtb1BKTHZaV2lRRDM3VE11S0Ez?=
 =?utf-8?B?aDh5ZTBsd1FlQWEybmUzOWhTUVBEampqYjFVTnN6QXljNU9WUXJJWE4vWENI?=
 =?utf-8?B?RWVNTUVYSUdUNExSaXRJejdrNEZneXhVMkJYUkZZVjZRRG5JSGtjK3cxdjhI?=
 =?utf-8?B?OWZlZnFIMEVYK2xDazRHREZvanZWeEVvVURkVkk5ZWFNUU9FYW1KU3FnaTIv?=
 =?utf-8?B?ck5FTEFmWkZWcE5HZG43b1R2R0hXMEdhcUwrRENqWEl4Y0VHVXdYcEZFMTNU?=
 =?utf-8?B?NFVBWGMvYzIyVnhGTVkvdHFTUDAyWFFmd3c1TzhMRnAvcy9CTG1nd1huWU9G?=
 =?utf-8?B?MHlKUUUweVExR0tzM0tWOVJNaTRGek5qQ0NSR0svdlRiWGlVMFdZejdTSE9E?=
 =?utf-8?B?aFVReDRseUFiU1RGT3QycHhnMzJkYlBlZ3AxOTBJQmt5WXlESHJtK21OaW56?=
 =?utf-8?B?VWRzSnBScGFqOVE4NTJlMTl4SmhEekNlK1Y1MnowV1NWTzNxK3pzaGlnbVAx?=
 =?utf-8?B?ayt6cDFrZUJiVTdRWDJWSmZoZHFla09WTlFydmtYemp1U3hFSUZRcld6VzEr?=
 =?utf-8?B?TU9ZNE9jVy9IWFZiQTFhUFFQbzBqZXFQRFljWnhNbXVIbFFLTmdodWE5U0xz?=
 =?utf-8?B?Y0tJeFcyV2dkQmpGR0V4WDBuODZJc0JBSy83UUxpNHMrRlVnV3plRnovTVha?=
 =?utf-8?B?VlhVU0JoN28xKzVqTjhPbUR2c0NxcnQ4ei93ckdNSitZaUF4Y2VkVGlLd1Y5?=
 =?utf-8?B?dGMybmlUZzJVWXZVdGI1MEpXRmhJWXd3cTVDUHVGQ1NDOG5EZHJHWjZBNWtQ?=
 =?utf-8?B?WHFzOXYzM0pZMzM1Q3hpYStiNFdXUWJkZnhSUlBCWEszc3pYd1NVUFgxcW5Q?=
 =?utf-8?B?REVTNmJYdngwamdqY1dESDArMlNhMzZZNStqdGxFOThWaW1aSlltOEVCZE5m?=
 =?utf-8?Q?hlrHxcaMmgN3hRl6FTLYJKo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89902f6d-dc6d-43dc-3f49-08dddfddac1b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:35:32.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYW6+wfZVoXIcZDcHomL/ez8LCN0gJiziV9496c27+2d/qmBcAknpZ+3JeQevaWFb5VY8Qh9iw3yugaIgZUgx5vKnjl6U0b/ntD/Q1MLAjeCG8kIM+zU9Us0lM0iFPy/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5749
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

On 20-Aug-25 4:56 PM, Marek Vasut wrote:
> 
> On 8/20/25 1:20 PM, Ravulapalli, Naresh Kumar wrote:
>> Hi Marek
>>
>> On 20-Aug-25 2:27 PM, Marek Vasut wrote:
>>>
>>> On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
>>>> Enhanced the generic firmware loader to support QSPI RAW partition
>>>> loading. This would enable FPGA configuration bitstream loading
>>>> from QSPI RAW partition to program FPGA.
>>>>
>>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>> Signed-off-by: Naresh Kumar Ravulapalli
>>>> <nareshkumar.ravulapalli@altera.com>
>>>
>>> Why not load from UBI on SPI NOR ?
>>
>> It is to avoid the storage overhead for metadata and management
>> for devices with flash constraints.
> 
> What about data integrity , iirc UBI gives you built-in checksums.
> 

Agree, UBI supports bad block management and other advantages. But
the objective here is to support RAW partition for flash constraint
devices.

Kind Regards
Naresh

