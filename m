Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F055CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9F8B405DE;
	Mon, 12 Oct 2026 14:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gscFodn2inYE; Mon, 12 Oct 2026 14:03:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4AE5340505
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813815;
	b=ZikT4fJzMH7HlbX9JolE/AZzS+LRBa7TCRIYSorcdbeWz2fVwDHfEasYsSxG9bUnCrcm
	 2OE4qdx6Fu3Cxzb692i64c3J8+s4yMz5vLTGD0DjYukbhAQm4GyXO7cMrDUkA8kCY3IkX
	 w8Qxikj/4cARYW9rGQWBu0U/4DVioPLQo4WTMVXBzk5ChQu5foD/mZJ6CwmG3iUOcm2EJ
	 fvrOg/PIImYLzwLWtiRkzKxCPM3afxUHl9jnpUEXJNO/YkLqLAyiefIiWpMA+9HIbyXS0
	 6t/0b69+cyx0nRVh68CqRdp6jKWWLHfU4AHQm8eRVNBzh4bNWcyjjsyxmfNEdChOoJQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2SbTHKqMJNhAoH/pr+9QcKAuodXO34IgF52ThVPQ4WE=;
	b=WUOoY7i8k3yrg5UasKYEAOgZ4xVr2n4ghg0cHQkCRAZzZOp2SOd1x5ClLmJsNOFE9RwL
	 CxvxsyQKBv9n4GmXkgLA2l4DE3ueQ/yTUgZu7lpz96wJP8IzUZTCK4YVj+9DgrmKDXl0k
	 BGCPocdCjNjt3LhPbh7VXCdwTK+NfemFhw16DALDIjCnGgv7CmDKGWtR7kbHGXI3E5NOe
	 bjrY8Qta3mixEO25FdLfUQY/YVoNOIEuL1OKQ5AtXs4FpXZ2vNI4LBYAfTsffNW1stgtt
	 XboZ4Us18MdVFyhE+RqxkXmrOLfW9lBrRezfn+M0v7A4bg1HQWrOSsTJJobF3jCittA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813815;
	bh=2SbTHKqMJNhAoH/pr+9QcKAuodXO34IgF52ThVPQ4WE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RIsVKEcMYz7nn0VcLVjfsCr8iddTbCIgRDkQQZwjCIEcGMhvGtIFwAi0sQLBYgRba
	 4cIKmXzejZObSm4clR4HD5+u7nQEAms6pqfWkQRh1uawC8yotUQNC52ckT0xrKnCbQ
	 /LldupdcuYZLRzWVijZy5MP5QXni+XtRdSQPNznGQTl7WWss+EDXAVBZQ2Cg0yWS4B
	 aNHA+OEnH/6cl0luAk+ZX2Fhzv1XKD1xJ8RxqdLM6mSQjC9D/vf6GTzjiED62AjVvE
	 4WMPkDbwxK7BrQeteHibmEHbJV5YHTcTqRg5Cal/c6z7NwWJUPqRpW2yHj+l2F32fD
	 kFlkz79NkniLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AE5340505;
	Mon, 12 Oct 2026 14:03:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A6B592E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D9AE60600
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEdG9J0_pI_4 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:03:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 91CD5605D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813813;
 b=h4rsdwUHv+PnN9AdQkqJBS99n9DtgQKhX+29AwtbDLeaWYLjDtiWEaSoxcEWPdLFtZ2H
 mrsTjLdq07qLRe08PbAot+yl5lftASVO8DuRSDFpAPRV/fIB2k91jFkZ/jqrha1Vs/FDn
 m/AjS9JlE8UMFlfmqbPBSCSlrK4mXlvn4FRmneSHxvqxlXx7tT7NR0f+mgWK8hWwWzRkP
 LMyzzW7gsPU+VzAnESHkpq1noeCHU1vKxaZhl0g1/0NErbREsLEHeLQvG5hqYKUoX1whp
 t4JJ+r6qoqcqT8k9tyBis/e1+d6lsErOWwBnrulXTZBr2B4/EZpdvksYQ09z3EuBC/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813813;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2SbTHKqMJNhAoH/pr+9QcKAuodXO34IgF52ThVPQ4WE=;
 b=U/JjUg28Nr8IXOHTbDp1wDjCesHzFKZFhXHvNP4x8sgoNFUHp+lGrmrikhyG6Nx19KGt
 un2KmEYIUtKzfG7aLbmdokDgweP2UTZfoFRZ4mt3BPI8Cex55J5W8+garWWdr2KoSxfFE
 qcgpUaYOVaDJrlbGJ2iujCyqK0JuTIOSBvw6rMb/A2dhcbd5USkFFbl0+F4hVIPbFY6yK
 SvQbH4n0m6nZmTy6oxrWOd/YNe21zfr2qJpbuG0WHkvqlEG1CXsy/urrZPvN32rmX7ffd
 Q/c6Wm4D1QOxJpPA1I75SkfOggpaRNo8PV7iZGO1wj0eDt/34PfyspAKjhJ68l2uCHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X92Ny+ml; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X92Ny+ml
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91CD5605D1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:03:31 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6af9a90e4bbso1971033a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813810; cv=none;
 d=google.com; s=arc-20260327;
 b=V5LGzbYyaLh+tHSClH9ZT1mgULNm/MxVkOH4k8gpiKcOGtLV5q3VsVV/MeiFAjf3Zi
 QklpKgj/psVdqyBpYRKZJowTC7bhJ4yd1DUp1YG4F2vqehcOPLPC1cMszxFrAsVDrA6p
 CsauHYAxPbE98xUx8wusxOW3xWzs4v4+n+Cs+o4zgQiB1XBQYnnGaf8wuCxzIdiN2Ybg
 ofy5bzkg6A+7yDvYwjArvstRbJI979+Bo4/6BL856yTzD2h07DN2nmiV06aNZ1ph2jjj
 1tCE4HGOfSvA7CCG7aqJN5wF6HU+tTOjtfyxdJc++BjlH8v+lg1tWDGl4dxZAZN5+UwB
 dtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2SbTHKqMJNhAoH/pr+9QcKAuodXO34IgF52ThVPQ4WE=;
 fh=NieCVW6M1MUYnz9eRpPjF8pQsTNUCjYet2bF/SkPmyw=;
 b=HF0Ua+ILbWBJqVI26MWXReQs6b+8nMMnVK1weZ0GiT0xaeu6Hemkc6NtpbsSn4Gvw9
 8xGQJE7dCHar1S30x+wZnOsBWk/r6KKqW7EZ6ELMWizsUA194IvtbhaFkT9c+No/J3DX
 al45xcn3RI/ysZw1hH29evHE5szJ7fHiHRFDga7YTh2DpgFyQ28ggA8UgiwBLqRkb020
 KySDj/KmXEIa05mjcdEcR0MFlzlv0+gQlh7DzkhT5O5XiRpTkBAENveVCapVAlH7GvMa
 xm0JVdP6u0fjxCwg83eiwW06b+qkclWTE+NriNcZUoXiwQkCX0V2fuEmirXx/9bv1khG
 zT2Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813810; x=1792418610;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2SbTHKqMJNhAoH/pr+9QcKAuodXO34IgF52ThVPQ4WE=;
 b=X92Ny+mlKNBuyocwu1t8Mfw3xIelF4pz9x49ZqeRBiuHJGAAF9oxZrxfI3gLXtKZV6
 PYTabTenCcKv7c8CL2tXvc+2FW6bUOn4M0f23lIxDaQd+o2uypHZm5kSCH0pCmaBGMax
 vcy4KTQJf6JQ+pKUu3cVcPl8wpuikatLrvRzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813810; x=1792418610;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2SbTHKqMJNhAoH/pr+9QcKAuodXO34IgF52ThVPQ4WE=;
 b=I1i/NMw3J/2KBBnXfE5mX0rrIrREDAbBFsH4r4LWBThPn+wlxlEKVrf2k7FGSL7vtS
 2kJWg0TnWFySCWhBx3InaqgW6bG1qeSb3zj289sLhgPtFs0bc5MoOt3lcIb+9O3w3RRP
 F0JsKDAEnp0Eu6ATX0vGkSw9Bo/a6UsK3cTFKLoKJUD6nBHTKNDv1GP04MW1Ig958diZ
 EEWmINBPOVGlSLaGzM00D+PpL/0COYTDZShryTgC9YFrBBocl7hWSjZWiSezDNCTqqOU
 94bB2uOijQBxLngq2Sl3aiPGCQ6QzsTu6f/fCcKADIcGBOQndDWYzrW4c/igTAFJEeIy
 fAig==
