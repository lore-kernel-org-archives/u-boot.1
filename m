Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1EC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6ACB88908;
	Mon,  5 Aug 2024 16:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CWfD/O9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E1F88908; Mon,  5 Aug 2024 16:13:14 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6FBE88913
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U162mLkiOpt6wE9FJAlKM62yEcMTFfawdbcuqqbtfsovbm8Rv/H2GBp5WIdhQ1DzVtlBRzbfJdGy3kMPAPyVvhMw9aZ+FVQQhMvrbflBbEJfaRk1HnRlSpes7/QqgX43YnKCcZJE2vUzCLVSjBRPuPRjVhfv1WlK8cT3FcJq3oLyVVtyWF8S05GsIdaczaoDVCLqGZIFPDTwyx+CypXTf9Js2XY96wvB0uDTCzoe/5avdmD9zL6YfwhLHmJGKxtG73gbNv1aWKH7yZ7rgfs2XL236jg43d0XMXOrAILWxwp5BT1tBD2q9cossMSpM3UvWoOpTtkDcq8nbmWmrlntcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcmhOZWsZDviu3RMuHdKVAM7iZsTTFOrMjiXRi2nF1o=;
 b=KACCupjHPwxBmHcEjQ+GrFgWCd0o4esL6zMFXb1xEKEKPKcIgmLpMZkfmNHuYA4hSrtGKBoes5np0021bWuFnxKWMS+5rLysDbDA4Kp3fF4stNj/3nEA2GyAyg/waUv38QMBqPorWVkCRxlzFD7wBOw4C9P5aoqkoCDJA28ayYFAB2/eQNA/XOixHc6AfvQJP1C7Jw2Oeebz+MYyE6ZljBp2B3yBDSnBdzuZMnr8WHH2J9ACASis1BIPgZ5ytzuXCrW+vC7ZPZCsTsJjMS75BcAtFfMhXGO4seJQ38KNzu2JJoPya6EQiHW6dCi6/zJyGGhpiIitRABv/N5ksBZ93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcmhOZWsZDviu3RMuHdKVAM7iZsTTFOrMjiXRi2nF1o=;
 b=CWfD/O9W3jsAJcaONp0ifY0eFXQ9Vj41WuokbTzKEhgIwbTRxg6saaP/DvzNPxy/dEG97/xMRoJPYWwh0kwxXJo3YNQxABXI1VSPJ1M4p4HttlYKl1FwKeQjyAACpDlw8DnB5QEiSOZeD6CGar2n0K1BsEMLRu1kMywdTQqOyEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 14:13:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 14:13:09 +0000
