Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E45CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C509846CE;
	Mon,  4 May 2026 22:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UhgM/VDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17CF846CE; Mon,  4 May 2026 22:33:41 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DE38394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso7240835a12.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926819; cv=none;
 d=google.com; s=arc-20240605;
 b=SUsXCL9/UTXFxW4IXux4kLjv0E7g+I+fxT9LfXs+47TUVysFOEhBPL/h6huT/VCbRp
 6mQUYe6khKvCdlOfbXV/moJsQUF8+aH7ovxiMgaWALeomCzeM4W8yD3punZVUSRFOYMB
 QgZsv11y1J8TcCXTqGcUKMa2db9NYwww3iAbVsk96GRPUHukeNJ1W/tmaPxumfl5TPyA
 zzxBnaqXw9c5QJSFljmqrco+TMP+IEvkHDKSufSMZewZDHlhkfMP+EC7eX9ronEo6nDJ
 Jq+agZ/RMPNBvhSTjYFYA+q4e5y98bcx8nHCM0M3cFh24ttQsTX69GKApzekwzun8L/N
 cCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rofFTqXdG+IRrJRdQHhP2wPSf9ZYuiVnvvSocq2N6iA=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=FCkZraSUuJ7OcRhGQmtAe73qjhIDrwHd7xYWJtkCQ9jfJfCbwS7cU1aSuxTOF+BeM4
 kVzjxm84eVcryXY1Abm8ne2pOIn6hHOxypguyIZbVi/4hdo94u4SQHmQKxAlCvhuBWnd
 UxlK+knqO7gnpop/B5j2yqeNCj9g2RGEFX6KcpHBGjyQ9iqPCleS/PFXHw5knf1P3g7v
 GY4DG3dUtPTNHxWexg22jYjnrmWoGptzz6ilh/zv7x7WL8lPsEs7v1W3hr5RjP8HQm8J
 7y8AQXWAVBGzCE/9ndiQ4lICxHWC9UtiCzkN7Rxz0PgnpKrvEAi8cIjlG4Qt56mrIKaW
 44Tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926819; x=1778531619; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rofFTqXdG+IRrJRdQHhP2wPSf9ZYuiVnvvSocq2N6iA=;
 b=UhgM/VDSxbIpjW5DF06WdVfWQrfNqDQSWycwtwRnhOdZAP7rLv+YIpQx3t/uE9PFtb
 rj8DMjCfF5qtvg4rt3tE6EMb7AhJSM09TpmZN1mbl3NaoNhPpo0DXIa1jE/AaYVzU2m/
 sSV3EuhbsOjuDa8oKGbUmvuPd3MLCLiH3ottU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926819; x=1778531619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rofFTqXdG+IRrJRdQHhP2wPSf9ZYuiVnvvSocq2N6iA=;
 b=egSS5K3NtvqRUSmP8p2HWk8PrYsLhle/os3Js4aNo06WI1FUKDYd7CGLKHiHWsadAl
 R+893oPanN7/x/8pENTvGGBvOggN8SMDjBoTZIMwhYqFO1MZsEUpkOr4ckRWlX3mO6sE
 n2KWhqjiMcKgGtTLmJUoICyqtvpGBekHO3l+7OOmvAxKsINEgAlj4doD9yv2v0/xYUDQ
 bWTNHFySMjk5NhSsvnOSPSF5zdZY1BO+OJp5q2im4PAWv06ipv3rnab8N7VT7hw/Jxhz
 YdFzTk1xcaN/YLRAbK7RU6Lik3Md9sIcIdm4WdLzCLNld3OD/QTrw7hVvXpLRgId0VOp
 uuHQ==
X-Gm-Message-State: AOJu0YyRc/NgJBMMNavXOM9sM056oTqQODIX7TScuDV6R2i8kLS2DDlN
 7gZOG8lgLSC0SYtfOZnNV1aclx5dGGwUkaXJpWWReymoc6HSkoOjYglxlV5sCrBEpl7HDfyoIJL
 O7lp3X7fKaMhfHQg0NhGJvhKGGyoZEfY6vaACpm9F
X-Gm-Gg: AeBDietK5V5/AJfmqPV4gu5xZqhwCyGh9WJjrcvsFPDNIVl1vStftOuUuLZSdlrSMxY
 eYR/zwlMJm728rj/j/cwnc82IMCeEYzVitCzc+/fen7dLT9S/w9OfO0H+5qsaOETjI+nSUQuvRp
 wSmU0cRhHvbXaBTGJwVcLFaeR2ifkyBoCYvn4gI68D8LKuICB9Bbh+lIBlyb35jjxV4quL1PMV4
 iT083FZ/ITGRm9tahQ/E5jV7tJB7NkFZrABHmFyz4mak4I71HbYAOKkpx5VHQ7pAcK3u0HQLpkI
 BMQkzxffciWNTkqq
X-Received: by 2002:a17:906:b394:b0:bc3:a0e9:e0c with SMTP id
 a640c23a62f3a-bc3d1636d7amr40590166b.13.1777926819404; Mon, 04 May 2026
 13:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-14-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-14-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:33:27 -0600
X-Gm-Features: AVHnY4JHFDVwD6n0LGQkBPBtkNNPtcG6R49j2kxmyHZgYg9tUqqARtOctrY8VNc
Message-ID: <CAFLszTgxqo_JgMDMm83P0oWZ7Z5B_3a0HP3N=gTXLj17EUBpYA@mail.gmail.com>
Subject: Re: [PATCH RFC next 14/18] kbuild: respect CONFIG_WERROR for linker
 and assembler
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> kbuild: respect CONFIG_WERROR for linker and assembler
>
> [ Upstream commit ec4a3992bc0b5b659eceb44a9f8582b26f2c8489 ]
>
> Original commit log:
>
>   The linker and assembler do not share the compiler flags.
>
>   Make sure they also fail on warnings with CONFIG_WERROR and W=e.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
