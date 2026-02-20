Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9683BC531FC
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 02:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1AF883946;
	Fri, 20 Feb 2026 03:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MTzY1KWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F0383AA9; Fri, 20 Feb 2026 03:39:19 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D31D8366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 03:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6597a7bd7d6so2054902a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:39:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771555157; cv=none;
 d=google.com; s=arc-20240605;
 b=DaC6uOZzTRZZ8uMOjvFn6EE2IDSpolEUcs9mT0fWw79rTLnBJ1qkfHITUNdLM+FgbF
 l4LpePfP69bn5GTbz3u35cE27+58Y5j167IQ2BJ/AX4ylJcJ5i6tlYhnlbXd6VYl8QPM
 LVWPhZ4tMVNVW4cgrrjVo09/VLx5oaDe5/EZ71BFrprlZwce5CjG8aJvgno0sCKB3qEf
 CfhGha49b7ottL8drHuOYnm4b56MelVir7wwpWDElLH7v53QfJu3k7out3EYBskCwcvB
 BKoKROsmg4eVV3xXV5RdM7bYQLUXyFvLQCWyX3oAo5hVMQ0tTmRi8NrU0G2AEUfqv+Xw
 FQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D/9pQ/lUQc4DSMeV6b5XlY5kZyRmYS/1WjWjAf5aMVI=;
 fh=89JGekwhSyYOPQOy2uyR8LelJwXS2WWWd2nllJCIfB4=;
 b=PQ35M4EMluusqGhr7UpV8m8ssbDzsRoftxXYhhype9KEa3JJe0k1nbP0HzbjutO/e/
 EK/gYhoHuUVq7cqZz98GQ5dKcHtVO2Um84cP+voTRRtSW2yWvSyHATqD/JhZUxoJZqay
 lBwTaVBsQvjD1hH6hw78yPHsmGDWfcWOQmTsbEgW8kARTFqzVHrtkmuZfzJmyjufAs7M
 KL9BstfmYC4Dut7mGaMzVKw424hIbIvyfz8r2ERHah8DQV+F1UPlptzhC5+7z/kvNn51
 it3JqcZB7I97uQYZoC3aMQgtSmbHvU0OchtwSkIRfuWAbms/kHEAnXIb489fsHq53INI
 JB+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771555157; x=1772159957; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D/9pQ/lUQc4DSMeV6b5XlY5kZyRmYS/1WjWjAf5aMVI=;
 b=MTzY1KWKmDSrV2y2Z3A9DKDK41B9jjqD13riFYhHb8pV04U1h36w5MdC5MpNrMa5M9
 vu2VBtMdlHz1yI/VGa7zCI2ajGqGI4qgTnIv57C/F3nC8bGSozHr3zHjK+A8ag1bY+bo
 RM4ve/NtKuPkMS7HsHqMK/IP0nzfAz8KP/WnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771555157; x=1772159957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/9pQ/lUQc4DSMeV6b5XlY5kZyRmYS/1WjWjAf5aMVI=;
 b=cYYBzja3kop7xkV8VWlsKWHIE1VL0/1w7RmYv4x2DwqVNLGW/83UiSHQdtEwirX0yO
 DAsvtKPFJJXNjE+VqCYb06Vru0SBz1FaTw8nEYJT1JuvW85x5p02f3g4c0OxbdFTQf+J
 AP2R9yczQLUHsiX+rWNx7rFmBeZDyI+/XgfXrWlcYmSHl8XBVdpF5cBLNe4vhESdy1mf
 frnnl4KsVmwM1xeLEhCTA/fk+r7bSiXGNmmSidDmfWcehZsDKQKhRW51fBkwlzbgCCFq
 4NfCLPVOTV6uVhn3qk6635UCztHXTFMqQhr/tm359higklXx8fNBlvqH30Ypd+O8nPoq
 3ccg==
X-Gm-Message-State: AOJu0YwX5Vs/OpBeEszOTLOSFZ5aNcP2JUHfIcKVq6uHo4BPYXnt9wZg
 kHJQxnobONkK8S0ln4LISd22WXsM+/pQQcl2V+iahll45mPDhpbkZ2p7OnLUMGmofhY2LiJtkZw
 OGY/ITqjqnUw03s5FJl0VHomvDeTQGt5A1z/lNgOc
