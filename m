Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F398AC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FE588845;
	Mon, 15 Jul 2024 13:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kWKIoVGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67571887FA; Mon, 15 Jul 2024 13:39:43 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5091088806
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-65cd720cee2so37771877b3.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043580; x=1721648380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vctDLNdpamhMNY/fJ255v7aYl4wcd6d0PWjDid+wdQI=;
 b=kWKIoVGw3Azbg7KFUgpMBjPyJ/QpmpSuDc4veGvPgvKos/PkbZNaMBII851pra2Ahc
 OkmQZ0iOfa17Xj/JSSZqgyO4jNX8DIGzI03eLQMkcd1FaiG4UvK2zU7jjN6SziC1dPAm
 S6bSjxS6zZx3cZKdpVgHwSUUTriTZQy3eG+6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043580; x=1721648380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vctDLNdpamhMNY/fJ255v7aYl4wcd6d0PWjDid+wdQI=;
 b=PIn/rLuUu3kZO+Z0m9axESl9rsBKJIqg7IblAhCoTh+BRLPGZbo+XOZnJ4sXjtyWNr
 Py+hHCIKaUhB39tfTUHCZvzUNzTLU6oe8k9w7oEkiQWZfXvWVnlq4rZ3HAWsdYFtqZSz
 Hv1/cRv4GqKrmf3xjmuIxfCyk7oGsZIXols/JWPsvaNg6cGGNnxR/Eth/bTb+CJWkrwb
 WL/KO9eaK5S+5SWXZBfIjIIQbP3e/1pJxPHs5R5rp1bhFtE4+36lBcCETKls3ymz/qtR
 qyokw9zD9EoVhHQcKInbHsX4RKuoR/82u4qBJVJGzOyx4tQWB6I0VsOmNsd41uBwFT4i
 lUUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtitLxYYlAOzCw29BvrFLWLoRfu8kLqq+OsQ8dLWVYev2Re24TRPv0c4TloItt73VIxOgldf+SCxuzYIIZz99rGj4iPQ==
X-Gm-Message-State: AOJu0YzYyVkcR3uLJb6mGamEmBKVdTgBKSOc2v0mSWgYZeDE67lKnXq6
 +FoNiJSgEIF9ll+W+f9kI6rVpUkS5TWcGUhGGGct+Pw4B8aYEHzokgOWT9WgPhaRhnUvsJTg8Hk
 yzXyURJqx1ZlcJn2UOAWhp64sBGd0tecNK3Am
X-Google-Smtp-Source: AGHT+IF1aYwUZPENfAQC6eOnaAXaDMNcpdgcSor24/wfJBItIVB+CBubfdCqvXzEQaMqvbn1+irjBB7U4TzfMJxC/Uo=
X-Received: by 2002:a81:ae1e:0:b0:65b:a403:9eba with SMTP id
 00721157ae682-65ba403a03emr163377337b3.11.1721043580233; Mon, 15 Jul 2024
 04:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:29 +0100
Message-ID: <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Integrate cmd-db into the U-Boot driver model.
>
> This is just a wrapper around an in-memory database, so we just need to
> get the address and validate that cmd-db is there.
>
> Since cmd_db_header will be stored in the .data section we can skip
> bind if it's already set.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> To: Simon Glass <sjg@chromium.org>
> ---
>  drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
>  include/soc/qcom/cmd-db.h |  3 --
>  2 files changed, 23 insertions(+), 52 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW, this is a MISC driver. Does it implement the read() operation?
