Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA40CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 07:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53E808811C;
	Mon, 30 Sep 2024 09:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mhcQfs80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226C88841E; Mon, 30 Sep 2024 09:58:18 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E0788113
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 09:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cdb6ebc1cso1180449f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727683094; x=1728287894;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=di7PjWmvJ23l/Uq6NjYvmaEiwK8qZW027md5XRnvwFI=;
 b=mhcQfs805J89YanJUaHnyXJHWB6dJ/GlwAZm9FOOHP0wEXpwFVP9rGd/LgQPM6dxc3
 VPhFtkWzC+FtWbzziEdmR0j4H1HNHsB0cYHuFVQ7Yxq55NHKrxjGj5frfBzHhc7n7PM6
 lu2Yt18TOFmXEAzo+l9lWHmrZxlexKn6WrXtu+Tl1beVsjeTstgk16uZtkSDxROy+3Kd
 cboIpPPY+lzhIJ015z86X4Esf0FBApxN9G9ufMPrAgFY0Gy6mEPfe39oxSk2shZqZRvm
 0EsS031S7a8p4XTQrM5mJ+0NYX5bL/xKxfYU41P979n+arT1XDbaGPSuIWfF7oLu6AWc
 x4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683094; x=1728287894;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=di7PjWmvJ23l/Uq6NjYvmaEiwK8qZW027md5XRnvwFI=;
 b=EyYmTeUfOf0a7rvU7erE8eGLdypi+3mdPyEkB/87t+aLIJBcpgWNTrFTvlJAA1WMD0
 5zFc2D6GzF0F7v6NjNeHvBQ/zQhrJVFNFCW7KFFQQNAxMXyhDyqTnxptZ7SGnGDnBv2y
 Lj4QqUU+x1DZqmu8DxXvukIE+lQKK/gaA0JV7cXuWH7s0WK6i06eBrEWB0rZqk7DAyFL
 /N2jJSNtH1/XVRgdWHnTznsmPwjU5rVHKLzu7tMK2YsQwoZRWmhRru3gifwJB3WEv70Z
 d2yImJHs4bAsaJuRBdNqNpOouxK1qzT1uH6rjBd9yrZ/8oNvkqnO/ADQsU8ljy4IbsCs
 Eu8g==
X-Gm-Message-State: AOJu0Yw/QKo06qOTjaozOFBTC4sutVp39kHeR5zZEuXLds5peFFFCLYT
 1BMGyv4p6ecaMc3C3dUG+DvPA8Bv5KFZKvslrgeSZC+B+ZZixe75awQKqbA/d+c=
X-Google-Smtp-Source: AGHT+IF4PJoYwakvjYFSc5ASniYz4sT7ouYOHbN6JPfAkMDDtwiGkzTQ7syQkH2Jm/RDrN/lMrlNFQ==
X-Received: by 2002:a05:6000:1c2:b0:37c:cee1:acb2 with SMTP id
 ffacd0b85a97d-37cd5aaf932mr5034547f8f.10.1727683093825; 
 Mon, 30 Sep 2024 00:58:13 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6587sm8355197f8f.47.2024.09.30.00.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 00:58:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, igor.opaniuk@gmail.com,
 sjg@chromium.org, semen.protsenko@linaro.org, trini@konsulko.com,
 colin.mcallister@garmin.com, 4.shket@gmail.com, avromanov@salutedevices.com
Cc: u-boot@lists.denx.de, kernel@salutedevices.com, rockosov@gmail.com,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH v2 1/6] include/android_ab: move ab_select_slot()
 documentation to @ notation
In-Reply-To: <20240911214945.15873-2-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-2-ddrokosov@salutedevices.com>
Date: Mon, 30 Sep 2024 09:58:12 +0200
Message-ID: <87msjpmv3f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Dmitry,

Thank you for the patch.

On jeu., sept. 12, 2024 at 00:49, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> There are new function documentation requirements in U-Boot, so apply
> these changes for android_ab.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  boot/android_ab.c    | 43 ++++++++++++++++++++++++-------------------
>  include/android_ab.h |  7 ++++---
>  2 files changed, 28 insertions(+), 22 deletions(-)
>
