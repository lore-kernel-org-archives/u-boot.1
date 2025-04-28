Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE06C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453998056A;
	Mon, 28 Apr 2025 18:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nqqnl3TJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7538A81E0F; Mon, 28 Apr 2025 18:08:28 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788E68004F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-549963b5551so5071250e87.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856506; x=1746461306; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWgJFgQena75ONHr+Cb+rOQR/aVwCpuOwZrkIrhPY0k=;
 b=Nqqnl3TJhefRMA9CB35lj622RGaag/B/+5QehfcxVViy2lSFC2y2Q19Xr7bdxxj4+t
 Tiw+e9+kKXfwytsLlvEDjuN+yTPz9IIeIG0vbWK0JhzjZIehBjop84DkC0R3Ns7ma0Nv
 ILyg/+dVDEtdZt7ylDOU6F6wjSANSodxEJk+tbwICAtiw1Yh47f6uwjKG6bWklT7mZtO
 LW/tbD2/jieIXnlwcJEDJERoa0DtZrELKjcB3qsO2iHrGz7XKs6iERvyHRZs/m7B94fl
 qW0tryHb2yvz13+kcE4xqD6Z49PvmMvNqTRVYD/tgFcynVvQd4eFerxu21xSOkPgyKqD
 QFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856506; x=1746461306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWgJFgQena75ONHr+Cb+rOQR/aVwCpuOwZrkIrhPY0k=;
 b=ZSzl5boI4iOy30gDcJ+CpUp6SNsAUviF4vhvHlbk57oI5Re+POpEdA4RqaZyH+UiIB
 ZQoRoEjGcdraEGLkyCDNRuUN4rL1pP/8lXL9F1M6M0P05GifpdXBLEfdtQHTsOoNglfh
 BFVplgWCNRolVyDAG6GVYE7ItWrgQIpjcGkkVcwWSJQiM3NGn7vj9G9s23ITOMEUL8Cn
 WwGGaX4ROlMyk39K+PM2kkch83i19WCOUMhElfFILF47m6uUyIX1JI9x9qelvX8tIkdm
 49uHg4Jb4fk0yGWmrDRqlhM8kfOsNl1+9QXj4JK8qURQOixy2nrTiqr+G633LLGYz8SL
 xwsQ==
X-Gm-Message-State: AOJu0Yw4m7xsxd9w29w5ZDrUo7lSb6RDSMbTg9QWSeIAQxGV06nDPUMc
 hVTRUZm5SP0KgeK5E2MlVeSV5/NAKwOdVyPa3/jXQaqGWdICifSVx9pSdOEAsuQ8UtO1Zrczam/
 Pic3DfdyeFCpT6ZVGpQfp/GeZbZPEoA==
X-Gm-Gg: ASbGnctDkxnjkc1dQWT+2wG9LEeoTh0rGY//pGt3PLb0rfn+tXaAvT/OfNM3O9iYI+Q
 Xk7ZVdSdM62sx84P20M+k82CA/LTIr8mju6T8EFm4+i88wXq31okP7OzQKKdPP94eAtG3tu/ho3
 bZGuub+qEiMVjeyvdJdkbAI8p0s5LO+8zQV1HlDocA0Q7aeH0Ez0mSgtTtej22YFg/
X-Google-Smtp-Source: AGHT+IFSMM+r2vo2v8HoRzrBYJ2/w6omTKSrMqUiHaqRv5L2LmaVU+HrNWoT2uai6naSpow2KtdNO5RCWEa7dLb+hWI=
X-Received: by 2002:a05:6512:1317:b0:540:206b:c355 with SMTP id
 2adb3069b0e04-54e8cbd82ffmr3454653e87.19.1745856505263; Mon, 28 Apr 2025
 09:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250416215524.3963310-1-aford173@gmail.com>
In-Reply-To: <20250416215524.3963310-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 13:08:13 -0300
X-Gm-Features: ATxdqUGD7zRISBeUb3N7MU-K75GcEBHnc3wOpWRs9fPnwx1TEfQdtKc3ag4lk0I
Message-ID: <CAOMZO5CdGt-bYs8-yfGpCCob1djqTF9PSmNvzh-ToojF=iwccQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Finish converting clock-osc-24 back to osc_24
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 cniedermaier@dh-electronics.com, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 16, 2025 at 7:12=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The UART clocks were added around the same time some other clock
> updates were happening, so converting clock-osc-24 back to osc_24
> was missed on the UART clocks for imx8mm and imx8mn, so update
> them here.
>
> Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
