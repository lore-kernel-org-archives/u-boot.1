Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA141CF45CB
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 02:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F979836AC;
	Tue, 13 Jan 2026 03:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nD9LpDye";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZtJxSMgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B41E8389A; Tue, 13 Jan 2026 03:04:36 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC49083045
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 03:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dqsxs39R0z9sst;
 Tue, 13 Jan 2026 03:04:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768269873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSoif//m2arfw75oAgxTTYOoPeh2Nfa1qGcKJjeDcNA=;
 b=nD9LpDyerGxmnHmCfeANIOWqB1cxPc0chXSyLoZxXMtI5NmPj/o3YTX2V1ixTIjCrJrc7l
 PfpOtKMLYDFVvKI8Ni3yCL964lEfKSHhH2gxojaQe9Phf5oSmTjgm+9yU7i8ySCt2UERwK
 khh3q5/KE9tB/nHhr9oUAVSQgThJhlN558GGjghuiBMZvOKAbdhwKuROkbhZud1EMAG0wV
 H05q4Yw1h1AEjPQkAu7FGyfe71OuTYFEtCMScIFhbHIT9Z4s7U9SrjjH1f5g0EJvKDKgnV
 QCQk0yrNhHk4A0jngfWOoUiJJ17FtWfmlWUi8wfoA2xxngjY9nr+g9mNucmyqQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZtJxSMgD;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768269871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSoif//m2arfw75oAgxTTYOoPeh2Nfa1qGcKJjeDcNA=;
 b=ZtJxSMgDenSeOzibQuTKDnWsu6Sw9a6aq+Pklzt02+dGfpoXMQ1mclpiMscLLjyhRfDQEi
 ocAkUje9XfdhaivyefyISeUsMeArg4GibuFkAknKf/R39CV6XCs9v56zOR61KctEdj9f0W
 sxIcMMAzl6/GGMST1b1jqRaDq/y8QUiZJ/x2aSh1QEFxIuctWQTmIFE50Yoz1cs8fAc+zj
 TN3d9nUm6CcMDDicE7eqSn5u7eZvkAr/cYbUGQP4zpbis8c8W7Z5JNL32BsaEeHAMw/SiH
 uDfEYK/i9qi+VnPYIuwGxlXyoEsiYnsJ8CR7/WdtMDFTRLzzYKpsnw5+dKwtxQ==
Date: Tue, 13 Jan 2026 00:56:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, marek.vasut+renesas@mailbox.org,
 james.hilliard1@gmail.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com> <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
 <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
 <20260112220536.GU3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260112220536.GU3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1d67df2f5b897a5dff7
X-MBO-RS-META: u3cwnbtk5aitd6kd3sczgiybwnuupx7a
X-Rspamd-Queue-Id: 4dqsxs39R0z9sst
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

On 1/12/26 11:05 PM, Tom Rini wrote:
> On Mon, Jan 12, 2026 at 10:56:04PM +0100, Marek Vasut wrote:
>> On 1/12/26 5:48 PM, Tom Rini wrote:
>>> On Mon, Jan 12, 2026 at 06:38:19PM +0530, Anshul Dalal wrote:
>>>> On Mon Jan 12, 2026 at 3:41 PM IST, Beleswar Padhi wrote:
>>>>> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
>>>>> a 4-byte alignment directive after the __u_boot_list section. This
>>>>> alignment directive only advances the location counter without padding
>>>>> the actual binary output.
>>>>>
>>>>> When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
>>>>> data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
>>>>> not an aligned address (e.g., 0x41c35a00). So, when the FIT image
>>>>> containing device trees is concatenated to the SPL binary, it gets
>>>>> appended at this unaligned file size, causing libfdt validation failure.
>>>>>
>>>>> To fix this, move the alignment directive into the __u_boot_list section
>>>>> itself and make it 8-byte aligned as per DT spec. This forces the linker
>>>>> to include padding as part of the section data, ensuring objcopy
>>>>> includes the padding bytes in the binary and the appended FIT image
>>>>> starts at an 8-byte aligned boundary.
>>>>>
>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>> ---
>>>>> v2: Changelog:
>>>>> 1. Get rid of extra ALIGN() directive, replace it with a comment
>>>>> 2. Carry Reported-by, Closes and Fixes tag.
>>>>>
>>>>> Link to v1:
>>>>> https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/
>>>>>
>>>>>    arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
>>>>> index 3bb759d8a1c..5ad169a37b7 100644
>>>>> --- a/arch/arm/mach-omap2/u-boot-spl.lds
>>>>> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
>>>>> @@ -35,9 +35,13 @@ SECTIONS
>>>>>    	. = ALIGN(4);
>>>>>    	__u_boot_list : {
>>>>>    		KEEP(*(SORT(__u_boot_list*)));
>>>>> +		/*
>>>>> +		 * Ensure 8-byte alignment at the end of the last section before
>>>>> +		 * DTB is appended, to satisfy DT spec alignment requirements
>>>>> +		 */
>>>>> +		. = ALIGN(8);
>>>>
>>>> I wonder if there could be a better way to handle this constraint,
>>>> currently we have two major problems with this approach:
>>>>
>>>> 1. All platforms facing similar alignment issues would have to modify
>>>> their linker scripts.
>>>
>>> Yes, agreed.
>>>
>>>> 2. The FDT only gets appended directly to SPL binary in cases of
>>>> CONFIG_SPL_SEPARATE_BSS. Otherwise we do (SPL binary + BSS + FDT) as per
>>>> the $(obj)/$(SPL_BIN)-dtb.bin make target. Which means BSS would have to
>>>> be 8-byte aligned as well as the SPL binary.
>>>>
>>>> I wonder if we could have a new make target for say
>>>> u-boot-spl-nodtb-aligned.bin which is just (SPL binary + optionally BSS
>>>> + padding for alignment) and at runtime we modify the fdt addr in gd to
>>>> point to the correctly aligned address?
>>>
>>> Looking back at
>>> https://lore.kernel.org/all/87h65ihumb.fsf@bloch.sibelius.xs4all.nl/ we
>>> can use dd as a portable way to ensure that a file ends with 8-byte
>>> alignmnent by doing:
>>> dd if=testfile bs=8 conv=sync of=testfile_pad
>>> and we get a zero-padded 8-byte aligned output file, and at the end of
>>> that we can concatenate our dtb.
>> You still need to make sure there is a symbol generated by the linker that
>> points at the END of the u-boot binary . dd happens too late, so you cannot
>> do that. The alignment has to be done by the linker, in the linker script I
>> think.
> 
> I guess the question is are we:
> a) Look at $sym for device tree, and so $sym must be 8-byte aligned.
> b) Look at end of self, rounded up to alignment, for device tree
> c) (a) on some platforms (b) on other platforms
> ?
$sym is at the end, which is not always 8 byte aligned . See 
lib/fdtdec.c for the relevant code:

1243 static void *fdt_find_separate(void)
1244 {
1245         void *fdt_blob = NULL;
1246
1247         if (IS_ENABLED(CONFIG_SANDBOX))
1248                 return NULL;
1249
1250 #ifdef CONFIG_XPL_BUILD
1251         /* FDT is at end of BSS unless it is in a different memory 
region */
1252         if (CONFIG_IS_ENABLED(SEPARATE_BSS))
1253                 fdt_blob = (ulong *)_image_binary_end;
1254         else
1255                 fdt_blob = (ulong *)__bss_end;

