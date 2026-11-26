Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AC606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cxib5iSw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WafSWyVJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22E2960A83;
	Thu, 26 Nov 2026 16:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xuAfal1t4-HN; Thu, 26 Nov 2026 16:58:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 386546066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795712337;
	b=DkNGadyWmb6L3lUEOkC9S56kb3fjKWI0RvBW7kPE+Fbsp5gqZm8cYM9W5Qu61tdG9aVe
	 4jOopUorN5i+POB8MkEGh9ryt5plVrdzDGv1aTO8ZQ1JSuMQS4RwUyKnRXQ3pv8pDbXWq
	 ieBvNuN93/gpAG9oxW508jBh+ZwWiRYUW48Avn8WNdiaPSQo3oaeon71Z4QvAfqfvs2Dv
	 1+v4UNtr4rafdUaMbwzakdQeuKvzhj4Xm2UX9beEvduFeR6OhOk/spDvdHAVpJremB4IT
	 EuKpbiJV/OKwnqZLuxdCGZNsvSP5bEe86WiNtFAXiRQxXfdtvdoqnE4uCldcW3fWXAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795712337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=aRBsMKwKxo5WlQudId8LegABiKa7/N0i0ruIDS5eNjw=;
	b=brUtAY8Og8J6AbRMOMYyOEMp6hMtVki2cyf8gu267qNdENGlILE67rqawRA0664q7rWd
	 y+iHWf1bEn4mv7bIZ6kF843ZAa8TkR66A6XVwJmq/XwA+y5egNW/CgsDu2gHev/wh17pH
	 StMLJJWair4BlmOaTQddQgLjRYwP5uGdNvCXbtoK9vybfOSidkTcH2sBYXNGdTrZoenty
	 7/X8JAi04s1IIONA+JbMrECq17cPdcYBXWAj90TRthLiWdbWSvITlKev3Sd7JmX3CMWZL
	 yTpIqNUxhio8MVEQvm3WgC4D7N8VeSo/4FtdNGj81kERZQa4bMf2jUtzZ152sjXTCBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795712337;
	bh=aRBsMKwKxo5WlQudId8LegABiKa7/N0i0ruIDS5eNjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cxib5iSwKnCGNlIenir00xDbAWR0TWmlfenn5soGwWM+4twZL8i2QIsaVqv+wsM9K
	 mGMHk8KEEs0iTmIOlAkQNzoetOvjl3NrrhZHzWeJNJdCARx48+3icphriuEFvQEKhN
	 XoILAXwlRqVtQnjwg5jiiF6dwkiskOf4sUvdIhly8zwP/mvYE2+gfVQTzv4QNYITr2
	 Xciu13jlP9CMKNOUgl/W4B3NCzubCCGxVVZss83pBTWU48Qc/LqUVH6gav3ilQ4Kkn
	 4XMiBuDMUwXkP+68CxPwYuDlAq2QHGWDYcI0IHNEYkvL5F9sUZp0YEeaAaTrEWzRpm
	 IOS77OIborPLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 386546066D;
	Thu, 26 Nov 2026 16:58:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B5D832D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28AD080C8B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CCiMWvurNpng for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 16:58:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 063258084A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WafSWyVJ
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 063258084A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:58:52 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b502b9b702so83775507b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795712331; x=1796317131;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aRBsMKwKxo5WlQudId8LegABiKa7/N0i0ruIDS5eNjw=;
 b=WafSWyVJbRzkAmQdUFB5JsLQfPCDa/8q9qcX1vI/dKTXvKWZo2sVahnxWtaep2a+34
 3xsYSGZmfC3pRFL6mSurYk2ypBrjpy/Hj02BxwbxLP+sn11CT0C1MuQahq3AorELPBPF
 Yz00AqEHsu+HaF7hFzeXO471ANb5mgYiRhj3AGfEKMQyZgo8xfuR5P+mKbPkfoyK6CWG
 V+vXM1J6a13vNNCqErJjifCWZVBW9UZd2xYLQyVUNQTdE7MWvIV+Hbrklq6Lv8dLCA5D
 cRIqewU8OENL8RBYCo9yXOaEJDn/ZcQW/9lxrj0rtU32szWhH6m2hSqArW82I+ET3cKV
 ceAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795712331; x=1796317131;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aRBsMKwKxo5WlQudId8LegABiKa7/N0i0ruIDS5eNjw=;
 b=nv6RLLar9paU3P5AisBqwwcqZKdUq5BEAezHl9n8k0j9Gap8EQxZf/k3puhoitl9jh
 NdN4rK6Z1sy1zcuw+wZDvTBkyCxVn507eh4sEqRBEE+6XElaTQloiF0LVqnXaQBoPEw8
 Xz8u18RNiBEI4zSG6/bbnwBnAlfpZzgiaC7hP/jMuchDI7RRV85Sait0ywCcAPonc10g
 ky36wE4Pmczmr+oqhWLuRK4setf5u5uIz1FVnhtyF2r6D4fnY2cloBtdyz3B7DzNE3lC
 MEyv+KJrm9gdZY9daO+3R7SgV9uhWXZUmDTXdIW33hraRAW1Rzv85qo1b53NChZ9wdCQ
 UyAg==
