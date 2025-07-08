Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B55C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED99D83123;
	Tue,  8 Jul 2025 15:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pA6SRhHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E77283323; Tue,  8 Jul 2025 15:02:52 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F299830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZbdLDDjluU4/nME0hBWZ5i0hxbVFBE5QrObKBTfkay8+BmvjPG+FCJC38brUUC3DPScGjuDrtGELnUNdAgZhFdXY8GQaBRnrQYxKOa3cyaptL7maMEf7MmTUlXT074UB+SiZAWWHyKt+FhDrk8hWrXWxb25gpukocYrxJCjITq5C3BZz/urfhnwPquV+yrYBA6aubh5P6x2G1ohgIGfmI4tS6nYA4uAIDoWWGLU+gsugRpO24MujDZsPJhNNm3JN/ESNBXL9xJK6Ry8sIghR2q4NX6cBGwpLf5+R4e/TWg3BFV1cdA9STZhS584/SqMgSKOoLJ2HAa1ELs0vNqH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu6aREQnPYIeLKw1nmFNAot/0K9pZDuI2TTXzQsF3Yg=;
 b=uww02vUvI72Y/kz9ZkeOLFjko7EmOBzo8Vrvq2fRM5NQ+wANFYfQYq6pQ7FkVVSwjNbjSl0tS87NqGTjMIvy/L9QBK1rzmulfY0ibZMSdvEOE7Oo5bXtBtk3CjjHVyZ7dD2AlVMPLb0JiQuA6QnC+lJOSvVnMQTPL4/1n4Wcj8oiCltqBE31Ls5v/XPEXqwTvpEQJRaLn4mRMTXFi8V2IdWT4o/PDZ1FBL0pa4EoSUx1wtm6ayfxUx6hRF3o0eUmE49audQhUM6dyLEvvBDGknZnf0KzA9vxcmHdW3jy5t0A+jkD56WX5RZQozLliZuFQJf4O085vZ7KalwlIzOOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu6aREQnPYIeLKw1nmFNAot/0K9pZDuI2TTXzQsF3Yg=;
 b=pA6SRhHVqwaV7JVqzW9szaG52F3dzyoybDm7WpQQn39H2UW9lalIEBL6R1A+w0BVGDHblKtBa/O2D2QblAinx55RbMKk08eHzrKvDpfmt3K2+PXmaVx6n3S0wtcgVTflxeb30ShcpC4Xmko9sRdoAyjIgXC4s3JGfqYoVwPd6Hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 8 Jul
 2025 13:02:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:02:43 +0000
