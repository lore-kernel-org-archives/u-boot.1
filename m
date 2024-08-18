Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BA3C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 20:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9078388953;
	Sun, 18 Aug 2024 22:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724014285;
	bh=w5sZCcSbkKAARtVZfpDiK58MaHiZsENA5jzKa5ursaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ale/IRsjEM5PfDYA2WgY/Kc/Chb1E5j2lOjV5bWksDNc4gAjPSuenBBOurDbaPG/e
	 gLLRvru4fpHxokaFfofKGMYIfXvchBMhT5pEGYgb7f/ZcSZHkK9lS7DknlQ6oC26fD
	 0ZF9/753FeVpkcwed7n43G636wdmUc9UfDmeq2zovppJDNHGU8evz45xGPNizAnASL
	 SDQu7zRNihhmsz9oLq5ELHRks2BCockL9o8MwbBTnjUjE/Buq4NU91Dr3/seq7gt1V
	 p6IqkjGpN6ymaBUC4P3rBF5MpRq4NcOoerYwDLLqYLHuRAlX3JaSygGGGby67waNip
	 cy0NhKuHCsH7g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8F52A8865D;
 Sun, 18 Aug 2024 22:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724014284;
 bh=w5sZCcSbkKAARtVZfpDiK58MaHiZsENA5jzKa5ursaA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=r+TlxnO0BH6h1FmzeunP8pPrCFJgFl5/cEmgErxoi/n9OJzg91Z+HmYql8bpkVGhi
 j3nPcMbzDQTIQ65/A9bPMZLLhZBv+PLgRRO2UqZp35yhQuaXrx/ps1Hclf50EwRp1c
 xAnub3hxx3pCAglopuSxifrOcTJpnlEpnzXArjFC6lJY8Ogl+0O1vZe5Hvt8DkVvcY
 Y+Qaihoo/FTPxvcomDpNiwBHt/PZNUtEoZ3ijetzqje2C0CmKZXxATnoqpfJcZyOE8
 XrXPInz+JIkY2XP75reMrNtjiHgDfNfNOir1WJObzGCLnneMP4hE/Pa1wyat8coSsO
 uU7XLxc+ZzYPA==
Message-ID: <d3c80c56-ebb0-4b6f-ac92-15cd646feb27@denx.de>
Date: Sun, 18 Aug 2024 22:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 u-boot@lists.denx.de, Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Simon Glass <sjg@chromium.org>, Soeren Moch <smoch@web.de>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240802180027.139193-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/2/24 7:59 PM, Sebastian Reichel wrote:
> Hi,

Hello everyone,

> On ROCK 5B power is usually supplied via it's USB-C port. This port has the
> data lines connected to RK3588, VBUS connected to the input regulator and
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can be
> accessed via I2C from RK3588. The USB-C controller is needed to figure out
> the USB-C cable orientation, but also to do USB PD communication. Thus it
> would be great to enable support for it in the operating system.
> 
> But the USB-PD specification requires, that a device reacts to USB-PD messages
> send by the power-supply within around 5 seconds. If that does not happen the
> power-supply assumes, that the device does not support USB-PD. If a device
> later starts sending USB-PD messages it is considered an error, which is solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltages are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an machine
> reset. This is currently worked around by not describing the FUSB302 in the
> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
> 
> 1. the USB-C port cannot be used at all
> 2. the board will be running via fallback supply, which provides limited
>     power capabilities
> 
> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, so
> that we react to the power-supply's queries in time. The code, which is
> originally from the Linux kernel, consists of two parts:
> 
> 1. the tcpm state machine, which implements the Type C port manager state
>     machine as described in the USB PD specification
> 2. the fusb302 driver, which knows about specific registers
> 
> Especially the first part has been heavily modified compared to the
> kernel, which makes use of multiple delayed works and threads. For this
> I used a priorly ported version from Rockchip, removed their hacks and
> any states not necessary in U-Boot (e.g. audio accessory support).
> 
> Sorry for the delay in getting PATCHv3 ready.

I am the one who should be sorry here, really, sorry for the abysmal 
delay in my replies.

So ... this series looks good to me. Thank you for working on this !

Jonas, are your concerns resolved ?
