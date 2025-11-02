Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF995CCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D1A83923;
	Sun,  2 Nov 2025 20:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a1pqKbXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09DE8393F; Sun,  2 Nov 2025 20:54:39 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D498391B
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b710601e659so11733766b.1
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113277; x=1762718077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VFUA/GQy3dLpiUoFT0nFX8E7STcUaHUYoFKhLwUJUZ0=;
 b=a1pqKbXE19bza++BHqTWiT9otBA+9RfT1axvCOk3fa45pUS5dzfCeQ0gWOKIr/1fY4
 HVXyYqHfTwbMWhYKd86hPt8Zl/B+eaBNL9fXgBFm4JcJe4MLYavlljFKwehgzBIaCc66
 AR7CmjIhuwjDQPVq6h2j79Q12N2Aray15pHsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113277; x=1762718077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFUA/GQy3dLpiUoFT0nFX8E7STcUaHUYoFKhLwUJUZ0=;
 b=GP3Q8h3F6ALCf38VoBJZRQHKUv7IW1TUXSp0obHwIw/eBgmBF+D7esz6EpqZl1g51E
 hQKNym3MRKUkCJ/G1xB5HDhYPaZXz+TsjgclnIwvgBn7zi7yqI6j/RrAoLlQXpjBFY/t
 K5AIBBzPaq3Ip0WwK8uvQ4fFIasG7f3bLMmCh5ZxEduoPQujftZG80wK1r7qvZWcbmMd
 WXuw7tWFkgdvZFTHfyIDZt02jwNZkq0cTjMdmr3negtjyHwHSSYuGacXcue/Ay3NVFCE
 W/QIxJ2XQ4dy3BXKlLjG2A41ax4fZo7nwW42TCtNOGAXf7CPFIlBt3/nMfEbYi7PEZC1
 6org==
X-Gm-Message-State: AOJu0Yzpvgv22l1IxsCRSE20WgvDBHCC5A/Eac7Ep/sicoyFd1yUZE8y
 v+037e3fKwTRmiLUHZ3oEHqtYwjYkvTogBk3pH0CrJKfDYCufGWTB4Q8XOwAT1x57+O9L72fTuQ
 kS2IwWrjPAE5gL3t9xYf1P9p1TOxqJCy6xf5WUG+W
X-Gm-Gg: ASbGncv+T0kct/TuUSkfaiCCjeXtDvEgHkGNG0BLQ0M3jx81O4QoB+Tbk8E9hRTuqed
 49J3GSbRQz9DlgJaZ9sGUvwVe4Jgbb7/vR9WdlpxTntlquVuHJns85/zrp4MchW/4DL8nCL9eo+
 rxxOH1c5BugsNpsTYjtvZvoE6/6oHoHYCffFRRlOzz+GVH6hcaJXL3KSvLWRS3OnjTkUbuq5DLJ
 C1LjV7PAJsrxsLUSSF8NpgRpCW3f5zD2DQa35N7Ffa/gETXR4gnZC/CKTwE7RpVPArKkX4/WHR7
 ykfy86g=
X-Google-Smtp-Source: AGHT+IFpuO7HBzlYfEirDSNvmcEo480K55tGg1aOwQB+tgeymYj1xlkdcerqKm567uCjsLLVur3me9IVVjf70Z72row=
X-Received: by 2002:a17:906:730b:b0:b70:b83a:73ea with SMTP id
 a640c23a62f3a-b70b83a8c80mr185302766b.55.1762113277285; Sun, 02 Nov 2025
 11:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:56 +0100
X-Gm-Features: AWmQ_blZtzHy3qF3FAGDzsylhH8mbrFoxAoRMGMLqg3yOk1X-mSu11j9-SUm-fw
Message-ID: <CAFLszTgKWU7mnFdXAOX7rH8jcGs3QrEVy=49om49=FbdNj1q=w@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools: binman: mkimage: add support for passing the
 engine
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 31 Oct 2025 at 16:23, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> mkimage has support for OpenSSL engines but binman currently doesn't for
> direct callers of mkimage (e.g. the fit etype). This prepares for adding
> support for OpenSSL engines for signing elements of a FIT image, which
> will done in the next commit.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/btool/mkimage.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Please make sure this is tested.

>
> diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
> index 3f84220fb1a..79a8f887795 100644
> --- a/tools/binman/btool/mkimage.py
> +++ b/tools/binman/btool/mkimage.py
> @@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
>
>      # pylint: disable=R0913
>      def run(self, reset_timestamp=False, output_fname=None,
external=False,
> -            pad=None, align=None, keys_dir=None):
> +            pad=None, align=None, keys_dir=None, engine=None):
>          """Run mkimage
>
>          Args:
> @@ -35,6 +35,7 @@ class Bintoolmkimage(bintool.Bintool):
>                  signatures
>              align: Bytes to use for alignment of the FIT and its
external data
>              keys_dir: Path to directory containing private and
encryption keys
> +            engine: Name of the OpenSSL engine to use
>              version: True to get the mkimage version
>          """
>          args = []
> @@ -50,6 +51,8 @@ class Bintoolmkimage(bintool.Bintool):
>              args += ['-k', f'{keys_dir}']
>          if output_fname:
>              args += ['-F', output_fname]
> +        if engine:
> +            args += ['-N', engine]
>          return self.run_cmd(*args)
>
>      def fetch(self, method):
>
> --
> 2.51.0
>

Regards,
Simon
