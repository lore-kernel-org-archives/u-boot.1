Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A36C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 08:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1176881DB;
	Mon, 20 May 2024 10:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lq/NsMjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1BB1881DB; Mon, 20 May 2024 10:29:53 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 650B58865C
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 10:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb6xYbsMMEygyIr3h8VgmWB7Sg+WG+2eV6ZPAofgE4S5l0RzANZeIYYKin264uaVeGSFxhtdnf9ZQx1eKakZGrT4zQTLJbyW0A9qKT64ZF1gyaQJbc6o5naffua8xoUZJddazD4eko23xBMf4nJTl9UikjFXMcgZyclsHn7jKChi9Z1K0tZpLoeSCBtrfsFPuq27EPq7ujl5AdqO4oEdZZEB2gD4hi4Is9TpanmKwsMCutnWb5HsI0Mf+r7dnft62BSfvqnwtaWEuiYLL3fs7tN70XnSGys0Ok6bP126MezmIcXEWAznX7LYHE9zJnA7Lw+hJJcYYQw91pbG7QuqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv6Uk964y0hQvTqkCRUpkCfhRfz02ZPH6llt0BgTbpo=;
 b=cowB69IMbu2Btmw9DjLEtT10IqnGmrkFBZAQoeaqPpqu49X/ZS3OR61jcjtPDglZrOuEUS8CTmUtZs2ye0Zr2xLZ7uHpp3XRXISZjDdgxXmjzgIiras5P4q1PGbyiWO+sYf4z9OtU+UOiRWuvqdz/n+utXi0uvbppZ7aECZKyJ/4Wyx3mimB7ko1d9ogkCjc69q5lvrGiOJ4AuIClEfG5y0jQkJCLLGwVqVvFfpx7aTH1ZCjUPAbXcZMScoL9sqUL79DyLwy/IA1eWrWApqM4l+Hgli7mOjhZoKYNwnREP/1oa6poQmUIukNJ3VlORFWT6T7XxfLQCK/M9I4PFVTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv6Uk964y0hQvTqkCRUpkCfhRfz02ZPH6llt0BgTbpo=;
 b=lq/NsMjbT13xLH8csUv9Aa8cB4CRHRmlF0sTgH0C9XH0NcIM+puASN4ugD781j0/30pK2LDWMweDswYsDbWwhhoRIsUWwgBnmDq0KrM7x52pl/iUD4pEYWSbf9iG/CQDzGfhqH2hPzh/D24A0Bmwz9fTcxxUCepN5qFJ7wiCfOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 08:29:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7587.026; Mon, 20 May 2024
 08:29:43 +0000
