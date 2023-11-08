Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE722C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5A687750;
	Wed,  8 Nov 2023 05:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FANf04SL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DD0D87718; Wed,  8 Nov 2023 05:26:55 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD97287735
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a84204e7aeso76305367b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vG8PRPdPBKAAwX7NB7U4qC+oyQ14Frc6bIbQ5r7+DrY=;
 b=FANf04SLBQVIdKDo7an1mWptH5G/oTGsCnRvxa6W779ZJnTw7QQuwd8EtIuonkmF44
 s5HjBluDB9rUD/2UEu9J3vaQAK1uK853XbB0P+iorBI49eNUyVHQgLVTWAzQrsxsJrMY
 uO3HFwVhDlwnrK3XueHmPQRVqPfZE5zT3ylfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vG8PRPdPBKAAwX7NB7U4qC+oyQ14Frc6bIbQ5r7+DrY=;
 b=KzNoHsHKzzVb4MYfdVcLwZkyU3Gn2jWykxeNwAhpK9tTjvQ3H8dtvIDr0+IDOav0z4
 6tr+9rL6x/NmA+Q4vwGmRy03gIFtmscFspkapHdt2Hodx39sntJlYmEdPHB6Oe0euv2z
 VTBmJvCjwH8hC0Csrpz9Hfh6mhJHzmZDG1WUmnDeTyyZ1CmuH4+CkByrxIF+JwspORs/
 H2I/6couM/K43vuxVHZ1PhbvOm6UB+tWtG/wTP4YOuXkqaM27YP42MOswPFRxmeva8vO
 Rzyocuja3SgRL9BuzGoVqxyMjFLsyJKakVBSuNCktbfdjdqlhZuGoefOF5DVpriW2MpM
 DROg==
X-Gm-Message-State: AOJu0Yx7FAxCZKezCYkHFmsca0kXFVl+UtE2IkMurhzcHZe2LKaiQsuj
 +3XS8Zq0UN9w16P8IXMr4sor86xeIpxPjsiLboQhnQ==
X-Google-Smtp-Source: AGHT+IHxhLw+XBVzsDpaUZHhWGFFTatm3tNkh3uNt3VkF6IWEVXUZ+s52umUdpvvFTAYH9TgUNKUo9M7ZmeO0Sxco1Y=
X-Received: by 2002:a0d:dc47:0:b0:5a7:aaac:2bce with SMTP id
 f68-20020a0ddc47000000b005a7aaac2bcemr648422ywe.35.1699417608090; Tue, 07 Nov
 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-2-semen.protsenko@linaro.org>
In-Reply-To: <20231107190601.17151-2-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:52 -0700
Message-ID: <CAPnjgZ3YqCaERtQ-E9b3+cTh2-js05x0jQ_GdA0-MdKrcJpN5A@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: s5p: Remove common.h inclusion
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
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

On Tue, 7 Nov 2023 at 12:06, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> It's not really needed here anymore. Remove it, as common.h is going
> away at some point.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/serial/serial_s5p.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
