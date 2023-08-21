Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BC7EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEED28716E;
	Mon, 21 Aug 2023 21:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FZBIBqWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02E498716E; Mon, 21 Aug 2023 21:11:55 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152A987110
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so7659161a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692645111; x=1693249911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e0vGgwZYqzaA4AsuJ0JENY1fctuAheG2seUYtsvRHPU=;
 b=FZBIBqWwMHrMK39rEhMZaDSoOQlerwj7Uq1eNF1PZxvhv6LiFGKj9Hd+ZC6+1qRGqG
 NttOi5pCZslyaaD3+xL3JX2Q80KGBymvFdyukPe51dvsaWgBNd1ToDsVAqceqLOveTl6
 CijBeOS7YCMd+8iFMJ+5anWnUhNVtm5mUDNiPOuMpz/9daz+WHq1bweL5ontJQ7m9qyx
 5bqCHg8giU5c+5NIezR7nUirFd31Nr643yCV9+gBG41MYJr8uXLeHAjEJKoIa7HVW7f5
 jFCXQ6hQf38xKEMnyr5k4EqcRJJnW5Zj82OZxifoebzbJ3XPLnpQsH/OjYsRPz10EOqA
 Wz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645111; x=1693249911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e0vGgwZYqzaA4AsuJ0JENY1fctuAheG2seUYtsvRHPU=;
 b=CpQXrEvyw8u65yFLur/8q5y7e7U+ACpNmFTFssYc+DixkoEUzJ0/7CNkbzWqxr9ZsO
 1vKRCg9tRpKNgyMqEt7cZKKA4il90KiyOKp/5+ma6WIiCfzgg1OQ2I8l1065278dsK27
 4xb74nXnHUapPiGGp5v/I2kCO8HH9ja30UIBZGKvf/3fVhYNlMHXS1Q4DHIUMmfGTVvo
 Q4FduS1FHfjEVqcBcCkMwvmhDclcqDCivIVZ28w19mN/heljMfnU5I0wKwIxow7t9vTy
 GwfzK3AEZpfnQAuvd20x3tkasn9jofVdK0DxQgUFEdGYiY1Le3T+YW6BuvMHpTtRrXJH
 TKCg==
X-Gm-Message-State: AOJu0YxiI5/84rYZZDvOVo4faYXk4m7VLMemkwssgbUUj2PUkPe8lwAo
 HprXySEDKyAzaiIFDRloAd0gWfPps2QAk7AfUCcmbOy9U7IlOJ1tOJ4=
X-Google-Smtp-Source: AGHT+IHtKzYeTkbbM8M4caM4wfNw10KAPEbOBSwfjcmcf3VjUMil5iZzOcseuLxEXD2rQrqYdcCoehICCzcSBAMBt88=
X-Received: by 2002:aa7:c414:0:b0:523:b133:5c7a with SMTP id
 j20-20020aa7c414000000b00523b1335c7amr7125332edq.21.1692645111513; Mon, 21
 Aug 2023 12:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230820173129.781985-1-trini@konsulko.com>
In-Reply-To: <20230820173129.781985-1-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 21 Aug 2023 13:11:40 -0600
Message-ID: <CAPnjgZ0oibrdxdquNUMeQ+Uim5e0LhdaPWq4m07=+YKYFHrtVw@mail.gmail.com>
Subject: Re: [PATCH 1/4] Azure: Set the timeout for jobs to the maximum
To: Tom Rini <trini@konsulko.com>
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

On Sun, 20 Aug 2023 at 11:31, Tom Rini <trini@konsulko.com> wrote:
>
> As per current Azure Pipelines documentation we qualify for 3600 minutes
> per job, if specified, as the timeout. The default unspecified timeout
> is 60 minutes. Rework things to specify 0 as the timeout (and so maximum
> allowed) so that we don't have failures due to running slightly past 60
> minutes total.
>
> Link: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml#timeouts
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
