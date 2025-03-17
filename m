Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0B6C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 10:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF56380107;
	Mon, 17 Mar 2025 11:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wsk7SplQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8255E8058A; Mon, 17 Mar 2025 11:04:31 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC8F800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 11:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaLp2yAklDWgPLWBQmf0QWH7HAvAPBC0vTNWoGvwhcpC9QcrlewVp+ON5GvlxPUq56Z4hNZD/VRb7J1lesczIxJ2dyOBCirdj7zTLWG4eYl3G7wpH5MeF0zsdMIhgHCzSe8GEV172dUgWpiyLBm2WIeP2h+X6haOZO590hrNcmICYDvThpIFZbCqDvVHpguAOq5bMheBtx0F2MzyDevveLW0RRig4H8lBYUZzpLuq21i+HtILzmxWOE9w/DZowytGtOWynQa7i9GvnMXh7cVmtu3Sih7T5LsGdIfOR2sJOfFMphg/QKrFfndkJ4/WXYjf6kGkTSIL1mELfn95JveKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URERxYPcdCxKUlIzOmdqsVaWCXL7gIR9sPUFuLA3Jvo=;
 b=Rg/SQm8InSbHnIS7wJqcr4Qt4lxzac1Fci/Mg3F30eJz3Ej3JP3U736vw1nhTbJbcKLvFY+eBq5VmEuhhnSxlXvnu31anJBobT46sHu5CDp8RbZOVdvFhhOkYjI39i1r0Npf6sGQeR+dwymgHmHd9v/gGg3HUvpP6OuWT6DBvT1/l9BytwXz9Arcvx6gomsQ/0nldHDEmGoX7hS+1UFvR98LtIMPTgRKW9oYBSBZzrDzzPeQQDgpkmQBMItlULgd9FI8Jmp4+13MlaA9RyTcjGvTfQC2z1N38QQL+p1rb1vlc3h0lTeD3xni4drMhF1rkxS2hUBBTgJ5JiF3apDRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URERxYPcdCxKUlIzOmdqsVaWCXL7gIR9sPUFuLA3Jvo=;
 b=Wsk7SplQReyi9YiE6CY2eZQjRvBPIWsg4FKdTO4RYnSvT2uX6mA+mSvqNUAppILYB2e2x9ajjMIhAlia39MgeQwaFLsCwofhlF9Xv470ZaVb98oEIKIWf75N5LHvuqrDesdKoe1EtcEZobxWQ8UnZAEG9I5P5Oryel64519Nd78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:04:25 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:04:25 +0000
