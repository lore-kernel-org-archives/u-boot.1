Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C96C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 10:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4E6C88987;
	Mon, 29 Apr 2024 12:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DVU5YXC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B688A880B5; Mon, 29 Apr 2024 12:38:24 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E1F8898D
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 12:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2b1e620de65so151360a91.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714387101; x=1714991901; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGaEHsdO1/Bq4lXnwjstKmsThrkRqVrwaSVejNO4LoE=;
 b=DVU5YXC24f6gWRS3vxie5gdLypUzdFqvd6cB7CDWc1zXipkQ3sN/IDYUbcJ3UyIdCh
 sX+CdjsVJFKQVXE2imsSDUSeis8Io9NDf9UmEr3xuCUxX9dZByXS1TpHT+DChGEaXGf+
 m/4HhtnszCeaGooB7FBawjbg76Ijky5QYuiXIbe5o1SIOs13M330v3m1k+S1Ie1wyml2
 qdIYP+bs07F2JwSjs19KT30Eu7fMbk6jq7uBRZ+f5t0FvYqXIqAHUXhSmsbkRkGdCsGC
 yy2EhyCY6wDSdlhmisoQmrZ2TSr4cWIToMyxE/OV3IBdz78mH4jtYVm8JTODsaVJ5alH
 t4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387101; x=1714991901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGaEHsdO1/Bq4lXnwjstKmsThrkRqVrwaSVejNO4LoE=;
 b=QPwlfSLbbksafWXDMGyeZl7d2D85OuJnlEtYdkosIyKCtElVqODEl1V5Zmbo1ltYv8
 Ee+MD9SivbUIuwfms9lopkFnzdM4jILYuB5CS+OcH2fN3+iSk9Lt1ARZgWE1ov3JzzkS
 wxVEsLg8aIhvvT3M8fX0jmh8tLZRuM3DrQ0H7vrUoLJQJuJXGMgBjeHBchScBihLzvbp
 oqbN/ldq0BD6/m/0Vth8bGhcKufRxeOfxx+Yt1TlWPhWSRQKUfEKFgyfNUB0JBCoL+w+
 NAA/Kn6TWibgV2FmjT/M50toMwFifsUXgn3BzyL6joROmgEoX7uKpEQpG/hIYUqrtby5
 e8Lg==
X-Gm-Message-State: AOJu0YwOiSavQLq9adpIP0DHuYbIqtDS4xMIEtLWFCamXUIAc4fSv+4y
 LH3B2iumx9Br9Opx5u+7Q85Y/zCr1iAeo1WkJrbwXSrw2fvdm5R+JKOo9gug3+o6ALzmbk7DH8R
 k7oU7C5D0LulCdll+OWvR4emVyGQ=
X-Google-Smtp-Source: AGHT+IE+Q5AghR0+mgA30UWUZrjkxVtecPUOkDGTCiISQR9BKJTvEp3dyAsI7SzgfwNhgP5qn9xd+TPolcEtbMVwYzE=
X-Received: by 2002:a17:90a:c301:b0:2af:8f41:6ab7 with SMTP id
 g1-20020a17090ac30100b002af8f416ab7mr9518385pjt.1.1714387101035; Mon, 29 Apr
 2024 03:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240425230102.497160-1-marex@denx.de>
In-Reply-To: <20240425230102.497160-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Apr 2024 07:38:09 -0300
Message-ID: <CAOMZO5AP-4au75uJgxfvA2gYatkHCnNm8yzuuE7QG_XbdtzaDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: Add nxp_imx8mimage etype
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Apr 25, 2024 at 8:01=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add new binman etype derived from mkimage etype which generates configura=
tion
> input file for mkimage -T imx8mimage, and runs the mkimage on input data.=
 The
> mkimage -T imx8mimage is used to generate combined image with SPL and DDR=
 PHY
> blobs which is bootable on i.MX8M.
>
> The configuration file generated here is equivalent of imx8mimage.cfg, wh=
ich
> is the file passed to '$ mkimage -T imx8mimage -n imx8mimage.cfg ...' . T=
he
> settings generated into the imx8mimage.cfg file are configured via suppor=
ted
> binman DT properties, nxp,boot-from, nxp,loader-address, nxp,rom-version.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied all, thanks.
