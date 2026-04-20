Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7784EA71B7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2511684286;
	Mon, 20 Apr 2026 04:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UXCMMl4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ECB483693; Mon, 20 Apr 2026 04:58:20 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E807A83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so24858225ad.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653896; cv=none;
 d=google.com; s=arc-20240605;
 b=CLXfJBDlFjhix18gi3WWYYHONwsgf36vvZz0gDkj5govQtwDljYadWZoFM741gCYuV
 CETwiL703AbmEfQEk2scxoq3e6yEbR8sgR2lND93tE0dRkEtrZ84dr33tsezXDgkK8Ev
 ltGY/+OUYlI43kNeYvDVf0o7VUoHxKxZbi2QZzDk2NKZonlTkA4jz7lPWVfXqfeMi7n2
 8BEI/Zm3EcHeuR2QNe92RM7ot9kmdb0ObCUvkLHVzbH3atDq/CBQ3++WYEQGTwxjalcv
 QLRllizmcPdUvdO3FFnf4R84D7y+pzuN60oKhk72f3rniP7j5RRVezqGSEtuXwpdlf1x
 PvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DFDKptxUupqvcXD6W0qEUn5pNUEC6BTqmeBBwwFppV8=;
 fh=uFxjLaaaCFvS5ORSoSXNjj6yABD3eNmIam49/ewrXUk=;
 b=TcjjxBaI8TGiNAkhiR+CmYQHyQtYyyz4FAt248rjtpQ2LkL9chiw4SbUV9tm3XXFZB
 ltidOJCsV+N/BXQSa0SL9uRcgsBIR6pepblHmufO1O8N99OxWQGMtpujdLagZ3kphSYa
 fBCm8Vl1b17m3MV/w1wfKzgPUsIUimtaojd8Q0yqV4ijXVbfnoiAx9+TCBkoPH3aTkxl
 IlZPlOiymRlRGjaS1zib8y7lelx9Ply2BGinK1nfxKq5h0j13j5RWKLeQNPiCF+Wbkcy
 voggdb3hWMwup94wgd+X7NinOu+g9TkAQyyK/NQCSpJUGPffz7b2G7jwWhQBOqHv/FAC
 K35w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653896; x=1777258696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DFDKptxUupqvcXD6W0qEUn5pNUEC6BTqmeBBwwFppV8=;
 b=UXCMMl4m3x9r5ZRUg46FrZs/RymYPiRwltt2ApMv8ZfI6fGEyhLBNe8fFbkmr4PO8v
 z1HzEHoCkyH6vBl1nzRl9XCT+hyCuFNMcBc5YOum0hQxVbENodkfCKfQGsR+WzScKRTq
 4aN73oLHvppBJ1++fcFz5AlruHbP3KhNwOlM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653896; x=1777258696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFDKptxUupqvcXD6W0qEUn5pNUEC6BTqmeBBwwFppV8=;
 b=DBqqFBnrVackIlCID03AJu8FcSSfB/8mXf3G6R+4kcbQ+wWgLPJPBcx4kowowfEgup
 wBG7bR1E424eMs7IYIDQWZw9u1hiEm09P5oOSBUnJw0+e3rN2KxR9JOYiXY0Jdb0HROs
 ELbuKsGV3Qpa+Om1zaTR7/OOY8JXnEK2y3Bg7biH92QVNxD4iXBuIpQ0YHTx53gAeodx
 A/IFkIrSFtp62QjViLU646mV+T75VUDYddnkWaRqU0NIpF+jLw8Hpp7XTEam9OrCjT37
 etVaP7kPLtU/hkbCur16IelM1J2SbY4At2v6bn9Nur7pFv6vXI1ozv81vfKEK6ki0pD/
 w9rg==
