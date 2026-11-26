Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11375606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sxpKcSez;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZoR/hFc8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C83CB409D8;
	Thu, 26 Nov 2026 16:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wV9szdRO8Iax; Thu, 26 Nov 2026 16:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3AF2409D0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795709939;
	b=ShxsOvpNPdCY03IT0ZT903UnN4zNyC3Z7L9pHZ+nZapcx7po2FbiLIm7J7i1Dxo+Yv4E
	 cE737LDAksyZKaJz3rIBlh32T+Z9RZuQzTINBanQKYhfjzVmW5ylYvOKyLUcFtHIMVQxn
	 il6Rgzd3qPx0LB/lEkS9uunDTA2phDai5vEbpikOlSdkMC2rBofllvCscDEYkgtWFnNzu
	 77UzPCmSwjywCnJeb7iqEY0BP2Dv7RvZTpUu/c1q7P9j30QSfXbsYSVL3iZ4+XMZ9ZNWI
	 KKwYQYgCNcAJZqONtHT73rGT7f/HQnKmUnZLv1TDgTf32t77i7YLxYCvPPAYWe1d2JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795709939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oWmfKOGTh1buC/NEIDeO2WpRnk2KzhOPtCKyMqPQ8jM=;
	b=kGxDYxcbIct6e6WsYZafm+MT7VSV9pi0KubKevcfaLUHDgN0EfU+t8qjBmzHoqOLS/n7
	 semDlh9LLJG5tCiBBk+BX23ZEgZsgtV10byD+/QxcVQHl7P3bYRks5mIhDnjiYkOE7mAC
	 FWeNRuhWn81VzIvxMYOk2is11S4PbHjBM/+3iCRJCEFjFxejQ9OCMbJvENlDfUK2O8RY/
	 NyCwFXgteIZj6ngchv4T9XatFiZQit1rOW2ncssItUOL9MwromOKGaIxeuk4skd/Ld7Bw
	 zsTcONxd8Oy4mzGBP0ATTsmHkM4IeUwXyFoLC/QaeT14BRriAMSW87362Qr9h5nVtog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="ZoR/hFc8";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795709939;
	bh=oWmfKOGTh1buC/NEIDeO2WpRnk2KzhOPtCKyMqPQ8jM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sxpKcSez1DVW0SxOlJt8vr0cifFbyyE1Lpdkw18TMiwlgxIDj/TduhZ3xf0GUVOIZ
	 0SprZSBnM67vH39lp6/w2eKFeekMCf1PbVSmi92m239vPFEBkxBhwuB+asgpm34+K5
	 MpE153Mz9bOcBkaNQOQ203T+gncBiHzd9bcu2yMUX6uWtSP0jJPYt5upFB5+c4PUtW
	 LxpYMuG8PGT1J6dfMW3IW3UgT2bcGPQCxxrPaiRBumIqcoCtMHCr4uRC3UdZG6NiPR
	 brtPRq6+7XeNLbnr9AatVCA3uKIw8Gt3BUeYLMI0w6+3Fy0dIMv518OJYh8ObSHmOS
	 13NXwTK+wUBWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3AF2409D0;
	Thu, 26 Nov 2026 16:18:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BB572260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1D2B409D0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OJaOqP46WkwN for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 16:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 90A33409CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ZoR/hFc8
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90A33409CF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:18:55 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b4c2da74c0so46914067b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795709935; x=1796314735;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oWmfKOGTh1buC/NEIDeO2WpRnk2KzhOPtCKyMqPQ8jM=;
 b=ZoR/hFc8hhfhnqtgvEHAhxDnora4/8s55wx9/5hq/zxINjOH/ddfvpHEzendHnmYbT
 UEx/MCjzHGgacjXYHUupkXoVK932fqzA+SMVMAtKDRBdkFF33cgR82N3QgQqkJIaVhrk
 Ni5ullsXmup9ZO2KhpNx/jTLVsfNpBCdK0fe1BUbHEaScnF+X7zkvmsEUWP71Inwg/8A
 MxCvq0CUN2hNVVH528G1BXE9Tx2WLHl1G8uweRc97VDJhsBM6yQlkkj5EtYPsSN8Rq+7
 aQ61Na9S4iYRYIQ0Wh20zJIUw5r0Mja6e5jYMU0NmN/99+XAgFhg7SoLiaE9BxsQ+MCR
 K2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795709935; x=1796314735;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oWmfKOGTh1buC/NEIDeO2WpRnk2KzhOPtCKyMqPQ8jM=;
 b=A7fJSNGQ3mkqZEJn02450AmIdtGIAJC0mmSFoAMcAhYDmBQ4QV3DQjokVBd1EVU9wq
 5jiRwNYiUx/OnfzPqgx0Dc318MMKLSoq3dvDx8lSMOBa0ixzZnJHAHtJt2NNAr7VjmnT
 FcORV6LvP8z0ZydvQL1ggIIoX96BPu+CHgVQnt18vYZSazJirTkNcWDZQMkM3m6Qerq7
 GRdIwQSCnL12d8FM5LKoiDAQ9wZqSvYjPQFRlpzyPUxWRJvzMd9JNcgxC7P5TpQGFq00
 +3mRgwWE3hMQ70911VRqrTTqPo1YlmSIcWoyt09AqmLZoPdLPX2KhEu2jOMTStgf0B8s
 ZIKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE+NU57JqQy5xjsEqdQJRJvfHv3XqedNt0DMS3ivOtLuYOs9MN7T53T08L3JgfGfxzsslFWTPA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/T91r4hu8b6zNc60lkEadIdq2x4/v/Ri5NIGyjpS7vw+D4owD5
 Z4RA1Gec0bqfttScyVN/CdGRLm6Cmi1JG1v1mZf8t5i3WkSbugoh0I9YfGm04nvs/7MzRwRRFcN
 T1xOmECTUHB0E53aa6TauoW1SYdgJDgAQK+H+D3hbNQ==
