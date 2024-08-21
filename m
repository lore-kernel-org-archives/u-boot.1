Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EBEC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0F988E03;
	Wed, 21 Aug 2024 18:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="e6mKXqEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19FB38843A; Wed, 21 Aug 2024 18:04:47 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1D688B3F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a1e0ff6871so434064385a.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724256284; x=1724861084; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWBrVOkguu24BawjJnqQsyk3e8C5BqDxhmUlKSn9mmY=;
 b=e6mKXqEuvzk1H7X0xBSfDKTBg0Dl45J17SkGygjhDq+wQKv9PRzSsKGWF0STn5Qjq7
 2mPDDGPcUXHRgNOBCVZYcxh/WCM74Z4WwH03ZKvOblKEUEhpR9OdU9VFFdcnFZpZWkWi
 p4MrosU5hH5Ly2AKKhiTs26IRcymwtXUeBiDJqexhL+9t+Y4SoI865o4g7MNhMvBNz1i
 HobyRzambQ4NUE1ll+ylRSaRBCsghEv8Ut15IF/1hvg7tdvGtA7GU9i4xfEndgXib/6h
 vKqJ5jXbkkqds7tEopbdhFKei5VxJpaHg9ihFab57DzueEm98KwWyBEgBIUL3Rv5ozRv
 fbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724256284; x=1724861084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWBrVOkguu24BawjJnqQsyk3e8C5BqDxhmUlKSn9mmY=;
 b=jFjCxAsh3H3bmcx2gFeqhCGU2gkW77zVcLJYmRxmfgOBkFVIVB0z6hHvRQxeUOHZup
 wPM1JOcoEX14egyv6fEebz+STHSPm75K6Im0o8tVEqlTs9Csz+c4a+UiaopaUCn+uJx0
 YIQrBfyYHFnadsaFsgcZkvDc/DQupZRsTfQd8J8vS7GCjm1dQNwlhCx2+YI9X+wTiTV0
 gFr4SKt5m6bzDRZ+M9rJumbKbeXgS6eMvy+nN5CmMZo/J9imSgjRkIE14TquJ/chHtV3
 aqG/ZWh9zHXOpvHgzGYQ/UHAuBbOkfFvlvcMXEZqQivXufQgOFjpwf+Igj23TTlMQ7wa
 5sfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Fwqe3Kerymm7YtpzbZy94WP59zP75G+sYZRAiLfY7fDGGaOeK/FmOpL+J1N60ooXA/xsXKs=@lists.denx.de
X-Gm-Message-State: AOJu0YxBPmJ73OrRA7IIBL3DuCPqLdpR1injw8hrVgZY06Vw3WuGqo8R
 Bpjdwx6ZGnSL3a8LhwAgDB44ns5Q9EcWHqZLQHDQRNXBQROL0x7J+bovgVtW558ppQgfjWP5HMj
 DGa6cGswWPN4KwnUCGtex7yVVcBfQtHRcDDvxWg==
X-Google-Smtp-Source: AGHT+IE3+0tGt4Qvcsskwwn2n6eDWED9ag2rc80ERR4XyjoSidcfjKO8T3w7kGX5lhd5eFb4CWEVo5T6OxiXXF26xQ4=
X-Received: by 2002:a05:620a:284b:b0:7a3:49dc:e6e3 with SMTP id
 af79cd13be357-7a6740b8b28mr296144985a.53.1724256283574; Wed, 21 Aug 2024
 09:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-3-mchitale@ventanamicro.com>
 <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
 <20240821-smilingly-lance-c051e89df945@wendy>
 <447d9553-6ca4-4f82-b2a0-4d445a09564b@microchip.com>
In-Reply-To: <447d9553-6ca4-4f82-b2a0-4d445a09564b@microchip.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Wed, 21 Aug 2024 21:34:07 +0530
Message-ID: <CAN37VV6-d9m=7R6rCSurDQkYWAAGHU93gGUV9Vjt-wF8ZRQUag@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] riscv: cache: Add CBO instructions
To: Conor.Dooley@microchip.com
Cc: xypron.glpk@gmx.de, rick@andestech.com, ycliang@andestech.com, 
 trini@konsulko.com, seashell11234455@gmail.com, randolph@andestech.com, 
 michal.simek@amd.com, peterlin@andestech.com, ben.dooks@codethink.co.uk, 
 samuel@sholland.org, dan.carpenter@linaro.org, u-boot@lists.denx.de
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

On Wed, Aug 21, 2024 at 3:33=E2=80=AFPM <Conor.Dooley@microchip.com> wrote:
>
> On 21/08/2024 10:57, Conor Dooley wrote:
> > On Tue, Aug 20, 2024 at 02:14:01PM +0200, Heinrich Schuchardt wrote:
> >> On 20.08.24 11:37, Mayuresh Chitale wrote:
> >>> +void riscv_zicbom_init(void)
> >>> +{
> >>> +   struct udevice *dev;
> >>> +
> >>> +   if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
> >>> +           return;
> >>> +
> >>> +   uclass_first_device(UCLASS_CPU, &dev);
> >>> +   if (!dev) {
> >>> +           log_err("Failed to get cpu device!\n");
> >>> +           return;
> >>
> >> Please, return an error code.
> >>
> >>> +   }
> >>> +
> >>> +   (void)dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_si=
ze);
> >>
> >> Please, do not ignore errors.
> >
> > I'm curious what the policy of U-Boot is w.r.t. extension probing. Is i=
t
> > okay to enable the option for Zicbom even if your hardware does not
> > support it, in which case riscv_zicbom_init() would be expected to fail
> > gracefully and no CMOs done?
> > Say, for example, you had two very similar chips, one with DMA non-cohe=
rent
> > peripherals and one that only differed by having DMA coherent ones, and=
 you
> > wanted to run the same U-Boot binary on both devices using a devicetree
> > passed from firmware.
>
> To be clear, I did notice that if the dev_read_u32() does not populate
> zicbom_block_size no cache ops will be done. My question was about
> the behaviour relating to the config option and or emitting warnings etc.
I am planning to add a info message if the config option is enabled
but the dt property is not found.
>
> Cheers,
> Conor.