Message-ID: <fa7dee62-2561-4184-bf7a-90999a4503ea@amd.com>
Date: Mon, 5 Aug 2024 16:12:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Remove PM firmware checking
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <05b8bbf0686c72f86ea7f8bfe0da250ddba9e211.1722336162.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <05b8bbf0686c72f86ea7f8bfe0da250ddba9e211.1722336162.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0220.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: a295973c-0404-4b59-f0bc-08dcb558bb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2xNcVBNMktPWmVxTmV3dTNPcmhQTTRaWW1NT1I2aGxvWEpLOWJPUHBoVldq?=
 =?utf-8?B?T0xJM1MzMHlZdjY1Mmt4OHFKSDd1ZFY1U3JNWVFHa3l1Yk1MYytJakhreFVF?=
 =?utf-8?B?Y2dCdjRhZkNvc0RMTFpBTkNMeGZ3UEFzS3FJUmp1cVo2VG5RWUh1ckNiZnBL?=
 =?utf-8?B?MDF3OTFQU2g2cmxwVE9najVGbHFxQUJmYlVCekdDRmNpTlJKV1J1QmViZ0xF?=
 =?utf-8?B?aTRDMHJQb1k5N1lXa2NNMmI0a3dJMys3WmR2RkNQeWhRYWs0M21MSVYweVY4?=
 =?utf-8?B?c015UFJJUVIrY1ozOVlVYk04a2VnRFRmN2FRU3ZFSFJWTlF4MlZSN3BJaVl6?=
 =?utf-8?B?VUswdXE3WUlRb1hzSE9INHVPYUppb2h2M1FnWm8waEZESTl0cStaTFp4OVRj?=
 =?utf-8?B?eTJsQTN0bHpWRFI2U2M4SFdRVFdzQS9sL25yR0pVSHlWbVNVMEFnK25xMEFh?=
 =?utf-8?B?dnc3Wis3UHZDbmJyWE9YRjBocDUxWDI3T2c2WHlFcTZLZGk4U1o0bitRanRG?=
 =?utf-8?B?M0VWaTVvc2NEZ0RyN3B2aVErTnZQWldxY1RGRmM3MWM4N1M2UHZPdFB0eHFF?=
 =?utf-8?B?ajZ1aHBwUW01eS9yZjdGRkdldHdCMHRwcCtYSVFTSEl3NlZhU3FQNlZ5OGk1?=
 =?utf-8?B?WjhWZFd0Q3V1WUxYMExKU1o1YVQ3VEExaERJU1I1cmdXMXA1MlhkM0dzbHMz?=
 =?utf-8?B?UllTNGhhM2tocWw1eUZKZlh4Rk5vTmR0Q2xuNWVYeFZoSkYvaThUOEMxL3RH?=
 =?utf-8?B?dVR1M3BEb2xYcHg5NjZXNzlMbGovOG0xMFJRUGIvc29CSDYrcmFPYXc5eklK?=
 =?utf-8?B?aWhzczBjUXhpeWs0Y0tFeCtoT1BUb2hObVVtbTZVekdGOEtyaXBHSlRMR2lN?=
 =?utf-8?B?WHNVajZ3UXc1R2dTTXBjRUI0ZG5nMjBhd3g4bFQxY0pCekVzWjA4bXRZUWYv?=
 =?utf-8?B?dE5wWnJBQ2tzbHk5R1k2Z0dpNlo0TVE4ZjZacTdVeFg2dUZsbUFYdVBYN1R6?=
 =?utf-8?B?L09FbjY0S2kzZHZtY2xlT3lld1NicGZ6Mm1UekppZWYxcEZMZFl4UnJ0QU5H?=
 =?utf-8?B?RUtiYitUKzZrQjExcWUzdG1ldmc3eEVKM3JQMlNleXM2WjV1RDY0OTNYS2Rj?=
 =?utf-8?B?N0JFbXNXREd2OE5JYStaRmYvZXlXQ2FnZk1XRGdGdFdzREk3aXkzelprMkVO?=
 =?utf-8?B?ckFNNFIwOHFlTDNZaDBneGNuWDlZZlcvZWMxK3Vybk1vSG1idS81VU5ZNW83?=
 =?utf-8?B?UVh4ODFxL0hWdEtQbURuS2dTR0t4bWxrS0lHYzVKTlp4TGdyMlJqTmV2bUlK?=
 =?utf-8?B?aEpvekZWTGtWdWdQNFhQMnNUSC9vQ3NLUS9qN3FGRnc2dmo4b2RJY0NWUG1u?=
 =?utf-8?B?NlNudE9RUy9CYWZUNzV4ZVhjWHRnRXpYcU4vLzdBU1lkajhUQysvOWRVMU8v?=
 =?utf-8?B?cWxzbi9rNjJOOW9oT3loSVQ3T0JjQllTRUNJT0NlemVNaVZMMzZSekhsTG9n?=
 =?utf-8?B?U1ZIWmdmOGk4WmpGc1o1ejFSeHg5Z1daa3BnYTRCenNPK2I4UnJ4M3FSeW8w?=
 =?utf-8?B?S0svdVEyRCtCRGN0a0h3N0UrdnF2alRzU2FsWWpnU3ZBZEZsSWwrSWJCZWtT?=
 =?utf-8?B?RHFnMXlhZEd6eWltOXU2TGFDOGN5Ky84bEVIZHp3L2E1aTRORnJaSHk0UVEy?=
 =?utf-8?B?L1dnLzNOTDhKZTBKNE9iVERVZm4rUVpIVDROUStqeWRHbGdlOUxCQzZkbWkv?=
 =?utf-8?B?WGkvNHc2b0thSS9TR0oxK2o4cGtxSDFqbUl4YW1IK2xDd09kUjlNRVpPWnhO?=
 =?utf-8?B?dkpTbkthdm80S0IyRnJGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlFbGU2dHJvYVRiSDdhc2xRR0ZvanVrbEt4clZ6UXZJNzZwTytyMDFnZ0pk?=
 =?utf-8?B?MVB1VjBER3UzUjBkcWVsTldqRHEyZVFyU0dIbXQ3QVhEeitFVUZIRDM4Mk1x?=
 =?utf-8?B?VXR4MnNkRHRDMHMrU2RrSyt5SzhyM3NtcVFVaUhsWDg0enE0ZGhkaWNlR1Qy?=
 =?utf-8?B?Nm4zVjk5QU1KdmxYcVVHZVY0QTlHdURLaStwQVN1ZnlpeGNRYUFabEdaVkpD?=
 =?utf-8?B?VHBHOGVWR2lnNVoveTQ3amxkRmhBa0tDOHoxRjcxT3FZY2tKK2xVeVNjWjFC?=
 =?utf-8?B?RTZKam52RWUxWGZVNG1yQ3VHN1Y3bXptblBtZCsxenlueDMzTFdIdlVnY09R?=
 =?utf-8?B?cSttamtUdS9ZWkMweUkxV2FlMnQ2cXVxU1FhdUdZbTE5aHllRS9IT0I1cVl6?=
 =?utf-8?B?emxCQkJsbmNJNjQ5UjhrWUEwSHpwSDN6elpzZWFtbnRFSlNtU3ZrR09OMXQ2?=
 =?utf-8?B?cDZMdTJZODZTVzZNSHBHdExFMXdPY1BjcXl3d2ZINUliMVgvMTNNdkVyRHMw?=
 =?utf-8?B?emRHL1ppaDAwZnVSczdyNERxcUtUcEJvaXZybVpXL1lQcGZFMjFPV3BONFdF?=
 =?utf-8?B?MjZSTkQ3SFVSMVhUbm4wVmJIUUk4WVJLbUpkcmVqazRWYzc5SW1qdm1Idi9W?=
 =?utf-8?B?WWt6Q1F5Q2h2TzY2c00zYzFleWJtdE85dzhDMGJUdUlXajFBUkdRN1F2aTNP?=
 =?utf-8?B?NFZFQUJBb0ROMzVSNVl2UVp3TWZDZkR0RU5pbXZhMWNvNldXZkFicDRlaFVx?=
 =?utf-8?B?Vk5vT2k3Y1YzcDYxQjNWYko3YXNreDNoZGduWkp6dy9NdTBYSVE4QkM2SmN6?=
 =?utf-8?B?QUx5VVFYY0hQdmh2VGRsN2hrSzA1bWVPZy9QenRXeExlSitBVnQvUTViSk1S?=
 =?utf-8?B?dzEwVUxRK0NteVBmL0NyS0dxOU5PRHQ2NkRPVjZTN20zZ2pXTmdmeWpCa2d2?=
 =?utf-8?B?ejhlQ3FITWNhS3ZFRHVSdmhVT09BQzd2a3NFeHpJcGhjblVTSVI5Ly8vMm5V?=
 =?utf-8?B?SGdUei9yblR6bDliUWdaUjYwNER5Rk9kTXNuYWpEK3laaW55TllQUi9EUlB4?=
 =?utf-8?B?NHlFRlZjWFZYdVR4MlhETmMzUWN2Tk9ORXRRa2RCMHYzbnFPd1Rid2wrcWNT?=
 =?utf-8?B?VmlSUW4vVDZmZWtkWEVkeGxKN3MwRkNtR21JUVc1YTJsWE0zWGR4Yk8yMFdw?=
 =?utf-8?B?UjBwUHB2UDhqc3hhT2lLRlVVUTkvQ3R3Zm1aRVoyWU5qU0d3YjRGc1NOVUFi?=
 =?utf-8?B?TWIxZENQdXhFYVQ4SVE0cVFNWWJlTENsNWVPVktTa25RYzRGMjVUSHNqNEh0?=
 =?utf-8?B?UmJaYzhEdVU2dUFSYzhzRis0NXBwaTA0bFI3d1BIRjViT0hON2VPRTZYeGFJ?=
 =?utf-8?B?aTZQVUlWaVdFVW1RbUpObmYyN2RmT0hsTGZLdWxCUVVGZnpsMUhPc2dIOG1D?=
 =?utf-8?B?ZFluNk9Od0svK3RlR1ZWOWRMSHVKclF5NUd1S1haQlhWeTRNamlWektpdEE0?=
 =?utf-8?B?TEpwSlc2MzM0NmVxZ1JPYUoxQmpuWHU4QTNjVlRETU9lM2NsbzIrZUtJUjM0?=
 =?utf-8?B?T25pc3Jpak5tYXVaV1A0M3o0eGhJZGFVZEt6cDZBUVUvUU4xeDNkbjdaY2VD?=
 =?utf-8?B?STByN0Q2b0hnYkdKY3hEYjgzZWFsQVhPSE9kVi9zUVl2WHU1TVdmemxBb3Zt?=
 =?utf-8?B?Y0h6Si82N2J4ZVJvQ0doRXA3eElVSXNseDNGcEx1YXRnR3dIaGQ3QTczTGtO?=
 =?utf-8?B?U3lIejE2K3RyM0xDNGtIU1pSVDBleWlLQ3NmTHYvKzZKTWxpN1dEWExPeTNn?=
 =?utf-8?B?Nkx6SVpjQ1Z1c1Q1YjNlVTZDcUhyT0FwOW9xZ1JmWndJTkIyM2xzSkEvVVR3?=
 =?utf-8?B?VlhwN05ScTVhK3I3VHNweThOTEVId295TWF3QVZ5QkFTVnp6VkhId0F1bXBp?=
 =?utf-8?B?VllrcTB6ZmRUVU84OXFzRm1OYWNwSGF6L0xlc2RjNUFyeUx4RVUxcHRxQ0dp?=
 =?utf-8?B?TitGRHhjc2RGVVFLV1B6NTJUdWdoWVJ0SW81L291ekVxcTJ0clpLaU9YUGIr?=
 =?utf-8?B?eXJURk9rZmlSM2RwUG56dHI0RjMvbFd4K040SVdrc1ZHaUI3ZlJ2a0lLVCta?=
 =?utf-8?Q?lzOOWzjAOqh5hIH7MG8gYruMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a295973c-0404-4b59-f0bc-08dcb558bb8b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:13:09.0501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GdXNxfKGWLaaJd6JCH3mdXSLceRwTIov5gaZzb2W8iL+TksHOzHCidSjlbJrvmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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



On 7/30/24 12:42, Michal Simek wrote:
> Having zynqmp firmware is actually only one valid configuration. In QEMU
> case for example there is no PMU that's why this checking can't end up in
> panic that's why code remove this code completely.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index b4c15b041ccb..e6331c0e4d81 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -152,20 +152,7 @@ int board_init(void)
>   	if (sizeof(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE) > 1)
>   		zynqmp_pmufw_load_config_object(zynqmp_pm_cfg_obj,
>   						zynqmp_pm_cfg_obj_size);
> -#endif
> -
> -#if defined(CONFIG_ZYNQMP_FIRMWARE)
> -	struct udevice *dev;
>   
> -	uclass_get_device_by_name(UCLASS_FIRMWARE, "power-management", &dev);
> -	if (!dev) {
> -		uclass_get_device_by_name(UCLASS_FIRMWARE, "zynqmp-power", &dev);
> -		if (!dev)
> -			panic("PMU Firmware device not found - Enable it");
> -	}
> -#endif
> -
> -#if defined(CONFIG_SPL_BUILD)
>   	printf("Silicon version:\t%d\n", zynqmp_get_silicon_version());
>   
>   	/* the CSU disables the JTAG interface when secure boot is enabled */

Applied.
M
