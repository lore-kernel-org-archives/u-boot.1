Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851D9C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 04:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D498C60718;
	Tue, 29 Sep 2026 04:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75ZaPToHVBVJ; Tue, 29 Sep 2026 04:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3A2C60712
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790655385;
	b=ZXuAOtuAR/5rbrXPjVFdFLNSl73Qv+gzXv/NVJB4UOxu1AA8bwih2gNV58o5x07fH5K3
	 qK2a4a8T2REYDnE/TVq/7tvr5YZqURSxdvxw7orzA3qjH6qr6uLSI+V1AhnFOZscOD/Ye
	 q1fCZE5P2M8b4GsyLnAEWlZrC/nb8s0VOpR7VzhaE4+eyO9vqefmy4FKJE/IuWIO2wkdb
	 Xf7F/G85buc/e4dzO4O+2E/lJavRpu9AeQ37HdF/mX4ewwvV1shPjrYrRGYmarD2ewQTH
	 CA8e60C1j7g75mOJeGqyNOXXRcq5tdH7+1gd00+XxIK11qd3GQrf2AFfiD3+QhqMItQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790655385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+1zgOqOCUMWhQrK9gkpUJGBo/fsIMDcyKRjsAnZ/jA8=;
	b=YMcRilJ4696fTwWFNW6WMgcLFEAWszV7We3FSRDe6qpqY9P4NizX3xjfwpy9TUUVSb98
	 AL3n3g4U25k8JMezWa83pmV3+e/C51NSXPgaoAiNYNvGnJIZ9U627cmiE6dOfJUStaXFk
	 W9ecNWJ7Sqm5GUqn7q9HtYb4fikbHF5JMXEcjjrNoEpPIyUJaz0Fo+ev3h/qkbeR+qKY4
	 Y+yiXYHXfGw4xCEcrZym9NJsXRNXgBrBCv8lmYk1wji9b6YhuLyvv8gf9V9FcGnsa4bcH
	 6zkN4PhJ7AB0cdBQCVFmuhcvG1+tMw+x+VaKNpArKJM41N+9oqLxi3xxK2QFZ61XhsA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790655385;
	bh=+1zgOqOCUMWhQrK9gkpUJGBo/fsIMDcyKRjsAnZ/jA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ooz9gFyIo92+gkD0udqDEx/DrOtxJrso5i9JGoZ7/tgUdsKQm1rXjrIz5lYjFuvgc
	 nbDhfbP8R0FHaQYdGxdBlDNeXMaE7Q0FuuK2wU95A6GiFSG6Hu6bFK663joJVQeeHt
	 ZIPkt8Sj8akXycCYzR8qRuSRx98xVWiqbFgCZZXn4fAesy8m76MP08uJKf7sBZ+z+q
	 gAOVBWZcGbRvL9BeRM2FMyoRZI+EZA/cyen2xSqb9Al/Z3qcIVzMBQfImZsETCAnZN
	 Xg4DxeJsRB4Ypv9DIjd+W4UKPPOdusHybZtoQ2/8w2LS7Pu4WHkwbjnRoUaa54rSV/
	 W9/PcCrDnNBHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3A2C60712;
	Tue, 29 Sep 2026 04:16:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61F60335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4763380C16
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vr7PTPyT-S2i for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 04:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6FD4380AC2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790655382;
 b=ZwzZigCkIml6TjIwJij8ovb/R0YsbrLd9lcHGbtptwWxYk5FsZ0ma5+znUI7D92vHpOq
 lSxEk/pQJFx31HAqG3BrreycSu5+NHwJOInOQofrUz8ad3P8YWgBeMF1fuh8/LOeuzuwm
 29JYEjXO4019+nbt67zngacGPGX6JcaiTaoG/3GZsymmnqwg1aGQaAc1hbWJW8N0Zmhu2
 nCCnOT6IyTmYCBcLFP5npkK9wPPYVCfJuqLQdXkpw15X0yIzioq/njnIvUmwpiHIDSWcU
 ESndJ7citZ3SEk51en7QQTHUdr0JuSIbYJ+S2GF3AEHslvatANEaHp6eBX50yvRwPJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790655382;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=+1zgOqOCUMWhQrK9gkpUJGBo/fsIMDcyKRjsAnZ/jA8=;
 b=XNhqOMOXEYgBHjWTIKKBCQWQY/QBw7hiqjVLNYGeROlk0+1Y3fDouLVOZb0+HSLyYehe
 wKj3PSgto2CMHucdOOg5PXQmjEEVzDeDD6E2K/GKKtVu4EDjt/fua+u9AaUM7/5+hWehc
 fbFcF3Cehzh7rlt39tdjX5yPsLuQDCMGeyucZCMi1JCWbrM1OHrUctuRTneRpcRxv6EV3
 Di8i1pywZNt4LpJAr3NSO0npP/UwCFzJmiqSOKdK1hR8N+Yxuqvy1caMbvfkUroMLKEsq
 eSzbvBwVlMPU1x8FqWppt2INND4/k1HSsGzosEJs5QK8MbnAQaJvq7SDGBRRAyEyNVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=wrCICBYL; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=wrCICBYL
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FD4380AC2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 04:16:20 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hv4cJ1Pd3zKnQs;
 Tue, 29 Sep 2026 06:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790655376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1zgOqOCUMWhQrK9gkpUJGBo/fsIMDcyKRjsAnZ/jA8=;
 b=wrCICBYL41XTRqDvwkBg6CmtSYILLkxmVxgcZ9jFkwKCMh5RwpftNKczi2Sq8LGPOJ5C/J
 GLw06P2ZOnfHBcw+/k7g+ESu8rPaVr1r5W/qZO1BLafV/p7vfXFaqkgrdSqMdHqaKPIGlg
 l6E8CHzjiFrs8E9Muc0iMmytIoCI2il6+2LffRDvtvjXyBn5Pu6rMmU05IPSUH3jPWHcMQ
 hs/0fows+DsGbSeved5eJVyhtc3yj0MvLQuTMmu0HV05mGepHgDsvcXPsgHUuEUuOAAgA7
 xGD/oUhD4L1Dqi5kxit2o0TZwEKANhTMn20YCJhH8i7fXCblEVDdX0MhANM7yQ==