Message-ID: <5829a440-c1e6-4c4d-994c-a96adcc7bc57@amd.com>
Date: Mon, 17 Mar 2025 11:04:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drivers: fpga: Add partial reconfiguration console
 commands
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250314114758.29078-1-nareshkumar.ravulapalli@altera.com>
 <20250314114758.29078-2-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250314114758.29078-2-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::23) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b96817-22eb-49f7-55fe-08dd653b18bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3BXbStHVFJQQnpta0pjbWxWV1dBRVF1SytIZm02amsrSnEzRXhUM1hpemlp?=
 =?utf-8?B?YW00ZE9EMXFCbVZGa041ZDhJdzJLekF2OUFaYThvQW41WEdrTkxpT0JKNCtj?=
 =?utf-8?B?S2Q1Wmgyd0Q5RC9FYTZ6djFBV3pwMjhtTFpjemFuTVh0dGZ1T2VWcjU4NGYr?=
 =?utf-8?B?VHZtSm1YYVBna051cFYwakRBVjVXWlQxKzZtdFZja2E0OHBRRjhHMWp0alFr?=
 =?utf-8?B?YUlVM2swbVlxSDdyaG1RZFF0QjlYWm5nOFkwQXdVR1lLZ00yc3pXM1lKdThm?=
 =?utf-8?B?ckhESm1VaVBaSTk5QktVUmVjblZ6OSt0Mm92YXpQTC9mMGdIeHN5ZkFYdXp6?=
 =?utf-8?B?SXdtMjVYWnRyRzdEVVFEaEd3OHhDSDc0SFRWWElnVmdqdlhwemsvSUdSdUFL?=
 =?utf-8?B?akRldmxBdWdnRGhjVWpwb0JvSnNobmVMOVNDSmhGN0FyUzJEbWJsN3ExUzBC?=
 =?utf-8?B?amVQYTZhS1NDSUdPUFFlVXVGNkVFbjNUaERSMi84TnYyTE9UaEVXMUhnOFFF?=
 =?utf-8?B?VFRwZnlPU2VYc1BXN09sOXBRN2tEOWk5VnBpUWNJNHk5WXQzT3cvZGcxbCt0?=
 =?utf-8?B?RCtvSUs5eHl2L0RqRTJXWVpxT2htWmhLTU10d21sYlhNWHZyVU05OGdZNTV6?=
 =?utf-8?B?N2MzR2ovV0c4RStFa2VSZkowM0lldzI0SGk5RXZ4RHJMeUZBRHRFMzRMaHJU?=
 =?utf-8?B?UUI0WXVHSWIvNEc0ZFNPTDBUTFl6bm9KMHo1OTFFRWN5bVZHb1dHTUtFREFN?=
 =?utf-8?B?VGgybkFwMk9mQ1U4dGZKNkhOTzg0eEs0U1grd00ydHhQbytyNE9NeVkyWHZ0?=
 =?utf-8?B?aVZjZEUyV0JEQm84TU1lK28vMGxpcWd4L0NkT2xTRG9VcVRYb3N1dGJoaEN6?=
 =?utf-8?B?dmJQVitkV0dkVkdwRXNMUHIrMEtYamNHdnlUc0p1dGJnNW9MSnNkR2IrT1I2?=
 =?utf-8?B?N3FtUnlyeGM2cWhLaU9NTGpLZnQyQ1ZwVG5YVTdCc1V0eVBhdTdoSjFyVStz?=
 =?utf-8?B?NjB2MlZYMDVzZkRSbTUxZnZwVmt2MU1aT3o2K2hyV09LM1FnMkhtUW5uTEhG?=
 =?utf-8?B?b241cTRudjBoRzZuQUtUSW4yWXhRUTZidWZZZ0FKLzJtVjAyaVdkUVVJT1hk?=
 =?utf-8?B?dEpveG1YbExULzNNV1p6MEdqd3MxQkI0VVhQR2FwUkFqOFFJT1RBdDZYVmdk?=
 =?utf-8?B?dm5ZZUI1NU5CMnZPMWRZV043VlZ2MXU0R2I0WTY0ZFc2a2VXV0sxRmRWNTdU?=
 =?utf-8?B?dUIzaWZUVE1neklPdDRWZWVDdTRiN0lKeTdEVG02SWlhQzZXZzcrT3JUK0Uw?=
 =?utf-8?B?TGJXcU9iUG1tQTU2SEN0dzA4NlZUckRIejBHR0R0RWkvRW9OdlByN3VpWTI1?=
 =?utf-8?B?T2o3VFBCUUJTd1ltUGNsUnJuM3hZZENLK1NSRmJuekp4UW5WdkpUczR0aHF5?=
 =?utf-8?B?TWVxRGQ0VU5iVmFQWUROV2FPdWprTlZJVGRBbSt3U3k2MGtEekJseXhBV21k?=
 =?utf-8?B?OFRKSkpVY0gvbDY5anNNemlJNVJuMmdGK2c2VVE0RVo2UHZPZGFUNW15dGVX?=
 =?utf-8?B?RVpEc0hZUHlFZXVNbGpOZ1BvUFdJYVVyWFpxczJOWFM1TkVTREJiQ2J3NTlj?=
 =?utf-8?B?ZXdYeHVQNXhBa0hRNXk2QW1rL1pTVlZOQnZCYUJMbHFJWUFnMlc3SVU2Y3U2?=
 =?utf-8?B?a1ZMc2FDWEVIMHduYmVqZVRrKzgrSXprZzNlU0plTnJjZks2eHNhbjZMak5R?=
 =?utf-8?B?elNPZFlJdmovTFZveDgzdmNpa1hEOU1mTFQxeTgwTUFPdS9oMDZ3aTE2TE5J?=
 =?utf-8?B?Q0pVMkRsVm9pL05JNVNSUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlA4dHBQRXVjem1xa2lTTnNQUmYwWnpOdU14MlRYNFJOREhPYm1ia0RwNHV3?=
 =?utf-8?B?cTdKZHJKV0ovSVlxMzdmYUFEQllJaStqVTBxblBFalBIMU9ZNlVkY25XUm1T?=
 =?utf-8?B?TUR3eDZpU1plWjdiUUxLcDJQNE5sd2RlMDVBbm8rMnVlZi8vQkZhRldrMUp4?=
 =?utf-8?B?UGxKM2YxclE2UVh4MXNXMjU5SmU3WmY5N1NpNnpvSUNjUFZYWERXVVBteWwz?=
 =?utf-8?B?eEl1cFNJSDF4eWdRcjBYV2FKcGI3UVYxZ2RQWUtxSE9YWkRFVnlEN3VnRGxo?=
 =?utf-8?B?cE83dUFmeCtOa3ozSG50djFneDdPZnlNSEU5N3ZtN043TTFPSnRNMVdkZVly?=
 =?utf-8?B?bGt0dnQvRnFiSnFPQ0JwcWRGRnFWekRsR045SEFENmF0ckZoMkJiTEhrUjc2?=
 =?utf-8?B?MWFlRFg3a2lFUGZQeW1mNmxoMGFEcm42akRMRXpZZiszQlNVNjc0THVRYlpU?=
 =?utf-8?B?RXBaUSthM2tYNU5FNEtZN1NuZytrRWczZkxRWERRdGtlaUZVenlEYWx2ZHF2?=
 =?utf-8?B?UDdOemU5SVBTNnY1Q0J6NGhZcmttdlZhQ3BkcHVGaUh5N2RIOGJQd0dpV0xW?=
 =?utf-8?B?RTQxYjhtR1hZMmI3QlBwV0F1NVpKVWZybGFKSSttaHVKQk5rLzMwOWt1Yk9k?=
 =?utf-8?B?TjJMdHVJLzMyV3gzWkN2UVNPMXlLMDFkTnVnVmc1VHptaEZIUldlWHNVbWxL?=
 =?utf-8?B?L095MlYyaXN0UnVWdEpvSFJxOGg3bmR3SFlaOE9LcmZSYm1TVll4Q1h5Y3B2?=
 =?utf-8?B?WEpYVHFFd3dyOStXdTJVTFVkRXNVY01pZzZXQXJ3UTF1bUhhaEt6NlRWSW1M?=
 =?utf-8?B?NnBXclk2YnBoTHBmQkdxMU1ZUE15V1ZQT3pQS2tCay8xbG9sakl5MXVmQzBt?=
 =?utf-8?B?Tmk5QzBUYjBYU2ZwU2FoMno2T3l2K3BzY3VDWG9QNTFHTUFNc0FQai9GTDBD?=
 =?utf-8?B?VDgweEZoT0NuSjdVNnBZbU5IVHZra3c1aWFsZHFiclNBOFlCdnBTQVV4SVN1?=
 =?utf-8?B?anpLR3diQXFCbjd3WHlUdUtldkZIbm5NRzF4T1N2OVg4MEltcE9rR1N0MCtE?=
 =?utf-8?B?YmwyRUczZEZVUDFxNW11M2VkREJhUnU3QWNvcTBKckQrTkl1dE1OV2krTnht?=
 =?utf-8?B?OHpHM2NubnBMNVNKS25sN0hpTTBSbkdHVTNIK0RxMm1SRjNYMWMzZHozRW9y?=
 =?utf-8?B?bDZwU0tjZDdGZlA2V3JIbFltOVBEZisyTnRCR3hiSmMyY2QzZ2h5eUx4Z3Rr?=
 =?utf-8?B?TFlVWC9qNFJOZXhVbXByaXQwOGpLWndxYlk4bmtIRm50TUdLVFBFMnJYNlFo?=
 =?utf-8?B?OUNUeDVWZnB6UjZqWEZvNG1lTlZLVG5RbWhFQTlhL2ZIWVNNaXlpQUx4UGZB?=
 =?utf-8?B?ZFBscGtEbStDNjhVdkVnUlR3aTZUMjU5OWhrRDN6OXJRbkZrYllUVDFud2di?=
 =?utf-8?B?SXROaUtOS0FCdG92VEdSdWREOTlYeENyejl2RmFObGtDWnpqc2s0OU9Zd0tB?=
 =?utf-8?B?MkdJYUFRaUE0azBPNEtrelduL1MvbE4zd1lwWlp0MW9iaDBmd3lXajdBTGRX?=
 =?utf-8?B?MFFmRDFxdnltYzFpNVl2bEgwSk5GUUZaM3dBSldQYkRvQmdldHF3ZGwrS0hS?=
 =?utf-8?B?YmI3OC9aSGNPTy9wc1FkdmI5TzRUUytRalN3L3g5enIwNWh0ajZFNzl0MmNp?=
 =?utf-8?B?dEFmbVAxU1lDa0swRGpUNHljN2dzNEQzbGlKYkFRWjlKWGVTVFFSdllBbFc5?=
 =?utf-8?B?Z1NOR3BDc0dwZmxRaHpNVUNSMnJJRlBxaE54cDhrUFM0RUxOV3pjamJkYUwx?=
 =?utf-8?B?R2dQSWZCa3RJTnEzUnlHOWp4MmRvUXpoSTBFYU9uVzlJejJXOS9TY0QrRWtp?=
 =?utf-8?B?aUQxMFczbjgrakVTczh4aFlKSFZhSVlQS3VoYW5GaHhjOXZqKy9lbTQyVERz?=
 =?utf-8?B?ckxWMFVNSTE4QmpEbVF4S0o5dG4rdmg3YUlmV2dxL0RSaGROR214T2ZIeC92?=
 =?utf-8?B?SVBDMFM2QWFNZmJ1NkhRanF0anJXU3lpSTVha2hGYUwzL1JqOE1VcEgraEky?=
 =?utf-8?B?TEdhLzI5ZTRMeUwzRzZ6R0xoV1RXWHBCVDdiMHlZaGNRenZJUE9wekE1ZmJx?=
 =?utf-8?Q?ucH1hRh7JyejbWGfZnrcjUMZm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b96817-22eb-49f7-55fe-08dd653b18bc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 10:04:25.5306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eK8TR+bDZnPyvh2e4FuB0QQFbsBQyJy8qaK4h9JHMvVR5i9a1NFsMN55FZzn6DSp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511
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



