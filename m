Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19F6E9A755
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327068352B;
	Tue, 24 Mar 2026 10:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g0PJzAsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF6E838BB; Tue, 24 Mar 2026 10:54:31 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B4082A9E
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79ab50ee951so11403137b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 02:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774346067; cv=none;
 d=google.com; s=arc-20240605;
 b=B6CApEPpqxLN20W6P+8JCMVDU4sUO1SlYK+w3u9DIruSwwU/kDrGOaDk5GDm+DSD/H
 0P7tS77Xzhz2XDtiXLAJxdt1GDsc1DOR3IXDYgVMP5z88R2AywpWg65SNtajKzROHPiH
 GvXWJamD4dyY/L1kaJX5uwifK9Md/BSikS+SoKUOF6PYLJPowSaalvcu8oQ683V1jnzZ
 l/mDU17lejifH0nwSpYMMRL/wDhBO+tBpUmAEmOSxLTGt0VsNgvxP8p34TwHkKr6MTOh
 w+Hhp9CHb0QZMzHVvnbYtxSsedFtJC6izFv2NxPApBf4TyP/Ba4HPtstJ/lBt0tv4nRC
 O+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8x9ZADBLt/28eMUwGU51AK1Ah3iVPEBweV0vUKUc9P4=;
 fh=SYTXsRvjEju37iVQhRpP6statsP1sHRONuiMYZUtw7M=;
 b=UU9VYkcI/3ZaQKXT7vBgymG3rGV04OWgj4UrxwAC5+IEnPHaqnFRcy3tXKtnWn9E67
 7abt9rJ3uo8mz3ZoHv6iCwyWynZu9DuoRrDwXmb3C5EmwtI5plvWjVLaD3QfsXc0Q8sW
 Eq9/mmp3yZpFBPw0+5Mepv+szL9MhtcuUc6yOXoyl13SG2/+JVb4X7wN2R96RxJs18dy
 b/Y83YQavnKV0WYD5X8T4N+ZQ+gconLtxXyHT+PkhNbmZHS3nrl/Kt86PX2JHDN9ZYq1
 EjiiwOhHthCX5tvkb2TmWg99jSj5FjDsFuxtLQnkn15QCAcHNYPwA09dCxTSsr65n2xZ
 nxKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774346067; x=1774950867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8x9ZADBLt/28eMUwGU51AK1Ah3iVPEBweV0vUKUc9P4=;
 b=g0PJzAsN0NxvvZ3KkxM6yQil3A0z2TRxD0nKdO295jrSoFCJN7cU2SftEwYum/Hmcf
 jiEVGL6gOsR9vhfh+Ha9pBmmk+C5mZS4/gQ0t3sBkEMGXvS3Wt7YwYjq1eaH5ngGLYN7
 7jhB/CPvsIexVfhZyL4X7IoUuPWehWTKdWbUcpGE15N/40EKUg7mdjsmjTNm66GVzDCe
 vsa8FEEFaIXBZ4JvbIIYLqnD6NAwAsFrKdP5RJGw4Imgmsufu1xY2z4WDamTy3afstxN
 a6vDIur171ir8ECSqCCzF4xsyOnuN8SZA0D+mEbOqEmViN0y7tCCoBjdh+HupusQgI9D
 Izow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346067; x=1774950867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8x9ZADBLt/28eMUwGU51AK1Ah3iVPEBweV0vUKUc9P4=;
 b=YP5pNeDJDEGTfSRUlH2hqtIxNDWu0VMt8xCmXaarxWce70VvP7wEAb5MEYBXwr2SrH
 UfTU0PMFaw3zQFne/JO72gLP6Gr53WDMgPaMEzcl4upXXYrHoXLTeI7zAbSRFZPpZSvd
 yELl876AFmvLPmwWYF3fnCdzTnq9eYLqmTQhwDZQBjfV6uqS24mICCh/n4hO0Aptr7up
 KfkMaImxwxW5g0Eh2020U2jvD62Zzxbbk/T8JbsrM/314mAY/s1wx+n11PVy31kCRwhj
 0bER4HcqdV33Luyg5rfNAUZgqogC7TMwFcBKziiFa+VGYH6fqlmM+8eIC4KiQP46RsaH
 fTVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsMOvD4q1MLfX3vAwOBL3erYd+y7s5mU2L1iIy0hlpDqo0mErMAdg8vbC241G4Z19LqSckvWk=@lists.denx.de