X-Gm-Message-State: AFq9FYI/heMxrT8QB4no1qYLR2tFoQrFAgYituLYsV9YG4cWVUKynt5h
 HgGAW22HaWzKhHtA2TH86Vb/DW6Sn2XCKpY5fSSfOuFLxjmTfyv3LoeWdN5Pgz8y+JRr3oOQd4K
 xg8li2Nm8FEw1V+rTyi2Dl5sqhDai+PYKibNn8XeX
X-Gm-Gg: AYBFou32hz1Dmbwlf7Lw9I804zTCg5uIW+2YZHwSV8y2Prd5zv2uTcL6T3QHBpuXoAw
 zewniBMJ0jb1x3y5nzP40NjS9Tao4Tf+BsYR+3sRqF1QJFuYLUEWd29+b7YHMnhkc/tHNVNf2KF
 rGZJC6PyzENe4vKydQTGD4bplJs2EAFtK0vyf9qvFzD4hgfv5423WeiUwQxA6lASBJzSpsPSXoV
 RdOZ8IZBoKMS3E4MhfA7/9gK662+yBvqDIIqNxK4tloAZM6tp2UBfPvNziKx0wGdB+9/DOnw7TY
 yovzVATD0oaT/3mNiNnmPc07kX6EbkOms/xZllJvkzB+vPMaVdvAzv0=
X-Received: by 2002:a05:6402:4512:b0:6aa:ab3c:a81d with SMTP id
 4fb4d7f45d1cf-6b17c26e33amr8801028a12.33.1791813809587; Mon, 12 Oct 2026
 07:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261011070600.2788775-1-bin.meng@processmission.com>
In-Reply-To: <20261011070600.2788775-1-bin.meng@processmission.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:02:38 +0100
X-Gm-Features: AclHuK_wBRa9go5wvNhz7XKfofReZRB_R_rA0RsNNCjgooDF5g6LeFkjHIEN_Vs
Message-ID: <CAFLszTgzeH9rEahc0uceFsFwMv1XDGUcj+0mCGPxHhc53wswVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: cpu: Use native_cpuid() in cpuid_ext()
To: bin.meng@processmission.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-10-11T07:05:58, Bin Meng <bin.meng@processmission.com> wrote:
> x86: cpu: Use native_cpuid() in cpuid_ext()
>
> cpuid_ext() saves and restores EBX with 32-bit moves, which clear the
> upper half of RBX in long mode. The assembly does not declare RBX as
> an output, so the compiler cannot account for this change.
>
> Initialize the leaf and subleaf in cpuid_result and use native_cpuid(),
> which declares all four output registers and lets the compiler preserve
> RBX correctly. Keep the structure-returning interface for callers.
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> arch/x86/include/asm/cpu.h | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
