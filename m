Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B13AC54E58
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 08:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC18B87FA1;
	Tue, 26 Mar 2024 09:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="KpYOgWj1";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BNSSwmSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25A987E47; Tue, 26 Mar 2024 09:40:45 +0100 (CET)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8556687FA1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 09:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=janne@jannau.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 55D4911400C5;
 Tue, 26 Mar 2024 04:40:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 26 Mar 2024 04:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1711442441; x=1711528841; bh=uLDslNtMa8
 UbGGtc66/a8tBxA69zC3b2k4JuPcT5aAE=; b=KpYOgWj1gDKaLRyYqsaj9a+1Au
 ptoqwLKLWbO/5F5Uq8jlRpVR8XvGHpSMBYqCneB4kUA0zVnNvRNekfMFAhgXKae3
 KwT2JLi6y5XJiL8dZzWjTWTzsM9RqbNw3PTu+8Qs3EN7SxFEqE6LfDVVZKW499hj
 gEJfflvpqHKNck5xiojFaoyG/U2BLMQPTzrBwQpdDaMchQoEZR3c5bZU85vQjYT8
 4eHSr+tBSlYrNzzJKslaw/REk3N95/c9WVlwvTTfcQ5Mj1MOzPZGVakxcc9Fw3s7
 StVVAkQ0MAY4urFlSJfIEOPt+eMXiBaEpn2iQFez9HB45Vkz9x5uPmEIWL8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1711442441; x=1711528841; bh=uLDslNtMa8UbGGtc66/a8tBxA69z
 C3b2k4JuPcT5aAE=; b=BNSSwmSvqX8y0gHbBOoIaRKHkV5f3xGovyNFJLjvjU3H
 Bc1R7qg8kVM4EC6o39gaKAZpL40yqOipf6L0CdjngZ1QP3ptvkK2VOjSaDc4qcpo
 884wTgKlvCAPS0oNx0m6ve+X3KJNrIMyKn7NvDcaN37Jg2QNosn0ciZTf11pYLaH
 Etw5CFsZK1MDReIQyRxLCRV8K8dE8Xcos7/4amHuVWmXxnWqYjbRDY3xjg1elJlz
 q1VPJXP4Ak0E4MKxHkIt3wyiXkdlf8Wts/8iTT2fGWH7NH2T7ZF6ehnedx/kE1Wo
 FqdE6iso4S+WaGda2bgJHWlbOXgtTnqoV/00LZtGmA==
X-ME-Sender: <xms:CYoCZhi0aM5OnPAosksf4SKFS4o5Ts1QPW6XLMC10seW67Ai1CTHvw>
 <xme:CYoCZmBaeBK3hLSmoYff1J8MQFUBfQJ3vOtJs_HbD-DzVr7frl_6bP7NpBchRmofv
 _QUUscKchROqgaCB28>
X-ME-Received: <xmr:CYoCZhETUYY0fRkvuTD0-tTn0baRYXow_doYtwJDq4b6ls4camvw5E4ztcjZpNOASF7HtO9OecjdK7d8SZurwLD9TfzVM9_HXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduvddguddvfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghn
 nhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnh
 epgfdvffevleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrnhhnvg
 esjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:CYoCZmTQNZ7uhmO0OlZHHLlKbd4prURRM0iZpMLjddU39eVO-1DLfg>
 <xmx:CYoCZuxWl8YoYSDSTjv8N4rRQ0hEnK1Xe8fv_C26t7Vfs7hdo8MUJA>
 <xmx:CYoCZs6m_tDXGUpWD6aDNB3fgFN01DObQf1YQGhttY_1xvA8eG27rg>
 <xmx:CYoCZjyrz6LnvXXcA-gvC4xknllgaSfeuFoOXeD4cKAubEnMWRPDTA>
 <xmx:CYoCZifSr6Es8RS8us67SVK-oAaaklxWYijRtGABc4MW4UnqU0bNJw>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 04:40:40 -0400 (EDT)
Date: Tue, 26 Mar 2024 09:40:39 +0100
From: Janne Grunau <j@jannau.net>
To: Marek Vasut <marex@denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de,
 asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v3 4/6] usb: Add environment based device ignorelist
Message-ID: <ZgKKB_j02eAVltTs@robin>
References: <20240322-asahi-keyboards-v3-0-3106dd4c4e19@jannau.net>
 <20240322-asahi-keyboards-v3-4-3106dd4c4e19@jannau.net>
 <fcc7e54e-5e52-4b27-bc0c-801954ccf0ca@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcc7e54e-5e52-4b27-bc0c-801954ccf0ca@denx.de>
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

On Fri, Mar 22, 2024 at 12:56:37PM +0100, Marek Vasut wrote:
> On 3/22/24 8:47 AM, Janne Grunau via B4 Relay wrote:
> 
> [...]
> 
> > @@ -1099,6 +1142,20 @@ int usb_select_config(struct usb_device *dev)
> >   	le16_to_cpus(&dev->descriptor.idProduct);
> >   	le16_to_cpus(&dev->descriptor.bcdDevice);
> >   
> > +	/* ignore devices from usb_ignorelist */
> > +	err = usb_device_is_ignored(dev->descriptor.idVendor,
> > +				    dev->descriptor.idProduct);
> > +	if (err == -ENODEV) {
> > +		dev_dbg(dev->dev, "Ignoring USB device 0x%x:0x%x\n",
> > +			dev->descriptor.idVendor, dev->descriptor.idProduct);
> > +		return err;
> > +	} else if (err == -EINVAL) {
> > +		printf("usb_ignorelist parse error in \"%s\"\n",
> > +		       env_get("usb_ignorelist"));
> 
> Please use dev_err() here consistently with dev_dbg() above.

I didn't use dev_err() since the parsing error is not specific to the
device. It doesn't matter much. I'll change it and resend after we've
settled the new discussion about the interface limit.

> With that fixed:
> 
> Reviewed-by: Marek Vasut <marex@denx.de>

thanks,

Janne
