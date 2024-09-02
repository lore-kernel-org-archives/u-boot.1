Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328F5CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 08:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743E288A30;
	Mon,  2 Sep 2024 10:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4+/EiRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7587588A30; Mon,  2 Sep 2024 10:43:56 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D96088A12
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 10:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O10NouA4Vo2zLeD0R+6aqknVm2X1/Osg2M2eQaRLrdq7qLIAuhdqR6uWbGGaov9+oqBzqQK23Sv1yv8lYkglIB1e4BflSBkP3491KELW/TsjQWngdWDeVCt3RvOTMKMfO6HV3rP7bPeQw5aHTUyXjRkI6gW4N8pG2tXR5iz1J7MCEJUYobV/0ScYyIaYuFQA8MV0uDnWoXkhCnu+SF9t0HbiMUQlDL99OSFCDBhq/7WpC6v+1c6yLIWkOP5JOqDjJykZfDIwhUkxaGx6guK04CXpLDqBHYSoUYcMjuNjMgZ9WdxkDAdxZsBdJ8blocuGUxBl6OTSH7pCGJcMyP7Ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KEiF5aW7/wQCzDHmFDzje4fGq1ThxTtFngGohJuQms=;
 b=kV/rHtW50GdtZs5Qjpd9b1IW7GtC/wOUee2D400yhzKAN6fqtHAK8dYcRLS3lWb6cr/dzOiXGpu+jpCwggeqEXJjYQsEDlc95TLnrjqZsK97W/lYT+BegP1IjxbBn8UtlQ6UKbNF0cVIPz4qxuF1buESc14dU1/obLtskoy4tShtX90GZSA58AZA9QZpIMKPYQXEEd2t5VkxFmStJdOdOjVg0AFjbb5e2P9vEfSLastHQ025JXGO3lfDkEtVfLh6GB2GiwLYrk/hU4idaY261eallaOwjTB9Qa7REeCik39JyEQWPF423mH9g8M+IgiJzhs22UEyTGHnvxMsS1dgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KEiF5aW7/wQCzDHmFDzje4fGq1ThxTtFngGohJuQms=;
 b=k4+/EiRsMBH19Sv3A5VBLmn5Kc4PfvELfqVATkGi64FmhWJNti5f9EFmKZsSLVcZrErwUYJV/nveHRHLQUjVR5xUs6Roi7lcdZhhFgaVYkHiJvACtfgBIqx7AVed7sp+nquVS3/xHSJsCcgJCPEiZNwTV5dksFV1iuErU/quaI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Mon, 2 Sep
 2024 08:43:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 08:43:49 +0000
