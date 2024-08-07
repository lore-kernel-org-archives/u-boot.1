Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B28C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E3D88CFB;
	Wed,  7 Aug 2024 16:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b8JinSWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B888D88D20; Wed,  7 Aug 2024 16:36:37 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B5388CFB
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-44fea44f725so8369621cf.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041394; x=1723646194; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ojqr18+o5ljPDysu6Wik0oniwE4n8zL10X9TqOl1/7c=;
 b=b8JinSWcKFOsNlhJbWIlLrAmp7lLiwMnGYYAZOTWA1loDVjNZ5WnjUYHP8AxUGXEhI
 X5k5dvWCZuFNgZZzEuIUCODhq3MHSPNIxPy4mkk/wNl54Yff228PGD9I6Xgv2XxSR0D0
 78+qBRYBWgn8mfOebCzPwUcVkRvJZ7tkaKpb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041394; x=1723646194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ojqr18+o5ljPDysu6Wik0oniwE4n8zL10X9TqOl1/7c=;
 b=n1BZ3Sge1ph6MoCOtw9K+B/BEBfouwxAe3+d7xe1dUv+YUCBevI/eSLAEFbzJGzhF3
 k/t5JkkxISqW51G9E6UXqYvlg0dNGwj1WRNrf9iYw4oqsyjUjcY964vcCzlZaJMO8K/F
 WC4ov4h/loXwBd9xBD3R/IWWsWyDeTg5Lhn6IgHHLbajo1ehmHZ5iITbMWwSrZdQ4MBv
 XMDDeOMcgRNORnT31cexSG8Ncco9Yge3rmCK2sGXc0rvlDPjTlwptZ5hzmTjT3pApz/4
 q4+FGbSyjI/0goyQ6r2KEK5f2lFejgLo9nC/adpmTRxz6YZeASIl6/tMEhl6+93MbXAV
 ne8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ZYswRxzqFjZXIVxSoGUgo4rUcyUuMQI9VhGuj7Zx1rgftnc9kCQvuFztQtZ19bPQLNK7l2nPKnn/OYVvIyptYDXcRg==
X-Gm-Message-State: AOJu0YyHFUFh1bYuRFEiOarPEQGs3cmzrtexa8ry/YfAyKWq/hUwcp1J
 T1v4SIZ6vXt2OysbFjjnAM711qKQqrG5f3wJyEXI3BgH+x3MI7Rx3r6e9JmG8iw2JbJqlh0srip
 R9XF3Gi7KDrc8RcVuMKvlPQjxN2yBpaLBd3AF
X-Google-Smtp-Source: AGHT+IHylo+fIl+0wLRAkstNZlQ7GbcPXMqE4Jq7D/U2b/87FyUuPdm5pF1tNm7OsOgwP1GNiE4MDuHRW4qjFduk+1c=
X-Received: by 2002:ac8:5887:0:b0:447:e6f9:f61c with SMTP id
 d75a77b69052e-451c7b02993mr44721911cf.22.1723041394379; Wed, 07 Aug 2024
 07:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240807121434.11761-1-clamor95@gmail.com>
 <20240807121434.11761-2-clamor95@gmail.com>
In-Reply-To: <20240807121434.11761-2-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:23 -0600
Message-ID: <CAFLszTiK=i+_TDQuW3dSgEyZgbhqvzsKD+28WO_+9SQUUoBH4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] board: tegra: convert boards to text env
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
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

