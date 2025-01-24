Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E6C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355C5807E4;
	Fri, 24 Jan 2025 10:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qjaGn49k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBBD807FE; Fri, 24 Jan 2025 10:01:26 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A47D80780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-vm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50O91JsB1356733
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 03:01:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737709279;
 bh=UmPzjJY/+bZCSsrFonLrYg9SZVshVmkmDAsTf8DiLpo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qjaGn49kyJ41Syhz9tQz6kjfr7sqH0sFwU9N8A4zLtS9qDDGnqYS9T6H2PeF8bbm/
 mBtaW6599KHXL/WepiH/0C9gUTSITxRHcHYgv7Rveuv3nY7DcRTrF7DxOGTGlXCVy/
 28CXzF9dTt2Rzvcg3xVNYsBRrR7CdFa4l7cHeND8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50O91Jlt016021
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Jan 2025 03:01:19 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 Jan 2025 03:01:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 Jan 2025 03:01:19 -0600
Received: from [10.24.69.179] ([10.24.69.179])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50O91FqU054083;
 Fri, 24 Jan 2025 03:01:16 -0600
Message-ID: <9cf9590b-e9ba-6d46-dd4d-80a71765e062@ti.com>
Date: Fri, 24 Jan 2025 14:31:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: Proposal for a New Command to U-Boot Fuse
 Programming
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: <sjg@chromium.org>, <angus@akkea.ca>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <kamlesh@ti.com>, <d-gole@ti.com>,
 <k-malarvizhi@ti.com>, <a-parmar1@ti.com>, <khasim@ti.com>
References: <1c2153bc-485f-a0f4-ac0d-fdc29065e235@ti.com>
 <20250106222314.GF3476@bill-the-cat>
 <5e166f95-681a-8a96-0d8c-033c36d47d5a@ti.com>
 <20250122172209.GN3476@bill-the-cat>
From: Harsha Vardhan V M <h-vm@ti.com>
In-Reply-To: <20250122172209.GN3476@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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



