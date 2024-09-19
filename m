Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC9FCF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32874891B5;
	Thu, 19 Sep 2024 16:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IowxnJ/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83799891BD; Thu, 19 Sep 2024 16:10:03 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B09891CA
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso5443006d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755000; x=1727359800; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/XwMXPfmGjMXreSyn++r3+CsNg6EihddpKOod/8z7aY=;
 b=IowxnJ/IefQsRF5s4EfhXObhKS7visA4gw9zEPlF1Rvy5X9wMj20OonB8VSq1cR9bX
 qKIlFN+7uVphmqS7mZqZ0WZVTOibrQ6RgRl28ujEJHT4TqTXNDKlkbOFfC0tjoMxge/R
 bbLyra60HS3pXWcBBn/f8QmaeGfKzm47RVYsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755000; x=1727359800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XwMXPfmGjMXreSyn++r3+CsNg6EihddpKOod/8z7aY=;
 b=ucSbHxfjMz+/ireRjwiCfeBbZGWGzISmgIC3sXtrPmKYa3wbGbS6XUl5fabYlBSszB
 1OQoIk8y4ATalOhEu0V8+SCshA8L8oXB5QdoKKkxr5EgexSVnBSkEkXk235KEdcwbVOp
 7WAFKZDG7oMb16dzXGV7g4AeugZOkzXI2EzqarHYI9Q2nUGgFZCxkbGdZ49BA7BhTb+V
 0OZN2JhLRv8034khzNqWwpfaurPxoo6CxNhVRnKZlTEWgQIsGMi0eRokLIXadResZIKz
 9Jbo6lw8dXMX6PjOKJ5+Bk3AIFbK35qzrwQ1bLnZsqeHe3YZAGQxxDGsfhh5h9TDg+f2
 Azgw==
X-Gm-Message-State: AOJu0YzFLEQmKMqXqD0k/qhZ9fgizM/2Klh9qeASavVMMrVwPgjFyyZg
 l4f9xtEuuvZi33tiKRU6f/DPeZ5KnXLvBDL8FHu/Q+fsPrLNQfqr9glWyMsnSE3/T9VzRDXzeA0
 3CqSOhK4V4nOWy1+chlGrI/ES4t26uY9YtvmE
X-Google-Smtp-Source: AGHT+IGN47wvtUMqG6TmWurPc+pxLUOHND0JwFncLJ7mtd+cD5z92catn5fTSrBAbwTEd9ZWgQh0ydpyT6J2Ep40BZ4=
X-Received: by 2002:a05:6214:434a:b0:6c5:a3d9:1bc5 with SMTP id
 6a1803df08f44-6c5a3d91d54mr189822696d6.32.1726755000264; Thu, 19 Sep 2024
 07:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-21-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-21-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:48 +0200
Message-ID: <CAFLszThP0ABDm6fV6rBS9Uwc4h9w0k8oijA379cw5XzpbW=nAg@mail.gmail.com>
Subject: Re: [PATCH v4 20/35] arm: gic-v3-its: Implement of_xlate
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Translate IRQs by implementing of_xlate() as required by
> irq_get_by_index() to parse interrupt properties.
>
> TEST: Booted on qemu sbsa-ref that has a GICV3.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
