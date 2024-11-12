Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3C4D32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64A589449;
	Tue, 12 Nov 2024 19:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="gi5fgm/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A6489294; Tue, 12 Nov 2024 16:57:24 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A728915D
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so44765811fa.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 07:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1731427041; x=1732031841;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMMTvJEQvojOZXrYNKhJlKvnBYUlEVJWJIN5mFtaJ4U=;
 b=gi5fgm/4Q4ZJvpW0+iUiUk2ABM7y9k0d7geq2ArKYnL6OkyyULcRJRpya1azRbhJ1W
 NQqsl3ZGQC1DUx2pNGoYMwenBtTdaFXZeTm6WA/vaKICfYVS8nCttkFPSfoBm5UeHFPI
 8FNGzu3g0S/SEple9pjWrsR+VlKSDgPqt3dTC13kzUjkHRNe1fWeMU/xSz42IXmY1tQd
 U++jIhRcpsWnb2ldcvJ79zmz5TJOrsALkTWljCjYST6iyqtWyEnZtlErrfAgon70nTzd
 IF9PqlbFcd7U0H0gEQ6X4YM9sM+LKVUWDpDcFrDRLjtbv5/dzEnrutzBpbRbrn1NURJ8
 XDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731427041; x=1732031841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMMTvJEQvojOZXrYNKhJlKvnBYUlEVJWJIN5mFtaJ4U=;
 b=jja53tagM1gRj3UGyoJpKg9KDdH0CpdLqjfYr0325bTMY8UYLA/x1EeYhDU6J6Lr4F
 GiL3SqFAoCKQpAUyiS+wTNA1FWpj/hPG4ejdzZ5IfIuO7yJCjZqnfIuiIZUwL2RdxW1T
 syMWqpHs3YBc7c6bg3SSmnLfK03Cm61oThdsoF4L/JfIETjlm/VzddcZKFnoig7h7mRT
 xiLUjOC9dsRh52e3a+cS+sTh8xuG80rpzUz9y4ntTVilyX2GHS8fhdwmQ7AYr4c/qcw7
 Kvxlt3aj8emZWkvTbgCHqUMeuboiFuMJiXT/naw8CrihxlCvTwFiLGphFwfAaUfZtg5X
 Zi1g==
X-Gm-Message-State: AOJu0Yysvdl0SBndBzj9E8ZIxcrR/rDyQKSHT/WZMkmZWIQLl+5nQAqy
 Y0ALUnWyYkG0LEfsSC1uFtkatyIeqTrMZvC/LFTupMFAc+QD2BcPZS5XClopjM743mg8aT3iZpR
 Js2fJmRG/FCOOYmCc9V/gC9QACLb2qTn0PSyFcl0VpNr3Yk8apq0fqA==
X-Google-Smtp-Source: AGHT+IFoBxqny5yTRmAErbbqDE5Gr6zYmDtatnvqkvYQrIzJOPESJ0ZDg0tTc4Vb0EfLl9jF8Wzg8AnnBG+Sv7KHARs=
X-Received: by 2002:a05:651c:88a:b0:2f5:2e2:eadf with SMTP id
 38308e7fff4ca-2ff2021c215mr84095961fa.10.1731427041397; Tue, 12 Nov 2024
 07:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20241018202715.283011-1-admin@hifiphile.com>
 <2637a7bd-fdc6-4102-80c1-43d0d058cd97@linaro.org>
In-Reply-To: <2637a7bd-fdc6-4102-80c1-43d0d058cd97@linaro.org>
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 12 Nov 2024 16:57:10 +0100
Message-ID: <CA+Gyqebjmuiwn0UyUEJK0vh7wimTkGXPeVCrf7feYxzFLF_Oxw@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
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

Hello,


On Tue, Nov 12, 2024 at 2:13=E2=80=AFPM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
>
> > +static bool at91_get_port_pio(struct at91_port *at91_port, int offset)
>
> The name get_port_pio is a bit confusing, can you rename it to something
> more meaningful, like maybe is_periph_func or something ?

How about at91_is_port_pio_active, more inline to the datasheet.
