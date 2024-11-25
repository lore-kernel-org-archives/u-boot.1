Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AB4D58D7E
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E523588FE8;
	Mon, 25 Nov 2024 19:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U+qVvPMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDCC890A8; Mon, 25 Nov 2024 19:44:30 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C6BC88E61
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 19:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuekdiB5ZA9ocHuJDqY8MsPJ1AbBBqbSmguMPXxjMGrIRpPLD9/UVZAdWl5PsIuD10+XAKorvoBVA3e567EYCFlJK4qAOhwGukncgCBf7hPhVkgdYuhIXof7jc+sfoUg3/bSEUq+1TkaVg33s8IRHl4P22cPdUyhUYGQ2OzabuY8li82B5pxArbB9rpTSX1sRisAlUdQQuya5Njm7E5SzxHbtYc/1YaK6jaRjFpewE/Kd2UIlIf9QfBY9LuRgcuBp3wa7yvmjFu6t6baht89jn/H3T4x4YnMEvIF73pL8jfNOt2YrX4TzfDnqZc+44Kq3szYl4apZSkQs0s73bbGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOsFLsrt/ky0VDkxZNJyvlJhY0f7Iiwojaw3WhyjCHM=;
 b=XRibFMoGhlWLapqWvWB5/x4BQBSWNtfPutq0cv/HONE+/YGYdCAWB9361NvKyatY1dEFbevxUX+jqyEFfa7NMh5u+Jkn0KBK4aEXUmnwUQa/mL5SlKrbAVoTcmf7vfd+CJfpG4+0tgRQna7ncBan/mR+7wiOLCIMSR71GTnfmwPtGrSPEUqMOCeci3pKEHHBxS21jIGZf+9mDrkkuJllUw0O2zLj0JHFVYaIhDL+YAgaeAOcNuZlwrBhr3ncC8BSNFu/SdADf3Q7V/0O8E89wY0uCsw5Zve72hVMv1uFUeOU0CrPheaqUDZlhAnlET7MQxfmhtkBzS1LdurPhO8FjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOsFLsrt/ky0VDkxZNJyvlJhY0f7Iiwojaw3WhyjCHM=;
 b=U+qVvPMym5lHzUm0bJyZJpG0D5PBJBn/l7Ic0LMyiWwNHvjLazB9sdjKHwUPpEyDhrX1IL0ueWro621EwS78Kn+GmT/foWo/TtjPhV4D8OpQcsAdZKKlJOT4fYKhLViMVJttQ0Y1YDsi9xJDQcCyWgprwQB4en/5kSLHl8JWrMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Mon, 25 Nov
 2024 18:44:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 18:44:21 +0000
