Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D777C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF01B886F0;
	Sat, 20 Jul 2024 14:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gRKNwOsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DE3886FF; Sat, 20 Jul 2024 14:36:20 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B7AB8867C
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dfef5980a69so3001128276.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478977; x=1722083777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KP/wPoCPWafGyp4tiXm4B791hD0lxnAd8GxHuNOstTA=;
 b=gRKNwOsV3+sThNb7S8VarWynJc9os/MOKAcpdST7sfJAcPCFd/hP4ParbCnwmuLu/4
 gHu2SVdHgdUrMGMiQMn7k6oJe+RZ4wJ7WEPMM4GKZEmVzdEb08llxEhOvkns+oEhZRLh
 8sha1CLbsge9SiohFP56B3HG2/i8iSG5AUkUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478977; x=1722083777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KP/wPoCPWafGyp4tiXm4B791hD0lxnAd8GxHuNOstTA=;
 b=ZSS388av0YMStQ4sY5Frmnw3dzoesgGkJN3pRNckHf9DTuytqYPjcxNK4CFUB4yTJW
 mdEqGO4osNq41HWEiKJabZIBZHfZ1Jz9XDBv4PLryEXhXRqgHWDQ1kMp6oMcHJoH7g4E
 ZYu6t+gbSSpF3bip1BKUP1vgy99Ag+5A3q8oHud0aKz1RIk5uHrQ7p3K9pTwEL1R4mMd
 T5G8QrxJa9Jou3zGK9prxZr6vljKn5LnenpkLQZK0ltzgr6Se/qnvo0tKuNgQeQ5Rlvl
 1ncjB22YV03WpIIFRa2Y2dQ7ch9AkVSVXU6VOhdIZGHKB45m7OaOSEHT+oG/Ph88Iogk
 GF5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbbActASQhOop08Vn3DxomrQ2A05lluS2jvdHmKVLZAiBvGgZIRvXJs/80O4XrOI2AtA7qHT/VCRSz54WqmtLfTpy0sA==
X-Gm-Message-State: AOJu0YxRxxH9lJHpOSkCqmNcn995zQHzGW5OdZU3XVcVoJwrl88mrvpi
 FwTttm7qZkeUxIFvS2YMfmW8IZw1yxjwMU9k5gzk5DUu0qSTIEUdItfPf+w5lMWDTPG5MjIxjOU
 tQhdzmsulxCknxiWmdfqhdF8/Hrp1oeuMfA2R
X-Google-Smtp-Source: AGHT+IF5tfjQ/2z7HrhL9cTc+ochcAeWLb1O2kKOLPWQHvnrgeZSSQZ3fCMB+heAxyAZieD2OJB4r8vVkMiUsEsmNWk=
X-Received: by 2002:a05:6902:1b89:b0:e08:5c66:7d60 with SMTP id
 3f1490d57ef6-e087b2fd751mr1395283276.12.1721478976994; Sat, 20 Jul 2024
 05:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240719091213.3757300-1-mikhail.kshevetskiy@iopsys.eu>
 <20240719091213.3757300-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240719091213.3757300-2-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:06 +0100
Message-ID: <CAFLszTjMjNyq0RXp-nmRdFoikKMbEBoQE=oD4i4OA3ezNtD0dA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] led: enable LEDST_BLINK state unconditionally
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de, 
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Christian Marangi <ansuelsmth@gmail.com>
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

On Fri, 19 Jul 2024 at 10:12, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Changes:
>  * enable LEDST_BLINK state unconditionally
>  * function led_set_period() becomes available when CONFIG_LED_BLINK
>    is disabled. This makes led code simpler.
>  * fix cmd/led.c to work properly when LEDST_BLINK present, but
>    CONFIG_LED_BLINK is disabled
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  cmd/led.c                |  8 --------
>  drivers/led/led-uclass.c | 10 +++++-----
>  include/led.h            |  2 --
>  3 files changed, 5 insertions(+), 15 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
