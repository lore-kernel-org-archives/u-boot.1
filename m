Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AB606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RXRfGdoT;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kVjXYEaD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF28F60A7C;
	Sat, 24 Oct 2026 06:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEusz-TXZpxX; Sat, 24 Oct 2026 06:29:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE2AF60A41
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823339;
	b=A5aFMwlLBY+yfS8WFxCfkPEegvtBK7KerMqhcBrwVnQEVoJX5CmK3nkqz/bkFDwZcmdZ
	 Qm3uM1r1uv2PImD/rt6zil+aoZMxmjICuWKG7nuoEcDHzkqyjx+p4c/0pA0U32N2nwsED
	 PwH0Ro17jwfk4BK1bRWxFOwzcpW3rY69wwBRIT31iXPxsvQXIb5jbKt3eid2X67LMP9cG
	 y0mocGnIi4XJ2x2zxlA7mJaj1Ld20foVHczxDqasZa2R5z0J1nucPMsp176cafGq2mgeY
	 VP9WzL/gBZnhWOaGe4AHOHg3l6tylAiuz44FKcbk6DNbJM/J3L/LPrj4n9Y7nQrAnag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/gLUHUmn5bwnChqqQhWVxZHD9emSbv9YZADIC1x+9Ro=;
	b=A5fKwDHRepzvSbpRn1Ji/MWtpxj1Ke/pq5F+p0Hr/4v96WOVhcegkr0ZE6Lr0hHAnuHP
	 bNl7aRCXZ6JujsQCAKr2kEc8VXWbpPT/HnCJiphZNWLYAPkPrDJ5QaCy/Nm8dc2q4wuNy
	 KzFZNrOVUvmRBmEh2KiCZwSA9PPy8trqfjZsL7QDMoxXfH9n/1mE8rf1/o8YclXKNuQkv
	 b9180IPzdnfD7TlqPjv70luVGA8Tcwh0ONFfqMpChCXCvoaIgng/WYny858dvJRjnldSm
	 KlnZ8GQqLs3UPSu/wO9HDLmOQeYdiHk4Sjh35NuXYDPHMkTx772aSaRGyVN55/FdiAg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823339;
	bh=/gLUHUmn5bwnChqqQhWVxZHD9emSbv9YZADIC1x+9Ro=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RXRfGdoT4+oGTrYhcYocrB3lwy2DDgK28fcSuZgDILbaoZ6PWfWhPfvNHlOwZF6xG
	 Pa8sL/4OX+y126+zok6c2FCj9DoilY0QaDJ3G+wG4aZ9QpOw3f5i/x0ZrqM7kZ8Rfw
	 7MXl8rsSX7Q3SZ3seKoLSC87aFA61fQJ52sBgrcmG0ugCFg2zgYmppRmjFZwrYbC7S
	 RmKxtcgLHrRHPjSdWhbaGTcCMeE2WLAm+3hG8o5278iqV7SiUG3ep00YCc+ADW3LTU
	 ThNGmo0kUiZ+RgXlz9gw0tfj+uove4+Q+tQtoalxZA7kFK9RRGV2rXpUYC6VCrwXIn
	 GTEft5/emuC1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE2AF60A41;
	Sat, 24 Oct 2026 06:28:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDA483C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF26440758
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:28:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r5B0H4PQrP5s for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:28:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26154406D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823338;
 b=cJAxNmReL3hnu81Dk3ztSpOX1w3dfmxJUw8D0+ejhmS7gEVFZOrE3Yfx0Jz3DvXlXjcE
 muPVXNiNdczhMlB86y0WibLjouZ3/3ZiJPbReGon1cZUaICfA0EUdiJef4WEP7GX5aT0s
 jvVYL8mRH1blxG2lE19chwnon5e15IxD2+LSUD5ZRHLSMdZMNz2om+6Y7BDM4s5hcAkah
 7FZ+S7/Qq1BFgWbXcyzzrcgfufW1Hj7X5c6O0xZEAvvMMgGRUnZt0fhPrCgWosppvRPUY
 S0XwD7X02egOW3AJHRnyEAO+/qLEi0rYxF7ZVhrfRdpt/hvy+KAQhXuy97drPZsWhMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823338;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=/gLUHUmn5bwnChqqQhWVxZHD9emSbv9YZADIC1x+9Ro=;
 b=B8GZ2GwINjUPMe5/P99CtmFSZfRUVOodocF4bwVMeXQikkra4cySNT+zmG5ERizM456D
 NtKRdva7MndcPNyIJR5VxP721vTZc+eM+ZpzUCXTzMILuSR1iatfRNEH9s9cp1oSe4ZHV
 J1v9M9BZgXE2/Z5oQNRSxxvK5HoHQDmtKP8S1lJIpuR9ICXpFWL2R21JHEKEotfvf2WfC
 D5jw5BRNXv6fmYhTKejCuOCPC9sjMephmeiNWvb4Wk3s3FXiEO50GVJvTVMqyrP/uNQw5
 2zYTc0eiY/iGRaHmbODfir9hItGRwaYuoAxInCATd7hI2u+9eoAc/dHOHehcO12RFlg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kVjXYEaD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1035"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kVjXYEaD
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26154406D0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:28:57 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ac677668a9so1878542a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823337; cv=none;
 d=google.com; s=arc-20260327;
 b=Mr89B2Oe1MPV0PwU4QVGmY0QJ/pAEhrcVQcjP1BZZseUF0aRq/2lIAAyp9RGPv45zr
 qi6WQs47Q7lsRT0RUI6zBIYsWqujQ9HnA9D/3DJE6GZzubIx0C00bQjwxv5JcSvmKfBU
 NELKcjmafa7u7m8eeIsxTwSz2ck3n4vYa9npbcrkoyQA5KLUJ3PuCl6TvaVW8CE7DMhJ
 O1YoYHaGgBv0IDDjAx0Gszi43PKs1uvnPVaUPOLAifRtUr1pZuX3TBaBQyukqFAUwEy3
 wSWpJT38xTBx41KuAA5SVpBuNhgfWTt315GAxNHaxdiKTHt2cY0meVPWDeKerVJ/YLj+
 lfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=/gLUHUmn5bwnChqqQhWVxZHD9emSbv9YZADIC1x+9Ro=;
 fh=sqFYa5HhsXMHk6lK1uJ95N3qZeoUfXxEDP8vyXdmNZo=;
 b=MH6wo95F174wf6vxcqUD7BjPN0qOKa2CjPKseg8XgXmDLDMDTo+VTrBnKeaYq46EAX
 66ca7hKuGq/wdkNzCtLcFTYkthdQENPC+nFb7Xl8EYoB/mj8Rs0rqp3FsvyqT5cO1er+
 1v5IjXU5mEnGYNqu8tVSp2JyGhrrlEpLUf298QDFWdvbxM7sR7CsxbVFa3CBhhrDQ9vM
 9HeWjbHZRGbMAaXG6jhYk4L6gjNj7MUfoe9Rc2XCCwnUDaP8QRiQIen3t+4DNvNuYv2u
 75yuq3j7f0TICzDza0g1VQT5iIKrrRXUhys/7ti7CvY5lEjXOSM2ynsn8x+0c3uMgUkG
 ePuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823337; x=1793428137;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/gLUHUmn5bwnChqqQhWVxZHD9emSbv9YZADIC1x+9Ro=;
 b=kVjXYEaDabkt7rj1IGiBEovXyptx2gbh8h+nalYw4UbZ+c7JujVIx4SA9i8ml48evK
 YtcCLGemNVLJNfjSEyYoSw3tsV7tk0l4TQuTusEn1iXz+ZLEHn1yTMvKKR4eXsr6Qnfm
 gdyzWpiAfTgz3Q05uRSNP0H7OjFfo++n2VgLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823337; x=1793428137;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/gLUHUmn5bwnChqqQhWVxZHD9emSbv9YZADIC1x+9Ro=;
 b=m3kzku5uTOZZK6DhTlHwRUcOCC4ro01kNK5X+jU+epb+jWKLQDOx4f8ucHjSu6oQ+Y
 yNNmOiKBxAf4ryrkTdJDxv4qWHvJVP5HxJCkjzqO+N4Ai+Me7NzyHA0E1zSeE/ZZX1AR
 IQp2qPc6BahPqyBIxILY83IIvY8o+ANWm7E7RuXQM3aLp8x16D9lfTgyrb+m/3tcENAB
 yOoS9VSAlWja+MQs61YLnozZv8XozOrRezQDeo9LxG9m2yXAOaFXPZjALdYpql/dv9IL
 QnujG64T+uMRAI3cfWL6qyhJ4FMiiEbjdilTkmoZ3OhdAoWpwvG/7Rm+/PIaMTJzdld1
 F5vA==
