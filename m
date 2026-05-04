Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31DEFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 10:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F056845E3;
	Mon,  4 May 2026 12:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABA2845E9; Mon,  4 May 2026 12:11:18 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A6C84255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 12:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=geert.uytterhoeven@gmail.com
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8eea23d01f7so537940585a.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 03:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777889475; x=1778494275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/Pon1yTVBO2BUMi/mnxbgVejCM2Eaof5CUvRZuQJwE=;
 b=ffaJEOGgiF75TiRIcPB7T8UWGRYLvVl3bK4hd3YsGyjd/NY2dopIMWvYwmx6X641Ct
 4N0V38LGlKRk6psC3E7mM8afCBGA+K3wjzJKS0A4FzWYSbs3uCRCWFn21nOab6/2oDyo
 5SiwhUUBpE+29xO925C9IW22yjqkBG56BpYAt5TRb368aUCvTQ52Pz+SbtvaYWxcv3Iu
 5BUm/OcNTXrVegcweeXiJ43Ez032cG1dgLjRxlfCV5WO1+T7yMhfkFobNkMOB4KBnZBj
 vv5/LDuygzDt4W0z7Nq/XFgtqAf7x+hZ26/VqGaA70Lz7ucTUHuqw+oxWAE5NWgUd7sz
 vPUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ88eDWCx0029UJC8r9mgXIRsoYFNDFeHe1y+PoQKLZJlRIb5GsQIbXI1FMIdihdWafWdRPQwNU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0dWexoQ39Jdt3CQtgSQQ6gPtzsNDKO3dwkLNO4UG0pp9UKXNu
 pmwcvH4XXD5puDIMgPEcilkutTXaJrjp0wAH3JVHVQVwncUXGNSYNyGUVbW4s0UE
X-Gm-Gg: AeBDieu6xs8lEdcds/hY9MJxzDsMj5Cl6KnWVkwXXfNDb6GOdzdFhPpwU+OAFfkbulB
 oxQGwUx0LnliT4rqBb49CzAMn/PpHnegwloMjuY7B+yLh03BAzNjMpJIyaR3B2GNAf+Jk2Jeb1i
 t1ai3IpsHEXjxVukrmq0zADeJtI0pc0Je4KvgsLCNBWt9zAW0AsMD6cnsxOPVHHPvrn2uunKN9Q
 dHYTUFkptlkg/vYSgCYWqaDwhYxQVcrtEyvEFXnL+qMC+GM7FchWXrnLFmsZ54nbI0Ba2tQBCGf
 1JJZie40egBMqI1jj2mOuoHqDPLzQEzcMArdsiB4es1DtUjUdDz5voXv9zYe2BylT16fzvMfPb8
 yBxJTWKlFle5kng+M5jo5Ohn4axPaWFMC9WNiv1oWRkZx1abkbwnjZBr4cptpkZday2mJCq3Had
 TygphMm5LLisc4V4kCWy8B15YYNOFYj4nq1sJCwJAFYZkooOWI7UBBYGVq+sVMazVtODsslarW1
 S4=
X-Received: by 2002:a05:620a:4512:b0:8ef:6b87:5c5b with SMTP id
 af79cd13be357-8fd15fc80edmr1442650485a.9.1777889474893; 
 Mon, 04 May 2026 03:11:14 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com.
 [209.85.222.182]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c34a0d4sm978902685a.25.2026.05.04.03.11.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 03:11:14 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso598169785a.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 03:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/ifHnWpEiWxItnfXt33mAyMu50kVIsSxPkZd9sRPOm4MKb91HpGjqASRp43Z5yL0zBttP0OLU=@lists.denx.de
X-Received: by 2002:a05:6102:605a:b0:5f5:4055:4558 with SMTP id
 ada2fe7eead31-62d84a5d671mr2941844137.2.1777889159343; Mon, 04 May 2026
 03:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
 <CAMuHMdVaVHwZahnZvJ6XBiRZnCm8CSpJNZgUksLR3TBYwvqrjw@mail.gmail.com>
 <f21e84e4-b20e-4da6-92f6-274a9835c807@iopsys.eu>
In-Reply-To: <f21e84e4-b20e-4da6-92f6-274a9835c807@iopsys.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 May 2026 12:05:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTMcXQ7voS1ogmuqnFKkagSgR1NFnWTxeYB0aXxy04dQ@mail.gmail.com>
X-Gm-Features: AVHnY4JT7qYC-063zBceP4ugaM1NHBh89JSKWLBH5JQTKfeA64ElqpHWeWo_csE
Message-ID: <CAMuHMdVTMcXQ7voS1ogmuqnFKkagSgR1NFnWTxeYB0aXxy04dQ@mail.gmail.com>
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

Hi Mikhail,

On Mon, 4 May 2026 at 11:57, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
> On 5/4/26 11:03, Geert Uytterhoeven wrote:
> > On Mon, 4 May 2026 at 02:34, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote:
> >> This patch series add pin controller and gpio driver support for EN7523/
> >> AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
> >> gpio driver with Matheus Sampaio Queiroga changes.
> >>
> >> The original Matheus Sampaio Queiroga driver can be taken from the repo:
> >>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
> >>
> >> Additionally in the EN7523 case the patches removes existing gpio dts nodes
> >> and replaces them with pinctrl node. It should not be very dangerous, because:
> >>  * No official EN7523 gpio support present in U-Boot
> >>  * Legacy Linux EN7523 GPIO driver is mostly abandoned
> >>  * The same driver is planned for upstream linux/openwrt
> >>
> >> The patches were tested on EN7523/AN7581/AN7583 boards.
> > Thanks for your series!
> >
> >> Changes v3:
> >>  * add non-constant field_{prep,get}() helpers
> >> Geert Uytterhoeven (1):
> >>   bitfield: Add non-constant field_{prep,get}() helpers
> > This is commit c1c6ab80b25c8db1 ("bitfield: Add non-constant
> > field_{prep,get}() helpers") in v6.19.  Which tree are you targeting
> > with this series?
>
> This is for master branch of U-Boot. It have the same or almost the same

Sorry for missing that.

> include/linux/bitfield.h file as in linux. Your linux commit fit
> perfectly for u-Boot as well.

Great! ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