Message-ID: <7ffda5a1-e570-4967-9c34-d787cfd441b0@amd.com>
Date: Mon, 2 Sep 2024 10:43:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] zynqmp: Disable secure access for boot devices
To: Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@xilinx.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240812220735.3602212-1-sean.anderson@linux.dev>
 <20240812220735.3602212-2-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240812220735.3602212-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0092.eurprd04.prod.outlook.com
 (2603:10a6:803:64::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec764c9-fb1c-40d2-1506-08dccb2b5dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlRqUGZObHI3Y1ptYVlSaEwxYktEbE1vREFyL01BQzBhY0xaRXo0RUs0NklC?=
 =?utf-8?B?YmVvZVVkaUt0dmg2Tk1DVnhnOWJlM3B3QUx5MU9hN0VQNE91azhuTCtRaUFD?=
 =?utf-8?B?M2xVTWdYNzJLWG83YWFkTy9idm9ZYlpxL1lmSUdFTzVPcUpPRFVPbnY2VUFC?=
 =?utf-8?B?cFZSTm1HUEkvcUxkMkU1dUlDTWZJejkyY1BSSEdBZS8vV3IyU1dYRE03dDM1?=
 =?utf-8?B?RUIzZzVqQ3BINUgzYmM3QnV0UW1XTTlicy9tRXFwKy85c29BRWtRYkgxN1Q1?=
 =?utf-8?B?enc5YlJJcXpYUStHUFE4bDZsY29xTnVYeUNBS3ZtMGpQOWFFQ0NmSUxVWVc0?=
 =?utf-8?B?TDJDYmpoL3NKblNrQlpzWWdkMFY4bHZkTmhPOExGME9YNnY0VmxSblBjUVBo?=
 =?utf-8?B?LzBaNkdVSktNNFBUaS82RXBXR2VUcnBnYUVWUzBEV0loTFBtd0lLQ0VaMEVK?=
 =?utf-8?B?cXA4dGNOdnQrOVhjaGU2aEdVbFVWZWRkYWFyRHVNOGlwai9sREo1Zys5aDB5?=
 =?utf-8?B?TVVzODlCc2RjRnVOdVBSNjg5RWl5YkZJY2M1dTEyaDY4L2RibENNRjNaa3I5?=
 =?utf-8?B?RmdKVk5hSmZIL0ZwTU84RlZkRk1ER0s0Szd0Y05TL054MzRzellZaHBzUGZC?=
 =?utf-8?B?SzJyekcybi95UnIyR0lVMXdOSXRvSVlMYldGYSt1MFpNdUhtZGNQd0xoclh1?=
 =?utf-8?B?TzN6Ny96RVU2YXhwZVhvdzlzSVV3NXB0d3ZSQllyZU5ObUlnamRveWowTWdw?=
 =?utf-8?B?V1ZKd3NVQXBNanNqWmhzWEZJUmRnd04yTnhJeC9FZ2VSTFVpTlVuWUFyWCtR?=
 =?utf-8?B?ekdXd2Yydk9xekpDcVRsdGx0TGdLb2IrdEhzRXprSUF1UE80THB2dlpYbjJT?=
 =?utf-8?B?NVNMYlpGdFhwZTNKQk5MMW9xS3VPWVVmMEFPRVA3cmhYVWlkczA1bGRlaHhC?=
 =?utf-8?B?TklQUThQZ0pnVkx4RDFEa1M1M3NUTk9vU1dyUXZEMGJYM2h2Q0JVcmhHenVX?=
 =?utf-8?B?YmlmNndPdDZqWC9pNGcvYU04RGhkQW9OOUc3cUpnUlRaTDJZV2xnZkVCSThO?=
 =?utf-8?B?dzV0MUdUY1JuSjBiQ25lRm9OWkV5Q0lMYzRWOVozSVREUUI0Q01wVEM2Ymk4?=
 =?utf-8?B?SVhKTjhnOGt3enM2S01YR2lBMUw5MmNtU3lHWTZraDFOd2dTSHFpSjBBT0Qx?=
 =?utf-8?B?NmpHbWh2V2RMTVFvZ0lvaU5wQ1VuRDhhL1FDK2MvMFVwYUVUbC9lZEw1YWZU?=
 =?utf-8?B?SnpKUTB3N2s3RnRRM05Nb2hZajFMRG9DUzZlUGVZVm5KaE1GekRIREhSQzRO?=
 =?utf-8?B?MDNFU2Y1N2YwTUttTnVRbCtDT0pEYzhqd0xLSHFQVk90UEFTdHJONW9QZEZ0?=
 =?utf-8?B?Z1M1Tkp1Q1g4cGZCN29EbUNtMjBBSXNxazhIM2ExcHl4SkZ5VjhBa1hkbGNl?=
 =?utf-8?B?c2x2UjREeFU1R2grV0N3d3ptMmkrZUJXRkJhcXdRRUlIYnVYeVkwRnEzeWdv?=
 =?utf-8?B?T1lGZzc4dnBvdURIMkIwaWN4bUY2YjNCQTVMUTUySjkyTkRwSFhWSGczY1VL?=
 =?utf-8?B?OEt6MzJ3T2JJRTBwbGVaYWJVQUZvdEdXYkQrbDRHNGZacU1pWm52YzRhQjBJ?=
 =?utf-8?B?NkV0elExaXQyVkJtMW04eVZmM3ljMGhpZWhnMTFIUGVvaXVYYlBSZ0NYdFJ3?=
 =?utf-8?B?N2IzYUtQdzIrWHdjNHNSamZOeWdvbnRzZHFVVDcrbWxpclh0TnZmeEZ1Qm9P?=
 =?utf-8?Q?km2a+8ZIOt1mVnlimoVu8hLGPj8qXnUsfxeahGZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VXWElPTVlWL3NCYTdCei9JK1YxQ3ZFbmg4UUVPVm4yaUM3cXVYa0NhSmtQ?=
 =?utf-8?B?OUdPaWtCalU1ZDkzWWE1UHdYZG1XeXN5VHJhSU0zR1hLOTdER1hqQzFEZlBY?=
 =?utf-8?B?NXNQc1ZaLzdaUzNhOTc1bVNtWnJicHJ2RlZUK05jNzI0bktPVG5URlpzU09S?=
 =?utf-8?B?NFdVaTZhUWRrWmdHZ1NhRkFRNkJ1RHkrdWk3Qm5WQ1N2M2hLa21rOXJUQkth?=
 =?utf-8?B?VktIUFk1UnVMcEZraTFJRlVjYVdLaVNZa29OL3dVYTNGTi9KeUljMnNDdE1C?=
 =?utf-8?B?M043OXZnSEt4bVpjN3R2YnBNeFVaQWoxQVo3VTJJcjE0a2ZxSC8vUFF6ZGJn?=
 =?utf-8?B?QkN4Vmk1N3RrWXkyQVRSRFU2TXIvV2EzeEtLK0hNdksyQ3ZQeGI5eWpoK0ds?=
 =?utf-8?B?QUREbmhUNzFZQitpM2pUNVhGTm95dFhOcGxGQ0lOK2p6MWVncU5jUkJpWHcx?=
 =?utf-8?B?dytQYjhqbi9QSFVxLzRRdDJtN01YL2JrRXI2WmZpdTJEYjFDZlFHVnpyNXNJ?=
 =?utf-8?B?TmM2S0NBc2c3TDJUOU12UGtMUWYxUVhuSkMvMHJEcldzbzBrUEtJTE1FN1V2?=
 =?utf-8?B?aUVCU011TXhNMnpiREJSZ3RBa2dKQzZ1bGl2R2ZocGxJQkN5eEloWFJKcnUy?=
 =?utf-8?B?NHN3RUNsWGY5THdlbmRsTTJZZ1ovb2Roa0JTZ0dFUjVrM2NUUDRqOGxxU0gv?=
 =?utf-8?B?dFZlbUhxQ2FzNGtJajhJc3h6UVAvejU1VjFyUVI2Tk1jQzZ6aUY0NUcvUnR6?=
 =?utf-8?B?SjE1K0RkclZtT2E3T0NNVmdzcFJ1eFdYcnZJNDY5NmNuVGx5Z0hxem02RWQ4?=
 =?utf-8?B?bzh3bjE3bFNEcmFIVGdSSlhkSHRiMEJnK2hac3oyMUM5SzZmZUgzcnJMdWp2?=
 =?utf-8?B?QmR2VkcrOWp4Um0zLzFwS1FCRHVIYTQxVjVGQ3BjQ1RPTTNXbnBMcTJUamw1?=
 =?utf-8?B?ZGsrTWRkcHM2Mi84QW90NFV1OGJmQmpJOC8vRmZreFVjckF5SG9qaEZZRUtx?=
 =?utf-8?B?eFBCWUJ6VUdkdGVKUHVyc3haSXQrYXBuZjBhcWRTMXBjRE5NN2d1RXl2TUF2?=
 =?utf-8?B?dzZha1Fnb0tGOGNHNE44RE9vSlZxUnpZdkl4R3hEUGhFN0dseXZGMDNrbmxp?=
 =?utf-8?B?UGkvSDZNeDFrSzNsTUxtQVAvYjlIaitHVmJEeTBuWjVvYVNZaGlhWHZUYStV?=
 =?utf-8?B?NTE5VmsrdmNuOExuZHMvTU10bFRuYytZVUdRK3Q5Q25vb1FwVjVmM0RQRTRC?=
 =?utf-8?B?OHdVRGJhUVlSajR2b1c3K0VsR29oY2ExS0E5VWJ4RUg5eW4zMXVydk51eUh6?=
 =?utf-8?B?OFBYTWtiNEVDSEkvQlVaSmV0TWdnZHFQdkxYQWVRbzQrV0JFUnlsRzZ2Z0xw?=
 =?utf-8?B?L1duSUZ3dk1OMHMvektGZzFVWCtFRWdaZEt2dXVvdndkNUZycGFjeENSN3Jk?=
 =?utf-8?B?S2k3b3lQTlpFU0dzRk1HUWZZVjM5cm9QdUpEb1JmZzFKMHE0Sy95SFA3SXM0?=
 =?utf-8?B?VGVyU1MzREt2MFNuT3BMRS9zQmxHdGQ3K0pXSHNOWDFUOTNYaEthVkhpMzFS?=
 =?utf-8?B?aTY3QmlTT2hrcVFhR0Q2aGUzenJVR1hjUml2N3pHTmtPdm9JOC9EM3p6bThR?=
 =?utf-8?B?LzI4djcwUDdPMXVmRmlwS1lMUDg5VERnSHRwZG15RjUydlFqQ1ZOcm9GTi9l?=
 =?utf-8?B?WElNM3J3Rm1PWXNPRmVaZjhVSm96VjVPYlNUTFFvdkdNeitNdllxNkd1QURY?=
 =?utf-8?B?cUtONlRPMUJKcnlKM0w2VFp4bGxwaDFEUHBYYVJiTXBtM09Wc0NJeTNGYnlu?=
 =?utf-8?B?ZjhvLytwT3lNSGhXazZ6c25hVDFJVXk4YzVKanUzODlEdkhRSmNsZ3V5czNX?=
 =?utf-8?B?RXdXUXA0MGVCb21iL3RBRlhEc2FmNkdRUEFtNWxob2lESEN2OXdSUmxyelRi?=
 =?utf-8?B?K1pEaGl4Yzg2SCtlSHYwNCtUNjloOUVlNWhjRkNZVnlGMHRlN3hLS2I4T1pF?=
 =?utf-8?B?Um5SOGs3WFdpVWJEQkZIQUszcWpRQ2JJWkczMHVSRlJOWitwNVJxcWZ5QmVR?=
 =?utf-8?B?MHUzL0hwbm95ay9OLzhzeDUvemJpckF5WHBCdDQ1b28ydmJrVFZCYm1ySm1n?=
 =?utf-8?Q?Xr37f0C/BWkC9gpXR58UjSN4D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec764c9-fb1c-40d2-1506-08dccb2b5dc3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:43:49.9340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtCs49Woa71v0XekR6glz5+6qfuhIay029HBwN63tRH+AUhbrI1GEBjoaOMqM0bG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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



On 8/13/24 00:07, Sean Anderson wrote:
> 
> Boot devices (QSPI, MMC, NAND, and Ethernet) use secure access for DMA
> by default. As this causes problems when using the SMMU [1], configure
> them for normal access instead.
> 
> [1] https://support.xilinx.com/s/article/72164
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   arch/arm/mach-zynqmp/include/mach/hardware.h | 2 ++
>   board/xilinx/zynqmp/zynqmp.c                 | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
> index 8cb6494e52c..f1514d6a869 100644
> --- a/arch/arm/mach-zynqmp/include/mach/hardware.h
> +++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
> @@ -63,6 +63,8 @@ struct crlapb_regs {
> 
>   #define crlapb_base ((struct crlapb_regs *)ZYNQMP_CRL_APB_BASEADDR)
> 
> +#define ZYNQMP_IOU_SECURE_SLCR 0xFF240000
> +
>   #define ZYNQMP_IOU_SCNTR_SECURE        0xFF260000
>   #define ZYNQMP_IOU_SCNTR_COUNTER_CONTROL_REGISTER_EN   0x1
>   #define ZYNQMP_IOU_SCNTR_COUNTER_CONTROL_REGISTER_HDBG 0x2
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index b4c15b041cc..94a66684af2 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -72,6 +72,10 @@ int __maybe_unused psu_uboot_init(void)
>          writel(ZYNQMP_PS_SYSMON_ANALOG_BUS_VAL,
>                 ZYNQMP_AMS_PS_SYSMON_ANALOG_BUS);
> 
> +       /* Disable secure access for boot devices */
> +       writel(0x04920492, ZYNQMP_IOU_SECURE_SLCR);
> +       writel(0x04920492, ZYNQMP_IOU_SECURE_SLCR + 4);

Based on
https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/IOU_AXI_RPRTCN-IOU_SECURE_SLCR-Register

there is no definition for bits 27:25 that's why that upper 4 shouldn't be there.

Thanks,
Michal
