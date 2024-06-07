Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1CBC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 07:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBC88824A;
	Fri,  7 Jun 2024 09:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jf8FCA+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2F48823D; Fri,  7 Jun 2024 09:53:35 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AFB88452
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 09:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvWvYS8Ur0ko8wj4N1UU0W89xYmhRWizGAl2iRLh+ZmxdgWJtZ0boh1ayCudBm10KIaIBzWKMUDTWQJRGAh96UG7sMGPR7EWvU6TFlar9jzNz1hlK675GoIf6kdSHZRhPtd/j8fvDRFd+j3XkYFqtUACnrhuwH4gDK0IbPGihcdux+go8N6PqpH1G+W7qy8u3K9mscJN6O/74aUWFPoeq0MdZz8XsRnBT0x7yNDQ6K712XENlYiCkQUdEfDYfxjbovBdGu1NKZDTknQAuZnI6tshizsgzroq+gmB7cXDnwLmXzfUnsCh4RsnHcoPSq69FTaJncwfkzXXCBTAY0S8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKq2lPJQd5GVUdR18lnwnz9FD/HGD7ZXIfw0r7MYsUY=;
 b=ZXklkVe98AEijz36e9NX7KHiffUcrI/dcoZuWqw4Gn5lh7dE2rY9FvdaEOq4Llc3eRRNdgQmAoOlYto0xXMtc9glkZE/bxjbzqgJTbIx4YwEWzj9jtxMNwZvVi8MYCRLdemsip5X2Pzy+NW088Varu4dlQhQNPFnUjUiz4a5bV4znlbpcu5F8xi2Ll/Fi/kV/YVDa3YAIpo/2+5MEQjhAewY5eJPT35CeqRFs+5cH2iBkNoh4pnO3kOVU6uTWsVepLEGKNtfNByDWIVSxLApU6DJ2yzHYAAUiHygPsPgl3Sy/EpKr6BFs3ZTEvs/XW6wcQUr2ZGHC17KbLcPMtlbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKq2lPJQd5GVUdR18lnwnz9FD/HGD7ZXIfw0r7MYsUY=;
 b=Jf8FCA+Tv2m9gdY+oqU9PqgcmHTQOG6NWQ/JcWMQei/st6x73gk9nZ8WAY/2H1msCYtZ1ff+jv0nGf/9wquvFpkS9uInP3q+AhpyE3sPnbGk+MNDhS4KZLhbOtvCnvm6Xc+sxBUa32qmF8rvu0oLcLQNMREqixmw32LiVpe6rCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 07:53:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Fri, 7 Jun 2024
 07:53:30 +0000
