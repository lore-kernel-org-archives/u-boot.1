Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201A7C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 14:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F4E80717;
	Mon, 20 Jan 2025 15:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vepitZsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A2280077; Mon, 20 Jan 2025 15:00:20 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4451805C5
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 15:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4affbb7ef2dso3163981137.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737381616; x=1737986416; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H39Fo08RTaLUmLXgQbt7w65qkbtsXH4uMUpTytTjOk8=;
 b=vepitZsZAqJn9FdfQDi0IeWliYpeb6gwIGEHLDGZtzOR9ogBy7qtl9RJd1s784eNSJ
 xz8AuTJiEfZejLQPrhf6zAyo7fvDKRhUkFavjnpd2zA10d4U4HmDSumig0rHN/1pKhTQ
 CeT0r3IrWX70S+ZPoSy4yNkQD5pDK1lRGdoZ0V8lEe0HfMOqGcBrWJxr+kJq4AVHfdoo
 GpmNS7qF2/tyHXOQ/ZjVJAJMQUOLor4gKiqn8Z2wBR12JK4hB96TCxVj7zI27an3QY7z
 b5N27JRcQufpOzn5QAdJR48I36aSOGuZByqW6HfOZrsAol7pEM9m+Kp4IMMwaMlOJkc+
 PyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737381616; x=1737986416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H39Fo08RTaLUmLXgQbt7w65qkbtsXH4uMUpTytTjOk8=;
 b=aG84yThfobjpv87P1vpognV99PSj2KGHfFXMpg5ElfkJo9MYTKosw22dE6iPXnYf0r
 Qw6JsiJDJ7X5q0+u4XWSnU82HIbKSZfe18z0hE11y57z0PphMtRQPaziDC4hWPdEhgb/
 spKHM3+H72D1/zZ/EqiFbhgBwq/44FPpIA/FG4pz+vgl8HIAK1pTbmGTDYQpWd8C1o6U
 WWhHuQ5JpjLmS8GUeeyaIA4P3qpIFUx5B28jYmsDeW8tyQ0FoBgL5kDrWxlod5U+m93B
 19lU5xmaYmaUu9hTzUjI4zgYcjdTcYCf18h/QHCysIVf35rid0f3tSLs8U4wwbgQItS2
 ZAIQ==
X-Gm-Message-State: AOJu0YyVPkSM3kxj7dXrJMdwglq0v9QBm9nYFhet+rj5kjte8Wku+VfH
 FoakTKcR/nO1L1xmq4qklcxhooeseJM4OeJmC9eXDHfroPHsphMp470sbadi6XvkcAcBlKZCDeY
 mqvAVQoh8FNpYU9PvahmZKbh4lXkMQiyitDKU7A==
X-Gm-Gg: ASbGnctwaPYm4AdfsnXJcMJKcoLEgur7ULRGzx7pSAzJRg8DnnoMuYtC8KxJ6gu5SSx
 I78HqJ42sod2HgjFAjen9Fad7+sGWctXOjg6wh6ZZYFAIdHwh7SgY
X-Google-Smtp-Source: AGHT+IHAjfblsyJKuK1zxqLB8eemEuF+iAz/QLKm2XpjLCqHTEJMtyhgGj5gTvbhYivhJKLU5CawwYeitCT0GG/eq0w=
X-Received: by 2002:a05:6102:c04:b0:4b6:d108:cac0 with SMTP id
 ada2fe7eead31-4b6d108ce5dmr440873137.3.1737381616527; Mon, 20 Jan 2025
 06:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <877c6p7juk.fsf@waldekranz.com>
In-Reply-To: <877c6p7juk.fsf@waldekranz.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 20 Jan 2025 19:30:05 +0530
X-Gm-Features: AbW1kvZWW87Y7aStbQ9e9Bl0rMK0gkCxGUrTEXInyejNGbDvbWzP63tEeDOnZsI
Message-ID: <CADg8p96jX0eDKpxTuBLKS5vx=UJ=QLeBxnmfroUFYZ8VJWv1Pg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Bin Meng <bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 20 Jan 2025 at 17:55, Tobias Waldekranz <tobias@waldekranz.com> wro=
te:
>
> On m=C3=A5n, jan 20, 2025 at 16:20, Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:
> > Add information about the type of blkmap device in the blkmap
> > structure. Currently, the blkmap device is used for mapping to either
> > a memory based block device, or another block device (linear
> > mapping). Put information in the blkmap structure to identify if it is
> > associated with a memory or linear mapped device. Which can then be
> > used to take specific action based on the type of blkmap device.
>
> Is this restriction really necessary? Why should it not be possible to
> setup a block map like this:
>
>  myblkmap:
> .--------.      .-----.
> | slice0 +------> RAM |
> :--------:      '-----'     .-------.
> | slice1 +------------------> eMMC0 |
> :--------:      .-------.   '-------'
> | slice2 +------> eMMC1 |
> '........'      '-------'
>
> Linux's "device mapper", after which blkmaps are modeled, works in this
> way.  I.e. a blkmap is just a collection of slices, and it is up to each
> slice how its data is provided, meaning that the user is free to compose
> their virtual block device in whatever way they need.

The blkmap structure, the way it is designed, is pointing to the
underlying block device. How can a single blkmap then be associated
with slices of different types? Would that not contravene with the
idea of a block device associating with a blkmap?

>
> Looking at the pmem patch that follows this one, I am not able to find
> anything that would motivate restricting the functionality either.

The subsequent patch is adding the persistent memory node to the
device-tree. The pmem node that is to be added is the memory mapped
blkmap device. The logic does check for the type of the blkmap device
and then proceeds to add the pmem node only for the memory mapped
blkmaps.

-sughosh
