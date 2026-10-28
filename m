Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9952606A32E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p9Vh+tDJ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MxbqM6pf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB12480E13;
	Wed, 28 Oct 2026 11:24:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIgdvUyKntaf; Wed, 28 Oct 2026 11:24:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1236880E18
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186662;
	b=GWkqSEaSaQkAApHXzLlAN/50EHCfZ0mjQc5MjKTQnglBkLEZ/GN3THfdx2zMd3dy9PnK
	 QYvEa/TmQVLVCPQ08pOh02OQLmxMTMJtJbXg14eXChLM2rl8I6aM/zFZXJS0b5trkoRKb
	 bzbpEJZuswv8sT5aunmygojl05sov85o7SC5CPt+50FqpfbH1xA8mLnR+YwHiDm8IOcfi
	 K/InetEDnZmSDzpYixoWAkqShh8oNq6SMsHS35rf9XWKORdyg+2co3f/dsSJwETQpG0Qh
	 3dtmkSzOL9VsMO5+RYpj9p1R7o/F5vxE5nL4oxi7DSHXQp6ZJ5empuzsoApfzCuUOGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dPYvmPuzeQBKJrbkuWqijusWD0G5aF9aX6iGPoF9scE=;
	b=rrJt2GtbGXgSxcva2cAsbPOIVxN+NwNshehX1n2vDivE/eHrpvFlqeMgeBFuKYGwrcSm
	 F7/zgGENHySBi1AmPvZCaPf+QbnQVX/kyYb74Gq24C121lG/iAUMOJ1unLUqlKqpdVA5Z
	 qKOTetZF26BN1fBd8TPpOQ5p/4I/xe2S5v3+DCg0gTOfTCmiyYcQ4lI35P7K4X4ITvaIA
	 +Gr+LP3II0AhyTq4dpw3sXWC/slK7LQzO7v3YFFEiTjOgrv/mbaTwxgVXAWI6Clh5gy4U
	 iV89Wi6l528GUxQMTCSkn/XkrLp6AbkXktRDmsnXlEBToa5h44Qs78gFseqttZuTqhQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793186662;
	bh=dPYvmPuzeQBKJrbkuWqijusWD0G5aF9aX6iGPoF9scE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p9Vh+tDJvQF4yNuWXD0hzw62Q9DWcOTPxiJMdwn3UB4x6M8AZpXElPvbB02X4TMNV
	 +TMFHdcRtYUwR9ZoLC1JRwCHDbt/LTAft1K/eMyNP0JhlGkr3OSAyYRNJeMSXU5yCo
	 57SWJAN9EuMTzEOS/zlBIl/r2CY05UT/SSpei+KN75AtK0LbwRzuJyJi4nBAmtAyBI
	 0xPNW4cN3QrK7PiVPN/lVo60KKSFsqqwR9ZrMFswSDMwLuYNrRPbjR2XBadvnjAg0J
	 nI5VFeL7p5NP/IVKVmU0tZTVr30wXjov6H5HRMoyt9Z5ByEbcjhjFpVXWZ4CCEe/9H
	 HkpIjnRxUe8Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1236880E18;
	Wed, 28 Oct 2026 11:24:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1B872E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97F67605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:24:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PzURsxch1XNn for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:24:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F169605E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186660;
 b=SpSow1jtE6E4dfO5hsd9x1lOjXQzbBKLxmJJOvlk4T90eYrUMivZw0bXoMhIsfuvmpym
 SmO5LqN0mO3BOvrx2NSxtP73O5Gyow7h1MAmRqt6j6MFxZHNM5G+OI3C4Aom/5UKY2DOQ
 Y9bAToMK1r2fj6+46WDtPj4oCddkfJjTVCiVX2kydL1TUg/9OssIMQFOVlwUqYI+AT6Lq
 6eB8Gm+3sk05vnJk/grRIFhVCqiDHT04P+xLfOl6tE4+MpTmgftSG2UJBO37tXCZ4DaxV
 nxycgF5FSO8hdICgmPjcod5L2maU9xtH2GFzr+nx+A3/g2kh0D+a7PpfN22Czxb3PQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793186660;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=dPYvmPuzeQBKJrbkuWqijusWD0G5aF9aX6iGPoF9scE=;
 b=J9lUg3hJK1ggs/f87lNw+3/9s1i4d/SMcoV3EifoECrtqNVJue+6UQdV20mkaGtx4156
 zj7jNBXs+TbwtVWFsY45ChuG+hDd6RHpNGDXz0goMOYxWq7PiF5C7uea4afUjE0KfJoHP
 L76EMhQ+iRqaLtSYyD8UteBt1b0CT1IJxZia3j3K4oTt4qNn7JDkjom8gkXa5fhZuGV3c
 x8E2M4aTp2k6XlvGdB3LS4kiHzrA1hxlzQFY6AVglWCf6YxVtm8LLrfqfVsB6KpUur5/A
 5//fH/6WOZ1ZzUa1JeH3rcCyQEbtkJJ6VMw/IkDKYNNn3POK1w5s2HB7fN+ebnJgG6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MxbqM6pf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MxbqM6pf
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F169605E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:24:16 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so1479445a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793186655; cv=none;
 d=google.com; s=arc-20260327;
 b=Amg7oTA+xlwnbZRgX464quY+nG8HeN7iCNmHOGWpvOSI6brXkgSPIHr3FZcpCfTs7y
 Ra5bV1h5ZLymXa6k6jIMO52j+HjTUH7w91q1V3oS7mYgiuv31o8n0IE9xLJmUJLEkCKu
 3s/gFjMqYLW9op3CUhW7JunDIy6cvWo+SuGs2MXHqvanNWRvbKnxQ55kozCuInbmZEA4
 B4B7UVX57VuOLjpIXIgZzO/UskBDT7f78Ns6eJgmpUM05gcf0fqbTIRNYjCurNiujhlp
 tCHwJwfZKqy8jt150zvadow2fTIsGEY9r5I98ESQG2YnAHISIqUfBrz+ndjIwDLBkDjy
 DP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=dPYvmPuzeQBKJrbkuWqijusWD0G5aF9aX6iGPoF9scE=;
 fh=X5wSQ4lCdoyllis2Qzggr+d1KQjR/ZhY5+whBCxgLQ0=;
 b=TjwdyuS5mPMMQGiiE/ltuAWZrjkjzGpt4vduzvYmcieyEqNzlPkkuVsj3gyc4/5RFy
 SszHjZBoSNEUmpUor9rgGPJxypoTcwygw30cmJUmA+iwL1LOUsZUMexcjBxPwp7OYbOS
 8OeptFhuKyyBXB009yLRxsWEu9gSzkFxBzEuUF9hcUtKDgxFor/ckLfFyuFf2ZBLzqxT
 SVb89baA4MiRI3kr+sH7Jl1r1ZWvfI6O3ySgRPfk6SsxmdOcwHONkwYrxc0rUweOHbqk
 STh8t5ZdZHEVEyUbwjDBiMCHD+ggKerQiblRj0AovBQ37H/KKX36+JvZVy2dDtyPK0DU
 mNjg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793186655; x=1793791455;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dPYvmPuzeQBKJrbkuWqijusWD0G5aF9aX6iGPoF9scE=;
 b=MxbqM6pf4g73QCZ0CG8Tts91yTftWMKw/oE4RJ4Kmeir8jLVqCGP5Py2UCAdrz8lFd
 op1CHfh5NUELI1lTfQFoJ8kJ0Yry1Z/h5h90MrtoSwZEsXiwrDMh67fgc8MWi4xYSVgf
 /tIQoYg05Bd5/dsm0LNkg1JIjml/bLkW+fsI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186655; x=1793791455;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dPYvmPuzeQBKJrbkuWqijusWD0G5aF9aX6iGPoF9scE=;
 b=nXZTG6/NnwpSAPdkL0kEUCod0bCPdOqE/1n4/o7NZU1Xat7Y3/p2Dy0HFcmlHde45G
 SHXyGfV/8vecHVBBZSe0zsc+qR1rBvghFdff0Nc0ahOtLo0pmidBxHqyjRLfWKgKppRW
 pm377POHcaS5BsmGZ4pdcw87ouhuA5psmbAqu3bmVptVoqVMjj08CwRtA1LVbmsTGyKX
 ROljE5DqyLjy/XQjGRvVGRpObY4nnnG07z4sQE5wXa+HEOWym+Mn2kORxlWbJIsT53/k
 gyJlA8Eo2RnxgZbVwugGVchJNG1Zt4C7D2Mo0Vtkl10gPgtFlOs6UD5MCFmluVldE+l7
 0lFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlxhVczr6H5Y2CbVCsfef8Gpu0m23xlu776v2TolxLwJh0YoYWVkN9CaHqjA6AKzj5Ei0J0yY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLY0TYLWFGl2+/DxTwK4iwtsVMrH5HIe2dbzUcipXT90OWz7fGR
 /9l1JX5OA7T3qBPnmovOkwmloyr+wYzflFQh4oNekmmNFK+9aiimXoyyroRdhcur3leLxWOeWE0
 7FqxZ7MT0IFRYIkpOyb6NfmHmqyYetf6EFuvM2h4J
