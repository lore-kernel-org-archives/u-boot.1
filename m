Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C5606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CLRI5CyT;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wiKi+/zH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C200581107;
	Thu, 26 Nov 2026 17:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUWJZBWdC3Jp; Thu, 26 Nov 2026 17:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03A428115C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795712645;
	b=AvSios6IIJXxN3yyngQazH20QJl+RWMVskTdtsrc2ILipYHNXlXhSW7U2I/q83FhPlAs
	 eGt6OF+mNN/4vjr+FgA6JozDtJQd428Q0QbDcOiGGE2AssMVCKcXbGhGMbH2Rz2e2EcxW
	 1AH7+AmXVm3a9uX11UpVnuhTTojgKj8S7KUSNch+mAxbsLTmPJXcRnErr5Z7ttTWsMGqM
	 rmJTxPpupEYRv0wPECAXBzt2LJejQl/xbbjDAXLRvyTOmddvENUEWQj3hWVix0bjb74bd
	 rm5b4kAjrM2c3Uji1tz0neM7EAQS9NGZkqtRJ0uP+AwXOWwViWPMtiW27Jx8TQLk6IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795712645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=56T6K37mJ0FhTzV+qrGrwqDg3midEFRQqbGk9DtQsWA=;
	b=ILptt/QLmCGaXgnmJifjb+PxkGJ6Tz9smEmrEzEVVx4Way68Z7/BdzKn33N5Gy49wOfu
	 BIAN1uLJzJMt0llVB9JCcepIruBHmCB4LZk20gcCyx2w6xG1Q1DBu3rLXvRDOE7lBhnIi
	 yj6z/DAhleQsbGA9w/dC/bR91tqNm9BbIWpTm+uMxHm8rq+YJ9/ZvLvUg2x5cvJZllZL7
	 PJ7HVIDvb/A6xCOD88vXM+2aYUILGNLuuKgmL1qm/e/+CzrEavlPMKwZSB01nPY7LBtaH
	 HPFVefrWms3seRHv1OoqXoXEHNEoHGwpWW12N7v69eeQk6vuwKCatH+WJR/n+flLgcA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795712645;
	bh=56T6K37mJ0FhTzV+qrGrwqDg3midEFRQqbGk9DtQsWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CLRI5CyTKx0sib0XnjA8ROTo3kr5BnOkVIRkVsI8ZAHZXDK1vMvlx0LX9OvJRvg8Q
	 ufy0b/ydspzTjY1DCY4zsEXpSzaxGFgTkuKs6SMPV0WUpmTAsT5Ha4mVky4FuutXqv
	 y1p5FLSjqm6WS/im053+owayit7ptxdot7PimIilUr/qR9ZzRbx5Iuxle90/1Fn8LN
	 OMsy3PkGU4hU7DgheGOB0xhqJiS2F/1ln//9BV7QZrFkNJ2fQQ6WaLGCW/WpQ7GKhs
	 oxeTrPhxJD+QUjpjOdsRYYxpdLMhf6LsHS8weuBNEaKCWrptI6g44OX/pkN0HZ6rqb
	 meo7S4eyf/ezw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03A428115C;
	Thu, 26 Nov 2026 17:04:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 860E622B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77DCB60A8C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNZKavBgOD9C for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 17:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5299960A6E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wiKi+/zH
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5299960A6E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:04:01 +0000 (UTC)
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-675617e81f9so8239542d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795712640; x=1796317440;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=56T6K37mJ0FhTzV+qrGrwqDg3midEFRQqbGk9DtQsWA=;
 b=wiKi+/zHgtpQnXRQO0lZPrElXggPKwk1wV0oz0N212d4VfoIztWfYyvzGNkmQhK9Bv
 fP9bLKJAnrCBqzCcOyqWZFfeIB65cr167GDlfA0TKhcNtcIJl3qxMX/y51H5SVHjrQqu
 YL3VFpQFdUtkYzrWmycVMWnkI47q3KIbCZWJXp0TkeiapFSUNtrkvzVVc4cxVyf2fuiO
 yBLqJTg92orfqU1nrUzBU1aqEU2pscrXfP2fWU9jDycWALUPBtKBiLzD03YV/yVqiwvG
 Bh8m38/hcg6+7KSpJ5Vgw3jJvBeFj6I6bE75hNYgvAOo29RJjoQvRAFHbt0a6ovcIRfB
 0QPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795712640; x=1796317440;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=56T6K37mJ0FhTzV+qrGrwqDg3midEFRQqbGk9DtQsWA=;
 b=mcceplsvi4TBinWIih9MAubh/TCaWM+b5lG+QRaVyM6OTGBHXbSX0iS3cLYwJ9uWS8
 JY/EvhTLw+0bu6230CYQVV82O+SF0tVI0XUgGGS+b3GeN8Aus0stF/wcU/HVEUgs6HxV
 E0MZ80WHdMKGc+0vFoQihCoy2ilyNVzTmh0KNxOeteQhQVAEuZOSO2ASXb4B3Te+uyOk
 /oxOc2nZ8RWYiGst1rRMZBWpSsOulxToWSRZfq+S+GDfn1wgkSepr4WYnHeDWc5xCFv4
 t8hrFf8kbdl47OP3R2X0oIIw166kMAYsvxfJ6zb1DtZgS1b0UxPDLT5GhNfvy4NrPnlH
 Q/2A==
