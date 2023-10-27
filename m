Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE8C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 06:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36787876AC;
	Fri, 27 Oct 2023 08:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="sjZe2n55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F039A8769B; Fri, 27 Oct 2023 08:04:05 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF22876AC
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 08:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 6D71941F75;
 Fri, 27 Oct 2023 06:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698386640; bh=NReBcm6zFw5a/BwbITc6ayGnF/poLpxDkfVYk6QtzU8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=sjZe2n55GJnkY0DBufr3jqBtv1WnRjTYqfTOrcuOzOPcLpUqUrJY+O/6DL1SF9SSf
 MjVKguYZrVuSnXv9zNojC3aKa7GNp+D7KQ798WyxyjBuv409jZQAqjrFPrl7Or7KwT
 kHsc9WU1JjafkqNOtRsOudBMh5UMxONyQg4YYI6FDoc8KLnJnf5mnpH92Df5X0MI9C
 olTGhVWemCOWC/mcuwMbqlnRmk+Et7gOfCwwQpQ9v/BU1uSMIY84fe6NKVpmafOVb9
 kAXSejJgGTgmuWKskaIRdu9TbiUTKTD41d2EPt9/TI4Ol6gxOPWyKydDe/9J8JwlTQ
 O1pKqmF0L0JcA==
Message-ID: <314492c3-4cd3-2711-1693-6d58501a9bd9@marcan.st>
Date: Fri, 27 Oct 2023 15:03:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fixup! usb: xhci: Guard all calls to xhci_wait_for_event
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.de, Minda Chen <minda.chen@starfivetech.com>
References: <20231027-usb-fixes-1-v1-1-1c879bbcd928@marcan.st>
 <20231026232642.16668-1-marcan@marcan.st>
 <f2cd8dab-a494-4e9a-b450-0311444f436b@denx.de>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <f2cd8dab-a494-4e9a-b450-0311444f436b@denx.de>
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

On 27/10/2023 09.36, Marek Vasut wrote:
> On 10/27/23 01:26, Hector Martin wrote:
>> Gah, I should've paid more attention to that rebase. Here's a dumb
>> fixup for this patch. I'll squash it into a v2 if needed alongside
>> any other changes, or if it looks good feel free to apply/squash
>> it in directly.
>>
>> ---
>>   drivers/usb/host/xhci-ring.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index e2bd2e999a8e..7f2507be0cf0 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -532,6 +532,7 @@ static void reset_ep(struct usb_device *udev, int ep_index)
>>   	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
>>   	if (!event)
>>   		return;
>> +	field = le32_to_cpu(event->trans_event.flags);
>>   	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
>>   	xhci_acknowledge_event(ctrl);
> 
> Please squash, and add
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Also, +CC Minda,
> 
> there has been a similar fix to this one but with much more information 
> about the failure, see:
> 
> [PATCH v1] usb: xhci: Check return value of wait for TRB_TRANSFER event
> 
> I think it would be useful to somehow include that information, so it 
> wouldn't be lost.

The root cause for *that* failure is what I fix in patch #5. From that
thread:

> scanning bus xhci_pci for devices... WARN halted endpoint, queueing
URB anyway.

Without #5 and without #1, that situation then leads to fireworks.

A bunch of things are broken, which is why this is a series and not a
single patch. I have more fixes to timeout handling, mass storage, etc.
coming up after this. I fixed most of this in one long day of trying
random USB devices, so it's not so much subtle super specific problems I
could document the crashes for as just wide-ranging problems in the
u-boot USB stack. None of this is particularly hard to repro if you just
try a bunch of normal consumer USB devices, including things like USB
HDDs which take time to spin-up leading to timeouts etc. The crash dumps
aren't particularly useful, it's the subtleties of the xHCI interactions
that are, but for that you need to add and enable a lot more debugging
(patch #8).

I think the main reason all this stuff is broken and we're finding out
now is that u-boot has traditionally been used in embedded devices with
fairly narrow use cases for USB, and now we're running it on
workstation-grade laptops and desktops and people are plugging in all
kinds of normal USB devices and expecting their bootloader not to freak
out with them (even though most of the time it doesn't need to talk to
them). It's really easy to run into this stuff when that's your use case.

- Hector

