Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B519C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 17:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234F883290;
	Fri, 18 Apr 2025 19:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H2HPjc6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB95C832E6; Fri, 18 Apr 2025 19:19:59 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80A883190
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 19:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f6222c6c4cso2300594a12.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744996797; x=1745601597; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYeRnDftBRt+VKV13TlJ7mnxzM8ENwUkZt23o5+ovq4=;
 b=H2HPjc6LXQNBieHjSQWQwHq9utI1rP4VrUFCdUcyMF+B6NsueLPtJTbpMwrAZVLrii
 q0f55BWT9e2LaRYlNLYnhyNQui0qEsrZTNSXyP23Q/QmpBLrCeh3AQybf6tKTg6gbeaQ
 j3ye9WA80mocOAU9MiYJNouwRH+oE/8jxuRtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744996797; x=1745601597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYeRnDftBRt+VKV13TlJ7mnxzM8ENwUkZt23o5+ovq4=;
 b=TAXvYzuvPTEhlAEmHK08D8Osg9p4AxJetnSrITooVSikGhJ0hs0AE9k9QpA8YtKy56
 ekm4rGsb7PjXnkrCxCMgERPGGghnF3YTzivNkwe+OI+bv0x6QXq+++g8gRK/Vr2Fdt9i
 6rBSGQSA6EBuz3mNSqv7s5Y4OOexmavjhA6COSCCt4MvhE/7pH+R3YpprN+ZL5mZlu8m
 HreDXjsUO6eSU06lMf9FcX0/mYcDOhVlWhtpWLSZHJXh2VjJm3N1yf02mzp5duoBy/mk
 u66swUfT2FjX/zfQREONe5FlNf5vtrsqQI1w5IBXGWN9E5F5AyXP94XGvmOws5LZhvvh
 ZX+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUz5D9Uwz7Mp1oqhOr96EYzBoTlRdcyEEZB0iKI2SpSI/pCg/rwLuZbC0kJK0m6e2I53chhPI=@lists.denx.de
X-Gm-Message-State: AOJu0YxVxFfrPbUd0esxzrgf/1TzkdFqp8PFSJxaj/hQnz7Ynsa+jL4/
 sl+SI/CfCGVbu+wQI2m7K0di0GaFUAnkoS/XBI4AIX9aDV5ExbIdFU6HVolrHGf2L7TvZyNdS5K
 tgfbJ/hQ+5FKyAMc/gM91pDb7wLwHHtTloPFM
X-Gm-Gg: ASbGncv1CG2l2auekTBvteX38OMVxyU3InQzYtLpaKrP2PjpvkMpb1HPtpgD1W0/fWt
 MosFaNg4NweKu1Puy+bdg8V+LnkODFt3/IJl8YHaq/dtpBz4LCQmM1C8Ar4i865NlHRENgbgvCt
 uf19QVVWOPRMFAcQBoYDuWH7c=
X-Google-Smtp-Source: AGHT+IFdalsSD5Bu/45U8/d/GjF8femDxCFyb+/2HGVnJTWmr0GvPi5FW+78uoeT/T+0kiscuER6Cn3OqKlBfNXO5n4=
X-Received: by 2002:a17:906:b88d:b0:acb:849d:1874 with SMTP id
 a640c23a62f3a-acb849d20c4mr88221966b.16.1744996797332; Fri, 18 Apr 2025
 10:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
In-Reply-To: <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 11:19:41 -0600
X-Gm-Features: ATxdqUHAOPn42K7maQop0de8hXYnmHjPKPfe68KqH2osqckYkqBmkyfYHO6awgo
Message-ID: <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more
 explicit error for key-name-hint with path
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> key-name-hint property in u-boot-spl-pubkey-dtb binman entry may contain
> a path instead of a filename due to user mistake.
>
> Because we currently assume it is a filename instead of a path, binman
> will find the full path to the key based on that path, and return the
> dirname of the full path but keeps the path in key-name-hint instead of
> stripping the directories from it.
>
> This means mkimage will fail with the following error message if we have
> key-name-hint set to keys/dev:
>
> binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home/qschul=
z/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/upstream=
/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA certifica=
te: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such file or=
 directory
>
> Let's make it a bit more obvious what the error is by erroring out in
> binman if a path is provided in key-name-hint (it is named key-name-hint
> and not key-path-hint after all).
>
> Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb etype")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 ++
>  tools/binman/ftest.py                                    |  7 +++++++
>  .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 ++++++++++=
++++++
>  3 files changed, 25 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

The change log seems to be missing?
