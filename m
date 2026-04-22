Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6766AF94CB8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 00:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF1A84178;
	Wed, 22 Apr 2026 02:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RghdhoED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB89984178; Wed, 22 Apr 2026 02:15:06 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5B8805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so313646766b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816902; cv=none;
 d=google.com; s=arc-20240605;
 b=OYr1ASHroICypBuV6CdUWpRQ24hAhtS2svUxL86B7eak0yMxXD8o1GKIKw+HdZ8jBo
 IidohJ7Y9QFre4hMq1fTphWmmK2XfxqZ7jMqG4ZjmzQUEx59VT4m9gUTgW5vCCcRdKPK
 IfyU7QpN320DoGVZqSYZ321p67epuYf2JRlWeybjqPjG71cDmrYvHhUXBxq6V3XjUkNO
 PJpd3Zjom+zLX1xfDn3fI+TRrDYlF18X7ANlTzhtjVjTJvIlITEW/vnrX1m7lmTV2f4q
 1uiAPEXBf1vUr9hT4dXDDgILYYlQB4NBu+4oV9y89NZZ8cqBze87aQNAIcbUAXQjzb+L
 iB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3u1AXF7tcTVhG3Rt8eU0gK4eWEHDYrTXOXppUfh5Kzk=;
 fh=qaRiAPLi2gUZrZGaRoTf6QYCsjzDIsZQoM8Hg7+2j3w=;
 b=J9Pe/g1yJigUJXe1qk3lE2r+Jld5ap07VEDl8N6veRM1Mf1rK4wUs5frA/IZG4tFXn
 ZneCntaePTFM39mh/+4t//9sF75ArYcuDbNcwTap0bft/FD6eIziGrw2p/sZfGztCe43
 WjNLjxlHgBoXRXLasLEnFGyWTCQ8F1Dx8AMlH1GWQuKfSwoaF2XWr0OP21uxsEAjjzNp
 c9waXKWJj7JrMMagGWCdlCc/uxKMKPqF3ZX/ZDMFB7S2kEsdXqPVPyhA9WawNieZmq6q
 vaW/qGUFNsgMW6Pzbrb4R7sQOEqMpuAqekwX/b20tddOrcpeHOZnQYi4Tq8lOo1G8oey
 wEbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776816902; x=1777421702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3u1AXF7tcTVhG3Rt8eU0gK4eWEHDYrTXOXppUfh5Kzk=;
 b=RghdhoEDUEFbiXmujonijkKiQlnl8/Jhe3WnbUZXNmD85IV5J1XP5keuQxUdf2I9XT
 h46GYcAYac21H4U9AiRkJ+JHYOv4vz/6GNL162uLWoPBlhkn/JprLCmkmsXt0hk5FOvu
 7b+9OrlX2MC87W1x4/sJOZWhwM4tZyH7rHkkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816902; x=1777421702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3u1AXF7tcTVhG3Rt8eU0gK4eWEHDYrTXOXppUfh5Kzk=;
 b=pZBO2ERtlUDSGK5su71zFh5dbPjdsUyIFB8QyPni2wbbeSak4+Nw/bweEnICeBkEUx
 ILvYuxZ9vFhxz180ebBDi/WbDMdjgJzYMvoV17rN/LebN94EEVfYe/3NDZImTZD6aqvc
 VhQhAMBQAgIDJP4UV7HnVkNv1XaBLWxrRgpAZXO9gTH4pSrHOzBcBeVtNELe8oVDQ9/c
 ps67tnWiFw2r/jggjvLrZVWKfRV67VlD6QLLKyXdHhadAwXE58JeidtrHBFNhiMP7BP4
 5ko6VLgZSTzHPy2wOGdKfxDWThmsJbMdwDajpJwSgchPcK8bgZubErunceClrfTs1ZPI
 0GhQ==
X-Gm-Message-State: AOJu0YyMjTgBnv6J0GDFAjSI1NUPl7KN7UmQgFFes0/o7vjPUZKGWixc
 9eMbHFcqibN27yfzE41LriUqF2IimYV6XjX6d45MYamvZobO8+0GR9CTU/2qaTAgTXOfmMlBlBv
 kKSFnwv8Lu23x11R57knkzx0Ni/nTIoLxTYGiK600
