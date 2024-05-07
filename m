Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49224C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 05:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D60088735;
	Tue,  7 May 2024 07:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brrDRJtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7669E88737; Tue,  7 May 2024 07:53:54 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14708886F1
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 07:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi7urBLSbchSiBPy3SMb9CWEbaOfyt6EnPCVzTQ6OktLb1VTvoFrpaMZ/sR1XSl9qzNZNezL3gBGvE0b2N7HZxK27dj+wAb5e0/UYsduyPMhM4+e1eOz6E7pSej5k2LbB6lh93Uy2taec8MwQuDgCeTd3KuJ1rmMDvhUuYQxsYOUA7XzqwVgJFqSqVRnxtzzIwCCTMFN938fF0qau/1FR9qBsWdVvcAF0J6F4SCRsRUN8g7p9vRlSizm6Q8B1153AnkJCM61IZCtJ5cbroO8Nk97BqMzKIuxuug/tjN3hpUSfRHh5VOBrlLAIWhn37LkxzY47gbITcrJdo8d7/0S6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YMN//kCcXJQ5TKL3EL+xv94pXTKR0OatTYejsmUAx8=;
 b=bkhTMUcP4Bc9G3JYaOKhz64ytAVZInowKugk5A0CIW6yOkfOPgaRhDIqdQHhDIf1L/FmSU11R7wnghGiiP/If+YnewTrfH+RG+g9Km7Amns6xzqXo+a/BmyW2joXUDtfsjtRuuQzZK2vZupWOv+PNuhZvD6L9fFyrGlauU7ZnDWwTmdfJfq8QaIXO2lrRPt7sjNz93qRKdmtVgczi1jeWsH5NC26yqZV5LUw7vZWKbYJ6624chZugDy3BeFtHnyuJPAk2L/e0Ops0uJotxCjmAlKay2b+ZPBBvYs998DHJ0Z4VJdtnN5y8VMHa2wWVwCoz9g8z9mKOLH0vhyA7Cn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YMN//kCcXJQ5TKL3EL+xv94pXTKR0OatTYejsmUAx8=;
 b=brrDRJtfkFE+wgT6y4M9hh1MLdHA+x8GTbJTFkntlfsGE6MOPc7eql4NwB7yhgQRRBiu6RsEmz/uj9yhvhxKJ4EMzmGVQ5pxWrH/LiAcgq3ucfGgMqLIVXjuwSKUWPYIdeXvubP3xhTMx+bbF4b2YH/sdxGs22TlMc0O98z62xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 05:53:47 +0000
