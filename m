Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2F5CA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 00:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FF9828A2;
	Tue, 26 Aug 2025 02:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UmuVTGVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A29282DA1; Tue, 26 Aug 2025 02:20:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451F7809A5
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 02:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6188b793d21so7463015a12.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756167640; x=1756772440; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aAKc96v7yz2aDYUddZUw0tUE3ws+NoO8wrJr+OA2lMg=;
 b=UmuVTGVAmzf2RmLR9IdX9DXxssbknJzEhD8txPRZaX+cgb3YqGgFIWIC2h+wse6k4d
 +c0tJiKh7fixpTCGZIk8MvBoBILf1dt8He5oM+4tBLs5ctJH5z4JfwM95Xy7Cr0Kp2/s
 0hx8tnQtz/ydVQcNb0MOjLKrNUlFFkKUszP8NERMxfm+iOHa+WS/7wGeP7U/hqeN7j0n
 EPJP68mGmMkAjo2s8OiG6EwDtiOvm/rj4++WXLqAjmmwDvwbimxxMwLWJ7M9IWg0U9+c
 IaVu5O64+edXbq8qr+hVG977M2htkxyaTFkK/cZ9z4blaU5M9jRUrJ6KyLEhTMHnXzVA
 2skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756167640; x=1756772440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aAKc96v7yz2aDYUddZUw0tUE3ws+NoO8wrJr+OA2lMg=;
 b=TntNA0hLkO9my1s54uc5WeQ7DaXvLPLIz7YRCXjlTc+U8/MotlRbMp1lHiv4boQcS7
 vKVIWDRaovo7/xXGmiT1i9mCD9NW6uDtJZX7jJG7o8OkPzAdsGSeGyQzMA6F+4+2fbzq
 x5uJ+0LN9C1kNkx9i0gfXR8wRiU2W4t7moVGK7w3rkL9MiAkzNq3Af4SJ0C5gE4Xuudk
 qQCExh5y09ctJgHOj9houSEiSdP63wx4XD5mXi9ozvUlv1W98Q/LAHNqQ9JAS7Qh9SI0
 LW0mjkNntf6vjfyGM1GzgYMC9sU+k2xTwbJS493sorTVbw/hiFQDaWNov3n5+CEHEDtg
 ypEA==
X-Gm-Message-State: AOJu0YwPhjc/ZWkhagVYdkKzXm3qR6VRUh9c9mYYyXZC8XVfzJ5yLLfg
 0MebWdjeUAEnIfVpI8X6HUCR4lEC/tEQBE902ZpP2BBY88Xa7DyBmsc5kxXcm73Z+rNaDk6qMdx
 kiMuWk4vwJ/HYXS2vhlQ/gWjP5bymijQ=
X-Gm-Gg: ASbGncsIBR155sSCbP9/vjQv0l0api3w/m9zKUviOYvrbNLcTVm6INxYYfs5F9ZhzJp
 De8/7seIWhpSounQJKIpgr4WuAxd1KF1W8GSjj/kpW3auYHREo5FpDU8/6G/08OopOBWSmWmHoL
 pE8UqQObF0rQ5iPguB0iiJRp/8Zf2SxNpmrWTYyYbeCOV7SR5DZ4gVxXwcHxIczWs96bwtEtpot
 sBV50MZbwIbQAVdBFfUqjfL8X4d7jHfsFZJCA==
X-Google-Smtp-Source: AGHT+IGdqns+SXarE0kBJgfmRzkaYRZ60AKsD6udx3zXw11DzJjWz1aScmQSxBubj7STlbKsHfDVzYwKZreSsVDup3g=
X-Received: by 2002:a05:6402:3482:b0:61c:7160:73b2 with SMTP id
 4fb4d7f45d1cf-61c71607e35mr3405963a12.36.1756167639508; Mon, 25 Aug 2025
 17:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-6-adrianocarvalho.pt@gmail.com>
 <20250825225824.GA124814@bill-the-cat>
In-Reply-To: <20250825225824.GA124814@bill-the-cat>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Tue, 26 Aug 2025 01:20:28 +0100
X-Gm-Features: Ac12FXyoInGHrIII1aBN5q17rkedEo8NHd26aIeZYDbhgqEMyY20OUJRwIfV2EY
Message-ID: <CACAHuLD58_QcDckscepmEM_4+4yboN7+iLvtEWiK9MBS_EYghg@mail.gmail.com>
Subject: Re: [PATCH 5/7] doc: make pdfdocs: Update empty SVG file to
 something, otherwise compilation of the *.tex files fails
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
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

On Mon, 25 Aug 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
> [...]
> It's not supposed to be zero byte I assume, so can we please figure out
> what patch was misapplied (I have some ideas) and then find the version
> where we get the right SVG? Thanks.
>
> --
> Tom

The problem seems to be with this patch:
https://patchwork.ozlabs.org/project/uboot/patch/20250319140327.301266-3-n-francis@ti.com/

The last part was cut-off even though there was something in there:

>  doc/develop/pics/spl_before_reloc.svg | Bin 0 -> 224608 bytes

I hope Neha still has the original.

I think this also got accepted by mistake:

> diff --git a/.gitattributes b/.gitattributes
> index 7a7c4163560..735b13da278 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -6,3 +6,4 @@
>  *.ttf binary
>  *.gz binary
>  *.png binary
> +*.svg binary

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