X-Forwarded-Encrypted: i=1;
 AL+hErHYgp30s6KpCszht2w6DgdTBa/AHLkZKU/SUHww1ihZBWDqyAm8iAj6f0H4oPKGGrn2EhfzbJI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z87AaFR5X37aPv7YeqCCNm3Qvnn3V4Eg7liykZ0u3D2jayNPx38
 NJEcAcoYPughc5SYqjV26RKQSVM8Gnyyo25CV9PNfzO8/qT1BNBPjpEJ469SrhNyfiJq4ba5gm2
 HwRz3QI5CD/b+JWL5rs7fVhmfKht4FcTJuiBWQnxLzYdAkknG7R73kAanww==
X-Gm-Gg: AZFdTZejEdfDKXIP/mYdNOIYzEEKP+MPYBh/AaKeuDWCaDCGUZjVO6IWlsg/51vchm7
 mR8Yv/zZMZBh60pE52Ia9O5GvA0pIOp2yUGJ8HuY3zwFgCzdNMlWLOIYgbPwcFv7Y5DdZIBF5Ad
 430gyT8C89YcUXRDFYUzQiZUQJ+a/bkmsdcP+HRxmAznLToXW64JRjEEC1gMqgR3jFsOuO6N9ji
 P2xq9qShlzJ0nYSVqBqgNgW/a63vJCpfhd/jQtegcDEoVDP632vipj1o01EZ/RbONXobA6p9IoS
 jRVJoetAstSG6rvt7XpCz6qSQccexXFX+6jteVyAUOigfYJy8it9l+2azTApI3Glckca1h1V6AS
 rkC6HqxoBII2Bjr6tLbS+wvF+DATn4T0xYGKAvQE9zBklrrp3JWEkiDTrDuvtT91C+d9P5NcRok
 X2xWgsufCib/EMDthCVpjw4zkr3WQ19J19Bmv9E8XQjR/pgxkacZWPDatToG4pxzqDIe2fTY+uL
 ty8HwFPJ/b4sRY00/G07ONOp4F/A43G5xVBBkS/ZMR1vwMNRhZCrfHT7vSE3T9IyCD4jVlEjWKM
 wVUDwyKVVu35uERE/j16lD2hR+odbw/3wFerWJe+vUArVPXcBH6x2kZkno0/LOJRXbFWk836x9T
 BlE/QAGpRYVD7WBWTRDK8fgSqKO9sincsf0cPU2gLGOApC5H/9UnV1nImKq68X7iYrsal9OxE74
 fiAcBmaHZ6gsHrVd7asIU3MMqiCAuAWMiYTqUqA5atHSpw7A2WBiWZZr5V/EIV0ybEdCfwwLBTD
 EA9x5t3i96T5zwbYAV6
