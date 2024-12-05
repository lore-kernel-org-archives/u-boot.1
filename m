Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A2DE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65AFF894D6;
	Thu,  5 Dec 2024 14:30:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w79HKH2S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C63F89495; Thu,  5 Dec 2024 14:30:00 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75456894E7
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDOTFeymSwolT4QCmQcd1qjFhWgju5lzaFiGFEi7IJNlfzu9J9/LLrjTKL8pwywaIoLghGW7l1TPrY2brhULaHje35kEemlm5I7mu7Sw8TwIvfM0WytyzyrERt2mxLMIkpBY0FuxILi9D8gKDdM3Wwh60N1+6wuB3pP7PpxfcrM8sOuO4cvbneKocqfxMzHLrSQJCptSErgPUTOkH8P/5VLFtfsncOA+sRsFD5hJG5TL9jlqTnpA2rzxAR/Sxj+xMblW4qYx7WDHvt9Qj7zdTmnFriYihfTfrH8harqLCB09V780tsSEa/Gjmisd9FcPuQ1LcYfwvw0D48ERQs7Lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0ZPKUejxK51fV658h2xnGLh8minD6jISGOsd914Izg=;
 b=yJ3WNCCvjPiQmhy1m8cIfYDlZV4Ac42sEI9aw4+pJxaAm6iaAoU7u9whs6gRq59W39aSZiSZavnrphhKeWsnMP/ao1+mBF37u5AdjrA26+hHTbHoX6/Z9x/N/DoBXjBixOMdLwHArfOBcj0yhMkambVPJJ7AElO83JUIF+anl0mU4NqWIzgFZqRM5EHQvA5pXPSuai1oUg34JpRrD9pwfxPWgWZcg2F/At04AtBhQeCJTPuTojL9so0FA/2P368Jn6CP0IIIXGwRgiEiJGSOahguhZJX/NbwEiJiFf2TNnlnv6UNgYPpEIrcyoBbXGhfp/QxtboulL14/SBRToQ7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0ZPKUejxK51fV658h2xnGLh8minD6jISGOsd914Izg=;
 b=w79HKH2SJFOxTdu4o9tY6YRRAV3UBvogrIAe+DgEf0221jPrMogRlOhKd9QWTlNucE0tA9YcYDObXi8bywpyiMOkFotG5kZ5gH/RQolomJe0R+s1qQQ25JvItQNK5MDO3tqJOyokwz5CC1J3ZUfsfPfXBtouNKEq+FS4xmY8aao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 13:29:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 13:29:50 +0000
