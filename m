Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80F8CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B4C86CC5;
	Thu, 21 Sep 2023 03:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lg4AAXrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C8086B4B; Thu, 21 Sep 2023 03:02:53 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D5386CB7
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so723527e87.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258168; x=1695862968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJ7gHonDmw/mGS6HRkQaUJ4qbfg7NSShKFTwPice+Qg=;
 b=lg4AAXrKuZnF7pvKE6s7j5yKK/RauGGUYDvNUUs2K87jIvWS8c3dDH5ycaBgqocUC6
 lFRDDJvMoC9L88LrVdrJi59ZysGN8iEVG6cdwASuVz1UYNnN53pfvD040K4yu//yVZRh
 h0CoXqP0zlohNGf7NcwM+i3h9BZ6QUREyepaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258168; x=1695862968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJ7gHonDmw/mGS6HRkQaUJ4qbfg7NSShKFTwPice+Qg=;
 b=HpzTB1DZ0zrkvsoadFibsCRO23C3NwEngdW0AeQP9+KNyImLoTbAjnmDjhy4HlELQI
 1cEK07WUHu7JxuReetJSkyqEa9BOqcrXLbM6tf1DD51Vfx50FnH/Y8nb9vzEkoSnWnZv
 dBUj8sWynrOnSBpWEmhUPnUqnPxi3y0y5C130aoiG4KT2MTCPKdDF+fk4lpy7TWGbLRI
 6UquFry+Zs6rtS9s+HKOlzQdWdOpe0S6zvy8JDWt1NIRXZkr8JRB0wazDNOt1K5MrbZ3
 PDC9BOgOs8tQI5ZXBk9FHrineYnYIioxblyUyHzKseuR8KWowRKMFS+bZZJ68V29RLvI
 VZ3g==
X-Gm-Message-State: AOJu0YwItCJ+KkCBzugXkU4CSMQuUpqXnNHC8ROkSQmGCknNzfO01HaE
 dDJsDJQ4WFFMuv4nPYIwWGf10swBDkFIxNXs+p5gPSnPl8Fn67WrXIo=
X-Google-Smtp-Source: AGHT+IHXjvA21PzsUfy+dga4oyikkdqdCRinWULMpZvVuk+XIqLjEGk8tcn1NebdH7bU7JBRTuls9DYV+RP+HlluWgY=
X-Received: by 2002:ac2:5f73:0:b0:502:ff3b:7671 with SMTP id
 c19-20020ac25f73000000b00502ff3b7671mr3226190lfc.9.1695258167462; Wed, 20 Sep
 2023 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
 <20230912213504.65513-4-seanedmond@linux.microsoft.com>
In-Reply-To: <20230912213504.65513-4-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:33 -0600
Message-ID: <CAPnjgZ1bP2Jj9pmDn7uN0JMotbCim8b2ZHrik_XcOhCHDqTOGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] cmd: kaslrseed: Use common API to fixup FDT
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org
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

On Tue, 12 Sept 2023 at 15:35, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> Use the newly introduced common API fdt_fixup_kaslr_seed() in the
> kaslrseed command.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  cmd/kaslrseed.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
