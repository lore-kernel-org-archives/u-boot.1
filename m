Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534C6C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B769874CA;
	Sat, 18 Nov 2023 18:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MZvG4QBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E73874D0; Sat, 18 Nov 2023 18:11:54 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24AA98749E
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-daec4e4c5eeso2841935276.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTeBbheuEiSDFBAzn5zHiol1CTl/9zu4xSAEekDEGyA=;
 b=MZvG4QBBzpi5/NALqjkuXNvuPkU+H6Ys5bJ+WTCyGcTZomV2GXTqsumyK/lIj/wBpG
 kax+nbNQKqfotALzcUQaqNjxwNTq+hKV8SR/nvsrB+/ndsmI/AGwTXVIDx8RZ2hmVmgq
 +E+faytkik1vh4X5ka8LZbNi+SyRkHkhMe7Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZTeBbheuEiSDFBAzn5zHiol1CTl/9zu4xSAEekDEGyA=;
 b=VBaa4E0GUdZA+EnEYk8OE2gNMKtF3kye5nkzSc58u92XmLzja4nNDdEoGBHUZ96cEX
 hfQP6/I+KplqZjdp1PQF+NeODHQ5WG2LHymTHcENekBfOLCvd4I7WAAUr0l+5fRO8y4R
 v2UwbEuINPl5+I59c6N1LZAB13P2sAnV2Yq/zo2UA9YoaxN4G1LgqLvoyB01kNBBke67
 AjZeugbXn39p4KKjx7rUDBpTgKvdIFuuW3diFWy5aY7hqlHrYkSRnX0Vvnbfn2fG3h2a
 nk9Zisens3vWGUqKI2iDU2pXQrj2Xpn+ILnLSriNwnO8Ivx8E/g+Ed+oeXR+eiK6KksR
 04rw==
X-Gm-Message-State: AOJu0YwrI//8X8CGtKewkCz7wchmljOLf7RW/emrY/bl7zW4PPEOsEP0
 yZzJlgvhE3blpZT5hhu5IKwq/dsNNi9aSSGgWyILCg==
X-Google-Smtp-Source: AGHT+IE9cAwmGov8MJ5zgtYoHKVFMTZoLkVp0uM3EcSRvrwXMa5m+0hkWiUmJrPfKLp7ZxCwghgy5fhk4C/M49kyb1c=
X-Received: by 2002:a25:4c05:0:b0:d9b:6c9d:e6a with SMTP id
 z5-20020a254c05000000b00d9b6c9d0e6amr2565359yba.0.1700327504869; Sat, 18 Nov
 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117211506.1396929-1-macroalpha82@gmail.com>
 <20231117211506.1396929-2-macroalpha82@gmail.com>
In-Reply-To: <20231117211506.1396929-2-macroalpha82@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:04 -0700
Message-ID: <CAPnjgZ27Ut4mQXtjDYPeMhfzS2w9Jm_MKOhuRRAxJw2Z7A4OwQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] board: rockchip: Refactor panel auto-detect code
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, 
 Chris Morgan <macromorgan@hotmail.com>
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

Hi Chris,

On Fri, 17 Nov 2023 at 14:15, Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Make the inability to detect a panel using the auto detection code not
> fail the entire boot process. This means that if the panel ID cannot
> be read we don't set an environment variable for the panel, and if an
> environment variable for the panel is not set we don't attempt to
> update the compatible string. Changes to the code also ensure that
> when there are multiple compatible strings required for the panel
> we use them both, which solves some issues that will pop up soon
> for the Linux driver.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 115 +++++++++++++--------
>  1 file changed, 74 insertions(+), 41 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

This seems similar to the extension_board command in some ways.

Raspberry Pi has some vaguely similar logic.

I wonder if we could figure out a generic way of handling this?

Regards,
Simon
