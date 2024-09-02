Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D18ACD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 08:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3A088A5F;
	Mon,  2 Sep 2024 10:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ped+s/Tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CF888A6C; Mon,  2 Sep 2024 10:50:46 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F6488A30
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 10:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv8/+91U0e+CHOM19doZMEFU4OQpON/MXnZN/2CXxirvLAn6m978G4oor4vCh649SnJIbLH70Irsy96VN60sFLFE/Tp9W9SDKaaFvK+XPj3+uM4aEbrFy9MUtXEmWW72eNRtneSW2aRRabLH7PVCL0IyYlAOF3GAlpLASGEQ9GNTRPW9JVV4lhp9SN33PpC0TCuib+Lg7z5g9A0jJyuQjrK7foqLYpF1WXIBh1AzMX1XnIfoMFn4ltpXRzxu0tyzkNr/5AqMeUHbWBj3s6sNROWxSc6zjrLBLdG4wNgzUXjhB50vEKSah+XKgdCjGP70SlFF40dXKJTyKNKKeSAqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTm1qT2lOc16x9jaIzKnBLphyfH93L+zGkf6FbHIqXc=;
 b=HuNFJYLPyatZzob3PCZ4kzoxgQdwyygyRALy0sCTfFpBBJArqplUUjrvUiJLPzDOnN0gUaHeEeh6n8LgKyiBeh+wVQvi48j6Soujlc5mX5br7z9aFZMef9yyQgUoS1HRM4oM2Gk7wEfVr2ieDi2Her9VfAziHuwOnxp5h3KpV/91z4HpQYndnE52igwN3GeEFUkaFatluV+pMK9jbMxacDWIxWkZwqFvrDvbW+bQCgccIxrHIP/vvHhd1Nhx+zLm7U8dH26RVvvs166vyQA3Bcs5joD3VrjlcTeRYGG+hiUadkG+EsRSljPxcJlaeWrxwaPg4S2RwJOe/B9cNDM3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTm1qT2lOc16x9jaIzKnBLphyfH93L+zGkf6FbHIqXc=;
 b=Ped+s/TvSVlo3z8M0fYXxKGrxrEIaVFxniWPOFLq83OQ7zx4RX9L6o+7t9QDHgtYOoD6Y1sq91CVKhSsn422/l9FfDsi9TejtU8AuSf49Q+hnCtXxZpU/7kmwg2l34Ea01kRIC1R9M3JTMS1+iC+Nxx2Gx4rwrDEr+cAa5qSKKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:50:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 08:50:38 +0000
