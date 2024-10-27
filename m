Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27502D13576
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE9688F75;
	Sun, 27 Oct 2024 18:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jTBfhLmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B388388F70; Sun, 27 Oct 2024 18:16:31 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 216C088E78
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso48966845e9.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049386; x=1730654186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qIDky/3afoSrUpqNHmz8R9nmfJCISIafWR7m5Q1vLog=;
 b=jTBfhLmQ2tsnGXoNz9c3PL/CELhO3PoDc5t15ox9KlqGoqi4FTEn+fJ+QWW4+REkU7
 0zRPea2r5EgsI0nK9TzZ7GRzVr3B/4UDi48RN33Jjj6rNlL22szYP6bnNLMEvl1KVzbN
 VBrOEKeq545xKj4blLZNrAJaFjvnPCfbnuCIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049386; x=1730654186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIDky/3afoSrUpqNHmz8R9nmfJCISIafWR7m5Q1vLog=;
 b=Ks3Tet8RvUE2mKXKn6oxVJYyEqvOQs5vDKOIMqs3qwWK/Z9MspwHBzrskHQRzAGCuf
 avuDrN0jgxqEGMTZ7v07P4JRi6QUlTifyB97bBn4uppuJ0bydxhnDtndjwLyPHNffo65
 wog0kHg6c5S8V63G/MXeLtRuErVB5x96eZQtulMKoAI4aeOu6KkKz+XQLm3oXdrb9ggB
 TWnEnEYUq+jAz0ivfObStwWyy4HOyDmhiO7gHXvV2Yz8L+OcKm6A3NHkgTGWp5XDSXEo
 onb17REiGrAgwqg7f9HX82F1G1IrkDUfHaFQ0s8Xfd697StF2u+ZmR8xFeEaKuiJOtZb
 VprA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjCp4fsbmpolf9MbuNDa0cMlu4GJvPkwQRAAmhNro5FAAgqZU77HQM3Dk2UNTjPvI/CIu305o=@lists.denx.de
X-Gm-Message-State: AOJu0YxgERM8YzY4Kwi25iAfjBHUhuWfpfmBlewywu30oPY7nSmbnEGx
 eK/49YeKXfQ4J42qB4BjN18dbLYo2+9fexTr9xtPfzfmc73amdvLwXUop+oVafYO35mz9SbZODo
 5JiU8bR27ueSP/Gn0l04xwj2WzbxmiYuwZ3D7
X-Google-Smtp-Source: AGHT+IFFaMecKySKGFmcGVDk4/7HS+qocY4ZTz/IIYCot6pNlPYP7iHC9x4DJgi0FDSYZan08VH6AxVYRvGbVxz0gYE=
X-Received: by 2002:a5d:5508:0:b0:37d:51b7:5e08 with SMTP id
 ffacd0b85a97d-3806117ea93mr5597606f8f.18.1730049386505; Sun, 27 Oct 2024
 10:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
In-Reply-To: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:12 +0100
Message-ID: <CAFLszTgg23HAJ5duUZDnhoX+xvbPCpdtrx0CUVQytxm8sZRsHA@mail.gmail.com>
Subject: Re: [PATCH] dm: core: downgrade some dm_warn messages to log_debug()
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexander Dahl <ada@thorsis.com>
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

Hi Quentin,

On Tue, 15 Oct 2024 at 16:32, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> People complained that enabling (SPL_)DM_WARN was now totally unusable
> due to the amount of messages printed on the console.
>
> Let's downgrade the log level of some messages that are clearly not on
> the error path.
>
> Note that there's one pr_debug in there, because it is followed by
> pr_cont so it made sense to reuse the same family of functions.
>
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Fixes: 6afdb1585112 ("dm: core: migrate debug() messages to use dm_warn")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Note that I am not entirely sure about the "not found" and "not large
> enough" changes there.
>
> Another note, %#x isn't handled by tinyprintf so it just prints "x"
> instead of the value.
>
> Finally, I don't know how one can enable LOG_DEBUG level without
> enabling DEBUG which enables assert() so I just tested that by removing
> the #define DEBUG in include/log.h :)
> ---
>  drivers/core/of_access.c | 36 ++++++++++++-------------
>  drivers/core/of_addr.c   | 26 +++++++++---------
>  drivers/core/of_extra.c  |  6 ++---
>  drivers/core/ofnode.c    | 68 ++++++++++++++++++++++++------------------------
>  4 files changed, 68 insertions(+), 68 deletions(-)

This is an improvement, so:

Reviewed-by: Simon Glass <sjg@chromium.org>

For -EOVERFLOW I think warning would be better, but in that case you
need to print a prefix, since otherwise the warning will have nothing
before it. So it is a little tricky. I can imagine some support in the
log module to help with this, although I haven't thought about it too
hard.

Also, we should really remove __func__ when adding logging, since
people can enable the option if they want function names to be stored.

Regards,
Simon
