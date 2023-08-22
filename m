Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4491EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 16:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB8F864B0;
	Tue, 22 Aug 2023 18:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="BAvhSOoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F8D8647D; Tue, 22 Aug 2023 18:24:45 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCE9864B0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 18:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so2871197f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692721481; x=1693326281; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tS1BY/qmCDU0wHcS4pRac8I0vO2dT1rOVb3t0TV6ao4=;
 b=BAvhSOoH1M3ZcgOOkWmkkhWWvAVDErtX72BhNwrQTaW3nbF6MLIqWaxnb30hAj1+P+
 NRP5gEN5AknPOp67qgWbeLNauL1s3LXG7+qW0UgwtAPPXI8HR0kbApxl3sBi/7bYhVSy
 z1pC4G2mW/Vrp6j1DWZuDJPXVBLhhE2FgNFLpR7peVjY2duEnRRaAwGIZmXlN9Xnxfch
 zd4X6rrtcU3wvlhuQyqPpQCetgDVsH8rNDTSGxM42B03URiSzSogXTXk89HYL30vyjMI
 k2D4NGex/xN1fa+oWPkm3t8Lqqvp/ko2SHlyiB62m8xAgBFEiU/emLNJ+TEXst/HGp8b
 Aruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692721481; x=1693326281;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tS1BY/qmCDU0wHcS4pRac8I0vO2dT1rOVb3t0TV6ao4=;
 b=PMX4u+3v4np+mkylB3uzpmpAgATzwnEu1T9xUUYvlf67CIHlqKc8N+KnCD6zfa3Zdm
 OLrIqLqOH8msSxcqzRJI/jea9JSrudcTTxDn97B7OiNgR+smX1s4QHYEVQkSNUrBb4eE
 K9sv/fXU9bCp+l6i92yGE4bqCW0tH1ZCUs55PeNBGvnZ5YR5nkYkC7QirGLXzBnc3Wgt
 /0QeqUOrU2K/7pjJAxcjBimA+QqE1ErgvWju78b9/wIj/NV3Im1gbpEMnhvOdAakVshZ
 DJ2JpFmW3yK+C3EofPW/4obVo9i+bcxgAIQn1EuabgtkhaAQmMNCTW/OD4RHifBKyq3B
 hoFQ==
X-Gm-Message-State: AOJu0YzAw10y8F+9L1YPp877fFHcA29fVNjDhGK7GdwsQEDTwEgDOExl
 oOmWppN6UDH+QPzJSHMEbe0uWg==
X-Google-Smtp-Source: AGHT+IFteuaF/dxWof0UabTv1VhekIqLt05aOhfdeB5pCiaRNnsPuqv+xqe92BS4mVCR2Y1iImO9eA==
X-Received: by 2002:a5d:4488:0:b0:317:f18b:a950 with SMTP id
 j8-20020a5d4488000000b00317f18ba950mr6916157wrq.26.1692721481049; 
 Tue, 22 Aug 2023 09:24:41 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 k14-20020a5d628e000000b00317eee26bf0sm16330839wru.69.2023.08.22.09.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 09:24:40 -0700 (PDT)
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
Subject: Re: [PATCH 06/17] cmd: sdp: Reorder variable declaration
In-Reply-To: <20230819142407.49632-6-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-6-marex@denx.de>
Date: Tue, 22 Aug 2023 18:24:39 +0200
Message-ID: <87bkezrqns.fsf@baylibre.com>
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

> Move the variable declaration around to improve code readability.
> No functional change.
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
>  cmd/usb_gadget_sdp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/cmd/usb_gadget_sdp.c b/cmd/usb_gadget_sdp.c
> index 1af82e11366..784d1b49768 100644
> --- a/cmd/usb_gadget_sdp.c
> +++ b/cmd/usb_gadget_sdp.c
> @@ -14,13 +14,13 @@
>=20=20
>  static int do_sdp(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
>  {
> +	int controller_index;
>  	int ret;
>=20=20
>  	if (argc < 2)
>  		return CMD_RET_USAGE;
>=20=20
> -	char *usb_controller =3D argv[1];
> -	int controller_index =3D simple_strtoul(usb_controller, NULL, 0);
> +	controller_index =3D simple_strtoul(argv[1], NULL, 0);
>  	usb_gadget_initialize(controller_index);
>=20=20
>  	g_dnl_clear_detach();
> --=20
> 2.40.1
