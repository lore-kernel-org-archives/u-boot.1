Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5D606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RRkFmZMm;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ShhFhAxZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB66F40729;
	Fri, 30 Oct 2026 12:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJw7ChKj7k9e; Fri, 30 Oct 2026 12:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B882C40713
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364564;
	b=IiOZwGYFjtl/vJfOwrnIxX8VtKN6GiTOBGazZdBxlB/R7Jg9hGaPNhwPGAg5KlmpRWoB
	 kFxj7/4rSOtCj8icEABHnc3dPA6X6OLSeN1EY5PL2G0b4QA54IEwEx6Azwk8csdqoSboW
	 HoFS8BtULI+Hfq8aUVfZFQAfVXxIE5CzQttmzoFodJNeUyCGMx2/6rje9Z5qNauVp2vdn
	 XqFBlHEuJPZpXVfZEjA/7BG05Is2EoiW1Lbj3+Ho9FxAlF7d44wWpozIJ1IEHXbnief/x
	 5ipDTuL/7JxJEPSZrqguZL52yvszUAN+DGhQbzYqjeWzC3YGgj5uRA2GhaBm828hgeg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793364564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N/l5WB3/YbT+ZUSUndiZdwZsF1z4JUK20EWGC7GfXKE=;
	b=YG+wQ038N9tvKSslX+coFYWJIfw97goZYPOY/4rIsI3yIjyJt7aqu9kmOzSKYIjV1YZ8
	 iCJ8nQlGCoGol+Zc5iZTLiHSoSPOHPFasEyxEA9XdanGe5oN/x0R3+ekSR9I/isGOVYTi
	 fMYo4p/bB5ijSSUd2E/M9Px37bvFInb4LJsApQ5ORVMDpbvPDGibeY1kJKglHJmXHYRqh
	 90y7yVO1hT2mfqb+UMdLKs6dQXw5AfE/i+ibD7JNFQAu2B2wWuXR7c3DEdLroYadTf4bw
	 RgCeZrn5sqlYiElaZJTZ6Kiqz/XrXvhxEb5Mh4nBO3GEV4RKVVrMotyCxwMIcBRMmUQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793364564;
	bh=N/l5WB3/YbT+ZUSUndiZdwZsF1z4JUK20EWGC7GfXKE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRkFmZMm6G/KwGG86nj25nnT3sKnNAvxd4ALIILavT0vdm7Muybdyhg80N/IleDF9
	 B7FYMRnWHf/y5Pca/9kz5sNsjHYmht8+rYOWIfUNJHj4bkcPRv8C+3muvlTVrL7KYr
	 cC2TxpvF8rAuqWr0Low6DvbnN5kjFwZv03vpjXzj4KHGj/o1OfMA/bbGa/PudXcrro
	 zoiM3d0FmQYLfhhjp8oBWc9ehE6T86w3soS+iYbBywv9PpRAze+SG8+U//pi4lcGjp
	 GsIjFM0NVRB3BRcjRlRWL27v6Mpf8OUQ1LoO9ogjYqqSNfGSUP8nBJ6ApW45xvmn/H
	 XeIiLhouR4dew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B882C40713;
	Fri, 30 Oct 2026 12:49:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AFC87529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95940607D6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PwS7fn2phz7r for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:49:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7482260633
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364562;
 b=ffCKPdmlJCF2qlpxbehtYl5SzlP4ZLfhDJD1WNWbg7j9U6xeaxLsc+aHDiAknfm0dMBQ
 EXhsnc3RUb1iXTAUocpOk3ygt/wNXr32H82msmwy69Fk9E/aOqVCr+jrw46QKByD/pV+j
 Bb06catMpNzmZVlS2jdB2HBKNDtlXknAPPgpxt/POlOQ46ee2X+yTEPy2DYvKZezvFv5v
 OeCTJ/RyfdhMlg7T6hkCdT5Cx+8PyPCrEDzZ6esXtK1mW3/uyIryqLNZyry0gp9ECbai8
 wPHAXlQm9QdSUo0GU+Pbwh77NHwm/lgXx/FBaKcMzssas+GYCWeBEcowgckgfqbcNzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793364562;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=N/l5WB3/YbT+ZUSUndiZdwZsF1z4JUK20EWGC7GfXKE=;
 b=VYec0C+uFbkxQaNAbSbV7WJg7zmRNb44VyTLcUfm1Lj/0TnuaDP120lTIYtIzqr7HP5n
 QvZUBoUl4lVt03DJNmy0Si2Kp2+JL0NLoN7HOez3pA5JpvrfqLEPpLeUFR+RewELS/mep
 +KCF5BZzXVGH576l22sn6sPLQd54m3YyHWnt07YEeEoSoAtsG02+/GubuuYMAh8VRDagZ
 Pqu4gRcpL3HM5qFJZrGmCiyqmP2XuvNgOQ0AFLl6hwb93WqiBdfjvAXbT6axOoWYL7e2j
 DO3yfiF6xBZueMP16hg2XPx1gI5RCE/wKlvTVnKqi3k6BRzeVnURuyUsPfYE2gRN+WQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ShhFhAxZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ShhFhAxZ
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7482260633
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:49:21 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-8470d7d430fso273240a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793364561; cv=none;
 d=google.com; s=arc-20260327;
 b=MK7EB36+mMHfYyZ2RjeN8zhrIn2thRWZcwGiMd9Ld7KLqR6fhDn9hSEzrv/ra5Calw
 wWwAtZCNonxkiFbUEDCGI2OBjpuEsrCHXteoU1513dTLMNTF6VgNTXcYH8WKSjXk6sYm
 3kF5aUcqWtJcN1nKnEhKxtkV1KXdQZxsFSwcfoit0uufc+zHNfYnWcJMKAtkFw6PTV61
 vAXu0Ful4q7K9a3dalGkOlNCpWFsPYy5AbX3K8sY3+2DQleUSAPDYT0x/fra1OY8PLfj
 rz7wIm6N/tRtEIacimeDXhLeQhCOKf5HST5Xr67zezaG1+mI9++Pu044yq5kN56vkLa/
 K0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=N/l5WB3/YbT+ZUSUndiZdwZsF1z4JUK20EWGC7GfXKE=;
 fh=SncXzb18icff1e3rfd4bLVJMHaL03DbFb6lullBLmxA=;
 b=TNt4RhNdKMhhc0mP2omm7B3tXgQzSRzISjZvFO8G7uMMcmHvzqB/gBgy1PgmnLIMtc
 Whrn/CUH2pWHutfcfHWGgzX056jKk0daWNBJCrTtn5LkEqnN77SBB2S56/XgikPROJae
 CfWvC1TzKPM8+JcSmRIaQrWtsQlIX+ZKJaLFs1n+Ksy+sCSsFougu/M9vbrjmgMzU49x
 0YZuuUhFOWxpUIrCYFXkoPMdL/4y4dEZzPptRLYYsBJc8VKaKo5QvhjGDv5CuKq1b+Qu
 +Ov5Nx+Peq4aKb2/8NAfUa9TCbAmNyisMUsMd+/G3Rs+C8Ijz6A5/5VeRw6+k6G6Mxsk
 R7UA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793364561; x=1793969361;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N/l5WB3/YbT+ZUSUndiZdwZsF1z4JUK20EWGC7GfXKE=;
 b=ShhFhAxZqlW4aA0X653kAtYQ/aV7o5nOyHYWnCaYGNgmMPfxj6XlZdPaPLaUW/jqY1
 JRkx53bc+/y7ie6zpszr5yjiyTeqojMUaAfGsfHOn2hyQd6NnT0cpJusMh5bI6HaNbvS
 Bas7m3GftVi/4gEmimorHnhMwZaagzCiaMzYuRCSXB4+GyBNsfM//npznfpZyWnR0uR7
 cWXawJD6rpbIElW32xX1/fnt3hOwMMZ+F64Oioq+8XcCuOHG60AhOKfF++ITDZsC7k1d
 ovNtQOXxv9PRgJxY7VulDamiaW0mge+Hv4jx+FXbQHtzUCdsTDWY6MHFtanBz+63AYlo
 682w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364561; x=1793969361;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N/l5WB3/YbT+ZUSUndiZdwZsF1z4JUK20EWGC7GfXKE=;
 b=YFvS34/I9EfAXTK9VubzVxBPbnVv2FEVX9wJtHA6E4mzWdYpiYiYLm3L4gpdzfJznX
 gmpfMOPvV+0TDdxF2NZdBzksNNEl51ClTwse6DewsY5kjnAg/ccd4KAdPPlIB5wHwBt/
 5uQ9lg8ltBk6PPDh8qdXfmRu0/VahRITUUhFuiTGhsYDheEihh+bcSBPeIzF5myPdL3A
 U0JZk25jOKnPmwWE/I4/zhZf1uXTaA4sTxncI8nLgRf2lj5RfLBdy64IquTqHj3+lH6G
 CqaWymwh9HrXTT3MxcjPrR+KbY9seEY/vhAFAlRhtJVkV/dMNZW3p7vBozn/WlLDb2Sj
 iIXw==
