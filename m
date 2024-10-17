Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167ED3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5197689119;
	Fri, 18 Oct 2024 01:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cq7pAxBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D0A890F8; Fri, 18 Oct 2024 01:11:52 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0E9890FE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbf340fccaso12541836d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206708; x=1729811508; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpIeLR+bbUbQRGHuOpmupqg8ZPna7HruTmHd7vc1H28=;
 b=cq7pAxBZOd1rzD5v+f2uVknq0Z6Sg8XhMTCAGxZk1Jg5lKurXedFVtSjj5NjutWE6D
 MLT5vXMr1cVrLJxgZM7jXH/JQ0232b8+Wz3scTPwnGsJTOmTBUEEGVQT1MSHcEOWvIv0
 ZdzksUcxW5P8E6vP+vYG6RlFnj/BJ8Ok2lyd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206708; x=1729811508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpIeLR+bbUbQRGHuOpmupqg8ZPna7HruTmHd7vc1H28=;
 b=mFSySxefQ7WAsviSTeXXDM12RX1+RKtnGu5NYLws/Vzibx6JXilLX3gbfGRxKdlrW2
 jdbK9jaPPbUrM23uXvWjBHfUIViVjF6xxnPprpHfQQwbFCizAO3yWYBUqH+43Zns2KjY
 lMVY2ZqoWyGIqFwvwjI5TmRl7Z2QXl86dRz+dmPmvGbGWkhl03XhIpNsvSGEDYP8ar+N
 Hqbb3gGak7A8Coe5ntGVdLZ99obGMNWP0YfG9nSsUlGFeaxS5eo1wutR5AbMRGLiT92j
 XPVeELbAabaL7oTYfrqMDTA8mTFkmhJZWdcZi0HXZjQBRbISONcCGnvy8hiWS0qvuwAw
 AaSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxKxUJnPWhqUWI7u0zsKSR242wdFLfPlvR0dPcbD4uQgIZ0dFCn4/QqO01bVg/45I/YHlafnY=@lists.denx.de
X-Gm-Message-State: AOJu0YxQMhY1Gjt9detnD3nPa+DnBICqq0zORK2hh91MjyxWzHSVT+F6
 dbeUJDaj7NOYwhlU5wv5GUnAwyCXfhS2EcVDbK2s+2ma1RFF8U7WeZMnMuCEq8iEoPbHmUFkLH8
 s/vCC9SlXxMo8EDrxluRl8Yor26BpFzek/McDWiPZvmQtrsw=
X-Google-Smtp-Source: AGHT+IEkwtr3UwUPO/TAdf2qEgQ4hO3gXsKcae8RDzxAu12Zz61k23uoTsN0OPZfdZwF43rlYj5K5aBUw5BfOSa1nug=
X-Received: by 2002:a05:6214:3c88:b0:6cb:d0a3:35ac with SMTP id
 6a1803df08f44-6cde18bd4f7mr7953166d6.8.1729206707880; Thu, 17 Oct 2024
 16:11:47 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 23:11:47 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThNc-N9+PC9AvSknpGZ66GsfW1Tscd3c5XRvx8kjdBj+g@mail.gmail.com>
References: <CAFLszThNc-N9+PC9AvSknpGZ66GsfW1Tscd3c5XRvx8kjdBj+g@mail.gmail.com>
 <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-5-andriy.shevchenko@linux.intel.com>
Date: Thu, 17 Oct 2024 23:11:47 +0000
X-Google-Sender-Auth: 9YZfr4t5pmlXpv8d_wpblnga2J0
Message-ID: <CAFLszTi=s6kxbxVMKfrpwfoPEHkVY+zjui1ZqbeDzgw=J5075g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] x86: cpu: Add missing header inclusion
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Without asm/cpu_x86.h inclusion a compiler is not happy:
>
>   arch/x86/cpu/cpu_x86.c:14:5: warning: no previous prototype for =E2=80=
=98cpu_x86_bind=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu_x86.c:29:5: warning: no previous prototype for =E2=80=
=98cpu_x86_get_vendor=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu_x86.c:41:5: warning: no previous prototype for =E2=80=
=98cpu_x86_get_desc=E2=80=99 [-Wmissing-prototypes]
>   arch/x86/cpu/cpu_x86.c:55:5: warning: no previous prototype for =E2=80=
=98cpu_x86_get_count=E2=80=99 [-Wmissing-prototypes]
>
> Add missing header inclusion.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/cpu/cpu_x86.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
Applied to u-boot-dm, thanks!
