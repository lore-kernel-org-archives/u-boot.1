Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB49606A327
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1KgS9u+R;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=a0FJoXtH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 358AB811C9;
	Wed, 11 Nov 2026 09:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHKpFtOk3qAB; Wed, 11 Nov 2026 09:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 785A3811CD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794391066;
	b=o5/4gKHaxeHoFAl2iTS8meuhVOpCJNzhXWKImEbWfbRYiuSvdGELT0W7SctXFzcXsTsm
	 sP7PH1Y9M9d8gkKAaBH/7jDi1c0Obvl5QkpZek+wxxmqxuQE4ZDtejIlzAN7Rm06yjIhW
	 EKMSh3rQF2eRDiJKM1kFQ3+0RMrlNW1hMfDx6xl1ubRURsKKn1GYQDeT51DN4Yqv3OT10
	 E0phsd3mGANgtd3oecAdAqkvI7dtwW4qXZPy9H1RdKfNDq7cNbc//aPAjRjAs5Ha0O0+f
	 +qsQpVSCiidpbM1v/pUvQZt+SLSgx+Wa8omt7/ivPeFuj/A49LJvValwxZyhuy+/4mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wQBNOBPmXaKJ4IhwXB1Acsr1GgKUXM/tSo9L6BiEl+g=;
	b=Js7ps+YxD/P5spYDRxao7VkdBQuwiB5C3fusBdm9oDtL1NqYkQUMAR83N86oYUTaEBUw
	 prFRRWiJuk80JOa+Fik1w48w1oqW97EE8CjHM9m4egVgxjpe/D0QIapEDkIEFcYUe22gp
	 kkdJxcl614+slr1RGS5l3aWA3e/KwkfV8fVC+3VSAylX8kz3kN/534krfTApD/6CMkKzn
	 0rAQztw/YCR3/o/tff6HT0qbsmG33VSUEAMu1XViuz196qVpnW1ffdFK678R09Z5312Az
	 SOqa+c39RDSiMt2nTZghRBunNCOqZIGFvPSupnU+aqWWxuEQ0ITqrsFQtwiTwY9ARuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794391066;
	bh=wQBNOBPmXaKJ4IhwXB1Acsr1GgKUXM/tSo9L6BiEl+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1KgS9u+RT00+E5bD05TyS31Bri58FpB6jvnhWO8txAHKUtx4uBI3gr0ym04jUMvci
	 KD2AZ8x97yXRszoBqX7s60qWI89KWImqdiq3b8WI9QtnxH6HGHiGRDU9xObyTJ7RIi
	 HtCApEXWC++oNh4CTsQ2v+Lh+prWvm5cfB9dCRiWY9rraRA+k38hLKR18wp3MotXkE
	 LENA4ZIkFIrwhm0NKtENa325nNBUifralas2NcsiEsxYe6hSrViPgA+JCKiWJLdX7C
	 FRh2rt07ij7RM1Jk6yQB5EZp71ZuTbWVsqQtExc8JFAp6F0ECWfSdiGWe5uSgtBDih
	 Poab7lf+cRAqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 785A3811CD;
	Wed, 11 Nov 2026 09:57:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E68E631F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C396640318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqZvw0z_pdGN for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F17E540070
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=a0FJoXtH
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F17E540070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:57:42 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPf8J0P2Mzq1y;
 Wed, 11 Nov 2026 10:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794391055;
 bh=wQBNOBPmXaKJ4IhwXB1Acsr1GgKUXM/tSo9L6BiEl+g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a0FJoXtHiLkNdky3yWcMoirXc5puSveJSrSoMjGzSgZnpaJxJ5zQJ64mpJZ2g5jzz
 wi6iit13sSbTSFKHXJoYd2cv8L6qNGGtGXvGSzYUD7iGrm5uWgsIfMTk5GeOyOKp1r
 aY6cf4mzKzVH/A988cZ4yuc2AmF4brYNmyjWXFOxlRLjslUfWrT9HvCFMbfNVWDxOA
 V2xnnDzDiPXRUnd/nkIA7W1CFepI7lQJw7loj2nE2I/TpaRPSLnSXJkjq3JfS8Mq8H
 6UwStrhK4n0wTfOX29/9LszgsKN+N5y4NDezr2awWFSwpZKMBCjsb41HxII3/0yYh9
 LwsR1utTDfJxw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPf8G0PJ9zKtR; Wed, 11 Nov 2026 10:57:34 +0100 (CET)
