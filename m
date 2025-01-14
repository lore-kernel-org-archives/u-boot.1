Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF586E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425418069D;
	Tue, 14 Jan 2025 08:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgyqg6YP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A8C806B7; Tue, 14 Jan 2025 08:58:20 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FDD80657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ5cg6svNXgJ+FG7yF9HvlCEHIeYGcPVA+MOBHmitEP5zCCpeacVy59jF2cHRnwzz2fvyOFHI6hRztkRBUKDW1ZhplFDGNRHEZKIoQVLrM8tGUux6267dP5VrTKrOyCLzZtzRQnEmDRF9Y9MzWpPxlFpjjOxFrC1OOADce8XskzvwjEw2g+VYl3Mp+RhlNT+HS6lW8ZYSF77cHMH8aABEtGUbNSNhRShaBjhjVp8c++vKv76zUM6LUXOl+2pqBklJc6jOfw2slDPt5m9PjZHTP6ccpsLvD89GtHmNeRcg25v/HYfkXlFualfIr7Dm2Wn9Jr6Ufl481iHtYr+EMBj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gT9enEgTPmK9K/T7ljjNzqXgZbfMyr7hn/wJp4MZkQ=;
 b=x1AMYDmv0OpwLYd4szCmMRzTD5++sixvYxZwyAYSuU4xygenQmWzqJHNdl6R1L+KbX6R9jdh8lR7YQnb54uOqsn8HZsTquSUWDCXdXVpHMU/Bdtg+6gRnc0qibDl2yuwrueamsej6Za8pv/oUmvZClwKe2HD0V8Yuip/e6MebEtile4/sk2AbHb7rErzd4o1GSO7XgcKlv7efDUhJxX0/Or2XQ6rJ/XpV8gdNk/OwskeSOOUDKTL6yWSc8ohg4PhC/NWsG50kIoaNy7QpfMsR7SGBEI6MZ2e0AkT2qmQWMjaraqUAG+CNmPXUcCrx81dce8FdtxvxOUStTDAM3MY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gT9enEgTPmK9K/T7ljjNzqXgZbfMyr7hn/wJp4MZkQ=;
 b=sgyqg6YP1w0H+ev8ffygU8lDjfPsbJYXMNbBbzuGCVwh4UGARB+AZRRkTZVB9vuSj+nd6pDrAulR+353dlPZ3z1Wdp9nBtkryy1R+QXeezos3Px9KXePRLgKDay0Y7UHSZNfm4ZkRCdYQZKn4TKZH9QsA2KIYMTiC2hpYoob8vE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 07:58:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:58:15 +0000
