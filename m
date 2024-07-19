Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45AAC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E3588C00;
	Fri, 19 Jul 2024 17:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1SjWrLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EAEA88BD6; Fri, 19 Jul 2024 17:05:28 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB2E88BF3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b78c980981so11067046d6.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401525; x=1722006325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9tCADUWLZiF/KGXre6LFjCUaWJiyUv+TYnE1Q+FTOMU=;
 b=g1SjWrLUqM/eLyzRvUoAYPoy3zK//5HnCswTDd4YaRCaCI+O4x3VJAwMBag5O6pxm4
 QntLNdjppPDZPuPrWDwGPHfb8r5fNh1kc7hL1vE3Rh6cUROegoF8Pgvl7EpHqZ+o6OS5
 7NefYbyy8ZGf6wE4CWXzOjSMkGscPJRRYnrGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401525; x=1722006325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9tCADUWLZiF/KGXre6LFjCUaWJiyUv+TYnE1Q+FTOMU=;
 b=oGzK2Sjtmd2dy5wX0xtCyZcOnuxTEcG2vtQzNzGEH81AfjNJAjqvbEFm9KQnfhdMoV
 ntsr/LP0hZZdLu56eN75oASApATsA/OkLsYUUXbemS0mp0iBV7NMvgX/c6iaItHCfXn/
 Qi1WJ3/0F0YNo1iIUhZFnrFgFYGg6Gr7TI7V2vusNKwmF7WgOvqbpmunlcuCjm5UXN8W
 0NUzPygwqn0025B8neLJnoayJdDGtaLT8eIdMNUTEa7x+WvlQl74GJeSPQWLGnAit7Qb
 yL+PJOah5bfJqVwo2NJVIa0tDoo7OKwV6UWjIlrSrjqeDwR1CgxjvAP74GnZDn771Uav
 sbDw==
X-Gm-Message-State: AOJu0Yx+3nnWchm8R+ZOKNCHHUVXBH1O4MO+e91V/ruhFnU0FE/NUq4B
 DIf/Ne8V70qqwtyCMpZ5J01hHaI4iGkZF9MZTF4/J0W5TNPRqvJgwliwMEHEsZRGL36kSbM2NLg
 4qhGtVCzpACykBGh2jkIBUJsUtE5C0WGX3Z6nsKCDVkKtNUQ=
X-Google-Smtp-Source: AGHT+IEwtICn5HY67U9eL9nrqpb3mjLOGluIq0l+f5R4p5SjPh0/MymJ63XRI/dg0cGN6K9cFJuIKz4rsHc1PhorM1Q=
X-Received: by 2002:a05:6214:d45:b0:6b7:a322:344f with SMTP id
 6a1803df08f44-6b7a3224827mr54982326d6.22.1721401525281; Fri, 19 Jul 2024
 08:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
 <20240717-docker-image-v1-2-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-2-7c7fc6251e7a@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:14 +0100
Message-ID: <CAFLszTjjBCb8rY=zRahE4tNoLvR=460bStth0JHceCbnicRxzw@mail.gmail.com>
Subject: Re: [PATCH 02/18] py: Replace distutils.core with setuptools
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 17 Jul 2024 at 15:29, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> distutils is deprecated long ago and being removed in python 3.12.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  tools/binman/setup.py           | 2 +-
>  tools/buildman/requirements.txt | 1 +
>  tools/dtoc/setup.py             | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But please separate out the requirements update into a separate patch.
