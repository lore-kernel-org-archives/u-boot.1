Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C794D69119
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF368988F;
	Thu, 28 Nov 2024 16:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hM32q2qF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08EE89C67; Thu, 28 Nov 2024 16:46:20 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39F889877
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ea39638194so798653a91.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808777; x=1733413577; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HPX7uFNohhh7V3BNH/E/P+M9sjGXY7KuWD+IuIYSrwo=;
 b=hM32q2qFjhR3TtL5xEpBc7yl23licIEOBA+uFSVv9FGtCYp5VX6bI+52db3YcaDv3d
 X/gkzfcVi5x+eUfiNNWqDW1jeRIZoXhvHFOFjGxgQkJgx+rQsPgdF1vXt01gIEDSkWlp
 4FB7LmvUMl7WXxYo0QgW6ffTIat37IOr9bACw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808777; x=1733413577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HPX7uFNohhh7V3BNH/E/P+M9sjGXY7KuWD+IuIYSrwo=;
 b=tOKL5vgxH3QQraR74OVH1dgEJJoQ0YH4L2T4Xr0gAOCZ6JDuI927jWQptzdUqyL4CS
 9CYB1+FQ3hL2JI2ghhKRoo5ecQs9Ei8jqQHZP2/VEG1T1uCriWay6Fxqr/Stt3u88DZx
 x+dql+HnrvUQWITvM+SqRlIqhT4fFoPfr8Xr8gwYtyOzZuv2fM1ngEaZToZ9nrWB7rvT
 xz8zXx6YmKvhGwwmXcY5y83fzSGCgIOHYw3ojtyKI0UKKh2ALE+iOwcsXJ/k3QZGDd2A
 njdr1KT2Q9KZGdj4ntZFfg1e+6wU2ClBTQTI2oEZ+/5WiJCuTcPvIZ2pxjmpLDNIvxZC
 f5Jg==
X-Gm-Message-State: AOJu0Yz/fuEJAMb4O4yQ3pYb68n6KxUDzgDDLzAtCDRimQuD4vwlAEca
 sprEDi9ENd8NR6xjoLRMLFVTHe5IL02X1z5gWa2GVTwqazwn5oBbnzBXF1kkffbauMOOypUXp8v
 PFrI68R7+J6ZhJ+qs2OygabtBlJqy2XjHXPfh
X-Gm-Gg: ASbGncttu+OpB+AWMaHvq4ZtI+/+aTeY2QO/7wpA7Sd6O4JFyM3Um2++ojeAnhS+T7I
 mD5V3aZm6cGCwwEQ46+4Fl1U8CPaWdgs=
X-Google-Smtp-Source: AGHT+IF3Rw2a/j0jZpmpqFSHRd7TccXcfRjIcwoDoZKO77Rd0/1IOCAbfKEhB4L7KgJKlWpSkzr0r5rhYZelg4aTt00=
X-Received: by 2002:a17:90b:4b4f:b0:2ea:3d2e:a0d7 with SMTP id
 98e67ed59e1d1-2ee08eb2f04mr9874030a91.15.1732808777237; Thu, 28 Nov 2024
 07:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-8-trini@konsulko.com>
In-Reply-To: <20241127172247.1488685-8-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 08:45:54 -0700
Message-ID: <CAFLszTgKiRHsAooddJWOQnV-HO9xjdNqEBQcs+YfparKBjZC1A@mail.gmail.com>
Subject: Re: [v6 07/12] docker: Use cache mounts for apt
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

On Wed, 27 Nov 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
>
> Instead of deleting /var/lib/apt/lists after each relevant RUN line, use
> a cache mount as is the current best practices.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v6:
> - New patch
> ---
>  tools/docker/Dockerfile | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
