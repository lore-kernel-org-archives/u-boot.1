Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBFAC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 12:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 514F680EDA;
	Tue, 21 Jul 2026 12:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0-SWyVA1FivW; Tue, 21 Jul 2026 12:46:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2D9480EBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784637985;
	bh=OKWlZM8mf2ma1N+zO7MxBkcNEddXAwXkqDd9/DlKcJU=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=USllzc5DRbCMkgRUE6H5Kc3e7Dw2LWZMe0PXNFEN7qot5OfuBJ03in1385UjmTIlD
	 Bom6uo+UcBBjkBvgjDH3Rx2/jU/VhuFYJe5bc3L9lw0AOlvD0i4HIbLr/1GAXOBcaS
	 O/8q60uxQOorE33yIZGAXVaaWVclc3waxflpm541Rn+OJ2vqwRSOyRgUktIAjloTiB
	 +37kCqx1/QbRnn2XiiGFrQxxzDx2zwD1NiQ0427NgbhiT2uutfuc27Re8vxujQkfAn
	 W3IojYTAREnDumc0EOv2A3EjnyCDju5PzPOZZYfI774XtSzFw8tXDmzOms1aLtJzIE
	 Ef1vB8+lW4eCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2D9480EBF;
	Tue, 21 Jul 2026 12:46:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B0BE8224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 968DF80EBF
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:46:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVUftT5jG1sm for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 12:46:22 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5EE1680EB7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EE1680EB7
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EE1680EB7
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 12:46:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF2384659; Tue, 21 Jul 2026 14:46:20 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2442803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:46:17 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so862300766b.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784637977; cv=none;
 d=google.com; s=arc-20260327;
 b=Qbirt1eD1a/5/C7eEMHeRt46d8BdSsiqevPr0+drdZMStA2hEPMLPm7i8j8rwCaoxO
 9kPIxfU6n0xtKtd2NCKGQk6iQXwxVibwz7PuiGo7YkzJMEh7D7MDQklCqxUnGVv15qtG
 gP2MJewlup02byQsfTIPIqKoaUGJMvdie6quKRHb+E1u2MbKa9i8WJ91JfxkcNv1elJ7
 CiHuAYpa5IjQSN2m2zl40qzBkwNwBAc83fmP1KdDhAzDmQCBP1R4VsGgZKuFWM2C2LNy
 liecyQjFFVFSfTWgbYqpNOtYow5A1FIXZSdf18PD//D9Vl6kG+2nNByifs2WmvfXH/30
 pviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OKWlZM8mf2ma1N+zO7MxBkcNEddXAwXkqDd9/DlKcJU=;
 fh=OuowzhnSXj1Fq0buMNvfvwCFCBmsDZM9xd1zaiexQbw=;
 b=RICndcEl2S6rtLe12Yl3LeEzVTNEdYuf2jmJwcZoy7klWiOCNvEkN8XgUSlXSuP8jS
 Lgro36NovwqjA3btq5hXZ2Op84xEhK/79ye55sOZQx6JucuUWDnI2Ec2G1jMYQ8cU7m9
 U3LFS5Ym9Enr/l7mApv7Hd6EQ2NoHzCabUCmx6HQ4bSUxjy/kkFSh/T20PW9hRFl3b30
 MphC1xWbAhnajHJAOB/YzaAA2bhSqdqERHNKXenAbKwgexlmpnj7WHUgkG/FdLXVK0P+
 bY3JtYBABmi/03rr3qy+Wjwh/CX6UxAOEtI+6MBwZjJmKqv0UE3cYuTLjSsMXCGTBHVB
 HYDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637977; x=1785242777;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OKWlZM8mf2ma1N+zO7MxBkcNEddXAwXkqDd9/DlKcJU=;
 b=p7O4plYL9nLFn9QeXQt2RmRMB1e1yI8uheOH+B/iwBIB/1tjTcInQPngrFOQJ/rzuN
 AgOqRtvMXVX2pdWThdPT8yhYAWD2zzyG4h51PPXfqJOLBJjjoTXLh1ciwxoWxrNIRyL0
 8yfyLhLhy/CPQNK6k76ZcAROAvudiHS+t4Db0K9kclc1ovaR+njT3duB5wL6xuYzRjKQ
 i/Y4ble9Y+SM40oJKkuANDz0i3a5PypgQ1LsMLx6bgR5eHrCrp/R7XE4RUlHBAmBnTs6
 hsiH47MvCV0m/nyKbNAfNnDKJrFVIKUJusQ/CChlErX7/nNcN1StnA3UUDQRqLLYMAF9
 Esog==
