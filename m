Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D81C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 20:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED229409E7;
	Fri,  7 Aug 2026 20:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-4joXWPKeyg; Fri,  7 Aug 2026 20:44:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B62AA4098B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786135495;
	bh=vJwi+M80CW1AKwqXEtm4+EAUQo5nMZ2ZvChrY45Eprw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ME1Z1TxS+q5Ztp8ZOoKnYvP2Hbn34hkgLD0NjvMM+XH31EEMaJKZH/8JpCbVmMqMY
	 /TtX6mK17sBq9ndh9AX+95dCAm4izHSQaOvq9NHPfuhkvOy4RyLDmqg8B4NnfN4Rp5
	 qCCmhLFP9CkwhDPDHYRXl+vlL6b2rMS0GhiYFKZ4E9W2s9Px/zneEBFtP8PKnZFfpF
	 rLE5so/gDBnshFANnAG+CvoqoaqiFnSfnYlP4sT+5uWHPCXtoRIczIUFQrBTBw1s+7
	 nRkKXd1FELKkKvOpIb/K/PV1MFQrt/t8wKX3GZ8uWC3e7pfv8ImJuFKJNJBezKKxDS
	 53LkCpxhZoEhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B62AA4098B;
	Fri,  7 Aug 2026 20:44:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EB48259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50B3D81338
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5egPbhQT-0f for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 20:44:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8EA7B81331
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EA7B81331
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EA7B81331
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:44:53 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso5569402a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 13:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786135491; cv=none;
 d=google.com; s=arc-20260327;
 b=RQMbrKvlQMFTG2JnKRSwqYaPgf4woyT7TzvmEgoawO+RHAjqEGf6BHxQguwB3R0y8c
 ccd7JFQYTpdlbSLBr8F77RFsrYhMg3WiVUpbY0kmU7z7PkNFZS/tVOI5dijnK4HoX5C5
 XCLy1LuUJ2b4ov9yRLPwgBTUblPKgt/zvwsXI+bRPrY/BNn0clZ8hJaIwkK//OGIKgFb
 FmEyxGcVT1t7vFvxQC8yIjjkDEgfRPbirxN7qtwQbV8tdiBwqx97uy9q8JvLfJtHgk3I
 J7JmwYYnvSr9xEC4I9Ogyvq95jeGDIiIN8G0a6P6BE7geJaGfSMYjSdvz9wCQ4b7XgIY
 +Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vJwi+M80CW1AKwqXEtm4+EAUQo5nMZ2ZvChrY45Eprw=;
 fh=ijpGqnd/DhBct2Cw5aDmEJPs+G5NkZyVrRaaBz7981M=;
 b=RSxnKGzYybhh1BLXL9U0IHCLGTzScJMrrtEJENY0LRozbe5GvdrAmtJYiYlkVIUd1a
 sQ4v2V1sItdLLjzEhCKmnTYLCfL/d7GZHUjUMnXuRAc6hC2mYLJiTzizwKfng+rLtTo3
 qNU0urEpxq3BmlxGVH1sSVIJdLm0Mf+xHOl+qULwZhKWbe877xdVWS5Dye1C5BqE/SqN
 kJJetAUTqnExOFeSk+q4w25CmnZrNOCl+8p3VXuVxQVHGgHGv62pEnNHllhwXY4ENldv
 jW67fjtHhsHFI5nMYEdtwWvNiC8RUotPm46x8HB1XS/Pk6ViSw6hnXCNTZq7d/pDbRGn
 mEMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135491; x=1786740291;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vJwi+M80CW1AKwqXEtm4+EAUQo5nMZ2ZvChrY45Eprw=;
 b=Y2IwCEvCyQPD0EwQyJcdPfq3nQxQbzx2cqZ8K1ZC/wpvzcDSZJgF3akbyBxcj4p1JZ
 3Z9IcB7Bj3rssM2f7ls/v6Eu2UO7JtNHM7FOoOxcnJTJFwQqzfmMJ8DIFsM2E4AKo/+L
 q2JD+f7A/3PVU6cy3Xnv7haJfOOIjgwM+uwoTqkgMoqGyyHahQmDK/Qx4l6SNFwk6daB
 V3kgGwVi6K0czCafMYap8fRyu0fK6oK3/cj6Jab2m3xfrW3QqAR4qF1JLOyuy7v43W5a
 pjpnWlkKMJYoJ/yZ2RkUeLTE7SjkmBuV8lEjSg8TvfkbwPXdL0dtASI0j+OYj6LoowTf
 QM6g==
