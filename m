Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0C606A32E
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yZYBIwtS;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Cpa5vcNu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7688D81360;
	Wed, 11 Nov 2026 04:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dGcuTJUpKK88; Wed, 11 Nov 2026 04:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CD328134E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794370476;
	b=Sbn8DASXgejz/69NykiLwz9aOzAK7BrjX71mpSWwgxt2JSJzxZt0UW7deGdwKG+u2tKC
	 MAHrUuzKHAbrMUQ7JKndWIxuc5YxUA5OjrCjSbMrotR+zcPPsj/HanTG7q95/U/O4/Grr
	 nyJuix/zUDvD6H3ofUZgomElpgXuRxMKbEJA+bUknc3xwjw6ghLFve5Ggw3kNhLpddGF5
	 84Kw/2+aQ+K8lrddcnXabKSO7Cn+hioo43hjnI2zoTKoVcNf+5ZX13766o65Hu6kcOWP0
	 ZUHmjfVJtxMLUBkyvVcoFM5RvdeiMjLP53VQhgWhRdvC1N3+e5h6ZALxo3Jgg+lke3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794370476;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1mnOhhtGyLCdcAdQR8cRBlwbRCCb9cDATYL1z8lYdS8=;
	b=UsVAWSWyAm7YDjvJi3ty2p5dviOoTV2VF4VbdjncPJCkYMFleWjzGFjU5vG6hsIkFZzP
	 Zste1oAw7EDYUXkbs+77XSTAVVzC6bp59r2IUSaWcGwRoYRmeVFUXylXGxqtqbU4AAeYy
	 +PKt9LcJedUQ+XWLee66X+v+A0bB+HSnqbs8QomZf2xMD/KEjhEosVlo7q2TMPCxpWERm
	 CB8CPIVdEx8sPGtNHfvLHd6HxiKH226WX3b/u1oaSt2GsdWoGwkXyRNePOR8iArRS2FYh
	 7NddfEYdkW9p1Lh2ygMpbUnF2Hd2U78rz+jlYudsNwVtnZUGYm1R+g4B3GSXpSAQQzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794370476;
	bh=1mnOhhtGyLCdcAdQR8cRBlwbRCCb9cDATYL1z8lYdS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yZYBIwtSYyKK5vjyUa32hVFUp9TP/65zZULCPamKBBqN5JVuMnQpT01bt76NLqWKw
	 ClnFEqj5PD8dk6htJd60qhFGlZZHdemf0y5BkCe4OS4D0cBxHdvhasJY0xkMgzxmLH
	 IjNgdSoCE+PQY75SBOz/AwMsmxhFiRDzxSZ4vSk2abXC5kSGO5lSNs+lTNtIXnVHjm
	 TDa7kiSksda+Auk9eTYMxRFrfIsO1qsIFrSDOqlsePvJaTuZLX0nGrNsHzu5L1v6GC
	 nchHjAyJaB4f+j346lPUkPULEEAwcpbBK47+0/OQb6COGYzpzcNGSitxlX+SHBpyC4
	 9Omtw8eVo0ucA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CD328134E;
	Wed, 11 Nov 2026 04:14:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC4E317CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 04:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1D92608C4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 04:14:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRYptsHkXZlS for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 04:14:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 532EA6073E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Cpa5vcNu
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 532EA6073E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 04:14:31 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jPVXM4bzNzMlPR;
 Wed, 11 Nov 2026 05:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794370467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mnOhhtGyLCdcAdQR8cRBlwbRCCb9cDATYL1z8lYdS8=;
 b=Cpa5vcNu67drr6SthCRnMO66wt61C3GeFmq6pSSeBZf9v9S5n33Z2sbPOJLIHNznrZrQKr
 BAbbwIB0kdDc4WnHJTTsOYDr2/hqQoEpVnwCPQoqbmksQeDqUgOxeWlr5t5Grap5pn9trG
 qaRIKyfETiNY4ajW7ZDY0G7vNMzu/Z75odqUFa4ayQK7sG+9HqPTx9DsJnbqgqcIutcMUf
 HlG44YCr8rNWoINWu7p2u7jrbJxpWivzkWJChmLAq3J0trz9X3dR5vGjsB6f3RoSpYLf/Y
 KiWa+6pM5oeT1vb0p3bXsJcza8vJXNkbol5j0DzwhbrtcRQcKLcvVAVsuOUE8A==
Message-ID: <205058d0-f257-49ce-be85-19c44bc6c5a7@mailbox.org>
Date: Tue, 10 Nov 2026 16:18:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1tk17p41mqpjt8ouyt67sqwky6kusnr7
X-MBO-RS-ID: 1cc3e1999f226c1f6de
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/7/26 8:21 AM, Anders Roxell wrote:

Hello everyone,

> This is part two of two. It applies on top of part one [1], which resets
> the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
> the build for every board that enables DWC3. This part adds back the
> U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
> builds and the gadget works again. It builds on Jerome's work [2].
> 
> The two parts have to go in together. Part one did not change, so I do
> not resend it. The v10 patches [1] still apply on ab4dc5aacf95.
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
> patch. Gadget configs build again from patch 20, the other UDC drivers
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
>    speed. That is where I found the event buffer bug in patch 15.
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
> The rest is build tested only.
I would like to move this series forward, so let me get input on the 
status. Below are the vendors which use DWC3 core that I could find in 
tree, can I get a go/no-go on this series from each of you ? I hope the 
CC is complete, if not, please add the missing people.

allwinner
altera
amlogic
apple
broadcom
exynos
freescale
microchip
qcom
rockchip
socionext
st
ti
xilinx

The current state of the patchset is at [1] in case you would like to 
re-test.

Thank you !

[1] 
https://git.u-boot-project.org/u-boot/custodians/u-boot-usb/-/commits/test-dwc3-v11
