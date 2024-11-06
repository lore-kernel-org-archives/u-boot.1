Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8336FD29FB8
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 08:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE0288DB1;
	Wed,  6 Nov 2024 09:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsttisRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718A28904C; Wed,  6 Nov 2024 09:04:00 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4292488C4A
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 09:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnaVuQWf7xOIWY2Cued4tG9ep4Y+rHnPTkCcSTMwp+XaZ6k+E1Qa54CMDDnAviToTSGmTmrXAprGoR8GHoot9rES/X7prd8UnDIU0ihA4JO/9YJQNAiYkP2R4otrVjCqoN/UdWUOWVdU6CL/pWVX+XSRYFm8rdpz26JX2LSJYRkveXYATn4HjkMRClI6Ec1Nk9J97/+HOJQ9Ge3C7xCX7yAdgUlaRXjXNxp22BPXB/gHWuF26Lw9kjf17MOafLvdtc7YYgnPw6e661ZYp2N46UhIHVeZ9ALV7jNpYx8S9XwePOu4ns8AObDAwwbkEoV6yTQPfoDvFoeN50SJSqAhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m09OWfUqVTgyvlV7lRCL64gXSi0cd14cvKdNoMCRs5U=;
 b=MM8Z3Mx7yAOZX5GOBuUJJEbZt0yULt8vx9nw+uJfrgV7adXhYcacfk9rgV1LxrkWezmd8tv4LvCPeAmbnlVeOKcW6mpzlKXVBgeXDlcGp+VDWSTbX2HcBTuWG7tIUuJNIROn11dTEEWbwD3Dc6mztJ+AJMs7XqxrSCccR+n0tApVl9WDpdrTbisS/SM5yaaKtj+QxgeZf6sK/gFQECcNlA2TFWjdkFH1b2MkxSoNJMCLYEjeE/zwOeIGag9rAjA0eN05j1xp+S5mT0PSWOZrmJlmLDo2xRGgd5weyeObYCLIEJAy0fdnsbemTbkEnJURx6iDUX74+NpqY5mYd9ewlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m09OWfUqVTgyvlV7lRCL64gXSi0cd14cvKdNoMCRs5U=;
 b=xsttisRNVugn/cSNUfbbras5k5806dgJn/r11ekTK8HlOjbS1YFutDu3E23ytt3YBhirKR5C08g8X4yFmB5cJT6K7HGNJPGz8bJzCbuth74CiRiJTCAdLqLIJe/Fw+lbP/xsm6K1RNZ8WCjWzFiUG0R+pG2nWEPP8ZJFxt0N2x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 08:03:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 08:03:54 +0000
