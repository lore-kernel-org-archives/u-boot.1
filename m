Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA692C46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A15A987C9E;
	Sat, 16 Dec 2023 19:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VuaZXKHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D496C87C51; Sat, 16 Dec 2023 19:48:40 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50FB87C74
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e4d65953d9so9923147b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuH0PO1+O+0ZyaqkGsL2efRUqHSlR/EIUQTzvMCdRUU=;
 b=VuaZXKHTranuHnFSQ/umPsqc9JQgQ3i793QmRqzDVBqpOmfE7myphDXsJrib3wRh48
 RrjzOzbRwpFisuqncSRWPNtkTYRuUt1elFWueFLSrMz5uMKfLlxo40W1rJL14lt4h8R0
 egE0l3F9a47Y8KhyIOF8qE/TgvsYu5uKJ7PGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZuH0PO1+O+0ZyaqkGsL2efRUqHSlR/EIUQTzvMCdRUU=;
 b=SW9ZSSTpeDd59yx8ntp6qy0B/QsOWnnftzqi/S+vzTJb/lGoSo/KtXXURVwu9sr5IJ
 y9r02d8ZbE1ATJrmLLnXOfzBnDj7kIUgqcmNX+oh5Oy2o8P4l4A19ZvqUqLo4Lr9gruC
 yGKgJelJ8+Umu9sY1Hpy2TC+Upi3TJkzMQo5n1JawXsuK+DtUGoX48ovKx/BJY7VxkL0
 vD3/D3sSlogC5Er+TbRb+ayjDWQjXWyZX1UMuqOu+2hwKLoYuyrXfTka73ot0lgfMhyn
 VwYHokZlOXTYJN3VW1oHIKf3bdbji+CYANniixMXswc1lRHkfNwmvxHGZ7aX6GvkzSjm
 N9Wg==
X-Gm-Message-State: AOJu0Ywa308mwuP5yCbB/Hrzty+i/LLFlC50MDIv03P8M/ZpVEg60UR8
 /OuFsNTjc21nojB39BRnEcJBQKUatv5U1lN0IIDmFg==
X-Google-Smtp-Source: AGHT+IF0zI+V37AHd9nhStnXRhOpH2QNkpzGWqxUYUe2aVfWEkK3GqbFEescG4Od8CUXobhvZx0ySRQzfpGivMeNyqk=
X-Received: by 2002:a0d:f607:0:b0:5d8:cb1e:f316 with SMTP id
 g7-20020a0df607000000b005d8cb1ef316mr9928914ywf.41.1702752514143; Sat, 16 Dec
 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231216153836.81717-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216153836.81717-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:37 -0700
Message-ID: <CAPnjgZ3En9kokXxFcok9555L7XT1p8QJ-MpoRYCaAoAZQofrXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] boot: CONFIG_CEDIT must depend on CONFIG_EXPO
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
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

On Sat, 16 Dec 2023 at 08:38, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Building sandbox_defconfig with
>
>     CONFIG_CMD_CEDIT=y
>     CONFIG_EXPO=n
>
> fails with
>
>     cmd/cedit.c:258:(.text.do_cedit_run+0x4c):
>     undefined reference to `expo_apply_theme
>
> Fix the dependencies.
>
> Fixes: a0874dc4ac71 ("expo: Add a configuration editor")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/Kconfig  | 2 +-
>  boot/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
