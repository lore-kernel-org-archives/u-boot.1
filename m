Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5CAD609B6
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 08:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91581892B8;
	Wed, 27 Nov 2024 09:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qcs2FSqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAABA89657; Wed, 27 Nov 2024 09:44:59 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACE488C44
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLXM7oKPWgXBw07fc/JCofJEE+WKq/DwIlTavTRrpg26s6EnBZnvLpybhZ9hDGQVaje5IGBGi0tYZB01J0LD3oW4I367T4TR1biH4DLcyK9M7PxjViYEQbP7JoZi/DAGWleoqKXVByWcVP1JDoMSoztuCJKq+YGkQ30S07Vm7xK77NM1KidXb/bhizNYFUPtl6OrQbEyE2hC0foMaSefBmfjb2bszvRYsdXKWOyFiBJyJlw5fo49pgA6BjlTbQPG9TgT3ssQjsCYRINfKzfVYXBprKJKM6b4My+AIfABt0CAIH5s6huLJmyNOU/SweUIcUam1bdlNERcqWQzq2JkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N1BzC8ao9JlQamo71WOY2nJEIzGh77ud71y5qKJYvU=;
 b=fEwzIt6V4fQdrYUICZ+HNgaYwfb1vfRqU/Kux/Y1we7hPDv89KYnS1n4qFic3g8kUX1JE5yrM3FAIq3rwFC5yONeC9ppJyqvEcne0Pvyjx/Mv/X/qAUAwRjqmUCVUexXxF4jlf10bqnvoFtgiHL3XYMuND6+QVc7T1MbnY1FC0jg70drfRmImS/qost4P/m5e4BHdnn8LM8DpZCUnVSW+9cUzPK9vFy2M0wbCOuvkLDbAJtCUk/9ellOIyXsh/a+bY7vPBW0QOxKsFHViuGcZfXm7zJ9XBj5o9tizG+3290zc8WGoGUBjhbR7Uf/TPhfza8sm2lWa+fvdWhePrFRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N1BzC8ao9JlQamo71WOY2nJEIzGh77ud71y5qKJYvU=;
 b=Qcs2FSqwrtwmW785OUuVdB9C+AzSttkEJp/AC62cDLh0SwN4qRAtIY9PPswxOeSKVfQzKDRCtnW+pW2uljH8HSuZCkR+3o481bCA+10qWoazFJjuBHeaRFLBqrNsO4q11vGmNzsvCErSa9L1YRx8zJOSSI2TpzSsoiIk0VyjsL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 08:44:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 08:44:48 +0000