X-Gm-Message-State: AOJu0YxlCyvc2kcCqU1IcR/p847PDqqAnpbmySND+TVYkh3zyppIyqro
 XagRkmsROUjuLJXygXQ9BrAu1nzMfEKHj45OUhwi5vknJLMd8WmjqnciFCm0uEhXwkLEoxGN/v6
 Q4BhugFpoRthkiXggcqQkcx2Tctxi7aJX5EiILgltmw==
X-Gm-Gg: ATEYQzzjYpoTiwFeq0UvnMZCdsis7uP24GHVT/m5o9/qJUwpI/HJcLrSBsB1/INxlYg
 zlKLaohuWca8KJn8dCeHh2SbLRqwfzeDrKWUAK3TFt3MN2MlISzLK9zId3b7xxiMbwEeqbTr5jm
 x15/1CMGVNKRUSeO6di7UeYus8ggTzplv00j19ThioXw+V4cvNirtBifs5cxrYYn12iGC7y//T/
 RzDKFTUWdyUXJ9YEL9vX8AcwYuQ56ZBfF6l3rrnaGdAkF5AAFNmbmvMLTBnI9TSBPSUpNkei+Ls
 jQ7vn+33H3eWotebP9R+akbGBABl/dP1li0cUMOkG2S9a4wftQ4J1R5rMaHQw7FYJWshlXLpPIA
 SpdwC/6HFZ17K/GK56Ftenl3dml9LtYaQtvdjLa2rOJbID0sRu0YcPTHXEeCNfP7Z9Xi8S3uKEW
 dWN7PqozoWqRFiskjIh0r/w7S4iSs+72sykFMGMgnyyITSWm22QrZRyFhGPiqfERaX1oqJ/gV+B
 ppGu+EevyCydSfuzEwDnMNbByQSaxMS3tLjbsX0fW/GjHt93aByo8VlxjbqFPv49Hr1Vlo2Dwvl
 k493GtjzOKbiPp6IClgZV22esqXode92UXabWnI+NbPwizgjKiSObfg=
X-Received: by 2002:a05:690c:6201:b0:79a:668a:b6d9 with SMTP id
 00721157ae682-79a90c510b7mr156168157b3.60.1774346067270; Tue, 24 Mar 2026
 02:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
 <462cf22d-10d4-4c59-9690-29d9584e7efb@mailbox.org>
 <875x8l69l3.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <875x8l69l3.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Mar 2026 11:53:51 +0200
X-Gm-Features: AaiRm52ZMPXH0VJEzWCV3Kw47tZ203VVc8Nuz_XS84uF0M7nUN65GZX0m0DIKhI
Message-ID: <CAC_iWjK2ARXUS2cpYLVHQx7Jxn6VYnon3ZU0V_SCJxH_hjtmkw@mail.gmail.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Marek Vasut <marek.vasut@mailbox.org>, xypron.glpk@gmx.de,
 u-boot@lists.denx.de, 
 yuya.hamamachi.sx@renesas.com, andrew.goodbody@linaro.org, 
 casey.connolly@linaro.org, holger.brunck@hitachienergy.com, jonas@kwiboo.se, 
 kettenis@openbsd.org, semen.protsenko@linaro.org, sughosh.ganu@linaro.org, 
 trini@konsulko.com
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

Hi Mark

