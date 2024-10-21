Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C369D0E6EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 10:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFEF988ED7;
	Mon, 21 Oct 2024 12:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="OjRM+DBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4843688EE4; Mon, 21 Oct 2024 12:51:40 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4161688E35
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 12:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1B837148AE42; Mon, 21 Oct 2024 12:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1729507897; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=aB9hw/qOx9Hk1HxRDN1BSyHYSbA3m3hnMBe2myxrDSw=;
 b=OjRM+DBkl358FuveOVkz092BJgOGgoJyKYB3O8mJCeoO6wl4QxexaXDRbPAH6ViOjRThlX
 KJr/w48cNhjn7sCQ/19fFsvqJ5au1NegYYyLnApvG2tKs43uJmhe97CBj6nQ5xuKu9pTqa
 rGFQrw1H3wcq/5gWq3hdVHO+G3zk+uHFS0h8Br0OMFwFGYzCsL3QV8w+jTKGpy2X0GEsys
 yGuke+LLidACsrzeEOhk0iZ9QbjzfjPiFelCHV4I2CxMToLvZH0Bec0UnLdnRn0uKLaFIL
 LSxs8VNNXoeQLDiqzhr1Y5H0VnSz4WUVPOwSjImsBtWB++Y2W9XEQ4PWjFwWqw==
Date: Mon, 21 Oct 2024 12:51:35 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de,
 John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Message-ID: <20241021-union-repressed-6ff41958aa98@thorsis.com>
Mail-Followup-To: Benedikt Spranger <b.spranger@linutronix.de>,
 u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
 <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
 <20241021122017.34fc9f3c@mitra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021122017.34fc9f3c@mitra>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Benedikt,

Am Mon, Oct 21, 2024 at 12:20:17PM +0200 schrieb Benedikt Spranger:
> The SPL sits in the first Page in NAND flash. It does it's magic and
> then load the U-Boot payload from an UBI volume (Or directly load a
> kernel). Then it "starts" the payload.
> 
> > Did you try reading/writing raw NAND from there?
> I try to read from SPL. That's all what ubispl wants. No need for write
> support here.
> 
> > I'm not familiar with SPL, does it consider dts?
> It consider dts.
> 
> > I could share my dts parts if that helps you.
> That would be great. I definitly give it a try.
> So here is a quick extract (EBI is also used otherwise) of what I did.

Using EBI for accessing an FPGA here on one of three boards.
So I'll share that dts excerpt from my v2024.10 branch.

> Hopefully I did not forget anything...
> 
> --- a/arch/arm/dts/at91-sama5d27_ABC.dts
> +++ b/arch/arm/dts/at91-sama5d27_ABC.dts
> @@ -63,7 +63,62 @@
>                                         bias-disable;
>                                         bootph-all;
>                                 };
> +
> +                               pinctrl_nand0_default: nand0_default {
> +                                       pinmux =
> +                                       <PIN_PA0__D0>,
> +                                        <PIN_PA1__D1>,
> +                                        <PIN_PA2__D2>,
> +                                        <PIN_PA3__D3>,
> +                                        <PIN_PA4__D4>,
> +                                        <PIN_PA5__D5>,
> +                                        <PIN_PA6__D6>,
> +                                        <PIN_PA7__D7>,
> +                                       <PIN_PA8__NWE_NANDWE>,
> +                                        <PIN_PA9__NCS3>,
> +                                        <PIN_PA10__A21_NANDALE>,
> +                                        <PIN_PA11__A22_NANDCLE>,
> +                                        <PIN_PA12__NRD_NANDOE>,
> +                                        <PIN_PA21__NANDRDY>;
> +                                       bias-disable;
> +                               };
>                         };
>                 };
>         };
>  };
> +
> +&ebi {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_nand0_default>;
> +       status = "okay";
> +
> +       nand_controller: nand-controller {
> +               status = "okay";
> +
> +               nand@3 {
> +                       reg = <0x3 0x0 0x800000>;
> +                       //atmel,rb = <0>;
> +                       nand-bus-width = <8>;
> +                       nand-ecc-mode = "hw";
> +                       nand-ecc-strength = <4>;
> +                       nand-ecc-step-size = <512>;
> +                       nand-on-flash-bbt;
> +
> +                       partitions {
> +                               compatible = "fixed-partitions";
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +
> +                               spl@0 {
> +                                       label = "spl";
> +                                       reg = <0x0 0x40000>;
> +                               };
> +
> +                               ubi@40000 {
> +                                       label = "UBI";
> +                                       reg = <0x40000 0x0>;
> +                               };
> +                       };
> +                };
> +        };
> +};

I have no partitions defined, but that should not hurt.  Split pinctrl
settings here, but that's basically because I have more child nodes on
the EBI node in Linux which I don't use in U-Boot here.  Should not
make such a difference.

Do you have external pull-ups for the A21_NANDALE, A22_NANDCLE,
NANDRDY, and NCS3 lines?  Maybe cross check that with the board code
you probably have for the old non-DM NAND driver.

Now my example:

  &ebi {
          pinctrl-names = "default";
          pinctrl-0 = <&pinctrl_ebi_default>;
          status = "okay";
  
          nand_controller: nand-controller {
                  pinctrl-names = "default";
                  pinctrl-0 = <&pinctrl_nand_default>;
                  status = "okay";
  
                  nand@3 {
                          reg = <0x3 0x0 0x800000>;
                          atmel,rb = <0>;
  
                          nand-bus-width = <8>;
                          nand-ecc-mode = "hw";
                          nand-on-flash-bbt;
                          nand-ecc-strength = <8>;
                          nand-ecc-step-size = <512>;
                          label = "atmel_nand";
                  };
          };
  };
  
  &pioA {
          pinctrl_ebi_default: ebi_default {
                  rd_we_data {
                          pinmux = <PIN_PA22__D0>,
                                   <PIN_PA23__D1>,
                                   <PIN_PA24__D2>,
                                   <PIN_PA25__D3>,
                                   <PIN_PA26__D4>,
                                   <PIN_PA27__D5>,
                                   <PIN_PA28__D6>,
                                   <PIN_PA29__D7>,
                                   <PIN_PA30__NWE_NANDWE>,
                                   <PIN_PB2__NRD_NANDOE>;
                          bias-disable;
                          atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
                  };
          };
  
          pinctrl_nand_default: nand_default {
                  ale_cle_rdy_cs {
                          pinmux = <PIN_PB0__A21_NANDALE>,
                                   <PIN_PB1__A22_NANDCLE>,
                                   <PIN_PC8__NANDRDY>,
                                   <PIN_PA31__NCS3>;
                          bias-pull-up;
                  };
          };
  };

Notice mine uses IO Set 1 here, but your's should work with IO Set 2 as
well.

> > (What I do here: SoC loads at91bootstrap from raw NAND at offset 0,
> > at91bootstrap loads U-Boot from raw NAND at some offset like 0x20000,
> > U-Boot (proper) loads everything else from UBI.)
> From my experience that can cause significant headache starting after
> 5-6 years in use. That's what I try to avoid :)

I'm aware of that.  The data retention time for the NAND flash used
here is 10 years according to datasheet.  No big deal on Linux when
running ubihealthd for everything stored in UBI, but everything
outside of that is about to fail some day. :-/

Greets
Alex

