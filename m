Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327DBD3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA18F83C08;
	Wed, 10 Dec 2025 08:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SbVKt/jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998D083C08; Wed, 10 Dec 2025 08:36:31 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5F783B48
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWyLdPHmj0fJfquIXVghTOJlVi4iJX7cjRfC6VaMiG5/NNGI4j68TMKPyjZgyjtZaJRgB92wBxx0KhMCNugnusZMVKlS7eKIWVWx/Uqmm4L2PfTrDPph12uE+/M17rJPRE7Kdquy68gU0lrZTDKY8ob9Fku8IJ5qUF+RGiJVttJ1y+ISypzSUxq4rAXRZ138gQ2s2OWexs7xtt5Di4STDFpRCelKLjazfLXqmuZsp4aPKLdafdJ6GBUEOf51u9qEu1QlyPxYDNP6ModNI/K9lWMwBvx6vyyAiKOY8Vj92Ada6BKJww6EALwRhSY5w6zqYDfujQLHX+YIN83d/Ztsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRmWQYjvKToLdH2Uw3dBQmGJu0KQhC1QtuzCnQw+rek=;
 b=fc1UZOC2/gjeCh/7roIBVMVi7uK/C2J7U/xQzPvatB9fOuUSvTPHuJLN6qDRpKPvM3NNYPZuBou1DqLjpZyb4m6aFDmlKyH1PbhY98brwAZHwMOo2SDtBifwkYDuh6+IS1NZVN0PRS85iDwRf6CK7R4EAh0D12gC7GjHQf5RhWM0WPE7C6B+qYqdreIA4fTaQ0g8W7SA20z54rQJw3BGZaCtkP4Y8Tql2C53EiHXmwnry35esby0yClgFzJMS9Alj4k3O2t6YThIeI2/4abOhpO2KQnw/L6Xf0Gh8uagaq8yigRE1aBqAFJUojqVYgTXCSLjEaenenTHE6TBrIRhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRmWQYjvKToLdH2Uw3dBQmGJu0KQhC1QtuzCnQw+rek=;
 b=SbVKt/jxSSt9iFUmQpODxQyqF3swwlYkSJyCaD1evF9zpPQTYh9O8KoXizzkRmCm+YFF00kzDbSr7ZUtLXMAupbykbXnYATaD6yyTrbQSEmIfRdQsm1rpx7pgG/t0qlvE7KpGUKcWKDgiapZEKqLUIHO8F5+K0MQ644n2D8zNzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:36:25 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:36:25 +0000
