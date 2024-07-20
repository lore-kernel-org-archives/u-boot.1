Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83131C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 13:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFFF88747;
	Sat, 20 Jul 2024 15:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721480990;
	bh=oUw6IiQ9kkdFu1s3FYprmAhnX7hezCzUOL4t+/xuAGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=foiQr//n/ZWVSkbg3OLXu1Ecpi4NaUTY50PQPL1fY2Gr3JickRkStov58T3l4HGAy
	 /oHKwiHb4wa3JHBlWgTu4BBR1CVOjlHfXUkDOzAOwFKWovDhJ4rrOeZH8VBBOJiJMn
	 aKFKP5F7ueho9Ag+03xoW/CsNsiMsPBq9XBnq9039kg5/niPOsCHbZ4OH5iTojBMeb
	 t0u1AJylg8xrX60gAHyz8FDyMQndYT0zYT20dofaa8pg3mhBqJGZvDX7VSf7C/himx
	 yoTUyXzvg27Cv+e8m2dHTR6+PLyJsRNOPGs4CvRl9y15ep5jcflkJxUL6Oky4uP/WW
	 6YNg68oMt2B6g==
Received: from crub (p508b6272.dip0.t-ipconnect.de [80.139.98.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 13D3F88373;
 Sat, 20 Jul 2024 15:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721480990;
 bh=oUw6IiQ9kkdFu1s3FYprmAhnX7hezCzUOL4t+/xuAGM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SjeGu//E7kvrbb4w2W6jsJIewDJ09cwPgRYs1vsTRpNiAiBXF6TmhVpLtxTg3Zq8T
 nwIPka5qirnUb1K6vQlcLpPw6kCmOFqhDgQ+ZinumkgUNH8hHR6bEt5A8wawNALmcK
 vJAY4gnHoi6zREqyxrtiBnJ55WW3ZLarDScZ8qT968ao/F1Z9eCXW88l/pTF+HrGmD
 xoga9tHqchtOQxgJker9PgQ/6bSDE3WFD1Pv4uicc8WLqNRZnDZfN+fjIcS7KfY0ng
 3QyFQdwuKkivfSK4DY36ElSv74F/DpOLaqBwiqC4b7LgdCIgehsBYl7JQVPyApVlfQ
 hOJE0ImLzPOXg==
Date: Sat, 20 Jul 2024 15:09:34 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] board: beagle: convert to CONFIG_DM_I2C
Message-ID: <20240720150934.40349259@crub>
In-Reply-To: <CAFLszTjjgvFePwsMO-u-bKRjaCREXy1PCpOCmfH=Atvm2ThAqg@mail.gmail.com>
References: <20240719215123.3358410-1-agust@denx.de>
 <CAFLszTjjgvFePwsMO-u-bKRjaCREXy1PCpOCmfH=Atvm2ThAqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On Sat, 20 Jul 2024 13:36:04 +0100
Simon Glass sjg@chromium.org wrote:
...
> > -       /* return BEAGLE_NO_EEPROM if eeprom doesn't respond */
> > -       if (i2c_probe(EXPANSION_EEPROM_I2C_ADDRESS) == 1) {
> > -               i2c_set_bus_num(TWL4030_I2C_BUS);
> > +       ret = i2c_get_chip_for_busnum(EXPANSION_EEPROM_I2C_BUS,
> > +                                     EXPANSION_EEPROM_I2C_ADDRESS, 1, &eeprom);
> > +       if (ret)
> >                 return BEAGLE_NO_EEPROM;  
> 
> Isn't this in the devicetree? It should be possible to use
> i2c_eeprom_read(). See for example sysinfo_rcar_probe().

No, it isn't in the devicetree. This EEPROM is on an optional
expansion board.

Thanks,
Anatolij