Message-ID: <86fd7ffb-b703-4b7b-b093-c4152540c34c@mailbox.org>
Date: Mon, 28 Sep 2026 23:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Tom Rini <trini@konsulko.com>
Cc: Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mark Kettenis <kettenis@openbsd.org>
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
 <20260928192542.GA4035470@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928192542.GA4035470@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h11hx4wr79uswyyqcjo5ncswegngyizb
X-MBO-RS-ID: 936baad5c2a7ca6ba76
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

On 9/28/26 9:25 PM, Tom Rini wrote:
> On Fri, Sep 11, 2026 at 10:59:23PM +0200, Marek Vasut wrote:
>> On 9/11/26 10:32 PM, Romain Beauxis wrote:
>>> Neither bootm nor EFI ExitBootServices() stops USB controllers
>>> explicitly. Both only remove devices whose driver sets
>>> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
>>> controller brought up by "usb start", e.g. from preboot for a USB
>>> keyboard, is handed to the OS still running.
>>>
>>> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
>>> is the path "usb stop" already takes: the xHCI is reset, its PHYs are
>>> shut down and its clocks and resets are released. Child devices such as
>>> hubs, storage and keyboards are removed first, and a controller already
>>> stopped by "usb stop" is skipped. xhci-pci has done the same since
>>> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
>>> have ohci-da8xx and the cdns3 wrappers.
>>>
>>> On Apple silicon machines the running controller is user visible: Linux
>>> does not enumerate a USB device attached to a Type-C port at boot until
>>> it is unplugged and plugged back in.
>> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is that
>> not sufficient to tear the controllers down before booting Linux ?
> 
> Jumping back up to this part of the thread. I believe the answer is that
> it is only enough once we set DM_FLAG_OS_PREPARE so that we know to find
> and tear this down. Without digging through all of the discussions of
> the other places we've used this flag to fix a problem like this over
> the years, I believe it's a feature not a bug of how we do things that
> we need this flag.
I am not convinced this is the right fix, but I asked Mark to dig into 
this, since I don't have any apple silicon hardware. Maybe they can help 
here.