X-Gm-Message-State: AOJu0YzsEvOXnDRp8r3yrhr/pv/WGKRi6lZjzHuacvj9KwYH6pKXUG9Q
 2+mFyeZC9wtZT59W7YAUhQRiVHoAzVAAOHirEAYn4G1lHjpC1cwkZPT02xWM/3KOnZ48O2yC/Jj
 LNLwEEw2DaTFocnEDOv5QfBDwdk8zGJdrY8tDDOWJISYFqj8GikM=
X-Gm-Gg: AR+sD13qHg2FtfW/WMf8rHZybeuWjnMzVEm4qUn5B5RWlGpsSShtJSgPReNBcszMlL1
 GEa5IJ6EoVPjFYFDYl7hMG4r+gtf15eQQHKtrXAriOCTQgpQMs1JA/OMKDGXc4HA1xrG/yJ2B8I
 0z/zTKsEfAg0Tie92F0O8MWM6l0HpdOKxBHSO8wkS+Cmb7U4FNM3/7SqbNSz0g6yb2p6ktv8bqo
 lsQ3paj4X/3nOJlAULkvnH4AV/alQHujl/XkBkUOhA1FAf34lIm6GZfbwfZ+7jZHVp+QqpXyFg6
 ysIwGOO+6DsPe17hOLji8Vwand5LgFR9h6InPZRv9dP9pppfW7GKcFE=
X-Received: by 2002:a05:6402:43c7:b0:698:6084:db7f with SMTP id
 4fb4d7f45d1cf-6a14f138ae3mr13526031a12.10.1786135491464; Fri, 07 Aug 2026
 13:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
 <20260807-riscv-full-fit-support-v1-2-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-2-21a34f79c350@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 14:44:39 -0600
X-Gm-Features: AUfX_mztlJotK4v6bBV3XIggXWXXJCG7l8FzeIiJKs3sNo1zO84uj4LxpuZHD6E
Message-ID: <CAFLszTgw4+oG8RdGBgBrun5FafHq8kY=f7R8rQ-xMGKCqQ4RJA@mail.gmail.com>
Subject: Re: [PATCH 2/5] common: spl: ram: Add LOAD_FIT_FULL support
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786135491; x=1786740291;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vJwi+M80CW1AKwqXEtm4+EAUQo5nMZ2ZvChrY45Eprw=;
 b=K2e/tGW7uvzmI3FUatwez0nAXDd5LBOtl2j7S3riEpvR8fYa8M3cEnNctnadxeQ9kn
 8nWKdcCIHh/rSe9P/LwwHUDT+Yp5Vvajy8BjHsPYgeFrOCUGDL/PsjKQ+oQxDECJQ3aJ
 idDGh7QtZFyEX//mZoXwURuvnyte4mL4bgAqo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=K2e/tGW7
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

Hi Nikita,

On 2026-08-07T08:06:41, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> common: spl: ram: Add LOAD_FIT_FULL support
>
> Allow booting with spl_load_fit_image() if LOAD_FIT_FULL enabled.

Please can you expand the commit message to mention the motivation
from your cover letter: spl_load_simple_fit() lacks the
firmware/loadables handling needed for the RISC-V OpenSBI flow, so RAM
boot should use the full parser when it is available.

>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> common/spl/spl_ram.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> @@ -81,11 +81,15 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>               debug("Found FIT\n");
> +             if (CONFIG_IS_ENABLED(LOAD_FIT_FULL)) {
> +                     ret = spl_load_fit_image(spl_image, header);
> +             } else {

Since SPL_LOAD_FIT_FULL depends on SPL_LOAD_FIT, a board with both
enabled currently uses spl_load_simple_fit() here and this patch
silently switches it to the full path with no fallback. Note that
spl_parse_image_header() tries spl_load_fit_image() first and falls
back to other parsers if it fails. I suspect you should do the same
here, so a FIT which the full parser cannot handle still boots. None
of the six boards enabling SPL_LOAD_FIT_FULL today uses RAM/DFU boot,
so nothing regresses immediately, but the fallback would make the
precedence consistent across the two call sites. What do you think?
Either way, please mention the precedence decision in the commit
message.

Regards,
Simon
