Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE2DC3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1544788498;
	Fri, 26 Jul 2024 01:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nEDCgijY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF6F8841E; Fri, 26 Jul 2024 01:33:14 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EC388395
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b7b28442f9so997136d6.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950391; x=1722555191; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sv0FrakfASKnvfWLkemhVN/zJbjohp89SZ02dL187Qo=;
 b=nEDCgijYG8Lod6akZABYNW2y+GgoXjTUDbkjzaStZOUJOCOHT5ONK5iVPM3VjFv9H4
 TUMflsb2Xx/e8yUdVhhx/Ea4Ae/WJ7I/wOcElhyGX84cFOa+VhSSJSUX9KBzYdreHi9Q
 X2oaHAxshEST/51CbiFLM0K1J2oNiqIk8oUhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950391; x=1722555191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sv0FrakfASKnvfWLkemhVN/zJbjohp89SZ02dL187Qo=;
 b=CNppidX2jSedljra68seq33tIDJfHMpB86JfgGHplU2hytffPjy+bbNeoCukQ6HCnD
 D9iaUpwaeCAzKiHQl2dsGQL3AJIopak0DYtBzxkCaWI4KJ2hBSaQDTEf4F4vJFR/XkmA
 KICUVVeCRrR/Q+ImXn4kbl9aE1wvg5kQNKbOk2F6lvEZkNzP3GXdJPuYCHAJvgwJ9rRd
 MebipShUD6ayVIWNbKPWyfTeDf4cyEa1/EGpVS0HhMxeoN5dITiBCYyHLDbXjT7ahDf6
 UguPIvgV5bqqfv253ePWYHlR7c9JJIkzGaICKM/MG4Laa/nk2HggKFOs+Yh+6Jni09gn
 fg+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH0HXx0slfqoytY+qxdlcdl1zM+odOnUd6fxbpXkKxU7XK/YERJae8k0CU7FEjdaWzuofX0XHmVKALrPNO0Yp3vmCpYg==
X-Gm-Message-State: AOJu0YzXKDBTzIc77YVqRfOQ3XqfNgohaW+oOdx6LR5tHN6T45lUbug0
 4tQi+webYxl2uOkrSp4T4LMrCMktIuEnhNzdHABC0onVdje2YN7uEN0WQDnHp9h7OenlMiy1cbX
 G6qK7/x1S9W6nB4pI6/Yp8xvBP9Pr5bzWJ1ag
X-Google-Smtp-Source: AGHT+IE0Ei+jvqC5wn4Ff+Hpq9uO+DlY7w4DL/Ll/cieCTHlEYjEDeUre66IYejFMj+fWvj5gjDh2tKGIdCgcqCfDQQ=
X-Received: by 2002:a05:6214:262c:b0:6bb:3f69:dd0b with SMTP id
 6a1803df08f44-6bb4081f43fmr43866246d6.18.1721950391007; Thu, 25 Jul 2024
 16:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-4-sjg@chromium.org>
 <f499b8da-61dd-488d-ab86-bd71c0eb94dc@gmx.de>
In-Reply-To: <f499b8da-61dd-488d-ab86-bd71c0eb94dc@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:33:00 -0600
Message-ID: <CAFLszTgzEDQxmeGUg+S1ADv=+MWAm7sQGFPmsc75m-t+3wBnoA@mail.gmail.com>
Subject: Re: [PATCH 3/6] efi: Allow monitoring of page allocations
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Thu, 25 Jul 2024 at 10:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.07.24 15:56, Simon Glass wrote:
> > Some confusion has set in over which memory-allocation method to use in
> > EFI-related code, particularly for the pool allocator. Most of the time,
> > malloc() is used, which is correct.
> >
> > However in some cases the page allocator is used. This means that some
> > EFI information is sitting 'in space', outside of the malloc() and not
> > allocated by lmb. This can cause problems if an image happens to be
> > loaded at the same address.
>
> We already agreed to resolve this problem by integrating LMB and UEFI
> memory allocation.
>
> Please, contribute to reviewing
> [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
> https://lists.denx.de/pipermail/u-boot/2024-July/557962.html

Yes, I reviewed the RFC some time ago and actually referenced that
series in the cover letter. This series is aimed at something
different, though. Please see the cover letter.

>
> >
> >  From what I can tell, there is currently no checking of this, but it
> > seems to be a real bug.
> >
> > Add a way to control whether allocations are permitted, to help debug
> > these sorts of issues.
>
> Calling AllocatePages() and AllocatedPool() cannot be forbidden as we
> want to comply to the UEFI specification.

Right. My point is this for debugging only, to allow allocations to be
forbidden when they should not be done, thus allowing us to sort out
the problems. Once there are no more problems, this patch can be
reverted, but that might take some years.
[..]

Regards,
Simon
