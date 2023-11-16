Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A343C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB56874CF;
	Thu, 16 Nov 2023 17:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lNWIcYD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A60286F73; Thu, 16 Nov 2023 17:04:47 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CB1874CC
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso144267766b.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700150681; x=1700755481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MKqkGSI4NaXEIB9NWSGm8KcYW0xjwGs2rndqWtA1INk=;
 b=lNWIcYD+clYbbPMspfqc4edKrWMOOD4KgAFHwWw4A4EbMgyZm8C6s7j5e/L/KdltAi
 vkwO2uJ5dlHId2BAVrm6m+Orp8WvgVzuPVOKteQCHzP7Jlt7XonHAd2XNuq2VEfmu9uE
 lgs1iC39hDzmust25ToWDXe5bjpw4/duvWvWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150681; x=1700755481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MKqkGSI4NaXEIB9NWSGm8KcYW0xjwGs2rndqWtA1INk=;
 b=TXEHkcyu9Dc1+/w+wMlgfJWF9WGzA6XzwW20XqlirKDS8IgTzcOt4TCmFPiLlmRkwk
 Rg+pUxr9hvZxZDwm/Y4EhGT65bAjYbHzRB1X+fQUKiES/gNSsbGKc4eTHQQQKJ4OBSsj
 BJN8HDP+33yLQ+4DKdIttaCzN+u3KHL4JUcswzKfrAH9gi6xukQL9Ky7Kfl6E/LsSltJ
 +FBNgMcVS4PqcXXft05vF+J28aPPmGIPlwtegKjK6LZmxpOzNt2jcsZU0I+7YfxpA4Td
 knC/a99FE+LslYkS8CjL39Kr9Era5O4GSHXO0wTA1X+wfJ38vFtARv5qjOair0ffBTzp
 AmGg==
X-Gm-Message-State: AOJu0YzTa6guKVES3Gj++KVHXPRs1p3Lxhtzle2O3QveqtpN0yCfnqhB
 +sAh0e+lL9qnMlPwsUhhAkYJOZBGxqTj8labQl2VHQ==
X-Google-Smtp-Source: AGHT+IFixOdHrL9ShJmTh9vOsEjMJxd3E0DLbiVDyEw4cLN+Er2SbSIIsXhjRqs5St065HJGe17ux5EWFO6JOQx2vbI=
X-Received: by 2002:a17:906:d217:b0:9be:3c7e:7f38 with SMTP id
 w23-20020a170906d21700b009be3c7e7f38mr11690356ejz.10.1700150681449; Thu, 16
 Nov 2023 08:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-3-n-francis@ti.com>
In-Reply-To: <20231115101024.3441093-3-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 16 Nov 2023 09:04:29 -0700
Message-ID: <CAPnjgZ2R0O-VZdRpUt2p45y2_kzY2yL5apciP+vz4hHDwfZR3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: k3-*-binman: Move to using templated FITs
To: Neha Malcom Francis <n-francis@ti.com>
Cc: marcel.ziswiler@toradex.com, u-boot@lists.denx.de, vigneshr@ti.com, 
 nm@ti.com, u-kumar1@ti.com, kamlesh@ti.com, m-chawdhry@ti.com, afd@ti.com, 
 mkorpershoek@baylibre.com
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

Hi Neha,

On Wed, 15 Nov 2023 at 03:10, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Reduce redundancy in code by using templates to generate the A72 boot
> binaries (tispl.bin and u-boot.img) as well as R5 boot binary sysfw.itb
> (for legacy boot following devices J721E and AM65x).
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi          | 157 +--------
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 155 +-------
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          | 158 +--------
>  arch/arm/dts/k3-am64x-binman.dtsi             | 151 +-------
>  arch/arm/dts/k3-am65x-binman.dtsi             | 273 +-------------
>  arch/arm/dts/k3-j7200-binman.dtsi             | 159 +--------
>  arch/arm/dts/k3-j721e-binman.dtsi             | 332 +-----------------
>  arch/arm/dts/k3-j721s2-binman.dtsi            | 157 +--------
>  8 files changed, 54 insertions(+), 1488 deletions(-)
>

Gosh that's a huge improvement!

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
