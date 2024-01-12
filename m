Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBBFC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D7187937;
	Fri, 12 Jan 2024 14:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ovznl91X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4019087941; Fri, 12 Jan 2024 14:15:00 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A73E87883
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CDEoo3057277;
 Fri, 12 Jan 2024 07:14:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705065290;
 bh=jbydLp+7+PCykb+cXwk8Md66AGXf/RxzGRaZsun1Lnw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Ovznl91XTB4vd0zp75PWiDqEoh/SnNwL7QXGpwO6fnULm4na+ZeIROTdU4qrvBI68
 B9QbjXKhmUtr9mIrQvhnIHmsIX6CZ8vc1ox/itouW1yl3UPEOfJvp+Z1oovmHmh/8l
 sE7IoNib2uqwQ0lilaGShlXgaxCkgQMx+Ee4H5FU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CDEoOd032115
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 07:14:50 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 07:14:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 07:14:50 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CDEotJ063140;
 Fri, 12 Jan 2024 07:14:50 -0600
Date: Fri, 12 Jan 2024 07:14:50 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <robertcnelson@gmail.com>, <trini@konsulko.com>, <marex@denx.de>,
 <n-francis@ti.com>, <praneeth@ti.com>, <s-vadapalli@ti.com>,
 <r-gunasekaran@ti.com>, <srk@ti.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Message-ID: <20240112131450.tpn454pfzlqlteed@urology>
References: <20240112124951.238098-1-rogerq@kernel.org>
 <20240112124951.238098-5-rogerq@kernel.org>
 <20240112130233.bflterluncjoyrhy@treadmill>
 <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 15:06-20240112, Roger Quadros wrote:
> 
> 
> On 12/01/2024 15:02, Nishanth Menon wrote:
> > On 14:49-20240112, Roger Quadros wrote:
> >> Without correct SERDES MUX and Lane control settings
> >> USB0 will be broken. Set the MUX and Lane control devices
> >> to be auto probed so they are configured correctly.
> >>
> >> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >> ---
> >>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >> index f83caf7998..017a5a722e 100644
> >> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >> @@ -165,6 +165,7 @@
> >>  
> >>  &serdes_ln_ctrl {
> >>  	bootph-all;
> >> +	u-boot,mux-autoprobe;
> >>  };
> >>  
> >>  &serdes2_usb_link {
> >> @@ -173,6 +174,7 @@
> >>  
> >>  &usb_serdes_mux {
> >>  	bootph-all;
> >> +	u-boot,mux-autoprobe;
> >>  };
> >>  
> >>  &serdes_wiz2 {
> >> -- 
> >> 2.34.1
> >>
> > 
> > Is this a u-boot thing? or a driver limitation?
> > 
> 
> u-boot specific. We just want the mux driver to probe
> and apply the settings.
> 
> from drivers/mux/mux-uclass.c
> 
> int dm_mux_init(void)
> {
>         struct uclass *uc;
>         struct udevice *dev;
>         int ret;
> 
>         ret = uclass_get(UCLASS_MUX, &uc);
>         if (ret < 0) {
>                 log_debug("unable to get MUX uclass\n");
>                 return ret;
>         }
>         uclass_foreach_dev(dev, uc) {
>                 if (dev_read_bool(dev, "u-boot,mux-autoprobe")) {
>                         ret = device_probe(dev);
>                         if (ret)
>                                 log_debug("unable to probe device %s\n",
>                                           dev->name);
>                 }
>         }
> 
>         return 0;
> }
> 
> 

Uggh.. We need to see eventually how to get rid of this.
This makes
https://lore.kernel.org/u-boot/20240110103547.719757-1-sumit.garg@linaro.org/#t
harder now?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
