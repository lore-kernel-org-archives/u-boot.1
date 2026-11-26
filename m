Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2993606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jS9BoaLf;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d3J+pnZ0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79A7740A1C;
	Thu, 26 Nov 2026 20:52:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OC1hrmmYtOB; Thu, 26 Nov 2026 20:52:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92B1140A15
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795726325;
	b=VUjsO0+bW2YO6umip/fO7aUo3Wk96ewGicSgs0wk01I87CrvaB5uWUtHf1QP/cvgGy0n
	 FhjqU8vRqX8RTnZ2FQ9URxqdUCBqdtctv4EidHPClhVRYV20/IWGnkHrzWM2vEgS8u1XN
	 LaJIdtNIbnMajiUSS/xlLx6tea1xGZ8A47HepOgSecNMtwsn1FF/lJQtkM2+dlt8Rrmq5
	 ZvRRQjN6qTBC6Hoj0179spEX+SLwvazSCwvihCFLnIIYMChJuKcc0xrr1pPH8JiAA8XLg
	 J1oIXuHHHjxTxH7pk7h52Qtds6WzhIM1O/uAS1A2Q8WgLBs+B2+VcePj93aZDhsqmzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795726325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yuz5T/F4AtNj9du0UNwyM9zVfgHnUT5Y/B3BwvR1uuc=;
	b=k67me2JIk2A97FoIIO0bcMosw0ypd4aKUR077k/O+LgqJUzsQHFrxPX06Zua3KHZYNTJ
	 ctAEqkEcn0+rL19hoz0fx+cnr1DvjMPP6JIsfjr+QVyEFi/bvygBHlOPzXzlAXufVFpx1
	 MEGlYYFBUJKcFAv/PL+hBD1o5/mqFuuScWqWCetFFiIrwmorfDjuwi1dCjeYCHN4bIvQI
	 uyRv0R4PqFc4BM3BK+pDzNo/9dLiZfvjGZvl6wRV/L0u9ZXPnfULtalFJCAcY9cEfsqGY
	 oiSmflU8tqcd+lpAhOjQlYZfmEYiKp768KBh2coGmEFxwCVpcXMw/Cg9iDHnBh/VTrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795726325;
	bh=yuz5T/F4AtNj9du0UNwyM9zVfgHnUT5Y/B3BwvR1uuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jS9BoaLfLVsT5NYFW09vcuEue7Hk1lIZnAA8TEYkcQek8VOIG/FVWH1E437idJLtI
	 986NN+nL5j+o5VY1nE7UrbIW09vOkaD6l4R5e+RB8uBpenTo1oTQn0iyKY08SluvSE
	 o9zxKT9dgir9a0fg2tKjkHmg+orgy+6yif5p10dSTrEsUcoSwdDCdOUawAaGXebH4J
	 CvMeSa1pDb6YvH4tnrP6NUpTOFU708JbvC4+oYhZv3YD3MxuUJXyTIkx8w59htWCJ3
	 7zEu/Pq2NIeyP1yJhgPpkqFTnYk4YlYcBK6ZeN7/1VeXZTHpNXA5F4h6DTkP2y6m7Q
	 c4K/t1BrrHNNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92B1140A15;
	Thu, 26 Nov 2026 20:52:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 87AB2266
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 20:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DA9A60AA5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 20:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORXfiTowWf-A for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 20:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4B9C60AAF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=d3J+pnZ0
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4B9C60AAF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 20:52:01 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b4d6981c67so48067857b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795726320; x=1796331120;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yuz5T/F4AtNj9du0UNwyM9zVfgHnUT5Y/B3BwvR1uuc=;
 b=d3J+pnZ0KkUjNEdtdRVRPIcGKw8TbkPvLnmwVbyaRQgEALsTl1Sljf8tun+gUTNX2p
 cqlAfytl/tlq/Xw2kV1Vln1p92Yy/bq19q2UywWrL08f70r7JAQ4x4OF3grkGnIkoNv/
 XyDk+cWPgAuLWdtyMwYrv/eCcSTkMU24eaaZA+UzBrqIPvtb/uNDc+HR7p1QB0sPmra9
 JDYqSj/RddxmOwRWWbZpZzxz6IDDWfzMBGm1imzsJqeY8vVoFeWYkNBEyvSPBR2+PauI
 3K+ShsLjGe71hAqLbGS1wFxcHybcRz5PRHvC7cVjK8i+R6XRmAAL+FlNgRK+b7c+3yH4
 SmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795726320; x=1796331120;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yuz5T/F4AtNj9du0UNwyM9zVfgHnUT5Y/B3BwvR1uuc=;
 b=QfEB1oN6axZnvMhSskOSmWD+ci7I3cgtf5c7IqHPkHOv4MUyvhzv5YByNI+LT1GmnW
 j6F0eBzizm7YKRwwcJjs6lbvtR+WQHrZPyAHSaWyCZ3uGe9UJkSE+lJbZIEcnNxdquQN
 9v6QoX9DUdOuQFHr8jnBpKZ2NOSp9brcRy4GvH649ri6AWBKyzMIhtg2fNSsoCSQ2vqO
 9WFs4ez5hEldpnB/p05hQqh+NOaagGXTmPsHHSGmuxlIWJwqiHL1ASAEY/q2DUDddEWv
 3womR9bMOBnl0Kj6wgXGPXTBaIOxUA8qXmXMoYO7fR86fL9BTjuouotsl8B1SWXZ+EnU
 wh1A==
