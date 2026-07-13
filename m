Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6B4C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDE784C31;
	Mon, 13 Jul 2026 16:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="loWlXI3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1233D84C36; Mon, 13 Jul 2026 16:23:54 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355CE84C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so5382342a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952632; cv=none;
 d=google.com; s=arc-20260327;
 b=srwb4LHpxCdqvLXD5tjrqr1W5XykdBM146IVVt+bxQKTT2j55IKrT+9Kou2EqTtw6F
 fAjxd19m4tCr/djGj7eRMgpf/AD571kqPsZfbACCA+NUCw0j1Jy47yvM9h33vcIyHzF4
 98DUcjbUxxroQvL81XslEGhOjA9tIOanE5BFKChO82cdo/DNEyLxlYBTRpFtJVoTZVDh
 cZVnilthi+kPO4Letz39T4FEt63S7mAYWKSPTxQvIN35frcDb0X5Jduz+c6ikjN9ir85
 1hZhiBIPGgba07PHFOOwjEdV62ay1FAG9+1OlCg5pQkgF0O/TjMDuaWUw9TgbbmUvbcn
 qSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z7ZGLVobTEx0DMSggWo1ZBjjJh3OoLvaD7pK9n6vK/M=;
 fh=+jxFOLNeFqIMtjzmIbEe5aAe/bxE8NuzasSPEDT7YHs=;
 b=rV3scGa1zIelF0RXsecbjrutg95nToBSQWRO3g0YYuF31BEVL1j0XTa/K9KG2kgM22
 HizStjfvH/0Ieb7wFnPUILGteqf+SHJ/A3tJZ/qe5RKT/vC8vce/SSixkWDIDTNq85Sn
 QP9R8iNT42a1vL+16pbDtO2rmrLWPS3cQmSg4lsOQn/r9WGTLssBHmfrfBHqXYOZXL2A
 AtAi5o9WIU6Tuu0vFUKI2GmjVupE/KAdg07GemO83ClldO43jOG/Mihf2mVA8g+9LZ1O
 37p8zwNmtw/+AwyXriVU2YOJm7TzBoTdIiDw/pVcx0EVLJgmR/JvVlTg6X10nIzuRDSe
 KeIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952632; x=1784557432; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z7ZGLVobTEx0DMSggWo1ZBjjJh3OoLvaD7pK9n6vK/M=;
 b=loWlXI3X2UWd/MNOA50q1RtrQsojrHwSa0vUEKVzLplgTKhokflg9cW1g69DOfIlV8
 1Eqn9pqeVD2Y/IXAqbiL4ibJ2du6fy0yXoiKQ0pFc60PHFvK4zvW6A/7bRsIdmIbkvV/
 iq/LCOhYV638xXKkNY1UliEzEm4cGWfcRW2ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952632; x=1784557432;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z7ZGLVobTEx0DMSggWo1ZBjjJh3OoLvaD7pK9n6vK/M=;
 b=DD8rqMfy9Jnh3MDYLslobn+CkcVfvddezaTRGK3qTpYYnu4hyj5wRqI8BedAPE0cok
 ajDUtb3wmdUs8e4GE9vDWpno5ZEd8aUyfC/9xlLxPFp7s9wTE4gcvfF4UiZ3eqtkZiso
 M4HWwWwEZiRg6H6zToA/Jrr4wObejdKjcXIt83v4w36GV6r9llJYvOMuCDaGtvA9W2AC
 lYDCEwn6EYjATlRDwUzVg4RF9mpGLMaFTVUPGE2HNmTFeBE2DBDu6qDDa0TNliuzPR99
 QpSS3v4COphZ0RESGU6LeJyYwJdrS5Cxvr/WnIHIw9q9AqdLAu9ppH4q8Eoq3v3YB58T
 MvrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RovY7Isj72x+CnMnL1h5lQZ/uYqVlVt23EILZNoeMsRM7VKxrFSmJQk3MrX4/6zw5GWiCCENak=@lists.denx.de
X-Gm-Message-State: AOJu0YxnO9YvQlbK3SPn79vcNEl3uNzZ3pZHuf83aBG32AY+kSzhTmS7
 CntJvSykGnsHJDi9G3B9oVOsgjanpOwA34mE9hcZboTQI3rAV5Z+S+3Vmuy7LMdnaUmEcvbkOa3
 WesGTAK5mTuqgn+e0TiJ1vdL7AtIGmhcleNL7sxQw5vV1p9o5It4JgA==
X-Gm-Gg: AfdE7cnZL5EY6aK96Iwary9Fq50mZ58ecBL3BiBvlmZz1gAKuytaL8z7irXZ7kkyAFN
 GEi4mgfeWXK/WQNJdL/rbtCyRBmE16rXYR3DXP2SqIoyp9Vq2Cd23LJ8fZvMJ2x4V8DTBuSWWpT
 PwsK83W3uj8pX98v1l/1I3x1aK2QTW4Os2f07BDlr1Y7wBK2XKRoZKcSRqyZ4DbELrkm0NBgBkk
 WW6ihLSAe178Ys+va2mno1Cb4TVpbglA7OafdsCQ9eH4ua2aw1PtmOF5cb5GOOlI6ar0Es=
X-Received: by 2002:a05:6402:1d4b:b0:69c:7754:f8b7 with SMTP id
 4fb4d7f45d1cf-69c7754f940mr3609626a12.38.1783952631696; Mon, 13 Jul 2026
 07:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-4-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-4-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:23:34 -0600
X-Gm-Features: AUfX_mx5dy6Ww1BOUMNI46AY1Ik8_xP79NtE4TnzZjD6FDpMWEjYPl987Y8Kr30
Message-ID: <CAFLszThOuhTRgTRmY-RZmxkTUzG3iggxR+m=3Vq9wTox+Lpohg@mail.gmail.com>
Subject: Re: [PATCH 03/11] rockchip: clk: rk3368: Drop redundant
 CONFIG_TPL_BUILD checks
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de
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

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> rockchip: clk: rk3368: Drop redundant CONFIG_TPL_BUILD checks
>
> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> drivers/clk/rockchip/clk_rk3368.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
