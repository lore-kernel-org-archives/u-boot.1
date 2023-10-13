Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE1CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B488286E77;
	Fri, 13 Oct 2023 14:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697201972;
	bh=V+cj1IO6p2k/lAVA+zuX/8Iktz7Y/u1/W0FAA30MI78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FYNfhPIGrtie57AfKFYchqbAbTElGryRN1EYnTkEhvU0UobE+LZlVFD4HNRDMTcdv
	 rB0LyqbY8GidD0nLc36DK35RABtoi7CGUYX6Jdp3d69hkvJNQQK+Xin5NOGv0Ejheb
	 FGdyXwwRkOYxtrx1TRzbYC6CfZSBq5Io58/gVWuDBSxuZ/RYhSJlUHiGQ/TlzmCNW8
	 Ol09TTFODC0JF+KhZ/7/3tlnl68WzBd2brFjLUqIc23yB94n7EZYxEkDKaOzwx0owt
	 6gzMCV4DY0oIN1Z/0BznNbJ4a/uZEE9UtA/nHJ08F5qu3Sx3WEXKE9736mOk1JNdSG
	 sFZXNHPx37UJA==
Received: from eryximachos.home (unknown
 [IPv6:2a01:cb18:989:a700:7e7a:91ff:feeb:a1bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D8B4186E5E;
 Fri, 13 Oct 2023 14:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697201970;
 bh=V+cj1IO6p2k/lAVA+zuX/8Iktz7Y/u1/W0FAA30MI78=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OxxE7Q6/vk/0Iazwl/JBXBAl+sB9EkeqyFvQ9pYi4xCsQw3GAANVfhtCcG1Z7wOj1
 OrtyZ/UFlw6Bo3oEqPP6TH/QGiWOdbejy6UWGm4d2MuWHjlBq9IQyRhFjipaiwMn9R
 e90Q0ANG9pSEMsjP9DkMXX60/7jxuSmQOtQbxoIdi2aoLnETHTLontArXjFR2/57P7
 j1BfwA8MqRCHM20nExbxXfUsgVMuAE8nI2ZyxKHKl81pyY4/WvRmwQOjnRRIy9lKIg
 7ycrcj/A0dPvl2+zH6ib4x/wRYCto7BpDTz0V5+OXxckpBVSN4i2s/3qkqiqsDk6z9
 ez1np1/AJc8yA==
Date: Fri, 13 Oct 2023 14:58:02 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH 2/2] bootcount: Add driver model I2C driver
Message-ID: <ZSk-2lBrLW5Bel_X@eryximachos.home>
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-3-pro@denx.de>
 <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
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

Hello Heiko,

On Fri, Oct 13, 2023 at 01:28:47PM +0200, Heiko Schocher wrote:
> [...]
> > 
> > 	bootcount {
> > 		compatible = "u-boot,bootcount-i2c";
> > 		i2c-bus = <&i2c1>;
> > 		address = <0x52>;
> 
> Hmm.. do we really need this here with DTS. Why not using a phandle
> to a real i2c device? Something like this for example:
> 
> 		i2cbcdev = &i2c_rtc;
> 
> with
> 
> &i2c1 {
>         i2c_rtc: rtc@68 {
> [...]
> 
> and so there is no need for knowing the bus and address ...
> 

Yeah I agree that would be much better, but ...

> [...]
> 
> when you use a phandle, you can replace the part from reading "offset"
> with this:
> 
> 	uclass_get_device_by_phandle(UCLASS_I2C, dev, "i2cbcdev", &priv->bcdev);
> 
> of course plus error checking...

This does not work, UCLASS_I2C is used for the *bus above* the device we
actually want.

Next thing I thougt about: Why not use the UCLASS_I2C_GENERIC. But this
expects a "i2c-chip" compatible string, which our rtc or whatever device
obviously does not have.

I think using UCLASS_I2C_GENERIC might indeed be the best approach.
Maybe using something like 'device_bind_driver()'. But again, this
expects the parent device to be there already as far as I can tell.

Any suggestions?

Best regards,
Philip


> 
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct bootcount_ops bootcount_i2c_ops = {
> > +	.get = bootcount_i2c_get,
> > +	.set = bootcount_i2c_set,
> > +};
> > +
> > +static const struct udevice_id bootcount_i2c_ids[] = {
> > +	{ .compatible = "u-boot,bootcount-i2c" },
> > +	{ }
> > +};
> > +
> > +U_BOOT_DRIVER(bootcount_i2c) = {
> > +	.name		= "bootcount-i2c",
> > +	.id		= UCLASS_BOOTCOUNT,
> > +	.priv_auto	= sizeof(struct bootcount_i2c_priv),
> > +	.probe		= bootcount_i2c_probe,
> > +	.of_match	= bootcount_i2c_ids,
> > +	.ops		= &bootcount_i2c_ops,
> > +};
> > 
> 
> bye,
> Heiko
> -- 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
