Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A54DC83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 08:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FF182E52;
	Tue, 15 Jul 2025 10:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WpZUMfDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D9782F00; Tue, 15 Jul 2025 10:32:54 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 412ED82CEA
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wD//ddPjS7RSW84sCaCCPVO63KsMPSYjaI8YTvOevjvFA/iW6dUeXp3+OB7Nb298UWqcbUbWcB3rlXB63eVuru4inWGExbFqiy9EOcPRax05/1ir09gtpBgQwMSQQ9LZXK647m4ElHwXTeXzE+cU0NR3oMnEv6D8i+xZOY6xN/8iYWly35DiMD+z1mUJsWxxYWwEQMh5ZlzWOdiEQRRQSfGOVJ1klLjFpU3CCaGzsCFFKunecQHl8GcAGFBT5KvTkFsNSGyXhmX/eAILvsqYp36/8PZJ8BaWh08RbkgDiIAM+C1SeqUukJsbvyoWcj+V5EJCLrMtTUBjI60AXZuuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB7wjnRhitWjVvZ0BmxJwQPHdFzT6V4Mf9NSV5y/Svk=;
 b=s81fv3Dyyg/NXLRiTsTsHyHizYXUiIA5BmVxLqghyy7yQn/v8p7VG4TzdBXvqfQ5zHpL9AImA54s1ItF0okI7AnuVlLLzzEl10B/W86/uvQG6i5dOq31iWtb69TE9PMpjZPgatVaUiIK1fUCevLZuScBgqwboqUj55VpNHy8Sd7+wRjVmjdEHuhc+2+/i9QhwTElixhRXKZjWq0wzzX0cMc3z2lq0kExYUlVl43AbKNxT3DRSkgHlHQBmWmf4kbk4oQE3CQKt3E5bTbrQDCYhDLUk6lAzbYwV/6+EwHbivPoBsoWdH2zNaWE63mI+jyQeNYp/UfZIa1xmq7SWId+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB7wjnRhitWjVvZ0BmxJwQPHdFzT6V4Mf9NSV5y/Svk=;
 b=WpZUMfDZKp76svYGtN6gdvTGnlY4iLHrj6/fKvcsizPpAD3awzsRGBhpMwUZPbpEJpkKX3KWmNHx5AayLvIQk1n39+viQx4OSj2ZO2u5ZLwF/C/jNJGot8tsi6RzaI+IhqwWR+vwu8gqLEwF0Io3BdSo7Bo0GhR4ztvelj0BhPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10110.eurprd04.prod.outlook.com (2603:10a6:150:1b2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:32:50 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:32:50 +0000
Message-ID: <552de3f9-d9cb-4d50-b7bb-9e6b7bc12ed9@cherry.de>
Date: Tue, 15 Jul 2025 10:32:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild: Don't mandate gcc as the host compiler
To: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20250712104558.77355-1-kettenis@openbsd.org>
 <87o6tpb5oj.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87o6tpb5oj.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10110:EE_
X-MS-Office365-Filtering-Correlation-Id: 49020a7c-5da7-445f-fdcc-08ddc37a2f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MklFK3FGSEZvenpVSE5xWFNnekFCVTZJRlhCRVBKRjVRNG1sR1k1bTlsUmxE?=
 =?utf-8?B?T0pEd3ZpTjlTOXRTUUZhU2V1UWRrM1FMUEFvTGFoQVROdUNXZmlIWmRYRkxv?=
 =?utf-8?B?WlQraVlMZFdaRzR5Qm9FamJVM2xWVkROaHJnL3pHWEdWRWJQRjZ3WFA2OWcr?=
 =?utf-8?B?MzBPSE96eXBHakJhUldSalNYUnpISHdKZ2tzdmpObjh5M1I5VFVLRG5NekVQ?=
 =?utf-8?B?SHBEUVkxUjJuUFdkWWo0eE1yTzdvaFYydTBqZTQ5dkIwOE1DN0JuZXBjekxE?=
 =?utf-8?B?djFvbHJhN05CdWJsKzdoL1dzNDFLUnFDUHpKT1dydEtwNVRUMUJ4RUtUdS8y?=
 =?utf-8?B?ak9tcG50ZEJWRHdZU2FZS2pjRXFXTkRJZnhRMFdzTVRXVTkwQVJyTGJoMDZ4?=
 =?utf-8?B?UklhblVJTG8yTUVINGcyVzQwNkNYWlBhMjNldHlJSGY1TWt0MVRudmVNMW1U?=
 =?utf-8?B?Sk56L2tLYzBpaEdKdWJ4SzkxT0lPbTduUTVVRU5KVHRhejd6THpoZ25nQ0c2?=
 =?utf-8?B?aTlEWGtoSVozaVBMa0R5b0hxUVpaK3ZDZU03ZUdjMnBhMWR5dVRZdDVDbnlu?=
 =?utf-8?B?MCtxVzIyaFJ0SHVaemRpN1h4RjVOL0Z1cWhXQU95eUdvc256MzQ3bkRaVjBi?=
 =?utf-8?B?MnZnQzZVaUpnMno2NlNNMVdEN1hacVlvVStzMVNHZHBFYVhMWDRNYWt4dVRy?=
 =?utf-8?B?SnFwZStyMlE1MmE3bWZEK2QrM2FUYzhoT0w3dENBdnVEdnA4NjliZHFLcWRo?=
 =?utf-8?B?RUJGVDdFZEtrcExsMVF0dHduVGRVL0JscGRhZTJrUkFKN2pGWTdHWTRGZjQz?=
 =?utf-8?B?VXl1ZHdlRldoMWI0L1JWbFFmb3lrbkFJN3M2OFUvUTlGUmY5c2V1VHFJRWlt?=
 =?utf-8?B?eTBKV3dRMEtlTWttajczUERYOWI4YytRVFNVK1RiRURiS00xQkxqZTF2bzEw?=
 =?utf-8?B?bFZMTWM3OEE0L0VGVkNmR1hkamZXUWRnaUJqN0paei9ONHh3eUQvSXFnVktY?=
 =?utf-8?B?QTF4T2U5VE1zTDdSRkhFU1laRzZUdXV1dUNMWTNLSHZhamJ6THVlZURpZVNS?=
 =?utf-8?B?SElqTzdqQVJWQ2lrM05nQ1JuSUw0cU1BZ1A1RkV2bTcrRU9jaXhhM1VUNHZl?=
 =?utf-8?B?ZnlwYmowdGVqVHR0Q1g1cW4zSlFiTzF3ZGNEeXEwODBqdzZHYllDTVN4UElk?=
 =?utf-8?B?NEJSdFo4VTVYOXU3MlM0VlhXQUpuMytZbmk2OEYzZktUckgvREdBTnRzamJD?=
 =?utf-8?B?T082dU1McXZ5d2oxZ2M4UDQvWk90cUFibFZUQk5KdUNwbWFYYUtHZzM0OTVa?=
 =?utf-8?B?L3h1QnhKaWx2RmE4c25yZ2twU3ZkUkhvQ0M4ZURNdkVNTFVxNko3RDlGczVs?=
 =?utf-8?B?OUdsZnVRZGxkdEV1Wm45UjJ2ZVJ5bXRYMkxweEJzdHIxb1doSG9jcjZYSGpa?=
 =?utf-8?B?VFhkRHNzL0dOU1VwTnpLKzBjdXVFSUxRVW9OOTRnUzE5MHU4MWdHU25PQW5q?=
 =?utf-8?B?OWw4Z2pUVUoxaU1JQlcxUGh4ZFRKZ0NybHdNekVEK2xYUGwrK0dsellZa0RV?=
 =?utf-8?B?eWlsNG5FWWx4QmhwRDVoeTRrdWR5Yk80OXFDLytMelYrVC8yQS9pdnNsSkM3?=
 =?utf-8?B?Sk02WWRNNnlFSUFKaVlROTUrZTNJS3JaUXFWVzllUDU3ekJrMDdBZW01RWxS?=
 =?utf-8?B?ZFlYUXU1L3dST2s4TDI2aThFNElybEtneVpvQzk2cTRIdzF6ME93K2pYVFNW?=
 =?utf-8?B?RmNmbForM1RaTVllLzk4d1g0bWxnZHhOS3ZHT29jcGpZU3h1UnFNVjc4eGxp?=
 =?utf-8?B?QzlTUnYvcjRqWTBNTUF3NWhsSk53ekdUVVYwaSt4ZTZHdmdrV2RGUU0rUnpn?=
 =?utf-8?B?Q29QVVFjUmxvKzJNNlkwaVBtYWhsakhKTnpjcERQcW1wdE1acnNXak1qUG1H?=
 =?utf-8?Q?ofI5ldA+zso=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzVwNXZQMDVMSGV3NVpQYlRBN0o2R1l2MEw5Qm5nNWVwSU15YVFDWmZqaTlj?=
 =?utf-8?B?UlNqV2Y1VjFLeHFqT2lKaktERDByWW1hSkY5MzZ4dUJzZ2Z5Wkh6d1pSOXM2?=
 =?utf-8?B?WEFhSWhvMmd4T2RJSW1qZXN1VFkzZkp2bVlieXpYVkc3MVNncmZ1T2VEbE5X?=
 =?utf-8?B?MVIxc0RsNWF3MEY4eCs5dXhLM2xYMjlGZkNZbi9lRlVYdzg2cVl1SkZLckVD?=
 =?utf-8?B?UkdMZ0RaWFVpcEU4Q1NpVXFmbFd4T3ZiUHUvczllMWREOUV6bExuRUVuTHdw?=
 =?utf-8?B?WUJRK015bUk5K3JUaytSZFRVa0tOVUxPdXQwTCt4UzJFZUZBbkFReC8zcnBk?=
 =?utf-8?B?RFBoNUx1ZFJIV2k5R1BXZUhDTnJHbUEvbGZvK0JsSGdkdlM3Zk0zRVZwei8y?=
 =?utf-8?B?S1FIU0hjbTU1TGtWY1RqY0NYcDdTWU45dW1pVkN4VkNjMzQxOU0yZjV4d3kx?=
 =?utf-8?B?bVlmZUVXSUk1dE1jU3Z6M084NHlvLytLTXNWV1N1Uk9pREE0RVEvTEd0R09K?=
 =?utf-8?B?OUNBSjRwclFhVjZmYW03VURzVTlDcFlqVytycXhMYW1SUlA3dGIwSlpZa3M4?=
 =?utf-8?B?V3RUeFlTV2ZRVjViL1IrSjdFNldUa3lML0dPM2xkcXNGNTZjNHdEMitUVTFa?=
 =?utf-8?B?bmFEZzB3Ung1cGh6TG9nbDlLQ2p3eC93Q0pVZWdsc0UyOXlKVElVcWJsSkdl?=
 =?utf-8?B?Ti9FeVllbmVLbUtpamg4L0N3SExEK0NlOTNSRWczSkZjTEtCL1hwS1hMTVFo?=
 =?utf-8?B?Yk9FNUhMOWVlWGdnZ3Bob1E3NkRiY2RDR1VWVGRueEh0VG9QTXdMMzNyZ1Vy?=
 =?utf-8?B?WUlEQ0U1WlArRm1DU1Zhak1LUTBBWXkwLzhWbzRjZnk0Qyt3YVp2aklMRElp?=
 =?utf-8?B?S3g1WURVa3o0cTdTdmtKeHZRVEtvYTZMMURFSVRCVGlkUFNwRVVsaXZRb2l0?=
 =?utf-8?B?d3YrdnBQRkhheUUwajRHbStWekR4RmVVVDBvOWFqcTdGY2MwREFISXFTOXpv?=
 =?utf-8?B?Q3hCS25UUkprS1JwS0pEZ0p2T25JZWk5ZzNreWF6KzlFcmVvK1NndlJuUXlD?=
 =?utf-8?B?RS9RK2ZYaDZtVDBDUTVlV2U2SENTa1NYVys3aWR5ZDRZOTNJcWkwTTBWN2Yz?=
 =?utf-8?B?aXQwajBrZDVYdzIwcmZ5MUJWSFN6TTJsS3lCa0hoSjVhbi9Zb2NDMExmVDE5?=
 =?utf-8?B?V0JUdmt4c3k4K01kSzczazJ3eUg2WWdCT0NKRHNvODRCNlgrTHptakl4RDhR?=
 =?utf-8?B?NG5wMkYzaERLemZMc3NsZ3NqdUYreUlKL0NVY2Rud1BoT3pTOGowRFVtT094?=
 =?utf-8?B?VGM0WG96YTRFOVpaOGxDUDlTemNKTVd4VXVuYUtqeEhIZElvVzVVaHhST3N0?=
 =?utf-8?B?UUUyb1BNcFFTMUlZaW1kVkRONkt4VVJodFRPQm41Vm43dlJuQjhPVGsrRGVM?=
 =?utf-8?B?cGtnT2FXT3doS0NXT0ZQVjloRk5jQXUrWklhcndOckFUQnpkK01PNDNIU0xS?=
 =?utf-8?B?M3ZWQXpPb3hWQW1UK1N1UFdOVkRpSTNyRGt3OU1DS2FUT1c5OWgxUVkzdXpn?=
 =?utf-8?B?bzR0dWc4Y20veGNIQm1yQWorRXk0L3F3MGk1OGpYVEl5RGdZclNUejR4U0Za?=
 =?utf-8?B?enp5NnhXR29sMWtpdnBRU1dBd0Z1SVRPTnZCR0hSUHJOODhOK0E1MDZIaVM5?=
 =?utf-8?B?UWZHZmwyUGdabEVWQUpuaW9zLzBKSDVmTWk2NndZTmIrVkhKOW01ZSt2N0tq?=
 =?utf-8?B?WWVXYzJSQThrVWNnL0RabWFBOFRXaFpLVkwrQ3h1eDkyTjBNQUFrN21VeGt5?=
 =?utf-8?B?ZFE1aUs1SG90KzBmdm40NWxWMEZONndpQ3N4Y1JiVS9xRzl2YTRVSnBSWWNU?=
 =?utf-8?B?a3hvT3FQUTZoS3Bad3lKWnQ0UklOajR6MjVvU0Uyc2YzeXNZaU40OVFscktv?=
 =?utf-8?B?ampLOUhselZCVlgxM2ttU2RxT0F5QXo5Q0RLVVIwS1ByNGdHdTdBdUJlS3Qx?=
 =?utf-8?B?ejkyUWlucE1VaGppaERZL0l1VUNOTzJ0cEw1Z25zTkN4dHlxbk5FU2U2QWto?=
 =?utf-8?B?OElXU3lraSt5OU5DU3FCTVJVd1IrMnlqMFEwZEFOd1RMOXh6cmNQYUdwSldw?=
 =?utf-8?B?SDZ0ekdBTitLYnRGaVBGUGJXejJZVlNTMzhDN1NKT0dWclBYcm1oRUg2UXdJ?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 49020a7c-5da7-445f-fdcc-08ddc37a2f03
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:32:50.1756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tjkh31mYzBBpnmwok3LX0oOwYy1FxrIBaRSWQ9CCBk6V8e/QnQd8kS2l/HX3Cd9BEzN0bZxNe8VD2Zf5op+4KSjZrrrkwliZmJxkuX6cNEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10110
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

Hi Mark,

On 7/12/25 8:54 PM, Mark Kettenis wrote:
>> From: Mark Kettenis <kettenis@openbsd.org>
>> Date: Sat, 12 Jul 2025 12:45:58 +0200
>>
>> Systems that use clang may not have gcc installed.  Set
>> HOSTCC to cc and HOSTCXX to c++ like we did before to make those
>> systems work again.
>>
>> Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> 
> Just realized I forgot my Signed-of-by tag.  So:
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> 
> Or should I resend the patch with that included?
> 

I would recommend resending the patch so that it's less work for 
maintainer(s) when applying the patch.

Cheers,
Quentin
