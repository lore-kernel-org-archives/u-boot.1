Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77714C88E56
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 03:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F165480E8C;
	Sun, 13 Sep 2026 03:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YdFeJDk-eifA; Sun, 13 Sep 2026 03:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EED0980E35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789268673;
	b=VrC4QIA/gyUUltqVNlWzBICUY4Im94KKmOp3g2TKeTQOHMLwDLnXaIAzE0sBw2YRTZGy
	 lrvx/C1DWj7UK++c/SGJnsO8f1QbP+nKdGuzmvMgsr+C/I3acW4TMQy8DGE1dRTfJEQWF
	 f09jPPWBe6W6VX8Bbbq2SQwLMKGTcD+Z8ed3pXck7jDHzleEQWZtib94KYCw7p8usXrf3
	 qn+diNQfhoj0nTiN/ypeRvm4d69e1mbw7wGLBMj9O5PLrJhO8r/glYPMVvEceZP/g+jvK
	 pl9RrTfuSN53BuE+sVRzqbY/sDCb18rEb8ygIU/8NaPngiCkN/CHDxYki+0WtkwoXZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789268673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yfJXsQgx79MeYMQldM+joSh8Zf+DOjh/a7nb05hD+Jk=;
	b=PorL805R50NCxXFOBkXj/OXij9klt1TULViUpxk1DJZOos3ihBvCtIp7vyqq8ME8+WE6
	 ScbnbcCZYRwqKUrG0Hy28xjDnoFjBg3qmjp/XXSe+WnwOTIRsjywPI6HmWguBK9o0qnBh
	 251xFr5ruwJ8PDGFUXRjBzpq6DelVys5dH0Gsj7mgDKzTOq6JFtekn53Irx91DPS0F39i
	 F0cRWxuRgoT2Ug/eGqwIRomsf+lZcPQk4CLetAJJB/UcEh8Ptcoff4MMM1Anw6Q0L5gPp
	 4dtnTmMIlzgCdjhdkMwt5JB3wjaM4krvENx44j9QXXktt109qtjkehpu7vT0iiMc3FA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=I5RFCjJb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789268673;
	bh=yfJXsQgx79MeYMQldM+joSh8Zf+DOjh/a7nb05hD+Jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JYguUlbQALkS4iilHA1GCo+DsfT8427X3TVE1M0vG1V5QphuP9Xhs2BewhhLXuA/3
	 x4DZJ3AZfFkFz9IFWqL4ldaJTgNgcOMPwTR9x7+QLryqtg7pFVeDNxyWwrNim6Oz2O
	 Q9Kk/1MwIlPhTEGWq67TOlP1lVAv0288AerT5J1AHLQcZtassRieuDWdV8uz6keC91
	 HAg9Q0fkygaRAofbya+6xPmdKt4TyMVVyXiC8+tdMR4GZWMPJ4dEvN36P6f6LZ/9Ee
	 8gsEdGr/sPlNmkEErD9HyFv8cQsLJp8/8jsWjcLRVpb4oHRt4xuQbicoGFyTJ4wXMW
	 9DXrqgdep87ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EED0980E35;
	Sun, 13 Sep 2026 03:04:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 516AB32F
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4219380E35
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0zcaLmhBZs2 for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 03:04:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 557C280E30
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789268669;
 b=laXt8EFrVL/LyfeYqm/DPPdjpLzsvOIza5v+Aquk5M7xSEEW+IgoR3WLA2hNNlFrSq88
 foh764mqI5sCorN9GDhLQKzmPGUMnx5eSnoqcH2b9ojSBX5rCc/VeZEff/BPsa4Wq3rwj
 deu8N07TDocn/Dm4P9dwVHohA8K7YcdBstM4O/nV4qxXo7JNX6+9ATn+gbwDjsp7d1lN8
 w2MZAZEQTwmbPHwdpT0EnLi6zRnI0KiByCHFmNSsiR414C/ClVch+KpCqfxp6Byb8G1tA
 mkUos9mUzT9lrEibdZS8uWtq151blgo9JVNTTn8iYxUsRCWELyEa7bycnJQA4sqaF+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789268669;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=yfJXsQgx79MeYMQldM+joSh8Zf+DOjh/a7nb05hD+Jk=;
 b=rdACbkcGXaH/Khbcr+d0CjMZMFG16d4rnYWjQ2O/2up+yOCqO19DVDm7mqUlRDgnlP2n
 zZrH9BK/iqQnvj9KMwYk9wRGrYQXT94te6SoJ2caImSS187TscRkGwVDePWoMF5ntXUEJ
 +az48Qorg9gBAY8T0UZLXKhg4vKuZvOBOYvwzP/qkZvCjNopEtk4gn6KhuLQtyMkpeI0E
 dKoXxg+08ddypLZbK2mc07gnYorcAQaJzBjjAVBKHnCjgFUUF8Q/X5mQT7yrPS0tadIYG
 +ojw6koS6V5tJAkyFvaGoV+wp+CxZUJk1F1PmcCfeDLRuot2emxX/+/ktQDqmTnDFWw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=I5RFCjJb; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=I5RFCjJb
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 557C280E30
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 03:04:27 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hjCmm40TQzMlFR;
 Sun, 13 Sep 2026 05:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789268664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfJXsQgx79MeYMQldM+joSh8Zf+DOjh/a7nb05hD+Jk=;
 b=I5RFCjJbwbmoZXrNTOAuzBchHXv3sLTd1l7LYpdaO6ITn90CBlXhbe6giBFZ9pkI86avLu
 1+EFbQ3q6QACY/rXgtKKQwDnJDBU28ImjaZd+I/C/eGE6SC8NTYLs/5XlJNgNG7LvzGI8Z
 VeTOH5UP8zk+wZRkTc8KzooXEUFm3DgTOV8Tftr15wSoBS6bYZCo38cN2r+ZiHvFhUOS7X
 TxIRBkixcN7ATb6V7VGdWCF1iog9GhRFnarcu+96bqCgw3IobG5jmMTdE/9z2NkBbVwabn
 7PqLYav5VBscH4Ub38SZ8+TXNMelfW/v3vjuPHJ3CMVwGOQVrOQLOcSXZSz2XA==
Message-ID: <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
Date: Fri, 11 Sep 2026 22:59:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260911203229.25414-1-romain.beauxis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 901a39c2758ee37bec4
X-MBO-RS-META: g7h4zrdo37tko1itw3s5t9x9jc9e5f5j
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

On 9/11/26 10:32 PM, Romain Beauxis wrote:
> Neither bootm nor EFI ExitBootServices() stops USB controllers
> explicitly. Both only remove devices whose driver sets
> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
> controller brought up by "usb start", e.g. from preboot for a USB
> keyboard, is handed to the OS still running.
> 
> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
> is the path "usb stop" already takes: the xHCI is reset, its PHYs are
> shut down and its clocks and resets are released. Child devices such as
> hubs, storage and keyboards are removed first, and a controller already
> stopped by "usb stop" is skipped. xhci-pci has done the same since
> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
> have ohci-da8xx and the cdns3 wrappers.
> 
> On Apple silicon machines the running controller is user visible: Linux
> does not enumerate a USB device attached to a Type-C port at boot until
> it is unplugged and plugged back in.
boot/bootm.c bootm_final() does call dm_remove_devices_active() , is 
that not sufficient to tear the controllers down before booting Linux ?
