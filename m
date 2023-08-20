Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F40BEE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F278F867CF;
	Sun, 20 Aug 2023 19:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FoFWQBwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2EBB8690B; Sun, 20 Aug 2023 19:49:03 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471B785F9F
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe11652b64so3798941e87.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692553740; x=1693158540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qzlhzHl68ZrUgqfXcEdEUCMcy8yYgnKPUUCA+djpLaY=;
 b=FoFWQBwWQevUPI6RbwuJJY4Q9X/yiAY94uy+s2DdItq2rs+QV2BHCtNRUP/3E7a2kE
 SqFy1DVqX8BafSt8HuYl5StggabVHtVJ8cfKWfd49402WF09W8TroiUfyPY1NTvEqRcc
 dQuegceLlmEDHnJWNKi53vGyFQpFGWVQ8EA+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692553740; x=1693158540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzlhzHl68ZrUgqfXcEdEUCMcy8yYgnKPUUCA+djpLaY=;
 b=jp3WA2iH9fb0yO3qD29z8sviWOZsUgaDSiGK8NI14DV+U/zjKF0FBT8ysQQ3uOj6IX
 wZhbeC9LS328a9uCOosxA7BBNSE294/bYY5FdYyaKela18uQLlnskzhiT3BbC9+C9dNa
 J1JMhbaXS/kw1/gJ4KFR15hPbFu66DTEvbjGUqlRDNa/+N/zyAcCL8vg+0kcjK06DYgW
 GzoBfpFDEY8m2cATLK8UQKsvXGLEQ4KrfgxSI00ZgioSpIVYbrPlCKfO9c/Bedx/L3vw
 ChjT1leHaCLn2stG9pDn1E90lLRC175+MMe18WifljvfmzhlyLSKxQo8o1fmVCCocumt
 AFCg==
X-Gm-Message-State: AOJu0YwezYtjR7EcBQ9gxNm8jSssRbwoK+00q/yw4oXZzgRdZWq/l7rl
 j73EshCZVshOFkEbwSSDxbOUIjORkSsqSPF9R8/bUg==
X-Google-Smtp-Source: AGHT+IFUy+n/2JAVVPEVBdVPDd/bIp7S4A4H4rGNykauhI8+NvcQ6v24iHa+IzgMcJYxmMx3JIvJRNjgfO50KT/59vo=
X-Received: by 2002:a05:6512:4026:b0:4f9:570c:7b28 with SMTP id
 br38-20020a056512402600b004f9570c7b28mr3619448lfb.32.1692553740289; Sun, 20
 Aug 2023 10:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-2-marex@denx.de>
In-Reply-To: <20230819142407.49632-2-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 20 Aug 2023 11:48:45 -0600
Message-ID: <CAPnjgZ0rT0ak09gYfVW07SH3WH-MrHR5xnuUFtKAFGZdawWtCQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] usb: sandbox: Add DM_USB_GADGET support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Angus Ainslie <angus@akkea.ca>, 
 Dmitrii Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Stefan Roese <sr@denx.de>, kernel@puri.sm
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

On Sat, 19 Aug 2023 at 08:24, Marek Vasut <marex@denx.de> wrote:
>
> Remove local usb_gadget_register_driver()/usb_gadget_unregister_driver()
> implementation which is implemented in udc-core.c instead if DM_USB_GADGET
> is enabled. Add no-op dm_usb_gadget_handle_interrupts() implementation.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
>  drivers/usb/host/usb-sandbox.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