Message-ID: <5fa9ce53-f616-495a-9480-4935836fdef9@amd.com>
Date: Wed, 27 Nov 2024 09:44:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cadence_qspi: Refactor the flash reset functionality
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 git@amd.com
References: <20241108063537.13180-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241108063537.13180-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: eb96abb0-1f9d-46ba-cd30-08dd0ebfc062
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmdDUm1kZWNDaDkwV0xjODl2K0hVUTg3RVFNbk5GZDFmallzM2FMcC8xSGhp?=
 =?utf-8?B?RFdQcUhoQU50U3NDQmlYK3Jic1pQRitDK0VtR2JKN0VWUEpvTjZQa0VmNHd5?=
 =?utf-8?B?S0NKQjlvUDB4UmhEMis2UmxYdi8xYVp2VitLSUNIL0tIaHZoNjJMMjNvRmUy?=
 =?utf-8?B?WlBTdUcwZUhpaGYyQ01QTm5CbnZNMkJSL1pDeGxGb2lmS1BMcU5kQTNyeEJ6?=
 =?utf-8?B?UUNQcVRxN3B2WWdQdXk5Ym51TEptWmw3dXEwK1Vuc1lSNnF0V29ScE5yZDVP?=
 =?utf-8?B?aFVLbUJGaHM4RGRmalVoTkQvY2pQYnUyOC9vU1lmSkhpQVN0MXF3Mkw2em9K?=
 =?utf-8?B?d1lLN3hsbVY0Q2VzSGprRnVPWFhpeEx1dmFqRVMxanhhKzByVUIvRjNpai9m?=
 =?utf-8?B?WWVaVlh3MDZMcW1QakZUNG1NQ1NkM25Ldk9BWEJBazVUWXFPWkVjbEpiaFZy?=
 =?utf-8?B?aXFyQVZJWDQyQmhCMkFBblEvSXp4azhyMC9OVWVGQjZDTSs2S0xCYVNFMVNF?=
 =?utf-8?B?YWZlNVlWWjdlUWQwRmw5OEwyMGljVSthSjg0UFVaOVQvdHJOdjJwU1FhTkVR?=
 =?utf-8?B?ditsOHBjY0RIQ1VyNkp0YlpLcGZ2TmFFZWJIK0lBRzJtblg4ZkwwS3ZqTVB1?=
 =?utf-8?B?cm0zaVdUMWlmWTZIa0lCd0tQWVZhUmZRZlhkNTJyNzRucERWMzNCVUhjRXRm?=
 =?utf-8?B?Y1B0VHZ0cjZjWkFYK3BFRzhLYmhJeGduQ015d3dJdVcwSnVXb3dIVWViRzFs?=
 =?utf-8?B?WmpXb3d5ZVJjUHQvMnZvQU0wTi85NFMvUWxKTlNZS3ZZOGxmcmJsNU53dWNz?=
 =?utf-8?B?aVRxSFByM2ZPMlR4WXRLYjE5SWlWT2w2dkU0dFhYeVdRbHJRbmtWczh1dHFp?=
 =?utf-8?B?OWhmUXdLSlBNS0k4VFNEYkczRmxaR2tEeVJZcGZNaTlzWEptWEUyeW04NkNx?=
 =?utf-8?B?K3VXL0VzLzF4eXBRNEtBTkFXNCtFeW9kR2dSdHFOOGI4aVhjd2J5L2pBZWhx?=
 =?utf-8?B?K2h5cWRUMHR6NzJOVjFVbGQrRzd1MHdRVmpnZkJ6bkt4bnhBQjFVYUNyM0pG?=
 =?utf-8?B?Wk00TEErWm9xYmEvOHRsaWlIdTlaVzRYOWFUcXRISk5mU3M0b2hacUkwTStw?=
 =?utf-8?B?ejNDbW1FT3Ivdk9CVXNEMmRiL2tyOTFIT3ZhZEFxejRLbnhROTh3RnhEck1y?=
 =?utf-8?B?VTQ5S1RKTXhZSTg0WmNnOVZvdlYvQWZoN0tJUnRvZG1wS1dPRStONytXVHZB?=
 =?utf-8?B?WE1pWmswTjVZR014UEU2Vk1YcXFLa2dzWGxUVTROeDJXWnF1MFJheDFIRW5O?=
 =?utf-8?B?WFFxWHR2NXZ5bEdDYVVtWmt2enNRZlJTNnBhaEIrYzZwVVQyRWVpemlFcDdD?=
 =?utf-8?B?OW1FbDgzSUxKYlc4a0J5ZmhmWHNHb2xOODZHalQ4OE9TT3g5bDFFZ3d4MDYw?=
 =?utf-8?B?VnEzeVg3aWM4Tjl5NDczZTJSdlNMOUJXNCtKa1lXY3dsTHJ6SUtXZTZwdGFW?=
 =?utf-8?B?RE9PdXA4OERIdnZNTmxXZUxEMkJPMXhkZXNQZXRGcHQyYlVTRmE4MG9RVW85?=
 =?utf-8?B?Wlh5V0I0dGJLUjVyUlZ5M1orSFg3T2hVL042WXRic0ptV1ZaUEw2RHhnd25I?=
 =?utf-8?B?Y0tEUjhtV0wzVU9vRWd2cml4T01xbzgwWFhHeEVzUm5aVTFGTjhKbTR1cjla?=
 =?utf-8?B?VTBBNjVvTk5pRUdGK2xYdXV3aVNQOGFBZFlyNmFlUjNVV2hYQkQ1WHhJMmV2?=
 =?utf-8?B?RENTNG1ZTm9mUysvZWt5TnkrL3NQVWRub2RYQkIwTVdVNVBxZUJKSGxJd1lY?=
 =?utf-8?B?d0lpRUQ4NExIY2VpRVlYQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEFtaFlKZjJ3WU9va0NscldXYjVPaUVYRTg4MThiTWJhMTRheE9QNmZBYjdx?=
 =?utf-8?B?VUF5U3BNSC81dFNKK2JDc1prTXNjRTBKZWNWOEVHUDZ1L0ZwNlZwV3FKektz?=
 =?utf-8?B?MnEvekR1b3p5MHliU3dVSEdtUW9kS3ZBbmFOUUFKdGhLOUpRTVNOOGVvUjdk?=
 =?utf-8?B?bUh5bEtKU1NRdDJHd1ZFR3JrdXo2U3NlbUpqSHcxckM4d3d3dzJZbFpla2Rv?=
 =?utf-8?B?MUlxSUUyVFk1NWtrOFdCL1FOcUtjUUs2Y2NJaUJVMW9uREVUb1JSSTVZY092?=
 =?utf-8?B?OWdLUGxkZEpXRWNNRE5VRVBQWXNlN21kd3lDL0xSenUyczhwdHJHWlU1TVVh?=
 =?utf-8?B?cHgrSktRUE1jdVZYT0J0cGY2Rk5tRFlPNVdndmJmWUVjaU00NVByWitua0Zq?=
 =?utf-8?B?VkpEMzc0akZjdHY0Y1RTTVBpOGtRUWliU01HVnppS21iUUVkNXoxVExYSE1s?=
 =?utf-8?B?aUNSTW9NMnhsc2lpSHppbHRWNDVrcWlJY0NvbWJmRk1sbW5rS0FZWDZ3ZTRp?=
 =?utf-8?B?cVBsMVo1eW9iVmkwa2plcmVDQWcvZUtqcVBsNjBhOEp1NEdqN1dWOVlJM2pU?=
 =?utf-8?B?dFNkV2ZzR05JVm92bzI1azZ3MGtBMmVDTzZTcUZnaUFsZ2lkZ3pRd3Y3MzFK?=
 =?utf-8?B?R2hObjBEN2NIU09qYThuYXZNbnIrRmtPVHVtZ2NlV1dmN3hiVXdTTGo5SzJn?=
 =?utf-8?B?aVNUdEVQTnlLejlkTnh2Q2dWSUo1cWVuaXQ0cUM0UXZISXNRQ2FjdzltaGpt?=
 =?utf-8?B?dG95RVpkTzBRS2ZPSGRqNkZpcnVZZHdwRndZblB2VXRNL3NFS2U2TUxvdE80?=
 =?utf-8?B?eTh2cnhKRG5lc2NOZDVyVllsdWRVOEpUelU1bFdPUEFYMEtPN2FKUVpRaTEr?=
 =?utf-8?B?anVtaVJwZUpmY242ZWg3MmI0UWg2N2dna3o2QlB3cWJWSlJKbGNJR0VTbEZN?=
 =?utf-8?B?c1d2dnJMVHJIZVRhcjFrWXVKUkhpSE83SFUwQS9IcjZWQ1pVRnYxR21Vejhn?=
 =?utf-8?B?SnE0NzdQdUh6TVF5NHR1V0JGMklWcUREWW1ycEtyTlNXWHdrMmF0NlJLVkIw?=
 =?utf-8?B?SDl1a0sxcVlHS2NOcVNJT3V2SnJGRzhtUU9BcDN4NmhONkREcjBUZGZwUTNK?=
 =?utf-8?B?bmhlQjM2N2YxdlNLSXhPbVhvZjhYZEhzRXlyOWZ0T0tKMXdCTzFyWHh6a1BQ?=
 =?utf-8?B?Q014RXFmaVNFaG1tVGMzY0MxWVRNUTl0ZlZ2b2w5SU02SEhMMTVFUDF3VGM3?=
 =?utf-8?B?OVhSOUJZNmV3NTY2emR1RTRyU0dPcjZ0eDJrZnNyLzVHZ1NQSXZadE0yZWps?=
 =?utf-8?B?RGRtbDN2c2RLMjhNNk94Z1pOa3RxZlEzc1ZsSVdiVnlyRWlBL3ZMaTJROU1y?=
 =?utf-8?B?UEVZYWZ5QkltYit4bkNsUTc4THk3VjlBOTNQUlRNc29BcFR2N211ZVpnMHFh?=
 =?utf-8?B?YjREMHgxckMyTXpGVXI5ZlVKVXZaejB0ZlB3dE1vVFA1OUxyaFdzN2RacGVn?=
 =?utf-8?B?VXJSc0xVK0QzQ1hxRlk1RXRVSVdJV1VJTHUyQTVZb0ZIaEk3UFQ3QW1GM0dX?=
 =?utf-8?B?WjJub3lWSGJJSmJDU25VcEJSYXZ2SFB0VW9LclBUMldrMUlTODVJVmNXNWlJ?=
 =?utf-8?B?V0dsY3V3TWRmdjZOVjYyUXFtMHVOakt1YUtBVjYxeUlIVEdtRElNWCtqak90?=
 =?utf-8?B?SUJzSkNHZ0NsT3c2ejFjMnFzcksvWlAwOWNiYXRMS3gyWitHVnNFcDAvb0kv?=
 =?utf-8?B?UmVqaVZoaXl3UkxoZCsrb1hWV1F6UmVOYUNhbG4zL0FDdjhJVnlnMk5GcTJn?=
 =?utf-8?B?NnRxSlFKdkNPbFI5N1g1ODNMSVloTkZlb21tWGtaSFd5R2NyQWU3S0hSci9l?=
 =?utf-8?B?bEFMaW1Ncm5WOVhTa01ISU9SRHk4NWFIZGg5emFiUDZLM3cyZmJkQWRJNVBk?=
 =?utf-8?B?N205WU5EY2Rqdi9td1kvREQ4Y3gyNGlwZlpOUFhobFgzUStCZ1hjeHRTM1lj?=
 =?utf-8?B?UUdaOGJuYzJyaXJtanFMRE9ROW9ZWUdTbW9wWjdzYTk0K2M0L3FQelB2UXFQ?=
 =?utf-8?B?NkNIRXpLVUlBSGIwM1B4NU9pTFlmTHNFRkhtbVZIaHdhZXNmNndPU3p6SnJI?=
 =?utf-8?Q?izTnJx40TwVJtuiK8CXzmhaTv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb96abb0-1f9d-46ba-cd30-08dd0ebfc062
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 08:44:48.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOuPq2vjBUfRVBq9OlWfi0kax44Rts4AtVdVRUlnMNePnRo3ycVXq3eQVPeIaDYI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
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



