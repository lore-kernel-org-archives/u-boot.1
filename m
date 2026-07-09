Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A3BC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 05:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA87A84A51;
	Thu,  9 Jul 2026 07:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CGiy2CLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09AA684A63; Thu,  9 Jul 2026 07:53:20 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C12849BA
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 07:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIrtnySyPutAoM99zJyreFg5CskoawPbtm8DTmWtEzfYfjBFnfOoKujJiw0XdGwS8JZPW+9IgfrsKygCzAcfBDx0e7wi1YfcUY/F+Mz1Llab48lKCJ7EcnaeartTRy/nt8mJBbbwHhZDbS0D1KplZ3P8o4eqwKeLpVO3AjejUHqFsUGeDMbE3etEjTFazA/06cTjWQshPrRWAKKXHprPSQjAerhARCnXZZGjDZSPoX8T/3S1cHExeX7gL+r67oQrtbWTgzSY/16nJ1CqxKmDgmGNJAtf3PpR9eYP9WfTb+GwxemZbSQ0Q5wWC+jLRFbi7NLnEt3a1cQ2xNs3bgFXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xIQ3FWDdNeUdZkx6U4UHoZRybf08xCtjfbHRhXD37o=;
 b=arPGcay8vwQ/X0e4YqpgBVouc0yo4Di/9k+SRGMlaK7Us9nFDkg07tY4L+Eg6e83+vg5X+sjoQWQnQHaRGM9ciZ8zTdMYH8+d/L5FpmnX372OZ83W4dUU5Wl/7DJNYRfOCp/wJfVsFvCl+Ncu+iSimaQWpGvBsMOeeymeW5I76gCZWAJignGrL4CV3SJxNj951E0vlQkmA4a0bNsLRA6slaCu1bpCUvAqHArS2vFC4M/cwJk/QHbG+qTp2SO07NFSX97YiUEmmuFLPR4dX8MsVMKITgM3sCT+9Ie5dmtQexeujrpuID2h+bX8CIa5dK7gixgrXnRTh/xn1xfiaSebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xIQ3FWDdNeUdZkx6U4UHoZRybf08xCtjfbHRhXD37o=;
 b=CGiy2CLEtTcr0YmD9/B3AminmQP4/+Q/GVThpEu0o2wJ5TySlps2DUB4tkZ1L0tAQIBSV4iBZzzRHjWLJpHiehCQjX2l15ykp70o0uO7jXlLnIJf7Di22cFxCA+w32zmduFFXkIDYFdoZO8F1px2Jngx1aLVJhZ7klVB95PeHTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:53:13 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 05:53:13 +0000
