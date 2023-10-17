Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990A9CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D6C86ECA;
	Tue, 17 Oct 2023 14:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697547435;
	bh=gKuLn8Gq0Pk000y0mZ4kuHTH0m2EzVOPPhLj46f0d+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=va22gN+7/XJ2p0yBa9EkrIgIOiX3OgiWwia50eh56NyShsR22lO/H+zT7D1ADFC2A
	 nTYdoVtISn3HMhR/g11C2mer8s33fK6aEXsxxyW0+dCfI1sjAlYs+Ut35JqTUZUc0P
	 gnYel5q0tR53dFW4xwRR9Nt8vjLWodJV8392eORgCGAzmrNpBsiI0E5Tw+uIVCKRPQ
	 Nacc8MkBaWMEHcBq3hdTemGK7QZL53hZw9CyVafJV4n84lLGZj1YtzDiERYj+Avf1G
	 JA7Xlj2PREDEYRc3dYsVn9Y2Mp6OgIpqE65FZpXavWsNCmuqTnuMyG4sYSG6kNFFIm
	 B4qfMrC/ay9PQ==
Received: from eryximachos.home (unknown
 [IPv6:2a01:cb18:989:a700:4b67:3ae7:15fa:40a0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9F4AD86E1C;
 Tue, 17 Oct 2023 14:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697547432;
 bh=gKuLn8Gq0Pk000y0mZ4kuHTH0m2EzVOPPhLj46f0d+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qnuSqlRYOLRKZaSKiG5fFhLtbqyswLBXf5eQjWbRYSC1ZZTRkhTX6Y+tg053SyTl0
 tcw6z2kWJC2x/GuoefYcdNnQGA+0QBPL7jkoVIcM7Ulmv1mPpBS/PXBC7GWdxRAAn9
 sE7vyjH92gbRcGvEwuM4RiMTFA/RXZVbFkiQN0gGwaOIhuas1ezsi4Tf0FBPM9NP4u
 RaFOXpvmLSHi+DvmzBdgvkTEWWzhMk0iDVCIjmNo9qfltzuI4MeSdeY5eiA2ZyXaST
 cx/DrWk9jpFU7NKHhLJIZnGqw6rhz48TVaHTL4j8tITOwoYlxBxkLTyA6QX3e+OnLM
 0CI6NxJDHhgtQ==
Date: Tue, 17 Oct 2023 14:55:43 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>, trini@konsulko.com
Subject: Re: [PATCH 2/2] bootcount: Add driver model I2C driver
Message-ID: <ZS6ET7ExtDSCfsNN@eryximachos.home>
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-3-pro@denx.de>
 <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
 <ZSk-2lBrLW5Bel_X@eryximachos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSk-2lBrLW5Bel_X@eryximachos.home>
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

maybe you can give me a hint on how to implement this cleanly in driver
model?

To sum it up, I'd like to have a phandle pointing to *any* I2C device,
not knowing which UCLASS actually fits. Then the device and the parent
bus should be probed/prepared such that dm_i2c_read() can be used.

Any ideas on this?

Best regards,
Philip


--
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================

On Fri, Oct 13, 2023 at 02:58:04PM +0200, Philip Oberfichtner wrote:
> Hello Heiko,
> 
> On Fri, Oct 13, 2023 at 01:28:47PM +0200, Heiko Schocher wrote:
> > [...]
> > > 
> > > 	bootcount {
> > > 		compatible = "u-boot,bootcount-i2c";
> > > 		i2c-bus = <&i2c1>;
> > > 		address = <0x52>;
> > 
> > Hmm.. do we really need this here with DTS. Why not using a phandle
> > to a real i2c device? Something like this for example:
> > 
> > 		i2cbcdev = &i2c_rtc;
> > 
> > with
> > 
> > &i2c1 {
> >         i2c_rtc: rtc@68 {
> > [...]
> > 
> > and so there is no need for knowing the bus and address ...
> > 
> 
> Yeah I agree that would be much better, but ...
> 
> > [...]
> > 
> > when you use a phandle, you can replace the part from reading "offset"
> > with this:
> > 
> > 	uclass_get_device_by_phandle(UCLASS_I2C, dev, "i2cbcdev", &priv->bcdev);
> > 
> > of course plus error checking...
> 
> This does not work, UCLASS_I2C is used for the *bus above* the device we
> actually want.
> 
> Next thing I thougt about: Why not use the UCLASS_I2C_GENERIC. But this
> expects a "i2c-chip" compatible string, which our rtc or whatever device
> obviously does not have.
> 
> I think using UCLASS_I2C_GENERIC might indeed be the best approach.
> Maybe using something like 'device_bind_driver()'. But again, this
> expects the parent device to be there already as far as I can tell.
> 
> Any suggestions?
> 
> Best regards,
> Philip
> 
> 
> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct bootcount_ops bootcount_i2c_ops = {
> > > +	.get = bootcount_i2c_get,
> > > +	.set = bootcount_i2c_set,
> > > +};
> > > +
> > > +static const struct udevice_id bootcount_i2c_ids[] = {
> > > +	{ .compatible = "u-boot,bootcount-i2c" },
> > > +	{ }
> > > +};
> > > +
> > > +U_BOOT_DRIVER(bootcount_i2c) = {
> > > +	.name		= "bootcount-i2c",
> > > +	.id		= UCLASS_BOOTCOUNT,
> > > +	.priv_auto	= sizeof(struct bootcount_i2c_priv),
> > > +	.probe		= bootcount_i2c_probe,
> > > +	.of_match	= bootcount_i2c_ids,
> > > +	.ops		= &bootcount_i2c_ops,
> > > +};
> > > 
> > 
> > bye,
> > Heiko
> > -- 
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