Message-ID: <fe080cc0-34c6-490b-a7d0-87c6a89d397b@amd.com>
Date: Wed, 10 Dec 2025 08:36:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cadence_qspi: Update the delays for flash reset
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <3fd0641a164a4d628fdf28a94771829f3bf9cb0c.1764181308.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <3fd0641a164a4d628fdf28a94771829f3bf9cb0c.1764181308.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:303:16d::21) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dc2deb-e44a-4302-ed3a-08de37bed28e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djFvQUFZWjk3Ui8zSVNxbnJRYzdWVVZzSzZxNmpFTy9DbW1iWDBPWE15azJ1?=
 =?utf-8?B?MmFLNVBZV1R4OTcvREdWenF2RTAyV1J0MVQ2QjBSdDhRY201ZGJ2em50QzFO?=
 =?utf-8?B?UjcyWkFRLzh2eVJIbWxBSXJGczRhUzJNbjl2YjhGd3NQVnkrWXlVU2tpU3J0?=
 =?utf-8?B?SjlOYm5GOUNiekgxRnRXTkE4eFN6d2JUaU5sZXIyTC9yQ3ZRcEs2aWtBKzZ4?=
 =?utf-8?B?NEsxQWNLMW5XYkdQMnV4VXE5Nmh2S2xUK0I4eW5JRUEraWlVSFlGb3dRcWhO?=
 =?utf-8?B?U2lONEhrWTBKelRUNGljRmIrL1RYRlNXRjBJWnZsL1JoOXdBOHNjUWw1UFEw?=
 =?utf-8?B?Mk5oaEdqK2ZpRFEya0JjaE14N2duQ1JxZ1dNWlFEeDhQUjlaMlplaGtGTkxu?=
 =?utf-8?B?dmhHQWhrQ2YweVV4bWluUTl5djZxYmJBdHUyUDNFMk5tQXRpVzlHSFQyUk5o?=
 =?utf-8?B?OTlNN0thRm5VVDRsUmRYMmE3K3FmRWUya1hRRlhBc0k5NDZNOHp4T2JsNTlD?=
 =?utf-8?B?UjJSYnVTRlVVeGJPT2ppUWN5aTBmQUxYWVkwSkplZ2ZvUHdESlpvZnMvbGJ6?=
 =?utf-8?B?ZXByMis4T0VrUVJXSlFJQURWTHZ0bml2N2VHQWVLUGhJalVGQWxiZHliczFC?=
 =?utf-8?B?TlBsTDJPYTdxMmNmVFZLNkY1V0Zjejc2MExIcS9wRG5udnFVMUVxRG00TG15?=
 =?utf-8?B?Q1FrQWZGQkUvR1hVQytFODYyMmVpTWJ6NXlSbi9ydW83SlRzdG5wbmREMGVR?=
 =?utf-8?B?a1I1REVBT1UzRFQwRGlxbjlHY012aEJxSGZpeFdBVkV5SktiMzFiWFlJOWpR?=
 =?utf-8?B?SjFqbyswalJXQ1NZQ1l1SVR1cVNyZSt2Y2x5U2tQTVFvMmxYSmxJSGVueVBr?=
 =?utf-8?B?S2RPTGFlRThDaDE3UGNxbEQvcUh1YzBDS3F1d2ZtalRkcHRhdDAvVXk3b2ZK?=
 =?utf-8?B?bGowS25kSnJrcUdhek84OFZFblBzc3c3RnkzS2RuTm8vUEdsR1JrRjlJTnV0?=
 =?utf-8?B?NUJRdjJBeGdEQTdlK2lERXVmd01RNkpIdlc4WnN4MFNYbVgrTHQwVHQ1aTdh?=
 =?utf-8?B?VVA4OE0yMTNyckNtcVlSbkNyZ09CQXNIcjZiTTRLWCtTVUYrL3RWU0tKQ1p4?=
 =?utf-8?B?OFN0cEhKem1jNDFoak5aMWRoL1I1MnM5TFEyQVBXZ2UrSVNqMFltbmFqM2lJ?=
 =?utf-8?B?aWIzQ3ZvYTE2ZVBLb25kUWoybGFCVEpjcE9odWVVWmlERmV4UnpSNTNqaTZ5?=
 =?utf-8?B?dXMxQ1Brc2xyT051NllycXlQS1Zoem54MHk2ODc3bVR0YTdScFVyUzRLejdO?=
 =?utf-8?B?aEtsYU1BM1Y1RlpKNEw4aTBSVjVWOG9aMHhJQ25LQllZWTdTOHdad0pMQkt0?=
 =?utf-8?B?dXY1bG5UUEhZa3hFalpZTlNsSzd5ZFJWSlZXU0Z4Qk1zdVVYc3RmdHQwb2Nk?=
 =?utf-8?B?YWJDYnFIcW9wdDQzUTBqTkJTR29qQnVIYmdPWG5jcjBzUGFIbnNEcTk0UVNK?=
 =?utf-8?B?VVJCYlNldkZuMEY0ZGIxSDRwa1VsZjZISDFKODdtdmZBQlF5c0RFQzhEQUc5?=
 =?utf-8?B?WTNjMGFsVGN2NithekI0ZmttTGxzWE96cHQ2ck9DbU00VnVrYUJPWkh6U2FY?=
 =?utf-8?B?UlhYQUtpZFl3MmtBblVyNTlGamYveHJabXJmQjhqeEx4YldyMmxZZDh0a3Vn?=
 =?utf-8?B?b0ZEeTVjT0NPZHV5b1QveUVmYXNPUjVhK2NhaUh4VlhmSXpNWjFkUy8vbWxQ?=
 =?utf-8?B?UjE0dU9VY1JBOWlvam1McWt6V0R2a0ZUMjFVb1R0M3BsdTZES0xxc1dhb3RE?=
 =?utf-8?B?QUtRUVJpWEN6SGo5ZVRFdTNxTFZRVDFQaFBaRDRVTHFnYWp5bFZBWFJRVnJ5?=
 =?utf-8?B?WStEREt2VTFlcFBmWFMyVG5jNmRGcmVuUW5tWlhYVTF0bHNJVU1oQldJeVgv?=
 =?utf-8?Q?9JUy14SSPcR9D5okn5AN1pUgVgVmK8oq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUVIZTY5ZjBtdUphOHV1WDJXOUE2ZkJGWmt6anREYW03eEZNWEpLV25lSGZR?=
 =?utf-8?B?OWtoNXFKU3IrcFJ1Nmk5S04yTGVYeHp2S1cyVUxmTW1pdmRsbHFSZUJLbEFZ?=
 =?utf-8?B?MUlFSHNJYXB5WWQ4TFpFQ2ZwSFVwQ0lxc2QyODUvR3gxSUpaM2tVYkMwWW80?=
 =?utf-8?B?TmljVnFPcUZUZHdmWEQ1d2ZMOUFSODUvV2FlakVYcllSbGZMSUNtN3dnK2VD?=
 =?utf-8?B?cXlGNkxRejNvdEgvN1BYbEZhVkdiOXAxcHFsVlRQb3BHa2NUc1pnamY4SmUz?=
 =?utf-8?B?aTBkZTRWK2VQOFNKVjdZay9iTWRqdkF2N2NZRTZQUUV1SElqMGowL3FKWDV5?=
 =?utf-8?B?ZnEwaGJQLzlsdUliaTgrOTdXR0RrOFBTc21xU3ZCZXNacGZ6SEQ2SlJQcVIz?=
 =?utf-8?B?NFBLbEh2WlVqYXdjd2NVYk9HR1JlSFJ0SERtN293dURWeTU2THpUcHJ0Vkdi?=
 =?utf-8?B?UTA4MmZnQnpVSWxhdHByUFUrc3B5cHRPUHloLzVwY2pQRW52NC9rYTJZOUxx?=
 =?utf-8?B?bWlYWFF3SnFiTi92YUorNkVGbzJqRUowRDM3RVZkZit1bTlKOWVuZXpjdVV1?=
 =?utf-8?B?eC9QSGloWW1nTEJ3SmNiQ0IxUUpuWDNFa1BjNDZxYW45am5OdE1CWUtqY3dw?=
 =?utf-8?B?SzZiSzNtMDIyYjBzM0d0bXBRZWd3cWdSeWtRU3Jjdklyd3N5Vjc3UGhXdVQ5?=
 =?utf-8?B?S2V2VEIrQUxveW9PSE1BN280Y0VHS0N0ZnRjd2EvRVRiNm5na3Y4a3E2a1Rq?=
 =?utf-8?B?eTU3TFhqc1VJdnNQUkpTczNFL2N2eEVIdExZUFdBUy92NVpva3dBOW1pM04y?=
 =?utf-8?B?bmlpQmx1clNaa3V3ZFFtUlRuQ1lJcDlDc3J3cWpXS2VoMUdlamtKOG9PdTlO?=
 =?utf-8?B?NmFCMUw2cTc4ekZyU29pVzkrT2dvNktWSzlCZWhwV0NETmk3S3poZWY3WGhX?=
 =?utf-8?B?SW9tR2pGbG00dEhSVkFSZnRwcWExaCtxanJFNFdJVVFucjc5TVFNTFc4ZEFE?=
 =?utf-8?B?ZERHVUUybkZIeWlNQVp0bmE1bTVrSnZVTHJKeXRwKy8zbjU0R0l0Nm1pWXBS?=
 =?utf-8?B?aWZ1NjVRSk02eXNkWm44YkRBMm9LeDJycUtlZGRMcnpqTWM3SUgvd2xCUFZq?=
 =?utf-8?B?dzBiQ25xZURNeXhSTU9ocnpPTkFobExib1FHMzNqOVlzRGJKWktDcWlxclJ2?=
 =?utf-8?B?VmhRWmVYWGUrcTBtTXBmWkFSSmV5T3l1U0s2MFZHbzgrNjZ2N21peUlOWFZG?=
 =?utf-8?B?elgyNjJPLzJ0cjJLdmNMcm5rZjM3L3laZlZPN3FEaDJPVkYzNGQ1QzNYMnhy?=
 =?utf-8?B?MVF0WTE1WHhGOTFKckcxNnYzVThWbHlNU1NsOW45Ky8yQ2h3QXk1U1FLdGdh?=
 =?utf-8?B?WDlLMmUrZU5ndUtxbDdKcC8zOXpXWklvVXA0ZzdmQW05eVJYYlpIMXFDckZR?=
 =?utf-8?B?cjROdE1hUEo5WjJrOVlic3AvdTEzenRrRHV0bHhMY2prNGVyWWdyNk82R0t0?=
 =?utf-8?B?QnUzNDlLd1FjZUZMa1dNNGtKNTJVZ3hSb250UVFLSi9kUnErS2ZQWUV2MUwr?=
 =?utf-8?B?TVFvR2RmekJaZEg2akNvQ0J1Q0dtVkRWeThzMjFxNXQ1ZlBTekZBUTdjeTEz?=
 =?utf-8?B?eml4ODNRbHlrUVdneUswbUN0WWNnbGU4TWdXUnBsNk9nY3NDcERWZEYxcDZN?=
 =?utf-8?B?MkZubURVa3JWNVFmNC9JNXoycXlEMmZxdnFTSjhBSUpxWVh4dXBVNkVJTGRI?=
 =?utf-8?B?bEJoSlJFSEZwQmVTQlN0SmFjUmJHTFM0NGdESjduMUdNTHE0MnVCdUpxb1hh?=
 =?utf-8?B?eDhuYzVZejdkNGxFelo1emlQNUJYL0ZOVFpBWDFZYjUvRk4xS3J4cWprenRB?=
 =?utf-8?B?aGw0MzdBYkFibnNXNkl4UmNQdXIxRHloL09CVjZnN3Fiam9lb0c0VTJ5Y3or?=
 =?utf-8?B?d1FuTVRzQ0M5Tkozc1VXN3g1SHdUeXEvYjlyeGNvZUg3dHMwNDBrOXQ5ZnNl?=
 =?utf-8?B?YkovbUVQTDJKZ1hCZC95dTJIeUVXa3lFUFZZRlB0N1doUFR4bTMvY3BPQlBh?=
 =?utf-8?B?bkp1eTIyazh3YU90ZVlMeHBPRGJOS3BLUGM2Ymx3SW9aOXBqRWFLMi91dDF3?=
 =?utf-8?Q?oP/JyqBAVTu9dR6wGUdMeSEe0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dc2deb-e44a-4302-ed3a-08de37bed28e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:36:25.0207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wguS/HD9CA2lt+pByfSaKQ1v2IizIGqFxpMkL+avoHa9bkCizjhCSc4TRhSPBC0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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



On 11/26/25 19:21, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Updating the delays for flash reset in the mini u-boot case.
> These experimental delay values by looking at different flash device
> vendors datasheets.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/spi/cadence_ospi_versal.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index 0efbbf56a5e3..e3ddf127e5a8 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -178,15 +178,15 @@ int cadence_qspi_flash_reset(struct udevice *dev)
>   
>   	/* Disable Tri-state */
>   	writel((readl(BANK0_TRI) & ~BIT(FLASH_RESET_GPIO)), BANK0_TRI);
> -	udelay(1);
> +	udelay(5);
>   
>   	/* Set value 0 to pin */
>   	writel((readl(BANK0_OUTPUT) & ~BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
> -	udelay(10);
> +	udelay(150);
>   
>   	/* Set value 1 to pin */
>   	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
> -	udelay(10);
> +	udelay(1200);
>   
>   	return 0;
>   }

Applied.
M
