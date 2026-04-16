Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E82F8D774
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C359B84227;
	Thu, 16 Apr 2026 21:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RjgmiFhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B735F8423F; Thu, 16 Apr 2026 21:38:44 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64C580086
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b941762394aso1058961366b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776368322; cv=none;
 d=google.com; s=arc-20240605;
 b=XNyYN7pGGd1kN9RzhL4Cui5nu5Y1Ioqj23vVTx0xjNFqCjtGmUebrh93hvosICmVKq
 sTZhoHPO9Pcv7B/b4VW4GhHRRAi+sCX1nZ/MCgUaIKNMbtKs8l9DNxYI33e0GUCXiQy3
 5q8t0YXN95StKpiHrClw+JFJMVA70GWUpZrkC4kvVKdzEnImiRt+9BBQY1s1WMUTVRcV
 BwIfMmGDzULbcqUH0qI464pfmM3U2JVgQV4oIRNrEKLLlZW237ncYRo5rSlnOxa3Fecf
 5g3mKMOEVY60JmZr9keKmiUOXeESgpxtwUdHHoy+fPLk0x4/ElOBUFAvr3sFnU+Mnho/
 zEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZI4YaW1FDpypP7++v1u1/vLNWWSe/BSsd5Qshu7EdxA=;
 fh=yvfB1FrUWTal8ddGB2brur50jnNN6dhwkVnrDw0x1us=;
 b=lPD4T6gzsHc03mlrRSrbhvyA0GgmiVRsa53OSLpF2yX9qDdMLtj8mc1dSRudAYAXtI
 L7vRrjRJizdcWLhbmqSVKU81TRA0n3SL5Em0jHZHyaBG54EgBb53rtu9IbKSJjdt7kBm
 SNlGuSq1dqsl6Lf5gxUb0ujfy4Ikdi5DZ63l3m1y8Ez65eg9f4upMoAnbDvTbFdl2Voo
 mYFEzDdqkaDRhB8IhRmIyi7jH7HfKySE0lm/jZ1CMl3MKxZ71xkRP0/wPjEGpbjpONmN
 9G4clAZWLnChZDf66x/hCmufOpTb/In+6DCTWzGfiQNp82dbKKXQnGASoGmmUoMQ9zBz
 TLcw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776368322; x=1776973122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZI4YaW1FDpypP7++v1u1/vLNWWSe/BSsd5Qshu7EdxA=;
 b=RjgmiFhSoKSX8lAXy/HBR+bm3dP7WkFqgKyvrMXRJJJpoEXbyzNoK6rr+VW29pr0+9
 FlDoNJ+qv33Osc/0Jl09fq2yQQ7AQ26dGpEklT7YOM78Ah3V7eAllXLRC7J90QHVZsxA
 3gk7Ldc4IQSJZmwsgpb43XsJQOyDM3AbqCMgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776368322; x=1776973122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI4YaW1FDpypP7++v1u1/vLNWWSe/BSsd5Qshu7EdxA=;
 b=UiAANppK0hPo+1ZBliDwzerNGrcYOs0mVlXPltZ6uoQHb2Vs1laA2SXbRCGl3HBTZN
 vjHIg3TNkVq8OWp9JsiHZI94IKxBuhI1SrhTdx2Y004XuIwayoPjF9GpHZNQtWHNnYKH
 bsepuIW80mbmQJuBCxcfXDdMBSG3JS7VBQ3X9rPVonZLoLzIu/bidVtvGp9sWQgBvIzx
 MbspjByTY1Jk/zatr67Tf9h0o/ji4gBnvAGyPWW0EdjsjS1AqtL4L7ln1AvRhty6PxZB
 BXqk4cQHTxnYya0lDLAHEfs/0TO3gWnV9Av6h6TXZSao/35VLOTaycMSHh4Qsdx0ndvt
 cJpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9T7kVJ9r0VV/sIUvZjUWCA6xcT2aIzOlN2mWnENpuMH4i0eRiZ4q25lqJENEDX+0QYV5lme/4=@lists.denx.de
X-Gm-Message-State: AOJu0YzVHECBBgv3SqyxWtoAFiEretUsk70qHGKSkuA9T2/eDCrN2rsc
 kGHYXQRrVVjc7Np7PG+FSKin93/pGIJYWybCZF/iKBfOGloDDeO7Y9kH9wCj0yBG1IGvcYz3fxc
 KeYssG6srDTRLOvP7VAWAEcq4EIbqAB0tZAeyIwI4
X-Gm-Gg: AeBDieu0YXUYO0XRNhAc1ii9e5fy7WtaIU4Yr5iNEzw9Htz8LxiDAjfCbdP0IY8mnnd
 +V+kPMpaSIcpCDB9CX6wmdQXdKA/I46ldLOIRujwvpnSMjTU91ZBdMZJ7OyeDqKeecwqoMzSQoe
 +JYZSThGOP1bLLBbJiwnI92DY5kkM3hpl9j+d+twe8iguBdhZt7XqgDH3yRaL7Qfla+KqWUHaD8
 mnu4YgD0mYS31/LDu/fCh37fS4RcR30xc8sYUYiBSYRquynZteIQY1QjCOW/v+llWhGYm86txuI
 EG5DdvMaqrAbjtiQbiSl
X-Received: by 2002:a17:906:4790:b0:b9e:98c:bd29 with SMTP id
 a640c23a62f3a-ba3dbfa8f05mr43352666b.18.1776368322107; Thu, 16 Apr 2026
 12:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <a5c18001aa5132bd8ca017c058226cc6e58c1734.1776302806.git.daniel@makrotopia.org>
In-Reply-To: <a5c18001aa5132bd8ca017c058226cc6e58c1734.1776302806.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 07:38:28 +1200
X-Gm-Features: AQROBzBaZVEFg6RBBVyMzyBOgfoUWor_mYCh5BbZvqiNRmz2h1FvWWkVk4dKXok
Message-ID: <CAFLszTiBKtnUGkd0wyXRuRE5dxe1+TgsQbRuoKingPikewUKDA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] doc: fit: add dm-verity boot parameter
 documentation
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
> doc: fit: add dm-verity boot parameter documentation
>
> Add documentation for CONFIG_FIT_VERITY which allows U-Boot to
> construct dm-mod.create= and dm-mod.waitfor= kernel command-line
> parameters from dm-verity metadata embedded in FIT filesystem
> sub-images.
>
> The new document covers the relationship between FIT loadable indices
> and the /dev/fitN block devices that the Linux uImage.FIT block driver
> creates, provides a complete .its example with a dm-verity-protected
> SquashFS root filesystem, describes all required and optional dm-verity
> subnode properties and explains how mkimage generates the verity
> metadata automatically.
>
> dm-verity is only supported for external-data FIT images (mkimage -E);
> mkimage aborts with an error if the flag is omitted.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> doc/usage/fit/dm-verity.rst | 282 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/fit/index.rst     |   1 +
>  2 files changed, 283 insertions(+)

> diff --git a/doc/usage/fit/dm-verity.rst b/doc/usage/fit/dm-verity.rst
> @@ -0,0 +1,282 @@
> +.. note::
> +
> +   `veritysetup format is invoked with --no-superblock, so no
> +   on-disk superblock is written between the data and hash regions.
> +   The Merkle hash tree is appended directly to the image data within
> +   the FIT external data section. Consequently hash-start-block
> +   equals num-data-blocks`.

This is only true when data-block-size equals hash-block-size -- in
the general case hash-start-block = data_size / hash_block_size versus
num-data-blocks = data_size / data_block_size

So can you update the comment?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
