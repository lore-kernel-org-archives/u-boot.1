Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26902606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qG/X/zAF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCw+l64r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3AE140D5F;
	Wed, 28 Oct 2026 18:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJDIbKTTQJFa; Wed, 28 Oct 2026 18:37:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9E644152C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212626;
	b=QEtUGMDXaFWSDGnCsD6Ae7C1Wp01Jnoflia5KuOGD4r91V8u/XKW6sKgyabY7KN6e4Mv
	 +PdHtFAVqj/QB4+LBq6b8BIjJgrWb/C4RY2fzlGZfOnzKEkpTr93LjtHzb1M0QYsPenGd
	 YwrXzaaMEo7TnAVT5O3j/hLfgqiUH9/NwgoObj0aDy8RuvQIvS2J6tAtlSUNMd3RVlTaG
	 FswZIxtxgOVEu5K+bsJ14ljdKvAuZWkgCqrJB00Q9BE3OyfNrF8377H88IUENY1kv6B6j
	 oq1FDFgJ+f/5ul2/fot3/6LAj19zGxwJLuSg9ms+35mlBdkSpFPQCPcfGEZNGh9klHQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793212626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lYvtLQxECR7zzA8enmmoEif4unPNziynYy8Am2AkWgE=;
	b=d01XIl7+7JHPGdQwtPOrmCGAvbTzJdgQe6/jszb1vT/xx4CbUBwavJcvY6Dn25O0Fk4z
	 d36PwYNjdvy+9lZakFUINpfaix3L4N4S6U03KkTKPk7ocRjFUYRfUFuHUn4t0LD4GwnMi
	 8oYARD8+FEFS/JjvpzMM9uG1kufHKBkHgM5yvuIgxQ+IyaLXzlXw8z10ipJWVn2+bx9Ad
	 tlDG1ekXQuTmx+dMW5MLBIFQHLmqUtvzCQxkr3DOeERmZ9ETZPbmRRL7Udq/XW5OzIHGZ
	 h3TzJ4NjGBqcszCNE2uFUN9noZreHhfeVUYa2qjH0tAT2cIPbztxouHA7eIXAaiYiNA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCw+l64r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793212626;
	bh=lYvtLQxECR7zzA8enmmoEif4unPNziynYy8Am2AkWgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qG/X/zAF30R6rD/uaOQXo7/bzFdO94VH6FEkb41pADI+brx2o1m4rxf8gbUmwYt6L
	 YY7WRnbAA3hDV7od6phfqvpqK84r9KzQD0u6P6rjCr2KbTOtBpD8nzNnXK0+XExTIB
	 4/dBcTGuhNaSRMAcgkP9UG176Iw8kGAAm3Ew2vjBNkT8FP5+n9nm6CMYrla6w+lH60
	 RApc4nyOqCLL86XL9VBNS24g1i5rNyxhc2TTjt1IS4wejD4xhP2ZbU13Is3rAL+1rG
	 vjgfGDv84kyvWrzKvJ3OKeWH3QReOqeuZNn8QyEMF8fqf1NIjvKTm60GhCGFBIY6z2
	 X5mRgl/brlkjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9E644152C;
	Wed, 28 Oct 2026 18:37:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DABC356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4155C4F3A5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:37:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RqbUw84q8Js for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:37:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9256B40DED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793212595;
 b=oKqMZVuJMxUzUcsdE7WLCrxdelQkcN0BH5jMLW7fe0Xhvtpm002WJ8qzx6MsWvvDO09p
 2C+WJJwAaj4EoS94HeUvxkMx0IFi5E4RB0kB/taWttOqqX18rscQpcqoTwl0UTQ6CSGNZ
 1P6ea8OvSRTd86EtEgOSo71GAKbK2bXOl4GqyHt8XAIpfxDhgbTGKaCMYlEAuMWLELc26
 hBx7VOgHbWrQSa8LLhUx52TKL4qXkNUduS5qbbyCVG7L0rNMBEjA+jj/JlMoqzaUYNq/1
 XgynaA3lYpF+JkcD+AshsNJoYtRCsPSQJHP+ivr9gSR3aFbQL0yHP4BRywEVg5+ZAZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793212595;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=lYvtLQxECR7zzA8enmmoEif4unPNziynYy8Am2AkWgE=;
 b=dTYrSKMRuNSbxbDPbC+c4G1NRXldD9MUqWzDU5ayP40HN6LAE0P7ZB3RTHhhFlwASONt
 KakUIe3ZD1OzZaBjy0TvcxngcstuyjD+GnTdaqTAPG1lRwuikblPlWAtcvHwmij5kOJjo
 B9zC2eeSgjE0quvo4EDQr1cSW96eQWrtN+Yep6+yADBv5hX5828LbDBBV4fZsg0IcW5Xj
 B3Kp/BD1C6mrRKgkDvb+i+GDzRZLU3XX8ZCNqefpwCdU6lIiBkxFEZtNb2jozz1bu2L9W
 b9YXAaSGAmWnH0gJYOE/adoXEUEXP3yvLTK80LVFft/6by7lG7HSKgyUHxvJaevStXw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WCw+l64r; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WCw+l64r
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9256B40DED
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:36:34 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so1422375d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793212594; cv=none;
 d=google.com; s=arc-20260327;
 b=caU7pOVzko+QaG9B7MRnxXkfpzl8rM1PixPXS1Zh8mBb5xg3ACqqZ7XGuuSYOlUDma
 QcxEBIjbCEliwe6QBPXcB3rj/9XZDPjPM98CEdX3Dq/jniQVloQdrkC9T1NDCULZtfex
 bt+3efQHXUpx8Eb4JvTvzJpTlzxM5PBVlsA+zeliu19WKqQEFov/NstFzWc3eVM8rPiE
 alj85IarT4OLiX8Jlvu0PmYWusCtiHw+7COsF+tKB8xiQOeRZJFM7ygm8L2D4URy1zOB
 zDJl0txn7s+Mu1+DWVV13GEP/oSKRBU1AB6g2y7jscsm8Ux6qu6IAwRkOvgBzzX/UHqu
 xxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lYvtLQxECR7zzA8enmmoEif4unPNziynYy8Am2AkWgE=;
 fh=wUTxbXCZe6fGB4KbRPZJfz4dHrMi6cdcH7MsBfEGPcY=;
 b=PtiiRBZDTnAlluBfobwZzQGLJ/AyEwFmbll8aYEWi88KTDuoONucRTVseGzlY3yB/S
 Qx8eJTj/0iPYp+B188P9cbFxl3OH2H0QdYUOMkG+9cDOSPqAWv6UneRPxSkXNdVshw0h
 5qDtQnUwCax2xqLscA4nXUJpSvjhJ4vIikbfPxlXLnrunShnhfSWG4Jnr2nFLIp4eWqt
 otGls6y6+kwpcgiMH1CqgB6sgzMUUXGAYQNV0RmIwWa9QO00Py5A9cYpOtpRPK8+Wgot
 ZATblNmo2rMsYj84UyA7YT5GDNmTuEipNXoqDK6YbvfG5K+dT3VwGFQMaNqnSgsAU3LY
 H5Mg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793212594; x=1793817394;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lYvtLQxECR7zzA8enmmoEif4unPNziynYy8Am2AkWgE=;
 b=WCw+l64rTU8n7ER9JnnrByY8ehJ9Goc403UavO8+Gn/g/T0XY2zH9g0LKcwJu1Bd2b
 KHE4VYpiq5AapRF28+K8yFgqJDxB0Hag02YNQlhvq27zBuXpZZTcZs9fESzrLzPMFim5
 EtUSDmgEWgZc4wASsT2zOCq+SWL6Z7qefG//WVOAR6LIqvLEoSt0DI2eM3Zt3J04Tg3+
 1GVHn9E53Jq2u5M0JNuwwKsHbKTawpfmqpI1Mg9Wld4707jt6xETy8EITX+f08lMrxVv
 V4IF9WnQuJqzviliNXFwnLXvwpdrrItTmdWsh3aWIatbVWVvdMVUGIFaVQH+pefYjxgn
 rlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212594; x=1793817394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lYvtLQxECR7zzA8enmmoEif4unPNziynYy8Am2AkWgE=;
 b=aFfnTvI6XdwPCfsvdmpQR8sG4RAu4j9ZnJc9pMe6zgUlwQ67hwiXv8+akpCoMf1qRF
 wMpq1hUta9XLoUAUdr1n/daas2joJzKEvMhHMA3zO1nqQMpPYZVvi3c0u8S7XWGuDhoD
 dWkVl2Y0G9DsDe9kxKe4swFOX0F0a/xi2pdJPojc60ll0iioZrqx5g0NMHGPs7QK+9ff
 smcJTeN4u3XHdC2TJZkBMHhIUoIQFolPKnFawdijwQLFprNO5x4+zqIJ+Vyv8dD+me93
 7qo/YjdTvIRNgJff3VEm5kN4liehAtR4EftTsDKhLKSc2SkFYYWdFqzmY/s6dxTMFYhz
 6FUw==
