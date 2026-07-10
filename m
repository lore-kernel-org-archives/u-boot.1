Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCABC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 06:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3748407E;
	Fri, 10 Jul 2026 08:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ftMRcVIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14C6843B6; Fri, 10 Jul 2026 08:37:03 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBBE83FF5
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 08:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQtCppHumjVyJDBU7GZU5dxy2r/5m+HnpOQugNtnxM7PC743FkyzXyJMs4uJYHtzrZ//TaoaRG5clfV+Obj+QKiu763KPBYEyKv7r6YLTwflyA8N4PnZj79QQxGNbwIwZthXbGjtxdrR+GWMlVH4SG7yOn477lgyKKO/MJWIlJaY+0lq6yqmC0jvHKaVqErqXT96mzfLDVNPck+sQpNlYn+cpuamiKveZGR4n6vTU7VO/LR4MKZhsmgAxVYb2rxSBUTK/vy36XfHlT9IaZeSR0mVAycu93nowG0qx6Pb88TkVIHsYb4xN60SW4vyl1J/nmL86Rv+dPg/IMokFYSETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qko9L7yGcefgFd28q+gLAt9QVHT54SkNRzOwMRUsJe8=;
 b=tg6z+Q2H3slHSbq7kfmwFSVZeGFHRhdVKjlkjXTbZ9B8oV/DJ9StvDwMoLFTTuHIr81/Gi1lOMGwZEPV0BexPbd58Hks/4YtS4evcVTOtMPaFInZxZAztjLyzR7B2Pa0MW7RxnNBzL1vS3k4ScLr943mj/AZ0Gop6Nc+T6AJgT1ZTOPgXuHs+rf1LZ2hgwq8S8guxYr+VcIkEPkfjTDQkOCRudSPZuduWGsPMecGMTar22cOtwwGagCrSz115dh4pe3oR6tYiAWWXHOWmvbbcZQ/3zAoUFWSnCbdSeW1LUDnt+Dh4fPOWIrPwojdCgsUThnEXGbPy0h4uEt5SriLyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qko9L7yGcefgFd28q+gLAt9QVHT54SkNRzOwMRUsJe8=;
 b=ftMRcVIPCJqiXEhDr7GNRpW9NRu2HmEak/N+CW0PCZRy+UveW8PSepT9WQ0iy9wqopgJeITAkpecpb/BdSYZlr2ZoeuKx0GIjIVniUFLzdVi/+v/uWGR1bJfoUuyS2HGS3MPp61mIs16Gsu4oKFbYn5dQr5HTQvzWt7rMzZ9D1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 06:36:56 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 06:36:56 +0000
Message-ID: <3537f946-39d2-4e75-9c19-2ea5f00ba92c@amd.com>
Date: Fri, 10 Jul 2026 08:36:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
To: Anup Patel <anup@brainfault.org>
Cc: Charles Perry <charles.perry@microchip.com>, u-boot@lists.denx.de,
 Rahul Pathak <rahul@summations.net>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>
