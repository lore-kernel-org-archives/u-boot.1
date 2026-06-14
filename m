Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E9FCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 11:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078128488B;
	Sun, 14 Jun 2026 13:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AWlO9oWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780C384877; Sun, 14 Jun 2026 13:53:09 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96CED800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so1842069a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 04:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437987; cv=none;
 d=google.com; s=arc-20240605;
 b=dY4heJWXEsecblllwp96r7TL10q2SvAK2TsSoyHWuJgnEqKA26EjPd9lsOHfLikZEa
 a3n37LvheP/0VPVjYlv6+p1+6jfFZ+IUMNIeY1g555EmoJD9P4a9PM/vsydvl09lS7f1
 ym95MTPfWIjGXOcTcCJbLN+Mk98t3A4s/G/ZrhjPoSPL3eB04OYlJdGUjY4SMROU/qGy
 85mFxIQGZFPTaTQOOHbrPz+ZoTaYSPyL2jHYZlFIJ+aN8mnMc9cl/ULvy2P/QQLhn/KR
 IkX0EURUr+p0zKUfVBVnXgyl9UJH82wMZsBV4f9/aUT+O0kqjuVHqnLmrWCrj+M0/+9d
 ZCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QROWFABD9Qgimwl2fg+0RfRREcHcI9wr3uKoCrAYEvA=;
 fh=JdYuey8wYmmx/AtEosXUVTN8d8L/5S4NrdlkDKNw/io=;
 b=WDzN/LinkvDd+Q3Ssd8bOcLhlaQ5LJdemfVNkrkqmZ53olHVj80Ilj2pBXQeFExDAr
 KjG6s5zc+v6lxjrqMitb1/aW9DLWFs74k3NHeieY7j/ZXWOOHOZVzMx3KsF8ecB5+l5x
 o+BPhvRAOLQCppPCPQHeN4K+eelkexbuKXZ5C9McjQqSX2nO6QJV+GM6zbvTN4pBaaXD
 /GDiWWIR069mXB46tu9lIK0s+U0l80N8IgmW/+8lnsgG4TSbgPQj9MAM4uYbfzTDXmWk
 LnHr7yKM8whScTSzokXP0fARlINygnt/im+DrM2qp/V6B0dnL8buCqoRoB/2FC7s//99
 XPaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781437987; x=1782042787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QROWFABD9Qgimwl2fg+0RfRREcHcI9wr3uKoCrAYEvA=;
 b=AWlO9oWkRfGLufEUUfY1FMhPCKLo/ygVbU1r8aKQs5Su42VEraZrTMbbakTM9bI2+C
 rCNf32SPKe9GPkHVMCApkzgWRCVAAGaCplWG0J3qTTjWI1IF7N1KNpAeepBUZ32ULihz
 qr7cUBKPXCHvvY1Lq1rOul0Dg8021G3E3YDtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781437987; x=1782042787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QROWFABD9Qgimwl2fg+0RfRREcHcI9wr3uKoCrAYEvA=;
 b=Nz5KhkpnUIZ7RVyiLxXsotxfXMVyHOTAt9UY4kB6JA1GWmSzwD3DMczNxhdZlndudH
 ndYV1PmrBxBd3m60nY2/jdsFB4EE+J/a+rCrX6VrzIIOyuf6Tfg1Vhco05l4RdtnQk6H
 mBrEHw0X60Q9OfugqoVIqYlaA4rcUNrBowqt2MAMyf1fmUBT9M2JwsFo2TTK0oMAWOiD
 bpXcRr4hmwkwr9Lqhye4jdqwMm7dtFjjWgixUc/H+XN0uCiTyZDJuGZRwCWyUNPZ7Si8
 hWxQuy/OAMw3IeUuDil1R6f9xWOx4Wdmquxl/6GNJsdCTYciF9R2v7J1zRTUzbM+V3zo
 Nx/A==
X-Gm-Message-State: AOJu0YzMrx5dKGzaE/MDH1JV8wdH5G84IncbRB5gMOZll7WNjhkXGlfV
 Ft5PMubB1GFOOVkG2lU6LAV2GbWa9cGWTNErgWeTnYvUF9lt9f9wwJ7SZgoPdY9hxH7QqfyDvQ2
 lt0wHAzCdRIZ60qWiA+Tz+k4+nPdEZK272eFEE+zMeaTUYDWESIs=
X-Gm-Gg: Acq92OHyh/zAcZVHkwSeqpgA8QiTSyyg7j6w/u8baKx+XtvZmKQX9FQG0WiNqltU29b
 VgIBFSY85+ZmsxOXdTT9+JTPvuztUMNvv6gaFSXiCvgcR4MyZ3RDJ2FigW/IJt7WZkw8rrPxYSn
 dO+6IU0e6hzeR5d874I/WYaM2Cghw6eliXg4sC3V9V/dRW/o2HEpRWB3JoBq3gazEJ9Bl9yw0f0
 i++K5VSVoVsgE0qvaMFUIFY4Wzwb2X0tYoLDY0uB79PWxTMbMeR14lcn4X/fvSOg6aOlqAaX+tz
 U4u8F871lsTOigBA
X-Received: by 2002:a05:6402:1d54:b0:68f:c62d:b36e with SMTP id
 4fb4d7f45d1cf-69378a5a6e7mr4667593a12.28.1781437986798; Sun, 14 Jun 2026
 04:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 05:52:54 -0600
X-Gm-Features: AVVi8Ce6ry88P0MubUZZRylQ58gEZvCTU8-Q041azGVlYDiNmLk57fk46GmV0Bw
Message-ID: <CAFLszTjSK+EJ8o0LQb8SbBJ9ERcN-=H3S2QfQ77mb5U8roJ-Ow@mail.gmail.com>
Subject: Re: [v8,00/15] add software ecdsa support
To: philippe.reynes@softathome.com
Cc: u-boot@lists.denx.de
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

Hi Philippe,

On 2026-06-01T13:42:58, Philippe Reynes <philippe.reynes@softathome.com> wrote:

> This series adds the support of ecdsa with software
> using mbedtls. So boards without ecdsa hardware may
> also use signature with ecdsa.

This looks good, but could you please do a follow-up to add docs? For
example doc/usage/fit/signature.rst mentions CONFIG_ECDSA but says
nothing about the new options, so users have no way to discover how to
enable software verification on a board without ecdsa hardware. The
binman pre-load entry documentation could also mention that ecdsa is
now accepted, since it currently only shows an rsa example.

Regards,
Simon
