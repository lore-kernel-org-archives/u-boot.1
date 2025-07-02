Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8DAC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD4C81FEE;
	Wed,  2 Jul 2025 08:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bTT7yG/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE0582103; Wed,  2 Jul 2025 08:35:05 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112BB8003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx8GkvRvFybQAH3N+WdqiQoxB+BRtCCtqZfbSMgpCILRJUDzyXVt/dD4bdg2WsVZoDaWHaU7O6hBNxLIo4IoHOWbzxPhTm5ZyCB6xadSOTomsZa5+ss6uMUm+pa+CVD2FfbyAoT27HtxLn36hJjhJU/Mgo/c8Xl5QtI0E+XIeh6FUmBP1fBJUQLcxzxV0BZlP03jdY0QhHnyTCqoLH7XerF1wXl+FxIRIdj3ep/TwCMmUDeC4vfvBEMDM2DGXSHEPkQMDJSiZhcCfuuD4QHAMxc/mUyQ2l4AMy8T+FxDIQlKOte6+FqFvd2Yu35znaLInvzIXCfD42jILeA7lZ5qlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1gzbaeopXk25egZKgFlioehicxwVXgyaxXBvlB3mXE=;
 b=RONRSXiOVIc8Kh0qDO9rLVX2tqQR5BMAvKDwyaymI1WD5Mat2/7ZgaFCHca3yPv5L6JJ1TLEeWulFjSuR4hFznQB3CppO7NwQG1w0RwetPC2MvOlEwaAzOBQUjDywNtwaio7goDzFchwHHL4Q7N2bFBb749MSHxkB3k4XUNitxHdmclnGE0hCZdtItsNoSonDXlVIXxpVNvNxY3mrCyY/SbylwhQXPLSKrWKjSFWr/+VZgQS9+GNfQonV+A7wA7y5BATvXtp1oUSI8vRe7e0+bhRan9FQVR4kinS0T5l1ISLXFj5ZA0o6tc139WATg+SK19XlYl8+beOpUWxrTuOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1gzbaeopXk25egZKgFlioehicxwVXgyaxXBvlB3mXE=;
 b=bTT7yG/s4Q387sxemIHxriuS1PjnHfwmtQ9Y4IMLCxZ64WTx1ptQZ1L1hra+JFZZT42OEnFwHr8xB8ZYFV4NBteDlghcO+UWbG7VjA8YhfZW7H7z9OMzcc6e57S9M3r5nw3XuFB+OtHXWVkDkJIkCqNHSRyfmpYI+Z8Ug2+DQks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 06:34:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 06:34:56 +0000
