Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB29E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3F283E36;
	Thu, 19 Feb 2026 14:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aHJ0Plgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A9683936; Thu, 19 Feb 2026 14:11:53 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2184883E85
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65c01595276so1223262a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506709; cv=none;
 d=google.com; s=arc-20240605;
 b=MiZhspZkRFQN+dC4b72rnI9mdZRcdeCcrnSVxm5se1JuP4qNCJzBkfZ98oOcuQtzOt
 ti4shsDce9TZKwfyWoLS3GPsQ+qTsKVtTGLbmkPymJJPbtv9JzWAwfyMa7rOFNwdvYiC
 MJdS9MyJvYrx9NcoWQCBlW0qOR+2ZzehgnBCWX4psDgYamgsSJ2TRKKFUw5fGCyNui0a
 JV8mE39l8uTAtvU7Poa2bmfCCchzXItKiNE+tTuhNpuK3J6CLl2vn6YWCdc88On2cUSL
 PUDNdDIHRVE16YawmrZCcDogXrmZi8GEsPk2gbCIGkW4IsnYnRLZP/xG1XZjGsWQTbA0
 ImSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rticnT4w6brqMGHyu/7Lud9afUmLmq+q0o92ww4xD9g=;
 fh=Z4Jq10Z+4hTZlRNIaUiK2k9TsXIVZReMqPSXVOBYLx8=;
 b=JzdY7qE2wyCGCvNEM50c8KKRYAxzBuA4WZ4sPxXX1dSJTxPpVpjBywptAWfPAMbUeb
 ZSHcORCe3z/9nBuWTDsmue/YuUglQktNkzOzwRVfnrsdcADPe920mulBrGou5HGgPveq
 h/zoEM5hw8P0rQ4IKqqPbK/sDQkksn8pjWn+pqK0+nMneUdX6W9Y5Gc4PEZkXEPoPDWJ
 H0tpLD0z18kyQJhJftuKdJ9Kx3P4o0pUzwSKjSRbV8jDIXDMMlpLgtJ3eshSi4i78Nzd
 Bo9R/z1gcfQOCc5reBb7EZ+H3XsZPPqZ4VQBvX1dWV3/HlJKehk8otXOcZBUma1RV99A
 8Qkg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506709; x=1772111509; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rticnT4w6brqMGHyu/7Lud9afUmLmq+q0o92ww4xD9g=;
 b=aHJ0Plgvqt1jbvc1bjVZf2/wKjKcw/NcfBodJ37AtwxHvDzo2QYctCyr5qULiqO7tD
 y9yIZWG05SDGJucWoWWjC6IVEh0W0o5q5ZykgJvoEHFRLopPkaVZ4QUZvkQvoOYxRhRC
 pdL9BzXtDP+1rBD+JGQA+eyZZ+9nGCkXHZWm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506709; x=1772111509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rticnT4w6brqMGHyu/7Lud9afUmLmq+q0o92ww4xD9g=;
 b=QgD0GRKLIXjvnrX6Z7cD3FxjHfnjLIn1CPa7HOjv7K/7gJEHDuvW7mquSkTGo1VwLH
 bLbDmievIaNChMETG2mnKmIwCrnM9aqiqDB1OM8QwjTi1Yc4AujAnP1iW4vk908Ikr/e
 8v/VGWrZrlkZ8IweCNJmwRdOz3jBzOFgKv0+gQ4SiKujdKyv+ijGQokuzYt6TRFtHKNt
 p+nW6IAHn/iOSmOQ6h000Go/G/Z0zdVOtCCOtydEgl2XeKMklZ0e7YqhdgjQFMQY/vgh
 mriN8DA9a8v57Gh2umXGERLY1n6pe564SS1ZBv2HvUN7dKUoUOKk1bqGPt8oVJQdrwh0
 zHTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCH1PeL7Zeve83HbvloIY++gWRvReKO/F0hSeRa1Dr1Q9a714PMk+SWSSCoA+rcWIPFkKHPOw=@lists.denx.de
