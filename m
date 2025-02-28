Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3150C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 21:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6348281100;
	Fri, 28 Feb 2025 22:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="chzQcMkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB2F81101; Fri, 28 Feb 2025 22:29:16 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A92809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 22:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso1207158276.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740778153; x=1741382953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj/f7zgOKyMyXNglvBzYfOQVh6qzO2rH9gV+H+/TJgI=;
 b=chzQcMkWXFqw3J6qmiqf9LwWYh6oMzF88N9VZuRCKuGCvCLDV+M3skXUyiBDcNbyH5
 7s1jvijKSk+FIqLSN8bReAsKxLtFBMAAssRCSUvhH/7Bw5KoKFkFquhIIfEPHD7ydOUr
 KbWW2tjt33vd8W/9bbCH0s0rA2Crf3ysbYE3qGOVbGBJY49yDH+r3MerTw/XucLIUdFV
 9lrM6vc9OFvklRcxHt4O47qwwh6hoUe3FSmEKCEjtuoqxP1Oxn+r+nYjrgqV+6yQHcfD
 j1oDneJZajwxMjpZ3jfk7HA8VhdsbGcXO3knnx6Tj9lGLiobOjo439Q/JODKnTrpNcgl
 7yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740778153; x=1741382953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rj/f7zgOKyMyXNglvBzYfOQVh6qzO2rH9gV+H+/TJgI=;
 b=eMw9zJXIpR5JY2qvjdfyLCBHHCCTkKHOji8Vc5cjTMosrIs2jVjw2sFqMusySLI5y9
 +E/8jQt/6xsXjx8kte8UOZuklV/J89qtUySSBjKshYj4wtjTOKEEtOebmhoWkD5w4eA1
 bAcepdacEvauBlC2JbZx+dQfoo0seWLTuLcKWhPlyR3ZIeDKcXDm9I/Z19hEWDtUV5AX
 25knyifC+02Y6xFxjs7Er+vt3z00ERMuq3txKW3tSTg4AZ7zF6tkYUjje/f5BT7rVFCy
 dgc0bqmUNQ6xTxZQVl9mTifzaB6tg3Xpplr2zQBt65N9mlvzm1xNMQrDa009I3pMsz0y
 h2yg==
X-Gm-Message-State: AOJu0YwSn1VP8deyTx5HvC7NnWU3YxpEozNgYkASsQah3kLrnTfd1AY6
 KIlXzJsXzbxCGGr50UCwR41b0rHCza8Ki4IKKrHfcgevLFMkQEUJ4b/VwEQ5EE1SZMbvI6SMfy3
 nvOGOEIOKtjgUfQ9OnmBOpwBBYz4HielA6M7Qtw==
X-Gm-Gg: ASbGncvLIqU11PHACcXA4FgzafIsNf7iY7orhqXxMkldXDh+aXmhXEsQ4/NHmCevot2
 E8vuLcnGne+utgXa5q3m4lIWTRX2M+xRmxUkavusGQK9tr4vITO2BEWj9B3y0DCYYk29cm6gAuO
 tSJLcEeO+ouCgoUiclRvKIfyamb/JzgLlovwa52WqqeOfSPOPiWXibixX5xA==
X-Google-Smtp-Source: AGHT+IFHlrInIjNcwzRjGjTy6VVrgA+kJLEXt6BdzyaIVqTXbK5DA+2BhleutDKhzkigGhQvnnbFb32i+/fw+5upnW8=
X-Received: by 2002:a05:6902:26c8:b0:e5d:ac3c:9df1 with SMTP id
 3f1490d57ef6-e60b2e8ecd7mr5320174276.6.1740778152761; Fri, 28 Feb 2025
 13:29:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <328b4225800ab778089f095019fcd4b75e872a37.1740672437.git.jerome.forissier@linaro.org>
In-Reply-To: <328b4225800ab778089f095019fcd4b75e872a37.1740672437.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 23:28:36 +0200
X-Gm-Features: AQ5f1JrAcnFu9KoVQVboEe90pZnPnNwIgIFPMNh_GKxhvSu0wajhfAVdbXlDVJQ
Message-ID: <CAC_iWjL1Xg=rzm+jEmAWjVQWbgdaJgBbAyT3AZa1qgOYDN_nSg@mail.gmail.com>
Subject: Re: [PATCH 5/5] configs: qemu_arm64_lwip_defconfig: enable
 WGET_CACERT and MBEDTLS_LIB_X509_PEM
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
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

On Thu, 27 Feb 2025 at 18:09, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Enable the "wget cacert" command as well as support for parsing X509
> certificates in PEM format.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index 754c770c33f..f48c132743c 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -8,3 +8,5 @@ CONFIG_CMD_DNS=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
>  CONFIG_WGET_HTTPS=y
> +CONFIG_WGET_CACERT=y
> +CONFIG_MBEDTLS_LIB_X509_PEM=y
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