Message-ID: <af5b229e-0466-45cf-9562-434dc0fa383f@amd.com>
Date: Thu, 9 Jul 2026 07:53:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mtd: rawnand: zynq: Fixes and software ECC support
To: Bastien Curutchet <bastien.curutchet@bootlin.com>, u-boot@lists.denx.de,
 Love Kumar <love.kumar@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b03087-2422-4a86-7713-08dedd7e5d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Kc2QXUanlLhWs1869C+guxV2GZxY/c850yGarpRUpKL53Rl561BahxeMfxNXXASAn9vveFmcRDuJtboB2w5nyLTuYF7nnkwOtIl+5dzuxsvMJCubgFR/XAvFTuUpjrBDEeubBDtSW7qKF5P6AD1EVT/cZ9KBYHYLhEVPUEXsjAxwHywCsMKn9WSqmkHFInCXEgwzOxT/c5wHI9vXNr7O4xxsgHy8g+wmHXp20DzXBeOmyyCY86H32F3e1ELAgHSUso3A2TqPgVnHpwAZXwpVqqbqSGfoFMV9mzq5kHmP7G/RdAf5tYYWSsFcIlL+9hx+zmKXplMjpRv3sl0LmbZ/xWtxVnjgs9uC34OTvWIugSNsiyV9VbJllb0UCXau9KSt2whsRvGUSIISnNDhVIQ45ncVwiiyf5y4t3kX3h+JnIBpwApr5TqNug9YLZ8BCRUQrS35hz/z6eXa+Z/qU3cYQCktQgyADrOFEegPJhQ749iM4knZcKALdRefnmFUrMdBMyVWmsV5Oj+814ykEI+OkAowIlNBderTucnhE6F3SNNsjxQjNAXfOHbbNLzozB8V7YVCD5NS6xMqLDACSshKNDvoaiaFVKmxvRcOTXv+ap/cSSf2Hl7bCM4tcwegNA+SBn4FB3eXKqL/zoCFUmfJ5nR7Nr+TXnXUiKZfgo3/Rkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjlSdjcxZVdYUysvb2l1T0lDN3lhcjlPRXV0N0dUWWk5eFRnVGNDdkVWUlZU?=
 =?utf-8?B?Z1VxcEVwYzc2SGZ1T3JpSGVLMVNtVi9zK0dJd2dxelgzdjZqQ0lpSk82OWEv?=
 =?utf-8?B?Q0lFTS9xZ2FaZm93MVBWVFdLZklIYWJjRWJFOEYvN0oySnNJQmZLUnNZOEV5?=
 =?utf-8?B?RlptdWZBbnMrYjIyWE4zbEQ2bUpFMGJweHdzQzl5dnBva0E3YkFsSm56MzNW?=
 =?utf-8?B?Rld5MTNqbTdjSXFKZTBRZUpubHZxRnNyUEpmc1g1RG4wRUNnMjBvUXk3SWd4?=
 =?utf-8?B?Z1JBNWVabGhuNmdjQWVGVzdtNFRXSTNiMjQwSHl1MTh2eFNTYm51M2hGWFp0?=
 =?utf-8?B?bGthQ2pzY1R0aXYvWE9Eb1ZPOGY1RC82d1kyR3lmY1hRQkludnBsektLQjB6?=
 =?utf-8?B?c1c0L3hRYXFlM2Rudi9PN013Zis2SE81eUc1NmpQUXIxOG5TZWNkU0RSRmpu?=
 =?utf-8?B?SVFoS2NaZnh6QjVjdUJLc2ZGZ0hqdEJsK3pYN3JWcGdOMmw4RE1uNzlXblNZ?=
 =?utf-8?B?RG9kTHNCK2ZZY2xzZkI0R2tKTUdIdk9lSE04QkU3dFQyQ3hId09pcEluVTdv?=
 =?utf-8?B?UkV6NGtVbm5jMHhmbXdvYkRWZmNmL09sRlRZYUFuZGNpYU1leDhpN2U4OXJj?=
 =?utf-8?B?QnZ6N2xPTTJKOHFqVEU4WWc2bXJJNlRMNnhhclh5a25NMU85MDRiWTU1NWNa?=
 =?utf-8?B?UnhQV0dLc1NCajNQemhVRzk4b1ZZcTNvVDhuQit4emlKVEd1N0pvNkNyWitv?=
 =?utf-8?B?ZGk4Ums3UHFsVHBBbFVWM0pqcFJxRVpKRDV2cTJBL0pOSGxnbGJHT2Yva2J5?=
 =?utf-8?B?Y2YxWWZ6NnNhem1HeGx4cFBsVzNGa1lwN2Q3NmxheXg4UjZxVUVBWGtKdUNC?=
 =?utf-8?B?SnRiUDJsY0xEbEp3MG1jTGNNWEpURTdTQVNsbmJLN1liSzA5NFV0T21OSlFo?=
 =?utf-8?B?Ny9ZdmNVQ1ZSdUp4QlQrLzJIb1BzbTJlUGRJckp1ZXVXNkNFdVNDci93VUVx?=
 =?utf-8?B?bEtxV2FVbG40dTZ6OVh3YU5TTjM5bWVlcFpYdDdRYzVpeVpVeEpRTFJVcW1w?=
 =?utf-8?B?MUt4SGpZS21jNzlSYzVscExLS1A1dzhHYUs4WnR2OVVFTmlHdFV4TS9mcEIr?=
 =?utf-8?B?WjNsTE1Vb0JNb3c0djFiT1hEWTJ4OXZSOW8zMkg4UHUvcEdEeVFUK3cxMmxl?=
 =?utf-8?B?YTMvcnNLTnZPUU1PSVlRRUhSRzk5cDZ5MlJjSFhVa2ZLWWRTSVRTcDAyL2Mw?=
 =?utf-8?B?RDYvbUVPNWI5RVEzaWtmeWVQcmtHSnh5Z2s1SHplQjFyNkRzcko2K01pemVQ?=
 =?utf-8?B?eVhCV2ljUEh4b0FxdXFqV0pLTGVOOUtsYWxlZjlYYzc1WXJxM2ZqUXd6cG5W?=
 =?utf-8?B?WjdDY205K1l2b04ySjFSMld1clNUVmdGMkM5VWJWbEtCQUtpcnc5eEg5cUR4?=
 =?utf-8?B?V2pRNG5xKzJqN3grQkF2NHBCMk8yRzdkbW5tcHN5N1p4UTRQWXZNMER6cDFN?=
 =?utf-8?B?TS9rbHNVdHlPTUpaYnRQTXRJZGh3ZnEwVDlLZHRHeVdhS1oxeUZQYWdZdXhY?=
 =?utf-8?B?MFJSS2pNU2YvaDFhazZiaVZQV3VHb0N1Vm5PcXE5WHB4akdIR0NWV2dRMnMv?=
 =?utf-8?B?S29tK2NwZFF4a2diaEd0Q0V5S1AzK3BrcnRyUDBFL2Vxbjh6dHdUYW83Smw5?=
 =?utf-8?B?SmYvRDQya25ucG5TUmtmaEJ6UDNpa0VwdTZqakJnLzJkVGdpNlF0MmRUUTdS?=
 =?utf-8?B?NFpWNEhJK3FDTmZZWWFtUEVTMnF4MkV5STgzdHV6TjNpcmZkQllEeVNBaEY4?=
 =?utf-8?B?T0F4NU9oa0hzaWQ2TnFJOTdvZzRPRHBvYU9meDdwNVgwejhHMlhXN0o0aWZQ?=
 =?utf-8?B?SFY1bVgwV0o3Z0wwWG9zY1M3S216QnIyWnJvZ1V3eDF1NWtKa01ldHJIT0xO?=
 =?utf-8?B?M2phTHJ0NzBGamlkNlNrTGtXQUoxeGF6QW1aKzF1VW5FVmQvSkdJVVNCNnNy?=
 =?utf-8?B?UEpmeVBMWUFRWHJ4bzVkbWNLdmp1Z1hPVWRzekpRb2N1TWNGZFQ5ckJUakYw?=
 =?utf-8?B?ako0YXZpNEFTbTFvQW85MG8xZDNmRVMrN0NmT2FQRzJtSFRrSjhtaGJnMGtB?=
 =?utf-8?B?NlRpSDZ2NUtFVmUxbzEyK2Fxei9DUkFIdnVvSnJtQWNCQXpsQ29MbWs4QURa?=
 =?utf-8?B?emdFN0JCMzdISThIa0JBK1MxRk5nSUJTcTVISUp0YzBVK2V3bjlMWDVoWnFY?=
 =?utf-8?B?L1BHZythTDdGSnNxT29jdDVURm1OMFlKckMyaTlnbStOSVpZL2t0R1I5TXFp?=
 =?utf-8?B?RWtKbUZwN2FKeXdmN29BZmJ0U2R3WHhNcHYrRGtPRlFkVytkTWJBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b03087-2422-4a86-7713-08dedd7e5d27
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:53:13.3092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaG1Z4Qeo3uIFnVOmnt3QM3qx3D/TTaOcAEtFppLhgVj0wF0tA08rP5HySuPUOyc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707
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

