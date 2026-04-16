Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E740F8D774
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EEF84277;
	Thu, 16 Apr 2026 21:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QIdlC6rI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA53D80086; Thu, 16 Apr 2026 21:36:56 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18A484222
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ba23b5bcbd5so291111166b.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776368211; cv=none;
 d=google.com; s=arc-20240605;
 b=lAn3QKgRq6CaJnwKfCzHmlnX8K68Q+KtpkY4ReV6C72CDSimXkDK22LZPe5qk5AQap
 825r5lE7o+D1aL1ePtCvJ4ZtwkQlGcxjquihaWxKZVvS6Heqc+hgQVqxZxuC8lga1RkC
 sA6ozNX5M9/sYttpNDxLO07vJTDFjuB2rV/UTXhrKH3LxJgHYsBTwl6j9lqwBpYAbwOf
 pkWBmaFz8+AMyV3Px/hwa25u4ZjN6fO61yRUYM5Rz6oJwpQc/YpofaDD1/O3pwACTbyN
 TCAh9iNKCZFtUg+GQIdsRidpeFkfkRYRORxIPg86Z+OQd0xvCsMUdiX/Ltp0rsSXt7fI
 AqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AfzZTDzVt+L5jeWILjk3Ph+bvsjKKs5pThvcK/YLNo4=;
 fh=Y+YA09imsVFHetIR3lhgrzGXd19XK8H0XNKJcOHXZQE=;
 b=UE+V+5WJrC5Hp7syjjHfk+VrNuCiZADQcc0MRm7BavmwW0GlEvmqSDZY6kbyt0liVF
 FERAEWWpsUaaiz45Hz3k/3K2CP1gFOyijQ2P0c7NMLmllNVdwNfBfwrj+DrcYYgjCGQX
 VxyueX1BLoSJzeLET4H4XNijfhee8EJVEK4LXPkeRWKeypU1V5Ep7c+rTEmy8ck2zf/w
 KQuu40OyWnq4rJQlJT0WwRm9g1nEsJq4d+2qszvfT1gXXRW0XRcpO90vVoGGXYZcDBfH
 HzDpqbB6i57uxBiRcEDROU4ktxI0U7/CmZtt8gTo51c88tcK5C5VmHmlAQLSQWoFj/Hu
 zerw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776368211; x=1776973011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AfzZTDzVt+L5jeWILjk3Ph+bvsjKKs5pThvcK/YLNo4=;
 b=QIdlC6rIU+ygXsYBwAikmmk0lcfHedG04GLY4b7gX/G3/D6N3vlOeJONjCv+gM2ApR
 NDAMzfQ0Qy93Sis6ggyxRI8+TnPF7Uew+3+X/OZqNPmpw1wz6BkuzkP38jI0tGVc1XNz
 9RWbhOZAi+xt062QoKReoiKkrJ3ulOqO4w9S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776368211; x=1776973011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfzZTDzVt+L5jeWILjk3Ph+bvsjKKs5pThvcK/YLNo4=;
 b=ro/skqeUYiRodWoXH6m8uoxfFA7S5PiWLX5haYyABpGiNRBvqaU/HheoLBZ3mcD6q4
 vikGt7eCAIoh/N2SUTHhBbf+GYfAuyX00hnG+PcETG6G3OyoDjoqedgBvJNG1NikOMQN
 kpSiGsJQfuzlqln09+p6Wc3NnX5QA4ydYhOx5Gia/ky5d83OlYVCyQ8uzLzu4dw5v0Rd
 GCDSnCAodtnbP8FlwQ7nBvBZK9iptV57rKUu2+MTmPO7+O/W6Cg2wJiFe0OG5yK1WYSv
 +VBAEeMJpPggRy+puZ6zmvKrlJiVQcgbgqAby1fYxE8fdb3J3uEtZ/jlwGBOV6tIYFje
 EpxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fEyVLWCwwF8j9ksWDKsnj+Tfmpr+OgEvDO5XtozD3TBdTrQyfmQ8oqy8dyz4rKqFVY0ZE2Vw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0opowKymOkm73cCbdN7j/1UV+44iqDEt1fycwSAOpkFGNpeY3
 vgBNW2oWpjHnqg5h7M5pK+D2bQLV1jNErRVm0rzYg+vvhNnc4fKHlN9I5ZlrhuuUppMVqWeBNGU
 D2xxkk6lBxlOJ7V4tSv2tf3wvjDj6SJtzj838r+RA
X-Gm-Gg: AeBDievl6gpJTGowTBRVphFb7euSuk6DTIPzgJseMzRE8bKKklmb/C+is4YoDM3Nl9Z
 dwqjDws0WCnuyQ0s8skLlSbTqf5PMIRd3qfeWKjkxGr7szlh40QERqdvAjP4AYmQ9fztHPvuPC4
 rSASHIRUhvySYUgLgRjJr7gRvwB1sfd4n3tjtKw/o74HY2ud1/EnL5a1sP5ZeA5ZSehx5ZP4hWS
 w9AtlwQgjJtLJuNnOxxeP0VbuSxO8uCfHlqCI5oy6FHPE8X5r0aPlPp0cYIeIJGibBVKpJeZwTg
 aYc3RvRTbZp28yFtFzGv
X-Received: by 2002:a17:906:9350:b0:b9c:6ef1:ed13 with SMTP id
 a640c23a62f3a-ba3dd6b2d2amr30124966b.31.1776368211084; Thu, 16 Apr 2026
 12:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <97e38b81f2e8f54ec819940d360849e4cf61b875.1776302806.git.daniel@makrotopia.org>
In-Reply-To: <97e38b81f2e8f54ec819940d360849e4cf61b875.1776302806.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 07:36:37 +1200
X-Gm-Features: AQROBzDvJUtYvv4Vy0eakB8Ie3RzsuwRZwuW9C-hVNjhZpcmekfFlRVHeywIhSs
Message-ID: <CAFLszTgazuTSYbidfn7Q1gEiE1RG2YVkj2Vz9L6fN49QE0bdUA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] test: boot: add runtime unit test for
 fit_verity_build_cmdline()
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
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

On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> test: boot: add runtime unit test for fit_verity_build_cmdline()
>
> Add test/boot/fit_verity.c with four tests that construct FIT blobs
> in memory and exercise fit_verity_build_cmdline().
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> test/boot/Makefile     |   1 +
>  test/boot/fit_verity.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c          |   2 +
>  3 files changed, 305 insertions(+)

> diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
> @@ -0,0 +1,302 @@
> +             ret = fdt_setprop_string(buf, verity_node, "algo", "sha256");
> +             val = cpu_to_fdt32(4096);
> +             ret = fdt_setprop(buf, verity_node, "data-block-size",

Please can you use the FIT_VERITY_*_PROP constants from
include/image.h instead of literal strings? See test/image/spl_load.c
for an example.

Regards,
Simon
