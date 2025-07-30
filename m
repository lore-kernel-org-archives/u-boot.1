Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2395AC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3580C82E52;
	Wed, 30 Jul 2025 19:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s4ptfCFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E00B82BA1; Wed, 30 Jul 2025 19:18:42 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4DA08211F
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so84587fac.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753895918; x=1754500718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bp1FFCiIWJh9tVpZWo20LRDj6/CSHyquJbYgbYGztFk=;
 b=s4ptfCFsqGlQpTNgJNsxZFJ/3zIjM/vEYN7yup/ZmKnHghMGdskKk/LIFmxL+C0FLi
 Kzii4xIlh5tSFjlD4u7HlP7rqFc8rLcgIXq0wl5FaQkV9Yo7OzzvWMDQQtsHJSphIpkq
 P5V03P0twEJ8i/Zq+hLq5Jwj8T+7MNgkFl788=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895918; x=1754500718;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bp1FFCiIWJh9tVpZWo20LRDj6/CSHyquJbYgbYGztFk=;
 b=PQvewGqcyXq0HQmDrCctrmrr5alA+swaLvEePRd9V8azYK/Ln+qdFcBHeHxkX3qJzi
 Q0TA2LWry+qg+gV3ENTx2rfKgVKO+1hmxfZblDkw9Fi/lDohvYYbjO6XDx83UGzhzVBt
 d2rsIgVFmR8a24x7hPZFRir05lOjPDEiC6kO3rhMpO6ApSMsLtvpI9V/CWesUiUoEVu/
 n46uS9VHusk/7ClI9UY6rerv/rjt0BLl1YZ2aPz/HVdc650+Jvmk+AyYcxlvwy7Jl55/
 fzSZFLPXZ7HFK0+6iDsKuZFVqo1s4nSs/aHCrdfasgaOiKSNCuvKj/8KaOWSSJ1x9Ovd
 OQIQ==
X-Gm-Message-State: AOJu0YzDdjqCYRuZYSwMbXMQ7ucR+vncBTNyEnjfsKTx0+S3o0n+EB0G
 7jLaK3T67qvSNRwH4K4LKI10wht5yKzJtxiob7umqzh4eWzhsQBJiHriPw+1SrIzk8A=
X-Gm-Gg: ASbGncvNST0Y5nALHaFsr/aF2VUxZB5Mk8NjvUNcQewT2+KoHU9PoCqV6nQnHXxmARz
 QuweXqL/mPgSQU6VlUl+xhJ88oe0Qb1Qj7ahTM4dXVL89StCUn9ilDwRGU11FoGxi36A4j5cr4J
 jUkuU3kO1Tm+J2DzGYQUyqJuErizQaD8EUjf0n6G2dzwQ21RqwbRF/0pUrOQxQnVsOemMUE3aCA
 7OBi/sQLuJ4TabLmEEW9d0CHCrQP9Vlbp0zz6fFkmbkcfpdizhSqWwtIjTLiTXkoqvLtfmBPL9d
 nYIke3694fYM39Is47ZUTTtnTmp9DhiK4QNlZGT6biUr1BXhS6p/Tqa25VLr1bxhWr/iY+uJIo+
 VQ7dl54UErJxsIt+y/qM0pcudQ9dNCy5p4s+XjkGNT2uUdRVbPvtBPy0=
X-Google-Smtp-Source: AGHT+IEuf6Aq7JMja4RHT/3SozQcpHyL0/jdBSTeZa0XlanxMsgAA66NR3pfklpRrx38HRTV7PB72g==
X-Received: by 2002:a05:6871:798:b0:306:c0b8:49f1 with SMTP id
 586e51a60fabf-30785d11126mr2460502fac.19.1753895918437; 
 Wed, 30 Jul 2025 10:18:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071323a99csm3016751fac.12.2025.07.30.10.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:18:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Paul Burton <paulburton@kernel.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20250722135717.23574-1-justin.swartz@risingedge.co.za>
References: <20250722135717.23574-1-justin.swartz@risingedge.co.za>
Subject: Re: [PATCH] tools: mips-relocs: replace format string introducers
Message-Id: <175389591706.3621398.13648918769350896468.b4-ty@konsulko.com>
Date: Wed, 30 Jul 2025 11:18:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 22 Jul 2025 15:57:17 +0200, Justin Swartz wrote:

> The statement that prints the ELF object type value assumes that "%lx"
> (long unsigned int, hexadecimal) is suitable for printing a uint64_t
> typed value. While this may seem to work for some machines, ie. amd64,
> it isn't ideal on a 32-bit system, such as x86 where uint64_t is likely
> to be equivalent to a long long unsigned int, as indicated by:
> 
>   ../tools/mips-relocs.c:275:34:
>   warning: format '%lx' expects argument of type 'long unsigned int',
>            but argument 2 has type 'uint64_t'
>            {aka 'long long unsigned int'} [-Wformat=]
>   275 |                 printf("type 0x%lx\n", ehdr_field(e_type));
>       |                                ~~^
>       |                                  |
>       |                                  long unsigned int
>       |                                %llx
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: mips-relocs: replace format string introducers
      commit: bb04b7bcf66e5d00a7abdf5c9a76026aa120e0df
-- 
Tom


