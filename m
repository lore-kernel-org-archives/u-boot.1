Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D749CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 18:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CB1803C6;
	Thu, 30 Apr 2026 20:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="OFjK7QPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F181480433; Thu, 30 Apr 2026 20:19:11 +0200 (CEST)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37DE880086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 20:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2eadb000b8cso2371799eec.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777573147; cv=none;
 d=google.com; s=arc-20240605;
 b=gDLr5goLXQ07DAgpcs3Eci5X7inC8NG2UkE+Zi8hWisS06tJFObIP3K75zRmAct5BO
 sz0aszklKakxfOGFfOp1RnohRZ7YLxWRQVCcWaGJ7io113hR8WZXnRZQUsbGDJhOSoq+
 Ot97eE7b1MTVIb8ikk/gN4BWs/gahj66FYo8AFIejq4jxQhsm6GqPchoK5+Y4efig+Ju
 djIZ/Rir7MhKpLkpdyfCISq9rUUYN2tgeXfWNaBmq7v0D7qODb0xdMj7l9X56ida/R1g
 OKgqoFokKhrsrsfjSQRO3VKOPtxTONhUBNraKmLXL846oMs33tQHMx8UFH3EemsS4sow
 WoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=weRaqufrWuURR+K7EinxkbfDVB7bPdMGse3ANFdjF+o=;
 fh=B7++efQEoSVFQ9ePsS0QvvXoKtroD+13bBMFR3U3XYY=;
 b=TRupj7e9FPMWQp7jtO6woQkhA6YiFBuagIBhrTtGnpm+pEsXidaZbEkRDpCHwAHqzg
 svZ+T2uohRTAXyr9XVGNinDSsSIIloonAPCN4JancU0Zqomt3XVTIQvyTHEI5inS59Hv
 3GgU/JsNO8umGQuSo30eWQmrWeP51o7anZrZYNoIxJ71ft+wzxRShPOxF5z4yUJf6SPT
 q0UFOoNxHXo8/zpzWud6IWFb/152XeNZOpDiKT6A59w/qYg+JV+fbscuGTeobXFqymY0
 GMp9E4680siorUqALwDFIz9gSIJrJnVd5RMx/bqB+xoVFXZJugL5nEBLh78XnsSNDWIg
 HQsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1777573147; x=1778177947;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=weRaqufrWuURR+K7EinxkbfDVB7bPdMGse3ANFdjF+o=;
 b=OFjK7QPJRwlwptd7GUI1lYe1cfbYXHpKGAF5ow1LYWpScfCrNWlyieMaSLZBJV8n+j
 yDa783+3dyU0RvKn29hgdjerZlxosEVjy6AK012DwgqVEzzPXcK5uNzOh7/0GfXjNGay
 82MhNddw37t7wm7yan8WQX6g13bxF7m6CtohhlIjaE+QS5jIqJqIjS7HE8ksVb063QU6
 OdoH86uEkR4a1tGV9TsFbtUGukypG43U/DDlgx6+V0SJ5ywXwxPxmTEiNggIXd+xTuTp
 tQyjt584vOGOgyoB09kHmSNnKWMrkrSdcZQJ7P2g8aQzHz9dxARTb+HRD1jiH9hYF5PN
 Ck4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777573147; x=1778177947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weRaqufrWuURR+K7EinxkbfDVB7bPdMGse3ANFdjF+o=;
 b=T3miiqQ26WpzC+s7DZZFT0PhfKDJFr9ln0dekSrICbz9xjZ1tDaTnVbHfCEO5lp8+b
 gM1LqZW389QkK1Lq5pMj/qrDsrQ5/rb5seACmVQPuU80MOU8FsvkWmTUlS0GxoE+Yio3
 07/ymUJKeuY8VvfL1YCBK0Gjqy9SLqtvXb2RwRtTWGFlfL21n1+jUlezrkKxLdGZgZL+
 YEuHY/tft1g1kAzzij0LsJLnJDeKD0IJrawVPFyySl18n8C+m+qtG7a3o4lVXrS/IuFk
 xDl8WmKkfB625tQLwLnclpFp+VyP+3ckUAv5ft3helStZRcdib6pjJm2//xqTM+A/EfT
 8/8g==
X-Gm-Message-State: AOJu0Yzq9gOCzYYxRI/5/A3IdSejeNs4DcFte5w5kSml1vsel0iDa1rD
 cOGMDFudXuJGR0xXz3lo7yLJvXJBvZojDXR+tyAJpu3sGxrzQLGTZGd0alRZB4cBbQ3pwuNMPNt
 7uiyWy9oER2dac9jLST7gSehMwFymEALoeTC5+7c9VA==
