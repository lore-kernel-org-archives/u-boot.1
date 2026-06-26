Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773ACCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 10:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A0F8496E;
	Fri, 26 Jun 2026 12:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BA+rDVc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A46A8498B; Fri, 26 Jun 2026 12:40:09 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E2F849A3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 12:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69806f118d1so1218673a12.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782470403; cv=none;
 d=google.com; s=arc-20260327;
 b=Mi+wJCAquq/lGC6mZqkcuX+xbis0P5Paj4BhNr9mu61/qx0RbWcdj6Bfv6lSYpM78k
 nHsFVgo78tajniTqrlAQvtfUN+mFAtrepSwKyeMs5ga+yF+tjh/p3I7oxJazjB22grIa
 okvjkvaA8QTktMHTK7FXvZ6F7xHMuQ7rH4NuhkWyJJCdLox0olGQz7EYfgSnZCf/AZdT
 3FG+Z/fozMO43xWKRlV3QTeNQhS3xfM1fr4ye97HlgfYmYZWo0z/TYh3dVt4AMMm40lo
 1660VnahCLXU8zlEXcfpLogbCm9fXz3LAHpOjnJqa6teDX+tgvTIGI6uZ1UoUww0Al/S
 dI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n3a3PyTwgNR+CwaubtfGSj298IvMzGkwTBsVeE/9FOU=;
 fh=nyKLZbC5pO9EO6FCB5YQSf7kr334RAPXhBSMuZ9b11E=;
 b=IfSleg1YTC+TFKsmocq/JIgDTAkTRIsT2x1X3OhAE77va60oxLLzLeiZ2LrPNl3V6K
 A2dZrijYk4ve29fV6hbCLKWQdqdVE+joV+6rrFZFz4FxmPwShuqLyC/8NYHAlJIclAJa
 QGcJQHQllOzzl16lwGjgJTL3Hhdi6jd0LM9I0DrIxkknyTk+aE++Aqt5ppJXo2GMmZrl
 fv//i/WTex7CF+iRhrwsTBreySdxZXLkGAThSXHtTHowXFCMJ3sVxFWQXAF9YzT85Fj7
 LgjUR37UNzX+jCN/C+7vuhD5cobJ0a9qmS64LeRovjgXqkprVB934eAsvFcQSoHouFiG
 Mtow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782470403; x=1783075203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n3a3PyTwgNR+CwaubtfGSj298IvMzGkwTBsVeE/9FOU=;
 b=BA+rDVc6gQtpt7s+eCx3dP3fX3VXAEga5dnz1vxcV/BiIBabnD8464x764JrIBa8Qu
 PFSPp5BryHUE5hfL7tpWb7mJ+VUlE45vplA9baGltmaD7Jqs3JZEd16uvzd+zOkc4OtP
 BkOhhroVQazhprTjtdfFrIlNhu6qHWZu8WyVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782470403; x=1783075203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n3a3PyTwgNR+CwaubtfGSj298IvMzGkwTBsVeE/9FOU=;
 b=rVirJdkWsA9VzfWy1K/FHehKU849NLB0KbfedU+Z6eqm5VewseSNBsyern06EzE3mN
 HEY5CfRoiYse3OTlZ++YDe8bZGvBvDvThOSNugvImyTI/1zj1b0qBzic6T3Crayq+y6Z
 FeiHF7p7D4u6D3pGJrPStKOpNKDKEQCK9H+WxIbQqpjJSGJllywm7KohgxAsIJJxHsnW
 JURB6K0tIiJEzW+kc7dS/F3NEFvlu6mifIBvt3O8nHeYKlnsgoFdxeXo6bjCfWw0bCCP
 siOTwZH83lxcGNEvh5eKGI8oVea1e+saTfzR/VgoGzd7NjFuYM1YiFQRPIM7DOG3IReu
 FYMg==
X-Gm-Message-State: AOJu0YzScZCTP/IYPvwO+YiRmYfDt3yBD66fqmrhV/YwgFqnpXvAQHEq
 ELrE358I8nKOSdnjzzQNvQO/5rGGqPjtdCFl4g0jctvpS6TwMTUhqVds4WnJ9W6iGxs2KMLWjgM
 LO1zrATptUauGKFcuFqDeEsVlCUXI+qqWMkTttMRl
