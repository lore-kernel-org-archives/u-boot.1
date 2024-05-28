Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD33C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C30988431;
	Tue, 28 May 2024 16:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgOdIWrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EFC884F1; Tue, 28 May 2024 16:54:00 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982C5883B6
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeJY0Q7kej7Xb53SLKYK8/SUJ584gbPXzXZe6tAlFPdouCXk9NSAUk2ie1Y1NR5ygoKqSTEEGB6wghkUZbteR/kXlAnC9z1ll9YHIzhDLtox/Eyr0qc7R2NhVqwOx1RcUxtpO4YxNso7jKpkv7G8dsR0Jd+0FZV+53OWavRxhTFE/HRscgWovGvy0XSMnDeypjr58/+iJ+vpTtMPuyDeYjQfcQw1lvpNov7HO6KF5AwiEYFeaTBJIOvJdC/hMemEOXa4EcSIxayrB+Wy9nUrQ7/llxqLlT8/pIfUAcuJSB+eKAKK7LuHcU4nBw0ZccmFha9elVLt/giywqGwOOtAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD2uq9GVvK7wcuZjl+CQK0cbcEzezz/AkM4bhuG74mY=;
 b=G8jU+6rhAmYVSVvhb8CzbaT1nSF7q5wkYnLIrQ54VHbILXa9ijBz29GuvQKNQuCqYznzr0Au/UGfHKsiISCuvf9lhhF7qdJcGPT5izLJt5EEhlnGfquks0muwwttPWwdlQL2IZeysXEpbs1Z7VQzVeGGbzxP5qR+yAQGK/t6GDIj43PwAC+UcfEoyg0ZT13jZkqrva+EaSZMdUR1mC+D0QxcsRxbviLSf5b/slph3fWnXYkh7wkQnG6A3KqvMl59cT60e72ReNJSJKU84s1XZMutuvuYhniYDhUT2pLzsZsVHph65LM66Pxz4/VxToqDDpgmN/F3qgrNrseKJKG/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD2uq9GVvK7wcuZjl+CQK0cbcEzezz/AkM4bhuG74mY=;
 b=HgOdIWrEaW1CmEjZ91Rfl7vGgjfe7B8ebuEqBAEHwlNotbSw9pGakYSD711Tb4jr3hUOZN4sltAZUyV25V+DwUKUCXzijvU6kOBYmYDk0IfrZYsEk5I7BIHOf2DRGCKOtDUEyqrjNq1h5xwkpuJB2spEgi1dYWamYVHjBlZXnbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 14:53:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 14:53:55 +0000
Message-ID: <a7b20716-669f-4e52-88e6-426f5304c5bb@amd.com>
Date: Tue, 28 May 2024 16:53:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Allow multiboot environment write even in
 saved environment
