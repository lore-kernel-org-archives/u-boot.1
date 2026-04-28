Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E4DFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678648460E;
	Tue, 28 Apr 2026 18:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i17TyfmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6DF68464E; Tue, 28 Apr 2026 18:16:55 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DAF8460C
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoZfd6AJrL8U+rr7Aiz5EzCakZmWTlWXAbKcpH9eaMlTGX6KaA8xYO/yjw8Aq/jzxP0jwaAJoJlYlZbk2SyDhS2RmKgb4wdkCeEY6uNMohHBVwkjFGfFn09Fn5D+5vZV0vxIxzXo+CX8iGxignDaLNqwAOTHLboJ3zfYmZNNUhdJFr9z428DFKGRDe5FmZgVvlsoSmNrf+okJtWhXsdz6C4ix36UEZENLP+EmaiAP/IuD1WmkvCM6sfMKm4IoDL362Jv8bg9H3OZHnhkA9wkGiUYPfXVr2PmALOUH3CWW0+x8zqJU8rBX9vD8zTMdKC4Qc1q37r3TMVh5APzYAaY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6QRwvEylQgHTGCWzpKVSG7eeT+IQFxIursQn2FzAnc=;
 b=Lgh1Gqami2d6g8d2rdr21n/edMTBaQQS2oxovNxbPK88KikDm9NGAH5QJCfgSahMfl6G/cZcn9kv68DONpnW2bTrbN9DkJheLegURQMtOccU8b6rGaRp3jfXXXy4x0fnJatEeWs8BbmTNJZgup0o1rfS/8ESzr3yaof8LdjCGJAOIdMI6y/hEkY+pKpXh716biTys40XTjeNkBnH8zes6fU8TZUo8+n5a6npccX/tFafVx4HHOnZFZArM+O04Q++fFrXmAvBM4KE05ZQj6Ej6JDWQdiL86eyyrZif8BkQoG5IQ8bpWzvFsElgInypWj0sy5Qa0w7K79jkanMd7zEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6QRwvEylQgHTGCWzpKVSG7eeT+IQFxIursQn2FzAnc=;
 b=i17TyfmGc+7Gc2bb/VPVkIeIbvkPAc/OJt0vwx4THahZYno/fk3+77x18nCNEnIWHA8MItI0s+wKqZAPatlZR6cNBKlUK/k4/6WVyoFyzLJT1aSA9yMgInwhUd3asyCWBePbblJPCadzOp2NI/orX4EVHhbAM7+lhjd9P+E7lIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB10919.eurprd04.prod.outlook.com (2603:10a6:150:201::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 16:16:48 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 16:16:48 +0000
Message-ID: <a2c89eea-b74d-43d4-b2e3-e2a80875a2e9@cherry.de>
Date: Tue, 28 Apr 2026 18:16:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: wget: validate URI for lwIP
To: Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>
References: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
 <fcf60081-849c-420e-ba7f-fbaed44ab108@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <fcf60081-849c-420e-ba7f-fbaed44ab108@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB10919:EE_
X-MS-Office365-Filtering-Correlation-Id: cf24cfee-cd19-480b-d98a-08dea5418c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info: h2QHoJoQAuW1porHIm8bV70Wtcsxi+MvIrtch8QEfQ9sKkLfy03izoyoftngT3h9iRY4hUnH01kutL/ZMHAxns9TDHPM7guEY4yksTVRqyGCj4mhXTmGLGtiiGe9djKXiB+BzNyV6pyb+SjvEg65YC65H5yBhpcOuUJBkp+RWGp4COlH1UoqTp1jOfXjgrNHTZY+ZuPeKku6wbA9YETlWviEDWVz2QPjDjuJc8lMRJzg6lGnujWMgE42eRDsDXOkIaN2fpci7hJBKjY8xynHSGqKSlYdFmmlZqvNguQWG3eRNbQAMtWLlKhYe/1Po8csi4Adji9lYikJpgDa4pSPmDmPM9owh8MXyv9eO2qHRWCCIjpcTlNGIR8OcJQ1ofuSRLSTm8K1GnqwdNUt5hg7AVIDJimTgBDkeFi/0FWH0Uld+ZSylPxbvCWG6UGODDOEE2jMCmZpO/11sKmL9z+zWAuAWNFOy9VLct+XxjnKg1SSghM+ECidzjIeZmtxD5kMuED+rcCrIsn+n//poLJHZddEsOuRchFKl3lt30spg4o3UgEK4dvJuYD+ssprCrr3yT1NHsaLvvr++FchGEnMPISuIQZk+6ZM7d7+xqeCm1W3m0p/PQk4+eO8xhhVXdjO4s0+yk7GCPURUwiVHuoI5Cw1CmECpomwZEQsBHFavWLeINiRY4V90H4ok1ws/mHcuKgC62iVSbpG07NuKirmZOB/EHW2Y2R/M9Qvin1NV6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djJLVVhDenVGYlpnWjJXQkVNRnB5ajdzZzh0cWRnTS9wczA2VGJSTUhEZ3NW?=
 =?utf-8?B?VTJ1M1Z3S1c5S3R3aEtQYnplZWY0UlMwMzU3VjhQK0tRdkc5bDl5M3dtR3JK?=
 =?utf-8?B?dTZKeDNwWUpWSDhkVDRraXIzMm1PN24va1hka1ZGaUFXNzhFMWV0QjIyYitu?=
 =?utf-8?B?RDlGTFdzeHRNVlZXTFRxUXZVSFk0VFROV2RhUW04ZS9DaDJSYk4yanFpOXFG?=
 =?utf-8?B?L0RkdGRzUkJsNjFZK3VDUTZpMGFrUnkyUVRScEczdC92Ym0vb25tQXlXTndJ?=
 =?utf-8?B?ODZ3TVQ3Yk13YjRaNU5wMmloSXdyV1F5UkNhOGpNQitZZ1Y1WEplb3YwVjRE?=
 =?utf-8?B?MzdLVElzd1NkS2l6UzdMSy9udnUxTngxUndVcGpNQy9DZ3hjNDQ4YjBGMlZS?=
 =?utf-8?B?WElDdGxYY1Bka3RSU3BIWVNJcVViclF4VWY3aHFaRkNyY3RDNS93VTBya04r?=
 =?utf-8?B?ekdZSGozZGI1WHNoNTd4dzNxS1UvcDA4c3loUkNCRzdMYmJER2tsUUZGOEFY?=
 =?utf-8?B?c0VpRUJsVENhaHZMNk1pempCMkU0UFBJYVZZT1hBUUp4dVNKWTkyUTVnK0pm?=
 =?utf-8?B?Y1paSExwSEM5M2dnR1Y1Q241M3dtSklRaEc0QmY4NmlDcHFLaEdMMENDdmxV?=
 =?utf-8?B?eU1Rc1dUcnMxMnNPeUhXb3ppbTYrNXRkWmdzVFV5UGo3dEtVNjMvNWxMd3pT?=
 =?utf-8?B?UVNlTTZrQ3RGMkV6VW9QejNnMmtmYndNZmUwR3JkeDB4R0ZFTmM2TklXbitT?=
 =?utf-8?B?djIwcFY4cEJScDZwcjk4UzZzTVZBSVg4ZFVZOWFNbjhqdUx0MzMzZ0xhTlhV?=
 =?utf-8?B?eGp0OWNRRytTUHVPajVxTHk2aXZNV0Naenc4eVlYMzF3UlgzZ2NJK0gveHp0?=
 =?utf-8?B?bVNmeDc4cUcvMXh2VVkxT0R3RnBwSU84dVVpUllDL3NBWVc5bFhGWGVqaHA1?=
 =?utf-8?B?UWovVEtrMTIvTmk5K0ozNHFCVElxOFhIRHFqU3ZoaVVManZHQ1loYTd2eUdC?=
 =?utf-8?B?RTZwZFZhSll0d056T1FZMGhqRHhqOXFDMHpabVRDclM5OTdhc3FaTGJGdS9k?=
 =?utf-8?B?QlNlVzd6ZXVnVjRoMTAzS1p3QVgyRllOUlk1a1U3Wi9YZEJ3MTZXTTNOVVE5?=
 =?utf-8?B?cTNmaHIrR1lxb0Q5YWEraDdMYjJxUFF3U0FMcmpiQjV3cG51aWtkZ3NsYzJh?=
 =?utf-8?B?NUpQQmJxc016SHAzL3M2MVNhNmlZaFJvMmp1c3ArVW9VTFIxZGJhVkRNV1A5?=
 =?utf-8?B?VWdwWTB0d0dWeXBtZnlPM3NNcFdRU1pGWERHVEZIWjU4czZNQ0dzMjFpella?=
 =?utf-8?B?RU85cFZhc0ptc3Q3SDBmNEQ1QUQzME1SSHdDOHdQYWQwM3hmVWtHdjBRVGZv?=
 =?utf-8?B?eGJ5cDNMY3hBU1lRU2daZXRpYUZYTUlqeXA0QVBHWVpvR2NEREtvMUozYVNF?=
 =?utf-8?B?WGdaNVJUMTlqVDVvWUZLcHZhLy9oQzVwQk9wdTVaUzEya0VkQTVITzlyYVBM?=
 =?utf-8?B?d1R0WkZBME44TXVjeXJXWit2SjFRZ1p3Sit4QnFUaUpnc3p1UkUxK3pQODYv?=
 =?utf-8?B?ckNKNW1FMnpnLzdFZGlJM3ZhQ3lNdXJIbXlPeXk1dHlYVEMzYU96QVVXcjdt?=
 =?utf-8?B?ZFp1b3FJT0pIMUlETFRpWmZWeStNT1hrQnp1c1dJVW84eFoySENkNG81SExu?=
 =?utf-8?B?T3ljbHE4bVI2RTNBbWQ4SzhpTmFPdS9YZ1ljNjBkdmY1RkU3MXptaEVkZExa?=
 =?utf-8?B?NW1UYjcvQzVVbFZFUVE3YVljUityNCtsT0QyaWtIRUorY2R0dlNQWDVwWE5G?=
 =?utf-8?B?TWZFa1h0QlJQR1FIWWYvVU1CY00rbHd6dUFXQnVCVVMyaXBtMUZKMzduM0VN?=
 =?utf-8?B?V1JiL1F5bkJSZFVjU1o5MUwwTkF3R2tLazBzbzdtRjFRbmxOT1dzRWIvb3NR?=
 =?utf-8?B?ekRHNDR5NHhpSWE3L1RvN2J3dUd1YlBlbzZ2djlmWHlYREZqa2RYN0xmdno0?=
 =?utf-8?B?RjFVOGpjZGtqdmlCTmZFTWgvcDN1Tmp0NjZybi83NGFZWFhqOGxjeisvMklI?=
 =?utf-8?B?MUJaaVJyT2drRWUyc004NWRrUVZpMjZtTWZ2TXc4aHdvY3pXU2RYeFpWZWhk?=
 =?utf-8?B?cmFDY283a1hiYlJvMmtrYjFYK2lXZUlDVlBEcGNjYUZHTWxDNllOdmpTcnYy?=
 =?utf-8?B?WmErTVUwcGRaT2c1SzJoRk13ditMMDVYZ2hSWm0zY0dsNm1DK0lhUUlWbXE1?=
 =?utf-8?B?dGdPSzJyUU0yN3p3Tmczd2tCREMzbnFHVTd5bHdnYW9pWDdlMS9Rc1FpaDFY?=
 =?utf-8?B?c1pqcHlqZHVweDBCa2cxTzZhSUw1MGFNQzFBa1FMVC9rRjN1dFZabDhBQ2t4?=
 =?utf-8?Q?2RHSgJqi0c78iXiEfqZYXsz/AUBucC1YEasKP?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf24cfee-cd19-480b-d98a-08dea5418c99
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:16:48.5923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWQCR7JDG6aE0WRYAWKaDQjSXdR+dZZ9vs3xt6wcM6/x3mZ64yVwVgfsGfr7tl2O1ytsGMtmRzMdRD4OcJ7X/BN7gsfqe2LRKmCCTiW66wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10919
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

Hi Marek,

On 4/28/26 6:07 PM, Marek Vasut wrote:
> On 4/28/26 5:55 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> We've had wget support in lwIP for almost a year now, so let's do *some*
>> checks in the form of validating URIs.
>>
>> The other test in test/cmd/wget.c currently requires structures only
>> defined for CONFIG_NET_LEGACY so it's left out for now until someone
>> ports the test to lwIP.
> Maybe this should be an RFC until it really completely validates the 
> wget command ?

We can already test something, why wait for everything?
