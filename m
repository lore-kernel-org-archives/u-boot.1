Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB0FC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 12:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1C487FDA;
	Tue,  5 Mar 2024 13:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hW5edWsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E34488033; Tue,  5 Mar 2024 13:35:09 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037F687FDA
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 13:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRpSr63psFV3lhroakOSX6N+962CheyRtnafgx9YZHl12W0j7SIBUj7CEqPwJtDa3BQmexzKTwUGavuQZtZjU44QjRr8Bn+W/SMWoL5xjEj1waMWZBdscWGYUqoRqMIHS11FFeOPN0Eaq5eEk4uOHjL/0EgAGIPjnV2hA9yAjiEHkK9uT1LdxFxNK+DGqnn/QEhiGx+MD5fcUwxAUW3kIVpLdD6dd+DXFK9O0t8btLumFPWTlrCO4zr1ekQ1v3jKqcBynKHO/EKO8RZaC6xH7OOWuKsbS/m9lOlUaxwfUYxvvYmTjXrDc6Ny5baY5qO06kKNQa2Q/E4TAGfNqQtTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrGckcpTm12StAoFP6wlimJrKkFgaq9WEtfHZAakhxY=;
 b=QK6+wD1W6Kz0o/WYdzSoAVuJNg0MwwJw8B+ekIIDn3iWpDLcbLF7Ijs8qVw28N9E9V9obzT2HWy95QDRwo0GATDQwS+6VwnYBTnRa9VdldGAw6y//8MCpp7JCAQrWfjcZqAp1TWpg8ecTPkQF6rdqd5h/xXJgPPd2RL1wvmi6xBZSShTlD9KFJ2MnOvhaet6L1C/KeejCNrC77Dekz6A4qdiRR5XHOupKLg4Oo60mJouYXXTp7cGbfODaW9KNhr+u2HGR9JKMaRyYUR6zBOJ3kBupcBn8tEuTWAe5nZRDguK7BwWq5BQXmNp2jWHAzifPz9XGEup3jKHeoKQkhSwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrGckcpTm12StAoFP6wlimJrKkFgaq9WEtfHZAakhxY=;
 b=hW5edWsqB2Q7ApuSflt0n25mtIfJ3pqEgbtaHTTdAsTCZbScsoDTTNtjbYShNW7+wSFW2Hp+Wo4mTpRGB1Cm+g4qQAzgMY1QEF9iBdw64smphB4XDYfvmM5KJdmi16D/uI8lmpEuNYkSf0O3aw+iQZFTRo/l4ui5bAykbTa/O1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 12:35:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 12:35:02 +0000