X-Forwarded-Encrypted: i=1;
 AKwUvByS0HJ+4zVQ+kY5RF4hE+n/kBcwmWgcvbGux+UeO4sg3CBIrdBRAE3oGWXfaSYe+qtHDLz5f1k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYILmczhc6CNvZb7JYkJHdVQsS+Mjb0i1SfnvMh2hQqAM9AjfOeF
 9WhSpM0WE6heNXoatOe1Q7I4kxg1TG4G0tLnaLJUMOQGoLvIWhaq+sUKQk+FDwOAylxCbGo6Gv9
 LJelocCNE06YXyPXFsusvdiLETHYEEgU=
X-Gm-Gg: AYBFou3099tqFwdG025rsH0wwJronOB6C/fifcVBxd193fznFZ1d4qoRInVUIYuNbyV
 yAfINH5dEOfQ2h4fLkEe+zpAXf/GBFKO833IYjAQdx9JNw66gkjfr8cXP+PS9yF1YFwSGBgvtko
 PLBv0GvTkt/bZD1S0bhXS2L8n8YVnbpnAIWVGLGmkGK2/6uJ7112TwfNI3/odGjJJZrneO2ZhOo
 3ye92OzcPsg/et/cTpsIv4rS7UZ6FB2elt5IDM3nXsbcUxeryo1GL/kosQORMBtiMIUzOHXmoDD
 P9G5U4M7OavBu3QpoZMJ6ZD9ppzbR3dxf69WBlkEUtOl61HTZko978kDRM56G2BJE7S+brea4rB
 IXRM5vw7dMdfkWOKpVjK+Oe//1OPmy4RqzhlJLNw=
