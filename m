Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483BFEA71A4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7BE83BC8;
	Mon, 20 Apr 2026 04:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DvX+neUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C920842BF; Mon, 20 Apr 2026 04:58:39 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA92F83B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso1464013a91.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653915; cv=none;
 d=google.com; s=arc-20240605;
 b=fZNRwNqXF9DfGXOUAwseWvUNZz6pb2PGqXt/xMj28M9AO35B96QToAyAe9rLgvCJk9
 vHc5a95tutFHPsooOjQVuazch/mSOyzs9OYSPVRb8kHCeKfZv9N1T3JIaZQWHsocB76u
 wu95GRkd1wPsU3FahnFrwOcS62cYRkfrqAhHi7BL9clMOlHLXIlqsD/oHIlWbCdbGXfd
 XtAgZaAuXfOB5gMm25WxR2f+KaNzNFXht6ZtqBzgLP6ZIHJMeAcoEcJG+hVBMubXO939
 t+w96VMdY3hoIe5USHz1mZBp82Vrd4LEWbckDGIWJB6gXxC/Iig+DGLGOq6CzteiT4Yc
 MRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rua5RVv4Lzv2gvPI3u7DiB4IY88d6lH6J3eK90h8xhQ=;
 fh=wNODYcYHwTK6I7LVNr8nSv47LrqCVVhAdKcSbKqeg08=;
 b=iLcaqMlAAN3SeXkJwhdvz3Q/iGEwxJ4x8P7O+AtSlRBjbBXuYjWF4pIdQ4ajBwsZbk
 7LyyXsq++5npoG7WYKLUUtpjMrtszOxOLp88P0KcgU/vEhryatOIes/k9rcF4+SX7QR3
 HVwEub9mE13rlzYqOBhzNChOZIlqt0BCpBHjBzsAGNfW2Etzxwl2VPCbrTU2a8mjcT2d
 ur4GRx/Zv1waGQWMr+PqMEyoxCtNB4Fx8lgqjiCfmC9asjfC+zf27G8+no2kNLiCw73b
 tXwFHM1nTxZu9+qw/75K1AIjOWzr7bTAMiDLnEHEPN87r2FMPubT6qkHHGmKoYyX5WwI
 nkSQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653915; x=1777258715; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rua5RVv4Lzv2gvPI3u7DiB4IY88d6lH6J3eK90h8xhQ=;
 b=DvX+neUNV/kIxPh8mvpAaVOZsWe+DP1TCLbNMPLgDB0a6Rnd65NRcLw2Sw4Tm3xGhy
 i0Qu8+GJJG4txa5d+86BIpILqBKWe18GOJKeNMR475v/V80vetIUt8XW8qxTOmjm7ssu
 LzGgDxMWvAfs0l0keymIOJosNCoS7pV55AYxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653915; x=1777258715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rua5RVv4Lzv2gvPI3u7DiB4IY88d6lH6J3eK90h8xhQ=;
 b=oaF2Y/liiTLVcRdzoL+haCfyDitHtSGFCIGODfN55gD7dShkRxnByqXiYW2sTebOSF
 d7x75ov/wgbcgYDB1ZZLgT/tVD/Sv1/JffvY4P5TND8Qf8vN6D1dGc31RB1cApFBzeDb
 cxkMMo3BW0SfYK/hjXDgm31iaUV5WyJqSqMDN0Avh6Nr2X3ifQfoFnohJvOeB2iAKjZb
 B7NE/jYUAzdvxE3PdIe5Oq/UnMYnOCUGlzqYAx2OjM+doWBQKgl0WW5hTzqxO//G7D9z
 CqiJqM2f/coxAAZj+fLxJDKMUTXQvQkjwaH/TcUYGGP5+0zay9ZTunqEopF0+iWd/WDo
 ZXMg==
X-Gm-Message-State: AOJu0YxwYH0wKKbkDaz8a/jLjX0O552FK//xxXZ2sc4F6zXMluy4XC1m
 UXC9SZ8i8pqpjJ5QIqFrY4dvOfmgIbFAZTF52G/kqYR2MpzTpR0DlsU9svxI0jxGSDw7uygOkBa
 Oy1FZDuripEr4pZTob/tqr5wQheB6vZjvRW3oqrsj
X-Gm-Gg: AeBDievTf9OIbwlQQ/kGIe3GSqblwHNj52bWALaexw64PVLBUqRoBwpCG4HTC3WK801
 YXWiwlHo0mM3K+ZSfz+2WzrJ/SNJXQZfyhCOszsin8j/VxHzhReddCpzmhmChkq5gyPNjawwDd9
 3h1MPPwB4cL9mG4ojm5z82n5q2wL937qSeAo3rSu3uk4V+1PvBGoPU9lfL6c6fGy9FODQ9n5b0z
 sK9UDugJsPh3/xGtgiXLnTJjbQfUCPHI9qYWDfA1/afxWTvlgx0PMN0UqpTY6ySXVDdR3vJ+ECL
 nCfyNH+fS2YDK5Tm1i0u
X-Received: by 2002:a17:90b:5865:b0:35b:929f:7e8d with SMTP id
 98e67ed59e1d1-3614046cdb7mr12341889a91.14.1776653915396; Sun, 19 Apr 2026
 19:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <d92e6e885515ddc3c205623d6edc56ab7c53aa19.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <d92e6e885515ddc3c205623d6edc56ab7c53aa19.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:58:06 +1200
X-Gm-Features: AQROBzCVbV8t10iUpNkp5TkyN13tN2KXr_7iTBJ6vzrgHwPeqtgNNgcUbMASVt4
Message-ID: <CAFLszThp+mUJNznn4cP35fsuVgnSrgUk-cLYpU2-BaJz2rWtqQ@mail.gmail.com>
Subject: Re: [RESEND v4 13/14] arm: sc5xx: add missing boot env selectors
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, Ozan Durgut <ozndrgt@gmail.com>, 
 Ozan Durgut <ozan.durgut@analog.com>
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

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> arm: sc5xx: add missing boot env selectors
>
> Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
> environment includes the expected boot commands for this board.
>
> SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
> environment, but it does not define any of the USE_* boot mode selectors.
> Without those selectors, the shared env does not generate the board boot
> commands such as spiboot. This leaves the default bootcmd=run spiboot
> without a matching environment command and breaks autoboot.
>
> Fixes: c9e893d ("board: adi: Add support for SC598")
> Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
>
> board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
