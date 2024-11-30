Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C7CD735FE
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 11:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEE18945B;
	Sat, 30 Nov 2024 12:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOqF+k7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2F9895BF; Sat, 30 Nov 2024 12:04:20 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6E888F24
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53df67d6659so4240831e87.3
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 03:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732964657; x=1733569457; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZ4dbbGxeD698Cfg6l1rYbdY7nS6PwDrqHR8LBgRBh8=;
 b=bOqF+k7JSeHSdIl6vjHPByD4VY3HZcOrLqLOp0CyxRfZL/Wfrf2wD7gHrez8Cy5nkx
 tWr4tJKTx6W1hs67euChUtlxvWvu3PcYv1QVVkJX1jGpeTCfq7N0KVwLBJfAmWM9XRuv
 8GDjV6Qb7u1lIhWojVcUf5jnSZWsLih6tLk7KlE3v4kI58Jh/7Zcq9MJV+tKyljtqQb8
 k4dYXg4cmadW1UdeeqGO9iNaFf3Ui+Gs7sRJNWfFczQm/wAH+iNAmErt6TGkNk9kj0XU
 Pw0X0VTv4Gv3NFE9jPhyNGuHNKbTvxUtyXbEcdK5F+DyTnWXEc0XJV9YoHZQeT+dRrLN
 YNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732964657; x=1733569457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZ4dbbGxeD698Cfg6l1rYbdY7nS6PwDrqHR8LBgRBh8=;
 b=ogUCxvpojcnU8qNnnMn+VAUQXI/V3I0vw1S8q/zljwbtTry9ZsQPfa5/V/i63q0eAp
 hafIepxrnVDHxgMmPmMo+kWBwdX0Zg0aoUt5fxr0/Sv7xpEWvFujoNWWPlQNz0sRQcQ1
 XGiOZkXafQvsnG3/AH1L4i8fGKhvl8GyL3MWZ+R3f1F6yyIiyxaznzewnGkBVKEzahBl
 ePOEaFTecm6NKy2/7qwRFGfcorTtgkGFiZYID0siKXb0/AU3oGrM61BSD7vNXMG42LW4
 iPceMVPdsUGnvlvPDBV3ZUSrJYLCngRv8p18w7CJtMjeGH/5ooFMq3zmVWFmWUfJMLjN
 LqcA==
X-Gm-Message-State: AOJu0YxpXt/ZrWuTfnJfyPa+YkXYkw/7Gk5ffu2/O28A5lqMspgiJndh
 6NjzjZjVvkE0gSHU2tqrLFD89BpdDPNTrMZ7+jmeRHW+nBhNi90GMovErxy6Dsyt+IvoZsqe2Kv
 LWJFKgyt6Zr672ezXwYE+pq+QUxI=
X-Gm-Gg: ASbGncs9sfrapcrT0QLFzFjVve/rY+Bd+hOXQBdnxxvDDPGnaE4U+pVvgdFikd9bDki
 pJDLj6mcL9FoLUcs0Kg10qSixZrKBcIaAfmzGGQzuKaDnTRqaxObqK6R6iOssyfw=
X-Google-Smtp-Source: AGHT+IFqYK/wzM3dfDK3nR65ZQxOAv0/Ksnb3y65B8HtZot0WM3+v8VrDSHxJsKusZq3iA9x7Ra8IGoI+Xq+oAPE1zQ=
X-Received: by 2002:a05:6512:3b0a:b0:53d:e8f5:f968 with SMTP id
 2adb3069b0e04-53df00a9840mr12950554e87.5.1732964656903; Sat, 30 Nov 2024
 03:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20241129001409.218850-1-marex@denx.de>
In-Reply-To: <20241129001409.218850-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Nov 2024 08:04:05 -0300
Message-ID: <CAOMZO5Bkud4g9K6WPSRhNnqKrs-u1nXDb8CL9yErGjnC9h-sMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: imx: Make DRAM coding GPIOs available
 before relocation on Data Modul i.MX8M Mini/Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, Nov 28, 2024 at 9:14=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The DRAM configuration GPIO straps must be accessible in SPL and before
> relocation because the GPIOs are sampled both in U-Boot SPL as well as ea=
rly
> on in U-Boot proper. The already present bootph-pre-ram DT property made =
the
> GPIO controllers available in SPL, but not early on in U-Boot proper, whi=
ch
> made gpio_request_list_by_name_nodev() in board dmo_get_memcfg() fail. Ad=
d
> missing bootph-some-ram DT property to all GPIO controllers which are
> referenced in dmo,ram-coding-gpios DT property to make those GPIO
> controllers available early in U-Boot proper as well.
>
> Fixes: 8c103c33fb14 ("dm: dts: Convert driver model tags to use new schem=
a")
> Signed-off-by: Marek Vasut <marex@denx.de>

> NOTE: For v2025.01

Applied all for master, thanks.
