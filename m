Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FBCD8C88
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 14:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9078063E;
	Sun,  7 Jun 2026 16:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vk4msl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; secure) header.d=vk4msl.com header.i=@vk4msl.com header.b="n8wTs4EW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8458C8063E; Sun,  7 Jun 2026 09:43:44 +0200 (CEST)
Received: from gapmx.vk4msl.com (gapmx.vk4msl.com
 [IPv6:2001:44b8:21ac:70f8::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE09780433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 09:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vk4msl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@vk4msl.com
Received: from gapmx.vk4msl.com (gapmx.vk4msl.com [127.0.0.1])
 by gapmx.vk4msl.com (Postfix) with ESMTP id 25A7A599E0
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 17:43:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=vk4msl.com; h=message-id
 :date:mime-version:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding; s=gapmx; bh=1ix8O2/k44M
 5b+qrgSUJIfTpra1cJj9Mgu9yUUq8cEk=; b=n8wTs4EW/xqdMtJIey+8c2VQb35
 eA9rmGkN3DstQo/cwhwFyn0RNDqGFuOET6TtrGb/GvVT+RpRhihRB8STcHSFQoHQ
 BnfFvcsaQvpEPiOpbU4NLZcma7pQMiipSUnw4Zc8VVDh2huJdwFNLe3Qb3uCVCYr
 phnFUM0rscnzd7WLrfK/lcAziqVcpA/v1gLSlJXOh11GKFYKXQ5aSoCifsAoRli6
 7/zpF3X3TYRhXkwZtnHUwDYlY3RQ/LJVdq6YUQwEDJCZFUEWKqwk1jrc6Swf3h9+
 WSGXcAI3GW7fGyT2yhW/EZXtHAwgwbojAHT1bEUc1JSzrsyYfcsVB0guwD+9Rwl9
 6UFFboqQIa5RufY9ovB9L0klyoXdolW3nKMW+h75j0ksUcxgC3Z+jQ3QtvBPYFjH
 iKMKG/SZKvwI1F62RUtm+cfwkPJo5uVf/IQ9RtEi6IsH4h3eR3DIwhQ2qhVYeLt9
 lGAK0XA5rF2NDm5VIuGb/Rri4AwE1sLiAzJTiOJZq4YE4d47xBtI6cj9EdB0cyAY
 ZQ36Opqnvr8UDX+cJQITT0VaqUgw610NYlm9euCwHGGzErTWElIzE9dqu2uoemnB
 nKLh8iJluNrZ2u/stUp8f54PSz+9NnCCwD2a0bQLthPq18gcIR7KtglzSkaE1IfJ
 mt2+iqk9bu+fuwMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=vk4msl.com; h=message-id
 :date:mime-version:subject:to:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=gapmx; b=fv5Ic
 XwtipVdj4i02y6r5+9WOyrhDFWp9vsDU0U/oFkBeUD5um88V5VecD1kdZ6XLKyOX
 wLxfDXjhaRP0/jhgQcP0Vv+jHwT0MxhKqQIwpFOhohA1np7QFXwX6CSiGWD9US3J
 yTR+bgG33er5oKJe+/30d0PxtuOJ8ZtN7tEW6dK22U6+hP7ptGkuXcf52EgHzBox
 xwXYE0HfxPXqy3RrYwo9lHsASPCZAHXlsWHTweom5nUTMjynqnDEtsT0DMz/KbUt
 Temnh/avrc3b9jmIsiB1Dcm/pSx7MMfmbeaExt/ex3cC1e+mgURB7fgbvxo4DQ1+
 7qXPNRW2Lw2DVJHqRu/T6opmvRgr4vZds2lqhI4MsqNjmUJWGxXlEjwbwlg25por
 cJk/GShbMaosqzjx85tmp02Lt1RGyu28EGy98ESUvEr+X+a4z77HBsOUdSOAzPLx
 YLX8JQBBeCv77pHFKC3vPHdW3PUbUM6AoEL5lgCNwA5S5QlBZrhXqC91f4FKHnK3
 7tSflcqCc3ap0tOxuRA1T3Jkuaia2ggCrjbSJZgbrzHXdWWGlUoh/ifXkx4YLplp
 K1nD3NFUrISxiA058x1UBeMB8PaU01/JG9MFbWQulMPJTodtJeMK43R/gThFXjEp
 MlYJ0J4fh+fYkOIBkDQIng1m1DQ7C63uczmcUM=
Received: from [IPV6:2001:44b8:21ac:7053:bc3b:2f94:1d7c:d4c5] (unknown
 [IPv6:2001:44b8:21ac:7053:bc3b:2f94:1d7c:d4c5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by gapmx.vk4msl.com (Postfix) with ESMTPSA id E607D599DF
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 17:43:04 +1000 (AEST)
Message-ID: <5087c98a-bf6e-4955-bc9e-b85734809b3c@vk4msl.com>
Date: Sun, 7 Jun 2026 17:43:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i.MX28 FEC Ethernet on DeviceTree with RMII PHY
To: u-boot@lists.denx.de
References: <832dd856-fa1e-436c-a8a0-681d5aa8e64a@vk4msl.com>
From: Stuart Longland VK4MSL <me@vk4msl.com>
Content-Language: en-GB, en-AU
In-Reply-To: <832dd856-fa1e-436c-a8a0-681d5aa8e64a@vk4msl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 16:56:44 +0200
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

On 5/6/26 14:47, Stuart Longland VK4MSL wrote:
> 
> I'm re-visiting some old work I did back around 2015 or so, where I 
> ported U-Boot to a Technologic Systems TS-7670 single-board computer.
> 
…snip…
> 
> Has anyone gotten a i.MX28 machine with RMII PHY talking on the network 
> with current U-Boot and have some insights to share?

So after much cursing, I stumbled on the answer.  The clock is 
initialised in `cpu_eth_init` defined in `arch/arm/cpu/arm926ejs/mxs/mxs.c`.

With the deprecation of `board_eth_init()` this routine is never called, 
  so the clock never gets turned on.

No idea where I access the `bis` parameter this function theoretically 
asks for, but in practice for the MXS series CPUs (i.MX23 and i.MX27) 
the function actually never touches it, so we can pass `NULL` here.  If 
I do it in the board early init:

int board_early_init_f(void)
{
	/* IO0 clock at 480MHz */
	mxs_set_ioclk(MXC_IOCLK0, 480000);
	/* IO1 clock at 480MHz */
	mxs_set_ioclk(MXC_IOCLK1, 480000);

	/* SSP clocks at 96MHz */
	mxs_set_sspclk(MXC_SSPCLK0, 96000, 0);
	/* SSP clocks at 96MHz */
	mxs_set_sspclk(MXC_SSPCLK1, 96000, 0);
	/* SSP2 clock at 160MHz */
	mxs_set_sspclk(MXC_SSPCLK2, 160000, 0);

	/* Power-cycle eMMC */
	mxs_iomux_setup_pad(TS7670D_V2_EN_SDPWR);
	gpio_direction_output(TS7670D_V2_EN_SDPWR, 1); // EN_SD_POWER#
	udelay(1000);
	gpio_direction_output(TS7670D_V2_EN_SDPWR, 0);

	/* Wait a little bit for the card to wake up fully */
	udelay(1000000);

	/* Initialise Ethernet clocks */
	cpu_eth_init(NULL);

	return 0;
}

I see this in my console on boot:

HTLLCLLC

U-Boot 2026.07-rc3-00557-g082f0e9a2be0-dirty (Jun 07 2026 - 17:33:06 +1000)

CPU:   Freescale i.MX28 rev1.2 at 454 MHz
BOOT:  SSP SD/MMC #0, 3V3
Model: embeddedTS i.MX28 TS-7670 (Default Device Tree)
DRAM:  128 MiB
Core:  114 devices, 18 uclasses, devicetree: separate
WDT:   Started watchdog@78 with servicing every 1000ms (500s timeout)
MMC:   MXS MMC: 0, MXS MMC: 1, MXS MMC: 2
Loading Environment from EXT4... OK
In:    serial
Out:   serial
Err:   serial
Reading Ethernet address from fuses: 00:d0:69:49:ef:e3 ${enetaddr} set
Net:   Enable RMII clock
Enable PHY
eth0: ethernet@800f0000
Press Ctrl+C to abort autoboot in 2 second(s)
=> <INTERRUPT>

…and the Ethernet works!

=> mdio list
FEC0:
0 - SMSC LAN8710/LAN8720 <--> ethernet@800f0000
=> mdio read 0
Reading from bus FEC0
PHY at address 0:
0 - 0x3000
=> dhcp
ethernet@800f0000 Waiting for PHY auto negotiation to complete. done (5ms)
BOOTP broadcast 1
BOOTP broadcast 2
BOOTP broadcast 3
BOOTP broadcast 4
BOOTP broadcast 5
DHCP client bound to address 192.168.65.123 (4801 ms)
Using ethernet@800f0000 device
TFTP from server 192.168.64.48; our IP address is 192.168.65.123
Filename 'netbsd-INSTALL32_IP3x'.
Load address: 0x42000000
Loading: *
ARP Retry count exceeded; starting again
=>

(Okay, it just tried and failed to load a NetBSD/sgimips image, but hey, 
it wouldn't have known to try and load that file had it not spoken to my 
DHCP server!)

So the question I guess remains, where is `cpu_eth_init` supposed to be 
called, and how?
-- 
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
   ...it's backed up on a tape somewhere.