On 3/14/25 12:47, Naresh Kumar Ravulapalli wrote:
> Partial Reconfiguration (pr) command is added to U-Boot console. The
> pr command will use the Freeze Controller which can freeze and
> unfreeze the specified partial reconfiguration region. The pr command
> supports multiple regions for partial reconfiguration by specifying
> the region ID.
> 
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
> ---
>   drivers/fpga/Kconfig    |   9 ++
>   drivers/fpga/Makefile   |   1 +
>   drivers/fpga/intel_pr.c | 191 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 201 insertions(+)
>   create mode 100644 drivers/fpga/intel_pr.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 62cb77b098..bf34d11a9d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -66,6 +66,15 @@ config FPGA_LATTICE
>   	  This is used for the lattice FPGAs. Please check the source code as
>   	  there is no documentation for this at present.
>   
> +config FPGA_INTEL_PR
> +	bool "Enable Intel FPGA Partial Reconfiguration driver"
> +	depends on FPGA_ALTERA
> +	help
> +	  Say Y here to enable the Intel FPGA Partial Reconfiguration driver
> +
> +	  This provides basic functionality for partial reconfiguration which
> +	  include the freeze controller support.
> +
>   config FPGA_XILINX
>   	bool "Enable Xilinx FPGA drivers"
>   	select FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 610c168fc3..70a8f88836 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_FPGA_STRATIX_V) += stratixv.o
>   obj-$(CONFIG_FPGA_SOCFPGA) += socfpga.o
>   obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += socfpga_gen5.o
>   obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += socfpga_arria10.o
> +obj-$(CONFIG_FPGA_INTEL_PR) += intel_pr.o
>   endif
> diff --git a/drivers/fpga/intel_pr.c b/drivers/fpga/intel_pr.c
> new file mode 100644
> index 0000000000..ecca2c9eeb
> --- /dev/null
> +++ b/drivers/fpga/intel_pr.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Intel Corporation

