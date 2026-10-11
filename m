Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE400CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 21:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82C3840576;
	Sun, 11 Oct 2026 21:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sI2cy5YR8fXo; Sun, 11 Oct 2026 21:57:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC9E44056C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791755870;
	b=LXDLsv2l6pH0XQqIx5UKxrQygyFauXLJDYMmtPcGiAV9/8QpvQne2P5oQbL8fnntGq1v
	 vN3935aR1zcIkvG0bI9fRvJgKRsygptoJZLD6yS3eZUrL+fMla+quCPII6VCJCMLBamsH
	 9E5U2GH6aouh3xEMtYqEJe6Tg6bMcnTBpj1VliLznI0TnpRjgbAB31BewTB5HuMwS8ZSb
	 9ac3gSUACj7YWw2yYFTY5xO/iumJAuEMrbOtpyWEX7Eo/BCHR5XQsQhCdfUC2rw9dJGKe
	 chuDa+JPj3gmibvZ5PwEJms70Y2hPcM5sxjc4X4L5NxVi2P3KbAErhb1qt+2BtZVZzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791755870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J1Ae+NgdnriyALOoVa4XjumIo+11NGkr2erkYk4L0Ms=;
	b=sQzb2wvF5V38dY80//ZciFOG0w9WWQKoQZ9PhXnKEb9OthW5chm5PssSXg5OSX7ruf//
	 Ih94NCOmr6wlggqpaZIG/Irl//8FCmAWs5Y1v9dEriCcfMttYw9udg7Oe4p12R/PHqfMq
	 KH0hJSBXSZ0VzxXD1nC24vRTXme4HZ5OxI1BZJGzCAzXBZj76S8MecrEDZX03Xks+AdDx
	 CyLvhv2ElzPzWE8pQrbvEWtp/qPNDEEyU3bVbGW+xqCBNXdbuA+li3XiV0sIl1R7+rMPw
	 MSkcbRXVW/kyKeVri+RmYv1zabUTbiqiBwZZKDn9116QqnRid6D4FLrfis6NbsyVxuQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=PoQ+LFqx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791755870;
	bh=J1Ae+NgdnriyALOoVa4XjumIo+11NGkr2erkYk4L0Ms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xzdh0/BkXwk8FUOSxL2WgW8cI81aRvDGWmdfHuoL7Ho2IxZ7dWDozgd1i08bCI83H
	 rpq6mHbKr86lWIWt1BaeKbyLz76SQvdKjRa6uIEvio79rDHBSMKG8IeBWGr2XlOgwx
	 dAL9swCbx/MAqB/AGWVqqe3X40HijGYhkYRYJoBrXObyijkROdLKyZ8SvWBlNMtai4
	 QpjlFRU5J94hiM8fOJ19+Y59t8iOE4vIFoFgu3oNCvcQoxx3tAR51sPDK7hBvp05Gc
	 dv4VBWgaAuM+KbDbpogAX297mMRZlC+R883OOVVqnTENBeaISg4nBKRhAT7DcE51mB
	 YSrYqqHEWxoCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC9E44056C;
	Sun, 11 Oct 2026 21:57:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB6DA380
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 21:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD3F74056C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 21:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HklJVUS-VY_o for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 21:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6D3914056B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791755867;
 b=elYELNkDpder8EAtCQEKW5z56NWTcfI5ATZtWcmpxOJXf03DSPfV4umcyfrh+yF/O/xw
 OUTPQ1+f7Qsl4Lj8sRVZUipbaNjEbA0HcEqzfoNLAH8dyaivIm2fegLKoEOa7wdYcFdKw
 rqEZu/V/8CKrd5Nax1tvxWc2VJLl2fwPnDuW9zaPm4fmJ+5QlTLRqTTgR3acPlQQgQxJO
 DqjqRbfwCBf5dZ5lm3nxFkjQbCVFjA/dLSiNsKKHf8baDcyl5GPk+tsnmPFIPgxPhtWei
 Si3NlGgw0e50/hE+H3zeRyLP47/7Bl8CgzXP+mGNshOJxQZd14al1kbaj5v1CF5cqGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791755867;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=J1Ae+NgdnriyALOoVa4XjumIo+11NGkr2erkYk4L0Ms=;
 b=c6KgW6Mh0fxEiUE9hJIkbpUQapsAQBMcfG2boaYEzW0CLkiN5USnLyfMcmO5n3R3u8Me
 k0kQ5YFNcfk5IYtKLfhQvdFBpgYDV3fzJEf93GNgi5GodnCV523rnor4fT8m7qr3sGBVq
 FQVVttD6PnvpOCkcrjxVxgkbY1guoLfMpr7c+2D1oXigVO+7vByL6cVGqS1HAiiTtc2+e
 x+4WudVfyvB+ZPBbrsCP2D35iyWq2tiLoShfLta/B8s4EOe41COF1m5MzZPfhArOBZOFI
 JzdffoJpBuXLZOlpIzjb03H5imbVwlXxtgozt8DxRAS1V1sQ7BFS0ct5OMitUfn1/8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PoQ+LFqx; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=PoQ+LFqx
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D3914056B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 21:57:46 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j2vbW1ckyzMlCx;
 Sun, 11 Oct 2026 23:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791755863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1Ae+NgdnriyALOoVa4XjumIo+11NGkr2erkYk4L0Ms=;
 b=PoQ+LFqxZuthBdC/kSxnLzKvZpmVi4DZs6/XQ3lD7bSRiHama2jPISNuJRF0nyHa5VMDHz
 S8PYAkBU8GUOZoBk8wHH2KcG3swaXvDMexpswa94d8w+cd02UXG4r90NuIdqL03iZTdaIe
 e5PrINm26xLRfkHigY1WPpXYDTMxJnHBvODt1vzKAuskjxKcwn6NzIrMzdgN7SCqY6DzX7
 5NnC84/eBzrgbP/MtYfOsZsWpAjC50ebm3linh4kHa36pvm9IivR4Vc2e1gwHoJvZErXr6
 gQu52azfcEni4D1kmX6g8y3JM2kLBpzeuMwtor5oCpTqMg2lSQZFtXNcYK2Wyw==
