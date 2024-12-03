Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9AEE74AC3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 17:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A208950E;
	Tue,  3 Dec 2024 18:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QJlXT8E5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B2789538; Tue,  3 Dec 2024 18:02:20 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FE8894F0
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 18:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmBApzcCLoeaPr4UqkoU7evxkC1YLIoWfE1qQFxh+58OEZ9c5gQyJiWHoClgYRDFrztYzH3slOhkx49PSKMVZyGl/EcOl7ILnficBMs1dOMY0zAxiUKWR2YgHWzdc/czXrXd93ek9h2iBgDWdASsjll5hWdX9eBkfVQlYX9ZGUiNd4E2QJN3FeMM1O/o18NkUoEu7lzaQzaGpBwryx6oxZ31UdWktbo3byG6qnaE4zgS1+eJ/dOi6uVqgsN+eyMhpSpq3qaQMdK2mDLaJ9SsF5fux9xl4xWK+9OR63yPZPPGOC/kgWgYL1eA1fO+2ARjLZiIOejaPpBou/4ZMk9L4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffJaorDxywUF9gsSNetWy9I20UYOpADibRUDRObxbYA=;
 b=mI66sE5LHdeJCR8XPP7f/hHDbVuXy+tTyd2aAk/KjYlMhoGdlMVsLLRAlgt2lbeqi5Jy03lkkTFTjmwx8padVhJs5uROqKYlDacGV68MRQuPCxI8enK1PCUjaN4KNo7MlglTXi9y5AM7UarZjU/y4AmJlWo6ydVAFncmCs2KvEcy+RTUhZD0MTsvbC9oAEddYF9yjLvYdDC8i78Qp891Kca2QfGZqI421SfPyBwTp5sxz70lYPTY4H7INVmP9Jb+hCFuxO0QYL2KrENHY85lXlA8/eI4q31eHkjiCK0bvfbhdynM3/2lMFEJA48ioBd8cuXfjxuTxG0ujoy1YA7WLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffJaorDxywUF9gsSNetWy9I20UYOpADibRUDRObxbYA=;
 b=QJlXT8E5fyUp7tAeEazQkvmpMqhtCyfpp0AtO9YitmqBbR3IhGCkijrr8v3DnCj4XNHuddoq37HBbMge/Nzf/Y6DQHT03WSHCiYTWlUa2wIgEiRAWDadP8wc0NxZIN+xEVChroxINC4S7Q30kz+aa0YuHNzT2xv88EtHS3+VamE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 17:02:11 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 17:02:11 +0000
Message-ID: <fc165f17-36e3-45f9-8522-588cd6fa682e@amd.com>
Date: Tue, 3 Dec 2024 18:02:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Update the bind function based on
 "peer_hub" property
