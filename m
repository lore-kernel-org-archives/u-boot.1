Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967C0F8D755
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 18:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB84841C8;
	Thu, 16 Apr 2026 20:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fWuMiDZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2FC84214; Thu, 16 Apr 2026 20:43:49 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B3180077
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 20:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-670f6ae9c7dso7485902a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365026; cv=none;
 d=google.com; s=arc-20240605;
 b=LKn3OLInrqiI3lHJHPIDCou6JdBXRILQxsijCgjkUR7FLUj9KodHlVn6C8fmVVSPny
 JAhJXZBJB6Y5u+h3KZZf2yav1lBGzLdQMvFoD1nHLG/nv7S7sFh5zHH9SsT0PzRoL1U3
 IkKKvpQEc5p/vAd3Bep7nu4YQxVqTFpq7O4Kje+1jgSh7HBAKsCBGvs6R6K9zfNQj+9Q
 BvVAsnQIDbUalE1sNgywNUiMsAlwyqn8UhfI7Paw7ExkuDyiWh7sgtHtrMCN57FBvib8
 i70f/7Dfk6gAA65zvNFsKB574xSi9WXVk9mpkeLvw1gLQ7hgWXyTXD6EWUe0nUVZKGAZ
 EvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R67XlJztoDvKrSArBAfy4u1q0Fy6cE4pVQoE4ttQ2qM=;
 fh=8h2fZbswfjNN3Yn8s4G7I/XU9UuIu0nksJyd6mdGF7s=;
 b=ixDCyjx586Ho4/43ngBrZAa+5D0uANEaAKLrcg83CrOYBfwzZhP6+4SbSB92Whg8+u
 ow4rZIieR8I7k89vlDdOf/X5VmTn22XjHESY7HWbgwzzvV7EUgPosbB77jjhdQdDEfz8
 e+r5haZeUx7zVi7SMbWeq6n1nMp9xnC+HKJDIuTS8R8A9GifgW4fzHu/AAcPkykuyfuF
 OhdiVTjPkkp0hiWMvZ9hxra6C9N2K4AND7n/xLENbz65XHDGC8pkOqzJHc/gwavk7l4R
 8qnTSR9OrI2CDXUG4/+5rLb2QeD0f99Dh4vdgmYHbkHlJsOTRiEMgZWW+fFMgISG7RKo
 aq8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776365026; x=1776969826; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R67XlJztoDvKrSArBAfy4u1q0Fy6cE4pVQoE4ttQ2qM=;
 b=fWuMiDZZaQ7wxAWkDZq+ajBSGEMbzu/gFVpfb0RnMux1qDuaP77Vs0x1xuRiNisbf9
 ABThM/LF1glt7LgMeVppn3wNOIxL6KTa4QCFfEvqE0gco53g1og1lqL535+Mrbm2wm7H
 hVB1xgnvCMipGhHNtBr9jU9XHLN4B3ZKrNBJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365026; x=1776969826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R67XlJztoDvKrSArBAfy4u1q0Fy6cE4pVQoE4ttQ2qM=;
 b=WC9DvXt656/G9svDMEpSioeydparmTm3p4ixBk5Zw9GyRQckv0YKGmsKTlsXM7nNgc
 Ta3n43SWbgCBHfCMgKS49Xsnhwvx/r1TLE7MCFuEN+kP1fJn1TM/Uptj1gHjlhU7yNAc
 3SEJubFip4XIeOPTEXncgIsMRPZaYnbE/whsjlSACGxIM5/SA116Y3glqA3DugReF+me
 byuKFaCIXdS3nxX30kwsgGZDodffAZmnpIEIEG+nrtMcJ4oGwRRI9IIKUarO0tgBeZs5
 im+ZZnJyYiPYkabXKhJ9XzAIGD4nS+M/N0lodNlAhBkhYbasJmmahYCd5GcjP33UdbQ0
 Pikg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LCc+ZPl5KmjQuBIbXGNvGOl1o8HJCxJYZuNSoMfk+AeDoZJUvtLQbyT49PtPkII/OLIwo+Ig=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmd/xrw6mkeHw4AZYVqOKBTKBldxDU78isFFuCgoWqvGPw/xKg
 xn/r3UH60CUhEkTuBSLO0i5wqT5B8CVa8iHp7edegW8kCI2emWnpaR53JoFF49wP2SHtLEO0eRp
 pD2qj3ev2oDyy+Zoi7Humb93aCfOihrjm+mYnJ235
