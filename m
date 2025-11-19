Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B6DCF58C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E3E8403F;
	Wed, 19 Nov 2025 18:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JpLSg+GE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9406A8006D; Wed, 19 Nov 2025 18:35:12 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7048403F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64165cd689eso1741612a12.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763573710; x=1764178510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dGkioxFHRPKCwT64Hx8u0yZA0ltayog6qdb9aVGfuGo=;
 b=JpLSg+GE5DNlt8gesbHByNP2OXUIcnMRahlyu4ZFLl179bglW7Hf0fCksnPrvmkCdh
 QNvqOJZK/niPRlN+cL79YfmKv3D11plXhGYHEg7XHxUw3oMxuEgLJuSN48Wl7B7DyWII
 xTppw5iBVF9w2jZyTGOR4rAGZvclvdxsHzk7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573710; x=1764178510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGkioxFHRPKCwT64Hx8u0yZA0ltayog6qdb9aVGfuGo=;
 b=Scc1dwdFPKXGJHr/obTd2YmOEvkYhYxePW38MrF2aPr3vOREIqGX0wfWHh3blzD1FI
 fYfVviR6SPGSbIIkXtcdbMKmWn8z5ELqYdwAir9nuTNbHYkhDSN/QMAbrFyy5qIZAbI7
 gS+BDsfsttFBbNDWdIPTqOVRC3pe9uwi1QXfr8lcxyNTvvsUQ2g1fDiRK+5+EgYdey+K
 fKRYtIYaBofYkaMAaReN5UcI8uNFJNTTri6NtpewCj5smBJNz9qihIo4Z5IIZKd1YLlg
 VMg57yw/vN1Mtsmu7Sd+0UxzO59NDGXpc8maLTrSopp+8QJov0Stpl+D98Otnjtd5U9z
 4iZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFlXvfqclBwgdmk4bX+xexK6kWbDI+2jl+MCQt0jmb7rLPaJ1J1+Z1K8Trg3iBJKgeQE9bAmk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzxc1A7NlkWzITrFjbAXLLOGJAuxEWvU8YebT41rN3i3sxpElXo
 widcUmoxOfnBuKZBLHSWYEYZ0CWIiae+BCCarZrdGxXdTIFHHIYXlMnRiyukdO8RkSfBRj5ir8p
 1CQBCxh3AE0Gkz0US2S8bLJIPzyVY1+JU5hnBHNb7
X-Gm-Gg: ASbGncu+o13iYI7GK381O/zlp7/sky22DVSg5xZzIRoBYik0P2+0g6kYdZ8kz0H389T
 jK9las+S60d01ng1CsQdLA48dVTHC8pgEC6RN61+ymsAvdEXwewle6Q0U+ysY3h4DryObJxGUnn
 GoVcy7v5J/vpPRDqVrDBJtfiOzkM+Vu3jkBOAeSjEn4TxgIRVt2ilE3tnAlNxc2gK765+v4jXr+
 tdD1TOSjqgY8wXQawIL0nR92EzEWnmniVOrVQoJm9rxDHzuRSwcPBkG8DBU1Q4Q5VMbGA==
X-Google-Smtp-Source: AGHT+IHXHu314/E8VzOnDuWXSQu3diP+rqgg50uwVEk+g+aIWNQvFlHxMUPVpjZ6M9aT0rEbl9WWMl7P6iBD3+ZNXu8=
X-Received: by 2002:a17:906:fd8c:b0:b72:671:b2a5 with SMTP id
 a640c23a62f3a-b763810bf7dmr391494166b.3.1763573709835; Wed, 19 Nov 2025
 09:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-2-e053f683c0b8@cherry.de>
 <CAFLszThkqMi5jxWArGrqSfnMnX5P-RbHW5Xc8_GEMGjmPhyiVw@mail.gmail.com>
 <0b433974-8557-499c-9d48-c4ad2df9c9d5@cherry.de>
In-Reply-To: <0b433974-8557-499c-9d48-c4ad2df9c9d5@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 10:34:52 -0700
X-Gm-Features: AWmQ_blVRF2kTIqzQtiLiTrhfSXvpoDWmVi9MpRwtG9Phr3YAm-X3BWRHpaCiYo
Message-ID: <CAFLszTgsCaC1VTK8bA9o-VJ0Hz-wKfhZ-bZkcgpiH2OAGj1SqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tools: binman: mkimage: add support for passing
 the engine
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Yannic Moog <y.moog@phytec.de>
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

Hi Quentin,

On Wed, 19 Nov 2025 at 06:46, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 11/19/25 2:16 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 17 Nov 2025 at 12:43, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >>
> >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> mkimage has support for OpenSSL engines but binman currently doesn't for
> >> direct callers of mkimage (e.g. the fit etype). This prepares for adding
> >> support for OpenSSL engines for signing elements of a FIT image, which
> >> will done in the next commit.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> ---
> >>   tools/binman/btool/mkimage.py | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > patchwork seems to be done, so I cannot try the test coverage
> >
>
> b4 shazam
> https://lore.kernel.org/u-boot/20251117-binman-engine-v2-0-e053f683c0b8@cherry.de/
>
> should do the trick to fetch the code easily and run whatever you want
> to run locally.
>
> I only tested 4/4 tests individually (you cannot actually pass multiple
> even if the help text claims the opposite). The pip dependencies aren't
> installable on Fedora 43 (or Debian Trixie AFAICT) because the libgit2
> dependency for building the wheels is too recent compared to what's
> expected. Anyway, building in the same container as the CI and repeating
> the same steps, it seems that my tests are actually breaking other tests
> now when running them all at once, I'll check. I suspect something
> related to the environment variables persisting across tests.
>
> I'll run the coverage test as well, thanks for the reminder, to see what
> I can do, we're most likely missing the check for fit,engine +
> fit,encrypt raised Error.

OK thanks, that worked. It looks quite good, but you have 4 lines
missing coverage in fit.py, from what I can see.

Regards,
Simon