X-Gm-Gg: AfdE7clKKH9RePb8MDdBRVDb1Wi1CZzCubj9rnVKpQ5ULZ/+Do87S0RGefin7r7jisG
 cT2OWqG7CZVuR4KmhpZxNWpLrwdt4kWuU0ps584AQxtQQeA7EwBaXSqhBAxBF+BQsPUVvQD9KmI
 qBq24ZmWcATNKiyk6bAKapUgG4uWNizehg6dIJaN2FZiqFaV3pOhOC4Piw9+CxMxxQJtyC8iUAu
 5Ugrtb6q/KETmavxOO01YNeHlo+MMBPsNmyYDi597iXjm9D7hlWdoG1+kG5rclYxnUlWXBMz7xC
 vqQc2LLS
X-Received: by 2002:a05:6402:321b:b0:695:37ba:fa00 with SMTP id
 4fb4d7f45d1cf-69810a181f1mr1939691a12.4.1782470403018; Fri, 26 Jun 2026
 03:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
 <20260606-pm8916-pon-v1-5-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-5-170c9cbe5099@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jun 2026 11:39:50 +0100
X-Gm-Features: AVVi8CeHP3mOGprAJnYkRsrN-qhdEMBcamET3cMZYIFz0OjZkIY6dSEfWgLuQ1Q
Message-ID: <CAFLszTinhT1GC6-9gL3Fo0hQjee3jQmUu3DnSHaqyXRkKHoKVg@mail.gmail.com>
Subject: Re: [PATCH 05/11] sysreset: qcom-pshold: PM8916 PON reset type support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>
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

Hi Sam,

On 2026-06-06T08:47:32, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> sysreset: qcom-pshold: PM8916 PON reset type support
>
> Before de-asserting PS_HOLD, PM8916 PMIC can be informed of what kind of
> reset should take place.
>
> This might seem a little hacky/weird, but it's a byproduct of how the DT
> nodes are structured, and the way u-boot handles sysreset.
>
> The qcom,pshold node does not belong to the PMIC hierarchy. If U-Boot's
> sysreset infra was a little more flexible, we might be able to model the
> qcom,pm8916-pon driver as UCLASS_SYSRESET in order to catch the sysreset
> type and set the appropriate bits in the PMIC, before chaining to the
> pshold driver to de-assert PS_HOLD (which actually triggers the reset
> type that was written in the previous step).
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> drivers/sysreset/sysreset_qcom-pshold.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
> @@ -13,6 +13,8 @@
>  #include <sysreset.h>
>  #include <asm/io.h>
>  #include <linux/delay.h>
> +#include <dm/device_compat.h>
> +#include 'pm8916_pon.h'

Please use #include <pm8916_pon.h> - quoted form is reserved for
headers in the same directory as the .c file.

> diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
> @@ -22,6 +24,13 @@ static int qcom_pshold_request(struct udevice *dev, enum sysreset_t type)
>  {
>       struct qcom_pshold_priv *priv = dev_get_priv(dev);
>
> +     if (CONFIG_IS_ENABLED(PM8916_PON)) {
> +             int ret = pm8916_pon_set_reboot_type(type);
> +
> +             if (ret)
> +                     dev_err(dev, "Failed to set reboot type: %d\n", ret);
> +     }

The header already provides a -ENOSYS stub when PM8916_PON is
disabled, so the CONFIG_IS_ENABLED() guard is redundant - the compiler
will elide the call. Dropping it would also stop -ENOSYS being logged
as a spurious error on platforms that don't enable the option (you'd
want to filter -ENOSYS from the error path, or just rely on the stub
returning success).

On the design point in the commit message: rather than reaching across
uclasses with a global lookup, I agree with Casey - better to make the
qcom,pm8916-pon node a UCLASS_SYSRESET driver itself, with a phandle
to the pshold node, then chain via sysreset_walk() - that avoids the
awkward coupling and the CONFIG_IS_ENABLED() gate. What do you think?

Regards,
Simon
