Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6A3C021A4
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 11:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E546680B98;
	Fri, 14 Feb 2025 12:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E1C80C6F; Fri, 14 Feb 2025 12:01:33 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A33C80756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 12:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1titRq-0007iC-HA; Fri, 14 Feb 2025 12:01:30 +0100
Message-ID: <8b8b8f4e-0709-4d4d-809c-c697bbc2bca6@pengutronix.de>
Date: Fri, 14 Feb 2025 12:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: u-boot in restricted environment: networking over serial
To: Ferenc Fejes <fejes@inf.elte.hu>, u-boot@lists.denx.de
References: <4fcb9244e87d5bb4a53075775247cecde2f9e3fa.camel@inf.elte.hu>
 <9f8dcabf-339c-4051-82bc-178e0047f886@pengutronix.de>
 <4ff910a006c5bb7c9fe1b460d426b4cf86059c28.camel@inf.elte.hu>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <4ff910a006c5bb7c9fe1b460d426b4cf86059c28.camel@inf.elte.hu>
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

Hi Ferenc,

On 03.02.25 13:31, Ferenc Fejes wrote:
> On Mon, 2025-02-03 at 13:08 +0100, Ahmad Fatoum wrote:
>> On 30.01.25 14:55, Ferenc Fejes wrote:
>>>
>>> Thanks in advance for any hint!
>>
>> If you are willing to implement it, there's RFC 916 (RATP), which
>> addresses the use case of establishing a reliable communication link over
>> serial. We use it in barebox to mount remote file systems via serial.
> 
> Thank you for the pointer, good to know barebox have such a feature! I assume
> the license permit what you suggest here, right?

barebox is licensed under the GPL-2.0 and IMO U-Boot would do well
to port over some of the generic niceties, which is why I am
pointing them out to prospective porters. :)

>> If you were to implement the same support in U-Boot, you could reuse
>> the host-side bits without change (and take inspiration from the barebox
>> implementation of the target-side bits).
>>
>> https://github.com/barebox/barebox/blob/master/fs/ratpfs.c
>> https://www.barebox.org/doc/latest/user/remote-control.html
> 
> I'll look into this. This looks like an interesting challenge or even better,
> add SoC bits to barebox (probably that is more work).

That would be cool. ;)
I got a Mediatek Chromebook that I intend to port barebox to (mt8186),
which possibly shares IPs with your router. But that's getting off-topic.

> BTW I have a MT7986 based router and I wanted to install Debian on it. In the
> process I encountered even though the ETH PHY supported by upstream, and linux-
> firmware have the required bits as well, none of them included in the installer.
> So I facing the same issue on Linux side as well :-) 

Meh, but surely, you can reach out to the Debian developers to get the necessary
drivers included.

> On FOSDEM '25 I noticed
> usb9pfs contribution from you, I really like that idea as well!

Thanks! There are some rough edges, but I believe this can be very useful once
the necessary parts land in diod, barebox et al.

Cheers,
Ahmad

> 
>>
>> Hope this helps.
>>
>> Cheers,
>> Ahmad
>>
>>
> 
> Best,
> Ferenc
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