Message-ID: <9afa2f72-d093-49f5-821a-0233769582d8@amd.com>
Date: Wed, 2 Jul 2025 08:34:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: Prepare code for new SMC firmware format
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cf99fe1af82bc004de3e313d4018464f4504f380.1750858165.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cf99fe1af82bc004de3e313d4018464f4504f380.1750858165.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:a03:60::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: d35d3f04-2c75-43ef-00fb-08ddb9328f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXd6YWFBU2FEQzh1aFkvbUpYdlk4NDF2RjcwOVpPOHhqaDNIbnp5emhQYTE5?=
 =?utf-8?B?WTZBMGRrMEFleTZiQ3lZeFlaRmxKa3RZZ3BaS0lEQU5GRWd4RDJzL05lSDQ2?=
 =?utf-8?B?bFRzYlRqWGptVEMyTjJISkJwL090UkdYdFFzTEdjaElRUnRpbFdUeDdCUU9n?=
 =?utf-8?B?RkN6c05oblZNekNhSkR2N1F2K210TU5jdGRHTDhZUnRMRHd2RDZlK3BvQUda?=
 =?utf-8?B?VXg2U3l4TXV2LzBsaXZLZVAxS2pINW5sTkxpdGlFRFQvQ2ZLQzB3a1AyQm96?=
 =?utf-8?B?bnBQaXM1SVMya2dGWjBLeXJRM0RlaTAwZzZyZmNsaTFvaWd3RmRNZXBycE1R?=
 =?utf-8?B?eFRqODY5aUZjRzJvQXJZYitpS2t0MGlpeURraDRQNVZWK3FDR1FjYjl0emxl?=
 =?utf-8?B?U2NNcm12MDFVbG9DUU16NEw2SjFXRk45ZXI5UFpuT1FmelZ2TUVYZE9rYXMy?=
 =?utf-8?B?cjMwMDVqUzNZVGFrVnpMY2JRalg0UUJZZnFad3MwODg0QnkrY0o2UUh3OWhS?=
 =?utf-8?B?VW9TTVFBWTNsaStqSTFZcnZVdU9IRVNJRDJJOVpqRUN0aVdMZXAvZWJwaDVO?=
 =?utf-8?B?a1FDemkxSEZkWjhJQzlWS0VScGFyWXNaNUdUcGF2dHROUkRnZUNPaEl3M1Zr?=
 =?utf-8?B?SkQvamYvMExiNXIyZjlYcDZZT1Z4bUl2cE81WU51RGxwa0ltREVDYzRnL2Ji?=
 =?utf-8?B?TVRMU0dYL0lOSndvbnVHV2ZxOUNUMmxnUXExMEJyYng3dU0zNE1TMkZ3V2NT?=
 =?utf-8?B?d1Y3dVRIUkFzTXdkb3VZUk1lRmp0cTVXcUtad1l1dW1zLzl2eHE3YkJva3FM?=
 =?utf-8?B?OXlIekhZNkdiS3djWm1iUU5UcmlXa0svdVNURU53WStkTTNXUHBleHZwSUk1?=
 =?utf-8?B?b2xSdjFMYkxJanU4MUZmbTlOREtGZmQ1enlRKzJIVzU5TnNSTG53WTgxWFE3?=
 =?utf-8?B?V2ZCclJmSmVhQitmMy9qdThWVW1GUGZsRXhSTVlpMEpqd2xXTTNwWDJWWFRp?=
 =?utf-8?B?cEpsa0FFdEtWSVNqVkhoMGdiY0JnZk1DdnBoUVYyVkxYWnVDUlhZTTBuTEhw?=
 =?utf-8?B?YktQQzB4TEpVbmk3dEZ0c0ZWSklWTXNIK25nRWdXL0FSRWFrWGw2SGJreWx2?=
 =?utf-8?B?VG9TY3Q0Y3B4a3F1ZHpmWW5DSU45WVFzVjZUZXkydXRTVnVWWW9TNnFWTDFx?=
 =?utf-8?B?UWQxY3BMVGtENFVlTnNrL1lKRytVYS9jNk5WR2tDWkpDY2VEY3M4MjZzc2dn?=
 =?utf-8?B?b2hVblNmVStKbkgzU2V2WldXazh3UHVRcGEzQlVGR1FYbHJLejF0RGliRyti?=
 =?utf-8?B?cUk0c29NK29rVGRERklrU1hZMmxzQVMxcVQyZjBqUk0ra1lMSzFZZitHRDlv?=
 =?utf-8?B?MUJUQ1NNdjlQQ0lRTE8wcUpCSW9qazRLVUl2L0t0QUZ1T0Q4M09HQlJsT0pr?=
 =?utf-8?B?VkxDNU1iZ2FPSFlPMjVlVFpkc2krNTVFTGhmRHZ5N25TcjZMWGIramQ0ZUY0?=
 =?utf-8?B?a3JsQjV5Y1hPYUNyY3AwaHVWMVkrVkhQdHpPemVyczFFL2toNUZYc1ZuRU1E?=
 =?utf-8?B?VzlCdjN4Znp5NXJ1Z0RWeXd4bXhmUzFhWkNUcnFjYUJKSTcxMGI0VHd3LzZn?=
 =?utf-8?B?aHhMdi9mVFhZcHFUSytYR0p5NDhnZU9Wam4vSll1T2ZWNUptanEyZk1Qd1R1?=
 =?utf-8?B?S2Y1Smx2NDczVVJsL3ZmQWpQWkZ4SjhaTlRzMXkrSHZuSEdRZktEZ0pzUWlO?=
 =?utf-8?B?RGV0THhnYWFJa3BodmhpdEg1K1RtaHlKZUFLbzJmb0RaeFV0cmtQOHVLaTY1?=
 =?utf-8?B?S0x2UFdCUDZZbEZwZjhhaG5TbG5mTTU0U2xNcEtuRGdwdTYvaFQ2Y21ya1RY?=
 =?utf-8?B?UUd6bC9SaHNtTVB6U2tYZzVnbnY4NjRDazEyRnJZK1ZoU2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1grY0JhdTYvQlVWcjB2WHJsZEpka3VKVERtemxxNGtsWWU0V3FoS0xmWGho?=
 =?utf-8?B?T2o5VHJ1aG5NSFhNbHdFOU04ajQwM3daV01CcVVObC9uNVpiU3gySkRmcU83?=
 =?utf-8?B?aE9xcU5xWEhmNUxwT1VCUzN5aEFkV3BMRTJEaGkra3JSckNmRWVSaUpKQmRX?=
 =?utf-8?B?c1RxVWJDVzM2R2RMRityUjkrMGdmdlRrK2wyZ0E1eG5McG1lTHlkanptVHN3?=
 =?utf-8?B?NnEySm5XbmFBNHpsQ1BKbHRNUjVxV1RoNTMyZDNmczBXLytLM1BaZkpkQlFk?=
 =?utf-8?B?LzFEWG9YRUczNTY0amhrSHBsb3c0V0ZYbTY0N2J1K1RYdDFpUlRmSzFwbzVk?=
 =?utf-8?B?RldkYW44TnVZYURMRTFyR1dwK1FtNDNLS21kcC9nclZDc3BDQ3dpcXN2SGZi?=
 =?utf-8?B?MDZhQTRiK29ZY1h2Q2pENTNCL1dwTzFFcmFmVWhSZ0gxMlhzZVIxbXludC9C?=
 =?utf-8?B?S0oySWJ1WFJyS0J2ZUVKZU1IMnZuSVBuTGpiS3FoemxBMWRHU1BCOUh6N2d3?=
 =?utf-8?B?d0JHQVJsa1BTR3BvSDZwNDVHK3Q5S0Q2djJEUXdqMGhvU2RyVzhXUlVVZmtV?=
 =?utf-8?B?MGJ0SytLK2MzU213SVQ1NU9CNjRTUnA1VEtmTE1GT1NybG9IRlBFcUVNSmVq?=
 =?utf-8?B?U3VZNGhhZ1pXWG5CbldwYXd1TlJISWNic3orV0YyaXY2MTFDVjRyTXhjS3lt?=
 =?utf-8?B?Q3gvS3NqeEJHd2xNYnVUbzhWZFRhTkV3Qngza2xzejRYWWRHUWFSYVZyRjdS?=
 =?utf-8?B?NE1Cd3N6N1IyZEpMS00vMTlHMXlRcjRBcFFTM2dHamxYN1h6VXhPVWY3RTZX?=
 =?utf-8?B?aVJhMTBQSFQ4MEx6ME9lYWlZdkd3cUR1WW04ODE4Z1Y5M3k0bWFMU203b21l?=
 =?utf-8?B?VmsxZ0szZHVtTXNaSDM1UUtnQ0dYdlJDL2hBQnZMS25WeUlSV2txbGR2emJx?=
 =?utf-8?B?cml3L1JBNE9qM2EyN1BqRXhGa0d3TURoa3lZLzU0YVUzeWU5eGV6VWtJd0ln?=
 =?utf-8?B?dEs3cm5HbTdQaHMzQTcwMUNDUUFyV3NtY0tscU1wckNDUVFJMGlOOEdhZitK?=
 =?utf-8?B?Q084NHg5OUJMelN1OEtZcHE2R3U2WHhLNGVDeDJrT1Vmd0ZKMS9oSEpPdzJz?=
 =?utf-8?B?US9nQkZVMXB3UkdJcVJhMnVtQU5SeXpEbW5LV0pFalAvNUtPWVg3dlg3bi9P?=
 =?utf-8?B?aVNnTStCQjVzZURhRmFGakxCZUxsa2lXeHNZdWZwYWxqQnArcEdQTS9WZlNX?=
 =?utf-8?B?bi8yRnpMeHdwQXMyU1BObExtVy8zbFdTZEhTekdkUzQ0Szd0L1BKNW4xdWlV?=
 =?utf-8?B?emUvSmpmQUlzNHcrYUdHRWFrTi9rcVZQNEJHQnBoL1hFeHk2RFNtOFlwbUVQ?=
 =?utf-8?B?ZHVDZkJyYjBqdmgzQXBwVVN6Y0RYdVdrR214NFZ4NnBMeklrNWxrY3dQVnBw?=
 =?utf-8?B?TkxCTlA4NHlNOUZXbXN5WUtoUDFOL3dFcEhnSWZESEVMRkdGSnpMMW1VVzhL?=
 =?utf-8?B?TzNZYkNlbnJ4R2luRGZCOWRjYjJGWkttV3ZRV25GZ3ZKdFJzUlhsWFhyYllW?=
 =?utf-8?B?eGJndU9FRjdaWloyaUdOZFAwVXR6VTMzZ1EwM0FvTDdGRTVqT0I5K2hzdFla?=
 =?utf-8?B?Y1hDajVYakpqbUxYK29ON2NLcVZLWjU4bDZXSjhBVFJCVnF4YTV4VXowVEFk?=
 =?utf-8?B?cjBNdHBtL3Fxb3FqYmQrbE5UZ2F0em1sRGVwN3oxRksvRVFKcjJlMy83M291?=
 =?utf-8?B?UTFSS09YMjlyRGdHdmkyYUt2Ly8wcm5MOXZxYk9meGdDenhHZUxadEZPQ3ZM?=
 =?utf-8?B?TkdsMHVxNDZudW16OVpwZ3d1Snd3cWk2a01pQW5JaC9KY1dIWEtjaSswd2pz?=
 =?utf-8?B?MGhRNFBlY0pJR2thallaS2s2d2YvYjN1QU1Nam9UTU9VNEFIQTEvRkY1WExn?=
 =?utf-8?B?V1FLblN6RllRYzYxaXhWc09hNUFzMkdJVFhPWkVYaWdwQS8wVklHQUhGUWNo?=
 =?utf-8?B?RmpLTzg3Qjk2L0hiZUVzN2duSmdxK0pWSW83R3RHT1VRWW1acllpY0gwMXlS?=
 =?utf-8?B?REhTalZxMGhrRWxoa21yM25mczFGbGxoT25JNHR6VDRXWDQ1bnUwNmpJMU50?=
 =?utf-8?Q?+ML2qwnOL1mGJWiV8BLDE8jgf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35d3f04-2c75-43ef-00fb-08ddb9328f75
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 06:34:56.3643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUf33OQODpfdNBOiQSMTvbwqe9EpRFaam2yIIPqRoTRgTmQ4j1xyh91+ghcpPTSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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



