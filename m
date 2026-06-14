Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C21FCD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 11:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 058E583EEF;
	Sun, 14 Jun 2026 13:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hIP6KQKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516758466E; Sun, 14 Jun 2026 13:50:12 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1AF800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c19f1f3ceso3654310a12.2
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 04:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437810; cv=none;
 d=google.com; s=arc-20240605;
 b=Gq0bLnRqzBQhXvmgsGzl25H+zQ3/vDPM4nYR40qSxp9zv4EOcQYLeaXpswvCwxg3iJ
 +EdN5L5OjuIpDgHjlF8kNokJyWo9WChHiJMyzMTrUsEWCbsdlG/ElqowK3ZMx4yUM0ba
 5mg0ISk37cUb8Hbd3j1vcV3VgGaTtHN6clNRaPW/9d53QX5z506+S8dMmZ4miqryZVwZ
 6AtJIOaGsdapa66jQKFxICC7c1CZsccxxxGB0qMAKUESeWGytoyVJ1KtGnvbQ+FLUnEE
 Bia8WBVvC+JHR9da4NOLyleqZ4zW+Bk9ucRKVE7VqZJrqn0Cv2GOluHuwXMKVYYKXXMc
 0rMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xk+2DYg154PdwvlInj4whp2jMAqOB5dKLcOYfA/suqI=;
 fh=BwvpJUFKz2lIY0poKDaPH6FInvB0TyF36I1HHCUz8SE=;
 b=Xw7ZXKjgUKtyb5oBnen+itWkENqQuH6hRNDgejmobXv2/nHQkGwuwUGB1Giii5V0qc
 YUi05JylD0/ZmPcXf6CE0yRlC0Guv+xU4dF8dK23vQbfiKYKJoUNVnm7sUizib61aOdU
 Wr02rvaIMhMtJgrPzA9heVdiSuToEseevVIRfTGpu0l4bGUq2g455h892XcB/jrbCPz7
 czai349XKO/6pknF+rIAoejXOcjC2REu1filX6aCX96ZvKeuAPhSfbc4b8PdnHlVq8D2
 bbx+GS30iKvSpIUfZep5ZZcG4V+G/XdsgDgYB1rLHipNKLj6CV60b8I2I/X2CTjfG6II
 n2/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781437810; x=1782042610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xk+2DYg154PdwvlInj4whp2jMAqOB5dKLcOYfA/suqI=;
 b=hIP6KQKxtA+KSo+hrn44yDgaolIFP90uoQJ+zObpvvfNL7aceqv18yJ4vUi0slJWq2
 /taG0BYTmJnIyFzhxMKK2RBvqadRICzAAGds1IU5nYV7cecGT26jBfRHziBxcfswJWi7
 xCHmGiXNJAr2S1mmZSDybQ6bFyE72ItQmYey8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781437810; x=1782042610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xk+2DYg154PdwvlInj4whp2jMAqOB5dKLcOYfA/suqI=;
 b=iD5DyVeWFSlXGb8rmdgSWyjdXSKjRRGTS+YZMQmq+OvFrCx3yIZ4QZNIJ76gHG+jn5
 DI7Zfx7yydegpMeeSeHsiIDoSO8HZS2ZNIPz3CFp6/a+xEF2S2SwkveEt9GlRL12TN8y
 pPE4wQV40S8jr6pG7gjs7tEj3qdaUIAOHufAgI5WCqw6U3JQ95KGsP4KpDTsYE1Mdcwe
 m5esfQespIS1frfCSbWIVw6PVI+SX64WB10U6TTvqh5KXl19YtC9UZ98+MW9SRXgbegY
 v2QD0322nqmKQPYvjj87VbvgbPpAObaZ1mxtQPyRx49q7IjtYCMv75gbJ4x+yz7PwrET
 pnLA==
X-Gm-Message-State: AOJu0Yx1ehFN3PcZIAtAdPNibvKuaK39SkyXXEHRv+xAZFkiwiHMgqxh
 fJo+Bj/YpWB5BBtEcf3FAuBgdx5hX2ZMuqwavzKJ2l5MxDZEIOzYRa8Kwz3uO1scSRR1ke/U8BG
 b1s+rCAmJevdaaHaxN0iwHdc9jfMnFTIgyqzBQ2CpnZgm9tOrKP9THw==
X-Gm-Gg: Acq92OGxYEBKigkbzu80DOhyLVC5wG9JaWpwVC4N7dBzWIMSTVJlWllyDj9MX3/wf73
 0NiUlXuMb6XGWKYmuBUjzyN6vjWO2dXHctdox8LrGz4x7fvTLAqPf5asahP+R+a5NIe/CynbOsQ
 34AmAR4D6FMzZebaxMIZYq2W5QZYD4b4FBWotEM8+x7bP6xZsGZKfkWydWcvL9IaatyVfM7kEDM
 JNWgLJAucA3xMU0Cb0w9ZM/X9Hs4AwZYB1osmmWuWuDXNY8wRlU3e33S42diCyFSjsO9P9W1m46
 8GYE6A==
X-Received: by 2002:a05:6402:50d4:b0:68a:de40:26e4 with SMTP id
 4fb4d7f45d1cf-69378a5119cmr4422494a12.25.1781437809926; Sun, 14 Jun 2026
 04:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
 <20260602-fastboot-abort-keyed-v1-1-414aac5a06b8@samcday.com>
In-Reply-To: <20260602-fastboot-abort-keyed-v1-1-414aac5a06b8@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 05:49:57 -0600
X-Gm-Features: AVVi8CdS51bOC_q71dUvUm9yCq5Fu7QsFUAl-tFa9tgnRvhwZIvA4t7d8jtDc4E
Message-ID: <CAFLszTgX3x2hoFTWVy2WCuKRuZAB_T+QLAp13YTkhbM8wpkZRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: fastboot: Add keyed abort option
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On 2026-06-02T08:45:46, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> cmd: fastboot: Add keyed abort option
>
> Works the same as CONFIG_CMD_UMS_ABORT_KEYED does: any keypress will
> abort fastboot mode (rather than only ctrl-c).
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> cmd/Kconfig    | 6 ++++++
>  cmd/fastboot.c | 9 ++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)

> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> @@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const argv[],
>       while (1) {
>               if (g_dnl_detach())
>                       break;
> -             if (ctrlc())
> +             if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> +                     if (tstc()) {
> +                             getchar();
> +                             puts("\rOperation aborted.\n");
> +                             break;
> +                     }
> +             } else if (ctrlc()) {
>                       break;
> +             }

I wonder if you could create a shared function (gadget_abort_check()
?) to keep this and the code in usb_mass_storage.c in sync?

> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> @@ -103,8 +103,15 @@ static int do_fastboot_usb(int argc, char *const argv[],
> +             if (IS_ENABLED(CONFIG_CMD_FASTBOOT_ABORT_KEYED)) {
> +                     if (tstc()) {
> +                             getchar();
> +                             puts("\rOperation aborted.\n");
> +                             break;
> +                     }

Can you please update doc/android/fastboot.rst to mention the new
Kconfig and the abort behaviour. There is currently nothing in that
file about how to leave fastboot mode at all.

Regards,
Simon
