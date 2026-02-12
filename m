Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A79EB4910
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 11:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE79483C4B;
	Thu, 12 Feb 2026 12:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZF6fqMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104A983CB5; Thu, 12 Feb 2026 12:41:46 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84328367F
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 12:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7iHfndEwRMAsmQw7v6Pw89p3onqp9UaDweGK8j7OzzmrPelYbKmEC9DMT2D1T/iNXmAuXs3p0f7hIo3cYJWBAocTHjIieJQf6aduOD243oZet6fqL62ySLnLdS5Om3WBhW3DSC00QMHWfjvmu2AccCpJ70U0kfmQwsXZuW1ksW9D9tyvYsIQbZo1DYKod8lKwOhlfOG9zO5USHSfDLzyLd5iTXfQUrw9I2L/FKxCAbcEZDTjYCoWceftKuntMxNuWzcz+d+Wy2/FbHvFoZLTkbvbxw/YNzUjS+AAjEKU8sYfhfRXup7YtGOniBoOuftxlfl0J1l3EuljMwl/zKk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK6BV7ENGmZ24CmAZ3wfC8BzBOI+RsiJ/VzthMvmI20=;
 b=ndRyrdHKQPqpHrH1qlEOMw/7RsNXLB/ZXdFgViKCOaWoXHv0XupwT2MtDZuwBBJBQPuFnmmU/1tzhfJKktGrEcfYissTYdDXUb2RmuNgnwZvbjcbp/WddWHW/LMZ0QKpW77ydpdv98s/PxK4kPgTe71rJU5/A0il0fIUkcNse6EhqPQfKZPUpaWDDvVW+ot1pBG2bzXpLarw1Ql0tfjVUfYtvVNSZsfT6UAzrDD7oflRDmTF75vuRzn0TrfdWYfWt10StGwrAjKGqNr9+or0bgbwgWqezktMNBlU+P+R7x/thE7k9mC/WsHscNLzMTMwb1H4ihAZJQFcGIKZBDM5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK6BV7ENGmZ24CmAZ3wfC8BzBOI+RsiJ/VzthMvmI20=;
 b=VZF6fqMMzsQAib2xIQggm0h0a/XoXOstSk9Lq6DZ/bmWR6Ky55RPPnlfzgkroCjBM/mQA/3aN4AcV8ybVE5Q4BeLigaEWRXstIcahI3VYG6WxnW3Rqcspk/RC9BTEUeslZ+eLZ4e61SDJ+afoBOJo+7HiCgE+xnlK+wBszHKWuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 11:41:40 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 11:41:40 +0000