X-Gm-Gg: AeBDies7Vnjux/KhS7kkLQYZWxWqXSUk3cO/XTVUP8GLYqsy/MS5FqNF1+9stx57QkE
 mWQnvht2WszKuekp0Yp5fR7pL5KE/m58vE2wc8zw/7M958XjhPSpjOdSPmFvMGKwgDlzW+RTA4c
 DBVvqoPfj43FK3cDJsyJZC7Qo7mfCfbJvemFUfOe/05uFQYrdoKsND5ZQf7rVplt5tHQ1CBeNrc
 CVZs6FZCvGQawzaNR9P3IqJmdrjzK+GeN9xV1VpOhCbr/096I6RqazK6yOAtswkzs7M7PBDWAfN
 BNjPwV5h7cBmylWS2Kod
X-Received: by 2002:a17:907:7e5c:b0:ba0:d678:f273 with SMTP id
 a640c23a62f3a-ba3dbaa108amr35281666b.12.1776365025777; Thu, 16 Apr 2026
 11:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org>
 <87jyv2oon5.fsf@prevas.dk>
 <CAFLszTi_U4xS_6kW1VUqaKVUeP+sweOfQvAydXM5F0nQOGSZ+Q@mail.gmail.com>
 <87se8ymuvl.fsf@prevas.dk> <20260414190224.GM41863@bill-the-cat>
In-Reply-To: <20260414190224.GM41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 06:43:32 +1200
X-Gm-Features: AQROBzCIjHoVmJmbz1i1M9TNmH0UozGl5VHzDCHnyaKov2zD_BhhkjE9EisGko4
Message-ID: <CAFLszTjxf1mwibK1091ySxrXHt-=8K8O5DvEeGTx2qftUx1Deg@mail.gmail.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
To: Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de, 
 Simon Glass <simon.glass@canonical.com>
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

Hi Tom and Rasmus,

