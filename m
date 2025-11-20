Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4492CF884C
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEB084113;
	Thu, 20 Nov 2025 13:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KpyYiVbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEF784114; Thu, 20 Nov 2025 13:25:11 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43769840F8
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-641e9422473so619654d50.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763641508; x=1764246308; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=13Sf4Ae9Hh3GR31O32xbWRHoKblz8xatSIpQhkEoPQk=;
 b=KpyYiVbHXGykdS4jG8PpfSw4Cxvz2ucxLaGAg4zNCjDgKR6QEkAaBRVKpv4kluCRC0
 37riTeH+9UjhRHqhVQmGKIwiWPoNUu2mKv5yS7iPOv5PQowKhp/qkZ9yCxOnEUkwfhwd
 3i7JVUuiTMYdVvQ21kq47gMImrvr+MwRo5l+Tx3h3L2w5LWkIZcMP4j2hNumyCs6ME8E
 LBoxXDEiWXDXBtwEo+YvoE1gq78KsoD5oigkHPCmExWosIqamD/QfAtVltDpGQ+ffzhS
 f1H1VHRidfGLbWc6eRPNqsQwqvdf1+ZOtL0fVABgVHAza06l/w3uOx8dbP3EbfnhEfi0
 cFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763641508; x=1764246308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13Sf4Ae9Hh3GR31O32xbWRHoKblz8xatSIpQhkEoPQk=;
 b=hy1bqhC1ieIFBHQ4Bd3BVEt6h+VXgUiarxguNV/KwQ2KgH6pF6IlB2PpHaR3KniRKX
 pSb/MYmXNFsU8r4MkA1XBhOtxwCTkfGe6rkRZCa628a4oVptK05vYikgmJVo0lnSq7XH
 1dUNuf+sdjWFpeFGUQUx3JJq6uhSdZSVeU6OANQC9bqFxHmjTM6pPOxrJoMdjG5/fJ0T
 yC7TTTOfbJNB6dMn0+WC7UfPqtVT8bk66H7MbwpHW1jUdQfISouE+rpodIRRAz9yBcRJ
 x/PkApdMWjb5vCvYr/f7jVPzwcCynoqsPavvxKsaMBpC8grsDMSEuOwIE5KMwHOrD7rD
 0GaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwclBf2PBsNa/K1Yb5uKNEOjRo1BaxpIc9EpiSOrkLOovzO7qRPI9JEggoQWSwJCEa2sc8fWk=@lists.denx.de
X-Gm-Message-State: AOJu0YxDRvS7mKNUpPAlW2CMFoOwiNKY3cli2VkTeFpJN0WwYo+4CSD1
 1fPeO5ewWevoWiszVqa0i2Z+KlvV63zXasqaEfheRHuM0GuS04CwktRSw5BJ+N9PgBDZ+tW8SdD
 XiEQjauIOuccdW0RVUd/uTgjaB7TkPF9z9Pm46vxEkw==
X-Gm-Gg: ASbGnctO4RDNRJ9Ql5JVB5uGe7mdx0yw7xax7NvPXDudqztGZNbcGazfp6fIn/1bCwp
 gbRDh40sfUG8zJmI61kKAz/OT+TPNxXiP6vXD5zgKzvyHcn931UX5+thbPVYccckq4ERYl5CDV6
 u4V9R5YE7kvYUOix36sE8WOdcF+PneiUWs/EHNeLB4DSgrmJICBiSGvTjHRGcyiMMLMP250dtoZ
 lqujlIHhrowsakvu53ZReubqLyzLgCiw1eKNAPwO5hKbZQmiHO4lkPsyJ19Q3lhY4dVVUeULbky
 IBjxNw+UXEiEbm/Ka5uHlMdBNVuHQiEGegkfCwyHgXjp+ujWZ5Y=
X-Google-Smtp-Source: AGHT+IHiOIdfX6EMuaRaZmFrEGN3ltMtv6tvD6goRLn5aCqLGu/6FZ5EBT0OWUBXCWf51/LdM83/cjqhlGlAEQF0dIc=
X-Received: by 2002:a05:690c:88a:b0:786:5471:f44c with SMTP id
 00721157ae682-78a79663781mr53882467b3.63.1763641508080; Thu, 20 Nov 2025
 04:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
 <20251118201733.67297-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251118201733.67297-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Nov 2025 14:24:31 +0200
X-Gm-Features: AWmQ_bl63gvbjstx8H89hzxHmHwptlUFUKagiwuWrm7P-PZtqdtqUd6Dik8vMpA
Message-ID: <CAC_iWjLqG5kcmNNEtkFWO1wH4y1fs4+377tMSMa_5TwsQriuag@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: add include/test/ut.h to HTML documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 18 Nov 2025 at 22:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The asserts in ut.h are often used. Provide online documentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  doc/api/index.rst |  1 +
>  doc/api/test.rst  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>  create mode 100644 doc/api/test.rst
>
> diff --git a/doc/api/index.rst b/doc/api/index.rst
> index d97630e7671..44922a742c3 100644
> --- a/doc/api/index.rst
> +++ b/doc/api/index.rst
> @@ -27,6 +27,7 @@ U-Boot API documentation
>     serial
>     setjmp
>     sysreset
> +   test
>     timer
>     unicode
>     uthread
> diff --git a/doc/api/test.rst b/doc/api/test.rst
> new file mode 100644
> index 00000000000..359cbd0617d
> --- /dev/null
> +++ b/doc/api/test.rst
> @@ -0,0 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. Copyright (c) 2025 Heinrich Schuchardt
> +
> +Test Framework
> +==============
> +
> +Assertions and reporting functions
> +----------------------------------
> +
> +.. kernel-doc:: include/test/ut.h
> +   :internal:
> --
> 2.51.0
>
