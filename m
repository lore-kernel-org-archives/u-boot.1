Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A914C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7290388125;
	Thu, 21 Mar 2024 20:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jIs7eJrO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VNcCX4+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 493EE88126; Thu, 21 Mar 2024 20:39:06 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5947287CB7
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 20:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V0wkb5lMJz9sRf;
 Thu, 21 Mar 2024 20:39:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711049943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4XLGGtmmxvF2PwduTgiC6xedSZIRuTO3hdcqxwdX/A=;
 b=jIs7eJrOXGhC4t31Pw2pqAS/ot2opsGLX0R8gaLCF1UrBUG4ZmGHPQmX1eTRuSjUsgUJak
 +Th6zLSDYkTeA0RmdyCsXKjSOXs9o7Pqi6ngVlSwOvluMdhu/CXnCkYo+zyDaUgUNS1CGJ
 9/7GOUYXYNyssCQisDZTQsa9QJVsP2XE841d9haX7o2+HQCFWHV3MPUPPzwnmygsIPJz+x
 VuK7XqFQl4poqhgDcWp3WX7ZpNT72hdSRb6SKDAjEfZX4oF9JippIe4jjmt3SKhvqiGQ5b
 10gtHRFDz6mvKVBcsIiiX2/BgHgVGX1lWz4HtsM4gK9wvs26gVCTAoyk/G+N1A==
Message-ID: <74a88ffb-c211-4886-a017-a6c523e7e5d9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1711049942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4XLGGtmmxvF2PwduTgiC6xedSZIRuTO3hdcqxwdX/A=;
 b=VNcCX4+pPZkQha3H6vGVxU+vnVSkj0MuMpIrniTNjAtXxGtx7Wh+NOYPF4IdfkaMnRZzZz
 k7E9usPJVh/zkHFjAJEyRARdYDB9+nsfK5LWh5mmzVHFkj0kXxuMDaYTkhiLlAGz/qnZxq
 /vDDNarxTVfwt3Uwm1an1IrLE0dZaSV7ey6eKzkiBiwXMWwE3Fa38hjPrfeehrQmZ7zeUV
 SAbBXzkOM3+kfpc0TUvWOwn7TX6bkf8JbJwfJl3ym9m3SWtt6e3LsP/0tZH/0PtNJ4ssWI
 sUzgyo7MdOfgCvvpQkoV6L+Cnw6uvXSrx3KNaih0eMtixfedHXhORVPdt5vf/g==
Date: Thu, 21 Mar 2024 20:38:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] usb: udc: dwc3: Fold board
 dm_usb_gadget_handle_interrupts() into DWC3 gadget
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>, Caleb Connolly
 <caleb.connolly@linaro.org>, Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Stefan Bosch <stefan_b@posteo.net>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 kernel@puri.sm
References: <20240317044357.547037-1-marek.vasut+renesas@mailbox.org>
 <878r2boqd8.fsf@baylibre.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <878r2boqd8.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 01910d7a09cd923076b
X-MBO-RS-META: qkthwe9414ogb6mbke3m9or16h9dex7h
X-Rspamd-Queue-Id: 4V0wkb5lMJz9sRf
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

On 3/21/24 11:01 AM, Mattijs Korpershoek wrote:
> Hi Marek,
> 
> Thank you for the patch.
> 
> On dim., mars 17, 2024 at 05:42, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> 
>> The dm_usb_gadget_handle_interrupts() has no place in board code. Move
>> this into DWC3 driver. The OMAP implementation is special, add new weak
>> dwc3_uboot_interrupt_status() function to decide whether DWC3 interrupt
>> handling should be called, and override it in OMAP DWC3 code, to repair
>> the special OMAP interrupt handling code until OMAP gets switched over
>> to DM UDC proper.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Tested that I could scan for usb mass storage and that I can use
> fastboot:
> 
> => fastboot usb 0
> crq->brequest:0x0
> => usb start
> starting USB...
> Bus usb@ff500000: Register 3000140 NbrPorts 3
> Starting the controller
> USB XHCI 1.10
> scanning bus usb@ff500000 for devices... 3 USB Device(s) found
>         scanning usb for storage devices... 1 Storage Device(s) found
> 
> => usb storage
>    Device 0: Vendor: SanDisk Rev: 1.00 Prod: Ultra
>              Type: Removable Hard Disk
>              Capacity: 29328.0 MB = 28.6 GB (60063744 x 512)
> 
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # vim3

Thank you!

Please feel free to pick this via DFU tree in a week or two, so others 
can comment on this and test this too.
