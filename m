Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E1EC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 06:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E797884F9;
	Thu, 20 Jun 2024 08:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="cXccC3Y1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F438850B; Thu, 20 Jun 2024 08:34:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DFBF884DC
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 08:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718865241; x=1719470041; i=xypron.glpk@gmx.de;
 bh=T+Pl7eZrneZ/Hd5nDgwZOJAIVAZqc9kaT2WPe9cfRIU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cXccC3Y1iFhoZvvDyVF+bNaKYgOdcAItm5VH1ZTUHo6O+2WZleiuRAfaZxpGJza+
 343AecfiC+CW6TFEnjOJpR1xAxTZX3e/ebs0fO2UnY8qpo/uD1Oua8UM4Sh4N3zPX
 fmTz8b6/erKe4JLEqE+6AALBYWfhrN99w1YnD3+WsT1afhOLMsis13w2HCKuG2xkS
 /oEdLA+Fd4pL+oh7LF9/ZyzaMKh/mtUPiKg6PJyVy1cCSsjpQe7Rx6lTzhqVbdPhi
 Tbix8Tre5it8lyDVab/kRYy/mo59rpvY1yE6qLGjvFgQefWvGuP85DYE8Uw2mgn3H
 9x1QjC9+esml0nVayw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1sXjyR2GZi-00ynO4; Thu, 20
 Jun 2024 08:34:01 +0200
Message-ID: <62bdc69d-edf8-422c-a6dd-4d50e1cdc1d1@gmx.de>
Date: Thu, 20 Jun 2024 08:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] misc: introduce STATUS LED activity function
To: Christian Marangi <ansuelsmth@gmail.com>
References: <20240619230400.8459-1-ansuelsmth@gmail.com>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Dmitry Dunaev <dunaev@tecon.ru>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240619230400.8459-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kJr4Jslf4cl0dE5e2SK9jqIOE2Ru7LDTe/uOS/heptS1SF7sxWF
 ZdqbxsJl9ytYADf/Kn47SvWP3GLXmDECyE+7JNxWhBE+U79aur0RPFDBAdB0MVsKBk7RLW4
 WHRbXpsZVYWHtJ7mgp02E8Z0/hJ46Din4Kz/h62d1sh7Rxtb8+v+N3/4lZ5oLLw/PPitMeE
 CMkjcFgJVZVsj8YW7F1Tw==
UI-OutboundReport: notjunk:1;M01:P0:iaLLAsYzMbE=;ZHW7P0JJYQ4CcqdpA2F1Ly7fTm4
 ZSTy+sjX/pz/GBqPPNn0kxnsHe2mQo5XySMFu03mcFmO12zK9q/GXI5jHb9Ol6iANChFuTQ0n
 JC09/LcXSPSa51bxXuOImv5TSKQBastKsi5/jiEgxukTXhrCO1u8PTu+QQ5kAURp/16YHUqEk
 R9jJoBmOR5SIubTIWKqvzpVbKQjCgO0bHzYDXzXkICvXiMJo3khCSHaVafhnCQw4B9ank1Go+
 7ogBGJmsqV/LhHWooDhd7WgK9w4SwpzrDHS6rQKb/TABcvE03D8aLf5ep67ZFFDtgPFUtngy3
 2t+AI1LPYVU3dqili6Mhe2LJk3TPHvZRfHp58s8wW4k0eokNjA0LtXs/bsQbsUI5EpRNyfZWn
 xgXbhiu0iB0YoUJN694Lgne3/5G1W003/usaKa1jtyjpZecpLFH0oIQnmfRatU65B0j1ZKqha
 9hmrUdliqaa6aVqn37Utm76zmKxK35GGS7O0+maehP7u2mn3dn1KO6AfngI6CtyCG/02QwcPC
 8mG7gYlavcuSiz9ZokTWa7cmN/gYmk2ofGUdzhkAvprkhfkAsX1YEv59YGuFK/odEfan+HmGF
 YJOeZg+Wd1brEFYJ7d+UT9ZZAU6Due1gwOqCY6Rg1+HhfX6kco0yP6I48ag2PV+047FA+CXnX
 CkPYbMn9aFzMT9elu9KsceCxHwM1OU3Ac0zz0F0ZGNwLZ1X1In62bsdqHKloCC08RmS6HE563
 WIL+NYVnVcWgzEU9P2lxKS2E8iB+oDLZN4eXDEuvG2o669G8iGibddbDat7R2gKHUSxxtkCeb
 3gS594Btm/OuKfTKNTVmXye7S2E4KUd4QiKwnJS4ix/ZU=
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

