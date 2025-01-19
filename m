Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D32C02185
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 00:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA88800CF;
	Sun, 19 Jan 2025 01:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AYWRWR3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4310880141; Sun, 19 Jan 2025 01:22:42 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13308800B6
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 01:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2aa179a8791so2966390fac.1
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 16:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737246159; x=1737850959; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ze3Fozo54dnrXzweL/qGgs6GjlL+DqY9p+0RPxGiTFo=;
 b=AYWRWR3E16nRarJ4g9sT/V3U50W/5UCP2v8jJu6mDzIv5LCQGTzWWNAx2Clm5fg6vr
 tRxLZAbBAn2d9C2RSiEDFHPOxBOX8e+eKaaEgwIKCkN03Qn+ARj2PMA/hrQTWpw7rS6z
 yt9K8OI94OEEUkwKM4MUuSNoeDx6FawQVkRKsck7649d9ubmbWLn7qKm8z1VDKlJ5Op7
 JdFrujwOeNoAKjLlrfHiBR3Ggt9PmCBFgaA8tlRFgJJ42c1RtmCh2piO0/kD3+AIsAsx
 v1a6sJJo3Ay+2DUZ4Np9inhu69ChG5loMABco4cid5XxSjeJgDHkliNWQGOnlAEAR/4u
 K9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737246159; x=1737850959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ze3Fozo54dnrXzweL/qGgs6GjlL+DqY9p+0RPxGiTFo=;
 b=IdhZUiauITSvM9d7q9c7767cxiOnVh3l/X1CZJCiuaPvoorpSiIXDkU+VkaTpQujmE
 +K6YXm5OK0wnJ/NCxQOpV6tFWmSryrKXcnin3fvLD1st2O7SQMpreJpsVgRkXydgGJ9E
 wDGaw3VBbs/uj5MnSzWu1M3kdaYyATa1NUc9hBepzOK+jHoSEDfwWciVqokOMozfVhon
 uQ+RfStkEyztuhjg4uFBcS+IMlFD8kf330m62Rov4CLpUlJWyDoMW45BEOHUk9+6Oqii
 VuWPCa2Ehwk++ql3hIaR1IbkAkeY8NI9+lh5YlwL6K1S1ve5Y/f2EIc/jkgzZaxlhQt0
 l67w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCR5BBOQojGxM+QaJ8yw9lz06NCv+RdB5DcqyMFG1f6EiB5ZV9uLyDMYl7SndthTf099htFTE=@lists.denx.de
X-Gm-Message-State: AOJu0YzB5L0bVRlf0qzbQ6ZbuaCd+pSU4LdYjxABbrhzUMZYXEuBLDsN
 rY4vuxovINc5oKRShbaxutTKKv77Vi4nyBEbHaTBuaAgHLuzLEe3lIvaJqOIvwSkzHpGV0Zd9M2
 IdYOSUbxNly+tW149uZUMaS3OSmM/dsmY
X-Gm-Gg: ASbGncs2jUjSucGq4p7xcwLopi9ENejhtN27TYB6Qd7Q1I7d/ttt0+JP5bwo9/TQUEG
 b3dSbuxQGzgqCjQCOl7yTKZZMc5MBZGo3gfV2bEC9O9twvq4iFBy1KIC3+fWPPljDUQ==
X-Google-Smtp-Source: AGHT+IGzF6tR1aTlY5757CW8zfYWTDx+r8Dss7j4eG8YVijjfCmcFAydopIpYF1XTJcRYM9TuolBiCjqGy5d74ags4g=
X-Received: by 2002:a05:6870:391f:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2b1c0de7181mr5071983fac.30.1737246158799; Sat, 18 Jan 2025
 16:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20250114052548.763611-1-anarsoul@gmail.com>
 <CAJs94EbAfQ8Ht6tiX_V=wcVP7cADzuAGzJSLn4KZnVPXN_0XDg@mail.gmail.com>
In-Reply-To: <CAJs94EbAfQ8Ht6tiX_V=wcVP7cADzuAGzJSLn4KZnVPXN_0XDg@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sat, 18 Jan 2025 16:22:12 -0800
X-Gm-Features: AbW1kvY9-oGk1iXbhDFMt_Zz8nIRJgUJntsMBYgmF-YeC5x8DsYthJYM576o0Sk
Message-ID: <CA+E=qVf0hACH2QV2o+-jJhSgL0rPpgL-tH0HDef+C=a39FQarA@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: rockchip: rk3328: use HDMIPHY PLL as a clock
 parent for VOP_DCLK
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Anatolij Gustschin <agust@denx.de>, Dragan Simic <dsimic@manjaro.org>,
 Chen-Yu Tsai <wens@csie.org>, 
 Christopher Obbard <chris.obbard@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Sat, Jan 18, 2025 at 4:53=E2=80=AFAM Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:

> Both UART-console and HDMI-console works with this patcheset on my Rock64=
 board.
>
> Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>

Thanks for testing!
