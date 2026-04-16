Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26357F8D775
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5905E8423E;
	Thu, 16 Apr 2026 21:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AJzq5qrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AAA280086; Thu, 16 Apr 2026 21:36:51 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1238180086
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-671c4d08dc2so3543608a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776368206; cv=none;
 d=google.com; s=arc-20240605;
 b=Rwy0kkhbZAJBDA7QoykpWxGdLkIhXFl3SZJDtrcoSZuYx800Tg2ADzi2wk1nT9Saag
 0Jg9xR0tHhda+ApDYN/Xfbk8ZdOKVG9j97H3Yj38lQ8SncPUHRCV/fq3Dy66mVsTy9WG
 YgwfBAk/tn7y52xJ0/7wuXmfnbZo18KcWykpNQiSdJw7hTkCgl5070hUG99mytUL2AzH
 50ETJqpYLLiIHGPpXdI6CxOGVJxFfOOeLElRLM0CYw6x3o5OiOo/BZ4sfGw5sMFL49eL
 Gs32nus/lv3gD4cyh91WEHP807H++tT4SvlsjttM0chRzfgUs5OpVY/RVARuAS/+cRlw
 m7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eDjf9DdFvk9B5T9ogRXGZDki9sdmBXN2s1JfKPWixME=;
 fh=cbYquVqJfSlv5DRvNQl5DfKkRDDjpF2iJAI/mtifNns=;
 b=DYpiCL9Bf/p9CKk5TA6pHvIOVEUehNseRdH9TRQQFX3TL0GafQwAN4CZCo3dXpgd9c
 mtuqYOh40wO9b21sEKCZ6LcMbss2mJ3YtLXHgZ3Xuq3On89J73Hh7cH4ISRh2i3HMCxe
 yGIjznqlH+c8fwmoOGHMGrWIEgoN95kVR9Zar2QCX8Vssy5M5txrUgzdNAT5ztsZ6gH6
 IqsnRog6ucshvnp5Sk0/GHgcZl4LZocnaQZgbe4vRK6KijNUglqCPrXTHMrCSUglfb8X
 W+4bV4YWl29CfZWjJrrSSs7GM6n7IW4CLBFze8kA3lAzkI/ndlsJHD7+Kywo5O57tCSv
 RiNw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776368206; x=1776973006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eDjf9DdFvk9B5T9ogRXGZDki9sdmBXN2s1JfKPWixME=;
 b=AJzq5qrhgkFm/PoFQKyCnJJlBPkMCicoUDPwnaSCClzw7NzubKqgqwOuw9sVPI9nBS
 Z8X63l6YXBQsEq7lQiYdfgzbHPwHsnQbq84E4aGQoHCemtEIMiQ/FrR01RdFqAkdpPzz
 kIObjymN/sDGs7lUjV4GLb92Qwk+mvToHqT+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776368206; x=1776973006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDjf9DdFvk9B5T9ogRXGZDki9sdmBXN2s1JfKPWixME=;
 b=WJjiWiKYNU+j8lOJPjyEGcFy3nK1B3o8YYJ7E4+PfQHMH1QIGH4yLE7yfjO7M6lWno
 ILBGRyN2SCCSXkXtJupUvk+NBANGGg5Y1oJ3tRsuaQR3QkqfsfBjQvMS+01IK8JHM5vL
 wHHQ+4lgIXYPMNNfTCCiipvNkY3KQCiJYmrNZQ7JXKNOId6LjCJT7j85ZBO62fcsykSL
 KAGFXHGJTZVbTTYTSxfw2mVsODxWKbZPJDcMVpCY2jGxYuvVfp27GaRogphwYn/c17N5
 rS37RPBsTs3TcRPXi0Y/77th4frdslG0HTsXiikL3IvZmiKv8hHWhx77dAbLz0+907OV
 ob/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sI9vA4DFMUeTVa1oW3NpN6V6TlLnX36lUSOL57NH3VEO0xCrHAnJe8C3YI1LKmtnl5F1cGJo=@lists.denx.de
X-Gm-Message-State: AOJu0YxcGWGSpp7xeScJB2jRbAOswEvjFbSzgSN9VqXnwPt66sFO8spy
 eGMqC6uqnIu90y7Vsbi4GpQgtehReOiIoslWm0isA6jE3PGF0v+INRm2POfrYN/W1Ut4x+Agvpu
 /wlFLu73mhoYJ+E9MQaFchL10f8SpZbEgT6N432z+
X-Gm-Gg: AeBDievT2c08/uZbFcIOGvWt9ISK1vFTSpmSiDCN0iMBGuLjaeupHzjlWAvNlnfSjS7
 D3T1DKgCMjMAytV0lJQvIUc5QEve+VQx3YUqraFUBzmbLEo3AEGP/RstISXQEXIyWf1stEWqskA
 Pv57s3DnEfqwT8OG5iMk9SNYUmUes2ChMM45+ktxL/OEvPbCNdhh0sVbUSnjz3g1gDDmPvYNJxP
 6A3UiqREXO5POJ7j0UrIRTt4u/5/tvoDQZUiXId9ivnGmgcPKczKK1smad8qZaPGQzCxBUg462Z
 /0HC8dE5caDxijqZtV4O
X-Received: by 2002:a17:907:d490:b0:b9c:f70f:7211 with SMTP id
 a640c23a62f3a-ba3de1c0476mr41412766b.44.1776368206285; Thu, 16 Apr 2026
 12:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <5945d65ed7d795cc753d76bc503a9c2e47fb6bb3.1776302806.git.daniel@makrotopia.org>
In-Reply-To: <5945d65ed7d795cc753d76bc503a9c2e47fb6bb3.1776302806.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 07:36:33 +1200
X-Gm-Features: AQROBzCVS0MhhBPaCdn60ClPjHRxOY7sb_pDnLnAGMCBBXfwdlaQkXIkxrIDEFw
Message-ID: <CAFLszTiW=ysumFM=H580CZEeH=Z6_EqJaNmpN5wwqGD+Csp=VA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] tools: mkimage: add dm-verity Merkle-tree
 generation
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
> tools: mkimage: add dm-verity Merkle-tree generation
>
> When mkimage encounters a dm-verity subnode inside a component image
> node it now automatically invokes veritysetup(8) with --no-superblock
> to generate the Merkle hash tree, screen-scrapes the Root hash and Salt
> from the tool output, and writes the computed properties back into the
> FIT blob.
>
> The user only needs to specify algorithm, data-block-size, and
> hash-block-size in the ITS; mkimage fills in digest, salt,
> num-data-blocks, and hash-start-block.  Because --no-superblock is
> used, hash-start-block equals num-data-blocks with no off-by-one.
>
> The image data property is replaced with the expanded content (original
> data followed directly by the hash tree) so that subsequent hash and
> signature subnodes operate on the complete image.
>
> fit_image_add_verification_data() is restructured into two passes:
> dm-verity first (may grow data), then hashes and signatures.
>
> [...]

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -626,6 +629,309 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
> +     uint32_t hash_start_block;
> ...
> +     /* hash tree starts immediately after data (no superblock) */
> +     hash_start_block = hash_offset / hash_block_size;

The check for num_data_blocks overflowdoesn't protect against
hash_start_block overflow when hash-block-size < data-block-size. For
example, if data_block_size is 4096 and hash_block_size is 512,
hash_start_block can be 8x larger than num_data_blocks. Please can you
add a similar overflow check for hash_start_block?

Regards,
Simon
