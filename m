Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA7FC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA2D88427;
	Wed, 19 Jun 2024 14:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oq2V92G0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6578844B; Wed, 19 Jun 2024 14:14:58 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9073B88415
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f9aeb96b93so4611865ad.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718799295; x=1719404095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RZem6zVxCmUyxT7kdOPHuzcjPs0eEV09BEFfMqQysuI=;
 b=oq2V92G0UjPlTqWm3gZlG+9RA4mryxcSsrZzSf2XYTCgNM1/wLYOOsMLQeCRaUieba
 TYTVBcJDENdFm7enob5c3TJqApCxgiU+Ckv+abaODaX9CgMi3JjSmgW/6fTw5HsVBOFo
 m8JHtIoQNs3KouVV/Ld4h8OzoNjknt8X/sgEHtrwkoWhnqXGpssxPZ4S7SxOlQfrEnag
 1b9BtPH4DdlwHcwBCl7ccs8zj94KoenPomFZz3N01U/QMunig2qzqPrWqWrpI/l1jgDI
 0c7kLu6/+22bIthEsFu8W7QA/m5l9XZA098GUQ/sNvchQ7lrnKQCmNmWYLOcq588dQWN
 HEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718799295; x=1719404095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RZem6zVxCmUyxT7kdOPHuzcjPs0eEV09BEFfMqQysuI=;
 b=W48qG/PYIpInaXUkcZSt6tJ5HAMdccrzLo0zuJYi8cKs4+SDwkz35/m0fX874qDq4i
 /6Jn5g0AXaFOnPKXUZEuQrizxYS157ib+1XIfjpgbSGfwh4cevrQt3BktQB06kZbbfJ+
 PSmeVe5f169fS5WIDHbQkFL+O0jvV3um+N4/XVJVHkyJLsu9rSTp2oPC2Bwma4gBfPfC
 /BSRyJz0cfDhZtIdlHvrDgTKypExDlBrp4GadWlsQ8RJptMZa/YFoHCuAZ/cn7Lbzzbr
 E4Kpl4ajNWjoZlDDyvqMbzGYUfa1DgdqHbVSMNEGDIQLGH8p2oXxlG2dK99YbiEiHNcD
 86+A==
X-Gm-Message-State: AOJu0YzCM3DNx4a841xQdfVmftdi1VlltzQNsQLk+C92XsEsruDRxv0c
 mxVi7RmWmi6DtsZZ6fubu6t4No6EDhWEdTdmkPjU1Ee7O8gtaUGWkRq8OuIu3lTvno7BSgb+6gw
 yNqnhqFknRhi929i1IEUpL14YAy3HKAeCzSL2M4WCMp95muEGqotAXw==
X-Google-Smtp-Source: AGHT+IGsPeERS3Htmv4iOUcv7aFvGfIAWSHt1d2gffKMgPzvqLerVHIuuYqVGZn7ChmKDkFpIOLkMJVLzQPCR1ey88E=
X-Received: by 2002:a17:902:e546:b0:1f9:a602:5e39 with SMTP id
 d9443c01a7336-1f9aa3bcbd0mr28100125ad.11.1718799295028; Wed, 19 Jun 2024
 05:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <e76ac139a4f3841535e1ee306e912fd758dee957.1718638104.git.jerome.forissier@linaro.org>
In-Reply-To: <e76ac139a4f3841535e1ee306e912fd758dee957.1718638104.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Jun 2024 15:14:18 +0300
Message-ID: <CAC_iWj+kw2u7h_bHwWKsH7JjzvimLKv-ioM=ZuzO8ETc4oneoA@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] configs: add qemu_arm64_lwip_defconfig
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 17 Jun 2024 at 18:33, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
> selects NET_LWIP instead of NET. This config has all the supported net
> commands enabled.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> new file mode 100644
> index 00000000000..1f5fd097f0e
> --- /dev/null
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -0,0 +1,4 @@
> +#include <configs/qemu_arm64_defconfig>
> +CONFIG_NET_LWIP=y
> +CONFIG_CMD_DNS=y
> +CONFIG_CMD_WGET=y
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
