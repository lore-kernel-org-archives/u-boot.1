Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4E5C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D5180F67;
	Sun, 23 Feb 2025 13:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZAXL3MbQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE9880FD6; Sun, 23 Feb 2025 13:51:20 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B26A807A8
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4399deda38cso20972005e9.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 04:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740315078; x=1740919878; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJmBUJHDGmKHhnZrNJ4nQeOgTubJ9Tl13xE0o8FhlLc=;
 b=ZAXL3MbQDTkR7T/q3TWRGu4ukO7Dd9M/fJpeJ5TC+KjZ9gnMVOccfJDIbncJQXsNnY
 CM3dK06nBVKeG1frZanFI9EcATTgCFpgwwr/jVScK7WD64EOm1VwZ+Y9kb+5tgr+kbog
 J4uGuaLrqJSSW/y+tAInY1saccsjJfHQL11nUrZlO7TpzbNDsAi1HaKxRJUAN/jJYWoU
 iQbVajyAfkZbANd+16ZYdPTaQBjDf9OyYwbXuJ7xsCTK+SaBGr7jXTByH6YtRb0wSl8n
 cCXqMwNVPapAcOwCG36SGz4NLjQTUWeMBO3CfZcwbEHjh3zSSTsErCdSjuocT0sMOagl
 King==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740315078; x=1740919878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJmBUJHDGmKHhnZrNJ4nQeOgTubJ9Tl13xE0o8FhlLc=;
 b=e+i2b6jXofZP4ZFlvz8UvcGH+UnLj85OzN4drAPqDbCqQAw9bRT1j2hjgp8pPX89bD
 pdl59Xk+y+ZoBeH8u4tD4HLYaZ9g2kxJAunQMCpm8tonds/6CBxoQZOsxlkoy4htf/a4
 4XeiuC2PU5q/ar0AvzrPwJRoOgqottNGjvmbEX3h3N31YbtbiRm7M2BwmD0gppMZvZGI
 ziXi/zoCu+qUf2ltLvJa81LHneLH9bJCNuY8hdsxhpNc5g9yOVSv29vjU7xlNp1humb7
 /NP4YkECNBRnM4dOHZxB1tg4ITyu5sEdnDGJaNEuodAzBHnguyX8v0SJ0W40qDxJeOH0
 M1Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxXUyjRgC8vTaPnlsh7eFAU9uG8/bL/LykqDJ0fIlr0YS8VpARjG/phrMjRJqWYMg9++d+Gu4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzrk7n3Q5DGyL8TxTLGmBHVtrrmNKh1SICIqOoYmrCUQ1erSspO
 tFMjOQMjMnKQUZJ9EoljAPcgjr8P4YDRCxgU5d1A8OSbS9h/78ZRWmrR0i6dimqTxaEMxXpsrVl
 +9OEr/89F+MqwunrfG85O9ldDAsM=
X-Gm-Gg: ASbGncvUJK7xhFCelWPI0xZfcu/+Q0bUDZRrrmZW5069StoMjxPb1FKhBOZtE8reKL7
 1GttpCKgAFTNccvBQPtZhIlAsG3t4RGyOoqFrFZo8jZlHx0yHffZSb/IFDZyDRDbPsxcFo4luaW
 UAaiYT5TiM
X-Google-Smtp-Source: AGHT+IFvp5Dw6TczZ3k2UVsJ31dfzOn+A/xhlveiVttczZyW3ULsc6Jc0Ucm19L86c29cFYrlR+7ooraAU8vfbmbuKk=
X-Received: by 2002:a5d:4e87:0:b0:38d:a879:4778 with SMTP id
 ffacd0b85a97d-38f6f0529bbmr7992130f8f.33.1740315077788; Sun, 23 Feb 2025
 04:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <20250223-vop2-pt2-v2-5-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-5-71350e482970@riseup.net>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 23 Feb 2025 14:51:06 +0200
X-Gm-Features: AWEUYZkL2Gm70O5ifdPzU3L0L7FJu8jLq_SgNbJTLqScwOBgXeY8p7tp24UwDMI
Message-ID: <CAPVz0n2zippDGDmr5afKn6J37-TSyESsbQQJV5fVzmJb_1e02w@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] video: Add BOE TH101MB31IG002-28A MIPI-DSI panel
To: Dang Huynh <danct12@riseup.net>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 23 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:14 Dang=
 Huynh <danct12@riseup.net> =D0=BF=D0=B8=D1=88=D0=B5:
>
> BOE TH101MB31IG002-28A is a MIPI-DSI panel used in the Pine64
> PineTab2.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  drivers/video/Kconfig                  |  10 ++
>  drivers/video/Makefile                 |   1 +
>  drivers/video/boe-th101mb31ig002-28a.c | 236 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 247 insertions(+)
>

A simple and clean DSI panel driver. Well done

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