Message-ID: <ad58b032-f618-498f-8cce-f13d0f6d6021@amd.com>
Date: Mon, 25 Nov 2024 19:44:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <20241125180847.GK3600562@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241125180847.GK3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:510:325::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7c1e3c-fba0-4c33-6452-08dd0d812d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEpueVVtMkUxTWxld0JNWUNqTEhHbno4emE4bDBwUEYzWXM3ZG1xZUJUYndY?=
 =?utf-8?B?YTEveXFqcUpWaFdrZjlzenBUVS92QnZ4cisrbVNvdzQyZ3VWRWc3T2Fody9Z?=
 =?utf-8?B?a1BjSXQyekpHNkdzNFhTUU9kbmJxb2d2aDNUaG9NZitUWXVwWjNYZHRzUlI4?=
 =?utf-8?B?Y0haZytvSzhSOTVPR2FBV2pqSUxFcTJmRytqc0QvV1BZaEJtNTVIZ0RUNkRr?=
 =?utf-8?B?Q3YvV3ZBZzdQUldWNDhmSHRxNVRpY05CWENlM0JrL1VKZEZBdU1sTnEweE4v?=
 =?utf-8?B?MXk0OXhqQnhNbHBQRGNJM29OQVk5NWQ4U0RIczlnSE00VjJET3g0Y2hnTzMv?=
 =?utf-8?B?WU9yQVJ6aS9mYXN3UUNxUjc0Z05pWEdjM3M2aEd5OGhiejUvWTc5dXN2bmJz?=
 =?utf-8?B?TitaQnV4eFNxSUwrSEFDMGlGSllPUWpuYWFxZ05NcjRHZjBtaUdNTngxMW04?=
 =?utf-8?B?WkJzZTg1Y3hneWZkbWw4SWpKc20xSnF4VFZNSXNnMG52M3NTOGNFaTVWbzlW?=
 =?utf-8?B?dzRIZTNyU3N2eTVOVUNRdk5ucENtNWhtMlFQQUk1eC9BaWgzUmtNR250eGFn?=
 =?utf-8?B?RzJZcXE4a1ZrMUFzQzY5Y0xxYzFuTjFkK2N1MEJDMDkvWE1zd2pjdk55VHdm?=
 =?utf-8?B?T3FxM3JLSFA0MTJBZk9kMkJnekZIVTZNd3J4TTNoc1ZBdjdydXBtK09GejYx?=
 =?utf-8?B?V3dweldPWmVnQ09lR0pTNmRtNThxdm1WZ0U1aUx6ekp4ZmR2T005d3ZveGlV?=
 =?utf-8?B?MFZJZklyUDhHK1hZWitjR3g5MFBCaUMzNW5qSWd6YU1SQVMyMS9WaEdneFdh?=
 =?utf-8?B?RCs1ZWtkNEZoREFTV05aOWF5ZXRRS3dpdGhSUVFSNUVXT3ArcWZFTWZrY0RI?=
 =?utf-8?B?K0thUk54TDJSY05rWnNsSHl2SW1uZm1PODVmdVVIOXMrSTJlMlhSb25zZzZP?=
 =?utf-8?B?NXM2TjJnU0hoTUZKM3dsMkZkU0cwMW1NMWdibmlaWTAxemp4YWVPa0hXVmk3?=
 =?utf-8?B?TG9pTW1pdVJQaEFsMlJyK2RqWTVuZG5jK1ZXbzRseVlRd3JQZ2l0S09qK0Fn?=
 =?utf-8?B?YmtaUit1ZTZqY2Y5ZVpwV3B1TVo0cis4QlA1bXFPQkZuenJ1RytBanJkNlBw?=
 =?utf-8?B?cEFkcjFlQzA2a3prWkpFczllQTJNRmFiSTBpdk1HK1pzRmVvaW5oY2p5Vmd5?=
 =?utf-8?B?TGlwaFNiQ20zQXhpMGgxRlMyeGpuVWQrNE9zWHVjUnI5QVhIWnRxZ0l3ZlEr?=
 =?utf-8?B?UHlyWW9rdi9GUXg5N1lIazcrWTlFNGUvVkY2ZDFxenFTOU5ENUZRcWIvL3VZ?=
 =?utf-8?B?Y2x1RGpyMGZzR202UlVsdjdCdk8rbkQyTXIyNW1qckVrV3d6NDNmd1ZtK2R2?=
 =?utf-8?B?eDBBdERRbTJCUFd5RW1pWGV4bXJoc3hhbGRRNEFxblVUZjJ2R3Q0bnBOZkpK?=
 =?utf-8?B?NmRkV0tZM3JPTFlBTWdsUUlzRU1yZkhpYmJzU0R4bmMxUUcySGVvbjE4VGRx?=
 =?utf-8?B?a002MWloejE0dGlRcTZnNWRKWDh0VDFTM0V0b1Q4ZWtRcnBCM1lMRHYwQjZZ?=
 =?utf-8?B?R1IvK2JFS0xzMjZ2Sit1UDdtZVQ5bDdBdGxmUnF2emZxNFF5WnFYNGdiaThV?=
 =?utf-8?B?WUtCc1paVjVTUHFJcm5kSHcxbHRrdllIUnRVdXFuTmlNOHhQQ1ZicHZiVWY2?=
 =?utf-8?B?WTNESFlXTk40SlhXZnlUL2lzQzVPWWlQZENXRDZoTWZ3VGE3WFBBdGlyTXVQ?=
 =?utf-8?B?dmh5SzhkT0FSUkUrYUFMamJ0eFRqYTVHTXN4NnhzK1MzRnRPTVdFbXVFbUk5?=
 =?utf-8?B?UXl2R2l5YWJVYnFxcmNSdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVPOW9UNkp6Mk1RM2Q5SzYxK1NtZ2xta09sWTNOQTExYlRlb1FJaGN4UkZI?=
 =?utf-8?B?ZXg4b1pxQW9YMjdwVUZMbHoxT3p5M0RmUjJqY0szM3JPOTI4cC9GZGU1dGcv?=
 =?utf-8?B?NjBNMFhwZ1N4YTdaQVFYdG16RXNkRy9vUVZadUJSYjVSaFRZOWVTejZvQTha?=
 =?utf-8?B?RVBCNzh5T3RielF4TnN6S0RvMkRTeHBlRXpkQ1lEeW1GL2RKRExYUmV6TE9V?=
 =?utf-8?B?TStwOWFZdU52VGdzYWVWRmI1TFp4b3BPQkUyNitFRnFhRmtMTVZudlRpOTMw?=
 =?utf-8?B?dW04U3FPMjlJazFRUDh5a1hnSXQ0YTRPcW5reGJ5c1ZRdVpZSDhBZk1TdUM4?=
 =?utf-8?B?SzdvVSttS0N4NXQzcWNZQkIxLzBuRHBQT1BjNmlzY2RLc21mWllxT2Z4Z2NB?=
 =?utf-8?B?dXFFRUdhWTliUnlzcVpRNFZzckhjT3o5dTRSajU3cnJPOStCZ09CVTBheERH?=
 =?utf-8?B?OWc4TUNrR2Q0L2tEWTVHUWpkUUZUeXluQjdXZ3djRFN5azZBdy9HbzdBVkJ1?=
 =?utf-8?B?MFRrTTNOaWhERlhrUWovN3M1Y2sreVhoUmo3NU5uOWZZYklWWVhNUEN3dTQx?=
 =?utf-8?B?M3lIbVg0Tnljd3FxWS9mMjdUbnRVL0pEcWQ5ejdpQmU3eGJVSmJ3WFU0Wko5?=
 =?utf-8?B?VDJzODNWN1p2THFMZnd2NitzQmV1QVJyV2dNWVB1V3BQWTc5OXFNbWpuakNT?=
 =?utf-8?B?OGprWDl3Unc4Z2cxdllEemxDTjZrcm9NaTlJSnh1VHBnTjVNQXlYTVQyV0ZZ?=
 =?utf-8?B?YlpxV2hXTXJqSXZoTThXYnFxWXFjbDMzYWJlRzB5Qjl0c1owbGEwTGNFeDEv?=
 =?utf-8?B?YVJtTmlYVjcyMlczYWhKbDZqTmtvdTVTazV1UE1ZQ2t1QkJJNkhBRERKNVFm?=
 =?utf-8?B?Wm9CRzRvQzQ0WWxzSllGSm5EWXlUbTdleUlsdVJGTDFrSzFuUm9hbXNGajQ2?=
 =?utf-8?B?ejg4c0pVZWp5L0djUStycmtZT09KR1hnZnBlWm1pQ0ovWHNxTVVNelZUNXBZ?=
 =?utf-8?B?a2gvSitVb0tKSGp6R3JOMzQ5SklPaGZMNHpab0d4YndwdVBucitkczI1dW9I?=
 =?utf-8?B?aVkwb0JVRTRkZFF5cnZnZlk4aW1xK1MreERkWWtjdDZSRzF3UXkyUS9lZjJS?=
 =?utf-8?B?SURveU11cC9PNXFvTzZxU3ZYSUIyajRJL0s2QjUwT3hFNXNLUHhORmhzN0pu?=
 =?utf-8?B?Sy9neGtPQlJJb1BvR0hhLzRZUXRTUFBNbFBsUnFNV2pyM2p6UEVBSHF1bTdq?=
 =?utf-8?B?ckZKSzlOWEtxQnRuQ0FpVTd5L1Jndnl4ckhndThMOTFJcWx5NTArYnFqYThT?=
 =?utf-8?B?c3JXR1lFY2M4cjZCZFVobHR1TFVJRlJlYWZNblBQeVBKV1RjdUcyRWtpa0xo?=
 =?utf-8?B?K2ZYYndKbFNMUE1QYUJnbkExVWFrWEhVMitoc0tkbHlyZUZsT3k2MzdrYm9D?=
 =?utf-8?B?Lzc0UUp2RmFOMTk4c3NwS3p6aEJOR1ZEWXEzOTluVVoyU05sSlRqYjRWcVFr?=
 =?utf-8?B?SXhKYkdjQURLNlR3TlhmTHdLNW41U1JxYXpvV0V0ZjVsM0h2djFXT3pSSERT?=
 =?utf-8?B?dXM3QVd2TU9jajdwb2xhTjRlQjlIQ1J3R2VyTjhSQURJQ3N3WkF0dUdjWWVW?=
 =?utf-8?B?YktHV0JOUDh0QlZ2UDZFSEc4OVpxUzViakl4WXpUci9EZTQ5T2xIT1JFeUxh?=
 =?utf-8?B?WlBGR3h5ZXo0cVV5VE5Oc1hpV1kxZmlwUENRNEdFRVhCL0srQjhKbExOeEY2?=
 =?utf-8?B?U0d0bkV6eEVTeks4SmxWa1VlUHRGSGZINUNkS2VwVmxwQ2JiY2NoWHR2TDBv?=
 =?utf-8?B?THIxZGF6M1BuaEs0MktLL1V2emV6VzNveVdIaWVEV0t4a01NaTR3dzU5UmNI?=
 =?utf-8?B?NVBlaFFaS0VQQnQ1OUtqVG9uOFpPajNVWmV2TU5VMVZ3L3g5aHJsU01jQ0Nz?=
 =?utf-8?B?eVpBOWh4cysyTG1mdmJ4SnBrNEdiQkFHQ0JMOHREdldHSHRaNEVjNzZwNG9w?=
 =?utf-8?B?MGxLZjRuSlJMZFdBbURsenNZeWU1WHlLVC9ZUjl0YnQ3SEJUdzNndllTVVBQ?=
 =?utf-8?B?eWtYTWIvTk0wa1lUM1Vzd01XMU5ia1FaaitKOERBWk40QUsyb3VhQ3JRU2Jr?=
 =?utf-8?Q?8IM6Te5IDBcSUKbBIERZ5NKsl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7c1e3c-fba0-4c33-6452-08dd0d812d13
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:44:21.7461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEi5okRlvHHNRDi+suy0X1F3epwzoJkoUAYSYUdzo+GJWU3GztfXNkarQGEd+Jm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
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



