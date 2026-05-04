Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397E2FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 08:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D578394E;
	Mon,  4 May 2026 10:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C28C83EF9; Mon,  4 May 2026 10:32:14 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3E680F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 10:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1wJoih-0007PT-7y; Mon, 04 May 2026 10:32:03 +0200
Message-ID: <2eeccc2c-069e-4b91-adca-2917a24372d2@pengutronix.de>
Date: Mon, 4 May 2026 10:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Beleswar Prasad Padhi <b-padhi@ti.com>, afd@ti.com, bb@ti.com,
 anshuld@ti.com, hnagalla@ti.com, jm@ti.com, nm@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-2-b-padhi@ti.com>
 <20260427195405.GL41863@bill-the-cat>
 <9863b81f-e6ad-41cb-8e02-4f22377d0137@ti.com>
 <20260428140606.GR41863@bill-the-cat>
 <CAFLszTgBzgYYF8s9u_5=-4Yd-zV5Z+wNF5SzP6M+MSowRreJOA@mail.gmail.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <CAFLszTgBzgYYF8s9u_5=-4Yd-zV5Z+wNF5SzP6M+MSowRreJOA@mail.gmail.com>
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

Hello,

On 4/29/26 4:23 PM, Simon Glass wrote:
> On Tue, 28 Apr 2026 at 08:06, Tom Rini <trini@konsulko.com> wrote:
>> On Tue, Apr 28, 2026 at 04:26:31PM +0530, Beleswar Prasad Padhi wrote:
>>>> I guess the real question here is, does the spec allow this to be
>>>> omitted like that?
>>>
>>>
>>> Could you please point me to the spec? I could not find it.
>>
>> Sure: https://github.com/open-source-firmware/flat-image-tree/
> 
> It is mandatory for kernel and firmware images. Instead of allowing it
> to be optional for 'kernel', we created 'kernel_noload' some years
> back.
> 
> Which image type are you using in your case?

FWIW, barebox has always interpreted lack of the load property to mean
that it should just compute a suitable address itself (i.e. free memory
aligned as Linux expects on that platform - same as kernel_noload).

Writing that into the spec also allows for Beleswar's use case here,
although it doesn't give the guarantee that the address will always be
the image address.

I think that giving a guarantee about the image address is wrong:

- If the code is not relocatable, then its load address can equally well
be written into the FIT image node

- If the code is relocatable, then forcing the load address to be the
image data addresses will make non-external FIT unfeasible for most
users, because of code having the wrong alignment and for external FIT,
it will mean careful placement of the FIT itself is required, so we
don't end up with misbehavior at runtime.

I thus suggest, the spec leaves it to bootloaders to select appropriate
load addresses if its missing and if the bootloader can't, it should
refuse boot (current U-Boot behavior). Future U-Boot behavior will
likely need to be adapted, so this loading at image data address is only
done for these specific firmware images and not in general as otherwise
it would preclude any other use in future.

Cheers,
Ahmad

> 
> Regards,
> Simon
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

