Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF78E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 12:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D479806DE;
	Mon, 23 Dec 2024 13:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QuG3MhoE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17EE2806E5; Mon, 23 Dec 2024 13:01:35 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182EC80562
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 13:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3022c61557cso51598451fa.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734955292; x=1735560092; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6av5U8ktpLkaVvYz8z/vJOn1izT4YLKwdH0LTmh7Y0=;
 b=QuG3MhoE5vHeQqVTuFBK+lIhOCVVcCMAb+O1RTiU+q3PgZtR8TNdeoPYXuu0cCZL8U
 mdWoJHnEs2UogUWiADci1IR17/+BIIqj4P7wo9o4ixLrrnOC+tWIZ/CAokBCWIEVm33t
 Sw4c8a8xktPZJBvKPLJ/uU5LQX1vJkgt3S8mNrdR+H+jmMhs8FVXUYNU4iRDi/QVP78c
 hFdM6LtE1IG6eH0kEmNt11UUaJ9UW5d0oQpE8255Lm5z7AYkbmm0HlkbEuinW+f3T231
 ivyOmne5scBx4TKYBwQj5xlNzlx28zfLvu6ruYNGNPL0IjW84HNVWcsqInimWNezpNMP
 AXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734955292; x=1735560092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6av5U8ktpLkaVvYz8z/vJOn1izT4YLKwdH0LTmh7Y0=;
 b=PYHOTI1ohnAhd/axVTvxJHfFkG7WuQcZnE/Cta5RvYNaxBElsTjjdBmI4vOepbaztN
 HmX870QI5htW/Rom7phwimxu86ZrW1p2uY2ny/fIVjYksvrTm3xO0+AAay2PhJvXo9fm
 vesum+74Rcpxy+vApYrgOITYCmtvMShLV33fYibVdSQPWkwyHGz5JhlacdBc+TiMni/K
 bYIpTvvY/ntXEIivjfe37mzuD1PrWHM0Zz4+4BV8P2eyRzLNi2IWsNGkBls7WXDiDtrd
 bPsZ/K3mU+AoQpuCZifIgjmlovJYG8sQQ2Mp4DETZ6XTMif8FxYxk+UbmUKRrk/wSi9L
 bKNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO7z46e03rwJNMdE0ezq59E5cLW7RpR8Guw79uID6FY1u165sp3hBkoUj2UXGxQJ6Csk0Sj8U=@lists.denx.de
X-Gm-Message-State: AOJu0YxgprsFEdSmOrQCnyncogedmhNwi1Q2cpcY4fxFe5aOxoEMQs6L
 kqJeS1Gq2PbKv4yT7VecTtY4hBrDVKp88TUBp9Sj630GEBj8FkbJtTYsoIttHDY0ZhZD+SQJFjl
 q/mAr24p5qxaGLrUKh9c1RJbycCA=
X-Gm-Gg: ASbGncuIkS4r/aTrQipkdDCt8+lXsOfDKdh1BNtGNd4P3WTGAPYS7XpJqFwwPMtf93t
 VJx0izc2YVQGMXIzznDzzxEVB+pZCNFFENRTO2n4eGl85fGiil05R8NJoccS7pJ7svOep
X-Google-Smtp-Source: AGHT+IGQ09HOsfyd0LRVyu9X/0aFNiXiVMBn2iiQ+NfStz1fIWKxwqDEQAIIf3lNN8lk+q6oiEWFfvMp6wdQRnRz2Fs=
X-Received: by 2002:a05:6512:334d:b0:542:2990:6e9b with SMTP id
 2adb3069b0e04-54229906eb8mr2902948e87.14.1734955291930; Mon, 23 Dec 2024
 04:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 09:01:20 -0300
Message-ID: <CAOMZO5C2=Te+z7huEyTFStBaim5r6Ea5d=aqSg3AcST+pUa_GQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, 
 marex@denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
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

On Thu, Dec 19, 2024 at 11:56=E2=80=AFPM Alice Guo <alice.guo@oss.nxp.com> =
wrote:

> +/* USB configs */
> +#if defined(CONFIG_CMD_NET)
> +#define PHY_ANEG_TIMEOUT 20000

This should be moved to the defconfig file instead.
