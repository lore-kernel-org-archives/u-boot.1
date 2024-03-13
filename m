Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897BBC54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 11:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84C987E92;
	Wed, 13 Mar 2024 12:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gerhold.net header.i=@gerhold.net header.b="jP4KHsFY";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="YZdDM6oS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBAA987E75; Wed, 13 Mar 2024 12:29:09 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091A487E47
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 12:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=stephan@gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1710329342; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=crPIkn9lc7VflqWPZlz5LgmH4JNqYDYtYJZWeP/0RJIY3bIHfOa0ZcMAgqVfic/3eR
 hZD++9QBkxNDhifKEwbhCQnKQjQkYtb1FyC+OR816Ll2MISvgfnfB+k6twWUj10A3y6v
 kC7EKvY9s272M2f0GUa2g7AWBtxQPEs0BNUTQtRW5GN6fk7+jaL2bjBN3jklqT7UNqz7
 cIP6QtogjEJpPmlfhwC4bjjn+wOgT96mfZPdUZHurZ5VoEdiKqMlCMTnCnHKV8nJ43bn
 tpkwIz6U1s02cVu0VuJEwZ6oaG8IuFcCgNgWNVcJg9L0+/2d7WlKA6VYHQm3xJveKYWw
 r4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710329342;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=cjQKXGsIjBl7HcQXEDuASk+vxBqSqw3wFZwt/Nf9eoM=;
 b=tiHiwsIGuWWgauqPpLR7zNf+keVK++58a+8akT+Kogk7q2aXI3G07Ag3Gsmz4IEjth
 kgWirhnBXLsOFZbE8hoWtqs1KjLKIkfd4y52FXxsZhL1CPonq9iiCHmrj+6NgBu4tz8D
 HMqIZ5G0QsLW3XZk8ZqxnhEj7L3PRTXmvA6gNYqwym8s3d/KlDuIxm0bvwQsZP6PmP0g
 u/um0eeBE0KmxwOQ31xOWe3Ur2614Gr49D3h7AyCMez56PjDIIGVAdR7p1bMW/xZjlS8
 RJGaUlhqxJfY8zaQTmGihDip4qI4IkEG+ubeZPUGxYb0ZH1mqb/EKhRRz/NPFcOcX8kR
 S2Hg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710329342;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=cjQKXGsIjBl7HcQXEDuASk+vxBqSqw3wFZwt/Nf9eoM=;
 b=jP4KHsFYZxVfxuRlqKkUX9n8Ux5pr57G02RKnYtAVnL/wrziF+qTu8x3jR64lVIxzE
 /uRrl+pJdUhqV12l9nF9zhRZzO7BpwVa0ad6+KHTSlfrt6rZXK8CbHhXxO+G6dWuSDnZ
 Zu+ZRAzk8PE1IeSZsm7E84wJCuMwnr1ZRYLySSnXAUU2oVMBtePcoQ57IA5QJXfgeW8H
 CEyA65JCBSTyNHWhGI9yi1WwgDvRl+5aZSc8ASj5Uy2AbVN5NcKaNVnIoQdD5EU/iZwK
 Vyd/4QLSm8kGhoPSUACJeFev7JxfNNN+eiljii7xAaUMcbXR2co9WsVxnS16k5kBSjKA
 6Lug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710329342;
 s=strato-dkim-0003; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=cjQKXGsIjBl7HcQXEDuASk+vxBqSqw3wFZwt/Nf9eoM=;
 b=YZdDM6oS8Vs6T8yJYUnNnJMRffCuRv/r4EKdUEVSp6EFRIAEyeqMO2+P+aroBLKrZg
 jNMdNaJwNt6JR425JnAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net by smtp.strato.de (RZmta 50.2.1 DYNA|AUTH)
 with ESMTPSA id R97a4502DBT13JS
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 13 Mar 2024 12:29:01 +0100 (CET)
Date: Wed, 13 Mar 2024 12:28:54 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
Subject: Re: [PATCH v2 5/5] board: add support for Schneider HMIBSC board
Message-ID: <ZfGN9j3Nb2CIoy_e@gerhold.net>
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-6-sumit.garg@linaro.org>
 <Ze8XM9cvZt7fSYg5@gerhold.net>
 <CAFA6WYOP2Y2byfTWVKv5j6Yu61q64hG_JHBRDspabnybh5KMSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOP2Y2byfTWVKv5j6Yu61q64hG_JHBRDspabnybh5KMSA@mail.gmail.com>
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

On Wed, Mar 13, 2024 at 12:08:58PM +0530, Sumit Garg wrote:
> On Mon, 11 Mar 2024 at 20:07, Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Mon, Mar 11, 2024 at 04:40:26PM +0530, Sumit Garg wrote:
> > > Support for Schneider Electric HMIBSC. Features:
> > > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > - 2GiB RAM
> > > - 64GiB eMMC, SD slot
> > > - WiFi and Bluetooth
> > > - 2x Host, 1x Device USB port
> > > - HDMI
> > > - Discrete TPM2 chip over SPI
> > >
> > > Features enabled in U-Boot:
> > > - RAUC updates
> > > - Environment protection
> > > - USB based ethernet adaptors
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> [...]
> > > +     gpio_rs232_high: gpio_rs232_high {
> >
> > Pretty sure DT schema checks would complain about this node name (need
> > -state suffix, no underscores).
> 
> We have the dtbs_check in U-Boot too. I will use that before posting
> the next version.
> 
> >
> > > +             bootph-all;
> > > +             pins = "gpio99";
> > > +             function = "gpio";
> > > +
> > > +             drive-strength = <16>;
> > > +             bias-disable;
> > > +             output-high;
> > > +     };
> > > +
> > > +     gpio_rs232_low: gpio_rs232_low {
> >
> > Same here.
> >
> > Also, since I'm looking at this a bit more closely now, are there maybe
> > more clear label/node names you could use here, or a comment you could
> > add what exactly these pins do? I guess this enables something about
> > RS232 but it's not clear what exactly.
> 
> Actually these GPIOs are a mux to select among different UART modes
> (RS232/422/485). This configuration allows you to select RS232 mode.
> How about following label/node names?
> 
> uart1_mux0_rs232_high: uart1-mux0-rs232-state
> 
> uart1_mux1_rs232_low: uart1-mux1-rs232-state
> 

Hm, is it a 2 bit mux selector like

	gpio99	gpio100	UART mode
	0	0	?
	0	1	?
	1	0	RS232
	1	1	?

and the others are RS422 and RS485? If yes, a comment with the table of
the function assignments would help a lot for clarity. With that,
precise naming would not be that important anymore. :-)

Thanks,
Stephan