X-Gm-Gg: AZuq6aLz7zt0dcWGqBuklQlLSbm0qXuLqRbntq7YoWrR623DHRUX1Kqj14q4JVS0h7J
 51tvVMGiOqvXUM/wIEbBHCpCWQo3+wszOOzYro1y7ag4MdZAMKD7/iDwXr4eumAG2M+VJZLmeUw
 JfUAsIoQcw+QGxfoxSPhlTRJL7LMwAZ5hRUxnmAPvD9EzGs7+in6crv7jUHEiDyWAEazAAaCDeO
 V5BJw7WqWSCLOmRShFFP87/LqDdxyIX4XJy/h4prnJNMOL8QHq5Up4Vl5YLa8zclWKe+GFtzCRO
 zJgLlA==
X-Received: by 2002:a05:6402:34ce:b0:658:b837:7953 with SMTP id
 4fb4d7f45d1cf-65bc78653cemr11219119a12.12.1771555156983; Thu, 19 Feb 2026
 18:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
 <CAFLszTiexKf9VhSvKC46QrJMW4dy9Uc2ufsG5AyWvs0e1D4aMw@mail.gmail.com>
In-Reply-To: <CAFLszTiexKf9VhSvKC46QrJMW4dy9Uc2ufsG5AyWvs0e1D4aMw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 19:39:04 -0700
X-Gm-Features: AaiRm53tPG_jx5mBEJg5ZqzNLG4AgSj7LFvdlj2GkY9vsHvFjDJdL93JL4zj_Y8
Message-ID: <CAFLszTjNx8_eew0p1uQK_k4tR81SDtBPpNmDSVVBmZcc2mG3cA@mail.gmail.com>
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

On Thu, 19 Feb 2026 at 06:12, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Wojciech,
>
> On Tue, 17 Feb 2026 at 04:53, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> >
> > Add support for pkcs11 URI's when generating UEFI capsules and
> > accept URI's for certificate in dts capsule nodes.
> > Example:
> > export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
> > tools/mkeficapsule --monotonic-count 1 \
> >  --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
> >  --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
> >  --index 1 \
> >  --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
> >  "capsule-payload" \
> >  "capsule.cap
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > Changes in v6:
> > * mkeficapsule: use strlen instead of hardcoded values
> > Changes in v5:
> > * add bin wrappers in test for all external tools
> > * improve error handling in python test
> > * fix data types in python
> > * standardize option name in mkeficapsule
> > * fix typos
> > Changes in v4:
> > * adapt mkeficapsule python support to dump detached signature
> >   for authenticated capsules
> > * verify detached capsule signature with openssl after generation
> > * use p11-kit to figure out location of softhsm2 library
> > * fix missing long option for dumping signatures in mkeficapsule
> > Changes in v3:
> > * fix write file encoding, env setting and extra line in binman test
> >   after review
> > Changes in v2:
> > * allow mixed file/pkcs11 URI as key specification in mkeficapsule
> > * fix logic for accepting pkcs11 URI in binman device tree sections
> > * add binman test for UEFI capsule signature where private key comes
> >   from softHSM
> > ---
> > Wojciech Dubowik (6):
> >   tools: mkeficapsule: Add support for pkcs11
> >   binman: Accept pkcs11 URI tokens for capsule updates
> >   tools: mkeficapsule: Fix dump signature long option
> >   binman: Add dump signature option to mkeficapsule
> >   binman: DTS: Add dump-signature option for capsules
> >   test: binman: Add test for pkcs11 signed capsule
> >
> >  doc/mkeficapsule.1                            |   4 +-
> >  tools/binman/btool/mkeficapsule.py            |   8 +-
> >  tools/binman/btool/p11_kit.py                 |  21 ++++
> >  tools/binman/entries.rst                      |   4 +
> >  tools/binman/etype/efi_capsule.py             |  17 ++-
> >  tools/binman/ftest.py                         |  66 ++++++++++
> >  .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
> >  tools/mkeficapsule.c                          | 113 +++++++++++++-----
> >  8 files changed, 221 insertions(+), 34 deletions(-)
> >  create mode 100644 tools/binman/btool/p11_kit.py
> >  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> >
> > --
> > 2.47.3
> >
>
> Please make sure that you have 100% test coverage now. CI will fail
> without it. If you need help on covering some code, please let me
> know.

Please note though that the only goal is to cover the code. Binman is
full of fakes and other techniques to do that with the minimum of
effort.

Regards,
Simon