Message-ID: <07c0000c-c60a-42ad-8c49-608b7b15e7f8@amd.com>
Date: Mon, 20 May 2024 10:29:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: c73e9d0b-c349-416e-c8c6-08dc78a70001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d29SeWFXUXZQcTdtWStlSGZpK3M4Q3lQV2NBRFU3eVB4RnFYdEc5ejJXZGtr?=
 =?utf-8?B?bC8zeW1pRHh5U0FRUUd5eCs5VWNKb1dzOSs0MGpVT0FhLzByemcvR0ZyaE55?=
 =?utf-8?B?ZXFBWGlKaWg4eGdTelZLa1V1cjBSVVhIV1ZVcTdJVFZpS25qNUpnVHRaQU81?=
 =?utf-8?B?R1hKeTJCa0w2Rzl0NFJzMW1VMWQxYmd5eDVmUnpEd0hXZXRsejR0OVFsWWhR?=
 =?utf-8?B?MXRoYmdEa21MU29FL1ZkMzRxWFBJNHZTUmlReG9zdnVaWnd6WGR2Nko1Q0FY?=
 =?utf-8?B?Z2dzVUd3MksyYnJhMCtTQjNORlJOUGhBanA4UmUrNENtM1R2MEgvd1FIcU9Y?=
 =?utf-8?B?eGhFRFZ1dXdUZ0xzZ1NEZTdEREZvUGRXRTVUdmVEeGpsSWtJMHFvUUpkaER4?=
 =?utf-8?B?ekxLd2dSc0FnRHQwN1R1YUFPRTdueVpnNFhBeTBzcDBlUlhDQUlWc3Zac3pt?=
 =?utf-8?B?Z0ptN3FObnZ2bmxiWmJGMzBieitiVndqK2ZFRitwVzVscldsclZNMFdSUUg2?=
 =?utf-8?B?ekJDTFZOTmlXTzdqbm5vY1VHN3pwZnY0SVpFTng0cTY3TlhoU21FQXNleGIv?=
 =?utf-8?B?My95bS8vbDVvUDhaMm9tbnQ0ekVCakNnQTBFV056MHdZaW14WGlqeVJoRk1P?=
 =?utf-8?B?QVFjRk00dzd4bHhRT1ovYWErSjhWaFl6NVBWUm1MWHBJUnNmQXZTbjNiL3A3?=
 =?utf-8?B?OXhwbC9FRXRGNS9JdmRMUFVveVJVdUpFOVFpZFJSeEQ5TDAxTTBQcnB2WGtm?=
 =?utf-8?B?VFE0cEl1QWdMY3g3Kzk2RDUxR1QvTnJvV0E4R0hLWkpsRm1WczFsaGJxZksv?=
 =?utf-8?B?MHgvVi9CTkFmOFpqaUh2QnZrVFpMeGYrTnVEcDdGM0pQS3k2TlloZGVBWkVz?=
 =?utf-8?B?c2hxYjVUTHdhVzVaOG1abEhqZlVkeHlsY2VEcFY2S2ErR1h1RlRaREpXU3dP?=
 =?utf-8?B?M01CQVVja05rRjhxT0tNUU9HYUJITjd6QzlBN0RJSTlmVHBnZ3FzeU8wcGdM?=
 =?utf-8?B?NDBRNzZGZTdyc0F6akNKMEExY1dWUHhJajlUN29wZUpUYlU0MFZXZElvcXRp?=
 =?utf-8?B?NzRRUGJJNm1rQlZXdXk3VVBlT1ppRjAzZ2JkcC9FT2cvMkZNd2crUmJHSnhX?=
 =?utf-8?B?dGg1QlBqcEIydEdROW01eHR0VCtYODNQL2Vxc2Z5ZHJsMEFYK3VBcFpNOWda?=
 =?utf-8?B?dUcrM25rb1ExQk1yQ0Z1MnVkTTUzTkF1U2RudVB0UHdZVnBUYUwwa1RUb3Va?=
 =?utf-8?B?QXZhWVE2SFhpcHdqcXhNQ2ZRdTAwdllhWXF2RVJMeG05QUczYjRFbkZJakZJ?=
 =?utf-8?B?enY5NStGOUEzK1RWaG1tMWt4cm5ZMmtzSzA5ODFnbCtubFNTcW5GOGprdTlu?=
 =?utf-8?B?alNFUjRHdUVCa2l4UlQ3S2VXbWVhS1luaXlQZVhpeHF0YktGZTZoRm8zMFlK?=
 =?utf-8?B?SnJVcEtFNUl3dUhpMG9LUloveWVsWUZOUlJ6TFk4UUxpYWNjWU9yODFqOW9X?=
 =?utf-8?B?bEdCS3pBN0ZVYjZaTTdYOEd4a2l2LzM5NU9lTUlkTkVaU3NxNnJxU2xkaThx?=
 =?utf-8?B?Q0gxMDVJZWUzQkhqNEhTbzI3WHdJMmpnQkZFRUx2Nk5ScVhqM0pycEw2V0o5?=
 =?utf-8?B?VWp2N2NVakhOUU1HSmZnSUU4a0VXQ05nTTFmY0gwemVkSlNqU0ZqTURQQnBE?=
 =?utf-8?B?bW4rZHo4WjdIRW02NTJobWNJK2JDOU05ZTZ5TzlaS3pUSGp6TFdIc05BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWUrakk4TFZTTWtDUW5IVThEZjAvUmh6dC92VVRteHh1andZODhXNWw1WFpQ?=
 =?utf-8?B?dmhKdmVjTUlZRFZHRFBvbnFpcGtWUjJpNlJVZCtxRVcrbklwS3JrWW5mY0JT?=
 =?utf-8?B?Z0huVXFXb1ZzRkZvQVRabW9GV3d5SFA3LzlGZ1NVMjBvOHdvUktkK0lWYmla?=
 =?utf-8?B?d0FYQzYzZ0R0YkxmR1VmL0hqTjlmaUxYb2ZmYWtRdG1YSXRaVnhFd0hGMVVm?=
 =?utf-8?B?c2RjSnlyZkRFSzRkLzVLejk3eHgrd2NaWndHZ1c0azVuVUdjRDRZS3FKN0dj?=
 =?utf-8?B?bDkvd3FiVUZJLzdONVdNRWdHNmxSb0Q1dzZsL0llMG1NeXk4N0M5VDNUbmpO?=
 =?utf-8?B?bzNrQVRMSEl2U3d6M0V5R2IwZ2tmTStJYmJoaUJVbkhFWmNlRk15Wm1qaUpY?=
 =?utf-8?B?dTErNm1PUnZkc3FQaC9Gd1pXaE9sVytQeXl4L0hlNGxtWFQ0SXViT3lkOS9E?=
 =?utf-8?B?MGxISHd1ajZtRzV3NStTcGxqZGRjWGxHL3kvYzRhcmppVGg2KzhLdjhKaGtp?=
 =?utf-8?B?eGZPOUdVZmpsUnhwQjN4ZFlzcUpsVHJsK2pnNDlKbFJybGdCaG80aTc3QThq?=
 =?utf-8?B?SVdiRk9keEdQd05BVDRHdk90M0VHdjRVU2ZERzBDRWZhc3BoMmcxcGNXVGVm?=
 =?utf-8?B?ajNIS2tUWDRlaGhHUXdZNnQxc2RmZ1dwNTU5blhDVjl2RkgyR3AvUlBuWm9N?=
 =?utf-8?B?WEw5akhwVS96OHVKYmZEWnZ4UVl3UC9CMjdTcWdHdUdnUzVqSGd4Q0ZBT2or?=
 =?utf-8?B?S0RqdDlrSmxwcmtRNW1qN0MyVWdOSWg1QUl6K1oxaFNnazlDdGNqQ00yMnVz?=
 =?utf-8?B?Z1k3bWdURXhQNUF6YTBTYmN6Rk85cHFiSE5icWN4blRPemdNTTA1elR1NUdp?=
 =?utf-8?B?RVJUd1lpT2FyY0UwWGZQczhuRjdreWVUMlJkWEQva1pOa0NHRnZvVm1xNEVJ?=
 =?utf-8?B?amJoUStua3dPVnY1eWdlZmYwcUoyK3JwREZtUHpBQXVyYk9NbGQ4RHhYWHZs?=
 =?utf-8?B?Nk1QK2llSDNic2VmLytuekovZGFrdUZBMFh5OWZleVJwOTcyT0o3eGZzbWFv?=
 =?utf-8?B?N09PeFV6aWhZSm9qM1FIWG5aeE94UENuT1pHbjN5dVpOdGxEc3lhRnMveWZX?=
 =?utf-8?B?Wm1NZitHalBhMlFsQVFTVTRqSjZDcWtwMy9MSXJRVWxFd3l1WUgxNlJpUUJp?=
 =?utf-8?B?Qy9RTWwvcGhxY0Vya3E4Y2VwTVMxcmVTZDRnSVA4c0c0Y1Nsb3J6OTNZWFdV?=
 =?utf-8?B?bXNyMko2RzJKTHVYZFBUejIxR2lOQ0gwNStwZC84QTdhcjl4bm1sMndnM3RK?=
 =?utf-8?B?Q2IwNStlVmxUT2lkcGZGby94ZG5aOFV0d0RiSGRabjJmYytEbzlUaUJVMVkw?=
 =?utf-8?B?aVRIZEZuVFUxOVV2WnlaQTdXUDRBYkhBVGFHVlVtdm94Y3Bpekg4dkF6QkJY?=
 =?utf-8?B?RTYzT2JpUVZJS2U0SEsyTkw5ckM0VUxnTTVpZGptYjEzcXNCSUdabWJ5NjB1?=
 =?utf-8?B?bGZhRXdQdk9MNmc1WHdPeTJWTXV1UVV6b3Y5ekVnb3R6K1NHcDZ1SnJtUDdG?=
 =?utf-8?B?WXR1ZEtQNjJmc2ExNFlka25UMGU3T0xHeTZYcmltQlVNTmdLdjNrejhRYURr?=
 =?utf-8?B?SituZFJ2YVRUUTJBUGhCdEcyeUd6RkF3TVpBQVh0WDhTSXJkWUlHMmg5Qm80?=
 =?utf-8?B?OUpueEpJT2w3UkNXa1drT2tKR2c0VnpqZmhmZ3RjWkcyTTJLMU13SHF3amJK?=
 =?utf-8?B?L24xcWU0d1hOQ3JVbXhzcklkV2NCRDZEOS9rNVhPS2RUditFTGYyZWR3SGpK?=
 =?utf-8?B?VmJTN0g2UG5CcWNvMEh5aFRIMElMSit5RDRLdk81aUZKMk5aV0VkR0VhV1A0?=
 =?utf-8?B?YXdMakZ6YS8rbDBkcDI0VDJ3VlFON2JSV1NFcFVMWlQwL294bGx3bjRSUXlE?=
 =?utf-8?B?UENIWEdtU2ltYXlsVnNWb3BQWUZrdmM1UHUyNjNHZlRtVzk2MkhubUVzMkRU?=
 =?utf-8?B?UUJ0a2lmMzNHTDgveWRxOERVUGVRNFVOMmxWVEFtZDV1Zk1UK3p0Z1BDQ2VR?=
 =?utf-8?B?ZXN3UnZyU3FlSUZyajZjQmhQS2s5MjUzeGluYmNFQmV6UFpPcjNNdTZONUJz?=
 =?utf-8?Q?x9umJe0ayjpbeVpeC5Lfr/hn6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73e9d0b-c349-416e-c8c6-08dc78a70001
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 08:29:43.7379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYhaQDrMriQouowScK+JIdxwdWKrJXMbH9cAC0tDkhGzDejfQkBDnRZyGh4fofUH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
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

