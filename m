Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3346DC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 15:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E733C88ABA;
	Fri, 19 Jul 2024 17:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jFtCxRyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC18A88BD6; Fri, 19 Jul 2024 17:05:27 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCAB88BEB
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 17:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b7b28442f9so5091776d6.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721401524; x=1722006324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J8jQBObcRqPzol7f135W+DzdtbJ14gH6luQhOEQaQNQ=;
 b=jFtCxRyNSRq9Ojhx2Nz1ayRjXKd9ajjn+4MuGcEgceCSB8BrtZwEBAnCTElg2Y7J7k
 T+vi1kULWO93QX7zNAppOi9MjvF0jresA4IzGKGU7LkBlQX0qCLY0Y/VDBMJSxaiSvik
 s1zOEtlNf3lXMQ6UemIky7RqlragOLJYbcp6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401524; x=1722006324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8jQBObcRqPzol7f135W+DzdtbJ14gH6luQhOEQaQNQ=;
 b=ilXY6XdXBTorumi5H0PMB1fn1CdNZp3WDCNEYCoqmhwLRbtJjSUkCvj2YWBygaUTjT
 hgEm/nopR8F1cM5VgiuXGLdXsWDGNqiOmglqkRqnT1aHitCeZcqPZKO+XaGf0OIMrIZa
 6/3PyuX28XYxQ7lH+N0k2x3ipp4jvV3igxq7k4sngmOoTjxCtT3Ch8w8DWxu7WzqOPMB
 k46Ui6AXdAOwlngMUi7yfPYpwwYzFfQrqIEhBEnLonIuu//Vvm1hzVaXdoUbJpQeKt5c
 H0KrXNXCd9oB6TCFakRYvMw8wGFU3JcRX210T+S1pvAVASZqje7J1JYvlt0ceRhwnnxS
 SyHA==
X-Gm-Message-State: AOJu0Ywsd4OGqoKUFSW4FpcfnoY/a9Td228TXxjT2wGQzv30hZPvPy14
 kWzxZU+ltO96yl3l8ewQ9aPgtQhjAAy6lKoSE3y0ldFTimAH5rpRh9RfBuOmNdoCFcwKnFpiMlm
 w2UgKkxS/aQhD/h7pll9KRAVtmYE0fOpPoUnL
X-Google-Smtp-Source: AGHT+IF9pepvZLHNILrrU3D85hRaWNyJxJFsfX0FO2TkGDtBv/C3IEZgEMwPk/Pt70Hsi6O3A04GTk7WzfD15ypi8JY=
X-Received: by 2002:a05:6214:202f:b0:6b5:4bc:6eed with SMTP id
 6a1803df08f44-6b78e200451mr102398456d6.44.1721401524363; Fri, 19 Jul 2024
 08:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com>
 <20240717-docker-image-v1-1-7c7fc6251e7a@flygoat.com>
In-Reply-To: <20240717-docker-image-v1-1-7c7fc6251e7a@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jul 2024 16:05:13 +0100
Message-ID: <CAFLszTi=DYwq2MXqY7h=APpCrqrbOR8waJ5+21j+RbykHeK6aQ@mail.gmail.com>
Subject: Re: [PATCH 01/18] binman: Replace pkg_resources with
 importlib.resources
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
> pkg_resources is deprecated long ago and being removed in python 3.12.
>
> Reimplement functions with importlib.resources.
>
> Link: https://docs.python.org/3/library/importlib.resources.html
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  tools/binman/control.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
