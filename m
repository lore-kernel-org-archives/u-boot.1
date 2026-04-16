Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECFAF8DFCB
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 858A683FC0;
	Thu, 16 Apr 2026 23:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="evlViaZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D567B8405A; Thu, 16 Apr 2026 23:35:06 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A207883EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6715594a4c2so5969907a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776375304; cv=none;
 d=google.com; s=arc-20240605;
 b=N6+iBZHACZ+8KDTRIcwmAbnpoTs/a+JQMCsqEWqQxW+pHxeU1JDg/lcPJ54VfnqiXr
 z5yLhlKUfWv88Nf6LLacbNXkSkP3Uq2LrCgY1NEvMK9ZnfWJi0TMTtWyOWeiB/9N0QnF
 XEZJ9Cj+wCNr+ryAKEG2+shHKqvSpKh+vv2EyglnKbhqAwBApNNqQW2Qk9OZPBXmzvAo
 qmuoW1KSo4AhOqBkak2h63MiciYrpplW0PlBiZLX072dxBHdNB6GvQ1kpjXggQBnmZSu
 e1fuOLrWuLmvOb945j7C3l7KoaFvNWL6fkm5+E10NsdiX7i/N+UhIvu1JWNofXwr+57O
 sqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TbX5nawl89opJSebQxK+V5QWv/ITowG1W1UMCEctjBA=;
 fh=a+1MZZg868FOOHhBF9IeBruJJ7gJtxQZEYfRTQDHlW8=;
 b=HndDY/GsS4XdJiBSJxUVz3K34zZvaoQRTFECBTw9DTHiESE2TWGrB0ni746ykPclhf
 czn6qlA87e2t8uQSKj8uSMElA2qJ2FYufWbwKmgWET3x+TkZMrokR/WVZlDe8996I4Zy
 huxTCWGAS0J+ymBHYbA5qhmVES0QX637RdD/qnQHdp9/YeKdPTOYBoMijoggR1kgCm8g
 AR9DFh6ONis0DZcfybkegeibmpO2W6ngZU32yr8BH3wNjDIj1J4V43C5/ui3OM/tY8xw
 ZnD8ImGp+XUbZjXOa7aw8O6Nn1s2AgAZC3q++fBES8H1/v/o4p194Nglm84pcjb/sSWE
 jdbA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776375304; x=1776980104; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TbX5nawl89opJSebQxK+V5QWv/ITowG1W1UMCEctjBA=;
 b=evlViaZQRN5T6amEG3qXWw/3cj/AFKFmboCPgzefBszfr90Dg/0yFcHkiOFTxdkpy4
 bIusdbZMBW/4nvXxCpAdbTkibe8nXJGJE4QFkwomRlGL4hS/t8dsNbim/bm5u9eQvhJN
 fPPEHGmHJEqWjA1dFMxlP0RENvPc2a16rnsA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776375304; x=1776980104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbX5nawl89opJSebQxK+V5QWv/ITowG1W1UMCEctjBA=;
 b=ICgVqMHIJLRB3urUtl0El2PL7lHgdvyepLIibeC15r9PtHBb64CjjmJLHTgwp/9Ro0
 MRgUX+8BM+vJm1TFQOVMB60oY3txOr8GR0jtHn1V/KFh1MkGkJBMKYzkv+IkeYHF4YGG
 GbAtPSAkXfV2D4M2PZf/e5F8TlgQBHozULZRMG0pGj6ISSn7JPZ9dwhKdtMr3ZJM8c5d
 6HjD9NA5Kdd54Fz0OuzsnDfiIgNCytkaRrYmb1u3jCfpmNoE3MWcdttp8ViVIOh1aChb
 CFS000kGU3h0o7RNapI3UnKEgqJHNC4AHn5M+pXl4qH477ezhqKGv40AKLtsxtvK5S/b
 NTig==
