Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDFEEEA854
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 21:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E80582BF2;
	Thu, 12 Feb 2026 22:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KtPz+EVE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JdHX4Bwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4992883015; Thu, 12 Feb 2026 22:44:08 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74DE580FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 22:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fBpj11r1Yz9sqq;
 Thu, 12 Feb 2026 22:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770932645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybGh0Wq9rRhNJRTZFf3gK8rblVmDmg70/4wa09mUwbk=;
 b=KtPz+EVE/yYtLvUpqBYXchKoazZDjZuktfNBoGbPPR5E14rYR19b3KWvEPgayqx0DhCber
 KQU+JQ4lbGdk1ROnBeK5Bz5fhZDrSyI/cAjR5i3NExNiYJhsLSaBV5ifR4+Dq69qmntQ/i
 YdlLC/RurTt4XAeCua9jZDDZi+nFttzMLMCSzDA8wkMnmenL3OnIL0FajADz8eTDguGxBV
 y1kg1td6+4q/QzvkkffwasMpkNIAMzBcKmLaHI+zuWu1VFcROrJRm+oE+jrcdT5EuYXyRt
 bF20Q7+VLfmZdpYayQ1FS0lzzg/mwOIucUKEcMqpeeEYmuOKG+WQYSlSOIqqDQ==
Message-ID: <a858e423-8f31-45d7-8592-a4439ba0c2b0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770932643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybGh0Wq9rRhNJRTZFf3gK8rblVmDmg70/4wa09mUwbk=;
 b=JdHX4Bwhb0h9H2r7sW+i9r1jkkVjP3PUOAONzDprr7354uCSJu908JfrSxAnq4E7jl6FCU
 WZ2A1KIN7e79nBgQ88hx08tb4AwaSPz1fD6o56P4NZb21mSbEVSj98iYlMKy3DYZyBlQT5
 qcALnGLYe6oEK16FbklsUdtaGm3OmGaM0uefpbKkAmtrKAcBGNZrk7EhYN2MVMXyNqchmK
 BgM1uES6FS4gulda8zuU8kK/Vzw64INKOc06Crds05NsJe6G29n9c4KmFVS6V+QJeVZ3bu
 3tbcgJ5G3sDvc0uC6jJKqkGLS/s9PhRDk047a1MLuxdVQ9nhGW6SnWSMUIsprg==
Date: Thu, 12 Feb 2026 22:44:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Jamie Gibbons <Jamie.Gibbons@microchip.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
References: <20260211180645.3313596-1-james.hilliard1@gmail.com>
 <cf72da71-12f3-45ab-b703-6cc776ed28ab@mailbox.org>
 <CADvTj4qtaoyJc9MtbjbpC+t_h3yO=jBXNed_3BAmDWMbDbhRPg@mail.gmail.com>
 <a00c737b-4f8f-4e26-974b-aa14ebbef64b@mailbox.org>
 <CADvTj4pXOQ5KKJa2ZmU0WhaqMYYS8k9AXd8xZ6Uv1HvW-H_wpQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CADvTj4pXOQ5KKJa2ZmU0WhaqMYYS8k9AXd8xZ6Uv1HvW-H_wpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z83badp58um635hm8bkr4rqbh8c65xx8
X-MBO-RS-ID: 918c69d1f46f873ac9d
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

On 2/12/26 10:32 PM, James Hilliard wrote:
> On Thu, Feb 12, 2026 at 1:05 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 2/12/26 8:52 PM, James Hilliard wrote:
>>> On Thu, Feb 12, 2026 at 8:26 AM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>
>>>> On 2/11/26 7:06 PM, James Hilliard wrote:
>>>>
>>>>> +static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
>>>>> +                                     ulong extra, ulong min_dstlen,
>>>>> +                                     void **fdtdstbuf, ulong *fdtdstlenp)
>>>>> +{
>>>>> +     const void *fdtsrcbuf;
>>>>> +     void *tmp = NULL;
>>>>> +     void *dstbuf, *newdstbuf;
>>>>> +     ulong dstlen, newdstlen;
>>>>> +     int err;
>>>>> +
>>>>> +     /* Make sure the source FDT/DTO is 8-byte aligned for libfdt. */
>>>>> +     fdtsrcbuf = src;
>>>>> +     if (!IS_ALIGNED((uintptr_t)src, 8)) {
>>>>> +             tmp = memalign(8, srclen);
>>>>> +             if (!tmp)
>>>>> +                     return -ENOMEM;
>>>>> +
>>>>> +             memcpy(tmp, src, srclen);
>>>>> +             fdtsrcbuf = tmp;
>>>>> +     }
>>>>> +
>>>>> +     newdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
>>>>> +     min_dstlen = ALIGN(min_dstlen, SZ_4K);
>>>>> +     if (newdstlen < min_dstlen)
>>>>> +             newdstlen = min_dstlen;
>>>>> +
>>>>> +     dstbuf = *fdtdstbuf;
>>>>> +     dstlen = dstbuf ? *fdtdstlenp : 0;
>>>>> +
>>>>> +     /*
>>>>> +      * If the caller already provided a large enough writable buffer,
>>>>> +      * and we're not moving the FDT, nothing to do.
>>>>> +      */
>>>>> +     if (dstbuf && dstlen >= newdstlen && dstbuf == fdtsrcbuf) {
>>>>
>>>> Can $dstbuf ever be NULL ?
>>>>
>>>>> +             free(tmp);
>>>>> +             return 0;
>>>>
>>>> You could try something like this here, to reduce the duplicate
>>>> free(tmp) in the code:
>>>>
>>>> "
>>>> err = 0;
>>>> goto exit;
>>>>
>>>> ...
>>>>
>>>> exit:
>>>>      free(tmp);
>>>>      return err;
>>>> "
>>>>
>>>>> +     }
>>>>> +
>>>>
>>>> [...]
>>>>
>>>>> -     load = (ulong)of_flat_tree;
>>>>> +     len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
>>>> How does this new length calculation work, can you please clarify that ?
>>>
>>>   From my understanding, that len is tracking the current packed DTB data
>>> length (up to the end of the strings block), not the allocated buffer size. We
>>> recompute it after each overlay so need = len + ovcopylen
>>> CONFIG_SYS_FDT_PAD grows from real used bytes instead of
>>> accumulated slack. This is roughly the same idea as libfdt’s internal
>>> fdt_data_size_(), and the final returned size is still taken after fdt_pack()
>>> with fdt_totalsize().
>>
>> Ah I see, thank you for the clarification, this helped. It would be nice
>> to include that as code comment too.
> 
> I'll add a comment.
> 
>>
>> But don't you have to account for the FDT headers too, so wouldn't
>> fdt_totalsize() be more appropriate here ?
> 
>  From my understanding, fdt_off_dt_strings() + fdt_size_dt_strings() is the
> packed DTB data size we need for growth calculations, and it already
> covers data from the blob start (so headers are implicitly accounted for
> via the offset). fdt_totalsize() includes spare/free space, so using it there
> would overestimate need and cause unnecessary buffer growth.
Thank you for spelling that out. Please also add that as a code comment, 
this really helps understand the code.

With that in place, for V6, add my:

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thank you for your hard work.