Message-ID: <fa255499-7000-45a2-bc75-ef8441bfdd32@amd.com>
Date: Mon, 2 Sep 2024 10:50:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: zynqmp: Enable non-invasive CCI-400 PMU debug
To: Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@xilinx.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240812220735.3602212-1-sean.anderson@linux.dev>
 <20240812220735.3602212-3-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240812220735.3602212-3-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0228.eurprd07.prod.outlook.com
 (2603:10a6:802:58::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d6c227-ae3a-4868-b5ed-08dccb2c5178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTBMOVFvcWdjMWZHblJNNDFub1VtN28xZ3cyT2tVNjlvckxEdEdYQ1VOajk5?=
 =?utf-8?B?bjhzM05XT0JRL096bFYwYWJNNi9zd3U1aldFajdDU3c5NmpVSy9zazFSMW1L?=
 =?utf-8?B?NThGZCtZb05kTXRNbGsyUVdwNHh6b0ZSbEFoV3h5K3hacEVITlhWdjlJakVp?=
 =?utf-8?B?Rkt1Q3k1bUh3Ni8zcUhjNy85UE5HTXRxcFV4dzlLZHRiajd6WWU3RWtJSm8w?=
 =?utf-8?B?YVhCQW9DQnpRcTFsNjYwT25mWFZPR291Qkw5UTlxOC9NYTJpVWRFZHhuS1Bz?=
 =?utf-8?B?RU50aFg0Q1FvMUtvMUc4VVBlZ1pCRmo0ZkVNUTVSWUlHWTVGWHR1YTY0dHEv?=
 =?utf-8?B?RHRMaWt4OS85MDllUnB6dmwwaElzNWR4WHJGaSs5dmRBWWtTZkJyOVZRRE1T?=
 =?utf-8?B?NXc0WXR0alQwSU5QTnhjTExua2c5WVFzRFhIYk52SUxLS3dPcGIzWVdwaWtk?=
 =?utf-8?B?WVRyVXN1cmZoekdyNXJCNStPSlZ1WTBJaG1UQVhUSzZLd1ZPcktnVVNYUXZm?=
 =?utf-8?B?Vkg3SDFKV29CdzMrdDBpUi9pNzRzSmtJQW5mRGFUQ3V4K2Nac2tQbkhXc2t1?=
 =?utf-8?B?QnltMjRpT0dPb0ZCa3I1dHMyQU1pTEtzR3ExVU1hOUptbGdlQTFPUFFmc2sv?=
 =?utf-8?B?OHFaU2x3MVFiR01FV1AvNXI1Z0ExdFZ0VHRidkVJOG5SR1VnNURPdlhaWnVk?=
 =?utf-8?B?U29oOWJWdGR1Vno0N2Y4OTFjVGk4R3c0Ry9tR3Rkcy9yYzJXRWMyRGdieTds?=
 =?utf-8?B?c2Z5anFTaWpYRk9FN3NMOUt1azdyQ05pWXp4bk95Z2gxZkVwaFNYS3dveTBs?=
 =?utf-8?B?YkhaUmJ6bTN5YVN1V3MycWs0WVpVTG8zVit3ZVhLS0xkSFJXSFpVeFR4UThC?=
 =?utf-8?B?RW5qQU9WSFRCRjNQZHhUdXRpRDJqRThZTm5DR1Y3ZW1XK0lmcEdHSzQxNS82?=
 =?utf-8?B?bU8yNEc3NXlnZll6bTllZFQ1L3MwVFlKMVVwZWhUVHJzYWFvUnorS01YMHF2?=
 =?utf-8?B?NFRVNjROMzkrVlVWd1FXTUw1b0pWWDF4QTVpVkdDUkhnZ1BIblJoTE1MTjg3?=
 =?utf-8?B?bkdXSDU2STIwRDFPeFowWlg4dFpUUlNuZjdmTDBhYUw1czJvcU12RWQrY1VV?=
 =?utf-8?B?dlhtMHNuR1JTc3htVlBHS25TOS80TFluYjdCVnJlOGdkdjBuZmMrMjBDaEw1?=
 =?utf-8?B?Qi9aRStxZzE4cXlCaTVDVUx1eFZRbzdnLy9SVWNaZC8vdm1XbURGQk5NZFQ3?=
 =?utf-8?B?QXBadi9pYjVUb0pNT3p4MHp2dDh5d0c1RnpKZDZjU2VEV2kzNmJPNy9HV2hR?=
 =?utf-8?B?aDgvT3M0R1JrZExjK0FScm1ka0swTlNvb1RTMnB1eDM1NzQ4cUNEcnkxU3hp?=
 =?utf-8?B?VEJ0MzdoUWI4NTJRU3dqMDF1V1BRZFZXVDd4dldtbHY1ZmEzYWN6MFE4Smsv?=
 =?utf-8?B?cEJpWXJ2KyszRENlR1BsSUNyRm04aHJpaFFUQnowM0pCdHpoek16cmtpbjVT?=
 =?utf-8?B?L2pDUjJ2eTcxakVuZ0daUUg0bXlhbHRpR2RWeWNrY3BzK0Q5THpPZUQ2WEJn?=
 =?utf-8?B?azkzZ0lpOCtkaEEzcnd3UDJ0TXFoR1M3OXo3WkZyZS9CTTV2YjRwc2VidlN6?=
 =?utf-8?B?S0UzOFVWeWN6b2M1SlAwRjNtMFBtZ2hUL3dMbFZhbExKdlZCUWp1bVJPWVMw?=
 =?utf-8?B?THg4cVhQNzdHU0R6b0FiTlpLK3FwWnNxUUtpRjQzalJCNW9mWDlRdlg1S2xs?=
 =?utf-8?B?ajMxaUtTT2krSzNKTURaYXFvM2hlbVY4Y0RHTmtOZ2pIRmlQOHJVRHRabjdV?=
 =?utf-8?B?VG1QS3N3cDNzKytpQ1hVQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZCK1RJQWE4Y3pBZFM5RnB4MVZnWGs2OXJGbUVQMWxkM1d3SmhuWU95QkN3?=
 =?utf-8?B?Q2pnQnVDbnNJMTE2ekRCeXJvRytHTVlid2pVd0JzZ0t1aHNNZHRSR3lIYWMr?=
 =?utf-8?B?akdXeGxWbDlUanA2ZFdISGVwVEk3REJkdHZUQWc3Q3hrRnNaSG9zdG5ZNHNx?=
 =?utf-8?B?L3V4QTFtUWZsY2t0dXoxazhwYzEweTdpSUFLV1RRdU00bHIvZmpTYWNuSDZw?=
 =?utf-8?B?UkNlZHJPZCttaW1ZVms5dXdnaUY1RFJCV1BlWm5wV1ZvQVRsRml2ZUxrY3Vk?=
 =?utf-8?B?S05laW1iWVdaYXBKRHQvWkFnenhWZjBGSldVRENORU93Z1FRb0FVUEk1SFpZ?=
 =?utf-8?B?QVRnQkl0YlIwSHlvZUZvWnNmT0ljSVFRRHJBdUVrc0xnZlpNQXl6dktGNEl4?=
 =?utf-8?B?UG9iU1I0K2JyUmV3M2NMai82Mlc1bG5maTIvakR0SngvSDJ2dmNPRzJqZFdF?=
 =?utf-8?B?SmgyVXhsWlpNb1owNWNGd2NWQWZSenAvSEo1S2g1SGc2aHRvajRFK21XQm1i?=
 =?utf-8?B?ZGdIdmxrd0xZUnFUVDA5cks4aUZFcE9jNVlFRFFkRFJ1Q1BvUnVvUWJSTmRX?=
 =?utf-8?B?eVBKSVNGb3VxKzVIMVNqdjBsaVJJUVFRRDY1RUYyRDdyRmx0MmdJMElWMHZ0?=
 =?utf-8?B?SGo3Y1g0T2NMTDNKWjRjNHBCRjYvdmhlcGJmUUtkdTJHV0FFcnhpaDZCa2NS?=
 =?utf-8?B?SUpHMDF6QUlyQ2lGZnRnSU92NXlOQ2RoOFl2cTVLTnl4a25sS0wzNnhwd1Jx?=
 =?utf-8?B?NzZYeXVLZWJ1L3RQRytEbUJnZC9UOGlwL3QrdEpGOEJYaloyQ0kxODdGZHV0?=
 =?utf-8?B?Z1ZmWkw3cHBVaTQxU09yZENjUXJmNkt3emtROXBFMnU4UFh2YlI3YTRVbStV?=
 =?utf-8?B?QmNJbldER1VDeC9XM1MrNy9sT0hFSzFFT2xYYTNNQ3lnSjRQRllWdVJpR2Zi?=
 =?utf-8?B?OFNDUWdjVEJSZHd4Z0VLcmFxR2VVOFpUcEpLeFEzNTlENHZacG0ycUVpRUpx?=
 =?utf-8?B?VUNCeENVQ1J2NDlXR3FpRGRzT2V5VmMza0FQaDhzTHdJa2tYbGJhYUNVKzFz?=
 =?utf-8?B?R2RtSHlMNDZiNmFYbDlFdWhaazB1c0VNOWFhWGdyNUVTVFFOZTIxOU14U0Na?=
 =?utf-8?B?RnpXMno1Yjg2VFoxd3pWaEYvR3E5Zm9MeVg3K1owOXZIL0VoOGNSYkwxQ2Zk?=
 =?utf-8?B?TU51cG9uNktUV09wL1daQnRJdUFuTGlVajA1VExTZHIvb251MlRoTTVZbGtM?=
 =?utf-8?B?Z0RoRXdTZGs2TFhRbjI0Q0NhMUQvSVZaNEpwaUwxY0lLTEJaYWtSaldndlk3?=
 =?utf-8?B?YURMcy8zVGRjaUtIeERaZG9WYmt4K0d5QW5rMUYvci9WelRtd0VobHd5MzNP?=
 =?utf-8?B?OGtzajRDYThxdFZiY2FLamFDa2tVYXR5RVVzMTVXVThnck5PejdKTUtlWVls?=
 =?utf-8?B?TlNydmdBb3NwU1dIOWxsQmZBbHRBM2EwNVBPQXhSZkQvY0pkMU9WZXZqL00z?=
 =?utf-8?B?SjJLWEU4ais5Mi9sdERLZ0pvempEVjlOZUZ1dFRYUTNRaHluSEt0QWV1MEdX?=
 =?utf-8?B?VWRaRWlaTFdZNWFVMlpjN2RQSC9YVzB5V2NVVDJ4TUVvRnZMNEQrbTgwVkli?=
 =?utf-8?B?Q2ZiVjhqSzRENnZGamNYdmsyZ002RFRsQnd6QkE5K01xQVJpR1lhN3pYbnBr?=
 =?utf-8?B?Z0ErV3FPYWxMZjhEdlR1QWFSYXY1QTNoaVRnWlNMSFZvZTgzSWxNUjY0U09M?=
 =?utf-8?B?di9FQ1NnSC8yZVluc1UxdVF6KzA5WXZ4TjJQYWRmU095MWV5aHp5WisyZnc2?=
 =?utf-8?B?Z3RNMTd6b0ltYXFJRWpXSGJyM2NVR25zWGo2OXVwbEM3T29sb24rSE9KbDFi?=
 =?utf-8?B?akNWS0U2RjRBVlpraEVST0pFTHMzOHRBcjBtYlJFYUZzamxheWxRSGRoNWNz?=
 =?utf-8?B?bVd4M1dMelRkRjhFZlBjbEhZdk1PR29jY3JVc3c0SGZ4bjltMnN2SDAwdEhT?=
 =?utf-8?B?am5vLzhZcDBEMVRJQlBZWndaZE9ZYW1iRjdmY2s1YXVpQWsxSGlFSzRGbEVB?=
 =?utf-8?B?c2RsSFhmSjVmVVFBbU9FYzFFa3E4N0lRaW5FSmoxQVl5d2xpWmt3TE5OSFVF?=
 =?utf-8?Q?ezCZe2GDewvEbjsDeGyBXpSnC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d6c227-ae3a-4868-b5ed-08dccb2c5178
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:50:38.8834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi6FuvsR6xOSfi5y/FzLtXwZWOUsL/+NfqfsJR8+T8DYxXeuByogWLh0lNhGEUPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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
> Set NIDEN, enabling non-invasive debug for the CCI-400 PMU. Otherwise,
> the PMU is effectively disabled.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   arch/arm/mach-zynqmp/include/mach/hardware.h | 3 +++
>   board/xilinx/zynqmp/zynqmp.c                 | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
> index f1514d6a869..51eab3509b8 100644
> --- a/arch/arm/mach-zynqmp/include/mach/hardware.h
> +++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
> @@ -128,6 +128,9 @@ struct crfapb_regs {
> 
>   #define crfapb_base ((struct crfapb_regs *)ZYNQMP_CRF_APB_BASEADDR)
> 
> +#define ZYNQMP_CCI_REG_CCI_MISC_CTRL   0xFD5E0040


Normally this should be described via structure but some time ago also macro can 
be used that's why I am fine with it.


> +#define ZYNQMP_CCI_REG_CCI_MISC_CTRL_NIDEN     BIT(1)
> +
>   #define ZYNQMP_APU_BASEADDR    0xFD5C0000
> 
>   struct apu_regs {
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 94a66684af2..e0ff2607952 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -76,6 +76,10 @@ int __maybe_unused psu_uboot_init(void)
>          writel(0x04920492, ZYNQMP_IOU_SECURE_SLCR);
>          writel(0x04920492, ZYNQMP_IOU_SECURE_SLCR + 4);
> 
> +       /* Enable CCI PMU events */
> +       writel(ZYNQMP_CCI_REG_CCI_MISC_CTRL_NIDEN,
> +              ZYNQMP_CCI_REG_CCI_MISC_CTRL);
> +
>          /* Delay is required for clocks to be propagated */
>          udelay(1000000);
> 
> --
> 2.35.1.1320.gc452695387.dirty
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
