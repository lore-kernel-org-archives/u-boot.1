Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCC4C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 07:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F5D40F11;
	Fri, 31 Jul 2026 07:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vmJ-xA8z-77; Fri, 31 Jul 2026 07:47:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B34540EC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785484065;
	bh=7xPL2XiQYFH1eReYZA34fJJe/pRn++xUg8szc96Kr68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MPbOGxbexs3t0QK0sDhq4qkDqUXUpoRZnECTZDJRCu6isxGyCX27qsrtuqaxBaSDo
	 NHkm4VSs/UXkGOH2GLLJgMyvYJoPisADmZC2IDWooay8j3EqS/GpBEBNtYg0bRhQKy
	 F5jfInGlHryHB1q4g0EE9X5HVcW1vDQLe3EgTaOQEsYTOoSRYf61Pzn7h2KxNyrHq/
	 FlZpbALy0aoz+qEnXmg1uJIvfTRqI1+itGrp7Lz4jQ5OmbupJmxuQbvh5P+tk0cM3O
	 vmdfemOngRBvfKnZpn86pXM4lBATxdJ4Sb85C7vxNTTaQKx8JR5/Hrh9nILCsRlLJR
	 1NuD9ydUv7OIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B34540EC1;
	Fri, 31 Jul 2026 07:47:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3506D2E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CA9040EC1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGTdIwfOhpb8 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 07:47:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9B32F40EBE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B32F40EBE
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B32F40EBE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:47:39 +0000 (UTC)
X-Forward-Email-ID: 6a6c53183d2a6a998ff28073
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1c19bd83-5c02-4563-9a50-ca4aef3fa034@kwiboo.se>
Date: Fri, 31 Jul 2026 09:47:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] rockchip: doc: add BootROM mode text
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.u-boot-project.org,
 eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <88612ac4-7c1d-4e4b-b297-a2f96ab17a3f@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <88612ac4-7c1d-4e4b-b297-a2f96ab17a3f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785484059;
 bh=7xPL2XiQYFH1eReYZA34fJJe/pRn++xUg8szc96Kr68=;
 b=UlT27LVAD3fB7zGzaZwQtTEUY6EEs2E07npzvPcobJSC6/16/lwKwkIiiQY5YJ8hx8/euvWhY
 wOPWOLNmlTTl+4g9opJBmeescMgpIGIzImg8iT8IDC0KU7NqZQ0llHNqRzQ7WRVGNaXavw+93ZK
 ls2yTi6lpc/haqhed0A6m1eh0unL8y6g8CGoSDzKSeG665cMhI0IoCd0GTk+tSqkMiFAl4N7iZB
 NX2Uq2t4+UiXDiyvz9EK4eF891CG3h2kdltLdIXTikNGyxwznYvtXOpKTcWM01Pp2X1yzfbAsD2
 GJioWIgm4oLrqSRJf+V7V0gg5bweZzceOv4vZRpVrp6A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=UlT27LVA
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/30/2026 3:33 PM, Johan Jonker wrote:
> Add text that explains how to get into BootROM mode.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V3:
> remove MaskROM
> reword connect
> use eMMC
> wrap
> ---
>  doc/board/rockchip/rockchip.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --
> 2.39.5
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 5144cbccef78..fab1af73b22a 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -325,6 +325,22 @@ To build rk3588 boards:
>          make evb-rk3588_defconfig
>          make CROSS_COMPILE=aarch64-linux-gnu-
> 
> +BootROM mode
> +------------
> +
> +Options to get your board into BootROM mode:

We typically call this mode 'maskrom mode', i.e. the mode bootrom
fallback into that listens to 0x471/0x472 usb commands.

> +
> +* Holding the recovery button when you boot the board.

Holding a recovery button does not always take you to the maskrom mode,
it typically depends on current firmware and how such recovery button is
wired.

> +* Remove the SD card.

Maybe make this more generic, today we have e.g. SD card, eMMC modules
and UFS modules that can be removed from some boards.

> +* Erase the NAND, eMMC or SPI chip part where the BootROM blocks are located.

BootROM blocks is a bad phrase to use here, the BootROM is read-only and
located inside the SoC.

The intent here is likely closer to 'erase any storage media
containing boot firmware' or similar.

> +
> +Methods of last resort (USE AT YOUR OWN RISK):
> +
> +* NAND: connect pin 8 and 9 of the NAND flash with a needle while
> +  reconnecting to the USB OTG port to a PC.
> +* eMMC: connect the clock line to ground while
> +  reconnecting to the USB OTG port to a PC.

Not all boards get power from USB OTG port, so this phrase is maybe too
narrow?

The intent is likely that the pins should be connected/sorted for a
short period when the board is connected to power, so that bootrom
cannot locate any boot firmware and falls back into maskrom mode.

Regards,
Jonas

> +
>  Flashing
>  --------
> 

