Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E3CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19F4801A9;
	Mon,  8 Jun 2026 15:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mkiMPGUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCE4801A9; Mon,  8 Jun 2026 15:30:57 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2557580087
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-660e9ea23cbso2094701d50.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925454; cv=none;
 d=google.com; s=arc-20240605;
 b=ad0hedpz8nJrT5vgYQgVPXRKnO6TUAHduBHVL7bpEt3j8GFzNDwBZKoZagb7AfdTFm
 O1IM3PCv4m2Dh30rUm12I1PL1wCZeiflTQ9NDUag6Yvb+iar3tS/TVj1nI7ENHw62+yH
 K1dH0dSR3/XxQcakAGn6l6nq6pY1dcq/aMeQxmN9gYugHjRUOkRw0hRIqGzarN2VS449
 G7pWQX0lP1khRv/0ik3nWB0rj/crXW7F7jgl0wZRiXXCmo8t5xY1tfhQy1WOErMJtWYU
 rU3rFBXLF4Cs84Lumy63e/1PSimqsquBmx1Q2xxVQO8skHzeUo1cy7B7fDTdq2qGsWlq
 Sfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jSEJGQeYpqYIvK7jXExei8kwTBAx5qdt3o+lKMXQcrs=;
 fh=h8XMs+/RVsiJAsYVH3fCd8nBHvqTQxSCm/fMkYxHpR4=;
 b=Dt59bAutCTVNcLCcL9niVIRFmjMJTo3c4XivAu0PXSfXqUs+LlUS/z5w0dOcXqaWfd
 nAiX2SSjkH5dZyYW3lg6/nTNg6j/CQR89MdAce/JLxoZfGN/ta3+NkMS5Rg+bsUHo88h
 3b+0suM2iqrR6oqSGzfa6iF7h1Hqtznj5qY5lru0IBfo1AZMRyoEiXBqHMNU1vV2b++B
 roA31fAQk9rj7DTJAJKDMipYmgLu/Vkkp5f9dsFZbq2ndOWDx3gtLxeYPHOQXg9aJ90L
 x+IeP96KAdz/QR9oVSak+J46dO/gS1yfPOEzAlKTJw+3GapI1OnnrZdQ3exbFDRQEdoa
 v5mw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780925454; x=1781530254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jSEJGQeYpqYIvK7jXExei8kwTBAx5qdt3o+lKMXQcrs=;
 b=mkiMPGUrmTTxC/GAkFY0I2wbHn61hic5QFTVYWNFw8R6ha6A20Xgrvnd/eFSqH7pS9
 CoZBVKQqXGWOAMfGnTRL9stDVjLTgJaKNjF6P2xPkjkJ0VolCkwU4GTx93gPO8UM6TO5
 Hrihdzu9wqEZFGsmw6F1AmbS+rXhxUui4RvokRAc6CHak4WmeX5bb3iIjM1hj2mX8Pvf
 LIOYLGy1d5oJc6LtYPunT/iGTc/jbUCfFzz/XFAISjHzkpfR1CdfL/XZAeMTCUok2gVW
 zA0HGWWWYRv7GJy+yDYcsRtHrFwAYWgNhaZWcC59uPW1OG+G/OjMVnJqmSXLizwTdPZl
 bKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925454; x=1781530254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSEJGQeYpqYIvK7jXExei8kwTBAx5qdt3o+lKMXQcrs=;
 b=qxPosdHqI6MQhhzpXidBp6FhkbaRA3JeTXD2DB7G7HuVdJ/IAr67OXv96IRxULfh6P
 RkgTkV4aMp9ruZuxTLwcv1CULRBwQttNoXNUh0Bx8gCNG0INapxA9HPw3B0SLdN8KeOz
 4aHEQko4BD7KNA3cam7zXGbZxU8YC8ERNpHElmaDIqTQXVes5+DD4tNKNHzNSnK2h4Kw
 bGG1JMeKE44NmZs+CTZKlw1aOsHRiRDg2HwewC3aJFyRGu84rdHOC6RnbU5CP90yHrOT
 bCEFAjPYl8vE8tgZ3m538eitioszqlGKqM0uf8MmCwDk17DZAvrAgRYmbLemud2qYcJK
 YcEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DQC1ZRqa3DYRbbztP7+oGPJdHEaawT1yxuSpZMFS+kSQBx7RFGcib97JhlN48x6TRYWP+Gno=@lists.denx.de
X-Gm-Message-State: AOJu0YwuT0IeCwsFQ3P/e4Qae5umEejnOh6TpFbBc1I7vWljiaJ0vywT
 CsnohFQ4kX0mk9PJJIqQtkWjY3O7YJfs6ty1epMkso77yWiMwRPzTDw0YknLlLFdKoTWMYmsjko
 H4inG7xbmy3S3sCwBmRhp5wjdGh7i8XeU05GlCKfcXw==