X-Gm-Message-State: AFq9FYKYnTrVrhJZWs+w43rNq2HQ3qE+BZm+Aj9IhCucFnX6qvXsGqha
 9V9v/UfR7zIOlqt4Ko8mVqM+rAwJN6B9V8I13Nri8BFNCXY4l21IcZUg6ovUVbNYZoK5A386hf4
 DxZddQxhDY9rCDyo99zynO/dQyWaYRkU=
X-Gm-Gg: AYBFou0btxhRSIagIkfFXGK+esp7NVJGjbkbj0oFNq1C4jlh34cBoEBf8pWGCWraI+x
 q3itY4I95Z6rU9qJAc3W4mzC87UBl0P8HadNT8qoGtxMGTM58MpMTzO774Quqsjc3kTpbuRkLtp
 OZ2uMvSo37wBv8ttYdLTJBuVEym61oTjO8CSnzB7kS99WvxUBjaoeOr49rnNigjkVVliM1xPHw3
 rBbeWYvg0v4weqV7n6VLEfZwho92Fo9y0LBPdXSJYOVdLH+9LdaRbhPtwLHYD4R4hmp5+xMDKoi
 J7c8C0lvhzv7DeaPh14lj0h0idzitisxZ29I4UUVW6Nn4WAjXZQg5u2JdFiRTik+N29e9cKp+dd
 9N54kgpe09Lbu0/uCKZggfEte4nLz0uQkaYXPd9ernBPUqRQmq7/GmxJndAncA3xVLL78MitgUw
 h1H4hCVYWwLhyolv8hef4ZuJuukQ9qcc0+932jWVgP6Gs30/48f2dmlqU=
