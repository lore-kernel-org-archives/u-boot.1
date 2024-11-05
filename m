Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C7D2C122
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0346891D0;
	Tue,  5 Nov 2024 16:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BZyiNQgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C1A891CD; Tue,  5 Nov 2024 16:15:13 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6BA891AC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so929218566b.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819711; x=1731424511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5aiv8bhaQIMxoAWezGphrdAUeJiiTDitxc3NLkDWNwI=;
 b=BZyiNQgM8dK+cgnu9epcaiDB6beq+Jv2Nkw8RhWOLLL1fr6bqHSYx03uFyDnCjBhsE
 yIweBF2k0NSZ9870kFCF+GzcJcpvFgjQBqaObRWPOxu0aPAIfqO7kp4+731+oDb6UWkE
 AXjR6VN7g3RK70Vhm5ni8GdZXWA37RRdpWvjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819711; x=1731424511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5aiv8bhaQIMxoAWezGphrdAUeJiiTDitxc3NLkDWNwI=;
 b=YGqgi1pvkz4mTTiACrPJowxV8Ba9KCshQjWqT65dUI9A/CTgJTjHSU3C8Lg68Gf7AW
 G4lNZNGWlteD3SbBfYnww9E9dC1arKpZyaACWk8af2BbOCc3hhT+elE9tWW2v/fncRDd
 vTo1P3++HQFvZmLe3Wk275PX8wczE5ZKF7jSrks1PXqF+mh/rYwj+I8XgZHmLZ3mSY7C
 X74iY9IQQbA9CKY/APi6UCakgUueSVKJQFPywkf3C8+q5kxtPMLMl7UgFpU+37MCxpJq
 y0QfJBqhWJpul71wYGGyZSQNiVZZ7tJGSzRhJLONY4JXm296+FVB3cx/kuaA8Jp87D4V
 W3lA==
X-Gm-Message-State: AOJu0YwXAHXoZQoBLIseJSVMchiEwvwoPDlxH2H4hn97DETTLTKl49aJ
 b4ZgWjzs0PEcETQDvldDUU2eKjMygKPA6Ayine90+1cpu36ZZY+LY7fi4Ys86f27lrvAqVBc+fp
 EPgM17t3cBYF5KzNCVM+0VvmvWkPRq9E/m+PO
X-Google-Smtp-Source: AGHT+IHNxPnCNXh7Fg1W8F8SL/GaoY0IkE64S0+z/xLSc2+9A5yFDkujABmGL2Su+58g2f2XiaMYKPX89u+VqVDXA7w=
X-Received: by 2002:a17:907:2dac:b0:a9a:82e2:e8ce with SMTP id
 a640c23a62f3a-a9e6587e288mr1803798966b.40.1730819711121; Tue, 05 Nov 2024
 07:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-3-sjg@chromium.org>
 <F9A7881F-1242-4B52-B48E-F0512264989C@gmx.de>
In-Reply-To: <F9A7881F-1242-4B52-B48E-F0512264989C@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:14:58 -0700
Message-ID: <CAFLszTgJEtuarWu+WGM6q46oLLWqXrDE_yLVTs5QMU92TtL3sw@mail.gmail.com>
Subject: Re: [PATCH 2/9] test: Adjust print_ut test to use unsigned char
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

On Mon, 4 Nov 2024 at 13:51, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 4. November 2024 14:39:46 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Since char is unsigned on arm64, this test currently fails. It seems
> >better to use unsigned anyway, since 0xff is written into the string at
> >the start.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > test/print_ut.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/test/print_ut.c b/test/print_ut.c
> >index f5e607b21a3..7e5c015f3a7 100644
> >--- a/test/print_ut.c
> >+++ b/test/print_ut.c
> >@@ -242,7 +242,7 @@ PRINT_TEST(print_display_buffer, UTF_CONSOLE);
> >
> > static int print_hexdump_line(struct unit_test_state *uts)
> > {
> >-      char *linebuf;
> >+      u8 *linebuf;
> >       u8 *buf;
> >       int i;
> >
> >@@ -255,10 +255,10 @@ static int print_hexdump_line(struct unit_test_state *uts)
> >       linebuf = map_sysmem(0x400, BUF_SIZE);
> >       memset(linebuf, '\xff', BUF_SIZE);
> >       ut_asserteq(-ENOSPC, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 75));
> >-      ut_asserteq(-1, linebuf[0]);
> >+      ut_asserteq(0xff, linebuf[0]);
> >       ut_asserteq(0x10, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 76));
> >       ut_asserteq(0, linebuf[75]);
>
> Should we add a ut_asserteq_str() here to check all characters?

I believe it is...that's why it checks the \0 at the end of the
string. Or are you asking about the bytes after the string?

>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> >-      ut_asserteq(-1, linebuf[76]);
> >+      ut_asserteq(0xff, linebuf[76]);
> >
> >       unmap_sysmem(buf);
> >

Regards,
Simon