X-Forwarded-Encrypted: i=1;
 AL+hErFUqyK5sAPjKL5tKQk1HW545UUKp5/wFSw2UGZesTAoGWCYl5+LjraaxQ1bZX0lCh6HF4mGgcg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8qUJjK67VURir2db9zxobpj++DW6wIGrW//mSeilyhuRLZ05Xl
 g5nzezp1Tx3wwpZUvffEJ+pBlfG9Xg0ufCmmJ6eh8noaVkuC2p7F3IHYtle8cg6njYB+85zNisE
 Fp/nUzUTJOAalKhI6V0Yj2kxRjP7B+k3//IizFYMrGg==
X-Gm-Gg: AZFdTZeQE1JwGPfqpMJAkXH8SZ053DMy1OyfmUb5dAKEQUYQPlkUyi5MgcgwLMy7GEI
 phx7U4AvtLhRlPSJhWq5rRCgtWlOdYO0qjMf1SDqtwdHOJ0n3KxJrJTesGBeFFr6s7gfA7A8wFF
 L7Z7H7I7NnGsUgwRRh1G5QHS8OnGHxEzDLLHO5BmoLmAQqTC8jam7qSL7K0juDGsFasHbeLaewC
 +JL6kgjRWQKtl0fjuG+GHvKVI502nnPP7ksH4JTWT90EPGibRaWnD4+k9nvDyfvEVuALbydpGcW
 APmid3TXA+bf20dkck7mmhPBqdELplNvkfGWR+GAkVQgp+NFKoJ43Y1D8d/aNsGUYoAPN9EgXik
 FZI4uqEVgxsCZXvOLzM9gLkzhBWAAAzGSTf/SrEcb8GJyFASIE006KBjTnZHuaeXAMJB4H3HpMt
 gqCsJ/A9n9wZWu3bKI9xwJxvLZiFNJlE8v+VwkrcHHfvfkrjC/R40o+S+nRXoYedaeo9Zt3TNFR
 rIZXLNny4jwlAStXIfVCehrBISkd220QsXgdsGU+jWNBFdPHxueOy4TFiIt89xu05P7ATu/p23H
 ejMsLY8MYKRG4URKHwLu8nt6/BjChoABxhSqG9ODky3IhZmd7ZiBHT12GEmbPWc9iQUHYvlRVzb
 BU/G0ykvSuEIE7yC5OKAyDNxL4BhKVVEbNgKYWgwR8vRMtn9nLsaXeIIVHLRRVEn9IurZWqUxUV
 +f5+vVzuC6kYZvRCqkU2M14JETuCl4DaEnSAGcE43mb9Vf92/++eDP7i2t1z7DOXhDlqaJ
X-Received: by 2002:a05:690c:e3d2:b0:8b4:f326:c4e3 with SMTP id
 00721157ae682-8b5204afe1amr89009337b3.39.1795726320099; Thu, 26 Nov 2026
 12:52:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
 <d19f2102-4da4-4369-b4e4-f6be0fb92500@linaro.org>
 <CAC_iWjKAxtVvp6v_vbFobHXsa9EOjBxtSHRte00W3u2om3vwQA@mail.gmail.com>
