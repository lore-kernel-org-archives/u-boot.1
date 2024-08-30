Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9E8CA1009
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 18:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4F288CE1;
	Fri, 30 Aug 2024 20:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725043874;
	bh=OIxedxG246OqJIj+IBVn686zMJMfkcfdLMRwAQu8hh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o3uYHN0Frc7ClD2pZSlmgCL7M+1mCpJ/7b61nJ7Yd6M3SvG8uenV3+JSRCRe6CpyW
	 mfjixRYpn9FPLErvgWNoj/5z3PJRJGWUeGDmQSvyuOGAB5Ymy528gjm9Mhql3ZWtR1
	 VsMo6WmpI2dfWUvzSgidEIxqbhqrEe88+sT50uPvmk6+lNzJ7MTBteB59olIkI8UsG
	 o/A/Udexc54V9t/39ikaWv4vu5qHKNbYEt57WM9beoeS1SkI5uSUdvnP55rbiSmIgb
	 oQYSWmxVE/4hB/uFh9Xei1LfTxF8wRTSdLxe/D3UK4teRLzhOnBCP0g6hNnq9pi/RY
	 p973U4OIbtTTw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5486B8876F;
 Fri, 30 Aug 2024 20:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725043872;
 bh=OIxedxG246OqJIj+IBVn686zMJMfkcfdLMRwAQu8hh4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Cp8EImLBK2baIcY30/+HumbQYNOGKcEEy2DBqpFRzLS2vSHW1dGvDgyx52xBfTwqt
 Ahs/2t/x3gWn7KPmgd+9psykcmfmE2e6ALnq3a0W5yr3aW5VpYCuMGmc5c6Y7zyjpM
 3txTodbiPZBNfBc9jNYYf/9qQ7NAJbDwqCS6sQFEJ5+r8wM5gVeYojWWzL5ZgVMqQy
 L6LNyY/OOMxKDalZ0eyLmeu294UK3qbsOx4DiAL8Rt+BsbmX8/DoavB4CDeV/t7uSa
 OBRCLB4IEtTk4fOwAMyixep0jGH4pZFcN5XKfgagzbX4REKyPSfoBcR53MIf5OoX7D
 ioUR0rDHgBuAQ==
Message-ID: <bdc1a1aa-2780-4eeb-b799-6ecc0b7bc322@denx.de>
Date: Fri, 30 Aug 2024 20:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Soeren Moch <smoch@web.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240830182330.49528-1-sebastian.reichel@collabora.com>
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

On 8/30/24 8:22 PM, Sebastian Reichel wrote:
> Hi,
> 
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
> This version has been tested on Radxa Rock 5B using the open source TF-A
> (patches recently got merged into master branch) using the following power
> supplies:
> 
>   * non PD capable (reports 5V 0A)
>   * RavPower 90W (ok)
>   * UGREEN 100W (ok)
>   * Anker 45W (ok)
>   * RavPower PB (hard resets in U-Boot, but succeeds at some point,
>     I still need to investigate)

I am happy with this series, as long as Jonas also says yes, this should 
go into u-boot/next . Thanks !
