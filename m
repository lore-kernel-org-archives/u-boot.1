Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25066D42BBF
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E74A89454;
	Tue, 12 Nov 2024 19:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="qfqgQrux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B17589270; Tue, 12 Nov 2024 17:06:38 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9AC8862E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 17:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso50023001fa.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 08:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1731427595; x=1732032395;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Xibiz3MxLmKK4pW71ARrhkrJJI0Q8yQEuyCHlAxV5A=;
 b=qfqgQruxJGV14bxsOEXkJd1skGcZOcmV4p8BZuOjt4BW3uejeNQs+M7pB8f3U7w4Qd
 Zh9kUo0MlEJZluFYi2SBY+VIOt/gTTQVSOK5XIY6kydICSZnnU8PXwy0UAecaD91T3t5
 rYQJsKMgTaUqx43ffF1FgVF1Qi4SuO5Z1bRIdSFieGxfhZrQqSNFXZ4U5fJQ2oZwX8t5
 /rxLFClfIlmSs5VXwYeZihN2TsApAj9uhT2b452tsnl6JW/148O6fclRRxYc0Bqf/AyV
 j/gC4V3ghCValcmzYusv+6gKah7jpXqRkE/D07UglMRHwiFA2KcX+GEyGtOtD31L6hoU
 ouzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731427595; x=1732032395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Xibiz3MxLmKK4pW71ARrhkrJJI0Q8yQEuyCHlAxV5A=;
 b=dYhr7B3ngjeWsPXvpYkdo1X1eXkFD070QE4AeHsKN34niA7D2GjuCZEx6jqoGWzQil
 kt7z1zGN8hboUudDW0FZYlxNxDQ0vLj/8/Q28VMtLmxTEZYPTNFJiMy/CFahPfFk4GXh
 3JjMFzlAC3FWf1V6R8h7Jw+yxhySOAZzkFg31CQGMse9bfUrlniSaOs7FZ1Tn0ojpp86
 sbs3IxTphauQwpy2EHLrOCUFIQcyIQ5GC+wvzvmtWBfl3UQ3jN6uKzEWQEKoaS0+vSSS
 ZYDgZP0PYQr2KDuYKEQi/NYPFtXqVlMmbiCijGNY0wmOFixO4Y8Ofb1ekqS2U2s8fuR2
 secA==
X-Gm-Message-State: AOJu0Yzfx3x4F0HTKUEtMiGZiQVDruGvT6+xyJx8NEiuH+lpa7q3q91r
 IHbaAJ9nbiPOe4RXKJBMjF5obpmVYnjHCs+mRRCw4rsz8/GnputWapMSj+yW3a6u+tD2hSNSBmy
 BaJqc2U7IcfvARjh725F0ZQi8R40p+nPKAucEyg==
X-Google-Smtp-Source: AGHT+IFHs0A/QHXZA1Q+P2Zk+lHUZgduBQYDkJeeL+jTX3AKkstGTdv3wHYX7e3MOBze9ilrnYs9WYMLBGNvyh1ewiw=
X-Received: by 2002:a05:651c:1602:b0:2fb:5ac6:90ef with SMTP id
 38308e7fff4ca-2ff2016213fmr95570411fa.11.1731427595572; Tue, 12 Nov 2024
 08:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20241018202715.283011-1-admin@hifiphile.com>
 <20241018202715.283011-2-admin@hifiphile.com>
 <100db945-f3cd-426e-860d-98c01cc6bb41@linaro.org>
In-Reply-To: <100db945-f3cd-426e-860d-98c01cc6bb41@linaro.org>
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 12 Nov 2024 17:06:25 +0100
Message-ID: <CA+GyqeYHkahrhBdQF9ZVSa7aN-uTtdVQr76J8vdEeTA5f2A8Nw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: at91: Implement ops set_flags
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

Hi,

On Tue, Nov 12, 2024 at 2:21=E2=80=AFPM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
> Does this change the current behavior? there is no set_flag ops
> implemented, previously it would use a default that would just return
> success regardless of the given flags parameters ?
> Btw maybe ENOTSUPP ?
>

Currently without .set_flags ops it just returns success regardless of the
given flags parameters. It's problematic especially when pull-up/down is us=
ed.
I've another patch to fix the silent failure:
https://lists.denx.de/pipermail/u-boot/2024-October/569044.html

Most drivers just ignore unsupported flags, I copied flag check from mcp230=
xx
driver. Is it better to return ENOTSUPP instead ?

> > +
> > +     if (flags & GPIOD_IS_OUT) {
> > +             bool value =3D flags & GPIOD_IS_OUT_ACTIVE;
>
> Can you please declare this value at the start of the function, or
> inline it below when it's being used
>

Will do.
