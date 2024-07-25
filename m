Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E965C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FD1886E6;
	Fri, 26 Jul 2024 01:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xg4qFZCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7923B884CA; Fri, 26 Jul 2024 01:32:50 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FAC88580
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d5846f7985so231072eaf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950364; x=1722555164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AobJFHJRvrQEB0sZ7WH1SjOVayQBaT/Uy+pwzWABHbA=;
 b=Xg4qFZChKF9QGuDqiF9pBt99C1qWzhjm6R3k8BOkd6nyUu5vGHif8IjswBF0hxkVzp
 TB5NI55cEVhgHPBkyBLKDJ1sWj97V4KCgRI8ki8UYaczDSqMKGLCkdhwitKsDz4zL0uK
 sZGe+Sd/KvJUVbwoFaSJIgPSgjKAGzB1sED7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950364; x=1722555164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AobJFHJRvrQEB0sZ7WH1SjOVayQBaT/Uy+pwzWABHbA=;
 b=IdFNe7b12CAUd9+2wXl3GmtRxMJwN7Rwu1aQ0+FZhSF0NjNCVA8hk5YjEQ7nqdprWv
 GVrq2EW19u3f45mUaSdgiDeGRKAuIu20FM82qg560/WYJ7mjsizN9hMsHqsgId1sRSeT
 inokQqFpzqgcK+pCV38liH0AjBrluNHy7U8bHs4P8YCJlsTyl7uW8lBCyOLlCKL61WDh
 KyMQSuKyDhl2xP1gX9iAtVLiiVtQhp3oCh7iORnkm+NMCvnWZAhBrZy8hWftShpF41CM
 d1BzRaOoqpJ5HZLzcmt+PgtTBpUv5A3pIqUbD+CICumFQGdmh/0EMFFloCdAXmDAYuLq
 77dQ==
X-Gm-Message-State: AOJu0Ywxby5djOmD2KyeNSvGNmtVxw07zikLnmM5A2tsWxbCB3xSsaWy
 qN/eaMGJQJsyo5jmccujnqSliEo5hb+IBYEX+8xklx+Xfy/8YlaNCXC6kJLSKVIDXJEgu4U0aiy
 0SykVYD26mS/nspu0EqzbE3rCZMjfSPMgSxLE
X-Google-Smtp-Source: AGHT+IGaYA+z83X5Iu5pmTQUfju0yIlEaoQac1poVyz5sINXRYMJ5gi92MGNP7ernGWSRkwat7acQI2u4I1XMcb5PSc=
X-Received: by 2002:a05:6358:248b:b0:1ab:9820:857f with SMTP id
 e5c5f4694b2df-1acf8891965mr602338155d.18.1721950364502; Thu, 25 Jul 2024
 16:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-27-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-27-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:33 -0600
Message-ID: <CAFLszTiqSN0pja51fy_o=ij-QJoe=vdoN-BSnSYAq61z_FTwTA@mail.gmail.com>
Subject: Re: [PATCH 26/40] spl: call spl_board_init() at the end of the spl
 init sequence
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The spl_board_init() function on sandbox invokes the unit
> tests. Invoking the tests should be done once the rest of the system
> has been initialised. Call the spl_board_init() function at the very
> end, once the rest of the initilisation functions have been called,
> including the setting up of the LMB memory map.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  common/spl/spl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