X-Received: by 2002:a05:690e:1907:b0:67d:a511:5e71 with SMTP id
 956f58d0204a3-67df4528b50mr8213413d50.150.1795712331301; Thu, 26 Nov 2026
 08:58:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
 <d19f2102-4da4-4369-b4e4-f6be0fb92500@linaro.org>
In-Reply-To: <d19f2102-4da4-4369-b4e4-f6be0fb92500@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 18:58:15 +0200
X-Gm-Features: Aa3M54oiP9jhQrar-Oa2tKcG383VV881l3TQ1VVx8NULec9ZmWyhSciuHOqpRn0
Message-ID: <CAC_iWjKAxtVvp6v_vbFobHXsa9EOjBxtSHRte00W3u2om3vwQA@mail.gmail.com>
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

Hi Richard,

Thanks for taking the time!

On Thu, 26 Nov 2026 at 18:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/24/26 23:41, Ilias Apalodimas wrote:
> >   ifneq ($(CONFIG_XPL_BUILD),y)
> > -# Check that only R_ARM_RELATIVE relocations are generated.
> > +# Check that only R_ARM_RELATIVE relocations are generated
> > +# unless we compile with RELR
> > +ifneq ($(CONFIG_RELR),y)
> >   INPUTS-y += checkarmreloc
> > +endif
>
> No, you should still run this.  If there are non-relative relocs they
> won't be packed.  You still want the build to fail if something goes wrong.
>
> Alternately, a different check that ensures *only* relr exists.

Fair enough. Tbh I tried to preserve the logic but readelf -rW seemed
to produce unreadable output. At least not so readable as
'0000000e3c68  000000000403 R_AARCH64_RELATIV
ff531'.
OTOH I was lazy enough and I (wrongly?) assumed that this couldn't be
detected yet, so I mentioned it in the commit message.

>
> > +++ b/arch/arm/cpu/armv8/start.S
> > @@ -89,6 +89,7 @@ pie_fixup:
> >       add     x2, x2, #:lo12:__rel_dyn_start
> >       adrp    x3, __rel_dyn_end       /* x3 <- Runtime &__rel_dyn_end */
> >       add     x3, x3, #:lo12:__rel_dyn_end
> > +     b       pie_skip_reloc          /* .rela.dyn may be empty */
> >   pie_fix_loop:
> >       ldp     x0, x1, [x2], #16       /* (x0, x1) <- (Link location, fixup) */
> >       ldr     x4, [x2], #8            /* x4 <- addend */
> > @@ -101,6 +102,43 @@ pie_fix_loop:
> >   pie_skip_reloc:
> >       cmp     x2, x3
> >       b.lo    pie_fix_loop
> > +
> > +#ifdef CONFIG_RELR
>
> With RELR, the above pie_fix_loop *will* be empty, not may be.
> So why are you compiling it in at all?

Is it always absent? Maybe I read this wrong but packed structs that
might end up being misaligned will still end up in rela.dyn.

