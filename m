Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F55CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD2984040;
	Fri, 10 Oct 2025 13:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jfeg7um7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CD483F6A; Fri, 10 Oct 2025 13:14:08 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A7C84040
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-32ed19ce5a3so1786628a91.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094845; x=1760699645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hMU8mspSgnfdiceJYStNQ87yNEV6+5OHj7OHDhCQI6s=;
 b=Jfeg7um7ramaLTe6T75Y14Hnc+UXgmd3nGkDmKMVi/bCCWI3Hr2qYbcnXT+l0x9mpJ
 0BugQ3n5OQiXCkeJnnH5w86ZVSa9P3FcICytSGg/oEz8Mte60sBiUnnPfHOuvDEi1odS
 4cv0V1wVXE0guirvPTr9hI+9U0p729wVnGtvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094845; x=1760699645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMU8mspSgnfdiceJYStNQ87yNEV6+5OHj7OHDhCQI6s=;
 b=WKOsF30VF5G78BVzq9Vis26UIKaYqB+P9aMeYfSl0MMbPRvQracWlJ6MbksDX++CqF
 eQ4vpGL/n5fXTHJz+ctAAB43evpFznu4NLSddh49PGC+LWWOdR6umrRzKW/VOXmFXDia
 8GfP8mcnSOW06plaMynMYqhlyTmQjaEHWjeusrW//PDkByZgcUHBkYKNBJoWKah6bLz5
 mb/EQmwyQlPR4e/pHyAEuxdFHxfkEyhGRFHM0SJ9EBMDcmdV3TRMlpk4UCSx/SGzmNMp
 lnvdUBLQvCdikL3GbazgEfDEXZZhDDQ+vZA1vuKyUXnszBaB4HXO+RUrPoB2DSNiell8
 1tbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8/xkJZmaGNSxFDTI+Iqyl2sRXscy7QDvdi/XtaU/Ywetx/ZyMfjzcwny2gQrWi2n45KUEy2I=@lists.denx.de
X-Gm-Message-State: AOJu0Yzh5UBe/N9uLVMz6yiGUnsUTiXXuhZAthcRq4oqSDSUWBSSnP4f
 k0HSXPguTpd33UV2IEUOYac59ogdaVj5uTqZrQlqhU1PKtNM46NKD+/djN3g5sE5ybDN2Crn4jJ
 lwz1CRZW56rqUoVwgN6b1VIjG3ngY5Y5RUDnWCoaE
X-Gm-Gg: ASbGncs+24IoT2NVHGS/kx92TGGjYXXe+0OIK2uA5ury6vqdyyZt8iNZPU4G0sh0yPX
 0H+K0J1AAuARXTyuYsxX99HJ+HSX+jkfrGkb+dPViaqQSw/5+A2619CxLFdimvOMsQ9HbSkg06X
 No0ug654qmxm4dk4CJFmb3YsTq01rbbaatxyn4jAvmBQQGTmDam7xezbuS/IQWbdCwwkBvWX8Fr
 FgpIKvZTRUQYOQWsMAHU5Fg5/NC7LJg
X-Google-Smtp-Source: AGHT+IFI+Q3zUfGp8j+kRi2j4qwEVG8vo/Cd2F2y5hMS7VufdCwlB0dNn5nV47I/kgFKF2Jd8retS8L0+3DQPEgy7G8=
X-Received: by 2002:a17:90b:3e81:b0:338:2ed3:affb with SMTP id
 98e67ed59e1d1-33b5138e372mr13958844a91.26.1760094844898; Fri, 10 Oct 2025
 04:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-15-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-15-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:28 +0100
X-Gm-Features: AS18NWB5LDL6xYlrxH69KdbCPdpZPg2esJSox9iSX5ILN1ghunlRE3bDYWKh6XA
Message-ID: <CAFLszTjuO6cdkd7xPaHiBbMQtKYz3JQwtN4_t_EgjMz5F8G8xA@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] boot: extension: Move overlay apply custom logic
 to command level
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
> The extension_overlay_cmd environment variable approach is specific to
> the U-Boot extension_board command, while other boot flows (pxe_utils,
> bootstd) handle overlay loading differently.
>
> Move the extension_overlay_cmd execution out of the core extension
> framework to the command level. This decouples the framework from
> command-specific behavior and prepares for future extension support
> in other boot flows.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  boot/extension-uclass.c   | 68 +++--------------------------------
>  cmd/extension_board.c     | 92 +++++++++++++++++++++++++++++++++++++++++++++--
>  include/extension_board.h | 12 ++-----
>  3 files changed, 98 insertions(+), 74 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
