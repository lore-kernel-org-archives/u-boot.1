Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0A6CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5518341A;
	Wed,  3 Jun 2026 18:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hXLKocAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FAC38486B; Wed,  3 Jun 2026 18:45:57 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C5FE80433
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so6304358a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505154; cv=none;
 d=google.com; s=arc-20240605;
 b=NLeeb6fy25ekWzHxQCIEw0RaUoXpvQoLExz87n8V6QuRSkU5HOff1YXQG9GxRmabGv
 OwluHaf3a2OrNEnJqxQlFxSyps8qJY1ZK10S2HZQip76IO7t4NuuoGsCAUrWFujUw7fh
 DmYICJ1E1HTVy/QiTL8UQNJ8824sSfTwe2Hc6MQt8apisenjwSQrR/4YMoJEX7FG+81K
 yo94na9sx5TTPAR+11lr9CB2gilD88L3QKon6Es8xdENIkS8OOxUe+vEtSWmG6q5p/LV
 0XqQuTWWP4rJpV29s0MiwMbGZfkICJOLFq33mjrqi3z14wSqiNTPMFs8QyS7ba24wiQc
 LsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XDeuDta9IGnnZYnqaAGtTqRRfLD3Zg9BJFQ4z/Lr1dw=;
 fh=3vbYSVaifU3E5yjV41YkOEuRcfdK8Bup9NZXioA8VLI=;
 b=L32Okq70q+rrfWYxgJKH4kc8i/Brehw+5KDYf9EGBKtJC5xAmX/Xk/UFPl3PRLaQNI
 QFEwFrYGXih/NDVhBChUUoYh2x9dvDpI6pM5Ls55lkr0XwVrw66pzliX22x3OFDTioK3
 vfs4kIdGrBS68r/Ub2ohgsybcznAykgVeIrACYLlh9NwkJcQNU9bKUNuJEUOmaYi5UUy
 Ma+ESmV4h4IBr3QpNKLtMZKjiUEpnCs/Nhytyj9FHmXe41zlNHLdlk0AEfmOP2cgOTCl
 O8NEvGh8wzssNwT4J/Sed//NlutWwEI3NDDo+5HNFIss84jXThmH2K3niDPwl5nI9G3T
 SHVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780505154; x=1781109954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XDeuDta9IGnnZYnqaAGtTqRRfLD3Zg9BJFQ4z/Lr1dw=;
 b=hXLKocAht2fyU8hMl2WD8YJx67owUm4wKvyS+HoXYIbJ3TaOELk7pYn9UFvn0465VR
 3rG6/EpKBlehffhPi1r3oRRcBaeTZxVR3lxjQVPoIHoyxBYEtxJwULWXPxVwC0gEEHkn
 3MBxhrRpeIBdG5j1SBWrEzQ18p8K7GqXNT+wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780505154; x=1781109954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDeuDta9IGnnZYnqaAGtTqRRfLD3Zg9BJFQ4z/Lr1dw=;
 b=BdYZTwZkpcSp0VM4PimyU9BTbuWozcBf8Hvf+D+hFI58Ftg/KvBDlWi3QN0A45unMa
 J4hgtUZ4xtB+9rmOyE3Y05q+kozwNFFZK+thf464pVvegs7AxzxsJaKopZy7IjV/dHhB
 iuRZGsNicCa1rA7sK8vjlLPHI5rRhbCErZ07LGNQbrbmoDEcu8lRWsS4ZsU87EiltOEW
 dS6Gk0H9Qmg4bEtN5P60143lzUJqQfXb9kTVYJrWwuzUWZUzS/wJddLquLTvKu03wg78
 04gaAlpTQtWZf07vSSNDLlD2UxKTEXLrJq3L9yQYdbz8IyBVIvk0tfT2pJjGNGMEBxJN
 go/w==
X-Gm-Message-State: AOJu0YzsF0lULPFOKvtcVxjgPi7B8jTmNSY+J0+VirCFiUleuJ12FVDR
 tyDYJaZdAXowgwZFl/eLTz1hX1hbtDo1JxLak6tNIZ4ts8CDFQRyzo2NvRHn940MQPDA28f8zos
 vQrSxqTyRxER/ywVryg7OHHRHwAzzn2W9yyEAj83X
X-Gm-Gg: Acq92OFatzGfB75Uih1G8R6MbVQv+pVwddbFrXe1vTto/DET4RH9W1yauf43c+TYWLH
 OoafW9B+hT7LtLK/gFoCw+aRAALYNESjQWBXGnvVlFeVyfx1eOk8JTZlGbxyGcUALe41lgSAM45
 9x1EYIwlqPslk8rLK3Uw2BwRXmroS0gp4eF+m4ahoJ/iiFUYk8QO+0RTwJrp0cAwtYWCHegugxT
 kkdymuaL8T3FzX1+eAoStFNuLHbDFrjZlwPg0hqVyrWSWcf8dwpfY9rgp1SkXcBmsC1MckpAAXI
 nhYmAqx6qdpsnb51tzHJ7ETJ0oc=
X-Received: by 2002:a17:90b:164c:b0:36d:ae6a:22f4 with SMTP id
 98e67ed59e1d1-36e33bb8f9cmr4314396a91.15.1780505153710; Wed, 03 Jun 2026
 09:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260525235155.96167-1-marex@nabladev.com>
 <20260525235155.96167-2-marex@nabladev.com>
In-Reply-To: <20260525235155.96167-2-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 10:45:37 -0600
X-Gm-Features: AVHnY4L0h3SVzocrCSo_MSk4gnIqtJlQL-gTn41Ab28EqCzA5bbouaVUdjAaCEM
Message-ID: <CAFLszTjAsHqahFQb-0Xk8=ee36MNOK3RPhqrx+cGrt-qKVSmrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mm: Generate FSPI header using
 binman imx8mimage
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-05-25T23:51:02, Marek Vasut <marex@nabladev.com> wrote:
> arm64: dts: imx8mm: Generate FSPI header using binman imx8mimage
>
> The binman imx8mimage now correctly handles generated fspi_header.bin
> in its imx8mimage etype. Make use of this, remove fspi_conf_block in
> favor of generated fspi_header.bin, and configure imx8mimage accordingly.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> arch/arm/dts/imx8mm-u-boot.dtsi | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
