Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A4DCA9ECA
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 19:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82E3E6069E;
	Sun, 11 Oct 2026 19:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJ2scoD3pr2U; Sun, 11 Oct 2026 19:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E5F026061E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791745579;
	b=gYt9EOeMOvyquPRNPxcKZrN6vtiOe6uvBapwQpRdSC6aN602RCa6/wFui9IGKLWA5lNl
	 Sx+TOpKVjPubHC8vPe1DqzxJ1QIEjFQ0IXb6zB2hQpLE/3kYuSD0DazzTsz/r0HjQee0I
	 60y7ncfEp5U4YAbcT2A+DwWIH7CVXBjaXvuYQCWkNCzNVDlBb8osxyJyiVudagwlbiK84
	 cqRud+kK4du5xVarvwK3s3Efj816/zY4G/xvYWUURXt4BWanUE+e9vlmjLlumQTRnIV74
	 Qj+k68Tw0iemJAHrLfPfsWf1mARcYHsFNukU2BYVHCTq3ImOqK/GyZfuuhdcCHDdMZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791745579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oiDhOOpkaQYDQ4jm4ZeRz4/7S374k/bAty/Ul9VSu5s=;
	b=eTFbCIw4E599qoS5u0OlQ1CPyzOT0g3nLg0cqtLgTse6Vd18XsOAEF69dO7pCtdrqCj2
	 nUBYEfRVpA2nPuaeL87agKKr4gfNVE/S3HjZEwyaBfv3VhYhmj5MxhkCZoQTtOaD0GCeD
	 sxJSwgnOh3fsAGjfllUbiGYa5RChLIOJR+zH+pIsYTMlijD//YuVqu66KhC48N7ER5Jzi
	 lHCcIxnhGjQzh/Ck7eOAvW2DNegF2GqzYddh98KWAjlXLGEPeUUp70bdgLBuU7HOORZVw
	 l9TAjvHqvKa0DDx+/1m22srFZSXmVESLVISJr5zYOxBMspvCf6+DXigtm82z3zCwwiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791745579;
	bh=oiDhOOpkaQYDQ4jm4ZeRz4/7S374k/bAty/Ul9VSu5s=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j7yfNmk08fM/1bZV1kp1W/z3ZceyBJnBFgWAheKRSf90ynI+bUJeCQW+vpVlEI7eV
	 IeUSquOeZrcc3s7/9cSTBdUnamQBuWpd03laE5bLeLqf8VWoRPAhQNNTi1cPqk4zRU
	 MzPFZSe9K6pEPqSYCvNNmi94pqE/5LwqkDUeB8Qe9PF90Mh401A7hUII/FZwshNHDn
	 exVVmYix1GiOuDmOaLJqEcOy/307oX84Ucw+7CHr261MuPGD2zVjtiU+g+M64rUrBG
	 CWT2Qj4y6AzdrniXBDwD+nRr5phWrLz/7z9uGR1v4bPm4Vk8ybV4fpptk1qcp4d/2H
	 n4gPcorHWIyKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5F026061E;
	Sun, 11 Oct 2026 19:06:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6527B2E0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B5AE405DC
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HTrKTI8kkUTm for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 84BB6405D8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.168
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791745575;
 b=QEco1tgE2uuZmdN3iBOlu2cw9UrnoM0NRSxwNlp3XbDnVaN/Z5IGYjsulgspBqKFVOKi
 Oc/rdbXHieUiEKR1UmZAd77r+vPDZs/I1k9QWkld72q9DQFaFw9cQzgTcM3MLhrPlV9gW
 Cl2VOBdo9gzEVQ0LZq0EO5HJ79a1CwthXPZ5c9f4bC8LMzc2qc0yKlUtIbjw/9nvT9G+x
 tSdANqOEC/e7wZrxKw7LyYNHP3p4/hp/XtRDlDjzT1gFPOapMRSQv3RDws292BhiiFtAm
 9VMAdDPJxiQy7SvcFddIb2PUssBQ69lNucuB+Jra8sSu4OYe+KWz5Gv9HnnQ1e4mGVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791745575;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=oiDhOOpkaQYDQ4jm4ZeRz4/7S374k/bAty/Ul9VSu5s=;
 b=LHtd9ZU2MjpS32tyfQehWgXnDK0ZPd1tZ2rCT4izpIVWF3Vl2LLkqDp7YW3OC82BqhS/
 cKIwv87PvF1CZ1AJUkANBsA3K5iIG+w57qcCUDDuiw3319zlBY4Q4iEGMiq0NY1odGT/7
 8BZ3zCU2024OPLTEe7pUyN3xeQAOZocAzDM9JO/zNTBezZyCtIKfNHwlllrmgdyqDpFEv
 wK0OICeJ4sKXrjLqOxpt9pf1u2WYbCn7UTi59paspXzssjr0/QcInc2EujaD/uidPxxCf
 J2RCSk/VdSuOCSu8MuMUC6SdOrjV+UBvoyisro70pzof6qWVOPGtm8LzvPKiioOaVQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=xs4all.nl;
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=dhPXaR4s; 
 arc=none smtp.remote-ip=195.121.94.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.168;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=dhPXaR4s
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84BB6405D8
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:06:09 +0000 (UTC)
X-KPN-MessageId: cea161b2-c5a6-11f1-8626-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id cea161b2-c5a6-11f1-8626-005056aba152;
 Sun, 11 Oct 2026 21:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=oiDhOOpkaQYDQ4jm4ZeRz4/7S374k/bAty/Ul9VSu5s=;
 b=dhPXaR4sa43v/N51Bmh2ND2JUeW+A5bW0xKijr8aciUi2TzSqslUpie+Vc3zNS5/y9Un95wpkpOpw
 vHyxHw+tMq7ELlRx8hKgWibqpgxxelYMhKdZZQQ6bE4T4BuJ0SjDGmnzQR2h9bOg5pjkc4jAsbQ4zK
 6v4oqfO2BSaHz6jxwsmSPQp/ahGCx9y+CYfS803bBWlugX6g1ABuoT7O6FBoOf+PT/8Y3BHAJg3ytY
 0YhUab/VCBuJSmT9eArFqni2dgMkfSrEHs0W9YlApWTzSLcOkDqjaHUDqitIXw68DdckHPpB0ewdvZ
 OYe1hNlnDYtOjn4wo6YPpZs6EZIbhPw==
