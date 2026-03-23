Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3200DF483C6
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36F484180;
	Mon, 23 Mar 2026 17:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VjT57VBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD3C0841C8; Mon, 23 Mar 2026 17:17:32 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9676B8408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so82698166b.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774282650; cv=none;
 d=google.com; s=arc-20240605;
 b=MyVChNuALzSr05qtvH2/FRiIfBjNSEWqGIj4Sks5EoiYC4EV5zODJYGbEo4ViWozuo
 vltJf2l0T+LtyaswOM/yhBe2ESHvSw5iGNmMLVilk9DeGhMpXRtEl4VVEJ7L+blKW76I
 57vDi3eFmNmGJ/1QkDUbMW02qEDN/VqP7sEbSFx0L3I0fWM+oyZTK9YsX4gSMAzvMB8z
 krRanFkrzS0TQTJ/Pq/hGc4LMryiQ04/1fbOGo+icINwfYU2+ei70YKAoFQfOUdINySa
 Bo4IzVpApSPSl6MTcH8ENh5U2rllljpXrlpyW5cRVg89QeDSFlHKR4CJ0HLHFVczPuGQ
 LRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d4gv4RNExH/zywHJtNg8ggXvT2JPipQAb5DfnNuF7qQ=;
 fh=5ToLsHOpvXw1vijzHr9QPV2BetlknSEbc3OXpxTlJcA=;
 b=S7dggUprbuCdlbd83v1ajUMjwoCiObhczoUFdBfgXqbCStWnYh+Gjm1jKsWv6t8fGl
 ZvS/y+capiyVmB4X+YBwyaApbGhH45LAc0cmekmNOIg5kNrNzfryDLPo6y93q9Ymmje7
 yqpxsXNczwEfvqt6wzU4Z0FXYR3IuVY+MIEdj7ZC/YlOvC4Cj8ngDC1zD9DxDrrq80fS
 kH8eJ0VXp4VKv9TTJ+Kn5o1+dIH9y4dc9VBvINSttuanGK4EaPP/Gm++6Gzr8xTvQODr
 XtQoK1MwtHs6UuAheewhno5jT/a/JYNX032/bEkc774j15yPon+R7oj973Xt9S1ky9i2
 FrCQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774282650; x=1774887450; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d4gv4RNExH/zywHJtNg8ggXvT2JPipQAb5DfnNuF7qQ=;
 b=VjT57VBT/hhFoCQeyLv99YaZew1zf3l6jWxRwB1iPhTog+lg4mZuL+TJQLEqBOVone
 LpsoPj/xMdXa8WWubmqbdM3b306fZoeVJ0DIvqIHkM1a03RcEpKVvlWi6bbaQEVs68RE
 PGHc7awCHPuxWx5hRP2XGSbm8lSs5JbuIm/hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774282650; x=1774887450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4gv4RNExH/zywHJtNg8ggXvT2JPipQAb5DfnNuF7qQ=;
 b=cPwIeTJBSiVGULusCMq7ObE21kse68xQXYAwirAylp902kMxg1C3d39wdaz1vreLY4
 wNuXGkX+82SsRw9L1qp2L9Qb/O1Kl5+dYtHWefwXkUEUgmvruJsX2TUqgI52QS9dPZ/9
 aXhRQDde6xjC7OVYmXar5D6xZ8UW5TcNqBNNWYbmiJGJvNzvqtzOQT5sifxsgd83a9x6
 ePh47MLjlQoFGxcSj98CoLQC0uIUMnH1CH53vklvxBtugGWnL3SHJz9Ojq7FU+bLllfW
 tyAt3cppkRj8N0eBA7R9N5RCz/SsLekMkMcJaKvvdRk+MQ2r4BLyjWKMMP13UAX7Fdvm
 aTDA==
X-Gm-Message-State: AOJu0Yya+u3hOykj5i57PqDeOoSIj36L1u/ZumOTv4B1ihpTvRUt0txg
 k4bzkp2ycTY3YD9vk+ArgSaXwQw2HIjRbKVYaweoH+pD7fHF2P+3poTqg+xDZh+qjuO4B4uCm2V
 bQk1xhYe3V5n9SdMBcxv+fUHgPJARLMLzQG6pOjac
X-Gm-Gg: ATEYQzwOEhrpsQWt3ioVPj/516SyxIULHX1GcxFyusqBPHfHQHJ3FCoQ2GGvyzrpg18
 bpy79KAw6MmWihxSp8Kp3uExq0IlCY4RVK/bfqago8SoyldydiKux7S8MtNGI6+4VsLVmIeFdGs
 S+63tu7yUG4AN59iClMpiuWl+vLtFvEXmoYpTwMOkdDHiwTmmAHMpFUNPJovwLqSksNYb3ol5zP
 eJEsUxFurnaMEgYMOqrXY859ZlUbKraHYp25sThRR8ah8/rYf+Ctjt+qJIpUDkdVTsf+7KgUVCj
 9C/xhBE=