References: <20260708215200.1331416-1-charles.perry@microchip.com>
 <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
 <ak+2LeDbngEr7oqj@bby-cbu-swbuild03.eng.microchip.com>
 <7a17de63-6cd8-4c23-b111-f759ca6af249@amd.com>
 <CAAhSdy0U1tqNReK-ED1ofs2cqz2ed55O+QUS0235WEaSrQm1Qw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAAhSdy0U1tqNReK-ED1ofs2cqz2ed55O+QUS0235WEaSrQm1Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: b49bb226-0a3d-4627-0f6b-08dede4da301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|11063799006|6133799003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f8TERpO8hm6LIygfAZRy8fFav38RO+ZseCjAAPtw/SLF7wLCdlKuEPx+1cvlUspCCi9NWggkrzdOPsI9aH2AWIATVIrwEyHagz7AzWln6vfCleqtRkmcuvb40F1NzMa+3orVeCljeGutNUi4C1K5Uoy3Ff1WB3O3EZW3bYC+zXjOnqt6TYVeV/MLOrJHVRfXBwlnkpXubd5gE0XM93JqIC6v88MRA+szD7DBDClmF089MUEVz2CW1ApHOh/t7CPOW3caIqjNcNFNzSpCqJHlVFdpzViro6OhtXb5hBB62FsYz7VvsM9G2AZzwBit31LWbkzX/fS2q6xcr4wssnon74Hq+pLAqcmA1HTXOw5QUJYbTLsq6NWdE2LjNW1e4OjOeIwaYnfr3T0sHC0XOIoxOhu/7ftrulclvNpHJozyk36rZmysgwcgd+e4y03udL7MPRONi4lTxo0RHysbpY6/0lMT8AD7X/cEvFBiMBPD7Flxzz7IbFD2uUGq7Khl5LGe+BnDMpXC+r4g6q+Y46cbSOBm9jAunKk9jPUwvhjwHU61N/PxX+oNKLM8hScVn0NWmXzBXIhvPuYC24v05udE9YkWLc8X/Dm+al9wUQ5+7aGgrgN/ZuuoeUZ5/7rz/ees
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(6133799003)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZ5dHZDd24xS2kzT052aEx6RXdMTCs5Mlp6Um5GZUFIZUsrUk1qWmV6dzg4?=
 =?utf-8?B?d0NqOTJpN2ZXdjFmNXJTUW9kUlNMM1dBUUloQk85amZYNHlkYVAxOE9QMk85?=
 =?utf-8?B?dXB1elFWeGpNTnF5TE90amlnWVBXclMwbnk4U1pSVFdHZGFTNDRBT0ljb0RX?=
 =?utf-8?B?OEJjbTY1Z0tMZlhjbnB6aVlWWWU5VytLZThoaW5QZDcyUVF3elpyaElJbnpq?=
 =?utf-8?B?RkVNUTlHRyswc3YwRThDLzY1VTYwVllwdVBUSHJaK3VERlBLbGg3SWxOenVF?=
 =?utf-8?B?aGM5eHBBS3I3UFFEcy9nZVkyNE9xa0liSE1yNGl1WThDYy9acGxsL1k3QUk1?=
 =?utf-8?B?T1ZUVk5QSTQrbDlIQW5Ya3RlSStpVFFYYldWa09HUXdmOS9IZGhHTVYzcU4w?=
 =?utf-8?B?TExLLzR5WTNjU21NVWR2Sy80WFVkTks2UXNkY3FTbWhoQlJVaHIvZ0FjNnZx?=
 =?utf-8?B?Vzk3TW8xRmJSZ1RoV1V3TkdZZHNKcUJFRWZQNCtoVGhyR1ZSclArTGl6clhC?=
 =?utf-8?B?d1hxL29UcURCTkNlY1N0WVFBMFNOWnpSVkJWZzhzOXc5Y2Y0WjUxOFRoWHVs?=
 =?utf-8?B?YWdkZUkwdjBJdlN5ZEcxY1dJVThvbDYyQ0tDcTlGcXdmRmFldWloNzNaMUV6?=
 =?utf-8?B?TkFSTW1MdkFOYzZackpPVmc1cUFjZmhDMFYvbk5XRnFoVXdHRmJJc29CVnN0?=
 =?utf-8?B?UjV0cytSc21oUXgxa0ZKaEY5UjRTQkQzckVUZWZPdjF0eWJSRFZsMXpvRkxu?=
 =?utf-8?B?ZHl6RGR1R1dtLzdYaTVKc3Mzb0hPazlibUpoRDBuZ0xFZU8rTnV0QnhxcDh4?=
 =?utf-8?B?cUNhcVRKKzhQbTNJNHcwUkN4eHhpSXlDMWw4SmkzY3hpd2tNYTRpa3pscURT?=
 =?utf-8?B?OEJCZ3h2a2lvSWI5aEZCZGRUckhsUnU4Z2xTRFVSbnhwWTRUT1MydkhTcEw1?=
 =?utf-8?B?YkF3S0tneWRoZnc5aGtZV1daWVNyMDBIWG5QWFMxREtGakJxQVlCUk13QkMz?=
 =?utf-8?B?NmhsTkl2ZWZyQXdDMWdmVkQ2WE1iVnpSeC9NOFUvamFDRjBhS1ppaTJxSzBG?=
 =?utf-8?B?SnV0OFZYRkl6c1k5cDYyb2liemxaZ3VKVlF5c1lhcVBrcDJRQ1Y1V1RCSlhm?=
 =?utf-8?B?NlZVQUJhU045WVh1eTBrZkFwZko2R3NPNzRrdCsvb042UkFWeVVmKzlya05H?=
 =?utf-8?B?ZWZOOWtPWnhSQTBNRjhFbks1Z0wwTFE2ZitwYThDcmVlQm5Mek9STkRoZE96?=
 =?utf-8?B?OUtEMmVOZmJaaW1QV1Y2dnM0dEd3V0RSR0dOUDk5Zy9FREtPQkRaQzlMTjBT?=
 =?utf-8?B?QVVld3VpYVRHR05mVXRCREs5czJjaUlNbnJCRElLcC9PcU5hWjg5SGh1Uk95?=
 =?utf-8?B?bC9xRHl5Ni90MHl6S3dKQjFPK1k2MTRsK0FsdHAwMnR2Q2FsanhiREdGNVhJ?=
 =?utf-8?B?UnI3TzMxYzdtNThnL2lOVXMyNkt0TllkOVZkRUpqSmx2WnZCKzhQTEVaMW9C?=
 =?utf-8?B?TFM5bFZhcHc1b3dGYzJNSktjODFNWG41VlJ6OWFPWEcybmpSSkpNWDk2dDFE?=
 =?utf-8?B?NFRVR0RsWWxwbWxNUkVrR0FDdzNqWVh3Y2lEejA2S1dzNGRNK05jV2V1N2JE?=
 =?utf-8?B?NjNGYll5dkxWMzUwOWg2d1A4OWh0MWhRSWNZamdRb0EvdE83aHpYdU1EVmtl?=
 =?utf-8?B?YUQva3N1cnJGbjExVGpPbFdkMk51YVpkaUZiOFhlUUtEMGpmNlNpeWQxNW00?=
 =?utf-8?B?NWF2a0VoY2g5cGZHTitDbWtlaTZ1aDAxY0luN0t0VVRCK0x3bVFmNnMwK2Fn?=
 =?utf-8?B?Nm80TUM0ZC91Rm9qUnVRYWdWa01wUXpQZ3h1ZW42eWtqaUh0RHpuTmhvanZs?=
 =?utf-8?B?bXM4MXFBNWJBUHhCa1JoTVk5c0cxanBpakI4cit2TC9ZTDNneC84TWg5OHhJ?=
 =?utf-8?B?UUZ4NndqZ1E2dmpCT2txT0VqY2xJY2JReGJTMlBCaFovZm5BYklYWExhV3NQ?=
 =?utf-8?B?N2s1ODhCTXhGcXVXSFd0dnJDRFMxWkg0R3RCOWcxSDlnd2FEMFQ5VDllL01K?=
 =?utf-8?B?bmhyTGhaMDlUb0NmN1pSUmdMWGFGMzdUVnB5eEpkZW1QcGdBMDVXMElpS0hw?=
 =?utf-8?B?U0lSVkNmcTBsWFNSUnlTRVJpYkdndzlSalpkSnMrZmx1eVZqUVpwRkw3N2pp?=
 =?utf-8?B?RmEyb0ZHYWFVNUlKQjF3Tk1tOXJQTHJ6OGlXemFLRlVGUVNKblkxWkJPUHZY?=
 =?utf-8?B?SFUwSFVSdzFSbFZEck9vY2t0aTJraDhnbm9SRFJVdU9tUjJhdzRPMGUwaXR0?=
 =?utf-8?B?QjNCTW14TkRkWlRvUGZmcHhjYjB6eFo4YkF1aE1IYzh1akMwNk9YUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49bb226-0a3d-4627-0f6b-08dede4da301
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 06:36:56.2559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tRAuUU+yI3SUKWz4taM3Glf71y8NhsMQIQNjsT4IAIMVDhFMt3kOfzPJaYxQqIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
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