X-Gm-Gg: AeBDieuIotvtv+98ahDkvTeHc7vVmR0jx9Hi4w+hgTFsCx9+VtUnMnsuzSKZiqUr1nW
 Xp3Dbpcd7Jtcy16k1EQOVk79UZbtym056wEMaKYZC8FxQ4CrAMZLlRv+KeJCrwm7Iu75e+4hFgt
 +sJZ2cc3W7lYhPE7bOgT0TILrPVMS02XGR6LhHbDo1ItSpWV2fQ7kuCQbgmWL0iKRqAmb15Ar/j
 LwZg6ONir6LO5moceLcBXIpTuK9jJVtOkYqA5yjE0fHK9uoZz//XFRzQzfD7Zx8oUg6LPwLvOOh
 +/hlVP5kFfteDIVfM5Zu
X-Received: by 2002:a17:907:928e:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-ba418981ae1mr1077311466b.10.1776816901576; Tue, 21 Apr 2026
 17:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260421133646.2826728-1-sergio.prado@e-labworks.com>
In-Reply-To: <20260421133646.2826728-1-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 12:14:48 +1200
X-Gm-Features: AQROBzBP3dlpsCcSgPYk2whCXlfYH-XqiCZtNqPLT5QFqnhvTNBcZLyjKrD-I2k
Message-ID: <CAFLszTivVH-DJCMY4BjywtWJqw6Ywt_Wt3wrFBZ_4m5vv7QK+w@mail.gmail.com>
Subject: Re: [PATCH v2] binman: x509_cert: add PKCS#11/HSM signing support
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, afd@ti.com
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

On 2026-04-21T13:36:46, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: add PKCS#11/HSM signing support
>
> Allow X509 certificates used for K3/TI secure boot to be signed via an
> HSM using the PKCS#11 standard.
>
> Two new make variables are introduced:
>
> - BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key on the HSM
> - BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so)
>
> When BINMAN_PKCS11_URI is set, it is passed to binman as the pkcs11-uri
> entry argument, which overrides the keyfile property at signing time.
>
> The openssl bintool gains three helper methods:
>
> - _pkcs11_use_provider() detects whether the pkcs11 provider (OpenSSL
>   >= 3.1) or the legacy pkcs11 engine (libp11) is available.
>
> - _build_key_args() builds the appropriate -key/-provider/-engine
>   arguments for the openssl command line, appending ?pin-value=<pin>
> [...]
>
> Makefile                        |   2 +
>  tools/binman/binman.rst         |  18 +++++++
>  tools/binman/btool/openssl.py   | 106 ++++++++++++++++++++++++++++++++++------
>  tools/binman/etype/x509_cert.py |  47 ++++++++++++++++--
>  tools/binman/ftest.py           |  96 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 249 insertions(+), 20 deletions(-)

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -35,18 +36,83 @@ class Bintoolopenssl(bintool.Bintool):
> +        if key_fname.startswith('pkcs11:'):
> +            pin = os.environ.get('PKCS11_PIN')
> +            if pin:
> +                key_fname = f'{key_fname}?pin-value={pin}'

This assumes the URI has no existing query parameters. It might be
worth using '&' instead of '?' if the URI already contains '?'

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -35,18 +36,83 @@ class Bintoolopenssl(bintool.Bintool):
> +    def _run_cmd_pkcs11(self, pkcs11_module, *args):
> +        if pkcs11_module:
> +            os.environ['PKCS11_MODULE_PATH'] = pkcs11_module
> +            os.environ['PKCS11_PROVIDER_MODULE'] = pkcs11_module
> +        return self.run_cmd(*args)

Setting os.environ directly pollutes the global environment. This
could cause issues if binman signs multiple images with different
module paths in a single run. It would be cleaner to pass the env to
run_cmd() explicitly. What do you think?

Also, the environment variables persist even if pkcs11_module is None
on a subsequent call.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -6884,6 +6884,102 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testX509CertPkcs11(self):
> +        """Test X509 certificate creation using a PKCS#11 URI instead of a key file"""
> +        PKCS11_URI = 'pkcs11:token=test;object=mykey;type=private'
> +        PKCS11_MODULE = '/usr/lib/pkcs11/libsofthsm2.so'
> +        original = bintool.Bintool.run_cmd
> +
> +        def fake_openssl(self_tool, *args, binary=False):
> +            if self_tool.name != 'openssl':
> +                return original(self_tool, *args, binary=binary)
> +            arg_list = list(args)
> +            if arg_list == ['list', '-providers']:
> +                return 'pkcs11 provider'
> +            if '-out' in arg_list:
> +                tools.write_file(arg_list[arg_list.index('-out') + 1],
> +                                 b'\x00' * 32)
> +            return ''

The test only confirms the code path runs without error. You could
also add assertions that check the args contain '-provider pkcs11' and
that PKCS11_URI is passed as the key argument.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
