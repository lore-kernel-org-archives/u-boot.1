Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50CA1061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EA48405B;
	Tue, 31 Mar 2026 01:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JeD/4WXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DA580433; Tue, 31 Mar 2026 01:00:32 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA1D840BE
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-46aa216a65aso1509242b6e.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911618; x=1775516418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+GORdvL393Ji3a4rONNysJ5L5ZFJoZttYFrir6xmsQ=;
 b=JeD/4WXpP0cp3FW4Mn2QwSDionY8N+6Cx67OkYqKZI5q8AHocfExPgLwWKg9/fvJ7i
 bs16x/cfibVM/mBWZmhnth+qMkf15/0sXgIUXZ/d9kRnZlUtfiFGNPoqm4Q/99Jh1Iaf
 pxrtYyDcvq0yA2w4+vDew7gfE9aHsNHygddGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911618; x=1775516418;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b+GORdvL393Ji3a4rONNysJ5L5ZFJoZttYFrir6xmsQ=;
 b=klUEjS1D2d09gIAgpc3xAXOHycZd85CFwNYGuQvS8Vrk+1NCvWnMnr5yRiycjEWPJk
 jZG6CDCF8YV0ydwt2Ef9Je03+cPvkcr+V1Vv3RWYzYpk+CWoiwNYrAA1kva5tRpwhMmS
 1W2prEKeDdwlv99EI2SoHpjJz5/8JXjyoA3DmAgm8rgVZlwQG6iU5mq2zCs6F5s4A5oD
 rgVav9VLNCE4/K7bGJVvdsNVGmirc4Imbisl3l7AWSDp4fOwIHdl+XK7SqYZpOR/g0Kx
 lTCq/u8WG28F0tSEDuO0oyIxlIgnJ2PLz6A6xnnYyA+VJ9zdgW8MvDx79F64UUjSrk0N
 Sjrw==
X-Gm-Message-State: AOJu0YxCf5awjj53N7EPgxl5qoBWfwl4zHnND0/Kn3/CXvj3ZaAzLq2h
 RMHslNGzNMUXw/QhbUyCzR8raj00VbWePtiec2U0CEzSnfzohmdr5Sos8/oUiC5xoFMLGpikeTr
 d38YbE8I=
X-Gm-Gg: ATEYQzxJuGN23hniv0+RtB76J1ChAvseUZU/5wh2f6cPRBi8Y/wBFrh7Ioc9FPoVD/e
 eKVyXui37iPtk40OH6PDd/4E6x0Ta3RJEofFBCkN/VFOht/5zirIUe8qlf1d4qdAXXNr3f1ogME
 lVR9OqFG47P0egd0ac4vHt2/GlfNZKCrYmkSbcEIw/J2IWbC60GrcSZ3EC+Uz8pycwocEBqKAkV
 bZDmajP90pI/lOL+tUk1EYZRQktBxw6tAKbyO/CWaKAVhnLjBPdJf/1AYwNHfhnvICv85xzA3yA
 upHZ13rmStaLJpVQLj7XZYt9GT7/BJuWUiJbaButL+qpkvvBkfAC7/H/G/dg8FRof0b1iO7YSyM
 WolohD+pKrJz/w85ysVTV1l3hy4a5GC5JJGA89RO6w6qhYY4GgidkBzYgwm0j21j4sJNx90mUZR
 +qM4XBDwl2LcxMWll6V+6+juc3W1QhRxC8xC4YSzD/gxhXmqxxJbf6iKipQNyQPSTiSzcGLwswF
 ivjhvfHxPQZ/5L7UyO4NodomWgSeWWN8a28UGLXlyHY4QQ=
X-Received: by 2002:a05:6808:6605:b0:450:d471:dce5 with SMTP id
 5614622812f47-46a8a3c804bmr6676994b6e.6.1774911618180; 
 Mon, 30 Mar 2026 16:00:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <20260317012416.4162318-1-trini@konsulko.com>
References: <20260317012416.4162318-1-trini@konsulko.com>
Subject: Re: [PATCH] usb: isp1760: Correct dependencies for USB_ISP1760
Message-Id: <177491161715.1028292.14495304569816433640.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Mar 2026 19:24:16 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for USB_ISP1760. It depends on DM && OF_CONTROL being set and
> functionally requires REGMAP. As part of fixing that issue, we change
> "tristate" to "bool" and remove mentions of module support as that's not
> a thing in U-Boot.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] usb: isp1760: Correct dependencies for USB_ISP1760
      commit: bdbe24b2a27c47e854a8ddfe89bffa0e609c24eb
-- 
Tom