Message-ID: <1cbaa06c-2f08-4d44-9829-e8c4b04a3f03@amd.com>
Date: Fri, 7 Jun 2024 09:53:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] lib: smbios: Extend driver with using sysinfo driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <cover.1714138688.git.michal.simek@amd.com>
 <66a52861-6203-4b6f-940e-52e21abfbb1a@amd.com>
 <CAC_iWjJzTrTSFNmnRcXH2JoPK5EB1bNgBzbHLvyEy0-JxQ-E2A@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWjJzTrTSFNmnRcXH2JoPK5EB1bNgBzbHLvyEy0-JxQ-E2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0151.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: dea3a052-aa36-491c-a5fb-08dc86c6ec5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTdRazF0ZERoZDRndnIrOHFWUnBjTUYzVW91S0RVM0lyQmNwRHlDdkFHd1ZJ?=
 =?utf-8?B?ZS9pUnRoaFZXb1k0V2ZUbFBQdFFZTnpmeStLQXhvbzZTTG5VUVlrbGFsWGN3?=
 =?utf-8?B?M0hSVGhkY3k4ZTBTcWo3OWo2eTJDbTYzSDdDejN2dk8xTVRQNk41VFA2bXFj?=
 =?utf-8?B?ZWswTXM4N0R0dTdKellWalRHb2pzWDJWRHNER1V0NXNYMUlERk0xRnV4eHIw?=
 =?utf-8?B?VTZ4ZzFnNGlSRjladEJCcEQ1b2xZMnBWVDFEU2ZNNkVPcFhUNExRT2p1RlFp?=
 =?utf-8?B?OWMvZG91eXJaZ3drOWpSdnh3V1psclFvdHBhcnRJcEdUOGFjMGVrcWRraEhk?=
 =?utf-8?B?azkxYm9mckQzZHArdEVwRitpbll2ekJiLzRkck92RFFUaWFJbytteWI3aFJI?=
 =?utf-8?B?OFpqV2FVWnEwbWJnWDJheEVtcnMrbS8zNVk2OXpCZWV1MFRJTzJSYWZMd045?=
 =?utf-8?B?OUd6TGNtNUdSV0xNdGpWb3pNNVg4eGRQTlMzTGU3d0kra0tlSm9YMk9UOU54?=
 =?utf-8?B?R3hiMW5CV2tLUkZkYzZWRTVNclowOTdGTkVtOVRXL0I2TTNBWVc2RjBTMlhs?=
 =?utf-8?B?N0FKQVJpaE1yWnZsV29NaUNYdlBaNEx1L1JHYVU5ekkxbHl3TlJVbVU0a1lK?=
 =?utf-8?B?b0tOL1NmbkNGaW9OeVNCa0lPQ0FmbFVaYndxdjFsT09KU1pXVkpaVHVvQTdO?=
 =?utf-8?B?NW9vZk1oLzBldHdFeEVrbnowUUVheXNmNVY1eXhhODFQdWZHNGVjaFI0NTRF?=
 =?utf-8?B?eS9qeXpEZmN3SVMvdVJHNG9aWmdDS2hZZ0NsR3puZ2VJVWs2TjltZThjUkky?=
 =?utf-8?B?WWZHVVVGS3NzWVdTOFlzZE1EVGg3Wm4wdklVbWVGUVRUTmR3OVVzcUdJd1ZQ?=
 =?utf-8?B?SWg1MmpjTE5nd0IyOHJxTFlCZmh3ZG1aUDcrNWlBM21mV1BMRmxZUytkUHBk?=
 =?utf-8?B?emVGWURFL3crYmYyUGYzMmgxcmM4aFFaMkluM0ZtRUxVdXBlZ2p0L0lCb1hh?=
 =?utf-8?B?Ynhrb0R6bFZRZ1BZc2ZrQVRVYnl3K0E2QnJROWNNYXpBd3VaYzVJY3VpTWE0?=
 =?utf-8?B?YlVmc1N0eERqd2l6RGhyc2ZuZUlRNjJ3eDdoL2syQk9UcjNPNjRJa3pFd3FR?=
 =?utf-8?B?OHdiV1k2RGtyS0cvOGUwdVpWK2RKajFNSjd3TXNXZ3JmMzE1U0FpTVZCSlJu?=
 =?utf-8?B?ZUo0aU1CZ0V6aUZXVzdzNUdTNVJSYmw2VG40ODFISVNVakJEWXhEQ2RJakJP?=
 =?utf-8?B?d0dPdi85cEtzcVhWQ2tQaFFnTkFTd2JaMHBWTWtKeHlsQU1BZU5jeUM2cXNH?=
 =?utf-8?B?aGR5UklQV0cxWGhXVlVHNXZ5NHlMVjRld2FCaVdZa3BPNUJjbGpreDZEaWVu?=
 =?utf-8?B?ODVxZUdvMTI2YmpiVW10U0VmR2lLNno0eFVkT0JLNkNtMXdFRkEzR1cwR0Z1?=
 =?utf-8?B?cE85aXNUUWtPSHphU1VldFU2SE45WEZNcmYzblBtVGVIWXpvUFBoRktsNUFV?=
 =?utf-8?B?R3k0N0haY1E2L2FlMlVob1lpbnNxTnEvQ2hwdXoxV29wM0w2V1U1TXcrb1J6?=
 =?utf-8?B?NHNZQ0ZUSTU0NWFUVGNpVU5oWWZoam5vRzFBV3NHU0RMb3FMRW5rNmNHM2RC?=
 =?utf-8?B?Q0xYMExNUCtWZ0VCNEZyMnpqWGJrTC84QUpFWWgzYkNSd3VoUlJ2Vy9TYURi?=
 =?utf-8?B?amNkbHIreUdPNUJ6MU5DcHh1YlAzL1pzNVpURXJZNVZwQUJGTWZURjQ2SHE3?=
 =?utf-8?Q?t3n6FU4BtAH2XejOUM4ooqyIfFLNL6mnS8uLMHj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm5jdUZ2Nm9TNnlkUFdPUmw4aUR6ZG1veCtaY05tWjRXQUlubjZjN0NmOGs3?=
 =?utf-8?B?RnJmQzQ5ZnAxaWlwdFFQTktudVErSnc4ZUtJQUdZbXQrUVN4VlRuZDFsNHVY?=
 =?utf-8?B?bEFWZlZDVTkraDlHYVdGQlNvdDllSEp2VVQxSVV4cm4zRkhLNFg5eXBLM053?=
 =?utf-8?B?V0RvYXA1eWtXL1prdTRUanNvVDRkUWFjenFtSkgzdXpzcUZkL2ptcndQSTNH?=
 =?utf-8?B?Qk96djFIbHpXaUpPVEUrbm9TQU43dUgxQkc3aEZzdEV5aDEySmFlUVJpTnBH?=
 =?utf-8?B?TXFPd1JZeFZMNDdJbWI1SkU2VE1GOC84OXcvbUQ2cXpQNlo5VVJmOFhZelRH?=
 =?utf-8?B?eVU1bjJGRjA3anVUdGlnZ1VmVFByVDc1ZFU4ZUtvRGp0RjNQTlNKbnB6aTJ5?=
 =?utf-8?B?bVc4bGRNNjdLc1NNS09EUTluN0hiQ3RJODkvbGMyamIrbmxVL1graklyY0Rn?=
 =?utf-8?B?bkMxTDhIanVJSHk2WXV6czFYMTA0Vk90KzNkWExPNGtEWE8xWmUrY1hnZlF3?=
 =?utf-8?B?aVBMRmR5UkZpNVZzUjJHU2V1S0YweXBHc1NERklEenlqK241T1R1NWFnRXJs?=
 =?utf-8?B?L21BeTlLWFVHNmNWOE4zbEk3dmUyemtnUEt3b0drYkdLcUNvWmluRGRkbVNl?=
 =?utf-8?B?aExXdUE3SG1FMU5xdTNndWdIWFQ3WG5WZi9QdGF6Q1U4TlYvN2c5QjZZMWJu?=
 =?utf-8?B?RDdHSllORDBhTzFuY1hFWlhGblRVckdRQWhGOTcwelZMUUpEUFB1SUFBVGlZ?=
 =?utf-8?B?S3g0OThSYk03a1JCajd4QlZkU3l3K3d6VEdOaVhINjVzekNqc0VlSHFwNFFX?=
 =?utf-8?B?UFg0dERuSHBWcmhTQUhqck1jT0xHWjkzbmswZElwSEZ5QmFDZjM0VmRnTUcv?=
 =?utf-8?B?THdHM0h0eWtmY3djK01kV3ByemFWV2tyRmdrUjc4c2xEOUx6WVdWejlLL3hT?=
 =?utf-8?B?UVBETlgvVUJFMUsvS3lzSHc4eGc2Z29TYURVOWQ4bTFCclllWWpzeGNOSkNV?=
 =?utf-8?B?RmNjcXVEZmRmdEZDQ2ZLWmZsSDAvdkpQQ0tNWjVtNXhVSjNZVDFDdEZJb1BX?=
 =?utf-8?B?Rm54ejduRjdpRHVHdEU5R1BKS3VKSGFzakE3b3ZWR1RSSzVoYWdPNHNRRHBK?=
 =?utf-8?B?ZXpyNlpYT2lDRmJsRU1jY002RTlicjlLV2dPSnpCejFtWnp1MWFpOERpVUlr?=
 =?utf-8?B?VmN2Tnh5L3FjU21Hbi9aYzZEaFQrMlhMZzR5eEYwc0dRT2tsTG51NjhYQjk5?=
 =?utf-8?B?UnNSUlFuS3l2RXVITlU2UXBkWi9XQmJNWE5zaW9pdXJaZDYzZCs4NDN2Wi84?=
 =?utf-8?B?U1JSYU5HSVlacE43a05Za3AvRjB3YUxYcEhRTFpUL3RCbzJDT3JxaVZ0YzN1?=
 =?utf-8?B?YWR1M3JoRDBJeWF6UnFLWTBVNWdaWWV1TXM4Y1B6SlJOZlFiWEVGSGxRSDRU?=
 =?utf-8?B?V2p3RmRGWnVyR0hUZUNDbzlTMGhLdHJwVzFRR0JzUDlNUjJpQmZXc3Avc3B1?=
 =?utf-8?B?SHZ1NXc0aTgrbmZkUCtCQ2NhWWVveUVnMzZDYVlrUmNQZXp3UDExbUxyOUpK?=
 =?utf-8?B?SEhENEY0TU94RjFwYzdDT1lxa2xvUC9NTFBhR21COGs0UFhPUVplaHlNdW40?=
 =?utf-8?B?cnY4d0dEU0ppTzVQNFdSWVFFa0U5UHlwb1I0Q3BlcDVSUVpabFNELzY2V0NC?=
 =?utf-8?B?THlNRkplR3FCK3NSQlZmRUdxMDlDYkZNZnY3NEpiVmt1NHRIYUdRNWFSSlhX?=
 =?utf-8?B?OGJiaThZQ2tnZEt3YTNLaFRINmpLb1NEVDI1cnBBbGlYeisvTXpjbzgwSDkv?=
 =?utf-8?B?S1ZMWXlwMXNaZU1TV3JCcVZVakdtanU2MkJTSHNOMHNFMFpGdDBONm5MRGRZ?=
 =?utf-8?B?aWNHcFl1TWpDOEZyUFlBdWwxdm9GR1BQS3lMS2VGbnliZmI1TDRIMUVRT0dJ?=
 =?utf-8?B?eHl6Q3AydzQrZTcyZU5zcDRsR3lHRlVmWEtUSDhnam5KYTNWbWpyVVZlMlFP?=
 =?utf-8?B?VTAzVmpueTNycEY3VWRXVmhwSTFhek9TcmRncEg2TTdseHowTkdZRjFVaWJV?=
 =?utf-8?B?WmVmVkE5azRFTDdCSVh4NmFIRld3Nmt1VkFoYjZ2Ly9wT2xpaHkvRUJZVHBw?=
 =?utf-8?Q?+xEWBoub12GgiQ/f5toYkPlvF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea3a052-aa36-491c-a5fb-08dc86c6ec5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:53:30.9363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrMJPLH9akRODXNdCjwuxkkL6NjEDEuR62cDTKr53XEeFs+brLxZXce8KGlaaRgd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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