X-Gm-Gg: Acq92OGKHvZ/H0bSnv5zEkhBDIIBL1zxTOdamd/gYBaRSAxhrLtc8fcCbq8vigHeeU9
 BY3hf+pEzMbH0cYFs95Gt5w8ZsRjo8/v1yoNSj5Cc0rPVnL0jFhlfFxa9mKIf5hOqVsEGxIhiiF
 W4Iee9HR/OMkVkbJGUbdXS5OuqAoa6Z6pCN6c4Xfbecai42W5B83iugPVR6k1PDI1kWmIy2jrwj
 ZG20GX5pv9Qtr8D/DhYE7a7cEz4er2lP29RWp5LPWnqpcHM2uuXCyL0fXY1+nVVEAW0aKjcHl0R
 NgQe4wG18dfEIlksKG3Dk3cSb2KqENYHl+1beZIPADByjdcQclbBYaRZKSGcre/9+np+iq/U0c+
 iixR0RYq3ywyje3f048QnPAcblhoBwwvRgiLi+HNBF2saMl0IV3tIJ2uuQN/HS8t3t+L98LRwGy
 GJg9LwVwT4EpVASiM09UPXC6h/yydcJXVAdxyHKMcpPNIkeqTDpReh1tymDZc2OQC94m44V0wBt
 JmfIjc1PETKwhlvv0oPE/NFxWdR3UD8XSOsyoMPBt+I7LV5cdhk7gyEFEk8ktY1evc7xsa3bSPw
 kpeRm6fuAc9ufZ/Fos7P1r2VzqS/q3t3kLartujpTK3RYFMffRyGShoS2J4yqrvx9ibxI3YHHu8
 qpvK4QXNpjA4Fhgbf
X-Received: by 2002:a53:d005:0:b0:660:7702:62df with SMTP id
 956f58d0204a3-66106f392e1mr11684147d50.31.1780925453791; Mon, 08 Jun 2026
 06:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-6-ilias.apalodimas@linaro.org>
 <CAFLszThLAkMcDnMurD639y_Cck-n4DkW7VOC+Xzy+k+Xk_ryzw@mail.gmail.com>
 <CAC_iWjLcLMvjsjJujKSQ=GKvKZb+axQj6-1Ptc9UffBLxic6cQ@mail.gmail.com>
 <CAFLszThSSU=AVafR7vWeSJ_HocefaORM_Rwd_49W0TobMAVaqw@mail.gmail.com>
In-Reply-To: <CAFLszThSSU=AVafR7vWeSJ_HocefaORM_Rwd_49W0TobMAVaqw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Jun 2026 16:30:17 +0300
X-Gm-Features: AVVi8Ceyo1j8MDSz7Radj7MGtPCgD8ih-n3NoCKMrTzto2QmK-VGQ4eVMlXyAj8
Message-ID: <CAC_iWjLqpcW9Wc+DS80e5oVe8_82GZ3SS-J+Kh+hLRirj=Yn2Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] common: Add an option to relocate on ram top
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, u-boot@lists.denx.de
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

Hi Simon,


On Mon, 8 Jun 2026 at 16:00, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Mon, 8 Jun 2026 at 01:44, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > [...]
> >
> > >
> > > I'm just a bit concerned about what this changes...see below.
> > >
> > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> > > >  static int setup_ram_config(void)
> > > >  {
> > > >       debug("Monitor len: %08x\n", gd->mon_len);
> > > > -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> > > > +
> > > > +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> > > > +             int i;
> > > > +             phys_addr_t top;
> > > > +
> > > > +             gd->ram_size = 0;
> > > > +             for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > > > +                     top = get_mem_top(gd->dram[i].start, gd->dram[i].size,
> > > > +                                       ALIGN(gd->mon_len, SZ_1M),
> > > > +                                       (void *)gd->fdt_blob);
> > > > +                     gd->ram_top = max(top, gd->ram_top);
> > > > +                     gd->ram_size += gd->dram[i].size;
> > > > +             }
> > > > +             gd->ram_top = board_get_usable_ram_top(gd->ram_size);
> > > > +     } else {
> > > > +             gd->ram_top = gd->ram_base + get_effective_memsize();
> > > > +             gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> > > > +     }
> > > >       /*
> > > >        * Subtract specified amount of memory to hide so that it won't
> > > >        * get 'touched' at all by U-Boot. By fixing up gd->ram_size
> > > > @@ -350,10 +372,9 @@ static int setup_ram_config(void)
> > > >        * memory size from the SDRAM controller setup will have to
> > > >        * get fixed.
> > > >        */
> > > > +#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> > > >       gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
> > > >  #endif
> > > > -     gd->ram_top = gd->ram_base + get_effective_memsize();
> > > > -     gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> > >
> > > This reorders SYS_MEM_TOP_HIDE relative to the ram_top calculation in
> > > the non-RELOC_ADDR_TOP path. Previously gd->ram_size was reduced first
> > > and get_effective_memsize() (which reads gd->ram_size) then yielded a
> > > ram_top below the hidden region.
> > >
> > > After this patch ram_top is computed from the full size and the
> > > subtraction happens afterwards, so ram_top (and hence relocaddr) now
> > > lands inside the region SYS_MEM_TOP_HIDE is meant to keep U-Boot out
> > > of
> > >
> > > Quite a few defconfigs still set CONFIG_SYS_MEM_TOP_HIDE (e.g. odroid)
> > > and look like they would regress here. Please keep the old ordering
> > > for the else branch, or do the subtraction up front and feed the
> > > reduced size to both branches.
> >
> > Yea that's true, however how that's used is weird because
> > get_effective_memsize() is board specific and it doesn't always use
> > ram_size.
> > So perhaps we should deduct the same value from ram_top and keep the
> > call last ? That way we can keep the functionality for both cases.
>
> That makes sense to me, yes. It seems more in keeping with
> board-specific functions. This is likely another area to clean up one
> day...

Ok, I'll send a v6 tomorrow with the change and yes this is another
area that needs a cleanup. The rough plan is
- land this
- Go through the board specific code and remove anything that's not
needed anymore
- revisit the reloc and make it even more abstract. The rough idea is
to keep the same structure. IOW calculate a reloc address and override
is with board_get_usable_ram_top(). But depending on the cleanup we
might actually be able to get rid of the old option and make
RELOC_ADDR_TOP the default. I just have to see how many boards would
be problematic. One idea is to define a board_get_usable_ram_top()
that returns valid memory < 4GiB and point the problematic boards to
that.

[...]

Regards
Ilias
