Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E3AC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 06:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620B081026;
	Tue, 22 Apr 2025 08:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6F1810E8; Tue, 22 Apr 2025 08:59:28 +0200 (CEST)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 328968056A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1u77bG-0000Pe-FA; Tue, 22 Apr 2025 08:59:22 +0200
Message-ID: <f3e3ec38-8132-4e7d-882b-fd88623451bc@pengutronix.de>
Date: Tue, 22 Apr 2025 08:59:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>,
 u-boot@lists.denx.de, vigneshr@ti.com, robertcnelson@gmail.com,
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com,
 m-chawdhry@ti.com, a-nandan@ti.com
References: <20250416073058.1441001-1-anshuld@ti.com>
 <20250416112418.nod2fut4v77qlmfq@hummus> <D983ZXCIAF06.2I0POMKUFPF2L@ti.com>
 <20250416150506.ws22odswwkjn2wth@deflected>
 <8146a036-681d-4c45-9285-c58259fec14b@ti.com>
 <20250416195113.mtfdclfvb756vpll@scoreless>
 <D98SY3X7C15U.15HUGCO6FK1T0@ti.com>
 <20250417113013.mrlhl65farooaiq2@extradite>
 <20250417141603.GW5495@bill-the-cat>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20250417141603.GW5495@bill-the-cat>
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

On 17.04.25 16:16, Tom Rini wrote:
> On Thu, Apr 17, 2025 at 06:30:13AM -0500, Nishanth Menon wrote:
>>>> I dont see a specific value here. U-boot just works. For folks who want
>>>> direct TFA to kernel jump (which is a niche fast boot usecase), go ahead
>>>> and use TFA with the mentioned build option.
>>>
>>
>> IMHO, there is a simpler alternate solution - build TFA, dtb etc in the
>> model of your desire. let us leave the defaults be.
>>
>> I will let Tom and other U-boot maintainers make their choice, as TFA
>> maintainer, I have already rejected the approach. it is already
>> PRELOADED_BL33_BASE ?= 0x80080000 which allows for override at build
>> time instead of all the massive rework and downstream ecosystem impact.
> 
> Thanks Nishanth. As you point out, all of the relevant projects need to
> stay in sync for this to be useful and I agree with your position so
> this is nak'd here too.

The i.MX folks also did some switcheroos with the TF-A load address (BL31
though [1]) and at least in barebox (running as BL2), it ended up wasting
a lot of time of everyone involved that could have been put to more
productive use.

So thanks Nishanth and Tom for saving AM6x users from the same hassle.

[1]: https://github.com/barebox/barebox/commit/199aabdc7

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