X-Received: by 2002:a17:907:e0d8:b0:b97:408f:eda0 with SMTP id
 a640c23a62f3a-b982f254f2cmr529983366b.14.1774282649664; Mon, 23 Mar 2026
 09:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org>
 <87jyv2oon5.fsf@prevas.dk>
In-Reply-To: <87jyv2oon5.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Mar 2026 10:17:17 -0600
X-Gm-Features: AQROBzAatVqvpbyJzqry-Cv2Op9pqjdrGJ09fKRzPk-j8-elluBGCXTYL28kf2c
Message-ID: <CAFLszTi_U4xS_6kW1VUqaKVUeP+sweOfQvAydXM5F0nQOGSZ+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Rasmus,

On Mon, 23 Mar 2026 at 03:56, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Sat, Mar 21 2026, Simon Glass <sjg@chromium.org> wrote:
>
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Change the alignment of end markers in ll_entry_end() and ll_end_decl()
> > from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
> > to __aligned(1).
> >
> > The linker places zero-size end markers at aligned boundaries based on
> > what follows them. When the next list's start marker has a high alignment
> > requirement (e.g., 32 bytes), padding gets inserted before the end
> > marker. This causes the byte span (end - start) to not be an exact
> > multiple of the struct size.
> >
> > The compiler optimises pointer subtraction (end - start) using
> > magic-number multiplication for division. This optimisation only produces
> > correct results when the byte span is an exact multiple of the struct
> > size. With padding, the result is garbage (e.g., -858993444 instead of
> > 15).
> >
> > By using __aligned(1), the end marker is placed immediately after the
> > last entry with no padding, ensuring (end - start) equals exactly (n *
> > sizeof) where n is the number of entries.
>
> So I'm wondering why that is guaranteed. I mean, the linker is placing
> these sections one after another in order
>
>
>   2_foo_2_last_foo   size sizeof(struct foo), alignment max(4, alignof(struct foo))
>   2_foo_3            size 0, alignment 4 (1 with your patch)
>   2_bar_1            size 0, alignment CONFIG_LINKER_LIST_ALIGN
>   2_bar_2_first_bar  size sizeof(struct bar), alignment max(4, alignof(struct bar))
>
> So clearly the end of last_foo does have 4-byte alignment, yet it is
> observed that the linker sometimes makes 2_foo_3's address coincide with
> 2_bar_1's address?
>
> What I don't understand is that it seems that the linker could place the
> zero-size object 2_foo_3 at any 4-byte aligned address between the end
> of 2_foo_2_last_foo and 2_bar_1. And the same seems to be true when one
> changes it to have even smaller alignment requirement.
>
> So why does an align(1) stop the linker from placing that 0-size section
> at the same address as 2_bar_1, or even force it (as we need) to put it
> at the first possible address, i.e. immediately after last_foo?

My commit message was a bit confusing - alignment of symbol is not
based on what follows an item, just on the item itself (despite
appearances to the contrary).

My understanding of this is that the linker processes input sections
sequentially within the SORT(_u_boot_list*) output section, placing
each at the first address that satisfies its alignment. So the
location counter advances forward only by the minimum needed. But this
isn't specific to alignment 1.

I've used __aligned(1) in order to make it clear we don't want any
alignment. In all current cases, __aligned(4) would be OK too since
the structs we use are always 4-byte-aligned. We just want the end
marker to go at the current location-counter, i.e. immediately after
the last entry. I suppose another way of saying this is that we want
the end marker to be a 'multiple of the struct size' higher than the
start marker.

With ll_end_decl() using __aligned(CONFIG_LINKER_LIST_ALIGN), the
result depends on the struct size and the number of items in the list.
On sandbox the value is 32. If the last entry ends at, say, 0x103c
(4-byte aligned but not 32-byte aligned), the linker must advance to
0x1040 to place the end marker. So then there is a 4-byte gap, i.e.
(end - start) not a multiple of sizeof(struct), and the compiler's
magic-number division optimisation fails.

> Unless
> alignment 1 is somehow special-cased to mean "place as early as
> possible", I can't see how this should provide any better guarantees
> than what we already have.

Yes, we could use 4, see above. I think that would be confusing
though. We cannot use CONFIG_LINKER_LIST_ALIGN as above.

>
> So I don't oppose the patch at all, but I'd really like to understand
> how it actually works.

BTW I spent quite a lot of time analysing what was actually going on
and even wrote a Python script to check the build. There is a blog
post about all of this too (search for "Linker Lists" and magic
numbers).

Regards,
Simon
