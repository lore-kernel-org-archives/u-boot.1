Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EB9C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7AB58144D;
	Tue, 28 Jul 2026 13:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wiMhPuEgiyiD; Tue, 28 Jul 2026 13:00:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6F94813F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243622;
	bh=QyhsTeJBByxffpiJ6GghlVuvPwVyOKhFj4KqjHEpwXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KizDiijkodkNxETojfM1j9slGWqQy1MqCVAIvcs8fBEtvIcsXyHF+lCKTROL0qBhh
	 tlz3THQgphKDaTgH6Fytg/dJNT2Dz6TmSz9nUldlILXbHe2BfOddJdQcz8nUpMq0jS
	 YUpFL0eoKK/3jz3VTmrF+NfeaaCh3ZtmwhMcbQDuNx1ucSIaPVRlo7NO7DxLFkQtkN
	 UJw/L+ZOujCHGXqDF5KyRoK1oihJor/66ldymhPA74JCGMlLI/7xoy1teIygtb0MES
	 sIPyOcmaGluQyc9XEyrp3mI6DCgkzYtH3P6RAuE6TmR9rkNGuiwcwKGaK+umDX3Oir
	 jsq2uLoKU+Rzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6F94813F1;
	Tue, 28 Jul 2026 13:00:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D071788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EF3680F5D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbdnrLRkuuZP for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:21:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8A06880DA1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A06880DA1
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A06880DA1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:21:21 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so5494678a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237679; cv=none;
 d=google.com; s=arc-20260327;
 b=oC4ZacGcGAHpY00zepPOEW4myeiuPODOb/+SxWFg8o1La6s1qUjTerrDbjjBn3cN9B
 w5rgYBVrFVQNJw6v9bjrYFgY1yoBg+NmauU8bAqURFvhkksp0XwwS6wFhflDNa7W8rdG
 Ujba5exFxL063x1p7l4e+6xK9m9dsq3of0WA3FF2Owm/mj9w3wPOsgoxcjCMFqjC9Yqt
 EO/nFlhZ/+3GQ0wMhLo3Q5OAIbOMUr8WOseaMO6mL4c2qJsrCm+i5HxwJa5/hnGqmY8R
 8AOKH9YJHZuIxJNoZD0fjKBRDbf4OLcaGCBw1Hjqxi40JdqySHOYSSGAEV/xXgHvRjde
 GyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QyhsTeJBByxffpiJ6GghlVuvPwVyOKhFj4KqjHEpwXE=;
 fh=b2gV51CA0Z9CHMnYUgdjUStXgHqzr/w03o9askeQ6a8=;
 b=Ee3ZQQ0ea6oyBe9KpyxXmafSXYvNRZ/z8e/emp1kXg6uPYfHM0k8XjeS7I/Kk5hvYT
 ZtXEr6557GbQNKuPnlhjE8ZalmC24RaziElW72ir1X5H7QZAkiJCG86tFyMqToeGDI3J
 aYdGeBFGmmRh2E9zrjKd3mzdedjYT2LfAb+ExCeAXWzrzudN1rh/+JLv2ZrlOX8sOYbr
 Hvlzk5/tM6a6chh8MpNE+iQijPdgd67LGVEI092tPwDsR7zMI0dY9VKxiMhhnT9BBdZK
 VVwCJJHQmi+izCKaHAIFZ+E6njuc5QWQkZKh+8Xkg6DXTF/r3x7Qfrd4n2UqGh+dpS9S
 6//g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237679; x=1785842479;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QyhsTeJBByxffpiJ6GghlVuvPwVyOKhFj4KqjHEpwXE=;
 b=BFNofkDc/g63m++q9vUjN5hiLEhHESti2fLfQwe18eOn0ywKkJUIXGALwYoWq8ws8t
 gFfF9Gr0fvgzVaZW962+Rs4+F8ZJIwx8eD3ELmTkFvfcuGNPPoNgKWMdQG5R+Htx/+jw
 hiVQ5gp6IIq7pBOmuy93cGndRNqybzLWOVnTNuNFvuwJun7PGtn/aB0FGoqhEvufEzAs
 8NqLMC6c3TXY5sqOJ5UOT43liUo454olr717Y9G6d8Iz72KB3GkscDCxKWYGsG5edWpb
 UHbFoVk2dd1LFb34qDptnWML/s7IpLrCZZj2es2egz8bVir2qarQwUHGtp52XOcyFc/q
 Gyuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOZM4qBkoOp7AJYwDBJl1som5kzN7hqec10o05ZttZYpRUzyfyD+R2G5rzxaWXHuyjwKZZHPE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw9GDRRVkvYmnNUilDkjfLczAeLysNH181C2cQFqibr8P/LGdoT
 omtgMTbLFT7Gfl6BeNPGJWltpLqEkIIDDdGnjfbRd3Zh8blhKhBHwoiVPyJERlvQd1NOeiXAGRi
 l7lwXr8X3pIk86CXiAso+W0iZ4xi6qQyV0gRstPep
X-Gm-Gg: AR+sD13kS2TgzVG9yWwvAQ6HPTFVhH2lz3nhCUbMeTZQ0hXFpCVjR92bNCcfZZBIeVt
 5B+GhfK3QZAppfsa6cIgKVa49r3eQ8/fX6AF8jKdx5IcYEIpKfbmXiaNO+TA9gDno/zoHCb3if0
 lt0Qo2Vur/Ld32Qdegu0MH5B6cns7qyZ3gvarl79VZLKVMyN4hIErPpXgkUrE9FQSENz+JfEz0D
 P6W/ne9jGEvDJzmDBNislTP+Q+YPuQ3x7kI09TmjsyMMQcJejVO5D0JFa/F
X-Received: by 2002:a05:6402:1f02:b0:69e:9755:eceb with SMTP id
 4fb4d7f45d1cf-6a0349f87e1mr913043a12.18.1785237679409; Tue, 28 Jul 2026
 04:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-5-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-5-3c41f66d4522@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:21:08 -0600
X-Gm-Features: AUfX_mw1zWql94NoJcV6lZcuSKMX-qHbHTw2YRkH3v439k0vciFT3yjbVoJ1ac4
Message-ID: <CAFLszTihm7i6c+bKEmH7NwTxn-Ogm8vvd6CknTr4Ufr-EX533w@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] boot: image: try all DM hash providers
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237679; x=1785842479;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QyhsTeJBByxffpiJ6GghlVuvPwVyOKhFj4KqjHEpwXE=;
 b=i2QnIBjIK7VKzRhaynPy/PRlS8KZLKnnl/7gb/rK8AA1aptcP+Clqgpk0myAKVvHvc
 iphklJgNiI0YsO4SH0gKKiGmKEYkjzW3P5k1N8TkkztUlgEO6GP1cWKzUDDP/h54ErUw
 mvuJOiuO7KdIaelnJuYuLSampADq2pDirF1iQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=i2QnIBjI
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-20T04:13:44, James Hilliard <james.hilliard1@gmail.com> wrote:
> boot: image: try all DM hash providers
>
> FIT hash calculation currently selects UCLASS_HASH device zero directly,
> so a provider which does not implement the requested algorithm prevents a
> later capable provider from being used. It also turns every provider error
> into the same generic FIT hash failure.
>
> Use the common hash provider-selection helper. Fall back to the configured
> software implementation only when no DM provider supports the algorithm,
> and preserve probe and digest failures from providers which accept it.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/image-fit.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
