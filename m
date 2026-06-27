Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5A9C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 18:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA195841C2;
	Sat, 27 Jun 2026 20:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y9d+Odms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A790D842FC; Sat, 27 Jun 2026 20:51:21 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A44B83FEE
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 20:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-664a09bc459so1844487d50.1
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 11:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782586277; cv=none;
 d=google.com; s=arc-20260327;
 b=crVu7KFKm+VirW2r1YtgJ0Fw3+mKDWc9ofyaG+dh6HZLP4xgruKyCt/UR+ywyWDRtF
 0iJe6hew1MifD35yFTDBQMBlJB2W34ZV3rojT3glpVOd+O3WkjEBKUYUujoNwwK6qQUb
 ilXkhtoNrDzaGUCGw2OtsMjl/cfE6h+AqUcgGkSay38ualbSGli0mROcHjSMapX8xhAH
 W2cdtKy4h4BTqbKb/CJgHA0zFsfUPriH9xSOVpY7grLSo8TZEfI1r1XPvez7opu8VPhY
 rONT7KXErY98VHhCIai0S008hPUWTMzcsGiGzTOdZnE9N5anczOcCuZKnBR49ZSuvCFk
 HU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u9XvXIhligjR/ahcRSMTGfUNeMOby87FzeVyBN4FK2k=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=Vz0ro9gQ5B8U8c6uJscLOrljSnn/BQrBgeRLotXzeR8WbDohUnt0e40y4wvXKnenh9
 Yxiyz232AcPmg/kvD4WumXJDvI93ZwGkbbLf6DTTYso3N3nT4AKNkKDeA4yIo1XB1wWA
 nE0J21qhsilgIn9hgPmJtihJRkrEHD2OV5tP4DJV9t0VW8G85ZQe2I5ZJ0/oj6KIGF38
 ohGF4nqqcITnj+zEm3OUvLbWmMizq7ICj3bHEbFbpQSz1XPRBqHJsUf/eF6hBnlCYFZ4
 hlTsmmtK3vArv2NJaoE+rnFlXpnKXi88ZF9DrMev30flJEyJ6wkHHwgjvAdDKV4y7uhO
 py7A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782586277; x=1783191077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u9XvXIhligjR/ahcRSMTGfUNeMOby87FzeVyBN4FK2k=;
 b=y9d+Odms9/Cd2K0CElwgIoWgOnvpOA40ZVn4ACbIOWABBtffOOIymUFZXxG1i14Arh
 CKqTR7suWwlihCeN1w0LcaVsFyY+eviSjJenUqAjzOhgAozVV1V43MZPdtvq++I7c4O/
 ib7SLCEPKPs4HbDgvPIDGJ+zZ9Ve4GBF17omfqRCRqb45OkBpKIhiFUtqF45kvtVhNu3
 9Tfzjpr9bUym0yBQgXX2aPpLA2+AXanNPcRL/4tcx7B+DuxmqMS1HrpxhxzLpl3CWwvK
 3d6SdXdpzwYA2PCWnL2We8R9W4ZRzchdq0+okNXZaWS2oAduPlnxngQJp/fA+vbXjcK9
 7STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782586277; x=1783191077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9XvXIhligjR/ahcRSMTGfUNeMOby87FzeVyBN4FK2k=;
 b=T45tvb1kqWrnA9qlvMMqrUVHGHyyOHPCGVWrR3QY+ZwdIA0c0qtqMHwExuM5OHXoYG
 Op1N3twPatd+DVI9UStdAOGQOo+YrkqtYHVJoyAoH0fRHT+jPyS9+Qyt2a3JlV+ALE+y
 edc+IV88WtIr+zm5MNYICSlYNdIn3GLXzyk87oNg1DFqnjRZQ3ge6oYR2nxhCLfm9/IJ
 CFUegwXalOl5KzRj9cPoUNwbrhr/rUhlVYrVZp11SyVaFHu3icqbAbevd3RGZ1kBelRg
 MD1KxBaD0Yw30WZ2JGPn3OxYQmWniRLyEc4R4GGxwLeJLpA609bPmf7mFeR4zlHkQvmm
 3jAA==