To: Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.denx.de
Cc: thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240528143652.64489-1-kory.maincent@bootlin.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240528143652.64489-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0206.eurprd08.prod.outlook.com
 (2603:10a6:802:15::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c87287b-eb1e-4f48-cc7e-08dc7f25ff3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDB0T0lVQWsrZmVXZWxpNjRBMGFEMWFaSHN2cjVnUVpoVUFVTldHVUhSeGFm?=
 =?utf-8?B?Wk1LNjB6VEkrVFBtUTVURUkvQzdKS24zOXZJbjNnTDdRNEhieTQzckh5ZHJh?=
 =?utf-8?B?YjBzYXl0Zy83K01kd0EvYTcwRkVsTGk2MGhWTXNSZ2k4czJ1YVNoV0Z2TjJO?=
 =?utf-8?B?eWtRNWs3MDRzOEJraG1nUWFuTkR2NlRSaGxobzVnYlBUMm9FYnI5N0lPWDZt?=
 =?utf-8?B?ZFMreGJkT2F1cVVaa0RyMGgwNFk1T2pzMzBVRG50V29uNUZoY2NuaklpOUlh?=
 =?utf-8?B?d3dvN01HTFZWN3JnejFhVU14bzE1b05qdGp4VXVoZ2E0cjdSMVlRNnRrNHVC?=
 =?utf-8?B?Y1lpQzBBWnJvN0w0a3Bpa1FXWlNvS2VCcjllaCtBQUJMV3h1VFcvMTExekFI?=
 =?utf-8?B?QnkwZmtPQ2MyTFRENHZUNEZVTklpdE5kWGNuekhkRStScGJBUXlPNGI2WnZK?=
 =?utf-8?B?cE5ZRWxoTzRnS0txNk8rUUcwVVZ4bzd5bG1kNEFtTEg0Ukx4cHZ6QUhraXBU?=
 =?utf-8?B?RlRaOTJsMlJxWHBWakcxd3FZWUM0U1pWb0FuNDNaNTVzdDJFOUNzWW5TTFZr?=
 =?utf-8?B?NElWSkFmdVdOVmM3SkdNUlNWS2ZhN2VRdmx4RnNEQmhGWkdNcGtqYm9UOEVR?=
 =?utf-8?B?K2Y5SGo1TUJFK3ltZW5ubnUxK2dZYlhaOWtUV1ltQ25TVEUzMmVuN29pTFhs?=
 =?utf-8?B?WEg4SnBSTHlTakwySEtzaXBxZi8xSXZxUGhiK3B5NlowZ1NrN2pKNWRFanNW?=
 =?utf-8?B?RGRlTHgvUXJPK3JnUUpyd3drT1g4MmozTHBGQ1lONS9DUHVyUENEUG5IZ0RK?=
 =?utf-8?B?NTZweU5VblJrRGVhNUxzSk95cklidkxIWUtFOEg2UHliVHNOSytBak82NFNY?=
 =?utf-8?B?UEw5VzlKM2pvVWdIWG5JTThFdmFnS2J1aHRRcmVaSy9Uc3YvVUhyTEloMEh1?=
 =?utf-8?B?UEJVS1lrSW9uU3VJU2toYXFYc2xsdjUrd2FhU01xdWdLVHA3WnNzckNVRXdi?=
 =?utf-8?B?VGx5TnE5WTkxUkh2NzJRYU9pUk1ROUhSN2R3VU1aYlBpTG1VVG9kVnBXMWlu?=
 =?utf-8?B?NjE5QmRrYUdBam1NbWhVaWx3WjErRFNLUlA1aUl1dTFzSUsvR0xxeDJYYzRw?=
 =?utf-8?B?bkU1MVFSTnlaNTVaZWIwZzloN29zVkZaWkJPcDc1SkV3NlBnMUZ4ZERBSEQz?=
 =?utf-8?B?YkZvVjFwdzluZ3dtdFZxck8yRUVOR0pOT1NaU0RaYmgvZ0ZQRzcrVVV4ZFRG?=
 =?utf-8?B?NEhpTHdlNWxXUDdZcDFQMW1FMlphRGd2dlNxT2NsMzdqWVBWK2s0QlhQa1VM?=
 =?utf-8?B?YjRubTNteXRVRHlaaG9MNko2b1NmUEhra0krZHZUTHdSbmJqS0szMk9TdFBw?=
 =?utf-8?B?dnJGM085d3ErbHVpMklhN1VGTlQ4TnRWZmd6czJZc2U4bzRwVzUzL2srbEtY?=
 =?utf-8?B?d0RGR1NzWE1WWm1rZHdUS3ZMRWZadEIvbFBlc2dYUEd4akp4UlVMdzBrU3Fl?=
 =?utf-8?B?c1ZLdXA5SVQrcEtUQUZaRWs1ZTg5cWh2OWxXdEZFRXU3ZzdIV0pHamJLUHAw?=
 =?utf-8?B?YlNhbmFVTXc1TmxwVXM2SmdkMmVoODdRNXg3MDQ2Y3VBMlI3RFBTa05tT25S?=
 =?utf-8?B?WDZ2SWtJSG1vWXAvK0JUNUJRUFBjTGx6TG8yTDlnTGZTMEo1ZG1CYUxybFNE?=
 =?utf-8?B?ZHgyckh1VkRWZWR3blRWWDEzdXZmaTlGa2I4a1oxU3A1eUdDY2ZjOFNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFJNEN2RjArcGRiUXZ2Z0Y4WFdqWnBpOFNrK2VKSTB2V0JBeUJtK2RMc1BL?=
 =?utf-8?B?YllPdUplOE9WRE1WRVFiT2pVSDF0enBNRUROcHZzU1RxZ1Z3L0l4QUhFcDdS?=
 =?utf-8?B?OFN4bEtFNGlvOXNxYStYaUdxR3JIdURMeXZSVVVWN0lDdDVvRUc1dE9TMHBH?=
 =?utf-8?B?MFRnY0Yvc2V3UnU3cXdyakgxN05pa0hzR294ZWFKRllBUmV5VHZ4YmRUNzZF?=
 =?utf-8?B?QW9OVVRYNG55Z3Q0cjdtM28vazEwODd1RTZ6VGFOM3IvR2FiLzlSa0ZVVDJW?=
 =?utf-8?B?VUpYcnF5T2p6M2dYRkFNTExZdmQ2QyswdVNUSWlBQTNpNzZRS2hhMGFPZVND?=
 =?utf-8?B?Um11WVNYUzdtUnVZbGh1M04zb2NWaUtNTi9QK0diaUhPYUdiRDRhd2lDaXZH?=
 =?utf-8?B?MVlOSnJ3b1FDazh5V0JITmVoZm9FR0pJYWk0dGIrdWc3WnBaek9GSGVRVjNh?=
 =?utf-8?B?TjdUTWtxRTVjNzFtR003M0ZZTkFySFBFMC9ESFhNZzJ6Z3FjL0h0TU5uaVFp?=
 =?utf-8?B?SVA5SCswaEhvUUd4U2JNN2VZVWw2ako2aHBqbDFCaERqbUNHakdUMTZqblhX?=
 =?utf-8?B?aXl5WmRsT3ZHSno2TVpNWHdzcjJGanJrc0FjTEJ4bGhROUh5NitKY0F1MDRX?=
 =?utf-8?B?RTRXYlR4WlFVRkdxaW1zQlN3Y016NUFHS0l0SkYyU3lUSTVPbVVZS3RtWlhs?=
 =?utf-8?B?ZnBaTUxyMmNJdkExOWFTbVcwTEc4MnBRamtvWGZFdDYwbG1kRGdMMVJXMElU?=
 =?utf-8?B?ZEJFeG5kd0pRenZwTzU3WTJoeDRCM1RFcktidkFNL3pTSG5UQXBQSmFlTHc4?=
 =?utf-8?B?SElkYkdVbjY3UVdrWmcrTlZ6OHprVnQ3ZE5RaUQybjFkMU1UU0dyMVR3Yk03?=
 =?utf-8?B?R2VaV3JQU2dGc0VZSVQ3Z3haZlVXMmIwOFhhVWgrR2JIcHcydjlWOTBPWFIw?=
 =?utf-8?B?YVVSV0xOU3RDMm1DV3FpKy9Rb0dQMzNNSnpQcVFGaERZaWZoeXlhOGNjUzhy?=
 =?utf-8?B?TGJDT1ZqUTdFWmJzT2MrLzBGZ1pQWkYxMGlVNktIQklQZXZiMW1pYVQ4UHN5?=
 =?utf-8?B?UGNZcEtkYzdJODJsL1J2M1dmeXBUdUtZOU1Db0lodkVYTWNlZEIwTzhMRXZT?=
 =?utf-8?B?S0pPREVMTmcwQ2liZ3R4bE5WOWNpek54L0VxVUVJS0R3enp1SnhkMnZWUWgw?=
 =?utf-8?B?MlcvaDZoS2k3UTFWeVkwNzhOVmdiWWxOaGpLRGhLL2ZHRFlPNWcwVjdsODQr?=
 =?utf-8?B?ZXVnMW5WNXFPb2xKQnU2MUF5Q3E4VmNma3NlMm12cnovY1dxNEl2OVhmTzRL?=
 =?utf-8?B?cDlYWUhXWmd5VEFEQzJlT1hiRGFiaFZ0Nm9aUURBQlFNZDFLUUZHQ2plcGht?=
 =?utf-8?B?c0VLUitENS9DcE1TT1duUzRuSDdpbFYrQnYveWZMamxjbm5DRjhlMUxyWTkr?=
 =?utf-8?B?Mjc4N1J4SmhwWXlhd0NjWkNTRGN3NWNvSnpMbjdzdDFRS3dzczJaYy8zUWJj?=
 =?utf-8?B?aVBkUlJYckdWV2VnTGFOa2RocWhKQmxKZkRoL1pFTFVVMEZlc3IrRUR2bjhJ?=
 =?utf-8?B?cmVpZ1pkWUIxWFdBTWcxN2NMSGgrV3docnUwRUlEdjJ3M1FUb1Q4VldVVTdt?=
 =?utf-8?B?Q3BlaDBJajNwM3JVWWtXMUlsR2cxLzlIVi90V2txTjVBbDJ2eE83dTRGa2F3?=
 =?utf-8?B?a0FRVUd5bGxEbDJLdDFsaE52QWwzUjFJcE80ZXNPSnBhdE1hbmNjV09vNXBo?=
 =?utf-8?B?THRqcTc5TndFR3hOajIxZlpic1BXR3RPVUdiZ2l3OE8xWTFkK2pTR3h1WCtq?=
 =?utf-8?B?R2djdkxTV21LZzBWYjcwaU5UTjZ5SGV3OGpYV0lWSk12RjFiZDdma3VpNjNo?=
 =?utf-8?B?UDM5aWhSQUQxSlhVZ2pEMlM2bVdhSkwzdFVnU0hJdG9ON0RyT2RvTjc1OGpD?=
 =?utf-8?B?R1BlUzVNd2t3Nk5GUDhOMENGRkdDTkI1eHdhTDJ0UW1mNEdOblNlUUV1M1Zl?=
 =?utf-8?B?NGVDVVpOQ0k0NVo0SUJjY0NNbTNhU2ZnSFVTSUt3b2dDOXJpZElobEFvUlVR?=
 =?utf-8?B?Q3NJZDVON3cvUjRGN05GaGpPQ0traUlJRXpvMm1nNUV6MkJxQUVTSnk1bUJF?=
 =?utf-8?Q?tRv8Efo447cBEp+8V2TuLkuPT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c87287b-eb1e-4f48-cc7e-08dc7f25ff3c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:53:55.5244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPlUcEXWzTwdHMY2lcpLTPsc6S9hIiMZCRnhpzK5odJXhbALJWl3Z54r717G7FTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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



On 5/28/24 16:36, Kory Maincent wrote:
> Once the environment was saved, we could not retrieve information about

nit: use imperative mood.

> the multiboot image used. When dealing with firmware updates, this
> information is necessary alongside the saved environment.

what exactly are you trying to do?

> 
> Move the multiboot environment set operation before the saved environment
> check to ensure this information is always available.

that make sense.

> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>   board/xilinx/zynqmp/zynqmp.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index f370fb7347a..16292ed1c7e 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -519,6 +519,10 @@ int board_late_init(void)
>   	usb_ether_init();
>   #endif
>   
> +	multiboot = multi_boot();
> +	if (multiboot >= 0)

likely make sense to remove this check to because you want to have even 
multiboot=0 too.

> +		env_set_hex("multiboot", multiboot);
> +
>   	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
>   		debug("Saved variables - Skipping\n");
>   		return 0;
> @@ -531,10 +535,6 @@ int board_late_init(void)
>   	if (ret)
>   		return ret;
>   
> -	multiboot = multi_boot();
> -	if (multiboot >= 0)
> -		env_set_hex("multiboot", multiboot);
> -
>   	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
>   		ret = boot_targets_setup();
>   		if (ret)

M
