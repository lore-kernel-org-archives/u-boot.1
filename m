Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DAECCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 14:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF7A836B2;
	Sun, 26 Oct 2025 15:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iPWkNeiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9602483623; Sun, 26 Oct 2025 15:27:15 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A500A82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 15:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63c1a0d6315so7270474a12.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761488833; x=1762093633; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ytmJ8y9JwnmWAyzknKkMYjTBc9gRHz/BU/sApuKwi7c=;
 b=iPWkNeiSjDO+cYige+jf6y5i3d13J1vtONFcn0muegDKrt0sJBA08T0mA2N2PLY3Bz
 30A5EcAUH9rWZ6zKVx/QV7TPRgAuTPbxzjBGDTNy3YAmvh6tXySPXsiu3cKz2uWN7s/J
 XlWQR18CpL0tCN+apLIMe8bi/ZJuL2ArRGXj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761488833; x=1762093633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ytmJ8y9JwnmWAyzknKkMYjTBc9gRHz/BU/sApuKwi7c=;
 b=YpSqt9NrmW6uBvMti0A7Xe+ytbzaWiHnSSpsdtgxTpwZhs0o8Iec0sQH3VX6a6Fd5+
 1qBaSM0yqQPBABYTDavIyDiWCUB/3drPyLXgN13xB+nVobEpNzclPn082CwHAPK6kCNI
 lE9/z3ABOPrsAh5u8aPZ8oNYaaLi/QegLqO2CbzOxG+p4VNb/F2LitN2DR5ZLAtQyVuy
 oHRKryt8Hpr4D7eSQrLk6af5zUkwU9X0GSiYaFSdWEU7D7XJJmlzHrkgTmpYI3Vju1EF
 uCUM5DXDMBoIfnBk/0UJX7aDPCkzJw5Zh4BwCAajBUe/0NIcVcFucVB0t5zNhSgQIiJs
 MhYg==
X-Gm-Message-State: AOJu0YyMMkQRtKdlBupjKkIJqAuc2xW4xicsSLj4qgqLsLEWmfJQ+bRT
 vS05IO/P6tUfg3nVh6/BX+7GGPDJC9dX+x/xFKsMnZiAtRJOH5wR18iSwPU42fpBvHgK6Fx6G+q
 2CW9qi8bB1wwxlA3qppEL0OBXznsEBbAVUTPz4uUl
X-Gm-Gg: ASbGncu+4vE/mCVpH9YF/3Cev/BySECDtHwhrRhORG6qObdO+e4nLzKobIT13n1LeZe
 FCSvXBsfmRd5TZqvVRnpF+WeH48mGzgDw31v3OAvjo59Jud0OeM29vCDL69PWAwyXVDnqdK3xE6
 8aFcVJdBVoxGPGIn/0XqvO94pJPgoUkLMO/Z8NdUoe2djQpgr1qwXfuOgi9eD4k3H/ccbw2Csl1
 tdLpL4e1nYyZ/BS4rwv156Umcm1RhcKpGNKtcWcjICOCvu/+i00bcOBGsK9
X-Google-Smtp-Source: AGHT+IH4axvxcaB1gaz1S2+WabIAk1Iw4qjd+PhPR2CujACxi0Epen79ymoEL3WkJCVKq/aZ/9fcnEB0+9oO6FqOn9E=
X-Received: by 2002:a05:6402:13ca:b0:62f:8274:d6bd with SMTP id
 4fb4d7f45d1cf-63c1f626dd4mr34918285a12.8.1761488833146; Sun, 26 Oct 2025
 07:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-2-wolfgang.wallner@br-automation.com>
In-Reply-To: <20251024151219.100970-2-wolfgang.wallner@br-automation.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 26 Oct 2025 14:26:58 +0000
X-Gm-Features: AWmQ_bmsawfFZBIbj_2ENuERE4aBlMUYBivp64Uo7-r55Afa2Ygsr0NiiQYNA5w
Message-ID: <CAFLszTgU_1m0jyjOqTrD1GWv1mURv4t2WOLPu3d0crA_rFBMbg@mail.gmail.com>
Subject: Re: [PATCH 1/9] doc: develop: Fix typos in binman/binman.rst
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yannic Moog <y.moog@phytec.de>
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

On Fri, 24 Oct 2025 at 16:12, Wolfgang Wallner
<wolfgang.wallner@br-automation.com> wrote:
>
> Fix some typos in binman.rst.
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
>
> ---
>
>  tools/binman/binman.rst | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
