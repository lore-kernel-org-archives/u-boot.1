Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F91FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 05:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7128E83FEC;
	Mon,  4 May 2026 07:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="WbncrCp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147A884255; Sun,  3 May 2026 20:56:55 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7A983EF9
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 20:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so539010566b.2
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 11:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777834611; cv=none;
 d=google.com; s=arc-20240605;
 b=Yk2uqMUdeI4m/6adxQGR3yaj2sEab8VhRwrFRsb8WoSdOBTaYwg68tDo3htJBLuqCW
 YPIo9jIYv2spg+UrQBByU6WpiWRzmTWS2ydxaaslsakTmjEjfDWuKzBYiPLEmafxST0o
 kFcwfosuDSn7AjIPl7ZB+GwDcf+g8IkB3+T5PuSbU7eJ5pq4zN8sefo3rzO5/7HLkK52
 CqffpFfXNnFDg6Ko4lSOyCLNykUXNMKYO+sLUSzAMEC0UxrgDVEDq3x3vWl8gadnyvWP
 Qv+5nqDKc5qTJjD/fgVplQPry3fYpUXniQEyVVXpy6pvOmLwzLaKGwq0kghiM2hjIJwz
 bAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+sQiwxsv3Jx27pyDia17tPNHpbZhV0tOPg2auOn0rps=;
 fh=JQhjmcwtbCAeNN3lv9ENZy6er9YK2QtDwlTRSiQkn94=;
 b=bxGv033QqCUMmTBNEo9k+boJ4Yd+ewlE5hbiRr1lb8A7kT0AbzJre97OGBN2eHZ5/d
 7sbTmkr1XwFuvHcq3vTzkB8boSB9kBEUQqkW0vZ2BKP4nx1j/IiTDsm3a19plmIQkrQA
 caTAVo7m4dssaOYTbywsmVEWrD/zO+rRfGqJf+SVov1Hr6H3ChHgHwPPWr8ukxxWxhux
 /tz+m5brZaqkXA5Zdzco5h1Fpkxy70PMjBd95A5r/fKCXdNK24eSWWFKJ5Kmnb7Jw1w5
 ity50/ac+tpPO2jP9pFdFIpnJ1iFWb+b6QuQpxpDgBiIk17zMfZzD6Ind1vlJapk1/P0
 /HfQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1777834611; x=1778439411; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sQiwxsv3Jx27pyDia17tPNHpbZhV0tOPg2auOn0rps=;
 b=WbncrCp37z2THs6mtkSKuK6I4kXTMaR0r2Yfpxwlj5n33Xfm6hV59z+nGIN+82v45m
 1e2Q07PPna1pNxqaaW2P3KyxxdJcg6Ol26nssBftyAjfc7UYXAMmksU861CYyFaPjyq2
 7d0QkrBeAupxXogEMnj3pGDgWZutvEXZMGa8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777834611; x=1778439411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+sQiwxsv3Jx27pyDia17tPNHpbZhV0tOPg2auOn0rps=;
 b=s1/oh2v26TX3ruRUUMimAY1EwpgpmiB0nH+xvX0irmyuIP7I/cjpcW8FvjzAXrBbiw
 kywS6KcflI8K3DZspjSVqshPEg0vgcgcPLIcaTDi+v9GZTbRAXkVfEPHOlI524ibmDPw
 O843efBoqj9PmsfJteDOweobhmBcBpZHVQ9yyaXq0+jZD1Fxi+lrWj8WE/lWqxwasJeK
 IS1vO7YHlmxPeVorHBYt6s+U7+N4q8YfofMSpciDcpVZEXSNrPuBz17N7hF1i+/rAGuc
 IPksADQRfwFpapVQ03eAofmUFjSOPPvAJrISLhm6saioHevloWc/xWGClwQ2Tkw0KKgg
 S0Ug==
