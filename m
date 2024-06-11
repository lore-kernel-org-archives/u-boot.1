Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA602C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 11:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05CE38863A;
	Tue, 11 Jun 2024 13:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jNSAb9/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8550D88644; Tue, 11 Jun 2024 13:02:29 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702E38860B
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJwEOyvOdhb1Ahr/BDG1UlE1dkNIBNk28K4uqqDV3AuOadTDcuXd0z+EAuJ8FxfEdG6EJBl+Fx777hjSuKrQ2jMzP9hMdlzLjJj1RNqzGyW6Oxhk/WcbYQ+aj7Rca1g95hV4pgNht6Nl1wPtmnHBNRtK7UHvFiSUqzKjCvyGCSj7bYGlLxhI55fYdvGrzQ5DgnHXRUCV2ETFyUClqpn6w1wJEpctSkJPZBoMm+Ohr9S/3NpCFOLHScYNwmhbWjGkFGvSdCWBHKBP0Yre5WkzAtfwNWdeOrKJE8V7QotnTV+iP66w7nHEKTnVnaEXcBWKqo2mxOLfC/9fjrHr2d3AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jAvTnxUka+BnuLFRrioRtkkppSDuweKnApLaIyNdDw=;
 b=N902Wu/3l2XD5xjjZ4YtY/cWlMd1Qxd7r1XZ/ANkwZDubrYDaPAFgBH62IuYF68N1uUuCuEOhnIkf1/rtWGbUfBuRR/1fIEqfB8N+MYjCgbJjtoEJRn0istt7x/wcdBPtiPa+0MkMJEsIaIthtADKkj1jMI4BVxtB6EW3JM35p1WiPt8LkXM7bDBBVq0sZwLVvXjq4Re+7UKno7n7TtKw1uPDp/eH2zY3I0F/hjUPFGGqzkyaVxHBj5OKxB08GVxarUl9LkbJvBA08qDW+GslvNIo+3hpTSjCeJ9ioAhk2Kjx1urfCI8fIg6ldWfwhTRYA30/Y1yc3donWfDggQouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jAvTnxUka+BnuLFRrioRtkkppSDuweKnApLaIyNdDw=;
 b=jNSAb9/u+ZBKwacULa8CW6fkbeh6hi9MK9AU0A2uvVRCiPKtPVBgHFvyTTGh25T9lk+IsEYRmzixoxsRFHHu+K2ZLN9DmB6+t0pbWEVG4/S6JLi5bvRQ59F0o4I0j+VlbtW8XK8gJ0HkbLwJwNrmsywqAxolpruBeI4DMykFiPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 11:02:24 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:02:24 +0000
