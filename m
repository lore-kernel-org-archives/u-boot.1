Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1127C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04EEE834EC;
	Sat, 24 May 2025 07:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hw5YK77i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 904F58363D; Sat, 24 May 2025 07:06:40 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF3C83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad5273c1fd7so80344266b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063198; x=1748667998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+HKkzeaNtGjIV9+s2Uq2ofdIkXIQ77eMJ2uhrwmmhU=;
 b=hw5YK77iYgcHytrJcjOyMaMTY2l/A6w8hxZG/OXjIruEwezxEoSTnW7nRJzdtGFAkP
 1zUt3oRuVMKoYd01yjRkx+y0ITlr9PnIblw0W7WOrKrqTsh+eBCTaLL3QF+O4O5CvoYY
 SIqwcUvDvkbkrqyeABS80bHmUqHEeFtdW2boc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063198; x=1748667998;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+HKkzeaNtGjIV9+s2Uq2ofdIkXIQ77eMJ2uhrwmmhU=;
 b=fMajraEUuIDqTsUg2JInJKCeCXhT5iFmaAPWwGuU0P46Pkc2Ez4Vikf348FZgfAB7S
 vAiPQXy8Oau/bcRmmjh15FLM32NMVWvSs6uLheHXPZn7XVs0Cem7uduB2O3FfbCpPAyB
 6XFr/j1fohR0h4/XDNnTVViYmD0RNSWzM8XTVsz3F5zGi4eU5OebpoUgvW7RI5s5+9xM
 2Osv8nS07pDsUFlMWYJo3wdeGwiDgxInBbOa6P0KX9mYX4E+Xp1VNepTWM1k3ZPWTiIA
 0oaZ3QpZr8bTelDJhbFaiMEEiD91yjVqb3FUdc4/sNupF6yXyyZrMV8sM4J7QjMYkM7m
 o8AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEYh2SKI9jgDQAhCBNPC3jusKaykMSbz7TE1MjUnhyUFqatLat3XmdlxqHM7RJ8vlc9madXuw=@lists.denx.de
X-Gm-Message-State: AOJu0YxqNdt0xC0i2xXRnnPDBSKHcc/P3/6ztTFtIwMUgGcEGkOm4RF2
 ag423ziJQn8z3Rs8hF2wki2yWNLL0qbPBi5V/FgmodGDGMnLVpWtLzJBHDUQH+QJ480nzCLGzhF
 NfN1TnMsgXvlbL9QBdjFqTitheXYKc2r177Xi2Y0nhLCZCIoURjTdgIgo
X-Gm-Gg: ASbGncvXXcY92WQfbpJBgHpwj3EbsRUUhztDA0KiJtlrnHrDXgu70s/xOkIjGcPhLV6
 QJ/3cjhWf/BTC+jQCJHBuVYPFjP6FhYviAohXezeM4wN+4rimd8o6qsj2kdVtmG6D249I9tCZ4M
 GqAiJ8IvZYMexlD+rkNELq3+r7fTgSGC0=
X-Google-Smtp-Source: AGHT+IGfYC/K4ePnbVom/XjQoE0rNcht3EtDRZG4OjNamJ8+YkggUeHcIiIzMmrrJpzWfH8MfYF++5ivHPDeFA3R6pI=
X-Received: by 2002:a17:906:2447:b0:ad5:935:81db with SMTP id
 a640c23a62f3a-ad85b0507eamr93872466b.10.1748063197893; Fri, 23 May 2025
 22:06:37 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:35 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:35 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-4-sjg@chromium.org>
References: <20250510110535.1453745-4-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:35 -0500
X-Google-Sender-Auth: zlr5NgFL2WkqhiZpzQTVTvx_Kpc
X-Gm-Features: AX0GCFst7vnwFu2_mWqPaD0GchB460NvWO7K9TVwNow3qVUg2s4pw-7P_v2hcAw
Message-ID: <CAFLszTjQc1qDvyQydOrNNrQYvVhpeTy9J0XOD2tUhR8iBxdqvg@mail.gmail.com>
Subject: Re: [PATCH 03/25] u_boot_pylib: Add more functions to gitutil
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Add functions for checking a branch, showing a commit, etc. to support
the new functionality.

Git version 2.34.1 ignores --stat if --quiet is given, so adjust the
args so that this performs as expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/gitutil.py | 96 +++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

Applied to sjg/master, thanks!
