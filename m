Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C889EE7717F
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 00:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA39800C2;
	Sat, 14 Dec 2024 01:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hqI7hsjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D24C800C8; Sat, 14 Dec 2024 01:51:52 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33C2800B2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 01:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dianders@chromium.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30229d5b229so21320481fa.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 16:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734137508; x=1734742308; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AomSg8403BB3GS+1JkKmHvy9TplOplTrujI0p5jopFs=;
 b=hqI7hsjIOgND3kL6hjRREUCNcBqjEeSRiVh4uu/DRtds7zEhdSqlqJgMv85Xrqmyjk
 9m7eiq9q0Q0EhTph54exc38MTeJNB8jxkQybddCnA6Ufvr4eNml37rDc6IFDOKbJTgcV
 nxygsvm7jIsqTnBUGaLp96hLZAf2YghXpudWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734137508; x=1734742308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AomSg8403BB3GS+1JkKmHvy9TplOplTrujI0p5jopFs=;
 b=UnTxZHrkLD0KKAGvf+Bu774TsvbE7cPSnje7LNsqbKD/aqeNfyUdkCuaOoNx60Sun6
 Mem1kofQn/LVfElV+4tHg0wIj5JwCncFuc73hcAVOecN58Ymr20gEP3AvAUfR2BgSwPz
 BI51rg5sXtZkMIk3C8mungW9H03JnkpXMDXikRI9tCTZNrfmJhqTdSwdB4Za90R4A3+u
 8u+VJWiTsn2vRCdg3HqVc308/NxnPfLFmBJx/KcpPiVcy6XdB6MFAA81IpXaCtt+h0IN
 9r0WWuk6/9D0f7ZwnPb4pizLXTKOk7aeuS89FfbR5mB/gjhdLTMTpLZzB17AqBgjPPCP
 rz+A==
X-Gm-Message-State: AOJu0Yw/rmTAdnWjtN7r21GGLOYueMNZEWdGfkLbwNkqFCBlNsNakgDH
 HgebUBk+ig/iYlcmKxImDJJYq52kfquMkS7NeXdx9ITILPysGnKFDHx92PYNtVtEDwo/6K7VfPj
 Io2Bx
X-Gm-Gg: ASbGnctm7hx+1n2Ex4cWkOpDM6U9h0KNRa0lh6hX6uQMzesONWnkdpR1ZX9YA1FUBUX
 MgYsY8CwSMiBnzWZ4uu6xdgAh1+IcnQ+SVzE0DFmXnoAGM8yvDkmm8817Vvsj1UO6hEOx3K8UXJ
 YfQIcCuVRsuNygQBILp9uOIEWuKa1mJdju9pThs1QnUVHtRsIHoNdSRfp2xQtTpPR/wy5tLfZbZ
 rIPrXqZlv5+YxVp9C9mlVoa7gi/XHCtNAqAaHDvX4bSR9ZnoFo80q4CQo8T1Gw/W60Sj9xFmXvK
 jpbdl7O4jOqLTHaKngRc
X-Google-Smtp-Source: AGHT+IGUaEKbz8BzBiP90puktGHdJMOK+i6OtIF9O4IhpPqrs72/jyFNuUv3eDCowyosrdReOHKW6A==
X-Received: by 2002:a05:651c:551:b0:300:1d91:c2bf with SMTP id
 38308e7fff4ca-30254517948mr11745261fa.41.1734137507797; 
 Fri, 13 Dec 2024 16:51:47 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3034401d3fasm752691fa.4.2024.12.13.16.51.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 16:51:46 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-54024ecc33dso2523566e87.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 16:51:46 -0800 (PST)
X-Received: by 2002:a05:6512:2356:b0:53e:3c3a:2032 with SMTP id
 2adb3069b0e04-54099b72f79mr1458774e87.57.1734137506146; Fri, 13 Dec 2024
 16:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-4-seanga2@gmail.com>
In-Reply-To: <20240419023632.29078-4-seanga2@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Dec 2024 16:51:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X1W1dh0zDB5KqPTD8-UmVOfn+QaSo3PLOWwpAaSZi+0A@mail.gmail.com>
X-Gm-Features: AbW1kvbS9TaVeDvVcgEBImoJPWCAdO3roHuoRsn6vtvhOXzmFOWN3p3Zg000Z8Q
Message-ID: <CAD=FV=X1W1dh0zDB5KqPTD8-UmVOfn+QaSo3PLOWwpAaSZi+0A@mail.gmail.com>
Subject: Re: [PATCH 3/3] patman: Add a tag for when a patch gets added to a
 series
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Thu, Apr 18, 2024 at 7:36=E2=80=AFPM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> When a patch is added to a series after the initial version, there are no
> changes to note except that it is new. This is typically done to suppress
> the "(no changes in vN)" message. It's also nice to add a change to the
> cover letter so reviewers know there is an additional patch. Add a tag to
> automate this process a bit.
>
> There are two nits with the current approach:
>
> - It favors '-' as a bullet point, but some people may prefer '*' (or
>   something else)
> - Tags (e.g. 'patman: ' in 'patman: foo bar') are not stripped. They are
>   probably just noise in most series, but they may be useful for treewide
>   series to distinguish 'gpio: frobnicate' from 'reset: frobnicate', so
>   I've left them in.
>
> Suggestions for the above appreciated.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  tools/patman/func_test.py                           |  2 ++
>  tools/patman/patchstream.py                         |  5 +++++
>  tools/patman/patman.rst                             | 13 +++++++++++++
>  ...t-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch |  1 +
>  tools/patman/test/test01.txt                        |  1 +
>  5 files changed, 22 insertions(+)
>
> diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
> index 3b4c9448882..af6c025a441 100644
> --- a/tools/patman/func_test.py
> +++ b/tools/patman/func_test.py
> @@ -293,6 +293,7 @@ Changes in v4:
>    change
>  - Some changes
>  - Some notes for the cover letter
> +- fdt: Correct cast for sandbox in fdtdec_setup_mem_size_base()
>
>  Simon Glass (2):
>    pci: Correct cast for sandbox
> @@ -342,6 +343,7 @@ Changes in v4:
>  - Multi
>    line
>    change
> +- New
>  - Some changes
>
>  Changes in v2:
> diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
> index ec1ca874fb2..a09ae9c7371 100644
> --- a/tools/patman/patchstream.py
> +++ b/tools/patman/patchstream.py
> @@ -477,6 +477,11 @@ class PatchStream:
>                  self.change_version =3D self._parse_version(value, line)
>              elif name =3D=3D 'cc':
>                  self.commit.add_cc(value.split(','))
> +            elif name =3D=3D 'added-in':
> +                version =3D self._parse_version(value, line)
> +                self.commit.add_change(version, '- New')
> +                self.series.AddChange(version, None, '- %s' %
> +                                      self.commit.subject)

I won't have a chance to track this down right now, but I figured I'd
at least report it. Maybe it's already been looked at?

Once before when I used this I saw a case where using
"Commit-added-in" was doubling tags. AKA I end up seeing:

- New
- New

When I came back to try to look at it later I couldn't reproduce it.
I'm seeing it again now. I did the bare minimum to debug and I see
that the code in process_line() is being run twice for the same line.
The first seems to be in get_metadata_for_list() and the second in
process_stream().

I can do a quick-n-dirty fix for this, but presumably it would be
better to dig into the real root cause?


-Doug