X-Gm-Gg: AZFdTZehOoXaH93VVOT5YW+VE9rdyiOSCa7wd/VdVKXzBo+dvajnlv0nI6Qa+Nd8NCI
 QC0O/4o1aOF0JGHUlePBK5/4M3qii8IDcRsjG0bKKkeVo2UDH2IoHPN+Adv49JsV9EN10GRaoHK
 13WriBFf7NrARidSvYJHFZSJPwpaa9vaklqeFWrDfo5v3E+15TezTUy7fuT0WmFt8jTPyaJMXIc
 lLwEgKaTdusANM/qKEsWqbVxJgx3u0JMGbGGngbm3/V7Rgp3cQWM/DtmaVEnF7+KhmGAhnej6KZ
 ajIB7URaD9NmurhwfHfKICa12IC+xH1HBqmxx9o/XZHfBrRJqI7uNgBbWr1HyFBFf7/mBTJw0X4
 1jTLBTxI9FWRHx378reMqF4DNh5JcGhiU24CvSlqMiJKUmXEOa7BonoAQbtWJ+Mqi7X+1KNvF9H
 HmYD/bJFvdXudV0Q6Sxw0s4iKBIwraQG3VFj+k/Lz5m7dbCMZ0FzuNkIQlAST11eFuPa/HjxBbk
 vBOJKIRll1EQk+5GY2vXfyTkhcypaQfU9kOC8yCbPE0TfrdPSRGf96rvTFreqDWUOzA6oatut2P
 PY/6zsal1b6PXSc+p91JEm9sIrD7MPOW+uAEpGfPMtGzYKy9DtGf+1WouM4Xwe0axCYPc8gefDT
 51CwhC6mcAuhDTzkjSN2TQ6ipeSqleCEXb9y5H68+jQ7pBDNdht634gNYyEGZiQIUgsgbgy+4Df
 9oXdS+xp+8BNs7u5TVEkaRmLaSe0KVMHjcsnC5D3WqrxLYsmk1G10a2UzDTwqGtrV74B3xQMc=
