Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BFEC5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 11:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 106D482D2B;
	Fri, 30 May 2025 13:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AAPWcf6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA8282E0A; Fri, 30 May 2025 13:18:45 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 448CC82B8E
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-604bf67b515so3527629a12.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748603923; x=1749208723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LsdTNjOCXViWKgjMTFq3zR5wjVkzVVLLKKf8YhqVbos=;
 b=AAPWcf6lM7XAgCusI2wUX9h5QSNRZCPdYUw8MjUYm4ZzpzOgKLxklbuD1PCbY6KnxC
 Rd6G5Ghy51lJaf3fEHk+enjtT0NKWWmXQg8czl0QiSOtGDQq7lyDwcRk2K1HreLTw8Hl
 8EcGgscU6lcRSo9JI5fnYdQvkw8ixL9WPmWQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748603923; x=1749208723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LsdTNjOCXViWKgjMTFq3zR5wjVkzVVLLKKf8YhqVbos=;
 b=oKQ7tzuEhbYiAGUHJ1fOzYOz3bxWZp034LZQfp6f/GXQceVL0sDCKrsFcqW/Ad627Y
 pFp9sWSeqimJe/PGUv2zsEsSLSjmtbTxMhTYJR69aryx4vt6h+t0PeIJxdCfoSRtfHol
 A4eNiJA3Efe/8qzDlaKuL13q4Qcte08Ug6sFG7vK0CEwvWTz9b5zX5xDAweHf2UEvuck
 ks7TI5e5smPSxgfPvmAfMDKG2qU0V6OQgHqd8NFLxS7dQcIWUFf04U3U9rkIcihnNiBr
 DTH+cRagvqmBzAJyrBRP2tdheCcW5jYDNZwYNLVMjwk8HnNMm0MWMJwQDyc2IUm4wddW
 W2fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhMWU9ToQQ11k0wqVJfScKBwO77ZtYwIGKbgvbiWAQGs71B4gAl7lV2EcUffxGgi4jtN1He9M=@lists.denx.de
X-Gm-Message-State: AOJu0YwyzLtCoJ5bg/uwPw3sKdrkl92JSvzUsd+1TjkTWc1+DZO3i29C
 ctyRozDJew96DlnQlsDHbdQDLkRw4wLnacgcxaUAqgM39ee9llNcE8RjqJmGyVM6Hednk1st6UZ
 avZgWe5m91YGU407vu3O0DSXcG6uPRHrrX6+djXab
X-Gm-Gg: ASbGncudqIkKcRssyDQze1f0Fz6LU7Q4AbKGLPoQGPFMjYDmw7SspjYZPjyR5t/1us4
 +bLJ7F4ryvuFiMvvrrdReDLbjf7UjVESpJyYxskv2LcmgcwW+T1BqKH15Viu6QGnex/LrcezMUB
 Nm9RM7VT1TvhpP4id1DuL5cIro0QX9n7c=
X-Google-Smtp-Source: AGHT+IHaqh+l/YcZXk204njvg85N4TRjFTEuk9pU0g+4jCjqm0YXusmtbe8rJljnG1wH5ycIpwk2c3Q4dIMaFh0vq9o=
X-Received: by 2002:a05:6402:4403:b0:600:7c6:eb31 with SMTP id
 4fb4d7f45d1cf-6057c1b5b28mr1687706a12.10.1748603922783; Fri, 30 May 2025
 04:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-4-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-4-3362ab897581@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 12:18:28 +0100
X-Gm-Features: AX0GCFvsKgtdIUzwXsjJ2vUj269aaN-2eYpVadMG1R5n35-PE5eF8bNtwiy69EM
Message-ID: <CAFLszTi2c4r1+E=ZJLsLsOxhZfL+syW3yWNHkAcipmD9SFyLbw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/8] binman: replace _entries with GetEntries()
To: Yannic Moog <y.moog@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
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

Hi Yannic,

On Tue, 27 May 2025 at 14:24, Yannic Moog <y.moog@phytec.de> wrote:
>
> _entries, as highlighted by leading _, is a private member and thus
> should not be accessed directly. As a result use the GetEntries function
> instead.
> GetEntries() returns _entries. No functional change introduced in this
> commit.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/etype/atf_fip.py         |  4 ++--
>  tools/binman/etype/blob_phase.py      |  4 ++--
>  tools/binman/etype/cbfs.py            | 12 +++++-----
>  tools/binman/etype/efi_capsule.py     |  2 +-
>  tools/binman/etype/fit.py             |  4 ++--
>  tools/binman/etype/mkimage.py         |  4 ++--
>  tools/binman/etype/nxp_imx8mcst.py    |  2 +-
>  tools/binman/etype/nxp_imx8mimage.py  |  2 +-
>  tools/binman/etype/section.py         | 44 +++++++++++++++++------------------
>  tools/binman/etype/ti_board_config.py |  8 +++----
>  tools/binman/ftest.py                 |  2 +-
>  11 files changed, 44 insertions(+), 44 deletions(-)

Are you sure this is right? The classes which use _entries are
subclasses, except for ftest.py which is test code where we should
probably add:

#pylint: disable=protected-access

Regards,
Simon
