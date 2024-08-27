Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E660C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84CA88A27;
	Tue, 27 Aug 2024 20:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUFkWGgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9332188A4B; Tue, 27 Aug 2024 20:49:22 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7417E887EB
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f3f25a1713so69131861fa.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724784560; x=1725389360; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xC5qYmdeNfmxeTwi9D97ku95qNLSj/xdxLUkE4ikeH8=;
 b=kUFkWGgn8j95fJM8ySV/oCx2tfKMidp0bSk9llinLWx0D2cMFbNHVQV/0PFCIaAAOJ
 lhSRZtVQJM/w8ajXoRmeL4pV4m9px/XJB2arW2WgG8vE6zj73dNVOhJhjhLX/vI4d9Ks
 GI7H57B1q1QeHwM82kytGARodRewxbb9fSvCR8jZS4cyLKVhD+yx9Xy/yDHUPi44nxSH
 dZohcrt2TwSWy3zpxFmLxc40Or4SViF+cAFfitBt6Ps8l+tWihQs3YBGBORrQdfV7W61
 M8MnhVRFDGBF+AIBlICOsU/EGcBHtNzzPyo9Zfs9XVct/El62HnbCaK6lFcIiIjTK8w3
 +4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724784560; x=1725389360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xC5qYmdeNfmxeTwi9D97ku95qNLSj/xdxLUkE4ikeH8=;
 b=MW2diOurW2XuRwL2nw+LsT2pHNJcUvRQ5yFeVSZlnQwNz88ADaS0mLFtAsMvHz1Wdw
 507oMF8/XSER7D8SAzbWgDDeKzOuqLKDKtpOHUIiTMKsXKky9a/Cwni1tiQWk6CKe4Wk
 S5TzuY21Kr3Mmz6w6FqwZnGi25/fJ7AfvfximU7CNKSglzvsxxCupjSRIw7NG8xC3b7i
 96UKRHrfjF/EUV+zfIJJh0ED0dXi7EF/rx0O0SbFNwmxy3N+q/P86Rp1Lr4rApX/H5Xt
 v5vhgDbBjfj1DHAcApe2dFNSVkXF9OqAbklQtbRgm0+lgf4yNaVn5zS2fB83M9FzhPuh
 sAUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZKtgHNFjgrV8NO/JcLZZGyjnTJ7FEnugzcgjE7cti7ooiYfxR6Ra+ipPlns5b0V/1q/k32pg=@lists.denx.de
X-Gm-Message-State: AOJu0YwRZHWUjIyVndO5g/R2jfA7XjX4r5CO3WGHSQ5Bp+TZAg546OUk
 fuzA4hRVKQEXtM4k8ovBM8Yr4vCK7k3+jGl1CP1G1r/nNzqqKCoL8F0UP6fzEHNWXJofR5nRUZt
 EEUXkEjLao/PSSxQAaOq3vEd7Lhg=
X-Google-Smtp-Source: AGHT+IGt+paH+tURK/i+fq2iQidOnfW5i2Y9mCy5lC9Cu4YpXqA0BOPwvvTBen/iu1EG2QxJOCk4URgzhcUDLC6dEkw=
X-Received: by 2002:a05:6512:4002:b0:530:ae4a:58d0 with SMTP id
 2adb3069b0e04-534387557bbmr9903066e87.8.1724784559279; Tue, 27 Aug 2024
 11:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145944.3048128-1-lukma@denx.de>
In-Reply-To: <20240820145944.3048128-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 15:49:08 -0300
Message-ID: <CAOMZO5AAfn7zw1+VEGjdS6UAQLv5kTVT97_dy_oxhauntYeHvQ@mail.gmail.com>
Subject: Re: [PATCH v2] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's
 imx8mm SoM QSPI boot
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com, 
 Cem Tenruh <c.tenruh@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>
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

Hi Lukasz,

On Tue, Aug 20, 2024 at 12:00=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wr=
ote:
>
> The image offset when booting from SPI-NOR (QSPI, FSPI driver) is
> different than one for SD card / eMMC as extra space (0x1000) is consumed
> by FSPI configuration header (CONFIG_FSPI_CONF_HEADER).
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Avoid line breaks with defines

From the other thread, my understanding is that QSPI boot is still not
working with this patch applied.

Please resend this patch when the QSPI boot problem is resolved.

Thanks