>
> > +     /*
> > +      * Fix .relr.dyn relocations. Entries hold link-time addresses
> > +      * while x9 holds the run-vs-link offset and the addend is the value
> > +      * already stored in the place.
> > +      */
> > +     adrp    x2, __relr_dyn_start    /* x2 <- Runtime &__relr_dyn_start */
> > +     add     x2, x2, #:lo12:__relr_dyn_start
> > +     adrp    x3, __relr_dyn_end      /* x3 <- Runtime &__relr_dyn_end */
> > +     add     x3, x3, #:lo12:__relr_dyn_end
> > +     b       pie_relr_next
> > +pie_relr_loop:
> > +     ldr     x4, [x2], #8            /* x4 <- RELR entry */
> > +     tbnz    x4, #0, pie_relr_bitmap
> > +     add     x5, x4, x9              /* x5 <- Runtime address of the word */
> > +     ldr     x6, [x5]
> > +     add     x6, x6, x9
> > +     str     x6, [x5], #8            /* x5 <- Start of the next bitmap */
> > +     b       pie_relr_next
> > +pie_relr_bitmap:
> > +     mov     x7, x5
> > +     lsr     x4, x4, #1
> > +pie_relr_bit:
> > +     tbz     x4, #0, pie_relr_skip_bit
> > +     ldr     x6, [x7]
> > +     add     x6, x6, x9
> > +     str     x6, [x7]
> > +pie_relr_skip_bit:
> > +     add     x7, x7, #8
> > +     lsr     x4, x4, #1
> > +     cbnz    x4, pie_relr_bit
> > +     add     x5, x5, #(63 * 8)       /* Each bitmap covers 63 words */
> > +pie_relr_next:
> > +     cmp     x2, x3
> > +     b.lo    pie_relr_loop
> > +#endif
> >   pie_fixup_done:
> >   #endif
> >
> > diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> > index 231ab28b50cd..73f0230629cc 100644
> > --- a/arch/arm/cpu/armv8/u-boot.lds
> > +++ b/arch/arm/cpu/armv8/u-boot.lds
> > @@ -149,6 +149,15 @@ SECTIONS
> >               . = ALIGN(8);
> >       }
> >
> > +#ifdef CONFIG_RELR
> > +     .relr.dyn ALIGN (8) : {
> > +             __relr_dyn_start = .;
> > +             *(.relr.dyn)
> > +             __relr_dyn_end = .;
> > +             . = ALIGN(8);
> > +     }
> > +#endif
> > +
> >       _end = .;
> >
> >       /*
> > diff --git a/arch/arm/lib/relocate_64.c b/arch/arm/lib/relocate_64.c
> > index 6f7a50f2264e..0572fe2d29f8 100644
> > --- a/arch/arm/lib/relocate_64.c
> > +++ b/arch/arm/lib/relocate_64.c
> > @@ -43,12 +43,19 @@ void notrace relocate_code(ulong dest)
> >       u64 size = (u64)__image_copy_end - src;
> >       const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
> >       const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
> > +#if IS_ENABLED(CONFIG_RELR)
> > +     const u64 *relr = (const u64 *)__relr_dyn_start;
> > +     const u64 *relr_end = (const u64 *)__relr_dyn_end;
> > +     u64 run_to_copy;
> > +     u64 *place = NULL;
> > +#endif
> >       u64 sctlr;
> >       u64 offset;
> >
> >       if (src == dest)
> >               return;
> >       memcpy((void *)dest, (void *)src, size);
> > +
> >       /*
> >        * r_offset and r_addend are link-time values, so the offset to apply
> >        * is link-to-copy
> > @@ -65,6 +72,27 @@ void notrace relocate_code(ulong dest)
> >               *(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
> >       }
> >
> > +#if IS_ENABLED(CONFIG_RELR)
> > +     /*
> > +      * RELR entries hold link-time addresses, so the location is found
> > +      * with the link-to-copy offset. The addend is the value already
> > +      * stored in the word, which pie_fixup has shifted to the run
> > +      * address, so it is adjusted by the run-to-copy offset.
> > +      */
> > +     run_to_copy = dest - src;
> > +     for (; relr < relr_end; relr++) {
> > +             if ((*relr & 1) == 0) {
> > +                     place = (u64 *)(*relr + offset);
> > +                     *place++ += run_to_copy;
> > +             } else {
> > +                     for (u64 *p = place, r = *relr >> 1; r; p++, r >>= 1)
> > +                             if (r & 1)
> > +                                     *p += run_to_copy;
> > +                     place += 63;
> > +             }
> > +     }
> > +#endif
>
> Similarly.
>
>
> r~