On Wed, 7 Aug 2024 at 06:14, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Convert boards to use text based env. This is the first stage of
> conversion, common inclusions should be converted next.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  board/asus/grouper/grouper.env                | 15 +++
>  .../asus/transformer-t20/transformer-t20.env  | 17 ++++
>  .../transformer-t30/configs/tf600t.config     |  1 +
>  board/asus/transformer-t30/tf600t.env         | 16 ++++
>  .../asus/transformer-t30/transformer-t30.env  | 17 ++++
>  board/htc/endeavoru/endeavoru.env             | 13 +++
>  .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
>  board/lg/x3-t30/configs/p880.config           |  1 +
>  board/lg/x3-t30/configs/p895.config           |  1 +
>  board/lg/x3-t30/p880.env                      | 15 +++
>  board/lg/x3-t30/p895.env                      | 13 +++
>  board/microsoft/surface-rt/surface-rt.env     | 14 +++
>  board/nvidia/cardhu/cardhu.env                |  2 +
>  board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
>  board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
>  board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
>  board/toradex/apalis_t30/apalis_t30.env       |  9 ++
>  board/toradex/colibri_t20/colibri_t20.env     |  3 +
>  board/toradex/colibri_t30/colibri_t30.env     |  9 ++
>  board/wexler/qc750/qc750.env                  | 15 +++
>  configs/apalis-tk1_defconfig                  |  3 +-
>  configs/apalis_t30_defconfig                  |  1 +
>  configs/cardhu_defconfig                      |  1 +
>  configs/colibri_t20_defconfig                 |  1 +
>  configs/colibri_t30_defconfig                 |  1 +
>  configs/endeavoru_defconfig                   |  1 +
>  configs/grouper_common_defconfig              |  1 +
>  configs/ideapad-yoga-11_defconfig             |  1 +
>  configs/p2771-0000-000_defconfig              |  1 +
>  configs/p3450-0000_defconfig                  |  1 +
>  configs/qc750_defconfig                       |  1 +
>  configs/surface-rt_defconfig                  |  1 +
>  configs/transformer_t20_defconfig             |  1 +
>  configs/transformer_t30_defconfig             |  1 +
>  include/configs/apalis-tk1.h                  | 58 ------------
>  include/configs/apalis_t30.h                  | 12 ---
>  include/configs/cardhu.h                      |  4 -
>  include/configs/colibri_t20.h                 | 11 ---
>  include/configs/colibri_t30.h                 | 12 ---
>  include/configs/endeavoru.h                   | 43 ---------
>  include/configs/grouper.h                     | 45 ---------
>  include/configs/ideapad-yoga-11.h             | 58 ------------
>  include/configs/p2771-0000.h                  | 20 ----
>  include/configs/p3450-0000.h                  | 13 ---
>  include/configs/qc750.h                       | 42 ---------
>  include/configs/surface-rt.h                  | 18 ----
>  include/configs/transformer-common.h          | 91 -------------------
>  include/configs/transformer-t20.h             |  4 +-
>  include/configs/transformer-t30.h             |  6 +-
>  include/configs/x3-t30.h                      | 44 ---------
>  include/env/nvidia/prod_upd.env               | 60 ++++++++++++
>  51 files changed, 332 insertions(+), 476 deletions(-)
>  create mode 100644 board/asus/grouper/grouper.env
>  create mode 100644 board/asus/transformer-t20/transformer-t20.env
>  create mode 100644 board/asus/transformer-t30/tf600t.env
>  create mode 100644 board/asus/transformer-t30/transformer-t30.env
>  create mode 100644 board/htc/endeavoru/endeavoru.env
>  create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
>  create mode 100644 board/lg/x3-t30/p880.env
>  create mode 100644 board/lg/x3-t30/p895.env
>  create mode 100644 board/microsoft/surface-rt/surface-rt.env
>  create mode 100644 board/nvidia/cardhu/cardhu.env
>  create mode 100644 board/nvidia/p2771-0000/p2771-0000.env
>  create mode 100644 board/nvidia/p3450-0000/p3450-0000.env
>  create mode 100644 board/toradex/apalis-tk1/apalis_tk1.env
>  create mode 100644 board/toradex/apalis_t30/apalis_t30.env
>  create mode 100644 board/toradex/colibri_t20/colibri_t20.env
>  create mode 100644 board/toradex/colibri_t30/colibri_t30.env
>  create mode 100644 board/wexler/qc750/qc750.env
>  delete mode 100644 include/configs/transformer-common.h
>  create mode 100644 include/env/nvidia/prod_upd.env
>

Reviewed-by: Simon Glass <sjg@chromium.org>
