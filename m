Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4F9EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEB686CF6;
	Sun, 10 Sep 2023 21:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMQF0zu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E04B86D20; Sun, 10 Sep 2023 21:14:56 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0F086D00
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d7e87b4a0f2so3211874276.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ke0pFhZ2wjhYNy86oqUfFRYCfXZDPOmF+60LkiJ+jF0=;
 b=fMQF0zu9rjcXZ6iGTticH5LmLExJcgswZXPOO3TEvqPN6wekoJDaL5nhjnqrGgN4Hj
 fua3vSmaXpvYjJbJ7s4Wr0XziHU5HaLvbynq62KrVkjStA3LXZ14gO6TzV+wEoqAQPLG
 loiIsnT+1Dmxf4nf/n1OgfH5GW3Qis8kmRj9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ke0pFhZ2wjhYNy86oqUfFRYCfXZDPOmF+60LkiJ+jF0=;
 b=SPy05BoH4PLu8lT4LloN2xXU7W/ly1NsL9n6t/hwHoa964IgDTO6V3KtHpB8vXGMET
 FpXHIJc6TP7nFErkYgFXG/d0aCT0FY+7M+c8zxxoMY1HPLwd0HExxZnQ0DffASZegtx9
 5+75wajYNxJ2o1bdV6nynU4fhRhthrFOv2q8fsSZUuCad9+rKex4j1uJgibExj4SgLIN
 gkc6+NTZNWytuSpE8V3wCwo2rQrqy/0UItYGk0yyXEbqo3II+FlrqT+M8o+7V2z0sM96
 TTTqvmHi9aqFcYuA4y/NjaLwAMe6Mi6u9ng6uldWBqZOYLimXPy/mUZj1ZPuPGgNgzU0
 m0fQ==
X-Gm-Message-State: AOJu0YziAZfzA4Y72lQ1NCHlACaaW1wnfPT6OhXFEkgb938HwLVL+jF8
 Yv6/TouX5Ot20BnHHx38m3D/DD0iWnvAD0Y3fR+ZrQ==
X-Google-Smtp-Source: AGHT+IH+DyRDUtZQ5zaPtWIbDKs8ixo4XL+pBnfzK6WKpNjr3H2NfNzFv0oCIXRZ8HTnEA4MUVuy2QdQA7BGVhA9jx0=
X-Received: by 2002:a25:2e01:0:b0:d62:b8f5:d745 with SMTP id
 u1-20020a252e01000000b00d62b8f5d745mr6507708ybu.52.1694373286952; Sun, 10 Sep
 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230908203723.5702-1-ilias.apalodimas@linaro.org>
 <849ad57d-2941-4066-870e-0dfcbf938fc6@gmx.de>
In-Reply-To: <849ad57d-2941-4066-870e-0dfcbf938fc6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:17 -0600
Message-ID: <CAPnjgZ38B1qT=nxw9xyu9L+rN9FZ=NJrPfmaxoXJXUo-QsNSUQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix autostart for TPM1.2 devices
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Fri, 8 Sept 2023 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/8/23 22:37, Ilias Apalodimas wrote:
> > On commit e663b2ff4ba2("tpm: Add 'tpm autostart' shell command") an
> > autostart function was added for both TPM1.2 and 2.0 devices.  Instead
> > of correctly wiring the autostart command for TPM1.2 devices that patch
> > mistakenly added it on 'tpm init'
> >
> > Fixes: commit e663b2ff4ba2("tpm: Add 'tpm autostart' shell command")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > ---
> >   cmd/tpm-v1.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