On Wed, 28 Jan 2026 at 17:27, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > Date: Wed, 28 Jan 2026 12:43:28 +0100
> > From: Marek Vasut <marek.vasut@mailbox.org>
>
> Hi Marek,
>
> > On 1/28/26 5:41 AM, Heinrich Schuchardt wrote:
> > > Am 28. Januar 2026 00:48:40 MEZ schrieb Marek Vasut <marek.vasut+renesas@mailbox.org>:
> > >> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> > >> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> > >> same bank"). These are based on incorrect premise of the first commit, that
> > >> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> > >> not and should not use memory above ram_top, user can perfectly well use
> > >> that memory from the U-Boot shell, for example to load content in there.
> > >>
> > >> Currently, attempt to use that memory to load large image using TFTP ends
> > >> with "TFTP error: trying to overwrite reserved memory...". With this change
> > >> in place, the memory can be used again.
> > >
> > > IIRC there are drivers that have issues with memory above 4 GiB and boards that artificially set ram_top to 4 GiB to work around these issues.
> >
> > I thought I had all of those solved, but apparently not, please read on.
> >
> > > We need to carefully consider why the reverted patch was introduced.
> >
> > I didn't find much on either commit. I believe the premise on which the
> > original patch was introduced is wrong, cf this commit message. We
> > should allow U-Boot to access the memory above ram_top, we should not
> > allow U-Boot to use it for its data structures because of the possible
> > 32bit DMA limitations.
>
> What do you want to do with that memory in U-Boot?  You can't really
> use it to load a kernel into if there is a 32-bit DMA limitations in,
> for example, your MMC controller...
>
> Are there boards that don't have enough memory below the 4GB address
> boundary?
>
> > > Why does your board use a 4GiB ram_top and not place ram_top at the physical top?
> > Originally, I thought it was only a remnant from the past which kept
> > U-Boot and all its data structures, stack, heap in the first DRAM bank
> > in 32bit space, so I tried to remove that. It turns out there are still
> > a couple of problems that have to be solved to make it possible to
> > relocate U-Boot fully into the 64bit space.
> >
> > The first one is the standard parsing of DRAM size / ram_top / DRAM
> > banks order in common/board_f.c , which probably hides a lot of issues
> > on various boards, pretty much what you wrote above. In short,
> > dram_init() only sets up gd->ram_base and gd->ram_size , which is often
> > the first continuous DRAM bank which is in 32bit space. The follow up
> > setup_dest_addr() uses that information to set up U-Boot relocation
> > address at the end of that first continuous bank. And then
> > dram_init_banksize() parses the rest of the DRAM banks into gd->bd
> > (gd->bd is set up after setup_dest_addr() is called, in reserve_board()).
> >
> > This above is fixable and I already have some clean up patches for that,
> > which I implemented while writing this email.
> >
> > But then I found out, that the ravb ethernet driver also has 32bit
> > limited DMA, which breaks if I relocate U-Boot to the 64bit range. It
> > worked thus far, because U-Boot was in 32bit space, so were mallocated
> > DMA descriptors, so was the net_pkt_buf[] array (which is in .data
> > section). I didn't find any other breakage thus far.
>
> Unfortunately hardware with 32-bit DMA constraints is very common.
> There are device trees with dma-ranges properties that imply DMA
> constraints.  That is mostly about restrictions of busses that have a
> limited number of address lines so it certainly doesn't cover
> everything.  My list of additonal SoCs with restrictions in OpenBSD has
> the Raspberry Pi 4 and Rockchip RK356x and RK3588 on it.
>
> > Which means, before we can really start switching boards to relocate to
> > 64bit space, we need to find all these remaining 32bit limitation sites
> > and fix them first. And to do that, we would need some way to force
> > allocation from 32bit space for drivers which need that ... do we
> > already have such a thing ? I couldn't find anything.
>
> We have bounce buffers in the EFI loader.  There is a more genric
> bounce buffer implementation in U-Boot as well, but that is only used
> to solve DMA cache coherency issues.  But this suggests that solving
> things in generic code instead of drivers might be feasable (at the
> price of extra memery copying).
>
> That said, is there really a benefit in giving U-Boot more memory on
> systems that typically have 2GB or more below the 4GB address
> boundary?

The only benefit I can see is loading live images or linux distros
that are pretty fat nowadays. It's worth noting that we can load live
images and boot with the recent pmem changes we added a few months
ago.

Cheers
/Ilias
