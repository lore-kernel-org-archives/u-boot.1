Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A124FC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 08:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5B287FFB;
	Mon, 27 May 2024 10:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="Uiex7xyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E6A881A2; Mon, 27 May 2024 10:57:22 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 766B487D74
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jagan@edgeble.ai
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2bdf3f4d5ffso2893684a91.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 01:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1716800239; x=1717405039;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A0a8cMaVUY3/jNwiHhXwHPhU8Z811TDuMM0Y4wwVQ3g=;
 b=Uiex7xycKkbJK4HgxED0B3q5D5CKA07//RB6eDxbB03LfQ621pWIeofyql84MRpzVT
 UVe3KmSFoyT85wLLvcWJZQIiCSyooxmIurqAh6mB9sApdgl0vw2SjP7DzaPSFKol+DXY
 sk3PMRE8WYLys6aGDD2R+L3ZagEeHKN9KXEzY/gkEfyVMGc1VZRjOZPsF++vPviDLatr
 xiahmAA/m8QI9YevqeUVKFxT3LlCVAlpfmlygQEVVEDCB8frcZhOwz4PQV23DVY9bEdS
 YhbcghpDa0I8w9v7ljvn5jyG6r5mDp3ul+Z0BIMpgdAULIeVCR8qiW+/Tld+oeSGQ73l
 frvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716800239; x=1717405039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A0a8cMaVUY3/jNwiHhXwHPhU8Z811TDuMM0Y4wwVQ3g=;
 b=ZvB57KTTi5HO9Sbuf5x554Yb1vNBgbm3Lv1PiN6Wa8uKLjz/U5/G3wYlp3GrbhrbZT
 Q3JcGz6OyI7mQL7Gv+8nDzLpIc4QsSKeuL1eRo6J5y6PCFluy3tWF2C6ZPyCrE9N4KB2
 5LznPSR2xxdkDKxBlwgwPu/rnZl+nyP/zipjrUIL2r1r6GSeZq0s/hMrk2wAUkDEmV4f
 0w93StT4NSL2cQvMx0IKkHwe63NlbIRu5nTTdtGnYG8NDlvHDI4Dp6BTPkLM+1GQuXOU
 pRkVMfkxFRgI4OKtfa9g3mNv8jUS/Y51Z1qOLIDl+9t/XgfpSlDVyupeJBFIMHesJffw
 9TRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFjjD3EEDkb36lr2ZI0BiFq7n/j+mWtJgcAn9YmNBpO9L6etNJFecl6leS0fZJtls2QsVLIaf/7wIpalQzI7yvnD0Oiw==
X-Gm-Message-State: AOJu0Yx2SISj+Tl5NYLFQB8N3EMQ0HW5MK3JcAjoVx1tVoAGv0+EOaOo
 rY09rQNzsHLLRrznFSauAg6AUriXL7Y1r2gJipxuKfQDRbTjyzDz9uN22Q2ikY8glYdfQOkPHPq
 CYTCxVN1QjUQ2ZG9TFZgcsz9Tea1yTJ7Wc/F0ow==
X-Google-Smtp-Source: AGHT+IEQRPGbnOr3JiGzpjbRUUJTdoKxXXCsIBH1GkqYIFkzklU/HpGEvvNyDlyTEOub7Gq7REQF3sFoSep+AKK0W2Y=
X-Received: by 2002:a17:90a:fb8f:b0:2a0:2fb3:c1ff with SMTP id
 98e67ed59e1d1-2bf5ee14909mr7483854a91.15.1716800238732; Mon, 27 May 2024
 01:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240527063915.6205-1-jagan@edgeble.ai>
 <20240527063915.6205-2-jagan@edgeble.ai>
 <c4024690-7067-4d23-bdf3-320194e31287@cherry.de>
In-Reply-To: <c4024690-7067-4d23-bdf3-320194e31287@cherry.de>
From: Jagan Teki <jagan@edgeble.ai>
Date: Mon, 27 May 2024 14:27:07 +0530
Message-ID: <CA+VMnFy39zhYSSmL=JuG_c=yejOccVGF+_jwj2YA0UPrF3HNhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rockchip: rk3588-edgeble: Add USB OTG support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 27 May 2024 at 14:17, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Jagan,
>
> On 5/27/24 8:39 AM, Jagan Teki wrote:
> > Add support for USB OTG with UMS to program eMMC.
> >
> > Add it for Edgeble NCM6A, NCM6B.
> >
> > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > ---
> >   .../dts/rk3588-edgeble-neu6a-io-u-boot.dtsi    | 18 ++++++++++++++++++
> >   .../dts/rk3588-edgeble-neu6b-io-u-boot.dtsi    | 18 ++++++++++++++++++
> >   configs/neu6a-io-rk3588_defconfig              |  9 +++++++++
> >   configs/neu6b-io-rk3588_defconfig              |  9 +++++++++
> >   4 files changed, 54 insertions(+)
> >
> > diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> > index 88f3f7eee2..534d9f8a2c 100644
> > --- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> > @@ -15,3 +15,21 @@
> >       bus-width = <4>;
> >       status = "okay";
> >   };
> > +
> > +&u2phy0 {
> > +     status = "okay";
> > +};
> > +
> > +&u2phy0_otg {
> > +     status = "okay";
> > +};
> > +
> > +&usbdp_phy0 {
> > +     status = "okay";
> > +};
> > +
> > +&usb_host0_xhci {
> > +     dr_mode = "peripheral";
> > +     maximum-speed = "high-speed";
> > +     status = "okay";
> > +};
> > diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> > index 289578803e..b3d17a60ce 100644
> > --- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> > @@ -15,3 +15,21 @@
> >       bus-width = <4>;
> >       status = "okay";
> >   };
> > +
> > +&u2phy0 {
> > +     status = "okay";
> > +};
> > +
> > +&u2phy0_otg {
> > +     status = "okay";
> > +};
> > +
> > +&usbdp_phy0 {
> > +     status = "okay";
> > +};
> > +
> > +&usb_host0_xhci {
> > +     dr_mode = "peripheral";
> > +     maximum-speed = "high-speed";
> > +     status = "okay";
> > +};
>
> I don't see those patches in v6.10-rc1. Have you sent those to upstream
> already? I assume we should cherry-pick patches in dts/upstream instead
> of piling stuff up in u-boot.dtsis. This should also bring the patches
> in rk3588(s).dtsi to add the missing bits for USB support we currently
> have in rk3588*-u-boot.dtsi?

These are -u-boot.dtsi and nothing to do with dts/upstream and can be
removed or reconfigured once we sync the DT from Linux.

Jagan.
