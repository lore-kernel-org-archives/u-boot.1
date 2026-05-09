Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA9FCD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 16:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2F584CF2;
	Sat,  9 May 2026 18:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YtgdCusG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F7184CF4; Sat,  9 May 2026 18:47:10 +0200 (CEST)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AA884CEC
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 18:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2f7020a928eso4083934eec.1
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 09:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778345226; cv=none;
 d=google.com; s=arc-20240605;
 b=Ye/fjM9NQiKtQBMTo2wV2dQP/YZwtdrUYgd8fDXDyRfThFDxPzTAS0QJXCHctXJfxW
 KkOeax32P+fBzFgOWk7ALa0/u19ppHdEH1ZyaK1r0QL2NYr+ZgNN1QDv3twRepn6IE1y
 77vmngtUkPLYlNSCYxIOxMVd+uKCh09/3iwJEiSspHzB5cAC6n/BRRv3H0KH9UBfcJLx
 1SqfaZhDCGu41NaM6Z9fVSKhC/kIcYPOrewv+Ih7j6k/1yNrFs/WOsEhpZblh/GOgKeS
 qV6sIFFIZFSqbV9su1Dx6eIDVWBlHlNs8e56eUNWAKO68VVnAIeqZ+tYjpF3ymQmF9Cs
 +xtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iqMcG9IjbYbgjVWQ477roO34LlaUvOByCHW9kFg/3MA=;
 fh=NbL1UtTKC0x7fUW18qQWobdeBynxeVXzUKcjNgMhygI=;
 b=duLfFVk7EegTEiroz4HqynLNds68ZIMtQc5Ci1/7zGLae5kpJHEiruIUApl6LaJqVZ
 G8wlyFBSnX/iz1S00tQfip/xkEshsEup9KiE/9Is6VMCL75AHtrHGlEA6Mr+0HdvUsDH
 Yxyf5Df8o23MW3zNM12F3/AHyNPdX9HibO3kHu4j7ofbKv28GCX2hVnh5SwqTCap9q6v
 Y+jj+CJ58cOye0rwGDYxfAKlUPVwpX6IntwtNEeK0R0AXxXHspI3sRYAyPq3vNxSrEAL
 o/EGauzZ/7t/25HSD5y9YHfATgoVaHrmmbUGc7zMDx92WXEOCSkemBp4HMFMzoRVLE8c
 KZCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778345226; x=1778950026; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqMcG9IjbYbgjVWQ477roO34LlaUvOByCHW9kFg/3MA=;
 b=YtgdCusGsHcW1wRNbwmK2NEQuUAw+4QqDDdpP1kU9PYF7cZPVL/WC9+WQg21oibujt
 4eQ+GdaIXDJ7t+yfNfQWHmsmIz16psRumfLc4+p7/a29gW8I0UkxlG7GC61FzmoHvCnm
 6XQ92mSCTJ2NyAp3PTmqnklr1VV4rQNFyOGos5LVAPE/O8dLTosJyF3PyzbVDXSUyXt8
 D3Ge76ftzn6yBdmrcBvu5b97vMvdn/FyNkK+4sQ7z+5kUNnzf2RuaEKya0sqFdEMcFtG
 4hJy9QUCOV6mCjGX6tnGng3sDhjxQDwn7YPXdrurHNZ0u9mg1noiKuM5jMuTuxi507Lm
 wbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778345226; x=1778950026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqMcG9IjbYbgjVWQ477roO34LlaUvOByCHW9kFg/3MA=;
 b=d5+Dk4hosAaGtMYnmzm+NuQmlYmEKK9u9gght5sK9TG852ZBNdTle/pM8sQk3KOx4/
 xWCoKh62lxgFAdxoH2/bh/kIEwl4DAN1RanFo6gBJvxMWZszzuQ/Zt5I8lka/djQVvFH
 i0hBgCfAd6teaUwyt+92q8twRyrJbWi3UAjM986Wdljewpd/LoJtKQqNA+nACtDkVzl3
 +74Er9yHaya1Xup3hFwZCkuQa8yJfRTYZFQ/UH5gpbu85+6ssghAV5JR27Ze+3E2g2k8
 gIfnPEX6n7BIoGRkxY6B8201Y2k2We2mOe5HtfKkg4t2ZxXQO5nZp07DbdVbLNBunLzQ
 Cdyw==
X-Gm-Message-State: AOJu0Yxw9EXeIYibZyFsrifshk+X+RnAstIN5Y9uaa/cmIxJk3N9nZ8s
 +ZcO2S5/aAkDsvlrC51yHLZJ2TFa1Vs49pt4IXWu5LLq4erzT3TA9mbRhwPh9n1AZOu4phsLKaI
 szGYb0fKXMqoKxGYuOvih+7aMv71shRo=
X-Gm-Gg: Acq92OE0SMe1FZTfg4fhwMWb5NpEzoj2h8iVBAqDwbawa13Q9+TAxEOddM7OYkMV8Hh
 9Hq1vxluna0CDYxP1SgGkjw7Y+SBqlZned8cgYM2kkMRSD565PIWrMXHWn2mhwyY2VffyOddSsO
 t31RRgitvjOrh7y7XFIwfB7HfoyXS6940gEGEIjD9mBgWEU2SnllWxa9LC4tJ1OVoqC8v2s+FXa
 c2uXxydWZU+PjKf1q6zGUZ64M+lQ4JndUgdQ8hi2csXrqMG18ITsxxR3ZF+W9KMA4ZMvW7iLnpE
 XkUO3qZe
X-Received: by 2002:a05:7300:f690:b0:2ea:7901:8d72 with SMTP id
 5a478bee46e88-2f54a87e863mr8905181eec.17.1778345226448; Sat, 09 May 2026
 09:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
 <20260509151308.23067-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-13-marek.vasut+renesas@mailbox.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 9 May 2026 19:46:55 +0300
X-Gm-Features: AVHnY4LhpV6zrXMeuTmGK5V1gGcMztohNJtA1zaSHkavg1eBqgwGhJlpE-vw5rQ
Message-ID: <CAPVz0n1OoDAj9No2vg-1b6-QBwkPsKqfQAXspPOZh_XgeCHKbA@mail.gmail.com>
Subject: Re: [PATCH 13/14] reset: tegra-car: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>
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

=D1=81=D0=B1, 9 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 18:13=
 Marek Vasut <marek.vasut+renesas@mailbox.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/reset/tegra-car-reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>
