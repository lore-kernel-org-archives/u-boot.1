Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB77C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 18:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5010801BE;
	Wed,  4 Jun 2025 20:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a6BpA78P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B68803DF; Wed,  4 Jun 2025 20:31:18 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F2CA800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 20:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72bc3987a05so135909a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749061875; x=1749666675; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0l6vkuiU3Rbxr3mizyoTSK0A7jt438RyTn8FF2n5isA=;
 b=a6BpA78PCHf7Jl1o3iikyOV5aXsWTAwpJO7qkGBstLsRF6RozCwv+tC9QMz5gWl2yQ
 By9+jOR6mQDtN2sRPNwmVpXyUKqBhh7kZCV2CNUfBz4nt5ofglwyr0HcrUpEfOFW3ngv
 PaoN2jAfvLBQxHEEaleosEXIqpgXp7x2/iS6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749061875; x=1749666675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0l6vkuiU3Rbxr3mizyoTSK0A7jt438RyTn8FF2n5isA=;
 b=kT7XGe07Pomgs2t5NUj1G2YMxvD901PYOurW4TXqjMFdF5lfqrnCAQt5aGmkeJUdeD
 1JLAiNQZdRWhlyxIGn17jC6t1qhPW2UKH6WoszGp/b3BGft76WD0LaIPhSutkRlxYpL6
 7WqkE0oQ8WACCW/RZdYtPvTo2n5wH3P0Wf1Rvyg1z3se9WvcjnIUyqMsEFsWQ7ZhLNnS
 Y/78l5UdZlrGCUX/1d6y9bFO6wcb/ba7JGSwwO12cEUuh7AbUY1w11bIufYSyfZzydWp
 lGXBRK5DdVrlxE5XMGe8eF+g+tdsseA1e7kVhtOGYRxUAbk+Hhr2WZdjW0YTuaxe7Rcu
 h8gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9d4p1ePYUSu0m1SpKBBzb6YLDi0d/xttHMxEk9Nipa/FRXiGS0MnE6k0FlFbSyLSKY8dK4+8=@lists.denx.de
X-Gm-Message-State: AOJu0YwO5afQIzv0n2+OrK1r4FmAQ0tCU/MTzhuKGWaYqIeu9CRJngCo
 MleT9gx9SXQ2ilsRU8CullrBhITPpTAfSMvxE0VD9eSjqtS2oWZn1UF+nHlCRJ/8qiI=
X-Gm-Gg: ASbGncuWIjUnG+DYvlvaQSCNw7aBxC62Kc2S4ITnjoxsydvA/zv2qxlak3GsXi9Qr7k
 5Wua5acdiVWkyDUahhvffQVOpregzUiI/LLMt9DXzmhX5nGbppR0ZG53uk3lt/NWtjaIBVO2BM+
 ZBpBeq+B32D6uaWpZDcFRgBN/PiR+8CV6tyx2wK7LMbH8ZoDcEy5W6nYblYL7kUwinbpgPplzNN
 AbbtGJ2y64Scot2H9ebUpoyr8Py6OK4xV28PC4cs1pJXHQHMzftazrsLpSia2bu+Tz5LP9MYcAU
 xNWZXRX0ItmW0E3E8tXH2W78d0+JOj2W1vd3VSgM2071YilwLvoZRJrGxQu8D60Ke4Y32gnGyeP
 JX4lrJTqFNx2tJjKCEi/Dwi8=
X-Google-Smtp-Source: AGHT+IHmAhcmZpXYDK6oRMqtE1l03Eeysbc/J8hRIWKFH/d3Z+oVyMZTNi31kbJT8CpVzuTup+0sWA==
X-Received: by 2002:a05:6830:490b:b0:72a:b78:1c5a with SMTP id
 46e09a7af769-73878577295mr610623a34.10.1749061874998; 
 Wed, 04 Jun 2025 11:31:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9ef2b1sm2357277a34.59.2025.06.04.11.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 11:31:14 -0700 (PDT)