To: Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: fabrice.gasnier@foss.st.com, git@amd.com
References: <20241203044950.119197-1-venkatesh.abbarapu@amd.com>
 <d1abaa7c-cf34-457a-9b5b-f665b0fa4790@amd.com>
 <eeea93d6-c006-499b-b999-e50604669166@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <eeea93d6-c006-499b-b999-e50604669166@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0150.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d98c3d-896b-4045-57f8-08dd13bc3a50
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjVEVmpCamt6SDhHU3ArVnJQVDVTVjEzS0tvWlJSQmx0YUlWOGRCV0FTendR?=
 =?utf-8?B?Y2ZtS1ptRkQwYmZjYWNFMWErWGdWeSs2aVJ3MHJPbUg3OXNGUXRCZXhwZUMx?=
 =?utf-8?B?Y1pyOTZhSTBoMzA3NWdsaVl6TlhESzFneVhKVVpRckRUZUpaeFZvRUh1Qm5Y?=
 =?utf-8?B?YmJMQ1lDTUFtTFVnL2Y0Tlh4dmdOWjFlZFU3R21PUGlTM2xrNmhZc0YrOTFk?=
 =?utf-8?B?dU5mRGoxeXlKSi9odUtUQnQxbEZKSlBId2NRMXVNS29KUWZOUXV0VlNIZThM?=
 =?utf-8?B?RUIvcVZhQTBOOFU4bnYwei9EdkluT09uNEs5RVhpOStjQ2hycFE5RWxKMStq?=
 =?utf-8?B?U3dpNnhibWdwemNWT2xjd3hUVDJiOVZhUC93VTF5THE1ZlJGMHpvZ0lQQTFy?=
 =?utf-8?B?TjIvMzExNEk5RG16WHErNUhKcm1hMi9EYUZZNG9EWkFPUFE1akV4V1pPZFor?=
 =?utf-8?B?bzJoUVBJMzZaRjdJd21yNmdSaXhWZEFmNVQ2OGV3bEFXUy82NGFkUzlnTmJR?=
 =?utf-8?B?SUQ2ZXgyVlZ6V3E5WDZYMkZEaDVpejBlMy8xend4Rjk5RkRLR2F2MWxrWVkr?=
 =?utf-8?B?dFBySjBjYzAxcEVSNlQ2Tm05TEJmY0hHOW5UdVFKM05zMDVWMW0xMEY4ZXVI?=
 =?utf-8?B?c0NvTWV5bmxDQkk2MElFZEV0WmN5dGFYU0VCdCsyR1lXaVpkWWlXOUUvbWN0?=
 =?utf-8?B?N0x1MjBDSjdqc0VVZDZHdWt2Qk5MbkJZRGV2MjRUQXF6VFJpcXo5RGpTdDBO?=
 =?utf-8?B?eEN3eVJ2a3MxNnhIcEhjcTUwbGZFWXZFdVcxRGRrZ3ZSb2VkTWVFR3hrUDl1?=
 =?utf-8?B?elQxNVlGVU54M3I2bVBkQWhXNzVYTWxINm9BYVE4WVZBaFU1czMrdDRiekJv?=
 =?utf-8?B?NXdwcGgxSE9jczVoU2N2RnFOd2J6RkVZSXFJZ0lnUUNNVDZMZDJ3VVBrSVFD?=
 =?utf-8?B?WkZaclR0bm0vdVdTd0h5U3kzbDdwMHlrMmg3Z2pGVkFBSWxzb08zeW9hSkNl?=
 =?utf-8?B?UzNnbUo4L1RZb3lFaW11SFpLemoybjJidDZNTXVYaHpqVGx2c3IreXNhZ3NX?=
 =?utf-8?B?K2w0TmI3Q2NmUHdoZ0VUY3RVUUtmVXQzbkZwdGpDTkk1UStteWgveU5pay9p?=
 =?utf-8?B?UUxXYkhFK2VzZ2hEVCtiSDhhYXZ1ZzFiZE5KOVpDVERXbmE1dFRmVWtDMjFX?=
 =?utf-8?B?K0FGNTUvTUpiNFRSUldFT1J6enZUSGgrSUo2eFVydFFuSkI4TThsUUR2ZDRE?=
 =?utf-8?B?UzNHcDVqNDkrN2IwWUN4cjVVZ3kvdVNJR1ZxZi94TjkwK0lmaVp2VWRWU1l5?=
 =?utf-8?B?R0FDNHFSeWxnQlpLRnVpUGtnQ0hBMzBNcXJzMXc0VDduUVdlQ0VWdjQzSUty?=
 =?utf-8?B?NkNHaTUzN3FsNnRYd1JUK3Z5RXQxd3FiRnZIQkJQY2U0a3RGcGlBaDNpOXNw?=
 =?utf-8?B?RTVJQXN5RVVGb2hBWXphRnFRWXcyNmZtM2kxNTBkMzhoLy8xdCs5d1VKYjMz?=
 =?utf-8?B?eXlPakhSb2tTa1k5TWZRckdXbGd1b3VSV1EvWitEeEQvNGt6OHZobnQwSEpZ?=
 =?utf-8?B?REpXTGc2K09JK0w4Rm0vcWduckxWY1o3UXI2bWcwbW9wbnRKWDcxU1JoRURS?=
 =?utf-8?B?eUtnbzI1QUo0YTJIbFJXTmVZbHJ6N2dpMVRGOTI4bHFudEN6UzRoNVQrclVv?=
 =?utf-8?B?S3FpMUNjRmJVN0c3QkFNN2dsN3R3NVhxRk96Q09GdFNJZk5UTmxQSmFnRTU3?=
 =?utf-8?B?cngzMCtEdDN5THB3QVN1VW5MM3NZTFhFR1NnRFROUUd2QkNtcVJGWEFFUjlo?=
 =?utf-8?B?TnZDWVVpd0htNjlVd2Uxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0hkcTdJMEtEeVFWczNsRG5VWVViVlg4S29RTDhGbExqS3J0L1RyQlE0anRo?=
 =?utf-8?B?czRnM0VzbzE0RkU3L2dTNXpveTlabEFXMGZBTDBmK2VMT1RDU3doQ0FmZHVM?=
 =?utf-8?B?SXU4QUVOVFdqakozNFJCbS9vcHM1emtjQmdLQ1Q5M3AzZ2Rhc3NLWjAxdmxD?=
 =?utf-8?B?NWVBeSt0bWNneGJPSkd6T1ZsRVJjSzdHNFJyTTFvZUZKb09KQ2NCYm44Z09u?=
 =?utf-8?B?YmFuT1B6ZnZiQ0NhTVZ1OFQrNnNxR2NKV3hSTGtESUh1THBjT1EyUWZZVHEr?=
 =?utf-8?B?RnlIZUxRbVdPRXlFbk9vWFpCNmRINERXSmFGaVR6cEx1bU5Kc0cvdkxJcndC?=
 =?utf-8?B?d3B4UmRvd3k4K2R5RWVicnFBMkdBZmk0MnMvUTZEVENNd3lxZWw3enpVU2VQ?=
 =?utf-8?B?aVAxK3ROTm42R1VCL3RCVVllVmFCMlpmSUVkSHR3UUVTOWF5Sk8zcGRwWEdM?=
 =?utf-8?B?ZkVVM3FxRFNhOTNDVUxQNHJFczU5YzdmYlVTdithL2VMSGUwaW1Hazhpd2Nk?=
 =?utf-8?B?b2IzcWVITE9VUW1LSFRkM3ZNcHRTM1d3NG5Xa2YwRjVuUFVpSHlPNUFoVU1Z?=
 =?utf-8?B?Q2JMSS9rYkRnS0NIRlE5Q0NobmRpdDl4dmp3SDRQTWhKNEFFRUpJVDZaMmxV?=
 =?utf-8?B?Q2oyRjBmZFBmUDJOVGZQYWZTVDRDcm5oV2I4Qko1cDZDVTJTbVBrY2NRekVY?=
 =?utf-8?B?M2VYL0Vtb3ZJeFFMQU03UUxKVUZFV0tvVFNMeVJlTXkvWmtabUo2TDBPUkI4?=
 =?utf-8?B?ZmlSS2JKeXRNQWJmc1hLMHF0ZTFDTXBoU21JTmpaUnRzVDBmbHduaW9YOFNi?=
 =?utf-8?B?WlhOL2ZaaXhHMUlXT0JLdlZxMVlEbkhJdjZsQmE4VWpnbWgzdE9MWHBjS0tv?=
 =?utf-8?B?T3NCcGx6bUlVL2xhd0ExdjdyVTRXbWs4eVRZNlF1Sk9RaXl0MndnRnlDZ1NV?=
 =?utf-8?B?blVldmY0OWZOV2VGWnN5UVFaektLMERHV0V0OUpYSjZ4L0dYYktONTY5MTFK?=
 =?utf-8?B?NytEQUN1TDQwZWFYVzQyK3p3U3ZPc2tsY0FNYmFQNHdDTGpySHFPT2k2cDBt?=
 =?utf-8?B?YVZuVFNlZXczNU9BcVVzNzltUjZ3Ky9kbkxSaHdzbjBDWEJQMlgyUDdMRlVF?=
 =?utf-8?B?UFVpVnpFSm5tdmgyV082L2c1WjdpYzFsTVlzKzRTODkrOW1IOU5VN3JiSFU5?=
 =?utf-8?B?RlZCRDdxUnIvS3V5b3BNQWw3ejhXdmp2aGlqRTFkc1Vjb1U3WHk0YmdlV1Nt?=
 =?utf-8?B?bi95R2Ria1cxejFmM3VvRExiWDlVYlBEYXRvMzkzODBjeTJFSVg0NlZ5aktR?=
 =?utf-8?B?ek5LVmJMcTkyS0l4UkZGdjRXbHJ4Z2xFaDM0cGNoOVNYcFFtWEswRkVKNVR2?=
 =?utf-8?B?VGV3ajRYVHJ0d09uRTNjWE80YWJhM08rS3dxb2JqQnl6TDMxa1BvQkpTWGgr?=
 =?utf-8?B?WFJxWVhta0dhb2Z3WHNGYW55WUZmYWxZWE9sSG85Q0psa2IrbTFESVlIazBJ?=
 =?utf-8?B?bUtXelBGVktRVW5hZ3BPR0RlTFB5UmpvQmg0blRpQjBZOEpPajM4UTdDRlpt?=
 =?utf-8?B?T0NJV3QxN3AwcUtuZmpNSnY5L1lWeE9BYU1qd0NwQXFpM1lJSiszei9YTjM2?=
 =?utf-8?B?a1B2Z1cvVjVRNUlaS2VZRU9Gc3h3SEo4bURoSUdFdVJEMGFrdWM0VFpvOGw4?=
 =?utf-8?B?UmMxTUxzb3NCUXJuN2ZPWDNScmhSZExhYU82bGpxNkhoTmhRNk5saHZ2SWV4?=
 =?utf-8?B?MGZwNkIxcWQ3T21WcUpzanBhR3B4Y3ZsdWN1a1hmZmRlRzVIS0tPV3NkbHpp?=
 =?utf-8?B?ZnFRbFpTa3lLd3E3VWZYT3FuMGRlUEQzSy8xOHFWKzVBL0dBQXVaSzRabC92?=
 =?utf-8?B?bE80eWJUS3F2SUc3NDVQZXlPelJzVFA5eFpNcmhkaFdya0pCMEwxTzJIdStY?=
 =?utf-8?B?MEJNN2RmL0lhUFJ4eG9ZaVhlUmhQN051TWtlM1pJaS91SVR3ZHpsK2ZSWFd2?=
 =?utf-8?B?aElSaGlNV09KQVNscHR0blJqQk1yUS84cXV6YVdKRlBxU0s1NWlQdXBRd1RS?=
 =?utf-8?B?b0pHNW5tempWR0p4aE9LRkUvekEwQyszeXMrVGlWODNlRmhlaHQ5L1B6R2VF?=
 =?utf-8?Q?9lHVC5Ozj6xk3HilyefGdlf1p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d98c3d-896b-4045-57f8-08dd13bc3a50
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:02:11.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0VgxnGvB0YuPk1UExzgUwa0rw5n9k4ahbjHxw2tKZZesRQwfvZg4wVDxOEdyG0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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



