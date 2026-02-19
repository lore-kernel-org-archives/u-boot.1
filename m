Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA49E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3E583EE2;
	Thu, 19 Feb 2026 14:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l+mW0IzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADBCC83F00; Thu, 19 Feb 2026 14:13:10 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E640083EC6
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65a36583ef9so1957084a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506785; cv=none;
 d=google.com; s=arc-20240605;
 b=cES/b19FMWp8aTuaUi6TH4iZZ7Ez8Z4B+ODchEFZ/YsDYozp5is61ckdkaGKE1BMpa
 ZzyBVkzR5yBAfronZBzhQnGvhI0U4hpcvYHheBA0yN3bc9GyHZdLC9hFJTKoNCGj3Vas
 gwPtlSMycVFVMN7St2hjRvFqItNT59OQkKDx+lnkG7xQA1MoQw96FtusrWqiri+C3Ea+
 faNSp+fCVKddtZB+YGTcnUhwdV/eill3+6a1nx5IAfRTbcf7yO+lNGWoc4RFya/pa1I0
 OsJxCjZ+TmTwmxs1DXezb2P8ZFPUbrVo2mKg1cc2fgq6pOv0rt8dD2qfIoKQXdwRtYUt
 5HKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6FleK1LaOvj9AYRr6M+18Z1bha9nTXqHwzVYmIT8TrY=;
 fh=89JGekwhSyYOPQOy2uyR8LelJwXS2WWWd2nllJCIfB4=;
 b=b7I+C76OOBU/x8kSNm3lPl5AVxy03jsWu5pEZlPvRWU+MzMdPMX/cgbp5FUxYqqvw9
 jd0Lp81zklMYlSTTQuyAlgStgCaJR9jUbKq+AcNGb+xyYPN4RL7slEuR7sE4feJ8H6u7
 vaLSBhJuc1n7MpNcuOD02owlCOP6xA8uIxm9xq4WYK8HMUS6WGrKFM3HiMBJh94ASM03
 kzuEU0SdhCk6izKOcy+Qrg1Eqz3tcUKF6pwUgvbesbqIeSFnS/Oq0opNnIfier5n2wxO
 tiZuHl30Vnzup+tNb2j6YQ4jQnYoC/2eDzMkaOGU7ye0eLyV+tHwoKY01pbDDZD87tLG
 r1fQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506785; x=1772111585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6FleK1LaOvj9AYRr6M+18Z1bha9nTXqHwzVYmIT8TrY=;
 b=l+mW0IzTDGvoRrVBu7fwof62rGOI+OXdr0JhNmOF/yxwlG4szeS98lFVx4VVbe2cfa
 UyCUNzM8lcS6ni5MfICCLqIzoQ49b0BsEbXmDo0UtpQX5geI0D6nNsphu5Lv5r5mquPC
 2zsAyyHrF17XZiU1zTp17GSTQeAir8A7WTn1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506785; x=1772111585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FleK1LaOvj9AYRr6M+18Z1bha9nTXqHwzVYmIT8TrY=;
 b=wDiJzVfO6IhfA2tdayh/GmkGH5AtFIjW3S4UUwlYXQ2NluPNqwqShJO8gmPD1mT2hL
 6BhZkxSeRw3Bp1/UC29qS/XlGLZTvfPIvequL6pO324RMXtMt59G3IeuV7Y1Iheqw55F
 LAuhRw/DCeOatbYkeAM4KZPEfYUwo7KUqwMa/VyhcP0NzuYvTu+OcLKYQfEDQH+EX2vi
 4IQ+M3TTlmyr5xLLfInDbzceAukdZhs1JgE7OsJvUmCbaXBudZAwensQAlr3TAD9AO27
 GybfwOhc2Eca1xnNlA2VTNbcXozzNDPuqUDE02w83WwB4Y9i8U9NxVXmf1pNHFS2pRuS
 iFTQ==
X-Gm-Message-State: AOJu0Yw0LjYg4GnIR/diTH1wn4r/bKX473xy1a2UChX94YMvUwss3bUa
 +AwTopHrB2b42c91G1bZOScnq6zMh9LiloJUDmzFHLZEsn2fhRrJRAqUF2ZEDDxc62lCwxt0+ve
 QIG0ziObHKJKGBZc+3OAvQ0r/8kaT2DfmJy88KngU
