Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E9D58066
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF090890CE;
	Mon, 25 Nov 2024 12:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ltynu8Cw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3881289A33; Mon, 25 Nov 2024 12:27:35 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D493088E81
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7f43259d220so3077935a12.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732534051; x=1733138851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MviT+SMEDfdEhvUf3V6p88XsNberdUuWaTe/6J45DZA=;
 b=ltynu8CwWonoMUevh6XponoiQFLQgv6lBTzN0zCc7rZREYxsInJ6g3QD1NJxI/EJ5L
 0TJ/1+1qlZWL8G1hIwQefLn5AahjIyRH8ezQ6X270flPobrFHepxJ1fwq7BH4N9+nsfm
 kQ/0jK1Lgwl90YdxHoa7/xI86KCMJ2NL/QNdPLDJspnQqzivhgEyTGVbPxhIVhkkGg+n
 s7Q+sqR6VlKuEDl6rpX9OgJHDCKrfOTtzLtoEnihXn+VkJFBOGleBdz14F2vznY0rO7X
 +sIxbea6y3U1hcXba00nmqJ7DNCcBU5WjusFRJcjy3SOgd86h7Ndj5z4v0kDiVkwqYMg
 MjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732534051; x=1733138851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MviT+SMEDfdEhvUf3V6p88XsNberdUuWaTe/6J45DZA=;
 b=Ds9HLUU4pnW2kyxZtAqKyUBF0hq2gUCC/jYI8NpwpDTvhArWUbIVGxOA6rZVkyfW07
 7PXkNXbyk9+tsTXRmfnv9cUewlSw2rfb+bjHyqZQhNCYKZZCoGhlFpGrc0RBhyS51yGG
 3gmnwmVPuLmRB1gpeSqvl33ooT5yBooJ7mU9Jf9zGIfoAqp6wYlrOz+UYShG9l77XylH
 LTEgnkN3KLxLplKBCzQ/K1ILWe110NOS6TcKRA9+L31MUHD0ISojpnTs6ALPCaARoFKF
 OBpHHKYLWmqfaXDO0iRBSJr5cxv/qKCq7Yh2zC8CsE/AT7ytv+NKCt9OXzvfibq0haFg
 ywBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzWpR25X7wqlkkoiwdTNN/jppwQwVa0OPe2ICYh2EOwTJM0OXEx8if32or+LnChi65DbVUF8g=@lists.denx.de
X-Gm-Message-State: AOJu0YwJOgFDEHo/79zKWD90apRcAi6KofXeb/vnLd2t5pVVngpfqlb2
 RPNgoxKgiH2CbiyZzFLmreO9C1QVibYNTsLLEljibUmOhdTfZK63CFn5ZaTgUxJUqLV2p6jwvbz
 lpkcGnHsJJkKmvuDGj67T6dlKm1FdDFVgm28nog==
X-Gm-Gg: ASbGncukpV7UlwpN3phrWxEiXevSM/+JUiVS1u1grbYd7TFXoBBpQyMVx3EB6gFQLOB
 6E1AAkU8cweW0p521pnifoCyH7hVWrg==
X-Google-Smtp-Source: AGHT+IGqfpeM59sktdTaApRA2JAN0JBBl2zw14VFszDR8+tJOKiAP55YMxarVQg6HyN4sGzgtbRR4GixBXOTeSNrbeU=
X-Received: by 2002:a05:6a20:7fa6:b0:1db:e8dc:4ae1 with SMTP id
 adf61e73a8af0-1e09e41f74bmr17752879637.17.1732534051391; Mon, 25 Nov 2024
 03:27:31 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241123214554.305285-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Nov 2024 13:26:55 +0200
Message-ID: <CAC_iWjJNGcuiL3ceafmOL69od91cVkX5gPyDr2kyNdiFR=QSUw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: eth_bootdev_hunt() must not try to boot
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Heinrich

On Sat, 23 Nov 2024 at 23:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> eth_bootdev_hunt() should not execute dhcp_run() as this itself would load
> a file and boot it if autostart=yes.
>
> Instead just check that there is a network device.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  net/eth_bootdev.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
> index 6ee54e3c790..b0fca6e8313 100644
> --- a/net/eth_bootdev.c
> +++ b/net/eth_bootdev.c
> @@ -64,9 +64,23 @@ static int eth_bootdev_bind(struct udevice *dev)
>         return 0;
>  }
>
> +/**
> + * eth_bootdev_hunt() - probe all network devices
> + *
> + * Network devices can also come from USB, but that is a higher
> + * priority (BOOTDEVP_5_SCAN_SLOW) than network, so it should have been
> + * enumerated already. If something like 'bootflow scan dhcp' is used,
> + * then the user will need to run 'usb start' first.
> + *
> + * @info:      info structure describing this hunter
> + * @show:      true to show information from the hunter
> + *
> + * Return:     0 if device found, -EINVAL otherwise
> + */
>  static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>  {
>         int ret;
> +       struct udevice *dev = NULL;
>
>         if (!test_eth_enabled())
>                 return 0;
> @@ -78,19 +92,11 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
>                         log_warning("Failed to init PCI (%dE)\n", ret);
>         }
>
> -       /*
> -        * Ethernet devices can also come from USB, but that is a higher
> -        * priority (BOOTDEVP_5_SCAN_SLOW) than ethernet, so it should have been
> -        * enumerated already. If something like 'bootflow scan dhcp' is used
> -        * then the user will need to run 'usb start' first.
> -        */
> -       if (IS_ENABLED(CONFIG_CMD_DHCP)) {
> -               ret = dhcp_run(0, NULL, false);
> -               if (ret)
> -                       return -EINVAL;
> -       }
> +       ret = -EINVAL;
> +       uclass_foreach_dev_probe(UCLASS_ETH, dev)
> +               ret = 0;
>
> -       return 0;
> +       return ret;

I agree with the reasoning above. Now that we have LWIP it would be a
good idea to try to boot only if ww receive and parse option 66 on
DHCP.

In any case FWIW
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  }
>
>  struct bootdev_ops eth_bootdev_ops = {
> --
> 2.45.2
>
