Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19B606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OOSorEvP;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=v0P9i+u9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D16DF40790;
	Mon, 23 Nov 2026 23:37:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tv66kE4GHh1Z; Mon, 23 Nov 2026 23:37:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47F5E4077B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795477045;
	b=HvPmd+ZmmCijHc42ckEtJLn8KmxCh0uxn9V3BtsMyjs1hPpPc8BKgvV7i+wsRmrqBJxy
	 3w0KjQxEMgftf7B9hMybDXYTgluIkLw/bWiKeT0m+jQFMD35G8mGcuB7xTuumL+YWNp3w
	 6NJhKGkeGQ+s8mVixM021ZZJ/RavCMvW7hX1HI5VeX/rZU0PnoF5nwLobSLfPEwHjgCm7
	 8oVJGj/lqgo72JytnE+5eWs/PiYxtB2AkCxBQM9EP5nQZpPX89ryEO20XgmK1GQESL3lW
	 cagRPjG6WG9zHpC3o354yF/HKtSjaMmGcJ45polwz1BRnKYwc2Rc4us8Ig/yaOVB8Mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795477045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oSTjlH7l9q0Kos+o1c/Y0rNbRQmgQoFiAkqcUoNaIb8=;
	b=NHfkwN9ig5U1YLPHYu3zIcNdH3WHyk6mA95tj+MyHJIKcoOZx26E31PRG4goeL3RUHzg
	 iuV7k6xUvuGFtNEsvUzZLbGwMGqVcYz8ExI6qzLebmfAoHisklfCKGaR8rgY5rM3jfr2M
	 BFmqmIe5K4L05ihAA7s1mhN4EqSD0AYdtjLW/wKHQhLdxeV+RH0lj2xnoRqJrYaGBH7EQ
	 VYjt5qnrFx/B0Cjsc+LugfLFo/piNGqgEBdysIBFC1be+ll0dFiKM3XG0HNJN2uBuKx7/
	 XXaNGN0/EMyFdfQ7EJZtvv8Jj7WqQ4LVAkIu/Jo9MnC2N+xGIIUrZ52d5noqWokDSrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795477045;
	bh=oSTjlH7l9q0Kos+o1c/Y0rNbRQmgQoFiAkqcUoNaIb8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OOSorEvPjbJ+c+wbJM+LMUs8xAzgRhvsHY+yMyrbMBvp2tOUeC3zTe6U+WMfwgdZJ
	 yV3/3f5OTIUHFyGP9rxTE/v0jB4XmFPdB6X3EIVbmAxKxmkpCkWIdHAn04qghy/+h8
	 MyhGPMVHgG+XSfh7zn8nJ5bSfwxH8Gb0pCQjc4xi98nMbbGedNwv26KD9xdNmaHDKJ
	 F9m3iG6k7+ImngVb8FoBpmF1rwet17wVjsJ3J+KDBCG5999jpxanOWfQGhA5aDA4kO
	 4O7tn1brjqtmpwaCHgipB02IikWWxdpsxGiYaZKSHF8Fl54/JQExKXZM5rAQBhbLZ+
	 XaVEecPn0g5Bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47F5E4077B;
	Mon, 23 Nov 2026 23:37:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 627351AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29F8E400B5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWgNqHhdDe9G for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E785040068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=v0P9i+u9
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E785040068
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:37:18 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jYMmT3Z3JzMm0h;
 Tue, 24 Nov 2026 00:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795477033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSTjlH7l9q0Kos+o1c/Y0rNbRQmgQoFiAkqcUoNaIb8=;
 b=v0P9i+u9w0twHpOiPzaulaigjiVItfWqVBFdW65Z49YAryZH5QW9ilqK90/mxBrS5Mxax7
 Xd5jK1PyGGTfUIyhimk1hPbimyKV1ZTplTROGLWDuij+Isvm4BcSPId1fWR3l8mg4CxGqW
 SvhnIc31KXON+KvonpNmi0qRtUuJuOxScSi0uMhHFUsAZg0TbmYO5Z60TArHmNebyvZok6
 ipTYgLBiCBG4R32ndxcKpJmgwGagARgsYCBtFmM6X4kudC6Myn5kroRIbuxZ6M9sEca3yZ
 4q2CSLRcC1PJCpT1/Yijhcq1TQIt6FPy8K9hhVNMLq+EU0kcyoT1uAip3xv67w==
