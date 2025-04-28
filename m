Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E74C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976978056A;
	Mon, 28 Apr 2025 18:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WEGcBidd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E6F82103; Mon, 28 Apr 2025 18:08:59 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098578004F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54b0d638e86so5855187e87.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856536; x=1746461336; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehzhF4WDKP9zXC+pV+VRY9mfP4+qlL/a+IcLnfCSy8w=;
 b=WEGcBiddDCUFHmXcIyt3FNEQLHeDARZHaBvH8CbnaFogBo9KccYkwpkbYnT8tNWC36
 mJsSUEIACuKuQx+orPOEvKIUAnsP1t02GkAA/+/Xau1IPs8Av8dWXLjNqB/Eb3imCzs+
 sfyiYI2TQ3COHqL0KZnnalZjTfcrR3pgKpocfd4SjfpiIlDnBrdv0j2duo58MLs88b+g
 Kb1TlYofMwqHE9xpUK4fRZ/9QpJjoJwyvz4TN4TILB2YTovk6uzsQMDPuqNl4VsO6Yje
 23cMYrHln7/bZxhAHq98TBMCmJi3PveT59vaFMYx0+kl4pHYqvSiJlcJLjFQe27Xs657
 0MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856536; x=1746461336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehzhF4WDKP9zXC+pV+VRY9mfP4+qlL/a+IcLnfCSy8w=;
 b=HdvRuNxLDXtI91qslGzML4DmS9qqxnjLBTSRlypxLikafKvKlypJQBGJvBqoT8rELa
 X+IjVoc1gjwe+Yw2aGIj6YqZHULcVMywzJLclgxRch3bojU5zTL8huvsvK97YaIowLcj
 d+0DfqJNRy0VFWsgUjPmUFfjquK2ercpeinunkmen3mAIhXHGGon6ASvwp9Ro1bEZVgG
 xHiyUeC4o3USmOoufo0Sa3t6kW//sqgi8i9aqKufTacK5dTQ/z3Q4S8cnbssStkDqla0
 n9W4chU25UvtfBnwoBEkBSmaXR7yuEEhxK6OoJMaXar9zEtUkyASll4pwmQb1XizmfSf
 LeAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGO9MG6HqF5fYpxo+N2Pxrfn7eM8iZBWlHBoZ7Qlte+XUBN8xIJGPVf/stn+ewSKD9StNBR2I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/oTzRdeAw+Z6o6cbXh4vQwCdolvG+gn9sBIxU2Ss9HIgEWTmj
 vhcwqXOVjI2eJ6PEEo4mNSXVd4bDoEONkKdTWbQ2TRRay/FlnZulWymaycbm4xVG4uylwKji7p9
 /nyMMJeRwljUPkpo34j+hdCbCCgk=
X-Gm-Gg: ASbGncswD2NZqZH1a61O6yC3XDf9EMLmSNq9ZLOzrgv+d3eoworkxMWKwtakx2E5czO
 Lle9+1KjECCFfXSr0PUDhy/Mkc9nZPNtWuuBEv/wyVsOthxbeGZ78euCiAoua4WTKeIX+ARDJ13
 XKm4X3/yKQW/DAb0LBBRfOIgAW9FMDJU6Hn0XnBY7DnvwrzCZL0Dz3ZQ==
X-Google-Smtp-Source: AGHT+IEIUnpkeVu51ZNBXjnlZ2suSDhwLNcmYUeTlcB5Bpvb1y6HjbARQjJUh/emsUbdxNxNmUZ/YXLjFOQNCk3kIGg=
X-Received: by 2002:a05:6512:3f26:b0:549:903a:1b4 with SMTP id
 2adb3069b0e04-54e900110b0mr2416573e87.52.1745856535831; Mon, 28 Apr 2025
 09:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250424082909.1396771-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20250424082909.1396771-1-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:08:43 -0300
X-Gm-Features: ATxdqUFR9iXmZhfH4qnY7qvfqL_cQzcd4_kYmNAXBHaFPGzdIleiPlDp-SjDuLE
Message-ID: <CAOMZO5BXsO0eEjo4-5WqCrhWrizhmeDG_eMZ4HysiUerQSDUvg@mail.gmail.com>
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: fix verdin imx95 sku 0089 pid4
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
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

On Thu, Apr 24, 2025 at 5:29=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> The memory size of the 0089 SKU is 8 GB instead of 16 GB.
> Fix PID4 0089 Verdin iMX95 definition, in the configuration block.
>
> Fixes: ce53f46f33b4 ("toradex: tdx-cfg-block: add verdin imx95 sku 0089 p=
id4")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Applied, thanks.
