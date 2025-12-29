Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241AEE92FCE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 18:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D8583EF1;
	Mon, 29 Dec 2025 19:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ggisz9dE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B61483EF2; Mon, 29 Dec 2025 19:26:09 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE4A83EAF
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 19:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-37ba5af5951so84477381fa.1
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767032767; x=1767637567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2xTshdcUdIYF0oM7bcMh1DEvQVptyHuXvrKArOiwKE=;
 b=Ggisz9dEHL/HhZINXYZ/j7p2xCfxBVatQXvGjbDIDqk15fKQ2ZiN/D6CBw2RcibGeu
 1i3t2FqSFWO4CX/S/YDB7Lnalr+QMk9H4qHg76vlGddg3otTs2IRmuXLdftXeMdqDUzk
 FuI1jTxnJSMYlzeOeZSrlRWCaCKheMmI6C/AIrNNUbIoVkopi7iOQV+sr8pQ2nSKhqtE
 Wpf851LqE0jgj7s1jUuRSPm6FUbnkBpbtmmpsy8X6bAzICxW9lPRo6HCZsK9XA+Fw08X
 Od+7/pmmnqW79YIMX4jnRpDr7HT9avLZpqszDtUYWn7ZwDAv9wh85EtTDEipmFtey6d9
 VFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767032767; x=1767637567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2xTshdcUdIYF0oM7bcMh1DEvQVptyHuXvrKArOiwKE=;
 b=I67hBtdCesE5BJ7ww1t5EtRGQWvISW/745fnQBTeJS9LIi22sGQ6Jxv1EwO82Lu/7w
 AppSymwg0xKncBBb6KEZscgI+fcIG36kaaP7JJscQvgwVSiAhdeq7LgocyLzsZtUH+U6
 QWnrtAj6v5ZZkIZUCXHr+ttU0EtLNvSwmXcDg24TdUDGLhsY5rcCg1v+hQmd6Ry6Xpi3
 EMgUFRHta30P757awAIMsAbB6sGgsvNAxcE/MqZ67GjB6WxqsYziW77BAF9Qc8zbYer7
 x4n3Yn/xFXeWXSA3EoFoirrVPBtwbMCiKllHVbHcFHtJJjvNnTgVcRt7+hio3oieZOsW
 +TbA==
X-Gm-Message-State: AOJu0YzCX4XVggQXwd/6zTcD9lSuV9Y5l/tgpSpBVIqHw7pC7bQpMRJU
 Wn8G8ANYGXqqqlbSF5Yj/GT9Ge/uspaeT6kPT1PGBQUCmqL0Hg1B5ZDUN/jYc8ZDPVeh+VXwBNC
 DWR0/WZ4OeGWm/Y3ryiVe5/u1skb16j0=
X-Gm-Gg: AY/fxX7fJu41sm+o4Gm8r/NiXHoYs2fEXYhNWW8N1LK3GDNHfaW4Pe/h1Mnjc0Rbll6
 zRCqBKSK+yTNLM/Lpn4wfXODA9exCGMSbD1To5iSKckoXPNXvVoCSifmexDGPd3qtMd+tKbyz0L
 i/db+kIC29F0pvpvwwglRlE6P1oI2o4tUIdEoBk4sNBtT+YrIaHCplf2JCGyy6lFkqgHKRkxK/R
 828p6HuoibCOGVNh+kIy1LAoKBPNAl913hyUGL5mah+CG6FLFxXw5GmnTqJNdPMCuitcIdA+2oQ
 zM0AB0SlQ59dfJNLIzty3uer
X-Google-Smtp-Source: AGHT+IFUY5WQDYlEowibhJbqPCC/H/BPu2tB2Hl32qMGGeiCRgF6Fr5F3yW+MJPLAsYKLKFJTamtSKZWxqMhXwbarWM=
X-Received: by 2002:a2e:be0f:0:b0:37b:969c:16f9 with SMTP id
 38308e7fff4ca-3812161d7admr100171401fa.25.1767032766740; Mon, 29 Dec 2025
 10:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20251228194329.354828-1-marex@nabladev.com>
In-Reply-To: <20251228194329.354828-1-marex@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Dec 2025 15:25:55 -0300
X-Gm-Features: AQt7F2pWlCovzEYv8WiEDsL7mbjmc_osgQwwwxrle5mixjCTU8c6fNdWkmCSZZU
Message-ID: <CAOMZO5DmJbAzfrEOhR=YXBXc14RAkuhYFURuqKZR+PZQPT+N8w@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Make flash.bin target available on i.MX9
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Sun, Dec 28, 2025 at 4:43=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> The current implementation of flash.bin generation with
> CONFIG_SPL_LOAD_IMX_CONTAINER=3Dy requires build of u-boot.cnt
> which is i.MX8 specific. Reinstate the i.MX8 check to avoid
> this dependency for i.MX9 .
>
> Fill in flash.bin target for i.MX9 into imx specific Makefile.
>
> Fixes: c3587197c0c9 ("Makefile: Make flash.bin target available for all p=
latforms")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Applied to u-boot-imx/next, thanks.
