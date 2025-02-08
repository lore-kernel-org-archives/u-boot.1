Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B821C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 22:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7D780805;
	Sat,  8 Feb 2025 23:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ESD+gTKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3665680821; Sat,  8 Feb 2025 23:38:26 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F379807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 23:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dcdb56c9d3so5129494a12.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 14:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739054303; x=1739659103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VSSCH++oGAuscpyKoBJxdP1EseQ1QqnEfa6I9vRoGN8=;
 b=ESD+gTKqEIjnKc3Lf5TSr1fWI+N57YJLgyvGb78kTL84ZqIL6P8W1wvA2RK+DiIF58
 U6r2oGG/Mm+kHNTK6Eg1sPFKrm12/7xfavViXkRg32Uy1N52Lk2V1B44G7dMYeTD32JQ
 ZLn/TMyVTkRLxjr/5uSxtU84/AFYT3vRBaA5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739054303; x=1739659103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VSSCH++oGAuscpyKoBJxdP1EseQ1QqnEfa6I9vRoGN8=;
 b=d6u/hyuaVqf1EnG6IXHWdNkn0/y36rHbKvLkxP9cv7Byt6b7sxm591RqLXd3wIVXgu
 ad24Ez+6m/EAEtyxyt+JUDscw28zXTwuQ+4tOSXonaiiBRnZpQu9kKh+6YeAN0A5OATJ
 INaQJ+l89RAQ8WjIlEkMCJ0IFkKxqZ+31xlY1VEZwnbYl1vDwx6ruKs1lWRiS18iKcw5
 kfhDQ6n2pk5J04h1TNFv4vlAM9GO5TT3X6Pi3UjmacLFI7U7alh7iOZZd89YNSQrYsrD
 z+ftskong9cF+zeo8ahhHkt/ops1QLyzHCJkypQTqciK3BXU5obhLNWxwpAmZJOeY919
 opFg==
X-Gm-Message-State: AOJu0Yz8gLABYIAuQeNqGF+KZwWZsOyvFAYeC69NdD4cUO8XO8245mZF
 xUk7DX9/q6PXNGjyPrxMjON6jq/K5H/S2rsAqUm1gYyV5iTVj0iq7E0Pxyrn9mjQUue7ARg0Ywb
 v5lguP6P44sug98XeJOCcvjIvvsekbC90QOGq
X-Gm-Gg: ASbGnctb6OFxjRc3R2EhgpaHZLzMml5mkEAO0XKKTEs5SygSyP8gjxt9NlFqa5a4LD8
 +I82n4bMKYwQnpRTHonzEeWIdv5cUyhHvIPLFRvhT5qRfLfRG7gXfC4FGe7tgnqiSRT4JcidB7g
 ==
X-Google-Smtp-Source: AGHT+IH/Au2vLxJ6Qmp7rp3a6xrq5UAvjONfSXl8KKS1G0euVhW93ZfHUnRfupy3y0vTWrEtGDrLSrk/rDjKUcDF/os=
X-Received: by 2002:a05:6402:321d:b0:5dc:cfc5:9324 with SMTP id
 4fb4d7f45d1cf-5de4508084amr26597455a12.30.1739054303575; Sat, 08 Feb 2025
 14:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
 <20250205135232.GO1233568@bill-the-cat>
In-Reply-To: <20250205135232.GO1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Feb 2025 15:38:12 -0700
X-Gm-Features: AWEUYZm0jbzXcT59s7BtaL9ZgfAIRnvP0mAaQVOOMoxplccKdoka95PLvJBk5ds
Message-ID: <CAFLszTg_vYrNRzWWAJbNDifZyv=4NwpBFBa4q3jdtcQ7GLOmyA@mail.gmail.com>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Wed, 5 Feb 2025 at 06:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 04, 2025 at 06:55:19PM -0700, Simon Glass wrote:
>
> > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > removes access to this memory, the best option seems to be to relocate
> > the bloblist just before running TF-A.
> >
> > Add an option to select this behaviour and provide a relocation address.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/Kconfig    | 20 ++++++++++++++++++++
> >  common/bloblist.c | 15 ++++++++++++++-
> >  common/spl/spl.c  |  9 +++++++++
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/Kconfig b/common/Kconfig
> > index 0e8c44f3f74..962e7fd76eb 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
> >
> >  endchoice
> >
> > +config SPL_BLOBLIST_RELOC
> > +     bool "Relocate the bloblist before existing SPL"
> > +     depends on BLOBLIST_FIXED
> > +     help
> > +       Some platforms locate the bloblist in SRAM in SPL. In some cases,
> > +       the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip RK3399.
> > +
> > +       Enable this option to make U-Boot copy the bloblist from SRAM to SDRAM
> > +       before leaving SPL.
>
> Isn't this because TF-A is (re?-)initializing SDRAM? I'll let one of the
> Rockchip people chime in here, thanks.

Not so far as I know. The DRAM init is in U-Boot on this platform.

Regards,
SImon
