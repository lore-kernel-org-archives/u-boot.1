Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C25BC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 12:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4CE80079;
	Mon,  3 Feb 2025 13:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1645B80087; Mon,  3 Feb 2025 13:08:25 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0BF8004F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 13:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1tevFW-0004cT-EJ; Mon, 03 Feb 2025 13:08:22 +0100
Message-ID: <9f8dcabf-339c-4051-82bc-178e0047f886@pengutronix.de>
Date: Mon, 3 Feb 2025 13:08:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: u-boot in restricted environment: networking over serial
To: Ferenc Fejes <fejes@inf.elte.hu>, u-boot@lists.denx.de
References: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hi,

On 30.01.25 14:55, Ferenc Fejes wrote:
> Hi,
> 
> Is it possible to use the serial port for u-boot networking? For example, given
> a restricted environment where the FIT image is available with ethernet firmware
> and drivers, so it is not possible to boot it with DHCP boot since there is no
> networking. Or simply the ethernet NIC has no u-boot driver at all. For such
> cases, I assume ymodem is recommended to download and boot the FIT image.
> 
> However, experimenting with different images and debugging, it would be more
> convenient if serial could be used as both data and console channel. Is this
> possible?
> 
> A simple example:
> 1. ppp on the host machine, with IP forward, NAT, etc.
> 2. u-boot establish a ppp connection over serial to the host
> 3. u-boot starts a netconsole session to the host
> 4. user can use netconsole and wget to download images
> 
> I was thinking of PPP, but that's probably not supported by u-boot. Anything
> similar with RNDIS and USB CDC ACM?
> 
> Thanks in advance for any hint!

If you are willing to implement it, there's RFC 916 (RATP), which
addresses the use case of establishing a reliable communication link over
serial. We use it in barebox to mount remote file systems via serial.

If you were to implement the same support in U-Boot, you could reuse
the host-side bits without change (and take inspiration from the barebox
implementation of the target-side bits).

https://github.com/barebox/barebox/blob/master/fs/ratpfs.c
https://www.barebox.org/doc/latest/user/remote-control.html

Hope this helps.

Cheers,
Ahmad

> 
> Best,
> Ferenc
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
