Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFBFC47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661D48787E;
	Mon,  1 Jan 2024 17:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TKkC4bs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF8A878E1; Mon,  1 Jan 2024 17:53:19 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956368780F
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-680285e7ce8so44438136d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127995; x=1704732795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqcsUgkLBHeWRrP2920+e3ktVBvfKoj/oJvtKZXolaI=;
 b=TKkC4bs1r9IRmeumahts7GXiTxEnm4rsUpvs8PMAqzHBFQwohSw/Nu7N4wnifytow5
 Tn0eX58izSLBvtB9K3LFriT4evY5lup2of63uJcI+2t+bwR/ACz0hf87DjteocW3/JpM
 gpDynq91OrPP4bK9YIEckGHNsy+A3x0uzqqXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127995; x=1704732795;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqcsUgkLBHeWRrP2920+e3ktVBvfKoj/oJvtKZXolaI=;
 b=ZH+VegYgbZfDbElTz+BiitEucdhnIxu7UhXVgZ08rhIdjcTWpHyM/3aICbGjfD9ks9
 ofHnV87H8QX8dNwVhtcQ96gvJTlcFHDW7lfbYh/puxo++M58lGCo/kPNJSM6Vc6StsnH
 tq8VfFJ2hOdFbETRb1GyqkllGePp+eyCt6o7PiyOC0D5Eyo2pLoUYaMYXQul6Izja3aV
 MZvu/f5VqBGUr9XxeuKKtunbcp8UDmippEEjkIF7H3oRZC3cMDp+bSgZ620cJIjfJ4gF
 P5dVMatFFOxzhX+8G4DkcnSgkhcDFFzwDMnflxqKibqyyR4d2REN1XVcU4HzoWkWtU6M
 SpDQ==
X-Gm-Message-State: AOJu0YyCO1HlwrkLKS+gAh1P/Mv9LcaDrHYU6J7dtrVG0YOXqwKnzy4z
 MTBfs9NHsgt8P5xhXSn9WUtL8GsReSNScxgLSGdhTByJCwH2
X-Google-Smtp-Source: AGHT+IHkKqrFFwpNtX/sh3DRL4aHB7v6b9qsnEppszVF38wE8aEeEuhQqflRXrU5r29wT4Ir/WD7XiSYlGkfzZ66kTk=
X-Received: by 2002:ad4:4b25:0:b0:67f:9aa6:e9c1 with SMTP id
 s5-20020ad44b25000000b0067f9aa6e9c1mr20209041qvw.127.1704127995511; Mon, 01
 Jan 2024 08:53:15 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:15 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-10-raymond.mao@linaro.org>
References: <20231229174244.892818-10-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:15 -0500
X-Google-Sender-Auth: ZCO-lUmyUm_uK65PCh8Brl2PAcU
Message-ID: <CAFLszTjRbg+KXycjk3L0u8eQ+0KjZrt=grY0LHnp0uv+93Fqmg@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] bloblist: Adjust the bloblist header
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
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

From: Simon Glass <sjg@chromium.org>

The v0.9 spec provides for a 24-byte header. Update the implementation
to match this.
Rename the fields of the bloblist header to align to the spec.
Adds an alignment field into the bloblist header.
Update the related bloblist APIs and UT testcases.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3
- Update the bloblist header to align to FW handoff spec up to commit 3592349.
- Update the related testcases.
Changes in v4
- Patch #14 from v3 is squashed into this patch.

 common/bloblist.c  | 86 +++++++++++++++++++++++++++-------------------
 include/bloblist.h | 44 ++++++++++++++----------
 test/bloblist.c    | 37 ++++++++++----------
 3 files changed, 95 insertions(+), 72 deletions(-)

Applied to u-boot-dm/next, thanks!