Message-ID: <098b2148-cd54-49c4-b769-81531a18071f@amd.com>
Date: Tue, 11 Jun 2024 13:02:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Setup multiboot register to 0
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <edaf714a778bdd7447533a77b3455e4fd623f9da.1717420131.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <edaf714a778bdd7447533a77b3455e4fd623f9da.1717420131.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0138.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 157dc254-ea66-4d6d-3da3-08dc8a05f950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am5rL09SV0xUcG9kbFJoSzZCVnRRckk3ZzVJemxOaU1WZUV6L2xaRmt4WGtp?=
 =?utf-8?B?eXBZbDc2RWxkenNPS0V1d2hsKzhlSmtzRlBoVk9ublY1eXBVOWRMenZpUFBQ?=
 =?utf-8?B?bVFIR24rQStmemVmQ2JUQzY4NDEzQkRqc2lnQVpkMG92RDQxYlBrTlVpbWhu?=
 =?utf-8?B?SGJrMHNlM3JzcnkwQTFVL0dUQ2ZSRUJkWWNvOFg3S1NINEVhTnFpYmZuTm5S?=
 =?utf-8?B?aGpleldQY0g5TEhSSmRtamdDU3dpa2Y5NnV1b0xMakJ6RnpleWNHRmxxQWNT?=
 =?utf-8?B?YjNKb01Xa09QSjg3ZU4xais5U0FGdVM4QWh0ZE9uMFl4dWpLSU9iQUlIQkZa?=
 =?utf-8?B?MEpXODNBTHo3YllhbEZXRHJBSUJCaDdlSVh3WnQ2R0wvazI0bVF3VnlXak0r?=
 =?utf-8?B?ejBKSFBxNXJGNlBMQUs0U05sNkoraDNZK2ZQd29oV1JHSml6ZFdRTkRwcnpV?=
 =?utf-8?B?QkhYVk53YnMzVHlqSlJjSVp2cVVHU0tIM2VyaTZKeTJMMzVFeEtLSStjQlRK?=
 =?utf-8?B?WnZIY09xUUdtM1BwUFhIZElUdTJYT1Z0Qi9SbHAvd2RhT1Z6OWQ5OThyMUJN?=
 =?utf-8?B?U0t6SnhtWUZSU3RvM2w1NEtXYzQxMktZUmRoeDJ2eThGU2RYaFVBUk8vVXdh?=
 =?utf-8?B?OW9XbTZjczFsYm9CNGg5ZURMR0tRYzM1WTMremk1MDhWTUd0TmowbUtaM296?=
 =?utf-8?B?VkhILzdDMzhka0VDMkQ5WkU1enBERURwa1NhVFk4Mlh5ZnFqaFBFVUV1SUpz?=
 =?utf-8?B?SUhMTXcvM1ZRZ0k5bGs5eVYvL1puOVFaSllrVklHREFQUlZoRHByZVFLTWlo?=
 =?utf-8?B?K3hZelM4LzBKaFdPZXd4SHlkME1XdE92TCt4YTZpSUxPN0dLSDNFbFBMOENC?=
 =?utf-8?B?SVU1Wk0vQUFOMER4SzMxeXRzdVVBMmxJSWRudlhBUGJZcElidFhVbVBxYTRW?=
 =?utf-8?B?eTRUVk1nRC9tZndRSDJvV2ZZU2IvSXUzRy9OcS9zdHRWY3Q4VDRRQWNIOFRP?=
 =?utf-8?B?Q1pwOWF1cXF0MkdsTnFUSnZycWxrM0N2c1BrQjZxeStZdjdKYnFwcWxsYmF3?=
 =?utf-8?B?RUY4N1FGODMwTUpNTFlsb1RBOVZzUElyNXBVRldqMEsydTRWeU8vRlNwdG9x?=
 =?utf-8?B?TVMzNHlaN3QwdXF4cXd4dmFBUFY4d2JHNkozYWR6YzExT1hiZlBtRWl2eHhR?=
 =?utf-8?B?Y0Y5ek5sSGRQaXVmbWZnRVQwdVlkeE9VQ3pmNy9hNDB4UFA0VkJaWTlkbTV1?=
 =?utf-8?B?MS9iTGowTTJ3bWt2NDVtRk9LdjdPaGFVcXZIaTFuckl5SXJ4dS8wZEhMcE1K?=
 =?utf-8?B?WDl3aThEKy80MitzMEY2NmJ1Mm13V20wdGRvMURkaHd4L3hmeEl5VG8vR1ZY?=
 =?utf-8?B?UHEzMUtnR2k3cHFERzFSZEtidXYrbEJzdUV0dDJYSitpS1ExM1hsODZ4Vm9t?=
 =?utf-8?B?a2VMejhzanBXbnc5WWVwZ0YrSXdjb3JVWmdidnZsOXlDUWtMM1c0M3RnQjZY?=
 =?utf-8?B?bFB0OHRzWTN3aUNhRWVva2g0akJuRDR2V0w4ZlRKUHJKdEhXUjl3b1JHYmJW?=
 =?utf-8?B?RzJHeEZXWGRHK3VVbnFLOUFoQ1JacDlFcUJIWkNnKy92eHUvOVdLRDZYaTFI?=
 =?utf-8?B?aEszUE1ib0tudDNYWDRzcW5ORUR4K3ZHQ29HYzh3SDhCd09OcnhoVHgyVThr?=
 =?utf-8?B?b1ZZbk5GVzQ3YmJqVEpSRG4xLzl1TjhiN3ZpSitFT0MrTCtmdkpxenZHcG4y?=
 =?utf-8?Q?9OSoHBO6OM49+tSR98=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHVYekZsRWVzOEw3TUg4TkRrZDgyZDVSUG1TcDdoRWN0U3NYTDd6Zk0vNXBN?=
 =?utf-8?B?OEJWK0xjVnpwcFoxWDIvdFRXZms4YkNWQlBJOE5WcVRFdlBTT2txRXBJdEo2?=
 =?utf-8?B?RXNTeTk3MThoQXd3WkhXVnJtSit6U1orR3VVQkVIMkRrc0xqRFhNeElpWitu?=
 =?utf-8?B?eXhuM1NoOW4wTFhsaGxSaGVMaFo3bVNFaGNDaDJuYXN4SU5PbklMaGlMQnVT?=
 =?utf-8?B?YmJCRUxuUHV6c2dqZEZST0t5MkNndno0SEhnU29yV2hnaE11SWRpYlhSSktU?=
 =?utf-8?B?WkpUUnhLVVdDU3FJQnl2UHhacEJOZlA1dzllS1dSMEJRN2svYlpGcXBRdW1h?=
 =?utf-8?B?eUw1VkhZWDZqM2dhRVlHUmN3VTVETndNemgrWjFaaGtOcDlBNFJaUkYrc2Qv?=
 =?utf-8?B?UU9OdHYvTndHZi9RUU9qYUk4SkI0OW9PcGd6c1JGMTliQTdORVpZSmp0YTRx?=
 =?utf-8?B?alJKOHRYT1VhWGhBUis5UGh1K3gycXRVUTA2a3RDdmdqRG1aQzIzY2FRZHJv?=
 =?utf-8?B?MjB6S3l5VzN4QlBFS05QWkhlY2xvTDZST2VCNGd1cmtma200ekNVOGtKdy82?=
 =?utf-8?B?T3F1WnZNZStZQllqZ256MjNtZStSYjM4YVlUV2IrQ0xXRDluQ3JjVFQ3MmlX?=
 =?utf-8?B?eGl1V0szYkZRTTlTZHRVUWtiNVB6eFJTWjhjaFJnWFpHY0lCNkpCWC9adzc0?=
 =?utf-8?B?UU52NFU1OWlOK1Zlc3RZR0dSM3NkU0MrQ3BoRWxhc2pNK1UxeUg0NVVoRXdy?=
 =?utf-8?B?M29YMGJlL2VWdGEvdHRmejFtZjlYbVV3M1Mrc0d3WFNUMFphS3JrN0doazN4?=
 =?utf-8?B?akJ0WG9iaU93OTRIQTk0Vzdqb044K0N1RkdHY2x5ZUdGSFNrNGxzNlFDTFM0?=
 =?utf-8?B?ZytqeWFOdWdwTUV2dXg1NlFZTFQyWjZpajliYUdPSzNKbDNkOFkrNllPdUw4?=
 =?utf-8?B?RFdkemI2OTBQVTZSbU04T2pGRGM3RXBFMEFBR2pXOGRVMVEvL2hpT0lVYzRF?=
 =?utf-8?B?aURDRlA0NGdtcmVrMThWcWRHWmwrNTRnS3M0M1lmS2FFcXY2Z1dZSmh3cFRW?=
 =?utf-8?B?ajlkSHBCU3VSVHZ6YTYzM215T05ySDRYWHB3NURwcUIxeHBXaFZRRHZ2aVQ1?=
 =?utf-8?B?ck53WDN2MjlOV29zMExOVjd0SW5aZHBaejhiaGdDMzVCdTJzMWthM2krVmts?=
 =?utf-8?B?Q2tZcitVUTNXNVk0Qld6R25RbjNsL2hIWjkwamNOWHgxczVuMmpnVVY5bW0z?=
 =?utf-8?B?YVg3MVdRMVk5QnJnTXJOWGhINjdxMXBMQWNkMXZHaU0zQnFEMk5aK1lsZEU3?=
 =?utf-8?B?NzVxM0hxTVpreURtYXNSVEtuc0hkMDd4dlpsTFE3TDFsWXlOL2FEUTl3eHF6?=
 =?utf-8?B?NnB6MjNoSkpmTU9EbFg3Qmppc042ellxWjVJSWhZV0RtOEVNR0NQV2tQWkZt?=
 =?utf-8?B?S1NPZWtQd3hsSUZuR0V3eWc3T0xEdFBHVzZhU2FYNHJqcE5FUHBXa1ZDbTJB?=
 =?utf-8?B?aDVONFNZdHR6Qkx3V1p5MjlFVXpUbGtVakVQWFpSUU9hWEpvVXJCaXF0OUZY?=
 =?utf-8?B?SGF2bE5VaDlkcmt5Wml4VkZsNnBxNzlFV1ZvVGV3TUtDS2tQSG1UMmFFNFdH?=
 =?utf-8?B?WjJGQ3Mvc1FUcVRzZFQrSWozNFdSKzJDTjhmMjdxQjJJbEt1Vkp0d05YRUNQ?=
 =?utf-8?B?NDh5dXdLOXFFVUpDZS9TMkRoR0ZnMVd3UWdMbElKejV6OFNVZnZFRVkrWWQ3?=
 =?utf-8?B?UmN1a0tlU0M0QnNvTFhpTUFGelh5ekh3ZWwwckQveGNZVU4wZ0hVVmVKSnhF?=
 =?utf-8?B?bHh5SWd3cE9nU0l5eHpiZXVGQjJyZkJQbU84NHZKaTQzSEZPUHJqQWVOdjVu?=
 =?utf-8?B?Ujdnb1UvWWd5RmhYVTJFZndGbkEwemhVakFKVG9id25zcDYvMlZqeEdSaURE?=
 =?utf-8?B?WWFpTmtNZk1XUGRWWWgrekFRVURuTUR5Y1VyUStDRVJSbHBVSU9CbmdkMEJ4?=
 =?utf-8?B?cWI4RStzWnUxdmJuVE5Pc0VId2traEQ4b2lpZ2V4UllnSEdXeTZxVHByREZ2?=
 =?utf-8?B?TnJSWU9BaTBWZGRIRU5xSkVWOXA4a04rMU9aQUM3ZXA1aFFGeVErM1RleitS?=
 =?utf-8?Q?9U+QYNY1kLCSYIwNcgfCco2AR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157dc254-ea66-4d6d-3da3-08dc8a05f950
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:02:24.4511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+MXiH4KSZ+9lKL0SE9/4sXGP3X6wTmuxSLkcMjegu7IaSF0BhRPSW4pmk1VXXH4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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



On 6/3/24 15:09, Michal Simek wrote:
> On Kria when board starts from Image A or Image B partition multiboot
> register is already setup to that location. When reset command is called
> board is issuing soft reset which start SW at already used location (offset
> of multiboot * 32k).
> But board should continue to run from multiboot offset 0 (start of QSPI)
> and call early bootloader every reboot that's why clear multiboot register
> to 0 by default to go that route all the time.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 846eceb0118d..69e333c53887 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -65,6 +65,7 @@ kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw nod
>   tpm_setup=tpm autostart;
>   
>   board_setup=\
> +zynqmp mmio_write 0xFFCA0010 0xfff 0; \
>   if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
>   if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
>   if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;\

Applied.
M
