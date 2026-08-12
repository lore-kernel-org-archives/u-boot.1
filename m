Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807AEC5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 13:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 216038125F;
	Wed, 12 Aug 2026 13:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NqGbv9TNn5Se; Wed, 12 Aug 2026 13:32:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE6F8811FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786541537;
	bh=yk/rElWfP3U6lraWkJcGxaOU6XQIFR5sYBahhz2ZwVQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XM0WQDhZUftJx7E5Je37rV87Dh+LntphaGJesv1FNnum84p/rIXuI9pMjhTJKFN9z
	 5vBCF69pdG7Wd9Wra+qxPsqz8mWbKNFbbLK5v8UWkiTrla4VNvNr0nOlmuoij1mgxk
	 NjDicWDh2FkSQWX0HykIDzgSvhYn0ecUlxJnbOv31TOCi0HhqPfAnHvDUzlchU/N5s
	 nrkOyMO8s5cy5GDQsphKo7c6Sy6wlQSKqgDGfHNUEiLQRZhtfBy6jo0pkMADCMIY8j
	 xh4bFDtDKELan+OmOuCmOjLKd5oILpTznFs3FTiyde2hVRgGb1S+d4CpzTh/jB+uoG
	 lw/ktD/Q8DjCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE6F8811FE;
	Wed, 12 Aug 2026 13:32:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CBB06282
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD86B4085D
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:32:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cy2nZbxOy_NC for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 13:32:16 +0000 (UTC)
X-Greylist: delayed 13386 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 12 Aug 2026 13:32:15 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 112814085A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 112814085A
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::bc08; helo=smtp-bc08.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::bc08])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 112814085A
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 13:32:15 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKqCw3dvWzvKZ;
 Wed, 12 Aug 2026 15:32:12 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKqCv2vY0zcdQ; Wed, 12 Aug 2026 15:32:11 +0200 (CEST)
Message-ID: <166efc6c-b659-41bb-a8d0-bec6d03df740@0leil.net>
Date: Wed, 12 Aug 2026 15:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] rockchip: doc: add mask ROM mode text
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
 <dfe95538-0b08-4378-ad46-bbe0ef554cab@gmail.com>
Content-Language: en-US
In-Reply-To: <dfe95538-0b08-4378-ad46-bbe0ef554cab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786541532;
 bh=yk/rElWfP3U6lraWkJcGxaOU6XQIFR5sYBahhz2ZwVQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g5oJxEp4TYrjaOEguxi5VHX5MkDIg+WSYPV37FqOtz/8Gl5mEluaKQn2oQb/mDpts
 MI6S1H2B50X00vDvnKan98A3p/rcqWmiaHBspnoZiJbeWd71P8LVfQgiWMEaIB962a
 4UTw0NBQO5t4qZICGhoz3Pm1LZ/IbcvBgFLqBQYuG9HdJwaUJQcuVLHkL/0edh92aF
 V6I7ps3zSzuew6Dmm8iEfJULaZJHlz+cVIfafLFIrvUpiQqMymQnAtZjjAU4bAV3E/
 BkD/mv68zHWPyE9gsy0H1ULjdO90G/vppYXzFZjAIHQNouGHTsjzhgKr69ldwuCjVV
 EFm4DTVFz1Agg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=g5oJxEp4
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 8/6/26 1:10 PM, Johan Jonker wrote:
> Add text that explains how to get into mask ROM mode.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changed V5:
> reword
> ---
>   doc/board/rockchip/rockchip.rst | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index de2df3046e28..af6c08c46636 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -325,6 +325,27 @@ To build rk3588 boards:
>           make evb-rk3588_defconfig
>           make CROSS_COMPILE=aarch64-linux-gnu-
>   
> +Mask ROM mode
> +-------------
> +
> +Mask ROM mode is the fallback mode of the boot ROM,
> +in which it listens for USB commands 0x471/0x472.
> +
> +Options to get your board into Mask ROM mode:
> +
> +* Hold the recovery button, depending on firmware support or wiring,
> +  while booting the board.
> +* Remove any SD cards, removable eMMC or removable UFS modules.
> +* Erase any storage media containing boot firmware.
> +
> +Methods of last resort (USE AT YOUR OWN RISK):
> +
> +Short the following pins briefly while powering the board, so the boot ROM
> +cannot locate any boot firmware and falls back into Mask ROM mode:
> +
> +* NAND: connect pin 8 and 9 of the NAND flash with a needle.
> +* eMMC: connect the clock line to ground.

I see that in the NAND section below pins 8 and 9 need to be connected 
and that's where you got the information but is there a standard that 
makes sure all NANDs are pin-to-pin compatible? I'm wondering if it 
wouldn't make more sense to specify which pin(s) (its function for 
example) need to be connected.

On RK3588, RK3576, possibly RK3562 and other RK35xx SoCs (but not 
RK356x, likely not RK3528, ...) it's also possible to enter Mask ROM 
mode by forcing channel 0 of the SARADC to be 0V. Can always be improved 
in a later patch.

For SPI NOR, on RK3399 Puma we make sure HOLD# is below the threshold 
and thus the SoC cannot communicate with it. Can always be improved in a 
later patch.

> +
>   Flashing
>   --------
>   
> @@ -485,9 +506,9 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
>   NAND
>   """"
>   
> -Bring device in BootROM mode:
> +Bring device in Mask ROM mode:
>   
> -If bricked and no BootROM mode shows up then connect pin 8 and 9 of the NAND flash
> +If bricked and no Mask ROM mode shows up then connect pin 8 and 9 of the NAND flash
>   with a needle while reconnecting to the USB OTG port to a PC.
>   

There's another BootROM/Mask ROM swap that's missing. For RK3066:

"""
If all other boot options fail then it enters into a BootROM mode on the 
USB OTG port.
"""

Cheers,
Quentin
