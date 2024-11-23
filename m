Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AA7E66887
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A349890B9;
	Sat, 23 Nov 2024 22:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6EASRIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFD489152; Sat, 23 Nov 2024 22:38:40 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3618905E
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fc968b3545so35329411fa.2
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 13:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732397917; x=1733002717; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eiBFdfoSy6t42h90ZdHAPK5RyZePMk6BYlMOOtavrU=;
 b=S6EASRIrstoDW3KipADd9s8RuPgJFSs+xIm+q+FiVxhNLFg3tHvAbqK3ty4Tu+V9ha
 u6Wjj2mFI9Y3vUDDhQLoN/7HrFUq8R7F64L8CoZlVgI+WtaTRr7A3UoqXydgQ6OY4vta
 Mfce1P3Ep3OLhsTcgQ+N0sMKLvGctT7l87okxJDpX8Kt5JwXMr7JuY8YZqhxMRxqiXca
 kbrDiAb4hyI08d7ZF283brRPpgm/6a1ZlHW5hvM55QS5JrifNBz0wEEa0ur0iXnqCgwI
 UkE5qnC2esBI8RbHJyS93FvjGAF/LBSb4/bmoL/pfDJAzp2pBrnjrbkUIcfRPdm1g6tH
 dOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732397917; x=1733002717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eiBFdfoSy6t42h90ZdHAPK5RyZePMk6BYlMOOtavrU=;
 b=P3+nR6ZkNG0LiIbh1lG5TskCmtpiCzuE/VmtAQVYnepklJ3vu507GvTBTuihlYbnba
 zKmugx+I9Gzz82xLeFOLh1A0BXPnq1SUUAT2Pp/JrlVisN9pLGeAJ683245DepTRdsF/
 EbocUGuTLa+8sCLbYqDu8bA0AuBXR5mCB6FH8PpNigklAmralcIr5Qkv4BbmFdev+SNn
 Z/lqdsajYhGIa8jh8SpTEgT9mwM8KMe7vumj2INXP0HX0uK5VeoJBq7lxZ8x2hADS42Z
 bwjw90PmSd1EZ3+iZdjSLXZEHcFG5sn9lycbcsdyMsY41gKs40+dIk7/gmnci8n/IDBb
 GgDA==
X-Gm-Message-State: AOJu0Yw3yiR6tHv3lLubkyTbmqelzquPwDAYjzaALJcXaJnjO/CDAdtD
 aBWJjJLvswqPsrUxG0CFT9POfpKmckidWcg9/JnaoNiw7yHba5Og8Hahfy8WjA6wYhXFfLEaTmg
 gZvDj1btliMGRQ4QrI4b5szQc/+yAYg==
X-Gm-Gg: ASbGnct5wFocJ9+DMzb/u0eb6wCnMRcpz2aUl/nL3IYx7v2LfOOJnpQLWr9KMSKa14E
 JyUvmhFcmXSZnyDhEWg6vqp0XQfN02JkYshELR4hx0xCTOrMLXSHQHA+yy6PJUCE=
X-Google-Smtp-Source: AGHT+IHz0uzmHBR3ART8TiUlVNvQObPjGZZPEcTnRkchXrx8636AltHI0gN74V/wdA4MSZoXeFNuck1UoMhOBNMfow0=
X-Received: by 2002:a05:6512:3b90:b0:53d:c3aa:e4ec with SMTP id
 2adb3069b0e04-53dd35a4cfamr3741228e87.1.1732397917327; Sat, 23 Nov 2024
 13:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20241122015858.557561-1-marex@denx.de>
In-Reply-To: <20241122015858.557561-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Nov 2024 18:38:26 -0300
Message-ID: <CAOMZO5CgrNbuLiBnXwkAL1LVcxztgo=XBzegt1uvYpedaH6Ctw@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Include 32kHz oscillator clock in
 SPL DTs
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Bryan Brattlof <bb@ti.com>, 
 Greg Malysa <greg.malysa@timesys.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

On Thu, Nov 21, 2024 at 10:59=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent")=
,
> drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m_clk=
)
> fails with error -22 EINVAL in SPL. This is because clk_get_by_name() in =
the
> end calls fdtdec_parse_phandle_with_args(), which iterates over all phand=
les
> in clock-controller@30380000 { clocks =3D <&osc_32k>, <&osc_24m>, ... } n=
ode
> 'clocks' property in an attempt to find the "osc_24m" clock, but fails to
> resolve the &osc_32k phandle and returns with -EINVAL.
>
> Include the osc_32k clock in SPL DTs as a low risk fix for v2025.01 relea=
se.
> This way, fdtdec_parse_phandle_with_args() can resolve both the osc_32k a=
nd
> following osc_24m phandle and successfully look up the osc_24m clock.
>
> Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent"=
)
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied only this one for -master, thanks.