Message-ID: <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
Date: Tue, 5 Mar 2024 13:34:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Content-Language: en-US
To: Angelo Dureghello <angelo@kernel-space.org>, Tom Rini
 <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43)
 To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a90f10-9f72-44a5-9a53-08dc3d10adc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVEio5fX6oMK6XIPaAA1Zy7pCs+uAaaOVPYXBXIfoeUimL3I1yES20QLyBx953CAUD7VwjVUnHwGBlzZrQ4mqurwZjLFioFw69zZjYGFRY6rppq9t9Jut7N27BCkhzpxz7ThFlIQKG4Fiz7268XsQl17YpxG5bemIwqgB7SFqcrIA6UyiDWlSeRI7jREgWhZuvRzCivD+t2us77MedxzCoxni6OoL3jd+9kN+A11UdKxe10mphR2s8sK6lrsDtFlM3budHsymfBHVujpaHLIY914hG+WFAhghTIyKCreiBnIb300b120IoQ/mm6pOtBhVVcsE0TskAGOJhf0y0YSQAQwqYipjYuzlv7wyAr0deULjY3Y/VBQsbzOV4toBvb1xJcRTOfvNdGTASI+Xm3zvIW0mDV9xyeS6mSvl3BjVxkdx6ae7FIfqHXhUdhJTCVsKDC08114njS/31t4O0i088e63X8hUMU43V+9PACI2CJSMqpDq6zTlRfAc9NvDq554G07oo2IUjy2nWPpLlpHw9x2PGgHNM7Xpben9wMjWo9ZUaWwNCqXczPjaOJxTdNDtSsezVvcTTWwYfrsFODyHf40hXvJNh/5HvHV2kPCxRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enIwWDlqdUJNU1htdVhOemNoL0lLSGNJLzB3QjhLcUlxVVVjNjd6RmJtVUlH?=
 =?utf-8?B?TjE3NVRKQWpaYUxKYi84YjEzWnJLaHJjMjZRVm5xQnRPR3NoQnZtdkZiTGt2?=
 =?utf-8?B?cEk2ay9KSW9maGN1Z1VvR2JjcU1vYVcrWStDZnBSeFBEVGIrSW0zS3FqTlVw?=
 =?utf-8?B?RzAwNERIYjhmSGZRSTFjbkFwRmc1RE9UNTZrdW1DWVVSZ1YvcEhWNnRCeFNi?=
 =?utf-8?B?ZWkzcEoxUFF5bStuQWx2cVVYV1JXWlR4cnB4MXF6S3FOR0lTVWE3M2cza1Rs?=
 =?utf-8?B?WHBFYURoMXlVMmlCeDg3WnB1UzJNcnNvSVdwQThDUXJsWmE1NUk2dWsyeWc1?=
 =?utf-8?B?dTFDZml0REo2TXdHam9EYTRCbkN0M3d2ZHNyOTFmYXVQekc4Y2ZRL2ptYVVa?=
 =?utf-8?B?RSsyNTM2UmJ2VEcyc2VQM2FsTmJRVVVHUFRiQjFSTWl4MG5RWkRmMFUwckFI?=
 =?utf-8?B?TUp6am4wNGsvc28zTTR6VVdLQWtvaWNQZldzS0xlTlQxSTRYdXdlUko1VmVU?=
 =?utf-8?B?RHJwU0U4Z0U4dlBGOWVmWWxVOEdUd2g5aDhwSUVXQ2dBdWIwbTF0Z1cwN0RJ?=
 =?utf-8?B?ZWg4ODdvVU5ici9lR1k0RE15WU9yTE05dHcvMkUxVTNCWlNRNFNsd1FsUkZ3?=
 =?utf-8?B?VnUwamczYnc5dkQ0dTJvdElMTC8ycEF2YTNSRmlPWVZlcUF0RGpPUGtUZUFU?=
 =?utf-8?B?NnkzZXRLUEd1WFBFeXZTUTJwVE1iMjRaaElUMDZEWlB1VWNtRW04U3oxek10?=
 =?utf-8?B?WjBmWWtxb3VVMlI2NWJRbkxXSmNSTjNRL1BBVGN3aUp6YkJvMXpVS0kyOHcx?=
 =?utf-8?B?NnV1b3FhQ1ZOQkVxdmVFQjJLMXNIMDU1ekwwRG1BdzNwVGNxZEdPUXlkcWVr?=
 =?utf-8?B?NzZ5amhYVXVFS2wybEd6WmpkRjgwWUFndVY0cGlHekd6dzFnOU1nRzR3YzBj?=
 =?utf-8?B?V1hqU1FVNDZITWtjWmMyT2lSVnVEVytYRGpOUTBQNWowb0xVZGxlYTFERW84?=
 =?utf-8?B?NDZlVk1GaWp4YkcrbmxLSkZyV1NRbnoyajFUMjk0VnIwWmhuWUFvKyt0RWhQ?=
 =?utf-8?B?WjF4a242YkUzZHd5QkRZV2UvaWt2Q1hoRmdnYVFoRE55V29NUVZROFRKNWRU?=
 =?utf-8?B?S1FqcHQ3dDM1cHRnWm0wWDdHK3JSUVg1UUY5UkVRS2YyeXpuSWxJdGt6WVpn?=
 =?utf-8?B?Ukt4ei90dnpFZ1ZxdXRaUStLTlNRMVhQYWRmN0Nyb0JVUktOZzZLTVdCbW05?=
 =?utf-8?B?UUw4bjkwU3ZvSk5GTFlDU1p1bVZOTllJenNseUlYajJWVmpKTlVnMXFTRUZs?=
 =?utf-8?B?VFZWQ2p5NjNobW9RKzJZWFB0b2ZVK1E0Y0R0QTBscGdodUdvVHNUSmkzSWtL?=
 =?utf-8?B?cTFuUjJqeThjK3g4cHNua0R1WTQwV1lCMmt3a2JVZlFlcnYxSkxZeWdIWFFq?=
 =?utf-8?B?SkZTdklwLzdxaUxmeWh5Z1Vwa2ZuR3FSZXZ0dDRBK3JlUWsyNUc5cTJXM3Nt?=
 =?utf-8?B?YWF1MnpPdmFWcEZvNVowR3U0UTlYWHUxdmlRTHZCVUFBcHUzb1Q2clI2YzIz?=
 =?utf-8?B?WTNBc1YyMjJycDhLdU05dDlJd1lCeCtyOEE5Ty9vK1hJUzFOWS9SSkdON01z?=
 =?utf-8?B?REV6REhjSmlnYXJEdzVFVXRZck4zRFE1WHA3cStoVndaNnlYSFJtVHBSVlZI?=
 =?utf-8?B?Y1ZHaFVPRlEyNzRBbW02dVhJN2h2STQzeG81c0FleWVQTDBES0graGhhbUZ4?=
 =?utf-8?B?dEc4cmhnZVdZVm1zUFdNWERWdWR1dnU1NDRIOTBHeGhBQTVpNHMrbDVmMlBB?=
 =?utf-8?B?b1orU29keURKMXIzcjMvWXpmMGRoaUcrZndlVVpKU1pzK0ppRkppeU9SdC9B?=
 =?utf-8?B?OTcyRTJmWm9PNjBkVFd2b1E1K0c3aDh6YVdNOFk4djRycWpyUjRSejR1d3Bz?=
 =?utf-8?B?QkdkZjg0dkMvMmREN1U1aFFpUHpQU2hIN013QWpseVVEblI1aW13NjFSalk2?=
 =?utf-8?B?TWdObFM0TGptc09rTHV5YnFzQW1yUTBIVlNJdnUwaHZyd21kQ2l4T0ZoWVZH?=
 =?utf-8?B?VTdtNXp0UzJUWERRT3MxUWpXR0lTWWt2dDdyTFF3YUxsaFpNellTTW8ycnV0?=
 =?utf-8?Q?z8AO+zrp8lBVtd2i5uLstv7yv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a90f10-9f72-44a5-9a53-08dc3d10adc2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 12:35:02.4771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoyNk/llDWXH+YbF+Mfn1HgVUsjHt0kVtlAcoCIwdPpwoH1dfozndi/VWousYeTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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



On 3/3/24 22:58, Angelo Dureghello wrote:
> Hi Tom,
>> On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
>>> Add a test for reset commands which performs resetting of CPU, It does COLD 
>>> reset by default and WARM reset with -w option. Signed-off-by: Love Kumar 
>>> <love.kumar@amd.com> Reviewed-by: Tom Rini <trini@konsulko.com> --- Changes 
>>> in v2: - Set bootmode through boardenv if modeboot is not defined Changes in 
>>> v3: - Fix the issue with bad pattern found on console --- 
>>> test/py/tests/test_reset.py | 61 +++++++++++++++++++++++++++++++++++++ 1 file 
>>> changed, 61 insertions(+) create mode 100644 test/py/tests/test_reset.py 
>> I had hoped this was all sorted out now, but both this and the saveenv test 
>> cause qemu_m68k to fail now. See: 
>> https://source.denx.de/u-boot/u-boot/-/jobs/791635 
> looking into this.

Is reset implemented in qemu? It should be skipped if it is not.

Thanks,
Michal
