Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF51CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D1D83FCF;
	Fri, 10 Oct 2025 13:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CScEzPiI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACC5840E4; Fri, 10 Oct 2025 13:14:47 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B841C83FCF
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b472842981fso240578066b.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094885; x=1760699685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F89gpUZf5mRbzBbO1dRFOF5gtczL4MzRWpTNMfUJOIE=;
 b=CScEzPiIK+tAfcg5QgpkNAxONkt4M1W7amJ9oxfg6URW3zGvsrQqCscG7dn+QfcOG8
 liYnJFSgq+xCn8FF5po/qv+Q6MTJIsd1E8CCh7fV5hDHhqMwDrVsybFHsFW/h/vhited
 zkI0P8PQ1XzMOG5B4Z36H7FDFxJji990fFwDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094885; x=1760699685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F89gpUZf5mRbzBbO1dRFOF5gtczL4MzRWpTNMfUJOIE=;
 b=XOIt0VboFzDkekl8H6SROCbVAYN2EyIg7X7FZ54jSXZrfOL1qMDXUCeG014tBGvOku
 hctKNpCBhE7mRHW30H4r6iSromou3PnMHfnwHqWDGznaRxc4sCyQZ71Fl6w/WfthB2na
 dlNjt3HIER7ptjThUjdURLQDuWornbZm6ZUHyEuwJfMoiPuBm23W55qexqUGwQXNhq3W
 tqdCR55NZtFEBJYu9xqhbMlj5YYmNG8PpWDCay3xncgYbiR+1ThOFdN/hN2trAljNHYc
 hptQUgX64WUPxSmaHclqYCBSVv00vZP3v77PGw9RB4r7E4AM1elK4jMEtrLBfU/jo2YI
 au7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+3iVobQiInNrmIga/LRDV/BVBOTpe5QqogKgNSWlbY0um3s7COXlka8ppGLWtebYoMuBZr/A=@lists.denx.de
X-Gm-Message-State: AOJu0YyC00lGZrUiY2D0uTSiXtbd9sU/QmQmK4cERPFS7pcFvrq08zB+
 6kOKz7IY8NxEEW2ot51kilj/VeeOwBgbneVs3CI7DC5IVvoaqhbPmyNrPlFxDiFJkNZMjWEfb1C
 xRAicbWRdO3CYHJPq0RsmWrkw12pzgkgJTYUfwtCP
X-Gm-Gg: ASbGnctt9r6bGQXhrlvNT5syctMxJnzo0UsRcV3FuO812dkuICD/AVkbwf//dZ4OlNl
 2cDA32tZZ9Bw3yajnwzKaZ14y1yMdrHoOd+DuU9j/0Iwtk3PxaoqnU0ML3dmEM4INVIS2VXUhEE
 O9ZKqlmTP2u8rj0MdY/NxN/A3qzl9uaAojB6zOumz5V3lklVoKsF5ufCRVeyrwRrBCP7NuedYUL
 3oG6CxCCTBrDdhHSyh6Dg==
X-Google-Smtp-Source: AGHT+IGy8dULmbYSmgOcagcHBGwbM0d8prRqrO4cAJ1knCjadV6d77sTTr+5EnxVUVFcG4bZ12j9b+EO7QcOk/M2EfA=
X-Received: by 2002:a17:907:2d0d:b0:b4e:f7cc:72f1 with SMTP id
 a640c23a62f3a-b50aaba1161mr1158710466b.22.1760094885205; Fri, 10 Oct 2025
 04:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-16-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-16-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:30 +0100
X-Gm-Features: AS18NWD9PI75TTRHciIFMAmN4Bks-Dsw8wiEB52gn1R-CG46ufD5Sq37J2VEC5c
Message-ID: <CAFLszThLHUYF_9xVjVjXiKsjYoHt3owUx978O4MKisMjx95=zg@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] boot: pxe_utils: Add extension board devicetree
 overlay support
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
> Add support for scanning and applying extension board devicetree
> overlays during PXE boot. After loading the main board devicetree,
> the system now scans for available extension boards and applies their
> overlays automatically.
>
> This enables dynamic hardware configuration for systems with extension
> boards during boot scenarios which are using pxe_utils.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  boot/pxe_utils.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