2018? That's quite old file.

> + */
> +
> +#include <command.h>
> +#include <errno.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/libfdt.h>
> +#include <fdtdec.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define FREEZE_CSR_STATUS_OFFSET		0
> +#define FREEZE_CSR_CTRL_OFFSET			4
> +#define FREEZE_CSR_ILLEGAL_REQ_OFFSET		8
> +#define FREEZE_CSR_REG_VERSION			12
> +
> +#define FREEZE_TIMEOUT				20000
> +
> +#define FREEZE_CSR_STATUS_FREEZE_REQ_DONE	BIT(0)
> +#define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE	BIT(1)
> +
> +#define FREEZE_CSR_CTRL_FREEZE_REQ		BIT(0)
> +#define FREEZE_CSR_CTRL_RESET_REQ		BIT(1)
> +#define FREEZE_CSR_CTRL_UNFREEZE_REQ		BIT(2)
> +
> +static int intel_get_freeze_br_addr(fdt_addr_t *addr, unsigned int region)
> +{
> +	int offset;
> +	char freeze_br[12];
> +	struct fdt_resource r;
> +	int ret;
> +
> +	snprintf(freeze_br, sizeof(freeze_br), "freeze_br%d", region);

_ is not allowed char for alias.

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/aliases.yaml#L30

> +
> +	const char *alias = fdt_get_alias(gd->fdt_blob, freeze_br);
> +
> +	if (!alias)	{
> +		printf("alias %s not found in dts\n", freeze_br);
> +		return -ENODEV;
> +	}
> +
> +	offset = fdt_path_offset(gd->fdt_blob, alias);
> +	if (offset < 0) {
> +		printf("%s not found in dts\n", alias);
> +		return -ENODEV;
> +	}
> +
> +	ret = fdt_get_resource(gd->fdt_blob, offset, "reg", 0, &r);
> +	if (ret) {
> +		printf("%s has no 'reg' property!\n", freeze_br);
> +		return ret;
> +	}
> +
> +	*addr = r.start;
> +
> +	return ret;
> +}
> +
> +static int intel_freeze_br_req_ack(fdt_addr_t addr, u32 req_ack)
> +{
> +	u32 status, illegal, ctrl;
> +	int ret = -ETIMEDOUT;
> +	unsigned long start = get_timer(0);
> +
> +	while (1) {
> +		illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +		if (illegal) {
> +			printf("illegal request 0x%08x detected in freeze bridge\n", illegal);
> +
> +			writel(illegal, addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +
> +			illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +			if (illegal)
> +				printf("illegal request 0x%08x detected in freeze bridge are not cleared\n",
> +				       illegal);
> +
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +		status &= req_ack;
> +		if (status) {
> +			ctrl = readl(addr + FREEZE_CSR_CTRL_OFFSET);
> +			printf("%s request %x acknowledged %x %x\n",
> +			       __func__, req_ack, status, ctrl);
> +
> +			ret = 0;
> +			break;
> +		}
> +
> +		if (get_timer(start) > FREEZE_TIMEOUT)
> +			break;
> +
> +		udelay(1);
> +		schedule();
> +	}
> +
> +	return ret;
> +}
> +
> +static int intel_freeze_br_do_freeze(unsigned int region)
> +{
> +	u32 status;
> +	int ret;
> +	fdt_addr_t addr;
> +
> +	ret = intel_get_freeze_br_addr(&addr, region);
> +	if (ret)
> +		return ret;
> +
> +	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +	if (status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE)
> +		return 0;

newline

> +	else if (!(status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE))

no reason for this else.

> +		return -EINVAL;
> +
> +	writel(FREEZE_CSR_CTRL_FREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	ret = intel_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_FREEZE_REQ_DONE);
> +	if (ret)

Don't you want to show the reason for this failure at least in debug?

> +		writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +	else
> +		writel(FREEZE_CSR_CTRL_RESET_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	return ret;
> +}
> +
> +static int intel_freeze_br_do_unfreeze(unsigned int region)
> +{
> +	u32 status;
> +	int ret;
> +	fdt_addr_t addr;
> +
> +	ret = intel_get_freeze_br_addr(&addr, region);
> +	if (ret)
> +		return ret;
> +
> +	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +	if (status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE)
> +		return 0;
> +	else if (!(status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE))

again no reason for else here.

> +		return -EINVAL;
> +
> +	writel(FREEZE_CSR_CTRL_UNFREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	ret = intel_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE);
> +
> +	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	return ret;
> +}
> +
> +static int do_pr(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
> +{
> +	const char *cmd;
> +	char *region;
> +	unsigned int region_num = 0;
> +
> +	if (argc != 2 && argc != 3)
> +		return CMD_RET_USAGE;
> +
> +	cmd = argv[1];
> +	if (argc == 3)
> +		region_num = simple_strtoul(argv[2], &region, 0);
> +
> +	if (strcmp(cmd, "start") == 0)
> +		return intel_freeze_br_do_freeze(region_num);
> +	else if (strcmp(cmd, "end") == 0)
> +		return intel_freeze_br_do_unfreeze(region_num);
> +
> +	return CMD_RET_USAGE;
> +}
> +
> +U_BOOT_CMD(
> +	pr, 3, 1, do_pr,
> +	"SoCFPGA partial reconfiguration (pr) control",
> +	"start [region ID]\n"
> +	"	- start the pr by freezing the region\n"
> +	"end [region ID]\n"
> +	"	- end the pr by unfreezing the PR region\n"
> +);

I don't think this is the reasonable way how to wire it up. We already have fpga 
command and this should be the part of it.

Thanks,
Michal