Message-ID: <9e3aab69-bff8-4276-99a9-a2191c34cc01@amd.com>
Date: Wed, 6 Nov 2024 09:03:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Rename SPI_ADVANCE to SPI_STACKED_PARALLEL
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <fe05a0e542d6117c10956e4a104123e46f956793.1730450241.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <fe05a0e542d6117c10956e4a104123e46f956793.1730450241.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: fa85d489-8d61-408d-5b49-08dcfe398ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejBKMHRLWWlNc3FFUW9VZ0FDdzdBQmF0MjNaZHJ3bXlCMlRiNTZVMXR5MjNa?=
 =?utf-8?B?TWRjZmc3bzNuTFY3VmliaTFIUWhnallFSUZnY3J0UGM3TWtqTHRvSmZJZU5J?=
 =?utf-8?B?b2dFN2xaczNRakczbVhPenJHcDgybzhOSFJPL3ZGenBscko1WEc3VjFUU3p2?=
 =?utf-8?B?aUxUa2hpdmZvUkNXMzBUWkJNSmN2MWlWZmZWSm5zeDl1Myt2L3o5T1Fubmph?=
 =?utf-8?B?dGxrcHBjMnFHRDdJcm1uRGtYMFY1RjMrWERZeUxHZVhjdWozT1FobGFPWTV4?=
 =?utf-8?B?akNlQ3lhWk96Uklac3I1LzROeFZJK1FvV3JQeE9PbjhMTHhsaVJNYVNwa2RF?=
 =?utf-8?B?cHFROXVwaGUrT215blMwUlBJUGkxQmNqdXVBNXJybGZjMlMydEZIVEJVRGY2?=
 =?utf-8?B?dFYyYjJNdTNUQ1dNQkoxcVl3a1dpY1RldENhVVVkakIxQWNISDhWTllRQitC?=
 =?utf-8?B?NWtmNU9pbFBXUk10cG9FeWIzL1luMEhubjFlc3BjamVlZC9uUEd5YVdqbk4z?=
 =?utf-8?B?OGdMQXJlT1hDNEFna2RsT0lSeFByTit0bU9rR3hKeDB2L1Q3VmlYZnpWZGd0?=
 =?utf-8?B?aUFMRUMvMnZvWDhYTm9lcTkxMEdjZkM5UVpsRFN2TldEN1RFVEtUUkpzUGdE?=
 =?utf-8?B?ditMRkw5WUhZQ0hJOXFqSmFMQTFCT20xM0dWQVl0dDZwcm1FZ2RyMDlEeXda?=
 =?utf-8?B?S25HL3FKMmt4bGdyb2pkdnNoNk5kMWFJNnhpMkpRV1krK0ttZWp4L1RlZU5Y?=
 =?utf-8?B?ekNBUC9DY2VzMzZRa2NlVDFPay9WaG9lMEw0UHVZNndXQ2RwUU50OUh1eFQ1?=
 =?utf-8?B?cVpLVEN4TGNaeGNiSmxVdk50Z1JhY0kxSFpPeUo0VDBrM1pjV05qSy91OHlT?=
 =?utf-8?B?TlJJWi9ESll1K2xGLytEWFd6MWNRb2trSXp3dTQzeFlQSlM1cW1KRktVaWhP?=
 =?utf-8?B?cVRFVUFyMzZYVjFKRTF5UExia1NHMDNRTEkxcmlvS3o3VjB0eE9sV3Bjc3Rh?=
 =?utf-8?B?U29zZHZRSHZrdWczVFdUZDR4MHcvMDlmOVljTktyWkF2R1RpL3BGUkd5MitQ?=
 =?utf-8?B?Rm9LeklxWS8wdG1EQ3NiYnFuSkJhbUpkT3VmQTkyckFYVjlodUk5N3pjYlEz?=
 =?utf-8?B?TlpoNktxL2Vha2pNeDBDSVVDai9CUFlZRnB5amZNSDRPSDZxYzB0a0t0UlJh?=
 =?utf-8?B?NWtSS2REZW9pUGVJUVdJeENxREJPTjFJV3pTR2NrRGFBd0pTWEFsczg1ZEJt?=
 =?utf-8?B?RmU5bGlvOWE4QVB0Uy8rYURYeXNWZXBRQ0V1WW8xNHRmeVBmSnk5djJjTGw2?=
 =?utf-8?B?UEh3cy9wVlBuenJoTFJJZUFMd3NhK01vWlFlU2gzVzNtZGVZenlPOUdjWXRX?=
 =?utf-8?B?WmJ5QWoyZDJ0M3VZeGZNWlZXY1QvazVqMTZESjMzTFZ3ZWE0NXNoNWJxTFVr?=
 =?utf-8?B?R2RjYm8rTHIyKzdVMWVIYlB0UW4wWlc4S3BYOWpwRk1qQ1l2Z2JlRmd1Sk95?=
 =?utf-8?B?TCtBT3Z5VWpLd01EZUs1c0h4T2NHcWc0TzFMWWdPcFJ2M1JIMTN6ZzZrS1c5?=
 =?utf-8?B?MTRaRnhobzAxLzJUeEFFWGd2NFlRbVQveFRobUhaZm1EWENFMHZqOVZiRkhz?=
 =?utf-8?B?M2t1WGc3VENBblFKVVR4ZjhVVlY4d21obkNHalJSTlVrYmRpYWd2dlRJeHJr?=
 =?utf-8?B?dUxqZDdiQkMxY2RGYlNtZ3N3WU1RSjJBS3Q3UUdyWHlhaXI0cXlHMWtMWDBZ?=
 =?utf-8?Q?mQPsibSrjZq2AWIn4N57XOdSSYgZD2MwEWIvy0G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1lSdXdMWUJEeVArU0hDSnczWWdCN0FJcVBqZU5nMTJZVm5VSzRGbTl3UEty?=
 =?utf-8?B?UE84YUdHVGM5MlZsaVByUGtiKzNzczVKeERHMUVxNUk2aVNVMmljdVRQQTVv?=
 =?utf-8?B?TjRIc2JYRXc2MGREREk3dnN2blQ2S1pWTG84VVhxbjZ2L2dXSHNCb045ZEFU?=
 =?utf-8?B?cTE5UVZUTWZ4WWhPaG1kWTZsOHgrTW1mbHVHNXlOYkkyc1d3Sk9BOTZ5Rmxq?=
 =?utf-8?B?QXdGakZrWmprblB6WGZvZzIxcTBLOTBLb2FkeERVcFIvU2FBcWQvcUFZbWhS?=
 =?utf-8?B?dmJBdmwrYThVcFhER2czVFd2SlpjRUpoSHB0SHJrcWZRd0M0VjcwbCs3ZlVS?=
 =?utf-8?B?cHdKSGZZYW9Jdzd0bFkxL09yYmt1bExVOENEVGxVV0RYb2VpNFNteHRCNUIx?=
 =?utf-8?B?NlVwTklZb3Q4SE1xZzU5NjBtbWxOeFBvRzVQTG1CSytrdVg3a2ZKZ0IxaXo3?=
 =?utf-8?B?eVU3WE4vd3JsWXVmakJpeVQ3dHhUT01mRWxPNlBRY1JCMmxKYURNVkZoNDVn?=
 =?utf-8?B?cnp6V0RDRXJORm8xZjRhazI5enhyY1pBUkkzV2tHWjlGN3Vrak5wN3d5NS9s?=
 =?utf-8?B?K0s0UXlMMHRNakw2QUpScGJ3dHRZaXBXdUhrenFUekdnMDFCTGp1VHpjSXdQ?=
 =?utf-8?B?Z0xhY3FZWTVTYzdINEhSbHh0QmVNOGZGdlpoN3VqbERpM2dPdUV2cE9WMUZs?=
 =?utf-8?B?Wll2ZEZaVnJWSHkwUGhRU0JManR1MEVhcWFad0hBS1p6UHp5VTlCam9wK1Zo?=
 =?utf-8?B?OTFBT3lEQkoxcDhVTnZPVXFCcFdNME9LRVNlTDE4SFl0UzJUbUVEZnVZQm16?=
 =?utf-8?B?VW8rTnFpZ0ZRWmdEUUxwSWU2Q09pQ2NOL2xJbmlwYnFMOTc1aUtBdjNGR0Jw?=
 =?utf-8?B?RVVzNnFsWkw4eGNLakN0VG5iTzFKODFlNWt5MmNzMGpWeW5ZRS94dUVUV0Y4?=
 =?utf-8?B?QjhjWHZ6ZzlNSjRYVGsyMzFCNUY2azA2UjQ3bDVkeFZDVHN1alN2MEorSW9Y?=
 =?utf-8?B?bWZQa04wQmpaVnkyQkV4dkl1WWhGVHVkdnRHS0NxYkQzVVRzcEJUQmUxMHFL?=
 =?utf-8?B?WGNBVTdPcyt6KzVMTHpDeTloUkQ4OFdiSVlRdVpsOU4zSmk3QVdOcHFkNVFU?=
 =?utf-8?B?emZEVnM1QXpQRkJyZjdRWnhzWmJURlpUYjIxZGhSUUsvNkZBZGdkZEFIL3hB?=
 =?utf-8?B?M1R6ejRrL3VHNDE4ajc0d0c0a0pMQzh2K2VPbllHb1FqSnh1Unh3QXA1V2lL?=
 =?utf-8?B?Z2MwMFhpUVpRZUxzaFowaDNaeGNhYkxkSk5neXRwUWtXUTZZZXVMbTBOVS9G?=
 =?utf-8?B?MCtuTm9WTWU0SGxYNGFKdHBiQjRkNHdINmZZcTNvVHFYQlJuODlrTkt5aSs4?=
 =?utf-8?B?bVJldUdUUlFjU0RrK2d1amgvbDczc1BTcVR3QWhhT3NHU0lIc083ZGMwbmE4?=
 =?utf-8?B?VnlmOFZjbVU3WlluZ0tCMVBVQ0F1V3ZFdnhsVlNJbUNFT3YvMHR5N2duTGJ5?=
 =?utf-8?B?dkpHeFMxREZQL3ppdk9ZazFJa1BlT1BRdndSSG5nRk1iQ3FPbUdic0dQUmVq?=
 =?utf-8?B?RVJ4UGJOdTdIcmFDclUyU1RXQmhNSFFhQXU2U0lDaXAyU0pGS2RNM3k2anN6?=
 =?utf-8?B?ajQ5emVWMmlvc3IwSlBCU0RpUWhhelVmWXdvRm5jNTFzTjd1eWliU2dUaFlC?=
 =?utf-8?B?bHhhY1ZMVkxHVzVPOHRCS0xMR0p0SWtMdHNWQS92QnlERnh2NlQ3OURDVlMz?=
 =?utf-8?B?ZVVtSkUzckFsUnFpZjRmUGcwTGRuK0lVdENJdTVRZWlPKzhxcGxtaTczMVd6?=
 =?utf-8?B?Si9GdDRxMFhnS28wQjZLOElBbWJ1MEZHM2pHSWU2ejRxdU9QSWphVjBaOGNU?=
 =?utf-8?B?WFk2U1RxZ1NFakFTcndkeUFDZTZqRzUzWHJWRzkyenhIQkJUV1lGRmQ2STFa?=
 =?utf-8?B?T3c3SzI4cUZFK0pBblVWRkpqRisvRlY5OVNhbWZxUTU3Q1dHeU9vUzFReGdM?=
 =?utf-8?B?YkhORElHMnVZT0tOR0xuYk05RUNnRU95QitrQmJRZ2cxNGVNckZqUlgzd1Nw?=
 =?utf-8?B?STNiazNYdlhLVFE3TEZndXVpMWp5TnlvSFR2VEJPd3FGa1JvN205dGR3VWtn?=
 =?utf-8?Q?hyM81u7S6wkkzw0noywytWE9q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa85d489-8d61-408d-5b49-08dcfe398ed6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 08:03:54.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlpKDm9iUdGxx1uV3kO84ugQAuez8kqFRLh3epziQH9gyqJKHKAV2+uyB8RuDQGF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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



