Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC69E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4EA805CD;
	Tue, 14 Jan 2025 14:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XDA0VkB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810DB80657; Tue, 14 Jan 2025 14:26:48 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1258022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so788271266b.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736861206; x=1737466006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K9UxJmiifI7EB9VyJ5T26/XMo32vWZzFf/EO8PMUTvg=;
 b=XDA0VkB78sAHplOldWGgB4WmZn6BzCFIzLMizpnzLYCCA0jwYJ3EvNq1FOR6C0XVV8
 GwZKmZDBHOoAU0gom1F1OsSQr6Z5uBrXrpcRNLA20G+O4m7YKmfUlLsBqg1UzHtjjvyx
 Z5+ySE8cEUTr8RN2PapP/U/Ktd08LIH8YnVeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736861206; x=1737466006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K9UxJmiifI7EB9VyJ5T26/XMo32vWZzFf/EO8PMUTvg=;
 b=ws1E4TSETNRffCnz6KeWi4QKoJDO+B+Of7vQxUABQkSZLdjijrF7NrGDnliemjtSdD
 DD7WD0BLL6tMcVx6vhZxVbzlwCw+J/qGi6KeMKGB41xkahRu4fosNVrEgKs9mjgQMb7H
 rVNFg3/oUG81mNI6Fu+0zF+T6lhLRkAK1vyQ02BFI83E8qfX5isdBBYUN5rXqlaR8qPt
 61/S5s9dH3D6At0rAU0c1zmKlRosLxXKPqu1l0VTOqSBldu3duDdhPVICTMKPuL5DA82
 kzKXhGQSZQUDsflVSEx2/2UJtp9roYYz2E1OsYk5HKXGtNax9qS0PulbXa7yPlWFK++4
 Slww==
X-Gm-Message-State: AOJu0YwK1fVdWLALsxO1SuPl1JvqjT+tOQfoMiuz4ikh/atKxlZf3rQB
 vsAZDChbq/XPMctRQRjArgTGg2w499gzNVPNbDyQCOY47qYHd3Y43c4vd2aUgAfemRgDI4E4fn0
 tSX+LJmG4/2VgCYQSYdfHpjIPlnNtoreDw2A2
X-Gm-Gg: ASbGnctFN22LIerGU/4oYsYyFIJm2NC32QOB7Qjf4ElBF4H7eyZet9Z1ynHTWqEh0ue
 zi0bhUua/RVhLHUJlrjAD7xtcpzGGHTQaXNWkQiE=
X-Google-Smtp-Source: AGHT+IG4cIIU6WmPPAmAyeyoDRkIxA8c2jVj+BM7239PipfMXQpDxtTnKrj56VzxkebbRk7j/S6a7d4VItHTBE0FHrw=
X-Received: by 2002:a17:906:3fcf:b0:ab2:f5cb:c039 with SMTP id
 a640c23a62f3a-ab2f5cbc22dmr1041271366b.54.1736861205895; Tue, 14 Jan 2025
 05:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-2-sjg@chromium.org>
 <20250114012226.GG3476@bill-the-cat>
 <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
In-Reply-To: <CAFLszTj9zAE_KniCZ2xHGHt1fK7jhTBHzfkdSif6XNuzKtWOTA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 06:26:33 -0700
X-Gm-Features: AbW1kvb9FceqF6UAVDk69QpcgHbgPSHidKYc7K1M-AHn46ZCmfa9MWNOo6oIcUs
Message-ID: <CAFLszTjPj_xPt72oXdQ_hav=9P2ff9F+OZJsJ=OmEcEiu-8e4g@mail.gmail.com>
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

On Tue, 14 Jan 2025 at 05:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Mon, 13 Jan 2025 at 18:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jan 09, 2025 at 05:29:56AM -0700, Simon Glass wrote:
> >
> > > Loading a FIT is useful for other VBE methods, such as ABrec, so start
> > > a new common file. Add functions for reading the version and nvdata.
> > > Also add a function to get the block device.
> >
> > This is not a good commit message when you're also introducing
> > functional changes (blk_dread -> blk_read).
>
> Yes, I did not actually notice this size change at all, as mentioned,
> as I only built for a few boards (firefly rk3399/rk3288 and a few
> sandbox ones). The blk_dread() function is the old API for reading
> from a block. It didn't occur to me that blk_dread() would bypass the
> cache.
>
> > Further, this functional
> > change seems to introduce some other code being pulled in very
> > unexpectedly, and that needs to be explained. For example,
> > phycore_am62x_r5_usbdfu is another case and that has
> > CONFIG_BLOCK_CACHE=y but CONFIG_SPL_BLOCK_CACHE=n, and yet the size
> > growth is in full U-Boot.
>
> This board currently uses blk_dread(), but not blk_read(), so the
> addition of a blk_read() call in non-SPL causes the BLK cache to be
> pulled in.
>
> > Just moving code should not result in
> > unexpected size change.
>
> That's correct, so long as 'expected' size changes includes the normal
> function-call overhead and loss of intra-module optimisation.
>
> So, what to do here? I certainly don't want to use the old blk API.
> But I can perhaps do a patch which changes VBE to use the new one,
> first, so the size growth is within that commit. I looked up
> BLOCK_CACHE and it is used by 90% of boards.
>
> Another thing I could do (down the track) is a separate series to
> remove blk_d...() functions.

Further to this I've created a v2 series which splits the first commit
into more pieces, so we can more clearly see the code-size increase.
I'll hold off sending it for now, in case something else comes up in
this discussion.

Regards,
Simon