Received: from MN2PR12MB4454.namprd12.prod.outlook.com
 ([fe80::4f10:46a5:2505:60d0]) by MN2PR12MB4454.namprd12.prod.outlook.com
 ([fe80::4f10:46a5:2505:60d0%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 05:53:47 +0000
Message-ID: <8df3d032-65bc-4bc9-a255-ba825847ea9d@amd.com>
Date: Tue, 7 May 2024 11:22:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] test/py: net_boot: Add test cases for net boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
References: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
 <20240503201842.GA2560583@bill-the-cat>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20240503201842.GA2560583@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::20) To MN2PR12MB4454.namprd12.prod.outlook.com
 (2603:10b6:208:26c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4454:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: f48d04f0-b553-4876-034a-08dc6e5a0fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zlg1UnRmTTRyMWtmeGllQ2FlTjFNZkl5d0lSRnNuZjNkNmEvRlZZcWNvK3U3?=
 =?utf-8?B?elhsTTlEczQ1bU8zSkZDL3dqWnZ1RHBzenh5RXpmMWJYcEhLaUx3WGlRN2ZD?=
 =?utf-8?B?emhhbENpK0h4Y0RJQm5mSnROR3VlQkNUcmIzT01Jd2w5N1JGK3RBRSt2R0dL?=
 =?utf-8?B?cUIxd3E3c1prMldTY1BuK2RiOUVjUk5mS3AzeG5hNVk2RlNNL2V5eTBuSnRq?=
 =?utf-8?B?WUdNZ005aGQzUFhSOTdIVktYV3dDNEg4MlJVUFRJWHFSUVBvMnNyTjZhb28x?=
 =?utf-8?B?QU5zaWdJd3FHU1pGMzhnUEs5NjBJb2svRDUxWjc2Rk44dXZuNkZHanNlZE0y?=
 =?utf-8?B?dFNzWEE0YmY1ajlZQXBUZlBxZmxtSmlBa2w3WHptKyt3NmR6UTM3NVk3MUxu?=
 =?utf-8?B?elRQR3BXb20vR2s5M2I3SnVMRG1oY2xYa25sTEFUcUg3VzJoS2JjNGdob2Nv?=
 =?utf-8?B?YnhHUmFkY3ZLdG5aQTlVZVc1U1c4eVhzWFZnK1kya2pWWXZIcVB3bkdmK1RM?=
 =?utf-8?B?Vi9NdEY5L2tzTlJHQ1FhbnZGdUpBdnRwbDN3akV3dUp0Ym4yY3h6bTNlOFNv?=
 =?utf-8?B?UFJva2NNVlVkUSsvOENFVU1UQ0tROW1UY3RIWFFxQVlZZHo4UzBzUlFXL2dh?=
 =?utf-8?B?aWF6bXFTWlcvUmFBK1VSV2JLTnRhMWV6eW5hU2FxUmorUStnWXN1cWd1UWRo?=
 =?utf-8?B?eEgvdGVMMldmZFZDN2NidWZITEZlZ2t1QXNBZXUyV1c4cmNocnFXa2NsMTFK?=
 =?utf-8?B?Qk42dUxqeW40OHZBMjZXUTc5azhzT29NMFE2WlhrTGZxUHJyL0pNYmdOcFpP?=
 =?utf-8?B?dmNQVFY4amNzenU4dFVHNHdERTBaQ2xMcUo3Tld6UUY2Ri9UWUk3R2sxZ2Rv?=
 =?utf-8?B?akovdHlRVDk2VXNQamJ1QXhXaU82UkFPQlJPRHZEdWo2amd0aCtEbmF0cUVj?=
 =?utf-8?B?OTM2UTdNMUlpWElsZng1L1lSNkcwcVpxNnU2WWdTMlpzVzZQN0h3Mytoc1du?=
 =?utf-8?B?czVyM0EvTlZKNHRlTlM4V2xkem04Uml1blJ4TG9qZkRBcGpYY25oRDN5M3Zz?=
 =?utf-8?B?ZFRzdk5nZktnbXpoNWRrOFRHdno5QmFQbzRJM3JOdWhNVUtueHBOYXdmOEJp?=
 =?utf-8?B?OGZ5M2pBNEJrSEQvT1BlOFFmdWpCb2FXZFFIaGoraUtlVmp1QWYxbmN5RkJZ?=
 =?utf-8?B?VTB3Y2MraXYxdGh1SDlSVGE3bCtqTzhSaEt3dlZxZW0xLzJFdFA1MlVEVzd0?=
 =?utf-8?B?TzQ4U2p5eTYvUGNPSU40dy84Y1ZKeWxiT1BpU3RvUWdPa3ZDalBlL3JXNHgr?=
 =?utf-8?B?YnI4RFZOZjhtakV2RXZ1SnBxaitBelRISlBsVjRJVklrZVozNlBxK3VabWtC?=
 =?utf-8?B?ZlhBblhhbnhqVm1WWGNVa0pYeXdlb0E4c3ZySlZoWFVabElpdEYranVPeDgr?=
 =?utf-8?B?cVZMblJycmFuQW45OHdIbEdDMUNoMi8wWXY4Sy94VjR2VHhicExwNnlOZTdW?=
 =?utf-8?B?ZGdJcDI3c2dhMzBPQ2EwYlU5QXdyRU5uY0ZjemJBdGRGM1RvQnEycit4NnZV?=
 =?utf-8?B?QmltM0RHYzZkZGR2SGQwb1B4RTlCNHVsQ0QxbDlFTWEwbVhOb0VaZjRlUnZt?=
 =?utf-8?B?bXdsQmluOWJOc3JUdnV2enJnSHRuZHl0K1hGOWp5eG5VelJtV3l1Y3ErT2Ns?=
 =?utf-8?B?SXd6TnpJNXVlTysvSGI3cmdoY2d0dG9ubGVKQ1RRSmlmbmNsbUxGbDhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4454.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVl2dUpuY1VBUTVjS3A4V3FrN3B3SDlYTzlyc3NUTzAvc0JjM0V5NFZIK3A1?=
 =?utf-8?B?YmxDYVVqMVh0SkJwUDVJMlF3aG8xaVBWRXp6aU5vWVAyMjBndzZqa0paZWxQ?=
 =?utf-8?B?ZXdXYmtvbDArbnU3L0lrOTE3S2crb3pCNDdVYTdVNmRFdHFnZ2dQSkU3cjl3?=
 =?utf-8?B?K1h3TW5IOE5uUUt0UXJESWgzTzZVLzlacEFmWVJUMnZBYlBOcmtodmNObzM3?=
 =?utf-8?B?YlVtWTZaOGNhNGZDK01mSkx6SnRvU0dtNGNJZitEZktLUWljTjNuQ3o4N1Fr?=
 =?utf-8?B?V2h5SmJzbXFnQzBqQ3ZCdEpPZXBGbGNKMWpRTXptZzdOK1NlVCtWL1ppQ1FZ?=
 =?utf-8?B?dThwWCtONWo3MWRKcVRNQmxSOURwb0RiMmZFM3FURzF2a2tZVnd0czU3Mlc3?=
 =?utf-8?B?NTl6cmhlbjJ2ckU1N3lyK0M1d1MrU1g3ZTM4c1Zja1J5ektaZk84Y0NxLzJM?=
 =?utf-8?B?a3hPRVZxVmt5ajFyWFBnS2Z2bzRpRHRBenNoVCtKZzNMc2NaelZ5WHM0REpa?=
 =?utf-8?B?MU1uTlE2aTJ4VlR0T0FuS2FLZ081OVZVV0l4V2pjTG14dWN3c3dRbmFqdXdE?=
 =?utf-8?B?RVNKNnVkVE9kZU9VZHVXMzZlZCtDM2p2R2V3TnJMZkxnYXJBdFFBaGdtblps?=
 =?utf-8?B?UnpoYno2dHpIYUFtaG8wZ1k0VmNIMENjeDlVR24wWUFDNGYxSy9ENVQ2TFN2?=
 =?utf-8?B?WFNWNXdUUnBCMjg2VGxhb2ZicDRBb2lyWk1qUTFVZUt4RGFsU0ROZVFWUDdN?=
 =?utf-8?B?ZTduMjFCeGdlSVdpU0ZXZ042bXdQVU5GRUZpZHFFZ1JZR1AvcDdWSnAzb0Jh?=
 =?utf-8?B?QlNoSk10QVFzYzFOWjBIMWtETEtPUVZxeXpqYnhRMnYxbE1nVGk2RFB0c3hr?=
 =?utf-8?B?YXJRWlBzQnJQbnRpQ09ZUGtsemh0d21ZY1RPc04wZXZHbjZTWmVQOUJsZ3p1?=
 =?utf-8?B?YVdBV09tVExITzVlaitLajNUL2lDbXgwcWFISmlPZmJqc2xvdTlvVGcrSnpF?=
 =?utf-8?B?RTQ4djVOb0N2L2t6OXExelVsNXF2eGtJZkdTT1FnaU9vTGVWSnRZam9YSTJj?=
 =?utf-8?B?S1kxeUU1R0o5ZHNJKy9ETysxUUdmSmgvM01lVGJXeDFGbUlvNVMwWkI0a05m?=
 =?utf-8?B?aVBmUVgrR2tRWWUzbm9CTWtBOTZ3QVluUldmNmZNVHV4cmYwblkxdUVvbUFm?=
 =?utf-8?B?dFVyaVhGS2hObC81ZmVkMzExNVRTTnVUN2pnajFMeXIxZ2liOXBVMjV5b1oz?=
 =?utf-8?B?bW9OYjhhWTluRk5yM204MnQxOE82MlZ2Qlk1SW1PRmE3YjFuc1FER1N4d3Fz?=
 =?utf-8?B?bHRkV04zbmNHaDNKUHEwVkZlSEd0ZlExOEw5bFg3Q3hCbmZHRHdFa2Vpc0ds?=
 =?utf-8?B?aGZUU0o5aEU5YitwbEh5RDhHcmFmbG9MT0g4bmtZOUJHWTlTbUFZWDZrc1B2?=
 =?utf-8?B?Uzl2aXc1LzZFL0ZTQm9OYlcvdGFFS3Q2aUFEZitDcVJjUE5iUnVDcUFVQTVN?=
 =?utf-8?B?S3ZUVHl4eWJ1N2FNNWlsV0dMV2tXb25wNU80VTFucFB1WkwxVUNKMmpXTkZB?=
 =?utf-8?B?WmdoMUVXNnN6WG4xRFF5a1FMV1lEcytySFJsV2xmU1BTRDhTOWY0S3l6c2J2?=
 =?utf-8?B?eWFiajlhOUdwM3BTcFVNbHJzbUpLQWVxbmdUbldFZFdyb0tDZXBDcm93dzRS?=
 =?utf-8?B?WTloNnlOMFR3U1pOSE9Wc0t5Vi9nTGsxdGFReXlTaHdCQkZVdVgrWldvQmtK?=
 =?utf-8?B?MERnMjV0QmtMT1JyY1ErSGk0SGpOQzBmcVV1aXY5cDBJTTVQTytxb2ZTNFIw?=
 =?utf-8?B?Qm94NUd5UVUzNXQ3b0M3V1ZCT3FUY2xMUmQ1YmhENHRXUEorcXZqNVhnYnh2?=
 =?utf-8?B?anlXajlraTZ3RTNBUWFBaStsYldId0ZlbjgxUVFHTVk1bXR1dTh5LzVhbXdM?=
 =?utf-8?B?a1JuRS9KWmgrTHdXTVN2NEtQMUlIejNscDBXeUgwbUd0UDd2UzYzNlFxdWtx?=
 =?utf-8?B?aE5yNzd1SGpnM2JUdVAzenMxZFlMNGtzakdYMUk4YVgvSE54QVMwaGVib1lD?=
 =?utf-8?B?MjlEQ0tINnZIK1dIdCs3UkNDNkF1bmhsMks3Z1lnL1ZzNjR2WmtKcTJRWVkz?=
 =?utf-8?Q?MqrQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48d04f0-b553-4876-034a-08dc6e5a0fe2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4454.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 05:53:47.5698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6NIeBNvVmFvGdsCwoVAxUpMJjSGPZ7C24tZTh/1zuvRKaj9ZpXOkoj4FyTZPxfY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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



On 04/05/24 1:48 am, Tom Rini wrote:
> On Fri, May 03, 2024 at 05:39:46PM +0530, Love Kumar wrote:
> 
>> Add tests for booting image using tftpboot/pxe boot commands, tftpboot
>> boot case loads the FIT image into DDR and boots using bootm command
>> whereas pxe boot cases downloads the pxe configuration file from the
>> TFTP server and interprets it to boot the images mentioned in the pxe
>> configurations file.
>> This test relies on boardenv_* containing configuration values including
>> the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till the
>> boot log pattern value is matched. For example, if the parameter
>> 'pattern' is defined as 'login:', it will boot till login prompt.
>>
>> Signed-off-by: Love Kumar <love.kumar@amd.com>
> 
> I'm not quite sure where the problem is, next. After enabling FIT image
> support in my build so I can use the image I have on hand:
> U-Boot> tftpboot 200000 v6.6/image.fit.nocomp
> Waiting for Ethernet connection... done.
> Using smsc95xx_eth device
> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> Filename 'v6.6/image.fit.nocomp'.
> Load address: 0x200000
> Loading: ##################################################  82 MiB
>           3.2 MiB/s
> done
> Bytes transferred = 85984256 (5200400 hex)
> U-Boot> U-Boot> crc32 200000 $filesize
> CRC32 for 00200000 ... 054003ff ==> 754c839a
> U-Boot> U-Boot> bootm 200000
> ## Loading kernel from FIT Image at 00200000 ...
> Could not find configuration node
> ERROR -2: can't get kernel image!
> U-Boot>
> 
> And in u_boot_boardenv_rpi_arm64.py:
> env__tftp_boot_test_skip = False
> 
> env__net_tftp_bootable_file = {
>      'fn': 'v6.6/image.fit.nocomp',
>      'addr': 0x00200000,
>      'size': 85984256,
>      'crc32': '754c839a',
>      'pattern': 'Linux',
>      'config': 'conf-852',
> }
> 
> But it's not trying to boot conf-852 but instead just passing the
> address. This image lacks a default config, which your example has and I
> think is why the tests work in your case.
> 

Hi,

Yes, this case expects to have some default config in fit image as it 
uses 'bootm <addr>' command to boot, below change in fit image should work.

configurations {
     default = "conf-852";

test_net_tftpboot_boot_config - This case will boot from the given 
config: 'bootm 200000#conf-852'

Regards,
Love Kumar
