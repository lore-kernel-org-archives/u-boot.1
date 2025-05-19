Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA0CC2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 07:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE92F82998;
	Mon, 19 May 2025 09:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UhJbq7i6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1743829E4; Mon, 19 May 2025 09:29:28 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7BA82998
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 09:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70b50e0566fso36779987b3.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747639765; x=1748244565; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=och3tBt15BpNcmtOmpSvmD0Log/oMxAd9iOacrDS1iw=;
 b=UhJbq7i6jF5CqlhAAPX7tcIRzeX6w7Nl5fwiM+Xqpc4fjYp6r/B0yEk2N9jg0AFpI2
 GvnkWgLh5tyh9HdlS8XEZKuG/G2wkfW2O8/wppdJ1nSJ7po7ANa0p2/nNqVyI+tnukSH
 WN3O4zTKKbc+e2qfs4t+2o+tzhrEe1Pf4Xvx8jGZ5sTGPcau2nWB7qagdGLKp7A6ddPT
 6zFwHi3srFzYTSNatG+J2WqavwwFanw5o+OKkkeVzwx7oGMnHXpZpuNM4rNZmvQ28IUm
 bZgLL8dz0unJuSE2TA5mJdGrPIV0r5WQ53kAs52sFv9iSPcIiWOrFZEuPDNCoDFXWAZA
 k4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747639765; x=1748244565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=och3tBt15BpNcmtOmpSvmD0Log/oMxAd9iOacrDS1iw=;
 b=Hbfd3yQRQ63ih4uPIdcTXh2/ct7MbMdXOtVbszq9vSnyWADyiOeIx+2Q19IItuNQ0P
 Dy64WVTYUuoC0GwpszdTmlZWlrpyV79eosmAg2Vo3LC+C8/qomcWl+nNki34muSqimyi
 B7Jn2b+xIjbbg99AHx3mJVLvqLIqRfcYsmfoVz7NXhKlvNuYkaCbjuEge3EHNIqd/N9D
 zmlrI9IO5a6xPLULsyi1XjAMTiaS4Fs1lUAIsg3FLIn5RkJU5SPAWearvRt5Zqi58KDo
 uJur951a7xplfDGfSBvH7IY9taPWA6xaa2uCxRqbtCmX1FWXG9I4ztBQTG+81kN6QcNM
 NUsw==
X-Gm-Message-State: AOJu0Yye4iAfSmsMuVlHBw0aIXa0NMFzZEfl6qmjuJlyekiODpvDn6Ro
 HJw0IQM9FeONRvKvocrkRHgTT+yPSAaRSNmPOa4ESfZtD62uQMN7ylOSwjdQabAmZtSG+1a6xe8
 6AJr8awngriKuoer1pjOLHaGDClh6qQeyVk2Nq7c64g==
X-Gm-Gg: ASbGncvKQBty4S1Ee6ua09GVu26TNBW1ll7dIMqwRcwk0reS32mxg58mKu4zeRd9IBM
 FqmG2rL9vPOLOol3iRCVjccKAsA/JFuzPW4je//+DrvaW+pSviaEEFVUsvabOgna0lx2cca+3yn
 KVMO3VkuKtNLGT3ahyZTc+v52vAi4nVaLLGw==
X-Google-Smtp-Source: AGHT+IHtwqVCD2sBKS4micbdnPe2MyBokl88TByk7ubq7RqYE+2YDewhougXXBz8VRc/kpVEQKdBySa//vXQmKgjp5Y=
X-Received: by 2002:a05:690c:88f:b0:6f9:7fe6:9d48 with SMTP id
 00721157ae682-70caaf38c21mr132042457b3.7.1747639765455; Mon, 19 May 2025
 00:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250516085256.30386-1-adriano.cordova@canonical.com>
 <20250516085256.30386-3-adriano.cordova@canonical.com>
In-Reply-To: <20250516085256.30386-3-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 10:28:49 +0300
X-Gm-Features: AX0GCFum6TCPMvTU5U3P8nR-QuQXVy8fp5-L6Rv5bEDLwhC_Bo0l8DRJNwfwy5w
Message-ID: <CAC_iWjKKraqemyymM7GW2vVWCiM530PQR7h1_B=csT26aHvuvw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cmd/Kconfig: select CMD_WGET if ARCH_QEMU
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

On Fri, 16 May 2025 at 11:52, Adriano Cordova <adrianox@gmail.com> wrote:
>
> select CMD_WGET for ARCH_QEMU. This way HTTP can be tested
> on the qemu platforms in CI.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index f21d27cb27f..fa353c6fcac 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2153,7 +2153,7 @@ config CMD_TFTPBOOT
>
>  config CMD_WGET
>         bool "wget"
> -       default y if SANDBOX
> +       default y if SANDBOX || ARCH_QEMU
>         select WGET
>         help
>           wget is a simple command to download kernel, or other files,
> --
> 2.48.1
>