X-Gm-Gg: AeBDievP+3GgetM3JkfODYk6Vje4RmZaqhxLf7xP7uVqNUdiI18cEiLfRspxXJrw7/+
 DUuGMyaj4smdtdl239F38lc20IdMxkPmaJPGf59442g8N7zjJhFrvlMdayJMvjg5qKZSl93JbXI
 EsCy2w4QvlRjdU7Ahp6pamdaJw4xJZUou6TG9OPUHcJHUydaURELZXQa3MwNWJuIyVK90biRJ0C
 u7pZNO0J2uQjGvmr/+mJhDhPYb+m4+a30Y6ZQCOkaycow5Nw4df5K1wQlkAB28SJefOnSSuBaf3
 SrmzUVxbAjP7gmLq9omVuE+D1hMPIH6fGkin19QMR0ATzpEg69Y=
X-Received: by 2002:a05:7300:e8a1:b0:2dd:6937:79bc with SMTP id
 5a478bee46e88-2ed3ba12a29mr2188432eec.6.1777573147607; Thu, 30 Apr 2026
 11:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
 <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
In-Reply-To: <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 30 Apr 2026 15:18:50 -0300
X-Gm-Features: AVHnY4I-RCxdjJ7Pdhs6GtJSzfcunFZsInRy2mq-YsjNOTzh15nhSUJx5TPMoSE
Message-ID: <CANu7NGtodVvWiW7ogKdiEdYbe26zbL8b9czL4BAKS3jBT7pr9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Quentin,

On 4/28/26 X:XX PM, Quentin Schulz wrote:
> Yeah, I'm not convinced this is useful.
>
> We would need to propagate this new variable to whatever calls those
> methods as well. And it quickly balloons.
>
> Just mock the environment with
>
> with unittest.mock.patch.dict('os.environ', {'MYVAR': 'myval'}): like in
> testFitSignPKCS11Object for example?
>
> I'm also very skeptical of the need for binman to *set* environment
> variables to setup openssl.

Yes, that makes sense. It does add unnecessary complexity, especially
if it requires
propagating state across multiple layers. I'll drop this commit and rework
the approach.

> Look at what's been done for testFitSignPKCS11Object, we externally
> configure openssl and softhsm so that binman doesn't have to know about
> it. This avoids having to play smart and adding a bunch of new
> variables. Is it possible to implement something like that for the x509
> certificates? For FIT, we do use fit,engine,
> fit,engine-keydir/key-name-hint with mkimage to (possibly) use pkcs11,
> custom openssl engines, etc..

Agreed. I=E2=80=99ll align with that approach and move the OpenSSL/PKCS#11
configuration fully outside of binman, similar to what is done for FIT
signing.

> Also, I don't think we should decide for the user whether they are
> forced to use a provider or an engine based on the presence of the
> provider? just let them configure openssl to use the one they want
> externally?

Yes, I agree. Letting the user control this via their OpenSSL configuration
is the cleanest approach.

One caveat is that the legacy engine-based flow (e.g. pkcs11 via libp11)
does not integrate transparently with OpenSSL 3=E2=80=99s STORE path (e.g. =
-key
pkcs11:...) and typically still requires explicit -engine/-keyform engine
usage. I'll elaborate on this in my reply to the second patch, since it
directly affects that part of the implementation.

Thanks for the feedback.

Cheers,

Sergio Prado


Em seg., 27 de abr. de 2026 =C3=A0s 06:48, Quentin Schulz <
quentin.schulz@cherry.de> escreveu:
>
> Hi Sergio,
>
> On 4/23/26 5:45 PM, Sergio Prado wrote:
> > [You don't often get email from sergio.prado@e-labworks.com. Learn why
this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Add an optional extra_env dict parameter to run_cmd() and
> > run_cmd_result(). When provided, the key/value pairs are merged into
> > the subprocess environment for that invocation only, leaving the parent
> > process environment unchanged.
> >
> > This might be needed by bintools that must inject environment variables
> > into specific tool calls without polluting the global environment.
> >
>
> Yeah, I'm not convinced this is useful.
>
> We would need to propagate this new variable to whatever calls those
> methods as well. And it quickly balloons.
>
> Just mock the environment with
>
> with unittest.mock.patch.dict('os.environ', {'MYVAR': 'myval'}): like in
> testFitSignPKCS11Object for example?
>
> I'm also very skeptical of the need for binman to *set* environment
> variables to setup openssl.
>
> Look at what's been done for testFitSignPKCS11Object, we externally
> configure openssl and softhsm so that binman doesn't have to know about
> it. This avoids having to play smart and adding a bunch of new
> variables. Is it possible to implement something like that for the x509
> certificates? For FIT, we do use fit,engine,
> fit,engine-keydir/key-name-hint with mkimage to (possibly) use pkcs11,
> custom openssl engines, etc..
>
> Also, I don't think we should decide for the user whether they are
> forced to use a provider or an engine based on the presence of the
> provider? just let them configure openssl to use the one they want
> externally?
>
> Cheers,
> Quentin
