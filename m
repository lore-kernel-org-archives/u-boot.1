Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B6AC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1345784C18;
	Thu,  9 Jul 2026 21:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWcWnGUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3509C84C17; Thu,  9 Jul 2026 21:14:38 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5798C84B3B
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so246838a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624476; cv=none;
 d=google.com; s=arc-20260327;
 b=eFa7RqdAGStC8xCh7n04FTvOwT5GsJclO+6+c5kkHVTV+OoIBJRw8V1UyyT4s6k2pw
 CrAGpOtkg6K/kqHfrCLnSAHXxKjr4sBZpUQC7Omp7v9qC9YDuOq43XQEee1OLYqd2kW6
 Y5H9mZXp5TZn//Dv4y8CBc39W2vD+O+57tIGCly0ZCe1ICEMt9HgUYYMGM8mSByRVMMh
 kKorpV8YdZCIavFazl9W5WEsBkyOqR50LFuDBXZ761CzShgshc1jRgN+DDS0BBihBW+V
 SCegIvE2m/qdA+9e+VgBinigv1J3lTboRPnUuWSp61G9nLO9a6SsQqy7dunH/TzlZpXE
 10Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eMrb29CELMo3ifRaX0aS4FtyWCz5PNtyYj1eCEV90aM=;
 fh=cX2a5uS3m9+hU+YaZez7ihgAHbtevX6/NcttqBcYz7Q=;
 b=fvua0eiBtoI+ZIYw36DLgl/gERazh86FFl98Ui9bdKkYazWYMuvRLubCW1Cl2BrQzO
 wRreT4XCTtBmeDXb2bddRp4Fwq35xOL+XfpQcORGClGcrYUuMbAkneLcuL5U+79BaBHe
 iGVMQwQ+njAneuv8R5ZwlID8DW2LM2MrrHAr//ZsPkZtyvBJkh2ZifjtqHs139bDMqGS
 FZvfQiHp96sEm6guF1Ml0qJTdgZyftN1VG5K2L3aFk5rpIn/+O9AH8Td5XZ0o5pdUtLO
 hXDLDUQZiMOfr6TCN//kmn976bY8SEstl/FLXOnOgb0CpuGtQ1KGUtwNwWdM6kEOfIKB
 2IBA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624476; x=1784229276; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eMrb29CELMo3ifRaX0aS4FtyWCz5PNtyYj1eCEV90aM=;
 b=cWcWnGUrw70WgYCj9kyOeruil9CA+Wp8eqh+wim/BRnTjAWQj3k/6ZouflEEbsSCs0
 q9awi1zHMxHmLmNOPaaW5XOmBKx6yOtU8FI2XkKVzQqHuNdzO2XWySjKHfZ2is7X6UhM
 EZ9aZRSQXhJTZ65m6DiVt4KbbVQfUzsTkK8u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624476; x=1784229276;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eMrb29CELMo3ifRaX0aS4FtyWCz5PNtyYj1eCEV90aM=;
 b=lB2r/OHuKTCNZIYrB/ehA1QhbXUmMvUwJkKxVvAqqMwm5j8udaxXkILA3eVECbXCqf
 RNVH7R9zK9FfaUkLl5P1Ww23L5cosPWs52nTOfco/xr4Of+JxLzdPkcqo70YyhQMZ9Ih
 vKSKEI2et1iKshGJV3rh/T8mdfV9M3yoUxzqoES/DeiRJMzEQ/+xaHockYOn4RBMqnBM
 Yk+X8+DfFT4Y06xEC8S2Hbun6qja+yW3YEhPrLTiU5oNB35RMJGaUGEF8KRnGGci2CBK
 BqWuDO8qI7hbEgAGZJci9LJdNwMxFEUIqHvgDfJPYiM3HHarCT7cVkO7bdFo3nkSWDXV
 201g==
X-Gm-Message-State: AOJu0Yyw+/oz6dUUShtmcm9i/LEUnXFpzFQ1pPIgx1eMzzJ6mBnBK2e/
 MIZPxtRvfrsIgt8S4zD8mrQYl0VvLWxN7gQAQF9leA5pXGz8MT/maz+KYq3MX5AyUoUdKT/6qG6
 1qCBV5u/iGf36UJ2k9edQEJMcjNzQbUPqFnLs/Zu2
X-Gm-Gg: AfdE7cnknzmF+wQYcKQhoTVo499RsHXE/4Cz3bd0D3FrKR9SomEPKYZERuAWPrkJ9tL
 vsnKY8AQMfvoCHx11gGIGaI6xTXsLcZNeXHSkF8AOsFnO19zUVWp4tW/MqmlNDxd2fgbzJEdxxZ
 nSH1JgMmlUDbiT8pWyJnNrbxbfax8SjDRUjOavF169XK26TYXNxuyEihkURyQ7RYNkJV2hcdxvj
 XkIyxj/3eK1/f/9PwfqkqxSpFVYpLPCAyA5JIC5YVq905TCg6L2c2ssdbbQa07xkxkVdyo=
X-Received: by 2002:a05:6402:eaa:b0:698:aa8c:c15f with SMTP id
 4fb4d7f45d1cf-69ab4497d22mr3319125a12.22.1783624475897; Thu, 09 Jul 2026
 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
 <20260703-dm-core-v1-4-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-4-076d395bded4@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:14:22 -0600
X-Gm-Features: AUfX_mygZcgNyhnSXLmC3lqjy0V17s0oYDKY3CpafAh_YkpE3hvLUFm8quIi41I
Message-ID: <CAFLszTg3f3q0D6__xQs5n=poG=yTGSr7X9ZfT-1DAki9eMMiFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] dm: core: free old name in device_set_name to prevent
 leak
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-07-03T09:11:23, Peng Fan <peng.fan@oss.nxp.com> wrote:
> dm: core: free old name in device_set_name to prevent leak
>
> If device_set_name is called on a device that already has
> DM_FLAG_NAME_ALLOCED set, the old dynamically-allocated name is leaked.
> Free it before assigning the new name.
>
> See: drivers/net/mdio_gpio.c:mdio_gpio_bind(). There is
> device_set_name() here, however dm_mdio_post_bind() will also call
> device_set_name() if 'device-name' exists.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/core/device.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
