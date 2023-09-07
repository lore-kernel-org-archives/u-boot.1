Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60FAEC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE1D486A3D;
	Thu,  7 Sep 2023 17:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iSJqEG5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D4386A38; Thu,  7 Sep 2023 17:57:54 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CC2869CA
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso133415666b.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102271; x=1694707071; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CMrSdHIdcerLz+b66cPn3fY1wLZr1TsU+VI9KAJbM9k=;
 b=iSJqEG5QB4A8kLyfzKoDzP7aJKYy1ZvvJ7NKZXGLnZR4iJSHTpNhY1mW3gkbDqSzrL
 aOR3BZyOFC1SXaTRQPbTubx8goe0vKOrYuRowOWtUWwoz3a1khiI3QBujSSf91QwAQi2
 8kowY69ySmS62CXFkKgkZpIVYiaqfOgPaVBU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102271; x=1694707071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CMrSdHIdcerLz+b66cPn3fY1wLZr1TsU+VI9KAJbM9k=;
 b=ZfZd3G/ebF2IjtDIGQPDauwf2qoQN/L+/EZe7r3ts9ju16SVveZo9E8UZZ8UKR7l0d
 n8xuHu/YylJZRuetVh4nAY7sYDk8sZ+A/g98wmEqfF+aCJdXdGuk+d9O6Jf3VHKmA9mg
 PvmRJ11GcP8tkKml78/Na5viPjt+nQ86ABEMljnSeg+TkNOWD1YGF4lotQzGj/DtCJa3
 PtsBnZHZwrRQJ5nRp96wFeCTM4KeaW2a/7repE49VZWQx87IwcKe9rBm93emCxOOdepC
 Wm7nevvpozX/JHEAZfP0NO4+ONX2WILzNtJmXlRVKpc5EzZokk1iXrA3g8PZIvRugkQI
 7SCQ==
X-Gm-Message-State: AOJu0YyQlvJjg6+IdrhU8H3yV8TEIgUMj3KlW1L3jmTrBbmDGs2QM96B
 hY7R+ddrOKEfzKGDuoqetj3adB2Il/sa3uGvoraLeTfRx29NCmZbGtc=
X-Google-Smtp-Source: AGHT+IHcJ+494vDVVQYb9uFvKR2JPAUfiyr8jztLeKTM0e/f6cd8YajNQlq1xowP/cJAXv7l50FiKNUaXapOrbarxtc=
X-Received: by 2002:a17:906:5a6c:b0:99d:dd43:d427 with SMTP id
 my44-20020a1709065a6c00b0099ddd43d427mr4714311ejc.10.1694102270739; Thu, 07
 Sep 2023 08:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230907144950.653-1-rknecht@pm.me>
In-Reply-To: <20230907144950.653-1-rknecht@pm.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 09:57:37 -0600
Message-ID: <CAPnjgZ2NckaHF8-UiZepNCa3oUWyqFLiNNS7pOYN=oeyfs_G5A@mail.gmail.com>
Subject: Re: [PATCH] cmd: xxd: move xxd into shell commands
To: Roger Knecht <rknecht@pm.me>
Cc: u-boot@lists.denx.de
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

On Thu, 7 Sept 2023 at 08:52, Roger Knecht <rknecht@pm.me> wrote:
>
> Move xxd into shell command section.
>
> Signed-off-by: Roger Knecht <rknecht@pm.me>
> ---
>  cmd/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