On 7/10/26 05:08, Anup Patel wrote:
> On Thu, Jul 9, 2026 at 8:50 PM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 7/9/26 16:54, Charles Perry wrote:
>>> On Thu, Jul 09, 2026 at 03:02:11PM +0200, Michal Simek wrote:
>>>>
>>>>
>>>> On 7/8/26 23:51, Charles Perry wrote:
>>>>> Hello,
>>>>>
>>>>> This series adds support for RISC-V Platform Management Interface (RPMI) to
>>>>> U-Boot. RPMI is an OS-agnostic protocol for communication between an
>>>>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
>>>>> goals and purpose of RPMI are similar to ARM's SCMI.
>>>>
>>>>   From the first look it looks like SCMI. Why do you introducing something
>>>> what can be replaced by SCMI?
>>>> And SCMI has only specific ARM transport layer but the rest is arch independent.
>>>
>>> Yes, there are alot of similarities between RPMI and SCMI. I found some
>>> justification for this in some Linux Plumbers slide deck on RISC-V power
>>> management by Paul Walmsley [1]:
>>>
>>>    * The hardware is more sophisticated
>>>    * The software is more sophisticated
>>>    * Some stakeholders haven’t had input in the past
>>>    * RISC-V “big tent” philosophy
>>>
>>> I think this is referring to the SBI spec of RISC-V vs arm's PSCI but the
>>> same arguments may as well apply to RPMI vs SCMI.
>>>
>>> Some other arguments:
>>>
>>>    * The microcontroller side is made easier with RPMI because of librpmi [2].
>>>      SCMI has SCP-firmware [3] which is a quite complex project compared to
>>>      librpmi. Also SCP-firmware doesn't accept contribution anymore.
>>>    * RPMI is already in Linux.
>>>
>>> For what I'm doing, RPMI is what gave me the first results (controlling
>>> clocks) the quickest because all the pieces were present in Linux, OpenSBI
>>> and librpmi. There are however lots of missing service drivers in Linux and
>>> some other important OS like u-boot don't have support for RPMI at all. So
>>> even though I gave you a bunch of reason for saying yes to RPMI, I do have
>>> some doubt about how long it will take to bring RPMI on par with SCMI,
>>> making the SCMI-for-RISCV transport that you suggest more appealing.
>>>
>>> [1]: https://lpc.events/event/2/contributions/197/attachments/133/165/RISC-V_Platform_Power_Management.pdf (slide 22)
>>> [2]: https://github.com/riscv-software-src/librpmi
>>> [3]: https://gitlab.arm.com/firmware/SCP-firmware
>>>
>>>>
>>>> In our case where we have Microblaze V in programmable logic I can't see any
>>>> reason to use RPMI for talking to the same server if I need to do it from
>>>> ARM side too via SCMI.
>>>>
>>>> I pretty much think that there should be communication with ARM and instead
>>>> of creating another firmware interface talk to each other and have only one
>>>> which can be used across multiple architectures.
>>
>> I have sent RFC patch to eliminate ARM from SCMI here
>>
>> https://lore.kernel.org/all/d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com/
>>
>> and feedback is quite positive. I think it is more or less question to Microchip
>> if you want to take responsibility on another firmware interface (I understand
>> that it is approved, etc) or just use what it is around for longer time.
>>
> 
> Simply renaming the Linux sources does not make the SCMI specification
> to be open and community driven. The real problem is SCMI specification
> development is not open and community driven with appropriate permissive
> license.
> 
> Some of the note worthy highlights of RPMI ecosystem as compared to
> SCMI are:
> 
> 1) RPMI specification is an open an community driven specification licensed
> under "Creative Commons Attribution 4.0".
> 
> 2) The scope of RPMI specification is much bigger than SCMI specification where
> RPMI is trying to consolidate all required messaging protocols under one RPMI
> specification. RPMI defines some unique service groups in-addition to
> the service
> groups providing SCMI-style functionality such as:
>     2.1) Collaborative Processor Performance Control (CPPC)
>     Allows application processor to abstract out CPPC support to a
>     microcontroller. It also has fast-channels for hot-path CPPC registers
>     such as desired performance and current performance level along
>     with RISC-V specific fast-mechanism to access delivered and
>     reference counter.
>     2.2) System MSI
>     Allows system-level events to be sent to application processors as MSIs.
>     This is used for graceful shutdown/reboot request, hotplug events, etc
>     2.3) Request Forward
>     Enables one domain / world to receive messages forwarded from
>     another domain.
>     2.4) Managment Mode (MM)
>     Allows UFEI / EDK2 firmware running on application processors to talk
>     to managment mode (other domain / world / microcontroller) for secure
>     variable updates and other MM services
>     2.5) RAS Agent
>     Allows UEFI / EDK2 firmware to discover error sources handled by
>     firmware and generate RAS related ACPI tables at boot-time
>     2.6) Truested Execution Environment (TEE) (Work-in-progress)
>     Provides a rich and extensible TEE communication interface between
>     non-secure world (Linux) and trusted world (OP-TEE and others).
>     2.7) ... and more to come ...
> 
> 3) The LibRPMI project which a open-source reference implementation of
> RPMI is permissively licensed under BSD-2-clause which allows platform
> vendors use any RTOS / baremetal-app as their microcontroller firmware.
> This library is also shipped as a shared library allowing QEMU to use
> LibRPMI for emulating RPMI services for TCG and KVM guests.
> 
> 4) The following Linux RPMI drivers are already available in upstream:
> MPXY mailbox controller, RPMI clock, and RPMI system MSI whereas
> the CPPC, LPI and system suspend drivers already work as-is for RISC-V.
> The upstreaming of RPMI performance driver is in-progress and should
> be merged soon. The OpenSBI (M-mode firmware) already supports
> almost all service groups defined by the RPMI v1.0 specification.
> 
> Based on the above facts, I would suggest AMD to consider using
> RPMI over SCMI.

In the Linux kernel when I do grep RPMI I see that it is just tighten to RISCV.
If this is community driven effort and based on what you are describing above 
(based on you better then SCMI) why is this connected only to RISCV. I would be 
very surprised if this was labeled like this that none raised this concern.

If you look at FirmwareHandoff as another example of community driver 
specification which is architecture neutral or trying to be.
https://github.com/FirmwareHandoff/

I would rather see one specification which is trying to solve the same issue 
where vendors are talking to each other to achieve the same goal. Instead of 
another firmware specification which should be adopted, reviewed, tested and 
used to serve the same purpose. And also not solving problems on heterogeneous 
systems with mix of architectures.

Anyway if this is real community driven spec I am happy to join that discussion 
and ask above question. If this is arch neutral I can't see any reason why there 
should be riscv in compatible string and Kconfigs setup for RISCV only.

Thanks,
Michal