X-Gm-Message-State: AFq9FYIRfEUlOwgqJnG+tQF5ydIouKKAgI0sgryt2ATMYlQdjhK3148n
 tPj8dO5zzPK6+JIXElIv4pn5/k9YxLF1NPcoyBuJq2xKqn4LK6Wdsh77kce+7bCsMJjoFC0cx3c
 m533lZF2OvU3qJDDa3cUKh0uIxDDEBCBwyH4UFzMuKl09uHywMGXiLg==
X-Gm-Gg: AYBFou07kDhHA/NVHSLj2JuvqwMUtAX6BHJyUmlzygVNm0W3LESFPOnEUX5Q5+3om29
 pRrVT8VEi5EYwE7c6rOOvuSz0M6u43FF6mHSAP26qdwnudetgse6nrkMoh39+RvKlqLFshIXBQO
 AmR0YCdqCOAsBnlBxgWda4SxGrSTcCxam5AC7jWYCJR8BpHeumomZHDJ7fKJAla7oNxwyMg9CBo
 3a10SdQTcd89Z/Op1T45w7qb1U2xop4Oje400iEiy38eLkIGcjXHQBoaL9QE+bb1KK/tt1eFE1M
 ERr8FP64vS10SeDTcejTC8QE0UNfulqS5rCg1wbRS8Ekguz5M4Ye4yDG72SrjRa+Vsvk6HkSZh5
 BlcosZDZEgViSjAMyY76Mf9u3v+Fr5xNze4k=