Message-ID: <767c2bd5-587d-41a2-816a-d343d98610bf@amd.com>
Date: Tue, 8 Jul 2025 15:02:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: versal2: Remove the ZynqMP Firmware from mini
 ospi
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250707092102.831697-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250707092102.831697-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:332::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c24eb0-9401-40b8-9d72-08ddbe1fba5a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG9OQVo4ME02TFBuRTBWZ21hZHhpR3IxM3MyTTBMeWxsdjFOV01OWi84R2k5?=
 =?utf-8?B?eFE1TC9ZN3J6Z3hPK1lsb00zdXhkRHE1TnQrM0d1UUg0NjQwaW0vemZpNWNM?=
 =?utf-8?B?NUxjaCtMK2pVY2FaaGJDY1RiaDBsa2t3VHRDN0kyQ3NkTHBMamoveGhEWFB6?=
 =?utf-8?B?Z1dVSWdGRU5NVkNwOW5BU1R1NTlhZGxoRTBkYlZ2bER6ZWpuWXlwZDJHNmJk?=
 =?utf-8?B?SitLSmJHNTJFQlAxUGtWQXRmY292RG9sQnNxMUljSjRFQlZtbGh4YWRrYnU1?=
 =?utf-8?B?Nm9IcFB6WUI5ZC9NOXcyTUtLa0lLK1h0b0FzQW13RlMzU1VTbHpPUDIvRGVZ?=
 =?utf-8?B?NlIvQW5kVVpCWVZiWGRwSUUrMk8zc0YyLytiN2tQKzVSNktOTVl2ZmlLV01X?=
 =?utf-8?B?djEwNWJ6MHV4R0FYcjh5QkhYaWV6NnRCMU1iTDFqdmVZeHd1dmFadUJQc1Nw?=
 =?utf-8?B?aktTenA5TXRpN1JJdEtWZXF3QzR5c21MaVdRc0hJU2lrbUZvcUxwODhkcTYr?=
 =?utf-8?B?RDNqNitaa3BwZHM3L1VVYkJUNFliYXRMYzIyYjFDSmR5eUpETWR6d1hIcDUz?=
 =?utf-8?B?L0RPY0FDdHI3cnlUSHBSNElzeVJkdzgyVGdxMloxNkFaNTFubzFheHd2MnN6?=
 =?utf-8?B?RzNhYlVST21Eek84VzR3QXhQTDR1Z2NXWTZzVmNoUThScWNHa25PeUVsTERr?=
 =?utf-8?B?VCswTUM4dVRjTVFQZW5LL2RGUlRPM0ZabUk3KzVjY3ZTQmZHZUpERTBnZktJ?=
 =?utf-8?B?RStSMG9VVWZYcHNZS3BmeXR0NytOVk5FRS9lUEVkK0FrM3FNbmkvN2o3eGVv?=
 =?utf-8?B?SzJraEZWOEdOTnVWMWZqT0lqR1ZFczhrbnBLMVVIcnQyNDhzNWRhZjJQZFd6?=
 =?utf-8?B?OS8zRmtiYUEyV2t3T0hOMldpSHl4SDMva0FpNW4rbmsrajVmcUkrVDYxdFQ2?=
 =?utf-8?B?ZWVmTEwxMkdCZnpYa1Jqd2lFcjZVL1JNNS9BT2ZMbGsvS0xYSTJxSUlzNFoy?=
 =?utf-8?B?a1R5UTN5aWl3MmxQdEl4VENhdTFQRk1rWkpHMnI4bThIZnYxUmc2QThubEVp?=
 =?utf-8?B?YnE0MTkrSjhLSzFIOGhIS3c0VWVoTzhMbmhLYWY5aHA5WHVNQXNyYWNKbHg0?=
 =?utf-8?B?dk82eG1OMU9zd0w5cDF0VDNSazBYRmR4VjJiZU83Ykd1NVpXMFFJSVFCWWtp?=
 =?utf-8?B?MVdRN3lmQVpKQUxMNjB4aFBPTmtJTElhU2M1VDhrVWJrcE4zdnVDNCtEOUlI?=
 =?utf-8?B?Qy9HWFBWTGxwSFdpM0hZMWRPNTJVNDhSSDMyanB5Sm5HeHVRWWJXbkY1R3Q2?=
 =?utf-8?B?cEJQZVFzK09RdkdNdDZDdHhUeG1xbEk5L2owLzZCMnVzclVqajd4VXdaVDFV?=
 =?utf-8?B?V1hFb1Vvd0d2Sk9OaDUyRDhad0NWb0FiT1ZFSnMrU1FHc2FvRm5DSHcwVmxZ?=
 =?utf-8?B?OTVvKzd1V1MxdDJzZEdPZ3N1Z0hkcXIySkhqcWhmUE1Qa0FLQW5OMm01N1hz?=
 =?utf-8?B?cFFsaGdlMUt4SzgrU25WWWI2ZllrK1UweVNIc1RSSHBad2gya1QrVyt4Vlpq?=
 =?utf-8?B?eXRtVG9lUDlSVGFlejBsSktiUTVpQm9DYjZDS1BtU1FPaHdJM2JWTFd2VHhl?=
 =?utf-8?B?T3Rxa3NTYWtmdGdONy90K1NXKzdnTW1BY0hFZHJUVnMzRDIrRmFwVkNKRDUv?=
 =?utf-8?B?YlA3dWpNVnhLNExyMjJGSzFtWW5yOE9uaHZvTkYrcFErNkZxNXB4anhlRWNr?=
 =?utf-8?B?YzViREF0NkU0Vjl3Ymx5ZE9GWnJSTUJLQmUwNDhSTXp0RUhIUisvZmF1M2hn?=
 =?utf-8?B?bVZYRk5zZG0yMGNxSGs0VWRjVnlPS3Zpc0NZcW1ydGtURGM3QjFZeXFTYlAr?=
 =?utf-8?B?bHNWR1JQZjV3N0ZkT2w3a3FXdEJsS1FocFFsbVdMREkwSlNKaUtKMjE0ZFRj?=
 =?utf-8?Q?M7TFJiMAMP0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhlWWFSK3l6SzhXMk9wcmNGWXg3TVh2VzB5M1ZDYWV2L0dtaDg0SEdXaE5E?=
 =?utf-8?B?RzRUMUd6K2YzaGQreGtWQ1lTaTlWOXpVUWxNcFArRTdRbzhUR2hjQUlnRUpV?=
 =?utf-8?B?QjV0MGVJbUxEOXA2UnFaZDNlRUtNWTdkS0t1UTJuNjVXQnZULzJndXQ3SElW?=
 =?utf-8?B?M0cwc0NSMis2aXZOZjZZUDN2S0J3a21uYUlxR3hTaEgxYUJPQ2NSQjNaVUpw?=
 =?utf-8?B?Q2xkeXVnc1pCR1ZKZmlTYWY1ejcrOXk3cTZYZ0ZlK0NMMzlWQW40MVhIUTJk?=
 =?utf-8?B?eVpJSDRCeGNUclA2RFVSbUxMOUllU0lJdXc0L2g2TzdNeUNDd29xWi9BSlpi?=
 =?utf-8?B?aWdaSC92aDhmOVNWb3g2TEJHNGtlYnI5ZjNmQjh3ZldpaG1BbjFGQlE1VmVp?=
 =?utf-8?B?UW94KzFMMkRqRERIU3FTSEo1SzdKTmlLUnFXWDMyVWJzaWdLSUVxT0dMTlpv?=
 =?utf-8?B?V2htc0dobUdNdzRKUnVrQXJvckFVNlpWczh3cFRvZVh4Z2J1R0w3bFhQcm5Z?=
 =?utf-8?B?R1pTbWdsLzAzYWNzZVRiWkRVV2poTjVhMG5kQ1l2enJuckNucjVNc0RZMXI1?=
 =?utf-8?B?U09GQlZMK2JjbVpFOWJRNWpPZTBpZllFL1djTzR6TUQzeFRrYWhrQWhOMVhH?=
 =?utf-8?B?ckpobWtaZ3lzRXJhZURMbmdhdk82T2FHQkYraU5rWFhCWWs4dEpaYmo2M1F2?=
 =?utf-8?B?L284b2dzMHFJSEo5SWZwVXJwQlRKdHA1Q1hDZHlENmxRQXVZdDdjRVJHWTdh?=
 =?utf-8?B?VmdPTW03eXN4NkRBUW1pV044ajhtMjJabkw0bzVnVHNYQVFNZytKRU1hTmZU?=
 =?utf-8?B?dFIvV0orL3dYY2x6cVNaOGRRMy9xWm5JOFNVWkdNWUlFckpXNHVVQTFsS2tV?=
 =?utf-8?B?ZzBjSnk5UDMyZ0RaYi9JVzZMQlprd3ZoSGhCVnFMS2hPeDN5UWU0RWNLYWtW?=
 =?utf-8?B?aUxjMm42M1hyQVBuVzgwaFlma09QU29KcmtvL2NlT0U3QXlqWkVSSk1Jd2JN?=
 =?utf-8?B?VHdablZiV2doWGFjdzZ4Uko2UGpYSGovU1cvMEdVZVNCQm15cEJiOHd2UW5C?=
 =?utf-8?B?aWNzQUc4TGZyM25QV1JnUWlGME9PTEcwbkZXM25uZlFWTXlnSjFMNU1INjZp?=
 =?utf-8?B?QmF4TzNhdEpiU3RIakdqRmQwK2lEVmR2dzB5QUtrRjJRRWdJRnRobG9HMU9V?=
 =?utf-8?B?YUcvQXp3Z015WWxtT1ZZMnY0bXNOYkg1VDB5NnRYMlJNaFFLSWNxaUtrZlNH?=
 =?utf-8?B?clkrT2xoR0xRejBrTlUzamhadDJuaDVXdzF4blkxb25yRXN3NE1JMU9QQ3pQ?=
 =?utf-8?B?M0dmOTIxWmRIR2x4cTQ2UVBpV0ZhNWh5bjVoaDg0bGZHT01DbWF6V0dpNUxq?=
 =?utf-8?B?QXNJdDl1ZVZtcUg1dlh0L0ZYVWQyMXhlQUVCUE91bzBsc2tUYjBMYU16ZnR5?=
 =?utf-8?B?cjNQdjJ0V1VHTzE3cDBybjdzMDZsdUhZNUVYUVl3SWtoNWYrUEltaXVhUElH?=
 =?utf-8?B?T2JhMnU1cnl1ZjFWdGFlREhuVHN4ei9mYVFZTFdYOUxmeC9IQjlXMzRkOG9h?=
 =?utf-8?B?TTVtOGlrUzMwODY3T25aeUJqd0VqYmRnSXpudEhVdVArQlZRaVRVcVoxeE95?=
 =?utf-8?B?dm5zUDJ6YkwvRmhLWGM3dDhjY2lCTUM5SXRTcmROQndMcFAvVElweXVYWGlM?=
 =?utf-8?B?RmtGeVZPUTE2eXFXV0dCWlh1TVFFTDluNTE3d0dWOUpDZ0hYQWgzYVRhSGFs?=
 =?utf-8?B?NGhoWWhaTGhFWld1VnVWeW1vTzltWFRoK0dVQlI0Rm1mYWNRTWxCWWF5bXRw?=
 =?utf-8?B?Tk1CQlg4eTRGMUFsMlJnNFhadDZLMzl4YW02SjRyR3lZcDdPazhRUmk3bG9T?=
 =?utf-8?B?dGJvOWFkYW85aVdLcEd3KzNva3liZENrZVljRDRTcmxYRndMREoyVXRFZ3Fh?=
 =?utf-8?B?RmFrczNWYS9ObHRPTjBqQVNheXJXcFdLaDBOZlpPZGZ1MUJ1R2ZPR2FSbnBX?=
 =?utf-8?B?eU1nbzJYK3RHVlVRWWRFV1RKNlR3ZXhYNTh5VTNwK2M3ZEgyNXdtaE5weUhQ?=
 =?utf-8?B?eUh6MGszeFAvZTVhQlB0bGRLUDRWN1NjNmMwV29YanFEY0s1azBHeXhoNyt5?=
 =?utf-8?Q?WKVSerovrVxF7HjN1x8mg/TEI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c24eb0-9401-40b8-9d72-08ddbe1fba5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:02:43.7868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onQmwClv2Bk0WcKTILsBG1qXzzCkfMn4NsAg+J6VU+blX6d1tHWWAHrSN87eUiZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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



On 7/7/25 11:21, Venkatesh Yadav Abbarapu wrote:
> Remove the config ZYNQMP_FIRMWARE and also update the initial
> stack address.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Remove the config FIRMWARE as well.
> ---
>   configs/amd_versal2_mini_ospi_defconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
> index 54328e85784..e0430434ba3 100644
> --- a/configs/amd_versal2_mini_ospi_defconfig
> +++ b/configs/amd_versal2_mini_ospi_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SYS_MALLOC_LEN=0x20000
>   CONFIG_SYS_MALLOC_F_LEN=0x4000
>   CONFIG_NR_DRAM_BANKS=3
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBF20000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xBBFF8000
>   CONFIG_ENV_SIZE=0x80
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-mini"
>   CONFIG_SYS_LOAD_ADDR=0xBBF80000
> @@ -57,6 +57,7 @@ CONFIG_OF_EMBED=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NO_NET=y
>   # CONFIG_DM_DEVICE_REMOVE is not set
> +# CONFIG_ZYNQMP_FIRMWARE is not set
>   # CONFIG_GPIO is not set
>   # CONFIG_I2C is not set
>   # CONFIG_INPUT is not set

Applied.
M