Message-ID: <aa491b27-4310-4164-8ea0-f8b738b0321f@amd.com>
Date: Tue, 14 Jan 2025 08:58:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH 2/2] fpga: improve loads usage information
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de
References: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
 <20250108140357.969380-3-ibai.erkiaga-elorza@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250108140357.969380-3-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf74b50-c4b3-4365-d50e-08dd347132f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3FGWlFPUmtLZW9Zam1DQk1uSVpUY3l3TEdEekJGV1ByVE1qdUNHVEx1eW1G?=
 =?utf-8?B?cjNZQk9DZzdDbnlnRVRzY1hod0ZaMFVUTnlCS2k2d2pSNldFSnY0cEpJZWEw?=
 =?utf-8?B?NGRtd2JxWGt6RUs1czhHUmZ6dmhkMHFiK3RFQzh6QzIwb0gzS0F5V1dKTFU0?=
 =?utf-8?B?MWl3bkVGNDVja2p1bFN5QjVaOXlTRGhzU0NCUFNpaUM4M1BOS0VjWVluMmVI?=
 =?utf-8?B?TGhkMzBJOVA1Q0F0QkFrSWE0ZzB3VlRYUkU2Q1VkS1czRTNBYzhDdWtHSEtD?=
 =?utf-8?B?RTc5WmszS0x6N0dHTitNajdoZGpTRHI1dUwyQnAxWllIUXpXbDBwWlphVHJY?=
 =?utf-8?B?OVI4TDN6WUk5MVQ2dmc4OGJmUG80SnN5S0l1YWtRc2NWamdSY0lTaEs0RW1U?=
 =?utf-8?B?WjZHSGN3YTFSTitqUjE2R2VMaTRVVW5lOVU1S3R2bk1NRjRWL3BwMFBwRVQr?=
 =?utf-8?B?T1drTEtkcUxRdVpLaGE0dm9NNnZnWXhYUHpWdlMwRlpaTlhlQm83ZVpFZVRj?=
 =?utf-8?B?c21GbWNVeExBS1gxUmZNazFidmdES2dGdkF5Z0huN1NNUlFkcGhhdThQUTF4?=
 =?utf-8?B?b0JIcng1bFVZOTNzbjRBd1pXK1ZKWEJUM05zb1F0by9zRVVMSjVwajlyZDg2?=
 =?utf-8?B?MW9KVStySGE1bDlnSnNQcTdxVGJzcXJKT0tsYTdHc05YRVFwWkRYaWtlSFU2?=
 =?utf-8?B?bnlGM1ZsYVBVeitsbVNVenBaUHlzWFcwcHBIcUp0WjUyWXdSaHlnRWR0Qysx?=
 =?utf-8?B?Q2RwNndGMTBFSHZ5OTlkbGVoT1B4ZWV6MUZyMFdtTVdGQ2Z2OW1HeXJ4eHFB?=
 =?utf-8?B?ZmtCc3M4UlAyTkRNUHZiMlRFTHdRZERDQ1NrL3pXZWlsZUNqaWdmbmp0YUJQ?=
 =?utf-8?B?bmt0eEdGWG9USGp0endhd2c0ejZTSy9xenVFQ3pJMUdHQStCTHBaZmp1eFY5?=
 =?utf-8?B?VmZKSFREbDN4aXFBeGd1SnFFSVJLdUYxczRKVmtxMTR3VXlVekkzMWpkUmR6?=
 =?utf-8?B?Ymw5QURBcjFZNzVWM0gvMWNyeHBjOHJjZTJFU0hVaE9xQXA0OW1mRjZnL3FT?=
 =?utf-8?B?KzlTQmhWTC8yQ2RXSWZIOStybVM3L3hpbDJFRFdEZnZOTDRwcVFuOHlxNU43?=
 =?utf-8?B?cU5VcE9VdWpDdFFZMExBcGdCbmlzSHJxK0dGL0hiVEMrUVhsamt2N1RmWlEv?=
 =?utf-8?B?aDU4MnlUS3FsMkNRSXhxSThib2VVcWhzUTZ2RW1HTUUxNmdTS043YytZNWl4?=
 =?utf-8?B?MDBIdmtJUHQ2ellEQjJ2czhJaTlCR21QQ3hESklSU0R5eUhnemV5QStmUU9I?=
 =?utf-8?B?MkZlMmcyZDlXWHFFVzM1YkpqMExHaGVmakZMb2RadS9kR2Nld082d1ZNZC9y?=
 =?utf-8?B?QVlvYWY2dFJjNFJIanV0UVNzZUl2ckpvV25CR29vV3B5bEdGQzRpa3dwQVpV?=
 =?utf-8?B?bDI1ditEajY1ZVpNTm9hMnA1MlBGYWlFSURWNVdqUkhXdnlRNDhrMUc1SkRp?=
 =?utf-8?B?TDJxVG9TTThLbVFLS1JLL1c0akRsWDR0TU9VZEtCSWxsWEVnL242TFcyZ01I?=
 =?utf-8?B?ZWFZYXNSOGNQK2ZBT05MaEkvZ1RzRWdXNjZwc1RubXl5eEpFcUlwR01aNmpz?=
 =?utf-8?B?TFZ2WHJVWXhmSERhT3hqNXRnMDRzRjRvb004TUNqOVYzdHNmRXY1TFZZWGFI?=
 =?utf-8?B?bDhnancxekwwOEFPYUUvQnBLTTloVDN2QTNFU1g4OC9QVjJNRTRJM2FaQTZ2?=
 =?utf-8?B?L1ZVUkRVTWphYUtGZzlUV21CTUtMcXZPSFpIRzdSdXQ2bW9sMk9JWVVmWWpl?=
 =?utf-8?B?aGNVdmxoUDBIMEYvQTBUVG9zNlNzWGk3WndXWmFMVWNKb2F6NGg5eE12TEl6?=
 =?utf-8?Q?yR51CwOCqlV8I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJqbjFyalh4VW9PcmxyMDlPM0t4OEVIeUFkTUZzN09uWi91VHkxakN6YXBn?=
 =?utf-8?B?NmdUcnVQa2tUcFFoMjhJTFlmSGNUWWtNblo3blVXMkYwcW1uN0daMURqc1ZT?=
 =?utf-8?B?TzFqeUFqWlVnTTNpZDFwQzBwdHhmeU1OZ1lrUThzQlZpeTVKckR2WXhtMSt1?=
 =?utf-8?B?STFrY3p1ampkZ0d0OUZnWVczOXlDTGhZN1dZQ3AzTTJzOHhtVEVCQUxVWjNN?=
 =?utf-8?B?VjMzWnc0NU9LeFFJK0dIcEdheWVGVm9SYUVIS3Vva2pWYktYb1VQUWI0VTlh?=
 =?utf-8?B?VjFHZXhRRWU0WklTRWhHM3VSUU1qRXVKcGpBSUxIZlpsMUFyTEltMWhSdTF4?=
 =?utf-8?B?c0c2d3BqTWtvTGlodm5mVzdrdCtUYStwWUM5WGNoeklremtEeGw0OWl6eWh3?=
 =?utf-8?B?dXRPMVkyZFFQbnJzRlVnTEM0Mzh2K3hydlMxQkNGZlpkY3BDdHRsdDFiZGpz?=
 =?utf-8?B?SFk4UHYvZU9XQTBLRlQzZGhNQ2pOdXoybDJzemw5UVIydDViTU9FVjZqeTdP?=
 =?utf-8?B?TCtWSzRvWTlQT3NPekRXb1ArREIyNHV3Tk1WbE5hZTZIamVmZUM2YVVhQlgr?=
 =?utf-8?B?bVA4U015eGdRTXdXWjRJZHlEZ0s2b2tidHVXcGl2UDBEVDZNRVFaSFRNMUps?=
 =?utf-8?B?MDFDQU5vZ251SlVSKzcwYzNBT2ZQUGVNVTRxdWxBOXZscUtqVkVnNHd5Y3F1?=
 =?utf-8?B?aUNEbGtpMTNkdGZ0Z2M4ZmczeDdlSnZZVVVySEVNRjk3d1hrVXM4TDF2MmhP?=
 =?utf-8?B?ejJpdTBONGJCRStnaW1uYURkNnc0bzlPVWtrWnpTVkV2cm90Wkd4UmdCMmFo?=
 =?utf-8?B?T2l4U2RTN1NpTGkvdVFNRVJBMWdSTWhwVVNGTlBoQ2h1dmd5TnVHd1dKclVk?=
 =?utf-8?B?cWw2VEQveWRWbDJNZDlNakk2MlRKNElDeVpxR3hielZvYTRYVjZRYWtuRHY4?=
 =?utf-8?B?bnU3cVJnOWx5dllGWWNDeDBrN2dnVGRVeFo5MldBbjREOVFaa3loQ24vQzg1?=
 =?utf-8?B?aThXVjZWOGQ4ZUJIOUYxaFhkRHpPY0RYV0Q3TFJlT0tmaTh4SzNJcFQzVEkw?=
 =?utf-8?B?T3FRU0xZOThVeXdDTjdTOUZSeHlNMTAycFhTQ09YYkZJWVN6bDgxMVBXeGMw?=
 =?utf-8?B?Mk1yemlkTkM2MFEvZU1OTVl1Tk14RHJoR0ZRUDZTRXZ1OGVCd3Z2Y25vc21h?=
 =?utf-8?B?aVZ6ZWR1VmRLSkpMNDdRRnhRZ0hKK0Q1ZlB3ZkJFRG1uZEtlZW9ERzlFek1E?=
 =?utf-8?B?TVFxR3JqdnRhN0lPK0ZZTUVRL1hXSDdoRUVFMmlzaEpKWUNBdnhmRGhWZHpK?=
 =?utf-8?B?OWhmZG5sK2ZkWkl1SDNjWXdocjVlaEZZZGJhcWtWUlZtdENuRFZpMmZwNGNU?=
 =?utf-8?B?cXZiT2paS3d5d0g3bEgrdWtFT1c0NEJNNEFRQnVkWnVGRU92NUhJNFllSzlh?=
 =?utf-8?B?VlB3enBUYXQwVFVlaForcStIOWdJZmcxdkF2N3R4eExtLzlmcFY2MVFsNm1X?=
 =?utf-8?B?YmlCK0lKcjFzeEpxVitPMHdQU0FMaVRRVVNJY0lWWG5WaU5oZXo1OTQzZ1Jp?=
 =?utf-8?B?Rlo5dXVLWGMyZ0JZYTNPMUxYU1JaRHZSZWRsOHNFR3Zmck1xU0ZBdmUyVi9s?=
 =?utf-8?B?OWRQalBDeGFVbFdBWUN4aDFld2JUdlJlRWNRL2hFLzRIaStMQWZnVExxT2ln?=
 =?utf-8?B?bXNPTVFJb2tVVjllZmhRN2c3bHVxYVl1WjlhZ3YxTWxXMUlrTHc4WnF6VWlU?=
 =?utf-8?B?bmFLVjI5ZU14ZldJeHVNaGJGY01ZaW9TeDg1OE9WKzFVRXFKTm16RnFiMHBp?=
 =?utf-8?B?TGxYQjZzY2V2QTBPYVpiTzlURko2UkVLMHpuQ2M1UjBhbHYyZ21lWTFDVmFZ?=
 =?utf-8?B?Sytyd2dRd3FOcUZ2S1Q2RytpMUdHc2hUV2FOOE9neFJEMGZSeUhvWU9EaEdL?=
 =?utf-8?B?ZUhyVTM5RkRUSkNGcTQySkJ1VzZsMmkybEYvMGp6Z0o2WXBLUlkyT01RRTU5?=
 =?utf-8?B?YjBSMCtwbGFueTA1WjFBS1Y0N2pzZTFOcFVPMG1Va1pYZkFzUG42MktOQnlG?=
 =?utf-8?B?Y1k0MUhNNVJCS21JRWtHV0lhQ0N0YnZOZnVzSzJEQXdBUDJxTXpIcmY0SWFM?=
 =?utf-8?Q?RVcvU8fXu8p5PhkQExLKOIQDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf74b50-c4b3-4365-d50e-08dd347132f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:58:14.9527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHxlw9QIffRoS8ONp0O5HLXLgLtVmcI5xebsOLSH/40JQpOaIh9YqyKuSWn9SHT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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