X-Received: by 2002:a17:90b:3a48:b0:3ad:6ec8:35cf with SMTP id
 98e67ed59e1d1-3adeae70722mr1107622a91.51.1792823337314; Fri, 23 Oct 2026
 23:28:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:28:54 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:28:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2646c589-e23d-460b-92d6-cab299fc4f56@gmail.com>
References: <2646c589-e23d-460b-92d6-cab299fc4f56@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:28:54 -0700
X-Gm-Features: AclHuK9B93Hx5zov7-4IfBJX18t3nU5g4FTiESF96T8Q9PWpSYAMt6nIU-utbZE
Message-ID: <CAFLszTiZyD9ydcsk0S4rLnPCy4Gp=cbF64T7fSmrp0Y9bpaFJQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] image-fit-sig: bind required image keys and honour
 required-mode
To: anon87111@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 0xiviel@gmail.com, me@ziyao.cc
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi anon87111,

On 2026-10-22T18:38:39, anon87111 <anon87111@gmail.com> wrote:

> Patch 1 binds the key. Patch 2 adds required-mode on the image gate so the
> two gates behave the same way, defaulting to "all".

Patch 1 changes behaviour for any board with more than one key marked
required = 'image'. Today those boards boot with a signature from just
one of the keys, and after this series they will not. That is the
right fix, but please can you say so in the cover letter and in
signature.rst, and tell people to use required-mode 'any' if they want
to keep the old behaviour. That also gives patch 2 a clear reason to
be in the series.

We should consider people migrating existing infrastructure and give
specific instructions there.

> Patch 3 adds the fixture and the regression test.

Patch 1 has a Fixes tag, so it may be picked up on its own. Its
regression test, though, is in the same commit as the required-mode
checks, which depend on patch 2. Please can you split it so the 'all'
case (two required keys, one signature, refused) goes in with patch 1
or straight after it, and the 'any'/'all' toggling goes with patch 2?
Then each fix carries its own test and the series can be bisected
cleanly.

Regards,
Simon