X-Forwarded-Encrypted: i=1;
 AL+hErGkpVo6bMwgHfDc0XRXwmPqyOEpuWYX6UPehAoPruuAffFJ9VqcPLnAhhqgs+lwEglAdGUnJSw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9iT1OWmBpOBo/2Mw+IUMLoRHcitDglS3a0SSQYNKrM7vJKN3JT
 5ic+VQRXZ+D2HxvAtcqfdx9cRd2BYXWuEEDj6b4nTHW51v0b+3lroHgXgEaL2BJWWa1GtbY2MKC
 ejW7cMt5Wq1NkdQLN5hdUOjx/ew0vRkaedtKuBd1sq0QmJCSBDINDUJA=
X-Gm-Gg: AZFdTZeoE7kQZ/h0UJurS+V5Xak620o4DaPEeDlnvgRlNfXNIWDB2IOkJE8XIrQM7RI
 rPvU5OMiX75T+t720NBhv0ZjhE0tokWLsb7YFEOS4nHhrIZGsL/lQXYXt5ahjagFZBVZrFN8Tst
 GDnnOSgaeWmugBHSjKDlJ6pt4chwPKDEQ6XeEwNTk2kbDGyUx8Rfw+5lWnNn/5UP9n+asaSOFlu
 npdsJfReERR0Q68rwyXuamQwje4obvlaXVLftedtiOjywZU72mQu40ClXSDUL0WVRgJ2l0c7P4G
 U2XSGTaHtAoP4FBh2xd3mhHJhqSRH6qznGtbK7F+tNTiEMj73dCC4VT28PiBpI72ZSWrlBsl5Cy
 GD47bYBwgicJlmOtcTqlQ0FIXcYaKmukjZeI2N62xTtpEDk7e5kdBkZVKkr0jBBNk2LR5nYPNuL
 lbmiwlElAzIWlrzyowP5LAEQcgkaoUk6IhTjanS9y45wcGGEdTTOBWMKhUmREU/tVDAiRQc+Df9
 RIZQNQ+sPaoK1GG2mRr91Tmsu26BGh78ozf864xCoaYUpgVcsB4xpbHmQdoFix+bGeEzkCiCS8K
 xoH3rI6R73IrS+BFQG861bg3C5rcrKs7+07ISWJA2ebunokPWl2BDLWTPPVsQ6EF5gmP7JAuf+B
 Rp4FYDQKmSNSGBrOm4Tle3dZxtXvZKgaY6rR9l4ybJKr4yYA1yDDhcwdkg1WZuhri8naTM81eh3
 aZA8tJY2QKbKnqrS7dcnSWV0WskPJ8gxRqoa0dwDFOg/QaCzCNQPMelJKLo53x0j0wz9ZmPO8=
X-Received: by 2002:a05:690e:b85:b0:67d:ad09:ba96 with SMTP id
 956f58d0204a3-67dfa20ba4dmr8242708d50.19.1795712640452; Thu, 26 Nov 2026
 09:04:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <ef34ded1-ade9-4c79-8f4a-4eb7e817a68b@linaro.org>
 <CAC_iWjJGSR+K2x1yn8Jxs5FLfrJTknH85s4MOsYMwKF-O8iUJw@mail.gmail.com>