On 6/25/25 15:29, Michal Simek wrote:
> Separate code to own function to be able to add new enhancement format.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/firmware/firmware-zynqmp.c | 60 +++++++++++++++++-------------
>   include/zynqmp_firmware.h          |  9 +++++
>   2 files changed, 44 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 2940181e83e9..d18ae523b6bc 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -422,6 +422,30 @@ U_BOOT_DRIVER(zynqmp_power) = {
>   };
>   #endif
>   
> +smc_call_handler_t __data smc_call_handler;
> +
> +static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
> +			   u32 arg3, u32 *ret_payload)
> +{
> +	struct pt_regs regs;
> +
> +	regs.regs[0] = PM_SIP_SVC | api_id;
> +	regs.regs[1] = ((u64)arg1 << 32) | arg0;
> +	regs.regs[2] = ((u64)arg3 << 32) | arg2;
> +
> +	smc_call(&regs);
> +
> +	if (ret_payload) {
> +		ret_payload[0] = (u32)regs.regs[0];
> +		ret_payload[1] = upper_32_bits(regs.regs[0]);
> +		ret_payload[2] = (u32)regs.regs[1];
> +		ret_payload[3] = upper_32_bits(regs.regs[1]);
> +		ret_payload[4] = (u32)regs.regs[2];
> +	}
> +
> +	return (ret_payload) ? ret_payload[0] : 0;
> +}
> +
>   int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   				     u32 arg3, u32 *ret_payload)
>   {
> @@ -450,38 +474,20 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   			      PAYLOAD_ARG_CNT);
>   		if (ret)
>   			return ret;
> +
> +		return (ret_payload) ? ret_payload[0] : 0;
>   #else
>   		return -EPERM;
>   #endif
> -	} else {
> -		/*
> -		 * Added SIP service call Function Identifier
> -		 * Make sure to stay in x0 register
> -		 */
> -		struct pt_regs regs;
> -
> -		regs.regs[0] = PM_SIP_SVC | api_id;
> -		regs.regs[1] = ((u64)arg1 << 32) | arg0;
> -		regs.regs[2] = ((u64)arg3 << 32) | arg2;
> -
> -		smc_call(&regs);
> -
> -		if (ret_payload) {
> -			ret_payload[0] = (u32)regs.regs[0];
> -			ret_payload[1] = upper_32_bits(regs.regs[0]);
> -			ret_payload[2] = (u32)regs.regs[1];
> -			ret_payload[3] = upper_32_bits(regs.regs[1]);
> -			ret_payload[4] = (u32)regs.regs[2];
> -		}
> -
>   	}
> -	return (ret_payload) ? ret_payload[0] : 0;
> +
> +	return smc_call_handler(api_id, arg0, arg1, arg2, arg3, ret_payload);
>   }
>   
>   static const struct udevice_id zynqmp_firmware_ids[] = {
> -	{ .compatible = "xlnx,zynqmp-firmware" },
> -	{ .compatible = "xlnx,versal-firmware"},
> -	{ .compatible = "xlnx,versal-net-firmware"},
> +	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
> +	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
> +	{ .compatible = "xlnx,versal-net-firmware", .data = (ulong)smc_call_legacy },
>   	{ }
>   };
>   
> @@ -490,6 +496,10 @@ static int zynqmp_firmware_bind(struct udevice *dev)
>   	int ret;
>   	struct udevice *child;
>   
> +	smc_call_handler = (smc_call_handler_t)dev_get_driver_data(dev);
> +	if (!smc_call_handler)
> +		return -EINVAL;
> +
>   	if ((IS_ENABLED(CONFIG_XPL_BUILD) &&
>   	     IS_ENABLED(CONFIG_SPL_POWER_DOMAIN) &&
>   	     IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) ||
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index dc06abc52fce..7ef8a58847f4 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -8,6 +8,8 @@
>   #ifndef _ZYNQMP_FIRMWARE_H_
>   #define _ZYNQMP_FIRMWARE_H_
>   
> +#include <compiler.h>
> +
>   enum pm_api_id {
>   	PM_GET_API_VERSION = 1,
>   	PM_SET_CONFIGURATION = 2,
> @@ -512,4 +514,11 @@ struct zynqmp_ipi_msg {
>   #define PM_REG_PMC_GLOBAL_NODE		0x30000004
>   #define PMC_MULTI_BOOT_MODE_REG_OFFSET	0x4
>   
> +#define __data __section(".data")
> +
> +typedef int (*smc_call_handler_t)(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
> +				  u32 arg3, u32 *ret_payload);
> +
> +extern smc_call_handler_t __data smc_call_handler;
> +
>   #endif /* _ZYNQMP_FIRMWARE_H_ */

Applied.
M
