Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35410E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 12:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B771805CD;
	Tue, 14 Jan 2025 13:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UHCOw+vs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B7380657; Tue, 14 Jan 2025 13:58:19 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE898022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 13:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so1107662466b.3
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 04:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736859496; x=1737464296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0RTAS2gSquCE97LYHJeVIXST6Z14mYox0QBajC+jqSQ=;
 b=UHCOw+vsbcht1WRFliZAZS1cfRPjDbzl2TkeFLsGRsVWeGODR5NyZCND9IEv8FaBAC
 XFTih32ZnRuNriuNrBox9ji6z9ByvMRGk3t16kbjRnOSzWoTvYxH3xOCnRJ0logIQKbb
 LbF+GZHGKPZJzvuYtD7zZb2akYsIN+RSRsejc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736859496; x=1737464296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0RTAS2gSquCE97LYHJeVIXST6Z14mYox0QBajC+jqSQ=;
 b=hhRWWGbymncPOw5TrT8SerlEi9zU3RXFhLzsvZbYAt9735e/GhfFzSLeV+WtJxoigM
 YB2yn90/SPZsQoY2ipftb5bXq4B9gjJJEUbf2kJQrxemB+B6gd3YyzuqQ0cw4rcqMR0p
 K4KGsaarauoC7ABR3WVLOw960BxF/KhWmsuDUTnPQqRuu2dQsqIBEY+8xqSMgUAeqmxo
 jI3x18+B26UFL4wL2PIKHz4GpXVYPyPuSJFOl5kR+IxS05116Omq7ZtFHXJJvXCx7UZy
 plS2gQOgLrSn9b4tf6vctLrWC0Jl9Grle8WJgKiS7fjOmwUcpbLUDkFunc9NqnH1l7ni
 QuFg==
X-Gm-Message-State: AOJu0Yzhjvg45TFdwKgc3E20ZiGQxIi//SvTYhSTk4dkw+EHtJy0ezde
 qur3SKlA9FirenP7TbxDi3HrVb48XhK3z/3tFAhUcoZchxrZTKmxgAF23p4LJU+1bIPQ6g1moiy
 3pTGpOL22nT4+hdS4hqndYU4tKY5/52E+fQFb
X-Gm-Gg: ASbGncsw/qZnf3GZOOMIXvaWTeYZIrBusLUE0xxg85G+uZCjxafEc1jPh6kf0YA7g9X
 nyB4ndN/JWKAN9qpAyySn/FVHlyTz21zf5C6g25k=
X-Google-Smtp-Source: AGHT+IFC9XDEKreW73vD6AVZsC4y/tBRxYk2E75if31TJ6WYD3myTudAuGkNVbr5s0UtzmoLC6L821AqIo2ZGmvSMew=
X-Received: by 2002:a17:907:72d6:b0:aa6:88c6:9449 with SMTP id
 a640c23a62f3a-ab2ab56abc5mr2488552966b.19.1736859495974; Tue, 14 Jan 2025
 04:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
 <20250114012226.GG3476@bill-the-cat>
In-Reply-To: <20250114012226.GG3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 05:58:04 -0700
X-Gm-Features: AbW1kvb3xo21WI-D54jE6pJ2gv5ajZ5gu2MOqNSsaHmAP-NFqa-JvK1eJyZJC24
Message-ID: <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
Subject: Re: [PATCH 01/15] vbe: Split out some VBE code into a common file
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

Hi Tom,

On Mon, 13 Jan 2025 at 18:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:
>
> > Loading a FIT is useful for other VBE methods, such as ABrec, so start
> > a new common file. Add functions for reading the version and nvdata.
> > Also add a function to get the block device.
>
> This is not a good commit message when you're also introducing
> functional changes (blk_dread -> blk_read).

Yes, I did not actually notice this size change at all, as mentioned,
as I only built for a few boards (firefly rk3399/rk3288 and a few
sandbox ones). The blk_dread() function is the old API for reading
from a block. It didn't occur to me that blk_dread() would bypass the
cache.

> Further, this functional
> change seems to introduce some other code being pulled in very
> unexpectedly, and that needs to be explained. For example,
> phycore_am62x_r5_usbdfu is another case and that has
> CONFIG_BLOCK_CACHE=y but CONFIG_SPL_BLOCK_CACHE=n, and yet the size
> growth is in full U-Boot.

This board currently uses blk_dread(), but not blk_read(), so the
addition of a blk_read() call in non-SPL causes the BLK cache to be
pulled in.

> Just moving code should not result in
> unexpected size change.

That's correct, so long as 'expected' size changes includes the normal
function-call overhead and loss of intra-module optimisation.

So, what to do here? I certainly don't want to use the old blk API.
But I can perhaps do a patch which changes VBE to use the new one,
first, so the size growth is within that commit. I looked up
BLOCK_CACHE and it is used by 90% of boards.

Another thing I could do (down the track) is a separate series to
remove blk_d...() functions.

Regards,
Simon
