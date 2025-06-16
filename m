Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC89BC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6FB81E18;
	Mon, 16 Jun 2025 09:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OMlGrw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA6882063; Mon, 16 Jun 2025 09:12:35 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC7F81E06
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzhdQO8jIrFZco/QRUMiKTJizoQvICxpnDOfe45BzTdStbW0nIKGWegFRTYgzbW61+8V2hb/WG6yUDvcYOqoKgeFSZaw4gP9mMMal71THUJafcWK/No/CxIi+57Bcg0CJiza4R6xdQhii2A6vkca5UcUtLIhwGE1ocacSyN2z2Aw+WWgc1iPYjRTqnpdyEg123L5iHtR2LZXlNuI8UL7frbITwZBmr+XxXHdimfBbE4qVGKhvzfHmXGysI4LcVYot33Y4YujVnYmpuVepbTkkFIiORBkhG2Y5JKwPX53nlzMGCAdBHbivAZGPA4qpryGv169MFBpKK4PljhKMr1Iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/lzfUy9twC0xhX0M46ZtJFfygpoG6eYAnkGQ0YqhiU=;
 b=XqDkiRBodd8nedXpHgoCjzfXKPEv3653z4kjeJAI/+EZI2ZWH0m/cKUFXImHz5NVlF/YG1Arwthxhx79eIaHoiFG/uYJ+Xkac7Mz5nbgn/CHBpRtzBjJlDW7Wrj40SfD6LZrytm1q2NMM89VICq80Me2nU+qANbs6cIEUOObXCW/ofwdlDyK+MGDwQZlJLrbw2Gg2V+9NTO6g++rFOBukXz/7a3hAhtmEGpYNHcc9yDJsjaNyCkQE+IhXtq2vS4z6JV0bNDterLqTuir8MS5vnWOAdXcPQRFigUaoIrnrrB4SN+fAK2uaSPRMuiZa0Xs0ou1t2AtNGX6NJZUaXEslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/lzfUy9twC0xhX0M46ZtJFfygpoG6eYAnkGQ0YqhiU=;
 b=3OMlGrw1eSc+bMQ3RAFl3EX8JaNbYTR8VRNyYSz0lDWfOKvKMn5Jdx0nC5dcoDSPM1zFwIRuuEMWhIr2aapu/xhwMwgnjAUj6d9JxfIvO+gSLakUbSIxILhdzbYk17igagFQRg0GgW+QV5amWpniNNTIU6ZgL0F0Tbt3kgTgVRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 07:12:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:12:30 +0000
