Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAC9C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 08:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA83982CF8;
	Mon, 26 May 2025 10:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pWNAPm4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D495282D18; Mon, 26 May 2025 10:57:49 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB24282C57
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 10:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so375029466b.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748249867; x=1748854667; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YinOVdd+Is808kB7f0cwdP3Se1w0YwML49wUsgZhdL4=;
 b=pWNAPm4bJyK3cZeQoeGYFaR0tuL9H5TWAHYlq77P52wh9E0x+MvDKn3XhPwof5ep44
 bfuU+mXrX/Rae8EvIPFl8zu+/iEDPlV5QIF3Ef0hrc2iFZv9jDZqQFSO60Ar9J/DsCqG
 LrLGKOEXvzYdiym/Xxwm31cFxAPcUzFsv7iXZI5XthGnggmWOdEIJMuP7WGRFMum/6uK
 QL8H50dH29C69Q/SAn69lYyLp+ghYBzZVkwQL2IgtuR9A15V2UXC4CDw1jI594Q/Z7gS
 oPN0mZV2pkjkVuMIZV4qXqf5Ckw9krH5UknqnFWZnCAqZ4YKQN9hWWRFpeHjpBBwNDDy
 nCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748249867; x=1748854667;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YinOVdd+Is808kB7f0cwdP3Se1w0YwML49wUsgZhdL4=;
 b=CffxkU05CKldTnQQ/SRGjHLQWmVw2VKtpI7Nt/Snwbu+O7roq5QMaJ/ZPMPzWdFUSV
 T7KMHz1PDSYZ/uuIo70L91W7wvSd71EaXCjWr0nTxnbqni9pi7Hl4wGzH7ST2N9NujAR
 KldEhHfWQtUSIptbPO/sF739G/9vd23zDIbP8Q28UEdqxDGgqx7AghTFpx0aFikjOLVL
 wnnv/+OH5fJnvHRGs1glCnOSod30WZ7jsFv2jwMPWea1tdbLFBSmFRkK8NrX0zldUgtq
 gxoXIuJ44TGcMkJUSwkZLa6qgQKPKL+GlgZsrOfsYh8wLTTI4D8tl224H005Mc+09uY3
 c17w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW88bPe36op9sbfSbEoOvQy407yrWIZzMRyWudE5pYddWm0Ben/mys01UApaYsVvBqeBWC5fLE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5pFa6PCvFVjS6JJU7u2XPmALaERwY0TiQ9HrnVpxSL/3r1Sdl
 lhweGfnzMvJUbhBqBj3NNyP8qay3H9whxofZugkytj+5gTVt4AdZzJaU376Y9SocB8c=
X-Gm-Gg: ASbGnctDiVUSEq11aOwkVBa59kCaL5JHYbakElO++2UKadtxzP/iXYLO2A9q/WZTDGZ
 KrPmKBOMgaPjZxFKUTzXoBu4PHavg7TxPHjAkwCHM7OEUCKK/0zWCLc54CGOdRBMB92msUSPgzj
 LDYHsJ4EfRln2u+NjPXGHKw98wUGuT/0HWbrNpjSTKCz+eaXTBqqLTlLNHmd3zO9h924leL65tZ
 VL6Mt2TqMcnnHTNWac7ZegsQyDnOFhpm0iRenkwQkYvraW1RbJ4Lb4IZqPUJZlPTaF+Ej8yB5AG
 pO1bQ0uZNiwBQjRLc7MF2v7/HC4iNMIuZQLCeswFO0IbsV+TpYThnbLWiG9Asr6KEviFmaq45W3
 pVJGAJPMTINgGABcTDRQQQe3j
X-Google-Smtp-Source: AGHT+IHY0FuMCRI3jvgnHB97/JZrmdNSFl2Uh5Lz5ITKPY2xbuJC/vVWddK8DkgGjxloW3kHJAVwvQ==
X-Received: by 2002:a17:907:6d04:b0:ad5:4691:1929 with SMTP id
 a640c23a62f3a-ad859b536c3mr824189066b.28.1748249867199; 
 Mon, 26 May 2025 01:57:47 -0700 (PDT)
Received: from localhost (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d437585sm1629891466b.115.2025.05.26.01.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 01:57:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 11:57:45 +0300
Message-Id: <DA5YUSUAKBHC.7IFVBK2UIK55@linaro.org>
Subject: Re: [PATCH v3 4/4] test: tpm: Skip failing tests on coral
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Simon Glass" <sjg@chromium.org>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Mattijs Korpershoek"
 <mkorpershoek@baylibre.com>, "Tim Harvey" <tharvey@gateworks.com>
X-Mailer: aerc 0.20.0
References: <20250524130642.902486-1-sjg@chromium.org>
 <20250524130642.902486-2-sjg@chromium.org>
In-Reply-To: <20250524130642.902486-2-sjg@chromium.org>
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

On Sat May 24, 2025 at 4:06 PM EEST, Simon Glass wrote:
> These tests have been failing for some months. Disable them so that a CI
> run can pass on coral. Further work will be needed to see how to make
> them pass.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Add new patch to skip failing tests on coral
>
>  test/py/tests/test_tpm2.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index fecce248fbd..9be85999d46 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -179,6 +179,7 @@ def test_tpm2_dam_parameters(ubman):
>      assert 'Property 0x00000211: 0x00000000' in read_cap
>
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
> +@pytest.mark.notbuildconfigspec('target_chromebook_coral')
>  def test_tpm2_pcr_read(ubman):
>      """Execute a TPM2_PCR_Read command.
>
> @@ -201,6 +202,7 @@ def test_tpm2_pcr_read(ubman):
>      assert '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00' in read_pcr
>
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
> +@pytest.mark.notbuildconfigspec('target_chromebook_coral')
>  def test_tpm2_pcr_extend(ubman):
>      """Execute a TPM2_PCR_Extend command.
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
