Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2BFC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C53C80FC4;
	Mon, 27 Jan 2025 08:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="dl062QiZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 613B580FF7; Mon, 27 Jan 2025 08:37:29 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C249680F9E
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgYd9atZz8bxENVWeD8MiHdbIlt9loj+lIJMcy8xvlULt2rZMhm8oFu/6DMdCPbgIJ+I8XJllRjoMRYtsHPxoShKDUdjxetZKJ4XWW84V3kmI0BQwLSToVVlcNH1gFkjIqZ9dgoPK+hFQt0NHYLVu9Fpd3squxZQItf/ooUbLxReCFQYK3FRnqlTPwz2cnnhuXVDvycN+UDtUZ+h7tPAX6MoaesnirJ2lwXLizKdO4vZewtVD8VdO3s3hBDsFi0jmQ23QnIn+3fv0cpNlqyTg2LPnRFRf+lvjXejEHtXmz7hbfj7C2v27oNkgYEKErzy9SPz93bCSUWD93QHpjYDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQFwElb4SkimhbmEY/rPy92LWEKY5XtTaqhIISEDo9g=;
 b=QCwBKRB2MbGayFq62t2IIxeZ5oFWgj5XSsvU/HwRew9K1NGiwCS673+hNDjDPIoVPd872IeBC93outYT60qPA2RYmjOncAzxRO769dpB6A+sOJmSHY1XgAAckEBf2jkM4EZGuCnEi30+H+18D6ROnEWWYbHLzYrUHFLJqtwn7eBnb2m7fpKaS1EjdfJKuYTP/pWrc1MWyDbMROLdUfxF0naY+YCAZwGD+fEK0GAne7CsTBn6JuyQvpEomshcXHITKnve7uDNBCZrYdl3/7K3Zl8qyO5H0BSigrbjrppIoWnKRtDZcP7u8qBH4TPumvJTp7wmJxFichHEOn+Ib/Vbrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQFwElb4SkimhbmEY/rPy92LWEKY5XtTaqhIISEDo9g=;
 b=dl062QiZlaQz4uNGvPIG0DfJyxntQTCfJktkL3GXqJPlypd0MIYRNvm4At2qw0F9w/i1qn4zbnS+RRq9c0Z2t0jrp/K5Ottx4Ir/CvWeuGVMGq4bsP6gIyiLvFW9sNvHvGUMJNCEkqHiYOvO40hDi5kcDF2UaMb12j48BaaB7RFtWy3g6T1MRFzv9d7rUomZQzHRRg1nZsx/h3wg8yTZ3p3aa+qqnXi9GelIaqj4k2wyw3HRi25EylrTvb0MI1UpnhRa7YRcKtlTf5ssAJp4GH3RI3xEt7smmlmfxvwjD2iNm/HZD5tZY1rL8anyU7WxxKQnsF6bCeranRYAYNLawA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AM9P195MB1046.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 07:37:25 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 07:37:24 +0000
Message-ID: <018775fc-c4c2-459a-a4c4-ec715b5740bf@phytec.de>
Date: Mon, 27 Jan 2025 14:37:18 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi: Add
 bootph props to i2c
To: Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, trini@konsulko.com,
 n-francis@ti.com, nmorrisson@phytec.com, d.schultz@phytec.de,
 sjg@chromium.org
References: <20250127041612.985929-1-w.egorov@phytec.de>
 <20250127062201.yvjpnf3vf36c4mf2@lcpd911>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250127062201.yvjpnf3vf36c4mf2@lcpd911>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0031.apcprd04.prod.outlook.com
 (2603:1096:820:e::18) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AM9P195MB1046:EE_
