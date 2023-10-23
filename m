Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E98C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9783878B3;
	Mon, 23 Oct 2023 19:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="flKL2nuk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB11878D4; Mon, 23 Oct 2023 19:02:22 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B9186FCC
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so972450466b.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698080540; x=1698685340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1nbO+iZhNDVNK5kQaF0OsYS17YTVqd1E8bMwko4wjPc=;
 b=flKL2nukHjUnR3JgpOFEnKOnHrGJ82CF5dCvDITlZjwhVNIzL1WnlRWBh/R5LVVilb
 +vn/9ZIWDUOKihTpqOzMUhRD7pD13QGgOGvGrR5LxJtX8mhKSGxXMXaQJCBbXGZUtbar
 n8fbroT3yBB9fFb8B3eLYwPn8tWURkbAIzdCXB3v1+H3kfPx33TIlI9qe5SOefxLbLc7
 UTU56x9Vr1QtvehpNgkYtw5vpXkHQpLiKDZ5lGxKP4nM5RKoIKweni9xmj6ZrZbC9R72
 hninE/n4/fbTMXUfaL5VMlXf3P6KBwSo7mn1tGPlSIAgkH2/QBgq5/ItR44QRUzZIOPg
 ZaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080540; x=1698685340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1nbO+iZhNDVNK5kQaF0OsYS17YTVqd1E8bMwko4wjPc=;
 b=or8cLX2Z5A8T6qb02LWEeP2cS3gL1YeXYrEiT+FVLNoAbpWXXSLY9xNbPPvBmFdTiT
 eOZayhU0Jlmm8ChDPoLsvxtmMVqES02yTLycOxXMdrzPD8k+gkVLU0ofOi+zG0o9/ymm
 juELby/xO3H3K/Vk+yrKQNNsggtFv2eoBDctoKSMY4bg2w/A5zbxVJX6hr/HUWbznzwy
 xzzhMkkQ15sg8Pav4SBY2VIPnOWoI0hWnxIC1fhXOj+zJQUCA4WSTxFgY7L1o/YZ0cc2
 T5snODTyuSBuGVFdKeguatd2A7qTODdiWFN6aKhzYHg8GI7QO6uGfoyCYw/xgN4syvT1
 Mfbw==
X-Gm-Message-State: AOJu0YyzvKkzGmruQMGYb9qcpQSjz4Meg8yn2Mrh9+KSiofEjy7SsH+W
 TyVTAEpGE1CZpSjhWd6VRE9/COywM4WEyrI8+REWAkxOu2R037bErHpXmlhd
X-Google-Smtp-Source: AGHT+IF+LYBNBwBbOXn0YUyHtcGO1W//uDjGp0KHWAcTy7W99QJLbaGRGKgow2+OawcwgCMqDna4zJupdzDUeOeFBTw=
X-Received: by 2002:a17:907:7e8b:b0:9a9:fa4a:5a4e with SMTP id
 qb11-20020a1709077e8b00b009a9fa4a5a4emr12651289ejc.13.1698080540171; Mon, 23
 Oct 2023 10:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231023153747.1967540-1-trini@konsulko.com>
In-Reply-To: <20231023153747.1967540-1-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 23 Oct 2023 10:02:01 -0700
Message-ID: <CAPnjgZ2ZdCMt+6H3g6CmBSbPMxH1ZEx6PrHBUJag68Fj5XNF_A@mail.gmail.com>
Subject: Re: [PATCH] CI: Re-enable maintainer check
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

On Mon, 23 Oct 2023 at 08:37, Tom Rini <trini@konsulko.com> wrote:
>
> At this point we have all of the defconfigs maintained again, so
> re-enable the check to prevent further regressions.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 2 +-
>  .gitlab-ci.yml       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