X-Received: by 2002:a53:adc3:0:b0:679:97d1:437c with SMTP id
 956f58d0204a3-67a7bd51c26mr1532810d50.94.1793212593866; Wed, 28 Oct 2026
 11:36:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
 <20261028181244.GD2677024@bill-the-cat>
In-Reply-To: <20261028181244.GD2677024@bill-the-cat>
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
Date: Wed, 28 Oct 2026 19:36:22 +0100
X-Gm-Features: AclHuK8Vyhf-VH5DHbcaJNE50QPghZd9W2tV6fddo4mGvkPrM1Lpoi0-fSC61z4
Message-ID: <CABPHAJweoMq-H+yQV_vzhbEx1=RXcYxxqz=_qoHPqKtV3ncWQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] macOS improvements
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No, the issue should be there with macos-14 too. You just don't hit it
because tools-only_defconfig doesn't build the two things that break:

a) kwboot is only built with CONFIG_ARCH_MVEBU or CONFIG_ARCH_KIRKWOOD,
   and tools-only_defconfig has neither.

b) The same goes for crc8.c. It's only used by gen_ethaddr_crc, which
   needs CONFIG_CMD_NET, and that's not enabled in tools-only_defconfig
   either.

I hit both with HOST_TOOLS_ALL=3Dy, which turns these on.

To be honest, I haven't tried macos-14.

~ Josef

st 28. 10. 2026 v 19:13 odes=C3=ADlatel Tom Rini <trini@konsulko.com> napsa=
l:
>
> On Wed, Oct 28, 2026 at 01:12:55PM +0100, Josef Schlehofer wrote:
>
> > With HOST_TOOLS_ALL=3Dy, the U-Boot host tools do not build on macOS.
> > crc8.o does not compile and kwboot does not link. The kwboot link error
> > also stops board builds such as turris_omnia.
> >
> > Patch 1 links kwboot with the system libncurses, patch 2 removes an
> > unused function warning in kwboot, and patch 3 keeps the sandbox
> > asm/sections.h out of the host build of crc8.c.
> >
> > Tested on macOS 27.0.1 with Apple clang 21: tools-only with
> > HOST_TOOLS_ALL=3Dy and the host tools of turris_omnia_defconfig now
> > build, and kwboot boots a Turris Omnia over UART. On Linux (Debian
> > trixie, GCC 14.2) the same tools-only build and a full turris_omnia
> > build still pass, and kwboot still links against libtinfo.
>
> Interesting. I guess since our Azure builds are (wow, I need to check if
> there's newer VMs..) on macos-14, and we do:
> $ brew install make ossp-uuid
> $ gmake tools-only_config tools-only \
>             HOSTCFLAGS=3D"-I/usr/local/opt/openssl@1.1/include" \
>             HOSTLDFLAGS=3D"-L/usr/local/opt/openssl@1.1/lib"
> is why we hadn't hit this?
>
> --
> Tom
