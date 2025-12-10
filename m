Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF94CD2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC9383CAA;
	Wed, 10 Dec 2025 08:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2mgIdLWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8C083CAA; Wed, 10 Dec 2025 08:42:45 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A475F83655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaDc0AYWzGiXdt1jDl1NTyiB4JiYHDH2Xj+9lk0/n5OjVEzWs+cTC6B7WGN9Ty+qnI4DAn9v4dWtszkNXMd5pHNr4L0ftdwjZZUYqX0K9di2Pja8gS63z2ix5zNRjHTLEekGYR4GgRzvvJXb7LIbFnqblabuKfa2E2erOUx1LJVjjiijzAQNrDI1IxZ/RgInVvAyzuuburv0Mki0heFio7MXIlhWViPCq/G/qFtDW5INNmszJ4ToClaqvg9Jzikap2nBFvjy0Lm2CfOcTiPGISaRa6t1sAkvCX1t0mZYxo8i+Zwv81nV4eZz1Njavs+EzADgQmqM7B/mZBf5rgN2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOojrwLBHdWbmpyjgTiAzMKPV2FJet9TxgaWy7OCuxs=;
 b=pf2h3vfVWVTTph9uCnzaEB8tdXu3MotdYnPlUVyP/oDeeZmal7/QGq3WP7b3qm2dP+OKmTCzwtS2hMYE7yh2/VUHdFpFNS4LznsFnPciR5dJ2kKRIfF3Wu3EvuxifoelLFick9dPmteNJGs5lf1SOqi3sD1Up7CdgK1e4eyFSOiM50CuVIk7x8lhQ8Xbt5wVIFbgJxPGt/5J1udOop14tyc0dp3ZtieqNa/C1Z2vv9oaZI1/aGmt8mXWTyG1kItq1ng1X2RO6o04rIy1fOGx4LEZooip2U6erPBl9n7JvDeft4a9zKJMTSrkX/DB8v3ANfqjlhxg38O1/4F/oGUNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOojrwLBHdWbmpyjgTiAzMKPV2FJet9TxgaWy7OCuxs=;
 b=2mgIdLWXNbq3I/kvCijqoqCDwP5s7ASNHsROQiUZkG+v2uLzi1MJB7k+kunVAZ3ecFr3KPyeKpZHVpN3MnGV+9XI9ezfpWKMUVx49uXfxan2giNjSm5Eqn2OUJ4T+SJTG+ss6Wq6BoogW5MIhqBvdG9XT+fJuwqYJoPk+IA0biI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:42:38 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:42:38 +0000