X-Gm-Message-State: AOJu0Yy9rg/mZrJ7jxb0j8VsapG7AR7eAAbq4A0y+djQ3HhGkMRowQpW
 gCC0C81t0qnJ7IAX+n66iqMyZ5hcBd3acNgzeIxP1d8qtUTPtUhrNH8QBvGXoxepJQ+61qksEnq
 tWkq05fR2LHTtHhI1WLVz3FV00s2u5w25g2EQzGW41g==
X-Gm-Gg: AfdE7cmwzD9jhdZk2F/xKLz4XO3kzyd64yJUSkM631iBL592NE09L9J201H2Ceqj2RR
 XKof02o5a1j2uxjc86EzJHMQxrIVOAwCrlzP0wkIkWiQ1WabOjBvgfm4CFVhNW5gOZ3YKb6xs7I
 1RJg8T2RzylIa/OfZQ7t2HNkSw0k4OMpPHY0ey+lEQgEPTODdKKDbE9EaofMVYgnGFNV3gh0isz
 p9G/yEhTwa1eO0FMBjsR19cF5FZY9wVyrD9CKoTDeR3tOzLgQwbdEGIjiPjbcvGqqXmPpoh1I4l
 0WR/LTOVEwDnjdW+kXVS/NLb017j5NwNtgMcUyun+6W/9FKCaPg+CLbFPRqnKxbdcW8UMyosYvV
 jtPfnk8IQQHYkw6HCvn82+5xprwz4TDAGwuaCrGjNhkTz1aPCHcmXIXKkQ8DBrCPj9xE3HoaMbH
 DZCTRV+PmZOoGo3bfMEKaxL8UzXM9Rj5f6nkM3VA/y6p8Onjm6sMpWxQpHnO0gdgIW+u5AY5/eo
 bdUvvhrLpmF88/LXQ4crlYZoPuIdUl640+jZJWdnBTW8V31fWazGsiwKd3Ga0IyRnR4jGgUFlRa
 Cs9Kn/vue9acC2fJYYLOcL6nDKHJOKDesijoownrEvwEmMMmXRmWEmFbxsjnik0+OKlvtsEDxrh
 4e9dpRgAEdC8L1YnvFnW7WUOKURc0
X-Received: by 2002:a53:d9c4:0:b0:664:ae6b:b497 with SMTP id
 956f58d0204a3-664ae6bb727mr3431534d50.76.1782586276993; Sat, 27 Jun 2026
 11:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-6-harsimransingh.tungal@arm.com>
In-Reply-To: <20260627144421.2067410-6-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 27 Jun 2026 21:50:40 +0300
X-Gm-Features: AVVi8CehRbAbPUxcAQCpBYlnYUNWenjeHPJfTDTCqL0wMVG9Rhjd-OFAXuF8gNA
Message-ID: <CAC_iWjKL=Qe13qoHx49XPi6CC1BEonSgpGAgfqN9UzJS=GaibQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] charset: mark u16_strsize() as __efi_runtime
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
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

On Sat, 27 Jun 2026 at 17:44, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Mark u16_strsize() as __efi_runtime so it can be called from the EFI
> runtime variable paths added for FF-A/MM communication after
> ExitBootServices().
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/charset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/charset.c b/lib/charset.c
> index 182c92a50c4..738ad1352de 100644
> --- a/lib/charset.c
> +++ b/lib/charset.c
> @@ -407,7 +407,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
>         return i;
>  }
>
> -size_t u16_strsize(const void *in)
> +size_t __efi_runtime u16_strsize(const void *in)
>  {
>         return (u16_strlen(in) + 1) * sizeof(u16);
>  }
> --
> 2.34.1
>