On 5/24/24 12:07, Ilias Apalodimas wrote:
> Hi Michal
> 
> 
> On Fri, 24 May 2024 at 12:45, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi Ilias,
>>
>> On 4/26/24 15:38, Michal Simek wrote:
>>> Hi,
>>>
>>> currently only DT way is supported and it is added directly to lib/smbios.c
>>> but I think DT and env is only one way how information can be found that's
>>> why this series is improving handling with using sysinfo driver which can
>>> be platform specific.
>>> At the end of day DT should be taken from smbios.c and put to sysinfo DT
>>> driver instead of implementing it directly in this generic file.
>>>
>>> Thanks,
>>> Michal
>>>
>>>
>>> Michal Simek (3):
>>>     xilinx: Enable SMBIOS command
>>>     lib: smbios: Let detect the system via sysinfo
>>>     lib: smbios: Detect system properties via SYSINFO IDs
>>>
>>>    configs/xilinx_versal_net_virt_defconfig |  1 +
>>>    configs/xilinx_versal_virt_defconfig     |  1 +
>>>    configs/xilinx_zynqmp_kria_defconfig     |  1 +
>>>    configs/xilinx_zynqmp_virt_defconfig     |  1 +
>>>    include/sysinfo.h                        |  9 +++++
>>>    lib/smbios.c                             | 42 +++++++++++++++++++-----
>>>    6 files changed, 46 insertions(+), 9 deletions(-)
>>>
>>
>>
>> Any comment on this series?
> 
> It's mostly Simon that created that sysinfo stuff, so I was expecting
> him to have a look.
> I can put in on my bucket list, but that's going to take some time

Simon: Any comment?

Thanks,
Michal
