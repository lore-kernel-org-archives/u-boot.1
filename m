Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1B0E94119
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC2F86DB8;
	Fri,  6 Oct 2023 22:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ToUsCXUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0A486DD5; Fri,  6 Oct 2023 22:44:33 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE3286BE7
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57bce354d94so1315080eaf.2
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696625069; x=1697229869; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woD9iz8qCJCn50HfEi4EZ6WGpaUhKkkKeUfgQqMtd0Y=;
 b=ToUsCXUja70Qknn9uWLsjGt9K3BGnTg3JH9dUBXhDWMlU5z03AHiq8SwcjSgYV58L0
 b1gY5KwWHNvcTltxL5a0RwHwG1zcRWHoBOPSLKgcemREGhEXwlITgamxNsee0vgCqwXt
 ts5XmBFR/vaGhnql9+jqXNu7qHijSRvssixZlDXH23xQGTdbYVS3Uqi1PVgcgw8QeHJv
 j01+CZrK5FyNmvP+C01QzdBxlvGk51Cl+gxhG+vfdjwqCrROHfjTE8WNSdGPyeOkF9tN
 Zy3mw5vQR1k4wnmhFa4ukXUoWBmfxKF86tUVHfznJERDPmj/WPs5UYrA0yGosrAVnjfw
 yxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696625069; x=1697229869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woD9iz8qCJCn50HfEi4EZ6WGpaUhKkkKeUfgQqMtd0Y=;
 b=MAVYd7/NMZG9YOvbeV35VVH+omAmr1TZq7rf1cSftju+/ZTRjM+TQjyNP6mTqQAOG9
 G7kVyFJPNsp8JDaQm4h9BCpv2jJ/pZPmMvuKnziy4E2CqbwVDP+esCMNt8T1m+SH/Y7N
 M7uEi7Do4KaC/3F2f/cgoYnM89irMu1gBqWl/AR+yjiDgCJIw30yT+CnyfeVL6upcRLU
 iRiS7dQw5TFMpd31beGExbwxqCn21hdaoTQH9x91NRjvRErxLQ27gnd+QdN9n5HkSjnX
 dpnbavfgCmCnWsa9Mgm6Je/H4fAAWKRO6C2QKVpVX66IZ3cWx9Imw/s86fhe+O1+tCZ+
 XKqw==
X-Gm-Message-State: AOJu0YwpWT7JKiMHUdytm8pZT9K7XXnf/hCVsovl/Z1smvAv4qpvlUR1
 g8TC8TiuPAa/arcxLBoE34vhmwkOZZkHRei7UqI=
X-Google-Smtp-Source: AGHT+IGEVTaNaPAqVOxnYltYLyJv4z4sIu34Hq1ExUdh5vYZ7vbyolhdZkuCDcIab0alfgaWRfAMPxaP77QLLwgL3tM=
X-Received: by 2002:a4a:ea39:0:b0:56e:9e98:2cfd with SMTP id
 y25-20020a4aea39000000b0056e9e982cfdmr10345791ood.2.1696625068806; Fri, 06
 Oct 2023 13:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-19-sjg@chromium.org>
In-Reply-To: <20230924203953.1829820-19-sjg@chromium.org>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:44:18 +0300
Message-ID: <CAGi-RULLLOD6kBKsn6=WcYWun+KNuvHYPeUcRwbMpphys8pJTg@mail.gmail.com>
Subject: Re: [PATCH 18/25] net: Depend on CONFIG_CMDLINE
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Sun, Sep 24, 2023 at 11:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> At present it isn't possible to use networking without the command line
> enabled. Add this as a condition.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  cmd/Kconfig | 1 +
>  net/Kconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5f6834b335dc..c3428d19f31d 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1687,6 +1687,7 @@ if NET
>
>  menuconfig CMD_NET
>         bool "Network commands"
> +       depends on CMDLINE
>         default y
>         imply NETDEVICES
>
> diff --git a/net/Kconfig b/net/Kconfig
> index 4215889127c9..25d494e1db46 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -4,6 +4,7 @@
>
>  menuconfig NET
>         bool "Networking support"
> +       depends on CMDLINE
>         default y
>
>  if NET
> --
> 2.42.0.515.g380fc7ccd1-goog
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