Message-ID: <6b4f4934-ed39-441e-961c-2e3b63b032f7@amd.com>
Date: Thu, 5 Dec 2024 14:29:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: zynqmp: Update the usb5744 hub node as per
 binding
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20241129110631.672637-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241129110631.672637-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 46471930-e321-46ee-9472-08dd1530e52e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0hFWEtiRG1vMXlabHNoajIyRjBXQTBvQU8wZllWOElKWnBFQmtQTDdVTFRV?=
 =?utf-8?B?UHQydTNYYnpTeWtJNFdDem14MTM5OXkrOUZBbVk5eGdvOUZmb0JFMnE3NGlw?=
 =?utf-8?B?TzVSVTJJWVRvRjVLL1BoeDc4VXdpcUhnbVNDT3ZRZWJySDllWEM3d1NmbS9u?=
 =?utf-8?B?ZzQrNHpBT1pMUHlIYzNmTjBKeTJ6T0lFbFBlMHJyOVVHdVptSXNyK0VtTWt4?=
 =?utf-8?B?SjlSL2MwbU8yWm9xRWlRMmlIYnZ3OWNncWRaT1F1YkZGdDlRekV1TXRHLzF2?=
 =?utf-8?B?RGYrRlM3b2V3MWJiM1h0RDJlckxOYjkzY3I4SmcvTnFrQ0RPQkZlZ2hYVzlU?=
 =?utf-8?B?dy80VWlQbXdHdzBOSFVmOWF2OFRKQ3BEbnlmaldlTERZUFRScHNrdHg0VUpl?=
 =?utf-8?B?cGFocTc0VTVwSXpYT09FL0cyQVZ4QnFpclRnc0pveGlVekdTZittRHNDOGZu?=
 =?utf-8?B?MHo3Ni9mQ2JwY0VNbFQ2ZlVVS1pvc1NuaTRzZ2xBaWcwQjFKd2FwTFJqSTJp?=
 =?utf-8?B?WmRJNWo0bjQyOER4Vy9CYzZlelJIZ3ZtY0I5UVlqRlNBTTlMUVF0cWpJeTJn?=
 =?utf-8?B?U1kzTmZseXhVcVplaWdFbmgvKzlTVDc0UEwrTm5paS9CRXpQWWtaQzhrODBB?=
 =?utf-8?B?V1orMzdYcFhSU2NFSUN6bXBqaGUyWTlMQ0VZZ2J0bmkxc0hoUnBjSllDRW1M?=
 =?utf-8?B?YmMvSW5wUWhKVXY2Nk5lYjRkeFRCMGZkeGpWVWVlVlR3dEhUSWtoU0ZmY21W?=
 =?utf-8?B?TkZ4Z1FFWUtUcTI4UmwxbjkyMmFOQkswcDdsOU9vZ3ExNDB1M3NFS2xzWmpV?=
 =?utf-8?B?RCtvYVFyT1JTT1RpMjcrL25MNGd0aVRBY2ZoKzd6VUVzeU9WcWx3QmdTUjM4?=
 =?utf-8?B?bWxxeGQxZU9LaStuL2ZySXhGV001YzgvMC9WUlJoZjE2a3REUDFpMGF2QVBp?=
 =?utf-8?B?MXk3Q2xvTjR5bWIzQ2pJc3pmNjRSRUxpRWYyd1UrOERZaTNRQk9FQkZqbklR?=
 =?utf-8?B?cVFzdUN6N3V2TWt5MnY5b3dVOEwzWUxmMG5BWGV2SWx6SmtpMXY0YXUrM09r?=
 =?utf-8?B?eVQvT1lMYWZtb01ET3JtVFJCb29XM3JRMW9GTzQ1WExCc0Q2WlhYSzZWcmFJ?=
 =?utf-8?B?ZWNXb1NOMVBNZGxXTTgwUkF6UTFEbHRsbm1pMTlWcCtDY2JDMFdtS1pPM3Bw?=
 =?utf-8?B?bXlCN1RvOVNWSnlaMXc4RmJPWkJhY256Q1hhcGluYm85ejFwVk52Umk4S2FG?=
 =?utf-8?B?NEw0bE5RRkFhaXp0NjBBN3ArdFF3d1NzbGZFZ1FwNjZ6SXBMdkFhT2p6NUJk?=
 =?utf-8?B?Tzd3MzB6VjlPUFVpZndRTjJWa1FJVDhFYWNDL01HVjcvdFQ2SytBM1Z3bEph?=
 =?utf-8?B?QzROeHNvUmU5UXdGK2dxdC9sRW9OYXdranhBeFpZU3ROV09wcGdoc3NZOEQy?=
 =?utf-8?B?Y2ZQTGdzbGpzdEpxVStWZDBGYWpVd2xWeVFINFpYa04xUjd6bHF3R1VNY3N4?=
 =?utf-8?B?VjFUd0Zqa1I0RnJNK3dhU1dwZGxjZWlZM0w3UWo0UUdVQ29iUUplWVJpK2Q5?=
 =?utf-8?B?TURIdkx2K0hRcEVXZy8xamxwZm9LU2NMQTcrOTBpN3NEb1M1M0RSK3lpMFNm?=
 =?utf-8?B?TGU4bzNPTDZUNFNIdkE3eDdpYlJxcUdXc3VlQVFsUmNsTUs1eDd0Sm84MTdu?=
 =?utf-8?B?a25mN2lRbXhRS0oyZTVoT3QzS0lmZUE4d0VOOHhDYk5yM0J1TFAvRFZDN3Z1?=
 =?utf-8?Q?aTxt11lMg9/BmlFLUo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JtNWE1WEpsdEJxOWd2VTNOUlQ0YmZJZVRlQXNielFoclRJVGNFc0o5Um83?=
 =?utf-8?B?M1RMNHo4b2ZCdFZzNXIvYlVuV2tWK08yRWhITFdOTnBqSk84dVNVQ2JkdUVj?=
 =?utf-8?B?QXg3WHRzVW1HOThldHRFZmE0WGFmSEJ0ekN6a2xFQ1dZY0Z0MFF2Q2dmTHBo?=
 =?utf-8?B?dzY2YU9aTE03d2ZwZzRScnBLMUdsWU5vd1NVUktzS0lpMXdUNzNucVdoRFov?=
 =?utf-8?B?WWxvWFlLMHNzRXJodnJDZ2o1TGF3YXd4YlNTRnhRVWYvc3ZheUVhNlBhV0lt?=
 =?utf-8?B?ZFpqTlBDdjBZdkZadzVNb0I3R09nT3ZkVk9NcHBFVTlhTmNGZDVtd2lBNFN6?=
 =?utf-8?B?M1VxejJNUXM5OFBFVFZBSDJObFA3ZzBYdUgzOGdhME5KU2ZXYzNmbEg4NndY?=
 =?utf-8?B?Y3l6ak1oandSVWJJTDBBazRlZzUzM1hXVzZkcFB0dERRNFBuU1ZMREo2MW9F?=
 =?utf-8?B?RkQ0a1ZsZVFWQTRFOExwY2VRemhSaWc0WHpPdCtjdjJmdmRQZjZkZy94b0p3?=
 =?utf-8?B?a2R6cUQvNnBJNFFZMlYvL1pUbSsvZ0tvSGN6VUV1N1Jzdlk4SzhSbmVPNmx0?=
 =?utf-8?B?ekRBTnB6ZEhrWXlJWXBFSUtSTmVOV1plc0lrRFhpL01HajNad2F2Q0xhTlFW?=
 =?utf-8?B?ZjV0Z3FQRWN4c1BmRklZWjBjWlpwcTg1WmdtVGR0bGhHU1ViN0t0bVVpRWFT?=
 =?utf-8?B?T1hhVmN4cHIwYUloQkhTSlRMbDZNcmV4OHArV01HR3V0cm4ybHpOb21KNGtN?=
 =?utf-8?B?dG4vZFByNUNyd1BWY2Joa3A2V0FSVTZsNHBjbFZUdzRkVUw4cXdWODNYc1Az?=
 =?utf-8?B?dTd6MWFmYUVMcTJtSjFXSEg5bG50NUpyVVpoNUREZGFkemttREJEcDFIRUhu?=
 =?utf-8?B?SlVxaEJrUndrOUxDRG1pUFhud1V0dEhsR0M5dUpUdHlmOFF4WTZSL3NVc2Nn?=
 =?utf-8?B?US9Wb0F2bXo0c2xyWTNoZ3FFMjZialVjM3BKWGdsNGVlcW5KcGMrY1VZck1q?=
 =?utf-8?B?dDZYclVTc2E2OXpxNUgzd21rOUx1LzdqWFVybFRPUlBnMFA4cDR2Q3RtVmJO?=
 =?utf-8?B?WXQrZDA2dlRWaVZQWVJwdFlBbnI0aUg4N1NHYTBuRElwS2trdDF3bjVUWEtw?=
 =?utf-8?B?K3h0RTRnWVRPNjJxc0ZUUlJmeU16VHV6SnlUZjFOdUpkamVVUVBxNTlrR0d5?=
 =?utf-8?B?eXhaQnZaRWtCd1RkRS93QWd3N0prUnIrNHZ3QnRQNGlYK20vR1ErcEZYMWlV?=
 =?utf-8?B?cjFwS2NxMHdyR05iYnJDQkpOZmI0SHZSbkZydXlMVmlkVXczRXBndVB5YXhj?=
 =?utf-8?B?eHQrTEJQaXJBVEJIYVlqakpNdzBGYUlZZkVrUEdVZzV2VllNdjZHbmZoakNK?=
 =?utf-8?B?QVNINW04S1R3OVhRS2hFNkc3WEk4VGRvSU8ySE9KYm15ckVLSFFVN2RqQTJF?=
 =?utf-8?B?Y0F5aDBMZzVQSW1lSkpOWFE5ajBKT1FCUHRnS3c5V0JXb3pPS2dKeXc1aDlw?=
 =?utf-8?B?MkVHUVhuN2tncVl6YW95Z1NheGlFNEtjSzNyUm4vcGJ3NHhyTndPRHAvTUtl?=
 =?utf-8?B?VFR6TVBEbnVWZWZMM09xRXZMVVNGVVFUckFsS3NabFc4TWM4UXRUN3ZxQjVl?=
 =?utf-8?B?MjdUOCszN3pBanROZ2hHYUhkWUNxWDhlK2FhcjQwWUNkZzJ3ZnE4V000N2Fr?=
 =?utf-8?B?T29hdnA1U3NlR0h4YmkwTWlnblhWMXNBdjAwNTJkVEZZNk1LbFB6T2xqbG91?=
 =?utf-8?B?dUJvZi9CaFowc3BoR3lNUnh4a0ltWmJZVW1wK0ZkdXErakhBQ3FRMGxlcTcx?=
 =?utf-8?B?Vzd3OXZSamxMeXZHcllONWxvNDBVNmEvbG45ZUdPR1d5Yi9pUzNPOGtBRmFW?=
 =?utf-8?B?YU5YT0ZTZlpvcWZJczV2MDdCQ0Jna082blFSZ0ZOMnhUMU0vam0xQWR3K3BL?=
 =?utf-8?B?QXpudng1OUVkU250dHlNcVV1SWdxS0I3dVJJZGI4RFY1YWR5dGtxV2djVG0w?=
 =?utf-8?B?ZmdxOGN5cnRwVzBDRGwvZEROM3N1Lzd3NUJGT2lxcGlxdllzVDdzV2tFMy9L?=
 =?utf-8?B?U0VDcVRQczVCQUl4RHBtWkNKTTBsQXUydExacWtwcnJzV3RnU1ZRakVFRnJ2?=
 =?utf-8?Q?79uwGMiLjbm7u7HNZ6RxK981X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46471930-e321-46ee-9472-08dd1530e52e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 13:29:50.5131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqY/9kpmbd2lvhvUhoxSENxjusiEZ/FAVMHtkllbaPSAqfGqlkn2PIEzCCK0Kk1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
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



