Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE07CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 19:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC04F82E52;
	Mon, 11 Aug 2025 21:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tsu2HOIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D853E82EB8; Mon, 11 Aug 2025 21:08:47 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC138004F
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 21:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-31f02b6cd37so4933336a91.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754939324; x=1755544124; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iZuC/rXTKXTwxLaxsi5g8j4DcipfeU6nn3s4FY1zVWw=;
 b=Tsu2HOIBce7g0S8ko18aB1wkICkS3Togb+NEo2UGXgsqcS7dLaUjkaBJbClDzVUVlI
 2fT1PZhP5BgiI5jXNFqbr8SAdFg61OlgbD5z66UWKo9Q9BMXZKYoXcCRmrtS0ZuwBuV/
 Kfcf7jGzvv9UR/o8zvXtc2MLSYQbpw/iliiQw2IjFTiktiBTY1khfRTg6CR+LBZkUSPJ
 ISAUgEYPF8Vr+U6KGo/ZipHhIvXCBa0FqYx6muvmQQ51F13bxjoMCRlA6q49kYrH6Vpo
 LM0XTu6oEhBo0KTOYSGKW4roX81POtTB3T7DvuP5eYv8blG5MQviEYVayJHYx4JzxYEI
 H7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754939324; x=1755544124;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZuC/rXTKXTwxLaxsi5g8j4DcipfeU6nn3s4FY1zVWw=;
 b=EzTQ8XofqYxyLpoOD0BKHx69/u6c0yI9Df4FW6HlDxnE0IfNTXDm+J8UdbAcFR8zGQ
 MTDamzB9XCRN/L+8nZBhBtD5uS+xeePTDFfbFM5o+gjZ76mqssctkuixHK7vM5ojVoDm
 xAFqXVCzkdVy97U7GXtMifDs171SnSHz/HCBnST63/l2emiU1kUCsRgK8ZdlePqsxQfh
 LM/s/jFzUjgzn1hp+EQ6G2OTiT3sX/XP32Jo8P/JL8j55MmumX5iZGlosHuFzLbQWC1l
 Kuu5tGqdJFb626O4q2u9+wUH/CHYSa+zfvPQLyLsxjBkE0fvkFtj7o1b4g+yBQSSnQP3
 xTZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsDKS40Mz2OvT9KwRYukY3dscNmpKJCw08txJJZ2h3oeI+gwK0uyYhXfmvsHf5UtHdtO2POdU=@lists.denx.de
X-Gm-Message-State: AOJu0YzfByOHts541Ut8s4o4B/X9mB5ttTL+lLCzbCdhorq3BDtmTxXR
 0/T5vhrIzFMDzhk7v2dnj1p/I/xIq7RFIuof13wJYcJqlbsR2PkPlGdV
X-Gm-Gg: ASbGnctZ5+oLeMZoa6tDApXsBVA5NN2sZS07oz6UdxsrjfFIP7ONcvyDyPy0sCJ/RR/
 UyKWI/XfpeBWHpaNkmCVbgitA4MtEsMFPz1C8u+mKqu97vgXPvT3qmG/EsyM/OM1AirNUfYtCN8
 1rpjAvt4eF4STLnglrCsaA7gc9XuAv02n6B41F0C2sny0J83ynvikXl8SY06cZ59iNnpviJCEEW
 lVd5knA8RD31pZl8su/fwyLwcWop2NnbZu+wXf/cwSCtnPQm3OSyUo8CR2h2VNEey4FNI9CTWdo
 bm24WVXXiFnJm/xn2Pz4M+e/+gD5MzxTHZogKYUoLxY103cx5iTCpmMUHjyi33xoAYZnAx+LvJU
 Ln6MHp6t6lJNSd1brvAvb35DDlxHTxNdawlJzc+Y=
X-Google-Smtp-Source: AGHT+IGioaacAGa/+0bGgBKN++3O2zHblHDKOr8PgzzKlnnXkM0Kv5Pv4+FNJ3XrKgfj8+kQvs44+w==
X-Received: by 2002:a17:90b:3e4b:b0:321:6e1a:1b70 with SMTP id
 98e67ed59e1d1-321838a62aemr23376513a91.0.1754939324004; 
 Mon, 11 Aug 2025 12:08:44 -0700 (PDT)
Received: from joaog-nb ([2804:14c:490:1191:2ce:dae9:57a1:9602])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ee49ebsm31538731a91.19.2025.08.11.12.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:08:43 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:08:38 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH v2] arm: imx: imx9: soc: Fix env location when booting
 from USB
Message-ID: <qjwgzb47uxa5i74dcyemg7vwz4a7sisjfnwohihfz47vdaqsfu@i5vihd7yhaxj>
References: <20250811-v2-fix-imx9-usb-boot-v2-1-3d89974e2881@toradex.com>
 <4982129d-c71f-4a63-9330-aca7efb8715e@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4982129d-c71f-4a63-9330-aca7efb8715e@kontron.de>
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

Hi Frieder,

On Mon, Aug 11, 2025 at 03:56:46PM +0200, Frieder Schrempf wrote:
> One thing I noticed, though: For the SCMI case (i.MX95) we will leave
> env_get_location() with ENVL_UNKNOWN in case of QSPI/SD/MMC boot if the
> corresponding env device is not enabled. For i.MX93 instead we return
> ENVL_NOWHERE (again without checking if ENVL_NOWHERE is enabled).
> 
> What would be the "correct" approach and can we align both platforms?

IMO, returning ENVL_NOWHERE as the default without the config is wrong.
The boot will hang anyway because, at runtime, U-Boot will not find the
nowhere env driver (as it is not compiled). Also, if no config is
enabled, it’s better that U-Boot signals this to me by failing to boot.

Anyway, if it is accepted that when booting from eMMC (or other storage)
the environment is implicitly assumed to be located on it and the config
is not needed, I can also update the i.MX95 patch to match the i.MX93.

Best Regards,
João Paulo Gonçalves