Message-ID: <d21fa3e3-4529-4a07-8c0a-ecd2802c0160@mailbox.org>
Date: Sun, 11 Oct 2026 23:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, romain.beauxis@gmail.com,
 u-boot@lists.u-boot-project.org, sjg@chromium.org, bmeng.cn@gmail.com,
 kettenis@openbsd.org
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
 <20260928192542.GA4035470@bill-the-cat>
 <86fd7ffb-b703-4b7b-b093-c4152540c34c@mailbox.org>
 <87a4okcb1g.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87a4okcb1g.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 07fc82d833209f904bf
X-MBO-RS-META: 4xk16phwmkbzxdbibhreksns4o8ehicc
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

On 10/11/26 9:06 PM, Mark Kettenis wrote:
>> Date: Mon, 28 Sep 2026 23:34:42 +0200
>> From: Marek Vasut <marek.vasut@mailbox.org>
>>
>> On 9/28/26 9:25 PM, Tom Rini wrote:
>>> On Fri, Sep 11, 2026 at 10:59:23PM +0200, Marek Vasut wrote:
>>>> On 9/11/26 10:32 PM, Romain Beauxis wrote:
>>>>> Neither bootm nor EFI ExitBootServices() stops USB controllers
>>>>> explicitly. Both only remove devices whose driver sets
>>>>> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
>>>>> controller brought up by "usb start", e.g. from preboot for a USB
>>>>> keyboard, is handed to the OS still running.
>>>>>
>>>>> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
>>>>> is the path "usb stop" already takes: the xHCI is reset, its PHYs are
>>>>> shut down and its clocks and resets are released. Child devices such as
>>>>> hubs, storage and keyboards are removed first, and a controller already
>>>>> stopped by "usb stop" is skipped. xhci-pci has done the same since
>>>>> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
>>>>> have ohci-da8xx and the cdns3 wrappers.
>>>>>
>>>>> On Apple silicon machines the running controller is user visible: Linux
>>>>> does not enumerate a USB device attached to a Type-C port at boot until
>>>>> it is unplugged and plugged back in.
>>>> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is that
>>>> not sufficient to tear the controllers down before booting Linux ?
>>>
>>> Jumping back up to this part of the thread. I believe the answer is that
>>> it is only enough once we set DM_FLAG_OS_PREPARE so that we know to find
>>> and tear this down. Without digging through all of the discussions of
>>> the other places we've used this flag to fix a problem like this over
>>> the years, I believe it's a feature not a bug of how we do things that
>>> we need this flag.
>> I am not convinced this is the right fix, but I asked Mark to dig into
>> this, since I don't have any apple silicon hardware. Maybe they can help
>> here.
> 
> Sorry, I've been a bit busy over the last few weeks.
> 
> I've had a few reports of spurious USB DMA activity during early boot
> of OpenBSD.  I recently made some changes there to enable the IOMMU
> properly (instead using bypass mode), and just received another report
> that definitely points at the USB controller doing DMA when it
> shouldn't.  I haven't been able to reproduce the issue myself, but I
> think there is enough evidence for U-Boot not properly disabling DMA
> when handing control to the OS.
> 
> I think that adding DM_FLAG_ACTIVE_DMA as Tom suggested in a different
> USB-related thread better reflects the intent.
ACK
