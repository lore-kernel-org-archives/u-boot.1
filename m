Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A922E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6614A89506;
	Thu,  5 Dec 2024 18:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JlNps6Yq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4D489338; Thu,  5 Dec 2024 18:56:55 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF9C89506
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa5366d3b47so191239266b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421413; x=1734026213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xA/TCECQCsTv0iIWWeeOyZQCfUITDS1lPS+rkq3bnzw=;
 b=JlNps6Yq/yXpzHdOok2xDbCRDQfhSC6DtzdRldWzp/hWbvyp/MPm2t5ZXmHSY1GIzF
 p2i4yJJgTGoPVM6pu6tvdnlNfY83XFYsIV2m8dKeTR55AAEjY0gB15lRK4ejJxo/t0w1
 mWQy8xH+67MCDTEwe035GervEr2qfHxA14xXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421413; x=1734026213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xA/TCECQCsTv0iIWWeeOyZQCfUITDS1lPS+rkq3bnzw=;
 b=UI8OxNlb4LDSyW2qE0Xf69GkvcQ8PCFzAxm6cH+442KeljYZrWglewuFgItjNm+OGE
 VJk9JK/7OEqAd7V6xtKyLqlJj3fTeYkc3lkI0ZtW+oQsUeeXYRuKJx92mkzNuhe40sce
 K6YUbtIEa8rgF2gyRmO5LX2ft1tHnVIy6++Pan6MbJYkOyNqAtZhuA3b55+U0Grz9Iam
 086IjbiJHtYAEZtPd9htBeo2AL5Y9huogkknPoX3Uu6lX53sQ8+S17Dsrb61Xan1HhVP
 nmnGQI30nnHxS4Rp071XvQS/tRdbQNA/wVZNjadrk+tZWY4h7zbFC0TCmzCOHaNp9eJD
 k25w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs9YTPv/w4FousfFVQzT9OaPD+i1J8G7E/dQq+mQ1olt9nPm4aa6SUdYwAIZVW02Yk5y6/pTw=@lists.denx.de
X-Gm-Message-State: AOJu0YwgK/IvL5X/3lfhlxL96w/ysst7heSuaIjMYaPAxF5qlB0jTgVB
 +fUbFfCL9k7RD9layBc70rTcS+ff3NmVtNlb1VOJtJW3o0vZ3LoR5iKUmaIgMebb64TbnRVCM0C
 OCoJmypr05aYZiDM8oCIToTsQhfJSEMdOgUKn
X-Gm-Gg: ASbGnctLHhZcOONI0JWqCuh3ql7s1CCvjI+QRH/kj3NMIGzW2WjB3tcGtleN4vYReuu
 WvZ6vOjuD8/7iHYqvpJ24LZANbSjPpjYd
X-Google-Smtp-Source: AGHT+IFgoaFXdU8JcGUY0M086s3mSn5AH8xG3Z322PPVQr3Q49fj+FgEEUKILm311WUE6AMKaJmJ3tfiGk6CINHBOS8=
X-Received: by 2002:a17:906:9d2:b0:aa6:21ce:cde0 with SMTP id
 a640c23a62f3a-aa621ced023mr374088166b.12.1733421413016; Thu, 05 Dec 2024
 09:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
 <20241203140133.GT2457179@bill-the-cat>
 <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
 <20241203160131.GW2457179@bill-the-cat>
 <CAFLszTgx6BacGQyiMOoCzYDM3vsOBgfr2XbzBEsNOZ_Gzj3=ig@mail.gmail.com>
 <20241203165132.GY2457179@bill-the-cat>
 <CAFLszTiEk64zKzVEK06diR8=expsWWqxjV_Jx8FQ+RwpiSBjsg@mail.gmail.com>
In-Reply-To: <CAFLszTiEk64zKzVEK06diR8=expsWWqxjV_Jx8FQ+RwpiSBjsg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:56:40 -0700
Message-ID: <CAFLszTh8PCDM5P7TWPfSYnEcC4hNiQyP4HpyzLZermSNnt+e5w@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
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

On Tue, 3 Dec 2024 at 12:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Tue, 3 Dec 2024 at 09:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 03, 2024 at 09:37:34AM -0700, Simon Glass wrote:
> >
> > > Hi Tom,
> > >
> > > If you like, you can apply the reverts first, since they break boards.
> > > That should not be controversial, particularly as I explained at the
> > > time that this was likely to cause problems.
> > >
> > > Then you can leave the discussion on OF_BLOBLIST open.
> > >
> > > Just a thought.
> >
> > Absolutely not. Again, 70fe23859437ffe4efe0793423937d8b78ebf9d6 says:
> > "Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work."
> >
> > And your new patch says exactly the same thing, but then:
> > "Note: This is the correct way to deal with bloblist, since it allows
> > boards to choose whether they want to use the devicetree from there, or
> > not." and a large number of patchwork links. And after squashing the
> > three commits together to see what's being changed, yes, you're
> > rewriting a whole bunch of the logic without any explanation of why. It
> > seems to fix 3 Chromebooks and isn't tested on anything else. This is
> > why I'm saying it's unreviewable.
> >
> > So no, at the moment I'm inclined to wait for further reports of
> > problems, and we're coming up on a year since 70fe23859437 was merged,
> > before making any sort of last-minute change here.
>
> OK, thanks for confirming that.

We could of course imply OF_BLOBLIST which would still allow my boards
to work, by disabling it.

The opposition to this patch is mystifying to me, particularly as it
seems like a clear mess-up.

I'll apply this to my tree for now. It is certainly correct.

Regards,
Simon