On 22/01/25 22:52, Tom Rini wrote:
> On Fri, Jan 10, 2025 at 11:12:47AM +0530, Harsha Vardhan V M wrote:
>>
>>
>> On 07/01/25 03:53, Tom Rini wrote:
>>> On Mon, Jan 06, 2025 at 12:06:25PM +0530, Harsha Vardhan V M wrote:
>>>
>>>> I would like to propose a new command for U-Boot's fuse programming
>>>> functionality to address the challenges posed by the current implementation.
>>>> While the existing fuse prog command works well for programming individual
>>>> fuse values, it becomes cumbersome especially when dealing with large-scale
>>>> programming requirements.
>>>>
>>>> Current Command: fuse prog [-y] <bank> <word> <hexval> [<hexval>...]
>>>>
>>>> This command programs one or more fuse words starting from a specific <bank>
>>>> and <word> with the hex values given as input.
>>>>
>>>> While functional, it lacks the efficiency and robustness needed for
>>>> programming a significant number of fuses or handling structured fuse
>>>> configuration data. Repeatedly specifying values for each fuse bank and word
>>>> is not only time-consuming but also prone to errors during manual input or
>>>> scripting. This approach does not leverage the ability to process
>>>> pre-structured data in memory. For users with complex programming needs, the
>>>> current method becomes an obstacle rather than a tool.
>>>>
>>>> Proposed Command: fuse writebuff
>>>
>>> It would be good to provide some documentation links to the fuses that
>>> you're wanting to deal with. What we have now works on a number of
>>> diverse SoCs, even if for some cases it might be best to write a
>>> script that's run rather than copy/paste things live. Any sort of new
>>> mechanism needs to get feedback from users at other semiconductor
>>> vendors to make sure it's generic enough for everyones needs. Thanks.
>>>
>>
>> Hi Tom and Simon,
>>
>> The buffer is not a text file. It is a structure in memory. The buffer is
>> structured to contain all necessary information for the fuse programming
>> process. This can include metadata, fuse programming data etc. The exact
>> structure of the buffer can determined by the command_id, which provides
>> flexibility for supporting different use cases. The memory buffer is
>> typically prepared in user-space code or a script and loaded in memory
>> before invoking the fuse writebuff command. It is not stored as a text file
>> or any other file format, as the command operates directly on memory
>> addresses.
>>
>> Example of a buffer:
>>
>> struct fuse_buffer {
>>      struct fuse_mpkh smpkh;
>>      struct fuse_msv msv;
>>      struct fuse_key_cnt key_cnt;
>>      u8 buffer_hash[64];
>> };
>>
>> This fuse_buffer struct will be loaded in memory containing all the
>> necessary information for fuse programming.
>>
>> struct fuse_mpkh {
>>      u8 mpkh[64]; // public key hash
>>      u8 bch[8];
>>      u32 attributes; // read-protect, write-protect, override, active flag
>>      u32 reserved[2];
>> };
>> struct fuse_msv {
>>      u32 msv_with_bch; //model specific value
>>      u32 attributes;
>>      u32 reserved[2];
>> };
>> struct fuse_key_cnt {
>>      u32 key_cnt; //key count
>>      u32 attributes;
>>      u32 reserved[2];
>> };
>>
>> -> eFUSE layout is abstract and isn't public as its programming and layout
>> itself is security sensitive (it has authentication and decryption keys
>> etc). So, fuse prog doesn't work as there is no "banks/offset" here.
>> -> Platform Security Core running Secure SW exposes APIs through which these
>> Keys and its attributes can be programmed. Whole content maybe encrypted for
>> enhanced security on unsecure factory floor.
>> -> There is a definite order in which these fields needs to be programmed.
>>
>> Its possible to break the struct into 32bit values and send them across but
>> we would end up with ~30 odd fuse prog cmds which is inefficient and error
>> prone.
>> It would be hard on secure core to also ensure correctness of operations
>> against all sorts of silly errors (such of accidentally skipping a word or
>> mess up ordering) which can render Silicon unusable.
>>
>> So passing a opaque pointer with a command_id to Secure core is all that
>> fuse cmd needs to do which is what writebuff supports.
>>
>> This can be extended to any vendor; It's just an opaque pointer handoff. I
>> see at least one other vendor do it in custom way:
>> arch/arm/mach-imx/cmd_dek.c which could benefit from this new cmd fuse
>> writebuff.
>>
>> Here’s how the fuse writebuff command works in a typical flow:
>> 1. Buffer Preparation: Vendors or developers create a complete buffer (e.g.,
>> key.bin) containing all fuse programming data using vendor-specific scripts
>> or tools and copied to SD card.
>> 2. The buffer is loaded into memory using commands like:
>> fatload mmc 1 0x80000000 key.bin
>> 3. The fuse writebuff command passes the memory address (0x80000000) and
>> command_id to the secure core:
>> fuse writebuff <command_id> 0x80000000
>> 4. The secure core receives the memory address as a pointer and validates,
>> interprets it based on the command_id and then programs the fuses.
> 
> To summarize what we talked about on a call, I would like to see either:
> 1) Work with arch/arm/mach-imx/cmd_dek.c and use that as the base of
> some new generic command that deals with SoC-specific fuse
> configurations that are handled via security processor.
Hi Tom,

1) I have looked at arch/arm/mach-imx/cmd_dek.c. The underlying 
implementation data structure is very specific to the vendor and how iMX 
devices are configured. The other vendors would also differ in their 
structures and SoC-specific fuse configurations, so I don't see a way to 
use this cmd_dek.c as the base and then abstract, create a new command 
out of it.

> OR
> 2) Create a new command (that should be in cmd/ti/) for handling the K3
> fuses, if we cannot make something abstract enough to handle this
> concept on multiple vendors while having any sort of useful code re-use.

2) In this case, I would like to add the fuse writebuff command for TI’s 
K3 architecture in cmd/ti/k3_fuse.c. And the command will look like

fuse writebuff <command_id> <addr>

However, I would still like to place the fuse writebuff command in 
cmd/fuse.c as a generic interface because the parameters command_id and 
an opaque pointer handoff provides a mechanism for the secure core to 
interpret buffers differently based on vendor or use case.

Thanks,
Harsha