Message-ID: <6dc35700-9fdb-4011-bab0-ea26174380e2@amd.com>
Date: Mon, 16 Jun 2025 09:12:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: zynqmp: Remove local copy of
 'dt-bindings/clock/xlnx-zynqmp-clk.h'
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250612181128.340232-1-trini@konsulko.com>
 <5e694bb1-02e7-48c2-8b07-35882fff0939@amd.com>
 <20250613142227.GW1382132@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250613142227.GW1382132@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:806:121::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d30ac3-1f8d-4352-6777-08ddaca52848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXFsQ0RNem9vNGRGeFZqQjNPL0t5TVR2WWpzZ1lyb0tNNGRlakZLSW1zcERX?=
 =?utf-8?B?Zk9TbzBpUDRDQWFzWVUxRlo4djVNeDB4TXJyd1dkQmtnNk1kZy9QQXVMVjh6?=
 =?utf-8?B?L0RNMlB1ZHJNNTR1eS90bXRobWRiYzFBcjJHL1lWcG5XeVVWQ1hqZVJyQmlC?=
 =?utf-8?B?ZHM1OXplSHlKYWFlR1FGU213d3hrTkxvc0hQbUlHY3pqbVF0T3czNW9hRTFR?=
 =?utf-8?B?OCtqUU9tYytnRnNuQ25LRnhjTmVmN2tGYnNSVzVpVUczMTJuTmw0L2sxTDQy?=
 =?utf-8?B?VFZYZ2Yvc05ZR1FpOC8zVUo5aDNSa0ZHUzRicXk4TkRUUFpEN0hkQ00zdnFz?=
 =?utf-8?B?c0EwMDlWMVQvL05tT254RlF4cStxbGY1citTTHAzM2VIQlF6bHJ4WkpBM0JH?=
 =?utf-8?B?V2Eyc0UraWpNUEx0NFliRGNXTXV3RDdYNjNveDV2VmhUY1ozZXUrUGxlTzk0?=
 =?utf-8?B?VDdkZmRUN2tBTVZZdHlROTZEek54Q21pUUFSSzBZSC9NcFk2VlA5azVGRkp1?=
 =?utf-8?B?aVc4WTVjTk41N2JBNGNqTllXSGNYVDRHaHN0eWxHdVB1OEwwNDZzdHhhckpX?=
 =?utf-8?B?RjRibGRJMGVDOTUvR2dzNWlvTnRjVi93cHFZb3BycDJONkYydG8zb1pWMG03?=
 =?utf-8?B?N2pQWFlxVkJyUG1lWTA5dmxxeVp0dDliQXFkdCthdVVjakkwU2V0c2hrM2FE?=
 =?utf-8?B?cUgrQTJkYVdKUjNyK3dHTVAwc1VsT0NTT2ZIaVF0SGVld21JUkh2dkM5N1I0?=
 =?utf-8?B?Mk80cnVCY001UmpWblpHVmRNZXBQdTR3eW83V0o4b1Y1a2J6T21tV1p1Q0VX?=
 =?utf-8?B?VUIyYnB1K2JXMVFjY1VkeWRFc2k2cXVsZDc2dGFWelkyYlRXYjdsdldrWTMv?=
 =?utf-8?B?cjZ6NjMzaDFqTHdDZVF1NlBXZU55RzQvZzgzYUdvMldtc3pldHlYdzdGV2JF?=
 =?utf-8?B?MFc1U2tPd3RvN2ZRQm54eW0rQW1RdG45dlU0WC9ITmxpOUk4UEpIOVZYUXl5?=
 =?utf-8?B?bWNtMWJwVE9nVWlqaUE5TXE2WURJQmFRMnN1a09Zdkx6QVRZWmxZY1BoSEdh?=
 =?utf-8?B?K1VuUXdrR1VVRlMrSzFJeXRZU1hCTE14SElsVUZiVWpPNzFFYkt5SnFGTVlB?=
 =?utf-8?B?VUk2VzdxdlhNa0kxeU1RdWNCWk42a3Y2NlFpb2Myc1VHQlNkRUppQnY5ZlFm?=
 =?utf-8?B?NUFlR0JyMk1memFkMnZjbXMrMWRTamdkSVRHeE90QjFLMk0yOS9MdkExVS9w?=
 =?utf-8?B?SnJBcXozdnhteVFPdmFYZXkzcytTK3BnWUxQcGxlQ0Y2akRRRURoQlFDQ09N?=
 =?utf-8?B?eS83TGc4V2J2bEFRb3o4eWFPMkdNTSttV0cwT0ZMdkVRWjlucVFxM3RNL3FJ?=
 =?utf-8?B?NlJVWnAzWXBvVDJpUnoxRTVLVWpXV1NWaHpQZnJhNzFEVU9JRDN5RnRMMWlB?=
 =?utf-8?B?ZDdDYmsyNnVUOTE2bzMrNmwxWGJuSVhTd0dkb1JOOUV2QU8wYUQ4Z0ZTOEhJ?=
 =?utf-8?B?aENFRTZpajJoeWtxTy80Z0gwcDlmWVM0V3dsMzNJRldOQVZxZVpGM0txWlpx?=
 =?utf-8?B?Q1NWUmd6R04yK25KN1ZEVWdMaUNyK0dzVTdzbW9yRXV0bkJGWmpjaHVRd00z?=
 =?utf-8?B?N21VdU1zc3JYVmIwcDZOMW0vS2p5NC92NEpEdGxWRkFnV01tdnFRZ1hianQ0?=
 =?utf-8?B?cnd1YmhTTGVEb0ZyNXl4RXh6T0NuOUJGc0xmY0xrRGV6emM1U3hnUDBiOXVD?=
 =?utf-8?B?aHloNUVTQzZ6czVnV1RjbStlZ0tzdFp0NEJtem43cmNLUVVDL2pnWmlyTUZW?=
 =?utf-8?B?Sk9FSGYxcWJBajFZQnRLL1hPcFdPbGcxcDNPN1BxQi8rMkFLSFNvNGxPcWc5?=
 =?utf-8?B?S00wbUNRWHFneVN6aDBPTGMwTEJnY0QyRlRDVXBXajUxTnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmxNVmM3MGRjUmFkSk0yRm92WVlubXVsRUdTSGZ1RHFGWVNYYU4yWnVXZVh4?=
 =?utf-8?B?VWVNeGlqdDMyaE5xVDdCd0kwbjRvdmFma3owaG9DUENrYUo0blFkZ2lCOEpJ?=
 =?utf-8?B?d1BrSWZuU0YyRUxvRkY4VEhUOWJuOVd3aFltK1Z2SXhMMnNUY3pPeGh3cjh2?=
 =?utf-8?B?NUJ5R1M5ZWxFemJjWnE2TURNbHZqaWhFNVV5TGc2TUNQTFpDZzErQ1N6QWEz?=
 =?utf-8?B?UnJRQ1J1YXRyem5QK0xUdjA0MjB1c0UzRkNwMlE0aHZ0Q2F1YzUyeklET2hr?=
 =?utf-8?B?NnYwMCs0N3lNSExBQnlVemxKSm5BQXhMUERoaXlOQ2c5blgrbEZldHNYbHZT?=
 =?utf-8?B?dlJDRjFGcFBNWkNjOTlsNTYvS1R0SzRiMWQyNTVYazl5NExBWndITTBBcjFk?=
 =?utf-8?B?Y25GQjVqdUpndFBBRjExclR1b0F2VDFnSEhNN2s2bGthQVRweW8rTzlOZDJa?=
 =?utf-8?B?VjlWODVFTXQ2TUIrbzdxYlZieVlGalBGY2tLSWJ6TEh0OENseTBRNkdmUWpy?=
 =?utf-8?B?ejRuQ2FlZHMwTUY5bS8wUEpnYzFLVjJJaWEzc2J6NVZ3aUFKQU5kOWtySjNU?=
 =?utf-8?B?aFU4cHRBdUFxb0I3ME5BWjVzTHhzeWdyNnVPdXJablpyb1c1SkxtNXM5Lzhu?=
 =?utf-8?B?Q3gvSVZOOUVzc3JabXlGMC8yQnVSbXVCc2kwWGNkL3A2K1g3Y05WWkIwcjFv?=
 =?utf-8?B?NDhrK3Fpc3k4SkhWRFlnSnZ4UUZpNG1uSzVqT29wREdzVlNxQ3dKbTgzaVE0?=
 =?utf-8?B?cVpyZU1vaXFvL1hMZHJTVU5ra3FpMnloZlpxU3pLYlVRZkhGSlM4MmY4Mklu?=
 =?utf-8?B?NUFhcnd6RlpYNjFnRW4xOTJ0SnZYMTBNekFCM2xocVA4WGhOTG8veUF1QTVp?=
 =?utf-8?B?c3dZaE5ocFplN0haTSs0aStia1pyWGEwcjlkcFVXMW90dUpBalZsMW84UnZS?=
 =?utf-8?B?RXBEMUlTbkNqalQ4aGhjVlZVdU93aGJxRGNkVnYvNEtvd240TTVKa2FEdWEv?=
 =?utf-8?B?RDZ5WTZhZDVuU0NnVlMwQUMwWkErdnd1S0Jsb0k0VDZpcEd5OGp3TVZXY1dl?=
 =?utf-8?B?bGVnVHlGcW95Zit6d0ZaL1JIWXEvdHRpUTZPTUhMeDhpOFJjREtXSndyQzZv?=
 =?utf-8?B?YzRieTBId1hVTHBXS3VVT1YzVVVQaWZ4Z2lIRWRxRytkWmZOTEdGR0FZSG9T?=
 =?utf-8?B?YkpjL1NaVDdiWGNRZFJKNFp4djlwWkJ0cm1ITUEzZTlXamNWUnNoSC9OaG0y?=
 =?utf-8?B?TWMzT2xVck0rT0JkZWlMZ3pZb0JVZ1hkaXgva0doRkw2MXVYOXRSQ1Y0V1R2?=
 =?utf-8?B?OWQ1Z255VUFpK3dzL0Jrd0l1WjBpQzV3YXV6ZjB1UjNnMmRITGFMOUZXazB6?=
 =?utf-8?B?WXJVdTd3eWpkRTVlYysxUUl5Tmt0MjRqMHByTlpzeXI5VEppL2dEblc2TTF3?=
 =?utf-8?B?OWh2c1gxQVVXUlBRbWNBMFRsOFVRL0NvSk1XUzRYWDBXS3BKTVBzSytBVktU?=
 =?utf-8?B?anhZK2dqZkdMNk9sSU91VTFyVGcxVnJ4c0hQMG8wdFVQUWM0dDY4RG41dnZS?=
 =?utf-8?B?R1lYaFZDcTJRVERnS3c5TTFuUjRZRU0yS3prNDRhMi8rVjRRY2JlRSt3NTVK?=
 =?utf-8?B?RWV6UWl1SkNmbEZFT3dBOVViTHNiOG0xbWlRaWpTeG0wc2wrWWF4OGxXZ1h1?=
 =?utf-8?B?UDQ1Uk5xR0JSMjNjTG4yS2c3aDBvNEF3NFpkOSt4VVFad2dWUCs2WHd0dXc3?=
 =?utf-8?B?Q3o5TFhZVjdFNEdKZ1N4Tmxhd3AwN0o0S1drR3BiODg1SnYxV2VERWpmeVB5?=
 =?utf-8?B?UnlCdHVKWGJ5bHRmMldBSE81M3NqQW52VkpoT05YUTdoT0FPTlBqZVJPeURB?=
 =?utf-8?B?L1UySDdOVGdpbE9WeStCY3BMbFJnWnFVeDRMMzdzMTZYSWFrTXBwV0QyN0Yv?=
 =?utf-8?B?bVNaUnNjVjlzWVQrUmRldGxiZ3R5RHZ5bkhoejgxK2NuN1YrL29qZ01TVC9X?=
 =?utf-8?B?NXlydzREZDd6ZGNoOHJTUDVTOXVHd1VUZk1WTldhTlBCMmZFc0ZoaFJseHdQ?=
 =?utf-8?B?T2JLUUVDUFZ3elBaaDNMZ3RXU2xjT0E2MmUwTGJ5akUyMVFYYXYrcmtiSGRU?=
 =?utf-8?Q?2XnhpWmQEckCtcjcnCH70SYbU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d30ac3-1f8d-4352-6777-08ddaca52848
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:12:30.3425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2DJhCl+zYtclbAgxXIEnBSg1AZiet24Cu6HHOiI5RsTO75TsqNA5WUceOQnMR0b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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



On 6/13/25 16:22, Tom Rini wrote:
> On Fri, Jun 13, 2025 at 10:31:33AM +0200, Michal Simek wrote:
>>
>>
>> On 6/12/25 20:11, Tom Rini wrote:
>>> As part of the recent cleanup of dt-bindigns header files we did not
>>> remove our copy of dt-bindings/clock/xlnx-zynqmp-clk.h at the time. This
>>> is because the difference between ours and current upstream is that
>>> current upstream has a #warning to not use it and to instead use
>>> xlnx-zynqmp-clk.h. So we change zynqmp-clk-ccf.dtsi to use the other
>>> and upstream-only file and then delete our dt-bindings file.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> ---
>>>    arch/arm/dts/zynqmp-clk-ccf.dtsi            |   2 +-
>>>    include/dt-bindings/clock/xlnx-zynqmp-clk.h | 126 --------------------
>>>    2 files changed, 1 insertion(+), 127 deletions(-)
>>>    delete mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h
>>>
>>
>> Tested-by: Michal Simek <michal.simek@amd.com>
>>
>> I expect you will take this patch via your tree. If not, please let me know.
> 
> It's a regular cleanup you can take it in your next PR for -next.
> 

Applied.
M
