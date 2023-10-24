Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766C9C25B6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E45A8798C;
	Tue, 24 Oct 2023 20:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vcjsK8z6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852928726A; Tue, 24 Oct 2023 20:03:28 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93F787996
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so4542266b.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698170604; x=1698775404; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=np5vEsl2fNmI8JFiwvIEMjKKdwQnnyHSwhZ1kmeXVXM=;
 b=vcjsK8z637C4FcyoKCmeYHl2ZxXDrAYPnl3c939ujQpolUboWFiiJm7I2rtKfLIFhe
 zb+1l2dW+gSv9KBC/GkObmBW8TtQg1qfg9xQiWvt7VFa9hCkue2MRdds9hPOkZpe+a5I
 csPSEF4/B6ipJxbjzA+LzC9DhyAsaxvmIIw3vEpCGh1MTxhmV1mhOeXA6aEGgdVNmzzR
 KR3nMklzAXN+zf5NLfz/M9OvEWkOVwPHNF20nPG/q15w1xZsOLJ3ydVvEMqYmXjxyQ1S
 /3/e9mfh2/DpO6PG8nW7I1cKqKsFtQDLy/kFuddhNku+QOheiuM8nz19mVyIX/7H9aO0
 x79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170604; x=1698775404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=np5vEsl2fNmI8JFiwvIEMjKKdwQnnyHSwhZ1kmeXVXM=;
 b=HZ76lPXf/HIIJUF3LEb3NhlDi6ra68z+UJydvo8/m1SDfSxvm01ikxc+UOzBHpfKfY
 T7bHHamy2FNi+lcQay6aK2tHzjzJYJItOBO/x8ziHwfg7kKBSzqS8/+yuFkLQkDFi76c
 L6FbGEtVWGxp7EIBzVPhOgUADY8UMXA94WJpeXHB2cAO9uFmDtqy+D6Llzj3O3NqpYN9
 rHGg5BP0owfrthLJ67t4C6jCqmCdEANvAM51efemNksDO8LjF5vgRNvoWk/edEdoKbhW
 30fRh6HSycXkdiqeZxSFQnpk8vp/OCsMz6kuodas+44Jqp6fXWBvafvjNRPXPDqTWlVN
 K3PQ==
X-Gm-Message-State: AOJu0Yz1xjwycL0qH5Kcbq5SH4y2eaDlJr74wlOPeM/uwY2lnW2PeRuw
 U5akIiUZfT9LB8vBz9mtZ8e1/Jc3vi00+Yxp43HIEdcQAFFZBHSPQaL/RL3d
X-Google-Smtp-Source: AGHT+IGCzm1Rot70aDGv1qzJvI9Dwt+C8XNxo67Hv5tF8K3Za+VbUsbwPYd+c+QLVu6YFJtR72g+j2DnmJ4WP/5XdoM=
X-Received: by 2002:a17:907:c205:b0:9ae:50ec:bd81 with SMTP id
 ti5-20020a170907c20500b009ae50ecbd81mr12836079ejc.21.1698170604173; Tue, 24
 Oct 2023 11:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231024120307.17896-1-tom@tom-fitzhenry.me.uk>
In-Reply-To: <20231024120307.17896-1-tom@tom-fitzhenry.me.uk>
From: Simon Glass <sjg@google.com>
Date: Tue, 24 Oct 2023 11:03:12 -0700
Message-ID: <CAPnjgZ0Toi5RPBc4YP7YwNArr9cVgswgQj2yx1NPs_TAFAJ_yg@mail.gmail.com>
Subject: Re: [PATCH] doc: usage: fix ordering of shell commands
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
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

On Tue, 24 Oct 2023 at 05:03, Tom Fitzhenry <tom@tom-fitzhenry.me.uk> wrote:
>
> I initially didn't find the bootz docs when I went looking for them. :)
> ---
>  doc/usage/index.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
