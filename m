Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B3DCA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3908307F;
	Mon, 11 Aug 2025 18:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YIl/Favn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A136831B4; Mon, 11 Aug 2025 18:52:07 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662F18304F
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76bee58e01cso5375239b3a.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754931123; x=1755535923;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LvkfpLIMSkIH6bHC7oomkhI90X/U5MYt4l7LvOTKTQo=;
 b=YIl/FavnlgSo3lZmTXeNckY6sb+3xrh1DAhTotYsSwDFlJU8CYZtQuNIKl/PRpHV6F
 VTPj1w/BNhX11LPqgT7VSpwydTFwUd0MPse+VAWTbHQGWCcvVzvecy/zZjyzAjQtL/uD
 LsxMi38aEXu1Tm8a/foZzKNbuGa+SZS1aKVrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931123; x=1755535923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LvkfpLIMSkIH6bHC7oomkhI90X/U5MYt4l7LvOTKTQo=;
 b=AafR6Af7ATnvKJKGCfNfY5uBSquFPdWDusNpVp2ijtXe8tncJ1/snDegAW4VluB27v
 l87Nw7NE3uExVUtr/k2r5DmDIWZiCK5hq/tnL9jeXMr/Qmhpp7nXwYn2URg6aCLuvtM4
 Z0NcGSTlskI/W0QQ+LBfv5hrLdyQxLlFmgZMxbi2dCHP6k7DCkT/yXZ2iQ0hFPf4oXxN
 ftA0K2AQ/5lMDhn1GJIYCVUaS6vuRl5ASTF/iY/yFMHkhi2WrN5YEVABdYZxoeAePogM
 8TVeG631shjvfr8huQe4tTZC4EOQ0WpiWJXILDRqf/pFgKsz+5vu7KPO7vjV02GTCGF5
 fL8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY2WUefIZvx5FBD3Yir90ojjkiWSpv5LcDVAVMHSy1nQHd5hf2BVoBwyPGLjszpeXRylh4cGw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyna8HsyQIK1g6gyOACLiHKFhENah9RF1Znqzzhm8n5Wk+Iffhz
 F6TaIgx2oJKjHLXEUkpdc1akhM/TcKGYseAXBE9Mww0Fft06pX2JeQdhCPwMNEijy+6XNNXhWkr
 v8x9poJrc9zamw0RHFuNd453KzHwusFqfomE94Nk6Ow==
X-Gm-Gg: ASbGncsfVkT2JjNM6wlEhxkq99qGWP+MD3T76hRY9TjopDW14GOZycmXLgCNtt/C8gi
 uz3AMEI1WvkxBhwFuz9c9Hfyiu6hT44yVAYHc7XaUXsCbitYLMNThw+WsJa0okb+SU5/eAbArFy
 BxIwEJofEByzRSZHfyPprnA6DOqmmJRZTelgr8KVDHpVQ1o9nJ7BGhWk6mQrglhHi6TF3m7ARxR
 6SoXZDVh96ySNXHneHp
X-Google-Smtp-Source: AGHT+IHWoXP+RyePuEGoYUWY3CBGLPTr3zaC6r+57zhJX7Ngue5YvKMtRvkeOge1QfPEBw99NchuMqOcjAw8uYvEycA=
X-Received: by 2002:a17:903:2ace:b0:234:b123:b4ff with SMTP id
 d9443c01a7336-242c2011167mr201785345ad.21.1754931122694; Mon, 11 Aug 2025
 09:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250806181450.2324488-1-dregan@broadcom.com>
 <20250806181450.2324488-2-dregan@broadcom.com>
 <1b0c1d33-8d43-457d-b81d-702a9f7e7bee@cherry.de>
In-Reply-To: <1b0c1d33-8d43-457d-b81d-702a9f7e7bee@cherry.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 11 Aug 2025 18:51:47 +0200
X-Gm-Features: Ac12FXypz1x3m5gfjfwEygZX9nXMilTvQNJebtOdenCIbljKNnfoxslWV1tHhts
Message-ID: <CAOf5uwnwZ2Tfi1gAgaYO-mYV8CUq9UapN8b=rgnObk53VLiYmQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: david regan <dregan@broadcom.com>, dregan@mail.com, 
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

On Mon, Aug 11, 2025 at 4:08=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de>
wrote:

> Hi David,
>
> On 8/6/25 8:14 PM, david regan wrote:
> > bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB since MTD_OOB_AUTO does not
> exist
> >
>
> There's also env/nand.c which uses this, can you also fix it?
>
> Please also add:
>
> Fixes: dfe64e2c8973 ("mtd: resync with Linux-3.7.1")
>
> To the commit log which i believe is the commit that introduced the issue=
?
>
> Only a 12yo bug you just found, nice catch :)
>
>
After I get a Fixes:  tag then I will queue with other patches

Michael


> Cheers,
> Quentin
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
