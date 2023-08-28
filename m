Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7986C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9AC864B3;
	Tue, 29 Aug 2023 00:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CcB3Vkyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715AD8648C; Tue, 29 Aug 2023 00:10:02 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75AB86482
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-48d11d1a251so1115972e0c.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693260597; x=1693865397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gY9tsrf0yKw0pSSdtaxTVnnUBG/f006dxLTASCguAjk=;
 b=CcB3Vkyzun+TgXrSeEinZV9fCDn+fwJYkEiVrhCuLwBJQkLjV6d66sZMbpk2HdaXxM
 WlXi3SftkSGX3ValCtwNWvzwBSYKCmlKs4dJ9yoPt0DQZ5+szbfW9+fGMZq0enjkeGh3
 30rfmU+GsTyPTFocq/JUgr1r1wYkv9zf3kwsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260597; x=1693865397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gY9tsrf0yKw0pSSdtaxTVnnUBG/f006dxLTASCguAjk=;
 b=G6H3ZZWyw5LvIchh5kuXAuFxDYQB+oX8u594GfC8gvSvYuWgfMrlCX4HbzDXJxrXlW
 o3lyHsibwUqCTG1CtR7quKmX06Gqfu5fpMdoxSVeC79vLKlfH/F3IqZKXUS9Z4dqJ9UK
 BOU43Zwcb4iYYNh+AOeGGufeZaFvwXeXp6fTN3ow0rySVBe3mUxqSvR1LepvtXFjaUdo
 8s+BNbjg9J52NFz+Dcf8hi1fEpxlqOd6IyNSwYbKy4wlIzTu3vJnxsihXJUBuh4xWeRF
 nQsWyRRgoQin3OwzLuREZI29c7n+CAwlQqMjB5+LOExRBpxArV+7kz3pSuFWOqCQJBUj
 mspw==
X-Gm-Message-State: AOJu0Yxv5HKh9JKjpLm5Ifju20O4BLAtb9H2miGU5T6iq02yE7EJ4bCF
 y5dsCimDy9FvniGmZVZwKBnw4wWQ+hIdyDddEgXWAiVeVuzwhBOjSto=
X-Google-Smtp-Source: AGHT+IFQO6Rd55W1bSx108AIxdYn7ZlB9H87pOHDyXQJ5E4v8e1fVgooPpxKYnyvl6bnSBxa/EPLAJPuWSy9neryGBw=
X-Received: by 2002:a1f:4cc4:0:b0:48d:1e9:2707 with SMTP id
 z187-20020a1f4cc4000000b0048d01e92707mr21385936vka.7.1693260597166; Mon, 28
 Aug 2023 15:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230828191333.77249-1-heinrich.schuchardt@canonical.com>
 <20230828191333.77249-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230828191333.77249-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 16:09:27 -0600
Message-ID: <CAPnjgZ2mDgHbuRa_W=NVCZcsoeT9siRz=oYHJ77fed-oiv3F8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dm: event: document all events
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, 28 Aug 2023 at 13:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide Sphinx documentation for all events.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         remove non-printing comments from num event_t
>         correct texts according to Simon's suggestions
> ---
>  include/event.h | 97 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!
