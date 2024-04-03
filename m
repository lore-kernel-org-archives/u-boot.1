Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3382CD1292
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 13:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 030A288322;
	Wed,  3 Apr 2024 15:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BCZnaj+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA6788322; Wed,  3 Apr 2024 15:28:23 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36CAF8838A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBF9KolNf3Pm5bl9xpV3YqKY5rsreP2+0YPRlG3PIwXmtHVx1a62yVLlAbuq3Uy3f/Ob5Mn5UYP8gG/jTGDAWm89RqczZmsRTMhzXVoWF8qkQbsqKZung1W2t9cRjY7cBeBXsh9lqukisa07lOM2lhUF2z937ZXlsGKbyaJ1bPqwW8dJphi/tcM/bFC1qtbmpUYocU0/ZlE2Wm2UrFky+xV/h9AOKIuccN797iIcw4htuNxylS9XdgZOFkcD/OaTKnVlrwdEbX3B2RV6WGPBBJhL+d4yWi2tKy36pA44wRa8+h89jjPypTiPbHkIIy+L1K3n9VZvZyeeETyaNAsdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zz1Ly0WIo0UglCIQEO3OsPcr4AHml3L6TklxB++BQI=;
 b=RXxpAFI3H2Ec/5K000YWhKtPlqdUMP2HeYo42ye0LR1m88WFuUTHVd3zTgDKqZdaoiC9WPrZ509PTgIyMOUkc7jrOdCR2sodjkvt5p5S1SYgvgOkl/MMV1AinTVMjaVEOXQBJ2WAyYKlibVc1hlmPl0kAS3B49T7CkY/vgHApRFffPUKNvuoekH5Uujvg6dZYPlaXrdNwDoY8kNpTJ0boKg3I2vwtOI+jYd9L0GyPJeGUJbwZia2lzy4RUOMnd1gAwT9V963RjWZgPWR5A2RsjdnCJFugiDI6RZX4/rl5qg8MILIkcyWqq1inFU096ktRTCBHiJPbFZx6iG/hGJLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zz1Ly0WIo0UglCIQEO3OsPcr4AHml3L6TklxB++BQI=;
 b=BCZnaj+bGSMI0EPq8uIpVPHvgMmpozt+OzYf4YgXWh9umhbNaCwXbnorl4gevI0U0qgC2twXriiLbK+oPETXSkYhSJQKyhHs5QWMc8JP2yidukeBHs6dKPfzOuW/srilSGJLl4LEwP00LKYJujvSpTKkryh4Af0rif9fZRV+/Yg=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 13:28:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 13:28:13 +0000
