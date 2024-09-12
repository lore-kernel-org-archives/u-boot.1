Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF243EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D8AD88E17;
	Thu, 12 Sep 2024 03:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G+EAd0+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ABDA88DEE; Thu, 12 Sep 2024 03:00:34 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2851C88DCF
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so311673a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102830; x=1726707630; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlzZZRhH1WJEO0RaMXHq1Bf0rAxRNxGMOsfGpTYkFPk=;
 b=G+EAd0+LJ3RfBPrXMghBqrHj2x8mn2oYdFMV9Nudf9MCDi0ne/8KCAh5pK+Gozgk2f
 kQH1vNF3DVWcI060KIO0CtMeucbM9BXRW4zMRIIPkW5DpP6CmyqseFYWvfZmcyv+zJhf
 BwH6XTNaS/5IWfHhnTicr2h281EoOpOnoCX6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102830; x=1726707630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlzZZRhH1WJEO0RaMXHq1Bf0rAxRNxGMOsfGpTYkFPk=;
 b=vq3wBrLiiy2MfVp92Do8KzBHih20EnklrlRb2gHdK3HBMCNdBVZjLR6lDIZYMoXfZE
 RnnfyRkUd4xvL4SRn4NFvjaizFGVgFEOAOFUGzlOjbF8+TwUytoF1lC+DbYQTvPtXIX3
 iQYcQ313tcFWt/b+e2NDjCv7BZrg01rKnJ7HI4Y+8ZXjbKUsBbaSyY++vQw+3x683j73
 tNjJxap90d3StPZJM6TnW6azstdrUGTT1CzNwpoaHvy6J80EanvrDA/bX39THwqNAh/b
 rqzn48YMlVzoqcUfXuK+fm0YJUjwtL1KXZDy1EpiTwYQgL/9GNe+3A53S9B1yByM2a8J
 izfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwI+KOqPJOkEs3eJnyGRCT6YPndgzmqaefuj0L1u+7uchC8jDtxSTYGQtgsZrMdp4c8/QJR4o=@lists.denx.de
X-Gm-Message-State: AOJu0YzqOyjlCEPT1PQsJCNHstHn+O9uZZiqK4lIlKVx74x8UjHwpO/h
 oXVwyePweWRMs39D/Q9ZcJj3mbvU/sOIMd3345w97dxSiRxjcA6Fjx/3JNemvvJYX3F5oyAd635
 KopUAUjTzP2dfdwirXw5/8ZirSDWmVTEzUQ5B
X-Google-Smtp-Source: AGHT+IGgdDS0XRqDrS7ISYN9Fka3OYdBjUPiXAmu1yPaTwRSrItTZIk9nyOby2QtCJovQduo/I1ce+NvR3BlpAq+SYo=
X-Received: by 2002:a05:6a00:4b4c:b0:718:ea84:3e50 with SMTP id
 d2e1a72fcca58-71926203a15mr1957938b3a.22.1726102830231; Wed, 11 Sep 2024
 18:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-12-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240909222720.2563118-12-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:56 -0600
Message-ID: <CAFLszThTRd1bt-eu2JuCtqm3QZ0Bzm2zicweJgG=+0RPzWT65Q@mail.gmail.com>
Subject: Re: [PATCH v6 11/12] net/httpd: add httpd common code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
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

Hi Mikhail,

On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> This patch adds HTTP/1.1 compatible web-server that can be used
> by other. Server supports GET, POST, and HEAD requests. On client
> request it will call user specified GET/POST callback. Then results
> will be transmitted to client.
>
> The following restrictions exist on the POST request
> at the moment:
>   * only multipart/form-data with a single file object
>   * object will be stored to a memory area specified in
>     image_load_addr variable
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net.h       |   2 +-
>  include/net/httpd.h |  64 ++++
>  net/Kconfig         |  14 +
>  net/Makefile        |   1 +
>  net/httpd.c         | 692 ++++++++++++++++++++++++++++++++++++++++++++
>  net/net.c           |   6 +
>  6 files changed, 778 insertions(+), 1 deletion(-)
>  create mode 100644 include/net/httpd.h
>  create mode 100644 net/httpd.c

This looks fine, but please comment struct httpd_priv

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