On 11/25/24 19:08, Tom Rini wrote:
> On Mon, Nov 25, 2024 at 07:03:41PM +0100, Michal Simek wrote:
>>
>>
>> On 11/25/24 11:35, Heinrich Schuchardt wrote:
>>> On 25.11.24 11:02, Michal Simek wrote:
>>>>
>>>>
>>>> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>>>>> On 11/25/24 09:32, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>>>>>> The CI uses the following command to launch xilinx_versal_virt_defconfig:
>>>>>>>
>>>>>>>       qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>>>       -display none -m 4G -serial mon:stdio \
>>>>>>>       -device loader,file=u-boot,cpu-num=0
>>>>>>>
>>>>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>>>>>>> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
>>>>>>> relative to the register start address 0xfe20c100.
>>>>>>>
>>>>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>>>>>>
>>>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>> ---
>>>>>>> v2:
>>>>>>>      new patch
>>>>>>> ---
>>>>>>>    configs/xilinx_versal_virt_defconfig | 2 --
>>>>>>>    1 file changed, 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/configs/xilinx_versal_virt_defconfig
>>>>>>> b/configs/ xilinx_versal_virt_defconfig
>>>>>>> index c8f166c1221..06a240173ba 100644
>>>>>>> --- a/configs/xilinx_versal_virt_defconfig
>>>>>>> +++ b/configs/xilinx_versal_virt_defconfig
>>>>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>>>>>>    CONFIG_DM_USB_GADGET=y
>>>>>>>    CONFIG_USB_XHCI_HCD=y
>>>>>>>    CONFIG_USB_XHCI_DWC3=y
>>>>>>> -CONFIG_USB_DWC3=y
>>>>>>> -CONFIG_USB_DWC3_GENERIC=y
>>>>>>>    CONFIG_USB_ULPI_VIEWPORT=y
>>>>>>>    CONFIG_USB_ULPI=y
>>>>>>>    CONFIG_USB_GADGET=y
>>>>>>
>>>>>> NACK. That's not the way to go. If one test is failing in CI
>>>>>> disable that test not really support which is for HW too.
>>>>>>
>>>>>> Thanks,
>>>>>> Michal
>>>>>
>>>>> Hello Michal,
>>>>>
>>>>> It is not that a single test fails. USB is completely unusable
>>>>> on the board. 'usb start' leads to an immediate crash.
>>>>
>>>> I am not applying any patches on SOM with HEAD and usb is partially working.
>>>
>>> Don't you see a crash when executing 'usb start'?
>>> What QEMU are you using?
>>>
>>>> I can agree that it is not super stable with upstream only patches
>>>> but that's different story.
>>>>
>>>>>
>>>>> The problem already existed in v2021.01.
>>>>
>>>> Any log?
>>>
>>> $ git reset --hard origin/master
>>> $ make xilinx_versal_virt_defconfig
>>> $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
>>> $ qemu-system-riscv64 --version
>>> QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
>>> $ qemu-system-aarch64 -M xlnx-versal-virt \
>>>   > -display none -m 4G -serial mon:stdio \
>>>   > -device loader,file=u-boot,cpu-num=0
>>>
>>>
>>> U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
>>>
>>> CPU:   UNKNOWN
>>> Model: Xilinx Versal Virtual development board
>>> DRAM:  2 GiB (effective 4 GiB)
>>> EL Level:       EL3
>>> Core:  32 devices, 13 uclasses, devicetree: board
>>> Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
>>> MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
>>> Loading Environment from nowhere... OK
>>> In:    uart@ff000000
>>> Out:   uart@ff000000
>>> Err:   uart@ff000000
>>> Bootmode: JTAG_MODE
>>> Net:
>>> ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
>>>
>>> Warning: ethernet@ff0c0000 (eth0) using random MAC address - 5e:f6:37:a3:68:24
>>> eth0: ethernet@ff0c0000
>>> ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
>>>
>>> Warning: ethernet@ff0d0000 (eth1) using random MAC address - 5e:8a:ec:a9:d7:e8
>>> , eth1: ethernet@ff0d0000
>>> MMC: no card present
>>> MMC: no card present
>>> Cannot persist EFI variables without system partition
>>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>>> Missing RNG device for EFI_RNG_PROTOCOL
>>> Hit any key to stop autoboot:  0
>>> Versal> usb start
>>> starting USB...
>>> Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
>>> elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
>>> elr: 000000007ff17fd8 lr : 000000007ff18940
>>> x0 : 00000000fe20c100 x1 : 0000000040000000
>>> x2 : 0000000033310000 x3 : 000000000000003f
>>> x4 : 000000007ffa74b0 x5 : 000000007c112880
>>> x6 : 000000007ffa74c0 x7 : 000000007c300000
>>> x8 : 0000000000000684 x9 : 000000007bda668c
>>> x10: 0000000000000003 x11: 0000000000000188
>>> x12: 0000000000000000 x13: 000000007bda6be0
>>> x14: 0000000000000000 x15: 000000007bda6224
>>> x16: 000000007fee9244 x17: 0000000000000000
>>> x18: 000000007bea6be0 x19: 000000007c111b48
>>> x20: 000000007c111240 x21: 0000000047822004
>>> x22: 000000007ff998b2 x23: 000000007ff998e8
>>> x24: 000000007ffd4514 x25: 0000000000000000
>>> x26: 0000000000000000 x27: 000000007c111130
>>> x28: 000000007c1110d0 x29: 000000007bda67b0
>>>
>>> Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
>>> Resetting CPU ...
>>>
>>> resetting ...
>>>
>>> $ cat u-boot.map
>>>    .text.dwc3_core_init
>>>                   0x0000000008068f24      0x6a0 drivers/usb/dwc3/core.o
>>>    .text.dwc3_of_parse
>>>                   0x00000000080695c4      0x310 drivers/usb/dwc3/core.o
>>>                   0x00000000080695c4                dwc3_of_parse
>>>
>>>>
>>>>> Do you know of any QEMU/U-Boot combination where USB ever worked on the board?
>>>>
>>>> Why was this visible in CI in past and why this pops up now?
>>>> What has changed? I don't think there was any change in QEMu
>>>> regarding USB but I can double check.
>>>
>>> We never started USB in the CI.
>>> With patch 6/6 of the series usb_bootdev_hunter() is invoked which starts USB.
>>
>> Did you push this to gitlab CI? Which test/py is failing there?
> 
> Er, we don't do "usb start" in CI yet, is why it doesn't fail there. Or
> are you suggesting this is a QEMU problem ?

This is where it is failing from dwc3_core_init().
dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);

It means it is likely qemu model limitation.

Thanks,
Michal