X-Gm-Message-State: AOJu0YyB+SwnTDRm8pCr9lE56vFI1HhihuJB8EMuQIM+VdVCO7meR4O0
 GYnYqdWyVajZOo3LegMWBWOuXMaiEN7UPT2TJxzT76V2lneK3fNum8msnAjgYDlyIxoA/UVh7xa
 MS/lfgwQmYHN5muiOcWC8WrQKiB6/J3BVjWIl8oh0
X-Gm-Gg: AeBDieuscTJRn0nTIyvDXI9UlYP9zwsxc7vZrebrGJOdMdjnSl0ULovpdTc9rjep+c5
 Ikuyz+cFlI1LlV8yx1GKLAUG4l/MgCmhcgdDphlgrf3KfuyFMu2PvArNjUTEC+FI1g3tJFCNKPg
 n3dC0yFfDJjfgUDSq4zPBF3XHKixpkRlsLIyoGLmFQaHIDnKS4ouJ+raahJB7Kal7pQj364Y5iV
 /RD/owqGs/t8RXVTb3JoN7TOiWksDZRG9dUDKwcU+AqGPhEqsGNcthF2aNsNpfXtufhOcI0tHzA
 yDmAi4Ct4eTG7t9+HBYt
X-Received: by 2002:a17:903:1110:b0:2b4:636b:dc4f with SMTP id
 d9443c01a7336-2b5f9e950a0mr98375085ad.15.1776653896414; Sun, 19 Apr 2026
 19:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <5255631b1c9316fcc36273a70e19a65cba0c95d1.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <5255631b1c9316fcc36273a70e19a65cba0c95d1.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:58:01 +1200
X-Gm-Features: AQROBzAmtwcy-W4Dwz7tq-LWgsyaJjek5MXtSaX26JaCp0axSx_dmHZwS5BLCCs
Message-ID: <CAFLszThJUF_3ppNojVEnCajcackbB5K8MN+kYUyS9Kv6earE4Q@mail.gmail.com>
Subject: Re: [RESEND v4 12/14] arm: sc5xx: Remove SC5XX_LOADADDR
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>,
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

Hi Caleb,

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> arm: sc5xx: Remove SC5XX_LOADADDR
>
> SC5XX_LOADADDR was an ADI-specific duplicate of standard U-Boot
> load address handling. U-Boot already uses CONFIG_SYS_LOAD_ADDR
> for the default load address and loadaddr for boot commands,
> so keeping separate SC5XX-specific names is redundant.
>
> Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/mach-sc5xx/Kconfig                     |  6 ------
>  board/adi/sc573-ezlite/sc573-ezlite.env         |  3 ---
>  board/adi/sc584-ezkit/sc584-ezkit.env           |  3 ---
>  board/adi/sc589-ezkit/sc589-ezkit.env           |  3 ---
>  board/adi/sc589-mini/sc589-mini.env             |  3 ---
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  3 ---
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  3 ---
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  3 ---
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  3 ---
>  configs/sc573-ezlite_defconfig                  |  2 +-
>  configs/sc584-ezkit_defconfig                   |  2 +-
>  configs/sc589-ezkit_defconfig                   |  2 +-
>  configs/sc589-mini_defconfig                    |  2 +-
>  configs/sc594-som-ezkit-spl_defconfig           |  2 +-
>  configs/sc594-som-ezlite-spl_defconfig          |  2 +-
>  configs/sc598-som-ezkit-spl_defconfig           |  2 +-
>  configs/sc598-som-ezlite-spl_defconfig          |  2 +-
>  include/env/adi/adi_boot.env                    | 18 +++++++++++-------
>  18 files changed, 19 insertions(+), 45 deletions(-)

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -2,7 +2,6 @@
>  * A target board needs to set these variables for the commands below to work:
>  *
>  * - adi_image_offset, location of the fitImage on the SPI flash
> - * - loadaddr, where you want to load things

The comment header now says boards need to set adi_image_offset, but
this patch moves adi_image_offset into adi_boot.env itself. Since no
board-level variables are needed anymore, please can you remove or
update this entire comment block?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
