Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B53C0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 09:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5403B800CF;
	Tue,  4 Feb 2025 10:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R7b7UUFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D8480104; Tue,  4 Feb 2025 10:21:33 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9111800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 10:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5b107c4346so953152276.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 01:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738660889; x=1739265689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEj6xzWQfxJVnaTrOZf83dNzKVM2jgV0HQRU4QWNEDA=;
 b=R7b7UUFwWHgMg/2yorUr1S2y1MthunpJsRDsdkErYsJazrMNzpB/Pk4ntrKEqrDw3z
 oVu1WLCgYUvYxV3/rhITFUg0ksH301GYyeWh0uQlqImGPqJlbaOzZkNRw1Jo1OWQuyUz
 rka08Mn1ROznonXNhYxZDyYLEt2onjQ3npxspKJoYHssEsOfb60VMXBvMeJdBtDer2PV
 MiNHnXixrEcOjHbBKoAC0YeD2v7CTHr9wdy2x6YW2bSWXEzB+WPxyH9FG9o+mG/ppTb0
 HbICLFreL8EM9zNkyUJMKFoFAX9hBSd4T/wNoXS1zG7U5yfTlHuCzdihyBcXCC3cyrfU
 exTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660889; x=1739265689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEj6xzWQfxJVnaTrOZf83dNzKVM2jgV0HQRU4QWNEDA=;
 b=box2/0+JAqu5iSjG5G4H2uT2K3S5ClE8sZs+fPfOd1TF5YFuNl8EBuIwskesEfRn1W
 oeH0javqLhMeTnL64t30x+lm6epWokJhGhI1j8gSZlVxjQMkGdDikm2Oxi66zd0JUKD1
 2TlaB7Dp6GFkvFQvwsUUL/ZK+OPtyY2PX1hymM+yE7Z7S4/j8go3bPF2lMFe3EW0+cbY
 4vDM2Fa9XxneVxAlvGvMP8iqz61/TTN8mk9zZdjyVH0Ji11Q9qbbl6UciLigU/quXcP/
 L4u5sc+5WwEjYxFHwe8K4Q7eqJ93ub6sRiPY8K2xxOCSMY8bSUS0wCHXBlSLmF75pB5N
 WorQ==
X-Gm-Message-State: AOJu0Ywtvh+ANfSmbUBzNvtjhHjVt6w6frWDnF/5p60uC15fseEhfYHC
 zEGgMM5NlrCTGGw+AbK66HHhk/TDD1JfTXQuZNTc6lcAoYj6cTz4tkibzXiH9vyf5n9V+qtJfdx
 OaLRtQ7QfURZxSW0rm4xKwvhOCbMs3tJTBN6SmQ==
X-Gm-Gg: ASbGncsc+SlFIjS+/S/oBXImlasEmh4VND+/u2D80bQMWPWN6JlOsahog+WB3IY3HYc
 sMnTsp3OCLln0WjQkHJ/LBXmiO2JEcs848b8ed2thsNMaXCEJ9Zlj88e+iEzjIyZU7ogBBEwa
X-Google-Smtp-Source: AGHT+IGWaY21rBhCwkIdvW7fRal1nRuQqGy6rFZGnEXKCF/yt1VDlrm6voXzEhSzDR/1+wMK7i6Zf2U6178SSeXzWlE=
X-Received: by 2002:a05:6902:e0c:b0:e5a:c67e:6465 with SMTP id
 3f1490d57ef6-e5ac67e6539mr16296468276.38.1738660889558; Tue, 04 Feb 2025
 01:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-6-adriano.cordova@canonical.com>
In-Reply-To: <20250122170858.961359-6-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 11:20:53 +0200
X-Gm-Features: AWEUYZn03yMyDnS4F23MvC8S1m8R7BJSXabhldNzw4heOGKNAPz-6qbksrJLg7Q
Message-ID: <CAC_iWj+xx+GMQT4N3D2sdU23_sfLTi_Y0KS5p6xrpv5iZppwgw@mail.gmail.com>
Subject: Re: [PATCH 05/21] efi_loader: efi_device_path: Let network device
 paths receive the net udevice as an argument
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
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

On Wed, 22 Jan 2025 at 19:09, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Support setting the device path with efi_dp_from_eth, efi_dp_from_ipv4,
> and efi_dp_from_http to an ethernet device other than the current
> ethernet udevice. Calling eth_dp_from_eth with eth_get_dev() as the
> argument recovers the pevious functionality.

The commit meesage can be a bit clearer. i.e
"There's a need to construct device path using an ethernet device
different than the default. Add
a udevice argument to the device path generation, and keep the
callsites with eth_get_dev() to preserve existing functionality"
or something along those lines.


>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  include/efi_loader.h             | 10 +++++-----
>  lib/efi_loader/efi_bootbin.c     |  3 ++-
>  lib/efi_loader/efi_device_path.c | 21 ++++++++++++---------
>  lib/efi_loader/efi_net.c         | 24 ++++++++++++++----------
>  4 files changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 97152bbb6a..8be52e2766 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -128,9 +128,9 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
>

[...]

> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index f0cf317d4f..a399f6f593 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -949,10 +949,12 @@ efi_status_t efi_net_register(void)
>                              &netobj->net);
>         if (r != EFI_SUCCESS)
>                 goto failure_to_add_protocol;
> -       if (!net_dp)
> -               efi_net_set_dp("Net", NULL);
> -       r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
> -                            net_dp);
> +
> +       if (net_dp)
> +               r = efi_add_protocol(&netobj->header, &efi_guid_device_path,
> +                                    net_dp);
> +       else
> +               r = efi_net_set_dp("Net", NULL, eth_get_dev());

This changes what the code previously does. Don't we still want to add
the protocol for the default device?

>         if (r != EFI_SUCCESS)
>                 goto failure_to_add_protocol;
>         r = efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_guid,
> @@ -1068,17 +1070,18 @@ out_of_resources:
>   *
>   * @dev:       dev to set the device path from
>   * @server:    remote server address
> + * @udev:      net udevice
>   * Return:     status code
>   */
> -efi_status_t efi_net_set_dp(const char *dev, const char *server)
> +efi_status_t efi_net_set_dp(const char *dev, const char *server, struct udevice *udev)
>  {
>         efi_free_pool(net_dp);
>
>         net_dp = NULL;
>         if (!strcmp(dev, "Net"))
> -               net_dp = efi_dp_from_eth();
> +               net_dp = efi_dp_from_eth(udev);
>         else if (!strcmp(dev, "Http"))
> -               net_dp = efi_dp_from_http(server);
> +               net_dp = efi_dp_from_http(server, udev);
>
>         if (!net_dp)
>                 return EFI_OUT_OF_RESOURCES;
> @@ -1091,14 +1094,15 @@ efi_status_t efi_net_set_dp(const char *dev, const char *server)
>   *
>   * Produce a copy of the current device path
>   *
> - * @dp:                copy of the current device path, or NULL on error
> + * @dp:                copy of the current device path
> + * @udev:      net udevice
>   */
> -void efi_net_get_dp(struct efi_device_path **dp)
> +void efi_net_get_dp(struct efi_device_path **dp, struct udevice *udev)
>  {
>         if (!dp)
>                 return;
>         if (!net_dp)
> -               efi_net_set_dp("Net", NULL);
> +               efi_net_set_dp("Net", NULL, udev);
>         if (net_dp)
>                 *dp = efi_dp_dup(net_dp);
>  }
> --
> 2.43.0
>

Thanks
/Ilias