Message-ID: <b81472c7-0985-4a8d-877d-16f21b0042ac@0leil.net>
Date: Wed, 11 Nov 2026 10:57:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 s-vadapalli@ti.com, Anders Roxell <anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
 <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 4:18 PM, Marek Vasut wrote:
> On 11/7/26 8:21 AM, Anders Roxell wrote:
> 
> Hello everyone,
> 
>> This is part two of two. It applies on top of part one [1], which resets
>> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
>> the build for every board that enables DWC3. This part adds back the
>> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
>> builds and the gadget works again. It builds on Jerome's work [2].
>>
>> The two parts have to go in together. Part one did not change, so I do
>> not resend it. The v10 patches [1] still apply on ab4dc5aacf95.
>>
>> The resynced epautoconf matches endpoints on their caps field instead of
>> on their name. Five UDC drivers never filled that in, so each one gets a
>> patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
>> and mtu3. With those and dwc2, every UDC driver in the tree sets caps.
>>
>> Build tested one board per driver: every DWC3 glue layer in the tree,
>> dwc3 on riscv (spacemit_k1), RK3588 and RK3399, dwc2 with and without
>> DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc with SPL SDP, musb-new
>> on sunxi and in the am335x_evm SPL, and mtu3. 24 boards, no warnings.
>>
>> Ilias found a few bisect gaps, so I built eight of the boards at every
>> patch. Gadget configs build again from patch 20, the other UDC drivers
>> from their own fixup patch.
>>
>> Tested on hardware with v10, per vendor:
>>
>> - AMD/Xilinx: Love tested and sent a Tested-by.
>> - TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
>>    (Anshul).
>> - NXP: ci_udc with ums on an i.MX93 board (me).
>> - Amlogic: gadget and host on Khadas VIM3 (Mattijs).
>> - Rockchip: host on RK3399 Puma, same as master (Quentin). RK3588
>>    Tiger had two regressions, see below.
>>
>> Tested on hardware with v11:
>>
>> - NXP: ci_udc with ums on i.MX93, chainloaded from the vendor U-Boot.
>>    Three ums rounds, the host read 64 MiB each time. It needs usbotg1 in
>>    peripheral mode.
>> - TI: dwc3 ums on BeagleBoard-X15, the host enumerates it at high
>>    speed. That is where I found the event buffer bug in patch 15.
>> - Rockchip: host on RK3399 Puma and RK3588 Tiger (Quentin). The two
>>    Tiger regressions from v10 are gone, and he sent a Tested-by:
>>
>>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma 
>> usbdrd_dwc3_1
>>    Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger 
>> usb_host1_xhci + usb_host2_xhci
>> - Rockchip: host and gadget on RK3576, a Flipper One and an RK3576 EVB1
>>    (Alexey). No regressions against master, and he sent a Tested-by:
>>
>>    Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576
>>
>> The rest is build tested only.
> I would like to move this series forward, so let me get input on the 
> status. Below are the vendors which use DWC3 core that I could find in 
> tree, can I get a go/no-go on this series from each of you ? I hope the 
> CC is complete, if not, please add the missing people.
> 
> allwinner
> altera
> amlogic
> apple
> broadcom
> exynos
> freescale
> microchip
> qcom
> rockchip

Go from Rockchip.

Cheers,
Quentin
