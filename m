Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F65D10362
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 22:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC4484142;
	Tue, 25 Nov 2025 23:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MHk3i+4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A81A8414B; Tue, 25 Nov 2025 23:41:37 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A6FD840E6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b73875aa527so974643266b.3
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764110495; x=1764715295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GDsGopUjgfwVNAH7biL7SLVcUod72fCgESG3kbswY00=;
 b=MHk3i+4NPnOgnr0xQ0VmluZnN3fjsqI0xwhUXgSDd1mPYGTZx1MMrvUFB9HD/3gsI8
 MoRB+ePIYTjB4ZJzdYaGWCv6QdF8+6unPl7FkGd+7I6Zb0OGTqiBnu3EIDLk8lst0LU0
 TK2pijDadr6n0CgLhP+EgIMdkqVfGJMxVv8O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764110495; x=1764715295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDsGopUjgfwVNAH7biL7SLVcUod72fCgESG3kbswY00=;
 b=L7Lu+401kDbL4cBexZbZmgi9Oc7sszptwVQ4ktWCJ5tzK70TIFvYE7bLPaIkK5RoVZ
 9VoimOep/yeTPAZSy1wPK6L5WfvZByFmdPf4z7DwsCsHzfLZZ9zQhALh4hWoltllEUAi
 zFepbnsaoYm8G4TAI5Mk109W3vEa9uEov5vrOz6XsiUUkE+msONncmm3HHA0pMoG3ip9
 NeH+prYjqF9sBTfis09/8GAhxEiPKrNvuKtnP9tNt++iybYu3rigPBCimrKCGXAWkLgm
 8bB+/8MxDijmvKolpDpMJm6cSQ/zCgglkjxFCSJsL+2c9wRpTU0VaS35q8zlZu6FGCkD
 nxGA==
X-Gm-Message-State: AOJu0Yxuc/BHTj18wb5YCymOdCxictm2mVgSALLorS21BZZujrHK2pox
 lD9h6Gli8P87x30Q2di2KKvMClElV05+UCwE/O1jJ0CV2WJsR7gu6M0jIdyevVKQrO2dNGdWIzo
 8k7EscPpIsbbPYNsFHmckP9+eR7hoFauEOf42h2R/
X-Gm-Gg: ASbGncsIECVKLb8gnelllar0JPFuYz/CHoxHjVRK8S6KNhWk7cbUAc/rlCeIMk+h+vg
 hi6NJmCfVzRDq8i03Gq4WHkf5DPy1F389WeakjmxxGFAXBiP0qIhNwRbfGL/xfn8zSkuuIYaI4d
 HPCSfXzveG13QX0ij1oThGNo27TNUuyLKc9jnK19aIIH1i+SjIErdb3GUsXydbSQkJs4c+cVEQB
 0pEtneeG5PZEc3Pj9f4EtBMpup0DrwAkYDCM/WgXGW2BQueGynSx8o07qJ3502FblRUpA==
X-Google-Smtp-Source: AGHT+IEP8cETY+PIxE9Ox8Zx8ZL0p2RkrGcyV69uGNx8OcyUpHYlg77zGiDL2mv5Tzh8USRgtiPfYM1dCNoLcadfc9E=
X-Received: by 2002:a17:907:2d20:b0:b73:8bdd:eec9 with SMTP id
 a640c23a62f3a-b7671558a7dmr1971061266b.5.1764110494840; Tue, 25 Nov 2025
 14:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
 <20251121-a-few-test-py-improvements-v1-2-bacb4148fb0d@baylibre.com>
 <CAFLszTjm94_iH5srp44mTMDJ-vJSAJMtgisBs+E=fNWk++KP6Q@mail.gmail.com>
 <0d1a05c3-6a29-404c-98a2-3b820bfe077b@baylibre.com>
In-Reply-To: <0d1a05c3-6a29-404c-98a2-3b820bfe077b@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Nov 2025 15:41:23 -0700
X-Gm-Features: AWmQ_blkh_bRSJndvFpNVPj3M8ixj5r_8Q-ypl6xdiC-JIt-WF6XdiTmsjqeFxI
Message-ID: <CAFLszTgoa=Yk+XS5jUXigoko_5dHedYn7qMyYYbmdQcTA1dGOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] test.py: check ubconfig exists before using it
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
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

Hi David,

On Tue, 25 Nov 2025 at 15:29, David Lechner <dlechner@baylibre.com> wrote:
>
> On 11/25/25 4:14 PM, Simon Glass wrote:
> > Hi David,
> >
>
> ...
>
> >> diff --git a/test/py/conftest.py b/test/py/conftest.py
> >> index 8ce680a92a0c37f36489b0782921d6cf4078850d..f889e3d3ae26db3ae19f79e236a281471d4b6de9 100644
> >> --- a/test/py/conftest.py
> >> +++ b/test/py/conftest.py
> >> @@ -613,7 +613,7 @@ def show_timings():
> >>          if too_long:
> >>              show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
> >>          log.info(buf.getvalue())
> >> -    if ubconfig.timing:
> >> +    if "ubconfig" in globals() and ubconfig.timing:
> >>          print(buf.getvalue(), end='')
> >
> > Please put 'ubconfig = None' at the top of the file, then this can be:
> >
> >      if ubconfig.timing:
>
> I think you mean this?
>
>         if ubconfig and ubconfig.timing?
>

Ah yes, thanks.

Regards,
Simon