X-Gm-Gg: AYBFou1bPLMbT5vnkAKxieXJc/QzX/oEdS6vWFbfQCO/STyoymHE+G4ikEJoe2OEr0p
 TTs8IC5eVI0RQucyfJOy++YdJdoXdbaUnrRZT0BQglmQbd53rmUWJW9sgyMd375DF+A5NjWzz4a
 +1riU/EuauaTjR/jPpILEoKKZMvKt2e09lftcX9sTOLxg7roKJY/T3H5cGgyXaxDfNx+DPIDn9y
 +Wos6+jvI04GccWEfjGg+r8kpI2PLXkXrX4NmiHkMpE94YleOfctcZtBtS4D9MSS8uCa6CqZUNh
 Vihk6BEgM5TRxYd2BD9fSSmiPnkPzmFK7753Fy0wQYIBtg6gzwm6c65dy4LI+1NE0ZxUqJGeFKL
 o+rsJQ2FjRWbE2f8oq3eyBmfioeOMxJWnpUkW
X-Received: by 2002:aa7:cd49:0:b0:6b4:203:a183 with SMTP id
 4fb4d7f45d1cf-6b49cc10d44mr939142a12.36.1793186654923; Wed, 28 Oct 2026
 04:24:14 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 04:24:13 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:23:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1e33c183-0677-4432-973c-4d7d59a1b96b@arm.com>
