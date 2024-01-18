Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF63BC47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 23:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D8C87BC5;
	Fri, 19 Jan 2024 00:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AizE58BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1613487BA0; Thu, 18 Jan 2024 23:29:26 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0946D87613
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 23:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=moritz.fischer.private@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5edfcba97e3so1528277b3.2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 14:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705616962; x=1706221762; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4c0D5qQkjAjkVsid+i7XkKsP5ZAGnL29alHCKrxqgw=;
 b=AizE58BRMkxs9bRh/mNKuiixT0UdIiKbKAPLO7yrWPWbtzZz4sDEXDcFmTqUT89+3X
 P7LbPiVxY1Zdm/698/G1D+xu6/Rrnox+mu/WPfg0mwu3JY0549WG8561XdxZsgGXUukA
 o60XbMlQFcZXqY3po10Vu6ArixwYbD1v3QsVXVE6j61bYm7In5Jj6yHvn0QX/KORJzk9
 S11VrgqXvWfHc0Ym/fG4GeBRDvnBgt/0TiKFnFAYVKPGy8n2agT149AA3VHaJKoGF6NH
 6d0c3Kq6qbmn4uR8xE9NPW7FoNysCW0eir+oSpj1LvmaGrp9CgN3NRQ58B8W+yh2VreW
 iq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705616962; x=1706221762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4c0D5qQkjAjkVsid+i7XkKsP5ZAGnL29alHCKrxqgw=;
 b=SNfnRS6z0vsv+HI1q+5f66WlXPjbEgHQ0tUgif9u5lM4LSfNk1fdpxcvELdxkVdVmU
 k6pjjQc6FlenXprAV9aXhcYIYBMYRfrLnk+tEVEsJy4/VzP7Ap61BnxkCj3tlT1UsHEK
 nIsn3cZlhlW0NBkt/0oykbfKlnUHseTUUQTQZ7fBbzOXLigwZb/fz92qP95CMIyjn7D3
 jY2UiOo4wmtBomFtQ6olDBGrqaxJ1eSZ9R9RI5f+9HhaxA5I102kAbDwJ0MWHDuT0cTp
 +mq4zeuSfEoSvsu8nAYqFyNf5EI8qiANU5rilAg9H3JEE1uj5x63K1uG/NBFcSfXPdFW
 5IVA==
X-Gm-Message-State: AOJu0Ywqg2vNSZw4jIrXTypZSJWwcQQOI7r98i+OHiw3FAQ2UwZpttPE
 A+LWkHVulGwyVXLRKE5AcrHQM0bsxdJBlDCdSD3e27cfTzsVvZYu+yNMh6dv2UWIRoj8u6RDPwy
 5ZDeOsE6UzN1JpNa7RgOvEHM/vSE=
X-Google-Smtp-Source: AGHT+IHZYT/gNVbz8JuPjIW00bIM9ZvkhxT1SEWC7Mdh/eCKOhc+x+cxOB4ISoDJIXqA2KczNqu+UGFxTw0qcT7uyvA=
X-Received: by 2002:a0d:e657:0:b0:5ff:860f:21d5 with SMTP id
 p84-20020a0de657000000b005ff860f21d5mr1424629ywe.33.1705616962635; Thu, 18
 Jan 2024 14:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20240110050448.1441657-1-moritzf@google.com>
 <20240110050448.1441657-2-moritzf@google.com>
In-Reply-To: <20240110050448.1441657-2-moritzf@google.com>
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Date: Thu, 18 Jan 2024 14:29:11 -0800
Message-ID: <CAJYdmeORBWpwMFKA-C9Ybie20OgJDwUzdo+ZE7eESn7VpV_2PQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 2/2] nvme: Update nvme_scan_namespace to keep
 trying on busy
To: Moritz Fischer <moritzf@google.com>
Cc: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com, 
 u-boot@lists.denx.de, trini@konsulko.com, patrick@blueri.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 19 Jan 2024 00:04:09 +0100
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

On Tue, Jan 9, 2024 at 9:05=E2=80=AFPM Moritz Fischer <moritzf@google.com> =
wrote:
>
> A busy controller shouldn't be game-over for all controllers,
> so keep trying on hitting -EBUSY.
>
> This change brings the actual behavior of the routine in line
> with what the descriptions says.
>
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
>  drivers/nvme/nvme.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index ec45f831a3..59a139baa0 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -695,7 +695,9 @@ int nvme_scan_namespace(void)
>                 if (ret) {
>                         log_err("Failed to probe '%s': err=3D%dE\n", dev-=
>name,
>                                 ret);
> -                       return ret;
> +                       /* Bail if we ran out of memory, else keep trying=
 */
> +                       if (ret !=3D -EBUSY)
> +                               return ret;
>                 }
>         }
>
> --
> 2.43.0.472.g3155946c3a-goog
>

Gently ping on this. Is anything wrong with this series or why does it
keep falling through the cracks?

- Moritz
