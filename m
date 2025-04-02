Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB11C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE4581FC8;
	Wed,  2 Apr 2025 21:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nE11GYlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5EE981FC8; Wed,  2 Apr 2025 21:19:18 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D9181E6C
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so16879066b.3
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621556; x=1744226356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vjzDTnWYzxsPLpfkJ0tS3AYhL0wCAWjeVV03qqcuEn0=;
 b=nE11GYlmcudifgD8T4ZKHO8KtS8v9WssiWG4gotpBpa8iIjy8Np2X+4qFsrlzLtx9M
 MMh+GqadMI0A7WWm4gwoLs3TI9SKBhfKA5tmOd6LEroxeRBx6i5OjLco1bJvt3n6kQWn
 bRKJhuawM/fskYF1HiDaKGD8tRehFIoix/iXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621556; x=1744226356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjzDTnWYzxsPLpfkJ0tS3AYhL0wCAWjeVV03qqcuEn0=;
 b=B+P/8ozSrCBF90i7r36Gx0B4Yz83Xqyv5hRfIH2GqlNXgWGDYA6SpzKMMQQ+qicGD2
 WXJdXgUUouuhNUwsPVtVZvtwN6IIhD4TPz8/BmUywva8dwLJsJiijVGLAK+BXciAyNRd
 NH4QKp2RKtxYMhs9bFqKfLX7PI4dd6O0ENRyX91o/sDrNA9JUaD4/4bZRdBAjBypqDF9
 LVjp/JjfUxFt6qJ/PcSDYmO0QG9VFAF/SOKExwlDOap8HK5FkS1YCIk6IvWAheKMLnS+
 zgXMR1GXo82su+26H41W1ib6oMZ1EYhmtxTs0QcJ07tZu6yf22U4sq5PjMyPzP2QfK63
 HSXQ==
X-Gm-Message-State: AOJu0YzpCE+kHm0Xm3EeLJXR+tI4n3sPpbPtBqlPvEdOuup35b0BdPhT
 HbwcGjCF1qVZmCBificBprEcHbOpwh7M82ktxp6TA+1zLbXLC9vIniCOyY3tz0dpDizQWy7kTJn
 o5ey247oVxjCGxMjZweKxhFJrvbPqEJH6rDiI
X-Gm-Gg: ASbGncua75QqnDnmsNiVTGQ4jOzVB2PtVCVR4nNwTAD+EIDNWJl1tHWizHGLGkVqQ/d
 A1dBtabIKuDV5OtzQ5W86jL/M6heSnUjkI26MUj8oTJRD9iUK3LCug+1pNRMvYobGzaHFQhCSAn
 3ZqpD9hhtuwbNA1uhjz41X708OsDtV
X-Google-Smtp-Source: AGHT+IFZ9u/JK+rTz83Dbw0CLnwCBmogeOzNSn0kA4uPfA/2wyan5AjVmjWql3bQHZTsMa2vLA+JNjeFoj6tHq629dY=
X-Received: by 2002:a17:906:d551:b0:ac7:333a:a5bb with SMTP id
 a640c23a62f3a-ac738bac9b1mr1627575166b.39.1743621555764; Wed, 02 Apr 2025
 12:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
 <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
 <20250402150024.GU5495@bill-the-cat>
In-Reply-To: <20250402150024.GU5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:19:03 +1300
X-Gm-Features: AQ5f1Jpwt2MqynsrHErKcNXzNkjPC_XMNalZBZZ12F2f_WYNRRXEarv4YKpPz9A
Message-ID: <CAFLszTh-N2PSKPV_OHa63mEi1ar6Y9+p+A4UTfTbf329wOiN9w@mail.gmail.com>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
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

On Thu, 3 Apr 2025 at 04:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 01:08:56PM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
> > >
> > > > This series includes some precursor patches needed for forthcoming expo
> > > > enhancements.
> > > >
> > > > - truetype support for multiple lines
> > > > - make white-on-black a runtime option
> > > > - support drawing a rectangle
> > > >
> > > > This series was split out from schd2
> > > [snip]
> > > > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > > > branch: schg
> > >
> > > I get as far as patch 4 before it doesn't apply to -next.
> >
> > Your tree is missing the video-damage series which adds some more
> > tests. It is here if you want to pick it up:
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=369663&state=*
> >
> > I can rebase and send a PR if you prefer.
>
> Reading the cover letter again, that doesn't seem ready to merge either.

It seems OK to me. What are your concerns?

Regards,
Simon
