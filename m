Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EFDC5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 13:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E24C6408B3;
	Wed, 12 Aug 2026 13:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TE8H_Lz4raC; Wed, 12 Aug 2026 13:33:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01030408A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786541631;
	bh=p4hCvjNSPwknZF/G7XBvmOdGIwkgoh8zgSGte6ob72A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KStDYxh8uNM1xOWS5wpbdiO0gdsG99fGA4QlJRBVELQDDm9SM59SRHh863nQgZqog
	 o/1WKdiQ56CjTVJYhZzLqU1l1D8F1I+7HU3cMMBwwQon35ZPSi9YGG3YSMH5Wxw57s
	 1kvlxFRzdekwa83QASI7Kb5KF8b0tnmZEBYqAe//9d6VVABsk/FenngRBTUsnBFgEl
	 RbG0jEg65levS2fgZhQlaTVvceyq5h/pShDyqMf46l3NumEkTQihGP4vTxtcl3RvAb
	 53wIMxPSNoiLRBPb9ZwMry22zpjLa516/BRtHvABFkpUjnqnmk5PPwJCmyPFcBCC3n
	 4F+6uzoa428vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01030408A2;
	Wed, 12 Aug 2026 13:33:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 760621F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6767C8125A
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SulPTKH2LOYR for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 13:33:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2552D81259
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2552D81259
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2552D81259
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H62CNDxi2ZyBrjcxV7LEpiQLBCnPrZ/bdCDxOe8ebsGPUSYc9viN0EOdT1GObVj1VYVtPPrOJI3zoSlpQRzHvDb+GUJqt/CrCHcOQMmqcE/YP3Ia/G/LV/L2yEK6iqzOj/GOH8jDYnj07QwFCGuqO4OP1q4pAib+KO4aNbN0eEuVPbIraiKcB4C4V4k1amuL+yix/uleMagfIHgGnSgUDRVAvZoNXSOjFcMYjnGfxSGcMTzo6IWj9Zz0pWbgxwUkgksa6mJ02lZ/GppI+GWOTnhwTp1GO0nO+Xgp0hgdJ6H3HKflEHL15JUB8TXanPyWJeGKDK7QS/qdrWg7dbXNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4hCvjNSPwknZF/G7XBvmOdGIwkgoh8zgSGte6ob72A=;
 b=ektlVUKqDxGsvmiXw/H081f+2KMsl0RSWhY/BfTcNDxsXbZao7KGVquT2Sogyu8st3OXNdGXcrFS2cLNtgf+Vx8UhpMnCcDdXGo0urk5W99uvJ/1i7G69Ici10kGJ32wRp5OnxNaGHO4jKmAkYrPJ87YjbeXlhAbiYPAS3y7m8eUvWJKND2u3d+hj+rtGoDOZ1oaTiN6xAmBvAOTGBqu9TibrwcleO4nb5tqgDOo12aVIa1vuuPxdlS6jI0nnYi1NthEKSraEb/3HJcAaNS0OMq5oKxyvMqSEoLS0+kur6F7DevenaWYi+L5VattpfMpYdqgCoWpYO8zEqlj0mbNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 13:33:37 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 13:33:37 +0000
