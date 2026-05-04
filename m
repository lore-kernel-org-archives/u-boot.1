Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F94FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 08:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117108394E;
	Mon,  4 May 2026 10:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317FC83EF9; Mon,  4 May 2026 10:03:48 +0200 (CEST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE67780F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 10:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-57513ac61f0so360900e0c.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 01:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777881824; x=1778486624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAT9zB5p9FbqDwdoueg0TbT4P4BS3tljiC+uI4G0VKg=;
 b=ck2BhgGZEN3FaFL2rFHzTxvSmbK+sNYRFNX6YpKmoSoqzmOruq3TIzxyV+LtSsmANN
 2ExrhUGoLkgllrb9FyJTHm2LOn2JxndRj7QLOGvTLMg11JhUKfJ7vWPplX/aKWNNy42l
 W3NPR9iK3lUX2TeAt9lHcqIr+TtdE+DX3AQjFIE6Bg55W57/tkUduDAHzBBL3JLKjyUL
 yFGN24m2wAJTlL4Cdtmem5iiI/3Ul067/iKWoqur/y/BnmQS0Y7EHQBSvtZrHlPtG+4C
 AStQm19mcDkMM9GyuPcDUnDF8q2U4aBXeQw7zKX7hCvWqw+A0J6Rqc5mPgpZhyxiCUj5
 Y+Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+FoPEio8ds4WAtbis9ivtAmdpWJmFNW6qgV/EBxb1R+4VoUdtb4eyl0b3zbpSal6yZFZiIX4=@lists.denx.de
X-Gm-Message-State: AOJu0YxLWOh8KgDAFx8grop3eSRFPEpPYmlokV020wYVwgeHu8AXUZX9
 vTCGF+96VO/yRHgXExVWKpv7Bp8/bM+LG1htqWou4KVhfS53Els6zJe4rJHaXd6Y
X-Gm-Gg: AeBDieuwZJD0RvYzK1CMr7dEzzCviGkKWONBQTqKis/zEwjZ+7uSD1YmbQ75tYLRSOO
 vMUxY0Hi1gQzEt2jbnjGlsIqYBcJHbG1WdTbqo1GLgYQ5q9hjnpn0AGOYzzzbXEQV3neubrLgEU
 Ma2OT0HEeEuiqpuLnkG4uNsYF7+KxZrQ4MucFmuZPVo3msvqzdFufbTkDtI0cdrExkHjtKqIbHH
 FOziBpSKcmANM9lSZSxEOPpdtaCpaIt0UE0sO5eeIVqmLRoxaHXsxEl/JPFXAmjRiBB5mamYsFP
 AcSgIED0uNyUK1Z3nJ7JnWxoVW/Bw8oWzr6knIC8F+3buc0Jotmy3rLdUbzPAXZ8MhaP/G/sV7h
 nPwFKlov5AN7maH4t1RvAuKTxMP6DPf6KydADGoeoZgQsYy7axZiGDX58V2zJ0JdRQSJSIF/bp1
 Zt9cf4MJdT9micE32//JEXp/0p6z1KT7UxlcSxWCLFJrlaVpfTrM2f1OZd6BUNEjVQqF5llfQ=
X-Received: by 2002:a05:6122:e251:b0:56f:31e3:9445 with SMTP id
 71dfb90a1353d-5750c4927b8mr3583590e0c.0.1777881824502; 
 Mon, 04 May 2026 01:03:44 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95d0ac3217dsm1944801241.3.2026.05.04.01.03.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 01:03:43 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-95699e8e26aso848792241.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 01:03:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9VeFMar+Jwo8H8UCjWaRgQZ7hCYqrz1ZJXQnESeOLaxfOkMGyx7CMhW2ZNpoyYC/mQMVXeb1U=@lists.denx.de
X-Received: by 2002:a05:6102:5241:b0:605:5e9d:2e5e with SMTP id
 ada2fe7eead31-62d85488631mr2866305137.7.1777881823165; Mon, 04 May 2026
 01:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 May 2026 10:03:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVaVHwZahnZvJ6XBiRZnCm8CSpJNZgUksLR3TBYwvqrjw@mail.gmail.com>
X-Gm-Features: AVHnY4Ib9-EUYB2oLPmdsVZnmf-TsBNTSstq3aNLxalKKHfibQFMkEUkKtoTGbc
Message-ID: <CAMuHMdVaVHwZahnZvJ6XBiRZnCm8CSpJNZgUksLR3TBYwvqrjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] pinctrl: add support of Airoha SoCs
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, 
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Crt Mori <cmo@melexis.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
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

Hi Mihail,

On Mon, 4 May 2026 at 02:34, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
> This patch series add pin controller and gpio driver support for EN7523/
> AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
> gpio driver with Matheus Sampaio Queiroga changes.
>
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
>
> Additionally in the EN7523 case the patches removes existing gpio dts nodes
> and replaces them with pinctrl node. It should not be very dangerous, because:
>  * No official EN7523 gpio support present in U-Boot
>  * Legacy Linux EN7523 GPIO driver is mostly abandoned
>  * The same driver is planned for upstream linux/openwrt
>
> The patches were tested on EN7523/AN7581/AN7583 boards.

Thanks for your series!

> Changes v3:
>  * add non-constant field_{prep,get}() helpers

> Geert Uytterhoeven (1):
>   bitfield: Add non-constant field_{prep,get}() helpers

This is commit c1c6ab80b25c8db1 ("bitfield: Add non-constant
field_{prep,get}() helpers") in v6.19.  Which tree are you targeting
with this series?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