On 6/20/24 01:03, Christian Marangi wrote:
> This series expand the STATUS LED framework with a new color
> and a big new feature. One thing that many device need is a way
> to communicate to the user that the device is actually doing
> something.
>
> This is especially useful for recovery steps where an
> user (for example) insert an USB drive, keep a button pressed
> and the device autorecover.
>
> There is currently no way to signal the user externally that
> the bootloader is processing/recoverying aside from setting
> a LED on.
>
> A solid LED on is not enough and won't actually signal any
> kind of progress.
> Solution is the good old blinking LED but uboot doesn't
> suggest (and support) interrupts and almost all the LED
> are usually GPIO LED that doesn't support HW blink.
>
> To fix this and handle the problem of device not supporting
> HW blink, expand the STATUS LED framework with new API.
>
> We introduce a new config LED_STATUS_ACTIVITY, that similar
> to the RED, GREEN and others, takes the LED ID set in
> the LED_STATUS config and is used as the global LED for activity
> operations.
>
> We add status_led_activity_start/stop() used to turn the
> activity LED on and register a cyclic to make it blink.
> LED will continue to blink until _stop() is called.
>
> Function that will start some kind of action will first call
> _start() and then at the end will call stop().
> If (on the broken implementation) a _start() is called before
> calling a _stop(), the Cyclic is first unregister and is
> registered again.
>
> Support for this is initially added to the tftp, mtd and ubi
> command.
>
> This also contains a big fixup for the gpio_led driver that
> currently deviates from the Documentation and make the
> coloured status led feature unusable.
>
> (world tested with the azure pipeline)

Hello Christian,

What is the relationship between CONFIG_LED and CONFIG_LED_STATUS?
Can they be used at the same time or should they be exclusive?
Should CONFIG_LED_STATUS depend on CONFIG_LED?

This should be clarified both in Kconfig and in the documentation.

At least cmd/led.c and cmd/legacy_led.c are conflicting as both provide
a command 'led'.

Can we unify the too?

Best regards

Heinrich

>
> Changes v4:
> - Rebase on top of next
> - Rework for cyclic changes on next
> - Fix compilation error
> - Fix compilation warning due to missing header
> Changes v3:
> - Add log on Status LED error conditions
> Changes v2:
> - Add Documentation conversion
> - Rework to Cyclic and simplify implementation
>
> Christian Marangi (9):
>    misc: gpio_led: fix broken coloured LED status functions
>    led: status_led: add support for white LED colour
>    led: status_led: add function to toggle a status LED
>    led: status_led: add warning when an invalid Status LED ID is used
>    led: status_led: add new activity LED config and functions
>    tftp: implement support for LED status activity
>    mtd: implement support for LED status activity
>    ubi: implement support for LED status activity
>    doc: convert README.LED to .rst documentation
>
>   cmd/legacy_led.c          |   6 +
>   cmd/mtd.c                 |  19 ++++
>   cmd/ubi.c                 |  15 ++-
>   common/board_f.c          |   2 +
>   doc/README.LED            |  77 -------------
>   doc/api/index.rst         |   1 +
>   doc/api/status_led.rst    |  35 ++++++
>   drivers/led/Kconfig       |  30 +++++
>   drivers/misc/gpio_led.c   |  41 +++++--
>   drivers/misc/status_led.c |  75 ++++++++++++-
>   include/status_led.h      | 231 +++++++++++++++++++++++++++++++++++++-
>   net/tftp.c                |   7 ++
>   12 files changed, 440 insertions(+), 99 deletions(-)
>   delete mode 100644 doc/README.LED
>   create mode 100644 doc/api/status_led.rst
>

