Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F266EEB362B
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 597D783F4C;
	Mon,  2 Mar 2026 19:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AeGwGLKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D77383F4D; Mon,  2 Mar 2026 19:12:43 +0100 (CET)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BB183F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-126ea4e9694so7422888c88.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772475159; cv=none;
 d=google.com; s=arc-20240605;
 b=HRnwb0yM0O/SUGy9kXT3ggnUToc6Pdsqmn1DRCrSZh4fb4pG+cTPXr8JH6dsvxiYXJ
 EUlkbFtKNbkuPSdJiccK50Oa4wa/EZVglJ0TMKKjCCmd3AciTK6B7wfuO0YKK76RQbWb
 YNMgIj3lZnn6hR61aDkuQzSe6Z2c7GRU8e6UDSuOlmkXq8TDG2EcXqy/SzbNOPG9Uylr
 kwZZQwnguhSvFSv6ie0+yp67Muwri166p0VWHGAE7kg37dOI6m0+wGHR61PZZHl3nYEQ
 vO4K/z3LhieyS4TKE5nuNglImzHbeM+tVvNZ8hklkr5kBkKn4wUndZUmGGo+T8jHp6Kh
 XMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Zc72ot6nw2vD9SxDxjqJ4453aSxCWmV1BpUzPeRZ0A=;
 fh=MqVxsXbTqLT1mEOVeZrDVva9zXkQPc3S8baR4giEULM=;
 b=iPCTjW0g4Zt0QmBKKf4bY18FbTDsFk2lKEW7pCqJi9f6gjy7vdG8r4XEJ5tOSe3TL7
 j2FbO89fAt/JSeq1KBWMYloj0hnlmcWZ89knAyjzTGp7WYcx1nGhhePYr1+ydixWxrEx
 huIwxtEYa/M/z4V2fIwc1vx2oDfwalEsFAFJk4nx4gzFFnwYLeq3TRfbOJpD9qRjLzap
 kSwdXve3fcB+TheIxuY9lN7cqCYL4qMx6sdfX9SqkjVx7zx2AaQ8Si/xQRRlJqmZfZlU
 n8VBJncagcRifiJJzPtHkx48MnowrHeHMexHl1CLcbDDG86gmEtaTKXAcdhYFkSmFxeN
 0RsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772475159; x=1773079959; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Zc72ot6nw2vD9SxDxjqJ4453aSxCWmV1BpUzPeRZ0A=;
 b=AeGwGLKGuGlN2Zh28h5zGk8V0ZGUU9SXDfaRwjFHbG9t7Bqi+jHp46fXqJAHsZ/qFL
 4XsnRMO4j876ANtpjA1xFabaTW3EkNzWMu7NgOm0waUR6sFmc9JiwngbYKkuYbymhTrz
 652Q9YEz2wXA9qwmL8+zJ4o4LaGcjhglGMLUPnbUJthgKvqS0w8SFTlRQFkakh13iaLI
 PmPFyaObft9dcLR5XIHrYQRa4lxqE+8z32+hXeyhLC6IqV9jZpnFSKQ2gRkC2ib3dwEU
 Nv6MroOF+xH2E/A6DDpc4ry94DGhWYdFISgrqnp1kG4lRlIOHkRV/JBNFzu0BfQs1/uF
 qPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772475159; x=1773079959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Zc72ot6nw2vD9SxDxjqJ4453aSxCWmV1BpUzPeRZ0A=;
 b=blYisWbJxX4gyi6oLqeNnJq2Jp6U4fGMqcX+KXQxQohRpJPucmjfiUccxl1pGBgnWI
 KnavIowARHAMtw+OyD3Naa5IFIKVqXZWa/OWqnM7womYA2ds25D6j1ET6pjqmpvhrhlj
 qiqpBJBowKP14oVJSXKJ5jBihNPJ9oHpnwF+dRO/x5UHhbGFVhQqt65jzNFA/nerBLdi
 LfglNw1tzC6mUlWILMUctW+1lnfj8cWkMkNnJlM79tkDEoK2Wfe4NALzrCB4IaeKhi17
 4WTwph4AMgOg7aKuhMlXF9kl8Ap9XCumkxLhjiVCcou9zbGYC+/+TrhtwmW2VDRVwxCk
 C7xQ==
