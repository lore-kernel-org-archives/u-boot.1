Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA9EC0218C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5658380763;
	Tue, 21 Jan 2025 14:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s1omm1D6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C5E80326; Tue, 21 Jan 2025 14:48:12 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67829801CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbQaLwSzoJMtcd2kQQMR/E+g7zE/TDua3knpiNbLdClJ30/nadXR0035/8VSZ/ijMYushy4swCSBZgLK9nLvUUdXGLK7EaIks0CacmpLDgzop27FE8E/AcgmZcK3ft0tFcT9xh8/DAw1YLGdBD5oNhzBB/CSPWyaXXRbxQpbgXzJd6qKfK/UQvLB4DnmJb7QBGTOX+ZbiDje0ZyVsiU9aEp+NCVPSuVpwIOO5pI8Wq43uGg/+t+5f7Khk2ADhfd6I52kJt1gyzZyrb1X3eOyyHZGJYfc/OhdUkFzCC1PVsNQ1pZljxByvlKVxn02RkpNB0E5wJwkDjthgn65A7olKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQOMeqSdeg0zuNihijPiRwHCOfE5O0sppXkQ/icLjxA=;
 b=yWWovuDO/u0lw9iJ3HCVWPwBQhXgbcjMywFIdsr65rG/GAS6C4eDr+tAdLpVMhRLPJ3eCXCneQS0L99SFBwTTGMPKPVB92WXy/I1rVO0fwdpvQbdqViDcvrfN5esEY2bMeHGPdd4ix2zmKA+3kfWqGRARTrfeBHhz99dQb4KglMFaMvXGz4nlUij/hiPqw0O6VV/M2Pom8kjNF+GCJbSw6rFv7vdHVQzbcMy2YTT319FetVYSbaKRfMPWZC25pKq4FDBdq2EgCn3Ezroo4WAVP9/pqcx8dfCwkQaWVFR6weyoO90uWqKwcdgbkv5b0O8H4AUtwJqQtWKUVtXLdRQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQOMeqSdeg0zuNihijPiRwHCOfE5O0sppXkQ/icLjxA=;
 b=s1omm1D6oTwy1jlZMfMoZPxNXfNg72Io9REtHeBp8fZjiWds3yFDrlZnqfFtHYXW0slhohP0gfTAeUy9MyTmuWDDuC0kEuagIuIkGJLEx6kwH4XE9ZKPhxLBQLGihlaQBTUrGAANmHJLy7EdUTphYFeyy16uT0lRJ1xvdK9fU1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:48:06 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:48:05 +0000
