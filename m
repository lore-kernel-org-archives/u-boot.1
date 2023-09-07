Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA62EC8724
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 13:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79BB6867F6;
	Thu,  7 Sep 2023 15:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="g7pGp0Ry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC2B868D7; Thu,  7 Sep 2023 15:29:16 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4938657B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 15:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d7e87b4a0f2so898611276.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1694093351; x=1694698151;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABMvoca9DgO99sEZ06BE+5cmcDBwaFG0n9wQaioMsIM=;
 b=g7pGp0Rys7mj9JE/2cO3TormMwX49pQGjmyKb2NbKrRQkZhTTWGZXAbfxgXSoLg8kY
 v/O1p16X587C5FzppP8JXW5G5YLIrJxk44ps8wSSYTxPa4KH28ldUrlFO9OXwXT/W7I4
 cpl0q/QNlNYYMyUzhyEyxEZXTmUOEfB94Yzwt42JfLaNeD0GenYklAvoqIUF4pY99WzU
 +LPAQqL0sCta9v+Q/6AnvGnVVVk2MPwa76Z1rlbWRH50aZqyMjQmGb3xKEx+OpufGoS2
 OWH7FKUet8ZvAm03XtdEPFgkTMtLhmb89Xwb8KEmL4N4zMaGcrZgSiKqxSxLV0lZ/BHm
 oiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694093351; x=1694698151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABMvoca9DgO99sEZ06BE+5cmcDBwaFG0n9wQaioMsIM=;
 b=fh31VhnOLZwrAaTeSebMnmZBVGJunVLAhIqmBs6ACXYr6J3sRVsY3u3+bhptaPDpU/
 CIWCqnHBlkDStYsOnH4ELyPzZE5NbOBFwqbx21owksFauu3U+S04Zm9CO5DakDwF4EyX
 kHYDpN63LgfaWMiO2BRKlWzRKjNUiAnMtHELRUu9RcryQ9ujzVTBtd9/CkrrrCqqQu7N
 OTrPP+pS83e1bJj5bvq8AOzy3ZT93+AWN+YgWmDKrMrQaD1O+xaIqiHHDAMqAcRfbLcV
 qIhB2Bi1HQd6YPkxYZmX6WNvNptjaIOlXNdou/m64PWq9dETljrRjPTKm4zPtx9K7MVS
 pFRA==
X-Gm-Message-State: AOJu0YyP88xCfMm/2fpdukIbcZDNQISiuw15v5yvdcD/Uv2KZj4YDYPf
 voWmgqXEjSOWAuUwKke7ayu1b6fBzJikl3GhHZMWPw==
X-Google-Smtp-Source: AGHT+IFkjARPxlbWs0m99/trb89r+fETeOZcW91SlcnRXWDxvRIgtsGJCOx2coVH5ySgPteIGbZ3A5ALrb2lPDmjl3Q=
X-Received: by 2002:a25:dcf:0:b0:d36:58a6:3281 with SMTP id
 198-20020a250dcf000000b00d3658a63281mr17731975ybn.39.1694093351636; Thu, 07
 Sep 2023 06:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-3-maxim.uvarov@linaro.org>
In-Reply-To: <20230822093614.4717-3-maxim.uvarov@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Thu, 7 Sep 2023 15:29:00 +0200
Message-ID: <CAHTX3dLWgUS-MOHFMF3foyETjCbNdi7Cb+PvYia0J+ZeP8OeNw@mail.gmail.com>
Subject: Re: [PATCHv7 02/15] net/lwip: integrate lwIP library
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

=C3=BAt 22. 8. 2023 v 11:38 odes=C3=ADlatel Maxim Uvarov <maxim.uvarov@lina=
ro.org> napsal:
>
> Define Makefile and Kconfig to build lwIP inside the U-Boot. We compile
> lwIP the same as the main code, plus we can do optimization for size at
> compile time with disabling not needed debug asserts, or not used protoco=
ls.
> So we can tune lwIP configuration specially for U-Boot environments.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  net/Kconfig       |  3 +++
>  net/Makefile      |  1 +
>  net/lwip/Kconfig  | 55 +++++++++++++++++++++++++++++++++++++++
>  net/lwip/Makefile | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  net/net.c         | 20 ++++++++++++++
>  5 files changed, 145 insertions(+)
>  create mode 100644 net/lwip/Kconfig
>  create mode 100644 net/lwip/Makefile
>
> diff --git a/net/Kconfig b/net/Kconfig
> index 4215889127..34c1e43c87 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -5,9 +5,12 @@
>  menuconfig NET
>         bool "Networking support"
>         default y
> +       imply LWIP
>
>  if NET
>
> +source net/lwip/Kconfig
> +
>  config ARP_TIMEOUT
>         int "Milliseconds before trying ARP again"
>         default 5000
> diff --git a/net/Makefile b/net/Makefile
> index 3e2d061338..61930c244e 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  +=3D wol.o
>  obj-$(CONFIG_PROT_UDP) +=3D udp.o
>  obj-$(CONFIG_PROT_TCP) +=3D tcp.o
>  obj-$(CONFIG_CMD_WGET) +=3D wget.o
> +obj-$(CONFIG_LWIP) +=3D lwip/
>
>  # Disable this warning as it is triggered by:
>  # sprintf(buf, index ? "foo%d" : "foo", index)
> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> new file mode 100644
> index 0000000000..f07e26f7d9
> --- /dev/null
> +++ b/net/lwip/Kconfig
> @@ -0,0 +1,55 @@
> +menu "LWIP"
> +config LWIP
> +       bool "Support LWIP library"
> +       help
> +          Enable the lwIP library code with
> +          all dependencies (commands are implemented with lwIP
> +          library. This option is automatically enabled if CONFIG_NET=3D=
y.
> +         lwIP library (https://git.savannah.nongnu.org/git/lwip.git) pro=
vides
> +          network stack and application code for U-Boot commands.
> +         Please see doc/develop/net_lwip.rst for more details.
> +
> +menu "LWIP options"
> +
> +config LWIP_LIB_DEBUG
> +       bool "enable debug"
> +       default n
> +
> +config LWIP_LIB_NOASSERT
> +       bool "disable asserts"
> +       default y
> +       help
> +           Disabling asserts reduces binary size by 16k.
> +
> +config LWIP_LIB_TCP
> +        bool "tcp"
> +        default y

Please check tab/space in this file. Below you have the same issues.

Thanks,
Michal