Message-ID: <c3030967-2a1b-45ee-8779-773fbbab22e3@amd.com>
Date: Thu, 12 Feb 2026 12:41:32 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] AMD/Xilinx changes for 2026.04-rc3
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: d589178d-b1a4-49ae-7a86-08de6a2bafc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjVRZ25Eb3BSZ0NNNThpaTVTWUdJTmhBRG5TK3FOdTZTenBNUDVOekVUQ2wy?=
 =?utf-8?B?Vk1YTHdnUDFBRXlEZGd5cEJUeDl0K2tEY0s1emsyYURFaWw4eHkwRWpuOGNy?=
 =?utf-8?B?VnUvdWtTWXFXT0lEZTZHTzQ5ZUZ3THd2ZDhMR0xsU0tzNDdsdWhSbTVMVStp?=
 =?utf-8?B?TlFvUWZzRkcyZVF6c3FlS0l3aDVwSWJ2UGhvSlZjWFJ0Z1A4UGpLcjNpc3Fk?=
 =?utf-8?B?Ri8zZm9kWkhYUUVaZE1Damg1alYzYmZmNWNoZ1l5RFVEWStsZ2tvREhoRVJh?=
 =?utf-8?B?M1BIVk1IRnA4STB4aHVWelFxNzB3K1BMMVYvUHlBUGxTRDZBWmIvRFcwaU9H?=
 =?utf-8?B?cmxadVdtdm1SdkxZelBQWXA0UFN4elBmdEZxR2NaZ2ZPMTRKWGNuOVFIUW1p?=
 =?utf-8?B?bXMyTzl5L1EvVTlFQzBHMXFPd2NEQUdxcWhoKzlmMjBZY0tRMFQraHNjMGpU?=
 =?utf-8?B?N3N1ZW8vbzM2ZXRmbmNLc1RJeVRlKzZVd2xWUnVSdkNiWEcxd0tBRktyR1VJ?=
 =?utf-8?B?SnViQTUvQXR5aVZxa0xNcTV2b2RsZktIaTFtSEtoTy9sOE5JbHUvdDB6VFNt?=
 =?utf-8?B?L3JndWh1ZEtHOGpEQlNnS2NrTG9NaHZmeW12dDhXY2dYeG91V25pS2oyMTg2?=
 =?utf-8?B?RzBGVGtIWUQ4T0Uya1FZUjNqOW1HS0p5emFSekNVMVVYcmxsaGdURlBBQXZG?=
 =?utf-8?B?NGxsOW9URzlqYTA5UUZBcnZxeXBRbk1LaURGeFU3Y0NlMVRJaUlUWmFMUXdz?=
 =?utf-8?B?dnF3Nmo4VVlvUlZ0bFNZQWI5Z3BJM1cweU8zdWU3MWJWUVpmSU9IejBNUld0?=
 =?utf-8?B?TlpPL1pRS2ZMUXFuUElKR0dGT29NZ05UcGpiRk1zMVAzR1dWTVJrUmx5TnBv?=
 =?utf-8?B?L0pqZ0U0UzZkSU5zdjc2VUJncElmYmo1K1l3YzdnaHBnS1VYWFJ6Q0crTXhj?=
 =?utf-8?B?K1pQVlpSc0FIb3FMblN3dmtYaDUvQXd4eUI3bFV5N1cwSXFaSWhGc3QwazFO?=
 =?utf-8?B?UDBSbzNpVndYVjI3QUcvaGJSdEp5WUs3V0NEYTB3dmttREppOFp5enVoWllK?=
 =?utf-8?B?TTRzc25CVzZzMzZYTlRicXFEWERmMkRjMVR3UlZPUWYvT01DMjdnWVRVVndt?=
 =?utf-8?B?K1ozYWJ4YjVPaSs0Z0FodFR5cEl3VUJ4Znk0bVNkN0g3V0xacVo5MDhIbCtq?=
 =?utf-8?B?ME9veGlFL0JvYWFqR0lBMzhOQVZDQ1BpUjBvNGNVNDc5RG5TS0RQTnNnK1NN?=
 =?utf-8?B?dGl3TG9SL0dOTTZLMnVDeDliK1dNVEVtVG5rSjEwMWRNVjd2eUdOK2tXc1Mv?=
 =?utf-8?B?RE0xU0dyRWdrVmUxNnU5RC9IUU9QWWRjbVpqSFQ1NmhucHVpRU9nbHRVMFpv?=
 =?utf-8?B?eTB1MFpuc1NqVDMzVlB4d1Nsa0JTdUMzRnZ3VVQ4UUtNeVhhR0U4TnpFMWlm?=
 =?utf-8?B?dXFqQ3hIVEdsR1pUWnZyOUxzeUs5Sno1MjRZUzdDU3FaU1Z3ZnF3elRMcHlG?=
 =?utf-8?B?MHNpM0NtLzZKem8rM01kWVg2Uk5majU2ZHVjSWx4WEhKcUxrNitMa1V0R1d6?=
 =?utf-8?B?TjNGRlRpTnZQa0UvWW0zVHAxRnZPenpaa3c0ZmxqZFk2bTZCbmJvamtjajZw?=
 =?utf-8?B?YVVlcDZtU01tSk9WeUg3MmxGVE9tdVBlMk8xcW9Fd1FKNXlBY0VFYk1ET255?=
 =?utf-8?B?WEdJcEg3aVVRMEFGUmdtVXFMNmsydTVPS0JhZ2ZzSXdlc0swZW1qMEViV0Zh?=
 =?utf-8?B?c01Cbmt1cFhmaisydkZRWTNKN3ZmUytIb1R2blJKVTNLMnRsazF6eHdjcVMv?=
 =?utf-8?B?cmN5VWlucXZXaEZTUUdOTkpzYU01K0hWQXc4Tm9vNDUwMjRIclBQVEphdHRL?=
 =?utf-8?B?UWJxVk1VVFFRYnkvVzc1cnE3YXEzdDRGK010OGxtMGRkTnJDVm55S2tWYWo0?=
 =?utf-8?B?UWtoN01zc1p6TzE4NjBhSTdLZ2xaMDNjcXZ4Y3VwS3hIeFhHT3J2Zm53d2Rh?=
 =?utf-8?Q?b0qDWP5za9VUX5NqwHv6XJ7OpbCiek=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE01bFV6UHNWaVRzNUZBSVhzdk9rS0YyR3lLNzdHZlJhRlNhV3Mzc3ZmMmVn?=
 =?utf-8?B?QnlCUTRNZ3p5STFqbldSMnAvZ2xiUW05alo0QVdrYkZFUHVZY01wQU50cEc4?=
 =?utf-8?B?ZFpTNkJBa084ZnU4WnJkQ2tLN2N4bVpyRjBhRlRHaTQ0YVRnekI2YzZSNHhI?=
 =?utf-8?B?S2FlQUhzai94eE44aGNkZnl6TzdHY3NWWnRLUEdneTBEaGhCbUZDRE40OUhi?=
 =?utf-8?B?eU9tMXVOVzVBUHJUak1FS0xqblNEVHVKTThmUXluQVFsM3l5aU81cm9tMmRn?=
 =?utf-8?B?dEM5OHNaWVVpbFFzcUFtRG5Zc1BCVE54Nm5kd3RCZTViZEViSUgxaEdTcG1H?=
 =?utf-8?B?V0tDUVk4UjNJZWxiRURFbUpFMTgyMjh2NTJKemJOemIySXBTaVBDRE9aY01a?=
 =?utf-8?B?dlJrb2hBV2YxaEdZQ3lNV2NydDNLQklSNEtEc011NklSeGdJMEpCcGw0dE40?=
 =?utf-8?B?S0NicHpDaUNqcFA4b1dSOVh1elVIaFZkTnFhbmdQdElnbFMyTCtoRW9MZDRn?=
 =?utf-8?B?eHhzc0RZWVlzVkhXbERoZVUxUVp2di9GM2RqeEhOMUxCSW4xbjcxSXRTVE1r?=
 =?utf-8?B?YUxzT3Y2aXJITjlkaGlxVVRGL2F5d0tHTzNlcmYyOXdGUGQzYm1kdEFOeTZp?=
 =?utf-8?B?dlBSWGNyaitNUVRHeEsydmxaUWpEUW1FQ3Q3NWE0SHNVTEJoWGx3NHdDVnoz?=
 =?utf-8?B?N096RlN5WmhXb0U1ODR3eVFuNFhESVFqT2JQcTlzMUZBWEs2azJoMzZpZzNV?=
 =?utf-8?B?SllMSE5Vdlhndjh2VmV2bDcwQUM4OVhkcDRvbHI1TVRQNk5DUDUrTGZoSEpl?=
 =?utf-8?B?UkZvUUQ0RkNqYVBOdDJxcmk3ZHFwVlZ0YVFNZFN3TDRzVll0bm9QcFNtUFFo?=
 =?utf-8?B?d0RBcEdUMWRudlo0YVB0aGpEbjRid244eWlUb3A4ZllaZzhPWVNsbE1LRDY2?=
 =?utf-8?B?cVZOM3YyTGpmNFo5VmNyT01vWFNKTk0veDFIYVY5bkY3ZCt0UXpjYXpJSlFF?=
 =?utf-8?B?bUYxaHV1WVhzem96MitqZk1HYStTRDhDTHBaL1FVTytNc3I2cGxMSGp6REkw?=
 =?utf-8?B?bm1qb0RyK1RJV0w4d1J1Z3pVUlQ1QldVVC9ROHpJekRIaE50RW5PZ0FTbkRD?=
 =?utf-8?B?ejNxaXJEdjdySFlHLzhqRndMQVlCMnczQkxOSGwxemUzYVdrUXVSWlFpQ1pu?=
 =?utf-8?B?c05pQytkdE1XbDFIbWxLUE5uRDRzY09TZUc5b3MvTXErMkJ2dFJTckJCRll0?=
 =?utf-8?B?dUFkZmwvL1c0L0hoeTR2UWs3dmhuTmI1ZTJhZWc3WmdBQlJoM25BbmNGaVBI?=
 =?utf-8?B?R2dzREJTMmlrZWVMVjA3VWFrckZtSEh4YS83TUdNcVd5dXJQSW53amROMVZj?=
 =?utf-8?B?aG5uNHN5QkR0azRuRFVndHFybHFHL3BrM0FoZmk3TmR2R3ZiVnk4UW9aT2lj?=
 =?utf-8?B?STBybU5MUFVBcjJmVytlVGRseFdnSktZNGY3Y2VWNzcxRGJ6U2FTVjVWSkJR?=
 =?utf-8?B?UGVZbko3UEFrM0lWVHpJWjV6NVViRTE1Y1hmSTA1Z2t1MmQwZnFjYzdOamgv?=
 =?utf-8?B?THk3dkNNS2w0bk1TRTUyVlBTa3NQUW5FMk9SWXlhRVhDVXR0RG1acXFvMEYr?=
 =?utf-8?B?ZktiYVN5TjM1NGIrV1pDSHhVOE4rSEVraXhmRGtQeFl5L3l4R0dQb0FNWmJH?=
 =?utf-8?B?WDlQbndzeDBDY2tndThuTlZSWjNGTVFMYVJxaW1DbE9oUitPSGxvUXFqWDFU?=
 =?utf-8?B?YmJnMC95eFlpeUJWOVdnc0JHLzBIbnF3bU10dVJOcVFYWWNrNklKMlhCaDJP?=
 =?utf-8?B?cDNqZWlvR2I3d3dvbDBKQXlEMzIyUjkvKzV1SFJGTysxeHBzOSsxMUFRRlB1?=
 =?utf-8?B?U0JmdjZ0UDdhK1ZHMGFjNXRYM3lWR2pTWlcwT0JqcXZXNE5BVGU5cHpNd0F4?=
 =?utf-8?B?NUFTS1BnOENBUEFoOHpITHZ6TU43eFFnV2VmdEdJcXo4aEpjNklzdFFqR003?=
 =?utf-8?B?WVhwWFRpZFBDc1BRTFRWd01VY0FWTEdlK2RWZThKNE5Ta3M2UyszUUNjUC80?=
 =?utf-8?B?UUVsUVhTMGRSYnl2c2QxS0tDdDN6UEQ1aTlueDBqT2pZV05OMUgxWDJkc0ww?=
 =?utf-8?B?NVBmT0RTZ2VlMit6MUNHcyszczlGbGlNYkw0RlBXVW9jbmlOaGxvWDNlU2pa?=
 =?utf-8?B?VHIrSWZaeVBrOFM5UTZIZnNBRVZoQjMzVEtPNVZtcG5hK0RONytXQzRTZENv?=
 =?utf-8?B?Z0w5MkY3ZGNGakNET1JIQjlJeXQ0RUR2NnN2OHdtNzZhMEVmWnAyMEhuay9q?=
 =?utf-8?B?TVdya1hLNTFCdWd3TEtJYTQ4a2FTQnl3QkFzNDE5clZ2Slh1V3pNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d589178d-b1a4-49ae-7a86-08de6a2bafc8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 11:41:40.1246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOITgObMsxRE76xc3L0auqrY4YCiGaaJGY1+vVoNoryBZN01N7sqDp4SCnl1DMcy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