In-Reply-To: <CAC_iWjKAxtVvp6v_vbFobHXsa9EOjBxtSHRte00W3u2om3vwQA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 22:51:23 +0200
X-Gm-Features: Aa3M54poQiuxon2kTGxILhOU8P_SgtbOcmzKp4NNVXDuoKX38Hrxj1cen9JU1Mw
Message-ID: <CAC_iWj+TaD8pytZeUozox_ifzFKEyewW6o61tmJO2vPe=KF=og@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Add RELR relocs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 at 18:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Richard,
>
> Thanks for taking the time!
>
> On Thu, 26 Nov 2026 at 18:35, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 11/24/26 23:41, Ilias Apalodimas wrote:
> > >   ifneq ($(CONFIG_XPL_BUILD),y)
> > > -# Check that only R_ARM_RELATIVE relocations are generated.
> > > +# Check that only R_ARM_RELATIVE relocations are generated
> > > +# unless we compile with RELR
> > > +ifneq ($(CONFIG_RELR),y)
> > >   INPUTS-y += checkarmreloc
> > > +endif
> >
> > No, you should still run this.  If there are non-relative relocs they
> > won't be packed.  You still want the build to fail if something goes wrong.
> >
> > Alternately, a different check that ensures *only* relr exists.
>
> Fair enough. Tbh I tried to preserve the logic but readelf -rW seemed
> to produce unreadable output. At least not so readable as
> '0000000e3c68  000000000403 R_AARCH64_RELATIV
> ff531'.
> OTOH I was lazy enough and I (wrongly?) assumed that this couldn't be
> detected yet, so I mentioned it in the commit message.

Replying to myself here, but looking at the output again we can parse
that only RELA & RELR are emitted.
I'll fix it in v2

>
> >
> > > +++ b/arch/arm/cpu/armv8/start.S
> > > @@ -89,6 +89,7 @@ pie_fixup:
> > >       add     x2, x2, #:lo12:__rel_dyn_start
> > >       adrp    x3, __rel_dyn_end       /* x3 <- Runtime &__rel_dyn_end */
> > >       add     x3, x3, #:lo12:__rel_dyn_end
> > > +     b       pie_skip_reloc          /* .rela.dyn may be empty */
> > >   pie_fix_loop:
> > >       ldp     x0, x1, [x2], #16       /* (x0, x1) <- (Link location, fixup) */
> > >       ldr     x4, [x2], #8            /* x4 <- addend */
> > > @@ -101,6 +102,43 @@ pie_fix_loop:
> > >   pie_skip_reloc:
> > >       cmp     x2, x3
> > >       b.lo    pie_fix_loop
> > > +
> > > +#ifdef CONFIG_RELR
> >
> > With RELR, the above pie_fix_loop *will* be empty, not may be.
> > So why are you compiling it in at all?
>
> Is it always absent? Maybe I read this wrong but packed structs that
> might end up being misaligned will still end up in rela.dyn.

So something (nasty) like the patch below

