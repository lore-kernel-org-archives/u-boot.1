Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E549EEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1365E864AD;
	Tue, 22 Aug 2023 18:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="RODP8kIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A37E864BB; Tue, 22 Aug 2023 18:32:43 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394B98648E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fed963273cso23385925e9.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692721957; x=1693326757; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0gOkxsFi32PDBzs6bFXnHKw9mYEoS/KIruv1WB1o1/0=;
 b=RODP8kIPG8fnVTxOg8tJ4pfRVzVzEC2ulgsAnTlicbIkVQWhzv7bA8QbM9qRErwrHi
 1CgsVQW+jSIIe3WJDp+MbBln5YbzHDLgtjfxhASTIv6l3R3gF8oOSOI8H1DliJf9NVfT
 Lp8cuzWGN9THwquQ2KuzQ1LybBRO96zGP6nU3Lcl1Udvrl0NcHGG9NRynzb1RBXBGel7
 F/AL3KMM1mO3cp5qXP8doCbqXcuyUC3Jlh3DboNv3PKTEzsAacmpbU/R4hb0P/kqyCI0
 lBYULmG3T7RlpcGK9/IZlCoS0pmRefASmBDNrAC5c1BSMAYy39fToWoS8uUa+It7PN3w
 bZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721957; x=1693326757;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gOkxsFi32PDBzs6bFXnHKw9mYEoS/KIruv1WB1o1/0=;
 b=K6S2goQJ126wScdf704OMohQ2GFSr5C6O0wDbxRZH86BQkVLVFvGWit3zJHiS9xXJD
 VZbn9GAlEDytHSQjCbow8mlJW47/IStNjsmeujZI4w4cwPx4+lIjE+Y14r8Jv/N01QDU
 dryHpunXub/kba4g7fR8+hIJF7quWi+RRZdn6mXfYv/bC7nzhBmc47vercV8GPU2eytl
 CMchFBp+f0YKDqniSNL2sn6ZW4vLMT8Yu9pznO+4+0PS/HvXRYs19VWOfbz2ersifOGF
 xDu5YNd8b+aUJmhJbzJFWXSElyLOfVhooXZGKAVGhNfGW9ICaLv3uby5GbIyqKNq+Fc1
 QwYg==
X-Gm-Message-State: AOJu0YxCvIV29GYMQR8R32f8cMklF44tcAZMMwD5Rq0tX7qq+r0Z8aCi
 rL6CtDaUhweXeWYRoi159+kbbA==
X-Google-Smtp-Source: AGHT+IHLnreZ+VgSqanHUHDW49200qqZu1ymezutDjuMU4Q5asM9BOdVaF5fqbKWaQQ7KgqhMhwxqA==
X-Received: by 2002:adf:f54a:0:b0:317:597f:3aa6 with SMTP id
 j10-20020adff54a000000b00317597f3aa6mr7829380wrp.18.1692721957641; 
 Tue, 22 Aug 2023 09:32:37 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 o2-20020adfcf02000000b0031423a8f4f7sm16398607wrj.56.2023.08.22.09.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:32:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>, Dmitrii
 Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH 09/17] dfu: Detach the controller on error
In-Reply-To: <20230819142407.49632-9-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-9-marex@denx.de>
Date: Tue, 22 Aug 2023 18:32:35 +0200
Message-ID: <875y57rqak.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On sam., ao=C3=BBt 19, 2023 at 16:23, Marek Vasut <marex@denx.de> wrote:

> In case anything errors out during the DFU registration, detach
> the controller instead of bailing out right away. This way, the
> controller can be reattached on next attempt.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
>  common/dfu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/common/dfu.c b/common/dfu.c
> index 96190889ab7..32fba84da16 100644
> --- a/common/dfu.c
> +++ b/common/dfu.c
> @@ -34,7 +34,8 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl=
_gadget)
>  	ret =3D g_dnl_register(usb_dnl_gadget);
>  	if (ret) {
>  		pr_err("g_dnl_register failed");
> -		return CMD_RET_FAILURE;
> +		ret =3D CMD_RET_FAILURE;
> +		goto err_detach;
>  	}
>=20=20
>  #ifdef CONFIG_DFU_TIMEOUT
> @@ -106,6 +107,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_d=
nl_gadget)
>  	}
>  exit:
>  	g_dnl_unregister();
> +err_detach:
>  	usb_gadget_release(usbctrl_index);
>=20=20
>  	if (dfu_reset)
> --=20
> 2.40.1