Message-ID: <d0bd0863-e094-4b82-9635-6798960a08d0@amd.com>
Date: Wed, 12 Aug 2026 15:33:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
References: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
 <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
 <f71ebcbb-6cdc-4c07-8d1e-0f39ccbfa141@mailbox.org>
 <5ef6b6eb-5f90-47cc-8c87-872c01eaf3bd@amd.com>
 <b3e35156-e1ec-4be4-9693-df16eb82016d@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <b3e35156-e1ec-4be4-9693-df16eb82016d@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5bfac8-6dc5-4285-b030-08def8765098
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: DmuiVJyl31YswgYz4VyTxHUC2d/5M6fE7RL4mhIZf0VIdAsIdwfrlQfpXVeuzOF3Lm3dDEtr/GZHN4FPkpsUfNnMPhG8EEyHBEdkott6+3HioAMuDNzP3E5DFFd6OfrFUNk9V6+480UadA2yEmHo76eODcz40TFQcx/bw/Sw0VWBqJdu6sRoKuC/CkXX+wcGWDuAd5RgGfGe8GXBFEYl8L9/fkDhSZK49VP7vk3JTJoOjonB5iIZaSDOpraEhDy/clAlA2r6QA55KE4vnJDqVJRuR6Hvl4ikEyCILPlNdjjPU/x7NEBJFS4B4TQ+4UuMwgLYyyBl9i5Pu+4E48T1G7NvhJxAdVtOYSkq8iVLHO/SXwliZ6cg+VEpJe844rLaFvqbfAmsPj2Fu0ZjTsoK2frIwiekZ4I1nyaFSJSWpfDeharOPnM63eUexxpDGKC5MdnTUBZpTgJ/D01bY9ZFnwMFxS0DIpX4AV7CL3P8G6oI+ZeV/0T34s1h/cRgGPriw6jABerxru8ii0LIupbWToKtdjb/2gIOS9R4Te2zTqSELKA/MVA5zvK2zJ158KrMn0ffUbX6Zgnu0RAmlo3Qwx2Zs3N5ZqewyDHut5+EES8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0d6R3JiNlphcGpZakRPcXowT3AvVitCU0FSR1FNaVEzaWtqUGZBVzVjRFEw?=
 =?utf-8?B?QW5oazdCVk52M0w3SEQyZTQ5cENMQmc0ZzJueWM5bTNWSE5VQmdnUjVLTzRB?=
 =?utf-8?B?a08zYXJnSkVaU2ZYKzBvTzk2aHNGaXQ3UGpGTGJBWDYwM0JIY3JZSmM1QUhw?=
 =?utf-8?B?dVFIQy8rditVeGR3d1RPdkVFd3didmozMGZNUVlhTVUwYmhpenk5Z2o4eEFr?=
 =?utf-8?B?dk5raHh1clJtRmE2NGxqU0NXcmIwWE9qbXBzSlQ5UENzcXFXQmVJVWdJVjFa?=
 =?utf-8?B?aTNacjc0VThGU2xYV2Q2N1UvSHdLNHBEenloYU5IbkFBQ1VnZFJpaWp5SWRu?=
 =?utf-8?B?MjdnVmFob3FPWU92VlVDTDcxeEdJZHV4U0ZDWHBmNXpONm4ydE9qdnNsRVhM?=
 =?utf-8?B?a0srUTJ3WmRTZUxqcWIyanlwLzVYei8vaHRicEJlK3dyTWtFeU91cnVmZlVW?=
 =?utf-8?B?cTYrMmpNY2xOcFVLd3dBbWUrOUdWM0lhZFZuUENSQ1RkeloxUGtpdFZuVWJE?=
 =?utf-8?B?WnVzSHdnNktZMkI2MEVJcFlIVFdXNTU4SGZRcGx4dlBTM3hacVZtb3hmMHlj?=
 =?utf-8?B?OU9FQ3FBcUZ1eUxySHhvOFRIYmZCcXBEVEVveTRGaVQ1K3dzWTFFZ0drb1Nl?=
 =?utf-8?B?QnpkZTJwTW41WlZiVzNDNVpjaUVCNmJrb1J4NWdxdVd6YU95N2gyTEI3ZFlM?=
 =?utf-8?B?eUdNakFMV0JZNFZyN2czMWVsbWlYTE9Ga1hhYmRFQzN4YlVjMGNaSk9jQy9l?=
 =?utf-8?B?eHRJMW9WMmphdWhtbWNMUkl3WVlpcEtLZnA1M0Q1OTB5dElPMnhSTlN5bkRi?=
 =?utf-8?B?M0kyRk1sa09DdCs4QzRNeHVLb1hrS3RzclBZMTY1ckpwcUlhOVVSdmRNQldv?=
 =?utf-8?B?ZTJaUjBXWnFxdG1tdGJvTDM5bksySVNGK3hia3MrQU9Oakl5V25yejJDajJp?=
 =?utf-8?B?aytrdFViYTM4ZW94VlpSNy92UUNkTndGZStkUERabStLRkIxM0lHVzdLbUxi?=
 =?utf-8?B?WXl5SFlSWU80M1JzdmNPd0hqR3ExMXVZZGRiUVU0VWJJdisyRHRrZ0tORFlN?=
 =?utf-8?B?UGY3OWVPem1lUlNGb3BmU21nWlFoTzFvMFV1aVRIL0x1YWdRUy94NG1ucWIr?=
 =?utf-8?B?aGtVS3VMZEdhUnBoTS9FY21sdDZxRDVqMHNzYXAxQWl2TU9rUG93MWlNQUxJ?=
 =?utf-8?B?NkpJOWNiTDFJdXVqb2ttalhsYmFoVmg5aThncm5jYnZGT2FRbDE3Z2VCdTk0?=
 =?utf-8?B?N1FkUzZkSGRKdi9LMnQwY2NrZ1pwSno0ekE3Y2thelo3Q1dwTEg4RGtOUFM5?=
 =?utf-8?B?b2l1VjBOSlF0UjkwMlJwcVoxZjhxQ2VhM0svMDI4a2lVTjRlTHhVRHlYeHJ4?=
 =?utf-8?B?UlphMDFLc2pQcFNnbkhqY055TTFUY3N3ZWgyVGFpQVd6VCs3cStuMGo2UXd2?=
 =?utf-8?B?dENaa3RGak5PZTE1SkxrOVgwOGc4UFVUTkc0SkRjRzducDdzdXJ2Y3JzYkVU?=
 =?utf-8?B?UjE5VHZMWjl6SDVsOHQ0Z0VMVUIvSWs4MjJNY2hNcElXY2p4S2FVMEVaQjdI?=
 =?utf-8?B?UUZDdUVkN3dKcEd0K0FqTHZMQXNVTTVSSEdjWU9ncUhmM1BEZXowT2EwcFNx?=
 =?utf-8?B?bFhXaS9OT1BLVWR1YXVYMmhZQ3BuVHV4M1dONW92d0dzTEQyR09yRTJRNDMz?=
 =?utf-8?B?Z0RnQUkvZEJmNHNaRXZJNkhrSmNReU9LYXYyTXR5OXRZVmxjMlVMRDFrZnds?=
 =?utf-8?B?TVFvK1R3OW1GbG45ZkVqSU9nZVlKcStydnJzMjBWZEsxV29Pd3NwSCtUZC9M?=
 =?utf-8?B?NHQ1UjAwNjgzZzBnVjArbnNWZzBKU05BaXdrbDIzK1J3eDMwUE43UEpFUldT?=
 =?utf-8?B?UzBEMzh0SzBmRzhXc0gyS0N0YW04NUVackQvWHJmT1RLbjVLcmdXcGEzdXFB?=
 =?utf-8?B?ajR6aWZVZ2VvNTg1VVY1dzBxei9WNHRBemlvV1MzWE1rM25RblpuN0I2NVFZ?=
 =?utf-8?B?UUpxQ0phd3ozNjFiUnVKYnVEZmVhZzF0M2ZlVjkvd1pKMitaK1FFdmllSHJN?=
 =?utf-8?B?Rkg3Q1hxOWo2em9hYkx4Wkticzc3bSszOUgzeXdPaTZlRFpTQWlzUm0zTmNW?=
 =?utf-8?B?SjQyWXUzcGVaR01iSDgzMlJLYzRxazNjbER4U1RSUTRpbFlBSzQ2cnJpcFhj?=
 =?utf-8?B?Y0R1cU4rWGI5eWJHbFlKSS9wbFpSUWZYY0wrM01sWTZXWUh0Ym1OSW9jR3ZX?=
 =?utf-8?B?RXQwRWxhSGduSFVGZTlKRnI0QTRiamNGdTNjZFZPcGloUTNvODVycnkxZmhX?=
 =?utf-8?B?eTJnUmN6Sk5OdWt2NDdsa2Y2MDhQVGkyaVRONi9FRW5UVGJ3ZXkxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5bfac8-6dc5-4285-b030-08def8765098
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 13:33:37.6895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzGG4q9iDXIOmnyuyUWtD4zDFjmCd7NREUmsCpVALgTsZ13x9ujg4ZdiC3SVNUlI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4hCvjNSPwknZF/G7XBvmOdGIwkgoh8zgSGte6ob72A=;
 b=rRSiCzdiyrJeRoV6WtDlNyZfBG+CZWYKeDKLw2yTXyPRKsf/t0O6rMd5c0CXAcAbADe18GBgtweuHGkYYRLK2mwEqF5YlZLRWAc34nUIM6rOsacgyeq5oDBwDRIYTei4uS1kEoTRsJWe0i45vnimLyqsVMDOf05/Vs/GlVY7uWg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=rRSiCzdi
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 8/12/26 15:08, Marek Vasut wrote:
> On 8/12/26 1:28 PM, Michal Simek wrote:
>>
>>
>> On 8/12/26 11:11, Marek Vasut wrote:
>>> On 8/12/26 8:35 AM, Michal Simek wrote:
>>>>
>>>>
>>>> On 8/10/26 13:37, Michal Simek wrote:
>>>>> Versal Gen 2 and especially march-versal2 is not covered by own fragment
>>>>> that's why add it.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>>   MAINTAINERS | 6 ++++++
>>>>>   1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index e1379a6a3e7e..eb48eea55c5a 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -821,6 +821,12 @@ F:    drivers/spi/cadence_ospi_versal.c
>>>>>   F:    drivers/watchdog/xilinx_wwdt.c
>>>>>   N:    (?<!uni)versal
>>>>> +ARM VERSAL GEN 2
>>>>> +M:    Michal Simek <michal.simek@amd.com>
>>>>> +S:    Maintained
>>>>> +T:    git https://git.u-boot-project.org/u-boot/custodians/u-boot- 
>>>>> microblaze.git
>>>>> +F:    arch/arm/mach-versal2/
>>> Use "N: versal" instead for the globbing match .
>>>
>>> In fact, "N:    (?<!uni)versal" above does not work ?
>>
>> nope
>>
>> Before
>> $ ./scripts/get_maintainer.pl -f arch/arm/mach-versal2/
>> Tom Rini <trini@konsulko.com> (maintainer:ARM)
>> Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:ARM)
>> Michal Simek <michal.simek@amd.com> (maintainer:ARM 
>> VERSAL,commit_signer:14/15=93%,authored:10/15=67%)
> There ^ you are , what's the problem ?

Yes, I'm listed - but under ARM VERSAL, which is a different SoC family.
Versal Gen 2 is a completely different chip with different features.
It only matches the ARM VERSAL entry because of the "versal" substring in
the N: regex, not because they're the same chips. (FWIW keeping "Versal"
in every new SoC name is very confusing).

Also Gen 2 specific drivers/files are coming, and those should be attributed to 
the Versal Gen 2 not to the Versal.
Creating the section now is what makes that correct - otherwise every new 
Versal2 file silently inherits the Versal.

Thanks,
Michal