X-Gm-Message-State: AOJu0YxT+H3rQ1i+cDuEzE5gn6Lx5P2we1974v0ro4whqvZNvOfRnVX0
 LgFdHQ/Zi7ZbvSVYTIitM9Tb1ZCE5564YteEVC2IgcNy/gPOSdXFiZqOrnQR75GVAbTo2W9I/aL
 WYW0gyAj//tyhMcZLVcqsjcKeu+4Z4bbNFyKLNACp9Q==
X-Gm-Gg: AR+sD133VTAO2yxsjaTAFW5zuWKc2Mxhuro1ArZLamymGUugaPOXb0vo/Woy7mutl+C
 AtfG2HOyPZtqxqCzDPJoCT5VGqMd/o0Mc4oKyd1nPSaqX9Nbfzavntx3IPYIzT3Lq9WN69KbFVh
 d6MQWCujcyb1WAJzt1tN6lWjQXCgFFxweHaL9Q3IK/RASx9qBCCeeFKwgVRJ0gFk87DxBZkiv00
 eyxABbauhyElHPUM9p1NxxcvQE2kMs1hLliGuxzFXHgyl00gXyT2G+jXD+QTUV731Q7ZDxs9AaQ
 lgYtqwcdqrMr9akqZg==
X-Received: by 2002:a17:907:3e11:b0:c1c:285a:4751 with SMTP id
 a640c23a62f3a-c1c285a5c8fmr61387666b.29.1784637977375; Tue, 21 Jul 2026
 05:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
 <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
 <153cd45a-b62c-4d3a-93dd-0dc94d74ddcc@cherry.de>
In-Reply-To: <153cd45a-b62c-4d3a-93dd-0dc94d74ddcc@cherry.de>
Date: Tue, 21 Jul 2026 16:46:04 +0400
X-Gm-Features: AUfX_mxAh9Yi-RfAHGgIAfVKdKp8jMykYg0WQtW9KueLauXS5iarVhTCoN67pbY
Message-ID: <CAKTNdwFeUNxcVz-Jv1BGXRfsx7mKo0w9hTQEoEtFabfaco65vg@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: rockchip: pll: fractional PLL coefficient is
 two's complement
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784637977; x=1785242777; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OKWlZM8mf2ma1N+zO7MxBkcNEddXAwXkqDd9/DlKcJU=;
 b=yrTYmH5yiW4JfEOXtA4+WSIrdkXYHKryVP8bIBMOPFnoANuwnXsQ+Ib4s2cNApRsco
 N4gTNBm5xpW33v2Sdt8Ta4nog50oFgLpCtf6ffqn640uQrWuTG4ZIKXE0iMS4KAZoma4
 lcr2KXUeD2ZA3mia+oNhUVPDcVtxRu5vHlTICPobUJ2PgoLg67vhPnwEuT0gTtDK9q9c
 +0FK+wnSpmaTQojW/7+zT1kckz0liuwifMakKPPYfPEZ2qy7LMQC9e+a4Yy48Nmniep+
 zyyMlNT9ptw0HwsUmD5Owq9mwXgU9R9jn20LTckHy0yd/yX3f1z935qWkPSEUEVmEbRP
 4spQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=yrTYmH5y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="yrTYmH5y"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Alexey Charkov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Alexey Charkov <alchark@flipper.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Tue, Jul 21, 2026 at 4:20=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/13/26 8:35 PM, Alexey Charkov wrote:
> > The TRM defines the fractional PLL adjustment coefficient as a signed
> > two's complement number, 16 bits wide, so store it as such to avoid
> > confusion.
> >
>
> Yet...
>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   arch/arm/include/asm/arch-rockchip/clock.h | 2 +-
> >   drivers/clk/rockchip/clk_pll.c             | 3 ++-
> >   2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/incl=
ude/asm/arch-rockchip/clock.h
> > index 95b08bfd046f..f9bfdfb8a6a3 100644
> > --- a/arch/arm/include/asm/arch-rockchip/clock.h
> > +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> > @@ -104,7 +104,7 @@ struct rockchip_pll_rate_table {
> >       unsigned int m;
> >       unsigned int p;
> >       unsigned int s;
> > -     unsigned int k;
> > +     int k;
>
> ... you use int here instead of s16, any specific reason?

Yes. What matters here is the signedness. The table value never gets
written to or read from the hardware without accessor functions, which
mask on writes and sign-extend on reads anyway. A generic 'int'
usually performs better than a fixed-width type because it aligns
better and requires fewer instructions for arithmetic.

It also reduces potential churn if this table definition is ever
reused for another SoC with a different width for the k coefficient,
but this latter point is more theoretical.

Shall I reword the commit description accordingly?

Happy to set the type to s16 if you believe it's more expressive,
though; we aren't doing much arithmetic on the table values anyway.

Best regards,
Alexey
