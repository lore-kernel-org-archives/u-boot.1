Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAACCA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 09:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC29D88606;
	Mon,  2 Sep 2024 11:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sbbfPoD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B6888717; Mon,  2 Sep 2024 11:54:01 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF10E88606
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 11:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/jgYQZGDUin2t5WP3aovnmqorZkrIKB0J/LJd/FFLp7ZM1EkkDbBrSLd5sHNrxM3sIi0EPQ3Bw4ma8vPUjvB7YBSDfewKagZ2GdCTLN+eoXzkRJe5K6teSsiGvc7C0p7f8+2+4AzEoalfC/GO5N7Hyjb5AmyE+HYLjO1Y3WGkMzKRo5IHVnnfU+ruROTqMeu8K/tlrSb1zQN+jZuwI5/TsaHAoc8+nP5Sy6a+XxO8koZt2+E+RJpRU3K5kdTdupJ48pdvdyMZtTxQlwRqvSf3NxII5gchXxsfEVKH9Xb4OyHjpyW5RQLUFj2MotER/gPttXSrS2mH1wMKslk8ib6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU1VjqWVR5QzxQoG1uyiYNALgx4hd0wZg/o/YZBG/DY=;
 b=cu+pNvgM/Wm4Dc+5UUmzbv3TR5Kv0UoUkUrC0WlDX0gtM6LekW18gfa4dpDnYz79R/lh26euGO3X5T9KT8uqx96kGCcnUVVTnSOuHVoBq6D/OtRsNhy8Qkv5A4M27uEYKai9YeHtx+nv1ykTkm+d7vHxoVZuMd65WSknlER1eJtQUy3OSGfFhONfYrES+JfdStinm0BYFZ17uFJvZ7f2GlH5zNooxcEIaAwpCjUE2jiHJjCA5sKAFMnw/nY1zMovJBVU8+SC1LJEYdRDPo4cXuhjzDA39aIL4o1gG7pRg36D0b+N9loGRvsJiHFP6Y5lh7vPCe0ULsRiAq4ARTRtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU1VjqWVR5QzxQoG1uyiYNALgx4hd0wZg/o/YZBG/DY=;
 b=sbbfPoD/tbAInhC1bfHPsVxzuZqraWUyNYKcRFznlCCqucGpybn3vylZL8gaF9sSa5l9xSeCKQWHMoP29KK1VfcmRrn4sHcJFbPHU9xixl/f3Wy8ZxtTpNcoVM4xigCV8vPTbeYPQtriKk6XSFaEkZRlK5HFBQWFUJCy2w7AMPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Mon, 2 Sep
 2024 09:53:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 09:53:54 +0000
