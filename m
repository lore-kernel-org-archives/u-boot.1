Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD77DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 07:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC0F84C85;
	Thu,  2 Jul 2026 09:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB4684C9F; Thu,  2 Jul 2026 09:59:32 +0200 (CEST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD16384C19
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5bddd789ae4so448198e0c.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782979169; x=1783583969;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXMfWL8GSbFwQT08ZsfaI5LoXIx8D1V8/8d+/6Ar7/o=;
 b=sGpPA3rqW2OvMZWhatLWa6BgrUyWpfcPIyzbNmxImfvSITK9J/nVfpa0Xlw126uakr
 H2DqSfG76NwH2sZplpS2fTW6K47caO/OeHYr0vFGqXf5uGBoENN4P4LocWK6Jrj5AgiB
 nSGUNFVLnfXfZ7I+lFSqLxsYhMF+1VathGXw9vP3aDXT7G3DlGoVLvGFqXPyKJPBdFmQ
 KtRV1gWjGeuWhke3i6ycb6acn/HTKWzfa92yhoS21PFMw3OnFQRW29GtYO8A9C8Epgiz
 IuGKbaRyHeC0aQH4gN4lQRKu6XSUBy7YNC7cCHQysRIOYqFyM4gD5kRSr9mKdnrsRA7O
 XfVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK2f1vxP8whoVKd+YjNUDVlFqPfGS0nPRlUYtxCUPusf20wN4QQXMkqMx4ODOjKCKZYhaMGOw=@lists.denx.de
X-Gm-Message-State: AOJu0YwigLJRy7K8eFDL0mTjt/aOHqwWCBeulFXpkcATfI3Ue3zCwPAM
 jdBygfDPTKkWW5xIeWky1D2dHlmvHfIUtP8aavNLuWAN76CgQgMBNCd36mg7jW+Nt9Y=
X-Gm-Gg: AfdE7cnvERIzBg5mBXLgOvDGJZ81fai0i6sGI3ZmNEAWrl7adzkFxKdXFZfRQLHzew+
 RYJqgPRzMLKqRkg8iSoOmBkLF3jI1SAQo79Ub27fvwP0wAI/01GllGpFUQzgmQ6rSbzZ/Ssr+rO
 sscslHIlUhSwru9H8gZWxftFZgg0h+dX3yqSwl9UljOBVqYOZlzzWwun7nAEFmLFQwsKmRz/MUx
 dBkT/JdrwuwmAK7ej7KofU1mNroM0RppJwwfzUR0ii7EA/uIhDbiRoE/Bd8MD2HSi9RWWRxYZJ+
 /MN3AbVnH6oT9kAlNpfYoVTiszuZo7IBpL+fuyQ8voy3wOMzzAOeRQjW0pjJphY5pEC5btunbp6
 5SnJXJjQcwxjhjgV2c1uFVv19kH0MAgNVig8CIXOwqLnTs3cSL7dRAxdm+z/5wVgmA5DE+v44fE
 GP0KSuNs71VULVyhVSX2kQMHyUYnholaQp6ha8YozcJmnUooPPeoPpgClrlJUX
X-Received: by 2002:a05:6102:950:b0:639:43f5:1fdc with SMTP id
 ada2fe7eead31-73dc04b207emr1651978137.26.1782979168446; 
 Thu, 02 Jul 2026 00:59:28 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c9ffe79sm994358137.12.2026.07.02.00.59.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 00:59:28 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-9697a691b5fso430406241.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:59:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpjZXy2sC6DfhwybeexI7o2DRYkFj53gIrWCb9LaKlMJB2jKlkIeLltyK2M2mFBtPx8l2IhgZk=@lists.denx.de
X-Received: by 2002:a05:6102:30c7:20b0:73e:c6a0:328 with SMTP id
 ada2fe7eead31-73ec6a01642mr121413137.19.1782979167851; Thu, 02 Jul 2026
 00:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Jul 2026 09:59:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOCLCywLNjcdorTTu8LW0U05EQOf80u-D1+XPp5T8RVQ@mail.gmail.com>
X-Gm-Features: AVVi8CcI6F-oT-c3LSX_qW4DFU1JZB1uwtF_lUa7iA1dmiN6paVKMST4REV7xgQ
Message-ID: <CAMuHMdVOCLCywLNjcdorTTu8LW0U05EQOf80u-D1+XPp5T8RVQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/18] pinctrl: add support of Airoha SoCs
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de, 
 Markus Gothe <markus.gothe@genexis.eu>, 
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
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

Hi Mikhail,

On Thu, 2 Jul 2026 at 07:57, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
> This patch series add pin controller and gpio driver support for EN7523/
> AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
> gpio driver with Matheus Sampaio Queiroga changes.
>
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_en7523/kernel/src/branch/airoha_en7523_pinctrl
>
> Additionally in the EN7523 case the patches removes existing gpio dts nodes
> and replaces them with pinctrl node. It should not be very dangerous, because:
>  * No official EN7523 gpio support present in U-Boot
>  * Legacy Linux EN7523 GPIO driver is mostly abandoned
>  * The same driver is planned for upstream linux/openwrt
>
> This patchset includes bitfield.h patches created for Linux kernel
> by Geert Uytterhoeven. It suits U-Boot fine. I preserve original author
> and original commit messages. It might be not a best strategy, because
> these patches refers to other linux kernel commits not added to U-Boot.
> Please note me, if there is a better way.
>
> The patches were tested on EN7523/AN7581/AN7583 boards.

> Changes v14:

Thanks for the update!

>  * Convert drivers to common field_{get,prep}() helpers. This should fix
>    build failures of many renesas boards.

Doing this after the introduction of the common macros breaks bisection.
To avoid, that you can either convert them during the addition, or
make it a two step-operation, like was done in Linux in e.g.
commits dbfe51513aae6bac ("clk: at91: pmc: #undef field_{get,prep}()
before definition") and 0f8407a1f1c795c4 ("clk: at91: Convert to common
field_{get,prep}() helpers").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
