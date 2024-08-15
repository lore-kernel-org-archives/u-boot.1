Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A287C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6964788B5D;
	Thu, 15 Aug 2024 22:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWPqfO4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C4088ABF; Thu, 15 Aug 2024 22:31:53 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 265BA8657F
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-842f00b7352so427063241.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753910; x=1724358710; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8juulElVv7KskmsHb9ooUrHBULfHQ/leRVa+y85lEiI=;
 b=cWPqfO4M9zffujHIKi7zvuUivzcITp3ayrmSBEYjYRwBY9Wqroi45JQ/GejeTU97UH
 ITUEOyGu2uiovbnuM7xqJr02niZ74OymGG20JLFNoTmdRBFnebUf5g/tsya171+qcypi
 AYJhuHx+rui6Zb0emfRhdZN9kjnaI/OvXP8vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753910; x=1724358710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8juulElVv7KskmsHb9ooUrHBULfHQ/leRVa+y85lEiI=;
 b=KCF/ZhAKqpee4PuSbmnb+4odDeB9Agk308YzlWf/MWd4FN487prRO58MEfoLddzXyr
 vmcqi/7otQCx3sxQCUiiqVVr4I7SapvqvpqQL+aIt6ahI0MO11XsBVTtyUaDeXiQeSvM
 KA+OLLtAr+yFbUuhOoqMhmSH8kS3OI9sW/zDAxRnzfyWvJ3LYrJZy2rgy6dVhdm4hCo9
 FmW9TD4nQZkD2bFWpsVySr/tRYPJLGuS6JkEMg2GNT9CjhXWwsYYEdH7noQPHxqWAxB0
 tz4fZLzOkZidWppibPrPk0cD2HwtEWB1m6JKZbQkUOzLQS7NHFia9gJf1xgDtb81Kr3q
 ChzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJmYZBnda9QCtfuSVuuBNUgfV0jjPioyHemO6FBYeF4GmXglXrJczs0UKvmb6kDQhBhVKXvjmE7dfnjP1ZmdSg1W6PcQ==
X-Gm-Message-State: AOJu0Yw6whuDtfS8ichGNUtRj7NkCaGbF4A+nA2HEbX5snshQ9fggjRy
 jQvkcDctmIM92BtWCVREYIMWwLB9oavbbPg50bNd8jwGWNusiv8RUwVPlN+VJAqCqyw0u54Ixet
 M3VfGAIVs4zrE8GahkgHtparLpzqKcdg6pidx
X-Google-Smtp-Source: AGHT+IFgutwH3D4Y1bb+gYWWoUwqHDrW2hPgRRmiFVYOp/VTqsKWqZGRllxcPTcpp86UpZ+eBhx6PXb5FCYVTx8H0QY=
X-Received: by 2002:a05:6102:c4f:b0:48f:4218:4d06 with SMTP id
 ada2fe7eead31-497799b0f1dmr1367175137.28.1723753909797; Thu, 15 Aug 2024
 13:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
In-Reply-To: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:31:39 +0100
Message-ID: <CAFLszTgdB2x1w=hQ38YV8Fg6Sc9YwtPNGU827-_Kj_UupxLsGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sandbox: Enable wget command
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 06:47, Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> Enable this so that the tests run.
>
> Fix a few warnings in the code so that CI passes.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
> ---
>  cmd/Kconfig | 1 +
>  net/wget.c  | 7 +++----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
