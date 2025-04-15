Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685A0C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 13:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F5C82AAF;
	Tue, 15 Apr 2025 15:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="L4bhcxU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC1E82ABB; Tue, 15 Apr 2025 15:15:29 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696E582A39
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4ZcPlv725Zz9wKJ;
 Tue, 15 Apr 2025 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1744722924; bh=o89x2ToZtB+MsyA2JEGOacipWMHxIXvKtTgToqv4O1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L4bhcxU2cvlOCe2g+DMTseAyZvOuGYJlyKf857+NoCvK5je2BV68I7Ll71CCORnmh
 4Fcq8GF+37o8L5ynauTHKWwIpnGcUqbPpqLYI9XXoAbO7BiAyWQvoBJkDYgjLNrl/+
 bbVUWPVSiBrCniGzNvRZWD8CegwLHooTOZvNOl60=
X-Riseup-User-ID: 9B9E0FCCF3DB6D3FB7A937422D1100174ABE3A4D29F37138C8987C1FE6EA1C8D
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZcPlc0VGQzJv4k;
 Tue, 15 Apr 2025 13:15:07 +0000 (UTC)
Date: Tue, 15 Apr 2025 20:15:04 +0700
From: Dang Huynh <danct12@riseup.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Piotr Zalewski <pZ010001011111@proton.me>
Subject: Re: [PATCH v3 08/12] dts: rockchip: rk356x: Prerelocate VOP in
 U-Boot proper
Message-ID: <Z_5b2G2I96tZ6xI8@melt-pi5>
References: <20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net>
 <20250412-vop2-pt2-v3-8-7c796db335e9@riseup.net>
 <a496ff87-1030-44c0-8707-04af70208883@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a496ff87-1030-44c0-8707-04af70208883@kwiboo.se>
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

On Sun, Apr 13, 2025 at 04:33:25PM +0200, Jonas Karlman wrote:
> Hi,
> 
> On 2025-04-12 16:27, Dang Huynh wrote:
> > We need to prerelocate VOP2 memory so the driver can work. This
> > will only support U-Boot proper.
> > 
> > Signed-off-by: Dang Huynh <danct12@riseup.net>
> > ---
> >  arch/arm/dts/rk356x-u-boot.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> > index 24a976cf7e21da351cbbb969ba2b4687c344ca6c..1191e2fd567dd18655c88ea1b7a28d160d43c220 100644
> > --- a/arch/arm/dts/rk356x-u-boot.dtsi
> > +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> > @@ -166,6 +166,10 @@
> >  	clock-frequency = <24000000>;
> >  };
> >  
> > +&vop {
> > +	bootph-some-ram;
> > +};
> 
> This node should be sorted after &uart2m0_xfer to be in alphabetical
> order, and not put between &uart2 and &uart2m0_xfer. 
Whoops. I'll fix this in the next revision.
>
> On a related note, I do not understand why U-Boot must allocated its
> framebuffer in pre-reloc phase, but that may be something to change/fix
> in a different series.
> 
> Regards,
> Jonas
> 
> > +
> >  &uart2m0_xfer {
> >  	bootph-all;
> >  };
> > 
> 
