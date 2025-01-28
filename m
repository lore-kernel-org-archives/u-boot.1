Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0B6C0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 05:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F14381727;
	Tue, 28 Jan 2025 06:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Cs1TiHCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB798186D; Tue, 28 Jan 2025 06:02:17 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312DB812BB
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnIoVRKAL7DqU9/P0Kd6MPK0T0iWg3yWfEASLCo63C4kHs0Kzsb4zRGBjk7meUZdyOcDVhk792ncMpFNL3vBUj3tw+GWVMjMr0AYqPEzE1om5YWucvgzJkRQOajgdIZBOnsy2r5OSDYA5SKA8Q/QsRUz5ma4RPv1iWGa4jQwZArdxlIEoBJgJ6eKji+eJIwDolNO24GqnlqjzvRwozNE980gblZsuPFDtyOFCcc6VCIQFgPxELibnNTbi4dwfd+Y3wBzLtHtdV9ZgdHccL8l0lSuCORefQIYr0y7JPPBNAiTJCks2BqExFLyy9jXA77qVymIgNLdzWpi1FPvg+/wRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0AheNeK0mN17Xz6LWsi37pNcpqQhOuvVPAAlq71wKU=;
 b=Znuvn7WgGhu6xy/N4uok7lJeRb/cUz+vvmOEn3ex1DsPwSCpo3SeWPeZc+B1lBQ80/LQlrjIo37HEJRga63rfqBik0JUzrSC0YGXHAYRFHy2OJSv4bFcD0DjLN+aOamjzepBLe0SlXuL3LkH5GXus+gDB2Iz/aKpaFAgoh0MhiM6CYRvaT9248z2yhpW9e8615aeDEa8LcLjres7WRb7tmdWQt0jVZYLsbGaPgGzUfPtyj/BiZEUP4hcJNC9MouopXW46pFTtZnKfmTU+dnckrUcgydoUBTk+pDWnpkVMJUs7EAHbAY6Vi7FiVMJfGCjCv21o/Nwc7ik3I9NbKT7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0AheNeK0mN17Xz6LWsi37pNcpqQhOuvVPAAlq71wKU=;
 b=Cs1TiHCkPOu01VTcJbfY7s8gTLzxMr/tOXcKhxnegIxkA/DHHYX/YKfpoY9iR+Z7Rnsh3pqcjNPqLbvyqo7yGEYdJsg6xqzkQ9Ap0br7B85+xO04PlI5Bbj7Ul1cDmpq65JYyz3gMjNEcutQ0nAqRW4t6OhitNBDLTCxRE8EixXLBhlS+wkFgnVOFG7BjaXkeoknj+11qeQWon3G4ZdjNDqllZjz2mXsOsT4W2x3LVwo5J5bMcNfkf/4eQ2gc8HFgChTqd7SXatHDwKBZowonAW36P7VHBdmYGaeiF4KUIfPhItfsOyPUs1SAvtXLHVTKYMdOcZ8Xf2FlSNKI3syGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PAWP195MB2350.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:366::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Tue, 28 Jan
 2025 05:02:13 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 05:02:13 +0000
Message-ID: <e9ef023d-0e23-45ab-952d-248514bb2bf4@phytec.de>
Date: Tue, 28 Jan 2025 12:02:05 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] k3-ddr.c: Remove unwanted header files
To: Neha Malcom Francis <n-francis@ti.com>, trini@konsulko.com, bb@ti.com,
 s-k6@ti.com, marek.vasut+renesas@mailbox.org, sabiya.d@ti.com
