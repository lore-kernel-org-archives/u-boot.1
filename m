Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0589C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 10:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04FD584B0E;
	Thu,  9 Jul 2026 12:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="pUVELvLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E62584B14; Thu,  9 Jul 2026 12:41:49 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7516784AB8
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 12:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb545db3afso987616a34.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 03:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783593706; cv=none;
 d=google.com; s=arc-20260327;
 b=HZLaU8E4u6uEuBzuZU2VKzVBrWGzMZzJFsA0FDmNvThD6dNLfXD7tR3fHfHwaEdPgH
 BInFByfbFp1LHOJaeLXUCP4aPBNZScmjo6tTzh6XH6CtzvxGQspmwgL4qrzwYuSISSDK
 /LWufBoRt1ofB+A6BlMSvZHOE9SgNEceqXZuC/aqqGo1t8puHPV4+Mj6Mc7YxdjHoRAZ
 C1ekKOZ6pytFG9o5XwWCEHFLz+kH3PYIK/x8CNWcveOLjIq9Xa9GejYX5lfUwb1Uw/sL
 jDzfKg52jPdf55km9veHxhSPYtk2efItu5oiUBsar/V4X7ayGY7E1XGCI+Rg9EzPipGi
 ZDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DV4fitCmcUiKCZtjtAk5tLUiYZQoV+/boJKfHh87Guk=;
 fh=Mn98zmmaVo1MBdSjLCIsYZYNfzkUZMOmxiIlYJ+k73I=;
 b=Vpz3zXdehhGx1bXaceQ8TfsZc12c10AsdKcC7IFKqSUBADifql3CZg8NjTTaJcA9Pr
 Hjlr9g8bp6XPU+sGrVKLSte4mwrHBTALoStVaGLi1sEal/h+nAB/6xdbFiL6wmXRjp/i
 LM9swHh4BovEvKEqD8M7uj0PqQd6BdK9K1NYtm4lHS8J7C0kqCbBAq/iCDg0tUPdCchy
 Vxuk88hzwbAx/19PA4MGYzeR92qEFiW25dEZUnUvNCDK1vsuJDjjyBeQzxBhAWzsN6cz
 IDRMy+D3NUuAe7xRyRRr/pZ2jsLqfoWGkfSpMHtrYfDur2zIOIXIWwFkkuW2Yc3VHhq8
 Lrfg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783593706; x=1784198506; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DV4fitCmcUiKCZtjtAk5tLUiYZQoV+/boJKfHh87Guk=;
 b=pUVELvLXjO/Jl5FjshZUMumP15ywsVvQYdPF+2Dk1pN8LAMyxIpW0+J1y/5HnZZjCw
 m2ORsqEIUrI7otA00cNH6q0dgN6IzvNRomhZXSVhexBzbcBEW4yeY5baSWW7Pzl1snIA
 tyF8viJ93ocUJumE+6l9GBkfrGSLAH0OvAHOOlC1ChH8gk8/FN3qpbEhaKc9u95qf6dc
 8a5d2G6aB0z8xKMjVVjcK03mkgKq3/MKN0AGdJlIyYZfSpWUF8OBX7UnzYJog/kg9/i1
 nbaqkX1z2B5b6/4JIqU9rBfPEBIT9I3hyQ1SWZeAb9ffRz51OtRuqQP2t7+FoQwQw8nD
 8M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783593706; x=1784198506;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DV4fitCmcUiKCZtjtAk5tLUiYZQoV+/boJKfHh87Guk=;
 b=akiUaK73Sf4wWV5t3W29/Y7b7YXwqXbuYrrW5jf3lK9HwxT8KTsI6wWX/JmrkuAAPo
 XFoXb7Vyspwn8qzsT2h+DaywMTwzId1hes0L8VQYYaMQntPSf+fv1ZgtepsEjp1xQWX7
 Otue8jklS2Fl92p4H+Bo+NA/h7EnRzAtQQypULpMp13DrdmJ/zMRI17ZJltvTj2N7H+A
 7yLEKNIyjQKfNgu9B6UJ/mrh61/F45cOP9bYHo93oTMbS1YumbeLIeT0760X/Ik/UaXS
 hPv5JBVVkmwX5YyHsVaZhIDIfN5ONuPAwwWND99gxcUj+SPaOL0EoIUCaOgt0WQ9dKtO
 Gspw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ft1i01iJQFwU0fK3qAs27s/yukCytjLPinvzX03IFXJW7iMlLXqpw908rHUv///gObYLzqNk=@lists.denx.de
X-Gm-Message-State: AOJu0YzOIAK13ztMyUlF+pTH1NJVm9JxeMbqT5C9oVsCIpMcm6NGLIQv
 5M7KduHnnRypwZT2b8ooLRIriroAFTVGVvI+gmjuUYKjQPF/Cw1BDVr/JacJMVIrNP7JH8FypxV
 lHixZyBh0n39HBwOPqC4SdOHPvUgrtr/7QrTJpk3YiA==
X-Gm-Gg: AfdE7cke8rU57Wh5l+IcVqdxc9MH/u/KuL59IOZJRJUvadCtq57ajpmU9UCYvRqJ0WU
 AfM/+u4dPwRwbslUcXbPd9SkgU9fWIRzc/hvlt0I0341BmRI7JE18Rlh8evBXj+uVXOnEtfIW6s
 q37hsF2J3vcbC41oM8sK2FmUtj18l4TreH+77POR0/1n5h1J9eNO8AxMxsCg3gNORxOm2wObfOv
 PbfWxqds7NUpiz58hX431xhGz+TH8tluiU9xUFE76cUfgo3GGR6vPbyltxVFr/4cprWC0rjr640
 vX0lGOk=
X-Received: by 2002:a05:6820:603:b0:6a1:50eb:2116 with SMTP id
 006d021491bc7-6a36db94c97mr4515701eaf.58.1783593706075; Thu, 09 Jul 2026
 03:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260707205611.65287-1-ccaione@baylibre.com>
 <CAFLszThaMksN7J_u8-B+eDY6vi5WS-ODGD89GLG1j=wCTyRr6A@mail.gmail.com>
In-Reply-To: <CAFLszThaMksN7J_u8-B+eDY6vi5WS-ODGD89GLG1j=wCTyRr6A@mail.gmail.com>
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 9 Jul 2026 12:41:34 +0200
X-Gm-Features: AUfX_mxG_sU6jVYjAjW7A0ClOJudGVnepDMhcwUXu55ORFCov7HXSq0tpLTQCUI
Message-ID: <CADh8LscMRDTHeCh996UqgT3V7NjODiXR0wd94Cd=8tB5bUAN=Q@mail.gmail.com>
Subject: Re: [PATCH] fit: prefer the default configuration on best-match ties
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, quentin.schulz@cherry.de, u-boot@lists.denx.de, 
 dlechner@baylibre.com, jstephan@baylibre.com
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

On Thu, Jul 9, 2026 at 3:24=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:

> This could use a spec tweak, perhaps?

Why not, let me prepare a PR for that as well.

Thanks,

--
Carlo Caione