On 11/8/24 07:35, Venkatesh Yadav Abbarapu wrote:
> As the flash reset is handled in spi nor core, removing the
> flash reset functionality. As the configuration like tristate
> and hysterisis need to be enabled by the cdo. Handle the flash
> reset only for mini u-boot case.
> 
> Rename the "cadence_qspi_versal_flash_reset" to generic name
> "cadence_qspi_flash_reset" as this can be used by other platforms
> as well.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Rename the cadence_qspi_versal_flash_reset to cadence_qspi_flash_reset.
> - Add the DM_GPIO flag in the paltform specific file.
> ---
>   drivers/spi/cadence_ospi_versal.c | 45 ++-----------------------------
>   drivers/spi/cadence_qspi.c        |  6 +++--
>   2 files changed, 6 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index 222f828f54..dcf28c7559 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -125,49 +125,8 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
>   	return 0;
>   }
>   
> -#if defined(CONFIG_DM_GPIO)
> -int cadence_qspi_versal_flash_reset(struct udevice *dev)
> -{
> -	struct gpio_desc gpio;
> -	u32 reset_gpio;
> -	int ret;
> -
> -	/* request gpio and set direction as output set to 1 */
> -	ret = gpio_request_by_name(dev, "reset-gpios", 0, &gpio,
> -				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> -	if (ret) {
> -		printf("%s: unable to reset ospi flash device", __func__);
> -		return ret;
> -	}
> -
> -	reset_gpio = PMIO_NODE_ID_BASE + gpio.offset;
> -
> -	/* Request for pin */
> -	xilinx_pm_request(PM_PINCTRL_REQUEST, reset_gpio, 0, 0, 0, NULL);
> -
> -	/* Enable hysteresis in cmos receiver */
> -	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
> -			  PM_PINCTRL_CONFIG_SCHMITT_CMOS,
> -			  PM_PINCTRL_INPUT_TYPE_SCHMITT, 0, NULL);
> -
> -	/* Disable Tri-state */
> -	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
> -			  PM_PINCTRL_CONFIG_TRI_STATE,
> -			  PM_PINCTRL_TRI_STATE_DISABLE, 0, NULL);
> -	udelay(1);
> -
> -	/* Set value 0 to pin */
> -	dm_gpio_set_value(&gpio, 0);
> -	udelay(1);
> -
> -	/* Set value 1 to pin */
> -	dm_gpio_set_value(&gpio, 1);
> -	udelay(1);
> -
> -	return 0;
> -}
> -#else
> -int cadence_qspi_versal_flash_reset(struct udevice *dev)
> +#if !CONFIG_IS_ENABLED(DM_GPIO)
> +int cadence_qspi_flash_reset(struct udevice *dev)
>   {
>   	/* CRP WPROT */
>   	writel(0, WPROT_CRP);
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 9c466f8695..c8d640f068 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -33,7 +33,7 @@ __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   	return 0;
>   }
>   
> -__weak int cadence_qspi_versal_flash_reset(struct udevice *dev)
> +__weak int cadence_qspi_flash_reset(struct udevice *dev)
>   {
>   	return 0;
>   }
> @@ -259,7 +259,9 @@ static int cadence_spi_probe(struct udevice *bus)
>   			priv->read_delay = -1;
>   
>   	/* Reset ospi flash device */
> -	return cadence_qspi_versal_flash_reset(bus);
> +	return cadence_qspi_flash_reset(bus);
> +
> +	return 0;
>   }
>   
>   static int cadence_spi_remove(struct udevice *dev)

Applied.
M