Message-ID: <e6c9daa2-3159-4741-9ced-f583f969ad64@amd.com>
Date: Wed, 3 Apr 2024 15:27:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240331232859.727769-1-james.hilliard1@gmail.com>
 <7fe20558-6af1-46cb-bbfe-af308e3ce279@amd.com>
 <CADvTj4r+0hO841ZYbW+Mg9nS70fRpmVGVbh-Q8yoGYE5mj_1AA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADvTj4r+0hO841ZYbW+Mg9nS70fRpmVGVbh-Q8yoGYE5mj_1AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0088.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7786:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFCAFswgLi2bvTnYHQCWybNIxGwzxuRKvg3rzYPjva4s9JR5V3Y/2r5UHACv8Oyr99rU/Pcraft7+IZdvZZGrqKZYwRV4wkxJqCIjhuSAiRKCUOgE+d6WYAOBOTobqvfBwTd04W8J2v4aHjJI0hb5Ox5C1syihsW6eQU3SFsBKi+NcUTaUyO8GlIXc4S0M0QhKi+dbS+aui0LmBzQU79NSlxFMPN8pTtszRbPk/hl+Lhr6Igg8FPG574C2fMnbpy+zyK0wz/bwR2yX87/lFm0qwSWgpZwS5DETLIfVtUdyL0tqcw4eVp1Opk4jjfHX/qxFvuu0aZlHq9258iIQZNX+wPFIvSLI3T/RkvPWj6AiDY+t5WpP218RWbynvFvI1O+mNxBPJ6QNgBFLU8pS6jdkcXlL3OSWtqRcrk/HbIFCVx8CL+DNeB2h5KKCiAvdUr9Vwj+uLCmKkUy5iQlZXtmrK+sxs9ooaMNhEiFU1auzja8jLhnFw5xvqa87fPj2k3XXJU2nt64uLPDNlca8wQ08fKutb5PrGH7kTU3NlJ/XPhwN/w0quWLHZvokAALh6L0zHy5l1T2MSjpN/oAq7vE2gvvcEyM4vTCaCX2SVQZuLa59rr3Xlyd9c8teXb8gR72cj0D/BC5ABOVK25UJIZYRnDFFw/AZ01X82qNVmaVcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFWT01WWk1GRnEzRVVBd09JejRHVFN2ejhJb1JRZmt0bTE3RlNNUkRBdUFJ?=
 =?utf-8?B?Yk1oOVZLZ2FEODdTNURMQVFrTk9WcUJZVk1aTHNod0RsdElGcGgxNXAxNHJS?=
 =?utf-8?B?Nit6MlJodkdMdUNRYm5FVi9IeFdmbFA3YVRJUE56WGJRNUZLd29xbUhGelBL?=
 =?utf-8?B?VlJCZTQwUklRUUh5MDZjWDBEVlBZcDRRd1RvWktMSE90Z201WkJORUVKRE5n?=
 =?utf-8?B?SkYrNUpLWDE1SjhaMUJVdlpkTmRCZS9JalJ5KzBXajdYZVl0RUVwMkwwamhW?=
 =?utf-8?B?N2gybVU3K0tYbjRIUDhBd2pLdkUyYWJIUy9oR0FmdTlzdzk4SXJJcWl3UXh1?=
 =?utf-8?B?YXNJbEZjcXl0SzQrbFZtTVE4V0RDTWg0dm10RnI3TG5KMHptdENkb3p0S0RI?=
 =?utf-8?B?R1ZyYWNpYXZMbGVXdXJ6Q0xicGg0SDFZbjIza3czUGdwN2VOT2dEMVVCUzEz?=
 =?utf-8?B?RHNndHlYVzdRUGpnVXdIYmZ5N1QrWkVmdzMrcCtZYmNVelp0NEhINVNqeXl5?=
 =?utf-8?B?c09LVGIvbTgvQ2VIUkl3cDRuTjhVQWN5NGxlV2g4WmMra3RmWFR6TENKMU4x?=
 =?utf-8?B?NWdWOU5Ja0NKQkRIUGFkT1J5ZjZqY1ZuNENvNEhlUDFTb0VSdHFsUDZuRlUy?=
 =?utf-8?B?MktSN3BXRDZhUEhmTGZ5VmxueXZtYm9PWnh2YzV1dDQycUdITjZvUTNRWmVi?=
 =?utf-8?B?eDI1L1hmRUNBajF5ZjRmUGt3ZjEwWTZ0VTNhSEdXRXM1OGJZS0pnZC9RTXFi?=
 =?utf-8?B?SnBDbVB5RHlkdGY3SEhLcDZQMTVRakUwb3NTS0FJdVRqZ1ZLWEJDUVpiczNk?=
 =?utf-8?B?dVFXeVFuYTBoNDMzdHlYdlZFZjc5VFoyd3dvQ2s1dmtjSWhoSER4TmE1TlZN?=
 =?utf-8?B?T3JCVGtYeE9EZWF5c3BCWGd5djYyRWNkTnh1NS9FMCtZN3Q3cyt1S2VnTE9R?=
 =?utf-8?B?Rzd1MmlnVHhjaHhodEEzZVBGNGFvY2pTbUkzMkZxTTRNWVpsamV4YlZDeTJw?=
 =?utf-8?B?VFhTZGFQU3ZWdDJxNnozOGtjaTFGQ3ovaWNxU2xFb3J0Nlh1cWdBckFiU0dh?=
 =?utf-8?B?TTJTeWRHWDVxT2s0VSt4WFc0MlVtNUhOQUhqYmZ3bkc1WHlBbkxBbTh5ZXV0?=
 =?utf-8?B?cXdmYkovZGMvWXBvMkM0QWlDL1J0YzN1c3p5UkpUMVJpVTZqRENpSEdVcEdI?=
 =?utf-8?B?Nzd4M0tENmM5VVVnemhoV1ZYRjM1UDg4b2d4akdvbTBqM3NJYnNXckZkZTJh?=
 =?utf-8?B?cE1MRDdMZHNQUWkrN1lSN0MyY3RlMzZzZU4vR2tYekl2emtVNlhhNlBuVUxu?=
 =?utf-8?B?WldqYlV5MXhlWEI1YkVidjl2enNwQUFwRm8rQUVFWE1Pb2I5UVl1TkN2cHNs?=
 =?utf-8?B?T2xXMUxMS00rL01nMkxJamdobTdiWmQvajEzbFQzc2taK2d5bHpvSFNiRUJq?=
 =?utf-8?B?dytsVnZtSjN0cWZxbS9wYWwrQkFGcm5tdkdLbVc2c21DNk1GQjdRZm5GVFQr?=
 =?utf-8?B?UWE5QlFTZFU1S3Y5NEpnYVpMdCtuMFFzejJTSlRUWTFlUEVKSmN0Z21mVDQx?=
 =?utf-8?B?NU9nUDlCWllVWm5WMjBpY1Jxc0Z1c3ZnYjVzUFJnckVCVFpZTkJteFYrVHM2?=
 =?utf-8?B?czg2NWUyTHNuQnBjZ2pXcnRQK3ZjUEYzbnpwZUxpWlBpblNpZytqMlN3Tm5J?=
 =?utf-8?B?Y2ZBbXg5YmEzQW9ld3IyV2tMTEh3YTNIejZiU2ZjcHJyN0JIbzlqd09oZnY4?=
 =?utf-8?B?WkxMT0hTbmU1ZVRsWktvMWdTVmJUUFR3aHRobFQraUswa3hFS0RzSHNFYmln?=
 =?utf-8?B?TkhPTFpuQmdXeHpTcWNMSlJIbDFmelVJd28zUy96NXdEREQyNzR1NTFSVk5t?=
 =?utf-8?B?c0UxajIxOHZCT0VnRW40N1RidkZnSUxKazRJNHkvaGNidGFsWHlHSllpdU9m?=
 =?utf-8?B?N0I3MTR4RWxKbVRjUy9QQ1BRSVZER1lBREVnS01JekI3OVQzRGJORzZjSUNm?=
 =?utf-8?B?cGNVM3dtOTJIS1hEeDA5anVOSmRvSXRJN2hvaktNdHFQQ3cyeTdObmZrelU5?=
 =?utf-8?B?U2FEbDRRVGFRR2lCakZsWXJkK1E1TXJ4NzdFSm1SdG5MbXloM3RuN1NTQkpZ?=
 =?utf-8?Q?ci3eoiP4OYTeZakRt/SgtjVCb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce62a8-3675-40b3-7327-08dc53e1e968
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 13:28:12.9638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/keyfO+nNildcld8IQM+khm9mMAphf2XLBNLWdil6wF8Zy6WJKYTakPDq2HL6ov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786
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



On 4/2/24 17:37, James Hilliard wrote:
> On Tue, Apr 2, 2024 at 6:41 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 4/1/24 01:28, James Hilliard wrote:
>>> There are situations where we may want to let U-Boot modify the FDT
>>> nand partitions for the kernel, such as when supporting multiple
>>> sizes of NAND chips.
>>>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>> ---
>>> Changes v1 -> v2:
>>>     - move partition fixups to board/xilinx/common/board.c
>>> ---
>>>    board/xilinx/common/board.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>> index 9641ed307b..20a6f00e45 100644
>>> --- a/board/xilinx/common/board.c
>>> +++ b/board/xilinx/common/board.c
>>> @@ -12,6 +12,7 @@
>>>    #include <env.h>
>>>    #include <image.h>
>>>    #include <init.h>
>>> +#include <jffs2/load_kernel.h>
>>
>> What is this header used for?
> 
> It's needed for MTD_DEV_TYPE_NAND.

Location is weird. Anyway applied.

Thanks,
Michal