X-Gm-Message-State: AOJu0Yyxs7aqS+WBiZXYirWogDbExFBnRe+iF43nbiWQBYBFqdbj0h4q
 D0bqI8wubQZ7nhA5TvbzihKEFGdf8l5UhJjlksT4fXkkNdBOJKx9zwe24TyOIuVXrN7qX39xoXk
 1my5oo20cYofn0K/0U3aNnVatVPxIPg==
X-Gm-Gg: ATEYQzzIa+K6+A/jqXIC8RHj4mPTqFRfenlv+aXIFP+z9h4vuTIQAWy+xXShBXefPtf
 KPFgkxRdYjwKkpK04uKd/VjGcd8ZTYDSv1dtU9nGmgvPCy2QMqe/UBdbFLIdX+TAE+q/pG/8U+J
 WGoBN7+Ffa1+dWVwDrOqGOOFgRpx2qNXUF7/5UU0se0feCdzSd6kD7NjJYJllPsy8X4zIjLB1mA
 Bo/7eFSdhh1iLwNzz1mv3To8cmj2RLHHofq+cLK7+R2hmRWht1/Gj5DGQI9Azu/mDunbZqDcBjj
 0AlD6t1D+l5lxRAZY2nB9SbVwn2Ssd+Hb/kCa6E=
X-Received: by 2002:a05:7022:6713:b0:119:e56b:9581 with SMTP id
 a92af1059eb24-1278fc288f3mr6827679c88.6.1772475158911; Mon, 02 Mar 2026
 10:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20260227193423.5712-1-jcethrid@gmail.com>
In-Reply-To: <20260227193423.5712-1-jcethrid@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Mon, 2 Mar 2026 13:12:04 -0500
X-Gm-Features: AaiRm52vPI7voiW0tUaKBjxEu0AqtetD2f4a5KGE5zg9kiFsDFDl9b9L_zs8pcg
Message-ID: <CABdDSeXcz-ft+moCHum2zLwM6Q+cmuuK+Xb-V7-ZiomYUbamuw@mail.gmail.com>
Subject: Re: [PATCH v3] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, linux@analog.com, 
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On Fri, Feb 27, 2026 at 2:34=E2=80=AFPM Caleb Ethridge <jcethrid@gmail.com>=
 wrote:
>
> From: Caleb Ethridge <caleb.ethridge@analog.com>
>
> Updates the polarities for the GPIOs on the sc594
> EZKIT carrier board for the newest revision, Rev D.
> The new carrier board revision has different polarities
> for some GPIOs. This patch updates the sc594 entries
> to match the sc598 entries that were updated in a previous
> commit, as both SOMs can utilize the EZKIT.
>
> Note that these updates are for the EZKIT carrier
> board used by both sc598 and sc594 SOMs, not the SOMs themselves.
>
> Fixes: be79378 ("board: adi: Add support for SC594")
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
> ---
> Changes in v3:
> - Resubmission to fix whitespace issues
> ---
>  arch/arm/dts/sc594-som-ezkit.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ez=
kit.dts
> index eeca6d17504..11154e65ed6 100644
> --- a/arch/arm/dts/sc594-som-ezkit.dts
> +++ b/arch/arm/dts/sc594-som-ezkit.dts
> @@ -22,7 +22,7 @@
>
>                 eeprom {
>                         gpio-hog;
> -                       gpios =3D <0 GPIO_ACTIVE_HIGH>;
> +                       gpios =3D <0 GPIO_ACTIVE_LOW>;
>                         output-low;
>                         line-name =3D "eeprom-en";
>                         bootph-pre-ram;
> @@ -30,7 +30,7 @@
>
>                 pushbutton {
>                         gpio-hog;
> -                       gpios =3D <1 GPIO_ACTIVE_HIGH>;
> +                       gpios =3D <1 GPIO_ACTIVE_LOW>;
>                         output-low;
>                         line-name =3D "pushbutton-en";
>                         bootph-pre-ram;
> @@ -70,7 +70,7 @@
>
>                 octal {
>                         gpio-hog;
> -                       gpios =3D <8 GPIO_ACTIVE_HIGH>;
> +                       gpios =3D <8 GPIO_ACTIVE_LOW>;
>                         output-low;
>                         line-name =3D "octal-spi-cs-en";
>                         bootph-pre-ram;
> --
> 2.34.1
>

Looks like the reviewed-by tag was dropped on patchwork so here's fresh one=
:

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
