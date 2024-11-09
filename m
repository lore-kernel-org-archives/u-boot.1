Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8D8D5E367
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 12:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB22B89112;
	Sat,  9 Nov 2024 13:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OgKSQrHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D19F8911D; Sat,  9 Nov 2024 13:10:27 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9822289110
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 13:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso3861461e87.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 04:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731154225; x=1731759025; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJabnjEHfh0qZgD7XNfdFKL6mFLDZwk1FSDS+eQJdUI=;
 b=OgKSQrHs0v915kHpanKokzZ1db9xUNXfVNXqv48ETO8TB+OyarNB8lVmF88sS9dxF5
 DkUBfWrobS71lZ5cDksYymlIVbUe+qs5c5LyJUCYYtBtOINKVlQ3674gOaiqF12XxZ3x
 EkNaqdf2ZZbyNTZfhDSP8HyMjckHJcpsY49Sw+DeIdo3/rgYASmBDpwWgdC5Rr+tQ5aQ
 SoFzbfltAZH3X37vpv6s9m7b+4PPM/6BeApKJWZi15VlHp8n5E/pAFpmeDUbffOmBJpQ
 S4qyugiBNideZanpKXLNawwGVitj3lSBva9i3naLPyKy2+uC1S6xxX6qzX/+nqk4RhKZ
 vptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731154225; x=1731759025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJabnjEHfh0qZgD7XNfdFKL6mFLDZwk1FSDS+eQJdUI=;
 b=QM4aJ64WmXPaYP/tiqI79/NkXWEtsdIplwzOs3CoJOAAWpo6ZRNdw4GJkGkp4zHb20
 8BqjfqWKg58cJJFyj2p3zNqFTXwtIqOllt1NXP5bOCWo98qe1usoCHh+4rObtkfKTOah
 7X93Jd7uiMGhS34/5dmyuRhRfRgrMKRqS4RANdEKFu4zq8HBSEAlMfpIHhW2utUqUUnR
 y1GqnKGZwV4DEgpft1vR0wrIFoYRAxnxRpysyLfbUIfgMApLYmf5jyr7r0ilR/cHRAad
 mhSjcEXQN0RamSgi0FOP0PMz58fEB2P2XkYWWsVG37XJ5lKstWgtJsI7KTCMWHVpuFWN
 z4cQ==
X-Gm-Message-State: AOJu0YzAzO56ty3BlO/pUq0qnAUjAmfT6RBihwBxj539kpJ2ZSK/7tJb
 h2GVmdCDRGfYqkD7HrIr15QA/m9+legW+89YzhjNW1gCQnJqnuKNg460p0dCU+IngwHYQCOXX5R
 iYRlBPEyCp4EO/awgUz9SoiyPZJ4=
X-Google-Smtp-Source: AGHT+IHm8GP5YI87PyCDHjlZDmUag7bDhPjCQtOXWeiFk35r6M44or+9QMO5TSsJp7msKMXaGvero0iYg1BYfwrEN3o=
X-Received: by 2002:a05:6512:3408:b0:539:8980:2009 with SMTP id
 2adb3069b0e04-53d862e4d8dmr3090373e87.36.1731154224726; Sat, 09 Nov 2024
 04:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-14-hs@denx.de>
In-Reply-To: <20241108052143.26874-14-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 09:10:13 -0300
Message-ID: <CAOMZO5ArGpi0TU9EVT+TT4g=M30d8h0HDt6=rtTipEebXr6_kA@mail.gmail.com>
Subject: Re: [PATCH v1 13/22] siemens: configs/capricorn_cxg3_defconfig:
 updates
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Fri, Nov 8, 2024 at 2:23=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> make savedefconfig and add SCU_WDT and fix environment
> offsets, as since silicium c0 the boot container takes place

s/silicium/silicon
