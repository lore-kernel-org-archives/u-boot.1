Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B39BCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1E28464D;
	Fri, 15 May 2026 14:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B9mM9KAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28908465D; Fri, 15 May 2026 14:58:18 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0684784099
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso683359466b.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849896; cv=none;
 d=google.com; s=arc-20240605;
 b=iUPzA0kpm8CvOt85Cyc8LWbi/zGmgfidmOrnjbzwCL5bi8pP77OpLrBpckkSPuICoR
 1VouYphdZdL+mtHzhAuU0BfHSxDZQ9WMTbpG3lLxEYkkRDJ2Xu0NL9qc3sGN/4AjK+QF
 WMHRlSlygHNfbssO4uvXPJ1K4dYICxOX374EHUH7GwD/2bMKNyY7wGZ0D0i3lHxw2v+8
 ct3iPGQ0C6WoWm3vpvcKwSCl1kmDYd+xF1rc7GKSOW4BFmzWpejOKJCoOXQU1qbigNoX
 e5gfRgOF+BTbiUj+gueS9kd6c6LsP4Ju7UAmmQCvavFQzNxFWqPEYF0Ekx8q/tcTaRvf
 lCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ADQ9GtO6sM4mFAZsesk9Pstq9ohxEDeCOR3VdRI0ifA=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=MVqJS968by3W0dLYkQpDOMzpbQfzOiY4s7ypiZiC2uLNSlsGWPY++dyuhnQQSthCVS
 XyJTIA+oaOyslwtRSbUBRTgHCibGrNjyxABdIKch5i9/F9A3+nG8gkGM8uqK/vkaL/gk
 v3U4sBq7QHEzEX21xGsNKR47j6Hj1+OBik+ytWTMK9DPpwkQZOco9ogVU3jRgo+WbQYr
 CoRTnZ8xJHSHY7cwBiiXiJ5W23+OWixrOG7nxRDvnKKfGAT61xU9yY5L+a24BT3mIBk3
 U4OtyrwHzAmQGjYPjekYC8uVxZKBMAP5cG3tH9YfvqONw0MZwGyVy94w2HqvAjCfBqrI
 yXxQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778849896; x=1779454696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ADQ9GtO6sM4mFAZsesk9Pstq9ohxEDeCOR3VdRI0ifA=;
 b=B9mM9KAWMAhX6VFajoXxYf0aOOt4NUJUkXmaqlz/jeawFLZJCrAcNdSZCfwqmBsPlG
 +tF/rcbobTGheJmULGenQFXaeTrL1LCy5KoXdV5qibOl4mRrWPyu9UhdZAloI++aHERl
 +zizDsPaFT3BQKT7bLVHNACb9A5hdJhjII8/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849896; x=1779454696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADQ9GtO6sM4mFAZsesk9Pstq9ohxEDeCOR3VdRI0ifA=;
 b=pdI56c1XDwyYm5QPRaRtI+kmICKncH7I9DUYbvxX1HuP1GD7Q/gBNHq9zsMjAXNIcK
 EGrADQ/WkF+1aq4d7soOCj7fQlVNzqN43dANf/CuWPS+NAWZts4gZrFR8A4jNNvupgqX
 4eH5wbMixjwrvNYowGjWMjcc2v6rljFNq3w/nchhbX1LSCxI5ga6Q93WWpZ/kasrWdc3
 wtqOvFD+nbTDBHRJWHAY+hErXr7wWJ6Uq8tLp6l4mD/AAWc6sXrGD7FlQRWkPjpTGhoj
 30i+rvrVASPM7kpVEXq/3x5u5lSuQrm8zWpjhazqtpxPlQ7xJZ3qEcv26Dslj5UYKURz
 54uA==
X-Gm-Message-State: AOJu0YxPk+UZrNOpwZnuhHPo310ZedVZNLEwxStbi9R0WlB/Y1IDPh8G
 ces0cXGWGklOc47jOhPogdgARCv9+SZ7uzl7aCnSmZ2bR1XK0P/rhg+w6Ajh2jjAciX2felWByS
 X6z24exiKxrhTIsNDbOot4zQJ7NIdcUqRCJs88XQSh5uA7xzddwfejg==
X-Gm-Gg: Acq92OFEF/jEA8EYSxsKGTePkJgWOq4kDufSUyCYazZLfznzIOWwG7BJJkA1jlGwLAb
 pRDXDNcujheiSnBLihyMQD9WAjMrAgNvYvrye9w8XTTSzLunq9TxspiDxf1PYhKRlxUQahbclqr
 m3y9vRn/bMoNCXkA6upMgx+mOx1Tj2KIG7ltnVbRkm1sGynwbCALKVlerByvFKkF26dKDGf9XN7
 OCasnhEAQQAsvr1JpO8Ezx4Q28+uqj+S58E4hawwqqOJ3x44Hr0zFrVK2sLjZj2lF6c1iQioEyW
 swzD2A==
X-Received: by 2002:a17:906:6207:b0:bd2:2852:683b with SMTP id
 a640c23a62f3a-bd5177c7dd5mr214019466b.16.1778849896413; Fri, 15 May 2026
 05:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <84adac247cd407e093dd7455138fbd794e91d933.1778657347.git.weijie.gao@mediatek.com>
In-Reply-To: <84adac247cd407e093dd7455138fbd794e91d933.1778657347.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 06:58:01 -0600
X-Gm-Features: AVHnY4IpOSGX-fx9CaE7JU5P7oLQll2vUxFmFrCokIbyRZGjwwYdy3pP0I3kbkQ
Message-ID: <CAFLszTi8ii_CM7HQQw_rjON6izUzQ89dt4xhXSD7EceU1O+n7A@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] cmd: ubi: export more APIs to public
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: export more APIs to public
>
> Export the following functions to public:
>
> - ubi_detach(): this is paired with ubi_part(). One may call this function
>   to completely clean up the ubi subsystem after using ubi_part().
>
> - ubi_{create,find,remove}_vol: this is a set of functions for volume
>   management.
>
> The original ubi_create_vol is renamed to __ubi_create_vol to allow the new
> ubi_create_vol() being used as a wrapper for __ubi_create_vol() with volume
> name.
>
> Also, comments are added for all exported functions.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c           | 23 ++++++++++----
>  include/ubi_uboot.h | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -213,8 +213,8 @@ bad:
>       return err;
>  }
>
> -static int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
> -                       int vol_id, bool skipcheck)
> +int ubi_create_vol(const char *volume, int64_t size, bool dynamic, int vol_id,
> +                bool skipcheck)

The commit message is now out of date - it says ubi_create_vol() is
renamed to __ubi_create_vol() and wrapped.

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,11 +47,102 @@
> + * ubi_part() - attach UBI to MTD partition
> + * @part_name: name of the MTD partition to attach
> + * @vid_header_offset: VID header offset (string)
> + *
> + * This function detaches any existing UBI device, then probes for the
> + * specified MTD partition, and then scans it to initialize UBI.
> + *
> + * @vid_header_offset is optional and is usually set to NULL.
> + *
> + * Return: 0 on success, 1 if partition not found, or -ve on error.
> + */
>  int ubi_part(const char *part_name, const char *vid_header_offset);

Just to check, where does the '1 if partition not found' come from? My
reading of ubi_dev_scan() / do_ubi() is that a missing partition
surfaces as a negative errno. If there is no path that returns +1,
please drop that clause.

Regards,
Simon
