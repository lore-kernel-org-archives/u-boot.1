Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F9AE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE34A806FB;
	Mon, 23 Dec 2024 14:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TOsZifdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D1F380708; Mon, 23 Dec 2024 14:20:07 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2374B8062B
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53e384e3481so3835480e87.2
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 05:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734960004; x=1735564804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gMHAGJRtbp/nHJbyFGPqBBbq/RwYIyzfoPMTkvQnH0=;
 b=TOsZifdZ949GTEj+wbyWocZ9p1FSbIPkp7uuyfodbz0aFQsqcvEu7pwFZhl2GTBaCR
 bvwsyaFKq77e+H02IvHx/i0+AumbH92e6XDnTN657kALEhzXhfqTri7sW8sP6msxTLcf
 s+xAj/T9XHTmSm0ix+x47KepDU/g/Rdq4oHteCLtml+Ac99kTOVznhvHvxX7WabWv17e
 sEsf0et3KbLp6eYmKexUootC2fK4Xpimts6lyjGtpz6a+O1o6xLY5+hfAcNHWRCrrFTG
 oXgdl/gA1J6KKRw97fMFpYOZRxFZHdYTIvofMetZvydqKGCNxZ39lDVL+px8P6ToSSa0
 dYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734960004; x=1735564804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gMHAGJRtbp/nHJbyFGPqBBbq/RwYIyzfoPMTkvQnH0=;
 b=vOtsTvCBjFTsz7b/htplia7WyyGyi5gCStMrP4fzhckwhjA0zfWow0VUZLGGbnRU+Z
 TY6lNct7YYJYw2X10cbR+Q5pZ5qX4sLx1ojztdez4kUQIu83KxfLXVu75brdYFVUXRU+
 GK4doiwFzXjxxCtTaFaEqiNGuVcJ7tWT7K9aDUGDMtkjYHQk5Qu0E+yJJRTykU/q0lDi
 DTEctE59mYCM4ez+CgX2Got/M7Hz56+MZir5cEGWJXF6FFZNrPfRan8njmZkDUJjg80t
 75MXCLKqKU4trE7Dc5qG0bo6hr5dLgpp1RsRGt7/qHxNGT+zCnz9Gp4uFeACATAXcwTt
 I4mw==
X-Gm-Message-State: AOJu0Yw0K04WX/2kYtdQZw7oLBmgxIs8e6knilqNXwis7Rj/SZzzfVnx
 sRqWRetB6DxyfgFkWmz0cdJCjK98VX7mHszHLkmzipQ+X9uwfUjbbgQ20XfHKvz+2lsF8NW8iJq
 K5Eew7PTHtayYJTqDF+Ckv6mkGn0=
X-Gm-Gg: ASbGncsRVtemd6BYKwex5txVlGo/JSsCd8CevUdeTo5BehtxgrP5klobtVFTlmIt/Jh
 D6tOIU/0ka7Q7X4JVUPmNan54X1z/A4+iT+XqZVbTFV6jFjj9sObwKdsuoowFGYVFZK1u
X-Google-Smtp-Source: AGHT+IEKAs5EjDdxETiHWKRg7038xcSr18ATYHJI3DydFzOCiJ7uUrpNNL/S0rzbpN59mLdSVgKRSuxd8POSANKnnPE=
X-Received: by 2002:a05:6512:628e:b0:542:2972:4e5c with SMTP id
 2adb3069b0e04-54229724f84mr3781680e87.19.1734960004317; Mon, 23 Dec 2024
 05:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20241218194542.1867618-1-tharvey@gateworks.com>
In-Reply-To: <20241218194542.1867618-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 10:19:53 -0300
Message-ID: <CAOMZO5Bh7BkQBArL+evDMK8GbMMLtq7Nbrp=_RhKheheQS4Q4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: misc: gsc: add support for fan controller
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Wed, Dec 18, 2024 at 4:45=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add support for Gateworks System Controller fan tach input.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied both to u-boot-imx/next, thanks.
