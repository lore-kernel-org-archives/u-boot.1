Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66614C98318
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 05:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A5AA40B3A;
	Sat, 26 Sep 2026 05:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAwI8g3qEodl; Sat, 26 Sep 2026 05:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 61C7540B11
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790400005;
	b=dFIdYExxCYMc/yLP73a4X3/S99nsFGb6PWlXn892zcxPFrjfNsakCSzdcXtsaxrYrz4s
	 PYAGkn89IskkwvQVGqUuescgrKbsIsOxMOkg4hNJsji2HxHoQWHzcQ+ML7+6DFIjv72rm
	 ZT6A/v8rL9Vu/t1/IpWmioM0nsVU4eNrx/dqdGBZmQtwW39ngOOhp2zZBIgYZmDDmqtnX
	 aL4xVjYV8lXo+JsOePHQ/G9SVABCr4BalRxAmuepYEmMVzpuHVlCIUT783X7iiqd3hNrk
	 RA9b1K063sLF2NReF2C6iwuB/Ljrqb6e4uQfPLpzILhh2d9VVG7nBJ6bvC43BsRgduw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790400005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gyHnQSZe+nVpWl/qb3kL32DWTM1nWiRBYX5/KIHb62g=;
	b=az0+KHg3tMyr42euzBUu6DzcaUmvLgVUed3VgPHxPndqUF06LhGliUOrRhIArHPLt21H
	 cLlp5tKoyjIZScTZ6er56/67z+JjpMqmrI3ntnKBc6eE7TRv0Us7kXeq68Nenv2Yuer9C
	 xpe5x9hViJjIs/Zh383YDyHMfjoxMB6EyucwP1qDHQ2jZz86B1Ewd1NbesA4JKcG9OQz1
	 hXwZDDK4lLa5DJqVvz/E11qrf74wWyNu+9W+Vk/EtpyT+e9feNRk32C2K7mZtJFgQoSLN
	 ogQnKCaq/uB69LsDQ0Oszat6ZCbimL2+kfmG0PO3L+aeBZHCWknsb8z0ptqZtYmziVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=hs8tFAnm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790400005;
	bh=gyHnQSZe+nVpWl/qb3kL32DWTM1nWiRBYX5/KIHb62g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qFyeo+vL4GzzziUgMC04v4CSAJyBUVv/tmSrQONCjZy/4/YIU4pB9ujtv4ReEPpZ1
	 irKXWAQsY7TCL1QNKen3EVnF0F39K9GgoOnhnTjxS+OVtEdAGjsA8FJTfvYRwps/e5
	 Hs0IMI4zQnnsKbLh9J3ga+HqxyqAek36ZmANYde5jaXrg39z41X8vNu//Wlw5f0Ets
	 v9dYtEiGL/5DGqkx1kNbkwKPr70odgmZH4FIXuZYl8JAiafHmTJo7wHsdOnHeKT11t
	 zGqswpJx8+XemEi9c3d1cZVv43OMD4/vQs1xbn9xKZaU7M51T5Rt5dpfdeZ3JR7kGm
	 PJLJTZLJeWYjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61C7540B11;
	Sat, 26 Sep 2026 05:20:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AC5124E
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 05:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CBB240B04
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 05:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csz9uiMS-KJQ for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 05:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D1BE40B07
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790400003;
 b=Wa77MbSzIHkVZzfDIGzGgOe8AeGqvW457TVZA4OZiI/5E7l6mhpRVsCE4HfF4H+P/OPS
 9qdhlMJNdg9q4qAxbpBcKSLMFxGxlqoEhtIx6ytJg2mAncNo53K9iF/w6o/+wQx2QxpOr
 MuBqLs+lSFhz5x2H9eHBfcZqk45/5d0MNJKyjcHngbgltoBUG/kjW0ssLnGJom7r5e66t
 WpyjyHReFsVqN6buAoGH+HKdjPkOowKmN6wWiMUJakaWl6tzs85R1GZgH0fqX0VvTH5y1
 nHKDn4xTDA65KCaauq2nw2Z0lg4jCDge5ePNUhERvzxKM9esxtbqer5JToLyGOEBSKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790400003;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=gyHnQSZe+nVpWl/qb3kL32DWTM1nWiRBYX5/KIHb62g=;
 b=PpYu4qR+NOQld1Y6abk/zQreU5iLpYmAtbXwC/lq4zYz64VjGZmmObvLm3ERcIPVxHK+
 id+MPSqiTIg4eO2TMWTXMpAUxxb0WvpG20NH5WPy5iUFNAKE2S/xNfK54Hua+SxNzxRI/
 pKwBgyrJ7F+WMG01dHAEqggagHjmyv8Xl/cgW1RL0R2uFDmUBpjUhjDHcXQn73/zk63hh
 vMBoZ56v1pb+At8VfUWwQs78RaerEdyGGXg5w2PXKyAUuNslYhGxo5DH8GltGj3EqOp7F
 7vsiprqLCageXLXVLjlrU4Dga8PAZYpvGDbfFtpwUB8mKSTMQ7ftZnhVy5ONlNdZ/Og==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hs8tFAnm; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hs8tFAnm
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D1BE40B07
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 05:20:02 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hsG9B0wjQzMlGM;
 Sat, 26 Sep 2026 07:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790399998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyHnQSZe+nVpWl/qb3kL32DWTM1nWiRBYX5/KIHb62g=;
 b=hs8tFAnmmZeIUoXHHliM6f8WgED3tHNumBkicUDfhr7sxbyaLL/AQ/YSN6+oMLf8NflGEg
 TtMdpMgjMc+oRDe5yz7Kjdbwd4WC1hVzAWLyupJT9RYJf1uVrGWB5N1p/1+XIQLEmwBObu
 blqCJRziUEhrhdutHznQBYtF0GCbMRTkiMwNEwxkGBO8dRMPCNXHYSSRmc6YfPhQ/+mIUL
 D5SKD7Bs/ZqVfaTFIAFOfleFJDNFcV0XXdW8FDqdIBNCUpwYLWWiPh87pz/0L5EOwIkDk3
 aShuTrOjiJQtKJftWMj6EGR4c5puw0ECvmm9KBLnDWMk8bgwoH9gfrwpl3CRTg==