X-Gm-Message-State: AOJu0YzNTKiOKbvf2U2ar1/OMIZbK+MEbCtqodrnEqU+eDKSVog80Uk4
 88C/OWW+/vv+SiBgitKd562gqwjtJcDCBtT90oX93/KfopQliAh16wc/s1+j4h9PyqEAZfxpdqr
 +VtpLeZaPWXip2LHsKHzFT/NQY4JecF7NI7h1nakRqOLH8cQ8lg+O
X-Gm-Gg: AeBDieszTzD+Nsk1si/MR9bapsIuV9CR7Yr724reQp8L1FQ0K2nCBh31i4yzYo2kN9p
 +wSGX6O2CaZ5/kDCjn5xlXh9HxCC5KAnSXdHSre4nsZSqXRz5hb4S0AfGbro4i7k0bi43J9Auik
 F/AjHKFCvj8Mt3QzOGvtYEJNWp66/YVSovGR1+eT5xH1IKp8wAtJDLhEZGg15Xp7I/GTzJr3v0R
 M/e3FBLJrTwjstpX+PmyaMuuWN9eLTsv3W0u7eignh1B1rltoPCVCz9w8FG/SITa36fe3qADnBA
 OBGN5/czial0Sln1Y9MRpc2C9zD7CPQEihvsHA0/JEDL8bmT8BYX
X-Received: by 2002:a17:907:9455:b0:bb7:e6a1:e09 with SMTP id
 a640c23a62f3a-bbffad20247mr372299166b.19.1777834610343; Sun, 03 May 2026
 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260421132103.30033-1-ssrane_b23@ee.vjti.ac.in>
In-Reply-To: <20260421132103.30033-1-ssrane_b23@ee.vjti.ac.in>
From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
Date: Mon, 4 May 2026 00:26:39 +0530
X-Gm-Features: AVHnY4I7XMj2fSs9i0j8j-gXpHV_MhUYVb5Jtvq7kYPXSChQR5-SyJQaWcjfjho
Message-ID: <CANNWa06xcOuCRwZ1YNLEm3xYSdxP7HcnLzY5EGf9RFYg3fs_eQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] BeaglePlay: add ITE IT66121 HDMI bridge driver and
 enable splash
To: u-boot@lists.denx.de
Cc: jd@ti.com, tl@ti.com, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 04 May 2026 07:09:21 +0200
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

Can this be merged or does it need some more changes?

On Tue, Apr 21, 2026 at 6:51=E2=80=AFPM Shaurya Rane <ssrane_b23@ee.vjti.ac=
.in> wrote:
>
> This series adds a U-Boot driver for the ITE IT66121 DPI-to-HDMI bridge
> and wires it up on the BeaglePlay so the board can drive an HDMI output
> from U-Boot (used for the splash screen via TIDSS).
>
> Patch 1 adds the new video bridge driver. Patch 2 enables the DSS,
> I2C2 and HDMI-bridge DT nodes for U-Boot (bootph-all) and turns on the
> required Kconfig options (TIDSS, VIDEO_BRIDGE_ITE_IT66121, BMP,
> SPLASH_SCREEN, etc.) in am62x_beagleplay_a53_defconfig.
>
> Tested on BeaglePlay hardware: U-Boot renders the BMP splash over HDMI
> via the IT66121 bridge.
>
> v3 addresses Simon's v2 review comments on the driver: the remaining
> bare BIT() constants in it66121_hw_init() now use named defines with a
> comment describing the AFE power-on sequence, and the unused-looking
> bpp local in it66121_attach() has a comment clarifying it is a
> required edid_get_timing() out-parameter.
>
>
> Shaurya Rane (2):
>   video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
>   BeaglePlay: enable IT66121 HDMI bridge and video stack
>
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  42 ++
>  configs/am62x_beagleplay_a53_defconfig       |  13 +
>  drivers/video/bridge/Kconfig                 |  10 +
>  drivers/video/bridge/Makefile                |   1 +
>  drivers/video/bridge/it66121.c               | 609 +++++++++++++++++++
>  5 files changed, 675 insertions(+)
>  create mode 100644 drivers/video/bridge/it66121.c
>
> --
> 2.43.0
>