X-Gm-Message-State: AOJu0YyLHy9HWbAH6aUicoW/PiAZdEnTDNuIr/tU5DdDppaYn+JKz5Jb
 W1BAn4C1qZtkVM6YLZJkKQ9R1EzPOy2a43M25WYLh2t20V1Ap8gp/uaG4TGYfBlz5PKv8yF63eL
 PCXoayW2ZZMrTkjFQ8H/184jMpnb1znzRNTYh6oUb
X-Gm-Gg: AeBDievzpL0hBl3s5A0iSM3kXyqNikz9igqDX6/00ufYWiqio1k5IxZwC6RrjHPwXi0
 2zuJ4wrc20FtPLlaokOQLf39cNc7y1KguxwYB7FOCeDexmTIkUJ73KiJcwnP1qb2HPRKTwa8P0r
 T5r0Skpqh/ELUrZygNCMPL8Nblgj4Vb48SuXg4Amqs3hSwuwdZq1yuG+lhc++DFdtwFGeazvpoU
 /BXmMFyAU/wiJmUS+uwM3W/COCMm7bHYTGSC1sDUbUeoiwW7F+02S9AkD/G3NxyjoQKxvFYN4+V
 qJqVTkwwDMW8LnGn5KSQ
X-Received: by 2002:a17:907:d92:b0:b9e:349:d29 with SMTP id
 a640c23a62f3a-ba41888237amr10343166b.9.1776375303832; Thu, 16 Apr 2026
 14:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260416145259.2985564-1-sergio.prado@e-labworks.com>
In-Reply-To: <20260416145259.2985564-1-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:34:52 +1200
X-Gm-Features: AQROBzA2juWLeN1osEPZlUcwh1hMs16PPZdHlR9uBfeBjkgVphUvbkPQlAxf3Q0
Message-ID: <CAFLszThoyxqjaR=FVz5kqg4F+NRqKoTXCx-d0r5-voCqDn9Lwg@mail.gmail.com>
Subject: Re: [PATCH] binman: x509_cert: add PKCS#11/HSM signing support
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org, 
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com, 
 y.moog@phytec.de, afd@ti.com
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

Hi Sergio,

On Fri, 17 Apr 2026 at 02:53, Sergio Prado <sergio.prado@e-labworks.com> wrote:
>
> Allow X509 certificates used for K3/TI secure boot to be signed via an
> HSM using the PKCS#11 standard.
>
> Two new make variables are introduced:
>
>   BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key on the HSM
>   BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so)
>
> When BINMAN_PKCS11_URI is set, it is passed to binman as the pkcs11-uri
> entry argument, which overrides the keyfile property at signing time.
>
> The openssl bintool gains three helper methods:
>
>   _pkcs11_use_provider() detects whether the pkcs11 provider (OpenSSL
>     >= 3.1) or the legacy pkcs11 engine (libp11) is available.
>
>   _build_key_args() builds the appropriate -key/-provider/-engine
>     arguments for the openssl command line, appending ?pin-value=<pin>
>     from the PKCS11_PIN environment variable when set.
>
>   _run_cmd_pkcs11() exports PKCS11_MODULE_PATH and PKCS11_PROVIDER_MODULE
>     before invoking openssl when a module path is provided.
>
> Existing behavior is unchanged when neither BINMAN_PKCS11_URI nor
> BINMAN_PKCS11_MODULE is set.
>
> Tested with SoftHSM2 and a Yubikey using the verdin-am62_a53_defconfig
> configuration.
>
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  Makefile                        |   2 +
>  tools/binman/binman.rst         |  18 ++++++
>  tools/binman/btool/openssl.py   | 106 +++++++++++++++++++++++++++-----
>  tools/binman/etype/x509_cert.py |  47 ++++++++++++--
>  4 files changed, 153 insertions(+), 20 deletions(-)

For some reason I cannot see this in patchwork.

In any case, please can you add tests and check that the coverage is
still 100% ?

Regards,
Simon
