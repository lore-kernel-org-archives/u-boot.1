Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138CECD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C67686A78;
	Tue, 19 Sep 2023 09:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jYclY22K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0CA86ACA; Tue, 19 Sep 2023 09:20:13 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B4986A81
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c00c0f11b2so28552651fa.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108011; x=1695712811; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRKdWDfK3dzksTU8ZJHvwNeMiXPus2JEuw1GvXkDcsI=;
 b=jYclY22KYKUUWUSRO7EA5Y5Ycxq4ez1T0qNPhKXwl1dCQTSCpeHrOetyffSpXIUaLe
 2OWxACRPV1mCpsJ3kzuf4COICSlkto8srUcZvKuH8zdcAYjZzwq9rvpF9qZUIHxg8APj
 W5gftHpIZDzrZVYWZ9DuuzH5qmL0fBwBjlaeG5uPoVCQrxWfbBt41ybKVmFXqUUfe9sw
 wVdqI/MLL62Wp35E0Knf8e+2PVTJaRiA7tOQphoASJA9MkTg9YaSgDk4X9uaiDfw45ft
 6Pz3wao+KwATy0Qg59LcIed70cLKzdRfkFLqNxceyZOKvQgycDBy7NXPFKN1tIq6DZQR
 /RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108011; x=1695712811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRKdWDfK3dzksTU8ZJHvwNeMiXPus2JEuw1GvXkDcsI=;
 b=m35AT5LQ3cvHayTuvSmu8aIx/juN1P7tQW4TGVKgNUUzQ4Ujye4nic5r/hCdCf+Ph3
 hY0YuaAHAHbmaESfBgojhPVJELO+0e8k42Yo1fa5Fn+3HBRmuEuSoKBMq2xo7kg+rQk/
 ls4XA3UPhayZOmBgKTjWiKGQBIcDSzPRc+Mn8A8JC6EFKnxYFOwwYSTmlwmjfK277HG4
 MqObOcibCyPMZMybxOqY+wD+8ya4YWfYVtcEfmL3ha4MImLmcq65w7Y1eRHTo4f5IVEF
 bCx59xhp4q9j+MAr8QfIw7jaYJaD30VzVXkzC8DCZ5o+Perw5Pb59blcELq9z0ZW/hqa
 VvrA==
X-Gm-Message-State: AOJu0YzVWlP+kqLIQ9+dpZ1shadZaZS5aSUQs1lUlsCHGGzGoBueABhy
 K4CNVccm10hJ6fztMIDS5XfBgST7WRW/ttpGlZo=
X-Google-Smtp-Source: AGHT+IG/J4e0mhSSX3dzGN4MU5WSmRcHhG0bBuujniKfOoPi7RVOUwZ1r7QOGHebccauCBcOPmfvtwi+yjWTuDbJZuU=
X-Received: by 2002:a2e:964d:0:b0:2bc:f1d3:b54c with SMTP id
 z13-20020a2e964d000000b002bcf1d3b54cmr10214637ljh.20.1695108010999; Tue, 19
 Sep 2023 00:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-15-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-15-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:54 +0800
Message-ID: <CAEUhbmXKXvU7poM6paK+9HzgQ4w=fidoS4HAGBbM6nND6fP1AQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/20] Record the position of the SMBIOS tables
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Remember where these end up so that we can pass this information on to
> the EFI layer.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Fix arm and riscv
>
> Changes in v2:
> - Add new patch
>
>  arch/arm/include/asm/global_data.h     | 3 +++
>  arch/riscv/include/asm/global_data.h   | 3 +++
>  arch/sandbox/include/asm/global_data.h | 1 +
>  arch/x86/include/asm/global_data.h     | 1 +
>  arch/x86/lib/tables.c                  | 3 +++
>  include/asm-generic/global_data.h      | 8 ++++++++
>  6 files changed, 19 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