On 1/8/25 15:03, Ibai Erkiaga wrote:
> Current usage information for loads command is too verbose and long for
> a command usage prompt. This flag simplifies the text for readability
> purposes.
> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> ---
> 
> The authentication and encryption flag naming is redundant with the
> description notes included. Use authflag and encflag names for the
> command pattern and use description lines for explanation.
> 
> New output looks like this:
> loads  [dev] [address] [size] [authflag] [encflag] [Userkey address]
>          Load device from memory buffer with secure bistream (authenticated/encrypted/both)(Xilinx only)
>           -authflag: 0 for OCM, 1 for DDR, 2 for no authentication (specifies where to perform authentication)
>           -encflag: 0 for device key, 1 for user key, 2 for no encryption
>           -Userkey address: specifies the address where user key is stored when user key is selected
>          NOTE: the secure bitstream has to be created using Xilinx bootgen tool only.
> 
> ---
>   cmd/fpga.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index cba38662958..cbcbe9c32f1 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -437,17 +437,11 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>   #endif
>   #endif
>   #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
> -	   " loads\t[dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
> -	   "\t[enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
> -	   "\tLoads the secure bistreams(authenticated/encrypted/both\n"
> -	   "\tauthenticated and encrypted) of [size] from [address] (Xilinx only)\n"
> -	   "\t -The auth-OCM/DDR flag specifies to perform authentication\n"
> -	   "\tin OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication.\n"
> -	   "\t -The enc flag specifies which key to be used for decryption\n"
> -	   "\t0-device key, 1-user key, 2-no encryption.\n"
> -	   "\t -The optional Userkey address specifies from which address key\n"
> -	   "\thas to be used for decryption if user key is selected.\n"
> -	   "\tNOTE: the secure bitstream has to be created using Xilinx\n"
> -	   "\tbootgen tool only.\n"
> +	   " loads\t[dev] [address] [size] [authflag] [encflag] [Userkey address]\n"
> +	   "\tLoad device from memory buffer with secure bistream (authenticated/encrypted/both)(Xilinx only)\n"
> +	   "\t -authflag: 0 for OCM, 1 for DDR, 2 for no authentication (specifies where to perform authentication)\n"
> +	   "\t -encflag: 0 for device key, 1 for user key, 2 for no encryption\n"
> +	   "\t -Userkey address: specifies the address where user key is stored when user key is selected\n"
> +	   "\tNOTE: the secure bitstream has to be created using Xilinx bootgen tool only.\n"
>   #endif
>   );