X-KPN-MID: 33|zFCjmtH7M5dUOSUXFDBkAdRMT/zTL5srUgHvYO/arBt3pxzg8ZqTl3ywDcTxZmc
 SNY40b5ME2ITb3qPYwqcNP6TMWkJjkW1lBW1OVLe9cBM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|uHE0y4PUbVFYZC3pntnUXyV94q1qq7HXGh1yp7dQmvO3k9byW5xTKETNjsp6jTN
 L4ArX7oaEuc8SaXoCYh1lIQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id ce28b30f-c5a6-11f1-bd30-005056abf0db;
 Sun, 11 Oct 2026 21:06:04 +0200 (CEST)
Date: Sun, 11 Oct 2026 21:06:03 +0200
Message-Id: <87a4okcb1g.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, romain.beauxis@gmail.com,
 u-boot@lists.u-boot-project.org, sjg@chromium.org,
 bmeng.cn@gmail.com, kettenis@openbsd.org
In-Reply-To: <86fd7ffb-b703-4b7b-b093-c4152540c34c@mailbox.org> (message from
 Marek Vasut on Mon, 28 Sep 2026 23:34:42 +0200)
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
 <20260928192542.GA4035470@bill-the-cat>
 <86fd7ffb-b703-4b7b-b093-c4152540c34c@mailbox.org>
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

> Date: Mon, 28 Sep 2026 23:34:42 +0200
> From: Marek Vasut <marek.vasut@mailbox.org>
> 
> On 9/28/26 9:25 PM, Tom Rini wrote:
> > On Fri, Sep 11, 2026 at 10:59:23PM +0200, Marek Vasut wrote:
> >> On 9/11/26 10:32 PM, Romain Beauxis wrote:
> >>> Neither bootm nor EFI ExitBootServices() stops USB controllers
> >>> explicitly. Both only remove devices whose driver sets
> >>> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
> >>> controller brought up by "usb start", e.g. from preboot for a USB
> >>> keyboard, is handed to the OS still running.
> >>>
> >>> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
> >>> is the path "usb stop" already takes: the xHCI is reset, its PHYs are
> >>> shut down and its clocks and resets are released. Child devices such as
> >>> hubs, storage and keyboards are removed first, and a controller already
> >>> stopped by "usb stop" is skipped. xhci-pci has done the same since
> >>> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
> >>> have ohci-da8xx and the cdns3 wrappers.
> >>>
> >>> On Apple silicon machines the running controller is user visible: Linux
> >>> does not enumerate a USB device attached to a Type-C port at boot until
> >>> it is unplugged and plugged back in.
> >> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is that
> >> not sufficient to tear the controllers down before booting Linux ?
> > 
> > Jumping back up to this part of the thread. I believe the answer is that
> > it is only enough once we set DM_FLAG_OS_PREPARE so that we know to find
> > and tear this down. Without digging through all of the discussions of
> > the other places we've used this flag to fix a problem like this over
> > the years, I believe it's a feature not a bug of how we do things that
> > we need this flag.
> I am not convinced this is the right fix, but I asked Mark to dig into 
> this, since I don't have any apple silicon hardware. Maybe they can help 
> here.

Sorry, I've been a bit busy over the last few weeks.

I've had a few reports of spurious USB DMA activity during early boot
of OpenBSD.  I recently made some changes there to enable the IOMMU
properly (instead using bypass mode), and just received another report
that definitely points at the USB controller doing DMA when it
shouldn't.  I haven't been able to reproduce the issue myself, but I
think there is enough evidence for U-Boot not properly disabling DMA
when handing control to the OS.

I think that adding DM_FLAG_ACTIVE_DMA as Tom suggested in a different
USB-related thread better reflects the intent.

Cheers,

Mark
