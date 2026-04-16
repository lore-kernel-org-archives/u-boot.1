Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E535EF8D77C
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE2A840AB;
	Thu, 16 Apr 2026 23:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LSkDJ7hm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A01841F2; Thu, 16 Apr 2026 23:08:41 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2865383FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso167355ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776373717; cv=none;
 d=google.com; s=arc-20240605;
 b=WsGO0B5j6YDzteDRUt/kaQh6Axd+BYVmGLsVWPYAhi/uRz1QMUDGVZbwsfPKTm/vR1
 mI2AjxZevLykqS754iRXGdKxs0XlSvKFvVBpzt4GASLyGEZzN2Y+6oH5c+WJotyyywzf
 jAHWpYQ6O61PGt3KDOFGr38wWiQhbW1Zz4/FIlDSTXnOl/atVL1jiqw5/6fEVETnD9gz
 pwmIxizMVSzJ9+1jNXQJXMo9PNCq991aHlVKkOkHb+YAphG/pfLHcQsxV+pLADRxIWM/
 mnRx1ob5+IzsYLu32nyb0MQ4daaUxoPXnfKuiljb8y6PqeFMXZXYkYznBTc9kkzD1xkV
 FAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U8ZJDV+Ff1nLIszPt3UlAds8BFaNIfF4BMU0gmEA5uI=;
 fh=hdsWtO79BuA+Rf4y39hS4y/wN17eZ8Uk6KkZ1EHP+lI=;
 b=j4AFlWuMQRrYT6mASdAA5SC0Nbh2o+Exzt4+jMg04y3CQIjVc5hi6rbCoitD6b/XvB
 bI9h3ftzhWS/giD2H2sMOT20JxLLf6O/e7yd581126Q5sna0pLLWU2bsnjSto1823/uI
 kIHdNWVdUkjYWC8FiyybLePclXdwdh5FXp88ZOWquaa4r5mD8P/yOtAjI4mWJZosXQnz
 GJD5uOD2dGLjqsfgixPFLQyVaaRYz5/DYg07x4Afopd8R10AVYtbabc1W8InJbTylNL2
 NanL+/if8PZ0GgQJarQA2peDKH+oJ35peseSrpO+X+jtWaxYBDCgSXxkDgKRS/orxc2h
 kebw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776373717; x=1776978517; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U8ZJDV+Ff1nLIszPt3UlAds8BFaNIfF4BMU0gmEA5uI=;
 b=LSkDJ7hmdxT9MnQJTmzaYmlNwhpYvFexnV71935WkXN+d0rXBYPvpL6Tfp/hfjbLUX
 XwxhUG5awnNKZJVjnGyRggBIL3NerKBrM5EodW+xfZ9+RQUb6XuZT4TP5ttz27odO3bG
 PbDtRUWsT+r0BpW7fRNiIgxRe+BxEgdyCMtBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373717; x=1776978517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8ZJDV+Ff1nLIszPt3UlAds8BFaNIfF4BMU0gmEA5uI=;
 b=sRVWYgkGgJ0mFkBWTZM4oCQD0jiOwiqqpv0PbG5LlYOhkD+PPbEoZDq8GSSgxVVeNX
 2ZyCdEHfNYvid4IQyb/T4ciUSUrzAOn3fRQEc16MBPHCqpgJhtu4Xw0XK8WUVcYeGzLi
 4TDoP5onrXJ6+od3ljHWI9KsdHMwDqnxOvJfCyl6JbVy8aLnnlUI9DxkRZpHs9mrzesD
 vMhDIUga62Km06d4dWt+4W88oY8QhEQZWweXRhCIkiO/+XiUrqxaV4uUnsm4Csiwji/s
 q3QrAz9EvgAembzkdREgCxn8H7TdIks7cR2dVvPzaxkAkwD/158J/39Ll1rSdCa49MdD
 By3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lB1SrqggAYHjppjii5TExzeNZZuEWDn7gDFCiUkH57CDJH/4rf4oDcMPbJKU6J9pTXfNdR68=@lists.denx.de
X-Gm-Message-State: AOJu0YzHol5n05ZpZuGlJu3mA0eEgdCwbvANmKM/riRtEHs8POpbENOh
 EDpq2x2sgeI9J+LEV6Ersskbs/VFNjqbVT7bTh7aaYd1HM2/RpKZofHLIOSzb2H2Ki61//JvqSV
 GIxe5zTb6UDqyPIBu4r0nFMoD+7ItQrXRd5UiVcsyU0xPLtJHzSsKtg==
X-Gm-Gg: AeBDievcTyFFLpCC+mjar8Z/tkz4LWaHmgA7HtxlhBc5KNkNgY8UkLIx/fTyiIG5MhU
 JYGTUC+kzLZ0tly9EDhgk1HleWSRarYsJEFvuFfw7bonZkOg6EuKH9XlgKufDO1iNe/1YDu1QYf
 rXTnpcKTl/lJa0TRAnzFXhVQPbtz5bsVCb9rVsDmx84+eiGF2rTPGBdZiEKmaKFJZDlwOESLNcz
 vFtL3HnkV4K1GNpGoSBNgcFNw0rlXzfLkgjGOPMZMU3dGP400YTuou9UFy5+kyFKd4mntLfC98I
 myQyBv215cV9KbiDvYjFeKTS/UASQX4=
X-Received: by 2002:a17:902:da8f:b0:2b4:5fdf:f91f with SMTP id
 d9443c01a7336-2b5f9dc3154mr638745ad.4.1776373717422; Thu, 16 Apr 2026
 14:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
 <20260416084535.1490476-4-ghidoliemanuele@gmail.com>
In-Reply-To: <20260416084535.1490476-4-ghidoliemanuele@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:08:20 +1200
X-Gm-Features: AQROBzCDL_FDQkRPoCO18pCbD0IPWBAQIpEP6g_FqnhI3J4Adr99ZgxP32_vTDM
Message-ID: <CAFLszTj_x2h0iW1zLio5sgvs9U=47VN6khVawVTsLn+Ue87dCg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] toradex: tdx-cfg-block: add verdin imx95 0226,
 0227 and 0228 pid4
To: ghidoliemanuele@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On 2026-04-16T08:45:22, Emanuele Ghidoli <ghidoliemanuele@gmail.com> wrote:
> toradex: tdx-cfg-block: add verdin imx95 0226, 0227 and 0228 pid4
>
> Add these new PID4 to config block handling:
>  - 0226 Verdin iMX95 Hexa 4GB WB IT
>  - 0227 Verdin iMX95 Hexa 4GB ET
>  - 0228 Verdin iMX95 Hexa 16GB IT
>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> board/toradex/common/tdx-cfg-block.c      | 3 +++
>  board/toradex/common/tdx-cfg-block.h      | 3 +++
>  board/toradex/verdin-imx95/verdin-imx95.c | 3 ++-
>  3 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
