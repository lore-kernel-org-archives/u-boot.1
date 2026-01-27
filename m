Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D83D25923
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 02:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3D683F64;
	Tue, 27 Jan 2026 03:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JVFt79xg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A6683F6A; Tue, 27 Jan 2026 03:55:28 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E46D83F63
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65063a95558so7087263a12.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 18:55:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769482526; cv=none;
 d=google.com; s=arc-20240605;
 b=Pn3vBCZXd+h/MGNq6DGD0OXPWxi4QCmA06OGqetF1ZtP9LrE3vy5cNbaF6uW4RWhqi
 lNswH+4x79NdjXtHibQhYs1jAeu+p1gpun2p6ij0pHDREe+cHp7iic1CjZeh6TQVPK/v
 BnwGZagQD4CpQKHv/DQTf6X1qYExGJ0YxPzyP3r1+zxRD6GbRzV2Gywng6eT2gcAPETN
 XlA1SyrZzNnQ2QFMwYUJ+/MKmjIlkGvIH88NFooBZHmoTW+5qlFdr5q0wiv2/y3lVyVq
 nY0p+WGaBz3QTlK7x4JamhAHw7b138MJLV4ghsmMnJ6OYMb1e+wFFN/xWiC/6JezgDxn
 EF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YLGOPujGyw5cT9GoUsLoXbCbmhAsDUalJEvFnno5Q+o=;
 fh=TCBdUFJ8Qo/n0fS8Qkbxqew5p5mxpoEKaWr/fkoz7iU=;
 b=O0/KutBV0eZ4QvOkiZDjgsgSkyeg/KlI4N08B7O4JGYBJ3VKSDvZ9EK6my/8NXXQl7
 /wSXf8c9xqwcukJYIRR2pcBDR9UKYOG9jQxwZdtTNGW6jYhhPfIDXFW2oW6lj3M/oZO9
 XR7JQOy8JTvnrA63etIlXLUOqj2gYNcQsOR2qweWnmPijJajdAY4LHK0reHWyG0QnDEG
 0koVVWjua1oyiqUB90Pp2mmAjd8m62qo1Sas88UxZQ93LMyhHagpnP4wluDUF6aQ8xvC
 lqdn6CckQcnMJ4xC9scdpvmNi9zKidsIR4w+j9Tlg0N49U3oUK51HzkvIWGOBkNdwxVo
 2oqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1769482526; x=1770087326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YLGOPujGyw5cT9GoUsLoXbCbmhAsDUalJEvFnno5Q+o=;
 b=JVFt79xgmIsIEYE7DmcyLgZRJY9QjIsOWz/HYZpIMIGO8eldZ+UpDQHzdMBqndNGXQ
 w8YWyFzT73qVRhEXzzvblqjwAICGgc9ez/vQCvgwGG5akhbx3n5rnrOGefPXzte9PP3l
 NgTXr4vuBAAsLIYdrEhvOIXHHp9WFzX/Xoq7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769482526; x=1770087326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLGOPujGyw5cT9GoUsLoXbCbmhAsDUalJEvFnno5Q+o=;
 b=ECKHPzUv+6HBQ/23RoL1r71ScznAt9owaGPvNJWa4kh/DyuyK18WD+wZBAzii/IOj1
 V7tlkgVHk3foLmVsuwIPO/KAr6BqKkXU8evgF0BJIOGCXug+66PaphGIQd2SdHUDagnK
 Dfqag62RZMkVltaAfk0TLW4e8Q7QrmEw1z6gODgXLuB/wvL4Vu6tC4SJWV5XgNmJ6huD
 zFcyjVXjuG0w6oSJA8dEj/toBwEGyGAonW5vhrI1a4KYs+O5k6HYfV5LrwK7Uc/pP4hv
 uuzpgWbfb2geO3B1DgmxiYcYwZQ2Jt3dnGnPsfRCORLPubN1EPDmIBuhdN00+4BME3sn
 WDlQ==
X-Gm-Message-State: AOJu0YxjqXWiLLW5vR8tPCvtynPVSPsjTQCFpdBO3qUf0w7xAeyf90Al
 JOGWvq8FW3dvKZRPpVb2M6JmeZOeZaL4aGruY1RH4TN7YKCk2H4qza0j9I1Y1HAirEYBUPI3abl
 AFPVQYRZ069Snozw6Ug3FxCcRLN+sRclY3KMA6MYclqJ4kxM/u7vQdg==
X-Gm-Gg: AZuq6aLvKRM6Ite89nq4EGl61tCD3EhigB5YNTkYH+gyyB8QuLILGC4lPYZdX1NXFNN
 xSVpHNPqJ/hVePm6p45Vl/nHeJZp8D6+Xb63R2PJcnzncibI3p++TSikbBUeTas6SBklPO2hFh+
 hraN5m5pGUpuE5+3HKUYY6hdIzcbEmgfDC4a++WvyiLHahdG4WxCeYL4WfCd1Z0N7427/BuduSa
 UoGuQE7S3SWmO6z34aICigPby15yXvet9mhJHIeYIUwDXITFzlRg74spOLHtI33iDw4PMDp
X-Received: by 2002:a17:907:1b10:b0:b87:685a:31f3 with SMTP id
 a640c23a62f3a-b8dab36196bmr25711066b.52.1769482525718; Mon, 26 Jan 2026
 18:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20250819105554.3067982-1-ravi@prevas.dk>
In-Reply-To: <20250819105554.3067982-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Jan 2026 15:55:24 +1300
X-Gm-Features: AZwV_QgoGzN93gPQxEKY8qRHE2TGTjJFUt-zD474eHrBWOTsdhtCmJ6m2VUTias
Message-ID: <CAFLszTgxbJxxUhPAcFpXE80=ks1ogtLL47EKbK4eGpLz1CffgQ@mail.gmail.com>
Subject: Re: [PATCH] common/spl: use memmove() in load_simple_fit()
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Sam Edwards <cfsworks@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, 
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

Hi Rasmus,

On Tue, 19 Aug 2025 at 22:56, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> I had trouble booting some am335x boards (both
> beagleboneblack and a custom board). SPL would start just fine, and
> apparently load U-Boot proper, but it would hang when jumping to
> U-Boot.
>
> While debugging, I stumbled on this memcpy() which from code
> inspection very much looked to have overlapping src and dst, and
> indeed a simple printf revealed
>
>   calling memcpy(0x8087bf68, 0x8087bf80, 0xf7f8)
>
> Now, it will always be with src > dst, our memcpy()
> implementations "most likely" do forward-copying, and in the end it
> turned out that this wasn't the culprit after all [*].
>
> But to avoid me or others barking up the wrong tree in the future, and
> because this use of memcpy() is technically undefined, use memmove()
> instead.
>
> [*] That was 358d1cc232c ("spl: Align FDT load address"), which has
> since been fixed in master but not the v2025.07 I worked of by
> 52caad0d14a ("ARM: Align image end to 8 bytes to fit DT alignment").
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  common/spl/spl_fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 25f3c822a49..746c3d2fa28 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -353,7 +353,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>                 }
>                 length = loadEnd - CONFIG_SYS_LOAD_ADDR;
>         } else {
> -               memcpy(load_ptr, src, length);
> +               memmove(load_ptr, src, length);
>         }
>
>         if (image_info) {
> --
> 2.50.1
>

I just hit this too, thanks for the fix!


- Simon
