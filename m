Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8D9C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 18:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A78A801BE;
	Wed,  4 Jun 2025 20:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JfoweuYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CE9803DF; Wed,  4 Jun 2025 20:20:33 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5767E800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 20:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6071ac9dc3eso100434a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1749061231; x=1749666031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zrSTCirxHGbYQ5+jAoEhx63Qm4GubKwkV3EINbzCqPg=;
 b=JfoweuYsbrEjzFDLL1xjfjuZG6w/PHbSZAi2/d1Orv/Yc6O+0QlDcyiuk1EazwAVGK
 w8KX14kgswozrXXownDGjMC3ViYmH1t+QNa0eCX4JOAEIonDGQG6xlUzErXBegTV4rf2
 YiTN5v8a1kU8kVHaZWKU3yfYhBidyk+b8jbEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749061231; x=1749666031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zrSTCirxHGbYQ5+jAoEhx63Qm4GubKwkV3EINbzCqPg=;
 b=pfL/XI9JdJr3RLffR3p0xPP5K5bVnRiWduEkM/Lr5j+7p17F8fRbL0hYNXdi2awU7F
 XWGQlvhzjCCTHLSUunpoSGPJ54LeQ5nq5bMmAij6T7i4FqfI/ldceNa09bv97CCvyFeT
 BIy3RtS0WTmJcREOAQWC2ybCnBKhIunS6raTLIigqtox6EkreVB4OAX+yBtnkJr9BsQf
 ekoYIyYqCKOSU/jGycFG/tRRu894YxKchOpHotXaJXhkZZ6pv5NMphgpKAVCISbozkHd
 cQRRbakp6vw56z/09b2sqd+lmqGllrZ/5IJyn2nWGrRoPciS0JqTLDRUpt5ET5m76NFQ
 PQ/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtXj97xwkiPzyBU3S6a9Gerv8+25Sqqb3gxdb3Hqflo3ad04B6+0dR7v3Y1Li+kVkrqCHH+o4=@lists.denx.de
X-Gm-Message-State: AOJu0YwfzQ80mbahngYAFT5pS/iTe0wdYaf2AuRaBCbCgYi7VZfR/5s7
 Elzw5+0J3xVTPS8rVsgEotEqVPBbKETFxS/QIIKd5onVls48qARY/d4xra/ucqxmCcZPsvK8vk4
 4or7SSPk0DY1sa3l+g0gYOaElmBpUAu9Sm5afbo1x
X-Gm-Gg: ASbGncttKEAQa75yhGluA5NekhJtrNeeiKIce2YTCxEK2ynyxUzqfBJ4sJrkInMNj33
 utpRWXU9g4G0i1dmT5c9YVUzUcqHsyLM3bJfD1KuMNccmTgxgs4/5H7ONkl3eSS0WbwhA7Wys9Z
 jS9ZCaZQ6cw04wBO6QiEuoglxIOz5iYCyNYA==
X-Google-Smtp-Source: AGHT+IHGAMgQYl3+tjotGp7XY6mlTdIGWspmEA8ujo5U/DcVfQcfRH/5NOm5WmDRPfnfUHgbTa8FkfIdYuOyhFBas2o=
X-Received: by 2002:a05:6402:3596:b0:5fa:f7ed:f19c with SMTP id
 4fb4d7f45d1cf-606e9415f30mr3870678a12.4.1749061230845; Wed, 04 Jun 2025
 11:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250604130923.1484873-1-sjg@chromium.org>
 <4d363f54-63b1-441f-b64b-a10c47a85edb@linaro.org>
 <CAFLszTi9yEz_JH9uXz8wmfsGJr8cKX2-zN1seX9cDTd+iqSEMQ@mail.gmail.com>
 <20250604172304.GQ1382132@bill-the-cat>
In-Reply-To: <20250604172304.GQ1382132@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Jun 2025 12:20:17 -0600
X-Gm-Features: AX0GCFstIG5AE4zp5L9g3Uy7GuQm8NdzpZ9iFjAHnSGFuGX0X5MbwHeJKGrP8pE
Message-ID: <CAFLszTgo5nN2KGzsUYoy028i1u9T77JsvPB0Qn+_P-1BzuNR9A@mail.gmail.com>
Subject: Re: [PATCH] x86: Correct condition for init_cache_f_r()
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
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

Hi Tom,

On Wed, 4 Jun 2025 at 11:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 04, 2025 at 10:17:32AM -0600, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Wed, 4 Jun 2025 at 07:15, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > On 6/4/25 15:09, Simon Glass wrote:
> > > > The condition here is reversed, which makes link and coral very slow,
> > > > leading to lab failures.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes 6c171f7a184 ("common: board: make initcalls static")
> > > > ---
> > > >
> > > >  common/board_f.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > index bff465d9cb2..c8a612d6070 100644
> > > > --- a/common/board_f.c
> > > > +++ b/common/board_f.c
> > > > @@ -1079,7 +1079,7 @@ void board_init_f(ulong boot_flags)
> > > >   */
> > > >  static void initcall_run_f_r(void)
> > > >  {
> > > > -#if CONFIG_IS_ENABLED(X86_64)
> > > > +#if !CONFIG_IS_ENABLED(X86_64)
> > > >       INITCALL(init_cache_f_r);
> > > >  #endif
> > > >  }
> > >
> > > Sorry for that mistake.
> > >
> > > Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> >
> > It's fine. I only noticed it because the lab tests started failing (I
> > have a short boot timeout on one of the boards).
> >
> > Do you think some of the conditions could use if() instead of #if now?
>
> I'm not sure the readability nor code coverage will be improved by that
> in this file.

In some cases it would help, I think, but I suppose it would be better
to remove more or them, or replace with events.

> And please find the time to reply to my thread about your
> future in the project before making further suggestions about the
> overall code base, thanks.

On that front, we'll need to discuss the options. We could find a bit
of time in the next call perhaps, or set up some specially.

Regards,
Simon