X-Gm-Message-State: AOJu0YxLAqPspyeicTV+2UK0rKdTQESgl5dkHSMij1wEIReYK7uUuCP4
 d2NpsKxQ35K2AOti0X+mHTaOHCfuqIUdyjEsLhjIOWNR8SvDi3l00o5LjGs8iH07uAoCZNM8ATj
 HA44yXosYnCXuRpmYShBrLWFU8iS46y4tIvngCmYc
X-Gm-Gg: AZuq6aKnLvhK92RrLtlGn3hi8pxywot1z8eyML1UN4Zu4UD0G03Fv+HuvmKUC/rbj1n
 erAap4WBf6tO2x7Z/vqdcmHh942k8gDA1wt/MSbFJbXZGF3qU0B+qpqzRFiFR17OTl0bYPzeHxl
 w4r9uqwF3UZetGA9cbVSKviSaqVT3fft5FAYJ0GweY5NzCnRpVvSka3ezalQdkd37vKDc1+b6DJ
 rAEvZee+Dblh3SjWX73MjAJRi65tQrMAAFEF5hKKfLumCJT/JdsPHsDaq+i9dlmSOaNh1mO3arW
 cEIVKg==
X-Received: by 2002:a05:6402:42c3:b0:65c:37a2:e4a4 with SMTP id
 4fb4d7f45d1cf-65c37a2e9a3mr6306641a12.25.1771506709067; Thu, 19 Feb 2026
 05:11:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <7f98de4d33c063072fff8e20af5a31a41cab7130.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <7f98de4d33c063072fff8e20af5a31a41cab7130.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:11:34 -0700
X-Gm-Features: AaiRm51FaUivicemp_l2RKgdkOOUajuj9IiBWOEzGjnW2HiSuq_6GNhSAzNrp3U
Message-ID: <CAFLszTgD5+MT1iw5KNQJqjgC+ncUiueZicgLH+Md1_QmZroBOw@mail.gmail.com>
Subject: Re: [RFC PATCH 19/20] boot: bootmeth: openwrt: add
 openwrt_boot_script hook for bootconf
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:24, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Some boards need to probe hardware at boot time to determine the
> correct FIT configuration. For example, the BPi-R3 checks whether
> SPI-NAND or SPI-NOR is present and selects the matching FIT config
> overlay accordingly.
>
> Add an optional script hook: if the environment variable
> openwrt_boot_script is set, its content is executed as a U-Boot
> command string right before bootconf is read. This lets board
> configurations assemble the correct bootconf value dynamically:
>
>   setenv openwrt_boot_script 'if nand info; then
>     setenv bootconf $bootconf_base#$bootconf_emmc#$bootconf_nand;
>   else
>     setenv bootconf $bootconf_base#$bootconf_emmc#$bootconf_nor;
>   fi'
>
> The hook runs once per boot attempt, after the image loader is set up
> but before bootm_run() is called.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/bootmeth_openwrt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
> index e1f47b58f61..d448697fe08 100644
> --- a/boot/bootmeth_openwrt.c
> +++ b/boot/bootmeth_openwrt.c
> @@ -12,6 +12,7 @@
>  #include <bootflow.h>
>  #include <bootm.h>
>  #include <bootmeth.h>
> +#include <command.h>
>  #include <dm.h>
>  #include <env.h>
>  #include <image.h>
> @@ -113,6 +114,17 @@ static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
>         bootm_init(&bmi);
>         bmi.loader = &ldr;
>
> +       /*
> +        * Optional script hook: run the command in openwrt_boot_script
> +        * before reading bootconf. Boards use this to probe hardware
> +        * and assemble the correct FIT configuration string, e.g.:
> +        *
> +        *   setenv openwrt_boot_script 'if nand info; then ...'
> +        */
> +       conf = env_get("openwrt_boot_script");
> +       if (conf)
> +               run_command(conf, 0);
> +
>         /* FIT config selection via #conf suffix */
>         conf = env_get("bootconf");
>         if (conf) {
> --
> 2.53.0

Down the track it would be nice to build this into bootstd too, as we
are trying to avoid scripts.

Regards,
Simon