References: <1e33c183-0677-4432-973c-4d7d59a1b96b@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 04:24:13 -0700
X-Gm-Features: AclHuK83nddaFxvYKMkTLibQUhfx69_M8DMLkMl-4ZRkiFPZ58XpmmaDW37tKGw
Message-ID: <CAFLszThd5C8p=bcgCGoFqK5_P07GPkuNfs3KRMRKbsFhiiDD0A@mail.gmail.com>
Subject: Re: [PATCH] x86: Handle unordered runtime relocations
To: jerome.forissier@arm.com
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>, James Hilliard <james.hilliard1@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jerome,

On 2026-10-27T16:02:16, Jerome Forissier <jerome.forissier@arm.com> wrote:
> x86: Handle unordered runtime relocations
>
> Runtime relocation entries are not guaranteed to be sorted by target
> address. The existing code skips every entry whose address is below the
> previous one, leaving it unrelocated.

Please can you say which toolchain or linker options give unsorted
entries, and what goes wrong when it happens? My understanding is that
GNU ld with combreloc (the default) sorts the RELATIVE relocations by
offset, so it would help to know where this was seen, e.g. lld, a
newer binutils or -z nocombreloc

>
> Check that each relocation target lies within the image instead. Apply
> the same correction to the 32-bit and 64-bit paths.
>
> Fixes: b50b1633c022 ("x86: Add support for 64-bit relocation")
> Fixes: 62f7970a5a06 ("x86: Add error checking to x86 relocation code")
> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
>
>  arch/x86/lib/relocate.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

> diff --git a/arch/x86/lib/relocate.c b/arch/x86/lib/relocate.c
> @@ -117,7 +115,7 @@ static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
>  		/* Check that the location of the relocation is in .text */
>  		if (offset_ptr_rom >= (Elf32_Addr *)(uintptr_t)text_base &&
> -		    offset_ptr_rom > last_offset) {
> +		    offset_ptr_rom < (Elf32_Addr *)(text_base + size)) {

One thing I'd like to check.. the ordering check came from commit
62f7970a, which says it is there to catch corrupted relocation data.
On x86 the .bss is an OVERLAY on __rel_dyn_start in both u-boot.lds
and u-boot-64.lds, so a stray BSS write before relocation overwrites
entries. The 'must increase' test was a cheap way to skip that
garbage. With this patch, a corrupted entry that lands inside the
image is applied. In the 32-bit case that means a '+=' on whatever is
there, as long as the value passes the target check.

I'm fine with the change, since the upper bound covers most of this,
but please can you mention it in the commit message, so it is clear
that the bounds check now does this job. The comment above
do_elf_reloc_fixups() points readers at that commit, so the two should
stay consistent.

Regards,
Simon