Hi Tim,

On 5/16/24 17:58, Tim Harvey wrote:
> On Wed, May 15, 2024 at 1:50 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>
>> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
>> randomize the virtual address at which the kernel image is loaded, it
>> expects entropy to be provided by the bootloader by populating
>> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>>
>> If we have DM_RNG enabled populate this value automatically when
>> fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
>> it's implementation uses a different source of entropy.
>>
>> As this fdt node is added elsewhere create a library function and
>> use it to deduplicate code.
>>
>> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
>> but left in place in case boot scripts exist that rely on this command
>> existing and returning success. An informational message is printed to
>> alert users of this command that it is likely no longer needed.
>>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>> v2:
>>   - fix typo in commit msg
>>   - use stack for seed to avoid unecessary malloc/free
>>   - move to a library function and deduplicate code by using it elsewhere
>> ---
>>   board/xilinx/common/board.c | 35 -----------------------------
>>   boot/fdt_support.c          | 10 +++++++++
>>   boot/pxe_utils.c            | 35 +++--------------------------
>>   cmd/kaslrseed.c             | 45 ++++++-------------------------------
>>   include/kaslrseed.h         | 17 ++++++++++++++
>>   lib/Makefile                |  1 +
>>   lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
>>   7 files changed, 72 insertions(+), 105 deletions(-)
>>   create mode 100644 include/kaslrseed.h
>>   create mode 100644 lib/kaslrseed.c
>>
>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>> index 30a81376ac41..f741e8957818 100644
>> --- a/board/xilinx/common/board.c
>> +++ b/board/xilinx/common/board.c
>> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>          if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
>>                  fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>>
>> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
>> -               debug("No RNG device\n");
>> -               return 0;
>> -       }
>> -
>> -       if (dm_rng_read(dev, buf, n)) {
>> -               debug("Reading RNG failed\n");
>> -               return 0;
>> -       }
>> -
>> -       if (!blob) {
>> -               debug("No FDT memory address configured. Please configure\n"
>> -                     "the FDT address via \"fdt addr <address>\" command.\n"
>> -                     "Aborting!\n");
>> -               return 0;
>> -       }
>> -
>> -       ret = fdt_check_header(blob);
>> -       if (ret < 0) {
>> -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
>> -               return ret;
>> -       }
>> -
>> -       nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
>> -       if (nodeoffset < 0) {
>> -               debug("Reading chosen node failed\n");
>> -               return nodeoffset;
>> -       }
>> -
>> -       ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
>> -       if (ret < 0) {
>> -               debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
>> -               return ret;
>> -       }
>> -
>>          return 0;
>>   }
>>   #endif
>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>> index 874ca4d6f5af..3455d60d69dc 100644
>> --- a/boot/fdt_support.c
>> +++ b/boot/fdt_support.c
>> @@ -8,6 +8,7 @@
>>
>>   #include <abuf.h>
>>   #include <env.h>
>> +#include <kaslrseed.h>
>>   #include <log.h>
>>   #include <mapmem.h>
>>   #include <net.h>
>> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
>>          if (nodeoffset < 0)
>>                  return nodeoffset;
>>
>> +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)) {
>> +               err = fdt_kaslrseed(fdt);
>> +               if (err) {
>> +                       printf("WARNING: could not set kaslr-seed %s.\n",
>> +                              fdt_strerror(err));
>> +                       return err;
>> +               }
>> +       }
>> +
>>          if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>>                  err = fdt_setprop(fdt, nodeoffset, "rng-seed",
>>                                    abuf_data(&buf), abuf_size(&buf));
>> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
>> index 4b22bb6f525a..8d70233fc08d 100644
>> --- a/boot/pxe_utils.c
>> +++ b/boot/pxe_utils.c
>> @@ -8,6 +8,7 @@
>>   #include <dm.h>
>>   #include <env.h>
>>   #include <image.h>
>> +#include <kaslrseed.h>
>>   #include <log.h>
>>   #include <malloc.h>
>>   #include <mapmem.h>
>> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
>>   #if CONFIG_IS_ENABLED(DM_RNG)
>>          ulong fdt_addr;
>>          struct fdt_header *working_fdt;
>> -       size_t n = 0x8;
>> -       struct udevice *dev;
>> -       u64 *buf;
>> -       int nodeoffset;
>>          int err;
>>
>>          /* Get the main fdt and map it */
>> @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
>>          if (err <= 0)
>>                  return;
>>
>> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
>> -               printf("No RNG device\n");
>> -               return;
>> -       }
>> -
>> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
>> -       if (nodeoffset < 0) {
>> -               printf("Reading chosen node failed\n");
>> -               return;
>> -       }
>> -
>> -       buf = malloc(n);
>> -       if (!buf) {
>> -               printf("Out of memory\n");
>> -               return;
>> -       }
>> -
>> -       if (dm_rng_read(dev, buf, n)) {
>> -               printf("Reading RNG failed\n");
>> -               goto err;
>> -       }
>> -
>> -       err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
>> -       if (err < 0) {
>> +       err = fdt_kaslrseed(working_fdt);
>> +       if (err < 0)
>>                  printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
>> -               goto err;
>> -       }
>> -err:
>> -       free(buf);
>>   #endif
>>          return;
>>   }
>> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
>> index e0d3c7fe7489..ea5c07d729cf 100644
>> --- a/cmd/kaslrseed.c
>> +++ b/cmd/kaslrseed.c
>> @@ -9,33 +9,16 @@
>>   #include <command.h>
>>   #include <dm.h>
>>   #include <hexdump.h>
>> +#include <kaslrseed.h>
>>   #include <malloc.h>
>>   #include <rng.h>
>>   #include <fdt_support.h>
>>
>>   static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>   {
>> -       size_t n = 0x8;
>> -       struct udevice *dev;
>> -       u64 *buf;
>> -       int nodeoffset;
>> -       int ret = CMD_RET_SUCCESS;
>> +       int err;
>>
>> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
>> -               printf("No RNG device\n");
>> -               return CMD_RET_FAILURE;
>> -       }
>> -
>> -       buf = malloc(n);
>> -       if (!buf) {
>> -               printf("Out of memory\n");
>> -               return CMD_RET_FAILURE;
>> -       }
>> -
>> -       if (dm_rng_read(dev, buf, n)) {
>> -               printf("Reading RNG failed\n");
>> -               return CMD_RET_FAILURE;
>> -       }
>> +       printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed");
>>
>>          if (!working_fdt) {
>>                  printf("No FDT memory address configured. Please configure\n"
>> @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>>                  return CMD_RET_FAILURE;
>>          }
>>
>> -       ret = fdt_check_header(working_fdt);
>> -       if (ret < 0) {
>> -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
>> +       err = fdt_kaslrseed(working_fdt);
>> +       if (err < 0) {
>> +               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
>>                  return CMD_RET_FAILURE;
>>          }
>>
>> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
>> -       if (nodeoffset < 0) {
>> -               printf("Reading chosen node failed\n");
>> -               return CMD_RET_FAILURE;
>> -       }
>> -
>> -       ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
>> -       if (ret < 0) {
>> -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
>> -               return CMD_RET_FAILURE;
>> -       }
>> -
>> -       free(buf);
>> -
>> -       return ret;
>> +       return CMD_RET_SUCCESS;
>>   }
>>
>>   U_BOOT_LONGHELP(kaslrseed,
>> diff --git a/include/kaslrseed.h b/include/kaslrseed.h
>> new file mode 100644
>> index 000000000000..3fe82f418acf
>> --- /dev/null
>> +++ b/include/kaslrseed.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
>> + */
>> +
>> +#if !defined _KASLRSEED_H_
>> +#define _KASLRSEED_H_
>> +
>> +/**
>> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
>> + *
>> + * @blob:      fdt blob
>> + * Return:     0 if OK, -ve on error
>> + */
>> +int fdt_kaslrseed(void *blob);
>> +
>> +#endif /* _KASLRSEED_H_ */
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 2a76acf100d0..20a0242055fa 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -149,6 +149,7 @@ obj-y += date.o
>>   obj-y += rtc-lib.o
>>   obj-$(CONFIG_LIB_ELF) += elf.o
>>
>> +obj-$(CONFIG_DM_RNG) += kaslrseed.o
>>   obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
>>
>>   #
>> diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
>> new file mode 100644
>> index 000000000000..ad06bee2b88d
>> --- /dev/null
>> +++ b/lib/kaslrseed.c
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
>> + */
>> +#include <dm.h>
>> +#include <rng.h>
>> +#include <fdt_support.h>
>> +
>> +int fdt_kaslrseed(void *fdt)
>> +{
>> +       struct udevice *dev;
>> +       int nodeoffset;
>> +       u64 data;
>> +       int err;
>> +
>> +       err = fdt_check_header(fdt);
>> +       if (err < 0)
>> +               return err;
>> +
>> +       /* find or create "/chosen" node. */
>> +       nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
>> +       if (nodeoffset < 0)
>> +               return nodeoffset;
>> +
>> +       err = uclass_get_device(UCLASS_RNG, 0, &dev);
>> +       if (!err)
>> +               err = dm_rng_read(dev, &data, sizeof(data));
>> +       if (!err)
>> +               err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
>> +       if (err < 0)
>> +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));

I have used debug messages to better track if error happens. I think it would be 
good if you can extend your code with it.
Because if this fails people have to start tracking if issue is that there is 
RNG device or reading fails or issue with setting up property.

In v1 it was said that you won't update it if the kaslr-seed property exists.
I can't see this in the code. Or do I read it incorrectly?


>> +
>> +       return err;
>> +}
>> --
>> 2.25.1
>>
> 
> I realized I forgot a few CC's here. Adding:
> 
> Michal Simek <michal.simek@amd.com> (board/xilinx/common/board.c and
> configs/xilinx* which have CMD_KASLRSEED)
> Andy Yan <andy.yan@rock-chips.com> (configs/evb-rk3308_defconfig and
> configs/roc-cc-rk3308_defconfig which have CMD_KASLRSEED)
> Akash Gajjar <gajjar04akash@gmail.com>
> (configs/rock-pi-s-rk3308_defconfig which has CMD_KASLRSEED)
> Ilias Apalodimas <ilias.apalodimas@linaro.org> (MEASURE_DEVICETREE,
> MEASURED_BOOT)
> 
> Michal, I see that board/xilinx/common/board.c is adding
> chosen/kaslr-seed in ft_board_setup as well as some of the
> configs/xilinx boards enabling CMD_KASLRSEED - can we remove
> CMD_ASLRSEED from those boards? (ie no bootscripts require it?)


Based on my note above that you shouldn't change kaslr-seed if exists.

What would also make sense is to extend kaslrseed command to pass one more 
parameter to pass which RNG instance should generate data on system with more 
RNGs. Then pretty much with command you can choose different RNG because current 
code hardcoded it to instance 0.

Do you have correct dependency in generic code when MEASURED_BOOT is enabled as 
was mentioned in v1? If yes it should be mentioned in commit message.

Thanks,
Michal