Message-ID: <cbf15d99-3869-4e14-813f-318ddfda9df0@amd.com>
Date: Mon, 2 Sep 2024 11:53:46 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] usb hub changes for 2025.01 next
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0037.eurprd03.prod.outlook.com
 (2603:10a6:803:118::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: f418600f-1c2e-4965-febb-08dccb35280e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzRwb0NSRi93enFzR1htN25RYmk4VWdSMDJTTjBlRnVaVG05UStHRDNBQUhM?=
 =?utf-8?B?YVZNclBLUHBjcDJrbkJyT3FOSTh5c25MT2liRGNoQkc0UDJUWitDL2l6NDhV?=
 =?utf-8?B?M1FrWUNqRWw1bjJEQVBNUXJ6TlF1NG9GRExSR2JJTVBhcEs2aVBBTHhNaGxq?=
 =?utf-8?B?d3FEMXFHSmNUY014RWdkdzR0WnJEK2VXZG80RFpWVG9HeElwVC9nMU55QXQ5?=
 =?utf-8?B?WDhubVFTNkYvTmsxTHZUU3R6c1UzYjE4MkgvT2lJVEpSTENhQ2tJY2l1ZEwx?=
 =?utf-8?B?M04yOElDN1RLTThPdTRlRmNkSVRWQjdnaVBvZDBvRkR4c1docHJlQkI2OVVl?=
 =?utf-8?B?cHR0SjdqeFVZbWJSbjd2SGR0c29Qcjc0MjZjTEhlaEVFQm0rcTNCWmtqTng2?=
 =?utf-8?B?VDJhLzJFWHU4UzRVTEdPMEVieHN4UTRvVnJaaTdsTDRoQk5KWG13QUdwaUhJ?=
 =?utf-8?B?UnlCT2FLVllzamhIWjdmeHo4OVRwUGxJRU9rdHJNaHRhN2MrNzhqSXhJSzg0?=
 =?utf-8?B?eVJMMGhEL0pSVnJnZ09HRG0zWW9DcWxZeUZBQWtIVnc1MUYxcU9nMmE2VzJ0?=
 =?utf-8?B?ZlE3WVNWQ002MEg5YXNLQStXeDh6WWFnaXBFN1FqMUJ5R0wvVGhMWEowRXZ3?=
 =?utf-8?B?eWNFUEk4THYzT0JIZlJUMVNWSXQ0NmxiT2xMSVBkUEhWR1JySEFSOFpuVXJq?=
 =?utf-8?B?YlduQ01ROENFNHBDeHNRdFhqVmNHL3EzK3NQQmhqSEpReW9rUG50elRWRFZS?=
 =?utf-8?B?dmxqVGN2a2ZBY3pGTWR4Wm9LUC93bjc3K1NNVXo5ZmlVQmhwK09LUmh0UFpX?=
 =?utf-8?B?aG8xRjc5dkRGZjJtYm9EZUp0R0djODMxNUtzOGMrOFpmcGZ3ZmZKMTZDa2dV?=
 =?utf-8?B?eUV1UFZTNWtOdUMrM2FHb0M1TWxnMGtyWC9VQ05oSGROY1VlSzFtUVBIQnhu?=
 =?utf-8?B?TWNkUFdMQVV4WGZhSE9MR0JCZ0k3alc2anZ6elhvdzBENjJGcEhGQnpDNGIy?=
 =?utf-8?B?L1hXUGhISnM3OFIzd2liQXhPV0VlOUF3b3ovUDBVM2hBZW1VTTlQWjAzc016?=
 =?utf-8?B?YjlJbTNFeFprQVpERVVwcTBaNGg3ZHRXL1RuTWErZmRrb1IwY2p4b2VaOFdU?=
 =?utf-8?B?WFYvTW4xSHplRFFDdWpNNEpwRHl3YSt1WU9wcTNyelBvVGVhUFRwbzhrRUx3?=
 =?utf-8?B?YUk4bXFIQUhJMEx2SmFLUlNLSzdERWdFTEl6LzFtUHZ0UklWck9wRHhpbWl6?=
 =?utf-8?B?TmdaOHRyL3J4SXBGa2pBcksyMFlwdlRidXlwam96RmJDbWYrL21ld3FuRnEx?=
 =?utf-8?B?MjUva3B3WTMzTFhJYUZ0cHg0L2Q3R0xab2FISGJWUTVYQWxWZkNkL05WQlVN?=
 =?utf-8?B?bWRoeEZIY3lJM0NvTFRiY0g2d3RRTi9pdjhkQ09CclphUG5IWGZNVkJXVTlB?=
 =?utf-8?B?ZFhjUnRDd1ZEUlFRQ201djdWa2s4aW5sOEcrdzZkN2NlRWhQc3Q5OHJFbkRK?=
 =?utf-8?B?eXFhQkk4K0pNMG5jZW9NbHBCVXZvczNyYVg3WHZ0d1JhNzVTL0hCNjhRMU1U?=
 =?utf-8?B?UDBwd1YyeVV2S3VoNERnUnIwVzVwcjVxNmZLaWVoRG9nM1JFVTFoZWZmNTE1?=
 =?utf-8?B?N2hydElVUjM4ZHJPSElqYUUxRU9tUXVVajY0M2xBbzRwUmlkSUROYUpDWXlF?=
 =?utf-8?B?cTEvdGNkb2N4L1ZaaE1TVWJVbUtjSXptSllJVUcwVTUvRzAySU1aUWMwUEFm?=
 =?utf-8?B?UHhWUkNXTjlET05meDZHTVF6c0g4MnBuM052TEF0cVhvVUc4MTFMeVRMSVFh?=
 =?utf-8?Q?xmghbQbA4l8bm00pgrdKc4V6AUTm/GTC7xZjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09UaCt4NThLc0kvQ2xDK2cxT3FmUCtqeVF2NFh2cFhZVEo4OHNRQ3hRaFp6?=
 =?utf-8?B?aGVFa09YWEI0d2dLM3VzUWFvQWplVHVOMzBFWTBCQ1dOanJmY0ZRMTlOWjlx?=
 =?utf-8?B?dUNmRVJVVWlVbW9pWXlkbU5jOXBOemhxMHVlVE5jZmVucHJwZWtoL2xtOUND?=
 =?utf-8?B?dFp4c1Yydnptc3lrMUNHUFh3aWxJUWo3ZUtUUVFXZGR3NVJQNEx1amNPSW11?=
 =?utf-8?B?eVF0V3FjQjdvbFhvVUJTWGlna2UwVmt1UHNmVy82VFFYZ3Fva3ZFY3hMd1Uz?=
 =?utf-8?B?TEkxWkt3bXBoY2o1bDRkNGFHWExmRzloUStlUit0a0dTRWQ4MHNhakNodUhP?=
 =?utf-8?B?WkRuOTkrNVg1aHFwMXc0RWh2YTJHc0hBVmM2SkVkL0hVOXBIZ2p1YjZ1djBP?=
 =?utf-8?B?RnZlTUNrMkNIbldGQzB2V1Fza3RRYzlJUEVNNkJSZnk4bEQ0ZmhyWXo2enhU?=
 =?utf-8?B?amM1TkZZYzlIMzJBQ0kzZ2lGb0E0eWhoVHJxUFRKVVVMMTVWTjA0RncwVkpK?=
 =?utf-8?B?S3FpcWx1L25EVmZxMllQNHc5d1kxdlhwNHNRK0pHNCtZV1BRcVpXTHltZ1ZS?=
 =?utf-8?B?a0t2S3U5dHpnT3dFQlJ2alkxTGZuaHBzWndoTGZCOWgraWZOQlFlTVRrdDQz?=
 =?utf-8?B?R2NGb2RwTU5MQ0I2NENaZ0lWakdZTkUwTzh0UmozNFZydk9UeTJodkhpTkFF?=
 =?utf-8?B?WFZjcENvQXV4MHNJbGVQQ0pVd01pd3Q4djBINm8wOU5QcnZYdEpSdklWeElt?=
 =?utf-8?B?bFJ2ZHp6OVV3QU9TQStqK1FEK3h1dzV1SkVLVEtUaEZJQ3MvaStHNUJxTzIx?=
 =?utf-8?B?Sy9zVVB3ZGRVVmNQamRmU3Z2NEYvWnVzY1BsaUZlZm5LR25qNk5BRU5GbDRo?=
 =?utf-8?B?K2N0ZlhncXFEYWZHREZvNFJqZHJaMFlWaE16bGd6RGFRWmE0d3p2Q05pTGFh?=
 =?utf-8?B?V096N3lLSzM4ZDh3UEM0aVVWWnNOd3oyZml0elRkVGJCMU5yWDJKL0VMQng5?=
 =?utf-8?B?WjFUZmFRcjhDaW4ySlE3L0JsdC9XcGx1NUpGb3d4NkQxUFZKMTF0KzhGUitk?=
 =?utf-8?B?UEMxajBaejZ1UTZuaEJQekdNSXA4U1ZoaENiZ3h4bEROVml3YzNsaDNIeDBS?=
 =?utf-8?B?RnpISEdWZi9EMy8xdVQ4MjRVaVBManQyNWUzZmZEb2tRLzdRN1dSek1XVEhz?=
 =?utf-8?B?OXIxWlJQT2JqS3JMM0RxVnQvN3BCeUFXb2JJMWZBZi90cWhaMEhUMmhUWXRL?=
 =?utf-8?B?MlJuSFNsRkZwdmtRMTBMWURRTVNENXdSTGxhemlkbS9RTERjQ3RDb01OSEtk?=
 =?utf-8?B?eEdMRTBsVU5vL20zeUtKeGxVTjloTHlNVUJ1YlBUZjgrYjVWMXdTQVFtT3dx?=
 =?utf-8?B?VE5BY0lQR1Y0Z0tCb2FrTGgrLzlxSGdFZzRmN3ZrTWMyZWZ0eWVoMlZJSXJS?=
 =?utf-8?B?NDlTNHo0QnlVdUpjeHRwbEQxUHdBMmdPOUtyWkpZdFR3bElGNnd6OGYvVmZx?=
 =?utf-8?B?M3BmSDU4T0VVSDJzL0hSZGZrRE1SV2dFc1YvNkRqTVNvRFc5MTR1MWp1UVJZ?=
 =?utf-8?B?YmRxMXFoeGJPenBtWFlLSmNjNC9NZVBvQm5aRzRXcUNYV1VJa0RrWDFod3dZ?=
 =?utf-8?B?K1RlZUM4MjZuSzNvT3NuK01MQmt0RDR0QmlsQjI4OVQrdVdjOG5PV09ydkJ4?=
 =?utf-8?B?Qlo2UXAwMWJWMHUrS0RNRGd3amxPd1AxVXhiR3lVQjY1WHRSVy9kdlZ5SHFT?=
 =?utf-8?B?V283cHVydldCaGZ6aW5zeTlRaDFjaWluSHY5djhxRElpSnJRNmhxVmdhMzVI?=
 =?utf-8?B?TDE1bFpYNUR1bVVnR1RmcDFsdlBaYiswNGVRWTd6NktXUmJHQmtOb0d0bDBw?=
 =?utf-8?B?eVRWM1A5Zlg2bjlQMS9iYUJVL2F1Ty9UOS8vZXJ5bGV1QUNkN2dXY0VRQlBr?=
 =?utf-8?B?K2ZXQkZLOFhrMnRGWlhabG5rbGJSdWZWMU81c2xBV3JDcFgzN3krbXhBSGIz?=
 =?utf-8?B?b0JaTjcwbmJiaFYvMlZkdlhXTnNuMDYzYVRieG1LRGxuc0h1a3ZyNG5NYXM5?=
 =?utf-8?B?KzlHSUFhUWNzNFVYdk5EVDBKTW9PM2V2TFF2NkxzSUlJcURMQTYyMHpaeldQ?=
 =?utf-8?Q?AbY2ZHFfWZGz45UE/5KNXc1n0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f418600f-1c2e-4965-febb-08dccb35280e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:53:54.7960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzDhuhgqO1kIf8ajY3XPnRZxcq0DoDaTSdTj+rJgxJz/LoRVSpKGKjVVEFABP4Bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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

Hi,

please pull these changes to your next branch. Changes have been sent for a 
while and there was no reply to them.
Here is the thread.
https://lore.kernel.org/all/20240605100221.3571-1-venkatesh.abbarapu@amd.com/

We are doing the same changes on Linux side and they should be merged soon
https://lore.kernel.org/all/1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com

I also queue them to gitlab CI and can't see any issue.

Thanks,
Michal

The following changes since commit f0ec3e608902ca1f573e5b7017da6bc804483f55:

   Merge patch series "Add support for Ethernet Boot on SK-AM62" (2024-08-30 
15:55:06 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/usb-hub-for-v2025.01

for you to fetch changes up to 97cbb90a0caa5876bdf0b8d1a0f251f80c9eb77e:

   arm64: zynqmp: Update the usb5744 hub node as per binding (2024-09-02 
09:24:50 +0200)

----------------------------------------------------------------
USB Hub update for v2025.01 next

Enhance onboard-hub wit handle usb5744 and it's
initialization via i2c also with optional reset.

----------------------------------------------------------------
Venkatesh Yadav Abbarapu (7):
       usb: onboard-hub: Add reset-gpio support
       usb: onboard-hub: Fix the return values of regulator APIs
       usb: onboard-hub: add support for Microchip USB5744
       usb: onboard-hub: Add i2c initialization for usb5744 hub
       usb: onboard-hub: Bail out if peer hub is already probed
       configs: zynqmp_kria: Enable the USB onboard hub
       arm64: zynqmp: Update the usb5744 hub node as per binding

  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso |  48 ++++++
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  48 ++++++
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso |  18 ++
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso |  25 ++-
  common/usb_onboard_hub.c               | 176 ++++++++++++++++++--
  configs/xilinx_zynqmp_kria_defconfig   |   1 +
  6 files changed, 304 insertions(+), 12 deletions(-)