X-MS-Office365-Filtering-Correlation-Id: f565086a-927e-4cf7-01e2-08dd3ea5711b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekg2Z01lR2VkQmh3ejYzMitUbEQzeFBzemRaSkg4WVhhc2ZTZGVTK2V5SzBZ?=
 =?utf-8?B?S0l6dGJhNTdIM1gvUDB1K3NwMnB0eTdkaUZtaWNQTXhNb1NPZkFtc1I4SHE5?=
 =?utf-8?B?S1gyWEt2b2xIa1g4TFNGWGR1NTMwNUZESHEzOVVyajhVNDJCblhNcW5jZFd2?=
 =?utf-8?B?YnBBakNxK0Q4aHh1bXNrdWVxWS94YU5BR3k2emVMZko2VWNMMndZdmIwQjR5?=
 =?utf-8?B?WnFUcXlTdncvemFmMHEyS0Z2MW1pdFAreWQ4SU1MVjZ1eTk0Q3cxNE0vb1RS?=
 =?utf-8?B?Zk5BYmVzTFM4QzAwc2lXZUVyZVNxSGR4M0xhYzVPa2NQNkdSRGZWNm5zTm1x?=
 =?utf-8?B?RzBWWTlPMWkvZkhFQ0h3VGwxc3lHekpEUzlTeUp0NE9tWHlZNXRIaDFHMFlV?=
 =?utf-8?B?VkJNazQ0SVJ0VmhtK0pTVFNlRTdUY05HMmloK0hkNm5US0U1KzdYK0xUVHRE?=
 =?utf-8?B?aUt3QUhYSXhSZllydGFZc29pREtqK3Q0VlJTM0FDcDJwZWk4M2lYN1BYS1lJ?=
 =?utf-8?B?K2JXQ2htMmdaKzBRbEpVekticWx1bHZrSngvbysxTGtwclJzcFNiSmZxcTBu?=
 =?utf-8?B?ZE40SXo2UU9aaUY3KzBRdGIyQzBBcGtiUEtWdHBFQlI5bCtCL0JpRVp2bitW?=
 =?utf-8?B?SjJ6Z1FCVkVQRE9QT1ArMzBLZWRlQ2c3VFI5elNYdWZadlFIMENLMWNuQzJ4?=
 =?utf-8?B?cytQVGxhVzM3SUVOY2NxWTRUR1R3SzJKNmlmS20rb2ZFOUZrNzdMWlJaVG42?=
 =?utf-8?B?N0lFT0YzdC83dC9PTFBaMTFIQWw0SVNoTitTNGk5ZEhUbU1vbEJCYXBmOERL?=
 =?utf-8?B?Rkt1L0dOU05zdWNhT3BtM2t1YnhsbUJ0S3NXN3JuNmJhaE1nK09kUjA1Lzdo?=
 =?utf-8?B?eEpkWWhON2c0ZEFWa3BXczFPOHU4T0o3S1dmM0FBTkw1T3ZPbzJ4aE1ISno2?=
 =?utf-8?B?S0hNZCtmWFByWFdubE16TnljTWMvL05SVU0wVXNOSWpNdnFJOTJ3d1NtMUo3?=
 =?utf-8?B?WWhFSUNZRzF1b1JBRmNSN3FIMlBETHltRmZnUkNaOGYyODV0TlRtSWo3VlZG?=
 =?utf-8?B?RDJ5YkZnZHlzVzU1M0tzY0o4VVM1MWsvMXhnZHdETVVYZS84OERiMHpuT2hJ?=
 =?utf-8?B?VExsenRSTGl4Y0YycWlJQjVubHJEMjB0N3RaTXNrYmlVNG94OGZacU1Yd0Jm?=
 =?utf-8?B?aTh5R1NQQlRRY01wMUpNbFpEZzNKdEoyWEhrODVaYWhOc1owT0dmTzNOWUpo?=
 =?utf-8?B?OWNCVy9nYXRtSE1vSnFLb2c3b1JIRWZoUjUwSVV3VnVUQllNdUQyeElhVWpO?=
 =?utf-8?B?NE1veUdoOVZMR1BNM0EzV21pZmJjYTBOQVNBOXhoVzlpZUtTNFhzclNuVDVy?=
 =?utf-8?B?MG03UjVJT0JoQmJodHJVb3dqa3puWGhLRG5uNVU5bytad0RncWFiQWZpMHhh?=
 =?utf-8?B?L1p6dG1rb2dpakhtSEZOWm1JT0ZsZndhZVlvWWJQR09tQ001eVY5NU01SExj?=
 =?utf-8?B?ZW96T2xWeGI3MFY5VHNMTEowd01KQnoyMlJieWNGZGZwZnBVM1p2eUIyeEpZ?=
 =?utf-8?B?bmxxczNzTG5oS1IvWVBqZkJ0NTJXcmFJbUhRN2NBZDFkTmN6ZUdlS1c2bEls?=
 =?utf-8?B?ak9Tby85OWNDekFxQkVkV3Jmdlk1ZUE1Zng4TzFtSCthdU5MNFBEQm9oZTBl?=
 =?utf-8?B?OFp6Yk93VzZJaElkSkJIVCs4SGhwT05heDZzNTlzT2lmeEtyS3RhbVlNTVZN?=
 =?utf-8?B?MThpVis2Umh1VWxrcWxwdE9sWDcvSXZDaFJkYThHbVFpMit4cnVlL0JnV0tU?=
 =?utf-8?B?eTE1R0lKUE1MUTFnMkppZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um5hUk5YSUNyMFhya3I4d0tOS0ROdE9oMDBORS9ad0RNMHZFMmgxOGZZOWlk?=
 =?utf-8?B?NXorWlZiUFgzcDlFNU9GU0xSdzNkTUhqN1Q1UlhqK0NXVm41SXhQK0VkdmFF?=
 =?utf-8?B?WlVNc2ZOUVhzQTVtbCtPNmoySWdXNXRISW55eWFNUFJBZmdJek1Ob0xWQm15?=
 =?utf-8?B?NCtoK3l3aVg3LysxcitXcENyTTZWdGVRQkRkTTBCQ1BOcjBuUDNITjNpY0xi?=
 =?utf-8?B?dzE5b0dkL3FORUF1VEoxaHB5YkV1THFIUjQ1RWk4ZEg2SzlzdHNCOUNTd2dr?=
 =?utf-8?B?b2JDNkZydHJUMTcveWovcTRPSVAvRHEwWTBWMVNsRi9ZSmlGS2E1dmJlQm1j?=
 =?utf-8?B?cks5RW1WM1NqWlk0RTgrS1pnRHpmOVlVdmpyNFE2MW5WbXBxREZMUGFTSHM2?=
 =?utf-8?B?d0hSbHlYMTdDaTFJYjd2ZkVmR1BVODlEck1qNmhGaDVkYkFHTTF6cDNmSTRy?=
 =?utf-8?B?bk15clBvVU91Vk1IYThKTVVhM0JHdkp6UFQrek5KU2hUbnJTcjZjUHQ3VTRx?=
 =?utf-8?B?c2luUFMwMDhSTTd1bjdJeFA3UWFnc0prd3lXdWdRWVAyd1RRVHU0RU94RTJr?=
 =?utf-8?B?Mkhmekp2TmRxL3lkU1Q5bTdwRUhkZnNsVHNBQXVJNXpmdERmZi9lY0o4SFRl?=
 =?utf-8?B?QnM0OVc1UnM4ZldUNTdPdXY3RFhROW5YSVdzQXdFdXdXb3llWXNweTE4VmUr?=
 =?utf-8?B?WnBITWVCZmdXN2pLV2ZHWjhLWGJISzZVMVZPMDlkb1pSakMyenFOajJqNUtQ?=
 =?utf-8?B?eXgwWEU2bTRlRjJ2a2NvRFpzVVVEeGd0K2xQRzBiVkNQaERMSFhYMkVVc0dv?=
 =?utf-8?B?R3ZUeWlPUjBRQVBhQXZXdzR4cmIzREh1K1pBT0tzUEZ3cXo2Q05iL1VJdUVM?=
 =?utf-8?B?c3owblVRa1ZTQ3lSZmtHWWFkWnBTNnFrNngvWGNXbGd3WG90bklDNklMVFdj?=
 =?utf-8?B?NlpsSEJXcVZieUVLTVNnSUdLdUxaaGc4QXEzc0pvV3d5N1g1UTgrQzB3NHZH?=
 =?utf-8?B?bWt2MU1oWm1vKzBDbG9DdjA1aFV0MmozY3FxeSs2OHRydUlna3BOM0twZXNp?=
 =?utf-8?B?Nm9aUUpOckhKQjZnUzd2TEdNM0pkV3Nnc2JYa2VoUXhXdE5SZmJPNkF3ZnFj?=
 =?utf-8?B?blhHSzFNdnNvSkZFWVZ0Vk9UZ1pycUpMVWNZbks2Q1NsUTBSMFY4TVoxWXlT?=
 =?utf-8?B?Z0FWeCtlblI2KzlxamNCdis4RXBwKzVDazdRR25saWY1RGdqTEgwODU5QUhu?=
 =?utf-8?B?QlJxKy9QYmdqalVnY1hCY0dwd0lvaG8ycEVpQkhDWm92WHIvSUpKYnBQWWxV?=
 =?utf-8?B?ckdKS1JKK2tySzB4UG4zUHVMVVJPT3YxeFJ1RFdFTzMrekFnSkcrWTVkNWw1?=
 =?utf-8?B?enZudnhIYmpwY01wZ2R4MTJQc2ErVG1CcHBqNFVIcnV6SDV6T0F4dmdyU1pV?=
 =?utf-8?B?RmtYeHg0OXJXemdsY2JSSjJkNERqSzF5bUF3VjZPNVZqRFRGSFFDT05KYUVM?=
 =?utf-8?B?OWcrSFN3cmFwN0lWZGFCN3VEbEZvK0xSbDNZb3dqMFZBdVBRVjVTN2FPVmY2?=
 =?utf-8?B?ZUpwc1pORXRROFFNRDhURUpBaFMyZlhHem1JQXlwS01VUE43KzJWTko4cWFH?=
 =?utf-8?B?Kzg2KzJ4RDJGZFlpRUxnNUovNlYrNjVHclU2SGszNHlhTi9zZUJjcEFxZUFD?=
 =?utf-8?B?NWxrdlNQRzdUY251VGdVYVVNK1hEWWRZMFpUeVRTTlRCRUFvWk1DWW9XUHlV?=
 =?utf-8?B?aWx6SVNRc0VBeWl6ZnpUZHdtTXpxR0VwVnlZRm5ob2JwUXpacy8vNUg3TTYv?=
 =?utf-8?B?M01mT0lpNkp5OTVXQVNpUURZWFhET0ptS3gzelJnSWg5VUVLMDB6a1VzeWJH?=
 =?utf-8?B?T0lQbWFQQkVPUUhhZFE2blJMUVI0aTRVeVk1bnQ0N3h2U2h5MzZVa2lTa1hW?=
 =?utf-8?B?SCtJdDVnR3hIcExCT2hQWFhCdlhVZDhtNzd6enZSM0d2OHFwWncyWkVEOTV0?=
 =?utf-8?B?UW1HSjdGRzJZR3pRenc5dWpUUzhPa1hnem5FdmNWVHhGVkNpajNJbGVGeWZl?=
 =?utf-8?B?aC9tMDErZkdwYzVlU1ZGYms3MmgyTkFIbXBSdS8vVldJazZUbktIelRidi9F?=
 =?utf-8?Q?lT1QGTRQbDORNa2CFAR8kyWpi?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f565086a-927e-4cf7-01e2-08dd3ea5711b
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 07:37:24.7742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXPH4YAFJBEO8VE9uRziw257mF3u6wmTgSCoAwRKEUxycg1bHbRkwfdtGaGViZPg+UIwZVp1lDenC1qqShkwbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1046
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

Hi Dhruva,

Am 27.01.25 um 13:22 schrieb Dhruva Gole:
> Hi Wadim,
> 
> On Jan 27, 2025 at 05:16:10 +0100, Wadim Egorov wrote:
>> Add bootph-all properties to I2C0 nodes to ensure the bus and EEPROM
>> are accessible across all stages. This enables reading the SoM
>> configuration at any point during the boot process.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
>> index 8f3c3a185ae..c68a48678a2 100644
>> --- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
>> @@ -72,6 +72,14 @@
>>   	bootph-all;
>>   };
>>   
>> +&main_i2c0 {
>> +	bootph-all;
>> +};
>> +
>> +&main_i2c0_pins_default {
>> +	bootph-all;
>> +};
>> +
> 
> Can we not add the bootph-all property in the kernel DT nodes for this?

Yes, adding bootph-props to the Kernel device tree is on my todo.

> Also, I don't see main_i2c0 in the kernel DTS file for this[1] platform. Is
> there a particular reason to not put it there?

It is defined in the som.dtsi file

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi#n264

Regards,
Wadim

> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> 
> 

