Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2CAC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFEB81FAB;
	Mon,  5 May 2025 17:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oDkk/vDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A38DD820E8; Mon,  5 May 2025 17:35:16 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66671801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so802050366b.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459313; x=1747064113; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WkTXJQXUXq9XAQD+nGjK/mUDZb6r3hjGgp+gY3ANU5U=;
 b=oDkk/vDWhKhKQMQe0q1irQffQSKbID4M4zU2YBGTPuOT7o3fQ7+/96rUHO2oaRcozD
 fIyFda7gRL9TJf/S+SqBgVosvtgVcgULlRdKEcPiiCpDmbe3xUpXGtb2+VVONJZtK/0V
 Ot/XOGemATs+1XMqsIqU2ytjbrLeg+ZPKoc5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459313; x=1747064113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WkTXJQXUXq9XAQD+nGjK/mUDZb6r3hjGgp+gY3ANU5U=;
 b=iZ9LuZ60fPXzV+3nf9b5Y8YihUX/M9lKaCvwJ2JNpBiJI4454UxSAEW7aF7hpe4FhC
 K5UZk3hj9IDzmjNBWUsZ+M2lQ/0PDUBJbMYh1XZaKQq1WuCYJOHWFTLkuYvGBeIrIqf+
 bD7u/E0PCSLbkNbcJk/UROOkyIyIi5h/WVf3UF86xnwelAPAq+L8wpJ5pH3TYI0cmqTV
 WmtCHej3EdVNnEvqvD75ulW8ZfeAsQafoFutdvKhOkPhbZvocFilAoyTIhhSfL/vffl4
 XSv4VodQDg+L2DGSD/XiBUAmkZQeyNDNcUTB3qPY/QVfhmaXdcEDxlihWFPwq4+M+pEQ
 zfTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcF3r/pzQSW59L4o7IeVkqmGWEkjLUwZu83aUZfAz64RhGvsX2vPDNYtx4esa405SgEzRikQc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4VJqTR6OQnR7WxTTRyeGwDdvabwU7Pfft7KGb7aEN/y60Hz7q
 HwQYsMafTxM5vPa6gIbuXN7q1jTiB0MdibRGhVPOFOAOiQhuzcHnZc3bMRYLY6EWTLJBdJgnKCo
 oeZ6juXx4dxqyKRkf0/J/SOvQSlYe/1FGH5Dz
X-Gm-Gg: ASbGncsACWdxpLEY0RW6oSQayPTDkT3xbpItDvYKLWC9hYMif0LOX5h3WfKcXirk3YX
 qVBQYhUxwNFAi4qxemFy4mnJ57jk7bOW+R80NYkhhQSiDsRpzpCOWwgq9QODSb/hDoK2AnGc/kw
 lE79UUQFZqO+ogyNNKP3RHuho=
X-Google-Smtp-Source: AGHT+IENDgLtpUApN5ngR0TgrdA/dA9bpaZ9QRs7/PGyw4iNAF9XgvOfswzTSxXkKJdRcLBiqvqlPMMOOyJKjW+P5TA=
X-Received: by 2002:a17:906:2c44:b0:ad1:d063:f326 with SMTP id
 a640c23a62f3a-ad1d063f37emr72546366b.29.1746459312710; Mon, 05 May 2025
 08:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250502025026.4140184-1-sjg@chromium.org>
 <0e3e24ac-a4a2-4b44-8c13-d47a655ce7ee@linaro.org>
 <CAFLszThha_WkVyCVxwm1dqvbFaiyxw+khuuyfZKgnoVkHJk-eA@mail.gmail.com>
 <20250505134542.GH1261075@bill-the-cat>
In-Reply-To: <20250505134542.GH1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 May 2025 17:34:58 +0200
X-Gm-Features: ATxdqUERwqSNeaSz7o-Oj5uD0Nyz0nVGawhduCzqojMouP4FaDFQrBoioaqW-t8
Message-ID: <CAFLszTjeyMUE4aLnzUdRwWPgUVnPtNj+F1FBsYJuO2CqOTe_EA@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Mon, May 5, 2025, 15:45 Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 05, 2025 at 02:58:06PM +0200, Simon Glass wrote:
> > Hi Neil,
> >
> > On Mon, 5 May 2025 at 09:06, <neil.armstrong@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > On 02/05/2025 04:50, Simon Glass wrote:
> > > > During a recent discussion with Heinrich we discussed why the hooks are
> > > > kept in a separate repo.
> > > >
> > > > The amount of code is small, a tenth of the size of the recently added
> > > > lwip, just by way of example. Testing is a critical part of U-Boot and
> > > > one of the things that distinguishes it from firmware projects that have
> > > > not kept up in this area. By having the tests somewhere else, we are
> > > > signalling that it is unusual, or difficult, or optional.
> > > >
> > > > The hooks mechanism also needs something of an update to take account of
> > > > real boards in 2025. That will be much easier to undertake if the code
> > > > that test/py talks to is in the same repo.
> > > >
> > > > This series brings the hook files in as first-class citizens of U-Boot.
> > >
> > > So this will definitely remove the ability to have test hooks out of the
> > > U-boot tree ?
> >
> > No, not at all. I think Tom had the same thought, but I'm not sure where it
> > is coming from. You can of course put the hooks wherever you like, since
> > you have to specify the path for them anyway.
> >
> > >This is a major regression, and I do not want my test hooks
> > > to be in the main u-boot tree for plenty of reasons, the main reasons is
> > > that I need flexibility to handle my lab boards and I can't wait multiple
> > > weeks to have the hooks fixed in the main tree.
> > >
> > > This could be enhanced, but I agree with Tom, it's a bad idea to merge
> > > them in the main tree.
> >
> > Are there any other reasons, beside the misunderstanding here?
>
> I don't think there's a misunderstanding here. If I follow what you're
> saying, you want the hooks to primarily exist in the main source tree.
> Yes, of course someone could maintain them out of tree instead. But
> that's adding pain to that set of users.

People maintain them out-of-tree today. They can simply keep doing so.
I am not sure what you are getting at here.

> And I'm not sure what the
> benefit is to anyone else to move them in-tree. We're making the project
> CI path a tiny bit easier (but for what is also a small case) at the
> expense of all of the other cases.

Did you see Heinrich's email?

>
> If we must save two steps in the case of testing new changes for CI, we
> could add the u-boot-test-hooks repository as another git subtree. This
> would make it easy to test new CI changes at the expense of making it
> more costly (a git subtree resync) when we want to update the hooks
> repository.

I don't see how a subtree would help though. It's not as if some other
project is using it, upstream of U-Boot.

- Simon

> --
> Tom