On Tue, 14 Apr 2026 at 15:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Apr 13, 2026 at 11:07:58PM +0200, Rasmus Villemoes wrote:
> > On Mon, Mar 23 2026, Simon Glass <sjg@chromium.org> wrote:
> >
> > > Hi Rasmus,
> > >
> > > On Mon, 23 Mar 2026 at 03:56, Rasmus Villemoes <ravi@prevas.dk> wrote:
> > >>
> > >> On Sat, Mar 21 2026, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> > From: Simon Glass <simon.glass@canonical.com>
> > >> >
> > >> > Change the alignment of end markers in ll_entry_end() and ll_end_decl()
> > >> > from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
> > >> > to __aligned(1).
> > >> >
> > >> > The linker places zero-size end markers at aligned boundaries based on
> > >> > what follows them. When the next list's start marker has a high alignment
> > >> > requirement (e.g., 32 bytes), padding gets inserted before the end
> > >> > marker. This causes the byte span (end - start) to not be an exact
> > >> > multiple of the struct size.
> > >> >
> > >> > The compiler optimises pointer subtraction (end - start) using
> > >> > magic-number multiplication for division. This optimisation only produces
> > >> > correct results when the byte span is an exact multiple of the struct
> > >> > size. With padding, the result is garbage (e.g., -858993444 instead of
> > >> > 15).
> > >> >
> > >> > By using __aligned(1), the end marker is placed immediately after the
> > >> > last entry with no padding, ensuring (end - start) equals exactly (n *
> > >> > sizeof) where n is the number of entries.
> > >>
> > >> So I'm wondering why that is guaranteed. I mean, the linker is placing
> > >> these sections one after another in order
> > >>
> > >>
> > >>   2_foo_2_last_foo   size sizeof(struct foo), alignment max(4, alignof(struct foo))
> > >>   2_foo_3            size 0, alignment 4 (1 with your patch)
> > >>   2_bar_1            size 0, alignment CONFIG_LINKER_LIST_ALIGN
> > >>   2_bar_2_first_bar  size sizeof(struct bar), alignment max(4, alignof(struct bar))
> > >>
> > >> So clearly the end of last_foo does have 4-byte alignment, yet it is
> > >> observed that the linker sometimes makes 2_foo_3's address coincide with
> > >> 2_bar_1's address?
> > >>
> > >> What I don't understand is that it seems that the linker could place the
> > >> zero-size object 2_foo_3 at any 4-byte aligned address between the end
> > >> of 2_foo_2_last_foo and 2_bar_1. And the same seems to be true when one
> > >> changes it to have even smaller alignment requirement.
> > >>
> > >> So why does an align(1) stop the linker from placing that 0-size section
> > >> at the same address as 2_bar_1, or even force it (as we need) to put it
> > >> at the first possible address, i.e. immediately after last_foo?
> > >
> > > My commit message was a bit confusing - alignment of symbol is not
> > > based on what follows an item, just on the item itself (despite
> > > appearances to the contrary).
> > >
> > > My understanding of this is that the linker processes input sections
> > > sequentially within the SORT(_u_boot_list*) output section, placing
> > > each at the first address that satisfies its alignment. So the
> > > location counter advances forward only by the minimum needed. But this
> > > isn't specific to alignment 1.
> > >
> > > I've used __aligned(1) in order to make it clear we don't want any
> > > alignment. In all current cases, __aligned(4) would be OK too since
> > > the structs we use are always 4-byte-aligned. We just want the end
> > > marker to go at the current location-counter, i.e. immediately after
> > > the last entry. I suppose another way of saying this is that we want
> > > the end marker to be a 'multiple of the struct size' higher than the
> > > start marker.
> > >
> > > With ll_end_decl() using __aligned(CONFIG_LINKER_LIST_ALIGN), the
> > > result depends on the struct size and the number of items in the list.
> > > On sandbox the value is 32. If the last entry ends at, say, 0x103c
> > > (4-byte aligned but not 32-byte aligned), the linker must advance to
> > > 0x1040 to place the end marker. So then there is a 4-byte gap, i.e.
> > > (end - start) not a multiple of sizeof(struct), and the compiler's
> > > magic-number division optimisation fails.
> >
> > OK, yes, I agree that the proper thing to use for the end markers is
> > aligned(1). But I can't help but feel that this problem is somewhat
> > self-inflicted; I still don't understand the rationale for
> > CONFIG_LINKER_LIST_ALIGN, even if I've read 0b2fa98aa5 multiple
> > times.
> >
> > The ELF format includes an alignment field for sections, so if gcc emits
> > a symbol to some section which requires 16 byte alignment, that section
> > should get an alignment requirement of 16 bytes. So I guess what I don't
> > understand is how gcc can end up emitting a section containing a "struct
> > driver" in one TU with an alignment of 16 bytes, while another TU
> > contains a section with a "struct driver" that only requires 8 byte
> > alignment.
> >
> > So yes, this commit improves things, and you can take my Ack, but I'd
> > like to have some very concrete examples of a set of complete TUs (not
> > just single lines) and compiler invocations that exhibit some of the
> > problems that this is all about. Because I'd really like to look at the
> > intermediate .o files and see what's going on.
>
> Agreeing it would be very good to better understand things, after
> applying this series I see:
>             qemu-arm-sbsa  : rodata -8 text +8
>                u-boot: add: 0/0, grow: 2/0 bytes: 8/0 (8)
>                  function                                   old     new   delta
>                  gic_v3_its_get_gic_addr                    200     204      +4
>                  acpi_fill_iort                             264     268      +4
>
>
> Which is because of patch 2 in the series. There are a few other
> examples of gic_lpi_tables_init changing on say
> ls1028ardb_tfa_SECURE_BOOT from the same commit.

I think it would be useful to go back and look at the need for
LINKER_LIST_ALIGN - it originally came from sandbox on amd64 where
section alignment of 32 was observed, but only if a linker-list item
is referenced from outside the file where it is defined.

I wonder if (with these bugs fixed) that problem might go away and we
can drop the Kconfig option?

Rasmus, that might provide you with an avenue to dig into this more
deeply and figure out what we do and don't need at this stage. I have
spent several days on this over the past few years, but despite that I
don't consider myself an expert.

Regards,
Simon
