Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23270CF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 02:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67DFF8914D;
	Wed,  9 Oct 2024 03:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LGQAOZob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8684A8914C; Wed,  9 Oct 2024 03:58:35 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FCAC8914F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbc7c77c99so5097226d6.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439112; x=1729043912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Np2ClKCeUVs3r0lL3RqwmARurCd57lMTZqK4j7mfFsw=;
 b=LGQAOZobrQ+rBM+N4y4Fw75PSmBoHR/7P6bQ3JwvzXqKmXR6Q70iQ+08MuYptkqM+T
 fvtDV7P5aFvbsgxkRlJTo+ZiaC32/ZwWg8mwWG5dFolBZ1LD5MZcyWlFYdSOi3FYF4Tj
 4s2r0OQCxo5uiMF10nfyPZULZpBcgGpHKLDw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439112; x=1729043912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Np2ClKCeUVs3r0lL3RqwmARurCd57lMTZqK4j7mfFsw=;
 b=ZzaqTw1OzE0fC3Ezli8Fz5WLOtKoHJoifXeRq9/IxVLV6zRPek+e7ZmDbogsMUx0vb
 wBFL/S81tMGWmypohA9ZDrf3l257pHe2ZS8wlABbknh0+p7KG7yB/uP7N3vTknWhFdo+
 GZCzvwKf6n78S48gbwELT1Y+bYE7mBYP19E00bl4nhaRGLhDazM2V5ZXd/FPULnUTkQe
 fCvnhtAD02BjJZHleDER9SCKoNviqXwXRdB0Wm12ir2p7dGWzl0bvCYef8+Zs1VZrykL
 2jyWz6c2hyR/YQif0eOEedFfmlB71iYQyUDsebogn9chCwDQy0mftrOHx8p0cR484bU3
 DpjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaWdARfN4b7TXXS6SfHNLU2bspzIDwmjhwi3PFW4j0JJxLykKd3vV08yndP8HihlBn4LhXcMQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyHaBjPEKkQ6ZogQlHqDtp4rNrDsnh8wg6Ns2eSmbZKAQUxVnB1
 WC/0b7HTWfxQtWGuW5wiUu3EjqDi2z+9sSCO3VEgQMVGuW5FATQ8QuIHIDbq0Bc0tjmuDZPyQ4f
 InG7NccpQgNCY93TzZFGOc5EmoFrMP6PqKAED
X-Google-Smtp-Source: AGHT+IG0PHsxvWresrb755IM5L9ghbGWDKfvXp84YOUfUu+FR68fhnJgyG3PC5KVqRWbiMa8MwjzqyOLkDGib+DhbIU=
X-Received: by 2002:a05:6214:4402:b0:6ca:756d:68a8 with SMTP id
 6a1803df08f44-6cbc9304943mr15719826d6.15.1728439112492; Tue, 08 Oct 2024
 18:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241008223219.105369-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241008223219.105369-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:58:21 -0600
Message-ID: <CAFLszTiO24nm_zNhbH0-tarax9QGtFvFen9-c0nBSpGraLLBcg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sandbox: add bootmethod EFI boot-manager
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

On Tue, 8 Oct 2024 at 16:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EFI boot-manager is the default method to boot EFI binaries.
> We should be able to use it on the Sandbox.
>
> * Enable EFI boot-manager bootmethod on the sandbox.
> * Adjust unit tests to reflect the additional boot method.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/sandbox/dts/test.dts |  4 ++++
>  test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
