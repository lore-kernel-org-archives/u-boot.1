Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F5EC36001
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 05:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E18E81DED;
	Mon, 24 Mar 2025 06:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nT3uiWCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7442681E14; Mon, 24 Mar 2025 06:36:18 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B53E81DE3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 06:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30332dfc821so1502001a91.3
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742794573; x=1743399373; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BUUwncdI//FJzC+KtYkiQTEuJ212ak9nA30f5PL9FAQ=;
 b=nT3uiWCsH4lU+QC7AvWMl2ZVoPcX71P48rdownW5wmRbpFXt7NSKqSHWhTPGOWPW9y
 0iOkZXZcn5mKSJITqDLHROcPkoj2jHCNRoKihyr2juFVHaTeCqBKHReY7VOSOmo/kn5i
 6LaaIaHBpzEKl2Yc283Yvlq7eetfCDd3TjGO8JjWYBG55JI18ARhOtGxi4Z+U5OWJ1G4
 Z0rjn6pAu+6drPBchjEPvufkrKSUEFbRYlmDU0Pnewop9akVIGkAWNeccfSxBTzqIVH0
 XM5TRpCh81tfKZ0vIBGWdwiKDiRp0pVloQtlTPUG3aEgWoVjHoLfCkCmBueFSCx73+Xm
 hgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742794573; x=1743399373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BUUwncdI//FJzC+KtYkiQTEuJ212ak9nA30f5PL9FAQ=;
 b=b3aYRcpWnrAfmKL4zVudPyoW3nk5d3ohc3Y97cyYwqn/IxtyFRImf5XVUe1HvNQQwD
 qF7aTU41pv/OvQXEFR0fylfXTbnHVA1ImpM52hy15SN49sAFFOKn1B2fc8LBG9NDlGnq
 Z1K+lwSYX22qQTBNSOwGU59Q8CYiL//NdIYZH5VsP4EPeUAGL8qfU6s6ZIM8em5B1sM5
 OKoBxQ6/Doa0nYp1g9UeAkWUrEvAeewOe3vkt5eAPz2VvNXi7lKQimJpxfQqiZ4JZATH
 TXwZYdYC9iN1b2sJOhhRT3PMTdfmRX5yWotOw8iGlS/hV8E7IC7O5ojlGZI3L9c9Ryy7
 1T2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSqVWb5kWUoUJo/Hdjz+xGUMcjcwWQIAoe21n/5lyCvDJ9SKgYSjFqbdAXcWKjJxbNhqq2+hg=@lists.denx.de
X-Gm-Message-State: AOJu0YytGPxMTZmMT/Da9FFGO2Aa8OAGPIkzSXHh2RqGlSahoMcZCk3f
 zl4Xnxyru1r9lv0biW/QPwSmA3sOq+Wlxg+cILhoXlBQ95mUOiq6NeGGwH6CENuDZEi43SmoZtW
 hhkOqHV4yG1ZpoJJsKK0YTMvAargdqQ==
X-Gm-Gg: ASbGncvoEpcHPtAIjVXurbehsTZ/rAjFBrlkfO4de6w7H0buGhLZx/CUyOuaoXmeC7P
 vR4ji7wQYcwdpr45noclaBAG099yrZv794vfJUIX7068974z6WhkhazYIe0m1wR3AvTEnTM4S+7
 J+sgoZovrAyNeVzBSEaRQljM6vTQhSCkArd74NZzWpP8Qib85zQ/YU
X-Google-Smtp-Source: AGHT+IGffTzQ4lgzmwIN2lrPI2kxHGVgXgMDsfWee0s16+PCIo/jzrUPPh/6UaMcah1kPgDRYtWjopDU/Tusd5f6y8k=
X-Received: by 2002:a17:90b:2d4c:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-3030fe8d565mr19582310a91.7.1742794573335; Sun, 23 Mar 2025
 22:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-2-anarsoul@gmail.com>
In-Reply-To: <20250323225134.2369473-2-anarsoul@gmail.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Mon, 24 Mar 2025 08:36:01 +0300
X-Gm-Features: AQ5f1Jpizwv3FxY-hRoE5YkCABVAjgeXbwpBC3nXwD-qmKizX0oeCwx6aQR413w
Message-ID: <CAJs94EbLgAZ5hnrzDLF1eovmvY-M_qtmhNbBcDCATCX=Ht_YWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] video: rockchip: rk3328: filter unsupported modes
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Anatolij Gustschin <agust@denx.de>, Jagan Teki <jagan@edgeble.ai>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

You say that the 4K works in Linux. Wouldn't it be better to fix the 4K
support in u-boot?

=D0=BF=D0=BD, 24 =D0=BC=D0=B0=D1=80. 2025 =D0=B3., 01:51 Vasily Khoruzhick =
<anarsoul@gmail.com>:

> While RK3328 is capable of 4K resolutions, dw-hdmi driver in u-boot
> seems to have some issue with 4K. 1440p or lower works fine.
>
> Limit max resolutions to 2560x1440x60Hz, by filtering the modes with
> pixel clock > 297MHz
>
> Fixes: f3ea872970d603 ("video: rockchip: Add rk3328 hdmi support")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: add a comment that max pixel clock limit is a workaround
>
> drivers/video/rockchip/rk3328_hdmi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/video/rockchip/rk3328_hdmi.c
> b/drivers/video/rockchip/rk3328_hdmi.c
> index 763669c09be..ff351aaac7c 100644
> --- a/drivers/video/rockchip/rk3328_hdmi.c
> +++ b/drivers/video/rockchip/rk3328_hdmi.c
> @@ -105,9 +105,20 @@ static int rk3328_hdmi_probe(struct udevice *dev)
>         return 0;
>  }
>
> +static bool rk3328_hdmi_mode_valid(struct udevice *dev,
> +                                  const struct display_timing *timing)
> +{
> +       /* Limit pixel clock to 297MHz. While RK3328 support higher rates
> and it
> +        * works in Linux, it doesn't seem to work in u-boot. That limits
> max
> +        * resolution to 1440p
> +        */
> +       return timing->pixelclock.typ <=3D 297000000;
> +}
> +
>  static const struct dm_display_ops rk3328_hdmi_ops =3D {
>         .read_edid =3D rk_hdmi_read_edid,
>         .enable =3D rk3328_hdmi_enable,
> +       .mode_valid =3D rk3328_hdmi_mode_valid,
>  };
>
>  static const struct udevice_id rk3328_hdmi_ids[] =3D {
> --
> 2.49.0
>
>