X-Received: by 2002:a05:690e:12c7:b0:67d:bff8:c405 with SMTP id
 956f58d0204a3-67df42b57d5mr8006755d50.5.1795709934749; Thu, 26 Nov 2026
 08:18:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <ef34ded1-ade9-4c79-8f4a-4eb7e817a68b@linaro.org>
In-Reply-To: <ef34ded1-ade9-4c79-8f4a-4eb7e817a68b@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 18:18:17 +0200
X-Gm-Features: Aa3M54qc-Cyt5HFzKPhRXcKOK_QRh3OgIs8S1oJKNWrYj8FnhQnNQ73AS_M0Jjs
Message-ID: <CAC_iWjJGSR+K2x1yn8Jxs5FLfrJTknH85s4MOsYMwKF-O8iUJw@mail.gmail.com>
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

Hi Richard,

On Thu, 26 Nov 2026 at 18:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/24/26 23:41, Ilias Apalodimas wrote:
> > +/**
> > + * relocate_code() - copy U-Boot to its final location and fix it up
> > + *
> > + * @dest: destination address, gd->relocaddr
> > + *
> > + * This is entered from _main in crt0_64.S with sp and gd already
> > + * pointing to the relocated area and with lr pointing to the relocated
> > + * copy of relocation_return, so returning from here continues execution
> > + * in the new image.
> > + *
> > + * Constraints for this function, since it runs from the old image and
> > + * before BSS is usable:
> > + * - It must not touch BSS. On arm64 .bss overlays .rela.dyn
> > + * - It must not rely on anything that needs relocating in the destination.
> > + *   Symbol addresses are generated PC-relative (adrp/add, -fno-pic), so they
> > + *   resolve to the runtime location of the currently executing image, which
> > + *   is already correct, either because we run at CONFIG_TEXT_BASE or because
> > + *   pie_fixup has fixed up the running image in place.
> > + * - It must not be instrumented.
> > + */
> > +void notrace relocate_code(ulong dest)
> > +{
> > +     u64 src = (u64)__image_copy_start;
> > +     u64 size = (u64)__image_copy_end - src;
> > +     const Elf64_Rela *rela = (const Elf64_Rela *)__rel_dyn_start;
> > +     const Elf64_Rela *rela_end = (const Elf64_Rela *)__rel_dyn_end;
> > +     u64 sctlr;
> > +     u64 offset;
> > +
> > +     if (src == dest)
> > +             return;
> > +     memcpy((void *)dest, (void *)src, size);
> > +     /*
> > +      * r_offset and r_addend are link-time values, so the offset to apply
> > +      * is link-to-copy
> > +      */
> > +     offset = dest - CONFIG_TEXT_BASE;
> > +
> > +     /*
> > +      * We have a makefile check that aborts if reloc entries are not
> > +      * R_AARCH64_RELATIVE.
> > +      */
> > +     for (; rela < rela_end; rela++) {
> > +             if (ELF64_R_TYPE(rela->r_info) != R_AARCH64_RELATIVE)
> > +                     continue;
> > +             *(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
> > +     }
>
> If you've got a build-time check that all reloc entries are RELATIVE,
> why are you checking again at runtime?

Defensive programming I guess, I can remove it, but I'd rather keep it
in case the Makefile checks ever go away.

>
> > +
> > +     sctlr = get_sctlr();
> > +     if (sctlr & CR_C) {
> > +             __asm_flush_dcache_range(dest, dest + size);
> > +             __asm_flush_l3_dcache();
> > +     } else {
> > +             /* Non-cacheable stores need to complete before we fetch new code */
> > +             asm volatile("dsb sy" : : : "memory");
> > +     }
> > +
> > +     if (sctlr & CR_I)
> > +             asm volatile("ic iallu\n\tdsb nsh\n\tisb" : : : "memory");
>
> isb here is redundant with the one below.

Ah fair enough. I need it whether CR_I is 0 or 1 right? So I can just
remove it from the if()

>
> > +
> > +     /* Always discard anything already fetched/prefetched */
> > +     asm volatile("isb" : : : "memory");
> > +}
>
>
> r~

Thanks
/Ilias