On 11/29/24 12:06, Venkatesh Yadav Abbarapu wrote:
> Updating the usb5744 hub node as per the latest upstream DT binding
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> tree/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml?h=v6.8.8
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Acked-by: Michal Simek <michal.simek@amd.com>
> ---
> Changes in v2:
> - Updated the hub node for KD board.
> - Removed the #if code.
> ---
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 37 +++++++++-----
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 67 ++++++++++++++++++-------
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 68 ++++++++++++++++++--------
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 24 ++++++---
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 33 +++++++++----
>   5 files changed, 162 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index 4de29d5d3f..d56e863ce1 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -80,7 +80,10 @@
>   				  "", "";
>   	};
>   
> -	/* usb5744@2d */
> +	hub: usb-hub@2d { /* u36 */
> +		compatible = "microchip,usb5744";
> +		reg = <0x2d>;
> +	};
>   };
>   
>   /* USB 3.0 */
> @@ -99,18 +102,6 @@
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>   	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -#if 0
> -	usbhub0: usb-hub { /* u36 */
> -		i2c-bus = <&i2c1>;
> -		compatible = "microchip,usb5744";
> -		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	usb2244: usb-sd { /* u41 */
> -		compatible = "microchip,usb2244";
> -		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
> -	};
> -#endif
>   };
>   
>   &dwc3_0 {
> @@ -118,6 +109,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &gem1 { /* mdio mio50/51 */
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 6349a0e108..9d0c0c2885 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -105,11 +105,19 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0>;
> +			hub_1: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		usbhub_i2c1: i2c@1 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <1>;
> +			hub_2: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		/* Bus 2/3 are not connected */
>   	};
> @@ -145,18 +153,6 @@
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>   	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -#if 0
> -	usbhub0: usb-hub { /* u43 */
> -		i2c-bus = <&usbhub_i2c0>;
> -		compatible = "microchip,usb5744";
> -		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	usb2244: usb-sd { /* u38 */
> -		compatible = "microchip,usb2244";
> -		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
> -	};
> -#endif
>   };
>   
>   &dwc3_0 {
> @@ -164,6 +160,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &usb1 { /* mio64 - mio75 */
> @@ -174,13 +190,6 @@
>   	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
>   	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -#if 0
> -	usbhub1: usb-hub { /* u84 */
> -		i2c-bus = <&usbhub_i2c1>;
> -		compatible = "microchip,usb5744";
> -		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> -	};
> -#endif
>   };
>   
>   &dwc3_1 {
> @@ -188,6 +197,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub1_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub1_3_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub1_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub1_2_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &gem0 { /* mdio mio50/51 */
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index b0d737d3ca..0d915d496c 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -117,11 +117,19 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0>;
> +			hub_1: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		usbhub_i2c1: i2c@1 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <1>;
> +			hub_2: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		/* Bus 2/3 are not connected */
>   	};
> @@ -165,18 +173,6 @@
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>   	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -#if 0
> -	usbhub0: usb-hub { /* u43 */
> -		i2c-bus = <&usbhub_i2c0>;
> -		compatible = "microchip,usb5744";
> -		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> -	};
> -
> -	usb2244: usb-sd { /* u38 */
> -		compatible = "microchip,usb2244";
> -		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
> -	};
> -#endif
>   };
>   
>   &dwc3_0 {
> @@ -184,6 +180,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &usb1 { /* mio64 - mio75 */
> @@ -194,14 +210,6 @@
>   	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
>   	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -
> -#if 0
> -	usbhub1: usb-hub { /* u84 */
> -		i2c-bus = <&usbhub_i2c1>;
> -		compatible = "microchip,usb5744";
> -		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> -	};
> -#endif
>   };
>   
>   &dwc3_1 {
> @@ -209,6 +217,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub1_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub1_3_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub1_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub1_2_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &gem0 { /* mdio mio50/51 */
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index 561b546e37..a98a888d13 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -129,12 +129,6 @@
>   	pinctrl-0 = <&pinctrl_usb0_default>;
>   	phy-names = "usb3-phy";
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
> -#if 0
> -	usbhub: usb5744 { /* u43 */
> -		compatible = "microchip,usb5744";
> -		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> -	};
> -#endif
>   };
>   
>   &dwc3_0 {
> @@ -142,6 +136,24 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &sdhci1 { /* on CC with tuned parameters */
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 64683e0ccb..7490efea98 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -92,7 +92,10 @@
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};
> -	/* u43 - 0x2d - USB hub */
> +	hub: usb-hub@2d {
> +		compatible = "microchip,usb5744";
> +		reg = <0x2d>;
> +	};
>   	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
>   };
>   
> @@ -131,14 +134,6 @@
>   	phy-names = "usb3-phy";
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -#if 0
> -	usb5744: usb-hub { /* u43 */
> -		status = "okay";
> -		compatible = "microchip,usb5744";
> -		i2c-bus = <&i2c1>;
> -		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> -	};
> -#endif
>   };
>   
>   &dwc3_0 {
> @@ -146,6 +141,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &sdhci1 { /* on CC with tuned parameters */

This has been applied already.

M