On 12/3/24 17:24, Marek Vasut wrote:
> On 12/3/24 2:44 PM, Michal Simek wrote:
>>
>>
>> On 12/3/24 05:49, Venkatesh Yadav Abbarapu wrote:
>>> Add the bool variable "peer_hub" and set this only for the
>>> hubs which have the "peer-hub" property in their DT nodes.
>>> Skip the bind function for usb hubs which don't have "peer-hub"
>>> property.
>>>
>>> Fixes: 57e30b09fc ("usb: onboard-hub: Bail out if peer hub is already probed")
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> ---
>>>   common/usb_onboard_hub.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>> index 6f28036e09..0a8fac38ee 100644
>>> --- a/common/usb_onboard_hub.c
>>> +++ b/common/usb_onboard_hub.c
>>> @@ -26,6 +26,7 @@ struct onboard_hub {
>>>   struct onboard_hub_data {
>>>       unsigned long reset_us;
>>> +    bool peer_hub;
>>>       unsigned long power_on_delay_us;
>>>       int (*init)(struct udevice *dev);
>>>   };
>>> @@ -178,10 +179,15 @@ err:
>>>   static int usb_onboard_hub_bind(struct udevice *dev)
>>>   {
>>> +    struct onboard_hub_data *data =
>>> +        (struct onboard_hub_data *)dev_get_driver_data(dev);
>>>       struct ofnode_phandle_args phandle;
>>>       const void *fdt = gd->fdt_blob;
>>>       int ret, off;
>>> +    if (!data->peer_hub)
>>> +        return 0;
>>> +
>>>       ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
>>>       if (ret)  {
>>>           dev_err(dev, "peer-hub not specified\n");
>>> @@ -212,12 +218,14 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>>>   }
>>>   static const struct onboard_hub_data usb2514_data = {
>>> +    .peer_hub = false,
>>>       .power_on_delay_us = 500,
>>>       .reset_us = 1,
>>>   };
>>>   static const struct onboard_hub_data usb5744_data = {
>>>       .init = usb5744_i2c_init,
>>> +    .peer_hub = true,
>>>       .power_on_delay_us = 1000,
>>>       .reset_us = 5,
>>>   };
>>
>> I don't think this is correct solution. I think if optional property peer-hub 
>> is not present in DT bind should return 0 and that should fix issue on stm 
>> board where only one hub is present.
> Shouldn't the 'peer-hub' property be mandatory for this hub ?

You can use this hub with usb2.0 only or with usb3.0 only. It means peer-hub is 
correctly optional property. It is just saying when it is there hub should be 
configured only once not twice.

It means right fix is when peer-hub property is missing bind should just pass 
because it is just hub which don't use another ID.

Thanks,
Michal