X-Received: by 2002:a05:6808:1a0d:b0:503:aaf8:ef12 with SMTP id
 5614622812f47-5640ddc34e8mr1326620b6e.34.1793364560862; Fri, 30 Oct 2026
 05:49:20 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 05:49:19 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 05:49:19 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <35841cbc-a276-48ab-b5dd-1ee44340eb62@gmx.de>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <fd7c9742-f369-4877-9a14-665b6b8afc2b@gmail.com>
 <35841cbc-a276-48ab-b5dd-1ee44340eb62@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 05:49:19 -0700
X-Gm-Features: AclHuK8Un3y0y6CtHWLSu77z_fmX1as3gKU2_nFxfZf9R6TxYE32S-a5-g8nuLU
Message-ID: <CAJnxHsjqorstpMkXmmhmoutPUohsxBss_-fqw7M4W2GcQbjD4Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] efi_loader: check the PE image ranges in
 efi_image_parse()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On 10/30/26 13:14, Heinrich Schuchardt wrote:
> The PECOFF specification does not require any table. Six are needed if
> you have a .reloc section which some non-compliant software assumes.
> Aren't you describing a bug in barebox?

No, that sentence is wrong, sorry. barebox's optional header struct
does not include the data directories, so its size check accepts fewer
than 16 as well. I'll drop the sentence in v2.

> read_header() in
> https://github.com/rhboot/shim/blob/e794a714.../pe-relocate.c#L376
> has rather strict tests for PE files. It might be worthwhile to compare
> their checks with ours.

I went through it. shim has one check the series lacks, and EDK2's
PeCoffLoaderGetPeHeader() has it too: NumberOfRvaAndSizes must be at
most 16, and SizeOfOptionalHeader must hold exactly that many entries.
v2 checks that instead of only checking that the certificate table
entry fits. The rest is covered by the series, is loader policy
(stripped relocations, NX), concerns SizeOfImage, which U-Boot doesn't
use, or, like requiring e_lfanew to point past the DOS header, rejects
odd images that do no harm here.

> FileAlignment and SectionAlignment should be checked once before the
> loop calling this function instead of checking the same value multiple
> times.

OK. efi_image_parse() only uses FileAlignment. SectionAlignment is only
used in efi_load_pe(), where efi_alloc_aligned_pages() already refuses
one that is not a power of two.

> We are already checking for overflows in pe_range_ok(). Why use
> __builtin_add_overflow()?

pe_range_ok() checks SizeOfRawData before it is rounded up, and the
rounding could still wrap where size_t is 32 bits.

> This whole function can be replaced by using the ALIGN() macro.

Yes. v2 drops pe_align_size() and rounds up with ALIGN() on a u64,
which can't wrap.

> Please, avoid this increment by starting at 4.

Will do.

> The PECOFF specification defines a default of 512 for the FileAlignment.
> That is the value you should use if FileAlignment == 0.

Will do, with a test.

> Here you are closing a memory leak. But this issue is not described in
> the commit message.

There was no leak before: the old code had no error exit while sorted
was allocated. The free is needed for the error exits this patch adds
to the section loop. I'll say so in the commit message.

Thanks,
Ana