Hi Tom,

please pull these 4 fixes to master branch.

Thanks,
Michal

The following changes since commit b99da05e1538b8fa153322da82917af2aa27e1d6:

   Prepare v2026.04-rc2 (2026-02-09 15:07:50 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.04-rc3

for you to fetch changes up to ce6fc049b700894b2a8f25778103cf4f2d29cb34:

   net: phy: mscc: Enable RMII clock output for VSC8541 PHY (2026-02-11 09:41:26 
+0100)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.04-rc3

clk:
- zynqmp clk fixes

phy:
- sync vsc8541 config

versal2:
- fix GIC configuration

----------------------------------------------------------------
Maheedhar Bollapalli (1):
       arm64: versal2: fix GICD/GICR base addresses for Versal Gen 2

Peter Korsgaard (2):
       drivers/clk/Kconfig: fix "related" typo in help text
       drivers/clk/clk_zynqmp.c: get rid of compiler warning for !CONFIG_CMD_CLK 
builds

Pranav Tilak (1):
       net: phy: mscc: Enable RMII clock output for VSC8541 PHY

  drivers/clk/Kconfig           | 4 ++--
  drivers/clk/clk_zynqmp.c      | 2 ++
  drivers/net/phy/mscc.c        | 2 +-
  include/configs/amd_versal2.h | 4 ++--
  4 files changed, 7 insertions(+), 5 deletions(-)