--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -102,6 +102,12 @@ static struct mm_region qemu_arm64_mem_map[] = {

 struct mm_region *mem_map = qemu_arm64_mem_map;
 #endif
+struct relr_test {
+        u8 dummy;
+        void *ptr;
+} __packed;
+
+struct relr_test relr_test = { .dummy = 1, .ptr = qemu_arm64_mem_map };

 int board_late_init(void)
 {
@@ -109,6 +115,7 @@ int board_late_init(void)
         * Make sure virtio bus is enumerated so that peripherals
         * on the virtio bus can be discovered by their drivers
         */
+      printf("relr_test.ptr %p\n", relr_test.ptr);
        virtio_init();

produces both rela & relr for me.

$~/work/u-boot-tpm>readelf -SW u-boot
[...]
  [ 9] .rela.dyn         RELA            000000000013f810 140810
000018 18   A  0   0  8
  [10] .relr.dyn         RELR            000000000013f828 140828
000800 08   A  0   0  8

Cheers
/Ilias

> >
> > > +     /*
> > > +      * Fix .relr.dyn relocations. Entries hold link-time addresses
> > > +      * while x9 holds the run-vs-link offset and the addend is the value
> > > +      * already stored in the place.
> > > +      */
> > > +     adrp    x2, __relr_dyn_start    /* x2 <- Runtime &__relr_dyn_start */
> > > +     add     x2, x2, #:lo12:__relr_dyn_start
> > > +     adrp    x3, __relr_dyn_end      /* x3 <- Runtime &__relr_dyn_end */
> > > +     add     x3, x3, #:lo12:__relr_dyn_end
> > > +     b       pie_relr_next
> > > +pie_relr_loop:
> > > +     ldr     x4, [x2], #8            /* x4 <- RELR entry */
> > > +     tbnz    x4, #0, pie_relr_bitmap
> > > +     add     x5, x4, x9              /* x5 <- Runtime address of the word */
> > > +     ldr     x6, [x5]
> > > +     add     x6, x6, x9
> > > +     str     x6, [x5], #8            /* x5 <- Start of the next bitmap */
> > > +     b       pie_relr_next
> > > +pie_relr_bitmap:
> > > +     mov     x7, x5
> > > +     lsr     x4, x4, #1
> > > +pie_relr_bit:
> > > +     tbz     x4, #0, pie_relr_skip_bit
> > > +     ldr     x6, [x7]
> > > +     add     x6, x6, x9
> > > +     str     x6, [x7]
> > > +pie_relr_skip_bit:
> > > +     add     x7, x7, #8
> > > +     lsr     x4, x4, #1
> > > +     cbnz    x4, pie_relr_bit
> > > +     add     x5, x5, #(63 * 8)       /* Each bitmap covers 63 words */
> > > +pie_relr_next:
> > > +     cmp     x2, x3
> > > +     b.lo    pie_relr_loop
> > > +#endif
> > >   pie_fixup_done:
> > >   #endif
> > >
> > > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > > index 231ab28b50cd..73f0230629cc 100644
> > > --- a/arch/arm/cpu/armv8/u-boot.lds
> > > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > > @@ -149,6 +149,15 @@ SECTIONS
> > >               . = ALIGN(8);
> > >       }
> > >
> > > +#ifdef CONFIG_RELR
> > > +     .relr.dyn ALIGN (8) : {
> > > +             __relr_dyn_start = .;
> > > +             *(.relr.dyn)
> > > +             __relr_dyn_end = .;
> > > +             . = ALIGN(8);
> > > +     }
> > > +#endif
> > > +
> > >       _end = .;
> > >
> > >       /*
> > > diff --git a/arch/arm/lib/relocate_64.c b/arch/arm/lib/relocate_64.c
> > > index 6f7a50f2264e..0572fe2d29f8 100644
> > > --- a/arch/arm/lib/relocate_64.c
> > > +++ b/arch/arm/lib/relocate_64.c
> > > @@ -43,12 +43,19 @@ void notrace relocate_code(ulong dest)
> > >       u64 size = (u64)__image_copy_end - src;
> > >       const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
> > >       const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
> > > +#if IS_ENABLED(CONFIG_RELR)
> > > +     const u64 *relr = (const u64 *)__relr_dyn_start;
> > > +     const u64 *relr_end = (const u64 *)__relr_dyn_end;
> > > +     u64 run_to_copy;
> > > +     u64 *place = NULL;
> > > +#endif
> > >       u64 sctlr;
> > >       u64 offset;
> > >
> > >       if (src == dest)
> > >               return;
> > >       memcpy((void *)dest, (void *)src, size);
> > > +
> > >       /*
> > >        * r_offset and r_addend are link-time values, so the offset to apply
> > >        * is link-to-copy
> > > @@ -65,6 +72,27 @@ void notrace relocate_code(ulong dest)
> > >               *(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
> > >       }
> > >
> > > +#if IS_ENABLED(CONFIG_RELR)
> > > +     /*
> > > +      * RELR entries hold link-time addresses, so the location is found
> > > +      * with the link-to-copy offset. The addend is the value already
> > > +      * stored in the word, which pie_fixup has shifted to the run
> > > +      * address, so it is adjusted by the run-to-copy offset.
> > > +      */
> > > +     run_to_copy = dest - src;
> > > +     for (; relr < relr_end; relr++) {
> > > +             if ((*relr & 1) == 0) {
> > > +                     place = (u64 *)(*relr + offset);
> > > +                     *place++ += run_to_copy;
> > > +             } else {
> > > +                     for (u64 *p = place, r = *relr >> 1; r; p++, r >>= 1)
> > > +                             if (r & 1)
> > > +                                     *p += run_to_copy;
> > > +                     place += 63;
> > > +             }
> > > +     }
> > > +#endif
> >
> > Similarly.
> >
> >
> > r~
