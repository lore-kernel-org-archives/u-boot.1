Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D39C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 17:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516E388905;
	Fri,  5 Jul 2024 19:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P9D7iEPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617F8889B9; Fri,  5 Jul 2024 19:57:02 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED4288905
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 19:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so3315123a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720202220; x=1720807020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uXvPg8atQcBo3ULyIAsWJ239G37p1Wf0N/VdxQ1bmz0=;
 b=P9D7iEPaA3wGLWU7vcOuksZm+MJfIYUuU1E9c2BaVZkOiKXLTcuxihp+wBrbyTN0JU
 ucPiEHHp3VK00LzDqhX+WZCj6fgauTZgNxPiF6pAP/G+0r4GhhYn2SWS4vVVDjChQYjl
 Lw0PGTa/2byc04x75RmMeL40N6UyaYQew4YDyTZn5eXMEYqzfmbHx08t0t5t/LiN8GHs
 Szg8nIrPigmas+XA6dgwbGIXvPwGfmn4FsGfPQKhaQO9Ox2Y4t/bCv6fJGFUAgxhqwMF
 ZVlJrRsxzqmZI7q6GNOsdNW04U1YiKW6T02ckG611M72FCqI2y/xbJvDZwoPq9HKPwkk
 cMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720202220; x=1720807020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uXvPg8atQcBo3ULyIAsWJ239G37p1Wf0N/VdxQ1bmz0=;
 b=LJ7oaypjp69xuKYv4iRi+KXc5grZF61shas++Yc8uI8Tq0QIq3qA/WoQk0g3aES5TL
 kJ+V48M9wq5wp/ph6KOkDEvJ4BJy2YDRyar7QpHo+HD9nZHTucbRx9Wjo0TUIsMUW3Xt
 ayFqbSgRrQc0mceIFEc1mHZU0eZhE03NtKrV/7givKoEYJs4U6sFxBc1BPC3LEMtQYzl
 bOTJ+yhA9MpyTQHiDM7BHhF0DuLssigTiVjurzxeYVVz1eibNvgMsQcfiE1bFPjMMYKz
 PeYJMdaic8JQvt5keZVFEqIqEGrnR/efWZkKTfyKbvKNsZZUAvVnoCiZDAi6SwcRnitK
 sVEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWn9lpIQKyf3WOZlhpbrP6ntT8xCGimeRH0aJYdz/bf3chtXCdKo9FrU8+vrg6TN3p2CMW7mcOiwFbPBRknqxC6W92xw==
X-Gm-Message-State: AOJu0YzEDOnlbjE+aHLZfPBWjG0p3EF4A5JLRlD6XlkyPtRGrEHvLdaw
 H5ozh4c4LDaTNS5wTK0h8SEWvPROifWetz47ZglN0EqsVlutL86reRN3aZ6ACDgIEbqUzKtTjhk
 V6qUJtzjQP7/RQL51jDm6rOcWPcA=
X-Google-Smtp-Source: AGHT+IHIHALsJbTJPghFzMSTY4iEKY493BviUTMJVlTfDCN3mGnQ1MrdDMvns4FSyI6Pzfkh5/sUkKaldZy6qnPz8kw=
X-Received: by 2002:a05:6402:2696:b0:57c:7f3a:6c81 with SMTP id
 4fb4d7f45d1cf-58e7b1198dbmr4039418a12.8.1720202219639; Fri, 05 Jul 2024
 10:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 5 Jul 2024 18:56:48 +0100
Message-ID: <CALeDE9OrLw4h_iZKb=1BFHUJKPLrPFirVwEb67ynh7dFNJV0Sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] net: tcp: improve tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Marek Vasut <marex@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

Hi Mikhail,

> This series of patches greatly improve TCP support.

Where's the changelog of what changed from v1?

> The benefits:
>  * a lot of bug was fixed
>  * tcp cliens becomes smaller/simpler
>  * fix data uploading (now it's possible to transmit a huge
>    array of data from the board to external server)
>  * data downloading/uploading with netcat over tcp was added
>
> Mikhail Kshevetskiy (9):
>   net/tcp: fix TCP options processing
>   net/tcp: fix selective acknowledge
>   net/tcp: put connection specific data into a tcp_stream structure
>   net/tcp: add connection info to tcp_stream structure
>   net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
>   net/tcp: improve tcp framework, use better state machine
>   net/tcp: simplify tcp header filling code
>   net/tcp: define a fallback value for rcv_wnd size
>   net/netcat: add netcat over tcp support
>
>  cmd/Kconfig          |    7 +
>  cmd/net.c            |   34 +-
>  include/net.h        |    7 +-
>  include/net/netcat.h |   20 +
>  include/net/tcp.h    |  227 +++++++-
>  include/net/wget.h   |    8 -
>  net/Makefile         |    1 +
>  net/fastboot_tcp.c   |  190 +++----
>  net/net.c            |   30 +-
>  net/netcat.c         |  159 ++++++
>  net/tcp.c            | 1253 +++++++++++++++++++++++++++++-------------
>  net/wget.c           |  479 +++++-----------
>  12 files changed, 1538 insertions(+), 877 deletions(-)
>  create mode 100644 include/net/netcat.h
>  create mode 100644 net/netcat.c
>
> --
> 2.39.2
>
