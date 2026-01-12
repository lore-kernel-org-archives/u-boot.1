Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03B2CF45CD
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 20:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C0F83759;
	Mon, 12 Jan 2026 21:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jakEIAN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894BE8382A; Mon, 12 Jan 2026 21:16:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D4C83700
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 21:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f435=7S=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1768248987;
 bh=DJQ14YAw4t/S0LNfIvgl9l5KuyqP8DerLobiOkkU4uI=;
 b=jakEIAN/KUUI0VDnzU2rFHsT4eHXU2d+PYv4fMgvEqq9fd/xIk0V05zEwI+Fx2FhJ8+8sMTS9
 omrLKvgmLjCL5pnTBMdp2mFHmck91jOcoQOK9D72PHolNZ6on6boHjZzzzZrTxTzAd2iGX2eliI
 vYWRLQUTeQcdcJ70aWznj84cdLlEgCkzmV8mFsyWWTMyOTjx7cyVAK1sfZcdfv6cAsyZFyob3Z+
 CUcnr9Arh/ZtJMnf297cwk8AG2vwydLUtkSdygh0PDM23Ux5Rdnj/kt5xcegM7BCge0RmvwuF63
 NAkn1DrkPteMaE7X6oUCflsvm7ORCIUblFOagRGHCIxg==
X-Forward-Email-ID: 69655698e6f5eea36679a038
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e94df9a3-80d9-4148-aba0-0c5408990556@kwiboo.se>
Date: Mon, 12 Jan 2026 21:16:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] rockchip: Add initial support for RK3506
To: Aaron Griffith <aargri@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260109005008.101506-1-jonas@kwiboo.se> <aWFjzQfEwfCK8RKJ@nara>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <aWFjzQfEwfCK8RKJ@nara>
Content-Type: text/plain; charset=UTF-8
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

Hi Aaron,

On 1/9/2026 9:23 PM, Aaron Griffith wrote:
> Hello Jonas,
> 
> On Fri, Jan 09, 2026 at 12:49:41AM +0000, Jonas Karlman wrote:
>> This series add initial support for the Rockchip RK3506 SoC.
>>
>> [..]
> #
>> With this series, board DTs and defconfigs it should be possible to boot
>> into U-Boot proper (without OP-TEE) and still have support for MMC,
>> Ethernet, OTP, RNG, LEDs, buttons and USB gadget/host.
> 
> I have a Luckfox Lyra Pi W board (with RK3506B) and a Luckfox Lyra
> (with RK3506G). I've been using the earlier version of this patchset
> for about two weeks to successfully boot Linux on both of these
> boards. I'm excited to see this support heading upstream.
> 
> Using these patches specifically, I can verify that the RNG and LEDs
> work, that it is able to read data from the MMC and USB storage, and
> that it successfully loads and runs a Linux kernel.
> 
> I was not able to get the Ethernet port to work on my Lyra Pi board,
> but that uses your device tree information that is not part of these
> patches (and may be incomplete). The specific failure U-boot reports is:
> 
>     ethernet@ff4d0000 Waiting for PHY auto negotiation to complete.........
>     TIMEOUT !

Thanks for testing these patches!

I did some testing on my Luckfox Lyra Pi W (eMMC) board and also found
similar issues that you report.

These issues mostly seem to be related to firewall for USB OTG1 and
MAC1 (ff4d0000) or DT issues related to Ethernet clocks and pinctrl.

The firewall values before we update them in arch_cpu_init():

  => md.l ff5f0020 5
  ff5f0020: ffffffff ffffffff ffffffff ffffff00  ................
  ff5f0030: ffffffff                             ....

The following firewall values seem to help fix MAC0/1 and USB OTG1:

  => md.l ff5f0020 5
  ff5f0020: ffffffff f00000ff fffffff0 fff0ff00  ................
  ff5f0030: ffffffff                             ....

We could possible set all these to 0 to allow all masters to access
memory, will send a v2 that configures the firewall like above.

Adding something like following to the ethernet-phy nodes seem to solve
the Ethernet issues in U-Boot on my Lyra Pi:

  assigned-clocks = <&cru CLK_MAC_OUT>;
  assigned-clock-rates = <50000000>;
  clocks = <&cru CLK_MAC_OUT>;
  pinctrl-names = "default";
  pinctrl-0 = <&eth_clk0_25m_out>;
    or
  pinctrl-0 = <&eth_clk1_25m_out>;

Vendor DT for Lyra Pi seem to set CLK_MAC_OUT to 25 MHz, but this does
not seem to work in U-Boot and I can not see anything wrong in the clk
driver, so maybe it is meant to be set to 50 MHz.

Will update my rk3506 branch to include these changes and later also
send out a v2 of this series including the firewall fix.

Regards,
Jonas

> 
> So, for what it's worth,
> 
> Tested-by: Aaron Griffith <aargri@gmail.com>
> 
> Thanks,
>  -Aaron

