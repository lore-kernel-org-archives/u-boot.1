Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF221E95A63
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 12:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A8886A19;
	Sat,  7 Oct 2023 14:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cceXTlHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA3186A23; Sat,  7 Oct 2023 14:51:37 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD948477A
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 14:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c76ef40e84so5765115ad.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696683094; x=1697287894; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHz5xtWOuY+DlAFRla14Vav10EDP+pDjAJkxN2C3S6E=;
 b=cceXTlHse0Bu3uuaonOwU4/cZcAy2AB51wZRu7u8Px5ZAyhUZvJBCN+b6BPXf+kffD
 L8CQ8soOTbvQ3C4CuF0WYkwWBAwUP3IsQbWlPj+KJqbdi6SWlxn1pU4CjnUjKUzGgND3
 VLaad1LdrYF9dR/QVou6jQr82BoIYPN0CjpdCktEMDIoU3FPZ6eFRR6oP09SDUZe/7Uv
 4J7GQtLsk6zs0vLV/Aznrk06RsUERnyT/ExMUXTQMCebjJ7dvWBwBF7qdbCQRzWrLCUG
 PMxC63nDSpFmRiFEnKEI0zFNrfeOc6NsHG8fTN5T9HXza71rjfSlboVAZx8fWF7VRQ+a
 sm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696683094; x=1697287894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHz5xtWOuY+DlAFRla14Vav10EDP+pDjAJkxN2C3S6E=;
 b=UAnrMlc1xvEVwCBiGJl/3QMbauQjfF5TbYzRGhwaAOWZljHE7e5Jk52GMigafw7cHv
 2yrr9nE8LE4x6W8KfLiAIj2ovqj4OOVyGf10YSYjK02e3PFxxP93gNZCagRkGhQTHdXb
 lYPy/pSer4cKmKFLPnteucOuRRVHUSNimGbYCIXE/UOrNm+y7AfWbb+78Hsqub6x67JU
 +7fTTCjdK/cHG8rav4LXSDJZOBqfVJEu4Nbxz+8N6LeqzpR4oalLVOc1+7vIer6hXPi7
 Jb0aoqwYQf0dsUbGoL/QhkSO7O2+fmOpIR2kRmH1OMWHLXSySYeydpSd34Fu2SKPSn+v
 i41Q==
X-Gm-Message-State: AOJu0YzG+53+a7e8C/YNZWtI4ITgfapOvSbx+cDC5t8R9b0GXjptkLFP
 J5NrWrKt4D+y1e9+jvBUeLbjLnnFLajcEi8+lZvtVr+P
X-Google-Smtp-Source: AGHT+IHiJlKxrCt7cVACMBsShYVj5HR1oIud4EDEjAMwU6wmneVf2uRxFKNcoMLaYu334HO4l2sMk6LfPxHaud7/kBk=
X-Received: by 2002:a05:6a20:8f01:b0:15a:2c0b:6c81 with SMTP id
 b1-20020a056a208f0100b0015a2c0b6c81mr12284729pzk.3.1696683093752; Sat, 07 Oct
 2023 05:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231002115749.15160-1-hiagofranco@gmail.com>
In-Reply-To: <20231002115749.15160-1-hiagofranco@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 7 Oct 2023 09:51:22 -0300
Message-ID: <CAOMZO5DP5gZvQyBeNdOu9hxf2_JsUddDXhkr5yW9PEA6mpOTKA@mail.gmail.com>
Subject: Re: [PATCH] toradex: colibri_imx7: Enable nand/emmc detection and set
 boot variant
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de, 
 Hiago De Franco <hiago.franco@toradex.com>
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

On Mon, Oct 2, 2023 at 10:08=E2=80=AFAM Hiago De Franco <hiagofranco@gmail.=
com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> Add detection of eMMC vs NAND devices on the Colibri iMX7
> board. A GPIO is configured to detect the presence of an on-board resisto=
r
> that is configured differently based on the flash memory used. Depending =
on
> the detection result, the 'variant' environment variable is set to '-emmc=
'
> or cleared, indicating the type of storage device.
>
> This enhancement improves variant detection during system initialization
> through USB recovery mode, where U-Boot is loaded directly to RAM. This
> allows variant detection for an accurate device tree selection.
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