When you are on this one I can't see any reason to state that this is Xilinx 
only. Pretty much CONFIG_CMD_FPGA_LOAD_SECURE should depends on FPGA_XILINX and 
then you don't need to state it in help. The same is for that Kconfig symbol.

CONFIG_CMD_FPGA_LOADFS
CONFIG_CMD_FPGA_LOAD_SECURE
and LOADB should have own symbol too which also depends on FPGA_XILINX.

Then you can remove Xilinx only from help too.

Thanks,
Michal

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4c4ad9d99799..89f0c162145c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1178,8 +1178,8 @@ config CMD_FPGA_LOADBP
           a partial bitstream.

  config CMD_FPGA_LOADFS
-       bool "fpga loadfs - load bitstream from FAT filesystem (Xilinx only)"
-       depends on CMD_FPGA
+       bool "fpga loadfs - load bitstream from FAT filesystem"
+       depends on CMD_FPGA && FPGA_XILINX
         help
           Supports loading an FPGA device from a FAT filesystem.

@@ -1198,7 +1198,7 @@ config CMD_FPGA_LOADP

  config CMD_FPGA_LOAD_SECURE
         bool "fpga loads - loads secure bitstreams"
-       depends on CMD_FPGA
+       depends on CMD_FPGA && FPGA_XILINX
         select FPGA_LOAD_SECURE
         help
           Enables the fpga loads command which is used to load secure