Hi Love,

On 7/2/26 15:08, Bastien Curutchet wrote:
> This driver is deeply broken in many ways. Miquèl has cleaned it up by:
> - flagging the most hideous parts (where Micron on-die ECC support is
>    hardcoded)
> - enabling DT support, eg. for reading the ECC configuration
> - fixing software ECC support
> - aligning the software ECC OOB layout to the rest of the world and
>    allow a working interoperability in Linux.
> 
> I then added a patch to fix writes when soft ECC is on.
> 
> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
> Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
> ---
> Changes in v3:
> - Add patch 6 to fix write issues in soft ECC.
> - Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com
> 
> Changes in v2:
> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
> 
> ---
> Bastien Curutchet (DAVE.eu) (1):
>        mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC
> 
> Miquel Raynal (DAVE.eu) (5):
>        mtd: rawnand: zynq: Align the layout structures with the driver namespace
>        mtd: rawnand: zynq: Add comments about very bad practices
>        mtd: rawnand: zynq: Make sure an of node is attached
>        mtd: rawnand: zynq: Do not fail the probe for no reason
>        mtd: rawnand: zynq: Fix Software ECC engine support
> 
>   drivers/mtd/nand/raw/nand_base.c |   6 +-
>   drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>   2 files changed, 32 insertions(+), 89 deletions(-)
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
> 
> Best regards,

Please test this series.

Thanks,
Michal
