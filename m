Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D632EEA845
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCCF8367F;
	Thu, 12 Feb 2026 21:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Sl9pnhxU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PUrCWXBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3258A83A47; Thu, 12 Feb 2026 21:05:32 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C8A83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fBmWF5JjLz9tgT;
 Thu, 12 Feb 2026 21:05:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770926729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcmYkStXdmywGmdV/yX6dOS4jNgUgTdsm7KFCW31qF0=;
 b=Sl9pnhxURrqAEr4UmSpdth8yWJCgUOE35ibUWrAnXVzWh8bpvuogJ8UDOO2qlfctSIxS5T
 UdnxijWr9cY7kiCXKDi6eaNNm+3rIUhKpb/4GsvaBWKgrgPOvwm4iUp1x6jyk1EoBNM8gD
 6+KqgDXeKC4YZX4e63JUpOZiW65HP8zNfPK0t7A5CDMgUDxneA8BsxTv9Vf4zFMOz/ivZ7
 ayeeZQx1hFQmNjpTvHHk+e+lO1H02C8lptZOYj+VvWYbIbINs5pQa2Et8jyet/WXuQEhuw
 VPdiGIka+AKgdBZpZtTAB0fToM4Ndj5pQiNAw7GgtZhYuLHjdSUy/tHwIF1okA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PUrCWXBX;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a00c737b-4f8f-4e26-974b-aa14ebbef64b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770926727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcmYkStXdmywGmdV/yX6dOS4jNgUgTdsm7KFCW31qF0=;
 b=PUrCWXBXnWkkinLSqY59Moso4k028QzfTGxcR1YAq9V/3dKQsudHoaXyqBPvCRM+hMggHh
 TGmZUL/Me9vLPzbXsb8RKKflofKomTkUOfXcHtXuTc8zk5dxMEeOOyoukqqmnp1Ig4rWVR
 DhwovwRXUZiELhb6exU3o9VdzmcmJllys53yiMVPvNp6mQxqrSEw4CMbMsQibT7Tvbsc3j
 DHT/YUWd8A9zkBcsZ0TbJV3FkXmLewLP0SUSR3jn49O4pAtCXAn5rxUY5agGp3iWRC4u+k
 7pCU+Lc3cZOSYr90FZUh+PRLe3T1s2ds6ZxdYMBNIDiTVvhiV2+MgnMTdDz1EA==
Date: Thu, 12 Feb 2026 21:05:24 +0100
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CADvTj4qtaoyJc9MtbjbpC+t_h3yO=jBXNed_3BAmDWMbDbhRPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k1kkehmnod18bgzrcxyy1j38df7j6xia
X-MBO-RS-ID: d88f64728f5538b51b0
X-Rspamd-Queue-Id: 4fBmWF5JjLz9tgT
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

On 2/12/26 8:52 PM, James Hilliard wrote:
> On Thu, Feb 12, 2026 at 8:26 AM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 2/11/26 7:06 PM, James Hilliard wrote:
>>
>>> +static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
>>> +                                     ulong extra, ulong min_dstlen,
>>> +                                     void **fdtdstbuf, ulong *fdtdstlenp)
>>> +{
>>> +     const void *fdtsrcbuf;
>>> +     void *tmp = NULL;
>>> +     void *dstbuf, *newdstbuf;
>>> +     ulong dstlen, newdstlen;
>>> +     int err;
>>> +
>>> +     /* Make sure the source FDT/DTO is 8-byte aligned for libfdt. */
>>> +     fdtsrcbuf = src;
>>> +     if (!IS_ALIGNED((uintptr_t)src, 8)) {
>>> +             tmp = memalign(8, srclen);
>>> +             if (!tmp)
>>> +                     return -ENOMEM;
>>> +
>>> +             memcpy(tmp, src, srclen);
>>> +             fdtsrcbuf = tmp;
>>> +     }
>>> +
>>> +     newdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
>>> +     min_dstlen = ALIGN(min_dstlen, SZ_4K);
>>> +     if (newdstlen < min_dstlen)
>>> +             newdstlen = min_dstlen;
>>> +
>>> +     dstbuf = *fdtdstbuf;
>>> +     dstlen = dstbuf ? *fdtdstlenp : 0;
>>> +
>>> +     /*
>>> +      * If the caller already provided a large enough writable buffer,
>>> +      * and we're not moving the FDT, nothing to do.
>>> +      */
>>> +     if (dstbuf && dstlen >= newdstlen && dstbuf == fdtsrcbuf) {
>>
>> Can $dstbuf ever be NULL ?
>>
>>> +             free(tmp);
>>> +             return 0;
>>
>> You could try something like this here, to reduce the duplicate
>> free(tmp) in the code:
>>
>> "
>> err = 0;
>> goto exit;
>>
>> ...
>>
>> exit:
>>     free(tmp);
>>     return err;
>> "
>>
>>> +     }
>>> +
>>
>> [...]
>>
>>> -     load = (ulong)of_flat_tree;
>>> +     len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
>> How does this new length calculation work, can you please clarify that ?
> 
>  From my understanding, that len is tracking the current packed DTB data
> length (up to the end of the strings block), not the allocated buffer size. We
> recompute it after each overlay so need = len + ovcopylen
> CONFIG_SYS_FDT_PAD grows from real used bytes instead of
> accumulated slack. This is roughly the same idea as libfdt’s internal
> fdt_data_size_(), and the final returned size is still taken after fdt_pack()
> with fdt_totalsize().

Ah I see, thank you for the clarification, this helped. It would be nice 
to include that as code comment too.

But don't you have to account for the FDT headers too, so wouldn't 
fdt_totalsize() be more appropriate here ?

>> I don't think this will work for fitImages with external data (generated
>> using mkimage -E) , but I might be wrong.
> 
>  From my understanding, this should still work with mkimage -E, external
> data only changes where FIT payload bytes are stored, and
> fit_image_load()/fit_image_get_data() already resolves that before overlay
> application. At that point we’re operating on a normal copied DTB buffer,
> and the length math is based on DTB-internal layout, not FIT
> external-data placement.

Clear, you're right.