Message-ID: <12ec02f7-7160-45f7-8ce3-b4c99ebf9e41@amd.com>
Date: Tue, 21 Jan 2025 14:47:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable support for Infineon Octal flashes
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
References: <20250116051857.346921-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250116051857.346921-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0156.eurprd07.prod.outlook.com
 (2603:10a6:802:16::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 24599572-1b0d-4091-fc80-08dd3a223b4a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1dveTVCejBLRk16bW1OTHMzcU9NZ3lld1JqOUlyOW1ZelB0SUlScmF1QWh1?=
 =?utf-8?B?MVVLN1lEVjU1K20xNVZNV1ZZSEtTVi9oNUtXaE9EQlVFTEpydUtFZEtlQTFk?=
 =?utf-8?B?aFVHWEpzZGlrMXg2VXpQQlh2ZDNaY2cwVlNMUnRQbHZLNkhIRTA4UHoxV3cz?=
 =?utf-8?B?cGhJT3J6c3k5ckRBWG5KdFU5bGVBWm5icmZYVEtYRTRJS0N2b1hiTzZvME9R?=
 =?utf-8?B?WUFzMFZlRGJhQVRUYjVuNmx6QVhydExtTkZTNkN5RDJKbmRFTXVXUlJHZkha?=
 =?utf-8?B?ZFlsNGRCR05VeXpDMWZvVU94TlZiSHkvdURacXcyYWxvWGh1ZnMxeHAxZHZZ?=
 =?utf-8?B?VVFSVitLcXhpdTlTUHUxYXBHNkhNMjdYUFBObmpSMTlvT2pzUUMyUXVXa2dN?=
 =?utf-8?B?Si9Ic0VsYVcvOXRsVWdaNlZPdlJhQVFkRjZxVFM0eEo5dUpuSkVpV2FnQTZE?=
 =?utf-8?B?emo0RGo1UWpBRHpDTmVJbFhCN3NuRFJ6SkNjMHN4WVE3MkhjNHVlUmVMQVo3?=
 =?utf-8?B?clRGRk04bkkzVGR3VnA4OVA0YUVMclVhOUhnVnoxZ1JWdklOdTZybkhaQStZ?=
 =?utf-8?B?MmhHcS9TZ1lzMzNIU1FXK2RSTkYwQVV3S2RkVlYvWUdsUnBnOU5ubVMyRWFQ?=
 =?utf-8?B?ZWVGRzJlWkJ0YThDM2lHZTNURjhEMEFNdnRLR0FPaGd0TmVuczFxZktqdTJF?=
 =?utf-8?B?bk9pbldKK1NXWFNDK1NsdVgrWjZGMDhuL1lTWnRXYURVamI1L0pwNmVPbjRw?=
 =?utf-8?B?bW9lRUl3ZWlVZXR2dlZTNkk2a1o1dC94SDFkOE9GYlVadGRvOURDa3N6UXdm?=
 =?utf-8?B?Qkt3SDVsYWFybUxDVDJRVTZFSjQ4elZ1SWFGTzNNQTF2Uzdzc3RQRWpENGZu?=
 =?utf-8?B?Ymp5RlEwSEMyTUVOMWpCZGQ1U2tXS3QxcTRLV2xJMnF1djFWTEdnaCtPaVdG?=
 =?utf-8?B?Q29PN2V1aWJvUFd0RmpLRFdOTXMwZzgyV1gxK3hNUFRqNWg4SThsNXZVbDAx?=
 =?utf-8?B?YTFrZHluYmF6WjRFVkxsQWxGZ2UyclNxZ3U5Z3BtNGFwMytBcEVpMXNsOENX?=
 =?utf-8?B?Y1JUVnQ0WGpySjdGMHkyU05IdmMweStOL0J1ZjFKYUVnY2tITnBGTUVHL3ZK?=
 =?utf-8?B?NXByTWNtT1d5R0E2SCtvL21CVGRBTjEwd3A4emxFanhJcnRyTE1jbFBkdmx4?=
 =?utf-8?B?SWUwZDRWNFl3RC9OQjVDNTBoRWJ4TmRSdk40MUV1eG5Qd3dZZVdaVkZiVytu?=
 =?utf-8?B?a1hKQStUbUZyVUFneDR6M2lnYkxkZnZ3UEdHVHdlN05URk50NCtvdWpUazNZ?=
 =?utf-8?B?SFd6RnBwL2R5dnNUbUw2RitoVCtuWUxPNGYveTUxWUMyc1hQSlRrdlo2RjBo?=
 =?utf-8?B?RXk0Ky96TXAwRUJ6Ty9ySXhOMjh0K1ZCMk1rQUpQZzZzelpjNksycllIWmww?=
 =?utf-8?B?bGU4QkFzMURUNWZjZ2U0VWhoUjdaSTJaeW9iTzRWTlB4TWh2UTVRMzZGR08v?=
 =?utf-8?B?bEhpTmxVVElheHZ6UnFHSS9HakJwdzdENjMyU3hPOHkrSzNkVnE0dEZFTnNr?=
 =?utf-8?B?ckZXVzB1WmZwbFZ1bncwUDhneS9hMG5pcENnbWhWalk0MURoTFYzekJnM0Nj?=
 =?utf-8?B?dGlsbGRDV0YzMk5iYVVEMHZORmNSQ2VXVGdoWDdobGNEb00zYXlaaGNiV2lq?=
 =?utf-8?B?U0gvbHBhcnZtS0xudWFFc0NvUk03ekVnYk5SUmNhZ2FDTjhLMDRWd21obSt6?=
 =?utf-8?B?WFp6VG9VQUtUN1M0Q29XOWRtQ2doeGlLVnNRSXJWaXFUZjJYVTZjblM1eThD?=
 =?utf-8?B?VnIvNHNML3lVWkE2Wkc4ZzUxZVZ4dUtnWU5RTWQwcVVrOUp5Smw0empjb2hV?=
 =?utf-8?Q?jVims/CAZ21LG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUo4K0QzbVNFV3BsZFFIeGI3R0pjUzRGdEdKb0drUnhzQVhlSWdhMzRPVjJ0?=
 =?utf-8?B?dHZBb2dPYVZEeFhNUnFZZzgyWTEzbWgwa1JZRWlvWVdYZHlEVFl1QVExMENz?=
 =?utf-8?B?Mll3dzhvQkxrcEVBU1MvZ0pUUU5mRmNDSDU5SUNJTnY1VDhHMWhnOUpEMm0z?=
 =?utf-8?B?cElOOWYvZE9VdUt3UHlWSm9NYm4wTldZKzVvK1VETnhzUHhTR0dYcXE2bklu?=
 =?utf-8?B?aUdxb25xdSt6UkFuQ1EycC9jRFoyY011MVdKQnVUQUNwK1YwVHdIdCtMVFdu?=
 =?utf-8?B?R1Uyc21UVXpETnRDa2FjeFYwWitoOHBVcHFtSndQbjVzVmcrdlZkcTVablI3?=
 =?utf-8?B?UjgzaitTYWxLbGNBVWNmdHdyMGJEVC9DclplK3BjUm04eHlYdHRJeTRKZ2Ft?=
 =?utf-8?B?bFhzaVJFRjVFZzl5WGZPQjU4ZGl4RzR6eW9CQzFIelowbkRna0RpODRlaTlU?=
 =?utf-8?B?REtzd2UvSVI4by9EWWc4L0t6ano3NUdud2FwMldBeWtGakZSRlFIU2RBOERz?=
 =?utf-8?B?dGFTU0xscTdscXdlU21rWUNTUXJsaWZjRDgvalZoOVVOVWRKakdERWIxd05n?=
 =?utf-8?B?MFRtZlVTUjliVzl5Sm52bGhGTUxZS0ZGaG9vMmhTRUd6SVlscUk5eWNWTyto?=
 =?utf-8?B?RVlyVzNqYVVwV1BGemZyUTJVV2gwcTdJQlU4enJqL2tQaHhKV3VpajdUemw3?=
 =?utf-8?B?ei94OUJRMThuV3B4STdzL3ZwMWo5N1lPNkdDTEFMTDFmNHp3Sk9zRk5pTFps?=
 =?utf-8?B?Z1prK1hTOVFoMW1BdzBZT1FCRXcrVTdnSGhCa1JWVElyUytqRGhZNTM2K3A2?=
 =?utf-8?B?WFVROFAzU2g0ai9yVGZ1MVEwY3hHYUFlTTdWMVQvdTZkMjV1a1BXNURCdkcr?=
 =?utf-8?B?RFF6L01zTjVnRWFXZGNsSXN0ZUd1Wi9jVVJVbjZnRVUyQWVVTGgwejhXUXIx?=
 =?utf-8?B?QVNlb1VGbG00N0FpdDNRbGljc2VxVkxzcXVFNzhSVHlCNDJmQk8zeTJTZFZS?=
 =?utf-8?B?eEx1elBndEVEWnVWYUtXeVhCMGpTaDlsd2h3V3FPbnA3NmNBbWowQnI5c3Js?=
 =?utf-8?B?OEVSOWhWOUtpR2lnb3N0V3laTWlpU3pTTkpDOStaT09vc1M2V1FTRVlXZjhI?=
 =?utf-8?B?TDNBdHJVRkNFYjZFTTVYRit4Z1d4U1ZaNTNNTld4dmpCTVBuZnZLQnp2V21s?=
 =?utf-8?B?TXgvNjVwRS9WQWRFcjZhR0R1VTN5dTBaaFBOT2gxS0pLaXN0RXhId2U2cEF5?=
 =?utf-8?B?RDYyS0M5clo3MW44MVc0TXNJd3U1bW1FNThPRTRCR3Z1dGxQNWdrYmJYa2dR?=
 =?utf-8?B?WU9aMk1DdzJpVm9oYis4TVRPQncvbTB0OTkyRlpHRkpROGZWNkZ2MmdYMG1N?=
 =?utf-8?B?WlVoR1lnR0dZZTBCQWcvRG1lWURCNGlIUTlackNBeHprUVcvS1BkdGY1Z1N3?=
 =?utf-8?B?RUQrN3p3MHUvQUdkWWVEOXZyVm13cDA4dGJWSFdZT2VTbEVxU0VWM3lKVnpP?=
 =?utf-8?B?UFpYUW1vMXliWld6Yk5GMzB5ZVVqMVh5Q2hGbDgwY3VtVi9MUVkybUpGNW9u?=
 =?utf-8?B?dFFaWEFNODljVDh2dkV0SU43b2JVRWhCTWRUTThrTmhmWFFyNml3cWw3MDBv?=
 =?utf-8?B?WmJOWUJjenIySlJyN2NwbjNuZXd2WUdKVXpnVVlhVmV3UTc3TWh4clFuZFBW?=
 =?utf-8?B?dFVPcUFxbWJJYTZBRHJtYUo4bW53UEhybElBdS9zZ1FDdGRFbVhsbFpneTFJ?=
 =?utf-8?B?MkdDa204K0NBdlkzZ1FBWXFPaERRNjlac0wweUhvWVJpM3BBZGxFMlg3MUVM?=
 =?utf-8?B?QjNZRXMvSFM4M2p6WVZMSFYyTnpON1BieS9hTDl4Vnlkb2svQ3ZHVTdlU29v?=
 =?utf-8?B?UTJjdHJZUjVTZkw5UnIyMi8vNG5XaUpYQk9TZEJLbjFJTkFFV3lmdVVSWWt3?=
 =?utf-8?B?Kzl6MGFDK3NWbkxDRTNjRm1rVHYrdUtya3hBZDIwZjh3andpYm12eDFjZzBP?=
 =?utf-8?B?Ly9OQ0xXZ0lWdEh5Y09mWlB1UFhib0IrQkUrVDc0dHMrQ1dkL1Y4UFBER3lE?=
 =?utf-8?B?WVRJazd0VWp4K0FBaDJjVU5UQWpvREpoU3RrbDRaTUdHd2d4V2xHQXprUE9q?=
 =?utf-8?Q?M6mFraBsUN0qBh1kS1nvd8JsT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24599572-1b0d-4091-fc80-08dd3a223b4a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:48:05.7159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBxLJSW1GxUoplux2PZzimGBw1nXchnD59ay2E/cUbaWaVVMXgCNevFGn4qV5wAG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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



On 1/16/25 06:18, Venkatesh Yadav Abbarapu wrote:
> Added support for Infineon Octal flash components on the
> Versal and Versal Net platforms.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 30d79ab8c8c..b40f7b7f855 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -102,6 +102,7 @@ CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_ISSI=y
>   CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_MT35XU=y
>   CONFIG_SPI_FLASH_SST=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index fb757c1067d..ccbd33ee1cf 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -112,6 +112,7 @@ CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_ISSI=y
>   CONFIG_SPI_FLASH_MACRONIX=y
>   CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   CONFIG_SPI_FLASH_MT35XU=y
>   CONFIG_SPI_FLASH_SST=y

Applied.
M