Cc: u-kumar1@ti.com, u-boot@lists.denx.de
References: <20250127142217.1757300-1-n-francis@ti.com>
 <20250127142217.1757300-2-n-francis@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250127142217.1757300-2-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:820:c::22) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PAWP195MB2350:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d74c4d6-634e-475a-07a9-08dd3f58ed74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDYzdlpSME96TG9RNkoxTkx6ZjhrQVV4cmMxOFZnZmU3dFlzMUFJUU1xV3RU?=
 =?utf-8?B?U09rT2t2SnNOcjJXdldHazVQczJzR0xjbEp2WnNEOEhtWkdGeGloMTNzUXJ5?=
 =?utf-8?B?c0xsN1FOYkhxd0VGcFZYQWpxQ1lJcUFTSjBxM1pkY3B1djFHRy9ZSUdyQkNu?=
 =?utf-8?B?aHltaU52Z3dNa001bEowbnVPaEJaYmFQQlNIRDNMaTdwazV3WHlBVnBELzA4?=
 =?utf-8?B?dHAxdVg0WFZmbzhTRTJyOFlmNGxYVnJZY2pkZ1ZDNlF3eGtDbERaSHE5SkFs?=
 =?utf-8?B?Qm1iMGRMcklSbGlRa3l4bWMwNkk0cGpvNXZ0ZENJWXRqSFFnQlNSOTg0azZS?=
 =?utf-8?B?NzRybkpDNmtxWldvemFycjRLODhIalkySHB6VFRreGdwWEhrZUhFVGlkemNE?=
 =?utf-8?B?a0lqeHpBQStrWGhDNkQ4d3FOOGVKMDlFL2M4MkVoUlE4cnZ2eTBBN05lNlQz?=
 =?utf-8?B?KzNOMlpVV1lpRzhjVU1wYWZHMTFHWHZ3WHFuK1BhUEN3UTBONURpeUMyRldM?=
 =?utf-8?B?MGVVQ2RSUE03WHlLRldoUVQ0QjlYanpRUVpMaXJzRUxNdVRZeTRsaEhzbUI0?=
 =?utf-8?B?emF4ekUxSWNPU1lkTVBzRmp1QzVkWTFiRUxWRTNmcldxSVhXcFNzaE16ZWV1?=
 =?utf-8?B?aGJBT2doRHo4WnNTZnNTVXkyVWM1dkUxOExVY2NUcHBNcU44OHFqOW9UdW5K?=
 =?utf-8?B?aGZ5UlJ2QjRRdUVPVGk3bGZkWDJmMHF6bkRjR0VrWUJ5a2h6T3kxUjJLY0k3?=
 =?utf-8?B?N1pUTjFUcnN2Zzhxb1pzbVA1eit1NzZScWdHZVFvSGxHNjFvZjluU3Q3RUs2?=
 =?utf-8?B?QXdYS0VJL2NEeXNjUzJnbW5zTkxTOEU2Q2tGT0ZkcTRrNGJOWVVMdC94bnNT?=
 =?utf-8?B?aUxLZ1FmQmNucGV6T2daNEdOOWxGWFFscDRqZkZxN3RRMDZ6ZmtuV2t5dG9M?=
 =?utf-8?B?OEQzaSs4b1NEOVZWRUlEWE9vUVE3RkZwd203QUlvSnQ3cG9UNUp0RlZmN0ht?=
 =?utf-8?B?am10WXdkbzVvNWVFOE1wWXB2U3FOcFhudnNKTnh5UjNlZWcweGRoWFErNDIz?=
 =?utf-8?B?K0kwME9peU9zdWQ1V29JVFplY2psMnRqQWx5NS9jZlhLaVRyOWExeCtETHJE?=
 =?utf-8?B?eUtBVlJHamRheHl2ZENuQTN5NEZnZWZac3N2RGY3a1lnMmltbnVSLzJ0RElB?=
 =?utf-8?B?VUMzam5RMkw2TmpvNnZwbGNNWnlyRUdhSEN2cHBhbnBsWVBtdXBXZjgyVzM3?=
 =?utf-8?B?aHRveVZDMExPbEliSXQwNnlVZFRLYnJYMlNLUS9WSmw5aU9tZTZxdWFncnQy?=
 =?utf-8?B?c0JUZU5rSU1WTThjMUpuUktOc3hZTHVSR21jaHlPalE5eW5mQ1dJckZ3Z05M?=
 =?utf-8?B?aXYvTWJRYVBJZkwwQ3lVNEZOazZ3YlpxNDNCRG5mMEJiV2dpY1J0T2hSd2o4?=
 =?utf-8?B?R2RiaDZtYTdlWllkTUp3cm9sWVY3aERwamZUaVRaN09ucXJyZnBNQmwvUllY?=
 =?utf-8?B?SElydTZTbnVyeXdxd0d0bTNJVXBaaDIzVzc1SVpkcFVnRCthVElYQ05sWStP?=
 =?utf-8?B?VEw5RDU3MnVBMDRYd2lkc1A2TTRPZTNZVk9VSW9zS01LaDd2UFlMblRHc2xF?=
 =?utf-8?B?cDdodjNWT0hicnhQZzVmQkVISHNsbzF6Y0VNcDdDYWluWjBrem42c0t1WFJj?=
 =?utf-8?B?MEU1T0g4bUxoRWVQeDhoa05aVzY4YjhMOUwyWGpIU08yaVhoY2lWK1g3Y3ZL?=
 =?utf-8?B?ZVBhaHhicFkxSllzQXhTSjg0WUJxTEdqSlhEWjBEaitGakFEd3R6Uzd2bHNk?=
 =?utf-8?B?MjhsbGRvZ0F5Qk00cFJqVFVzazJsVlZUc2RuOWlJcG9xT040UkRjVVlNb0s3?=
 =?utf-8?Q?GwK9s89AdBYi+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2R1RGlaN1EvbmUyNzFpUEhIVkJldWpVNHk5TmpSd1c1M3FJZ0RkbnpiOXpo?=
 =?utf-8?B?Z0FqeHhWR283WksxQWJsSlBYRU9lc2NIYlBQeEo5Ti9YZjRVMXZaWDZEcy9J?=
 =?utf-8?B?TEVRR2hpdXRHQ28zUjRzb1RsTGZDK2lPTXMyZmN5dW1rTVR1c2xvbTZPRndR?=
 =?utf-8?B?RzBwc2lKM0JOalhWdjQ5M3dKRXRmTWtBZVEvcjhaK28xeFVsbG1ORWpwamwz?=
 =?utf-8?B?S2xVV1BIYjRQeW52T0FWT2xuenRlVS9oVmQvb2VhejNIazd6Qi82VUhYVjhF?=
 =?utf-8?B?RVY2eDVjWm9WWkpBaXlqZ0V3Rks1K3dKSExSRW1mZGhWU1hvMGthb2RyVDVM?=
 =?utf-8?B?eDhlMHQ0bFF5elpKMFIvYmtodFp1UFBJT0Z2VnJKb2JQQS9UN2pBd29MWW55?=
 =?utf-8?B?TFlYRkFCRkhXZXNkaTNjeGp1a2Y4OGVFaDNlNkNNanZGUnpka2tWNnVWSnRE?=
 =?utf-8?B?Zmc5bTJORXdWOEZoMWc0T0l4YnFXbmRKc3JzZElja0t4OVBWRy85UG50V2JH?=
 =?utf-8?B?ejZmdGFmUjJYTFdNakpPdGRvV2VBbG40aUJPeldBWmZERWp4djZPbk50L0t5?=
 =?utf-8?B?ZzBiOTFhemhReTFxYlJocjRERUwrT0ROVW44RkpZRXNrMU1uUnpEaWV1cDlo?=
 =?utf-8?B?VDZGWjJlNXJjT2FSWHBwYStSUG1UKy9oWmRZMnIrOW80ZGx6MWRiN1ljM2g4?=
 =?utf-8?B?NGtlNTdNMXgybXN6VkdnK2ZoSzd5Nk0weTFBN3VNUFhSb1BYNjJIRHNUNUNR?=
 =?utf-8?B?RDlEeVZvRE1XZjNGQ1VLY1BzL0RyM0swZXo2WGt0ZHBNL09jOHhlODNkVTRM?=
 =?utf-8?B?Vjc2ZHdPNVFsY2liZVVGaitOLzBTdm1oamdncHpYTDBBV2hRVStCT1JBUnVG?=
 =?utf-8?B?ZERVaSt5bExMeU1ZamZhYlNrWlA1L0JhZjVYZlhJRUpLSWp4R0hnanA1MU9C?=
 =?utf-8?B?UjNaU3RIUXBmWVFIUlp4YzBtQmhsWmEvd1BXZXFmRlY5Vld1TkZ6eDRCSHpH?=
 =?utf-8?B?b2hrRk04U1FRTGhLaEozeFpycmc4SmdXV2dydDRqL1JDNUJWQTZZSkxKa2hE?=
 =?utf-8?B?ZXBXbDZWSGdDTzNValBRcXFrd215c2laVi9PQ2xqRVllQmJxS093b3R5RW5S?=
 =?utf-8?B?dVZnRHVoOEZoZWZqekRERnF6M3VQc1lFVGtkRGY5OC9oaWd0VCsvM0tSUi9a?=
 =?utf-8?B?YmJpQWFOYzdBbUdLSzl0TEtrUjZ3ZnFqakJ1bEw5VkthOFVCSXZ2LzYyUGxt?=
 =?utf-8?B?ZGtSdktKWnFGSWdBcWRqVDY4V21VRUxkQStqTlR4NGZhNGdSUW56Vjl6cnR2?=
 =?utf-8?B?eS8vS0YrTkltK1dIQ2YxSy9JYUhwWHpNSlNlQ2U1WDFBMXVNdzNpRHVxY2pX?=
 =?utf-8?B?aUxqajk4ZkhrVVlHODVCM281NytVaTE0bUg2eFh5Z2hrZ21pcFkvSVI2dEZF?=
 =?utf-8?B?dGd0bndkTVl0dWRYOXhUeVZYRTRtbEREajFhWkJqVi9OekdwZXlQTnNlamd2?=
 =?utf-8?B?bGpjVDg3anZjVllCOVlBYXRMNm1LRWs5VGJnU1NJd3BtSnVZUGxKS2JJZGxU?=
 =?utf-8?B?ak82NE5ZeHBNVC85MlJlV1M3ZWE5T2hPTGk3Tk9maWtidkxORVhRZVc2Y3JH?=
 =?utf-8?B?TUFvTjA4b0Z5ZE5nZDJ5QUpFai9jem9SdmRoV1dRcjRBaWVxZFZpL3UzaW1o?=
 =?utf-8?B?cFlDR0N3ajl0VmhVbXlqQ1ZINm9CQ1FucUluZVhiaytwcTkxblJzd2pxTzBX?=
 =?utf-8?B?Nkc0dUVwS0cvN0YyMmxVZlhQeHlzcnNCR0NSZXIvMnBkSE5ES2QzK01INFRn?=
 =?utf-8?B?TGJ5RlZsZ3IrVFROWjN6ZFptdW91VTczTmsrTkZITFRtZDZGMXJuU2hBWGww?=
 =?utf-8?B?QjZZajErdHFOeWhyMGM0V0tkZUxDZnF6OVVNeG42cTQ3bXgwT2xNdW1Db3pi?=
 =?utf-8?B?Zi9TZ3hROE9wYnlOZHY1cmthZ0JEcVBCYkVQRzZ4RUJMQ1Z0UElOTWZmKzMz?=
 =?utf-8?B?TGpvMXFabE93YmJOMXVOMEZXV25TcUorMXRnM2RFMzBrdEtvM0dsempBejdR?=
 =?utf-8?B?NytBYzlvQWEzdGlZSzJuWmpnY2NTQXlFK3FWN2VzL3ZZNWZMK1hLK21Bdjh2?=
 =?utf-8?Q?XpCv01dnLbvm0tGI9GVekgqp3?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d74c4d6-634e-475a-07a9-08dd3f58ed74
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 05:02:13.2777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sn/l65AcCrMomyZ4ezQ3MiDLQXM7GGZxDMoXGR4d+BLYYsjKF3CP418v8jJF0mbXXXgO2rAuWS+tMv38YHUNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2350
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

Hi Neha,

Am 27.01.25 um 21:22 schrieb Neha Malcom Francis:
> This header file is not in use in these arch/board specific files,
> remove them.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/mach-k3/k3-ddr.c | 1 -
>   board/ti/common/k3-ddr.c  | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/k3-ddr.c b/arch/arm/mach-k3/k3-ddr.c
> index 6e3e60cdc86..026381490da 100644
> --- a/arch/arm/mach-k3/k3-ddr.c
> +++ b/arch/arm/mach-k3/k3-ddr.c
> @@ -5,7 +5,6 @@
>   
>   #include <fdt_support.h>
>   #include <dm/uclass.h>
> -#include <k3-ddrss.h>

k3_ddrss_ddr_fdt_fixup() is still used here and the compiler gives us a 
implicit declaration warning.

Regards,
Wadim