X-Gm-Gg: AZuq6aIzSRejMz0JpL8HlcEdJAn6oSA9JEJ/YOMcFIXukMBhtAIPEjofgQQfEbQOlic
 nizetXQu9JWNKcaRjO7A/Ll8m8Co9PAine4XkEzkTBQSmtpmcdVZyXeTANqHa83qkmcqKCryqaS
 6aN/ZYLq/WmyiBMPlG0LIHm7euYwlzl3oZIP/KOdBUTJoWZVDELOZdVYaqEgI9gSLDkuoyOtPvq
 lNo4FAh2k4wXXPKajPbZLjAhev27wD+VfKBMUAH0pT70hGGNuj7GivSDVuPO4TLndTPufoZf2mZ
 05d3vw==
X-Received: by 2002:a05:6402:5cd:b0:649:a157:3327 with SMTP id
 4fb4d7f45d1cf-65e4f985a99mr1013807a12.17.1771506785173; Thu, 19 Feb 2026
 05:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:12:51 -0700
X-Gm-Features: AaiRm50kGUa8pDPBlqH18Z5MD3rjwJO_86KXQkcIFmK0J0Yz71cqmsTl9tjQQp0
Message-ID: <CAFLszTiexKf9VhSvKC46QrJMW4dy9Uc2ufsG5AyWvs0e1D4aMw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] UEFI Capsule - PKCS11 Support
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 simon.glass@canonical.com, quentin.schulz@cherry.de
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

Hi Wojciech,

On Tue, 17 Feb 2026 at 04:53, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> Add support for pkcs11 URI's when generating UEFI capsules and
> accept URI's for certificate in dts capsule nodes.
> Example:
> export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
> tools/mkeficapsule --monotonic-count 1 \
>  --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
>  --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
>  --index 1 \
>  --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
>  "capsule-payload" \
>  "capsule.cap
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v6:
> * mkeficapsule: use strlen instead of hardcoded values
> Changes in v5:
> * add bin wrappers in test for all external tools
> * improve error handling in python test
> * fix data types in python
> * standardize option name in mkeficapsule
> * fix typos
> Changes in v4:
> * adapt mkeficapsule python support to dump detached signature
>   for authenticated capsules
> * verify detached capsule signature with openssl after generation
> * use p11-kit to figure out location of softhsm2 library
> * fix missing long option for dumping signatures in mkeficapsule
> Changes in v3:
> * fix write file encoding, env setting and extra line in binman test
>   after review
> Changes in v2:
> * allow mixed file/pkcs11 URI as key specification in mkeficapsule
> * fix logic for accepting pkcs11 URI in binman device tree sections
> * add binman test for UEFI capsule signature where private key comes
>   from softHSM
> ---
> Wojciech Dubowik (6):
>   tools: mkeficapsule: Add support for pkcs11
>   binman: Accept pkcs11 URI tokens for capsule updates
>   tools: mkeficapsule: Fix dump signature long option
>   binman: Add dump signature option to mkeficapsule
>   binman: DTS: Add dump-signature option for capsules
>   test: binman: Add test for pkcs11 signed capsule
>
>  doc/mkeficapsule.1                            |   4 +-
>  tools/binman/btool/mkeficapsule.py            |   8 +-
>  tools/binman/btool/p11_kit.py                 |  21 ++++
>  tools/binman/entries.rst                      |   4 +
>  tools/binman/etype/efi_capsule.py             |  17 ++-
>  tools/binman/ftest.py                         |  66 ++++++++++
>  .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
>  tools/mkeficapsule.c                          | 113 +++++++++++++-----
>  8 files changed, 221 insertions(+), 34 deletions(-)
>  create mode 100644 tools/binman/btool/p11_kit.py
>  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
>
> --
> 2.47.3
>

Please make sure that you have 100% test coverage now. CI will fail
without it. If you need help on covering some code, please let me
know.

Regards,
Simon
