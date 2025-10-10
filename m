Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE839CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C80483FCF;
	Fri, 10 Oct 2025 13:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JO5wTN4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00A28402E; Fri, 10 Oct 2025 13:14:03 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EB383F6A
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-33082c95fd0so2503229a91.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094840; x=1760699640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c3+E49RV6Twk2bJey5/yur2qI7swITuzLKD4Hv1ixtM=;
 b=JO5wTN4B1Y/8/fE4j8yqFaMyguL2H0xVWZv+ctMxneAxNQtsvWqcUixjeitrPuajDs
 HLya13jSUu4QOiLKEE0guZWYIkHB1TmX4McT6QF1uq4VG5QUaeLKUCFou7v3NY4+33Tr
 ZuZOKwnXMvJbTJB4ID9Q10Hz6iaCMPa2fME28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094840; x=1760699640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3+E49RV6Twk2bJey5/yur2qI7swITuzLKD4Hv1ixtM=;
 b=M/kR17NeibnTwJuRWpWKuqbTrTbgDRWRTdgI5K2K9Q9SWWHuxQB0kegU8SlUvubPDx
 KrQ9Blp6XC0+/ukUNw+OU/pd69R7eEVLlyHBURYN7UxyhS/JNxeY5b+Od1fAQEUyzLd2
 22J3ruQ+rfXHAROVsVOjMiFsTxWA6qrBn6OlSjvGPC0Syr0L76WNmk90knlm/8qlLtJm
 6zgkelNhFtlhSSc8NEn3Kc4nFqUSZrPAPwLVpL/07iH1fVFraQFTAlCwo2G8vDIuTMwq
 8hidd6/SBfnCuoXoLOIO3pbCpZ1Km9iQNpCBzOOOXoqeC9pbZk1sOcObQlpgba6cCnL8
 ZKaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiYg3t/yA9Qi0m1bA2ne3vB8ZKpY29NmD/Cjf/H/YAkgV8i+xq/XOnVI7ZPjHuk2oYRK0tgP8=@lists.denx.de
X-Gm-Message-State: AOJu0YyWWEh7jZB3p9aeVE8J9z8ZzakZPSACnPA3mY77Sb+fReO9Irrd
 cI6p0KpGujul9OZDrD+gYd9b9hiiCW+POp3I7vvephkQbIFSRi7+cXwOEcd6D2aQjsWQqPXzcBD
 DrxwRRnxikrrwRZJyejlBWCtqp2n+ph/Rj/NEA7mH
X-Gm-Gg: ASbGncsS70HIi84sAfSHe2oaNGe/eBXgiK7odMgnt9xV6iWYrAW3R+UBPSdjCyHKuKb
 5SyMOfMysxe6DmBYVu2pxhAm1tkTzxt8QWuZaTyXqTIr7ctBU7VRFXE/SUwmwvIz+qPwrWfuhnP
 z5umZ4YXgbKFj55HDU7qhX0e7cDFXZ5pQ+Yh1IZXx4WydMzpOY5pMVM4sjmsMh+H7XF/xla+sxI
 FgH8UKw35PH5O4q/tcxUJcPheOPI/PB
X-Google-Smtp-Source: AGHT+IGmDTSK0vshScv3Vu+tR9Bx/pohe44eQeh0+kdOtJi0gw3UQxVPanSbYAG0ADveyq5jaKRpKUkgWNYhvSPe55Y=
X-Received: by 2002:a17:90b:33cb:b0:330:3fb8:3885 with SMTP id
 98e67ed59e1d1-33b513b355fmr16819672a91.18.1760094840286; Fri, 10 Oct 2025
 04:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-10-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-10-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:15 +0100
X-Gm-Features: AS18NWBQVxOhGrQpnI7lWC6BAxtFglDWrosMnn8q_5eo_CiVbKsTmQigB0RI54I
Message-ID: <CAFLszTh9QRw27=e6AK_cheN+2QmvNJhSsT8zFBCt9d6LMwnULA@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] board: sandbox: Improve extension board scan
 implementation
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Enhance the extension board scanning code in sandbox with better error
> handling and code organization.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  board/sandbox/sandbox.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