Message-ID: <a614b702-9d8a-4e7e-8a7f-ab50b5fceb22@mailbox.org>
Date: Sat, 26 Sep 2026 06:38:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Romain Beauxis <romain.beauxis@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
 <CABWZ6OQ8xqFUQDt8FyODZPzDC=SFOcxr7bDe0eAF5K0OpwTy4g@mail.gmail.com>
 <6c15d243-812c-4674-bee2-7d3fb5671beb@mailbox.org>
 <CABWZ6OSpK+KA8VoQ_Y7nywXjeUzRLEnfTXa=RWdgKZ8RHwRw-g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CABWZ6OSpK+KA8VoQ_Y7nywXjeUzRLEnfTXa=RWdgKZ8RHwRw-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0f90374393bc67154d6
X-MBO-RS-META: gztejzbfkfh7eosf96o6t1x1yhc1msia
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

On 9/26/26 5:35 AM, Romain Beauxis wrote:
> Le mer. 16 sept. 2026 à 23:47, Marek Vasut <marek.vasut@mailbox.org> a
> écrit :
>>
>> On 9/16/26 9:24 PM, Romain Beauxis wrote:
>>> Le sam. 12 sept. 2026 à 22:04, Marek Vasut <marek.vasut@mailbox.org> a
>>> écrit :
>>>>
>>>> On 9/11/26 10:32 PM, Romain Beauxis wrote:
>>>>> Neither bootm nor EFI ExitBootServices() stops USB controllers
>>>>> explicitly. Both only remove devices whose driver sets
>>>>> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
>>>>> controller brought up by "usb start", e.g. from preboot for a USB
>>>>> keyboard, is handed to the OS still running.
>>>>>
>>>>> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff.
> This
>>>>> is the path "usb stop" already takes: the xHCI is reset, its PHYs are
>>>>> shut down and its clocks and resets are released. Child devices such
> as
>>>>> hubs, storage and keyboards are removed first, and a controller
> already
>>>>> stopped by "usb stop" is skipped. xhci-pci has done the same since
>>>>> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
>>>>> have ohci-da8xx and the cdns3 wrappers.
>>>>>
>>>>> On Apple silicon machines the running controller is user visible:
> Linux
>>>>> does not enumerate a USB device attached to a Type-C port at boot
> until
>>>>> it is unplugged and plugged back in.
>>>>
>>>> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is
>>>> that not sufficient to tear the controllers down before booting Linux ?
>>>
>>> Any idea how to test this?
>>
>> Add a printf() into the controller and uclass .remove/.unbind callbacks ?
> :)
> 
> Ok I can try that but I'm not sure if your question covers a part that's
> been untested. What I did confirm:
> * Stock u-boot: kernel does not pick up the USB device on boot
> * With explicit usb stop: kernel does pick up the USB device on boot
> * With proposed patch: kernel does pick up the USB device on boot
> 
> Is your question related to a different scenario that has not been covered
> yet?
boot/bootm.c bootm_final() does call dm_remove_devices_active() , that 
should be enough to shut the controller down. Why is it not enough ?

What does "the USB device" and "pick up" mean here, does the controller 
fail to enumerate devices attached to it when Linux boots ? Could the 
problem be related to some clock or some such instead ?