Date: Wed, 4 Jun 2025 12:31:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] x86: Correct condition for init_cache_f_r()
Message-ID: <20250604183111.GR1382132@bill-the-cat>
References: <20250604130923.1484873-1-sjg@chromium.org>
 <4d363f54-63b1-441f-b64b-a10c47a85edb@linaro.org>
 <CAFLszTi9yEz_JH9uXz8wmfsGJr8cKX2-zN1seX9cDTd+iqSEMQ@mail.gmail.com>
 <20250604172304.GQ1382132@bill-the-cat>
 <CAFLszTgo5nN2KGzsUYoy028i1u9T77JsvPB0Qn+_P-1BzuNR9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h9u7UpTiY46mf/q0"
Content-Disposition: inline
In-Reply-To: <CAFLszTgo5nN2KGzsUYoy028i1u9T77JsvPB0Qn+_P-1BzuNR9A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--h9u7UpTiY46mf/q0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 12:20:17PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 4 Jun 2025 at 11:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 04, 2025 at 10:17:32AM -0600, Simon Glass wrote:
> > > Hi Jerome,
> > >
> > > On Wed, 4 Jun 2025 at 07:15, Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > > >
> > > > On 6/4/25 15:09, Simon Glass wrote:
> > > > > The condition here is reversed, which makes link and coral very s=
low,
> > > > > leading to lab failures.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Fixes 6c171f7a184 ("common: board: make initcalls static")
> > > > > ---
> > > > >
> > > > >  common/board_f.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > > index bff465d9cb2..c8a612d6070 100644
> > > > > --- a/common/board_f.c
> > > > > +++ b/common/board_f.c
> > > > > @@ -1079,7 +1079,7 @@ void board_init_f(ulong boot_flags)
> > > > >   */
> > > > >  static void initcall_run_f_r(void)
> > > > >  {
> > > > > -#if CONFIG_IS_ENABLED(X86_64)
> > > > > +#if !CONFIG_IS_ENABLED(X86_64)
> > > > >       INITCALL(init_cache_f_r);
> > > > >  #endif
> > > > >  }
> > > >
> > > > Sorry for that mistake.
> > > >
> > > > Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> > >
> > > It's fine. I only noticed it because the lab tests started failing (I
> > > have a short boot timeout on one of the boards).
> > >
> > > Do you think some of the conditions could use if() instead of #if now?
> >
> > I'm not sure the readability nor code coverage will be improved by that
> > in this file.
>=20
> In some cases it would help, I think, but I suppose it would be better
> to remove more or them, or replace with events.
>=20
> > And please find the time to reply to my thread about your
> > future in the project before making further suggestions about the
> > overall code base, thanks.
>=20
> On that front, we'll need to discuss the options. We could find a bit
> of time in the next call perhaps, or set up some specially.

No, the first step is that I want you to say, in public and in writing,
what your intentions are. For the public record and so the community at
large knows and can see. Until that point, I'm not going to engage
further with you. This thread was about a regression fix, so I took it.
Your PR for -next was changes that I would have taken anyhow, and I took
as an act of good faith. But that's it.

--=20
Tom

--h9u7UpTiY46mf/q0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAkO8ACgkQFHw5/5Y0
tyw8Mwv7BXVwAUFZPZfkfSXoVGjeN8eEd0fczfXbGlNi0MBSU0gV7Uw3bXqzmSgM
wNKiqvNeqrGtijiIqOYP9wXX8/ny4cDgweo3diYY8Yob9cJK3DZU/Gsr//Ey9Dix
q6F9wcPQkxgeK3LbW8n3QwXpA4XHWOcUAPZNjStfeFA8PdP8Nu7dl2TgX/CaQiAJ
ZU8qj+lc1CmBjVAN2ILJqfX2J3XL7q6aWKIOexmubVPy1lFUKcway1OaWpWPsLzT
68r2gaxz8Hsjvqea/hMfHAdenOElCL5Pa4otrX9sBxu7WnNQ9BM8p7Zsq+WA0Yoj
6DZo9Ue/ThBHm0CZd1SyfjuvGcgPiT2X7B1ePoFW0UPEO7aImU63TwM2e9N5ZV+N
WFBJpp3F6EFeVREAXA8wySLKxPpjcea4WSFkwxkqp3Sd/NtdIQIl3Ig0+/NFDDCH
Tkf9FeodKt3Nj4maiFiAtlDSWppV+nRZCAgSqCGDQzDjEkQkdMJ31R4BqXK4BaDT
Q5HNwL/D
=6HJ+
-----END PGP SIGNATURE-----

--h9u7UpTiY46mf/q0--
