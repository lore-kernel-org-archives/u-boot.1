Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A81BCD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 08:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091A98486D;
	Fri,  5 Jun 2026 10:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vk4msl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; secure) header.d=vk4msl.com header.i=@vk4msl.com header.b="uM6Kx3PS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5928484F; Fri,  5 Jun 2026 06:47:28 +0200 (CEST)
Received: from gapmx.vk4msl.com (gapmx.vk4msl.com
 [IPv6:2001:44b8:21ac:70f8::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318B083314
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 06:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vk4msl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@vk4msl.com
Received: from gapmx.vk4msl.com (gapmx.vk4msl.com [127.0.0.1])
 by gapmx.vk4msl.com (Postfix) with ESMTP id D9DB159426
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 14:46:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=vk4msl.com; h=message-id
 :date:mime-version:to:from:subject:content-type
 :content-transfer-encoding; s=gapmx; bh=qUtRKK3WYTnish6332Y0chI9
 JBJiSfCAOhWoKQATqr0=; b=uM6Kx3PS+Lj6J+RDa2dQZLV/fejGa2GYLVCoGSjk
 w7SijULGnIhazaJDO47AN+ji9WhmAnvbda7KhTkh9o+l6MZKJneYU1NIKYJlqidA
 O1A58ohLr0R8yC90sYxSA4Fgbq9Hosgby8dKL9oBR/4cKhknCGAxjy1UcDtcR9o+
 HqalKi5jMDwxtIc4pJgH3ZRxEdabbxDQe+077/tUGF9lYYldOSurIqiGWiSUkTBD
 MfFE9Go3ndCFBb1Tk3iagty4S8O8nzDYA9RppwZRLKd1jkJNWXz3I3TF4f0Q1FOD
 yHtbWf4QnMNFiRDuljxtJ2hcGhO9tzHe3euiJAbw6TXRO2hBKKr5yrlh+L2S7Ztu
 T6P7pjjtQBcTgwoXMOjEvhmj4aERUQ0FfV63Xxtmv8f2sklVoE3fIKgW2v+OPPnP
 87UDEdlARXxhAiP3HCcemZXlE2GfvjJxWmYB2dK5t7mPctfaRUcunACRXTNWspcY
 0DBIELC0PNfVji0C98tD/wyfLURKXBrP4UimH8P0sQL8hHUby08yHUDwNYlMGhkC
 JBvQniaV0lnxV4zshoUC/WUedUolrIGXwkFnLdoz4qBmwfQok0jrlSto8nhP+7jj
 PwPDJhY+RXczC0MG6CJN7QscPrInlDTg/LA0pCXHS1u5meNH6rhywbNeRZ4x6EA7
 +34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=vk4msl.com; h=message-id
 :date:mime-version:to:from:subject:content-type
 :content-transfer-encoding; q=dns; s=gapmx; b=gPJ1VEHb6gN7fcvoZX
 g9DqhS9UN6W8ADPmbtHdz64SMPdQa2SU4cCDGWHU3ZWofMccfbr4bymGi7QFpQGX
 q1TyaSTUpfTYrNf58OlvsZ3QgMKhI6d39wNzi7ody7MV6Jg1wjDKElAgKe4o+ls0
 tc6fKEINQCJgdyNZoFmcC2SbD0SsUKIqPD0f0FfnmTvV5rD2V06mhy0jLiBIGoN7
 CXpAZbotXgRRbhMeWN/CwQCKnLX7iLvkRuqf5+VCOIkz7bw7+7uzKfxdW96HBspY
 9ADDYrqSpHO2EiwRFmWsrLz0og/iq6FRZwhFV4JN3pmeF+k4Euw1Yf7q4ZQI84ck
 mBxtp4ZzknlRfnFO6xHn+Dv56zOosG031bRBMGMJqFvS8yso8AQA30yZwuvxKXvv
 f1ZjM6f85OBFCvGnl3synCW5dg13DlzfRDp0dF12SkK2rxa2Xy5P3t3fTKg1oqtQ
 SoxPbCaPY2zZsSVyRfnMhD63RuY2C92SkzdQ8w24QsWXsWE+pm24ycURc4x53kuw
 sbz13BOn/rzMa9K/ojw1P/VrJ9ENrEHenYm8QdrIcCDP6p2fWqgNGN2HUj2reN5u
 1WXtUjXp15bHJ3QceS3dWpJ9pM7EBgjOlun3S6CdH3R8txQ3XA/Sh9q2WzYbXrMN
 Hoo0WLBf70h+ln++acxy56wHI=
Received: from [IPV6:2001:44b8:21ac:7053:47c1:8297:2d98:5f10] (unknown
 [IPv6:2001:44b8:21ac:7053:47c1:8297:2d98:5f10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by gapmx.vk4msl.com (Postfix) with ESMTPSA id 9A31659425
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 14:46:44 +1000 (AEST)
Message-ID: <832dd856-fa1e-436c-a8a0-681d5aa8e64a@vk4msl.com>
Date: Fri, 5 Jun 2026 14:47:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-GB, en-AU
From: Stuart Longland VK4MSL <me@vk4msl.com>
Subject: i.MX28 FEC Ethernet on DeviceTree with RMII PHY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 10:05:46 +0200
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

Hi all,

I'm re-visiting some old work I did back around 2015 or so, where I 
ported U-Boot to a Technologic Systems TS-7670 single-board computer.

Schematics are online at 
https://www.embeddedts.com/documentation/ts-7670-schematic.pdf and my 
code is at https://github.com/sjlongland/u-boot-ts7670/

I managed to drag U-Boot 2014.10 kicking and screaming into this world, 
and can build it with a GCC-5 based toolchain, but I'd like something 
that builds with the same toolchain as the kernel.

So far I have U-Boot 2026.04 booting the device, loading from eMMC or SD 
card and storing its environment in an EXT4 partition.  There's an issue 
with the watchdog in that `wdt-uclass.c` thinks the watchdog "isn't 
activated" (but it is) and refuses to reset it; but if I set the timeout 
long, I can work-around that.  (No I can't turn the watchdog off.  Not 
without replacing the firmware in the MCU that implements it, and I 
don't have that code.)

The issue that's causing me the most pain is Ethernet not being 
initialised, and so Linux changes the MAC address every boot.  My 
work-around for now is to read the fuses and set `enetaddr` myself, but 
it'd be nice to have U-Boot do this the way it was intended (and have 
working Ethernet for network booting).

The device shares a lot of similarities with the Freescale MX28EVK 
development board, particularly regarding the arrangement of the 
Ethernet.  In the case of the TS-7670 there's a SMSC LAN8710Ai PHY wired 
up to MAC0 with MDIO, MDC, RXD0, RXD1, RX_EN, TXD0, TXD1, TX_EN and 
ENET_CLK wired.  Not sure if it's the same PHY on the MX28EVK, but it's 
a similar wiring arrangement.

There's power controlled from GPIO 1.10 (LCD_D10) and a reset line from 
GPIO 2.9 (SSP0_DETECT).  Details of how to describe this in Device Tree 
are scarce, but I think I have it right here:

https://github.com/sjlongland/u-boot-ts7670/blob/f5cea6747cc5a35e7e0822cb7349f7afdccb595c/arch/arm/dts/imx28-ts7670d.dts#L379-L399

It's worth noting that I do not need to go to this level of detail to 
get Linux successfully on the network.

One contributing factor I suspect is the fact that the Ethernet operates 
in RMII mode.  I see deep in the code base, the clock output I need is 
enabled here:

https://github.com/sjlongland/u-boot-ts7670/blob/f5cea6747cc5a35e7e0822cb7349f7afdccb595c/arch/arm/cpu/arm926ejs/mxs/mxs.c#L231

…but in the original 2015-era code, we did this…

https://github.com/sjlongland/u-boot-ts7670/blob/ts7670-2014.10/board/freescale/mx28evk/mx28evk.c#L110-L111

`board_eth_init` is no more now, I see support for that is gone even 
though headers still hint at its existence, it is never called.  I 
suspect this difference is a major contributing factor, I'm not sure 
what replaces it.

I did try modifying that call (in mxs.c) to set 
`CLKCTRL_ENET_TIME_SEL_RMII_CLK` as well, but to no avail.

Has anyone gotten a i.MX28 machine with RMII PHY talking on the network 
with current U-Boot and have some insights to share?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
   ...it's backed up on a tape somewhere.