Message-ID: <79ec1874-3d7b-417e-87eb-efabafff9b75@mailbox.org>
Date: Mon, 23 Nov 2026 19:23:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/31] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 quentin.schulz@cherry.de, s-vadapalli@ti.com
References: <20261121115335.548142-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oe4g8x9mjuf9coduob7ur3x4arebk8d7
X-MBO-RS-ID: 62550e7ef93d5c381b7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/21/26 12:53 PM, Anders Roxell wrote:
> Hi,
> 
> This is part two of two. It applies on top of part one [1], which resets
> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> the build for every board that enables DWC3. This part adds back the
> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> builds and the gadget works again. It builds on Jerome's work [2].
> 
> The two parts have to go in together, on top of next (794978160561).
> Part one did not change, so I do not resend it. The v10 patches [1]
> still apply on next.
> 
> The resynced epautoconf matches endpoints on their caps field instead of
> on their name. Five UDC drivers never filled that in, so each one gets a
> patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
> and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
> 
> Build tested one board per driver: every DWC3 glue layer in the tree,
> dwc3 on riscv (spacemit_k1), RK3588 and RK3399, dwc2 with and without
> DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc with SPL SDP, musb-new
> on sunxi and in the am335x_evm SPL, and mtu3. 24 boards, no warnings.
> 
> Ilias found a few bisect gaps, so I built eight of the boards at every
> patch. Gadget configs build again from patch 21, the other UDC drivers
> from their own fixup patch.
> 
> Tested on hardware with v10, per vendor:
> 
> - AMD/Xilinx: Love tested and sent a Tested-by.
> - TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
>    (Anshul).
> - NXP: ci_udc with ums on an i.MX93 board (me).
> - Amlogic: gadget and host on Khadas VIM3 (Mattijs).
> - Rockchip: host on RK3399 Puma, same as master (Quentin). RK3588
>    Tiger had two regressions, see below.
> 
> Tested on hardware with v11:
> 
> - NXP: ci_udc with ums on i.MX93, chainloaded from the vendor U-Boot.
>    Three ums rounds, the host read 64 MiB each time. It needs usbotg1 in
>    peripheral mode.
> - TI: dwc3 ums on BeagleBoard-X15, the host enumerates it at high
>    speed. That is where I found the event buffer bug in patch 16.
> - Rockchip: host on RK3399 Puma and RK3588 Tiger (Quentin). The two
>    Tiger regressions from v10 are gone, and he sent a Tested-by:
> 
>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma usbdrd_dwc3_1
>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger usb_host1_xhci + usb_host2_xhci
> - Rockchip: host and gadget on RK3576, a Flipper One and an RK3576 EVB1
>    (Alexey). No regressions against master, and he sent a Tested-by:
> 
>    Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576
> 
> v12 only has the review fixes below, and they do not change what the
> code does. So the v11 hardware tests above still hold. I also ran
> dwc3 ums on BeagleBoard-X15 with v12. The host enumerates it at high
> speed, and what it reads back matches what U-Boot wrote to the card.
> ci_udc ums on i.MX93, chainloaded like for v11, works too.
> 
> One thing is still open.
> 
> Anshul sees a single "unknown endpoint event 0" line on AM62p during
> enumeration. I got the same line on the X15 from the event buffer bug
> that patch 16 fixes. I think it is the same on AM62p, but I have not
> tested it.
> 
> The branch has both parts [3].
> 
> [1] part one, subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and
>      import from Linux v6.16
> [2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [3] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v12
> [4] v11 part two: https://lore.kernel.org/u-boot/20261107072224.3492260-1-anders.roxell@linaro.org/
I tried to pick them up for next, but the build failed due to oversize am62:

https://git.u-boot-project.org/u-boot/custodians/u-boot-usb/-/jobs/156214
