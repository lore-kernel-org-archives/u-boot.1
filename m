Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2886DD3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F0F89181;
	Fri, 18 Oct 2024 01:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XEL7rvHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B00689157; Fri, 18 Oct 2024 01:12:05 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C843F89068
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b14f3927ddso117921785a.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206721; x=1729811521; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b3QxrB7xjunndf7DX8/DM7xaxjQjbEiDJnLwpkPSgqo=;
 b=XEL7rvHmzEcqxsZHkNBt7obZM7t2UP5oPKYG55oviPDaxWV06yt9+x3O1NphCqTwYm
 iEA7QKPE9lPkSl6jMnVXz6NMtFwinotAJmFvLTsOSVuIFEQSq0NgJYSDZ7cwZsbQWYJa
 V12BfZzAzSMkSGBmHxRI7iw6dFnH/NUIEtJ/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206721; x=1729811521;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b3QxrB7xjunndf7DX8/DM7xaxjQjbEiDJnLwpkPSgqo=;
 b=QZ7NnGjWYqR/O66uuvmmhgiTn4Q8lo1A6B9rJvq+XmPwEJgIUaO6YoHmsYN9U5aaek
 uyXyFK5rkWGVp9yhTvRNvJK8Vn223ixESmsBiJyAUjv7a/fsWprB1FNLhhSe9seqvquJ
 mldecBrrZ3MUs6eirZKQDzOmxwHgd/Qgaf7zFaq1TzsV+23BSxDMXkSXBUBUlhjIzQap
 GVlylF+Lau4O7n89DnVm6HoHubsh+lQCMYy22NjpFg2J/+z5/gZyMuV31UIOan2gKmE/
 nDnZ7oGdRLb2di0st1UZAvS6kcEPFNDAchswd5QM1C0aH/FwilwxO+krfR6mcNjMVQCa
 +szw==
X-Gm-Message-State: AOJu0Ywj0mtsEtlbHx4RyRbqVBBwsrVB6H1sIZ6GW9sBLEZNg6oigdoM
 XKaSV0TOkSeSKyR32ske1CI1scghNaZKxW76/9PPML2TZzcmS/X07pDane8eAMOe1uJLXPSGIfD
 ffM/1MvRGM8VCdKhPZMj7CHmOMQje45hmz4jL
X-Google-Smtp-Source: AGHT+IEtNwH+NOBc2Nka5q0TXVu5gNujt9xYCBmtVWlpt64R1PWhgA4ykTgAF2OPpx9P38LSCgCbW3hU9uxr1nRe5uY=
X-Received: by 2002:a05:6214:4411:b0:6cc:1de6:1287 with SMTP id
 6a1803df08f44-6cde114741dmr9061436d6.0.1729206721228; Thu, 17 Oct 2024
 16:12:01 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:00 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTiwHSjS_U895=5o4Utino+ofDxd_-U4z8yaT6hNpJLJxw@mail.gmail.com>
References: <CAFLszTiwHSjS_U895=5o4Utino+ofDxd_-U4z8yaT6hNpJLJxw@mail.gmail.com>
 <20240916082446.32082-1-al.kochet@gmail.com>
 <20240916082446.32082-4-al.kochet@gmail.com>
Date: Thu, 17 Oct 2024 16:12:00 -0700
X-Google-Sender-Auth: SxnDP_tcfPtQt_zKCI6UVFfnt2Q
Message-ID: <CAFLszTinRbfZHkHweJ-OOc4dFzLb12G8p9+4pkYahHvbQ-oF0g@mail.gmail.com>
Subject: Re: [PATCH 3/3] binman: implement signing FIT images during image
 build
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alexander Kochetkov <al.kochet@gmail.com>
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

On Mon, 16 Sept 2024 at 02:25, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> The patch implement new property 'fit,sign' that can be declared
> at the top-level 'fit' node. If that option is declared, fit tryies
> to detect private keys directory among binman include directories.
> That directory than passed to mkimage using '-k' flag and that enable
> signing of FIT.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  tools/binman/btool/mkimage.py           |  5 +-
>  tools/binman/entries.rst                |  7 ++
>  tools/binman/etype/fit.py               | 51 +++++++++++++
>  tools/binman/ftest.py                   | 95 ++++++++++++++++++++++++
>  tools/binman/test/326_fit_signature.dts | 98 +++++++++++++++++++++++++
>  tools/binman/test/326_rsa2048.key       | 28 +++++++
>  tools/binman/test/327_fit_signature.dts | 98 +++++++++++++++++++++++++
>  tools/binman/test/328_fit_signature.dts | 61 +++++++++++++++
>  8 files changed, 442 insertions(+), 1 deletion(-)
>  create mode 100644 tools/binman/test/326_fit_signature.dts
>  create mode 100644 tools/binman/test/326_rsa2048.key
>  create mode 100644 tools/binman/test/327_fit_signature.dts
>  create mode 100644 tools/binman/test/328_fit_signature.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Nice

Applied to u-boot-dm, thanks!