In-Reply-To: <CAC_iWjJGSR+K2x1yn8Jxs5FLfrJTknH85s4MOsYMwKF-O8iUJw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 19:03:23 +0200
X-Gm-Features: Aa3M54r5XL62wdXjasG_VXlpsTtZCNxUQZFQqDi21wf3pS936D54OsqPpLuxdDo
Message-ID: <CAC_iWjLUMwZcV9-g5OFAWanzzzMWGZFZmzARDPyQOWdET6yMYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: relocate: convert relocate_code to C
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 at 18:18, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Richard,
>
> On Thu, 26 Nov 2026 at 18:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 11/24/26 23:41, Ilias Apalodimas wrote:
> > > +/**
> > > + * relocate_code() - copy U-Boot to its final location and fix it up
> > > + *
> > > + * @dest: destination address, gd->relocaddr
> > > + *
> > > + * This is entered from _main in crt0_64.S with sp and gd already
> > > + * pointing to the relocated area and with lr pointing to the relocated
> > > + * copy of relocation_return, so returning from here continues execution
> > > + * in the new image.
> > > + *
> > > + * Constraints for this function, since it runs from the old image and
> > > + * before BSS is usable:
> > > + * - It must not touch BSS. On arm64 .bss overlays .rela.dyn
> > > + * - It must not rely on anything that needs relocating in the destination.
> > > + *   Symbol addresses are generated PC-relative (adrp/add, -fno-pic), so they
> > > + *   resolve to the runtime location of the currently executing image, which
> > > + *   is already correct, either because we run at CONFIG_TEXT_BASE or because
> > > + *   pie_fixup has fixed up the running image in place.
> > > + * - It must not be instrumented.
> > > + */
> > > +void notrace relocate_code(ulong dest)
> > > +{
> > > +     u64 src = (u64)__image_copy_start;
> > > +     u64 size = (u64)__image_copy_end - src;
> > > +     const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
> > > +     const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
> > > +     u64 sctlr;
> > > +     u64 offset;
> > > +
> > > +     if (src == dest)
> > > +             return;
> > > +     memcpy((void *)dest, (void *)src, size);
> > > +     /*
> > > +      * r_offset and r_addend are link-time values, so the offset to apply
> > > +      * is link-to-copy
> > > +      */
> > > +     offset = dest - CONFIG_TEXT_BASE;
> > > +
> > > +     /*
> > > +      * We have a makefile check that aborts if reloc entries are not
> > > +      * R_AARCH64_RELATIVE.
> > > +      */
> > > +     for (; rela < rela_end; rela++) {
> > > +             if (ELF64_R_TYPE(rela->r_info) != R_AARCH64_RELATIVE)
> > > +                     continue;
> > > +             *(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
> > > +     }
> >
> > If you've got a build-time check that all reloc entries are RELATIVE,
> > why are you checking again at runtime?
>
> Defensive programming I guess, I can remove it, but I'd rather keep it
> in case the Makefile checks ever go away.

Actually I remembered why I did this while responding to the second
email. It wasn't defensive. The second patch removes the script
because I couldn't find an easy way to parse RELR + RELA. Also while
reading up on RELR, I thought RELA+RELR can co-exist.

Thanks
/Ilias
>
> >
> > > +
> > > +     sctlr = get_sctlr();
> > > +     if (sctlr & CR_C) {
> > > +             __asm_flush_dcache_range(dest, dest + size);
> > > +             __asm_flush_l3_dcache();
> > > +     } else {
> > > +             /* Non-cacheable stores need to complete before we fetch new code */
> > > +             asm volatile("dsb sy" : : : "memory");
> > > +     }
> > > +
> > > +     if (sctlr & CR_I)
> > > +             asm volatile("ic iallu\n\tdsb nsh\n\tisb" : : : "memory");
> >
> > isb here is redundant with the one below.
>
> Ah fair enough. I need it whether CR_I is 0 or 1 right? So I can just
> remove it from the if()
>
> >
> > > +
> > > +     /* Always discard anything already fetched/prefetched */
> > > +     asm volatile("isb" : : : "memory");
> > > +}
> >
> >
> > r~
>
> Thanks
> /Ilias