Message-ID: <530b25bf-b915-4120-9151-536bde022005@amd.com>
Date: Wed, 10 Dec 2025 08:42:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: mbv32: Disable floating point
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <2c043ed05643fee200a79eb08bfd5c0041663bd2.1764746430.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <2c043ed05643fee200a79eb08bfd5c0041663bd2.1764746430.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a684bed-74a6-45db-38d8-08de37bfb0fa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUtGTng0eStvUEowK1ZQTlJIWU5zVnhRY3R1NTVFaDVWNUZRb0NKanBBTnR3?=
 =?utf-8?B?MXdEQmFLYjQydjU1czBIOWd5VDlPS240SHdZVjZFMXc3WWJFUEdnVEdNK1Rn?=
 =?utf-8?B?ZHBWaDhpZlJDeGludnM1NmNTNHlpL0hDSVdtTm5KTGhLVTFxZjBPbkp5Uk5H?=
 =?utf-8?B?WGhnWVdiM2l4bE1zbHA3Z1pySDN1VTArTHI4d1hlRkloQ1RIZStRL3VGby8w?=
 =?utf-8?B?UUdsOFNQc0pEb1BibWlPODhlTGlURFZ4ajhQWW9WaUNXaDNOMGxvbDExQXox?=
 =?utf-8?B?N1ZSNlhGTVRiS3VaTmRaT1FJcWJIRHpicFJTNGxRZm1yL25BSHpua2lMN3Vz?=
 =?utf-8?B?NHNIZG02QjIyUG9Ybmw1NlBnRE9xb0NWOXRWVDA0bXZRdmlia0FVbXRkZkJR?=
 =?utf-8?B?OHl3VTg1UXFkYXZEQXhSanFBbnRnY3QzM3dtMlQ3L0JGOC90RDJpWmlEOXp0?=
 =?utf-8?B?R2JjWVcrSEZUN0tPYWwwOFVBWlp0dDdETE1kakJMc01Nekk1blBhZHpqUmlj?=
 =?utf-8?B?a2lEMTRTVGVUNFhRbVhmM1B5b0N3U0NTWUl0ZGd2cFFpL243UjFOUUlBQ1Ar?=
 =?utf-8?B?b0gwY2tRNGJKS1NUcm9BTWJjTlArZmU0UUt6cDVQU09HbzVuU28yUWJNV0tH?=
 =?utf-8?B?WmJNcWlVdzIzbWU0SHZ3VDkyNXk1T0hoSjFQTVVLaWJOK2hVL0RLSjYycldU?=
 =?utf-8?B?eUgySFFOVzVRczRmQk9mUXo1QTNyNlk4ZFdYZjRvV3pRUGVnMmJ2akpUdGRz?=
 =?utf-8?B?Vi9xOXExSHl5em43aHVPMFlueFNkTHRCMjFONlZwV3V0Wms0eFdCT0FBYTUv?=
 =?utf-8?B?TnU0QzFiYXhidzc0Y1haWmZRZ2thMEt1czZkS1VLVVhiOWpPOFAvMlhwVXVm?=
 =?utf-8?B?d25maG41VzF0KzRxaTZqN1R4K0pPeU5qZ1hhTXdVTWpEdFJneWF1WDFoeXBG?=
 =?utf-8?B?ZUxkazE5NDhMVStIeGVGbm9MbVlVNWg0NXdCZ1Y3WUhGVEYrdVFmb09YM2s3?=
 =?utf-8?B?VmpTbjh4SUs3c2lPcitYMmlDZVB3aU1ielAvWWlTL0RLcXppOEt3RFlTY1VD?=
 =?utf-8?B?RklGRDd2WkJrOUkrdWFQRmx2RGF1WGt0NmFXNTRUL0xaOGdrb1lhWG5rbFF5?=
 =?utf-8?B?TzNHWEZlU2VxTHJoNlFyMXJRaXNQZlAwSWlRcDJwRmh6TXBMWUhVc295ZldT?=
 =?utf-8?B?aEdqSmM2eGtlUnhwMTRGcWU4S0dyalluZFlobWlxNnFtQjNPUXROVFRnNHdU?=
 =?utf-8?B?cFRUYnlUWCtIVGdmenBnWkozWHdqYyt3TU55VUFSTnhDSXVOU1N1WlBSbVZr?=
 =?utf-8?B?ZmRoZ0tXMG83VHhBWkFaN1IzQVlSMGEyendyMmFBZVBiMVZzMkd6WEZQWWdh?=
 =?utf-8?B?SGFkdWpLZ2hvUVozNW91MTBUVCtBd0R0MHNmeW5sVE5lVXRqK0w5NlJkS2p0?=
 =?utf-8?B?VkdITjVQcUFOUjRkRVVpNU9Tc2FjOFVaQm5NYm8vMTNQY0pjZVg5ZW9CRWpk?=
 =?utf-8?B?aVBBVHFYZHhsWlBlOHFiVXZzcnBTQWJuS0RaYmlJU0R2NUVRZ0phdzZTbDdw?=
 =?utf-8?B?R3c3OTQzSkYwZTZ5OVhSM2l1djkvY2R4UVhYUnBZZGRMQ3NoRVE3ODVYYTRu?=
 =?utf-8?B?d1ZLbFVIYWVYck9OZ2lEa1pMd0xaQ2xDQjFEeGpLVE1rcXRBNGdrZHphK080?=
 =?utf-8?B?RW5UWUxEdW0zMEJVMlc5RThWY0Y2c2tMRFd6TjdpSUlkUXZPd2hEd1hkVThX?=
 =?utf-8?B?TjJMZjVnZGliLzFSMHU0YlAzMVk0akk2ak9SdVhRRmJQbGV3STZVVVFLS04x?=
 =?utf-8?B?SEdHUGs3L3JSUlZDME1zNk5jd2ptZGVCSUxBRks3elE1TVhDWTE3bnVBWlFS?=
 =?utf-8?B?QU16bGpDOHNKN2hmWlQyb2k3SWtwSGJZYU10WFNjOXhCMFJERkZpV1lBREYr?=
 =?utf-8?Q?I+I8TWMcXiPANvUWWtGDw8F30KWHpiS6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME5nN3I2Uk55RENRU0QzQm5QSjExZHFla0tnWFBvU2s4NitieHNjOGNxTGZu?=
 =?utf-8?B?aXlrcWM2OXl1UkQ4MGxVSGE4VjZrNnZUYXNkOWkwWUZJT1o2UE81Z3VERmVV?=
 =?utf-8?B?Vmd1R3NOaUg2akpmNDNJYmRERitmY3RhZkVndy8vV1c1SGY4Vk1DMWxiQktT?=
 =?utf-8?B?My94VUFsOHR3YmJ4MFc5WkFlbS9tSFlza1FUd1FtK3paa0xST2gyVE9BdzJJ?=
 =?utf-8?B?WW4xejA4c2JJUDl0VlExN1NQYVBvTmJHdlcyNUc1UXRNanh1MlFiaHRMYkpo?=
 =?utf-8?B?Vysza2FCTCtEaE56M1VDSDVkakZ4dzNscUt5akJXaUJWOG04TG5KSU53RWpD?=
 =?utf-8?B?bzl0R0RJWEhpeGRFUm1SUWd5bzRLZXV6UGhQRUVueE84dXVsM09NbDJwQVUw?=
 =?utf-8?B?YWNJOTYxUHJZUmk1bTVkQmtPRnMzTVVQNEVZeEpkSnVOaWZ6RFI1blBCZlNk?=
 =?utf-8?B?QUtERmNwakh3Zm5zVmc3a2dnNFdZb2JWSEZodksyaG4rZ2NvVDN1aUVqSEVP?=
 =?utf-8?B?Tlc5dEozWVRCTmNNMkhXZVN2MnI5bUs2NkM3OUNzQ3dMUFpnYVN5djNvNnBs?=
 =?utf-8?B?SFAvWSt4UnBhZ05SRklUWHE4R25PVEk3V2M2RGZ6SE10VXcvQThuOTNhbFZs?=
 =?utf-8?B?cmFkalhXU21ITVFNME9tTWNLR3BMS0N3Y09MbTVINzdOazBGM3VXOWNHbDRo?=
 =?utf-8?B?K01HblR4MTBNaFliaERCbVYzU3dHWVpNbVZoeGRhQXJuYVk5bnIzQ3dzeUFF?=
 =?utf-8?B?cnVBeWVhdktRbTByM28yeG9XU2dXN2JjdGk5VTlybzFEdzBLY0NnZzV1b3dH?=
 =?utf-8?B?LzkybVpZV25DSTFIbkVUZEZhNlRVUlo1SFRIR1hOelZBRzJRdDkxWjR3TVBr?=
 =?utf-8?B?eURLZyt0Q3B0cHZPekhvTWwvME5pOEtFQkVsNHlMUzNjOXZaRmp1Q1c4SWNZ?=
 =?utf-8?B?RFhjZ1U0SHBRNEc2eEF0WkpDOHg5Tk5hcnpqa3kzZHJKM09QcW55bDB2MnRB?=
 =?utf-8?B?d0NwTE0vaUhTOVZET0JaVGIwU0JMc1N2ZjJEYUU4M0U3WkdXZSsycWhEK2tM?=
 =?utf-8?B?RkpvaTVUdHVLMkx2OUlzNzRDT0pDZGNOM244SUFVMVhkSWllYklpQis4ZE56?=
 =?utf-8?B?ZmdQbHplNk81QUllL0NnVURNMzM2dGxmWTA0bHRMMmFLWlp5RmJPcEtrY1px?=
 =?utf-8?B?QTRGMi9mN3VaYURjOXhHUTJ0d1lGeE80SHdQTVRZTTFqWWJ4OWJ6WHdsL2tv?=
 =?utf-8?B?R01qRm1vNGhjbEZiVXRkZDN6Q2VBWW84UExQYUprWmlIWm8rTVZjeURuSUNR?=
 =?utf-8?B?c0JvWnF6S3g5NzY0Y21GZkpteGFaaFFRdnY3NVhaVmtWU0k1dGQwYzFxVis1?=
 =?utf-8?B?MnJGWUhSc0t3VXhieXZVaHI0ZmZFWnZ6M2dtcHVtaHBzNlljclBkVmVZRnVu?=
 =?utf-8?B?NDNNTEt0dDN1Z3BGVEs2Mm5IMnp2UkxtR0lvSGozMDc3YmxSWTB5NzhDYVFv?=
 =?utf-8?B?TmM5NVJhVGVuT1JXQlRGR3hObW1Cd1ZLWUdDYXNVYWtSdVFYTXNwZU1OMUtq?=
 =?utf-8?B?Q3A1eFRNc3pXOWdoZVJVeWJ6V2VzeWg4TU9XRFFIU0R2S3B6RHd0citQL29T?=
 =?utf-8?B?ejdTL3N0N0M2K2J1Umx4MFhleDN2RWhhWlBoZjVJd0gwdzVNeHd5Y3FXbzhT?=
 =?utf-8?B?c2xxanVOcFgzanFQSVI4NnRITXp0a3VXMVFkRHZPeW0rZXcwT3RWUWFaTWdB?=
 =?utf-8?B?V1NieU9LK3FVT0dUVnludUh0TU9tc0tFZE9BOG9GWDFPK1dsTC9MNjRrRFZ5?=
 =?utf-8?B?bCtpVlRmdkE4YUJSOU5yY0g3bUsyaW9oWVhkZENxKzFLcWhaOTdCcmxSWTVM?=
 =?utf-8?B?anN3cVZ2cTluRnBkUEQxS1llczk5djE2VmxLOFd4UDlkNFd1dGpmb2R5a1VS?=
 =?utf-8?B?T3N4QTZFL0JScWp6SFF3SUNaWndyWGdsSVY3ejRtaU5IWXg5TXViR1gyS2dt?=
 =?utf-8?B?eU1QbVQxcC9QWTdTbERYZVd2d1BpNVRQTlV5Zm9EMCtDNmdML2xwWDlwZnNo?=
 =?utf-8?B?M0VGRVFXMEpZTXRQbG1xWlh3NEw0SVgxdUhpZUZiR3MrNWlXbDVuRFlYc0Js?=
 =?utf-8?Q?4qIbezHirEwOgHDPu6TFbMimL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a684bed-74a6-45db-38d8-08de37bfb0fa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:42:38.1598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL5/3I4IOHt2XU9CFqukCCfhctQNctTW4vvSCoCzbvrE931amOVEnX930dpNiJns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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



On 12/3/25 08:20, Michal Simek wrote:
> MB-V 32 has optional single precision FPU (64bit has single and double
> precision FPU) but there is no use and reason to enable FPU by default
> that's why disable it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_mbv32_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index 88d9e5ce6b2b..81c0f8e9e936 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -18,6 +18,7 @@ CONFIG_SYS_CLK_FREQ=100000000
>   CONFIG_BOOT_SCRIPT_OFFSET=0x0
>   CONFIG_DEBUG_UART=y
>   CONFIG_TARGET_XILINX_MBV=y
> +# CONFIG_RISCV_ISA_F is not set
>   # CONFIG_SPL_SMP is not set
>   CONFIG_REMAKE_ELF=y
>   CONFIG_FIT=y

Applied.
M