On 11/1/24 09:37, Michal Simek wrote:
> Align defconfigs with the latest Kconfig layout.
> 
> Fixes: f896aa656774 ("mtd: spi-nor: Rename SPI_ADVANCE to SPI_STACKED_PARALLEL")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_versal_net_virt_defconfig | 2 +-
>   configs/xilinx_versal_virt_defconfig     | 2 +-
>   configs/xilinx_zynq_virt_defconfig       | 2 +-
>   configs/xilinx_zynqmp_virt_defconfig     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 476c3aa8a6b5..30d79ab8c8c0 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -128,12 +128,12 @@ CONFIG_XILINX_UARTLITE=y
>   CONFIG_SOC_DEVICE=y
>   CONFIG_SOC_XILINX_VERSAL_NET=y
>   CONFIG_SPI=y
> -CONFIG_SPI_ADVANCE=y
>   CONFIG_DM_SPI=y
>   CONFIG_CADENCE_QSPI=y
>   CONFIG_CADENCE_OSPI_VERSAL=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_TPM2_TIS_SPI=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index ede729b4dd50..671dd160617b 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -129,7 +129,6 @@ CONFIG_PL01X_SERIAL=y
>   CONFIG_XILINX_UARTLITE=y
>   CONFIG_SOC_XILINX_VERSAL=y
>   CONFIG_SPI=y
> -CONFIG_SPI_ADVANCE=y
>   CONFIG_DM_SPI=y
>   CONFIG_CADENCE_QSPI=y
>   CONFIG_HAS_CQSPI_REF_CLK=y
> @@ -137,6 +136,7 @@ CONFIG_CQSPI_REF_CLK=200000000
>   CONFIG_CADENCE_OSPI_VERSAL=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_TPM2_TIS_SPI=y
>   CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index 19ef894242ff..ed3d10194857 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -144,9 +144,9 @@ CONFIG_ZYNQ_GEM=y
>   CONFIG_POWER_DOMAIN=y
>   CONFIG_ARM_DCC=y
>   CONFIG_ZYNQ_SERIAL=y
> -CONFIG_SPI_ADVANCE=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQ_QSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_ULPI_VIEWPORT=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index d94b298e94bd..310efdf2338a 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -208,9 +208,9 @@ CONFIG_XILINX_UARTLITE=y
>   CONFIG_ZYNQ_SERIAL=y
>   CONFIG_SOC_XILINX_ZYNQMP=y
>   CONFIG_SPI=y
> -CONFIG_SPI_ADVANCE=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_SYSRESET=y
>   CONFIG_SYSRESET_CMD_POWEROFF=y
>   CONFIG_SYSRESET_PSCI=y

Applied.
M
